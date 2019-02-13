float a[M][N][P];
float b[M][N][P];
float c0;
float c1;
float c2;
float c3;
float c4;
float c5;
float c6;
float c7;
float c8;
float c9;
float c10;
float c11;
float c12;

for(long k=2; k < M-2; ++k){
for(long j=2; j < N-2; ++j){
for(long i=2; i < P-2; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
+ c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
+ c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
+ c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
+ c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
+ c11 * a[k][j-2][i] + c12 * a[k][j+2][i]
;
}
}
}
