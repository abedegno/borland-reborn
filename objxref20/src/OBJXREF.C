/* target: OBJXREF */
/* opts: -mc -G -O -Z -d */
/* OBJXREF.C: OBJXREF 3.0 of Borland C++ 2.0, the cross-reference of object modules and
 * libraries. It reads every module named on the command line, in response files (@file,
 * /L linker response files) or in Turbo C project files (/P), into tables of symbols,
 * modules, segments and classes; links them as the linker would, from the modules given
 * outright and whatever they need from the libraries (resolve()); drops the rest (purge());
 * sorts what the reports need and writes the reports (/RP /RM /RX /RR /RS /RC /RU) to the
 * screen, stdout or the /O file.
 *
 * One file: its data shows it. Turbo C 2.01 word-aligns each object's _DATA, and the string
 * literals of pubdef(), theadr(), resolve(), option() and main() follow the messages and
 * the initialised variables at odd offsets, in one pool. The demangler (DEMANGLE.C, TLIB's)
 * and the project-file reader (PRJ.C) were separate objects, linked after it.
 *
 * Memory: everything is allocated from one far block taken at the start (getmem()) and
 * never freed, except the last allocation, which release() can give back; that is how a
 * name read twice is kept once. lowwater remembers the least memory left, for the closing
 * "Available memory" line.
 *
 * OBJXREF.COM keeps no symbols, so every name is descriptive. Turbo C 2.01 lays out the
 * uninitialised variables in ascending order of a hash of the name, (first char + 4 * last
 * char + 32 * length) & 1023, ties in order of first sight, so the names of those were
 * chosen to fall in the original's order and are declared in that order; renaming one
 * moves it. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <io.h>
#include <dos.h>
#include <dir.h>
#include <mem.h>
#include <alloc.h>
#include <conio.h>
#include <fcntl.h>
#include <errno.h>

/* flags: the report and option switches (option(), setinput()) */
#define R_PUBS		0x0001		/* /RP public definitions by symbol */
#define R_MODREFS	0x0002		/* /RX external references by module */
#define R_MODDEFS	0x0004		/* /RM public definitions by module */
#define R_SYMREFS	0x0008		/* /RR definitions and references by symbol (the default) */
#define R_UNREF		0x0010		/* /RU unreferenced publics */
#define O_IGNCASE	0x0020		/* /I */
#define O_PRJ		0x0040		/* /P: the next file set is a Turbo C project file */
#define O_RSP		0x0080		/* /L: ... a linker response file */
#define O_FULLLIB	0x0100		/* /F: every library module counts, linked or not */
#define R_SEGS		0x0200		/* /RS module sizes by segment */
#define O_VERBOSE	0x0400		/* /V */
#define R_CLASSES	0x0800		/* /RC module sizes by class */
#define O_ZERO		0x1000		/* /Z: list pieces of length 0 */
#define O_NAME		0x2000		/* /N: report only the name in nameopt */
#define O_CPUTS		0x8000		/* console messages through cputs(); nothing sets it */
#define R_ALL		0x0A1F		/* /RV */

/* OMF record types */
#define THEADR		0x80
#define MODEND		0x8A
#define EXTDEF		0x8C
#define PUBDEF		0x90
#define LNAMES		0x96
#define SEGDEF		0x98
#define LEDATA		0xA0
#define LIDATA		0xA2
#define LIBHDR		0xF0
#define LIBEND		0xF1

/* a SEGDEF's attribute byte */
#define SEG_ALIGN	0xE0		/* alignment; 0 is an absolute segment */
#define SEG_COMBINE	0x1C		/* combination: */
#define SEG_PRIVATE	0x00
#define SEG_PUBLIC	0x08
#define SEG_STACK	0x14
#define SEG_COMMON	0x18
#define SEG_BIG		0x02		/* exactly 64K long */

/* A buffered reader over a DOS handle (ropen(), rread(), rskip()): objrdr reads the object
 * files and libraries, prjrdr the response and project files. */
struct rbuf {
	char near *buf;
	int eof;
	unsigned pos;			/* the next byte in buf */
	unsigned len;			/* bytes in buf */
	unsigned size;
	int fd;
};

/* A public or external symbol, in symhashtab and, from listsyms(), on syms. */
struct sym {
	struct sym *next;
	struct ref *refs;		/* the modules that refer to it */
	struct def *def;		/* the module that defines it, or NULL */
	char *name;
	int nrefs;
};

/* A module: an object file, a library module, or one of the dummy modules -common- (the
 * definer of communal variables) and -undefined- (of unresolved externals). */
struct mod {
	struct mod *next;
	struct def *defs;		/* its public symbols */
	struct ref *refs;		/* its external references */
	char *name;			/* "name" or "name (library)" */
	int linked;			/* part of the link: given outright, or needed by one that is */
	int visited;			/* resolve() has been through it */
	int ndefs;
	int nrefs;
};

/* A definition: on its module's defs list, and its symbol's def. */
struct def {
	struct def *next;
	struct mod *mod;
	struct sym *sym;
};

/* A reference: on its module's refs list and on its symbol's refs list. */
struct ref {
	struct ref *modnext;
	struct ref *symnext;
	struct mod *mod;
	struct sym *sym;
};

/* A segment: public segments of the same name and combination are one segment, made of
 * the pieces the modules contribute. */
struct seg {
	struct seg *next;
	struct piece *pieces;
	char *name;
	int npieces;
	unsigned char attr;		/* the SEGDEF attribute byte: SEG_... */
};

/* A class, with the pieces of every segment of that class. */
struct cls {
	struct cls *next;
	struct piece *pieces;
	char *name;
	int npieces;
};

/* One module's part of a segment. */
struct piece {
	struct piece *segnext;
	struct piece *clsnext;
	struct seg *seg;
	struct mod *mod;
	long size;
	char hasdata;			/* the module has LEDATA or LIDATA for it */
};

/* A name from an LNAMES record; the same name is kept once (lnamelist). */
struct lname {
	struct lname *next;
	char *name;
};

/* A file of a Turbo C project (PRJ.C's readprj()). */
struct prjent {
	int flags;
	char *name;
	char pad[12];
	struct prjent *next;
};

/* The uninitialised variables, in the order of their addresses (see the top). */
struct sym *syms;			/* every symbol, sorted by name for the reports */
struct seg *segs;			/* every segment, sorted */
char msgbuf[256];			/* a message or report line, formatted */
FILE *outfp;				/* the /O file */
char search[128];			/* the /D directories, separated by ; */
char *names[200];			/* this module's LNAMES, by index */
char outname[80];			/* the /O name */
char huge *memptr;			/* the next free byte of the far block */
int numcls;				/* classes */
int modcnt;				/* modules */
unsigned long memspace;			/* bytes left in the far block */
int symcnt;				/* symbols */
int binary;				/* the /P project file is a binary Turbo C project */
int numsegs;				/* segments */
char nameopt[128];			/* the /N name */
char objectbuf[0x2000];			/* objrdr's buffer */
char prjtxtbuf[0x400];			/* prjrdr's buffer */
struct cls **clshashtab;		/* the classes, by hash(), 50 chains */
unsigned long lowwater;			/* the least memspace has been */
struct mod **modhashtab;		/* 200 chains */
struct sym **symhashtab;		/* 2000 chains */
struct seg **seghashtab;		/* 500 chains */
unsigned lnamecnt;			/* names[] used */
int stdoutcon;				/* stdout is the console */
struct seg *segindex[200];		/* this module's segments, by index */
struct cls *classlist;			/* every class, sorted */
struct lname *lnamelist;		/* every name from LNAMES, each once */
struct mod *allmodules;			/* every module, sorted */
unsigned nsegindex;			/* segindex[] used */

/* The initialised data, in the order of its addresses: first the stack size and the ID
 * block, then the messages, then flags and the readers. */
unsigned _stklen = 0x800;		/* the stack size, read by the startup code */
char idblock[] = "$*$*$*\1\0\1\2OBJXREF";	/* never read by OBJXREF itself */
char banner[] = "\r\nOBJXREF  Version 3.0  Copyright (c) 1991 Borland Intl\r\n";
char syntax[] =
	"Syntax:  objxref [options] fileset [fileset ...]\r\n"
	"\r\n"
	"Report format options:\r\n"
	"   /RR* public refs and defs      /RP  public definitions\r\n"
	"   /RM  publics by module         /RX  externals by module\r\n"
	"   /RS  module sizes by segment   /RC  module sizes by class\r\n"
	"   /RU  unreferenced publics      /RV  verbose - all report formats\r\n"
	"   (* = default)\r\n"
	"\r\n"
	"Control options:\r\n"
	"   /I   ignore case               /F   include full libraries\r\n"
	"   /V   verbose output            /Z   show zero length segments\r\n"
	"   /Nn  selective report by name  /On  output file\r\n"
	"\r\n"
	"Response file options:\r\n"
	"   @n   input from free format ASCII file (filename.ext)\r\n"
	"   /Ln  input from a linker response file (filename.ext)\r\n"
	"   /Pn  input from a TC project file (filename[.PRJ])\r\n"
	"   /Dn  search directories (separate with ';') \r\n"
	"\r\n"
	"fileset (file names and extensions may contain wild cards):\r\n"
	"   List of OBJs and Libs (default extentions is .OBJ)\r\n";
char readmsg[] = "Reading modules...\r\n";
char linkmsg[] = "Linking modules...\r\n";
char sortmsg[] = "Sorting reports...\r\n";
char writemsg[] = "Writing reports...\r\n";
char loadmsg[] = "Loading %s\r\n";
char countmsg[] = "\r\nSymbols  = %d\r\nModules  = %d\r\n";
char segcountmsg[] = "Segments = %d\r\nClasses  = %d\r\n";
char memmsg[] = "\r\nAvailable memory = %ld\r\n";
char objext[] = ".OBJ";
char libext[] = ".LIB";
char prjext[] = ".PRJ";
char cext[] = ".C";
char dupmsg[] = "WARNING: symbol %s defined in %s duplicated in %s\r\n";
char nomatchmsg[] = "WARNING: No files matching %s\r\n";
char badspecmsg[] = "WARNING: Invalid file specification %s\r\n";
char notfoundmsg[] = "WARNING: File not found %s\r\n";
char openinmsg[] = "WARNING: Unable to open input file %s\r\n";
char openoutmsg[] = "WARNING: Unable to open output file %s\r\n";
char unresmsg[] = "WARNING: Unresolved symbol %s in module %s\r\n";
char badoptmsg[] = "WARNING: Unknown option - %s\r\n";
char lnamesmsg[] = "Modules defines more than %d lnames\r\n";
char segsmsg[] = "Modules defines more than %d segments\r\n";
char nomemmsg[] = "Out of memory\r\n";
char crlf2b[] = "\r\n\r\n";
char crlf2[] = "\r\n\r\n";
char crlf[] = "\r\n";
char pubhdr[] = "PUBLIC SYMBOL DEFINITIONS BY SYMBOL NAME\r\n\r\n";
char pubhdr2[] = "SYMBOL                                  DEFINED IN\r\n\r\n";
char pubfmt[] = "%-32s        %s\r\n";
char moddefhdr[] = "PUBLIC SYMBOL DEFINITIONS BY MODULE NAME\r\n\r\n";
char moddeffmt[] = "MODULE: %s defines the following symbols\r\n";
char moddefsym[] = "        %s\r\n";
char modrefhdr[] = "EXTERNAL SYMBOL REFERENCES BY MODULE NAME\r\n\r\n";
char modreffmt[] = "MODULE: %s references the following symbols\r\n";
char modrefsym[] = "        %s\r\n";
char symrefhdr[] = "PUBLIC SYMBOL DEFINITION AND REFERENCES BY SYMBOL NAME\r\n\r\n";
char symreffmt[] = "%s (%s)\r\n";
char symrefmod[] = "        %s\r\n";
char seghdr[] = "MODULE SIZES BY SEGMENT\r\n\r\n";
char segfmt[] = "        %6lu (%05lXh)    %s";
char clshdr[] = "MODULE SIZES BY CLASS\r\n\r\n";
char noclass[] = "No class name";
char clsfmt[] = "        %6lu (%05lXh)    %s, %s";
char absstr[] = ", ABSOULTE";
char commonstr[] = ", COMMON";
char publicstr[] = ", PUBLIC";
char privatestr[] = ", PRIVATE";
char stackstr[] = ", STACK";
char uninitstr[] = ", uninitialized";
char fmts[] = "%s";
char totalfmt[] = "        %6lu (%05lXh)    total\r\n\r\n";
char unrefhdr[] = "UNREFERENCED PUBLIC SYMBOLS BY MODULE NAME\r\n\r\n";
char unreffmt[] = "MODULE: %s defines the following unreferenced symbols\r\n";
char unrefsym[] = "        %s\r\n";

unsigned flags = 0;			/* R_... and O_... */
int rspstate = 1;			/* rsptoken(): the field of the linker response file */
/* the readers: their buffers are set here, the rest by ropen() */
struct rbuf objrdr = { (char near *)objectbuf };
struct rbuf prjrdr = { (char near *)prjtxtbuf };

int unmangle(char *src, char *dest, unsigned maxlen, char *qualP, char *baseP, int doArgs);
int isprj(FILE *fp);
struct prjent *readprj(FILE *fp);
char *dname(char *name);
int isdev(int fd);
void chkbrk(void);
void conout(char *s);
void output(char *s);
void putmsg(void);
void readblk(struct rbuf near *rb);
void ropen(struct rbuf near *rb, char *name, int mode, unsigned size);
void rclose(struct rbuf near *rb);
unsigned rread(struct rbuf near *rb, char *dst, unsigned n);
void rskip(struct rbuf near *rb, unsigned n);
char *getmem(unsigned n);
void release(unsigned n);
unsigned getindex(unsigned *len);
int namecmp(char *a, char *b);
unsigned hash(char *s, unsigned size);
struct sym *findsym(char *name);
struct mod *findmod(char *name);
struct seg *findseg(char *name, unsigned char attr);
struct cls *findcls(char *name);
struct piece *segpiece(char i);
struct lname *findlname(char *name);
struct sym *newsym(char *name);
struct def *adddef(struct mod *m, struct sym *s);
struct mod *newmod(char *name);
struct seg *newseg(char *name, unsigned char attr);
struct cls *newcls(char *name);
struct piece *newpiece(long size);
void addref(struct mod *m, struct sym *s);
struct lname *addlname(char *name);
struct mod *getmod(char *name);
struct cls *getcls(char *name);
void addpiece(struct piece *p, struct seg *s, struct cls *c, struct mod *m);
void skip(unsigned n);
void pubdef(unsigned len, struct mod *m);
void extdef(unsigned len, struct mod *m);
char *basename(char *path);
struct mod *theadr(char *fname, char *lib);
void clearlnames(void);
void getlnames(unsigned len);
void segdef(unsigned len, struct mod *m);
void ledata(unsigned len);
void load(char *fname);
char *upcase(char *s);
void fileset(char *spec);
void resolve(struct mod *m);
void resolveall(void);
int rsptoken(struct rbuf near *rb, char *tok);
int prjtoken(struct rbuf near *rb, char *tok);
int token(struct rbuf near *rb, char *tok);
void option(char *opt);
void setinput(char *opt);
void inittabs(void);
void purge(void);
int cmpsym(struct sym *a, struct sym *b);
void sortsyms(void);
int cmpmod(struct mod *a, struct mod *b);
void sortmods(void);
int cmpseg(struct seg *a, struct seg *b);
void sortsegs(void);
int cmpcls(struct cls *a, struct cls *b);
void sortcls(void);
void sortall(void);
int cmpdef(struct def *a, struct def *b);
void sortdefs(struct mod *o);
int cmpref(struct ref *a, struct ref *b);
void sortrefs(struct mod *o);
int cmpsref(struct ref *a, struct ref *b);
void sortsrefs(struct sym *o);
int cmppmod(struct piece *a, struct piece *b);
int cmppseg(struct piece *a, struct piece *b);
void sortspieces(struct seg *o);
void sortcpieces(struct cls *o);
void listsyms(void);
void listmods(void);
void listsegs(void);
void listcls(void);
int wanted(char *name);
void rptpubs(void);
void rptmoddefs(void);
void rptmodrefs(void);
void rptsymrefs(void);
void rptsegs(void);
void rptclasses(void);
void rptunref(void);
void reports(void);
void defext(char *name, char *ext);

/* a symbol's name for the reports: demangled when it is a C++ name.
 * match: the buffer is 129 bytes and 128 is passed as its length */
char *dname(char *name)
{
	static char buf[129];

	unmangle(name, buf, 128, NULL, NULL, 1);
	return buf;
}

/* fd is the console (DOS IOCTL 4400h: a device that is stdin or stdout).
 * match: the register variables are unused; they make Turbo C save SI and DI */
int isdev(int fd)
{
	register int a, b;		/* match: unused */

	_BX = fd;
	_AX = 0x4400;
	geninterrupt(0x21);
	return (_DL & 0x82) == 0x82;
}

/* a DOS call that lets Ctrl-Break stop OBJXREF (function 0Bh) */
void chkbrk(void)
{
	_AH = 0x0B;
	geninterrupt(0x21);
}

/* a message for the screen */
void conout(char *s)
{
	if (flags & O_CPUTS)
		cputs(s);
	else
		fputs(s, stderr);
}

/* a line of the reports: to the /O file, else to the screen or stdout */
void output(char *s)
{
	chkbrk();
	if (outfp)
		fputs(s, outfp);
	else if (stdoutcon)
		conout(s);
	else
		fputs(s, stdout);
}

/* msgbuf to the screen, and to the reports unless they are on the screen too */
void putmsg(void)
{
	chkbrk();
	conout(msgbuf);
	if (outfp)
		fputs(msgbuf, outfp);
	else if (!stdoutcon)
		fputs(msgbuf, stdout);
}

/* refills rb */
void readblk(register struct rbuf near *rb)
{
	rb->pos = 0;
	rb->eof = (rb->len = _read(rb->fd, rb->buf, rb->size)) == 0;
}

/* opens name for rb; a file that does not open reads as empty, with a warning */
void ropen(register struct rbuf near *rb, char *name, int mode, unsigned size)
{
	rb->eof = rb->pos = rb->len = 0;
	rb->size = size;
	if ((rb->fd = _open(name, mode)) <= 0) {
		sprintf(msgbuf, openinmsg, name);
		putmsg();
		rb->eof = 1;
	}
}

void rclose(struct rbuf near *rb)
{
	_close(rb->fd);
}

/* reads up to n bytes; the number read */
unsigned rread(register struct rbuf near *rb, char *dst, unsigned n)
{
	unsigned got;
	register unsigned k;

	got = 0;
	while (n) {
		if (rb->len - rb->pos == 0) {
			if (rb->eof)
				break;
			readblk(rb);
		}
		k = rb->len - rb->pos >= n ? n : rb->len - rb->pos;
		movmem(rb->buf + rb->pos, dst + got, k);
		got += k;
		rb->pos += k;
		n -= k;
	}
	return got;
}

/* skips n bytes */
void rskip(register struct rbuf near *rb, register unsigned n)
{
	unsigned k;

	while (n) {
		if (rb->len - rb->pos == 0) {
			if (rb->eof)
				break;
			readblk(rb);
		}
		k = rb->len - rb->pos >= n ? n : rb->len - rb->pos;
		rb->pos += k;
		n -= k;
	}
}

/* n bytes of the far block; out of memory ends OBJXREF */
char *getmem(register unsigned n)
{
	char *p;

	if (n > memspace) {
		sprintf(msgbuf, nomemmsg);
		putmsg();
		exit(2);
	}
	memspace -= n;
	if (memspace < lowwater)
		lowwater = memspace;
	p = (char *)memptr;
	memptr += n;
	return p;
}

/* gives back the last n bytes taken */
void release(unsigned n)
{
	memspace += n;
	memptr -= n;
}

/* an OMF index (one byte, or two when the first has bit 7), counting len down */
unsigned getindex(unsigned *len)
{
	unsigned v;

	v = 0;
	rread(&objrdr, (char *)&v, 1);
	(*len)--;
	if (v & 0x80) {
		v = (v & 0x7F) << 8;
		rread(&objrdr, (char *)&v, 1);
		(*len)--;
	}
	return v;
}

/* compares names, ignoring case with /I */
int namecmp(char *a, char *b)
{
	if (flags & O_IGNCASE)
		return stricmp(a, b);
	else
		return strcmp(a, b);
}

/* the hash of a name, for a table of size chains */
unsigned hash(char *s, unsigned size)
{
	register int c;
	register unsigned h;

	h = 0;
	while (*s) {
		c = *s++;
		if (flags & O_IGNCASE)
			c = toupper(c);
		h = h << 3 ^ c;
	}
	return h % size;
}

struct sym *findsym(char *name)
{
	struct sym *p;

	for (p = symhashtab[hash(name, 2000)]; p; p = p->next)
		if (namecmp(name, p->name) == 0)
			break;
	return p;
}

struct mod *findmod(char *name)
{
	struct mod *p;

	for (p = modhashtab[hash(name, 200)]; p; p = p->next)
		if (namecmp(name, p->name) == 0)
			break;
	return p;
}

/* the segment name with attr's combination; a private segment is never shared */
struct seg *findseg(char *name, unsigned char attr)
{
	struct seg *p;

	if (!(attr & SEG_COMBINE))
		return NULL;
	for (p = seghashtab[hash(name, 500)]; p; p = p->next)
		if (namecmp(name, p->name) == 0 && (p->attr & SEG_COMBINE) == (attr & SEG_COMBINE))
			break;
	return p;
}

struct cls *findcls(char *name)
{
	struct cls *p;

	for (p = clshashtab[hash(name, 50)]; p; p = p->next)
		if (namecmp(name, p->name) == 0)
			break;
	return p;
}

/* the piece of segment index i that this module added last.
 * Sic: i is a char, so an index above 127 reads before segindex[] */
struct piece *segpiece(char i)
{
	return segindex[i - 1]->pieces;
}

struct lname *findlname(char *name)
{
	struct lname *p;

	for (p = lnamelist; p; p = p->next)
		if (namecmp(name, p->name) == 0)
			break;
	return p;
}

struct sym *newsym(char *name)
{
	struct sym *s;
	register unsigned h;

	s = (struct sym *)getmem(sizeof(struct sym));
	s->name = name;
	s->def = NULL;
	s->refs = NULL;
	s->nrefs = 0;
	h = hash(name, 2000);
	s->next = symhashtab[h];
	symhashtab[h] = s;
	symcnt++;
	return s;
}

/* records that m defines s.
 * match: no return statement; resolve() takes the value it leaves in DX:AX, the new
 * definition */
struct def *adddef(struct mod *m, struct sym *s)
{
	struct def *d;

	d = (struct def *)getmem(sizeof(struct def));
	d->next = m->defs;
	d->mod = m;
	d->sym = s;
	s->def = m->defs = d;
	m->ndefs++;
}

struct mod *newmod(char *name)
{
	struct mod *m;
	register unsigned h;

	m = (struct mod *)getmem(sizeof(struct mod));
	m->defs = NULL;
	m->refs = NULL;
	m->name = name;
	m->visited = m->linked = m->ndefs = m->nrefs = 0;
	h = hash(name, 200);
	m->next = modhashtab[h];
	modhashtab[h] = m;
	modcnt++;
	return m;
}

struct seg *newseg(char *name, unsigned char attr)
{
	struct seg *s;
	register unsigned h;

	s = (struct seg *)getmem(sizeof(struct seg));
	s->next = NULL;
	s->pieces = NULL;
	s->name = getmem(strlen(name) + 1);
	strcpy(s->name, name);
	s->npieces = 0;
	s->attr = attr;
	h = hash(name, 500);
	s->next = seghashtab[h];
	seghashtab[h] = s;
	numsegs++;
	return s;
}

struct cls *newcls(char *name)
{
	struct cls *c;
	register unsigned h;

	c = (struct cls *)getmem(sizeof(struct cls));
	c->next = NULL;
	c->pieces = NULL;
	c->name = getmem(strlen(name) + 1);
	strcpy(c->name, name);
	c->npieces = 0;
	h = hash(name, 50);
	c->next = clshashtab[h];
	clshashtab[h] = c;
	numcls++;
	return c;
}

struct piece *newpiece(long size)
{
	struct piece *p;

	p = (struct piece *)getmem(sizeof(struct piece));
	p->segnext = NULL;
	p->clsnext = NULL;
	p->seg = NULL;
	p->mod = NULL;
	p->size = size;
	p->hasdata = 0;
	return p;
}

/* records that m refers to s */
void addref(struct mod *m, struct sym *s)
{
	struct ref *r;

	r = (struct ref *)getmem(sizeof(struct ref));
	r->sym = s;
	r->mod = m;
	r->modnext = m->refs;
	m->refs = r;
	m->nrefs++;
	r->symnext = s->refs;
	s->refs = r;
	s->nrefs++;
}

struct lname *addlname(char *name)
{
	struct lname *n;

	n = (struct lname *)getmem(sizeof(struct lname));
	n->next = lnamelist;
	n->name = name;
	lnamelist = n;
	return n;
}

/* the dummy module name, made on first use */
struct mod *getmod(char *name)
{
	struct mod *m;

	if ((m = findmod(name)) == NULL) {
		m = newmod(name);
		m->linked = 1;
	}
	return m;
}

struct cls *getcls(char *name)
{
	struct cls *c;

	if ((c = findcls(name)) == NULL)
		c = newcls(name);
	return c;
}

/* puts m's piece p on segment s and class c */
void addpiece(struct piece *p, struct seg *s, struct cls *c, struct mod *m)
{
	p->segnext = s->pieces;
	s->pieces = p;
	s->npieces++;
	p->clsnext = c->pieces;
	c->pieces = p;
	c->npieces++;
	p->seg = s;
	p->mod = m;
}

/* skips the rest of a record */
void skip(unsigned n)
{
	rskip(&objrdr, n);
}

/* a PUBDEF record: m defines each name; a name in a COMMON segment is a communal variable,
 * defined by -common- and referred to by m */
void pubdef(unsigned len, struct mod *m)
{
	char *name;
	struct sym *s;
	struct mod *cm;
	unsigned char n;
	register int seg;
	register int grp;

	grp = getindex(&len);
	seg = getindex(&len);
	if (grp == 0 && seg == 0) {
		skip(2);
		len -= 2;
	}
	while (len > 1) {
		rread(&objrdr, &n, 1);
		len--;
		name = getmem(n + 1);
		rread(&objrdr, name, n);
		len -= n;
		name[n] = 0;
		if ((segindex[seg - 1]->attr & SEG_COMBINE) == SEG_COMMON) {
			if ((s = findsym(name)) == NULL)
				s = newsym(name);
			if (s->def == NULL) {
				cm = getmod("-common-");
				adddef(cm, s);
			}
			addref(m, s);
		} else {
			if ((s = findsym(name)) == NULL) {
				s = newsym(name);
				adddef(m, s);
			} else {
				release(n + 1);
				if (s->def) {
					sprintf(msgbuf, dupmsg, dname(s->name), s->def->mod->name, m->name);
					putmsg();
				} else
					adddef(m, s);
			}
		}
		skip(2);
		len -= 2;
		getindex(&len);
	}
	skip(len);
}

/* an EXTDEF record: m refers to each name */
void extdef(unsigned len, struct mod *m)
{
	char *name;
	struct sym *s;
	unsigned char n;

	while (len > 1) {
		rread(&objrdr, &n, 1);
		len--;
		name = getmem(n + 1);
		rread(&objrdr, name, n);
		len -= n;
		name[n] = 0;
		if ((s = findsym(name)) == NULL)
			s = newsym(name);
		else
			release(n + 1);
		addref(m, s);
		getindex(&len);
	}
	skip(len);
}

/* the name part of path, in capitals, without its extension (in place) */
char *basename(char *path)
{
	char *p;

	p = &path[strlen(path) - 1];
	for (;;) {
		if (*p == '.')
			*p = 0;
		else if (*p == '\\' || *p == '/' || *p == ':') {
			p++;
			break;
		} else
			*p = toupper(*p);
		if (p == path)
			break;
		p--;
	}
	return p;
}

/* a THEADR record: a new module, "name" or "name (library)". A module named A, as some
 * assemblers write, takes the name of its file */
struct mod *theadr(char *fname, char *lib)
{
	char *p;
	char buf[128];
	struct mod *m;
	unsigned char n;

	rread(&objrdr, &n, 1);
	rread(&objrdr, buf, n + 1);
	buf[n] = 0;
	if (*lib == 0 && *(int *)buf == 'A') {
		for (p = &fname[strlen(fname) - 1]; p >= fname && *p != '\\' && *p != '/' && *p != ':'; p--)
			;
		strcpy(buf, p);
	}
	strcpy(buf, basename(buf));
	if (*lib)
		p = strcat(strcat(strcat(strcpy(getmem(strlen(buf) + strlen(lib) + 4), buf), " ("), lib), ")");
	else
		p = strcpy(getmem(strlen(buf) + 1), buf);
	m = newmod(p);
	m->linked = *lib == 0 || flags & O_FULLLIB;
	nsegindex = 0;
	return m;
}

/* forgets the module's LNAMES (at MODEND) */
void clearlnames(void)
{
	register unsigned i;

	for (i = 0; i < lnamecnt; i++)
		names[i] = NULL;
	lnamecnt = 0;
}

/* an LNAMES record */
void getlnames(register unsigned len)
{
	char n;
	char *name;
	struct lname *l;

	while (len > 1) {
		if (lnamecnt == 200) {
			sprintf(msgbuf, lnamesmsg, 200);
			putmsg();
			exit(2);
		}
		rread(&objrdr, &n, 1);
		name = getmem(n + 1);
		rread(&objrdr, name, n);
		name[n] = 0;
		if ((l = findlname(name)) == NULL)
			l = addlname(name);
		else
			release(n + 1);
		names[lnamecnt++] = l->name;
		len -= n + 1;
	}
	skip(len);
}

/* a SEGDEF record: the module's piece of a segment */
void segdef(unsigned len, struct mod *m)
{
	char frame[3];
	long size;
	unsigned char attr;
	struct seg *s;
	struct cls *c;
	register unsigned ni;
	register unsigned ci;

	rread(&objrdr, &attr, 1);
	len--;
	if (!(attr & SEG_ALIGN)) {
		rread(&objrdr, frame, 3);
		len -= 3;
	}
	size = 0;
	rread(&objrdr, (char *)&size, 2);
	len -= 2;
	if (attr & SEG_BIG)
		size = 0x10000L;
	ni = getindex(&len) - 1;
	ci = getindex(&len) - 1;
	if ((s = findseg(names[ni], attr)) == NULL)
		s = newseg(names[ni], attr);
	if (nsegindex == 200) {
		sprintf(msgbuf, segsmsg, 200);
		putmsg();
		exit(2);
	}
	segindex[nsegindex++] = s;
	c = getcls(names[ci]);
	addpiece(newpiece(size), s, c, m);
	getindex(&len);
	skip(len);
}

/* an LEDATA or LIDATA record: the piece has data */
void ledata(unsigned len)
{
	char seg;

	seg = getindex(&len);
	segpiece(seg)->hasdata = 1;
	skip(len);
}

/* reads an object file or a library. A library's modules start on its page boundaries.
 * match: the remainder is computed in _CX, as the original does */
void load(char *fname)
{
	struct mod *m;
	char lib[128];
	struct {
		unsigned char type;
		unsigned len;
	} hdr;
	register unsigned pagesize;
	register int inmod;

	lib[0] = 0;
	inmod = 0;
	if (flags & O_VERBOSE) {
		sprintf(msgbuf, loadmsg, fname);
		putmsg();
	}
	ropen(&objrdr, fname, O_RDONLY | O_BINARY, 0x2000);
	while (rread(&objrdr, (char *)&hdr, 3)) {
		switch (hdr.type) {
		case LIBHDR:
			pagesize = hdr.len + 3;
			skip(hdr.len);
			strcpy(lib, basename(strcpy(lib, fname)));
			break;
		case THEADR:
			if (!inmod) {
				m = theadr(fname, lib);
				inmod = 1;
				break;
			}
			skip(hdr.len);
			break;
		case EXTDEF:
			extdef(hdr.len, m);
			break;
		case PUBDEF:
			pubdef(hdr.len, m);
			break;
		case LNAMES:
			getlnames(hdr.len);
			break;
		case SEGDEF:
			segdef(hdr.len, m);
			break;
		case LEDATA:
		case LIDATA:
			ledata(hdr.len);
			break;
		case MODEND:
			clearlnames();
			inmod = 0;
			if (lib[0] == 0)
				goto done;
			skip(hdr.len);
			_CX = objrdr.pos % pagesize;	/* match: see above */
			if (_CX)
				rskip(&objrdr, pagesize - _CX);
			break;
		case LIBEND:
			goto done;
		default:
			skip(hdr.len);
			break;
		}
	}
done:
	rclose(&objrdr);
}

/* s in capitals, in place */
char *upcase(char *s)
{
	char *p;

	p = s;
	while (*s) {
		*s = toupper(*s);
		s++;
	}
	return p;
}

/* loads every file spec names, with .OBJ when it has no extension, looking in each /D
 * directory when it has no drive or directory of its own.
 * match: some tests of fl's bits are spelled ~fl & BIT, as the code shows */
void fileset(char *spec)
{
	struct ffblk ff;
	char path[MAXPATH];
	char drive[MAXDRIVE];
	char dir[MAXDIR];
	char name[MAXFILE];
	char ext[MAXEXT];
	char *p;
	char *q;
	register int fl;
	register int found;

	p = search;
	found = 0;
	fl = fnsplit(upcase(spec), drive, dir, name, ext);
	if (~fl & EXTENSION)
		strcpy(ext, objext);
	do {
		if (!(fl & (DIRECTORY | DRIVE))) {
			if (p[1] == ':') {
				*(int *)drive = *(int *)p;
				p += 2;
				drive[2] = 0;
			}
			for (q = dir; *p && *p != ';'; )
				*q++ = *p++;
			*q = 0;
			if (*p == ';')
				p++;
		}
		fnmerge(path, drive, dir, name, ext);
		if (findfirst(path, &ff, 0)) {
			if (fl & WILDCARDS) {
				if (errno == ENOENT)
					sprintf(msgbuf, nomatchmsg, path);
				else
					sprintf(msgbuf, badspecmsg, path);
				putmsg();
			}
		} else {
			found++;
			do {
				fnmerge(path, drive, dir, ff.ff_name, NULL);
				load(path);
			} while (findnext(&ff) == 0);
		}
	} while (!(fl & (DIRECTORY | DRIVE)) && *p && (!found || !(~fl & WILDCARDS)));
	if (~fl & !found & WILDCARDS) {	/* no files matched a plain name */
		strcpy(path, spec);
		if (~fl & EXTENSION)
			strcat(path, objext);
		sprintf(msgbuf, notfoundmsg, path);
		putmsg();
	}
}

/* links m: every module that defines what m refers to is linked too; an external that
 * nothing defines gets a warning and the definer -undefined- */
void resolve(struct mod *m)
{
	struct ref *r;
	struct def *d;

	if (m->visited)
		return;
	m->visited = m->linked = 1;
	for (r = m->refs; r; r = r->modnext) {
		d = r->sym->def;
		if (d && strcmp(d->mod->name, "-undefined-"))
			resolve(d->mod);
		else {
			sprintf(msgbuf, unresmsg, dname(r->sym->name), r->mod->name);
			putmsg();
			d = adddef(getmod("-undefined-"), r->sym);	/* the value is never used */
		}
	}
}

/* links every module given outright */
void resolveall(void)
{
	struct mod *m;
	register int i;

	for (i = 0; i < 200; i++)
		for (m = modhashtab[i]; m; m = m->next)
			if (m->linked)
				resolve(m);
}

/* the next object or library name of a linker response file (objects, exe, map,
 * libraries; + continues a field on the next line); the exe and map fields are skipped */
int rsptoken(struct rbuf near *rb, char *tok)
{
	int c;
	register int st;

	c = 0;
	*tok = 0;
	if (rspstate != 5) {
		st = rspstate;
		while (rread(rb, (char *)&c, 1)) {
			rspstate = st;
			switch (c) {
			case ' ':
			case '\t':
				if (*tok == 0)
					continue;
				st = rspstate & 0x7FFF;
				goto done;
			case '\r':
				continue;
			case 0x1A:
			case ';':
				st = 5;
				goto done;
			case ',':
				st = (rspstate & 0x7FFF) + 1;
				if (*tok)
					goto done;
				continue;
			case '+':
				st = rspstate | 0x8000;
				if (*tok)
					goto done;
				continue;
			case '\n':
				if (rspstate & 0x8000)
					st = rspstate & 0x7FFF;
				else
					st = rspstate + 1;
				if (*tok)
					goto done;
				continue;
			case '/':
				rread(rb, (char *)&c, 1);
				continue;
			default:
				st = rspstate &= 0x7FFF;
				if (st != 2 && st != 3)
					strncat(tok, (char *)&c, 79);
				continue;
			}
		}
done:
		if ((rspstate & 0x7FFF) == 4 && !(fnsplit(tok, NULL, NULL, NULL, NULL) & EXTENSION))
			strncat(tok, libext, 79);
		rspstate = st;
	}
	return *tok;
}

/* the next file of a project file in text form; (...) holds dependencies, and a .C file
 * stands for its .OBJ.
 * match: paren is cleared and then copied into c */
int prjtoken(struct rbuf near *rb, char *tok)
{
	int c;
	char name[MAXFILE];
	char ext[MAXEXT];
	register int paren;

	paren = 0;
	c = paren;			/* match: see above */
	*tok = 0;
	while (rread(rb, (char *)&c, 1)) {
		switch (c) {
		case '(':
			paren = 1;
		case '\t':
		case '\n':
		case '\r':
		case ' ':
		case '+':
		case ',':
		case ';':
			if (*tok)
				goto done;
			break;
		case ')':
			paren = 0;
			break;
		case 0x1A:
			goto done;
		default:
			if (!paren)
				strncat(tok, (char *)&c, 79);
			break;
		}
	}
done:
	if (!(fnsplit(tok, NULL, NULL, name, ext) & EXTENSION) || stricmp(ext, cext) == 0)
		strcpy(tok, name);
	return *tok;
}

/* the next name of a free-form @file */
int token(register struct rbuf near *rb, char *tok)
{
	int c;

	c = 0;
	*tok = 0;
	while (rread(rb, (char *)&c, 1)) {
		switch (c) {
		case '\t':
		case '\n':
		case '\r':
		case ' ':
		case '+':
		case ',':
		case ';':
			if (*tok == 0)
				break;
			goto done;
		case 0x1A:
			goto done;
		default:
			strncat(tok, (char *)&c, 79);
			break;
		}
	}
done:
	return *tok;
}

/* a /option */
void option(char *opt)
{
	register unsigned f;
	register int len;

	f = 0;
	switch (toupper(*opt)) {
	case 'R':
		switch (toupper(opt[1])) {
		case 'P':
			f = R_PUBS;
			break;
		case 'M':
			f = R_MODDEFS;
			break;
		case 'X':
			f = R_MODREFS;
			break;
		case 'R':
			f = R_SYMREFS;
			break;
		case 'S':
			f = R_SEGS;
			break;
		case 'C':
			f = R_CLASSES;
			break;
		case 'U':
			f = R_UNREF;
			break;
		case 'V':
			f = R_ALL;
			break;
		default:
			goto bad;
		}
		break;
	case 'I':
		f = O_IGNCASE;
		break;
	case 'F':
		f = O_FULLLIB;
		break;
	case 'V':
		f = O_VERBOSE;
		break;
	case 'Z':
		f = O_ZERO;
		break;
	case 'N':
		f = O_NAME;
		strcpy(nameopt, opt + 1);
		break;
	case 'D':
		upcase(opt + 1);
		if ((len = strlen(search)) != 0 && search[len - 1] != ';')
			strcat(search, ";");
		strcat(search, opt + 1);
		break;
	case 'O':
		strcpy(outname, opt + 1);
		break;
	case 'L':
	case 'P':
		break;
	default:
bad:
		sprintf(msgbuf, badoptmsg, opt);
		putmsg();
	}
	flags |= f;
}

/* /P or /L: how the next file set is to be read */
void setinput(char *opt)
{
	register unsigned f;

	f = 0;
	switch (toupper(*opt)) {
	case 'P':
		f = O_PRJ;
		break;
	case 'L':
		f = O_RSP;
		break;
	}
	flags = flags & ~(O_PRJ | O_RSP) | f;
}

/* the hash tables, empty */
void inittabs(void)
{
	register int i;

	symhashtab = (struct sym **)getmem(2000 * sizeof(struct sym *));
	for (i = 0; i < 2000; i++)
		symhashtab[i] = NULL;
	modhashtab = (struct mod **)getmem(200 * sizeof(struct mod *));
	for (i = 0; i < 200; i++)
		modhashtab[i] = NULL;
	seghashtab = (struct seg **)getmem(500 * sizeof(struct seg *));
	for (i = 0; i < 500; i++)
		seghashtab[i] = NULL;
	clshashtab = (struct cls **)getmem(50 * sizeof(struct cls *));
	for (i = 0; i < 50; i++)
		clshashtab[i] = NULL;
}

/* drops the modules that are not part of the link, with their definitions and
 * references */
void purge(void)
{
	struct mod *m;
	struct mod *p;
	struct mod *prev;
	struct ref *q;
	struct ref *pr;
	struct ref *r;
	struct sym *s;
	struct sym *ps;
	struct def *d;
	register unsigned h;

	prev = NULL;
	for (p = allmodules; p; ) {
		m = p;
		p = p->next;
		if (m->linked == 0) {
			for (r = m->refs; r; r = r->modnext) {
				pr = NULL;
				for (q = (s = r->sym)->refs; q; q = (pr = q)->symnext)
					if (q == r)
						break;
				if (pr)
					pr->symnext = q->symnext;
				else
					s->refs = q->symnext;
				s->nrefs--;
			}
			for (d = m->defs; d; d = d->next) {
				h = hash(d->sym->name, 2000);
				s = symhashtab[h];
				ps = NULL;
				while (namecmp(d->sym->name, s->name)) {
					ps = s;
					s = s->next;
				}
				if (ps)
					ps->next = s->next;
				else
					symhashtab[h] = s->next;
				symcnt--;
			}
			if (prev)
				prev->next = p;
			else
				allmodules = p;
			modcnt--;
		} else
			prev = m;
	}
}

/* sorts a[lo..hi] */
void quicksort(void **a, int lo, int hi, int (*cmp)())
{
	void *pivot;
	void *t;
	register int i;
	register int j;

	i = lo;
	j = hi;
	pivot = a[(i + j) / 2];
	do {
		while ((*cmp)(a[i], pivot) < 0 && i < hi)
			i++;
		while ((*cmp)(pivot, a[j]) < 0 && j > lo)
			j--;
		if (i <= j) {
			t = a[i];
			a[i] = a[j];
			a[j] = t;
			i++;
			j--;
		}
	} while (i <= j);
	if (lo < j)
		quicksort(a, lo, j, cmp);
	if (i < hi)
		quicksort(a, i, hi, cmp);
}

int cmpsym(struct sym *a, struct sym *b)
{
	return stricmp(a->name, b->name);
}

void sortsyms(void)
{
	struct sym **a;
	struct sym *p;
	register int i;

	if (symcnt == 0)
		return;
	a = (struct sym **)getmem(symcnt * sizeof(struct sym *));
	for (p = syms, i = 0; i < symcnt; i++) {
		a[i] = p;
		p = p->next;
	}
	quicksort((void **)a, 0, symcnt - 1, cmpsym);
	syms = a[0];
	for (i = 0; i < symcnt - 1; i++)
		a[i]->next = a[i + 1];
	a[i]->next = NULL;
	release(symcnt * sizeof(struct sym *));
}

int cmpmod(struct mod *a, struct mod *b)
{
	return stricmp(a->name, b->name);
}

void sortmods(void)
{
	struct mod **a;
	struct mod *p;
	register int i;

	if (modcnt == 0)
		return;
	a = (struct mod **)getmem(modcnt * sizeof(struct mod *));
	for (p = allmodules, i = 0; i < modcnt; i++) {
		a[i] = p;
		p = p->next;
	}
	quicksort((void **)a, 0, modcnt - 1, cmpmod);
	allmodules = a[0];
	for (i = 0; i < modcnt - 1; i++)
		a[i]->next = a[i + 1];
	a[i]->next = NULL;
	release(modcnt * sizeof(struct mod *));
}

int cmpseg(struct seg *a, struct seg *b)
{
	return stricmp(a->name, b->name);
}

void sortsegs(void)
{
	struct seg **a;
	struct seg *p;
	register int i;

	if (numsegs == 0)
		return;
	a = (struct seg **)getmem(numsegs * sizeof(struct seg *));
	for (p = segs, i = 0; i < numsegs; i++) {
		a[i] = p;
		p = p->next;
	}
	quicksort((void **)a, 0, numsegs - 1, cmpseg);
	segs = a[0];
	for (i = 0; i < numsegs - 1; i++)
		a[i]->next = a[i + 1];
	a[i]->next = NULL;
	release(numsegs * sizeof(struct seg *));
}

int cmpcls(struct cls *a, struct cls *b)
{
	return stricmp(a->name, b->name);
}

void sortcls(void)
{
	struct cls **a;
	struct cls *p;
	register int i;

	if (numcls == 0)
		return;
	a = (struct cls **)getmem(numcls * sizeof(struct cls *));
	for (p = classlist, i = 0; i < numcls; i++) {
		a[i] = p;
		p = p->next;
	}
	quicksort((void **)a, 0, numcls - 1, cmpcls);
	classlist = a[0];
	for (i = 0; i < numcls - 1; i++)
		a[i]->next = a[i + 1];
	a[i]->next = NULL;
	release(numcls * sizeof(struct cls *));
}

/* sorts the lists the chosen reports need */
void sortall(void)
{
	if (flags & (R_PUBS | R_SYMREFS))
		sortsyms();
	if (flags & (R_MODREFS | R_MODDEFS | R_UNREF))
		sortmods();
	if (flags & R_SEGS)
		sortsegs();
	if (flags & R_CLASSES)
		sortcls();
}

int cmpdef(struct def *a, struct def *b)
{
	return stricmp(a->sym->name, b->sym->name);
}

void sortdefs(struct mod *o)
{
	struct def **a;
	struct def *p;
	register int i;
	register int n;

	if ((n = o->ndefs) == 0)
		return;
	a = (struct def **)getmem(n * sizeof(struct def *));
	for (p = o->defs, i = 0; i < n; i++) {
		a[i] = p;
		p = p->next;
	}
	quicksort((void **)a, 0, n - 1, cmpdef);
	o->defs = a[0];
	for (i = 0; i < n - 1; i++)
		a[i]->next = a[i + 1];
	a[i]->next = NULL;
	release(n * sizeof(struct def *));
}

int cmpref(struct ref *a, struct ref *b)
{
	return stricmp(a->sym->name, b->sym->name);
}

void sortrefs(struct mod *o)
{
	struct ref **a;
	struct ref *p;
	register int i;
	register int n;

	if ((n = o->nrefs) == 0)
		return;
	a = (struct ref **)getmem(n * sizeof(struct ref *));
	for (p = o->refs, i = 0; i < n; i++) {
		a[i] = p;
		p = p->modnext;
	}
	quicksort((void **)a, 0, n - 1, cmpref);
	o->refs = a[0];
	for (i = 0; i < n - 1; i++)
		a[i]->modnext = a[i + 1];
	a[i]->modnext = NULL;
	release(n * sizeof(struct ref *));
}

int cmpsref(struct ref *a, struct ref *b)
{
	return stricmp(a->mod->name, b->mod->name);
}

void sortsrefs(struct sym *o)
{
	struct ref **a;
	struct ref *p;
	register int i;
	register int n;

	if ((n = o->nrefs) == 0)
		return;
	a = (struct ref **)getmem(n * sizeof(struct ref *));
	for (p = o->refs, i = 0; i < n; i++) {
		a[i] = p;
		p = p->symnext;
	}
	quicksort((void **)a, 0, n - 1, cmpsref);
	o->refs = a[0];
	for (i = 0; i < n - 1; i++)
		a[i]->symnext = a[i + 1];
	a[i]->symnext = NULL;
	release(n * sizeof(struct ref *));
}

int cmppmod(struct piece *a, struct piece *b)
{
	return stricmp(a->mod->name, b->mod->name);
}

int cmppseg(struct piece *a, struct piece *b)
{
	register int r;

	r = stricmp(a->seg->name, b->seg->name);
	if (r == 0)
		r = stricmp(a->mod->name, b->mod->name);
	return r;
}

void sortspieces(struct seg *o)
{
	struct piece **a;
	struct piece *p;
	register int i;
	register int n;

	if ((n = o->npieces) == 0)
		return;
	a = (struct piece **)getmem(n * sizeof(struct piece *));
	for (p = o->pieces, i = 0; i < n; i++) {
		a[i] = p;
		p = p->segnext;
	}
	quicksort((void **)a, 0, n - 1, cmppmod);
	o->pieces = a[0];
	for (i = 0; i < n - 1; i++)
		a[i]->segnext = a[i + 1];
	a[i]->segnext = NULL;
	release(n * sizeof(struct piece *));
}

void sortcpieces(struct cls *o)
{
	struct piece **a;
	struct piece *p;
	register int i;
	register int n;

	if ((n = o->npieces) == 0)
		return;
	a = (struct piece **)getmem(n * sizeof(struct piece *));
	for (p = o->pieces, i = 0; i < n; i++) {
		a[i] = p;
		p = p->clsnext;
	}
	quicksort((void **)a, 0, n - 1, cmppseg);
	o->pieces = a[0];
	for (i = 0; i < n - 1; i++)
		a[i]->clsnext = a[i + 1];
	a[i]->clsnext = NULL;
	release(n * sizeof(struct piece *));
}

/* strings the hash chains into one list, for sorting */
void listsyms(void)
{
	struct sym *p;
	struct sym *next;
	register int i;

	syms = NULL;
	for (i = 0; i < 2000; i++)
		for (p = symhashtab[i]; p; p = next) {
			next = p->next;
			p->next = syms;
			syms = p;
		}
}

void listmods(void)
{
	struct mod *p;
	struct mod *next;
	register int i;

	allmodules = NULL;
	for (i = 0; i < 200; i++)
		for (p = modhashtab[i]; p; p = next) {
			next = p->next;
			p->next = allmodules;
			allmodules = p;
		}
}

void listsegs(void)
{
	struct seg *p;
	struct seg *next;
	register int i;

	segs = NULL;
	for (i = 0; i < 500; i++)
		for (p = seghashtab[i]; p; p = next) {
			next = p->next;
			p->next = segs;
			segs = p;
		}
}

void listcls(void)
{
	struct cls *p;
	struct cls *next;
	register int i;

	classlist = NULL;
	for (i = 0; i < 50; i++)
		for (p = clshashtab[i]; p; p = next) {
			next = p->next;
			p->next = classlist;
			classlist = p;
		}
}

/* with /N, only the name given */
int wanted(char *name)
{
	if (flags & O_NAME)
		return stricmp(name, nameopt) == 0;
	else
		return 1;
}

/* the reports: each ends with a form feed unless it is on the screen */
void rptpubs(void)
{
	struct sym *s;

	output(pubhdr);
	output(pubhdr2);
	for (s = syms; s; s = s->next)
		if (s->def && wanted(s->name)) {
			sprintf(msgbuf, pubfmt, dname(s->name), s->def->mod->name);
			output(msgbuf);
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

void rptmoddefs(void)
{
	struct mod *m;
	struct def *d;

	output(moddefhdr);
	for (m = allmodules; m; m = m->next)
		if (wanted(m->name)) {
			sprintf(msgbuf, moddeffmt, m->name);
			output(msgbuf);
			sortdefs(m);
			for (d = m->defs; d; d = d->next) {
				sprintf(msgbuf, moddefsym, dname(d->sym->name));
				output(msgbuf);
			}
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

void rptmodrefs(void)
{
	struct mod *m;
	struct ref *r;

	output(modrefhdr);
	for (m = allmodules; m; m = m->next)
		if (wanted(m->name)) {
			sprintf(msgbuf, modreffmt, m->name);
			output(msgbuf);
			sortrefs(m);
			for (r = m->refs; r; r = r->modnext) {
				sprintf(msgbuf, modrefsym, dname(r->sym->name));
				output(msgbuf);
			}
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

void rptsymrefs(void)
{
	struct sym *s;
	struct ref *r;

	output(symrefhdr);
	for (s = syms; s; s = s->next)
		if (s->nrefs && wanted(s->name)) {
			sprintf(msgbuf, symreffmt, dname(s->name), s->def->mod->name);
			output(msgbuf);
			sortsrefs(s);
			for (r = s->refs; r; r = r->symnext) {
				sprintf(msgbuf, symrefmod, r->mod->name);
				output(msgbuf);
			}
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

void rptsegs(void)
{
	struct seg *s;
	struct piece *p;
	unsigned long total;
	unsigned long size;

	output(seghdr);
	for (s = segs; s; s = s->next)
		if (wanted(s->name)) {
			sprintf(msgbuf, fmts, s->name);
			output(msgbuf);
			switch (s->attr & SEG_COMBINE) {
			case SEG_PUBLIC:
				output(publicstr);
				break;
			case SEG_PRIVATE:
				output(privatestr);
				break;
			case SEG_COMMON:
				output(commonstr);
				break;
			case SEG_STACK:
				output(stackstr);
				break;
			}
			if (!(s->attr & SEG_ALIGN))
				output(absstr);
			output(crlf);
			sortspieces(s);
			for (p = s->pieces, total = 0; p; p = p->segnext)
				if (p->mod->linked) {
					size = p->size;
					if (size || flags & O_ZERO) {
						sprintf(msgbuf, segfmt, size, size, p->mod->name);
						output(msgbuf);
						if (!p->hasdata)
							output(uninitstr);
						output(crlf);
					}
					if (s->attr & SEG_ALIGN)
						if ((s->attr & SEG_COMBINE) != SEG_COMMON)
							total += size;
						else if (size > total)
							total = size;
				}
			sprintf(msgbuf, totalfmt, total, total);
			output(msgbuf);
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

void rptclasses(void)
{
	struct cls *c;
	struct piece *p;
	struct seg *s;
	unsigned long total;
	unsigned long size;

	output(clshdr);
	for (c = classlist; c; c = c->next)
		if (wanted(c->name)) {
			if (*c->name) {
				sprintf(msgbuf, fmts, c->name);
				output(msgbuf);
			} else
				output(noclass);
			output(crlf);
			sortcpieces(c);
			for (p = c->pieces, total = 0; p; p = p->clsnext)
				if (p->mod->linked) {
					size = p->size;
					s = p->seg;
					if (size || flags & O_ZERO) {
						sprintf(msgbuf, clsfmt, size, size, p->seg->name, p->mod->name);
						output(msgbuf);
						if (!p->hasdata)
							output(uninitstr);
						output(crlf);
					}
					if (s->attr & SEG_ALIGN)
						if ((s->attr & SEG_COMBINE) != SEG_COMMON)
							total += size;
						else if (size > total)
							total = size;
				}
			sprintf(msgbuf, totalfmt, total, total);
			output(msgbuf);
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

void rptunref(void)
{
	struct mod *m;
	struct def *d;
	register int first;

	output(unrefhdr);
	for (m = allmodules; m; m = m->next)
		if (wanted(m->name)) {
			if (!(flags & R_MODDEFS))
				sortdefs(m);
			first = 1;
			for (d = m->defs; d; d = d->next)
				if (d->sym->nrefs == 0) {
					if (first) {
						first = 0;
						sprintf(msgbuf, unreffmt, m->name);
						output(msgbuf);
					}
					sprintf(msgbuf, unrefsym, dname(d->sym->name));
					output(msgbuf);
				}
		}
	output(crlf2);
	if (!stdoutcon)
		fputchar('\f');
}

/* writes the chosen reports */
void reports(void)
{
	output(crlf2b);
	if (flags & R_PUBS)
		rptpubs();
	if (flags & R_MODDEFS)
		rptmoddefs();
	if (flags & R_MODREFS)
		rptmodrefs();
	if (flags & R_SYMREFS)
		rptsymrefs();
	if (flags & R_SEGS)
		rptsegs();
	if (flags & R_CLASSES)
		rptclasses();
	if (flags & R_UNREF)
		rptunref();
}

/* adds ext to a name that has none */
void defext(char *name, char *ext)
{
	char *p;
	register int dot;

	dot = 0;
	p = name;
	while (*p)
		switch (*p++) {
		case ':':
		case '/':
		case '\\':
			dot = 0;
			break;
		case '.':
			dot = 1;
			break;
		}
	if (!dot && strlen(name) + strlen(ext) < 80)
		strcat(name, ext);
}

/* reads the options, then the file sets in order, then links, sorts and reports */
void main(register int argc, char **argv)
{
	char buf[80];
	FILE *fp;
	struct prjent *node;
	char name[MAXFILE];
	char ext[MAXEXT];
	register int i;

	setmode(fileno(stdout), O_BINARY);
	setmode(fileno(stderr), O_BINARY);
	stdoutcon = isdev(1);
	conout(banner);
	if (argc < 2) {
		if (!stdoutcon)
			output(banner);
		output(syntax);
		exit(1);
	}
	lowwater = memspace = farcoreleft() - 1024;
	memptr = farmalloc(memspace);
	inittabs();
	for (i = 1; i < argc; i++)
		if (argv[i][0] == '/' || argv[i][0] == '-')
			option(argv[i] + 1);
	if (outname[0])
		if ((outfp = fopen(outname, "wb")) == NULL) {
			sprintf(msgbuf, openoutmsg, outname);
			putmsg();
		}
	if (flags & O_VERBOSE)
		fputs(readmsg, stderr);
	for (i = 1; i < argc; i++)
		switch (argv[i][0]) {
		case '@':
			ropen(&prjrdr, argv[i] + 1, O_RDONLY, 0x400);
			while (token(&prjrdr, buf))
				fileset(buf);
			rclose(&prjrdr);
			break;
		case '-':
		case '/':
			setinput(argv[i] + 1);
			if (flags & (O_PRJ | O_RSP)) {
				buf[79] = 0;
				strncpy(buf, argv[i] + 2, 79);
				if (flags & O_PRJ)
					defext(buf, prjext);
				ropen(&prjrdr, buf, O_RDONLY, 0x400);
				if (flags & O_PRJ) {
					fp = fdopen(prjrdr.fd, "rb");
					if (isprj(fp)) {
						binary = 1;
						node = readprj(fp);
					} else {
						binary = 0;
						rewind(fp);
					}
				}
				for (;;) {
					if (flags & O_RSP) {
						if (!rsptoken(&prjrdr, buf))
							break;
					} else if (binary) {
						if (!node)
							break;
						strcpy(buf, node->name);
						node = node->next;
						if (!(fnsplit(buf, NULL, NULL, name, ext) & EXTENSION) || stricmp(ext, cext) == 0)
							strcpy(buf, name);
					} else if (!prjtoken(&prjrdr, buf))
						break;
					fileset(buf);
				}
				rclose(&prjrdr);
			}
			flags &= ~(O_PRJ | O_RSP);
			break;
		default:
			fileset(argv[i]);
		}
	if (!(flags & R_ALL))
		flags |= R_SYMREFS;
	fputs(linkmsg, stderr);
	resolveall();
	listmods();
	purge();
	listsegs();
	listcls();
	listsyms();
	fputs(sortmsg, stderr);
	sortall();
	if (outfp || !stdoutcon)
		fputs(writemsg, stderr);
	reports();
	sprintf(msgbuf, countmsg, symcnt, modcnt);
	putmsg();
	if (flags & (R_SEGS | R_CLASSES)) {
		sprintf(msgbuf, segcountmsg, numsegs, numcls);
		putmsg();
	}
	fprintf(stderr, memmsg, lowwater);
	if (outfp)
		fclose(outfp);
}
