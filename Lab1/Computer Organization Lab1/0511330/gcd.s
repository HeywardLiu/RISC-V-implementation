.data
N1:		.word 512 #a0
N2:		.word 480 #a1
str1:	.string "GCD value of "
str2:	.string " and "
str3:	.string " is "

.text
main:
	lw		a0,	N1						#a0 = N1
	lw		a1,	N2						#a1 = N2
	jal	ra,	GCD

	mv		a3,	a0						#a3 = gcd result(a0)
	jal	ra,	printResult

## terminate program ##
	li   a0,	10	
	ecall

GCD:	
	beq	a1,	zero,	done 	#if(N2==0) return N1(a0)
	
	mv		t0,	a1						# t0 = N2(a1)
	rem	a1,	a0, a1				# a1 = N1(a0) % N2(a1) 
	mv		a0,	t0						# a0 = N2(t0)
	jal	zero,	GCD				# ret GCD(N2, N1%N2), (N2 == a0; N1%N2 == a1)

done:
	jalr	zero,	ra,	0			# back to main part where jump to GCD

printResult:
	la		a1,	str1
	li		a0,	4
	ecall

	lw		a1,	N1
	li		a0,	1
	ecall
	
	la		a1,	str2
	li		a0,	4
	ecall

	lw		a1,	N2
	li		a0,	1
	ecall

	la		a1,	str3
	li		a0,	4
	ecall

	mv		a1,	a3
	li		a0,	1
	ecall

	ret