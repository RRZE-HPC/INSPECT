---

title:  "Stencil 3D r2 star variable heterogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "25"
scaling      : [ "650" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[13][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * a[k][j][i - 1] +
                   W[2][k][j][i] * a[k][j][i + 1] +
                   W[3][k][j][i] * a[k - 1][j][i] +
                   W[4][k][j][i] * a[k + 1][j][i] +
                   W[5][k][j][i] * a[k][j - 1][i] +
                   W[6][k][j][i] * a[k][j + 1][i] +
                   W[7][k][j][i] * a[k][j][i - 2] +
                   W[8][k][j][i] * a[k][j][i + 2] +
                   W[9][k][j][i] * a[k - 2][j][i] +
                   W[10][k][j][i] * a[k + 2][j][i] +
                   W[11][k][j][i] * a[k][j - 2][i] +
                   W[12][k][j][i] * a[k][j + 2][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm18, ymm17
vpaddq ymm17, ymm17, ymm21
vmovupd ymm1{k1}{z}, ymmword ptr [r11+r13*8+0x10]
vmovupd ymm0{k1}{z}, ymmword ptr [rax+r13*8]
vmovupd ymm4{k1}{z}, ymmword ptr [rax+r13*8+0x20]
vmovupd ymm3{k1}{z}, ymmword ptr [r12+r13*8+0x10]
vmovupd ymm8{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [rdi+r13*8+0x10]
vmulpd ymm0, ymm1, ymm0
vmovupd ymm10{k1}{z}, ymmword ptr [rax+r13*8+0x18]
vmulpd ymm1, ymm3, ymm4
vmovupd ymm19{k1}{z}, ymmword ptr [rbx+r13*8+0x10]
vmovupd ymm6{k1}{z}, ymmword ptr [r14+r13*8+0x10]
vmovupd ymm5{k1}{z}, ymmword ptr [r10+r13*8+0x10]
vmovupd ymm24{k1}{z}, ymmword ptr [rsi+r13*8+0x10]
vmovupd ymm13{k1}{z}, ymmword ptr [rdx+r13*8+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rax+r13*8+0x8]
vmovupd ymm14{k1}{z}, ymmword ptr [rax+r13*8+0x10]
vfmadd231pd ymm1, ymm5, ymm6
vmovupd ymm15{k1}{z}, ymmword ptr [r9+r13*8+0x10]
mov r15, qword ptr [rsp+0x478]
vmovupd ymm11{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x460]
vmovupd ymm9{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x448]
vmovupd ymm16{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x468]
vmovupd ymm7{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x438]
vmulpd ymm3, ymm16, ymm7
vmovupd ymm2{k1}{z}, ymmword ptr [r15+r13*8+0x10]
vfmadd231pd ymm3, ymm8, ymm9
vfmadd231pd ymm0, ymm19, ymm2
vfmadd231pd ymm3, ymm10, ymm11
vaddpd ymm2, ymm0, ymm1
vfmadd231pd ymm3, ymm12, ymm13
mov r15, qword ptr [rsp+0x408]
vfmadd231pd ymm3, ymm14, ymm15
vmovupd ymm25{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x3f8]
vmovupd ymm29{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x458]
vmovupd ymm28{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x3e8]
nop
vmovupd ymm22{k1}{z}, ymmword ptr [r15+r13*8+0x10]
mov r15, qword ptr [rsp+0x3c8]
vmulpd ymm30, ymm22, ymm23
vmovupd ymm26{k1}{z}, ymmword ptr [r15+r13*8+0x10]
vfmadd231pd ymm30, ymm24, ymm25
mov r15, qword ptr [rsp+0x3d8]
vmovupd ymm27{k1}{z}, ymmword ptr [r15+r13*8+0x10]
vmulpd ymm31, ymm26, ymm27
vfmadd231pd ymm31, ymm28, ymm29
vaddpd ymm22, ymm30, ymm31
vaddpd ymm8, ymm22, ymm2
vaddpd ymm4, ymm8, ymm3
vmovupd ymmword ptr [r8+r13*8+0x10]{k1}, ymm4
add r13, 0x4
cmp r13, qword ptr [rsp+0x3c0]
jb 0xfffffffffffffe14
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/23;P ~ 170
L2: P <= 131072/23;P ~ 5690
L3: P <= 3670016/23;P ~ 159560
L1: 136*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P ~ 10²
L2: 136*N*P + 16*P*(N - 2) + 32*P <= 1048576;N*P ~ 80²
L3: 136*N*P + 16*P*(N - 2) + 32*P <= 29360128;N*P ~ 430²
{%- endcapture -%}

{% include stencil_template.md %}
