
{% for page in site.pages %}
	{% if page.url contains '/stencils/' %}
		{% if page.url contains '/stencils/named/' -%}
		{% else %}
		  {% assign dims = page.dimension | append: '|' | prepend: dims %}
		  {% assign rads = page.radius | append: '|' | prepend: rads %}
		  {% assign weights = page.weighting | append: '|' | prepend: weights %}
		  {% assign kinds = page.kind | append: '|' | prepend: kinds %}
		  {% assign coeffs = page.coefficients | append: '|' | prepend: coeffs %}
		  {% assign dts = page.datatype | append: '|' | prepend: dts %}
		  {% assign machines = page.machine | append: '|' | prepend: machines %}
		{% endif %}
	{% endif %}
{% endfor %}

{% assign dims=dims | split: "|" | uniq | sort %}
{% assign rads=rads | split: "|" | uniq | sort %}
{% assign weights=weights | split: "|" | uniq | sort %}
{% assign kinds=kinds | split: "|" | uniq | sort %}
{% assign coeffs=coeffs | split: "|" | uniq | sort %}
{% assign dts=dts | split: "|" | uniq | sort %}
{% assign machines=machines | split: "|" | uniq | sort %}

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
{%- assign basename_rad = 'stencils/' | append: dim | append: '/' -%}
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
{%- assign basename_weight = basename_rad | append: rad | append: '/' | append: weight | append: '/' -%}
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
{%- assign basename_kind = basename_weight | append: kind | append: '/' -%}
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
{%- assign basename_coeff = basename_kind | append: coeff | append: '/' -%}
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
{%- assign basename_dt = basename_coeff | append: dt | append: '/' -%}
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
{%- assign basename = basename_dt | append: machine | append: '/' -%}
{%- if page.machine == machine -%}
{%- if page.url contains basename -%}
  - [{{machine}}{%if page.flavor != "" and page.flavor != nil %} - {{page.flavor}}{% endif %}]({{site.baseurl}}{{page.url}}){: .machine{{machine}}}
{% endif %}
{%- endif -%}
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
