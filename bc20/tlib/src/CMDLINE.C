/* target: CMDLINE */
/* opts: -mc -B -O -Z -r- */
/* CMDLINE.C: TLIB's main file - the command line, main(), and two small helpers.
 *
 *   TLIB libname [/C] [/E] [/P<size>] [/0] commands, listfile
 *
 * The command line is read a character at a time by nextc(), first from the program's
 * command tail in the PSP and then, after an '@name' or a line ending in '&', from a
 * response file or the console (the tail's '&' continues on standard input). getname()
 * reads one name, nextsig() skips blanks and handles /switches and @files, parsecmds() reads
 * the +, - and * commands into commandlist. main() opens the library, has process() (OMF.C)
 * write the new one under a temporary name, then renames the old one to .BAK and the new one
 * into place.
 *
 * Compiled through assembly (-B), without register variables (-r-): the original's
 * sign-extended immediates (83 /1) and NOP-padded short jumps come from TASM. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <io.h>
#include <fcntl.h>
#include <dos.h>
#include <dir.h>
#include <process.h>
#include "TLIB.H"

/* nextc()'s source of characters */
#define FROM_TAIL0	0	/* not started: point at the command tail */
#define FROM_TAIL	1	/* the PSP's command tail */
#define FROM_FILE0	2	/* switch to standard input (a response file, or the console) */
#define FROM_FILE	3	/* lines of standard input */

char nextsig(void);
char *getname(void);
char nextsep(char comma);
void parsecmds(struct cmd **head);
void usage(void);

/* Unreferenced: "$*$*$*", three bytes and "TLIB". It looks like a marker for a patching
 * or installation tool to find; nothing in TLIB reads it. */
char stamp[] = "$*$*$*\2\0\0\3TLIB";
int mode = FROM_TAIL0;		/* where nextc() reads from */
int cont = 0;			/* the line ended in '&': read on from standard input */

char heldch;			/* a character pushed back for nextc() to return again */
char echoon;			/* echo response-file lines to stdout */

/* The next character of the command line: '\n' at the end of each line (the command tail
 * counts as one), and the first character again after heldch is set. */
char nextc(void)
{
	static int argn;
	static char *cmdbuf;
	static char *cursor;
	static char *argp;
	char c;

	if (heldch) {
		if (mode == FROM_FILE0) {	/* a switch to standard input is pending: push it back into the tail */
			argp--;
			*argp = heldch;
			argn++;
			heldch = 0;
		} else {
			c = heldch;
			heldch = 0;
			return c;
		}
	}
	switch (mode) {
	case FROM_TAIL0:
		((unsigned *)&argp)[0] = 0x80;	/* the command tail in the PSP */
		((unsigned *)&argp)[1] = _psp;
		argn = *argp++;
		mode = FROM_TAIL;
	case FROM_TAIL:
		if (--argn >= 0) {
			if ((c = *argp++) != 0)
				break;
			c = ' ';
			break;
		}
		if (cont == 1) {
			mode = FROM_FILE0;
			echoon = 0;
		}
		c = '\n';
		break;
	case FROM_FILE0:
		mode = FROM_FILE;
		if ((cmdbuf = calloc(1, 128)) == NULL)
			error(1, "Not enough memory for command-line buffer");
		cursor = cmdbuf;
	case FROM_FILE:
		if ((c = *cursor++) != 0)
			break;
		if (fgets(cursor = cmdbuf, 127, stdin) != NULL) {
			if (echoon)
				fputs(cursor, stdout);
			c = *cursor;
			cursor++;
			if (c != 0)
				break;
		}
		mode = FROM_TAIL;	/* end of input: an empty tail, so '\n' */
		c = nextc();
		break;
	}
	return c;
}

/* A /switch, after the '/': /C case-sensitive, /0 strip debugging records, /E extended
 * dictionary, /P<n> page size (a power of two from 16 to 32768). */
void option(void)
{
	unsigned v;
	unsigned n;
	unsigned shift;
	char c, uc;

	uc = ((c = nextc()) & 0x80) ? c : toupper(c);
	if (uc == 'C')
		casesens = 1;
	else if (uc == '0')
		zeroflag = 1;
	else if (uc == 'E')
		edict = 1;
	else if (uc == 'P') {
		for (n = 0; isdigit(c = nextc()); n = n * 10 + (c - '0'))
			;
		heldch = c;
		if (n >= 16 && n <= 0x8000) {
			shift = 3;
			v = n >> 3;
			do {
				shift++;
				v >>= 1;
			} while (!(v & 1));
			if (v == 1) {
				pageset = 1;
				pagesize = n;
				pageshift = shift;
				return;
			}
		}
		error(0, "invalid page size value ignored");
	} else
		error(0, "unknown command line switch '%c' ignored", c);
}

/* The next name (a path, a module): up to 64 characters that are not blanks or one of
 * ()*+,-/;<=?[]{|}, upper-cased. NULL when there is none. */
char *getname(void)
{
	static char namebuf[68];
	unsigned n;
	char *p;
	char c;

	n = 0;
	p = namebuf;
	while (!((c = nextc()) & 0x80) && (c == ' ' || c == '\t'))
		;
	while (c > ' ' && strchr("()*+,-/;<=?[]{|}", c) == NULL && n++ < 64) {
		*p++ = (0x80 & c) ? c : toupper(c);
		c = nextc();
	}
	heldch = c;
	*p = 0;
	if (n == 64)
		error(1, "'%s' - path is too long", namebuf);
	else if (n == 0)
		return NULL;
	strupr(namebuf);
	return namebuf;
}

/* The next significant character: skips blanks and line ends (while a line ends in '&'),
 * and acts on /switches and @responsefile on the way. */
char nextsig(void)
{
	char c;
	char *name;

	cont = 0;
	while (!((c = nextc()) & 0x80) && (isspace(c) || c == '/' || c == '@' || c == '&')) {
		if (c == '&')
			cont = 1;
		else if (c == '\n') {
			if (cont == 1)
				continue;
			if (mode != FROM_FILE)
				break;
			mode = FROM_TAIL;
		} else if (c == '/')
			option();
		else if (c == '@') {
			if ((name = getname()) == NULL)
				error(1, "'@' seen, expected a response-file's name");
			close(0);
			if (open(name, O_RDONLY) != 0)
				error(2, "using '%s' for responses", name);
			mode = FROM_FILE0;
			echoon = 1;
		}
	}
	return c;
}

/* Reads a module name and adds it to the list at *HEAD with OPS, or merges OPS into the
 * entry already there for that module. Returns 0 when there is no name. */
char addcmd(struct cmd **head, int ops)
{
	char *name, *path;
	struct cmd *node, *it;
	char *modname;

	heldch = nextsig();
	if ((name = getname()) == NULL)
		return 0;
	addext(name, ".OBJ");
	if (strlen(name) > 63)
		error(0, "ignored '%s', path is too long", name);
	else {
		path = strdup(name);
		if ((name = strrchr(path, '\\')) == NULL && (name = strrchr(path, ':')) == NULL)
			name = path;
		else
			name++;
		modname = basename(name, "");
		if ((it = *head) != NULL)
			for (;;) {
				if (strcmp(it->modname, modname) == 0) {
					ops = it->ops |= ops;
					goto check;
				}
				if (it->next == NULL)
					break;
				it = it->next;
			}
		if ((node = calloc(1, sizeof(struct cmd))) == NULL)
			error(2, "Memory full");
		node->path = path;
		node->modname = modname;
		node->ops = ops;
		if (it != NULL)
			it->next = node;
		else
			*head = node;
check:
		if ((ops & (OP_ADD | OP_EXTRACT)) == (OP_ADD | OP_EXTRACT))
			error(1, "the combinations '+*' or '*+' are not allowed");
	}
	return 1;
}

/* Moves to the next part of the command line: 0 at the end of the line; with COMMA, the
 * part must start with a comma. */
char nextsep(char comma)
{
	char c;

	if ((c = nextsig()) == '\n')
		return 0;
	if (!comma)
		heldch = c;
	else {
		if (c != ',')
			error(1, "unexpected char '%c' in command line", c);
		heldch = nextsig();
	}
	return 1;
}

/* Reads the library commands: each is one or more of -, + and * before a module name. */
void parsecmds(struct cmd **head)
{
	char c;
	unsigned ops;

	do {
		ops = 0;
		for (;;) {
			if ((c = nextsig()) == '-')
				ops |= OP_REMOVE;
			else if (c == '+')
				ops |= OP_ADD;
			else if (c == '*')
				ops |= OP_EXTRACT;
			else
				break;
		}
		heldch = c;
		if (ops == 0)
			break;
	} while (addcmd(head, ops));
}

/* The help screen, for a command line without a library name. */
void usage(void)
{
	puts("Syntax: TLIB libname [/C] [/E] commands, listfile\n"
	     "    libname     library file pathname\n"
	     "    commands    sequence of operations to be performed (optional)\n"
	     "    listfile    file name for listing file (optional)\n"
	     "\n"
	     "A command is of the form: <symbol>modulename, where <symbol> is:\n"
	     "    +           add modulename to the library\n"
	     "    -           remove modulename from the library\n"
	     "    *           extract modulename without removing it\n"
	     "    -+ or +-    replace modulename in library\n"
	     "    -* or *-    extract modulename and remove it\n"
	     "\n"
	     "    /C          case-sensitive library\n"
	     "    /E          create extended dictionary\n"
	     "\n"
	     "Use @filepath to continue from file \"filepath\".\n"
	     "Use '&' at end of a line to continue onto the next line.\n");
	exit(1);
}

char *libname;			/* the library, with .LIB added */

/* The whole command line: the library name, the commands, and the listing file's name. */
void getargs(void)
{
	char *name;

	heldch = nextsig();
	if ((name = getname()) == NULL)
		usage();
	libname = malloc(strlen(name) + 5);
	strcpy(libname, name);
	addext(libname, ".LIB");
	if (nextsep(0)) {
		parsecmds(&commandlist);
		if (nextsep(1)) {
			if ((name = getname()) != NULL) {
				listname = malloc(strlen(name) + 5);
				strcpy(listname, name);
				addext(listname, ".LST");
			}
			if (nextsep(1)) {
				fputc('\n', stdout);
				fflush(stdout);
			}
		}
	}
}

/* Opens the library (or notes that it is new), has process() write the new one as a
 * temporary file "libtmpXXXXXX" (on the library's drive, in its current directory), then
 * keeps the old one as .BAK and renames the new one into place. */
void main(void)
{
	char drive[16];		/* the drive, then the temporary file's name */
	char dir[66];
	char name[10];
	char ext[6];
	int fd;
	struct cmd *p;
	int ops;
	char *bakname;
	char *tmpname;

	conmode();
	fputs("TLIB 3.01 Copyright (c) 1991 Borland International\n", stderr);
	if (setjmp(fatal_jmp)) {
		if (outfile) {
			fclose(outfile);
			remove(tmpname);
		}
		fclose(stdout);
		_exit(1);
	}
	getargs();
	if ((fd = open(libname, 0)) >= 0) {	/* match: mode 0, not O_RDONLY */
		new_library = 0;
		close(fd);
	} else
		new_library = 1;
	publics_table = newtable(casesens);
	ops = 0;
	if (!new_library) {
		if ((in_file = fopen(libname, "rb")) == NULL)
			error(2, "opening '%s'", libname);
		if (setvbuf(in_file, NULL, _IOFBF, 0x4000))
			error(2, "changing file buffer size");
		for (p = commandlist; p != NULL; p = p->next)
			ops |= p->ops;
	}
	if (new_library || (ops & (OP_REMOVE | OP_ADD))) {
		fnsplit(libname, drive, dir, name, ext);
		strcat(drive, "libtmpXXXXXX");
		tmpname = mktemp(drive);
		if ((outfile = fopen(tmpname, "wb")) == NULL)
			error(2, "opening '%s' for output", tmpname);
		if (setvbuf(outfile, NULL, _IOFBF, 0x4000))
			error(2, "changing file buffer size");
	}
	process();
	if (in_file)
		fclose(in_file);
	if (setjmp(fatal_jmp))
		exit(1);
	if (outfile) {
		fclose(outfile);
		bakname = basename(libname, ".BAK");
		remove(bakname);
		if (in_file && rename(libname, bakname)) {
			error(0, "results are safe in file '%s'", tmpname);
			error(2, "renaming '%s' to '%s'", libname, bakname);
		}
		if (rename(tmpname, libname))
			error(2, "renaming '%s' to '%s'", tmpname, libname);
	}
	exit(0);
}

/* NAME as C++ source, when it is a mangled C++ name (DEMANGLE.C); in a static buffer. */
char *demangle(char *name)
{
	unmangle(name, cbuf, 128, NULL, NULL, 1);
	return cbuf;
}

/* Abandons the extended dictionary: back to writeext() (OMF.C). */
void giveup(void)
{
	longjmp(abortjb, 1);
}
