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

for(int k=1; k < M-1; ++k){
for(int j=1; j < N-1; ++j){
for(int i=1; i < P-1; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * (a[k][j][i-1] + a[k][j][i+1])
+ c2 * (a[k][j-1][i] + a[k][j+1][i])
+ c3 * (a[k-1][j][i] + a[k+1][j][i])
+ c4 * (a[k][j-1][i-1] + a[k][j+1][i+1])
+ c5 * (a[k-1][j][i-1] + a[k+1][j][i+1])
+ c6 * (a[k+1][j][i-1] + a[k-1][j][i+1])
+ c7 * (a[k][j+1][i-1] + a[k][j-1][i+1])
+ c8 * (a[k-1][j-1][i] + a[k+1][j+1][i])
+ c9 * (a[k+1][j-1][i] + a[k-1][j+1][i])
+ c10 * (a[k-1][j-1][i-1] + a[k+1][j+1][i+1])
+ c11 * (a[k+1][j-1][i-1] + a[k-1][j+1][i+1])
+ c12 * (a[k-1][j+1][i-1] + a[k+1][j-1][i+1])
+ c13 * (a[k+1][j+1][i-1] + a[k-1][j-1][i+1])
;
}
}
}
