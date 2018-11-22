---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
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
vpcmpgtd k1, xmm27, xmm26
vpaddd xmm26, xmm26, xmm29
mov rdi, qword ptr [rsp+0x2b8]
mov rsi, qword ptr [rsp+0x2f8]
mov rdx, qword ptr [rsp+0x2e8]
vmovupd ymm28{k1}{z}, ymmword ptr [r8+rdi*1+0x10]
vmovupd ymm11{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm16{k1}{z}, ymmword ptr [r8+rsi*1]
vmovupd ymm7{k1}{z}, ymmword ptr [r8+rdx*1]
vaddpd ymm11, ymm16, ymm11
vmovupd ymm16{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
mov rdi, qword ptr [rsp+0x300]
mov rcx, qword ptr [rsp+0x308]
mov r13, qword ptr [rsp+0x320]
vmovupd ymm5{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm15{k1}{z}, ymmword ptr [r8+rcx*1]
vmovupd ymm21{k1}{z}, ymmword ptr [r8+r13*1]
vaddpd ymm7, ymm7, ymm15
vmovupd ymm15{k1}{z}, ymmword ptr [r8+rcx*1+0x8]
mov rdi, qword ptr [rsp+0x318]
mov r15, qword ptr [rsp+0x2f0]
mov rbx, qword ptr [rsp+0x2d0]
vmovupd ymm4{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm8{k1}{z}, ymmword ptr [r8+r15*1]
vmovupd ymm30{k1}{z}, ymmword ptr [r8+rbx*1]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+rbx*1+0x8]
vaddpd ymm5, ymm5, ymm4
vaddpd ymm8, ymm21, ymm8
vaddpd ymm30, ymm28, ymm30
vaddpd ymm11, ymm11, ymm5
vaddpd ymm7, ymm7, ymm8
vmovupd ymm8{k1}{z}, ymmword ptr [r8+r15*1+0x8]
vmovupd ymm21{k1}{z}, ymmword ptr [r8+r13*1+0x8]
vaddpd ymm7, ymm7, ymm11
vaddpd ymm16, ymm8, ymm16
vaddpd ymm21, ymm15, ymm21
vmovupd ymm8{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vmovupd ymm15{k1}{z}, ymmword ptr [r8+rcx*1+0x10]
mov rdi, qword ptr [rsp+0x330]
mov r12, qword ptr [rsp+0x2c0]
mov r11, qword ptr [rsp+0x2c8]
vmovupd ymm13{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm10{k1}{z}, ymmword ptr [r8+r12*1]
vmovupd ymm2{k1}{z}, ymmword ptr [r8+r11*1]
vmovupd ymm28{k1}{z}, ymmword ptr [r8+r12*1+0x8]
vaddpd ymm10, ymm10, ymm2
vaddpd ymm28, ymm23, ymm28
vmovupd ymm2{k1}{z}, ymmword ptr [r8+r11*1+0x8]
vaddpd ymm10, ymm30, ymm10
mov rdi, qword ptr [rsp+0x340]
mov r10, qword ptr [rsp+0x310]
mov r14, qword ptr [rsp+0x328]
vmovupd ymm22{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm3{k1}{z}, ymmword ptr [r8+r10*1]
vmovupd ymm20{k1}{z}, ymmword ptr [r8+r14*1]
vmovupd ymm30{k1}{z}, ymmword ptr [r8+r10*1+0x8]
vaddpd ymm13, ymm13, ymm22
vaddpd ymm3, ymm3, ymm20
vaddpd ymm2, ymm2, ymm30
vmovupd ymm20{k1}{z}, ymmword ptr [r8+r14*1+0x8]
vmovupd ymm30{k1}{z}, ymmword ptr [r8+r12*1+0x10]
mov r9, qword ptr [rsp+0x2d8]
mov rax, qword ptr [rsp+0x2e0]
mov rdi, qword ptr [rsp+0x348]
vmovupd ymm31{k1}{z}, ymmword ptr [r8+r9*1]
vmovupd ymm24{k1}{z}, ymmword ptr [r8+rax*1]
vmovupd ymm12{k1}{z}, ymmword ptr [r8+rdi*1]
vaddpd ymm24, ymm31, ymm24
vmovupd ymm31{k1}{z}, ymmword ptr [r8+r9*1+0x8]
vaddpd ymm24, ymm3, ymm24
vmovupd ymm3{k1}{z}, ymmword ptr [r8+rax*1+0x8]
vaddpd ymm24, ymm10, ymm24
vaddpd ymm20, ymm20, ymm31
vmovupd ymm10{k1}{z}, ymmword ptr [r8+rdx*1+0x8]
vmovupd ymm31{k1}{z}, ymmword ptr [r8+r11*1+0x10]
vaddpd ymm7, ymm24, ymm7
vaddpd ymm2, ymm2, ymm20
vaddpd ymm3, ymm3, ymm10
vaddpd ymm30, ymm30, ymm31
vmovupd ymm10{k1}{z}, ymmword ptr [r8+rdx*1+0x10]
vmovupd ymm20{k1}{z}, ymmword ptr [r8+r10*1+0x10]
vmovupd ymm31{k1}{z}, ymmword ptr [r8+r12*1+0x18]
vaddpd ymm21, ymm3, ymm21
vaddpd ymm15, ymm10, ymm15
vmovupd ymm3{k1}{z}, ymmword ptr [r8+r13*1+0x10]
vmovupd ymm10{k1}{z}, ymmword ptr [r8+rax*1+0x18]
vaddpd ymm8, ymm3, ymm8
vmovupd ymm3{k1}{z}, ymmword ptr [r8+rcx*1+0x18]
mov rdi, qword ptr [rsp+0x350]
mov rsi, qword ptr [rsp+0x2b8]
mov r15, qword ptr [rsp+0x2f8]
vmovupd ymm9{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm4{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vaddpd ymm9, ymm12, ymm9
mov rdi, qword ptr [rsp+0x358]
mov rsi, qword ptr [rsp+0x300]
vaddpd ymm9, ymm13, ymm9
vmovupd ymm14{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm5{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
mov rdi, qword ptr [rsp+0x360]
mov rsi, qword ptr [rsp+0x318]
vaddpd ymm4, ymm4, ymm5
vmovupd ymm6{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm11{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm5{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm6, ymm14, ymm6
vaddpd ymm16, ymm16, ymm4
mov rdi, qword ptr [rsp+0x370]
mov rsi, qword ptr [rsp+0x330]
mov r15, qword ptr [rsp+0x300]
vmovupd ymm18{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm24{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm4{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm21, ymm21, ymm16
vaddpd ymm11, ymm11, ymm24
vaddpd ymm4, ymm5, ymm4
vmovupd ymm5{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vaddpd ymm4, ymm8, ymm4
mov rdi, qword ptr [rsp+0x380]
mov rsi, qword ptr [rsp+0x340]
mov r13, qword ptr [rsp+0x2f0]
vmovupd ymm17{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm22{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vaddpd ymm18, ymm18, ymm17
vaddpd ymm8, ymm5, ymm8
vaddpd ymm18, ymm6, ymm18
vmovupd ymm5{k1}{z}, ymmword ptr [r8+rcx*1+0x20]
vaddpd ymm9, ymm9, ymm18
mov rdi, qword ptr [rsp+0x398]
mov rsi, qword ptr [rsp+0x348]
mov r15, qword ptr [rsp+0x318]
vmovupd ymm19{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm12{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm16{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm12, ymm22, ymm12
mov rdi, qword ptr [rsp+0x2a8]
mov rsi, qword ptr [rsp+0x350]
mov r13, qword ptr [rsp+0x2f8]
vmovupd ymm1{k1}{z}, ymmword ptr [r8+rdi*1]
vmovupd ymm13{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+rdi*1+0x8]
vaddpd ymm19, ymm19, ymm1
vaddpd ymm12, ymm11, ymm12
vaddpd ymm28, ymm19, ymm28
vmovupd ymm19{k1}{z}, ymmword ptr [r8+rbx*1+0x10]
vaddpd ymm2, ymm28, ymm2
vmovupd ymm28{k1}{z}, ymmword ptr [r8+r14*1+0x10]
vaddpd ymm9, ymm9, ymm2
vaddpd ymm19, ymm23, ymm19
vaddpd ymm20, ymm20, ymm28
vaddpd ymm7, ymm7, ymm9
vmovupd ymm2{k1}{z}, ymmword ptr [r8+r9*1+0x10]
vmovupd ymm9{k1}{z}, ymmword ptr [r8+rax*1+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+rdi*1+0x10]
vmovupd ymm28{k1}{z}, ymmword ptr [r8+r11*1+0x18]
vaddpd ymm9, ymm2, ymm9
vaddpd ymm30, ymm30, ymm20
vaddpd ymm28, ymm31, ymm28
vaddpd ymm9, ymm9, ymm15
vmovupd ymm20{k1}{z}, ymmword ptr [r8+r10*1+0x18]
vmovupd ymm2{k1}{z}, ymmword ptr [r8+r9*1+0x18]
vmovupd ymm15{k1}{z}, ymmword ptr [r8+rdx*1+0x18]
vmovupd ymm31{k1}{z}, ymmword ptr [r8+rbx*1+0x20]
vaddpd ymm9, ymm9, ymm4
vaddpd ymm2, ymm2, ymm10
vaddpd ymm15, ymm15, ymm3
vmovupd ymm4{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm3{k1}{z}, ymmword ptr [r8+rax*1+0x20]
vmovupd ymm10{k1}{z}, ymmword ptr [r8+r9*1+0x20]
vaddpd ymm2, ymm2, ymm15
vmovupd ymm15{k1}{z}, ymmword ptr [r8+rdx*1+0x20]
mov rsi, qword ptr [rsp+0x358]
mov r15, qword ptr [rsp+0x330]
mov r13, qword ptr [rsp+0x2b8]
vmovupd ymm14{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm24{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm3, ymm3, ymm15
vaddpd ymm14, ymm13, ymm14
vaddpd ymm24, ymm16, ymm24
mov rsi, qword ptr [rsp+0x360]
mov r15, qword ptr [rsp+0x340]
mov rax, qword ptr [rsp+0x320]
vmovupd ymm17{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm22{k1}{z}, ymmword ptr [r8+r15*1+0x10]
mov rsi, qword ptr [rsp+0x370]
mov r15, qword ptr [rsp+0x348]
mov rdx, qword ptr [rsp+0x2f0]
vmovupd ymm6{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm11{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm6, ymm17, ymm6
vaddpd ymm22, ymm22, ymm11
vaddpd ymm6, ymm14, ymm6
vaddpd ymm24, ymm24, ymm22
vaddpd ymm6, ymm12, ymm6
mov rsi, qword ptr [rsp+0x380]
vaddpd ymm6, ymm21, ymm6
vmovupd ymm18{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
mov rsi, qword ptr [rsp+0x398]
mov r15, qword ptr [rsp+0x350]
mov rcx, qword ptr [rsp+0x2f8]
vmovupd ymm1{k1}{z}, ymmword ptr [r8+rsi*1+0x8]
vmovupd ymm13{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm18, ymm18, ymm1
vmovupd ymm1{k1}{z}, ymmword ptr [r8+rsi*1+0x10]
vaddpd ymm19, ymm18, ymm19
vmovupd ymm18{k1}{z}, ymmword ptr [r8+rbx*1+0x18]
vaddpd ymm30, ymm19, ymm30
vmovupd ymm19{k1}{z}, ymmword ptr [r8+r14*1+0x18]
vaddpd ymm9, ymm30, ymm9
vaddpd ymm23, ymm23, ymm18
vaddpd ymm20, ymm20, ymm19
vaddpd ymm9, ymm6, ymm9
vmovupd ymm30{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm18{k1}{z}, ymmword ptr [r8+rsi*1+0x18]
vmovupd ymm19{k1}{z}, ymmword ptr [r8+r12*1+0x20]
vaddpd ymm9, ymm7, ymm9
vaddpd ymm28, ymm28, ymm20
vaddpd ymm30, ymm4, ymm30
vaddpd ymm31, ymm31, ymm19
vmovupd ymm20{k1}{z}, ymmword ptr [r8+r11*1+0x20]
vmovupd ymm4{k1}{z}, ymmword ptr [r8+rax*1+0x20]
vmovupd ymm19{k1}{z}, ymmword ptr [r8+rdi*1+0x20]
vaddpd ymm8, ymm8, ymm30
vaddpd ymm4, ymm5, ymm4
vmovupd ymm30{k1}{z}, ymmword ptr [r8+rdx*1+0x20]
vaddpd ymm8, ymm2, ymm8
vmovupd ymm2{k1}{z}, ymmword ptr [r8+rcx*1+0x20]
mov r13, qword ptr [rsp+0x300]
mov r15, qword ptr [rsp+0x358]
mov rbx, qword ptr [rsp+0x2b8]
vmovupd ymm6{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm17{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm2, ymm30, ymm2
vaddpd ymm13, ymm13, ymm17
vaddpd ymm5, ymm4, ymm2
mov r13, qword ptr [rsp+0x318]
mov r15, qword ptr [rsp+0x360]
mov r9, qword ptr [rsp+0x300]
vmovupd ymm7{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm14{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm6, ymm6, ymm7
vmovupd ymm7{k1}{z}, ymmword ptr [r8+rbx*1+0x20]
mov r13, qword ptr [rsp+0x330]
mov r15, qword ptr [rsp+0x370]
mov r11, r13
vmovupd ymm16{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm12{k1}{z}, ymmword ptr [r8+r15*1+0x10]
mov r13, qword ptr [rsp+0x340]
mov r15, qword ptr [rsp+0x380]
vaddpd ymm14, ymm14, ymm12
vmovupd ymm11{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm21{k1}{z}, ymmword ptr [r8+r15*1+0x10]
vaddpd ymm13, ymm13, ymm14
vaddpd ymm16, ymm16, ymm11
vaddpd ymm21, ymm21, ymm1
vaddpd ymm24, ymm24, ymm13
vaddpd ymm6, ymm6, ymm16
vaddpd ymm21, ymm21, ymm23
vmovupd ymm1{k1}{z}, ymmword ptr [r8+r15*1+0x18]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+rdi*1+0x18]
vmovupd ymm11{k1}{z}, ymmword ptr [r8+r9*1+0x20]
vaddpd ymm28, ymm21, ymm28
vaddpd ymm18, ymm18, ymm23
vaddpd ymm7, ymm7, ymm11
vaddpd ymm28, ymm24, ymm28
vmovupd ymm21{k1}{z}, ymmword ptr [r8+r10*1+0x20]
vmovupd ymm24{k1}{z}, ymmword ptr [r8+r14*1+0x20]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+r15*1+0x20]
vaddpd ymm21, ymm20, ymm21
vaddpd ymm10, ymm24, ymm10
vaddpd ymm31, ymm31, ymm21
vaddpd ymm3, ymm10, ymm3
mov r13, qword ptr [rsp+0x348]
mov r10, qword ptr [rsp+0x318]
mov r12, qword ptr [rsp+0x340]
vmovupd ymm22{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vmovupd ymm16{k1}{z}, ymmword ptr [r8+r10*1+0x20]
vaddpd ymm10, ymm3, ymm5
mov r13, qword ptr [rsp+0x350]
mov r14, qword ptr [rsp+0x348]
mov rax, r13
vmovupd ymm17{k1}{z}, ymmword ptr [r8+r13*1+0x18]
mov r13, qword ptr [rsp+0x358]
vaddpd ymm17, ymm22, ymm17
vmovupd ymm22{k1}{z}, ymmword ptr [r8+r11*1+0x20]
vmovupd ymm12{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vaddpd ymm11, ymm16, ymm22
mov r13, qword ptr [rsp+0x360]
mov rdx, qword ptr [rsp+0x358]
mov rcx, r13
vmovupd ymm14{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vaddpd ymm12, ymm12, ymm14
vmovupd ymm14{k1}{z}, ymmword ptr [r8+r12*1+0x20]
vaddpd ymm17, ymm17, ymm12
vmovupd ymm12{k1}{z}, ymmword ptr [r8+r14*1+0x20]
vaddpd ymm17, ymm6, ymm17
vmovupd ymm6{k1}{z}, ymmword ptr [r8+rax*1+0x20]
vaddpd ymm17, ymm8, ymm17
vaddpd ymm12, ymm14, ymm12
vmovupd ymm8{k1}{z}, ymmword ptr [r8+rdx*1+0x20]
vaddpd ymm17, ymm28, ymm17
vmovupd ymm28{k1}{z}, ymmword ptr [r8+rcx*1+0x20]
vaddpd ymm6, ymm6, ymm8
mov r13, qword ptr [rsp+0x370]
vaddpd ymm8, ymm12, ymm6
vmovupd ymm13{k1}{z}, ymmword ptr [r8+r13*1+0x18]
vaddpd ymm13, ymm13, ymm1
vmovupd ymm1{k1}{z}, ymmword ptr [r8+r13*1+0x20]
vaddpd ymm13, ymm13, ymm18
vmovupd ymm18{k1}{z}, ymmword ptr [r8+rsi*1+0x20]
vaddpd ymm13, ymm13, ymm31
vaddpd ymm1, ymm28, ymm1
vaddpd ymm18, ymm23, ymm18
vaddpd ymm2, ymm13, ymm10
vaddpd ymm13, ymm7, ymm11
vaddpd ymm1, ymm1, ymm18
vaddpd ymm14, ymm13, ymm8
vaddpd ymm3, ymm1, ymm19
vaddpd ymm4, ymm14, ymm3
vaddpd ymm2, ymm2, ymm4
vaddpd ymm5, ymm17, ymm2
vaddpd ymm6, ymm9, ymm5
vmulpd ymm7, ymm0, ymm6
mov rbx, qword ptr [rsp+0x2b0]
mov rsi, qword ptr [rsp+0x338]
add rsi, 0x4
vmovupd ymmword ptr [r8+rbx*1+0x10]{k1}, ymm7
add r8, 0x20
mov qword ptr [rsp+0x338], rsi
cmp rsi, qword ptr [rsp+0x3b8]
jb 0xfffffffffffff63d
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

