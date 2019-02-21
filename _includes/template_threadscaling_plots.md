{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="scaling" {{hide_if_hidden}} >

{% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_scaling{% endcapture %}
{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

<div id="scaling"></div>

{% capture cores %}{% for data in csv_file %}{{data.threads}},{%endfor%}{% endcapture %}
{% capture bench %}{% for data in csv_file %}{{data["Mlup/s"]}},{%endfor%}{% endcapture %}
{% capture ecm %}{% for data in csv_file %}{{data["Mlup/s (Roofline)"]}},{%endfor%}{% endcapture %}
{% capture roofline %}{% for data in csv_file %}{{data["MLUP/s (ECM)"]}},{%endfor%}{% endcapture %}
{% capture lasttick %}{% for data in csv_file %}{%if forloop.last%}{{data.threads}}{%endif%}{%endfor%}{% endcapture %}

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

{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["scaling_{{include.type}}.svg"] %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
