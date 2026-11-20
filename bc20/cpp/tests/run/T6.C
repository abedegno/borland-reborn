#define REC(n) (n>0)?REC_##n:0
#if (1 ? 2 : 3) == 2 && (sizeof(int) == 2) && !defined(NOTHING) && (1<<4) == 16
ok_expr
#elif 1
not_this
#else
nor_this
#endif
/* unterminated? */ "a\"b" 'c' 0x1fUL 1.5e10
#if 1/0
#endif
#garbage
