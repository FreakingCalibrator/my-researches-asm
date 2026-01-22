section .data
    path db "/bin/ls", 0
    arg1 db "/", 0
    arg2 db "-l", 0

    str0 db "Hello world!", 0x10
    str0C equ $-str0
    argv_array dq path, arg2, arg1, 0
    envp_array dq 0
section .bss
    child_status resd 1
section .text
global _start
_start:
    mov rax, 57 ;fork
    syscall
    cmp rax, 0
    jz child
    mov rax, 1              ;printf
    mov rdi, 1
    mov rsi, str0
    mov rdx, str0C
    syscall
    mov rax, 61          ; syscall waitpid
    mov rdi, -1          
    mov rsi, child_status 
    mov rdx, 0           
    syscall
    jmp finish
child:
    mov rax, 59
    mov rdi, path
    mov rsi, argv_array
    mov rdx, envp_array
    syscall
    mov rax, 60        ; exit
    xor rdi, 1       ; код возврата = 1
    syscall

finish:
    mov rax, 60        ; exit
    xor rdi, rdi       ; код возврата = 0
    syscall
