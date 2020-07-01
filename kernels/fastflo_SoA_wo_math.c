double unknowns[4][L][M][N];
double rhs[4][L][M][N];

double csoun;
double clapl;
double reyf0;
double epsvi;
double cpres;
double cvelo;
double c05di;
double c05gr;
double cadvp;
double cadve;
double cadvv;
double vi0la;
double refac;
double kernelfacs[4];

//kernel variables
double prxm2, uvxm2, vvxm2, wvxm2;
double prym2, uvym2, vvym2, wvym2;
double przm2, uvzm2, vvzm2, wvzm2;

double prxm1, uvxm1, vvxm1, wvxm1;
double prym1, uvym1, vvym1, wvym1;
double przm1, uvzm1, vvzm1, wvzm1;

double pr000, uv000, vv000, wv000;

double prxp2, uvxp2, vvxp2, wvxp2;
double pryp2, uvyp2, vvyp2, wvyp2;
double przp2, uvzp2, vvzp2, wvzp2;

double prxp1, uvxp1, vvxp1, wvxp1;
double pryp1, uvyp1, vvyp1, wvyp1;
double przp1, uvzp1, vvzp1, wvzp1;


double uved1, flu1p, flu1u, flu1v, flu1w;
double vmax1, dte1p, dte1v, fav1p, fav1u, fav1v, fav1w;

double uved2, flu2p, flu2u, flu2v, flu2w;
double vmax2, dte2p, dte2v, fav2p, fav2u, fav2v, fav2w;

double vved3, flu3p, flu3u, flu3v, flu3w;
double vmax3, dte3p, dte3v, fav3p, fav3u, fav3v, fav3w;

double vved4, flu4p, flu4u, flu4v, flu4w;
double vmax4, dte4p, dte4v, fav4p, fav4u, fav4v, fav4w;

double wved5, flu5p, flu5u, flu5v, flu5w;
double vmax5, dte5p, dte5v, fav5p, fav5u, fav5v, fav5w;

double wved6, flu6p, flu6u, flu6v, flu6w;
double vmax6, dte6p, dte6v, fav6p, fav6u, fav6v, fav6w;

double timeintfac;
/*************** "main" loop ****************/
for (int k=2; k<L-2; ++k)
{
    for (int j=2; j<M-2; ++j)
    {
#pragma simd vectorlength(4)
        for (int i=2; i<N-2; ++i)
        {
            /* get primaries from array */
            prxm2 = unknowns[0][k][j][i-2];//*(unknowns0 + blkpr + jxm2);
            uvxm2 = unknowns[1][k][j][i-2]; //*(unknowns0 + blkuv + jxm2);
            vvxm2 = unknowns[2][k][j][i-2];//*(unknowns0 + blkvv + jxm2);
            wvxm2 = unknowns[3][k][j][i-2];//*(unknowns0 + blkwv + jxm2);
            prym2 = unknowns[0][k][j-2][i];//*(unknowns0 + blkpr + jym2);
            uvym2 = unknowns[1][k][j-2][i];//*(unknowns0 + blkuv + jym2);
            vvym2 = unknowns[2][k][j-2][i];//*(unknowns0 + blkvv + jym2);
            wvym2 = unknowns[3][k][j-2][i];//*(unknowns0 + blkwv + jym2);
            przm2 = unknowns[0][k-2][j][i];//*(unknowns0 + blkpr + jzm2);
            uvzm2 = unknowns[1][k-2][j][i];//*(unknowns0 + blkuv + jzm2);
            vvzm2 = unknowns[2][k-2][j][i];//*(unknowns0 + blkvv + jzm2);
            wvzm2 = unknowns[3][k-2][j][i];//*(unknowns0 + blkwv + jzm2);

            prxm1 = unknowns[0][k][j][i-1];//*(unknowns0 + blkpr + jxm1);
            uvxm1 = unknowns[1][k][j][i-1]; //*(unknowns0 + blkuv + jxm1);
            vvxm1 = unknowns[2][k][j][i-1];//*(unknowns0 + blkvv + jxm1);
            wvxm1 = unknowns[3][k][j][i-1];//*(unknowns0 + blkwv + jxm1);
            prym1 = unknowns[0][k][j-1][i];//*(unknowns0 + blkpr + jym1);
            uvym1 = unknowns[1][k][j-1][i];//*(unknowns0 + blkuv + jym2);
            vvym1 = unknowns[2][k][j-1][i];//*(unknowns0 + blkvv + jym2);
            wvym1 = unknowns[3][k][j-1][i];//*(unknowns0 + blkwv + jym2);
            przm1 = unknowns[0][k-1][j][i];//*(unknowns0 + blkpr + jzm2);
            uvzm1 = unknowns[1][k-1][j][i];//*(unknowns0 + blkuv + jzm2);
            vvzm1 = unknowns[2][k-1][j][i];//*(unknowns0 + blkvv + jzm2);
            wvzm1 = unknowns[3][k-1][j][i];//*(unknowns0 + blkwv + jzm2);

            pr000 = unknowns[0][k][j][i];//*(unknowns0 + blkpr + i);
            uv000 = unknowns[1][k][j][i];//*(unknowns0 + blkuv + i);
            vv000 = unknowns[2][k][j][i];//*(unknowns0 + blkvv + i);
            wv000 = unknowns[3][k][j][i];//*(unknowns0 + blkwv + i);

            prxp1 = unknowns[0][k][j][i+1];//*(unknowns0 + blkpr + jxm1);
            uvxp1 = unknowns[1][k][j][i+1]; //*(unknowns0 + blkuv + jxm1);
            vvxp1 = unknowns[2][k][j][i+1];//*(unknowns0 + blkvv + jxm1);
            wvxp1 = unknowns[3][k][j][i+1];//*(unknowns0 + blkwv + jxm1);
            pryp1 = unknowns[0][k][j+1][i];//*(unknowns0 + blkpr + jym1);
            uvyp1 = unknowns[1][k][j+1][i];//*(unknowns0 + blkuv + jym2);
            vvyp1 = unknowns[2][k][j+1][i];//*(unknowns0 + blkvv + jym2);
            wvyp1 = unknowns[3][k][j+1][i];//*(unknowns0 + blkwv + jym2);
            przp1 = unknowns[0][k+1][j][i];//*(unknowns0 + blkpr + jzm2);
            uvzp1 = unknowns[1][k+1][j][i];//*(unknowns0 + blkuv + jzm2);
            vvzp1 = unknowns[2][k+1][j][i];//*(unknowns0 + blkvv + jzm2);
            wvzp1 = unknowns[3][k+1][j][i];//*(unknowns0 + blkwv + jzm2);

            prxp2 = unknowns[0][k][j][i+2];//*(unknowns0 + blkpr + jxm1);
            uvxp2 = unknowns[1][k][j][i+2]; //*(unknowns0 + blkuv + jxm1);
            vvxp2 = unknowns[2][k][j][i+2];//*(unknowns0 + blkvv + jxm1);
            wvxp2 = unknowns[3][k][j][i+2];//*(unknowns0 + blkwv + jxm1);
            pryp2 = unknowns[0][k][j+2][i];//*(unknowns0 + blkpr + jym1);
            uvyp2 = unknowns[1][k][j+2][i];//*(unknowns0 + blkuv + jym2);
            vvyp2 = unknowns[2][k][j+2][i];//*(unknowns0 + blkvv + jym2);
            wvyp2 = unknowns[3][k][j+2][i];//*(unknowns0 + blkwv + jym2);
            przp2 = unknowns[0][k+2][j][i];//*(unknowns0 + blkpr + jzm2);
            uvzp2 = unknowns[1][k+2][j][i];//*(unknowns0 + blkuv + jzm2);
            vvzp2 = unknowns[2][k+2][j][i];//*(unknowns0 + blkvv + jzm2);
            wvzp2 = unknowns[3][k+2][j][i];//*(unknowns0 + blkwv + jzm2);

            /* -----edge 1: x_{i-1}:x_{i} */
            uved1 = uvxm1 + uv000;
            flu1p =        uvxm1 + uv000;
            flu1u = uved1*(uvxm1 + uv000);
            flu1v = uved1*(vvxm1 + vv000);
            flu1w = uved1*(wvxm1 + wv000);

            vmax1 = uvxm1;//fmax((uvxm1), (uv000));
            dte1p = cpres / (csoun + vmax1);
            dte1v = cvelo * vmax1 * ((refac * vmax1 - 1.0));
            fav1p = dte1p * (-prxp1 + 3.0 * (pr000 - prxm1) + prxm2);
            fav1u = dte1v * (-uvxp1 + 3.0 * (uv000 - uvxm1) + uvxm2);
            fav1v = dte1v * (-vvxp1 + 3.0 * (vv000 - vvxm1) + vvxm2);
            fav1w = dte1v * (-wvxp1 + 3.0 * (wv000 - wvxm1) + wvxm2);

            /* -----edge 2: x_{i}:x_{i+1} */
            uved2 = uv000 + uvxp1;
            flu2p =          uv000 + uvxp1;
            flu2u = uved2 * (uv000 + uvxp1);
            flu2v = uved2 * (vv000 + vvxp1);
            flu2w = uved2 * (wv000 + wvxp1);

            vmax2 = uv000;//fmax((uv000), (uvxp1));
            dte2p = cpres / (csoun + vmax2);
            dte2v = cvelo * vmax2 * ((refac * vmax2 - 1.0));
            fav2p = dte2p * (-prxp2 + 3.0 * (prxp1 - pr000) + prxm1);
            fav2u = dte2v * (-uvxp2 + 3.0 * (uvxp1 - uv000) + uvxm1);
            fav2v = dte2v * (-vvxp2 + 3.0 * (vvxp1 - vv000) + vvxm1);
            fav2w = dte2v * (-wvxp2 + 3.0 * (wvxp1 - wv000) + wvxm1);

            /* -----edge 3: y_{i-1}:y_{i} */

            vved3 = vvym1 + vv000;
            flu3p =          vvym1 + vv000;
            flu3u = vved3 * (uvym1 + uv000);
            flu3v = vved3 * (vvym1 + vv000);
            flu3w = vved3 * (wvym1 + wv000);

            vmax3 = vvym1;//fmax((vvym1), (vv000));
            dte3p = cpres / (csoun + vmax3);
            dte3v = cvelo * vmax3 * ((refac * vmax3 - 1.0));
            fav3p = dte3p * ( - pryp1 + 3.0 * (pr000 - prym1) + prym2);
            fav3u = dte3v * ( - uvyp1 + 3.0 * (uv000 - uvym1) + uvym2);
            fav3v = dte3v * ( - vvyp1 + 3.0 * (vv000 - vvym1) + vvym2);
            fav3w = dte3v * ( - wvyp1 + 3.0 * (wv000 - wvym1) + wvym2);

            /* -----edge 4: y_{i}:y_{i+1} */
            vved4 = vv000 + vvyp1;
            flu4p =          vv000 + vvyp1;
            flu4u = vved4 * (uv000 + uvyp1);
            flu4v = vved4 * (vv000 + vvyp1);
            flu4w = vved4 * (wv000 + wvyp1);

            vmax4 = vv000;//fmax((vv000), (vvyp1));
            dte4p = cpres / (csoun + vmax4);
            dte4v = cvelo * vmax4 * ((refac * vmax4 - 1.0));
            fav4p = dte4p * ( - pryp2 + 3.0 * (pryp1 - pr000) + prym1);
            fav4u = dte4v * ( - uvyp2 + 3.0 * (uvyp1 - uv000) + uvym1);
            fav4v = dte4v * ( - vvyp2 + 3.0 * (vvyp1 - vv000) + vvym1);
            fav4w = dte4v * ( - wvyp2 + 3.0 * (wvyp1 - wv000) + wvym1);

            /* -----edge 5: z_{i-1}:z_{i} */
            wved5 = wvzm1 + wv000;
            flu5p =          wvzm1 + wv000;
            flu5u = wved5 * (uvzm1 + uv000);
            flu5v = wved5 * (vvzm1 + vv000);
            flu5w = wved5 * (wvzm1 + wv000);

            vmax5 = wvzm1;//fmax((wvzm1), (wv000));
            dte5p = cpres / (csoun + vmax5);
            dte5v = cvelo * vmax5 * ((refac * vmax5 - 1.0));
            fav5p = dte5p * ( - przp1 + 3.0 * (pr000 - przm1) + przm2);
            fav5u = dte5v * ( - uvzp1 + 3.0 * (uv000 - uvzm1) + uvzm2);
            fav5v = dte5v * ( - vvzp1 + 3.0 * (vv000 - vvzm1) + vvzm2);
            fav5w = dte5v * ( - wvzp1 + 3.0 * (wv000 - wvzm1) + wvzm2);

            /* -----edge 6: z_{i}:z_{i+1} */
            wved6 = wv000 + wvzp1;
            flu6p =          wv000 + wvzp1;
            flu6u = wved6 * (uv000 + uvzp1);
            flu6v = wved6 * (vv000 + vvzp1);
            flu6w = wved6 * (wv000 + wvzp1);

            vmax6 = wv000;//fmax((wv000), (wvzp1));
            dte6p = cpres / (csoun + vmax6);
            dte6v = cvelo * vmax6 * (( refac * vmax6 - 1.0));
            fav6p = dte6p * ( - przp2 + 3.0 * (przp1 - pr000) + przm1);
            fav6u = dte6v * ( - uvzp2 + 3.0 * (uvzp1 - uv000) + uvzm1);
            fav6v = dte6v * ( - vvzp2 + 3.0 * (vvzp1 - vv000) + vvzm1);
            fav6w = dte6v * ( - wvzp2 + 3.0 * (wvzp1 - wv000) + wvzm1);

            /* -----add to the rhs */
            rhs[0][k][j][i] = timeintfac * rhs[0][k][j][i] + kernelfacs[0] * (
                    c05di * (flu2p - flu1p + flu4p - flu3p + flu6p - flu5p)
                    + cadvp * (fav2p - fav1p + fav4p - fav3p + fav6p - fav5p));
            rhs[1][k][j][i] = timeintfac * rhs[1][k][j][i] + kernelfacs[1] * (
                    cadve * (flu2u - flu1u + flu4u - flu3u + flu6u - flu5u)
                    + c05gr * (prxp1 - prxm1)
                    + cadvv * (fav2u - fav1u + fav4u - fav3u + fav6u - fav5u)
                    + vi0la * (uvzp1 + uvyp1 + uvxp1 -   6.0 * uv000 + uvzm1 + uvym1 + uvxm1));
            rhs[2][k][j][i] = timeintfac * rhs[2][k][j][i] + kernelfacs[2] * (
                    cadve * (flu2v - flu1v + flu4v - flu3v + flu6v - flu5v)
                    + c05gr * (pryp1 - prym1)
                    + cadvv * (fav2v - fav1v + fav4v - fav3v + fav6v - fav5v)
                    + vi0la * (vvzp1 + vvyp1 + vvxp1 -   6.0 * vv000 + vvzm1 + vvym1 + vvxm1));
            rhs[3][k][j][i] = timeintfac * rhs[3][k][j][i] + kernelfacs[3] * (
                    cadve * (flu2w - flu1w + flu4w - flu3w + flu6w - flu5w)
                    + c05gr * (przp1 - przm1)
                    + cadvv * (fav2w - fav1w + fav4w - fav3w + fav6w - fav5w)
                    + vi0la * (wvzp1 + wvyp1 + wvxp1 -   6.0 * wv000 + wvzm1 + wvym1 + wvxm1));
        }
    }
}
