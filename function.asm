.text
.globl main
main:
	# Getting user integer input a into register v0
	li $v0, 5
	syscall
	# Moving the integer input to another register: $t0 <- a
	move $t0, $v0
	# Getting the second user integer input a into register v0
	li $v0, 5
	syscall
	# Moving the integer input to another register: $t1 <- b
	move $t1, $v0
	# Your code goes here...
	beq $t0,$t1, equal #if equal jump to equal part
	jal compare #else call compare
	add $v1, $v0, $zero #store returned value in v1 
	li $v0, 10
	syscall
	
	
	compare:
	slt $t6, $t0, $t1 #t6 = 1 if a<b else 0
	addi $sp, $sp, -4 # make space on stack
	sw $ra, 0($sp)
	bne $t6, 1, do_nothing #if t6=1 compiler will jump to line 28 ignoring punish() call
	jal punish
	do_nothing:
	
	jal award  #award()
	
	
	equal:
	add $v1, $t0, $t1 #a+b
	add $v1, $v1, $v1 #2(a+b)
	li $v0, 10
	syscall
	
	punish:
	#$t0 = param a, $t1=param b $s0 is value to be returned
	add $s0, $t0, $zero #s0 = a
	sub $s0, $s0, $t1  #s0 = a-b
	sub $s0, $s0, $t1  #s0 = a-b-b
	sub $s0, $s0, $t1  #s0 = a-b-b-b = a-3b
	add $v0, $s0, $zero   # put return value in $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	award:
	#s0 is value to be returned
	add $s0, $t0, $t0 #s0 = 2a
	add $s0, $s0, $t0 #s0 = 2a +a
	add $s0, $s0, $t1 #s0 = 3a+b
	add $v0, $s0, $zero #put return value in $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 4	
	jr $ra
	
	
	
	

	# Don’t forget that the final result must be in $v1 before exit
	# Exit from the simulator function
	li $v0, 10
	syscall