section .bss
    msg resb 500
    res resb 100
section .text
global _start
%macro read 0
    mov rax, 0
    mov rdi, 0
    mov rsi, msg
    mov rdx, 500
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
    mov rdi, msg
    mov rcx, -1
    xor rax, rax
    xor rbx, rbx
    mov al, 0xa
    repne scasb
    mov rcx, rdi
    sub rcx, rsi
    dec rcx

    xor rbx, rbx
    xor rax, rax
    loonsym:
        movzx rdx, byte[msg+rbx]
        cmp rdx, 0x20
        je cont
        cont1:
            inc rbx
            loop loonsym

    cmp rdi, rsi
    jne cont2
    cont3:
    mov rbx, 10
    xor rdx, rdx
    xor rcx, rcx
    cont4:
        xor rdx, rdx
        div rbx
        add rdx, 0x30
        push rdx
        inc rcx
        cmp rax, 0
        jne cont4

    xor rbx, rbx
    loopnum4:
        pop rdx
        mov [res+rbx], rdx
        inc rbx
        loop loopnum4

    write rbx

    end:
        mov rax, 60
        mov rdi, 0
        syscall

    cont2:
        inc rax
        jmp cont3
    
    cont:
        inc rax
        jmp cont1