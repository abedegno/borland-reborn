/* MAKE.H: what MAKE's source files share - the makefile's targets, rules and macros, and
 * the functions and variables more than one file uses.
 *
 * MAKE 3.5 keeps no symbols, so every name is descriptive. Borland C++ 2.0 lays out each
 * file's uninitialised variables by a hash of the name, so the names of those were chosen
 * to land where the original's variables are; renaming one moves it. */

/* A macro (MAIN.C): its name, and its value after the name's NUL. */
struct macro {
	char flags;			/* MAC_BUSY while it is being expanded */
	struct macro *next;		/* the next in its hash chain */
	char *other;			/* never used */
	char name[1];
};
#define MAC_BUSY	2

/* A line of an in-line file (&& ... in a command). */
struct line {
	struct line *next;
	char *text;
};

/* An in-line file: written to a temporary file before its command runs. */
struct inl {
	struct inl *next;
	char *name;			/* MAKEnnnn.$$$ */
	struct line *lines;
};

/* A command of a target or a rule. */
struct cmd {
	struct cmd *next;
	char *extra;			/* never used */
	char *text;
	struct inl *inl;		/* its in-line files */
};

/* A dependency of a target. */
struct dep {
	struct dep *next;
	struct file *file;
};

/* An implicit rule .from.to, kept on the list of the extension it makes. */
struct rule {
	struct rule *next;
	struct ext *from;
	struct cmd *cmds;
};

/* An extension that a rule makes or uses, with its .path. directory. */
struct ext {
	char *name;
	struct ext *next;
	struct rule *rules;		/* the rules that make a file of this extension */
	char *path;
};

/* A target or a dependency. */
struct file {
	char *name;
	char *path;			/* the directory of name<dir>, or "" */
	struct cmd *cmds;
	struct file *next;
	struct dep *deps;
	struct ext *ext;
	char made;			/* never used */
	unsigned long time;		/* its date and time once known, 0 before */
	char state;			/* checkcirc(), update(): 1 while visited, 3 in a cycle */
	char pathed;			/* findpath() gave it its extension's .path. directory */
};

/* An -I directory, searched for !include files. */
struct incdir {
	int unused;
	struct incdir *next;
	char *dir;			/* with a / at its end */
};

/* BUILD.C: bringing a target up to date */
unsigned long pascal make(struct file *f, int depth);

/* MAKEIN.C: reading the makefile */
int pascal openfile(char *name);
long tellin(void);
int pascal openat(char *name, long pos);
void closein(void);
void pascal unget(int c);
int nextch(void);

/* MAIN.C: macros, targets, extensions and rules */
struct macro *pascal define(char *name, char *value);
void pascal undefine(char *name);
void pascal defstring(char *text, char *next, int *skip);
void pascal strarg(char *opt, char *next, int *skip);
int pascal isdef(char *name);
struct macro *findmacro(void);
struct file *pascal definefile(char *name, char *path);
struct rule *pascal definerule(struct ext *to, struct ext *from);
struct ext *pascal defineext(char *name);
void pascal adddep(struct file *t, char *name, char *path);
struct cmd *pascal newcmd(struct cmd *prev, char *text, char *extra);
void pascal setpath(struct ext *e, char *path);

/* PARSE.C: the makefile parser */
void pascal process(char *name);
char *pascal alloc(unsigned n);

/* EXEC.C: running a command */
unsigned long pascal getage(char *name);
unsigned long now(void);
char *pascal pathfind(char *name);
int pascal execute(char *cmd, char *args);
void importenv(void);

/* MACRO.C: macro expansion */
int pascal ifexpand(int c);
void pascal expandline(int c);
void pascal expandcmd(char *cmd, char *path);
void pascal skipline(int c);
void pascal put(int c);

/* IFEXPR.C: !if expressions */
int pascal ifexpr(char *s);

/* CONFIG.C: options */
char *pascal getoptions(int argc, char **argv);
char *pascal strsave(char *s);

/* ERRORS.C: messages; fatal() and error() add "file line" when reading a makefile */
void fatal(char *fmt, ...);
void error(char *fmt, ...);
void msg(char *fmt, ...);

/* SPAWN.C and SWAP.ASM: -S, swapping MAKE out of memory while a command runs */
int pascal redirect(char *name, int fd, int mode);
void pascal unredirect(int saved, int fd);
int pascal swapspawn(char *prog, char *args);
int pascal doswap(char *prog, char *args);
extern unsigned far swapsize;		/* bytes that stay in memory */

/* the options (CONFIG.C) */
extern int debug;			/* -= (undocumented): debugging output */
extern int help;			/* -? -h */
extern int autodep;			/* -a .AUTODEPEND */
extern int silent;			/* -s .SILENT */
extern int noexec;			/* -n, and .IGNORE (sic) */
extern int buildall;			/* -B */
extern int keeptemp;			/* -K .KEEP */
extern int ignore;			/* -i */
extern int swap;			/* -S .SWAP */
extern int stringopt;			/* a string option was given: -W cannot save them */

/* the makefile being read (ERRORS.C, PARSE.C) */
extern char *errfile;
extern int lineno;
extern int errcount;

/* buffers and lists (MACRO.C, MAIN.C) */
extern char expbuf[];			/* a line as expanded */
extern char macname[];			/* a macro's or a file's name */
extern char *outptr;			/* where put() writes in expbuf */
extern int maxname;			/* the significant length of a macro's name */
extern char *makefile;
extern char **myenv;			/* main()'s environment */
extern struct file *filechain;		/* every target and dependency */
extern struct incdir *incdirs;		/* -I directories */

/* the messages (MSGS.C) */
extern char errsmsg[], fatalmsg[], errormsg[], nohowmsg[], execmsg[], badarg[], nomakemsg[];
extern char nomemmsg[], errdirmsg[], redirmsg[], notermmsg[], circmsg[], toolongmsg[];
extern char ifeofmsg[], baddirmsg[], badincmsg[], longnamemsg[], noendmsg[], noincmsg[];
extern char macrolongmsg[], iflongmsg[], cmdlongmsg[], rulelongmsg[], badundefmsg[];
extern char elsemsg[], cmdsyntaxmsg[], elifmsg[], endifmsg[], badcharmsg[], syntaxmsg[];
extern char octalmsg[], charlongmsg[], divzeromsg[], redefmsg[], badtransmsg[];
