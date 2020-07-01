double u1[N*N*N];
double d1[N*N*N];
double xx[N*N*N];
double xy[N*N*N];
double xz[N*N*N];
double c1, c2, d;

for(int k=2; k<N-2; k++) {
    for(int j=2; j<N-2; j++) {
        for(int i=2; i<N-2; i++) {
            d = 0.25*(d1[k*N*N     + j*N + i] + d1[k*N*N     + (j-1)*N + i]
                    + d1[(k-1)*N*N + j*N + i] + d1[(k-1)*N*N + (j-1)*N + i]);
            u1[k*N*N + j*N + i] = u1[k*N*N + j*N + i] + (dth/d)
             * ( c1*(xx[k*N*N     + j*N     + i]   - xx[k*N*N     + j*N     + i-1])
               + c2*(xx[k*N*N     + j*N     + i+1] - xx[k*N*N     + j*N     + i-2])
               + c1*(xy[k*N*N     + j*N     + i]   - xy[k*N*N     + (j-1)*N + i])
               + c2*(xy[k*N*N     + (j+1)*N + i]   - xy[k*N*N     + (j-2)*N + i])
               + c1*(xz[k*N*N     + j*N     + i]   - xz[(k-1)*N*N + j*N     + i])
               + c2*(xz[(k+1)*N*N + j*N     + i]   - xz[(k-2)*N*N + j*N     + i]));
}}}
