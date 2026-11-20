#ifndef MACROS_H
#define MACROS_H
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
extern unsigned char LANGUAGE_MODE;
extern signed char NAME_LIMIT;
extern unsigned int HASH_CHAIN_LINK_SEG;
extern char near *TOKEN_PTR;
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
#endif
