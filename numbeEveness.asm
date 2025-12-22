section .data
    msg db "100001", 0x10
    Ev db "Even", 0x00
    OddStr db "Odd", 0x00
section .bss
    ;msg resb 100
section .text
global _start
_start:
;
    ;call read

    mov al, 0x10
    mov rdi, msg
    call parse

    xor rdx, rdx
    mov rbx, 2
    div rbx
    cmp dl, 1
    je Odd
    jmp Evensense
    Odd:
        mov rsi, OddStr
        mov rdx, 4
        call write
        jmp end
    Evensense:
        mov rsi, Ev
        mov rdx, 5
        call write
    end:
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
    mov rcx, -1
    repne scasb
    sub rdi, msg
    mov rcx, rdi
    xor rax, rax
    xor rbx, rbx

    .loopCtoI:
        imul rax, 10
        movzx rdx, byte [msg+rbx]
        sub rdx, 48
        add rax, rdx
        inc rbx
        loop .loopCtoI
    ret

write:
    mov rdi, 1
    mov rax, 1
    syscall
    ret
