section .bss
    msg resb 100
section .data
    pos db "Non-negative",0xa
    poslen equ $-pos
    negative db "Negative", 0xa
    neglen equ $-negative
section .text
global _start
%macro read 0
    mov rsi, msg
    mov rdi, 0
    mov rax, 0
    mov rdx, 100
    syscall
%endmacro

%macro write 2
    mov rax, 1
    mov rsi, %1
    mov rdx, %2
    mov rdi, 1
    syscall
%endmacro

_start:
    read
    xor rax, rax
    mov al, 0xa
    mov rdi, msg
    repne scasb

    sub rdi, rsi
    dec rdi
    mov rcx, rdi
    xor rbx, rbx
    xor rax, rax

    .loopparse:
        imul rax, 10
        movzx rdx, byte[rsi+rbx]
        cmp rdx, 0x2d
        je .cont
        sub rdx, 0x30
        add rax, rdx
        .cont:
            inc rbx
            loop .loopparse
    
    movzx rdx, byte[rsi]
    cmp rdx, 0x2d
    jne sign
    imul rax, -1   
    sign:
    cmp rax, 0
    jge positive
    write negative, neglen
    jmp end

end:
    mov rax, 60
    mov rdi, 0
    syscall

positive:
    write pos, poslen
    jmp end