{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="blocking" {{hide_if_hidden}} >

{% for case in page.blocking %}

{% if page.stencil_name %}
  {% capture csv_filename %}{{page.stencil_name}}_{{page.machine}}_blocking_{{case}}{% endcapture %}
{% else %}
  {% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_blocking_{{case}}{% endcapture %}
{% endif %}

{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% capture csv_results_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% assign csv_results_file = site.data.stencils[{{csv_results_filename}}] %}

{% if forloop.first %}
  {% assign hide_if_hidden_b = '' %}
{% else %}
  {% assign hide_if_hidden_b = 'style="display:none;"' %}
{% endif %}

<div id="blocking_{{case}}" {{hide_if_hidden_b}}></div>

{% assign N = "" %}
{% assign bench = "" %}
{% assign bench_block = "" %}
{% assign ecm = "" %}
{% assign roofline_LC = "" %}

{% for data in csv_file %}
  {% assign N = data.N | append: ',' | prepend: N %}
  {% assign bench_block = data["Mlup/s"] | append: ',' | prepend: bench_block %}

  {% if forloop.last %}
    {% assign nticks = data.N %}
  {% endif %}
{% endfor %}

{% for data in csv_results_file %}
  {% assign bench = data["Benchmark MLUPs"] | append: ',' | prepend: bench %}
  {% assign roofline_LC = data["Roofline LC MLUPs"] | append: ',' | prepend: roofline_LC %}
  {% assign ecm = data["Roofline ECM MLUPs"] | append: ',' | prepend: ecm %}
{% endfor %}

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
var trace_benchmark_block = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{N}}],
  y: [{{bench_block}}],
  line: {color: 'green'},
  name: "Benchmark w/ {{case}} blocking"
};
var trace_roofline = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{{roofline_LC}}],
  line: {color: '#1f77b4'},
  name: "Roofline LC"
};
var trace_ecm = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{{ecm}}],
  line: {color: '#ff7f0e'},
  name: "ECM"
};

var data = [trace_benchmark,trace_benchmark_block,trace_roofline,trace_ecm];

var layout = {
  xaxis: {title: "Grid Size (N^{{page.dimension | replace: 'D', ''}})",
          rangemode: "tozero"},
  yaxis: {title: 'Performance [MLUP/s]',
          rangemode: "tozero"},
  margin: { l: 50, r: 35, t: 10, b: 40},
  legend: { orientation: "h",y:1.1},
  width: 600,
  height: 450,
};

var config = {locale: 'en'};
Plotly.newPlot('blocking_{{case}}', data, layout, config);
</script>

{% endfor %}
</div>
