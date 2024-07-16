.data
msg1: .asciiz "Enter the first number: "
msg2: .asciiz "Enter the second number: "
msg4: .asciiz "The XOR of the two numbers is: "

.text
.globl main
main:
    # Prompt for the first number
    li $v0, 4            # Load the syscall code for print_string into $v0
    la $a0, msg1         # Load address of msg1 into $a0
    syscall              # Make syscall to print the string

    # Read the first number
    li $v0, 5        
    syscall          
    move $t0, $v0

    # Prompt for the second number
    li $v0, 4          
    la $a0, msg2       
    syscall            

    # Read the second number
    li $v0, 5           
    syscall            
    move $t1, $v0      

    # XOR using arithmetic operations and multiplication

    # Calculate not A: ~A
    nor $t2, $t0, $zero  # $t2 = ~A (bitwise NOT of A)

    # Calculate not B: ~B
    nor $t3, $t1, $zero  # $t3 = ~B (bitwise NOT of B)

    # Calculate not A and B: (~A) * B
    mul $t4, $t2, $t1    # $t4 = (~A) * B

    # Calculate A and not B: A * (~B)
    mul $t5, $t0, $t3    # $t5 = A * (~B)

    # Add the results: (~A) * B + A * (~B)
    add $t6, $t4, $t5    # $t6 = $t4 + $t5

    # Display the result of XOR
    li $v0, 4            # Load the syscall code for print_string into $v0
    la $a0, msg4         # Load address of msg4 into $a0
    syscall              # Make syscall to print the string

    li $v0, 1            # Load the syscall code for print_int into $v0
    move $a0, $t6        # Move XOR result from $t6 to $a0
    syscall              # Make syscall to print the integer

    # Exit the program
    li $v0, 10           # Load the syscall code for exit into $v0
    syscall              # Make syscall to exit the program
