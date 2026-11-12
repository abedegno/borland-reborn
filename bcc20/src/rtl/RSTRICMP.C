/* target: CODE_34_RSTRICMP */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: STRING_COMPARE. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: STRING_COMPARE is the C library's stricmp: compares two far
   strings ignoring case and returns -1, 0 or 1.  The characters are
   compared after TOLOWER, as signed chars.  When a ends, the sign of the
   character in b decides: a following character (positive char) means a
   is shorter (-1); a character of 80h or above, negative as a char, gives
   1.  Used by the driver and option code (file extensions, segment names)
   and by the preprocessor and the inline assembler statement parser. */
/* Segment 0AAA:0008..0071, Borland run-time library stricmp with pascal
   calling (STRING_COMPARE = stricmp), comparing through TOLOWER (module
   TOLOWER).  Returns -1, 0 or 1.
   Built with BC 2.0, not Turbo C 2.01: its two `dec sp` are BC's 2-byte
   frame.  The gotos jump into the if blocks so that both comparisons share
   the original's return blocks. */
extern unsigned int far pascal TOLOWER(int);

int far pascal STRING_COMPARE(char far *a,char far *b)
{
    char lower_b;
    char lower_a;
    while(*a) {
        lower_a=TOLOWER(*a);
        lower_b=TOLOWER(*b);
        if(lower_a<lower_b) goto less;
        if(lower_a>lower_b) goto greater;
        a++;
        b++;
    }
    if(*b>0) {
less:
        return -1;
    }
    if(*b<0) {
greater:
        return 1;
    }
    return 0;
}
