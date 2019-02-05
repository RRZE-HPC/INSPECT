---

title:  "Stencil 3D r2 star variable homogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "2r"
weighting    : "homogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "770" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[1][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] *
                   (a[k][j][i] + a[k][j][i - 1] + a[k][j][i + 1] +
                    a[k - 1][j][i] + a[k + 1][j][i] + a[k][j - 1][i] +
                    a[k][j + 1][i] + a[k][j][i - 2] + a[k][j][i + 2] +
                    a[k - 2][j][i] + a[k + 2][j][i] + a[k][j - 2][i] +
                    a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm2, ymm3
vpaddq ymm3, ymm3, ymm1
vmovupd ymm4{k1}{z}, ymmword ptr [r9+r13*8+0x10]
vmovupd ymm5{k1}{z}, ymmword ptr [r9+r13*8+0x8]
vmovupd ymm6{k1}{z}, ymmword ptr [r9+r13*8+0x18]
vmovupd ymm13{k1}{z}, ymmword ptr [r9+r13*8]
vmovupd ymm18{k1}{z}, ymmword ptr [r9+r13*8+0x20]
vmovupd ymm7{k1}{z}, ymmword ptr [r10+r13*8+0x10]
vmovupd ymm10{k1}{z}, ymmword ptr [rdi+r13*8+0x10]
vmovupd ymm11{k1}{z}, ymmword ptr [r15+r13*8+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rsi+r13*8+0x10]
vmovupd ymm19{k1}{z}, ymmword ptr [r11+r13*8+0x10]
vmovupd ymm20{k1}{z}, ymmword ptr [rbx+r13*8+0x10]
vmovupd ymm21{k1}{z}, ymmword ptr [r12+r13*8+0x10]
vmovupd ymm25{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
vaddpd ymm8, ymm4, ymm5
vaddpd ymm9, ymm6, ymm7
vaddpd ymm14, ymm10, ymm11
vaddpd ymm15, ymm12, ymm13
vaddpd ymm22, ymm18, ymm19
vaddpd ymm23, ymm20, ymm21
vaddpd ymm16, ymm8, ymm9
vaddpd ymm17, ymm14, ymm15
vaddpd ymm24, ymm22, ymm23
vaddpd ymm26, ymm16, ymm17
vaddpd ymm27, ymm24, ymm25
vaddpd ymm28, ymm26, ymm27
vmulpd ymm29{k1}{z}, ymm28, ymmword ptr [r8+r13*8+0x10]
vmovupd ymmword ptr [r14+r13*8+0x10]{k1}, ymm29
add r13, 0x4
cmp r13, rax
jb 0xffffffffffffff0f
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/11;P ~ 370
L2: P <= 131072/11;P ~ 11910
L3: P <= 3670016/11;P ~ 333630
L1: 40*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P ~ 10²
L2: 40*N*P + 16*P*(N - 2) + 32*P <= 1048576;N*P ~ 100²
L3: 40*N*P + 16*P*(N - 2) + 32*P <= 29360128;N*P ~ 510²
{%- endcapture -%}

{% include stencil_template.md %}
