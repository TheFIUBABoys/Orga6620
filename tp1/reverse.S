#include "reverse.h"
#include "sys_mmap/mymalloc.h"
#include <mips/regdef.h>

#define STACK_SIZE 32

.text
.align 2
.globl reverse #a0->fdin, $a1->fdout
reverse: 		subu $sp, $sp, STACK_SIZE	#ra, fp, gp + a0 a1 + 3 padding
				sw $fp, STACK_SIZE-8($sp)	#este menos no se si se puede hacer, check
				sw $gp, STACK_SIZE-4($sp)
				sw $ra, STACK_SIZE($sp)
				sw $a0, STACK_SIZE+4($sp)
				sw $a1, STACK_SIZE+8($sp)
			
			




popStack:	lw $fp, STACK_SIZE-8($sp)
			lw $gp, STACK_SIZE-4($sp)
			lw $ra, STACK_SIZE($sp)
			lw $a0, STACK_SIZE+4($sp)
			lw $a1, STACK_SIZE+8($sp)
			addiu $sp, $sp, STACK_SIZE
			jr $ra

.data
#Checkear como poner los punteros bien; poner .align o .space?
reverse_errmsg: 
error1: .asciiz "error1"
error2: .asciiz "error2"
error3: .asciiz "error3"