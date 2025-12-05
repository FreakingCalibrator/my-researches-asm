global _start
section .data
msg dd 1, 2, 3, 4, 5
msg1 db "Hello!", 0xA
section .text
_start:
    mov rcx, 4
    xor rbx, rbx
    mov rsi, msg1
    mov rdi, 1
    mov rdx, 7
circle:
    mov rax, 1
    mov rbx, rcx
    syscall
    mov rcx, rbx
    loop circle
finish:
    mov rax, 60        ; exit
    xor rdi, rdi       ; код возврата = 0
    syscall