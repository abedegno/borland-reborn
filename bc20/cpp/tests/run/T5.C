#if __SMALL__
small
#endif
#if __STDC__
stdc
#endif
#define STR(x) #x
#define CAT(a,b) a##b
char *p = STR(hello world);
int CAT(foo,bar) = __LINE__;
#pragma warn -rvl
#undef CAT
