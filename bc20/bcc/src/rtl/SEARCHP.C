/* target: CODE_42_SEARCHP */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library: searchpath(); finds a file in the current directory or along
   PATH. Entry points: RTL_SEARCHPATH. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RTL_SEARCHPATH is the C library's searchpath (dir.h).  Its
   only caller is RUN_PROGRAM in driver/RDRV388.C, which uses it to find
   TASM.EXE or TLINK.EXE before running them.  The result is always the
   static SEARCH_BUFFER, overwritten by the next call.  One quirk, kept
   from the original: when PATH does not end in ';', path is left one past
   the value's terminator after the last directory, so the loop test reads
   the next byte of RTL_GETENV's static buffer (probably 0 or text left
   from an earlier, longer value). */
/* Segment 0AF5:0001..0121, Borland run-time library searchpath(), built by
   Turbo C 2.01 like the rest of the library BCC.EXE links.  If the file
   exists (_chmod(file,0) != -1) its name is copied to the static buffer;
   otherwise each ';'-separated directory of PATH is copied there, a '\' is
   added unless it already ends in ':', '/' or '\' (or is at most one
   character), the file name appended and _chmod tried again.  Returns the
   buffer, or NULL. */
extern int cdecl _chmod(char far *path,int func,...);   /* RCHMOD */
extern char far * far pascal RTL_GETENV(char far *name);   /* getenv */
extern void far pascal RTL_MEMMOVE(void far *,void far *,unsigned int);   /* memmove */
extern unsigned int far pascal STRING_LENGTH(char far *);
extern char far * far pascal STRING_APPEND(char far *,char far *);
extern char far * far pascal STRING_COPY(char far *,char far *);
extern char near SEARCH_BUFFER[];       /* DS:8BCE */
extern char near SEARCH_PATH_NAME[];    /* DS:5C8E, "PATH" */
extern char near SEARCH_SEPARATOR[];    /* DS:5C93, "\\" */

char far * far pascal RTL_SEARCHPATH(char far *file)
{
    char far *p;
    char far *path;
    if(_chmod(file,0)==-1) {
        path=RTL_GETENV(SEARCH_PATH_NAME);
        if(!path) return 0;
        do {
            /* Copy the next directory of PATH (up to ';' or the end) into
               the buffer and step path past it. */
            for(p=path;*p && *p!=';';p++) ;
            RTL_MEMMOVE(SEARCH_BUFFER,path,p-path);
            SEARCH_BUFFER[p-path]=0;
            path=p+1;
            /* Append "\" unless the directory already ends in a separator,
               then the file name, and test whether that file exists. */
            p=SEARCH_BUFFER+STRING_LENGTH(SEARCH_BUFFER)-1;
            if(SEARCH_BUFFER<p && *p!=':' && *p!='/' && *p!='\\')
                STRING_APPEND(SEARCH_BUFFER,SEARCH_SEPARATOR);
            STRING_APPEND(SEARCH_BUFFER,file);
            if(_chmod(SEARCH_BUFFER,0)!=-1) return SEARCH_BUFFER;
        } while(*path);
        return 0;
    }
    STRING_COPY(SEARCH_BUFFER,file);
    return SEARCH_BUFFER;
}
