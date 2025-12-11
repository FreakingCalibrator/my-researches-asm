section .data
    strs db "Hello@gmail.com"
section .bss
    strsym resb 1
section .text
global _start
_start:
    mov rdi, strs
    mov al, '@'
    mov rcx, 15
    repne scasb

    mov rbx, 15
    sub rbx, rcx
    mov rcx, rbx
    add rcx, 48
    mov [strsym], rcx
    mov rsi, strsym

preend:
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
end:
    mov rax, 60        ; exit
    xor rdi, rdi       ; код возврата = 0
    syscall