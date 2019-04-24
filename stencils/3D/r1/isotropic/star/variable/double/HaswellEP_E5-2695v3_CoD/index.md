---

title:  "Stencil 3D r1 star variable isotropic double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r1"
weighting    : "isotropic"
kind         : "star"
coefficients : "variable"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.4/include -Llikwid-4.3.4/lib -I/headers/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "8"
scaling      : [ "940" ]
blocking     : [ "L2-3D", "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[2][M][N][P];

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = W[0][k][j][i] * a[k][j][i]
+ W[1][k][j][i] * ((a[k][j][i-1] + a[k][j][i+1]) + (a[k-1][j][i] + a[k+1][j][i]) + (a[k][j-1][i] + a[k][j+1][i]))
;
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm0, ymmword ptr [r14+rdx*1]
vmovupd ymm6, ymmword ptr [r14+rdx*1+0x8]
vaddpd ymm1, ymm0, ymmword ptr [r14+rdx*1+0x10]
vaddpd ymm2, ymm1, ymmword ptr [r10+r15*8+0x8]
vaddpd ymm3, ymm2, ymmword ptr [r12+r15*8+0x8]
vaddpd ymm4, ymm3, ymmword ptr [r13+r15*8+0x8]
vaddpd ymm5, ymm4, ymmword ptr [r11+r15*8+0x8]
vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8+0x8]
vfmadd231pd ymm7, ymm6, ymmword ptr [rbx+r15*8+0x8]
vmovupd ymmword ptr [r9+r15*8+0x8], ymm7
vmovupd ymm8, ymmword ptr [r14+rdx*1+0x20]
vmovupd ymm14, ymmword ptr [r14+rdx*1+0x28]
vaddpd ymm9, ymm8, ymmword ptr [r14+rdx*1+0x30]
vaddpd ymm10, ymm9, ymmword ptr [r10+r15*8+0x28]
vaddpd ymm11, ymm10, ymmword ptr [r12+r15*8+0x28]
vaddpd ymm12, ymm11, ymmword ptr [r13+r15*8+0x28]
vaddpd ymm13, ymm12, ymmword ptr [r11+r15*8+0x28]
vmulpd ymm15, ymm13, ymmword ptr [r8+r15*8+0x28]
vfmadd231pd ymm15, ymm14, ymmword ptr [rbx+r15*8+0x28]
vmovupd ymmword ptr [r9+r15*8+0x28], ymm15
vmovupd ymm0, ymmword ptr [r14+rdx*1+0x40]
vmovupd ymm6, ymmword ptr [r14+rdx*1+0x48]
vaddpd ymm1, ymm0, ymmword ptr [r14+rdx*1+0x50]
vaddpd ymm2, ymm1, ymmword ptr [r10+r15*8+0x48]
vaddpd ymm3, ymm2, ymmword ptr [r12+r15*8+0x48]
vaddpd ymm4, ymm3, ymmword ptr [r13+r15*8+0x48]
vaddpd ymm5, ymm4, ymmword ptr [r11+r15*8+0x48]
vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8+0x48]
vfmadd231pd ymm7, ymm6, ymmword ptr [rbx+r15*8+0x48]
vmovupd ymmword ptr [r9+r15*8+0x48], ymm7
vmovupd ymm8, ymmword ptr [r14+rdx*1+0x60]
vmovupd ymm14, ymmword ptr [r14+rdx*1+0x68]
vaddpd ymm9, ymm8, ymmword ptr [r14+rdx*1+0x70]
vaddpd ymm10, ymm9, ymmword ptr [r10+r15*8+0x68]
add r14, 0x80
vaddpd ymm11, ymm10, ymmword ptr [r12+r15*8+0x68]
vaddpd ymm12, ymm11, ymmword ptr [r13+r15*8+0x68]
vaddpd ymm13, ymm12, ymmword ptr [r11+r15*8+0x68]
vmulpd ymm0, ymm13, ymmword ptr [r8+r15*8+0x68]
vfmadd231pd ymm0, ymm14, ymmword ptr [rbx+r15*8+0x68]
vmovupd ymmword ptr [r9+r15*8+0x68], ymm0
add r15, 0x10
cmp r15, rax
jb 0xfffffffffffffedb
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2051/4;P ~ 510
L2: P <= 16387/4;P ~ 4090
L3: P <= 1179651/4;P ~ 294910
L1: 32*N*P + 16*P*(N - 1) - 16*P <= 32768;N*P ~ 20²
L2: 32*N*P + 16*P*(N - 1) - 16*P <= 262144;N*P ~ 70²
L3: 32*N*P + 16*P*(N - 1) - 16*P <= 18874368;N*P ~ 620²
{%- endcapture -%}
{%- capture iaca -%}
Throughput Analysis Report
--------------------------
Block Throughput: 20.00 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles |  8.0     0.0  | 20.0  | 20.0    20.0  | 20.0    16.0  |  4.0  |  1.0  |  1.0  |  0.0  |
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
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm0, ymmword ptr [r14+rdx*1]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm6, ymmword ptr [r14+rdx*1+0x8]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm1, ymm0, ymmword ptr [r14+rdx*1+0x10]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm2, ymm1, ymmword ptr [r10+r15*8+0x8]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm3, ymm2, ymmword ptr [r12+r15*8+0x8]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm4, ymm3, ymmword ptr [r13+r15*8+0x8]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm5, ymm4, ymmword ptr [r11+r15*8+0x8]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8+0x8]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm7, ymm6, ymmword ptr [rbx+r15*8+0x8]
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r9+r15*8+0x8], ymm7
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm8, ymmword ptr [r14+rdx*1+0x20]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm14, ymmword ptr [r14+rdx*1+0x28]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm9, ymm8, ymmword ptr [r14+rdx*1+0x30]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm10, ymm9, ymmword ptr [r10+r15*8+0x28]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm11, ymm10, ymmword ptr [r12+r15*8+0x28]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm12, ymm11, ymmword ptr [r13+r15*8+0x28]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm13, ymm12, ymmword ptr [r11+r15*8+0x28]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm15, ymm13, ymmword ptr [r8+r15*8+0x28]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm15, ymm14, ymmword ptr [rbx+r15*8+0x28]
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r9+r15*8+0x28], ymm15
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm0, ymmword ptr [r14+rdx*1+0x40]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm6, ymmword ptr [r14+rdx*1+0x48]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm1, ymm0, ymmword ptr [r14+rdx*1+0x50]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm2, ymm1, ymmword ptr [r10+r15*8+0x48]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm3, ymm2, ymmword ptr [r12+r15*8+0x48]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm4, ymm3, ymmword ptr [r13+r15*8+0x48]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm5, ymm4, ymmword ptr [r11+r15*8+0x48]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm7, ymm5, ymmword ptr [r8+r15*8+0x48]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm7, ymm6, ymmword ptr [rbx+r15*8+0x48]
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r9+r15*8+0x48], ymm7
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm8, ymmword ptr [r14+rdx*1+0x60]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm14, ymmword ptr [r14+rdx*1+0x68]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm9, ymm8, ymmword ptr [r14+rdx*1+0x70]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm10, ymm9, ymmword ptr [r10+r15*8+0x68]
|   1      |             |      |             |             |      |      | 1.0  |      | add r14, 0x80
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm11, ymm10, ymmword ptr [r12+r15*8+0x68]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm12, ymm11, ymmword ptr [r13+r15*8+0x68]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm13, ymm12, ymmword ptr [r11+r15*8+0x68]
|   2      | 1.0         |      |             | 1.0     1.0 |      |      |      |      | vmulpd ymm0, ymm13, ymmword ptr [r8+r15*8+0x68]
|   2      | 1.0         |      | 1.0     1.0 |             |      |      |      |      | vfmadd231pd ymm0, ymm14, ymmword ptr [rbx+r15*8+0x68]
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r9+r15*8+0x68], ymm0
|   1      |             |      |             |             |      | 1.0  |      |      | add r15, 0x10
|   1*     |             |      |             |             |      |      |      |      | cmp r15, rax
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffedb
Total Num Of Uops: 75
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.
{%- endcapture -%}
{%- capture hostinfo -%}
################################################################################
# Hostname
################################################################################
hasep1.rrze.uni-erlangen.de

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
Linux hasep1 4.15.0-46-generic #49-Ubuntu SMP Wed Feb 6 09:33:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Logged in users
################################################################################
 05:24:35 up 20 days, 16:28,  0 users,  load average: 0.68, 0.86, 0.94
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CPUset
################################################################################
Domain N:
	0,28,1,29,2,30,3,31,4,32,5,33,6,34,7,35,8,36,9,37,10,38,11,39,12,40,13,41,14,42,15,43,16,44,17,45,18,46,19,47,20,48,21,49,22,50,23,51,24,52,25,53,26,54,27,55

Domain S0:
	0,28,1,29,2,30,3,31,4,32,5,33,6,34,7,35,8,36,9,37,10,38,11,39,12,40,13,41

Domain S1:
	14,42,15,43,16,44,17,45,18,46,19,47,20,48,21,49,22,50,23,51,24,52,25,53,26,54,27,55

Domain C0:
	0,28,1,29,2,30,3,31,4,32,5,33,6,34

Domain C1:
	7,35,8,36,9,37,10,38,11,39,12,40,13,41

Domain C2:
	14,42,15,43,16,44,17,45,18,46,19,47,20,48

Domain C3:
	21,49,22,50,23,51,24,52,25,53,26,54,27,55

Domain M0:
	0,28,1,29,2,30,3,31,4,32,5,33,6,34

Domain M1:
	7,35,8,36,9,37,10,38,11,39,12,40,13,41

Domain M2:
	14,42,15,43,16,44,17,45,18,46,19,47,20,48

Domain M3:
	21,49,22,50,23,51,24,52,25,53,26,54,27,55


################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-55
Allowed Memory controllers: 0-3

################################################################################
# Topology
################################################################################
--------------------------------------------------------------------------------
CPU name:	Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz
CPU type:	Intel Xeon Haswell EN/EP/EX processor
CPU stepping:	2
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:		2
Cores per socket:	14
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
14		0		14		1		*
15		0		15		1		*
16		0		16		1		*
17		0		17		1		*
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
28		1		0		0		*
29		1		1		0		*
30		1		2		0		*
31		1		3		0		*
32		1		4		0		*
33		1		5		0		*
34		1		6		0		*
35		1		7		0		*
36		1		8		0		*
37		1		9		0		*
38		1		10		0		*
39		1		11		0		*
40		1		12		0		*
41		1		13		0		*
42		1		14		1		*
43		1		15		1		*
44		1		16		1		*
45		1		17		1		*
46		1		18		1		*
47		1		19		1		*
48		1		20		1		*
49		1		21		1		*
50		1		22		1		*
51		1		23		1		*
52		1		24		1		*
53		1		25		1		*
54		1		26		1		*
55		1		27		1		*
--------------------------------------------------------------------------------
Socket 0:		( 0 28 1 29 2 30 3 31 4 32 5 33 6 34 7 35 8 36 9 37 10 38 11 39 12 40 13 41 )
Socket 1:		( 14 42 15 43 16 44 17 45 18 46 19 47 20 48 21 49 22 50 23 51 24 52 25 53 26 54 27 55 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:			1
Size:			32 kB
Cache groups:		( 0 28 ) ( 1 29 ) ( 2 30 ) ( 3 31 ) ( 4 32 ) ( 5 33 ) ( 6 34 ) ( 7 35 ) ( 8 36 ) ( 9 37 ) ( 10 38 ) ( 11 39 ) ( 12 40 ) ( 13 41 ) ( 14 42 ) ( 15 43 ) ( 16 44 ) ( 17 45 ) ( 18 46 ) ( 19 47 ) ( 20 48 ) ( 21 49 ) ( 22 50 ) ( 23 51 ) ( 24 52 ) ( 25 53 ) ( 26 54 ) ( 27 55 )
--------------------------------------------------------------------------------
Level:			2
Size:			256 kB
Cache groups:		( 0 28 ) ( 1 29 ) ( 2 30 ) ( 3 31 ) ( 4 32 ) ( 5 33 ) ( 6 34 ) ( 7 35 ) ( 8 36 ) ( 9 37 ) ( 10 38 ) ( 11 39 ) ( 12 40 ) ( 13 41 ) ( 14 42 ) ( 15 43 ) ( 16 44 ) ( 17 45 ) ( 18 46 ) ( 19 47 ) ( 20 48 ) ( 21 49 ) ( 22 50 ) ( 23 51 ) ( 24 52 ) ( 25 53 ) ( 26 54 ) ( 27 55 )
--------------------------------------------------------------------------------
Level:			3
Size:			9 MB
Cache groups:		( 0 28 1 29 2 30 3 31 4 32 5 33 6 34 ) ( 7 35 8 36 9 37 10 38 11 39 12 40 13 41 ) ( 14 42 15 43 16 44 17 45 18 46 19 47 20 48 ) ( 21 49 22 50 23 51 24 52 25 53 26 54 27 55 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		4
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 28 1 29 2 30 3 31 4 32 5 33 6 34 )
Distances:		10 21 31 31
Free memory:		15580 MB
Total memory:		15932.8 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 7 35 8 36 9 37 10 38 11 39 12 40 13 41 )
Distances:		21 10 31 31
Free memory:		15483.1 MB
Total memory:		16125.3 MB
--------------------------------------------------------------------------------
Domain:			2
Processors:		( 14 42 15 43 16 44 17 45 18 46 19 47 20 48 )
Distances:		31 31 10 21
Free memory:		15838.8 MB
Total memory:		16125.3 MB
--------------------------------------------------------------------------------
Domain:			3
Processors:		( 21 49 22 50 23 51 24 52 25 53 26 54 27 55 )
Distances:		31 31 21 10
Free memory:		15715.3 MB
Total memory:		16124.4 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 28 29 30 31 32 33 34
node 0 size: 15932 MB
node 0 free: 15580 MB
node 1 cpus: 7 8 9 10 11 12 13 35 36 37 38 39 40 41
node 1 size: 16125 MB
node 1 free: 15483 MB
node 2 cpus: 14 15 16 17 18 19 20 42 43 44 45 46 47 48
node 2 size: 16125 MB
node 2 free: 15847 MB
node 3 cpus: 21 22 23 24 25 26 27 49 50 51 52 53 54 55
node 3 size: 16124 MB
node 3 free: 15714 MB
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
CPU 0: governor  performance min/cur/max 2.3/1.681/2.3 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.3/1.854/2.3 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.3/1.313/2.3 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.3/1.296/2.3 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.3/1.640/2.3 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.3/1.661/2.3 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.3/1.306/2.3 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.3/1.540/2.3 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.3/1.632/2.3 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.3/1.313/2.3 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.3/1.448/2.3 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.3/1.567/2.3 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.3/1.458/2.3 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.3/1.256/2.3 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.3/2.292/2.3 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.3/2.145/2.3 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.3/2.274/2.3 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.3/2.121/2.3 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.3/2.157/2.3 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.3/2.257/2.3 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.3/1.812/2.3 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.3/2.303/2.3 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.3/1.281/2.3 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.3/1.766/2.3 GHz Turbo 0
CPU 32: governor  performance min/cur/max 2.3/1.602/2.3 GHz Turbo 0
CPU 33: governor  performance min/cur/max 2.3/1.763/2.3 GHz Turbo 0
CPU 34: governor  performance min/cur/max 2.3/1.770/2.3 GHz Turbo 0
CPU 35: governor  performance min/cur/max 2.3/1.413/2.3 GHz Turbo 0
CPU 36: governor  performance min/cur/max 2.3/1.620/2.3 GHz Turbo 0
CPU 37: governor  performance min/cur/max 2.3/1.511/2.3 GHz Turbo 0
CPU 38: governor  performance min/cur/max 2.3/1.201/2.3 GHz Turbo 0
CPU 39: governor  performance min/cur/max 2.3/1.660/2.3 GHz Turbo 0
CPU 40: governor  performance min/cur/max 2.3/1.756/2.3 GHz Turbo 0
CPU 41: governor  performance min/cur/max 2.3/1.395/2.3 GHz Turbo 0
CPU 42: governor  performance min/cur/max 2.3/2.260/2.3 GHz Turbo 0
CPU 43: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 44: governor  performance min/cur/max 2.3/2.161/2.3 GHz Turbo 0
CPU 45: governor  performance min/cur/max 2.3/2.272/2.3 GHz Turbo 0
CPU 46: governor  performance min/cur/max 2.3/2.243/2.3 GHz Turbo 0
CPU 47: governor  performance min/cur/max 2.3/2.272/2.3 GHz Turbo 0
CPU 48: governor  performance min/cur/max 2.3/2.290/2.3 GHz Turbo 0
CPU 49: governor  performance min/cur/max 2.3/2.162/2.3 GHz Turbo 0
CPU 50: governor  performance min/cur/max 2.3/2.295/2.3 GHz Turbo 0
CPU 51: governor  performance min/cur/max 2.3/2.126/2.3 GHz Turbo 0
CPU 52: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 53: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 54: governor  performance min/cur/max 2.3/2.272/2.3 GHz Turbo 0
CPU 55: governor  performance min/cur/max 2.3/2.284/2.3 GHz Turbo 0

Current Uncore frequencies:
Socket 0: min/max 2.3/2.3 GHz
Socket 1: min/max 2.3/2.3 GHz

################################################################################
# Prefetchers
################################################################################
Feature               CPU 0	CPU 28	CPU 1	CPU 29	CPU 2	CPU 30	CPU 3	CPU 31	CPU 4	CPU 32	CPU 5	CPU 33	CPU 6	CPU 34	CPU 7	CPU 35	CPU 8	CPU 36	CPU 9	CPU 37	CPU 10	CPU 38	CPU 11	CPU 39	CPU 12	CPU 40	CPU 13	CPU 41	CPU 14	CPU 42	CPU 15	CPU 43	CPU 16	CPU 44	CPU 17	CPU 45	CPU 18	CPU 46	CPU 19	CPU 47	CPU 20	CPU 48	CPU 21	CPU 49	CPU 22	CPU 50	CPU 23	CPU 51	CPU 24	CPU 52	CPU 25	CPU 53	CPU 26	CPU 54	CPU 27	CPU 55
HW_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
CL_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
DCU_PREFETCHER        on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
IP_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
FAST_STRINGS          on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
THERMAL_CONTROL       on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
PERF_MON              on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
FERR_MULTIPLEX        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off
BRANCH_TRACE_STORAGE  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
XTPR_MESSAGE          off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off
PEBS                  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
SPEEDSTEP             on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
MONITOR               on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
SPEEDSTEP_LOCK        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off
CPUID_MAX_VAL         off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off
XD_BIT                on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on
DYN_ACCEL             off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off
TURBO_MODE            off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off
TM2                   off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off

################################################################################
# Load
################################################################################
0.57 0.83 0.93 1/633 2519

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
MemTotal:       65851192 kB
MemFree:        64136864 kB
MemAvailable:   64517192 kB
Buffers:          121468 kB
Cached:           677896 kB
SwapCached:           16 kB
Active:           573452 kB
Inactive:         266636 kB
Active(anon):      38128 kB
Inactive(anon):    10624 kB
Active(file):     535324 kB
Inactive(file):   256012 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      31998972 kB
SwapFree:       31992944 kB
Dirty:               756 kB
Writeback:             4 kB
AnonPages:         40708 kB
Mapped:            59816 kB
Shmem:              8028 kB
Slab:             535800 kB
SReclaimable:     257708 kB
SUnreclaim:       278092 kB
KernelStack:       10992 kB
PageTables:         3036 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    64924568 kB
Committed_AS:     216412 kB
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
DirectMap4k:      531584 kB
DirectMap2M:    21379072 kB
DirectMap1G:    47185920 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: [always] madvise never
Use zero page: 1

################################################################################
# Hardware power limits
################################################################################
RAPL domain package-1
- Limit0 long_term MaxPower 120000000uW Limit 120000000uW TimeWindow 999424us
- Limit1 short_term MaxPower 240000000uW Limit 144000000uW TimeWindow 7808us
RAPL domain dram
- Limit0 long_term MaxPower 21500000uW Limit 0uW TimeWindow 976us
RAPL domain package-0
- Limit0 long_term MaxPower 120000000uW Limit 120000000uW TimeWindow 999424us
- Limit1 short_term MaxPower 240000000uW Limit 144000000uW TimeWindow 7808us
RAPL domain dram
- Limit0 long_term MaxPower 21500000uW Limit 0uW TimeWindow 976us

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

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 1.1
	Release Date: 04/09/2015
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 16 MB
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
		8042 keyboard services are supported (int 9h)
	(Line containing Serial number has been censored)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 5.6

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Supermicro
	Product Name: Super Server
	Version: 0123456789
	(Line containing Serial number has been censored)
	(Line containing UUID has been censored)
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Supermicro
	Product Name: X10DRL-i
	Version: 1.01
	(Line containing Serial number has been censored)
	Asset Tag: To be filled by O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To be filled by O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 25 bytes
Chassis Information
	Manufacturer: Supermicro
	Type: Main Server Chassis
	Lock: Not Present
	Version: 0123456789
	(Line containing Serial number has been censored)
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 1
		<OUT OF SPEC> (0)
	SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0005, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0006, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: TV Out
	External Connector Type: Mini Centronics Type-14
	Port Type: Other

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2A
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	(Line containing Serial number has been censored)

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2B
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9A1 - TPM HDR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9C1 - PCIE DOCKING CONN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2B3 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6C2 - EXT HDMI
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3C1 - GMCH FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1D1 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E2 - MDC INTPSR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E4 - MDC INTPSR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E3 - LPC HOT DOCKING
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E1 - SCAN MATRIX
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G1 - LPC SIDE BAND
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8F1 - UNIFIED
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6F1 - LVDS
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2F1 - LAI FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2G1 - GFX VID
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1G6 - AC JACK
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 9, 17 bytes
System Slot Information
	Designation: PCH SLOT1 PCI-E 2.0 X4 (IN X8)
	Type: x4 PCI Express 2 x8
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:ff:00.0

Handle 0x001D, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 SLOT2 PCI-E 3.0 X8
	Type: x8 PCI Express 3 x8
	Current Usage: Available
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:01:00.0

Handle 0x001E, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 SLOT3 PCI-E 3.0 X8
	Type: x8 PCI Express 3 x8
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:02:00.0

Handle 0x001F, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU2 SLOT4 PCI-E 3.0 X4 (IN X8)
	Type: x4 PCI Express 3 x8
	Current Usage: Available
	Length: Short
	ID: 4
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0001:ff:00.0

Handle 0x0020, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 SLOT5 PCI-E 3.0 X16
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Short
	ID: 5
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:04:00.0

Handle 0x0021, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 SLOT6 PCI-E 3.0 X8
	Type: x8 PCI Express 3 x8
	Current Usage: Available
	Length: Short
	ID: 6
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:03:00.0

Handle 0x0023, DMI type 12, 5 bytes
System Configuration Options
	Option 1: To Be Filled By O.E.M.

Handle 0x0024, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0054, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: ASPEED Video AST2400
	Type: Video
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:06:00.0

Handle 0x0055, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Intel Ethernet i210 #1
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:07:00.0

Handle 0x0056, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Intel Ethernet i210 #2
	Type: Ethernet
	Status: Enabled
	Type Instance: 2
	Bus Address: 0000:08:00.0

Handle 0x0058, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 128 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0059, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0058
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMA1
	Bank Locator: P0_Node0_Channel0_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMA1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x005A, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0058
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMB1
	Bank Locator: P0_Node0_Channel1_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMB1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x005B, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 128 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x005C, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x005B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMC1
	Bank Locator: P0_Node0_Channel2_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMC1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x005D, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x005B
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DIMMD1
	Bank Locator: P0_Node0_Channel3_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P1-DIMMD1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x005E, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 128 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x005F, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x005E
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMME1
	Bank Locator: P1_Node1_Channel0_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMME1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x0060, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x005E
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMF1
	Bank Locator: P1_Node1_Channel1_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMF1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x0061, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 128 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0062, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0061
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMG1
	Bank Locator: P1_Node1_Channel2_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMG1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x0063, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0061
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DIMMH1
	Bank Locator: P1_Node1_Channel3_Dimm0
	Type: Other
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: Samsung
	(Line containing Serial number has been censored)
	Asset Tag: P2-DIMMH1_AssetTag (date:14/33)
	Part Number: M393A1G40DB0-CPB
	Rank: 1
	Configured Clock Speed: 2133 MT/s

Handle 0x0070, DMI type 15, 73 bytes
System Event Log
	Area Length: 65535 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: Memory-mapped physical 32-bit address
	Access Address: 0xFF540000
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

Handle 0x0071, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L1
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 896 kB
	Maximum Size: 896 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Other
	Associativity: 8-way Set-associative

Handle 0x0072, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L2
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 3584 kB
	Maximum Size: 3584 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0073, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L3
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 17920 kB
	Maximum Size: 17920 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 20-way Set-associative

Handle 0x0074, DMI type 4, 42 bytes
Processor Information
	Socket Designation: CPU1
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: F2 06 03 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 63, Stepping 2
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
	Version: Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz
	Voltage: 1.8 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2300 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA2011-3
	L1 Cache Handle: 0x0071
	L2 Cache Handle: 0x0072
	L3 Cache Handle: 0x0073
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 14
	Core Enabled: 14
	Thread Count: 28
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0075, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L1
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 896 kB
	Maximum Size: 896 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Other
	Associativity: 8-way Set-associative

Handle 0x0076, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L2
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 3584 kB
	Maximum Size: 3584 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0077, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L3
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 17920 kB
	Maximum Size: 17920 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 20-way Set-associative

Handle 0x0078, DMI type 4, 42 bytes
Processor Information
	Socket Designation: CPU2
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: F2 06 03 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 63, Stepping 2
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
	Version: Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz
	Voltage: 1.8 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2300 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA2011-3
	L1 Cache Handle: 0x0075
	L2 Cache Handle: 0x0076
	L3 Cache Handle: 0x0077
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 14
	Core Enabled: 14
	Thread Count: 28
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0079, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Long
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1


################################################################################
# environment variables
################################################################################
PBS_ENVIRONMENT=PBS_BATCH
LS_COLORS=
LD_LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:/mnt/opt/likwid-4.3.4/lib
PBS_O_LANG=en_US
MKL_INC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
INCLUDE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
LESSCLOSE=/bin/lesspipe %s %s
MKL_SHLIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm
LESS=-R
LIKWID_LIBDIR=/mnt/opt/likwid-4.3.4/lib
I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=off
IPPROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp
OLDPWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r1_point-symmetric_star_constant/HaswellEP_E5-2695v3_CoD_20190417_015300
PBS_O_HOME=/home/hpc/iwia/iwia84
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
RRZECLUSTER=TESTCLUSTER
EDITOR=nano
PBS_JOBID=3088.catstor
ENVIRONMENT=BATCH
PATH_modshare=/usr/bin/vendor_perl:999999999:/home/julian/.local/.bin:999999999:/opt/android-sdk/tools:999999999:/usr/bin:1:/mnt/opt/likwid-4.3.4/sbin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/local/bin:999999999:/opt/android-sdk/platform-tools:999999999:/usr/bin/core_perl:999999999:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/mnt/opt/likwid-4.3.4/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/home/julian/.bin:999999999:/bin:1:/apps/python/3.6-anaconda/bin:1:/opt/intel/bin:999999999
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
LOADEDMODULES_modshare=intel64/19.0up02:1:intelmpi/2019up02-intel:1:python/3.6-anaconda:1:mkl/2019up02:1:likwid/4.3.4:1:pbspro/default:2
PBS_JOBNAME=HWL_stempel_bench
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NCPUS=56
FPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
INTEL_F_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
CPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
WOODYHOME=/home/woody/iwia/iwia84
PBS_O_PATH=/mnt/opt/pbspro/default/bin:/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
LIKWID_FORCE=1
FI_PROVIDER_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib/prov
INTEL_PYTHONHOME=/apps/intel/ComposerXE2019/debugger_2019/python/intel64/
MKL_INCDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
LD_LIBRARY_PATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/release:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:1:/mnt/opt/likwid-4.3.4/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin:1:/apps/intel/ComposerXE2019/debugger_2019/libipt/intel64/lib:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:1
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
PBS_NODEFILE=/var/spool/pbspro/aux/3088.catstor
GROUP=iwia
PBS_TASKNUM=1
LIKWID_DEFINES=-DLIKWID_PERFMON
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r1_isotropic_star_variable/HaswellEP_E5-2695v3_CoD_20190417_052435
HOME=/home/hpc/iwia/iwia84
LIKWID_LIB=-L/mnt/opt/likwid-4.3.4/lib
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_MOMPORT=15003
LIKWID_INCDIR=/mnt/opt/likwid-4.3.4/include
_LMFILES__modshare=/apps/modules/modulefiles/tools/python/3.6-anaconda:1:/apps/modules/modulefiles/libraries/mkl/2019up02:2:/opt/modules/modulefiles/testcluster/likwid/4.3.4:1:/opt/modules/modulefiles/testcluster/pbspro/default:2:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:1
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
PBS_JOBCOOKIE=1DC637CC6CEBF0D00C195FEB396BCA3A
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
PBS_O_SHELL=/bin/bash
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LESS_TERMCAP_mb=[1;32m
LESS_TERMCAP_md=[1;34m
LESS_TERMCAP_me=[0m
TMPDIR=/scratch/pbs.3088.catstor
LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
LIKWID_INC=-I/mnt/opt/likwid-4.3.4/include
LOADEDMODULES=pbspro/default:likwid/4.3.4:intelmpi/2019up02-intel:mkl/2019up02:intel64/19.0up02:python/3.6-anaconda
DAALROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal
MPILIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib
PBS_CONF=/etc/pbspro.conf
INTEL_LICENSE_FILE=1713@license4
PBS_O_QUEUE=route
MKL_CDFT=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_cdft_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -openmp
SHELL=/bin/bash
MKL_BASE=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl
MANPATH_modshare=:1:/mnt/opt/pbspro/default/man:2:/apps/python/3.6-anaconda/share/man:1:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:1:/apps/intel/ComposerXE2019/man/common:2:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:2:/apps/intel/mpi/man:1:/mnt/opt/likwid-4.3.4/man:1
MKL_SLIB_THREADED=-Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -lpthread -lm -openmp
MKLPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
GDK_USE_XFT=1
TMOUT=3660
SHLVL=3
PBS_O_HOST=testfront1.rrze.uni-erlangen.de
INTEL_C_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
PBS_O_SYSTEM=Linux
MANPATH=/apps/python/3.6-anaconda/share/man:/apps/intel/ComposerXE2019/documentation_2019/en/debugger/gdb-ia/man/:/apps/intel/ComposerXE2019/man/common::/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/man:/apps/intel/mpi/man:/mnt/opt/likwid-4.3.4/man:/mnt/opt/pbspro/default/man
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
PATH=/apps/python/3.6-anaconda/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:/mnt/opt/likwid-4.3.4/sbin:/mnt/opt/likwid-4.3.4/bin:/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
TBBROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb
_LMFILES_=/opt/modules/modulefiles/testcluster/pbspro/default:/opt/modules/modulefiles/testcluster/likwid/4.3.4:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:/apps/modules/modulefiles/libraries/mkl/2019up02:/apps/modules/modulefiles/tools/python/3.6-anaconda
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
OMP_NUM_THREADS=1
PBS_O_MAIL=/var/mail/iwia84
_=/usr/bin/env
{%- endcapture -%}

{% include stencil_template.md %}
