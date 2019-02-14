
[comment]: <> dimensions
{% capture tmpdim %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.dimension}}|{% endif %}{% endfor %}{% endcapture %}
{% assign dims=tmpdim | split: "|" | uniq | sort %}
[comment]: <> radii
{% capture tmprad %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.radius}}|{% endif %}{% endfor %}{% endcapture %}
{% assign rads=tmprad | split: "|" | uniq | sort %}
[comment]: <> weigths
{% capture tmpweight %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.weighting}}|{% endif %}{% endfor %}{% endcapture %}
{% assign weights=tmpweight | split: "|" | uniq | sort %}
[comment]: <> kinds
{% capture tmpkind %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.kind}}|{% endif %}{% endfor %}{% endcapture %}
{% assign kinds=tmpkind | split: "|" | uniq | sort %}
[comment]: <> coefficients
{% capture tmpcoeff %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.coefficients}}|{% endif %}{% endfor %}{% endcapture %}
{% assign coeffs=tmpcoeff | split: "|" | uniq | sort %}
[comment]: <> datatypes
{% capture tmpdt %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.datatype}}|{% endif %}{% endfor %}{% endcapture %}
{% assign dts=tmpdt | split: "|" | uniq | sort %}
[comment]: <> machines
{% capture tmpmachine %}{% for page in site.pages %}{% if page.url contains '/stencils/' -%}{{page.machine}}|{% endif %}{% endfor %}{% endcapture %}
{% assign machines=tmpmachine | split: "|" | uniq | sort %}

<script src="assets/js/navigation_toggle_visibility.js"></script>

<div markdown="1" id="navigation">
## Stencil Navigation

Filter available stencil data by categories or by collapsing levels:



{% include template_navigation_select.md title='Dimension'    type=dims    type_name="dim" %}
{% include template_navigation_select.md title='Radius'       type=rads    type_name="rad" %}
{% include template_navigation_select.md title='Weight'       type=weights type_name="weight" %}
{% include template_navigation_select.md title='Kind'         type=kinds   type_name="kind" %}
{% include template_navigation_select.md title='Coefficients' type=coeffs  type_name="coeff" %}
{% include template_navigation_select.md title='Datatype'     type=dts     type_name="dt" %}

<br /><br /><br />


{%- for dim in dims %}
<details class="dim{{dim}}" open>
<summary>{{dim}}</summary>
{%- for rad in rads %}
{%- capture basename_rad -%}
stencils/{{dim}}
{%- endcapture -%}
{% assign has_rad = false %}
{%- for page in site.pages %}
{%- if page.url contains basename_rad -%}
{% assign has_rad = true %}
{% break %}
{% endif %}
{%- endfor -%}
{% if has_rad == false %}
{% continue %}
{% endif %}
<details class="rad{{rad}}" open>
<summary>{{rad}}</summary>
{%- for weight in weights %}
{%- capture basename_weight -%}
stencils/{{dim}}/{{rad}}/{{weight}}
{%- endcapture -%}
{% assign has_weight = false %}
{%- for page in site.pages %}
{%- if page.url contains basename_weight -%}
{% assign has_weight = true %}
{% break %}
{% endif %}
{%- endfor -%}
{% if has_weight == false %}
{% continue %}
{% endif %}
<details class="weight{{weight}}" open>
<summary>{{weight}}</summary>
{%- for kind in kinds %}
{%- capture basename_kind -%}
stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}
{%- endcapture -%}
{% assign has_kind = false %}
{%- for page in site.pages %}
{%- if page.url contains basename_kind -%}
{% assign has_kind = true %}
{% break %}
{% endif %}
{%- endfor -%}
{% if has_kind == false %}
{% continue %}
{% endif %}
<details class="kind{{kind}}" open>
<summary>{{kind}}</summary>
{%- for coeff in coeffs %}
{%- capture basename_coeff -%}
stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}/{{coeff}}
{%- endcapture -%}
{% assign has_coeff = false %}
{%- for page in site.pages %}
{%- if page.url contains basename_coeff -%}
{% assign has_coeff = true %}
{% break %}
{% endif %}
{%- endfor -%}
{% if has_coeff == false %}
{% continue %}
{% endif %}
<details class="coeff{{coeff}}" open>
<summary>{{coeff}}</summary>
{%- for dt in dts %}
{%- capture basename_dt -%}
stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}/{{coeff}}/{{dt}}
{%- endcapture -%}
{% assign has_dt = false %}
{%- for page in site.pages %}
{%- if page.url contains basename_dt -%}
{% assign has_dt = true %}
{% break %}
{% endif %}
{%- endfor -%}
{% if has_dt == false %}
{% continue %}
{% endif %}
<details class="dt{{dt}}" markdown="1" open>
<summary>{{dt}}</summary>
{%- for machine in machines %}
{%- for page in site.pages %}

{%- capture basename -%}
stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}/{{coeff}}/{{dt}}/{{machine}}
{%- endcapture -%}

{%- if page.url contains basename -%}
  - [{{machine}}{%if page.flavor != "" and page.flavor != nil %} - {{page.flavor}}{% endif %}]({{site.baseurl}}{{page.url}}){: .machine{{machine}}}
{% endif %}
{%- endfor -%}
{%- endfor -%}
</details>
{%- endfor -%}
</details>
{%- endfor -%}
</details>
{%- endfor -%}
</details>
{%- endfor -%}
</details>
{%- endfor -%}
</details>
{%- endfor -%}

</div>
