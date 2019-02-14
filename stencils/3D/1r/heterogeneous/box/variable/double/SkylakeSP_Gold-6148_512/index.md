---

title:  "Stencil 3D r1 box variable heterogeneous double SkylakeSP_Gold-6148_512"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "variable"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_avx512"
flavor       : "AVX 512"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopt-zmm-usage=high -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "53"
scaling      : [ "520" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[27][M][N][P];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * a[k - 1][j - 1][i - 1] +
                   W[2][k][j][i] * a[k][j - 1][i - 1] +
                   W[3][k][j][i] * a[k + 1][j - 1][i - 1] +
                   W[4][k][j][i] * a[k - 1][j][i - 1] +
                   W[5][k][j][i] * a[k][j][i - 1] +
                   W[6][k][j][i] * a[k + 1][j][i - 1] +
                   W[7][k][j][i] * a[k - 1][j + 1][i - 1] +
                   W[8][k][j][i] * a[k][j + 1][i - 1] +
                   W[9][k][j][i] * a[k + 1][j + 1][i - 1] +
                   W[10][k][j][i] * a[k - 1][j - 1][i] +
                   W[11][k][j][i] * a[k][j - 1][i] +
                   W[12][k][j][i] * a[k + 1][j - 1][i] +
                   W[13][k][j][i] * a[k - 1][j][i] +
                   W[14][k][j][i] * a[k + 1][j][i] +
                   W[15][k][j][i] * a[k - 1][j + 1][i] +
                   W[16][k][j][i] * a[k][j + 1][i] +
                   W[17][k][j][i] * a[k + 1][j + 1][i] +
                   W[18][k][j][i] * a[k - 1][j - 1][i + 1] +
                   W[19][k][j][i] * a[k][j - 1][i + 1] +
                   W[20][k][j][i] * a[k + 1][j - 1][i + 1] +
                   W[21][k][j][i] * a[k - 1][j][i + 1] +
                   W[22][k][j][i] * a[k][j][i + 1] +
                   W[23][k][j][i] * a[k + 1][j][i + 1] +
                   W[24][k][j][i] * a[k - 1][j + 1][i + 1] +
                   W[25][k][j][i] * a[k][j + 1][i + 1] +
                   W[26][k][j][i] * a[k + 1][j + 1][i + 1];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtd k1, ymm23, ymm22
vpaddd ymm22, ymm22, ymm21
vmovupd zmm26{k1}{z}, zmmword ptr [rdx+r13*8+0x8]
vmovupd zmm27{k1}{z}, zmmword ptr [r8+r13*8+0x8]
vmovupd zmm31{k1}{z}, zmmword ptr [rcx+r13*8+0x8]
vmovupd zmm29{k1}{z}, zmmword ptr [r14+r13*8]
vmovupd zmm17{k1}{z}, zmmword ptr [rax+r13*8]
vmovupd zmm4{k1}{z}, zmmword ptr [rsi+r13*8]
vmovupd zmm5{k1}{z}, zmmword ptr [rcx+r13*8]
vmovupd zmm7{k1}{z}, zmmword ptr [rbx+r13*8]
vmovupd zmm1{k1}{z}, zmmword ptr [rdi+r13*8+0x8]
vmovupd zmm11{k1}{z}, zmmword ptr [r8+r13*8]
vmovupd zmm8{k1}{z}, zmmword ptr [rdx+r13*8]
vmovupd zmm2{k1}{z}, zmmword ptr [r9+r13*8]
vmovupd zmm12{k1}{z}, zmmword ptr [rdi+r13*8]
vmovupd zmm14{k1}{z}, zmmword ptr [rsi+r13*8+0x8]
mov r15, qword ptr [rsp+0x298]
vmovupd zmm15{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x288]
vmovupd zmm13{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x2a0]
vmovupd zmm18{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x2b8]
vmovupd zmm6{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x2c8]
vmovupd zmm9{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x2d8]
vmovupd zmm20{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x2e8]
vmulpd zmm4, zmm20, zmm4
vmovupd zmm10{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vfmadd231pd zmm4, zmm5, zmm6
vmulpd zmm5, zmm10, zmm7
vmulpd zmm6, zmm18, zmm11
vfmadd231pd zmm5, zmm8, zmm9
vfmadd231pd zmm6, zmm12, zmm13
mov r15, qword ptr [rsp+0x300]
vfmadd231pd zmm6, zmm14, zmm15
vmovupd zmm16{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x340]
vmovupd zmm3{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x350]
vmovupd zmm25{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x360]
vmulpd zmm25, zmm25, zmm29
vmovupd zmm19{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmovupd zmm29{k1}{z}, zmmword ptr [r14+r13*8+0x8]
vfmadd231pd zmm25, zmm17, zmm16
vmovupd zmm17{k1}{z}, zmmword ptr [rdx+r13*8+0x10]
vmulpd zmm1, zmm19, zmm1
mov r15, qword ptr [rsp+0x368]
vfmadd231pd zmm1, zmm2, zmm3
vmovupd zmm28{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vaddpd zmm2, zmm25, zmm1
vaddpd zmm3, zmm4, zmm5
mov r15, qword ptr [rsp+0x370]
vaddpd zmm14, zmm2, zmm3
vmovupd zmm30{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vaddpd zmm8, zmm14, zmm6
data16 nop
mov r15, qword ptr [rsp+0x378]
vmovupd zmm24{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmulpd zmm24, zmm24, zmm26
mov r15, qword ptr [rsp+0x388]
vfmadd231pd zmm24, zmm27, zmm28
vmovupd zmm28{k1}{z}, zmmword ptr [rbx+r13*8+0x8]
vmovupd zmm26{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmulpd zmm26, zmm26, zmm28
vmovupd zmm28{k1}{z}, zmmword ptr [rax+r13*8+0x8]
vfmadd231pd zmm26, zmm31, zmm30
vmovupd zmm30{k1}{z}, zmmword ptr [r9+r13*8+0x8]
vaddpd zmm24, zmm24, zmm26
nop
mov r15, qword ptr [rsp+0x398]
vmovupd zmm27{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x3a8]
vmovupd zmm31{k1}{z}, zmmword ptr [r15+r13*8+0x8]
data16 nop
mov r15, qword ptr [rsp+0x3b8]
vmovupd zmm26{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmulpd zmm26, zmm26, zmm29
vmovupd zmm29{k1}{z}, zmmword ptr [r10+r13*8+0x8]
vfmadd231pd zmm26, zmm28, zmm27
vmovupd zmm28{k1}{z}, zmmword ptr [rdi+r13*8+0x10]
vmovupd zmm27{k1}{z}, zmmword ptr [r11+r13*8+0x8]
vmulpd zmm28, zmm29, zmm28
vmovupd zmm29{k1}{z}, zmmword ptr [r8+r13*8+0x10]
vfmadd231pd zmm28, zmm30, zmm31
vmovupd zmm30{k1}{z}, zmmword ptr [rcx+r13*8+0x10]
vaddpd zmm26, zmm26, zmm28
mov r15, qword ptr [rsp+0x3e0]
vaddpd zmm13, zmm26, zmm24
vmovupd zmm31{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x3f0]
nop dword ptr [rax], eax
vmovupd zmm28{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x400]
vmulpd zmm17, zmm28, zmm17
vmovupd zmm16{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmovupd zmm28{k1}{z}, zmmword ptr [rsi+r13*8+0x10]
vfmadd231pd zmm17, zmm29, zmm27
vmovupd zmm29{k1}{z}, zmmword ptr [rbx+r13*8+0x10]
vmulpd zmm28, zmm16, zmm28
vmovupd zmm16{k1}{z}, zmmword ptr [r12+r13*8+0x8]
vfmadd231pd zmm28, zmm30, zmm31
vmovupd zmm30{k1}{z}, zmmword ptr [rax+r13*8+0x10]
vaddpd zmm17, zmm17, zmm28
vmovupd zmm28{k1}{z}, zmmword ptr [r9+r13*8+0x10]
nop dword ptr [rax], eax
mov r15, qword ptr [rsp+0x410]
vmovupd zmm27{k1}{z}, zmmword ptr [r15+r13*8+0x8]
mov r15, qword ptr [rsp+0x278]
vmovupd zmm31{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmulpd zmm28, zmm31, zmm28
mov r15, qword ptr [rsp+0x280]
vfmadd231pd zmm28, zmm29, zmm27
vmovupd zmm27{k1}{z}, zmmword ptr [r14+r13*8+0x10]
vmovupd zmm31{k1}{z}, zmmword ptr [r15+r13*8+0x8]
vmulpd zmm31, zmm31, zmm27
vfmadd231pd zmm31, zmm30, zmm16
vaddpd zmm16, zmm28, zmm31
vaddpd zmm12, zmm16, zmm17
vaddpd zmm7, zmm12, zmm13
vaddpd zmm9, zmm7, zmm8
mov r15, qword ptr [rsp+0x290]
vmovupd zmmword ptr [r15+r13*8+0x8]{k1}, zmm9
add r13, 0x8
cmp r13, qword ptr [rsp+0x270]
jb 0xfffffffffffffbf1
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4152/37;P ~ 110
L2: P <= 3544;P ~ 3540
L3: P <= 3670072/37;P ~ 99190
L1: 248*N*P - 448*P - 448 <= 32768;N*P ~ 10²
L2: 248*N*P - 448*P - 448 <= 1048576;N*P ~ 60²
L3: 248*N*P - 448*P - 448 <= 29360128;N*P ~ 340²
{%- endcapture -%}

{% include stencil_template.md %}
