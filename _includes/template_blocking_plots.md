{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="blocking" {{hide_if_hidden}} >

{% for case in page.blocking %}

{% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_blocking_{{case}}{% endcapture %}
{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% capture csv_results_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% assign csv_results_file = site.data.stencils[{{csv_results_filename}}] %}

<div id="blocking_{{case}}"></div>

{% capture N %}{% for data in csv_file %}{{data.N}},{%endfor%}{% endcapture %}
{% capture bench_block %}{% for data in csv_file %}{{data["Mlup/s"]}},{%endfor%}{% endcapture %}
{% capture nticks %}{% for data in csv_file %}{%if forloop.last%}{{data.N}}{%endif%}{%endfor%}{% endcapture %}

{% capture bench %}{% for data in csv_results_file %}{{data["Benchmark MLUPs"]}},{%endfor%}{% endcapture %}
{% capture roofline_LC %}{% for data in csv_results_file %}{{data["Roofline LC MLUPs"]}},{%endfor%}{% endcapture %}
{% capture ecm %}{% for data in csv_results_file %}{{data["Roofline ECM MLUPs"]}},{%endfor%}{% endcapture %}

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

{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["blocking_{{include.type}}.svg"] %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
