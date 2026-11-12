/* target: ovr075_C228UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: C++ expression parsing: new, member selection, qualified names. Entry points:
   PARSE_MEMBER_SELECTOR, PARSE_QUALIFIED_NAME, PARSE_TYPE_CONSTRUCTOR_CALL,
   PARSE_NEW_EXPRESSION. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C++ parts of the expression parser (parser/OPPREC.C calls these while
   reading an expression): the member name after '.' or '->', names qualified with
   '::', T(args) for a type T, and new expressions. They only parse and build nodes;
   the meaning is worked out later by expression analysis (ANALYZE_MEMBER_SELECT,
   ANALYZE_NEW_EXPRESSION in CPPEXPCK.C, ANALYZE_TEMP_OBJECT_NODE in CPPCAST.C).
   Member names are member-name nodes made by MAKE_MEMBER_NAME_NODE(name, kind) with
   kind 0 identifier, 1 operator function, 2 conversion function (its target type in
   EXPR_SCOPE_CLASS), 4 destructor; EXPR_RIGHT holds the qualifying class of X::name.
   The special names are entries of TOKEN_NAMES (see CPPCTOR.C): DTOR_NAME is
   the destructor name, CONVERSION_FUNC_NAME (TOKEN_NAMES[0x37]) the name given to all
   conversion functions. TOKEN_TYPE is the lookahead token filled by PEEK_TOKEN; 0x67
   is TOK_SCOPE. Declaration specifiers inside these constructs must be plain types:
   PARSE_DECL_SPECIFIERS returning a storage code other than 0x82, friend or virtual
   gives MSG_STORAGE_CLASS_NOT_258. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"

/* ---- PARSE_MEMBER_SELECTOR (listing 5A60) ---- */
#include <dos.h>
struct C16Spec { signed char first,second,third; };
extern unsigned int TOKEN_TYPE; extern unsigned int CURRENT_TOKEN_RECORD; extern unsigned int CURRENT_TOKEN_VALUE;
extern unsigned int EXPR_POOL_SEG;
extern void far pascal PEEK_TOKEN(void);
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned int far pascal BCC_TYPE_RESOLVE_NAME(void);
extern unsigned int far pascal BCC_TYPE_PRIMARY(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_MEMBER_NAME_NODE(unsigned int,unsigned int);
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,unsigned int far *,unsigned char far *,unsigned char far *,unsigned int far *,struct C16Spec far *,unsigned char far *);
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,unsigned int far *,unsigned int far *,unsigned int far *,unsigned int far *,struct C16Spec far *,struct C16Spec far *);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC();
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);

/* PARSE_MEMBER_SELECTOR: parses what follows '.' or '->' and stores a member-name
   node in EXPR_RIGHT of node: [X::]name, [X::]~X (checked against the class name,
   MSG_DESTRUCTOR_NAME_MUST), operator op (op must be overloadable: TYPE_FLAGS 0x400;
   '()' and '[]' take their closing token) or operator type. Returns node. */
unsigned int far pascal PARSE_MEMBER_SELECTOR(unsigned int node)
{
    unsigned int scope;
    unsigned char bad;
    unsigned int context;
    unsigned int value;
    unsigned int code;
    unsigned int second_value;
    unsigned int third_value;
    unsigned int fourth_value;
    struct C16Spec spec;
    unsigned char first;
    unsigned char second;
    unsigned char third;
    register unsigned int result;
    register unsigned int type;

    bad=0;
    scope=0;
    if(CURRENT_TOKEN==TOK_IDENT) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==0x67) {
            scope=BCC_TYPE_RESOLVE_NAME();
            ADVANCE_TOKEN();
            ADVANCE_TOKEN();
        }
    }
    if(scope && CURRENT_TOKEN==TOK_TILDE) {
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN!=TOK_IDENT) return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SYNTAX,0);
        type=BCC_TYPE_PRIMARY(CURRENT_TOKEN_VALUE);
        if(!type) type=BCC_TYPE_PRIMARY(CURRENT_TOKEN_VALUE);
        if(!type || ((SYM_B(type,SYM_STORAGE_CLASS)>>3)!=11 && (SYM_B(type,SYM_STORAGE_CLASS)>>3)!=8) ||
           !TYPES_COMPATIBLE(SYM_W(type,SYM_TYPE),scope,1))
            return REPORT_EXPR_ERROR_PLAIN(MSG_DESTRUCTOR_NAME_MUST,0);
        result=MAKE_MEMBER_NAME_NODE(DTOR_NAME,4);
        ADVANCE_TOKEN();
    } else if(CURRENT_TOKEN==TOK_IDENT || CURRENT_TOKEN==TOK_OPERATOR) {
        if(CURRENT_TOKEN==TOK_IDENT) {
            result=MAKE_MEMBER_NAME_NODE(CURRENT_TOKEN_VALUE,0);
        } else {
            ADVANCE_TOKEN();
            if(TOKEN_IS_TYPE_START((void far *)&CURRENT_TOKEN_RECORD)) {
                PEEK_TOKEN();
                if(TOKEN_TYPE!=0x67) {
                context=INT_TYPE;
                PARSE_DECL_SPECIFIERS(6,&code,&first,&second,&context,&spec,&third);
                if(code!=0x82 || first || second)
                    REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,first ? (char far *)STR_FRIEND_2 :
                        second ? (char far *)STR_VIRTUAL_2 : NAME_TEXT_COPY(TOKEN_NAMES[code]),0L);
                PARSE_DECLARATOR(context,6,&value,&second_value,&third_value,&fourth_value,&spec,&spec);
                result=MAKE_MEMBER_NAME_NODE(CONVERSION_FUNC_NAME,2);
                EXPR_W(result,EXPR_SCOPE_CLASS)=value;
                goto check;
                }
            }
            result=MAKE_MEMBER_NAME_NODE(TOKEN_NAMES[CURRENT_TOKEN_RECORD],1);
            if(CURRENT_TOKEN==TOK_LPAREN) {
                ADVANCE_TOKEN();
                if(CURRENT_TOKEN!=TOK_RPAREN) REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
            } else if(CURRENT_TOKEN==TOK_LBRACKET) {
                ADVANCE_TOKEN();
                if(CURRENT_TOKEN!=TOK_RBRACKET) REPORT_DIAGNOSTIC(MSG_MISSING,(char far *)STR_OPERATOR,0L);
            } else if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x400)) {
                REPORT_CURRENT_TOKEN(MSG_OVERLOADABLE_OPERATOR);
                bad=1;
            }
        }
        ADVANCE_TOKEN();
check:
        if(bad) result=REPORT_EXPR_ERROR_PLAIN(0,result);
        else EXPR_W(result,EXPR_RIGHT)=scope;
    } else {
        result=REPORT_EXPR_ERROR_PLAIN(MSG_FIELD_IDENTIFIER,0);
    }
    EXPR_W(node,EXPR_RIGHT)=result;
    return node;
}

/* ---- PARSE_QUALIFIED_NAME (listing 5D01) ---- */
#include <dos.h>
#include "BCCREC6.H"

struct C24Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
#define TOKEN (*(struct C24Token near *)&CURRENT_TOKEN_RECORD)
extern unsigned int SCOPE_POOL_SEG; extern unsigned int BCC_TREE_SPECIAL;
extern unsigned char LANGUAGE_MODE;
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern unsigned int far pascal FIND_MEMBER_REPORT(unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern int far pascal FIND_SYMBOL_IN_SCOPES(unsigned int);
extern unsigned int far pascal FIND_NAME_IN_LIST(unsigned int,unsigned int);
extern unsigned int far pascal CREATE_TYPE(unsigned int);
extern unsigned int far pascal BUILD_IDENTIFIER_NODE(unsigned int,struct C24Token far *,struct C77Record6);
extern char far * far pascal FORMAT_MEMBER_NAME(unsigned int,unsigned int,unsigned int,unsigned int);
extern long far pascal FORMAT_MEMBER(unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int,unsigned int);

/* PARSE_QUALIFIED_NAME: parses a primary name: identifier, X::name, ::name, operator
   op or operator type, and returns its node. The local "destructor" is set when a '::'
   is seen (X:: or a leading ::), not for destructors. Lookup:
   - ::name searches the global scope; X::name the class X (inherited is set when X is
     a base of the current class);
   - a plain name searches the open scopes, then the members of CURRENT_CLASS_TYPE
     (inherited), then the global scope.
   A name that is not a member goes to BUILD_IDENTIFIER_NODE. A member gives: a field
   reference (data member), an int constant (enumerator), a symbol node (static member
   or function; a conversion function is chosen by its target type). Inside a member
   function (CTOR_THIS_SYMBOL set) a member of the current class or its bases is made
   this->member (node flag 2 marks it); a data member used in a function without this
   is MSG_CANNOT_USED_STATIC. Accessibility is checked here only for enumerators and
   static members. With MACRO_MODE and LANGUAGE_MODE both set, lookup results are
   ignored (purpose not clear). */
unsigned int far pascal PARSE_QUALIFIED_NAME(void)
{
    unsigned char destructor;
    unsigned int scope;
    unsigned int name;
    unsigned int kind;
    unsigned int result;
    unsigned char inherited;
    unsigned int conversion;
    struct C77Record6 where;
    unsigned int context;
    unsigned int code;
    unsigned int second_value;
    unsigned int third_value;
    unsigned int fourth_value;
    struct C16Spec spec;
    unsigned char first;
    unsigned char second;
    unsigned char third;
    struct C24Token token;
    register unsigned int member;
    register unsigned int type;

    inherited=0;
    scope=0;
    conversion=0;
    kind=0;
    if(CURRENT_TOKEN==TOK_IDENT) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==0x67) {
            scope=BCC_TYPE_RESOLVE_NAME();
            ADVANCE_TOKEN();
        }
    }
    destructor=0;
    if(CURRENT_TOKEN==TOK_SCOPE) {
        destructor=1;
        ADVANCE_TOKEN();
    }
    name=0;
    if(CURRENT_TOKEN==TOK_OPERATOR) {
        ADVANCE_TOKEN();
        if(TOKEN_IS_TYPE_START((void far *)&CURRENT_TOKEN_RECORD) && (PEEK_TOKEN(),TOKEN_TYPE)!=0x67) {
            kind=2;
            token=TOKEN;
            where.first=CURRENT_TOKEN_FILE;
            where.second=CURRENT_TOKEN_LINE;
            where.third=CURRENT_TOKEN_LOC_WORD3;
            token.kind=0x37;
            name=CONVERSION_FUNC_NAME;
            context=INT_TYPE;
            PARSE_DECL_SPECIFIERS(6,&code,&first,&second,&context,&spec,&third);
            if(code!=0x82 || first || second)
                REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,first ? (char far *)STR_FRIEND_2 :
                    second ? (char far *)STR_VIRTUAL_2 : NAME_TEXT_COPY(TOKEN_NAMES[code]),0L);
            PARSE_DECLARATOR(context,6,&conversion,&second_value,&third_value,&fourth_value,&spec,&spec);
        } else {
            kind=1;
            name=TOKEN_NAMES[CURRENT_TOKEN_RECORD];
            token=TOKEN;
            where.first=CURRENT_TOKEN_FILE;
            where.second=CURRENT_TOKEN_LINE;
            where.third=CURRENT_TOKEN_LOC_WORD3;
            if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x400)) REPORT_CURRENT_TOKEN(MSG_OVERLOADABLE_OPERATOR);
            else if(CURRENT_TOKEN==TOK_LBRACKET || CURRENT_TOKEN==TOK_LPAREN) {
                if(CURRENT_TOKEN==TOK_LBRACKET && (PEEK_TOKEN(),TOKEN_TYPE)!=4)
                    REPORT_DIAGNOSTIC(MSG_MISSING,(char far *)STR_OPERATOR_2,0L);
                else if(CURRENT_TOKEN==TOK_LPAREN && (PEEK_TOKEN(),TOKEN_TYPE)!=2)
                    REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                else ADVANCE_TOKEN();
            }
            ADVANCE_TOKEN();
        }
    } else if(CURRENT_TOKEN==TOK_IDENT) {
        name=CURRENT_TOKEN_VALUE;
        token=TOKEN;
        where.first=CURRENT_TOKEN_FILE;
        where.second=CURRENT_TOKEN_LINE;
        where.third=CURRENT_TOKEN_LOC_WORD3;
        ADVANCE_TOKEN();
    } else {
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    }

    type=0;
    member=0;
    if(!name) return REPORT_EXPR_ERROR_PLAIN(0,0);
    if(destructor) {
        if(!scope) {
            type=FIND_NAME_IN_LIST(name,SCOPE_W(GLOBAL_SCOPE,SCOPE_NAMES));
        } else {
            member=FIND_MEMBER_REPORT(name,scope);
            if(CURRENT_CLASS_TYPE) inherited=IS_BASE_CLASS(scope,CURRENT_CLASS_TYPE,0);
        }
    } else {
        type=FIND_SYMBOL_IN_SCOPES(name);
        if(!type && CURRENT_CLASS_TYPE) {
            member=FIND_MEMBER_REPORT(name,CURRENT_CLASS_TYPE);
            inherited=member!=0;
        }
        if(!type && !inherited) {
            type=FIND_NAME_IN_LIST(name,SCOPE_W(GLOBAL_SCOPE,SCOPE_NAMES));
        }
    }
    if(MACRO_MODE && LANGUAGE_MODE) type=0;
    if(!member && !scope) return BUILD_IDENTIFIER_NODE(type,&token,where);
    if(!member) {
        REPORT_DIAGNOSTIC(MSG_UNDEFINED_SYMBOL,FORMAT_MEMBER_NAME(name,kind,scope,conversion),0L);
        return REPORT_EXPR_ERROR_PLAIN(0,0);
    }
    if(conversion) {
        for(type=MEMBER_W(member,MEMB_VALUE); type && TYPE_W(SYM_W(type,SYM_TYPE),TYPE_TARGET)!=conversion; type=SYM_W(type,SYM_NEXT_OVERLOAD))
            ;
        if(!type) {
            context=!scope ? CURRENT_CLASS_TYPE : scope;
            code=CREATE_TYPE(0x12);
            TYPE_W(code,TYPE_TARGET)=conversion;
            REPORT_DIAGNOSTIC(MSG_NOT_MEMBER,FORMAT_MEMBER_NAME(MEMBER_W(member,MEMB_NAME),2,code,context),FORMAT_TYPE(context));
            return REPORT_EXPR_ERROR_PLAIN(0,0);
        }
        member=0;
        result=MAKE_SYMBOL_NODE(type);
        EXPR_W(result,EXPR_SCOPE_CLASS)=scope;
    } else switch(MEMBER_B(member,MEMB_FLAGS)&3) {
    case 0:
        if(!CTOR_THIS_SYMBOL && BCC_TREE_SPECIAL && inherited) {
            REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_USED_STATIC,MEMBER_W(member,MEMB_NAME));
            return REPORT_EXPR_ERROR_PLAIN(0,0);
        }
        result=MAKE_FIELD_REF_NODE(member);
        EXPR_W(result,EXPR_RIGHT)=scope;
        break;
    case 1:
        result=MAKE_INT_CONSTANT(MEMBER_W(member,MEMB_TYPE),(long)(int)MEMBER_W(member,MEMB_VALUE));
        inherited=0;
        if(!MEMBER_ACCESSIBLE(member,CURRENT_CLASS_TYPE))
            REPORT_DIAGNOSTIC(0xB6,FORMAT_MEMBER(member),0L);
        break;
    case 2:
        inherited=0;
        result=MAKE_SYMBOL_NODE(MEMBER_W(member,MEMB_VALUE));
        if(!MEMBER_ACCESSIBLE(member,CURRENT_CLASS_TYPE))
            REPORT_DIAGNOSTIC(0xB6,FORMAT_MEMBER(member),0L);
        break;
    case 3:
        if(!CTOR_THIS_SYMBOL || !inherited) {
            result=MAKE_SYMBOL_NODE(MEMBER_W(member,MEMB_VALUE));
            EXPR_W(result,EXPR_SCOPE_CLASS)=scope;
        } else {
            result=MAKE_FIELD_REF_NODE(member);
            EXPR_W(result,EXPR_RIGHT)=scope;
        }
        break;
    }
    if(inherited && CTOR_THIS_SYMBOL) {
        result=MAKE_BINARY_NODE(0x2F,MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL),result);
        EXPR_B(result,EXPR_NODE_FLAGS)|=2;
    }
    return result;
}
#undef TOKEN

/* ---- PARSE_TYPE_CONSTRUCTOR_CALL (listing 6246) ---- */
#include <dos.h>

extern unsigned int far pascal PARSE_ARGUMENT_LIST(unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);

/* PARSE_TYPE_CONSTRUCTOR_CALL: T(args), a type name used like a function. Parses the
   type and the argument list and returns a temporary-object node (op 0x37, EXPR_TYPE
   T, EXPR_RIGHT the arguments); with exactly one argument it is a cast (op 0x35) of
   that argument instead. */
unsigned int far pascal PARSE_TYPE_CONSTRUCTOR_CALL(void)
{
    unsigned int code;
    unsigned int context;
    struct C16Spec spec;
    unsigned char first;
    unsigned char second;
    unsigned char third;
    register unsigned int expression;
    register unsigned int initializer;

    context=INT_TYPE;
    PARSE_DECL_SPECIFIERS(3,&code,&first,&second,&context,&spec,&third);
    if(code!=0x82 || first || second)
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,first ? (char far *)STR_FRIEND_2 :
            second ? (char far *)STR_VIRTUAL_2 : NAME_TEXT_COPY(TOKEN_NAMES[code]),0L);
    initializer=PARSE_ARGUMENT_LIST(0);
    expression=MAKE_BINARY_NODE(1,0,initializer);
    EXPR_W(expression,EXPR_OP)=0x37;
    EXPR_W(expression,EXPR_TYPE)=context;
    if(initializer && EXPR_W(initializer,EXPR_LEFT)==0) {
        EXPR_W(expression,EXPR_OP)=0x35;
        EXPR_W(expression,EXPR_LEFT)=EXPR_W(initializer,EXPR_RIGHT);
        EXPR_W(expression,EXPR_RIGHT)=0;
        FREE_EXPR_NODE(initializer);
    }
    return expression;
}

/* ---- PARSE_NEW_EXPRESSION (listing 631C) ---- */
#include <dos.h>
extern unsigned char far pascal IS_PAREN_TYPE_NAME(unsigned int);
extern unsigned int far pascal PARSE_TYPE_NAME(unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* PARSE_NEW_EXPRESSION: parses [::]new [(placement)] type [(initializers)], the
   current token being '::' or new. Returns two nodes made with token 0x6C (new): the
   outer one is EXPR_RIGHT of the inner one and holds the placement list (left) and the
   initializer list (right). The inner node has EXPR_TYPE the allocated type and
   EXPR_LEFT the array dimension (an expression for new T[n], else 0). ::new clears
   node flag 0x20 on the inner node. new (T) is told apart from placement arguments by
   IS_PAREN_TYPE_NAME. */
unsigned int far pascal PARSE_NEW_EXPRESSION(void)
{
    unsigned int outer;
    register unsigned int type;
    register unsigned int inner;

    outer=MAKE_BINARY_NODE(0x6C,0,0);
    inner=MAKE_BINARY_NODE(0x6C,0,outer);
    if(CURRENT_TOKEN==TOK_SCOPE) {
        ADVANCE_TOKEN();
        EXPR_B(inner,EXPR_NODE_FLAGS)&=0xDF;
    }
    ADVANCE_TOKEN();
    if(CURRENT_TOKEN==TOK_LPAREN && !IS_PAREN_TYPE_NAME(4)) EXPR_W(outer,EXPR_LEFT)=PARSE_ARGUMENT_LIST(0);
    if(CURRENT_TOKEN==TOK_LPAREN) {
        ADVANCE_TOKEN();
        type=PARSE_TYPE_NAME(5);
        REQUIRE_TOKEN_ELSE_ERROR(2,0xE9);
    } else {
        type=PARSE_TYPE_NAME(4);
    }
    if(TYPE_W(type,TYPE_KIND)==TK_ARRAY) {
        EXPR_W(inner,EXPR_LEFT)=(TYPE_B(type,TYPE_ATTRS)&0x20) ? TYPE_W(type,TYPE_DIM_EXPR) : MAKE_INT_CONSTANT(INT_TYPE,TYPE_L(type,TYPE_ARRAY_COUNT));
        type=TYPE_W(type,TYPE_TARGET);
    } else {
        EXPR_W(inner,EXPR_LEFT)=0;
    }
    EXPR_W(inner,EXPR_TYPE)=type;
    EXPR_W(outer,EXPR_RIGHT)=CURRENT_TOKEN==TOK_LPAREN ? PARSE_ARGUMENT_LIST(0) : 0;
    return inner;
}
