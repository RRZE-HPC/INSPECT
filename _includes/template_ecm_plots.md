
{% if page.stencil_name %}
  {% capture csv_filename %}{{page.stencil_name}}_{{page.machine}}_results{% endcapture %}
{% else %}
  {% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% endif %}

{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% assign m_file = site.data.machine_files[{{page.machine}}] %}
{% capture clock %}{{m_file.clock | replace: " GHz", "" | replace: ".","" | times: 800 }}{% endcapture %}

{% capture overlaps %}{% for level in m_file["memory hierarchy"] %}{{level["transfers overlap"]}},{% endfor %}{% endcapture %}
{% assign overlap=overlaps | split: "," %}

{% for data in csv_file %}
  {% assign N = data["N^3"] | append: ',' | prepend: N %}
  {% assign bench = data["Benchmark cycl"] | append: ',' | prepend: bench %}

  {% assign LC_Tol = data["ECM LC Tol"] | append: ',' | prepend: LC_Tol %}
  {% assign LC_Tnol = data["ECM LC Tnol"] | append: ',' | prepend: LC_Tnol %}
  {% assign LC_Tl1l2 = data["ECM LC Tl1l2"] | append: ',' | prepend: LC_Tl1l2 %}
  {% assign LC_Tl2l3 = data["ECM LC Tl2l3"] | append: ',' | prepend: LC_Tl2l3 %}
  {% assign LC_Tl3mem = data["ECM LC Tl3mem"] | append: ',' | prepend: LC_Tl3mem %}
  {% assign LC_total = data["ECM LC cycl"] | append: ',' | prepend: LC_total %}

  {% assign CS_Tol = data["ECM CS Tol"] | append: ',' | prepend: CS_Tol %}
  {% assign CS_Tnol = data["ECM CS Tnol"] | append: ',' | prepend: CS_Tnol %}
  {% assign CS_Tl1l2 = data["ECM CS Tl1l2"] | append: ',' | prepend: CS_Tl1l2 %}
  {% assign CS_Tl2l3 = data["ECM CS Tl2l3"] | append: ',' | prepend: CS_Tl2l3 %}
  {% assign CS_Tl3mem = data["ECM CS Tl3mem"] | append: ',' | prepend: CS_Tl3mem %}
  {% assign CS_total = data["ECM CS cycl"] | append: ',' | prepend: CS_total %}

  {% assign Pheno_Tol = data["Benchmark Pheno Tol"] | append: ',' | prepend: Pheno_Tol %}
  {% assign Pheno_Tnol = data["Benchmark Pheno Tnol"] | append: ',' | prepend: Pheno_Tnol %}
  {% assign Pheno_Tl1l2 = data["Benchmark Pheno Tl1l2"] | append: ',' | prepend: Pheno_Tl1l2 %}
  {% assign Pheno_Tl2l3 = data["Benchmark Pheno Tl2l3"] | append: ',' | prepend: Pheno_Tl2l3 %}
  {% assign Pheno_Tl3mem = data["Benchmark Pheno Tl3mem"] | append: ',' | prepend: Pheno_Tl3mem %}
  {% assign Pheno_total = data["Benchmark Pheno cycl"] | append: ',' | prepend: Pheno_total %}

  {% if data["Roofline LC cycl"] != nil %}
    {% assign roofline_LC = data["Roofline LC cycl"] | append: ',' | prepend: roofline_LC %}
  {% elsif data["Roofline LC MLUPs"] %}
    {% assign roofline_LC = clock | append: '/' | append: data["Roofline LC MLUPs"] | append: ',' | prepend: roofline_LC %}
  {% else %}
    {% assign roofline_CS = ',' | prepend: roofline_CS %}
  {%endif%}

  {% if data["Roofline CS cycl"] %}
    {% assign roofline_CS = data["Roofline CS cycl"] | append: ',' | prepend: roofline_CS %}
  {% elsif data["Roofline CS MLUPs"] %}
    {% assign roofline_CS = clock | append: '/' | append: data["Roofline CS MLUPs"] | append: ',' | prepend: roofline_CS %}
  {% else %}
  {% assign roofline_CS = ',' | prepend: roofline_CS %}
  {%endif%}
{% endfor %}

<div  markdown="1" class="ecm" id="ecm_LC" >
*Comparison of the measured stencil performance (in cycles per cache line), [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Layer Conditions](https://rrze-hpc.github.io/layer-condition/) to model the cache behavior. The calculated [layer conditions](#layer-conditions) shown above correspond to the jumps in the ECM prediction in this plot.*
</div>

<div  markdown="1" class="ecm" id="ecm_CS" style="display:none;" >
*Comparison of the measured stencil performance (in cycles per cache line), [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Cache Simulation](https://github.com/RRZE-HPC/pycachesim) to model the cache behavior.*
</div>

<div  markdown="1" class="ecm" id="ecm_Pheno" style="display:none;" >
*Comparison of the measured stencil performance (in cycles per cache line), [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) and the (stacked) contributions of the phenomenological [ECM Performance Model](https://hpc.fau.de/research/ecm/) measured with [kerncraft](https://github.com/RRZE-HPC/kerncraft). The phenomenological ECM Model is completely derived from performance counter measurements during benchmark execution.*
</div>

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

{% for i in (1..2) %}
{% if i == 1 %}
{% assign script_name = "LC" %}
{% assign script_data_RFL = roofline_LC %}
{% elsif i == 2 %}
{% assign script_name = "CS" %}
{% assign script_data_RFL = roofline_CS %}
{% endif %}

var trace_roofline_{{script_name}} = {
  type: "scatter",
  mode: "lines+markers",
  marker: { symbol: "circle-open", maxdisplayed: 5 },
  x: [{{N}}],
  y: [{{script_data_RFL}}],
  line: {color: 'green'},
  name: "Roofline /w {{script_name}}",
};
{% endfor %}

{% for i in (1..3) %}
{% if i == 1 %}
{% assign script_name = "LC" %}
{% assign script_data_Tol = LC_Tol %}
{% assign script_data_Tnol = LC_Tnol %}
{% assign script_data_Tl1l2 = LC_Tl1l2 %}
{% assign script_data_Tl2l3 = LC_Tl2l3 %}
{% assign script_data_Tl3mem = LC_Tl3mem %}
{% assign script_data_Ttotal = LC_total %}
{% elsif i == 2 %}
{% assign script_name = "CS" %}
{% assign script_data_Tol = CS_Tol %}
{% assign script_data_Tnol = CS_Tnol %}
{% assign script_data_Tl1l2 = CS_Tl1l2 %}
{% assign script_data_Tl2l3 = CS_Tl2l3 %}
{% assign script_data_Tl3mem = CS_Tl3mem %}
{% assign script_data_Ttotal = CS_total %}
{% elsif i == 3 %}
{% assign script_name = "Pheno" %}
{% assign script_data_Tol = Pheno_Tol %}
{% assign script_data_Tnol = Pheno_Tnol %}
{% assign script_data_Tl1l2 = Pheno_Tl1l2 %}
{% assign script_data_Tl2l3 = Pheno_Tl2l3 %}
{% assign script_data_Tl3mem = Pheno_Tl3mem %}
{% assign script_data_Ttotal = '' %}
{% endif %}

var trace_Tol_{{script_name}} = {
  type: "scatter",
  mode: "lines+markers",
  marker: { symbol: "square-open", maxdisplayed: 5 },
  x: [{{N}}],
  y: [{{script_data_Tol}}],
  line: {color: '#d62728'},
  name: "T<sub>comp</sub>"
};
var trace_Tnol_{{script_name}} = {
  {%- if overlap[0] == "true" %}
  type: "scatter",
  mode: "lines+markers",
  marker: { symbol: "triangle-up-open", maxdisplayed: 5 },
  line: {color: '#1f77b4'},
  {%- else %}
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  marker: {color: '#1f77b4'},
  {% endif %}
  x: [{{N}}],
  y: [{{script_data_Tnol}}],
  name: "T<sub>Reg-L1</sub>"
};
var trace_Tl1l2_{{script_name}} = {
  {%- if overlap[1] == "true" %}
  type: "scatter",
  mode: "lines+markers",
  marker: { symbol: "triangle-down-open", maxdisplayed: 5 },
  line: {color: '#aec7e8'},
  {%- else %}
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  marker: {color: '#aec7e8'},
  {% endif %}
  x: [{{N}}],
  y: [{{script_data_Tl1l2}}],
  name: "T<sub>L1-L2</sub>"
};
var trace_Tl2l3_{{script_name}} = {
  {%- if overlap[2] == "true" %}
  type: "scatter",
  mode: "lines+markers",
  marker: { symbol: "hexagon-open", maxdisplayed: 5 },
  line: {color: '#ff7f0e'},
  {%- else %}
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  marker: {color: '#ff7f0e'},
  {% endif %}
  x: [{{N}}],
  y: [{{script_data_Tl2l3}}],
  name: "T<sub>L2-L3</sub>"
};
var trace_Tl3mem_{{script_name}} = {
  {%- if overlap[3] == "true" %}
  type: "scatter",
  mode: "lines+markers",
  marker: { symbol: "star-diamond-open", maxdisplayed: 5 },
  line: {color: '#ffbb78'},
  {%- else %}
  type: "histogram",
  xbins: {size:10},
  histfunc: "sum",
  marker: {color: '#ffbb78'},
  {% endif %}
  x: [{{N}}],
  y: [{{script_data_Tl3mem}}],
  name: "T<sub>L3-MEM</sub>"
};
var trace_Ttotal_{{script_name}} = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{{script_data_Ttotal}}],
  line: {color: 'rgba(0,0,0,0)'},
  showlegend: false,
  name: "T<sub>ECM total</sub>"
};
{% endfor %}

var data_LC = [trace_roofline_LC,trace_benchmark,trace_Tol_LC,trace_Tnol_LC,
               trace_Tl1l2_LC,trace_Tl2l3_LC,trace_Tl3mem_LC,trace_Ttotal_LC];
var data_CS = [trace_roofline_CS,trace_benchmark,trace_Tol_CS,trace_Tnol_CS,
               trace_Tl1l2_CS,trace_Tl2l3_CS,trace_Tl3mem_CS,trace_Ttotal_CS];
var data_Pheno = [trace_roofline_LC,trace_benchmark,trace_Tol_Pheno,trace_Tnol_Pheno,
                  trace_Tl1l2_Pheno,trace_Tl2l3_Pheno,trace_Tl3mem_Pheno];

var layout = {
  margin: { l: 40, r: 35, t: 10, b: 40},
  xaxis: {title: "Grid Size (N^(1/{{page.dimension | replace: 'D', ''}}))",
          dticks: 50,
          tick0: 0},
  yaxis: {title: 'Cycles / Cacheline',
          tick0: 0},
  barmode: 'stack',
  legend: { orientation: "h",y:1.1 },
  width: 600,
  height: 450,
};

var config = {locale: 'en'};
Plotly.newPlot('ecm_LC', data_LC, layout, config);
Plotly.newPlot('ecm_CS', data_CS, layout, config);
Plotly.newPlot('ecm_Pheno', data_Pheno, layout, config);
</script>
