<div markdown="1" id="navigation">
## Navigation
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

<select class="select_dims">
<option value="all" selected="selected">All</option>
{%- for dim in dims %}
<option value="dim{{dim}}">{{dim}}</option>
{%- endfor -%}
</select>
<select class="select_rads" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="radall" selected="selected">All</option>
{%- for rad in rads %}
<option value="rad{{rad}}">{{rad}}</option>
{%- endfor -%}
</select>
<select class="select_weights" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="weightall" selected="selected">All</option>
{%- for weight in weights %}
<option value="weight{{weights}}">{{weight}}</option>
{%- endfor -%}
</select>
<select class="select_kinds" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="kindall" selected="selected">All</option>
{%- for kind in kinds %}
<option value="kind{{kind}}">{{kind}}</option>
{%- endfor -%}
</select>
<select class="select_coeffs" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="coeffall" selected="selected">All</option>
{%- for coeff in coeffs %}
<option value="coeff{{coeff}}">{{coeff}}</option>
{%- endfor -%}
</select>
<select class="select_dts" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="dtall" selected="selected">All</option>
{%- for dt in dts %}
<option value="dt{{dt}}">{{dt}}</option>
{%- endfor -%}
</select>
<select class="select_machines" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="machineall" selected="selected">All</option>
{%- for machine in machines %}
<option value="machine{{machine}}">{{machine}}</option>
{%- endfor -%}
</select>

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
		$("[class^="+name+"]").css("visibility","visible");
		$("[class^="+name+"]").css("height","auto");
	} else {
		$("[class^="+name+"]").css("visibility","hidden");
		$("[class^="+name+"]").css("height","0");
		$("."+String(option)).css("visibility","visible");
		$("."+String(option)).css("height","auto");
	}
}
</script>


{%- for dim in dims %}
<details class="dim{{dim}}" open>
<summary>{{dim}}</summary>
{%- for rad in rads %}
<details class="rad{{rad}}" open>
<summary>{{rad}}</summary>
{%- for weight in weights %}
<details class="weight{{weight}}" open>
<summary>{{weight}}</summary>
{%- for kind in kinds %}
<details class="kind{{kind}}" open>
<summary>{{kind}}</summary>
{%- for coeff in coeffs %}
<details class="coeff{{coeff}}" open>
<summary>{{coeff}}</summary>
{%- for dt in dts %}
<details class="dt{{dt}}" markdown="1" open>
<summary>{{dt}}</summary>
{%- for machine in machines %}
{%- for page in site.pages %}

{%- capture basename -%}
stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}/{{coeff}}/{{dt}}/{{machine}}
{%- endcapture -%}

{%- if page.url contains basename -%}
  - [{{machine}}{%if page.flavor != "" and page.flavor != nil %} - {{page.flavor}}{% endif %}]({{site.baseurl}}{{page.url}})
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
