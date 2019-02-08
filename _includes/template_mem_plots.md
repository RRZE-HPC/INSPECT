{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="memory" id="mem_{{include.type}}" {{hide_if_hidden}} >
<object data="./memory_{{include.type}}.svg" type="image/svg+xml"></object>
*Data transfers between the different cache levels and main memory. The shown data for each level contains evicted and loaded data. The measured data is represented by points and the predicted transfer rates by [kerncraft](https://github.com/RRZE-HPC/kerncraft) by lines.*

{% if include.type == 'LC' %}
	{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["mem_{{include.type}}.svg"] %}
{% else if include.type == 'CS' %}
	{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["mem_{{include.type}}.svg"] %}
{% endif %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
