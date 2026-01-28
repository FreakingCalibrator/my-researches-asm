section .text
global is_that_vowel_letter
is_that_vowel_letter:
    mov r9, rsi      ;адрес массива
    mov rsi, rdi
    mov al, 0 
    mov rcx, -1
    repne scasb
    sub rdi, rsi
    mov rcx, rdi
    mov r8, 1
    .loop
        movzx rdx, byte[rsi]
        cmp rdx, 'a';"aeiou
        jz .cont
        cmp rdx, 'e';"aeiou
        jz .cont
        cmp rdx, 'i';"aeiou
        jz .cont
        cmp rdx, 'o';"aeiou
        jz .cont
        cmp rdx, 'u';"aeiou
        jz .cont
        mov [r9], rdx
        inc r9
        .cont:
        inc rsi
        loop .loop
    ret