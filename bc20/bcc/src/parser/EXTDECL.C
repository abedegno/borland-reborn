/* target: ovr056_C83UNIT */
/* opts: -mm -O -Z -p -Y -B -Tm2 */
/* Role: parser: external (file-level) declarations; declares functions, typedefs and
   variables, merges redeclarations, parses declaration initialisers. Entry points:
   SET_FUNCTION_SYMBOL_TYPE, MERGE_FUNCTION_DECLARATION, DECLARE_FUNCTION, DECLARE_TYPEDEF,
   DECLARE_VARIABLE, PARSE_DECL_INITIALIZER, PARSE_EXTERNAL_DECLARATIONS. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Original CO000 (record ovr_1b9b_5000, 6313 bytes) as one source file.
   -Z: ES is kept across far stores into the same segment (user-accepted,
   batch290-admission/policy-Z-extension.json).
   "friend"/"virtual" (DS:0702/0709) are formed as MK_FP(_DS,offset): the original
   loads DS before the offset and the inversion of the jump at 12E4 requires an
   address the compiler sizes as a constant. */
#include <dos.h>
#include "EXTDECL.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
/* Overview: the top level of the C++ front end's parse (it also compiles C
   when CPP_MODE, the C++ language flag, is clear).
   PARSE_EXTERNAL_DECLARATIONS is called once per compile (from
   BEGIN_SESSION in INITPOOL.C): it initialises the parser and reads
   external declarations until end of input, handling extern "C" { ... }
   linkage blocks (C0LINKAGE / C0UNLINK keep a stack of CURRENT_LINKAGE),
   then processes deferred work (inline bodies and the like) and runs the
   end-of-file symbol checks (CHECK_FILE_SYMBOLS, SYMSCAN.C).
   C0DECL parses one declaration: specifiers, then each declarator in
   turn, sending it to DECLARE_TYPEDEF, DECLARE_FUNCTION,
   COMPILE_FUNCTION_DEFINITION (FUNCDEF.C) when a body follows, or
   DECLARE_VARIABLE plus PARSE_DECL_INITIALIZER.  The same DECLARE_*
   functions serve local declarations too (STMTCPP.C).
   Storage classes are kept in bits 3-7 of SYM_STORAGE_CLASS; from how
   C0SELECT assigns them: 1 a global definition, 2 extern, 3 file static
   (or inline function), 4 static inside a block, 5 auto (local), 6 a
   function (the symbol of a declared function starts as 6), 8 typedef,
   9 a constant whose value is known (C++ const scalars), 10 probably a
   predeclared intrinsic.  Storage-class tokens: 0x82 none given, 0x35
   static, 0x36 extern, 0x37 typedef, 0x38 register, 0x39 auto,
   0x6B inline, 0x6E overload. */
#define HEAD(n) (*(unsigned int far *)MK_FP(NAME_POOL_SEG,(n)))
#define LW(n) (*(unsigned int far *)MK_FP(LINKAGE_STACK_POOL_SEG,(n)))
#define TEXT(n) ((char near *)(n))


/* Moves symbol input from the head list of its name into the current
   scope's name list, unless the current scope is the file scope
   (GLOBAL_SCOPE_NAMES); also sets its name-space kind to 1.  Used in C when a
   block-scope extern refers to a symbol found elsewhere (C0SELECT). */
static void near pascal C0RELINK(unsigned int input)
{
    register unsigned int record=input;
    register unsigned int current;
    unsigned int previous;

    SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&0xF8)|1;
    if(SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES)!=GLOBAL_SCOPE_NAMES) {
        current=HEAD(SYM_W(record,SYM_NAME));
        previous=0;
        while(current!=record) {
            previous=current;
            current=SYM_W(current,SYM_NEXT);
        }
        if(!previous) HEAD(SYM_W(record,SYM_NAME))=SYM_W(record,SYM_NEXT);
        else SYM_W(previous,SYM_NEXT)=SYM_W(record,SYM_NEXT);
        SYM_W(record,SYM_NEXT)=SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES);
        SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES)=record;
    }
}

/* Finds or creates the symbol for a declaration of name in the current
   scope.  token is the storage-class token, declaration the kind of thing
   declared (6 a function, 5 a variable, 3 or 4 a constant).  An existing
   symbol is reused when the redeclaration is legal (extern after extern,
   a file-scope redeclaration, and so on), with the "previously declared"
   style diagnostics; otherwise a new symbol is created with the storage
   class worked out from token, declaration and scope (see the file
   overview).  *selected receives the symbol, *created 1 if it is new. */
static void near pascal C0SELECT(unsigned int name,register unsigned int token,
    unsigned int declaration,unsigned int far *selected,unsigned char far *created)
{
    unsigned int context;
    int kind;
    unsigned int new_kind;
    register unsigned int record;

    context=SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES);
    if(CPP_MODE) {
        record=FIND_NAME_IN_LIST(name,SCOPE_W(CURRENT_SCOPE,SCOPE_TAGS));
        if(record && (EXPR_FLAGS[TYPE_W(SYM_W(record,SYM_TYPE),TYPE_KIND)]&0x40) &&
           (TYPE_B(SYM_W(record,SYM_TYPE),TYPE_ATTRS)&4) && declaration==0)
            REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
    }
    record=FIND_NAME_IN_LIST(name,context);
    if(!CPP_MODE && !record &&
       (declaration==6 || token==0x36 || (context==GLOBAL_SCOPE_NAMES && token==0x82))) {
        record=C0FIND(name,1);
        if(!record) {
            record=C0FIND(name,0);
            if(record) C0RELINK(record);
        }
    }
    if(record) {
        kind=(int)SYM_B(record,SYM_STORAGE_CLASS)>>3;
        if(token==0x35) {
            if(!CPP_MODE && kind!=3 && SYM_W(record,SYM_TYPE)!=0) {
                if(NOT_ANSI_FLAG) SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|0x18;
                else REPORT_NAME_DIAGNOSTIC(MSG_WAS_PREVIOUSLY_138,name);
            }
        } else if((context==GLOBAL_SCOPE_NAMES && (kind==1 || kind==2)) ||
                  declaration==6 || token==0x36) {
            if(declaration==4 || declaration==3) {
                declaration=5;
                token=kind==1?0x82:0x36;
            }
            if(token==0x35 && (kind==1 || kind==2) &&
               (CPP_MODE==0 || (TYPE_B(SYM_W(record,SYM_TYPE),TYPE_ATTRS)&1)==0)) {
                REPORT_NAME_DIAGNOSTIC(MSG_DECLARED_BOTH_EXTERNAL,name);
                SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|0x18;
            }
        } else if(token!=0x39 || kind!=5 || SYM_W(record,SYM_STORAGE)!=0)
            record=0;
    }
    if(!record) {
        *created=1;
        record=BCC_TYPE_CREATE(name,declaration);
        new_kind=5;
        if(declaration==3 || declaration==4) new_kind=9;
        else if(token==0x35 && declaration!=6 && context!=GLOBAL_SCOPE_NAMES) new_kind=4;
        else if(token==0x35 || token==0x6B) new_kind=3;
        else if(token==0x36 || declaration==6) new_kind=2;
        else if(context==GLOBAL_SCOPE_NAMES) new_kind=1;
        if(new_kind<5) C0MARK(1);
        SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|((new_kind&0x1F)<<3);
    } else *created=0;
    *selected=record;
}

/* Gives function symbol record its type and storage class (3 static or
   inline, else 2 extern), its pascal (flag 0x40) and far (flag 0x80)
   bits, and in C++ its inline kind, linkage and function kind (scope).
   main gets linkage 2 and must return int (relaxed checks allow void). */
void far pascal SET_FUNCTION_SYMBOL_TYPE(register unsigned int record,unsigned int scope,
                       register unsigned int type,unsigned int token)
{
    SYM_W(record,SYM_TYPE)=type;
    SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|((((token==0x35 || token==0x6B)?3:2)&0x1F)<<3);
    if(TYPE_B(type,TYPE_CALL_CONV)==2) SYM_B(record,SYM_FLAGS)|=0x40;
    if(TYPE_B(type,TYPE_FUNC_FLAGS)&1) SYM_B(record,SYM_FLAGS)|=0x80;
    if(CPP_MODE) {
        SYM_W(record,SYM_VIRTUAL_INDEX)=0;
        SYM_B(record,SYM_INLINE_ACCESS)=(SYM_B(record,SYM_INLINE_ACCESS)&0xFC)|(((token==0x6B)?1:0)&3);
        SYM_W(record,SYM_LINKAGE)=(CURRENT_LINKAGE==0)?1:CURRENT_LINKAGE;
        SYM_W(record,SYM_FUNC_KIND)=scope;
    }
    if(SYM_W(record,SYM_NAME)==MAIN_SYMBOL && CURRENT_CLASS_TYPE==0) {
        if(CPP_MODE) SYM_W(record,SYM_LINKAGE)=2;
        if(NOT_ANSI_FLAG==0 || TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)!=TK_VOID) {
            if(!TYPES_COMPATIBLE(TYPE_W(type,TYPE_TARGET),INT_TYPE,1)) REPORT_CURRENT_TOKEN(MSG_MAIN_MUST_HAVE_RETURN);
        }
    }
}

/* Checks a function declaration against an earlier one (previous, 0 if
   none).  First checks the return type (no arrays or functions, no
   abstract class in C++).  With no earlier declaration it only checks
   that default arguments are all at the end.  In C++ an earlier function
   goes to BCC_TYPE_MATCH, which decides between redeclaration and a new
   overload (*changed set).  In C the newer prototype replaces an old-style
   declaration and the types must be compatible.  A non-function of the
   same name is a multiple declaration. */
void far pascal MERGE_FUNCTION_DECLARATION(unsigned int scope,register unsigned int type,
    unsigned int far *selected,unsigned int previous,unsigned int token,
    unsigned char far *changed)
{
    unsigned char special;
    unsigned int previous_type;
    unsigned int target_type;
    unsigned int marked_count;
    unsigned int parameter;
    register unsigned int old_record;

    old_record=previous;
    marked_count=0;
    parameter=TYPE_W(type,TYPE_PARAMS);
    special=(TYPE_B(type,TYPE_FUNC_FLAGS)&8)!=0;
    target_type=TYPE_W(type,TYPE_TARGET);
    if(TYPE_W(target_type,TYPE_KIND)==TK_ARRAY || TYPE_W(target_type,TYPE_KIND)==TK_FUNCTION)
        REPORT_CURRENT_TOKEN(MSG_FUNCTIONS_CANNOT);
    else if(CPP_MODE && (EXPR_FLAGS[TYPE_W(target_type,TYPE_KIND)]&0x40) &&
            (TAG_W(TYPE_W(target_type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x80))
        REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE,(char far *)CLASS_NAME_OF_TYPE(target_type),0L);

    if(old_record &&
       ((SYM_W(*selected,SYM_TYPE)!=0 && TYPE_W(SYM_W(*selected,SYM_TYPE),TYPE_KIND)!=TK_FUNCTION) ||
        ((int)SYM_B(*selected,SYM_STORAGE_CLASS)>>3)==8))
        *selected=ALLOC_SYMBOL_ENTRY(SYM_W(*selected,SYM_NAME),6);
    if(*selected!=old_record) SET_FUNCTION_SYMBOL_TYPE(*selected,scope,type,token);
    if(CPP_MODE && SYM_W(*selected,SYM_FUNC_KIND)!=0)
        BCC_TYPE_VALIDATE(*selected,type);

    if(old_record==0) {
        *changed=0;
        while(parameter!=0) {
            if(FORMAL_W(parameter,FORMAL_DEFAULT_ARG)!=0) ++marked_count;
            else if(marked_count!=0) {
                REPORT_CURRENT_TOKEN(MSG_DEFAULT_VALUE_MISSING);
                return;
            }
            parameter=FORMAL_W(parameter,FORMAL_NEXT);
        }
        return;
    }
    previous_type=SYM_W(old_record,SYM_TYPE);
    if(old_record==EMIT_INTRINSIC_SYMBOL) {
        *changed=0;
        return;
    }
    if(previous_type==0 && ((int)SYM_B(old_record,SYM_STORAGE_CLASS)>>3)==0x0A) {
        SYM_W(old_record,SYM_TYPE)=type;
        *changed=0;
        return;
    }
    if(TYPE_W(previous_type,TYPE_KIND)==TK_FUNCTION) {
        if(CPP_MODE) {
            BCC_TYPE_MATCH(old_record,type,CURRENT_LINKAGE,selected,changed);
            return;
        }
        *changed=0;
        if(!special && !(SYM_B(old_record,SYM_FLAGS)&2) && CURRENT_SCOPE==GLOBAL_SCOPE)
            SYM_W(old_record,SYM_TYPE)=type;
        if(!TYPES_COMPATIBLE(type,previous_type,0)) REPORT_NAME_DIAGNOSTIC(MSG_TYPE_MISMATCH,SYM_W(old_record,SYM_NAME));
        return;
    }
    REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,SYM_W(old_record,SYM_NAME));
}

/* Declares function name with type (no body).  Storage class must be
   extern, static or inline (none and overload mean extern).  In C++ a
   declaration with a different signature becomes a new overload chained
   through SYM_NEXT_OVERLOAD.  *result receives the symbol, *created 1 if
   it is new. */
void far pascal DECLARE_FUNCTION(register unsigned int type,unsigned int name,unsigned int scope,
    register unsigned int token,unsigned int far *result,unsigned char far *created)
{
    unsigned int previous;
    unsigned char changed;
    unsigned int record;
    if(token==0x82 || token==0x6E) token=0x36;
    if(token!=0x36 && token!=0x35 && token!=0x6B) REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_131,TOKEN_NAMES[token]);
    C0SELECT(name,token,6,&record,created);
    previous=*created ? 0 : record;
    MERGE_FUNCTION_DECLARATION(scope,type,&record,previous,token,&changed);
    if(CPP_MODE) {
        if(SYM_W(record,SYM_TYPE)==0) {
            SET_FUNCTION_SYMBOL_TYPE(record,scope,type,token);
            changed=1;
        } else if(changed) {
            record=ALLOC_SYMBOL_ENTRY(name,6);
            SET_FUNCTION_SYMBOL_TYPE(record,scope,type,token);
            SYM_W(record,SYM_NEXT_OVERLOAD)=SYM_W(previous,SYM_NEXT_OVERLOAD);
            SYM_W(previous,SYM_NEXT_OVERLOAD)=record;
        }
    }
    SYM_W(record,SYM_FUNC_FLAGS)|=0x80;
    *result=record;
}

/* Declares typedef name for type in the current scope (storage class 8).
   An unnamed struct takes the typedef name as its own in C++.  A typedef
   repeating an identical earlier one is accepted.  The declaration
   attributes (memory model modifiers and the like) are kept in the
   symbol's storage word, except for pointer types. */
void far pascal DECLARE_TYPEDEF(register unsigned int type,struct DeclarationAttributes attributes,
    unsigned int name)
{
    register unsigned int record;
    record=FIND_NAME_IN_LIST(name,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    if(CPP_MODE && record==0) record=FIND_NAME_IN_LIST(name,SCOPE_W(CURRENT_SCOPE,SCOPE_TAGS));
    if(record==0) {
        record=BCC_TYPE_CREATE(name,1);
        SYM_W(record,SYM_TYPE)=type;
        SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|0x40;
        if(CPP_MODE && (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) && SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)==0)
            SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)=name;
    } else if(((SYM_B(record,SYM_STORAGE_CLASS)>>3)!=8 && ((SYM_B(record,SYM_STORAGE_CLASS)>>3)!=11 || !CPP_MODE)) ||
               !TYPES_COMPATIBLE(SYM_W(record,SYM_TYPE),type,0))
        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
    *(struct DeclarationAttributes far *)MK_FP(SYMBOL_POOL_SEG,record+SYM_STORAGE)=
        (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) ? EXPR_TEMP2 : attributes;
}

/* Turns a tentative definition into an extern-like symbol whose storage
   is placed later (storage class 2, prepared flag 0x80), with far data
   flags for a far array.  DECLARE_VARIABLE uses it for Windows programs
   instead of reserving the storage at once (why is not visible here). */
static void far pascal C0FINAL(unsigned int input)
{
    register unsigned int record=input;
    register unsigned int prepared;
    SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|0x10;
    prepared=PREPARE_SYMBOL(record);
    SET_PREPARED_FLAGS(prepared,0x80);
    if(TYPE_W(SYM_W(record,SYM_TYPE),TYPE_KIND)==TK_ARRAY && (TYPE_B(SYM_W(record,SYM_TYPE),TYPE_ATTRS)&0x40)) {
        SET_PREPARED_FLAGS(prepared,0x10);
        CLEAR_PREPARED_FLAGS(prepared,4);
        SYM_B(record,SYM_FLAGS)|=0x80;
    }
}

/* Declares variable name of type input.  token is the storage-class
   token, defining nonzero when an initializer follows, attributes the
   declaration modifiers.  Returns the symbol.  Main steps: a C++ const
   object without storage class becomes static (and, when initialised, a
   constant symbol of class 9); incomplete types are reported; C0SELECT
   finds or creates the symbol; a new symbol gets its flags (register,
   defined, far data when far is requested, the data and BSS groups
   differ, or the object is large and automatic far data is on); in C++ a
   global declared without initializer reserves its storage at once
   (statics inside functions likewise); a redeclaration must have a
   compatible type and may move the object between near and far data. */
unsigned int far pascal DECLARE_VARIABLE(unsigned int input,unsigned int name,
    unsigned int token,unsigned char defining,DeclarationAttributes attributes)
{
    unsigned char created;
    unsigned int requested_kind;
    unsigned int record;
    unsigned int prepared;
    unsigned int previous_type;
    unsigned int amount;
    unsigned int temporary;
    register unsigned int type=input;
    register unsigned int kind;

    requested_kind=5;
    if(CPP_MODE && (TYPE_B(type,TYPE_ATTRS)&1) && (token==0x82 || token==0x35)) {
        token=0x35;
        if(defining) {
            if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&1) requested_kind=3;
            else if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&2) requested_kind=4;
        } else REPORT_CURRENT_TOKEN(MSG_OBJECT_MUST);
    }
    if(TYPE_SIZE(type)==0L) {
        temporary=TYPE_W(type,TYPE_KIND)==TK_ARRAY?TYPE_W(type,TYPE_TARGET):type;
        if(TYPE_SIZE(temporary)==0L) {
            while(TYPE_W(temporary,TYPE_KIND)==TK_ARRAY) temporary=TYPE_W(temporary,TYPE_TARGET);
            if((EXPR_FLAGS[TYPE_W(temporary,TYPE_KIND)]&0x40) && TYPE_SIZE(temporary)==0L) {
                if(token!=0x36)
                    REPORT_NAME_DIAGNOSTIC(MSG_UNDEFINED_STRUCTURE,SYM_W(TAG_W(TYPE_W(temporary,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME));
            } else REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,name);
        }
    }
    if(CPP_MODE && (TYPE_B(type,TYPE_ATTRS)&4)) {
        temporary=type;
        while(TYPE_W(temporary,TYPE_KIND)==TK_ARRAY) temporary=TYPE_W(temporary,TYPE_TARGET);
        if(TAG_W(TYPE_W(temporary,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x80)
            REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE,(char far *)FORMAT_TYPE(temporary),0L);
    }
    C0SELECT(name,token,requested_kind,&record,&created);
    if(requested_kind!=5 && (SYM_B(record,SYM_STORAGE_CLASS)>>3)==9) {
        if(!created) REPORT_NAME_DIAGNOSTIC(MSG_VARIABLE_INITIALIZED,name);
        return record;
    }
    kind=SYM_B(record,SYM_STORAGE_CLASS)>>3;
    if(created!=0) {
        SYM_W(record,SYM_TYPE)=type;
        if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20) &&
            !defining && kind!=2) REPORT_CURRENT_TOKEN(MSG_OBJECT_MUST);
        if(defining && kind==2 && CURRENT_SCOPE==GLOBAL_SCOPE) {
            SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|8;
            kind=1;
        }
        if(token==0x38) SYM_B(record,SYM_FLAGS)|=8;
        if(kind==3 || kind==1) SYM_B(record,SYM_FLAGS)|=2;
        if(defining) SYM_B(record,SYM_FLAGS)|=3;
        if((attributes.storage==2 || (attributes.storage==0 && OPTION_CALLING_CONVENTION==1)) &&
            (kind==1 || kind==2)) SYM_B(record,SYM_FLAGS)|=0x40;
        if(attributes.calling==8)
            SYM_B(record,SYM_FLAGS)|=8;
        else if(attributes.calling==9 || DATA_BSS_GROUPS_DIFFER!=0 ||
            ((kind==2 || (kind==1 && TYPE_SIZE(type)>=(long)FAR_DATA_THRESHOLD)) &&
             ((MODEL_FAR_DATA && OPTION_AUTO_FAR_DATA) || OPTION_MEMORY_MODEL==5))) {
            if(CPP_MODE && (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) &&
                (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x108)==0) REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            SYM_B(record,SYM_FLAGS)|=0x80;
        }
        if(!defining && CPP_MODE && token==0x82) {
            if(TYPE_W(type,TYPE_KIND)==TK_ARRAY && TYPE_SIZE(type)==0L) REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,name);
            if(OPTION_WINDOWS_MODE)
                C0FINAL(record);
            else if(TYPE_W(type,TYPE_KIND)==TK_ARRAY && (TYPE_B(type,TYPE_ATTRS)&0x40)) {
                SYM_B(record,SYM_FLAGS)|=0x80;
                SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(record),DEFINE_HUGE_DATA_SEGMENTS(type));
                EMIT_HUGE_DATA(record);
            } else {
                temporary=PREPARE_SYMBOL(record);
                STREAM_HOOK(GET_SYMBOL_SEGMENT_HOOK(temporary));
                ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK(type));
                DEFINE_SYMBOL_HERE_HOOK(temporary);
                amount=(unsigned int)TYPE_SIZE(type);
                if(amount) RESERVE_BYTES_HOOK(amount);
            }
            SYM_B(record,SYM_FLAGS)|=3;
        }
        if(kind==5) {
            if(attributes.storage|attributes.calling|attributes.qualifier) REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            previous_type=SYM_W(record,SYM_TYPE);
            if(CPP_MODE &&
                (!((EXPR_FLAGS[TYPE_W(previous_type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(previous_type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)) &&
                TYPE_W(previous_type,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(previous_type,TYPE_PTR_MODE)==0x0B)
                previous_type=MEMBER_PTR_CLASS_TYPE;
            if(TYPE_SIZE(type)!=0L) REGISTER_SYMBOL_VARIABLE(record);
            return record;
        } else if(kind==2 || kind==1) {
            return record;
        } else if(kind==3 || kind==4) {
            if(TYPE_W(type,TYPE_KIND)==TK_ARRAY && (TYPE_B(type,TYPE_ATTRS)&0x40)) {
                SYM_B(record,SYM_FLAGS)|=0x80;
                SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(record),DEFINE_HUGE_DATA_SEGMENTS(type));
                if(CURRENT_SCOPE!=GLOBAL_SCOPE && !defining) EMIT_HUGE_DATA(record);
                return record;
            } else {
                if(attributes.calling==9 ||
                    ((OPTION_MEMORY_MODEL==5 || DATA_BSS_GROUPS_DIFFER!=0) && !defining && attributes.calling!=8))
                    SYM_B(record,SYM_FLAGS)|=0x80;
                prepared=PREPARE_SYMBOL(record);
                if(attributes.calling==9) SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_FAR_SEGMENT());
                if(CURRENT_SCOPE!=GLOBAL_SCOPE && !defining) {
                    STREAM_HOOK(GET_SYMBOL_SEGMENT_HOOK(prepared));
                    ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK(type));
                    DEFINE_SYMBOL_HERE_HOOK(prepared);
                    amount=(unsigned int)TYPE_SIZE(type);
                    if(amount==0) REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,SYMBOL_NAME_TEXT(record),0L);
                    else RESERVE_BYTES_HOOK(amount);
                }
            }
        }
        return record;
    } else {
        if(!TYPES_COMPATIBLE(SYM_W(record,SYM_TYPE),type,0)) REPORT_NAME_DIAGNOSTIC(MSG_TYPE_MISMATCH,name);
        if(defining || token==0x82) {
            SYM_B(record,SYM_FLAGS)|=6;
            if(kind==2) SYM_B(record,SYM_STORAGE_CLASS)=(SYM_B(record,SYM_STORAGE_CLASS)&7)|8;
            if(OPTION_AUTO_FAR_DATA) {
                if(TYPE_SIZE(type)>=(long)FAR_DATA_THRESHOLD) {
                    if(!(SYM_B(record,SYM_FLAGS)&0x88)) {
                        SYM_B(record,SYM_FLAGS)|=0x80;
                        if(SYM_W(record,SYM_STORAGE)!=0) {
                            prepared=PREPARE_SYMBOL(record);
                            SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_FAR_SEGMENT());
                            CLEAR_PREPARED_FLAGS(prepared,4);
                            SET_PREPARED_FLAGS(prepared,0x10);
                        }
                    }
                } else if(SYM_B(record,SYM_FLAGS)&0x80) {
                    SYM_B(record,SYM_FLAGS)&=0x7F;
                    if(SYM_W(record,SYM_STORAGE)!=0) {
                        prepared=PREPARE_SYMBOL(record);
                        SET_SYMBOL_SEGMENT_HOOK(prepared,DATA_SEGMENT_ID);
                        CLEAR_PREPARED_FLAGS(prepared,0x10);
                        SET_PREPARED_FLAGS(prepared,4);
                    }
                }
            }
            if(defining || CPP_MODE) {
                if((SYM_B(record,SYM_FLAGS)&1) && kind!=5 && kind!=4) REPORT_NAME_DIAGNOSTIC(MSG_VARIABLE_INITIALIZED,name);
                if(!defining) {
                    if(OPTION_WINDOWS_MODE)
                        C0FINAL(record);
                    else if(TYPE_W(type,TYPE_KIND)==TK_ARRAY && (TYPE_B(type,TYPE_ATTRS)&0x40)) {
                        SYM_B(record,SYM_FLAGS)|=0x80;
                        SET_SYMBOL_SEGMENT_HOOK(prepared,DEFINE_HUGE_DATA_SEGMENTS(type));
                        EMIT_HUGE_DATA(record);
                    } else {
                        prepared=PREPARE_SYMBOL(record);
                        SET_SYMBOL_SEGMENT_HOOK(prepared,(SYM_B(record,SYM_FLAGS)&0x80)?DEFINE_FAR_SEGMENT():BSS_SEGMENT_ID);
                        STREAM_HOOK(GET_SYMBOL_SEGMENT_HOOK(prepared));
                        ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK(type));
                        DEFINE_SYMBOL_HERE_HOOK(prepared);
                        amount=(unsigned int)TYPE_SIZE(type);
                        if(amount==0) REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,SYMBOL_NAME_TEXT(record),0L);
                        else RESERVE_BYTES_HOOK(amount);
                    }
                } else if(SYM_B(record,SYM_FLAGS)&0x80)
                    SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(record),DEFINE_FAR_SEGMENT());
                else if(kind!=5)
                    SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(record),DATA_SEGMENT_ID);
                SYM_B(record,SYM_FLAGS)|=1;
            }
        }
        if(TYPE_SIZE(SYM_W(record,SYM_TYPE))==0L) SYM_W(record,SYM_TYPE)=type;
    }

    return record;
}

/* Parses the initializer of variable record of type: a constant (class 9)
   through PARSE_CONST_INITIALIZER, a reference through INIT_REFERENCE, a
   class object needing construction (defining set by the caller) through
   INIT_CLASS_OBJECT, a scalar written "x(value)" or "= value" through
   PARSE_SCALAR_INITIALIZER, and aggregates through INIT_DECLARATOR
   (INITLIST.C). */
void far pascal PARSE_DECL_INITIALIZER(unsigned char defining,unsigned int type,unsigned int record)
{
    unsigned char incomplete;
    register unsigned int current_type=type;
    register unsigned int current_record=record;

    if((SYM_B(current_record,SYM_STORAGE_CLASS)>>3)==9) {
        REQUIRE_TOKEN_ELSE_ERROR(0x0B,0xC5);
        PARSE_CONST_INITIALIZER(current_record,current_type);
    } else if((EXPR_FLAGS[TYPE_W(current_type,TYPE_KIND)]&0x14) && (TYPE_B(current_type,TYPE_ATTRS)&0x20))
        INIT_REFERENCE(current_record,current_type);
    else if(defining)
        INIT_CLASS_OBJECT(current_record,current_type);
    else {
        if(CURRENT_TOKEN==TOK_LPAREN && (EXPR_FLAGS[TYPE_W(current_type,TYPE_KIND)]&7)) {
            PARSE_SCALAR_INITIALIZER(current_record,current_type);
            return;
        }
        REQUIRE_TOKEN_ELSE_ERROR(0x0B,0xC5);
        if((EXPR_FLAGS[TYPE_W(current_type,TYPE_KIND)]&7) ||
            (CPP_MODE && TYPE_W(current_type,TYPE_KIND)!=TK_ARRAY && CURRENT_TOKEN!=TOK_LBRACE))
        {
            PARSE_SCALAR_INITIALIZER(current_record,current_type);
        }
        else {
            incomplete=TYPE_W(current_type,TYPE_KIND)==TK_ARRAY && TYPE_SIZE(current_type)==0L &&
                !(SYM_B(current_record,SYM_FLAGS)&0x88);
            INIT_DECLARATOR(current_record,current_type);
            if(incomplete!=0 && OPTION_AUTO_FAR_DATA && TYPE_SIZE(current_type)>=(long)FAR_DATA_THRESHOLD)
                REPORT_DIAGNOSTIC(MSG_ARRAY_VARIABLE_NEAR,(char far *)FORMAT_SYMBOL(current_record),0L);
        }
    }
}

/* Parses one external declaration (or an asm statement at file level).
   A declaration without declarators ("struct S { ... };") goes to
   BCC_TYPE_RELATION in C++, and in C must at least name a tag.  The
   position of each declarator is saved first, because a function
   definition needs the line where it started.  Errors set IN_ERROR_RECOVERY and
   skip to a synchronising token. */
static void near pascal C0DECL(void)
{
    unsigned int token;
    unsigned int type;
    unsigned int base;
    unsigned int name;
    unsigned int scope;
    unsigned int context;
    unsigned int record;
    unsigned char specified;
    unsigned char member;
    unsigned char defining;
    unsigned char created;
    unsigned char implicit;
    DeclarationAttributes attributes;
    DeclarationAttributes current;
    unsigned long extra;
    unsigned char friend_flag;
    unsigned char virtual_flag;
    unsigned long position;
    unsigned int saved_token_line;
    unsigned int saved_token_file;
    unsigned int saved_context;
    register unsigned int count;

    saved_context=CURRENT_CLASS_TYPE;
    if(CURRENT_TOKEN==TOK_ASM) {
        PARSE_ASM_STATEMENT();
        TOKEN_TYPE=0x82;
        ADVANCE_TOKEN();
        return;
    }
    if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x18)) {
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
        IN_ERROR_RECOVERY=1;
        ADVANCE_TOKEN();
        SKIP_TO_SYNC_TOKEN(TOK_EXTERN);
        return;
    }
    IN_ERROR_RECOVERY=0;
    token=0x82;
    type=0;
    attributes=EXPR_TEMP2;
    if(TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD)) {
        if(CURRENT_TOKEN!=TOK_IDENT || (PEEK_TOKEN(),TOKEN_TYPE)!=0x67) {
            PARSE_DECL_SPECIFIERS(0,&token,&friend_flag,&virtual_flag,&type,&attributes,&specified);
            if(friend_flag || virtual_flag || token==0x39 || token==0x38)
                /* match: DS:0702 and DS:0709 are the strings "friend" and "virtual", but they stay numbers:
                   with a name (a fixup) BC compiles this ?: differently.  The modding build
                   keeps these two words right only while the data before 0709h keeps its size. */
                REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,friend_flag ? (char far *)MK_FP(_DS,0x702) :
                    virtual_flag ? (char far *)MK_FP(_DS,0x709) : NAME_TEXT_COPY(TOKEN_NAMES[token]),0L);
        }
    }
    implicit=type==0;
    if(implicit) type=INT_TYPE;
    if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x10) && TYPE_W(type,TYPE_KIND)!=TK_ENUM) {
        if(CPP_MODE) BCC_TYPE_RELATION(type,token);
        else if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) {
            if(SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)==0) REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT_352);
        } else REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
        REQUIRE_TOKEN_ELSE_ERROR(7,0x1F);
    } else {
        count=0;
        while(TYPE_FLAGS[CURRENT_TOKEN]&0x10) {
            current=attributes;
            saved_token_line=CURRENT_TOKEN_LINE;
            saved_token_file=CURRENT_TOKEN_FILE;
            position=TOKEN_POSITION;
            ++count;
            PARSE_DECLARATOR(type,0,&base,&name,&scope,&context,&current,&extra);
            if(name==0) {
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
                goto next;
            }
            if(token==0x37) {
                if(implicit) REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
                if(context) REPORT_NAME_DIAGNOSTIC(MSG_IDENTIFIER_CANNOT_HAVE,name);
                if(scope) {
                    REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
                    goto next;
                }
                DECLARE_TYPEDEF(base,current,name);
                goto next;
            }
            if(TYPE_W(base,TYPE_KIND)==TK_FUNCTION) {
                if(CURRENT_TOKEN==TOK_COMMA || CURRENT_TOKEN==TOK_SEMICOLON) {
                    if(TYPE_B(base,TYPE_ATTRS)&0x40) {
                        REPORT_CURRENT_TOKEN(MSG_PARAMETER_NAMES_ARE);
                        goto next;
                    }
                    if(context) {
                        REPORT_NAME_DIAGNOSTIC(MSG_CLASS_MEMBER_DECLARED,name);
                        goto next;
                    }
                    DECLARE_FUNCTION(base,name,scope,token,&record,&created);
                    goto next;
                }
                if(type==base && specified) REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_FUNCTION_DEFINITION : MSG_FUNCTION_DEFINITION_387);
                if(count>1 && !NOT_ANSI_FLAG) REPORT_CURRENT_TOKEN(MSG_OTHER_OBJECTS_CANNOT);
                FUNCTION_DEF_POSITION=position;
                FUNCTION_DEF_LINE=saved_token_line;
                CURRENT_SOURCE_FILE=saved_token_file;
                COMPILE_FUNCTION_DEFINITION(base,context,name,scope,token,implicit,0);
                while(CURRENT_TOKEN==TOK_SEMICOLON) {
                    if(!NOT_ANSI_FLAG) REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
                    ADVANCE_TOKEN();
                }
                return;
            }
            if(token==0x6E) goto next;
            if(implicit && token==0x82) {
                REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
                IN_ERROR_RECOVERY=1;
            }
            defining=CURRENT_TOKEN==TOK_ASSIGN || CURRENT_TOKEN==TOK_LPAREN;
            member=(TYPE_B(base,TYPE_ATTRS)&4) && (token!=0x36 || (defining && (TYPE_B(base,TYPE_ATTRS)&1)));
            defining|=member;
            if(context) {
                record=DEFINE_STATIC_DATA_MEMBER(base,context,name,token,defining);
                CURRENT_CLASS_TYPE=context;
                base=SYM_W(record,SYM_TYPE);
            } else record=DECLARE_VARIABLE(base,name,token,defining,current);
            if(defining) PARSE_DECL_INITIALIZER(member,base,record);
            else if(CPP_MODE && token!=0x36 && record)
                TEMP_DESTRUCTOR_LIST=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(record),base,TEMP_DESTRUCTOR_LIST);
            CURRENT_CLASS_TYPE=saved_context;
next:
            C11_EXPECT(7);
        }
        REQUIRE_TOKEN_ELSE_ERROR(7,0x1F);
    }
}

/* extern "C" (or the other language name at DS:0715): pushes
   CURRENT_LINKAGE and sets it from the string literal just read (1 or 2;
   any other name is an error and gives 0). */
static void near pascal C0LINKAGE(void)
{
    char text[10];
    char far *p;
    int c;
    register unsigned int entry;
    register unsigned int index;

    index=0;
    entry=POOL_ALLOC_REUSE(&LINKAGE_STACK_POOL_SEG,4);
    LW(entry)=CURRENT_LINKAGE;
    LW(entry+2)=LINKAGE_STACK;
    LINKAGE_STACK=entry;
    p=text;
    while((c=NEXT_LITERAL_CHAR(index++))!=-1)
        if(p<text+9) *p++=c;
    *p=0;
    if(!COMPARE_NAME(text,TEXT(STR_C_7))) CURRENT_LINKAGE=1;
    else if(!COMPARE_NAME(text,TEXT(STR_C_8))) CURRENT_LINKAGE=2;
    else {
        CURRENT_LINKAGE=0;
        REPORT_CURRENT_TOKEN(MSG_UNKNOWN_LANGUAGE_MUST);
    }
    ADVANCE_TOKEN();
}

/* End of a linkage specification: pops CURRENT_LINKAGE. */
static void near pascal C0UNLINK(void)
{
    register unsigned int entry;
    if(LINKAGE_STACK==0) REPORT_CURRENT_TOKEN(MSG_UNEXPECTED);
    else {
        entry=LINKAGE_STACK;
        LINKAGE_STACK=LW(entry+2);
        CURRENT_LINKAGE=LW(entry);
        POOL_FREE_ITEM(&LINKAGE_STACK_POOL_SEG,entry);
    }
}

/* Parses the whole compilation unit (see the file overview).  An empty
   file is an error unless checks are relaxed; stray semicolons are
   skipped. */
void far pascal PARSE_EXTERNAL_DECLARATIONS(void)
{
    INIT_PARSER();
    if(CURRENT_TOKEN==0 && !NOT_ANSI_FLAG) REPORT_CURRENT_TOKEN(MSG_FILE_MUST_CONTAIN);
    while(CURRENT_TOKEN!=0) {
        while((NOT_ANSI_FLAG || CPP_MODE) && CURRENT_TOKEN==TOK_SEMICOLON) ADVANCE_TOKEN();
        if(CURRENT_TOKEN==0) break;
        if(CURRENT_TOKEN==TOK_EXTERN && (PEEK_TOKEN(),TOKEN_TYPE)==0x34) {
            ADVANCE_TOKEN();
            C0LINKAGE();
            if(CURRENT_TOKEN==TOK_LBRACE) ADVANCE_TOKEN();
            else {
                if(CURRENT_TOKEN!=TOK_LBRACE && CURRENT_TOKEN!=0) C0DECL();
                C0UNLINK();
            }
        } else if(CURRENT_TOKEN==TOK_RBRACE) {
            C0UNLINK();
            ADVANCE_TOKEN();
        } else if(CURRENT_TOKEN!=TOK_LBRACE && CURRENT_TOKEN!=0) C0DECL();
        else {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            IN_ERROR_RECOVERY=1;
            ADVANCE_TOKEN();
            SKIP_TO_SYNC_TOKEN(TOK_EXTERN);
        }
    }
    if(CPP_MODE) PROCESS_DEFERRED_DECLS();
    CHECK_FILE_SYMBOLS();
}
