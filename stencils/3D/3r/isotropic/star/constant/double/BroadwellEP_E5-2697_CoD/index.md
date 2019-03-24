---

title:  "Stencil 3D r3 star constant isotropic double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "3r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "22"
scaling      : [ "900" ]
blocking     : [ "L2-3D" ]
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

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * ((a[k][j][i-1] + a[k][j][i+1]) + (a[k-1][j][i] + a[k+1][j][i]) + (a[k][j-1][i] + a[k][j+1][i]))
+ c2 * ((a[k][j][i-2] + a[k][j][i+2]) + (a[k-2][j][i] + a[k+2][j][i]) + (a[k][j-2][i] + a[k][j+2][i]))
+ c3 * ((a[k][j][i-3] + a[k][j][i+3]) + (a[k-3][j][i] + a[k+3][j][i]) + (a[k][j-3][i] + a[k][j+3][i]))
;
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm11, ymmword ptr [rbx+rdi*8+0x10]
vmovupd ymm1, ymmword ptr [rbx+rdi*8+0x8]
vmovupd ymm2, ymmword ptr [rbx+rdi*8]
vaddpd ymm12, ymm11, ymmword ptr [rbx+rdi*8+0x20]
vaddpd ymm1, ymm1, ymmword ptr [rbx+rdi*8+0x28]
vaddpd ymm2, ymm2, ymmword ptr [rbx+rdi*8+0x30]
vaddpd ymm11, ymm1, ymmword ptr [r13+rdi*8+0x18]
mov rcx, qword ptr [rsp+0x1a8]
vaddpd ymm13, ymm12, ymmword ptr [rcx+rdi*8+0x18]
vaddpd ymm12, ymm11, ymmword ptr [r12+rdi*8+0x18]
mov rcx, qword ptr [rsp+0x1a0]
vaddpd ymm14, ymm13, ymmword ptr [rcx+rdi*8+0x18]
vaddpd ymm13, ymm12, ymmword ptr [r11+rdi*8+0x18]
vaddpd ymm15, ymm14, ymmword ptr [rsi+rdi*8+0x18]
vaddpd ymm14, ymm13, ymmword ptr [rdx+rdi*8+0x18]
vaddpd ymm0, ymm15, ymmword ptr [r8+rdi*8+0x18]
vaddpd ymm15, ymm2, ymmword ptr [r10+rdi*8+0x18]
vmulpd ymm0, ymm5, ymm0
vaddpd ymm1, ymm15, ymmword ptr [r14+rdi*8+0x18]
vfmadd231pd ymm0, ymm6, ymmword ptr [rbx+rdi*8+0x18]
vaddpd ymm2, ymm1, ymmword ptr [r9+rdi*8+0x18]
vfmadd231pd ymm0, ymm14, ymm4
vaddpd ymm11, ymm2, ymmword ptr [r15+rdi*8+0x18]
vfmadd231pd ymm0, ymm11, ymm3
vmovupd ymmword ptr [rax+rdi*8+0x18], ymm0
add rdi, 0x4
cmp rdi, qword ptr [rsp+0x178]
jb 0xffffffffffffff56
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P ~ 290
L2: P <= 16384/7;P ~ 2340
L3: P <= 1441792/7;P ~ 205970
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;N*P ~ 10²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;N*P ~ 60²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 23068672;N*P ~ 510²
{%- endcapture -%}

{% include stencil_template.md %}
