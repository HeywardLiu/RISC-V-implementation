.data
arraySize:	.word 10
str1: .string "Array: "
str2: .string "Sorted: "
space: .string " "
newline: .string "\n"
array:		.word	5,3,6,7,31,23,43,12,45,1

.text
main:
	la			a2, array			#a1(x11) = &array[0]
	lw			a3, arraySize  #a0(x10) = len(array)
	li			t0, 0				#t0(i) = 0

	jal		ra, printStr1
	jal		ra, printArray 
	
	la			x10, array
	lw			x11, arraySize
	jal		ra, sort
	
	la			a2, array
	lw			a3, arraySize
	li			t0, 0
	jal		ra, printStr2
	jal		ra, printArray
	
	#terminate the program
	li		a0, 10
	ecall
	


printArray:						#printArray(int *array, int arrSize), x10 = &array[0], x11 = arrSize
	slli		t2, t0, 2      #i = i*4
	add		t4, a2, t2     #t4 = &array[0] + i*4

	lw			a1, 0(t4)      #print array[i]
	li			a0, 1
	ecall
	
	la			a1, space      #print space
	li			a0, 4
	ecall

	addi 	t0, t0, 1			# i++
	blt		t0, a3, printArray

	la			a1, newline
	li			a0, 4
	ecall
	jalr		x0, x1, 0


printStr1:
	la			a1, str1
	li			a0, 4
	ecall
	jalr		x0, x1, 0


printStr2:
	la			a1, str2
	li			a0, 4
	ecall
	jalr		x0, x1, 0

#######################################################################

sort: 									#sort(int *array, int arrSize),  x10 = &array[0], x11 = arrSize
		addi		sp, sp, -20 		#save x19~x22 & x1 on stack
		sw			x1, 16(sp)
		sw			x22, 12(sp)
		sw			x21,	8(sp)
		sw			x20,	4(sp)
		sw			x19,	0(sp)
		mv			x21, x10
		mv			x22, x11
		li			x19, 0
for1tst:
		bge	 x19, x22, exit1
		addi  x20, x19, -1
for2tst:
		blt	 x20, x0 ,exit2
		slli 	x5, x20, 2
		add 	x5, x21, x5
		lw		x6, 0(x5)
		lw		x7, 4(x5)
		ble	x6, x7, exit2
		mv		x10, x21
		mv		x11, x20
		jal	x1, swap
		addi x20, x20, -1
		j for2tst
exit2:
		addi x19, x19, 1
		j for1tst
exit1:
		lw		x19, 0(sp)
		lw		x20, 4(sp)
		lw		x21, 8(sp)
		lw 	x22,	12(sp)
		lw		x1,	16(sp)
		addi sp,	sp, 20
		jalr x0, x1, 0
############################################################################

swap:                  #swap(int *arr, int idx), x10 = &array[0], x11 = idx
	slli x6, x11, 2		#x6 = x11(idx)*4
	add 	x6, x10, x6		#x6 = idx*4 + &array[0]
	lw 	x5, 0(x6)
	lw 	x7, 4(x6)
	sw		x7, 0(x6)
	sw		x5, 4(x6)
	jalr	x0, x1, 0