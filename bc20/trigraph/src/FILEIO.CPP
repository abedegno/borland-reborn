/* target: FILEIO */
/* opts: -ms -O */
/* FILEIO.CPP: TRIGRAPH's buffers and files.
 *
 * The input is read in blocks of BUFSIZE into inbuf, with an EOF character (0xFF) stored
 * after the last byte read; the filters see that character and call fill() for the next
 * block. Output goes to a temporary file, which replaces the input file at the end, and the
 * input file is kept as NAME.BAK.
 *
 * TRIGRAPH.EXE keeps no symbols: every name here is descriptive. The program was two files:
 * this file's string literals come before TRIGRAPH.CPP's initialised data in the data
 * segment, which one file could not give. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dir.h>
#include <io.h>
#include "TRIGRAPH.H"

/* the messages for each value of err */
char *msgs[] = {
	"",
	"Unable to open input file.",
	"Unable to open temporary file.",
	"Error reading input file.",
	"Error writing output file.",
	"System error."
};

char outbuf[BUFSIZE];
char *inp;
char *outp;
int done;
int err;
char inname[80];
FILE *fout;
char outname[80];
FILE *fin;
char inbuf[BUFSIZE + 1];		/* one more for the EOF mark */
char tmpname[14];	/* match: the BSS needs 14 or 15 bytes here; L_tmpnam is 13 */

/* reports the error and that NAME was left as it was */
void notmod(char *name)
{
	char buf[80];

	puts(msgs[err]);
	strcpy(buf, name);
	strcat(buf, " not modified.");
	puts(buf);
}

/* empties both buffers: the EOF mark at inp makes the first read call fill() */
void initbuf(void)
{
	err = 0;
	inp = inbuf + BUFSIZE;
	inbuf[BUFSIZE] = EOF;
	outp = outbuf;
}

/* reads the next block into inbuf; sets done at the end of the file or on an error */
void fill(void)
{
	unsigned n;

	/* an EOF mark before the end of the buffer is the end of the file (or a 0xFF byte
	   in the input, which also stops the program) */
	if (inp != inbuf + BUFSIZE + 1)
		done = 1;
	else if ((n = fread(inbuf, 1, BUFSIZE, fin)) <= 0 && !(fin->flags & _F_EOF)) {
		err = 3;
		done = 1;
	} else {
		inbuf[n] = EOF;
		inp = inbuf;
	}
}

/* writes out the output buffer */
void flush(void)
{
	if (fwrite(outbuf, 1, outp - outbuf, fout) != outp - outbuf) {
		err = 4;
		done = 1;
	} else
		outp = outbuf;
}

/* puts c back, to be read again */
void unget(char c)
{
	*--inp = c;
}

/* the input file's name: NAME, with .c added when it has no extension */
void setinname(char *name)
{
	strcpy(inname, name);
	if (!strchr(inname, '.'))
		strcat(inname, ".c");
}

/* the output file's name: NAME with the directory of -n and the extension of -x */
void makeoutname(char *name, register char *dir, register char *ext)
{
	char file[MAXFILE];
	char e[MAXEXT + 1];
	char drive[MAXDIR];
	char d[MAXPATH];

	fnsplit(name, drive, d, file, e);
	if (dir)
		strcpy(d, dir);
	if (ext) {
		strcpy(e, ".");
		strcat(e, ext);
	}
	if (e[0] == 0)
		strcpy(e, ".c");
	fnmerge(outname, drive, d, file, e);
}

/* opens the input file and a temporary output file; 0 on an error */
int openfiles(register char *name, char *dir, char *ext)
{
	setinname(name);
	makeoutname(name, dir, ext);
	if ((fin = fopen(inname, "rb")) == NULL) {
		err = 1;
		return 0;
	}
	tmpnam(tmpname);
	if ((fout = fopen(tmpname, "wb")) == NULL) {
		err = 2;
		return 0;
	}
	return 1;
}

void closefiles(void)
{
	if (fin)
		fclose(fin);
	if (fout)
		fclose(fout);
}

/* renames the input file to NAME.BAK and the temporary file to the input file */
void backup(char *name)
{
	char *p;
	char bak[14];

	strcpy(bak, name);
	if ((p = strchr(bak, '.')) == NULL)
		strcat(bak, ".BAK");
	else
		strcpy(p, ".BAK");
	unlink(bak);
	if (rename(inname, bak) == -1)
		err = 5;
	else if (rename(tmpname, inname) == -1) {
		err = 5;
		rename(bak, inname);
	}
}

/* After a file: on an error, removes the output and says the file was not modified;
 * otherwise, without -n or -x, replaces the input file by the output.
 * With -n or -x nothing renames the temporary file to outname, and on an error the file
 * removed is outname, not the temporary file. */
void finish(register char *name, char *dir, char *ext)
{
	if (err) {
		unlink(outname);
		notmod(name);
	} else if (!dir && !ext)
		backup(name);
}

