---

title:  "Stencil 3D r1 box constant point-symmetric double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "point-symmetric"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
comment      : "The relatively long dependency chain (see assembler code) is a common issue for boxed stencils. This makes this code in general core bound because of those dependencies."
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "40"
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
double c4;
double c5;
double c6;
double c7;
double c8;
double c9;
double c10;
double c11;
double c12;
double c13;

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          c0 * a[k][j][i] + c1 * (a[k][j][i - 1] + a[k][j][i + 1]) +
          c2 * (a[k][j - 1][i] + a[k][j + 1][i]) +
          c3 * (a[k - 1][j][i] + a[k + 1][j][i]) +
          c4 * (a[k][j - 1][i - 1] + a[k][j + 1][i + 1]) +
          c5 * (a[k - 1][j][i - 1] + a[k + 1][j][i + 1]) +
          c6 * (a[k + 1][j][i - 1] + a[k - 1][j][i + 1]) +
          c7 * (a[k][j + 1][i - 1] + a[k][j - 1][i + 1]) +
          c8 * (a[k - 1][j - 1][i] + a[k + 1][j + 1][i]) +
          c9 * (a[k + 1][j - 1][i] + a[k - 1][j + 1][i]) +
          c10 * (a[k - 1][j - 1][i - 1] + a[k + 1][j + 1][i + 1]) +
          c11 * (a[k + 1][j - 1][i - 1] + a[k - 1][j + 1][i + 1]) +
          c12 * (a[k - 1][j + 1][i - 1] + a[k + 1][j - 1][i + 1]) +
          c13 * (a[k + 1][j + 1][i - 1] + a[k - 1][j - 1][i + 1]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm14, ymmword ptr [r10+r15*8]
vmovupd ymm12, ymmword ptr [r9+r15*8]
vmovupd ymm0, ymmword ptr [r10+r15*8+0x8]
vaddpd ymm15, ymm14, ymmword ptr [r13+r15*8+0x10]
vaddpd ymm13, ymm12, ymmword ptr [r9+r15*8+0x10]
vaddpd ymm12, ymm0, ymmword ptr [r13+r15*8+0x8]
vmulpd ymm11, ymm7, ymm15
vmovupd ymm0, ymmword ptr [rsp+0x380]
vmovupd ymm14, ymmword ptr [r13+r15*8]
vmovupd ymm15, ymmword ptr [r12+r15*8+0x8]
vfmadd231pd ymm11, ymm12, ymm9
vmovupd ymm12, ymmword ptr [r12+r15*8]
vaddpd ymm15, ymm15, ymmword ptr [rbx+r15*8+0x8]
vfmadd231pd ymm11, ymm0, ymmword ptr [r9+r15*8+0x8]
vaddpd ymm0, ymm14, ymmword ptr [r10+r15*8+0x10]
vaddpd ymm14, ymm12, ymmword ptr [rbx+r15*8+0x10]
vmulpd ymm12, ymm14, ymmword ptr [rsp+0x360]
vfmadd231pd ymm12, ymm15, ymm8
vfmadd231pd ymm12, ymm13, ymm10
vmovupd ymm13, ymmword ptr [r11+r15*8+0x8]
vaddpd ymm15, ymm11, ymm12
vmovupd ymm11, ymmword ptr [rbx+r15*8]
vaddpd ymm12, ymm11, ymmword ptr [r12+r15*8+0x10]
vaddpd ymm11, ymm13, ymmword ptr [r14+r15*8+0x8]
vmovupd ymm13, ymmword ptr [r11+r15*8]
vmulpd ymm14, ymm5, ymm11
vmovupd ymm11, ymmword ptr [r14+r15*8]
vaddpd ymm13, ymm13, ymmword ptr [r14+r15*8+0x10]
vfmadd231pd ymm14, ymm12, ymm6
vaddpd ymm12, ymm11, ymmword ptr [r11+r15*8+0x10]
vmovupd ymm11, ymmword ptr [rsi+r15*8+0x8]
vmulpd ymm12, ymm12, ymmword ptr [rsp+0x320]
vaddpd ymm11, ymm11, ymmword ptr [r8+r15*8+0x8]
vmulpd ymm11, ymm4, ymm11
vfmadd231pd ymm11, ymm0, ymmword ptr [rsp+0x340]
vmovupd ymm0, ymmword ptr [rsi+r15*8]
vaddpd ymm11, ymm14, ymm11
vaddpd ymm0, ymm0, ymmword ptr [r8+r15*8+0x10]
vmovupd ymm14, ymmword ptr [r8+r15*8]
vfmadd231pd ymm12, ymm0, ymm2
vaddpd ymm0, ymm14, ymmword ptr [rsi+r15*8+0x10]
vmulpd ymm14, ymm1, ymm0
vfmadd231pd ymm14, ymm13, ymm3
vaddpd ymm12, ymm14, ymm12
vaddpd ymm11, ymm12, ymm11
vaddpd ymm15, ymm11, ymm15
vmovupd ymmword ptr [rdx+r15*8+0x8], ymm15
add r15, 0x4
cmp r15, rcx
jb 0xfffffffffffffece
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;P ~ 400
L2: P <= 3277;P ~ 3270
L3: P <= 1179649/5;P ~ 235920
L1: 32*N*P - 16*P - 16 <= 32768;N*P ~ 20²
L2: 32*N*P - 16*P - 16 <= 262144;N*P ~ 90²
L3: 32*N*P - 16*P - 16 <= 18874368;N*P ~ 760²
{%- endcapture -%}

{% include stencil_template.md %}
