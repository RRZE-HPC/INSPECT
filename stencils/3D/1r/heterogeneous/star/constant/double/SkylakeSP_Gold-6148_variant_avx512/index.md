---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_avx512"
flavor       : "AVX 512"
comment      : "Inorder to convince the compiler to generate AVX512 code, the flag `-qopt-zmm-usage=high` has to be used."
compile_flags: "icc -O3 -xCORE-AVX512 -qopt-zmm-usage=high -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;
double c1;
double c2;
double c3;
double c4;
double c5;
double c6;

for ( int k = 1; k < M-1; k++ ) {
  for ( int j = 1; j < N-1; j++ ) {
    for ( int i = 1; i < P-1; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i];
    }
  }
}
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 21846
L3: P <= 611670
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 1048576;181²
L3: 16*N*P + 16*P*(N - 1) <= 29360128;957²
{%- endcapture -%}

{% include stencil_template.md %}

