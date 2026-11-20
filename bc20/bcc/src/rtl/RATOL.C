/* target: CODE_15_RATOL */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_ATOL, RTL_ATOI. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's atol and atoi.  RTL_ATOL accepts leading
   blanks and tabs, one optional '-', and decimal digits, and stops at the
   first other character.  It does no overflow check and, unlike ANSI atol,
   does not accept '+'.  RTL_ATOI just truncates the long.  RTL_ATOL reads
   the -# heap size (RARGV0F0.C) and numeric options (OPTIONS.C); RTL_ATOI
   has no caller in the sources. */
/* Segment 0A34:0009..00B2, Borland run-time library atol and atoi with
   pascal calling (Turbo C 2.01).  atol skips blanks and tabs, takes one
   optional '-' (no '+'), then decimal digits.
   RTL_ATOL = atol, RTL_ATOI = atoi. */
long far pascal RTL_ATOL(char far *string)
{
    long value;
    register int negative;
    while(*string==' ' || *string=='\t') string++;
    if(*string=='-') {
        negative=1;
        string++;
    } else negative=0;
    value=0;
    while(*string>='0' && *string<='9') {
        value=value*10+*string-'0';
        string++;
    }
    if(negative) value=-value;
    return value;
}

int far pascal RTL_ATOI(char far *string)
{
    return RTL_ATOL(string);
}
