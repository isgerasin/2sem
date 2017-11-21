#include <stdio.h>

int hash(int i)
{
	
}

int main()
{
	FILE* fl = fopen( "MAXpass.txt", "w" );
	unsigned long long count = 0;
	for ( int i1 = '0'; i1 <= 'z'; i1++ )
	{
		for ( int i2 = '0'; i2 <= 'z'; i2++ )
	{
		for ( int i3 = '0'; i3 <= 'z'; i3++ )
	{
		for ( int i4 = '0'; i4 <= 'z'; i4++ )
	{
		for ( int i5 = '0'; i5 <= 'z'; i5++ )
	{
		for ( int i6 = '0'; i6 <= 'z'; i6++ )
	{
		for ( int i7 = '0'; i7 <= 'z'; i7++ )
	{
		for ( int i8 = '0'; i8 <= 'z'; i8++ )
	{
		for ( int i9 = '0'; i9 <= 'z'; i9++ )
	{
		if ( i1*1+i2*2+i3*3+i4*4+i5*5+i6*6+i7*7+i8*8+i9*9 == 4255 )
		{
			count++;
			fprintf( fl, "%llu %c%c%c%c%c%c%c%c%c\n", count, i9, i8, i7, i6, i5, i4, i3, i2, i1 );
		}
	}
	}
	}
	}
	}
	}
	}
	}
	}
}
