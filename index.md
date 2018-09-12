---
title:  "Stempel Data Collection"
---

{% for page in site.pages %}
{% if page.url contains 'pages' %}
{% capture basename %}{{page.dimension}} -- {{page.radius}} -- {{page.weighting}} -- {{page.kind}} -- {{page.coefficients}} -- {{page.datatype}} -- {{page.machine}}{% endcapture %}
[{{basename}}]({{site.baseurl}}{{page.url}})
{% endif %}
{% endfor %}
