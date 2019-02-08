{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="roofline" id="rfl_{{include.type}}" {{hide_if_hidden}} >
<object data="./roofline_{{include.type}}.svg" type="image/svg+xml"></object>
*Performance plot with [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) in comparison with the measured stencil performance. For comparison the according ECM prediction is also included.*

{% if include.type == 'LC' %}
	{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["roofline_{{include.type}}.svg"] %}
{% else if include.type == 'CS' %}
	{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["roofline_{{include.type}}.svg"] %}
{% endif %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
