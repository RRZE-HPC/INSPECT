---

title:  "Stencil 3D r3 star constant isotropic double BroadwellEP_E5-2697_CoD"

dimension    : "3D"
radius       : "3r"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.3/include -Llikwid-4.3.3/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "22"
scaling      : [ "900" ]
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

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * ((a[k][j][i-1] + a[k][j][i+1]) + (a[k-1][j][i] + a[k+1][j][i]) + (a[k][j-1][i] + a[k][j+1][i]))
+ c2 * ((a[k][j][i-2] + a[k][j][i+2]) + (a[k-2][j][i] + a[k+2][j][i]) + (a[k][j-2][i] + a[k][j+2][i]))
+ c3 * ((a[k][j][i-3] + a[k][j][i+3]) + (a[k-3][j][i] + a[k+3][j][i]) + (a[k][j-3][i] + a[k][j+3][i]))
;
}
}
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vmovupd ymm11, ymmword ptr [rbx+rdi*8+0x10]
vmovupd ymm1, ymmword ptr [rbx+rdi*8+0x8]
vmovupd ymm2, ymmword ptr [rbx+rdi*8]
vaddpd ymm12, ymm11, ymmword ptr [rbx+rdi*8+0x20]
vaddpd ymm1, ymm1, ymmword ptr [rbx+rdi*8+0x28]
vaddpd ymm2, ymm2, ymmword ptr [rbx+rdi*8+0x30]
vaddpd ymm11, ymm1, ymmword ptr [r13+rdi*8+0x18]
mov rcx, qword ptr [rsp+0x1a8]
vaddpd ymm13, ymm12, ymmword ptr [rcx+rdi*8+0x18]
vaddpd ymm12, ymm11, ymmword ptr [r12+rdi*8+0x18]
mov rcx, qword ptr [rsp+0x1a0]
vaddpd ymm14, ymm13, ymmword ptr [rcx+rdi*8+0x18]
vaddpd ymm13, ymm12, ymmword ptr [r11+rdi*8+0x18]
vaddpd ymm15, ymm14, ymmword ptr [rsi+rdi*8+0x18]
vaddpd ymm14, ymm13, ymmword ptr [rdx+rdi*8+0x18]
vaddpd ymm0, ymm15, ymmword ptr [r8+rdi*8+0x18]
vaddpd ymm15, ymm2, ymmword ptr [r10+rdi*8+0x18]
vmulpd ymm0, ymm5, ymm0
vaddpd ymm1, ymm15, ymmword ptr [r14+rdi*8+0x18]
vfmadd231pd ymm0, ymm6, ymmword ptr [rbx+rdi*8+0x18]
vaddpd ymm2, ymm1, ymmword ptr [r9+rdi*8+0x18]
vfmadd231pd ymm0, ymm14, ymm4
vaddpd ymm11, ymm2, ymmword ptr [r15+rdi*8+0x18]
vfmadd231pd ymm0, ymm11, ymm3
vmovupd ymmword ptr [rax+rdi*8+0x18], ymm0
add rdi, 0x4
cmp rdi, qword ptr [rsp+0x178]
jb 0xffffffffffffff56
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2048/7;P ~ 290
L2: P <= 16384/7;P ~ 2340
L3: P <= 1441792/7;P ~ 205970
L1: 48*N*P + 16*P*(N - 3) + 48*P <= 32768;N*P ~ 10²
L2: 48*N*P + 16*P*(N - 3) + 48*P <= 262144;N*P ~ 60²
L3: 48*N*P + 16*P*(N - 3) + 48*P <= 23068672;N*P ~ 510²
{%- endcapture -%}
{%- capture iaca -%}

Throughput Analysis Report
--------------------------
Block Throughput: 15.00 Cycles       Throughput Bottleneck: Backend
Loop Count:  22
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles |  4.0     0.0  | 15.0  | 11.5    11.1  | 11.5    10.9  |  1.0  |  1.0  |  1.0  |  0.0  |
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
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm11, ymmword ptr [rbx+rdi*8+0x10]
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm1, ymmword ptr [rbx+rdi*8+0x8]
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vmovupd ymm2, ymmword ptr [rbx+rdi*8]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm12, ymm11, ymmword ptr [rbx+rdi*8+0x20]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm1, ymm1, ymmword ptr [rbx+rdi*8+0x28]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm2, ymm2, ymmword ptr [rbx+rdi*8+0x30]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm11, ymm1, ymmword ptr [r13+rdi*8+0x18]
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov rcx, qword ptr [rsp+0x1a8]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm13, ymm12, ymmword ptr [rcx+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm12, ymm11, ymmword ptr [r12+rdi*8+0x18]
|   1      |             |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | mov rcx, qword ptr [rsp+0x1a0]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm14, ymm13, ymmword ptr [rcx+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm13, ymm12, ymmword ptr [r11+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm15, ymm14, ymmword ptr [rsi+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm14, ymm13, ymmword ptr [rdx+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm0, ymm15, ymmword ptr [r8+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm15, ymm2, ymmword ptr [r10+rdi*8+0x18]
|   1      | 1.0         |      |             |             |      |      |      |      | vmulpd ymm0, ymm5, ymm0
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm1, ymm15, ymmword ptr [r14+rdi*8+0x18]
|   2      | 1.0         |      | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vfmadd231pd ymm0, ymm6, ymmword ptr [rbx+rdi*8+0x18]
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm2, ymm1, ymmword ptr [r9+rdi*8+0x18]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm0, ymm14, ymm4
|   2      |             | 1.0  | 0.5     0.5 | 0.5     0.5 |      |      |      |      | vaddpd ymm11, ymm2, ymmword ptr [r15+rdi*8+0x18]
|   1      | 1.0         |      |             |             |      |      |      |      | vfmadd231pd ymm0, ymm11, ymm3
|   2      |             |      | 0.5         | 0.5         | 1.0  |      |      |      | vmovupd ymmword ptr [rax+rdi*8+0x18], ymm0
|   1      |             |      |             |             |      |      | 1.0  |      | add rdi, 0x4
|   2^     |             |      | 0.5     0.5 | 0.5     0.5 |      | 1.0  |      |      | cmp rdi, qword ptr [rsp+0x178]
|   0*F    |             |      |             |             |      |      |      |      | jb 0xffffffffffffff56
Total Num Of Uops: 45
Analysis Notes:
Backend allocation was stalled due to unavailable allocation resources.

{%- endcapture -%}
{%- capture hostinfo -%}

################################################################################
# Logged in users
################################################################################
 13:05:07 up 103 days, 21:37,  0 users,  load average: 0.81, 8.87, 13.49
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT

################################################################################
# CGroups
################################################################################
Allowed CPUs: 0-71
Allowed Memory controllers: 0-3

################################################################################
# Topology
################################################################################
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              72
On-line CPU(s) list: 0-71
Thread(s) per core:  2
Core(s) per socket:  18
Socket(s):           2
NUMA node(s):        4
Vendor ID:           GenuineIntel
CPU family:          6
Model:               79
Model name:          Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz
Stepping:            1
CPU MHz:             2274.232
CPU max MHz:         2301.0000
CPU min MHz:         1200.0000
BogoMIPS:            4594.52
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            23040K
NUMA node0 CPU(s):   0-8,36-44
NUMA node1 CPU(s):   9-17,45-53
NUMA node2 CPU(s):   18-26,54-62
NUMA node3 CPU(s):   27-35,63-71
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 invpcid_single pti intel_ppin ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsaveopt cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts flush_l1d
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 36 37 38 39 40 41 42 43 44
node 0 size: 32041 MB
node 0 free: 31431 MB
node 1 cpus: 9 10 11 12 13 14 15 16 17 45 46 47 48 49 50 51 52 53
node 1 size: 32252 MB
node 1 free: 31992 MB
node 2 cpus: 18 19 20 21 22 23 24 25 26 54 55 56 57 58 59 60 61 62
node 2 size: 32252 MB
node 2 free: 31918 MB
node 3 cpus: 27 28 29 30 31 32 33 34 35 63 64 65 66 67 68 69 70 71
node 3 size: 32251 MB
node 3 free: 31801 MB
node distances:
node   0   1   2   3
  0:  10  21  31  31
  1:  21  10  31  31
  2:  31  31  10  21
  3:  31  31  21  10

################################################################################
# Load
################################################################################
0.81 8.87 13.49 1/777 56250

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
MemFree:        130196292 kB
MemAvailable:   129866120 kB
Buffers:            8604 kB
Cached:           123268 kB
SwapCached:        49268 kB
Active:            49792 kB
Inactive:         152388 kB
Active(anon):      21128 kB
Inactive(anon):    49668 kB
Active(file):      28664 kB
Inactive(file):   102720 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      67043324 kB
SwapFree:       66958076 kB
Dirty:              2672 kB
Writeback:             0 kB
AnonPages:         23120 kB
Mapped:            91728 kB
Shmem:               340 kB
Slab:             691236 kB
SReclaimable:     279136 kB
SUnreclaim:       412100 kB
KernelStack:       13616 kB
PageTables:         3892 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    132987896 kB
Committed_AS:     309880 kB
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
DirectMap4k:      912128 kB
DirectMap2M:    45096960 kB
DirectMap1G:    90177536 kB

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
# Operating System Kernel
################################################################################
Linux broadep2 4.15.0-42-generic #45-Ubuntu SMP Thu Nov 15 19:32:57 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

################################################################################
# Hostname
################################################################################
broadep2.rrze.uni-erlangen.de
{%- endcapture -%}

{% include stencil_template.md %}
