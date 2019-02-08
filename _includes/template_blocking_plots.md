{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="blocking" {{hide_if_hidden}} >
<object data="./blocking_{{include.type}}.svg" type="image/svg+xml"></object>

{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["blocking_{{include.type}}.svg"] %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
