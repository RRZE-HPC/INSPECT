---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r3"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
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
vmulpd ymm15, ymm12, ymmword ptr [rax+rcx*8+0x18]
vmulpd ymm14, ymm11, ymmword ptr [rax+rcx*8+0x10]
vaddpd ymm15, ymm15, ymm14
vmulpd ymm14, ymm10, ymmword ptr [rax+rcx*8+0x20]
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r8+rcx*8+0x18]
mov r15, qword ptr [rsp+0x510]
vinsertf128 ymm15, ymm15, xmmword ptr [r8+rcx*8+0x28], 0x1
vmulpd ymm15, ymm9, ymm15
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r10+rcx*8+0x18]
vinsertf128 ymm14, ymm14, xmmword ptr [r10+rcx*8+0x28], 0x1
vmulpd ymm14, ymm8, ymm14
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r9+rcx*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r9+rcx*8+0x28], 0x1
vmulpd ymm15, ymm7, ymm15
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [rsi+rcx*8+0x18]
vinsertf128 ymm14, ymm14, xmmword ptr [rsi+rcx*8+0x28], 0x1
vmulpd ymm14, ymm6, ymm14
vaddpd ymm15, ymm15, ymm14
vmulpd ymm14, ymm5, ymmword ptr [rax+rcx*8+0x8]
vaddpd ymm15, ymm15, ymm14
vmulpd ymm14, ymm4, ymmword ptr [rax+rcx*8+0x28]
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r12+rcx*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r12+rcx*8+0x28], 0x1
vmulpd ymm15, ymm3, ymm15
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r14+rcx*8+0x18]
vinsertf128 ymm14, ymm14, xmmword ptr [r14+rcx*8+0x28], 0x1
vmulpd ymm14, ymm2, ymm14
vaddpd ymm15, ymm15, ymm14
vmulpd ymm14, ymm1, ymmword ptr [r15+rcx*8+0x18]
mov r15, qword ptr [rsp+0x508]
vaddpd ymm15, ymm15, ymm14
vmulpd ymm14, ymm0, ymmword ptr [r15+rcx*8+0x18]
vaddpd ymm15, ymm15, ymm14
vmulpd ymm14, ymm13, ymmword ptr [rax+rcx*8]
vaddpd ymm14, ymm15, ymm14
vmovups ymm15, ymmword ptr [rsp+0x4a0]
vmulpd ymm15, ymm15, ymmword ptr [rax+rcx*8+0x30]
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [rdi+rcx*8+0x18]
vinsertf128 ymm14, ymm14, xmmword ptr [rdi+rcx*8+0x28], 0x1
vmulpd ymm14, ymm14, ymmword ptr [rsp+0x480]
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r13+rcx*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r13+rcx*8+0x28], 0x1
vmulpd ymm15, ymm15, ymmword ptr [rsp+0x460]
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [rdx+rcx*8+0x18]
vinsertf128 ymm14, ymm14, xmmword ptr [rdx+rcx*8+0x28], 0x1
vmulpd ymm14, ymm14, ymmword ptr [rsp+0x440]
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [rbx+rcx*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+rcx*8+0x28], 0x1
vmulpd ymm15, ymm15, ymmword ptr [rsp+0x4c0]
vaddpd ymm14, ymm14, ymm15
vextractf128 xmmword ptr [r11+rcx*8+0x28], ymm14, 0x1
vmovupd xmmword ptr [r11+rcx*8+0x18], xmm14
add rcx, 0x4
cmp rcx, qword ptr [rsp+0x4e8]
jb 0xfffffffffffffe67
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

