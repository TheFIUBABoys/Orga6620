#include "reverse.h"
#include "sys_mmap/mymalloc.h"
#include <mips/regdef.h>

#define STACK_SIZE 32

.text
.align 2
.globl reverse #a0->fdin, $a1->fdout
.ent reverse
reverse: 	
	subu $sp, $sp, STACK_SIZE	#ra, fp, gp + a0 a1 + 3 padding
	sw $fp, STACK_SIZE-8($sp)	#este menos no se si se puede hacer, check. Sino dejar asi hasta que tengamos size de stack
	sw $gp, STACK_SIZE-4($sp)
	sw $ra, STACK_SIZE($sp)
	sw $a0, STACK_SIZE+4($sp)
	sw $a1, STACK_SIZE+8($sp)
		
			

invertirLinea: #t0->linea, t1->len
	beq $t0, NULL, finInvertir
	li $t2, 0 #i->t2
	addiu $t1, $t1, -1 #$t1->l-1
while:
	bgt $t1, $t2, finInvertir
	lb $t3, $t2($t0) #t3 = aux = linea[i];
	lb $t4, $t1($t0) #t4 = linea[l];
	sb $t4, $t2($t0) #linea[i]=linea[l];
	sb $t3, $t1($t0)
	addiu $t2, $t2, 1 #i++
	addiu $t1, $t1, 1 #l--
	b while
	while (l-1 > i){
		//Swap
		char aux = linea[i];
		linea[i]=linea[l];
		linea[l]=aux;
		i++;
		l--;
    }

popStack:
	lw $fp, STACK_SIZE-8($sp)
	lw $gp, STACK_SIZE-4($sp)
	lw $ra, STACK_SIZE($sp)
	lw $a0, STACK_SIZE+4($sp)
	lw $a1, STACK_SIZE+8($sp)
	addiu $sp, $sp, STACK_SIZE
	jr $ra

.end reverse

.data
#Checkear como poner los punteros bien; poner .align o .space?
reverse_errmsg: 
error1: .asciiz "error1"
error2: .asciiz "error2"
error3: .asciiz "error3"