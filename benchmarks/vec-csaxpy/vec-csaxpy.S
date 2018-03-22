## RISC-V Vector SAXPY code

#include "rvv.h"

.text
.align 2

.globl vec_csaxpy
.type  vec_csaxpy,@function

# assumes calling convention:
# a0 has int n
# a1 has float a  <---
# a2 has float* x
# a3 has float* y

vec_csaxpy:
    # configuration:
    # v0:    scalar int width 8 bits
    # v1:    vector int width 8 bits (vector masks)
    # v2:    vector int width 8 bits
    # v3:    scalar float with 32 bits
    # v4-v5: vector float with 32 bits
    setvcfg(vcfg0,
      SCALAR | INT | W8,
      VECTOR | INT | W8,
		VECTOR | INT | W8,
      SCALAR | FP  | W32)
    setvcfg(vcfg2, \
      VECTOR | FP | W32, \
      VECTOR | FP | W32, \
      0, 0)
loop:
    setvl(t0, a0)
    vinsert v0, x0, x0        # v0[0] = 0
    vld v2, 0(a1)             # load cond[i]
    vsne v1, v2, v0           # set if cond[i] != 0
    
    vinsert v3, a2, x0        # v2[0] = a
    vld v4, 0(a3), v1t        # load x[i]
    vld v5, 0(a4), v1t        # load y[i]
    vmadd v5, v3, v4, v5, v1t # y[i] = a * x[i] + y[i]
    vst v5, 0(a4), v1t        # store y[i]
	 add a1, a1, t0            # bump cond
    sll t1, t0, 2             # byte offset
    add a3, a3, t1            # bump x
    add a4, a4, t1            # bump y
    sub a0, a0, t0            # decrement n
    bnez a0, loop             # loop
    ret
