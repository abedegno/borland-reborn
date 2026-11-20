/* target: CODE_1_RDRV388 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* context: RVECSET.C */
/* context: REXIT09F.C */
/* context-helper-entry: RVECSET.C RVECSET */
/* context-call: 0x76 EXIT EXIT_BODY */
/* context-call: 0x116 EXIT EXIT_BODY */
/* context-call: 0x141 EXIT EXIT_BODY */
/* context-call: 0x8B RVECSET RVECSET_BODY */
/* context-call: 0x9B RVECSET RVECSET_BODY */
/* context-call: 0xAB RVECSET RVECSET_BODY */
/* context-call: 0xD0 RVECSET RVECSET_BODY */
/* context-call: 0xE0 RVECSET RVECSET_BODY */
/* context-call: 0xF0 RVECSET RVECSET_BODY */
#include "DATA.H"
#include "MSG.H"
/* Overview: RUN_PROGRAM runs an external program, TASM for -B and .ASM files
   (PATH_PROCESS in DRVLINK.C) or TLINK for the link step (RUN_LINKER), and waits for it.
   Because BCC holds almost all of conventional memory as its far heap, it first shrinks
   that memory (SHRINK_MEMORY_FOR_EXEC) and puts back the original DOS vectors for
   interrupts 1Bh (Ctrl-Break), 23h (Ctrl-C) and 18h that RMAIN13C replaced at start-up,
   so the child sees a normal machine. Afterwards it installs BCC's own handlers again
   and regrows the heap. A program that cannot be found or started is a fatal error:
   the message is printed even if -g/-j limits are reached (the limits are set to 0 first),
   the heap banks (EMS, extended memory, swap file) are released, and BCC exits with 1. */
#pragma option -G

typedef void far *VectorAddress;
struct ExecutionBlock {
    unsigned int environment;
    char far *command_tail;
    void far *first_control;
    void far *second_control;
};
extern unsigned int ENVIRONMENT_SEG;
extern VectorAddress SAVED_INT23_VECTOR,SAVED_INT18_VECTOR,SAVED_INT1B_VECTOR;
extern unsigned char far C0_INT_DISPATCH_HANDLER[];
extern unsigned char far CTRL_C_HANDLER_ENTRY[];
extern unsigned char far CTRL_BREAK_HANDLER_ENTRY[];
extern unsigned int far pascal STRING_LENGTH(char far *);
extern void far *far pascal RTL_MEMSET(void far *,int,unsigned int);
extern char far *far pascal RTL_SEARCHPATH(char far *);
extern int far pascal RTL_EXEC(char far *,unsigned int,struct ExecutionBlock far *);
extern void far pascal SHRINK_MEMORY_FOR_EXEC(void);
extern void far pascal RESTORE_MEMORY_AFTER_EXEC(void);
extern void far cdecl REPORT_ERROR(int,...);
extern void far pascal SHUTDOWN_HEAP_BANKS(void);
/* Runs pathname (searched along PATH) with the command tail command.
   On entry command[0] is a spare byte and the text starts at command+1; the first byte is
   filled with the text length, as DOS wants in a command tail. Returns the DOS exit status
   of the child (RTL_EXEC's value: low byte the child's code, high byte how it ended). */
static int far pascal RUN_PROGRAM(char far *pathname,char far *command)
{
    char far *searched;
    struct ExecutionBlock block;
    register int status;
    *command=(char)STRING_LENGTH(command+1);
    RTL_MEMSET(&block,0,sizeof(block));
    block.environment=ENVIRONMENT_SEG;
    block.command_tail=command;
    searched=RTL_SEARCHPATH(pathname);
    if(!searched) {
        OPTION_WARNING_LIMIT=OPTION_ERROR_LIMIT=0;
        REPORT_ERROR(MSG_UNABLE_EXECUTE_COMMAND,pathname);
        SHUTDOWN_HEAP_BANKS();
        EXIT(1);
    }
    SHRINK_MEMORY_FOR_EXEC();
    RVECSET(0x1B,SAVED_INT1B_VECTOR);
    RVECSET(0x23,SAVED_INT23_VECTOR);
    RVECSET(0x18,SAVED_INT18_VECTOR);
    status=RTL_EXEC(searched,0,&block);
    RVECSET(0x18,C0_INT_DISPATCH_HANDLER);
    RVECSET(0x23,CTRL_C_HANDLER_ENTRY);
    RVECSET(0x1B,CTRL_BREAK_HANDLER_ENTRY);
    RESTORE_MEMORY_AFTER_EXEC();
    /* High byte 1 = child ended by Ctrl-C, 2 = by a critical error: stop BCC as well. */
    if((status&0xff00)==0x100 || (status&0xff00)==0x200) {
        SHUTDOWN_HEAP_BANKS();
        EXIT(1);
    }
    /* Negative: the EXEC call itself failed (not enough memory, bad file). */
    if(status<0) {
        OPTION_WARNING_LIMIT=OPTION_ERROR_LIMIT=0;
        REPORT_ERROR(MSG_UNABLE_EXECUTE_COMMAND,pathname);
        SHUTDOWN_HEAP_BANKS();
        EXIT(1);
    }
    return status;
}
