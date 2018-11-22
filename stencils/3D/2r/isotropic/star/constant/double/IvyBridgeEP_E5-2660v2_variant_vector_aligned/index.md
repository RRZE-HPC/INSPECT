---

title:  "Stencil detail"

dimension    : "3D"
radius       : "2r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : "with pragma vector aligned"
comment      : "In order to generate optimal code the (intel) compiler needs a hint for the inner loop: `#pragma vector aligned`"
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for(int k=2; k < M-2; k++){
  for(int j=2; j < N-2; j++){
#pragma vector aligned
    for(int i=2; i < P-2; i++){
      b[k][j][i] = c0 * (a[k][j][i]
        + a[k][j][i-1] + a[k][j][i+1]
        + a[k-1][j][i] + a[k+1][j][i]
        + a[k][j-1][i] + a[k][j+1][i]
        + a[k][j][i-2] + a[k][j][i+2]
        + a[k-2][j][i] + a[k+2][j][i]
        + a[k][j-2][i] + a[k][j+2][i]
        );
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmovupd ymm15, ymmword ptr [r10+rbx*8+0x8]
vmovupd ymm12, ymmword ptr [r8+rbx*8+0x8]
vmovupd ymm5, ymmword ptr [r8+rbx*8]
vmulpd ymm14, ymm3, ymmword ptr [r8+rbx*8+0x10]
vmulpd ymm13, ymm3, ymmword ptr [r10+rbx*8+0x10]
vaddpd ymm10, ymm15, ymmword ptr [r10+rbx*8+0x18]
vmovupd xmm15, xmmword ptr [rcx+rbx*8+0x10]
vaddpd ymm11, ymm12, ymmword ptr [r8+rbx*8+0x18]
vmovupd xmm12, xmmword ptr [rcx+rbx*8+0x30]
vinsertf128 ymm15, ymm15, xmmword ptr [rcx+rbx*8+0x20], 0x1
vaddpd ymm10, ymm10, ymm15
vinsertf128 ymm15, ymm12, xmmword ptr [rcx+rbx*8+0x40], 0x1
vaddpd ymm15, ymm11, ymm15
vmovupd xmm11, xmmword ptr [rdx+rbx*8+0x10]
vmovupd xmm12, xmmword ptr [rdx+rbx*8+0x30]
vinsertf128 ymm11, ymm11, xmmword ptr [rdx+rbx*8+0x20], 0x1
vaddpd ymm11, ymm10, ymm11
vinsertf128 ymm10, ymm12, xmmword ptr [rdx+rbx*8+0x40], 0x1
vaddpd ymm10, ymm15, ymm10
vmovupd xmm15, xmmword ptr [r14+rbx*8+0x10]
vinsertf128 ymm12, ymm15, xmmword ptr [r14+rbx*8+0x20], 0x1
vmovupd xmm15, xmmword ptr [r14+rbx*8+0x30]
vaddpd ymm12, ymm11, ymm12
vinsertf128 ymm11, ymm15, xmmword ptr [r14+rbx*8+0x40], 0x1
vaddpd ymm11, ymm10, ymm11
vmovupd xmm10, xmmword ptr [r12+rbx*8+0x10]
vinsertf128 ymm15, ymm10, xmmword ptr [r12+rbx*8+0x20], 0x1
vmovupd xmm10, xmmword ptr [r12+rbx*8+0x30]
vaddpd ymm15, ymm12, ymm15
vmulpd ymm15, ymm4, ymm15
vaddpd ymm13, ymm13, ymm15
vinsertf128 ymm12, ymm10, xmmword ptr [r12+rbx*8+0x40], 0x1
vaddpd ymm11, ymm11, ymm12
vmovupd xmm10, xmmword ptr [r11+rbx*8+0x30]
vmulpd ymm12, ymm4, ymm11
vaddpd ymm15, ymm14, ymm12
vaddpd ymm14, ymm5, ymmword ptr [r10+rbx*8]
vaddpd ymm12, ymm5, ymmword ptr [rdi+rbx*8+0x40]
vmovupd xmm5, xmmword ptr [r11+rbx*8+0x10]
vinsertf128 ymm11, ymm5, xmmword ptr [r11+rbx*8+0x20], 0x1
vinsertf128 ymm5, ymm10, xmmword ptr [r11+rbx*8+0x40], 0x1
vaddpd ymm10, ymm14, ymm11
vmovupd xmm14, xmmword ptr [rax+rbx*8+0x10]
vmovupd xmm11, xmmword ptr [rax+rbx*8+0x30]
vaddpd ymm5, ymm12, ymm5
vinsertf128 ymm12, ymm14, xmmword ptr [rax+rbx*8+0x20], 0x1
vinsertf128 ymm11, ymm11, xmmword ptr [rax+rbx*8+0x40], 0x1
vaddpd ymm14, ymm10, ymm12
vaddpd ymm10, ymm5, ymm11
vmovupd xmm12, xmmword ptr [r15+rbx*8+0x10]
vmovupd xmm5, xmmword ptr [r15+rbx*8+0x30]
vinsertf128 ymm11, ymm12, xmmword ptr [r15+rbx*8+0x20], 0x1
vinsertf128 ymm5, ymm5, xmmword ptr [r15+rbx*8+0x40], 0x1
vaddpd ymm12, ymm14, ymm11
vaddpd ymm14, ymm10, ymm5
vmovupd xmm10, xmmword ptr [r9+rbx*8+0x10]
vmovupd xmm11, xmmword ptr [r9+rbx*8+0x30]
vinsertf128 ymm5, ymm10, xmmword ptr [r9+rbx*8+0x20], 0x1
vaddpd ymm5, ymm12, ymm5
vmulpd ymm5, ymm9, ymm5
vaddpd ymm13, ymm13, ymm5
vmovupd ymmword ptr [r13+rbx*8+0x10], ymm13
vinsertf128 ymm10, ymm11, xmmword ptr [r9+rbx*8+0x40], 0x1
vaddpd ymm14, ymm14, ymm10
vmulpd ymm10, ymm9, ymm14
vaddpd ymm5, ymm15, ymm10
vmovupd ymmword ptr [r13+rbx*8+0x30], ymm5
add rbx, 0x8
cmp rbx, rsi
jb 0xfffffffffffffe52
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/5;409
L2: P <= 16384/5;3276
L3: P <= 1441792/5;288385
L1: 32*N*P + 16*P*(N - 2) + 32*P <= 32768;26²
L2: 32*N*P + 16*P*(N - 2) + 32*P <= 262144;73²
L3: 32*N*P + 16*P*(N - 2) + 32*P <= 26214400;738²
{%- endcapture -%}

{% include stencil_template.md %}

