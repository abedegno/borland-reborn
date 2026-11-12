/* target: CODE_32_RSTRCHR */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_STRCHR, STRING_FIND_CHAR. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's strchr (RTL_STRCHR) and strrchr
   (STRING_FIND_CHAR, despite its name the search from the end).  Both
   return a far pointer to the character found or NULL.  The character is
   tested before the terminator, so searching for 0 finds the terminator,
   as in standard strchr.  STRING_FIND_CHAR is called by DRVLINK;
   RTL_STRCHR has no caller in the sources. */
/* Segment 0AA0:0000..0086, Borland run-time library strchr and strrchr with
   pascal calling and far pointers (Turbo C 2.01).  strchr's scan is inline
   assembly (two characters per lodsw); on a match the asm leaves the result
   in DX:AX and the function falls off its end (documented fall-off-end
   policy: the value is in DX:AX, as in the original).
   RTL_STRCHR = strchr, STRING_FIND_CHAR = strrchr. */
#pragma inline
extern unsigned int far pascal STRING_LENGTH(char far *);

char far * far pascal RTL_STRCHR(char far *string,char c)
{
    asm push ds
    asm lds si,string
    asm mov bl,c
    /* lodsw loads two characters (AL first, then AH) and advances SI by 2. */
scan:
    asm lodsw
    asm cmp al,bl
    asm je low
    asm or al,al
    asm je none
    asm cmp ah,bl
    asm je high
    asm or ah,ah
    asm jne scan
none:
    asm pop ds
    return 0;
    /* Found in AL: the character is at SI-2.  Found in AH: at SI-1.  The
       result is DS:(SI-1) after the extra dec for the AL case. */
low:
    asm dec si
high:
    asm mov dx,ds
    asm mov ax,si
    asm dec ax
    asm pop ds
}

char far * far pascal STRING_FIND_CHAR(char far *string,char c)
{
    char far *p;
    p=string+STRING_LENGTH(string)-1;
    while(p>string) {
        if(*p==c) return p;
        p--;
    }
    /* For an empty string p is string-1 and this reads the byte before it,
       as the original does. */
    return *p==c ? p : 0;
}
