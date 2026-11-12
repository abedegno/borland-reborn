/* target: CODE_1_REXIT09F */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: EXIT. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: BCC's exit.  EXIT puts back the INT 1Bh (Ctrl-Break) vector
   saved at startup, the one vector that is still BCC's own at this point,
   and ends the program through C0_TERMINATE (driver/C0.ASM, DOS 4Ch).
   Only the low byte of status reaches DOS, because C0_TERMINATE loads it
   into AL.  Unlike the C library's exit it runs no atexit functions and
   flushes nothing; callers close their files first.  Called from many
   places in the driver and heap code.  The context lines are build
   directives naming the file whose static RVECSET this one calls; the
   mid-file #pragma option -G- is part of the original build. */
/* context: RVECSET.C */
/* context-helper-entry: RVECSET */
/* context-call: 0xF RVECSET RVECSET_BODY */
/* Actual vector setter is separately proved against its original on each build. */
#pragma option -G-
extern void far *SAVED_INT1B_VECTOR;
extern void far cdecl C0_TERMINATE(int status);
void far pascal EXIT(int status)
{
    RVECSET(0x1B,SAVED_INT1B_VECTOR);
    C0_TERMINATE(status);
}
