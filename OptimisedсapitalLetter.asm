section .bss
    buffer resb 100
    outbuf resb 20

section .text
    global _start

_start:
    ; --- read(stdin, buffer, 100) ---
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 100
    syscall
    
    mov rcx, -1
    mov rdi, rsi
    mov al, 0xa
    repne scasb
    sub rdi, rsi
    mov rcx, rdi
    dec rcx

    xor rbx, rbx
    xor rax, rax
    loopLetter:
        movzx r8, byte[rsi+rbx]
        mov rdx, 1
        cmp r8, 65
        setae dl
        cmp r8, 90
        setbe dl
        add rax, rdx
        inc rbx
        loop loopLetter

    ; ====================================================
    ; BEGIN: ваш код здесь
    ; Нужно:
    ; 1. Пройти по buffer до '\n' или конца
    ; 2. Посчитать количество заглавных букв A-Z
    ; 3. Минимизировать обращения к памяти и количество ветвлений
    ; 4. Сохранить результат в r8
    ; ====================================================
    ; END: ваш код выше
    ; ====================================================

    ; --- перевод r8 в строку и write ---
    ;mov rax, r8
    dec rax
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