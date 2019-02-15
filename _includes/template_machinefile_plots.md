{% capture cores %}{% for data in include.dataset.cores%}{{data}},{%endfor%}{% endcapture %}

{% capture load %}{% for data in include.dataset.results.load%}{{data | replace: ' GB/s', ''}},{%endfor%}{% endcapture %}

{% capture update %}{% for data in include.dataset.results.update%}{{data | replace: ' GB/s', ''}},{%endfor%}{% endcapture %}

{% capture daxpy %}{% for data in include.dataset.results.daxpy%}{{data | replace: ' GB/s', ''}},{%endfor%}{% endcapture %}

{% capture copy %}{% for data in include.dataset.results.copy%}{{data | replace: ' GB/s', ''}},{%endfor%}{% endcapture %}

{% capture triad %}{% for data in include.dataset.results.triad%}{{data | replace: ' GB/s', ''}},{%endfor%}{% endcapture %}

<script>
var trace_load = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{load}}],
  line: {color: 'orange'},
  name: "load"
};

var trace_update = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{update}}],
  line: {color: 'red'},
  name: "update"
};

var trace_daxpy = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{daxpy}}],
  line: {color: 'blue'},
  name: "daxpy"
};

var trace_copy = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{copy}}],
  line: {color: 'green'},
  name: "copy"
};

var trace_triad = {
  type: "scatter",
  mode: "lines",
  x: [{{cores}}],
  y: [{{triad}}],
  line: {color: 'yellow'},
  name: "triad"
};

var data = [trace_load,trace_update,trace_daxpy,trace_copy,trace_triad];

var layout = {
	title: '{{include.title}}',
	xaxis: {title: '{{include.xaxis}}',
          nticks: {{include.dataset.cores | last}}},
	yaxis: {title: '{{include.yaxis}}'},
};

var config = {locale: 'en'};
Plotly.newPlot({{include.div}}, data, layout, config);
</script>
