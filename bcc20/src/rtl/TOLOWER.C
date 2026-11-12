/* target: CODE_36_TOLOWER */
/* opts: -mm -G -O -Z -r- -p */
/* Role: run-time library: tolower() using the _ctype table. Entry points: TOLOWER. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: TOLOWER is the C library's tolower, the twin of RTL_TOUPPER
   (RTOUPPER.C): the bit with value 4 (_IS_UPP) of the _CTYPE entry
   (indexed by the character plus 1) marks an upper-case letter, which is changed by adding 32.  Only the
   low byte of value is used.  The caller is STRING_COMPARE (RSTRICMP.C). */
extern unsigned char _CTYPE[];
unsigned int far pascal TOLOWER(int value)
{
    if(_CTYPE[(unsigned char)value+1]&4) return (unsigned char)value+32;
    return (unsigned char)value;
}
