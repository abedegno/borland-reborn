/* target: CODE_20_RBSRCH */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: BCC_BINARY_SEARCH. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: BCC_BINARY_SEARCH is bsearch with pascal calling.  key is
   what to look for, base the sorted table of count elements of width bytes
   each, and compare a far pascal function returning <0, 0 or >0 for key
   against an element.  The search keeps a window of remaining elements
   starting at low; each probe looks at the middle element and keeps the
   lower or upper half.  Its caller is SCAN_ASM_TOKEN (parser/ASMSTMT.C),
   which looks up inline assembler mnemonics in ASM_KEYWORD_TABLE. */
/* Segment 0A72:0007..0079, bsearch, a binary search with pascal calling, used by the
   inline assembler's mnemonic lookup (overlay CO03C, parser/ASMSTMT.C;
   an earlier note said #pragma name lookup); Turbo C 2.01 like the rest of the
   run-time library.  Returns the matching element or NULL. */
void far * far pascal BCC_BINARY_SEARCH(void far *key,void far *base,int count,
    unsigned int width,int (far pascal *compare)(void far *key,void far *element))
{
    char far *low;
    char far *probe;
    int result;
    register int remaining;
    register int half;
    remaining=count;
    low=base;
    while(remaining>0) {
        half=remaining>>1;
        probe=low+half*width;
        if((result=compare(key,probe))==0) return probe;
        /* Key below the probe: keep the elements before it.  Otherwise
           keep the elements after it. */
        if(result<0) remaining=half;
        else {
            low=probe+width;
            remaining=remaining-half-1;
        }
    }
    return 0;
}
