---

title:  "Stencil SolarSplit_x BroadwellEP_E5-2697_CoD"

stencil_name : "SolarSplit_x"
dimension    : "3D"
radius       : "r1"
coefficients : "variable"
datatype     : "double_Complex"
machine      : "BroadwellEP_E5-2697_CoD"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp "
flop         : "7"
scaling      : [ "600" ]
blocking     : []
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double _Complex Exy[M][N][O];
double _Complex ExSrc[M][N][O];
double _Complex tExy[M][N][O];
double _Complex cExy[M][N][O];

double _Complex Hyx[M][N][O];
double _Complex Hyz[M][N][O];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < O - 1; ++i) {
      Exy[k][j][i] =
          Exy[k][j][i] * tExy[k][j][i] + ExSrc[k][j][i] +
          cExy[k][j][i] * (Hyx[k][j][i] - Hyx[k + 1][j][i] +
                           Hyz[k][j][i] - Hyz[k + 1][j][i]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm6, ymmword ptr [r12+r14*1+0x10]
add rsi, 0x4
vmovupd ymm3, ymmword ptr [r12+rbx*1+0x10]
vmovupd ymm0, ymmword ptr [r12+r13*1+0x10]
vmovupd ymm9, ymmword ptr [r12+r10*1+0x10]
vsubpd ymm7, ymm6, ymmword ptr [r12+r15*1+0x10]
vaddpd ymm8, ymm7, ymmword ptr [r12+r9*1+0x10]
vmovupd ymm7, ymmword ptr [r12+r14*1+0x30]
vsubpd ymm12, ymm8, ymmword ptr [r12+rdi*1+0x10]
vsubpd ymm8, ymm7, ymmword ptr [r12+r15*1+0x30]
vunpckhpd ymm1, ymm0, ymm0
vshufpd ymm2, ymm3, ymm3, 0x5
vmulpd ymm4, ymm1, ymm2
vmovupd ymm1, ymmword ptr [r12+r13*1+0x30]
vunpckhpd ymm10, ymm9, ymm9
vshufpd ymm11, ymm12, ymm12, 0x5
vmovddup ymm5, ymmword ptr [r12+r13*1+0x10]
vmulpd ymm13, ymm10, ymm11
vfmaddsub213pd ymm5, ymm3, ymm4
vmovupd ymm4, ymmword ptr [r12+rbx*1+0x30]
vmovupd ymm10, ymmword ptr [r12+r10*1+0x30]
vaddpd ymm9, ymm8, ymmword ptr [r12+r9*1+0x30]
vaddpd ymm14, ymm5, ymmword ptr [r12+rcx*1+0x10]
vmovddup ymm15, ymmword ptr [r12+r10*1+0x10]
vfmaddsub213pd ymm15, ymm12, ymm13
vsubpd ymm13, ymm9, ymmword ptr [r12+rdi*1+0x30]
vaddpd ymm0, ymm14, ymm15
vunpckhpd ymm2, ymm1, ymm1
vshufpd ymm3, ymm4, ymm4, 0x5
vmulpd ymm5, ymm2, ymm3
vmovupd ymmword ptr [r12+rbx*1+0x10], ymm0
vunpckhpd ymm11, ymm10, ymm10
vshufpd ymm12, ymm13, ymm13, 0x5
vmulpd ymm14, ymm11, ymm12
vmovddup ymm6, ymmword ptr [r12+r13*1+0x30]
vfmaddsub213pd ymm6, ymm4, ymm5
vmovddup ymm0, ymmword ptr [r12+r10*1+0x30]
vfmaddsub213pd ymm0, ymm13, ymm14
vaddpd ymm15, ymm6, ymmword ptr [r12+rcx*1+0x30]
vaddpd ymm1, ymm15, ymm0
vmovupd ymmword ptr [r12+rbx*1+0x30], ymm1
add r12, 0x40
cmp rsi, r11
jb 0xffffffffffffff04
{%- endcapture -%}

{%- capture layer_condition -%}
### Layer conditions for L1 cache with 32 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```96*M*N*O < 32768```|0|9|
|```128*N*O <= 32768```|6|3|
|Else|8|1|

### Layer conditions for L2 cache with 256 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```96*M*N*O < 262144```|0|9|
|```128*N*O <= 262144```|6|3|
|Else|8|1|

### Layer conditions for L3 cache with 23040 KB:

|condition|misses|hits|
|:---:|---:|---:|
|```96*M*N*O < 23592960```|0|9|
|```128*N*O <= 23592960```|6|3|
|Else|8|1|


{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 13.21 Cycles       Throughput Bottleneck: FrontEnd
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles |  8.0     0.0  | 10.0  | 11.0    11.0  | 11.0     9.0  |  2.0  |  8.0  |  2.0  |  0.0  |
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
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm6, ymmword ptr [r12+r14*1+0x10]
|   1      |             |      |             |             |      |      | 1.0  |      | add rsi, 0x4
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm3, ymmword ptr [r12+rbx*1+0x10]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm0, ymmword ptr [r12+r13*1+0x10]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm9, ymmword ptr [r12+r10*1+0x10]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vsubpd ymm7, ymm6, ymmword ptr [r12+r15*1+0x10]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm8, ymm7, ymmword ptr [r12+r9*1+0x10]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm7, ymmword ptr [r12+r14*1+0x30]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vsubpd ymm12, ymm8, ymmword ptr [r12+rdi*1+0x10]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vsubpd ymm8, ymm7, ymmword ptr [r12+r15*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd ymm1, ymm0, ymm0
|   1      |             |      |             |             |      | 1.0  |      |      | vshufpd ymm2, ymm3, ymm3, 0x5
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm4, ymm1, ymm2
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm1, ymmword ptr [r12+r13*1+0x30]
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd ymm10, ymm9, ymm9
|   1      |             |      |             |             |      | 1.0  |      |      | vshufpd ymm11, ymm12, ymm12, 0x5
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup ymm5, ymmword ptr [r12+r13*1+0x10]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm13, ymm10, ymm11
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd ymm5, ymm3, ymm4
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm4, ymmword ptr [r12+rbx*1+0x30]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm10, ymmword ptr [r12+r10*1+0x30]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm9, ymm8, ymmword ptr [r12+r9*1+0x30]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm14, ymm5, ymmword ptr [r12+rcx*1+0x10]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup ymm15, ymmword ptr [r12+r10*1+0x10]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd ymm15, ymm12, ymm13
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vsubpd ymm13, ymm9, ymmword ptr [r12+rdi*1+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm0, ymm14, ymm15
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd ymm2, ymm1, ymm1
|   1      |             |      |             |             |      | 1.0  |      |      | vshufpd ymm3, ymm4, ymm4, 0x5
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm5, ymm2, ymm3
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r12+rbx*1+0x10], ymm0
|   1      |             |      |             |             |      | 1.0  |      |      | vunpckhpd ymm11, ymm10, ymm10
|   1      |             |      |             |             |      | 1.0  |      |      | vshufpd ymm12, ymm13, ymm13, 0x5
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm14, ymm11, ymm12
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovddup ymm6, ymmword ptr [r12+r13*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd ymm6, ymm4, ymm5
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovddup ymm0, ymmword ptr [r12+r10*1+0x30]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmaddsub213pd ymm0, ymm13, ymm14
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm15, ymm6, ymmword ptr [r12+rcx*1+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm1, ymm15, ymm0
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [r12+rbx*1+0x30], ymm1
|   1      |             |      |             |             |      |      | 1.0  |      | add r12, 0x40
|   1*     |             |      |             |             |      |      |      |      | cmp rsi, r11
|   0*F    |             |      |             |             |      |      |      |      | jb 0xffffffffffffff04
Total Num Of Uops: 53


Detected pointer increment: 64
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
 18:21:12 up 62 days,  8:35,  0 users,  load average: 4.45, 3.38, 2.04
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
Free memory:		31107.3 MB
Total memory:		32062.8 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 9 45 10 46 11 47 12 48 13 49 14 50 15 51 16 52 17 53 )
Distances:		21 10 31 31
Free memory:		31564.6 MB
Total memory:		32231.5 MB
--------------------------------------------------------------------------------
Domain:			2
Processors:		( 18 54 19 55 20 56 21 57 22 58 23 59 24 60 25 61 26 62 )
Distances:		31 31 10 21
Free memory:		32092.5 MB
Total memory:		32252.6 MB
--------------------------------------------------------------------------------
Domain:			3
Processors:		( 27 63 28 64 29 65 30 66 31 67 32 68 33 69 34 70 35 71 )
Distances:		31 31 21 10
Free memory:		32022.9 MB
Total memory:		32251.1 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 36 37 38 39 40 41 42 43 44
node 0 size: 32062 MB
node 0 free: 31107 MB
node 1 cpus: 9 10 11 12 13 14 15 16 17 45 46 47 48 49 50 51 52 53
node 1 size: 32231 MB
node 1 free: 31574 MB
node 2 cpus: 18 19 20 21 22 23 24 25 26 54 55 56 57 58 59 60 61 62
node 2 size: 32252 MB
node 2 free: 32092 MB
node 3 cpus: 27 28 29 30 31 32 33 34 35 63 64 65 66 67 68 69 70 71
node 3 size: 32251 MB
node 3 free: 32022 MB
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
CPU 0: governor  performance min/cur/max 2.3/1.980/2.3 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.3/2.221/2.3 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.3/2.210/2.3 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.3/2.208/2.3 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.3/2.176/2.3 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.3/1.895/2.3 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.3/1.329/2.3 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.3/2.292/2.3 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.3/2.296/2.3 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.3/2.278/2.3 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.3/2.290/2.3 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.3/2.292/2.3 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 32: governor  performance min/cur/max 2.3/2.291/2.3 GHz Turbo 0
CPU 33: governor  performance min/cur/max 2.3/2.260/2.3 GHz Turbo 0
CPU 34: governor  performance min/cur/max 2.3/2.293/2.3 GHz Turbo 0
CPU 35: governor  performance min/cur/max 2.3/2.298/2.3 GHz Turbo 0
CPU 36: governor  performance min/cur/max 2.3/2.147/2.3 GHz Turbo 0
CPU 37: governor  performance min/cur/max 2.3/1.246/2.3 GHz Turbo 0
CPU 38: governor  performance min/cur/max 2.3/2.249/2.3 GHz Turbo 0
CPU 39: governor  performance min/cur/max 2.3/1.469/2.3 GHz Turbo 0
CPU 40: governor  performance min/cur/max 2.3/1.763/2.3 GHz Turbo 0
CPU 41: governor  performance min/cur/max 2.3/1.864/2.3 GHz Turbo 0
CPU 42: governor  performance min/cur/max 2.3/2.231/2.3 GHz Turbo 0
CPU 43: governor  performance min/cur/max 2.3/1.434/2.3 GHz Turbo 0
CPU 44: governor  performance min/cur/max 2.3/2.242/2.3 GHz Turbo 0
CPU 45: governor  performance min/cur/max 2.3/2.038/2.3 GHz Turbo 0
CPU 46: governor  performance min/cur/max 2.3/1.858/2.3 GHz Turbo 0
CPU 47: governor  performance min/cur/max 2.3/2.247/2.3 GHz Turbo 0
CPU 48: governor  performance min/cur/max 2.3/2.218/2.3 GHz Turbo 0
CPU 49: governor  performance min/cur/max 2.3/2.277/2.3 GHz Turbo 0
CPU 50: governor  performance min/cur/max 2.3/1.234/2.3 GHz Turbo 0
CPU 51: governor  performance min/cur/max 2.3/1.504/2.3 GHz Turbo 0
CPU 52: governor  performance min/cur/max 2.3/2.187/2.3 GHz Turbo 0
CPU 53: governor  performance min/cur/max 2.3/2.123/2.3 GHz Turbo 0
CPU 54: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 55: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 56: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 57: governor  performance min/cur/max 2.3/2.300/2.3 GHz Turbo 0
CPU 58: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 59: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 60: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 61: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 62: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 63: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 64: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 65: governor  performance min/cur/max 2.3/2.297/2.3 GHz Turbo 0
CPU 66: governor  performance min/cur/max 2.3/2.244/2.3 GHz Turbo 0
CPU 67: governor  performance min/cur/max 2.3/2.294/2.3 GHz Turbo 0
CPU 68: governor  performance min/cur/max 2.3/2.280/2.3 GHz Turbo 0
CPU 69: governor  performance min/cur/max 2.3/2.290/2.3 GHz Turbo 0
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
3.77 3.27 2.01 1/768 72615

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
MemFree:        129836584 kB
MemAvailable:   129724968 kB
Buffers:           30464 kB
Cached:           539132 kB
SwapCached:            0 kB
Active:           448432 kB
Inactive:         168600 kB
Active(anon):      47732 kB
Inactive(anon):     1628 kB
Active(file):     400700 kB
Inactive(file):   166972 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      67043324 kB
SwapFree:       67043324 kB
Dirty:               404 kB
Writeback:             0 kB
AnonPages:         47128 kB
Mapped:            63712 kB
Shmem:              1916 kB
Slab:             627484 kB
SReclaimable:     246332 kB
SUnreclaim:       381152 kB
KernelStack:       13456 kB
PageTables:         3544 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    132987884 kB
Committed_AS:     276944 kB
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
DirectMap4k:      764672 kB
DirectMap2M:    31612928 kB
DirectMap1G:    103809024 kB

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
OLDPWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/5D_r1_isotropic_box_constant/solar_split_y/BroadwellEP_E5-2697_CoD_20190627_170010
PBS_O_HOME=/home/hpc/iwia/iwia84
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
RRZECLUSTER=TESTCLUSTER
EDITOR=nano
PBS_JOBID=4398.catstor
ENVIRONMENT=BATCH
PATH_modshare=/usr/bin/vendor_perl:999999999:/home/julian/.local/.bin:999999999:/opt/android-sdk/tools:999999999:/usr/bin:1:/mnt/opt/likwid-4.3.4/sbin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/local/bin:999999999:/opt/android-sdk/platform-tools:999999999:/usr/bin/core_perl:999999999:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/mnt/opt/likwid-4.3.4/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/home/julian/.bin:999999999:/bin:1:/apps/python/3.6-anaconda/bin:1:/opt/intel/bin:999999999
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
LOADEDMODULES_modshare=intel64/19.0up02:1:intelmpi/2019up02-intel:1:python/3.6-anaconda:1:mkl/2019up02:1:likwid/4.3.4:1:pbspro/default:2
PBS_JOBNAME=BDW_stempel_bench
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NCPUS=72
FPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
INTEL_F_HOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler
CPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include:1
WOODYHOME=/home/woody/iwia/iwia84
PBS_O_PATH=/mnt/opt/pbspro/default/bin:/apps/python/3.6-anaconda/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:/mnt/opt/likwid-4.3.4/sbin:/mnt/opt/likwid-4.3.4/bin:/bin:/usr/bin:/usr/local/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/intel/bin:/home/julian/.bin:/home/julian/.local/.bin
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
PBS_NODEFILE=/var/spool/pbspro/aux/4398.catstor
GROUP=iwia
PBS_TASKNUM=1
I_MPI_OFA_ADAPTER_NAME=mlx4_0
LIKWID_DEFINES=-DLIKWID_PERFMON
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/5D_r1_isotropic_box_constant/solar_split_z/BroadwellEP_E5-2697_CoD_20190627_182112
HOME=/home/hpc/iwia/iwia84
LIKWID_LIB=-L/mnt/opt/likwid-4.3.4/lib
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_MOMPORT=15003
LIKWID_INCDIR=/mnt/opt/likwid-4.3.4/include
_LMFILES__modshare=/apps/modules/modulefiles/tools/python/3.6-anaconda:1:/apps/modules/modulefiles/libraries/mkl/2019up02:2:/opt/modules/modulefiles/testcluster/likwid/4.3.4:1:/opt/modules/modulefiles/testcluster/pbspro/default:2:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:1
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
PBS_JOBCOOKIE=51A95A5A5D3FFB120317782C52E32F82
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
PBS_O_SHELL=/bin/bash
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LESS_TERMCAP_mb=[1;32m
LESS_TERMCAP_md=[1;34m
LESS_TERMCAP_me=[0m
TMPDIR=/scratch/pbs.4398.catstor
LIBRARY_PATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/lib/intel64:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64/gcc4.7:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/intel64_lin:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/lib/intel64_lin/gcc4.4:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
LIKWID_INC=-I/mnt/opt/likwid-4.3.4/include
LOADEDMODULES=pbspro/default:likwid/4.3.4:intelmpi/2019up02-intel:mkl/2019up02:intel64/19.0up02:python/3.6-anaconda
DAALROOT=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal
MPILIB=-L/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib
PBS_CONF=/etc/pbspro.conf
INTEL_LICENSE_FILE=1713@license4
I_MPI_FABRICS=shm:ofa
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
OMP_NUM_THREADS=72
PBS_O_MAIL=/var/mail/iwia84
_=/usr/bin/env
{%- endcapture -%}

{% include stencil_template.md %}
