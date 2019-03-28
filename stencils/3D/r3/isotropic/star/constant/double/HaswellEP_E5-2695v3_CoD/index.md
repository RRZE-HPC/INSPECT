---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r3"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vmovupd ymm11, ymmword ptr [rax+rcx*8+0x10]
vmovupd ymm1, ymmword ptr [rax+rcx*8+0x8]
vmovupd ymm2, ymmword ptr [rax+rcx*8]
vaddpd ymm12, ymm11, ymmword ptr [rax+rcx*8+0x20]
vaddpd ymm1, ymm1, ymmword ptr [rax+rcx*8+0x28]
vaddpd ymm2, ymm2, ymmword ptr [rax+rcx*8+0x30]
vaddpd ymm11, ymm1, ymmword ptr [r13+rcx*8+0x18]
mov r15, qword ptr [rsp+0x1b0]
vaddpd ymm13, ymm12, ymmword ptr [r15+rcx*8+0x18]
vaddpd ymm12, ymm11, ymmword ptr [rbx+rcx*8+0x18]
mov r15, qword ptr [rsp+0x1a8]
vaddpd ymm14, ymm13, ymmword ptr [r15+rcx*8+0x18]
vaddpd ymm13, ymm12, ymmword ptr [r14+rcx*8+0x18]
vaddpd ymm15, ymm14, ymmword ptr [rdi+rcx*8+0x18]
vaddpd ymm14, ymm13, ymmword ptr [r12+rcx*8+0x18]
vaddpd ymm0, ymm15, ymmword ptr [rdx+rcx*8+0x18]
vaddpd ymm15, ymm2, ymmword ptr [r8+rcx*8+0x18]
vmulpd ymm0, ymm5, ymm0
vaddpd ymm1, ymm15, ymmword ptr [r9+rcx*8+0x18]
vfmadd231pd ymm0, ymm8, ymmword ptr [rax+rcx*8+0x18]
vaddpd ymm2, ymm1, ymmword ptr [r10+rcx*8+0x18]
vfmadd231pd ymm0, ymm14, ymm4
vaddpd ymm11, ymm2, ymmword ptr [rsi+rcx*8+0x18]
vfmadd231pd ymm0, ymm11, ymm3
vmovupd ymmword ptr [r11+rcx*8+0x18], ymm0
add rcx, 0x4
cmp rcx, qword ptr [rsp+0x180]
jb 0xffffffffffffff55
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;292
L2: P <= 16384/7;2340
L3: P <= 1179648/7;168521
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;32²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;91²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 18874368;768²
{%- endcapture -%}

{% include stencil_template.md %}

