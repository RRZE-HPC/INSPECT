double a[M][N][P];
double b[M][N][P];
double c0;
double c1;
double c2;
double c3;

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * (a[k][j][i-1] + a[k][j-1][i] + a[k-1][j][i] + a[k+1][j][i] + a[k][j+1][i] + a[k][j][i+1])
+ c2 * (a[k][j-1][i-1] + a[k-1][j][i-1] + a[k+1][j][i-1] + a[k][j+1][i-1] + a[k-1][j-1][i] + a[k+1][j-1][i] + a[k-1][j+1][i] + a[k+1][j+1][i] + a[k][j-1][i+1] + a[k-1][j][i+1] + a[k+1][j][i+1] + a[k][j+1][i+1])
+ c3 * (a[k-1][j-1][i-1] + a[k+1][j-1][i-1] + a[k-1][j+1][i-1] + a[k+1][j+1][i-1] + a[k-1][j-1][i+1] + a[k+1][j-1][i+1] + a[k-1][j+1][i+1] + a[k+1][j+1][i+1])
;
}
}
}
