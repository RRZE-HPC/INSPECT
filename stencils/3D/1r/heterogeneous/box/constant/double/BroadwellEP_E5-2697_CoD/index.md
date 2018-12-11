---

title:  "Stencil 3D r1 box constant heterogeneous double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "53"
scaling      : [ "1280" ]
blocking     : [ "L3-3D" ]
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
double c19;
double c20;
double c21;
double c22;
double c23;
double c24;
double c25;
double c26;

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          c0 * a[k][j][i] + c1 * a[k - 1][j - 1][i - 1] +
          c2 * a[k][j - 1][i - 1] + c3 * a[k + 1][j - 1][i - 1] +
          c4 * a[k - 1][j][i - 1] + c5 * a[k][j][i - 1] +
          c6 * a[k + 1][j][i - 1] + c7 * a[k - 1][j + 1][i - 1] +
          c8 * a[k][j + 1][i - 1] + c9 * a[k + 1][j + 1][i - 1] +
          c10 * a[k - 1][j - 1][i] + c11 * a[k][j - 1][i] +
          c12 * a[k + 1][j - 1][i] + c13 * a[k - 1][j][i] +
          c14 * a[k + 1][j][i] + c15 * a[k - 1][j + 1][i] +
          c16 * a[k][j + 1][i] + c17 * a[k + 1][j + 1][i] +
          c18 * a[k - 1][j - 1][i + 1] + c19 * a[k][j - 1][i + 1] +
          c20 * a[k + 1][j - 1][i + 1] + c21 * a[k - 1][j][i + 1] +
          c22 * a[k][j][i + 1] + c23 * a[k + 1][j][i + 1] +
          c24 * a[k - 1][j + 1][i + 1] + c25 * a[k][j + 1][i + 1] +
          c26 * a[k + 1][j + 1][i + 1];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm15, ymmword ptr [rsp+0x3a0]
vmulpd ymm12, ymm1, ymmword ptr [rsi+r15*8+0x10]
vmulpd ymm14, ymm0, ymmword ptr [r8+r15*8+0x10]
vmulpd ymm13, ymm4, ymmword ptr [r9+r15*8+0x10]
vmulpd ymm11, ymm15, ymmword ptr [r12+r15*8+0x10]
vfmadd231pd ymm12, ymm3, ymmword ptr [r11+r15*8+0x10]
vfmadd231pd ymm14, ymm2, ymmword ptr [r14+r15*8+0x10]
vfmadd231pd ymm13, ymm5, ymmword ptr [rbx+r15*8+0x10]
vmovupd ymm15, ymmword ptr [rsp+0x3c0]
vfmadd231pd ymm11, ymm6, ymmword ptr [r13+r15*8+0x10]
vaddpd ymm12, ymm12, ymm14
vaddpd ymm14, ymm11, ymm13
vmulpd ymm11, ymm8, ymmword ptr [r8+r15*8+0x8]
vaddpd ymm13, ymm12, ymm14
vmovupd ymm12, ymmword ptr [rsp+0x3e0]
vfmadd231pd ymm11, ymm15, ymmword ptr [r14+r15*8+0x8]
vmulpd ymm15, ymm7, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm14, ymmword ptr [rsp+0x420]
vfmadd231pd ymm15, ymm9, ymmword ptr [rsi+r15*8+0x8]
vaddpd ymm15, ymm11, ymm15
vmulpd ymm11, ymm12, ymmword ptr [r12+r15*8+0x8]
vmovupd ymm12, ymmword ptr [rsp+0x400]
vfmadd231pd ymm11, ymm14, ymmword ptr [r13+r15*8+0x8]
vmulpd ymm14, ymm10, ymmword ptr [r11+r15*8+0x8]
vfmadd231pd ymm14, ymm12, ymmword ptr [rbx+r15*8+0x8]
vmovupd ymm12, ymmword ptr [rsp+0x480]
vaddpd ymm11, ymm11, ymm14
vaddpd ymm15, ymm15, ymm11
vmovupd ymm11, ymmword ptr [rsp+0x4a0]
vaddpd ymm15, ymm13, ymm15
vmovupd ymm13, ymmword ptr [rsp+0x460]
vmulpd ymm14, ymm13, ymmword ptr [r8+r15*8]
vmovupd ymm13, ymmword ptr [rsp+0x440]
vfmadd231pd ymm14, ymm11, ymmword ptr [r14+r15*8]
vmulpd ymm11, ymm13, ymmword ptr [r10+r15*8+0x8]
vfmadd231pd ymm11, ymm12, ymmword ptr [rsi+r15*8]
vaddpd ymm13, ymm14, ymm11
vmovupd ymm14, ymmword ptr [rsp+0x4e0]
vmovupd ymm11, ymmword ptr [rsp+0x520]
vmulpd ymm12, ymm14, ymmword ptr [r9+r15*8]
vmovupd ymm14, ymmword ptr [rsp+0x4c0]
vfmadd231pd ymm12, ymm11, ymmword ptr [rbx+r15*8]
vmulpd ymm14, ymm14, ymmword ptr [r11+r15*8]
vmovupd ymm11, ymmword ptr [rsp+0x500]
vfmadd231pd ymm14, ymm11, ymmword ptr [r12+r15*8]
vaddpd ymm12, ymm12, ymm14
vaddpd ymm11, ymm13, ymm12
vmovupd ymm13, ymmword ptr [rsp+0x540]
vmovupd ymm12, ymmword ptr [rsp+0x560]
vmulpd ymm14, ymm13, ymmword ptr [r13+r15*8]
vmovupd ymm13, ymmword ptr [rsp+0x580]
vfmadd231pd ymm14, ymm12, ymmword ptr [r10+r15*8]
nop
vfmadd231pd ymm14, ymm13, ymmword ptr [r9+r15*8+0x8]
vaddpd ymm11, ymm11, ymm14
vaddpd ymm15, ymm15, ymm11
vmovupd ymmword ptr [rdx+r15*8+0x8], ymm15
add r15, 0x4
cmp r15, rcx
jb 0xfffffffffffffe70
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;P ~ 400
L2: P <= 3277;P ~ 3270
L3: P <= 1441793/5;P ~ 288350
L1: 32*N*P - 16*P - 16 <= 32768;N*P ~ 20²
L2: 32*N*P - 16*P - 16 <= 262144;N*P ~ 90²
L3: 32*N*P - 16*P - 16 <= 23068672;N*P ~ 840²
{%- endcapture -%}

{% include stencil_template.md %}
