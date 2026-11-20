/* target: TRIGRAPH */
/* opts: -ms -O */
/* TRIGRAPH.CPP: TRIGRAPH 1.0's command line and its two filters.
 *
 * By default the program replaces each ANSI trigraph (??= ??( ??/ ??) ??' ??< ??! ??> ??-)
 * by the character it stands for, and joins lines spliced by a backslash at the end of a
 * line. With -u it does the opposite and writes a trigraph for each of those nine
 * characters.
 *
 * The program was written in C++ (BCC compiled it as a .CPP file: its names are mangled and
 * the increment of *p++ comes before the load), but uses nothing of C++ beyond C. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "TRIGRAPH.H"

int undo = 0;
char *outdir = 0;
char *outext = 0;
/* never used by the code */
char idblock[10] = { '$', '*', '$', '*', '$', '*', 0, 1, 0, 1 };
char banner[] = "\nTrigraph  Version 1.0  Copyright (c) 1991 Borland International";

void usage(void)
{
	puts("\nFilter to remove or insert trigraphs in C source files,");
	puts("and to handle backslash splicing outside of macros.");
	puts("\nWorks directly on source files, creating a backup file");
	puts("with the extension .BAK, unless -n or -x switch is used.");
	puts("\nUSAGE: trigraph [options] <file spec> [<file spec> ...]\n");
	puts("options:");
	puts("\t-nXXX   write output files to directory 'XXX'");
	puts("\t-u      UNDO    insert trigraphs");
	puts("\t-xXXX   create output files with extension 'XXX'");
	exit(1);
}

void inserttri(void);
void removetri(void);

/* trigraph [-nDIR] [-u] [-xEXT] FILE...  (BCC's WILDARGS.OBJ expands wildcards in FILE) */
int main(register int argc, register char **argv)
{
	puts(banner);
	for (; argv[1][0] == '-' || argv[1][0] == '/'; argc--, argv++)
		switch (argv[1][1]) {
		case 'N':
		case 'n':
			outdir = argv[1] + 2;
			break;
		case 'U':
		case 'u':
			undo = 1;
			break;
		case 'X':
		case 'x':
			outext = argv[1] + 2;
			break;
		default:
			usage();
		}
	/* match: these two odd spellings are the ones that give the original's jumps */
	argc < 2 ? usage() : (void)0;
	while ((argv++, argc--) > 1) {
		puts(*argv);
		if (openfiles(*argv, outdir, outext)) {
			if (!undo)
				removetri();
			else
				inserttri();
			closefiles();
			finish(*argv, outdir, outext);
		}
	}
	return 0;
}

/* -u: writes a trigraph for each of the nine characters that have one */
void inserttri(void)
{
	char c;

	initbuf();
	done = 0;
	while (!done) {
		c = *inp++;
		switch (c) {
		case '#':
			put('?'); put('?'); put('=');
			break;
		case '[':
			put('?'); put('?'); put('(');
			break;
		case '\\':
			put('?'); put('?'); put('/');
			break;
		case ']':
			put('?'); put('?'); put(')');
			break;
		case '^':
			put('?'); put('?'); put('\'');
			break;
		case '{':
			put('?'); put('?'); put('<');
			break;
		case '|':
			put('?'); put('?'); put('!');
			break;
		case '}':
			put('?'); put('?'); put('>');
			break;
		case '~':
			put('?'); put('?'); put('-');
			break;
		case EOF:
			fill();
			break;
		default:
			put(c);
		}
	}
	if (!err)
		flush();
}

/* after "??": writes the character a trigraph stands for. "??/" puts a backslash back into
 * the input, so that a backslash written as a trigraph can still splice lines. */
void question(void)
{
	char c;

	while (!done) {
		c = *inp++;
		switch (c) {
		case '?':
			put('?');
			break;
		case '=':
			put('#');
			return;
		case '(':
			put('[');
			return;
		case '/':
			unget('\\');
			return;
		case ')':
			put(']');
			return;
		case '\'':
			put('^');
			return;
		case '<':
			put('{');
			return;
		case '!':
			put('|');
			return;
		case '>':
			put('}');
			return;
		case '-':
			put('~');
			return;
		case EOF:
			fill();
			break;
		default:
			put('?'); put('?'); put(c);
			return;
		}
	}
}

/* after one '?': looks for the second */
void trigraph(void)
{
	char c;

	while (!done) {
		c = *inp++;
		switch (c) {
		case '?':
			question();
			return;
		case EOF:
			fill();
			break;
		default:
			put('?');
			unget(c);
			return;
		}
	}
}

/* after a backslash and a line end: drops the line ends that follow */
void splice(void)
{
	char c;

	while (!done) {
		c = *inp++;
		switch (c) {
		case EOF:
			fill();
			break;
		case '\n':
		case '\r':
			break;
		default:
			unget(c);
			return;
		}
	}
}

/* after a backslash: a line end makes a splice; anything else is written as it was */
void backslash(void)
{
	char c;

	while (!done) {
		c = *inp++;
		switch (c) {
		case '\n':
		case '\r':
			splice();
			return;
		case EOF:
			fill();
			break;
		default:
			put('\\');
			unget(c);
			return;
		}
	}
}

/* the default: replaces trigraphs and joins spliced lines */
void removetri(void)
{
	char c;

	initbuf();
	done = 0;
	while (!done) {
		c = *inp++;
		switch (c) {
		case '\\':
			backslash();
			break;
		case '?':
			trigraph();
			break;
		case EOF:
			fill();
			break;
		default:
			put(c);
		}
	}
	if (!err)
		flush();
}
