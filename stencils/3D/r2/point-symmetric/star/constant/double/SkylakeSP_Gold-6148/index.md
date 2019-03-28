---

title:  "Stencil 3D r2 star constant point-symmetric double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r2"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
scaling      : [ "1030" ]
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

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = c0 * a[k][j][i] +
                   c1 * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   c2 * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   c3 * (a[k][j - 1][i] + a[k][j + 1][i]) +
                   c4 * (a[k][j][i - 2] + a[k][j][i + 2]) +
                   c5 * (a[k - 2][j][i] + a[k + 2][j][i]) +
                   c6 * (a[k][j - 2][i] + a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm3, ymm2
vpaddq ymm2, ymm2, ymm11
vmovupd ymm14{k1}{z}, ymmword ptr [r8+r15*8+0x10]
vmovupd ymm15{k1}{z}, ymmword ptr [rsi+r15*8+0x10]
vmovupd ymm20{k1}{z}, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm21{k1}{z}, ymmword ptr [rcx+r15*8+0x10]
vmovupd ymm22{k1}{z}, ymmword ptr [r11+r15*8+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [rdx+r15*8+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rdi+r15*8+0x8]
vmovupd ymm13{k1}{z}, ymmword ptr [rdi+r15*8+0x18]
vmovupd ymm18{k1}{z}, ymmword ptr [rdi+r15*8]
vmovupd ymm19{k1}{z}, ymmword ptr [rdi+r15*8+0x20]
vmovupd ymm16{k1}{z}, ymmword ptr [r9+r15*8+0x10]
vmovupd ymm17{k1}{z}, ymmword ptr [rbx+r15*8+0x10]
vmovupd ymm1{k1}{z}, ymmword ptr [rdi+r15*8+0x10]
vaddpd ymm30, ymm14, ymm15
vaddpd ymm24, ymm20, ymm21
vaddpd ymm26, ymm22, ymm23
vaddpd ymm31, ymm12, ymm13
vaddpd ymm25, ymm16, ymm17
vaddpd ymm27, ymm18, ymm19
vmulpd ymm13, ymm7, ymm30
vmulpd ymm28, ymm4, ymm24
vmulpd ymm29, ymm0, ymm26
vfmadd231pd ymm13, ymm31, ymm8
vfmadd231pd ymm28, ymm25, ymm6
vfmadd231pd ymm29, ymm27, ymm5
vfmadd231pd ymm13, ymm1, ymm9
vaddpd ymm12, ymm28, ymm29
vaddpd ymm1, ymm12, ymm13
vmovupd ymmword ptr [rax+r15*8+0x10]{k1}, ymm1
add r15, 0x4
cmp r15, r12
jb 0xffffffffffffff03
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;P <= 400
L2: P <= 65536/5;P <= 13100
L3: P <= 1835008/5;P <= 367000
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P <= 20²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 1048576;N*P <= 80²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 29360128;N*P <= 680²
{%- endcapture -%}

{% include stencil_template.md %}
