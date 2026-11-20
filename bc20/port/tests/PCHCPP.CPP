// modtest: -ml -H
// modes: -c -c
// Precompiled headers in C++: extern "C" around the includes, a #pragma hdrfile name.
#pragma hdrfile "OWN.SYM"
extern "C" {
#include <string.h>
}
#include <stdlib.h>
#define LATER 2
int main() { return strlen("ab") + LATER; }
