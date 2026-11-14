/* modtest: -ml */
/* interrupt and _saveregs functions (save every register) that return a value: the value is
   stored into the saved registers' slots in the frame before they are popped. */
int interrupt int_result(void) { return 5; }
long interrupt long_result(void) { return 70000L; }
char far * interrupt pointer_result(void) { return (char far *)0x12345678L; }
void interrupt plain(void) { }
/* _saveregs functions keep every register too (the save-all frame), and return values
   through the saved slots */
int _saveregs saved_int(int a) { return a + 1; }
long _saveregs saved_long(long a) { return a * 2; }
void _saveregs saved_void(void) { }
