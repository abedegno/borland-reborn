/* target: ovr099_C239UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: tree simplifier and constant arithmetic (SIMPLIFY_*, FOLD_*). Entry points:
   FOLD_ADD_SIGNED, FOLD_ADD_UNSIGNED, FOLD_SUB_SIGNED, FOLD_SUB_UNSIGNED, FOLD_MUL_SIGNED,
   FOLD_MUL_UNSIGNED, FOLD_DIV_SIGNED, FOLD_DIV_UNSIGNED (+10 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the tree simplifier of the C++-mode front end, SIMPLIFY_EXPRESSION, run on
   analysed expressions (0x1A-byte nodes of expr/EXPRPOOL.C) before they are kept or
   handed on, from about 15 files. It walks the tree once (SIMPLIFY_NODE dispatches by
   operator) and does three jobs at the same time:
   1. Constant folding and algebraic simplification: constant operands are computed
      (the FOLD_* helpers below, reached through the function pointers *_FN, with the
      long double helpers for floating constants), and identities are applied: x+0,
      x*1, x*0, x/1, x*-1 = -x, x&0, x|-1, x^-1 = ~x, --x, !!x, *&x and &*x, constant
      conditions in ?:, && and ||, x-c as x+(-c), multiplication and unsigned
      division / remainder by powers of two as shifts and masks, (x+c1)+c2 = x+(c1+c2),
      member offsets folded into symbol offsets.
   2. Removal of unused values: "mode" 0 means the value of the subtree is discarded;
      subtrees without side effects are then deleted altogether (SIMPLIFY_NODE
      returns 0 for them), x++ in a discarded position becomes ++x, and so on.
   3. Use tracking for warnings: every symbol leaf ORs "flags" into its SYM_FLAGS
      (4 = value read, 2 = value assigned), and a read before any assignment, outside
      loops (LOOP_NEST_FACTOR 1), gives "possible use of 'x' before definition".
   The two parameters passed down the walk: mode (called level in places) 0 value
   discarded, 1 value used, 2 the subtree is used as an object (an lvalue under &, the
   target of an assignment, a callee); flags the use bits for symbols below, as above.
   Error nodes (operator 0) propagate: an operator with an error operand becomes the
   error node. CONSTANT_TRUTH_VALUE answers 0 (false), 1 (true) or 2 (unknown).
   EXPR_FLAGS bit 0x20 marks unsigned kinds; operator 3 is a long double constant,
   0x2D a _seg:offset combination, 0x49 unary plus, 0x35 cast, 0x36 call;
   INT_TYPE is the int type. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"
typedef struct { unsigned char bytes[10]; } C40RealStorage;   /* a 10-byte real, as in LOWEREXP.H */

/* FOLD_ADD_SIGNED .. FOLD_SHIFT_UNSIGNED: the constant arithmetic used by the folding
   code, one function per operator and signedness so that APPLY_CONSTANT_OP can be
   handed the pair it needs (through the *_FN pointers). Division and remainder by
   zero are not checked here; SIMPLIFY_DIVIDE and SIMPLIFY_MODULO report them before
   folding. The shift helpers shift right for a negative count, which SIMPLIFY_SHIFT
   uses to fold >> as a left shift by minus the count. */
/* ---- FOLD_ADD_SIGNED (listing 7380) ---- */
/* row FOLD_ADD_SIGNED (offset 0x0): stub 0C67:002A = FOLD_ADD_SIGNED */
long far pascal FOLD_ADD_SIGNED(long left,long right)
{
    return left+right;
}

/* ---- FOLD_ADD_UNSIGNED (listing 7393) ---- */
/* row FOLD_ADD_UNSIGNED (offset 0x13): stub 0C67:0020 = FOLD_ADD_UNSIGNED */
unsigned long far pascal FOLD_ADD_UNSIGNED(unsigned long left,unsigned long right)
{
    return left+right;
}

/* ---- FOLD_SUB_SIGNED (listing 73A6) ---- */
/* row FOLD_SUB_SIGNED (offset 0x26): stub 0C67:0066 = FOLD_SUB_SIGNED */
long far pascal FOLD_SUB_SIGNED(long left,long right)
{
    return left-right;
}

/* ---- FOLD_SUB_UNSIGNED (listing 73B9) ---- */
/* row FOLD_SUB_UNSIGNED (offset 0x39): stub 0C67:003E = FOLD_SUB_UNSIGNED */
unsigned long far pascal FOLD_SUB_UNSIGNED(unsigned long left,unsigned long right)
{
    return left-right;
}

/* ---- FOLD_MUL_SIGNED (listing 73CC) ---- */
/* row FOLD_MUL_SIGNED (offset 0x4C): stub 0C67:006B = FOLD_MUL_SIGNED */
long far pascal FOLD_MUL_SIGNED(long left,long right)
{
    return left*right;
}

/* ---- FOLD_MUL_UNSIGNED (listing 73E4) ---- */
/* row FOLD_MUL_UNSIGNED (offset 0x64): stub 0C67:0043 = FOLD_MUL_UNSIGNED */
unsigned long far pascal FOLD_MUL_UNSIGNED(unsigned long left,unsigned long right)
{
    return left*right;
}

/* ---- FOLD_DIV_SIGNED (listing 73FC) ---- */
/* row FOLD_DIV_SIGNED (offset 0x7C): stub 0C67:005C = FOLD_DIV_SIGNED */
long far pascal FOLD_DIV_SIGNED(long left,long right)
{
    if (right==0)
        return left;
    return left/right;
}

/* ---- FOLD_DIV_UNSIGNED (listing 7424) ---- */
/* row FOLD_DIV_UNSIGNED (offset 0xA4): stub 0C67:0039 = FOLD_DIV_UNSIGNED */
unsigned long far pascal FOLD_DIV_UNSIGNED(unsigned long left,unsigned long right)
{
    if (right==0)
        return left;
    return left/right;
}

/* ---- FOLD_MOD_SIGNED (listing 744C) ---- */
/* row FOLD_MOD_SIGNED (offset 0xCC): stub 0C67:0070 = FOLD_MOD_SIGNED */
long far pascal FOLD_MOD_SIGNED(long left,long right)
{
    return left%right;
}

/* ---- FOLD_MOD_UNSIGNED (listing 7464) ---- */
/* row FOLD_MOD_UNSIGNED (offset 0xE4): stub 0C67:0048 = FOLD_MOD_UNSIGNED */
unsigned long far pascal FOLD_MOD_UNSIGNED(unsigned long left,unsigned long right)
{
    if (right==0)
        return 0;
    return left%right;
}

/* ---- FOLD_AND_LONG (listing 748A) ---- */
/* row FOLD_AND_LONG (offset 0x10A): stub 0C67:002F = FOLD_AND_LONG */
long far pascal FOLD_AND_LONG(long left,long right)
{
    return left&right;
}

/* ---- FOLD_OR_LONG (listing 749D) ---- */
/* row SIMPLIFY_EXPRESSION (offset 0x11D): stub 0C67:0025 = FOLD_OR_LONG (SIMPLIFY_EXPRESSION is the name of stub 0C67:0061) */
long far pascal FOLD_OR_LONG(long left,long right)
{
    return left|right;
}

/* ---- FOLD_XOR_LONG (listing 74B0) ---- */
/* row FOLD_XOR_LONG (offset 0x130): stub 0C67:0034 = FOLD_XOR_LONG */
long far pascal FOLD_XOR_LONG(long left,long right)
{
    return left^right;
}

/* ---- FOLD_SHIFT_SIGNED (listing 74C3) ---- */
/* row FOLD_SHIFT_SIGNED (offset 0x143): stub 0C67:0057 = FOLD_SHIFT_SIGNED */
long far pascal FOLD_SHIFT_SIGNED(long value,long count)
{
    if (count<0)
        return value>>-count;
    return value<<count;
}

/* ---- FOLD_SHIFT_UNSIGNED (listing 74F8) ---- */
/* row FOLD_SHIFT_UNSIGNED (offset 0x178): stub 0C67:004D = FOLD_SHIFT_UNSIGNED */
unsigned long far pascal FOLD_SHIFT_UNSIGNED(unsigned long value,long count)
{
    if (count<0)
        return value>>-count;
    return value<<count;
}

/* ---- COMPARE_SIGNED_LONG (listing 752D) ---- */
/* row COMPARE_SIGNED_LONG (offset 0x1AD): stub none (static) = COMPARE_SIGNED_LONG */
/* COMPARE_SIGNED_LONG / COMPARE_UNSIGNED_LONG: -1, 0 or 1 like strcmp, for folding
   comparisons of constants. */
static int far pascal COMPARE_SIGNED_LONG(long left,long right)
{
    if (left==right)
        return 0;
    if (left<right)
        return -1;
    return 1;
}

/* ---- COMPARE_UNSIGNED_LONG (listing 7562) ---- */
/* row COMPARE_UNSIGNED_LONG (offset 0x1E2): stub none (static) = COMPARE_UNSIGNED_LONG */
static int far pascal COMPARE_UNSIGNED_LONG(unsigned long left,unsigned long right)
{
    if (left==right)
        return 0;
    if (left<right)
        return -1;
    return 1;
}

/* ---- NO_REAL_FOLD (listing 7597) ---- */
/* row NO_REAL_FOLD (offset 0x217): stub 0C67:0052 = NO_REAL_FOLD */
/* NO_REAL_FOLD: the "floating" operation for operators that have none (%, &, |, ^,
   shifts); it leaves the left value unchanged. */
void far pascal NO_REAL_FOLD(long left,long right)
{
}

/* ---- POWER_OF_TWO_SHIFT (listing 759E) ---- */
/* row POWER_OF_TWO_SHIFT (offset 0x21E): stub none (static) = POWER_OF_TWO_SHIFT */
/* POWER_OF_TWO_SHIFT: *single = 1 when value (> 0) is a power of two, with *shift its
   exponent. */
static void near pascal POWER_OF_TWO_SHIFT(long value,unsigned char far *single,int far *shift)
{
    register int count;

    for (count=0; value>0 && (value&1)==0; count++)
        value>>=1;
    *single=value==1;
    *shift=count;
}

/* ---- CONSTANT_TRUTH_VALUE (listing 75F6) ---- */
/* row X02A_11 (offset 0x276): stub 0C67:0075 = CONSTANT_TRUTH_VALUE */
extern unsigned int  EXPR_POOL_SEG;
extern C40RealStorage near  REAL_ZERO;     /* the 10-byte real 0.0 */
extern int far pascal RTL_LDOUBLE_COMPARE(void far *,void far *);

/* CONSTANT_TRUTH_VALUE: truth value of expr when known at compile time: 0 for a zero
   constant, 1 for a nonzero constant or the address of a symbol, 2 when unknown. */
unsigned int far pascal CONSTANT_TRUTH_VALUE(register unsigned int expr)
{
    unsigned char value[10];

    if (expr) {
        if (EXPR_W(expr,EXPR_OP)==EOP_CONST) {
            if (EXPR_L(expr,EXPR_VALUE)==0)
                return 0;
            return 1;
        }
        if (EXPR_W(expr,EXPR_OP)==3) {
            RTL_MEMMOVE(value,MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),10);
            if (RTL_LDOUBLE_COMPARE(value,&REAL_ZERO)==0)
                return 0;
            return 1;
        }
        if (EXPR_W(expr,EXPR_OP)==EOP_ADDR && EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==1)
            return 1;
    }
    return 2;
}

/* ---- REPLACE_WITH_INT_CONSTANT (listing 767A) ---- */
/* row REPLACE_WITH_INT_CONSTANT (offset 0x2FA): stub none (static) = REPLACE_WITH_INT_CONSTANT */
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern void far pascal FREE_EXPR_TREE(unsigned int);

/* REPLACE_WITH_INT_CONSTANT: frees expr and returns the int constant value. */
static unsigned int near pascal REPLACE_WITH_INT_CONSTANT(long value,unsigned int expr)
{
    unsigned int result;

    result=MAKE_INT_CONSTANT(INT_TYPE,value);
    FREE_EXPR_TREE(expr);
    return result;
}

/* ---- REPLACE_WITH_TYPED_CONSTANT (listing 76A4) ---- */
/* row REPLACE_WITH_TYPED_CONSTANT (offset 0x324): stub none (static) = REPLACE_WITH_TYPED_CONSTANT */

/* REPLACE_WITH_TYPED_CONSTANT: frees expr and returns a constant value of expr's type. */
static unsigned int near pascal REPLACE_WITH_TYPED_CONSTANT(long value,unsigned int expr)
{
    unsigned int result;

    result=MAKE_INT_CONSTANT(EXPR_W(expr,EXPR_TYPE),value);
    FREE_EXPR_TREE(expr);
    return result;
}

/* ---- REPLACE_WITH_LEFT (listing 76D5) ---- */
/* row REPLACE_WITH_LEFT (offset 0x355): stub none (static) = REPLACE_WITH_LEFT */
extern void far pascal FREE_EXPR_NODE(unsigned int);

/* REPLACE_WITH_LEFT: frees expr and its right operand and returns its left operand. */
static unsigned int near pascal REPLACE_WITH_LEFT(unsigned int expr)
{
    unsigned int result;

    result=EXPR_W(expr,EXPR_LEFT);
    FREE_EXPR_TREE(EXPR_W(expr,EXPR_RIGHT));
    FREE_EXPR_NODE(expr);
    return result;
}

/* ---- NEGATE_CONSTANT (listing 7704) ---- */
/* row NEGATE_CONSTANT (offset 0x384): stub none (static) = NEGATE_CONSTANT */
extern long (far pascal *TOKEN_CONVERT)(long,int);

/* NEGATE_CONSTANT: negates an integer or floating constant node in place (for floating
   values by flipping the sign bit of the 10-byte long double). */
static void near pascal NEGATE_CONSTANT(register unsigned int expr)
{
    unsigned int value[5];

    if (EXPR_W(expr,EXPR_OP)==EOP_CONST)
        EXPR_L(expr,EXPR_VALUE)=TOKEN_CONVERT(-EXPR_L(expr,EXPR_VALUE),TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND));
    else if (EXPR_W(expr,EXPR_OP)==3) {
        RTL_MEMMOVE(value,MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),10);
        value[4]^=0x8000;
        RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),value,10);
    }
}

/* ---- WRAP_IN_UNARY_NODE (listing 778E) ---- */
/* row WRAP_IN_UNARY_NODE (offset 0x40E): stub none (static) = WRAP_IN_UNARY_NODE */
extern unsigned int far pascal ALLOC_EXPR_NODE(void);
struct C023Node { unsigned int words[13]; };

/* WRAP_IN_UNARY_NODE: a new node with operator op (e.g. 0x2E EOP_NEG, 0x2F EOP_COMPL)
   over expr, copying expr's type and source position. */
static unsigned int near pascal WRAP_IN_UNARY_NODE(unsigned int op,unsigned int expr)
{
    register unsigned int node;

    node=ALLOC_EXPR_NODE();
    *(struct C023Node far *)MK_FP(EXPR_POOL_SEG,node)=
        *(struct C023Node far *)MK_FP(EXPR_POOL_SEG,expr);
    EXPR_W(node,EXPR_OP)=op;
    EXPR_W(node,EXPR_LEFT)=expr;
    EXPR_W(node,EXPR_RIGHT)=0;
    return node;
}

/* ---- SIMPLIFY_CALL (listing 77CD) ---- */
/* row SIMPLIFY_CALL (offset 0x44D): stub none (static) = SIMPLIFY_CALL */
static unsigned int near pascal SIMPLIFY_NODE(unsigned int expr,unsigned int flags,unsigned int mode);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);

/* SIMPLIFY_CALL: simplifies the callee (as an object) and every argument; any error
   operand makes the whole call an error node. */
static unsigned int near pascal SIMPLIFY_CALL(register unsigned int expr)
{
    unsigned char zero;
    unsigned int item;

    EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),4,2);
    zero=EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==0;
    for (item=EXPR_W(expr,EXPR_RIGHT); item; item=EXPR_W(item,EXPR_LEFT)) {
        EXPR_W(item,EXPR_RIGHT)=SIMPLIFY_NODE(EXPR_W(item,EXPR_RIGHT),4,1);
        if (!zero && EXPR_W(item,EXPR_RIGHT))
            zero=EXPR_W(EXPR_W(item,EXPR_RIGHT),EXPR_OP)==0;
    }
    if (zero)
        expr=REPORT_EXPR_ERROR_PLAIN(0,expr);
    return expr;
}

/* ---- SIMPLIFY_CAST (listing 7878) ---- */
/* row SIMPLIFY_CAST (offset 0x4F8): stub none (static) = SIMPLIFY_CAST */
extern unsigned long far pascal RTL_LDOUBLE_TO_ULONG(void far *);
extern long far pascal RTL_LDOUBLE_TO_LONG(void far *);
extern void far pascal RTL_ULONG_TO_LDOUBLE(unsigned long,void far *);
extern void far pascal RTL_LONG_TO_LDOUBLE(long,void far *);
extern long far pascal TYPE_SIZE(unsigned int);

/* SIMPLIFY_CAST: simplifies the operand, then removes the cast where it changes
   nothing (same type) or can be done now: an integer or floating constant converted to
   an integer or floating type, or an integer constant to a pointer or integer of the
   same size; a cast between pointers of the same kind is also dropped (but not
   &function cast to another function pointer type). The surviving node always has the
   cast's type. A discarded operand (0) removes the cast too. */
static unsigned int near pascal SIMPLIFY_CAST(register unsigned int expr,unsigned int flags,
    unsigned int mode)
{
    unsigned int type,kind;
    unsigned char value[10];
    unsigned int old;

    old=0;
    EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),flags,mode);
    if (EXPR_W(expr,EXPR_LEFT)==0) {
        FREE_EXPR_NODE(expr);
        expr=0;
    } else if (EXPR_W(expr,EXPR_TYPE)==EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_TYPE) || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==0) {
        /* Documented exception (no-op before the goto): the original jumps
           from here into the identical copy below (054D jmp 05B3) through a
           jump of its own; without the no-op BC folds the goto into the je. */
        (void)0;
        goto take_operand;
    } else {
        type=TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND);
        kind=EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP);
        if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3) {
            if ((EXPR_FLAGS[type]&1) && kind==2) {
                old=expr;
                expr=EXPR_W(expr,EXPR_LEFT);
                EXPR_L(expr,EXPR_VALUE)=TOKEN_CONVERT(EXPR_L(expr,EXPR_VALUE),type);
            } else if ((EXPR_FLAGS[type]&2) && kind==3) {
            take_operand:
                old=expr;
                expr=EXPR_W(expr,EXPR_LEFT);
            } else if ((EXPR_FLAGS[type]&1) && kind==3) {
                old=expr;
                expr=EXPR_W(old,EXPR_LEFT);
                EXPR_W(expr,EXPR_OP)=EOP_CONST;
                RTL_MEMMOVE(value,MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),10);
                EXPR_L(expr,EXPR_VALUE)=(EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20) ?
                    RTL_LDOUBLE_TO_ULONG(value) : RTL_LDOUBLE_TO_LONG(value);
                EXPR_L(expr,EXPR_VALUE)=TOKEN_CONVERT(EXPR_L(expr,EXPR_VALUE),type);
            } else if ((EXPR_FLAGS[type]&2) && kind==2) {
                old=expr;
                expr=EXPR_W(old,EXPR_LEFT);
                EXPR_W(expr,EXPR_OP)=3;
                if (EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20)
                    RTL_ULONG_TO_LDOUBLE(EXPR_L(expr,EXPR_VALUE),value);
                else
                    RTL_LONG_TO_LDOUBLE(EXPR_L(expr,EXPR_VALUE),value);
                RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),value,10);
            } else if ((EXPR_FLAGS[type]&0x15) && kind==2 &&
                    TYPE_SIZE(EXPR_W(expr,EXPR_TYPE))==TYPE_SIZE(EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_TYPE))) {
                old=expr;
                expr=EXPR_W(old,EXPR_LEFT);
            }
        } else if (!((EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x14) &&
                    TYPE_W(TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_FUNCTION && kind==0x32) &&
                (EXPR_FLAGS[type]&0x14) && TYPE_W(EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==type) {
            old=expr;
            expr=EXPR_W(old,EXPR_LEFT);
        }
    }
    if (old) {
        EXPR_W(expr,EXPR_TYPE)=EXPR_W(old,EXPR_TYPE);
        FREE_EXPR_NODE(old);
    }
    return expr;
}

/* ---- SIMPLIFY_NOT (listing 7B1C) ---- */
/* row SIMPLIFY_NOT (offset 0x79C): stub none (static) = SIMPLIFY_NOT */

/* SIMPLIFY_NOT: !constant becomes 0 or 1; !(a op b) for a comparison becomes the
   opposite comparison (COMPARE_NEGATION_TABLE), and !(x != 0) for x smaller than long
   becomes !x. */
static unsigned int near pascal SIMPLIFY_NOT(unsigned int expr)
{
    int kind;
    unsigned int child;

    child=EXPR_W(expr,EXPR_LEFT);
    switch (CONSTANT_TRUTH_VALUE(child)) {
    case 0:
        return REPLACE_WITH_INT_CONSTANT(1L,expr);
    case 1:
        return REPLACE_WITH_INT_CONSTANT(0L,expr);
    }
    kind=EXPR_W(child,EXPR_OP);
    if (kind>=0x1D && kind<=0x22) {
        if (kind==0x1E && (int)TYPE_W(EXPR_W(EXPR_W(child,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)<TK_LONG &&
            EXPR_W(EXPR_W(child,EXPR_RIGHT),EXPR_OP)==EOP_CONST && EXPR_L(EXPR_W(child,EXPR_RIGHT),EXPR_VALUE)==0) {
            EXPR_W(expr,EXPR_LEFT)=EXPR_W(child,EXPR_LEFT);
            FREE_EXPR_NODE(EXPR_W(child,EXPR_RIGHT));
            FREE_EXPR_NODE(child);
        } else {
            FREE_EXPR_NODE(expr);
            EXPR_W(child,EXPR_OP)=COMPARE_NEGATION_TABLE[EXPR_W(child,EXPR_OP)];
            expr=child;
        }
    }
    return expr;
}

/* ---- SIMPLIFY_UNARY (listing 7BD9) ---- */
/* row SIMPLIFY_UNARY (offset 0x859): stub none (static) = SIMPLIFY_UNARY */

/* SIMPLIFY_UNARY: simplifies a unary node. The operand of &, ++ and -- counts as read
   and written (flags 6), except a function under &. In a discarded position (mode 0) *p
   and &x reduce to p and x, and x++ / x-- become ++x / --x (node flag 2 cleared).
   Otherwise *&x and &*p cancel, -constant, ~constant and --x fold, unary plus
   disappears, and ! goes to SIMPLIFY_NOT. */
static unsigned int near pascal SIMPLIFY_UNARY(unsigned int expr,unsigned int flags,
    unsigned int mode)
{
    unsigned int old=0;
    unsigned int level=1;
    unsigned int child;

    if (EXPR_W(expr,EXPR_OP)==EOP_ADDR && mode==2)
        level=2;
    if (EXPR_W(expr,EXPR_OP)==EOP_DEREF && EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)!=0x35)
        child=EXPR_W(expr,EXPR_LEFT);
    else {
        unsigned int want;

        want=4;
        if (EXPR_W(expr,EXPR_OP)==EOP_ADDR || EXPR_W(expr,EXPR_OP)==EOP_INC || EXPR_W(expr,EXPR_OP)==EOP_DEC) {
            if ((EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x14)==0 ||
                TYPE_W(TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)!=TK_FUNCTION)
                want=6;
        } else if (mode==0)
            want=0;
        child=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),want,level);
    }
    if (EXPR_W(child,EXPR_OP)==0) {
        old=expr;
        expr=child;
    } else {
        EXPR_W(expr,EXPR_LEFT)=child;
        switch (EXPR_W(expr,EXPR_OP)) {
        case EOP_DEREF:
            if (mode==0) {
                FREE_EXPR_NODE(expr);
                expr=SIMPLIFY_NODE(child,0,mode);
            } else if (EXPR_W(child,EXPR_OP)==EOP_ADDR) {
                old=expr;
                expr=EXPR_W(child,EXPR_LEFT);
                FREE_EXPR_NODE(child);
                expr=SIMPLIFY_NODE(expr,flags,mode);
            } else {
                EXPR_W(expr,EXPR_LEFT)=child=SIMPLIFY_NODE(child,4,mode);
                if (EXPR_W(child,EXPR_OP)==EOP_ADDR) {
                    old=expr;
                    expr=EXPR_W(child,EXPR_LEFT);
                    FREE_EXPR_NODE(child);
                }
            }
            break;
        case EOP_ADDR:
            if (mode==0) {
                FREE_EXPR_NODE(expr);
                expr=child;
            } else if (EXPR_W(child,EXPR_OP)==EOP_DEREF) {
                old=expr;
                expr=EXPR_W(child,EXPR_LEFT);
                FREE_EXPR_NODE(child);
            }
            break;
        case EOP_INC:
        case EOP_DEC:
            if (mode==0)
                EXPR_B(expr,EXPR_NODE_FLAGS)&=0xFD;
            break;
        case EOP_NEG:
            if (EXPR_W(child,EXPR_OP)==EOP_CONST || EXPR_W(child,EXPR_OP)==3) {
                old=expr;
                expr=child;
                NEGATE_CONSTANT(expr);
            } else if (EXPR_W(child,EXPR_OP)==EOP_NEG) {
                FREE_EXPR_NODE(expr);
                expr=EXPR_W(child,EXPR_LEFT);
                old=child;
            }
            break;
        case EOP_COMPL:
            if (EXPR_W(child,EXPR_OP)==EOP_CONST) {
                old=expr;
                expr=child;
                EXPR_L(expr,EXPR_VALUE)=TOKEN_CONVERT(~EXPR_L(expr,EXPR_VALUE),TYPE_W(EXPR_W(old,EXPR_TYPE),TYPE_KIND));
            }
            break;
        case 0x49:
            old=expr;
            expr=child;
            break;
        case EOP_NOT:
            expr=SIMPLIFY_NOT(expr);
            break;
        }
        if (old)
            EXPR_W(expr,EXPR_TYPE)=EXPR_W(old,EXPR_TYPE);
    }
    if (old)
        FREE_EXPR_NODE(old);
    return expr;
}

/* ---- APPLY_CONSTANT_OP (listing 7E38) ---- */
/* row APPLY_CONSTANT_OP (offset 0xAB8): stub none (static) = APPLY_CONSTANT_OP */
extern unsigned int far pascal MAKE_REAL_CONSTANT(unsigned int,C40RealStorage far *);

/* APPLY_CONSTANT_OP: computes left op right for two constants of the same sort and
   returns a new constant of type: integers with unsigned_op or signed_op (by the
   signedness of type) and truncated to type, floating values with real_op. Frees both
   operands. */
static unsigned int near pascal APPLY_CONSTANT_OP(unsigned int left,unsigned int right,
    unsigned int type,long (far pascal *unsigned_op)(long,long),
    long (far pascal *signed_op)(long,long),
    void (far pascal *real_op)(void far *,void far *))
{
    long value;
    unsigned char left_value[10];
    unsigned char right_value[10];
    unsigned int result;

    if (EXPR_W(left,EXPR_OP)==EOP_CONST) {
        value=(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x20) ?
            (*unsigned_op)(EXPR_L(left,EXPR_VALUE),EXPR_L(right,EXPR_VALUE)) :
            (*signed_op)(EXPR_L(left,EXPR_VALUE),EXPR_L(right,EXPR_VALUE));
        result=MAKE_INT_CONSTANT(type,TOKEN_CONVERT(value,TYPE_W(type,TYPE_KIND)));
    } else {
        RTL_MEMMOVE(left_value,MK_FP(EXPR_POOL_SEG,left+EXPR_LEFT),10);
        RTL_MEMMOVE(right_value,MK_FP(EXPR_POOL_SEG,right+EXPR_LEFT),10);
        (*real_op)(left_value,right_value);
        result=MAKE_REAL_CONSTANT(type,(C40RealStorage far *)left_value);
    }
    FREE_EXPR_NODE(right);
    FREE_EXPR_NODE(left);
    return result;
}

/* ---- FOLD_CONSTANT_OPERANDS (listing 7F1D) ---- */
/* row FOLD_CONSTANT_OPERANDS (offset 0xB9D): stub none (static) = FOLD_CONSTANT_OPERANDS */

/* FOLD_CONSTANT_OPERANDS: when both operands of expr are constants of the same sort,
   replaces expr by the folded constant (APPLY_CONSTANT_OP). */
static unsigned int near pascal FOLD_CONSTANT_OPERANDS(unsigned int expr,
    long (far pascal *unsigned_op)(long,long),
    long (far pascal *signed_op)(long,long),
    void (far pascal *real_op)(void far *,void far *))
{
    unsigned int old;
    unsigned int left;
    unsigned int right;

    left=EXPR_W(expr,EXPR_LEFT);
    right=EXPR_W(expr,EXPR_RIGHT);
    if (EXPR_W(left,EXPR_OP)==EXPR_W(right,EXPR_OP)) {
        old=expr;
        expr=APPLY_CONSTANT_OP(left,right,EXPR_W(expr,EXPR_TYPE),unsigned_op,signed_op,real_op);
        FREE_EXPR_NODE(old);
    }
    return expr;
}

/* ---- SIMPLIFY_MEMBER (listing 7F78) ---- */
/* row SIMPLIFY_MEMBER (offset 0xBF8): stub none (static) = SIMPLIFY_MEMBER */
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_DEREFERENCE(unsigned int);

/* SIMPLIFY_MEMBER: object.member after its operands were simplified. For a variable the
   member offset is added to the symbol leaf's offset; otherwise the member is reached
   as *(&object + offset), with a long offset through a huge pointer (variable
   far_ptr) and the far-pointer form 0x2D through a _seg pointer (variable near_ptr; both
   names say less than the tests). A ?:, = or 0x48 object is used through its address.
   A bitfield member keeps its member node, with the offset now 0. A member node naming
   a symbol (operator 1) is turned into a silent error. */
static unsigned int near pascal SIMPLIFY_MEMBER(unsigned int expr,unsigned int mode)
{
    unsigned int right;
    unsigned char direct;
    unsigned char near_ptr;
    unsigned char far_ptr;
    unsigned int left;
    unsigned int temp;

    left=EXPR_W(expr,EXPR_LEFT);
    right=EXPR_W(expr,EXPR_RIGHT);
    if (EXPR_W(right,EXPR_OP)==1)
        return REPORT_EXPR_ERROR_PLAIN(0,expr);
    direct=EXPR_W(left,EXPR_OP)==EOP_QUESTION || EXPR_W(left,EXPR_OP)==EOP_ASSIGN || EXPR_W(left,EXPR_OP)==0x48;
    near_ptr=EXPR_W(left,EXPR_OP)==EOP_DEREF && TYPE_W(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_SEG_PTR;
    far_ptr=EXPR_W(left,EXPR_OP)==EOP_DEREF && TYPE_W(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_HUGE_PTR;
    if (EXPR_W(left,EXPR_OP)==1)
        EXPR_W(left,EXPR_RIGHT)+=EXPR_W(right,EXPR_LEFT);
    else if (EXPR_W(right,EXPR_LEFT)!=0 || near_ptr || direct) {
        temp=MAKE_ADDRESS_OF(left);
        if (!direct) {
            temp=MAKE_BINARY_NODE(0x16,temp,
                MAKE_INT_CONSTANT(far_ptr ? LONG_TYPE : SIZE_T_TYPE,EXPR_W(right,EXPR_LEFT)));
            EXPR_W(temp,EXPR_TYPE)=EXPR_W(EXPR_W(temp,EXPR_LEFT),EXPR_TYPE);
            if (near_ptr) {
                EXPR_W(temp,EXPR_OP)=0x2D;
                EXPR_W(temp,EXPR_TYPE)=MAKE_POINTER_TYPE(TYPE_W(EXPR_W(temp,EXPR_TYPE),TYPE_TARGET),0x0F,0);
            }
            EXPR_B(temp,EXPR_NODE_FLAGS)=1;
            left=SIMPLIFY_NODE(MAKE_DEREFERENCE(temp),mode==0 ? 0 : 4,mode);
        } else {
            left=MAKE_ADDRESS_OF(temp);
            EXPR_B(left,EXPR_NODE_FLAGS)=1;
        }
    }
    EXPR_W(left,EXPR_TYPE)=EXPR_W(expr,EXPR_TYPE);
    if (EXPR_B(right,EXPR_NODE_FLAGS)&4) {
        EXPR_W(right,EXPR_LEFT)=0;
        EXPR_W(expr,EXPR_LEFT)=left;
    } else {
        FREE_EXPR_NODE(right);
        FREE_EXPR_NODE(expr);
        expr=left;
    }
    return expr;
}

/* ---- SIMPLIFY_MULTIPLY (listing 8149) ---- */
/* row SIMPLIFY_MULTIPLY (offset 0xDC9): stub none (static) = SIMPLIFY_MULTIPLY */
extern unsigned int far *BCC_TYPE_PTR;
extern C40RealStorage near  REAL_ONE;   /* 1.0 */
extern C40RealStorage near  REAL_MINUS_ONE;     /* -1.0 */
extern long (far pascal *FOLD_MUL_SIGNED_FN)(long,long);
extern long (far pascal *FOLD_MUL_UNSIGNED_FN)(long,long);
extern void (far pascal *REAL_MUL_FN)(void far *,void far *);
extern unsigned int far pascal SWAP_OPERANDS(unsigned int);

/* SIMPLIFY_MULTIPLY: constants are moved right and folded; x * 0.0 / 1.0 / -1.0,
   x * 0, x * 1, x * -c (as -(x * c) when c is a power of two), x * 2^n as x << n. In
   an object context (mode 2, probably array indexing) (x + c) * k becomes x * k + c*k
   so the constant part can join the address offset. */
static unsigned int near pascal SIMPLIFY_MULTIPLY(unsigned int expr,unsigned int mode)
{
    unsigned int right;
    long value;
    unsigned int left;
    unsigned char negate;
    unsigned char single;
    int shift;
    unsigned int old;
    unsigned char nested;
    unsigned char real[10];
    unsigned int constant;

    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=SWAP_OPERANDS(expr);
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_MUL_UNSIGNED_FN,FOLD_MUL_SIGNED_FN,REAL_MUL_FN);
    else if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==3) {
        right=EXPR_W(expr,EXPR_RIGHT);
        if (EXPR_W(right,EXPR_OP)==3) {
            RTL_MEMMOVE(real,MK_FP(EXPR_POOL_SEG,right+EXPR_LEFT),10);
            if (RTL_LDOUBLE_COMPARE(real,&REAL_ZERO)==0) {
                old=MAKE_REAL_CONSTANT(EXPR_W(expr,EXPR_TYPE),&REAL_ZERO);
                FREE_EXPR_TREE(expr);
                expr=old;
            } else if (RTL_LDOUBLE_COMPARE(real,&REAL_ONE)==0)
                expr=REPLACE_WITH_LEFT(expr);
            else if (RTL_LDOUBLE_COMPARE(real,&REAL_MINUS_ONE)==0)
                expr=WRAP_IN_UNARY_NODE(0x2E,REPLACE_WITH_LEFT(expr));
        } else if (EXPR_W(right,EXPR_OP)==EOP_CONST) {
            left=EXPR_W(expr,EXPR_LEFT);
            nested=EXPR_W(left,EXPR_OP)==EOP_ADD && EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_OP)==EOP_CONST;
            value=EXPR_L(right,EXPR_VALUE);
            if (nested && mode==2) {
                constant=EXPR_W(expr,EXPR_RIGHT);
                old=expr;
                expr=EXPR_W(expr,EXPR_LEFT);
                EXPR_W(old,EXPR_LEFT)=EXPR_W(expr,EXPR_LEFT);
                if(EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20)
                    EXPR_L(constant,EXPR_VALUE)=FOLD_MUL_UNSIGNED(value,EXPR_L(constant,EXPR_VALUE));
                else
                    EXPR_L(constant,EXPR_VALUE)=FOLD_MUL_SIGNED(value,EXPR_L(constant,EXPR_VALUE));
                EXPR_L(constant,EXPR_VALUE)=TOKEN_CONVERT(EXPR_L(constant,EXPR_VALUE),TYPE_W(EXPR_W(constant,EXPR_TYPE),TYPE_KIND));
                EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_MULTIPLY(old,mode);
            } else {
                if (value<0 && !(EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20)) {
                    negate=1;
                    value=-value;
                } else
                    negate=0;
                if (value==0)
                    expr=REPLACE_WITH_TYPED_CONSTANT(0L,expr);
                else if (value==1)
                    expr=REPLACE_WITH_LEFT(expr);
                else {
                    POWER_OF_TWO_SHIFT(value,&single,&shift);
                    if (single) {
                        EXPR_W(expr,EXPR_OP)=EOP_SHL;
                        EXPR_W(right,EXPR_TYPE)=BCC_TYPE_PTR[2];
                        EXPR_L(right,EXPR_VALUE)=shift;
                    } else
                        negate=0;
                }
                if (negate)
                    expr=WRAP_IN_UNARY_NODE(0x2E,expr);
            }
        }
    }
    return expr;
}

/* ---- SIMPLIFY_DIVIDE (listing 8433) ---- */
/* row SIMPLIFY_DIVIDE (offset 0x10B3): stub none (static) = SIMPLIFY_DIVIDE */
extern long (far pascal *FOLD_DIV_SIGNED_FN)(long,long);
extern long (far pascal *FOLD_DIV_UNSIGNED_FN)(long,long);
extern void (far pascal *REAL_DIV_FN)(void far *,void far *);

/* SIMPLIFY_DIVIDE: division by a constant: zero is an error for integers; constants
   fold; x / 1 and x / -1 (also 1.0, -1.0); unsigned x / 2^n becomes x >> n. */
static unsigned int near pascal SIMPLIFY_DIVIDE(unsigned int expr)
{
    unsigned char single;
    int shift;
    unsigned char real[10];
    unsigned int right;

    right=EXPR_W(expr,EXPR_RIGHT);
    if (EXPR_W(right,EXPR_OP)==EOP_CONST || EXPR_W(right,EXPR_OP)==3) {
        if (CONSTANT_TRUTH_VALUE(right)==0 && !(EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&2))
            expr=REPORT_EXPR_ERROR_PLAIN(MSG_DIVISION_ZERO,expr);
        else if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
            expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_DIV_UNSIGNED_FN,FOLD_DIV_SIGNED_FN,REAL_DIV_FN);
        else if (EXPR_W(right,EXPR_OP)==3) {
            RTL_MEMMOVE(real,MK_FP(EXPR_POOL_SEG,right+EXPR_LEFT),10);
            if (RTL_LDOUBLE_COMPARE(real,&REAL_ONE)==0)
                expr=REPLACE_WITH_LEFT(expr);
            else if (RTL_LDOUBLE_COMPARE(real,&REAL_MINUS_ONE)==0)
                expr=WRAP_IN_UNARY_NODE(0x2E,REPLACE_WITH_LEFT(expr));
        } else if (EXPR_L(right,EXPR_VALUE)==1)
            expr=REPLACE_WITH_LEFT(expr);
        else if (EXPR_L(right,EXPR_VALUE)==-1)
            expr=WRAP_IN_UNARY_NODE(0x2E,REPLACE_WITH_LEFT(expr));
        else if (EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20) {
            POWER_OF_TWO_SHIFT(EXPR_L(right,EXPR_VALUE),&single,&shift);
            if (single) {
                EXPR_W(expr,EXPR_OP)=EOP_SHR;
                EXPR_L(right,EXPR_VALUE)=shift;
                EXPR_W(right,EXPR_TYPE)=BCC_TYPE_PTR[2];
            }
        }
    }
    return expr;
}

/* ---- SIMPLIFY_MODULO (listing 85BB) ---- */
/* row SIMPLIFY_MODULO (offset 0x123B): stub none (static) = SIMPLIFY_MODULO */
extern long (far pascal *FOLD_MOD_SIGNED_FN)(long,long);
extern long (far pascal *FOLD_MOD_UNSIGNED_FN)(long,long);
extern void (far pascal *NO_REAL_FOLD_FN)(void far *,void far *);

/* SIMPLIFY_MODULO: remainder by a constant: zero is an error; constants fold; x % 1 is
   0; unsigned x % 2^n becomes x & (2^n - 1). */
static unsigned int near pascal SIMPLIFY_MODULO(unsigned int expr)
{
    unsigned char single;
    int shift;
    unsigned int right;

    right=EXPR_W(expr,EXPR_RIGHT);
    if (EXPR_W(right,EXPR_OP)==EOP_CONST || EXPR_W(right,EXPR_OP)==3) {
        if (CONSTANT_TRUTH_VALUE(right)==0)
            expr=REPORT_EXPR_ERROR_PLAIN(MSG_DIVISION_ZERO,expr);
        else if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
            expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_MOD_UNSIGNED_FN,FOLD_MOD_SIGNED_FN,NO_REAL_FOLD_FN);
        else if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST) {
            if (EXPR_L(right,EXPR_VALUE)==1)
                expr=REPLACE_WITH_TYPED_CONSTANT(0L,expr);
            else if (EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20) {
                POWER_OF_TWO_SHIFT(EXPR_L(right,EXPR_VALUE),&single,&shift);
                if (single) {
                    EXPR_W(expr,EXPR_OP)=EOP_AND;
                    EXPR_L(right,EXPR_VALUE)-=1;
                }
            }
        }
    }
    return expr;
}

/* ---- BOTH_SAME_KIND_CONSTANT (listing 86A7) ---- */
/* row BOTH_SAME_KIND_CONSTANT (offset 0x1327): stub none (static) = BOTH_SAME_KIND_CONSTANT */

/* BOTH_SAME_KIND_CONSTANT: 1 when left and right are both integer constants or both
   floating constants. */
static unsigned char near pascal BOTH_SAME_KIND_CONSTANT(unsigned int left,unsigned int right)
{
    return (EXPR_W(left,EXPR_OP)==EOP_CONST || EXPR_W(left,EXPR_OP)==3) && EXPR_W(left,EXPR_OP)==EXPR_W(right,EXPR_OP);
}

/* ---- SIMPLIFY_ADD (listing 86DD) ---- */
/* row SIMPLIFY_ADD (offset 0x135D): stub none (static) = SIMPLIFY_ADD */
extern long (far pascal *FOLD_ADD_SIGNED_FN)(long,long);
extern long (far pascal *FOLD_ADD_UNSIGNED_FN)(long,long);
extern void (far pascal *REAL_ADD_FN)(void far *,void far *);
extern unsigned int far pascal PICK_WIDER_TYPE(unsigned int,unsigned int);

/* SIMPLIFY_ADD: constants are moved right; two constants fold; x + 0 is x; &v + c moves
   c into v's offset. left_offset / right_offset say that an operand has the form
   x + c or c - x with an integer constant of the result's size; such constants are
   gathered: (x + c1) + c2 = x + (c1 + c2), (x + c) + y = (x + y) + c, and
   (x + c1) + (y + c2) = (x + y) + (c1 + c2), so later folding and addressing can use
   one constant. */
static unsigned int near pascal SIMPLIFY_ADD(unsigned int expr)
{
    unsigned int first;
    unsigned int second;
    unsigned char left_offset;
    unsigned char right_offset;
    unsigned int type;
    unsigned int temp;
    unsigned int size;
    unsigned int left;
    unsigned int right;

    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=SWAP_OPERANDS(expr);
    left=EXPR_W(expr,EXPR_LEFT);
    right=EXPR_W(expr,EXPR_RIGHT);
    type=EXPR_W(expr,EXPR_TYPE);
    size=(unsigned int)TYPE_SIZE(type);
    left_offset=0;
    right_offset=0;
    if (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&1) {
        if (EXPR_W(left,EXPR_OP)==EOP_ADD)
            left_offset=(EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_TYPE))==size;
        else if (EXPR_W(left,EXPR_OP)==EOP_SUB)
            left_offset=(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_TYPE))==size;
        if (EXPR_W(right,EXPR_OP)==EOP_ADD)
            right_offset=(EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_TYPE))==size;
        else if (EXPR_W(right,EXPR_OP)==EOP_SUB)
            right_offset=(EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_TYPE))==size;
    }
    if (BOTH_SAME_KIND_CONSTANT(left,right)) {
        FREE_EXPR_NODE(expr);
        return APPLY_CONSTANT_OP(left,right,type,FOLD_ADD_UNSIGNED_FN,FOLD_ADD_SIGNED_FN,REAL_ADD_FN);
    }
    if (EXPR_W(right,EXPR_OP)==EOP_CONST || EXPR_W(right,EXPR_OP)==3) {
        if (CONSTANT_TRUTH_VALUE(right)==0)
            return REPLACE_WITH_LEFT(expr);
        if (left_offset) {
            if (EXPR_W(left,EXPR_OP)==EOP_ADD) {
                if (BOTH_SAME_KIND_CONSTANT(EXPR_W(left,EXPR_RIGHT),right)) {
                    EXPR_W(left,EXPR_RIGHT)=APPLY_CONSTANT_OP(EXPR_W(left,EXPR_RIGHT),right,type,
                        FOLD_ADD_UNSIGNED_FN,FOLD_ADD_SIGNED_FN,REAL_ADD_FN);
                    FREE_EXPR_NODE(expr);
                    expr=left;
                }
            } else if (BOTH_SAME_KIND_CONSTANT(EXPR_W(left,EXPR_LEFT),right)) {
                EXPR_W(left,EXPR_LEFT)=APPLY_CONSTANT_OP(EXPR_W(left,EXPR_LEFT),right,type,
                    FOLD_ADD_UNSIGNED_FN,FOLD_ADD_SIGNED_FN,REAL_ADD_FN);
                FREE_EXPR_NODE(expr);
                expr=left;
            }
        } else if (EXPR_W(left,EXPR_OP)==EOP_ADDR && EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==1) {
            EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_RIGHT)+=EXPR_W(right,EXPR_LEFT);
            FREE_EXPR_NODE(expr);
            FREE_EXPR_NODE(right);
            expr=left;
        }
    } else if (left_offset!=right_offset) {
        if (right_offset)
            expr=SWAP_OPERANDS(expr);
        temp=EXPR_W(expr,EXPR_RIGHT);
        if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_ADD) {
            EXPR_W(expr,EXPR_RIGHT)=EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_RIGHT);
            EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_RIGHT)=temp;
        } else {
            EXPR_W(expr,EXPR_RIGHT)=EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_LEFT);
            EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_LEFT)=temp;
        }
    } else if (left_offset && right_offset) {
        first=EXPR_W(left,EXPR_OP)==EOP_SUB ? EXPR_W(left,EXPR_LEFT) : EXPR_W(left,EXPR_RIGHT);
        second=EXPR_W(right,EXPR_OP)==EOP_SUB ? EXPR_W(right,EXPR_LEFT) : EXPR_W(right,EXPR_RIGHT);
        if (BOTH_SAME_KIND_CONSTANT(first,second)) {
            temp=APPLY_CONSTANT_OP(first,second,PICK_WIDER_TYPE(EXPR_W(first,EXPR_TYPE),EXPR_W(second,EXPR_TYPE)),
                FOLD_ADD_UNSIGNED_FN,FOLD_ADD_SIGNED_FN,REAL_ADD_FN);
            if (EXPR_W(left,EXPR_OP)==EOP_SUB && EXPR_W(right,EXPR_OP)==EOP_SUB) {
                EXPR_W(right,EXPR_LEFT)=EXPR_W(left,EXPR_RIGHT);
                EXPR_W(right,EXPR_OP)=EOP_ADD;
                FREE_EXPR_NODE(EXPR_W(expr,EXPR_LEFT));
                EXPR_W(expr,EXPR_LEFT)=temp;
                EXPR_W(expr,EXPR_OP)=EOP_SUB;
            } else {
                if (EXPR_W(left,EXPR_OP)==EOP_ADD) {
                    if(EXPR_W(right,EXPR_OP)==EOP_ADD)
                        EXPR_W(left,EXPR_RIGHT)=EXPR_W(right,EXPR_LEFT);
                    else
                        EXPR_W(left,EXPR_RIGHT)=EXPR_W(right,EXPR_RIGHT);
                    EXPR_W(left,EXPR_OP)=EXPR_W(right,EXPR_OP);
                } else
                    EXPR_W(left,EXPR_LEFT)=EXPR_W(right,EXPR_LEFT);
                FREE_EXPR_NODE(right);
                EXPR_W(expr,EXPR_RIGHT)=temp;
            }
        }
    }
    return expr;
}

/* ---- FOLD_FAR_POINTER_CONSTANT (listing 8B84) ---- */
/* row FOLD_FAR_POINTER_CONSTANT (offset 0x1804): stub none (static) = FOLD_FAR_POINTER_CONSTANT */

/* FOLD_FAR_POINTER_CONSTANT: segment:offset (operator 0x2D) of two constants becomes
   one 32-bit constant (segment in the high word). */
static unsigned int near pascal FOLD_FAR_POINTER_CONSTANT(unsigned int expr)
{
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST && EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST)
        return REPLACE_WITH_TYPED_CONSTANT(((unsigned long)EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_LEFT)<<16)+
            EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE),expr);
    return expr;
}

/* ---- SIMPLIFY_SUBTRACT (listing 8BCA) ---- */
/* row SIMPLIFY_SUBTRACT (offset 0x184A): stub none (static) = SIMPLIFY_SUBTRACT */
extern long (far pascal *FOLD_SUB_SIGNED_FN)(long,long);
extern long (far pascal *FOLD_SUB_UNSIGNED_FN)(long,long);
extern void (far pascal *REAL_SUB_FN)(void far *,void far *);

/* SIMPLIFY_SUBTRACT: x - c becomes x + (-c) and goes to SIMPLIFY_ADD; constants hidden
   in x + c / c - x operands are pulled out as in SIMPLIFY_ADD; c - (x + c2) folds to
   (c - c2) - x; 0 - x becomes -x. */
static unsigned int near pascal SIMPLIFY_SUBTRACT(unsigned int expr)
{
    unsigned char left_const;
    unsigned char right_const;
    unsigned char left_offset;
    unsigned char right_offset;
    unsigned int right_part;
    unsigned int left_part;
    unsigned int temp;
    unsigned int size;
    unsigned int left;
    unsigned int right;

    left=EXPR_W(expr,EXPR_LEFT);
    right=EXPR_W(expr,EXPR_RIGHT);
    left_const=EXPR_W(left,EXPR_OP)==EOP_CONST || EXPR_W(left,EXPR_OP)==3;
    right_const=EXPR_W(right,EXPR_OP)==EOP_CONST || EXPR_W(right,EXPR_OP)==3;
    size=(unsigned int)TYPE_SIZE(EXPR_W(expr,EXPR_TYPE));
    left_offset=0;
    right_offset=0;
    if ((EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&1) && (EXPR_FLAGS[TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND)]&1) &&
        (EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&1)) {
        if (EXPR_W(left,EXPR_OP)==EOP_ADD)
            left_offset=(EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(left,EXPR_RIGHT),EXPR_TYPE))==size;
        else if (EXPR_W(left,EXPR_OP)==EOP_SUB)
            left_offset=(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(left,EXPR_LEFT),EXPR_TYPE))==size;
        if (EXPR_W(right,EXPR_OP)==EOP_ADD)
            right_offset=(EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(right,EXPR_RIGHT),EXPR_TYPE))==size;
        else if (EXPR_W(right,EXPR_OP)==EOP_SUB)
            right_offset=(EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_OP)==3) &&
                (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&1) &&
                (unsigned int)TYPE_SIZE(EXPR_W(EXPR_W(right,EXPR_LEFT),EXPR_TYPE))==size;
    }
    if ((right_offset && !left_const) || (left_offset && !right_const)) {
        if (right_offset) {
            if (EXPR_W(right,EXPR_OP)==EOP_SUB) {
                temp=EXPR_W(right,EXPR_LEFT);
                EXPR_W(right,EXPR_LEFT)=left;
                EXPR_W(right,EXPR_OP)=EOP_ADD;
            } else {
                temp=EXPR_W(right,EXPR_RIGHT);
                EXPR_W(right,EXPR_RIGHT)=left;
                EXPR_W(right,EXPR_OP)=EOP_SUB;
                EXPR_W(expr,EXPR_RIGHT)=SWAP_OPERANDS(right);
            }
            EXPR_W(expr,EXPR_RIGHT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_RIGHT),0,1);
            EXPR_W(expr,EXPR_LEFT)=temp;
            expr=SWAP_OPERANDS(expr);
            right_const=1;
            right_offset=0;
            NEGATE_CONSTANT(temp);
            EXPR_W(expr,EXPR_OP)=EOP_ADD;
        } else {
            if (EXPR_W(left,EXPR_OP)==EOP_SUB) {
                temp=EXPR_W(left,EXPR_LEFT);
                EXPR_W(left,EXPR_LEFT)=right;
                EXPR_W(left,EXPR_OP)=EOP_ADD;
                EXPR_W(expr,EXPR_RIGHT)=temp;
                expr=SWAP_OPERANDS(expr);
            } else {
                temp=EXPR_W(left,EXPR_RIGHT);
                EXPR_W(left,EXPR_RIGHT)=right;
                EXPR_W(left,EXPR_OP)=EOP_SUB;
                EXPR_W(expr,EXPR_RIGHT)=temp;
                EXPR_W(expr,EXPR_OP)=EOP_ADD;
                right_const=1;
            }
            left_offset=0;
        }
    } else if (right_const) {
        NEGATE_CONSTANT(right);
        EXPR_W(expr,EXPR_OP)=EOP_ADD;
    }
    if (right_const && EXPR_W(expr,EXPR_OP)==EOP_ADD)
        expr=SIMPLIFY_ADD(expr);
    else if (left_const) {
        if (right_offset) {
            if (EXPR_W(right,EXPR_OP)==EOP_ADD) {
                right_part=EXPR_W(right,EXPR_RIGHT);
                EXPR_W(expr,EXPR_RIGHT)=EXPR_W(right,EXPR_LEFT);
            } else {
                right_part=EXPR_W(right,EXPR_LEFT);
                EXPR_W(expr,EXPR_RIGHT)=EXPR_W(right,EXPR_RIGHT);
                EXPR_W(expr,EXPR_OP)=EOP_ADD;
            }
            EXPR_W(expr,EXPR_LEFT)=APPLY_CONSTANT_OP(left,right_part,
                PICK_WIDER_TYPE(EXPR_W(left,EXPR_TYPE),EXPR_W(right_part,EXPR_TYPE)),
                FOLD_SUB_UNSIGNED_FN,FOLD_SUB_SIGNED_FN,REAL_SUB_FN);
            FREE_EXPR_NODE(right);
            if (EXPR_W(expr,EXPR_OP)==EOP_ADD)
                expr=SWAP_OPERANDS(expr);
        } else if (CONSTANT_TRUTH_VALUE(left)==0) {
            FREE_EXPR_NODE(left);
            FREE_EXPR_NODE(expr);
            expr=WRAP_IN_UNARY_NODE(0x2E,right);
        }
    } else if (left_offset && right_offset) {
        left_part=EXPR_W(left,EXPR_OP)==EOP_SUB ? EXPR_W(left,EXPR_LEFT) : EXPR_W(left,EXPR_RIGHT);
        right_part=EXPR_W(right,EXPR_OP)==EOP_SUB ? EXPR_W(right,EXPR_LEFT) : EXPR_W(right,EXPR_RIGHT);
        if (BOTH_SAME_KIND_CONSTANT(left_part,right_part)) {
            temp=APPLY_CONSTANT_OP(left_part,right_part,
                PICK_WIDER_TYPE(EXPR_W(left_part,EXPR_TYPE),EXPR_W(right_part,EXPR_TYPE)),
                FOLD_SUB_UNSIGNED_FN,FOLD_SUB_SIGNED_FN,REAL_SUB_FN);
            if (EXPR_W(left,EXPR_OP)==EOP_SUB) {
                if (EXPR_W(right,EXPR_OP)==EOP_ADD)
                    EXPR_W(right,EXPR_RIGHT)=EXPR_W(left,EXPR_RIGHT);
                else
                    EXPR_W(right,EXPR_LEFT)=EXPR_W(left,EXPR_RIGHT);
                FREE_EXPR_NODE(left);
                EXPR_W(expr,EXPR_LEFT)=temp;
            } else {
                EXPR_W(expr,EXPR_OP)=EOP_ADD;
                if (EXPR_W(right,EXPR_OP)==EOP_ADD) {
                    EXPR_W(left,EXPR_RIGHT)=EXPR_W(right,EXPR_LEFT);
                    EXPR_W(left,EXPR_OP)=EOP_SUB;
                } else
                    EXPR_W(left,EXPR_RIGHT)=EXPR_W(right,EXPR_RIGHT);
                NEGATE_CONSTANT(temp);
            }
            FREE_EXPR_NODE(right);
            EXPR_W(expr,EXPR_RIGHT)=temp;
        }
    }
    return expr;
}

/* ---- SIMPLIFY_AND (listing 9106) ---- */
/* row SIMPLIFY_AND (offset 0x1D86): stub none (static) = SIMPLIFY_AND */
extern long (far pascal *FOLD_AND_LONG_FN)(long,long);

/* SIMPLIFY_AND: constants fold; x & 0 is 0, x & -1 is x. */
static unsigned int near pascal SIMPLIFY_AND(unsigned int expr)
{
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=SWAP_OPERANDS(expr);
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_AND_LONG_FN,FOLD_AND_LONG_FN,NO_REAL_FOLD_FN);
    else if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST) {
        if (EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)==0)
            expr=REPLACE_WITH_TYPED_CONSTANT(0L,expr);
        else if (EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)==-1)
            expr=REPLACE_WITH_LEFT(expr);
    }
    return expr;
}

/* ---- SIMPLIFY_OR (listing 91B0) ---- */
/* row SIMPLIFY_OR (offset 0x1E30): stub none (static) = SIMPLIFY_OR */
extern long (far pascal *FOLD_OR_LONG_FN)(long,long);

/* SIMPLIFY_OR: constants fold; x | 0 is x, x | -1 is -1. */
static unsigned int near pascal SIMPLIFY_OR(unsigned int expr)
{
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=SWAP_OPERANDS(expr);
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_OR_LONG_FN,FOLD_OR_LONG_FN,NO_REAL_FOLD_FN);
    else if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST) {
        if (EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)==0)
            expr=REPLACE_WITH_LEFT(expr);
        else if (EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)==-1)
            expr=REPLACE_WITH_TYPED_CONSTANT(-1L,expr);
    }
    return expr;
}

/* ---- SIMPLIFY_XOR (listing 925C) ---- */
/* row SIMPLIFY_XOR (offset 0x1EDC): stub none (static) = SIMPLIFY_XOR */
extern long (far pascal *FOLD_XOR_LONG_FN)(long,long);

/* SIMPLIFY_XOR: constants fold; x ^ 0 is x, x ^ -1 is ~x. */
static unsigned int near pascal SIMPLIFY_XOR(unsigned int expr)
{
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=SWAP_OPERANDS(expr);
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3)
        expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_XOR_LONG_FN,FOLD_XOR_LONG_FN,NO_REAL_FOLD_FN);
    else if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST) {
        if (EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)==0)
            expr=REPLACE_WITH_LEFT(expr);
        else if (EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)==-1)
            expr=WRAP_IN_UNARY_NODE(0x2F,REPLACE_WITH_LEFT(expr));
    }
    return expr;
}

/* ---- SIMPLIFY_SHIFT (listing 9308) ---- */
/* row SIMPLIFY_SHIFT (offset 0x1F88): stub none (static) = SIMPLIFY_SHIFT */
extern long (far pascal *FOLD_SHIFT_SIGNED_FN)(long,long);
extern long (far pascal *FOLD_SHIFT_UNSIGNED_FN)(long,long);

/* SIMPLIFY_SHIFT: direction 1 for <<, -1 for >>. Constant operands fold (a right shift
   as a left shift by a negative count). A shift by 0 disappears; a shift by more bits
   than the type has becomes 0 when it is a right shift or the type is unsigned. */
static unsigned int near pascal SIMPLIFY_SHIFT(unsigned int expr,int direction)
{
    unsigned long distance;
    long count;

    if ((EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==3) &&
        (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST || EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==3)) {
        if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST)
            EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE)=direction*EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE);
        expr=FOLD_CONSTANT_OPERANDS(expr,FOLD_SHIFT_UNSIGNED_FN,FOLD_SHIFT_SIGNED_FN,NO_REAL_FOLD_FN);
    } else if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST) {
        count=EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE);
        distance=count>=0 ? count : -count;
        if (distance==0)
            expr=REPLACE_WITH_LEFT(expr);
        else if ((TYPE_SIZE(EXPR_W(expr,EXPR_TYPE))<<3)<distance) {
            if (direction*count<0 || (EXPR_FLAGS[TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)]&0x20))
                expr=REPLACE_WITH_TYPED_CONSTANT(0L,expr);
        }
    }
    return expr;
}

/* ---- CHECK_COMPARE_RANGE (listing 945C) ---- */
/* row CHECK_COMPARE_RANGE (offset 0x20DC): stub none (static) = CHECK_COMPARE_RANGE */
struct Range { long minimum,maximum; };
extern struct Range  TYPE_RANGE_TABLE[];
extern void far pascal REPORT_DIAGNOSTIC_AT(int,long,long,unsigned int,unsigned int);

/* CHECK_COMPARE_RANGE: warns "constant out of range in comparison" when a comparison
   of an integer variable (smaller than long) with a constant is always true or false.
   A constant on the left is handled by swapping the comparison, which is done through
   COMPARE_NEGATE_TABLE: used this way it holds the mirrored operator (a < b as b > a),
   despite its name. */
static void near pascal CHECK_COMPARE_RANGE(unsigned int expr)
{
    long value;
    int op;
    unsigned int low;
    int kind;

    op=EXPR_W(expr,EXPR_OP);
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST) {
        value=EXPR_L(EXPR_W(expr,EXPR_LEFT),EXPR_VALUE);
        kind=TYPE_W(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND);
        op=COMPARE_NEGATE_TABLE[op];
    } else {
        value=EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE);
        kind=TYPE_W(EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_TYPE),TYPE_KIND);
    }
    if (kind<7) {
        if (EXPR_FLAGS[kind]&0x20) {
            low=(unsigned int)value;
            if (low>TYPE_RANGE_TABLE[kind].maximum || (op==0x21 && value==0) ||
                (op==0x22 && low>=TYPE_RANGE_TABLE[kind].maximum))
                REPORT_DIAGNOSTIC_AT(MSG_CONSTANT_OUT_RANGE,0L,0L,EXPR_W(expr,EXPR_SRC_LINE),0);
        } else if (TYPE_RANGE_TABLE[kind].maximum<value || TYPE_RANGE_TABLE[kind].minimum>value ||
            (op==0x21 && TYPE_RANGE_TABLE[kind].minimum==value) ||
            (op==0x22 && TYPE_RANGE_TABLE[kind].maximum==value))
            REPORT_DIAGNOSTIC_AT(MSG_CONSTANT_OUT_RANGE,0L,0L,EXPR_W(expr,EXPR_SRC_LINE),0);
    }
}

/* ---- SIMPLIFY_COMPARISON (listing 95ED) ---- */
/* row SIMPLIFY_COMPARISON (offset 0x226D): stub none (static) = SIMPLIFY_COMPARISON */
extern unsigned char far pascal EXPRESSIONS_EQUAL(unsigned int,unsigned int,unsigned char);

/* SIMPLIFY_COMPARISON: equal is 1 when the comparison holds for equal operands (==, <=,
   >=), sign the result of COMPARE_* that makes it true (-1 for <, 1 for >, 0 for == and
   !=). Checks the constant range, folds comparisons of identical side-effect-free
   operands and of two constants. */
static unsigned int near pascal SIMPLIFY_COMPARISON(unsigned int expr,unsigned char equal,int sign)
{
    int result;
    unsigned char left_value[10];
    unsigned char right_value[10];
    unsigned int left;
    unsigned int right;

    left=EXPR_W(expr,EXPR_LEFT);
    right=EXPR_W(expr,EXPR_RIGHT);
    if (EXPR_W(left,EXPR_OP)==EOP_CONST || EXPR_W(right,EXPR_OP)==EOP_CONST)
        CHECK_COMPARE_RANGE(expr);
    if (EXPRESSIONS_EQUAL(left,right,0))
        return REPLACE_WITH_INT_CONSTANT((long)(int)equal,expr);
    if ((EXPR_W(left,EXPR_OP)==EOP_CONST || EXPR_W(left,EXPR_OP)==3) && EXPR_W(left,EXPR_OP)==EXPR_W(right,EXPR_OP)) {
        if (EXPR_W(left,EXPR_OP)==EOP_CONST) {
            if ((EXPR_FLAGS[TYPE_W(EXPR_W(left,EXPR_TYPE),TYPE_KIND)]&0x20) || (EXPR_FLAGS[TYPE_W(EXPR_W(right,EXPR_TYPE),TYPE_KIND)]&0x20))
                result=COMPARE_UNSIGNED_LONG(EXPR_L(left,EXPR_VALUE),EXPR_L(right,EXPR_VALUE));
            else
                result=COMPARE_SIGNED_LONG(EXPR_L(left,EXPR_VALUE),EXPR_L(right,EXPR_VALUE));
        } else {
            RTL_MEMMOVE(left_value,MK_FP(EXPR_POOL_SEG,left+EXPR_LEFT),10);
            RTL_MEMMOVE(right_value,MK_FP(EXPR_POOL_SEG,right+EXPR_LEFT),10);
            result=RTL_LDOUBLE_COMPARE(left_value,right_value);
        }
        /* The call is written in each branch; BC cross-jumps the shared tail. */
        if (sign==0 && !equal)
            expr=REPLACE_WITH_INT_CONSTANT((long)(result!=0),expr);
        else
            expr=REPLACE_WITH_INT_CONSTANT((long)(result==sign || (result==0 && equal)),expr);
    }
    return expr;
}

/* ---- SIMPLIFY_LOGICAL_AND (listing 974D) ---- */
/* row SIMPLIFY_LOGICAL_AND (offset 0x23CD): stub none (static) = SIMPLIFY_LOGICAL_AND */
extern unsigned char far pascal IS_SIDE_EFFECT_FREE(unsigned int);

/* SIMPLIFY_LOGICAL_AND: simplifies a && b. A false constant left side makes it 0 (the
   right side is not even simplified, so its symbols do not count as used); two
   constants fold to 0 or 1; x && 0 becomes 0, or (x, 0) when x has side effects. */
static unsigned int near pascal SIMPLIFY_LOGICAL_AND(unsigned int expr,unsigned int mode)
{
    unsigned int flags;
    unsigned int result;

    flags=mode==0 ? 0 : 4;
    EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),flags,1);
    if (EXPR_W(expr,EXPR_LEFT) && EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==0) {
        result=EXPR_W(expr,EXPR_LEFT);
        FREE_EXPR_TREE(EXPR_W(expr,EXPR_RIGHT));
        FREE_EXPR_NODE(expr);
        return result;
    }
    if (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_LEFT))==0)
        return REPLACE_WITH_INT_CONSTANT(0L,expr);
    EXPR_W(expr,EXPR_RIGHT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_RIGHT),flags,mode);
    if (EXPR_W(expr,EXPR_RIGHT) && EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==0) {
        result=EXPR_W(expr,EXPR_RIGHT);
        FREE_EXPR_TREE(EXPR_W(result,EXPR_LEFT));
        FREE_EXPR_NODE(expr);
        return result;
    }
    switch (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_LEFT))) {
    case 1:
        switch (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_RIGHT))) {
        case 0:
            expr=REPLACE_WITH_INT_CONSTANT(0L,expr);
            break;
        case 1:
            expr=REPLACE_WITH_INT_CONSTANT(1L,expr);
            break;
        }
        break;
    case 2:
        if (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_RIGHT))==0) {
            if (IS_SIDE_EFFECT_FREE(EXPR_W(expr,EXPR_LEFT)))
                expr=REPLACE_WITH_INT_CONSTANT(0L,expr);
            else {
                EXPR_W(expr,EXPR_OP)=EOP_COMMA;
                EXPR_W(expr,EXPR_RIGHT)=REPLACE_WITH_INT_CONSTANT(0L,EXPR_W(expr,EXPR_RIGHT));
            }
        }
        break;
    }
    return expr;
}

/* ---- SIMPLIFY_LOGICAL_OR (listing 988C) ---- */
/* row SIMPLIFY_LOGICAL_OR (offset 0x250C): stub none (static) = SIMPLIFY_LOGICAL_OR */

/* SIMPLIFY_LOGICAL_OR: the same for a || b with true and false exchanged. */
static unsigned int near pascal SIMPLIFY_LOGICAL_OR(unsigned int expr,unsigned int mode)
{
    unsigned int flags;
    unsigned int result;

    flags=mode==0 ? 0 : 4;
    EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),flags,1);
    if (EXPR_W(expr,EXPR_LEFT) && EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==0) {
        result=EXPR_W(expr,EXPR_LEFT);
        FREE_EXPR_TREE(EXPR_W(expr,EXPR_RIGHT));
        FREE_EXPR_NODE(expr);
        return result;
    }
    if (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_LEFT))==1)
        return REPLACE_WITH_INT_CONSTANT(1L,expr);
    EXPR_W(expr,EXPR_RIGHT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_RIGHT),flags,mode);
    if (EXPR_W(expr,EXPR_RIGHT) && EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==0) {
        result=EXPR_W(expr,EXPR_RIGHT);
        FREE_EXPR_TREE(EXPR_W(result,EXPR_LEFT));
        FREE_EXPR_NODE(expr);
        return result;
    }
    switch (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_LEFT))) {
    case 0:
        switch (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_RIGHT))) {
        case 0:
            expr=REPLACE_WITH_INT_CONSTANT(0L,expr);
            break;
        case 1:
            expr=REPLACE_WITH_INT_CONSTANT(1L,expr);
            break;
        }
        break;
    case 2:
        switch (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_RIGHT))) {
        case 0:
            break;
        case 1:
            if (IS_SIDE_EFFECT_FREE(EXPR_W(expr,EXPR_LEFT)))
                expr=REPLACE_WITH_INT_CONSTANT(1L,expr);
            else {
                EXPR_W(expr,EXPR_OP)=EOP_COMMA;
                EXPR_W(expr,EXPR_RIGHT)=REPLACE_WITH_INT_CONSTANT(1L,EXPR_W(expr,EXPR_RIGHT));
            }
            break;
        case 2:
            break;
        }
        break;
    }
    return expr;
}

/* ---- SIMPLIFY_ASSIGN (listing 99DB) ---- */
/* row SIMPLIFY_ASSIGN (offset 0x265B): stub none (static) = SIMPLIFY_ASSIGN */

/* SIMPLIFY_ASSIGN: x = x is replaced by x. */
static unsigned int near pascal SIMPLIFY_ASSIGN(unsigned int expr)
{
    unsigned int old;

    if (EXPRESSIONS_EQUAL(EXPR_W(expr,EXPR_LEFT),EXPR_W(expr,EXPR_RIGHT),0)) {
        old=expr;
        expr=EXPR_W(old,EXPR_LEFT);
        EXPR_W(old,EXPR_LEFT)=0;
        FREE_EXPR_TREE(old);
    }
    return expr;
}

/* ---- SIMPLIFY_COMMA (listing 9A1B) ---- */
/* row SIMPLIFY_COMMA (offset 0x269B): stub none (static) = SIMPLIFY_COMMA */

/* SIMPLIFY_COMMA: simplifies a chain of commas without recursion, in the same threaded
   stack style as ANALYZE_COMMA_EXPR (expr/COMMAEXP.C): left_stack and right_stack are
   kept in the EXPR_LEFT / EXPR_RIGHT words of the pushed nodes and node flag 0x80 marks
   a node pushed from the right. Left operands are simplified as discarded values; the
   last right operand gets the caller's mode. Commas whose left (or right) part
   disappeared are removed. */
static unsigned int near pascal SIMPLIFY_COMMA(unsigned int expr,unsigned int mode)
{
    unsigned int left_stack;
    unsigned int right_stack;
    int marked;
    unsigned char right_done;
    unsigned char left_done;
    unsigned int child;

    left_stack=0;
    right_stack=0;
    right_done=0;
next_right:
    left_done=0;
next:
    if (!left_done && !right_done) {
        child=EXPR_W(expr,EXPR_LEFT);
        if (child && EXPR_W(child,EXPR_OP)==EOP_COMMA) {
            EXPR_W(expr,EXPR_LEFT)=left_stack;
            left_stack=expr;
            expr=child;
            goto next;
        }
        EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(child,0,0);
    }
    if (!right_done) {
        child=EXPR_W(expr,EXPR_RIGHT);
        if (child && EXPR_W(child,EXPR_OP)==EOP_COMMA) {
            EXPR_W(expr,EXPR_RIGHT)=right_stack;
            right_stack=expr;
            expr=child;
            EXPR_B(expr,EXPR_NODE_FLAGS)|=0x80;
            goto next_right;
        }
        EXPR_W(expr,EXPR_RIGHT)=SIMPLIFY_NODE(child,(left_stack && mode) ? 4 : 0,
            left_stack ? 0 : mode);
    }
    marked=EXPR_B(expr,EXPR_NODE_FLAGS)&0x80;
    EXPR_B(expr,EXPR_NODE_FLAGS)&=0x7F;
    if (EXPR_W(expr,EXPR_LEFT)==0) {
        child=expr;
        expr=EXPR_W(expr,EXPR_RIGHT);
        FREE_EXPR_NODE(child);
    } else if (EXPR_W(expr,EXPR_RIGHT)==0) {
        child=expr;
        expr=EXPR_W(expr,EXPR_LEFT);
        FREE_EXPR_NODE(child);
    }
    if (marked) {
        unsigned int parent=right_stack;
        right_stack=EXPR_W(parent,EXPR_RIGHT);
        EXPR_W(parent,EXPR_RIGHT)=expr;
        expr=parent;
        right_done=1;
        goto next;
    }
    if (left_stack) {
        unsigned int parent=left_stack;
        left_stack=EXPR_W(parent,EXPR_LEFT);
        EXPR_W(parent,EXPR_LEFT)=expr;
        expr=parent;
        left_done=1;
        right_done=0;
        goto next;
    }
    return expr;
}

/* ---- SIMPLIFY_BINARY (listing 9B6B) ---- */
/* row SIMPLIFY_BINARY (offset 0x27EB): stub none (static) = SIMPLIFY_BINARY */
/* This row also holds MAKE_VOID_ZERO_NODE (offset 0x2A2A, after the switch table), which has no row of its own. */
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);

/* SIMPLIFY_BINARY: simplifies the operands of a binary node and dispatches to the
   operator's rule. "relation" is set for operators with a side effect (EXPR_OP_FLAGS
   bit 1), i.e. assignments, not comparisons as the name suggests: their left operand
   is an object (mode 2) that is read and written (flags 6); for plain = it is only
   written (flags 2 added). The left of "." keeps the caller's mode and flags. An error
   operand makes the node an error node. */
static unsigned int near pascal SIMPLIFY_BINARY(unsigned int expr,unsigned int flags,
    unsigned int mode)
{
    unsigned int level;
    unsigned int want;
    unsigned char relation;
    unsigned int old;

    old=0;
    relation=EXPR_OP_FLAGS[EXPR_W(expr,EXPR_OP)]&1;
    want=(mode==0 && !relation) ? 0 : 4;
    if (EXPR_W(expr,EXPR_OP)==EOP_DOT)
        level=mode;
    else if (relation)
        level=2;
    else
        level=1;
    if (EXPR_W(expr,EXPR_OP)==EOP_ASSIGN)
        flags|=2;
    else if (relation)
        flags=6;
    else if (EXPR_W(expr,EXPR_OP)!=EOP_DOT)
        flags=want;
    EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),flags,level);
    if (EXPR_W(expr,EXPR_OP)==EOP_ANDAND || EXPR_W(expr,EXPR_OP)==EOP_OROR)
        level=mode;
    else
        level=1;
    EXPR_W(expr,EXPR_RIGHT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_RIGHT),want,level);
    if (EXPR_W(expr,EXPR_LEFT) && EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==0) {
        old=expr;
        expr=EXPR_W(old,EXPR_LEFT);
        FREE_EXPR_TREE(EXPR_W(old,EXPR_RIGHT));
    }
    if (EXPR_W(expr,EXPR_OP) && EXPR_W(expr,EXPR_RIGHT) && EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==0) {
        old=expr;
        expr=EXPR_W(old,EXPR_RIGHT);
        FREE_EXPR_TREE(EXPR_W(old,EXPR_LEFT));
    }
    if (EXPR_W(expr,EXPR_OP)) {
        switch (EXPR_W(expr,EXPR_OP)) {
        case EOP_DOT:
            expr=SIMPLIFY_MEMBER(expr,mode);
            break;
        case EOP_MUL:
            expr=SIMPLIFY_MULTIPLY(expr,mode);
            break;
        case EOP_DIV:
            expr=SIMPLIFY_DIVIDE(expr);
            break;
        case EOP_MOD:
            expr=SIMPLIFY_MODULO(expr);
            break;
        case EOP_ADD:
            expr=SIMPLIFY_ADD(expr);
            break;
        case 0x2D:
            expr=FOLD_FAR_POINTER_CONSTANT(expr);
            break;
        case EOP_SUB:
            expr=SIMPLIFY_SUBTRACT(expr);
            break;
        case EOP_AND:
            expr=SIMPLIFY_AND(expr);
            break;
        case EOP_XOR:
            expr=SIMPLIFY_XOR(expr);
            break;
        case EOP_OR:
            expr=SIMPLIFY_OR(expr);
            break;
        case EOP_SHL:
            expr=SIMPLIFY_SHIFT(expr,1);
            break;
        case EOP_SHR:
            expr=SIMPLIFY_SHIFT(expr,-1);
            break;
        case EOP_LT:
            expr=SIMPLIFY_COMPARISON(expr,0,-1);
            break;
        case EOP_GT:
            expr=SIMPLIFY_COMPARISON(expr,0,1);
            break;
        case EOP_LE:
            expr=SIMPLIFY_COMPARISON(expr,1,-1);
            break;
        case EOP_GE:
            expr=SIMPLIFY_COMPARISON(expr,1,1);
            break;
        case EOP_EQ:
            expr=SIMPLIFY_COMPARISON(expr,1,0);
            break;
        case EOP_NE:
            expr=SIMPLIFY_COMPARISON(expr,0,0);
            break;
        case EOP_ASSIGN:
            expr=SIMPLIFY_ASSIGN(expr);
            break;
        }
    }
    if (old)
        FREE_EXPR_NODE(old);
    return expr;
}

/* MAKE_VOID_ZERO_NODE: (void)0, used for a missing arm of ?:. */
static unsigned int near pascal MAKE_VOID_ZERO_NODE(void)
{
    return CONVERT_EXPR_TO_TYPE(VOID_TYPE,MAKE_INT_CONSTANT(INT_TYPE,0L),0);
}

/* ---- SIMPLIFY_CONDITIONAL (listing 9DCD) ---- */
/* row SIMPLIFY_CONDITIONAL (offset 0x2A4D): stub none (static) = SIMPLIFY_CONDITIONAL */

/* SIMPLIFY_CONDITIONAL: c ? a : b. A constant condition keeps only the chosen arm; equal
   arms make it (c, a); in a discarded position both arms become void. Any error makes
   the whole an error node. */
static unsigned int near pascal SIMPLIFY_CONDITIONAL(unsigned int expr,unsigned int mode)
{
    unsigned char invalid;
    unsigned int want;
    unsigned int old;

    want=mode==0 ? 0 : 4;
    EXPR_W(expr,EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(expr,EXPR_LEFT),4,1);
    invalid=EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==0;
    switch (CONSTANT_TRUTH_VALUE(EXPR_W(expr,EXPR_LEFT))) {
    case 0:
        old=expr;
        expr=SIMPLIFY_NODE(EXPR_W(EXPR_W(old,EXPR_RIGHT),EXPR_RIGHT),want,mode);
        EXPR_W(EXPR_W(old,EXPR_RIGHT),EXPR_RIGHT)=0;
        FREE_EXPR_TREE(old);
        break;
    case 1:
        old=expr;
        expr=SIMPLIFY_NODE(EXPR_W(EXPR_W(old,EXPR_RIGHT),EXPR_LEFT),want,mode);
        EXPR_W(EXPR_W(old,EXPR_RIGHT),EXPR_LEFT)=0;
        FREE_EXPR_TREE(old);
        break;
    case 2:
        if (!invalid) {
            EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT)=SIMPLIFY_NODE(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT),want,mode);
            if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT))
                invalid=EXPR_W(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT),EXPR_OP)==0;
            if (!invalid) {
                EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT)=SIMPLIFY_NODE(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT),want,mode);
                if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT))
                    invalid=EXPR_W(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT),EXPR_OP)==0;
            }
            if (!invalid) {
                if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT)==0)
                    EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT)=MAKE_VOID_ZERO_NODE();
                if (EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT)==0)
                    EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT)=MAKE_VOID_ZERO_NODE();
                if (EXPRESSIONS_EQUAL(EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT),EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT),1)) {
                    old=EXPR_W(expr,EXPR_RIGHT);
                    EXPR_W(expr,EXPR_RIGHT)=EXPR_W(old,EXPR_RIGHT);
                    EXPR_W(old,EXPR_RIGHT)=0;
                    EXPR_W(expr,EXPR_OP)=EOP_COMMA;
                    FREE_EXPR_TREE(old);
                    expr=SIMPLIFY_NODE(expr,want,mode);
                } else if (mode==0) {
                    EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(VOID_TYPE,EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_LEFT),0);
                    EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(VOID_TYPE,EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_RIGHT),0);
                    EXPR_W(expr,EXPR_TYPE)=VOID_TYPE;
                }
            }
        }
        break;
    }
    if (invalid)
        expr=REPORT_EXPR_ERROR_PLAIN(0,expr);
    return expr;
}

/* ---- SIMPLIFY_NODE (listing A02F) ---- */
/* row SIMPLIFY_NODE (offset 0x2CAF): stub none (static) = SIMPLIFY_NODE */
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);

/* SIMPLIFY_NODE: the dispatcher (see the overview). Symbol leaves record their use and
   may warn about use before definition (not for storage classes 1, 2, 3, 7 and 10,
   probably the ones that are always initialised, such as statics and functions). In a
   discarded position a side-effect-free result is freed and 0 returned. The stack check
   stops very deep trees with MSG_OUT_MEMORY. */
static unsigned int near pascal SIMPLIFY_NODE(unsigned int expr,unsigned int flags,
    unsigned int mode)
{
    if (_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    if (expr) {
        switch (EXPR_W(expr,EXPR_OP)) {
        case 0x36:
            expr=SIMPLIFY_CALL(expr);
            break;
        case 0x35:
            expr=SIMPLIFY_CAST(expr,flags,mode);
            break;
        case EOP_NEG: case EOP_COMPL: case EOP_NOT: case EOP_DEREF: case EOP_ADDR:
        case EOP_INC: case EOP_DEC: case 0x49:
            expr=SIMPLIFY_UNARY(expr,flags,mode);
            break;
        case EOP_ADD: case EOP_SUB: case EOP_MUL: case EOP_DIV: case EOP_MOD: case EOP_SHL:
        case EOP_SHR: case EOP_AND: case EOP_OR: case EOP_XOR: case EOP_ASSIGN: case EOP_ADD_ASSIGN:
        case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN: case EOP_DIV_ASSIGN: case EOP_MOD_ASSIGN: case EOP_SHL_ASSIGN: case EOP_SHR_ASSIGN:
        case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN: case EOP_EQ: case EOP_NE: case EOP_GT:
        case EOP_LT: case EOP_GE: case EOP_LE: case 0x2B: case 0x2D: case EOP_DOT:
            expr=SIMPLIFY_BINARY(expr,flags,mode);
            break;
        case EOP_ANDAND:
            expr=SIMPLIFY_LOGICAL_AND(expr,mode);
            break;
        case EOP_OROR:
            expr=SIMPLIFY_LOGICAL_OR(expr,mode);
            break;
        case EOP_QUESTION:
            expr=SIMPLIFY_CONDITIONAL(expr,mode);
            break;
        case EOP_COMMA:
            expr=SIMPLIFY_COMMA(expr,mode);
            break;
        case 0x01:
            switch (SYM_B(EXPR_W(expr,EXPR_LEFT),SYM_STORAGE_CLASS)>>3) {
            case 1: case 2: case 3: case 7: case 10:
                break;
            default:
                if (TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)==TK_FUNCTION)
                    flags&=~2;
                SYM_B(EXPR_W(expr,EXPR_LEFT),SYM_FLAGS)|=flags;
                if (LOOP_NEST_FACTOR==1 && (flags&4) && !(SYM_B(EXPR_W(expr,EXPR_LEFT),SYM_FLAGS)&2)) {
                    REPORT_DIAGNOSTIC_AT(MSG_POSSIBLE_USE_BEFORE,(long)SYMBOL_NAME_TEXT(EXPR_W(expr,EXPR_LEFT)),0L,EXPR_W(expr,EXPR_SRC_LINE),EXPR_W(expr,EXPR_SRC_WORD3));
                    SYM_B(EXPR_W(expr,EXPR_LEFT),SYM_FLAGS)|=2;
                }
                break;
            }
            break;
        }
    }
    if (mode==0 && IS_SIDE_EFFECT_FREE(expr)) {
        FREE_EXPR_TREE(expr);
        expr=0;
    }
    return expr;
}

/* ---- SIMPLIFY_EXPRESSION (listing A224) ---- */
/* row X02A_05 (offset 0x2EA4): stub 0C67:0061 = SIMPLIFY_EXPRESSION */

/* SIMPLIFY_EXPRESSION: entry point. mode nonzero: the value is discarded (expression
   statement); 0: the value is used and its symbols count as read. Returns the
   simplified tree, possibly 0 for a discarded side-effect-free expression. */
unsigned int far pascal SIMPLIFY_EXPRESSION(register unsigned int expr,unsigned char mode)
{
    register unsigned int level;

    if(mode) level=0; else level=1;
    expr=SIMPLIFY_NODE(expr,mode ? 0 : 4,level);
    return expr;
}
