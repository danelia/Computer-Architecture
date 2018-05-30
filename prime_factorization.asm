	.data 
Integer: .asciiz "Enter integer: "
NewLine: .asciiz "\n"

	.text 
main:
	la $a0, Integer
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	move $t1, $v0
	li $t2, 2

Loop:
	bgt $t2, $t1, EndLoop
	div $t0, $t2
	mfhi $t3
	beqz $t3, Helper
	addi $t2, $t2, 1
	j Loop

Helper:
	mflo $t0
	move $a0, $t2
	li $v0, 1
	syscall
	la $a0, NewLine
	li $v0, 4
	syscall
	div $t0, $t2
	mfhi $t3
	beqz $t3, Helper
	j Loop

EndLoop:
	li $v0, 10
	syscall
