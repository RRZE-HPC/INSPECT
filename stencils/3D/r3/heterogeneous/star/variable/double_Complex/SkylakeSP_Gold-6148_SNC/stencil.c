double _Complex a[M][N][P];
double _Complex b[M][N][P];
double _Complex W[19][M][N][P];

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = W[0][k][j][i] * a[k][j][i]
+ W[1][k][j][i] * a[k][j][i-1] + W[2][k][j][i] * a[k][j][i+1]
+ W[3][k][j][i] * a[k-1][j][i] + W[4][k][j][i] * a[k+1][j][i]
+ W[5][k][j][i] * a[k][j-1][i] + W[6][k][j][i] * a[k][j+1][i]
+ W[7][k][j][i] * a[k][j][i-2] + W[8][k][j][i] * a[k][j][i+2]
+ W[9][k][j][i] * a[k-2][j][i] + W[10][k][j][i] * a[k+2][j][i]
+ W[11][k][j][i] * a[k][j-2][i] + W[12][k][j][i] * a[k][j+2][i]
+ W[13][k][j][i] * a[k][j][i-3] + W[14][k][j][i] * a[k][j][i+3]
+ W[15][k][j][i] * a[k-3][j][i] + W[16][k][j][i] * a[k+3][j][i]
+ W[17][k][j][i] * a[k][j-3][i] + W[18][k][j][i] * a[k][j+3][i]
;
}
}
}
