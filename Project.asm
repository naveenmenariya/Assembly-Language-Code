# Print the entered string as a pyramid
#################################################
#												#
#				  text segment					#
#												#
#################################################
	.text
	.globl __start	
__start:
#-------------start of main program-------------#
print_string:  
                la $a0, message       # Load address of the prompt message into $a0
                li $v0, 4             # Load the system call code for print_string into $v0
                syscall               # Make the system call to print the message

read_string:   
                li $v0, 8             # Load the system call code for read_string into $v0
                la $a0, string        # Load address of the input buffer into $a0
                li $a1, 26            # Load the buffer size (26 bytes) into $a1
                syscall               # Make the system call to read the input string

                li $s0, 6             # Initialize $s0 with 6 (used for pyramid height calculation)
                la $s1, string        # Load address of the input string into $s1

print_string_before:    
                        la $a0, string  # Load address of the input string into $a0
                        li $v0, 4       # Load the system call code for print_string into $v0
                        syscall         # Make the system call to print the input string

pyramid:    
            addi $s0, $s0, -1       # Decrement $s0 by 1 (used for space calculation)
            move $t0, $s0           # Move $s0 to $t0 (number of spaces)

            li $t3, 2
            mul $t4, $t0, $t3       # Calculate the number of spaces (2 * $t0)
            li $t5, 11
            sub $t3, $t5, $t4       # Calculate the number of characters in the line ($t3 = 11 - 2 * $t0)
        
            jal print_endl          # Jump to the print_endl procedure to print a new line
         
check:  
            li $s3, 3               # Load 3 into $s3 (used for last line check)
            beq $t0, $zero, loop_char  # If $t0 is zero, jump to loop_char

            li $s3, 0               # Initialize $s3 with 0 (flag)
loop_space: 
            print_space:    
                        la $a0, space   # Load address of the space string into $a0
                        li $v0, 4       # Load the system call code for print_string into $v0
                        syscall         # Make the system call to print a space

                        addi $t0, $t0, -1  # Decrement $t0 by 1
                        bne $t0, $zero, loop_space  # If $t0 is not zero, repeat loop_space
                        addi $s3, $s3, 1  # Increment $s3 (flag)
                        li $t6, 3
                        beq $s3, $t6, pyramid  # If $s3 equals 3, jump to pyramid

loop_char:
            print_char:     
                        lbu $a0, 0($s1)  # Load the next character of the input string into $a0
                        addi $s1, $s1, 1  # Move to the next character in the string
                        li $v0, 11        # Load the system call code for print_char into $v0
                        syscall           # Make the system call to print the character
                                        
                        addi $t3, $t3, -1  # Decrement $t3 by 1 
                        bne $t3, $zero, loop_char  # If $t3 is not zero, repeat loop_char

                        li $t6, 3
                        beq $s3, $t6, exit  # If $s3 equals 3, jump to exit
                        addi $s3, $s3, 1    # Increment $s3 (flag)
                        li $t6, 2
                        beq $s3, $t2, loop_space  # If $s3 equals 2, jump to loop_space

                    beq $t0, $zero, pyramid  # If $t0 is zero, jump to pyramid
            
                        
exit:   
                li $v0, 10          # Load the system call code for exit into $v0
                syscall             # Make the system call to exit
#-------------end of main program--------------#

#-------------start of procedures--------------#
print_endl:      
                la $a0, endl         # Load address of the newline string into $a0
                li $v0, 4            # Load the system call code for print_string into $v0
                syscall              # Make the system call to print a newline
                jr $ra               # Return from the procedure

#-------------end of procedures---------------#

#################################################
#			 									#
#     	 	      data segment				    #
#												#
#################################################

	.data
message: .asciiz "Give a string of 25 chars: "  # Prompt message
endl: 	.asciiz "\n"                          # Newline character
string: .space 26                              # Input buffer (26 bytes)
space:  .asciiz " "                            # Space character
