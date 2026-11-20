#ifndef SEGNAMES_H
#define SEGNAMES_H
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
/* The shared record definition matches accepted INITTYPE exactly. */
struct C9Token { char near *name; unsigned int flags; signed char type; unsigned char reserved[2]; };
struct C31Bank { unsigned int segment,capacity,used,extra; };
struct C52ModelInfo { char far *name; unsigned char far_data,far_code; };
extern struct C9Token near PSEUDO_REGISTER_TABLE[];
extern struct C31Bank STRING_POOL_SEG,EXPR_POOL_SEG;
extern struct C52ModelInfo near C52_MODEL_INFO[6];
extern unsigned char MODEL_FAR_CODE; extern unsigned char OPTION_OVERLAY_CODE; extern unsigned char OPTION_CALLING_CONVENTION; extern unsigned char OPTION_WINDOWS_MODE; extern unsigned char OPTION_FLAGS; extern unsigned char COMPILER_MODE; extern unsigned char OPTION_COMPILE_VIA_ASM;
extern signed char OPTION_MEMORY_MODEL;
extern char far *OPTION_OUTPUT_DIR;
extern char far *OPTION_OBJECT_NAME;
extern char far *C52_CODE_NAME_OPTION;
extern char far *C52_CODE_GROUP_OPTION;
extern char far *C52_CODE_CLASS_OPTION;
extern char far *C52_DATA_NAME_OPTION;
extern char far *C52_DATA_GROUP_OPTION;
extern char far *C52_DATA_CLASS_OPTION;
extern char far *C52_BSS_NAME_OPTION;
extern char far *C52_BSS_GROUP_OPTION;
extern char far *C52_BSS_CLASS_OPTION;
extern char far *C52_FAR_NAME_OPTION;
extern char far *C52_FAR_GROUP_OPTION;
extern char far *C52_FAR_CLASS_OPTION;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *STREAM_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_HOOK)(unsigned int);
extern int (far pascal *FLAG_HOOK)(unsigned int);
extern void (far pascal *BYTE_HOOK)(unsigned char);
extern void (far pascal *WORD_HOOK)(unsigned int,int);
extern void (far pascal *ALT_HOOK)(unsigned int,int);
extern unsigned int far pascal MACRO_DEFINE(char far *,char far *,signed char,unsigned int);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern void far pascal RTL_ITOA10(int,char far *);
extern unsigned int far pascal DEFINE_SEGMENT(unsigned char,unsigned int,unsigned int,unsigned int);
char far * far pascal REGISTER_NAME(char,char);
int far pascal BCC_TOKEN_FLAG(signed char);
void far pascal INIT_SEGMENT_NAMES(char far *);
unsigned int far pascal BCC_INTERN_STRING(char far *);
unsigned int far pascal DEFINE_FAR_SEGMENT(void);
unsigned int far pascal PTR_SCALE_TYPE(unsigned int);
void far pascal EMIT_STARTUP_EXIT_RECORD(unsigned int,unsigned char,unsigned int,unsigned int);
void far pascal ADD_STARTUP_ENTRY(unsigned int,unsigned int);
void far pascal ADD_EXIT_ENTRY(unsigned int,unsigned int);
#endif
