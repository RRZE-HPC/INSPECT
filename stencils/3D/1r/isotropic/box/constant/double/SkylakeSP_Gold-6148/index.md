---

title:  "Stencil 3D r1 box constant isotropic double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "30"
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

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          c0 * a[k][j][i] +
          c1 * (a[k][j][i - 1] + a[k][j - 1][i] + a[k - 1][j][i] +
                a[k + 1][j][i] + a[k][j + 1][i] + a[k][j][i + 1]) +
          c2 * (a[k][j - 1][i - 1] + a[k - 1][j][i - 1] +
                a[k + 1][j][i - 1] + a[k][j + 1][i - 1] +
                a[k - 1][j - 1][i] + a[k + 1][j - 1][i] +
                a[k - 1][j + 1][i] + a[k + 1][j + 1][i] +
                a[k][j - 1][i + 1] + a[k - 1][j][i + 1] +
                a[k + 1][j][i + 1] + a[k][j + 1][i + 1]) +
          c3 * (a[k - 1][j - 1][i - 1] + a[k + 1][j - 1][i - 1] +
                a[k - 1][j + 1][i - 1] + a[k + 1][j + 1][i - 1] +
                a[k - 1][j - 1][i + 1] + a[k + 1][j - 1][i + 1] +
                a[k - 1][j + 1][i + 1] + a[k + 1][j + 1][i + 1]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtd k1, xmm2, xmm1
add r13, 0x4
vpaddd xmm1, xmm1, xmm4
vmovupd ymm9{k1}{z}, ymmword ptr [rax+r10*1]
vmovupd ymm10{k1}{z}, ymmword ptr [rax+r12*1+0x8]
vmovupd ymm12{k1}{z}, ymmword ptr [rax+r9*1+0x8]
vmovupd ymm14{k1}{z}, ymmword ptr [rax+r15*1+0x8]
vmovupd ymm16{k1}{z}, ymmword ptr [rax+r8*1+0x8]
vmovupd ymm18{k1}{z}, ymmword ptr [rax+r10*1+0x10]
vmovupd ymm21{k1}{z}, ymmword ptr [rax+r12*1]
vmovupd ymm22{k1}{z}, ymmword ptr [rax+r9*1]
vmovupd ymm23{k1}{z}, ymmword ptr [rax+r15*1]
vmovupd ymm24{k1}{z}, ymmword ptr [rax+r8*1]
vmovupd ymm27{k1}{z}, ymmword ptr [rax+r11*1+0x8]
vmovupd ymm28{k1}{z}, ymmword ptr [rax+rdx*1+0x8]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+rbx*1+0x8]
vmovupd ymm30{k1}{z}, ymmword ptr [rax+rcx*1+0x8]
vmovupd ymm20{k1}{z}, ymmword ptr [rax+r10*1+0x8]
vaddpd ymm11, ymm9, ymm10
vaddpd ymm25, ymm21, ymm22
vaddpd ymm26, ymm23, ymm24
vaddpd ymm13, ymm11, ymm12
vaddpd ymm31, ymm27, ymm28
vaddpd ymm27, ymm29, ymm30
vaddpd ymm15, ymm13, ymm14
vaddpd ymm21, ymm25, ymm26
vaddpd ymm22, ymm31, ymm27
vaddpd ymm17, ymm15, ymm16
vmovupd ymm9{k1}{z}, ymmword ptr [rax+r12*1+0x10]
vmovupd ymm10{k1}{z}, ymmword ptr [rax+r9*1+0x10]
vmovupd ymm11{k1}{z}, ymmword ptr [rax+r15*1+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rax+r8*1+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [rax+rcx*1]
vmovupd ymm30{k1}{z}, ymmword ptr [rax+rcx*1+0x10]
vmovupd ymm26{k1}{z}, ymmword ptr [rax+r11*1+0x10]
vmovupd ymm28{k1}{z}, ymmword ptr [rax+rdx*1+0x10]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+rbx*1+0x10]
vaddpd ymm19, ymm17, ymm18
vaddpd ymm13, ymm9, ymm10
vaddpd ymm14, ymm11, ymm12
vaddpd ymm15, ymm21, ymm22
vaddpd ymm31, ymm26, ymm28
vaddpd ymm16, ymm13, ymm14
vaddpd ymm26, ymm29, ymm30
vmulpd ymm0, ymm6, ymm19
vmovupd ymm18{k1}{z}, ymmword ptr [rax+r11*1]
vmovupd ymm19{k1}{z}, ymmword ptr [rax+rdx*1]
vaddpd ymm17, ymm15, ymm16
vaddpd ymm10, ymm31, ymm26
vaddpd ymm24, ymm18, ymm19
vfmadd231pd ymm0, ymm20, ymm7
vmovupd ymm20{k1}{z}, ymmword ptr [rax+rbx*1]
vfmadd231pd ymm0, ymm17, ymm5
vaddpd ymm25, ymm20, ymm23
vaddpd ymm9, ymm24, ymm25
vaddpd ymm11, ymm9, ymm10
vfmadd231pd ymm0, ymm11, ymm3
vmovupd ymmword ptr [rax+r14*1+0x8]{k1}, ymm0
add rax, 0x20
cmp r13, rsi
jb 0xfffffffffffffe40
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
