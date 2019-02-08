<div markdown="1">
{% case include.author %}
  {% when 'rrzeschorscherl' %}
     {% assign avatar_img = 'rrzeschorscherl.png' %}
  {% when 'cod3monk' %}
     {% assign avatar_img = 'cod3monk.png' %}
  {% else %}
     {% assign avatar_img = 'male-avatar.svg' %}
{% endcase %}

{% if include.uptodate == false %}
{% assign outofdate = ' outofdate' %}
{% else %}
{% assign outofdate = '' %}
{% endif %}

<img src="{{site.baseurl}}/assets/img/{{avatar_img}}" class="comment_bubble_img" />
<blockquote markdown="1" class="comment_bubble{{outofdate}}" >
{% if include.uptodate == false %}
<span class="warning">
⚠️ Comment was submitted for a previous version of the shown data.
</span>
{% endif %}
{{include.author}} says:
<p><i>{{include.comment}}</i></p>
{% if include.review != null %}
<svg class="svg" height="18" width="18">
	<circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="{{include.review}}" />
</svg>
{% endif %}
</blockquote>
</div>
