global _start
section .data
    msg db "CF flag", 0x0
    msg1 db "OF flag", 0x0
    msg2 db "%d", 0x0
section .text
_start:
    stc
    lahf
    jmp end
experiments3:
    stc
    clc 
    jc cffunc
    jmp end
experiments2:
    stc
    jc cffunc
    jmp end
experiments1:
    mov al, 0xff
    add al, 1
    jc cffunc

    ;xor rax, rax

    mov rax, 0xfffffffffffff
    xor rbx, rbx
    sub rbx, 0x3040425
    imul rax, rbx
    jo offunc

    jmp end

cffunc:
    mov rsi, msg
    jmp func

offunc:
    mov rsi, msg1
    jmp func

end:
    mov     rax, 60        ; exit
    xor     rdi, rdi       ; код возврата = 0
    syscall

func:
    mov rax, 1
    mov rdi, 1
    mov rdx, 7
    syscall
    jmp end