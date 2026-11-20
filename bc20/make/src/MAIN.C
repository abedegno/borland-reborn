/* target: MAIN */
/* opts: -mc -O -Z -d -a -y */
/* MAIN.C: main(), and the tables the makefile builds. main() reads the options (CONFIG.C),
 * BUILTINS.MAK from the current directory or MAKE's own, and the makefile (MAKEFILE or
 * MAKEFILE.MAK, or -f's), then makes the targets named on the command line, or the first
 * one in the makefile. Macros are a hash table of 1000 chains (define(), undefine(),
 * isdef(), findmacro()); targets and dependencies one list of files (definefile()),
 * extensions another, each with the rules that make files of that extension. */
#include <dos.h>
#include <dir.h>
#include <string.h>
#include <alloc.h>
#include <ctype.h>

#include "MAKE.H"

void _exit(int status);
extern char *_heaptop;

char idblock[22] = "$*$*$*\0\31\0\3Turbo Make";	/* never read by MAKE itself */
char makever[] = "0x0350";		/* the value of __MAKE__ */
char makename[] = "makefile";
int maxname = 32;			/* the significant length of a macro's name */
char *makefile = makename;
int gotbuiltins = 0;			/* BUILTINS.MAK was read: no makefile is no error */
char usagemsg[] =
	"Syntax: MAKE [options ...] target[s]\n"
	"\n"
	"    -B%c              Builds all targets regardless of dependency dates\n"
	"    -Dsymbol         defines symbol\n"
	"    -Dsymbol=string  defines symbol to string\n"
	"    -Idirectory      names an include directory\n"
	"    -K%c              keeps ( does not erase ) temporary files created by MAKE\n"
	"    -S%c              swaps MAKE out of memory to execute commands.\n"
	"    -W               write all non-string options back to the .EXE file\n"
	"    -Usymbol         undefine symbol\n"
	"    -ffilename       uses filename as the MAKEFILE\n"
	"    -a%c              performs auto-dependency checks for include files\n"
	"    -i%c              ignores errors returned by commands\n"
	"    -n%c              prints commands but does not do them\n"
	"    -s%c              silent, does not print commands before doing them\n"
	"    -? or -h         prints this message\n"
	"\n"
	"      Options marked with '+' are on by default.\n"
	"      To turn off a default option follow it by a '-',\n"
	"         for example: -a-\n";
unsigned _heaplen = 0x2000;		/* not used in the compact model */
unsigned _stklen = 0x2400;		/* the stack size, read by the startup code */

char **myenv;
struct ext *extensions;		/* every extension, with its rules */
struct macro *macros[1000];	/* the macro table, by hash() */
struct ext *lastext;
struct file *filechain;		/* every target and dependency, in the order first named */
struct file *filelast;
struct incdir *incdirs;

void pascal readbuiltins(char *prog);
void pascal strarg(char *opt, char *next, int *skip);
void pascal defstring(char *text, char *next, int *skip);
void usage(void);
char *pascal pathdup(char *s);
struct macro *pascal define(char *name, char *value);
void pascal undefine(char *name);
void revpaths(void);
void pascal inclib(char *dir);
int pascal isdef(char *name);
struct macro *findmacro(void);
int pascal hash(char *s);
int pascal namecmp(char *a, char *b);
struct file *pascal definefile(char *name, char *path);
struct rule *pascal definerule(struct ext *to, struct ext *from);
struct ext *pascal defineext(char *name);

int main(register int argc, char **argv, char **envp)
{
	char *prog;
	register int i;

	prog = argv[0];
	msg("MAKE  Version 3.5  Copyright (c) 1991 Borland International\n");
	myenv = envp;
	importenv();
	define("__MAKE__", makever);
	define("__MSDOS__", "1");
	getoptions(argc, argv);
	if (help)
		usage();
	while (argc > 1 && (argv[1][0] == '-' || argv[1][0] == ' ')) {
		argc--;
		argv++;
	}
	revpaths();
	readbuiltins(prog);
	if (!openfile(makefile)) {
		char *mf;

		mf = malloc(strlen(makefile) + 5);
		strcat(strcpy(mf, makefile), ".mak");
		if (!openfile(mf)) {
			if (makefile != makename || !gotbuiltins)
				fatal(nomakemsg);
			else
				makefile = NULL;
		} else
			makefile = mf;
	}
	if (makefile)
		process(makefile);
	{
		long avail;

		if (swap)
			avail = ((unsigned long)(FP_SEG(_heaptop) - _psp) << 4) - swapsize;
		else
			avail = coreleft();
		msg("\nAvailable memory %ld bytes\n\n", avail);
	}
	if (errcount) {
		msg(errsmsg, errcount);
		_exit(1);
	} else if (argc == 1) {
		make(filechain, 0);	/* the first target in the makefile, and its dependencies */
		_exit(0);
		(void)1;	/* match: keeps this exit apart from the one below */
	} else {
		i = 1;
		while (i < argc)
			make(definefile(argv[i++], ""), 0);
		_exit(0);
	}
	return 0;
}

void pascal readbuiltins(char *prog)
{
	char drive[MAXDRIVE];
	char path[MAXPATH];
	char dir[MAXDIR];

	if (openfile("builtins.mak")) {
		process("builtins.mak");
		gotbuiltins = 1;
	} else if (_osmajor >= 3) {
		fnsplit(prog, drive, dir, NULL, NULL);
		fnmerge(path, drive, dir, "builtins.mak", NULL);
		if (openfile(path)) {
			process(path);
			gotbuiltins = 1;
		}
	}
}

void pascal strarg(char *opt, char *next, int *skip)
{
	switch (*opt++) {
	case 'I':
		inclib(strsave(opt));
		break;
	case 'D':
		defstring(opt, next, skip);
		break;
	case 'U':
		undefine(opt);
		break;
	case 'f':
		makefile = strsave(opt);
		break;
	}
}

void pascal defstring(char *text, char *next, int *skip)
{
	char *p;

	for (p = text; *p; p++)
		if (*p == '=') {
			*p = 0;
			if (p[1] == 0) {
				define(text, next);
				*skip = 1;
			} else
				define(text, p + 1);
			*p = '=';
			return;
		}
	define(text, "1");
}

void usage(void)
{
	msg(usagemsg, buildall ? '+' : ' ', keeptemp ? '+' : ' ', swap ? '+' : ' ',
	    autodep ? '+' : ' ', ignore ? '+' : ' ', noexec ? '+' : ' ', silent ? '+' : ' ');
	_exit(0);
}

char *pascal pathdup(char *s)
{
	char *p;
	register int slash;

	p = s + strlen(s);
	if (p == s || p[-1] == '/' || p[-1] == '\\' || p[-1] == ':')
		slash = 0;
	else
		slash = 1;
	p = alloc(strlen(s) + slash + 1);
	strcpy(p, s);
	if (slash)
		strcat(p, "/");
	return p;
}

struct macro *pascal define(char *name, char *value)
{
	struct macro *m;
	register int h;

	h = hash(name);
	if (debug)
		msg("define( %s, %s )\n", name, value);
	for (m = macros[h]; m; m = m->next)
		if (namecmp(m->name, name)) {
			undefine(name);
			break;
		}
	m = (struct macro *)alloc(strlen(name) + strlen(value) + 12);
	strcpy(m->name, name);
	m->other = NULL;
	m->next = macros[h];
	m->flags = 0;
	macros[h] = m;
	strcpy(m->name + strlen(m->name) + 1, value);
	return m;
}

void pascal undefine(char *name)
{
	struct macro *m;
	struct macro *prev;
	register int h;

	if (debug)
		msg("undefine( %s )\n", name);
	h = hash(name);
	prev = NULL;
	for (m = macros[h]; m; m = m->next) {
		if (namecmp(name, m->name)) {
			if (prev)
				prev->next = m->next;
			else
				macros[h] = m->next;
			return;
		}
		prev = m;
	}
}

void revpaths(void)
{
	struct incdir *d;
	struct incdir *next;

	next = NULL;
	d = incdirs;
	incdirs = NULL;
	while (d) {
		next = d->next;
		d->next = incdirs;
		incdirs = d;
		d = next;
	}
}

void pascal inclib(char *dir)
{
	struct incdir *d;

	d = (struct incdir *)alloc(sizeof *d);
	if (debug)
		msg("inclib( %s )\n", dir);
	d->dir = pathdup(dir);
	d->next = incdirs;
	incdirs = d;
}

int pascal isdef(char *name)
{
	struct macro *m;

	if (debug)
		msg("isdef( %s )\n", name);
	for (m = macros[hash(name)]; m; m = m->next)
		if (namecmp(m->name, name))
			return 1;
	return 0;
}

struct macro *findmacro(void)
{
	struct macro *m;

	for (m = macros[hash(macname)]; m; m = m->next)
		if (namecmp(m->name, macname)) {
			if (m->flags & 2)
				return NULL;
			break;
		}
	return m;
}

int pascal hash(char *s)
{
	char *p;
	int shift;
	register int h;
	register int n;

	n = 0;
	p = s;
	h = 0;
	shift = 0;
	for (; *p && n < maxname; p++, shift++, n++) {
		if (shift > 8)
			shift = 0;
		h += *p << shift;
	}
	h = h * 0x643A71E3L >> 16;
	h %= 1000;
	if (h < 0)
		h = -h;
	return h;
}

int pascal namecmp(char *a, char *b)
{
	register int i;

	for (i = 0; i < maxname; i++, a++, b++) {
		if (*a != *b)
			return 0;
		if (*a == 0)
			break;
	}
	return 1;
}

struct file *pascal definefile(char *name, char *path)
{
	struct file *f;
	char *p;
	char *q;

	if (debug)
		msg("definefile( %s )\n", name);
	for (q = name; *q; q++)
		*q = tolower(*q);
	for (q = path; *q; q++)
		*q = tolower(*q);
	for (f = filechain; f; f = f->next)
		if (strcmp(f->name, name) == 0 && (*path == 0 || *f->path == 0 || strcmp(f->path, path) == 0)) {
			if (*f->path == 0) {
				f->path = path;
				return f;	/* match: two returns, merged into one jump */
			}
			return f;
		}
	f = (struct file *)alloc(sizeof *f);
	f->name = name;
	f->path = path;
	f->cmds = NULL;
	f->deps = NULL;
	f->next = NULL;
	f->made = 0;
	f->time = 0;
	f->state = 0;
	for (p = name + strlen(name) - 1; p >= name; p--) {
		if (*p == '.')
			break;
		if (*p == '\\') {
			p = name;	/* sic: dir\name gets the extension "ir\name" below */
			break;
		}
	}
	if (p >= name)
		f->ext = defineext(p + 1);
	else
		f->ext = NULL;
	if (filechain)
		filelast->next = f;
	else
		filechain = f;
	filelast = f;
	return f;
}

struct rule *pascal definerule(struct ext *to, struct ext *from)
{
	struct rule *r;
	struct rule *prev;

	if (debug)
		msg("defineedepend( %s, %s )\n", to->name, from->name);
	prev = NULL;
	for (r = to->rules; r; r = r->next) {
		if (r->from == from)
			return r;
		prev = r;
	}
	r = (struct rule *)alloc(sizeof *r);
	r->cmds = NULL;
	r->from = from;
	r->next = NULL;
	if (prev)
		prev->next = r;
	else
		to->rules = r;
	return r;
}

struct ext *pascal defineext(char *name)
{
	struct ext *e;
	char *p;

	if (debug)
		msg("defineextension( %s )\n", name);
	for (p = name; *p; p++)
		*p = tolower(*p);
	for (e = extensions; e; e = e->next)
		if (strcmp(e->name, name) == 0)
			return e;
	if (e == NULL) {
		e = (struct ext *)alloc(sizeof *e);
		e->name = name;
		e->next = NULL;
		e->rules = NULL;
		e->path = NULL;
		if (extensions)
			lastext->next = e;
		else
			extensions = e;
		lastext = e;
	}
	return e;
}

void pascal adddep(struct file *t, char *name, char *path)
{
	struct dep *d;
	struct dep *prev;
	struct file *f;

	f = definefile(name, path);
	prev = NULL;
	for (d = t->deps; d; d = d->next) {
		if (d->file == f)
			return;
		prev = d;
	}
	d = (struct dep *)alloc(sizeof *d);
	d->file = f;
	d->next = NULL;
	if (prev)
		prev->next = d;
	else
		t->deps = d;
}

struct cmd *pascal newcmd(struct cmd *prev, char *text, char *extra)
{
	struct cmd *c;

	c = (struct cmd *)alloc(sizeof *c);
	c->text = text;
	c->extra = extra;
	c->next = NULL;
	if (prev)
		prev->next = c;
	return c;
}

void pascal setpath(struct ext *e, char *path)
{
	char *p;

	for (p = path; *p; p++)
		*p = tolower(*p);
	e->path = path;
}
