---

title:  "Stencil 3D r2 star variable homogeneous double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r2"
weighting    : "homogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "660" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[1][M][N][P];

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
vmovupd ymm1, ymmword ptr [rax+r8*8+0x18]
vmovupd ymm0, ymmword ptr [rax+r8*8+0x10]
vmovupd ymm10, ymmword ptr [rax+r8*8+0x20]
vmovupd ymm4, ymmword ptr [r13+r8*8+0x10]
vmovupd ymm5, ymmword ptr [r11+r8*8+0x10]
vmovupd ymm11, ymmword ptr [r9+r8*8+0x10]
vaddpd ymm2, ymm0, ymmword ptr [rax+r8*8+0x8]
vaddpd ymm7, ymm5, ymmword ptr [rax+r8*8]
vaddpd ymm3, ymm1, ymmword ptr [r14+r8*8+0x10]
vaddpd ymm6, ymm4, ymmword ptr [r12+r8*8+0x10]
vaddpd ymm12, ymm10, ymmword ptr [r15+r8*8+0x10]
vaddpd ymm13, ymm11, ymmword ptr [rbx+r8*8+0x10]
vaddpd ymm8, ymm2, ymm3
vaddpd ymm9, ymm6, ymm7
vaddpd ymm14, ymm12, ymm13
vaddpd ymm15, ymm8, ymm9
vaddpd ymm0, ymm14, ymmword ptr [rsi+r8*8+0x10]
vaddpd ymm1, ymm15, ymm0
vmulpd ymm2, ymm1, ymmword ptr [r10+r8*8+0x10]
vmovupd ymmword ptr [rdi+r8*8+0x10], ymm2
add r8, 0x4
cmp r8, rdx
jb 0xffffffffffffff7b
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/11;P <= 370
L2: P <= 32768/11;P <= 2970
L3: P <= 2359296/11;P <= 214480
L1: 40*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P <= 10²
L2: 40*N*P + 16*P*(N - 2) + 32*P <= 262144;N*P <= 50²
L3: 40*N*P + 16*P*(N - 2) + 32*P <= 18874368;N*P <= 430²
{%- endcapture -%}

{% include stencil_template.md %}
