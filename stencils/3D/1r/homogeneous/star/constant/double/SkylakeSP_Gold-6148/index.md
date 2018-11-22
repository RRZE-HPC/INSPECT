---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
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

for(int k=1; k < M-1; k++){
  for(int j=1; j < N-1; j++){
    for(int i=1; i < P-1; i++){
      b[k][j][i] = c0 * (a[k][j][i]
        + a[k][j][i-1] + a[k][j][i+1]
        + a[k-1][j][i] + a[k+1][j][i]
        + a[k][j-1][i] + a[k][j+1][i]
        );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmovupd ymm2, ymmword ptr [rsi+rdi*8+0x8]
vmovupd ymm3, ymmword ptr [rsi+rdi*8+0x10]
vmovupd ymm6, ymmword ptr [r10+rdi*8+0x8]
vmovupd ymm16, ymmword ptr [r10+rdi*8+0x28]
vmovupd ymm26, ymmword ptr [r10+rdi*8+0x48]
vmovupd ymm12, ymmword ptr [rsi+rdi*8+0x28]
vmovupd ymm13, ymmword ptr [rsi+rdi*8+0x30]
vmovupd ymm22, ymmword ptr [rsi+rdi*8+0x48]
vmovupd ymm23, ymmword ptr [rsi+rdi*8+0x50]
vaddpd ymm4, ymm2, ymmword ptr [rsi+rdi*8]
vaddpd ymm5, ymm3, ymmword ptr [r9+rdi*8+0x8]
vaddpd ymm7, ymm6, ymmword ptr [r14+rdi*8+0x8]
vaddpd ymm17, ymm16, ymmword ptr [r14+rdi*8+0x28]
vaddpd ymm8, ymm4, ymm5
vaddpd ymm9, ymm7, ymmword ptr [rcx+rdi*8+0x8]
vaddpd ymm14, ymm12, ymmword ptr [rsi+rdi*8+0x20]
vaddpd ymm24, ymm22, ymmword ptr [rsi+rdi*8+0x40]
vaddpd ymm15, ymm13, ymmword ptr [r9+rdi*8+0x28]
vaddpd ymm25, ymm23, ymmword ptr [r9+rdi*8+0x48]
vaddpd ymm27, ymm26, ymmword ptr [r14+rdi*8+0x48]
vaddpd ymm10, ymm8, ymm9
vaddpd ymm18, ymm14, ymm15
vaddpd ymm19, ymm17, ymmword ptr [rcx+rdi*8+0x28]
vaddpd ymm29, ymm27, ymmword ptr [rcx+rdi*8+0x48]
vaddpd ymm28, ymm24, ymm25
vaddpd ymm20, ymm18, ymm19
vmovupd ymm2, ymmword ptr [rsi+rdi*8+0x68]
vmovupd ymm3, ymmword ptr [rsi+rdi*8+0x70]
vmovupd ymm6, ymmword ptr [r10+rdi*8+0x68]
vmulpd ymm11, ymm0, ymm10
vmulpd ymm21, ymm0, ymm20
vaddpd ymm4, ymm2, ymmword ptr [rsi+rdi*8+0x60]
vaddpd ymm5, ymm3, ymmword ptr [r9+rdi*8+0x68]
vaddpd ymm7, ymm6, ymmword ptr [r14+rdi*8+0x68]
vaddpd ymm30, ymm28, ymm29
vaddpd ymm8, ymm4, ymm5
vaddpd ymm9, ymm7, ymmword ptr [rcx+rdi*8+0x68]
vmovupd ymmword ptr [r15+rdi*8+0x8], ymm11
vmulpd ymm31, ymm0, ymm30
vmovupd ymmword ptr [r15+rdi*8+0x28], ymm21
vaddpd ymm10, ymm8, ymm9
vmovupd ymmword ptr [r15+rdi*8+0x48], ymm31
vmulpd ymm11, ymm0, ymm10
vmovupd ymmword ptr [r15+rdi*8+0x68], ymm11
add rdi, 0x10
cmp rdi, rbx
jb 0xfffffffffffffeb8
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 21846
L3: P <= 611670
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 1048576;181²
L3: 16*N*P + 16*P*(N - 1) <= 29360128;957²
{%- endcapture -%}

{% include stencil_template.md %}

