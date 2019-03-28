---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r1"
weighting    : "homogeneous"
kind         : "box"
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

for( int k = 1; k < M - 1; k++ ) {
  for( int j = 1; j < N - 1; j++ ) {
    for( int i = 1; i < P - 1; i++ ) {
      b[k][j][i] = c0 *
        ( a[k-1][j-1][i-1] + a[k][j-1][i-1]   + a[k+1][j-1][i-1]
        + a[k-1][j][i-1]   + a[k][j][i-1]     + a[k+1][j][i-1]
        + a[k-1][j+1][i-1] + a[k][j+1][i-1]   + a[k+1][j+1][i-1]
        + a[k-1][j-1][i]   + a[k][j-1][i]     + a[k+1][j-1][i]
        + a[k-1][j][i]     + a[k][j][i]       + a[k+1][j][i]
        + a[k-1][j+1][i]   + a[k][j+1][i]     + a[k+1][j+1][i]
        + a[k-1][j-1][i+1] + a[k][j-1][i+1]   + a[k+1][j-1][i+1]
        + a[k-1][j][i+1]   + a[k][j][i+1]     + a[k+1][j][i+1]
        + a[k-1][j+1][i+1] + a[k][j+1][i+1]   + a[k+1][j+1][i+1] );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vpcmpgtd k1, ymm28, ymm27
add r13, 0x8
vpaddd ymm27, ymm27, ymm1
vmovupd zmm30{k1}{z}, zmmword ptr [rax+r10*1+0x8]
vmovupd zmm4{k1}{z}, zmmword ptr [rax+r10*1]
vmovupd zmm21{k1}{z}, zmmword ptr [rax+r10*1+0x10]
vmovupd zmm31{k1}{z}, zmmword ptr [rax+r11*1]
vmovupd zmm10{k1}{z}, zmmword ptr [rax+r11*1+0x8]
vmovupd zmm18{k1}{z}, zmmword ptr [rax+r11*1+0x10]
vmovupd zmm29{k1}{z}, zmmword ptr [rax+r12*1]
vmovupd zmm9{k1}{z}, zmmword ptr [rax+r12*1+0x8]
vmovupd zmm17{k1}{z}, zmmword ptr [rax+r12*1+0x10]
vmovupd zmm3{k1}{z}, zmmword ptr [rax+r8*1]
vmovupd zmm14{k1}{z}, zmmword ptr [rax+r8*1+0x8]
vmovupd zmm22{k1}{z}, zmmword ptr [rax+r8*1+0x10]
vmovupd zmm7{k1}{z}, zmmword ptr [rax+rbx*1]
vmovupd zmm11{k1}{z}, zmmword ptr [rax+rbx*1+0x8]
vmovupd zmm19{k1}{z}, zmmword ptr [rax+rbx*1+0x10]
vmovupd zmm6{k1}{z}, zmmword ptr [rax+r9*1]
vmovupd zmm13{k1}{z}, zmmword ptr [rax+r9*1+0x8]
vmovupd zmm20{k1}{z}, zmmword ptr [rax+r9*1+0x10]
vmovupd zmm5{k1}{z}, zmmword ptr [rax+rcx*1]
vmovupd zmm12{k1}{z}, zmmword ptr [rax+rcx*1+0x8]
vmovupd zmm15{k1}{z}, zmmword ptr [rax+rdx*1]
vmovupd zmm26{k1}{z}, zmmword ptr [rax+rdx*1+0x8]
vmovupd zmm8{k1}{z}, zmmword ptr [rax+r15*1]
vmovupd zmm16{k1}{z}, zmmword ptr [rax+r15*1+0x8]
vmovupd zmm25{k1}{z}, zmmword ptr [rax+rcx*1+0x10]
vmovupd zmm23{k1}{z}, zmmword ptr [rax+rdx*1+0x10]
vmovupd zmm24{k1}{z}, zmmword ptr [rax+r15*1+0x10]
vaddpd zmm30, zmm30, zmm31
vaddpd zmm3, zmm29, zmm3
vaddpd zmm4, zmm7, zmm4
vaddpd zmm5, zmm6, zmm5
vaddpd zmm8, zmm15, zmm8
vaddpd zmm9, zmm10, zmm9
vaddpd zmm11, zmm14, zmm11
vaddpd zmm12, zmm13, zmm12
vaddpd zmm16, zmm26, zmm16
vaddpd zmm17, zmm18, zmm17
vaddpd zmm19, zmm22, zmm19
vaddpd zmm20, zmm21, zmm20
vaddpd zmm29, zmm30, zmm3
vaddpd zmm6, zmm4, zmm5
vaddpd zmm10, zmm8, zmm9
vaddpd zmm13, zmm11, zmm12
vaddpd zmm18, zmm16, zmm17
vaddpd zmm21, zmm19, zmm20
vaddpd zmm23, zmm25, zmm23
vaddpd zmm7, zmm29, zmm6
vaddpd zmm14, zmm10, zmm13
vaddpd zmm22, zmm18, zmm21
vaddpd zmm24, zmm23, zmm24
vaddpd zmm15, zmm7, zmm14
vaddpd zmm25, zmm22, zmm24
vaddpd zmm26, zmm15, zmm25
vmulpd zmm31, zmm0, zmm26
vmovupd zmmword ptr [rax+r14*1+0x8]{k1}, zmm31
add rax, 0x40
cmp r13, rsi
jb 0xfffffffffffffe37
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;409
L2: P <= 65537/5;13107
L3: P <= 1835009/5;367001
L1: 32*N*P - 16*P - 16 <= 32768;32²
L2: 32*N*P - 16*P - 16 <= 1048576;181²
L3: 32*N*P - 16*P - 16 <= 29360128;957²
{%- endcapture -%}

{% include stencil_template.md %}

