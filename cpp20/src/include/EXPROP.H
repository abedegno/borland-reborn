/* EXPROP.H: expression operators (EXPR_OP of a node).  Each name is the token
   BCC prints for the operator, from its table C18_OPERATOR_TOKENS (operator
   -> token, used by BCC's CPPCALL for diagnostics); where two operators print the same
   token the unary one says so.  Operators without a name are still literals.
   Generated during the readability pass. */
#ifndef EXPROP_H
#define EXPROP_H
#define EOP_CONST 0x02        /* constant (the folder looks for it as a constant operand) */
#define EOP_ADD 0x08          /* + */
#define EOP_SUB 0x09          /* - */
#define EOP_MUL 0x0A          /* * */
#define EOP_DIV 0x0B          /* / */
#define EOP_MOD 0x0C          /* % */
#define EOP_SHL 0x0D          /* << */
#define EOP_SHR 0x0E          /* >> */
#define EOP_AND 0x0F          /* & */
#define EOP_OR 0x10           /* | */
#define EOP_XOR 0x11          /* ^ */
#define EOP_ASSIGN 0x12       /* = */
#define EOP_ADD_ASSIGN 0x13   /* += */
#define EOP_SUB_ASSIGN 0x14   /* -= */
#define EOP_MUL_ASSIGN 0x15   /* *= */
#define EOP_DIV_ASSIGN 0x16   /* /= */
#define EOP_MOD_ASSIGN 0x17   /* %= */
#define EOP_SHL_ASSIGN 0x18   /* <<= */
#define EOP_SHR_ASSIGN 0x19   /* >>= */
#define EOP_AND_ASSIGN 0x1A   /* &= */
#define EOP_OR_ASSIGN 0x1B    /* |= */
#define EOP_XOR_ASSIGN 0x1C   /* ^= */
#define EOP_EQ 0x1D           /* == */
#define EOP_NE 0x1E           /* != */
#define EOP_GT 0x1F           /* > */
#define EOP_LT 0x20           /* < */
#define EOP_GE 0x21           /* >= */
#define EOP_LE 0x22           /* <= */
#define EOP_POSTINC 0x23      /* x++ (GENERATE_POST_INCREMENT; helper STR_PINA; C mode turns it into +=) */
#define EOP_POSTDEC 0x24      /* x-- (GENERATE_POST_DECREMENT; helper STR_PDEA; C mode turns it into -=) */
#define EOP_QUESTION 0x25     /* ? */
#define EOP_COLON 0x26        /* : */
#define EOP_ANDAND 0x27       /* && */
#define EOP_OROR 0x28         /* || */
#define EOP_COMMA 0x2A        /* , */
#define EOP_NEG 0x2E          /* - (unary) */
#define EOP_COMPL 0x2F        /* ~ */
#define EOP_NOT 0x30          /* ! */
#define EOP_DEREF 0x31        /* * (unary) */
#define EOP_ADDR 0x32         /* & (unary) */
#define EOP_INDEX 0x3A        /* [] */
#define EOP_DOT 0x3B          /* . */
#define EOP_DOT_STAR 0x3C     /* .* */
#define EOP_ARROW 0x3D        /* -> */
#define EOP_ARROW_STAR 0x3E   /* ->* */
#define EOP_INC 0x3F          /* ++ */
#define EOP_DEC 0x40          /* -- */
#define EOP_NEW 0x41          /* new */
#define EOP_DELETE 0x43       /* delete */
#define EOP_SIZEOF 0x44       /* sizeof */
#endif
