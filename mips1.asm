.data 
msg1: .asciiz "Enter numerator: "
msg2: .asciiz "Enter denominator: "
msg3: .asciiz "Quotient is: "
msg4: .asciiz "Remainder is: "
error_msg: .asciiz "Error: Division by zero\n"

.text 
# Display message for entering the numerator
li $v0, 4
la $a0, msg1
syscall

# Read the numerator from the user
li $v0, 5
syscall
move $t0, $v0   # Store the numerator in $t0

# Display message for entering the denominator
li $v0, 4
la $a0, msg2
syscall

# Read the denominator from the user
li $v0, 5
syscall
move $t1, $v0   # Store the denominator in $t1

# Check if denominator is not zero
beqz $t1, division_by_zero

# Perform division
div  $s0 ,$t0, $t1   # $t0 / $t1, quotient in $t0, remainder in $t1

# Separate remainder into a new variable
mfhi $t2   # $t2 = remainder

# Display message for the quotient
li $v0, 4
la $a0, msg3
syscall

# Display the quotient
move $a0, $s0
li $v0, 1
syscall

# Display message for the remainder
li $v0, 4
la $a0, msg4
syscall

# Display the remainder
move $a0, $t2
li $v0, 1
syscall

# Exit program
li $v0, 10
syscall

division_by_zero:
# Display error message for division by zero
li $v0, 4
la $a0, error_msg
syscall

# Exit program
li $v0, 10
syscall