#include <stdio.h>
extern int SumArr(int*arr);
int main()
{
    int array[1024];
    int res;
    for (int i=0;i<1024;++i)
        array[i]=(1024-i);
    res=SumArr(array);
    printf("Summ of array=%d", res);
}