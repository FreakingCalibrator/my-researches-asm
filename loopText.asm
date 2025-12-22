section .data
    ;msg db "A", 0x0
    ;imput db "HhhH", 0x0d, "5", 0x00
    emter db 0x0a
section .bss
    lenghtmsg resq 1
    msg resb 100
    count resb 100
    imput resb 200
section .text
global _start
_start:
    mov rsi, imput
    call read

    mov rcx, -1
    mov al, 10
    mov rdi, imput
    repne scasb

    mov rax, rdi
    mov rbx, rdi
    sub rax, imput
    sub rax, 1
    mov [lenghtmsg], rax

    mov rsi, imput
    mov rdi, msg
    mov rcx, rax
    rep movsb
    
    mov rcx, -1
    mov al, 0x00
    mov rsi, rbx
    mov rdi, rbx
    repne scasb

    mov rax, rdi
    sub rax, rsi
    sub rax, 1

    mov rdi, count
    mov rcx, rax
    rep movsb

    call parse

    mov rcx, rax
    mov rdx, [lenghtmsg]
    push rdx
    .looptext:
        mov rsi, msg
        pop rdx
        push rdx
        call write

        mov rsi, emter
        mov rdx, 1
        call write

        loop .looptext

    end:
        mov rax, 60
        mov rdi, 0
        syscall

read:
    mov rdi, 0
    mov rdx, 100
    mov rax, 0
    syscall
    ret

parse:
    mov rcx, rax
    xor rax, rax
    xor rbx, rbx
    .loopCtoI:
        imul rax, 10
        movzx rdx, byte [count+rbx]
        sub rdx, 48
        add rax, rdx
        inc rbx
        loop .loopCtoI
    ret

write:
    push rcx
    mov rdi, 1
    mov rax, 1
    syscall
    pop rcx
    ret
