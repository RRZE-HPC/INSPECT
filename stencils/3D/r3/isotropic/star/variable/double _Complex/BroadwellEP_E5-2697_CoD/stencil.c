double _Complex a[M][N][P];
double _Complex b[M][N][P];
double _Complex W[4][M][N][P];

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = W[0][k][j][i] * a[k][j][i]
+ W[1][k][j][i] * ((a[k][j][i-1] + a[k][j][i+1]) + (a[k-1][j][i] + a[k+1][j][i]) + (a[k][j-1][i] + a[k][j+1][i]))
+ W[2][k][j][i] * ((a[k][j][i-2] + a[k][j][i+2]) + (a[k-2][j][i] + a[k+2][j][i]) + (a[k][j-2][i] + a[k][j+2][i]))
+ W[3][k][j][i] * ((a[k][j][i-3] + a[k][j][i+3]) + (a[k-3][j][i] + a[k+3][j][i]) + (a[k][j-3][i] + a[k][j+3][i]))
;
}
}
}
