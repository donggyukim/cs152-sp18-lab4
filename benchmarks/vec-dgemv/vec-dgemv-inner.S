## RISC-V Vector dgemv_inner code

#include "rvv.h"

.text
.align 2

.globl vec_dgemv_inner
.type  vec_dgemv_inner,@function

# assumes calling convention:
# a0 has int n
# a1 has double* A  <---
# a2 has double* x
# a3 has double* y

vec_dgemv_inner:
    # configuration:
    # v0-v3: vector float with 64 bits
    setvcfg(vcfg0,
      VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64)

   fld f0, 0(a3)       # load y[i]
loop:
	setvl(t0, a0)
	# TODO: load A[i][]
   # TODO: load x[]
	# TODO: v2[j] = A[i][j] * x[j]
	# Reduction
	mv t2, t0           # t2 = VL
reduction:
	srl t2, t2, 1       # t2 = t2 / 2 
	beqz t2, reduction_done
   # TODO: v3[i] = v2[t2 + i]
	# TODO: v2 = v2 + v3
	j reduction
reduction_done:   
   # TODO: t3 = v2[0]
	fmv.d.x f1, t3      # f1 = t3 
	fadd.d f0, f0, f1   # f0 += reduction
   sll t4, t0, 3       # byte offset
	add a1, a1, t4      # bump A[i][]
	add a2, a2, t4      # bump x[]
   sub a0, a0, t0      # decrement n
	bnez a0, loop       # loop
   fsd f0, 0(a3)       # store A[i][] * x[]
	ret
