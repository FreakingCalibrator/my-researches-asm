global _start
section .data
msg db "res="
section .text
_start:
    mov rcx, msg
    mov al, 255
    add al, 1
    cmovc rsi, rcx
    xor rax, rax
    mov rax, 1
    mov rdi, 1
    mov rdx, 5
    syscall

    mov     rax, 60        ; exit
    xor     rdi, rdi       ; код возврата = 0
    syscall