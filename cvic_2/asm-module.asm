    bits 64

    section .data

    extern apps_string_i,rgba_string,g_int_array,g_char_array,g_char_array

    global apps_chars,rgba_int,g_neg_val_array,g_int_outup
    g_neg_val_array resd 15
    g_int_outup     resd 1
    temp_num       dd      0                    ; int
    temp_dec       dd      0                    ; int
    temp_flag      dd      0                    ; bool

    rgba_int       dd      0                    ; int
    apps_chars     db      0,0,0,0            ; char[ 4 ]
    pi:            dd      3.14159
    section .text

;***************************************************************************
    global convert_rgba
convert_rgba:
    mov eax, 0
    mov al, [rgba_string + 0]
    mov [ rgba_int + 2 ], al
    mov al, [rgba_string + 1]
    mov [ rgba_int + 1 ], al
    mov al, [ rgba_string + 2 ]
    mov [ rgba_int + 0 ], al
    mov byte [ rgba_int + 3 ], 0
    ret

    global access_string
access_string:
    mov al, [ apps_string_i + 2 ]
    mov [apps_chars + 0], al
    mov al, [ apps_string_i + 1 ]
    mov [apps_chars + 1], al
    mov al, [ apps_string_i + 0 ]
    mov [apps_chars + 2], al
    mov al, [ apps_string_i + 3 ]
    mov [apps_chars + 3], al
    ret

    ; temp = rdi
    ; moist = rdx
    global temp_func
temp_func:
    enter 0,0
    mov rax, rdi
    mov dword [rdx], eax
    and dword [rdx], 0xFFFF
    shr rax, 16
    mov dword [rsi], eax
    and dword [rsi], 0xFFFF
    mov rcx, 0
    mov ecx, [rdx]
    add ecx, [rsi]
    and ecx, 0xFFFE
    mov rax, 0
    mov eax, ecx
    leave
    ret


    global sum
sum:
    enter 0, 0
    xor rax, rax
    mov eax, edi
    add eax, esi
    sub eax, edx
    add eax, 100
    leave
    ret

    global display
display:
    enter 0, 0
    xor rax, rax
    dec esi
    mov ecx, esi
    loopstart:
        cmp dword [rdi + rcx*4],0
        je skip_mask
        and dword [rdi + rcx*4], 0x00FFFFFF
        xor dword [rdi + rcx*4], 0x00FFFFFF
    skip_mask:
        dec rcx
        jns loopstart
    leave
    ret

    global string_convert
string_convert:
    enter 0, 0
    mov rcx, 0
    mov eax, 0
    loop_string:
        cmp byte [rdi + rcx],0
        je end
        cmp byte [rdi + rcx], 'a'
        je change
        jmp next
    change:
        mov byte [rdi +rcx], 'A'
        inc eax
    next:
        inc rcx
        jmp loop_string
    end:
        leave
        ret

    global rand_print_asm
    extern print_val
    extern get_random
rand_print_asm:
    enter 0,0
    call get_random
    mov ecx, eax
    push rcx
    sub rsp, 8
    call get_random
    add rsp, 8
    pop rcx
    add ecx, eax
    mov edi,ecx
    call print_val
    leave
    ret

global edit_number
edit_number:
    enter 12,0
    mov ecx, edi
    mov dword [rbp - 4], edi
    add edi, ecx
    mov [rbp - 8], edi
    add edi, ecx
    mov [rbp - 12], edi
    mov eax,[rbp - 4]
    add eax,[rbp - 8]
    add eax,[rbp - 12]
    leave
    ret

global calculate_circle
calculate_circle:
    enter 0,0
    mulss xmm0,xmm0
    cvtsi2ss xmm1,rdi
    movss xmm2,[rel pi]
    mulss xmm0,xmm2
    mulss xmm0,xmm1
    leave
    ret

global edit_data
edit_data:
    enter 0,0
    mov rcx, 0
    mov eax, 0
    edit_data_loop:
        cmp dword esi, ecx
        je end_edit_data_loop
        mov r8, rcx
        imul r8, 12
        cmp byte [rdi + r8 + 8], 'X'
        je next_edit_data_loop
        movss xmm0,dword [rdi + r8 + 4]
        addss xmm0,xmm0
        movss dword [rdi + r8 + 4],xmm0
        inc eax
    next_edit_data_loop:
        add dword [rdi + r8 + 0],1
        inc rcx
        jmp edit_data_loop
    end_edit_data_loop:
        leave
        ret

; task 11
global sum_diagonal
sum_diagonal:
    enter 0,0
    mov rcx,0
    mov rax,0
    sum_loop:
        cmp rcx,rsi
        je end_sum_diagonal
        mov r8,[rdi + rcx*8]
        add eax,[r8 + rcx*4]
        inc rcx
        jmp sum_loop
    end_sum_diagonal:
        leave
        ret


;; task 12
global factorial
factorial:
    enter 0,0
    cmp rdi,1
    je base_factorial_case
    cmp rdi,0
    je base_factorial_case
    push rdi
    sub rsp, 8
    dec rdi
    call factorial
    add rsp, 8
    pop rdi
    mul rdi
    jmp factorial_end
    base_factorial_case:
        mov rax,1

    factorial_end:
        leave
        ret

global add_float_arrays
add_float_arrays:
    enter 0,0
    mov r8d, 0
    add_float_array_lopp:
        cmp r8d,ecx
        je add_float_array_end
        movups xmm0,[rdi+r8*4]
        movups xmm1,[rsi+r8*4]
        addps xmm0,xmm1
        movups [rdx+r8*4],xmm0
        add r8d,4
        jmp add_float_array_lopp
    add_float_array_end:
    leave
    ret

global edit_int
edit_int:
    enter 0,0
    mov eax,0
    mov rcx,0
    edit_int_loop:
        cmp rcx,15
        je edit_int_end
        cmp [g_int_array + rcx*4],0
        jl copy_negative
        aa:
        test [g_int_array + rcx*4],1
        je add_even
        bb:
        inc rcx
        jmp edit_int_loop
    add_even:
        mov r9d, [g_int_array + rcx*4]
        add [g_int_outup], r9d
        jmp bb
    copy_negative:
        mov r9d,[g_int_array + rcx*4]
        mov [g_neg_val_array + rax*4], r9
        inc rax
        jmp aa
    edit_int_end:
        mov eax, [g_int_outup]
        xor edx, edx
        mov ecx, 4
        div ecx
        neg eax
        mov [g_int_outup], eax
        leave
        ret
global conver_string
conver_string:
    enter 0,0
    mov rcx,0
    mov rdx,0
    .loop:
        cmp rcx,32
        je .end
        mov al, [g_char_array + rcx]
        cmp al, 'a'
        je .is_vowel
        cmp al, 'e'
        je .is_vowel
        cmp al, 'i'
        je .is_vowel
        cmp al, 'o'
        je .is_vowel
        cmp al, 'u'
        je .is_vowel
    .loop_end:
        inc rcx
        jmp .loop
    .is_vowel:
        mov byte [g_char_array + rcx],'3'
        inc rdx
        jmp .loop_end
    .end:
        mov rax,rdx
        leave
        ret
