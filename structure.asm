section .data
structure1:
    db "Philosopher stone", 10
    db 1
    db "Secret chamber", 10
    db 2
    db "Prisoner of azcaban", 10
    db 3
    db "Goblet of fire", 10
    db 4
    db "Order of the phoenix", 10
    db 5
    db "Prince half-blood", 10
    db 6
    db "Deathly hallows", 10
    db 7

structure2:
    dq book1
    dq book2
    dq book3

book1 db "The Fellowship of the Ring", 10
book2 db "Two towers", 10
book3 db "Return of the king",10

section .text
global _start
_start:
jmp exp3
exp1:
    mov rbx, structure1
    add rbx, 34
    mov rsi, rbx
    jmp end
exp2:
    mov rbx, [structure2+8]
    mov rsi, rbx
    jmp end
exp3:
    lea rsi, [structure1+34]
    jmp end
end:
    mov rax, 1
    mov rdi, 1
    
    mov rdx, 21
    syscall

    mov rax, 60        ; exit
    xor rdi, rdi       ; код возврата = 0
    syscall