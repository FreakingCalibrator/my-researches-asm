section .bss
    din_arr resq 1
section .text
    global _start
    _start:
        ;len=1024
        ;     addr    len   prot                  flags                      fd,    offset
        ;mmap(0     , 1024, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0,     0)
        mov rax, 9
        xor rdi, rdi
        mov rsi, 8192
        mov rdx, 3
        mov r10, 34
        xor r8, r8
        xor r9, r9
        syscall
        mov [din_arr], rax
        mov rcx, 1023
        xor rbx, rbx
        mov rsi, rax
        .arrLoop:
            mov [rsi], rcx
            add rsi, 8
            loop .arrLoop
        .clean:
        mov rdi, [din_arr]
        mov rsi, 8192
        mov rax, 11              ; munmap
        syscall
        .end:
        mov rax, 60
        mov rdi, 0
        syscall
