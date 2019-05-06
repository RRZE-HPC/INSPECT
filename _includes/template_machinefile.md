
{% assign file = include.file %}

# {{file["model name"]}}

{% assign com = site.data.comments.machine_files[page.machine] %}
{% if com %}
<div markdown="1" class="section-block-full">
<div markdown="1" class="section-block-half">
{% include template_comment.md comment=com.comment author=com.author review=com.review uptodate=True %}
</div>
</div>
{% endif %}

<div markdown="1" class="section-block-full">

<div markdown="1" class="section-block-half">

## General

|-------------------------|------------------------------------:|
| model type              | {{file["model type"]}}              |
| model name              | {{file["model name"]}}              |
| micro-architecture      | {{file["micro-architecture"]}}      |
| cores per socket        | {{file["cores per socket"]}}        |
| cores per NUMA domain   | {{file["cores per NUMA domain"]}}   |
| cacheline size          | {{file["cacheline size"]}}          |
| clock                   | {{file["clock"]}}                   |
| NUMA domains per socket | {{file["NUMA domains per socket"]}} |

This machine file was generated for kerncraft version {{file["kerncraft version"]}}.

</div>
<div markdown="1" class="section-block-half">

## Compiler Flags

|-------------------|------------------:|
{%- for compiler in file.compiler %}
{%- if compiler contains "icc" %}
| icc   | `{{compiler["icc"]}}` |
{%- elsif compiler contains "gcc" %}
| gcc   | `{{compiler["gcc"]}}` |
{%- elsif compiler contains "clang" %}
| clang   | `{{compiler["clang"]}}` |
{%- endif %}
{%- endfor %}

## Flops per Cycle

{% assign flops = file["FLOPs per cycle"] %}
|-------------------|-----------------:|-----------------:|-----------------:|-------------------:|
|                   | ADD              | MUL              | FMA              | total              |
| Single Precission | {{flops.SP.ADD}} | {{flops.SP.MUL}} | {{flops.SP.FMA}} | {{flops.SP.total}} |
| Double Precission | {{flops.DP.ADD}} | {{flops.DP.MUL}} | {{flops.DP.FMA}} | {{flops.DP.total}} |

</div>
</div>


<div markdown="1" class="section-block-full">

## Memory Hierarchy
{% for level in file["memory hierarchy"] %}

<div markdown="1" class="section-block-half">
### {{level.level}}

{% if level.level == 'MEM' %}
|-------------------|-------------------------------:|
| cores per group   | {{level["cores per group"]}}   |
| threads per group | {{level["threads per group"]}} |
{% if level["non-overlap upstream throughput"] %}|non-overlap upstream throughput|{{level["non-overlap upstream throughput"][0]}}, {{level["non-overlap upstream throughput"][1]}}|{% endif %}
{% else %}
|-------------------|-------------------------------:|
| groups            | {{level["groups"]}}            |
| cores per group   | {{level["cores per group"]}}   |
| threads per group | {{level["threads per group"]}} |
{% if level["non-overlap upstream throughput"] %}|non-overlap upstream throughput|{{level["non-overlap upstream throughput"][0]}}, {{level["non-overlap upstream throughput"][1]}}|{% endif %}
{% endif %}

{% unless level.level == 'MEM' %}

#### Cache Per Group

|------------|-----------:|
{%- for group in level["cache per group"] %}
|{{group[0]}}|{{group[1]}}|
{%- endfor %}

#### Performance Counter Metrics

|----------|----------------------------------------------------:|
| accesses | `{{level["performance counter metrics"].accesses}}` |
| misses   | `{{level["performance counter metrics"].misses}}`   |
| evicts   | `{{level["performance counter metrics"].evicts}}`   |

{% endunless %}

</div>

{% endfor %}

</div>

<div markdown="1" class="section-block-full">
<div markdown="1" class="section-block-half">

## Overlapping Model

### Ports:
{% for port in file["overlapping model"].ports -%}
{{port}}{% if forloop.last %}{%else%},{% endif %}
{% endfor %}

### Performance Counter Metric
```
{{file["overlapping model"]["performance counter metric"]}}
```

</div>
<div markdown="1" class="section-block-half">

## Non-Overlapping Model

### Ports:
{% for port in file["non-overlapping model"].ports -%}
{{port}}{% if forloop.last %}{%else%},{% endif %}
{% endfor %}

### Performance Counter Metric
```
{{file["non-overlapping model"]["performance counter metric"]}}
```

</div>
</div>


<div markdown="1" class="section-block-full">
## Benchmarks
</div>

<script src="{{site.baseurl}}/assets/js/plotly-latest.min.js"></script>

<div markdown="1" class="section-block-full">
<div markdown="1" class="section-block-half">

<div id="l1_1" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.L1[1] %}
{% capture l1_title %}L1 Cache (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='l1_1' title=l1_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
<div markdown="1" class="section-block-half">

<div id="l1_2" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.L1[2] %}
{% capture l1_title %}L1 Cache (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='l1_2' title=l1_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
</div>
<div markdown="1" class="section-block-full">
<div markdown="1" class="section-block-half">

<div id="l2_1" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.L2[1] %}
{% capture l2_title %}L2 Cache (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='l2_1' title=l2_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
<div markdown="1" class="section-block-half">

<div id="l2_2" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.L2[2] %}
{% capture l2_title %}L2 Cache (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='l2_2' title=l2_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
</div>
<div markdown="1" class="section-block-full">
<div markdown="1" class="section-block-half">

<div id="l3_1" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.L3[1] %}
{% capture l3_title %}L3 Cache (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='l3_1' title=l3_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
<div markdown="1" class="section-block-half">

<div id="l3_2" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.L3[2] %}
{% capture l3_title %}L3 Cache (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='l3_2' title=l3_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
</div>
<div markdown="1" class="section-block-full">
<div markdown="1" class="section-block-half">

<div id="mem_1" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.MEM[1] %}
{% capture mem_title %}Memory (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='mem_1' title=mem_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}

</div>
<div markdown="1" class="section-block-half">

<div id="mem_2" style="width:100%;height:400px;"></div>
{% assign data = file.benchmarks.measurements.MEM[2] %}
{% capture mem_title %}Memory (Threads per core: {{data["threads per core"]}}){% endcapture %}
{% include template_machinefile_plots.md dataset=data div='mem_2' title=mem_title xaxis='Cores' yaxis='Bandwidth [GB/s]' %}
</div>
</div>


<div markdown="1" class="section-block-full">
### Kernels
{% for kernel in file.benchmarks.kernels %}

<div markdown="1" class="section-block-half">

#### {{kernel[0]}}

|-------------------|-----------------------------------:|
|FLOPs per iteration|{{kernel[1]["FLOPs per iteration"]}}|
|read streams       |{{kernel[1]["read streams"].streams}} Streams with {{kernel[1]["read streams"].bytes}}       |
|write streams      |{{kernel[1]["write streams"].streams}} Streams with {{kernel[1]["write streams"].bytes}}      |
|read+write streams |{{kernel[1]["read+write streams"].streams}} Streams with {{kernel[1]["read+write streams"].bytes}} |

</div>

{% endfor %}
</div>

