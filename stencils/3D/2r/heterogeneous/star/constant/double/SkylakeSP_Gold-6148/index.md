---

title:  "Stencil 3D r2 star constant heterogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "2r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
comment      : "The correct way to measure L2-Memory and L3-Memory traffic is unknown, hence the prediction by kerncraft is less accurate."
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "25"
scaling      : [ "1030" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;
double c1;
double c2;
double c3;
double c4;
double c5;
double c6;
double c7;
double c8;
double c9;
double c10;
double c11;
double c12;

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
vpcmpgtq k1, ymm9, ymm8
vpaddq ymm8, ymm8, ymm18
vmovupd ymm7{k1}{z}, ymmword ptr [rsi+r15*8+0x10]
vmovupd ymm3{k1}{z}, ymmword ptr [r8+r15*8+0x10]
vmovupd ymm0{k1}{z}, ymmword ptr [rdi+r15*8]
vmovupd ymm1{k1}{z}, ymmword ptr [rdi+r15*8+0x20]
vmovupd ymm26{k1}{z}, ymmword ptr [r11+r15*8+0x10]
vmulpd ymm7, ymm24, ymm7
vmovupd ymm28{k1}{z}, ymmword ptr [rdx+r15*8+0x10]
vmovupd ymm4{k1}{z}, ymmword ptr [rdi+r15*8+0x18]
vmovupd ymm10{k1}{z}, ymmword ptr [r9+r15*8+0x10]
vmovupd ymm2{k1}{z}, ymmword ptr [rbx+r15*8+0x10]
vfmadd231pd ymm7, ymm3, ymm23
vmovupd ymm27{k1}{z}, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm29{k1}{z}, ymmword ptr [rcx+r15*8+0x10]
vmulpd ymm30, ymm12, ymm26
vmulpd ymm31, ymm11, ymm28
vmulpd ymm0, ymm16, ymm0
vmulpd ymm1, ymm15, ymm1
vmovupd ymm5{k1}{z}, ymmword ptr [rdi+r15*8+0x8]
vfmadd231pd ymm7, ymm4, ymm22
vfmadd231pd ymm30, ymm27, ymm14
vfmadd231pd ymm31, ymm29, ymm13
vfmadd231pd ymm0, ymm10, ymm25
vfmadd231pd ymm1, ymm2, ymm17
vmovupd ymm6{k1}{z}, ymmword ptr [rdi+r15*8+0x10]
vfmadd231pd ymm7, ymm5, ymm21
vaddpd ymm26, ymm30, ymm31
vaddpd ymm2, ymm0, ymm1
vfmadd231pd ymm7, ymm6, ymm20
vaddpd ymm3, ymm26, ymm2
vaddpd ymm4, ymm3, ymm7
vmovupd ymmword ptr [rax+r15*8+0x10]{k1}, ymm4
add r15, 0x4
cmp r15, r12
jb 0xfffffffffffffefa
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;P ~ 400
L2: P <= 65536/5;P ~ 13100
L3: P <= 1835008/5;P ~ 367000
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;N*P ~ 20²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 1048576;N*P ~ 80²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 29360128;N*P ~ 680²
{%- endcapture -%}

{% include stencil_template.md %}
