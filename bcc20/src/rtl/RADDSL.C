/* target: CODE_16_RADDSL */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: ADD_TRAILING_BACKSLASH. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: ADD_TRAILING_BACKSLASH prepares a directory name so a file
   name can be appended to it (no standard C function does this).  It
   changes the caller's buffer in place, so the buffer needs room for one
   more character.  Callers: driver/SEGNAMES.C, which builds the output
   path from the -n directory, and DRVLINK.  For an empty path end points
   before the buffer, but the length test keeps it from being read. */
/* Segment 0A3F:0003..005E, run-time path helper (Turbo C 2.01): upper-cases
   the path (RTL_STRUPR, strupr; module RSTRLOW, named for strlwr but holding strupr) and
   appends a '\' unless the path is
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
