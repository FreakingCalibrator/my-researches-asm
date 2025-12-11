section .data
    strs db "Hello there", 10
    strsym db 'a'
section .bss
    strd resb 12
section .text
global _start
_start:
    exp1:
        mov rcx, 12
        mov rsi, strs
        mov rdi, strd
        rep movsb

    exp2:
        lea rsi, strsym
        lea rdi, [strd+1]
        movsb
    
    exp3:
        mov rsi, strd
        mov rdi, strs
        mov rcx, 12
        repe cmpsb
        mov rbx, 12
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