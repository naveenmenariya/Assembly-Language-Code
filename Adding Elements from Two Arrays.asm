.data
array1: .word 2, 4, 6
array2: .word 3, 5, 7
array3: .word 0, 0, 0
msg: .asciiz "  "

.text
main:
    la $s1, array1      # Store the address of the first array in $s1
    la $s2, array2      # Store the address of the second array in $s2
    la $s3, array3      # Store the address of the third array in $s3
    li $s0, 0           # Loop counter
    
loop:
    lw $s4, ($s1)       # Load element from array1
    lw $s5, ($s2)       # Load element from array2
    add $s6, $s4, $s5  # Add elements from array1 and array2
    sw $s6, ($s3)       # Store the result in array3

    # Print the result
    li $v0, 1
    move $a0, $s6
    syscall

    # Print a space between results
    li $v0, 4
    la $a0, msg
    syscall

    addi $s1, $s1, 4    # Move to the next element of array1
    addi $s2, $s2, 4    # Move to the next element of array2
    addi $s3, $s3, 4    # Move to the next element of array3
    addi $s0, $s0, 1    # Increment loop counter
    blt $s0, 3, loop    # Continue looping if counter < 3

    # Exit program
    li $v0, 10
    syscall
