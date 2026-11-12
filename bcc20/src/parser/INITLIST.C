/* target: ovr092_C36UNIT */
/* Role: parser: initializers: brace lists, sized and unsized arrays, struct members and
   packed bitfields, scalar initializers and their data output. Entry points:
   IS_CONSTANT_INITIALIZER, INIT_SCALAR, INIT_OBJECT, INIT_DECLARATOR,
   PARSE_SCALAR_INITIALIZER. Map of all sources: docs/SOURCE-MAP.md. */
/* Whole original CO024, 3925 bytes, eleven recovered routines.
   Source/ABI/ownership derivation included; compiler/object proof pending. */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Overview: initializers of the C++ front end ("= value" and "= { ... }"
   after a declarator).  For a static object the initial value is written
   as data bytes into the object's segment as it is parsed; position (a
   long passed by address everywhere) is the offset reached inside the
   object, and PAD_INIT_DATA fills gaps with zero bytes.  INIT_DECLARATOR
   is the entry for one declarator: it selects the object's output stream,
   calls INIT_OBJECT, pads to the full size and restores the stream.
   INIT_OBJECT dispatches on the type: arrays (INIT_SIZED_ARRAY,
   INIT_UNSIZED_ARRAY, which also fixes the element count of "x[] = ..."),
   structs (INIT_STRUCT_MEMBERS, packing bitfields into bytes), unions
   (first named member only), and scalars (INIT_SCALAR).
   A scalar value is analysed as the assignment "temporary = value"; if it
   folds to a constant or an address constant it is emitted as data
   (EMIT_CONST_INIT_VALUE).  Otherwise, in C++, the assignment is built as
   an expression and queued (QUEUE_INIT_EXPR) to run at start-up, and in C
   it is an error.  Locals (storage class 5, probably auto) are always
   initialised that way, by code.  Arrays with attribute 0x40 (FIELDS.H:
   far array) are written through NEXT_DATA_BANK / EMIT_DATA_SPANS,
   probably the huge data path.  Records are read through the accessors
   of POOL.H (EXPR_W, TYPE_W, SYM_B, TAG_W, MEMBER_W ...). */
#include <dos.h>
#include "INITLIST.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"

/* 0000: synchronize at a terminator class and consume token6 when present. */
/* Expects the '}' closing a brace initializer.  Anything else is reported
   (as "too many initializers" if it could start another value) and
   skipped up to a synchronising token. */
static void near pascal END_BRACE_INIT(void)
{
    if(CURRENT_TOKEN!=TOK_RBRACE) {
        REPORT_CURRENT_TOKEN((TYPE_FLAGS[CURRENT_TOKEN]&EXPR_START_FLAG_MASK)?MSG_TOO_MANY_INITIALIZERS:MSG_EXPECTED_230);
        IN_ERROR_RECOVERY=1;
        while(!(TYPE_FLAGS[CURRENT_TOKEN]&0x200)) ADVANCE_TOKEN();
    }
    if(CURRENT_TOKEN==TOK_RBRACE) ADVANCE_TOKEN();
}
/* 0051: signed LONG position order; actual zero-output count is a WORD. */
/* Emits zero bytes (through EMIT_ZERO_BYTES) from *position up to target
   and advances *position. */
static void near pascal PAD_INIT_DATA(long target,long far *position)
{
    if(*position<target) {
        EMIT_ZERO_BYTES((unsigned int)(target-*position));
        *position=target;
    }
}
/* 008F: classify literal/address initializer forms without added null guards. */
/* Nonzero if the expression can be emitted as data: a constant (operators
   EOP_CONST, 3 and 0x48, probably string and member-pointer constants),
   or the address of a static object or function, optionally plus or
   minus a constant.  Operator 0x35 nodes (probably casts) are looked
   through.  The address of a local (storage class 5) is not constant.  A
   function whose address is taken is queued with QUEUE_DEFERRED_SYMBOL,
   probably so an inline function gets an out-of-line copy. */
unsigned char far pascal IS_CONSTANT_INITIALIZER(register unsigned int expression)
{
    while(EXPR_W(expression,EXPR_OP)==0x35) expression=EXPR_W(expression,EXPR_LEFT);
    if(EXPR_W(expression,EXPR_OP)==EOP_CONST || EXPR_W(expression,EXPR_OP)==3 || EXPR_W(expression,EXPR_OP)==0x48) return 1;
    if(EXPR_W(expression,EXPR_OP)==EOP_ADD) {
        if(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==EOP_CONST) expression=EXPR_W(expression,EXPR_RIGHT);
        else expression=EXPR_W(expression,EXPR_LEFT);
    } else if(EXPR_W(expression,EXPR_OP)==EOP_SUB && EXPR_W(EXPR_W(expression,EXPR_RIGHT),EXPR_OP)==EOP_CONST)
        expression=EXPR_W(expression,EXPR_LEFT);
    if(EXPR_W(expression,EXPR_OP)!=EOP_ADDR) return 0;
    expression=EXPR_W(expression,EXPR_LEFT);
    if(EXPR_W(expression,EXPR_OP)==1) {
        if((SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)==5) return 0;
        if(TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)==TK_FUNCTION) QUEUE_DEFERRED_SYMBOL(EXPR_W(expression,EXPR_LEFT));
        return 1;
    }
    return 0;
}
static void far pascal INIT_STRUCT_MEMBERS(unsigned int,unsigned int,long far *);
/* 015E: scalar initializer folding, fallback construction and constant output. */
/* Initialises one scalar (or a class object with a constructor) of type at
   *position in symbol.  expression is the value if the caller has parsed
   it already, else 0 and the value is parsed here (it may be in braces).
   The value is first analysed with NO_ERRORS_YET forced off so no code or
   errors come out of the trial.  A constant goes out as data; a member
   pointer constant (operator 0x48) is written as its parts; anything else
   becomes a start-up assignment in C++ (see the file overview). */
void far pascal INIT_SCALAR(unsigned int symbol,unsigned int type,long far *position,
    register unsigned int expression)
{
    unsigned int temporary;
    unsigned char braced;
    int offset;
    unsigned char aggregate,special,constant;
    int value;
    unsigned int reference;
    unsigned char saved;
    register unsigned int built;
    saved=NO_ERRORS_YET;
    special=(SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==5;
    braced=0;
    if(CURRENT_TOKEN==TOK_LBRACE && expression==0) {ADVANCE_TOKEN();braced=1;}
    if(expression==0) expression=PARSE_ASSIGNMENT_EXPR(8);
    NO_ERRORS_YET=0;
    /* Trial: analyse "temporary = copy of value" to see what it folds to. */
    built=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(type)),COPY_EXPR_TREE(expression));
    built=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(built,VOID_TYPE),0);
    aggregate=CPP_MODE &&
        ((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) || (EXPR_FLAGS[TYPE_W(EXPR_W(built,EXPR_TYPE),TYPE_KIND)]&0x40));
    NO_ERRORS_YET=saved && ERROR_COUNT==0;
    constant=EXPR_W(built,EXPR_OP)==EOP_ASSIGN && IS_CONSTANT_INITIALIZER(EXPR_W(built,EXPR_RIGHT));
    if(NO_ERRORS_YET) {
        if(aggregate || special || !constant) {
                /* Build "*(type *)((char *)&symbol + position) = value" and
                   queue it to run at start-up. */
            if(CPP_MODE) {
                if(!special) EMIT_ZERO_BYTES((unsigned int)TYPE_SIZE(type));
                temporary=MAKE_CAST_NODE(CHAR_POINTER_TYPE,MAKE_UNARY_NODE(0x1d,MAKE_SYMBOL_NODE(symbol)));
                temporary=MAKE_BINARY_NODE(0x16,temporary,MAKE_INT_CONSTANT(INT_TYPE,*position));
                temporary=MAKE_CAST_NODE(MAKE_POINTER_TYPE(type,0,0),temporary);
                temporary=MAKE_UNARY_NODE(0x18,temporary);
                temporary=MAKE_BINARY_NODE(5,temporary,expression);
                QUEUE_INIT_EXPR(temporary);FREE_EXPR_TREE(built);
            } else {
                REPORT_CURRENT_TOKEN(MSG_ILLEGAL_INITIALIZATION);FREE_EXPR_TREE(built);FREE_EXPR_TREE(expression);
            }
        } else {
            temporary=EXPR_W(built,EXPR_RIGHT);EXPR_W(built,EXPR_RIGHT)=0;
            FREE_EXPR_TREE(expression);FREE_EXPR_TREE(built);expression=temporary;
            if(EXPR_W(expression,EXPR_OP)==0x48) {
                offset=EXPR_W(expression,EXPR_RIGHT);value=EXPR_W(expression,EXPR_LEFT);reference=EXPR_W(expression,EXPR_SCOPE_CLASS);
                EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,(long)value));
                if(reference) {
                    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,(long)SYM_W(reference,SYM_VIRTUAL_INDEX)));
                    if(SYM_W(reference,SYM_VIRTUAL_INDEX)) {
                        EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,(long)offset));
                        EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,0L));
                    } else {
                        EMIT_CONST_INIT_VALUE(BUILD_SYMBOL_EXPR(reference));
                        if(TYPE_B(SYM_W(reference,SYM_TYPE),TYPE_FUNC_FLAGS)&0x40)
                            EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,0L));
                    }
                } else {
                    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,0L));
                    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,0L));
                    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE,0L));
                }
            } else EMIT_CONST_INIT_VALUE(expression);
        }
    }
    *position=*position+TYPE_SIZE(type);
    if(braced) {
        if(CURRENT_TOKEN==TOK_COMMA) ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}

/* 04B9: unsized array initialization counts emitted units through a FAR LONG. */
/* Initialises an array declared without a size: from a string literal
   (for char arrays) or from a brace list of elements.  type is the element
   type, size its size; *count receives the number of elements found.  For
   a static array each element starts at its own offset (target), padding
   any gap; for a local the position is just reset to it. */
static void far pascal INIT_UNSIZED_ARRAY(register unsigned int symbol,register unsigned int type,
    unsigned char advance,long far *count,long size,long far *position)
{
    unsigned char braced;
    long target;
    int value;
    unsigned int index;
    *count=0;
    braced=0;target=*position;
    if(CURRENT_TOKEN==TOK_LBRACE) {
        ADVANCE_TOKEN();braced=1;
        if(CURRENT_TOKEN==TOK_RBRACE) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
    }
    if(CURRENT_TOKEN==0x34 && (TYPE_W(type,TYPE_KIND)==TK_CHAR || TYPE_W(type,TYPE_KIND)==TK_UCHAR)) {
        while(CURRENT_TOKEN==0x34) {
            index=0;
            while((value=NEXT_LITERAL_CHAR(index++))!=-1) {
                ++*count;EMIT_BYTE_IF_ENABLED((unsigned char)value);
            }
            ADVANCE_TOKEN();
        }
        EMIT_BYTE_IF_ENABLED(0);++*count;*position+=*count;
    } else {
        if(!braced) REPORT_CURRENT_TOKEN(MSG_INITIALIZATION_ONLY);
        while(CURRENT_TOKEN==TOK_LBRACE || (TYPE_FLAGS[CURRENT_TOKEN]&EXPR_START_FLAG_MASK)) {
            if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==5) *position=target;
            else PAD_INIT_DATA(target,position);
            INIT_OBJECT(symbol,type,position,advance,1);
            ++*count;target=target+size;
            if(CURRENT_TOKEN!=TOK_RBRACE) {
                REQUIRE_TOKEN_ELSE_ERROR(8,0xca);
                if(CURRENT_TOKEN==TOK_COMMA) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
            }
        }
    }
    if(braced) {
        if(CURRENT_TOKEN==TOK_COMMA) ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}
/* 065D: sized arrays retain the original WORD string counter and LONG bounds. */
/* Initialises an array of count elements of type (each size bytes): from
   a string literal for char arrays (too long is an error; in C++ even when
   only the closing 0 does not fit), or from a brace list.  In C++ the
   elements left over in an array of class objects with constructors are
   constructed by CONSTRUCT_ARRAY_ELEMENTS. */
static void far pascal INIT_SIZED_ARRAY(unsigned int symbol,register unsigned int type,
    unsigned char advance,unsigned char empty,long count,long size,long far *position)
{
    unsigned char braced=0;
    long target=*position;
    int value;
    unsigned int index;
    register unsigned int characters;
    if(CURRENT_TOKEN==TOK_LBRACE) {
        ADVANCE_TOKEN();braced=1;
        if(CURRENT_TOKEN==TOK_RBRACE) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
    }
    if(CURRENT_TOKEN==0x34 && (TYPE_W(type,TYPE_KIND)==TK_CHAR || TYPE_W(type,TYPE_KIND)==TK_UCHAR)) {
        characters=0;
        while(CURRENT_TOKEN==0x34) {
            index=0;
            while((value=NEXT_LITERAL_CHAR(index++))!=-1) {
                ++characters;
                if((long)characters<=count) EMIT_BYTE_IF_ENABLED((unsigned char)value);
            }
            if(characters==0 && count>0) {characters=1;EMIT_BYTE_IF_ENABLED(0);}
            ADVANCE_TOKEN();
        }
        if((long)characters>count || (CPP_MODE && (long)characters>count-1))
            REPORT_CURRENT_TOKEN(MSG_ILLEGAL_INITIALIZATION);
        else if((long)characters<count) count=characters;
        *position+=count;
    } else {
        if(!braced) REPORT_CURRENT_TOKEN(MSG_INITIALIZATION_ONLY);
        while(count>0 && (CURRENT_TOKEN==TOK_LBRACE || (TYPE_FLAGS[CURRENT_TOKEN]&EXPR_START_FLAG_MASK))) {
            if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==5) *position=target;
            else PAD_INIT_DATA(target,position);
            INIT_OBJECT(symbol,type,position,advance,empty);
            count=count-1;target=target+size;
            if(count>0 && CURRENT_TOKEN!=TOK_RBRACE) {
                REQUIRE_TOKEN_ELSE_ERROR(8,0xca);
                if(CURRENT_TOKEN==TOK_COMMA) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
            }
        }
        if(CPP_MODE && count>0 && (TYPE_B(type,TYPE_ATTRS)&4)) {
            if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==5) *position=target;
            else PAD_INIT_DATA(target,position);
            CONSTRUCT_ARRAY_ELEMENTS(count,symbol,type,position,advance,empty);
        }
    }
    if(braced) {
        if(CURRENT_TOKEN==TOK_COMMA) ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}

/* 08EF: scan member links, preserving the terminal sentinel record access. */
/* Size in bytes of the storage unit that holds the bitfield member: the
   distance to the next member at a different offset, or to the end of the
   struct, at most the size of an int.  Non-data members (kind bits) are
   skipped. */
static unsigned int far pascal BITFIELD_UNIT_SIZE(unsigned int type,register unsigned int member)
{
    unsigned int space;
    register unsigned int offset=MEMBER_W(member,MEMB_VALUE);
    while(MEMBER_W(member,MEMB_NEXT)!=0 && ((MEMBER_B(member,MEMB_FLAGS)&3) || MEMBER_W(member,MEMB_VALUE)==offset))
        member=MEMBER_W(member,MEMB_NEXT);
    if(MEMBER_W(member,MEMB_VALUE)!=offset) return MEMBER_W(member,MEMB_VALUE)-offset;
    space=(unsigned int)TYPE_SIZE(type)-offset;
    if(space>INT_TYPE_SIZE) return INT_TYPE_SIZE;
    return space;
}
/* 0956: aggregate members and packed bitfields; all original sentinel
   accesses and the WORD packing/shift domain are retained for Borland16. */
/* Initialises the data members of a struct in order from a brace list.
   Static members, functions and other non-data members are skipped.
   Consecutive bitfields in one unit are collected in packed (shift and
   width from MEMB_BITFIELD) and written out as one or two bytes when the
   unit changes.  MEMBER_B(0,MEMB_FLAGS) is cleared first so the record at
   offset 0 works as a list end in the skipping loops. */
static void far pascal INIT_STRUCT_MEMBERS(unsigned int symbol,unsigned int type,long far *position)
{
    unsigned char active;
    long base,target,stride,value;
    unsigned int masked;
    int shift,width;
    unsigned char braced;
    unsigned int packed;
    register unsigned int member;
    register int bits;
    stride=0;bits=0;braced=0;
    if(CURRENT_TOKEN==TOK_LBRACE) {
        ADVANCE_TOKEN();braced=1;
        if(CURRENT_TOKEN==TOK_RBRACE) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
    } else REPORT_CURRENT_TOKEN(MSG_INITIALIZATION_ONLY);
    active=0;base=*position;packed=0;
    member=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);
    while(member && (CURRENT_TOKEN==TOK_LBRACE || (TYPE_FLAGS[CURRENT_TOKEN]&EXPR_START_FLAG_MASK))) {
        MEMBER_B(0,MEMB_FLAGS)=0;
        while((MEMBER_B(member,MEMB_FLAGS)&3) || ((MEMBER_B(member,MEMB_FLAGS)&0x20) && !(MEMBER_B(member,MEMB_FLAGS)&0x80)))
            member=MEMBER_W(member,MEMB_NEXT);
        if(member==0) continue;
        target=base+MEMBER_W(member,MEMB_VALUE);
        if(MEMBER_B(member,MEMB_FLAGS)&0x40) {
            shift=MEMBER_B(member,MEMB_BITFIELD)&7;width=MEMBER_B(member,MEMB_BITFIELD)>>3;
            if(!active || *position!=target) {
                if(active) {
                    EMIT_BYTE_IF_ENABLED((unsigned char)(packed&0xff));packed>>=8;bits-=8;
                    if(stride>1) {EMIT_BYTE_IF_ENABLED((unsigned char)packed);packed=0;bits=0;}
                    *position+=stride;
                }
                active=1;PAD_INIT_DATA(target,position);
                stride=BITFIELD_UNIT_SIZE(type,member);
            }
            PARSE_CONSTANT_EXPR_VALUE(8,&value);
            masked=((1U<<width)-1)&(unsigned int)value;
            packed|=masked<<shift;bits=width+shift;
        } else {
            if(active) {
                EMIT_BYTE_IF_ENABLED((unsigned char)(packed&0xff));
                if(stride>1) EMIT_BYTE_IF_ENABLED((unsigned char)(packed>>8));
                packed=0;*position+=stride;active=0;bits=0;
            }
            PAD_INIT_DATA(target,position);
            INIT_OBJECT(symbol,MEMBER_W(member,MEMB_TYPE),position,0,0);
        }
        member=MEMBER_W(member,MEMB_NEXT);
        if(CURRENT_TOKEN!=TOK_RBRACE && member) {
            REQUIRE_TOKEN_ELSE_ERROR(8,0xca);
            if(CURRENT_TOKEN==TOK_COMMA) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
        }
    }
    if(active) {
        EMIT_BYTE_IF_ENABLED((unsigned char)(packed&0xff));++*position;
        if(bits>8) {EMIT_BYTE_IF_ENABLED((unsigned char)(packed>>8));++*position;}
    }
    if(braced) {
        if(CURRENT_TOKEN==TOK_COMMA) ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}

/* 0C08: dispatch array, union/member and scalar initialization. */
/* Initialises an object of type at *position in symbol, choosing by kind.
   advance: the object is in a far (attribute 0x40) array, so after it
   NEXT_DATA_BANK is called; empty is passed on to it.  A struct of unknown
   size cannot be initialised (the braces are skipped).  A class with a
   constructor (attribute 4) is initialised like a scalar, by an
   expression. */
void far pascal INIT_OBJECT(register unsigned int symbol,register unsigned int type,
    long far *position,unsigned char advance,unsigned char empty)
{
    long count;
    unsigned int member;
    if(TYPE_W(type,TYPE_KIND)==TK_ARRAY) {
        advance=advance || (TYPE_B(type,TYPE_ATTRS)&0x40);
        if(TYPE_SIZE(type)==0) {
            INIT_UNSIZED_ARRAY(symbol,TYPE_W(type,TYPE_TARGET),advance,&count,TYPE_SIZE(TYPE_W(type,TYPE_TARGET)),position);
            TYPE_L(type,TYPE_ARRAY_COUNT)=count;
        } else INIT_SIZED_ARRAY(symbol,TYPE_W(type,TYPE_TARGET),advance,empty,TYPE_L(type,TYPE_ARRAY_COUNT),TYPE_SIZE(TYPE_W(type,TYPE_TARGET)),position);
    } else if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) {
        if(TYPE_SIZE(type)==0) {IN_ERROR_RECOVERY=1;END_BRACE_INIT();return;}
        if(TYPE_W(type,TYPE_KIND)==TK_UNION) {
            member=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);
            MEMBER_B(0,MEMB_FLAGS)=0;
            while((MEMBER_B(member,MEMB_FLAGS)&3)!=0) member=MEMBER_W(member,MEMB_NEXT);
            type=MEMBER_W(member,MEMB_TYPE);
            INIT_OBJECT(symbol,type,position,0,0);
        } else if(TYPE_B(type,TYPE_ATTRS)&4) INIT_SCALAR(symbol,type,position,0);
        else INIT_STRUCT_MEMBERS(symbol,type,position);
    } else INIT_SCALAR(symbol,type,position,0);
    if(advance) NEXT_DATA_BANK(empty);
}
/* 0D6E: wrapper retains both validation diagnostics and repeated symbol tests.
   Meaningful consumers ignore its scalar result; historical type is non-unique. */
/* Parses the initializer of declarator symbol of type, after the '='.
   Checks first that a brace list is used where one is needed (and not for
   a C++ class that forbids it, TAG_CLASS_FLAGS 0x40); IN_ERROR_RECOVERY is set
   after such an error so follow-on messages are suppressed.  For statics,
   output goes to the symbol's own data stream and is padded to the full
   size of the type. */
void far pascal INIT_DECLARATOR(register unsigned int symbol,register unsigned int type)
{
    long position;
    unsigned int saved;
    unsigned char advance,empty;
    if(CPP_MODE && (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && CURRENT_TOKEN==TOK_LBRACE &&
       (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x40)) {
        REPORT_CURRENT_TOKEN(MSG_CLASSES_CANNOT);IN_ERROR_RECOVERY=1;
    } else if(((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) ||
              (TYPE_W(type,TYPE_KIND)==TK_ARRAY && CURRENT_TOKEN!=0x34 && !(TYPE_B(type,TYPE_ATTRS)&4))) &&
              CURRENT_TOKEN!=TOK_LBRACE) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_216);IN_ERROR_RECOVERY=1;
    } else IN_ERROR_RECOVERY=0;
    position=0;
    advance=TYPE_W(type,TYPE_KIND)==TK_ARRAY && (TYPE_B(type,TYPE_ATTRS)&0x40);
    empty=advance && TYPE_SIZE(type)==0;
    if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=5) {
        if(advance) saved=BEGIN_ARRAY_DATA(symbol);
        else saved=SELECT_SYMBOL_STREAM(symbol);
    }
    INIT_OBJECT(symbol,type,&position,advance,empty);
    if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=5) {
        if(advance) EMIT_DATA_SPANS(TYPE_SIZE(type)-position,empty);
        else PAD_INIT_DATA(TYPE_SIZE(type),&position);
        IN_ERROR_RECOVERY=0;SET_STREAM(saved);
    }
}

/* 0EC6: original symbol-class tests are repeated across INIT_SCALAR;
   the saved output state remains indeterminate if that class changes5->other. */
/* Parses a scalar initializer, optionally in braces, for symbol;
   initializer is the type to initialise.  Used where the type is known to
   be scalar. */
void far pascal PARSE_SCALAR_INITIALIZER(register unsigned int symbol,unsigned int initializer)
{
    unsigned char braced;
    unsigned int saved;
    long position=0;
    braced=0;
    if(CURRENT_TOKEN==TOK_LBRACE) {braced=1;ADVANCE_TOKEN();}
    if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=5) saved=SELECT_SYMBOL_STREAM(symbol);
    INIT_SCALAR(symbol,initializer,&position,0);
    if((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)!=5) SET_STREAM(saved);
    if(braced) {
        if(CURRENT_TOKEN==TOK_COMMA) ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}
