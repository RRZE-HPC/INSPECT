double a[M1][K];
double b[K][N2][N1];
double c[M1][N1][N2];
double s;

for(int m1=1; m1<M1-1; ++m1)
    for(int n1=1; n1<N1-1; ++n1)
        for(int n2=1; n2<N2-1; ++n2)
            for(int k=1; k<K-1; ++k)
                c[m1][n1][n2] += a[m1][k] + b[k][n2][n1];

