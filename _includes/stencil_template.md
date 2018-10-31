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
## Benchmark Plots
<script>
var index = 0;
function changeImage() {
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
### ECM Plot
<span id="ecm_LC">
![ECM](./ecm_LC.svg){:width="100%"}
</span>
<span id="ecm_CS" style="display:none;">
![ECM](./ecm_CS.svg){:width="100%"}
</span>
*ECM plot of the measured benchmark results and the (stacked) ECM contributions predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft). The calculated [layer conditions](#layer-conditions) correspond to the jumps in the ECM prediction.*
</div>

<div markdown="1" class="section-block-half">
### Performance Plot
<span id="rfl_LC">
![Performance](./roofline_LC.svg){:width="100%"}
</span>
<span id="rfl_CS" style="display:none;">
![Performance](./roofline_CS.svg){:width="100%"}
</span>
*Performance plot with roofline prediction in comparison with the measured benchmark data. For comparison the according ECM prediction is also included.*
</div>

</div>

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
### Memory Transfer Plot
<span id="mem_LC">
![Memory LC](./memory_LC.svg){:width="100%"}
</span>
<span id="mem_CS" style="display:none;">
![Memory CS](./memory_CS.svg){:width="100%"}
</span>
*Data transfers between the different cache levels and main memory. The shown data for each level contains evicted and loaded data. The measured data is represented by points and the predicted transfer rates by [kerncraft](https://github.com/RRZE-HPC/kerncraft) by lines.*
</div>

<div markdown="1" class="section-block-half">

<input id="plot-button" type="button" onclick="changeImage()" value="Showing Layer Condition Data. Click to switch to Cache Simulator Data." />

Benchmark raw data can be found [in the git repository](https://github.com/RRZE-HPC/stempel_data_collection/blob/master/stencils/{{page.dimension}}/{{page.radius}}/{{page.weighting}}/{{page.kind}}/{{page.coefficients}}/{{page.datatype}}/{{page.machine}}/results.csv).
</div>

</div>
