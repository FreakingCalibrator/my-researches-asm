section .data
filename db "HelloWorld.txt", 0
filename2 db "HelloWorld2.txt", 0
count equ 16
section .bss
buffer resb 100
fd resq 1
section .text
global _start:

_start:
    ;open
    mov rax, 2
    mov rdi, filename
    mov rsi, 0x40
    or rsi, 2
    mov rdx, 0777
    syscall
    mov [fd], rax

    ;write
    mov rax, 1
    mov rdi, [fd]
    mov rsi, filename2
    mov rdx, count
    syscall

    ;close
    mov rax, 3
    mov rdi, [fd]
    syscall

    mov rax, 60
    mov rdi, 0
    syscall