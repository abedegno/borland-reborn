/* target: RSCPY */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RSCPY (11E8:000A..0089): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RSCPY.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: STRING_COPY, RTL_STRNCPY. */
/* Overview: the C library's strcpy and strncpy on far strings, both
   built on RTL_MEMMOVE.  STRING_COPY copies source with its terminator.
   RTL_STRNCPY copies at most n characters and fills the rest of n with
   zeros; as in standard strncpy, the result has no terminator when source
   is n characters or longer.  STRING_COPY is used throughout the program;
   in CPP.EXE RTL_STRNCPY is called only by FNSPLIT (RFNSPLIT.C). */
/* Borland run-time library strcpy and strncpy with
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
