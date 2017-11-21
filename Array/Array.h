#include <string.h>


class my_vector
{
    public:

typedef double vctr_type;
    my_vector();
    my_vector( const my_vector& that);
    explicit  my_vector( size_t length );
    ~my_vector();
    bool ok() const;
    bool dump( const char* msg ) const;

    const vctr_type& operator[]( size_t num ) const ;
    vctr_type& operator[]( size_t num );
    
    const my_vector& operator=( const my_vector& that );
    my_vector& operator=( my_vector& that );

    private:

    size_t checkcalc() const;

    unsigned int canaryA_;
    size_t length_;
    vctr_type* data_;
    size_t checksum_;
    unsigned int canaryB_;

    friend my_vector operator+( const my_vector& va, const my_vector& vb );
    friend my_vector operator-( const my_vector& va, const my_vector& vb );

};

my_vector operator+( const my_vector& va, const my_vector& vb );

my_vector operator-( const my_vector& va, const my_vector& vb );

