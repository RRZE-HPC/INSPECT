---
title:  "Stempel Data Collection"
---

{% for page in site.pages %}
{% if page.url contains 'pages' %}
[{{page.title}}]({{site.baseurl}}{{page.url}})
{% endif %}
{% endfor %}
