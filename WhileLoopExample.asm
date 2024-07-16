 .data
string1: .asciiz "Enter Number: "
sum: .asciiz "Sum of digits is: "

.text
li $v0,4
la $a0,string1
syscall

li $v0,5
syscall
move $t0,$v0

move $t1,$t0
li $t2,0

while:
	beq $t1,$zero,endWhile
	rem $t3,$t1,10
	#123%10 = 3
	add $t2,$t2,$t3
	div $t1,$t1,10
	j while
	
endWhile: 
	li $v0,4
	la $a0,sum
	syscall
	
#prints sum
li $v0,1
move $a0,$t2
syscall

end_label: 
li $v0,10
syscall
