---

title:  "Stencil 3D r1 star constant isotropic double SkylakeSP_Gold-6148"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "8"
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

for (long k = 1; k < M - 1; ++k) {
  for (long j = 1; j < N - 1; ++j) {
    for (long i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          c0 * a[k][j][i] + c1 * ((a[k][j][i - 1] + a[k][j][i + 1]) +
                                  (a[k - 1][j][i] + a[k + 1][j][i]) +
                                  (a[k][j - 1][i] + a[k][j + 1][i]));
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm5, ymmword ptr [r11+r13*8+0x10]
vmovupd ymm10, ymmword ptr [r11+r13*8+0x8]
vmovupd ymm4, ymmword ptr [r11+r13*8]
vaddpd ymm4, ymm4, ymm5
vaddpd ymm5, ymm4, ymmword ptr [r10+r13*8+0x8]
vaddpd ymm6, ymm5, ymmword ptr [rax+r13*8+0x8]
vaddpd ymm7, ymm6, ymmword ptr [rdx+r13*8+0x8]
vaddpd ymm8, ymm7, ymmword ptr [r15+r13*8+0x8]
vmulpd ymm9, ymm0, ymm8
vfmadd231pd ymm9, ymm10, ymm1
vmovupd ymmword ptr [r14+r13*8+0x8], ymm9
vmovupd ymm5, ymmword ptr [r11+r13*8+0x30]
vmovupd ymm10, ymmword ptr [r11+r13*8+0x28]
vmovupd ymm4, ymmword ptr [r11+r13*8+0x20]
vaddpd ymm4, ymm4, ymm5
vaddpd ymm5, ymm4, ymmword ptr [r10+r13*8+0x28]
vaddpd ymm6, ymm5, ymmword ptr [rax+r13*8+0x28]
vaddpd ymm7, ymm6, ymmword ptr [rdx+r13*8+0x28]
vaddpd ymm8, ymm7, ymmword ptr [r15+r13*8+0x28]
vmulpd ymm9, ymm0, ymm8
vfmadd231pd ymm9, ymm10, ymm1
vmovupd ymmword ptr [r14+r13*8+0x28], ymm9
vmovupd ymm5, ymmword ptr [r11+r13*8+0x50]
vmovupd ymm10, ymmword ptr [r11+r13*8+0x48]
vmovupd ymm4, ymmword ptr [r11+r13*8+0x40]
vaddpd ymm4, ymm4, ymm5
vaddpd ymm5, ymm4, ymmword ptr [r10+r13*8+0x48]
vaddpd ymm6, ymm5, ymmword ptr [rax+r13*8+0x48]
vaddpd ymm7, ymm6, ymmword ptr [rdx+r13*8+0x48]
vaddpd ymm8, ymm7, ymmword ptr [r15+r13*8+0x48]
vmulpd ymm9, ymm0, ymm8
vfmadd231pd ymm9, ymm10, ymm1
vmovupd ymmword ptr [r14+r13*8+0x48], ymm9
vmovupd ymm5, ymmword ptr [r11+r13*8+0x70]
vmovupd ymm10, ymmword ptr [r11+r13*8+0x68]
vmovupd ymm4, ymmword ptr [r11+r13*8+0x60]
vaddpd ymm4, ymm4, ymm5
vaddpd ymm5, ymm4, ymmword ptr [r10+r13*8+0x68]
vaddpd ymm6, ymm5, ymmword ptr [rax+r13*8+0x68]
vaddpd ymm7, ymm6, ymmword ptr [rdx+r13*8+0x68]
vaddpd ymm8, ymm7, ymmword ptr [r15+r13*8+0x68]
vmulpd ymm9, ymm0, ymm8
vfmadd231pd ymm9, ymm10, ymm1
vmovupd ymmword ptr [r14+r13*8+0x68], ymm9
add r13, 0x10
cmp r13, rbx
jb 0xfffffffffffffee2
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3;P ~ 680
L2: P <= 21846;P ~ 21840
L3: P <= 611670;P ~ 611670
L1: 16*N*P + 16*P*(N - 1) <= 32768;N*P ~ 30²
L2: 16*N*P + 16*P*(N - 1) <= 1048576;N*P ~ 180²
L3: 16*N*P + 16*P*(N - 1) <= 29360128;N*P ~ 950²
{%- endcapture -%}

{% include stencil_template.md %}
