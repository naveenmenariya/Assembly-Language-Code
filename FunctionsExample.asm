.data
msg1: .asciiz "Enter 1st number: "
msg2: .asciiz "Enter 2nd number: "
msg3: .asciiz "Sum is: "
msg4: .asciiz "\nDifference is: "
msg5: .asciiz "\nProduct is: "
msg6: .asciiz "\nQuotient is: "
msg7: .asciiz "\nRemainder is: "

.text
main:
    # Prompt for input
    li $v0, 4
    la $a0, msg1
    syscall

    # Read input for the 1st number
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, msg2
    syscall

    # Read input for the 2nd number
    li $v0, 5
    syscall
    move $t1, $v0

    jal calculate_sum
    li $v0, 4
    la $a0, msg3
    syscall
    li $v0, 1
    move $a0, $s1
    syscall

    jal calculate_difference
    li $v0, 4
    la $a0, msg4
    syscall
    li $v0, 1
    move $a0, $s2
    syscall

    jal calculate_product
    li $v0, 4
    la $a0, msg5
    syscall
    li $v0, 1
    move $a0, $s3
    syscall

    jal calculate_quotient_and_remainder
    li $v0, 4
    la $a0, msg6
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, msg7
    syscall
    li $v0, 1
    move $a0, $s5
    syscall

    # Terminate execution
    li $v0, 10
    syscall

calculate_sum:
    add $s1, $t0, $t1
    jr $ra

calculate_difference:
    sub $s2, $t0, $t1
    jr $ra

calculate_product:
    mul $s3, $t0, $t1
    jr $ra

calculate_quotient_and_remainder:
    div $t0, $t1
    mflo $s4
    mfhi $s5  
    jr $ra
