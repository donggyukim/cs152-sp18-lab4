#include "rvv.h"

.text
.align 2

.globl vec_imax
.type  vec_imax,@function

# assumes calling convention:
# a0 has int n
# a1 has double* l  <---
# a2 has int* i
# a3 has double* m
vec_imax:
   # configufations
   # v0 : 64 bit floating-point scalar
   # v1 : 64 bit int vector (mask)
   # v2-v4 : 32 bit floating-point vector
   
	setvcfg(vcfg0, \
			 SCALAR | FP  | W64, \
			 VECTOR | INT | W32, \
			 VECTOR | FP  | W64, \
			 VECTOR | FP  | W64)
	setvcfg(vcfg2, \
			 VECTOR | FP  | W64, \
			 0, 0, 0)

	# TODO: init max value (v0) to 0
	li t1, 0           # index of max
	li t2, 0           # loop index
loop:
	setvl(t0, a0)      # set VL 
	# TODO: v2 = load l[]
	# TODO: v3 = v2

	mv t3, t0
reduction:
	srl t3, t3, 1      # t2 / 2
   beqz t3, reduction_done
	# TODO: v4[i] = v3[t3 + i]
	# TODO: v3[i] = max(v3[i], v3[t2 + i])
   j reduction

reduction_done:
	# TODO: v0 = max(v0, v3)
	# TODO: v1[i] = v0[i] == v2[i]
	# TODO: find the index of 1 in v1
	# TODO: replace index of max if there's a new max

	sll t5, t0, 3      # byte offset
	add a1, a1, t5     # bump l
	add t2, t2, t0     # increment loop index
	sub a0, a0, t0     # decrement N
	bnez a0, loop      # loop

	sw t1, 0(a2)       # *i = index of max
	# TODO: *d = max value
	ret
