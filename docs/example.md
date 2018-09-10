# Example stencil site

## stencil type

| property | value |
|---|---:|
| dimension| 3D |
| radius | 1r |
| weighting | isotropic |
| kind | star |
| coefficients | constant |
| datatype | double |
| machine | [BroadwellEP_E5-2697](../machine_files/BroadwellEP_E5-2697) |

## Remarks

Compiler flags:
```bash
icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid
```

## source code

```C
double a[M][N][P];
double b[M][N][P];
double c0;

for(int k=1; k < M-1; k++){
for(int j=1; j < N-1; j++){
for(int i=1; i < P-1; i++){
b[k][j][i] = c0 * (a[k][j][i]
+ a[k][j][i-1] + a[k][j][i+1]
+ a[k-1][j][i] + a[k+1][j][i]
+ a[k][j-1][i] + a[k][j+1][i]
);
}
}
}
```
