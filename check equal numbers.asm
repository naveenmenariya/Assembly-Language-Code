    .data
prompt: .asciiz "Enter the first integer: "
prompt2: .asciiz "Enter the second integer: "
equalMsg: .asciiz "The two integers are equal.\n"
notEqualMsg: .asciiz "The two integers are not equal. \n"

    .text
    # Prompt for the first integer
    li $v0, 4           # Step 1
    la $a0, prompt      # Step 2
    syscall             # Step 3

    # Read the first integer
    li $v0, 5           # Step 1
    syscall             # Step 3
    move $t0, $v0       # Step 4

    # Prompt for the second integer
    li $v0, 4           # Step 1
    la $a0, prompt2     # Step 2
    syscall             # Step 3

    # Read the second integer
    li $v0, 5           # Step 1
    syscall             # Step 3
    move $t1, $v0       # Step 4

    # Check if the integers are equal
    beq $t0, $t1, equal   # If equal, jump to equal label
    # Display message for not equal
    li $v0, 4             # Step 1
    la $a0, notEqualMsg   # Step 2
    syscall               # Step 3
    j exit                # Jump to exit

equal:
    # Display message for equal
    li $v0, 4            # Step 1
    la $a0, equalMsg     # Step 2
    syscall              # Step 3

exit:
    # Exit the program
    li $v0, 10           # Step 1
    syscall              # Step 3
