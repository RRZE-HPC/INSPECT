---

title:  "Stencil 3D r1 star constant point-symmetric double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r1"
weighting    : "point-symmetric"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "10"
scaling      : [ "1440" ]
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

for (long k = 1; k < M - 1; ++k) {
  for (long j = 1; j < N - 1; ++j) {
    for (long i = 1; i < P - 1; ++i) {
      b[k][j][i] = c0 * a[k][j][i] +
                   c1 * (a[k][j][i - 1] + a[k][j][i + 1]) +
                   c2 * (a[k - 1][j][i] + a[k + 1][j][i]) +
                   c3 * (a[k][j - 1][i] + a[k][j + 1][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm10, ymm11
vpaddq ymm11, ymm11, ymm7
vmovupd ymm12{k1}{z}, ymmword ptr [r8+r12*8]
vmovupd ymm13{k1}{z}, ymmword ptr [r8+r12*8+0x10]
vmovupd ymm15{k1}{z}, ymmword ptr [r8+r12*8+0x8]
vmovupd ymm16{k1}{z}, ymmword ptr [rsi+r12*8+0x8]
vmovupd ymm17{k1}{z}, ymmword ptr [r15+r12*8+0x8]
vmovupd ymm19{k1}{z}, ymmword ptr [rbx+r12*8+0x8]
vmovupd ymm20{k1}{z}, ymmword ptr [r14+r12*8+0x8]
vaddpd ymm14, ymm12, ymm13
vaddpd ymm18, ymm16, ymm17
vaddpd ymm21, ymm19, ymm20
vmulpd ymm22, ymm2, ymm14
vfmadd231pd ymm22, ymm15, ymm3
vfmadd231pd ymm22, ymm18, ymm1
vfmadd231pd ymm22, ymm21, ymm0
vmovupd ymmword ptr [r13+r12*8+0x8]{k1}, ymm22
add r12, 0x4
cmp r12, rax
jb 0xffffffffffffff72
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3;P <= 680
L2: P <= 21846;P <= 21840
L3: P <= 611670;P <= 611670
L1: 16*N*P + 16*P*(N - 1) <= 32768;N*P <= 30²
L2: 16*N*P + 16*P*(N - 1) <= 1048576;N*P <= 180²
L3: 16*N*P + 16*P*(N - 1) <= 29360128;N*P <= 950²
{%- endcapture -%}

{% include stencil_template.md %}
