
{% assign file = include.file %}
# {{file["model name"]}}

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

## Compiler Flags

|-------------------|------------------:|
{%- for compiler in file.compiler %}
| {{compiler[0]}}   | `{{compiler[1]}}` |
{%- endfor %}

## Flops per Cycle

{% assign flops = file["FLOPs per cycle"] %}
|---|------:|----:|----:|----:|
|   | total | FMA | ADD | MUL |
| Single Precission | {{flops.SP.total}} | {{flops.SP.FMA}} | {{flops.SP.ADD}} | {{flops.SP.MUL}} |
| Double Precission | {{flops.DP.total}} | {{flops.DP.FMA}} | {{flops.DP.ADD}} | {{flops.DP.MUL}} |

## Memory Hierarchy
{% for level in file["memory hierarchy"] %}
### {{level.level}}

|-------------------|-------------------------------:|
{% if level.level != 'MEM' %}| groups            | {{level["groups"]}}            |{% endif %}
| cores per group   | {{level["cores per group"]}}   |
| threads per group | {{level["threads per group"]}} |
{% if level["non-overlap upstream throughput"] %}|non-overlap upstream throughput|{{level["non-overlap upstream throughput"][0]}}, {{level["non-overlap upstream throughput"][1]}}|{% endif %}

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

{% endfor %}

## Overlapping Model

### Ports:
{% for port in file["overlapping model"].ports -%}
{{port}}{% if forloop.last %}{%else%},{% endif %}
{% endfor %}

### Performance Counter Metric
```
{{file["overlapping model"]["performance counter metric"]}}
```

## Non-Overlapping Model

### Ports:
{% for port in file["non-overlapping model"].ports -%}
{{port}}{% if forloop.last %}{%else%},{% endif %}
{% endfor %}

### Performance Counter Metric
```
{{file["non-overlapping model"]["performance counter metric"]}}
```

## Benchmarks

### Kernels
{% for kernel in file.benchmarks.kernels %}
#### {{kernel[0]}}

|-------------------|-----------------------------------:|
|FLOPs per iteration|{{kernel[1]["FLOPs per iteration"]}}|
|read streams       |{{kernel[1]["read streams"].streams}} Streams with {{kernel[1]["read streams"].bytes}}       |
|write streams      |{{kernel[1]["write streams"].streams}} Streams with {{kernel[1]["write streams"].bytes}}      |
|read+write streams |{{kernel[1]["read+write streams"].streams}} Streams with {{kernel[1]["read+write streams"].bytes}} |

{% endfor %}



