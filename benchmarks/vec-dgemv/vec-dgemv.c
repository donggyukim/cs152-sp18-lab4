// See LICENSE for license details.

//**************************************************************************
// Vector DGEMV benchmark for the RISC-V Vector ISA
//--------------------------------------------------------------------------
//

#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

void vec_dgemv_inner( int n, double A[], double x[], double* y );

void vec_dgemv( int m, int n, double A[], double x[], double y[] ) {
  int i;
  for (i = 0 ; i < m ; i++) {
    y[i] = 0.0;
    vec_dgemv_inner(n, A + (i * n), x, y + i);
  }
}

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  double results[ROW_SIZE];

  // Do the saxpy
  setStats(1);
  vec_dgemv(ROW_SIZE, COL_SIZE, input_data_A, input_data_x, results);
  setStats(0);

  // Check the results
  return verifyDouble(ROW_SIZE, results, output_data_y);
}
