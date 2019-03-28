---

title:  "Stencil 3D r2 star constant homogeneous float SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r2"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "float"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "1450" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
float a[M][N][P];
float b[M][N][P];
float c0;

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
vpcmpgtq k0, ymm3, ymm1
vpcmpgtq k1, ymm3, ymm2
vpaddq ymm2, ymm2, ymm5
vpaddq ymm1, ymm1, ymm5
kshiftlw k2, k0, 0x4
korw k3, k1, k2
vmovups ymm7{k3}{z}, ymmword ptr [rsi+r15*4+0x8]
vmovups ymm8{k3}{z}, ymmword ptr [rsi+r15*4+0x4]
vmovups ymm9{k3}{z}, ymmword ptr [rsi+r15*4+0xc]
vmovups ymm16{k3}{z}, ymmword ptr [rsi+r15*4]
vmovups ymm21{k3}{z}, ymmword ptr [rsi+r15*4+0x10]
vmovups ymm10{k3}{z}, ymmword ptr [r9+r15*4+0x8]
vmovups ymm13{k3}{z}, ymmword ptr [rbx+r15*4+0x8]
vmovups ymm14{k3}{z}, ymmword ptr [r10+r15*4+0x8]
vmovups ymm15{k3}{z}, ymmword ptr [rcx+r15*4+0x8]
vmovups ymm22{k3}{z}, ymmword ptr [r11+r15*4+0x8]
vmovups ymm23{k3}{z}, ymmword ptr [rdx+r15*4+0x8]
vmovups ymm24{k3}{z}, ymmword ptr [r12+r15*4+0x8]
vmovups ymm28{k3}{z}, ymmword ptr [rax+r15*4+0x8]
vaddps ymm11, ymm7, ymm8
vaddps ymm12, ymm9, ymm10
vaddps ymm17, ymm13, ymm14
vaddps ymm18, ymm15, ymm16
vaddps ymm25, ymm21, ymm22
vaddps ymm26, ymm23, ymm24
vaddps ymm19, ymm11, ymm12
vaddps ymm20, ymm17, ymm18
vaddps ymm27, ymm25, ymm26
vaddps ymm29, ymm19, ymm20
vaddps ymm30, ymm27, ymm28
vaddps ymm31, ymm29, ymm30
vmulps ymm7, ymm0, ymm31
vmovups ymmword ptr [r13+r15*4+0x8]{k3}, ymm7
add r15, 0x8
cmp r15, r14
jb 0xfffffffffffffef9
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/5;P <= 810
L2: P <= 131072/5;P <= 26210
L3: P <= 3670016/5;P <= 734000
L1: 16*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P <= 20²
L2: 16*N*P + 8*P*(N - 2) + 16*P <= 1048576;N*P <= 170²
L3: 16*N*P + 8*P*(N - 2) + 16*P <= 29360128;N*P <= 1020²
{%- endcapture -%}

{% include stencil_template.md %}
