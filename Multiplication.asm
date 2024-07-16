.data
msg1: .asciiz "Enter the first number: "
msg2: .asciiz "Enter the second number: "
msg3: .asciiz "The product of the two numbers is: "

.text
# Prompt for the first number
li $v0, 4
la $a0, msg1
syscall

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

# Multiply the two numbers
mul $t2, $t0, $t1

# Display the result
li $v0, 4
la $a0, msg3
syscall

li $v0, 1
move $a0, $t2
syscall

# Exit the program
li $v0, 10
syscall
