#include <stdio.h>

int printf_my_wrapper(char* fmt, ...);

int main()
{
	printf("HI%d!\n", 7);
	printf_my_wrapper("Hello Ilya! %d %b %s %h\n %d %d %d %d %d \n", 7, 9, "it is working!", 0xAB, 1, 2, 3, 4, 5);
}
