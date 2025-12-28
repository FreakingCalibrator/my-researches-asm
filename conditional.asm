section .bss
    msg resb 100
    num resq 1
section .data
    res1 db "Greater than 10", 0xa
    res1len equ $-res1
    res2 db "Less than or equal to 10", 0xa
    res2len equ $-res2
section .text
global _start
%macro read 0
    mov rdi, 0
    mov rdx, 100
    mov rax, 0
    mov rsi, msg
    syscall
%endmacro 

%macro write 1
    mov rax, 1
    mov rdi, 1
    %assign i %1
    %if i==1
        mov rsi, res1
        mov rdx, res1len
    %else
        mov rsi, res2
        mov rdx, res2len
    %endif
    syscall
%endmacro

one:
    write 1
    jmp end
two:
    write 0
    jmp end
end:
    mov rax, 60
    mov rdi, 0
    syscall

_start:
    read
    xor rax, rax
    mov al, 0xa
    mov rdi, msg
    mov rcx, -1
    repne scasb
    sca:
        mov rcx, rdi
        sub rcx, rsi
        dec rcx
        xor rax, rax
        xor rbx, rbx
        .loopnum:
            imul rax, 10
            movzx rdx, byte [msg+rbx]
            add rax, rdx
            sub rax, 48
            inc rbx
            loop .loopnum
    sca2:
        cmp rax, 10
        jg one
        jle two
        jmp end