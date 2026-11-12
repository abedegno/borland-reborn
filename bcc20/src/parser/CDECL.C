/* target: ovr127_C202UNIT */
/* Role: parser (C mode): external and local declarations: storage classes, struct fields
   and bitfields, initializers and their data, function definitions. Entry points:
   BCC_STATEMENT_MAIN, TOKEN_STARTS_TYPE, BCC_STMT_BUILD, REPORT_AND_SKIP,
   BCC_STMT_DECL_PARSE, BCC_STMT_FUNCTION_NEAR, BCC_STMT_BIND_FIELD, STBEGIN (+3 more). Map
   of all sources: docs/SOURCE-MAP.md. */
/* Original CO046 (ovr_1cf2_9000) as one source. */
/* opts: -mm -G -O -Z -p -Y -y */
/* Overview: declarations in the C front end (COMPILE_C_SOURCE, for .c
   files).  BCC_STATEMENT_MAIN is the top of the C parse: it reads external
   declarations until end of input.  A declaration is: specifiers
   (BCC_STMT_BUILD: storage class, type keywords, struct/union/enum
   bodies, typedef names, modifiers), then a list of declarators
   (BCC_STMT_PARSE_NEXT), each declared with DECLARE_SYMBOL and perhaps
   initialised (STINIT for static data written as bytes,
   BCC_STMT_FINISH_NEAR for locals initialised by code).  A function
   declarator followed by '{' is a definition (BCC_STMT_MEMBER_NEAR), whose
   body goes to PARSE_BLOCK_BODY in STMTC.C.  Local declarations at the
   start of a block come through BCC_STMT_DECL_PARSE.
   Tokens come straight from the lexer: NEXT() returns the next token code
   (TOKEN_TYPE), with one token of push-back (TOKEN_PUSHED_BACK); names and
   constant values are in TOKEN_CONST_VALUE.  Symbols are C symbol records
   (CSYM_*) in scopes C_GLOBAL_SCOPE, C_FUNCTION_SCOPE and the block scope
   C_DECL_SCOPE.  C symbol classes (CSYM_CLASS, C_DECL_STORAGE_CLASS): 1
   global definition, 2 extern, 3 static, 4 static in a block, 5 auto,
   6 parameter, 7 pseudo-register, 8 typedef, 9 enumerator, 10 intrinsic,
   11 struct/union/enum tag, 13 register.  Types use the C layout of the
   type pool (TYPE_C_* fields).
   Much of this file is written with register pseudo-variables (_SI, _DI,
   _ES, _BX, _AX) and ES_W/ES_B accessors: that is how the original code
   used the registers (SI usually the symbol, DI the type or the flag word
   passed to DECLARE_SYMBOL), kept so the build matches byte for byte.
   Statements like "_AX=NEXT();" or "_AX=_AX;" only reproduce the
   original's register use. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"
static unsigned int near pascal BCC_STMT_CHECK_TYPE_NEAR(unsigned int kind,unsigned int type);



/* ---- STMAIN (listing ovr_1cf2_9000:0000) ---- */
int far pascal TOKEN_STARTS_TYPE(register unsigned int kind);
unsigned int far pascal BCC_STMT_BUILD(void);
static int near pascal BCC_STMT_PARSE_NEXT(unsigned int kind,unsigned int base,unsigned int allowed);
extern unsigned int TOKEN_TYPE; extern unsigned int C_DECL_STORAGE_CLASS;
extern unsigned long TOKEN_POSITION;
extern unsigned char TOKEN_PUSHED_BACK,LANGUAGE_MODE;
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern void (far pascal *RESET_EXPR_POOL_HOOK)(void);
extern int far pascal LEX_NEXT_TOKEN(void);
extern void far pascal NESTING_CHECK(void);
extern void far pascal PARSE_ASM_STATEMENT(void);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses a whole C file: external declarations, file-level asm
   statements, stray '}' errors.  A declaration without storage class is a
   global definition (class 1); auto and register are not allowed here.
   The expression pool is reset after each declaration
   (RESET_EXPR_POOL_HOOK).  The back end is started first, as functions
   are compiled as soon as they are parsed. */
void far pascal BCC_STATEMENT_MAIN(void)
{
    register unsigned int statement;
    C_CURRENT_FUNCTION_SYMBOL=0;
    NEXT();
    BEGIN_BACKEND_OUTPUT_HOOK();
    if(TOKEN_TYPE==0 && LANGUAGE_MODE==1) REPORT_ERROR(MSG_FILE_MUST_CONTAIN);
    for(;;) {
        NESTING_CHECK();
        if(TOKEN_TYPE==0) break;
        LOGICAL_LINE=CURRENT_LINE;
        C_DECL_START_POSITION=TOKEN_POSITION;
        if(TOKEN_TYPE==0x57) PARSE_ASM_STATEMENT();
        else if(TOKEN_TYPE==6) REPORT_ERROR(MSG_UNEXPECTED);
        else {
            if(TOKEN_STARTS_TYPE(TOKEN_TYPE)) {
                statement=BCC_STMT_BUILD();
                if(statement==0) goto next;
                if(C_DECL_STORAGE_CLASS==0) C_DECL_STORAGE_CLASS=1;
                else if(C_DECL_STORAGE_CLASS==5 || C_DECL_STORAGE_CLASS==13) {
                    REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258,(char far *)STORAGE_CLASS_NAMES[C_DECL_STORAGE_CLASS]);
                    C_DECL_STORAGE_CLASS=1;
                }
            } else {C_DECL_STORAGE_CLASS=1;statement=0;}
            if(TOKEN_TYPE!=7) {
                C_OLD_STYLE_PARAM_LIST=0;
                BCC_STMT_PARSE_NEXT(C_DECL_STORAGE_CLASS,statement,1);
            }
        }
        RESET_EXPR_POOL_HOOK();
next:
        NEXT();
    }
}
#undef NEXT

/* ---- STCLASS (listing ovr_1cf2_9000:0118) ---- */
static unsigned int near pascal BCC_STMT_SPECIAL_CHECK(unsigned int name);
extern long TOKEN_CONST_VALUE;
/* Nonzero if token kind can start declaration specifiers: a keyword with
   flag 0x30 in TOKEN_START_FLAGS, or an identifier naming a typedef
   (BCC_STMT_SPECIAL_CHECK reads the identifier from TOKEN_CONST_VALUE). */
int far pascal TOKEN_STARTS_TYPE(register unsigned int kind)
{
    if(TOKEN_START_FLAGS[kind]&0x30) return 1;
    if(kind==0x31 && BCC_STMT_SPECIAL_CHECK((unsigned int)TOKEN_CONST_VALUE)) return 1;
    return 0;
}

/* ---- STBUILD (listing ovr_1cf2_9000:0147) ---- */
static unsigned int near pascal BCC_STMT_ALLOC(int kind);
static unsigned int near pascal BCC_STMT_LOOKUP(void);
struct Flags { unsigned char first,second,third; };
extern struct Flags C_DECL_MODIFIERS;
extern unsigned int C_DECL_STORAGE_CLASS; extern unsigned int C_DECL_SYMBOL_FLAGS; extern unsigned int TOKEN_TYPE;
extern unsigned char TOKEN_PUSHED_BACK,UNSIGNED_CHAR;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern struct Flags far pascal BCC_STMT_BEGIN(struct Flags);
extern int far pascal LEX_NEXT_TOKEN(void);
/* Parses declaration specifiers and returns the base type (0 after an
   error).  Leaves the storage class in C_DECL_STORAGE_CLASS (0 if none),
   const and volatile in C_DECL_SYMBOL_FLAGS and modifiers in
   C_DECL_MODIFIERS.  short, long, signed and unsigned are collected in the
   flags c, d, b and a and combined with the base kind at the end (int
   kind 5 becomes short 3, unsigned 6, long 7 ...; plain char is unsigned
   with -K, UNSIGNED_CHAR).  The basic types come from MODE_HOOK(kind).
   The first token after the specifiers is left pushed back. */
unsigned int far pascal BCC_STMT_BUILD(void)
{
    register unsigned int node=0;
    unsigned int a=0,b=0,c=0,d=0;
    register unsigned int kind=0;
    unsigned int flags=0,done;
    C_DECL_MODIFIERS.first=0;C_DECL_MODIFIERS.second=0;C_DECL_MODIFIERS.third=0;C_DECL_STORAGE_CLASS=0;
    do {
        done=0;
        C_DECL_MODIFIERS=BCC_STMT_BEGIN(C_DECL_MODIFIERS);
        switch(TOKEN_TYPE) {
        case 53: if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_TOO_MANY_STORAGE);C_DECL_STORAGE_CLASS=3;break;
        case 54: if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_TOO_MANY_STORAGE);C_DECL_STORAGE_CLASS=2;break;
        case 55: if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_TOO_MANY_STORAGE);C_DECL_STORAGE_CLASS=8;break;
        case 57: if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_TOO_MANY_STORAGE);C_DECL_STORAGE_CLASS=5;break;
        case 56: if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_TOO_MANY_STORAGE);C_DECL_STORAGE_CLASS=13;break;
        case 74: if(flags&1) REPORT_ERROR(MSG_CONFLICTING_TYPE);flags|=1;break;
        case 75: if(flags&2) REPORT_ERROR(MSG_CONFLICTING_TYPE);flags|=2;break;
        case 69: if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);kind=12;break;
        case 58: if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);kind=1;break;
        case 59: c=1;break;
        case 63: d=1;break;
        case 61: a=1;break;
        case 62: b=1;break;
        case 60: if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);kind=5;break;
        case 65: if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);kind=10;break;
        case 64: if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);kind=9;break;
        case 68:
            if(kind || c || a || d || b) REPORT_ERROR(MSG_TOO_MANY_TYPES);
            node=BCC_STMT_LOOKUP();if(!node) return 0;
            kind=21;TOKEN_PUSHED_BACK=1;break;
        case 66:
            if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);
            node=BCC_STMT_ALLOC(1);if(!node) return 0;
            kind=19;TOKEN_PUSHED_BACK=1;break;
        case 67:
            if(kind) REPORT_ERROR(MSG_TOO_MANY_TYPES);
            node=BCC_STMT_ALLOC(2);if(!node) return 0;
            kind=19;TOKEN_PUSHED_BACK=1;break;
        case 49:
            if(kind) { kind=kind; goto stop; }
            node=BCC_STMT_SPECIAL_CHECK(TOKEN_CONST_VALUE);
            if(node) kind=-1;
            else {TOKEN_PUSHED_BACK=1;done=1;node=node;}
            break;
        default:
stop:
            TOKEN_PUSHED_BACK=1;done=1;
        }
        _AX=TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN();
        LOGICAL_LINE=CURRENT_LINE;
    } while(!done);
    if(d&&c) { node=node; goto conflict; }
    if(b&&a) {
conflict:
        REPORT_ERROR(MSG_TOO_MANY_TYPES);
    }
    switch(kind) {
    case 1:
        if(a) kind=2;
        else if(!b && UNSIGNED_CHAR) kind=2;
        break;
    case 9:
        if(d) kind=10;
        if(a||b) REPORT_ERROR(MSG_TOO_MANY_TYPES);
        break;
    case 10:
        if(d) kind=11;
        if(a||b) REPORT_ERROR(MSG_TOO_MANY_TYPES);
        break;
    case 0: case 5:
        if(d&&a) kind=8;
        else if(d) kind=7;
        else if(c&&a) kind=4;
        else if(c) kind=3;
        else if(a) kind=6;
        else kind=5;
        break;
    }
    if(!node) node=MODE_HOOK(kind);
    C_DECL_SYMBOL_FLAGS=flags;
    return node;
}

/* ---- LG0BB (listing ovr_1cf2_9000:053C) ---- */
extern struct Flags C_DECL_MODIFIERS;
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
/* If name is a typedef in scope, returns its type (a typedef declared with
   far data, flag 0x10, also sets the far modifier); else 0. */
static unsigned int near pascal BCC_STMT_SPECIAL_CHECK(unsigned int name)
{
    register unsigned int record;
    record=LOOKUP_SYMBOL(name,C_DECL_SCOPE,0);
    if(record && CSYM_B(record,CSYM_CLASS)==8) {
        if(CSYM_W(record,CSYM_FLAGS)&0x10) {
            if(C_DECL_MODIFIERS.second) REPORT_ERROR(MSG_CONFLICTING_TYPE);
            C_DECL_MODIFIERS.second=9;
        }
        return CSYM_W(record,CSYM_TYPE);
    }
    return 0;
}

/* ---- STALLOC (listing ovr_1cf2_9000:0592) ---- */
static void near pascal BCC_STMT_CHECK_NEAR(unsigned int name);
extern unsigned int C_DECL_STORAGE_CLASS; extern unsigned int TOKEN_TYPE; extern unsigned int DIAG_NAME_BUFFER; extern unsigned int C_DECL_SYMBOL_FLAGS;
extern unsigned char TOKEN_PUSHED_BACK,LANGUAGE_MODE;
extern signed char BCC_PACK_FLAG;
extern int far pascal LEX_NEXT_TOKEN(void);
extern unsigned int far pascal BCC_STMT_FIND2(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal NEW_STRUCT_TYPE(signed char);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern char far *far pascal NAME_TEXT_COPY(unsigned int);

extern void far cdecl BCC_STMT_ERROR_NEAR(unsigned int,char far *);
extern unsigned int far pascal PARSE_CONSTANT_EXPR(unsigned int);
extern unsigned int far pascal BCC_STMT_DECL_NEW(unsigned int);
extern unsigned int far pascal BCC_STMT_BIND_TYPE(unsigned int,unsigned int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int far pascal ADD_STRUCT_MEMBER(unsigned int,unsigned int,unsigned int,unsigned int,unsigned char,unsigned char,unsigned int);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses a struct (kind 1) or union (kind 2) specifier after its keyword
   and returns the type.  "struct name" without a body refers to (or
   forward-declares) the tag; with a body, the members are laid out:
   offsets, bitfields packed into 16-bit units (a width of 16 is stored as
   0), word alignment when BCC_PACK_FLAG (probably the -a option) is set,
   and the total size (an empty struct is an error and gets size 1;
   more than 64K is an error).  Unnamed bitfields only advance the bit
   position.  The tag symbol is class 11 in C_DECL_SCOPE. */
static unsigned int near pascal BCC_STMT_ALLOC(int kind)
{
    unsigned int base,result,declaration,symbol,field,name,saved_kind;
    int width,bits;
    unsigned long size;
    int named=0;
    register unsigned int type;
    register unsigned int head;
    saved_kind=C_DECL_STORAGE_CLASS;
    if(NEXT()==49) {name=TOKEN_CONST_VALUE;_AX=NEXT();}
    else name=0;
    if(TOKEN_TYPE!=5) {
        if(name) {
            symbol=TOKEN_TYPE==7 ? BCC_STMT_FIND2(name,C_DECL_SCOPE,2) : LOOKUP_SYMBOL(name,C_DECL_SCOPE,2);
            if(!symbol) {
                result=NEW_STRUCT_TYPE((signed char)kind);
                TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
                _AX=DECLARE_SYMBOL(name,C_DECL_SCOPE,2,11,result,0,0);
                _BX=result;_ES=TYPE_POOL;ES_W(_BX,TYPE_C_TAG_SYMBOL)=_AX;
                goto done;
            } else {
                _BX=symbol;_ES=CSYM_POOL_SEG;result=ES_W(_BX,CSYM_TYPE);
                _BX=result;_ES=TYPE_POOL;
                if(ES_SC(_BX,TYPE_C_BYTE9)==kind) goto reference_done;
                DIAG_NAME_BUFFER=0;
                REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(name));
                goto done;
            }
        } else {
            BCC_STMT_ERROR_NEAR(216,(char far *)0);
            result=0;
            goto done;
        }
reference_done:
        _AX=_AX;
        goto done;
    }
    size=0;bits=0;head=0;
    if(name) {
        symbol=BCC_STMT_FIND2(name,C_DECL_SCOPE,2);
        if(!symbol) {
            result=NEW_STRUCT_TYPE((signed char)kind);
            _AX=DECLARE_SYMBOL(name,C_DECL_SCOPE,2,11,result,0,0);
            _BX=result;_ES=TYPE_POOL;ES_W(_BX,TYPE_C_TAG_SYMBOL)=_AX;
        } else {
            _BX=symbol;_ES=CSYM_POOL_SEG;result=ES_W(_BX,CSYM_TYPE);
            _BX=result;_ES=TYPE_POOL;
            if(ES_W(_BX,TYPE_C_MEMBERS)) BCC_STMT_CHECK_NEAR(name);
            _BX=result;_ES=TYPE_POOL;
            if(ES_SC(_BX,TYPE_C_BYTE9)!=kind) {
                DIAG_NAME_BUFFER=0;
                REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(name));
            }
        }
        named=1;
    } else {
        result=NEW_STRUCT_TYPE((signed char)kind);
        DECLARE_SYMBOL(0,C_DECL_SCOPE,2,11,result,0,0);
    }
    _BX=result;_ES=TYPE_POOL;ES_W(_BX,TYPE_C_SIZE)=1;
    while(NEXT()!=6 && TOKEN_TYPE!=0) {
        if(LANGUAGE_MODE==1 && !TOKEN_STARTS_TYPE(TOKEN_TYPE)) REPORT_ERROR(MSG_TYPE_NAME_EXPECTED);
        base=BCC_STMT_BUILD();
        if(C_DECL_STORAGE_CLASS) REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258,(char far *)STORAGE_CLASS_NAMES[C_DECL_STORAGE_CLASS]);
        if(base) {
            for(;;) {
                if(TOKEN_TYPE==33) {
                    _AX=NEXT();
                    if(!PARSE_CONSTANT_EXPR(2)) continue;
                    width=TOKEN_CONST_VALUE;
                    if(width>16) {REPORT_ERROR(MSG_BIT_FIELD_TOO_LARGE);width=0;}
                    if(width==0) {
                        if(bits) {
                            if(BCC_PACK_FLAG!=0) size+=BITFIELD_UNIT_BYTES;
                            else size+=1;
                            bits=0;
                            _AX=_AX;
                        }
                    } else if(bits+width>16) {
                        if(BCC_PACK_FLAG!=0) size+=BITFIELD_UNIT_BYTES;
                        else size+=1;
                        bits=0;
                    }
                    bits+=width;
                    if(!BCC_PACK_FLAG && bits>8) {
                        size+=(unsigned int)bits>>3;
                        bits=bits&7;
                    }
                    if(TOKEN_TYPE!=8) {
                        if(TOKEN_TYPE==7) break;
                        BCC_STMT_ERROR_NEAR(31,(char far *)0);
                        break;
                    }
                    _AX=NEXT();
                    continue;
                }
                declaration=BCC_STMT_DECL_NEW(0);
                if(!declaration) break;
                name=C_DECLARATOR_NAME;
                type=BCC_STMT_BIND_TYPE(declaration,base);
                if(TOKEN_TYPE==33) {
                    _AX=NEXT();
                    if(!PARSE_CONSTANT_EXPR(2)) break;
                    width=TOKEN_CONST_VALUE;
                    if(width==0) REPORT_ERROR(MSG_BIT_FIELDS_MUST);
                    if(width==16) width=0;
                    else if(width>16) {REPORT_ERROR(MSG_BIT_FIELD_TOO_LARGE);width=0;}
                    if(bits+width>16) {
                        if(BCC_PACK_FLAG!=0) size+=BITFIELD_UNIT_BYTES;
                        else size+=1;
                        bits=0;
                    }
                    _ES=TYPE_POOL;
                    if(ES_B(type,TYPE_KIND)>6) {REPORT_ERROR(MSG_BIT_FIELDS_MUST_SIGNED);type=MODE_HOOK(5);}
                } else {
                    width=0;
                    _ES=TYPE_POOL;
                    if(ES_B(type,TYPE_KIND)==18) REPORT_ERROR(MSG_FUNCTIONS_MAY_NOT_PART);
                }
                if(kind==1) {
                    if(!width && bits) {
                        size+=1;
                        if(bits>8) size+=1;
                        bits=0;
                    }
                    if(BCC_PACK_FLAG!=0) size+=(unsigned int)size%TYPE_ALIGNMENT_HOOK(type);
                    field=ADD_STRUCT_MEMBER(name,head,type,(unsigned int)size,(unsigned char)bits,(unsigned char)width,C_DECL_SYMBOL_FLAGS);
                    if(!head) head=field;
                    if(!width) size+=SIZE_OF_TYPE_CHECKED_HOOK(type);
                    else {
                        bits+=width;
                        if(!BCC_PACK_FLAG && bits>=8) {
                            size+=(unsigned int)bits>>3;
                            bits=bits&7;
                        }
                    }
                } else {
                    field=ADD_STRUCT_MEMBER(name,head,type,0,0,(unsigned char)width,C_DECL_SYMBOL_FLAGS);
                    if(!head) head=field;
                    if(!width) {
                        if(SIZE_OF_TYPE_CHECKED_HOOK(type)>size) {size=SIZE_OF_TYPE_CHECKED_HOOK(type);_AX=_AX;}
                    } else {
                        if(BITFIELD_UNIT_BYTES>size) size=BITFIELD_UNIT_BYTES;
                    }
                }
                if(TOKEN_TYPE!=8) {
                    if(TOKEN_TYPE==7) break;
                    BCC_STMT_ERROR_NEAR(31,(char far *)0);
                    break;
                }
                _AX=NEXT();
            }
        }
        if(TOKEN_TYPE==6) break;
    }
    if(bits) {
        if(BCC_PACK_FLAG!=0) size+=BITFIELD_UNIT_BYTES;
        else size+=1;
    } else if(size==0) {REPORT_ERROR(MSG_SIZE_TYPE_UNKNOWN_ZERO);size=1;}
    if(BCC_PACK_FLAG!=0) {size+=1;size&=0xFFFFFFFEUL;}
    if(size&0xFFFF0000UL) {REPORT_ERROR(MSG_STRUCTURE_SIZE_TOO);size=1;}
    _BX=result;_ES=TYPE_POOL;ES_W(_BX,TYPE_C_SIZE)=(unsigned int)size;ES_W(_BX,TYPE_C_MEMBERS)=head;
    _AX=NEXT();
    if(named) TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
done:
    C_DECL_STORAGE_CLASS=saved_kind;
    return result;
}
#undef NEXT

/* ---- STLOOK (listing ovr_1cf2_9000:0C48) ---- */
extern unsigned char TOKEN_PUSHED_BACK,OPTION_SOURCE_DEBUG;
extern signed char OPTION_ENUMS_AS_INT;
extern unsigned int TOKEN_TYPE;
extern long BCC_ENUM_LIMIT_LO;
extern int far pascal LEX_NEXT_TOKEN(void);
extern unsigned int far pascal BCC_STMT_FIND2(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_ENUM_TYPE(unsigned int);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal PARSE_CONSTANT_EXPR(unsigned int);
extern void far cdecl BCC_STMT_ERROR_NEAR(unsigned int,char far *);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses an enum specifier after its keyword and returns the type.  Each
   enumerator becomes a class 9 symbol holding its value; values count up
   from the previous one unless given.  An enum whose values fit in a
   signed char is marked byte-sized (TYPE_MEMBER_CLASS 1) unless -b
   (OPTION_ENUMS_AS_INT).  With debug information the enumerators are also
   kept as a field list (TYPE_TAG_BODY). */
static unsigned int near pascal BCC_STMT_LOOKUP(void)
{
    unsigned int type,record,head,field;
    int minimum,maximum;
    register unsigned int name;
    register int value;
    if(NEXT()==49) {
        name=TOKEN_CONST_VALUE;
        NEXT();
    } else name=0;
    head=0;
    if(TOKEN_TYPE==5) {
        if(name) {
            record=BCC_STMT_FIND2(name,C_DECL_SCOPE,2);
            if(!record) {
                type=MAKE_ENUM_TYPE(0);
                DECLARE_SYMBOL(name,C_DECL_SCOPE,2,11,type,0,0);
            } else {
                type=CSYM_W(record,CSYM_TYPE);
                if(TYPE_W(type,TYPE_TAG_BODY)) BCC_STMT_CHECK_NEAR(name);
            }
        } else type=MAKE_ENUM_TYPE(0);
        value=-1;
        minimum=0;maximum=0;
        while(NEXT()!=6) {
            if(TOKEN_TYPE!=49) break;
            name=TOKEN_CONST_VALUE;
            NEXT();
            if(TOKEN_TYPE==11) {
                NEXT();
                PARSE_CONSTANT_EXPR(4);
                value=TOKEN_CONST_VALUE;
            } else {
                if(value==BCC_ENUM_LIMIT_LO) REPORT_ERROR(MSG_NUMERIC_CONSTANT_TOO);
                value++;
            }
            record=DECLARE_SYMBOL(name,C_DECL_SCOPE,0,9,type,0,0);
            if(OPTION_SOURCE_DEBUG) {
                field=ADD_STRUCT_MEMBER(name,head,PLAIN_INT_TYPE,value,0,0,0);
                if(!head) head=field;
            }
            if(value<minimum) minimum=value;
            if(value>maximum) maximum=value;
            CSYM_W(record,CSYM_OFFSET)=value;
            if(TOKEN_TYPE!=8) break;
        }
        if(TOKEN_TYPE!=6) {
            BCC_STMT_ERROR_NEAR(40,(char far *)0);
            return 0;
        }
        NEXT();
        if(OPTION_ENUMS_AS_INT==0 && minimum>=-128 && maximum<=127) {
            TYPE_W(type,TYPE_MEMBER_CLASS)=1;
        }
        TYPE_W(type,TYPE_TAG_BODY)=head;
    } else {
        if(name) {
            record=LOOKUP_SYMBOL(name,C_DECL_SCOPE,2);
            if(!record) {
                if(!OPTION_ENUMS_AS_INT) REPORT_ERROR(MSG_MUST_PREVIOUSLY_206);
                type=MAKE_ENUM_TYPE(0);
                DECLARE_SYMBOL(name,C_DECL_SCOPE,2,11,type,0,0);
            } else {
                type=CSYM_W(record,CSYM_TYPE);
            }
        } else {
            BCC_STMT_ERROR_NEAR(40,(char far *)0);
            return 0;
        }
    }
    TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
    return type;
}
#undef NEXT

/* ---- STERR (listing ovr_1cf2_9000:0EEF) ---- */
extern unsigned int TOKEN_TYPE;
extern unsigned char TOKEN_PUSHED_BACK;
extern int far pascal LEX_NEXT_TOKEN(void);
extern void far pascal BCC_LEX_RESTORE(unsigned int);

#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Reports error (with text) and recovers: skips tokens up to ';' or a '}'
   (left pushed back), stepping over whole brace groups and draining the
   characters of string literals.  In MACRO_MODE (inside #if) it skips to
   the end of the line instead. */
void far cdecl REPORT_AND_SKIP(unsigned int error,char far *text)
{
    register int token;
    register int depth;
    LOGICAL_LINE=CURRENT_LINE;
    token=TOKEN_TYPE;
    REPORT_ERROR(error,text);
    if(MACRO_MODE) {
        while(token && token!=10) token=NEXT();
    } else {
        if(token==6) TOKEN_PUSHED_BACK=1;
        else {
            while(token && token!=7 && token!=6) {
                if(token==5) {
                    depth=1;
                    for(;;) {
                        token=NEXT();
                        LOGICAL_LINE=CURRENT_LINE;
                        if(!token) return;
                        if(token==6) {
                            depth--;
                            if(depth<=0) break;
                        } else if(token==5) depth++;
                        else if(token==52) BCC_LEX_RESTORE(0);
                    }
                } else if(token==52) BCC_LEX_RESTORE(0);
                token=NEXT();
                LOGICAL_LINE=CURRENT_LINE;
            }
            if(token==6) TOKEN_PUSHED_BACK=1;
        }
    }
}
#undef NEXT

/* ---- STWRAP (listing ovr_1cf2_9000:0FDE) ---- */
extern unsigned int C_DECL_STORAGE_CLASS,TOKEN_TYPE;
/* Parses one local declaration (no storage class means auto). */
void far pascal BCC_STMT_DECL_PARSE(void)
{
    register unsigned int node=BCC_STMT_BUILD();
    if(node) {
        if(C_DECL_STORAGE_CLASS==0) C_DECL_STORAGE_CLASS=5;
        if(TOKEN_TYPE!=7) BCC_STMT_PARSE_NEXT(C_DECL_STORAGE_CLASS,node,0);
    }
}

/* ---- STPARSE (listing ovr_1cf2_9000:100E) ---- */
static int near pascal BCC_STMT_MEMBER_NEAR(unsigned int kind,unsigned int binding,unsigned int flags);
void far pascal BCC_STMT_FUNCTION_NEAR(void);
unsigned int far pascal STINIT(unsigned int type,unsigned int fixed,unsigned int mode);
static void near pascal BCC_STMT_FINISH_NEAR(unsigned int record);
extern unsigned int C_DECL_SYMBOL_FLAGS; extern unsigned int TOKEN_TYPE; extern unsigned int DIAG_NAME_BUFFER;
extern unsigned char LANGUAGE_MODE; extern unsigned char TOKEN_PUSHED_BACK; extern unsigned char OPTION_CALLING_CONVENTION; extern unsigned char OPTION_MEMORY_MODEL;
extern signed char OPTION_AUTO_FAR_DATA;
extern unsigned int far pascal BCC_STMT_DECL_NEW(unsigned int);
extern int far pascal IS_BARE_DECLARATOR(unsigned int);
extern unsigned int far pascal BCC_STMT_BIND_TYPE(unsigned int,unsigned int);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);

extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern int far pascal LEX_NEXT_TOKEN(void);
extern unsigned int far pascal ALLOC_ARRAY_SEGMENTS(unsigned int);
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal BYTE_POOL_LENGTH(void);
extern unsigned int far pascal MERGE_DUPLICATE_BYTES(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern void (far pascal *STREAM_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses the declarators of one declaration with storage class kind and
   base type base.  allowed is nonzero at file level (function definitions
   and old-style parameter lists allowed).  For each declarator: a function
   is declared (class 2 or 3; a definition goes to BCC_STMT_MEMBER_NEAR);
   an object gets its class, its segment (linkage: BSS, data, a far
   segment, or 0xFFFF for a communal variable with -Fc, OPTION_COMDEFS)
   and its flag word (_DI: 4 near data, 0x10 far data, 0x20 initialised or
   local, 0x400 pascal naming, 8 register), possibly moved to far data by
   automatic far data (-Ff, FAR_DATA_THRESHOLD).  Then the initializer: a
   static object is written as data by STINIT (char arrays of strings with
   -d, OPTION_MERGE_STRINGS, go to the merged string pool instead), an auto or
   register object is initialised by code (BCC_STMT_FINISH_NEAR); a block
   static without initializer reserves its storage at once.  Returns 1 if
   the declaration ended with ';'. */
static int near pascal BCC_STMT_PARSE_NEXT(unsigned int kind,unsigned int base,unsigned int allowed)
{
    unsigned int type,mode,decl,saved,flags,linkage,result,temporary,output,buffer;
    if(kind==13) {flags=8;kind=5;} else flags=0;
    saved=C_DECL_SYMBOL_FLAGS;
again:
    C_DECL_SYMBOL_FLAGS=saved;
    decl=BCC_STMT_DECL_NEW(allowed);
    _DI=0;
    if(decl==0) return 0;
    if((TOKEN_TYPE==7 || TOKEN_TYPE==8 || TOKEN_TYPE==11) && base==0 && IS_BARE_DECLARATOR(decl)) REPORT_ERROR(MSG_TYPE_NAME_EXPECTED);
    if(base==0) base=PLAIN_INT_TYPE;
    type=BCC_STMT_BIND_TYPE(decl,base);
    mode=kind;
    if(kind==8) {
        if(C_DECL_DISTANCE==9) {_ES=TYPE_POOL;_BX=type;if(ES_B(_BX,TYPE_KIND)!=0x12) _DI=0x10;}
        goto define;
    }
    _ES=TYPE_POOL;_BX=type;
    if(ES_B(_BX,TYPE_KIND)==0x12) {
        if(C_DECL_SCOPE==C_GLOBAL_SCOPE && allowed!=0 && TOKEN_TYPE==5) BCC_STMT_FUNCTION_NEAR();
        _BX=type;_ES=TYPE_POOL;
        if(ES_B(_BX,TYPE_C_FUNC_FLAGS)&1) _DI=0x10;else _DI=4;
        _BX=type;_ES=TYPE_POOL;
        if(ES_B(_BX,TYPE_C_CALL_CONV)==2) flags|=0x400;
        else {_BX=type;_ES=TYPE_POOL;if(ES_B(_BX,TYPE_C_CALL_CONV)==3) flags|=0x2000;}
        if(C_DECL_SCOPE!=C_GLOBAL_SCOPE && allowed!=0) {
            if(LANGUAGE_MODE==1 && base==type) REPORT_ERROR(MSG_FUNCTION_DEFINITION);
            return BCC_STMT_MEMBER_NEAR(kind,type,flags);
        }
        if(kind==3) {
            if(allowed==0) {REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258,(char far *)STR_STATIC);mode=2;_DI=_DI;}
        } else mode=2;
        _SI=DECLARE_SYMBOL(C_DECLARATOR_NAME,C_DECL_SCOPE,0,mode,type,0,flags|_DI);
        if(TOKEN_TYPE==8) {_AX=NEXT();goto again;}
        if(TOKEN_TYPE!=7) {
            DIAG_NAME_BUFFER=0;
            _ES=CSYM_POOL_SEG;REPORT_AND_SKIP(MSG_DECLARATION_SYNTAX,NAME_TEXT_COPY(ES_W(_SI,CSYM_NAME)));
            return 0;
        }
        return 1;
    }
    linkage=BSS_SEGMENT_ID;
    _ES=TYPE_POOL;_BX=type;
    if(ES_B(_BX,TYPE_KIND)==0x13) flags&=0xFFF7;
    switch(mode) {
    case 2:
        if(TOKEN_TYPE!=11) {
            if(C_DECL_CALL_CONVENTION==2) {_DI=_DI;goto language_one;}
            if(C_DECL_CALL_CONVENTION==0 && OPTION_CALLING_CONVENTION==1) {language_one:_DI|=0x400;}
            if(C_DECL_DISTANCE==8) _DI|=4;
            else if(C_DECL_DISTANCE==9 || OPTION_MEMORY_MODEL==5 || DATA_BSS_GROUPS_DIFFER!=0) {_DI|=0x10;linkage=0xFFFF;}
            else _DI|=4;
            break;
        }
        if(allowed==0) {REPORT_AND_SKIP(MSG_EXTERN_VARIABLE_CANNOT,(char far *)0);return 0;}
        mode=1;
    case 1:
        if(C_DECL_CALL_CONVENTION==2) {_DI=_DI;goto language_two;}
        if(C_DECL_CALL_CONVENTION==0 && OPTION_CALLING_CONVENTION==1) {language_two:_DI|=0x400;}
    case 3:
        if(C_DECL_SCOPE!=C_GLOBAL_SCOPE) {_DI|=0x20;mode=4;}
        if(C_DECL_DISTANCE==9) {
            if(OPTION_COMDEFS!=0 && mode==1 && TOKEN_TYPE!=11) linkage=0xFFFF;
            else {
                _ES=TYPE_POOL;_BX=type;
                if(ES_B(_BX,TYPE_KIND)==0x11 && ES_B(_BX,TYPE_C_BYTE9)!=0) _AX=ALLOC_ARRAY_SEGMENTS(type);
                else _AX=DEFINE_FAR_SEGMENT();
                linkage=_AX;
            }
            _DI|=0x10;
        } else if(DATA_BSS_GROUPS_DIFFER!=0 && TOKEN_TYPE!=11) _DI|=0x10;
        else {_DI|=4;if(TOKEN_TYPE==11) linkage=DATA_SEGMENT_ID;}
        if(TOKEN_TYPE==11) _DI|=0x20;
        break;
    case 5:
        if(C_DECL_DISTANCE!=0) REPORT_ERROR(MSG_CONFLICTING_TYPE);
        if(TOKEN_TYPE==11) _DI|=0x24;
        else if(!SIZE_OF_TYPE_CHECKED_HOOK(type)) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(MSG_SIZE_UNKNOWN_ZERO,NAME_TEXT_COPY(C_DECLARATOR_NAME));
        }
        break;
    }
define:
    if(OPTION_AUTO_FAR_DATA!=0 && MODEL_FAR_DATA!=0 && C_DECL_DISTANCE!=8 && !(_DI&0x10)) {
        if(mode==2) {_DI=_DI;goto external;}
        if(TOKEN_TYPE==11 || (!OPTION_COMDEFS && mode==1)) {
            if(SIZE_OF_TYPE_CHECKED_HOOK(type)>=FAR_DATA_THRESHOLD) {
                linkage=DEFINE_FAR_SEGMENT();_DI&=0xFFFB;_DI|=0x10;_DI=_DI;
            }
        } else if(mode==1 && OPTION_COMDEFS!=0) {
external:
            linkage=0xFFFF;_DI&=0xFFFB;_DI|=0x10;
        }
    }
    _SI=DECLARE_SYMBOL(C_DECLARATOR_NAME,C_DECL_SCOPE,0,mode,type,linkage,flags|_DI|C_DECL_SYMBOL_FLAGS);
    if(mode==5 || mode==6) {
        _AX=FIND_OR_ADD_VARIABLE(_SI,(_ES=TYPE_POOL,_BX=type,ES_B(_BX,TYPE_KIND)),(_ES=CSYM_POOL_SEG,ES_B(_SI,CSYM_FLAGS)));
        _ES=CSYM_POOL_SEG;ES_W(_SI,CSYM_VAR_ENTRY)=_AX;
    }
    if(TOKEN_TYPE==11) {
        _AX=NEXT();
        if(mode==1 || mode==4 || mode==3) {
            _ES=CSYM_POOL_SEG;ES_W(_SI,CSYM_FLAGS)&=0xF7FF;
            if(!(ES_W(_SI,CSYM_FLAGS)&1) || OPTION_MERGE_STRINGS==0 || mode==4) goto ordinary_output;
            _BX=ES_W(_SI,CSYM_TYPE);_ES=TYPE_POOL;
            if(ES_B(_BX,TYPE_KIND)!=0x11) goto ordinary_output;
            _ES=CSYM_POOL_SEG;_BX=ES_W(_SI,CSYM_TYPE);_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TARGET);
            if(ES_B(_BX,TYPE_KIND)>2) goto ordinary_output;
            {
                temporary=1;buffer=BYTE_POOL_LENGTH();output=2;
                _ES=CSYM_POOL_SEG;ES_W(_SI,CSYM_SEGMENT)=0;
                goto output_ready;
            }
            {
ordinary_output:
                output=1;
                _ES=CSYM_POOL_SEG;STREAM_HOOK(ES_W(_SI,CSYM_SEGMENT));
                if(BCC_PACK_FLAG) ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK((_ES=CSYM_POOL_SEG,ES_W(_SI,CSYM_TYPE))));
                DEFINE_SYMBOL_HERE_HOOK(_SI);temporary=0;
            }
output_ready:
            result=STINIT((_ES=CSYM_POOL_SEG,ES_W(_SI,CSYM_TYPE)),1,output);
            if(temporary) {_AX=MERGE_DUPLICATE_BYTES(buffer);_ES=CSYM_POOL_SEG;ES_W(_SI,CSYM_OFFSET)=_AX;}
            if(result) {
                _ES=CSYM_POOL_SEG;ES_W(_SI,CSYM_TYPE)=result;
                if(OPTION_AUTO_FAR_DATA!=0 && MODEL_FAR_DATA!=0 && C_DECL_DISTANCE!=8 && !(_DI&0x10) && SIZE_OF_TYPE_CHECKED_HOOK(result)>=FAR_DATA_THRESHOLD) {
                    DIAG_NAME_BUFFER=0;
                    _ES=CSYM_POOL_SEG;REPORT_WARNING(MSG_ARRAY_VARIABLE_NEAR,NAME_TEXT_COPY(ES_W(_SI,CSYM_NAME)));
                }
            }
            _ES=CSYM_POOL_SEG;ES_W(_SI,CSYM_FLAGS)|=0x240;
        } else if(mode==5 || mode==13) BCC_STMT_FINISH_NEAR(_SI);
    } else if(mode==4) {
        _ES=CSYM_POOL_SEG;STREAM_HOOK(ES_W(_SI,CSYM_SEGMENT));
        if(BCC_PACK_FLAG) ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK((_ES=CSYM_POOL_SEG,ES_W(_SI,CSYM_TYPE))));
        DEFINE_SYMBOL_HERE_HOOK(_SI);
        result=SIZE_OF_TYPE_CHECKED_HOOK((_ES=CSYM_POOL_SEG,ES_W(_SI,CSYM_TYPE)));
        if(result==0) {
            DIAG_NAME_BUFFER=0;
            _ES=CSYM_POOL_SEG;REPORT_ERROR(MSG_SIZE_UNKNOWN_ZERO,NAME_TEXT_COPY(ES_W(_SI,CSYM_NAME)));
        } else RESERVE_BYTES_HOOK(result);
    } else if(OPTION_COMDEFS!=0 && mode==1) {
        _ES=CSYM_POOL_SEG;ES_B(_SI,CSYM_CLASS)=2;ES_W(_SI,CSYM_FLAGS)|=0x800;
    }
    if(TOKEN_TYPE==8) {_AX=NEXT();goto again;}
    if(TOKEN_TYPE!=7) {
        DIAG_NAME_BUFFER=0;
        _ES=CSYM_POOL_SEG;REPORT_AND_SKIP(mode==8?MSG_EXPECTED_202:MSG_DECLARATION_SYNTAX,NAME_TEXT_COPY(ES_W(_SI,CSYM_NAME)));
        return 0;
    }
    return 1;
}
#undef NEXT

/* ---- STMEMBER (listing ovr_1cf2_9000:16CB) ---- */
static void near pascal BCC_STMT_END_NEAR(unsigned int record,register unsigned int right,register unsigned int left);
void far pascal STBEGIN(register unsigned int node);
unsigned int far pascal BCC_STMT_COUNT_NEAR(register unsigned int item);
static void near pascal BCC_STMT_FLUSH_NEAR(void);
extern unsigned int CODE_SEGMENT_ID; extern unsigned int DIAG_NAME_BUFFER; extern unsigned int BCC_TREE_SPECIAL; extern unsigned int TOKEN_TYPE; extern unsigned int C_DECL_STORAGE_CLASS; extern unsigned int LOOP_BLOCK_WEIGHT;
extern unsigned char PRAGMA_SAVEREGS_PENDING; extern unsigned char TOKEN_PUSHED_BACK; extern unsigned char OPTION_UNDERSCORES; extern unsigned char RETURN_FORM_SEEN; extern unsigned char PRAGMA_ARGSUSED_PENDING;
extern signed char OPTION_WINDOWS_MODE;
extern char far *FUNCTION_NAME_TEXT;
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal POOL_TRIM(unsigned int far *,unsigned int);
extern unsigned int far pascal INIT_FUNCTION_STATE(unsigned int,unsigned int,unsigned int,unsigned char,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);

extern int far pascal LEX_NEXT_TOKEN(void);
extern unsigned int far pascal NEW_SCOPE_ENTER_BLOCK(unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern int far pascal PARSE_BLOCK_BODY(unsigned int,unsigned int);
extern unsigned int far pascal NEW_SCOPE_EXIT_BLOCK(unsigned int);
extern void far pascal FINISH_FUNCTION_BLOCKS(unsigned int,unsigned int,unsigned int);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Compiles a function definition; binding is the function type, kind its
   storage class, flags its symbol flags.  Declares the function in the
   global scope, sets up the per-function state (INIT_FUNCTION_STATE,
   BCC_TREE_SPECIAL), reads old-style parameter declarations and checks
   them against an earlier prototype, declares the parameters, makes main
   with parameters pull in the start-up helpers _setargv (and _setenvp
   for three), parses the body, reports undefined labels and a missing
   return value, and finishes the function's block chain
   (FINISH_FUNCTION_BLOCKS).  #pragma saveregs applies here. */
static int near pascal BCC_STMT_MEMBER_NEAR(unsigned int kind,unsigned int binding,unsigned int flags)
{
    unsigned int type,parameters,unused;
    int count;
    unsigned int access;
    _DI=binding;
    if(kind==2) kind=1;
    _SI=DECLARE_SYMBOL(C_DECLARATOR_NAME,C_GLOBAL_SCOPE,0,kind,_DI,CODE_SEGMENT_ID,flags|0x24);
    _ES=TYPE_POOL;CURRENT_FUNCTION_TYPE=ES_W(_DI,TYPE_C_TARGET);
    C_FUNC_DEF_SET_ONLY_FLAG=1;
    FUNCTION_NAME_TEXT=STRING_COPY(C_FUNCTION_NAME_BUFFER,(DIAG_NAME_BUFFER=0,_ES=CSYM_POOL_SEG,NAME_TEXT_COPY(ES_W(_SI,CSYM_NAME))));
    access=0;
    if(PRAGMA_SAVEREGS_PENDING) access=0x20;
    PRAGMA_SAVEREGS_PENDING=0;
    POOL_TRIM(&CONTEXT_SEG,100);
    BCC_TREE_SPECIAL=INIT_FUNCTION_STATE(_SI,CURRENT_FUNCTION_TYPE,(_ES=TYPE_POOL,ES_W(_DI,TYPE_C_PARAMS)),ES_B(_DI,TYPE_C_CALL_CONV),ES_B(_DI,TYPE_C_FUNC_FLAGS)|(unsigned char)access,CODE_SEGMENT_ID,C_DECL_SOURCE_FILE,C_DECL_SOURCE_LINE,C_DECL_START_POSITION_HIGH,C_DECL_START_POSITION);
    _ES=TYPE_POOL;
    if(ES_W(_DI,TYPE_C_PARAMS)==0 && C_OLD_STYLE_PARAM_LIST!=0) {
        while(TOKEN_TYPE && TOKEN_TYPE!=5) {
            if(TOKEN_STARTS_TYPE(TOKEN_TYPE)) {
                type=BCC_STMT_BUILD();
                if(type==0) continue;
                if(C_DECL_STORAGE_CLASS==0) C_DECL_STORAGE_CLASS=6;
                else if(C_DECL_STORAGE_CLASS!=13 && C_DECL_STORAGE_CLASS!=8) {
                    REPORT_ERROR(MSG_STORAGE_CLASS_NOT_258,(char far *)STORAGE_CLASS_NAMES[C_DECL_STORAGE_CLASS]);
                    C_DECL_STORAGE_CLASS=6;
                }
                if(TOKEN_TYPE!=7 && !BCC_STMT_CHECK_TYPE_NEAR(C_DECL_STORAGE_CLASS,type)) {
                    C_DECL_SCOPE=C_GLOBAL_SCOPE;CURRENT_SCOPE=GLOBAL_SCOPE;return 0;
                }
            } else {
                REPORT_AND_SKIP(MSG_DECLARATION_WAS,(char far *)0);
                if(TOKEN_TYPE==6) {TOKEN_PUSHED_BACK=1;break;}
            }
            _AX=NEXT();
        }
        STBEGIN(parameters=C_OLD_STYLE_PARAM_LIST);
        _ES=TYPE_POOL;unused=ES_W(_DI,TYPE_C_PARAMS);
        _ES=CSYM_POOL_SEG;_BX=ES_W(_SI,CSYM_TYPE);_ES=TYPE_POOL;
        if((ES_B(_BX,TYPE_C_FUNC_FLAGS)&8)==0) {
            BCC_STMT_END_NEAR(_SI,(_ES=CSYM_POOL_SEG,_BX=ES_W(_SI,CSYM_TYPE),_ES=TYPE_POOL,ES_W(_BX,TYPE_C_PARAMS)),parameters);
        }
    } else {_ES=TYPE_POOL;parameters=ES_W(_DI,TYPE_C_PARAMS);}
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,STMT_SCOPE_BLOCK=NEW_SCOPE_ENTER_BLOCK(C_FUNCTION_SCOPE,0),LOOP_BLOCK_WEIGHT);
    count=BCC_STMT_COUNT_NEAR(parameters);
    _ES=CSYM_POOL_SEG;
    if(ES_W(_SI,CSYM_NAME)==MAIN_SYMBOL && !OPTION_WINDOWS_MODE && count>0) {
        DECLARE_NAMED_GLOBAL_HOOK(OPTION_UNDERSCORES?STR_SETARGV:STR_SETARGV_2,0);
        if(count>=3) DECLARE_NAMED_GLOBAL_HOOK(OPTION_UNDERSCORES?STR_SETENVP:STR_SETENVP_2,0);
    }
    C_CURRENT_FUNCTION_SYMBOL=_SI;
    count=PARSE_BLOCK_BODY(1,1);
    C_CURRENT_FUNCTION_SYMBOL=0;
    C_DECL_SCOPE=C_GLOBAL_SCOPE;CURRENT_SCOPE=GLOBAL_SCOPE;
    BCC_STMT_FLUSH_NEAR();
    if(count) {
        _ES=TYPE_POOL;_BX=CURRENT_FUNCTION_TYPE;
        if(ES_B(_BX,TYPE_KIND)!=12) REPORT_WARNING(MSG_FUNCTION_SHOULD_RETURN_367);
        else if(RETURN_FORM_SEEN==2) REPORT_WARNING(MSG_BOTH_RETURN_RETURN);
    }
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,NEW_SCOPE_EXIT_BLOCK(STMT_SCOPE_BLOCK),LOOP_BLOCK_WEIGHT);
    LOGICAL_LINE=CURRENT_LINE;
    FINISH_FUNCTION_BLOCKS(BCC_TREE_SPECIAL,TOKEN_FILE_NODE,TOKEN_LINE);
    FUNCTION_NAME_TEXT=0;
    C_FUNC_DEF_SET_ONLY_FLAG=1;PRAGMA_ARGSUSED_PENDING=0;
    return 1;
}
#undef NEXT

/* ---- STEND (listing ovr_1cf2_9000:19D1) ---- */
extern unsigned int DIAG_NAME_BUFFER;
extern unsigned char LANGUAGE_MODE;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern int far pascal TYPE_RECORDS_COMPATIBLE(unsigned int,unsigned int,unsigned char);
extern char far *far pascal NAME_TEXT_COPY(unsigned int);
/* Checks old-style parameter types left (after the default promotions:
   float to double, small integers by INTEGRAL_PROMOTION_KIND) against the
   prototype parameter list right of function record, then the counts:
   with function flag 4 (the prototype ends in "...") only leftover
   prototype parameters are an error, otherwise any difference is. */
static void near pascal BCC_STMT_END_NEAR(unsigned int record,register unsigned int right,register unsigned int left)
{
    unsigned int size,type,expected;
    while(left && right) {
        type=CPARM_W(left,CPARM_TYPE);
        if(TYPE_B(type,TYPE_KIND)==9) size=10;
        else size=INTEGRAL_PROMOTION_KIND[TYPE_B(type,TYPE_KIND)];
        if(size) {
            expected=MODE_HOOK(size);
            if(!TYPE_RECORDS_COMPATIBLE(expected,CPARM_W(right,CPARM_TYPE),0)) {
                if(LANGUAGE_MODE==1 || TYPE_B(type,TYPE_KIND)==9) {
                    DIAG_NAME_BUFFER=0;
                    REPORT_ERROR(MSG_TYPE_MISMATCH_80,NAME_TEXT_COPY(CPARM_W(left,CPARM_NAME)));
                }
            }
        } else {
            if(!TYPE_RECORDS_COMPATIBLE(type,CPARM_W(right,CPARM_TYPE),0)) {
                DIAG_NAME_BUFFER=0;
                REPORT_ERROR(MSG_TYPE_MISMATCH_80,NAME_TEXT_COPY(CPARM_W(left,CPARM_NAME)));
            }
        }
        left=CPARM_W(left,CPARM_NEXT);
        right=CPARM_W(right,CPARM_NEXT);
    }
    if(TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_C_FUNC_FLAGS)&4) {
        if(right) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
        }
    } else if(left || right) {
        DIAG_NAME_BUFFER=0;
        REPORT_ERROR(MSG_TYPE_MISMATCH,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
    }
}

/* ---- STCTYPE (listing ovr_1cf2_9000:1B3B) ---- */
void far pascal BCC_STMT_BIND_FIELD(unsigned int field,unsigned int name,unsigned int flags,unsigned int type);
extern unsigned int C_DECL_SYMBOL_FLAGS; extern unsigned int TOKEN_TYPE;
extern unsigned char TOKEN_PUSHED_BACK;
extern unsigned int far pascal BCC_STMT_DECL_NEW(unsigned int);
extern unsigned int far pascal BCC_STMT_BIND_TYPE(unsigned int,unsigned int);
extern unsigned int far pascal PTR_TYPE_FOR_MODIFIER(unsigned int,unsigned char,unsigned int,unsigned char);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern int far pascal LEX_NEXT_TOKEN(void);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses the declarators of one old-style parameter declaration ("int a,
   *b;") and gives each named parameter its type (functions become
   pointers); a typedef here (kind 8) is declared globally instead.
   Returns 0 after a syntax error. */
static unsigned int near pascal BCC_STMT_CHECK_TYPE_NEAR(register unsigned int kind,unsigned int type)
{
    unsigned int declaration,saved;
    register unsigned int bound;
    saved=C_DECL_SYMBOL_FLAGS;
    for(;;) {
        C_DECL_SYMBOL_FLAGS=saved;
        declaration=BCC_STMT_DECL_NEW(0);
        if(!declaration) return 0;
        bound=BCC_STMT_BIND_TYPE(declaration,type);
        _ES=TYPE_POOL;
        if(ES_B(bound,TYPE_KIND)==18) bound=PTR_TYPE_FOR_MODIFIER(bound,0,0,0);
        if(kind==8) DECLARE_SYMBOL(C_DECLARATOR_NAME,C_GLOBAL_SCOPE,0,kind,bound,0,0);
        else BCC_STMT_BIND_FIELD(C_OLD_STYLE_PARAM_LIST,C_DECLARATOR_NAME,kind,bound);
        if(TOKEN_TYPE==8) _AX=NEXT();
        else break;
    }
    if(TOKEN_TYPE!=7) {
        REPORT_AND_SKIP(MSG_EXPECTED_202,(char far *)0);
        return 0;
    }
    return 1;
}
#undef NEXT

/* ---- STFUNC (listing ovr_1cf2_9000:1C05) ---- */
extern unsigned int SCOPE_POOL_SEG;
extern unsigned int BCC_TREE_SPECIAL;
/* Begins a function's parameter scope: clears the per-function state and
   makes C_FUNCTION_SCOPE (emptied) the current scope.  An old-style
   parameter list inside a block is an error. */
void far pascal BCC_STMT_FUNCTION_NEAR(void)
{
    if(C_DECL_SCOPE!=C_GLOBAL_SCOPE) REPORT_ERROR(MSG_PARAMETER_NAMES_ARE);
    else {
        RTL_MEMSET(&BCC_TREE_SPECIAL,0,9);
        C_FUNC_START_CLEARED_WORD=0;
        C_DECL_SCOPE=C_FUNCTION_SCOPE;
        CURRENT_SCOPE=C_FUNCTION_SCOPE;
        RTL_MEMSET(MK_FP(SCOPE_POOL_SEG,C_FUNCTION_SCOPE),0,8);
        C_OLD_STYLE_PARAM_LIST=0;
    }
}

/* ---- STFIELD (listing ovr_1cf2_9000:1C5D) ---- */
extern unsigned int DIAG_NAME_BUFFER;
extern unsigned int far pascal PTR_TYPE_FOR_MODIFIER(unsigned int,unsigned char,unsigned int,unsigned char);
extern char far *far pascal NAME_TEXT_COPY(unsigned int);
/* Sets the type of parameter name in the old-style list field (arrays and
   functions become pointers; flag 8, register, marks it 0xFE).  A name not
   in the list, or declared twice, is an error. */
void far pascal BCC_STMT_BIND_FIELD(unsigned int field,unsigned int name,unsigned int flags,unsigned int type)
{
    _DI=type;
    _SI=field;
    while(_SI) {
        _ES=C_PARAM_POOL_SEG;
        if(ES_W(_SI,CPARM_NAME)==name) {
            if(ES_W(_SI,CPARM_TYPE)) {
                BCC_STMT_CHECK_NEAR(name);
                return;
            }
            if(_DI) {
                _ES=TYPE_POOL;
                if(ES_B(_DI,TYPE_KIND)==0x11)
                    _DI=PTR_TYPE_FOR_MODIFIER(ES_W(_DI,TYPE_TARGET),0,0,0);
                else {
                    _ES=TYPE_POOL;
                    if(ES_B(_DI,TYPE_KIND)==0x12)
                        _DI=PTR_TYPE_FOR_MODIFIER(_DI,0,0,0);
                }
            }
            _ES=C_PARAM_POOL_SEG;
            ES_W(_SI,CPARM_TYPE)=_DI;
            if(flags&8) ES_B(_SI,CPARM_REG_MARK)=0xFE;
            return;
        }
        _ES=C_PARAM_POOL_SEG;
        _SI=ES_W(_SI,CPARM_NEXT);
    }
    DIAG_NAME_BUFFER=0;
    REPORT_ERROR(MSG_NOT_PARAMETER,NAME_TEXT_COPY(name));
}

/* ---- STBEGIN (listing ovr_1cf2_9000:1CF8) ---- */
/* Gives every old-style parameter that was never declared the type int. */
void far pascal STBEGIN(register unsigned int node)
{
    while(node!=0) {
        if(CPARM_W(node,CPARM_TYPE)==0) CPARM_W(node,CPARM_TYPE)=PLAIN_INT_TYPE;
        node=CPARM_W(node,CPARM_NEXT);
    }
}

/* ---- STADD (listing ovr_1cf2_9000:1D24) ---- */
extern unsigned int far pascal POOL_ALLOC_REUSE(char far *,unsigned int);
extern unsigned int far pascal PTR_TYPE_FOR_MODIFIER(unsigned int,unsigned char,unsigned int,unsigned char);
/* Appends a parameter (name, type adjusted as for BCC_STMT_BIND_FIELD,
   register mark 0xFE if flags has 8, else 0xFF) to the C_PARAM_POOL_SEG
   list head and returns the list.  A repeated name is reported. */
unsigned int far pascal BCC_STMT_ADD_FIELD(unsigned int head,unsigned int name,unsigned int type,unsigned int flags)
{
    if(name) {
        _SI=head;
        while(_SI) {
            _ES=C_PARAM_POOL_SEG;
            if(ES_W(_SI,CPARM_NAME)==name) {
                BCC_STMT_CHECK_NEAR(name);
                return _SI;
            }
            _ES=C_PARAM_POOL_SEG;
            _SI=ES_W(_SI,CPARM_NEXT);
        }
    }
    _SI=POOL_ALLOC_REUSE((char far *)&C_PARAM_POOL_SEG,8);
    if(head) {
        _DI=head;
        _ES=C_PARAM_POOL_SEG;
        while(ES_W(_DI,CPARM_NEXT)) {
            _ES=C_PARAM_POOL_SEG;
            _DI=ES_W(_DI,CPARM_NEXT);
            _ES=C_PARAM_POOL_SEG;
        }
        ES_W(_DI,CPARM_NEXT)=_SI;
    } else head=_SI;
    _AL=(flags&8)?0xFE:0xFF;
    _ES=C_PARAM_POOL_SEG;
    ES_B(_SI,CPARM_REG_MARK)=_AL;
    ES_B(_SI,CPARM_BYTE1)=0xFF;
    ES_W(_SI,CPARM_NEXT)=0;
    ES_W(_SI,CPARM_NAME)=name;
    if(type) {
        _ES=TYPE_POOL;
        if(ES_B(type,TYPE_KIND)==0x11)
            type=PTR_TYPE_FOR_MODIFIER(ES_W(type,TYPE_TARGET),0,0,0);
        else {
            _ES=TYPE_POOL;
            if(ES_B(type,TYPE_KIND)==0x12)
                type=PTR_TYPE_FOR_MODIFIER(type,0,0,0);
        }
    }
    _ES=C_PARAM_POOL_SEG;
    ES_W(_SI,CPARM_TYPE)=type;
    return head;
}

/* ---- STCOUNT (listing ovr_1cf2_9000:1E03) ---- */
extern unsigned int far pascal NEW_POINTER_TYPE(unsigned int,unsigned char,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int,unsigned char,unsigned char);
/* Declares the parameters in list item as class 6 symbols of the current
   function (flag 64, plus 8 for register) with their variable entries,
   and returns their count.  A function returning a struct not of size 1,
   2 or 4 first gets the hidden parameter STRUCT_RETURN_PARAM, a far
   pointer to the result.  A parameter without a name is an error. */
unsigned int far pascal BCC_STMT_COUNT_NEAR(register unsigned int item)
{
    int count;
    unsigned int type;
    register unsigned int record;
    if(TYPE_B(CURRENT_FUNCTION_TYPE,TYPE_KIND)==19) {
        count=TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_MEMBER_CLASS);
        if(count!=1 && count!=2 && count!=4) {
            type=NEW_POINTER_TYPE(CURRENT_FUNCTION_TYPE,15,0,0,0);
            STRUCT_RETURN_PARAM=DECLARE_SYMBOL(0,C_DECL_SCOPE,0,6,type,0,64);
            CSYM_W(STRUCT_RETURN_PARAM,CSYM_VAR_ENTRY)=FIND_OR_ADD_VARIABLE(STRUCT_RETURN_PARAM,15,0);
        }
    }
    count=1;
    while(item) {
        if(!CPARM_W(item,CPARM_NAME)) REPORT_ERROR(MSG_PARAMETER_D_MISSING,(long)count);
        record=DECLARE_SYMBOL(CPARM_W(item,CPARM_NAME),C_DECL_SCOPE,0,6,CPARM_W(item,CPARM_TYPE),0,CPARM_B(item,CPARM_REG_MARK)==254 ? 72 : 64);
        CSYM_W(record,CSYM_VAR_ENTRY)=FIND_OR_ADD_VARIABLE(record,TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_KIND),CSYM_B(record,CSYM_FLAGS));
        item=CPARM_W(item,CPARM_NEXT);
        count++;
    }
    return count-1;
}

/* ---- LG0BC (listing ovr_1cf2_9000:1F1E) ---- */
extern unsigned int DIAG_NAME_BUFFER;
extern char far * far pascal NAME_TEXT_COPY(unsigned int);

/* Reports "multiple declaration" of name. */
static void near pascal BCC_STMT_CHECK_NEAR(unsigned int name)
{
    DIAG_NAME_BUFFER=0;
    REPORT_ERROR(MSG_MULTIPLE_DECLARATION,NAME_TEXT_COPY(name));
}

/* ---- STFLUSH (listing ovr_1cf2_9000:1F43) ---- */
#pragma option -G- -k-   /* STFLUSH was compiled without -G and with -k- */
extern unsigned int SCOPE_POOL_SEG; extern unsigned int DIAG_NAME_BUFFER;
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
/* At the end of a function: reports every label used by goto but never
   defined (labels are name-space 1 in C_FUNCTION_SCOPE; flag 0x40 =
   defined). */
static void near pascal BCC_STMT_FLUSH_NEAR(void)
{
    register unsigned int record;
    record=SCOPE_W(C_FUNCTION_SCOPE,SCOPE_C_SYMBOLS);
    while(record) {
        if(CSYM_B(record,CSYM_NAMESPACE)==1 && !(CSYM_W(record,CSYM_FLAGS)&0x40)) {
            DIAG_NAME_BUFFER=0;
            REPORT_ERROR(MSG_UNDEFINED_LABEL,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
        }
        record=CSYM_W(record,CSYM_NEXT);
    }
}

#pragma option -G -k
/* ---- STINIT (listing ovr_1cf2_9000:1F8F) ---- */
static unsigned int near pascal BCC_STMT_BITFIELD_NEAR(unsigned int member);
static void near pascal BCC_STMT_OUTPUT_NEAR(unsigned char value);
extern unsigned int TOKEN_TYPE;
extern unsigned char  TOKEN_PUSHED_BACK;
extern int far pascal LEX_NEXT_TOKEN(void);

extern void far pascal BCC_LEX_RESTORE(unsigned int);
extern void far pascal EMIT_VALUE(unsigned char);
extern unsigned int far pascal NEW_ARRAY_TYPE(unsigned long,unsigned int,unsigned int);
extern void far pascal RESERVE_ARRAY_REMAINDER(unsigned int,unsigned int);
extern void far pascal ADVANCE_IF_SEGMENT_FULL(void);
extern unsigned int far pascal PARSE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal STASSIGN(unsigned int,unsigned int);
extern void far pascal MARK_SYMBOLS_REFERENCED(unsigned int);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);
extern void far pascal EMIT_INITIALIZER_VALUE_FAR(unsigned int,unsigned int);
extern void (far pascal *BYTE_HOOK)(unsigned char);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
#define FAIL(n) {REPORT_AND_SKIP(n,(char far *)0);return 0;}
/* Parses a static initializer for an object of type and writes it as data
   bytes.  fixed is nonzero at the top level (an unsized array may get its
   size from the initializer; the new array type is returned); mode is the
   output: 1 the current segment through BYTE_HOOK, 2 the data byte pool
   (merged strings).  Arrays: from string literals (char arrays) or from
   elements, braces optional for inner levels; the rest of a sized array is
   reserved.  Structs and unions: members in order, bitfields collected
   in BITFIELD_INIT_BITS and written byte by byte, alignment padding when
   packing; a union takes its first member.  Scalars: an expression folded
   and written by EMIT_INITIALIZER_VALUE_FAR.  Returns the type, or 0
   after an error (already reported and skipped). */
unsigned int far pascal STINIT(unsigned int type,unsigned int fixed,unsigned int mode)
{
    unsigned int node;
    int alignment;
    unsigned int braces,limit,initialized;
    if(TOKEN_TYPE==5) {braces=1;initialized=0;_AX=NEXT();}
    else braces=0;
    TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
    _ES=TYPE_POOL;_BX=type;
    switch(ES_B(_BX,TYPE_KIND)) {
    case 0x11:
        _BX=type;_ES=TYPE_POOL;
        if(ES_L(_BX,TYPE_C_SIZE)==0L) limit=0xFFFF;
        else {_BX=type;_ES=TYPE_POOL;limit=ES_W(_BX,TYPE_C_SIZE);}
        _BX=type;_ES=TYPE_POOL;_BX=ES_W(_BX,TYPE_TARGET);
        if(ES_B(_BX,TYPE_KIND)<=2 && TOKEN_TYPE==0x34) {
            _SI=0;
            do {BCC_LEX_RESTORE(mode);_SI+=(unsigned int)TOKEN_CONST_VALUE;_AX=NEXT();} while(_AX==0x34);
            initialized=1;
            _BX=type;_ES=TYPE_POOL;
            if(ES_L(_BX,TYPE_C_SIZE)==0L) {
                if(mode==1) BYTE_HOOK(0);else EMIT_VALUE(0);
                ++_SI;
            } else if(mode==2) {
                while((long)_SI<(*((long far *)MK_FP(TYPE_POOL,type+TYPE_MEMBER_CLASS)))) {++_SI;EMIT_VALUE(0);}
            }
            if(_SI>limit) {REPORT_ERROR(MSG_TOO_MANY_INITIALIZERS);limit=0xFFFF;}
            if(braces) {
                if(TOKEN_TYPE!=6) FAIL(0xE6);
                _AX=NEXT();_AX=_AX;
            }
            goto array_done;
        }
        if(braces==0) {
            if(fixed) FAIL(0xD8);
            initialized=1;_SI=0;
            while(_SI<limit) {
                if(!STINIT((_BX=type,_ES=TYPE_POOL,ES_W(_BX,TYPE_TARGET)),0,mode)) return 0;
                if(TOKEN_TYPE!=8 && TOKEN_TYPE!=7 && TOKEN_TYPE!=6) FAIL(0xCA);
                ++_SI;
                _BX=type;_ES=TYPE_POOL;if(ES_B(_BX,TYPE_C_BYTE9)) ADVANCE_IF_SEGMENT_FULL();
                if(TOKEN_TYPE==8 && _SI<limit) _AX=NEXT();
                if(TOKEN_TYPE==6 || TOKEN_TYPE==7) goto array_done;
            }
            goto array_done;
        } else {
            _SI=0;
            while(TOKEN_TYPE!=6) {
                if(_SI>=limit) {REPORT_ERROR(MSG_TOO_MANY_INITIALIZERS);limit=0xFFFF;}
                initialized=1;
                if(!STINIT((_BX=type,_ES=TYPE_POOL,ES_W(_BX,TYPE_TARGET)),0,mode)) return 0;
                if(TOKEN_TYPE!=8 && TOKEN_TYPE!=6) FAIL(0xCA);
                _BX=type;_ES=TYPE_POOL;if(ES_B(_BX,TYPE_C_BYTE9)) ADVANCE_IF_SEGMENT_FULL();
                if(TOKEN_TYPE==8) _AX=NEXT();
                ++_SI;
            }
            _AX=NEXT();
        }
array_done:
        if(initialized==0) REPORT_ERROR(MSG_EXPRESSION_EXPECTED);
        _BX=type;_ES=TYPE_POOL;
        if(ES_L(_BX,TYPE_C_SIZE)==0L) {
            if(fixed==0) REPORT_ERROR(MSG_SIZE_TYPE_UNKNOWN_ZERO);
            else type=NEW_ARRAY_TYPE((unsigned long)_SI,(_BX=type,_ES=TYPE_POOL,ES_W(_BX,TYPE_TARGET)),0);
            TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
            break;
        }
        _BX=type;_ES=TYPE_POOL;
        if(ES_L(_BX,TYPE_C_SIZE)>(long)_SI) {
            _BX=type;_ES=TYPE_POOL;
            if(ES_B(_BX,TYPE_C_BYTE9)) RESERVE_ARRAY_REMAINDER(type,_SI);
            else {
                _BX=type;_ES=TYPE_POOL;
                RESERVE_BYTES_HOOK((unsigned int)(((*((long far *)MK_FP(TYPE_POOL,type+TYPE_MEMBER_CLASS)))-(long)_SI)*(unsigned long)SIZE_OF_TYPE_CHECKED_HOOK(ES_W(_BX,TYPE_TARGET))));
            }
        }
        break;
    case 0x13:
        _BX=type;_ES=TYPE_POOL;_DI=ES_W(_BX,TYPE_C_MEMBERS);
        BITFIELD_INIT_BITS=0;BITFIELD_INIT_PENDING=0;
        if(ES_B(_BX,TYPE_C_BYTE9)==2) {
            _ES=MEMBER_SEGMENT;
            if(ES_B(_DI,MEMB_C_BIT_WIDTH)) {if(!BCC_STMT_BITFIELD_NEAR(_DI)) return 0;}
            else if(!STINIT((_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_C_TYPE)),0,mode)) return 0;
            initialized=1;
            if(TOKEN_TYPE!=8 && TOKEN_TYPE!=7 && TOKEN_TYPE!=6) FAIL(0xCA);
            _ES=MEMBER_SEGMENT;_SI=SIZE_OF_TYPE_CHECKED_HOOK(ES_W(_DI,MEMB_C_TYPE));
            if(braces) {
                if(TOKEN_TYPE!=6) FAIL(0xE6);
                _AX=NEXT();_AX=_AX;
            }
            goto struct_done;
        }
        if(braces==0) {
            if(fixed) FAIL(0xD8);
            initialized=1;_SI=0;
            while(_DI) {
                if(BITFIELD_INIT_PENDING) {
                    while((_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_FLAGS))!=BITFIELD_INIT_OFFSET) {
                        BCC_STMT_OUTPUT_NEAR((unsigned char)BITFIELD_INIT_BITS);BITFIELD_INIT_BITS>>=8;++BITFIELD_INIT_OFFSET;++_SI;
                    }
                    if(BITFIELD_INIT_BITS==0) BITFIELD_INIT_PENDING=0;
                }
                _ES=MEMBER_SEGMENT;alignment=TYPE_ALIGNMENT_HOOK(ES_W(_DI,MEMB_C_TYPE));
                if(BCC_PACK_FLAG && alignment>1 && _SI%alignment) {ALIGN_OUTPUT_HOOK(alignment);_SI+=alignment-_SI%alignment;}
                _ES=MEMBER_SEGMENT;
                if(ES_B(_DI,MEMB_C_BIT_WIDTH)) {if(!BCC_STMT_BITFIELD_NEAR(_DI)) return 0;}
                else if(!STINIT((_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_C_TYPE)),0,mode)) return 0;
                if(TOKEN_TYPE!=8 && TOKEN_TYPE!=7 && TOKEN_TYPE!=6) FAIL(0xCA);
                if(BITFIELD_INIT_PENDING==0) {_ES=MEMBER_SEGMENT;_SI+=SIZE_OF_TYPE_CHECKED_HOOK(ES_W(_DI,MEMB_C_TYPE));}
                if(TOKEN_TYPE==8 && (_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_NEXT))) _AX=NEXT();
                if(TOKEN_TYPE==7 || TOKEN_TYPE==6) goto struct_done;
                _ES=MEMBER_SEGMENT;_DI=ES_W(_DI,MEMB_NEXT);
            }
            goto struct_done;
        } else {
            _SI=0;
            while(TOKEN_TYPE!=6 && _DI) {
                initialized=1;
                if(BITFIELD_INIT_PENDING) {
                    while((_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_FLAGS))>BITFIELD_INIT_OFFSET) {
                        BCC_STMT_OUTPUT_NEAR((unsigned char)BITFIELD_INIT_BITS);BITFIELD_INIT_BITS>>=8;++BITFIELD_INIT_OFFSET;++_SI;
                    }
                    if(BITFIELD_INIT_BITS==0) BITFIELD_INIT_PENDING=0;
                }
                _ES=MEMBER_SEGMENT;alignment=TYPE_ALIGNMENT_HOOK(ES_W(_DI,MEMB_C_TYPE));
                if(BCC_PACK_FLAG && alignment>1 && _SI%alignment) {ALIGN_OUTPUT_HOOK(alignment);_SI+=alignment-_SI%alignment;}
                _ES=MEMBER_SEGMENT;
                if(ES_B(_DI,MEMB_C_BIT_WIDTH)) {if(!BCC_STMT_BITFIELD_NEAR(_DI)) return 0;}
                else if(!STINIT((_ES=MEMBER_SEGMENT,ES_W(_DI,MEMB_C_TYPE)),0,mode)) return 0;
                if(TOKEN_TYPE!=8 && TOKEN_TYPE!=6) FAIL(0xCA);
                if(TOKEN_TYPE==8) _AX=NEXT();
                if(BITFIELD_INIT_PENDING==0) {_ES=MEMBER_SEGMENT;_SI+=SIZE_OF_TYPE_CHECKED_HOOK(ES_W(_DI,MEMB_C_TYPE));}
                _ES=MEMBER_SEGMENT;_DI=ES_W(_DI,MEMB_NEXT);
            }
            if(TOKEN_TYPE!=6) FAIL(0x46);
            _AX=NEXT();
        }
struct_done:
        if(initialized==0) REPORT_ERROR(MSG_EXPRESSION_EXPECTED);
        if(BITFIELD_INIT_PENDING) {
            while(BITFIELD_INIT_BITS) {BCC_STMT_OUTPUT_NEAR((unsigned char)BITFIELD_INIT_BITS);BITFIELD_INIT_BITS>>=8;++_SI;}
            BITFIELD_INIT_PENDING=0;
        }
        _BX=type;_ES=TYPE_POOL;
        if(ES_W(_BX,TYPE_C_SIZE)>_SI) RESERVE_BYTES_HOOK(ES_W(_BX,TYPE_C_SIZE)-_SI);
        break;
    case 0x0C:case 0x12:
        REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);break;
    default:
        node=PARSE_EXPRESSION(0,2);if(node==0) return 0;
        node=STASSIGN(node,type);MARK_SYMBOLS_REFERENCED(node);node=FOLD_EXPRESSION(node);
        EMIT_INITIALIZER_VALUE_FAR(node,mode&2);
        TYPE_POOL_WORD6=0;TYPE_POOL_LENGTH=TYPE_POOL_LENGTH_MARK;
        if(braces) {
            if(TOKEN_TYPE!=6) FAIL(0xE6);
            _AX=NEXT();
        }
        break;
    }
    return type;
}
#undef NEXT
#undef FAIL

/* ---- STBITS (listing ovr_1cf2_9000:27CA) ---- */
extern unsigned int TOKEN_TYPE; extern unsigned int EXPR_POOL_SEG;
extern unsigned char TOKEN_PUSHED_BACK;
extern int far pascal LEX_NEXT_TOKEN(void);
extern unsigned int far pascal PARSE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal STASSIGN(unsigned int,unsigned int);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);

#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Parses the constant value of bitfield member and adds it, masked to its
   width and shifted to its bit position, into BITFIELD_INIT_BITS (the
   bitfield's byte offset goes to BITFIELD_INIT_OFFSET). */
static unsigned int near pascal BCC_STMT_BITFIELD_NEAR(unsigned int member)
{
    unsigned int braces,value;
    _SI=member;
    if(TOKEN_TYPE==5) {braces=1;_AX=NEXT();}
    else braces=0;
    _DI=PARSE_EXPRESSION(0,2);
    if(_DI==0) return 0;
    _DI=FOLD_EXPRESSION(STASSIGN(_DI,(_ES=MEMBER_SEGMENT,ES_W(_SI,MEMB_C_TYPE))));
    if(BITFIELD_INIT_PENDING==0) BITFIELD_INIT_BITS=0;
    BITFIELD_INIT_PENDING=1;
    _ES=EXPR_POOL_SEG;
    if(ES_W(_DI,EXPR_OP)!=2) REPORT_ERROR(MSG_ILLEGAL_INITIALIZATION);
    _ES=MEMBER_SEGMENT;
    value=((1<<ES_B(_SI,MEMB_C_BIT_WIDTH))-1)&(_ES=EXPR_POOL_SEG,ES_W(_DI,EXPR_LEFT));
    _ES=MEMBER_SEGMENT;
    BITFIELD_INIT_BITS+=value<<ES_B(_SI,MEMB_VALUE);
    BITFIELD_INIT_OFFSET=ES_W(_SI,MEMB_FLAGS);
    if(braces) {
        if(TOKEN_TYPE!=6) {REPORT_AND_SKIP(MSG_EXPECTED_230,(char far *)0);return 0;}
        _AX=NEXT();
    }
    return 1;
}
#undef NEXT

/* ---- STOUT (listing ovr_1cf2_9000:28C6) ---- */
extern void (far pascal *STREAM_HOOK)(unsigned int);
extern void (far pascal *BYTE_HOOK)(unsigned char);
/* Writes one byte of initialised data to the data segment. */
static void near pascal BCC_STMT_OUTPUT_NEAR(unsigned char value)
{
    STREAM_HOOK(DATA_SEGMENT_ID);
    BYTE_HOOK(value);
}

/* ---- STFIN (listing ovr_1cf2_9000:28DF) ---- */
static unsigned int near pascal BCC_STMT_CONVERT_NEAR(register unsigned int left,unsigned int right);
extern unsigned int TOKEN_TYPE; extern unsigned int LOOP_BLOCK_WEIGHT; extern unsigned int BCC_TREE_SPECIAL;
extern unsigned char TOKEN_PUSHED_BACK;
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal PARSE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal FOLD_EXPRESSION(unsigned int);
extern void far pascal MARK_SYMBOLS_REFERENCED(unsigned int);
extern unsigned int far pascal NEW_EXPRESSION_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int,unsigned int,unsigned int);
extern int far pascal LEX_NEXT_TOKEN(void);
extern void (far pascal *STREAM_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_SYMBOL_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int,unsigned long);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
#define NEXT() (TOKEN_PUSHED_BACK ? (TOKEN_PUSHED_BACK=0,TOKEN_TYPE) : LEX_NEXT_TOKEN())
/* Initialises the local (auto or register) variable record.  An array or
   struct with a brace or string initializer is built as an unnamed static
   copy in the data segment and copied in at run time ("record = copy",
   with a size for arrays); anything else becomes the assignment
   "record = value".  Either way an expression block is appended to the
   function. */
static void near pascal BCC_STMT_FINISH_NEAR(unsigned int record)
{
    unsigned int node,result,oldlow,oldhigh,temporary;
    TYPE_POOL_LENGTH_MARK=TYPE_POOL_LENGTH;
    _BX=record;_ES=CSYM_POOL_SEG;_SI=ES_W(_BX,CSYM_TYPE);
    oldlow=TOKEN_FILE_NODE;oldhigh=TOKEN_LINE;
    if(TOKEN_TYPE!=5 && TOKEN_TYPE!=0x34) goto ordinary;
    _ES=TYPE_POOL;
    if(ES_B(_SI,TYPE_KIND)!=0x11 && ES_B(_SI,TYPE_KIND)!=0x13) goto ordinary;
    {
        STREAM_HOOK(DATA_SEGMENT_ID);
        if(BCC_PACK_FLAG) ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK(_SI));
        temporary=DECLARE_SYMBOL(0,C_FUNCTION_SCOPE,0,4,_SI,0,0);
        DEFINE_SYMBOL_HERE_HOOK(temporary);
        _SI=STINIT(_SI,1,1);
        if(_SI) {_BX=record;_ES=CSYM_POOL_SEG;ES_W(_BX,CSYM_TYPE)=_SI;}
        else {_BX=record;_ES=CSYM_POOL_SEG;_SI=ES_W(_BX,CSYM_TYPE);}
        _BX=record;_ES=CSYM_POOL_SEG;ES_W(_BX,CSYM_FLAGS)|=0x260;
        _DI=NEW_SYMBOL_NODE_HOOK(1,_SI,temporary,0,0);
        node=NEW_SYMBOL_NODE_HOOK(5,_SI,record,0,0);
        _DI=NEW_EXPR_NODE_HOOK(0x12,_SI,node,_DI);
        _ES=TYPE_POOL;
        if(ES_B(_SI,TYPE_KIND)==0x11) {
            node=NEW_CONST_NODE_HOOK(PLAIN_INT_TYPE,(unsigned long)SIZE_OF_TYPE_CHECKED_HOOK(_SI));
            _DI=NEW_EXPR_NODE_HOOK(0x34,_SI,_DI,node);
        }
        result=NEW_EXPRESSION_BLOCK(_DI,0,0,0,0);
    } 
    goto emitted;
ordinary:
    {
        if(TOKEN_TYPE==5) {
            _AX=NEXT();
            _DI=PARSE_EXPRESSION(0,2);
            if(TOKEN_TYPE!=6) REPORT_AND_SKIP(MSG_EXPECTED_230,(char far *)0);
            else _AX=NEXT();
        } else _DI=PARSE_EXPRESSION(0,2);
        _ES=TYPE_POOL;
        if(ES_B(_SI,TYPE_KIND)==0x15) {
            if(ES_W(_SI,TYPE_C_SIZE)==1) _SI=MODE_HOOK(1);
            else _SI=PLAIN_INT_TYPE;
        }
        node=NEW_SYMBOL_NODE_HOOK(5,_SI,record,0,(_BX=record,_ES=CSYM_POOL_SEG,ES_W(_BX,CSYM_FLAGS)));
        _DI=FOLD_EXPRESSION(_DI);
        _DI=BCC_STMT_CONVERT_NEAR(node,_DI);
        MARK_SYMBOLS_REFERENCED(_DI);
        result=NEW_EXPRESSION_BLOCK(_DI,oldlow,oldhigh,TOKEN_FILE_NODE,TOKEN_LINE);
    }
emitted:
    APPEND_BLOCK_CHAIN(BCC_TREE_SPECIAL,result,LOOP_BLOCK_WEIGHT);
    TYPE_POOL_WORD6=0;
    TYPE_POOL_LENGTH=TYPE_POOL_LENGTH_MARK;
}
#undef NEXT

/* ---- STCONV (listing ovr_1cf2_9000:2B00) ---- */
extern unsigned int EXPR_POOL_SEG;
extern int far pascal TYPE_RECORDS_COMPATIBLE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal STASSIGN(unsigned int,unsigned int);
extern unsigned int far pascal STCVT8(void);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
/* Builds the assignment node "left = right" for an initialisation,
   converting right to left's type (STASSIGN); struct values must have
   compatible types.  Error nodes (kind TK_UNDEFINED) pass through. */
static unsigned int near pascal BCC_STMT_CONVERT_NEAR(register unsigned int left,unsigned int right)
{
    unsigned int result;
    if(EXPR_W(left,EXPR_KIND)==TK_UNDEFINED) return left;
    if(right && EXPR_W(right,EXPR_KIND)==TK_UNDEFINED) return right;
    if(EXPR_W(left,EXPR_KIND)==TK_STRUCT || EXPR_W(right,EXPR_KIND)==TK_STRUCT) {
        if(!TYPE_RECORDS_COMPATIBLE(EXPR_W(left,EXPR_TYPE),EXPR_W(right,EXPR_TYPE),2)) {
            REPORT_ERROR(MSG_ILLEGAL_STRUCTURE);
            return STCVT8();
        }
        result=NEW_EXPR_NODE_HOOK(0x12,EXPR_W(left,EXPR_TYPE),left,right);
        return result;
    }
    right=STASSIGN(right,EXPR_W(left,EXPR_TYPE));
    return NEW_EXPR_NODE_HOOK(0x12,EXPR_W(left,EXPR_TYPE),left,right);
}
