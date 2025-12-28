section .data
    msg db "Hello, Stepic!", 0xA
    msglen equ $-msg
section .text
global _start
%macro Write 0
    mov rax, 1
    mov rdi, 1
    lea rdx, 5
    lea rsi, [msg]
    syscall
%endmacro

_start:
    Write
    mov rax, 60
    mov rdi, 0
    syscall