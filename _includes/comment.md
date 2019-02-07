<div markdown="1">
<img src="{{site.baseurl}}/assets/img/male-avatar.svg" class="comment_bubble_img" />
<blockquote markdown="1" class="comment_bubble">
{% if include.uptodate == false %}
⚠️ Comment was submitted for a previous version of the shown data.
{% endif %}

{{include.author}} says: {{include.comment}}

{% if include.review != null %}
Review Status: <svg height="18" width="18"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="{{include.review}}" /></svg>
{% endif %}
</blockquote>
</div>
