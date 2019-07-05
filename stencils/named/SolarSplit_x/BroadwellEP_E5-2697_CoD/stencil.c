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
			Exy[k][j][i] =
			  Exy[k][j][i] * tExy[k][j][i] + ExSrc[k][j][i]
			  + cExy[k][j][i] * ( Hyx[k][j][i] - Hyx[k + 1][j][i] + Hyz[k][j][i] - Hyz[k + 1][j][i] );
		}
	}
}
