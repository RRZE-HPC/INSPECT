---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r3"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
flavor       : "AVX512"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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

for( int k = 3; k < M-3; k++ ) {
  for( int j = 3; j < N-3; j++ ) {
    for( int i = 3; i < P-3; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
        + c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
        + c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
        + c11 * a[k][j-2][i] + c12 * a[k][j+2][i]
        + c13 * a[k][j][i-3] + c14 * a[k][j][i+3]
        + c15 * a[k-3][j][i] + c16 * a[k+3][j][i]
        + c17 * a[k][j-3][i] + c18 * a[k][j+3][i];
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vpcmpgtd k1, ymm29, ymm9
add r13, 0x8
vpaddd ymm9, ymm9, ymm27
vmovupd zmm2{k1}{z}, zmmword ptr [rdi+r14*1+0x18]
vmovupd zmm3{k1}{z}, zmmword ptr [rdi+r12*1+0x18]
vmovupd zmm0{k1}{z}, zmmword ptr [rdi+rax*1+0x8]
vmovupd zmm6{k1}{z}, zmmword ptr [rdi+r9*1+0x18]
vmovupd zmm30{k1}{z}, zmmword ptr [rdi+rax*1+0x28]
vmovupd zmm7{k1}{z}, zmmword ptr [rdi+rax*1+0x20]
vmovupd zmm4{k1}{z}, zmmword ptr [rdi+rax*1+0x10]
vmovupd zmm5{k1}{z}, zmmword ptr [rdi+rax*1+0x18]
vmulpd zmm2, zmm20, zmm2
vmulpd zmm7, zmm23, zmm7
vfmadd231pd zmm2, zmm3, zmm22
vmovupd zmm3{k1}{z}, zmmword ptr [rdi+rsi*1+0x18]
vfmadd231pd zmm7, zmm4, zmm24
vmulpd zmm3, zmm16, zmm3
vfmadd231pd zmm7, zmm5, zmm25
vfmadd231pd zmm3, zmm0, zmm18
vmovupd zmm0{k1}{z}, zmmword ptr [rdi+r10*1+0x18]
mov r15, qword ptr [rsp+0x300]
vmulpd zmm0, zmm15, zmm0
vmovupd zmm31{k1}{z}, zmmword ptr [rdi+r15*1+0x18]
vfmadd231pd zmm0, zmm30, zmm17
vmulpd zmm31, zmm19, zmm31
vaddpd zmm0, zmm3, zmm0
vfmadd231pd zmm31, zmm6, zmm21
vmovupd zmm6{k1}{z}, zmmword ptr [rdi+rax*1]
vaddpd zmm31, zmm2, zmm31
vmovupd zmm2{k1}{z}, zmmword ptr [rdi+rax*1+0x30]
vmulpd zmm6, zmm12, zmm6
vmulpd zmm2, zmm11, zmm2
vaddpd zmm0, zmm0, zmm31
vmovupd zmm31{k1}{z}, zmmword ptr [rdi+rbx*1+0x18]
mov r15, qword ptr [rsp+0x2f8]
vmovupd zmm30{k1}{z}, zmmword ptr [rdi+r15*1+0x18]
mov r15, qword ptr [rsp+0x310]
vfmadd231pd zmm6, zmm30, zmm14
vmovupd zmm30{k1}{z}, zmmword ptr [rdi+r11*1+0x18]
vmovupd zmm3{k1}{z}, zmmword ptr [rdi+r15*1+0x18]
vfmadd231pd zmm2, zmm3, zmm13
vmovupd zmm3{k1}{z}, zmmword ptr [rdi+rdx*1+0x18]
vaddpd zmm2, zmm6, zmm2
vmovupd zmm6{k1}{z}, zmmword ptr [rdi+rcx*1+0x18]
vmulpd zmm3, zmm28, zmm3
vmulpd zmm6, zmm1, zmm6
vfmadd231pd zmm3, zmm31, zmm10
vfmadd231pd zmm6, zmm30, zmm8
vaddpd zmm3, zmm3, zmm6
vaddpd zmm4, zmm3, zmm2
vaddpd zmm5, zmm4, zmm0
vaddpd zmm0, zmm5, zmm7
vmovupd zmmword ptr [rdi+r8*1+0x18]{k1}, zmm0
add rdi, 0x40
cmp r13, qword ptr [rsp+0x328]
jb 0xfffffffffffffe52
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;292
L2: P <= 65536/7;9362
L3: P <= 262144
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;32²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 1048576;128²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 29360128;677²
{%- endcapture -%}

{% include stencil_template.md %}

