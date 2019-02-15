---
title: Review Overview
---

# {{page.title}}

<div markdown="1" class="section-block-full">
## Machine Files

{% for mf_comments in site.data.comments.machine_files %}

<div markdown="1" class="section-block-half">

### {{mf_comments[0]}}
{% capture com %}{{mf_comments[1].comment}}{% endcapture %}
{% capture aut %}{{mf_comments[1].author}}{% endcapture %}
{% capture rev %}{{mf_comments[1].review}}{% endcapture %}
{% capture upt %}{{mf_comments[1].uptodate}}{% endcapture %}
{% include template_comment.md comment=com author=aut review=rev uptodate=upt %}
<br />
</div>
{% endfor %}

</div>

| Dimension | Radius | Weighting | Kind | Coefficients | Datatype | Machine | Comments |
|-----------|--------|-----------|------|--------------|----------|---------|----------|
{% for dimension in site.data.comments.stencils -%}
{% for radius in dimension[1] -%}
{% for weighting in radius[1] -%}
{% for kind in weighting[1] -%}
{% for coefficients in kind[1] -%}
{% for datatype in coefficients[1] -%}
{% for machine in datatype[1] -%}
| {{dimension[0]}} | {{radius[0]}} | {{weighting[0]}} | {{kind[0]}} | {{coefficients[0]}} | {{datatype[0]}} | {{machine[0]}} | {%- for c in machine[1] -%}<svg class="svg" height="18" width="18"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="{{c[1].review}}" /></svg>{%- endfor -%} |
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
