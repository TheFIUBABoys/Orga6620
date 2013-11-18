	.file	1 "poder.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	3
$LC0:
	.word	-1030792151
	.word	1073228021
	.text
	.align	2
	.globl	leerLinea
	.ent	leerLinea
leerLinea:
	.frame	$fp,64,$ra		# vars= 24, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,60($sp)
	sw	$fp,56($sp)
	sw	$gp,52($sp)
	sw	$s0,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$a2,72($fp)
	li	$v0,40			# 0x28
	sw	$v0,24($fp)
	sw	$zero,28($fp)
	lw	$s0,68($fp)
	lw	$a0,24($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,0($s0)
	lw	$v0,68($fp)
	lw	$v0,0($v0)
	bne	$v0,$zero,$L18
	li	$v0,1			# 0x1
	sw	$v0,40($fp)
	b	$L17
$L18:
	.set	noreorder
	nop
	.set	reorder
$L19:
	lw	$a0,64($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sb	$v0,32($fp)
	lw	$v0,64($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L22
	li	$v1,3			# 0x3
	sw	$v1,40($fp)
	b	$L17
$L22:
	lw	$v0,68($fp)
	lw	$v1,0($v0)
	lw	$v0,28($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,32($fp)
	sb	$v0,0($v1)
	lw	$v0,28($fp)
	addu	$v1,$v0,1
	lw	$v0,24($fp)
	bne	$v0,$v1,$L23
	l.s	$f0,24($fp)
	cvt.d.w	$f0,$f0
	l.d	$f2,$LC0
	mov.d	$f12,$f0
	mov.d	$f14,$f2
	la	$t9,pow
	jal	$ra,$t9
	trunc.w.d $f0,$f0,$v0
	s.s	$f0,24($fp)
	lw	$v0,68($fp)
	lw	$a0,0($v0)
	lw	$a1,24($fp)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L24
	li	$v1,2			# 0x2
	sw	$v1,40($fp)
	b	$L17
$L24:
	lw	$v1,68($fp)
	lw	$v0,36($fp)
	sw	$v0,0($v1)
$L23:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	lb	$v1,32($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L20
	lb	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L19
$L20:
	lw	$v1,72($fp)
	lw	$v0,28($fp)
	sw	$v0,0($v1)
	sw	$zero,40($fp)
$L17:
	lw	$v0,40($fp)
	move	$sp,$fp
	lw	$ra,60($sp)
	lw	$fp,56($sp)
	lw	$s0,48($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	leerLinea
	.size	leerLinea, .-leerLinea
	.align	2
	.globl	invertirLinea
	.ent	invertirLinea
invertirLinea:
	.frame	$fp,32,$ra		# vars= 16, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 0
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,32($fp)
	sw	$a1,36($fp)
	lw	$v0,32($fp)
	beq	$v0,$zero,$L28
	lw	$v0,36($fp)
	slt	$v0,$v0,3
	bne	$v0,$zero,$L28
	sw	$zero,8($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,-2
	sw	$v0,12($fp)
$L31:
	lw	$v0,12($fp)
	lw	$v1,8($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,$L33
	b	$L28
$L33:
	lw	$v1,32($fp)
	lw	$v0,8($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,16($fp)
	lw	$v1,32($fp)
	lw	$v0,8($fp)
	addu	$a0,$v1,$v0
	lw	$v1,32($fp)
	lw	$v0,12($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v1,32($fp)
	lw	$v0,12($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,16($fp)
	sb	$v0,0($v1)
	lw	$v0,8($fp)
	addu	$v0,$v0,1
	sw	$v0,8($fp)
	lw	$v0,12($fp)
	addu	$v0,$v0,-1
	sw	$v0,12($fp)
	b	$L31
$L28:
	move	$sp,$fp
	lw	$fp,28($sp)
	addu	$sp,$sp,32
	j	$ra
	.end	invertirLinea
	.size	invertirLinea, .-invertirLinea
	.rdata
	.align	2
$LC1:
	.ascii	"-h\000"
	.align	2
$LC2:
	.ascii	"Usage:\n"
	.ascii	"tp0 -h\n"
	.ascii	"tp0 -V\n"
	.ascii	"tp0 [file...]\n"
	.ascii	"Options:\n"
	.ascii	"-V, --version  Print version and quit.\n"
	.ascii	"-h, --help  Print this information and quit.\n"
	.ascii	"Examples:\n"
	.ascii	"tp0 foo.txt bar.txt\n"
	.ascii	"tp0 gz.txt\n\000"
	.align	2
$LC3:
	.ascii	"-V\000"
	.align	2
$LC4:
	.ascii	"Tp0 Version 1.0\000"
	.align	2
$LC5:
	.ascii	"r\000"
	.align	2
$LC6:
	.ascii	"Error in File %s open\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	lw	$v0,72($fp)
	addu	$v0,$v0,-1
	sw	$v0,24($fp)
	sb	$zero,32($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L35
	la	$v0,__sF
	sw	$v0,28($fp)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
	li	$v0,1			# 0x1
	sb	$v0,32($fp)
	b	$L36
$L35:
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC1
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L37
	lw	$v1,24($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L37
	la	$a0,$LC2
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,52($fp)
	b	$L34
$L37:
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC3
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L36
	lw	$v1,24($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L36
	la	$a0,$LC4
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,52($fp)
	b	$L34
$L36:
	sw	$zero,36($fp)
	sw	$zero,40($fp)
$L40:
	lw	$v0,36($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	beq	$v0,$zero,$L41
	lw	$v0,40($fp)
	bne	$v0,$zero,$L41
	lbu	$v0,32($fp)
	bne	$v0,$zero,$L44
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC5
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,28($fp)
$L44:
	lw	$v0,28($fp)
	bne	$v0,$zero,$L47
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,4
	la	$a0,__sF+176
	la	$a1,$LC6
	lw	$a2,0($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L46
$L47:
	lw	$v0,28($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L46
	lw	$v0,40($fp)
	bne	$v0,$zero,$L46
	sw	$zero,44($fp)
	sw	$zero,48($fp)
	addu	$v0,$fp,44
	addu	$v1,$fp,48
	lw	$a0,28($fp)
	move	$a1,$v0
	move	$a2,$v1
	la	$t9,leerLinea
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	bne	$v0,$zero,$L51
	lw	$a0,44($fp)
	lw	$a1,48($fp)
	la	$t9,invertirLinea
	jal	$ra,$t9
	lw	$v0,44($fp)
	beq	$v0,$zero,$L52
	lw	$v1,44($fp)
	lw	$v0,48($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,-1
	lb	$v1,0($v0)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L52
	lw	$v0,48($fp)
	addu	$v0,$v0,-1
	sw	$v0,48($fp)
$L52:
	li	$a0,1			# 0x1
	lw	$a1,44($fp)
	lw	$a2,48($fp)
	la	$t9,write
	jal	$ra,$t9
$L51:
	lw	$v0,44($fp)
	beq	$v0,$zero,$L47
	lw	$a0,44($fp)
	la	$t9,free
	jal	$ra,$t9
	b	$L47
$L46:
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	lbu	$v0,32($fp)
	bne	$v0,$zero,$L40
	lw	$v0,28($fp)
	beq	$v0,$zero,$L40
	lw	$a0,28($fp)
	la	$t9,fclose
	jal	$ra,$t9
	b	$L40
$L41:
	lw	$v0,40($fp)
	sw	$v0,52($fp)
$L34:
	lw	$v0,52($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
