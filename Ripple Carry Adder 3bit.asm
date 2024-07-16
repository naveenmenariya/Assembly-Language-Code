.data
array1: .word 1, 1, 1
array2: .word 1, 0, 1
size: .word 3
result: .word 0, 0, 0
newline: .asciiz "\n"
final_carr: .asciiz "final carry is "
final_sum: .asciiz "final sum is "

.text

main:
    # Load addresses and size
    la $t0, array1               # Load address of array1 into $t0
    la $t1, array2               # Load address of array2 into $t1
    lw $t2, size                 # Load size of arrays into $t2
    la $t3, result               # Load address of result into $t3
    addiu $t0, $t0, 8            # Move $t0 to point to the last element of array1   Add Immediate Unsigned
    addiu $t1, $t1, 8            # Move $t1 to point to the last element of array2
    addiu $t3, $t3, 8            # Move $t3 to point to the last element of result
    li $t5, 0                    # Initialize carry to 0

    loop:
        # Load current elements
        lw $t4, 0($t0)           # Load element from array1 into $t4
        lw $t6, 0($t1)           # Load element from array2 into $t6

        # Calculate sum bit
        xor $t7, $t4, $t6        # $t7 = array1[i] XOR array2[i]
        xor $t8, $t7, $t5        # $t8 = (array1[i] XOR array2[i]) XOR carry

        # Calculate carry
        and $t9, $t4, $t6        # $t9 = array1[i] AND array2[i]
        and $t4, $t7, $t5        # $t4 = (array1[i] XOR array2[i]) AND carry
        or $t5, $t9, $t4         # $t5 = new carry

        # Store the sum bit in result array
        sw $t8, 0($t3)

        # Move to the previous elements
        subu $t0, $t0, 4         # Move to the previous element in array1
        subu $t1, $t1, 4         # Move to the previous element in array2
        subu $t3, $t3, 4         # Move to the previous element in result
        addiu $t2, $t2, -1       # Decrease size counter
        bnez $t2, loop           # Repeat loop if $t2 != 0

    # Print final carry
    li $v0, 4
    la $a0, final_carr           # Load final carry message
    syscall

    li $v0, 1
    move $a0, $t5                # Load final carry value
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    # Print final sum
    la $t3, result               # Reset $t3 to the start of the result array
    lw $t2, size                 # Reset $t2 to size

    li $v0, 4
    la $a0, final_sum            # Load final sum message
    syscall

print_loop:
    lw $a0, 0($t3)               # Load current result element
    li $v0, 1
    syscall

    addiu $t3, $t3, 4            # Move to the next result element
    addiu $t2, $t2, -1           # Decrease size counter
    bnez $t2, print_loop         # Repeat if $t2 != 0

    la $a0, newline
    li $v0, 4
    syscall

    # Exit program
    li $v0, 10
    syscall
