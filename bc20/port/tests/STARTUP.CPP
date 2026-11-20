// modtest: -ml
// #pragma startup and exit in C++, with functions that take parameters and that do not.
void init(void) {}
void finish(int) {}
#pragma startup init 64
#pragma exit finish
#pragma startup nothing
int main() { return 0; }
