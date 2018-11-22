---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "isotropic"
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

for(int k=1; k < M-1; k++){
  for(int j=1; j < N-1; j++){
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
vmovupd ymm2, ymmword ptr [r10+rcx*8+0x8]
vmovupd xmm4, xmmword ptr [rdi+rcx*8+0x8]
vmovupd xmm7, xmmword ptr [r8+rcx*8+0x8]
vaddpd ymm3, ymm2, ymmword ptr [r10+rcx*8]
vmovupd xmm10, xmmword ptr [r15+rcx*8+0x8]
vaddpd ymm5, ymm3, ymmword ptr [r10+rcx*8+0x10]
vmovupd xmm13, xmmword ptr [r12+rcx*8+0x8]
vinsertf128 ymm6, ymm4, xmmword ptr [rdi+rcx*8+0x18], 0x1
vaddpd ymm8, ymm5, ymm6
vmovupd xmm6, xmmword ptr [rdi+rcx*8+0x28]
vinsertf128 ymm9, ymm7, xmmword ptr [r8+rcx*8+0x18], 0x1
vaddpd ymm11, ymm8, ymm9
vmovupd xmm9, xmmword ptr [r8+rcx*8+0x28]
vinsertf128 ymm12, ymm10, xmmword ptr [r15+rcx*8+0x18], 0x1
vaddpd ymm14, ymm11, ymm12
vmovupd xmm12, xmmword ptr [r15+rcx*8+0x28]
vinsertf128 ymm15, ymm13, xmmword ptr [r12+rcx*8+0x18], 0x1
vaddpd ymm2, ymm14, ymm15
vmovupd xmm15, xmmword ptr [r12+rcx*8+0x28]
vmulpd ymm3, ymm0, ymm2
vmovupd ymmword ptr [r14+rcx*8+0x8], ymm3
vmovupd ymm4, ymmword ptr [r10+rcx*8+0x28]
vaddpd ymm5, ymm4, ymmword ptr [r10+rcx*8+0x20]
vaddpd ymm7, ymm5, ymmword ptr [r10+rcx*8+0x30]
vinsertf128 ymm8, ymm6, xmmword ptr [rdi+rcx*8+0x38], 0x1
vaddpd ymm10, ymm7, ymm8
vmovupd xmm8, xmmword ptr [rdi+rcx*8+0x48]
vinsertf128 ymm11, ymm9, xmmword ptr [r8+rcx*8+0x38], 0x1
vaddpd ymm13, ymm10, ymm11
vmovupd xmm11, xmmword ptr [r8+rcx*8+0x48]
vinsertf128 ymm14, ymm12, xmmword ptr [r15+rcx*8+0x38], 0x1
vaddpd ymm2, ymm13, ymm14
vmovupd xmm14, xmmword ptr [r15+rcx*8+0x48]
vinsertf128 ymm3, ymm15, xmmword ptr [r12+rcx*8+0x38], 0x1
vaddpd ymm4, ymm2, ymm3
vmovupd xmm15, xmmword ptr [r8+rcx*8+0x68]
vmulpd ymm5, ymm0, ymm4
vmovupd xmm4, xmmword ptr [r12+rcx*8+0x48]
vmovupd ymmword ptr [r14+rcx*8+0x28], ymm5
vmovupd ymm6, ymmword ptr [r10+rcx*8+0x48]
vaddpd ymm7, ymm6, ymmword ptr [r10+rcx*8+0x40]
vaddpd ymm9, ymm7, ymmword ptr [r10+rcx*8+0x50]
vinsertf128 ymm10, ymm8, xmmword ptr [rdi+rcx*8+0x58], 0x1
vaddpd ymm12, ymm9, ymm10
vinsertf128 ymm13, ymm11, xmmword ptr [r8+rcx*8+0x58], 0x1
vaddpd ymm2, ymm12, ymm13
vmovupd xmm11, xmmword ptr [rdi+rcx*8+0x68]
vinsertf128 ymm3, ymm14, xmmword ptr [r15+rcx*8+0x58], 0x1
vaddpd ymm5, ymm2, ymm3
vinsertf128 ymm6, ymm4, xmmword ptr [r12+rcx*8+0x58], 0x1
vaddpd ymm7, ymm5, ymm6
vmovupd xmm4, xmmword ptr [r15+rcx*8+0x68]
vmulpd ymm8, ymm0, ymm7
nop
vmovupd xmm7, xmmword ptr [r12+rcx*8+0x68]
vmovupd ymmword ptr [r14+rcx*8+0x48], ymm8
vmovupd ymm9, ymmword ptr [r10+rcx*8+0x68]
vaddpd ymm10, ymm9, ymmword ptr [r10+rcx*8+0x60]
vaddpd ymm12, ymm10, ymmword ptr [r10+rcx*8+0x70]
vinsertf128 ymm13, ymm11, xmmword ptr [rdi+rcx*8+0x78], 0x1
vaddpd ymm2, ymm12, ymm13
vinsertf128 ymm3, ymm15, xmmword ptr [r8+rcx*8+0x78], 0x1
vaddpd ymm5, ymm2, ymm3
vinsertf128 ymm6, ymm4, xmmword ptr [r15+rcx*8+0x78], 0x1
vaddpd ymm8, ymm5, ymm6
vinsertf128 ymm9, ymm7, xmmword ptr [r12+rcx*8+0x78], 0x1
vaddpd ymm10, ymm8, ymm9
vmulpd ymm11, ymm0, ymm10
vmovupd ymmword ptr [r14+rcx*8+0x68], ymm11
add rcx, 0x10
cmp rcx, rdx
jb 0xfffffffffffffe42
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

