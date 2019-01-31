---

title:  "Stencil 3D r1 star constant point-symmetric double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "10"
scaling      : [ "1010" ]
blocking     : [ "L3-3D" ]
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

for (long k = 1; k < M - 1; ++k) {
  for (long j = 1; j < N - 1; ++j) {
    for (long i = 1; i < P - 1; ++i) {
      b[k][j][i] = c0 * a[k][j][i] +
                   c1 * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   c2 * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   c3 * (a[k][j - 1][i] + a[k][j + 1][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm8, ymmword ptr [r14+r13*8]
vmovupd ymm10, ymmword ptr [r11+r13*8+0x8]
vmovupd ymm12, ymmword ptr [r10+r13*8+0x8]
vaddpd ymm9, ymm8, ymmword ptr [r14+r13*8+0x10]
vaddpd ymm11, ymm10, ymmword ptr [r8+r13*8+0x8]
vaddpd ymm13, ymm12, ymmword ptr [r15+r13*8+0x8]
vmulpd ymm14, ymm2, ymm9
vfmadd231pd ymm14, ymm3, ymmword ptr [r14+r13*8+0x8]
vfmadd231pd ymm14, ymm11, ymm1
vfmadd231pd ymm14, ymm13, ymm0
vmovupd ymmword ptr [r9+r13*8+0x8], ymm14
add r13, 0x4
cmp r13, rax
jb 0xffffffffffffffb3
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3;P ~ 680
L2: P <= 5462;P ~ 5460
L3: P <= 1179650/3;P ~ 393210
L1: 16*N*P + 16*P*(N - 1) <= 32768;N*P ~ 30²
L2: 16*N*P + 16*P*(N - 1) <= 262144;N*P ~ 90²
L3: 16*N*P + 16*P*(N - 1) <= 18874368;N*P ~ 760²
{%- endcapture -%}

{% include stencil_template.md %}
