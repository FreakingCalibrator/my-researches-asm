section .data
    align 8
    arr dq 1,2,3,4,5,6,7,8

section .bss
    outbuf resb 20

section .text
    global _start

_start:    
    mov rsi, arr
    mov rcx, 2
    xor r8, r8
    loopSQRT:
        mov rax, [rsi]
        mul rax
        add r8, rax
        
        mov rax, [rsi+8]
        mul rax
        add r8, rax
        
        mov rax, [rsi+16]
        mul rax
        add r8, rax
        
        mov rax, [rsi+24]
        mul rax
        add r8, rax
        lea rsi, [rsi+32]
        loop loopSQRT
    ; ====================================================
    ; BEGIN: ваш код здесь
    ; Нужно:
    ; 1. Проитерировать массив arr
    ; 2. Посчитать sum += arr[i]*arr[i]
    ; 3. Минимизировать обращения к памяти:
    ;    - один раз грузим arr[i] в регистр
    ;    - все вычисления в регистрах
    ; 4. Сохранить результат в r8
    ; ====================================================
    ; END: ваш код выше
    ; ====================================================

    ; --- перевод r8 в строку и write ---
    mov rax, r8
    mov rbx, 10
    mov rcx, outbuf + 19
    mov byte [rcx], 10
    dec rcx

.convert_loop:
    xor rdx, rdx
    div rbx
    mov r10b, dl
    add r10b, '0'
    mov [rcx], r10b
    dec rcx
    test rax, rax
    jnz .convert_loop
    inc rcx

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, outbuf + 20
    sub rdx, rcx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall