---

title:  "Stencil 3D r3 star constant homogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r3"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
scaling      : [ "770" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for (long k = 3; k < M - 3; ++k) {
  for (long j = 3; j < N - 3; ++j) {
    for (long i = 3; i < P - 3; ++i) {
      b[k][j][i] =
          c0 * (a[k][j][i] + a[k][j][i - 1] + a[k][j][i + 1] +
                a[k - 1][j][i] + a[k + 1][j][i] + a[k][j - 1][i] +
                a[k][j + 1][i] + a[k][j][i - 2] + a[k][j][i + 2] +
                a[k - 2][j][i] + a[k + 2][j][i] + a[k][j - 2][i] +
                a[k][j + 2][i] + a[k][j][i - 3] + a[k][j][i + 3] +
                a[k - 3][j][i] + a[k + 3][j][i] + a[k][j - 3][i] +
                a[k][j + 3][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm8, ymm7
vpaddq ymm7, ymm7, ymm10
vmovupd ymm12{k1}{z}, ymmword ptr [rax+r13*8+0x18]
vmovupd ymm13{k1}{z}, ymmword ptr [rax+r13*8+0x10]
vmovupd ymm14{k1}{z}, ymmword ptr [rax+r13*8+0x20]
vmovupd ymm21{k1}{z}, ymmword ptr [rax+r13*8+0x8]
vmovupd ymm26{k1}{z}, ymmword ptr [rax+r13*8+0x28]
vmovupd ymm0{k1}{z}, ymmword ptr [rax+r13*8]
vmovupd ymm9{k1}{z}, ymmword ptr [rax+r13*8+0x30]
vmovupd ymm15{k1}{z}, ymmword ptr [rdi+r13*8+0x18]
vmovupd ymm19{k1}{z}, ymmword ptr [r8+r13*8+0x18]
vmovupd ymm20{k1}{z}, ymmword ptr [r14+r13*8+0x18]
vmovupd ymm27{k1}{z}, ymmword ptr [rdx+r13*8+0x18]
vmovupd ymm29{k1}{z}, ymmword ptr [rcx+r13*8+0x18]
vmovupd ymm1{k1}{z}, ymmword ptr [r10+r13*8+0x18]
vmovupd ymm3{k1}{z}, ymmword ptr [rbx+r13*8+0x18]
vmovupd ymm6{k1}{z}, ymmword ptr [r11+r13*8+0x18]
vmovupd ymm4{k1}{z}, ymmword ptr [rsi+r13*8+0x18]
vmovupd ymm5{k1}{z}, ymmword ptr [r12+r13*8+0x18]
vaddpd ymm16, ymm12, ymm13
vaddpd ymm17, ymm14, ymm15
vaddpd ymm23, ymm20, ymm21
vaddpd ymm30, ymm26, ymm27
vaddpd ymm0, ymm1, ymm0
vaddpd ymm1, ymm9, ymm3
vaddpd ymm24, ymm16, ymm17
vaddpd ymm4, ymm6, ymm4
vaddpd ymm3, ymm0, ymm1
vaddpd ymm5, ymm4, ymm5
mov r15, qword ptr [rsp+0x2c0]
vmovupd ymm18{k1}{z}, ymmword ptr [r15+r13*8+0x18]
mov r15, qword ptr [rsp+0x2b0]
vaddpd ymm22, ymm18, ymm19
vmovupd ymm28{k1}{z}, ymmword ptr [r15+r13*8+0x18]
vaddpd ymm25, ymm22, ymm23
vaddpd ymm31, ymm28, ymm29
vaddpd ymm12, ymm24, ymm25
vaddpd ymm26, ymm30, ymm31
vaddpd ymm9, ymm26, ymm3
vaddpd ymm13, ymm12, ymm9
vaddpd ymm6, ymm13, ymm5
vmulpd ymm14, ymm2, ymm6
vmovupd ymmword ptr [r9+r13*8+0x18]{k1}, ymm14
add r13, 0x4
cmp r13, qword ptr [rsp+0x2a8]
jb 0xfffffffffffffea1
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P <= 290
L2: P <= 65536/7;P <= 9360
L3: P <= 262144;P <= 262140
L1: 48*P + 16*P*(N - 3) + 48*P <= 32768;N*P <= 10²
L2: 48*P + 16*P*(N - 3) + 48*P <= 1048576;N*P <= 120²
L3: 48*P + 16*P*(N - 3) + 48*P <= 29360128;N*P <= 510²
{%- endcapture -%}

{% include stencil_template.md %}
