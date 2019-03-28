---

title:  "Stencil 3D r1 star variable point-symmetric double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "r1"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "10"
scaling      : [ "910" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[4][M][N][P];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   W[2][k][j][i] * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   W[3][k][j][i] * (a[k][j - 1][i] + a[k][j + 1][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm0, ymmword ptr [rcx+r11*8]
vmovupd ymm2, ymmword ptr [rcx+r11*8+0x8]
vmovupd ymm3, ymmword ptr [r12+r11*8+0x8]
vmovupd ymm5, ymmword ptr [r14+r11*8+0x8]
vaddpd ymm1, ymm0, ymmword ptr [rcx+r11*8+0x10]
vaddpd ymm4, ymm3, ymmword ptr [r13+r11*8+0x8]
vaddpd ymm6, ymm5, ymmword ptr [rdi+r11*8+0x8]
vmulpd ymm7, ymm1, ymmword ptr [rdx+r11*8+0x8]
vfmadd231pd ymm7, ymm2, ymmword ptr [rax+r11*8+0x8]
vfmadd231pd ymm7, ymm4, ymmword ptr [rsi+r11*8+0x8]
vfmadd231pd ymm7, ymm6, ymmword ptr [r10+r11*8+0x8]
vmovupd ymmword ptr [r15+r11*8+0x8], ymm7
add r11, 0x4
cmp r11, r8
jb 0xffffffffffffffa6
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2052/5;P <= 410
L2: P <= 16388/5;P <= 3270
L3: P <= 1441796/5;P <= 288350
L1: 48*N*P + 16*P*(N - 1) - 32*P <= 32768;N*P <= 20²
L2: 48*N*P + 16*P*(N - 1) - 32*P <= 262144;N*P <= 60²
L3: 48*N*P + 16*P*(N - 1) - 32*P <= 23068672;N*P <= 600²
{%- endcapture -%}

{% include stencil_template.md %}
