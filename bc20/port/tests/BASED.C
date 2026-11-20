/* modtest: -ml -O */
/* Borland C++ 2.0's based pointers, an undocumented C extension: a string literal after
   the '*' of a pointer declarator names the base expression, and a use of the pointer adds
   it (FLUSH_PENDING_POOL, APPLY_BASED_POINTER_C, IS_BASED_NEAR_PTR).  Dereference,
   subscript, member access, arithmetic, assignment, comparison and casts. */
unsigned base_seg;
unsigned table[4];
struct item { int a, b; };
char near * "base_seg" p;
int far * "base_seg" q;
struct item near * "table[1]" r;
int f(int i)
{
    int total = *p + *q + p[2] + q[i] + r->b;
    p++;
    q += 2;
    *p = 7;
    r[i].a = total;
    if (p == 0 || q != 0)
        total += (int)p;
    return total + (int)(char near *)p;
}
