#!/usr/bin/env python3
import html
from collections import defaultdict
from pathlib import Path
import json
from pprint import pformat
from tempfile import NamedTemporaryFile
import sys
from unittest.mock import patch
import io

from IPython.display import display, HTML, Code
from ipywidgets import widgets
import pandas as pd
import matplotlib.pyplot as plt
import compress_pickle
from tabulate import tabulate
import numpy as np

from machinestate.html_export import to_html as ms_to_html


def load_pickled_dataframe(fname='dataframe.pickle.lzma'):
    data = compress_pickle.load(fname)
    if data.empty or any([c not in data.columns
                          for c in ['compiler', 'incore_model', 'cache_predictor']]):
        raise SystemExit("No data avilable")
    return data


def get_unique(data, column, no_nones=True):
    return [i for i in data[column].unique() if i is not None or not no_nones]


def get_iterations_per_cacheline(data):
    return int(data.get('iterations per cacheline').dropna().unique()[0])


def get_incore_analysis_tabs(data,
                             compilers=None,
                             incore_models=None):
    if compilers is None:
        compilers = get_unique(data, 'compiler')
    if incore_models is None:
        incore_models = get_unique(data, 'incore_model')
    cc_tab = widgets.Tab()
    cc_tab_children = []
    for i, cc in enumerate(compilers):
        cc_tab.set_title(i, cc)
        icm_tab = widgets.Tab(children=[])
        icm_tab_children = []
        cc_tab_children.append(icm_tab)
        for j, icm in enumerate(incore_models):
            icm_tab.set_title(j, icm)
            model_output = list(data.query("compiler == @cc and incore_model == @icm")['in-core model output'].iloc(0))
            if model_output:
                model_output = model_output[0]
            else:
                model_output = ''
            icm_tab_children.append(
                widgets.HTML(value='<pre style="line-height: 1;">{}</pre>'.format(html.escape(model_output))))
        icm_tab.children = icm_tab_children
    cc_tab.children = cc_tab_children
    return cc_tab


def display_lc_analysis(data):
    lc_data = []
    for col in data.columns:
        if not col.endswith(' LCs'):
            continue
        cache = col.split(' ')[0]
        for lc in data.get(col).dropna()[0]:
            lc['cache'] = cache
            lc_data.append(lc)
    lc_df = pd.DataFrame(lc_data)
    if not lc_df.empty:
        idx = pd.MultiIndex.from_frame(lc_df[['cache', 'tail']])
        lc_df = pd.DataFrame(lc_data, columns=['condition', 'hits', 'misses', 'evicts'], index=idx)
        display(lc_df)
        display(HTML("<p>hits, misses and evicts are given in number of elements</p>"))


def get_model_analysis_tabs(data,
                            machine,
                            compilers=None,
                            incore_models=None,
                            cache_predictors=None):
    if compilers is None:
        compilers = get_unique(data, 'compiler')
    if incore_models is None:
        incore_models = get_unique(data, 'incore_model')
    if cache_predictors is None:
        cache_predictors = get_unique(data, 'cache_predictor')
    iterations_per_cacheline = get_iterations_per_cacheline(data)
    plt.ioff()
    cp_tab = widgets.Tab()
    cp_tab_children = []
    for i, cp in enumerate(cache_predictors):
        cp_tab.set_title(i, cp)
        data_defines = data.sort_values(by=['define'])
        if compilers and incore_models:
            fig, axs = plt.subplots(len(compilers), len(incore_models),
                                    squeeze=False,
                                    figsize=(4*len(incore_models),3*len(compilers)),
                                    sharey=True,
                                    sharex=True)
            fig.subplots_adjust(hspace=0.3)

        ylimit = max(
            data_defines.query('pmodel=="RooflineIACA" and cores==1 and '
                               'cache_predictor == @cp')['performance [cy/CL]'].max(skipna=True),
            data_defines.query('pmodel=="Benchmark" and cores==1')['performance [cy/CL]'].max(skipna=True))

        for i_cc, cc in enumerate(compilers):
            for i_icm, icm in enumerate(incore_models):
                ax = axs[i_cc, i_icm]
                ax.set_title("{} {}".format(cc, icm))
                ax.set_xscale("log")
                ax.set_ylim(0, ylimit*1.05)
                ax.xaxis.set_tick_params(labelbottom=True)
                #ax.yaxis.set_tick_params(labelleft=True)
                ax.grid()
                ax.set_axisbelow(True)  # places gridlines behind everything else

                # ECM
                ecm_data = data_defines.query('pmodel=="ECM" and cores==1 and incore_model == @icm and '
                                              'compiler == @cc and cache_predictor == @cp and cores==1')
                ax.stackplot(
                    ecm_data['define'],
                    ecm_data['T_RegL1'], ecm_data['T_L1L2'], ecm_data['T_L2L3'], ecm_data['T_L3MEM'],
                    labels=('T_RegL1', 'T_L1L2', 'T_L2L3', 'T_L3MEM'))
                ax.plot(ecm_data['define'], ecm_data.T_comp, label='T_comp')

                # Benchmark
                bench_data = data_defines.query('pmodel=="Benchmark" and cores==1 and compiler == @cc and cores==1')
                ax.plot(bench_data.define, bench_data['performance [cy/CL]'], '+', label='Measured')

                # RooflineIACA
                roof_data = data_defines.query('pmodel=="RooflineIACA" and incore_model == @icm and '
                                               'compiler == @cc and cache_predictor == @cp and cores==1')
                ax.plot(roof_data.define, roof_data['performance [cy/CL]'], label='RL pred.')

                ax.set_ylim(0)
                if i_icm == len(incore_models) - 1:
                    T_to_P = lambda T: float(machine['clock']) / T * iterations_per_cacheline
                    ax_right = ax.twinx()
                    ymin, ymax = ax.get_ylim()
                    ax_right.set_ylim(ax.get_ylim())
                    with np.errstate(divide='ignore'):
                        ax_right.set_yticklabels(["{:.2f}".format(T_to_P(t)/1e9) for t in ax.get_yticks()])
                    ax_right.set_ylabel("giga iterations per second")
                if i_icm == 0 and i_cc == 0:
                    ax.legend(bbox_to_anchor=(0.5, 0.0), ncol=len(incore_models)*3,
                              loc='lower center', bbox_transform=fig.transFigure)
                if i_icm == 0:
                    ax.set_ylabel("cycle per {} iterations".format(iterations_per_cacheline))
                if i_cc == len(compilers) - 1:
                    ax.set_xlabel("dimension length")
        if len(incore_models) == 1:  # only one column
            fig.subplots_adjust(right=0.85)  # otherwise twinx will be partially hidden
        f = io.BytesIO()
        fig.savefig(f, format="svg")
        plt.close(fig)

        cp_tab_children.append(widgets.HTML(value=f.getvalue()))
    cp_tab.children = cp_tab_children
    plt.ion()
    return cp_tab


def get_scaling_tabs(data,
                     machine,
                     compilers=None,
                     incore_models=None,
                     cache_predictors=None):
    if compilers is None:
        compilers = get_unique(data, 'compiler')
    if incore_models is None:
        incore_models = get_unique(data, 'incore_model')
    if cache_predictors is None:
        cache_predictors = get_unique(data, 'cache_predictor')
    iterations_per_cacheline = get_iterations_per_cacheline(data)
    plt.ioff()
    cp_tab = widgets.Tab()
    cp_tab_children = []
    for i, cp in enumerate(cache_predictors):
        cp_tab.set_title(i, cp)
        if compilers and incore_models:
            fig, axs = plt.subplots(len(compilers), len(incore_models), squeeze=False,
                                    figsize=(4*len(incore_models),3*len(compilers)),
                                    sharey=True,
                                    sharex=True)
            fig.subplots_adjust(hspace=0.3)
        max_define = data.define.max()
        for i_cc, cc in enumerate(compilers):
            for i_icm, icm in enumerate(incore_models):
                ax = axs[i_cc, i_icm]
                ax.set_title("{} {}".format(cc, icm))
                ax.xaxis.set_tick_params(labelbottom=True)
                ax.grid()

                bench_data = data.query(
                    'pmodel=="Benchmark" and define==@max_define and compiler == @cc'
                ).sort_values(by=['cores'])
                ax.plot(bench_data.cores, bench_data['performance [It/s]']/1e9, label='Measured')
                ecm_data = data.query(
                    'pmodel=="ECM" and define==@max_define and incore_model==@icm and '
                    'compiler == @cc and cache_predictor == @cp'
                ).sort_values(by=['cores'])
                ax.plot(ecm_data.cores, ecm_data['performance [It/s]']/1e9, label='ECM pred.')
                roof_data = data.query(
                    'pmodel=="RooflineIACA" and define==@max_define and incore_model==@icm and '
                    'compiler == @cc and cache_predictor == @cp'
                ).sort_values(by=['cores'])
                ax.plot(roof_data.cores, roof_data['performance [It/s]']/1e9, label='RL pred.')

                ax.set_ylim(0)
                ax.set_axisbelow(True)  # places gridlines behind everything else
                if i_icm != 0:
                    ax.yaxis.set_tick_params(labelleft=False)
                if i_icm == len(incore_models) - 1:
                    P_to_T = lambda P: iterations_per_cacheline*float(machine['clock'])/P
                    ax_right = ax.twinx()
                    ymin, ymax = ax.get_ylim()
                    ax_right.set_ylim(ax.get_ylim())
                    with np.errstate(divide='ignore'):
                        ax_right.set_yticklabels(["{:.2f}".format(P_to_T(t*1e9)) for t in ax.get_yticks()])
                    ax_right.set_ylabel("cycle per {} iterations".format(iterations_per_cacheline))
                # use default ticks, but always start at min_cores and end at max_cores
                min_cores, max_cores = int(data.cores.min()), int(data.cores.max())
                ax.set_xticks([t for t in ax.get_xticks()
                               if min_cores < t < max_cores] +
                              [min_cores, max_cores])
                ax.minorticks_on()
                if i_icm == 0 and i_cc == 0:
                    ax.legend(bbox_to_anchor=(0.5, 0.0), ncol=len(incore_models)*3,
                              loc='lower center', bbox_transform=fig.transFigure)
                if i_icm == 0:
                    ax.set_ylabel("giga iterations per second")
                if i_cc == len(compilers) - 1:
                    ax.set_xlabel("cores")
        if len(incore_models) == 1:  # only one column
            fig.subplots_adjust(right=0.85)  # otherwise twinx will be partially hidden
        f = io.BytesIO()
        fig.savefig(f, format="svg")
        plt.close(fig)

        cp_tab_children.append(widgets.HTML(
            value=f.getvalue()+"<p>with dimension length = {}</p>".format(int(max_define)).encode('utf8')))
    cp_tab.children = cp_tab_children
    plt.ion()
    return cp_tab


def get_machinestate_html(fname):
    with open(fname) as f:
        machinestate = json.load(f)
    return HTML('''
        <iframe class="machinestatewrapper" width="100%" height="1000" data-content="'''+html.escape(ms_to_html(machinestate))+'''"></iframe>
        <script>
            var msw = $(".machinestatewrapper")[0];
            var html = msw.getAttribute('data-content');
            msw.contentDocument.write(html);
            msw.contentWindow.document.close();
        </script>''')


def get_output(data, **kwargs):
    d = data
    for k, v in kwargs.items():
        d = d.query(k+' == @v')

    if len(d) > 1:
        print("!!! Multiple jobs selected ({}), printing first result:".format(len(d)))
    elif len(d) == 0:
        raise Exception("nothing found")

    return d.iloc[0]['raw output']