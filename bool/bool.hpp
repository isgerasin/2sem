#include <stdio.h>
#include <assert.h>

#define CANARY 0xBABACEEF
#define BADCANARY 0xBADBEEF

#define ASSERT_OK( smth ) \
            if ( !((smth)->ok()) ) \
                (smth)->dump("ERROR");

typedef char data_type;

class booladdress
{
    public:
    booladdress();
    ~booladdress();
    bool ok() const;
    bool dump( const char* msg ) const;
    
    operator data_type();
    data_type operator = ( data_type data );
    size_t byte_;
    size_t bit_;
    data_type* ptr_;
};

//template<>
//my_Array<bool>
template<size_t len>
class my_Arraybool
{
    public:

    my_Arraybool();
    ~my_Arraybool();
    bool ok();
    bool dump( const char* msg );
    size_t getlen();
    //const booladdress  operator[]( size_t pos) const;
    booladdress operator[]( size_t pos );

    
    //bool Eratosthenes();
    data_type operator=( data_type );

    private:

    unsigned int canaryA_;
    size_t length_;
    size_t reallength_;
    data_type data_[len/sizeof( data_type )/8+1];
    unsigned int canaryB_;

};

template<size_t len>
size_t my_Arraybool<len>::getlen()
{
    ASSERT_OK( this )
    return reallength_;
}

template< size_t len>
bool my_Arraybool<len>::ok()
{
    return  canaryA_ == CANARY &&
            canaryB_ == CANARY;
}

template<size_t len>
bool my_Arraybool<len>::dump( const char* msg )
{
    fprintf( stderr, "=================================\n" );
    fprintf( stderr, "Array<bool> %s [%p] %s\n"
                     "canaryA = %u\n"
                     "length = %lu byte\n"//%z
                     "canaryB = %u\n",
            msg, this, this->ok() ? "OK": "ERROR", canaryA_, length_, canaryB_ );
    for ( size_t i = 0; i < length_; i++ )
    {
        fprintf( stderr, "\t--%lu--[%p]--\n", i, this->data_ + i );
        for ( int j = 0; j < sizeof( data_type )*8; j++ )
            fprintf( stderr, "\t%4lu byte[%lu][%d] = %d\n", i * 8 * sizeof( *data_ ) +  j,  i, j, (data_[i] >> j) & 1 );
    }
    fprintf( stderr, "=================================\n" );
    return true;
}

template< size_t len>
my_Arraybool<len>::my_Arraybool():
    canaryA_ ( CANARY ),
    length_ ( len / sizeof( data_type ) /8 + 1 ),
    reallength_ ( len ),
    canaryB_ ( CANARY )
{
    for ( size_t i = 0; i < length_; i++ )
        data_[i] = 0;
    ASSERT_OK( this )
}

template< size_t len>
my_Arraybool< len>::~my_Arraybool()
{
    ASSERT_OK( this )
    length_ = 0;
    canaryA_ = BADCANARY;
    canaryB_ = BADCANARY;
}

template< size_t len >
booladdress my_Arraybool<len>::operator[]( size_t pos )
{
    ASSERT_OK( this )

    booladdress ba; 
    ba.byte_ = pos / 8;
    ba.bit_ = pos % 8;
    ba.ptr_ = this->data_;

    ASSERT_OK( this )
    return ba;
}

/*data_type operator=( const booladdress& ba )
{
    this->data_[ba.byte_] |= <<
}
*/

booladdress::booladdress():
    byte_ ( 0 ),
    bit_ ( 0 ),
    ptr_ ( NULL )
    {}

booladdress::~booladdress()
{
    byte_ = 0;
    bit_ = 0;
    ptr_ = NULL;
}

bool booladdress::ok() const
{
    return ptr_ != NULL;
}
bool booladdress::dump( const char* msg ) const
{
    fprintf( stderr, "================================\n"
                     "booladdress [%p] %s %s\n"
                     "byte = %lu\n"
                     "bit = %lu\n"
                     "ptr = %p\n"
                     "================================\n",
                     this, this->ok() ? "ok": "ERROR", msg,  byte_, bit_, ptr_ );
    return true;

}

booladdress::operator data_type()
{
    ASSERT_OK( this )
    return (int) (ptr_[byte_] >> bit_ ) & 1 ;
}


data_type booladdress::operator = ( data_type data )
{
    ASSERT_OK( this )
    if ( data != 0 )
        ptr_[byte_] |= 1 << bit_;
    else 
        ptr_[byte_] &= ~(1 << bit_);

    ASSERT_OK( this )
    return data;

}

