---

title:  "temporal test stencil"

stencil_name : "temporal test"
dimension    : "7D"
radius       : "r24"
weighting    : "homogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double_Complex"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : "Cluster on Die"
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp "
flop         : "7"
scaling      : []
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

for ( int k = 1; k < M - 1; ++k )
{
	for ( int j = 1; j < N - 1; ++j )
	{
		for ( int i = 1; i < O - 1; ++i )
		{
			// ----- Ex_y = Cex_ty * Ex_y + Cex_y * (D(Hy_x + Hy_z) - T(Hy_x + Hy_z) ) + Ex_old;
			Exy[k][j][i] = Exy[k][j][i] * tExy[k][j][i] + ExSrc[k][j][i]
			  + cExy[k][j][i] * ( Hyx[k][j][i] - Hyx[k + 1][j][i] + Hyz[k][j][i] - Hyz[k + 1][j][i] );
		}
	}
}
{%- endcapture -%}

{% include template_stencil_temporal.md %}
