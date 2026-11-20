/* target: SYMTAB */
/* opts: -mc -O -Z */
/* SYMTAB.C: looking names up in the symbol table (HASH.C has the hash and newtable()). */
#include <stdlib.h>
#include <string.h>
#include "TLIB.H"

struct table *curtab;

/* Looks NAME, whose hash is H, up in T. When it is there, *RESULT is its entry's data and
 * the result is 0. When it is not, the result is 1, and with CREATE an entry is added at
 * the end of its chain and *RESULT is the new entry's data (zeroed). */
char lookup(int create, struct table *t, char *name, unsigned h, char **result)
{
	unsigned char lo, hi;
	struct entry *e;
	struct entry *prev;

	prev = NULL;
	curtab = t;
	hi = h >> 8;
	for (e = t->bucket[lo = h]; e != NULL && (e->hi != hi || (*curtab->cmp)(name, e->name) != 0); e = (prev = e)->next)
		;
	if (e != NULL) {
		*result = e->data;
		return 0;
	}
	if (!create)
		return 1;
	if ((curtab->last = e = calloc(1, strlen(name) + 13)) == NULL)
		error(2, "Memory full");
	e->hi = hi;
	e->lo = lo;
	*result = e->data;
	strcpy(e->name, name);
	if (prev != NULL)
		prev->next = e;
	else
		curtab->bucket[lo] = e;
	curtab->count++;
	return 1;
}

/* The number of names in T. */
int tcount(struct table *t)
{
	return t->count;
}
