---
title:  "Stempel Data Collection"
---

<!-- dimensions -->
{% capture tmpdim %}{% for page in site.pages %}{{page.dimension}}|{% endfor %}{% endcapture %}
{% assign dims=tmpdim | split: "|" | uniq | sort %}
<!-- radii -->
{% capture tmprad %}{% for page in site.pages %}{{page.radius}}|{% endfor %}{% endcapture %}
{% assign rads=tmprad | split: "|" | uniq | sort %}
<!-- weigths -->
{% capture tmpweight %}{% for page in site.pages %}{{page.weighting}}|{% endfor %}{% endcapture %}
{% assign weights=tmpweight | split: "|" | uniq | sort %}
<!-- kinds -->
{% capture tmpkind %}{% for page in site.pages %}{{page.kind}}|{% endfor %}{% endcapture %}
{% assign kinds=tmpkind | split: "|" | uniq | sort %}
<!-- coefficients -->
{% capture tmpcoeff %}{% for page in site.pages %}{{page.coefficients}}|{% endfor %}{% endcapture %}
{% assign coeffs=tmpcoeff | split: "|" | uniq | sort %}
<!-- datatypes -->
{% capture tmpdt %}{% for page in site.pages %}{{page.datatype}}|{% endfor %}{% endcapture %}
{% assign dts=tmpdt | split: "|" | uniq | sort %}
<!-- machines -->
{% capture tmpmachine %}{% for page in site.pages %}{{page.machine}}|{% endfor %}{% endcapture %}
{% assign machines=tmpmachine | split: "|" | uniq | sort %}

{% for dim in dims %}
- {{dim}}{% for rad in rads %}
  - {{rad}}{% for weight in weights %}
    - {{weight}}{% for kind in kinds %}
      - {{kind}}{% for coeff in coeffs %}
        - {{coeff}}{% for dt in dts %}
          - {{dt}}{% for machine in machines %}{% for page in site.pages %}{% capture basename %}stencils/{{dim}}/{{rad}}/{{weight}}/{{kind}}/{{coeff}}/{{dt}}/{{machine}}{% endcapture %}{% if page.url contains basename %}
            - [{{machine}}]({{site.baseurl}}{{page.url}}){% endif %}{% endfor %}{% endfor %}{% endfor %}{% endfor %}{% endfor %}{% endfor %}{% endfor %}{% endfor %}


<!-- {% for page in site.pages %}
{% if page.url contains 'stencil' %}
{% capture basename %}{{page.dimension}} -- {{page.radius}} -- {{page.weighting}} -- {{page.kind}} -- {{page.coefficients}} -- {{page.datatype}} -- {{page.machine}}{% if page.flavor and page.flavor != "" and page.flavor != nil %} -- Variant: {{page.flavor}}{% endif %}{% endcapture %}
[{{basename}}]({{site.baseurl}}{{page.url}})
{% endif %}
{% endfor %} -->
