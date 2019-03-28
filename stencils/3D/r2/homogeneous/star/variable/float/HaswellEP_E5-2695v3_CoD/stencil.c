float a[M][N][P];
float b[M][N][P];
float W[1][M][N][P];

for(long k=2; k < M-2; ++k){
for(long j=2; j < N-2; ++j){
for(long i=2; i < P-2; ++i){
b[k][j][i] = W[0][k][j][i] * (a[k][j][i]
+ a[k][j][i-1] + a[k][j][i+1]
+ a[k-1][j][i] + a[k+1][j][i]
+ a[k][j-1][i] + a[k][j+1][i]
+ a[k][j][i-2] + a[k][j][i+2]
+ a[k-2][j][i] + a[k+2][j][i]
+ a[k][j-2][i] + a[k][j+2][i]
);
}
}
}
