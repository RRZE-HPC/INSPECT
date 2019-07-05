
{% for page in site.pages %}
	{% if page.url contains '/stencils/named/' -%}
	  {% assign names = page.stencil_name | append: '|' | prepend: names %}
	  {% assign machines = page.machine | append: '|' | prepend: machines %}
	{% endif %}
{% endfor %}

{% assign names=names | split: "|" | uniq | sort %}
{% assign machines=machines | split: "|" | uniq | sort %}

<script src="assets/js/navigation_toggle_visibility.js"></script>

<div markdown="1" id="navigation_named">
## Named Stencils

{%- for name in names %}
<details class="name_{{name}}" markdown="1" open>
<summary>{{name}}</summary>
{%- for machine in machines %}
{%- for page in site.pages %}

{%- capture basename -%}
stencils/named/{{name}}/{{machine}}
{%- endcapture -%}

{%- if page.machine == machine -%}
{%- if page.url contains basename -%}
  - [{{machine}}{%if page.flavor != "" and page.flavor != nil %} - {{page.flavor}}{% endif %}]({{site.baseurl}}{{page.url}}){: .machine{{machine}}}
{% endif %}
{%- endif -%}
{%- endfor -%}
{%- endfor -%}
</details>
{%- endfor -%}

</div>
