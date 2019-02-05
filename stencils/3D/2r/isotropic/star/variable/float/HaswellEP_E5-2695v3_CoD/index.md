---

title:  "Stencil 3D r2 star variable isotropic float HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "star"
coefficients : "variable"
datatype     : "float"
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
float a[M][N][P];
float b[M][N][P];
float W[3][M][N][P];

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
vmovups ymm0, ymmword ptr [rax+rdx*4+0x4]
vmovups ymm7, ymmword ptr [rax+rdx*4]
vmovups ymm6, ymmword ptr [rax+rdx*4+0x8]
vaddps ymm1, ymm0, ymmword ptr [rax+rdx*4+0xc]
vaddps ymm8, ymm7, ymmword ptr [rax+rdx*4+0x10]
vaddps ymm2, ymm1, ymmword ptr [r13+rdx*4+0x8]
vaddps ymm9, ymm8, ymmword ptr [rbx+rdx*4+0x8]
vaddps ymm3, ymm2, ymmword ptr [r12+rdx*4+0x8]
vaddps ymm10, ymm9, ymmword ptr [rsi+rdx*4+0x8]
vaddps ymm4, ymm3, ymmword ptr [r15+rdx*4+0x8]
vaddps ymm11, ymm10, ymmword ptr [rdi+rdx*4+0x8]
vaddps ymm5, ymm4, ymmword ptr [r11+rdx*4+0x8]
vaddps ymm12, ymm11, ymmword ptr [r8+rdx*4+0x8]
vmulps ymm13, ymm5, ymmword ptr [r14+rdx*4+0x8]
vfmadd231ps ymm13, ymm6, ymmword ptr [rcx+rdx*4+0x8]
vfmadd231ps ymm13, ymm12, ymmword ptr [r10+rdx*4+0x8]
vmovups ymmword ptr [r9+rdx*4+0x8], ymm13
add rdx, 0x8
cmp rdx, qword ptr [rsp+0x148]
jb 0xffffffffffffff86
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 8192/13;P ~ 630
L2: P <= 65536/13;P ~ 5040
L3: P <= 4718592/13;P ~ 362960
L1: 28*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P ~ 20²
L2: 28*N*P + 8*P*(N - 2) + 16*P <= 262144;N*P ~ 80²
L3: 28*N*P + 8*P*(N - 2) + 16*P <= 18874368;N*P ~ 510²
{%- endcapture -%}

{% include stencil_template.md %}
