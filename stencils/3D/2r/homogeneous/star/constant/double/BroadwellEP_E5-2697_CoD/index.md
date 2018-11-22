---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : ""
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vmovupd ymm3, ymmword ptr [r8+r15*8+0x18]
vmovupd ymm2, ymmword ptr [r8+r15*8+0x10]
vmovupd ymm12, ymmword ptr [r8+r15*8+0x20]
vmovupd ymm6, ymmword ptr [r13+r15*8+0x10]
vmovupd ymm7, ymmword ptr [r11+r15*8+0x10]
vmovupd ymm13, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm4, ymm2, ymmword ptr [r8+r15*8+0x8]
vaddpd ymm9, ymm7, ymmword ptr [r8+r15*8]
vaddpd ymm5, ymm3, ymmword ptr [r9+r15*8+0x10]
vaddpd ymm8, ymm6, ymmword ptr [r12+r15*8+0x10]
vaddpd ymm14, ymm12, ymmword ptr [r10+r15*8+0x10]
vaddpd ymm15, ymm13, ymmword ptr [rdi+r15*8+0x10]
vaddpd ymm10, ymm4, ymm5
vaddpd ymm11, ymm8, ymm9
vaddpd ymm12, ymm14, ymm15
vaddpd ymm2, ymm10, ymm11
vaddpd ymm3, ymm12, ymmword ptr [rsi+r15*8+0x10]
vaddpd ymm4, ymm2, ymm3
vmulpd ymm5, ymm0, ymm4
vmovupd ymmword ptr [rdx+r15*8+0x10], ymm5
add r15, 0x4
cmp r15, rcx
jb 0xffffffffffffff7d
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;409
L2: P <= 16384/5;3276
L3: P <= 1441792/5;288385
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;26²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 262144;73²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 23068672;692²
{%- endcapture -%}

{% include stencil_template.md %}

