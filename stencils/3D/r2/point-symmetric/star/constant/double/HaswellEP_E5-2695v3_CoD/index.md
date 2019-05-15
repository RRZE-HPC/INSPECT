---

title:  "Stencil 3D r2 star constant point-symmetric double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r2"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
scaling      : [ "770" ]
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

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = c0 * a[k][j][i] +
                   c1 * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   c2 * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   c3 * (a[k][j - 1][i] + a[k][j + 1][i]) +
                   c4 * (a[k][j][i - 2] + a[k][j][i + 2]) +
                   c5 * (a[k - 2][j][i] + a[k + 2][j][i]) +
                   c6 * (a[k][j - 2][i] + a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm3, ymmword ptr [rax+r9*8+0x8]
vmovupd ymm15, ymmword ptr [r10+r9*8+0x10]
vmovupd ymm2, ymmword ptr [rax+r9*8]
vaddpd ymm14, ymm3, ymmword ptr [rax+r9*8+0x18]
vaddpd ymm3, ymm15, ymmword ptr [r14+r9*8+0x10]
vaddpd ymm2, ymm2, ymmword ptr [rax+r9*8+0x20]
vmulpd ymm3, ymm7, ymm3
vfmadd231pd ymm3, ymm14, ymm0
vmovupd ymm14, ymmword ptr [r13+r9*8+0x10]
vfmadd231pd ymm3, ymm1, ymmword ptr [rax+r9*8+0x10]
vaddpd ymm15, ymm14, ymmword ptr [r12+r9*8+0x10]
vmovupd ymm14, ymmword ptr [r11+r9*8+0x10]
vaddpd ymm14, ymm14, ymmword ptr [r15+r9*8+0x10]
vmulpd ymm14, ymm10, ymm14
vfmadd231pd ymm14, ymm15, ymm13
vmovupd ymm15, ymmword ptr [rsi+r9*8+0x10]
vaddpd ymm15, ymm15, ymmword ptr [rdi+r9*8+0x10]
vmulpd ymm15, ymm9, ymm15
vfmadd231pd ymm15, ymm2, ymm12
vaddpd ymm2, ymm14, ymm15
vaddpd ymm2, ymm2, ymm3
vmovupd ymmword ptr [r8+r9*8+0x10], ymm2
add r9, 0x4
cmp r9, rdx
jb 0xffffffffffffff72
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;P <= 400
L2: P <= 16384/5;P <= 3270
L3: P <= 1179648/5;P <= 235920
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P <= 20²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 262144;N*P <= 40²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 18874368;N*P <= 510²
{%- endcapture -%}

{% include stencil_template.md %}
