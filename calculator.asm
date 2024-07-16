.data
msg1: .asciiz "Enter the 1st number: "
msg2: .asciiz "Enter the 2nd number: "
msg3: .asciiz "Results : "
msg4: .asciiz "\n Enter the operation \n1 for Addition, 2 for Subtraction,  \n3 for Division, 4 for Multiplication, \n5 for Remainder, 6 for Exit): "

.text
main:
    # Read the first number
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    # Read the second number
    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    # Loop for continuous operation until exit
Loop:
    # Read the operation
    li $v0, 4
    la $a0, msg4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    # Switch-case-like structure
    beq $t2, 1, Addition
    beq $t2, 2, Subtraction
    beq $t2, 3, Division
    beq $t2, 4, Multiplication
    beq $t2, 5, Remainder
    beq $t2, 6, Exit
    j Loop

Addition:
    add $s1, $t0, $t1
    j Print

Subtraction:
    sub $s1, $t0, $t1
    j Print

Division:
    div $t0, $t1
    mflo $s1
    j Print

Multiplication:
    mul $s1, $t0, $t1
    j Print

Remainder:
    rem $s1, $t0, $t1
    j Print

Print:
    li $v0, 4
    la $a0, msg3
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    j Loop

Exit:
    li $v0, 10
    syscall