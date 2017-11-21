#include <stdio.h>

int main()
{
	#define define "12345678901\xEE\x00\x40\0\0\0\0"
	fwrite (define, 1, sizeof (define), fopen( "input", "wb" ));
}
