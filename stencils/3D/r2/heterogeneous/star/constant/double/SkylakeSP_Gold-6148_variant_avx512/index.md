---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r2"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_avx512"
flavor       : "AVX 512"
compile_flags: "icc -O3 -xCORE-AVX512 -qopt-zmm-usage=high -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vpcmpgtd k1, ymm9, ymm8
add r14, 0x8
vpaddd ymm8, ymm8, ymm12
vmovupd zmm7{k1}{z}, zmmword ptr [rax+r8*1+0x10]
vmovupd zmm0{k1}{z}, zmmword ptr [rax+r9*1]
vmovupd zmm1{k1}{z}, zmmword ptr [rax+r9*1+0x20]
vmovupd zmm26{k1}{z}, zmmword ptr [rax+r10*1+0x10]
vmovupd zmm28{k1}{z}, zmmword ptr [rax+rbx*1+0x10]
vmovupd zmm3{k1}{z}, zmmword ptr [rax+r13*1+0x10]
vmovupd zmm4{k1}{z}, zmmword ptr [rax+r9*1+0x18]
vmovupd zmm10{k1}{z}, zmmword ptr [rax+r12*1+0x10]
vmovupd zmm2{k1}{z}, zmmword ptr [rax+rdi*1+0x10]
vmovupd zmm27{k1}{z}, zmmword ptr [rax+r11*1+0x10]
vmovupd zmm29{k1}{z}, zmmword ptr [rax+rsi*1+0x10]
vmovupd zmm5{k1}{z}, zmmword ptr [rax+r9*1+0x8]
vmovupd zmm6{k1}{z}, zmmword ptr [rax+r9*1+0x10]
vmulpd zmm7, zmm20, zmm7
vmulpd zmm30, zmm13, zmm26
vmulpd zmm31, zmm11, zmm28
vmulpd zmm0, zmm17, zmm0
vmulpd zmm1, zmm16, zmm1
vfmadd231pd zmm7, zmm3, zmm21
vfmadd231pd zmm30, zmm27, zmm15
vfmadd231pd zmm31, zmm29, zmm14
vfmadd231pd zmm0, zmm10, zmm19
vfmadd231pd zmm1, zmm2, zmm18
vfmadd231pd zmm7, zmm4, zmm22
vaddpd zmm26, zmm30, zmm31
vaddpd zmm2, zmm0, zmm1
vfmadd231pd zmm7, zmm5, zmm23
vaddpd zmm3, zmm26, zmm2
vfmadd231pd zmm7, zmm6, zmm24
vaddpd zmm4, zmm3, zmm7
vmovupd zmmword ptr [rax+r15*1+0x10]{k1}, zmm4
add rax, 0x40
cmp r14, rdx
jb 0xfffffffffffffeee
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

