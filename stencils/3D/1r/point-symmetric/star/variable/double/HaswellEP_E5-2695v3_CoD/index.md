---

title:  "Stencil 3D r1 star variable point-symmetric double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "10"
scaling      : [ "800" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[4][M][N][P];

for (long k = 1; k < M - 1; ++k) {
  for (long j = 1; j < N - 1; ++j) {
    for (long i = 1; i < P - 1; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   W[2][k][j][i] * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   W[3][k][j][i] * (a[k][j - 1][i] + a[k][j + 1][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm0, ymmword ptr [rax+r9*8]
vmovupd ymm2, ymmword ptr [rax+r9*8+0x8]
vmovupd ymm3, ymmword ptr [r12+r9*8+0x8]
vmovupd ymm5, ymmword ptr [rcx+r9*8+0x8]
vaddpd ymm1, ymm0, ymmword ptr [rax+r9*8+0x10]
vaddpd ymm4, ymm3, ymmword ptr [r11+r9*8+0x8]
vaddpd ymm6, ymm5, ymmword ptr [rdi+r9*8+0x8]
vmulpd ymm7, ymm1, ymmword ptr [r14+r9*8+0x8]
vfmadd231pd ymm7, ymm2, ymmword ptr [r10+r9*8+0x8]
vfmadd231pd ymm7, ymm4, ymmword ptr [r13+r9*8+0x8]
vfmadd231pd ymm7, ymm6, ymmword ptr [r15+r9*8+0x8]
vmovupd ymmword ptr [r8+r9*8+0x8], ymm7
add r9, 0x4
cmp r9, rdx
jb 0xffffffffffffffa6
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2052/5;P ~ 410
L2: P <= 16388/5;P ~ 3270
L3: P <= 1179652/5;P ~ 235930
L1: 48*N*P + 16*P*(N - 1) - 32*P <= 32768;N*P ~ 20²
L2: 48*N*P + 16*P*(N - 1) - 32*P <= 262144;N*P ~ 60²
L3: 48*N*P + 16*P*(N - 1) - 32*P <= 18874368;N*P ~ 540²
{%- endcapture -%}

{% include stencil_template.md %}
