/* target: CODE_43_RSCPY */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: STRING_COPY, RTL_STRNCPY. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's strcpy and strncpy on far strings, both
   built on RTL_MEMMOVE.  STRING_COPY copies source with its terminator.
   RTL_STRNCPY copies at most n characters and fills the rest of n with
   zeros; as in standard strncpy, the result has no terminator when source
   is n characters or longer.  STRING_COPY is used throughout the compiler;
   RTL_STRNCPY by FNSPLIT and DRVLINK. */
/* Segment 0B07:0002..0080, Borland run-time library strcpy and strncpy with
   pascal calling and far pointers (Turbo C 2.01).  strncpy pads the rest of
   the count with zeros (RTL_MEMSET, RMSET).
   STRING_COPY = strcpy, RTL_STRNCPY = strncpy. */
extern unsigned int far pascal STRING_LENGTH(char far *);
extern void far pascal RTL_MEMMOVE(void far *,void far *,unsigned int);
extern void far pascal RTL_MEMSET(void far *,int,unsigned int);

char far * far pascal STRING_COPY(char far *destination,char far *source)
{
    RTL_MEMMOVE(destination,source,STRING_LENGTH(source)+1);
    return destination;
}

char far * far pascal RTL_STRNCPY(char far *destination,char far *source,register unsigned int n)
{
    register unsigned int length=STRING_LENGTH(source);
    if(length>n) length=n;
    RTL_MEMMOVE(destination,source,length);
    if(length<n) RTL_MEMSET(destination+length,0,n-length);
    return destination;
}
