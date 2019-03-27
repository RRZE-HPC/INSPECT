---

title:  "Stencil 3D r3 star constant heterogeneous double SkylakeSP_Gold-6148_SNC"

dimension    : "3D"
radius       : "3r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_SNC"
flavor       : "Sub-NUMA Clustering"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "37"
scaling      : [ "1010" ]
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
vpcmpgtq k1, ymm29, ymm9
vpaddq ymm9, ymm9, ymm27
vmovupd ymm2{k1}{z}, ymmword ptr [rdi+r13*8+0x18]
vmovupd ymm3{k1}{z}, ymmword ptr [rdx+r13*8+0x18]
vmovupd ymm31{k1}{z}, ymmword ptr [r9+r13*8+0x18]
vmovupd ymm0{k1}{z}, ymmword ptr [rcx+r13*8+0x8]
vmovupd ymm6{k1}{z}, ymmword ptr [rax+r13*8+0x18]
vmulpd ymm2, ymm20, ymm2
vmovupd ymm30{k1}{z}, ymmword ptr [rcx+r13*8+0x28]
vmulpd ymm31, ymm19, ymm31
vmovupd ymm7{k1}{z}, ymmword ptr [rcx+r13*8+0x20]
vmovupd ymm4{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
vfmadd231pd ymm2, ymm3, ymm22
vmovupd ymm5{k1}{z}, ymmword ptr [rcx+r13*8+0x18]
vfmadd231pd ymm31, ymm6, ymm21
vmovupd ymm6{k1}{z}, ymmword ptr [rcx+r13*8]
vmulpd ymm7, ymm23, ymm7
vaddpd ymm31, ymm2, ymm31
vmovupd ymm2{k1}{z}, ymmword ptr [rcx+r13*8+0x30]
vmulpd ymm6, ymm12, ymm6
vfmadd231pd ymm7, ymm4, ymm24
vmulpd ymm2, ymm11, ymm2
vfmadd231pd ymm7, ymm5, ymm25
mov r15, qword ptr [rsp+0x370]
vmovupd ymm3{k1}{z}, ymmword ptr [r15+r13*8+0x18]
vmulpd ymm3, ymm16, ymm3
vfmadd231pd ymm3, ymm0, ymm18
vmovupd ymm0{k1}{z}, ymmword ptr [r14+r13*8+0x18]
vmulpd ymm0, ymm15, ymm0
vfmadd231pd ymm0, ymm30, ymm17
vmovupd ymm30{k1}{z}, ymmword ptr [rbx+r13*8+0x18]
vaddpd ymm0, ymm3, ymm0
vmovupd ymm3{k1}{z}, ymmword ptr [r10+r13*8+0x18]
vfmadd231pd ymm6, ymm30, ymm14
vmovupd ymm30{k1}{z}, ymmword ptr [r11+r13*8+0x18]
vaddpd ymm0, ymm0, ymm31
vfmadd231pd ymm2, ymm3, ymm13
vmovupd ymm3{k1}{z}, ymmword ptr [rsi+r13*8+0x18]
vaddpd ymm2, ymm6, ymm2
vmovupd ymm6{k1}{z}, ymmword ptr [r12+r13*8+0x18]
vmulpd ymm3, ymm28, ymm3
vmulpd ymm6, ymm1, ymm6
mov r15, qword ptr [rsp+0x378]
vfmadd231pd ymm6, ymm30, ymm8
vmovupd ymm31{k1}{z}, ymmword ptr [r15+r13*8+0x18]
vfmadd231pd ymm3, ymm31, ymm10
vaddpd ymm3, ymm3, ymm6
vaddpd ymm4, ymm3, ymm2
vaddpd ymm5, ymm4, ymm0
vaddpd ymm0, ymm5, ymm7
vmovupd ymmword ptr [r8+r13*8+0x18]{k1}, ymm0
add r13, 0x4
cmp r13, qword ptr [rsp+0x350]
jb 0xfffffffffffffe76
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P ~ 290
L2: P <= 65536/7;P ~ 9360
L3: P <= 262144;P ~ 262140
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;N*P ~ 10²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 1048576;N*P ~ 120²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 29360128;N*P ~ 510²
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 20.53 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 16.0     0.0  | 16.0  | 11.5    11.1  | 11.5    10.9  |  1.0  | 16.0  |  2.0  |  0.0  |
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
|   1      |             |      |             |             |      | 1.0  |      |      | vpcmpgtq k1, ymm29, ymm9
|   1      |             |      |             |             |      | 1.0  |      |      | vpaddq ymm9, ymm9, ymm27
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm2{k1}{z}, ymmword ptr [rdi+r13*8+0x18]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm3{k1}{z}, ymmword ptr [rdx+r13*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [r9+r13*8+0x18]
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm0{k1}{z}, ymmword ptr [rcx+r13*8+0x8]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm6{k1}{z}, ymmword ptr [rax+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm2, ymm20, ymm2
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm30{k1}{z}, ymmword ptr [rcx+r13*8+0x28]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm31, ymm19, ymm31
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm7{k1}{z}, ymmword ptr [rcx+r13*8+0x20]
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm4{k1}{z}, ymmword ptr [rcx+r13*8+0x10]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm2, ymm3, ymm22
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm5{k1}{z}, ymmword ptr [rcx+r13*8+0x18]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm31, ymm6, ymm21
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm6{k1}{z}, ymmword ptr [rcx+r13*8]
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm7, ymm23, ymm7
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd ymm31, ymm2, ymm31
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm2{k1}{z}, ymmword ptr [rcx+r13*8+0x30]
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm6, ymm12, ymm6
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm7, ymm4, ymm24
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm2, ymm11, ymm2
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm7, ymm5, ymm25
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov r15, qword ptr [rsp+0x370]
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm3{k1}{z}, ymmword ptr [r15+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm3, ymm16, ymm3
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm3, ymm0, ymm18
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm0{k1}{z}, ymmword ptr [r14+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm0, ymm15, ymm0
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm0, ymm30, ymm17
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm30{k1}{z}, ymmword ptr [rbx+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm0, ymm3, ymm0
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm3{k1}{z}, ymmword ptr [r10+r13*8+0x18]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm6, ymm30, ymm14
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm30{k1}{z}, ymmword ptr [r11+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm0, ymm0, ymm31
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm2, ymm3, ymm13
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm3{k1}{z}, ymmword ptr [rsi+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm2, ymm6, ymm2
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm6{k1}{z}, ymmword ptr [r12+r13*8+0x18]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm3, ymm28, ymm3
|   1      |             | 1.0  |             |             |      |      |      |      | vmulpd ymm6, ymm1, ymm6
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov r15, qword ptr [rsp+0x378]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm6, ymm30, ymm8
|   2      |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | vmovupd ymm31{k1}{z}, ymmword ptr [r15+r13*8+0x18]
|   1      |             | 1.0  |             |             |      |      |      |      | vfmadd231pd ymm3, ymm31, ymm10
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd ymm3, ymm3, ymm6
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm4, ymm3, ymm2
|   1      | 1.0         |      |             |             |      |      |      |      | vaddpd ymm5, ymm4, ymm0
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm0, ymm5, ymm7
|   2      |             |      | 0.5         | 0.5         | 1.0  |      |      |      | vmovupd ymmword ptr [r8+r13*8+0x18]{k1}, ymm0
|   1      |             |      |             |             |      |      | 1.0  |      | add r13, 0x4
|   2^     |             |      | 0.5     0.5 | 0.5     0.5 |      |      | 1.0  |      | cmp r13, qword ptr [rsp+0x350]
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffe76
Total Num Of Uops: 74
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.

{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Logged in users
################################################################################
root
 13:05:13 up 6 days, 22:17,  1 user,  load average: 0.40, 3.94, 6.21
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    192.168.80.181   19Mar19  6days  0.01s  0.01s -bash

################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-79
Allowed Memory controllers: 0-3

################################################################################
# Topology
################################################################################
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              80
On-line CPU(s) list: 0-79
Thread(s) per core:  2
Core(s) per socket:  20
Socket(s):           2
NUMA node(s):        4
Vendor ID:           GenuineIntel
CPU family:          6
Model:               85
Model name:          Intel(R) Xeon(R) Gold 6148 CPU @ 2.40GHz
Stepping:            4
CPU MHz:             2344.203
CPU max MHz:         2401.0000
CPU min MHz:         1000.0000
BogoMIPS:            4800.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            1024K
L3 cache:            28160K
NUMA node0 CPU(s):   0-2,5,6,10-12,15,16,40-42,45,46,50-52,55,56
NUMA node1 CPU(s):   3,4,7-9,13,14,17-19,43,44,47-49,53,54,57-59
NUMA node2 CPU(s):   20-22,25,26,30-32,35,36,60-62,65,66,70-72,75,76
NUMA node3 CPU(s):   23,24,27-29,33,34,37-39,63,64,67-69,73,74,77-79
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 invpcid_single pti intel_ppin ssbd mba ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku ospke flush_l1d
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 5 6 10 11 12 15 16 40 41 42 45 46 50 51 52 55 56
node 0 size: 22758 MB
node 0 free: 22345 MB
node 1 cpus: 3 4 7 8 9 13 14 17 18 19 43 44 47 48 49 53 54 57 58 59
node 1 size: 24188 MB
node 1 free: 23903 MB
node 2 cpus: 20 21 22 25 26 30 31 32 35 36 60 61 62 65 66 70 71 72 75 76
node 2 size: 24188 MB
node 2 free: 23913 MB
node 3 cpus: 23 24 27 28 29 33 34 37 38 39 63 64 67 68 69 73 74 77 78 79
node 3 size: 24186 MB
node 3 free: 23802 MB
node distances:
node   0   1   2   3
  0:  10  11  21  21
  1:  11  10  21  21
  2:  21  21  10  11
  3:  21  21  11  10

################################################################################
# Load
################################################################################
0.40 3.94 6.21 1/797 79767

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
MemFree:        96222928 kB
MemAvailable:   95973528 kB
Buffers:            6800 kB
Cached:           125764 kB
SwapCached:            8 kB
Active:            88328 kB
Inactive:          99304 kB
Active(anon):      49452 kB
Inactive(anon):     8192 kB
Active(file):      38876 kB
Inactive(file):    91112 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      49632252 kB
SwapFree:       49631996 kB
Dirty:               356 kB
Writeback:             0 kB
AnonPages:         55264 kB
Mapped:            98500 kB
Shmem:              2144 kB
Slab:             675556 kB
SReclaimable:     232448 kB
SUnreclaim:       443108 kB
KernelStack:       14048 kB
PageTables:         3952 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    98437132 kB
Committed_AS:     200244 kB
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
DirectMap4k:      772304 kB
DirectMap2M:    12511232 kB
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
# Operating System Kernel
################################################################################
Linux skylakesp2 4.15.0-46-generic #49-Ubuntu SMP Wed Feb 6 09:33:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Hostname
################################################################################
skylakesp2.rrze.uni-erlangen.de
{%- endcapture -%}

{% include stencil_template.md %}
