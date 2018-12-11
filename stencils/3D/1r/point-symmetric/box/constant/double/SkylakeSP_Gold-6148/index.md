---

title:  "Stencil 3D r1 box constant point-symmetric double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "1r"
weighting    : "point-symmetric"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "40"
scaling      : [ "1440" ]
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
vpcmpgtd k1, xmm10, xmm9
add r13, 0x4
vpaddd xmm9, xmm9, xmm24
vmovupd ymm5{k1}{z}, ymmword ptr [rax+r10*1]
vmovupd ymm4{k1}{z}, ymmword ptr [rax+r10*1+0x10]
vmovupd ymm2{k1}{z}, ymmword ptr [rax+r12*1+0x8]
vmovupd ymm11{k1}{z}, ymmword ptr [rax+r12*1]
vmovupd ymm6{k1}{z}, ymmword ptr [rax+r9*1+0x8]
vmovupd ymm1{k1}{z}, ymmword ptr [rax+r9*1+0x10]
vmovupd ymm7{k1}{z}, ymmword ptr [rax+rdx*1+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rax+rdx*1]
vmovupd ymm30{k1}{z}, ymmword ptr [rax+rdx*1+0x10]
vmovupd ymm0{k1}{z}, ymmword ptr [rax+r15*1+0x8]
vmovupd ymm31{k1}{z}, ymmword ptr [rax+r15*1+0x10]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+r15*1]
vmovupd ymm28{k1}{z}, ymmword ptr [rax+r9*1]
vmovupd ymm3{k1}{z}, ymmword ptr [rax+r10*1+0x8]
vaddpd ymm5, ymm5, ymm4
vaddpd ymm2, ymm2, ymm6
vaddpd ymm4, ymm7, ymm0
vaddpd ymm7, ymm11, ymm1
vaddpd ymm6, ymm8, ymm31
vaddpd ymm11, ymm29, ymm30
vmovupd ymm0{k1}{z}, ymmword ptr [rax+r12*1+0x10]
vmovupd ymm1{k1}{z}, ymmword ptr [rax+r11*1+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rax+rbx*1+0x8]
vmovupd ymm31{k1}{z}, ymmword ptr [rax+rsi*1+0x8]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+r8*1+0x8]
vmovupd ymm30{k1}{z}, ymmword ptr [rax+r11*1]
vmulpd ymm7, ymm18, ymm7
vaddpd ymm0, ymm28, ymm0
vaddpd ymm8, ymm1, ymm8
vaddpd ymm1, ymm31, ymm29
vmovupd ymm28{k1}{z}, ymmword ptr [rax+rbx*1+0x10]
vmovupd ymm31{k1}{z}, ymmword ptr [rax+rsi*1]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+r8*1+0x10]
vfmadd231pd ymm7, ymm2, ymm20
vmulpd ymm8, ymm14, ymm8
vaddpd ymm28, ymm30, ymm28
vaddpd ymm31, ymm31, ymm29
vmovupd ymm30{k1}{z}, ymmword ptr [rax+r8*1]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+rsi*1+0x10]
vfmadd231pd ymm7, ymm3, ymm22
vmulpd ymm3, ymm17, ymm6
vfmadd231pd ymm8, ymm11, ymm16
vmulpd ymm11, ymm13, ymm1
vaddpd ymm29, ymm30, ymm29
vmovupd ymm30{k1}{z}, ymmword ptr [rax+rbx*1]
vfmadd231pd ymm3, ymm4, ymm19
vmulpd ymm29, ymm25, ymm29
vfmadd231pd ymm11, ymm0, ymm15
vfmadd231pd ymm3, ymm5, ymm21
vfmadd231pd ymm29, ymm28, ymm27
vmovupd ymm28{k1}{z}, ymmword ptr [rax+r11*1+0x10]
vaddpd ymm0, ymm8, ymm11
vaddpd ymm1, ymm7, ymm3
vaddpd ymm30, ymm30, ymm28
vmulpd ymm28, ymm12, ymm30
vfmadd231pd ymm28, ymm31, ymm26
vaddpd ymm28, ymm29, ymm28
vaddpd ymm28, ymm28, ymm0
vaddpd ymm2, ymm28, ymm1
vmovupd ymmword ptr [rax+r14*1+0x8]{k1}, ymm2
add rax, 0x20
cmp r13, rcx
jb 0xfffffffffffffe29
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;P ~ 400
L2: P <= 65537/5;P ~ 13100
L3: P <= 1835009/5;P ~ 367000
L1: 32*N*P - 16*P - 16 <= 32768;N*P ~ 20²
L2: 32*N*P - 16*P - 16 <= 1048576;N*P ~ 180²
L3: 32*N*P - 16*P - 16 <= 29360128;N*P ~ 950²
{%- endcapture -%}

{% include stencil_template.md %}
