---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148"
flavor       : ""
compile_flags: "icc -O3 -xCORE-AVX512 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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

for ( int k = 1; k < M-1; k++ ) {
  for ( int j = 1; j < N-1; j++ ) {
    for ( int i = 1; i < P-1; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i];
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vpcmpgtd k1, xmm9, xmm10
add r11, 0x4
vpaddd xmm10, xmm10, xmm1
vmovupd ymm17{k1}{z}, ymmword ptr [rcx+r9*1+0x10]
vmovupd ymm11{k1}{z}, ymmword ptr [rcx+r10*1+0x8]
vmovupd ymm13{k1}{z}, ymmword ptr [rcx+rbx*1+0x8]
vmovupd ymm18{k1}{z}, ymmword ptr [rcx+r9*1]
vmovupd ymm12{k1}{z}, ymmword ptr [rcx+r8*1+0x8]
vmulpd ymm21, ymm5, ymm17
vmovupd ymm14{k1}{z}, ymmword ptr [rcx+rdi*1+0x8]
vmulpd ymm15, ymm2, ymm11
vmulpd ymm16, ymm0, ymm13
vmovupd ymm19{k1}{z}, ymmword ptr [rcx+r9*1+0x8]
vfmadd231pd ymm21, ymm18, ymm6
vfmadd231pd ymm15, ymm12, ymm4
vfmadd231pd ymm16, ymm14, ymm3
vfmadd231pd ymm21, ymm19, ymm7
vaddpd ymm20, ymm15, ymm16
vaddpd ymm22, ymm20, ymm21
vmovupd ymmword ptr [rcx+r13*1+0x8]{k1}, ymm22
add rcx, 0x20
cmp r11, r15
jb 0xffffffffffffff63
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 21846
L3: P <= 611670
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 1048576;181²
L3: 16*N*P + 16*P*(N - 1) <= 29360128;957²
{%- endcapture -%}

{% include stencil_template.md %}

