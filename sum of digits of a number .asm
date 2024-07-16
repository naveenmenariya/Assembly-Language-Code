    .data
prompt: .asciiz "Enter a number: "
sum_msg: .asciiz "The sum of the digits is: "

    .text
main:
    # Prompt for the number
    li $v0, 4           # Step 1
    la $a0, prompt      # Step 2
    syscall             # Step 3

    # Read the number
    li $v0, 5           # Step 1
    syscall             # Step 3
    move $t0, $v0       # Step 4

    # Initialize sum to 0
    li $t1, 0           # Initialize $t1 to store the sum

loop:
    # Check if the number is 0
    beq $t0, $zero, exit_loop   # If $t0 is 0, exit the loop

    # Get the last digit of the number
    div $t0, $t0, 10    # Divide $t0 by 10
    mfhi $t2            # Remainder is the last digit
    add $t1, $t1, $t2   # Add the last digit to the sum

    # Shift the number to the right by one digit
    mflo $t0            # Quotient is the number without the last digit

    # Repeat the loop
    j loop

exit_loop:
    # Display the sum of digits
    li $v0, 4             # Step 1
    la $a0, sum_msg       # Step 2
    syscall               # Step 3

    # Print the sum stored in $t1
    li $v0, 1             # Step 1
    move $a0, $t1         # Step 2
    syscall               # Step 3

    # Exit the program
    li $v0, 10            # Step 1
    syscall               # Step 3
