section .bss
    msg resb 100
section .data
    nonADigit db "Not a digit", 0x00
    ADigit db "Digit", 0x00
section .text
global _start
_start:
    mov rsi, msg
    call read
    xor rax, rax
    mov rdi, msg
    mov al, 0x00
    mov rcx, -1
    repne scasb
    Hello:
    sub rdi, msg
    sub rdi, 1
    mov rcx, rdi
    xor rbx, rbx
    .loopNum:
        movzx rax, byte[msg+rbx]
        inc rbx
        cmp rax, 0x30
        jl cont
        cmp rax, 0x39
        jg cont
        loop .loopNum

        mov rsi, ADigit
        mov rdx, 5
        call write
        jmp end

    
end:
    mov rax, 60
    mov rdi, 0
    syscall

cont:
    mov rsi, nonADigit
    mov rdx, 11
    call write
    jmp end

read:
    mov rdi, 0
    mov rdx, 100
    mov rax, 0
    syscall
    ret

write:
    mov rcx, rbx
    mov rdi, 1
    mov rax, 1
    syscall
    ret
