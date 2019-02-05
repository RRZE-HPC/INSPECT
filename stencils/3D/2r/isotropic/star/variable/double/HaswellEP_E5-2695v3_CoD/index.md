---

title:  "Stencil 3D r2 star variable isotropic double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "15"
scaling      : [ "740" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[3][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] =
          W[0][k][j][i] * a[k][j][i] +
          W[1][k][j][i] * ((a[k][j][i - 1] + a[k][j][i + 1]) +
                           (a[k - 1][j][i] + a[k + 1][j][i]) +
                           (a[k][j - 1][i] + a[k][j + 1][i])) +
          W[2][k][j][i] * ((a[k][j][i - 2] + a[k][j][i + 2]) +
                           (a[k - 2][j][i] + a[k + 2][j][i]) +
                           (a[k][j - 2][i] + a[k][j + 2][i]));
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm0, ymmword ptr [rax+rdx*8+0x8]
vmovupd ymm7, ymmword ptr [rax+rdx*8]
vmovupd ymm6, ymmword ptr [rax+rdx*8+0x10]
vaddpd ymm1, ymm0, ymmword ptr [rax+rdx*8+0x18]
vaddpd ymm8, ymm7, ymmword ptr [rax+rdx*8+0x20]
vaddpd ymm2, ymm1, ymmword ptr [r13+rdx*8+0x10]
vaddpd ymm9, ymm8, ymmword ptr [rbx+rdx*8+0x10]
vaddpd ymm3, ymm2, ymmword ptr [r12+rdx*8+0x10]
vaddpd ymm10, ymm9, ymmword ptr [rsi+rdx*8+0x10]
vaddpd ymm4, ymm3, ymmword ptr [r15+rdx*8+0x10]
vaddpd ymm11, ymm10, ymmword ptr [rdi+rdx*8+0x10]
vaddpd ymm5, ymm4, ymmword ptr [r11+rdx*8+0x10]
vaddpd ymm12, ymm11, ymmword ptr [r8+rdx*8+0x10]
vmulpd ymm13, ymm5, ymmword ptr [r14+rdx*8+0x10]
vfmadd231pd ymm13, ymm6, ymmword ptr [rcx+rdx*8+0x10]
vfmadd231pd ymm13, ymm12, ymmword ptr [r10+rdx*8+0x10]
vmovupd ymmword ptr [r9+rdx*8+0x10], ymm13
add rdx, 0x4
cmp rdx, qword ptr [rsp+0x148]
jb 0xffffffffffffff86
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/13;P ~ 310
L2: P <= 32768/13;P ~ 2520
L3: P <= 2359296/13;P ~ 181480
L1: 56*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P ~ 20²
L2: 56*N*P + 16*P*(N - 2) + 32*P <= 262144;N*P ~ 40²
L3: 56*N*P + 16*P*(N - 2) + 32*P <= 18874368;N*P ~ 510²
{%- endcapture -%}

{% include stencil_template.md %}
