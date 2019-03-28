---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r2"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
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
vmovupd ymm5, ymmword ptr [r8+rbx*8+0x10]
vmovupd ymm4, ymmword ptr [r10+rbx*8+0x10]
vmovupd xmm9, xmmword ptr [rcx+rbx*8+0x30]
vmovupd xmm8, xmmword ptr [rcx+rbx*8+0x10]
vaddpd ymm7, ymm5, ymmword ptr [r8+rbx*8+0x8]
vaddpd ymm6, ymm4, ymmword ptr [r10+rbx*8+0x8]
vmovupd xmm15, xmmword ptr [rdx+rbx*8+0x30]
vaddpd ymm12, ymm7, ymmword ptr [r8+rbx*8+0x18]
vaddpd ymm10, ymm6, ymmword ptr [r10+rbx*8+0x18]
vmovupd xmm14, xmmword ptr [rdx+rbx*8+0x10]
vmovupd xmm7, xmmword ptr [r14+rbx*8+0x10]
vmovupd ymm0, ymmword ptr [r8+rbx*8]
vinsertf128 ymm13, ymm9, xmmword ptr [rcx+rbx*8+0x40], 0x1
vaddpd ymm5, ymm12, ymm13
vmovupd xmm13, xmmword ptr [r12+rbx*8+0x10]
vinsertf128 ymm11, ymm8, xmmword ptr [rcx+rbx*8+0x20], 0x1
vmovupd xmm8, xmmword ptr [r14+rbx*8+0x30]
vaddpd ymm4, ymm10, ymm11
vinsertf128 ymm6, ymm15, xmmword ptr [rdx+rbx*8+0x40], 0x1
vaddpd ymm11, ymm5, ymm6
vmovupd xmm15, xmmword ptr [r15+rbx*8+0x10]
vinsertf128 ymm14, ymm14, xmmword ptr [rdx+rbx*8+0x20], 0x1
vinsertf128 ymm12, ymm8, xmmword ptr [r14+rbx*8+0x40], 0x1
vaddpd ymm9, ymm4, ymm14
vaddpd ymm6, ymm11, ymm12
vmovupd xmm11, xmmword ptr [r12+rbx*8+0x30]
vinsertf128 ymm10, ymm7, xmmword ptr [r14+rbx*8+0x20], 0x1
vaddpd ymm4, ymm9, ymm10
vinsertf128 ymm7, ymm11, xmmword ptr [r12+rbx*8+0x40], 0x1
vaddpd ymm9, ymm6, ymm7
vaddpd ymm12, ymm9, ymm0
vmovupd xmm9, xmmword ptr [rax+rbx*8+0x30]
vaddpd ymm6, ymm12, ymmword ptr [rdi+rbx*8+0x40]
vmovupd xmm12, xmmword ptr [r11+rbx*8+0x30]
vinsertf128 ymm5, ymm13, xmmword ptr [r12+rbx*8+0x20], 0x1
vaddpd ymm8, ymm4, ymm5
vaddpd ymm10, ymm8, ymmword ptr [r10+rbx*8]
vmovupd xmm8, xmmword ptr [rax+rbx*8+0x10]
vaddpd ymm4, ymm10, ymm0
vmovupd xmm0, xmmword ptr [r11+rbx*8+0x10]
vinsertf128 ymm7, ymm12, xmmword ptr [r11+rbx*8+0x40], 0x1
vaddpd ymm13, ymm6, ymm7
vmovupd xmm7, xmmword ptr [r9+rbx*8+0x10]
vinsertf128 ymm5, ymm0, xmmword ptr [r11+rbx*8+0x20], 0x1
vaddpd ymm10, ymm4, ymm5
vinsertf128 ymm14, ymm9, xmmword ptr [rax+rbx*8+0x40], 0x1
vaddpd ymm5, ymm13, ymm14
vmovupd xmm13, xmmword ptr [r15+rbx*8+0x30]
vinsertf128 ymm11, ymm8, xmmword ptr [rax+rbx*8+0x20], 0x1
vaddpd ymm0, ymm10, ymm11
vmovupd xmm8, xmmword ptr [r9+rbx*8+0x30]
vinsertf128 ymm4, ymm15, xmmword ptr [r15+rbx*8+0x20], 0x1
vinsertf128 ymm6, ymm13, xmmword ptr [r15+rbx*8+0x40], 0x1
vaddpd ymm9, ymm0, ymm4
vaddpd ymm11, ymm5, ymm6
vinsertf128 ymm10, ymm7, xmmword ptr [r9+rbx*8+0x20], 0x1
vinsertf128 ymm12, ymm8, xmmword ptr [r9+rbx*8+0x40], 0x1
vaddpd ymm14, ymm9, ymm10
vaddpd ymm0, ymm11, ymm12
vmulpd ymm4, ymm2, ymm14
vmulpd ymm5, ymm2, ymm0
vmovupd ymmword ptr [r13+rbx*8+0x10], ymm4
vmovupd ymmword ptr [r13+rbx*8+0x30], ymm5
add rbx, 0x8
cmp rbx, rsi
jb 0xfffffffffffffe6b
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

