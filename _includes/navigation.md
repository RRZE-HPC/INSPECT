
[comment]: <> dimensions
{% capture tmpdim %}{% for page in site.pages %}{{page.dimension}}|{% endfor %}{% endcapture %}
{% assign dims=tmpdim | split: "|" | uniq | sort %}
[comment]: <> radii
{% capture tmprad %}{% for page in site.pages %}{{page.radius}}|{% endfor %}{% endcapture %}
{% assign rads=tmprad | split: "|" | uniq | sort %}
[comment]: <> weigths
{% capture tmpweight %}{% for page in site.pages %}{{page.weighting}}|{% endfor %}{% endcapture %}
{% assign weights=tmpweight | split: "|" | uniq | sort %}
[comment]: <> kinds
{% capture tmpkind %}{% for page in site.pages %}{{page.kind}}|{% endfor %}{% endcapture %}
{% assign kinds=tmpkind | split: "|" | uniq | sort %}
[comment]: <> coefficients
{% capture tmpcoeff %}{% for page in site.pages %}{{page.coefficients}}|{% endfor %}{% endcapture %}
{% assign coeffs=tmpcoeff | split: "|" | uniq | sort %}
[comment]: <> datatypes
{% capture tmpdt %}{% for page in site.pages %}{{page.datatype}}|{% endfor %}{% endcapture %}
{% assign dts=tmpdt | split: "|" | uniq | sort %}
[comment]: <> machines
{% capture tmpmachine %}{% for page in site.pages %}{{page.machine}}|{% endfor %}{% endcapture %}
{% assign machines=tmpmachine | split: "|" | uniq | sort %}

<div markdown="1" id="navigation">
## Stencil Navigation

Filter available stencil data by categories or by collapsing levels:

<span class="nav-selection">Dimension:<br/>
<select class="select_dims nav-selection-dropdowns">
<option value="all" selected="selected">All</option>
{%- for dim in dims %}
<option value="dim{{dim}}">{{dim}}</option>
{%- endfor -%}
</select>
</span>
<span class="nav-selection">Radius:<br/>
<select class="select_rads nav-selection-dropdowns" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="radall" selected="selected">All</option>
{%- for rad in rads %}
<option value="rad{{rad}}">{{rad}}</option>
{%- endfor -%}
</select>
</span>
<span class="nav-selection">Weight:<br/>
<select class="select_weights nav-selection-dropdowns" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="weightall" selected="selected">All</option>
{%- for weight in weights %}
<option value="weight{{weight}}">{{weight}}</option>
{%- endfor -%}
</select>
</span>
<span class="nav-selection">Kind:<br/>
<select class="select_kinds nav-selection-dropdowns" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="kindall" selected="selected">All</option>
{%- for kind in kinds %}
<option value="kind{{kind}}">{{kind}}</option>
{%- endfor -%}
</select>
</span>
<span class="nav-selection">Coefficients:<br/>
<select class="select_coeffs nav-selection-dropdowns" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="coeffall" selected="selected">All</option>
{%- for coeff in coeffs %}
<option value="coeff{{coeff}}">{{coeff}}</option>
{%- endfor -%}
</select>
</span>
<span class="nav-selection">Datatype:<br/>
<select class="select_dts nav-selection-dropdowns" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="dtall" selected="selected">All</option>
{%- for dt in dts %}
<option value="dt{{dt}}">{{dt}}</option>
{%- endfor -%}
</select>
</span>
<!-- <select class="select_machines" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="machineall" selected="selected">All</option>
{%- for machine in machines %}
<option value="machine{{machine}}">{{machine}}</option>
{%- endfor -%}
</select> -->

<br /><br /><br />

<script>
function toggle_visibility(option) {
	var name = "";
	if (String(option).startsWith("dim")) {
		name = "dim"
	} else if (String(option).startsWith("rad")) {
		name = "rad"
	} else if (String(option).startsWith("weight")) {
		name = "weight"
	} else if (String(option).startsWith("kind")) {
		name = "kind"
	} else if (String(option).startsWith("coeff")) {
		name = "coeff"
	} else if (String(option).startsWith("dt")) {
		name = "dt"
	} else if (String(option).startsWith("machine")) {
		name = "machine"
	}

	if (String(option).endsWith("all")) {
		$("[class^="+name+"]").css("display","block");
	} else {
		$("[class^="+name+"]").css("display","none");
		$("."+String(option)).css("display","block");
	}
}
</script>


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
