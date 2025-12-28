section .bss
    msg resb 100
section .data
    msg1 db "Even", 0xa
    msg1len equ $-msg1
    msg2 db "Odd", 0xa
    msg2len equ $-msg2
section .text
    global _start
%macro read 0
    mov rdi, 0
    mov rdx, 100
    mov rax, 0
    mov rsi, msg
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
        xor rdx, rdx
        mov rcx, 2
        div rcx
        cmp rdx, 0
        je eveness
        jne odd
    end:
        mov rax, 60
        mov rdi, 0
        syscall

eveness:
    write msg1, msg1len
    jmp end

odd:
    write msg2, msg2len
    jmp end