/* access.c: from bcc20/src/cpp/ACCESS.C: name lookup in a class and its bases, and the C++
   access rules.  FIND_MEMBER_IN_BASES looks a name up in a class type with
   FIND_MEMBER_BY_NAME and, if it is not declared there, in each base class in turn.
   Finding it along two different paths is an ambiguity, unless the two finds are the same
   member reached through virtual bases, or both are member functions (member kind 3) and
   one class is a base of the other along a virtual path (the derived one dominates).
   MEMBER_ACCESSIBLE and SYMBOL_ACCESSIBLE answer whether a member may be used from the code
   being compiled (CURRENT_CLASS_TYPE) when reached through an object of class value.
   Access codes (bits 2-4 of MEMB_FLAGS, of SYM_INLINE_ACCESS for a symbol): 0 public, 1
   protected, 2 private, 3 not accessible at all (a private member of a base), 4 always
   accessible.  In C++ the word RETURN_FORM_SEEN holds, while a function is compiled, the
   list of classes that made it a friend.  The out-parameters passed by address live in the
   scratch area. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"

#define FRIEND_LIST W(RETURN_FORM_SEEN_P)

/* the class a member belongs to: MEMB_CLASS for a data member or enumerator, the owner
   class of the symbol for a static member or a function */
u16 MEMBER_RESULT_TYPE(u16 value)
{
    switch (MEMBER_B(value, MEMB_FLAGS) & 3) {
    case 0:
    case 1:
        return MEMBER_W(value, MEMB_CLASS);
    default:
        return SYM_W(SYM_W(MEMBER_W(value, MEMB_VALUE), SYM_OWNER_CLASS), SYM_TYPE);
    }
}

/* looks up name mode in class node.  *out gets the member found (0 if none), *conflict the
   class in which two finds clashed (0 if unambiguous), and *state is nonzero when the
   member was reached through a virtual base.  Recurses into the base classes only in C++
   and only when the class does not declare the name itself */
void FIND_MEMBER_IN_BASES(u16 mode, u16 node, farptr conflict, farptr out, farptr state)
{
    /* the three out-locals passed to the recursive call */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    farptr childflag = v, child = fp_add(v, 2), error = fp_add(v, 4);
    W(error) = 0;
    u16 si = FIND_MEMBER_BY_NAME(mode, node);
    u16 flag = 0;
    if (CPP_MODE != 0 && si == 0) {
        for (u16 di = TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_BASES); di != 0; di = BASE_W(di, BASE_NEXT)) {
            FIND_MEMBER_IN_BASES(mode, BASE_W(di, BASE_TYPE), error, child, childflag);
            if (W(error) != 0) {
                si = W(child);
                break;
            }
            if (W(child) != 0) {
                W(childflag) |= BASE_B(di, BASE_VIRTUAL);
                if (si == 0) {
                    si = W(child);
                    flag = W(childflag);
                    continue;
                }
                if (flag != 0 && si == W(child))
                    continue;
                if (flag != W(childflag) && (MEMBER_B(si, MEMB_FLAGS) & 3) == 3 && (MEMBER_B(W(child), MEMB_FLAGS) & 3) == 3) {
                    u16 first = MEMBER_RESULT_TYPE(si);
                    u16 second = MEMBER_RESULT_TYPE(W(child));
                    if (W(childflag) != 0 && IS_BASE_CLASS(second, first, 0))
                        continue;
                    if (flag != 0 && IS_BASE_CLASS(first, second, 0)) {
                        si = W(child);
                        flag = 0;
                        continue;
                    }
                }
                W(error) = node;
                break;
            }
        }
    }
    W(out) = si;
    W(conflict) = W(error);
    W(state) = flag;
    scratch_release(mark);
}

/* the lookup with the callers' three out-locals */
static u16 find_member(u16 first, u16 second, u16 *conflict)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    farptr extra = v, result = fp_add(v, 2), temp = fp_add(v, 4);
    FIND_MEMBER_IN_BASES(first, second, temp, result, extra);
    u16 member = W(result);
    *conflict = W(temp);
    scratch_release(mark);
    return member;
}

/* FIND_MEMBER_IN_BASES(name first, class second), reporting an ambiguity; the member or 0 */
u16 FIND_MEMBER_REPORT(u16 first, u16 second)
{
    u16 conflict;
    u16 result = find_member(first, second, &conflict);
    if (conflict) {
        i32 member_name = (i32)MEMBER_NAME_TEXT(result);          /* pascal: left to right */
        i32 class_name = CLASS_NAME_OF_TYPE(conflict);
        REPORT_DIAGNOSTIC(MSG_FIELD_AMBIGUOUS, member_name, class_name);
    }
    return result;
}

/* the same, silently */
u16 FIND_MEMBER_QUIET(u16 first, u16 second)
{
    u16 conflict;
    return find_member(first, second, &conflict);
}

/* the access code of member key, declared in class type, as seen through class node:
   fallback (the declared code) when node is type itself, when type is not a base of node,
   or when node has an access declaration for key; otherwise the best code over all base
   paths (a code above 1 becomes 3, and a public or protected member becomes 2 through a
   non-public base).  The LCELL search uses record 2 as its end marker */
i16 ACCESS_MODE_VIA_BASES(i16 fallback, u16 key, u16 type, u16 node)
{
    if (TYPES_COMPATIBLE(node, type, 1) || !IS_BASE_CLASS(type, node, 0))
        return fallback;
    u16 cursor = TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_ACCESS_DECLS);
    LCELL_W(2, LCELL_NULL_VALUE) = key;
    while (LCELL_W(cursor, LCELL_VALUE) != key)
        cursor = LCELL_W(cursor, LCELL_NEXT);
    if (cursor != 0)
        return fallback;
    i16 best = 3;
    for (u16 link = TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_BASES); link != 0 && best > 0; link = BASE_W(link, BASE_NEXT)) {
        i16 candidate = ACCESS_MODE_VIA_BASES(fallback, key, type, BASE_W(link, BASE_TYPE));
        if (candidate > 1)
            candidate = 3;
        else if (!BASE_B(link, BASE_PUBLIC))
            candidate = 2;
        if (candidate < best)
            best = candidate;
    }
    return best;
}

/* 1 if the class whose tag symbol is value has made the current code its friend: value is
   on the friend list of the function being compiled, or on the list at word 0Ah of the
   current class's tag body.  Both lists are CONS cells searched with record 0 as the end
   marker */
u8 IS_FRIEND(u16 value)
{
    W(MK_FP(CONS_CELL_POOL_SEG, 2)) = value;   /* record 0's value word: the search's end */
    u16 entry = FRIEND_LIST;
    while (CONS_W(entry, CONS_VALUE) != value)
        entry = CONS_W(entry, 0);
    if (entry == 0 && CURRENT_CLASS_TYPE != 0) {
        entry = TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), 0x0A);
        while (CONS_W(entry, CONS_VALUE) != value)
            entry = CONS_W(entry, 0);
    }
    return entry != 0;
}

/* may member key with access code mode, declared in class node, be used through an object
   of class other?  Yes when node is 0 or the code is 4; friends of node (when other is 0
   or derives from node) and members of node or other may use all but code 3; members of a
   class derived from node may use public and protected members through an object of their
   own class; friends of other may use all but 3 */
u8 ACCESS_ALLOWED(u16 key, i16 mode, u16 node, u16 other)
{
    if (node == 0 || mode == 4)
        return 1;
    if (IS_FRIEND(TAG_W(TYPE_W(node, TYPE_TAG_BODY), TAG_SYMBOL)) && (other == 0 || IS_BASE_CLASS(node, other, 0)))
        return mode != 3;
    mode = ACCESS_MODE_VIA_BASES(mode, key, node, other);
    if (mode == 0)
        return 1;
    if (CURRENT_CLASS_TYPE != 0) {
        if (TYPES_COMPATIBLE(CURRENT_CLASS_TYPE, node, 1) || TYPES_COMPATIBLE(CURRENT_CLASS_TYPE, other, 1))
            return mode != 3;
        if (IS_BASE_CLASS(node, CURRENT_CLASS_TYPE, 0) && TYPES_COMPATIBLE(CURRENT_CLASS_TYPE, other, 1))
            return mode <= 1;
    }
    if (IS_FRIEND(TAG_W(TYPE_W(other, TYPE_TAG_BODY), TAG_SYMBOL)))
        return mode != 3;
    return 0;
}

/* may member record node be used through an object of class value? */
u8 MEMBER_ACCESSIBLE(u16 node, u16 value)
{
    u16 target = 0;
    switch (MEMBER_B(node, MEMB_FLAGS) & 3) {
    case 0:
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

/* the same for a member symbol value1 (a member function or static member): its member
   record is found in its owner class and the access code kept in SYM_INLINE_ACCESS is
   checked */
u8 SYMBOL_ACCESSIBLE(u16 value1, u16 value2)
{
    u16 intermediate = FIND_MEMBER_BY_NAME(SYM_W(value1, SYM_NAME), SYM_W(SYM_W(value1, SYM_OWNER_CLASS), SYM_TYPE));
    return ACCESS_ALLOWED(intermediate, SYM_B(value1, SYM_INLINE_ACCESS) >> 2, SYM_W(SYM_W(value1, SYM_OWNER_CLASS), SYM_TYPE), value2);
}
