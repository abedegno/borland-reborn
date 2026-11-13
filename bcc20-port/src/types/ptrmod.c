/* ptrmod.c: PTR_TYPE_FOR_MODIFIER, from bcc20/src/types/PTRMOD.C: the C pointer type to
   node for a pointer modifier: 0 none (the model's default), 1..6 a near pointer with that
   segment mode (probably the _cs/_ds/_es/_ss based pointers), 7 _seg, 8 near (mode by the
   target kind), 9 far, 10 huge.  qualifier is the pointer's const and volatile bits; value
   goes through to NEW_POINTER_TYPE.  Other modifier values leave the kind unset in the
   original; the port uses 0 (no caller passes one). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "protos.h"

#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)

u16 PTR_TYPE_FOR_MODIFIER(u16 node, i8 qualifier, u16 value, i8 second)
{
    u16 kind = 0;
    i16 mode = 0;
    switch (second) {
    case 1: case 2: case 3: case 4: case 5: case 6:
        mode = second;
        kind = 13;
        break;
    case 9: kind = 15; break;
    case 7: kind = 14; break;
    case 10: kind = 16; break;
    case 8:
        mode = TYPE_SC(node, TYPE_KIND) == TK_FUNCTION ? 2 : 4;
        kind = 13;
        break;
    case 0:
        if (TYPE_SC(node, TYPE_KIND) == TK_FUNCTION) {
            if (MODEL_FAR_CODE || (TYPE_SC(node, TYPE_C_FUNC_FLAGS) & 1))
                kind = 15;
            else {
                mode = 2;
                kind = 13;
            }
        } else if (MODEL_FAR_DATA)
            kind = 15;
        else {
            mode = 4;
            kind = 13;
        }
        break;
    }
    return NEW_POINTER_TYPE(node, (u8)kind, qualifier, value, mode);
}
