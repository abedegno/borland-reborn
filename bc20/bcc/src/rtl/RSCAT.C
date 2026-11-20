/* target: CODE_45_RSCAT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: STRING_APPEND, STRING_APPEND_N. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's strcat and strncat on far strings.
   STRING_APPEND copies source with its terminator to the end of
   destination.  STRING_APPEND_N appends at most count characters and
   always adds a terminator.  STRING_APPEND is used to build file names,
   paths and assembler text; STRING_APPEND_N has no caller in the
   sources. */
/* Segment 0B14:0006..0095, Borland run-time library strcat and strncat with
   pascal calling and far pointers (Turbo C 2.01).  Both copy through
   RTL_MEMMOVE (RMMOVE) and return the destination. */
extern unsigned int far pascal STRING_LENGTH(char far *);
extern void far pascal RTL_MEMMOVE(void far *,void far *,unsigned int);

char far * far pascal STRING_APPEND(char far *destination,char far *source)
{
    RTL_MEMMOVE(destination+STRING_LENGTH(destination),source,STRING_LENGTH(source)+1);
    return destination;
}

char far * far pascal STRING_APPEND_N(char far *destination,char far *source,
    unsigned int count)
{
    register unsigned int length;
    register unsigned int added;
    length=STRING_LENGTH(destination);
    added=STRING_LENGTH(source);
    if(added>count) added=count;
    RTL_MEMMOVE(&destination[length],source,added);
    destination[length+added]=0;
    return destination;
}
