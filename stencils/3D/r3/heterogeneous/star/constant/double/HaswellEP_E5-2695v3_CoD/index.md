---

title:  "Stencil 3D r3 star constant heterogeneous double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r3"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "37"
scaling      : [ "580" ]
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

for (long k = 3; k < M - 3; ++k) {
  for (long j = 3; j < N - 3; ++j) {
    for (long i = 3; i < P - 3; ++i) {
      b[k][j][i] = c0 * a[k][j][i] + c1 * a[k][j][i - 1] +
                   c2 * a[k][j][i + 1] + c3 * a[k - 1][j][i] +
                   c4 * a[k + 1][j][i] + c5 * a[k][j - 1][i] +
                   c6 * a[k][j + 1][i] + c7 * a[k][j][i - 2] +
                   c8 * a[k][j][i + 2] + c9 * a[k - 2][j][i] +
                   c10 * a[k + 2][j][i] + c11 * a[k][j - 2][i] +
                   c12 * a[k][j + 2][i] + c13 * a[k][j][i - 3] +
                   c14 * a[k][j][i + 3] + c15 * a[k - 3][j][i] +
                   c16 * a[k + 3][j][i] + c17 * a[k][j - 3][i] +
                   c18 * a[k][j + 3][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm15, ymmword ptr [rsp+0x3c0]
vmovupd ymm2, ymmword ptr [rsp+0x400]
vmovupd ymm1, ymmword ptr [rsp+0x4a0]
vmovupd ymm0, ymmword ptr [rsp+0x3e0]
vmulpd ymm3, ymm15, ymmword ptr [r15+rdi*8+0x18]
vmovupd ymm15, ymmword ptr [rsp+0x440]
vfmadd231pd ymm3, ymm2, ymmword ptr [r14+rdi*8+0x18]
vmulpd ymm2, ymm1, ymmword ptr [rbx+rdi*8+0x18]
vmulpd ymm1, ymm15, ymmword ptr [rcx+rdi*8]
vmovupd ymm15, ymmword ptr [rsp+0x460]
vfmadd231pd ymm2, ymm0, ymmword ptr [r9+rdi*8+0x18]
vfmadd231pd ymm1, ymm5, ymmword ptr [r10+rdi*8+0x18]
vmulpd ymm15, ymm15, ymmword ptr [r13+rdi*8+0x18]
vaddpd ymm3, ymm3, ymm2
vmovupd ymm2, ymmword ptr [rsp+0x420]
vmulpd ymm2, ymm2, ymmword ptr [rcx+rdi*8+0x30]
mov rdx, qword ptr [rsp+0x4f8]
vfmadd231pd ymm2, ymm4, ymmword ptr [rdx+rdi*8+0x18]
vaddpd ymm0, ymm1, ymm2
vmulpd ymm1, ymm7, ymmword ptr [r12+rdi*8+0x18]
vaddpd ymm2, ymm3, ymm0
vmulpd ymm3, ymm6, ymmword ptr [r11+rdi*8+0x18]
vfmadd231pd ymm1, ymm9, ymmword ptr [rcx+rdi*8+0x8]
vmulpd ymm0, ymm10, ymmword ptr [r8+rdi*8+0x18]
vfmadd231pd ymm3, ymm8, ymmword ptr [rcx+rdi*8+0x28]
vfmadd231pd ymm0, ymm11, ymmword ptr [rsi+rdi*8+0x18]
vaddpd ymm1, ymm1, ymm3
vmovupd ymm3, ymmword ptr [rsp+0x480]
mov rdx, qword ptr [rsp+0x510]
vfmadd231pd ymm15, ymm3, ymmword ptr [rdx+rdi*8+0x18]
vaddpd ymm0, ymm0, ymm15
vaddpd ymm1, ymm1, ymm0
vmulpd ymm0, ymm12, ymmword ptr [rcx+rdi*8+0x20]
vaddpd ymm2, ymm2, ymm1
vfmadd231pd ymm0, ymm13, ymmword ptr [rcx+rdi*8+0x10]
vfmadd231pd ymm0, ymm14, ymmword ptr [rcx+rdi*8+0x18]
vaddpd ymm1, ymm2, ymm0
vmovupd ymmword ptr [rax+rdi*8+0x18], ymm1
add rdi, 0x4
cmp rdi, qword ptr [rsp+0x4d0]
jb 0xfffffffffffffef5
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P <= 290
L2: P <= 16384/7;P <= 2340
L3: P <= 1179648/7;P <= 168520
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;N*P <= 10²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;N*P <= 60²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 18874368;N*P <= 380²
{%- endcapture -%}

{% include stencil_template.md %}
