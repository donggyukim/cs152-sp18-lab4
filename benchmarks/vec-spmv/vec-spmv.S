#include "rvv.h"

.text
.align 2

.globl vec_spmv
.type  vec_spmv,@function

# assumes calling convention:
# a0 has int r
# a1 has double* val  <---
# a2 has double* idx
# a3 has double* x
# a4 has int* ptr
# a5 has double* y
# a6 has double* temp
vec_spmv:
    # TODO: prologue

    # step 1 configure machine
    # TODO: change configurations if necessary
    # configuration:
    # v0-v1: 32 bit int vector
	 # v2-v19: 64 bit float vector
    setvcfg(vcfg0,
      VECTOR | INT | W32,
		VECTOR | INT | W32,
		VECTOR | FP | W64,
		VECTOR | FP | W64)
    setvcfg(vcfg2,
      VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64)
    setvcfg(vcfg4,
      VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64)
    setvcfg(vcfg6,
      VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64)
    setvcfg(vcfg8, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64)
    # v20    : 64 bit int scalar
    # v21-v31: 64 bit float scalar
    setvcfg(vcfg10, \
      SCALAR | INT | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64)
    setvcfg(vcfg12, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64)
    setvcfg(vcfg14, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64)
	    
# step 2 setup loop-constant values
loop_i:

# step 3 stripmine
loop_k:
	setvl(t0, t1)

# step 4 compute SpMV

# step 5 loop arithmetic

# TODO: epilogue
   ret
