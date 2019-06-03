---

title:  "Stencil 3D r2 box variable heterogeneous double IvyBridgeEP_E5-2660v2"

dimension    : "3D"
radius       : "r2"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "variable"
datatype     : "double"
machine      : "IvyBridgeEP_E5-2660v2"
flavor       : "EDIT_ME"
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -I/apps/likwid/4.3.4/include -L/apps/likwid/4.3.4/lib -I/headers/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "249"
scaling      : [ "240" ]
blocking     : [ "L2-3D", "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[125][M][N][P];

for(long k=2; k < M-2; ++k){
for(long j=2; j < N-2; ++j){
for(long i=2; i < P-2; ++i){
b[k][j][i] = W[0][k][j][i] * a[k][j][i]
+ W[1][k][j][i] * a[k-2][j-2][i-2]
+ W[2][k][j][i] * a[k-1][j-2][i-2]
+ W[3][k][j][i] * a[k][j-2][i-2]
+ W[4][k][j][i] * a[k+1][j-2][i-2]
+ W[5][k][j][i] * a[k+2][j-2][i-2]
+ W[6][k][j][i] * a[k-2][j-1][i-2]
+ W[7][k][j][i] * a[k-1][j-1][i-2]
+ W[8][k][j][i] * a[k][j-1][i-2]
+ W[9][k][j][i] * a[k+1][j-1][i-2]
+ W[10][k][j][i] * a[k+2][j-1][i-2]
+ W[11][k][j][i] * a[k-2][j][i-2]
+ W[12][k][j][i] * a[k-1][j][i-2]
+ W[13][k][j][i] * a[k][j][i-2]
+ W[14][k][j][i] * a[k+1][j][i-2]
+ W[15][k][j][i] * a[k+2][j][i-2]
+ W[16][k][j][i] * a[k-2][j+1][i-2]
+ W[17][k][j][i] * a[k-1][j+1][i-2]
+ W[18][k][j][i] * a[k][j+1][i-2]
+ W[19][k][j][i] * a[k+1][j+1][i-2]
+ W[20][k][j][i] * a[k+2][j+1][i-2]
+ W[21][k][j][i] * a[k-2][j+2][i-2]
+ W[22][k][j][i] * a[k-1][j+2][i-2]
+ W[23][k][j][i] * a[k][j+2][i-2]
+ W[24][k][j][i] * a[k+1][j+2][i-2]
+ W[25][k][j][i] * a[k+2][j+2][i-2]
+ W[26][k][j][i] * a[k-2][j-2][i-1]
+ W[27][k][j][i] * a[k-1][j-2][i-1]
+ W[28][k][j][i] * a[k][j-2][i-1]
+ W[29][k][j][i] * a[k+1][j-2][i-1]
+ W[30][k][j][i] * a[k+2][j-2][i-1]
+ W[31][k][j][i] * a[k-2][j-1][i-1]
+ W[32][k][j][i] * a[k-1][j-1][i-1]
+ W[33][k][j][i] * a[k][j-1][i-1]
+ W[34][k][j][i] * a[k+1][j-1][i-1]
+ W[35][k][j][i] * a[k+2][j-1][i-1]
+ W[36][k][j][i] * a[k-2][j][i-1]
+ W[37][k][j][i] * a[k-1][j][i-1]
+ W[38][k][j][i] * a[k][j][i-1]
+ W[39][k][j][i] * a[k+1][j][i-1]
+ W[40][k][j][i] * a[k+2][j][i-1]
+ W[41][k][j][i] * a[k-2][j+1][i-1]
+ W[42][k][j][i] * a[k-1][j+1][i-1]
+ W[43][k][j][i] * a[k][j+1][i-1]
+ W[44][k][j][i] * a[k+1][j+1][i-1]
+ W[45][k][j][i] * a[k+2][j+1][i-1]
+ W[46][k][j][i] * a[k-2][j+2][i-1]
+ W[47][k][j][i] * a[k-1][j+2][i-1]
+ W[48][k][j][i] * a[k][j+2][i-1]
+ W[49][k][j][i] * a[k+1][j+2][i-1]
+ W[50][k][j][i] * a[k+2][j+2][i-1]
+ W[51][k][j][i] * a[k-2][j-2][i]
+ W[52][k][j][i] * a[k-1][j-2][i]
+ W[53][k][j][i] * a[k][j-2][i]
+ W[54][k][j][i] * a[k+1][j-2][i]
+ W[55][k][j][i] * a[k+2][j-2][i]
+ W[56][k][j][i] * a[k-2][j-1][i]
+ W[57][k][j][i] * a[k-1][j-1][i]
+ W[58][k][j][i] * a[k][j-1][i]
+ W[59][k][j][i] * a[k+1][j-1][i]
+ W[60][k][j][i] * a[k+2][j-1][i]
+ W[61][k][j][i] * a[k-2][j][i]
+ W[62][k][j][i] * a[k-1][j][i]
+ W[63][k][j][i] * a[k+1][j][i]
+ W[64][k][j][i] * a[k+2][j][i]
+ W[65][k][j][i] * a[k-2][j+1][i]
+ W[66][k][j][i] * a[k-1][j+1][i]
+ W[67][k][j][i] * a[k][j+1][i]
+ W[68][k][j][i] * a[k+1][j+1][i]
+ W[69][k][j][i] * a[k+2][j+1][i]
+ W[70][k][j][i] * a[k-2][j+2][i]
+ W[71][k][j][i] * a[k-1][j+2][i]
+ W[72][k][j][i] * a[k][j+2][i]
+ W[73][k][j][i] * a[k+1][j+2][i]
+ W[74][k][j][i] * a[k+2][j+2][i]
+ W[75][k][j][i] * a[k-2][j-2][i+1]
+ W[76][k][j][i] * a[k-1][j-2][i+1]
+ W[77][k][j][i] * a[k][j-2][i+1]
+ W[78][k][j][i] * a[k+1][j-2][i+1]
+ W[79][k][j][i] * a[k+2][j-2][i+1]
+ W[80][k][j][i] * a[k-2][j-1][i+1]
+ W[81][k][j][i] * a[k-1][j-1][i+1]
+ W[82][k][j][i] * a[k][j-1][i+1]
+ W[83][k][j][i] * a[k+1][j-1][i+1]
+ W[84][k][j][i] * a[k+2][j-1][i+1]
+ W[85][k][j][i] * a[k-2][j][i+1]
+ W[86][k][j][i] * a[k-1][j][i+1]
+ W[87][k][j][i] * a[k][j][i+1]
+ W[88][k][j][i] * a[k+1][j][i+1]
+ W[89][k][j][i] * a[k+2][j][i+1]
+ W[90][k][j][i] * a[k-2][j+1][i+1]
+ W[91][k][j][i] * a[k-1][j+1][i+1]
+ W[92][k][j][i] * a[k][j+1][i+1]
+ W[93][k][j][i] * a[k+1][j+1][i+1]
+ W[94][k][j][i] * a[k+2][j+1][i+1]
+ W[95][k][j][i] * a[k-2][j+2][i+1]
+ W[96][k][j][i] * a[k-1][j+2][i+1]
+ W[97][k][j][i] * a[k][j+2][i+1]
+ W[98][k][j][i] * a[k+1][j+2][i+1]
+ W[99][k][j][i] * a[k+2][j+2][i+1]
+ W[100][k][j][i] * a[k-2][j-2][i+2]
+ W[101][k][j][i] * a[k-1][j-2][i+2]
+ W[102][k][j][i] * a[k][j-2][i+2]
+ W[103][k][j][i] * a[k+1][j-2][i+2]
+ W[104][k][j][i] * a[k+2][j-2][i+2]
+ W[105][k][j][i] * a[k-2][j-1][i+2]
+ W[106][k][j][i] * a[k-1][j-1][i+2]
+ W[107][k][j][i] * a[k][j-1][i+2]
+ W[108][k][j][i] * a[k+1][j-1][i+2]
+ W[109][k][j][i] * a[k+2][j-1][i+2]
+ W[110][k][j][i] * a[k-2][j][i+2]
+ W[111][k][j][i] * a[k-1][j][i+2]
+ W[112][k][j][i] * a[k][j][i+2]
+ W[113][k][j][i] * a[k+1][j][i+2]
+ W[114][k][j][i] * a[k+2][j][i+2]
+ W[115][k][j][i] * a[k-2][j+1][i+2]
+ W[116][k][j][i] * a[k-1][j+1][i+2]
+ W[117][k][j][i] * a[k][j+1][i+2]
+ W[118][k][j][i] * a[k+1][j+1][i+2]
+ W[119][k][j][i] * a[k+2][j+1][i+2]
+ W[120][k][j][i] * a[k-2][j+2][i+2]
+ W[121][k][j][i] * a[k-1][j+2][i+2]
+ W[122][k][j][i] * a[k][j+2][i+2]
+ W[123][k][j][i] * a[k+1][j+2][i+2]
+ W[124][k][j][i] * a[k+2][j+2][i+2]
;
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
mov rax, qword ptr [rbp-0x618]
mov r15, qword ptr [rbp-0x600]
mov rdx, qword ptr [rbp-0x628]
mov rcx, qword ptr [rbp-0x638]
vmovupd ymm0, ymmword ptr [rax+r15*8+0x10]
vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
vmovupd xmm5, xmmword ptr [rcx+r15*8+0x10]
mov r14, qword ptr [rbp-0x540]
mov r13, qword ptr [rbp-0x520]
mov rsi, qword ptr [rbp-0x610]
mov r12, qword ptr [rbp-0x4f8]
vmulpd ymm3, ymm0, ymmword ptr [r14+r15*8+0x10]
vmovupd xmm9, xmmword ptr [rsi+r15*8+0x10]
mov rdi, qword ptr [rbp-0x608]
mov r11, qword ptr [rbp-0x530]
mov rax, qword ptr [rbp-0x630]
vmovupd ymm13, ymmword ptr [rdi+r15*8+0x10]
mov r8, qword ptr [rbp-0x620]
mov r10, qword ptr [rbp-0x580]
mov r9, qword ptr [rbp-0x518]
vmovupd xmm0, xmmword ptr [r8+r15*8+0x10]
vmulpd ymm15, ymm13, ymmword ptr [r10+r15*8]
mov rdi, qword ptr [rbp-0x5a0]
vinsertf128 ymm2, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
vmulpd ymm4, ymm2, ymmword ptr [r13+r15*8]
vaddpd ymm7, ymm3, ymm4
vmovupd xmm4, xmmword ptr [rax+r15*8+0x10]
mov rdx, qword ptr [rbp-0x640]
vinsertf128 ymm6, ymm5, xmmword ptr [rcx+r15*8+0x20], 0x1
vmulpd ymm8, ymm6, ymmword ptr [r12+r15*8]
vaddpd ymm11, ymm7, ymm8
vmovupd xmm8, xmmword ptr [rdx+r15*8+0x10]
mov rcx, qword ptr [rbp-0x648]
vinsertf128 ymm10, ymm9, xmmword ptr [rsi+r15*8+0x20], 0x1
vmulpd ymm12, ymm10, ymmword ptr [r11+r15*8]
vaddpd ymm14, ymm11, ymm12
vmovupd ymm12, ymmword ptr [rcx+r15*8+0x10]
vaddpd ymm2, ymm14, ymm15
mov rsi, qword ptr [rbp-0x598]
mov rcx, qword ptr [rbp-0x5a8]
vinsertf128 ymm5, ymm4, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x650]
vmulpd ymm14, ymm12, ymmword ptr [rsi+r15*8]
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm1, ymm0, xmmword ptr [r8+r15*8+0x20], 0x1
vmulpd ymm3, ymm1, ymmword ptr [r9+r15*8]
mov r8, qword ptr [rbp-0x548]
vaddpd ymm6, ymm2, ymm3
vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8]
vaddpd ymm10, ymm6, ymm7
vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x660]
vmulpd ymm2, ymm0, ymmword ptr [rcx+r15*8]
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm9, ymm8, xmmword ptr [rdx+r15*8+0x20], 0x1
vmulpd ymm11, ymm9, ymmword ptr [rdi+r15*8]
vaddpd ymm13, ymm10, ymm11
vaddpd ymm1, ymm13, ymm14
mov rdx, qword ptr [rbp-0x658]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [rdx+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x590]
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x668]
vinsertf128 ymm4, ymm3, xmmword ptr [rdx+r15*8+0x20], 0x1
mov rdx, qword ptr [rbp-0x500]
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
vmulpd ymm6, ymm4, ymmword ptr [rdx+r15*8]
mov rax, qword ptr [rbp-0x588]
vaddpd ymm9, ymm5, ymm6
vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
vaddpd ymm12, ymm9, ymm10
mov rax, qword ptr [rbp-0x670]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x688]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8]
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x538]
vmulpd ymm6, ymm4, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x6b8]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x578]
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x7b0]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
mov rax, qword ptr [rbp-0x550]
vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x7d0]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x558]
vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x818]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x560]
vmulpd ymm6, ymm4, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x848]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x568]
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x868]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
mov rax, qword ptr [rbp-0x570]
vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x8b0]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x4e8]
vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x8d0]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x528]
vmulpd ymm6, ymm4, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x8f0]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x510]
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x910]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
mov rax, qword ptr [rbp-0x508]
vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x938]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x4f0]
vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8]
mov rax, qword ptr [rbp-0x6b0]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x6a8]
vmulpd ymm6, ymm4, ymmword ptr [r13+r15*8+0x8]
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x6a0]
vmulpd ymm10, ymm8, ymmword ptr [r12+r15*8+0x8]
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vmulpd ymm13, ymm11, ymmword ptr [r11+r15*8+0x8]
mov rax, qword ptr [rbp-0x698]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x9a0]
vmulpd ymm2, ymm0, ymmword ptr [r10+r15*8+0x8]
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x690]
vmulpd ymm6, ymm4, ymmword ptr [r9+r15*8+0x8]
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x998]
vmulpd ymm10, ymm8, ymmword ptr [r8+r15*8+0x8]
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vmulpd ymm13, ymm11, ymmword ptr [rdi+r15*8+0x8]
mov rax, qword ptr [rbp-0x990]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x988]
vmulpd ymm2, ymm0, ymmword ptr [rsi+r15*8+0x8]
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x980]
vmulpd ymm6, ymm4, ymmword ptr [rcx+r15*8+0x8]
vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x978]
vmulpd ymm10, ymm8, ymmword ptr [rdx+r15*8+0x8]
vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
mov rax, qword ptr [rbp-0x590]
vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8+0x8]
mov rax, qword ptr [rbp-0x970]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x588]
vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8+0x8]
mov rax, qword ptr [rbp-0x968]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x960]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
mov rax, qword ptr [rbp-0x538]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x958]
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8+0x8]
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
mov r14, qword ptr [rbp-0x578]
vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x950]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x550]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x948]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x558]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x940]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x560]
vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x5f8]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x568]
vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x930]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x570]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x928]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x4e8]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x920]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x528]
vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x918]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x510]
vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x5f0]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x508]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x908]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x4f0]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
mov r14, qword ptr [rbp-0x900]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8f8]
vmulpd ymm10, ymm8, ymmword ptr [r13+r15*8+0x10]
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vmulpd ymm13, ymm11, ymmword ptr [r12+r15*8+0x10]
mov r14, qword ptr [rbp-0x5e8]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8e8]
vmulpd ymm2, ymm0, ymmword ptr [r11+r15*8+0x10]
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8e0]
vmulpd ymm6, ymm4, ymmword ptr [r10+r15*8+0x10]
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8d8]
vmulpd ymm10, ymm8, ymmword ptr [r9+r15*8+0x10]
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vmulpd ymm13, ymm11, ymmword ptr [r8+r15*8+0x10]
mov r14, qword ptr [rbp-0x5e0]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8c8]
vmulpd ymm2, ymm0, ymmword ptr [rdi+r15*8+0x10]
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8c0]
vmulpd ymm6, ymm4, ymmword ptr [rsi+r15*8+0x10]
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x8b8]
vmulpd ymm10, ymm8, ymmword ptr [rcx+r15*8+0x10]
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vmulpd ymm13, ymm11, ymmword ptr [rdx+r15*8+0x10]
mov r14, qword ptr [rbp-0x5d8]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x590]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x8a8]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x588]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x8a0]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x898]
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8+0x10]
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
mov r14, qword ptr [rbp-0x578]
vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x890]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x550]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x888]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x558]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x880]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x560]
vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x878]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x568]
vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x870]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x570]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x5d0]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x4e8]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x860]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x528]
vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x858]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x510]
vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x850]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x508]
vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x5c8]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
mov r14, qword ptr [rbp-0x4f0]
vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
mov r14, qword ptr [rbp-0x840]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
vmulpd ymm10, ymm8, ymmword ptr [r13+r15*8+0x18]
mov r13, qword ptr [rbp-0x838]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [r13+r15*8+0x10]
vmulpd ymm13, ymm11, ymmword ptr [r12+r15*8+0x18]
mov r12, qword ptr [rbp-0x830]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm14, xmmword ptr [r12+r15*8+0x10]
mov r14, qword ptr [rbp-0x7d8]
mov r13, qword ptr [rbp-0x540]
vinsertf128 ymm0, ymm14, xmmword ptr [r12+r15*8+0x20], 0x1
vmulpd ymm2, ymm0, ymmword ptr [r11+r15*8+0x18]
mov r11, qword ptr [rbp-0x828]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [r11+r15*8+0x10]
mov r12, qword ptr [rbp-0x7e0]
vinsertf128 ymm4, ymm3, xmmword ptr [r11+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [r10+r15*8+0x18]
mov r10, qword ptr [rbp-0x820]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [r10+r15*8+0x10]
mov r11, qword ptr [rbp-0x588]
vinsertf128 ymm8, ymm7, xmmword ptr [r10+r15*8+0x20], 0x1
vmulpd ymm10, ymm8, ymmword ptr [r9+r15*8+0x18]
mov r9, qword ptr [rbp-0x5c0]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [r9+r15*8+0x10]
vmulpd ymm13, ymm11, ymmword ptr [r8+r15*8+0x18]
mov r8, qword ptr [rbp-0x810]
vaddpd ymm1, ymm12, ymm13
vmovupd xmm15, xmmword ptr [r8+r15*8+0x10]
mov r10, qword ptr [rbp-0x7e8]
mov r9, qword ptr [rbp-0x590]
vinsertf128 ymm0, ymm15, xmmword ptr [r8+r15*8+0x20], 0x1
vmulpd ymm2, ymm0, ymmword ptr [rdi+r15*8+0x18]
mov rdi, qword ptr [rbp-0x808]
vaddpd ymm5, ymm1, ymm2
vmovupd xmm3, xmmword ptr [rdi+r15*8+0x10]
mov r8, qword ptr [rbp-0x7b8]
vinsertf128 ymm4, ymm3, xmmword ptr [rdi+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [rsi+r15*8+0x18]
vmovupd xmm3, xmmword ptr [r10+r15*8+0x10]
mov rsi, qword ptr [rbp-0x800]
vaddpd ymm9, ymm5, ymm6
vmovupd xmm7, xmmword ptr [rsi+r15*8+0x10]
mov rdi, qword ptr [rbp-0x558]
vinsertf128 ymm8, ymm7, xmmword ptr [rsi+r15*8+0x20], 0x1
vmulpd ymm10, ymm8, ymmword ptr [rcx+r15*8+0x18]
vmovupd xmm7, xmmword ptr [r12+r15*8+0x10]
mov rcx, qword ptr [rbp-0x7f8]
vaddpd ymm12, ymm9, ymm10
vmovupd ymm11, ymmword ptr [rcx+r15*8+0x10]
vmulpd ymm13, ymm11, ymmword ptr [rdx+r15*8+0x18]
vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
vaddpd ymm1, ymm12, ymm13
vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8+0x18]
vmovupd ymm11, ymmword ptr [r8+r15*8+0x10]
mov rdx, qword ptr [rbp-0x7f0]
mov rax, qword ptr [rbp-0x5b8]
mov rsi, qword ptr [rbp-0x7c0]
vmovupd xmm14, xmmword ptr [rdx+r15*8+0x10]
vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
mov rcx, qword ptr [rbp-0x550]
mov r14, qword ptr [rbp-0x7a0]
mov r8, qword ptr [rbp-0x788]
vinsertf128 ymm0, ymm14, xmmword ptr [rdx+r15*8+0x20], 0x1
vmulpd ymm2, ymm0, ymmword ptr [r9+r15*8+0x18]
vaddpd ymm5, ymm1, ymm2
mov rdx, qword ptr [rbp-0x7c8]
mov r9, qword ptr [rbp-0x560]
vinsertf128 ymm4, ymm3, xmmword ptr [r10+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [r11+r15*8+0x18]
vmovupd xmm3, xmmword ptr [rdx+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
mov r10, qword ptr [rbp-0x5b0]
mov r11, qword ptr [rbp-0x568]
vinsertf128 ymm8, ymm7, xmmword ptr [r12+r15*8+0x20], 0x1
vmulpd ymm10, ymm8, ymmword ptr [r13+r15*8+0x18]
vmovupd xmm7, xmmword ptr [rsi+r15*8+0x10]
vmovupd xmm14, xmmword ptr [r10+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vaddpd ymm1, ymm12, ymm13
vmulpd ymm13, ymm11, ymmword ptr [r9+r15*8+0x18]
mov r12, qword ptr [rbp-0x7a8]
mov r13, qword ptr [rbp-0x570]
mov r9, qword ptr [rbp-0x508]
vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
mov rax, qword ptr [rbp-0x578]
vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8+0x18]
vinsertf128 ymm4, ymm3, xmmword ptr [rdx+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [rcx+r15*8+0x18]
vmovupd xmm3, xmmword ptr [r12+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
vaddpd ymm9, ymm5, ymm6
mov rdx, qword ptr [rbp-0x798]
mov rax, qword ptr [rbp-0x4e8]
mov rcx, qword ptr [rbp-0x528]
vmovupd ymm11, ymmword ptr [rdx+r15*8+0x10]
vinsertf128 ymm8, ymm7, xmmword ptr [rsi+r15*8+0x20], 0x1
vmulpd ymm10, ymm8, ymmword ptr [rdi+r15*8+0x18]
vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vaddpd ymm1, ymm12, ymm13
vmulpd ymm13, ymm11, ymmword ptr [rcx+r15*8+0x18]
mov rsi, qword ptr [rbp-0x790]
mov rdi, qword ptr [rbp-0x510]
vinsertf128 ymm0, ymm14, xmmword ptr [r10+r15*8+0x20], 0x1
vmulpd ymm2, ymm0, ymmword ptr [r11+r15*8+0x18]
vmovupd xmm15, xmmword ptr [rsi+r15*8+0x10]
vaddpd ymm5, ymm1, ymm2
mov r10, qword ptr [rbp-0x780]
mov r11, qword ptr [rbp-0x4f0]
vinsertf128 ymm4, ymm3, xmmword ptr [r12+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [r13+r15*8+0x18]
vmovupd xmm3, xmmword ptr [r8+r15*8+0x10]
vaddpd ymm9, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8+0x18]
vmovupd xmm7, xmmword ptr [r10+r15*8+0x10]
vaddpd ymm12, ymm9, ymm10
vaddpd ymm1, ymm12, ymm13
vinsertf128 ymm0, ymm15, xmmword ptr [rsi+r15*8+0x20], 0x1
vmulpd ymm2, ymm0, ymmword ptr [rdi+r15*8+0x18]
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [r8+r15*8+0x20], 0x1
vmulpd ymm6, ymm4, ymmword ptr [r9+r15*8+0x18]
vaddpd ymm0, ymm5, ymm6
vinsertf128 ymm8, ymm7, xmmword ptr [r10+r15*8+0x20], 0x1
vmulpd ymm1, ymm8, ymmword ptr [r11+r15*8+0x18]
mov rax, r15
mov rdx, qword ptr [rbp-0x520]
mov rsi, qword ptr [rbp-0x770]
mov rdi, qword ptr [rbp-0x4f8]
vaddpd ymm2, ymm0, ymm1
vmovupd xmm0, xmmword ptr [rdx+rax*8+0x20]
vmovupd xmm4, xmmword ptr [rsi+rax*8+0x10]
vmovupd xmm5, xmmword ptr [rdi+rax*8+0x20]
mov rcx, qword ptr [rbp-0x778]
mov r8, qword ptr [rbp-0x768]
mov r9, qword ptr [rbp-0x530]
mov r10, qword ptr [rbp-0x760]
mov r11, qword ptr [rbp-0x580]
vmovupd xmm10, xmmword ptr [r8+rax*8+0x10]
vmovupd xmm11, xmmword ptr [r9+rax*8+0x20]
mov r12, qword ptr [rbp-0x518]
mov r14, qword ptr [rbp-0x750]
mov r15, qword ptr [rbp-0x548]
mov r13, qword ptr [rbp-0x758]
vinsertf128 ymm1, ymm0, xmmword ptr [rdx+rax*8+0x30], 0x1
vmulpd ymm3, ymm1, ymmword ptr [rcx+rax*8+0x10]
vmovupd xmm0, xmmword ptr [r10+rax*8+0x10]
vmovupd xmm1, xmmword ptr [r11+rax*8+0x20]
vaddpd ymm8, ymm2, ymm3
mov rdx, qword ptr [rbp-0x748]
mov rcx, qword ptr [rbp-0x5a0]
vinsertf128 ymm6, ymm4, xmmword ptr [rsi+rax*8+0x20], 0x1
vinsertf128 ymm7, ymm5, xmmword ptr [rdi+rax*8+0x30], 0x1
vmulpd ymm9, ymm6, ymm7
vmovupd xmm6, xmmword ptr [r12+rax*8+0x20]
vaddpd ymm14, ymm8, ymm9
mov rsi, qword ptr [rbp-0x740]
mov rdi, qword ptr [rbp-0x598]
vinsertf128 ymm12, ymm10, xmmword ptr [r8+rax*8+0x20], 0x1
vinsertf128 ymm13, ymm11, xmmword ptr [r9+rax*8+0x30], 0x1
vmulpd ymm15, ymm12, ymm13
vmovupd xmm10, xmmword ptr [r14+rax*8+0x10]
vmovupd xmm11, xmmword ptr [r15+rax*8+0x20]
vaddpd ymm4, ymm14, ymm15
mov r8, qword ptr [rbp-0x5a8]
mov r9, qword ptr [rbp-0x738]
vinsertf128 ymm2, ymm0, xmmword ptr [r10+rax*8+0x20], 0x1
vinsertf128 ymm3, ymm1, xmmword ptr [r11+rax*8+0x30], 0x1
vmulpd ymm5, ymm2, ymm3
vmovupd xmm0, xmmword ptr [rdx+rax*8+0x10]
vmovupd xmm1, xmmword ptr [rcx+rax*8+0x20]
vaddpd ymm8, ymm4, ymm5
mov r10, qword ptr [rbp-0x730]
mov r11, qword ptr [rbp-0x500]
vinsertf128 ymm7, ymm6, xmmword ptr [r12+rax*8+0x30], 0x1
vmulpd ymm9, ymm7, ymmword ptr [r13+rax*8+0x10]
vmovupd xmm6, xmmword ptr [rsi+rax*8+0x10]
vmovupd xmm7, xmmword ptr [rdi+rax*8+0x20]
vaddpd ymm14, ymm8, ymm9
mov r12, qword ptr [rbp-0x728]
mov r13, qword ptr [rbp-0x590]
vinsertf128 ymm12, ymm10, xmmword ptr [r14+rax*8+0x20], 0x1
vinsertf128 ymm13, ymm11, xmmword ptr [r15+rax*8+0x30], 0x1
vmulpd ymm15, ymm12, ymm13
vmovupd xmm12, xmmword ptr [r8+rax*8+0x20]
vaddpd ymm4, ymm14, ymm15
mov r14, qword ptr [rbp-0x720]
mov r15, qword ptr [rbp-0x588]
vinsertf128 ymm2, ymm0, xmmword ptr [rdx+rax*8+0x20], 0x1
vinsertf128 ymm3, ymm1, xmmword ptr [rcx+rax*8+0x30], 0x1
vmulpd ymm5, ymm2, ymm3
vmovupd xmm0, xmmword ptr [r10+rax*8+0x10]
vmovupd xmm1, xmmword ptr [r11+rax*8+0x20]
vaddpd ymm10, ymm4, ymm5
mov rdx, qword ptr [rbp-0x540]
mov rcx, qword ptr [rbp-0x718]
vinsertf128 ymm8, ymm6, xmmword ptr [rsi+rax*8+0x20], 0x1
vinsertf128 ymm9, ymm7, xmmword ptr [rdi+rax*8+0x30], 0x1
vmulpd ymm11, ymm8, ymm9
vmovupd xmm6, xmmword ptr [r12+rax*8+0x10]
vmovupd xmm7, xmmword ptr [r13+rax*8+0x20]
vaddpd ymm14, ymm10, ymm11
mov rsi, qword ptr [rbp-0x710]
mov rdi, qword ptr [rbp-0x538]
vinsertf128 ymm13, ymm12, xmmword ptr [r8+rax*8+0x30], 0x1
vmulpd ymm15, ymm13, ymmword ptr [r9+rax*8+0x10]
vmovupd xmm12, xmmword ptr [r14+rax*8+0x10]
vmovupd xmm13, xmmword ptr [r15+rax*8+0x20]
vaddpd ymm4, ymm14, ymm15
mov r8, qword ptr [rbp-0x708]
mov r9, qword ptr [rbp-0x578]
vinsertf128 ymm2, ymm0, xmmword ptr [r10+rax*8+0x20], 0x1
vinsertf128 ymm3, ymm1, xmmword ptr [r11+rax*8+0x30], 0x1
vmulpd ymm5, ymm2, ymm3
vmovupd xmm2, xmmword ptr [rdx+rax*8+0x20]
vaddpd ymm10, ymm4, ymm5
mov r10, qword ptr [rbp-0x700]
mov r11, qword ptr [rbp-0x550]
vinsertf128 ymm8, ymm6, xmmword ptr [r12+rax*8+0x20], 0x1
vinsertf128 ymm9, ymm7, xmmword ptr [r13+rax*8+0x30], 0x1
vmulpd ymm11, ymm8, ymm9
vmovupd xmm6, xmmword ptr [rsi+rax*8+0x10]
vmovupd xmm7, xmmword ptr [rdi+rax*8+0x20]
vaddpd ymm0, ymm10, ymm11
mov r12, qword ptr [rbp-0x558]
mov r13, qword ptr [rbp-0x6f8]
vinsertf128 ymm14, ymm12, xmmword ptr [r14+rax*8+0x20], 0x1
vinsertf128 ymm15, ymm13, xmmword ptr [r15+rax*8+0x30], 0x1
vmulpd ymm1, ymm14, ymm15
vmovupd xmm12, xmmword ptr [r8+rax*8+0x10]
vmovupd xmm13, xmmword ptr [r9+rax*8+0x20]
vaddpd ymm4, ymm0, ymm1
mov r14, qword ptr [rbp-0x6f0]
mov r15, qword ptr [rbp-0x560]
vinsertf128 ymm3, ymm2, xmmword ptr [rdx+rax*8+0x30], 0x1
vmulpd ymm5, ymm3, ymmword ptr [rcx+rax*8+0x10]
vmovupd xmm2, xmmword ptr [r10+rax*8+0x10]
vmovupd xmm3, xmmword ptr [r11+rax*8+0x20]
vaddpd ymm10, ymm4, ymm5
mov rdx, qword ptr [rbp-0x6e8]
mov rcx, qword ptr [rbp-0x568]
vinsertf128 ymm8, ymm6, xmmword ptr [rsi+rax*8+0x20], 0x1
vinsertf128 ymm9, ymm7, xmmword ptr [rdi+rax*8+0x30], 0x1
vmulpd ymm11, ymm8, ymm9
vmovupd xmm8, xmmword ptr [r12+rax*8+0x20]
vaddpd ymm0, ymm10, ymm11
mov rsi, qword ptr [rbp-0x6e0]
mov rdi, qword ptr [rbp-0x570]
vinsertf128 ymm14, ymm12, xmmword ptr [r8+rax*8+0x20], 0x1
vinsertf128 ymm15, ymm13, xmmword ptr [r9+rax*8+0x30], 0x1
vmulpd ymm1, ymm14, ymm15
vmovupd xmm12, xmmword ptr [r14+rax*8+0x10]
vmovupd xmm13, xmmword ptr [r15+rax*8+0x20]
vaddpd ymm6, ymm0, ymm1
mov r8, qword ptr [rbp-0x4e8]
mov r9, qword ptr [rbp-0x6d8]
vinsertf128 ymm4, ymm2, xmmword ptr [r10+rax*8+0x20], 0x1
vinsertf128 ymm5, ymm3, xmmword ptr [r11+rax*8+0x30], 0x1
vmulpd ymm7, ymm4, ymm5
vmovupd xmm2, xmmword ptr [rdx+rax*8+0x10]
vmovupd xmm3, xmmword ptr [rcx+rax*8+0x20]
vaddpd ymm10, ymm6, ymm7
mov r10, qword ptr [rbp-0x6d0]
mov r11, qword ptr [rbp-0x528]
vinsertf128 ymm9, ymm8, xmmword ptr [r12+rax*8+0x30], 0x1
vmulpd ymm11, ymm9, ymmword ptr [r13+rax*8+0x10]
vmovupd xmm8, xmmword ptr [rsi+rax*8+0x10]
vmovupd xmm9, xmmword ptr [rdi+rax*8+0x20]
vaddpd ymm0, ymm10, ymm11
mov r12, qword ptr [rbp-0x6c8]
mov r13, qword ptr [rbp-0x510]
vinsertf128 ymm14, ymm12, xmmword ptr [r14+rax*8+0x20], 0x1
vinsertf128 ymm15, ymm13, xmmword ptr [r15+rax*8+0x30], 0x1
vmulpd ymm1, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r8+rax*8+0x20]
vaddpd ymm6, ymm0, ymm1
mov r14, qword ptr [rbp-0x6c0]
mov r15, qword ptr [rbp-0x508]
vinsertf128 ymm4, ymm2, xmmword ptr [rdx+rax*8+0x20], 0x1
vinsertf128 ymm5, ymm3, xmmword ptr [rcx+rax*8+0x30], 0x1
vmulpd ymm7, ymm4, ymm5
vmovupd xmm2, xmmword ptr [r10+rax*8+0x10]
vmovupd xmm3, xmmword ptr [r11+rax*8+0x20]
vaddpd ymm12, ymm6, ymm7
mov rdx, qword ptr [rbp-0x4f0]
mov rcx, qword ptr [rbp-0x678]
vinsertf128 ymm10, ymm8, xmmword ptr [rsi+rax*8+0x20], 0x1
vinsertf128 ymm11, ymm9, xmmword ptr [rdi+rax*8+0x30], 0x1
vmulpd ymm13, ymm10, ymm11
vmovupd xmm8, xmmword ptr [r12+rax*8+0x10]
vmovupd xmm9, xmmword ptr [r13+rax*8+0x20]
vaddpd ymm0, ymm12, ymm13
mov rsi, qword ptr [rbp-0x680]
vinsertf128 ymm15, ymm14, xmmword ptr [r8+rax*8+0x30], 0x1
vmulpd ymm1, ymm15, ymmword ptr [r9+rax*8+0x10]
vmovupd xmm14, xmmword ptr [r14+rax*8+0x10]
vmovupd xmm15, xmmword ptr [r15+rax*8+0x20]
vaddpd ymm6, ymm0, ymm1
vinsertf128 ymm4, ymm2, xmmword ptr [r10+rax*8+0x20], 0x1
vinsertf128 ymm5, ymm3, xmmword ptr [r11+rax*8+0x30], 0x1
vmulpd ymm7, ymm4, ymm5
vmovupd xmm3, xmmword ptr [rdx+rax*8+0x20]
vaddpd ymm12, ymm6, ymm7
vinsertf128 ymm10, ymm8, xmmword ptr [r12+rax*8+0x20], 0x1
vinsertf128 ymm11, ymm9, xmmword ptr [r13+rax*8+0x30], 0x1
vmulpd ymm13, ymm10, ymm11
vaddpd ymm1, ymm12, ymm13
vinsertf128 ymm14, ymm14, xmmword ptr [r14+rax*8+0x20], 0x1
vinsertf128 ymm0, ymm15, xmmword ptr [r15+rax*8+0x30], 0x1
vmulpd ymm2, ymm14, ymm0
vaddpd ymm5, ymm1, ymm2
vinsertf128 ymm4, ymm3, xmmword ptr [rdx+rax*8+0x30], 0x1
vmulpd ymm6, ymm4, ymmword ptr [rcx+rax*8+0x10]
vaddpd ymm7, ymm5, ymm6
vmovupd xmmword ptr [rsi+rax*8+0x10], xmm7
vextractf128 xmmword ptr [rsi+rax*8+0x20], ymm7, 0x1
add rax, 0x4
mov qword ptr [rbp-0x600], rax
cmp rax, qword ptr [rbp-0x9a8]
jb 0xffffffffffffed0d
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled L2: unconditionally fulfilled L3: unconditionally fulfilled L1: P <= 4600/151 L2: P <= 33272/151 L3: P <= 21704 L1: 1048*N*P - 4032*P - 4032 <= 32768 L2: 1048*N*P - 4032*P - 4032 <= 262144 L3: 1048*N*P - 4032*P - 4032 <= 26214400
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 366.76 Cycles       Throughput Bottleneck: Backend. Port2_DATA, Port3_DATA

Port Binding In Cycles Per Iteration:
----------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -   D   |   3   -   D   |   4   |   5   |
----------------------------------------------------------------------------------
| Cycles | 125.0    0.0  | 124.0 | 295.0   359.5 | 295.0   359.5 |  3.0  | 120.0 |
----------------------------------------------------------------------------------

N - port number or number of cycles resource conflict caused delay, DV - Divider pipe (on port 0)
D - Data fetch pipe (on ports 2 and 3), CP - on a critical path
F - Macro Fusion with the previous instruction occurred
* - instruction micro-ops not bound to a port
^ - Micro Fusion happened
# - ESP Tracking sync uop was issued
@ - SSE instruction followed an AVX256/AVX512 instruction, dozens of cycles penalty is expected
X - instruction not supported, was not accounted in Analysis

| Num Of |              Ports pressure in cycles               |    |
|  Uops  |  0  - DV  |  1  |  2  -  D  |  3  -  D  |  4  |  5  |    |
---------------------------------------------------------------------
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x618]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r15, qword ptr [rbp-0x600]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x628]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x638]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm0, ymmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm1, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm5, xmmword ptr [rcx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x540]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x520]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x610]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x4f8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm3, ymm0, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm9, xmmword ptr [rsi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x608]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x530]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x630]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm13, ymmword ptr [rdi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x620]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x580]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x518]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm0, xmmword ptr [r8+r15*8+0x10]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm15, ymm13, ymmword ptr [r10+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x5a0]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm2, ymm1, xmmword ptr [rdx+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm4, ymm2, ymmword ptr [r13+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm7, ymm3, ymm4
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm4, xmmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x640]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm6, ymm5, xmmword ptr [rcx+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm8, ymm6, ymmword ptr [r12+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm11, ymm7, ymm8
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm8, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x648]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm10, ymm9, xmmword ptr [rsi+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm12, ymm10, ymmword ptr [r11+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm11, ymm12
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm12, ymmword ptr [rcx+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm2, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x598]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x5a8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm5, ymm4, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x650]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm14, ymm12, ymmword ptr [rsi+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm1, ymm0, xmmword ptr [r8+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm3, ymm1, ymmword ptr [r9+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x548]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm6, ymm2, ymm3
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm6, ymm7
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x660]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rcx+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm9, ymm8, xmmword ptr [rdx+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm11, ymm9, ymmword ptr [rdi+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm13, ymm10, ymm11
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm13, ymm14
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x658]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rdx+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x590]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x668]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rdx+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x500]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rdx+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x588]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x670]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x688]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x538]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x6b8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x578]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x7b0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x550]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x7d0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x558]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x818]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x560]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x848]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x568]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x868]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x570]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x8b0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x4e8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x8d0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x528]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x8f0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x510]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x910]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x508]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x938]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x4f0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x6b0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x6a8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r13+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x6a0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r12+r15*8+0x8]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r11+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x698]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x9a0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r10+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x690]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r9+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x998]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r8+r15*8+0x8]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rdi+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x990]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x988]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rsi+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x980]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rcx+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x978]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rdx+r15*8+0x8]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rax+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x590]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x970]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x588]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x968]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rax+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rax+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x960]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x538]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x958]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8+0x8]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x578]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x950]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x550]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x948]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x558]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x940]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x560]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5f8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x568]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x930]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x570]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x928]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x4e8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x920]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x528]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x918]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x510]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5f0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x508]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x908]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x4f0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x900]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8f8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r13+r15*8+0x10]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r12+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5e8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8e8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r11+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8e0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r10+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8d8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r9+r15*8+0x10]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r8+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5e0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8c8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rdi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8c0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rsi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8b8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rcx+r15*8+0x10]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5d8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x590]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8a8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x588]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x8a0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x898]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x578]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x890]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x550]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x888]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x558]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x880]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x560]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x878]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x568]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x870]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x570]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5d0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x4e8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x860]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x528]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x858]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x510]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x850]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x508]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x5c8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r14+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x4f0]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r14+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x840]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r13+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x838]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r13+r15*8+0x10]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r12+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x830]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r12+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x7d8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x540]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [r12+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r11+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x828]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r11+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x7e0]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r11+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r10+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x820]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r10+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x588]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r10+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r9+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x5c0]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r9+r15*8+0x10]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r8+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x810]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r8+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x7e8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x590]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r8+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rdi+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x808]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rdi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x7b8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rdi+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rsi+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r10+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x800]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rsi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x558]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rsi+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rcx+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r12+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x7f8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rcx+r15*8+0x10]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rdx+r15*8+0x18]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rax+r15*8+0x18]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [r8+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x7f0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x5b8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x7c0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [rdx+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [rax+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x550]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x7a0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x788]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [rdx+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r9+r15*8+0x18]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x7c8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x560]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r10+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r11+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rdx+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x5b0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x568]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r12+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [r13+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rsi+r15*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r10+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [r9+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x7a8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x570]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x508]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [rax+r15*8+0x20], 0x1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x578]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rax+r15*8+0x18]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rdx+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rcx+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r12+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x798]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rax, qword ptr [rbp-0x4e8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x528]
|   1    |           |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmovupd ymm11, ymmword ptr [rdx+r15*8+0x10]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [rsi+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rdi+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r14+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm13, ymm11, ymmword ptr [rcx+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x790]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x510]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm14, xmmword ptr [r10+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [r11+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [rsi+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x780]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x4f0]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r12+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r13+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r8+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm9, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r14+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm10, ymm8, ymmword ptr [rax+r15*8+0x18]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r10+r15*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm9, ymm10
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [rsi+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm2, ymm0, ymmword ptr [rdi+r15*8+0x18]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [r8+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [r9+r15*8+0x18]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm5, ymm6
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm7, xmmword ptr [r10+r15*8+0x20], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm1, ymm8, ymmword ptr [r11+r15*8+0x18]
|   1*   |           |     |           |           |     |     |    | mov rax, r15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x520]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x770]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x4f8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm2, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm0, xmmword ptr [rdx+rax*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm4, xmmword ptr [rsi+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm5, xmmword ptr [rdi+rax*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x778]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x768]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x530]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x760]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x580]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm10, xmmword ptr [r8+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm11, xmmword ptr [r9+rax*8+0x20]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x518]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x750]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r15, qword ptr [rbp-0x548]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x758]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm1, ymm0, xmmword ptr [rdx+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm3, ymm1, ymmword ptr [rcx+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm0, xmmword ptr [r10+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm1, xmmword ptr [r11+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x748]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x5a0]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm6, ymm4, xmmword ptr [rsi+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm7, ymm5, xmmword ptr [rdi+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm9, ymm6, ymm7
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm6, xmmword ptr [r12+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x740]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x598]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm12, ymm10, xmmword ptr [r8+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm13, ymm11, xmmword ptr [r9+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm15, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm10, xmmword ptr [r14+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm11, xmmword ptr [r15+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm4, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x5a8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x738]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm2, ymm0, xmmword ptr [r10+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm3, ymm1, xmmword ptr [r11+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm5, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm0, xmmword ptr [rdx+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm1, xmmword ptr [rcx+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm8, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x730]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x500]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm7, ymm6, xmmword ptr [r12+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm9, ymm7, ymmword ptr [r13+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm6, xmmword ptr [rsi+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rdi+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x728]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x590]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm12, ymm10, xmmword ptr [r14+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm13, ymm11, xmmword ptr [r15+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm15, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm12, xmmword ptr [r8+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm4, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x720]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r15, qword ptr [rbp-0x588]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm2, ymm0, xmmword ptr [rdx+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm3, ymm1, xmmword ptr [rcx+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm5, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm0, xmmword ptr [r10+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm1, xmmword ptr [r11+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x540]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x718]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm6, xmmword ptr [rsi+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm9, ymm7, xmmword ptr [rdi+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm11, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm6, xmmword ptr [r12+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [r13+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm10, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x710]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x538]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm13, ymm12, xmmword ptr [r8+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm15, ymm13, ymmword ptr [r9+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm12, xmmword ptr [r14+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm13, xmmword ptr [r15+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm4, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x708]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x578]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm2, ymm0, xmmword ptr [r10+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm3, ymm1, xmmword ptr [r11+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm5, ymm2, ymm3
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm2, xmmword ptr [rdx+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x700]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x550]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm6, xmmword ptr [r12+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm9, ymm7, xmmword ptr [r13+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm11, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm6, xmmword ptr [rsi+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm7, xmmword ptr [rdi+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm10, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x558]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x6f8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm14, ymm12, xmmword ptr [r14+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm15, ymm13, xmmword ptr [r15+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm1, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm12, xmmword ptr [r8+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm13, xmmword ptr [r9+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm4, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x6f0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r15, qword ptr [rbp-0x560]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm3, ymm2, xmmword ptr [rdx+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm5, ymm3, ymmword ptr [rcx+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm2, xmmword ptr [r10+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r11+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x6e8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x568]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm8, ymm6, xmmword ptr [rsi+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm9, ymm7, xmmword ptr [rdi+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm11, ymm8, ymm9
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm8, xmmword ptr [r12+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm10, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x6e0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdi, qword ptr [rbp-0x570]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm14, ymm12, xmmword ptr [r8+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm15, ymm13, xmmword ptr [r9+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm1, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm12, xmmword ptr [r14+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm13, xmmword ptr [r15+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm6, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r8, qword ptr [rbp-0x4e8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r9, qword ptr [rbp-0x6d8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm2, xmmword ptr [r10+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm5, ymm3, xmmword ptr [r11+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm7, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm2, xmmword ptr [rdx+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rcx+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm10, ymm6, ymm7
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r10, qword ptr [rbp-0x6d0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r11, qword ptr [rbp-0x528]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm9, ymm8, xmmword ptr [r12+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm11, ymm9, ymmword ptr [r13+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm8, xmmword ptr [rsi+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm9, xmmword ptr [rdi+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm10, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r12, qword ptr [rbp-0x6c8]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r13, qword ptr [rbp-0x510]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm14, ymm12, xmmword ptr [r14+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm15, ymm13, xmmword ptr [r15+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm1, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r8+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm6, ymm0, ymm1
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r14, qword ptr [rbp-0x6c0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov r15, qword ptr [rbp-0x508]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm2, xmmword ptr [rdx+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm5, ymm3, xmmword ptr [rcx+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm7, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm2, xmmword ptr [r10+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [r11+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm6, ymm7
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rdx, qword ptr [rbp-0x4f0]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rcx, qword ptr [rbp-0x678]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm10, ymm8, xmmword ptr [rsi+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm11, ymm9, xmmword ptr [rdi+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm13, ymm10, ymm11
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm8, xmmword ptr [r12+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm9, xmmword ptr [r13+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm0, ymm12, ymm13
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | mov rsi, qword ptr [rbp-0x680]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm15, ymm14, xmmword ptr [r8+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm1, ymm15, ymmword ptr [r9+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm14, xmmword ptr [r14+rax*8+0x10]
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm15, xmmword ptr [r15+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm6, ymm0, ymm1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm2, xmmword ptr [r10+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm5, ymm3, xmmword ptr [r11+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm7, ymm4, ymm5
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     | CP | vmovupd xmm3, xmmword ptr [rdx+rax*8+0x20]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm12, ymm6, ymm7
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm10, ymm8, xmmword ptr [r12+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm11, ymm9, xmmword ptr [r13+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm13, ymm10, ymm11
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm1, ymm12, ymm13
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm14, ymm14, xmmword ptr [r14+rax*8+0x20], 0x1
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm0, ymm15, xmmword ptr [r15+rax*8+0x30], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm2, ymm14, ymm0
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm5, ymm1, ymm2
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | vinsertf128 ymm4, ymm3, xmmword ptr [rdx+rax*8+0x30], 0x1
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     | CP | vmulpd ymm6, ymm4, ymmword ptr [rcx+rax*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm7, ymm5, ymm6
|   2    |           |     | 0.5       | 0.5       | 1.0 |     |    | vmovupd xmmword ptr [rsi+rax*8+0x10], xmm7
|   2    |           |     | 0.5       | 0.5       | 1.0 |     |    | vextractf128 xmmword ptr [rsi+rax*8+0x20], ymm7, 0x1
|   1    |           |     |           |           |     | 1.0 |    | add rax, 0x4
|   2^   |           |     | 0.5       | 0.5       | 1.0 |     |    | mov qword ptr [rbp-0x600], rax
|   2^   |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 | CP | cmp rax, qword ptr [rbp-0x9a8]
|   0F   |           |     |           |           |     |     |    | jb 0xffffffffffffed0d
Total Num Of Uops: 963


Detected pointer increment: 32
{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Hostname
################################################################################
e0355

################################################################################
# Operating System
################################################################################
CentOS Linux release 7.6.1810 (Core) 
Derived from Red Hat Enterprise Linux 7.6 (Source)
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

CentOS Linux release 7.6.1810 (Core) 
CentOS Linux release 7.6.1810 (Core) 
cpe:/o:centos:centos:7

################################################################################
# Operating System (LSB)
################################################################################
/home/hpc/iwia/iwia84/INSPECT-repo/scripts/Artifact-description/machine-state.sh: line 149: lsb_release: command not found

################################################################################
# Operating System Kernel
################################################################################
Linux e0355 3.10.0-957.12.2.el7.x86_64 #1 SMP Tue May 14 21:24:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Logged in users
################################################################################
 10:36:56 up 1 day, 20:06,  0 users,  load average: 0.00, 0.06, 2.12
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CPUset
################################################################################
Domain N:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29,10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39

Domain S0:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29

Domain S1:
	10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39

Domain C0:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29

Domain C1:
	10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39

Domain M0:
	0,20,1,21,2,22,3,23,4,24,5,25,6,26,7,27,8,28,9,29

Domain M1:
	10,30,11,31,12,32,13,33,14,34,15,35,16,36,17,37,18,38,19,39


################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-39
Allowed Memory controllers: 0-1

################################################################################
# Topology
################################################################################
--------------------------------------------------------------------------------
CPU name:	Intel(R) Xeon(R) CPU E5-2660 v2 @ 2.20GHz
CPU type:	Intel Xeon IvyBridge EN/EP/EX processor
CPU stepping:	4
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:		2
Cores per socket:	10
Threads per core:	2
--------------------------------------------------------------------------------
HWThread	Thread		Core		Socket		Available
0		0		0		0		*
1		0		1		0		*
2		0		2		0		*
3		0		3		0		*
4		0		4		0		*
5		0		5		0		*
6		0		6		0		*
7		0		7		0		*
8		0		8		0		*
9		0		9		0		*
10		0		10		1		*
11		0		11		1		*
12		0		12		1		*
13		0		13		1		*
14		0		14		1		*
15		0		15		1		*
16		0		16		1		*
17		0		17		1		*
18		0		18		1		*
19		0		19		1		*
20		1		0		0		*
21		1		1		0		*
22		1		2		0		*
23		1		3		0		*
24		1		4		0		*
25		1		5		0		*
26		1		6		0		*
27		1		7		0		*
28		1		8		0		*
29		1		9		0		*
30		1		10		1		*
31		1		11		1		*
32		1		12		1		*
33		1		13		1		*
34		1		14		1		*
35		1		15		1		*
36		1		16		1		*
37		1		17		1		*
38		1		18		1		*
39		1		19		1		*
--------------------------------------------------------------------------------
Socket 0:		( 0 20 1 21 2 22 3 23 4 24 5 25 6 26 7 27 8 28 9 29 )
Socket 1:		( 10 30 11 31 12 32 13 33 14 34 15 35 16 36 17 37 18 38 19 39 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:			1
Size:			32 kB
Cache groups:		( 0 20 ) ( 1 21 ) ( 2 22 ) ( 3 23 ) ( 4 24 ) ( 5 25 ) ( 6 26 ) ( 7 27 ) ( 8 28 ) ( 9 29 ) ( 10 30 ) ( 11 31 ) ( 12 32 ) ( 13 33 ) ( 14 34 ) ( 15 35 ) ( 16 36 ) ( 17 37 ) ( 18 38 ) ( 19 39 )
--------------------------------------------------------------------------------
Level:			2
Size:			256 kB
Cache groups:		( 0 20 ) ( 1 21 ) ( 2 22 ) ( 3 23 ) ( 4 24 ) ( 5 25 ) ( 6 26 ) ( 7 27 ) ( 8 28 ) ( 9 29 ) ( 10 30 ) ( 11 31 ) ( 12 32 ) ( 13 33 ) ( 14 34 ) ( 15 35 ) ( 16 36 ) ( 17 37 ) ( 18 38 ) ( 19 39 )
--------------------------------------------------------------------------------
Level:			3
Size:			25 MB
Cache groups:		( 0 20 1 21 2 22 3 23 4 24 5 25 6 26 7 27 8 28 9 29 ) ( 10 30 11 31 12 32 13 33 14 34 15 35 16 36 17 37 18 38 19 39 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		2
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 20 1 21 2 22 3 23 4 24 5 25 6 26 7 27 8 28 9 29 )
Distances:		10 21
Free memory:		29794.8 MB
Total memory:		32734.2 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 10 30 11 31 12 32 13 33 14 34 15 35 16 36 17 37 18 38 19 39 )
Distances:		21 10
Free memory:		31405.7 MB
Total memory:		32768 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 20 21 22 23 24 25 26 27 28 29
node 0 size: 32734 MB
node 0 free: 29804 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 30 31 32 33 34 35 36 37 38 39
node 1 size: 32768 MB
node 1 free: 31406 MB
node distances:
node   0   1 
  0:  10  21 
  1:  21  10 

################################################################################
# Frequencies
################################################################################
Cannot read frequency data from cpufreq module


################################################################################
# Prefetchers
################################################################################
likwid-features not available

################################################################################
# Load
################################################################################
0.00 0.06 2.12 1/518 8212

################################################################################
# Performance energy bias
################################################################################
Performance energy bias: 7 (0=highest performance, 15 = lowest energy)

################################################################################
# NUMA balancing
################################################################################
Enabled: 1

################################################################################
# General memory info
################################################################################
MemTotal:       65936896 kB
MemFree:        62682920 kB
MemAvailable:   62459512 kB
Buffers:               0 kB
Cached:          1878240 kB
SwapCached:            0 kB
Active:            36820 kB
Inactive:        1855856 kB
Active(anon):      33404 kB
Inactive(anon):  1816932 kB
Active(file):       3416 kB
Inactive(file):    38924 kB
Unevictable:       50020 kB
Mlocked:           54116 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:            96 kB
AnonPages:         65252 kB
Mapped:            46636 kB
Shmem:           1835900 kB
Slab:             223836 kB
SReclaimable:      54184 kB
SUnreclaim:       169652 kB
KernelStack:        8752 kB
PageTables:         3384 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    32968448 kB
Committed_AS:    2021044 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      783248 kB
VmallocChunk:   34324873212 kB
HardwareCorrupted:     0 kB
AnonHugePages:     26624 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      299636 kB
DirectMap2M:     9103360 kB
DirectMap1G:    59768832 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: [always] madvise never
Use zero page: 1

################################################################################
# Hardware power limits
################################################################################
RAPL domain package-1
- Limit0 long_term MaxPower 95000000uW Limit 95000000uW TimeWindow 9994240us
- Limit1 short_term MaxPower 150000000uW Limit 114000000uW TimeWindow 7808us
RAPL domain core
- Limit0 long_term MaxPower NAuW Limit 0uW TimeWindow 976us
RAPL domain dram
- Limit0 long_term MaxPower 39000000uW Limit 0uW TimeWindow 976us
RAPL domain package-0
- Limit0 long_term MaxPower 95000000uW Limit 95000000uW TimeWindow 9994240us
- Limit1 short_term MaxPower 150000000uW Limit 114000000uW TimeWindow 7808us
RAPL domain core
- Limit0 long_term MaxPower NAuW Limit 0uW TimeWindow 976us
RAPL domain dram
- Limit0 long_term MaxPower 39000000uW Limit 0uW TimeWindow 976us

################################################################################
# Compiler
################################################################################
icc (ICC) 19.0.2.187 20190117
Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.


################################################################################
# MPI
################################################################################
Intel(R) MPI Library for Linux* OS, Version 2019 Update 2 Build 20190123 (id: e2d820d49)
Copyright 2003-2019, Intel Corporation.

################################################################################
# dmidecode
################################################################################
dmidecode not executable, so ask your administrator to put the
dmidecode output to a file (configured /etc/dmidecode.txt)

################################################################################
# environment variables
################################################################################
MKLROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
MANPATH=/apps/python/3.5-anaconda/share/man:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:/apps/intel/ComposerXE2019/man/common::/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:/apps/intel/mpi/man:/apps/likwid/4.3.4/man
MPILIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib
LESS_TERMCAP_mb=[1;32m
HOSTNAME=e0355
LESS_TERMCAP_md=[1;34m
PBS_VERSION=TORQUE-4.2.10
_LMFILES__modshare=/apps/modules/data/tools/python/3.5-anaconda:1:/apps/modules/data/development/intel64/19.0up02:1:/apps/modules/data/libraries/mkl/2019up02:1:/apps/modules/data/tools/likwid/4.3.4:1:/apps/modules/data/development/intelmpi/2019up02-intel:1
LESS_TERMCAP_me=[0m
MODULEPATH_modshare=/apps/modules/data/deprecated:4:/apps/modules/data/tools:4:/apps/modules/data/libraries:4:/apps/modules/data/testing:4:/apps/modules/data/via-spack:4:/apps/modules/data/development:4:/apps/modules/data/applications:4
INTEL_LICENSE_FILE=1713@license4
MKLPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
IPPROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp
SHELL=/bin/bash
HISTSIZE=1000
I_MPI_FABRICS=shm:ofa
QT_XFT=true
TMPDIR=/scratch/1114577.eadm
PBS_JOBNAME=IVY_stempel_bench
LIKWID_FORCE=1
FASTTMP=/elxfs/iwia/iwia84
LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
PBS_ENVIRONMENT=PBS_BATCH
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
LESS_TERMCAP_ue=[0m
PBS_O_WORKDIR=/home/hpc/iwia/iwia84/INSPECT
GROUP=iwia
PBS_TASKNUM=1
USER=iwia84
LS_COLORS=
LD_LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:/apps/likwid/4.3.4/lib
GDK_USE_XFT=1
PBS_O_HOME=/home/hpc/iwia/iwia84
PSTLROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
MKL_LIB=-Wl,--start-group /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_sequential.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
FI_PROVIDER_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib/prov
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_WALLTIME=86400
FPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
PBS_GPUFILE=/var/spool/torque/aux//1114577.eadmgpu
PBS_MOMPORT=15003
MKL_BASE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
LIKWID_INC=-I/apps/likwid/4.3.4/include
LESS_TERMCAP_us=[1;32m
PBS_O_QUEUE=route
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
MAIL=/var/spool/mail/iwia84
PBS_O_LOGNAME=iwia84
PATH=/apps/python/3.5-anaconda/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:/apps/likwid/4.3.4/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin:/usr/local/sbin:/usr/sbin
I_MPI_OFA_ADAPTER_NAME=mlx4_0
PBS_O_LANG=en_US.UTF-8
LIKWID_INCDIR=/apps/likwid/4.3.4/include
WORK=/home/woody/iwia/iwia84
PBS_JOBCOOKIE=8A7297392C5FEE5CD40A123D1B251E66
TBBROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r2_heterogeneous_box_variable/IvyBridgeEP_E5-2660v2_20190523_103656
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
_LMFILES_=/apps/modules/data/tools/likwid/4.3.4:/apps/modules/data/development/intelmpi/2019up02-intel:/apps/modules/data/libraries/mkl/2019up02:/apps/modules/data/development/intel64/19.0up02:/apps/modules/data/tools/python/3.5-anaconda
EDITOR=/usr/bin/vim
PBS_NODENUM=0
LANG=C.UTF-8
MODULEPATH=/apps/modules/data/applications:/apps/modules/data/development:/apps/modules/data/libraries:/apps/modules/data/tools:/apps/modules/data/via-spack:/apps/modules/data/deprecated:/apps/modules/data/testing
MPIINCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
INTEL_LICENSE_FILE_modshare=1713@license4:1
PBS_NUM_NODES=1
LOADEDMODULES=likwid/4.3.4:intelmpi/2019up02-intel:mkl/2019up02:intel64/19.0up02:python/3.5-anaconda
INTEL_F_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
GCC_COLORS=error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01
PBS_O_SHELL=/bin/bash
MKL_CDFT=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_cdft_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
MKL_SCALAPACK=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_scalapack_lp64.a -Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
CPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
MPIROOTDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
I_MPI_HARD_FINALIZE=1
PBS_JOBID=1114577.eadm
DAALROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal
HISTCONTROL=ignoredups
ENVIRONMENT=BATCH
INTEL_PYTHONHOME=/apps/intel/ComposerXE2019/debugger_2019/python/intel64/
SHLVL=3
HOME=/home/hpc/iwia/iwia84
MKL_INC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PATH_modshare=/home/julian/.local/.bin:1:/usr/bin/vendor_perl:1:/opt/android-sdk/tools:1:/usr/bin:1:/apps/python/3.5-anaconda/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/bin/core_perl:1:/opt/android-sdk/platform-tools:1:/usr/local/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/home/julian/.bin:1:/usr/sbin:1:/apps/likwid/4.3.4/bin:1:/opt/intel/bin:1:/usr/local/sbin:1
PBS_O_HOST=emmy2.rrze.uni-erlangen.de
LIKWID_LIB=-L/apps/likwid/4.3.4/lib
WOODYHOME=/home/woody/iwia/iwia84
HPCVAULT=/home/vault/iwia/iwia84
MANPATH_modshare=/apps/python/3.5-anaconda/share/man:1::1:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:1:/apps/intel/ComposerXE2019/man/common:2:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:2:/apps/intel/mpi/man:1:/apps/likwid/4.3.4/man:1
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
PBS_VNODENUM=0
BASH_ENV=/etc/profile
MKL_INCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NLSPATH_modshare=/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:1
LESS=-R
LOGNAME=iwia84
PYTHONPATH=/home/hpc/iwia/iwia84/kerncraft/kerncraft-ivy//lib/python3.5/site-packages/
CVS_RSH=ssh
LD_LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/likwid/4.3.4/lib:1:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
LESS_TERMCAP_so=[1;44;1m
PBS_QUEUE=work
CLASSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar
MKL_SLIB_THREADED=-Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -lpthread -lm -openmp
MODULESHOME=/apps/modules
LESSOPEN=||/usr/bin/lesspipe.sh %s
PBS_MICFILE=/var/spool/torque/aux//1114577.eadmmic
PBS_O_SUBMIT_FILTER=/usr/local/sbin/torque_submitfilter
PBS_O_MAIL=/var/spool/mail/iwia84
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
LOADEDMODULES_modshare=intel64/19.0up02:1:python/3.5-anaconda:1:intelmpi/2019up02-intel:1:mkl/2019up02:1:likwid/4.3.4:1
INFOPATH=/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/info/
INFOPATH_modshare=/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/info/:1
PBS_NP=40
PBS_NUM_PPN=40
PBS_O_SERVER=eadm
INCLUDE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
INTEL_C_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LIKWID_LIBDIR=/apps/likwid/4.3.4/lib
I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=off
SCRATCH=/scratch
PBS_NODEFILE=/var/spool/torque/aux//1114577.eadm
LESS_TERMCAP_se=[0m
PBS_O_PATH=/apps/git/2.2.1/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
MKL_SHLIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm
I_MPI_ROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi
_=/usr/bin/env
{%- endcapture -%}

{% include stencil_template.md %}
