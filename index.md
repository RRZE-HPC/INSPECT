---
title:  "Stempel Data Collection"
---

{% for page in site.pages %}
{% if page.url contains 'stencil' %}
{% capture basename %}{{page.dimension}} -- {{page.radius}} -- {{page.weighting}} -- {{page.kind}} -- {{page.coefficients}} -- {{page.datatype}} -- {{page.machine}}{% endcapture %}
[{{basename}}]({{site.baseurl}}{{page.url}})
{% endif %}
{% endfor %}

{% loop_directory directory:stencil iterator:folder sort:ascending %}
{{ folder }}
{% endloop_directory %}

 {% directory path: stencil %}
  {{ file.date }}
  {{ file.name }}
  {{ file.slug }}
  {{ file.url }}

  {{ forloop }}
{% enddirectory %}
