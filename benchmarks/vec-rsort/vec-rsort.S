#include "rvv.h"

.text
.align 2

.globl vec_rsort
.type  vec_rsort,@function

# assumes calling convention:
# a0 has int n
# a1 has type* arrIn  <---
# a2 has type* scratchIn
# a3 has int* buckets
# a4 has int log_base
vec_rsort:
    # TODO: prologue
	addi sp, sp, -64
	sd s0, 56(sp)
	sd s1, 48(sp)
	sd s2, 40(sp)
   sd s3, 32(sp)
	sd s4, 24(sp)
	sd s5, 16(sp)
	sd s6, 8(sp)
	sd s7, 0(sp)

    # Step 1: Configure machine
    # TODO: change configurations if necessary
    # configuration:
    # v0-v7:   32 bit int vector
    # v8-v15:  32 bit int scalar
    # v16-v31: 32 bit int vector
    setvcfg(vcfg0, \
      VECTOR | INT | W32, \
		VECTOR | INT | W32, \
		VECTOR | INT | W32, \
		VECTOR | INT | W32)
    setvcfg(vcfg2, \
      VECTOR | INT | W32, \
		VECTOR | INT | W32, \
		VECTOR | INT | W32, \
		VECTOR | INT | W32)
    setvcfg(vcfg4, \
      SCALAR | INT | W32, \
		SCALAR | INT | W32, \
		SCALAR | INT | W32, \
		SCALAR | INT | W32)
    setvcfg(vcfg6, \
      SCALAR | INT | W32, \
		SCALAR | INT | W32, \
		SCALAR | INT | W32, \
		SCALAR | INT | W32)
    setvcfg(vcfg8, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32)
    setvcfg(vcfg10, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32)
    setvcfg(vcfg12, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32)
    setvcfg(vcfg14, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32, \
      VECTOR | INT | W32)

	# s0 = base
   li s0, 1
	sll s0, s0, a4
	mv s1, x0           # s1 = log_exp
   mv s2, a1           # s2 = arr
	mv s3, a2           # s3 = scratch
	li s4, 1            # s4 = 1
	li s5, -1           # s5 = 1
	li s6, 32           # s6 = CHAR_BIT * sizeof(type)

while_loop:
	# Step 2: Reset buckets
bucket_init:

	# Step 3: Assign buckets
to_buckets:
   setvl(t0, t1)   # set VL
	# TODO: find digits
	# TODO: count and prune duplicate digits
	# TODO: increment buckets

	# Step 4: Add offsets to buckets

   # Step 5: Merge buckets
from_buckets:
	setvl(t0, t1)   # set VL  

	# TODO: find digits 
	# TODO: count and prune duplicate digits
	# TODO: decrement buckets
	# TODO: store scratch

   # Step 6: Swap arr & scratch

   # Step 7: Loop arithmatic

   # Call memcpy before return
   beq a1, s2, rsort_done
	mv t1, a0
	sll t1, t1, 2
	mv a0, a1  # arrIn
	mv a1, s2  # arr
	mv a2, t1  # n * sizeof(type)

	addi sp, sp, -8
	sd ra, 0(sp)
   jal memcpy
	ld ra, 0(sp)
	addi sp, sp, 8

rsort_done:
	# TODO: epilogue
	ld s0, 56(sp)
	ld s1, 48(sp)
	ld s2, 40(sp)
   ld s3, 32(sp)
	ld s4, 24(sp)
	ld s5, 16(sp)
	ld s6, 8(sp)
	ld s7, 0(sp)
	addi sp, sp, 64
	ret	
