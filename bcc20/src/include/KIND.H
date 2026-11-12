/* KIND.H: type kinds (TYPE_KIND of a type, EXPR_KIND of a node's value).  The text
   after each is BCC's own name for the kind, from its type-name table
   (C33_TYPE_NAMES, DS:0BA9, indexed by kind).
   Generated during the readability pass. */
#ifndef KIND_H
#define KIND_H
#define TK_UNDEFINED 0x00 /* undefined */
#define TK_CHAR 0x01      /* char */
#define TK_UCHAR 0x02     /* unsigned char */
#define TK_SHORT 0x03     /* short */
#define TK_USHORT 0x04    /* unsigned short */
#define TK_INT 0x05       /* int */
#define TK_UINT 0x06      /* unsigned int */
#define TK_LONG 0x07      /* long */
#define TK_ULONG 0x08     /* unsigned long */
#define TK_FLOAT 0x09     /* float */
#define TK_DOUBLE 0x0A    /* double */
#define TK_LDOUBLE 0x0B   /* long double */
#define TK_VOID 0x0C      /* void */
#define TK_NEAR_PTR 0x0D  /* near */
#define TK_SEG_PTR 0x0E   /* _seg */
#define TK_FAR_PTR 0x0F   /* far */
#define TK_HUGE_PTR 0x10  /* huge */
#define TK_ARRAY 0x11     /* array [ */
#define TK_FUNCTION 0x12  /* function returning */
#define TK_STRUCT 0x13    /* struct */
#define TK_UNION 0x14     /* union */
#define TK_ENUM 0x15      /* enum */
#endif
