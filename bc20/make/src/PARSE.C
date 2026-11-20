/* target: PARSE */
/* opts: -mc -O -Z -d -a -y */
/* PARSE.C: reading a makefile. process() reads one file a line at a time: a line starting
 * with ! is a directive (!include, !if, !elif, !else, !endif, !undef, !error), one with
 * name = value defines a macro, .from.to: an implicit rule, a line with : a target and its
 * dependencies, a .NAME line a switch such as .AUTODEPEND or .PATH.ext = dir, and the
 * indented lines after a rule or a target its commands, with their && in-line files. The
 * conditional directives keep a stack of open !if blocks (ifstack) and skip what is not
 * taken with skipif(). */
#include <ctype.h>
#include <string.h>
#include <alloc.h>
#include "MAKE.H"

/* an open !if: state 1 while its taken part has not been seen, 2 after (!else) */
struct ifent {
	struct ifent *next;
	int state;
	int line;			/* for "Unexpected end of file in conditional" */
};

/* directives (dirtype) */
#define D_NONE		0
#define D_INCLUDE	1
#define D_UNDEF		3
#define D_DIR4		4		/* 4 and 5 open a block like !if, but nothing sets them */
#define D_DIR5		5
#define D_ENDIF		6
#define D_IF		7
#define D_ELSE		8
#define D_ELIF		10
#define D_ERROR		12

struct ifent *ifstack = NULL;
char tmpname[] = "MAKE0000.$$$";	/* in-line files, numbered by tmpnum */
int tmpnum = 0;

int dirtype;			/* the directive parsedirective() read */
char *infile;			/* the makefile being read */

void parseline(void);
void parsetarget(void);
struct file *pascal parsedep(char *line);
int pascal keyword(char *name, char *value);
struct cmd *getcmds(void);
int pascal isblank(int c);
char *tempname(void);
struct inl *pascal getinline(struct inl *list);
struct cmd *pascal interpcmd(struct cmd *prev);
void directive(void);
int parsedirective(void);
void pascal doerror(int c);
void pascal doinclude(int c);
char *trimline(void);
void pascal doundef(int c);
void pascal pushif(int state);
void pascal doif(int c);
void pascal doelse(int c);
void pascal doelif(int c);
void pascal doendif(int c);
int pascal getname(int c);
char *pascal alloc(unsigned n);
char *pascal dirpart(char *name);
void pascal skipif(int mode, int done);
int pascal skipblanks(int c);
void pascal skiprest(int c);

void pascal process(char *name)
{
	char *savefile;
	int saveline;
	struct ifent *saveif;
	register int c;
	register int indent;

	if (debug)
		msg("process( %s )\n", name);
	savefile = errfile;
	saveline = lineno;
	saveif = ifstack;
	ifstack = NULL;
	infile = name;
	errfile = name;
	lineno = 1;
	for (;;) {
		indent = 0;
		for (;;) {
			c = nextch();
			if (!isblank(c))
				break;
			indent = 1;
		}
		outptr = expbuf;
		if (c == '!') {
			directive();
			continue;
		}
		if (c == -1) {
			if (ifstack == NULL)
				goto done;
			error(ifeofmsg, ifstack->line);
			break;
		}
		if (c == '\n')
			continue;
		expandline(c);
		if (indent) {
			error(cmdsyntaxmsg);
			continue;
		}
		parseline();
	}
	while (ifstack)
		ifstack = ifstack->next;
done:
	ifstack = saveif;
	closein();
	lineno = saveline;
	errfile = savefile;
}

void parseline(void)
{
	char *p;
	char *to;
	char *from;
	struct rule *r;

	if (expbuf[0] == ' ') {
		interpcmd(NULL);
		return;
	}
	if (debug)
		msg("interprule: %s\n", expbuf);
	if (expbuf[0] == '.' && expbuf[1] != '.' && expbuf[1] != '/' && expbuf[1] != '\\') {
		from = expbuf + 1;
		for (p = from; *p != '.' && *p; p++)
			;
		if (*p == 0) {
			if (keyword(from, p))
				return;
			(void)1;
			goto bad;
		}
		*p++ = 0;
		if (keyword(from, p))
			return;
		to = p;
		for (; *p != ':' && *p; p++)
			;
		if (*p == 0) {
			(void)2;
			goto bad;
		}
		*p = 0;
		while (*++p == ' ')
			(void)3;
		if (*p) {
		bad:
			error(cmdsyntaxmsg);
			return;
		}
		for (p = from; *p != ' ' && *p; p++)
			;
		*p = 0;
		for (p = to; *p != ' ' && *p; p++)
			;
		*p = 0;
		r = definerule(defineext(strsave(to)), defineext(strsave(from)));
		r->cmds = getcmds();
		return;
	}
	parsetarget();
}

int pascal keyword(char *name, char *value)
{
	char *p;
	char *dir;
	char *mac;
	register int on;

	on = 1;
	if (strnicmp(name, "NO", 2) == 0) {
		on = 0;
		name += 2;
	}
	if (stricmp(name, "PATH") == 0) {
		if (!on)
			return 0;
		p = value;
		for (; *value != '=' && *value; value++)
			;
		if (*value == 0) {
		bad:
			error(cmdsyntaxmsg);
			return 1;
		}
		*value = 0;
		while (*++value == ' ' && *value)
			(void)4;
		if (*value == 0) {
			(void)5;
			goto bad;
		}
		dir = value;
		for (; *value != ' ' && *value; value++)
			;
		*value = 0;
		value = p;
		for (; *value != ' ' && *value; value++)
			;
		*value = 0;
		setpath(defineext(strsave(p)), dir = strsave(dir));
		mac = alloc(strlen(p) + 7);
		strcpy(mac, ".PATH.");
		strcat(mac, p);
		define(mac, dir);
		return 1;
	}
	if (stricmp(name, "AUTODEPEND") == 0) {
		autodep = on;
		return 1;
	}
	if (stricmp(name, "SILENT") == 0) {
		silent = on;
		return 1;
	}
	if (stricmp(name, "SWAP") == 0) {
		swap = on;
		return 1;
	}
	if (stricmp(name, "IGNORE") == 0) {
		noexec = on;	/* sic: .IGNORE sets the -n flag, not -i's */
		return 1;
	}
	if (stricmp(name, "KEEP") == 0) {
		keeptemp = on;
		return 1;
	}
	return 0;
}

void parsetarget(void)
{
	char *p;
	char *name;

	for (p = expbuf; *p; p++) {
		if (*p == '=' || *p == ' ')
			break;
		if (*p == ':' && (p[1] == ' ' || p[1] == 0))
			break;
	}
	if (p - expbuf == 0) {
		error(cmdsyntaxmsg);
		return;
	}
	for (; *p == ' '; p++)
		;
	if (*p == '=') {
		name = expbuf;
		*p = 0;
		if (p[-1] == ' ')
			p[-1] = 0;
		if (p[1] == ' ')
			p++;
		define(name, p + 1);
	} else
		parsedep(expbuf);
}

struct file *pascal parsedep(char *line)
{
	char *dep;
	struct file *t;
	struct file *sub;
	char *path;
	char *p;

	for (p = line; *p; p++) {
		if (*p == ' ')
			break;
		if (*p == ':' && (p[1] == ' ' || p[1] == 0))
			break;
	}
	if (p - line == 0) {
		error(cmdsyntaxmsg);
		return NULL;
	}
	for (; *p == ' '; p++)
		*p = 0;
	if (*p != ':') {
		path = dirpart(line);
		t = definefile(strsave(line), strsave(path));
		if (t->cmds || t->deps)
			error(redefmsg, line);
		sub = parsedep(p);
		if (sub == NULL)
			return NULL;
		t->cmds = sub->cmds;
		t->deps = sub->deps;
		return sub;
	}
	*p++ = 0;
	if (debug)
		msg("target = '%s'\n", line);
	path = dirpart(line);
	t = definefile(strsave(line), strsave(path));
	if (t->cmds || t->deps)
		error(redefmsg, line);
	for (; *p == ' '; p++)
		;
	if (*p)
		do {
			dep = p;
			for (; *p && *p != ' '; p++)
				;
			for (; *p == ' '; p++)
				*p = 0;
			path = dirpart(dep);
			adddep(t, strsave(dep), strsave(path));
		} while (*p);
	t->cmds = getcmds();
	return t;
}

struct cmd *getcmds(void)
{
	struct cmd *head;
	struct cmd *tail;
	struct inl *inl;
	char ch;
	register int c;

	head = NULL;
	inl = NULL;
	tail = NULL;
	for (;;) {
		c = nextch();
		if (c == '\n')
			continue;
		if (c == '!') {
			(void)6;
			goto bang;
		}
		if (!isblank(c))
			break;
		c = nextch();
		outptr = expbuf;
		if (c == '!') {
		bang:
			directive();
			continue;
		}
		if (c == -1)
			break;
		if (c == '\n')
			continue;
		outptr = expbuf;
		expbuf[0] = 0;
		inl = NULL;
		while (c != -1 && c != '\n') {
			put(c);
			c = nextch();
			if (c == '<') {
				if ((ch = nextch()) == '<') {
					put('<');
					goto inline;
				}
				unget(ch);
				(void)7;
			} else if (c == '&') {
				if ((ch = nextch()) == '&') {
				inline:
					inl = getinline(inl);
					c = nextch();
				} else {
					unget(ch);
					(void)8;
				}
			}
		}
		tail = interpcmd(tail);
		tail->inl = inl;
		if (head == NULL)
			head = tail;
	}
	unget(c);
	return head;
}

int pascal isblank(register int c)
{
	return c == ' ' || c == '\t';
}

char *tempname(void)
{
	tmpname[4] = tmpnum / 1000 % 10 + '0';
	tmpname[5] = tmpnum / 100 % 10 + '0';
	tmpname[6] = tmpnum / 10 % 10 + '0';
	tmpname[7] = tmpnum % 10 + '0';
	tmpnum++;
	return strsave(tmpname);
}

struct inl *pascal getinline(struct inl *list)
{
	struct inl *n;
	struct line *last;
	char *save;
	char term;
	volatile char c;	/* match: the loop test reads c back after storing it */
	struct line *ln;

	last = NULL;
	save = outptr;
	c = 0;
	n = (struct inl *)alloc(sizeof *n);
	n->name = tempname();
	n->lines = NULL;
	if ((term = nextch()) == '\n')
		fatal(notermmsg);
	while (c != '\n')
		c = nextch();
	while ((c = nextch(), c) != term) {
		while (c != '\n') {
			put(c);
			if ((c = nextch()) == -1)
				fatal(notermmsg);
		}
		put(c);
		ln = (struct line *)alloc(sizeof *ln);
		ln->text = strsave(save);
		ln->next = NULL;
		if (n->lines == NULL)
			n->lines = ln;
		else
			last->next = ln;
		last = ln;
		outptr = save;
		*outptr = 0;
	}
	for (save = n->name; *save; save++)
		put(*save);
	n->next = list;
	return n;
}

struct cmd *pascal interpcmd(struct cmd *prev)
{
	char *p;
	char *cmd;

	if (debug)
		msg("interpcmd: %s\n", expbuf);
	for (p = expbuf; *p == ' '; p++)
		;
	cmd = p;
	if (debug)
		msg("xcmd = '%s'\n", cmd);
	cmd = strsave(cmd);
	return newcmd(prev, cmd, NULL);
}

void directive(void)
{
	register int c;

	if (debug)
		msg("control()\n");
	c = parsedirective();
	switch (dirtype) {
	case D_NONE:
		skiprest(c);
		break;
	case D_INCLUDE:
		doinclude(c);
		break;
	case D_IF:
		doif(c);
		break;
	case D_UNDEF:
		doundef(c);
		break;
	case D_ELSE:
		doelse(c);
		break;
	case D_ERROR:
		doerror(c);
		break;
	case D_ENDIF:
		doendif(c);
		break;
	case D_ELIF:
		doelif(c);
		break;
	}
}

int parsedirective(void)
{
	char *p;
	int c;

	if (debug)
		msg("parsecntrl()\n");
	c = skipblanks(' ');
	if (c == '\n') {
		dirtype = D_NONE;
		return c;
	}
	for (p = macname; isalpha(c); c = nextch())
		*p++ = c;
	*p = 0;
	c = skipblanks(c);
	if (strcmp("include", macname) == 0)
		dirtype = D_INCLUDE;
	else if (strcmp("undef", macname) == 0)
		dirtype = D_UNDEF;
	else if (strcmp("elif", macname) == 0)
		dirtype = D_ELIF;
	else if (strcmp("if", macname) == 0)
		dirtype = D_IF;
	else if (strcmp("endif", macname) == 0)
		dirtype = D_ENDIF;
	else if (strcmp("else", macname) == 0)
		dirtype = D_ELSE;
	else if (strcmp("error", macname) == 0)
		dirtype = D_ERROR;
	else {
		dirtype = D_NONE;
		error(baddirmsg);
		skiprest(c);
		c = -1;
	}
	return c;
}

void pascal doerror(int c)
{
	char *p;

	for (p = expbuf; c != -1 && c != '\n'; c = nextch())
		*p++ = c;
	*p = 0;
	fatal(errdirmsg, expbuf);
}

void pascal doinclude(int c)
{
	char *savefile;
	char *name;
	char *end;
	struct incdir *dir;
	long pos;
	register int found;

	if (!ifexpand(c))
		return;
	name = trimline();
	if (debug)
		msg("Expanded to: '%s'\n", name);
	end = name + strlen(name) - 1;
	if (*name != '"' && *name != '<') {
		error(badincmsg);
		return;
	}
	if (*name == '"' && *end != '"' || *name == '<' && *end != '>') {
		error(noendmsg);
		return;
	}
	*end = 0;
	name++;
	if (strlen(name) >= 512) {
		error(longnamemsg);
		return;
	}
	strcpy(macname, name);
	if (debug)
		msg("opening %s\n", macname);
	savefile = infile;
	pos = tellin();
	closein();
	found = openfile(macname);
	for (dir = incdirs; dir && !found; dir = dir->next) {
		strcpy(expbuf, dir->dir);
		strcat(expbuf, macname);
		found = openfile(expbuf);
		if (debug)
			msg("opening %s\n", expbuf);
	}
	if (!found)
		error(noincmsg, macname);
	else {
		name = alloc(strlen(macname) + 1);
		strcpy(name, macname);
		process(name);
	}
	infile = savefile;
	openat(infile, pos);
}

char *trimline(void)
{
	char *p;

	for (p = expbuf + strlen(expbuf) - 1; p > expbuf && *p == ' '; p--)
		;
	if (p > expbuf || *p != ' ')
		p[1] = 0;
	else
		*p = 0;
	for (p = expbuf; *p == ' '; p++)
		;
	return p;
}

void pascal doundef(register int c)
{
	if (!isalpha(c) && c != '_') {
		error(badundefmsg);
		skiprest(c);
		return;
	}
	skiprest(getname(c));
	undefine(macname);
}

void pascal pushif(int state)
{
	struct ifent *e;

	e = (struct ifent *)alloc(sizeof *e);
	e->next = ifstack;
	e->state = state;
	e->line = lineno - 1;
	ifstack = e;
}

void pascal doif(int c)
{
	if (ifexpand(c) && ifexpr(expbuf))
		pushif(1);
	else {
		skipif(2, 0);
		if (dirtype == D_ELSE)
			pushif(2);
		else if (dirtype == D_ELIF)
			pushif(1);
	}
}

void pascal doelse(int c)
{
	skiprest(c);
	if (ifstack && ifstack->state == 1) {
		skipif(0, 0);
		ifstack = ifstack->next;
	} else
		error(elsemsg);
}

void pascal doelif(int c)
{
	skiprest(c);
	if (ifstack && ifstack->state == 1) {
		while (dirtype == D_ELIF || dirtype == D_ELSE)
			skipif(2, 1);
		ifstack = ifstack->next;
	} else
		error(elifmsg);
}

void pascal doendif(int c)
{
	skiprest(c);
	if (ifstack)
		ifstack = ifstack->next;
	else
		error(endifmsg);
}

int pascal getname(int c)
{
	char *p;

	for (p = macname; isalpha(c) || isdigit(c) || c == '_' || c == '$'; c = nextch())
		if (macname + maxname > p)
			*p++ = c;
	*p = 0;
	return c;
}

char *pascal alloc(unsigned n)
{
	char *p;

	p = malloc(n);
	if (p == NULL)
		fatal(nomemmsg);
	return p;
}

char *pascal dirpart(char *name)
{
	char *end;
	char *p;

	if (*name == 0)
		return "";
	end = name + strlen(name) - 1;
	if (*end != '>')
		return "";
	for (p = end - 1; p + 1 >= name + 1; p--)
		if (*p == '<') {
			if (end[-1] == ':' || end[-1] == '\\' || end[-1] == '/')
				*end = 0;
			else
				*end = '\\';
			*p = 0;
			return p + 1;
		}
	return "";
}

void pascal skipif(int mode, int done)
{
	int line;
	register int depth;
	register int c;

	line = lineno - 1;
	depth = 0;
	do {
		do
			c = nextch();
		while (c == ' ');
		if (c == -1) {
			error(ifeofmsg, line);
			return;
		}
		if (c == '!') {
			c = parsedirective();
			if (dirtype == D_IF || dirtype == D_DIR4 || dirtype == D_DIR5)
				depth++;
			else if (dirtype == D_ENDIF)
				depth--;
			else if (dirtype == D_ELSE && depth == 0) {
				if (mode == 1)
					depth--;
				else if (mode == 2) {
					if (done == 0)
						depth--;
					else
						mode = 0;
				} else
					error(elsemsg);
			} else if (dirtype == D_ELIF && depth == 0) {
				if (mode != 2)
					error(elifmsg);
				else if (done == 0) {
					if (ifexpand(c) && ifexpr(expbuf))
						return;
					continue;
				}
			}
		}
		skipline(c);
	} while (depth >= 0);
}

int pascal skipblanks(register int c)
{
	while (c == ' ')
		c = nextch();
	return c;
}

void pascal skiprest(register int c)
{
	while (c != -1 && c != '\n')
		c = nextch();
}
