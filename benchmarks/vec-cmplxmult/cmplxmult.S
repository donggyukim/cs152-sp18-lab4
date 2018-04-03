## RISC-V Vector Complex Multiply Code

#include "rvv.h"

.text
.align 2

.globl cmplxmult
.type  cmplxmult,@function

# assumes calling convention
# a0 has int n
# a1 has struct Complex* a
# a2 has struct Complex* b
# a3 has struct Complex* c

cmplxmult:
	# configurations
   # v0-v7: 32-bit floting-point
	setvcfg(vcfg0, \
			VECTOR | FP | W32, \
			VECTOR | FP | W32, \
			VECTOR | FP | W32, \
			VECTOR | FP | W32)
	setvcfg(vcfg2, \
			VECTOR | FP | W32, \
			VECTOR | FP | W32, \
			VECTOR | FP | W32, \
			VECTOR | FP | W32)

loop:
	setvl(t0, a0)    # set VL
   addi t4, a1, 4
	addi t5, a2, 4                 
   addi t6, a3, 4
	li t1, 8         # set stride
   # TODO: load a[].real
   # TODO: load a[].imag
   # TODO: load b[].real
   # TODO: load b[].imag

   # TODO: compute c[i].real
	# = a[].real * b[i].real - a[i].imag * b[i].imag
   # Hint: Number of instructions needed = 2

   # TODO: compute c[i].imag
	# = a[].real * b[i].imag + a[i].imag * b[i].real
   # Hint: Number of instructions needed = 2

	# TODO: store c[]

   # TODO: bump pointers and loop

	ret

