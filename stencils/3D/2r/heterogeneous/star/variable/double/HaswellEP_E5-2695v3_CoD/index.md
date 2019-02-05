---

title:  "Stencil 3D r2 star variable heterogeneous double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "25"
scaling      : [ "490" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[13][M][N][P];

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
vmovupd ymm8, ymmword ptr [r13+r14*8+0x10]
vmovupd ymm0, ymmword ptr [r15+r14*8+0x10]
vmovupd ymm3, ymmword ptr [rdi+r14*8+0x10]
vmovupd ymm9, ymmword ptr [rsi+r14*8+0x10]
vmovupd ymm2, ymmword ptr [r9+r14*8+0x10]
vmulpd ymm12, ymm8, ymmword ptr [rax+r14*8+0x10]
vmovupd ymm10, ymmword ptr [rcx+r14*8+0x10]
vmovupd ymm4, ymmword ptr [r8+r14*8+0x18]
vmovupd ymm11, ymmword ptr [r11+r14*8+0x10]
vmovupd ymm5, ymmword ptr [r8+r14*8+0x8]
vmovupd ymm6, ymmword ptr [r8+r14*8+0x10]
vmulpd ymm13, ymm10, ymmword ptr [r10+r14*8+0x10]
mov rdi, qword ptr [rsp+0x228]
vfmadd231pd ymm13, ymm11, ymmword ptr [r12+r14*8+0x10]
vmovupd ymm7, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x208]
vmovupd ymm14, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x280]
vmulpd ymm15, ymm14, ymmword ptr [r8+r14*8]
vmovupd ymm1, ymmword ptr [rdi+r14*8+0x10]
vfmadd231pd ymm15, ymm0, ymmword ptr [rbx+r14*8+0x10]
vmulpd ymm0, ymm1, ymmword ptr [r8+r14*8+0x20]
mov rdi, qword ptr [rsp+0x220]
vfmadd231pd ymm12, ymm9, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x200]
vaddpd ymm8, ymm12, ymm13
vfmadd231pd ymm0, ymm2, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x268]
vaddpd ymm1, ymm15, ymm0
vmulpd ymm2, ymm7, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x270]
vfmadd231pd ymm2, ymm3, ymmword ptr [rdi+r14*8+0x10]
vaddpd ymm3, ymm8, ymm1
mov rdi, qword ptr [rsp+0x278]
vfmadd231pd ymm2, ymm4, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x260]
vfmadd231pd ymm2, ymm5, ymmword ptr [rdi+r14*8+0x10]
mov rdi, qword ptr [rsp+0x210]
vfmadd231pd ymm2, ymm6, ymmword ptr [rdi+r14*8+0x10]
vaddpd ymm4, ymm3, ymm2
vmovupd ymmword ptr [rdx+r14*8+0x10], ymm4
add r14, 0x4
cmp r14, qword ptr [rsp+0x1f0]
jb 0xfffffffffffffecf
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4096/23;P ~ 170
L2: P <= 32768/23;P ~ 1420
L3: P <= 2359296/23;P ~ 102570
L1: 136*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P ~ 10²
L2: 136*N*P + 16*P*(N - 2) + 32*P <= 262144;N*P ~ 40²
L3: 136*N*P + 16*P*(N - 2) + 32*P <= 18874368;N*P ~ 320²
{%- endcapture -%}

{% include stencil_template.md %}
