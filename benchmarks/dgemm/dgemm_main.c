// See LICENSE for license details.

#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

void dgemm_inner ( int n, double A[], double B[], double C[] );
void dgemm_remainder ( int n, double A[], double B[], double C[] );

void dgemm( int n, double A[], double B[], double C[] )
{
  int i;

  for (i = 0 ; i < n/4*4 ; i += 4) {
    dgemm_inner(n, A + i*n, B, C + i*n);
  }

  for (i = n/4*4 ; i < n ; i++) {
    dgemm_remainder(n, A + i*n, B, C + i*n);
  }
}


//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  double results[DATA_SIZE * DATA_SIZE];

  // Do the saxpy
  setStats(1);
  dgemm(DATA_SIZE, input_data_A, input_data_B, results);
  setStats(0);

  // Check the results
  return verifyDouble(DATA_SIZE*DATA_SIZE, results, output_data_C);
}
