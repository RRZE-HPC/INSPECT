---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : ""
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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

{%- capture source_code_asm -%}
vmulpd ymm14, ymm1, ymmword ptr [rdi+r12*8+0x8]
vmulpd ymm15, ymm0, ymmword ptr [r13+r12*8+0x8]
vfmadd231pd ymm14, ymm3, ymmword ptr [rsi+r12*8+0x8]
vfmadd231pd ymm15, ymm2, ymmword ptr [rbx+r12*8+0x8]
vaddpd ymm14, ymm14, ymm15
vmulpd ymm15, ymm4, ymmword ptr [r14+r12*8+0x10]
vfmadd231pd ymm15, ymm5, ymmword ptr [r14+r12*8]
vfmadd231pd ymm15, ymm6, ymmword ptr [r14+r12*8+0x8]
vaddpd ymm14, ymm14, ymm15
vmovupd ymmword ptr [r11+r12*8+0x8], ymm14
add r12, 0x4
cmp r12, rax
jb 0xffffffffffffffb8
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 5462
L3: P <= 1179650/3
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 262144;90²
L3: 16*N*P + 16*P*(N - 1) <= 18874368;768²
{%- endcapture -%}

{% include stencil_template.md %}

