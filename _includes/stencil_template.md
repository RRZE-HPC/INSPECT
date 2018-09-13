{% include header.html %}

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

##### ECM Plot
![ECM](./ecm.svg)<!-- {:width="50%"} -->

##### Roofline Plot
![Roofline](./roofline.svg)

##### Memory Transfer Plot
![Memory](./memory.svg)

Benchmark raw data can be found [here](./results.csv).

{% if page.comment %}
### Comments

{{page.comment}}
{% endif %}

### How to test this stencil

Generate this stencil with:
```bash
stempel gen ...
```

and generate the compilable benchmark code with:
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
