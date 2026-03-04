bits 64

section .data

section .text

global area
area:
    enter 0, 0
    mov rax, 0
    mov r8d, [rdi + 0]
    mov rax, [rdi + 4]
    cmp rsi, 1
    je .triangle_area
    cmp rsi, 2
    je .rectangle_area


    .triangle_area:
        mul r8d
        jmp .end
    .rectangle_area:
        mov r10d, 2
        mul r8d
        div r10d
        jmp .end
    .end:
        leave
        ret


global div
div:
    enter 0, 0
    mov r9, 0
    mov r8, rdx
    .loop:
        cmp r9, 5
        je .end
        mov qword rax, [rdi + r9 * 8]
        xor rdx, rdx
        div r8
        mov qword [rsi + r9*8],rdx
        inc r9
        jmp .loop
    .end:
        leave
        ret

global prime_div
prime_div:
    enter 0, 0
    mov r9,0
    mov r11d,0
    .loop:
        cmp r9,5
        je .end
        mov r10d,[rdi + r9 *4]
        cmp r10d,1
        jbe .end_loop
        mov r8d,2

    .is_prime_check:
        cmp r10d,r8d
        je .is_prime
        mov eax,r10d
        mov edx,0
        div r8d
        cmp edx,0
        je .end_loop
        inc r8d
        jmp .is_prime_check

    .is_prime:
        add r11d,r10d
    .end_loop:
        inc r9
        jmp .loop
    .end:
        mov eax,r11d
        mov edx,0
        div rsi
        leave
        ret

