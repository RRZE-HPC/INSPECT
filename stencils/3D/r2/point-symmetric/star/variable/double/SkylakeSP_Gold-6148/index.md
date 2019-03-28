---

title:  "Stencil 3D r2 star variable point-symmetric double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r2"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "variable"
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
double W[7][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   W[2][k][j][i] * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   W[3][k][j][i] * (a[k][j - 1][i] + a[k][j + 1][i]) +
                   W[4][k][j][i] * (a[k][j][i - 2] + a[k][j][i + 2]) +
                   W[5][k][j][i] * (a[k - 2][j][i] + a[k + 2][j][i]) +
                   W[6][k][j][i] * (a[k][j - 2][i] + a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm6, ymm5
vpaddq ymm5, ymm5, ymm4
vmovupd ymm10{k1}{z}, ymmword ptr [rax+r12*8+0x10]
vmovupd ymm15{k1}{z}, ymmword ptr [rsi+r12*8+0x10]
vmovupd ymm16{k1}{z}, ymmword ptr [r8+r12*8+0x10]
vmovupd ymm18{k1}{z}, ymmword ptr [r11+r12*8+0x10]
vmovupd ymm7{k1}{z}, ymmword ptr [rcx+r12*8+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rcx+r12*8+0x18]
vmovupd ymm19{k1}{z}, ymmword ptr [r9+r12*8+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [r10+r12*8+0x10]
vmovupd ymm11{k1}{z}, ymmword ptr [rbx+r12*8+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rdi+r12*8+0x10]
vmovupd ymm13{k1}{z}, ymmword ptr [rcx+r12*8]
vmovupd ymm14{k1}{z}, ymmword ptr [rcx+r12*8+0x20]
vmovupd ymm26{k1}{z}, ymmword ptr [r13+r12*8+0x10]
vmovupd ymm3{k1}{z}, ymmword ptr [rdx+r12*8+0x10]
vmovupd ymm2{k1}{z}, ymmword ptr [rcx+r12*8+0x10]
vaddpd ymm20, ymm15, ymm16
vaddpd ymm31, ymm7, ymm8
vaddpd ymm21, ymm11, ymm12
vaddpd ymm25, ymm13, ymm14
vmulpd ymm27, ymm19, ymm20
mov r15, qword ptr [rsp+0x358]
vmovupd ymm1{k1}{z}, ymmword ptr [r15+r12*8+0x10]
mov r15, qword ptr [rsp+0x360]
vmovupd ymm29{k1}{z}, ymmword ptr [r15+r12*8+0x10]
mov r15, qword ptr [rsp+0x368]
vmovupd ymm9{k1}{z}, ymmword ptr [r15+r12*8+0x10]
mov r15, qword ptr [rsp+0x350]
vaddpd ymm30, ymm9, ymm10
vmovupd ymm22{k1}{z}, ymmword ptr [r15+r12*8+0x10]
vmulpd ymm8, ymm29, ymm30
vfmadd231pd ymm27, ymm21, ymm22
vfmadd231pd ymm8, ymm31, ymm1
mov r15, qword ptr [rsp+0x378]
vfmadd231pd ymm8, ymm2, ymm3
vmovupd ymm17{k1}{z}, ymmword ptr [r15+r12*8+0x10]
vaddpd ymm24, ymm17, ymm18
vmulpd ymm28, ymm23, ymm24
vfmadd231pd ymm28, ymm25, ymm26
vaddpd ymm7, ymm27, ymm28
vaddpd ymm1, ymm7, ymm8
vmovupd ymmword ptr [r14+r12*8+0x10]{k1}, ymm1
add r12, 0x4
cmp r12, qword ptr [rsp+0x318]
jb 0xfffffffffffffe8a
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/17;P <= 240
L2: P <= 131072/17;P <= 7710
L3: P <= 3670016/17;P <= 215880
L1: 88*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P <= 10²
L2: 88*N*P + 16*P*(N - 2) + 32*P <= 1048576;N*P <= 90²
L3: 88*N*P + 16*P*(N - 2) + 32*P <= 29360128;N*P <= 510²
{%- endcapture -%}

{% include stencil_template.md %}
