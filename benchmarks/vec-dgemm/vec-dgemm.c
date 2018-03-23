// See LICENSE for license details.

//**************************************************************************
// Vector SAXPY benchmark for the RISC-V Vector ISA
//--------------------------------------------------------------------------
//

#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

// #include "dataset1-test.h"
#include "dataset1.h"

void vec_dgemm_inner( int n, double* A, double* B, double* C );
void vec_dgemm_remainder( int n, double* A, double* B, double* C );

void vec_dgemm( int n, double A[], double B[], double C[] )
{
  int i, j, k;
  for (i = 0 ; i < n/4*4 ; i += 4) {
    vec_dgemm_inner(n, A + i*n, B, C + i*n);
  }
  for (i = n/4*4 ; i < n ; i++) {
    vec_dgemm_remainder(n, A + i*n, B, C + i*n);
  }
}


//--------------------------------------------------------------------------
// Main

double results[DATA_SIZE * DATA_SIZE];

int main( int argc, char* argv[] )
{
  // Do the saxpy
  setStats(1);
  vec_dgemm(DATA_SIZE, input_data_A, input_data_B, results);
  setStats(0);

  // Check the results
  return verifyDouble(DATA_SIZE*DATA_SIZE, results, output_data_C);
}
