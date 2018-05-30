	.data 
FirstInteger: .asciiz "Enter first integer: " 
SecondInteger: .asciiz "Enter second integer: " 
GDC: .asciiz "GCD is: " 
	
	.text 
.global main

main:
	la $a0, FirstInteger
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0,$v0

	la $a0, SecondInteger
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1,$v0

loop:
	beq $t0, $t1, finish
	bgt $t0, $t1, swap
	subu $t1, $t1, $t0
	j loop

swap:
	subu $t0, $t0, $t1
	j loop

finish:
	la $a0, GDC
	li $v0, 4
	syscall

	move $a0,$t0
	li $v0, 1
	syscall

	li $v0, 10
	syscall
