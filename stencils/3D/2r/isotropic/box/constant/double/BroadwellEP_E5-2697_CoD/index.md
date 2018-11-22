---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : ""
comment      : "This is a comment"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for ( int k = 2; k < M - 2; k++ ) {
  for ( int j = 2; j < N - 2; j++ ) {
    for (int i = 2; i < P - 2; i++ ) {
      b[k][j][i] = c0 *
        ( a[k][j][i]       + a[k-2][j-2][i-2] + a[k-1][j-2][i-2]
        + a[k][j-2][i-2]   + a[k+1][j-2][i-2] + a[k+2][j-2][i-2]
        + a[k-2][j-1][i-2] + a[k-1][j-1][i-2] + a[k][j-1][i-2]
        + a[k+1][j-1][i-2] + a[k+2][j-1][i-2] + a[k-2][j][i-2]
        + a[k-1][j][i-2]   + a[k][j][i-2]     + a[k+1][j][i-2]
        + a[k+2][j][i-2]   + a[k-2][j+1][i-2] + a[k-1][j+1][i-2]
        + a[k][j+1][i-2]   + a[k+1][j+1][i-2] + a[k+2][j+1][i-2]
        + a[k-2][j+2][i-2] + a[k-1][j+2][i-2] + a[k][j+2][i-2]
        + a[k+1][j+2][i-2] + a[k+2][j+2][i-2] + a[k-2][j-2][i-1]
        + a[k-1][j-2][i-1] + a[k][j-2][i-1]   + a[k+1][j-2][i-1]
        + a[k+2][j-2][i-1] + a[k-2][j-1][i-1] + a[k-1][j-1][i-1]
        + a[k][j-1][i-1]   + a[k+1][j-1][i-1] + a[k+2][j-1][i-1]
        + a[k-2][j][i-1]   + a[k-1][j][i-1]   + a[k][j][i-1]
        + a[k+1][j][i-1]   + a[k+2][j][i-1]   + a[k-2][j+1][i-1]
        + a[k-1][j+1][i-1] + a[k][j+1][i-1]   + a[k+1][j+1][i-1]
        + a[k+2][j+1][i-1] + a[k-2][j+2][i-1] + a[k-1][j+2][i-1]
        + a[k][j+2][i-1]   + a[k+1][j+2][i-1] + a[k+2][j+2][i-1]
        + a[k-2][j-2][i]   + a[k-1][j-2][i]   + a[k][j-2][i]
        + a[k+1][j-2][i]   + a[k+2][j-2][i]   + a[k-2][j-1][i]
        + a[k-1][j-1][i]   + a[k][j-1][i]     + a[k+1][j-1][i]
        + a[k+2][j-1][i]   + a[k-2][j][i]     + a[k-1][j][i]
        + a[k+1][j][i]     + a[k+2][j][i]     + a[k-2][j+1][i]
        + a[k-1][j+1][i]   + a[k][j+1][i]     + a[k+1][j+1][i]
        + a[k+2][j+1][i]   + a[k-2][j+2][i]   + a[k-1][j+2][i]
        + a[k][j+2][i]     + a[k+1][j+2][i]   + a[k+2][j+2][i]
        + a[k-2][j-2][i+1] + a[k-1][j-2][i+1] + a[k][j-2][i+1]
        + a[k+1][j-2][i+1] + a[k+2][j-2][i+1] + a[k-2][j-1][i+1]
        + a[k-1][j-1][i+1] + a[k][j-1][i+1]   + a[k+1][j-1][i+1]
        + a[k+2][j-1][i+1] + a[k-2][j][i+1]   + a[k-1][j][i+1]
        + a[k][j][i+1]     + a[k+1][j][i+1]   + a[k+2][j][i+1]
        + a[k-2][j+1][i+1] + a[k-1][j+1][i+1] + a[k][j+1][i+1]
        + a[k+1][j+1][i+1] + a[k+2][j+1][i+1] + a[k-2][j+2][i+1]
        + a[k-1][j+2][i+1] + a[k][j+2][i+1]   + a[k+1][j+2][i+1]
        + a[k+2][j+2][i+1] + a[k-2][j-2][i+2] + a[k-1][j-2][i+2]
        + a[k][j-2][i+2]   + a[k+1][j-2][i+2] + a[k+2][j-2][i+2]
        + a[k-2][j-1][i+2] + a[k-1][j-1][i+2] + a[k][j-1][i+2]
        + a[k+1][j-1][i+2] + a[k+2][j-1][i+2] + a[k-2][j][i+2]
        + a[k-1][j][i+2]   + a[k][j][i+2]     + a[k+1][j][i+2]
        + a[k+2][j][i+2]   + a[k-2][j+1][i+2] + a[k-1][j+1][i+2]
        + a[k][j+1][i+2]   + a[k+1][j+1][i+2] + a[k+2][j+1][i+2]
        + a[k-2][j+2][i+2] + a[k-1][j+2][i+2] + a[k][j+2][i+2]
        + a[k+1][j+2][i+2] + a[k+2][j+2][i+2] );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
mov r10, qword ptr [rsp+0x2f0]
mov rdx, qword ptr [rsp+0x268]
mov rax, qword ptr [rsp+0x230]
mov r9, qword ptr [rsp+0x2e8]
mov r13, qword ptr [rsp+0x278]
mov r14, qword ptr [rsp+0x298]
vmovupd ymm14, ymmword ptr [r10+r12*8+0x10]
vmovupd ymm2, ymmword ptr [rdx+r12*8]
vmovupd ymm0, ymmword ptr [rax+r12*8]
vmovupd ymm4, ymmword ptr [r9+r12*8]
vmovupd ymm10, ymmword ptr [r13+r12*8+0x8]
vmovupd ymm13, ymmword ptr [r14+r12*8+0x8]
vmovupd ymm7, ymmword ptr [r10+r12*8+0x8]
vmovupd ymm9, ymmword ptr [rdx+r12*8+0x10]
vmovupd ymm3, ymmword ptr [rax+r12*8+0x10]
vmovupd ymm1, ymmword ptr [r9+r12*8+0x18]
vmovupd ymm8, ymmword ptr [r9+r12*8+0x10]
vmovupd ymm12, ymmword ptr [rdx+r12*8+0x18]
vmovupd ymm15, ymmword ptr [rax+r12*8+0x18]
vaddpd ymm6, ymm2, ymmword ptr [r13+r12*8]
vaddpd ymm0, ymm0, ymmword ptr [r14+r12*8]
vaddpd ymm10, ymm10, ymmword ptr [rax+r12*8+0x8]
vaddpd ymm13, ymm13, ymmword ptr [r9+r12*8+0x8]
vaddpd ymm12, ymm12, ymmword ptr [r13+r12*8+0x18]
vaddpd ymm15, ymm15, ymmword ptr [r14+r12*8+0x18]
mov r11, qword ptr [rsp+0x260]
mov r15, qword ptr [rsp+0x2e0]
mov rcx, qword ptr [rsp+0x2d0]
vaddpd ymm11, ymm14, ymmword ptr [r11+r12*8]
vaddpd ymm4, ymm4, ymmword ptr [r15+r12*8]
vaddpd ymm8, ymm8, ymmword ptr [r15+r12*8+0x10]
vaddpd ymm6, ymm11, ymm6
vaddpd ymm2, ymm0, ymm4
vaddpd ymm1, ymm1, ymmword ptr [r15+r12*8+0x18]
vmovupd ymm14, ymmword ptr [r15+r12*8+0x8]
vmovupd ymm5, ymmword ptr [r11+r12*8+0x8]
vaddpd ymm2, ymm6, ymm2
vaddpd ymm6, ymm10, ymm13
vaddpd ymm13, ymm7, ymmword ptr [rcx+r12*8+0x8]
vaddpd ymm7, ymm9, ymmword ptr [r13+r12*8+0x10]
vaddpd ymm9, ymm3, ymmword ptr [r14+r12*8+0x10]
vaddpd ymm5, ymm5, ymmword ptr [rdx+r12*8+0x8]
vaddpd ymm7, ymm7, ymm9
mov r9, qword ptr [rsp+0x2d8]
mov r8, qword ptr [rsp+0x250]
mov rdi, qword ptr [rsp+0x280]
vmovupd ymm3, ymmword ptr [r9+r12*8+0x8]
vmovupd ymm4, ymmword ptr [r8+r12*8+0x10]
vmovupd ymm11, ymmword ptr [r8+r12*8]
vmovupd ymm0, ymmword ptr [r8+r12*8+0x18]
vaddpd ymm14, ymm14, ymmword ptr [r8+r12*8+0x8]
vaddpd ymm9, ymm3, ymmword ptr [rdi+r12*8+0x8]
vaddpd ymm10, ymm11, ymmword ptr [r9+r12*8]
vmovupd ymm3, ymmword ptr [rdi+r12*8+0x18]
vaddpd ymm9, ymm14, ymm9
vaddpd ymm14, ymm4, ymmword ptr [r9+r12*8+0x10]
vaddpd ymm11, ymm8, ymm14
vmovupd ymm8, ymmword ptr [rdi+r12*8+0x10]
mov r8, qword ptr [rsp+0x270]
mov rsi, qword ptr [rsp+0x248]
mov rbx, qword ptr [rsp+0x240]
vaddpd ymm14, ymm8, ymmword ptr [r8+r12*8+0x10]
vaddpd ymm8, ymm12, ymm15
vaddpd ymm3, ymm3, ymmword ptr [r8+r12*8+0x18]
vmovupd ymm15, ymmword ptr [rdi+r12*8]
vaddpd ymm12, ymm15, ymmword ptr [r8+r12*8]
vaddpd ymm15, ymm10, ymm12
vmovupd ymm10, ymmword ptr [r8+r12*8+0x8]
vmovupd ymm12, ymmword ptr [rsi+r12*8+0x18]
vaddpd ymm4, ymm10, ymmword ptr [rsi+r12*8+0x8]
vmovupd ymm10, ymmword ptr [rsi+r12*8]
vaddpd ymm13, ymm4, ymm13
vaddpd ymm4, ymm9, ymm13
vmovupd ymm9, ymmword ptr [rsi+r12*8+0x10]
vaddpd ymm13, ymm9, ymmword ptr [rcx+r12*8+0x10]
vaddpd ymm14, ymm14, ymm13
vmovupd ymm13, ymmword ptr [rcx+r12*8+0x18]
vaddpd ymm9, ymm11, ymm14
vaddpd ymm14, ymm0, ymmword ptr [r9+r12*8+0x18]
vaddpd ymm11, ymm10, ymmword ptr [r10+r12*8]
vaddpd ymm0, ymm1, ymm14
vmovupd ymm1, ymmword ptr [rcx+r12*8]
mov rdi, qword ptr [rsp+0x290]
mov rsi, qword ptr [rsp+0x258]
mov rdx, qword ptr [rsp+0x2b8]
vaddpd ymm10, ymm1, ymmword ptr [rdi+r12*8]
vaddpd ymm13, ymm13, ymmword ptr [rdi+r12*8+0x18]
vmovupd ymm14, ymmword ptr [rdi+r12*8+0x10]
vmovupd ymm1, ymmword ptr [rbx+r12*8+0x18]
vaddpd ymm11, ymm11, ymm10
vaddpd ymm14, ymm14, ymmword ptr [rbx+r12*8+0x10]
vaddpd ymm15, ymm15, ymm11
vmovupd ymm11, ymmword ptr [rdi+r12*8+0x8]
vaddpd ymm15, ymm2, ymm15
vaddpd ymm2, ymm11, ymmword ptr [rbx+r12*8+0x8]
vaddpd ymm11, ymm12, ymmword ptr [r10+r12*8+0x18]
vmovupd ymm12, ymmword ptr [rbx+r12*8]
vaddpd ymm3, ymm3, ymm11
vaddpd ymm12, ymm12, ymmword ptr [rsi+r12*8]
vaddpd ymm11, ymm0, ymm3
vmovupd ymm0, ymmword ptr [rsi+r12*8+0x10]
vaddpd ymm3, ymm0, ymmword ptr [rdx+r12*8+0x10]
vaddpd ymm0, ymm14, ymm3
vmovupd ymm14, ymmword ptr [rsi+r12*8+0x8]
vaddpd ymm10, ymm14, ymmword ptr [rdx+r12*8+0x8]
vaddpd ymm14, ymm1, ymmword ptr [rsi+r12*8+0x18]
vmovupd ymm1, ymmword ptr [rdx+r12*8]
vaddpd ymm10, ymm2, ymm10
vaddpd ymm13, ymm13, ymm14
vmovupd ymm2, ymmword ptr [rdx+r12*8+0x18]
mov rcx, qword ptr [rsp+0x2b0]
mov rax, qword ptr [rsp+0x2a8]
mov rbx, qword ptr [rsp+0x288]
vaddpd ymm14, ymm1, ymmword ptr [rcx+r12*8]
vaddpd ymm1, ymm2, ymmword ptr [rcx+r12*8+0x18]
vmovupd ymm2, ymmword ptr [rcx+r12*8+0x8]
vmovupd ymm3, ymmword ptr [rcx+r12*8+0x10]
vaddpd ymm12, ymm12, ymm14
vaddpd ymm14, ymm2, ymmword ptr [rax+r12*8+0x8]
vaddpd ymm3, ymm3, ymmword ptr [rax+r12*8+0x10]
vmovupd ymm2, ymmword ptr [rax+r12*8+0x18]
vaddpd ymm2, ymm2, ymmword ptr [rbx+r12*8+0x18]
vaddpd ymm1, ymm1, ymm2
vaddpd ymm13, ymm13, ymm1
vaddpd ymm2, ymm11, ymm13
vmovupd ymm11, ymmword ptr [rax+r12*8]
vaddpd ymm1, ymm11, ymmword ptr [rbx+r12*8]
vmovupd ymm11, ymmword ptr [rbx+r12*8+0x10]
mov rdx, qword ptr [rsp+0x2c8]
mov rax, qword ptr [rsp+0x2c0]
vaddpd ymm13, ymm11, ymmword ptr [rdx+r12*8+0x10]
vaddpd ymm3, ymm3, ymm13
vaddpd ymm3, ymm0, ymm3
vmovupd ymm0, ymmword ptr [rbx+r12*8+0x8]
vaddpd ymm11, ymm0, ymmword ptr [rdx+r12*8+0x8]
vmovupd ymm0, ymmword ptr [rax+r12*8+0x8]
vaddpd ymm14, ymm14, ymm11
vmovupd ymm11, ymmword ptr [rdx+r12*8+0x18]
vaddpd ymm13, ymm10, ymm14
vmovupd ymm10, ymmword ptr [rdx+r12*8]
vaddpd ymm14, ymm4, ymm13
vmovupd ymm13, ymmword ptr [rax+r12*8+0x10]
vaddpd ymm4, ymm10, ymmword ptr [rax+r12*8]
mov rdx, qword ptr [rsp+0x238]
vaddpd ymm1, ymm1, ymm4
vmovupd ymm10, ymmword ptr [rdx+r12*8+0x18]
vaddpd ymm4, ymm12, ymm1
vaddpd ymm12, ymm11, ymmword ptr [rax+r12*8+0x18]
vaddpd ymm1, ymm0, ymmword ptr [rdx+r12*8+0x8]
vaddpd ymm13, ymm13, ymmword ptr [rdx+r12*8+0x10]
mov rax, qword ptr [rsp+0x2a0]
vaddpd ymm11, ymm10, ymmword ptr [rax+r12*8+0x18]
vmovupd ymm10, ymmword ptr [rdx+r12*8]
vaddpd ymm12, ymm12, ymm11
vmovupd ymm11, ymmword ptr [rax+r12*8+0x10]
vaddpd ymm0, ymm10, ymmword ptr [rax+r12*8]
vmovupd ymm10, ymmword ptr [r11+r12*8+0x20]
vaddpd ymm5, ymm0, ymm5
vaddpd ymm6, ymm5, ymm6
vmovupd ymm5, ymmword ptr [rax+r12*8+0x8]
vaddpd ymm6, ymm4, ymm6
vaddpd ymm4, ymm11, ymmword ptr [r11+r12*8+0x18]
vaddpd ymm5, ymm5, ymmword ptr [r11+r12*8+0x10]
vaddpd ymm6, ymm15, ymm6
vaddpd ymm11, ymm13, ymm4
vaddpd ymm0, ymm1, ymm5
vmovupd ymm5, ymmword ptr [r15+r12*8+0x20]
vmovupd ymm15, ymmword ptr [r13+r12*8+0x20]
vmovupd ymm1, ymmword ptr [r14+r12*8+0x20]
vmovupd ymm13, ymmword ptr [rdi+r12*8+0x20]
vaddpd ymm7, ymm0, ymm7
vaddpd ymm8, ymm11, ymm8
vmovupd ymm11, ymmword ptr [rsi+r12*8+0x20]
vaddpd ymm9, ymm7, ymm9
vaddpd ymm8, ymm3, ymm8
vmovupd ymm7, ymmword ptr [r9+r12*8+0x20]
vmovupd ymm3, ymmword ptr [rcx+r12*8+0x20]
vaddpd ymm14, ymm14, ymm9
vaddpd ymm2, ymm8, ymm2
vmovupd ymm9, ymmword ptr [r8+r12*8+0x20]
vmovupd ymm8, ymmword ptr [rbx+r12*8+0x20]
vaddpd ymm14, ymm6, ymm14
vmovupd ymm6, ymmword ptr [r10+r12*8+0x20]
mov r10, qword ptr [rsp+0x268]
mov r15, qword ptr [rsp+0x250]
mov r11, qword ptr [rsp+0x230]
mov r14, qword ptr [rsp+0x2e8]
mov rcx, qword ptr [rsp+0x280]
mov rbx, qword ptr [rsp+0x248]
vaddpd ymm0, ymm10, ymmword ptr [r10+r12*8+0x20]
vaddpd ymm10, ymm5, ymmword ptr [r15+r12*8+0x20]
vaddpd ymm15, ymm15, ymmword ptr [r11+r12*8+0x20]
vaddpd ymm1, ymm1, ymmword ptr [r14+r12*8+0x20]
vaddpd ymm7, ymm7, ymmword ptr [rcx+r12*8+0x20]
vaddpd ymm5, ymm9, ymmword ptr [rbx+r12*8+0x20]
vaddpd ymm4, ymm0, ymm15
vaddpd ymm0, ymm1, ymm10
vaddpd ymm9, ymm7, ymm5
vaddpd ymm12, ymm12, ymm4
vaddpd ymm1, ymm0, ymm9
mov r13, qword ptr [rsp+0x2c0]
mov rdi, qword ptr [rsp+0x240]
mov rsi, qword ptr [rsp+0x2d0]
vmovupd ymm15, ymmword ptr [r13+r12*8+0x20]
vaddpd ymm9, ymm12, ymm1
vaddpd ymm12, ymm13, ymmword ptr [rdi+r12*8+0x20]
vaddpd ymm6, ymm6, ymmword ptr [rsi+r12*8+0x20]
vaddpd ymm15, ymm15, ymmword ptr [rdx+r12*8+0x20]
vaddpd ymm0, ymm6, ymm12
mov r8, qword ptr [rsp+0x2b8]
mov r9, qword ptr [rsp+0x2a8]
mov r10, qword ptr [rsp+0x2c8]
vaddpd ymm13, ymm11, ymmword ptr [r8+r12*8+0x20]
vaddpd ymm3, ymm3, ymmword ptr [r9+r12*8+0x20]
vaddpd ymm8, ymm8, ymmword ptr [r10+r12*8+0x20]
vaddpd ymm1, ymm13, ymm3
vaddpd ymm3, ymm8, ymm15
vaddpd ymm4, ymm0, ymm1
vaddpd ymm5, ymm3, ymmword ptr [rax+r12*8+0x20]
vaddpd ymm6, ymm4, ymm5
vaddpd ymm7, ymm9, ymm6
vaddpd ymm2, ymm2, ymm7
vaddpd ymm0, ymm14, ymm2
vmulpd ymm1, ymm0, ymmword ptr [rsp+0x200]
mov rax, qword ptr [rsp+0x228]
vmovupd ymmword ptr [rax+r12*8+0x10], ymm1
add r12, 0x4
cmp r12, qword ptr [rsp+0x1f8]
jb 0xfffffffffffffa4b
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/13;157
L2: P <= 65538/13;5041
L3: P <= 1835010/13;141154
L1: 48*N*P - 32*P - 32 <= 32768;26²
L2: 48*N*P - 32*P - 32 <= 1048576;147²
L3: 48*N*P - 32*P - 32 <= 29360128;782²
{%- endcapture -%}

{% include stencil_template.md %}

