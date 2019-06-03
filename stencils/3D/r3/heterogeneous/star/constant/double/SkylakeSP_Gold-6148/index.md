---

title:  "Stencil 3D r3 star constant heterogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r3"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "37"
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

for (long k = 3; k < M - 3; ++k) {
  for (long j = 3; j < N - 3; ++j) {
    for (long i = 3; i < P - 3; ++i) {
      b[k][j][i] = c0 * a[k][j][i] + c1 * a[k][j][i - 1] +
                   c2 * a[k][j][i + 1] + c3 * a[k - 1][j][i] +
                   c4 * a[k + 1][j][i] + c5 * a[k][j - 1][i] +
                   c6 * a[k][j + 1][i] + c7 * a[k][j][i - 2] +
                   c8 * a[k][j][i + 2] + c9 * a[k - 2][j][i] +
                   c10 * a[k + 2][j][i] + c11 * a[k][j - 2][i] +
                   c12 * a[k][j + 2][i] + c13 * a[k][j][i - 3] +
                   c14 * a[k][j][i + 3] + c15 * a[k - 3][j][i] +
                   c16 * a[k + 3][j][i] + c17 * a[k][j - 3][i] +
                   c18 * a[k][j + 3][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm29, ymm9
vpaddq ymm9, ymm9, ymm27
vmovupd ymm2{k1}{z}, ymmword ptr [rdi+r13*8+0x18]
vmovupd ymm3{k1}{z}, ymmword ptr [rdx+r13*8+0x18]
vmovupd ymm31{k1}{z}, ymmword ptr [r9+r13*8+0x18]
vmovupd ymm0{k1}{z}, ymmword ptr [rcx+r13*8+0x8]
vmovupd ymm6{k1}{z}, ymmword ptr [rax+r13*8+0x18]
vmulpd ymm2, ymm20, ymm2
vmovupd ymm30{k1}{z}, ymmword ptr [rcx+r13*8+0x28]
vmulpd ymm31, ymm19, ymm31
vmovupd ymm7{k1}{z}, ymmword ptr [rcx+r13*8+0x20]
vmovupd ymm4{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
vfmadd231pd ymm2, ymm3, ymm22
vmovupd ymm5{k1}{z}, ymmword ptr [rcx+r13*8+0x18]
vfmadd231pd ymm31, ymm6, ymm21
vmovupd ymm6{k1}{z}, ymmword ptr [rcx+r13*8]
vmulpd ymm7, ymm23, ymm7
vaddpd ymm31, ymm2, ymm31
vmovupd ymm2{k1}{z}, ymmword ptr [rcx+r13*8+0x30]
vmulpd ymm6, ymm12, ymm6
vfmadd231pd ymm7, ymm4, ymm24
vmulpd ymm2, ymm11, ymm2
vfmadd231pd ymm7, ymm5, ymm25
mov r15, qword ptr [rsp+0x370]
vmovupd ymm3{k1}{z}, ymmword ptr [r15+r13*8+0x18]
vmulpd ymm3, ymm16, ymm3
vfmadd231pd ymm3, ymm0, ymm18
vmovupd ymm0{k1}{z}, ymmword ptr [r14+r13*8+0x18]
vmulpd ymm0, ymm15, ymm0
vfmadd231pd ymm0, ymm30, ymm17
vmovupd ymm30{k1}{z}, ymmword ptr [rbx+r13*8+0x18]
vaddpd ymm0, ymm3, ymm0
vmovupd ymm3{k1}{z}, ymmword ptr [r10+r13*8+0x18]
vfmadd231pd ymm6, ymm30, ymm14
vmovupd ymm30{k1}{z}, ymmword ptr [r11+r13*8+0x18]
vaddpd ymm0, ymm0, ymm31
vfmadd231pd ymm2, ymm3, ymm13
vmovupd ymm3{k1}{z}, ymmword ptr [rsi+r13*8+0x18]
vaddpd ymm2, ymm6, ymm2
vmovupd ymm6{k1}{z}, ymmword ptr [r12+r13*8+0x18]
vmulpd ymm3, ymm28, ymm3
vmulpd ymm6, ymm1, ymm6
mov r15, qword ptr [rsp+0x378]
vfmadd231pd ymm6, ymm30, ymm8
vmovupd ymm31{k1}{z}, ymmword ptr [r15+r13*8+0x18]
vfmadd231pd ymm3, ymm31, ymm10
vaddpd ymm3, ymm3, ymm6
vaddpd ymm4, ymm3, ymm2
vaddpd ymm5, ymm4, ymm0
vaddpd ymm0, ymm5, ymm7
vmovupd ymmword ptr [r8+r13*8+0x18]{k1}, ymm0
add r13, 0x4
cmp r13, qword ptr [rsp+0x350]
jb 0xfffffffffffffe76
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P <= 290
L2: P <= 65536/7;P <= 9360
L3: P <= 262144;P <= 262140
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;N*P <= 10²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 1048576;N*P <= 120²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 29360128;N*P <= 510²
{%- endcapture -%}

{% include stencil_template.md %}
