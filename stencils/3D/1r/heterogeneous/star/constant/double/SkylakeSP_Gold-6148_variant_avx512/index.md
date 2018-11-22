---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "SkylakeSP_Gold-6148_avx512"
flavor       : "AVX 512"
comment      : "Inorder to convince the compiler to generate AVX512 code, the flag `-qopt-zmm-usage=high` has to be used."
compile_flags: "icc -O3 -xCORE-AVX512 -qopt-zmm-usage=high -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
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

for ( int k = 1; k < M-1; k++ ) {
  for ( int j = 1; j < N-1; j++ ) {
    for ( int i = 1; i < P-1; i++ ) {
      b[k][j][i] = c0 * a[k][j][i]
        + c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
        + c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
        + c5 * a[k][j-1][i] + c6 * a[k][j+1][i];
    }
  }
}
{%- endcapture -%}

{%- capture source_code_asm -%}
vpcmpgtd k1, ymm9, ymm10
add r11, 0x8
vpaddd ymm10, ymm10, ymm1
vmovupd zmm17{k1}{z}, zmmword ptr [rcx+r9*1+0x10]
vmovupd zmm11{k1}{z}, zmmword ptr [rcx+r10*1+0x8]
vmovupd zmm13{k1}{z}, zmmword ptr [rcx+rbx*1+0x8]
vmovupd zmm18{k1}{z}, zmmword ptr [rcx+r9*1]
vmovupd zmm12{k1}{z}, zmmword ptr [rcx+r8*1+0x8]
vmovupd zmm14{k1}{z}, zmmword ptr [rcx+rdi*1+0x8]
vmovupd zmm19{k1}{z}, zmmword ptr [rcx+r9*1+0x8]
vmulpd zmm21, zmm5, zmm17
vmulpd zmm15, zmm2, zmm11
vmulpd zmm16, zmm0, zmm13
vfmadd231pd zmm21, zmm18, zmm6
vfmadd231pd zmm15, zmm12, zmm4
vfmadd231pd zmm16, zmm14, zmm3
vfmadd231pd zmm21, zmm19, zmm7
vaddpd zmm20, zmm15, zmm16
vaddpd zmm22, zmm20, zmm21
vmovupd zmmword ptr [rcx+r13*1+0x8]{k1}, zmm22
add rcx, 0x40
cmp r11, r15
jb 0xffffffffffffff61
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

