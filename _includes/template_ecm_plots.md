{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="ecm" id="ecm_{{include.type}}" {{hide_if_hidden}} >
<object data="./ecm_{{include.type}}.svg" type="image/svg+xml"></object>
{% if include.type == 'LC' %}
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Layer Conditions](https://rrze-hpc.github.io/layer-condition/) to model the cache behavior. The calculated [layer conditions](#layer-conditions) shown above correspond to the jumps in the ECM prediction in this plot.*
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["ecm_LC.svg"] %}
{% else if include.type == 'CS' %}
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the [ECM Performance Model](https://hpc.fau.de/research/ecm/) predicted by [kerncraft](https://github.com/RRZE-HPC/kerncraft) using [Cache Simulation](https://github.com/RRZE-HPC/pycachesim) to model the cache behavior.*
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["ecm_CS.svg"] %}
{% else include.type == 'Pheno' %}
*Comparison of the measured stencil performance (in cycles per cache line) and the (stacked) contributions of the phenomenological [ECM Performance Model](https://hpc.fau.de/research/ecm/) measured with [kerncraft](https://github.com/RRZE-HPC/kerncraft). The phenomenological ECM Model is completely derived from performance counter measurements during benchmark execution.*
{% assign com = site.data.comments.stencils[page.dimension][page.radius][page.weighting][page.kind][page.coefficients][page.datatype][page.machine]["ecm_Pheno.svg"] %}
{% else %}
*Unknown ECM Plot*
{% endif %}

{% if com %}
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=com.uptodate %}
{% endif %}
</div>
