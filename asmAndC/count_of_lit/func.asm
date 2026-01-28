section .text
global count_of_Lit     ;rdi- Lit   ;rsi- word
count_of_Lit:
    push rbx
    mov r8, rdi
    mov rdi, rsi
    mov rcx, -1
    mov al, 0
    xor rdx, rdx
    xor rbx, rbx
    repne scasb
    sub rdi, rsi
    mov rcx, rdi
    .loop:
        movzx r9, byte[rsi]
        cmp r9, r8
        sete bl
        add rdx, rbx
        inc rsi
        loop .loop
    pop rbx
    mov rax, rdx
    ret
