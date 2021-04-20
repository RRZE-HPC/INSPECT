#!/usr/bin/env python3
import argparse
import os
import math
import itertools
from pathlib import Path
import fcntl
import sys
import socket
import io
import contextlib
import shutil
import traceback
from distutils.spawn import find_executable
import gc
import subprocess
from collections import OrderedDict
from copy import copy
from textwrap import dedent
import json
from tempfile import NamedTemporaryFile
import atexit
import multiprocessing
from glob import glob
from functools import lru_cache

import compress_pickle as compress_pickle
import pandas
from nbconvert import HTMLExporter
from nbconvert.preprocessors import ExecutePreprocessor
from nbconvert.nbconvertapp import NbConvertApp
import nbformat
from ruamel import yaml
from kerncraft import prefixedunit
from kerncraft import kerncraft
from stempel import stempel
import jinja2

from hpc_inspect import utils

__version__ = '2.0.dev0'
config = {
    'config_abspath': (Path(__file__)).resolve(),  # to be set at runtime

    # All paths are either absolute or relative in regard to config_abspath's parent directory.
    'jobs_dir': '../jobs',
    'hosts_file': 'hosts.yml',
    'machinefiles_dir': '../machine_files',
    'kernels_file': 'kernels.yml',
    'namedkernels_dir': '../kernels',
    'webroot_dir': '../webroot',

    # Notebooks to use for workloads, selected by kernel type:
    'report_templates': {
        # kerneltype: ipython-notebook.ipynb
        'likwid-bench': 'report-likwid-bench.ipynb',
        'named': 'report-named-stempel.ipynb',
        'stempel': 'report-named-stempel.ipynb'
    }
}


def parse_configpath(path_str):
    '''
    Translates string paths as found in config file, into resolved absolute path in relation.

    Relative paths are taken relative in relation to config file's location.
    '''
    if config['config_abspath'] is not None:
        return (Path(config['config_abspath']).parent / path_str).resolve()
    else:
        return Path(path_str).resolve()


# TODO:
# * remove failed job dirs
# * Workload processing / report generation
# * Extract suggested scaling upperbound from LC output
# * Job submission
# * Job enqueuing
# * Report upload

class Kernel:
    """Describes a kernel including sizes to model and execute for."""
    @classmethod
    def get_all(cls, filter_type, filter_parameter):
        with parse_configpath(config['kernels_file']).open() as f:
            kernel_dicts = yaml.load(f, Loader=yaml.Loader)
        for kd in kernel_dicts:
            if filter_type is not None and kd['type'] not in filter_type:
                continue
            if filter_parameter is not None and kd['parameter'] not in filter_parameter:
                continue
            yield cls(**kd)

    def __init__(self, type, parameter, scaling=None, steps=None):
        self.type = type
        self.parameter = parameter
        self.scaling = scaling
        self.steps = steps
        if scaling and steps is None:
            self.steps = generate_steps(**scaling)
        else:
            self.steps = []

    def get_code(self):
        if self.type == "named":
            with (parse_configpath(config['namedkernels_dir']) / self.parameter).open() as f:
                code = f.read()
        elif self.type == "stempel":
            parser = stempel.create_parser()
            # 2D/r1/star/constant/isotropic/float
            dimensions, radius, kind, coefficient, classification, datatype = \
                self.parameter.split('/')
            dimensions = dimensions.strip('D')
            radius = radius.strip('r')
            args= parser.parse_args(["gen",
                                     "-D", dimensions,
                                     "-r", radius,
                                     "-C", coefficient,
                                     "-k", kind,
                                     "-c", classification,
                                     "-t", datatype])
            codeio = io.StringIO()
            args.store = codeio
            output = io.StringIO()
            stempel.run_gen(args, parser, output_file=output)
            code = codeio.getvalue()
            codeio.close()
        elif self.type == "likwid-bench":
            code = None
        else:
            raise ValueError("Unsupported kernel type: {}".format(self.type))
        return code

    def save_to(self, path):
        """Save kernel code to path."""
        if self.type == "likwid-bench":
            return
        else:
            with path.open('w') as f:
                f.write(self.get_code())

    def __repr__(self):
        steps = self.steps
        if self.scaling:
            steps = self.scaling
        return "<Kernel {!r} {!r} {!r}>".format(self.type, self.parameter, steps)

class Host:
    """Describes a host on which kernels may be executed and modelled."""
    @classmethod
    def get_all(cls, filter_names=None):
        with parse_configpath(config['hosts_file']).open() as f:
            hosts_dict = yaml.load(f, Loader=yaml.Loader)
        for name, hd in hosts_dict.items():
            if filter_names is not None and name not in filter_names:
                continue
            try:
                yield cls(name=name, **hd)
            except TypeError:
                traceback.print_exc()

    def __init__(self, name, nodelist=[], submission_host=None, slurm_arguments='',
                 runtime_setup=[], machine_filename=None, ignore_kerncraft_warnings=False):
        self.name = name
        self.nodelist = nodelist
        self.submission_host = submission_host
        self.slurm_arguments = slurm_arguments
        self.runtime_setup = runtime_setup
        self.machine_filename = machine_filename
        # Load contents of machine file into machine_file
        if machine_filename is not None:
            with self.get_machine_filepath().open() as f:
                self.machine_file = yaml.load(f, Loader=yaml.Loader)
        self.ignore_kerncraft_warnings = ignore_kerncraft_warnings

    def get_machine_filepath(self):
        return parse_configpath(config['machinefiles_dir']) / self.machine_filename

    def enqueue_execution(self, cli_args):
        print("TODO enqueue on", self.name, ':', ' '.join(cli_args))
        # TODO eunqueue
        # * build job file string
        # * pass to slurm

    def get_queued_executions(self):
        """Return list of queued cli_args and status"""
        raise NotImplementedError

    def get_compilers(self, skip_unavailable=False):
        """Return list of compilers from host description."""
        for c in self.machine_file['compiler'].keys():
            if not skip_unavailable or find_executable(c):
                yield c

    def is_current_host(self):
        """Return True if executing host is mentioned in nodelist"""
        return socket.gethostname().split('.')[0] in self.nodelist
    
    def get_slurm_jobscript(self, base_cmd, cwd=None):
        runtime_setup = '\n'.join(self.runtime_setup)
        if cwd:
            runtime_setup += '\ncd ' + cwd
        jobscript = dedent('''
            #!/bin/bash
            #SBATCH -J INSPECT-{host}
            #SBATCH {slurm_arguments}
            #SBATCH -w {node}
            #SBATCH --time=24:00:00
            # Runtime Setup:
            {runtime_setup}
            module load slurm
            echo base_cmd={base_cmd}
            if ! likwid_bench_auto --compare-host -m {machine_filename} -; then
                exit 1;
            fi
            STATUS=`{base_cmd} status`;
            # If there is work left (as job may terminate before completion), terminate.
            if (echo "{base_cmd}" | grep -q -- '--rerun-failed' && echo "$STATUS" | grep -E '(new|failed)' | grep -vEq '(new|failed)\s+0') || echo "$STATUS" | grep new |grep -vEq 'new\s+0'; then
                # Reschedule
                echo rescheduling due to status output:
                echo $STATUS
                {base_cmd} enqueue --same-host
            fi
            # Execution:
            {base_cmd} execute
        ''').strip().format(
            slurm_arguments=self.slurm_arguments,
            base_cmd=base_cmd,
            runtime_setup=runtime_setup,
            node=','.join(self.nodelist),
            host=self.name,
            machine_filename=str(self.get_machine_filepath()))
        tf = NamedTemporaryFile(mode='w+', delete=False)
        tf.write(jobscript)
        tf.close()
        atexit.register(os.remove, tf.name)
        return tf.name


class Workload:
    """
    Describes the complete modelling, measurement and reporting of a single kernel on a single host.
    """
    @classmethod
    def get_all(cls, kernels, hosts):
        return [cls(k, h) for k, h in itertools.product(kernels, hosts)]

    def __init__(self, kernel, host):
        self.kernel = kernel
        self.host = host
        self._wldir = parse_configpath(config['jobs_dir']).joinpath(
                self.host.name, self.kernel.type, self.kernel.parameter)

    def get_wldir(self):
        """Return path to workload directory"""
        return self._wldir

    def initialize_wldir(self):
        """Initialize and return path to workload directory"""
        wldir = self.get_wldir()
        if not wldir.exists():
            wldir.mkdir(parents=True)

        # TODO make this into the job's responsibility?
        if self.kernel.type in ['stempel', 'named']:
            # Save kernel file
            kernel_filename = wldir.joinpath('kernel.c')
            if not kernel_filename.exists():
                self.kernel.save_to(kernel_filename)

            # Copy machine file if it does not exist or is older
            machine_filename = wldir.joinpath('machine.yml')
            if not machine_filename.exists() or machine_filename.lstat().st_mtime < \
                    self.host.get_machine_filepath().lstat().st_mtime:
                shutil.copy(str(self.host.get_machine_filepath()), str(machine_filename))
        return wldir

    def get_jobs(self, compiler=None, steps=None, incore_model=None, cores=None):
        if hasattr(self, '_jobs'):
            return self._jobs

        jobs = [MachineStateJob(self, exec_on_host=True)]
        if self.kernel.type in ['stempel', 'named']:
            # Layer Conditions
            jobs += [KerncraftJob(self, pmodel='LC', define=100, exec_on_host=False)]
            do_steps = [s for s in self.kernel.steps
                        if steps is None or s in steps]
            do_compilers = [cc for cc in self.host.get_compilers()
                            if compiler is None or cc in compiler]
            cores_per_socket = (self.host.machine_file['NUMA domains per socket']
                                * self.host.machine_file['cores per NUMA domain'])
            do_cores = [c for c in range(1, cores_per_socket + 1)
                        if cores is None or c in cores]
            do_incore_models = [icm for icm in self.host.machine_file['in-core model'].keys()
                                if incore_model is None or icm in incore_model]
            for s in do_steps:
                for cc in do_compilers:
                    # Benchmark
                    jobs.append(KerncraftJob(self, pmodel='Benchmark', define=s, cores=1, 
                                             compiler=cc, exec_on_host=True))
            for s in do_steps:
                for cc in do_compilers:
                    for icm in do_incore_models:
                        for cp in ['LC', 'SIM']:
                            # ECM
                            jobs.append(KerncraftJob(self, pmodel='ECM', define=s,
                                                 compiler=cc, incore_model=icm,
                                                 cache_predictor=cp, exec_on_host=False))
                            # RooflineIACA
                            jobs.append(KerncraftJob(self, pmodel='RooflineIACA', define=s,
                                                 compiler=cc, incore_model=icm,
                                                 cache_predictor=cp, exec_on_host=False))
            
            # core scaling
            if self.kernel.steps and max(self.kernel.steps) in do_steps:
                s = max(self.kernel.steps)
                for c in do_cores:
                    for cc in do_compilers:
                        jobs.append(KerncraftJob(self, pmodel='Benchmark', define=s, cores=c, 
                                                 compiler=cc, exec_on_host=True))
                        for icm in do_incore_models:
                            for cp in ['LC', 'SIM']:
                                # ECM
                                jobs.append(KerncraftJob(self, pmodel='ECM', define=s,
                                                         compiler=cc, incore_model=icm,
                                                         cache_predictor=cp, exec_on_host=False,
                                                         cores=c))
                                # RooflineIACA
                                jobs.append(KerncraftJob(self, pmodel='RooflineIACA', define=s,
                                                         compiler=cc, incore_model=icm,
                                                         cache_predictor=cp, exec_on_host=False,
                                                         cores=c))
        elif self.kernel.type == "likwid-bench":
            base_args = ['likwid-bench', '-t', self.kernel.parameter]
            cores_per_socket = (self.host.machine_file['NUMA domains per socket']
                                * self.host.machine_file['cores per NUMA domain'])
            do_cores = [c for c in range(1, cores_per_socket + 1)
                        if cores is None or c in cores]
            threads_per_core = self.host.machine_file['threads per core']
            for s in self.kernel.steps:
                for c in do_cores:
                    jobs.append(Job(self, base_args + ['-w', 'S0:{}B:{}:1:{}'.format(
                                                       s, c, threads_per_core)],
                                    exec_on_host=True))
        else:
            raise NotImplementedError("Unknown kernel type")
        self._jobs = jobs
        return jobs
    
    def has_report(self):
        """Check if report exists."""
        return (self.get_wldir() / 'report.html').exists()

    def process_outputs(self, overwrite=False):
        """Gather and process outputs into a single report."""
        if not self.get_wldir().exists() or \
                not (self.get_wldir() / 'machinestate.json').exists():
            return
        if self.kernel.type in ['stempel', 'named'] and (\
                not (self.get_wldir() / 'machine.yml').exists() or \
                not (self.get_wldir() / 'kernel.c').exists()):
            return

        # 1. gather output of finished jobs
        df_pickle_filename = self.get_wldir() / 'dataframe.pickle.lzma'
        if not df_pickle_filename.exists() or overwrite:
            outputs = []
            for j in self.get_jobs():
                if j.get_state() != 'finished':
                    # Skipping unfinished jobs
                    continue
                d = j.get_dicts()
                if d:
                    outputs += d
            df = pandas.DataFrame(outputs)
            df_pickle_file = self.get_wldir() / 'dataframe.pickle.lzma'
            compress_pickle.dump(df, df_pickle_filename)
            print(df_pickle_filename, 'written')
        else:
            print(df_pickle_filename, 'already exists')

        # 2. Run template in workload dir and save to report notebook
        report_filename = self.get_wldir() / 'report.ipynb'
        html_report_filename = report_filename.with_suffix('.html')
        if not report_filename.exists() or not html_report_filename.exists() or overwrite:
            template_filename = parse_configpath(config['report_templates'][self.kernel.type])
            with template_filename.open() as f:
                nb = nbformat.read(f, as_version=nbformat.NO_CONVERT)
            # Execute cells in notebook
            try:
                pp = ExecutePreprocessor(timeout=500)
                pp.preprocess(nb, {'metadata': {'path': str(self.get_wldir())}})
                with open(report_filename, 'w') as f:
                    nbformat.write(nb, f)
                print(report_filename, 'written')
            except Exception as e:
                print(report_filename, 'execution failed: '+str(e))
                return  # abort
        else:
            print(report_filename, 'already exists')
        # 3. Render to static HTML file
        if not html_report_filename.exists() or overwrite:
            resources = {}
            if hasattr(NbConvertApp, 'jupyter_widgets_base_url'):
                resources['jupyter_widgets_base_url'] = NbConvertApp().jupyter_widgets_base_url
            elif hasattr(NbConvertApp, 'ipywidgets_base_url'):
                resources['ipywidgets_base_url'] = NbConvertApp().ipywidgets_base_url
            html_exporter = HTMLExporter()
            (body, resources) = html_exporter.from_notebook_node(nb, resources=resources)
            with open(html_report_filename, 'w') as f:
                f.write(body)
            print(html_report_filename, 'written')
        else:
            print(html_report_filename, 'already exists')

    # TODO jobs status tracking functionality
    # TODO report generation function


class Job:
    """
    A single job to be executed on a host by a single Kerncraft run.

    Can be used to execute a new or unfished job or to collect resulting data
    and detect state (i.e., new, executing, finished or failed).
    """
    def __init__(self, workload, arguments, exec_on_host):
        """
        Construct Job object.

        :param kernel: kernel to analyze
        :param host: host this job is running for
        :param arguments: list of arguments to execute and to identify job
        :param exec_on_host: if True, execute this job only on specified host, otherwise use any
        """
        self.workload = workload
        self.arguments = arguments
        self.exec_on_host = exec_on_host

        self._have_lock = False
        self._jobdir = self.workload.get_wldir() / ' '.join(self.arguments).replace('/', '$')
        self._lockfile_path = self._jobdir.with_name(self._jobdir.name+'.lock')
        self._lock_fd = None

        self._state = None

    def __repr__(self):
        return "<Job {} {!r} {} {}>".format(
            self.workload.host.name, self.workload.kernel, self.arguments, self.exec_on_host)

    def check_hostname(self):
        return socket.gethostname().split('.')[0] in self.workload.host.nodelist

    def _aquire_lock(self, non_blocking=False):
        """Lock job directory"""
        if self._have_lock:
            return True
        self.get_jobdir().mkdir(parents=True, exist_ok=True)
        self._lock_fd = self._lockfile_path.open('w')
        operation = fcntl.LOCK_EX
        if non_blocking:
            operation |= fcntl.LOCK_NB
        try:
            fcntl.flock(self._lock_fd, operation)
        except IOError:
            return False
        self._have_lock = True
        return True

    def is_locked(self):
        # May be locked, but good enough
        return self._lockfile_path.exists()

    def _release_lock(self):
        if not self._have_lock:
            return
        fcntl.flock(self._lock_fd, fcntl.LOCK_UN)
        try:
            self._lockfile_path.unlink()
        except FileNotFoundError:
            # Missing lockfile is okay
            pass
        self._lock_fd.close()
        self._lock_fd = None

    def get_jobdir(self):
        """Return job directory path."""
        return self._jobdir

    def _run(self):
        """Work to be executed"""
        try:
            with chdir(str(self.get_jobdir())):
                with open('out.txt', 'w') as f:
                    subprocess.run(self.arguments, check=True,
                        stdout=f, stderr=subprocess.STDOUT)
        except KeyboardInterrupt:
            raise
        except:
            traceback.print_exc(file=sys.stderr)
            raise

    def execute(self, non_blocking=False, rerun_failed=False):
        """Change state from new or enqueud to executing."""
        self.get_state()  # Necessary to ensure self._state is updated
        if self._state == 'finished':
            return
        elif self._state == 'failed' and not rerun_failed:
            return
        assert not self.exec_on_host or self.check_hostname(), \
            "Needs to run on specified host: "+repr(self.workload.host)
        self._aquire_lock(non_blocking=non_blocking)
        if self._state == 'failed':
            shutil.rmtree(str(self.get_jobdir()))
            self.get_jobdir().mkdir()
        self._state = "executing"

        # Execute work
        failed = True
        try:
            failed = self._run()
        except KeyboardInterrupt:
            failed = True
            # Rollback by removing jobdir
            shutil.rmtree(str(self.get_jobdir()))
            print("Manual abort. Cleared currently running job data.")
            sys.exit(1)
        except:  # Also catching SystemExit, which inherits from BaseException
            failed = True
            traceback.print_exc(file=sys.stderr)
            print("Job run failed.", file=sys.stderr)
        finally:
            if not failed:
                self._state = "finished"
                try:
                    with self.get_jobdir().joinpath('FINISHED').open('w') as f:
                        f.write(self._state)
                except IOError as e:
                    print("Could not write FINISHED file:", e, file=sys.stderr)
            else:
                self._state = "failed"
                # Nothing needs to be stored
                # directory exists && no lock && no FINISHED file in combination mean failed
            self._release_lock()
        gc.collect()

    def get_state(self, update=False):
        """Indicate if this job is new, executing, finished or failed."""
        if self._state is None:
            update = True
        if update:
            self._state = "new"
            if self.get_jobdir().is_dir():
                if self.is_locked():
                    self._state = "executing"
                else:
                    if self.get_jobdir().joinpath('FINISHED').exists():
                        self._state = 'finished'
                    else:
                        self._state = 'failed'
        return self._state

    def get_outputs(self):
        """Return tuple of output (combined stdin and stderr) of run"""
        assert self.get_state() == 'finished', "Can only be run on sucessfully finished jobs."
        raw_file = self.get_jobdir().joinpath('out.txt')
        if not raw_file.exists():
            raw_output = None
        else:
            raw_output = raw_file.read_text()
        return (raw_output,)
    
    def get_dicts(self):
        """Return dicts to be inserted into Workload's DataFrame"""
        return [OrderedDict([
            ('job', self),
            ('raw output', self.get_outputs()[0])])]


class KerncraftJob(Job):
    """
    kerncraft Job
    arguments are a list of cli arguments to pass to kerncraft (including machine file and leading
    kerncraft)
    """
    def __init__(self, workload, pmodel, define, cores=None, compiler=None, incore_model=None,
                 cache_predictor=None, exec_on_host=True):
        """
        Construct Job object.

        :param kernel: kernel to analyze
        :param host: host this job is running for
        :param arguments: list of arguments to execute and to identify job
        :param exec_on_host: if True, execute this job only on specified host, otherwise use any
        """
        self.pmodel = pmodel
        self.define = define
        self.cores = cores
        self.compiler = compiler
        self.incore_model = incore_model
        self.cache_predictor = cache_predictor
        arguments = ['kerncraft', '-p', pmodel, '-D', '.', str(define)]
        if workload.host.ignore_kerncraft_warnings:
            arguments.append('--ignore-warnings')
        if cores is not None:
            arguments += ['-c', str(cores)]
        if compiler is not None:
            arguments += ['-C', compiler]
        if incore_model is not None:
            arguments += ['-i', incore_model]
        if cache_predictor is not None:
            arguments += ['-P', cache_predictor]
        arguments += ['-m', 'machine.yml', 'kernel.c', '-vvv']
        Job.__init__(self, workload, arguments, exec_on_host)
    
    def _get_kerncraft_argparser(self):
        parser = kerncraft.create_parser()
        with chdir(str(self.workload.initialize_wldir())):
            args = parser.parse_args(self.arguments[1:])  # ignore first, is always 'kerncraft'
            kerncraft.check_arguments(args, parser)
        return parser, args

    def _run(self):
        parser, args = self._get_kerncraft_argparser()
        with chdir(str(self.workload.initialize_wldir())):
            with self.get_jobdir().joinpath('out.txt').open('w') as f:
                with utils.stdout_redirected(f, stdout=sys.stderr):
                    with utils.stdout_redirected(f):
                        try:
                            result_storage = kerncraft.run(parser, args)
                        except KeyboardInterrupt:
                            raise
                        except:
                            print(self.get_jobdir())
                            traceback.print_exc(file=sys.stderr)
                            raise
                        finally:
                            del parser
                            del args
            compress_pickle.dump(result_storage, self.get_jobdir() / 'out.pickle.lzma',
                                 pickler_kwargs={'protocol': 4})
            del result_storage

    def get_outputs(self):
        """Return tuple of execution output (combined stdin and stderr) and loaded pickle"""
        return Job.get_outputs(self) + (
                compress_pickle.load(self.get_jobdir() / 'out.pickle.lzma'),
            )
    
    def get_dicts(self):
        """Return dicts to be inserted into Workload dataframe"""
        base_dict = Job.get_dicts(self)[0]
        base_dict['pmodel'] = self.pmodel
        base_dict['define'] = int(self.define)
        base_dict['cores'] = self.cores or 1
        base_dict['compiler'] = self.compiler
        base_dict['incore_model'] = self.incore_model
        base_dict['cache_predictor'] = self.cache_predictor
        kc_args, kc_results = next(iter(self.get_outputs()[-1].items()))
        base_dict['kc_results'] = kc_results
        dicts = []
        if self.pmodel == 'LC':
            del base_dict['define']
            # LC conditions (e.g. 'L1 LCs': [...])
            for i, lc_info in enumerate(kc_results['cache'], start=1):
                cache_level = 'L{}'.format(i)
                base_dict[cache_level+' LCs'] = lc_info
            dicts.append(base_dict)
        elif self.pmodel == 'ECM':
            # extracts (keys):
            # T_comp
            # T_RegL1
            # T_L1L2
            # T_L2L3
            # T_L3Mem
            # T unit, e.g. 'cy/8 It'
            # iterations per cacheline
            # memory bandwidth [GB/s]
            # preformance [It/s]
            # performance [cy/CL]
            # performance [cy/It]
            # performance [FLOP/s]
            # in-core model output
            # 
            # TODO get code balance (B_ [B/It]) for inter-cache transfers
            base_dict['iterations per cacheline'] = int(kc_results['iterations per cacheline'])
            base_dict['T unit'] = 'cy/{} It'.format(kc_results['iterations per cacheline'])
            for ecm_name, ecm_rectp in zip(
                    utils.flatten_tuple(kc_results['ECM Model Construction']),
                    utils.flatten_tuple(kc_results['ECM'])):
                base_dict[ecm_name] = ecm_rectp
            base_dict['memory bandwidth [GB/s]'] = float(kc_results['memory bandwidth'])/1e9
            base_dict['B unit'] = 'B/{} It'.format(kc_results['iterations per cacheline'])
            base_dict['in-core model output'] = kc_results['in-core model output']
            for p in kc_results['scaling prediction']:
                d = copy(base_dict)
                d['cores'] = p['cores']
                for unit, value in p['performance'].items():
                    d['performance [{}]'.format(unit)] = float(value)
                # if(d['cores'] == 1 and d['job'].cores and d['job'].cores > 1):
                #     print(d['cores'], d['job'].cores, d['job'])
                #     print(kc_results['scaling prediction'])
                dicts.append(d)
        elif self.pmodel == 'RooflineIACA':
            # extracts:
            # performance [It/s]
            # performance [cy/CL]
            # performance [cy/It]
            # performance [FLOP/s]
            # in-core model output
            cpu_perf = kc_results['cpu bottleneck']['performance throughput']
            if kc_results['min performance']['It/s'] > cpu_perf['It/s']:
                performance = cpu_perf
            else:
                performance = \
                    kc_results['mem bottlenecks'][kc_results['bottleneck level']]['performance']
            for unit, value in performance.items():
                base_dict['performance [{}]'.format(unit)] = float(value)
            base_dict['in-core model output'] = \
                kc_results['cpu bottleneck']['in-core model output']
            dicts.append(base_dict)
        elif self.pmodel == 'Benchmark':
            # extracts:
            # iterations per cacheline
            # performance [cy/CL]
            # performance [FLOP/s]
            # performance [LUP/s]
            # performance [It/s]
            # data transfers
            # misses L<i>[CL/CL]
            # evicts L<i> [CL/CL]
            # 
            base_dict['iterations per cacheline'] = int(kc_results['Iterations per cacheline'])
            base_dict['performance [cy/CL]'] = float(
                kc_results['Runtime (per cacheline update) [cy/CL]'])
            base_dict['performance [cy/It]'] = \
                float(kc_results['Runtime (per cacheline update) [cy/CL]'] * \
                    kc_results['Iterations per cacheline'])
            base_dict['performance [FLOP/s]'] = float(kc_results['Performance [MFLOP/s]']*1e6)
            base_dict['performance [LUP/s]'] = float(kc_results['Performance [MLUP/s]']*1e6)
            base_dict['performance [It/s]'] = float(kc_results['Performance [MIt/s]']*1e6)
            if 'data transfers' in kc_results and kc_results['data transfers'] is not None:
                # data transfers are / phenoECM is only gathered with single core runs
                base_dict['data transfers'] = kc_results['data transfers']
                for level in kc_results['data transfers']:
                    base_dict['misses '+level+' [CL/CL]'] = \
                        float(kc_results['data transfers'][level]['misses'])
                    base_dict['evicts '+level+' [CL/CL]'] = \
                        float(kc_results['data transfers'][level]['evicts'])
            # TODO get code balance (B_ [B/It]) for inter-cache transfers
            dicts.append(base_dict)
            # TODO PhenoECM
        else:
            raise NotImplementedError("Unsupported performance model type {!r}".format(self.pmodel))
        for d in dicts:
            d.move_to_end('raw output')
        return dicts


class MachineStateJob(Job):
    """
    MachineState Job
    """
    def __init__(self, workload, exec_on_host=True):
        """
        Construct Job object.

        :param exec_on_host: if True, execute this job only on specified host, otherwise use any
        """
        arguments = ["machinestate", "-o", "../machinestate.json"]
        super(MachineStateJob, self).__init__(workload, arguments, exec_on_host)

    def get_outputs(self):
        """Return tuple of execution output (combined stdin and stderr) and loaded pickle"""
        with open(self.workload.get_wldir()/'machinestate.json') as f:
            return Job.get_outputs(self) + (json.load(self.get_wldir() / 'machinestate.json'),)
    
    def get_dicts(self):
        return None

class VersionAction(argparse.Action):
    """Reimplementation of the version action, because argparse's version outputs to stderr."""
    def __init__(self, option_strings, version, dest=argparse.SUPPRESS,
                 default=argparse.SUPPRESS,
                 help="show program's version number and exit"):
        super(VersionAction, self).__init__(
            option_strings=option_strings,
            dest=dest,
            default=default,
            nargs=0,
            help=help)
        self.version = version

    def __call__(self, parser, namespace, values, option_string=None):
        print(parser.prog, self.version)
        parser.exit()

def enqueue(type=None, parameter=None, machine=None, compiler=None, steps=None,
            incore_model=None, cores=None, same_host=False, verbose=0, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    if same_host:
        local_hostname = socket.gethostname().split('.')[0]
        hosts = [h for h in hosts if local_hostname in h.nodelist]
    base_cmd = 'inspector ' + ' '.join(sys.argv[1:sys.argv.index('enqueue')])
    cwd = os.getcwd()
    # enque one slurm_job for each host
    for h in hosts:
        jobscript_path = h.get_slurm_jobscript(base_cmd, cwd)
        if verbose:
            print("### Jobscript for {} ({}):".format(h.name, jobscript_path))
            with open(jobscript_path) as f:
                print(f.read())
        subprocess.check_output(['sbatch', jobscript_path])
    # TODO restart upon termination due to walltime constraint (as part of execute command)


def status(type=None, parameter=None, machine=None, compiler=None, steps=None,
           incore_model=None, cores=None, verbose=0, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    kernels = list(Kernel.get_all(filter_type=type, filter_parameter=parameter))
    workloads = []
    jobs = []
    workloads = list(Workload.get_all(kernels, hosts))
    # Build list of jobs by chaining workload job lists
    jobs = list(itertools.chain(*[w.get_jobs(
                compiler=compiler, steps=steps, incore_model=incore_model, cores=cores
            ) for w in workloads]))

    job_states = list([j.get_state() for j in jobs])

    i = 0
    for s, j in zip(job_states, jobs):
        i += 1
        if verbose >= 2:
            print(s, j.get_jobdir())
        elif verbose >= 1:
            print(s[0], end='')
            if i % 80 == 0:
                print()

    print("   State  Count Percent")
    for state in ['new', 'failed', 'finished']:
        count = job_states.count(state)
        part_of_total = 0
        if len(jobs):
            part_of_total = count/len(jobs)
        print("{:>8} {:>6} {:>7.1%}".format(state, count, part_of_total))
    print('Total:', len(jobs))


def execute(type=None, parameter=None, machine=None, compiler=None, steps=None,
            incore_model=None, cores=None, rerun_failed=False, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    kernels = list(Kernel.get_all(filter_type=type, filter_parameter=parameter))
    workloads = list(Workload.get_all(kernels, hosts))
    jobs = []
    # Build list of jobs by chaining workload job lists
    jobs = list(itertools.chain(*[w.get_jobs(
                compiler=compiler, steps=steps, incore_model=incore_model, cores=cores
            ) for w in workloads]))
    # Filter jobs which do not match current host but require this
    jobs = [j for j in jobs if not j.exec_on_host or j.check_hostname()]

    # Place jobs which require the current host at front
    jobs.sort(key=lambda j: j.exec_on_host, reverse=True)

    # Just FYI
    print(len(hosts), "hosts")
    print(len(kernels), "kernels")
    print(len(workloads), "workloads")
    print(len(jobs), "jobs")

    running_jobs = 0
    while jobs and jobs[0].exec_on_host:
        j = jobs.pop(0)
        jec = JobExecutionCaller(rerun_failed=rerun_failed)
        jec(j)
    with multiprocessing.Pool() as p:
        jec = JobExecutionCaller(rerun_failed=rerun_failed)
        p.map(jec, jobs)


class JobExecutionCaller:
    def __init__(self, *args, **kwargs):
        self.args = args
        self.kwargs = kwargs
    
    def __call__(self, job):
        print(job.get_state(), job.get_jobdir())
        job.execute(*self.args, **self.kwargs)


def process(type=None, parameter=None, machine=None, overwrite=False, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    kernels = list(Kernel.get_all(filter_type=type, filter_parameter=parameter))
    workloads = list(Workload.get_all(kernels, hosts))
    for wl in workloads:
        print(wl.get_wldir())
        wl.process_outputs(overwrite=overwrite)


def upload(type=None, parameter=None, machine=None, overwrite=False, reindex=False, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    kernels = list(Kernel.get_all(filter_type=type, filter_parameter=parameter))
    workloads = list(Workload.get_all(kernels, hosts))

    webroot = Path(config['webroot_dir'])
    # 1. create webroot directory
    webroot.mkdir(parents=True, exist_ok=True)
    updated_workloads = {}
    # 2. per workload
    for wl in workloads:
        if not wl.has_report():
            # nothing to do if report has not been generated by `process()`
            continue
        # 2.0 create webroot/workload/$host/$ktype/$kparam folder (wl-webroot)
        wl_web_dir = webroot / 'workload' / wl.host.name / wl.kernel.type / wl.kernel.parameter
        wl_web_dir.mkdir(parents=True, exist_ok=True)
        wldir = wl.get_wldir()

        # Skip?
        if (wl_web_dir / 'meta.json').exists() and not overwrite:
            continue

        #  2.1 copy files, incl. static html report to webroot
        for fn in [e for e in wldir.iterdir() if e.is_file()]:
            shutil.copy(fn, wl_web_dir/fn.name)
        # 2.2 add meta.json?
        metadata = {
            '{}/{}/{}'.format(wl.host.name, wl.kernel.type, wl.kernel.parameter): {
                'host_name': wl.host.name,
                'kernel_type': wl.kernel.type,
                'kernel_parameter': wl.kernel.parameter}}
        with (wl_web_dir / 'meta.json').open('w') as f:
            json.dump(metadata, f)
        updated_workloads.update(metadata)
    # 3. compile list of workloads
    if reindex or not (webroot / 'workload' / 'list.json').exists():
        # Build index anew  from meta.json files
        workloads_metadata = {}
        for wlm in webroot.glob('**/meta.json'):
            with wlm.open() as f:
                workloads_metadata.update(json.load(f))
    else:
        # Take already existing index for granted
        with (webroot / 'workload' / 'list.json').open('r') as f:
            workloads_metadata = json.load(f)
    # 3.1 append new workloads to webroot/workload/list.json
    workloads_metadata.update(updated_workloads)
    with (webroot / 'workload' / 'list.json').open('w') as f:
        json.dump(workloads_metadata, f)
    # TODO 4. per host
    for h in hosts:
        pass
        # 4.1 render host description pages to webroot/host/$hostname/index.hml
        # 4.2 append to webroot/host/list.json

    # 5. copy index to webroot/index.html
    if not (webroot / 'index.html').exists() or overwrite:
        shutil.copy(parse_configpath(config['index_file']), webroot / 'index.html')


def get_args(args=None):
    """Return parsed commandline arguments."""
    if hasattr(get_args, '_parsed_args'):
        return get_args._parsed_args

    parser = argparse.ArgumentParser(description='INSPECT Command Line Utility')
    parser.add_argument('--version', action=VersionAction, version='{}'.format(__version__))
    parser.add_argument('--verbose', '-v', action='count', default=0,
                        help='Increases verbosity level.')
    parser.add_argument('--config', type=argparse.FileType('r'), default='./config/config.yml',
                        help='Configuration file.')

    # Workload filter:
    parser.add_argument('--type', '-t', action='append',
                        help='Kernel type(s) to consider')
    parser.add_argument('--parameter', '-p', action='append',
                        help='Kernel parameter(s) to consider')
    parser.add_argument('--machine', '-m', action='append',
                        help='Machine name(s) to consider')

    # Jobs filter:
    parser.add_argument('--compiler', '-C', action='append',
                        help='Compiler(s) to consider')
    parser.add_argument('--steps', '-s', type=int, action='append',
                        help='Step(s) to consider')
    parser.add_argument('--incore-model', '-i', action='append',
                        help='In-core model(s) to consider')
    parser.add_argument('--cores', '-c', type=int, action='append',
                        help='Core count(s) to consider')
    parser.add_argument('--rerun-failed', action='store_true',
                        help='Delete incomplete output and rerun failed jobs.')

    subparsers = parser.add_subparsers(
        title='command', dest='command', description='action to take', help='Valid commands:')
    subparsers.required = True

    # enqueue: workload + jobs
    enqueue_parser = subparsers.add_parser('enqueue', help='Generate and enqueue jobs')
    enqueue_parser.set_defaults(action_function=enqueue)
    enqueue_parser.add_argument('--same-host', action='store_true',
                                help="Only enqueue on same host")
    # status: workload + jobs
    status_parser = subparsers.add_parser('status', help='Check status of jobs')
    status_parser.set_defaults(action_function=status)
    # execute: workload + jobs
    execute_parser = subparsers.add_parser(
        'execute', help='Execute suitable jobs and collect raw outputs')
    execute_parser.set_defaults(action_function=execute)
    # process: workload
    process_parser = subparsers.add_parser(
        'process', help='Process workload reports from raw job outputs')
    process_parser.set_defaults(action_function=process)
    process_parser.add_argument('--overwrite', action='store_true',
                                help='Overwrite already existing dataframes and reports.')
    # uload: workload
    upload_parser = subparsers.add_parser(
        'upload', help='Upload and combine workload reports into website')
    upload_parser.set_defaults(action_function=upload)
    upload_parser.add_argument('--overwrite', action='store_true',
                               help='Overwrite already existing workloads in web root.')
    process_parser.add_argument('--reindex', action='store_true',
                                help='Overwrite existing metadata list and build from scratch.')
    get_args._parsed_args = parser.parse_args(args=args)
    return get_args._parsed_args


def make_cli_args(ignore_list=['command', 'action_function'], **kwargs):
    """
    Turn Namespace into args list passable to get_args.

    Quite dumb, will only work with default naming scheme.
    """
    args = []
    for key, value in kwargs.items():
        if value is None: continue
        if key in ignore_list: continue
        argument = '--' + key.replace('_', '-')
        if type(value) is list:
            for item in value:
                args += [argument, str(item)]
        else:
            args += [argument, str(value)]
    return args


def generate_steps(
    first, last, steps=100, stepping='log', multiple_of=8, no_powers_of_two=True,
    extend=[]):
    """
    Generate a list of sizes, based on scaling dictionary description.

    :param first: first element in resuliting list
    :param last: last element in resulting list
    :param steps: total number of elements in resulting list
    :param stepping: use linear ('lin') or logarithmic ('log') stepping
    :param multiple_of: force all sizes to be a multiple of this
    :param no_powers_of_two: check for powers of two and avoid those
    :param extend: will use this list of sizes to include (will lead to more sizes)

    Length of returned list is not guaranteed.
    """
    results = [first]

    if stepping not in ['log', 'lin']:
        raise ValueError("Unknown stepping parameter. Use 'lin' or 'log'.")

    intermediate = first
    while len(results) < steps and intermediate < last:
        if stepping == 'log':
            stepwidth = (math.log10(last) - math.log10(intermediate))/(steps-len(results))
            intermediate = 10**(math.log10(intermediate) + stepwidth)
        else:
            stepwidth = (last - intermediate)/(steps-len(results))
            intermediate += stepwidth

        intermediate = round(intermediate)
        while True:
            if multiple_of is not None:
                if intermediate % multiple_of != 0:
                    # Increase to next multiple of
                    intermediate += multiple_of - intermediate % multiple_of
                    continue
            if no_powers_of_two:
                if intermediate != 0 and ((intermediate & (intermediate - 1)) == 0):
                    intermediate += 1
                    continue
            if results[-1] == intermediate:
                # Do not insert same element twice
                intermediate += 1
                continue

            results.append(intermediate)
            break
    if results[-1] < last:
        results.append(last)

    if extend:
        i = j = 0
        extend = sorted(extend)
        while i < len(results):
            while j < len(extend):
                d = extend[j] - results[i]
                if abs(d) < 0.05 * results[i]:
                    # Very close to new size: replace
                    results[i] = extend[j]
                    i += 1
                    j += 1
                    break
                elif d < 0:
                    # Less: insert before
                    results.insert(i, extend[j])
                    i += 1
                    j += 1
                    break
                else:  # d > 0
                    # Greater: go to next
                    i += 1
                    break
            else:
                break

    return results


@contextlib.contextmanager
def chdir(pathstr):
    old_cwd = os.getcwd()
    try:
        os.chdir(pathstr)
        yield
    finally:
        os.chdir(old_cwd)


def main():
    args = get_args()
    config.update(yaml.load(args.config, Loader=yaml.Loader))
    config['config_abspath'] = Path(args.config.name).resolve()
    args.action_function(**vars(args))


if __name__ == '__main__':
    main()