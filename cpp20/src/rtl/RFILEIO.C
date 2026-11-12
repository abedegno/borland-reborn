/* target: RFILEIO */
/* opts: -mm -G -O -Z -p -zAFCODE */
/* link: -zAFCODE gives this file's code a class of its own. In CPP.EXE its relocations come
   before the run-time library modules' (it was linked before them), yet its code lies after
   them, starting on a paragraph: TLINK lays out a class after the classes it met earlier.
   The class name itself is not in the EXE. */
/* CPP.EXE module RFILEIO (11FF:0000..0157): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RFILEIO.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: CREATE_OUTPUT_FILE, BCC_OUTPUT_STRING, OUTPUT_CHAR,
   CLOSE_OUTPUT_FILE, DISCARD_OUTPUT_FILE. */
/* Overview: the program's one buffered output file.  In CPP.EXE it is the
   preprocessor output (the .i file): driver/SEGNAMES.C names and creates
   it, the lexer, input, preprocessor and token output code (LEXER, INPUT,
   PREPROC, TOKADV) write the text through OUTPUT_CHAR and
   BCC_OUTPUT_STRING, and END_SESSION (driver/INITPOOL.C) closes it.  (In
   BCC.EXE the same code writes the assembler output and the linker
   response file.)  Only one such file is open at a time:
   OUTPUT_FILE_HANDLE is its DOS handle (-1 when none),
   OUTPUT_BUFFER_SEG the segment of a 4096-byte buffer taken from the far
   heap, and OUTPUT_BUFFER_FILL the number of bytes in the buffer.
   CREATE_OUTPUT_FILE creates the file and the buffer, OUTPUT_CHAR and
   BCC_OUTPUT_STRING add text and write each full buffer, CLOSE_OUTPUT_FILE
   writes the rest and closes, and DISCARD_OUTPUT_FILE (used by the Ctrl-C
   handler RCTRL23 in driver/CPPMAIN.C) closes without writing and deletes
   the file.
   Things to know: a write error is fatal (REPORT_FATAL with
   MSG_ERROR_WRITING_OUTPUT); DISCARD_OUTPUT_FILE always deletes the file
   named by ASM_OUTPUT_PATH (in CPP.EXE the output name SEGNAMES built),
   whichever file is open; and SET_DEFAULT_OWNER_TAG stores
   HEAP_DEFAULT_OWNER_TAG (heap/HPTAGS.C).  This is a
   tiny stand-in for stdio's fopen, fputc, fputs and fclose. */
#include <dos.h>
#include "DATA.H"
#include "HEAP.H"
#include "MSG.H"
extern unsigned int STRING_POOL_SEG;
extern unsigned char CURRENT_OWNER_TAG;
extern int far pascal RTL_CREAT(char far *,unsigned int);
extern void far pascal POOL_INIT(unsigned int far *,unsigned int);
extern unsigned int far pascal FREE_HANDLE_BLOCK(unsigned int far *);
extern int far pascal RTL_WRITE(int,void far *,unsigned int);
extern int far pascal RTL_CLOSE(int);
extern int far pascal DELETE_FILE(char far *);
extern void far cdecl REPORT_FATAL(int,...);
void far pascal OUTPUT_CHAR(char value);
/* Create name for writing and set up the 4096-byte buffer.  The buffer is
   allocated under CURRENT_OWNER_TAG: the default heap owner tag is
   switched for the POOL_INIT call and then put back.  The variable option
   holds the saved tag.  Returns the handle, or -1 if the file could not be
   created (the caller, driver/SEGNAMES.C, reports that); the buffer is set
   up either way. */
int far pascal CREATE_OUTPUT_FILE(char far *name)
{
    unsigned int option;
    OUTPUT_FILE_HANDLE=RTL_CREAT(name,0);
    option=GET_DEFAULT_OWNER_TAG();
    SET_DEFAULT_OWNER_TAG(CURRENT_OWNER_TAG);
    POOL_INIT(&OUTPUT_BUFFER_SEG,4096);
    SET_DEFAULT_OWNER_TAG(option);
    OUTPUT_BUFFER_FILL=0;
    return OUTPUT_FILE_HANDLE;
}
/* Write a NUL-terminated string to the output file (like fputs). */
void far pascal BCC_OUTPUT_STRING(char far *text)
{
    while(*text) OUTPUT_CHAR(*text++);
}
/* Store one character in the buffer (like fputc) and write the buffer to
   the file when it holds 4096 bytes.  A short write empties the buffer
   and reports a fatal error. */
void far pascal OUTPUT_CHAR(char value)
{
    ((char far *)MK_FP(OUTPUT_BUFFER_SEG,0))[OUTPUT_BUFFER_FILL]=value;
    ++OUTPUT_BUFFER_FILL;
    if(OUTPUT_BUFFER_FILL>=4096) {
        if(RTL_WRITE(OUTPUT_FILE_HANDLE,MK_FP(OUTPUT_BUFFER_SEG,0),4096)!=4096) {
            OUTPUT_BUFFER_FILL=0;
            REPORT_FATAL(MSG_ERROR_WRITING_OUTPUT);
        }
        OUTPUT_BUFFER_FILL=0;
    }
}
/* Write what is left in the buffer, free the buffer, close the file and
   mark it closed.  A failed write is reported, fatally, only after the
   file has been closed.  Does nothing when no file is open. */
void far pascal CLOSE_OUTPUT_FILE(void)
{
    register int error;
    if(OUTPUT_FILE_HANDLE>=0) {
        if(OUTPUT_BUFFER_FILL) error=RTL_WRITE(OUTPUT_FILE_HANDLE,MK_FP(OUTPUT_BUFFER_SEG,0),OUTPUT_BUFFER_FILL)!=OUTPUT_BUFFER_FILL;
        else error=0;
        FREE_HANDLE_BLOCK(&OUTPUT_BUFFER_SEG);
        RTL_CLOSE(OUTPUT_FILE_HANDLE);
        OUTPUT_FILE_HANDLE=-1;
        if(error) REPORT_FATAL(MSG_ERROR_WRITING_OUTPUT);
    }
}
/* Abandon the open output file: close it without writing the buffer,
   free the buffer and delete the file at ASM_OUTPUT_PATH (an offset in the
   string pool).  Used when compilation is interrupted. */
void far pascal DISCARD_OUTPUT_FILE(void)
{
    if(OUTPUT_FILE_HANDLE>=0) {
        RTL_CLOSE(OUTPUT_FILE_HANDLE);
        FREE_HANDLE_BLOCK(&OUTPUT_BUFFER_SEG);
        OUTPUT_FILE_HANDLE=-1;
        DELETE_FILE((char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH));
    }
}
