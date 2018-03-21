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
    # write your code
    ret
