double Ezx[M][N][2 * O];
double Ezy[M][N][2 * O];

double Hyz[M][N][2 * O];
double tHyz[M][N][2 * O];
double cHyz[M][N][2 * O];

double asgn, diffRe, diffIm;

for ( int k = 1; k < M - 1; ++k )
{
	for ( int j = 1; j < N - 1; ++j )
	{
		for ( int i = 1; i < O - 1; ++i )
		{
			// ----- Hy_z = Chy_tz * Hy_z - Chy_z * (W(Ez_x + Ez_y) - E(Ez_x + Ez_y) );
			diffRe = Ezx[k][j][2 * i - 2] + Ezy[k][j][2 * i - 2] - Ezx[k][j][2 * i] - Ezy[k][j][2 * i];
			diffIm =
			  Ezx[k][j][2 * i - 1] + Ezy[k][j][2 * i - 1] - Ezx[k][j][2 * i + 1] - Ezy[k][j][2 * i + 1];

			asgn = Hyz[k][j][2 * i] * tHyz[k][j][2 * i] - Hyz[k][j][2 * i + 1] * tHyz[k][j][2 * i + 1]
			       - cHyz[k][j][2 * i] * diffRe + cHyz[k][j][2 * i + 1] * diffIm;
			Hyz[k][j][2 * i + 1] = Hyz[k][j][2 * i] * tHyz[k][j][2 * i + 1]
			                       + Hyz[k][j][2 * i + 1] * tHyz[k][j][2 * i] - cHyz[k][j][2 * i] * diffIm
			                       - cHyz[k][j][2 * i + 1] * diffRe;
			Hyz[k][j][2 * i] = asgn;
		}
	}
}
