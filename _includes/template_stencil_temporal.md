

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
| datatype     | {{ page.datatype | replace: '_', ' _' }}              |
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

</div>

<div markdown="1" class="section-block-half">

## Kernel Source Code
<div markdown="1" id="c_source">
```c
{{source_code}}
```
</div>

</div>

</div>
