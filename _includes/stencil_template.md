{% include header.html %}

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
## Stencil Properties

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


Benchmark raw data can be found [in the git repository](https://github.com/RRZE-HPC/stempel_data_collection/tree/master/stencils/{{page.dimension}}/{{page.radius}}/{{page.weighting}}/{{page.kind}}/{{page.coefficients}}/{{page.datatype}}/{{page.machine}}/).

If you have feedback, issues or found errors on this page: please [submit an issue on the github page](https://github.com/RRZE-HPC/stempel_data_collection/issues/new) and include the stencil type:

```
{{page.dimension}}/{{page.radius}}/{{page.weighting}}/{{page.kind}}/{{page.coefficients}}/{{page.datatype}}/{{page.machine}}{% assign flavor_size = {{page.flavor | size}} %}{% if flavor_size != 0 %}/{{page.flavor}}{% endif %}
```

{% if page.comment and page.comment != "" and page.comment != nil and page.comment != "EDIT_ME" %}
<div markdown="1">
<img src="{{site.baseurl}}/assets/img/male-avatar.svg" class="comment_bubble_img" />
<blockquote markdown="1" class="comment_bubble">
<!-- ## Comments -->
{{page.comment}}
</blockquote>
</div>

{% endif %}

</div>

<div markdown="1" class="section-block-half">
## Kernel Source Code

Show:
<input class="code-button" type="button" onclick="document.getElementById('c_source').style.display = 'block';document.getElementById('asm_source').style.display = 'none'" value="C Source Code" />
<input class="code-button" type="button" onclick="document.getElementById('asm_source').style.display = 'block';document.getElementById('c_source').style.display = 'none';" value="Assembly Code" />

<div markdown="1" id="c_source">
```c
{{source_code}}
```
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine].stencil_c %}
{% if com %}
{% include comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>

<div markdown="1" id="asm_source" style="display:none;">
```nasm
{{source_code_asm}}
```
</div>
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
- {{ lc | replace: ": ",": `" | replace: ";","`, that is	`" | append:"`" }}
{%- endif %}
{%- endfor %}

Have a look at the [kernel source code](#kernel-source-code) for dimension naming.

<!--
grep "\[[a-z]" stencil.c | sed -r 's/([A-Z])\[([0-9]*)\]/\1\2/g' | sed 's/.* =//;s/ c[0-9]* //;s/[ijk]//g;s/(//g;s/)//g;s/+ /,/g;s/\* /,/g;s/\[\]/\[0\]/g;s/+,/,/;s/[[:space:]]//g;s/[a-Z][0-9]*/\"&\":/g;s/\]\[/,/g' | tr -d '\n'
-->

<!-- <script>
function get_url() {
var jsonstr='{"dimensions":3,"arrays":{"type":"double","bytes_per_element":8,"dimension":[1024,1024,1024]},"accesses":{"a":[0,0,0],"a":[-1,-1,-1],"a":[0,-1,-1],"a":[+1,-1,-1],"a":[-1,0,-1],"a":[0,0,-1],"a":[+1,0,-1],"a":[-1,+1,-1],"a":[0,+1,-1],"a":[+1,+1,-1],"a":[-1,-1,0],"a":[0,-1,0],"a":[+1,-1,0],"a":[-1,0,0],"a":[+1,0,0],"a":[-1,+1,0],"a":[0,+1,0],"a":[+1,+1,0],"a":[-1,-1,+1],"a":[0,-1,+1],"a":[+1,-1,+1],"a":[-1,0,+1],"a":[0,0,+1],"a":[+1,0,+1],"a":[-1,+1,+1],"a":[0,+1,+1],"a":[+1,+1,+1]},"cache_sizes":{"L1":{"size":32768,"cores":1,"available":32768},"L2":{"size":262144,"cores":1,"available":262144},"L3":{"size":20971520,"cores":1,"available":20971520}},"safety_margin":2}'
return "https://rrze-hpc.github.io/layer-condition/#calculator%23!"+encodeURIComponent(JSON.stringify(jsonstr));
}
</script>

<a href='get_url()'>Layer Condition website</a> -->
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
## Single Core Grid Scaling

<div markdown="1" class="section-block-half">
### ECM Prediction vs. Performance

View data for:
<input class="plot-button" type="button" value="Layer Condition"
  onclick="document.getElementById('ecm_LC').style.display = 'block';
           document.getElementById('ecm_CS').style.display = 'none';
           document.getElementById('ecm_Pheno').style.display = 'none';" />
<input class="plot-button" type="button" value="Cache Simulation"
  onclick="document.getElementById('ecm_CS').style.display = 'block';
           document.getElementById('ecm_LC').style.display = 'none';
           document.getElementById('ecm_Pheno').style.display = 'none';" />
<input class="plot-button" type="button" value="Phenomenological"
  onclick="document.getElementById('ecm_Pheno').style.display = 'block';
           document.getElementById('ecm_CS').style.display = 'none';
           document.getElementById('ecm_LC').style.display = 'none';" />

<div  markdown="1" id="ecm_LC">
<object data="./ecm_LC.svg" type="image/svg+xml"></object>
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Layer Conditions](https://rrze-hpc.github.io/layer-condition/) to model the cache behavior. The calculated [layer conditions](#layer-conditions) shown above correspond to the jumps in the ECM prediction in this plot.*
</div>

<div  markdown="1" id="ecm_CS" style="display:none;">
<object data="./ecm_CS.svg" type="image/svg+xml"></object>
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Cache Simulation](https://github.com/RRZE-HPC/pycachesim) to model the cache behavior.*
</div>

<div  markdown="1" id="ecm_Pheno" style="display:none;">
<object data="./ecm_Pheno.svg" type="image/svg+xml"></object>
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the phenomenological [ECM Performance Model](https://hpc.fau.de/research/ecm/) measured with [kerncraft](https://github.com/RRZE-HPC/kerncraft). The phenomenological ECM Model is completely derived from performance counter measurements during benchmark execution.*
</div>

</div>

<div markdown="1" class="section-block-half">
### Stencil Performance

View data for:
<input class="plot-button" type="button" value="Layer Condition"
  onclick="document.getElementById('rfl_LC').style.display = 'block';
           document.getElementById('rfl_CS').style.display = 'none';" />
<input class="plot-button" type="button" value="Cache Simulation"
  onclick="document.getElementById('rfl_CS').style.display = 'block';
           document.getElementById('rfl_LC').style.display = 'none';" />

<object data="./roofline_LC.svg" type="image/svg+xml" id="rfl_LC"></object>
<object data="./roofline_CS.svg" type="image/svg+xml" id="rfl_CS" style="display:none;"></object>

*Performance plot with [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) in comparison with the measured stencil performance. For comparison the according ECM prediction is also included.*
</div>

</div>

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
<!-- ### Memory Transfers between Caches and Memory -->
### Data Transfers between Caches

View data for:
<input class="plot-button" type="button" value="Layer Condition"
  onclick="document.getElementById('mem_LC').style.display = 'block';
           document.getElementById('mem_CS').style.display = 'none';" />
<input class="plot-button" type="button" value="Cache Simulation"
  onclick="document.getElementById('mem_CS').style.display = 'block';
           document.getElementById('mem_LC').style.display = 'none';" />

<object data="./memory_LC.svg" type="image/svg+xml" id="mem_LC"></object>
<object data="./memory_CS.svg" type="image/svg+xml" id="mem_CS" style="display:none;"></object>

*Data transfers between the different cache levels and main memory. The shown data for each level contains evicted and loaded data. The measured data is represented by points and the predicted transfer rates by [kerncraft](https://github.com/RRZE-HPC/kerncraft) by lines.*
</div>

</div>


<div markdown="1" class="section-block-full">

{%- assign scaling_size = {{page.scaling | size}} -%}
{%- if scaling_size != 0 -%}

<div markdown="1" class="section-block-half">
## Multi Core Thread Scaling

{% if scaling_size > 0 %}
{% capture hidescaling %}{% for item in page.scaling %}document.getElementById('scaling_{{ item }}').style.display = 'none';{% endfor %}{% endcapture %}
{% if scaling_size > 1 %}Choose grid size: {%- endif -%}{%- for item in page.scaling -%}
<input class="plot-button" type="button" onclick="{{hidescaling}}document.getElementById('scaling_{{ item }}').style.display = 'block';" value="{{item}}³" />
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
## Single Core Spatial Blocking

{% if blocking_size > 0 %}
{% capture hideblocking %}{% for item in page.blocking %}document.getElementById('blocking_{{ item }}').style.display = 'none';{% endfor %}{% endcapture %}
{% if blocking_size > 1 %}Choose blocking option: {%- endif -%}{%- for item in page.blocking -%}
<input class="plot-button" type="button" onclick="{{hideblocking}}document.getElementById('blocking_{{ item }}').style.display = 'block';" value="{{item}}" />
{%- endfor -%}
{% endif %}

{% for item in page.blocking %}
{%- if forloop.first -%}
<object data="./blocking_{{ item }}.svg" class="blocking" id="blocking_{{ item }}" style="display:block;" type="image/svg+xml"></object>
{%- else -%}
<object data="./blocking_{{ item }}.svg" class="blocking" id="blocking_{{ item }}" style="display:none;" type="image/svg+xml"></object>
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
kerncraft -p ECM -p RooflineIACA -p Benchmark -P LC -m {{page.machine}}.yml stencil.c -D N $GRID_SIZE -D M $GRID_SIZE -D P $GRID_SIZE -vvv --cores $CORES --compiler icc
```

The roofline prediction can be obtained with [kerncraft](https://github.com/RRZE-HPC/kerncraft) and the [generated stencil](#how-to-test-this-stencil):
```bash
kerncraft -p RooflineIACA -P LC -m {{page.machine}}.yml stencil.c -D N $GRID_SIZE -D M $GRID_SIZE -D P $GRID_SIZE -vvv --cores ${threads} --compiler icc
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
