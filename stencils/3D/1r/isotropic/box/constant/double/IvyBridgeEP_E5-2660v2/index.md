---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : ""
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vmovupd ymm2, ymmword ptr [r15+r13*8+0x8]
vaddpd ymm3, ymm2, ymmword ptr [r12+r13*8]
vaddpd ymm4, ymm3, ymmword ptr [r14+r13*8]
vaddpd ymm5, ymm4, ymmword ptr [rcx+r13*8]
vaddpd ymm6, ymm5, ymmword ptr [r8+r13*8]
vaddpd ymm7, ymm6, ymmword ptr [r15+r13*8]
vaddpd ymm8, ymm7, ymmword ptr [rdi+r13*8]
vaddpd ymm9, ymm8, ymmword ptr [r10+r13*8]
vaddpd ymm10, ymm9, ymmword ptr [r9+r13*8]
vaddpd ymm11, ymm10, ymmword ptr [rsi+r13*8]
vaddpd ymm12, ymm11, ymmword ptr [r12+r13*8+0x8]
vaddpd ymm13, ymm12, ymmword ptr [r14+r13*8+0x8]
vaddpd ymm14, ymm13, ymmword ptr [rcx+r13*8+0x8]
vaddpd ymm15, ymm14, ymmword ptr [r8+r13*8+0x8]
vaddpd ymm2, ymm15, ymmword ptr [rdi+r13*8+0x8]
vaddpd ymm3, ymm2, ymmword ptr [r10+r13*8+0x8]
vaddpd ymm4, ymm3, ymmword ptr [r9+r13*8+0x8]
vaddpd ymm5, ymm4, ymmword ptr [rsi+r13*8+0x8]
vaddpd ymm6, ymm5, ymmword ptr [r12+r13*8+0x10]
vaddpd ymm7, ymm6, ymmword ptr [r14+r13*8+0x10]
vaddpd ymm8, ymm7, ymmword ptr [rcx+r13*8+0x10]
vaddpd ymm9, ymm8, ymmword ptr [r8+r13*8+0x10]
vaddpd ymm10, ymm9, ymmword ptr [r15+r13*8+0x10]
vaddpd ymm11, ymm10, ymmword ptr [rdi+r13*8+0x10]
vaddpd ymm12, ymm11, ymmword ptr [r10+r13*8+0x10]
vaddpd ymm13, ymm12, ymmword ptr [r9+r13*8+0x10]
vaddpd ymm14, ymm13, ymmword ptr [rsi+r13*8+0x10]
vmulpd ymm15, ymm0, ymm14
vmovupd ymmword ptr [r11+r13*8+0x8], ymm15
add r13, 0x4
cmp r13, rdx
jb 0xffffffffffffff39
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;409
L2: P <= 3277
L3: P <= 1638401/5;327680
L1: 32*N*P - 16*P - 16 <= 32768;32²
L2: 32*N*P - 16*P - 16 <= 262144;90²
L3: 32*N*P - 16*P - 16 <= 18874368;768²
{%- endcapture -%}

{% include stencil_template.md %}

