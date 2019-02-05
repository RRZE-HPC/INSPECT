---

title:  "Stencil 3D r2 star variable homogeneous float HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "homogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "float"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "880" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
float a[M][N][P];
float b[M][N][P];
float W[1][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] *
                   (a[k][j][i] + a[k][j][i - 1] + a[k][j][i + 1] +
                    a[k - 1][j][i] + a[k + 1][j][i] + a[k][j - 1][i] +
                    a[k][j + 1][i] + a[k][j][i - 2] + a[k][j][i + 2] +
                    a[k - 2][j][i] + a[k + 2][j][i] + a[k][j - 2][i] +
                    a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovups ymm10, ymmword ptr [rax+r8*4+0x10]
vmovups ymm1, ymmword ptr [rax+r8*4+0xc]
vmovups ymm0, ymmword ptr [rax+r8*4+0x8]
vmovups ymm4, ymmword ptr [r13+r8*4+0x8]
vmovups ymm5, ymmword ptr [r11+r8*4+0x8]
vmovups ymm11, ymmword ptr [r9+r8*4+0x8]
vaddps ymm2, ymm0, ymmword ptr [rax+r8*4+0x4]
vaddps ymm7, ymm5, ymmword ptr [rax+r8*4]
vaddps ymm3, ymm1, ymmword ptr [r14+r8*4+0x8]
vaddps ymm6, ymm4, ymmword ptr [r12+r8*4+0x8]
vaddps ymm12, ymm10, ymmword ptr [r15+r8*4+0x8]
vaddps ymm13, ymm11, ymmword ptr [rbx+r8*4+0x8]
vaddps ymm8, ymm2, ymm3
vaddps ymm9, ymm6, ymm7
vaddps ymm14, ymm12, ymm13
vaddps ymm15, ymm8, ymm9
vaddps ymm0, ymm14, ymmword ptr [rsi+r8*4+0x8]
vaddps ymm1, ymm15, ymm0
vmulps ymm2, ymm1, ymmword ptr [r10+r8*4+0x8]
vmovups ymmword ptr [rdi+r8*4+0x8], ymm2
add r8, 0x8
cmp r8, rdx
jb 0xffffffffffffff7b
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 8192/11;P ~ 740
L2: P <= 65536/11;P ~ 5950
L3: P <= 4718592/11;P ~ 428960
L1: 20*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P ~ 20²
L2: 20*N*P + 8*P*(N - 2) + 16*P <= 262144;N*P ~ 70²
L3: 20*N*P + 8*P*(N - 2) + 16*P <= 18874368;N*P ~ 650²
{%- endcapture -%}

{% include stencil_template.md %}
