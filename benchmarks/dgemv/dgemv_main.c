// See LICENSE for license details.

//**************************************************************************
// Vector SAXPY benchmark for the RISC-V Vector ISA
//--------------------------------------------------------------------------
//

#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

void dgemv_inner( int n, double A[], double x[], double* y );

void dgemv( int m, int n, double A[], double x[], double y[] )
{
  int i, j;
  for (i = 0 ; i < m ; i++) {
    y[i] = 0.0;
    dgemv_inner(n, A + (i * n) + j, x, y + i);
  }
}


//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  double results[ROW_SIZE];

  // Do the saxpy
  setStats(1);
  dgemv(ROW_SIZE, COL_SIZE, input_data_A, input_data_x, results);
  setStats(0);

  // Check the results
  return verifyDouble(ROW_SIZE, results, output_data_y);
}
