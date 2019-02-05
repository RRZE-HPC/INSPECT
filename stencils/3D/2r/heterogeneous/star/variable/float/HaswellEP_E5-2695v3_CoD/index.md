---

title:  "Stencil 3D r2 star variable heterogeneous float HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "float"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "25"
scaling      : [ "510" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
float a[M][N][P];
float b[M][N][P];
float W[13][M][N][P];

for (long k = 2; k < M - 2; ++k) {
  for (long j = 2; j < N - 2; ++j) {
    for (long i = 2; i < P - 2; ++i) {
      b[k][j][i] = W[0][k][j][i] * a[k][j][i] +
                   W[1][k][j][i] * a[k][j][i - 1] +
                   W[2][k][j][i] * a[k][j][i + 1] +
                   W[3][k][j][i] * a[k - 1][j][i] +
                   W[4][k][j][i] * a[k + 1][j][i] +
                   W[5][k][j][i] * a[k][j - 1][i] +
                   W[6][k][j][i] * a[k][j + 1][i] +
                   W[7][k][j][i] * a[k][j][i - 2] +
                   W[8][k][j][i] * a[k][j][i + 2] +
                   W[9][k][j][i] * a[k - 2][j][i] +
                   W[10][k][j][i] * a[k + 2][j][i] +
                   W[11][k][j][i] * a[k][j - 2][i] +
                   W[12][k][j][i] * a[k][j + 2][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
mov rdi, qword ptr [rsp+0x230]
vmovups ymm8, ymmword ptr [r11+r14*4+0x8]
vmovups ymm0, ymmword ptr [r15+r14*4+0x8]
vmovups ymm3, ymmword ptr [rdi+r14*4+0x8]
vmovups ymm1, ymmword ptr [rcx+r14*4+0x8]
vmovups ymm2, ymmword ptr [r9+r14*4+0x8]
vmulps ymm12, ymm8, ymmword ptr [r13+r14*4+0x8]
vmovups ymm10, ymmword ptr [rax+r14*4+0x8]
vmovups ymm4, ymmword ptr [r8+r14*4+0xc]
vmovups ymm11, ymmword ptr [r12+r14*4+0x8]
vmovups ymm5, ymmword ptr [r8+r14*4+0x4]
vmovups ymm6, ymmword ptr [r8+r14*4+0x8]
vmulps ymm13, ymm10, ymmword ptr [r10+r14*4+0x8]
mov rdi, qword ptr [rsp+0x228]
vfmadd231ps ymm13, ymm11, ymmword ptr [rsi+r14*4+0x8]
vmovups ymm7, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x208]
vmovups ymm14, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x220]
vmulps ymm15, ymm14, ymmword ptr [r8+r14*4]
vmovups ymm9, ymmword ptr [rdi+r14*4+0x8]
vfmadd231ps ymm15, ymm0, ymmword ptr [rbx+r14*4+0x8]
vmulps ymm0, ymm1, ymmword ptr [r8+r14*4+0x10]
mov rdi, qword ptr [rsp+0x280]
vfmadd231ps ymm12, ymm9, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x200]
vaddps ymm8, ymm12, ymm13
vfmadd231ps ymm0, ymm2, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x268]
vaddps ymm1, ymm15, ymm0
vmulps ymm2, ymm7, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x270]
vfmadd231ps ymm2, ymm3, ymmword ptr [rdi+r14*4+0x8]
vaddps ymm3, ymm8, ymm1
mov rdi, qword ptr [rsp+0x278]
vfmadd231ps ymm2, ymm4, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x260]
vfmadd231ps ymm2, ymm5, ymmword ptr [rdi+r14*4+0x8]
mov rdi, qword ptr [rsp+0x210]
vfmadd231ps ymm2, ymm6, ymmword ptr [rdi+r14*4+0x8]
vaddps ymm4, ymm3, ymm2
vmovups ymmword ptr [rdx+r14*4+0x8], ymm4
add r14, 0x8
cmp r14, qword ptr [rsp+0x1f8]
jb 0xfffffffffffffecf
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 8192/23;P ~ 350
L2: P <= 65536/23;P ~ 2840
L3: P <= 4718592/23;P ~ 205150
L1: 68*N*P + 8*P*(N - 2) + 16*P <= 32768;N*P ~ 20²
L2: 68*N*P + 8*P*(N - 2) + 16*P <= 262144;N*P ~ 50²
L3: 68*N*P + 8*P*(N - 2) + 16*P <= 18874368;N*P ~ 480²
{%- endcapture -%}

{% include stencil_template.md %}
