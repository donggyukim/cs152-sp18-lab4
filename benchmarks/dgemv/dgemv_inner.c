void dgemv_inner( int n, double A[], double x[], double* y )
{
  int j;
  for (j = 0 ; j < n ; j++) {
    *y += A[j] * x[j];
  }
}

