/* structargs.h: functions of the original that take a structure by value, declared by
   hand (tools/genadapters.py leaves them out of protos.h).  The port passes the structure
   as its words; replay/functions.c has their stand-ins. */
#ifndef PORT_STRUCTARGS_H
#define PORT_STRUCTARGS_H
#include "port.h"

/* expr/EXPRPOOL.C, far pascal: a member node (operator 39h), with the source position
   struct C21Location {file, line, word3} (6 bytes on the stack, file lowest) */
u16 MAKE_MEMBER_NODE(u16 member, u16 file, u16 line, u16 word3);

#endif
