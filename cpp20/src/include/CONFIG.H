#ifndef CONFIG_H
#define CONFIG_H
#include <dos.h>
#include <dir.h>
#include "DATA.H"
#include "OVL.H"
extern int ENVIRONMENT_SEG;
extern char far *PCH_FILE_NAME;
extern char far *C53_OPTION_PATH;
extern unsigned char OPTION_OVERLAY_CODE; extern unsigned char COMPILER_MODE; extern unsigned char OPTION_COMPILE_VIA_ASM;
extern char near _CTYPE[];
extern int far pascal DOS_CALL_AH(int,int,int);
extern int far pascal FNSPLIT(char far *,char far *,char far *,char far *,char far *);
extern void far pascal FNMERGE(char far *,char far *,char far *,char far *,char far *);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern char far * far pascal MALLOC(unsigned int);
extern char far * far pascal STRING_COPY(char far *,char far *);
extern int far pascal RTL_OPEN(char far *,unsigned int);
extern long far pascal RTL_LSEEK(unsigned int,long,unsigned int);
extern unsigned int far pascal RTL_READ(unsigned int,char far *,unsigned int);
extern int far pascal RTL_CLOSE(unsigned int);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern unsigned int far pascal FREE_HANDLE_BLOCK(unsigned int far *);
extern int far pascal COMPARE_NAME(char far *,char far *);
extern int far pascal FINDFIRST(char far *,struct ffblk far *,int);
extern void far cdecl REPORT_ERROR(unsigned int,...);
extern void far pascal SHUTDOWN_HEAP_BANKS(void);
extern void far pascal EXIT(int);
static int near pascal BCC_LINE_READ(char far *);
static int near pascal FILE_TEST(char far *);
static void near pascal FILE_FATAL(char far *,char far *);
#endif
