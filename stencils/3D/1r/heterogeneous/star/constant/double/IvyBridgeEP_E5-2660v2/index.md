---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : ""
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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
vmulpd ymm14, ymm8, ymmword ptr [rsi+r9*8+0x8]
vmulpd ymm15, ymm7, ymmword ptr [rsi+r9*8]
vaddpd ymm14, ymm14, ymm15
vmulpd ymm15, ymm6, ymmword ptr [rsi+r9*8+0x10]
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r12+r9*8+0x8]
vinsertf128 ymm14, ymm14, xmmword ptr [r12+r9*8+0x18], 0x1
vmulpd ymm14, ymm13, ymm14
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r13+r9*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [r13+r9*8+0x18], 0x1
vmulpd ymm15, ymm1, ymm15
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r11+r9*8+0x8]
vinsertf128 ymm14, ymm14, xmmword ptr [r11+r9*8+0x18], 0x1
vmulpd ymm14, ymm2, ymm14
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [rbx+r9*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [rbx+r9*8+0x18], 0x1
vmulpd ymm15, ymm0, ymm15
vaddpd ymm14, ymm14, ymm15
vmovupd ymmword ptr [r10+r9*8+0x8], ymm14
add r9, 0x4
cmp r9, rax
jb 0xffffffffffffff70
{%- endcapture -%}


{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 5462
L3: P <= 546134
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 262144;90²
L3: 16*N*P + 16*P*(N - 1) <= 26214400;905²
{%- endcapture -%}

{% include stencil_template.md %}
