#ifndef INITTYPE_H
#define INITTYPE_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"

/* Original eight-byte bank descriptor; canonical segment scalars remain extern. */
struct C9Bank {
    unsigned int segment,spare,used,limit;
};

/* Real MZ record2 is resident0094; the original six-byte-argument RETF6 body. */
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);

/* New addresses whose actual native PUBLIC names are already occupied. */
/* Actual native PUBLIC ALLOC_LABEL_RECORD is unoccupied in the canonical namespace. */


/* Extern-only extension from the remaining original bodies. */
extern unsigned int SCOPE_POOL_SEG; /* Existing canonical DS782A arena selector. */
extern unsigned char OPTION_BLOCK; /* DS16EE */
extern unsigned char OPTION_MEMORY_MODEL; /* DS16EF */
extern unsigned char NEAR_HELPER_CALLS; /* DS16F1 */
extern unsigned char LANGUAGE_MODE; /* DS16F5 */
extern unsigned char UNSIGNED_CHAR; /* DS16F6 */
extern unsigned char OPTION_CALLING_CONVENTION; /* DS1705 */
extern unsigned char OPTION_UNDERSCORES; /* DS1716 */
extern unsigned char OPTION_FLAGS; /* DS1762 */
extern unsigned char OPTION_ENUMS_AS_INT; /* DS1764 */
extern unsigned int DEFAULT_CALL_CONVENTION; /* DS5EBC */
extern unsigned int FUNCTION_BODY_DEPTH; /* DS5EC0 */
extern unsigned int BCC_TREE_SPECIAL; /* DS5EDC */
extern unsigned int LOOP_CONTEXT; /* DS5EFD */
extern unsigned int DIAG_NAME_BUFFER; /* DS5F4E */
extern unsigned int TOKEN_RECORD_STREAM; /* DS6168 */
extern unsigned int TOKEN_STREAM_POS; /* DS617A */
extern unsigned int REPLAY_STREAM_1; /* DS6420 */
extern unsigned int FUNCTION_NAME_TEXT; /* DS66C0 */
extern unsigned char MODEL_FAR_CODE; /* DS77D1 */
extern unsigned int NAME_POOL_SEG; /* DS7832 */

extern unsigned int near C9_TYPE_GRID[2][2][13];
extern unsigned int far *BCC_TYPE_PTR;
struct C9Token {
    char near *name;
    unsigned int flags;
    signed char type;
    unsigned char reserved[2];
};
extern struct C9Token PSEUDO_REGISTER_TABLE[];
struct C9Intrinsic {
    char near *name;
    signed char result;
    unsigned char reserved3;
    signed char count;
    unsigned char reserved5;
    signed char parameters[4];
};
extern struct C9Intrinsic INTRINSIC_TABLE[];
struct C9TokenName { unsigned int name,token; };
extern struct C9TokenName C9_TOKEN_NAMES[];
extern struct C9TokenName far *C9_TOKEN_END;
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);

#endif
