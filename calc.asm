global _start
section .bss
arr resb 5
section .text
_start:
    mov byte[arr+2], 52
    mov byte[arr], 50
    mov byte[arr+1], 51
    mov byte[arr+3], 52
    mov byte[arr+4], 0x0
    mov rax, 1
    mov rdi, 1
    mov rsi, arr
    mov rdx, 5
    syscall
end:
    mov rax, 60        ; exit
    xor rdi, rdi       ; код возврата = 0
    syscall