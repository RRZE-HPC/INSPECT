---

title:  "Stencil 3D r2 star constant heterogeneous float HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "float"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "25"
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
float c3;
float c4;
float c5;
float c6;
float c7;
float c8;
float c9;
float c10;
float c11;
float c12;

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = c0 * a[k][j][i] + c1 * a[k][j][i - 1] +
                   c2 * a[k][j][i + 1] + c3 * a[k - 1][j][i] +
                   c4 * a[k + 1][j][i] + c5 * a[k][j - 1][i] +
                   c6 * a[k][j + 1][i] + c7 * a[k][j][i - 2] +
                   c8 * a[k][j][i + 2] + c9 * a[k - 2][j][i] +
                   c10 * a[k + 2][j][i] + c11 * a[k][j - 2][i] +
                   c12 * a[k][j + 2][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmulps ymm14, ymm2, ymmword ptr [rsi+r9*4+0x8]
vmulps ymm15, ymm1, ymmword ptr [rdi+r9*4+0x8]
vfmadd231ps ymm14, ymm4, ymmword ptr [r11+r9*4+0x8]
vfmadd231ps ymm15, ymm3, ymmword ptr [r15+r9*4+0x8]
vaddps ymm0, ymm14, ymm15
vmulps ymm14, ymm6, ymmword ptr [rax+r9*4]
vmulps ymm15, ymm5, ymmword ptr [rax+r9*4+0x10]
vfmadd231ps ymm14, ymm8, ymmword ptr [r13+r9*4+0x8]
vfmadd231ps ymm15, ymm7, ymmword ptr [r12+r9*4+0x8]
vaddps ymm14, ymm14, ymm15
vaddps ymm0, ymm0, ymm14
vmulps ymm14, ymm9, ymmword ptr [r14+r9*4+0x8]
vfmadd231ps ymm14, ymm10, ymmword ptr [r10+r9*4+0x8]
vfmadd231ps ymm14, ymm11, ymmword ptr [rax+r9*4+0xc]
vfmadd231ps ymm14, ymm12, ymmword ptr [rax+r9*4+0x4]
vfmadd231ps ymm14, ymm13, ymmword ptr [rax+r9*4+0x8]
vaddps ymm0, ymm0, ymm14
vmovups ymmword ptr [r8+r9*4+0x8], ymm0
add r9, 0x8
cmp r9, rdx
jb 0xffffffffffffff84
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
