
## Stencil Type

| property     | value            |
|--------------|-----------------:|
| dimension    | {{page.dimension}}    |
| radius       | {{page.radius}}       |
| weighting    | {{page.weighting}}    |
| kind         | {{page.kind}}         |
| coefficients | {{page.coefficients}} |
| datatype     | {{page.datatype}}     |
| machine      | [{{page.machine}}](/machine_files/{{page.machine}}) |
{% assign flavor_size = {{page.flavor | size}} %}{% if flavor_size != 0 %}| flavor       | {{page.flavor}}       |{% endif %}

## Plots

{% assign image_files = site.static_files | where: "image", true %}
{% for myimage in image_files %}
{% if myimage.path contains basename %}
![Plot]({{site.baseurl}}{{myimage.path}})
{% endif %}
{% endfor %}

## Remarks

Compiler flags:
```bash
{{page.compile_flags}}
```

## source code

```C
{{source_code}}
```
