---

title:  "Stencil 3D r1 box constant heterogeneous double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "r1"
weighting    : "heterogeneous"
kind         : "box"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "53"
scaling      : [ "1270" ]
blocking     : [ "L2-3D", "L3-3D" ]
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
vmovupd ymm15, ymmword ptr [rsp+0x3a0]
vmulpd ymm12, ymm1, ymmword ptr [rsi+r9*8+0x10]
vmulpd ymm14, ymm0, ymmword ptr [rdi+r9*8+0x10]
vmulpd ymm13, ymm4, ymmword ptr [rax+r9*8+0x10]
vmulpd ymm11, ymm15, ymmword ptr [r12+r9*8+0x10]
vfmadd231pd ymm12, ymm3, ymmword ptr [r11+r9*8+0x10]
vfmadd231pd ymm14, ymm2, ymmword ptr [r15+r9*8+0x10]
vfmadd231pd ymm13, ymm5, ymmword ptr [r13+r9*8+0x10]
vmovupd ymm15, ymmword ptr [rsp+0x3c0]
vfmadd231pd ymm11, ymm6, ymmword ptr [r14+r9*8+0x10]
vaddpd ymm12, ymm12, ymm14
vaddpd ymm14, ymm11, ymm13
vmulpd ymm11, ymm8, ymmword ptr [rdi+r9*8+0x8]
vaddpd ymm13, ymm12, ymm14
vmovupd ymm12, ymmword ptr [rsp+0x3e0]
vfmadd231pd ymm11, ymm15, ymmword ptr [r15+r9*8+0x8]
vmulpd ymm15, ymm7, ymmword ptr [r10+r9*8+0x10]
vmovupd ymm14, ymmword ptr [rsp+0x420]
vfmadd231pd ymm15, ymm9, ymmword ptr [rsi+r9*8+0x8]
vaddpd ymm15, ymm11, ymm15
vmulpd ymm11, ymm12, ymmword ptr [r12+r9*8+0x8]
vmovupd ymm12, ymmword ptr [rsp+0x400]
vfmadd231pd ymm11, ymm14, ymmword ptr [r14+r9*8+0x8]
vmulpd ymm14, ymm10, ymmword ptr [r11+r9*8+0x8]
vfmadd231pd ymm14, ymm12, ymmword ptr [r13+r9*8+0x8]
vmovupd ymm12, ymmword ptr [rsp+0x480]
vaddpd ymm11, ymm11, ymm14
vaddpd ymm15, ymm15, ymm11
vmovupd ymm11, ymmword ptr [rsp+0x4a0]
vaddpd ymm15, ymm13, ymm15
vmovupd ymm13, ymmword ptr [rsp+0x460]
vmulpd ymm14, ymm13, ymmword ptr [rdi+r9*8]
vmovupd ymm13, ymmword ptr [rsp+0x440]
vfmadd231pd ymm14, ymm11, ymmword ptr [r15+r9*8]
vmulpd ymm11, ymm13, ymmword ptr [r10+r9*8+0x8]
vfmadd231pd ymm11, ymm12, ymmword ptr [rsi+r9*8]
vaddpd ymm13, ymm14, ymm11
vmovupd ymm14, ymmword ptr [rsp+0x4e0]
vmovupd ymm11, ymmword ptr [rsp+0x520]
vmulpd ymm12, ymm14, ymmword ptr [rax+r9*8]
vmovupd ymm14, ymmword ptr [rsp+0x4c0]
vfmadd231pd ymm12, ymm11, ymmword ptr [r13+r9*8]
vmulpd ymm14, ymm14, ymmword ptr [r11+r9*8]
vmovupd ymm11, ymmword ptr [rsp+0x500]
vfmadd231pd ymm14, ymm11, ymmword ptr [r12+r9*8]
vaddpd ymm12, ymm12, ymm14
vaddpd ymm11, ymm13, ymm12
vmovupd ymm13, ymmword ptr [rsp+0x540]
vmovupd ymm12, ymmword ptr [rsp+0x560]
vmulpd ymm14, ymm13, ymmword ptr [r14+r9*8]
vmovupd ymm13, ymmword ptr [rsp+0x580]
vfmadd231pd ymm14, ymm12, ymmword ptr [r10+r9*8]
nop
vfmadd231pd ymm14, ymm13, ymmword ptr [rax+r9*8+0x8]
vaddpd ymm11, ymm11, ymm14
vaddpd ymm15, ymm15, ymm11
vmovupd ymmword ptr [r8+r9*8+0x8], ymm15
add r9, 0x4
cmp r9, rdx
jb 0xfffffffffffffe70
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2049/5;P ~ 400
L2: P <= 3277;P ~ 3270
L3: P <= 1441793/5;P ~ 288350
L1: 32*N*P - 16*P - 16 <= 32768;N*P ~ 20²
L2: 32*N*P - 16*P - 16 <= 262144;N*P ~ 90²
L3: 32*N*P - 16*P - 16 <= 23068672;N*P ~ 840²
{%- endcapture -%}

{%- capture iaca -%}
Throughput Analysis Report
--------------------------
Block Throughput: 22.05 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 19.5     0.0  | 19.5  | 22.0    22.0  | 22.0    21.0  |  1.0  |  1.0  |  1.0  |  0.0  |
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
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm15, ymmword ptr [rsp+0x3a0]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm12, ymm1, ymmword ptr [rsi+r9*8+0x10]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd ymm14, ymm0, ymmword ptr [rdi+r9*8+0x10]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vmulpd ymm13, ymm4, ymmword ptr [rax+r9*8+0x10]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vmulpd ymm11, ymm15, ymmword ptr [r12+r9*8+0x10]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm12, ymm3, ymmword ptr [r11+r9*8+0x10]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm14, ymm2, ymmword ptr [r15+r9*8+0x10]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm13, ymm5, ymmword ptr [r13+r9*8+0x10]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm15, ymmword ptr [rsp+0x3c0]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm11, ymm6, ymmword ptr [r14+r9*8+0x10]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm12, ymm12, ymm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm14, ymm11, ymm13
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd ymm11, ymm8, ymmword ptr [rdi+r9*8+0x8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm13, ymm12, ymm14
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm12, ymmword ptr [rsp+0x3e0]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm11, ymm15, ymmword ptr [r15+r9*8+0x8]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm15, ymm7, ymmword ptr [r10+r9*8+0x10]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm14, ymmword ptr [rsp+0x420]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm15, ymm9, ymmword ptr [rsi+r9*8+0x8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm15, ymm11, ymm15
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd ymm11, ymm12, ymmword ptr [r12+r9*8+0x8]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm12, ymmword ptr [rsp+0x400]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm11, ymm14, ymmword ptr [r14+r9*8+0x8]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vmulpd ymm14, ymm10, ymmword ptr [r11+r9*8+0x8]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm14, ymm12, ymmword ptr [r13+r9*8+0x8]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm12, ymmword ptr [rsp+0x480]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm11, ymm11, ymm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm15, ymm15, ymm11
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm11, ymmword ptr [rsp+0x4a0]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm15, ymm13, ymm15
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm13, ymmword ptr [rsp+0x460]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vmulpd ymm14, ymm13, ymmword ptr [rdi+r9*8]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm13, ymmword ptr [rsp+0x440]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm14, ymm11, ymmword ptr [r15+r9*8]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm11, ymm13, ymmword ptr [r10+r9*8+0x8]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm11, ymm12, ymmword ptr [rsi+r9*8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm13, ymm14, ymm11
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm14, ymmword ptr [rsp+0x4e0]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm11, ymmword ptr [rsp+0x520]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm12, ymm14, ymmword ptr [rax+r9*8]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm14, ymmword ptr [rsp+0x4c0]
|   2      | 0.5         | 0.5  |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm12, ymm11, ymmword ptr [r13+r9*8]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vmulpd ymm14, ymm14, ymmword ptr [r11+r9*8]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm11, ymmword ptr [rsp+0x500]
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm14, ymm11, ymmword ptr [r12+r9*8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm12, ymm12, ymm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm11, ymm13, ymm12
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm13, ymmword ptr [rsp+0x540]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm12, ymmword ptr [rsp+0x560]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm14, ymm13, ymmword ptr [r14+r9*8]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm13, ymmword ptr [rsp+0x580]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vfmadd231pd ymm14, ymm12, ymmword ptr [r10+r9*8]
|   1      |             |      |             |             |      |      | 1.0  |      | nop
|   2      | 0.5         | 0.5  | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm14, ymm13, ymmword ptr [rax+r9*8+0x8]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm11, ymm11, ymm14
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm15, ymm15, ymm11
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r8+r9*8+0x8], ymm15
|   1      |             |      |             |             |      | 1.0  |      |      | add r9, 0x4
|   1*     |             |      |             |             |      |      |      |      | cmp r9, rdx
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffe70
Total Num Of Uops: 87
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.
{%- endcapture -%}

{%- capture hostinfo -%}
################################################################################
# Logged in users
################################################################################
 10:54:06 up 105 days, 19:26,  0 users,  load average: 0.15, 0.03, 0.01
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
Size:			22 MB
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
Free memory:		31441.5 MB
Total memory:		32041.7 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 9 45 10 46 11 47 12 48 13 49 14 50 15 51 16 52 17 53 )
Distances:		21 10 31 31
Free memory:		31999.7 MB
Total memory:		32252.6 MB
--------------------------------------------------------------------------------
Domain:			2
Processors:		( 18 54 19 55 20 56 21 57 22 58 23 59 24 60 25 61 26 62 )
Distances:		31 31 10 21
Free memory:		31793.2 MB
Total memory:		32252.6 MB
--------------------------------------------------------------------------------
Domain:			3
Processors:		( 27 63 28 64 29 65 30 66 31 67 32 68 33 69 34 70 35 71 )
Distances:		31 31 21 10
Free memory:		31269.8 MB
Total memory:		32251.1 MB
--------------------------------------------------------------------------------
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 36 37 38 39 40 41 42 43 44
node 0 size: 32041 MB
node 0 free: 31441 MB
node 1 cpus: 9 10 11 12 13 14 15 16 17 45 46 47 48 49 50 51 52 53
node 1 size: 32252 MB
node 1 free: 31999 MB
node 2 cpus: 18 19 20 21 22 23 24 25 26 54 55 56 57 58 59 60 61 62
node 2 size: 32252 MB
node 2 free: 31803 MB
node 3 cpus: 27 28 29 30 31 32 33 34 35 63 64 65 66 67 68 69 70 71
node 3 size: 32251 MB
node 3 free: 31269 MB
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
CPU 0: governor  performance min/cur/max 2.3/1.599/2.3 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.3/1.712/2.3 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.3/1.853/2.3 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.3/1.935/2.3 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.3/2.299/2.3 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.3/2.302/2.3 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.3/2.302/2.3 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.3/2.303/2.3 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.3/2.302/2.3 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.3/1.399/2.3 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.3/2.296/2.3 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.3/2.233/2.3 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.3/2.235/2.3 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.3/2.251/2.3 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.3/2.280/2.3 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.3/2.301/2.3 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.3/2.240/2.3 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.3/2.100/2.3 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 32: governor  performance min/cur/max 2.3/2.060/2.3 GHz Turbo 0
CPU 33: governor  performance min/cur/max 2.3/2.055/2.3 GHz Turbo 0
CPU 34: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 35: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 36: governor  performance min/cur/max 2.3/2.026/2.3 GHz Turbo 0
CPU 37: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 38: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 39: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 40: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 41: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 42: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 43: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 44: governor  performance min/cur/max 2.3/2.299/2.3 GHz Turbo 0
CPU 45: governor  performance min/cur/max 2.3/2.281/2.3 GHz Turbo 0
CPU 46: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 47: governor  performance min/cur/max 2.3/2.299/2.3 GHz Turbo 0
CPU 48: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 49: governor  performance min/cur/max 2.3/2.293/2.3 GHz Turbo 0
CPU 50: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 51: governor  performance min/cur/max 2.3/2.299/2.3 GHz Turbo 0
CPU 52: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 53: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 54: governor  performance min/cur/max 2.3/2.125/2.3 GHz Turbo 0
CPU 55: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 56: governor  performance min/cur/max 2.3/2.285/2.3 GHz Turbo 0
CPU 57: governor  performance min/cur/max 2.3/2.235/2.3 GHz Turbo 0
CPU 58: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 59: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 60: governor  performance min/cur/max 2.3/2.293/2.3 GHz Turbo 0
CPU 61: governor  performance min/cur/max 2.3/2.295/2.3 GHz Turbo 0
CPU 62: governor  performance min/cur/max 2.3/2.280/2.3 GHz Turbo 0
CPU 63: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 64: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 65: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 66: governor  performance min/cur/max 2.3/2.222/2.3 GHz Turbo 0
CPU 67: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 68: governor  performance min/cur/max 2.3/2.029/2.3 GHz Turbo 0
CPU 69: governor  performance min/cur/max 2.3/2.054/2.3 GHz Turbo 0
CPU 70: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 71: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0

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
0.14 0.03 0.01 1/774 27456

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
MemTotal:       131889148 kB
MemFree:        129541936 kB
MemAvailable:   129604892 kB
Buffers:          173480 kB
Cached:           512880 kB
SwapCached:        49184 kB
Active:           491360 kB
Inactive:         266836 kB
Active(anon):      23048 kB
Inactive(anon):    49144 kB
Active(file):     468312 kB
Inactive(file):   217692 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      67043324 kB
SwapFree:       66959100 kB
Dirty:              1692 kB
Writeback:             0 kB
AnonPages:         23812 kB
Mapped:           111568 kB
Shmem:               348 kB
Slab:             768876 kB
SReclaimable:     358824 kB
SUnreclaim:       410052 kB
KernelStack:       13568 kB
PageTables:         4072 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    132987896 kB
Committed_AS:     348152 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:      6144 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      916224 kB
DirectMap2M:    46141440 kB
DirectMap1G:    89128960 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: [always] madvise never
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
Linux broadep2 4.15.0-42-generic #45-Ubuntu SMP Thu Nov 15 19:32:57 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Hostname
################################################################################
broadep2.rrze.uni-erlangen.de
{%- endcapture -%}

{% include stencil_template.md %}
