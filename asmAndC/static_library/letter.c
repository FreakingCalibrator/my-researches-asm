#include <stdio.h>               
extern void is_that_vowel_letter(char* letter, char* answer);
int main()
{
    char let[100];                //rsi
    char letter[]="Hello, world";//rdi
    is_that_vowel_letter(letter, let);
    printf("Message=%s",let);
}