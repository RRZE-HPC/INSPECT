---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : ""
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for( int k = 1; k < M - 1; k++ ) {
  for( int j = 1; j < N - 1; j++ ) {
    for( int i = 1; i < P - 1; i++ ) {
      b[k][j][i] = c0 *
        ( a[k-1][j-1][i-1] + a[k][j-1][i-1]   + a[k+1][j-1][i-1]
        + a[k-1][j][i-1]   + a[k][j][i-1]     + a[k+1][j][i-1]
        + a[k-1][j+1][i-1] + a[k][j+1][i-1]   + a[k+1][j+1][i-1]
        + a[k-1][j-1][i]   + a[k][j-1][i]     + a[k+1][j-1][i]
        + a[k-1][j][i]     + a[k][j][i]       + a[k+1][j][i]
        + a[k-1][j+1][i]   + a[k][j+1][i]     + a[k+1][j+1][i]
        + a[k-1][j-1][i+1] + a[k][j-1][i+1]   + a[k+1][j-1][i+1]
        + a[k-1][j][i+1]   + a[k][j][i+1]     + a[k+1][j][i+1]
        + a[k-1][j+1][i+1] + a[k][j+1][i+1]   + a[k+1][j+1][i+1] );
    }
  }
}
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;409
L2: P <= 3277
L3: P <= 1638401/5;327680
L1: 32*N*P - 16*P - 16 <= 32768;32²
L2: 32*N*P - 16*P - 16 <= 262144;90²
L3: 32*N*P - 16*P - 16 <= 18874368;768²
{%- endcapture -%}

{% include stencil_template.md %}

