.data
msg1: .asciiz "Enter the starting number: "
msg2: .asciiz "Enter the ending number: "
msg3: .asciiz "The sum of odd numbers in the range is: "

.text
li $v0, 4
la $a0, msg1
syscall

li $v0, 5
syscall
move $t0, $v0

li $v0, 4
la $a0, msg2
syscall

li $v0, 5
syscall
move $t1, $v0

li $t2, 0

calc_sum:
    andi $t3, $t0, 1
    bne $t3, $zero, add_to_sum

    addi $t0, $t0, 1

    bgt $t0, $t1, print_sum

    j calc_sum

add_to_sum:
    add $t2, $t2, $t0

    addi $t0, $t0, 1

    bgt $t0, $t1, print_sum

    j calc_sum

print_sum:
    li $v0, 4
    la $a0, msg3
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

li $v0, 10
syscall
