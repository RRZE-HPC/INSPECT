---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r2"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for ( int k = 2; k < M - 2; k++ ) {
  for ( int j = 2; j < N - 2; j++ ) {
    for (int i = 2; i < P - 2; i++ ) {
      b[k][j][i] = c0 *
        ( a[k][j][i]       + a[k-2][j-2][i-2] + a[k-1][j-2][i-2]
        + a[k][j-2][i-2]   + a[k+1][j-2][i-2] + a[k+2][j-2][i-2]
        + a[k-2][j-1][i-2] + a[k-1][j-1][i-2] + a[k][j-1][i-2]
        + a[k+1][j-1][i-2] + a[k+2][j-1][i-2] + a[k-2][j][i-2]
        + a[k-1][j][i-2]   + a[k][j][i-2]     + a[k+1][j][i-2]
        + a[k+2][j][i-2]   + a[k-2][j+1][i-2] + a[k-1][j+1][i-2]
        + a[k][j+1][i-2]   + a[k+1][j+1][i-2] + a[k+2][j+1][i-2]
        + a[k-2][j+2][i-2] + a[k-1][j+2][i-2] + a[k][j+2][i-2]
        + a[k+1][j+2][i-2] + a[k+2][j+2][i-2] + a[k-2][j-2][i-1]
        + a[k-1][j-2][i-1] + a[k][j-2][i-1]   + a[k+1][j-2][i-1]
        + a[k+2][j-2][i-1] + a[k-2][j-1][i-1] + a[k-1][j-1][i-1]
        + a[k][j-1][i-1]   + a[k+1][j-1][i-1] + a[k+2][j-1][i-1]
        + a[k-2][j][i-1]   + a[k-1][j][i-1]   + a[k][j][i-1]
        + a[k+1][j][i-1]   + a[k+2][j][i-1]   + a[k-2][j+1][i-1]
        + a[k-1][j+1][i-1] + a[k][j+1][i-1]   + a[k+1][j+1][i-1]
        + a[k+2][j+1][i-1] + a[k-2][j+2][i-1] + a[k-1][j+2][i-1]
        + a[k][j+2][i-1]   + a[k+1][j+2][i-1] + a[k+2][j+2][i-1]
        + a[k-2][j-2][i]   + a[k-1][j-2][i]   + a[k][j-2][i]
        + a[k+1][j-2][i]   + a[k+2][j-2][i]   + a[k-2][j-1][i]
        + a[k-1][j-1][i]   + a[k][j-1][i]     + a[k+1][j-1][i]
        + a[k+2][j-1][i]   + a[k-2][j][i]     + a[k-1][j][i]
        + a[k+1][j][i]     + a[k+2][j][i]     + a[k-2][j+1][i]
        + a[k-1][j+1][i]   + a[k][j+1][i]     + a[k+1][j+1][i]
        + a[k+2][j+1][i]   + a[k-2][j+2][i]   + a[k-1][j+2][i]
        + a[k][j+2][i]     + a[k+1][j+2][i]   + a[k+2][j+2][i]
        + a[k-2][j-2][i+1] + a[k-1][j-2][i+1] + a[k][j-2][i+1]
        + a[k+1][j-2][i+1] + a[k+2][j-2][i+1] + a[k-2][j-1][i+1]
        + a[k-1][j-1][i+1] + a[k][j-1][i+1]   + a[k+1][j-1][i+1]
        + a[k+2][j-1][i+1] + a[k-2][j][i+1]   + a[k-1][j][i+1]
        + a[k][j][i+1]     + a[k+1][j][i+1]   + a[k+2][j][i+1]
        + a[k-2][j+1][i+1] + a[k-1][j+1][i+1] + a[k][j+1][i+1]
        + a[k+1][j+1][i+1] + a[k+2][j+1][i+1] + a[k-2][j+2][i+1]
        + a[k-1][j+2][i+1] + a[k][j+2][i+1]   + a[k+1][j+2][i+1]
        + a[k+2][j+2][i+1] + a[k-2][j-2][i+2] + a[k-1][j-2][i+2]
        + a[k][j-2][i+2]   + a[k+1][j-2][i+2] + a[k+2][j-2][i+2]
        + a[k-2][j-1][i+2] + a[k-1][j-1][i+2] + a[k][j-1][i+2]
        + a[k+1][j-1][i+2] + a[k+2][j-1][i+2] + a[k-2][j][i+2]
        + a[k-1][j][i+2]   + a[k][j][i+2]     + a[k+1][j][i+2]
        + a[k+2][j][i+2]   + a[k-2][j+1][i+2] + a[k-1][j+1][i+2]
        + a[k][j+1][i+2]   + a[k+1][j+1][i+2] + a[k+2][j+1][i+2]
        + a[k-2][j+2][i+2] + a[k-1][j+2][i+2] + a[k][j+2][i+2]
        + a[k+1][j+2][i+2] + a[k+2][j+2][i+2] );
    }
  }
}
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/13;157
L2: P <= 16386/13;1260
L3: P <= 1179650/13;90742
L1: 48*N*P - 32*P - 32 <= 32768;26²
L2: 48*N*P - 32*P - 32 <= 262144;73²
L3: 48*N*P - 32*P - 32 <= 26214400;739²
{%- endcapture -%}

{% include stencil_template.md %}

