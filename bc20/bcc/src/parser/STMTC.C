/* target: ovr132_C122UNIT */
/* Role: statement parser, C mode. Entry points: PARSE_BLOCK_BODY, CHECK_EXPRESSION_EFFECT,
   MARK_SYMBOLS_REFERENCED. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO04B (ovr_1d10_982e) as one source. */
/* opts: -mm -G -O -Z -p -Y -y -k- */
/* Overview: the statement parser of the C front end (the one COMPILE_C_SOURCE
   runs for .c files; C++ has its own in STMTCPP.C).  This front end reads
   tokens straight from the lexer: NEXT() returns the next token code
   (LEX_NEXT_TOKEN, or the one token pushed back with TOKEN_PUSHED_BACK),
   the code is in TOKEN_TYPE and an identifier's name or a constant's
   value in TOKEN_CONST_VALUE; there are no token records or replay streams.
   Statements are not built into a tree: each one is turned at once into
   flow blocks appended to the current function's block chain
   (APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL, block, LOOP_BLOCK_WEIGHT)):
   labels (NEW_LABEL), expression blocks, conditional branch blocks, jumps,
   switch and return blocks.  So "while (c) s" becomes: jump to the test;
   label: s; continue label: test, branch back if true; break label.
   LOOP_BLOCK_WEIGHT is the weight given to new blocks: it triples inside
   each loop when optimising for speed, probably so the register allocator
   favours variables used in loops.
   Each PARSE_STATEMENT_C call gets *flag, which says whether the point
   before the statement can be reached; it is updated for the point after
   it (0 after break, continue, return, goto or an endless loop), and a
   statement where it is 0 gets the "unreachable code" warning.  Loops and
   switches keep their break and continue labels in a struct loop_ctx on
   the C stack, linked through CURRENT_LOOP_CONTEXT and
   CURRENT_SWITCH_CONTEXT.  case values are kept sorted in
   SWITCH_CASE_LIST.  Token codes are those of TOKEN.H (0x59 if, 0x5B for
   ...).  The last two functions walk finished expression trees to warn
   about expressions without effect and to mark variables used or
   assigned. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- STOVR46 (listing 82E0) ---- */
static void near pascal PARSE_STATEMENT_C(unsigned int far *flag);
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG; extern unsigned int BCC_TREE_SPECIAL;
extern int  LOOP_BLOCK_WEIGHT;
extern int  TOKEN_TYPE;
extern unsigned char  TOKEN_PUSHED_BACK;
extern unsigned int far pascal LEX_NEXT_TOKEN(void);
extern int far pascal TOKEN_STARTS_TYPE(unsigned int);
extern unsigned int far pascal CREATE_SCOPE(unsigned int);
extern unsigned int far pascal NEW_SCOPE_ENTER_BLOCK(unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NEW_SCOPE_EXIT_BLOCK(unsigned int);
extern void far pascal BCC_STMT_DECL_PARSE(void);
extern void far pascal WARN_UNUSED_SYMBOLS(unsigned int);
extern void far cdecl REPORT_AND_SKIP(unsigned int,...);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses the inside of a compound statement, after its '{': local
   declarations first (they open a new scope C_DECL_SCOPE, with scope enter
   and exit blocks, unless the caller already opened one: opened nonzero),
   then statements up to the '}'.  value is the reachability flag on entry;
   the flag after the block is returned.  The type pool is cut back after
   each statement (TYPE_POOL_LENGTH_MARK), as statement-local types are no
   longer needed.  Unused locals are reported when the scope closes. */
int far pascal PARSE_BLOCK_BODY(unsigned int opened,unsigned int value)
{
    unsigned int saved;
    register unsigned int list;
    register unsigned int current;
    current=C_DECL_SCOPE;
    list=0;
    saved=STMT_SCOPE_BLOCK;
    if(TOKEN_STARTS_TYPE(NEXT())) {
        if(opened==0) {
            current=CURRENT_SCOPE=C_DECL_SCOPE=CREATE_SCOPE(C_DECL_SCOPE);
            opened=1;
            list=NEW_SCOPE_ENTER_BLOCK(C_DECL_SCOPE,STMT_SCOPE_BLOCK);
            STMT_SCOPE_BLOCK=list;
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,list,LOOP_BLOCK_WEIGHT);
        }
        do {
            BCC_STMT_DECL_PARSE();
            if(TOKEN_TYPE!=7) REPORT_AND_SKIP(MSG_DECLARATION_MISSING,0L);
        } while(TOKEN_STARTS_TYPE(NEXT()));
    }
    TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
    while(TOKEN_TYPE!=6 && TOKEN_TYPE!=0) {
        TOKEN_PUSHED_BACK=1;
        PARSE_STATEMENT_C(&value);
        TYPE_POOL_WORD6=0;
        TYPE_POOL_LENGTH=TYPE_POOL_LENGTH_MARK;
        NEXT();
    }
    LOGICAL_LINE=CURRENT_LINE;
    if(TOKEN_TYPE!=6) REPORT_ERROR(MSG_COMPOUND_STATEMENT);
    if(opened) {
        C_DECL_SCOPE=*(unsigned int far *)MK_FP(SCOPE_POOL_SEG,current+SCOPE_C_PARENT);
        CURRENT_SCOPE=C_DECL_SCOPE;
        WARN_UNUSED_SYMBOLS(current);
        if(list) APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,NEW_SCOPE_EXIT_BLOCK(list),LOOP_BLOCK_WEIGHT);
        STMT_SCOPE_BLOCK=saved;
    }
    return value;
}
#undef NEXT

/* ---- STOVR47 (listing 842E) ---- */
extern unsigned char  OPTION_OPTIMIZE_SPEED;
/* Entering a loop body: triples the block weight (when optimising for
   speed, up to a limit). */
static void near pascal ENTER_LOOP_WEIGHT(void)
{
    if(OPTION_OPTIMIZE_SPEED!=0 && LOOP_BLOCK_WEIGHT<=8191) LOOP_BLOCK_WEIGHT*=3;
}

/* ---- STOVR48 (listing 8449) ---- */
/* Leaving a loop body: undoes ENTER_LOOP_WEIGHT. */
static void near pascal LEAVE_LOOP_WEIGHT(void)
{
    if(LOOP_BLOCK_WEIGHT>1) LOOP_BLOCK_WEIGHT/=3;
}

/* ---- STOVR49 (listing 845D) ---- */
/* Warns "unreachable code" when the reachability flag is 0. */
static void near pascal WARN_IF_UNREACHABLE(unsigned int far *value)
{
    if(*value==0) REPORT_WARNING(MSG_UNREACHABLE_CODE);
}

/* ---- PARSE_STATEMENT_C (listing 847A) ---- */
#include <dos.h>
struct loop_ctx {
    struct loop_ctx far *prev_loop;
    struct loop_ctx far *prev_switch;
    unsigned int break_label;
    unsigned int continue_label;
    char kind;
    char broken;
};
extern unsigned int EXPR_POOL_SEG;
extern unsigned int DIAG_NAME_BUFFER;
extern long  TOKEN_CONST_VALUE;
extern unsigned char RETURN_FORM_SEEN;
extern struct loop_ctx far *CURRENT_LOOP_CONTEXT;
extern struct loop_ctx far *CURRENT_SWITCH_CONTEXT;
extern void far pascal NESTING_CHECK(void);
extern unsigned int far pascal PARSE_CONSTANT_EXPR(unsigned int);
extern unsigned int far pascal NEW_LABEL(void);
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
extern void far pascal PARSE_ASM_STATEMENT(void);
extern unsigned int far pascal PARSE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);
extern unsigned int far pascal FOLD_STATEMENT_EXPR(unsigned int);
extern unsigned int far pascal NEW_EXPRESSION_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NEW_BRANCH_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal SET_BLOCK_1C_FLAG_1(unsigned int);
extern unsigned int far pascal STASSIGN(unsigned int,unsigned int);
extern unsigned int far pascal NEW_SWITCH_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal SET_SWITCH_BLOCK_INFO(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NEW_RETURN_JUMP_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern int far pascal PARSE_BLOCK_BODY(unsigned int,unsigned int);
static void near pascal ENTER_LOOP_WEIGHT(void);
static void near pascal LEAVE_LOOP_WEIGHT(void);
static void near pascal WARN_IF_UNREACHABLE(unsigned int far *);
static int near pascal CLASSIFY_CONDITION(unsigned int);
static int near pascal BRANCH_IF_FALSE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
static int near pascal BRANCH_IF_TRUE(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
static void near pascal EMIT_JUMP(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal CHECK_EXPRESSION_EFFECT(unsigned int);
extern void far pascal MARK_SYMBOLS_REFERENCED(unsigned int);
static unsigned int near pascal COPY_STRUCT_RETURN(unsigned int);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses one statement and appends its flow blocks (see the file
   overview); flag is the reachability flag.  Labels, case and default go
   back to restart, since they prefix the statement that follows.  file
   and line are the statement's position, given to the blocks for debug
   line numbers.  STATEMENT_LABELED_FLAG notes a label inside a loop body;
   a loop body with no label, case or default in it gets its loop-head
   block marked (SET_BLOCK_1C_FLAG_1), probably telling later passes the
   loop is entered only from the top. */
static void near pascal PARSE_STATEMENT_C(unsigned int far *flag)
{
    int cls;
    unsigned int label;
    unsigned int label2;
    unsigned int label3;
    unsigned int steptree;
    unsigned int step;
    unsigned int ident;
    unsigned int prev;
    unsigned int saved_cases;
    unsigned int saved_cases2;
    unsigned int saved_default;
    unsigned int saved_default2;
    int saved_flag;
    char far *name;
    unsigned int rec;
    unsigned int file;
    unsigned int line;
    unsigned int file2;
    unsigned int line2;
    unsigned int file3;
    unsigned int line3;
    int ifcls;
    unsigned int saved;
    int saved6458;
    struct loop_ctx ctx;
    register unsigned int node;
    register unsigned int p;
restart:
    NESTING_CHECK();
    ident=0;
    NEXT();
    LOGICAL_LINE=CURRENT_LINE;
    file=TOKEN_FILE_NODE;
    line=TOKEN_LINE;
    saved_cases=SWITCH_CASE_LIST;
    saved_flag=STATEMENT_LABELED_FLAG;
    saved_default=SWITCH_DEFAULT_LABEL;
    switch(TOKEN_TYPE) {
    /* case constant: the value is inserted in the sorted case list with a
       new label, which is placed here. */
    case 0x63:
        *flag=1;
        NEXT();
        if(!PARSE_CONSTANT_EXPR(3)) return;
        if(CURRENT_SWITCH_CONTEXT==0) {
            REPORT_ERROR(MSG_CASE_OUTSIDE_SWITCH);
            goto restart;
        }
        prev=0;
        for(p=SWITCH_CASE_LIST; p; p=SWCASE_W(p,SWCASE_NEXT)) {
            if(SWCASE_L(p,SWCASE_VALUE)==TOKEN_CONST_VALUE) {
                REPORT_ERROR(MSG_DUPLICATE_CASE);
                break;
            }
            if(SWCASE_L(p,SWCASE_VALUE)>TOKEN_CONST_VALUE) {
                p=0;
                break;
            }
            prev=p;
        }
        if(p) goto restart;
        label=NEW_LABEL();
        p=POOL_ALLOC_REUSE(&CASE_ENTRY_POOL_SEG,8);
        if(prev==0) {
            SWCASE_W(p,SWCASE_NEXT)=SWITCH_CASE_LIST;
            SWITCH_CASE_LIST=p;
        } else {
            SWCASE_W(p,SWCASE_NEXT)=SWCASE_W(prev,SWCASE_NEXT);
            SWCASE_W(prev,SWCASE_NEXT)=p;
        }
        SWCASE_W(p,SWCASE_TARGET)=label;
        SWCASE_L(p,SWCASE_VALUE)=TOKEN_CONST_VALUE;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        goto restart;
    case 0x62:
        *flag=1;
        if(NEXT()!=0x21) {
            REPORT_ERROR(MSG_INCORRECT_USE_DEFAULT);
            TOKEN_PUSHED_BACK=1;
            goto restart;
        }
        if(CURRENT_SWITCH_CONTEXT==0) {
            REPORT_ERROR(MSG_DEFAULT_OUTSIDE_SWITCH);
            goto restart;
        }
        if(SWITCH_DEFAULT_LABEL) {
            REPORT_ERROR(MSG_TOO_MANY_DEFAULT_CASES);
            goto restart;
        }
        SWITCH_DEFAULT_LABEL=NEW_LABEL();
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,SWITCH_DEFAULT_LABEL,LOOP_BLOCK_WEIGHT);
        goto restart;
    case 6:
        TOKEN_PUSHED_BACK=1;
    case 0:
        REPORT_ERROR(MSG_STATEMENT_MISSING_234);
        return;
    case 0x57:
        WARN_IF_UNREACHABLE(flag);
        PARSE_ASM_STATEMENT();
        return;
    case 0x5A:
        REPORT_ERROR(MSG_MISPLACED_ELSE_127);
        goto restart;
    case 0x59:
        WARN_IF_UNREACHABLE(flag);
        name=STR_IF_4;
        if(NEXT()!=1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING,name);
            return;
        }
        NEXT();
        label=NEW_LABEL();
        node=PARSE_EXPRESSION(0,0);
        if(!node) return;
        node=FOLD_EXPRESSION(node);
        MARK_SYMBOLS_REFERENCED(node);
        ifcls=BRANCH_IF_FALSE(node,label,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        *flag=ifcls>=0;
        if(TOKEN_TYPE!=2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63,name);
            return;
        }
        PARSE_STATEMENT_C(flag);
        file=TOKEN_FILE_NODE;
        line=TOKEN_LINE;
        if(NEXT()==0x5A) {
            saved=*flag;
            if(ifcls>0) *flag=0;
            else *flag=1;
            label2=NEW_LABEL();
            EMIT_JUMP(label2,file,line,0,0);
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
            PARSE_STATEMENT_C(flag);
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label2,LOOP_BLOCK_WEIGHT);
            if(ifcls>0) *flag=saved;
            else *flag|=saved;
            return;
        }
        if(ifcls<=0) *flag=1;
        TOKEN_PUSHED_BACK=1;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        return;
    /* for (init; test; step) body.  Layout: init, a jump to the test unless
       it is constant, label2: body, continue label: step, then the test
       (a branch back to label2), or a plain jump back for an always-true
       test, then the break label.  cls is the test's CLASSIFY_CONDITION
       result (1 always true, -1 always false, 0 unknown). */
    case 0x5B:
        WARN_IF_UNREACHABLE(flag);
        name=STR_FOR_2;
        ctx.prev_loop=CURRENT_LOOP_CONTEXT;
        ctx.break_label=NEW_LABEL();
        ctx.continue_label=NEW_LABEL();
        ctx.kind=0x5B;
        ctx.broken=0;
        label2=NEW_LABEL();
        if(NEXT()!=1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING,name);
            return;
        }
        if(NEXT()!=7) {
            node=PARSE_EXPRESSION(0,0);
            if(!node) return;
            CHECK_EXPRESSION_EFFECT(node);
            node=FOLD_STATEMENT_EXPR(node);
            label=NEW_EXPRESSION_BLOCK(node,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
            file=TOKEN_FILE_NODE;
            line=TOKEN_LINE;
            if(TOKEN_TYPE!=7) {
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,name);
                return;
            }
        } else file=0;
        ENTER_LOOP_WEIGHT();
        if(NEXT()!=7) {
            file2=TOKEN_FILE_NODE;
            line2=TOKEN_LINE;
            if(line==line2 && file==file2) file2=0;
            node=PARSE_EXPRESSION(0,0);
            if(!node) return;
            if(TOKEN_TYPE!=7) {
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,name);
                return;
            }
            if(file2) {
                file3=TOKEN_FILE_NODE;
                line3=TOKEN_LINE;
            } else file3=0;   /* line3 is left unset when file3==0, as in the original */
            node=FOLD_EXPRESSION(node);
            cls=CLASSIFY_CONDITION(node);
            MARK_SYMBOLS_REFERENCED(node);
            if(cls==0) label3=NEW_BRANCH_BLOCK(1,node,label2,file2,line2,file3,line3);
            else label3=0;
        } else {
            cls=1;
            label3=0;
        }
        if(NEXT()!=2) {
            if(line!=TOKEN_LINE || file!=TOKEN_FILE_NODE) {
                file=TOKEN_FILE_NODE;
                line=TOKEN_LINE;
            } else file=0;
            step=PARSE_EXPRESSION(0,0);
            if(!step) return;
            if(TOKEN_TYPE!=2) {
                REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63,name);
                return;
            }
            step=FOLD_EXPRESSION(step);
            saved6458=FOR_STEP_CLEARED_FLAG;
            FOR_STEP_CLEARED_FLAG=0;
            CHECK_EXPRESSION_EFFECT(step);
            FOR_STEP_CLEARED_FLAG=saved6458;
            steptree=NEW_EXPRESSION_BLOCK(step,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        } else steptree=0;
        CURRENT_LOOP_CONTEXT=&ctx;
        if(cls<0) *flag=0;
        else {
            if(cls==0) {
                label=NEW_LABEL();
                EMIT_JUMP(label,0,0,0,0);
            }
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label2,LOOP_BLOCK_WEIGHT);
        }
        STATEMENT_LABELED_FLAG=0;
        PARSE_STATEMENT_C(flag);
        if(cls>=0 && saved_cases==SWITCH_CASE_LIST && STATEMENT_LABELED_FLAG==0 && saved_default==SWITCH_DEFAULT_LABEL) SET_BLOCK_1C_FLAG_1(label2);
        STATEMENT_LABELED_FLAG|=saved_flag;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.continue_label,LOOP_BLOCK_WEIGHT);
        if(steptree) APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,steptree,LOOP_BLOCK_WEIGHT);
        if(cls==0) { APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT); APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label3,LOOP_BLOCK_WEIGHT); ctx.broken=1; } else if(cls>0) EMIT_JUMP(label2,0,0,0,0); else ctx.broken=1;
        LEAVE_LOOP_WEIGHT();
        *flag=ctx.broken;
        CURRENT_LOOP_CONTEXT=ctx.prev_loop;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.break_label,LOOP_BLOCK_WEIGHT);
        return;
    case 0x5D:
        WARN_IF_UNREACHABLE(flag);
        name=STR_DO_WHILE_2;
        ctx.prev_loop=CURRENT_LOOP_CONTEXT;
        ctx.kind=0x5D;
        CURRENT_LOOP_CONTEXT=&ctx;
        ctx.continue_label=NEW_LABEL();
        ctx.break_label=NEW_LABEL();
        ctx.broken=0;
        label=NEW_LABEL();
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        ENTER_LOOP_WEIGHT();
        *flag=1;
        STATEMENT_LABELED_FLAG=0;
        PARSE_STATEMENT_C(flag);
        if(saved_cases==SWITCH_CASE_LIST && STATEMENT_LABELED_FLAG==0 && saved_default==SWITCH_DEFAULT_LABEL) SET_BLOCK_1C_FLAG_1(label);
        STATEMENT_LABELED_FLAG|=saved_flag;
        if(NEXT()!=0x5C) {
            REPORT_AND_SKIP(MSG_DO_STATEMENT_MUST_HAVE,0L);
            return;
        }
        file=TOKEN_FILE_NODE;
        line=TOKEN_LINE;
        if(NEXT()!=1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING,name);
            return;
        }
        NEXT();
        CURRENT_LOOP_CONTEXT=ctx.prev_loop;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.continue_label,LOOP_BLOCK_WEIGHT);
        node=PARSE_EXPRESSION(0,0);
        if(!node) return;
        node=FOLD_EXPRESSION(node);
        MARK_SYMBOLS_REFERENCED(node);
        if(BRANCH_IF_TRUE(node,label,file,line,TOKEN_FILE_NODE,TOKEN_LINE)<=0) ctx.broken=1;
        LEAVE_LOOP_WEIGHT();
        *flag=ctx.broken;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.break_label,LOOP_BLOCK_WEIGHT);
        if(TOKEN_TYPE!=2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63,name);
            return;
        }
        if(NEXT()!=7) REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,name);
        return;
    case 0x5C:
        WARN_IF_UNREACHABLE(flag);
        name=STR_WHILE_2;
        if(NEXT()!=1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING,name);
            return;
        }
        NEXT();
        ctx.prev_loop=CURRENT_LOOP_CONTEXT;
        ctx.kind=0x5C;
        CURRENT_LOOP_CONTEXT=&ctx;
        ctx.continue_label=NEW_LABEL();
        ctx.break_label=NEW_LABEL();
        ctx.broken=0;
        *flag=1;
        node=PARSE_EXPRESSION(0,0);
        if(!node) return;
        if(TOKEN_TYPE!=2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63,name);
            return;
        }
        ENTER_LOOP_WEIGHT();
        node=FOLD_EXPRESSION(node);
        cls=CLASSIFY_CONDITION(node);
        if(cls<=0) EMIT_JUMP(ctx.continue_label,0,0,0,0);
        if(cls>=0) {
            label=NEW_LABEL();
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        }
        MARK_SYMBOLS_REFERENCED(node);
        if(cls==0) label3=NEW_BRANCH_BLOCK(1,node,label,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        else label3=0;
        if(cls<0) {
            *flag=0;
            ctx.broken=1;
        }
        STATEMENT_LABELED_FLAG=0;
        PARSE_STATEMENT_C(flag);
        if(saved_cases==SWITCH_CASE_LIST && STATEMENT_LABELED_FLAG==0 && saved_default==SWITCH_DEFAULT_LABEL) SET_BLOCK_1C_FLAG_1(ctx.continue_label);
        STATEMENT_LABELED_FLAG|=saved_flag;
        LEAVE_LOOP_WEIGHT();
        CURRENT_LOOP_CONTEXT=ctx.prev_loop;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.continue_label,LOOP_BLOCK_WEIGHT);
        if(cls==0) {
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label3,LOOP_BLOCK_WEIGHT);
            ctx.broken=1;
        } else if(cls>0) EMIT_JUMP(label,0,0,0,0);
        *flag=ctx.broken;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.break_label,LOOP_BLOCK_WEIGHT);
        return;
    /* switch: the selector is converted to int unless it is long, unsigned
       long or unsigned; the cases and default found in the body are
       attached to the switch block afterwards.  A switch without default
       gets one at its end. */
    case 0x5E:
        WARN_IF_UNREACHABLE(flag);
        name=STR_SWITCH_2;
        if(NEXT()!=1) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING,name);
            return;
        }
        NEXT();
        node=PARSE_EXPRESSION(0,0);
        if(!node) return;
        if(EXPR_W(node,EXPR_KIND)!=TK_LONG && EXPR_W(node,EXPR_KIND)!=TK_ULONG && EXPR_W(node,EXPR_KIND)!=TK_UINT) node=STASSIGN(node,PLAIN_INT_TYPE);
        saved_cases2=SWITCH_CASE_LIST;
        saved_default2=SWITCH_DEFAULT_LABEL;
        SWITCH_DEFAULT_LABEL=0;
        SWITCH_CASE_LIST=0;
        MARK_SYMBOLS_REFERENCED(node);
        node=FOLD_EXPRESSION(node);
        label=NEW_SWITCH_BLOCK(node,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        if(TOKEN_TYPE!=2) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_63,name);
            return;
        }
        ctx.break_label=NEW_LABEL();
        if(CURRENT_LOOP_CONTEXT) ctx.continue_label=CURRENT_LOOP_CONTEXT->continue_label;
        else ctx.continue_label=0;
        ctx.prev_loop=CURRENT_LOOP_CONTEXT;
        ctx.prev_switch=CURRENT_SWITCH_CONTEXT;
        ctx.kind=0x5E;
        ctx.broken=0;
        CURRENT_LOOP_CONTEXT=&ctx;
        CURRENT_SWITCH_CONTEXT=&ctx;
        *flag=0;
        PARSE_STATEMENT_C(flag);
        if(SWITCH_DEFAULT_LABEL==0) { SWITCH_DEFAULT_LABEL=NEW_LABEL(); APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,SWITCH_DEFAULT_LABEL,LOOP_BLOCK_WEIGHT); *flag=1; } else if(ctx.broken) *flag=1;
        SET_SWITCH_BLOCK_INFO(label,SWITCH_DEFAULT_LABEL,SWITCH_CASE_LIST);
        SWITCH_CASE_LIST=saved_cases2;
        SWITCH_DEFAULT_LABEL=saved_default2;
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,ctx.break_label,LOOP_BLOCK_WEIGHT);
        CURRENT_LOOP_CONTEXT=ctx.prev_loop;
        CURRENT_SWITCH_CONTEXT=ctx.prev_switch;
        return;
    case 0x60:
        WARN_IF_UNREACHABLE(flag);
        if(NEXT()!=7) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,(char far *)STR_BREAK);
            return;
        }
        if(CURRENT_LOOP_CONTEXT==0 || CURRENT_LOOP_CONTEXT->break_label==0) REPORT_ERROR(MSG_MISPLACED_BREAK);
        else {
            EMIT_JUMP(CURRENT_LOOP_CONTEXT->break_label,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
            CURRENT_LOOP_CONTEXT->broken=1;
        }
        *flag=0;
        return;
    case 0x61:
        WARN_IF_UNREACHABLE(flag);
        if(NEXT()!=7) {
            REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,(char far *)STR_CONTINUE);
            return;
        }
        if(CURRENT_LOOP_CONTEXT==0 || CURRENT_LOOP_CONTEXT->continue_label==0) REPORT_ERROR(MSG_MISPLACED_CONTINUE);
        else EMIT_JUMP(CURRENT_LOOP_CONTEXT->continue_label,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        *flag=0;
        return;
    /* return: RETURN_FORM_SEEN remembers whether this function used
       "return;" (1) or "return value;" (2), to warn about mixing them. */
    case 0x5F:
        WARN_IF_UNREACHABLE(flag);
        *flag=0;
        if(NEXT()!=7) {
            node=PARSE_EXPRESSION(0,0);
            if(!node) return;
            if(TYPE_B(CURRENT_FUNCTION_TYPE,TYPE_KIND)==TK_VOID) REPORT_WARNING(MSG_VOID_FUNCTIONS_MAY_NOT);
            else node=STASSIGN(node,CURRENT_FUNCTION_TYPE);
            if(RETURN_FORM_SEEN==1) REPORT_WARNING(MSG_BOTH_RETURN_RETURN);
            RETURN_FORM_SEEN=2;
            if(TOKEN_TYPE!=7) REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,(char far *)STR_RETURN);
        } else {
            if(CURRENT_FUNCTION_TYPE!=PLAIN_INT_TYPE && TYPE_B(CURRENT_FUNCTION_TYPE,TYPE_KIND)!=TK_VOID) REPORT_WARNING(MSG_FUNCTION_SHOULD_RETURN_367); else if(RETURN_FORM_SEEN==2) REPORT_WARNING(MSG_BOTH_RETURN_RETURN);
            RETURN_FORM_SEEN=1;
            node=0;
        }
        MARK_SYMBOLS_REFERENCED(node);
        node=FOLD_EXPRESSION(node);
        if(TYPE_B(CURRENT_FUNCTION_TYPE,TYPE_KIND)==TK_STRUCT) node=COPY_STRUCT_RETURN(node);
        label=NEW_RETURN_JUMP_BLOCK(node,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        return;
    case 5:
        *flag=PARSE_BLOCK_BODY(0,*flag);
        return;
    case 0x58:
        WARN_IF_UNREACHABLE(flag);
        if(NEXT()!=0x31) {
            REPORT_AND_SKIP(MSG_GOTO_STATEMENT_MISSING,0L);
            return;
        }
        rec=LOOKUP_SYMBOL((unsigned int)TOKEN_CONST_VALUE,C_FUNCTION_SCOPE,1);
        if(rec==0) {
            rec=DECLARE_SYMBOL((unsigned int)TOKEN_CONST_VALUE,C_FUNCTION_SCOPE,1,3,0,0,0);
            CSYM_W(rec,CSYM_LABEL)=NEW_LABEL();
        }
        CSYM_W(rec,CSYM_FLAGS)|=0x80;
        EMIT_JUMP(CSYM_W(rec,CSYM_LABEL),file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        if(NEXT()!=7) REPORT_AND_SKIP(MSG_STATEMENT_MISSING_64,(char far *)STR_GOTO_2);
        *flag=0;
        return;
    /* An identifier: a label if ':' follows (labels live in
       C_FUNCTION_SCOPE, flag 0x40 = defined), else the start of an
       expression statement, whose first name is passed to PARSE_EXPRESSION
       because it has already been read. */
    case 0x31:
        ident=TOKEN_CONST_VALUE;
        if(NEXT()==0x21) {
            rec=LOOKUP_SYMBOL(ident,C_FUNCTION_SCOPE,1);
            *flag=1;
            STATEMENT_LABELED_FLAG=1;
            if(rec==0) {
                rec=DECLARE_SYMBOL(ident,C_FUNCTION_SCOPE,1,3,0,0,0x40);
                CSYM_W(rec,CSYM_LABEL)=NEW_LABEL();
            } else {
                if(CSYM_W(rec,CSYM_FLAGS)&0x40) {
                    DIAG_NAME_BUFFER=0;
                    REPORT_ERROR(MSG_MULTIPLE_DECLARATION,NAME_TEXT_COPY(CSYM_W(rec,CSYM_NAME)));
                    goto restart;
                }
                CSYM_W(rec,CSYM_FLAGS)|=0x40;
            }
            APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,CSYM_W(rec,CSYM_LABEL),LOOP_BLOCK_WEIGHT);
            goto restart;
        }
    default:
        WARN_IF_UNREACHABLE(flag);
        node=PARSE_EXPRESSION(ident,0);
        if(!node) return;
        CHECK_EXPRESSION_EFFECT(node);
        node=FOLD_STATEMENT_EXPR(node);
        label=NEW_EXPRESSION_BLOCK(node,file,line,TOKEN_FILE_NODE,TOKEN_LINE);
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,label,LOOP_BLOCK_WEIGHT);
        if(TOKEN_TYPE!=7) REPORT_AND_SKIP(MSG_STATEMENT_MISSING_234,0L);
        *flag=1;
    case 7:
        break;
    }
}
#undef NEXT

/* ---- STOVR52 (listing 9623) ---- */
#include <dos.h>
/* Classifies a folded condition: 1 if always true (a nonzero constant or an
   address), -1 if always false (zero), 0 if it must be tested.  Warns on a
   struct value and on an assignment used as a condition ("possibly
   incorrect assignment"). */
static int near pascal CLASSIFY_CONDITION(register unsigned int node)
{
    if(EXPR_W(node,EXPR_KIND)==TK_STRUCT) REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
    switch(EXPR_W(node,EXPR_OP)) {
    case EOP_CONST:if(*(long far *)MK_FP(EXPR_POOL_SEG,node+EXPR_LEFT)==0) return -1; else return 1;
    case EOP_ADDR:return 1;
    case EOP_ASSIGN:REPORT_WARNING(MSG_POSSIBLY_INCORRECT);return 0;
    }
    return 0;
}

/* ---- STOVR53 (listing 968B) ---- */
extern unsigned int far pascal STBIN3(unsigned int);
extern void far pascal MARK_SYMBOLS_REFERENCED(unsigned int input);
/* Emits code that goes to label first when the condition node is false:
   nothing if it is always true, a jump if always false, else a branch
   block.  second to fifth are the file and line positions of the start and
   end of the condition.  Returns the CLASSIFY_CONDITION result. */
static int near pascal BRANCH_IF_FALSE(register unsigned int node,unsigned int first,unsigned int second,unsigned int third,unsigned int fourth,unsigned int fifth)
{
    unsigned int temporary;
    register int classification;
    node=STBIN3(node);
    node=FOLD_EXPRESSION(node);
    classification=CLASSIFY_CONDITION(node);
    MARK_SYMBOLS_REFERENCED(node);
    if(classification<0) EMIT_JUMP(first,second,third,fourth,fifth);
    else if(classification==0) {
        temporary=NEW_BRANCH_BLOCK(0,node,first,second,third,fourth,fifth);
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,temporary,LOOP_BLOCK_WEIGHT);
    }
    return classification;
}

/* ---- STOVR54 (listing 9704) ---- */
/* The same, going to label first when the condition is true. */
static int near pascal BRANCH_IF_TRUE(register unsigned int node,unsigned int first,unsigned int second,unsigned int third,unsigned int fourth,unsigned int fifth)
{
    unsigned int temporary;
    register int classification;
    node=STBIN3(node);
    node=FOLD_EXPRESSION(node);
    classification=CLASSIFY_CONDITION(node);
    if(classification>0) EMIT_JUMP(first,second,third,fourth,fifth);
    else if(classification==0) {
        temporary=NEW_BRANCH_BLOCK(1,node,first,second,third,fourth,fifth);
        APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,temporary,LOOP_BLOCK_WEIGHT);
    }
    return classification;
}

/* ---- STOVR55 (listing 9778) ---- */
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
/* Appends a jump to label first (second to fifth: source positions). */
static void near pascal EMIT_JUMP(unsigned int first,unsigned int second,unsigned int third,unsigned int fourth,unsigned int fifth)
{
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,NEW_JUMP_BLOCK(first,second,third,fourth,fifth),LOOP_BLOCK_WEIGHT);
}

/* ---- STOVR56 (listing 97A3) ---- */
#include <dos.h>
/* Checks an expression used as a statement.  Warns "code has no effect"
   for an operator without side effects (EXPR_OP_HAS_EFFECT table) whose
   value is not void, looking into comma and ?: operands.  As the value is
   discarded, x++ and x-- are rewritten as x += and x -= (the step amount
   is already in the node).  Then marks the symbols used. */
void far pascal CHECK_EXPRESSION_EFFECT(register unsigned int node)
{
    register unsigned int child;
    if(node==0) return;
    if(EXPR_W(node,EXPR_KIND)==TK_UNDEFINED) return;
    if(EXPR_W(node,EXPR_OP)==EOP_COMMA) {
        CHECK_EXPRESSION_EFFECT(EXPR_W(node,EXPR_LEFT));
        CHECK_EXPRESSION_EFFECT(EXPR_W(node,EXPR_RIGHT));
    } else if(EXPR_W(node,EXPR_OP)==EOP_QUESTION) {
        if(EXPR_W(node,EXPR_RIGHT)==0) return;
        child=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_LEFT);
        if(EXPR_W(child,EXPR_OP)==0x35 && EXPR_W(child,EXPR_KIND)!=TK_VOID) child=EXPR_W(child,EXPR_LEFT);
        CHECK_EXPRESSION_EFFECT(child);
        child=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT);
        if(EXPR_W(child,EXPR_OP)==0x35 && EXPR_W(child,EXPR_KIND)!=TK_VOID) child=EXPR_W(child,EXPR_LEFT);
        CHECK_EXPRESSION_EFFECT(child);
        MARK_SYMBOLS_REFERENCED(EXPR_W(node,EXPR_LEFT));
    } else {
        if(EXPR_W(node,EXPR_OP)==EOP_POSTINC) EXPR_W(node,EXPR_OP)=EOP_ADD_ASSIGN;
        else if(EXPR_W(node,EXPR_OP)==EOP_POSTDEC) EXPR_W(node,EXPR_OP)=EOP_SUB_ASSIGN;
        else {
            if(EXPR_W(node,EXPR_OP)==5 && CSYM_W(EXPR_W(node,EXPR_LEFT),CSYM_NAME)==0) return;
            if(EXPR_W(node,EXPR_KIND)!=TK_VOID && !EXPR_OP_HAS_EFFECT[EXPR_W(node,EXPR_OP)]) REPORT_WARNING(MSG_CODE_HAS_NO_EFFECT);
        }
        MARK_SYMBOLS_REFERENCED(node);
    }
}

/* ---- STOVR57 (listing 98AC) ---- */
#include <dos.h>
extern void far pascal WARN_USE_BEFORE_ASSIGN(unsigned int);
/* Walks an expression and sets the C symbol flags of the variables in it:
   0x80 used, 0x40 assigned, 0x100 address taken.  A local read before
   anything was assigned to it gets the "possibly used before definition"
   warning (WARN_USE_BEFORE_ASSIGN).  Operators 5 and 6 are probably local
   and register variable nodes, 1 other symbols, 0x33 a field selection
   that is looked through.  Taking the address of an array also changes
   that node's type to the element type. */
void far pascal MARK_SYMBOLS_REFERENCED(unsigned int input)
{
    register unsigned int child;
    register unsigned int node=input;
    for(;;) {
        if(!node) return;
        if(EXPR_I(node,EXPR_KIND)==TK_UNDEFINED) return;
        switch(EXPR_I(node,EXPR_OP)) {
        case 5:case 6:
            if(!(CSYM_W(EXPR_I(node,EXPR_LEFT),CSYM_FLAGS)&0x40)) WARN_USE_BEFORE_ASSIGN(EXPR_I(node,EXPR_LEFT));
        case 1:
            CSYM_W(EXPR_I(node,EXPR_LEFT),CSYM_FLAGS)|=0x80;
            return;
        case EOP_ASSIGN:
            if(EXPR_I(node,EXPR_RIGHT)) MARK_SYMBOLS_REFERENCED(EXPR_I(node,EXPR_RIGHT));
            child=EXPR_I(node,EXPR_LEFT);
            if(EXPR_I(child,EXPR_OP)==0x33) child=EXPR_I(child,EXPR_LEFT);
            if(EXPR_I(child,EXPR_OP)==1) {CSYM_W(EXPR_I(child,EXPR_LEFT),CSYM_FLAGS)|=0xC0;return;}
            if(EXPR_I(child,EXPR_OP)==6 || EXPR_I(child,EXPR_OP)==5) {CSYM_W(EXPR_I(child,EXPR_LEFT),CSYM_FLAGS)|=0x40;return;}
            node=child;
            continue;
        case EOP_COMMA:
            CHECK_EXPRESSION_EFFECT(EXPR_I(node,EXPR_LEFT));
            node=EXPR_I(node,EXPR_RIGHT);
            continue;
        case 0x33:
            node=EXPR_I(node,EXPR_LEFT);
            continue;
        case EOP_ADDR:
            child=EXPR_I(node,EXPR_LEFT);
            if(EXPR_I(child,EXPR_OP)==1 || EXPR_I(child,EXPR_OP)==6 || EXPR_I(child,EXPR_OP)==5) CSYM_W(EXPR_I(child,EXPR_LEFT),CSYM_FLAGS)|=0x1C0;
            if(EXPR_I(child,EXPR_KIND)==TK_ARRAY) {
                EXPR_I(child,EXPR_TYPE)=TYPE_W(EXPR_I(child,EXPR_TYPE),TYPE_TARGET);
                EXPR_I(child,EXPR_KIND)=TYPE_B(EXPR_I(child,EXPR_TYPE),TYPE_KIND);
            }
        default:
            if(EXPR_I(node,EXPR_LEFT)) MARK_SYMBOLS_REFERENCED(EXPR_I(node,EXPR_LEFT));
            node=EXPR_I(node,EXPR_RIGHT);
            continue;
        case EOP_CONST:case 3:case 4:case 7:return;
        }
    }
}

/* ---- STAG005 (listing 9A64) ---- */
#include <dos.h>
extern unsigned int (far pascal *NEW_SYMBOL_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
/* For a function returning a struct whose size is not 1, 2 or 4: rewrites
   the return value as "*hidden = value, *hidden" through the hidden
   return pointer STRUCT_RETURN_PARAM, so the value is copied to the
   caller's buffer (operators 0x31 EOP_DEREF, 0x12 EOP_ASSIGN and 0x2A
   EOP_COMMA, written as numbers in the code).  Smaller structs are returned in registers unchanged. */
static unsigned int near pascal COPY_STRUCT_RETURN(register unsigned int node)
{
    unsigned int kind;
    register unsigned int result;
    if(!node || !EXPR_W(node,EXPR_OP)) return node;
    kind=TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_C_SIZE);
    if(kind==1 || kind==2 || kind==4) return node;
    result=NEW_SYMBOL_NODE_HOOK(5,CSYM_W(STRUCT_RETURN_PARAM,CSYM_TYPE),STRUCT_RETURN_PARAM,0,0);
    result=NEW_EXPR_NODE_HOOK(0x31,CURRENT_FUNCTION_TYPE,result,0);
    node=NEW_EXPR_NODE_HOOK(0x12,CURRENT_FUNCTION_TYPE,result,node);
    result=NEW_SYMBOL_NODE_HOOK(5,CSYM_W(STRUCT_RETURN_PARAM,CSYM_TYPE),STRUCT_RETURN_PARAM,0,0);
    result=NEW_EXPR_NODE_HOOK(0x31,CURRENT_FUNCTION_TYPE,result,0);
    node=NEW_EXPR_NODE_HOOK(0x2A,CURRENT_FUNCTION_TYPE,node,result);
    return node;
}
