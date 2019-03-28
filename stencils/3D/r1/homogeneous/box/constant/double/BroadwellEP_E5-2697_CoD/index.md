---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r1"
weighting    : "homogeneous"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vmovupd ymm2, ymmword ptr [r9+r15*8+0x8]
vmovupd ymm3, ymmword ptr [r13+r15*8]
vmovupd ymm6, ymmword ptr [r12+r15*8]
vmovupd ymm5, ymmword ptr [r11+r15*8]
vmovupd ymm9, ymmword ptr [r11+r15*8+0x8]
vmovupd ymm7, ymmword ptr [r10+r15*8+0x8]
vmovupd ymm8, ymmword ptr [rsi+r15*8+0x8]
vmovupd ymm10, ymmword ptr [rdi+r15*8]
vmovupd ymm15, ymmword ptr [rdi+r15*8+0x8]
vmovupd ymm11, ymmword ptr [r9+r15*8+0x10]
vmovupd ymm12, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm13, ymmword ptr [rsi+r15*8+0x10]
vmovupd ymm14, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm4, ymm2, ymmword ptr [r10+r15*8]
vaddpd ymm2, ymm3, ymmword ptr [rsi+r15*8]
vaddpd ymm6, ymm6, ymmword ptr [r9+r15*8]
vaddpd ymm5, ymm5, ymmword ptr [r14+r15*8]
vaddpd ymm9, ymm9, ymmword ptr [r14+r15*8+0x8]
vaddpd ymm4, ymm4, ymm2
vaddpd ymm2, ymm6, ymm5
vaddpd ymm10, ymm10, ymmword ptr [r8+r15*8]
vaddpd ymm7, ymm7, ymmword ptr [r13+r15*8+0x8]
vaddpd ymm8, ymm8, ymmword ptr [r12+r15*8+0x8]
vaddpd ymm3, ymm4, ymm2
vaddpd ymm2, ymm10, ymm7
vaddpd ymm4, ymm8, ymm9
vaddpd ymm13, ymm13, ymmword ptr [r12+r15*8+0x10]
vaddpd ymm15, ymm15, ymmword ptr [r8+r15*8+0x8]
vaddpd ymm5, ymm2, ymm4
vaddpd ymm12, ymm12, ymmword ptr [r13+r15*8+0x10]
vaddpd ymm11, ymm11, ymmword ptr [r11+r15*8+0x10]
vaddpd ymm2, ymm3, ymm5
vaddpd ymm3, ymm15, ymm12
vaddpd ymm4, ymm13, ymm11
vaddpd ymm14, ymm14, ymmword ptr [rdi+r15*8+0x10]
vaddpd ymm5, ymm3, ymm4
vaddpd ymm3, ymm14, ymmword ptr [r8+r15*8+0x10]
vaddpd ymm4, ymm5, ymm3
vaddpd ymm2, ymm2, ymm4
vmulpd ymm6, ymm0, ymm2
vmovupd ymmword ptr [rdx+r15*8+0x8], ymm6
add r15, 0x4
cmp r15, rcx
jb 0xffffffffffffff06
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;409
L2: P <= 3277
L3: P <= 1441793/5;288358
L1: 32*N*P - 16*P - 16 <= 32768;32²
L2: 32*N*P - 16*P - 16 <= 262144;90²
L3: 32*N*P - 16*P - 16 <= 23068672;849²
{%- endcapture -%}

{% include stencil_template.md %}

