/* target: RADDSL */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RADDSL (1145:0003..005F): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RADDSL.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: ADD_TRAILING_BACKSLASH. */
/* Overview: ADD_TRAILING_BACKSLASH prepares a directory name so a file
   name can be appended to it (no standard C function does this).  It
   changes the caller's buffer in place, so the buffer needs room for one
   more character.  The only caller in CPP.EXE is driver/SEGNAMES.C, which
   builds the output path from the -n directory (BCC.EXE's DRVLINK also
   calls it; CPP's DRVLINK does not).  For an empty path end points
   before the buffer, but the length test keeps it from being read. */
/* Run-time path helper (Turbo C 2.01): upper-cases the path (RTL_STRUPR,
   strupr, which CPP.EXE has in driver/CPPMAIN.C; BCC.EXE has it in a module
   RSTRLOW) and appends a '\' unless the path is
   empty or already ends in '\', '/' or ':'. */
extern void far pascal RTL_STRUPR(char far *text);
extern unsigned int far pascal STRING_LENGTH(char far *);

void far pascal ADD_TRAILING_BACKSLASH(char far *path)
{
    char far *end;
    register int length;
    RTL_STRUPR(path);
    length=STRING_LENGTH(path);
    end=path+length-1;
    if(length>0 && *end!='\\' && *end!='/' && *end!=':') {
        *++end='\\';
        *++end=0;
    }
}
