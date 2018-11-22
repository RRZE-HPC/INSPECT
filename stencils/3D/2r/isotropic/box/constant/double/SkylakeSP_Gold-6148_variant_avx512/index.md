---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_avx512"
flavor       : "AVX 512"
comment      : "Inorder to convince the compiler to generate AVX512 code, the flag` -qopt-zmm-usage=high` has to be used."
compile_flags: "icc -O3 -xCORE-AVX512 -qopt-zmm-usage=high -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vpcmpgtd k1, ymm27, ymm26
vpaddd ymm26, ymm26, ymm29
mov rdi, qword ptr [rsp+0x370]
mov rsi, qword ptr [rsp+0x3b0]
mov rdx, qword ptr [rsp+0x3a0]
vmovupd zmm28{k1}{z}, zmmword ptr [r8+rdi*1+0x10]
vmovupd zmm11{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm16{k1}{z}, zmmword ptr [r8+rsi*1]
vmovupd zmm7{k1}{z}, zmmword ptr [r8+rdx*1]
vaddpd zmm11, zmm16, zmm11
vmovupd zmm16{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
mov rdi, qword ptr [rsp+0x3b8]
mov rcx, qword ptr [rsp+0x3c0]
mov r13, qword ptr [rsp+0x3d8]
vmovupd zmm5{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm15{k1}{z}, zmmword ptr [r8+rcx*1]
vmovupd zmm21{k1}{z}, zmmword ptr [r8+r13*1]
vaddpd zmm7, zmm7, zmm15
vmovupd zmm15{k1}{z}, zmmword ptr [r8+rcx*1+0x8]
mov rdi, qword ptr [rsp+0x3d0]
mov r15, qword ptr [rsp+0x3a8]
mov rbx, qword ptr [rsp+0x388]
vmovupd zmm4{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm8{k1}{z}, zmmword ptr [r8+r15*1]
vmovupd zmm30{k1}{z}, zmmword ptr [r8+rbx*1]
vmovupd zmm23{k1}{z}, zmmword ptr [r8+rbx*1+0x8]
vaddpd zmm5, zmm5, zmm4
vaddpd zmm8, zmm21, zmm8
vaddpd zmm30, zmm28, zmm30
vaddpd zmm11, zmm11, zmm5
vaddpd zmm7, zmm7, zmm8
vmovupd zmm8{k1}{z}, zmmword ptr [r8+r15*1+0x8]
vmovupd zmm21{k1}{z}, zmmword ptr [r8+r13*1+0x8]
vaddpd zmm7, zmm7, zmm11
vaddpd zmm16, zmm8, zmm16
vaddpd zmm21, zmm15, zmm21
vmovupd zmm8{k1}{z}, zmmword ptr [r8+r15*1+0x10]
nop dword ptr [rax], eax
vmovupd zmm15{k1}{z}, zmmword ptr [r8+rcx*1+0x10]
mov rdi, qword ptr [rsp+0x3e8]
mov r12, qword ptr [rsp+0x378]
mov r11, qword ptr [rsp+0x380]
vmovupd zmm13{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm10{k1}{z}, zmmword ptr [r8+r12*1]
vmovupd zmm2{k1}{z}, zmmword ptr [r8+r11*1]
vmovupd zmm28{k1}{z}, zmmword ptr [r8+r12*1+0x8]
vaddpd zmm10, zmm10, zmm2
vaddpd zmm28, zmm23, zmm28
vmovupd zmm2{k1}{z}, zmmword ptr [r8+r11*1+0x8]
vaddpd zmm10, zmm30, zmm10
mov rdi, qword ptr [rsp+0x3f8]
mov r10, qword ptr [rsp+0x3c8]
mov r14, qword ptr [rsp+0x3e0]
vmovupd zmm22{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm3{k1}{z}, zmmword ptr [r8+r10*1]
vmovupd zmm20{k1}{z}, zmmword ptr [r8+r14*1]
vmovupd zmm30{k1}{z}, zmmword ptr [r8+r10*1+0x8]
vaddpd zmm13, zmm13, zmm22
vaddpd zmm3, zmm3, zmm20
vaddpd zmm2, zmm2, zmm30
vmovupd zmm20{k1}{z}, zmmword ptr [r8+r14*1+0x8]
vmovupd zmm30{k1}{z}, zmmword ptr [r8+r12*1+0x10]
mov r9, qword ptr [rsp+0x390]
mov rax, qword ptr [rsp+0x398]
mov rdi, qword ptr [rsp+0x400]
vmovupd zmm31{k1}{z}, zmmword ptr [r8+r9*1]
vmovupd zmm24{k1}{z}, zmmword ptr [r8+rax*1]
vmovupd zmm12{k1}{z}, zmmword ptr [r8+rdi*1]
vaddpd zmm24, zmm31, zmm24
vmovupd zmm31{k1}{z}, zmmword ptr [r8+r9*1+0x8]
vaddpd zmm24, zmm3, zmm24
vmovupd zmm3{k1}{z}, zmmword ptr [r8+rax*1+0x8]
vaddpd zmm24, zmm10, zmm24
vaddpd zmm20, zmm20, zmm31
data16 nop
vmovupd zmm10{k1}{z}, zmmword ptr [r8+rdx*1+0x8]
vmovupd zmm31{k1}{z}, zmmword ptr [r8+r11*1+0x10]
vaddpd zmm7, zmm24, zmm7
vaddpd zmm2, zmm2, zmm20
vaddpd zmm3, zmm3, zmm10
vaddpd zmm30, zmm30, zmm31
vmovupd zmm10{k1}{z}, zmmword ptr [r8+rdx*1+0x10]
vmovupd zmm20{k1}{z}, zmmword ptr [r8+r10*1+0x10]
vmovupd zmm31{k1}{z}, zmmword ptr [r8+r12*1+0x18]
vaddpd zmm21, zmm3, zmm21
vaddpd zmm15, zmm10, zmm15
nop
vmovupd zmm3{k1}{z}, zmmword ptr [r8+r13*1+0x10]
nop dword ptr [rax], eax
vmovupd zmm10{k1}{z}, zmmword ptr [r8+rax*1+0x18]
vaddpd zmm8, zmm3, zmm8
vmovupd zmm3{k1}{z}, zmmword ptr [r8+rcx*1+0x18]
mov rdi, qword ptr [rsp+0x408]
mov rsi, qword ptr [rsp+0x370]
mov r15, qword ptr [rsp+0x3b0]
vmovupd zmm9{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm4{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
vaddpd zmm9, zmm12, zmm9
mov rdi, qword ptr [rsp+0x410]
mov rsi, qword ptr [rsp+0x3b8]
vaddpd zmm9, zmm13, zmm9
vmovupd zmm14{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm5{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
mov rdi, qword ptr [rsp+0x418]
mov rsi, qword ptr [rsp+0x3d0]
vaddpd zmm4, zmm4, zmm5
vmovupd zmm6{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm11{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
nop dword ptr [rax], eax
vmovupd zmm5{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm6, zmm14, zmm6
vaddpd zmm16, zmm16, zmm4
mov rdi, qword ptr [rsp+0x428]
mov rsi, qword ptr [rsp+0x3e8]
mov r15, qword ptr [rsp+0x3b8]
data16 nop
vmovupd zmm18{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm24{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
nop dword ptr [rax], eax
vmovupd zmm4{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm21, zmm21, zmm16
vaddpd zmm11, zmm11, zmm24
vaddpd zmm4, zmm5, zmm4
vmovupd zmm5{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vaddpd zmm4, zmm8, zmm4
data16 nop
mov rdi, qword ptr [rsp+0x438]
mov rsi, qword ptr [rsp+0x3f8]
mov r13, qword ptr [rsp+0x3a8]
vmovupd zmm17{k1}{z}, zmmword ptr [r8+rdi*1]
nop dword ptr [rax], eax
vmovupd zmm22{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
vmovupd zmm8{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vaddpd zmm18, zmm18, zmm17
vaddpd zmm8, zmm5, zmm8
vaddpd zmm18, zmm6, zmm18
nop dword ptr [rax], eax
vmovupd zmm5{k1}{z}, zmmword ptr [r8+rcx*1+0x20]
vaddpd zmm9, zmm9, zmm18
mov rdi, qword ptr [rsp+0x450]
mov rsi, qword ptr [rsp+0x400]
mov r15, qword ptr [rsp+0x3d0]
nop dword ptr [rax], eax
vmovupd zmm19{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm12{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
nop dword ptr [rax], eax
vmovupd zmm16{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm12, zmm22, zmm12
mov rdi, qword ptr [rsp+0x360]
mov rsi, qword ptr [rsp+0x408]
mov r13, qword ptr [rsp+0x3b0]
nop dword ptr [rax], eax
vmovupd zmm1{k1}{z}, zmmword ptr [r8+rdi*1]
vmovupd zmm13{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
vmovupd zmm23{k1}{z}, zmmword ptr [r8+rdi*1+0x8]
vaddpd zmm19, zmm19, zmm1
vaddpd zmm12, zmm11, zmm12
vaddpd zmm28, zmm19, zmm28
vmovupd zmm19{k1}{z}, zmmword ptr [r8+rbx*1+0x10]
vaddpd zmm2, zmm28, zmm2
nop
vmovupd zmm28{k1}{z}, zmmword ptr [r8+r14*1+0x10]
vaddpd zmm9, zmm9, zmm2
vaddpd zmm19, zmm23, zmm19
vaddpd zmm20, zmm20, zmm28
vaddpd zmm7, zmm7, zmm9
vmovupd zmm2{k1}{z}, zmmword ptr [r8+r9*1+0x10]
vmovupd zmm9{k1}{z}, zmmword ptr [r8+rax*1+0x10]
vmovupd zmm23{k1}{z}, zmmword ptr [r8+rdi*1+0x10]
vmovupd zmm28{k1}{z}, zmmword ptr [r8+r11*1+0x18]
vaddpd zmm9, zmm2, zmm9
vaddpd zmm30, zmm30, zmm20
vaddpd zmm28, zmm31, zmm28
vaddpd zmm9, zmm9, zmm15
vmovupd zmm20{k1}{z}, zmmword ptr [r8+r10*1+0x18]
nop
vmovupd zmm2{k1}{z}, zmmword ptr [r8+r9*1+0x18]
data16 nop
vmovupd zmm15{k1}{z}, zmmword ptr [r8+rdx*1+0x18]
vmovupd zmm31{k1}{z}, zmmword ptr [r8+rbx*1+0x20]
vaddpd zmm9, zmm9, zmm4
vaddpd zmm2, zmm2, zmm10
vaddpd zmm15, zmm15, zmm3
vmovupd zmm4{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vmovupd zmm3{k1}{z}, zmmword ptr [r8+rax*1+0x20]
vmovupd zmm10{k1}{z}, zmmword ptr [r8+r9*1+0x20]
vaddpd zmm2, zmm2, zmm15
nop dword ptr [rax], eax
vmovupd zmm15{k1}{z}, zmmword ptr [r8+rdx*1+0x20]
mov rsi, qword ptr [rsp+0x410]
data16 nop
mov r15, qword ptr [rsp+0x3e8]
nop
mov r13, qword ptr [rsp+0x370]
vmovupd zmm14{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
vmovupd zmm24{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm3, zmm3, zmm15
vaddpd zmm14, zmm13, zmm14
vaddpd zmm24, zmm16, zmm24
mov rsi, qword ptr [rsp+0x418]
data16 nop
mov r15, qword ptr [rsp+0x3f8]
mov rax, qword ptr [rsp+0x3d8]
vmovupd zmm17{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
data16 nop
vmovupd zmm22{k1}{z}, zmmword ptr [r8+r15*1+0x10]
mov rsi, qword ptr [rsp+0x428]
mov r15, qword ptr [rsp+0x400]
mov rdx, qword ptr [rsp+0x3a8]
nop dword ptr [rax], eax
vmovupd zmm6{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
vmovupd zmm11{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm6, zmm17, zmm6
vaddpd zmm22, zmm22, zmm11
vaddpd zmm6, zmm14, zmm6
vaddpd zmm24, zmm24, zmm22
vaddpd zmm6, zmm12, zmm6
mov rsi, qword ptr [rsp+0x438]
vaddpd zmm6, zmm21, zmm6
vmovupd zmm18{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
mov rsi, qword ptr [rsp+0x450]
nop
mov r15, qword ptr [rsp+0x408]
mov rcx, qword ptr [rsp+0x3b0]
vmovupd zmm1{k1}{z}, zmmword ptr [r8+rsi*1+0x8]
nop
vmovupd zmm13{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm18, zmm18, zmm1
vmovupd zmm1{k1}{z}, zmmword ptr [r8+rsi*1+0x10]
vaddpd zmm19, zmm18, zmm19
vmovupd zmm18{k1}{z}, zmmword ptr [r8+rbx*1+0x18]
vaddpd zmm30, zmm19, zmm30
nop
vmovupd zmm19{k1}{z}, zmmword ptr [r8+r14*1+0x18]
vaddpd zmm9, zmm30, zmm9
vaddpd zmm23, zmm23, zmm18
vaddpd zmm20, zmm20, zmm19
vaddpd zmm9, zmm6, zmm9
nop
vmovupd zmm30{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vmovupd zmm18{k1}{z}, zmmword ptr [r8+rsi*1+0x18]
vmovupd zmm19{k1}{z}, zmmword ptr [r8+r12*1+0x20]
vaddpd zmm9, zmm7, zmm9
vaddpd zmm28, zmm28, zmm20
vaddpd zmm30, zmm4, zmm30
vaddpd zmm31, zmm31, zmm19
vmovupd zmm20{k1}{z}, zmmword ptr [r8+r11*1+0x20]
vmovupd zmm4{k1}{z}, zmmword ptr [r8+rax*1+0x20]
vmovupd zmm19{k1}{z}, zmmword ptr [r8+rdi*1+0x20]
vaddpd zmm8, zmm8, zmm30
vaddpd zmm4, zmm5, zmm4
vmovupd zmm30{k1}{z}, zmmword ptr [r8+rdx*1+0x20]
vaddpd zmm8, zmm2, zmm8
vmovupd zmm2{k1}{z}, zmmword ptr [r8+rcx*1+0x20]
mov r13, qword ptr [rsp+0x3b8]
mov r15, qword ptr [rsp+0x410]
mov rbx, qword ptr [rsp+0x370]
vmovupd zmm6{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vmovupd zmm17{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm2, zmm30, zmm2
vaddpd zmm13, zmm13, zmm17
vaddpd zmm5, zmm4, zmm2
nop dword ptr [rax], eax
mov r13, qword ptr [rsp+0x3d0]
mov r15, qword ptr [rsp+0x418]
mov r9, qword ptr [rsp+0x3b8]
vmovupd zmm7{k1}{z}, zmmword ptr [r8+r13*1+0x18]
nop dword ptr [rax], eax
vmovupd zmm14{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm6, zmm6, zmm7
vmovupd zmm7{k1}{z}, zmmword ptr [r8+rbx*1+0x20]
mov r13, qword ptr [rsp+0x3e8]
mov r15, qword ptr [rsp+0x428]
mov r11, r13
data16 nop
vmovupd zmm16{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vmovupd zmm12{k1}{z}, zmmword ptr [r8+r15*1+0x10]
data16 nop
mov r13, qword ptr [rsp+0x3f8]
mov r15, qword ptr [rsp+0x438]
vaddpd zmm14, zmm14, zmm12
vmovupd zmm11{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vmovupd zmm21{k1}{z}, zmmword ptr [r8+r15*1+0x10]
vaddpd zmm13, zmm13, zmm14
vaddpd zmm16, zmm16, zmm11
vaddpd zmm21, zmm21, zmm1
vaddpd zmm24, zmm24, zmm13
vaddpd zmm6, zmm6, zmm16
vaddpd zmm21, zmm21, zmm23
data16 nop
vmovupd zmm1{k1}{z}, zmmword ptr [r8+r15*1+0x18]
nop dword ptr [rax], eax
vmovupd zmm23{k1}{z}, zmmword ptr [r8+rdi*1+0x18]
vmovupd zmm11{k1}{z}, zmmword ptr [r8+r9*1+0x20]
vaddpd zmm28, zmm21, zmm28
vaddpd zmm18, zmm18, zmm23
vaddpd zmm7, zmm7, zmm11
vaddpd zmm28, zmm24, zmm28
vmovupd zmm21{k1}{z}, zmmword ptr [r8+r10*1+0x20]
vmovupd zmm24{k1}{z}, zmmword ptr [r8+r14*1+0x20]
nop dword ptr [rax], eax
vmovupd zmm23{k1}{z}, zmmword ptr [r8+r15*1+0x20]
vaddpd zmm21, zmm20, zmm21
vaddpd zmm10, zmm24, zmm10
vaddpd zmm31, zmm31, zmm21
vaddpd zmm3, zmm10, zmm3
mov r13, qword ptr [rsp+0x400]
mov r10, qword ptr [rsp+0x3d0]
mov r12, qword ptr [rsp+0x3f8]
data16 nop
vmovupd zmm22{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vmovupd zmm16{k1}{z}, zmmword ptr [r8+r10*1+0x20]
vaddpd zmm10, zmm3, zmm5
mov r13, qword ptr [rsp+0x408]
mov r14, qword ptr [rsp+0x400]
mov rax, r13
vmovupd zmm17{k1}{z}, zmmword ptr [r8+r13*1+0x18]
mov r13, qword ptr [rsp+0x410]
vaddpd zmm17, zmm22, zmm17
vmovupd zmm22{k1}{z}, zmmword ptr [r8+r11*1+0x20]
nop dword ptr [rax], eax
vmovupd zmm12{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vaddpd zmm11, zmm16, zmm22
mov r13, qword ptr [rsp+0x418]
mov rdx, qword ptr [rsp+0x410]
mov rcx, r13
vmovupd zmm14{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vaddpd zmm12, zmm12, zmm14
nop dword ptr [rax], eax
vmovupd zmm14{k1}{z}, zmmword ptr [r8+r12*1+0x20]
vaddpd zmm17, zmm17, zmm12
vmovupd zmm12{k1}{z}, zmmword ptr [r8+r14*1+0x20]
vaddpd zmm17, zmm6, zmm17
vmovupd zmm6{k1}{z}, zmmword ptr [r8+rax*1+0x20]
vaddpd zmm17, zmm8, zmm17
vaddpd zmm12, zmm14, zmm12
nop dword ptr [rax], eax
vmovupd zmm8{k1}{z}, zmmword ptr [r8+rdx*1+0x20]
vaddpd zmm17, zmm28, zmm17
nop dword ptr [rax], eax
vmovupd zmm28{k1}{z}, zmmword ptr [r8+rcx*1+0x20]
vaddpd zmm6, zmm6, zmm8
nop dword ptr [rax], eax
mov r13, qword ptr [rsp+0x428]
vaddpd zmm8, zmm12, zmm6
vmovupd zmm13{k1}{z}, zmmword ptr [r8+r13*1+0x18]
vaddpd zmm13, zmm13, zmm1
vmovupd zmm1{k1}{z}, zmmword ptr [r8+r13*1+0x20]
vaddpd zmm13, zmm13, zmm18
nop dword ptr [rax], eax
vmovupd zmm18{k1}{z}, zmmword ptr [r8+rsi*1+0x20]
vaddpd zmm13, zmm13, zmm31
vaddpd zmm1, zmm28, zmm1
vaddpd zmm18, zmm23, zmm18
vaddpd zmm2, zmm13, zmm10
vaddpd zmm13, zmm7, zmm11
vaddpd zmm1, zmm1, zmm18
vaddpd zmm14, zmm13, zmm8
vaddpd zmm3, zmm1, zmm19
vaddpd zmm4, zmm14, zmm3
vaddpd zmm2, zmm2, zmm4
vaddpd zmm5, zmm17, zmm2
vaddpd zmm6, zmm9, zmm5
vmulpd zmm7, zmm0, zmm6
nop
mov rbx, qword ptr [rsp+0x368]
mov rsi, qword ptr [rsp+0x3f0]
add rsi, 0x8
vmovupd zmmword ptr [r8+rbx*1+0x10]{k1}, zmm7
add r8, 0x40
mov qword ptr [rsp+0x3f0], rsi
cmp rsi, qword ptr [rsp+0x470]
jb 0xfffffffffffff540
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

