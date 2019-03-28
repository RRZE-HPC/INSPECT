---

title:  "Stencil detail"

dimension    : "3D"
radius       : "r1"
weighting    : "isotropic"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_avx512"
flavor       : "AVX 512"
compile_flags: "icc -O3 -xCORE-AVX512 -qopt-zmm-usage=high -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;

for(int k=1; k < M-1; k++){
  for(int j=1; j < N-1; j++){
    for(int i=1; i < P-1; i++){
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
vmovupd zmm4, zmmword ptr [r8+r12*8+0x10]
vmovupd zmm3, zmmword ptr [r8+r12*8+0x8]
vmovups zmm7, zmmword ptr [rbx+r12*8+0x8]
vmovups zmm17, zmmword ptr [rbx+r12*8+0x48]
vaddpd zmm5, zmm3, zmmword ptr [r8+r12*8]
vaddpd zmm6, zmm4, zmmword ptr [rsi+r12*8+0x8]
vaddpd zmm8, zmm7, zmmword ptr [r11+r12*8+0x8]
vaddpd zmm18, zmm17, zmmword ptr [r11+r12*8+0x48]
vaddpd zmm9, zmm5, zmm6
vaddpd zmm10, zmm8, zmmword ptr [r15+r12*8+0x8]
vaddpd zmm20, zmm18, zmmword ptr [r15+r12*8+0x48]
vaddpd zmm11, zmm9, zmm10
vmulpd zmm12, zmm2, zmm11
vmovupd zmmword ptr [rax+r12*8+0x8], zmm12
vmovupd zmm14, zmmword ptr [rdi+r12*8+0x10]
vmovupd zmm13, zmmword ptr [rdi+r12*8+0x8]
vaddpd zmm16, zmm14, zmmword ptr [rsi+r12*8+0x48]
vaddpd zmm15, zmm13, zmmword ptr [rdi+r12*8]
vaddpd zmm19, zmm15, zmm16
vaddpd zmm21, zmm19, zmm20
vmulpd zmm22, zmm2, zmm21
vmovupd zmmword ptr [rax+r12*8+0x48], zmm22
add r12, 0x10
cmp r12, r14
jb 0xffffffffffffff2d
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 21846
L3: P <= 611670
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 1048576;181²
L3: 16*N*P + 16*P*(N - 1) <= 29360128;957²
{%- endcapture -%}

{% include stencil_template.md %}

