section .text
global SumArr
SumArr:
    push rbx
    xor rax, rax
    mov rcx, 1024
    .cicrle:
        mov dword rbx, [rdi]
        add rax, rbx
        add rdi, 4
        loop .cicrle
    pop rbx
    ret