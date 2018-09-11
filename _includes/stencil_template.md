
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
![ECM Plot](/graphs/{{basename}}-ecm.svg)
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
