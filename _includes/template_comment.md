<div markdown="1">
{% if include.author == 'rrzeschorscherl' or include.author == 'Georg Hager' %}
	{% assign author_name = 'Georg Hager' %}
  {% assign avatar_img = 'rrzeschorscherl.png' %}
{% elsif include.author == 'cod3monk' or include.author == 'Julian Hammer' or include.author == 'JuHa' %}
	{% assign author_name = 'Julian Hammer' %}
  {% assign avatar_img = 'cod3monk.png' %}
{% elsif include.author == 'vivaeltopo' or include.author == 'Julian Hornich' or include.author == 'JuHo' %}
	{% assign author_name = 'Julian Hornich' %}
  {% assign avatar_img = 'cod3monk.png' %}
{% else %}
	{% assign author_name = include.author %}
  {% assign avatar_img = 'male-avatar.svg' %}
{% endif %}

{% if include.uptodate == false %}
{% assign outofdate = ' outofdate' %}
{% else %}
{% assign outofdate = '' %}
{% endif %}

<img src="{{site.baseurl}}/assets/img/{{avatar_img}}" class="comment_bubble_img" />
<blockquote markdown="1" class="comment_bubble{{outofdate}}" >

{% capture color %}{% if include.review != null %}{{include.review}}{% else %}gray{% endif %}{% endcapture %}
<svg class="svg" height="18" width="18">
	<circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="{{color}}" />
</svg>

<p class="comment_author">{{author_name}} says:</p>
<p class="comment"><i>{{include.comment}}</i></p>

{% if include.uptodate == false %}
<hr />
<span class="warning">
Comment was submitted for a previous version of the shown data.
</span>
{% endif %}

</blockquote>
</div>
