{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="memory" id="mem_{{include.type}}" {{hide_if_hidden}} >

{% if page.stencil_name %}
  {% capture csv_filename %}{{page.stencil_name}}_{{page.machine}}_results{% endcapture %}
{% else %}
  {% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% endif %}

{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% assign N = "" %}

{% for data in csv_file %}
  {% assign N = data["N^3"] | append: ',' | prepend: N %}
  {% assign bench_L1L2 = data["Benchmark Transfer L1L2 total"] | append: ',' | prepend: bench_L1L2 %}
  {% assign bench_L2L3 = data["Benchmark Transfer L2L3 total"] | append: ',' | prepend: bench_L2L3 %}
  {% assign bench_L3MEM = data["Benchmark Transfer L3MEM total"] | append: ',' | prepend: bench_L3MEM %}

  {% assign LC_L1L2 = data["LC Transfer L1L2 total"] | append: ',' | prepend: LC_L1L2 %}
  {% assign LC_L2L3 = data["LC Transfer L2L3 total"] | append: ',' | prepend: LC_L2L3 %}
  {% assign LC_L3MEM = data["LC Transfer L3MEM total"] | append: ',' | prepend: LC_L3MEM %}

  {% assign CS_L1L2 = data["CS Transfer L1L2 total"] | append: ',' | prepend: CS_L1L2 %}
  {% assign CS_L2L3 = data["CS Transfer L2L3 total"] | append: ',' | prepend: CS_L2L3 %}
  {% assign CS_L3MEM = data["CS Transfer L3MEM total"] | append: ',' | prepend: CS_L3MEM %}
{% endfor %}

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
	xaxis: {title: "Grid Size (N^(1/{{page.dimension | replace: 'D', ''}}))",
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
