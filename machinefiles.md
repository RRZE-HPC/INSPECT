---
title: Machine Files
---

# {{page.title}}

Detailed descriptions of the machines used on this website can be found on this site. Machine files for new hardware can be created with the `likwid_bench_auto` command provided by [kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft').

{% assign sorted_files = site.data.machine_files | sort %}
{% for file in sorted_files -%}
{% unless file[0] contains 'comment' -%}
- [{{file[0] | replace: '_', ' '}}](./machines/{{file[0]}})
{% endunless -%}
{% endfor %}
