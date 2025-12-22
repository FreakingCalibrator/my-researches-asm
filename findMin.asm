section .data
    arr dq  5, 7, 3, 1, 2
    emter db 0x0a
section .bss
    min resq 1
    minstr resb 100
section .text
global _start
_start:
    mov rcx, 5
    mov rax, 32000
    mov qword [min], rax
    find:
        mov rax, [min]
        mov rbx, [arr+rcx*8-8]
        cmp rax, rbx
        jl cont
        mov rax, [arr+rcx*8-8]
        mov qword [min], rax
        cont:
            loop find
    
    mov rax, [min]
    call itoc
    
    mov rsi, minstr
    call write
           
    
    end:
        mov rax, 60
        mov rdi, 0
        syscall

    write:
    mov rdx, 1
    mov rdi, 1
    mov rax, 1
    syscall
    ret

    itoc:
    xor rbx, rbx
    mov rbx, 10
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
        mov [minstr+rbx], rax
        inc rbx
        loop .itoc
     mov byte[minstr+rbx], 0x0
    ret
