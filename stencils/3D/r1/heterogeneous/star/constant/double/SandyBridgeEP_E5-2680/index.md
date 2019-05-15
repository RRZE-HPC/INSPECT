---

title:  "Stencil 3D r1 star constant heterogeneous double SandyBridgeEP_E5-2680"

dimension    : "3D"
radius       : "r1"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SandyBridgeEP_E5-2680"
flavor       : "EDIT_ME"
compile_flags: "icc -O3 -xAVX -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.4/include -Llikwid-4.3.4/lib -I/headers/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "13"
scaling      : [ "1210" ]
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

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
+ c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
+ c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
;
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmulpd ymm14, ymm9, ymmword ptr [r10+r13*8+0x8]
vmulpd ymm15, ymm8, ymmword ptr [r10+r13*8]
vaddpd ymm14, ymm14, ymm15
vmulpd ymm15, ymm7, ymmword ptr [r10+r13*8+0x10]
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r11+r13*8+0x8]
vinsertf128 ymm14, ymm14, xmmword ptr [r11+r13*8+0x18], 0x1
vmulpd ymm14, ymm11, ymm14
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r8+r13*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [r8+r13*8+0x18], 0x1
vmulpd ymm15, ymm1, ymm15
vaddpd ymm15, ymm14, ymm15
vmovupd xmm14, xmmword ptr [r9+r13*8+0x8]
vinsertf128 ymm14, ymm14, xmmword ptr [r9+r13*8+0x18], 0x1
vmulpd ymm14, ymm2, ymm14
vaddpd ymm14, ymm15, ymm14
vmovupd xmm15, xmmword ptr [r15+r13*8+0x8]
vinsertf128 ymm15, ymm15, xmmword ptr [r15+r13*8+0x18], 0x1
vmulpd ymm15, ymm0, ymm15
vaddpd ymm14, ymm14, ymm15
vmovupd ymmword ptr [r14+r13*8+0x8], ymm14
add r13, 0x4
cmp r13, rax
jb 0xffffffffffffff70
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3;P ~ 680
L2: P <= 5462;P ~ 5460
L3: P <= 1310722/3;P ~ 436900
L1: 16*N*P + 16*P*(N - 1) <= 32768;N*P ~ 30²
L2: 16*N*P + 16*P*(N - 1) <= 262144;N*P ~ 90²
L3: 16*N*P + 16*P*(N - 1) <= 20971520;N*P ~ 800²
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 8.00 Cycles       Throughput Bottleneck: FrontEnd

Port Binding In Cycles Per Iteration:
-------------------------------------------------------------------------
|  Port  |  0   -  DV  |  1   |  2   -  D   |  3   -  D   |  4   |  5   |
-------------------------------------------------------------------------
| Cycles | 7.0    0.0  | 6.0  | 6.0    7.0  | 6.0    7.0  | 2.0  | 6.0  |
-------------------------------------------------------------------------

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
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmulpd ymm14, ymm9, ymmword ptr [r10+r13*8+0x8]
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmulpd ymm15, ymm8, ymmword ptr [r10+r13*8]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm14, ymm15
|   2    | 1.0       |     | 0.5   1.0 | 0.5   1.0 |     |     |    | vmulpd ymm15, ymm7, ymmword ptr [r10+r13*8+0x10]
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm14, xmmword ptr [r11+r13*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm14, ymm14, xmmword ptr [r11+r13*8+0x18], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm14, ymm11, ymm14
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm15, ymm14
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r8+r13*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r8+r13*8+0x18], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm15, ymm1, ymm15
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm15, ymm14, ymm15
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm14, xmmword ptr [r9+r13*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm14, ymm14, xmmword ptr [r9+r13*8+0x18], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm14, ymm2, ymm14
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm15, ymm14
|   1    |           |     | 0.5   0.5 | 0.5   0.5 |     |     |    | vmovupd xmm15, xmmword ptr [r15+r13*8+0x8]
|   2    |           |     | 0.5   0.5 | 0.5   0.5 |     | 1.0 |    | vinsertf128 ymm15, ymm15, xmmword ptr [r15+r13*8+0x18], 0x1
|   1    | 1.0       |     |           |           |     |     |    | vmulpd ymm15, ymm0, ymm15
|   1    |           | 1.0 |           |           |     |     |    | vaddpd ymm14, ymm14, ymm15
|   2    |           |     | 0.5       | 0.5       | 2.0 |     |    | vmovupd ymmword ptr [r14+r13*8+0x8], ymm14
|   1    |           |     |           |           |     | 1.0 |    | add r13, 0x4
|   1    |           |     |           |           |     | 1.0 |    | cmp r13, rax
|   0F   |           |     |           |           |     |     |    | jb 0xffffffffffffff70
Total Num Of Uops: 32


Detected pointer increment: 32
{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Hostname
################################################################################
phinally.rrze.uni-erlangen.de

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
Linux phinally 4.15.0-42-generic #45-Ubuntu SMP Thu Nov 15 19:32:57 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Logged in users
################################################################################
 22:40:46 up 153 days,  7:04,  0 users,  load average: 1.31, 1.06, 1.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CPUset
################################################################################
Domain N:
	0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23,8,24,9,25,10,26,11,27,12,28,13,29,14,30,15,31

Domain S0:
	0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23

Domain S1:
	8,24,9,25,10,26,11,27,12,28,13,29,14,30,15,31

Domain C0:
	0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23

Domain C1:
	8,24,9,25,10,26,11,27,12,28,13,29,14,30,15,31

Domain M0:
	0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23

Domain M1:
	8,24,9,25,10,26,11,27,12,28,13,29,14,30,15,31


################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-31
Allowed Memory controllers: 0-1

################################################################################
# Topology
################################################################################
--------------------------------------------------------------------------------
CPU name:	Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
CPU type:	Intel Xeon SandyBridge EN/EP processor
CPU stepping:	7
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:		2
Cores per socket:	8
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
8		0		8		1		*
9		0		9		1		*
10		0		10		1		*
11		0		11		1		*
12		0		12		1		*
13		0		13		1		*
14		0		14		1		*
15		0		15		1		*
16		1		0		0		*
17		1		1		0		*
18		1		2		0		*
19		1		3		0		*
20		1		4		0		*
21		1		5		0		*
22		1		6		0		*
23		1		7		0		*
24		1		8		1		*
25		1		9		1		*
26		1		10		1		*
27		1		11		1		*
28		1		12		1		*
29		1		13		1		*
30		1		14		1		*
31		1		15		1		*
--------------------------------------------------------------------------------
Socket 0:		( 0 16 1 17 2 18 3 19 4 20 5 21 6 22 7 23 )
Socket 1:		( 8 24 9 25 10 26 11 27 12 28 13 29 14 30 15 31 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:			1
Size:			32 kB
Cache groups:		( 0 16 ) ( 1 17 ) ( 2 18 ) ( 3 19 ) ( 4 20 ) ( 5 21 ) ( 6 22 ) ( 7 23 ) ( 8 24 ) ( 9 25 ) ( 10 26 ) ( 11 27 ) ( 12 28 ) ( 13 29 ) ( 14 30 ) ( 15 31 )
--------------------------------------------------------------------------------
Level:			2
Size:			256 kB
Cache groups:		( 0 16 ) ( 1 17 ) ( 2 18 ) ( 3 19 ) ( 4 20 ) ( 5 21 ) ( 6 22 ) ( 7 23 ) ( 8 24 ) ( 9 25 ) ( 10 26 ) ( 11 27 ) ( 12 28 ) ( 13 29 ) ( 14 30 ) ( 15 31 )
--------------------------------------------------------------------------------
Level:			3
Size:			20 MB
Cache groups:		( 0 16 1 17 2 18 3 19 4 20 5 21 6 22 7 23 ) ( 8 24 9 25 10 26 11 27 12 28 13 29 14 30 15 31 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:		2
--------------------------------------------------------------------------------
Domain:			0
Processors:		( 0 16 1 17 2 18 3 19 4 20 5 21 6 22 7 23 )
Distances:		10 21
Free memory:		31431 MB
Total memory:		32156 MB
--------------------------------------------------------------------------------
Domain:			1
Processors:		( 8 24 9 25 10 26 11 27 12 28 13 29 14 30 15 31 )
Distances:		21 10
Free memory:		31706.3 MB
Total memory:		32231.4 MB
--------------------------------------------------------------------------------

################################################################################
# NUMA Topology
################################################################################
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 16 17 18 19 20 21 22 23
node 0 size: 32156 MB
node 0 free: 31441 MB
node 1 cpus: 8 9 10 11 12 13 14 15 24 25 26 27 28 29 30 31
node 1 size: 32231 MB
node 1 free: 31706 MB
node distances:
node   0   1 
  0:  10  21 
  1:  21  10 

################################################################################
# Frequencies
################################################################################
Current CPU frequencies:
CPU 0: governor  performance min/cur/max 2.481/1.910/2.611 GHz Turbo 0
CPU 1: governor  performance min/cur/max 2.481/1.953/2.611 GHz Turbo 0
CPU 2: governor  performance min/cur/max 2.481/1.735/2.611 GHz Turbo 0
CPU 3: governor  performance min/cur/max 2.481/1.870/2.611 GHz Turbo 0
CPU 4: governor  performance min/cur/max 2.481/1.681/2.611 GHz Turbo 0
CPU 5: governor  performance min/cur/max 2.481/1.849/2.611 GHz Turbo 0
CPU 6: governor  performance min/cur/max 2.481/2.681/2.611 GHz Turbo 0
CPU 7: governor  performance min/cur/max 2.481/1.747/2.611 GHz Turbo 0
CPU 8: governor  performance min/cur/max 2.481/2.336/2.611 GHz Turbo 0
CPU 9: governor  performance min/cur/max 2.481/2.611/2.611 GHz Turbo 0
CPU 10: governor  performance min/cur/max 2.481/2.699/2.611 GHz Turbo 0
CPU 11: governor  performance min/cur/max 2.481/2.596/2.611 GHz Turbo 0
CPU 12: governor  performance min/cur/max 2.481/2.699/2.611 GHz Turbo 0
CPU 13: governor  performance min/cur/max 2.481/2.595/2.611 GHz Turbo 0
CPU 14: governor  performance min/cur/max 2.481/2.596/2.611 GHz Turbo 0
CPU 15: governor  performance min/cur/max 2.481/2.588/2.611 GHz Turbo 0
CPU 16: governor  performance min/cur/max 2.481/1.783/2.611 GHz Turbo 0
CPU 17: governor  performance min/cur/max 2.481/1.881/2.611 GHz Turbo 0
CPU 18: governor  performance min/cur/max 2.481/1.835/2.611 GHz Turbo 0
CPU 19: governor  performance min/cur/max 2.481/1.871/2.611 GHz Turbo 0
CPU 20: governor  performance min/cur/max 2.481/1.806/2.611 GHz Turbo 0
CPU 21: governor  performance min/cur/max 2.481/1.809/2.611 GHz Turbo 0
CPU 22: governor  performance min/cur/max 2.481/1.804/2.611 GHz Turbo 0
CPU 23: governor  performance min/cur/max 2.481/1.945/2.611 GHz Turbo 0
CPU 24: governor  performance min/cur/max 2.481/2.268/2.611 GHz Turbo 0
CPU 25: governor  performance min/cur/max 2.481/2.590/2.611 GHz Turbo 0
CPU 26: governor  performance min/cur/max 2.481/2.699/2.611 GHz Turbo 0
CPU 27: governor  performance min/cur/max 2.481/2.592/2.611 GHz Turbo 0
CPU 28: governor  performance min/cur/max 2.481/2.595/2.611 GHz Turbo 0
CPU 29: governor  performance min/cur/max 2.481/2.699/2.611 GHz Turbo 0
CPU 30: governor  performance min/cur/max 2.481/2.699/2.611 GHz Turbo 0
CPU 31: governor  performance min/cur/max 2.481/2.691/2.611 GHz Turbo 0

No support for Uncore frequencies

################################################################################
# Prefetchers
################################################################################
Feature               CPU 0	CPU 16	CPU 1	CPU 17	CPU 2	CPU 18	CPU 3	CPU 19	CPU 4	CPU 20	CPU 5	CPU 21	CPU 6	CPU 22	CPU 7	CPU 23	CPU 8	CPU 24	CPU 9	CPU 25	CPU 10	CPU 26	CPU 11	CPU 27	CPU 12	CPU 28	CPU 13	CPU 29	CPU 14	CPU 30	CPU 15	CPU 31	
HW_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
CL_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
DCU_PREFETCHER        on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
IP_PREFETCHER         on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
FAST_STRINGS          on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
THERMAL_CONTROL       on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
PERF_MON              on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
FERR_MULTIPLEX        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
BRANCH_TRACE_STORAGE  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
XTPR_MESSAGE          off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
PEBS                  on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
SPEEDSTEP             on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
MONITOR               on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
SPEEDSTEP_LOCK        off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
CPUID_MAX_VAL         off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
XD_BIT                on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	on	
DYN_ACCEL             off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
TURBO_MODE            off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	
TM2                   off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	off	

################################################################################
# Load
################################################################################
1.31 1.06 1.00 1/407 16282

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
MemTotal:       65932752 kB
MemFree:        64662628 kB
MemAvailable:   64804240 kB
Buffers:           27616 kB
Cached:           563968 kB
SwapCached:            0 kB
Active:           418756 kB
Inactive:         212648 kB
Active(anon):      40068 kB
Inactive(anon):     8884 kB
Active(file):     378688 kB
Inactive(file):   203764 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      31998972 kB
SwapFree:       31998972 kB
Dirty:               164 kB
Writeback:             0 kB
AnonPages:         38848 kB
Mapped:            48988 kB
Shmem:              9132 kB
Slab:             368128 kB
SReclaimable:     147240 kB
SUnreclaim:       220888 kB
KernelStack:        7168 kB
PageTables:         3224 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    64965348 kB
Committed_AS:     205964 kB
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
DirectMap4k:      368248 kB
DirectMap2M:     6938624 kB
DirectMap1G:    61865984 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: always [madvise] never
Use zero page: 1

################################################################################
# Hardware power limits
################################################################################
RAPL domain package-1
- Limit0 long_term MaxPower 130000000uW Limit 130000000uW TimeWindow 9994240us
- Limit1 short_term MaxPower 200000000uW Limit 156000000uW TimeWindow 7808us
RAPL domain dram
- Limit0 long_term MaxPower 35000000uW Limit 0uW TimeWindow 976us
RAPL domain core
- Limit0 long_term MaxPower NAuW Limit 0uW TimeWindow 976us
RAPL domain package-0
- Limit0 long_term MaxPower 130000000uW Limit 130000000uW TimeWindow 9994240us
- Limit1 short_term MaxPower 200000000uW Limit 156000000uW TimeWindow 7808us
RAPL domain core
- Limit0 long_term MaxPower NAuW Limit 0uW TimeWindow 976us
RAPL domain dram
- Limit0 long_term MaxPower 35000000uW Limit 0uW TimeWindow 976us

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
SMBIOS 2.7 present.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 2.0 
	Release Date: 01/17/2013
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 12288 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
	(Line containing Serial number has been censored)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 1.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Supermicro
	Product Name: X9DRG-HF
	Version: 0123456789
	(Line containing Serial number has been censored)
	(Line containing UUID has been censored)
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Supermicro
	Product Name: X9DRG-HF
	Version: 0123456789
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
	Type: Desktop
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
	Contained Elements: 0
	SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 4, 42 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: D7 06 02 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 45, Stepping 7
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
	Version: Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
	Voltage: 1.1 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2700 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA2011
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 8
	Core Enabled: 8
	Thread Count: 16
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Other
	Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 kB
	Maximum Size: 2048 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 20480 kB
	Maximum Size: 20480 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 20-way Set-associative

Handle 0x0008, DMI type 4, 42 bytes
Processor Information
	Socket Designation: CPU 2
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: D7 06 02 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 45, Stepping 7
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
	Version: Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
	Voltage: 1.1 V
	External Clock: 100 MHz
	Max Speed: 4000 MHz
	Current Speed: 2700 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA2011
	L1 Cache Handle: 0x0009
	L2 Cache Handle: 0x000A
	L3 Cache Handle: 0x000B
	(Line containing Serial number has been censored)
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 8
	Core Enabled: 8
	Thread Count: 16
	Characteristics:
		64-bit capable
		Multi-Core
		Hardware Thread
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x0009, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Other
	Associativity: 8-way Set-associative

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 kB
	Maximum Size: 2048 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 20480 kB
	Maximum Size: 20480 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 20-way Set-associative

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JCOM1
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	(Line containing Serial number has been censored)

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBRJ45
	Internal Connector Type: None
	External Reference Designator: USB01
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBKM
	Internal Connector Type: None
	External Reference Designator: USB23
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JLAN1
	Internal Connector Type: None
	External Reference Designator: LAN1/3
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JLAN2
	Internal Connector Type: None
	External Reference Designator: LAN2/4
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JVGA
	Internal Connector Type: None
	External Reference Designator: VGA
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSB4/5
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSB6/7
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFAN1
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFAN2
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFAN3
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFAN4
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFAN5
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFAN6
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFANA
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JFANB
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JTPM
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JCOM2
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSAS1
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSAS2
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0020, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSATA1
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0021, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSATA2
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0022, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSATA3
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0023, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSATA4
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0024, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSATA5
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0025, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JSATA6
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0026, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 Slot1
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:03:00.0

Handle 0x0027, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 Slot2
	Type: x4 PCI Express 3 x4
	Current Usage: In Use
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:02:00.1

Handle 0x0028, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU1 Slot3
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0000:83:00.0

Handle 0x0029, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU2 Slot4
	Type: x16 PCI Express 3 x16
	Current Usage: In Use
	Length: Long
	ID: 4
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0080:84:00.0

Handle 0x002A, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU2 Slot5
	Type: x16 PCI Express 3 x16
	Current Usage: Available
	Length: Long
	ID: 5
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0080:01:00.0

Handle 0x002B, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU2 Slot6
	Type: x8 PCI Express 3 x8
	Current Usage: Available
	Length: Short
	ID: 6
	Characteristics:
		3.3 V is provided
		PME signal is supported
	Bus Address: 0080:ff:00.0

Handle 0x002C, DMI type 10, 18 bytes
On Board Device 1 Information
	Type: Video
	Status: Enabled
	Description:  Onboard Matrox VGA
On Board Device 2 Information
	Type: SATA Controller
	Status: Enabled
	Description:  Onboard Intel SATA Controller
On Board Device 3 Information
	Type: SAS Controller
	Status: Enabled
	Description:  Onboard Intel SCU Controller
On Board Device 4 Information
	Type: Ethernet
	Status: Enabled
	Description:  Onboard Intel Ethernet 1
On Board Device 5 Information
	Type: Ethernet
	Status: Enabled
	Description:  Onboard Intel Ethernet 2
On Board Device 6 Information
	Type: Ethernet
	Status: Enabled
	Description:  Onboard Intel Ethernet 3
On Board Device 7 Information
	Type: Ethernet
	Status: Enabled
	Description:  Onboard Intel Ethernet 4

Handle 0x002E, DMI type 12, 5 bytes
System Configuration Options
	Option 1: To Be Filled By O.E.M.

Handle 0x002F, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 64 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0031, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x002F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DimmA1
	Bank Locator: P1-CH-A
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmA1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x0033, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x002F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DimmB1
	Bank Locator: P1-CH-B
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmB1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x0035, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x002F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DimmC1
	Bank Locator: P1-CH-C
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmC1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x0037, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x002F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P1-DimmD1
	Bank Locator: P1-CH-D
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmD1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x0039, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 64 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x003B, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0039
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DimmE1
	Bank Locator: P2-CH-E
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmE1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x003D, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0039
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DimmF1
	Bank Locator: P2-CH-F
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmF1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x003F, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0039
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DimmG1
	Bank Locator: P2-CH-G
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmG1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x0041, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0039
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: P2-DimmH1
	Bank Locator: P2-CH-H
	Type: DDR3
	Type Detail: Registered (Buffered)
	Speed: 1600 MT/s
	Manufacturer: Samsung            
	(Line containing Serial number has been censored)
	Asset Tag: DimmH1_AssetTag
	Part Number: M393B1K70DH0-CK0 
	Rank: 1
	Configured Clock Speed: 1600 MT/s

Handle 0x0043, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: Flash Memory
	Error Correction Type: None
	Maximum Capacity: 16 MB
	Error Information Handle: Not Provided
	Number Of Devices: 1

Handle 0x0045, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0043
	Error Information Handle: Not Provided
	Total Width: 8 bits
	Data Width: 8 bits
	Size: 16 MB
	Form Factor: Other
	Set: None
	Locator:  
	Bank Locator:  
	Type: Flash
	Type Detail: Non-Volatile
	Speed: 33 MT/s
	Manufacturer: Micron/Numonyx
	(Line containing Serial number has been censored)
	Asset Tag:  
	Part Number: 25Q Series
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x0047, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0076, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Matrox VGA
	Type: Video
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x0077, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Intel SATA Controller
	Type: SATA Controller
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x0078, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Intel SCU controller
	Type: SAS Controller
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x0079, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Intel Ethernet 1
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x007A, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Intel Ethernet 2
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x007B, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Intel Ethernet 3
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x007C, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard Intel Ethernet 4
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:00.0

Handle 0x0086, DMI type 15, 73 bytes
System Event Log
	Area Length: 0 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: Memory-mapped physical 32-bit address
	Access Address: 0xFF450000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 25
	Descriptor 1: Single-bit ECC memory error
	Data Format 1: Handle
	Descriptor 2: Multi-bit ECC memory error
	Data Format 2: Handle
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

Handle 0x008B, DMI type 13, 22 bytes
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
OLDPWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r1_isotropic_star_constant/SandyBridgeEP_E5-2680_20190514_162910
PBS_O_HOME=/home/hpc/iwia/iwia84
MPICHHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
RRZECLUSTER=TESTCLUSTER
EDITOR=nano
PBS_JOBID=3285.catstor
ENVIRONMENT=BATCH
PATH_modshare=/usr/bin/vendor_perl:999999999:/home/julian/.local/.bin:999999999:/opt/android-sdk/tools:999999999:/usr/bin:1:/mnt/opt/likwid-4.3.4/sbin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/bin:1:/usr/local/bin:999999999:/opt/android-sdk/platform-tools:999999999:/usr/bin/core_perl:999999999:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/bin/intel64:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/rrze-bin-intel:1:/mnt/opt/likwid-4.3.4/bin:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/libfabric/bin:1:/home/julian/.bin:999999999:/bin:1:/apps/python/3.6-anaconda/bin:1:/opt/intel/bin:999999999
MPIHOME=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64
LOADEDMODULES_modshare=intel64/19.0up02:1:intelmpi/2019up02-intel:1:python/3.6-anaconda:1:mkl/2019up02:1:likwid/4.3.4:1:pbspro/default:2
PBS_JOBNAME=SNB_stempel_bench
FPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
NCPUS=32
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
PBS_NODEFILE=/var/spool/pbspro/aux/3285.catstor
GROUP=iwia
PBS_TASKNUM=1
LIKWID_DEFINES=-DLIKWID_PERFMON
PWD=/home/hpc/iwia/iwia84/INSPECT-repo/stencils/3D_r1_heterogeneous_star_constant/SandyBridgeEP_E5-2680_20190514_224046
HOME=/home/hpc/iwia/iwia84
LIKWID_LIB=-L/mnt/opt/likwid-4.3.4/lib
CLASSPATH_modshare=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/lib/daal.jar:1:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/lib/mpi.jar:1
CPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/ipp/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/pstl/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/tbb/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/daal/include:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/include
PBS_MOMPORT=15003
LIKWID_INCDIR=/mnt/opt/likwid-4.3.4/include
_LMFILES__modshare=/apps/modules/modulefiles/tools/python/3.6-anaconda:1:/apps/modules/modulefiles/libraries/mkl/2019up02:2:/opt/modules/modulefiles/testcluster/likwid/4.3.4:1:/opt/modules/modulefiles/testcluster/pbspro/default:2:/apps/modules/modulefiles/development/intelmpi/2019up02-intel:1
NLSPATH=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/compiler/lib/intel64/locale/%l_%t/%N:/apps/intel/ComposerXE2019/debugger_2019/gdb/intel64/share/locale/%l_%t/%N:/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/locale/%l_%t/%N
PBS_JOBCOOKIE=554DD21C61FEFFB946D4B6D44F97C3F7
MKL_LIBDIR=/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin
PBS_O_SHELL=/bin/bash
MPIINC=-I/apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mpi/intel64/include
MKL_LIB_THREADED=-Wl,--start-group  /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_lp64.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_intel_thread.a /apps/intel/ComposerXE2019/compilers_and_libraries_2019.2.187/linux/mkl/lib/intel64_lin/libmkl_core.a -Wl,--end-group -lpthread -lm -openmp
LESS_TERMCAP_mb=[1;32m
LESS_TERMCAP_md=[1;34m
LESS_TERMCAP_me=[0m
TMPDIR=/scratch/pbs.3285.catstor
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
