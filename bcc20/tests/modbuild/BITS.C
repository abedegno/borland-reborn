/* modtest: -ml -O -G */
/* Bitfields: loads, stores, compound assignment, increment and decrement of signed and
   unsigned fields of several widths, also through pointers and in conditions. */
struct flags {
    unsigned ready : 1;
    unsigned mode : 3;
    signed level : 4;
    unsigned count : 7;
    unsigned wide : 12;
    int tail : 2;
};
struct flags global_flags;
struct flags table[4];

int test_bits(struct flags *f, int v)
{
    f->ready = 1;
    f->mode = v;
    f->level = -v;
    f->count += 3;
    f->count -= v;
    f->count *= 2;
    f->count /= 3;
    f->count %= 5;
    f->count <<= 1;
    f->count >>= 2;
    f->count |= 4;
    f->count &= 0x3C;
    f->count ^= v;
    f->wide++;
    f->wide--;
    ++f->level;
    --f->level;
    f->tail = f->level;
    global_flags = *f;
    table[v & 3].mode = global_flags.mode + 1;
    table[v & 3].wide = f->wide + table[(v + 1) & 3].wide;
    if (f->ready && f->mode == 3)
        return f->level + f->count;
    return f->wide > 100 ? f->tail : -f->count;
}

int pre(struct flags *f)
{
    int a = ++f->count;
    int b = --f->level;
    int c = (f->mode = 5) + (f->wide += 7);
    return a + b + c + (f->ready ? 1 : 2);
}

int post_global(void)
{
    /* through a far pointer this fails in Borland's compiler: see BITFAIL.C */
    return global_flags.count++ + global_flags.level--;
}
