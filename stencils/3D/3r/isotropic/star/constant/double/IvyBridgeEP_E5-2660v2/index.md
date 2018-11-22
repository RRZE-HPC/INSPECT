---

title:  "Stencil detail"

dimension    : "3D"
radius       : "3r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : ""
comment      : "On this machine the intel compiler generates sub-optimal code with half-wide SIMD instructions. Resulting in worse performance than predicted. To fix this issue the inner loop has to be annotated with `#pragma vector align`. There are separate measurements available with this option enabled."
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for( int k=3; k < M-3; k++ ) {
  for( int j=3; j < N-3; j++ ) {
    for( int i=3; i < P-3; i++ ) {
      b[k][j][i] = c0 * (a[k][j][i]
        + a[k][j][i-1] + a[k][j][i+1]
        + a[k-1][j][i] + a[k+1][j][i]
        + a[k][j-1][i] + a[k][j+1][i]
        + a[k][j][i-2] + a[k][j][i+2]
        + a[k-2][j][i] + a[k+2][j][i]
        + a[k][j-2][i] + a[k][j+2][i]
        + a[k][j][i-3] + a[k][j][i+3]
        + a[k-3][j][i] + a[k+3][j][i]
        + a[k][j-3][i] + a[k][j+3][i]
      );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmovupd ymm13, ymmword ptr [rax+rcx*8+0x10]
vmovupd xmm14, xmmword ptr [r8+rcx*8+0x18]
vmovupd xmm1, xmmword ptr [r10+rcx*8+0x18]
vaddpd ymm15, ymm13, ymmword ptr [rax+rcx*8+0x20]
vmulpd ymm2, ymm8, ymmword ptr [rax+rcx*8+0x18]
vmovupd ymm3, ymmword ptr [rax+rcx*8+0x8]
vmovupd ymm4, ymmword ptr [rax+rcx*8]
vaddpd ymm3, ymm3, ymmword ptr [rax+rcx*8+0x28]
mov r15, qword ptr [rsp+0x198]
vinsertf128 ymm0, ymm14, xmmword ptr [r8+rcx*8+0x28], 0x1
vaddpd ymm13, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r9+rcx*8+0x18]
vinsertf128 ymm14, ymm1, xmmword ptr [r10+rcx*8+0x28], 0x1
vaddpd ymm0, ymm13, ymm14
vmovupd xmm13, xmmword ptr [rsi+rcx*8+0x18]
vinsertf128 ymm1, ymm15, xmmword ptr [r9+rcx*8+0x28], 0x1
vaddpd ymm14, ymm0, ymm1
vinsertf128 ymm0, ymm13, xmmword ptr [rsi+rcx*8+0x28], 0x1
vaddpd ymm1, ymm14, ymm0
vmulpd ymm13, ymm7, ymm1
vaddpd ymm1, ymm2, ymm13
vmovupd xmm2, xmmword ptr [r12+rcx*8+0x18]
vinsertf128 ymm0, ymm2, xmmword ptr [r12+rcx*8+0x28], 0x1
vmovupd xmm2, xmmword ptr [r14+rcx*8+0x18]
vaddpd ymm3, ymm3, ymm0
vinsertf128 ymm13, ymm2, xmmword ptr [r14+rcx*8+0x28], 0x1
vaddpd ymm14, ymm3, ymm13
vmovupd xmm3, xmmword ptr [r13+rcx*8+0x18]
vaddpd ymm15, ymm14, ymmword ptr [r15+rcx*8+0x18]
mov r15, qword ptr [rsp+0x190]
vaddpd ymm0, ymm15, ymmword ptr [r15+rcx*8+0x18]
vmovupd xmm15, xmmword ptr [rdx+rcx*8+0x18]
vmulpd ymm2, ymm6, ymm0
vaddpd ymm0, ymm1, ymm2
vaddpd ymm1, ymm4, ymmword ptr [rax+rcx*8+0x30]
vmovupd xmm4, xmmword ptr [rdi+rcx*8+0x18]
vinsertf128 ymm14, ymm3, xmmword ptr [r13+rcx*8+0x28], 0x1
vmovupd xmm3, xmmword ptr [rbx+rcx*8+0x18]
vinsertf128 ymm2, ymm4, xmmword ptr [rdi+rcx*8+0x28], 0x1
vaddpd ymm13, ymm1, ymm2
vaddpd ymm1, ymm13, ymm14
vinsertf128 ymm2, ymm15, xmmword ptr [rdx+rcx*8+0x28], 0x1
vaddpd ymm4, ymm1, ymm2
vinsertf128 ymm13, ymm3, xmmword ptr [rbx+rcx*8+0x28], 0x1
vaddpd ymm14, ymm4, ymm13
vmulpd ymm1, ymm5, ymm14
vaddpd ymm0, ymm0, ymm1
vmovupd xmmword ptr [r11+rcx*8+0x18], xmm0
vextractf128 xmmword ptr [r11+rcx*8+0x28], ymm0, 0x1
add rcx, 0x4
cmp rcx, qword ptr [rsp+0x178]
jb 0xfffffffffffffec6
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;292
L2: P <= 16384/7;2340
L3: P <= 1638400/7;234057
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;32²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;91²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 26214400;452²

{%- endcapture -%}

{% include stencil_template.md %}

