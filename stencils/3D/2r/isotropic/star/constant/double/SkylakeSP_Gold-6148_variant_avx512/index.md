---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "star"
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
vpcmpgtd k1, ymm3, ymm4
add r14, 0x8
vpaddd ymm4, ymm4, ymm1
vmovupd zmm5{k1}{z}, zmmword ptr [rax+r9*1+0x10]
vmovupd zmm6{k1}{z}, zmmword ptr [rax+r9*1+0x8]
vmovupd zmm7{k1}{z}, zmmword ptr [rax+r9*1+0x18]
vmovupd zmm14{k1}{z}, zmmword ptr [rax+r9*1]
vmovupd zmm19{k1}{z}, zmmword ptr [rax+r9*1+0x20]
vmovupd zmm8{k1}{z}, zmmword ptr [rax+r13*1+0x10]
vmovupd zmm11{k1}{z}, zmmword ptr [rax+r8*1+0x10]
vmovupd zmm12{k1}{z}, zmmword ptr [rax+r12*1+0x10]
vmovupd zmm13{k1}{z}, zmmword ptr [rax+rdi*1+0x10]
vmovupd zmm20{k1}{z}, zmmword ptr [rax+r11*1+0x10]
vmovupd zmm21{k1}{z}, zmmword ptr [rax+rsi*1+0x10]
vmovupd zmm22{k1}{z}, zmmword ptr [rax+r10*1+0x10]
vmovupd zmm26{k1}{z}, zmmword ptr [rax+rbx*1+0x10]
vaddpd zmm9, zmm5, zmm6
vaddpd zmm10, zmm7, zmm8
vaddpd zmm15, zmm11, zmm12
vaddpd zmm16, zmm13, zmm14
vaddpd zmm23, zmm19, zmm20
vaddpd zmm24, zmm21, zmm22
vaddpd zmm17, zmm9, zmm10
vaddpd zmm18, zmm15, zmm16
vaddpd zmm25, zmm23, zmm24
vaddpd zmm27, zmm17, zmm18
vaddpd zmm28, zmm25, zmm26
vaddpd zmm29, zmm27, zmm28
vmulpd zmm30, zmm0, zmm29
vmovupd zmmword ptr [rax+r15*1+0x10]{k1}, zmm30
add rax, 0x40
cmp r14, rdx
jb 0xffffffffffffff07
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

