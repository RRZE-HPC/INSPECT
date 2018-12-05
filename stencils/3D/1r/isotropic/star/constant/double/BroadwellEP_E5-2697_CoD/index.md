---

title:  "Stencil 3D r1 star constant isotropic double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "8"
scaling      : [ "1160" ]
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

for (int k = 1; k < M - 1; k++) {
  for (int j = 1; j < N - 1; j++) {
    for (int i = 1; i < P - 1; i++) {
      b[k][j][i] =
          c0 * a[k][j][i] + c1 * ((a[k][j][i - 1] + a[k][j][i + 1]) +
                                  (a[k - 1][j][i] + a[k + 1][j][i]) +
                                  (a[k][j - 1][i] + a[k][j + 1][i]));
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm4, ymmword ptr [r10+rcx*8]
vaddpd ymm5, ymm4, ymmword ptr [r10+rcx*8+0x10]
vaddpd ymm6, ymm5, ymmword ptr [rdi+rcx*8+0x8]
vaddpd ymm7, ymm6, ymmword ptr [r8+rcx*8+0x8]
vaddpd ymm8, ymm7, ymmword ptr [r15+rcx*8+0x8]
vaddpd ymm9, ymm8, ymmword ptr [r13+rcx*8+0x8]
vmulpd ymm10, ymm0, ymm9
vfmadd231pd ymm10, ymm1, ymmword ptr [r10+rcx*8+0x8]
vmovupd ymmword ptr [r14+rcx*8+0x8], ymm10
vmovupd ymm11, ymmword ptr [r10+rcx*8+0x20]
vaddpd ymm12, ymm11, ymmword ptr [r10+rcx*8+0x30]
vaddpd ymm13, ymm12, ymmword ptr [rdi+rcx*8+0x28]
vaddpd ymm14, ymm13, ymmword ptr [r8+rcx*8+0x28]
vaddpd ymm15, ymm14, ymmword ptr [r15+rcx*8+0x28]
vaddpd ymm4, ymm15, ymmword ptr [r13+rcx*8+0x28]
vmulpd ymm5, ymm0, ymm4
vfmadd231pd ymm5, ymm1, ymmword ptr [r10+rcx*8+0x28]
vmovupd ymmword ptr [r14+rcx*8+0x28], ymm5
vmovupd ymm6, ymmword ptr [r10+rcx*8+0x40]
vaddpd ymm7, ymm6, ymmword ptr [r10+rcx*8+0x50]
vaddpd ymm8, ymm7, ymmword ptr [rdi+rcx*8+0x48]
vaddpd ymm9, ymm8, ymmword ptr [r8+rcx*8+0x48]
vaddpd ymm10, ymm9, ymmword ptr [r15+rcx*8+0x48]
vaddpd ymm11, ymm10, ymmword ptr [r13+rcx*8+0x48]
vmulpd ymm12, ymm0, ymm11
vfmadd231pd ymm12, ymm1, ymmword ptr [r10+rcx*8+0x48]
vmovupd ymmword ptr [r14+rcx*8+0x48], ymm12
vmovupd ymm13, ymmword ptr [r10+rcx*8+0x60]
vaddpd ymm14, ymm13, ymmword ptr [r10+rcx*8+0x70]
vaddpd ymm15, ymm14, ymmword ptr [rdi+rcx*8+0x68]
vaddpd ymm4, ymm15, ymmword ptr [r8+rcx*8+0x68]
vaddpd ymm5, ymm4, ymmword ptr [r15+rcx*8+0x68]
vaddpd ymm6, ymm5, ymmword ptr [r13+rcx*8+0x68]
vmulpd ymm7, ymm0, ymm6
vfmadd231pd ymm7, ymm1, ymmword ptr [r10+rcx*8+0x68]
vmovupd ymmword ptr [r14+rcx*8+0x68], ymm7
add rcx, 0x10
cmp rcx, rdx
jb 0xffffffffffffff0c
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3;P ~ 680
L2: P <= 5462;P ~ 5460
L3: P <= 1179650/3;P ~ 393210
L1: 16*N*P + 16*P*(N - 1) <= 32768;N*P ~ 30²
L2: 16*N*P + 16*P*(N - 1) <= 262144;N*P ~ 90²
L3: 16*N*P + 16*P*(N - 1) <= 18874368;N*P ~ 760²
{%- endcapture -%}

{% include stencil_template.md %}
