/* target: WALK */
/* opts: -mc -O -Z -r- */
/* WALK.C: visiting every entry of a symbol table, chain by chain. */
#include <stdlib.h>
#include <string.h>
#include "TLIB.H"

/* The data of the entry after the one whose data is DATA, or of the first entry when DATA
 * is NULL; NULL after the last. */
char *walk(struct table *t, char *data)
{
	unsigned i;
	struct entry *e;

	curtab = t;
	if (data != NULL) {
		e = (struct entry *)(data - 6);
		i = e->lo;
		e = e->next;
	} else {
		i = -1;
		e = NULL;
	}
	if (e == NULL)
		while (++i < 256 && (e = curtab->bucket[i]) == NULL)
			;
	if (e != NULL)
		return e->data;
	return NULL;
}
