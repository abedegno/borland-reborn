/* target: PRJ */
/* opts: -mc -G -O -Z -d */
/* PRJ.C: reading a Turbo C project file (.PRJ) in its binary form, for OBJXREF /P. Generic
 * code, by the look of it: prjstring() and the configuration file's signature are never
 * used, and readfiles() never uses its size.
 *
 * The file: "Turbo C Project File \x1A" and its NUL, the version bytes 1 13 18 23 1 26 0, a
 * word whose high byte is 7, then records of a type word and a size word, ending with type
 * -1. Type 35h is the list of files, 6Ch bytes each, ending with one whose first word has
 * bit 15 set; the name is at 14h. Type 32h holds a nested project; 37h a table of strings. */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* a file of the project, as OBJXREF.C has it */
struct prjent {
	int flags;
	char *name;
	char pad[12];
	struct prjent *next;
};

/* a record's header */
struct prjrec {
	int type;
	unsigned size;
};

char *getmem(unsigned n);
char *xalloc(unsigned n);

char cfgsig[] = "Turbo C Configuration File \x1A";
char version[] = { 1, 13, 18, 23, 1, 26, 0 };
char prjsig[] = "Turbo C Project File \x1A";

static char *strtab;
static unsigned strsize;

/* string idx of the table in record 37h, the record list starting at pos; never called */
char *prjstring(int idx, FILE *fp, long pos)
{
	long save;
	struct prjrec hdr;
	register int i;

	if (strtab == NULL) {
		save = ftell(fp);
		fseek(fp, pos, SEEK_SET);
		hdr.size = 0;
		do
			fseek(fp, (long)hdr.size, SEEK_CUR);
		while (fread(&hdr, 4, 1, fp) == 1 && hdr.type != 0x37);
		strtab = xalloc(strsize = hdr.size);
		fread(strtab, strsize, 1, fp);
		fseek(fp, save, SEEK_SET);
	}
	i = ((int *)strtab)[idx];
	return strtab + i;
}

/* the list of files in a record 35h, at the file's position.
 * match: the loop is entered through a goto to its read, the one spelling that tests the
 * field in memory after fread() as the original does */
struct prjent *readfiles(FILE *fp, unsigned size)
{
	long save;
	struct {
		int flags;
		char pad[0x12];
		char name[0x58];
	} rec;
	struct prjent *e;
	struct prjent *head;
	struct prjent *last;

	head = NULL;
	last = NULL;
	save = ftell(fp);
	goto next;
	do {
		e = (struct prjent *)xalloc(sizeof(struct prjent));
		e->next = NULL;
		e->flags = rec.flags;
		e->name = xalloc(strlen(rec.name) + 1);
		strcpy(e->name, rec.name);
		if (!head)
			head = e;
		if (last)
			last->next = e;
		last = e;
next:
		fread(&rec, sizeof rec, 1, fp);
	} while (!(rec.flags & 0x8000));
	fseek(fp, save, SEEK_SET);
	return head;
}

/* every file of the project, nested projects first.
 * match: entered through a goto to its read, as readfiles() */
struct prjent *readprj(FILE *fp)
{
	struct prjent *save;
	struct prjent *sub;
	struct prjrec hdr;
	struct prjent *list;

	list = NULL;
	goto next;
	do {
		if (hdr.type == 0x35)
			list = readfiles(fp, hdr.size);
		if (hdr.type == 0x32) {
			if ((sub = readprj(fp)) != NULL) {
				save = list;
				list = sub;
				while (sub->next)
					sub = sub->next;
				sub->next = save;
			}
		} else
			fseek(fp, (long)hdr.size, SEEK_CUR);
next:
		fread(&hdr, 1, 4, fp);
	} while (hdr.type != -1);
	return list;
}

/* fp starts with the signature and version of a binary project file */
int isprj(FILE *fp)
{
	char buf[82];
	int ver;

	fread(buf, 1, 23, fp);
	if (strcmp(buf, prjsig) == 0) {
		fread(buf, 1, 7, fp);
		if (strcmp(buf, version) == 0) {
			fread(&ver, 1, 2, fp);
			if ((ver & 0xFF00) == 0x700)
				return 1;
		}
	}
	return 0;
}

/* getmem(), with its own message (getmem() never returns NULL) */
char *xalloc(unsigned n)
{
	char *p;

	if ((p = getmem(n)) == NULL) {
		printf("\nOut of memory\n");
		exit(1);
	}
	return p;
}
