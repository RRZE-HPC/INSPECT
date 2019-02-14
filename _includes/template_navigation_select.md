<span class="nav-selection">{{include.title}}:<br/>
<select class="select_{{include.type_name}}s nav-selection-dropdowns" onchange="toggle_visibility(this.options[this.selectedIndex].value)">
<option value="all" selected="selected">All</option>
{%- for opt in include.type %}
<option value="{{include.type_name}}{{opt}}">{{opt}}</option>
{%- endfor -%}
</select>
</span>
