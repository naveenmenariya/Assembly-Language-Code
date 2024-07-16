.data
msg1: .asciiz "Enter the first number: "
msg2: .asciiz "Enter the second number: "
msg3: .asciiz "The logical AND of the two numbers is: "
msg4: .asciiz "The XOR of the two numbers is: "


.text
# Prompt for the first number
li $v0, 4          # Load the syscall code for print_string into $v0                load immediate            Syscall Code 4 (print_string)
la $a0, msg1   # Load address of msg1 into $a0                                      load address
syscall
# Read the first number
li $v0, 5                                    #  Syscall Code 5 read int
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

# Logical AND
and $t2, $t0, $t1     # bitwise AND on $t0 and $t1, store result in $t2


# Display the result of logical AND
li $v0, 4
la $a0, msg3
syscall
li $v0, 1                                #     Syscall Code 1 (print_int)
move $a0, $t2     # Move the AND result from $t2 to $a0
syscall           # Make the syscall to print the integer


# XOR
xor $t3, $t0, $t1          # Perform XOR on $t0 and $t1, store result in $t3


# Display the result of XOR
li $v0, 4
la $a0, msg4
syscall
li $v0, 1
move $a0, $t3     # Move XOR result from $t3 to $a0
syscall

# Exit the program
li $v0, 10 
syscall

