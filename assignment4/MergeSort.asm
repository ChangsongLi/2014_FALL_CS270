	.data
arr:	.space	80
aux:	.space	80
size:	.asciiz	"Enter the number of elements in the array: "
	.align	2
num:	.asciiz	"Enter the array elements: "
	.align 2
sorted:	.asciiz	"The elements sorted in ascending order are: "
	.align 2

		
# end of data segment
	
# ========================================================================================================

# begin text segment


	.text
MAIN:	la	$s0,	arr		# arr(s0) load the address of the array
	la	$a0,	size		# load the address of the string size
	addi	$v0,	$zero,	4	# set up printing for prompt
	syscall				# printing the prompt
	addi	$v0,	$zero,	5	# read number of elements from user
	syscall				# read from user
	move	$s1,	$v0		# size = user's input
	la	$a0,	num		# load the string for the prompt
	addi	$v0,	$zero,	4	# prepare for printing
	syscall				# printing
	addi	$s2,	$zero,	0	# i = 0
FOR:	slt	$t0,	$s2,	$s1	# i < size
	beq	$zero,	$t0,	FOREND	# i >= size, stop
	addi	$v0,	$zero,	5	# prepare for reading number of elements from user
	syscall				# read user's input
	sll	$t0,	$s2,	2	# i * 4 for get offset
	add 	$t0,	$s0,	$t0	# get the address of arr[i]
	sw	$v0,	0($t0)		# arr[i] = user input
	addi	$s2,	$s2,	1	# i++
	j	FOR
FOREND:	addi	$a0,	$s0,	0	# pass the argument arr
	addi	$a1,	$s1,	0	# pass the size of the array
	jal	MS
	la	$a0,	sorted		# load the string for sorted
	addi	$v0,	$zero,	4	# prepare for printing
	syscall				# printing
	addi	$s2,	$zero,	0	# i = 0
PFOR:	slt	$t0,	$s2,	$s3	# i < size
	beq	$zero,	$t0,	END	# i >= size, stop
	sll	$t0,	$s2,	2	# i * 4 for get offset
	add 	$t0,	$s0,	$t0	# get the address of arr[i]
	lw	$a0,	0($t0)		# prepare to print arr[i]
	addi	$v0,	$zero,	1	# set up for printing integer
	syscall				# printing integer
	addi	$a0,	$zero,	' '	# prepare to print space
	addi	$v0,	$zero,	11	# set up for printing character
	syscall				# print space
	addi	$s2,	$s2,	1	# i++
	j	PFOR			# jump back
END:	addi	$v0,	$zero,	10	# ready to end the program
	syscall				# exit
	
# end of the text

# =================================================================================================


MS:	addi	$sp,	$sp,	-16	# get the space on the stack
	sw	$a0,	0($sp)		# put the a0 to the stack
	sw	$a1,	4($sp)		# put the a1 to the stack
	sw	$s0,	8($sp)		# put the s0 to the stack
	sw	$ra,	12($sp)		# put the ra to the stack
	la	$s0,	aux		# load the address of aux
	addi	$a3,	$a1,	-1	# put the size - 1 to argument4 
	addi	$a2,	$zero,	0	# put the 0 to argument 3
	addi	$a1,	$s0,	0	# put the aux to argument2 
	jal	MS1			# jump to MergeSort1
	lw	$a0,	0($sp)		# load the a0 from the stack
	lw	$a1,	4($sp)		# load the a1 from the stack
	lw	$s0,	8($sp)		# load the s0 from the stack
	lw	$ra,	12($sp)		# load the ra from the stack
	addi	$sp,	$sp,	12	# shift the stack up
	jr	$ra			# jump back
	
MS1:	slt	$t0,	$a2,	$a3	# if s < e
	beq	$t0,	$zero,	ENDMS1	# not, then stop
	
ENDMS1: