// See LICENSE for license details.

// This benchmark finds the index of max in a vector
 
#include "util.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset1.h"

void imax( int n, double l[], int* i, double* m )
{
  int k, idx, sgt;
  double elm, max = 0.0;
  for ( k = 0 ; k < n ; k++) {
    elm = l[k];
    sgt = elm > max;
    max = sgt ? elm : max; // To infer fmax
    idx = sgt ? k : idx;
  }
  *i = idx;
  *m = max;
}

//--------------------------------------------------------------------------
// Main

extern int printf(const char* fmt, ...);

int main( int argc, char* argv[] )
{
  int i;
  double m;

  setStats(1);
  imax( SIZE, input_data, &i, &m );
  setStats(0);

  printf("idx: %d != %d, max: %lld != %lld\n", i, idx, (long long)m, (long long)max);
  // Check the results
  return (i != idx) + ((m != max) << 1);
}
