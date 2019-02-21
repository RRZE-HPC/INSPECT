{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="roofline" id="rfl_{{include.type}}" style="width:600px;" {{hide_if_hidden}} >

{% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% capture name %}Roofline LC MLUPs{% endcapture %}
{% capture N %}{% for data in csv_file %}{{data["N^3"]}},{%endfor%}{% endcapture %}
{% capture bench %}{% for data in csv_file %}{{data["Benchmark MLUPs"]}},{%endfor%}{% endcapture %}
{% capture roofline_LC %}{% for data in csv_file %}{{data["Roofline LC MLUPs"]}},{%endfor%}{% endcapture %}
{% capture roofline_CS %}{% for data in csv_file %}{{data["Roofline CS MLUPs"]}},{%endfor%}{% endcapture %}
{% capture ecm %}{% for data in csv_file %}{{data["Roofline ECM MLUPs"]}},{%endfor%}{% endcapture %}

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
var trace_roofline = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{roofline_LC}}{% elsif include.type == 'CS' %}{{roofline_CS}}{% endif %}],
  line: {color: '#1f77b4'},
  name: "Roofline prediction with {{include.type}}"
};
var trace_ecm = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{{ecm}}],
  line: {color: '#ff7f0e'},
  name: "ECM prediction with {{include.type}}"
};

var data = [trace_roofline,trace_ecm,trace_benchmark];

var layout = {
	xaxis: {title: "Grid Size (N^{{page.dimension | replace: 'D', ''}})",
          rangemode: "tozero"},
	yaxis: {title: 'Performance [MLUP/s]',
          rangemode: "tozero"},
  margin: { l: 50, r: 35, t: 10, b: 40},
  legend: { orientation: "h",y:1.1},
};

var config = {locale: 'en'};
Plotly.newPlot('rfl_{{include.type}}', data, layout, config);
</script>

*Performance plot with [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) in comparison with the measured stencil performance. For comparison the according ECM prediction is also included.*

{% if include.type == 'LC' %}
	{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["roofline_{{include.type}}.svg"] %}
{% else if include.type == 'CS' %}
	{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["roofline_{{include.type}}.svg"] %}
{% endif %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
