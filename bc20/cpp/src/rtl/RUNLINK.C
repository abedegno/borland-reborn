/* target: RUNLINK */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RUNLINK (11AA:000E..0034): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RUNLINK.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: DELETE_FILE. */
/* Overview: DELETE_FILE is unlink (or remove): DOS function 41h deletes
   the named file through RTL_DOS_CALL_PTR (RDOSPTR.C).  DOS leaves AX
   undefined on success, so any result other than -1 is turned into 0.
   Returns 0, or -1 with errno set.
   The only caller in CPP.EXE is DISCARD_OUTPUT_FILE (RFILEIO.C); BCC.EXE's
   DRVLINK and precompiled-header code also call it there. */
extern int far pascal RTL_DOS_CALL_PTR(unsigned int,char far *,unsigned int);
int far pascal DELETE_FILE(char far *path)
{
    register int result;
    result=RTL_DOS_CALL_PTR(0x41,path,0);
    if(result!=-1) result=0;
    return result;
}
