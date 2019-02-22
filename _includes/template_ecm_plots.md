{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="ecm" id="ecm_{{include.type}}" {{hide_if_hidden}} >

{% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% capture N %}{% for data in csv_file %}{{data["N^3"]}},{%endfor%}{% endcapture %}
{% capture bench %}{% for data in csv_file %}{{data["Benchmark cycl"]}},{%endfor%}{% endcapture %}

{% capture LC_Tol %}{% for data in csv_file %}{{data["ECM LC Tol"]}},{%endfor%}{% endcapture %}
{% capture LC_Tnol %}{% for data in csv_file %}{{data["ECM LC Tnol"]}},{%endfor%}{% endcapture %}
{% capture LC_Tl1l2 %}{% for data in csv_file %}{{data["ECM LC Tl1l2"]}},{%endfor%}{% endcapture %}
{% capture LC_Tl2l3 %}{% for data in csv_file %}{{data["ECM LC Tl2l3"]}},{%endfor%}{% endcapture %}
{% capture LC_Tl3mem %}{% for data in csv_file %}{{data["ECM LC Tl3mem"]}},{%endfor%}{% endcapture %}
{% capture LC_total %}{% for data in csv_file %}{{data["ECM LC cycl"]}},{%endfor%}{% endcapture %}

{% capture CS_Tol %}{% for data in csv_file %}{{data["ECM CS Tol"]}},{%endfor%}{% endcapture %}
{% capture CS_Tnol %}{% for data in csv_file %}{{data["ECM CS Tnol"]}},{%endfor%}{% endcapture %}
{% capture CS_Tl1l2 %}{% for data in csv_file %}{{data["ECM CS Tl1l2"]}},{%endfor%}{% endcapture %}
{% capture CS_Tl2l3 %}{% for data in csv_file %}{{data["ECM CS Tl2l3"]}},{%endfor%}{% endcapture %}
{% capture CS_Tl3mem %}{% for data in csv_file %}{{data["ECM CS Tl3mem"]}},{%endfor%}{% endcapture %}
{% capture CS_total %}{% for data in csv_file %}{{data["ECM CS cycl"]}},{%endfor%}{% endcapture %}

{% capture Pheno_Tol %}{% for data in csv_file %}{{data["Benchmark Pheno Tol"]}},{%endfor%}{% endcapture %}
{% capture Pheno_Tnol %}{% for data in csv_file %}{{data["Benchmark Pheno Tnol"]}},{%endfor%}{% endcapture %}
{% capture Pheno_Tl1l2 %}{% for data in csv_file %}{{data["Benchmark Pheno Tl1l2"]}},{%endfor%}{% endcapture %}
{% capture Pheno_Tl2l3 %}{% for data in csv_file %}{{data["Benchmark Pheno Tl2l3"]}},{%endfor%}{% endcapture %}
{% capture Pheno_Tl3mem %}{% for data in csv_file %}{{data["Benchmark Pheno Tl3mem"]}},{%endfor%}{% endcapture %}

<script>
var trace_benchmark = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{N}}],
  y: [{{bench}}],
  line: {color: 'black'},
  name: "Benchmark"
};
var trace_Tol = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_Tol}}{% elsif include.type == 'CS' %}{{CS_Tol}}{% elsif include.type == 'Pheno' %}{{Pheno_Tol}}{% endif %}],
  line: {color: '#d62728'},
  name: "T<sub>OL</sub>"
};
var trace_Tnol = {
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_Tnol}}{% elsif include.type == 'CS' %}{{CS_Tnol}}{% elsif include.type == 'Pheno' %}{{Pheno_Tnol}}{% endif %}],
  marker: {color: '#1f77b4'},
  name: "T<sub>nOL</sub>"
};
var trace_Tl1l2 = {
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_Tl1l2}}{% elsif include.type == 'CS' %}{{CS_Tl1l2}}{% elsif include.type == 'Pheno' %}{{Pheno_Tl1l2}}{% endif %}],
  marker: {color: '#aec7e8'},
  name: "T<sub>L1-L2</sub>"
};
var trace_Tl2l3 = {
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_Tl2l3}}{% elsif include.type == 'CS' %}{{CS_Tl2l3}}{% elsif include.type == 'Pheno' %}{{Pheno_Tl2l3}}{% endif %}],
  marker: {color: '#ff7f0e'},
  name: "T<sub>L2-L3</sub>"
};
var trace_Tl3mem = {
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_Tl3mem}}{% elsif include.type == 'CS' %}{{CS_Tl3mem}}{% elsif include.type == 'Pheno' %}{{Pheno_Tl3mem}}{% endif %}],
  marker: {color: '#ffbb78'},
  name: "T<sub>L3-MEM</sub>"
};
var trace_Ttotal = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_total}}{% elsif include.type == 'CS' %}{{CS_total}}{% elsif include.type == 'Pheno' %}{% endif %}],
  line: {color: 'rgba(0,0,0,0)'},
  showlegend: false,
  name: "T<sub>ECM total</sub>"
};


var data = [trace_Tnol,trace_Tl1l2,trace_Tl2l3,trace_Tl3mem,trace_Tol,trace_Ttotal,trace_benchmark];

var layout = {
  margin: { l: 40, r: 35, t: 10, b: 40},
  xaxis: {title: "Grid Size (N^{{page.dimension | replace: 'D', ''}})",
          dticks: 50,
          tick0: 0},
  yaxis: {title: 'Cycles / Cacheline',
          tick0: 0},
  barmode: 'stack',
  legend: { orientation: "h",y:1.1},
  width: 600,
  height: 450,
};

var config = {locale: 'en'};
Plotly.newPlot('ecm_{{include.type}}', data, layout, config);
</script>

{% if include.type == 'LC' %}
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Layer Conditions](https://rrze-hpc.github.io/layer-condition/) to model the cache behavior. The calculated [layer conditions](#layer-conditions) shown above correspond to the jumps in the ECM prediction in this plot.*
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["ecm_LC.svg"] %}
{% else if include.type == 'CS' %}
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Cache Simulation](https://github.com/RRZE-HPC/pycachesim) to model the cache behavior.*
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["ecm_CS.svg"] %}
{% else include.type == 'Pheno' %}
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the phenomenological [ECM Performance Model](https://hpc.fau.de/research/ecm/) measured with [kerncraft](https://github.com/RRZE-HPC/kerncraft). The phenomenological ECM Model is completely derived from performance counter measurements during benchmark execution.*
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["ecm_Pheno.svg"] %}
{% else %}
*Unknown ECM Plot*
{% endif %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
