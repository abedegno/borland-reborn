/* target: CONFIG */
/* opts: -mc -O -Z -d -a -y */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mem.h>
#include <io.h>
#include <fcntl.h>
#include <dos.h>
#include <assert.h>
#include <limits.h>
#include "MAKE.H"

/* config.c: the command line options, and -W, which writes the yes/no options into
 * MAKE.EXE itself. The original's name: its assertion says "config.c", line 554. The
 * options from autodep on sit right after the signature in MAKE.EXE's data, so -W finds the
 * signature in the file and writes the 16 bytes after it. */

/* An option letter (opttab is sorted for bsearch()): type 0 is a flag, on unless the
 * letter is followed by '-'; 1 takes a string (strarg() in MAIN.C); 3 is -W. */
struct option {
	int letter;
	int type;
	int *flag;
};

extern char **_argv;

int stringopt;
int debug = 0;
int help = 0;
char signature[12] = "!@#$%^&*()";
int autodep = 0;
int optx = 0;			/* never used */
int silent = 0;
int noexec = 0;
int buildall = 0;
int keeptemp = 0;
int ignore = 0;
int swap = 0;

int optcmp(const void *key, const void *entry);

struct option opttab[15] = {
	{'=', 0, &debug},
	{'?', 0, &help},
	{'B', 0, &buildall},
	{'D', 1, 0},
	{'I', 1, 0},
	{'K', 0, &keeptemp},
	{'S', 0, &swap},
	{'U', 1, 0},
	{'W', 3, 0},
	{'a', 0, &autodep},
	{'f', 1, 0},
	{'h', 0, &help},
	{'i', 0, &ignore},
	{'n', 0, &noexec},
	{'s', 0, &silent},
};

void pascal setoption(char *opt, char *next, int *skip);
void writeopts(void);

/* the options before the first target name; returns the first argument after them */
char *pascal getoptions(register int argc, char **argv)
{
	int skip;

	argc--;
	argv++;
	while (argc > 0 && **argv == '-') {
		skip = 0;
		setoption(*argv + 1, argv[1], &skip);
		if (skip) {
			argv++;
			argc--;
		}
		argv++;
		argc--;
	}
	return *argv;
}

int optcmp(const void *key, const void *entry)
{
	if (*(char *)key < *(char *)entry)
		return -1;
	if (*(char *)key > *(char *)entry)
		return 1;
	return 0;
}

void pascal setoption(char *opt, char *next, int *skip)
{
	struct option *o;

	o = bsearch(opt, opttab, 15, sizeof(struct option), optcmp);
	if (o == NULL) {
		msg(badarg, opt - 1);
		msg("\n\n");
		help = 1;
	} else
		switch (o->type) {
		case 0:
			*o->flag = opt[1] != '-';
			break;
		case 1:
			stringopt = 1;
			strarg(opt, next, skip);
			break;
		case 3:
			writeopts();
			exit(0);
		}
}

char *pascal strsave(char *s)
{
	char *p;

	p = alloc(strlen(s) + 1);
	strcpy(p, s);
	return p;
}

/* moves fd's position to just after the signature sig; 0 when found. A read that fails or
 * reaches the end of the file is not caught: the test is == 1 where -1 was meant, and
 * without the signature the loop goes on reading nothing. */
int pascal findsig(register int fd, char *sig)
{
	unsigned long bytesread;
	char *p;
	int len;
	register unsigned i;

	len = strlen(sig) + 1;
	for (;;) {
		i = 0;
		memset(expbuf, 0, 0x800);
		if ((bytesread = read(fd, expbuf, 0x800)) == 1)
			return -1;
#line 554			/* the original's line, which the assertion message names */
		assert(bytesread < UINT_MAX);
		do {
			p = memchr(expbuf + i, *sig, (unsigned)bytesread - i);
			if (p != NULL) {
				if ((i = p - expbuf) > (unsigned)bytesread - len) {
					lseek(fd, (long)(len + 1), 1);
					break;
				}
				if (strncmp(sig, expbuf + i, len) == 0) {
					lseek(fd, lseek(fd, 0L, 1) - (unsigned)bytesread + i + len + 1, 0);
					return 0;
				}
				i++;
			}
		} while (p != NULL);
	}
}

/* a key, with echo (DOS function 1) */
int getkey(void)
{
	_AH = 1;
	geninterrupt(0x21);
	return _AL;
}

/* a line from the keyboard (DOS function 0Ah): line needs max + 3 bytes */
char *pascal getline(char *line, int max)
{
	line[0] = max;
	_ES = _DS;
	_DS = FP_SEG(line);
	_DX = FP_OFF(line);
	_AH = 0x0A;
	geninterrupt(0x21);
	_DS = _ES;
	max = line[1];
	memmove(line, line + 2, max);
	line[max] = 0;
	return line;
}

/* -W: writes the flag options into MAKE.EXE (this program, or the one the user names) */
void writeopts(void)
{
	char *path;
	char c;
	register int fd;

	if (stringopt)
		fatal("Cannot write a string option.\n");
	if (_osmajor < 3) {
		if ((path = pathfind("MAKE.EXE")) == NULL)
			fatal("Cannot find MAKE.EXE\n");
	} else
		path = *_argv;
	msg("\nWrite options to %s? ( Y/N ) [N]:", path);
	if ((c = getkey()) != 'Y' && c != 'y') {
		msg("\nEnter full path of MAKE.EXE to modify: ");
		path = alloc(0x53);
		getline(path, 0x50);
		msg("\n");
		if (*path == 0)
			exit(2);
	} else
		msg("\n");
	if ((fd = open(path, O_RDWR | O_BINARY)) == -1)
		fatal("Unable to open file %s.\n", path);
	if (findsig(fd, signature))
		fatal("%s not a MAKE.\n", path);
	if (write(fd, &autodep, 16) != 16)
		fatal("Write error on file %s.\n", path);
	exit(0);
}
