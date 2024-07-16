.data
msg1: .asciiz "Enter a positive integer: "
msg2: .asciiz "Factorial is: "

.text
main:
    li $v0, 4         
    la $a0, msg1
    syscall

    li $v0, 5         
    syscall
    move $t0, $v0     

    li $t1, 1          # factorial calculation
    li $t2, 1          # counting the factorial

Loopstart: 
    bgt $t2, $t0, endloop  
    mul $t1, $t1, $t2   
    addi $t2, $t2, 1       
    j Loopstart

endloop:
    li $v0, 4         
    la $a0, msg2
    syscall

    move $a0, $t1  
    li $v0, 1        
    syscall

    li $v0, 10         
    syscall
