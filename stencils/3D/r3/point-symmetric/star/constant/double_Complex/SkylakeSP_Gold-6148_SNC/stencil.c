double _Complex a[M][N][P];
double _Complex b[M][N][P];
double _Complex c0;
double _Complex c1;
double _Complex c2;
double _Complex c3;
double _Complex c4;
double _Complex c5;
double _Complex c6;
double _Complex c7;
double _Complex c8;
double _Complex c9;

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * (a[k][j][i-1] + a[k][j][i+1])
+ c2 * (a[k-1][j][i] + a[k+1][j][i])
+ c3 * (a[k][j-1][i] + a[k][j+1][i])
+ c4 * (a[k][j][i-2] + a[k][j][i+2])
+ c5 * (a[k-2][j][i] + a[k+2][j][i])
+ c6 * (a[k][j-2][i] + a[k][j+2][i])
+ c7 * (a[k][j][i-3] + a[k][j][i+3])
+ c8 * (a[k-3][j][i] + a[k+3][j][i])
+ c9 * (a[k][j-3][i] + a[k][j+3][i])
;
}
}
}
