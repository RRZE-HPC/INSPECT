---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
flavor       : ""
compile_flags: "icc -O3 -xCORE-AVX512 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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

for ( int k = 2; k < M-2; k++ ) {
  for ( int j = 2; j < N-2; j++ ) {
    for ( int i = 2; i < P-2; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
        + c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
        + c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
        + c11 * a[k][j-2][i] + c12 * a[k][j+2][i];
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vpcmpgtd k1, xmm9, xmm8
add r14, 0x4
vpaddd xmm8, xmm8, xmm12
vmovupd ymm7{k1}{z}, ymmword ptr [rax+r8*1+0x10]
vmovupd ymm3{k1}{z}, ymmword ptr [rax+r13*1+0x10]
vmovupd ymm0{k1}{z}, ymmword ptr [rax+r9*1]
vmovupd ymm1{k1}{z}, ymmword ptr [rax+r9*1+0x20]
vmovupd ymm26{k1}{z}, ymmword ptr [rax+r10*1+0x10]
vmulpd ymm7, ymm20, ymm7
vmovupd ymm28{k1}{z}, ymmword ptr [rax+rbx*1+0x10]
vmovupd ymm4{k1}{z}, ymmword ptr [rax+r9*1+0x18]
vmovupd ymm10{k1}{z}, ymmword ptr [rax+r12*1+0x10]
vmovupd ymm2{k1}{z}, ymmword ptr [rax+rdi*1+0x10]
vfmadd231pd ymm7, ymm3, ymm21
vmovupd ymm27{k1}{z}, ymmword ptr [rax+r11*1+0x10]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+rsi*1+0x10]
vmulpd ymm30, ymm13, ymm26
vmulpd ymm31, ymm11, ymm28
vmulpd ymm0, ymm17, ymm0
vmulpd ymm1, ymm16, ymm1
vmovupd ymm5{k1}{z}, ymmword ptr [rax+r9*1+0x8]
vfmadd231pd ymm7, ymm4, ymm22
vfmadd231pd ymm30, ymm27, ymm15
vfmadd231pd ymm31, ymm29, ymm14
vfmadd231pd ymm0, ymm10, ymm19
vfmadd231pd ymm1, ymm2, ymm18
vmovupd ymm6{k1}{z}, ymmword ptr [rax+r9*1+0x10]
vfmadd231pd ymm7, ymm5, ymm23
vaddpd ymm26, ymm30, ymm31
vaddpd ymm2, ymm0, ymm1
vfmadd231pd ymm7, ymm6, ymm24
vaddpd ymm3, ymm26, ymm2
vaddpd ymm4, ymm3, ymm7
vmovupd ymmword ptr [rax+r15*1+0x10]{k1}, ymm4
add rax, 0x20
cmp r14, rdx
jb 0xfffffffffffffef5
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;409
L2: P <= 16384/5;3276
L3: P <= 1441792/5;288385
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;26²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 1048576;147²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 29360128;781²
{%- endcapture -%}

{% include stencil_template.md %}

