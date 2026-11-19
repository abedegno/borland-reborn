/* target: GLOBALS */
/* opts: -mc -O -Z */
/* GLOBALS.C: the program-wide variables (TLIB.H describes each one).
 *
 * A file of data only. Its uninitialised variables sit after SYMTAB.C's curtab and before
 * the demangler's in TLIB.EXE, and pagesize and pageshift just before the demangler's
 * initialised data, so the link puts it there, between FNAME.C and DEMANGLE.C. */
#include "TLIB.H"

unsigned pagesize = 16;
int pageshift = 4;

byte edict;
FILE *in_file;
FILE *outfile;
char *listname;
char zeroflag;
int pageset;
char casesens;
jmp_buf fatal_jmp;
struct cmd *commandlist;
struct table *publics_table;
char new_library;
