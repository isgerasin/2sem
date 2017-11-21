#include <stdlib.h>

typedef double TypeStk;

class Stack
{
	public:
	Stack();
	~Stack();
	bool ok() const;
	bool dump() const;
	bool push( TypeStk data );
	TypeStk pop();
	
	private:
	bool realoc( double x );

    int canaryA;
    TypeStk* data;
    size_t counter;
    size_t lenght;
    int canaryB;
};



