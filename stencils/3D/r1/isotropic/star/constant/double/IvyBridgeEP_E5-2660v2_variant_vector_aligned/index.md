---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r1"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : "with pragma vector aligned"
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for(int k=1; k < M-1; k++){
  for(int j=1; j < N-1; j++){
#pragma vector aligned
    for(int i=1; i < P-1; i++){
      b[k][j][i] = c0 * (a[k][j][i]
        + a[k][j][i-1] + a[k][j][i+1]
        + a[k-1][j][i] + a[k+1][j][i]
        + a[k][j-1][i] + a[k][j+1][i]
        );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmovupd xmm1, xmmword ptr [rax+rcx*1+0x8]
add esi, 0x1
vbroadcastsd ymm0, qword ptr [rsp+0x120]
vinsertf128 ymm1, ymm1, xmmword ptr [rax+rcx*1+0x18], 0x1
vmovupd xmm2, xmmword ptr [rax+rcx*1]
vmulpd ymm1, ymm1, ymm0
vmovupd xmm0, xmmword ptr [rax+rcx*1+0x10]
vinsertf128 ymm2, ymm2, xmmword ptr [rax+rcx*1+0x10], 0x1
vmovupd xmm3, xmmword ptr [r13+rcx*1+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [rax+rcx*1+0x20], 0x1
vaddpd ymm2, ymm2, ymm0
vmovupd xmm0, xmmword ptr [r15+rcx*1+0x8]
vinsertf128 ymm3, ymm3, xmmword ptr [r13+rcx*1+0x18], 0x1
vinsertf128 ymm0, ymm0, xmmword ptr [r15+rcx*1+0x18], 0x1
vaddpd ymm0, ymm3, ymm0
vmovupd xmm3, xmmword ptr [r14+rcx*1+0x8]
vinsertf128 ymm3, ymm3, xmmword ptr [r14+rcx*1+0x18], 0x1
vaddpd ymm2, ymm2, ymm0
vmovupd xmm0, xmmword ptr [r10+rcx*1+0x8]
vinsertf128 ymm0, ymm0, xmmword ptr [r10+rcx*1+0x18], 0x1
vaddpd ymm0, ymm3, ymm0
vaddpd ymm0, ymm2, ymm0
vbroadcastsd ymm2, qword ptr [rsp+0x140]
vmulpd ymm0, ymm0, ymm2
vaddpd ymm0, ymm1, ymm0
vmovupd xmmword ptr [rdi+rcx*1+0x8], xmm0
vextractf128 xmmword ptr [rdi+rcx*1+0x18], ymm0, 0x1
add rcx, 0x20
cmp esi, dword ptr [rsp+0x84]
jb 0xffffffffffffff4b
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

