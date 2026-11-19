/* TLIB.H: what TLIB's source files share - the library-command list, the symbol table,
 * the per-module records of the extended dictionary, and the program-wide globals.
 *
 * TLIB 3.01 keeps no symbols, so every name here is descriptive. The names of the
 * file-scope variables are also constrained: Turbo C 2.01 lays out each file's
 * uninitialised variables by a hash of the name ((first char + 4 * last char + 32 * length)
 * & 1023, ascending), so each name was chosen to land where the original's variable is.
 * Renaming one moves it. */

#include <stdio.h>
#include <setjmp.h>

typedef unsigned char byte;
typedef unsigned short word;	/* match: Turbo C 2.01 never puts an unsigned short local in a
				   register of its own accord, so the code's word locals stay on
				   the stack as they do in the original */

/* One library command from the command line: +name adds, -name removes, *name extracts,
 * and -+, +-, -* and *- combine them. */
#define OP_REMOVE	1
#define OP_ADD		2
#define OP_EXTRACT	4

struct cmd {
	struct cmd *next;
	int ops;		/* OP_ bits */
	char *path;		/* the .OBJ file as typed, with .OBJ added */
	char *modname;		/* the module name: the path's base name, no extension */
};

/* The public-symbol table (HASH.C, SYMTAB.C, WALK.C): 256 chains by the low byte of a
 * name's hash. Each entry carries six bytes of data for its owner: TLIB keeps the module
 * that defines the symbol in the first four and the symbol's dictionary position in the
 * last two. */
struct entry {
	struct entry *next;
	byte lo;		/* the hash's low byte: the chain */
	byte hi;		/* the hash's high byte, compared before the name */
	char data[6];
	char name[1];		/* the name, NUL-terminated, allocated to fit */
};

struct table {
	struct entry *last;	/* the entry made last */
	int count;
	int (*cmp)(const char *, const char *);	/* strcmp, or stricmp without /C */
	struct entry *bucket[256];
};

/* A module of the library being written. Its name is entered in the symbol table with a
 * '!' appended (a name no public can have), and the entry's data points back here. */
struct mod {
	struct mod *next;
	char *sym;		/* the data of its symbol-table entry */
	word page;		/* its first page in the library */
	long size;		/* the total length of its segments */
};

/* The extended dictionary, which TLINK /E reads: per module, its segments, groups,
 * publics and external references. */
struct name {			/* an LNAME or an external name, listed once each */
	struct name *next;
	int index;		/* externals: the dictionary position, or -n for the nth unresolved */
	long offset;
	char text[1];
};

struct pub {
	struct pub *next;
	char *sym;		/* the public's symbol-table data */
	unsigned grp;		/* group and segment index, as PUBDEF gives them */
	unsigned seg;
	word frame;		/* frame number, when both are 0 */
	word offset;
};

struct seg {
	struct seg *next;
	int name;		/* LNAME numbers (lnameidx()) */
	int class;
	int ovl;
	word frame;
	word len;
	char attr;		/* the SEGDEF attribute byte */
};

struct gitem {			/* one segment of a group */
	struct gitem *next;
	int seg;
};

struct grp {
	struct grp *next;
	int name;
	word count;
	struct gitem *first;
	struct gitem *last;
};

struct extref {			/* one EXTDEF of a module, pointing at the shared name */
	struct extref *next;
	struct name *name;
};

struct ext {			/* one module's part of the extended dictionary */
	struct ext *next;
	struct grp *grps;
	struct extref *exts;
	struct seg *segs;
	struct pub *pubs;
	word nexts;
	word npubs;
	word nfix;		/* fixups that need a segment's base */
	word nsegs;
	word ngrps;
	char *mod;		/* the module's own symbol-table data */
	byte ismain;		/* MODEND says the module holds a program's start address */
};

/* CMDLINE.C: the command line, main() */
char *demangle(char *name);
void giveup(void);

/* OMF.C: reading and writing the library */
void process(void);

/* HASH.C, SYMTAB.C, WALK.C: the symbol table */
unsigned hash(char *s);
struct table *newtable(char casesens);
char lookup(int create, struct table *t, char *name, unsigned h, char **result);
int tcount(struct table *t);
char *walk(struct table *t, char *data);

/* ERROR.C: messages */
void conmode(void);
void error(int level, char *fmt, ...);	/* 0 warning, 1 error, 2 DOS error; 1 and 2 stop TLIB */

/* FNAME.C: file names */
void addext(char *name, char *ext);
char *basename(char *name, char *ext);

/* DEMANGLE.C: C++ names for the listing */
char *unmangle(char *src, char *dst, unsigned maxlen, char *qual, char *base, int args);

/* The program-wide globals, defined in GLOBALS.C */
extern unsigned pagesize;		/* the library's page size (/P, or the input library's) */
extern int pageshift;			/* log2 of pagesize */
extern byte edict;			/* /E: 1 build the extended dictionary, 2 also seen debug
					   records (warn to use TLINK /E); 0 when not possible */
extern FILE *in_file;			/* the library being read, NULL for a new one */
extern FILE *outfile;			/* the library being written, NULL when nothing changes */
extern char *listname;			/* the listing file, or NULL */
extern char zeroflag;			/* /0: strip debugging records */
extern int pageset;			/* /P was given */
extern char casesens;			/* /C: case-sensitive symbols */
extern jmp_buf fatal_jmp;		/* error() returns here on a fatal error */
extern struct cmd *commandlist;		/* the library commands, in command-line order */
extern struct table *publics_table;	/* every public and module name in the library */
extern char new_library;		/* the library did not exist */

/* defined in OMF.C, used by CMDLINE.C */
extern char cbuf[129];			/* demangle()'s result */
extern jmp_buf abortjb;			/* giveup() abandons the extended dictionary here */

/* defined in SYMTAB.C, used by WALK.C */
extern struct table *curtab;		/* the table the last lookup() or walk() used */
