---

title:  "Stencil 3D r2 star constant isotropic double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r2"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "15"
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

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = c0 * a[k][j][i] +
                   c1 * ((a[k][j][i - 1] + a[k][j][i + 1]) +
                         (a[k - 1][j][i] + a[k + 1][j][i]) +
                         (a[k][j - 1][i] + a[k][j + 1][i])) +
                   c2 * ((a[k][j][i - 2] + a[k][j][i + 2]) +
                         (a[k - 2][j][i] + a[k + 2][j][i]) +
                         (a[k][j - 2][i] + a[k][j + 2][i]));
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm5, ymm6
vpaddq ymm6, ymm6, ymm4
vmovupd ymm7{k1}{z}, ymmword ptr [rdi+r15*8+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rdi+r15*8+0x18]
vmovupd ymm10{k1}{z}, ymmword ptr [r8+r15*8+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rsi+r15*8+0x10]
vmovupd ymm14{k1}{z}, ymmword ptr [r9+r15*8+0x10]
vmovupd ymm19{k1}{z}, ymmword ptr [rdi+r15*8]
vmovupd ymm20{k1}{z}, ymmword ptr [rdi+r15*8+0x20]
vmovupd ymm16{k1}{z}, ymmword ptr [rbx+r15*8+0x10]
vmovupd ymm22{k1}{z}, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm24{k1}{z}, ymmword ptr [rcx+r15*8+0x10]
vmovupd ymm26{k1}{z}, ymmword ptr [r11+r15*8+0x10]
vmovupd ymm18{k1}{z}, ymmword ptr [rdi+r15*8+0x10]
vmovupd ymm28{k1}{z}, ymmword ptr [rdx+r15*8+0x10]
vaddpd ymm9, ymm7, ymm8
vaddpd ymm21, ymm19, ymm20
vaddpd ymm11, ymm9, ymm10
vaddpd ymm23, ymm21, ymm22
vaddpd ymm13, ymm11, ymm12
vaddpd ymm25, ymm23, ymm24
vaddpd ymm15, ymm13, ymm14
vaddpd ymm27, ymm25, ymm26
vaddpd ymm17, ymm15, ymm16
vaddpd ymm29, ymm27, ymm28
vmulpd ymm30, ymm1, ymm17
vfmadd231pd ymm30, ymm18, ymm2
vfmadd231pd ymm30, ymm29, ymm0
vmovupd ymmword ptr [rax+r15*8+0x10]{k1}, ymm30
add r15, 0x4
cmp r15, r12
jb 0xffffffffffffff12
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
