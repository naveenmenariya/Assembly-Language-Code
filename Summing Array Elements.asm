.data
array: .word 9, 6, 3, 2, 9
msg: .asciiz "Sum of Array Elements: "

.text
main:
    addi $t0, $zero, 5      # Size of array is 5
    lui $s1, 0x1001         # Starting address of the given array is 0x10010000
    li $s0, 0               # Initialize sum to 0
    
loop:
    lw $s2, 0($s1)          # Load array element into $s2
    add $s0, $s0, $s2       # Add array element to sum
    addi $s1, $s1, 4        # Point to address of next element of array
    addi $t0, $t0, -1       # Decrement the counter
    bne $t0, $zero, loop    # Repeat loop if counter is not zero
    
    # Print the message
    li $v0, 4
    la $a0, msg
    syscall
    
    # Print the sum of elements
    li $v0, 1
    move $a0, $s0
    syscall

    # Exit program
    li $v0, 10
    syscall
