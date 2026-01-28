#include <stdio.h>
int main()
{
    int val1, val2, res;
    val1=5, val2=9;
    __asm__("imull %%eax, %%ebx":"=a"(res):"a"(val1), "b"(val2):);
    printf("res=%d", res);
}