/* target: T_CHARCASE */
/* compiler: TC201 */
/* opts: -ml -p -O */
/* CHARCASE.C: TLINK's own letter-case helpers, far pascal functions on the run-time
   library's character table (_ctype; bit 4 = upper case, bit 8 = lower case). */
#include <ctype.h>

int far pascal LOWER_CASE(unsigned char c)
{
	return (_ctype[c + 1] & _IS_UPP) ? c + 0x20 : c;
}

int far pascal UPPER_CASE(unsigned char c)
{
	return (_ctype[c + 1] & _IS_LOW) ? c - 0x20 : c;
}
