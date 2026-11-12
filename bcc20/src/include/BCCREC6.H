#ifndef BCCREC6_H
#define BCCREC6_H
#include <stddef.h>
/* Deliberate shared project schema: genuine six-byte by-value source record. */
struct C77Record6 { unsigned int first,second,third; };
typedef char BCCRecord6Size[(sizeof(struct C77Record6)==6)?1:-1];
typedef char BCCRecord6First[(offsetof(struct C77Record6,first)==0)?1:-1];
typedef char BCCRecord6Second[(offsetof(struct C77Record6,second)==2)?1:-1];
typedef char BCCRecord6Third[(offsetof(struct C77Record6,third)==4)?1:-1];
#endif
