---

title:  "Stencil 3D r2 star variable point-symmetric float HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r2"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "variable"
datatype     : "float"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
scaling      : [ "610" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
float a[M][N][P];
float b[M][N][P];
float W[7][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   W[2][k][j][i] * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   W[3][k][j][i] * (a[k][j - 1][i] + a[k][j + 1][i]) +
                   W[4][k][j][i] * (a[k][j][i - 2] + a[k][j][i + 2]) +
                   W[5][k][j][i] * (a[k - 2][j][i] + a[k + 2][j][i]) +
                   W[6][k][j][i] * (a[k][j - 2][i] + a[k][j + 2][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
mov rsi, qword ptr [rsp+0x1f0]
vmovups ymm5, ymmword ptr [r11+r9*4+0x8]
vmovups ymm6, ymmword ptr [r14+r9*4+0x8]
vmovups ymm2, ymmword ptr [rsi+r9*4+0x8]
vmovups ymm1, ymmword ptr [rcx+r9*4+0x4]
vmovups ymm4, ymmword ptr [rcx+r9*4]
vmovups ymm0, ymmword ptr [rcx+r9*4+0x8]
vaddps ymm7, ymm5, ymmword ptr [rbx+r9*4+0x8]
vaddps ymm9, ymm6, ymmword ptr [r15+r9*4+0x8]
vaddps ymm14, ymm1, ymmword ptr [rcx+r9*4+0xc]
vaddps ymm10, ymm4, ymmword ptr [rcx+r9*4+0x10]
vmulps ymm11, ymm7, ymmword ptr [r12+r9*4+0x8]
vmulps ymm12, ymm9, ymmword ptr [r10+r9*4+0x8]
mov rsi, qword ptr [rsp+0x1e8]
vfmadd231ps ymm12, ymm10, ymmword ptr [r13+r9*4+0x8]
vaddps ymm13, ymm2, ymmword ptr [rsi+r9*4+0x8]
mov rsi, qword ptr [rsp+0x1f8]
vmulps ymm1, ymm13, ymmword ptr [r8+r9*4+0x8]
vmovups ymm3, ymmword ptr [rsi+r9*4+0x8]
vfmadd231ps ymm1, ymm14, ymmword ptr [rdx+r9*4+0x8]
vaddps ymm8, ymm3, ymmword ptr [rdi+r9*4+0x8]
mov rsi, qword ptr [rsp+0x200]
vfmadd231ps ymm11, ymm8, ymmword ptr [rsi+r9*4+0x8]
mov rsi, qword ptr [rsp+0x1c8]
vaddps ymm15, ymm11, ymm12
vfmadd231ps ymm1, ymm0, ymmword ptr [rsi+r9*4+0x8]
vaddps ymm0, ymm15, ymm1
vmovups ymmword ptr [rax+r9*4+0x8], ymm0
add r9, 0x8
cmp r9, qword ptr [rsp+0x1a0]
jb 0xffffffffffffff31
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 8192/17;P <= 480
L2: P <= 65536/17;P <= 3850
L3: P <= 4718592/17;P <= 277560
L1: 44*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P <= 20²
L2: 44*N*P + 8*P*(N - 2) + 16*P <= 262144;N*P <= 50²
L3: 44*N*P + 8*P*(N - 2) + 16*P <= 18874368;N*P <= 590²
{%- endcapture -%}

{% include stencil_template.md %}
