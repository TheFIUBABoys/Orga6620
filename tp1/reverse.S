#include <sys/syscall.h>
#include <mips/regdef.h>

#define STACK_SIZE 32

#define TAM_INI_CADENA 40

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


.ent realloc
realloc:
#TODO
.end realloc



.ent leerLinea
leerLinea:			# a0: fd al archivo, a1: puntero a largo
	subu sp, sp, STACK_SIZE	#ra, $fp, gp + a0 a1 + 3 padding
	sw $fp, STACK_SIZE-24(sp)
	sw gp, STACK_SIZE-20(sp)
	sw ra, STACK_SIZE-16(sp)
	sw s0, STACK_SIZE-12(sp)
	sw s1, STACK_SIZE-8(sp)
	sw s2, STACK_SIZE-4(sp)
	sw s3, STACK_SIZE(sp)
	sw a0, STACK_SIZE+4(sp)
	sw a1, STACK_SIZE+8(sp)
	
	move s0,a0 			# fd
	move s1,a1			# ptr a largo
	move s2,zero			# i

	# Reservo memoria para la linea
	li a0,TAM_INI_CADENA	# tamano para reservar memoria. Parametro de mymalloc
	jal mymalloc			# llamo a mymalloc
	move s3,v0				# s3 <- return de mymalloc
	bltz s3,error_malloc	# Si v0 < 0 -> error
	
	# Reservo memoria para la letra
	li a0,1				# tamano para reservar memoria. Parametro de mymalloc
	jal mymalloc			# llamo a mymalloc
	move t0,v0			# t0 <- return de mymalloc
	bltz t0,error_malloc	# Si v0 < 0 -> error

loop:	
	# Leo un caracter del archivo
	li v0,SYS_read			# Indico que la syscall es read
	move a0,s0				# 1er param -> fd
	move a1,t1				# 2do param -> ptr al buffer(letra)
	li a2,1					# 3er param -> chars a leer (1 en este caso, solo leo una letra)
	syscall
	
	bltz v0,error_lectura
	
	# Copio la letra leida en la linea
	lb t1,0(t0)				# *letra -> t1
	addu t2,s3,s2			# linea[i] -> t2
	sb t1,0(t2)				# linea[i] = *letra
	addi s2,1				# i++
	
	
	# Chequeo si el indice de linea se fue de rango
	li t2,TAM_INI_CADENA
	bne t2,s2,non_realloc	# i != TAM
	move a0,s3
	jal realloc

non_realloc:
	li t2,'\n'		
	beq t1,t2,end_loop	# letra == '\n'
	beqz t1,end_loop		# letra == EOF
	b loop

end_loop:
	addi s2,-1				# i-1 para pisar el ultimo char almacenado (\n o eof)
	addu t2,s3,s2		# linea[i] -> t2
	li t1,'\0'				
	sb t1,0(t2)				# linea[i] = '\0'
	
	# Libero letra
	move a0,t1
	jal myfree
	bnez v0,error_free
	
	bnez s2,return_ok
	move s3,t1			# Largo 0, libero linea
	jal myfree
	bnez v0,error_free
	b zero_length

error_lectura:
#TODO ERROR_LECTURA

error_malloc:
#TODO ERROR_MALLOC

error_free:
#TODO ERROR_FREE

zero_length:
	
return_ok:	
	
return:	
	lw $fp, STACK_SIZE-24(sp)
	lw gp, STACK_SIZE-20(sp)
	lw ra, STACK_SIZE-16(sp)
	lw s0, STACK_SIZE-12(sp)
	lw s1, STACK_SIZE-8(sp)
	lw s2, STACK_SIZE-4(sp)
	lw s3, STACK_SIZE(sp)
	lw a0, STACK_SIZE+4(sp)
	lw a1, STACK_SIZE+8(sp)
	addiu sp, sp, STACK_SIZE
	jr ra
.end leerLinea

.data
#Checkear como poner los punteros bien; poner .align o .space?
reverse_errmsg: 
error1: .asciiz "error1"
error2: .asciiz "error2"
error3: .asciiz "error3"
