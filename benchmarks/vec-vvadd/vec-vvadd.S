## RISC-V Vector vvadd ASM code

#include "rvv.h"

.text
.align 2

.globl vec_vvadd
.type  vec_vvadd,@function

# assumes calling convention:
# a0 has int n
# a1 has int* a  <---
# a2 has int* b
# a3 has int* c
vec_vvadd:
    # configufations
    # v0-v2: int
    setvcfg(vcfg0, \
			 VECTOR | INT | W32, \
			 VECTOR | INT | W32, \
			 VECTOR | INT | W32, \
			 0)
loop:
    # write your own code
    # 1) set VL
    # 2) load a[], b[]
    # 3) compute c[] = a[] + b[]
    # 4) store c[]
    # 5) bump pointers and decremet n
    # 6) loop until done
    ret
