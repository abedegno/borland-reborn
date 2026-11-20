#define A 1
#define F(x,y) ((x)+(y)*A)
#if F(2,3) > 4 && defined(A)
int z = F(1,2);
#else
int z = 0;
#endif
#include "T2.H"
char *s = "str\n" "cat";
/* comment */ long q = 0x10L; // c++ comment?
