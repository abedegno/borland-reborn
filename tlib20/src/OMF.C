/* target: OMF */
/* opts: -mc -B -O -Z */
/* OMF.C: reading object modules and libraries, and writing the new library.
 *
 * process() is TLIB's work: it copies the old library's modules (copymod), as the commands
 * say, adds the new object files (addmod), and finishes the library with its dictionary
 * (dictsize, writedict, dictadd) and, under /E, the extended dictionary TLINK /E uses
 * (writeext and the put... functions), then writes the listing (listing). Every record of
 * every module passes through readrec(); omfrec() notes what each means for the
 * dictionaries.
 *
 * Compiled through assembly (-B). Several spellings below are kept for the code they give;
 * each says so in a match: note. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alloc.h>
#include <mem.h>
#include <errno.h>
#include <io.h>
#include "TLIB.H"

/* OMF record types, and the kind number TLIB keeps for each: (type - 0x6E) / 2, so 0x80
 * THEADR is 9 and 0xB0 COMDEF is 0x21; a library's own records (F0h and up) keep their
 * type. */
#define KIND(type)	(((type) - 0x6E) >> 1)
#define THEADR	0x80
#define LHEADR	0x82
#define COMENT	0x88
#define MODEND	0x8A
#define EXTDEF	0x8C
#define PUBDEF	0x90
#define LINNUM	0x94
#define LNAMES	0x96
#define SEGDEF	0x98
#define GRPDEF	0x9A
#define FIXUPP	0x9C
#define LEDATA	0xA0
#define LIDATA	0xA2
#define COMDEF	0xB0
#define LIBHDR	0xF0	/* a library's header record */
#define LIBEND	0xF1	/* the record that pads a library's last page */

/* A library's header record: written first with a page size, rewritten at the end with
 * the dictionary's place and size. */
struct libhdr {
	byte type;		/* LIBHDR */
	word len;		/* the page size less 3 */
	long dictoff;
	word dictsize;		/* in 512-byte blocks */
};

char cbuf[129];			/* demangle()'s result (CMDLINE.C) */
char nbuf[62];			/* omfstring()'s result */
char lidata;			/* the module's last data record was LIDATA */
jmp_buf abortjb;		/* writeext() returns here when the extended dictionary is abandoned */
byte *recbuf;			/* the current record: type, length, contents */
byte *rec_p;			/* the next byte of it to read */
char *dictbuf;			/* the dictionary being built */
unsigned long in_pos;		/* bytes read from the input library or object file */
word rec_size;			/* the current record's length, header included */
int rec_type;			/* its KIND(), or its type for library records */
char zero_pad[16];		/* zeros, for padding pages */
unsigned long out_pos;		/* bytes written to the new library */
int lnamemap[64];		/* the current module's LNAMES, as lnameidx() numbers */
word dictpages;			/* the dictionary's size in 512-byte blocks */
char module_name[64];		/* the current module's name */
word recdatalen;		/* the current record's length field */
struct extref *extref_tail;	/* where the current module's lists end */
struct grp *grouplistend;
struct pub *public_tail;
struct seg *segmenttail;
byte *recordlimit;		/* the current record's checksum byte */
struct mod *module_chain;	/* the new library's modules, last first */
int lnames_count;		/* LNAMES of the current module so far */

/* The extended dictionary's state, and the buffer for LEDATA/LIDATA records */
word bufsize = 0x408;		/* recbuf's size: grown for longer records */
char *lebuf = NULL;		/* the module's last LEDATA or LIDATA record */
word lebufsize = 0;
struct libhdr hdr = { LIBHDR };
struct ext *exthead = NULL;	/* every module's extended-dictionary data, in order */
struct ext *curext = NULL;	/* the current module's */
int nmods = 0;
int ngrps = 0;			/* never counted: written as 0 */
int nexts = 0;			/* never counted */
int nsegs = 0;
int npubs = 0;
struct name *lnhead = NULL;	/* every LNAME of the library, once each */
struct name *lntail = NULL;
int nlnames = 0;
int lnsize = 0;
struct name *xnhead = NULL;	/* every external name, once each */
struct name *xntail = NULL;
int nxnames = 0;

/* Gives up the extended dictionary for this library, saying why. */
void noextdict(char *why)
{
	edict = 0;
	error(0, "%s - extended dictionary not created.", why);
}

/* Frees a list of names and empties it. */
void freelist(struct name **head)
{
	struct name *p;
	struct name *next;

	p = *head;
	if (p != NULL) {
		do {
			next = p->next;
			free(p);
			p = next;
		} while (p != NULL);
		*head = NULL;
	}
}

/* Appends a copy of S to the list of names *HEAD .. *TAIL. */
void addname(struct name **head, struct name **tail, char *s)
{
	struct name *p;

	if ((p = calloc(1, strlen(s) + 11)) == NULL)
		giveup();
	strcpy(p->text, s);
	p->next = NULL;
	if (*tail == NULL)
		*head = p;
	else
		(*tail)->next = p;
	*tail = p;
}

/* Reads an OMF index (one byte, or two when the first has bit 7 set). */
word getindex(void)
{
	word i;

	if ((i = *rec_p++) & 0x80)
		return ((0x7F & i) << 8) + *rec_p++;
	return i;
}

/* Reads a length-prefixed OMF string; returns it NUL-terminated in nbuf (cut to 61
 * characters). */
char *omfstring(void)
{
	word n;
	word m;

	n = *rec_p;
	rec_p++;
	m = n < 61 ? n : 61;
	memcpy(nbuf, rec_p, m);
	nbuf[m] = 0;
	rec_p += n;
	return nbuf;
}

/* Writes the current record to FP, when there is one. A short write is an error: "device
 * full" when DOS gave no error. */
void putrec(FILE *fp)
{
	if (fp != NULL) {
		errno = 0;
		if (fwrite(recbuf, 1, rec_size, fp) < rec_size)
			if (errno)
				error(2, "Could not write output.");
			else
				error(1, "Output device is full.");
	}
}

/* Pads the new library with zeros to the next page boundary. */
void padpage(void)
{
	word k;
	word n;

	if ((n = (pagesize - 1) & out_pos) != 0) {
		n = pagesize - n;
		while (n != 0) {
			k = n > 16 ? 16 : n;
			fwrite(zero_pad, 1, k, outfile);
			out_pos += k;
			n -= k;
		}
	}
}

/* Reads the next record of FP into recbuf, growing it when needed, and sets rec_type,
 * rec_size and recordlimit. Under /0 (zeroflag) it skips line numbers and debugging
 * comments; under /E it notes that there were some (edict 2), for a warning at the end. */
void readrec(FILE *fp)
{
	word c;

again:
	rec_p = recbuf;
	rec_type = ((*rec_p = c = (byte)getc(fp)) - 0x6E) >> 1;
	rec_p++;
	if (rec_type >= KIND(0xB8))
		if ((c & 0xFE) == 0xF0)
			rec_type = c;
		else
			error(1, "bad OMF record type 0x%X encountered", c);
	*(word *)rec_p = recdatalen = getw(fp);
	rec_size = recdatalen + 3;
	rec_p += 2;
	if (rec_size > bufsize) {
		bufsize = rec_size;
		if ((recbuf = realloc(recbuf, bufsize)) == NULL)
			error(1, "record length %u exceeds available buffer.", rec_size);
		rec_p = recbuf + 3;
	}
	fread(rec_p, 1, recdatalen, fp);
	in_pos += rec_size;
	if (rec_type == KIND(LINNUM) || rec_type == KIND(COMENT) && (recbuf[4] < 0x9E || recbuf[4] > 0xA1)) {
		if (zeroflag)
			goto again;
		if (edict && (rec_type == KIND(LINNUM) || rec_type == KIND(COMENT) && (recbuf[4] > 0xE0 || recbuf[4] <= 0xF8)))
			edict = 2;
	}
	recordlimit = recbuf + rec_size - 1;
}

/* Moves to the next module of FP, whose modules start on PAGE boundaries, and reads its
 * THEADR or LHEADR, setting module_name. Returns 0 at the library's end record. */
char nextmod(FILE *fp, word page)
{
	word skip;
	char *p;

	if ((skip = (page - in_pos) & (page - 1)) != 0) {
		fread(recbuf, 1, skip, fp);
		in_pos += skip;
	}
	readrec(fp);
	if (rec_type == KIND(LHEADR) || rec_type == KIND(THEADR)) {
		strncpy(module_name, omfstring(), 63);
		if ((p = strrchr(module_name, '.')) != NULL)
			*p = 0;
		strupr(module_name);
	} else if ((rec_type & 0xFE) == 0xF0)
		return 0;
	else
		error(1, " record kind 0x%X found, expected theadr or lheadr", rec_type * 2 + 0x6E);
	return 1;
}

/* Starts a module of the new library: enters its name with a '!' appended in the symbol
 * table, and notes the page it starts on. */
void newmod(void)
{
	struct mod *m;

	if ((m = calloc(1, sizeof(struct mod))) == NULL)
		error(1, "Memory full");
	m->next = module_chain;
	module_chain = m;
	m->page = out_pos >> pageshift;
	strcat(module_name, "!");
	lookup(1, publics_table, module_name, hash(module_name), &m->sym);
	module_name[strlen(module_name) - 1] = 0;
	*(struct mod **)m->sym = m;
}

/* A PUBDEF record: enters each public in the symbol table, which must not already have it,
 * and for the extended dictionary notes its group, segment and offset. */
void pubdef(void)
{
	struct pub *p;
	char *name;
	char *data;
	word offset;
	int type;
	word frame;
	unsigned grp;
	unsigned seg;

	grp = getindex();
	seg = getindex();
	frame = (grp | seg) == 0 ? *((word *)rec_p)++ : 0;
	while (rec_p - recbuf + 2 < rec_size) {
		name = omfstring();
		if (!lookup(1, publics_table, name, hash(name), &data))
			error(1, "public '%s' in module '%s' clashes with prior module '%.*s'", demangle(name), module_name,
			      strlen((*(struct mod **)data)->sym + 6) - 1, (*(struct mod **)data)->sym + 6);
		*(struct mod **)data = module_chain;
		offset = *(word *)rec_p;
		rec_p += 2;
		type = getindex();
		if (edict) {
			p = calloc(1, sizeof(struct pub));
			if (curext->pubs == NULL)
				curext->pubs = p;
			else
				public_tail->next = p;
			public_tail = p;
			p->sym = data;
			p->grp = grp;
			p->seg = seg;
			p->frame = frame;
			p->offset = offset;
			curext->npubs++;
			npubs++;
		}
	}
}

/* For the extended dictionary: -31 for a segment named <module>_DATA, -32 for
 * <module>_TEXT, else 0 (lnameidx() gives those names no LNAME of their own). */
int groupseg(char *s)
{
	unsigned n;

	if ((n = strlen(s)) > 5 && strlen(module_name) == n - 5)
		if (strcmp("_DATA", s + n - 5) == 0) {
			if (strncmp(s, module_name, n - 5) == 0)
				return -31;
		} else if (strcmp("_TEXT", s + n - 5) == 0 && strncmp(s, module_name, n - 5) == 0)
			return -32;
	return 0;
}

/* A SEGDEF record: adds the segment's length to the module's size, and notes the segment for
 * the extended dictionary. */
void segdef(void)
{
	byte attr;
	byte align;
	byte big;
	long len;
	byte nameidx;
	byte classidx;
	struct seg *p;
	word frame;

	attr = *rec_p;
	rec_p++;
	align = attr >> 5;
	big = attr & 2;
	if (align == 0) {
		frame = *(word *)rec_p;
		rec_p += 2;
		rec_p++;
	}
	len = *(word *)rec_p;
	rec_p += 2;
	if (big)
		len = 0x10000L;
	nameidx = *rec_p;
	rec_p++;
	classidx = *rec_p;
	rec_p++;
	rec_p++;
	module_chain->size += len;
	if (edict) {
		p = calloc(1, sizeof(struct seg));
		if (curext->segs == NULL)
			curext->segs = p;
		else
			segmenttail->next = p;
		segmenttail = p;
		p->len = len;
		p->attr = attr;
		p->name = lnamemap[nameidx - 1];
		p->class = lnamemap[classidx - 1];
		p->frame = frame;
		curext->nsegs++;
	}
	nsegs++;
}

/* A GRPDEF record, for the extended dictionary: the group's name and segments. */
void grpdef(void)
{
	struct grp *g;
	struct gitem *it;
	int n;

	n = 0;
	g = calloc(1, sizeof(struct grp));
	if (curext->grps == NULL)
		curext->grps = g;
	else
		grouplistend->next = g;
	grouplistend = g;
	g->next = NULL;
	rec_p = recbuf + 3;
	g->name = lnamemap[getindex() - 1];
	while (rec_p < recordlimit) {
		if (*rec_p++ != 0xFF) {
			fprintf(stderr, "Bogus GCD type byte in GRPDEF, extended dict aborted\n");
			giveup();
		}
		it = calloc(1, sizeof(struct gitem));
		if (g->last == NULL)
			g->first = it;
		else
			g->last->next = it;
		g->last = it;
		it->seg = getindex();
		n++;
	}
	g->count = n;
	curext->ngrps++;
}

/* The number of an LNAME in the library's list of them, adding it when new. */
int lnameidx(char *s)
{
	struct name *p;
	int i;

	if ((i = groupseg(s)) == 0) {
		for (p = lnhead; p != NULL; p = p->next) {
			if (strcmp(s, p->text) == 0)
				return i;
			i++;
		}
		addname(&lnhead, &lntail, s);
		nlnames++;
		lnsize += strlen(s) + 3;
	}
	return i;
}

/* An LNAMES record: numbers the module's names. */
void lnames(void)
{
	while (rec_p < recbuf + rec_size - 1)
		lnamemap[lnames_count++] = lnameidx(omfstring());
}

/* Prints the list of LNAMEs (a debugging aid; nothing calls it). */
void listlnames(void)
{
	struct name *p;

	printf("\n\nLNAMES LIST\n================== [%u] Entrys\n", nlnames);
	for (p = lnhead; p != NULL; p = p->next)
		printf("[%s]\n", p->text);
}

/* An EXTDEF record, for the extended dictionary: notes each external, sharing one name
 * entry among all the modules that use it. */
void extdef(void)
{
	struct name *p;
	struct name *found;
	struct extref *e;
	char *name;

	while (rec_p < recbuf + rec_size - 1) {
		name = omfstring();
		if (name != NULL && strlen(name) != 0) {
			found = NULL;
			for (p = xnhead; p != NULL; p = p->next)
				if (strcmp(p->text, name) == 0) {
					found = p;
					break;
				}
			if (found == NULL) {
				addname(&xnhead, &xntail, name);
				found = xntail;
				nxnames++;
				rec_p += (*rec_p & 0x80) ? 2 : 1;
			}
			e = calloc(1, sizeof(struct extref));
			if (curext->exts == NULL)
				curext->exts = e;
			else
				extref_tail->next = e;
			extref_tail = e;
			e->name = found;
			curext->nexts++;
		}
	}
}

/* Walks one iterated-data block of an LIDATA record at *PP, setting *SIZE to the bytes it
 * expands to. Returns 0 at the end of the record. */
int iterdata(char **pp, char *end, unsigned *size)
{
	unsigned sub;
	unsigned blocks;
	unsigned rep;

	rep = *(*(word **)pp)++;
	blocks = *(*(word **)pp)++;
	if (blocks == 0) {
		*pp += **(byte **)pp + 1;
		if (*pp < end)
			return 0;
		*size = rep;
		return 1;
	}
	while (blocks > 0) {
		if (iterdata(pp, end, &sub)) {
			*size = sub * rep;
			return 1;
		}
		blocks--;
	}
	return 0;
}

/* The bytes the last LIDATA record expands to, LEN being its length. */
unsigned lidatasize(unsigned len)
{
	char *p;
	char *end;
	unsigned total;

	total = 0;
	p = lebuf;
	end = p + len;
	while (iterdata(&p, end, &total))
		;
	return total;
}

/* Notes what the current record means for the extended dictionary (and, for PUBDEF and
 * SEGDEF, for the dictionary and the listing). */
void omfrec(int kind)
{
	unsigned b;

	switch (kind) {
	case KIND(COMENT):
	case KIND(LINNUM):
		if (!edict)
			break;
		break;
	case KIND(LNAMES):
		if (!edict)
			break;
		lnames();
		break;
	case KIND(EXTDEF):
		if (!edict)
			break;
		extdef();
		break;
	case KIND(PUBDEF):
		pubdef();
		break;
	case KIND(SEGDEF):
		segdef();
		break;
	case KIND(GRPDEF):
		if (!edict)
			break;
		if (!edict)
			break;
		grpdef();
		break;
	case KIND(FIXUPP):
		if (!edict)
			break;
		while (rec_p < recordlimit) {
			b = *rec_p;
			rec_p++;
			if (!(b & 0x80)) {
				b >>= 2;
				if (!(b & 0x10))
					b &= 3;
				b &= 7;
				if (b < 3)
					getindex();
				else if (b == 3)
					rec_p += 2;
			} else {
				b = (b << 8) + *rec_p;
				rec_p++;
				if ((b & 0x1800) == 0x800)
					curext->nfix += lidata == 1 ? lidatasize(b & 0x3FF) : 1;
				b = *rec_p;
				rec_p++;
				if (!(b & 0x80))
					if (b < 0x30)
						getindex();
					else if (b < 0x40)
						rec_p += 2;
				b = ~b;
				if (b & 8)
					if (b & 3)
						getindex();
					else
						rec_p += 2;
				if (b & 4)
					rec_p += 2;
			}
		}
		break;
	case KIND(LIDATA):
		if (!edict)
			break;
		lidata = 1;
		goto copy;
	case KIND(LEDATA):
		if (!edict)
			break;
		lidata = 0;
	copy:
		if (lebufsize) {
			if (lebufsize < rec_size)
				if ((lebuf = realloc(lebuf, rec_size)) == NULL)
					error(1, "can't grow LE/LIDATA record buffer");
		} else if ((lebuf = malloc(lebufsize = bufsize)) == NULL)
			error(1, "couldn't get LE/LIDATA record buffer");
		memcpy(lebuf, recbuf, rec_size);
		break;
	case KIND(COMDEF):
		if (!edict)
			break;
		noextdict("library contains COMDEF records");
		break;
	case KIND(MODEND): {
		char t;

		if (!edict)
			break;
		t = (recbuf[3] & 0xC0) >> 6;
		curext->ismain = t == 2 || t == 3;
		break;
	}
	case KIND(THEADR): {
		struct ext *x;

		if (!edict)
			break;
		if ((x = calloc(1, sizeof(struct ext))) == NULL)
			error(1, "couldn't alloc memory for per module data");
		omfstring();
		exthead != NULL ? (curext->next = x) : (exthead = x);	/* match: a ?: gives the original's stores */
		curext = x;
		x->next = NULL;
		x->mod = module_chain->sym;
		nmods++;
		lnames_count = 0;
		break;
	}
	}
}

/* Copies the current module of the input library: to its own .OBJ file with OP_EXTRACT,
 * and to the new library unless OP_REMOVE. C is the module's command, or NULL for a module
 * no command names. */
void copymod(struct cmd *c)
{
	FILE *out;
	word ops;
	int skip;

	out = NULL;
	ops = 0;
	if (c != NULL) {
		if ((ops = c->ops) & 4)
			if ((out = fopen(c->path, "wb")) == NULL) {
				error(0, "'%s' couldn't be created, original won't be changed", c->path);
				c->ops = ops = 0;
			}
		c->ops &= ~5;
	}
	if ((skip = ops & 1) == 0)
		newmod();
	for (;;) {
		putrec(out);
		if (!skip && outfile != NULL) {
			putrec(outfile);
			out_pos += rec_size;
			if (rec_type == KIND(MODEND))
				padpage();
		}
		if (!skip)
			omfrec(rec_type);
		if (rec_type == KIND(MODEND))
			break;
		readrec(in_file);
	}
	if (out != NULL)
		fclose(out);
}

/* Adds the object file FP, for command C, to the new library: every module of it when it
 * is itself a library, else its one module, renamed after the file. */
void addmod(FILE *fp, struct cmd *c)
{
	word sum;
	word n;
	char *p;
	char ok;
	word page;

	if (nextmod(fp, page = 16)) {
		ok = 0;
		strcpy(module_name, c->modname);
		p = recbuf + 4;
		strcpy(p, c->modname);
		n = (recbuf[1] = (recbuf[3] = strlen(p)) + 2) + 2;
		rec_size = n + 1;
		sum = 0;
		p -= 4;
		while (n--)
			sum -= *p++;
		*p = sum;
	} else {
		if (rec_type != LIBHDR || !nextmod(fp, page = rec_size)) {
			error(0, "added file '%s' does not begin correctly, ignored", c->path);
			return;
		}
		ok = 1;
	}
loop:
	newmod();
again:
	if (outfile != NULL) {
		putrec(outfile);
		out_pos += rec_size;
	}
	if (rec_type == KIND(MODEND)) {
		if (outfile != NULL)
			padpage();
		if (!ok)
			return;
		if (!nextmod(fp, page))
			return;
		goto loop;
	} else {
		omfrec(rec_type);
		readrec(fp);
		goto again;
	}
}

#define MODNAME(p) ((*(struct mod **)*(p))->sym + 6)

/* qsort() order for the listing: by module, the module's own name first, then by name. */
int cmppub(char **a, char **b)
{
	word r;

	if ((r = strcmp(MODNAME(a), MODNAME(b))) != 0)
		return r;
	if (*a == (*(struct mod **)*a)->sym)
		return -1;
	if (*b == (*(struct mod **)*b)->sym)
		return 1;
	return strcmp(*a + 6, *b + 6);
}

/* qsort() order for the dictionary: by name. */
int cmpsym(char **a, char **b)
{
	return strcmp(*a + 6, *b + 6);
}

/* Writes the listing file: the publics of each module, two to a line. */
void listing(char *name)
{
	char **syms;
	char **sp;
	word count;
	word n;
	char *data;
	struct mod *m;
	char col;
	FILE *fp;

	if (name == NULL)
		return;
	remove(name);
	if ((fp = fopen(name, "w+")) == NULL)
		error(2, name);
	if ((n = count = tcount(publics_table)) == 0)
		fputs("No public symbols exist.\n", fp);
	else {
		if ((sp = syms = calloc(count, 4)) == NULL) {
			error(0, "\r\nMemory full listing truncated!\r\n");
			return;
		}
		data = NULL;
		while (n-- && (*sp++ = data = walk(publics_table, data)) != NULL)
			;
		fputs("Publics by module\n", fp);
		qsort(syms, count, 4, cmppub);
		sp = syms;
		n = count;
		col = 0;
		while (n--) {
			m = *(struct mod **)*sp;
			if (m->sym == *sp) {
				if (col)
					putc('\n', fp);
				fprintf(fp, "\n%-8.*s\tsize = %ld\n", strlen(m->sym + 6) - 1, m->sym + 6, m->size);
				col = 0;
			} else
				fprintf(fp, (col ^= 1, col) ? "\t%-32s" : "  %s\n", demangle(*sp + 6));	/* match: re-reads col, as the original does */
			sp++;
		}
		if (col)
			putc('\n', fp);
		free(syms);
	}
	fclose(fp);
}

/* Allocates the dictionary: enough 512-byte blocks for every name, with EXTRA bytes of
 * slack per block, and at least one block. */
void dictsize(word extra)
{
	word a;
	word b;
	word nsyms;
	word bytes;
	char *data;

	nsyms = 0;
	bytes = 0;
	data = NULL;
	while ((data = walk(publics_table, data)) != NULL) {
		nsyms++;
		bytes += (strlen(data + 6) + 4) & ~1;
	}
	a = (nsyms + 34) / 35;
	b = (bytes + 474 - extra - extra - 1) / (474 - extra);
	dictpages = a > b ? a : b;
	dictpages = dictpages > 1 ? dictpages : 1;
	if ((dictbuf = calloc(dictpages, 512)) == NULL)
		error(1, "Out of memory");
	a = dictpages;
	while (a--)
		dictbuf[a * 512 + 37] = 0x13;
}

/* Enters NAME (length-prefixed, followed by its module's page) in the dictionary by the
 * library format's double hashing. Returns its position, or 0 when it found no room. */
word dictadd(byte *name)
{
	word bucket_x;
	word bucket_d;
	word block_x;
	word block_d;
	word bucket;
	word block;
	word len;
	word off;
	byte *p;
	byte *end;

	bucket_x = 0;
	bucket_d = 0;
	block_x = 0;
	block_d = 0;
	len = *(p = name);
	end = p + len;
	while (len--) {
		/* the format's rotations, in assembler: Turbo C has no rotate operator */
		asm mov cl,2
		asm ror word ptr bucket_x,cl
		bucket_x ^= *end | 0x20;
		asm mov cl,2
		asm rol word ptr block_d,cl
		block_d ^= *end | 0x20;
		end--;
		asm mov cl,2
		asm rol word ptr block_x,cl
		block_x ^= *p | 0x20;
		asm mov cl,2
		asm ror word ptr bucket_d,cl
		bucket_d ^= *p | 0x20;
		p++;
	}
	bucket = bucket_x %= 37;
	if ((bucket_d %= 37) == 0)
		bucket_d = 1;
	block = block_x %= dictpages;
	if ((block_d %= dictpages) == 0)
		block_d = 1;
	do {
		p = dictbuf + block * 512;
		do {
			if (p[bucket] == 0) {
				off = p[37] * 2;
				len = (*name + 4) & ~1;
				if (512 - off < len)
					p[37] = 0xFF;
				else {
					p[bucket] = off >> 1;
					memcpy(p + off, name, len);
					p[37] += len >> 1;
					return block * 512 + off;
				}
			}
		} while ((bucket = (bucket + bucket_d) % 37) != bucket_x);
	} while ((block = (block + block_d) % dictpages) != block_x);
	return 0;
}

/* Fills the dictionary with every name, in order. Returns 0 when it overflowed, for
 * process() to try again with more blocks. */
char writedict(void)
{
	char *data;
	word n;
	char buf[64];
	char **syms;
	char **sp;
	word count;
	word left;

	left = count = tcount(publics_table);
	if (count == 0)
		return 1;
	if ((sp = syms = calloc(count, 4)) == NULL)
		error(1, "Out of memory");
	data = NULL;
	while (left-- && (*sp++ = data = walk(publics_table, data)) != NULL)
		;
	qsort(syms, count, 4, cmpsym);
	sp = syms;
	left = count;
	while (left--) {
		memset(buf, 0, 64);
		data = *sp;
		sp++;
		buf[0] = n = strlen(data + 6) < 61 ? strlen(data + 6) : 61;
		memcpy(buf + 1, data + 6, n);
		*(word *)&buf[++n] = (*(struct mod **)data)->page;	/* match: the increment in the index orders the code as the original's */
		if (n & 1)
			buf[n + 2] = 0;
		if ((*(word *)(data + 4) = dictadd(buf)) == 0) {
			free(syms);
			return 0;
		}
	}
	free(syms);
	return 1;
}

/* Writes an OMF index (one or two bytes). */
word putindex(word i)
{
	byte b[2];
	int n;

	b[0] = i;
	if (i < 0x80)
		n = 1;
	else {
		n = 2;
		b[0] = (i >> 8) | 0x80;
		b[1] = i;
	}
	fwrite(b, n, 1, outfile);
	return i;
}

/* Writes a length in one, two or three bytes (the extended dictionary's own encoding). */
word putvlen(word v)
{
	byte b[3];
	int n;

	b[0] = v;
	if (v < 0x80)
		n = 1;
	else if (v < 0x4000) {
		n = 2;
		b[0] |= 0x80;
		b[1] = v >> 7;
	} else {
		n = 3;
		b[0] |= 0x80;
		b[1] = (v >> 7) | 0x80;
		b[2] = v >> 14;
	}
	fwrite(b, n, 1, outfile);
	return v;
}

/* Writes a length-prefixed string. */
void putstr(char *s)
{
	int n;

	putindex(n = strlen(s));
	if (n)
		fwrite(s, n, 1, outfile);
}

/* Writes a byte. */
void putbyte(byte c)
{
	fwrite(&c, 1, 1, outfile);
}

/* Writes a word. */
void putword(word w)
{
	fwrite(&w, 2, 1, outfile);
}

/* Writes the extended dictionary's list of LNAMEs. */
void putlnames(void)
{
	struct name *p;
	unsigned i;

	putword(nlnames);
	putword(lnsize);
	for (i = 0; i < nlnames; i++)
		putword(0xFFFF);
	for (p = lnhead; p != NULL; p = p->next)
		putstr(p->text);
}

/* Writes the extended dictionary's external names: those that are public in the library
 * become its dictionary position, the others are listed by name. */
void putexts(void)
{
	struct name *p;
	char *data;
	int n;
	int size;
	unsigned i;

	n = size = 0;
	for (p = xnhead; p != NULL; p = p->next)
		if (!lookup(0, publics_table, p->text, hash(p->text), &data))
			p->index = *(word *)(data + 4);
		else {
			p->index = -++n;
			size += strlen(p->text) + 3;
		}
	putword(n);
	putword(size);
	for (i = 0; i < n; i++)
		putword(0xFFFF);
	for (p = xnhead; n != 0 && p != NULL; p = p->next)
		if (p->index < 0) {
			putstr(p->text);
			n--;
		}
}

/* Writes a module's external references. */
void putextrefs(struct ext *x)
{
	struct extref *e;
	word unused;
	int idx;

	unused = 0;
	if (x->nexts > 6)
		putindex(x->nexts);
	for (e = x->exts; e != NULL; e = e->next)
		if ((idx = e->name->index) < 0)
			putindex(-idx);
		else {
			putbyte(0);
			putindex(idx);
		}
}

/* Writes a module's publics. */
void putpubs(struct pub *p, word n)
{
	if (n > 14)
		putindex(n);
	for (; p != NULL; p = p->next) {
		putword(*(word *)(p->sym + 4));
		putindex(p->grp);
		putindex(p->seg);
		if ((p->grp | p->seg) == 0)
			putword(p->frame);
		putword(p->offset);
	}
}

/* Writes a module's segments: the common ones as a single code byte. */
void putsegs(struct seg *s, unsigned n)
{
	struct seg *p;
	word name;
	word class;
	word attr;
	word code;
	register unsigned i;

	if (s == NULL)
		return;
	if (n > 6)
		putindex(n);
	for (i = 0, p = s; i < n; i++, p = p->next) {
		name = p->name;
		class = p->class;
		attr = p->attr;
		code = 0;
		switch (name) {
		case 1:
			if (class == 5 && attr == 0x28)
				code = 0xC0;
			break;
		case 2:
			if (class == 6 && attr == 0x48)
				code = 0xC1;
			break;
		case 3:
			if (class == 7 && attr == 0x48)
				code = 0xC2;
			break;
		case -32:
			if (class == 5 && attr == 0x28)
				code = 0xC4;
			break;
		case -31:
			if (class == 6 && attr == 0x48)
				code = 0xC5;
			break;
		}
		if (code)
			putbyte(code);
		else {
			if (class >= (word)-32)
				putbyte(class);
			else
				putindex(class);
			if (name >= (word)-32)
				putbyte(name);
			else
				putindex(name);
			putbyte(attr);
			if (!(attr & 0xE0))
				putword(p->frame);
		}
		putvlen(p->len);
	}
}

/* Writes a module's groups. */
void putgrps(struct grp *g, word n)
{
	struct gitem *it;

	if (n > 2)
		putindex(n);
	for (; g != NULL; g = g->next) {
		if ((g->name & 0xF000) != 0 || g->count > 15)
			giveup();
		putword((g->name << 4) | (g->count &= 0xF));
		for (it = g->first; it != NULL; it = it->next)
			putindex(it->seg);
	}
}

/* Writes one module's part of the extended dictionary. */
void putmodext(struct ext *x)
{
	word nsegs;
	word ngrps;
	word unused;
	unsigned nexts;
	unsigned npubs;

	unused = 0;
	nexts = x->nexts;
	npubs = x->npubs;
	nsegs = x->nsegs;
	ngrps = x->ngrps;
	putword(*(word *)(x->mod + 4));
	putindex(x->nfix);
	if (nexts > 6)
		nexts = 7;
	if (npubs > 14)
		npubs = 15;
	if (ngrps > 2)
		ngrps = 3;
	if (nsegs > 6)
		nsegs = 7;
	putword((nexts << 12) | (npubs << 8) | (ngrps << 3) | nsegs | (x->ismain << 5));
	putsegs(x->segs, x->nsegs);
	putgrps(x->grps, x->ngrps);
	putpubs(x->pubs, x->npubs);
	putextrefs(x);
}

/* Gives the names every module uses the first LNAME numbers. */
void seedlnames(void)
{
	lnameidx("");
	lnameidx("_TEXT");
	lnameidx("_DATA");
	lnameidx("_BSS");
	lnameidx("DGROUP");
	lnameidx("CODE");
	lnameidx("DATA");
	lnameidx("BSS");
}

/* Writes the extended dictionary after the dictionary, from a 512-byte boundary. When
 * giveup() comes back here, the file position goes back to where it began and the file is
 * committed (by closing a duplicate of its handle). */
void writeext(void)
{
	struct ext *x;
	long pos;
	int pad;
	int rem;

	if (outfile == NULL)
		return;
	pos = ftell(outfile);
	if (setjmp(abortjb)) {
		lseek(outfile->fd, pos, 0);
		close(dup(outfile->fd));
		return;
	}
	if ((rem = pos % 512) != 0)
		for (pad = 512 - rem; pad > 0; pad -= 16)
			fwrite(zero_pad, 1, pad < 16 ? pad : 16, outfile);
	putword(0x2BAD);
	putword(nmods);
	putword(nsegs);
	putword(npubs);
	putlnames();
	putexts();
	for (x = exthead; x != NULL; x = x->next)
		putmodext(x);
}

/* Writes the new library: copies the old library's modules as the commands say, adds the
 * new ones, then writes the dictionary, the extended dictionary and the header, and the
 * listing. */
void process(void)
{
	word v;
	struct cmd *c;
	char *buf;
	FILE *fp;
	word page;
	word extra;

	if ((recbuf = malloc(bufsize)) == NULL)
		error(1, "Out of memory");
	if (edict)
		seedlnames();
	in_pos = 0;
	if (in_file != NULL) {
		readrec(in_file);
		if (rec_type != LIBHDR || rec_size < 16)
			error(1, "Bad header in input LIB");
		page = rec_size;
		if (!pageset) {
			pagesize = page;
			pageshift = 3;
			v = pagesize >> 3;	/* match: pagesize (just set), not page */
			do {
				pageshift++;
				v >>= 1;
			} while (!(v & 1));
		}
	}
	if (outfile != NULL) {
		fwrite(&hdr, 1, 1, outfile);
		out_pos += 1;
		padpage();
	}
	if (in_file != NULL)
		for (;;) {
			if (!nextmod(in_file, page))
				break;
			for (c = commandlist; c != NULL; c = c->next)
				if (strcmp(module_name, c->modname) == 0) {
					if ((c->ops & 2) && !(c->ops & 1)) {
						error(0, "'%s' already in LIB, not changed!", module_name);
						copymod(NULL);
						c->ops &= ~2;
					} else
						copymod(c);
					break;
				}
			if (c == NULL)
				copymod(NULL);
		}
	if ((buf = malloc(0x4000)) == NULL)
		error(1, "Out of memory");
	for (c = commandlist; c != NULL; c = c->next) {
		if (c->ops & 5)
			error(0, "'%s' not found in library", c->modname);
		if (c->ops & 2)
			if ((fp = fopen(c->path, "rb")) == NULL)
				error(0, "'%s' file not found", c->path);
			else {
				in_pos = 0;
				setvbuf(fp, buf, _IOFBF, 0x4000);
				addmod(fp, c);
				fclose(fp);
			}
	}
	free(buf);
	if (outfile != NULL) {
		hdr.len = pagesize - 3;
		hdr.dictoff = out_pos;
		rec_size = 512 - (out_pos & 0x1FF);
		hdr.dictoff += rec_size;
		if (hdr.dictoff > (0x10000L << pageshift))
			error(1, "library too large, please restart with /P%d", pagesize * 2);
		memset(recbuf, 0, rec_size);
		recbuf[0] = LIBEND;
		*(word *)(recbuf + 1) = rec_size - 3;
		putrec(outfile);
		for (extra = 0x80;;) {	/* match: a test-at-top loop, as the original's */
			dictsize(extra);
			if (writedict())
				break;
			free(dictbuf);
			extra += 16;
		}
		hdr.dictsize = dictpages;
		fwrite(dictbuf, 512, dictpages, outfile);
		if (edict) {
			writeext();
			if (edict > 1)
				error(0, "use /E with TLINK to obtain debug information from library");
		}
		rewind(outfile);
		fwrite(&hdr, 1, 9, outfile);
	}
	listing(listname);
}
