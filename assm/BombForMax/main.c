#include <stdio.h>

int main()
{
	FILE* fl = fopen( "input", "w" );
	fprintf( fl, "123456789012345678%c%c%c%c%c%c%c%c12345678%c%c%c%c%c%c%c%c", 0x23, 0x02, 0x60, 0, 0, 0, 0 ,0 ,0x18, 0x01, 0x40,  0, 0, 0, 0, 0 );
	fclose( fl);
}
