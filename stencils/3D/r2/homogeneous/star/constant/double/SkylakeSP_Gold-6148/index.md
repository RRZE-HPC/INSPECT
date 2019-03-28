---

title:  "Stencil 3D r2 star constant homogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r2"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
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

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] =
          c0 * (a[k][j][i] + a[k][j][i - 1] + a[k][j][i + 1] +
                a[k - 1][j][i] + a[k + 1][j][i] + a[k][j - 1][i] +
                a[k][j + 1][i] + a[k][j][i - 2] + a[k][j][i + 2] +
                a[k - 2][j][i] + a[k + 2][j][i] + a[k][j - 2][i] +
                a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm4, ymm5
vpaddq ymm5, ymm5, ymm1
vmovupd ymm6{k1}{z}, ymmword ptr [r13+r9*8+0x10]
vmovupd ymm7{k1}{z}, ymmword ptr [r13+r9*8+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [r13+r9*8+0x18]
vmovupd ymm15{k1}{z}, ymmword ptr [r13+r9*8]
vmovupd ymm20{k1}{z}, ymmword ptr [r13+r9*8+0x20]
vmovupd ymm9{k1}{z}, ymmword ptr [rsi+r9*8+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [r10+r9*8+0x10]
vmovupd ymm13{k1}{z}, ymmword ptr [rdi+r9*8+0x10]
vmovupd ymm14{k1}{z}, ymmword ptr [r11+r9*8+0x10]
vmovupd ymm21{k1}{z}, ymmword ptr [r8+r9*8+0x10]
vmovupd ymm22{k1}{z}, ymmword ptr [r12+r9*8+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [r15+r9*8+0x10]
vmovupd ymm27{k1}{z}, ymmword ptr [rcx+r9*8+0x10]
vaddpd ymm10, ymm6, ymm7
vaddpd ymm11, ymm8, ymm9
vaddpd ymm16, ymm12, ymm13
vaddpd ymm17, ymm14, ymm15
vaddpd ymm24, ymm20, ymm21
vaddpd ymm25, ymm22, ymm23
vaddpd ymm18, ymm10, ymm11
vaddpd ymm19, ymm16, ymm17
vaddpd ymm26, ymm24, ymm25
vaddpd ymm28, ymm18, ymm19
vaddpd ymm29, ymm26, ymm27
vaddpd ymm30, ymm28, ymm29
vmulpd ymm31, ymm0, ymm30
vmovupd ymmword ptr [r14+r9*8+0x10]{k1}, ymm31
add r9, 0x4
cmp r9, rax
jb 0xffffffffffffff10
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
