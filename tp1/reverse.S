#include <sys/syscall.h>
#include <mips/regdef.h>

#define STACK_SIZE 32

.text
.align 2
.globl reverse #a0->fdin, a1->fdout
.ent reverse
reverse: 	
	subu sp, sp, STACK_SIZE	#ra, $fp, gp + a0 a1 + 3 padding
	sw $fp, STACK_SIZE-8(sp)
	sw gp, STACK_SIZE-4(sp)
	sw ra, STACK_SIZE(sp)
	sw a0, STACK_SIZE+4(sp)
	sw a1, STACK_SIZE+8(sp)
		

popStack:
	lw $fp, STACK_SIZE-8(sp)
	lw gp, STACK_SIZE-4(sp)
	lw ra, STACK_SIZE(sp)
	lw a0, STACK_SIZE+4(sp)
	lw a1, STACK_SIZE+8(sp)
	addiu sp, sp, STACK_SIZE
	jr ra

.end reverse

.ent invertirLinea
invertirLinea: #t0->linea, t1->len
	subu sp, sp, 8	# $fp, gp
	sw $fp, 0(sp)	
	sw gp, 4(sp)
	sw a0, 12(sp)
	sw a1, 16(sp)

	beqz t0, popStackInv
	li t2, 0 #i->t2
	addiu t1, t1, -1 #t1->l-1
while:
	bgt t1, t2, popStackInv
	addu t5, t0, t2 # t5 = t0+t2
	lb t3, 0(t5) #t3 = aux = linea[i];
	addu t6, t0, t1 # t6 = t0+t1
	lb t4, 0(t6) #t4 = linea[l];
	sb t4, 0(t5) #linea[i]=linea[l];
	sb t3, 0(t6)
	addiu t2, t2, 1 #i++
	addiu t1, t1, -1 #l--
	b while

popStackInv:
	lw $fp, 0(sp)	
	lw gp, 4(sp)
	lw a0, 12(sp)
	lw a1, 16(sp)
	addiu sp, sp, 8	# $fp, gp
	jr ra
.end invertirLinea

.ent leerLinea
leerLinea:			# a0: fd al archivo, a1: puntero a largo
	subu sp, sp, STACK_SIZE	#ra, $fp, gp + a0 a1 + 3 padding
	sw $fp, STACK_SIZE-8(sp)
	sw gp, STACK_SIZE-4(sp)
	sw ra, STACK_SIZE(sp)
	sw a0, STACK_SIZE+4(sp)
	sw a1, STACK_SIZE+8(sp)
	
	
	
	li a0, 1
	jal mymalloc
	jr ra
.end leerLinea

.data
#Checkear como poner los punteros bien; poner .align o .space?
reverse_errmsg: 
error1: .asciiz "error1"
error2: .asciiz "error2"
error3: .asciiz "error3"
