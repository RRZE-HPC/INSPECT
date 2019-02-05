---

title:  "Stencil 3D r2 star variable point-symmetric double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
scaling      : [ "540" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[7][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   W[2][k][j][i] * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   W[3][k][j][i] * (a[k][j - 1][i] + a[k][j + 1][i]) +
                   W[4][k][j][i] * (a[k][j][i - 2] + a[k][j][i + 2]) +
                   W[5][k][j][i] * (a[k - 2][j][i] + a[k + 2][j][i]) +
                   W[6][k][j][i] * (a[k][j - 2][i] + a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm5, ymmword ptr [r10+r8*8+0x10]
vmovupd ymm3, ymmword ptr [rdi+r8*8+0x10]
vmovupd ymm6, ymmword ptr [r13+r8*8+0x10]
vmovupd ymm1, ymmword ptr [rdx+r8*8+0x8]
vmovupd ymm4, ymmword ptr [rdx+r8*8]
vmovupd ymm0, ymmword ptr [rdx+r8*8+0x10]
vaddpd ymm7, ymm5, ymmword ptr [rbx+r8*8+0x10]
vaddpd ymm8, ymm3, ymmword ptr [r12+r8*8+0x10]
vaddpd ymm9, ymm6, ymmword ptr [r14+r8*8+0x10]
vaddpd ymm14, ymm1, ymmword ptr [rdx+r8*8+0x18]
vaddpd ymm10, ymm4, ymmword ptr [rdx+r8*8+0x20]
vmulpd ymm11, ymm7, ymmword ptr [r11+r8*8+0x10]
vmulpd ymm12, ymm9, ymmword ptr [r9+r8*8+0x10]
mov r15, qword ptr [rsp+0x1e0]
vfmadd231pd ymm12, ymm10, ymmword ptr [rcx+r8*8+0x10]
vmovupd ymm2, ymmword ptr [r15+r8*8+0x10]
mov r15, qword ptr [rsp+0x1f8]
vaddpd ymm13, ymm2, ymmword ptr [r15+r8*8+0x10]
mov r15, qword ptr [rsp+0x1f0]
vfmadd231pd ymm11, ymm8, ymmword ptr [r15+r8*8+0x10]
mov r15, qword ptr [rsp+0x1e8]
vaddpd ymm15, ymm11, ymm12
vmulpd ymm1, ymm13, ymmword ptr [r15+r8*8+0x10]
vfmadd231pd ymm1, ymm14, ymmword ptr [rsi+r8*8+0x10]
mov r15, qword ptr [rsp+0x1c8]
vfmadd231pd ymm1, ymm0, ymmword ptr [r15+r8*8+0x10]
vaddpd ymm0, ymm15, ymm1
vmovupd ymmword ptr [rax+r8*8+0x10], ymm0
add r8, 0x4
cmp r8, qword ptr [rsp+0x1a0]
jb 0xffffffffffffff31
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/17;P ~ 240
L2: P <= 32768/17;P ~ 1920
L3: P <= 2359296/17;P ~ 138780
L1: 88*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P ~ 10²
L2: 88*N*P + 16*P*(N - 2) + 32*P <= 262144;N*P ~ 40²
L3: 88*N*P + 16*P*(N - 2) + 32*P <= 18874368;N*P ~ 350²
{%- endcapture -%}

{% include stencil_template.md %}
