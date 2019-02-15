---
title: Review Overview
---

# {{page.title}}

<div markdown="1" class="section-block-full">
## Machine Files

{% for mf_comments in site.data.comments.machine_files %}

{% if mf_comments[1].comment %}
<div markdown="1" class="section-block-half">

### {{mf_comments[0]}}
{% capture com %}{{mf_comments[1].comment}}{% endcapture %}
{% capture aut %}{{mf_comments[1].author}}{% endcapture %}
{% capture rev %}{{mf_comments[1].review}}{% endcapture %}
{% capture upt %}{{mf_comments[1].uptodate}}{% endcapture %}
{% include template_comment.md comment=com author=aut review=rev uptodate=upt %}
<br />
</div>
{%endif%}
{% endfor %}

</div>

## Stencils

| Dimension | Radius | Weighting | Kind | Coefficients | Datatype | Machine | Comments |
|-----------|--------|-----------|------|--------------|----------|---------|----------|
{% for dimension in site.data.comments.stencils -%}
{% for radius in dimension[1] -%}
{% for weighting in radius[1] -%}
{% for kind in weighting[1] -%}
{% for coefficients in kind[1] -%}
{% for datatype in coefficients[1] -%}
{% for machine in datatype[1] -%}
{%- capture url -%}{{site.baseurl}}/stencils/{{dimension[0]}}/{{radius[0]}}/{{weighting[0]}}/{{kind[0]}}/{{coefficients[0]}}/{{datatype[0]}}/{{machine[0]}}/{%- endcapture -%}
| {{dimension[0]}} | {{radius[0]}} | {{weighting[0]}} | {{kind[0]}} | {{coefficients[0]}} | {{datatype[0]}} | {{machine[0]}} | {%- for c in machine[1] -%}<a href="{{url}}#{{c[0] | replace: '.svg', ''}}"><svg class="svg" height="18" width="18"><title>{{c[0]}}: {{c[1].comment}}</title><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="{%- if c[1].review != null -%}{{-c[1].review-}}{%- else -%}gray{%- endif -%}" /></svg></a>{%- endfor -%} |
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
{% endfor -%}
