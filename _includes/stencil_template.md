{% include header.html %}

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
## Stencil Properties

|              |                       |
|--------------|----------------------:|
| dimension    | {{page.dimension}}    |
| radius       | {{page.radius}}       |
| weighting    | {{page.weighting}}    |
| kind         | {{page.kind}}         |
| coefficients | {{page.coefficients}} |
| datatype     | {{page.datatype}}     |
| machine      | [{{page.machine}}](https://github.com/RRZE-HPC/stempel_data_collection/blob/master/machine_files/{{page.machine}}.yml) |
{% assign flop_size = {{page.flop | size}} %}{% if flop_size != 0 %}| FLOP per LUP       | {{page.flop}}       |{% endif %}
{% assign flavor_size = {{page.flavor | size}} %}{% if flavor_size != 0 %}| flavor       | {{page.flavor}}       |{% endif %}

{% if page.comment and page.comment != "" and page.comment != nil %}
## Comments

{{page.comment}}
{% endif %}

</div>

<div markdown="1" class="section-block-half">
## Kernel Source Code

```c
{{source_code}}
```
</div>

</div>

<div markdown="1" class="section-block-full">


<div markdown="1" class="section-block-half">
{% if layercondition %}
## Layer Conditions

{% assign lc_split = layercondition | newline_to_br | split: '<br />' %}
{%- for lc in lc_split -%}
{% if forloop.index0 == 0 or forloop.index0 == 3 or forloop.index0 == 6 %}

#### {{ forloop.index0 | divided_by:3 | plus:1 }}D Layer Condition:
{% endif %}
{%- if lc contains "fulfilled" %}
- {{lc}}
{%- else %}
- {{ lc | replace: ": ",": `" | replace: ";","`, that is	`~" | append:"`" }}
{%- endif %}
{%- endfor %}

Have a look at the kernel source code below for dimension naming.
{% endif %}
</div>


<div markdown="1" class="section-block-half">
## How to test this stencil

Generate this stencil with:
```bash
stempel gen -D {{ page.dimension | remove: 'D'}} -r {{ page.radius | remove: 'r'}} -t {{ page.datatype }} -C {{ page.coefficients }} -k {{ page.kind }} {% if page.weighting == 'isotropic' %}-i{% elsif page.weighting == 'heterogeneous' %}-e{% elsif page.weighting == 'homogeneous' %}-o{% elsif page.weighting == 'point-symmetric' %}-p{% endif %} --store stencil.c
```

and generate the compilable benchmark code with:
```bash
stempel bench stencil.c -m {{ page.machine }}.yml --store
```

## Compiler flags
```bash
{{page.compile_flags}}
```
</div>

</div>

<div markdown="1" class="section-block-full">
## Single Core Benchmark Data
<script>
var index = 0;
function changeSingleCore() {
	var button = document.getElementById('plot-button');
  var ecmLC = document.getElementById('ecm_LC');
  var ecmCS = document.getElementById('ecm_CS');
  var rflLC = document.getElementById('rfl_LC');
  var rflCS = document.getElementById('rfl_CS');
  var memLC = document.getElementById('mem_LC');
  var memCS = document.getElementById('mem_CS');
  if (index == 0) {
     index = 1;
     ecmLC.style.display = 'none';
     rflLC.style.display = 'none';
     memLC.style.display = 'none';
     ecmCS.style.display = 'block';
     rflCS.style.display = 'block';
     memCS.style.display = 'block';
     button.value = "Showing Cache Simulator Data. Click to switch to Layer Condition Data."
  } else if (index == 1) {
     index = 0;
     ecmLC.style.display = 'block';
     rflLC.style.display = 'block';
     memLC.style.display = 'block';
     ecmCS.style.display = 'none';
     rflCS.style.display = 'none';
     memCS.style.display = 'none';
     button.value = "Showing Layer Condition Data. Click to switch to Cache Simulator Data."
  }
}
</script>

<div markdown="1" class="section-block-half">
### ECM Prediction vs. Performance
<object data="./ecm_LC.svg" id="ecm_LC" type="image/svg+xml"></object>
<object data="./ecm_CS.svg" type="image/svg+xml" id="ecm_CS" style="display:none;"></object>
*ECM plot of the measured benchmark results and the (stacked) ECM contributions predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft). The calculated [layer conditions](#layer-conditions) correspond to the jumps in the ECM prediction.*
</div>

<div markdown="1" class="section-block-half">
### Stencil Performance
<object data="./roofline_LC.svg" id="rfl_LC" type="image/svg+xml"></object>
<object data="./roofline_CS.svg" type="image/svg+xml" id="rfl_CS" style="display:none;"></object>
*Performance plot with roofline prediction in comparison with the measured benchmark data. For comparison the according ECM prediction is also included.*
</div>

</div>

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
### Memory Transfers between Caches and Memory
<object data="./memory_LC.svg" id="mem_LC" type="image/svg+xml"></object>
<object data="./memory_CS.svg" type="image/svg+xml" id="mem_CS" style="display:none;"></object>
*Data transfers between the different cache levels and main memory. The shown data for each level contains evicted and loaded data. The measured data is represented by points and the predicted transfer rates by [kerncraft](https://github.com/RRZE-HPC/kerncraft) by lines.*
</div>

<div markdown="1" class="section-block-half">

<input id="plot-button" type="button" onclick="changeSingleCore()" value="Showing Layer Condition Data. Click to switch to Cache Simulator Data." />

Benchmark raw data can be found [in the git repository](https://github.com/RRZE-HPC/stempel_data_collection/blob/master/stencils/{{page.dimension}}/{{page.radius}}/{{page.weighting}}/{{page.kind}}/{{page.coefficients}}/{{page.datatype}}/{{page.machine}}/results.csv).
</div>

</div>


<div markdown="1" class="section-block-full">

{%- assign scaling_size = {{page.scaling | size}} -%}
{%- if scaling_size != 0 -%}

<div markdown="1" class="section-block-half">
## Thread Scaling Performance

{% if scaling_size > 1 %}
{% capture hidescaling %}{% for item in page.scaling %}document.getElementById('scaling_{{ item }}').style.display = 'none';{% endfor %}{% endcapture %}
Choose grid size: {%- for item in page.scaling -%}
<input id="plot-button" type="button" onclick="{{hidescaling}}document.getElementById('scaling_{{ item }}').style.display = 'block';" value="{{item}}³" />
{%- endfor -%}
{% endif %}

{% for item in page.scaling %}
{%- if forloop.first -%}
<object data="./scaling_{{item}}.svg" class="scaling" id="scaling_{{ item }}" style="display:block;" type="image/svg+xml"></object>
{%- else -%}
<object data="./scaling_{{item}}.svg" class="scaling" id="scaling_{{ item }}" style="display:none;" type="image/svg+xml"></object>
{%- endif -%}
{% endfor %}
</div>
{% endif %}

{%- assign blocking_size = {{page.blocking | size}} -%}
{%- if blocking_size != 0 -%}
<div markdown="1" class="section-block-half">
## Spatial Blocking Performance

{% if blocking_size > 1 %}
{% capture hideblocking %}{% for item in page.blocking %}document.getElementById('blocking_{{ item }}').style.display = 'none';{% endfor %}{% endcapture %}
Choose grid size: {%- for item in page.blocking -%}
<input id="plot-button" type="button" onclick="{{hideblocking}}document.getElementById('blocking_{{ item }}').style.display = 'block';" value="{{item}}³" />
{%- endfor -%}
{% endif %}

{% for item in page.blocking %}
{%- if forloop.first -%}
<object data="./ecm_LC.svg" class="blocking" id="blocking_{{ item }}" style="display:block;" type="image/svg+xml"></object>
{%- else -%}
<object data="./ecm_LC.svg" class="blocking" id="blocking_{{ item }}" style="display:none;" type="image/svg+xml"></object>
{%- endif -%}
{% endfor %}
</div>
{% endif %}

</div>

<div markdown="1" class="section-block-full">
## How to replicate this data

<div markdown="1" class="section-block-half">
### Single Core Measurements

Using the [generated stencil](#how-to-test-this-stencil) and [kerncraft](https://github.com/RRZE-HPC/kerncraft), all single core performance data shown on this page can be reproduced by:

#### Layer Condition Data
```bash
kerncraft -p ECM -p RooflineIACA -p Benchmark -p LC -P LC -m {{page.machine}}.yml stencil.c -D N $GRID_SIZE -D M $GRID_SIZE -D P $GRID_SIZE -vvv --cores 1 --compiler icc
```

#### Cache Simulator Data
```bash
kerncraft -p ECM -p RooflineIACA -p Benchmark -p LC -P CS -m {{page.machine}}.yml stencil.c -D N $GRID_SIZE -D M $GRID_SIZE -D P $GRID_SIZE -vvv --cores 1 --compiler icc
```
</div>

<div markdown="1" class="section-block-half">
### Thread Scaling Measurements

The [generated benchmark code](#how-to-test-this-stencil) can be used to reproduce the thread scaling data shown on this page by:
```bash
OMP_NUM_THREADS=$THREADS likwid-pin -C S0:0-$(bc -l <<< "$THREADS - 1") ./stencil $GRID_SIZE $GRID_SIZE $GRID_SIZE
```

The roofline prediction can be obtained with [kerncraft](https://github.com/RRZE-HPC/kerncraft) and the [generated stencil](#how-to-test-this-stencil):
```bash
kerncraft -p RooflineIACA -P LC -m {{page.machine}}.yml stencil.c -D N ${size} -D M ${size} -D P ${size} -vvv --cores ${threads} --compiler icc
```
</div>

<div markdown="1" class="section-block-half">
### Spatial Blocking Measurements

Generate benchmark code from the [stencil](#how-to-test-this-stencil) with blocking and compile it as shown before:
```bash
stempel bench stencil.c -m {{ page.machine }}.yml -b 2 --store
```

```bash
OMP_NUM_THREADS=1 likwid-pin -C S0:0 ./stencil $GRID_SIZE $GRID_SIZE $GRID_SIZE $BLOCKING_M $BLOCKING_N $BLOCKING_P
```
</div>

</div>
