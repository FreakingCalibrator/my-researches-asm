section .bss
    msg resb 100
section .data
    outOfRange db "Out of range", 0xa
    lenOut equ $-outOfRange
    inRange db "In range", 0xa
    inlen equ $-inRange
section .text
global _start
%macro read 0
    mov rax, 0
    mov rdi, 0
    mov rsi, msg
    mov rdx, 100
    syscall
%endmacro

%macro write 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

_start:
    read
    mov rcx, -1
    mov rdi, msg
    mov al, 0xa
    repne scasb

    mov rcx, rdi
    sub rcx, rsi
    dec rcx
    xor rax, rax
    xor rbx, rbx
    .loopRange:
        imul rax, 10
        movzx rdx, byte[rsi+rbx]
        cmp rdx, 0x2d
        je .cont
        add rax, rdx
        sub rax, 0x30
        .cont:
        inc rbx
        loop .loopRange

    movzx rdx, byte[rsi]
    cmp rdx, 0x2d
    jne cont2
    imul rax, -1
    cont2:
        cmp rax, 10
        jge write1
        write outOfRange, lenOut
        jmp end
    write1:
        cmp rax, 20
        jle write2
        write outOfRange, lenOut
        jmp end
    write2:
        write inRange, inlen
        jmp end
    end:
        mov rax, 60
        mov rdi, 0
        syscall