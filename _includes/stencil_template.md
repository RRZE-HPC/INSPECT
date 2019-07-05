<script src="{{site.baseurl}}/assets/js/plotly-latest.min.js"></script>

{% assign comments = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine] %}

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
## Stencil Properties

{% capture machinefile_link %}[{{page.machine}}]({{site.baseurl}}/machines/{{page.machine}}){% endcapture %}

{%- assign flop_size = {{page.flop | size}} -%}
{%- assign flavor_size = {{page.flavor | size}} -%}

|--------------|-------------------------------:|
{%- if page.stencil_name %}
| name         | {{page.stencil_name}}          |
{%- endif -%}
{%- if page.dimension    %}
| dimension    | {{page.dimension}}             |
{%- endif -%}
{%- if page.radius       %}
| radius       | {{page.radius | remove: 'r' }} |
{%- endif -%}
{%- if page.weighting    %}
| weighting    | {{page.weighting}}             |
{%- endif -%}
{%- if page.kind         %}
| kind         | {{page.kind}}                  |
{%- endif -%}
{%- if page.coefficients %}
| coefficients | {{page.coefficients}}          |
{%- endif -%}
{%- if page.datatype     %}
| datatype     | {{page.datatype}}              |
{%- endif -%}
{%- if page.machine      %}
| machine      | {{machinefile_link}}           |
{%- endif -%}
{%- if flop_size != 0 %}
| FLOP per LUP | {{page.flop}}                  |
{%- endif -%}
{%- if flavor_size != 0 %}
| flavor       | {{page.flavor}}                |
{%- endif -%}

{% assign com = comments["general"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}

{% assign com = site.data.comments.machine_files[page.machine] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=True %}
{% endif %}

Benchmark raw data shown on this page can be found in the [according folder of the git repository](https://github.com/RRZE-HPC/stempel_data_collection/tree/master/stencils/{{page.dimension}}/{{page.radius}}/{{page.weighting}}/{{page.kind}}/{{page.coefficients}}/{{page.datatype}}/{{page.machine}}/).

If you have feedback, issues or found errors on this page, please [submit an issue on the github page](
https://github.com/RRZE-HPC/stempel_data_collection/issues/new?labels[]=Stencil%20Comment%20Management&labels[]=[Type]%20Bug&title=Stencil%20Comment&milestone=People%20Management:%20m6&assignee=ebinnion&body=Stencil:%20{{page.dimension}}%20{{page.radius}}%20{{page.weighting}}%20{{page.kind}}%20{{page.coefficients}}%20{{page.datatype}}%20{{page.machine}}{% assign flavor_size = {{page.flavor | size}} %}{% if flavor_size != 0 %}%20{{page.flavor}}{% endif %}).

</div>

<div markdown="1" class="section-block-half">
## Kernel Source Code

<input class="code-button" type="button" onclick="document.getElementById('c_source').style.display = 'block';document.getElementById('asm_source').style.display = 'none';document.getElementById('iaca').style.display = 'none'" value="C Source Code" />
<input class="code-button" type="button" onclick="document.getElementById('asm_source').style.display = 'block';document.getElementById('c_source').style.display = 'none';document.getElementById('iaca').style.display = 'none'" value="Assembly Code" />

<div markdown="1" id="c_source">
```c
{{source_code}}
```
</div>

<div markdown="1" id="asm_source" style="display:none;">
```nasm
{{source_code_asm}}
```
</div>

{% assign com = comments["stencil"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}
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
{% endif %}
{% if layer_condition %}
## Layer Conditions
{{layer_condition}}
{% endif %}

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

{% include template_ecm_plots.md %}

{% assign com = comments["grid_scaling"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}

</div>

<div markdown="1" class="section-block-half">
### Data Transfers between Caches

<input class="plot-button" type="button" value="Layer Condition"
  onclick="document.getElementById('mem_LC').style.display = 'block';
           document.getElementById('mem_CS').style.display = 'none';" />
<input class="plot-button" type="button" value="Cache Simulation"
  onclick="document.getElementById('mem_CS').style.display = 'block';
           document.getElementById('mem_LC').style.display = 'none';" />

{% include template_mem_plots.md type='LC' hidden='false' %}
{% include template_mem_plots.md type='CS' hidden='true' %}

{% assign com = comments["data_transfers"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}
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
    {% include template_threadscaling_plots.md type=item hidden='false' %}
  {%- else -%}
    {% include template_threadscaling_plots.md type=item hidden='true' %}
  {%- endif -%}
{% endfor %}

{% assign com = comments["thread_scaling"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}

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
    {% include template_blocking_plots.md type=item hidden='false' %}
  {%- else -%}
    {% include template_blocking_plots.md type=item hidden='true' %}
  {%- endif -%}
{% endfor %}

{% assign com = comments["spatial_blocking"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}

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

{% if iaca %}
<div markdown="1" class="section-block-full">
## IACA Output

<div markdown="1" class="section-block-half">
{% assign com = comments["iaca"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}
</div>
</div>

<div markdown="1" id="iaca" class="section-block-full">

```text
{{iaca}}
```
</div>
{% endif %}

{% if hostinfo %}
<div markdown="1" class="section-block-full">
## System Information

<div markdown="1" class="section-block-half">
{% assign com = comments["system_info"] %}
{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=comments.uptodate %}
{% endif %}
</div>
</div>

<div markdown="1" id="iaca" class="section-block-full">

```text
{{hostinfo}}
```
</div>
{% endif %}

</div>
