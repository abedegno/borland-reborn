/* target: SIMPLIFY */
/* opts: -mm -O -Z -p -y */
/* CPP.EXE module SIMPLIFY (image 0xB465..0xDE21, frame 0B46h): source taken from the
   BCC.EXE reconstruction (bcc20/src/expr/SIMPLIFY.C). CPP.EXE has only
   some of its functions, in the same order; left out here: SIMPLIFY_MEMBER,
   SIMPLIFY_ASSIGN, SIMPLIFY_COMMA. Other CPP.EXE edits (each marked "CPP.EXE edit"
   below): CODE_MASK called directly instead of through TOKEN_CONVERT;
   SIMPLIFY_COMPARISON without the EXPRESSIONS_EQUAL fold; SIMPLIFY_LOGICAL_AND / _OR
   without the IS_SIDE_EFFECT_FREE rewrites; SIMPLIFY_BINARY without the "." and "="
   cases; SIMPLIFY_CONDITIONAL without the equal-arms fold and the void conversion;
   SIMPLIFY_NODE with stack limit 0x7AEC, no "," case and no freeing of
   side-effect-free trees. MAKE_VOID_ZERO_NODE has its own table row in CPP. */
/* Role: tree simplifier and constant arithmetic (SIMPLIFY_*, FOLD_*). Entry points:
   SIMPLIFY_EXPRESSION and the FOLD_* helpers (FOLD_ADD_SIGNED .. FOLD_SHIFT_UNSIGNED,
   COMPARE_SIGNED_LONG, COMPARE_UNSIGNED_LONG). */
/* Overview: the tree simplifier, SIMPLIFY_EXPRESSION, run on analysed expressions
   (0x1A-byte nodes of expr/EXPRPOOL.C). In CPP.EXE its caller is
   EVAL_CONSTANT_CONDITION (CPPIFEXP.C), which folds an #if expression to a constant.
   It walks the tree once (SIMPLIFY_NODE dispatches by operator) and does these jobs at
   the same time:
   1. Constant folding and algebraic simplification: constant operands are computed
      (the FOLD_* helpers below, reached through the function pointers *_FN, with the
      long double helpers for floating constants), and identities are applied: x+0,
      x*1, x*0, x/1, x*-1 = -x, x&0, x|-1, x^-1 = ~x, --x, !!x, *&x and &*x, constant
      conditions in ?:, && and ||, x-c as x+(-c), multiplication and unsigned
      division / remainder by powers of two as shifts and masks, (x+c1)+c2 = x+(c1+c2).
   2. Unused values: "mode" 0 means the value of the subtree is discarded. (BCC's
      version deleted side-effect-free subtrees there; CPP.EXE's does not.)
   3. Use tracking for warnings, kept from BCC: every symbol leaf ORs "flags" into its
      SYM_FLAGS (4 = value read, 2 = value assigned), and a read before any assignment,
      outside loops (LOOP_NEST_FACTOR 1), gives "possible use of 'x' before definition".
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
/* ---- FOLD_ADD_SIGNED (CPP 0B46:0005) ---- */
long far pascal FOLD_ADD_SIGNED(long left,long right)
{
    return left+right;
}

/* ---- FOLD_ADD_UNSIGNED (CPP 0B46:0018) ---- */
unsigned long far pascal FOLD_ADD_UNSIGNED(unsigned long left,unsigned long right)
{
    return left+right;
}

/* ---- FOLD_SUB_SIGNED (CPP 0B46:002B) ---- */
long far pascal FOLD_SUB_SIGNED(long left,long right)
{
    return left-right;
}

/* ---- FOLD_SUB_UNSIGNED (CPP 0B46:003E) ---- */
unsigned long far pascal FOLD_SUB_UNSIGNED(unsigned long left,unsigned long right)
{
    return left-right;
}

/* ---- FOLD_MUL_SIGNED (CPP 0B46:0051) ---- */
long far pascal FOLD_MUL_SIGNED(long left,long right)
{
    return left*right;
}

/* ---- FOLD_MUL_UNSIGNED (CPP 0B46:0069) ---- */
unsigned long far pascal FOLD_MUL_UNSIGNED(unsigned long left,unsigned long right)
{
    return left*right;
}

/* ---- FOLD_DIV_SIGNED (CPP 0B46:0081) ---- */
long far pascal FOLD_DIV_SIGNED(long left,long right)
{
    if (right==0)
        return left;
    return left/right;
}

/* ---- FOLD_DIV_UNSIGNED (CPP 0B46:00A9) ---- */
unsigned long far pascal FOLD_DIV_UNSIGNED(unsigned long left,unsigned long right)
{
    if (right==0)
        return left;
    return left/right;
}

/* ---- FOLD_MOD_SIGNED (CPP 0B46:00D1) ---- */
long far pascal FOLD_MOD_SIGNED(long left,long right)
{
    return left%right;
}

/* ---- FOLD_MOD_UNSIGNED (CPP 0B46:00E9) ---- */
unsigned long far pascal FOLD_MOD_UNSIGNED(unsigned long left,unsigned long right)
{
    if (right==0)
        return 0;
    return left%right;
}

/* ---- FOLD_AND_LONG (CPP 0B46:010F) ---- */
long far pascal FOLD_AND_LONG(long left,long right)
{
    return left&right;
}

/* ---- FOLD_OR_LONG (CPP 0B46:0122) ---- */
long far pascal FOLD_OR_LONG(long left,long right)
{
    return left|right;
}

/* ---- FOLD_XOR_LONG (CPP 0B46:0135) ---- */
long far pascal FOLD_XOR_LONG(long left,long right)
{
    return left^right;
}

/* ---- FOLD_SHIFT_SIGNED (CPP 0B46:0148) ---- */
long far pascal FOLD_SHIFT_SIGNED(long value,long count)
{
    if (count<0)
        return value>>-count;
    return value<<count;
}

/* ---- FOLD_SHIFT_UNSIGNED (CPP 0B46:017D) ---- */
unsigned long far pascal FOLD_SHIFT_UNSIGNED(unsigned long value,long count)
{
    if (count<0)
        return value>>-count;
    return value<<count;
}

/* ---- COMPARE_SIGNED_LONG (CPP 0B46:01B2) ---- */
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

/* ---- COMPARE_UNSIGNED_LONG (CPP 0B46:01E7) ---- */
static int far pascal COMPARE_UNSIGNED_LONG(unsigned long left,unsigned long right)
{
    if (left==right)
        return 0;
    if (left<right)
        return -1;
    return 1;
}

/* ---- NO_REAL_FOLD (CPP 0B46:021C) ---- */
/* NO_REAL_FOLD: the "floating" operation for operators that have none (%, &, |, ^,
   shifts); it leaves the left value unchanged. */
void far pascal NO_REAL_FOLD(long left,long right)
{
}

/* ---- POWER_OF_TWO_SHIFT (CPP 0B46:0223) ---- */
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

/* ---- CONSTANT_TRUTH_VALUE (CPP 0B46:0279) ---- */
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

/* ---- REPLACE_WITH_INT_CONSTANT (CPP 0B46:02FD) ---- */
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

/* ---- REPLACE_WITH_TYPED_CONSTANT (CPP 0B46:0325) ---- */

/* REPLACE_WITH_TYPED_CONSTANT: frees expr and returns a constant value of expr's type. */
static unsigned int near pascal REPLACE_WITH_TYPED_CONSTANT(long value,unsigned int expr)
{
    unsigned int result;

    result=MAKE_INT_CONSTANT(EXPR_W(expr,EXPR_TYPE),value);
    FREE_EXPR_TREE(expr);
    return result;
}

/* ---- REPLACE_WITH_LEFT (CPP 0B46:0354) ---- */
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

/* ---- NEGATE_CONSTANT (CPP 0B46:0381) ---- */
/* CPP.EXE edit: CPP.EXE has no TOKEN_CONVERT pointer; this file calls CODE_MASK
   (expr/TRUNCVAL.C, CPP 0475:0004) directly, pushing the type kind as a byte (mov al,es:[bx]). */
extern long far pascal CODE_MASK(long,unsigned char);

/* NEGATE_CONSTANT: negates an integer or floating constant node in place (for floating
   values by flipping the sign bit of the 10-byte long double). */
static void near pascal NEGATE_CONSTANT(register unsigned int expr)
{
    unsigned int value[5];

    if (EXPR_W(expr,EXPR_OP)==EOP_CONST)
        EXPR_L(expr,EXPR_VALUE)=CODE_MASK(-EXPR_L(expr,EXPR_VALUE),TYPE_W(EXPR_W(expr,EXPR_TYPE),TYPE_KIND));
    else if (EXPR_W(expr,EXPR_OP)==3) {
        RTL_MEMMOVE(value,MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),10);
        value[4]^=0x8000;
        RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,expr+EXPR_LEFT),value,10);
    }
}

/* ---- WRAP_IN_UNARY_NODE (CPP 0B46:040B) ---- */
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

/* ---- SIMPLIFY_CALL (CPP 0B46:0448) ---- */
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

/* ---- SIMPLIFY_CAST (CPP 0B46:04F1) ---- */
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
                EXPR_L(expr,EXPR_VALUE)=CODE_MASK(EXPR_L(expr,EXPR_VALUE),type);
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
                EXPR_L(expr,EXPR_VALUE)=CODE_MASK(EXPR_L(expr,EXPR_VALUE),type);
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

/* ---- SIMPLIFY_NOT (CPP 0B46:0795) ---- */

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
            /* link: BCC's reconstruction names the base COMPARE_NEGATION_TABLE (CPP DS:4FF4,
               inside PREPROC's data); it is COMPARE_NEGATE_TABLE (CPP DS:502E) less 1Dh entries,
               the operator codes starting at 1Dh. Same bytes ([bx+4FF4h]). */
            EXPR_W(child,EXPR_OP)=(COMPARE_NEGATE_TABLE-0x1D)[EXPR_W(child,EXPR_OP)];
            expr=child;
        }
    }
    return expr;
}

/* ---- SIMPLIFY_UNARY (CPP 0B46:0850) ---- */

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
                EXPR_L(expr,EXPR_VALUE)=CODE_MASK(~EXPR_L(expr,EXPR_VALUE),TYPE_W(EXPR_W(old,EXPR_TYPE),TYPE_KIND));
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

/* ---- APPLY_CONSTANT_OP (CPP 0B46:0AAF) ---- */
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
        result=MAKE_INT_CONSTANT(type,CODE_MASK(value,TYPE_W(type,TYPE_KIND)));
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

/* ---- FOLD_CONSTANT_OPERANDS (CPP 0B46:0B94) ---- */

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

/* ---- (BCC's SIMPLIFY_MEMBER: not in CPP.EXE) ---- */
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_DEREFERENCE(unsigned int);


/* ---- SIMPLIFY_MULTIPLY (CPP 0B46:0BED) ---- */
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
                EXPR_L(constant,EXPR_VALUE)=CODE_MASK(EXPR_L(constant,EXPR_VALUE),TYPE_W(EXPR_W(constant,EXPR_TYPE),TYPE_KIND));
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

/* ---- SIMPLIFY_DIVIDE (CPP 0B46:0ED7) ---- */
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

/* ---- SIMPLIFY_MODULO (CPP 0B46:105D) ---- */
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

/* ---- BOTH_SAME_KIND_CONSTANT (CPP 0B46:1147) ---- */

/* BOTH_SAME_KIND_CONSTANT: 1 when left and right are both integer constants or both
   floating constants. */
static unsigned char near pascal BOTH_SAME_KIND_CONSTANT(unsigned int left,unsigned int right)
{
    return (EXPR_W(left,EXPR_OP)==EOP_CONST || EXPR_W(left,EXPR_OP)==3) && EXPR_W(left,EXPR_OP)==EXPR_W(right,EXPR_OP);
}

/* ---- SIMPLIFY_ADD (CPP 0B46:117B) ---- */
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

/* ---- FOLD_FAR_POINTER_CONSTANT (CPP 0B46:1620) ---- */

/* FOLD_FAR_POINTER_CONSTANT: segment:offset (operator 0x2D) of two constants becomes
   one 32-bit constant (segment in the high word). */
static unsigned int near pascal FOLD_FAR_POINTER_CONSTANT(unsigned int expr)
{
    if (EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_OP)==EOP_CONST && EXPR_W(EXPR_W(expr,EXPR_RIGHT),EXPR_OP)==EOP_CONST)
        return REPLACE_WITH_TYPED_CONSTANT(((unsigned long)EXPR_W(EXPR_W(expr,EXPR_LEFT),EXPR_LEFT)<<16)+
            EXPR_L(EXPR_W(expr,EXPR_RIGHT),EXPR_VALUE),expr);
    return expr;
}

/* ---- SIMPLIFY_SUBTRACT (CPP 0B46:1664) ---- */
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

/* ---- SIMPLIFY_AND (CPP 0B46:1B9E) ---- */
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

/* ---- SIMPLIFY_OR (CPP 0B46:1C46) ---- */
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

/* ---- SIMPLIFY_XOR (CPP 0B46:1CF0) ---- */
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

/* ---- SIMPLIFY_SHIFT (CPP 0B46:1D9A) ---- */
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

/* ---- CHECK_COMPARE_RANGE (CPP 0B46:1EEC) ---- */
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

/* ---- SIMPLIFY_COMPARISON (CPP 0B46:207B) ---- */
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
    /* CPP.EXE edit: no EXPRESSIONS_EQUAL fold of identical operands here (CPP's code goes
       from CHECK_COMPARE_RANGE straight to the constant test). */
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

/* ---- SIMPLIFY_LOGICAL_AND (CPP 0B46:21BA) ---- */

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
        case 2:
            break;
        }
        break;
    /* CPP.EXE edit: no case 2 (x && 0 for unknown x) and an empty inner case 2 above:
       CPP's code tests only 1 here, then 0, 1, 2 for the right side. */
    }
    return expr;
}

/* ---- SIMPLIFY_LOGICAL_OR (CPP 0B46:22B5) ---- */

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
            /* CPP.EXE edit: the x || 1 rewrite is gone; CPP's code keeps the empty case. */
            break;
        case 2:
            break;
        }
        break;
    }
    return expr;
}

/* ---- (BCC's SIMPLIFY_ASSIGN: not in CPP.EXE) ---- */


/* ---- (BCC's SIMPLIFY_COMMA: not in CPP.EXE) ---- */


/* ---- SIMPLIFY_BINARY (CPP 0B46:23CE) ---- */
/* In BCC's table this row also holds MAKE_VOID_ZERO_NODE (after the switch table); CPP's
   table gives it its own row (CPP 0B46:25DD). */
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
        /* CPP.EXE edit: no EOP_DOT (SIMPLIFY_MEMBER) and no EOP_ASSIGN (SIMPLIFY_ASSIGN)
           cases; CPP's jump table runs from EOP_ADD to 0x2D and sends 0x12 to the end. */
        switch (EXPR_W(expr,EXPR_OP)) {
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

/* ---- SIMPLIFY_CONDITIONAL (CPP 0B46:25FE) ---- */

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
                /* CPP.EXE edit: no folding of equal arms (EXPRESSIONS_EQUAL) and no void
                   conversion of the arms in a discarded position; CPP's code ends the
                   case after the two MAKE_VOID_ZERO_NODE fills. */
            }
        }
        break;
    }
    if (invalid)
        expr=REPORT_EXPR_ERROR_PLAIN(0,expr);
    return expr;
}

/* ---- SIMPLIFY_NODE (CPP 0B46:27BB) ---- */
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);

/* SIMPLIFY_NODE: the dispatcher (see the overview). Symbol leaves record their use and
   may warn about use before definition (not for storage classes 1, 2, 3, 7 and 10,
   probably the ones that are always initialised, such as statics and functions). In a
   discarded position a side-effect-free result is freed and 0 returned. The stack check
   stops very deep trees with MSG_OUT_MEMORY. */
static unsigned int near pascal SIMPLIFY_NODE(unsigned int expr,unsigned int flags,
    unsigned int mode)
{
    /* CPP.EXE edit: the stack limit is 0x7AEC (cmp sp,7AECh), not BCC's 0x8F0C. */
    if (_SP<0x7AEC) REPORT_FATAL(MSG_OUT_MEMORY);
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
        /* CPP.EXE edit: no EOP_COMMA case (SIMPLIFY_COMMA is not in CPP.EXE). */
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
    /* CPP.EXE edit: no freeing of a side-effect-free tree in a discarded position
       (IS_SIDE_EFFECT_FREE); CPP's code returns expr straight after the switch. */
    return expr;
}

/* ---- SIMPLIFY_EXPRESSION (CPP 0B46:2991) ---- */

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
