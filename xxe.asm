section .data
    nums dd 1.09, 40.56, 3.14, 2.72

section .text
    global _start

_start:
.sqrt:
    movaps xmm0, [nums]
    sqrtps xmm0, xmm0
    movaps [nums], xmm0
.mul:
    movaps xmm1, [nums]
    mulps xmm1, xmm1
    movaps [nums], xmm1
.add:
    movaps xmm2, [nums]
    addps xmm2, xmm1
    movaps [nums], xmm2
.sub:
    subps xmm1, xmm0
    movaps [nums], xmm1
.div:
    movaps xmm4, [nums]
    divps xmm4, xmm2
    movaps [nums], xmm4
.exit:
    mov rax, 60
    xor rdi, rdi

    syscall
