---
title: Machine Files
---

# {{page.title}}

Detailed descriptions of the machines used on this website can be found on this site. Machine files specify information about a machine model for each micro architecture. The [Kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft') repository already contains machine files for the most relevant architectures. To create machine files for new hardware call the `likwid_bench_auto` command provided by [kerncraft](https://github.com/RRZE-HPC/kerncraft 'kerncraft') on the destination machine. A list of machine files used on this website can be found below:

{% assign sorted_files = site.data.machine_files | sort %}
{% for file in sorted_files -%}
{% unless file[0] contains 'comment' -%}
- [{{file[0] | replace: '_', ' '}}](./machines/{{file[0]}})
{% endunless -%}
{% endfor %}
