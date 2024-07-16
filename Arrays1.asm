.data #Data segment
.word 7,2,5,2,8
msg: .asciiz "Sum of Array Elements: “
.text #Code segment
addi $t0, $0, 5 #Size of array is 5
lui $s1, 0x1001 #Starting address of the given array is 0x10010000
loop:
lw $s2, 0($s1) 
add $s0, $s0, $s2 #s0 = 0 initially
addi $s1, $s1, 4 #Point to address of next element of array
addi $t0, $t0, -1 #Decrement the counter
bne $t0, $0, loop
li $v0, 4 
la $a0, msg #Printing the message
syscall
li $v0, 1 
move $a0, $s0 
#Printing the sum of elements of the 
array
syscall
Exit:
li $v0,10
syscall


.data #Data segment
array1: .word 2,4,6
array2: .word 3,5,7
array3: .word 0,0,0
msg: .asciiz " "
.text #Code segment 
la $s1, array1 #Storing 1st array in s1
la $s2, array2 #Storing 2nd array in s2
la $s3, array3 #Storing 3rd array in s3
li $s0, 0 #Loop Counter
loop:
lw $s4, ($s1) 
lw $s5, ($s2)
add $s6, $s4, $s5
sw $s6, ($s3)
li $v0,1
move $a0,$s6 
#$a0 = array1[i] + array2[i]
syscall
li $v0, 4 
la $a0, msg
syscall
addi $s1, $s1, 4 #array1[i+=1]
addi $s2, $s2, 4 #array2[i+=1]
addi $s3, $s3, 4 #array3[i+=1]
addi $s0, $s0, 1 #count += 1
blt $s0, 3, loop 
#Execute loop if count < 3 because size of 
array = 3
Exit:
li $v0,10
syscall