// See LICENSE for license details.

void dgemm_remainder( int n, double A[], double B[], double C[] )
{
  int j, k;
  double c0;
  double b0, b1, b2, b3;
  double a00, a01, a02, a03;

  for (k = 0 ; k < n ; k += 1) {
    c0 = C[k]; // C[i][k]
    for (j = 0 ; j < n/4*4 ; j += 4) {
      b0 = B[(j+0)*n + k]; // B[j][k]
      b1 = B[(j+1)*n + k]; // B[j+1][k]
      b2 = B[(j+2)*n + k]; // B[j+2][k]
      b3 = B[(j+3)*n + k]; // B[j+3][k]
 
      a00 = A[j+0]; // A[i][j]
      a01 = A[j+1]; // A[i][j+1]
      a02 = A[j+2]; // A[i][j+2]
      a03 = A[j+3]; // A[i][j+3]

      // C[i][k] = sum_j{A[i][j]*B[j][k]}
      c0 += a00 * b0 + a01 * b1 + a02 * b2 + a03 * b3;
    }

    for (j = n/4*4 ; j < n ; j ++) {
      b0 = B[j*n + k]; // B[j][k]
      a00 = A[j]; // A[i][j]
      c0 += a00 * b0;
    }
    C[k] = c0; // C[i][k]
  }
}
