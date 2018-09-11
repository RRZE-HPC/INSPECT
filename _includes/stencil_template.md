
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
{% assign basename = {{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}} %}
![ECM Plot](/graphs/3D-1r-isotropic-star-constant-double-BroadwellEP_E5-2697-ecm.svg)
![roofline Plot](/graphs/{{basename}}-roofline.svg)
![memory Plot](/graphs/{{basename}}-memory.svg)

## Remarks

Compiler flags:
```bash
icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid
```

## source code

```C
{{source_code}}
```
