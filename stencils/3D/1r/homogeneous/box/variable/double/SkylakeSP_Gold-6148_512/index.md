---

title:  "Stencil 3D r1 box variable homogeneous double SkylakeSP_Gold-6148_512"

dimension    : "3D"
radius       : "1r"
weighting    : "homogeneous"
kind         : "box"
coefficients : "variable"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_512"
flavor       : "AVX 512"
compile_flags: "icc -O3 -fno-alias -xCORE-AVX512 -qopt-zmm-usage=high -qopenmp -DLIKWID_PERFMON -Ilikwid-4.3.2/include -Llikwid-4.3.2/lib -Iheaders/dummy.c stencil_compilable.c -o stencil -llikwid"
flop         : "27"
scaling      : [ "1290" ]
blocking     : [ "L3-3D" ]
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double W[1][M][N][P];

for (int k = 1; k < M - 1; ++k) {
  for (int j = 1; j < N - 1; ++j) {
    for (int i = 1; i < P - 1; ++i) {
      b[k][j][i] =
          W[0][k][j][i] *
          (a[k][j][i] + a[k - 1][j - 1][i - 1] + a[k][j - 1][i - 1] +
           a[k + 1][j - 1][i - 1] + a[k - 1][j][i - 1] +
           a[k][j][i - 1] + a[k + 1][j][i - 1] +
           a[k - 1][j + 1][i - 1] + a[k][j + 1][i - 1] +
           a[k + 1][j + 1][i - 1] + a[k - 1][j - 1][i] +
           a[k][j - 1][i] + a[k + 1][j - 1][i] + a[k - 1][j][i] +
           a[k + 1][j][i] + a[k - 1][j + 1][i] + a[k][j + 1][i] +
           a[k + 1][j + 1][i] + a[k - 1][j - 1][i + 1] +
           a[k][j - 1][i + 1] + a[k + 1][j - 1][i + 1] +
           a[k - 1][j][i + 1] + a[k][j][i + 1] + a[k + 1][j][i + 1] +
           a[k - 1][j + 1][i + 1] + a[k][j + 1][i + 1] +
           a[k + 1][j + 1][i + 1]);
    }
  }
}
{%- endcapture -%}
{%- capture source_code_asm -%}
vpcmpgtd k1, ymm28, ymm27
add r13, 0x8
vpaddd ymm27, ymm27, ymm0
vmovupd zmm30{k1}{z}, zmmword ptr [rax+r10*1+0x8]
vmovupd zmm3{k1}{z}, zmmword ptr [rax+r10*1]
vmovupd zmm20{k1}{z}, zmmword ptr [rax+r10*1+0x10]
vmovupd zmm31{k1}{z}, zmmword ptr [rax+r11*1]
vmovupd zmm9{k1}{z}, zmmword ptr [rax+r11*1+0x8]
vmovupd zmm17{k1}{z}, zmmword ptr [rax+r11*1+0x10]
vmovupd zmm29{k1}{z}, zmmword ptr [rax+r12*1]
vmovupd zmm8{k1}{z}, zmmword ptr [rax+r12*1+0x8]
vmovupd zmm16{k1}{z}, zmmword ptr [rax+r12*1+0x10]
vmovupd zmm2{k1}{z}, zmmword ptr [rax+rsi*1]
vmovupd zmm13{k1}{z}, zmmword ptr [rax+rsi*1+0x8]
vmovupd zmm21{k1}{z}, zmmword ptr [rax+rsi*1+0x10]
vmovupd zmm6{k1}{z}, zmmword ptr [rax+rbx*1]
vmovupd zmm10{k1}{z}, zmmword ptr [rax+rbx*1+0x8]
vmovupd zmm18{k1}{z}, zmmword ptr [rax+rbx*1+0x10]
vmovupd zmm5{k1}{z}, zmmword ptr [rax+rdi*1]
vmovupd zmm12{k1}{z}, zmmword ptr [rax+rdi*1+0x8]
vmovupd zmm19{k1}{z}, zmmword ptr [rax+rdi*1+0x10]
vmovupd zmm4{k1}{z}, zmmword ptr [rax+rcx*1]
vmovupd zmm11{k1}{z}, zmmword ptr [rax+rcx*1+0x8]
vmovupd zmm14{k1}{z}, zmmword ptr [rax+rdx*1]
vmovupd zmm25{k1}{z}, zmmword ptr [rax+rdx*1+0x8]
vmovupd zmm7{k1}{z}, zmmword ptr [rax+r15*1]
vmovupd zmm15{k1}{z}, zmmword ptr [rax+r15*1+0x8]
vmovupd zmm24{k1}{z}, zmmword ptr [rax+rcx*1+0x10]
vmovupd zmm22{k1}{z}, zmmword ptr [rax+rdx*1+0x10]
vmovupd zmm23{k1}{z}, zmmword ptr [rax+r15*1+0x10]
vmovupd zmm26{k1}{z}, zmmword ptr [rax+r9*1+0x8]
vaddpd zmm30, zmm30, zmm31
vaddpd zmm2, zmm29, zmm2
vaddpd zmm3, zmm6, zmm3
vaddpd zmm4, zmm5, zmm4
vaddpd zmm7, zmm14, zmm7
vaddpd zmm8, zmm9, zmm8
vaddpd zmm10, zmm13, zmm10
vaddpd zmm11, zmm12, zmm11
vaddpd zmm15, zmm25, zmm15
vaddpd zmm16, zmm17, zmm16
vaddpd zmm18, zmm21, zmm18
vaddpd zmm19, zmm20, zmm19
vaddpd zmm29, zmm30, zmm2
vaddpd zmm5, zmm3, zmm4
vaddpd zmm9, zmm7, zmm8
vaddpd zmm12, zmm10, zmm11
vaddpd zmm17, zmm15, zmm16
vaddpd zmm20, zmm18, zmm19
vaddpd zmm22, zmm24, zmm22
vaddpd zmm6, zmm29, zmm5
vaddpd zmm13, zmm9, zmm12
vaddpd zmm21, zmm17, zmm20
vaddpd zmm23, zmm22, zmm23
vaddpd zmm14, zmm6, zmm13
vaddpd zmm24, zmm21, zmm23
vaddpd zmm25, zmm14, zmm24
vmulpd zmm26, zmm26, zmm25
vmovupd zmmword ptr [rax+r14*1+0x8]{k1}, zmm26
add rax, 0x40
cmp r13, r8
jb 0xfffffffffffffe2c
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 4100/11;P ~ 370
L2: P <= 11916;P ~ 11910
L3: P <= 3670020/11;P ~ 333630
L1: 40*N*P - 32*P - 32 <= 32768;N*P ~ 20²
L2: 40*N*P - 32*P - 32 <= 1048576;N*P ~ 160²
L3: 40*N*P - 32*P - 32 <= 29360128;N*P ~ 850²
{%- endcapture -%}

{% include stencil_template.md %}
