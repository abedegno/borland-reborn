/* target: GETSTAT */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module GETSTAT (0054:1B81, image 0x20C1): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/GETSTAT.C); its code is the
   same in both programs. */
/* Role: far-memory heap: returns HEAP_STATUS, the result of the last heap call. */
/* Overview: far entry that returns HEAP_STATUS, the result of the last heap
   call: 0, or 1000h (no memory), 1001h (no descriptors), 1002h (bad handle
   or argument).  BCC.EXE also has 1003h (swap-file error); CPP.EXE has no
   swap file. */
extern unsigned int HEAP_STATUS;
static unsigned int far pascal _loadds BCC_READ_STATUS(void)
{
    return HEAP_STATUS;
}
