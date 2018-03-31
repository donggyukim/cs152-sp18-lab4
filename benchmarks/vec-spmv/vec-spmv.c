// See LICENSE for license details.

//**************************************************************************
// Double-precision sparse matrix-vector multiplication benchmark
//--------------------------------------------------------------------------

#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"
// #include "dataset1-test.h"

void vec_spmv(int r, const double* val, const int* idx, const double* x,
          const int* ptr, double* y, double* tmp);

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  double y[R];
  double tmp[R];

  setStats(1);
  vec_spmv(R, val, idx, x, ptr, y, tmp);
  setStats(0);

  return verifyDouble(R, y, verify_data);
}
