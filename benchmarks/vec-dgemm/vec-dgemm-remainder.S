## RISC-V Vector SAXPY code

#include "rvv.h"

.text
.align 2

.globl vec_dgemm_remainder
.type  vec_dgemm_remainder,@function

# assumes calling convention:
# a0 has int n
# a1 has double* A  <---
# a2 has double* B
# a3 has double* C

vec_dgemm_remainder:
    # TODO: prologue

    # configuration:
    # v0, v4-v7: vector float with 64 bits
    setvcfg(vcfg0,
      VECTOR | FP | W64,
		0, 0, 0)
    setvcfg(vcfg2,
      VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64)
    # v16-v31: scalar float with 64 bits
    setvcfg(vcfg8, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64, \
      SCALAR | FP | W64)
    setvcfg(vcfg10, \
      SCALAR | FP | W64, \
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
    
loop_k:
    # TODO: add your code for loop_k
loop_j:
    # TODO: add your code for loop_j
loop_j_remainder:
    # TODO: add your code for loop_j_remainder
loop_j_done:
    
	 # TODO: epilogue
    ret

