    bits 64

    section .data

    extern g_encoded,g_char_array,g_long_array,g_counter,g_output,g_to_replace,g_new

    section .text

;***************************************************************************

global work_int
work_int:
    mov rcx,0
    mov eax,0
    .loop:
        cmp rcx,5
        je .end
        mov r8,[g_long_array + rcx*8]
        test r8,1
        jne .odd
        add rax,r8
        .end_loop:
            inc rcx
        jmp .loop
    .odd:
        inc [g_counter]
        jmp .end_loop
    .end:
    mov ecx,0
    .div:
        mov r8,rax
        sub r8,7
        cmp r8,0
        jl .end_div
        inc ecx
        sub rax,7
        jmp .div
    .end_div:
        mov [g_output],ecx
        not dword [g_counter]
        ret

global replace_string
replace_string:
    mov rcx,0
    mov r9b,[g_new]
    mov byte r8b,[g_to_replace]
    .loop_s:
        cmp [g_char_array + rcx*4],0
        je .end_s
        cmp [g_char_array + rcx*4],r8b
        je .replace_s
    .end_loop_s:
        inc rcx
        jmp .loop_s

    .replace_s:
        mov [g_char_array + rcx*4],r9b
        jmp .end_loop_s
    .end_s:
        ret

global decode
decode:
    mov rcx, 0
.loop_s:
    cmp rcx, 6
    je .end_s
    mov r8b, [g_encoded + rcx]
    cmp r8b, 'A'
    jb .decode
    cmp r8b, 'Z'
    ja .decode
    add r8b, 32
.decode:
    cmp r8b, 'a'
    jb .store
    cmp r8b, 'z'
    ja .store
    add r8b, 13
    cmp r8b, 'z'
    jbe .store
    sub r8b, 26
.store:
    mov [g_encoded + rcx], r8b
    inc rcx
    jmp .loop_s
.end_s:
    ret
