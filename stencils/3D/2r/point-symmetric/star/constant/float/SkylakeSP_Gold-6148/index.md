---

title:  "Stencil 3D r2 star constant point-symmetric float SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "2r"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "constant"
datatype     : "float"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
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
float c1;
float c2;
float c3;
float c4;
float c5;
float c6;

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
vpcmpgtq k0, ymm5, ymm3
vpcmpgtq k1, ymm5, ymm4
vpaddq ymm4, ymm4, ymm14
vpaddq ymm3, ymm3, ymm14
kshiftlw k2, k0, 0x4
korw k3, k1, k2
vmovups ymm15{k3}{z}, ymmword ptr [rsi+r15*4+0x4]
vmovups ymm16{k3}{z}, ymmword ptr [rsi+r15*4+0xc]
vmovups ymm17{k3}{z}, ymmword ptr [rdi+r15*4+0x8]
vmovups ymm18{k3}{z}, ymmword ptr [rbx+r15*4+0x8]
vmovups ymm23{k3}{z}, ymmword ptr [r11+r15*4+0x8]
vmovups ymm24{k3}{z}, ymmword ptr [rdx+r15*4+0x8]
vmovups ymm25{k3}{z}, ymmword ptr [r12+r15*4+0x8]
vmovups ymm26{k3}{z}, ymmword ptr [rax+r15*4+0x8]
vmovups ymm19{k3}{z}, ymmword ptr [r10+r15*4+0x8]
vmovups ymm20{k3}{z}, ymmword ptr [rcx+r15*4+0x8]
vmovups ymm21{k3}{z}, ymmword ptr [rsi+r15*4]
vmovups ymm22{k3}{z}, ymmword ptr [rsi+r15*4+0x10]
vmovups ymm2{k3}{z}, ymmword ptr [rsi+r15*4+0x8]
vaddps ymm0, ymm15, ymm16
vaddps ymm15, ymm17, ymm18
vaddps ymm27, ymm23, ymm24
vaddps ymm29, ymm25, ymm26
vaddps ymm28, ymm19, ymm20
vaddps ymm30, ymm21, ymm22
vmulps ymm17, ymm9, ymm15
vmulps ymm31, ymm6, ymm27
vmulps ymm19, ymm1, ymm29
vfmadd231ps ymm17, ymm0, ymm10
vfmadd231ps ymm31, ymm28, ymm8
vfmadd231ps ymm19, ymm30, ymm7
vfmadd231ps ymm17, ymm2, ymm11
vaddps ymm16, ymm31, ymm19
vaddps ymm0, ymm16, ymm17
vmovups ymmword ptr [r13+r15*4+0x8]{k3}, ymm0
add r15, 0x8
cmp r15, r14
jb 0xfffffffffffffee9
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/5;P ~ 810
L2: P <= 131072/5;P ~ 26210
L3: P <= 3670016/5;P ~ 734000
L1: 16*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P ~ 20²
L2: 16*N*P + 8*P*(N - 2) + 16*P <= 1048576;N*P ~ 170²
L3: 16*N*P + 8*P*(N - 2) + 16*P <= 29360128;N*P ~ 1020²
{%- endcapture -%}

{% include stencil_template.md %}
