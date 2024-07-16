.data
space: .asciiz " "
no_solution: .asciiz "solution does not exist\n"
solution_exists_msg: .asciiz "solution exists\n"

sudoku: .word 0, 0, 8, 0, 0, 0, 0, 0, 0
        .word 4, 9, 0, 1, 5, 7, 0, 0, 2
        .word 0, 0, 3, 0, 0, 4, 1, 9, 0
        .word 1, 8, 5, 0, 6, 0, 0, 2, 0
        .word 0, 0, 0, 0, 2, 0, 0, 6, 0
        .word 9, 6, 0, 4, 0, 5, 3, 0, 0
        .word 0, 3, 0, 0, 7, 2, 0, 0, 4
        .word 0, 4, 9, 0, 3, 0, 0, 5, 7
        .word 8, 2, 7, 0, 0, 9, 0, 1, 3

.text
main:
    la $s0, sudoku     # Load base address of the sudoku array
    li $s1, 0          # Initialize current row to 0
    li $s2, 0          # Initialize current col to 0

    jal sudokuSolver   # Call the Sudoku solver function

    # Print result
    beq $v0, 1, solution_exists
    li $v0, 4
    la $a0, no_solution
    syscall
    j exit

solution_exists:
    li $v0, 4
    la $a0, solution_exists_msg
    syscall
    la $a0, sudoku
    jal printSudoku  # Print the solved Sudoku grid

    j exit

exit:
    li $v0, 10          # Exit syscall
    syscall

sudokuSolver:
    # Function Prologue
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    # Load current cell value
    sll $t0, $s1, 3           # $t0 = row * 9
    add $t0, $t0, $s2         # $t0 = row * 9 + col
    sll $t0, $t0, 2           # $t0 = (row * 9 + col) * 4 (each element is 4 bytes)
    add $s7, $s0, $t0         # Calculate address of current cell
    lw $s3, 0($s7)            # Load digit from current cell

    # Check if current cell is not empty
    bne $s3, $zero, not_empty

    # Base case: if last cell is reached
    beq $s1, 9, base_case

not_empty:
    # Calculate next cell index
    addi $s7, $s7, 4          # Move to the next cell
    li $s6, 9                 # Set the limit for column index
    blt $s2, $s6, next_col    # If column is less than 9, go to next column
    li $s2, 0                 # Reset column to 0
    addi $s1, $s1, 1          # Increment row
    j next_cell

next_col:
    addi $s2, $s2, 1          # Increment column

next_cell:
    jal sudokuSolver          # Recursive call for next cell
    j end_sudokuSolver

base_case:
    li $v0, 1
    j end_sudokuSolver

end_sudokuSolver:
    # Function Epilogue
    lw $ra, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 8
    jr $ra

printSudoku:
    li $t0, 0                   # Counter for row index
print_row_loop:
    bge $t0, 9, print_exit      # Exit loop if all rows are printed

    li $t1, 0                   # Counter for column index
print_col_loop:
    bge $t1, 9, print_newline   # Exit loop if all columns are printed

    sll $t2, $t0, 3             # $t2 = row * 9
    add $t2, $t2, $t1           # $t2 = row * 9 + col
    sll $t2, $t2, 2             # $t2 = (row * 9 + col) * 4 (each element is 4 bytes)
    add $t2, $s0, $t2           # Calculate address of current cell
    lw $a0, 0($t2)              # Load digit from current cell

    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t1, $t1, 1            # Increment column index
    j print_col_loop

print_newline:
    li $v0, 11
    li $a0, '\n'
    syscall

    addi $t0, $t0, 1            # Increment row index
    j print_row_loop

print_exit:
    jr $ra
