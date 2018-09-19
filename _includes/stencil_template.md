{% include header.html %}

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">
## Stencil Properties

| property     | value            |
|--------------|-----------------:|
| dimension    | {{page.dimension}}    |
| radius       | {{page.radius}}       |
| weighting    | {{page.weighting}}    |
| kind         | {{page.kind}}         |
| coefficients | {{page.coefficients}} |
| datatype     | {{page.datatype}}     |
| machine      | [{{page.machine}}]({{site.baseurl}}/machine_files/{{page.machine}}.yml) |
{% assign flavor_size = {{page.flavor | size}} %}{% if flavor_size != 0 %}| flavor       | {{page.flavor}}       |{% endif %}

</div>

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

</div>

<div markdown="1" class="section-block-full">
## Performance Plots

<div markdown="1" class="section-block-half">
### ECM Plot
![ECM](./ecm.svg){:width="100%"}
*ECM plot of the measured benchmark results and the (stacked) ECM contributions predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft)*
</div>

<div markdown="1" class="section-block-half">
### Roofline Plot
![Roofline](./roofline.svg){:width="100%"}
*Roofline prediction in comparison with the measured benchmark data. For comparison the according ECM prediction is also included.*
</div>

<div markdown="1" class="section-block-half">
### Memory Transfer Plot
![Memory](./memory.svg){:width="100%"}
*Data transfers between the different cache levels and main memory. The shown data for each level contains _evicted and loaded_ data.*
</div>

<div markdown="1" class="section-block-half">
Benchmark raw data can be found [in the repository](https://github.com/RRZE-HPC/stempel_data_collection/blob/master/stencils/{{page.dimension}}/{{page.radius}}/{{page.weighting}}/{{page.kind}}/{{page.coefficients}}/{{page.datatype}}/{{page.machine}}/results.csv).
</div>

</div>

<div markdown="1" class="section-block-full">

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

<div markdown="1" class="section-block-half">
## Kernel Source Code

```c
{{source_code}}
```
</div>

{% if page.comment and page.comment != "" and page.comment != nil %}
<div markdown="1" class="section-block-half">
## Comments

{{page.comment}}
</div>
{% endif %}

</div>
