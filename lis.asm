	.data
array_size: .word 10
array: .word 1 2 3 3 5 6 4 4 4 4
answer: .space 20

	.text
main:
	la $t0, answer
	li $t1, 0
	li $t2, 1
	la $t3, array_size
	lw $t4, 0($t3)
	j initLoop
	
initLoop:
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	blt  $t1, $t4, initLoop
	la $t0, answer
	la $t1, array
	li $t2, 1
	j dynamicLoop

dynamicLoop:
	beq $t2, $t4, printTrans
	li $t3, 0
	j dynamicInnerLoop

dynamicLoopTransition:
	addi $t2, $t2, 1
	j  dynamicLoop

dynamicInnerLoop:
	beq $t3, $t2, dynamicLoopTransition
	li $t5, 4
	mult  $t5, $t2
	mflo  $t6
	mult $t3, $t5
	mflo $t7
	add $t8, $t1, $t6
	add $t9, $t1, $t7
	lw $t6 0($t8)
	lw $t7 0($t9)
	ble $t6, $t7, transition
	mult  $t5, $t2
	mflo  $t6
	mult $t3, $t5
	mflo $t7
	add $t8, $t0, $t6
	add $t9, $t0, $t7
	lw $t6, 0($t8)
	lw $t7, 0($t9)
	addi $t7, $t7, 1
	bge $t6, $t7, transition
	sw $t7, 0($t8)
	j transition
	
transition:
	addi $t3, $t3, 1
	j dynamicInnerLoop

printTrans:
	li $t2 0
	lw $t5, 0($t0)
	j maxLoop	

putMax:
	move $t5, $t3
	j maxLoop
	
maxLoop:
	beq $t2, $t4, printMax
	lw $t3, 0($t0)
	addi $t0, $t0 4
	addi $t2, $t2, 1
	bgt $t3, $t5, putMax
	j maxLoop
	
printMax:
	move $a0, $t5
	li $v0, 1
	syscall
	j exit
	
exit:
	li $v0, 10
	syscall