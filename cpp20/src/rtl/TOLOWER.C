/* target: TOLOWER */
/* opts: -mm -G -O -Z -r- -p -zCCODE36 */
/* link: -zCCODE36 gives this file the code segment it shares with the other files of frame 11A6h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module TOLOWER (11A6:0006..002A): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/TOLOWER.C); its code is the same in both programs. */
/* Role: run-time library: tolower() using the _ctype table. Entry points: TOLOWER. */
/* Overview: TOLOWER is the C library's tolower, the twin of RTL_TOUPPER
   (RTOUPPER.C): the bit with value 4 (_IS_UPP) of the _CTYPE entry
   (indexed by the character plus 1) marks an upper-case letter, which is changed by adding 32.  Only the
   low byte of value is used.  Callers in CPP.EXE: STRING_COMPARE
   (RSTRICMP.C), the lexer (LEXER.C, number scanning) and DRVLINK. */
extern unsigned char _CTYPE[];
unsigned int far pascal TOLOWER(int value)
{
    if(_CTYPE[(unsigned char)value+1]&4) return (unsigned char)value+32;
    return (unsigned char)value;
}
