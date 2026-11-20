/* target: CODE_37_RACCESS */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: DELETE_FILE. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: DELETE_FILE is unlink (or remove): DOS function 41h deletes
   the named file through RTL_DOS_CALL_PTR (RDOSPTR.C).  DOS leaves AX
   undefined on success, so any result other than -1 is turned into 0.
   Returns 0, or -1 with errno set.
   Callers: DISCARD_OUTPUT_FILE (RFILEIO.C), the
   driver (DRVLINK) and the precompiled-header code (PCH). */
extern int far pascal RTL_DOS_CALL_PTR(unsigned int,char far *,unsigned int);
int far pascal DELETE_FILE(char far *path)
{
    register int result;
    result=RTL_DOS_CALL_PTR(0x41,path,0);
    if(result!=-1) result=0;
    return result;
}
