---
title: Machine Files
---

# {{page.title}}

{% assign sorted_files = (site.data.machine_files | sort) %}
{% for file in sorted_files -%}
{% unless file[0] contains 'comment' -%}
- [{{file[0]}}](./machines/{{file[0]}})
{% endunless -%}
{% endfor %}
