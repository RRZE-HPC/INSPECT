---

title:  "Stencil 3D r1 star variable heterogeneous double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
comment      : "The relatively long dependency chain (see assembler code) is a common issue for boxed stencils. This makes this code in general core bound because of those dependencies."
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "660" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[7][M][N][P];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * a[k][j][i - 1] +
                   W[2][k][j][i] * a[k][j][i + 1] +
                   W[3][k][j][i] * a[k - 1][j][i] +
                   W[4][k][j][i] * a[k + 1][j][i] +
                   W[5][k][j][i] * a[k][j - 1][i] +
                   W[6][k][j][i] * a[k][j + 1][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm6, ymmword ptr [rdi+r15*8+0x8]
vmovupd ymm0, ymmword ptr [r11+r15*8+0x8]
vmovupd ymm2, ymmword ptr [rbx+r15*8+0x8]
vmovupd ymm7, ymmword ptr [rax+r15*8]
vmovupd ymm1, ymmword ptr [r9+r15*8+0x8]
vmulpd ymm10, ymm6, ymmword ptr [rax+r15*8+0x10]
vmovupd ymm3, ymmword ptr [r10+r15*8+0x8]
vmulpd ymm4, ymm0, ymmword ptr [rdx+r15*8+0x8]
vmulpd ymm5, ymm2, ymmword ptr [rcx+r15*8+0x8]
vmovupd ymm8, ymmword ptr [rax+r15*8+0x8]
vfmadd231pd ymm10, ymm7, ymmword ptr [r14+r15*8+0x8]
vfmadd231pd ymm4, ymm1, ymmword ptr [r8+r15*8+0x8]
vfmadd231pd ymm5, ymm3, ymmword ptr [r13+r15*8+0x8]
vfmadd231pd ymm10, ymm8, ymmword ptr [rsi+r15*8+0x8]
vaddpd ymm9, ymm4, ymm5
vaddpd ymm11, ymm9, ymm10
vmovupd ymmword ptr [r12+r15*8+0x8], ymm11
add r15, 0x4
cmp r15, qword ptr [rsp+0x158]
jb 0xffffffffffffff83
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4107/13;P ~ 310
L2: P <= 32779/13;P ~ 2520
L3: P <= 2359307/13;P ~ 181480
L1: 72*N*P + 16*P*(N - 1) - 56*P <= 32768;N*P ~ 10²
L2: 72*N*P + 16*P*(N - 1) - 56*P <= 262144;N*P ~ 50²
L3: 72*N*P + 16*P*(N - 1) - 56*P <= 18874368;N*P ~ 460²
{%- endcapture -%}

{% include stencil_template.md %}
