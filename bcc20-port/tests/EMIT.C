/* modtest: -ml */
/* Borland's __emit__ intrinsic: bytes, words and addresses of locals and globals, and
   arguments it refuses. */
int global;
void f(int arg)
{
    int local;
    __emit__(0x90, 0xCC, 0x1234, &local, &arg, &global, (char)7);
    __emit__(local);
    __emit__();
}
