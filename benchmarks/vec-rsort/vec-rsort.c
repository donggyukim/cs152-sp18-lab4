// See LICENSE for license details.

//**************************************************************************
// Quicksort benchmark
//--------------------------------------------------------------------------
//
// This benchmark uses quicksort to sort an array of integers. The
// implementation is largely adapted from Numerical Recipes for C. The
// input data (and reference data) should be generated using the
// qsort_gendata.pl perl script and dumped to a file named
// dataset1.h

#include "util.h"
#include <string.h>
#include <limits.h>

//--------------------------------------------------------------------------
// Input/Reference Data

#define type unsigned int
#include "dataset1.h"
// #include "dataset1-test.h"

#define LOG_BASE 3
#define BASE (1 << LOG_BASE)

void vec_rsort(int n, type* arrIn, type* scratchIn, int* buckets, int log_base);

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  static type scratch[DATA_SIZE];
  static int buckets[BASE];

  // Do the sort
  setStats(1);
  vec_rsort(DATA_SIZE, input_data, scratch, buckets, LOG_BASE);
  setStats(0);

  // Check the results
  return verify( DATA_SIZE, input_data, verify_data );
}
