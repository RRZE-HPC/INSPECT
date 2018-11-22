---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "homogeneous"
kind         : "star"
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

for(int k=2; k < M-2; k++){
  for(int j=2; j < N-2; j++){
    for(int i=2; i < P-2; i++){
      b[k][j][i] = c0 * (a[k][j][i]
        + a[k][j][i-1] + a[k][j][i+1]
        + a[k-1][j][i] + a[k+1][j][i]
        + a[k][j-1][i] + a[k][j+1][i]
        + a[k][j][i-2] + a[k][j][i+2]
        + a[k-2][j][i] + a[k+2][j][i]
        + a[k][j-2][i] + a[k][j+2][i]
        );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vpcmpgtd k1, xmm4, xmm5
add r14, 0x4
vpaddd xmm5, xmm5, xmm1
vmovupd ymm6{k1}{z}, ymmword ptr [rbx+rcx*1+0x10]
vmovupd ymm7{k1}{z}, ymmword ptr [rbx+rcx*1+0x8]
vmovupd ymm8{k1}{z}, ymmword ptr [rbx+rcx*1+0x18]
vmovupd ymm15{k1}{z}, ymmword ptr [rbx+rcx*1]
vmovupd ymm20{k1}{z}, ymmword ptr [rbx+rcx*1+0x20]
vmovupd ymm9{k1}{z}, ymmword ptr [rbx+r13*1+0x10]
vmovupd ymm12{k1}{z}, ymmword ptr [rbx+r9*1+0x10]
vmovupd ymm13{k1}{z}, ymmword ptr [rbx+r12*1+0x10]
vmovupd ymm14{k1}{z}, ymmword ptr [rbx+rsi*1+0x10]
vmovupd ymm21{k1}{z}, ymmword ptr [rbx+r11*1+0x10]
vmovupd ymm22{k1}{z}, ymmword ptr [rbx+rdx*1+0x10]
vmovupd ymm23{k1}{z}, ymmword ptr [rbx+r10*1+0x10]
vmovupd ymm27{k1}{z}, ymmword ptr [rbx+rdi*1+0x10]
vaddpd ymm10, ymm6, ymm7
vaddpd ymm11, ymm8, ymm9
vaddpd ymm16, ymm12, ymm13
vaddpd ymm17, ymm14, ymm15
vaddpd ymm24, ymm20, ymm21
vaddpd ymm25, ymm22, ymm23
vaddpd ymm18, ymm10, ymm11
vaddpd ymm19, ymm16, ymm17
vaddpd ymm26, ymm24, ymm25
vaddpd ymm28, ymm18, ymm19
vaddpd ymm29, ymm26, ymm27
vaddpd ymm30, ymm28, ymm29
vmulpd ymm31, ymm0, ymm30
vmovupd ymmword ptr [rbx+r15*1+0x10]{k1}, ymm31
add rbx, 0x20
cmp r14, r8
jb 0xffffffffffffff0d
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;409
L2: P <= 16384/5;3276
L3: P <= 1441792/5;288385
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;26²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 1048576;147²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 29360128;781²
{%- endcapture -%}

{% include stencil_template.md %}

