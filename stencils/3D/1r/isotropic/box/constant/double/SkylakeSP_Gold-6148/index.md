---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "box"
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
vpcmpgtd k1, xmm28, xmm27
add r13, 0x4
vpaddd xmm27, xmm27, xmm1
vmovupd ymm30{k1}{z}, ymmword ptr [rax+r10*1+0x8]
vmovupd ymm4{k1}{z}, ymmword ptr [rax+r10*1]
vmovupd ymm21{k1}{z}, ymmword ptr [rax+r10*1+0x10]
vmovupd ymm31{k1}{z}, ymmword ptr [rax+r11*1]
vmovupd ymm10{k1}{z}, ymmword ptr [rax+r11*1+0x8]
vmovupd ymm18{k1}{z}, ymmword ptr [rax+r11*1+0x10]
vmovupd ymm29{k1}{z}, ymmword ptr [rax+r12*1]
vmovupd ymm9{k1}{z}, ymmword ptr [rax+r12*1+0x8]
vmovupd ymm17{k1}{z}, ymmword ptr [rax+r12*1+0x10]
vmovupd ymm3{k1}{z}, ymmword ptr [rax+r8*1]
vmovupd ymm14{k1}{z}, ymmword ptr [rax+r8*1+0x8]
vmovupd ymm22{k1}{z}, ymmword ptr [rax+r8*1+0x10]
vmovupd ymm7{k1}{z}, ymmword ptr [rax+rbx*1]
vmovupd ymm11{k1}{z}, ymmword ptr [rax+rbx*1+0x8]
vmovupd ymm19{k1}{z}, ymmword ptr [rax+rbx*1+0x10]
vmovupd ymm6{k1}{z}, ymmword ptr [rax+r9*1]
vmovupd ymm13{k1}{z}, ymmword ptr [rax+r9*1+0x8]
vmovupd ymm20{k1}{z}, ymmword ptr [rax+r9*1+0x10]
vmovupd ymm5{k1}{z}, ymmword ptr [rax+rcx*1]
vmovupd ymm12{k1}{z}, ymmword ptr [rax+rcx*1+0x8]
vmovupd ymm15{k1}{z}, ymmword ptr [rax+rdx*1]
vmovupd ymm26{k1}{z}, ymmword ptr [rax+rdx*1+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rax+r15*1]
vmovupd ymm16{k1}{z}, ymmword ptr [rax+r15*1+0x8]
vmovupd ymm25{k1}{z}, ymmword ptr [rax+rcx*1+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [rax+rdx*1+0x10]
vmovupd ymm24{k1}{z}, ymmword ptr [rax+r15*1+0x10]
vaddpd ymm30, ymm30, ymm31
vaddpd ymm3, ymm29, ymm3
vaddpd ymm4, ymm7, ymm4
vaddpd ymm5, ymm6, ymm5
vaddpd ymm8, ymm15, ymm8
vaddpd ymm9, ymm10, ymm9
vaddpd ymm11, ymm14, ymm11
vaddpd ymm12, ymm13, ymm12
vaddpd ymm16, ymm26, ymm16
vaddpd ymm17, ymm18, ymm17
vaddpd ymm19, ymm22, ymm19
vaddpd ymm20, ymm21, ymm20
vaddpd ymm29, ymm30, ymm3
vaddpd ymm6, ymm4, ymm5
vaddpd ymm10, ymm8, ymm9
vaddpd ymm13, ymm11, ymm12
vaddpd ymm18, ymm16, ymm17
vaddpd ymm21, ymm19, ymm20
vaddpd ymm23, ymm25, ymm23
vaddpd ymm7, ymm29, ymm6
vaddpd ymm14, ymm10, ymm13
vaddpd ymm22, ymm18, ymm21
vaddpd ymm24, ymm23, ymm24
vaddpd ymm15, ymm7, ymm14
vaddpd ymm25, ymm22, ymm24
vaddpd ymm26, ymm15, ymm25
vmulpd ymm31, ymm0, ymm26
vmovupd ymmword ptr [rax+r14*1+0x8]{k1}, ymm31
add rax, 0x20
cmp r13, rsi
jb 0xfffffffffffffe45
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

