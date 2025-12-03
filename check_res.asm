section .data
msg: db "Hello there!", 0xA
section .text
global _start
_start:
    call print
    mov     rax, 60        ; exit
    xor     rdi, rdi       ; код возврата = 0
    syscall
print:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 12
    syscall
    ret