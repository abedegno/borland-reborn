/* target: ovr128_C119UNIT */
/* Role: expressions: precedence parser (PARSE_EXPRESSION), unary operators, identifiers,
   subscripts, calls and arguments, assignment and pointer compatibility checks, conversions
   (STCVT*). Entry points: PARSE_EXPRESSION, PARSE_TYPE_NAME_PAREN, PARSE_CONSTANT_EXPR,
   STASSIGN, STCVT8, STCVTA, STCVTC, STCVTD (+6 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO047 (ovr_1cf8_92bb) as one source. */
/* opts: -mm -G -O -Z -p -Y -k- */
/* Overview: the expression parser of the C-mode front end (the STMTC.C side), which
   type-checks as it parses. There is no separate analysis pass here: every operator
   node is built through TYPECHECK_OPERATOR, which inserts the conversions and reports
   errors at once, and nodes come from the C-mode constructors (expr/EXPRMAKE.C, through
   NEW_EXPR_NODE_HOOK and friends). An error gives the error node STCVT8() (operator 0,
   kind TK_UNDEFINED), which later checks pass through quietly.
   Structure: STEVALN is a precedence-climbing parser for binary operators (priorities
   from BINARY_PRIORITY_BY_TOKEN, operators from OPERATOR_BY_TOKEN); STUNARY parses
   prefix operators, primary expressions and the postfix chain ( [ ] ( ) . -> ++ -- ).
   PARSE_CONSTANT_EXPR wraps it for constant expressions in declarations, case labels
   and #if, leaving the value in TOKEN_CONST_VALUE. The rest are helpers: implicit
   function declarations, subscripts, calls and argument checks, the assignment
   conversion STASSIGN, struct member access, comparisons.
   Things to know:
   - The parser works on TOKEN_TYPE (the current token here) with one pushed-back token
     (TOKEN_PUSHED_BACK); the NEXT macro reads the next token into _AX. The value of a
     constant or identifier token is in TOKEN_CONST_VALUE (LOW/HIGH words), its kind in
     TOKEN_AUX. Token codes are those of TOKEN.H: 1 (, 2 ), 3 [, 4 ], 8 comma, 0x16 +,
     0x17 -, 0x18 *, 0x1B &, 0x21 :, 0x2A !, 0x2B ~, 0x2C sizeof, 0x2D ++, 0x2E --, 0x2F
     ., 0x30 ->, 0x31 identifier, 0x32/0x65 integer constant, 0x33 floating constant,
     0x34 string literal, 9 the "..." token.
   - Much of the code is written with register pseudo-variables (_AX, _SI, _DI, _ES,
     _BX) and odd shapes (x=x, _AX=_AX); these keep the original's register use and code
     for byte matching. _SI usually holds the current operand node, _DI the other one.
   - Leaf operators: 1, 4, 5, 6 symbol leaves (5 and 6 probably locals and parameters),
     2 EOP_CONST, 3 floating constant, 7 the "..." leaf (the start of the unnamed
     arguments of a variadic function, as Turbo C's va_start uses it). 0x2B is an
     argument-list cell, 0x2C pointer difference, 0x2D _seg pointer + offset, 0x33
     bitfield, 0x36 (54) call, 42 (0x2A) comma.
   - The STCVT* and STBIN* names are the original listing names; the comment above each
     says what it does.
   - LANGUAGE_MODE is the language mode (1 = strict ANSI); MACRO_MODE is set while
     parsing a #if expression. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- STEVAL (listing ovr_1cf8_92bb:2BB0) ---- */
static unsigned int near pascal STEVALN(int minimum,unsigned int unary,int mode,int previous,unsigned int context);
/* PARSE_EXPRESSION: parses a whole expression (including commas unless mode stops
   them); unary is an identifier already read by the caller, or 0. See STEVALN. */
unsigned int far pascal PARSE_EXPRESSION(unsigned int unary,int mode)
{
    return STEVALN(0,unary,mode,0,2);
}

/* ---- STEVALN (listing ovr_1cf8_92bb:2BC8) ---- */
static unsigned int near pascal STUNARY(unsigned int name,unsigned int context);
unsigned int far pascal TYPECHECK_OPERATOR(int op,unsigned int left,unsigned int right);
extern int TOKEN_TYPE;
extern unsigned int EXPR_POOL_SEG;
extern unsigned char TOKEN_PUSHED_BACK;
extern int far pascal LEX_NEXT_TOKEN(void);
extern void far cdecl REPORT_FATAL(unsigned int);
extern void far cdecl REPORT_WARNING();
extern void far cdecl REPORT_AND_SKIP(unsigned int,char far *);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
#define NEXT (_AX=TOKEN_PUSHED_BACK?(TOKEN_PUSHED_BACK=0,TOKEN_TYPE):LEX_NEXT_TOKEN())
/* STEVALN: precedence climbing. Parses a unary expression, then binary operators whose
   priority is at least "minimum" (equal priority only for right-associative levels,
   LEVEL_ASSOCIATIVITY), recursing for the right operand with the operator's priority.
   mode says which token ends the expression besides the normal ones: 1 argument list
   (commas build argument-list cells 0x2B), 2 stop at a comma, 3 stop at ':' (middle of
   ?:), 4 stop at token 10 (the end of a #if line, probably). previous is the operator
   just left of this operand, for the "ambiguous operators need parentheses" warning
   given when different operators of priorities 7..13 (probably bitwise, shift and
   comparison levels) are mixed. context is passed to string literal handling. Returns
   the tree, or 0 after a syntax error. */
static unsigned int near pascal STEVALN(int minimum,unsigned int unary,int mode,int previous,unsigned int context)
{
    unsigned int temp;
    int associativity;
    unsigned int line;
    int op,priority;
    if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    _DI=STUNARY(unary,context);
    if(_DI==0) return 0;
    _BX=minimum;
    associativity=LEVEL_ASSOCIATIVITY[_BX];
    for(;;) {
        if(TOKEN_TYPE>0x29) break;
        if(mode==4 && TOKEN_TYPE==10) break;
        if(mode==2 && TOKEN_TYPE==8) break;
        if(mode==3 && TOKEN_TYPE==0x21) break;
        _BX=TOKEN_TYPE;
        priority=BINARY_PRIORITY_BY_TOKEN[_BX];
        if(priority==0) break;
        _BX=TOKEN_TYPE;
        op=OPERATOR_BY_TOKEN[_BX];
        LOGICAL_LINE=line=CURRENT_LINE;
        if(op!=previous && minimum>=7 && priority>=7) {
            if(minimum<=12 && priority<=12) {
                _AX=_AX;
                goto warning;
            }
            if(minimum==13 && priority==12) goto warning;
            if(minimum==12 && priority==13) {
warning:
                REPORT_WARNING(MSG_AMBIGUOUS_OPERATORS);
            }
        }
        if(minimum>priority) break;
        if(minimum==priority && associativity==1) break;
        /* ?: : parse the middle up to ':', then the right side at TERNARY_ELSE_LEVEL */
        if(op==0x25) {
            NEXT;
            _SI=STEVALN(0,0,3,0,context);
            if(_SI==0) return 0;
            if(TOKEN_TYPE!=0x21) {
                REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);
                return 0;
            }
            NEXT;
            temp=STEVALN(TERNARY_ELSE_LEVEL,0,mode,0,context);
            if(temp==0) return 0;
            LOGICAL_LINE=line;
            _SI=TYPECHECK_OPERATOR(0x26,_SI,temp);
            _DI=TYPECHECK_OPERATOR(0x25,_DI,_SI);
        } else {
            NEXT;
            _SI=STEVALN(priority,0,mode,op,context);
            if(_SI==0) return 0;
            LOGICAL_LINE=line;
            /* the comma operator: in an argument list it builds a list cell instead */
            if(op==0x2A) {
                if(mode==1) _DI=NEW_EXPR_NODE_HOOK(0x2B,PLAIN_INT_TYPE,_DI,_SI);
                else _DI=NEW_EXPR_NODE_HOOK(0x2A,(_ES=EXPR_POOL_SEG,*((unsigned int far *)MK_FP(_ES,_SI+EXPR_TYPE))),_DI,_SI);
            } else _DI=TYPECHECK_OPERATOR(op,_DI,_SI);
        }
    }
    return _DI;
}
#undef NEXT

/* ---- STUNARY (listing ovr_1cf8_92bb:2E02) ---- */
static void near pascal STDEFARG(unsigned int name);
unsigned int far pascal PARSE_TYPE_NAME_PAREN(void);
static unsigned int near pascal RESOLVE_IDENTIFIER(register unsigned int name);
static unsigned int near pascal BUILD_SUBSCRIPT(register unsigned int left,register unsigned int right);
static void near pascal REPORT_INCOMPATIBLE_TYPE(void);
static unsigned int near pascal BUILD_FUNCTION_CALL(register unsigned int expression,unsigned int value);
static unsigned int near pascal STCVT6(register unsigned int node);
unsigned int far pascal STCVT8(void);
static unsigned int near pascal STCVT9(register unsigned int node,unsigned int left,unsigned int right);
static int near pascal STCVTB(unsigned int node,unsigned int mask);
int far pascal IS_ADDRESSABLE_EXPR(register unsigned int node);
extern unsigned int EXPR_POOL_SEG; extern unsigned int DIAG_NAME_BUFFER;
extern unsigned char LANGUAGE_MODE; extern unsigned char TOKEN_PUSHED_BACK;
extern signed char TOKEN_AUX;
extern unsigned long TOKEN_CONST_VALUE;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int,unsigned long);
extern unsigned int (far pascal *NEW_SYMBOL_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *DECAY_TO_POINTER_HOOK)(unsigned int,unsigned int,int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void far cdecl REPORT_ERROR();
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal BCC_LEX_RESTORE(unsigned int);
extern int far pascal TOKEN_STARTS_TYPE(unsigned int);
extern unsigned int far pascal NEW_REAL_CONSTANT_NODE(void far *,unsigned int);
extern unsigned int far pascal NEW_EXPR_LEAF(signed char,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_EXPRESSION_TYPE(unsigned int,unsigned int);
extern unsigned int far pascal PTR_TYPE_FOR_MODIFIER(unsigned int,unsigned char,unsigned int,unsigned char);
extern unsigned int far pascal NEW_ARRAY_TYPE(unsigned long,unsigned int,unsigned int);
extern unsigned int far pascal NEW_POINTER_TYPE(unsigned int,unsigned char,int,unsigned int,int);
extern unsigned int far pascal MERGE_DUPLICATE_BYTES(unsigned int);
extern unsigned int far pascal BYTE_POOL_LENGTH(void);
extern void far pascal EMIT_VALUE(unsigned char);
#define LOW (((unsigned int near *)&TOKEN_CONST_VALUE)[0])
#define HIGH (((unsigned int near *)&TOKEN_CONST_VALUE)[1])
#define NEXT (_AX=TOKEN_PUSHED_BACK?(TOKEN_PUSHED_BACK=0,TOKEN_TYPE):LEX_NEXT_TOKEN())
#define READ_UNARY NEXT; _SI=STUNARY(0,context); if(_SI==0) return 0
/* STUNARY: parses a unary expression: a prefix operator applied to a unary expression,
   sizeof, a cast, a parenthesised expression, a constant, a string literal, an
   identifier (or, with name nonzero, the identifier the caller already read), followed
   by any postfix operators. context nonzero means string literals are emitted into the
   data being built (probably in initialisers). Returns the node or 0 after a syntax
   error. */
static unsigned int near pascal STUNARY(unsigned int name,unsigned int context)
{
    unsigned int mode,count,type;
    LOGICAL_LINE=CURRENT_LINE;
    if(name) goto named;
    switch(TOKEN_TYPE) {
    /* prefix * & - + ! ~ ++ --: ++x and --x are built as x += 1 and x -= 1 */
    case 0x18:
        READ_UNARY;
        _AX=TYPECHECK_OPERATOR(0x31,_SI,0); goto result;
    case 0x1B:
        READ_UNARY;
        _AX=TYPECHECK_OPERATOR(0x32,_SI,0); goto result;
    case 0x17:
        READ_UNARY;
        _AX=TYPECHECK_OPERATOR(0x2E,_SI,0); goto result;
    case 0x16:
        READ_UNARY;
        _ES=EXPR_POOL_SEG;
        if(ES_W(_SI,EXPR_KIND)==0) goto postfix;
        if(STCVTB(_SI,0x10)) {
            _AX=STCVT8(); goto result;
        }
        _SI=STCVT6(_SI); goto postfix;
    case 0x2A:
        READ_UNARY;
        _AX=TYPECHECK_OPERATOR(0x30,_SI,0); goto result;
    case 0x2B:
        READ_UNARY;
        _AX=TYPECHECK_OPERATOR(0x2F,_SI,0); goto result;
    case 0x2D:
        READ_UNARY;
        _DI=NEW_CONST_NODE_HOOK(PLAIN_INT_TYPE,1L);
        _AX=TYPECHECK_OPERATOR(0x13,_SI,_DI); goto result;
    case 0x2E:
        READ_UNARY;
        _DI=NEW_CONST_NODE_HOOK(PLAIN_INT_TYPE,1L);
        _AX=TYPECHECK_OPERATOR(0x14,_SI,_DI); goto result;
    /* sizeof (type) or sizeof expr: a constant of the size, unsigned (or unsigned long,
       MODE_HOOK(8), for a huge array) */
    case 0x2C:
        NEXT;
        if(_AX==1) {
            NEXT;
            if(TOKEN_STARTS_TYPE(_AX)) {
                type=PARSE_TYPE_NAME_PAREN();
                if(type==0) return 0;
                TOKEN_CONST_VALUE=(unsigned long)SIZE_OF_TYPE_CHECKED_HOOK(type);
                if(TOKEN_CONST_VALUE==0L) REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
                _ES=TYPE_POOL;_BX=type;
                if(ES_B(_BX,TYPE_KIND)==0x11 && ES_B(_BX,TYPE_C_BYTE9)) mode=8;
                else mode=6;
                _AX=NEW_CONST_NODE_HOOK(MODE_HOOK(mode),TOKEN_CONST_VALUE);goto result;
            }
            _DI=STEVALN(0,0,0,0,0);
            if(_DI==0) return 0;
            if(TOKEN_TYPE!=2) {
                REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);return 0;
            }
            NEXT;
        } else {
            _DI=STUNARY(0,context);
            if(_DI==0) return 0;
        }
        _ES=EXPR_POOL_SEG;
        if(ES_W(_DI,EXPR_OP)==0x32 && (ES_W(ES_W(_DI,EXPR_LEFT),EXPR_KIND)==0x11 || ES_W(ES_W(_DI,EXPR_LEFT),EXPR_KIND)==0x12)) {
            _ES=EXPR_POOL_SEG;_BX=ES_W(_DI,EXPR_LEFT);_AX=ES_W(_BX,EXPR_TYPE);
        } else {
            _ES=EXPR_POOL_SEG;
            if(ES_W(_DI,EXPR_OP)==0x33) {REPORT_ERROR(MSG_SIZEOF_MAY_NOT_APPLIED);_AX=PLAIN_INT_TYPE;}
            else {_ES=EXPR_POOL_SEG;_AX=ES_W(_DI,EXPR_TYPE);}
        }
        type=_AX;
        _ES=TYPE_POOL;_BX=type;
        if(ES_B(_BX,TYPE_KIND)==0x12) {
            REPORT_ERROR(MSG_SIZEOF_MAY_NOT_APPLIED_257);TOKEN_CONST_VALUE=1L;
        } else {
            TOKEN_CONST_VALUE=(unsigned long)SIZE_OF_TYPE_CHECKED_HOOK(type);
            if(TOKEN_CONST_VALUE==0L) REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
        }
        _ES=TYPE_POOL;_BX=type;
        if(ES_B(_BX,TYPE_KIND)==0x11 && ES_B(_BX,TYPE_C_BYTE9)) mode=8;
        else mode=6;
        _AX=NEW_CONST_NODE_HOOK(MODE_HOOK(mode),TOKEN_CONST_VALUE);goto result;
    /* ( type ) cast, or a parenthesised expression */
    case 1:
        NEXT;
        if(TOKEN_STARTS_TYPE(_AX)) {
            type=PARSE_TYPE_NAME_PAREN();if(type==0) return 0;
            _SI=STUNARY(0,context);if(_SI==0) return 0;
            _DI=CONVERT_EXPRESSION_TYPE(_SI,type);
            if(_DI==0) {
                _ES=EXPR_POOL_SEG;
                if(ES_W(_SI,EXPR_KIND)==12) {REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);goto postfix;}
                REPORT_INCOMPATIBLE_TYPE();goto postfix;
            }
            _SI=_DI;goto postfix;
        }
        _SI=STEVALN(0,0,0,0,context);if(_SI==0) return 0;
        if(TOKEN_TYPE!=2) {REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);return 0;}
        NEXT;goto postfix;
    /* the "..." token inside a variadic function: the address of the unnamed arguments */
    case 9:
        if(LANGUAGE_MODE==1 || C_DECL_SCOPE==C_GLOBAL_SCOPE) goto invalid_this;
        _BX=C_CURRENT_FUNCTION_SYMBOL;_ES=CSYM_POOL_SEG;_BX=ES_W(_BX,CSYM_TYPE);_ES=TYPE_POOL;
        if(ES_B(_BX,TYPE_C_FUNC_FLAGS)&4) goto valid_this;
invalid_this:
        REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
valid_this:
        _SI=NEW_EXPR_LEAF(7,PLAIN_INT_TYPE,0);
        _SI=TYPECHECK_OPERATOR(0x32,_SI,0);NEXT;goto postfix;
    case 0x31:
        name=LOW;NEXT;goto named;
    case 0x32: case 0x65:
        _SI=NEW_CONST_NODE_HOOK(MODE_HOOK(TOKEN_AUX),TOKEN_CONST_VALUE);NEXT;goto postfix;
    case 0x33:
        if(MACRO_MODE && LANGUAGE_MODE==1) {REPORT_AND_SKIP(MSG_ILLEGAL_USE_FLOATING,(char far *)0);return 0;}
        _SI=NEW_REAL_CONSTANT_NODE(&TOKEN_CONST_VALUE,MODE_HOOK(TOKEN_AUX));NEXT;goto postfix;
    /* adjacent string literals are concatenated into the byte pool; the literal is an
       array of char at an offset in C_STRING_LITERAL_SYMBOL, decayed to a pointer */
    case 0x34:
        mode=BYTE_POOL_LENGTH();count=0;
        do {BCC_LEX_RESTORE(context);count+=LOW;NEXT;} while(_AX==0x34);
        if(context) {
            EMIT_VALUE(0);
            if(OPTION_MERGE_STRINGS) mode=MERGE_DUPLICATE_BYTES(mode);
        }
        type=NEW_ARRAY_TYPE((unsigned long)(count+1),STRING_CHAR_TYPE,0);
        _SI=NEW_SYMBOL_NODE_HOOK(1,type,C_STRING_LITERAL_SYMBOL,mode,4);
        _BX=type;_ES=TYPE_POOL;
        _AX=DECAY_TO_POINTER_HOOK(ES_W(_BX,TYPE_TARGET),_SI,0);goto result;
    default:REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);return 0;
    }
named:
    STDEFARG(name);
    _AX=RESOLVE_IDENTIFIER(name);
result:
    _SI=_AX;
/* postfix operators, as long as they follow */
postfix:
    for(;;) {
        switch(TOKEN_TYPE) {
        case 0x2D:_SI=TYPECHECK_OPERATOR(0x23,_SI,0);break;
        case 0x2E:_SI=TYPECHECK_OPERATOR(0x24,_SI,0);break;
        case 3:
            NEXT;_DI=STEVALN(0,0,0,0,context);if(_DI==0) return 0;
            if(TOKEN_TYPE!=4) {REPORT_AND_SKIP(MSG_MISSING,(char far *)STR_SUBSCRIPTING_2);return 0;}
            _SI=BUILD_SUBSCRIPT(_SI,_DI);break;
        case 1:
            NEXT;
            if(_AX==2) _DI=0;
            else {
                _DI=STEVALN(0,0,1,0,context);if(_DI==0) return 0;
                if(TOKEN_TYPE!=2) {REPORT_AND_SKIP(MSG_FUNCTION_CALL_MISSING,(char far *)0);return 0;}
            }
            LOGICAL_LINE=CURRENT_LINE;
            _SI=BUILD_FUNCTION_CALL(_SI,_DI);break;
        /* object.member: the object must be a struct; its address is taken (a temporary
           address for a non-lvalue such as a function result) and handled as p->member */
        case 0x2F:
            NEXT;
            if(_AX!=0x31) {REPORT_AND_SKIP(MSG_INVALID_USE_DOT,(char far *)0);return 0;}
            LOGICAL_LINE=CURRENT_LINE;
            _ES=EXPR_POOL_SEG;
            if(ES_W(_SI,EXPR_KIND)==0) break;
            _ES=EXPR_POOL_SEG;
            if(ES_W(_SI,EXPR_KIND)!=0x13) {REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);_SI=STCVT8();break;}
            if(!IS_ADDRESSABLE_EXPR(_SI)) {
                _ES=EXPR_POOL_SEG;
                if(ES_W(_SI,EXPR_OP)==0x2A) {
                    _AX=NEW_EXPR_NODE_HOOK(0x32,PTR_TYPE_FOR_MODIFIER(ES_W(_SI,EXPR_TYPE),0,0,0),
                        (_ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_RIGHT)),0);
                    _ES=EXPR_POOL_SEG;ES_W(_SI,EXPR_RIGHT)=_AX;
                    _BX=ES_W(_SI,EXPR_RIGHT);_AX=ES_W(_BX,EXPR_KIND);ES_W(_SI,EXPR_KIND)=_AX;
                    _BX=ES_W(_SI,EXPR_RIGHT);_AX=ES_W(_BX,EXPR_TYPE);ES_W(_SI,EXPR_TYPE)=_AX;
                } else {
                    _SI=NEW_EXPR_NODE_HOOK(0x32,NEW_POINTER_TYPE((_ES=EXPR_POOL_SEG,ES_W(_SI,EXPR_TYPE)),13,0,0,3),_SI,0);
                    _SI=_SI;
                }
            } else _SI=TYPECHECK_OPERATOR(0x32,_SI,0);
            _SI=STCVT9(_SI,LOW,C_DECL_SCOPE);
            if(_SI) break;
            DIAG_NAME_BUFFER=0;REPORT_ERROR(MSG_UNDEFINED_SYMBOL,NAME_TEXT_COPY(LOW));
            _SI=STCVT8();break;
        case 0x30:
            NEXT;
            if(_AX!=0x31) {REPORT_AND_SKIP(MSG_FIELD_IDENTIFIER,(char far *)0);return 0;}
            LOGICAL_LINE=CURRENT_LINE;
            _ES=EXPR_POOL_SEG;
            if(ES_W(_SI,EXPR_KIND)==0) break;
            _ES=EXPR_POOL_SEG;_BX=ES_W(_SI,EXPR_KIND);
            if(!((unsigned int)EXPR_FLAGS[_BX]&0x14)) goto bad_member;
            _BX=ES_W(_SI,EXPR_TYPE);_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_C_TARGET);
            if(ES_B(_BX,TYPE_KIND)==0x13) goto good_member;
bad_member:
            REPORT_ERROR(MSG_POINTER_REQUIRED_LEFT);_SI=STCVT8();break;
good_member:
            _SI=STCVT9(_SI,LOW,C_DECL_SCOPE);
            if(_SI==0) {
                DIAG_NAME_BUFFER=0;REPORT_ERROR(MSG_UNDEFINED_SYMBOL,NAME_TEXT_COPY(LOW));
                _SI=STCVT8();
            }
            break;
        default:return _SI;
        }
        NEXT;
    }
}
#undef LOW
#undef HIGH
#undef NEXT
#undef READ_UNARY

/* ---- STDEFARG (listing ovr_1cf8_92bb:384F) ---- */
extern unsigned int DIAG_NAME_BUFFER; extern unsigned int CODE_SEGMENT_ID;
extern unsigned char OPTION_CALLING_CONVENTION; extern unsigned char MODEL_FAR_CODE;
extern int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern void far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);

/* STDEFARG: when an undeclared identifier is called (followed by '('), declares it as
   an extern function of IMPLICIT_FUNCTION_TYPE (int f()) with the default calling
   convention and code model, warning "No declaration for function" unless
   WARN_PRO_FLAG is set. */
static void near pascal STDEFARG(unsigned int name)
{
    register unsigned int flags;
    if(TOKEN_TYPE==1 && !LOOKUP_SYMBOL(name,C_DECL_SCOPE,0)) {
        if(WARN_PRO_FLAG==0) {
            DIAG_NAME_BUFFER=0;
            REPORT_WARNING(MSG_NO_DECLARATION,NAME_TEXT_COPY(name));
        }
        flags=0;
        if(OPTION_CALLING_CONVENTION==1) flags=0x400;
        else if(OPTION_CALLING_CONVENTION==2) flags=0x2000;
        if(MODEL_FAR_CODE) flags|=0x10;
        DECLARE_SYMBOL(name,C_DECL_SCOPE,0,2,IMPLICIT_FUNCTION_TYPE,
            MODEL_FAR_CODE?0xFFFF:CODE_SEGMENT_ID,flags);
    }
}

/* ---- STPRIM (listing ovr_1cf8_92bb:38E1) ---- */
extern unsigned int  C_DECL_STORAGE_CLASS;
extern unsigned int far pascal BCC_STMT_BUILD(void);
extern unsigned int far pascal PARSE_ABSTRACT_DECLARATOR(void);
extern unsigned int far pascal BCC_STMT_BIND_TYPE(unsigned int,unsigned int);

#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* PARSE_TYPE_NAME_PAREN: parses "type-name )" after a '(' (in casts and sizeof) and
   returns the type; a storage class is an error. */
unsigned int far pascal PARSE_TYPE_NAME_PAREN(void)
{
    register unsigned int stmt;
    register unsigned int type;
    stmt=BCC_STMT_BUILD();
    if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258,(char far *)STORAGE_CLASS_NAMES[C_DECL_STORAGE_CLASS]);
    if(stmt==0) return 0;
    type=PARSE_ABSTRACT_DECLARATOR();
    if(type==0) return 0;
    if(TOKEN_TYPE!=2) {REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);return 0;}
    NEXT();
    return BCC_STMT_BIND_TYPE(type,stmt);
}
#undef NEXT

/* ---- STCONST (listing ovr_1cf8_92bb:3960) ---- */
extern unsigned int  EXPR_POOL_SEG;
extern unsigned char TOKEN_PUSHED_BACK;
extern void (far pascal *RESET_EXPR_POOL_HOOK)(void);
extern unsigned int far pascal EXPR_POOL_IS_RESET(void);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);
/* PARSE_CONSTANT_EXPR: parses a constant expression for the C declaration and
   statement parsers and stores its value in TOKEN_CONST_VALUE (0 after an error). mode
   says where it stands and which token must follow: 1 array bound (then ]), 2 bitfield
   width or initializer (, or ;), 4 enumerator value (, or }), 5 #if line, 3 case label
   (:). Returns 0 after a syntax error, else 1. Frees the expression nodes when the pool
   was empty on entry. */
unsigned int far pascal PARSE_CONSTANT_EXPR(unsigned int mode)
{
    unsigned int active;
    register unsigned int node;
    active=EXPR_POOL_IS_RESET();
    switch(mode) {
    case 1:
        node=STEVALN(0,0,0,0,2);
        if(TOKEN_TYPE!=4) {
            REPORT_AND_SKIP(MSG_MISSING,(char far *)MK_FP(_DS,(unsigned)(STR_ARRAY_BOUNDS_2)));
            return 0;
        }
        _AX=TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN();
        break;
    case 2:
        node=STEVALN(0,0,2,0,2);
        if(TOKEN_TYPE!=8 && TOKEN_TYPE!=7) {
            REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);
            return 0;
        }
        break;
    case 4:
        node=STEVALN(0,0,2,0,2);
        if(TOKEN_TYPE!=8 && TOKEN_TYPE!=6) {
            REPORT_AND_SKIP(MSG_ENUM_SYNTAX_ERROR,(char far *)0);
            return 0;
        }
        break;
    case 5:
        MACRO_MODE=1;
        _AX=TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN();
        node=STEVALN(0,0,4,0,2);
        MACRO_MODE=0;
        if(TOKEN_TYPE!=10) {
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
            TOKEN_CONST_VALUE=0L;
            return 0;
        }
        break;
    case 3:
        node=STEVALN(0,0,3,0,2);
        if(TOKEN_TYPE!=33) {
            REPORT_ERROR(MSG_CASE_STATEMENT_MISSING);
            TOKEN_CONST_VALUE=0L;
            return 1;
        }
        break;
    }
    node=FOLD_EXPRESSION(node);
    _ES=EXPR_POOL_SEG;
    if(ES_W(node,EXPR_KIND)==0) TOKEN_CONST_VALUE=0L;
    else {
        _ES=EXPR_POOL_SEG;
        if(ES_W(node,EXPR_OP)==2) TOKEN_CONST_VALUE=*((long far *)MK_FP(_ES,node+EXPR_LEFT));
        else {
            REPORT_ERROR(MSG_CONSTANT_EXPRESSION);
            TOKEN_CONST_VALUE=0L;
        }
    }
    if(active) RESET_EXPR_POOL_HOOK();
    return 1;
}

/* ---- STREL (listing ovr_1cf8_92bb:3B34) ---- */
unsigned int far pascal STCVTC(register unsigned int node);
extern unsigned int DIAG_NAME_BUFFER;
extern unsigned int far pascal BUILD_SYMBOL_OPERAND(unsigned int,unsigned int,unsigned int);

/* RESOLVE_IDENTIFIER: the expression for a name: a symbol leaf (arrays and functions
   decayed by STCVTC). An undefined name is 0 inside #if; otherwise it is reported and
   entered as a class-9 symbol of MODE_HOOK(0) type, probably so it is reported once. */
static unsigned int near pascal RESOLVE_IDENTIFIER(register unsigned int name)
{
    register unsigned int found;
    found=BUILD_SYMBOL_OPERAND(name,C_DECL_SCOPE,0);
    if(found==0) {
        if(MACRO_MODE) return NEW_CONST_NODE_HOOK(PLAIN_INT_TYPE,0L);
        DIAG_NAME_BUFFER=0;
        REPORT_ERROR(MSG_UNDEFINED_SYMBOL,NAME_TEXT_COPY(name));
        DECLARE_SYMBOL(name,C_DECL_SCOPE,0,9,MODE_HOOK(0),0,0);
        return STCVT8();
    }
    return STCVTC(found);
}

/* ---- STMERGE (listing ovr_1cf8_92bb:3BB2) ---- */
static unsigned int near pascal SCALE_INDEX(unsigned int left,unsigned int right);
extern unsigned int EXPR_POOL_SEG;
/* BUILD_SUBSCRIPT: a[i] (either operand may be the pointer) as *(a + i * element size).
   _seg pointers go through the + case of TYPECHECK_OPERATOR. */
static unsigned int near pascal BUILD_SUBSCRIPT(register unsigned int left,register unsigned int right)
{
    if(EXPR_W(left,EXPR_TYPE)==0) return left;
    if(EXPR_W(right,EXPR_TYPE)==0) return right;
    if(EXPR_W(left,EXPR_KIND)==TK_SEG_PTR || EXPR_W(right,EXPR_KIND)==TK_SEG_PTR) {
        right=TYPECHECK_OPERATOR(8,left,right);
    } else if(EXPR_FLAGS[EXPR_W(left,EXPR_KIND)]&0x14) {
        right=SCALE_INDEX(right,left);
        right=NEW_EXPR_NODE_HOOK(8,EXPR_W(left,EXPR_TYPE),left,right);
    } else {
        left=SCALE_INDEX(left,right);
        right=NEW_EXPR_NODE_HOOK(8,EXPR_W(right,EXPR_TYPE),right,left);
    }
    right=TYPECHECK_OPERATOR(0x31,right,0);
    return right;
}

/* ---- STTYPE (listing ovr_1cf8_92bb:3C52) ---- */
unsigned int far pascal STASSIGN(register unsigned int expression,unsigned int target);
static unsigned int near pascal STCVT5(register unsigned int node);
/* SCALE_INDEX: converts the index left to int (long for a huge pointer right) and
   multiplies it by the element size of right (operator 10, EOP_MUL). */
static unsigned int near pascal SCALE_INDEX(unsigned int left,unsigned int right)
{
    unsigned int type;
    _SI=left;_DI=right;
    _ES=EXPR_POOL_SEG;
    type=MODE_HOOK(ES_W(_DI,EXPR_KIND)==16?7:5);
    _SI=STASSIGN(_SI,type);
    _SI=NEW_EXPR_NODE_HOOK(10,type,_SI,STCVT5(_DI));
    return _AX;
}

/* ---- STCHECK (listing ovr_1cf8_92bb:3CA2) ---- */
/* PROMOTE_CALL_ARGS: default argument promotions for a call without a prototype, over
   the argument list: float to double, small integers and enums to int (STCVT6);
   a struct argument gets the "structure passed by value" warning. */
static unsigned int near pascal PROMOTE_CALL_ARGS(register unsigned int expression)
{
    register unsigned int item;
    if(!expression) return 0;
    if(EXPR_W(expression,EXPR_OP)==0x2B) {
        EXPR_W(expression,EXPR_LEFT)=PROMOTE_CALL_ARGS(EXPR_W(expression,EXPR_LEFT));
        item=EXPR_W(expression,EXPR_RIGHT);
    } else item=expression;
    if(EXPR_W(item,EXPR_KIND)==TK_STRUCT) REPORT_WARNING(MSG_STRUCTURE_PASSED_VALUE);
    else {
        if(EXPR_W(item,EXPR_KIND)==TK_FLOAT) item=CONVERT_EXPRESSION_TYPE(item,MODE_HOOK(10));
        else item=STCVT6(item);
        if(EXPR_W(expression,EXPR_OP)==0x2B) EXPR_W(expression,EXPR_RIGHT)=item;
        else expression=item;
    }
    return expression;
}

/* ---- STASSIGN (listing ovr_1cf8_92bb:3D29) ---- */
static int near pascal POINTER_TARGETS_COMPATIBLE(register unsigned int left,register unsigned int right,int mode);
static int near pascal POINTER_KIND_COMPATIBLE(register unsigned int left,register unsigned int right);
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal NARROW_FAR_POINTER(unsigned int);
extern int far pascal TYPE_RECORDS_COMPATIBLE(unsigned int,unsigned int,unsigned char);
/* STASSIGN: converts expression to type target as assignment does, with C's warnings:
   integer to pointer ("nonportable pointer conversion", an error for long to a short
   pointer), pointers losing const/volatile or to different types ("suspicious pointer
   conversion", or "mixing pointers to signed and unsigned char"), long to int
   ("conversion may lose significant digits"); arrays, functions and structs as targets
   are "incompatible type". The literal 0 converts to any pointer silently. */
unsigned int far pascal STASSIGN(register unsigned int expression,unsigned int target)
{
    unsigned int oldType;
    int oldKind,oldFlags,oldBit,newFlags,newBit;
    register int kind;
    _ES=EXPR_POOL_SEG;
    if(ES_W(expression,EXPR_OP)==0) return expression;
    _ES=EXPR_POOL_SEG;
    if((oldType=ES_W(expression,EXPR_TYPE))==target) return expression;
    expression=FOLD_EXPRESSION(expression);
    _ES=EXPR_POOL_SEG;
    oldKind=ES_W(expression,EXPR_KIND);
    _ES=TYPE_POOL; _BX=target;
    kind=ES_B(_BX,TYPE_KIND);
    switch(kind) {
    case 12:
        /* Keep this switch entry distinct from the shared conversion tail. */
        expression=expression;
        goto convert;
    case 17: case 18: case 19:
        REPORT_INCOMPATIBLE_TYPE();
        return expression;
    case 13: case 14: case 15: case 16:
        expression=NARROW_FAR_POINTER(expression);
        _ES=EXPR_POOL_SEG;
        oldKind=ES_W(expression,EXPR_KIND);
        oldType=ES_W(expression,EXPR_TYPE);
        if(ES_W(expression,EXPR_OP)==2 && *((unsigned long far *)MK_FP(_ES,expression+EXPR_LEFT))==0L &&
           (oldKind!=13 || (kind!=15 && kind!=16))) {
            _ES=EXPR_POOL_SEG;
            ES_W(expression,EXPR_TYPE)=target;
            ES_W(expression,EXPR_KIND)=kind;
            return expression;
        }
        if(EXPR_FLAGS[oldKind]&1) {
            if(kind!=15 && (oldKind==7 || oldKind==8)) REPORT_ERROR(MSG_NONPORTABLE_POINTER);
            else {
                REPORT_WARNING(MSG_NONPORTABLE_POINTER_375);
                /* Preserve the separate original diagnostic call. */
                expression=expression;
            }
        } else if(EXPR_FLAGS[oldKind]&0x14) {
            _BX=oldType; _ES=TYPE_POOL;
            oldFlags=(signed char)ES_B(_BX,TYPE_C_PTR_QUALS);
            _BX=target; newFlags=(signed char)ES_B(_BX,TYPE_C_PTR_QUALS);
            oldBit=oldFlags&1;
            newBit=newFlags&1;
            oldFlags&=2;
            newFlags&=2;
            if(newFlags<oldFlags || newBit<oldBit) REPORT_WARNING(MSG_SUSPICIOUS_POINTER);
            else if(!POINTER_TARGETS_COMPATIBLE(oldType,target,1)) {
                _BX=oldType; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_C_TARGET);
                if(ES_B(_BX,TYPE_KIND)<=2 && (_BX=target,_BX=ES_W(_BX,TYPE_C_TARGET),ES_B(_BX,TYPE_KIND))<=2 && POINTER_KIND_COMPATIBLE(oldType,target))
                    REPORT_WARNING(MSG_MIXING_POINTERS_SIGNED);
                else REPORT_WARNING(MSG_SUSPICIOUS_POINTER);
            }
        }
        _ES=EXPR_POOL_SEG;
        if(ES_W(expression,EXPR_OP)==0x32 && oldKind==kind) {
            _BX=oldType; _ES=TYPE_POOL;
            if(TYPE_RECORDS_COMPATIBLE(ES_W(_BX,TYPE_C_TARGET),(_BX=target,ES_W(_BX,TYPE_C_TARGET)),1)) {
                _ES=EXPR_POOL_SEG;
                ES_W(expression,EXPR_TYPE)=target;
                return expression;
            }
        }
        break;
    }
    switch(oldKind) {
    case 7: case 8:
        if(kind==5 || kind==6) REPORT_WARNING(MSG_CONVERSION_MAY_LOSE);
        break;
    case 13: case 14: case 15: case 16:
        if(EXPR_FLAGS[kind]&2) REPORT_INCOMPATIBLE_TYPE();
        if(EXPR_FLAGS[kind]&1) {
            if(oldKind==15) {
                if(kind==7 || kind==8) REPORT_WARNING(MSG_NONPORTABLE_POINTER_375);
                else REPORT_ERROR(MSG_NONPORTABLE_POINTER);
            } else {
                if(kind==7 || kind==8) REPORT_ERROR(MSG_NONPORTABLE_POINTER);
                else REPORT_WARNING(MSG_NONPORTABLE_POINTER_375);
            }
        }
        break;
    case 9: case 10:
        if(EXPR_FLAGS[kind]&0x14) REPORT_INCOMPATIBLE_TYPE();
        break;
    case 12:
        REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
        break;
    case 19:
        REPORT_INCOMPATIBLE_TYPE();
        return expression;
    }
convert:
    return CONVERT_EXPRESSION_TYPE(expression,target);
}

/* ---- STCOMPAT (listing ovr_1cf8_92bb:3FE3) ---- */
/* POINTER_TARGETS_COMPATIBLE: 1 when two C pointer types have compatible kinds and
   compatible targets (void * matches anything); mode goes to TYPE_RECORDS_COMPATIBLE. */
static int near pascal POINTER_TARGETS_COMPATIBLE(register unsigned int left,register unsigned int right,int mode)
{
    if(!POINTER_KIND_COMPATIBLE(left,right)) return 0;
    if(TYPE_B(TYPE_W(left,TYPE_C_TARGET),TYPE_KIND)==TK_VOID || TYPE_B(TYPE_W(right,TYPE_C_TARGET),TYPE_KIND)==TK_VOID) return 1;
    return TYPE_RECORDS_COMPATIBLE(TYPE_W(left,TYPE_C_TARGET),TYPE_W(right,TYPE_C_TARGET),(unsigned char)mode);
}

/* ---- STSAME (listing ovr_1cf8_92bb:4035) ---- */
/* POINTER_KIND_COMPATIBLE: 1 when a pointer of type right may be used as left as far as
   the pointer kinds go: anything converts to huge, far to anything but huge, _seg only
   to _seg, near only to near with the same segment mode. */
static int near pascal POINTER_KIND_COMPATIBLE(register unsigned int left,register unsigned int right)
{
    switch((int)TYPE_B(right,TYPE_KIND)) {
    case 14:
        if(TYPE_B(left,TYPE_KIND)==TK_SEG_PTR) return 1;
        return 0;
    case 16:
        return 1;
    case 15:
        if(TYPE_B(left,TYPE_KIND)==TK_HUGE_PTR) return 0;
        return 1;
    case 13:
        if(TYPE_B(left,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(left,TYPE_C_FUNC_FLAGS)==TYPE_B(right,TYPE_C_FUNC_FLAGS)) return 1;
        return 0;
    }
    return 0;
}

/* ---- STWARN (listing ovr_1cf8_92bb:40AE) ---- */
/* REPORT_INCOMPATIBLE_TYPE: reports MSG_INCOMPATIBLE_TYPE. */
static void near pascal REPORT_INCOMPATIBLE_TYPE(void)
{
    REPORT_ERROR(MSG_INCOMPATIBLE_TYPE);
}

/* ---- STCAST (listing ovr_1cf8_92bb:40BA) ---- */
static unsigned int near pascal ADD_HIDDEN_RETURN_ARG(unsigned int type,register unsigned int expression,unsigned int value);
static unsigned int near pascal STCVT3(unsigned char flags,unsigned int status,register unsigned int left,register unsigned int right);
extern unsigned int EXPR_POOL_SEG; extern unsigned int CODE_SEGMENT_ID; extern unsigned int DIAG_NAME_BUFFER;
extern unsigned int (far pascal *NEW_TEMPORARY_HOOK)(unsigned int);

extern char far *far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal CHECK_EMIT_ARGUMENTS(unsigned int,unsigned int);
/* BUILD_FUNCTION_CALL: builds the call of "expression" (a function or pointer to
   function) with the argument list value. For a direct call: an intrinsic (class 10)
   checks its arguments with CHECK_EMIT_ARGUMENTS; a far function outside the current
   code segment gets CSYM flag 0x100. With a prototype the arguments are checked and
   converted (STCVT3); without one they get the default promotions and a "call to
   function with no prototype" warning. A struct result that is not 1, 2 or 4 bytes is
   returned through a temporary whose address is passed as a hidden first argument;
   the call then reads (call, temp). */
static unsigned int near pascal BUILD_FUNCTION_CALL(register unsigned int expression,unsigned int value)
{
    unsigned int status,type,special=0,size,temporary;
    register unsigned int item;
    if(EXPR_W(expression,EXPR_KIND)==TK_UNDEFINED) return expression;
    item=EXPR_W(expression,EXPR_TYPE);
    if((EXPR_FLAGS[TYPE_B(item,TYPE_KIND)]&20) && TYPE_B(TYPE_W(item,TYPE_C_TARGET),TYPE_KIND)==TK_FUNCTION) {
        item=TYPE_W(item,TYPE_C_TARGET);
        if(EXPR_W(expression,EXPR_OP)==EOP_ADDR && EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1) {
            register unsigned int record;
            expression=EXPR_W(expression,EXPR_LEFT);
            record=EXPR_W(expression,EXPR_LEFT);
            status=CSYM_W(record,CSYM_NAME);
            if(CSYM_B(record,CSYM_CLASS)==10) special=1;
            else if(TYPE_B(item,TYPE_C_FUNC_FLAGS)&1) {
                if(CSYM_W(record,CSYM_SEGMENT)!=CODE_SEGMENT_ID) CSYM_W(record,CSYM_FLAGS)|=256;
            }
        } else {
            expression=NEW_EXPR_NODE_HOOK(49,item,expression,0);
            status=0;
        }
    } else {
        REPORT_ERROR(MSG_CALL_NONFUNCTION);
        return STCVT8();
    }
    type=TYPE_W(item,TYPE_C_PARAMS);
    CALL_ARGUMENT_NUMBER=1;CALL_FUNCTION_EXPR=expression;
    value=FOLD_EXPRESSION(value);
    if((TYPE_B(item,TYPE_C_FUNC_FLAGS)&8)==0) value=STCVT3(TYPE_B(item,TYPE_C_FUNC_FLAGS)&4,type,PROMOTE_CALL_ARGS(value),status);
    else if(!special) {
        value=PROMOTE_CALL_ARGS(value);
        if(EXPR_W(expression,EXPR_OP)==1) {
            DIAG_NAME_BUFFER=0;
            REPORT_WARNING(MSG_CALL_FUNCTION_NO,NAME_TEXT_COPY(status));
        } else REPORT_WARNING(MSG_CALL_FUNCTION_NO_360);
    } else {
        value=FOLD_EXPRESSION(value);
        CHECK_EMIT_ARGUMENTS(CSYM_W(EXPR_W(expression,EXPR_LEFT),CSYM_OFFSET),value);
    }
    item=TYPE_W(item,TYPE_C_TARGET);
    if(TYPE_B(item,TYPE_KIND)==TK_ENUM) {
        if(TYPE_W(item,TYPE_C_SIZE)==1) item=MODE_HOOK(1);
        else item=PLAIN_INT_TYPE;
    } else if(TYPE_B(item,TYPE_KIND)==TK_STRUCT) {
        size=TYPE_W(item,TYPE_C_SIZE);
        if(size!=1 && size!=2 && size!=4) {
            temporary=NEW_TEMPORARY_HOOK(item);
            value=ADD_HIDDEN_RETURN_ARG(item,value,temporary);
            expression=NEW_EXPR_NODE_HOOK(54,PLAIN_INT_TYPE,expression,value);
            value=NEW_SYMBOL_NODE_HOOK(5,item,temporary,0,0);
            return NEW_EXPR_NODE_HOOK(42,item,expression,value);
        }
    }
    return NEW_EXPR_NODE_HOOK(54,item,expression,value);
}

/* ---- STCVT2 (listing ovr_1cf8_92bb:42D8) ---- */
/* ADD_HIDDEN_RETURN_ARG: puts the far address of the temporary "value" (of struct type)
   in front of the argument list expression (list cells, operator 43 = 0x2B). */
static unsigned int near pascal ADD_HIDDEN_RETURN_ARG(unsigned int type,register unsigned int expression,unsigned int value)
{
    unsigned int result;
    register unsigned int item;
    result=NEW_SYMBOL_NODE_HOOK(5,type,value,0,0);
    result=NEW_EXPR_NODE_HOOK(50,NEW_POINTER_TYPE(type,15,0,0,0),result,0);
    if(!expression) expression=result;
    else {
        if(EXPR_W(expression,EXPR_OP)!=43) expression=NEW_EXPR_NODE_HOOK(43,type,result,expression);
        else {
            item=expression;
            while(EXPR_W(EXPR_W(item,EXPR_LEFT),EXPR_OP)==43)
                item=EXPR_W(item,EXPR_LEFT);
            EXPR_W(item,EXPR_LEFT)=NEW_EXPR_NODE_HOOK(43,type,result,EXPR_W(item,EXPR_LEFT));
        }
    }
    return expression;
}

/* ---- STCVT3 (listing ovr_1cf8_92bb:437F) ---- */
static unsigned int near pascal STCVT4(unsigned char mode,unsigned int far *list,unsigned int node,unsigned int which);
extern unsigned int DIAG_NAME_BUFFER;
/* STCVT3: checks and converts the arguments left against the parameter list status of
   the function named right (0 if called through a pointer); parameters left over give
   "too few parameters in call". flags is the function's ellipsis bit (4). */
static unsigned int near pascal STCVT3(unsigned char flags,unsigned int status,register unsigned int left,register unsigned int right)
{
    left=STCVT4(flags,&status,left,right);
    if(status!=0) {
        DIAG_NAME_BUFFER=0;
        REPORT_ERROR(right!=0 ? MSG_TOO_FEW_PARAMETERS_46 : MSG_TOO_FEW_PARAMETERS,NAME_TEXT_COPY(right));
    }
    return left;
}

/* ---- STCVT4 (listing ovr_1cf8_92bb:43CD) ---- */
static int near pascal STCVT7(register unsigned int node,unsigned int type);
extern unsigned int EXPR_POOL_SEG; extern unsigned int DIAG_NAME_BUFFER;

/* STCVT4: walks the argument tree node (list cells nest through both operands) and
   pairs each argument, left to right, with the next parameter in *list: compatible
   arguments (STCVT7) are converted with STASSIGN, others give "type mismatch in
   parameter" (77..80, named or numbered by CALL_ARGUMENT_NUMBER). An argument with no
   parameter left is an "extra parameter" unless the function has an ellipsis
   (mode 4). which is the function's name record, or 0. */
static unsigned int near pascal STCVT4(unsigned char mode,unsigned int far *list,unsigned int node,unsigned int which)
{
    unsigned int type;
    _SI=node;
    if (_SI==0) return 0;
    _ES=EXPR_POOL_SEG;
    if(ES_W(_SI,EXPR_OP)==0x2B) {
        *((unsigned int far *)MK_FP(EXPR_POOL_SEG,_SI+EXPR_LEFT))=STCVT4(mode,list,ES_W(_SI,EXPR_LEFT),which);
        *((unsigned int far *)MK_FP(EXPR_POOL_SEG,_SI+EXPR_RIGHT))=STCVT4(mode,list,ES_W(_SI,EXPR_RIGHT),which);
    } else {
        _DI=*list;
        if (_DI) {
            _ES=C_PARAM_POOL_SEG;
            *list=ES_W(_DI,CPARM_NEXT);
            _ES=C_PARAM_POOL_SEG;
            type=ES_W(_DI,CPARM_TYPE);
            _ES=TYPE_POOL;
            _BX=type;
            if (ES_B(_BX,TYPE_KIND)==0x15) {
                if (ES_W(_BX,TYPE_C_SIZE)==1) type=MODE_HOOK(1);
                else type=PLAIN_INT_TYPE;
            }
            if (STCVT7(_SI,type)) {
                _SI=STASSIGN(_SI,type);
            } else {
                _ES=C_PARAM_POOL_SEG;
                if (ES_W(_DI,CPARM_NAME)) {
                    DIAG_NAME_BUFFER=0;
                    REPORT_ERROR(which?MSG_TYPE_MISMATCH_78:MSG_TYPE_MISMATCH_80,
                        NAME_TEXT_COPY((_ES=C_PARAM_POOL_SEG,ES_W(_DI,CPARM_NAME))),NAME_TEXT_COPY(which));
                } else {
                    DIAG_NAME_BUFFER=0;
                    REPORT_ERROR(which?MSG_TYPE_MISMATCH_77:MSG_TYPE_MISMATCH_79,(long)(int)CALL_ARGUMENT_NUMBER,NAME_TEXT_COPY(which));
                }
            }
            ++CALL_ARGUMENT_NUMBER;
        } else if (mode!=4) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(which?MSG_EXTRA_PARAMETER_CALL_97:MSG_EXTRA_PARAMETER_CALL,NAME_TEXT_COPY(which));
        }
    }
    return _SI;
}

/* ---- STCVT5 (listing ovr_1cf8_92bb:452E) ---- */
extern unsigned int far pascal PTR_SCALE_TYPE(unsigned int);
/* STCVT5: the element size of a pointer node (or the size of a non-pointer node's type)
   as a constant of PTR_SCALE_TYPE; an unknown size is an error. */
static unsigned int near pascal STCVT5(register unsigned int node)
{
    register unsigned int converted;
    if(EXPR_FLAGS[EXPR_W(node,EXPR_KIND)]&0x14)
        converted=SIZE_OF_TYPE_CHECKED_HOOK(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_C_TARGET));
    else
        converted=SIZE_OF_TYPE_CHECKED_HOOK(EXPR_W(node,EXPR_TYPE));
    if(converted==0) REPORT_ERROR(MSG_SIZE_TYPE_UNKNOWN_ZERO);
    return NEW_CONST_NODE_HOOK(PTR_SCALE_TYPE(node),(long)converted);
}

/* ---- STCVT6 (listing ovr_1cf8_92bb:4587) ---- */
extern unsigned int EXPR_POOL_SEG;
/* STCVT6: integral promotion of node: kinds listed in INTEGRAL_PROMOTION_KIND are
   converted to the kind given there (char/short to int); an enum gets its int or char
   type in place. */
static unsigned int near pascal STCVT6(register unsigned int node)
{
    register unsigned int kind;
    kind=EXPR_W(node,EXPR_KIND);
    if(INTEGRAL_PROMOTION_KIND[kind]!=0) {
        node=CONVERT_EXPRESSION_TYPE(node,MODE_HOOK(INTEGRAL_PROMOTION_KIND[kind]));
    } else if(kind==0x15) {
        if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_C_TARGET)==1)
            EXPR_W(node,EXPR_TYPE)=MODE_HOOK(1);
        else
            EXPR_W(node,EXPR_TYPE)=PLAIN_INT_TYPE;
        EXPR_W(node,EXPR_KIND)=TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_KIND);
    }
    return node;
}

/* ---- STCVT7 (listing ovr_1cf8_92bb:460D) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned char OPTION_WINDOWS_MODE;
#define POOL_BYTE(r) (*((unsigned char far *)MK_FP(TYPE_POOL,(r))))
/* STCVT7: 1 when an argument node may be passed for a parameter of type "type" at all
   (the conversion then follows): not to arrays, functions or structs; pointers to
   non-pointers only in Windows mode for integer kinds; near and _seg pointers do not
   mix; a function pointer needs a compatible function type (mode 3); integers and
   floats convert among themselves and to enums, and the literal 0 to pointers. */
static int near pascal STCVT7(register unsigned int node,unsigned int type)
{
    int oldtype;
    register int kind;
    if(EXPR_W(node,EXPR_TYPE)==type) return 1;
    oldtype=EXPR_W(node,EXPR_KIND);
    switch(kind=POOL_BYTE(type)) {
    case 17: case 18: case 19: return 0;
    }
    switch(oldtype) {
    case 13: case 14: case 15: case 16:
        if (!((unsigned int)EXPR_FLAGS[kind]&0x14)) {
            if(OPTION_WINDOWS_MODE && kind<=8) return 1;
            return 0;
        }
        if(oldtype==14 && kind==13) return 0;
        if(oldtype==13 && kind==14) return 0;
        if(POOL_BYTE(TYPE_W(type,TYPE_C_TARGET))==18) {
            if(!TYPE_RECORDS_COMPATIBLE(TYPE_W(type,TYPE_C_TARGET),TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_C_TARGET),3)) return 0;
        }
        break;
    case 1: case 2: case 3: case 4: case 5: case 6:
    case 7: case 8: case 9: case 10: case 11: case 21:
        if(EXPR_W(node,EXPR_OP)==EOP_CONST && !*((long far *)MK_FP(EXPR_POOL_SEG,node+EXPR_LEFT)) &&
           (EXPR_FLAGS[kind]&0x14)) return 1;
        if(OPTION_WINDOWS_MODE && oldtype<=8 && (EXPR_FLAGS[kind]&0x14)) return 1;
        if(kind<=11) break;
        if(kind==21) break;
        return 0;
    case 19: return 0;
    }
    return 1;
}
#undef POOL_BYTE

/* ---- STCVT8 (listing ovr_1cf8_92bb:475C) ---- */
/* STCVT8: the error node (operator 0, no type). */
unsigned int far pascal STCVT8(void)
{
    return NEW_EXPR_NODE_HOOK(0,0,0,0);
}

/* ---- STCVT9 (listing ovr_1cf8_92bb:476B) ---- */
unsigned int far pascal STCVTA(unsigned int node,unsigned int member);
extern unsigned int far pascal LOOKUP_MEMBER(unsigned int,unsigned int,unsigned int);
/* STCVT9: member access p->name: finds the member with LOOKUP_MEMBER in the struct p
   points to (left = name, right = scope) and builds the access (STCVTA), or 0. */
static unsigned int near pascal STCVT9(register unsigned int node,unsigned int left,unsigned int right)
{
    register unsigned int result;
    result=LOOKUP_MEMBER(left,right,TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_C_TARGET));
    if(result==0) return 0;
    return STCVTA(node,result);
}

/* ---- STCVTA (listing ovr_1cf8_92bb:47A7) ---- */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int (far pascal *NEW_BITFIELD_NODE_HOOK)(unsigned int,unsigned int,unsigned char,unsigned char);
/* STCVTA: builds *(member-type *)(p + offset) for the struct pointer node and member
   record (C layout read with C++ field names: MEMB_FLAGS at offset 4 is the C offset
   MEMB_C_OFFSET, MEMB_VALUE byte 6 is the bit offset MEMB_C_BIT_OFFSET). The pointer
   keeps its kind, qualifiers and base (huge becomes far); a _seg pointer plus offset
   becomes a far pointer (0x2D). A bitfield member is wrapped in a bitfield node. */
unsigned int far pascal STCVTA(unsigned int node,unsigned int member)
{
    unsigned int type, saved, kind, owner;
    _SI=node;
    _DI=member;
    _ES=MEMBER_SEGMENT;
    owner=ES_W(_DI,MEMB_C_TYPE);
    _ES=EXPR_POOL_SEG;
    kind=ES_W(_SI,EXPR_KIND);
    type=ES_W(_SI,EXPR_TYPE);
    if(kind==16) kind=15;
    type=NEW_POINTER_TYPE(owner,(unsigned char)kind,
        (_BX=type,_ES=TYPE_POOL,ES_SC(_BX,TYPE_C_PTR_QUALS)),ES_W(_BX,TYPE_C_PTR_BASE),ES_SC(_BX,TYPE_C_FUNC_FLAGS));
    _SI=CONVERT_EXPRESSION_TYPE(_SI,type);
    _ES=MEMBER_SEGMENT;
    if(ES_W(_DI,MEMB_C_OFFSET)) {
        saved=NEW_CONST_NODE_HOOK(MODE_HOOK(5),
            (_ES=MEMBER_SEGMENT,(unsigned long)ES_W(_DI,MEMB_C_OFFSET)));
        if(kind==14) {
            type=NEW_POINTER_TYPE(owner,15,
                (_BX=type,_ES=TYPE_POOL,ES_SC(_BX,TYPE_C_PTR_QUALS)),0,0);
            _AX=0x2D;
        } else _AX=8;
        _SI=NEW_EXPR_NODE_HOOK(_AX,type,_SI,saved);
        _SI=FOLD_EXPRESSION(_SI);
    }
    _SI=TYPECHECK_OPERATOR(0x31,_SI,0);
    _ES=MEMBER_SEGMENT;
    if(ES_B(_DI,MEMB_C_BIT_WIDTH)) {
        _SI=NEW_BITFIELD_NODE_HOOK(_SI,owner,ES_B(_DI,MEMB_C_BIT_WIDTH),ES_B(_DI,MEMB_C_BIT_OFFSET));
    }
    return _SI;
}

/* ---- STCVTB (listing ovr_1cf8_92bb:48AF) ---- */
extern unsigned int EXPR_POOL_SEG;
/* STCVTB: rejects an operand kind (floating and up) that the operator's flag mask does
   not allow, with the message from OPERAND_KIND_MESSAGE. Returns 1 after an error. */
static int near pascal STCVTB(unsigned int node,unsigned int mask)
{
    register unsigned int kind;
    kind=EXPR_W(node,EXPR_KIND);
    if((int)kind<9 || OPERAND_KIND_MASK[kind]==0) return 0;
    if((mask & (unsigned int)OPERAND_KIND_MASK[kind])==0) {
        REPORT_ERROR(OPERAND_KIND_MESSAGE[kind]);return 1;
    }
    return 0;
}

/* ---- STCVTC (listing ovr_1cf8_92bb:48F6) ---- */
extern unsigned int EXPR_POOL_SEG;
/* STCVTC: an array value decays to a pointer to its first element (and its symbol is
   marked "address taken", CSYM flag 0x100); a function value to a function pointer. */
unsigned int far pascal STCVTC(register unsigned int node)
{
    if(EXPR_W(node,EXPR_KIND)==0x11) {
        CSYM_W(EXPR_W(node,EXPR_LEFT),CSYM_FLAGS)|=0x100;
        node=DECAY_TO_POINTER_HOOK(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),node,
                        (int)TYPE_SC(EXPR_W(node,EXPR_TYPE),TYPE_PARAMS));
    }
    if(EXPR_W(node,EXPR_KIND)==0x12) node=DECAY_TO_POINTER_HOOK(EXPR_W(node,EXPR_TYPE),node,0);
    return node;
}

/* ---- STCVTD (listing ovr_1cf8_92bb:495F) ---- */
unsigned int far pascal STCVTD(unsigned int type,register unsigned int node,unsigned int force);
extern unsigned int EXPR_POOL_SEG;
/* STCVTD: builds &node, choosing the pointer modifier for PTR_TYPE_FOR_MODIFIER: force
   gives 10 (huge), a far symbol (CSYM flag 0x10) 9 (far), a local or parameter when DS
   may differ from SS and data is near gives 3 (an SS-based near pointer, probably). */
unsigned int far pascal STCVTD(unsigned int type,register unsigned int node,unsigned int force)
{
    unsigned int mode;
    mode=0;
    if(force!=0) mode=10;
    else if(EXPR_W(node,EXPR_OP)==1 &&
            (CSYM_W(EXPR_W(node,EXPR_LEFT),CSYM_FLAGS)&0x10)) mode=9;
    else if((EXPR_W(node,EXPR_OP)==5 || EXPR_W(node,EXPR_OP)==6 ||
             EXPR_W(node,EXPR_OP)==7) &&
            MODEL_FAR_DATA==0 && OPTION_DS_NOT_SS!=0) mode=3;
    return NEW_EXPR_NODE_HOOK(0x32,PTR_TYPE_FOR_MODIFIER(type,(unsigned char)(EXPR_B(node,EXPR_QUAL_FLAGS)&3),0,(unsigned char)mode),node,0);
}

/* ---- TYPECHECK_OPERATOR: binary-operator type checking (listing 49F2, formerly the native STBINOP with its jump table STJTAB2) ---- */
/* Line numbers on (-y) for this function only: without them BC merges
   five `lcall [NEW_EXPR_NODE_HOOK]; mov [bp-2],ax` call tails that the original keeps
   apart (e.g. 202B, 2072, 26CD, 26EB). */
#pragma option -y
/* row X047_03 (offset 0x1E42): stub 0CF6:0020 = TYPECHECK_OPERATOR */
extern signed char KIND_INFO_TABLE[];
extern unsigned int (far pascal *EXPAND_COMPOUND_ASSIGN_HOOK)(unsigned int);
extern int far pascal IS_ADDRESSABLE_NODE(unsigned int);
extern unsigned int far pascal MIRROR_COMPARE_OP(unsigned int);
/* unit functions defined later in this overlay */
static int near pascal STBIN2(unsigned int node);
unsigned int far pascal STBIN3(unsigned int node);
static void near pascal STBIN4(int opcode,unsigned int node,int type);
static unsigned int near pascal STBIN5(unsigned int node,unsigned int type);
static int near pascal STBIN7(unsigned int type,unsigned int mask);
unsigned int far pascal APPLY_BASED_POINTER_C(unsigned int node);
/* expression nodes (EXPR_POOL_SEG), types (TYPE_POOL), statement records */
#define KIND(n) (*(int far *)MK_FP(EXPR_POOL_SEG,(n)+2))
#define FLAGS(n) EXPR_FLAGS[EXPR_W(n,EXPR_KIND)]
#define RANK(n) KIND_INFO_TABLE[EXPR_W(n,EXPR_KIND)*4]
/* Type-check operator op applied to left and right (right == 0 for a unary
   operator, in which case other aliases node): insert the conversions,
   build the result node with NEW_EXPR_NODE_HOOK and return it; on an error return
   STCVT8(), the error node.  TYPECHECK_OP_FLAGS[op] holds per-operator flag bits.
   The op meanings in the case comments below are inferred from the code.
   Some cases end in `return result;` and others in `break;` (which reaches
   the same `return result;`): the choice is the original's and decides
   which call tails BC merges and where it leaves its one unreachable jmp
   (2719), so keep it.  `goto general` jumps to the shared tail that applies
   the usual arithmetic conversions (the default case). */
unsigned int far pascal TYPECHECK_OPERATOR(int op,unsigned int left,unsigned int right)
{
    register unsigned int node;
    register unsigned int other;
    unsigned int result,type,original,mask;
    int conversion;
    node=left;
    other=right;
    if(EXPR_W(node,EXPR_KIND)==TK_UNDEFINED) return node;
    if(other && EXPR_W(other,EXPR_KIND)==TK_UNDEFINED) return other;
    if(other==0) other=node;
    result=node;
    if(op<8 || op>0x33) mask=0;
    else mask=TYPECHECK_OP_FLAGS[op];
    if(mask&0x8000) {
        if(!IS_ADDRESSABLE_EXPR(node)) {
            REPORT_ERROR(MSG_LVALUE_REQUIRED);
            return STCVT8();
        }
        if((EXPR_W(node,EXPR_QUAL_FLAGS)&1) || ((EXPR_W(node,EXPR_KIND)==TK_STRUCT || EXPR_W(node,EXPR_KIND)==TK_UNION) && STBIN7(EXPR_W(node,EXPR_TYPE),1))) {
            REPORT_ERROR(MSG_CANNOT_MODIFY_CONST);
            return STCVT8();
        }
    }
    if((FLAGS(node)&0x14) || (FLAGS(other)&0x14)) mask&=0xFFEF;
    if(STCVTB(node,mask) || STCVTB(other,mask)) return STCVT8();
    switch(op) {
    case 0x31:    /* inferred: unary * */
        if(!(FLAGS(node)&0x14)) {
            REPORT_ERROR(MSG_INVALID_INDIRECTION);
            return STCVT8();
        }
        original=EXPR_W(node,EXPR_TYPE);
        if(TYPE_W(original,TYPE_C_PTR_BASE)) {
            node=APPLY_BASED_POINTER_C(node);
            original=EXPR_W(node,EXPR_TYPE);
        }
        type=TYPE_W(original,TYPE_C_TARGET);
        if(TYPE_B(type,TYPE_KIND)==TK_VOID) {
            REPORT_ERROR(MSG_NOT_ALLOWED_TYPE);
            return STCVT8();
        }
        if(TYPE_B(type,TYPE_KIND)==TK_ARRAY) {
            node=NEW_EXPR_NODE_HOOK(0x31,type,node,0);
            EXPR_W(node,EXPR_QUAL_FLAGS)=TYPE_SC(original,TYPE_C_PTR_QUALS);
            result=NEW_EXPR_NODE_HOOK(0x32,NEW_POINTER_TYPE(TYPE_W(type,TYPE_TARGET),TYPE_B(original,TYPE_KIND),TYPE_SC(original,TYPE_C_PTR_QUALS),TYPE_W(original,TYPE_C_PTR_BASE),TYPE_SC(original,TYPE_C_FUNC_FLAGS)),node,0);
        } else if(TYPE_B(type,TYPE_KIND)==TK_FUNCTION) {
            node=NEW_EXPR_NODE_HOOK(0x31,type,node,0);
            EXPR_W(node,EXPR_QUAL_FLAGS)=TYPE_SC(original,TYPE_C_PTR_QUALS);
            result=NEW_EXPR_NODE_HOOK(0x32,original,node,0);
        } else if(EXPR_W(node,EXPR_OP)==EOP_ADDR && IS_ADDRESSABLE_NODE(EXPR_W(node,EXPR_LEFT))) {
            node=EXPR_W(node,EXPR_LEFT);
            EXPR_W(node,EXPR_TYPE)=type;
            EXPR_W(node,EXPR_KIND)=TYPE_B(type,TYPE_KIND);
            EXPR_W(node,EXPR_QUAL_FLAGS)&=0xFFFC;
            EXPR_W(node,EXPR_QUAL_FLAGS)|=TYPE_SC(original,TYPE_C_PTR_QUALS);
            return node;
        } else {
            result=NEW_EXPR_NODE_HOOK(op,type,node,0);
            EXPR_W(result,EXPR_QUAL_FLAGS)=TYPE_SC(original,TYPE_C_PTR_QUALS);
        }
        return result;
    case 0x32:    /* inferred: unary & */
        if(EXPR_W(node,EXPR_OP)==EOP_ADDR) {
            if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_C_TARGET)!=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE)) {
                type=EXPR_W(node,EXPR_TYPE);
                EXPR_W(node,EXPR_TYPE)=NEW_POINTER_TYPE(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),EXPR_B(node,EXPR_KIND),TYPE_SC(type,TYPE_C_PTR_QUALS),TYPE_W(type,TYPE_C_PTR_BASE),TYPE_SC(type,TYPE_C_FUNC_FLAGS));
                return node;
            }
            REPORT_WARNING(MSG_SUPERFLUOUS_FUNCTION);
            return node;
        }
        if(STBIN2(node) || EXPR_W(node,EXPR_OP)==0x33 || !IS_ADDRESSABLE_EXPR(node)) {
            REPORT_ERROR(MSG_MUST_TAKE_ADDRESS);
            return STCVT8();
        }
        if(EXPR_W(node,EXPR_OP)==EOP_DEREF) {
            result=EXPR_W(node,EXPR_LEFT);
            type=EXPR_W(result,EXPR_TYPE);
            EXPR_W(result,EXPR_TYPE)=type=NEW_POINTER_TYPE(EXPR_W(node,EXPR_TYPE),EXPR_B(result,EXPR_KIND),TYPE_SC(type,TYPE_C_PTR_QUALS),TYPE_W(type,TYPE_C_PTR_BASE),TYPE_SC(type,TYPE_C_FUNC_FLAGS));
            EXPR_W(result,EXPR_KIND)=TYPE_B(type,TYPE_KIND);
            return result;
        }
        if(EXPR_W(node,EXPR_OP)==EOP_QUESTION) {
            unsigned int list,first;
            list=EXPR_W(node,EXPR_RIGHT);
            first=EXPR_W(list,EXPR_LEFT)=TYPECHECK_OPERATOR(0x32,EXPR_W(list,EXPR_LEFT),0);
            EXPR_W(list,EXPR_RIGHT)=TYPECHECK_OPERATOR(0x32,EXPR_W(list,EXPR_RIGHT),0);
            EXPR_W(node,EXPR_KIND)=EXPR_W(list,EXPR_KIND)=EXPR_W(first,EXPR_KIND);
            EXPR_W(node,EXPR_TYPE)=EXPR_W(list,EXPR_TYPE)=EXPR_W(first,EXPR_TYPE);
            return node;
        }
        if(EXPR_W(node,EXPR_OP)==1 || EXPR_W(node,EXPR_OP)==5) CSYM_W(EXPR_W(node,EXPR_LEFT),CSYM_FLAGS)|=0x100;
        return DECAY_TO_POINTER_HOOK(EXPR_W(node,EXPR_TYPE),node,0);
    case 0x30:    /* ! (EOP_NOT, result int); below - and ~ (0x2E EOP_NEG, 0x2F EOP_COMPL) */
        node=STCVT6(node);
        return NEW_EXPR_NODE_HOOK(0x30,PLAIN_INT_TYPE,node,0);
    case 0x2E:
    case 0x2F:
        node=STCVT6(node);
        return NEW_EXPR_NODE_HOOK(op,EXPR_W(node,EXPR_TYPE),node,0);
    case 0x23:    /* postfix ++ / -- (EOP_POSTINC/EOP_POSTDEC); prefix ++x is built as x += 1 */
    case 0x24:
        result=(FLAGS(node)&0x14) ? STCVT5(node) : STASSIGN(NEW_CONST_NODE_HOOK(PLAIN_INT_TYPE,1L),EXPR_W(node,EXPR_TYPE));
        return NEW_EXPR_NODE_HOOK(op,EXPR_W(node,EXPR_TYPE),node,result);
    case 8:       /* inferred: binary + */
        if(FLAGS(node)&0x14) {
            type=EXPR_W(node,EXPR_TYPE);
            if(EXPR_W(node,EXPR_KIND)==TK_SEG_PTR) {
                if(EXPR_W(other,EXPR_KIND)==TK_SEG_PTR || EXPR_W(other,EXPR_KIND)==TK_FAR_PTR) {
                    REPORT_ERROR(MSG_INVALID_POINTER);
                    return STCVT8();
                }
                if(EXPR_W(other,EXPR_KIND)!=TK_NEAR_PTR) other=SCALE_INDEX(other,node);
                else if(TYPE_B(TYPE_W(type,TYPE_C_TARGET),TYPE_KIND)!=TK_VOID && TYPE_B(TYPE_W(EXPR_W(other,EXPR_TYPE),TYPE_C_TARGET),TYPE_KIND)!=TK_VOID
                        && !TYPE_RECORDS_COMPATIBLE(TYPE_W(type,TYPE_C_TARGET),TYPE_W(EXPR_W(other,EXPR_TYPE),TYPE_C_TARGET),0)) {
                    REPORT_ERROR(MSG_ILLEGAL_USE_POINTER);
                    return STCVT8();
                }
                if(TYPE_B(TYPE_W(type,TYPE_C_TARGET),TYPE_KIND)==TK_VOID) type=EXPR_W(other,EXPR_TYPE);
                return NEW_EXPR_NODE_HOOK(0x2D,NEW_POINTER_TYPE(TYPE_W(type,TYPE_C_TARGET),0xF,0,0,0),node,other);
            }
            if(EXPR_W(other,EXPR_KIND)==TK_SEG_PTR) {
                if(EXPR_W(node,EXPR_KIND)==TK_FAR_PTR) {
                    REPORT_ERROR(MSG_INVALID_POINTER);
                    return STCVT8();
                }
                if(TYPE_B(TYPE_W(type,TYPE_C_TARGET),TYPE_KIND)!=TK_VOID && TYPE_B(TYPE_W(EXPR_W(other,EXPR_TYPE),TYPE_C_TARGET),TYPE_KIND)!=TK_VOID
                        && !TYPE_RECORDS_COMPATIBLE(TYPE_W(type,TYPE_C_TARGET),TYPE_W(EXPR_W(other,EXPR_TYPE),TYPE_C_TARGET),0)) {
                    REPORT_ERROR(MSG_ILLEGAL_USE_POINTER);
                    return STCVT8();
                }
                if(TYPE_B(TYPE_W(type,TYPE_C_TARGET),TYPE_KIND)==TK_VOID) type=EXPR_W(other,EXPR_TYPE);
                return NEW_EXPR_NODE_HOOK(0x2D,NEW_POINTER_TYPE(TYPE_W(type,TYPE_C_TARGET),0xF,0,0,0),other,node);
            }
            if(FLAGS(other)&0x14) {
                REPORT_ERROR(MSG_INVALID_POINTER);
                return STCVT8();
            }
            other=SCALE_INDEX(other,node);
            result=NEW_EXPR_NODE_HOOK(8,type,node,other);
        } else if(FLAGS(other)&0x14) {
            if(EXPR_W(other,EXPR_KIND)==TK_SEG_PTR) {
                node=SCALE_INDEX(node,other);
                return NEW_EXPR_NODE_HOOK(0x2D,NEW_POINTER_TYPE(TYPE_W(EXPR_W(other,EXPR_TYPE),TYPE_C_TARGET),0xF,0,0,0),other,node);
            }
            node=SCALE_INDEX(node,other);
            result=NEW_EXPR_NODE_HOOK(8,EXPR_W(other,EXPR_TYPE),other,node);
        } else
            goto general;
        return result;
    case 0x13:    /* inferred: += */
        if(FLAGS(node)&0x14) {
            if(FLAGS(other)&0x14) {
                REPORT_ERROR(MSG_INVALID_POINTER);
                return STCVT8();
            }
            other=SCALE_INDEX(other,node);
            return NEW_EXPR_NODE_HOOK(op,EXPR_W(node,EXPR_TYPE),node,other);
        }
        if((FLAGS(other)&0x14)==0) goto general;
        REPORT_ERROR(MSG_ILLEGAL_USE_POINTER);
        return STCVT8();
    case 9:       /* inferred: binary - and -= (0x14) */
    case 0x14:
        if(FLAGS(node)&0x14) {
            if(FLAGS(other)&0x14) {
                unsigned int common,scale;
                if(op==0x14) {
                    REPORT_ERROR(MSG_ILLEGAL_POINTER);
                    return STCVT8();
                }
                other=STASSIGN(other,EXPR_W(node,EXPR_TYPE));
                scale=STCVT5(node);
                type=MODE_HOOK((EXPR_W(other,EXPR_KIND)==TK_FAR_PTR || EXPR_W(other,EXPR_KIND)==TK_HUGE_PTR) ? 7 : 5);
                if(TYPE_B(type,TYPE_KIND)==TK_LONG && EXPR_W(other,EXPR_KIND)==TK_FAR_PTR) {
                    common=MODE_HOOK(6);
                    node=CONVERT_EXPRESSION_TYPE(node,common);
                    other=CONVERT_EXPRESSION_TYPE(other,common);
                }
                result=NEW_EXPR_NODE_HOOK(0x2C,type,node,other);
                scale=CONVERT_EXPRESSION_TYPE(scale,type);
                result=NEW_EXPR_NODE_HOOK(0xB,EXPR_W(result,EXPR_TYPE),result,scale);
            } else {
                other=SCALE_INDEX(other,node);
                result=NEW_EXPR_NODE_HOOK(op,EXPR_W(node,EXPR_TYPE),node,other);
            }
        } else {
            if((FLAGS(other)&0x14)==0) goto general;
            REPORT_ERROR(MSG_ILLEGAL_POINTER);
            return STCVT8();
        }
        return result;
    case 0x25:    /* inferred: ?: (other must be the 0x26 node) */
        if(EXPR_W(node,EXPR_OP)!=EOP_CONST) node=STBIN3(node);
        if(EXPR_W(other,EXPR_OP)!=EOP_COLON) REPORT_ERROR(MSG_EXPRESSION_SYNTAX);
        result=NEW_EXPR_NODE_HOOK(0x25,EXPR_W(other,EXPR_TYPE),node,other);
        break;
    case 0x12:    /* = (EOP_ASSIGN): struct assignment is checked here, other types take the general path */
        if(EXPR_W(node,EXPR_KIND)!=TK_STRUCT && EXPR_W(other,EXPR_KIND)!=TK_STRUCT) goto general;
        if(!TYPE_RECORDS_COMPATIBLE(EXPR_W(node,EXPR_TYPE),EXPR_W(other,EXPR_TYPE),1)) {
            REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
            return STCVT8();
        }
        result=NEW_EXPR_NODE_HOOK(0x12,EXPR_W(node,EXPR_TYPE),node,other);
        break;
    case 0x1D:    /* inferred: relational and equality operators */
    case 0x1E:
    case 0x1F:
    case 0x20:
    case 0x21:
    case 0x22:
        if(!(FLAGS(node)&0x14) && !(FLAGS(other)&0x14)) {
            node=FOLD_EXPRESSION(node);
            other=FOLD_EXPRESSION(other);
            if(EXPR_W(other,EXPR_OP)!=EOP_CONST) /* the opcode of the left operand (result still holds left here), not
               op: the original reads [bp-2] (27DC); kept as in the original */
            STBIN4(MIRROR_COMPARE_OP(EXPR_W(result,EXPR_OP)),node,EXPR_W(other,EXPR_KIND));
            else if(EXPR_W(node,EXPR_OP)!=EOP_CONST) STBIN4(EXPR_W(result,EXPR_OP),other,EXPR_W(node,EXPR_KIND));
        }
        if((FLAGS(node)&0x14) && (FLAGS(other)&0x14)) {
            if(EXPR_W(other,EXPR_KIND)==TK_FAR_PTR && EXPR_W(node,EXPR_KIND)!=TK_FAR_PTR)
                node=STBIN5(node,EXPR_W(other,EXPR_TYPE));
            else
                other=STBIN5(other,EXPR_W(node,EXPR_TYPE));
        }
        goto general;
    case 0x27:    /* inferred: && and || */
    case 0x28:
        node=STBIN3(node);
        other=STBIN3(other);
        return NEW_EXPR_NODE_HOOK(op,PLAIN_INT_TYPE,node,other);
    default:
    general:
        if(mask&0x2000) {
            other=STCVT6(other);
            node=STCVT6(node);
        }
        conversion=mask&3;
        if(conversion==3) {
            other=CONVERT_EXPRESSION_TYPE(other,MODE_HOOK(2));
        } else {
            if(conversion==1) {
                unsigned int child;
                if(op>=0x13 && op<=0x17 && RANK(other)>RANK(node)) {
                    result=NEW_EXPR_NODE_HOOK(op,EXPR_W(other,EXPR_TYPE),node,other);
                    result=EXPAND_COMPOUND_ASSIGN_HOOK(result);
                    child=EXPR_W(result,EXPR_RIGHT);
                    EXPR_W(child,EXPR_LEFT)=STASSIGN(EXPR_W(child,EXPR_LEFT),EXPR_W(other,EXPR_TYPE));
                    EXPR_W(result,EXPR_RIGHT)=STASSIGN(child,EXPR_W(node,EXPR_TYPE));
                    EXPR_W(result,EXPR_KIND)=EXPR_W(node,EXPR_KIND);
                    EXPR_W(result,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
                    return result;
                }
                other=STASSIGN(other,EXPR_W(node,EXPR_TYPE));
            } else if(conversion==2) {
                other=STASSIGN(other,MODE_HOOK(2));
            } else if((FLAGS(node)&0x14) && EXPR_W(other,EXPR_OP)==EOP_CONST && EXPR_L(other,EXPR_VALUE)==0) {
                other=CONVERT_EXPRESSION_TYPE(other,EXPR_W(node,EXPR_TYPE));
            } else if((FLAGS(other)&0x14) && EXPR_W(node,EXPR_OP)==EOP_CONST && EXPR_L(node,EXPR_VALUE)==0) {
                node=CONVERT_EXPRESSION_TYPE(node,EXPR_W(other,EXPR_TYPE));
            } else if(KIND(other)<KIND(node)) {
                other=STASSIGN(other,EXPR_W(node,EXPR_TYPE));
            }
            if(!(mask&4) && KIND(node)<KIND(other)) node=STASSIGN(node,EXPR_W(other,EXPR_TYPE));
        }
        type=(mask&8) ? PLAIN_INT_TYPE : EXPR_W(node,EXPR_TYPE);
        result=NEW_EXPR_NODE_HOOK(op,type,node,other);
    }
    return result;
}
#undef KIND
#undef FLAGS
#undef RANK
#pragma option -y-
/* ---- STBIN2 (listing ovr_1cf8_92bb:5635) ---- */
/* STBIN2: 1 for a register variable (leaf 5 with CSYM flag 8, or leaf 4), whose address
   cannot be taken. */
static int near pascal STBIN2(register unsigned int node)
{
    if(EXPR_W(node,EXPR_OP)==5)
        return CSYM_W(EXPR_W(node,EXPR_LEFT),CSYM_FLAGS)&8;
    if(EXPR_W(node,EXPR_OP)==4) return 1;
    return 0;
}

/* ---- STBIN3 (listing ovr_1cf8_92bb:566F) ---- */
extern unsigned int EXPR_POOL_SEG;
#define W(n) (*((unsigned int far *)MK_FP(_ES,_SI+(n))))
/* STBIN3: a condition operand: comparisons, && || and ! are used as they are; anything
   else becomes (x != 0). An assignment used as a condition gets "possibly incorrect
   assignment". */
unsigned int far pascal STBIN3(unsigned int node)
{
    _SI=node;
    _ES=EXPR_POOL_SEG;
    if (W(0)==18) REPORT_WARNING(MSG_POSSIBLY_INCORRECT);
    _ES=EXPR_POOL_SEG;
    if ((int)W(0)>=29 && (int)W(0)<=34) goto unchanged;
    _ES=EXPR_POOL_SEG;
    if (W(0)==39 || W(0)==40 || W(0)==48) {
unchanged:
        return _SI;
    }
    return TYPECHECK_OPERATOR(0x1E,_SI,NEW_CONST_NODE_HOOK(PLAIN_INT_TYPE,0L));
}
#undef W

/* ---- STBIN4 (listing ovr_1cf8_92bb:56D2) ---- */
struct Range { long minimum,maximum; };
extern struct Range TYPE_RANGE_TABLE[];
extern long (far pascal *TOKEN_CONVERT)(long,int);
#define L(r) (*((long far *)MK_FP(EXPR_POOL_SEG,(r)+10)))
/* STBIN4: for a comparison of a variable with the constant node, warns "constant out of
   range in comparison" when the constant cannot be a value of the variable's integer
   kind "type" (or the comparison is always true or false at the range ends); otherwise
   the constant is given that kind so the comparison can be done in it. */
static void near pascal STBIN4(int opcode,register unsigned int node,int type)
{
    if (EXPR_W(node,EXPR_OP)!=EOP_CONST) return;
    if (type>=7) return;
    if (EXPR_FLAGS[type]&0x20) {
        if ((unsigned long)L(node)>(unsigned long)TYPE_RANGE_TABLE[type].maximum) { REPORT_WARNING(MSG_CONSTANT_OUT_RANGE); return; }
        if (opcode==0x21) {
            if (L(node)==0L) { REPORT_WARNING(MSG_CONSTANT_OUT_RANGE); return; }
        }
        if (opcode==0x22) {
            if ((unsigned long)L(node)==(unsigned long)TYPE_RANGE_TABLE[type].maximum) { REPORT_WARNING(MSG_CONSTANT_OUT_RANGE); return; }
        }
    } else {
        if (L(node)<TYPE_RANGE_TABLE[type].minimum ||
            L(node)>TYPE_RANGE_TABLE[type].maximum) { REPORT_WARNING(MSG_CONSTANT_OUT_RANGE); return; }
        if (opcode==0x21) {
            if (L(node)==TYPE_RANGE_TABLE[type].minimum) { REPORT_WARNING(MSG_CONSTANT_OUT_RANGE); return; }
        }
        if (opcode==0x22) {
            if (L(node)==TYPE_RANGE_TABLE[type].maximum) { REPORT_WARNING(MSG_CONSTANT_OUT_RANGE); return; }
        }
    }
    L(node)=TOKEN_CONVERT(L(node),type);
    EXPR_W(node,EXPR_KIND)=type;
}
#undef L

/* ---- STBIN5 (listing ovr_1cf8_92bb:586C) ---- */
#define KIND(t) (*((unsigned char far *)MK_FP(TYPE_POOL,*((unsigned int far *)MK_FP(TYPE_POOL,(t)+3)))))
/* STBIN5: converts the pointer node to the pointer type "type" for a comparison,
   warning when the targets are not compatible. */
static unsigned int near pascal STBIN5(unsigned int node,register unsigned int type)
{
    register unsigned int left;
    left=*((unsigned int far *)MK_FP(EXPR_POOL_SEG,node+EXPR_TYPE));
    if(!POINTER_TARGETS_COMPATIBLE(left,type,3))
        REPORT_WARNING((KIND(left)<=2 && KIND(type)<=2 && POINTER_KIND_COMPATIBLE(left,type)) ? MSG_MIXING_POINTERS_SIGNED : MSG_SUSPICIOUS_POINTER);
    return CONVERT_EXPRESSION_TYPE(node,type);
}
#undef KIND

/* ---- IS_ADDRESSABLE_EXPR (listing ovr_1cf8_92bb:58CE) ---- */
/* IS_ADDRESSABLE_EXPR: 1 when node is an lvalue: a symbol leaf, *p or a bitfield (not of
   array type), or a ?: of struct type whose arms are both lvalues. */
int far pascal IS_ADDRESSABLE_EXPR(register unsigned int node)
{
    register unsigned int operand;
    switch((int)EXPR_W(node,EXPR_OP)) {
    case 0x25:
        if(EXPR_W(node,EXPR_KIND)!=TK_STRUCT) return 0;
        operand=EXPR_W(node,EXPR_RIGHT);
        return IS_ADDRESSABLE_EXPR(EXPR_W(operand,EXPR_LEFT)) && IS_ADDRESSABLE_EXPR(EXPR_W(operand,EXPR_RIGHT));
    case 1:case 4:case 5:case 6:case 7:case 0x31:case 0x33:
        if(EXPR_W(node,EXPR_KIND)==TK_ARRAY) return 0;
        return 1;
    default:
        return 0;
    }
}

/* ---- STBIN7 (listing ovr_1cf8_92bb:5962) ---- */
/* STBIN7: 1 when a member of the struct type has a flag in mask (the byte read through
   MEMB_TYPE, offset 8, is MEMB_C_FLAGS in the C layout; mask 1 probably "const"). */
static int near pascal STBIN7(unsigned int type,unsigned int mask)
{
    register unsigned int member;
    member=TYPE_W(type,TYPE_C_PARAMS);
    while(member!=0) {
        if(mask & (unsigned int)MEMBER_B(member,MEMB_C_FLAGS)) return 1;
        member=MEMBER_W(member,MEMB_NEXT);
    }
    return 0;
}

/* ---- STBIN8 (listing ovr_1cf8_92bb:599F) ---- */
struct Token { unsigned char bytes[19]; };
extern void far pascal BCC_INPUT_STRING_PTR(unsigned int,unsigned int);
extern void far pascal POP_INPUT_CONTEXT(unsigned int);
#define TOKEN_WORD (*((unsigned int near *)&TOKEN_TYPE))
/* APPLY_BASED_POINTER_C: C-mode version of APPLY_BASED_POINTER (expr/CONVERT.C): parses
   the based pointer's base text (from the POOL_HASH pool at 0x789C) and returns
   base + pointer; on a syntax error the node is returned unchanged. */
unsigned int far pascal APPLY_BASED_POINTER_C(unsigned int node)
{
    struct Token saved;
    _SI=node;
    saved=*(struct Token near *)&TOKEN_TYPE;
    BCC_INPUT_STRING_PTR((unsigned)&POOL_HASH,(_ES=EXPR_POOL_SEG,_BX=ES_W(_SI,EXPR_TYPE),_ES=TYPE_POOL,ES_W(_BX,TYPE_C_PTR_BASE)));
    _AX=TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_WORD) : LEX_NEXT_TOKEN();
    _DI=PARSE_EXPRESSION(0,0);
    if (_DI==0) return _SI;
    if (TOKEN_WORD!=7) {
        REPORT_AND_SKIP(MSG_EXPRESSION_SYNTAX,(char far *)0);
        return _SI;
    }
    POP_INPUT_CONTEXT(1);
    *(struct Token near *)&TOKEN_TYPE=saved;
    return TYPECHECK_OPERATOR(8,_DI,_SI);
}
#undef TOKEN_WORD

/* ---- STBIN9 (listing ovr_1cf8_92bb:5A47) ---- */
int far pascal STBIN9(register unsigned int node);
/* STBIN9: 1 for a symbol leaf without EXPR_QUAL_FLAGS bit 4. FAR_POINTER_NARROW_MASK
   (expr/CONSTFLD.C) treats a leaf with bit 4 set as having a known segment, so bit 4
   probably marks a variable in the default data group. */
int far pascal STBIN9(register unsigned int node)
{
    return EXPR_W(node,EXPR_OP)==1 && !(EXPR_W(node,EXPR_QUAL_FLAGS)&4);
}

/* ---- STBIN10 (listing ovr_1cf8_92bb:5A6C) ---- */
int far pascal STBIN10(unsigned int value);
/* STBIN10: 1 when value is the string literal symbol C_STRING_LITERAL_SYMBOL. */
int far pascal STBIN10(unsigned int value)
{
    return value==C_STRING_LITERAL_SYMBOL;
}
