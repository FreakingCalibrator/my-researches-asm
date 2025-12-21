section .data
    probel db 32
section .bss
    msg resb 100
    num1 resb 100
    num2 resb 100
section .text
global _start
_start:
    call read

    mov al, 32
    mov rdx, num1
    mov rdi, msg
    call parse
    mov rdx, num2
    mov al, 0x0
    call parse

    mov rsi, num1
    mov rdx, 100
    call write

    mov rsi, probel
    mov rdx, 1
    call write

    mov rsi, num2
    mov rdx, 100
    call write
    ;end
    mov rax, 60
    mov rdi, 0
    syscall

read:
    mov rdi, 0
    mov rsi, msg
    mov rdx, 100
    mov rax, 0
    syscall
    ret

parse:
    mov rbx, rdi
    mov rcx, -1
    repne scasb
    push rdi
    sub rdi, rbx
    sub rdi, 1
    mov rcx, rdi
    mov rsi, rbx
    mov rdi, rdx
    rep movsb
    pop rdi
    ret

write:
    mov rdi, 1
    mov rax, 1
    syscall
    ret
