// See LICENSE for license details.

//**************************************************************************
// cmplxmult benchmark
//--------------------------------------------------------------------------
//

#include "util.h"
#include "cmplxmult.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset.h"

// helpers
static void printComplexArray(const char name[], int n, const struct Complex arr[])
{
#if HOST_DEBUG
  int i;
  printf( " %10s :", name );
  for ( i = 0; i < n; i++ )
    printf( " (%g, %g) ", arr[i].real,arr[i].imag );
  printf( "\n" );
#endif
}
float absolute( float in)
{
  if (in > 0)
    return in;
  else
    return -in;
}
// are two floating point numbers "close enough"?
// this is pretty loose, because Perl is giving me pretty terrible answers
int close_enough(float a, float b)
{
   int close_enough = 1;

   if (  absolute(a) > 1.10*absolute(b) 
      || absolute(a) < 0.90*absolute(b)
      || absolute(a) > 1.10*absolute(b)
      || absolute(a) < 0.90*absolute(b))
   {
      if (absolute(absolute(a) - absolute(b)) > 0.1)
      {
         close_enough = 0;
      }
   }

   return close_enough;
}

static int verifyComplex(int n, const volatile struct Complex* test, const struct Complex* verify)
{
  int i;
  // Unrolled for faster verification
  for (i = 0; i < n/2*2; i+=2)
  {
    struct Complex t0 = test[i], t1 = test[i+1];
    struct Complex v0 = verify[i], v1 = verify[i+1];
    int eq1 = (close_enough(t0.real, v0.real)) && (close_enough(t0.imag, v0.imag)), eq2 = close_enough(t1.real, v1.real) && close_enough(t1.imag, v1.imag);
    if (!(eq1 & eq2)) return i+1+eq1;
  }
  if (n % 2 != 0 && (test[n-1].real != verify[n-1].real || test[n-1].imag != verify[n-1].imag))
    return n;
  return 0;
}

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  // Print the input array
  printComplexArray("inputX", DATA_SIZE, input1_data);
  printComplexArray("inputY", DATA_SIZE, input2_data);
  printComplexArray("verify", DATA_SIZE, verify_data);

#if PREALLOCATE
  cmplxmult(DATA_SIZE, input1_data, input2_data, output_data);
#endif

  // Do the cmplxmult
  setStats(1);
  cmplxmult(DATA_SIZE, input1_data, input2_data, output_data);
  setStats(0);

  // Print out the result
  printComplexArray("results", DATA_SIZE, output_data);

  // Check the results
  return verifyComplex(DATA_SIZE, output_data, verify_data);
}
