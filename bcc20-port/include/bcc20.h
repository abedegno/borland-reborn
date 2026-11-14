/* bcc20.h: Borland C++ 2.0's compiler as a library call (README.md, "Plan", step 6).
   bcc20_compile runs one BCC command line in-process, from memory to memory: the files it
   names come from the job (the source, headers), every file BCC writes (the object file,
   the assembly listing, a precompiled header file) comes back in the result, and so does
   the console text.  Each call starts BCC afresh (its whole memory image reloaded), so one
   compile never sees another's state.  Not reentrant: one compile at a time per process.

   Files BCC asks for that the job does not hold are read from the host directory root,
   which stands for drive C:'s root and the current directory (for the toolchain's
   headers, say); with no root they are not found.  BCC never writes to the host. */
#ifndef BCC20_H
#define BCC20_H
#include <stddef.h>

#define BCC20_MAX_FILES 4000    /* a job's files; bcc20_compile returns -1 for more */

typedef struct {
    const char *name;           /* a DOS name, as BCC will ask for it: "T.C", "PROJ\\X.H" */
    const void *data;
    size_t size;
} bcc20_file;

typedef struct {
    int argc;                   /* BCC's arguments, without the program's own name */
    const char *const *argv;
    const bcc20_file *files;    /* the files BCC may read */
    int n_files;                /* at most BCC20_MAX_FILES */
    const char *root;           /* host directory for any other file, or NULL */
    long long time;             /* the clock and the files' times, in seconds since 1970;
                                   0 for the host's clock */
    int stack_limit;            /* 1: stop where BCC.EXE's 8086 stack would ("Out of
                                   memory"); 0: no limit (README.md, "Decisions") */
    /* the compiler explaining its choices, one line per event, or NULL: "function name=f",
       "regvar var=i reg=si score=12", "regvar_candidate ...", "reg op=7 preferred=ax
       allowed=ax,dx,bx free=dx,bx narrowed_to=ax,dx,bx chose=dx", "spill ...", "crossjump
       merged=3 ops ...", "peephole removed_load op=12 value_in=ax" (include/explain.h) */
    void (*explain)(void *context, const char *line);
    void *explain_context;
} bcc20_job;

typedef struct {
    int status;                 /* BCC's exit status */
    char *console;              /* what BCC printed (not 0-terminated) */
    size_t console_size;
    bcc20_file *outputs;        /* the files BCC wrote, data owned by the result */
    int n_outputs;
} bcc20_result;

/* runs the job; returns BCC's exit status (also in result->status), or -1 without running
   when the job has more than BCC20_MAX_FILES files */
int bcc20_compile(const bcc20_job *job, bcc20_result *result);
/* frees what bcc20_compile put in result */
void bcc20_free(bcc20_result *result);
#endif
