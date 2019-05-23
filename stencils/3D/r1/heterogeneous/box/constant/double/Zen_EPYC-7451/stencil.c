double a[M][N][P];
double b[M][N][P];
double c0;
double c1;
double c2;
double c3;
double c4;
double c5;
double c6;
double c7;
double c8;
double c9;
double c10;
double c11;
double c12;
double c13;
double c14;
double c15;
double c16;
double c17;
double c18;
double c19;
double c20;
double c21;
double c22;
double c23;
double c24;
double c25;
double c26;

for(long k=1; k < M-1; ++k){
for(long j=1; j < N-1; ++j){
for(long i=1; i < P-1; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * a[k-1][j-1][i-1]
+ c2 * a[k][j-1][i-1]
+ c3 * a[k+1][j-1][i-1]
+ c4 * a[k-1][j][i-1]
+ c5 * a[k][j][i-1]
+ c6 * a[k+1][j][i-1]
+ c7 * a[k-1][j+1][i-1]
+ c8 * a[k][j+1][i-1]
+ c9 * a[k+1][j+1][i-1]
+ c10 * a[k-1][j-1][i]
+ c11 * a[k][j-1][i]
+ c12 * a[k+1][j-1][i]
+ c13 * a[k-1][j][i]
+ c14 * a[k+1][j][i]
+ c15 * a[k-1][j+1][i]
+ c16 * a[k][j+1][i]
+ c17 * a[k+1][j+1][i]
+ c18 * a[k-1][j-1][i+1]
+ c19 * a[k][j-1][i+1]
+ c20 * a[k+1][j-1][i+1]
+ c21 * a[k-1][j][i+1]
+ c22 * a[k][j][i+1]
+ c23 * a[k+1][j][i+1]
+ c24 * a[k-1][j+1][i+1]
+ c25 * a[k][j+1][i+1]
+ c26 * a[k+1][j+1][i+1]
;
}
}
}
