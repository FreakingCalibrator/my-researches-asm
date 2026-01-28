#include <stdio.h>
extern int count_of_Lit(char lit, char* word);
int main()
{
    char word[]="Hello, world!";
    int size=count_of_Lit('l', word);
    printf("count=%d", size);
}
