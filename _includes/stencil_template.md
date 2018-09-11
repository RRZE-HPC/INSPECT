---
base_github_url: https://github.com/vivaeltopo/stempel_data/blob/master/
---

## stencil type

| property     | value            |
|--------------|-----------------:|
| dimension    | {{page.dimension}}    |
| radius       | {{page.radius}}       |
| weighting    | {{page.weighting}}    |
| kind         | {{page.kind}}         |
| coefficients | {{page.coefficients}} |
| datatype     | {{page.datatype}}     |
| machine      | [{{page.machine}}](/machine_files/{{page.machine}}) |

## Plots
{% for image in site.static_files %}
        <img src="{{ page.base_github_url }}{{ image.path }}" alt="image" />
{% endfor %}

![roofline Plot](/graphs/{{basename}}-roofline.svg)
![memory Plot](/graphs/{{basename}}-memory.svg)

## Remarks

Compiler flags:
```bash
{{compile_flags}}
```

## source code

```C
{{source_code}}
```
