double Exy[M][N][O][2];
double ExSrc[M][N][O][2];
double tExy[M][N][O][2];
double cExy[M][N][O][2];

// double Exz[M][N][O][2];
// double tExz[M][N][O][2];
// double cExz[M][N][O][2];

// double Eyx[M][N][O][2];
// double EySrc[M][N][O][2];
// double tEyx[M][N][O][2];
// double cEyx[M][N][O][2];

// double Eyz[M][N][O][2];
// double tEyz[M][N][O][2];
// double cEyz[M][N][O][2];

// double Ezx[M][N][O][2];
// double tEzx[M][N][O][2];
// double cEzx[M][N][O][2];

// double Ezy[M][N][O][2];
// double tEzy[M][N][O][2];
// double cEzy[M][N][O][2];

// double Hxy[M][N][O][2];
// double HxSrc[M][N][O][2];
// double tHxy[M][N][O][2];
// double cHxy[M][N][O][2];

// double Hxz[M][N][O][2];
// double tHxz[M][N][O][2];
// double cHxz[M][N][O][2];

double Hyx[M][N][O][2];
// double HySrc[M][N][O][2];
// double tHyx[M][N][O][2];
// double cHyx[M][N][O][2];

double Hyz[M][N][O][2];
// double tHyz[M][N][O][2];
// double cHyz[M][N][O][2];

// double Hzx[M][N][O][2];
// double tHzx[M][N][O][2];
// double cHzx[M][N][O][2];

// double Hzy[M][N][O][2];
// double tHzy[M][N][O][2];
// double cHzy[M][N][O][2];

double asgn, diffRe, diffIm;

for ( int k = 1; k < M - 1; ++k )
{
	for ( int j = 1; j < N - 1; ++j )
	{
		// #pragma simd
		for ( int i = 1; i < O - 1; ++i )
		{
			// ----- Ex_y = Cex_ty * Ex_y + Cex_y * (D(Hy_x + Hy_z) - T(Hy_x + Hy_z) ) + Ex_old;
			diffRe = Hyx[k][j][i][0] - Hyx[k + 1][j][i][0] + Hyz[k][j][i][0] - Hyz[k + 1][j][i][0];
			diffIm =
			  Hyx[k + 1][j][i][1] - Hyx[k + 1][j][i][1] + Hyz[k + 1][j][i][1] - Hyz[k + 1][j][i][1];

			asgn = Exy[k][j][i][0] * tExy[k][j][i][0] - Exy[k][j][i][1] * tExy[k][j][i][1]
			       + ExSrc[k][j][i][0] + cExy[k][j][i][0] * diffRe - cExy[k][j][i][1] * diffIm;
			Exy[k][j][i][1] = Exy[k][j][i][0] * tExy[k][j][i][1] + Exy[k][j][i][1] * tExy[k][j][i][0]
			                  + ExSrc[k][j][i][1] + cExy[k][j][i][0] * diffIm + cExy[k][j][i][1] * diffRe;
			Exy[k][j][i][0] = asgn;

			// // -----  Ex_z = Cex_tz * Ex_z + Cex_z * (N(Hz_x + Hz_y) - S(Hz_x + Hz_y) );
			// diffRe = Hzx[k][j + 1][2*i] - Hzx[k][j][2*i] + Hzy[k][j + 1][2*i] - Hzy[k][j][2*i];
			// diffIm = Hzx[k][j + 1][2*i + 1] - Hzx[k][j][2*i + 1] + Hzy[k][j + 1][2*i + 1] -
			// Hzy[k][j][2*i + 1];

			// asgn = Exz[k][j][2*i] * tExz[k][j][2*i] - Exz[k][j][2*i + 1] * tExz[k][j][2*i + 1]
			//        + cExz[k][j][2*i] * diffRe - cExz[k][j][2*i + 1] * diffIm;
			// Exz[k][j][2*i + 1] = Exz[k][j][2*i] * tExz[k][j][2*i + 1] + Exz[k][j][2*i + 1] *
			// tExz[k][j][2*i]
			//                    + cExz[k][j][2*i] * diffIm + cExz[k][j][2*i + 1] * diffRe;
			// Exz[k][j][2*i] = asgn;

			// // ----- Ey_x = Cey_tx * Ey_x + Cey_x * (T(Hx_y + Hx_z) - D(Hx_y + Hx_z) )   + Ey_old;
			// diffRe = Hxy[k + 1][j][2*i] - Hxy[k][j][2*i] + Hxz[k + 1][j][2*i] - Hxz[k][j][2*i];
			// diffIm = Hxy[k + 1][j][2*i + 1] - Hxy[k][j][2*i + 1] + Hxz[k + 1][j][2*i + 1] -
			// Hxz[k][j][2*i + 1];

			// asgn = Eyx[k][j][2*i] * tEyx[k][j][2*i] - Eyx[k][j][2*i + 1] * tEyx[k][j][2*i + 1] +
			// EySrc[k][j][2*i]
			//        + cEyx[k][j][2*i] * diffRe - cEyx[k][j][2*i + 1] * diffIm;
			// Eyx[k][j][2*i + 1] = Eyx[k][j][2*i] * tEyx[k][j][2*i + 1] + Eyx[k][j][2*i + 1] *
			// tEyx[k][j][2*i]
			//                    + EySrc[k][j][2*i + 1] + cEyx[k][j][2*i] * diffIm + cEyx[k][j][2*i + 1]
			//                    * diffRe;
			// Eyx[k][j][2*i] = asgn;

			// // ----- Ey_z = Cey_tz * Ey_z + Cey_z * (W(Hz_x + Hz_y) - E(Hz_x + Hz_y) );
			// diffRe = Hzx[k][j][2*i] + Hzy[k][j][2*i] - Hzx[k][j][2*i + 2] - Hzy[k][j][2*i + 2];
			// diffIm = Hzx[k][j][2*i + 1] + Hzy[k][j][2*i + 1] - Hzx[k][j][2*i + 3] - Hzy[k][j][2*i + 3];

			// asgn = Eyz[k][j][2*i] * tEyz[k][j][2*i] - Eyz[k][j][2*i + 1] * tEyz[k][j][2*i + 1]
			//        + cEyz[k][j][2*i] * diffRe - cEyz[k][j][2*i + 1] * diffIm;
			// Eyz[k][j][2*i + 1] = Eyz[k][j][2*i] * tEyz[k][j][2*i + 1] + Eyz[k][j][2*i + 1] *
			// tEyz[k][j][2*i]
			//                    + cEyz[k][j][2*i] * diffIm + cEyz[k][j][2*i + 1] * diffRe;
			// Eyz[k][j][2*i] = asgn;

			// // -----  Ez_x = Cez_tx * Ez_x + Cez_x * (S(Hx_y + Hx_z) - N(Hx_y + Hx_z) );
			// diffRe = Hxy[k][j][2*i] + Hxz[k][j][2*i] - Hxy[k][j + 1][2*i] - Hxz[k][j + 1][2*i];
			// diffIm = Hxy[k][j][2*i + 1] + Hxz[k][j][2*i + 1] - Hxy[k][j + 1][2*i + 1] - Hxz[k][j +
			// 1][2*i + 1];

			// asgn = Ezx[k][j][2*i] * tEzx[k][j][2*i] - Ezx[k][j][2*i + 1] * tEzx[k][j][2*i + 1]
			//        + cEzx[k][j][2*i] * diffRe - cEzx[k][j][2*i + 1] * diffIm;
			// Ezx[k][j][2*i + 1] = Ezx[k][j][2*i] * tEzx[k][j][2*i + 1] + Ezx[k][j][2*i + 1] *
			// tEzx[k][j][2*i]
			//                    + cEzx[k][j][2*i] * diffIm + cEzx[k][j][2*i + 1] * diffRe;
			// Ezx[k][j][2*i] = asgn;

			// // ----- Ez_y = Cez_ty * Ez_y + Cez_y * (E(Hy_x + Hy_z) - W(Hy_x + Hy_z) );
			// diffRe = Hyx[k][j][2*i + 2] - Hyx[k][j][2*i] + Hyz[k][j][2*i + 2] - Hyz[k][j][2*i];
			// diffIm = Hyx[k][j][2*i + 3] - Hyx[k][j][2*i + 1] + Hyz[k][j][2*i + 3] - Hyz[k][j][2*i + 1];

			// asgn = Ezy[k][j][2*i] * tEzy[k][j][2*i] - Ezy[k][j][2*i + 1] * tEzy[k][j][2*i + 1]
			//        + cEzy[k][j][2*i] * diffRe - cEzy[k][j][2*i + 1] * diffIm;
			// Ezy[k][j][2*i + 1] = Ezy[k][j][2*i] * tEzy[k][j][2*i + 1] + Ezy[k][j][2*i + 1] *
			// tEzy[k][j][2*i]
			//                    + cEzy[k][j][2*i] * diffIm + cEzy[k][j][2*i + 1] * diffRe;
			// Ezy[k][j][2*i] = asgn;

			// // ----- Hx_y = Chx_ty * Hx_y - Chx_y * (D(Ey_x + Ey_z) - T(Ey_x + Ey_z) )  + Hx_old;
			// diffRe = Eyx[k - 1][j][2*i] - Eyx[k][j][2*i] + Eyz[k - 1][j][2*i] - Eyz[k][j][2*i];
			// diffIm = Eyx[k - 1][j][2*i + 1] - Eyx[k][j][2*i + 1] + Eyz[k - 1][j][2*i + 1] -
			// Eyz[k][j][2*i + 1];

			// asgn = Hxy[k][j][2*i] * tHxy[k][j][2*i] - Hxy[k][j][2*i + 1] * tHxy[k][j][2*i + 1] +
			// HxSrc[k][j][2*i]
			//        - cHxy[k][j][2*i] * diffRe + cHxy[k][j][2*i + 1] * diffIm;
			// Hxy[k][j][2*i + 1] = Hxy[k][j][2*i] * tHxy[k][j][2*i + 1] + Hxy[k][j][2*i + 1] *
			// tHxy[k][j][2*i]
			//                    + HxSrc[k][j][2*i + 1] - cHxy[k][j][2*i] * diffIm - cHxy[k][j][2*i + 1]
			//                    * diffRe;
			// Hxy[k][j][2*i] = asgn;

			// // ----- Hx_z = Chx_tz * Hx_z - Chx_z * (N(Ez_x + Ez_y) - S(Ez_x + Ez_y) );
			// diffRe = Ezx[k][j][2*i] - Ezx[k][j - 1][2*i] + Ezy[k][j][2*i] - Ezy[k][j - 1][2*i];
			// diffIm = Ezx[k][j][2*i + 1] - Ezx[k][j - 1][2*i + 1] + Ezy[k][j][2*i + 1] - Ezy[k][j -
			// 1][2*i + 1];

			// asgn = Hxz[k][j][2*i] * tHxz[k][j][2*i] - Hxz[k][j][2*i + 1] * tHxz[k][j][2*i + 1]
			//        - cHxz[k][j][2*i] * diffRe + cHxz[k][j][2*i + 1] * diffIm;
			// Hxz[k][j][2*i + 1] = Hxz[k][j][2*i] * tHxz[k][j][2*i + 1] + Hxz[k][j][2*i + 1] *
			// tHxz[k][j][2*i]
			//                    - cHxz[k][j][2*i] * diffIm - cHxz[k][j][2*i + 1] * diffRe;
			// Hxz[k][j][2*i] = asgn;

			// // ----- Hy_x = Chy_tx * Hy_x - Chy_x * (T(Ex_y + Ex_z) - D(Ex_y + Ex_z) )  + Hy_old;
			// diffRe = Exy[k][j][2*i] - Exy[k - 1][j][2*i] + Exz[k][j][2*i] - Exz[k - 1][j][2*i];
			// diffIm = Exy[k][j][2*i + 1] - Exy[k - 1][j][2*i + 1] + Exz[k][j][2*i + 1] - Exz[k -
			// 1][j][2*i + 1];

			// asgn = Hyx[k][j][2*i] * tHyx[k][j][2*i] - Hyx[k][j][2*i + 1] * tHyx[k][j][2*i + 1] +
			// HySrc[k][j][2*i]
			//        - cHyx[k][j][2*i] * diffRe + cHyx[k][j][2*i + 1] * diffIm;
			// Hyx[k][j][2*i + 1] = Hyx[k][j][2*i] * tHyx[k][j][2*i + 1] + Hyx[k][j][2*i + 1] *
			// tHyx[k][j][2*i]
			//                    + HySrc[k][j][2*i + 1] - cHyx[k][j][2*i] * diffIm - cHyx[k][j][2*i + 1]
			//                    * diffRe;
			// Hyx[k][j][2*i] = asgn;
			// // ----- Hy_z = Chy_tz * Hy_z - Chy_z * (W(Ez_x + Ez_y) - E(Ez_x + Ez_y) );
			// diffRe = Ezx[k][j][2*i - 2] + Ezy[k][j][2*i - 2] - Ezx[k][j][2*i] - Ezy[k][j][2*i];
			// diffIm = Ezx[k][j][2*i - 1] + Ezy[k][j][2*i - 1] - Ezx[k][j][2*i + 1] - Ezy[k][j][2*i + 1];

			// asgn = Hyz[k][j][2*i] * tHyz[k][j][2*i] - Hyz[k][j][2*i + 1] * tHyz[k][j][2*i + 1]
			//        - cHyz[k][j][2*i] * diffRe + cHyz[k][j][2*i + 1] * diffIm;
			// Hyz[k][j][2*i + 1] = Hyz[k][j][2*i] * tHyz[k][j][2*i + 1] + Hyz[k][j][2*i + 1] *
			// tHyz[k][j][2*i]
			//                    - cHyz[k][j][2*i] * diffIm - cHyz[k][j][2*i + 1] * diffRe;
			// Hyz[k][j][2*i] = asgn;

			// // ----- Hz_x = Chz_tx * Hz_x - Chz_x * (S(Ex_y + Ex_z) - N(Ex_y + Ex_z) );
			// diffRe = Exy[k][j - 1][2*i] - Exy[k][j][2*i] + Exz[k][j - 1][2*i] - Exz[k][j][2*i];
			// diffIm = Exy[k][j - 1][2*i + 1] - Exy[k][j][2*i + 1] + Exz[k][j - 1][2*i + 1] -
			// Exz[k][j][2*i + 1];

			// asgn = Hzx[k][j][2*i] * tHzx[k][j][2*i] - Hzx[k][j][2*i + 1] * tHzx[k][j][2*i + 1]
			//        - cHzx[k][j][2*i] * diffRe + cHzx[k][j][2*i + 1] * diffIm;
			// Hzx[k][j][2*i + 1] = Hzx[k][j][2*i] * tHzx[k][j][2*i + 1] + Hzx[k][j][2*i + 1] *
			// tHzx[k][j][2*i]
			//                    - cHzx[k][j][2*i] * diffIm - cHzx[k][j][2*i + 1] * diffRe;
			// Hzx[k][j][2*i] = asgn;

			// // ----- Hz_y = Chz_ty * Hz_y - Chz_y * (E(Ey_x + Ey_z) - W(Ey_x + Ey_z) );
			// diffRe = Eyx[k][j][2*i] - Eyx[k][j][2*i - 2] + Eyz[k][j][2*i] - Eyz[k][j][2*i - 2];
			// diffIm = Eyx[k][j][2*i + 1] - Eyx[k][j][2*i - 1] + Eyz[k][j][2*i + 1] - Eyz[k][j][2*i - 1];

			// asgn = Hzy[k][j][2*i] * tHzy[k][j][2*i] - Hzy[k][j][2*i + 1] * tHzy[k][j][2*i + 1]
			//        - cHzy[k][j][2*i] * diffRe + cHzy[k][j][2*i + 1] * diffIm;
			// Hzy[k][j][2*i + 1] = Hzy[k][j][2*i] * tHzy[k][j][2*i + 1] + Hzy[k][j][2*i + 1] *
			// tHzy[k][j][2*i]
			//                    - cHzy[k][j][2*i] * diffIm - cHzy[k][j][2*i + 1] * diffRe;
			// Hzy[k][j][2*i] = asgn;
		}
	}
}
