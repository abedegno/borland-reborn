/* target: FNAME */
/* opts: -mc -O -Z -r- */
/* FNAME.C: adding and replacing file-name extensions. */
#include <stdlib.h>
#include <string.h>
#include <mem.h>
#include "TLIB.H"

/* Appends EXT (".LIB", ".OBJ") to NAME when its last component has no extension, keeping
 * NAME within 63 characters. */
void addext(char *name, char *ext)
{
	char *p;

	if ((p = strrchr(name, '\\')) == NULL)
		p = name;
	if (strchr(p, '.') == NULL)
		strncat(p, ext, 63 - strlen(name));
}

/* A new string: NAME with the extension of its last component replaced by EXT (".BAK"),
 * or removed when EXT is "". */
char *basename(char *name, char *ext)
{
	char *p;
	unsigned n;

	if ((p = strrchr(name, '\\')) == NULL)
		p = name;
	n = (p = strchr(p, '.')) != NULL ? p - name : strlen(name);
	if ((p = calloc(strlen(ext) + n + 1, 1)) == NULL)
		error(2, "Memory full");
	memcpy(p, name, n);
	strcpy(p + n, ext);
	return p;
}
