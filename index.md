---
title:  "Stempel Data Collection"
---

{% for page in site.pages %}
{% if page.url contains 'stencil' %}
{% capture basename %}{{page.dimension}} -- {{page.radius}} -- {{page.weighting}} -- {{page.kind}} -- {{page.coefficients}} -- {{page.datatype}} -- {{page.machine}}{% endcapture %}
{% capture cnt %}[{{basename}}]({{site.baseurl}}{{page.url}}){% endcapture %}
{% include collapse.html title=cnt content=cnt %}
{% endif %}
{% endfor %}
