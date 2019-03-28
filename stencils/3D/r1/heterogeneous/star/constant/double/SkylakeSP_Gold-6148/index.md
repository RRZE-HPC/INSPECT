---

title:  "Stencil 3D r1 star constant heterogeneous double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "r1"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
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
double c4;
double c5;
double c6;

for (long k = 1; k < M - 1; ++k) {
  for (long j = 1; j < N - 1; ++j) {
    for (long i = 1; i < P - 1; ++i) {
      b[k][j][i] = c0 * a[k][j][i] + c1 * a[k][j][i - 1] +
                   c2 * a[k][j][i + 1] + c3 * a[k - 1][j][i] +
                   c4 * a[k + 1][j][i] + c5 * a[k][j - 1][i] +
                   c6 * a[k][j + 1][i];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtq k1, ymm9, ymm10
vpaddq ymm10, ymm10, ymm8
vmovupd ymm17{k1}{z}, ymmword ptr [r10+r15*8+0x10]
vmovupd ymm11{k1}{z}, ymmword ptr [rcx+r15*8+0x8]
vmovupd ymm13{k1}{z}, ymmword ptr [rax+r15*8+0x8]
vmovupd ymm18{k1}{z}, ymmword ptr [r10+r15*8]
vmovupd ymm12{k1}{z}, ymmword ptr [r9+r15*8+0x8]
vmulpd ymm21, ymm4, ymm17
vmovupd ymm14{k1}{z}, ymmword ptr [rdx+r15*8+0x8]
vmulpd ymm15, ymm1, ymm11
vmulpd ymm16, ymm0, ymm13
vmovupd ymm19{k1}{z}, ymmword ptr [r10+r15*8+0x8]
vfmadd231pd ymm21, ymm18, ymm5
vfmadd231pd ymm15, ymm12, ymm3
vfmadd231pd ymm16, ymm14, ymm2
vfmadd231pd ymm21, ymm19, ymm6
vaddpd ymm20, ymm15, ymm16
vaddpd ymm22, ymm20, ymm21
vmovupd ymmword ptr [r13+r15*8+0x8]{k1}, ymm22
add r15, 0x4
cmp r15, r14
jb 0xffffffffffffff66
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
