/* target: CODE_19_RFNSPLIT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: FNSPLIT, FNMERGE. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's fnsplit and fnmerge (dir.h), which take a DOS
   path apart into drive, directory, name and extension and put one
   together again.  The flag and size macros are those of dir.h.  FNSPLIT
   copies the path (leading blanks skipped, at most MAXPATH characters)
   into buffer, with a 0 in buffer[0] in front of it, and walks backward
   from the end.  Each part it recognises is copied out with SLICE_TEXT and
   cut off the work copy by writing a 0 over its first character, so the
   next part found ends there.  The 0 in buffer[0] is what stops the walk
   at the start of the path.  Any of drive, dir, name and ext may be NULL.
   Used by the driver and option code to build file names (output, object
   and library names). */
/* Segment 0A47:0005..02B6, Borland run-time library fnsplit and fnmerge with
   pascal calling and far pointers, built by Turbo C 2.01.  SLICE_TEXT copies
   one part of the split path and cuts it off the work copy.  In FNSPLIT,
   split first holds strlen(path) and then becomes the flag "name part split
   off"; COPY_TO_END is FNMERGE's copy helper. */
#define WILDCARDS 0x01
#define EXTENSION 0x02
#define FILENAME  0x04
#define DIRECTORY 0x08
#define DRIVE     0x10
#define MAXPATH   80
#define MAXDRIVE  3
#define MAXDIR    66
#define MAXFILE   9
#define MAXEXT    5

extern char far * far pascal RTL_STRNCPY(char far *,char far *,unsigned int);  /* strncpy */
extern unsigned int far pascal STRING_LENGTH(char far *);

/* Copy at most length characters from source to destination (if given)
   and terminate them, then cut the work copy at source. */
static void near pascal SLICE_TEXT(char far *destination,char far *source,unsigned int length)
{
    if(destination) {
        RTL_STRNCPY(destination,source,length);
        destination[length]=0;
    }
    *source=0;
}

/* Split path into the four parts and return the dir.h flags: which parts
   were present (DRIVE, DIRECTORY, FILENAME, EXTENSION) and WILDCARDS if
   the name or extension holds '*' or '?'. */
int far pascal FNSPLIT(char far *path,char far *drive,char far *dir,char far *name,char far *ext)
{
    char far *p;
    char buffer[MAXPATH+2];
    register int split;
    register int flags;
    flags=0;
    if(drive) *drive=0;
    if(dir) *dir=0;
    if(name) *name=0;
    if(ext) *ext=0;
    p=buffer;
    while(*path==' ') path++;
    if((split=STRING_LENGTH(path))>MAXPATH) split=MAXPATH;
    *p++=0;
    RTL_STRNCPY(p,path,split);
    *(p+=split)=0;
    split=0;
    /* Walk backward.  Before split is set, a '.' starts the extension (the
       last '.' only) and the first '\', '/' or ':' (or the start) ends the
       name.  After that, a ':' or the start ends the directory.  break
       leaves the loop, continue keeps walking. */
    for(;;) {
        switch(*--p) {
        case '.':
            if(!split && !(flags&EXTENSION)) {
                flags|=EXTENSION;
                SLICE_TEXT(ext,p,MAXEXT);
            }
            continue;
        case ':':
        case 0:
            if(split) {
                if(*++p) flags|=DIRECTORY;
                SLICE_TEXT(dir,p,MAXDIR);
                p--;
                break;
            }
            /* fall through */
        case '/':
        case '\\':
            if(!split) {
                split++;
                if(*++p) flags|=FILENAME;
                SLICE_TEXT(name,p,MAXFILE);
                p--;
                if(*p==':' || *p==0) break;
            }
            continue;
        case '*':
        case '?':
            if(!split) flags|=WILDCARDS;
            /* fall through */
        default:
            continue;
        }
        break;
    }
    /* Stopped at a ':': what is in front of it is the drive. */
    if(*p==':') {
        if(buffer[1]) flags|=DRIVE;
        SLICE_TEXT(drive,buffer+1,MAXDRIVE);
    }
    return flags;
}

/* Copy source to destination with its terminator and return the address
   of that terminator, so the next copy appends (like stpcpy). */
static char far * far pascal COPY_TO_END(char far *destination,char far *source)
{
    while((*destination=*source++)!=0) destination++;
    return destination;
}

/* Build path from the parts: only the first character of drive is used,
   followed by ':'; a '\' is added after dir unless it already ends in one
   or in '/'.  NULL or empty parts are left out. */
void far pascal FNMERGE(char far *path,char far *drive,char far *dir,char far *name,char far *ext)
{
    if(drive && *drive) {
        *path++=*drive++;
        *path++=':';
    }
    if(dir && *dir) {
        path=COPY_TO_END(path,dir);
        if(path[-1]!='\\' && path[-1]!='/') *path++='\\';
    }
    if(name) path=COPY_TO_END(path,name);
    if(ext) path=COPY_TO_END(path,ext);
    *path=0;
}
