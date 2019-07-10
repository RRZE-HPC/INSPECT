double _Complex a[M][N][P];
double _Complex b[M][N][P];
double _Complex c0;
double _Complex c1;
double _Complex c2;
double _Complex c3;
double _Complex c4;
double _Complex c5;
double _Complex c6;
double _Complex c7;
double _Complex c8;
double _Complex c9;
double _Complex c10;
double _Complex c11;
double _Complex c12;
double _Complex c13;
double _Complex c14;
double _Complex c15;
double _Complex c16;
double _Complex c17;
double _Complex c18;

for(long k=3; k < M-3; ++k){
for(long j=3; j < N-3; ++j){
for(long i=3; i < P-3; ++i){
b[k][j][i] = c0 * a[k][j][i]
+ c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
+ c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
+ c5 * a[k][j-1][i] + c6 * a[k][j+1][i]
+ c7 * a[k][j][i-2] + c8 * a[k][j][i+2]
+ c9 * a[k-2][j][i] + c10 * a[k+2][j][i]
+ c11 * a[k][j-2][i] + c12 * a[k][j+2][i]
+ c13 * a[k][j][i-3] + c14 * a[k][j][i+3]
+ c15 * a[k-3][j][i] + c16 * a[k+3][j][i]
+ c17 * a[k][j-3][i] + c18 * a[k][j+3][i]
;
}
}
}
