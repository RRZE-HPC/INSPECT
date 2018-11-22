---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
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

for ( int k = 2; k < M-2; k++ ) {
  for ( int j = 2; j < N-2; j++ ) {
    for ( int i = 2; i < P-2; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
        + c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
        + c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
        + c11 * a[k][j-2][i] + c12 * a[k][j+2][i];
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmulpd ymm14, ymm2, ymmword ptr [rdi+r15*8+0x10]
vmulpd ymm15, ymm1, ymmword ptr [rsi+r15*8+0x10]
vfmadd231pd ymm14, ymm4, ymmword ptr [r10+r15*8+0x10]
vfmadd231pd ymm15, ymm3, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm0, ymm14, ymm15
vmulpd ymm14, ymm6, ymmword ptr [r8+r15*8]
vmulpd ymm15, ymm5, ymmword ptr [r8+r15*8+0x20]
vfmadd231pd ymm14, ymm8, ymmword ptr [r12+r15*8+0x10]
vfmadd231pd ymm15, ymm7, ymmword ptr [r11+r15*8+0x10]
vaddpd ymm14, ymm14, ymm15
vaddpd ymm0, ymm0, ymm14
vmulpd ymm14, ymm9, ymmword ptr [r13+r15*8+0x10]
vfmadd231pd ymm14, ymm10, ymmword ptr [r9+r15*8+0x10]
vfmadd231pd ymm14, ymm11, ymmword ptr [r8+r15*8+0x18]
vfmadd231pd ymm14, ymm12, ymmword ptr [r8+r15*8+0x8]
vfmadd231pd ymm14, ymm13, ymmword ptr [r8+r15*8+0x10]
vaddpd ymm0, ymm0, ymm14
vmovupd ymmword ptr [rdx+r15*8+0x10], ymm0
add r15, 0x4
cmp r15, rcx
jb 0xffffffffffffff84
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
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 18874368;626²
{%- endcapture -%}

{% include stencil_template.md %}

