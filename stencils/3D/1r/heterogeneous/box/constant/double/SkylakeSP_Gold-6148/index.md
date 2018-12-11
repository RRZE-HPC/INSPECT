---

title:  "Stencil 3D r1 box constant heterogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "53"
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
double c14;
double c15;
double c16;
double c17;
double c18;
double c19;
double c20;
double c21;
double c22;
double c23;
double c24;
double c25;
double c26;

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          c0 * a[k][j][i] + c1 * a[k - 1][j - 1][i - 1] +
          c2 * a[k][j - 1][i - 1] + c3 * a[k + 1][j - 1][i - 1] +
          c4 * a[k - 1][j][i - 1] + c5 * a[k][j][i - 1] +
          c6 * a[k + 1][j][i - 1] + c7 * a[k - 1][j + 1][i - 1] +
          c8 * a[k][j + 1][i - 1] + c9 * a[k + 1][j + 1][i - 1] +
          c10 * a[k - 1][j - 1][i] + c11 * a[k][j - 1][i] +
          c12 * a[k + 1][j - 1][i] + c13 * a[k - 1][j][i] +
          c14 * a[k + 1][j][i] + c15 * a[k - 1][j + 1][i] +
          c16 * a[k][j + 1][i] + c17 * a[k + 1][j + 1][i] +
          c18 * a[k - 1][j - 1][i + 1] + c19 * a[k][j - 1][i + 1] +
          c20 * a[k + 1][j - 1][i + 1] + c21 * a[k - 1][j][i + 1] +
          c22 * a[k][j][i + 1] + c23 * a[k + 1][j][i + 1] +
          c24 * a[k - 1][j + 1][i + 1] + c25 * a[k][j + 1][i + 1] +
          c26 * a[k + 1][j + 1][i + 1];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpd k1, xmm7, xmmword ptr [rsp+0x270], 0x1
add r14, 0x4
vpaddd xmm7, xmm7, xmmword ptr [rsp+0x260]
vmovupd ymm9{k1}{z}, ymmword ptr [rcx+r13*1]
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+r12*1]
vmovupd ymm5{k1}{z}, ymmword ptr [rcx+r8*1]
vmovupd ymm6{k1}{z}, ymmword ptr [rcx+r8*1+0x8]
vmovupd ymm16{k1}{z}, ymmword ptr [rcx+r10*1]
vmulpd ymm28, ymm25, ymm9
vmovupd ymm9{k1}{z}, ymmword ptr [rcx+r9*1]
vmulpd ymm5, ymm22, ymm5
vfmadd231pd ymm28, ymm31, ymm26
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+rsi*1]
vfmadd231pd ymm5, ymm16, ymm24
vmulpd ymm16, ymm21, ymm9
vmovupd ymm9{k1}{z}, ymmword ptr [rcx+rdi*1]
vfmadd231pd ymm28, ymm6, ymm27
vmovupd ymm6{k1}{z}, ymmword ptr [rcx+rdx*1]
vfmadd231pd ymm16, ymm6, ymm23
vmulpd ymm6, ymm18, ymm31
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+r12*1+0x8]
vaddpd ymm5, ymm5, ymm16
vmovupd ymm16{k1}{z}, ymmword ptr [rcx+rbx*1]
vfmadd231pd ymm6, ymm9, ymm20
vmulpd ymm9, ymm17, ymm31
vfmadd231pd ymm9, ymm16, ymm19
vmovupd ymm16{k1}{z}, ymmword ptr [rcx+r13*1+0x8]
vaddpd ymm6, ymm6, ymm9
vaddpd ymm5, ymm6, ymm5
vaddpd ymm6, ymm5, ymm28
vmovupd ymm28{k1}{z}, ymmword ptr [rcx+rdx*1+0x8]
vmovupd ymm5{k1}{z}, ymmword ptr [rcx+r10*1+0x8]
vmulpd ymm9, ymm14, ymm28
vmovupd ymm28{k1}{z}, ymmword ptr [rcx+r9*1+0x8]
vfmadd231pd ymm9, ymm16, ymmword ptr [rsp+0x240]
vmulpd ymm31, ymm13, ymm28
vmovupd ymm16{k1}{z}, ymmword ptr [rcx+rdi*1+0x8]
data16 nop
vmovupd ymm28{k1}{z}, ymmword ptr [rcx+r12*1+0x10]
vfmadd231pd ymm31, ymm5, ymm15
vmovupd ymm5{k1}{z}, ymmword ptr [rcx+rsi*1+0x8]
vaddpd ymm9, ymm9, ymm31
vmulpd ymm5, ymm10, ymm5
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+rbx*1+0x8]
vfmadd231pd ymm5, ymm16, ymm12
vmulpd ymm16, ymm8, ymm28
vmovupd ymm28{k1}{z}, ymmword ptr [rcx+r10*1+0x10]
vfmadd231pd ymm16, ymm31, ymm11
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+r13*1+0x10]
vaddpd ymm5, ymm5, ymm16
vaddpd ymm5, ymm5, ymm9
vmovupd ymm9{k1}{z}, ymmword ptr [rcx+rdx*1+0x10]
vmulpd ymm16, ymm30, ymm9
vmovupd ymm9{k1}{z}, ymmword ptr [rcx+r8*1+0x10]
vfmadd231pd ymm16, ymm31, ymm1
vmulpd ymm31, ymm29, ymm9
vmovupd ymm9{k1}{z}, ymmword ptr [rcx+rbx*1+0x10]
vfmadd231pd ymm31, ymm28, ymm0
vmulpd ymm9, ymm9, ymmword ptr [rsp+0x220]
vmovupd ymm28{k1}{z}, ymmword ptr [rcx+rdi*1+0x10]
vaddpd ymm16, ymm16, ymm31
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+r9*1+0x10]
vfmadd231pd ymm9, ymm31, ymm4
vmovupd ymm31{k1}{z}, ymmword ptr [rcx+rsi*1+0x10]
vmulpd ymm31, ymm2, ymm31
vfmadd231pd ymm31, ymm28, ymm3
vaddpd ymm28, ymm9, ymm31
vaddpd ymm16, ymm28, ymm16
vaddpd ymm5, ymm16, ymm5
vaddpd ymm6, ymm5, ymm6
vmovupd ymmword ptr [rcx+r15*1+0x8]{k1}, ymm6
add rcx, 0x20
cmp r14, r11
jb 0xfffffffffffffdea
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
