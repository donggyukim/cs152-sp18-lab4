// See LICENSE for license details.

// This benchmark finds the index of max in a vector
 
#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

void vec_imax( int n, double l[], int* i, double* m );

//--------------------------------------------------------------------------
// Main

extern int printf(const char* fmt, ...);

int main( int argc, char* argv[] )
{
  int i;
  double m;

  setStats(1);
  vec_imax( SIZE, input_data, &i, &m );
  setStats(0);

  printf("idx: %d ?= %d, max: %lld ?= %lld\n", i, idx, (long long)m, (long long)max);
  // Check the results
  return (i != idx) + ((m != max) << 1);
}
