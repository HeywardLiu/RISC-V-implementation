.data
argument:	.word 5
str: .string "th number in the Fibonacci sequence is "

.text
main:
	lw		a0, argument
	jal	ra, Fib
	mv		a3,	a0				# a3 = Fib(n)
	jal  ra, printResult

	
	#terminate program
	li   a0, 10
	ecall
Fib:
	beq	a0, x0, done		#in n==0 return 1
	addi t0, x0, 1			#t0 = 0 + 1
	beq 	a0, x5, done		#if n==1 return 1
	
	addi sp, sp, -16		#allocate for 2 item
	sw		ra, 0(sp)			#save return address on stack
	sw		a0, 8(sp)			#save argument n
	addi	a0, a0, -1		#a0 = n-1
	jal	ra,	Fib			#Fib(n-1)
	lw		t0,	8(sp)		#LOAD n from stack
	sw		a0,	8(sp)		#push Fib(n-1) on stack
	addi	a0,	t0,	-2   #t0 = n - 2
	jal	ra,	Fib			#Fib(n-2)
	lw		t0,	8(sp)		#x5 = Fib(-1)
	add	a0,	a0,	t0		#a0 = Fib(n-1) + Fib(n-2)

	lw		x1,	0(sp)
	addi	sp,	sp,	16

done:	
	jalr	x0,	ra,	0

printResult:
	lw		a1,	argument
	li		a0,	1
	ecall

	la		a1,	str
	li		a0,	4
	ecall
	
	mv		a1,	a3				# a1 = a3(=Fib(n))
	li		a0,	1
	ecall