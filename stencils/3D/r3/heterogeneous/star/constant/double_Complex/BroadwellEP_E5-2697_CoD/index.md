---

title:  "Stencil 3D r3 star constant heterogeneous double _Complex BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "r3"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double _Complex"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "EDIT_ME"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp "
flop         : "37"
scaling      : [ "130" ]
blocking     : []
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double _Complex a[M][N][P];
double _Complex b[M][N][P];
double _Complex c0;
double _Complex c1;
double _Complex c2;
double _Complex c3;
double _Complex c4;
double _Complex c5;
double _Complex c6;
double _Complex c7;
double _Complex c8;
double _Complex c9;
double _Complex c10;
double _Complex c11;
double _Complex c12;
double _Complex c13;
double _Complex c14;
double _Complex c15;
double _Complex c16;
double _Complex c17;
double _Complex c18;

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
+ c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
+ c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
+ c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
+ c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
+ c11 * a[k][j-2][i] + c12 * a[k][j+2][i]
+ c13 * a[k][j][i-3] + c14 * a[k][j][i+3]
+ c15 * a[k-3][j][i] + c16 * a[k+3][j][i]
+ c17 * a[k][j-3][i] + c18 * a[k][j+3][i]
;
}
}
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vmovupd xmm15, xmmword ptr [r13+rbx*1+0x30]
vunpckhpd xmm0, xmm15, xmm15
inc rax
vmulpd xmm14, xmm0, xmmword ptr [rsp+0x4d0]
vmovupd xmm15, xmmword ptr [r13+rbx*1+0x20]
vmovddup xmm0, qword ptr [r13+rbx*1+0x30]
vfmaddsub213pd xmm0, xmm9, xmm14
vunpckhpd xmm14, xmm15, xmm15
vmulpd xmm15, xmm14, xmmword ptr [rsp+0x590]
vmovddup xmm14, qword ptr [r13+rbx*1+0x20]
vfmaddsub213pd xmm14, xmm8, xmm15
vaddpd xmm14, xmm0, xmm14
vmovupd xmm0, xmmword ptr [r13+rbx*1+0x40]
vunpckhpd xmm0, xmm0, xmm0
vmulpd xmm15, xmm0, xmmword ptr [rsp+0x570]
vmovddup xmm0, qword ptr [r13+rbx*1+0x40]
vfmaddsub132pd xmm0, xmm15, xmmword ptr [rsp+0x5b0]
vaddpd xmm0, xmm14, xmm0
vmovupd xmm14, xmmword ptr [r13+r12*1+0x30]
vunpckhpd xmm15, xmm14, xmm14
vmulpd xmm14, xmm15, xmmword ptr [rsp+0x4a0]
vmovddup xmm15, qword ptr [r13+r12*1+0x30]
vfmaddsub213pd xmm15, xmm7, xmm14
vaddpd xmm15, xmm0, xmm15
vmovupd xmm0, xmmword ptr [r13+r14*1+0x30]
vunpckhpd xmm0, xmm0, xmm0
vmulpd xmm14, xmm0, xmmword ptr [rsp+0x500]
vmovddup xmm0, qword ptr [r13+r14*1+0x30]
vfmaddsub213pd xmm0, xmm6, xmm14
vaddpd xmm14, xmm15, xmm0
vmovupd xmm15, xmmword ptr [r13+rcx*1+0x30]
vunpckhpd xmm0, xmm15, xmm15
vmulpd xmm15, xmm0, xmmword ptr [rsp+0x510]
vmovddup xmm0, qword ptr [r13+rcx*1+0x30]
vfmaddsub213pd xmm0, xmm5, xmm15
vaddpd xmm0, xmm14, xmm0
vmovupd xmm14, xmmword ptr [r13+r9*1+0x30]
vunpckhpd xmm14, xmm14, xmm14
vmulpd xmm15, xmm14, xmmword ptr [rsp+0x4f0]
vmovddup xmm14, qword ptr [r13+r9*1+0x30]
vfmaddsub213pd xmm14, xmm4, xmm15
vaddpd xmm15, xmm0, xmm14
vmovupd xmm0, xmmword ptr [r13+rbx*1+0x10]
vunpckhpd xmm0, xmm0, xmm0
vmulpd xmm14, xmm0, xmmword ptr [rsp+0x4b0]
vmovddup xmm0, qword ptr [r13+rbx*1+0x10]
vfmaddsub213pd xmm0, xmm3, xmm14
vaddpd xmm14, xmm15, xmm0
vmovupd xmm15, xmmword ptr [r13+rbx*1+0x50]
vunpckhpd xmm0, xmm15, xmm15
vmulpd xmm15, xmm0, xmmword ptr [rsp+0x490]
vmovddup xmm0, qword ptr [r13+rbx*1+0x50]
vfmaddsub213pd xmm0, xmm2, xmm15
vaddpd xmm0, xmm14, xmm0
vmovupd xmm14, xmmword ptr [r13+r8*1+0x30]
vunpckhpd xmm14, xmm14, xmm14
vmulpd xmm15, xmm14, xmmword ptr [rsp+0x560]
vmovddup xmm14, qword ptr [r13+r8*1+0x30]
vfmaddsub213pd xmm14, xmm13, xmm15
vaddpd xmm15, xmm0, xmm14
vmovupd xmm0, xmmword ptr [r13+rdi*1+0x30]
vunpckhpd xmm0, xmm0, xmm0
vmulpd xmm14, xmm0, xmmword ptr [rsp+0x580]
vmovddup xmm0, qword ptr [r13+rdi*1+0x30]
vfmaddsub132pd xmm0, xmm14, xmmword ptr [rbp+0x70]
mov r15, qword ptr [rsp+0x5d8]
vaddpd xmm14, xmm15, xmm0
nop dword ptr [rax], eax
vmovupd xmm15, xmmword ptr [r13+r15*1+0x30]
vunpckhpd xmm0, xmm15, xmm15
vmulpd xmm15, xmm0, xmmword ptr [rsp+0x5a0]
vmovddup xmm0, qword ptr [r13+r15*1+0x30]
vfmaddsub132pd xmm0, xmm15, xmmword ptr [rbp+0x80]
mov r15, qword ptr [rsp+0x5c8]
vaddpd xmm0, xmm14, xmm0
vmovupd xmm14, xmmword ptr [r13+r15*1+0x30]
vunpckhpd xmm14, xmm14, xmm14
vmulpd xmm15, xmm14, xmmword ptr [rsp+0x480]
vmovddup xmm14, qword ptr [r13+r15*1+0x30]
vfmaddsub132pd xmm14, xmm15, xmmword ptr [rbp+0x90]
vaddpd xmm15, xmm0, xmm14
vmovupd xmm0, xmmword ptr [r13+rbx*1]
vunpckhpd xmm0, xmm0, xmm0
vmulpd xmm14, xmm0, xmmword ptr [rsp+0x4c0]
vmovddup xmm0, qword ptr [r13+rbx*1]
vfmaddsub132pd xmm0, xmm14, xmmword ptr [rbp+0xa0]
vaddpd xmm14, xmm15, xmm0
vmovupd xmm15, xmmword ptr [r13+rbx*1+0x60]
vunpckhpd xmm0, xmm15, xmm15
vmulpd xmm15, xmm0, xmmword ptr [rsp+0x540]
vmovddup xmm0, qword ptr [r13+rbx*1+0x60]
vfmaddsub132pd xmm0, xmm15, xmmword ptr [rbp+0xb0]
vaddpd xmm0, xmm14, xmm0
vmovupd xmm14, xmmword ptr [r13+rsi*1+0x30]
vunpckhpd xmm14, xmm14, xmm14
vmulpd xmm15, xmm14, xmmword ptr [rsp+0x4e0]
vmovddup xmm14, qword ptr [r13+rsi*1+0x30]
vfmaddsub213pd xmm14, xmm12, xmm15
vaddpd xmm15, xmm0, xmm14
vmovupd xmm0, xmmword ptr [r13+r10*1+0x30]
vunpckhpd xmm0, xmm0, xmm0
vmulpd xmm14, xmm0, xmmword ptr [rsp+0x550]
vmovddup xmm0, qword ptr [r13+r10*1+0x30]
vfmaddsub213pd xmm0, xmm11, xmm14
vaddpd xmm14, xmm15, xmm0
vmovupd xmm15, xmmword ptr [r13+r11*1+0x30]
vunpckhpd xmm0, xmm15, xmm15
vmulpd xmm15, xmm0, xmmword ptr [rsp+0x520]
vmovddup xmm0, qword ptr [r13+r11*1+0x30]
vfmaddsub213pd xmm0, xmm10, xmm15
mov r15, qword ptr [rsp+0x5d0]
vaddpd xmm0, xmm14, xmm0
vmovupd xmm14, xmmword ptr [r13+r15*1+0x30]
vunpckhpd xmm14, xmm14, xmm14
vmulpd xmm15, xmm14, xmmword ptr [rsp+0x530]
vmovddup xmm14, qword ptr [r13+r15*1+0x30]
vfmaddsub213pd xmm14, xmm1, xmm15
vaddpd xmm0, xmm0, xmm14
vmovupd xmmword ptr [r13+rdx*1+0x30], xmm0
add r13, 0x10
cmp rax, qword ptr [rsp+0x5e0]
jb 0xfffffffffffffcfd
{%- endcapture -%}

{%- capture layer_condition -%}
### Layer conditions for L1 cache with 32 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```32*M*N*P < 32768```|0|20|
|```128*N*P - 96*P <= 32768```|2|18|
|```128*N*P + 96*P <= 32768```|4|16|
|```224*P - 384 <= 32768```|8|12|
|```224*P + 96 <= 32768```|10|10|
|Else|14|6|

### Layer conditions for L2 cache with 256 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```32*M*N*P < 262144```|0|20|
|```128*N*P - 96*P <= 262144```|2|18|
|```128*N*P + 96*P <= 262144```|4|16|
|```224*P - 384 <= 262144```|8|12|
|```224*P + 96 <= 262144```|10|10|
|Else|14|6|

### Layer conditions for L3 cache with 23040 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```32*M*N*P < 23592960```|0|20|
|```128*N*P - 96*P <= 23592960```|2|18|
|```128*N*P + 96*P <= 23592960```|4|16|
|```224*P - 384 <= 23592960```|8|12|
|```224*P + 96 <= 23592960```|10|10|
|Else|14|6|


{%- endcapture -%}

{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 36.21 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 28.0     0.0  | 28.0  | 34.0    33.0  | 34.0    34.0  |  1.0  | 19.0  |  3.0  |  0.0  |
--------------------------------------------------------------------------------------------------

DV - Divider pipe (on port 0)
D - Data fetch pipe (on ports 2 and 3)
F - Macro Fusion with the previous instruction occurred
* - instruction micro-ops not bound to a port
^ - Micro Fusion occurred
# - ESP Tracking sync uop was issued
@ - SSE instruction followed an AVX256/AVX512 instruction, dozens of cycles penalty is expected
X - instruction not supported, was not accounted in Analysis

| Num Of   |                    Ports pressure in cycles                         |      |
|  Uops    |  0  - DV    |  1   |  2  -  D    |  3  -  D    |  4   |  5   |  6   |  7   |
-----------------------------------------------------------------------------------------
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+rbx*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm15, xmm15
|   1      |             |      |             |             |      |      | 1.0  |      | inc rax
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm14, xmm0, xmmword ptr [rsp+0x4d0]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+rbx*1+0x20]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+rbx*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm9, xmm14
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm14, xmm15, xmm15
|   2^     |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm14, xmmword ptr [rsp+0x590]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm14, qword ptr [r13+rbx*1+0x20]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm14, xmm8, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm14, xmm0, xmm14
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm0, xmmword ptr [r13+rbx*1+0x40]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm0, xmm0
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm15, xmm0, xmmword ptr [rsp+0x570]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm0, qword ptr [r13+rbx*1+0x40]
|   2^     |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vfmaddsub132pd xmm0, xmm15, xmmword ptr [rsp+0x5b0]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm14, xmm0
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm14, xmmword ptr [r13+r12*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm15, xmm14, xmm14
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm14, xmm15, xmmword ptr [rsp+0x4a0]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm15, qword ptr [r13+r12*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm15, xmm7, xmm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm15, xmm0, xmm15
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm0, xmmword ptr [r13+r14*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm0, xmm0
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm14, xmm0, xmmword ptr [rsp+0x500]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+r14*1+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm6, xmm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm14, xmm15, xmm0
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+rcx*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm15, xmm15
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm15, xmm0, xmmword ptr [rsp+0x510]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm0, qword ptr [r13+rcx*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm5, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm14, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm14, xmmword ptr [r13+r9*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm14, xmm14, xmm14
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm14, xmmword ptr [rsp+0x4f0]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm14, qword ptr [r13+r9*1+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vfmaddsub213pd xmm14, xmm4, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm15, xmm0, xmm14
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm0, xmmword ptr [r13+rbx*1+0x10]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm0, xmm0
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm14, xmm0, xmmword ptr [rsp+0x4b0]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm0, qword ptr [r13+rbx*1+0x10]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm3, xmm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm14, xmm15, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+rbx*1+0x50]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm15, xmm15
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm0, xmmword ptr [rsp+0x490]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+rbx*1+0x50]
|   1      |             | 1.0  |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm2, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm14, xmm0
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm14, xmmword ptr [r13+r8*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm14, xmm14, xmm14
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm15, xmm14, xmmword ptr [rsp+0x560]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm14, qword ptr [r13+r8*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm14, xmm13, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm15, xmm0, xmm14
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm0, xmmword ptr [r13+rdi*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm0, xmm0
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm14, xmm0, xmmword ptr [rsp+0x580]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+rdi*1+0x30]
|   2^     |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vfmaddsub132pd xmm0, xmm14, xmmword ptr [rbp+0x70]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | mov r15, qword ptr [rsp+0x5d8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm14, xmm15, xmm0
|   0X     |             |      |             |             |      |      |      |      | nop dword ptr [rax], eax
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+r15*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm15, xmm15
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm15, xmm0, xmmword ptr [rsp+0x5a0]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm0, qword ptr [r13+r15*1+0x30]
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vfmaddsub132pd xmm0, xmm15, xmmword ptr [rbp+0x80]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | mov r15, qword ptr [rsp+0x5c8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm14, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm14, xmmword ptr [r13+r15*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm14, xmm14, xmm14
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm14, xmmword ptr [rsp+0x480]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm14, qword ptr [r13+r15*1+0x30]
|   2^     |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vfmaddsub132pd xmm14, xmm15, xmmword ptr [rbp+0x90]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm15, xmm0, xmm14
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm0, xmmword ptr [r13+rbx*1]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm0, xmm0
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm14, xmm0, xmmword ptr [rsp+0x4c0]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+rbx*1]
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmaddsub132pd xmm0, xmm14, xmmword ptr [rbp+0xa0]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm14, xmm15, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+rbx*1+0x60]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm15, xmm15
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm0, xmmword ptr [rsp+0x540]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+rbx*1+0x60]
|   2^     |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vfmaddsub132pd xmm0, xmm15, xmmword ptr [rbp+0xb0]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm14, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm14, xmmword ptr [r13+rsi*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm14, xmm14, xmm14
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm14, xmmword ptr [rsp+0x4e0]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm14, qword ptr [r13+rsi*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm14, xmm12, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm15, xmm0, xmm14
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd xmm0, xmmword ptr [r13+r10*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm0, xmm0
|   2^     | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd xmm14, xmm0, xmmword ptr [rsp+0x550]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup xmm0, qword ptr [r13+r10*1+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm11, xmm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm14, xmm15, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm15, xmmword ptr [r13+r11*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm0, xmm15, xmm15
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm0, xmmword ptr [rsp+0x520]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm0, qword ptr [r13+r11*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd xmm0, xmm10, xmm15
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | mov r15, qword ptr [rsp+0x5d0]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm14, xmm0
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd xmm14, xmmword ptr [r13+r15*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm14, xmm14, xmm14
|   2^     | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd xmm15, xmm14, xmmword ptr [rsp+0x530]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup xmm14, qword ptr [r13+r15*1+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vfmaddsub213pd xmm14, xmm1, xmm15
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm0, xmm0, xmm14
|   2      |             |      | 1.0         |             | 1.0  |      |      |      | vmovupd xmmword ptr [r13+rdx*1+0x30], xmm0
|   1      |             |      |             |             |      |      | 1.0  |      | add r13, 0x10
|   2^     |             |      |             | 1.0     1.0 |      |      | 1.0  |      | cmp rax, qword ptr [rsp+0x5e0]
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffcfd
Total Num Of Uops: 147
Analysis Notes:
There was an unsupported instruction(s), it was not accounted in Analysis.
Backend allocation was stalled due to unavailable allocation resources.
{%- endcapture -%}

{%- capture hostinfo -%}

################################################################################
# Hostname
################################################################################
broadep2.rrze.uni-erlangen.de

################################################################################
# Operating System
################################################################################
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.2 LTS"
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic

################################################################################
# Operating System (LSB)
################################################################################
No LSB modules are available.

################################################################################
# Operating System Kernel
################################################################################
Linux broadep2 4.15.0-48-generic #51-Ubuntu SMP Wed Apr 3 08:28:49 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Logged in users
################################################################################
 11:04:18 up 80 days,  1:18,  0 users,  load average: 3.36, 2.32, 1.23
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CPUset
################################################################################
Domain N:
	0,36,1,37,2,38,3,39,4,40,5,41,6,42,7,43,8,44,9,45,10,46,11,47,12,48,13,49,14,50,15,51,16,52,17,53,18,54,19,55,20,56,21,57,22,58,23,59,24,60,25,61,26,62,27,63,28,64,29,65,30,66,31,67,32,68,33,69,34,70,35,71

Domain S0:
	0,36,1,37,2,38,3,39,4,40,5,41,6,42,7,43,8,44,9,45,10,46,11,47,12,48,13,49,14,50,15,51,16,52,17,53

Domain S1:
	18,54,19,55,20,56,21,57,22,58,23,59,24,60,25,61,26,62,27,63,28,64,29,65,30,66,31,67,32,68,33,69,34,70,35,71

Domain C0:
	0,36,1,37,2,38,3,39,4,40,5,41,6,42,7,43,8,44

Domain C1:
	9,45,10,46,11,47,12,48,13,49,14,50,15,51,16,52,17,53

Domain C2:
	18,54,19,55,20,56,21,57,22,58,23,59,24,60,25,61,26,62

Domain C3:
	27,63,28,64,29,65,30,66,31,67,32,68,33,69,34,70,35,71

Domain M0:
	0,36,1,37,2,38,3,39,4,40,5,41,6,42,7,43,8,44

Domain M1:
	9,45,10,46,11,47,12,48,13,49,14,50,15,51,16,52,17,53

Domain M2:
	18,54,19,55,20,56,21,57,22,58,23,59,24,60,25,61,26,62

Domain M3:
	27,63,28,64,29,65,30,66,31,67,32,68,33,69,34,70,35,71


################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-71
Allowed Memory controllers: 0-3

################################################################################
# Topology
################################################################################
--------------------------------------------------------------------------------
CPU name:	Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz
CPU type:	Intel Xeon Broadwell EN/EP/EX processor
CPU stepping:	1
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:		2
Cores per socket:	18
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
10		0		10		0		*
11		0		11		0		*
12		0		12		0		*
13		0		13		0		*
14		0		14		0		*
15		0		15		0		*
16		0		16		0		*
17		0		17		0		*
18		0		18		1		*
19		0		19		1		*
20		0		20		1		*
21		0		21		1		*
22		0		22		1		*
23		0		23		1		*
24		0		24		1		*
25		0		25		1		*
26		0		26		1		*
27		0		27		1		*
28		0		28		1		*
29		0		29		1		*
30		0		30		1		*
31		0		31		1		*
32		0		32		1		*
33		0		33		1		*
34		0		34		1		*
35		0		35		1		*
36		1		0		0		*
37		1		1		0		*
38		1		2		0		*
39		1		3		0		*
40		1		4		0		*
41		1		5		0		*
42		1		6		0		*
43		1		7		0		*
44		1		8		0		*
45		1		9		0		*
46		1		10		0		*
47		1		11		0		*
48		1		12		0		*
49		1		13		0		*
50		1		14		0		*
51		1		15		0		*
52		1		16		0		*
53		1		17		0		*
54		1		18		1		*
55		1		19		1		*
56		1		20		1		*
57		1		21		1		*
58		1		22		1		*
59		1		23		1		*
60		1		24		1		*
61		1		25		1		*
62		1		26		1		*
63		1		27		1		*
64		1		28		1		*
65		1		29		1		*
66		1		30		1		*
67		1		31		1		*
68		1		32		1		*
69		1		33		1		*
70		1		34		1		*
71		1		35		1		*
--------------------------------------------------------------------------------
Socket 0:		( 0 36 1 37 2 38 3 39 4 40 5 41 6 42 7 43 8 44 9 45 10 46 11 47 12 48 13 49 14 50 15 51 16 52 17 53 )
Socket 1:		( 18 54 19 55 20 56 21 57 22 58 23 59 24 60 25 61 26 62 27 63 28 64 29 65 30 66 31 67 32 68 33 69 34 70 35 71 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:			1
Size:			32 kB
Cache groups:		( 0 36 ) ( 1 37 ) ( 2 38 ) ( 3 39 ) ( 4 40 ) ( 5 41 ) ( 6 42 ) ( 7 43 ) ( 8 44 ) ( 9 45 ) ( 10 46 ) ( 11 47 ) ( 12 48 ) ( 13 49 ) ( 14 50 ) ( 15 51 ) ( 16 52 ) ( 17 53 ) ( 18 54 ) ( 19 55 ) ( 20 56 ) ( 21 57 ) ( 22 58 ) ( 23 59 ) ( 24 60 ) ( 25 61 ) ( 26 62 ) ( 27 63 ) ( 28 64 ) ( 29 65 ) ( 30 66 ) ( 31 67 ) ( 32 68 ) ( 33 69 ) ( 34 70 ) ( 35 71 )
--------------------------------------------------------------------------------
Level:			2
Size:			256 kB
Cache groups:		( 0 36 ) ( 1 37 ) ( 2 38 ) ( 3 39 ) ( 4 40 ) ( 5 41 ) ( 6 42 ) ( 7 43 ) ( 8 44 ) ( 9 45 ) ( 10 46 ) ( 11 47 ) ( 12 48 ) ( 13 49 ) ( 14 50 ) ( 15 51 ) ( 16 52 ) ( 17 53 ) ( 18 54 ) ( 19 55 ) ( 20 56 ) ( 21 57 ) ( 22 58 ) ( 23 59 ) ( 24 60 ) ( 25 61 ) ( 26 62 ) ( 27 63 ) ( 28 64 ) ( 29 65 ) ( 30 66 ) ( 31 67 ) ( 32 68 ) ( 33 69 ) ( 34 70 ) ( 35 71 )
--------------------------------------------------------------------------------
Level:			3
Size:			11 MB
Cache groups:		( 0 36 1 37 2 38 3 39 4 40 5 41 6 42 7 43 8 44 ) ( 9 45 10 46 11 47 12 48 13 49 14 50 15 51 16 52 17 53 ) ( 18 54 19 55 20 56 21 57 22 58 23 59 24 60 25 61 26 62 ) ( 27 63 28 64 29 65 30 66 31 67 32 68 33 69 34 70 35 71 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		4
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 36 1 37 2 38 3 39 4 40 5 41 6 42 7 43 8 44 )
Distances:		10 21 31 31
Free memory:		31232.6 MB
Total memory:		32062.8 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 9 45 10 46 11 47 12 48 13 49 14 50 15 51 16 52 17 53 )
Distances:		21 10 31 31
Free memory:		31729.1 MB
Total memory:		32231.5 MB
--------------------------------------------------------------------------------
Domain:			2
Processors:		( 18 54 19 55 20 56 21 57 22 58 23 59 24 60 25 61 26 62 )
Distances:		31 31 10 21
Free memory:		32068.2 MB
Total memory:		32252.6 MB
--------------------------------------------------------------------------------
Domain:			3
Processors:		( 27 63 28 64 29 65 30 66 31 67 32 68 33 69 34 70 35 71 )
Distances:		31 31 21 10
Free memory:		32023.4 MB
Total memory:		32251.1 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 36 37 38 39 40 41 42 43 44
node 0 size: 32062 MB
node 0 free: 31232 MB
node 1 cpus: 9 10 11 12 13 14 15 16 17 45 46 47 48 49 50 51 52 53
node 1 size: 32231 MB
node 1 free: 31739 MB
node 2 cpus: 18 19 20 21 22 23 24 25 26 54 55 56 57 58 59 60 61 62
node 2 size: 32252 MB
node 2 free: 32068 MB
node 3 cpus: 27 28 29 30 31 32 33 34 35 63 64 65 66 67 68 69 70 71
node 3 size: 32251 MB
node 3 free: 32023 MB
node distances:
node   0   1   2   3 
  0:  10  21  31  31 
  1:  21  10  31  31 
  2:  31  31  10  21 
  3:  31  31  21  10 

################################################################################
# Frequencies
################################################################################
Current CPU frequencies:
CPU 0: governor  performance min/cur/max 2.3/1.282891/2.3 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.3/1.643382/2.3 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.3/1.682964/2.3 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.3/1.688886/2.3 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.3/1.682575/2.3 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.3/1.672537/2.3 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.3/1.780482/2.3 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.3/1.683536/2.3 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.3/1.897881/2.3 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.3/1.59272/2.3 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.3/1.678422/2.3 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.3/1.670911/2.3 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.3/1.636757/2.3 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.3/1.704693/2.3 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.3/1.682209/2.3 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.3/1.731728/2.3 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.3/1.638891/2.3 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.3/1.752243/2.3 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.3/2.291743/2.3 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.3/2.292318/2.3 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.3/2.292025/2.3 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.3/2.291237/2.3 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.3/2.292791/2.3 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.3/2.287215/2.3 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.3/2.296424/2.3 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.3/2.294954/2.3 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.3/2.291521/2.3 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.3/2.28705/2.3 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.3/2.111536/2.3 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.3/2.297436/2.3 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.3/2.188866/2.3 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.3/2.291651/2.3 GHz Turbo 0
CPU 32: governor  performance min/cur/max 2.3/2.181188/2.3 GHz Turbo 0
CPU 33: governor  performance min/cur/max 2.3/2.255305/2.3 GHz Turbo 0
CPU 34: governor  performance min/cur/max 2.3/2.273361/2.3 GHz Turbo 0
CPU 35: governor  performance min/cur/max 2.3/2.29649/2.3 GHz Turbo 0
CPU 36: governor  performance min/cur/max 2.3/1.639198/2.3 GHz Turbo 0
CPU 37: governor  performance min/cur/max 2.3/1.960881/2.3 GHz Turbo 0
CPU 38: governor  performance min/cur/max 2.3/1.7686/2.3 GHz Turbo 0
CPU 39: governor  performance min/cur/max 2.3/1.768333/2.3 GHz Turbo 0
CPU 40: governor  performance min/cur/max 2.3/1.628637/2.3 GHz Turbo 0
CPU 41: governor  performance min/cur/max 2.3/1.639571/2.3 GHz Turbo 0
CPU 42: governor  performance min/cur/max 2.3/1.748498/2.3 GHz Turbo 0
CPU 43: governor  performance min/cur/max 2.3/1.667002/2.3 GHz Turbo 0
CPU 44: governor  performance min/cur/max 2.3/1.664393/2.3 GHz Turbo 0
CPU 45: governor  performance min/cur/max 2.3/1.696865/2.3 GHz Turbo 0
CPU 46: governor  performance min/cur/max 2.3/1.792924/2.3 GHz Turbo 0
CPU 47: governor  performance min/cur/max 2.3/1.637187/2.3 GHz Turbo 0
CPU 48: governor  performance min/cur/max 2.3/1.668705/2.3 GHz Turbo 0
CPU 49: governor  performance min/cur/max 2.3/1.639494/2.3 GHz Turbo 0
CPU 50: governor  performance min/cur/max 2.3/1.658486/2.3 GHz Turbo 0
CPU 51: governor  performance min/cur/max 2.3/1.666477/2.3 GHz Turbo 0
CPU 52: governor  performance min/cur/max 2.3/1.671841/2.3 GHz Turbo 0
CPU 53: governor  performance min/cur/max 2.3/1.671802/2.3 GHz Turbo 0
CPU 54: governor  performance min/cur/max 2.3/2.289184/2.3 GHz Turbo 0
CPU 55: governor  performance min/cur/max 2.3/2.294919/2.3 GHz Turbo 0
CPU 56: governor  performance min/cur/max 2.3/2.293998/2.3 GHz Turbo 0
CPU 57: governor  performance min/cur/max 2.3/2.292239/2.3 GHz Turbo 0
CPU 58: governor  performance min/cur/max 2.3/2.285073/2.3 GHz Turbo 0
CPU 59: governor  performance min/cur/max 2.3/2.294732/2.3 GHz Turbo 0
CPU 60: governor  performance min/cur/max 2.3/2.292121/2.3 GHz Turbo 0
CPU 61: governor  performance min/cur/max 2.3/2.294453/2.3 GHz Turbo 0
CPU 62: governor  performance min/cur/max 2.3/2.29372/2.3 GHz Turbo 0
CPU 63: governor  performance min/cur/max 2.3/2.296243/2.3 GHz Turbo 0
CPU 64: governor  performance min/cur/max 2.3/2.277572/2.3 GHz Turbo 0
CPU 65: governor  performance min/cur/max 2.3/2.297486/2.3 GHz Turbo 0
CPU 66: governor  performance min/cur/max 2.3/2.097558/2.3 GHz Turbo 0
CPU 67: governor  performance min/cur/max 2.3/2.286136/2.3 GHz Turbo 0
CPU 68: governor  performance min/cur/max 2.3/2.293954/2.3 GHz Turbo 0
CPU 69: governor  performance min/cur/max 2.3/2.294844/2.3 GHz Turbo 0
CPU 70: governor  performance min/cur/max 2.3/2.296183/2.3 GHz Turbo 0
CPU 71: governor  performance min/cur/max 2.3/2.295211/2.3 GHz Turbo 0

Current Uncore frequencies:
Socket 0: min/max 2.3/2.3 GHz
Socket 1: min/max 2.3/2.3 GHz

################################################################################
# Prefetchers
################################################################################
Feature               CPU 0	CPU 36	CPU 1	CPU 37	CPU 2	CPU 38	CPU 3	CPU 39	CPU 4	CPU 40	CPU 5	CPU 41	CPU 6	CPU 42	CPU 7	CPU 43	CPU 8	CPU 44	CPU 9	CPU 45	CPU 10	CPU 46	CPU 11	CPU 47	CPU 12	CPU 48	CPU 13	CPU 49	CPU 14	CPU 50	CPU 15	CPU 51	CPU 16	CPU 52	CPU 17	CPU 53	CPU 18	CPU 54	CPU 19	CPU 55	CPU 20	CPU 56	CPU 21	CPU 57	CPU 22	CPU 58	CPU 23	CPU 59	CPU 24	CPU 60	CPU 25	CPU 61	CPU 26	CPU 62	CPU 27	CPU 63	CPU 28	CPU 64	CPU 29	CPU 65	CPU 30	CPU 66	CPU 31	CPU 67	CPU 32	CPU 68	CPU 33	CPU 69	CPU 34	CPU 70	CPU 35	CPU 71	
HW_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
CL_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
DCU_PREFETCHER        on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
IP_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
FAST_STRINGS          on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
THERMAL_CONTROL       on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
PERF_MON              on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
FERR_MULTIPLEX        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
BRANCH_TRACE_STORAGE  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
XTPR_MESSAGE          off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
PEBS                  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
SPEEDSTEP             on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
MONITOR               on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
SPEEDSTEP_LOCK        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
CPUID_MAX_VAL         off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
XD_BIT                on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
DYN_ACCEL             off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
TURBO_MODE            off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
TM2                   off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	

################################################################################
# Load
################################################################################
3.36 2.32 1.23 1/768 13892

################################################################################
# Performance energy bias
################################################################################
Performance energy bias: 7 (0=highest performance, 15 = lowest energy)

################################################################################
# NUMA balancing
################################################################################
Enabled: 0

################################################################################
# General memory info
################################################################################
MemTotal:       131889124 kB
MemFree:        130112956 kB
MemAvailable:   129836872 kB
Buffers:           13524 kB
Cached:           249784 kB
SwapCached:            0 kB
Active:           230444 kB
Inactive:          83592 kB
Active(anon):      50744 kB
Inactive(anon):     1896 kB
Active(file):     179700 kB
Inactive(file):    81696 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      67043324 kB
SwapFree:       67043324 kB
Dirty:               184 kB
Writeback:             0 kB
AnonPages:         50760 kB
Mapped:            67056 kB
Shmem:              1920 kB
Slab:             653876 kB
SReclaimable:     257360 kB
SUnreclaim:       396516 kB
KernelStack:       13440 kB
PageTables:         3504 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    132987884 kB
Committed_AS:     223260 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      787200 kB
DirectMap2M:    33687552 kB
DirectMap1G:    101711872 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: always [madvise] never
Use zero page: 1

################################################################################
# Hardware power limits
################################################################################
RAPL domain package-1
- Limit0 long_term MaxPower 145000000uW Limit 145000000uW TimeWindow 999424us
- Limit1 short_term MaxPower 290000000uW Limit 174000000uW TimeWindow 7808us
RAPL domain dram
- Limit0 long_term MaxPower 42750000uW Limit 0uW TimeWindow 976us
RAPL domain package-0
- Limit0 long_term MaxPower 145000000uW Limit 145000000uW TimeWindow 999424us
- Limit1 short_term MaxPower 290000000uW Limit 174000000uW TimeWindow 7808us
RAPL domain dram
- Limit0 long_term MaxPower 42750000uW Limit 0uW TimeWindow 976us

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
# dmidecode 3.1
Getting SMBIOS data from sysfs.
SMBIOS 2.8 present.

Handle 0x0000, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1152 kB
	Maximum Size: 1152 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0001, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 4608 kB
	Maximum Size: 4608 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0002, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 23040 kB
	Maximum Size: 23040 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 20-way Set-associative

Handle 0x0003, DMI type 4, 42 bytes
Processor Information
	Socket Designation: Proc 1
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel(R) Corporation
	ID: F1 06 04 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 79, Stepping 1
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Multi-threading)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz
	Voltage: 1.8 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2300 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA2011-3
	L1 Cache Handle: 0x0000
	L2 Cache Handle: 0x0001
	L3 Cache Handle: 0x0002
	(Line containing Serial number has been censored)
	Asset Tag: UNKNOWN
	Part Number: Not Specified
	Core Count: 18
	Core Enabled: 18
	Thread Count: 36
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0004, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1152 kB
	Maximum Size: 1152 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 4608 kB
	Maximum Size: 4608 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 23040 kB
	Maximum Size: 23040 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 20-way Set-associative

Handle 0x0007, DMI type 4, 42 bytes
Processor Information
	Socket Designation: Proc 2
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel(R) Corporation
	ID: F1 06 04 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 79, Stepping 1
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Multi-threading)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz
	Voltage: 1.8 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2300 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA2011-3
	L1 Cache Handle: 0x0004
	L2 Cache Handle: 0x0005
	L3 Cache Handle: 0x0006
	(Line containing Serial number has been censored)
	Asset Tag: UNKNOWN
	Part Number: Not Specified
	Core Count: 18
	Core Enabled: 18
	Thread Count: 36
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0008, DMI type 0, 24 bytes
BIOS Information
	Vendor: HP
	Version: P89
	Release Date: 07/18/2016
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 16 MB
	Characteristics:
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
	(Line containing Serial number has been censored)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 2.22
	Firmware Revision: 2.44

Handle 0x0009, DMI type 1, 27 bytes
System Information
	Manufacturer: HP
	Product Name: ProLiant DL380 Gen9
	Version: Not Specified
	(Line containing Serial number has been censored)
	(Line containing UUID has been censored)
	Wake-up Type: Power Switch
	SKU Number: 719064-B21
	Family: ProLiant

Handle 0x000A, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 1536 GB
	Error Information Handle: Not Provided
	Number Of Devices: 12

Handle 0x000B, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 1536 GB
	Error Information Handle: Not Provided
	Number Of Devices: 12

Handle 0x000C, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: None
	Locator: PROC 1 DIMM 1
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x000D, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 1
	Locator: PROC 1 DIMM 2
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x000E, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 2
	Locator: PROC 1 DIMM 3
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x000F, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 3
	Locator: PROC 1 DIMM 4
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0010, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 4
	Locator: PROC 1 DIMM 5
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0011, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 5
	Locator: PROC 1 DIMM 6
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0012, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 6
	Locator: PROC 1 DIMM 7
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0013, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 7
	Locator: PROC 1 DIMM 8
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0014, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 8
	Locator: PROC 1 DIMM 9
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0015, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 9
	Locator: PROC 1 DIMM 10
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0016, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 10
	Locator: PROC 1 DIMM 11
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0017, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 11
	Locator: PROC 1 DIMM 12
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0018, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 12
	Locator: PROC 2 DIMM 1
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0019, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 13
	Locator: PROC 2 DIMM 2
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x001A, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 14
	Locator: PROC 2 DIMM 3
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x001B, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 15
	Locator: PROC 2 DIMM 4
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x001C, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 16
	Locator: PROC 2 DIMM 5
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x001D, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 17
	Locator: PROC 2 DIMM 6
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x001E, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 18
	Locator: PROC 2 DIMM 7
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x001F, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 19
	Locator: PROC 2 DIMM 8
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0020, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 20
	Locator: PROC 2 DIMM 9
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0021, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 21
	Locator: PROC 2 DIMM 10
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0022, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: 22
	Locator: PROC 2 DIMM 11
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: UNKNOWN
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: NOT AVAILABLE
	Rank: Unknown
	Configured Clock Speed: Unknown
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: Unknown

Handle 0x0023, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: 23
	Locator: PROC 2 DIMM 12
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous Registered (Buffered)
	Speed: 2400 MT/s
	Manufacturer: HP     
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: 809081-081
	Rank: 2
	Configured Clock Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0028, DMI type 2, 17 bytes
Base Board Information
	Manufacturer: HP
	Product Name: ProLiant DL380 Gen9
	Version: Not Specified
	(Line containing Serial number has been censored)
	Asset Tag:                                 
	Features:
		Board is a hosting board
		Board is removable
		Board is replaceable
	Location In Chassis:                 
	Chassis Handle: 0x0000
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0029, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: HP
	Type: Rack Mount Chassis
	Lock: Not Present
	Version: Not Specified
	(Line containing Serial number has been censored)
	Asset Tag:                                 
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: Unknown
	OEM Information: 0x00000000
	Height: 2 U
	Number Of Power Cords: 2
	Contained Elements: 0

Handle 0x002A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90041
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: USB PORT 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x002B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90043
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: USB PORT 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x002C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J132
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: USB PORT 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x002D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J132
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: USB PORT 4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x002E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J12
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: USB PORT 5
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x002F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J12
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: USB PORT 6
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0030, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90043
	Internal Connector Type: None
	External Reference Designator: Video PORT
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0031, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J36
	Internal Connector Type: None
	External Reference Designator: Video PORT
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0032, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J87
	Internal Connector Type: None
	External Reference Designator: COM PORT
	External Connector Type: DB-9 male
	(Line containing Serial number has been censored)

Handle 0x0033, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J39
	Internal Connector Type: None
	External Reference Designator: ILO NIC PORT
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0034, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90077
	Internal Connector Type: None
	External Reference Designator: NIC PORT 1
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0035, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90077
	Internal Connector Type: None
	External Reference Designator: NIC PORT 2
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0036, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90077
	Internal Connector Type: None
	External Reference Designator: NIC PORT 3
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0037, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J90077
	Internal Connector Type: None
	External Reference Designator: NIC PORT 4
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x00B6, DMI type 9, 17 bytes
System Slot Information
	Designation: PCI-E Slot 1
	Type: x8 PCI Express 3
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:05:00.0

Handle 0x00B7, DMI type 9, 17 bytes
System Slot Information
	Designation: PCI-E Slot 3
	Type: x8 PCI Express 3
	Current Usage: Available
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:08:00.0

Handle 0x00B8, DMI type 9, 17 bytes
System Slot Information
	Designation: PCI-E Slot 2
	Type: x8 PCI Express 3
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:0b:00.0

Handle 0x00BF, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x00C1, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded FlexibleLOM 1 Port 1
	Type: Ethernet
	Status: Enabled
	Type Instance: 49
	Bus Address: 0000:04:00.0

Handle 0x00C2, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded FlexibleLOM 1 Port 2
	Type: Ethernet
	Status: Enabled
	Type Instance: 50
	Bus Address: 0000:04:00.0

Handle 0x00C3, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded LOM 1 Port 1
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:02:00.0

Handle 0x00C4, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded LOM 1 Port 2
	Type: Ethernet
	Status: Enabled
	Type Instance: 2
	Bus Address: 0000:02:00.1

Handle 0x00C5, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded LOM 1 Port 3
	Type: Ethernet
	Status: Enabled
	Type Instance: 3
	Bus Address: 0000:02:00.2

Handle 0x00C6, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded LOM 1 Port 4
	Type: Ethernet
	Status: Enabled
	Type Instance: 4
	Bus Address: 0000:02:00.3

Handle 0x00C7, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded SATA Controller #1
	Type: SATA Controller
	Status: Disabled
	Type Instance: 1
	Bus Address: 0000:00:1f.2

Handle 0x00C8, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded SATA Controller #2
	Type: SATA Controller
	Status: Disabled
	Type Instance: 2
	Bus Address: 0000:00:11.4

Handle 0x00C9, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Embedded RAID 1
	Type: SAS Controller
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:03:00.0


################################################################################
# environment variables
################################################################################
PBS_ENVIRONMENT=PBS_BATCH
LS_COLORS=
LD_LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:/mnt/opt/likwid-4.3-dev/lib
PBS_O_LANG=en_US
MKL_INC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
INCLUDE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
LESSCLOSE=/bin/lesspipe %s %s
MKL_SHLIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm
LESS=-R
LIKWID_LIBDIR=/mnt/opt/likwid-4.3-dev/lib
I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=off
IPPROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp
OLDPWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r3_isotropic_star_constant/BroadwellEP_E5-2697_CoD_20190715_104520
PBS_O_HOME=/home/hpc/iwia/iwia84
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
RRZECLUSTER=TESTCLUSTER
EDITOR=nano
PBS_JOBID=4616.catstor
ENVIRONMENT=BATCH
PATH_modshare=/usr/bin/vendor_perl:999999999:/home/julian/.local/.bin:999999999:/opt/android-sdk/tools:999999999:/usr/bin:1:/mnt/opt/likwid-4.3-dev/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/local/bin:999999999:/opt/android-sdk/platform-tools:999999999:/usr/bin/core_perl:999999999:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/home/julian/.bin:999999999:/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/apps/python/3.6-anaconda/bin:1:/mnt/opt/likwid-4.3-dev/sbin:1:/opt/intel/bin:999999999
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
LOADEDMODULES_modshare=intel64/19.0up02:1:likwid/4.3-dev:1:intelmpi/2019up02-intel:1:python/3.6-anaconda:1:mkl/2019up02:1:pbspro/default:2
PBS_JOBNAME=BDW_stempel_bench
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NCPUS=72
FPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
INTEL_F_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
CPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
WOODYHOME=/home/woody/iwia/iwia84
PBS_O_PATH=/mnt/opt/pbspro/default/bin:/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
LIKWID_FORCE=1
FI_PROVIDER_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib/prov
INTEL_PYTHONHOME=/apps/intel/ComposerXE2019/debugger_2019/python/intel64/
MKL_INCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
LD_LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:1:/mnt/opt/likwid-4.3-dev/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
LESS_TERMCAP_so=[1;44;1m
CLASSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar
PBS_CONF_FILE=/etc/pbspro.conf
LESS_TERMCAP_se=[0m
LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
PBS_O_WORKDIR=/home/hpc/iwia/iwia84/INSPECT
USER=iwia84
MPIINCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
I_MPI_HARD_FINALIZE=1
NLSPATH_modshare=/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:1
PBS_NODEFILE=/var/spool/pbspro/aux/4616.catstor
GROUP=iwia
PBS_TASKNUM=1
I_MPI_OFA_ADAPTER_NAME=mlx4_0
LIKWID_DEFINES=-DLIKWID_PERFMON
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r3_heterogeneous_star_constant/BroadwellEP_E5-2697_CoD_20190715_110418
HOME=/home/hpc/iwia/iwia84
LIKWID_LIB=-L/mnt/opt/likwid-4.3-dev/lib
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_MOMPORT=15003
LIKWID_INCDIR=/mnt/opt/likwid-4.3-dev/include
_LMFILES__modshare=/apps/modules/modulefiles/tools/python/3.6-anaconda:1:/apps/modules/modulefiles/libraries/mkl/2019up02:2:/opt/modules/modulefiles/testcluster/pbspro/default:2:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:1:/opt/modules/modulefiles/testcluster/likwid/4.3-dev:1
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
PBS_JOBCOOKIE=1AD84C4A5D9E47CC397A2BCB025092AC
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
PBS_O_SHELL=/bin/bash
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LESS_TERMCAP_mb=[1;32m
LESS_TERMCAP_md=[1;34m
LESS_TERMCAP_me=[0m
TMPDIR=/scratch/pbs.4616.catstor
LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
LIKWID_INC=-I/mnt/opt/likwid-4.3-dev/include
LOADEDMODULES=pbspro/default:likwid/4.3-dev:intelmpi/2019up02-intel:mkl/2019up02:intel64/19.0up02:python/3.6-anaconda
DAALROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal
MPILIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib
PBS_CONF=/etc/pbspro.conf
INTEL_LICENSE_FILE=1713@license4
I_MPI_FABRICS=shm:ofa
PBS_O_QUEUE=route
MKL_CDFT=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_cdft_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
SHELL=/bin/bash
MKL_BASE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
MANPATH_modshare=:1:/mnt/opt/likwid-4.3-dev/man:1:/mnt/opt/pbspro/default/man:2:/apps/python/3.6-anaconda/share/man:1:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:1:/apps/intel/ComposerXE2019/man/common:2:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:2:/apps/intel/mpi/man:1
MKL_SLIB_THREADED=-Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -lpthread -lm -openmp
MKLPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
GDK_USE_XFT=1
TMOUT=3660
SHLVL=3
PBS_O_HOST=testfront1.rrze.uni-erlangen.de
INTEL_C_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
PBS_O_SYSTEM=Linux
MANPATH=/apps/python/3.6-anaconda/share/man:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:/apps/intel/ComposerXE2019/man/common::/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:/apps/intel/mpi/man:/mnt/opt/likwid-4.3-dev/man:/mnt/opt/pbspro/default/man
MKL_LIB=-Wl,--start-group /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_sequential.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm
PBS_O_LOGNAME=iwia84
PBS_NODENUM=0
MODULEPATH=/opt/modules/modulefiles/testcluster:/apps/modules/modulefiles/applications:/apps/modules/modulefiles/development:/apps/modules/modulefiles/libraries:/apps/modules/modulefiles/tools:/apps/modules/modulefiles/deprecated:/apps/modules/modulefiles/testing
PBS_JOBDIR=/home/hpc/iwia/iwia84
MPIROOTDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
LOGNAME=iwia84
MKLROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
MODULEPATH_modshare=/apps/modules/modulefiles/testing:2:/apps/modules/modulefiles/development:2:/apps/modules/modulefiles/applications:2:/opt/modules/modulefiles/testcluster:2:/apps/modules/modulefiles/deprecated:2:/apps/modules/modulefiles/tools:2:/apps/modules/modulefiles/libraries:2
LESS_TERMCAP_ue=[0m
PSTLROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl
LESS_TERMCAP_us=[1;32m
PATH=/apps/python/3.6-anaconda/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:/mnt/opt/likwid-4.3-dev/sbin:/mnt/opt/likwid-4.3-dev/bin:/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
TBBROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb
_LMFILES_=/opt/modules/modulefiles/testcluster/pbspro/default:/opt/modules/modulefiles/testcluster/likwid/4.3-dev:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:/apps/modules/modulefiles/libraries/mkl/2019up02:/apps/modules/modulefiles/tools/python/3.6-anaconda
PBS_QUEUE=work
MODULESHOME=/apps/modules
INFOPATH=/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/info/
INFOPATH_modshare=/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/info/:1
I_MPI_ROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi
QT_XFT=true
INTEL_LICENSE_FILE_modshare=1713@license4:1
GCC_COLORS=error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01
MKL_SCALAPACK=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_scalapack_lp64.a -Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
LESSOPEN=| /bin/lesspipe %s
OMP_NUM_THREADS=72
PBS_O_MAIL=/var/mail/iwia84
_=/usr/bin/env
{%- endcapture -%}

{% include stencil_template.md %}
