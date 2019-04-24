---

title:  "Stencil 3D r3 star constant homogeneous double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r3"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "19"
scaling      : [ "580" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for (long k = 3; k < M - 3; ++k) {
  for (long j = 3; j < N - 3; ++j) {
    for (long i = 3; i < P - 3; ++i) {
      b[k][j][i] =
          c0 * (a[k][j][i] + a[k][j][i - 1] + a[k][j][i + 1] +
                a[k - 1][j][i] + a[k + 1][j][i] + a[k][j - 1][i] +
                a[k][j + 1][i] + a[k][j][i - 2] + a[k][j][i + 2] +
                a[k - 2][j][i] + a[k + 2][j][i] + a[k][j - 2][i] +
                a[k][j + 2][i] + a[k][j][i - 3] + a[k][j][i + 3] +
                a[k - 3][j][i] + a[k + 3][j][i] + a[k][j - 3][i] +
                a[k][j + 3][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm7, ymmword ptr [rcx+rdi*8+0x18]
vmovupd ymm1, ymmword ptr [rcx+rdi*8+0x30]
vmovupd ymm3, ymmword ptr [rcx+rdi*8+0x28]
vmovupd ymm8, ymmword ptr [rcx+rdi*8+0x20]
vmovupd ymm11, ymmword ptr [r8+rdi*8+0x18]
vmovupd ymm12, ymmword ptr [r12+rdi*8+0x18]
vmovupd ymm0, ymmword ptr [r10+rdi*8+0x18]
vmovupd ymm2, ymmword ptr [rax+rdi*8+0x18]
vmovupd ymm4, ymmword ptr [r15+rdi*8+0x18]
vaddpd ymm9, ymm7, ymmword ptr [rcx+rdi*8+0x10]
vaddpd ymm14, ymm12, ymmword ptr [rcx+rdi*8+0x8]
vaddpd ymm2, ymm2, ymmword ptr [rcx+rdi*8]
vaddpd ymm10, ymm8, ymmword ptr [rsi+rdi*8+0x18]
vaddpd ymm13, ymm11, ymmword ptr [r13+rdi*8+0x18]
vaddpd ymm3, ymm3, ymmword ptr [r11+rdi*8+0x18]
vaddpd ymm0, ymm0, ymmword ptr [r14+rdi*8+0x18]
vaddpd ymm1, ymm1, ymmword ptr [r9+rdi*8+0x18]
vaddpd ymm15, ymm9, ymm10
vaddpd ymm7, ymm13, ymm14
vaddpd ymm8, ymm3, ymm0
vaddpd ymm9, ymm2, ymm1
vaddpd ymm10, ymm15, ymm7
vaddpd ymm4, ymm4, ymmword ptr [rbx+rdi*8+0x18]
vaddpd ymm11, ymm8, ymm9
mov rdx, qword ptr [rsp+0x188]
vaddpd ymm12, ymm10, ymm11
vaddpd ymm13, ymm4, ymmword ptr [rdx+rdi*8+0x18]
vaddpd ymm14, ymm12, ymm13
vmulpd ymm15, ymm5, ymm14
mov rdx, qword ptr [rsp+0x178]
vmovupd ymmword ptr [rdx+rdi*8+0x18], ymm15
add rdi, 0x4
cmp rdi, qword ptr [rsp+0x160]
jb 0xffffffffffffff3b
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P <= 290
L2: P <= 16384/7;P <= 2340
L3: P <= 1179648/7;P <= 168520
L1: 48*P + 16*P*(N - 3) + 48*P <= 32768;N*P <= 10²
L2: 48*P + 16*P*(N - 3) + 48*P <= 262144;N*P <= 60²
L3: 48*P + 16*P*(N - 3) + 48*P <= 18874368;N*P <= 380²
{%- endcapture -%}

{% include stencil_template.md %}
