---

title:  "Stencil 3D r1 star variable heterogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r1"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "870" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[7][M][N][P];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * a[k][j][i - 1] +
                   W[2][k][j][i] * a[k][j][i + 1] +
                   W[3][k][j][i] * a[k - 1][j][i] +
                   W[4][k][j][i] * a[k + 1][j][i] +
                   W[5][k][j][i] * a[k][j - 1][i] +
                   W[6][k][j][i] * a[k][j + 1][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtd k1, xmm2, xmm3
add r9, 0x4
vpaddd xmm3, xmm3, xmm1
vmovupd ymm14{k1}{z}, ymmword ptr [rdi+rcx*1+0x8]
vmovupd ymm15{k1}{z}, ymmword ptr [rdi+r8*1+0x10]
vmovupd ymm4{k1}{z}, ymmword ptr [rdi+r12*1+0x8]
vmovupd ymm5{k1}{z}, ymmword ptr [rdi+rbx*1+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rdi+rax*1+0x8]
vmovupd ymm9{k1}{z}, ymmword ptr [rdi+r13*1+0x8]
vmovupd ymm16{k1}{z}, ymmword ptr [rdi+r8*1]
vmulpd ymm21, ymm14, ymm15
vmovupd ymm7{k1}{z}, ymmword ptr [rdi+r10*1+0x8]
vmovupd ymm6{k1}{z}, ymmword ptr [rdi+r14*1+0x8]
vmovupd ymm11{k1}{z}, ymmword ptr [rdi+r11*1+0x8]
vmovupd ymm10{k1}{z}, ymmword ptr [rdi+rdx*1+0x8]
vmulpd ymm12, ymm4, ymm5
vmulpd ymm13, ymm8, ymm9
vmovupd ymm19{k1}{z}, ymmword ptr [rdi+rsi*1+0x8]
vmovupd ymm18{k1}{z}, ymmword ptr [rdi+r8*1+0x8]
vfmadd231pd ymm12, ymm6, ymm7
vfmadd231pd ymm13, ymm10, ymm11
mov r15, qword ptr [rsp+0x1e8]
vaddpd ymm20, ymm12, ymm13
vmovupd ymm17{k1}{z}, ymmword ptr [rdi+r15*1+0x8]
vfmadd231pd ymm21, ymm16, ymm17
vfmadd231pd ymm21, ymm18, ymm19
vaddpd ymm22, ymm20, ymm21
mov r15, qword ptr [rsp+0x1d0]
vmovupd ymmword ptr [rdi+r15*1+0x8]{k1}, ymm22
add rdi, 0x20
cmp r9, qword ptr [rsp+0x1c8]
jb 0xffffffffffffff04
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4107/13;P <= 310
L2: P <= 131083/13;P <= 10080
L3: P <= 3670027/13;P <= 282300
L1: 72*N*P + 16*P*(N - 1) - 56*P <= 32768;N*P <= 10²
L2: 72*N*P + 16*P*(N - 1) - 56*P <= 1048576;N*P <= 100²
L3: 72*N*P + 16*P*(N - 1) - 56*P <= 29360128;N*P <= 570²
{%- endcapture -%}

{% include stencil_template.md %}
