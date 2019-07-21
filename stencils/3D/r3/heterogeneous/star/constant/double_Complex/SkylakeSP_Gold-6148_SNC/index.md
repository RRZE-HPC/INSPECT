---

title:  "Stencil 3D r3 star constant heterogeneous double _Complex SkylakeSP_Gold-6148_SNC"

dimension    : "3D"
radius       : "r3"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double _Complex"
machine      : "SkylakeSP_Gold-6148_SNC"
flavor       : "EDIT_ME"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp "
flop         : "37"
scaling      : [ "900" ]
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
vmovupd xmm30, xmmword ptr [r8+rdx*1+0x30]
vunpckhpd xmm31, xmm30, xmm30
inc rax
vmovupd xmm30, xmmword ptr [r8+rdx*1+0x20]
vmulpd xmm31, xmm31, xmm24
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmm22
vfmaddsub231pd xmm31, xmm25, qword ptr [r8+rdx*1+0x30]{1to2}
vfmaddsub231pd xmm30, xmm23, qword ptr [r8+rdx*1+0x20]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+rdx*1+0x40]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmm20
vfmaddsub231pd xmm31, xmm21, qword ptr [r8+rdx*1+0x40]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+rcx*1+0x30]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmm18
vfmaddsub231pd xmm30, xmm19, qword ptr [r8+rcx*1+0x30]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+r14*1+0x30]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmm16
vfmaddsub231pd xmm31, xmm17, qword ptr [r8+r14*1+0x30]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+r9*1+0x30]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmmword ptr [rsp+0x590]
vfmaddsub231pd xmm30, xmm15, qword ptr [r8+r9*1+0x30]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+rsi*1+0x30]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmmword ptr [rsp+0x5d0]
vfmaddsub231pd xmm31, xmm14, qword ptr [r8+rsi*1+0x30]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+rdx*1+0x10]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmmword ptr [rsp+0x5c0]
vfmaddsub231pd xmm30, xmm13, qword ptr [r8+rdx*1+0x10]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+rdx*1+0x50]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmm11
vfmaddsub231pd xmm31, xmm12, qword ptr [r8+rdx*1+0x50]{1to2}
mov r15, qword ptr [rsp+0x5f0]
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+r15*1+0x30]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmmword ptr [rsp+0x580]
vfmaddsub231pd xmm30, xmm10, qword ptr [r8+r15*1+0x30]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+r10*1+0x30]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmmword ptr [rsp+0x5a0]
nop 
vfmaddsub231pd xmm31, xmm9, qword ptr [r8+r10*1+0x30]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+r11*1+0x30]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmmword ptr [rsp+0x5b0]
vfmaddsub231pd xmm30, xmm8, qword ptr [r8+r11*1+0x30]{1to2}
mov r15, qword ptr [rsp+0x5e8]
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+r15*1+0x30]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmmword ptr [rsp+0x570]
vfmaddsub231pd xmm31, xmm7, qword ptr [r8+r15*1+0x30]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+rdx*1]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmmword ptr [rsp+0x560]
vfmaddsub231pd xmm30, xmm6, qword ptr [r8+rdx*1]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+rdx*1+0x60]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmm4
vfmaddsub231pd xmm31, xmm5, qword ptr [r8+rdx*1+0x60]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+r12*1+0x30]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmm2
vfmaddsub231pd xmm30, xmm3, qword ptr [r8+r12*1+0x30]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+r13*1+0x30]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmm29
vfmaddsub231pd xmm31, xmm1, qword ptr [r8+r13*1+0x30]{1to2}
vaddpd xmm31, xmm30, xmm31
vmovupd xmm30, xmmword ptr [r8+rdi*1+0x30]
vunpckhpd xmm30, xmm30, xmm30
vmulpd xmm30, xmm30, xmm27
vfmaddsub231pd xmm30, xmm28, qword ptr [r8+rdi*1+0x30]{1to2}
vaddpd xmm30, xmm31, xmm30
vmovupd xmm31, xmmword ptr [r8+rbx*1+0x30]
vunpckhpd xmm31, xmm31, xmm31
vmulpd xmm31, xmm31, xmm0
nop 
vfmaddsub231pd xmm31, xmm26, qword ptr [r8+rbx*1+0x30]{1to2}
vaddpd xmm30, xmm30, xmm31
mov r15, qword ptr [rsp+0x5e0]
vmovupd xmmword ptr [r8+r15*1+0x30], xmm30
add r8, 0x10
cmp rax, qword ptr [rsp+0x5f8]
jb 0xfffffffffffffd41
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

### Layer conditions for L2 cache with 1024 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```32*M*N*P < 1048576```|0|20|
|```128*N*P - 96*P <= 1048576```|2|18|
|```128*N*P + 96*P <= 1048576```|4|16|
|```224*P - 384 <= 1048576```|8|12|
|```224*P + 96 <= 1048576```|10|10|
|Else|14|6|

### Layer conditions for L3 cache with 8448 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```32*M*N*P < 8650752```|0|20|
|```128*N*P - 96*P <= 8650752```|2|18|
|```128*N*P + 96*P <= 8650752```|4|16|
|```224*P - 384 <= 8650752```|8|12|
|```224*P + 96 <= 8650752```|10|10|
|Else|14|6|


{%- endcapture -%}

{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 42.79 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 28.0     0.0  | 28.0  | 25.5    25.1  | 25.5    24.9  |  1.0  | 19.0  |  5.0  |  0.0  |
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
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+rdx*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm30, xmm30
|   1      |             |      |             |             |      |      | 1.0  |      | inc rax
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+rdx*1+0x20]
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm24
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm30, xmm30, xmm22
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm25, qword ptr [r8+rdx*1+0x30]{1to2}
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm23, qword ptr [r8+rdx*1+0x20]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+rdx*1+0x40]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm20
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm21, qword ptr [r8+rdx*1+0x40]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+rcx*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd xmm30, xmm30, xmm18
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm19, qword ptr [r8+rcx*1+0x30]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+r14*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm16
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm17, qword ptr [r8+r14*1+0x30]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+r9*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   2^     |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm30, xmm30, xmmword ptr [rsp+0x590]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm15, qword ptr [r8+r9*1+0x30]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+rsi*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   2^     | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm31, xmm31, xmmword ptr [rsp+0x5d0]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm14, qword ptr [r8+rsi*1+0x30]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+rdx*1+0x10]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   2^     |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm30, xmm30, xmmword ptr [rsp+0x5c0]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm13, qword ptr [r8+rdx*1+0x10]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+rdx*1+0x50]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm11
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm12, qword ptr [r8+rdx*1+0x50]{1to2}
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov r15, qword ptr [rsp+0x5f0]
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+r15*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   2^     |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm30, xmm30, xmmword ptr [rsp+0x580]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm10, qword ptr [r8+r15*1+0x30]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+r10*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   2^     | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm31, xmm31, xmmword ptr [rsp+0x5a0]
|   1      |             |      |             |             |      |      | 1.0  |      | nop 
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm9, qword ptr [r8+r10*1+0x30]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+r11*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   2^     |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm30, xmm30, xmmword ptr [rsp+0x5b0]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm8, qword ptr [r8+r11*1+0x30]{1to2}
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov r15, qword ptr [rsp+0x5e8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+r15*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   2^     | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm31, xmm31, xmmword ptr [rsp+0x570]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm7, qword ptr [r8+r15*1+0x30]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+rdx*1]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   2^     |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmulpd xmm30, xmm30, xmmword ptr [rsp+0x560]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm6, qword ptr [r8+rdx*1]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+rdx*1+0x60]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm4
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm5, qword ptr [r8+rdx*1+0x60]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+r12*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd xmm30, xmm30, xmm2
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm3, qword ptr [r8+r12*1+0x30]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+r13*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm29
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm1, qword ptr [r8+r13*1+0x30]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm31, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm30, xmmword ptr [r8+rdi*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm30, xmm30, xmm30
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd xmm30, xmm30, xmm27
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm30, xmm28, qword ptr [r8+rdi*1+0x30]{1to2}
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd xmm30, xmm31, xmm30
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd xmm31, xmmword ptr [r8+rbx*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd xmm31, xmm31, xmm31
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd xmm31, xmm31, xmm0
|   1      |             |      |             |             |      |      | 1.0  |      | nop 
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmaddsub231pd xmm31, xmm26, qword ptr [r8+rbx*1+0x30]{1to2}
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd xmm30, xmm30, xmm31
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov r15, qword ptr [rsp+0x5e0]
|   2      |             |      | 0.5         | 0.5         | 1.0  |      |      |      | vmovupd xmmword ptr [r8+r15*1+0x30], xmm30
|   1      |             |      |             |             |      |      | 1.0  |      | add r8, 0x10
|   2^     |             |      | 0.5     0.5 | 0.5     0.5 |      |      | 1.0  |      | cmp rax, qword ptr [rsp+0x5f8]
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffd41
Total Num Of Uops: 132
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.

{%- endcapture -%}

{%- capture hostinfo -%}

################################################################################
# Hostname
################################################################################
skylakesp2.rrze.uni-erlangen.de

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
Linux skylakesp2 4.15.0-50-generic #54-Ubuntu SMP Mon May 6 18:46:08 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Logged in users
################################################################################
 15:48:55 up 50 days, 22:35,  0 users,  load average: 6.76, 6.51, 3.93
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CPUset
################################################################################
Domain N:
	0,40,1,41,2,42,5,45,6,46,10,50,11,51,12,52,15,55,16,56,3,43,4,44,7,47,8,48,9,49,13,53,14,54,17,57,18,58,19,59,20,60,21,61,22,62,25,65,26,66,30,70,31,71,32,72,35,75,36,76,23,63,24,64,27,67,28,68,29,69,33,73,34,74,37,77,38,78,39,79

Domain S0:
	0,40,1,41,2,42,5,45,6,46,10,50,11,51,12,52,15,55,16,56,3,43,4,44,7,47,8,48,9,49,13,53,14,54,17,57,18,58,19,59

Domain S1:
	20,60,21,61,22,62,25,65,26,66,30,70,31,71,32,72,35,75,36,76,23,63,24,64,27,67,28,68,29,69,33,73,34,74,37,77,38,78,39,79

Domain C0:
	0,40,1,41,2,42,5,45,6,46,10,50,11,51,12,52,15,55,16,56

Domain C1:
	3,43,4,44,7,47,8,48,9,49,13,53,14,54,17,57,18,58,19,59

Domain C2:
	20,60,21,61,22,62,25,65,26,66,30,70,31,71,32,72,35,75,36,76

Domain C3:
	23,63,24,64,27,67,28,68,29,69,33,73,34,74,37,77,38,78,39,79

Domain M0:
	0,40,1,41,2,42,5,45,6,46,10,50,11,51,12,52,15,55,16,56

Domain M1:
	3,43,4,44,7,47,8,48,9,49,13,53,14,54,17,57,18,58,19,59

Domain M2:
	20,60,21,61,22,62,25,65,26,66,30,70,31,71,32,72,35,75,36,76

Domain M3:
	23,63,24,64,27,67,28,68,29,69,33,73,34,74,37,77,38,78,39,79


################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-79
Allowed Memory controllers: 0-3

################################################################################
# Topology
################################################################################
--------------------------------------------------------------------------------
CPU name:	Intel(R) Xeon(R) Gold 6148 CPU @ 2.40GHz
CPU type:	Intel Skylake SP processor
CPU stepping:	4
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:		2
Cores per socket:	20
Threads per core:	2
--------------------------------------------------------------------------------
HWThread	Thread		Core		Socket		Available
0		0		0		0		*
1		0		1		0		*
2		0		2		0		*
3		0		10		0		*
4		0		11		0		*
5		0		3		0		*
6		0		4		0		*
7		0		12		0		*
8		0		13		0		*
9		0		14		0		*
10		0		5		0		*
11		0		6		0		*
12		0		7		0		*
13		0		15		0		*
14		0		16		0		*
15		0		8		0		*
16		0		9		0		*
17		0		17		0		*
18		0		18		0		*
19		0		19		0		*
20		0		20		1		*
21		0		21		1		*
22		0		22		1		*
23		0		30		1		*
24		0		31		1		*
25		0		23		1		*
26		0		24		1		*
27		0		32		1		*
28		0		33		1		*
29		0		34		1		*
30		0		25		1		*
31		0		26		1		*
32		0		27		1		*
33		0		35		1		*
34		0		36		1		*
35		0		28		1		*
36		0		29		1		*
37		0		37		1		*
38		0		38		1		*
39		0		39		1		*
40		1		0		0		*
41		1		1		0		*
42		1		2		0		*
43		1		10		0		*
44		1		11		0		*
45		1		3		0		*
46		1		4		0		*
47		1		12		0		*
48		1		13		0		*
49		1		14		0		*
50		1		5		0		*
51		1		6		0		*
52		1		7		0		*
53		1		15		0		*
54		1		16		0		*
55		1		8		0		*
56		1		9		0		*
57		1		17		0		*
58		1		18		0		*
59		1		19		0		*
60		1		20		1		*
61		1		21		1		*
62		1		22		1		*
63		1		30		1		*
64		1		31		1		*
65		1		23		1		*
66		1		24		1		*
67		1		32		1		*
68		1		33		1		*
69		1		34		1		*
70		1		25		1		*
71		1		26		1		*
72		1		27		1		*
73		1		35		1		*
74		1		36		1		*
75		1		28		1		*
76		1		29		1		*
77		1		37		1		*
78		1		38		1		*
79		1		39		1		*
--------------------------------------------------------------------------------
Socket 0:		( 0 40 1 41 2 42 5 45 6 46 10 50 11 51 12 52 15 55 16 56 3 43 4 44 7 47 8 48 9 49 13 53 14 54 17 57 18 58 19 59 )
Socket 1:		( 20 60 21 61 22 62 25 65 26 66 30 70 31 71 32 72 35 75 36 76 23 63 24 64 27 67 28 68 29 69 33 73 34 74 37 77 38 78 39 79 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:			1
Size:			32 kB
Cache groups:		( 0 40 ) ( 1 41 ) ( 2 42 ) ( 5 45 ) ( 6 46 ) ( 10 50 ) ( 11 51 ) ( 12 52 ) ( 15 55 ) ( 16 56 ) ( 3 43 ) ( 4 44 ) ( 7 47 ) ( 8 48 ) ( 9 49 ) ( 13 53 ) ( 14 54 ) ( 17 57 ) ( 18 58 ) ( 19 59 ) ( 20 60 ) ( 21 61 ) ( 22 62 ) ( 25 65 ) ( 26 66 ) ( 30 70 ) ( 31 71 ) ( 32 72 ) ( 35 75 ) ( 36 76 ) ( 23 63 ) ( 24 64 ) ( 27 67 ) ( 28 68 ) ( 29 69 ) ( 33 73 ) ( 34 74 ) ( 37 77 ) ( 38 78 ) ( 39 79 )
--------------------------------------------------------------------------------
Level:			2
Size:			1 MB
Cache groups:		( 0 40 ) ( 1 41 ) ( 2 42 ) ( 5 45 ) ( 6 46 ) ( 10 50 ) ( 11 51 ) ( 12 52 ) ( 15 55 ) ( 16 56 ) ( 3 43 ) ( 4 44 ) ( 7 47 ) ( 8 48 ) ( 9 49 ) ( 13 53 ) ( 14 54 ) ( 17 57 ) ( 18 58 ) ( 19 59 ) ( 20 60 ) ( 21 61 ) ( 22 62 ) ( 25 65 ) ( 26 66 ) ( 30 70 ) ( 31 71 ) ( 32 72 ) ( 35 75 ) ( 36 76 ) ( 23 63 ) ( 24 64 ) ( 27 67 ) ( 28 68 ) ( 29 69 ) ( 33 73 ) ( 34 74 ) ( 37 77 ) ( 38 78 ) ( 39 79 )
--------------------------------------------------------------------------------
Level:			3
Size:			14 MB
Cache groups:		( 0 40 1 41 2 42 5 45 6 46 10 50 11 51 12 52 15 55 16 56 ) ( 3 43 4 44 7 47 8 48 9 49 13 53 14 54 17 57 18 58 19 59 ) ( 20 60 21 61 22 62 25 65 26 66 30 70 31 71 32 72 35 75 36 76 ) ( 23 63 24 64 27 67 28 68 29 69 33 73 34 74 37 77 38 78 39 79 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		4
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 40 1 41 2 42 5 45 6 46 10 50 11 51 12 52 15 55 16 56 )
Distances:		10 11 21 21
Free memory:		22205 MB
Total memory:		22758.8 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 3 43 4 44 7 47 8 48 9 49 13 53 14 54 17 57 18 58 19 59 )
Distances:		11 10 21 21
Free memory:		23628.2 MB
Total memory:		24188.2 MB
--------------------------------------------------------------------------------
Domain:			2
Processors:		( 20 60 21 61 22 62 25 65 26 66 30 70 31 71 32 72 35 75 36 76 )
Distances:		21 21 10 11
Free memory:		23749.2 MB
Total memory:		24188.2 MB
--------------------------------------------------------------------------------
Domain:			3
Processors:		( 23 63 24 64 27 67 28 68 29 69 33 73 34 74 37 77 38 78 39 79 )
Distances:		21 21 11 10
Free memory:		23662.8 MB
Total memory:		24186.8 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 5 6 10 11 12 15 16 40 41 42 45 46 50 51 52 55 56
node 0 size: 22758 MB
node 0 free: 22205 MB
node 1 cpus: 3 4 7 8 9 13 14 17 18 19 43 44 47 48 49 53 54 57 58 59
node 1 size: 24188 MB
node 1 free: 23628 MB
node 2 cpus: 20 21 22 25 26 30 31 32 35 36 60 61 62 65 66 70 71 72 75 76
node 2 size: 24188 MB
node 2 free: 23749 MB
node 3 cpus: 23 24 27 28 29 33 34 37 38 39 63 64 67 68 69 73 74 77 78 79
node 3 size: 24186 MB
node 3 free: 23673 MB
node distances:
node   0   1   2   3 
  0:  10  11  21  21 
  1:  11  10  21  21 
  2:  21  21  10  11 
  3:  21  21  11  10 

################################################################################
# Frequencies
################################################################################
Current CPU frequencies:
CPU 0: governor  performance min/cur/max 2.4/1.69441/2.4 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.4/2.104983/2.4 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.4/1.897243/2.4 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.4/2.134789/2.4 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.4/2.235305/2.4 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.4/1.775272/2.4 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.4/2.15266/2.4 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.4/2.030944/2.4 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.4/2.151766/2.4 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.4/1.994298/2.4 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.4/2.233479/2.4 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.4/2.172303/2.4 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.4/2.06602/2.4 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.4/2.222842/2.4 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.4/2.293142/2.4 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.4/2.262009/2.4 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.4/2.139541/2.4 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.4/2.171641/2.4 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.4/1.250196/2.4 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.4/1.891225/2.4 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.4/1.774506/2.4 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.4/1.686651/2.4 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.4/1.502941/2.4 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.4/1.313099/2.4 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.4/2.150762/2.4 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.4/2.033503/2.4 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.4/1.138487/2.4 GHz Turbo 0
CPU 32: governor  performance min/cur/max 2.4/2.15066/2.4 GHz Turbo 0
CPU 35: governor  performance min/cur/max 2.4/2.120677/2.4 GHz Turbo 0
CPU 36: governor  performance min/cur/max 2.4/1.893064/2.4 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.4/2.076571/2.4 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.4/1.159968/2.4 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.4/1.081302/2.4 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.4/1.565251/2.4 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.4/1.921078/2.4 GHz Turbo 0
CPU 33: governor  performance min/cur/max 2.4/1.347649/2.4 GHz Turbo 0
CPU 34: governor  performance min/cur/max 2.4/1.546724/2.4 GHz Turbo 0
CPU 37: governor  performance min/cur/max 2.4/1.959474/2.4 GHz Turbo 0
CPU 38: governor  performance min/cur/max 2.4/1.366151/2.4 GHz Turbo 0
CPU 39: governor  performance min/cur/max 2.4/1.769983/2.4 GHz Turbo 0
CPU 40: governor  performance min/cur/max 2.4/2.308431/2.4 GHz Turbo 0
CPU 41: governor  performance min/cur/max 2.4/2.182236/2.4 GHz Turbo 0
CPU 42: governor  performance min/cur/max 2.4/2.122326/2.4 GHz Turbo 0
CPU 45: governor  performance min/cur/max 2.4/2.306725/2.4 GHz Turbo 0
CPU 46: governor  performance min/cur/max 2.4/2.098579/2.4 GHz Turbo 0
CPU 50: governor  performance min/cur/max 2.4/2.232594/2.4 GHz Turbo 0
CPU 51: governor  performance min/cur/max 2.4/2.356111/2.4 GHz Turbo 0
CPU 52: governor  performance min/cur/max 2.4/2.344674/2.4 GHz Turbo 0
CPU 55: governor  performance min/cur/max 2.4/2.081156/2.4 GHz Turbo 0
CPU 56: governor  performance min/cur/max 2.4/2.154798/2.4 GHz Turbo 0
CPU 43: governor  performance min/cur/max 2.4/2.275129/2.4 GHz Turbo 0
CPU 44: governor  performance min/cur/max 2.4/2.122825/2.4 GHz Turbo 0
CPU 47: governor  performance min/cur/max 2.4/2.194272/2.4 GHz Turbo 0
CPU 48: governor  performance min/cur/max 2.4/2.278365/2.4 GHz Turbo 0
CPU 49: governor  performance min/cur/max 2.4/2.154235/2.4 GHz Turbo 0
CPU 53: governor  performance min/cur/max 2.4/2.11135/2.4 GHz Turbo 0
CPU 54: governor  performance min/cur/max 2.4/2.358864/2.4 GHz Turbo 0
CPU 57: governor  performance min/cur/max 2.4/2.399887/2.4 GHz Turbo 0
CPU 58: governor  performance min/cur/max 2.4/1.843397/2.4 GHz Turbo 0
CPU 59: governor  performance min/cur/max 2.4/1.376024/2.4 GHz Turbo 0
CPU 60: governor  performance min/cur/max 2.4/2.249901/2.4 GHz Turbo 0
CPU 61: governor  performance min/cur/max 2.4/2.216412/2.4 GHz Turbo 0
CPU 62: governor  performance min/cur/max 2.4/1.246607/2.4 GHz Turbo 0
CPU 65: governor  performance min/cur/max 2.4/1.564177/2.4 GHz Turbo 0
CPU 66: governor  performance min/cur/max 2.4/1.547099/2.4 GHz Turbo 0
CPU 70: governor  performance min/cur/max 2.4/1.996635/2.4 GHz Turbo 0
CPU 71: governor  performance min/cur/max 2.4/1.812032/2.4 GHz Turbo 0
CPU 72: governor  performance min/cur/max 2.4/2.313262/2.4 GHz Turbo 0
CPU 75: governor  performance min/cur/max 2.4/2.140525/2.4 GHz Turbo 0
CPU 76: governor  performance min/cur/max 2.4/2.269915/2.4 GHz Turbo 0
CPU 63: governor  performance min/cur/max 2.4/1.609865/2.4 GHz Turbo 0
CPU 64: governor  performance min/cur/max 2.4/1.423215/2.4 GHz Turbo 0
CPU 67: governor  performance min/cur/max 2.4/1.576161/2.4 GHz Turbo 0
CPU 68: governor  performance min/cur/max 2.4/1.480612/2.4 GHz Turbo 0
CPU 69: governor  performance min/cur/max 2.4/1.109086/2.4 GHz Turbo 0
CPU 73: governor  performance min/cur/max 2.4/1.567676/2.4 GHz Turbo 0
CPU 74: governor  performance min/cur/max 2.4/1.37086/2.4 GHz Turbo 0
CPU 77: governor  performance min/cur/max 2.4/1.276697/2.4 GHz Turbo 0
CPU 78: governor  performance min/cur/max 2.4/1.523382/2.4 GHz Turbo 0
CPU 79: governor  performance min/cur/max 2.4/1.278314/2.4 GHz Turbo 0

Current Uncore frequencies:
Socket 0: min/max 2.4/2.4 GHz
Socket 1: min/max 2.4/2.4 GHz

################################################################################
# Prefetchers
################################################################################
Feature               CPU 0	CPU 40	CPU 1	CPU 41	CPU 2	CPU 42	CPU 5	CPU 45	CPU 6	CPU 46	CPU 10	CPU 50	CPU 11	CPU 51	CPU 12	CPU 52	CPU 15	CPU 55	CPU 16	CPU 56	CPU 3	CPU 43	CPU 4	CPU 44	CPU 7	CPU 47	CPU 8	CPU 48	CPU 9	CPU 49	CPU 13	CPU 53	CPU 14	CPU 54	CPU 17	CPU 57	CPU 18	CPU 58	CPU 19	CPU 59	CPU 20	CPU 60	CPU 21	CPU 61	CPU 22	CPU 62	CPU 25	CPU 65	CPU 26	CPU 66	CPU 30	CPU 70	CPU 31	CPU 71	CPU 32	CPU 72	CPU 35	CPU 75	CPU 36	CPU 76	CPU 23	CPU 63	CPU 24	CPU 64	CPU 27	CPU 67	CPU 28	CPU 68	CPU 29	CPU 69	CPU 33	CPU 73	CPU 34	CPU 74	CPU 37	CPU 77	CPU 38	CPU 78	CPU 39	CPU 79	
HW_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
CL_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
DCU_PREFETCHER        on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
IP_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
FAST_STRINGS          on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
THERMAL_CONTROL       on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
PERF_MON              on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
FERR_MULTIPLEX        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
BRANCH_TRACE_STORAGE  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
XTPR_MESSAGE          off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
PEBS                  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
SPEEDSTEP             on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
MONITOR               on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
SPEEDSTEP_LOCK        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
CPUID_MAX_VAL         off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
XD_BIT                on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
DYN_ACCEL             off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
TURBO_MODE            off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
TM2                   off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	

################################################################################
# Load
################################################################################
6.76 6.51 3.93 1/848 24635

################################################################################
# Performance energy bias
################################################################################
Performance energy bias: 6 (0=highest performance, 15 = lowest energy)

################################################################################
# NUMA balancing
################################################################################
Enabled: 1

################################################################################
# General memory info
################################################################################
MemTotal:       97609736 kB
MemFree:        95501976 kB
MemAvailable:   95539664 kB
Buffers:           24476 kB
Cached:           512504 kB
SwapCached:         3928 kB
Active:           382196 kB
Inactive:         171984 kB
Active(anon):      13380 kB
Inactive(anon):     4128 kB
Active(file):     368816 kB
Inactive(file):   167856 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      49632252 kB
SwapFree:       49585660 kB
Dirty:               164 kB
Writeback:             0 kB
AnonPages:         15000 kB
Mapped:            36708 kB
Shmem:               308 kB
Slab:             841344 kB
SReclaimable:     328512 kB
SUnreclaim:       512832 kB
KernelStack:       14880 kB
PageTables:         3228 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    98437120 kB
Committed_AS:     257644 kB
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
DirectMap4k:     1118416 kB
DirectMap2M:    52011008 kB
DirectMap1G:    48234496 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: always [madvise] never
Use zero page: 1

################################################################################
# Hardware power limits
################################################################################
RAPL domain package-1
- Limit0 long_term MaxPower 150000000uW Limit 150000000uW TimeWindow 55967744us
- Limit1 short_term MaxPower 319000000uW Limit 180000000uW TimeWindow 20468203520us
RAPL domain dram
- Limit0 long_term MaxPower 36750000uW Limit 0uW TimeWindow 976us
RAPL domain package-0
- Limit0 long_term MaxPower 150000000uW Limit 150000000uW TimeWindow 55967744us
- Limit1 short_term MaxPower 319000000uW Limit 180000000uW TimeWindow 20468203520us
RAPL domain dram
- Limit0 long_term MaxPower 36750000uW Limit 0uW TimeWindow 976us

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
SMBIOS 3.1.1 present.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 2.0a
	Release Date: 12/06/2017
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 32 MB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
	(Line containing Serial number has been censored)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 5.12

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Supermicro
	Product Name: SYS-6019P-WT
	Version: 0123456789
	(Line containing Serial number has been censored)
	(Line containing UUID has been censored)
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Supermicro
	Product Name: X11DDW-L
	Version: 1.10
	(Line containing Serial number has been censored)
	Asset Tag: To be filled by O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To be filled by O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Supermicro
	Type: Other
	Lock: Not Present
	Version: 0123456789
	(Line containing Serial number has been censored)
	Asset Tag: To be filled by O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0
	SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JLAN1
	Internal Connector Type: None
	External Reference Designator: LAN1
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0005, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JLAN2
	Internal Connector Type: None
	External Reference Designator: LAN2
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0006, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBR
	Internal Connector Type: None
	External Reference Designator: USB2/3(3.0)
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBRJ45
	Internal Connector Type: None
	External Reference Designator: IPMI_LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBRJ45
	Internal Connector Type: None
	External Reference Designator: USB0/1(3.0)
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JVGA
	Internal Connector Type: None
	External Reference Designator: VGA
	External Connector Type: DB-25 female
	Port Type: Video Port

Handle 0x000A, DMI type 9, 17 bytes
System Slot Information
	Designation: JAOM SLOT1
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:ff:00.0

Handle 0x000C, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000F, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: ASPEED Video AST2500
	Type: Video
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:03:00.0

Handle 0x0010, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Intel LAN X722 #1
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:1c:00.0

Handle 0x0011, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Intel LAN X722 #2
	Type: Ethernet
	Status: Enabled
	Type Instance: 2
	Bus Address: 0000:1c:00.1

Handle 0x0018, DMI type 15, 73 bytes
System Event Log
	Area Length: 65535 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: Memory-mapped physical 32-bit address
	Access Address: 0xFF110000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 25
	Descriptor 1: Single-bit ECC memory error
	Data Format 1: Multiple-event handle
	Descriptor 2: Multi-bit ECC memory error
	Data Format 2: Multiple-event handle
	Descriptor 3: Parity memory error
	Data Format 3: None
	Descriptor 4: Bus timeout
	Data Format 4: None
	Descriptor 5: I/O channel block
	Data Format 5: None
	Descriptor 6: Software NMI
	Data Format 6: None
	Descriptor 7: POST memory resize
	Data Format 7: None
	Descriptor 8: POST error
	Data Format 8: POST results bitmap
	Descriptor 9: PCI parity error
	Data Format 9: Multiple-event handle
	Descriptor 10: PCI system error
	Data Format 10: Multiple-event handle
	Descriptor 11: CPU failure
	Data Format 11: None
	Descriptor 12: EISA failsafe timer timeout
	Data Format 12: None
	Descriptor 13: Correctable memory log disabled
	Data Format 13: None
	Descriptor 14: Logging disabled
	Data Format 14: None
	Descriptor 15: System limit exceeded
	Data Format 15: None
	Descriptor 16: Asynchronous hardware timer expired
	Data Format 16: None
	Descriptor 17: System configuration information
	Data Format 17: None
	Descriptor 18: Hard disk information
	Data Format 18: None
	Descriptor 19: System reconfigured
	Data Format 19: None
	Descriptor 20: Uncorrectable CPU-complex error
	Data Format 20: None
	Descriptor 21: Log area reset/cleared
	Data Format 21: None
	Descriptor 22: System boot
	Data Format 22: None
	Descriptor 23: End of log
	Data Format 23: None
	Descriptor 24: OEM-specific
	Data Format 24: OEM-specific
	Descriptor 25: OEM-specific
	Data Format 25: OEM-specific

Handle 0x0019, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 2304 GB
	Error Information Handle: Not Provided
	Number Of Devices: 3

Handle 0x001A, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMA1
	Bank Locator: P0_Node0_Channel0_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMA1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x001C, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMB1
	Bank Locator: P0_Node0_Channel1_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMB1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x001E, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMC1
	Bank Locator: P0_Node0_Channel2_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMC1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0020, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 2304 GB
	Error Information Handle: Not Provided
	Number Of Devices: 3

Handle 0x0021, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0020
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMD1
	Bank Locator: P0_Node1_Channel0_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMD1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0023, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0020
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMME1
	Bank Locator: P0_Node1_Channel1_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMME1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0025, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0020
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMF1
	Bank Locator: P0_Node1_Channel2_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMF1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0027, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 2304 GB
	Error Information Handle: Not Provided
	Number Of Devices: 3

Handle 0x0028, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0027
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMA1
	Bank Locator: P1_Node0_Channel0_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMA1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x002A, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0027
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMB1
	Bank Locator: P1_Node0_Channel1_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMB1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x002C, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x0027
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMC1
	Bank Locator: P1_Node0_Channel2_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMC1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x002E, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 2304 GB
	Error Information Handle: Not Provided
	Number Of Devices: 3

Handle 0x002F, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x002E
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMD1
	Bank Locator: P1_Node1_Channel0_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMD1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0031, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x002E
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMME1
	Bank Locator: P1_Node1_Channel1_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMME1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0033, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x002E
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMF1
	Bank Locator: P1_Node1_Channel2_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Micron Technology
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMF1_AssetTag (date:17/36)
	Part Number: 18ASF1G72PDZ-2G6B1  
	Rank: 2
	Configured Clock Speed: 2666 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V

Handle 0x0045, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1280 kB
	Maximum Size: 1280 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0046, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 20480 kB
	Maximum Size: 20480 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x0047, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 28160 kB
	Maximum Size: 28160 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: Fully Associative

Handle 0x0048, DMI type 4, 48 bytes
Processor Information
	Socket Designation: CPU1
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel(R) Corporation
	ID: 54 06 05 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 85, Stepping 4
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
	Version: Intel(R) Xeon(R) Gold 6148 CPU @ 2.40GHz
	Voltage: 1.6 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2400 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0045
	L2 Cache Handle: 0x0046
	L3 Cache Handle: 0x0047
	(Line containing Serial number has been censored)
	Asset Tag: UNKNOWN
	Part Number: Not Specified
	Core Count: 20
	Core Enabled: 20
	Thread Count: 40
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0049, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1280 kB
	Maximum Size: 1280 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x004A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 20480 kB
	Maximum Size: 20480 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x004B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 28160 kB
	Maximum Size: 28160 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: Fully Associative

Handle 0x004C, DMI type 4, 48 bytes
Processor Information
	Socket Designation: CPU2
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel(R) Corporation
	ID: 54 06 05 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 85, Stepping 4
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
	Version: Intel(R) Xeon(R) Gold 6148 CPU @ 2.40GHz
	Voltage: 1.6 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2400 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0049
	L2 Cache Handle: 0x004A
	L3 Cache Handle: 0x004B
	(Line containing Serial number has been censored)
	Asset Tag: UNKNOWN
	Part Number: Not Specified
	Core Count: 20
	Core Enabled: 20
	Thread Count: 40
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0051, DMI type 9, 17 bytes
System Slot Information
	Designation: RSC-R1UW-2E16 SLOT1 PCI-E X16
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:ff:00.0

Handle 0x0052, DMI type 9, 17 bytes
System Slot Information
	Designation: RSC-R1UW-2E16 SLOT2 PCI-E X16
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:ff:00.0

Handle 0x0054, DMI type 9, 17 bytes
System Slot Information
	Designation: RSC-R1UW-E8R SLOT1 PCI-E X8
	Type: x8 PCI Express 3 x8
	Current Usage: Available
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:ff:00.0


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
OLDPWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r3_isotropic_star_constant/SkylakeSP_Gold-6148_SNC_20190719_115133
PBS_O_HOME=/home/hpc/iwia/iwia84
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
RRZECLUSTER=TESTCLUSTER
EDITOR=vi
PBS_JOBID=4701.catstor
ENVIRONMENT=BATCH
PATH_modshare=/usr/bin/vendor_perl:999999999:/home/julian/.local/.bin:999999999:/opt/android-sdk/tools:999999999:/usr/bin:1:/mnt/opt/likwid-4.3-dev/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/local/bin:999999999:/opt/android-sdk/platform-tools:999999999:/usr/bin/core_perl:999999999:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/home/julian/.bin:999999999:/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/apps/python/3.6-anaconda/bin:1:/mnt/opt/likwid-4.3-dev/sbin:1:/opt/intel/bin:999999999
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
LOADEDMODULES_modshare=intel64/19.0up02:1:likwid/4.3-dev:1:intelmpi/2019up02-intel:1:python/3.6-anaconda:1:mkl/2019up02:1:pbspro/default:2
PBS_JOBNAME=SKL_stempel_bench
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NCPUS=80
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
PBS_NODEFILE=/var/spool/pbspro/aux/4701.catstor
GROUP=iwia
PBS_TASKNUM=1
LIKWID_DEFINES=-DLIKWID_PERFMON
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r3_heterogeneous_star_constant/SkylakeSP_Gold-6148_SNC_20190719_154855
HOME=/home/hpc/iwia/iwia84
LIKWID_LIB=-L/mnt/opt/likwid-4.3-dev/lib
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_MOMPORT=15003
LIKWID_INCDIR=/mnt/opt/likwid-4.3-dev/include
_LMFILES__modshare=/apps/modules/modulefiles/tools/python/3.6-anaconda:1:/apps/modules/modulefiles/libraries/mkl/2019up02:2:/opt/modules/modulefiles/testcluster/pbspro/default:2:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:1:/opt/modules/modulefiles/testcluster/likwid/4.3-dev:1
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
PBS_JOBCOOKIE=062A5C3401EB0BF90F52C9DB59C3C713
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
PBS_O_SHELL=/bin/bash
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LESS_TERMCAP_mb=[1;32m
LESS_TERMCAP_md=[1;34m
LESS_TERMCAP_me=[0m
TMPDIR=/scratch/pbs.4701.catstor
LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
LIKWID_INC=-I/mnt/opt/likwid-4.3-dev/include
LOADEDMODULES=pbspro/default:likwid/4.3-dev:intelmpi/2019up02-intel:mkl/2019up02:intel64/19.0up02:python/3.6-anaconda
DAALROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal
MPILIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib
PBS_CONF=/etc/pbspro.conf
INTEL_LICENSE_FILE=1713@license4
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
OMP_NUM_THREADS=80
PBS_O_MAIL=/var/mail/iwia84
_=/usr/bin/env
{%- endcapture -%}

{% include stencil_template.md %}
