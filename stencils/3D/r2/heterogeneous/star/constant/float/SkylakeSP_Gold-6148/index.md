---

title:  "Stencil 3D r2 star constant heterogeneous float SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r2"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "float"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "25"
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
float c7;
float c8;
float c9;
float c10;
float c11;
float c12;

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = c0 * a[k][j][i] + c1 * a[k][j][i - 1] +
                   c2 * a[k][j][i + 1] + c3 * a[k - 1][j][i] +
                   c4 * a[k + 1][j][i] + c5 * a[k][j - 1][i] +
                   c6 * a[k][j + 1][i] + c7 * a[k][j][i - 2] +
                   c8 * a[k][j][i + 2] + c9 * a[k - 2][j][i] +
                   c10 * a[k + 2][j][i] + c11 * a[k][j - 2][i] +
                   c12 * a[k][j + 2][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k0, ymm11, ymm9
vpcmpgtq k1, ymm11, ymm10
vpaddq ymm10, ymm10, ymm26
vpaddq ymm9, ymm9, ymm26
kshiftlw k2, k0, 0x4
korw k3, k1, k2
vmovups ymm8{k3}{z}, ymmword ptr [rsi+r15*4]
vmovups ymm2{k3}{z}, ymmword ptr [rsi+r15*4+0x10]
vmovups ymm7{k3}{z}, ymmword ptr [rbx+r15*4+0x8]
vmovups ymm0{k3}{z}, ymmword ptr [r10+r15*4+0x8]
vmovups ymm29{k3}{z}, ymmword ptr [r12+r15*4+0x8]
vmulps ymm8, ymm16, ymm8
vmovups ymm3{k3}{z}, ymmword ptr [rdi+r15*4+0x8]
vmovups ymm30{k3}{z}, ymmword ptr [r11+r15*4+0x8]
vmovups ymm28{k3}{z}, ymmword ptr [rax+r15*4+0x8]
vmulps ymm29, ymm27, ymm29
vfmadd231ps ymm8, ymm0, ymm18
vmulps ymm0, ymm15, ymm2
vmulps ymm2, ymm19, ymm7
vmovups ymm4{k3}{z}, ymmword ptr [rsi+r15*4+0xc]
vmovups ymm1{k3}{z}, ymmword ptr [rcx+r15*4+0x8]
vmovups ymm31{k3}{z}, ymmword ptr [rdx+r15*4+0x8]
vfmadd231ps ymm29, ymm30, ymm14
vfmadd231ps ymm2, ymm3, ymm20
vmulps ymm30, ymm12, ymm28
vmovups ymm5{k3}{z}, ymmword ptr [rsi+r15*4+0x4]
vfmadd231ps ymm0, ymm1, ymm17
vmovups ymm6{k3}{z}, ymmword ptr [rsi+r15*4+0x8]
vfmadd231ps ymm2, ymm4, ymm21
vfmadd231ps ymm30, ymm31, ymm13
vaddps ymm1, ymm8, ymm0
vfmadd231ps ymm2, ymm5, ymm22
vaddps ymm28, ymm29, ymm30
vfmadd231ps ymm2, ymm6, ymm23
vaddps ymm3, ymm28, ymm1
vaddps ymm4, ymm3, ymm2
vmovups ymmword ptr [r13+r15*4+0x8]{k3}, ymm4
add r15, 0x8
cmp r15, r14
jb 0xfffffffffffffee1
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
