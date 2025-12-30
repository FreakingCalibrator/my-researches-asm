section .bss
    msg resb 100
    res resb 100
section .text
global _start
%macro read 0
    mov rax, 0
    mov rdi, 0
    mov rsi, msg
    mov rdx, 100
    syscall
%endmacro

%macro write 1
    mov rax, 1
    mov rdi, 1
    mov rsi, res
    mov rdx, %1
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

    xor rbx, rbx
    xor rax, rax
    .loopnum:
        movzx rdx, byte[msg+rbx]
        sub rdx, 0x30
        add rax, rdx
        inc rbx
        loop .loopnum

    mov rbx, 10
    xor rcx, rcx
    .loopsym:
        xor rdx, rdx
        div rbx
        add rdx, 0x30
        push rdx
        inc rcx
        cmp rax, 0
        jne .loopsym
    
    xor rbx, rbx
    .loopsym2:
        pop rdx
        mov [res+rbx], dl
        inc rbx
        loop .loopsym2
    ll:
    write rbx

    end:
    mov rax, 60
    mov rdi, 0
    syscall