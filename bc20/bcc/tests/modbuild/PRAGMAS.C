/* modtest: -ml -w */
/* modes: -c -S */
/* Every #pragma BCC knows, and malformed ones: warn on, off and back to its default,
   startup and exit functions with and without priorities, codeseg with a name, a group and
   a class and with none, saveregs, argsused, noretval, option, and pragmas with bad
   arguments (reported, outside strict ANSI mode). */
#pragma warn -par
#pragma warn +rvl
#pragma warn .aus
#pragma warn xyz
#pragma warn -
void early(void) { }
void late(void) { }
#pragma startup early 64
#pragma startup late
#pragma exit late 100
#pragma exit early
#pragma startup 3
#pragma startup nosuchfunction
int notafunction;
#pragma exit notafunction
#pragma startup early 64 extra
#pragma codeseg MYCODE MYGROUP "MYCLASS"
int in_my_segment(int a) { return a + 1; }
#pragma codeseg
#pragma codeseg OTHER
#pragma codeseg 9bad
#pragma codeseg A B C
#pragma codeseg Q "unterminated
#pragma saveregs
int kept(int a, int b) { return a; }
#pragma argsused
int unused_args(int a, int b) { return 0; }
#pragma noretval
int no_value(void) { }
#pragma option -a
#pragma unknownpragma
#pragma 42
int main(void) { return in_my_segment(1) + kept(2, 3) + unused_args(4, 5); }
