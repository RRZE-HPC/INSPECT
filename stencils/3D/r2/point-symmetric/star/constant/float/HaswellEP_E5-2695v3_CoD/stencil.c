float a[M][N][P];
float b[M][N][P];
float c0;
float c1;
float c2;
float c3;
float c4;
float c5;
float c6;

for(long k=2; k < M-2; ++k){
for(long j=2; j < N-2; ++j){
for(long i=2; i < P-2; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * (a[k][j][i-1] + a[k][j][i+1])
+ c2 * (a[k-1][j][i] + a[k+1][j][i])
+ c3 * (a[k][j-1][i] + a[k][j+1][i])
+ c4 * (a[k][j][i-2] + a[k][j][i+2])
+ c5 * (a[k-2][j][i] + a[k+2][j][i])
+ c6 * (a[k][j-2][i] + a[k][j+2][i])
;
}
}
}
