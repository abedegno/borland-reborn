#ifndef DRVLINK_H
#define DRVLINK_H
#include <dos.h>
#include <dir.h>
#include "DATA.H"
#include "OVL.H"
struct Argument { struct Argument far *next; char text[1]; };
struct search_entry { unsigned char reserved[2]; struct search_entry far *next; char far *directory; };
struct LineBuffer { struct LineBuffer far *next; char far *text; };
struct C51Libraries { char near *startup; char near *runtime; char near *math; };
typedef int (near pascal *PathCallback)(char far *);
extern struct C51Libraries near C51_DOS_LIBRARIES[6],C51_WINDOWS_LIBRARIES[6];
extern unsigned char LINKER_SWITCH_FLAGS[26];
extern unsigned char OPTION_OVERLAY_CODE; extern unsigned char OPTION_WINDOWS_MODE; extern unsigned char OPTION_CALLING_CONVENTION; extern unsigned char OPTION_SOURCE_DEBUG;
extern unsigned char OPTION_FLAGS;
extern signed char OPTION_MEMORY_MODEL;
extern unsigned int ERROR_COUNT;
extern unsigned int near ERROR_JUMP_BUFFER[];
extern struct Argument far *ARGUMENT_LIST;
extern struct search_entry far *SEARCH_LIST;
extern char far *OPTION_OUTPUT_DIR;
extern char far *OPTION_OBJECT_NAME;
extern char far *LINK_OUTPUT_NAME;
extern char far *TASM_PROGRAM_NAME;
extern char near _CTYPE[];
extern int far pascal FNSPLIT(char far *,char far *,char far *,char far *,char far *);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern char far * far pascal MALLOC(unsigned int);
extern char far * far pascal STRING_COPY(char far *,char far *);
extern char far * far pascal STRING_APPEND(char far *,char far *);
extern char far * far pascal RTL_STRNCPY(char far *,char far *,unsigned int);
extern int far pascal RUN_PROGRAM(char far *,char far *);
extern int far pascal C45_SETJUMP(void far *);
extern void far pascal SHUTDOWN_HEAP_BANKS(void);
extern void far pascal EXIT(int);
extern int far pascal DELETE_FILE(char far *);
extern void far pascal ADD_TRAILING_BACKSLASH(char far *);
extern int far pascal CREATE_OUTPUT_FILE(char far *);
extern void far pascal CLOSE_OUTPUT_FILE(void);
extern void far pascal OUTPUT_CHAR(char);
extern int far pascal STRING_COMPARE(char far *,char far *);
extern int far pascal FINDFIRST(char far *,struct ffblk far *,int);
extern void far pascal FNMERGE(char far *,char far *,char far *,char far *,char far *);
extern int far pascal FINDNEXT(struct ffblk far *);
extern int far pascal TOLOWER(int);
extern char far * far pascal STRING_FIND_CHAR(char far *,int);
extern int far pascal DOS_CALL_AH(int,int,int);
extern int far pascal RTL_OPEN(char far *,unsigned int);
extern int far pascal RTL_CLOSE(unsigned int);
extern long far pascal RTL_LSEEK(unsigned int,long,unsigned int);
extern unsigned int far pascal RTL_READ(unsigned int,char far *,unsigned int);
extern void far pascal WRITE_STDOUT_STRING(char far *);
extern void far cdecl REPORT_ERROR(unsigned int,...);
extern void far cdecl RTL_DPRINTF(char far *,...);
static int near pascal PREPROCESS_ONE_FILE(char far *);
static char far * near pascal BCC_STRING_CONCAT_NEAR(char far *,char far *);
static void near pascal COMPILE_FILE_REPORT_ERRORS(char far *);
static void near pascal PUT_STRING(char far *);
static void near pascal SLASH_FIX(char far *);
static void near pascal PUT_PATH(char far *);
static int near pascal FILE_APPEND_CALLBACK(char far *);
static int near pascal C51_EMIT_PATH_CALLBACK(char far *);
static int near pascal HAS_LIB_EXTENSION(char far *);
static int near pascal EXPAND_WILDCARDS(char far *,PathCallback);
static void near pascal STRIP_EXTENSION(char far *);
static void near pascal FIND_FILE(char far *,int);
static unsigned int near pascal BCC_READ_FILE(unsigned int,struct LineBuffer far * far *);
#endif
