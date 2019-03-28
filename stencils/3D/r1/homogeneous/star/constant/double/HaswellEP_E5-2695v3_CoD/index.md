---

title:  "Stencil 3D r1 star constant homogeneous double HaswellEP_E5-2695v3_CoD"

dimension    : "3D"
radius       : "r1"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "HaswellEP_E5-2695v3_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "7"
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

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = c0 * (a[k][j][i]
+ a[k][j][i-1] + a[k][j][i+1]
+ a[k-1][j][i] + a[k+1][j][i]
+ a[k][j-1][i] + a[k][j+1][i]
);
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm3, ymmword ptr [rsi+r13*1+0x10]
vmovupd ymm2, ymmword ptr [rsi+r13*1+0x8]
vmovupd ymm6, ymmword ptr [r8+r14*8+0x8]
vaddpd ymm5, ymm3, ymmword ptr [rdi+r14*8+0x8]
vaddpd ymm4, ymm2, ymmword ptr [rsi+r13*1]
vaddpd ymm7, ymm6, ymmword ptr [r10+r14*8+0x8]
vmovupd ymm2, ymmword ptr [r8+r14*8+0x28]
vaddpd ymm8, ymm4, ymm5
vaddpd ymm9, ymm7, ymmword ptr [r9+r14*8+0x8]
vaddpd ymm3, ymm2, ymmword ptr [r10+r14*8+0x28]
vaddpd ymm10, ymm8, ymm9
vaddpd ymm5, ymm3, ymmword ptr [r9+r14*8+0x28]
vmulpd ymm11, ymm0, ymm10
vmovupd ymmword ptr [rbx+r14*8+0x8], ymm11
vmovupd ymm13, ymmword ptr [rsi+r13*1+0x30]
vmovupd ymm12, ymmword ptr [rsi+r13*1+0x28]
vaddpd ymm15, ymm13, ymmword ptr [rdi+r14*8+0x28]
vaddpd ymm14, ymm12, ymmword ptr [rsi+r13*1+0x20]
vmovupd ymm12, ymmword ptr [r8+r14*8+0x48]
vaddpd ymm4, ymm14, ymm15
vaddpd ymm13, ymm12, ymmword ptr [r10+r14*8+0x48]
vaddpd ymm6, ymm4, ymm5
vaddpd ymm15, ymm13, ymmword ptr [r9+r14*8+0x48]
vmulpd ymm7, ymm0, ymm6
vmovupd ymmword ptr [rbx+r14*8+0x28], ymm7
vmovupd ymm9, ymmword ptr [rsi+r13*1+0x50]
vmovupd ymm8, ymmword ptr [rsi+r13*1+0x48]
vaddpd ymm11, ymm9, ymmword ptr [rdi+r14*8+0x48]
vaddpd ymm10, ymm8, ymmword ptr [rsi+r13*1+0x40]
vmovupd ymm8, ymmword ptr [r8+r14*8+0x68]
vaddpd ymm14, ymm10, ymm11
vaddpd ymm9, ymm8, ymmword ptr [r10+r14*8+0x68]
vaddpd ymm2, ymm14, ymm15
vaddpd ymm11, ymm9, ymmword ptr [r9+r14*8+0x68]
vmulpd ymm3, ymm0, ymm2
vmovupd ymmword ptr [rbx+r14*8+0x48], ymm3
vmovupd ymm5, ymmword ptr [rsi+r13*1+0x70]
vmovupd ymm4, ymmword ptr [rsi+r13*1+0x68]
vaddpd ymm7, ymm5, ymmword ptr [rdi+r14*8+0x68]
vaddpd ymm6, ymm4, ymmword ptr [rsi+r13*1+0x60]
vaddpd ymm10, ymm6, ymm7
add rsi, 0x80
vaddpd ymm12, ymm10, ymm11
vmulpd ymm13, ymm0, ymm12
vmovupd ymmword ptr [rbx+r14*8+0x68], ymm13
add r14, 0x10
cmp r14, r12
jb 0xfffffffffffffedc
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3;P <= 680
L2: P <= 5462;P <= 5460
L3: P <= 1179650/3;P <= 393210
L1: 16*N*P + 16*P*(N - 1) <= 32768;N*P <= 30²
L2: 16*N*P + 16*P*(N - 1) <= 262144;N*P <= 90²
L3: 16*N*P + 16*P*(N - 1) <= 18874368;N*P <= 760²
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 24.00 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles |  4.0     0.0  | 24.0  | 16.0    13.0  | 16.0    15.0  |  4.0  |  1.0  |  1.0  |  0.0  |
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
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm3, ymmword ptr [rsi+r13*1+0x10]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm2, ymmword ptr [rsi+r13*1+0x8]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm6, ymmword ptr [r8+r14*8+0x8]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm5, ymm3, ymmword ptr [rdi+r14*8+0x8]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm4, ymm2, ymmword ptr [rsi+r13*1]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm7, ymm6, ymmword ptr [r10+r14*8+0x8]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm2, ymmword ptr [r8+r14*8+0x28]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm8, ymm4, ymm5
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm9, ymm7, ymmword ptr [r9+r14*8+0x8]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm3, ymm2, ymmword ptr [r10+r14*8+0x28]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm10, ymm8, ymm9
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm5, ymm3, ymmword ptr [r9+r14*8+0x28]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm11, ymm0, ymm10
|   2      |             |      | 1.0         |             | 1.0  |      |      |      | vmovupd ymmword ptr [rbx+r14*8+0x8], ymm11
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm13, ymmword ptr [rsi+r13*1+0x30]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm12, ymmword ptr [rsi+r13*1+0x28]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm15, ymm13, ymmword ptr [rdi+r14*8+0x28]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm14, ymm12, ymmword ptr [rsi+r13*1+0x20]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm12, ymmword ptr [r8+r14*8+0x48]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm4, ymm14, ymm15
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm13, ymm12, ymmword ptr [r10+r14*8+0x48]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm6, ymm4, ymm5
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm15, ymm13, ymmword ptr [r9+r14*8+0x48]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm7, ymm0, ymm6
|   2      |             |      | 1.0         |             | 1.0  |      |      |      | vmovupd ymmword ptr [rbx+r14*8+0x28], ymm7
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm9, ymmword ptr [rsi+r13*1+0x50]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm8, ymmword ptr [rsi+r13*1+0x48]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm11, ymm9, ymmword ptr [rdi+r14*8+0x48]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm10, ymm8, ymmword ptr [rsi+r13*1+0x40]
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm8, ymmword ptr [r8+r14*8+0x68]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm14, ymm10, ymm11
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm9, ymm8, ymmword ptr [r10+r14*8+0x68]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm2, ymm14, ymm15
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm11, ymm9, ymmword ptr [r9+r14*8+0x68]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm3, ymm0, ymm2
|   2      |             |      | 1.0         |             | 1.0  |      |      |      | vmovupd ymmword ptr [rbx+r14*8+0x48], ymm3
|   1      |             |      |             | 1.0     1.0 |      |      |      |      | vmovupd ymm5, ymmword ptr [rsi+r13*1+0x70]
|   1      |             |      | 1.0     1.0 |             |      |      |      |      | vmovupd ymm4, ymmword ptr [rsi+r13*1+0x68]
|   2      |             | 1.0  |             | 1.0     1.0 |      |      |      |      | vaddpd ymm7, ymm5, ymmword ptr [rdi+r14*8+0x68]
|   2      |             | 1.0  | 1.0     1.0 |             |      |      |      |      | vaddpd ymm6, ymm4, ymmword ptr [rsi+r13*1+0x60]
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm10, ymm6, ymm7
|   1      |             |      |             |             |      |      | 1.0  |      | add rsi, 0x80
|   1      |             | 1.0  |             |             |      |      |      |      | vaddpd ymm12, ymm10, ymm11
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm13, ymm0, ymm12
|   2      |             |      |             | 1.0         | 1.0  |      |      |      | vmovupd ymmword ptr [rbx+r14*8+0x68], ymm13
|   1      |             |      |             |             |      | 1.0  |      |      | add r14, 0x10
|   1*     |             |      |             |             |      |      |      |      | cmp r14, r12
|   0*F    |             |      |             |             |      |      |      |      | jb 0xfffffffffffffedc
Total Num Of Uops: 67
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.

{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Logged in users
################################################################################
 13:05:02 up 103 days, 22:30,  0 users,  load average: 0.24, 2.52, 4.59
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-55
Allowed Memory controllers: 0-3

################################################################################
# Topology
################################################################################
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              56
On-line CPU(s) list: 0-55
Thread(s) per core:  2
Core(s) per socket:  14
Socket(s):           2
NUMA node(s):        4
Vendor ID:           GenuineIntel
CPU family:          6
Model:               63
Model name:          Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz
Stepping:            2
CPU MHz:             2218.074
CPU max MHz:         2301.0000
CPU min MHz:         1200.0000
BogoMIPS:            4600.13
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            17920K
NUMA node0 CPU(s):   0-6,28-34
NUMA node1 CPU(s):   7-13,35-41
NUMA node2 CPU(s):   14-20,42-48
NUMA node3 CPU(s):   21-27,49-55
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti intel_ppin ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc cqm_occup_llc dtherm ida arat pln pts flush_l1d
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 28 29 30 31 32 33 34
node 0 size: 15932 MB
node 0 free: 15665 MB
node 1 cpus: 7 8 9 10 11 12 13 35 36 37 38 39 40 41
node 1 size: 16125 MB
node 1 free: 15920 MB
node 2 cpus: 14 15 16 17 18 19 20 42 43 44 45 46 47 48
node 2 size: 16125 MB
node 2 free: 15873 MB
node 3 cpus: 21 22 23 24 25 26 27 49 50 51 52 53 54 55
node 3 size: 16124 MB
node 3 free: 15836 MB
node distances:
node   0   1   2   3
  0:  10  21  31  31
  1:  21  10  31  31
  2:  31  31  10  21
  3:  31  31  21  10

################################################################################
# Load
################################################################################
0.24 2.52 4.59 1/641 19665

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
MemFree:        64815388 kB
MemAvailable:   64636500 kB
Buffers:            6724 kB
Cached:           110432 kB
SwapCached:        41328 kB
Active:            38284 kB
Inactive:         131812 kB
Active(anon):      11540 kB
Inactive(anon):    42048 kB
Active(file):      26744 kB
Inactive(file):    89764 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      31998972 kB
SwapFree:       31909896 kB
Dirty:              2580 kB
Writeback:             8 kB
AnonPages:         13420 kB
Mapped:            77776 kB
Shmem:               568 kB
Slab:             527292 kB
SReclaimable:     203208 kB
SUnreclaim:       324084 kB
KernelStack:       11136 kB
PageTables:         3344 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    64924568 kB
Committed_AS:     265560 kB
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
DirectMap4k:      617600 kB
DirectMap2M:    30730240 kB
DirectMap1G:    37748736 kB

################################################################################
# Transparent huge pages
################################################################################
Enabled: always [madvise] never
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
Linux hasep1 4.15.0-42-generic #45-Ubuntu SMP Thu Nov 15 19:32:57 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Hostname
################################################################################
hasep1.rrze.uni-erlangen.de
{%- endcapture -%}

{% include stencil_template.md %}
