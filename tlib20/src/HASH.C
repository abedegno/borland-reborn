/* target: HASH */
/* opts: -mc -O -Z -r- */
/* HASH.C: the symbol table's hash function, and making a table.
 *
 * The table itself is SYMTAB.C (lookup) and WALK.C (walking it in order). The three were
 * compiled separately: Turbo C 2.01 has no #pragma, and lookup() needs register variables
 * where hash() and walk() must not have them (-r-), so they cannot share a file. */
#include <stdlib.h>
#include <string.h>
#include "TLIB.H"

/* The hash of a name, case-folded (& 0xDF) so that both kinds of table can use it: the
 * low byte picks the chain, the high byte is compared before the name. */
unsigned hash(char *s)
{
	unsigned h;
	int c;

	h = 0;
	while ((c = *s++) != 0)
		h = ((h << 5) + (h >> 11)) ^ (c & 0xDF);
	return h;
}

/* A new, empty table, comparing names with strcmp, or with stricmp when casesens is 0.
 * Returns NULL when there is no memory. */
struct table *newtable(char casesens)
{
	struct table *t;

	if ((t = calloc(1, sizeof(struct table))) == NULL)
		return NULL;
	t->cmp = casesens ? strcmp : stricmp;
	return t;
}
