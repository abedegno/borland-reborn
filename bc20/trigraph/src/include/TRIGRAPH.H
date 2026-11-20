/* TRIGRAPH.H: what TRIGRAPH's two files share.
 *
 * FILEIO.CPP owns the files and the two buffers; TRIGRAPH.CPP owns the command line and the
 * two filters. The filters read from inbuf through inp, one character at a time, and write
 * to outbuf through put(). */
#include <stdio.h>

#define BUFSIZE	1024		/* size of each buffer */

/* Writes c to the output buffer, emptying the buffer first when it is full.
 * match: of the spellings tried, only this one, with its empty arm "(void)0", gives the
 * original's code (others move the increment of outp or the jumps). */
#define put(c)	((outp == outbuf + BUFSIZE ? flush() : (void)0), *outp++ = (c))

extern char outbuf[BUFSIZE];
extern char *inp;		/* next character to read from inbuf */
extern char *outp;		/* next free place in outbuf */
extern int done;		/* set at the end of the input or on an error */
extern int err;			/* index into msgs[] in FILEIO.CPP; 0 for no error */

void initbuf(void);
void fill(void);
void flush(void);
void unget(char c);
int openfiles(char *name, char *dir, char *ext);
void closefiles(void);
void finish(char *name, char *dir, char *ext);
