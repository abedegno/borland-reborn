/* RTL.H: the run-time library functions shared across the compiler: one
   prototype each, written as its definition is (src/<file> named on each line).
   Generated during the readability pass. */
#ifndef RTL_H
#define RTL_H
void far * far pascal MALLOC(unsigned int size);                       /* R5ALLOC.C */
void far cdecl REPORT_FATAL(int error,...);                          /* FATAL.C */
void far cdecl REPORT_ERROR(int error,...);                            /* ERRREPT.C */
void far cdecl REPORT_WARNING(unsigned int error,...);                    /* WARNREPT.C */
void far pascal ADD_TRAILING_BACKSLASH(char far *path);                          /* RADDSL.C */
long far pascal RTL_ATOL(char far *string);                    /* RATOL.C */
int far pascal RTL_CLOSE(int handle);                               /* RCLOSE.C */
int far pascal FINDFIRST(char far *path,struct ffblk far *ffblk,int attrib); /* RFFIND.C */
void far pascal CLOSE_OUTPUT_FILE(void);                                    /* RFILEIO.C */
void far pascal DISCARD_OUTPUT_FILE(void);                                    /* RFILEIO.C */
void far pascal BCC_OUTPUT_STRING(char far *text);                     /* RFILEIO.C */
void far pascal OUTPUT_CHAR(char value);                               /* RFILEIO.C */
int far pascal FNSPLIT(char far *path,char far *drive,char far *dir,char far *name,char far *ext); /* RFNSPLIT.C */
void far pascal LINE_HOOK(void);                                       /* RINIT.C */
long far pascal RTL_LSEEK(int handle,long position,int whence);     /* RLSEEK.C */
void far pascal RTL_MEMMOVE(void far *destination,void far *source,unsigned count); /* RMMOVE.C */
void far * far pascal RTL_MEMSET(void far *destination,int c,unsigned count); /* RMSET.C */
int far pascal RTL_OPEN(char far *path,int mode);                  /* ROPEN.C */
int far pascal RTL_READ(int handle,void far *buffer,unsigned count); /* RREAD.C */
char far * far pascal STRING_APPEND(char far *destination,char far *source); /* RSCAT.C */
int far pascal COMPARE_NAME(char far *a,char far *b);                  /* RSCMP.C */
char far * far pascal STRING_COPY(char far *destination,char far *source); /* RSCPY.C */
unsigned far pascal STRING_LENGTH(char far *string);                   /* RSLEN.C */
int far pascal STRING_COMPARE(char far *a,char far *b);                /* RSTRICMP.C */
void far pascal RTL_STRUPR(char far *text);                      /* RSTRLOW.C */
unsigned int far pascal RTL_TOUPPER(int value);                       /* RTOUPPER.C */
unsigned int far pascal TOLOWER(int value);                            /* TOLOWER.C */
#endif
