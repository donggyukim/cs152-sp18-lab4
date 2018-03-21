// See LICENSE for license details.

//**************************************************************************
// complex multiply (c version)
//--------------------------------------------------------------------------
#include "cmplxmult.h"

// scalar C implementation 
void cmplxmult( int n, struct Complex a[], struct Complex b[], struct Complex c[] )
{
  int i;
  for ( i = 0; i < n; i++ )
  {
    c[i].real = (a[i].real * b[i].real) - (a[i].imag * b[i].imag);
    c[i].imag = (a[i].imag * b[i].real) + (a[i].real * b[i].imag);
  }
}
