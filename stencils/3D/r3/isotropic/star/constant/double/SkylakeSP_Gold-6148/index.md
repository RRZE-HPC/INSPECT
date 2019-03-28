---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r3"
weighting    : "isotropic"
kind         : "star"
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
vpcmpgtd k1, xmm3, xmm1
add r13, 0x4
vpaddd xmm1, xmm1, xmm2
vmovupd ymm8{k1}{z}, ymmword ptr [r8+rdx*1+0x10]
vmovupd ymm9{k1}{z}, ymmword ptr [r8+rdx*1+0x20]
vmovupd ymm11{k1}{z}, ymmword ptr [r8+rax*1+0x18]
vmovupd ymm13{k1}{z}, ymmword ptr [r8+r14*1+0x18]
vmovupd ymm15{k1}{z}, ymmword ptr [r8+r9*1+0x18]
vmovupd ymm17{k1}{z}, ymmword ptr [r8+r10*1+0x18]
vmovupd ymm19{k1}{z}, ymmword ptr [r8+rdx*1+0x18]
vmovupd ymm20{k1}{z}, ymmword ptr [r8+rdx*1+0x8]
vmovupd ymm21{k1}{z}, ymmword ptr [r8+rdx*1+0x28]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+rdi*1+0x18]
vmovupd ymm31{k1}{z}, ymmword ptr [r8+rdx*1]
vmovupd ymm27{k1}{z}, ymmword ptr [r8+rsi*1+0x18]
vmovupd ymm29{k1}{z}, ymmword ptr [r8+r11*1+0x18]
vaddpd ymm10, ymm8, ymm9
vaddpd ymm22, ymm20, ymm21
vmovupd ymm21{k1}{z}, ymmword ptr [r8+rbx*1+0x18]
vaddpd ymm12, ymm10, ymm11
vaddpd ymm24, ymm22, ymm23
vmovupd ymm23{k1}{z}, ymmword ptr [r8+r12*1+0x18]
vaddpd ymm14, ymm12, ymm13
vaddpd ymm16, ymm14, ymm15
vaddpd ymm18, ymm16, ymm17
vmulpd ymm8, ymm5, ymm18
mov r15, qword ptr [rsp+0x2a8]
vfmadd231pd ymm8, ymm19, ymm6
vmovupd ymm19{k1}{z}, ymmword ptr [r8+rdx*1+0x30]
vmovupd ymm25{k1}{z}, ymmword ptr [r8+r15*1+0x18]
vaddpd ymm20, ymm31, ymm19
vaddpd ymm26, ymm24, ymm25
vmovupd ymm25{k1}{z}, ymmword ptr [r8+rcx*1+0x18]
vaddpd ymm22, ymm20, ymm21
vaddpd ymm28, ymm26, ymm27
vaddpd ymm24, ymm22, ymm23
vaddpd ymm30, ymm28, ymm29
vaddpd ymm26, ymm24, ymm25
vfmadd231pd ymm8, ymm30, ymm4
mov r15, qword ptr [rsp+0x278]
vmovupd ymm27{k1}{z}, ymmword ptr [r8+r15*1+0x18]
vaddpd ymm28, ymm26, ymm27
vfmadd231pd ymm8, ymm28, ymm0
mov r15, qword ptr [rsp+0x288]
vmovupd ymmword ptr [r8+r15*1+0x18]{k1}, ymm8
add r8, 0x20
nop
cmp r13, qword ptr [rsp+0x2b0]
jb 0xfffffffffffffe89
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;292
L2: P <= 65536/7;9362
L3: P <= 262144
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;32²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 1048576;128²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 29360128;677²
{%- endcapture -%}

{% include stencil_template.md %}

