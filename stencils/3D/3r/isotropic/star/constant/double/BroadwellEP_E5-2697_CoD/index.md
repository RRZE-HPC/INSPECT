---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : ""
comment      : "This is a comment"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for( int k=3; k < M-3; k++ ) {
  for( int j=3; j < N-3; j++ ) {
    for( int i=3; i < P-3; i++ ) {
      b[k][j][i] = c0 * (a[k][j][i]
        + a[k][j][i-1] + a[k][j][i+1]
        + a[k-1][j][i] + a[k+1][j][i]
        + a[k][j-1][i] + a[k][j+1][i]
        + a[k][j][i-2] + a[k][j][i+2]
        + a[k-2][j][i] + a[k+2][j][i]
        + a[k][j-2][i] + a[k][j+2][i]
        + a[k][j][i-3] + a[k][j][i+3]
        + a[k-3][j][i] + a[k+3][j][i]
        + a[k][j-3][i] + a[k][j+3][i]
      );
    }
  }
}
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;292
L2: P <= 16384/7;2340
L3: P <= 1441792/7;205970
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;32²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;91²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 23068672;849²

{%- endcapture -%}

{% include stencil_template.md %}

