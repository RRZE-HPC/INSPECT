---

title:  "Stencil 3D r2 star constant isotropic float HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "float"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "15"
scaling      : [ "770" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
float a[M][N][P];
float b[M][N][P];
float c0;
float c1;
float c2;

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = c0 * a[k][j][i] +
                   c1 * ((a[k][j][i - 1] + a[k][j][i + 1]) +
                         (a[k - 1][j][i] + a[k + 1][j][i]) +
                         (a[k][j - 1][i] + a[k][j + 1][i])) +
                   c2 * ((a[k][j][i - 2] + a[k][j][i + 2]) +
                         (a[k - 2][j][i] + a[k + 2][j][i]) +
                         (a[k][j - 2][i] + a[k][j + 2][i]));
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovups ymm6, ymmword ptr [rax+r9*4+0x4]
vmovups ymm12, ymmword ptr [rax+r9*4]
vaddps ymm7, ymm6, ymmword ptr [rax+r9*4+0xc]
vaddps ymm13, ymm12, ymmword ptr [rax+r9*4+0x10]
vaddps ymm8, ymm7, ymmword ptr [r10+r9*4+0x8]
vaddps ymm14, ymm13, ymmword ptr [r11+r9*4+0x8]
vaddps ymm9, ymm8, ymmword ptr [r14+r9*4+0x8]
vaddps ymm15, ymm14, ymmword ptr [r15+r9*4+0x8]
vaddps ymm10, ymm9, ymmword ptr [r13+r9*4+0x8]
vaddps ymm12, ymm15, ymmword ptr [rsi+r9*4+0x8]
vaddps ymm11, ymm10, ymmword ptr [r12+r9*4+0x8]
vaddps ymm13, ymm12, ymmword ptr [rdi+r9*4+0x8]
vmulps ymm6, ymm1, ymm11
vfmadd231ps ymm6, ymm2, ymmword ptr [rax+r9*4+0x8]
vfmadd231ps ymm6, ymm13, ymm0
vmovups ymmword ptr [r8+r9*4+0x8], ymm6
add r9, 0x8
cmp r9, rdx
jb 0xffffffffffffff8e
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/5;P ~ 810
L2: P <= 32768/5;P ~ 6550
L3: P <= 2359296/5;P ~ 471850
L1: 16*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P ~ 20²
L2: 16*N*P + 8*P*(N - 2) + 16*P <= 262144;N*P ~ 80²
L3: 16*N*P + 8*P*(N - 2) + 16*P <= 18874368;N*P ~ 510²
{%- endcapture -%}

{% include stencil_template.md %}
