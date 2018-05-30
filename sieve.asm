	.data
Integer: .asciiz "Enter integer: "
Space:	.asciiz	" "

	.text
main:
	la $a0, Integer
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	li $s0, 0x00000000
	li $s1, 0x11111111
	move $t9, $v0

	add $s2, $sp, 0

	li $t0, 2

init:
	sw $s1, ($sp)
	add	$t0, $t0, 1
	sub	$sp, $sp, 4
	ble	$t0, $t9, init

	li $t0, 1

outer:
	add $t0, $t0, 1
	mul	$t1, $t0, $t0
	bgt	$t1, $t9, print

check:
	add	$t2, $s2, 0
	mul	$t3, $t0, 4
	sub	$t2, $t2, $t3
	add	$t2, $t2, 8

	lw $t3, ($t2)

	beq	$t3, $s0, outer

inner:
	add	$t2, $s2, 0
	mul	$t3, $t1, 4
	sub	$t2, $t2, $t3
	add	$t2, $t2, 8

	sw $s0, ($t2)

	add	$t1, $t1, $t0
	bgt	$t1, $t9, outer

	j inner

print:
	li $t0, 1

count:
	add	$t0, $t0, 1

	bgt	$t0, $t9, exit

	add	$t2, $s2, 0
	mul	$t3, $t0, 4
	sub	$t2, $t2, $t3
	add	$t2, $t2, 8

	lw	$t3, ($t2)
	beq	$t3, $s0, count

	add	$t3, $s2, 0

	sub	$t3, $t3, $t2
	div	$t3, $t3, 4
	add	$t3, $t3, 2

	li	$v0, 1
	add	$a0, $t3, 0
	syscall

	li	$v0, 4
	la	$a0, Space	
	syscall

	ble	$t0, $t9, count

exit:
	li $v0, 10
    syscall
