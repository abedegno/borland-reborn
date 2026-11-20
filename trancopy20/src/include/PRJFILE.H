/* PRJFILE.H: a Turbo C project file, read and written through stdio. */
#include <stdio.h>

class PrjFile {
	FILE *fp;
	long spare;		/* never used */
	long pos;		/* where the file is, counted by the members below */
public:
	FILE *open(char *name, char *mode);
	int read(void *buf, unsigned n);
	int write(void *buf, unsigned n);
	void rewind();
	int skip(unsigned n);
	int seek(unsigned where);
	int close();
	long tell() { return pos; }
};
