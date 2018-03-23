// See LICENSE for license details.

void dgemm_inner( int n, double A[], double B[], double C[] )
{
  int j, k;
  double c0, c1, c2, c3;
  double b0, b1, b2, b3;
  double a00, a01, a02, a03;
  double a10, a11, a12, a13;
  double a20, a21, a22, a23;
  double a30, a31, a32, a33;

  for (k = 0 ; k < n ; k += 1) {
    c0 = C[k]; // C[i][k]
    c1 = C[n + k]; // C[i+1][k]
    c2 = C[2*n + k]; // C[i+2][k]
    c3 = C[3*n + k]; // C[i+3][k]
    for (j = 0 ; j < n/4*4 ; j += 4) {
      b0 = B[(j+0)*n + k]; // B[j][k]
      b1 = B[(j+1)*n + k]; // B[j+1][k]
      b2 = B[(j+2)*n + k]; // B[j+2][k]
      b3 = B[(j+3)*n + k]; // B[j+3][k]
 
      a00 = A[j+0]; // A[i][j]
      a01 = A[j+1]; // A[i][j+1]
      a02 = A[j+2]; // A[i][j+2]
      a03 = A[j+3]; // A[i][j+3]

      a10 = A[n + j+0]; // A[i+1][j]
      a11 = A[n + j+1]; // A[i+1][j+1]
      a12 = A[n + j+2]; // A[i+1][j+2]
      a13 = A[n + j+3]; // A[i+1][j+3]

      a20 = A[2*n + j+0]; // A[i+2][j]
      a21 = A[2*n + j+1]; // A[i+2][j+1]
      a22 = A[2*n + j+2]; // A[i+2][j+2]
      a23 = A[2*n + j+3]; // A[i+2][j+3]

      a30 = A[3*n + j+0]; // A[i+3][j]
      a31 = A[3*n + j+1]; // A[i+3][j+1]
      a32 = A[3*n + j+2]; // A[i+3][j+2]
      a33 = A[3*n + j+3]; // A[i+3][j+3]

      // C[i][k] = sum_j{A[i][j]*B[j][k]}
      c0 += a00 * b0 + a01 * b1 + a02 * b2 + a03 * b3;
      // C[i+1][k] = sum_j{A[i+1][j]*B[j][k]}
      c1 += a10 * b0 + a11 * b1 + a12 * b2 + a13 * b3;
      // C[i+2][k] = sum_j{A[i+2][j]*B[j][k]}
      c2 += a20 * b0 + a21 * b1 + a22 * b2 + a23 * b3;
      // C[i+3][k] = sum_j{A[i+3][j]*B[j][k]}
      c3 += a30 * b0 + a31 * b1 + a32 * b2 + a33 * b3;
    }

    for (j = n/4*4 ; j < n ; j ++) {
      b0 = B[j*n + k]; // B[j][k]
      a00 = A[j]; // A[i][j]
      a10 = A[n + j]; // A[i+1][j]
      a20 = A[2*n + j]; // A[i+2][j]
      a30 = A[3*n + j]; // A[i+3][j]

      c0 += a00 * b0;
      c1 += a10 * b0;
      c2 += a20 * b0;
      c3 += a30 * b0;
    }
    C[k] = c0; // C[i][k]
    C[n + k] = c1; // C[i+1][k]
    C[2*n + k] = c2; // C[i+2][k]
    C[3*n + k] = c3; // C[i+3][k]
  }
}
