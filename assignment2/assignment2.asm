# Change a decimal number to a 4 bytes binary number
# Changsong Li

	.data
arr:	.space	128				# create a int arr with size 32
	.align	2				# align data segment after each int
	
# end of data segment

#======================================================================================

# begin text segment

	.text					# instrutction starts from here
MAIN:	la	$s0,	arr			# load the address of the arr to $s0
	addi	$s1,	$zero,	0		# assign i = 0
	addi	$s2,	$zero,	1		# assign num = 1
FOR:	slti	$t0,	$s1,	32		# check i < 32
	bne	$t0,	$zero,	END_FOR		# to the end if it is true
	add	$t0,	$s0,	$s1		# addr. A[i]
	sw	$s2,	0($t0)			# A[i] = num		