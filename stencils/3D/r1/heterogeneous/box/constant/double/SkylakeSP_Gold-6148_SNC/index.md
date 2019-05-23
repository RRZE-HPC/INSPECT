---

title:  "Stencil 3D r1 box constant heterogeneous double SkylakeSP_Gold-6148_SNC"

dimension    : "3D"
radius       : "r1"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_SNC"
flavor       : "Sub-NUMA Clustering"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "53"
scaling      : [ "1140" ]
blocking     : [ "L3-3D" ]
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
double c7;
double c8;
double c9;
double c10;
double c11;
double c12;
double c13;
double c14;
double c15;
double c16;
double c17;
double c18;
double c19;
double c20;
double c21;
double c22;
double c23;
double c24;
double c25;
double c26;

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * a[k-1][j-1][i-1]
+ c2 * a[k][j-1][i-1]
+ c3 * a[k+1][j-1][i-1]
+ c4 * a[k-1][j][i-1]
+ c5 * a[k][j][i-1]
+ c6 * a[k+1][j][i-1]
+ c7 * a[k-1][j+1][i-1]
+ c8 * a[k][j+1][i-1]
+ c9 * a[k+1][j+1][i-1]
+ c10 * a[k-1][j-1][i]
+ c11 * a[k][j-1][i]
+ c12 * a[k+1][j-1][i]
+ c13 * a[k-1][j][i]
+ c14 * a[k+1][j][i]
+ c15 * a[k-1][j+1][i]
+ c16 * a[k][j+1][i]
+ c17 * a[k+1][j+1][i]
+ c18 * a[k-1][j-1][i+1]
+ c19 * a[k][j-1][i+1]
+ c20 * a[k+1][j-1][i+1]
+ c21 * a[k-1][j][i+1]
+ c22 * a[k][j][i+1]
+ c23 * a[k+1][j][i+1]
+ c24 * a[k-1][j+1][i+1]
+ c25 * a[k][j+1][i+1]
+ c26 * a[k+1][j+1][i+1]
;
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpq k1, ymm15, ymmword ptr [rsp+0x280], 0x1
vpaddq ymm15, ymm15, ymmword ptr [rip+0x26f7]
vmovupd ymm16{k1}{z}, ymmword ptr [r11+r13*8]
vmovupd ymm31{k1}{z}, ymmword ptr [r12+r13*8]
vmovupd ymm13{k1}{z}, ymmword ptr [r15+r13*8]
vmovupd ymm14{k1}{z}, ymmword ptr [r15+r13*8+0x8]
vmovupd ymm23{k1}{z}, ymmword ptr [r8+r13*8]
vmulpd ymm24, ymm19, ymm16
vmovupd ymm16{k1}{z}, ymmword ptr [r9+r13*8]
vmulpd ymm13, ymm22, ymm13
vfmadd231pd ymm24, ymm31, ymm18
vmovupd ymm31{k1}{z}, ymmword ptr [rdi+r13*8]
vfmadd231pd ymm13, ymm23, ymm20
vmulpd ymm23, ymm25, ymm16
vmovupd ymm16{k1}{z}, ymmword ptr [rcx+r13*8]
vfmadd231pd ymm24, ymm14, ymm17
vmovupd ymm14{k1}{z}, ymmword ptr [r10+r13*8]
vfmadd231pd ymm23, ymm14, ymm21
vmulpd ymm14, ymm26, ymm31
vmovupd ymm31{k1}{z}, ymmword ptr [r12+r13*8+0x8]
vaddpd ymm13, ymm13, ymm23
vmovupd ymm23{k1}{z}, ymmword ptr [rbx+r13*8]
vfmadd231pd ymm14, ymm16, ymmword ptr [rsp+0x2a0]
vmulpd ymm16, ymm27, ymm31
vfmadd231pd ymm16, ymm23, ymmword ptr [rsp+0x2c0]
vmovupd ymm23{k1}{z}, ymmword ptr [r11+r13*8+0x8]
vaddpd ymm14, ymm14, ymm16
vaddpd ymm13, ymm14, ymm13
vaddpd ymm14, ymm13, ymm24
vmovupd ymm24{k1}{z}, ymmword ptr [r10+r13*8+0x8]
vmovupd ymm13{k1}{z}, ymmword ptr [r8+r13*8+0x8]
vmulpd ymm16, ymm6, ymm24
vmovupd ymm24{k1}{z}, ymmword ptr [r9+r13*8+0x8]
vfmadd231pd ymm16, ymm23, ymm28
vmulpd ymm31, ymm4, ymm24
vmovupd ymm23{k1}{z}, ymmword ptr [rcx+r13*8+0x8]
vmovupd ymm24{k1}{z}, ymmword ptr [r12+r13*8+0x10]
vfmadd231pd ymm31, ymm13, ymm29
vmovupd ymm13{k1}{z}, ymmword ptr [rdi+r13*8+0x8]
vaddpd ymm16, ymm16, ymm31
vmulpd ymm13, ymm1, ymm13
vmovupd ymm31{k1}{z}, ymmword ptr [rbx+r13*8+0x8]
vfmadd231pd ymm13, ymm23, ymm3
vmulpd ymm23, ymm0, ymm24
vmovupd ymm24{k1}{z}, ymmword ptr [r8+r13*8+0x10]
vfmadd231pd ymm23, ymm31, ymm2
vmovupd ymm31{k1}{z}, ymmword ptr [r11+r13*8+0x10]
vaddpd ymm13, ymm13, ymm23
vaddpd ymm13, ymm13, ymm16
vmovupd ymm16{k1}{z}, ymmword ptr [r10+r13*8+0x10]
vmulpd ymm23, ymm8, ymm16
vmovupd ymm16{k1}{z}, ymmword ptr [r15+r13*8+0x10]
vfmadd231pd ymm23, ymm31, ymm30
vmulpd ymm31, ymm5, ymm16
vmovupd ymm16{k1}{z}, ymmword ptr [rbx+r13*8+0x10]
vfmadd231pd ymm31, ymm24, ymm9
vmulpd ymm16, ymm10, ymm16
vmovupd ymm24{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
vaddpd ymm23, ymm23, ymm31
vmovupd ymm31{k1}{z}, ymmword ptr [r9+r13*8+0x10]
vfmadd231pd ymm16, ymm31, ymm12
vmovupd ymm31{k1}{z}, ymmword ptr [rdi+r13*8+0x10]
vmulpd ymm31, ymm7, ymm31
vfmadd231pd ymm31, ymm24, ymm11
vaddpd ymm24, ymm16, ymm31
vaddpd ymm23, ymm24, ymm23
vaddpd ymm13, ymm23, ymm13
vaddpd ymm14, ymm13, ymm14
vmovupd ymmword ptr [r14+r13*8+0x8]{k1}, ymm14
add r13, 0x4
cmp r13, rax
jb 0xfffffffffffffded
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;P ~ 400
L2: P <= 65537/5;P ~ 13100
L3: P <= 1835009/5;P ~ 367000
L1: 32*N*P - 16*P - 16 <= 32768;N*P ~ 20²
L2: 32*N*P - 16*P - 16 <= 1048576;N*P ~ 180²
L3: 32*N*P - 16*P - 16 <= 29360128;N*P ~ 950²
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 30.05 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 22.7     0.0  | 22.6  | 16.0    16.0  | 16.0    15.0  |  1.0  | 22.7  |  1.0  |  0.0  |
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
|   2      |             |      | 1.0     1.0 |             |      | 1.0  |      |      | vpcmpq k1, ymm15, ymmword ptr [rsp+0x280], 0x1
|   2^     |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vpaddq ymm15, ymm15, ymmword ptr [rip+0x26f7]
|   2      |             |      | 1.0     1.0 |             |      | 1.0  |      |      | vmovupd ymm16{k1}{z}, ymmword ptr [r11+r13*8]
|   2      | 0.3         | 0.3  |             | 1.0     1.0 |      | 0.4  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [r12+r13*8]
|   2      | 0.4         | 0.3  | 1.0     1.0 |             |      | 0.3  |      |      | vmovupd ymm13{k1}{z}, ymmword ptr [r15+r13*8]
|   2      | 0.3         | 0.4  |             | 1.0     1.0 |      | 0.3  |      |      | vmovupd ymm14{k1}{z}, ymmword ptr [r15+r13*8+0x8]
|   2      | 0.3         | 0.3  | 1.0     1.0 |             |      | 0.4  |      |      | vmovupd ymm23{k1}{z}, ymmword ptr [r8+r13*8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vmulpd ymm24, ymm19, ymm16
|   2      |             | 0.4  |             | 1.0     1.0 |      | 0.6  |      |      | vmovupd ymm16{k1}{z}, ymmword ptr [r9+r13*8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vmulpd ymm13, ymm22, ymm13
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vfmadd231pd ymm24, ymm31, ymm18
|   2      |             |      | 1.0     1.0 |             |      | 1.0  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [rdi+r13*8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm13, ymm23, ymm20
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm23, ymm25, ymm16
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm16{k1}{z}, ymmword ptr [rcx+r13*8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm24, ymm14, ymm17
|   2      |             | 0.3  | 1.0     1.0 |             |      | 0.7  |      |      | vmovupd ymm14{k1}{z}, ymmword ptr [r10+r13*8]
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vfmadd231pd ymm23, ymm14, ymm21
|   1      | 0.4         | 0.6  |             |             |      |      |      |      | vmulpd ymm14, ymm26, ymm31
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [r12+r13*8+0x8]
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vaddpd ymm13, ymm13, ymm23
|   2      |             | 0.3  | 1.0     1.0 |             |      | 0.7  |      |      | vmovupd ymm23{k1}{z}, ymmword ptr [rbx+r13*8]
|   2^     | 0.7         | 0.3  |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm14, ymm16, ymmword ptr [rsp+0x2a0]
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm16, ymm27, ymm31
|   2^     | 0.7         | 0.3  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm16, ymm23, ymmword ptr [rsp+0x2c0]
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm23{k1}{z}, ymmword ptr [r11+r13*8+0x8]
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vaddpd ymm14, ymm14, ymm16
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vaddpd ymm13, ymm14, ymm13
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vaddpd ymm14, ymm13, ymm24
|   2      |             |      | 1.0     1.0 |             |      | 1.0  |      |      | vmovupd ymm24{k1}{z}, ymmword ptr [r10+r13*8+0x8]
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm13{k1}{z}, ymmword ptr [r8+r13*8+0x8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vmulpd ymm16, ymm6, ymm24
|   2      |             | 0.4  | 1.0     1.0 |             |      | 0.6  |      |      | vmovupd ymm24{k1}{z}, ymmword ptr [r9+r13*8+0x8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm16, ymm23, ymm28
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm31, ymm4, ymm24
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm23{k1}{z}, ymmword ptr [rcx+r13*8+0x8]
|   2      | 0.3         | 0.3  | 1.0     1.0 |             |      | 0.4  |      |      | vmovupd ymm24{k1}{z}, ymmword ptr [r12+r13*8+0x10]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm31, ymm13, ymm29
|   2      |             | 0.4  |             | 1.0     1.0 |      | 0.6  |      |      | vmovupd ymm13{k1}{z}, ymmword ptr [rdi+r13*8+0x8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vaddpd ymm16, ymm16, ymm31
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm13, ymm1, ymm13
|   2      |             |      | 1.0     1.0 |             |      | 1.0  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [rbx+r13*8+0x8]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm13, ymm23, ymm3
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm23, ymm0, ymm24
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm24{k1}{z}, ymmword ptr [r8+r13*8+0x10]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm23, ymm31, ymm2
|   2      |             | 0.3  | 1.0     1.0 |             |      | 0.7  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [r11+r13*8+0x10]
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vaddpd ymm13, ymm13, ymm23
|   1      | 0.4         | 0.6  |             |             |      |      |      |      | vaddpd ymm13, ymm13, ymm16
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm16{k1}{z}, ymmword ptr [r10+r13*8+0x10]
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vmulpd ymm23, ymm8, ymm16
|   2      |             | 0.3  | 1.0     1.0 |             |      | 0.7  |      |      | vmovupd ymm16{k1}{z}, ymmword ptr [r15+r13*8+0x10]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm23, ymm31, ymm30
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm31, ymm5, ymm16
|   2      |             |      |             | 1.0     1.0 |      | 1.0  |      |      | vmovupd ymm16{k1}{z}, ymmword ptr [rbx+r13*8+0x10]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm31, ymm24, ymm9
|   1      | 0.3         | 0.7  |             |             |      |      |      |      | vmulpd ymm16, ymm10, ymm16
|   2      |             |      | 1.0     1.0 |             |      | 1.0  |      |      | vmovupd ymm24{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vaddpd ymm23, ymm23, ymm31
|   2      |             | 0.4  |             | 1.0     1.0 |      | 0.6  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [r9+r13*8+0x10]
|   1      | 0.7         | 0.3  |             |             |      |      |      |      | vfmadd231pd ymm16, ymm31, ymm12
|   2      |             | 0.3  | 1.0     1.0 |             |      | 0.7  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [rdi+r13*8+0x10]
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vmulpd ymm31, ymm7, ymm31
|   1      | 0.4         | 0.6  |             |             |      |      |      |      | vfmadd231pd ymm31, ymm24, ymm11
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vaddpd ymm24, ymm16, ymm31
|   1      | 0.4         | 0.6  |             |             |      |      |      |      | vaddpd ymm23, ymm24, ymm23
|   1      | 0.6         | 0.4  |             |             |      |      |      |      | vaddpd ymm13, ymm23, ymm13
|   1      | 0.4         | 0.6  |             |             |      |      |      |      | vaddpd ymm14, ymm13, ymm14
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r14+r13*8+0x8]{k1}, ymm14
|   1      |             |      |             |             |      |      | 1.0  |      | add r13, 0x4
|   1*     |             |      |             |             |      |      |      |      | cmp r13, rax
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffded
Total Num Of Uops: 103
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.

{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Logged in users
################################################################################
 10:56:55 up 8 days, 20:09,  0 users,  load average: 0.15, 0.03, 0.01
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
	0,40,1,41,2,42,5,45,6,46,10,50,11,51,12,52,15,55,16,56,3,43,4,44,7,47,8,48,9,49,13,53,14,54,17,57,18,58,19,59

Domain C1:
	20,60,21,61,22,62,25,65,26,66,30,70,31,71,32,72,35,75,36,76,23,63,24,64,27,67,28,68,29,69,33,73,34,74,37,77,38,78,39,79

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
Size:			28 MB
Cache groups:		( 0 40 1 41 2 42 5 45 6 46 10 50 11 51 12 52 15 55 16 56 3 43 4 44 7 47 8 48 9 49 13 53 14 54 17 57 18 58 19 59 ) ( 20 60 21 61 22 62 25 65 26 66 30 70 31 71 32 72 35 75 36 76 23 63 24 64 27 67 28 68 29 69 33 73 34 74 37 77 38 78 39 79 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		4
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 40 1 41 2 42 5 45 6 46 10 50 11 51 12 52 15 55 16 56 )
Distances:		10 11 21 21
Free memory:		22334.2 MB
Total memory:		22758.8 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 3 43 4 44 7 47 8 48 9 49 13 53 14 54 17 57 18 58 19 59 )
Distances:		11 10 21 21
Free memory:		23692 MB
Total memory:		24188.2 MB
--------------------------------------------------------------------------------
Domain:			2
Processors:		( 20 60 21 61 22 62 25 65 26 66 30 70 31 71 32 72 35 75 36 76 )
Distances:		21 21 10 11
Free memory:		23878.3 MB
Total memory:		24188.2 MB
--------------------------------------------------------------------------------
Domain:			3
Processors:		( 23 63 24 64 27 67 28 68 29 69 33 73 34 74 37 77 38 78 39 79 )
Distances:		21 21 11 10
Free memory:		23696.3 MB
Total memory:		24186.8 MB
--------------------------------------------------------------------------------
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 5 6 10 11 12 15 16 40 41 42 45 46 50 51 52 55 56
node 0 size: 22758 MB
node 0 free: 22343 MB
node 1 cpus: 3 4 7 8 9 13 14 17 18 19 43 44 47 48 49 53 54 57 58 59
node 1 size: 24188 MB
node 1 free: 23692 MB
node 2 cpus: 20 21 22 25 26 30 31 32 35 36 60 61 62 65 66 70 71 72 75 76
node 2 size: 24188 MB
node 2 free: 23878 MB
node 3 cpus: 23 24 27 28 29 33 34 37 38 39 63 64 67 68 69 73 74 77 78 79
node 3 size: 24186 MB
node 3 free: 23696 MB
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
CPU 0: governor  performance min/cur/max 2.4/1.529/2.4 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.4/1.931/2.4 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.4/2.284/2.4 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.4/1.928/2.4 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.4/2.274/2.4 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.4/2.401/2.4 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.4/1.943/2.4 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.4/1.945/2.4 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.4/1.918/2.4 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.4/1.941/2.4 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.4/2.288/2.4 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.4/2.286/2.4 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.4/1.413/2.4 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.4/2.394/2.4 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.4/2.150/2.4 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.4/2.336/2.4 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.4/2.156/2.4 GHz Turbo 0
CPU 32: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 35: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 36: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.4/2.401/2.4 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.4/1.838/2.4 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 33: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 34: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 37: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 38: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 39: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 40: governor  performance min/cur/max 2.4/1.137/2.4 GHz Turbo 0
CPU 41: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 42: governor  performance min/cur/max 2.4/1.856/2.4 GHz Turbo 0
CPU 45: governor  performance min/cur/max 2.4/1.958/2.4 GHz Turbo 0
CPU 46: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 50: governor  performance min/cur/max 2.4/2.273/2.4 GHz Turbo 0
CPU 51: governor  performance min/cur/max 2.4/1.854/2.4 GHz Turbo 0
CPU 52: governor  performance min/cur/max 2.4/1.922/2.4 GHz Turbo 0
CPU 55: governor  performance min/cur/max 2.4/1.867/2.4 GHz Turbo 0
CPU 56: governor  performance min/cur/max 2.4/1.845/2.4 GHz Turbo 0
CPU 43: governor  performance min/cur/max 2.4/2.401/2.4 GHz Turbo 0
CPU 44: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 47: governor  performance min/cur/max 2.4/2.332/2.4 GHz Turbo 0
CPU 48: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 49: governor  performance min/cur/max 2.4/1.913/2.4 GHz Turbo 0
CPU 53: governor  performance min/cur/max 2.4/1.775/2.4 GHz Turbo 0
CPU 54: governor  performance min/cur/max 2.4/1.880/2.4 GHz Turbo 0
CPU 57: governor  performance min/cur/max 2.4/1.873/2.4 GHz Turbo 0
CPU 58: governor  performance min/cur/max 2.4/1.830/2.4 GHz Turbo 0
CPU 59: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 60: governor  performance min/cur/max 2.4/1.000/2.4 GHz Turbo 0
CPU 61: governor  performance min/cur/max 2.4/2.382/2.4 GHz Turbo 0
CPU 62: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 65: governor  performance min/cur/max 2.4/2.281/2.4 GHz Turbo 0
CPU 66: governor  performance min/cur/max 2.4/2.345/2.4 GHz Turbo 0
CPU 70: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 71: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 72: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 75: governor  performance min/cur/max 2.4/2.004/2.4 GHz Turbo 0
CPU 76: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 63: governor  performance min/cur/max 2.4/2.401/2.4 GHz Turbo 0
CPU 64: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 67: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 68: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 69: governor  performance min/cur/max 2.4/2.259/2.4 GHz Turbo 0
CPU 73: governor  performance min/cur/max 2.4/1.751/2.4 GHz Turbo 0
CPU 74: governor  performance min/cur/max 2.4/2.400/2.4 GHz Turbo 0
CPU 77: governor  performance min/cur/max 2.4/1.744/2.4 GHz Turbo 0
CPU 78: governor  performance min/cur/max 2.4/1.864/2.4 GHz Turbo 0
CPU 79: governor  performance min/cur/max 2.4/1.827/2.4 GHz Turbo 0

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
0.22 0.05 0.02 1/793 66973

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
MemTotal:       97609764 kB
MemFree:        95847428 kB
MemAvailable:   95799624 kB
Buffers:           18484 kB
Cached:           479392 kB
SwapCached:            8 kB
Active:           343112 kB
Inactive:         205384 kB
Active(anon):      45988 kB
Inactive(anon):     6820 kB
Active(file):     297124 kB
Inactive(file):   198564 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      49632252 kB
SwapFree:       49631996 kB
Dirty:               292 kB
Writeback:             8 kB
AnonPages:         50756 kB
Mapped:           102964 kB
Shmem:              2124 kB
Slab:             668592 kB
SReclaimable:     239760 kB
SUnreclaim:       428832 kB
KernelStack:       14000 kB
PageTables:         3324 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    98437132 kB
Committed_AS:     347764 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:      8192 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      790736 kB
DirectMap2M:    12492800 kB
DirectMap1G:    88080384 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: [always] madvise never
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
# Modules
################################################################################

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
Linux skylakesp2 4.15.0-46-generic #49-Ubuntu SMP Wed Feb 6 09:33:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Hostname
################################################################################
skylakesp2.rrze.uni-erlangen.de
{%- endcapture -%}

{% include stencil_template.md %}
