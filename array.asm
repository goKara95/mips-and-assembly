.data
	A: .word 2, 3, 1, 4, 8, 20, 30, 7, 9, 15 # Initialize the array A in memory
.text
.globl main
	main:
# Load the address of A[0] to $t1
	la $t1, A
# Getting user integer input K into register v0
	li $v0, 5
	syscall
	move $t0, $v0
# Your code goes here...
	addi $t2, $zero, 0 #index
	addi $t4, $zero, 40 #array size
	addi $v1, $zero, 0 # count of elements < k
	for: 	
		slt $t3, $t2, $t4 #1 if index <40 else 0
		beq $t3, 0, done #if t3 = 0 exit the program
		lw $t6, A($t2)
		slt $t5, $t6, $t0 #if t6<k 1 else 0
		beq $t5, 1, increment
		addi $t2, $t2, 4 #increment the index by 4 because next element in array is in (a+4)th location
		j for
		increment: 
			addi $v1, $v1, 1
			addi $t2, $t2, 4 #increment the index by 4 because next element in array is in (a+4)th location
			j for
	done:
		li $v0, 10
		syscall
# Don’t forget that the final result must be in $v1 before exit
# Exit from the simulator function
