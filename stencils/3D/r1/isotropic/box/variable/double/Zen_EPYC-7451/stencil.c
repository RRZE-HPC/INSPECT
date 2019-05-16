double a[M][N][P];
double b[M][N][P];
double W[4][M][N][P];

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = W[0][k][j][i] * a[k][j][i]
+ W[1][k][j][i] * (a[k][j][i-1] + a[k][j-1][i] + a[k-1][j][i] + a[k+1][j][i] + a[k][j+1][i] + a[k][j][i+1])
+ W[2][k][j][i] * (a[k][j-1][i-1] + a[k-1][j][i-1] + a[k+1][j][i-1] + a[k][j+1][i-1] + a[k-1][j-1][i] + a[k+1][j-1][i] + a[k-1][j+1][i] + a[k+1][j+1][i] + a[k][j-1][i+1] + a[k-1][j][i+1] + a[k+1][j][i+1] + a[k][j+1][i+1])
+ W[3][k][j][i] * (a[k-1][j-1][i-1] + a[k+1][j-1][i-1] + a[k-1][j+1][i-1] + a[k+1][j+1][i-1] + a[k-1][j-1][i+1] + a[k+1][j-1][i+1] + a[k-1][j+1][i+1] + a[k+1][j+1][i+1])
;
}
}
}
