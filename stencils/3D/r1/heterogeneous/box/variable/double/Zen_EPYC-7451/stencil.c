double a[M][N][P];
double b[M][N][P];
double W[27][M][N][P];

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = W[0][k][j][i] * a[k][j][i]
+ W[1][k][j][i] * a[k-1][j-1][i-1]
+ W[2][k][j][i] * a[k][j-1][i-1]
+ W[3][k][j][i] * a[k+1][j-1][i-1]
+ W[4][k][j][i] * a[k-1][j][i-1]
+ W[5][k][j][i] * a[k][j][i-1]
+ W[6][k][j][i] * a[k+1][j][i-1]
+ W[7][k][j][i] * a[k-1][j+1][i-1]
+ W[8][k][j][i] * a[k][j+1][i-1]
+ W[9][k][j][i] * a[k+1][j+1][i-1]
+ W[10][k][j][i] * a[k-1][j-1][i]
+ W[11][k][j][i] * a[k][j-1][i]
+ W[12][k][j][i] * a[k+1][j-1][i]
+ W[13][k][j][i] * a[k-1][j][i]
+ W[14][k][j][i] * a[k+1][j][i]
+ W[15][k][j][i] * a[k-1][j+1][i]
+ W[16][k][j][i] * a[k][j+1][i]
+ W[17][k][j][i] * a[k+1][j+1][i]
+ W[18][k][j][i] * a[k-1][j-1][i+1]
+ W[19][k][j][i] * a[k][j-1][i+1]
+ W[20][k][j][i] * a[k+1][j-1][i+1]
+ W[21][k][j][i] * a[k-1][j][i+1]
+ W[22][k][j][i] * a[k][j][i+1]
+ W[23][k][j][i] * a[k+1][j][i+1]
+ W[24][k][j][i] * a[k-1][j+1][i+1]
+ W[25][k][j][i] * a[k][j+1][i+1]
+ W[26][k][j][i] * a[k+1][j+1][i+1]
;
}
}
}
