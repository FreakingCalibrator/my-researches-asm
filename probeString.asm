section .data
    probel db 32
    ;msg db "1914 1918",0x0d
section .bss
    msg resb 100
    num1 resb 100
    num2 resb 100
    num1i resq 1
    num2i resq 1
    numRes resb 100
section .text
global _start
_start:
    call read

    mov al, 32
    mov rdx, num1
    mov rdi, msg
    call parse
    mov rdx, num2
    mov al, 0x0a
    call parse

    mov rdi, num1
    mov rsi, num1i
    call ctoi

    mov rdi, num2
    mov rsi, num2i
    call ctoi
    call itoc

    ;write
    mov rsi, numRes
    mov rdx, 100
    call write

    ;end
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
    mov rbx, rdi
    mov rcx, -1
    repne scasb
    push rdi
    sub rdi, rbx
    sub rdi, 1
    mov rcx, rdi
    mov rsi, rbx
    mov rdi, rdx
    rep movsb
    pop rdi
    ret

write:
    mov rdi, 1
    mov rax, 1
    syscall
    ret

ctoi:
    xor rbx, rbx
    xor rax, rax
    .loopctoi:
        imul rax, 10
        movzx rdx, byte [rdi+rbx]
        sub rdx, 48
        add rax, rdx
        inc rbx
        movzx rcx, byte [rdi+rbx]
        cmp rcx, 0
        jne .loopctoi
    mov [rsi], rax
    ret

sum:
    pop rax
    pop rbx
    add rax, rbx

itoc:
    mov rax, [num1i]
    add rax, [num2i]
    xor rbx, rbx
    mov rbx, 10
    mov rcx, 10
    xor rcx, rcx
    mov rdi, rax
    .loopdiv:
        xor rdx, rdx
        div rbx
        inc rcx
        add rdx, 48
        push rdx
        cmp rax, 0
        jne .loopdiv

    xor rbx, rbx
    .itoc:
        pop rax
        mov [numRes+rbx], rax
        inc rbx
        loop .itoc
        mov byte[numRes+rbx], 0x0
    ret