## RISC-V Vector SAXPY code

#include "rvv.h"

.text
.align 2

.globl vec_dgemm_inner
.type  vec_dgemm_inner,@function

# assumes calling convention:
# a0 has int n
# a1 has double* A  <---
# a2 has double* B
# a3 has double* C

vec_dgemm_inner:
    # prologue
    addi sp, sp, -104
    sd s0, 96(sp)
    sd s1, 88(sp)
    sd s2, 80(sp)
    sd s3, 72(sp)
    sd s4, 64(sp)
    sd s5, 56(sp)
    sd s6, 48(sp)
    sd s7, 40(sp)
    sd s8, 32(sp)
    sd s9, 16(sp)
    sd s10, 8(sp)
    sd s11, 0(sp)

    # configuration:
    # v0-v7: vector float with 64 bits
    setvcfg(vcfg0,
      VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64,
		VECTOR | FP | W64)
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
    
	 mv  t1, a0 
	 sll t2, a0, 3             # t2 = n * 8 for byte addresses

loop_k:
    setvl(t0, t1)             # set VL

    # compute indices for C
    add t3, a3, t2            # t3 = C + (i+1)*n + k
    add t4, t3, t2            # t4 = C + (i+2)*n + k
	 add t5, t4, t2            # t5 = C + (i+3)*n + k

    # TODO: load C[i][] to v0
    # TODO: load C[i+1][] to v1
    # TODO: load C[i+2][] to v2
    # TODO: load C[i+3][] to v3

    srli t6, a0, 2            # n / 4
	 slli t6, t6, 2            # j = n / 4 * 4
    
    # compute indices for A 
	 mv s0, a1                 # s0 = A + i*n
	 add s1, s0, t2            # s1 = A + (i+1)*n
	 add s2, s1, t2            # s2 = A + (i+2)*n
	 add s3, s2, t2            # s3 = A + (i+3)*n

	 mv s4, a2                 # s4 = B + k
loop_j:
    # TODO: load B[j][] to v4
	 add s4, s4, t2            # s4 = B + (j+1)*n + k
    # TODO: load B[j+1][] to v5
	 add s4, s4, t2            # s4 = B + (j+2)*n + k
    # TODO: load B[j+2][] to v6
	 add s4, s4, t2            # s4 = B + (j+3)*n + k
    # TODO: load B[j+3][] to v7
	 add s4, s4, t2            # s4 = B + (j+4)*n + k for next iteration

    ld s7, 0(s0)              # load A[i][j]
	 ld s8, 8(s0)              # load A[i][j+1]
	 ld s9, 16(s0)             # load A[i][j+2]
	 ld s10, 24(s0)            # load A[i][j+3]

    # TODO: v16[0] = A[i][j]
    # TODO: v17[0] = A[i][j+1]
    # TODO: v18[0] = A[i][j+2]
    # TODO: v19[0] = A[i][j+3]

    ld s7, 0(s1)              # load A[i+1][j]
	 ld s8, 8(s1)              # load A[i+1][j+1]
	 ld s9, 16(s1)             # load A[i+1][j+2]
	 ld s10, 24(s1)            # load A[i+1][j+3]

    # TODO: v20[0] = A[i+1][j]
    # TODO: v21[0] = A[i+1][j+1]
    # TODO: v22[0] = A[i+1][j+2]
    # TODO: v23[0] = A[i+1][j+3]

    ld s7, 0(s2)              # load A[i+2][j]
	 ld s8, 8(s2)              # load A[i+2][j+1]
	 ld s9, 16(s2)             # load A[i+2][j+2]
	 ld s10, 24(s2)            # load A[i+2][j+3]

    # TODO: v24[0] = A[i+2][j]
    # TODO: v25[0] = A[i+2][j+1]
    # TODO: v26[0] = A[i+2][j+2]
    # TODO: v27[0] = A[i+2][j+3]

    ld s7, 0(s3)              # load A[i+3][j]
	 ld s8, 8(s3)              # load A[i+3][j+1]
	 ld s9, 16(s3)             # load A[i+3][j+2]
	 ld s10, 24(s3)            # load A[i+3][j+3]

    # TODO: v28[0] = A[i+3][j]
    # TODO: v29[0] = A[i+3][j+1]
    # TODO: v30[0] = A[i+3][j+2]
    # TODO: v31[0] = A[i+3][j+3]

    # TODO: add your code for matirix multiply

    add s0, s0, 32            # bump A[i][]
	 add s1, s1, 32            # bump A[i+1][]
	 add s2, s2, 32            # bump A[i+2][]
	 add s3, s3, 32            # bump A[i+3][]

    addi t6, t6, -4           # decrement j
    bnez t6, loop_j

    # handle remainder
    srli t6, a0, 2            # n / 4
	 slli t6, t6, 2            # n / 4 * 4
	 sub t6, a0, t6            # j = n % 4

loop_j_remainder:
    beqz t6, loop_j_done

    # TODO: load B[j][] to v4

    ld s7, 0(s0)              # load A[i][j]
	 ld s8, 0(s1)              # load A[i][j+1]
	 ld s9, 0(s2)              # load A[i][j+2]
	 ld s10, 0(s3)             # load A[i][j+3]

    # TODO: v16[0] = A[i][j]
    # TODO: v17[0] = A[i][j+1]
    # TODO: v18[0] = A[i][j+2]
    # TODO: v19[0] = A[i][j+3]

	 # TODO: add your code for reminder

    add s0, s0, 8             # bump A[i][]
	 add s1, s1, 8             # bump A[i+1][]
	 add s2, s2, 8             # bump A[i+2][]
	 add s3, s3, 8             # bump A[i+3][]
    add s4, s4, t2            # bump B[j]

    addi t6, t6, -1
	 j loop_j_remainder

loop_j_done:
    # TODO: store C[i][] to v0
    # TODO: store C[i+1][] to v1
    # TODO: store C[i+2][] to v2
    # TODO: store C[i+3][] to v3

	 sll t3, t0, 3             # bypte address
    add a2, a2, t3            # bump B
	 add a3, a3, t3            # bump C
    sub t1, t1, t0            # decrement n
    bnez t1, loop_k           # loop
    
	 # epilogue
    ld s0, 96(sp)
    ld s1, 88(sp)
    ld s2, 80(sp)
    ld s3, 72(sp)
    ld s4, 64(sp)
    ld s5, 56(sp)
    ld s6, 48(sp)
    ld s7, 40(sp)
    ld s8, 32(sp)
    ld s9, 16(sp)
    ld s10, 8(sp)
    ld s11, 0(sp)
    addi sp, sp, 104
    ret

