---

title:  "Stencil 3D r1 box variable heterogeneous double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "r1"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "variable"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor      : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "53"
scaling      : [ "450" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[27][M][N][P];

for(long k=1; k < M-1; ++k){
  for(long j=1; j < N-1; ++j){
    for(long i=1; i < P-1; ++i){
      b[k][j][i] = W[0][k][j][i] * a[k][j][i]
                  + W[1][k][j][i] * a[k-1][j-1][i-1]
                  + W[2][k][j][i] * a[k][j-1][i-1]
                  + W[3][k][j][i] * a[k+1][j-1][i-1]
                  + W[4][k][j][i] * a[k-1][j][i-1]
                  + W[5][k][j][i] * a[k][j][i-1]
                  + W[6][k][j][i] * a[k+1][j][i-1]
                  + W[7][k][j][i] * a[k-1][j+1][i-1]
                  + W[8][k][j][i] * a[k][j+1][i-1]
                  + W[9][k][j][i] * a[k+1][j+1][i-1]
                  + W[10][k][j][i] * a[k-1][j-1][i]
                  + W[11][k][j][i] * a[k][j-1][i]
                  + W[12][k][j][i] * a[k+1][j-1][i]
                  + W[13][k][j][i] * a[k-1][j][i]
                  + W[14][k][j][i] * a[k+1][j][i]
                  + W[15][k][j][i] * a[k-1][j+1][i]
                  + W[16][k][j][i] * a[k][j+1][i]
                  + W[17][k][j][i] * a[k+1][j+1][i]
                  + W[18][k][j][i] * a[k-1][j-1][i+1]
                  + W[19][k][j][i] * a[k][j-1][i+1]
                  + W[20][k][j][i] * a[k+1][j-1][i+1]
                  + W[21][k][j][i] * a[k-1][j][i+1]
                  + W[22][k][j][i] * a[k][j][i+1]
                  + W[23][k][j][i] * a[k+1][j][i+1]
                  + W[24][k][j][i] * a[k-1][j+1][i+1]
                  + W[25][k][j][i] * a[k][j+1][i+1]
                  + W[26][k][j][i] * a[k+1][j+1][i+1];
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
mov r15, qword ptr [rsp+0x3f0]
vmovupd ymm12, ymmword ptr [r9+rdi*8+0x8]
vmovupd ymm6, ymmword ptr [r10+rdi*8]
vmovupd ymm14, ymmword ptr [r15+rdi*8+0x8]
vmovupd ymm7, ymmword ptr [r14+rdi*8]
vmovupd ymm0, ymmword ptr [rax+rdi*8]
vmulpd ymm12, ymm12, ymmword ptr [r13+rdi*8]
vmovupd ymm1, ymmword ptr [r11+rdi*8+0x8]
vmovupd ymm15, ymmword ptr [r10+rdi*8+0x8]
vmovupd ymm11, ymmword ptr [rax+rdi*8+0x8]
vmovupd ymm5, ymmword ptr [r11+rdi*8+0x10]
vmovupd ymm3, ymmword ptr [r10+rdi*8+0x10]
vmovupd ymm10, ymmword ptr [r13+rdi*8+0x10]
vmovupd ymm2, ymmword ptr [rax+rdi*8+0x10]
vmovupd ymm4, ymmword ptr [rdx+rdi*8+0x8]
vmovupd ymm8, ymmword ptr [r12+rdi*8]
vmovupd ymm9, ymmword ptr [r8+rdi*8+0x8]
mov r15, qword ptr [rsp+0x358]
vmovupd ymm13, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm13, ymm13, ymmword ptr [r8+rdi*8]
mov r15, qword ptr [rsp+0x400]
vfmadd231pd ymm13, ymm6, ymmword ptr [r15+rdi*8+0x8]
vmovupd ymm6, ymmword ptr [rdx+rdi*8]
mov r15, qword ptr [rsp+0x3e8]
vfmadd231pd ymm12, ymm7, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x420]
vaddpd ymm13, ymm13, ymm12
vmovupd ymm7, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x428]
vmulpd ymm7, ymm7, ymmword ptr [rcx+rdi*8]
vmovupd ymm12, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x390]
vfmadd231pd ymm7, ymm0, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x388]
vmovupd ymm0, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm0, ymm0, ymmword ptr [r14+rdi*8+0x8]
mov r15, qword ptr [rsp+0x398]
vfmadd231pd ymm0, ymm1, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x380]
vmovupd ymm1, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm1, ymm1, ymmword ptr [r13+rdi*8+0x8]
mov r15, qword ptr [rsp+0x438]
nop
vfmadd231pd ymm1, ymm15, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x430]
vaddpd ymm0, ymm0, ymm1
vmovupd ymm15, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x360]
vmulpd ymm15, ymm15, ymmword ptr [rcx+rdi*8+0x8]
vmovupd ymm1, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x378]
vmulpd ymm1, ymm1, ymmword ptr [r12+rdi*8+0x10]
vfmadd231pd ymm15, ymm11, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x348]
nop dword ptr [rax], eax
vmovupd ymm11, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm11, ymm11, ymmword ptr [r14+rdi*8+0x10]
mov r15, qword ptr [rsp+0x418]
vfmadd231pd ymm11, ymm5, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x340]
nop dword ptr [rax], eax
vmovupd ymm5, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm5, ymm5, ymmword ptr [r8+rdi*8+0x10]
mov r15, qword ptr [rsp+0x330]
vfmadd231pd ymm5, ymm3, ymmword ptr [rsi+rdi*8+0x8]
vmovupd ymm3, ymmword ptr [r15+rdi*8+0x8]
vaddpd ymm5, ymm11, ymm5
vmulpd ymm3, ymm3, ymmword ptr [rdx+rdi*8+0x10]
mov r15, qword ptr [rsp+0x328]
vmovupd ymm11, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x338]
vfmadd231pd ymm3, ymm10, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm10, ymm11, ymmword ptr [rcx+rdi*8+0x10]
mov r15, qword ptr [rsp+0x318]
vfmadd231pd ymm10, ymm2, ymmword ptr [r15+rdi*8+0x8]
mov r15, qword ptr [rsp+0x370]
vaddpd ymm2, ymm3, ymm10
vfmadd231pd ymm1, ymm4, ymmword ptr [r15+rdi*8+0x8]
vmulpd ymm4, ymm12, ymmword ptr [r12+rdi*8+0x8]
vaddpd ymm1, ymm15, ymm1
vfmadd231pd ymm4, ymm6, ymmword ptr [rbx+rdi*8+0x8]
vaddpd ymm3, ymm7, ymm4
vmulpd ymm4, ymm14, ymmword ptr [r11+rdi*8]
vaddpd ymm14, ymm3, ymm13
mov r15, qword ptr [rsp+0x3f8]
vfmadd231pd ymm4, ymm8, ymmword ptr [r15+rdi*8+0x8]
vaddpd ymm8, ymm2, ymm5
mov r15, qword ptr [rsp+0x350]
vfmadd231pd ymm4, ymm9, ymmword ptr [r15+rdi*8+0x8]
vaddpd ymm9, ymm1, ymm0
vaddpd ymm1, ymm14, ymm4
vaddpd ymm0, ymm8, ymm9
vaddpd ymm2, ymm0, ymm1
mov r15, qword ptr [rsp+0x320]
vmovupd ymmword ptr [r15+rdi*8+0x8], ymm2
add rdi, 0x4
cmp rdi, qword ptr [rsp+0x310]
jb 0xfffffffffffffd7f
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4152/37;P <= 110
L2: P <= 32824/37;P <= 880
L3: P <= 2883640/37;P <= 77930
L1: 248*N*P - 448*P - 448 <= 32768;N*P <= 10²
L2: 248*N*P - 448*P - 448 <= 262144;N*P <= 30²
L3: 248*N*P - 448*P - 448 <= 23068672;N*P <= 300²
{%- endcapture -%}

{% include stencil_template.md %}
