{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="memory" id="mem_{{include.type}}" {{hide_if_hidden}} >

{% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% capture N %}{% for data in csv_file %}{{data["N^3"]}},{%endfor%}{% endcapture %}
{% capture bench_L1L2 %}{% for data in csv_file %}{{data["Benchmark Transfer L1L2 total"]}},{%endfor%}{% endcapture %}
{% capture bench_L2L3 %}{% for data in csv_file %}{{data["Benchmark Transfer L2L3 total"]}},{%endfor%}{% endcapture %}
{% capture bench_L3MEM %}{% for data in csv_file %}{{data["Benchmark Transfer L3MEM total"]}},{%endfor%}{% endcapture %}

{% capture LC_L1L2 %}{% for data in csv_file %}{{data["LC Transfer L1L2 total"]}},{%endfor%}{% endcapture %}
{% capture LC_L2L3 %}{% for data in csv_file %}{{data["LC Transfer L2L3 total"]}},{%endfor%}{% endcapture %}
{% capture LC_L3MEM %}{% for data in csv_file %}{{data["LC Transfer L3MEM total"]}},{%endfor%}{% endcapture %}

{% capture CS_L1L2 %}{% for data in csv_file %}{{data["CS Transfer L1L2 total"]}},{%endfor%}{% endcapture %}
{% capture CS_L2L3 %}{% for data in csv_file %}{{data["CS Transfer L2L3 total"]}},{%endfor%}{% endcapture %}
{% capture CS_L3MEM %}{% for data in csv_file %}{{data["CS Transfer L3MEM total"]}},{%endfor%}{% endcapture %}

<script>
var benchmark_l1l2 = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{N}}],
  y: [{{bench_L1L2}}],
  line: {color: '#d62728'},
  name: "L1-L2 Benchmark"
};
var benchmark_l2l3 = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{N}}],
  y: [{{bench_L2L3}}],
  line: {color: '#1f77b4'},
  name: "L2-L3 Benchmark"
};
var benchmark_l3mem = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{N}}],
  y: [{{bench_L3MEM}}],
  line: {color: '#ff7f0e'},
  name: "L3-MEM Benchmark"
};

var L1L2 = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_L1L2}}{% elsif include.type == 'CS' %}{{CS_L1L2}}{% endif %}],
  line: {color: '#d62728'},
  name: "L1-L2 with {{include.type}}"
};
var L2L3= {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_L2L3}}{% elsif include.type == 'CS' %}{{CS_L2L3}}{% endif %}],
  line: {color: '#1f77b4'},
  name: "L2-L3 with {{include.type}}"
};
var L3MEM = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{LC_L3MEM}}{% elsif include.type == 'CS' %}{{CS_L3MEM}}{% endif %}],
  line: {color: '#ff7f0e'},
  name: "L3-MEM with {{include.type}}"
};

var data = [benchmark_l1l2,benchmark_l2l3,benchmark_l3mem,L1L2,L2L3,L3MEM];

var layout = {
	xaxis: {title: "Grid Size (N^{{page.dimension | replace: 'D', ''}})",
          rangemode: "tozero"},
	yaxis: {title: 'Data Transfers [Byte/LUP]',
          rangemode: "tozero"},
  margin: { l: 50, r: 35, t: 10, b: 40},
  legend: { orientation: "h",y:1.3},
  width: 600,
  height: 450,
};

var config = {locale: 'en'};
Plotly.newPlot('mem_{{include.type}}', data, layout, config);
</script>

*Data transfers between the different cache levels and main memory. The shown data for each level contains evicted and loaded data. The measured data is represented by points and the predicted transfer rates by [kerncraft](https://github.com/RRZE-HPC/kerncraft) by lines.*
</div>
