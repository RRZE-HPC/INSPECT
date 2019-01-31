---

title:  "Stencil 3D r1 box variable homogeneous double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "1r"
weighting    : "homogeneous"
kind         : "box"
coefficients : "variable"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "27"
scaling      : [ "1140" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[1][M][N][P];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          W[0][k][j][i] *
          (a[k][j][i] + a[k - 1][j - 1][i - 1] + a[k][j - 1][i - 1] +
           a[k + 1][j - 1][i - 1] + a[k - 1][j][i - 1] +
           a[k][j][i - 1] + a[k + 1][j][i - 1] +
           a[k - 1][j + 1][i - 1] + a[k][j + 1][i - 1] +
           a[k + 1][j + 1][i - 1] + a[k - 1][j - 1][i] +
           a[k][j - 1][i] + a[k + 1][j - 1][i] + a[k - 1][j][i] +
           a[k + 1][j][i] + a[k - 1][j + 1][i] + a[k][j + 1][i] +
           a[k + 1][j + 1][i] + a[k - 1][j - 1][i + 1] +
           a[k][j - 1][i + 1] + a[k + 1][j - 1][i + 1] +
           a[k - 1][j][i + 1] + a[k][j][i + 1] + a[k + 1][j][i + 1] +
           a[k - 1][j + 1][i + 1] + a[k][j + 1][i + 1] +
           a[k + 1][j + 1][i + 1]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm7, ymmword ptr [rsi+r12*8+0x10]
vmovupd ymm11, ymmword ptr [rsi+r12*8+0x8]
vmovupd ymm6, ymmword ptr [rbx+r12*8+0x10]
vmovupd ymm2, ymmword ptr [rbx+r12*8+0x8]
vmovupd ymm12, ymmword ptr [rcx+r12*8]
vmovupd ymm8, ymmword ptr [rdi+r12*8+0x10]
vmovupd ymm4, ymmword ptr [rdi+r12*8+0x8]
vmovupd ymm15, ymmword ptr [rdx+r12*8]
vmovupd ymm3, ymmword ptr [r13+r12*8+0x8]
vmovupd ymm1, ymmword ptr [r13+r12*8]
vmovupd ymm10, ymmword ptr [r14+r12*8+0x8]
vmovupd ymm5, ymmword ptr [r14+r12*8]
vmovupd ymm9, ymmword ptr [r8+r12*8+0x10]
vaddpd ymm1, ymm1, ymmword ptr [r8+r12*8]
vaddpd ymm3, ymm3, ymmword ptr [r8+r12*8+0x8]
vaddpd ymm13, ymm11, ymmword ptr [rbx+r12*8]
vaddpd ymm14, ymm12, ymmword ptr [rdi+r12*8]
vaddpd ymm0, ymm15, ymmword ptr [rsi+r12*8]
vaddpd ymm5, ymm5, ymmword ptr [r11+r12*8]
vaddpd ymm10, ymm10, ymmword ptr [r11+r12*8+0x8]
vaddpd ymm2, ymm2, ymmword ptr [rcx+r12*8+0x8]
vaddpd ymm6, ymm6, ymmword ptr [rcx+r12*8+0x10]
vaddpd ymm4, ymm4, ymmword ptr [rdx+r12*8+0x8]
vaddpd ymm8, ymm8, ymmword ptr [rdx+r12*8+0x10]
vaddpd ymm7, ymm7, ymmword ptr [r13+r12*8+0x10]
vaddpd ymm11, ymm13, ymm14
vaddpd ymm12, ymm0, ymm1
vaddpd ymm13, ymm5, ymm2
vaddpd ymm14, ymm4, ymm3
vaddpd ymm6, ymm10, ymm6
vaddpd ymm7, ymm8, ymm7
vaddpd ymm9, ymm9, ymmword ptr [r14+r12*8+0x10]
vaddpd ymm0, ymm11, ymm12
vaddpd ymm15, ymm13, ymm14
vaddpd ymm8, ymm6, ymm7
vaddpd ymm6, ymm9, ymmword ptr [r11+r12*8+0x10]
vaddpd ymm0, ymm0, ymm15
vaddpd ymm1, ymm8, ymm6
vaddpd ymm2, ymm0, ymm1
vmulpd ymm3, ymm2, ymmword ptr [rax+r12*8+0x8]
vmovupd ymmword ptr [r15+r12*8+0x8], ymm3
add r12, 0x4
cmp r12, r9
jb 0xffffffffffffff02
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4100/11;P ~ 370
L2: P <= 32772/11;P ~ 2970
L3: P <= 2883588/11;P ~ 262140
L1: 40*N*P - 32*P - 32 <= 32768;N*P ~ 20²
L2: 40*N*P - 32*P - 32 <= 262144;N*P ~ 80²
L3: 40*N*P - 32*P - 32 <= 23068672;N*P ~ 750²
{%- endcapture -%}

{% include stencil_template.md %}
