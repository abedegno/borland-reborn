/* target: CODE_36_RTOUPPER */
/* opts: -mm -G -O -Z -r- -p */
/* Role: run-time library. Entry points: RTL_TOUPPER. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: RTL_TOUPPER is the C library's toupper.  _CTYPE is the
   library's character class table, indexed by the character plus 1 (entry
   0 is for EOF); the bit with value 8 (_IS_LOW) marks a lower-case letter, which is changed by
   subtracting 32.  Only the low byte of value is used, so EOF (-1) comes
   back as 255.  The caller is RTL_STRUPR (RSTRLOW.C). */
extern unsigned char _CTYPE[];
unsigned int far pascal RTL_TOUPPER(int value)
{
    if(_CTYPE[(unsigned char)value+1]&8) return (unsigned char)value-32;
    return (unsigned char)value;
}
