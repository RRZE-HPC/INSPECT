---

title:  "Stencil 3D r1 star variable isotropic double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "8"
scaling      : [ "950" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[2][M][N][P];

for (long k = 1; k < M - 1; ++k) {
  for (long j = 1; j < N - 1; ++j) {
    for (long i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          W[0][k][j][i] * a[k][j][i] +
          W[1][k][j][i] * ((a[k][j][i - 1] + a[k][j][i + 1]) +
                           (a[k - 1][j][i] + a[k + 1][j][i]) +
                           (a[k][j - 1][i] + a[k][j + 1][i]));
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm0, ymmword ptr [r14+rdx*1]
vmovupd ymm6, ymmword ptr [r14+rdx*1+0x8]
vaddpd ymm1, ymm0, ymmword ptr [r14+rdx*1+0x10]
vaddpd ymm2, ymm1, ymmword ptr [r10+r15*8+0x8]
vaddpd ymm3, ymm2, ymmword ptr [r12+r15*8+0x8]
vaddpd ymm4, ymm3, ymmword ptr [r13+r15*8+0x8]
vaddpd ymm5, ymm4, ymmword ptr [r11+r15*8+0x8]
vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8+0x8]
vfmadd231pd ymm7, ymm6, ymmword ptr [rbx+r15*8+0x8]
vmovupd ymmword ptr [r9+r15*8+0x8], ymm7
vmovupd ymm8, ymmword ptr [r14+rdx*1+0x20]
vmovupd ymm14, ymmword ptr [r14+rdx*1+0x28]
vaddpd ymm9, ymm8, ymmword ptr [r14+rdx*1+0x30]
vaddpd ymm10, ymm9, ymmword ptr [r10+r15*8+0x28]
vaddpd ymm11, ymm10, ymmword ptr [r12+r15*8+0x28]
vaddpd ymm12, ymm11, ymmword ptr [r13+r15*8+0x28]
vaddpd ymm13, ymm12, ymmword ptr [r11+r15*8+0x28]
vmulpd ymm15, ymm13, ymmword ptr [r8+r15*8+0x28]
vfmadd231pd ymm15, ymm14, ymmword ptr [rbx+r15*8+0x28]
vmovupd ymmword ptr [r9+r15*8+0x28], ymm15
vmovupd ymm0, ymmword ptr [r14+rdx*1+0x40]
vmovupd ymm6, ymmword ptr [r14+rdx*1+0x48]
vaddpd ymm1, ymm0, ymmword ptr [r14+rdx*1+0x50]
vaddpd ymm2, ymm1, ymmword ptr [r10+r15*8+0x48]
vaddpd ymm3, ymm2, ymmword ptr [r12+r15*8+0x48]
vaddpd ymm4, ymm3, ymmword ptr [r13+r15*8+0x48]
vaddpd ymm5, ymm4, ymmword ptr [r11+r15*8+0x48]
vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8+0x48]
vfmadd231pd ymm7, ymm6, ymmword ptr [rbx+r15*8+0x48]
vmovupd ymmword ptr [r9+r15*8+0x48], ymm7
vmovupd ymm8, ymmword ptr [r14+rdx*1+0x60]
vmovupd ymm14, ymmword ptr [r14+rdx*1+0x68]
vaddpd ymm9, ymm8, ymmword ptr [r14+rdx*1+0x70]
vaddpd ymm10, ymm9, ymmword ptr [r10+r15*8+0x68]
add r14, 0x80
vaddpd ymm11, ymm10, ymmword ptr [r12+r15*8+0x68]
vaddpd ymm12, ymm11, ymmword ptr [r13+r15*8+0x68]
vaddpd ymm13, ymm12, ymmword ptr [r11+r15*8+0x68]
vmulpd ymm0, ymm13, ymmword ptr [r8+r15*8+0x68]
vfmadd231pd ymm0, ymm14, ymmword ptr [rbx+r15*8+0x68]
vmovupd ymmword ptr [r9+r15*8+0x68], ymm0
add r15, 0x10
cmp r15, rax
jb 0xfffffffffffffedb
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2051/4;P ~ 510
L2: P <= 16387/4;P ~ 4090
L3: P <= 1179651/4;P ~ 294910
L1: 32*N*P + 16*P*(N - 1) - 16*P <= 32768;N*P ~ 20²
L2: 32*N*P + 16*P*(N - 1) - 16*P <= 262144;N*P ~ 70²
L3: 32*N*P + 16*P*(N - 1) - 16*P <= 18874368;N*P ~ 620²
{%- endcapture -%}

{% include stencil_template.md %}
