
## Stencil Type

| property     | value            |
|--------------|-----------------:|
| dimension    | {{page.dimension}}    |
| radius       | {{page.radius}}       |
| weighting    | {{page.weighting}}    |
| kind         | {{page.kind}}         |
| coefficients | {{page.coefficients}} |
| datatype     | {{page.datatype}}     |
| machine      | [{{page.machine}}]({{site.baseurl}}/machine_files/{{page.machine}}.yml) |
{% assign flavor_size = {{page.flavor | size}} %}{% if flavor_size != 0 %}| flavor       | {{page.flavor}}       |{% endif %}

## Plots

![ECM](./ecm.svg)
![Roofline](./roofline.svg)
![Memory](./memory.svg)

Benchmark raw data can be found [here](./results.csv).

### Remarks

..

### Stempel calls

Stencil generation:
```bash
stempel gen ...
```

Benchmark generation:
```bash
stempel bench ...
```

### Compiler flags:
```bash
{{page.compile_flags}}
```

### Source Code

```C
{{source_code}}
```
