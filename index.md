---
title:  "Stempel Data Collection"
---

{% for page in site.pages %}
{% if page.url contains 'stencil' %}
{% capture basename %}{{page.dimension}} -- {{page.radius}} -- {{page.weighting}} -- {{page.kind}} -- {{page.coefficients}} -- {{page.datatype}} -- {{page.machine}}{% if page.flavor and page.flavor != "" and page.flavor != nil %} -- Variant: {{page.flavor}}{% endif %}{% endcapture %}
[{{basename}}]({{site.baseurl}}{{page.url}})
{% endif %}
{% endfor %}
