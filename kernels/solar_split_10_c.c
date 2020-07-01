double _Complex Ezx[M][N][O];
double _Complex Ezy[M][N][O];

double _Complex Hyz[M][N][O];
double _Complex tHyz[M][N][O];
double _Complex cHyz[M][N][O];

for ( int k = 1; k < M - 1; ++k )
{
	for ( int j = 1; j < N - 1; ++j )
	{
		for ( int i = 1; i < O - 1; ++i )
		{
			// ----- Hy_z = Chy_tz * Hy_z - Chy_z * (W(Ez_x + Ez_y) - E(Ez_x + Ez_y) );
			Hyz[k][j][i] =
			  Hyz[k][j][i] * tHyz[k][j][i]
			  - cHyz[k][j][i] * ( Ezx[k][j][i - 1] + Ezx[k][j][i - 1] - Ezx[k][j][i] + Ezx[k][j][i] );
		}
	}
}