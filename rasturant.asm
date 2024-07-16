section .data
array dd 8, 3, 1, 7, 0, 4, 2, 9
array_len equ 8

section .text
global _start

_start:
    ; Display original array
    mov esi, array
    mov ecx, array_len
    call display_array

    ; Call Insertion Sort
    mov esi, array
    mov edx, array_len
    call insertion_sort

    ; Display sorted array
    mov esi, array
    mov ecx, array_len
    call display_array

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

insertion_sort:
    ; Outer loop for iterating over each element
    mov ebx, 1 ; Start from the second element (index 1)
outer_loop:
    cmp ebx, edx ; Check if ebx >= array length
    jge end_outer_loop

    ; Inner loop for shifting elements to the right
    mov esi, ebx ; Set esi to current index
inner_loop:
    cmp esi, 0 ; Check if esi <= 0
    jle end_inner_loop

    ; Compare current element with previous element
    mov eax, [esi*4 + esi*4 - 4] ; Previous element
    mov ecx, [esi*4] ; Current element
    cmp eax, ecx
    jle end_inner_loop ; If previous element <= current element, end inner loop

    ; Swap elements
    mov edx, [esi*4 + esi*4 - 4] ; Previous element
    mov [esi*4 + esi*4 - 4], ecx ; Current element
    mov [esi*4], edx ; Previous element
    dec esi ; Move to previous index
    jmp inner_loop

end_inner_loop:
    inc ebx ; Move to next index
    jmp outer_loop

end_outer_loop:
    ret

display_array:
    ; Display array elements separated by spaces
    mov eax, 4
    mov ebx, 1
    mov edx, 1

display_loop:
    mov eax, [esi]
    call display_number
    add esi, 4
    dec ecx
    jnz display_loop

    ; Newline
    mov eax, 4
    mov ebx, 1
    mov edx, newline
    mov ecx, newline_len
    int 0x80
    ret

display_number:
    ; Convert integer to string and display
    push eax ; Save eax
    push ecx ; Save ecx

    mov eax, eax ; Value to convert
    mov ebx, 10 ; Base
    mov ecx, num_buffer ; Destination buffer
    call itoa ; Convert integer to string

    mov eax, 4 ; syscall: sys_write
    mov ebx, 1 ; file descriptor: stdout
    mov ecx, num_buffer ; pointer to string
    mov edx, num_len ; string length
    int 0x80 ; call kernel

    pop ecx ; Restore ecx
    pop eax ; Restore eax
    ret

itoa:
    ; Convert integer in eax to string in ecx
    mov esi, ecx ; Store destination pointer
    mov edi, ecx ; Store start pointer

    add ecx, 11 ; Move pointer to the end of string

    mov byte [ecx], 0 ; Null-terminate string

    dec ecx ; Move pointer to last character

convert_loop:
    xor edx, edx ; Clear edx for division
    div ebx ; Divide eax by 10, quotient in eax, remainder in edx
    add dl, '0' ; Convert remainder to ASCII
    dec ecx ; Move pointer to previous character
    mov [ecx], dl ; Store ASCII character
    test eax, eax ; Check if quotient is zero
    jnz convert_loop ; Jump if not zero

    mov eax, edi ; Restore start pointer
    mov ecx, esi ; Restore destination pointer
    ret

section .bss
    num_buffer resb 12 ; Maximum of 12 characters for displaying a number
    num_len equ $ - num_buffer
    newline db 0xA ; Newline character
    newline_len equ $ - newline
