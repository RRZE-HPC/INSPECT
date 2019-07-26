{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="scaling" {{hide_if_hidden}} >

{% if page.stencil_name %}
  {% capture csv_filename %}{{page.stencil_name}}_{{page.machine}}_scaling{% endcapture %}
{% else %}
  {% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_scaling{% endcapture %}
{% endif %}

{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

<div id="scaling"></div>

{% assign cores = "" %}
{% assign bench = "" %}
{% assign ecm = "" %}
{% assign roofline = "" %}

{% for data in csv_file %}
  {% assign cores = data.threads | append: ',' | prepend: cores %}
  {% assign bench = data["Mlup/s"] | append: ',' | prepend: bench %}
  {% assign roofline = data["Mlup/s (Roofline)"] | append: ',' | prepend: roofline %}
  {% assign ecm = data["MLUP/s (ECM)"] | append: ',' | prepend: ecm %}

  {%if forloop.last%}
    {% assign lasttick = data.threads %}
  {%endif%}
{% endfor %}

<script>
var trace_benchmark = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{cores}}],
  y: [{{bench}}],
  line: {color: 'black'},
  name: "Benchmark"
};
var trace_ecm = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{ecm}}],
  line: {color: '#ff7f0e'},
  name: "ECM LC Prediction"
};
var trace_roofline = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{roofline}}],
  line: {color: '#1f77b4'},
  name: "Roofline LC Prediction"
};

var data = [trace_benchmark,trace_ecm,trace_roofline];

var layout = {
	xaxis: {title: 'Number of Threads',
          range: [0.5,{{lasttick}}.5],
          nticks: {{lasttick}}},
	yaxis: {title: 'Performance [MLUP/s]',
          rangemode: "tozero"},
  margin: { l: 50, r: 35, t: 10, b: 40},
  legend: { orientation: "h",
            y:1.1 },
  width: 600,
  height: 450,
};

var config = {locale: 'en'};
Plotly.newPlot('scaling', data, layout, config);
</script>
</div>
