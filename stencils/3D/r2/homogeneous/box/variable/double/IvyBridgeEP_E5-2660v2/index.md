---

title:  "Stencil 3D r2 box variable homogeneous double IvyBridgeEP_E5-2660v2"

dimension    : "3D"
radius       : "r2"
weighting    : "homogeneous"
kind         : "box"
coefficients : "variable"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -I/apps/likwid/4.3.4/include -L/apps/likwid/4.3.4/lib -I/headers/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "125"
scaling      : [ "1020" ]
blocking     : []
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[1][M][N][P];

for(long k=2; k < M-2; ++k){
for(long j=2; j < N-2; ++j){
for(long i=2; i < P-2; ++i){
b[k][j][i] = W[0][k][j][i] * (a[k][j][i]
+ a[k-2][j-2][i-2]
+ a[k-1][j-2][i-2]
+ a[k][j-2][i-2]
+ a[k+1][j-2][i-2]
+ a[k+2][j-2][i-2]
+ a[k-2][j-1][i-2]
+ a[k-1][j-1][i-2]
+ a[k][j-1][i-2]
+ a[k+1][j-1][i-2]
+ a[k+2][j-1][i-2]
+ a[k-2][j][i-2]
+ a[k-1][j][i-2]
+ a[k][j][i-2]
+ a[k+1][j][i-2]
+ a[k+2][j][i-2]
+ a[k-2][j+1][i-2]
+ a[k-1][j+1][i-2]
+ a[k][j+1][i-2]
+ a[k+1][j+1][i-2]
+ a[k+2][j+1][i-2]
+ a[k-2][j+2][i-2]
+ a[k-1][j+2][i-2]
+ a[k][j+2][i-2]
+ a[k+1][j+2][i-2]
+ a[k+2][j+2][i-2]
+ a[k-2][j-2][i-1]
+ a[k-1][j-2][i-1]
+ a[k][j-2][i-1]
+ a[k+1][j-2][i-1]
+ a[k+2][j-2][i-1]
+ a[k-2][j-1][i-1]
+ a[k-1][j-1][i-1]
+ a[k][j-1][i-1]
+ a[k+1][j-1][i-1]
+ a[k+2][j-1][i-1]
+ a[k-2][j][i-1]
+ a[k-1][j][i-1]
+ a[k][j][i-1]
+ a[k+1][j][i-1]
+ a[k+2][j][i-1]
+ a[k-2][j+1][i-1]
+ a[k-1][j+1][i-1]
+ a[k][j+1][i-1]
+ a[k+1][j+1][i-1]
+ a[k+2][j+1][i-1]
+ a[k-2][j+2][i-1]
+ a[k-1][j+2][i-1]
+ a[k][j+2][i-1]
+ a[k+1][j+2][i-1]
+ a[k+2][j+2][i-1]
+ a[k-2][j-2][i]
+ a[k-1][j-2][i]
+ a[k][j-2][i]
+ a[k+1][j-2][i]
+ a[k+2][j-2][i]
+ a[k-2][j-1][i]
+ a[k-1][j-1][i]
+ a[k][j-1][i]
+ a[k+1][j-1][i]
+ a[k+2][j-1][i]
+ a[k-2][j][i]
+ a[k-1][j][i]
+ a[k+1][j][i]
+ a[k+2][j][i]
+ a[k-2][j+1][i]
+ a[k-1][j+1][i]
+ a[k][j+1][i]
+ a[k+1][j+1][i]
+ a[k+2][j+1][i]
+ a[k-2][j+2][i]
+ a[k-1][j+2][i]
+ a[k][j+2][i]
+ a[k+1][j+2][i]
+ a[k+2][j+2][i]
+ a[k-2][j-2][i+1]
+ a[k-1][j-2][i+1]
+ a[k][j-2][i+1]
+ a[k+1][j-2][i+1]
+ a[k+2][j-2][i+1]
+ a[k-2][j-1][i+1]
+ a[k-1][j-1][i+1]
+ a[k][j-1][i+1]
+ a[k+1][j-1][i+1]
+ a[k+2][j-1][i+1]
+ a[k-2][j][i+1]
+ a[k-1][j][i+1]
+ a[k][j][i+1]
+ a[k+1][j][i+1]
+ a[k+2][j][i+1]
+ a[k-2][j+1][i+1]
+ a[k-1][j+1][i+1]
+ a[k][j+1][i+1]
+ a[k+1][j+1][i+1]
+ a[k+2][j+1][i+1]
+ a[k-2][j+2][i+1]
+ a[k-1][j+2][i+1]
+ a[k][j+2][i+1]
+ a[k+1][j+2][i+1]
+ a[k+2][j+2][i+1]
+ a[k-2][j-2][i+2]
+ a[k-1][j-2][i+2]
+ a[k][j-2][i+2]
+ a[k+1][j-2][i+2]
+ a[k+2][j-2][i+2]
+ a[k-2][j-1][i+2]
+ a[k-1][j-1][i+2]
+ a[k][j-1][i+2]
+ a[k+1][j-1][i+2]
+ a[k+2][j-1][i+2]
+ a[k-2][j][i+2]
+ a[k-1][j][i+2]
+ a[k][j][i+2]
+ a[k+1][j][i+2]
+ a[k+2][j][i+2]
+ a[k-2][j+1][i+2]
+ a[k-1][j+1][i+2]
+ a[k][j+1][i+2]
+ a[k+1][j+1][i+2]
+ a[k+2][j+1][i+2]
+ a[k-2][j+2][i+2]
+ a[k-1][j+2][i+2]
+ a[k][j+2][i+2]
+ a[k+1][j+2][i+2]
+ a[k+2][j+2][i+2]
);
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
mov rsi, qword ptr [rsp+0x480]
mov r14, qword ptr [rsp+0x4a0]
mov r13, qword ptr [rsp+0x4a8]
vmovupd xmm13, xmmword ptr [rsi+r15*8+0x10]
vmovupd xmm14, xmmword ptr [rsi+r15*8+0x30]
vmovupd xmm6, xmmword ptr [r13+r15*8]
vmovupd xmm7, xmmword ptr [r13+r15*8+0x20]
mov r12, qword ptr [rsp+0x498]
mov r11, qword ptr [rsp+0x490]
mov r10, qword ptr [rsp+0x440]
mov r9, qword ptr [rsp+0x4c0]
vmovupd xmm11, xmmword ptr [r11+r15*8]
vmovupd xmm12, xmmword ptr [r11+r15*8+0x20]
mov r8, qword ptr [rsp+0x4b8]
mov rcx, qword ptr [rsp+0x4c8]
mov rax, qword ptr [rsp+0x4b0]
mov rdx, qword ptr [rsp+0x4d0]
mov rbx, qword ptr [rsp+0x4d8]
mov rdi, qword ptr [rsp+0x4e0]
vinsertf128 ymm13, ymm13, xmmword ptr [rsi+r15*8+0x20], 0x1
vinsertf128 ymm14, ymm14, xmmword ptr [rsi+r15*8+0x40], 0x1
mov rsi, qword ptr [rsp+0x470]
vmovupd xmm2, xmmword ptr [rsi+r15*8+0x10]
vmovupd xmm3, xmmword ptr [rsi+r15*8+0x30]
vinsertf128 ymm4, ymm2, xmmword ptr [rsi+r15*8+0x20], 0x1
vmovupd ymm2, ymmword ptr [r14+r15*8+0x20]
vaddpd ymm8, ymm4, ymmword ptr [r14+r15*8]
vinsertf128 ymm4, ymm6, xmmword ptr [r13+r15*8+0x10], 0x1
vmovupd xmm6, xmmword ptr [r12+r15*8]
vaddpd ymm8, ymm8, ymm4
vinsertf128 ymm5, ymm3, xmmword ptr [rsi+r15*8+0x40], 0x1
vaddpd ymm5, ymm5, ymm2
vinsertf128 ymm3, ymm7, xmmword ptr [r13+r15*8+0x30], 0x1
vmovupd xmm7, xmmword ptr [r12+r15*8+0x20]
vaddpd ymm10, ymm5, ymm3
vinsertf128 ymm9, ymm6, xmmword ptr [r12+r15*8+0x10], 0x1
vinsertf128 ymm4, ymm7, xmmword ptr [r12+r15*8+0x30], 0x1
vaddpd ymm15, ymm8, ymm9
vaddpd ymm1, ymm10, ymm4
vmovupd xmm9, xmmword ptr [r9+r15*8]
vmovupd ymm6, ymmword ptr [r10+r15*8+0x20]
vmovupd xmm10, xmmword ptr [r9+r15*8+0x20]
vinsertf128 ymm0, ymm11, xmmword ptr [r11+r15*8+0x10], 0x1
vinsertf128 ymm5, ymm12, xmmword ptr [r11+r15*8+0x30], 0x1
vaddpd ymm7, ymm15, ymm0
vaddpd ymm8, ymm1, ymm5
vmovupd xmm0, xmmword ptr [r8+r15*8]
vaddpd ymm11, ymm7, ymmword ptr [r10+r15*8]
vaddpd ymm15, ymm8, ymm6
vmovupd xmm1, xmmword ptr [r8+r15*8+0x20]
vinsertf128 ymm12, ymm9, xmmword ptr [r9+r15*8+0x10], 0x1
vinsertf128 ymm7, ymm10, xmmword ptr [r9+r15*8+0x30], 0x1
vaddpd ymm10, ymm11, ymm12
vaddpd ymm9, ymm15, ymm7
vmovupd xmm12, xmmword ptr [rcx+r15*8+0x20]
vinsertf128 ymm11, ymm0, xmmword ptr [r8+r15*8+0x10], 0x1
vinsertf128 ymm8, ymm1, xmmword ptr [r8+r15*8+0x30], 0x1
vaddpd ymm11, ymm10, ymm11
vaddpd ymm10, ymm9, ymm8
vmovupd xmm9, xmmword ptr [rcx+r15*8]
vmovupd xmm0, xmmword ptr [rax+r15*8+0x20]
vinsertf128 ymm15, ymm9, xmmword ptr [rcx+r15*8+0x10], 0x1
vinsertf128 ymm9, ymm12, xmmword ptr [rcx+r15*8+0x30], 0x1
vaddpd ymm12, ymm11, ymm15
vaddpd ymm11, ymm10, ymm9
vmovupd xmm10, xmmword ptr [rax+r15*8]
vinsertf128 ymm15, ymm10, xmmword ptr [rax+r15*8+0x10], 0x1
vaddpd ymm1, ymm12, ymm15
vmovupd xmm12, xmmword ptr [rdx+r15*8+0x20]
vinsertf128 ymm10, ymm0, xmmword ptr [rax+r15*8+0x30], 0x1
vaddpd ymm0, ymm11, ymm10
vmovupd xmm11, xmmword ptr [rdx+r15*8]
vinsertf128 ymm15, ymm11, xmmword ptr [rdx+r15*8+0x10], 0x1
vinsertf128 ymm11, ymm12, xmmword ptr [rdx+r15*8+0x30], 0x1
vaddpd ymm12, ymm1, ymm15
vmovupd xmm15, xmmword ptr [rbx+r15*8]
vaddpd ymm1, ymm0, ymm11
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x20]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x10], 0x1
vaddpd ymm15, ymm12, ymm15
vinsertf128 ymm12, ymm0, xmmword ptr [rbx+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x2a0], ymm12
vaddpd ymm12, ymm1, ymm12
vmovupd xmm1, xmmword ptr [rdi+r15*8]
vinsertf128 ymm0, ymm1, xmmword ptr [rdi+r15*8+0x10], 0x1
vaddpd ymm1, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdi+r15*8+0x20]
vinsertf128 ymm0, ymm15, xmmword ptr [rdi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x220], ymm0
vaddpd ymm0, ymm12, ymm0
vmovupd xmm12, xmmword ptr [rsi+r15*8]
mov rdi, qword ptr [rsp+0x430]
vinsertf128 ymm15, ymm12, xmmword ptr [rsi+r15*8+0x10], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rsi+r15*8+0x20]
vinsertf128 ymm12, ymm1, xmmword ptr [rsi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x240], ymm12
vaddpd ymm12, ymm0, ymm12
vmovupd xmm0, xmmword ptr [rdi+r15*8]
mov rsi, qword ptr [rsp+0x438]
vinsertf128 ymm1, ymm0, xmmword ptr [rdi+r15*8+0x10], 0x1
vaddpd ymm1, ymm15, ymm1
vmovupd xmm15, xmmword ptr [rdi+r15*8+0x20]
vinsertf128 ymm0, ymm15, xmmword ptr [rdi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x260], ymm0
vaddpd ymm0, ymm12, ymm0
vmovupd xmm12, xmmword ptr [rsi+r15*8]
mov rdi, qword ptr [rsp+0x418]
vinsertf128 ymm15, ymm12, xmmword ptr [rsi+r15*8+0x10], 0x1
vaddpd ymm12, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rsi+r15*8+0x20]
vinsertf128 ymm15, ymm1, xmmword ptr [rsi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x280], ymm15
vaddpd ymm15, ymm0, ymm15
vmovupd xmm0, xmmword ptr [rdi+r15*8]
mov rsi, qword ptr [rsp+0x410]
vinsertf128 ymm1, ymm0, xmmword ptr [rdi+r15*8+0x10], 0x1
vmovupd xmm0, xmmword ptr [rdi+r15*8+0x20]
vaddpd ymm12, ymm12, ymm1
vinsertf128 ymm1, ymm0, xmmword ptr [rdi+r15*8+0x30], 0x1
vmovupd xmm0, xmmword ptr [rsi+r15*8]
vmovups ymmword ptr [rsp+0x2c0], ymm1
vaddpd ymm15, ymm15, ymm1
mov rdi, qword ptr [rsp+0x460]
vinsertf128 ymm1, ymm0, xmmword ptr [rsi+r15*8+0x10], 0x1
vaddpd ymm1, ymm12, ymm1
vmovupd xmm12, xmmword ptr [rsi+r15*8+0x20]
vinsertf128 ymm12, ymm12, xmmword ptr [rsi+r15*8+0x30], 0x1
vaddpd ymm0, ymm15, ymm12
vmovupd xmm15, xmmword ptr [rdi+r15*8]
mov rsi, qword ptr [rsp+0x428]
vinsertf128 ymm15, ymm15, xmmword ptr [rdi+r15*8+0x10], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdi+r15*8+0x20]
vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x2e0], ymm1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rsi+r15*8]
mov rdi, qword ptr [rsp+0x468]
vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x10], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rsi+r15*8+0x20]
vinsertf128 ymm15, ymm15, xmmword ptr [rsi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x300], ymm15
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdi+r15*8]
mov rsi, qword ptr [rsp+0x448]
vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x10], 0x1
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm0, ymmword ptr [rsi+r15*8]
vmovupd xmm0, xmmword ptr [rdi+r15*8+0x20]
vinsertf128 ymm0, ymm0, xmmword ptr [rdi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x320], ymm0
vaddpd ymm15, ymm15, ymm0
vmovupd ymm0, ymmword ptr [rsi+r15*8+0x20]
mov rdi, qword ptr [rsp+0x450]
vmovupd ymmword ptr [rsp+0x340], ymm0
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdi+r15*8]
mov rsi, qword ptr [rsp+0x408]
vinsertf128 ymm15, ymm15, xmmword ptr [rdi+r15*8+0x10], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdi+r15*8+0x20]
vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x360], ymm1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rsi+r15*8]
mov rdi, qword ptr [rsp+0x458]
vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x10], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rsi+r15*8+0x20]
vinsertf128 ymm15, ymm15, xmmword ptr [rsi+r15*8+0x30], 0x1
mov rsi, qword ptr [rsp+0x420]
vmovups ymmword ptr [rsp+0x380], ymm15
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rsi+r15*8]
vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x10], 0x1
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm0, ymmword ptr [rdi+r15*8]
vmovupd xmm0, xmmword ptr [rsi+r15*8+0x20]
vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x30], 0x1
vmovups ymmword ptr [rsp+0x3a0], ymm0
vaddpd ymm15, ymm15, ymm0
vmovupd ymm0, ymmword ptr [rdi+r15*8+0x20]
vmovupd ymmword ptr [rsp+0x3c0], ymm0
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r14+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [r14+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r14+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [r14+r15*8+0x38], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r13+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r13+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [r13+r15*8+0x38], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r12+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [r12+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r12+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x38], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r11+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r11+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x38], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r10+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [r10+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r10+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [r10+r15*8+0x38], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r9+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [r9+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r9+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x38], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r8+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [r8+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r8+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x38], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rcx+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rcx+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x38], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rax+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rax+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x38], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdx+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x38], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x4e0]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x470]
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x430]
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x438]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x418]
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x410]
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x460]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x428]
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x468]
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x448]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x450]
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
mov rbx, qword ptr [rsp+0x408]
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rsi+r15*8+0x8]
vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x18], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rsi+r15*8+0x28]
vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x38], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdi+r15*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rdi+r15*8+0x18], 0x1
vaddpd ymm1, ymm1, ymm15
vaddpd ymm15, ymm1, ymmword ptr [r14+r15*8+0x10]
vmovupd xmm1, xmmword ptr [rdi+r15*8+0x28]
vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x38], 0x1
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm0, ymmword ptr [r14+r15*8+0x30]
vmovupd xmm0, xmmword ptr [r13+r15*8+0x10]
vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r13+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [r13+r15*8+0x40], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r12+r15*8+0x10]
vinsertf128 ymm1, ymm1, xmmword ptr [r12+r15*8+0x20], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r12+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x40], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r11+r15*8+0x10]
vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x20], 0x1
vaddpd ymm1, ymm1, ymm15
vaddpd ymm15, ymm1, ymmword ptr [r10+r15*8+0x10]
vmovupd xmm1, xmmword ptr [r11+r15*8+0x30]
vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x40], 0x1
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm0, ymmword ptr [r10+r15*8+0x30]
vmovupd xmm0, xmmword ptr [r9+r15*8+0x10]
vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r9+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [r9+r15*8+0x40], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r8+r15*8+0x10]
vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x20], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r8+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [r8+r15*8+0x40], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rcx+r15*8+0x10]
vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x20], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rcx+r15*8+0x30]
vinsertf128 ymm1, ymm1, xmmword ptr [rcx+r15*8+0x40], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rax+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x40], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
mov rax, qword ptr [rsp+0x4d8]
vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x40], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
mov rdx, qword ptr [rsp+0x4e0]
vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rax+r15*8+0x30]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x40], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x10]
mov rax, qword ptr [rsp+0x430]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdx+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x40], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rax+r15*8+0x10]
mov rdx, qword ptr [rsp+0x438]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x20], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rax+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x40], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdx+r15*8+0x10]
mov rax, qword ptr [rsp+0x418]
vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x20], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x30]
vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x40], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rax+r15*8+0x10]
mov rdx, qword ptr [rsp+0x410]
vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rax+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x40], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
mov rax, qword ptr [rsp+0x460]
vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x40], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
mov rdx, qword ptr [rsp+0x428]
vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rax+r15*8+0x30]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x40], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x10]
mov rax, qword ptr [rsp+0x448]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdx+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x40], 0x1
mov rdx, qword ptr [rsp+0x468]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm0, ymmword ptr [rax+r15*8+0x10]
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x40], 0x1
vaddpd ymm15, ymm15, ymm0
vaddpd ymm0, ymm15, ymmword ptr [rax+r15*8+0x30]
mov rax, qword ptr [rsp+0x450]
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rax+r15*8+0x30]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x40], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x10]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x20], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rbx+r15*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x40], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rsi+r15*8+0x10]
vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x20], 0x1
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm0, ymmword ptr [rdi+r15*8+0x10]
vmovupd xmm0, xmmword ptr [rsi+r15*8+0x30]
vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x40], 0x1
vaddpd ymm15, ymm15, ymm0
vaddpd ymm0, ymm15, ymmword ptr [rdi+r15*8+0x30]
vmovupd xmm15, xmmword ptr [r14+r15*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r14+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r14+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r14+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r13+r15*8+0x18]
mov r14, qword ptr [rsp+0x418]
vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r13+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [r13+r15*8+0x48], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r12+r15*8+0x18]
mov r13, qword ptr [rsp+0x438]
vinsertf128 ymm1, ymm1, xmmword ptr [r12+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r12+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r11+r15*8+0x18]
mov r12, qword ptr [rsp+0x430]
vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r11+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r10+r15*8+0x18]
mov r11, qword ptr [rsp+0x470]
vinsertf128 ymm0, ymm0, xmmword ptr [r10+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r10+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [r10+r15*8+0x48], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r9+r15*8+0x18]
mov r10, qword ptr [rsp+0x4e0]
vinsertf128 ymm1, ymm1, xmmword ptr [r9+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r9+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r8+r15*8+0x18]
mov r9, qword ptr [rsp+0x4d8]
vinsertf128 ymm15, ymm15, xmmword ptr [r8+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r8+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rcx+r15*8+0x18]
mov r8, qword ptr [rsp+0x4d0]
vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rcx+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x48], 0x1
mov rcx, qword ptr [rsp+0x4b0]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rcx+r15*8+0x18]
vinsertf128 ymm1, ymm1, xmmword ptr [rcx+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rcx+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r8+r15*8+0x18]
mov rcx, qword ptr [rsp+0x410]
vinsertf128 ymm15, ymm15, xmmword ptr [r8+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r8+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r9+r15*8+0x18]
mov r8, qword ptr [rsp+0x460]
vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r9+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [r9+r15*8+0x48], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r10+r15*8+0x18]
mov r9, qword ptr [rsp+0x428]
vinsertf128 ymm1, ymm1, xmmword ptr [r10+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r10+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [r10+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r11+r15*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r11+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r12+r15*8+0x18]
vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r12+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [r12+r15*8+0x48], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r13+r15*8+0x18]
vinsertf128 ymm1, ymm1, xmmword ptr [r13+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r13+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r14+r15*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r14+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r14+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r14+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rcx+r15*8+0x18]
vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rcx+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x48], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r8+r15*8+0x18]
vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [r8+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [r8+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [r9+r15*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [r9+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [r9+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [r9+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x18]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x28], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rdx+r15*8+0x38]
vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x48], 0x1
mov rdx, qword ptr [rsp+0x448]
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x18]
vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x28], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x48], 0x1
vaddpd ymm0, ymm15, ymm0
vmovupd xmm15, xmmword ptr [rax+r15*8+0x18]
vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x28], 0x1
vaddpd ymm15, ymm1, ymm15
vmovupd xmm1, xmmword ptr [rax+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x48], 0x1
vaddpd ymm1, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x18]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x28], 0x1
vaddpd ymm15, ymm15, ymm0
vmovupd xmm0, xmmword ptr [rbx+r15*8+0x38]
vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x48], 0x1
vaddpd ymm0, ymm1, ymm0
vmovupd xmm1, xmmword ptr [rsi+r15*8+0x18]
vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x28], 0x1
vaddpd ymm15, ymm15, ymm1
vmovupd xmm1, xmmword ptr [rsi+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x48], 0x1
vaddpd ymm0, ymm0, ymm1
vmovupd xmm1, xmmword ptr [rdi+r15*8+0x18]
vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x28], 0x1
vmovups ymmword ptr [rsp+0x3e0], ymm1
vmovupd xmm1, xmmword ptr [rdi+r15*8+0x38]
vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x48], 0x1
mov r14, r11
mov r13, r10
vaddpd ymm15, ymm15, ymmword ptr [rsp+0x3e0]
vaddpd ymm0, ymm0, ymm1
vaddpd ymm1, ymm15, ymm2
vaddpd ymm2, ymm1, ymm3
vaddpd ymm3, ymm2, ymm4
vaddpd ymm4, ymm3, ymm5
vaddpd ymm5, ymm4, ymm6
vaddpd ymm6, ymm5, ymm7
vaddpd ymm7, ymm6, ymm8
vaddpd ymm8, ymm7, ymm9
mov rax, qword ptr [rsp+0x4a0]
mov rdx, qword ptr [rsp+0x4a8]
vaddpd ymm9, ymm8, ymm10
vaddpd ymm4, ymm0, ymmword ptr [rax+r15*8+0x40]
vmovupd xmm0, xmmword ptr [rdx+r15*8+0x40]
vaddpd ymm10, ymm9, ymm11
mov rcx, qword ptr [rsp+0x498]
vaddpd ymm11, ymm10, ymmword ptr [rsp+0x2a0]
vmovupd xmm6, xmmword ptr [rcx+r15*8+0x40]
vaddpd ymm1, ymm11, ymmword ptr [rsp+0x220]
mov rbx, qword ptr [rsp+0x490]
vaddpd ymm2, ymm1, ymmword ptr [rsp+0x240]
vmovupd xmm9, xmmword ptr [rbx+r15*8+0x40]
vaddpd ymm3, ymm2, ymmword ptr [rsp+0x260]
mov rdi, qword ptr [rsp+0x4c0]
mov rsi, qword ptr [rsp+0x440]
mov r8, qword ptr [rsp+0x4b8]
vmovupd xmm1, xmmword ptr [rdi+r15*8+0x40]
vaddpd ymm11, ymm3, ymmword ptr [rsp+0x280]
mov r9, qword ptr [rsp+0x4c8]
mov r10, qword ptr [rsp+0x4b0]
mov r11, qword ptr [rsp+0x4d0]
mov r12, qword ptr [rsp+0x4d8]
mov rax, qword ptr [rsp+0x430]
vinsertf128 ymm5, ymm0, xmmword ptr [rdx+r15*8+0x50], 0x1
vaddpd ymm7, ymm4, ymm5
vmovupd xmm4, xmmword ptr [r8+r15*8+0x40]
mov rdx, qword ptr [rsp+0x438]
vinsertf128 ymm8, ymm6, xmmword ptr [rcx+r15*8+0x50], 0x1
vaddpd ymm10, ymm7, ymm8
vmovupd xmm7, xmmword ptr [r9+r15*8+0x40]
mov rcx, qword ptr [rsp+0x418]
vinsertf128 ymm15, ymm9, xmmword ptr [rbx+r15*8+0x50], 0x1
vaddpd ymm0, ymm10, ymm15
vmovupd xmm10, xmmword ptr [r10+r15*8+0x40]
vaddpd ymm2, ymm0, ymmword ptr [rsi+r15*8+0x40]
mov rbx, qword ptr [rsp+0x410]
mov rsi, qword ptr [rsp+0x460]
vinsertf128 ymm3, ymm1, xmmword ptr [rdi+r15*8+0x50], 0x1
vaddpd ymm5, ymm2, ymm3
vmovupd xmm1, xmmword ptr [r11+r15*8+0x40]
mov rdi, qword ptr [rsp+0x428]
vinsertf128 ymm6, ymm4, xmmword ptr [r8+r15*8+0x50], 0x1
vaddpd ymm8, ymm5, ymm6
vmovupd xmm4, xmmword ptr [r12+r15*8+0x40]
mov r8, qword ptr [rsp+0x468]
vinsertf128 ymm9, ymm7, xmmword ptr [r9+r15*8+0x50], 0x1
vaddpd ymm15, ymm8, ymm9
vmovupd xmm7, xmmword ptr [r13+r15*8+0x40]
mov r9, qword ptr [rsp+0x448]
vinsertf128 ymm0, ymm10, xmmword ptr [r10+r15*8+0x50], 0x1
vaddpd ymm2, ymm15, ymm0
vmovupd xmm10, xmmword ptr [r14+r15*8+0x40]
mov r10, qword ptr [rsp+0x450]
vinsertf128 ymm3, ymm1, xmmword ptr [r11+r15*8+0x50], 0x1
vaddpd ymm5, ymm2, ymm3
vmovupd xmm1, xmmword ptr [rax+r15*8+0x40]
mov r11, qword ptr [rsp+0x408]
vinsertf128 ymm6, ymm4, xmmword ptr [r12+r15*8+0x50], 0x1
vaddpd ymm8, ymm5, ymm6
vmovupd xmm4, xmmword ptr [rdx+r15*8+0x40]
mov r12, qword ptr [rsp+0x420]
vinsertf128 ymm9, ymm7, xmmword ptr [r13+r15*8+0x50], 0x1
vaddpd ymm15, ymm8, ymm9
vmovupd xmm7, xmmword ptr [rcx+r15*8+0x40]
mov r13, qword ptr [rsp+0x458]
vinsertf128 ymm0, ymm10, xmmword ptr [r14+r15*8+0x50], 0x1
vaddpd ymm2, ymm15, ymm0
vaddpd ymm0, ymm11, ymmword ptr [rsp+0x2c0]
vmovupd xmm11, xmmword ptr [rbx+r15*8+0x40]
vaddpd ymm0, ymm0, ymm12
vmovupd xmm12, xmmword ptr [rsi+r15*8+0x40]
mov r14, qword ptr [rsp+0x488]
vinsertf128 ymm3, ymm1, xmmword ptr [rax+r15*8+0x50], 0x1
vaddpd ymm5, ymm2, ymm3
vmovupd xmm3, xmmword ptr [rdi+r15*8+0x40]
vinsertf128 ymm6, ymm4, xmmword ptr [rdx+r15*8+0x50], 0x1
vaddpd ymm8, ymm5, ymm6
vaddpd ymm4, ymm0, ymmword ptr [rsp+0x2e0]
vinsertf128 ymm9, ymm7, xmmword ptr [rcx+r15*8+0x50], 0x1
vaddpd ymm1, ymm8, ymm9
vmovupd xmm7, xmmword ptr [r8+r15*8+0x40]
vaddpd ymm8, ymm4, ymmword ptr [rsp+0x300]
vinsertf128 ymm2, ymm11, xmmword ptr [rbx+r15*8+0x50], 0x1
vaddpd ymm1, ymm1, ymm2
vaddpd ymm11, ymm8, ymmword ptr [rsp+0x320]
vaddpd ymm0, ymm11, ymmword ptr [rsp+0x340]
vaddpd ymm4, ymm0, ymmword ptr [rsp+0x360]
vaddpd ymm8, ymm4, ymmword ptr [rsp+0x380]
vaddpd ymm11, ymm8, ymmword ptr [rsp+0x3a0]
vaddpd ymm0, ymm11, ymmword ptr [rsp+0x3c0]
vmulpd ymm13, ymm13, ymm0
vinsertf128 ymm2, ymm12, xmmword ptr [rsi+r15*8+0x50], 0x1
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm6, ymm3, xmmword ptr [rdi+r15*8+0x50], 0x1
vaddpd ymm9, ymm5, ymm6
vmovupd xmm3, xmmword ptr [r11+r15*8+0x40]
vinsertf128 ymm10, ymm7, xmmword ptr [r8+r15*8+0x50], 0x1
vaddpd ymm15, ymm9, ymm10
vmovupd xmm7, xmmword ptr [r12+r15*8+0x40]
vaddpd ymm1, ymm15, ymmword ptr [r9+r15*8+0x40]
vmovupd xmm15, xmmword ptr [r10+r15*8+0x40]
vinsertf128 ymm2, ymm15, xmmword ptr [r10+r15*8+0x50], 0x1
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm6, ymm3, xmmword ptr [r11+r15*8+0x50], 0x1
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm10, ymm7, xmmword ptr [r12+r15*8+0x50], 0x1
vaddpd ymm12, ymm9, ymm10
vaddpd ymm1, ymm12, ymmword ptr [r13+r15*8+0x40]
vmulpd ymm14, ymm14, ymm1
vmovupd xmmword ptr [r14+r15*8+0x10], xmm13
vmovupd xmmword ptr [r14+r15*8+0x30], xmm14
vextractf128 xmmword ptr [r14+r15*8+0x20], ymm13, 0x1
vextractf128 xmmword ptr [r14+r15*8+0x40], ymm14, 0x1
add r15, 0x8
cmp r15, qword ptr [rsp+0x400]
jb 0xffffffffffffebcb
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 152
L2: P <= 32776/27
L3: P <= 3276808/27
L1: 56*N*P - 64*P - 64 <= 32768
L2: 56*N*P - 64*P - 64 <= 262144
L3: 56*N*P - 64*P - 64 <= 26214400
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 357.19 Cycles       Throughput Bottleneck: Dependency chains (possibly between iterations)

Port Binding In Cycles Per Iteration:
----------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -   D   |   3   -   D   |   4   |   5   |
----------------------------------------------------------------------------------
| Cycles | 105.5    0.0  | 248.0 | 277.0   285.0 | 277.0   285.0 | 34.0  | 105.5 |
----------------------------------------------------------------------------------

N - port number or number of cycles resource conflict caused delay, DV - Divider pipe (on port 0)
D - Data fetch pipe (on ports 2 and 3), CP - on a critical path
F - Macro Fusion with the previous instruction occurred
* - instruction micro-ops not bound to a port
^ - Micro Fusion happened
# - ESP Tracking sync uop was issued
@ - SSE instruction followed an AVX256/AVX512 instruction, dozens of cycles penalty is expected
X - instruction not supported, was not accounted in Analysis

| Num Of |              Ports pressure in cycles               |    |
|  Uops  |  0  - DV  |  1  |  2  -  D  |  3  -  D  |  4  |  5  |    |
---------------------------------------------------------------------
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x480]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r14, qword ptr [rsp+0x4a0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r13, qword ptr [rsp+0x4a8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm13, xmmword ptr [rsi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm14, xmmword ptr [rsi+r15*8+0x30]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm6, xmmword ptr [r13+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [r13+r15*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r12, qword ptr [rsp+0x498]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r11, qword ptr [rsp+0x490]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r10, qword ptr [rsp+0x440]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r9, qword ptr [rsp+0x4c0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm11, xmmword ptr [r11+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [r11+r15*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r8, qword ptr [rsp+0x4b8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rcx, qword ptr [rsp+0x4c8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x4b0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x4d0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x4d8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x4e0]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm13, ymm13, xmmword ptr [rsi+r15*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm14, ymm14, xmmword ptr [rsi+r15*8+0x40], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x470]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm2, xmmword ptr [rsi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm3, xmmword ptr [rsi+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm4, ymm2, xmmword ptr [rsi+r15*8+0x20], 0x1
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmovupd ymm2, ymmword ptr [r14+r15*8+0x20]
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm8, ymm4, ymmword ptr [r14+r15*8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm4, ymm6, xmmword ptr [r13+r15*8+0x10], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm6, xmmword ptr [r12+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm8, ymm4
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm5, ymm3, xmmword ptr [rsi+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm5, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm3, ymm7, xmmword ptr [r13+r15*8+0x30], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [r12+r15*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm5, ymm3
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm9, ymm6, xmmword ptr [r12+r15*8+0x10], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm4, ymm7, xmmword ptr [r12+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm8, ymm9
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm10, ymm4
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm9, xmmword ptr [r9+r15*8]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmovupd ymm6, ymmword ptr [r10+r15*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm10, xmmword ptr [r9+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm11, xmmword ptr [r11+r15*8+0x10], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm5, ymm12, xmmword ptr [r11+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm7, ymm15, ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm1, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r8+r15*8]
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm11, ymm7, ymmword ptr [r10+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm8, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r8+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm12, ymm9, xmmword ptr [r9+r15*8+0x10], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm7, ymm10, xmmword ptr [r9+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm11, ymm12
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm15, ymm7
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [rcx+r15*8+0x20]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm11, ymm0, xmmword ptr [r8+r15*8+0x10], 0x1
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm8, ymm1, xmmword ptr [r8+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm11, ymm10, ymm11
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm9, ymm8
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm9, xmmword ptr [rcx+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rax+r15*8+0x20]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm9, xmmword ptr [rcx+r15*8+0x10], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm9, ymm12, xmmword ptr [rcx+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm11, ymm15
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm11, ymm10, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm10, xmmword ptr [rax+r15*8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm10, xmmword ptr [rax+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [rdx+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm10, ymm0, xmmword ptr [rax+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm11, ymm10
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm11, xmmword ptr [rdx+r15*8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm11, xmmword ptr [rdx+r15*8+0x10], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm11, ymm12, xmmword ptr [rdx+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm12, ymm15
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm12, ymm0, xmmword ptr [rbx+r15*8+0x30], 0x1
|   2^   |           |     | 0.9       | 0.1       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x2a0], ymm12
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm1, ymm12
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm1, xmmword ptr [rdi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm15, xmmword ptr [rdi+r15*8+0x30], 0x1
|   2^   |           |     |           | 1.0       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x220], ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm12, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [rsi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x430]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm12, xmmword ptr [rsi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm12, ymm1, xmmword ptr [rsi+r15*8+0x30], 0x1
|   2^   |           |     | 1.0       |           | 2.0 |     |    | vmovups ymmword ptr [rsp+0x240], ymm12
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm0, ymm12
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x438]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm0, xmmword ptr [rdi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm15, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm15, xmmword ptr [rdi+r15*8+0x30], 0x1
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x260], ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm12, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [rsi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x418]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm12, xmmword ptr [rsi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8+0x20]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm1, xmmword ptr [rsi+r15*8+0x30], 0x1
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x280], ymm15
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm0, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x410]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm0, xmmword ptr [rdi+r15*8+0x10], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdi+r15*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm12, ymm1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm0, xmmword ptr [rdi+r15*8+0x30], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rsi+r15*8]
|   2^   |           |     | 1.0       |           | 2.0 |     |    | vmovups ymmword ptr [rsp+0x2c0], ymm1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x460]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm0, xmmword ptr [rsi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [rsi+r15*8+0x20]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm12, ymm12, xmmword ptr [rsi+r15*8+0x30], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm12
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x428]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x30], 0x1
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x2e0], ymm1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rsi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x468]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rsi+r15*8+0x20]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rsi+r15*8+0x30], 0x1
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x300], ymm15
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x448]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm0, ymmword ptr [rsi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdi+r15*8+0x30], 0x1
|   2^   |           |     |           | 1.0       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x320], ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm0
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmovupd ymm0, ymmword ptr [rsi+r15*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x450]
|   2^   |           |     | 1.0       |           | 2.0 |     |    | vmovupd ymmword ptr [rsp+0x340], ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x408]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x30], 0x1
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x360], ymm1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rsi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x458]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rsi+r15*8+0x20]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rsi+r15*8+0x30], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x420]
|   2^   |           |     |           | 1.0       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x380], ymm15
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x10], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm0, ymmword ptr [rdi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rsi+r15*8+0x20]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x30], 0x1
|   2^   |           |     |           | 1.0       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x3a0], ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm0
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmovupd ymm0, ymmword ptr [rdi+r15*8+0x20]
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovupd ymmword ptr [rsp+0x3c0], ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r14+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r14+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r14+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r14+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r13+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r13+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r13+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r12+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r12+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r12+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r11+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r11+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r10+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r10+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r10+r15*8+0x28]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r10+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r9+r15*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r9+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r9+r15*8+0x28]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r8+r15*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r8+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r8+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rcx+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rcx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rax+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdx+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x28]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x4e0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x470]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x430]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x438]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x418]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x410]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x460]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x428]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x468]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x448]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x450]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rbx+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x408]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x28]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8+0x8]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rsi+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdi+r15*8+0x8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdi+r15*8+0x18], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm1, ymm15
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm15, ymm1, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8+0x28]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x38], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm0, ymmword ptr [r14+r15*8+0x30]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r13+r15*8+0x10]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r13+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r13+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r12+r15*8+0x10]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r12+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r12+r15*8+0x30]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r11+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm1, ymm15
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm15, ymm1, ymmword ptr [r10+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r11+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm0, ymmword ptr [r10+r15*8+0x30]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r9+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r9+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r9+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r8+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r8+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r8+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rcx+r15*8+0x10]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rcx+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rcx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rax+r15*8+0x10]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rax+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x4d8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x4e0]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x430]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdx+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x438]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rax+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x418]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x410]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rax+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x460]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x428]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x448]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdx+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x40], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x468]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm0, ymmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm0
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm0, ymm15, ymmword ptr [rax+r15*8+0x30]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x450]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x10]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rbx+r15*8+0x30]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x20], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm0, ymmword ptr [rdi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rsi+r15*8+0x30]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rsi+r15*8+0x40], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm0
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm0, ymm15, ymmword ptr [rdi+r15*8+0x30]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r14+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r14+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r14+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r14+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r13+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r14, qword ptr [rsp+0x418]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r13+r15*8+0x38]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r13+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r12+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r13, qword ptr [rsp+0x438]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r12+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r12+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r11+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r12, qword ptr [rsp+0x430]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r11+r15*8+0x38]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r10+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r11, qword ptr [rsp+0x470]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r10+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r10+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r10+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r9+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r10, qword ptr [rsp+0x4e0]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r9+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r9+r15*8+0x38]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r8+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r9, qword ptr [rsp+0x4d8]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r8+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r8+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rcx+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r8, qword ptr [rsp+0x4d0]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rcx+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x48], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rcx, qword ptr [rsp+0x4b0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rcx+r15*8+0x18]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rcx+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rcx+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r8+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rcx, qword ptr [rsp+0x410]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r8+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r8+r15*8+0x38]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r9+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r8, qword ptr [rsp+0x460]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r9+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r9+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r9+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r10+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r9, qword ptr [rsp+0x428]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r10+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r10+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r10+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r11+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r11+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r11+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r11+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r12+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [r12+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r12+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r12+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r13+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm1, ymm1, xmmword ptr [r13+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r13+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r13+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r14+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r14+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r14+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r14+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rcx+r15*8+0x18]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rcx+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rcx+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rcx+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r8+r15*8+0x18]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r8+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [r8+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm0, ymm0, xmmword ptr [r8+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r9+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm15, ymm15, xmmword ptr [r9+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r9+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [r9+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rdx+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rdx+r15*8+0x48], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x448]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x18]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdx+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rdx+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [rax+r15*8+0x18]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm15, xmmword ptr [rax+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm1, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x38]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rax+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x18]
|   2    | 1.0       |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rbx+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm0, xmmword ptr [rbx+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm1, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8+0x18]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x28], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm15, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rsi+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rsi+r15*8+0x48], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8+0x18]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x28], 0x1
|   2^   |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovups ymmword ptr [rsp+0x3e0], ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8+0x38]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm1, ymm1, xmmword ptr [rdi+r15*8+0x48], 0x1
|   1*   |           |     |           |           |     |     |    | mov r14, r11
|   1*   |           |     |           |           |     |     |    | mov r13, r10
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm15, ymm15, ymmword ptr [rsp+0x3e0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm15, ymm2
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm2, ymm1, ymm3
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm3, ymm2, ymm4
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm4, ymm3, ymm5
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm4, ymm6
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm6, ymm5, ymm7
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm7, ymm6, ymm8
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm7, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x4a0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x4a8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm8, ymm10
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm4, ymm0, ymmword ptr [rax+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm0, xmmword ptr [rdx+r15*8+0x40]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm9, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rcx, qword ptr [rsp+0x498]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm11, ymm10, ymmword ptr [rsp+0x2a0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm6, xmmword ptr [rcx+r15*8+0x40]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm11, ymmword ptr [rsp+0x220]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x490]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm2, ymm1, ymmword ptr [rsp+0x240]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm9, xmmword ptr [rbx+r15*8+0x40]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm3, ymm2, ymmword ptr [rsp+0x260]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x4c0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x440]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r8, qword ptr [rsp+0x4b8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rdi+r15*8+0x40]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm11, ymm3, ymmword ptr [rsp+0x280]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r9, qword ptr [rsp+0x4c8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r10, qword ptr [rsp+0x4b0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r11, qword ptr [rsp+0x4d0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r12, qword ptr [rsp+0x4d8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rax, qword ptr [rsp+0x430]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm5, ymm0, xmmword ptr [rdx+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm7, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm4, xmmword ptr [r8+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdx, qword ptr [rsp+0x438]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm8, ymm6, xmmword ptr [rcx+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm7, ymm8
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [r9+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rcx, qword ptr [rsp+0x418]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm15, ymm9, xmmword ptr [rbx+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm10, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm10, xmmword ptr [r10+r15*8+0x40]
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm2, ymm0, ymmword ptr [rsi+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rbx, qword ptr [rsp+0x410]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rsi, qword ptr [rsp+0x460]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm3, ymm1, xmmword ptr [rdi+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [r11+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov rdi, qword ptr [rsp+0x428]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm6, ymm4, xmmword ptr [r8+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm4, xmmword ptr [r12+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r8, qword ptr [rsp+0x468]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm9, ymm7, xmmword ptr [r9+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [r13+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r9, qword ptr [rsp+0x448]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm10, xmmword ptr [r10+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm2, ymm15, ymm0
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm10, xmmword ptr [r14+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r10, qword ptr [rsp+0x450]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm3, ymm1, xmmword ptr [r11+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm1, xmmword ptr [rax+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r11, qword ptr [rsp+0x408]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm6, ymm4, xmmword ptr [r12+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm4, xmmword ptr [rdx+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r12, qword ptr [rsp+0x420]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm9, ymm7, xmmword ptr [r13+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [rcx+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r13, qword ptr [rsp+0x458]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm0, ymm10, xmmword ptr [r14+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm2, ymm15, ymm0
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm0, ymm11, ymmword ptr [rsp+0x2c0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm11, xmmword ptr [rbx+r15*8+0x40]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm0, ymm12
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm12, xmmword ptr [rsi+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | mov r14, qword ptr [rsp+0x488]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm3, ymm1, xmmword ptr [rax+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm3, xmmword ptr [rdi+r15*8+0x40]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm6, ymm4, xmmword ptr [rdx+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm5, ymm6
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm4, ymm0, ymmword ptr [rsp+0x2e0]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm9, ymm7, xmmword ptr [rcx+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [r8+r15*8+0x40]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm8, ymm4, ymmword ptr [rsp+0x300]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm2, ymm11, xmmword ptr [rbx+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm1, ymm2
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm11, ymm8, ymmword ptr [rsp+0x320]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm0, ymm11, ymmword ptr [rsp+0x340]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm4, ymm0, ymmword ptr [rsp+0x360]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm8, ymm4, ymmword ptr [rsp+0x380]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm11, ymm8, ymmword ptr [rsp+0x3a0]
|   2^   |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm0, ymm11, ymmword ptr [rsp+0x3c0]
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm13, ymm13, ymm0
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm2, ymm12, xmmword ptr [rsi+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm6, ymm3, xmmword ptr [rdi+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm3, xmmword ptr [r11+r15*8+0x40]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm10, ymm7, xmmword ptr [r8+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm9, ymm10
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm7, xmmword ptr [r12+r15*8+0x40]
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm15, ymmword ptr [r9+r15*8+0x40]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r10+r15*8+0x40]
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm2, ymm15, xmmword ptr [r10+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    | 0.5       |     | 0.5   0.5 | 0.5   0.5 |     | 0.5 |    | vinsertf128 ymm6, ymm3, xmmword ptr [r11+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm10, ymm7, xmmword ptr [r12+r15*8+0x50], 0x1
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   2    |           | 1.0 | 0.5   1.0 | 0.5   1.0 |     |     |    | vaddpd ymm1, ymm12, ymmword ptr [r13+r15*8+0x40]
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm14, ymm14, ymm1
|   2    |           |     | 0.5       | 0.5       | 1.0 |     |    | vmovupd xmmword ptr [r14+r15*8+0x10], xmm13
|   2    |           |     | 1.0       |           | 1.0 |     |    | vmovupd xmmword ptr [r14+r15*8+0x30], xmm14
|   2    |           |     | 0.5       | 0.5       | 1.0 |     |    | vextractf128 xmmword ptr [r14+r15*8+0x20], ymm13, 0x1
|   2    |           |     |           | 1.0       | 1.0 |     |    | vextractf128 xmmword ptr [r14+r15*8+0x40], ymm14, 0x1
|   1    | 0.5       |     |           |           |     | 0.5 |    | add r15, 0x8
|   2^   |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | cmp r15, qword ptr [rsp+0x400]
|   0F   |           |     |           |           |     |     |    | jb 0xffffffffffffebcb
Total Num Of Uops: 1034


Detected pointer increment: 64
{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Hostname
################################################################################
e0355

################################################################################
# Operating System
################################################################################
CentOS Linux release 7.6.1810 (Core)
Derived from Red Hat Enterprise Linux 7.6 (Source)
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

CentOS Linux release 7.6.1810 (Core)
CentOS Linux release 7.6.1810 (Core)
cpe:/o:centos:centos:7

################################################################################
# Operating System (LSB)
################################################################################
/home/hpc/iwia/iwia84/INSPECT-repo/scripts/Artifact-description/machine-state.sh: line 149: lsb_release: command not found

################################################################################
# Operating System Kernel
################################################################################
Linux e0355 3.10.0-957.12.2.el7.x86_64 #1 SMP Tue May 14 21:24:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Logged in users
################################################################################
 14:59:49 up 2 days, 29 min,  0 users,  load average: 1.24, 2.40, 2.24
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CPUset
################################################################################
Domain N:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29,10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39

Domain S0:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29

Domain S1:
	10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39

Domain C0:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29

Domain C1:
	10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39

Domain M0:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29

Domain M1:
	10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39


################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-39
Allowed Memory controllers: 0-1

################################################################################
# Topology
################################################################################
--------------------------------------------------------------------------------
CPU name:	Intel(R) Xeon(R) CPU E5-2660 v2 @ 2.20GHz
CPU type:	Intel Xeon IvyBridge EN/EP/EX processor
CPU stepping:	4
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:		2
Cores per socket:	10
Threads per core:	2
--------------------------------------------------------------------------------
HWThread	Thread		Core		Socket		Available
0		0		0		0		*
1		0		1		0		*
2		0		2		0		*
3		0		3		0		*
4		0		4		0		*
5		0		5		0		*
6		0		6		0		*
7		0		7		0		*
8		0		8		0		*
9		0		9		0		*
10		0		10		1		*
11		0		11		1		*
12		0		12		1		*
13		0		13		1		*
14		0		14		1		*
15		0		15		1		*
16		0		16		1		*
17		0		17		1		*
18		0		18		1		*
19		0		19		1		*
20		1		0		0		*
21		1		1		0		*
22		1		2		0		*
23		1		3		0		*
24		1		4		0		*
25		1		5		0		*
26		1		6		0		*
27		1		7		0		*
28		1		8		0		*
29		1		9		0		*
30		1		10		1		*
31		1		11		1		*
32		1		12		1		*
33		1		13		1		*
34		1		14		1		*
35		1		15		1		*
36		1		16		1		*
37		1		17		1		*
38		1		18		1		*
39		1		19		1		*
--------------------------------------------------------------------------------
Socket 0:		( 0 20 1 21 2 22 3 23 4 24 5 25 6 26 7 27 8 28 9 29 )
Socket 1:		( 10 30 11 31 12 32 13 33 14 34 15 35 16 36 17 37 18 38 19 39 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:			1
Size:			32 kB
Cache groups:		( 0 20 ) ( 1 21 ) ( 2 22 ) ( 3 23 ) ( 4 24 ) ( 5 25 ) ( 6 26 ) ( 7 27 ) ( 8 28 ) ( 9 29 ) ( 10 30 ) ( 11 31 ) ( 12 32 ) ( 13 33 ) ( 14 34 ) ( 15 35 ) ( 16 36 ) ( 17 37 ) ( 18 38 ) ( 19 39 )
--------------------------------------------------------------------------------
Level:			2
Size:			256 kB
Cache groups:		( 0 20 ) ( 1 21 ) ( 2 22 ) ( 3 23 ) ( 4 24 ) ( 5 25 ) ( 6 26 ) ( 7 27 ) ( 8 28 ) ( 9 29 ) ( 10 30 ) ( 11 31 ) ( 12 32 ) ( 13 33 ) ( 14 34 ) ( 15 35 ) ( 16 36 ) ( 17 37 ) ( 18 38 ) ( 19 39 )
--------------------------------------------------------------------------------
Level:			3
Size:			25 MB
Cache groups:		( 0 20 1 21 2 22 3 23 4 24 5 25 6 26 7 27 8 28 9 29 ) ( 10 30 11 31 12 32 13 33 14 34 15 35 16 36 17 37 18 38 19 39 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		2
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 20 1 21 2 22 3 23 4 24 5 25 6 26 7 27 8 28 9 29 )
Distances:		10 21
Free memory:		29695.1 MB
Total memory:		32734.2 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 10 30 11 31 12 32 13 33 14 34 15 35 16 36 17 37 18 38 19 39 )
Distances:		21 10
Free memory:		31221.4 MB
Total memory:		32768 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 20 21 22 23 24 25 26 27 28 29
node 0 size: 32734 MB
node 0 free: 29704 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 30 31 32 33 34 35 36 37 38 39
node 1 size: 32768 MB
node 1 free: 31221 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10

################################################################################
# Frequencies
################################################################################
Cannot read frequency data from cpufreq module


################################################################################
# Prefetchers
################################################################################
likwid-features not available

################################################################################
# Load
################################################################################
1.24 2.40 2.24 1/478 18398

################################################################################
# Performance energy bias
################################################################################
Performance energy bias: 7 (0=highest performance, 15 = lowest energy)

################################################################################
# NUMA balancing
################################################################################
Enabled: 1

################################################################################
# General memory info
################################################################################
MemTotal:       65936896 kB
MemFree:        62389204 kB
MemAvailable:   62352964 kB
Buffers:               0 kB
Cached:          2155688 kB
SwapCached:            0 kB
Active:           114704 kB
Inactive:        2055860 kB
Active(anon):      41040 kB
Inactive(anon):  1812568 kB
Active(file):      73664 kB
Inactive(file):   243292 kB
Unevictable:       50020 kB
Mlocked:           54116 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:         65108 kB
Mapped:            48668 kB
Shmem:           1838732 kB
Slab:             232520 kB
SReclaimable:      62208 kB
SUnreclaim:       170312 kB
KernelStack:        8304 kB
PageTables:         3324 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    32968448 kB
Committed_AS:    2024048 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      783248 kB
VmallocChunk:   34324873212 kB
HardwareCorrupted:     0 kB
AnonHugePages:     26624 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      299636 kB
DirectMap2M:     9103360 kB
DirectMap1G:    59768832 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: [always] madvise never
Use zero page: 1

################################################################################
# Hardware power limits
################################################################################
RAPL domain package-1
- Limit0 long_term MaxPower 95000000uW Limit 95000000uW TimeWindow 9994240us
- Limit1 short_term MaxPower 150000000uW Limit 114000000uW TimeWindow 7808us
RAPL domain core
- Limit0 long_term MaxPower NAuW Limit 0uW TimeWindow 976us
RAPL domain dram
- Limit0 long_term MaxPower 39000000uW Limit 0uW TimeWindow 976us
RAPL domain package-0
- Limit0 long_term MaxPower 95000000uW Limit 95000000uW TimeWindow 9994240us
- Limit1 short_term MaxPower 150000000uW Limit 114000000uW TimeWindow 7808us
RAPL domain core
- Limit0 long_term MaxPower NAuW Limit 0uW TimeWindow 976us
RAPL domain dram
- Limit0 long_term MaxPower 39000000uW Limit 0uW TimeWindow 976us

################################################################################
# Compiler
################################################################################
icc (ICC) 19.0.2.187 20190117
Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.


################################################################################
# MPI
################################################################################
Intel(R) MPI Library for Linux* OS, Version 2019 Update 2 Build 20190123 (id: e2d820d49)
Copyright 2003-2019, Intel Corporation.

################################################################################
# dmidecode
################################################################################
dmidecode not executable, so ask your administrator to put the
dmidecode output to a file (configured /etc/dmidecode.txt)

################################################################################
# environment variables
################################################################################
MKLROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
MANPATH=/apps/python/3.5-anaconda/share/man:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:/apps/intel/ComposerXE2019/man/common::/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:/apps/intel/mpi/man:/apps/likwid/4.3.4/man
MPILIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib
LESS_TERMCAP_mb=[1;32m
HOSTNAME=e0355
LESS_TERMCAP_md=[1;34m
PBS_VERSION=TORQUE-4.2.10
_LMFILES__modshare=/apps/modules/data/tools/python/3.5-anaconda:1:/apps/modules/data/development/intel64/19.0up02:1:/apps/modules/data/libraries/mkl/2019up02:1:/apps/modules/data/tools/likwid/4.3.4:1:/apps/modules/data/development/intelmpi/2019up02-intel:1
LESS_TERMCAP_me=[0m
MODULEPATH_modshare=/apps/modules/data/deprecated:4:/apps/modules/data/tools:4:/apps/modules/data/libraries:4:/apps/modules/data/testing:4:/apps/modules/data/via-spack:4:/apps/modules/data/development:4:/apps/modules/data/applications:4
INTEL_LICENSE_FILE=1713@license4
MKLPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
IPPROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp
SHELL=/bin/bash
HISTSIZE=1000
I_MPI_FABRICS=shm:ofa
QT_XFT=true
TMPDIR=/scratch/1114577.eadm
PBS_JOBNAME=IVY_stempel_bench
LIKWID_FORCE=1
FASTTMP=/elxfs/iwia/iwia84
LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
PBS_ENVIRONMENT=PBS_BATCH
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
LESS_TERMCAP_ue=[0m
PBS_O_WORKDIR=/home/hpc/iwia/iwia84/INSPECT
GROUP=iwia
PBS_TASKNUM=1
USER=iwia84
LS_COLORS=
LD_LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:/apps/likwid/4.3.4/lib
GDK_USE_XFT=1
PBS_O_HOME=/home/hpc/iwia/iwia84
PSTLROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
MKL_LIB=-Wl,--start-group /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_sequential.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
FI_PROVIDER_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib/prov
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_WALLTIME=86400
FPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
PBS_GPUFILE=/var/spool/torque/aux//1114577.eadmgpu
PBS_MOMPORT=15003
MKL_BASE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
LIKWID_INC=-I/apps/likwid/4.3.4/include
LESS_TERMCAP_us=[1;32m
PBS_O_QUEUE=route
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
MAIL=/var/spool/mail/iwia84
PBS_O_LOGNAME=iwia84
PATH=/apps/python/3.5-anaconda/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:/apps/likwid/4.3.4/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin:/usr/local/sbin:/usr/sbin
I_MPI_OFA_ADAPTER_NAME=mlx4_0
PBS_O_LANG=en_US.UTF-8
LIKWID_INCDIR=/apps/likwid/4.3.4/include
WORK=/home/woody/iwia/iwia84
PBS_JOBCOOKIE=8A7297392C5FEE5CD40A123D1B251E66
TBBROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r2_homogeneous_box_variable/IvyBridgeEP_E5-2660v2_20190523_145949
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
_LMFILES_=/apps/modules/data/tools/likwid/4.3.4:/apps/modules/data/development/intelmpi/2019up02-intel:/apps/modules/data/libraries/mkl/2019up02:/apps/modules/data/development/intel64/19.0up02:/apps/modules/data/tools/python/3.5-anaconda
EDITOR=/usr/bin/vim
PBS_NODENUM=0
LANG=C.UTF-8
MODULEPATH=/apps/modules/data/applications:/apps/modules/data/development:/apps/modules/data/libraries:/apps/modules/data/tools:/apps/modules/data/via-spack:/apps/modules/data/deprecated:/apps/modules/data/testing
MPIINCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
INTEL_LICENSE_FILE_modshare=1713@license4:1
PBS_NUM_NODES=1
LOADEDMODULES=likwid/4.3.4:intelmpi/2019up02-intel:mkl/2019up02:intel64/19.0up02:python/3.5-anaconda
INTEL_F_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
GCC_COLORS=error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01
PBS_O_SHELL=/bin/bash
MKL_CDFT=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_cdft_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
MKL_SCALAPACK=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_scalapack_lp64.a -Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
CPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
MPIROOTDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
I_MPI_HARD_FINALIZE=1
PBS_JOBID=1114577.eadm
DAALROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal
HISTCONTROL=ignoredups
ENVIRONMENT=BATCH
INTEL_PYTHONHOME=/apps/intel/ComposerXE2019/debugger_2019/python/intel64/
SHLVL=3
HOME=/home/hpc/iwia/iwia84
MKL_INC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PATH_modshare=/home/julian/.local/.bin:1:/usr/bin/vendor_perl:1:/opt/android-sdk/tools:1:/usr/bin:1:/apps/python/3.5-anaconda/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/bin/core_perl:1:/opt/android-sdk/platform-tools:1:/usr/local/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/home/julian/.bin:1:/usr/sbin:1:/apps/likwid/4.3.4/bin:1:/opt/intel/bin:1:/usr/local/sbin:1
PBS_O_HOST=emmy2.rrze.uni-erlangen.de
LIKWID_LIB=-L/apps/likwid/4.3.4/lib
WOODYHOME=/home/woody/iwia/iwia84
HPCVAULT=/home/vault/iwia/iwia84
MANPATH_modshare=/apps/python/3.5-anaconda/share/man:1::1:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:1:/apps/intel/ComposerXE2019/man/common:2:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:2:/apps/intel/mpi/man:1:/apps/likwid/4.3.4/man:1
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
PBS_VNODENUM=0
BASH_ENV=/etc/profile
MKL_INCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NLSPATH_modshare=/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:1
LESS=-R
LOGNAME=iwia84
PYTHONPATH=/home/hpc/iwia/iwia84/kerncraft/kerncraft-ivy//lib/python3.5/site-packages/
CVS_RSH=ssh
LD_LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/likwid/4.3.4/lib:1:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
LESS_TERMCAP_so=[1;44;1m
PBS_QUEUE=work
CLASSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar
MKL_SLIB_THREADED=-Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -lpthread -lm -openmp
MODULESHOME=/apps/modules
LESSOPEN=||/usr/bin/lesspipe.sh %s
PBS_MICFILE=/var/spool/torque/aux//1114577.eadmmic
PBS_O_SUBMIT_FILTER=/usr/local/sbin/torque_submitfilter
PBS_O_MAIL=/var/spool/mail/iwia84
OMP_NUM_THREADS=1
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
LOADEDMODULES_modshare=intel64/19.0up02:1:python/3.5-anaconda:1:intelmpi/2019up02-intel:1:mkl/2019up02:1:likwid/4.3.4:1
INFOPATH=/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/info/
INFOPATH_modshare=/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/info/:1
PBS_NP=40
PBS_NUM_PPN=40
PBS_O_SERVER=eadm
INCLUDE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
INTEL_C_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LIKWID_LIBDIR=/apps/likwid/4.3.4/lib
I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=off
SCRATCH=/scratch
PBS_NODEFILE=/var/spool/torque/aux//1114577.eadm
LESS_TERMCAP_se=[0m
PBS_O_PATH=/apps/git/2.2.1/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
MKL_SHLIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm
I_MPI_ROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi
_=/usr/bin/env
{%- endcapture -%}

{% include stencil_template.md %}
