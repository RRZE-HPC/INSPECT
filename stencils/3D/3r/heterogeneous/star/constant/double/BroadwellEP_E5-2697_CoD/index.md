---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
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
double c13;
double c14;
double c15;
double c16;
double c17;
double c18;

for( int k = 3; k < M-3; k++ ) {
  for( int j = 3; j < N-3; j++ ) {
    for( int i = 3; i < P-3; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
        + c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
        + c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
        + c11 * a[k][j-2][i] + c12 * a[k][j+2][i]
        + c13 * a[k][j][i-3] + c14 * a[k][j][i+3]
        + c15 * a[k-3][j][i] + c16 * a[k+3][j][i]
        + c17 * a[k][j-3][i] + c18 * a[k][j+3][i];
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmovupd ymm15, ymmword ptr [rsp+0x3c0]
vmovupd ymm2, ymmword ptr [rsp+0x400]
vmovupd ymm1, ymmword ptr [rsp+0x4a0]
vmovupd ymm0, ymmword ptr [rsp+0x3e0]
vmulpd ymm3, ymm15, ymmword ptr [r11+rbx*8+0x18]
vmovupd ymm15, ymmword ptr [rsp+0x440]
vfmadd231pd ymm3, ymm2, ymmword ptr [r9+rbx*8+0x18]
vmulpd ymm2, ymm1, ymmword ptr [rsi+rbx*8+0x18]
vmulpd ymm1, ymm15, ymmword ptr [rax+rbx*8]
vmovupd ymm15, ymmword ptr [rsp+0x460]
vfmadd231pd ymm2, ymm0, ymmword ptr [r10+rbx*8+0x18]
vfmadd231pd ymm1, ymm5, ymmword ptr [r8+rbx*8+0x18]
vmulpd ymm15, ymm15, ymmword ptr [rcx+rbx*8+0x18]
vaddpd ymm3, ymm3, ymm2
vmovupd ymm2, ymmword ptr [rsp+0x420]
vmulpd ymm2, ymm2, ymmword ptr [rax+rbx*8+0x30]
mov r15, qword ptr [rsp+0x520]
vfmadd231pd ymm2, ymm4, ymmword ptr [r15+rbx*8+0x18]
vaddpd ymm0, ymm1, ymm2
vmulpd ymm1, ymm7, ymmword ptr [r14+rbx*8+0x18]
vaddpd ymm2, ymm3, ymm0
vmulpd ymm3, ymm6, ymmword ptr [rdx+rbx*8+0x18]
vfmadd231pd ymm1, ymm9, ymmword ptr [rax+rbx*8+0x8]
vmulpd ymm0, ymm10, ymmword ptr [r13+rbx*8+0x18]
vfmadd231pd ymm3, ymm8, ymmword ptr [rax+rbx*8+0x28]
vfmadd231pd ymm0, ymm11, ymmword ptr [rdi+rbx*8+0x18]
vaddpd ymm1, ymm1, ymm3
vmovupd ymm3, ymmword ptr [rsp+0x480]
mov r15, qword ptr [rsp+0x528]
vfmadd231pd ymm15, ymm3, ymmword ptr [r15+rbx*8+0x18]
vaddpd ymm0, ymm0, ymm15
vaddpd ymm1, ymm1, ymm0
vmulpd ymm0, ymm12, ymmword ptr [rax+rbx*8+0x20]
vaddpd ymm2, ymm2, ymm1
vfmadd231pd ymm0, ymm13, ymmword ptr [rax+rbx*8+0x10]
vfmadd231pd ymm0, ymm14, ymmword ptr [rax+rbx*8+0x18]
vaddpd ymm1, ymm2, ymm0
vmovupd ymmword ptr [r12+rbx*8+0x18], ymm1
add rbx, 0x4
cmp rbx, qword ptr [rsp+0x4e0]
jb 0xfffffffffffffef6
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;292
L2: P <= 16384/7;2340
L3: P <= 1441792/7;205970
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;32²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;91²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 23068672;849²

{%- endcapture -%}

{% include stencil_template.md %}

