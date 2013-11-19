#include <sys/syscall.h>
#include <mips/regdef.h>


#define STACK_SIZE 40
#define TAM_INI_CADENA 40

.text
.align 2
.globl reverse #a0->fdin, a1->fdout
.ent reverse
reverse: 	#variables locales: t0->int size  
	subu sp, sp, STACK_SIZE	#ra, $fp, gp + a0 a1 a2 a3+ size +1 padding
	li t0,10 		# '/n'
	sb t0, STACK_SIZE-20(sp)
	sw $fp, STACK_SIZE-8(sp)
	sw gp, STACK_SIZE-4(sp)
	sw ra, STACK_SIZE(sp)
	sw a0, STACK_SIZE+4(sp)
	sw a1, STACK_SIZE+8(sp)
	
mientras:
	lw a0, STACK_SIZE+4(sp)
	li t0, 0 			# inicializo size en 0
	sw t0, STACK_SIZE-16(sp)	# guardo size en el stack
	addiu a1, sp, STACK_SIZE-16	# cargo en a1 la direccion de size en a0 tengo el fd
	jal leerLinea			# llamo a leer linea
	lw t0, STACK_SIZE-16(sp)	# cargo size en t0
	
	bnez v1, manejoError 		# capturo errores en leerLinea	
	beqz t0, salidaExitosa		# si size<=0 entonces termino loop(eof)
	move a0,v0			# cargo en a0 el puntero a la linea leida
	move a1,t0			# cargo en a1 la direccion de size
	jal invertirLinea		# llamo a invertir linea 
	
	#Imprimo linea en fdout
	move a1,a0			# copio en a1 el puntero a la linea leida
	li v0, SYS_write		# cargo en v0 el codigo de syscall Write	 
	lw a0, STACK_SIZE+8(sp)		# cargo en a0 fdout 
	lw a2,STACK_SIZE-16(sp)		# cargo en a2 el size de la linea
	syscall				# escribo linea en fdout
	blez v0, error_escritura	# manejo error_escritura
	
	move a0,a1			# cargo en a0 linea leida
	jal myfree			# libero linea
	bnez v0, error_free2		# chequeo error en liberacion
	
	#Imprimo salto de linea en fdout
	addu a1,sp,STACK_SIZE-20		# copio en a1 el puntero a la linea leida
	li v0, SYS_write			# cargo en v0 el codigo de syscall Write	 
	li a0, 1		# cargo en a0 fdout 
	li a2,1					# cargo en a2 el size de la linea
	syscall				# escribo linea en fdout
	blez v0, error_escritura	# manejo error_escritura
			
	j mientras			# repito mientras 

error_free2:
	# ERROR_FREE
	li v1, 3		# codigo de error en 3
	b manejoError

error_escritura:
	# ERROR_ESCRITURA
	li v1, 4		# codigo de error en 4

manejoError:
	# TODO: Manejar error en v1 tengo codigo de error
	move v0,v1 		# Devuelvo en v0 el codigo de error
	b popStackRev

salidaExitosa:
	li v0,0			# Cargo codigo de exito

popStackRev:
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
	move t0, a0
	move t1, a1
	beqz t0, popStackInv  
	li t2, 0 #i->t2
	addiu t1, t1, -1 #t1->l-1     
while:
	bgt t2, t1, popStackInv
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


.globl leerLinea
.ent leerLinea
leerLinea:			# a0: fd al archivo, a1: puntero a largo
	subu sp, sp, STACK_SIZE	#ra, $fp, gp + a0 a1 + 3 padding
	sw $fp, STACK_SIZE-28(sp)
	sw gp, STACK_SIZE-24(sp)
	sw ra, STACK_SIZE-20(sp)
	sw s0, STACK_SIZE-16(sp)
	sw s1, STACK_SIZE-12(sp)
	sw s2, STACK_SIZE-8(sp)
	sw s3, STACK_SIZE-4(sp)
	sw s4, STACK_SIZE(sp)
	sw a0, STACK_SIZE+4(sp)
	sw a1, STACK_SIZE+8(sp)
	
	move s0,a0 			# fd
	move s1,a1			# ptr a largo
	move s2,zero			# i

	# Reservo memoria para la linea
	li a0,TAM_INI_CADENA	# tamano para reservar memoria. Parametro de mymalloc
	move t7,a0
	jal mymalloc			# llamo a mymalloc
	move s3,v0				# s3 <- return de mymalloc
	beqz s3,error_malloc	# Si v0 == NULL -> error
	
	# Reservo memoria para la letra
	li a0,1				# tamano para reservar memoria. Parametro de mymalloc
	jal mymalloc			# llamo a mymalloc
	move s4,v0			# s4 <- return de mymalloc
	beqz s4,error_malloc	# Si v0 == NULL -> error

loop:	
	# Leo un caracter del archivo
	li v0,SYS_read			# Indico que la syscall es read
	move a0,s0				# 1er param -> fd
	move a1,s4				# 2do param -> ptr al buffer(letra)
	li a2,1					# 3er param -> chars a leer (1 en este caso, solo leo una letra)
	syscall
	bltz v0,error_lectura
	
	# Copio la letra leida en la linea
	lb t1,0(s4)				# *letra -> t1
	addu t2,s3,s2			# linea[i] -> t2
	sb t1,0(t2)				# linea[i] = *letra
	addi s2,1				# i++
	
	
	# Chequeo si el indice de linea se fue de rango
	li t2,TAM_INI_CADENA
	bne t2,s2,non_realloc	# i != TAM
	move a0,s3
	sll a1,t7,2
	move t7,a1
	jal myrealloc
	beqz v0,error_malloc
	move s3,v0

non_realloc:
	li t2,10
	lw t1,0(s4)	
	beq t1,t2,end_loop		#letra == '\n'
	beqz t1,end_loop		# letra == EOF
	b loop

end_loop:
	addi s2,-1				# i-1 para pisar el ultimo char almacenado (\n o eof)
	addu t2,s3,s2		# linea[i] -> t2
	li t1,0				
	sb t1,0(t2)				# linea[i] = '\0'
	
	# Libero letra
	move a0,s4
	jal myfree
	bnez v0,error_free
	
	bnez s2,return_ok
	move a0,s3			# Largo 0, libero linea
	jal myfree
	bnez v0,error_free
	b zero_length_no_error

error_lectura:
	# ERROR_LECTURA
	li v1,1		# codigo de error en 1
	b zero_length
	
error_malloc:
	# ERROR_MALLOC
	li v1,2		# codigo de error en 2
	b zero_length
	
error_free:
	# ERROR_FREE
	li v1,3		# codigo de error en 3
	b zero_length

zero_length_no_error:	
	li v1,0		# codigo de error en 0
zero_length:
	move v0,zero 
	sw zero,0(s1)	# Pongo el largo en el parametro
	b return
	
return_ok:	
	move v0, s3	# Devuelvo el puntero a linea
	li v1,0		# codigo de error en 0 
	sw s2,0(s1)	# Pongo el largo en el parametro
	b return
	
return:	
	lw $fp, STACK_SIZE-28(sp)
	lw gp, STACK_SIZE-24(sp)
	lw ra, STACK_SIZE-20(sp)
	lw s0, STACK_SIZE-16(sp)
	lw s1, STACK_SIZE-12(sp)
	lw s2, STACK_SIZE-8(sp)
	lw s3, STACK_SIZE-4(sp)
	lw s4, STACK_SIZE(sp)
	lw a0, STACK_SIZE+4(sp)
	lw a1, STACK_SIZE+8(sp)
	addiu sp, sp, STACK_SIZE
	jr ra
.end leerLinea

.data
.align 2
.globl reverse_errmsg
reverse_errmsg: .word sinError, error1, error2, error3, error4
		.size reverse_errmsg, 16
		.align 0
sinError: .asciiz "No hubo errores"
error1: .asciiz "error1"
error2: .asciiz "error2"
error3: .asciiz "error3"
error4: .asciiz "error4"
