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
from math import copysign

from IPython.display import display, HTML, Code
from ipywidgets import widgets
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import compress_pickle
from tabulate import tabulate
import numpy as np
import machinestate


def divide(numerator, denominator):
    if denominator == 0.0:
        return copysign(float('inf'), denominator)
    return numerator / denominator


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
    # Etract overlapping and non-overlapping data-transfer components from
    # machine mokdel definition
    overlapping_ecm_transfers = [
        label
        for label, level in zip(['T_RegL1', 'T_L1L2', 'T_L2L3', 'T_L3MEM'],
                                machine['memory hierarchy'])
        if level['transfers overlap']]
    nonoverlapping_ecm_transfers = [
        label
        for label, level in zip(['T_RegL1', 'T_L1L2', 'T_L2L3', 'T_L3MEM'],
                                machine['memory hierarchy'])
        if not level['transfers overlap']]
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
                    *[ecm_data[t] for t in nonoverlapping_ecm_transfers],
                    labels=[t for t in nonoverlapping_ecm_transfers])
                ax.plot(ecm_data['define'], ecm_data.T_comp, label='T_comp')
                for t in overlapping_ecm_transfers:
                    ax.plot(ecm_data['define'], ecm_data[t], label=t)

                # Benchmark
                bench_data = data_defines.query('pmodel=="Benchmark" and cores==1 and compiler == @cc and cores==1')
                ax.plot(bench_data.define, bench_data['performance [cy/CL]'], '+', label='Measured')

                # RooflineIACA
                roof_data = data_defines.query('pmodel=="RooflineIACA" and incore_model == @icm and '
                                               'compiler == @cc and cache_predictor == @cp and cores==1')
                ax.plot(roof_data.define, roof_data['performance [cy/CL]'], label='RL pred.')

                ax.set_ylim(0)
                if i_icm == len(incore_models) - 1:
                    T_to_P = lambda T: divide(float(machine['clock']), T) * iterations_per_cacheline
                    ax_right = ax.twinx()
                    ymin, ymax = ax.get_ylim()
                    yticks = ax.get_yticks().tolist()
                    ax_right.set_ylim(ax.get_ylim())
                    ax_right.yaxis.set_major_locator(mticker.FixedLocator(yticks))
                    ax.yaxis.set_major_locator(mticker.FixedLocator(yticks))
                    with np.errstate(divide='ignore'):
                        ax_right.set_yticklabels(["{:.2f}".format(T_to_P(t)/1e9) for t in yticks])
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
                    P_to_T = lambda P: iterations_per_cacheline*divide(float(machine['clock']), P)
                    ax_right = ax.twinx()
                    ymin, ymax = ax.get_ylim()
                    ax_right.set_ylim(ax.get_ylim())
                    yticks = ax.get_yticks().tolist()
                    ax.yaxis.set_major_locator(mticker.FixedLocator(yticks))
                    ax_right.yaxis.set_major_locator(mticker.FixedLocator(yticks))
                    with np.errstate(divide='ignore'):
                        ax_right.set_yticklabels(["{:.2f}".format(P_to_T(t*1e9))
                                                  for t in yticks])
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
        ms_data = json.load(f)
    
    html_wrapper = """
<html>
<head>
<meta name "viewport" content="width=device-width, initial-scale=1">
<style>
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 98vw;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc;
}

.accordion:after {
  content: '\\002B';
  color: #777;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.active:after {
  content: "\\2212";
}

.panel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
  width: 97vw;
}

.option {
  float: left;
  background-color: #555555;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 15px;
}

.expandable {
  background-color: #4CAF50;
  width: 49vw;
}

.collapsible {
  background-color: #f44336;
  width: 49vw;
}
</style>
</head>

<body>
<button class="option expandable">Expand all</button>
<button class="option collapsible">Collapse all</button>
{table}
<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var children = this.parentNode.childNodes;
    children.forEach(child => {
        if(child.style) {
    		if (child.style.maxHeight) {
        		child.style.maxHeight = null;
       		} else {
	        	child.style.maxHeight = child.scrollHeight + "px";
    	    }
        }
    });
    adjust(this.parentNode);
  });
}

var bExpand = document.getElementsByClassName("option expandable")[0];
var bCollaps = document.getElementsByClassName("option collapsible")[0];

bExpand.addEventListener("click", function() {
	var accNonActive = Array.prototype.filter.call(acc, function(elem, i, acc) {
		return !elem.className.includes("active");
	});
	for (i = 0; i < accNonActive.length; i++) {
		accNonActive[i].click();
	}
});

bCollaps.addEventListener("click", function() {
	var accActive = Array.prototype.filter.call(acc, function(elem, i, acc) {
		return elem.className.includes("active");
	});
	for (i = accActive.length - 1; i >= 0; i--) {
		accActive[i].click();
	}
});

function adjust(node) {
	if(node.style) {
        node.style.maxHeight = 10 * window.innerHeight + "px";
    }
    if(node.parentNode){
    	adjust(node.parentNode);
	}
}
</script>
</body>
</html>
    """

    def get_infogroup_html(name, d):
        instances = []
        s = ""
        s += "<button class=\"accordion\">{}</button>\n".format(name)
        s += "<div class=\"panel\">\n<table style=\"width:100vw\">\n"
        for k,v in d.items():
            if isinstance(v, dict):
                instances.append((k,v))
            if isinstance(v, list):
                s += "<tr>\n\t<td style=\"width: 20%\"><b>{}:</b></td>\n\t<td>{}</td>\n</tr>\n".format(k, ", ".join([str(x) for x in v]))
            else:
                s += "<tr>\n\t<td style=\"width: 20%\"><b>{}:</b></td>\n\t<td>{}</td>\n</tr>\n".format(k, v)
        for inst in instances:
            s += "<tr>\n\t<td colspan=\"2\">{}</td>\n</tr>".format(get_infogroup_html(*inst))
        s += "</table>\n</div>\n\n"
        return s

    table = '<table style="width:100vw">'
    for k,v in ms_data.items():
        table += '<tr>\n\t<td colspan=\"2\">'
        table += get_infogroup_html(k, v)
        table += '</td>\n</tr>'
    table += '</table>\n\n'

    return HTML('''
        <iframe class="machinestatewrapper" width="100%" height="1000" data-content="''' + \
            html.escape(html_wrapper.replace('{table}', table)) + '''"></iframe>
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