---

title:  "Stencil 3D r1 box constant isotropic double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r1"
weighting    : "isotropic"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "30"
scaling      : [ "1010" ]
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

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          c0 * a[k][j][i] +
          c1 * (a[k][j][i - 1] + a[k][j - 1][i] + a[k - 1][j][i] +
                a[k + 1][j][i] + a[k][j + 1][i] + a[k][j][i + 1]) +
          c2 * (a[k][j - 1][i - 1] + a[k - 1][j][i - 1] +
                a[k + 1][j][i - 1] + a[k][j + 1][i - 1] +
                a[k - 1][j - 1][i] + a[k + 1][j - 1][i] +
                a[k - 1][j + 1][i] + a[k + 1][j + 1][i] +
                a[k][j - 1][i + 1] + a[k - 1][j][i + 1] +
                a[k + 1][j][i + 1] + a[k][j + 1][i + 1]) +
          c3 * (a[k - 1][j - 1][i - 1] + a[k + 1][j - 1][i - 1] +
                a[k - 1][j + 1][i - 1] + a[k + 1][j + 1][i - 1] +
                a[k - 1][j - 1][i + 1] + a[k + 1][j - 1][i + 1] +
                a[k - 1][j + 1][i + 1] + a[k + 1][j + 1][i + 1]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm12, ymmword ptr [r9+r15*8]
vmovupd ymm6, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm5, ymmword ptr [rsi+r15*8+0x10]
vmovupd ymm1, ymmword ptr [rsi+r15*8]
vmovupd ymm0, ymmword ptr [r10+r15*8]
vmovupd ymm14, ymmword ptr [r11+r15*8+0x8]
vaddpd ymm13, ymm12, ymmword ptr [r10+r15*8+0x8]
vaddpd ymm6, ymm6, ymmword ptr [r13+r15*8+0x10]
vaddpd ymm5, ymm5, ymmword ptr [r12+r15*8+0x10]
vaddpd ymm15, ymm13, ymmword ptr [r13+r15*8+0x8]
vaddpd ymm0, ymm0, ymmword ptr [r13+r15*8]
vaddpd ymm6, ymm6, ymm5
vaddpd ymm12, ymm15, ymmword ptr [rsi+r15*8+0x8]
vaddpd ymm1, ymm1, ymmword ptr [r12+r15*8]
vaddpd ymm14, ymm14, ymmword ptr [r14+r15*8+0x8]
vaddpd ymm13, ymm12, ymmword ptr [r12+r15*8+0x8]
vaddpd ymm0, ymm0, ymm1
vmovupd ymm5, ymmword ptr [rdi+r15*8+0x8]
vmovupd ymm1, ymmword ptr [rdi+r15*8+0x10]
vaddpd ymm15, ymm13, ymmword ptr [r9+r15*8+0x10]
vaddpd ymm5, ymm5, ymmword ptr [r8+r15*8+0x8]
vaddpd ymm1, ymm1, ymmword ptr [r8+r15*8+0x10]
vmulpd ymm12, ymm3, ymm15
vmovupd ymm13, ymmword ptr [r11+r15*8+0x10]
vmovupd ymm15, ymmword ptr [r11+r15*8]
vaddpd ymm14, ymm14, ymm5
vaddpd ymm13, ymm13, ymmword ptr [r14+r15*8+0x10]
vmovupd ymm5, ymmword ptr [rdi+r15*8]
vfmadd231pd ymm12, ymm11, ymmword ptr [r9+r15*8+0x8]
vaddpd ymm0, ymm0, ymm14
vaddpd ymm5, ymm5, ymmword ptr [r8+r15*8]
vaddpd ymm14, ymm13, ymm1
vaddpd ymm6, ymm0, ymm6
vaddpd ymm0, ymm15, ymmword ptr [r14+r15*8]
vfmadd231pd ymm12, ymm6, ymm4
vaddpd ymm6, ymm0, ymm5
vaddpd ymm15, ymm6, ymm14
vfmadd231pd ymm12, ymm15, ymm2
vmovupd ymmword ptr [rdx+r15*8+0x8], ymm12
add r15, 0x4
cmp r15, rcx
jb 0xffffffffffffff0c
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;P <= 400
L2: P <= 3277;P <= 3270
L3: P <= 1179649/5;P <= 235920
L1: 32*N*P - 16*P - 16 <= 32768;N*P <= 20²
L2: 32*N*P - 16*P - 16 <= 262144;N*P <= 90²
L3: 32*N*P - 16*P - 16 <= 18874368;N*P <= 760²
{%- endcapture -%}

{% include stencil_template.md %}
