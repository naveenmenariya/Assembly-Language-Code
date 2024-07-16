.data
string1: .asciiz "enter a number:"
endline: .asciiz "\n"
string2: .asciiz "a is equal to b"
string3: .asciiz "a is not equal to b"

.text
li $v0,4
la $a0,string1
syscall
li $v0,5
syscall
move $t0,$v0

li $v0,4
la $a0,string1
syscall
li $v0,5
syscall
move $t1,$v0

beq $t0,$t1,if_label
j else_label

if_label:
li $v0,4
la $a0,string2
syscall
j end_label

else_label:
li $v0,4
la $a0,string3
syscall

end_label:
li $v0,10   #exit
syscall