/* target: ovr168_C112UNIT */
/* Role: C++ classes: member lookup through base classes (ambiguity report), friend tests
   and access checks for members and symbols. Entry points: FIND_MEMBER_IN_BASES,
   FIND_MEMBER_REPORT, FIND_MEMBER_QUIET, IS_FRIEND, MEMBER_ACCESSIBLE, SYMBOL_ACCESSIBLE.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: name lookup in a class and its bases, and the C++ access rules. Used by
   every part of the C++ front end that names a member: expression analysis, the
   constructor builders of CPPCTOR.C, overload resolution, class definition checks.
   - FIND_MEMBER_IN_BASES looks a name (a NAME_POOL record) up in a class type with
     FIND_MEMBER_BY_NAME and, if it is not declared there, in each base class in turn.
     Finding it along two different paths is an ambiguity, unless the two finds are the
     same member reached through virtual bases, or both are member functions (member
     kind 3) and one class is a base of the other along a virtual path (the derived one
     dominates). FIND_MEMBER_REPORT reports MSG_FIELD_AMBIGUOUS, FIND_MEMBER_QUIET does
     not.
   - MEMBER_ACCESSIBLE and SYMBOL_ACCESSIBLE answer whether a member may be used from
     the code being compiled (CURRENT_CLASS_TYPE is the class whose member function is
     being compiled, 0 outside classes) when reached through an object of class value.
   Access codes, as read from the code: bits 2-4 of MEMB_FLAGS (bits 2-4 of
   SYM_INLINE_ACCESS for a symbol) hold 0 public, 1 protected, 2 private; 3 means not
   accessible at all (private member of a base class) and 4 always accessible.
   ACCESS_MODE_VIA_BASES recomputes the code as seen through the derivation path
   (private inheritance turns public into private, a private member of a base becomes 3),
   unless the member was named in an access declaration of the class (TAG_ACCESS_DECLS).
   The friend list in RETURN_FORM_SEEN: in C++ that DS word is reused, while a function
   is compiled, for the list of classes that made the function a friend (set from
   CACHE_HEAD in FUNCDEF.C and INLINEXP.C); in C it is a byte about return statements
   (STMTC.C). The name only fits the C use.
   The code of FIND_MEMBER_IN_BASES works through register pseudo-variables (_SI is the
   member found so far, _DI walks the base list, _ES/_BX read pool records directly) to
   match the original's register use. */
/* Original CO06C (ovr_1db6_af54) as one source. */
/* opts: -mm -O -Z -p -Y */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- MEMBER_RESULT_TYPE (listing ovr_1db6_af54:F540) ---- */
static unsigned int near pascal MEMBER_RESULT_TYPE(unsigned int value);

/* MEMBER_RESULT_TYPE: the class a member belongs to: MEMB_CLASS for a data member or
   enumerator, the owner class of the symbol for a static member or a function. */
static unsigned int near pascal MEMBER_RESULT_TYPE(register unsigned int value)
{
    switch (MEMBER_B(value, MEMB_FLAGS) & 3) {
    case 0:
        return MEMBER_W(value, MEMB_CLASS);
    case 1:
        return MEMBER_W(value, MEMB_CLASS);
    default:
        return SYM_W(SYM_W(MEMBER_W(value, MEMB_VALUE), SYM_OWNER_CLASS), SYM_TYPE);
    }
}

/* ---- STAOV137 (listing ovr_1db6_af54:F585) ---- */
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
/* FIND_MEMBER_IN_BASES: looks up name mode in class node. *out gets the member found
   (0 if none), *conflict the class in which two finds clashed (0 if unambiguous), and
   *state is nonzero when the member was reached through a virtual base. Recurses into
   the base classes only in C++ mode (CPP_MODE) and only when the class does
   not declare the name itself. */
void far pascal FIND_MEMBER_IN_BASES(unsigned int mode,unsigned int node,
                              unsigned int far *conflict,unsigned int far *out,
                              unsigned int far *state)
{
    unsigned int error,flag,child,childflag,first,second;
    error=0;
    _SI=FIND_MEMBER_BY_NAME(mode,node);
    flag=0;
    if(CPP_MODE!=0 && _SI==0) {
        _BX=node; _ES=TYPE_POOL; _BX=ES_W(_BX,TYPE_TAG_BODY); _ES=TAG_BODY_POOL_SEG; _DI=ES_W(_BX,TAG_BASES);
        while(_DI!=0) {
            FIND_MEMBER_IN_BASES(mode,(_ES=BASE_LIST_SEG,ES_W(_DI,BASE_TYPE)),&error,&child,&childflag);
            if(error!=0) {_SI=child; break;}
            if(child!=0) {
                _ES=BASE_LIST_SEG; childflag|=ES_B(_DI,BASE_VIRTUAL);
                if(_SI==0) {_SI=child;flag=childflag;goto next;}
                if(flag!=0 && _SI==child) goto next;
                if(flag==childflag) goto conflict;
                _ES=MEMBER_SEGMENT;
                if((ES_B(_SI,MEMB_FLAGS)&3)!=3) goto conflict;
                _BX=child;
                if((ES_B(_BX,MEMB_FLAGS)&3)!=3) goto conflict;
                {
                    first=MEMBER_RESULT_TYPE(_SI);
                    second=MEMBER_RESULT_TYPE(child);
                    if(childflag!=0 && IS_BASE_CLASS(second,first,0)) goto next;
                    if(flag!=0 && IS_BASE_CLASS(first,second,0)) {
                        _SI=child;flag=0;goto next;
                    }
                }
conflict:
                error=node;break;
            }
next:
            _ES=BASE_LIST_SEG;_DI=ES_W(_DI,BASE_NEXT);
        }
    }
    *out=_SI;
    *conflict=error;
    *state=flag;
}

/* ---- STAOV138 (listing ovr_1db6_af54:F6D1) ---- */
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,long,long);
extern long far pascal MEMBER_NAME_TEXT(unsigned int);
extern long far pascal CLASS_NAME_OF_TYPE(unsigned int);

/* FIND_MEMBER_REPORT: FIND_MEMBER_IN_BASES(name first, class second) that reports an
   ambiguity; returns the member or 0. FIND_MEMBER_QUIET below does the same silently. */
unsigned int far pascal FIND_MEMBER_REPORT(unsigned int first,unsigned int second)
{
    unsigned int result,temp,extra;
    FIND_MEMBER_IN_BASES(first,second,&temp,&result,&extra);
    if(temp) REPORT_DIAGNOSTIC(MSG_FIELD_AMBIGUOUS,MEMBER_NAME_TEXT(result),CLASS_NAME_OF_TYPE(temp));
    return result;
}

/* ---- STAOV139 (listing ovr_1db6_af54:F71C) ---- */

unsigned int far pascal FIND_MEMBER_QUIET(unsigned int first,unsigned int second)
{
    unsigned int result,temp,extra;
    FIND_MEMBER_IN_BASES(first,second,&temp,&result,&extra);
    return result;
}

/* ---- ACCESS_MODE_VIA_BASES (listing ovr_1db6_af54:F744) ---- */
static int far pascal ACCESS_MODE_VIA_BASES(int fallback,unsigned int key,unsigned int type,unsigned int node);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
/* ACCESS_MODE_VIA_BASES: the access code of member key, declared in class type, as
   seen through class node. Returns fallback (the declared code) when node is type
   itself, when type is not a base of node, or when node has an access declaration
   for key. Otherwise takes the best code over all base paths: a code above 1 becomes 3
   (inaccessible), and a public or protected member becomes 2 through a non-public
   base. The LCELL search uses the null record 2 as a sentinel. */
static int far pascal ACCESS_MODE_VIA_BASES(int fallback,unsigned int key,unsigned int type,register unsigned int node)
{
    int best,candidate;
    unsigned int cursor;
    register unsigned int link;
    if(TYPES_COMPATIBLE(node,type,1) || !IS_BASE_CLASS(type,node,0))
        return fallback;
    cursor=TAG_W(TYPE_W(node,TYPE_TAG_BODY),TAG_ACCESS_DECLS);
    LCELL_W(2,LCELL_NULL_VALUE)=key;
    while(LCELL_W(cursor,LCELL_VALUE)!=key)
        cursor=LCELL_W(cursor,LCELL_NEXT);
    if(cursor!=0) return fallback;
    best=3;
    link=TAG_W(TYPE_W(node,TYPE_TAG_BODY),TAG_BASES);
    while(link!=0 && best>0) {
        candidate=ACCESS_MODE_VIA_BASES(fallback,key,type,BASE_W(link,BASE_TYPE));
        if(candidate>1) candidate=3;
        else if(!BASE_B(link,BASE_PUBLIC)) candidate=2;
        if(candidate<best) best=candidate;
        link=BASE_W(link,BASE_NEXT);
    }
    return best;
}

/* ---- STAOV13B (listing ovr_1db6_af54:F833) ---- */
extern unsigned int RETURN_FORM_SEEN;

/* IS_FRIEND: 1 if the class whose tag symbol is value has made the current code its
   friend: value is on the friend list of the function being compiled
   (RETURN_FORM_SEEN, see the overview) or on the list at word 0x0A of the current
   class's tag body (the classes that declared the current class a friend; filled by
   TYPE_FINALIZE in CLASSDEF.C).
   Both lists are CONS cells searched with record 0 as a sentinel; the first load of
   entry is repeated, as in the original. */
unsigned char far pascal IS_FRIEND(unsigned int value)
{
    register unsigned int entry;

    entry = RETURN_FORM_SEEN;
    *((unsigned int far *)MK_FP(CONS_CELL_POOL_SEG, 2)) = value;
    entry = RETURN_FORM_SEEN;
    while (*((unsigned int far *)MK_FP(CONS_CELL_POOL_SEG, entry + CONS_VALUE)) != value)
        entry = *((unsigned int far *)MK_FP(CONS_CELL_POOL_SEG, entry));
    if (entry == 0 && CURRENT_CLASS_TYPE != 0) {
        entry = *((unsigned int far *)MK_FP(
            TAG_BODY_POOL_SEG,
            *((unsigned int far *)MK_FP(TYPE_POOL, CURRENT_CLASS_TYPE + TYPE_TAG_BODY)) + 0x0A));
        while (*((unsigned int far *)MK_FP(CONS_CELL_POOL_SEG, entry + CONS_VALUE)) != value)
            entry = *((unsigned int far *)MK_FP(CONS_CELL_POOL_SEG, entry));
    }
    return entry != 0;
}

/* ---- ACCESS_ALLOWED (listing ovr_1db6_af54:F8A2) ---- */
static unsigned char far pascal ACCESS_ALLOWED(unsigned int key,int mode,unsigned int node,unsigned int other);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
/* ACCESS_ALLOWED: may member key with access code mode, declared in class node, be
   used through an object of class other? Yes when node is 0 or the code is 4; friends
   of node (when other is 0 or derives from node) and members of node or other may use
   all but code 3; members of a class derived from node may use public and protected
   members (code <= 1) through an object of their own class; friends of other may use
   all but 3. Note IS_BASE_CLASS(a,b,0) means "a is a base of b" (see CPPCTOR.C). */
static unsigned char far pascal ACCESS_ALLOWED(unsigned int key,register int mode,register unsigned int node,unsigned int other)
{
    if(node==0 || mode==4) return 1;
    if(IS_FRIEND(TAG_W(TYPE_W(node,TYPE_TAG_BODY),TAG_SYMBOL)) && (other==0 || IS_BASE_CLASS(node,other,0)))
        return mode!=3;
    mode=ACCESS_MODE_VIA_BASES(mode,key,node,other);
    if(mode==0) return 1;
    if(CURRENT_CLASS_TYPE!=0) {
        if(TYPES_COMPATIBLE(CURRENT_CLASS_TYPE,node,1) || TYPES_COMPATIBLE(CURRENT_CLASS_TYPE,other,1)) return mode!=3;
        if(IS_BASE_CLASS(node,CURRENT_CLASS_TYPE,0) && TYPES_COMPATIBLE(CURRENT_CLASS_TYPE,other,1)) return mode<=1;
    }
    if(IS_FRIEND(TAG_W(TYPE_W(other,TYPE_TAG_BODY),TAG_SYMBOL))) return mode!=3;
    return 0;
}

/* ---- MEMBER_ACCESSIBLE (listing ovr_1db6_af54:F9A5) ---- */
unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int node, unsigned int value);

/* MEMBER_ACCESSIBLE: may member record node be used through an object of class value
   (usually CURRENT_CLASS_TYPE or the object expression's class)? */
unsigned char far pascal MEMBER_ACCESSIBLE(register unsigned int node, unsigned int value)
{
    register unsigned int target;
    switch (MEMBER_B(node, MEMB_FLAGS) & 3) {
    case 0:
        target = MEMBER_W(node, MEMB_CLASS);
        break;
    case 1:
        target = MEMBER_W(node, MEMB_CLASS);
        break;
    case 2:
    case 3:
        target = SYM_W(SYM_W(MEMBER_W(node, MEMB_VALUE), SYM_OWNER_CLASS), SYM_TYPE);
        break;
    }
    return ACCESS_ALLOWED(node, (MEMBER_B(node, MEMB_FLAGS) >> 2) & 7, target, value);
}

/* ---- SYMBOL_ACCESSIBLE (listing ovr_1db6_af54:FA10) ---- */
unsigned char far pascal SYMBOL_ACCESSIBLE(unsigned int value1,unsigned int value2);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
/* SYMBOL_ACCESSIBLE: the same for a member symbol value1 (a member function or static
   member): finds its member record in its owner class and checks the access code kept
   in SYM_INLINE_ACCESS. */
unsigned char far pascal SYMBOL_ACCESSIBLE(register unsigned int value1,unsigned int value2)
{
    unsigned int intermediate;
    intermediate=FIND_MEMBER_BY_NAME(SYM_W(value1,SYM_NAME),SYM_W(SYM_W(value1,SYM_OWNER_CLASS),SYM_TYPE));
    return ACCESS_ALLOWED(intermediate,(int)SYM_B(value1,SYM_INLINE_ACCESS)>>2,SYM_W(SYM_W(value1,SYM_OWNER_CLASS),SYM_TYPE),value2);
}
