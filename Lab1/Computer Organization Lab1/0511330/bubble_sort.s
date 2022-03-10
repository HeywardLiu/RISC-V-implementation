.data
arraySize:	.word 11
str1: .string "Array: "
str2: .string "Sorted: "
space: 		.string " "
newline: 	.string "\n"
array:		.word	99,5,3,6,7,31,23,43,12,45,1

.text
main:
	la			a2, array			#a2 = &array[0]
	lw			a3, arraySize  #a3 = len(array)
	li			t0, 0				#t0 = 0 (i=0)
	jal		ra, printStr1
	jal		ra, printArray 
	
	la			a0, array			# a0 = &array[0]
	lw			a1, arraySize	# a1 = arrSize 
	jal		ra, sort			# sort(int *array, int arrSize)
	
	la			a2, array			# a2 = &array[0]
	lw			a3, arraySize	# a3 = arrSize
	li			t0, 0				# t0 = 0 (i=0)
	jal		ra, printStr2  
	jal		ra, printArray
	
## terminate the program ##
	li			a0, 10
	ecall
	

										# printArray(int *array, int arrSize)
printArray:						# a2 = &array[0], a3 = arrSize
	slli		t2, t0, 2      # i = i*4
	add		t4, a2, t2     # t4 = &array[0] + i*4

	lw			a1, 0(t4)      # print array[i]
	li			a0, 1
	ecall
	
	la			a1, space      # print space
	li			a0, 4
	ecall

	addi 	t0, t0, 1			# i++
	blt		t0, a3, printArray	#if (i<arrSize) then jump to printArray

	la			a1, newline		# print newline
	li			a0, 4
	ecall

	jalr		zero, ra, 0		# back to the part where call printArray


printStr1:
	la			a1, str1
	li			a0, 4
	ecall
	jalr		zero, ra, 0


printStr2:
	la			a1, str2
	li			a0, 4
	ecall
	jalr		zero, ra, 0

#######################################################################
											### sort(int *array, int arrSize) ###
sort: 									### a0 = &array[0], a1 = arrSize  ###
	addi		sp, sp, -20 			# make 4 spaces
	sw			ra, 16(sp)			# save s3~s6 + ra on stack
	sw			s6, 12(sp)			
	sw			s5,	8(sp)
	sw			s4,	4(sp)
	sw			s3,	0(sp)
	mv			s5, a0					# s5 = a0			[Store parameter a0 & a1]
	mv			s6, a1					# s6 = a1	
	li			s3, 0					# s3 = 0 			[i = 0]

for1tst:								### Outer for Loop i ###
	bge	 	s3, s6, exit1		# if(s3 >= s6) go exit1 	[if(i>=n) break;]
	addi  	s4, s3, -1			#	s4 = s3 - 1 	         	[j = i - 1]

for2tst:								### Inner for Loop j ###
	blt		s4, zero ,exit2	# if(s4<0) go to exit2  	[if(j<0) break;]
	slli 	t0, s4, 2				# t0 = s4 * 4            [t0 = j * 4]
	add 		t0, s5, t0			# t0 = s5 + t0					[t0 = &array[0] + j*4]
	lw			t1, 0(t0)				# t1 = t0[0]						[t1 = array[idx] ]
	lw			t2, 4(t0)				# t2 = t0[4]						[t2 = array[idx+1] ]
	ble		t1, t2, exit2		# if(t1<t2) go to exit2  [if(array[idx]<array[idx+1]) break;]
	mv			a0, s5					# a0 = s5							[restore parameter a0 & a1]
	mv			a1, s4					# a1 = s4							
	jal		ra, swap				# jump to swap 
	addi 	s4, s4, -1			# s4 = s4 - 1					[j = j - 1]
	j for2tst							# jump to Inner for Loop j

exit2:
	addi 	s3, s3, 1				# s3 = s3 + 1					[i = i + 1]
	j for1tst							# jump to Outer for Loop with i+1

exit1:
	lw			s3, 0(sp)				# restore s3~s6 + ra we save on the stack before sorting
	lw			s4, 4(sp)				
	lw			s5, 8(sp)
	lw 		s6,	12(sp)
	lw			ra,	16(sp)
	addi 	sp,	sp, 20			# release the space we allocate
	jalr 	zero, ra, 0			# back to main where call the sort
############################################################################
										# swap(int *arr, int idx), a0 = &array[0], a1 = idx
swap:								
	slli 	t1, a1, 2			# t1 = a1*4 						(t1 = idx*4)
	add 		t1, a0, t1		# t1 = idx*4 + &array[0] (t1 = &array + 4*idx
	lw 		t0, 0(t1)			# t0 = *t1               (t0 = array[idx] )
	lw 		t2, 4(t1)			# t2 = *(t1+1)					(t2 = array[idx+1])
	sw			t2, 0(t1)			# *t1 = t2						(array[idx] = t2 )
	sw			t0, 4(t1)			# *(t1+1) = t1					(array[idx+1] = t1)
	jalr		zero, ra, 0		# back to the part where call swap