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

import compress_pickle as compress_pickle
import pandas
import papermill
from ruamel import yaml
from kerncraft import prefixedunit
from kerncraft import kerncraft
from stempel import stempel

from hpc_inspect import utils

__version__ = '2.0.dev0'
config = {
    'base_dirpath': Path('.')
}

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
        with config['base_dirpath'].joinpath('config', 'kernels.yml').open() as f:
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
            with config['base_dirpath'].joinpath('kernels', self.parameter).open() as f:
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
        with config['base_dirpath'].joinpath('config', 'hosts.yml').open() as f:
            hosts_dict = yaml.load(f, Loader=yaml.Loader)
        for name, hd in hosts_dict.items():
            if filter_names is not None and name not in filter_names:
                continue
            try:
                yield cls(name=name, **hd)
            except TypeError:
                traceback.print_exc()

    def __init__(self, name, nodelist=[], submission_host=None, slurm_arguments='',
                 runtime_setup=[], machine_filename=None):
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

    def get_machine_filepath(self):
        return config['base_dirpath'].joinpath('machine_files', self.machine_filename)

    def enqueue_execution(self, cli_args):
        print("TODO enqueue on", self.name, ':', ' '.join(cli_args))
        # TODO eunqueue
        # * build job file string
        # * pass to slurm

    def get_queued_executions(self):
        """Return list of queued cli_args and status"""
        raise NotImplementedError

    def get_compilers(self, skip_unavailable=True):
        """Return list of compilers from host description."""
        for c in self.machine_file['compiler'].keys():
            if not skip_unavailable or find_executable(c):
                yield c

    def is_current_host(self):
        """Return True if executing host is mentioned in nodelist"""
        return socket.gethostname().split('.')[0] in self.nodelist


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

    def get_wldir(self):
        """Return path to workload directory"""
        wldir = config['base_dirpath'].joinpath(
            'jobs', self.host.name, self.kernel.type, self.kernel.parameter)
        return wldir

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

            # Copy machine file
            machine_filename = wldir.joinpath('machine.yml')
            if not machine_filename.exists():
                shutil.copy(str(self.host.get_machine_filepath()), str(machine_filename))
        return wldir

    def get_jobs(self, compiler=None, steps=None, incore_model=None, cores=None):
        if hasattr(self, '_jobs'):
            return self._jobs

        jobs = []
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
            for s in self.kernel.steps:
                jobs.append(Job(self, base_args + ['-w', 'S0:{}B'.format(s)], exec_on_host=True))
        else:
            raise NotImplementedError("Unknown kernel type")
        self._jobs = jobs
        return jobs

    def process_outputs(self):
        """Gather and process outputs into a single report."""
        # 1. gather output of finished jobs
        outputs = []
        for j in self.get_jobs():
            if j.get_state() != 'finished':
                # Skipping unfinished jobs
                continue
            outputs += j.get_dicts()
        df = pandas.DataFrame(outputs)
        df_pickle_filename = 'dataframe.pickle.lzma'
        compress_pickle.dump(df, self.get_wldir() / df_pickle_filename)

        papermill.execute_notebook(
            str(config['base_dirpath'] / 'config/report-template.ipynb'),
            str(self.get_wldir() / 'report.ipynb'),
            parameters={}
        )
        print(self.get_wldir() / 'report.ipynb', 'written')

        # 2. combine all outputs
        # 3. generate plots and report (how?)

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
        jdir = self.get_jobdir()
        self._lockfile_path = jdir.with_name(jdir.name+'.lock')
        self._lock_fd = None

        self._state = self.get_state()

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
        self._lockfile_path.unlink()
        self._lock_fd.close()
        self._lock_fd = None

    def get_jobdir(self):
        """Return job directory path."""
        return self.workload.get_wldir() / ' '.join(self.arguments).replace('/', '$')

    def _run(self):
        """Work to be executed"""
        try:
            with self.get_jobdir().joinpath('out.txt').open('w') as f:
                subprocess.run(self.arguments, check=True,
                    stdout=f, stderr=subprocess.STDOUT)
        except KeyboardInterrupt:
            raise
        except:
            traceback.print_exc(file=sys.stderr)
            raise

    def execute(self, non_blocking=False, rerun_failed=False):
        """Change state from new or enqueud to executing."""
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

    def get_state(self):
        """Indicate if this job is new, executing, finished or failed."""
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
        assert self._state == 'finished', "Can only be run on sucessfully finished jobs."
        return (self.get_jobdir().joinpath('out.txt').read_text(),)
    
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
                            traceback.print_exc(file=sys.stderr)
                            raise
                        finally:
                            del parser
                            del args
            compress_pickle.dump(result_storage, self.get_jobdir() / 'out.pickle.lzma',
                         protocol=4)
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
        base_dict['cores'] = self.cores
        base_dict['compiler'] = self.compiler
        base_dict['incore_model'] = self.incore_model
        base_dict['cache_predictor'] = self.cache_predictor
        kc_args, kc_results = next(iter(self.get_outputs()[-1].items()))
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
                dicts.append(d)
        elif self.pmodel == 'RooflineIACA':
            # extracts:
            # preformance [It/s]
            # performance [cy/CL]
            # performance [cy/It]
            # performance [FLOP/s]
            # in-core model output
            cpu_perf = kc_results['cpu bottleneck']['performance throughput']
            if kc_results['min performance']['FLOP/s'] > cpu_perf['FLOP/s']:
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
            base_dict['iterations per cacheline'] = int(kc_results['Iterations per cacheline'])
            base_dict['performance [cy/CL]'] = float(
                kc_results['Runtime (per cacheline update) [cy/CL]'])
            base_dict['performance [cy/It]'] = \
                float(kc_results['Runtime (per cacheline update) [cy/CL]'] * \
                    kc_results['Iterations per cacheline'])
            base_dict['performance [FLOP/s]'] = float(kc_results['Performance [MFLOP/s]']*1e6)
            base_dict['performance [LUP/s]'] = float(kc_results['Performance [MLUP/s]']*1e6)
            base_dict['performance [It/s]'] = float(kc_results['Performance [MIt/s]']*1e6)
            # TODO get code balance (B_ [B/It]) for inter-cache transfers
            dicts.append(base_dict)
            # TODO PhenoECM
        else:
            raise NotImplementedError("Unsupported performance model type {!r}".format(self.pmodel))
        for d in dicts:
            d.move_to_end('raw output')
        return dicts


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
            incore_model=None, cores=None, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    kernels = list(Kernel.get_all(filter_type=type, filter_parameter=parameter))
    workloads = []
    jobs = []
    for h in hosts:
        wls = list(Workload.get_all(kernels, [h]))
        workloads.extend(wls)
        # Build list of jobs by chaining workload job lists
        if any([w.get_jobs(
                    compiler=compiler, steps=steps, incore_model=incore_model, cores=cores
                ) for w in wls]):
            # Queue this filterset for execution on host
            h.enqueue_execution(make_cli_args(
                type=type, parameter=parameter, machine=machine, compiler=compiler, steps=steps,
                incore_model=incore_model, cores=incore_model))

    # Just FYI
    print(len(hosts), "hosts")
    print(len(kernels), "kernels")
    print(len(workloads), "workloads")


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
        print("{:>8} {:>6} {:>7.1%}".format(state, count, count/len(jobs)))
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

    for j in jobs:
        print(j.get_state(), j.get_jobdir())
        j.execute(rerun_failed=rerun_failed)


def process(type=None, parameter=None, machine=None, **kwargs):
    hosts = list(Host.get_all(filter_names=machine))
    kernels = list(Kernel.get_all(filter_type=type, filter_parameter=parameter))
    workloads = list(Workload.get_all(kernels, hosts))
    for wl in workloads:
        wl.process_outputs()


def upload(type=None, parameter=None, machine=None, **kwargs):
    raise NotImplementedError


def get_args(args=None):
    """Return parsed commandline arguments."""
    if hasattr(get_args, '_parsed_args'):
        return get_args._parsed_args

    parser = argparse.ArgumentParser(description='INSPECT Command Line Utility')
    parser.add_argument('--version', action=VersionAction, version='{}'.format(__version__))
    parser.add_argument('--verbose', '-v', action='count', default=0,
                        help='Increases verbosity level.')
    parser.add_argument('--base-dir', '-b', type=Path, default=Path('.'),
                        help='Base directory to use for config and intermediate files.')

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
    # uload: workload
    upload_parser = subparsers.add_parser(
        'upload', help='Upload and combine workload reports into website')
    upload_parser.set_defaults(action_function=upload)
    get_args._parsed_args = parser.parse_args(args=args)
    get_args._parsed_args.base_dir = get_args._parsed_args.base_dir.absolute()
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
    first, last, steps=100, stepping='log', multiple_of=8, no_powers_of_two=True):
    """
    Generate a list of sizes, based on scaling dictionary description.

    :param first: first element in resuliting list
    :param last: last element in resulting list
    :param steps: total number of elements in resulting list
    :param stepping: use linear ('lin') or logarithmic ('log') stepping
    :param multiple_of: force all sizes to be a multiple of this
    :param no_powers_of_two: check for powers of two and avoid those

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
    config['base_dirpath'] = args.base_dir
    args.action_function(**vars(args))


if __name__ == '__main__':
    main()