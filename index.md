---
title:  "Stempel Data Collection"
---

# {{site.title}}

The [stempel](https://github.com/RRZE-HPC/stempel) tool allows automatic generation of loop kernels for several kind of stencil patterns. Stempel provides a framework to generate, perform static analysis of the code (exploiting kerncraft), generate a full C code and parallelize it via openMP and blocking.

On this site a collection of benchmark data obtained from the [stempel](https://github.com/RRZE-HPC/stempel) tool can be found.


## Sitemap
[comment]: <> dimensions
{% capture tmpdim %}{% for page in site.pages %}{{page.dimension}}|{% endfor %}{% endcapture %}
{% assign dims=tmpdim | split: "|" | uniq | sort %}
[comment]: <> radii
{% capture tmprad %}{% for page in site.pages %}{{page.radius}}|{% endfor %}{% endcapture %}
{% assign rads=tmprad | split: "|" | uniq | sort %}
[comment]: <> weigths
{% capture tmpweight %}{% for page in site.pages %}{{page.weighting}}|{% endfor %}{% endcapture %}
{% assign weights=tmpweight | split: "|" | uniq | sort %}
[comment]: <> kinds
{% capture tmpkind %}{% for page in site.pages %}{{page.kind}}|{% endfor %}{% endcapture %}
{% assign kinds=tmpkind | split: "|" | uniq | sort %}
[comment]: <> coefficients
{% capture tmpcoeff %}{% for page in site.pages %}{{page.coefficients}}|{% endfor %}{% endcapture %}
{% assign coeffs=tmpcoeff | split: "|" | uniq | sort %}
[comment]: <> datatypes
{% capture tmpdt %}{% for page in site.pages %}{{page.datatype}}|{% endfor %}{% endcapture %}
{% assign dts=tmpdt | split: "|" | uniq | sort %}
[comment]: <> machines
{% capture tmpmachine %}{% for page in site.pages %}{{page.machine}}|{% endfor %}{% endcapture %}
{% assign machines=tmpmachine | split: "|" | uniq | sort %}

{%- for dim in dims %}
- {{dim}}
{%- for rad in rads %}
  - {{rad}}
{%- for weight in weights %}
    - {{weight}}
{%- for kind in kinds %}
      - {{kind}}
{%- for coeff in coeffs %}
        - {{coeff}}
{%- for dt in dts %}
          - {{dt}}
{%- for machine in machines %}
{%- for page in site.pages %}

{%- capture basename -%}
stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}/{{coeff}}/{{dt}}/{{machine}}
{%- endcapture -%}

{%- if page.url contains basename %}
            - [{{machine}}{%if page.flavor != "" and page.flavor != nil %} - {{page.flavor}}{% endif %}]({{site.baseurl}}{{page.url}})
{%- endif %}
{%- endfor -%}
{%- endfor -%}
{%- endfor -%}
{%- endfor -%}
{%- endfor -%}
{%- endfor -%}
{%- endfor -%}
{%- endfor -%}
