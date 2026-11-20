   	     public  X03E_02
   	     public  X03E_03
   	     public  X03E_00
   	     public  X03E_01
   	     public  X03E_06
   	     public  X03E_07
   	     public  X03E_04
   	     public  X03E_05
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cce_8758
; BEGIN TREL (listing ovr_1cce_8758:7580)

        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   X019_05:far
        extrn   X023_04:far
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   X02C_1C:far
        extrn   X019_03:far
        extrn   BCC_NODE_NAMES:word


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_04
X03E_04 label   far
BCC_TYPE_RELATION	     proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     si,word ptr [bp+8]
        or	     si,si
        jne     short M000_@@CHECK_14
        jmp     M000_@@RETURN
M000_@@CHECK_14:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[si],14h
        jne     short M000_@@CHECK_13
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+2],0
        je	     short M000_@@CHECK_OP35
        jmp     M000_@@RETURN
M000_@@CHECK_OP35:
        cmp     word ptr [bp+6],35h
        je	     short M000_@@MEMBERS
        mov     ax,0EEh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M000_@@MEMBERS:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     di,word ptr es:[bx+2]
        push    si
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X023_04
        dw	     seg X023_04
        mov     word ptr [bp-2],ax
        jmp     short M000_@@TEST_MEMBER
M000_@@MEMBER:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        test    byte ptr es:[di+4],3
        jne     short M000_@@MEMBER_ERROR
        push    di
        push    word ptr [bp-2]
        db	     9Ah
        dw	     X02C_1C
        dw	     seg X02C_1C
        jmp     short M000_@@NEXT_MEMBER
M000_@@MEMBER_ERROR:
        mov     ax,112h
        push    ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        push    word ptr es:[di+2]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M000_@@NEXT_MEMBER:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     di,word ptr es:[di]
M000_@@TEST_MEMBER:
        or	     di,di
        jne     short M000_@@MEMBER
        jmp     short M000_@@RETURN
M000_@@CHECK_13:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[si],13h
        jne     short M000_@@BAD_RELATION
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+2],0
        jne     short M000_@@CHECK_OPS
        jmp     short M000_@@BAD_RELATION
M000_@@CHECK_OPS:
        cmp     word ptr [bp+6],36h
        je	     short M000_@@RETURN
        cmp     word ptr [bp+6],35h
        je	     short M000_@@RETURN
        cmp     word ptr [bp+6],82h
        je	     short M000_@@RETURN
        mov     ax,102h
        push    ax
        mov     bx,word ptr [bp+6]
        shl     bx,1
        push    word ptr DGROUP:BCC_NODE_NAMES[bx]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
        jmp     short M000_@@RETURN
M000_@@BAD_RELATION:
        mov     ax,0B3h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M000_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    4
BCC_TYPE_RELATION	     endp
CO03E_TEXT	     ends

; END TREL
; BEGIN TMETHOD (listing ovr_1cce_8758:7671)

        extrn   BCC_NODE_NAMES:word
        extrn   X019_03:far
        extrn   X02C_21:far
        extrn   X019_02:far
        extrn   X019_06:far
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   X00A_00:far
        extrn   BCC_EXPR_SEGMENT:word
        extrn   X02C_0E:far
        extrn   X02C_10:far
        extrn   BCC_RD_86C8_W:word
        extrn   X035_02:far
        extrn   X011_00:far
        extrn   X011_01:far
        extrn   BCC_MEMBER_HOOK:dword
        extrn   X00A_03:far
        extrn   X002_09:far
   	     extrn   X021_07:far
   	     extrn   X021_03:far
   	     extrn   X002_15:far
   	     extrn   X002_01:far


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_01
X03E_01 label   far
BCC_TYPE_METHOD proc    far
        push    bp
        mov     bp,sp
        sub     sp,6
        push    si
        push    di
        cmp     word ptr [bp+8],82h
        je	     short M001_@@FIND
        mov     ax,102h
        push    ax
        mov     bx,word ptr [bp+8]
        shl     bx,1
        push    word ptr DGROUP:BCC_NODE_NAMES[bx]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M001_@@FIND:
        push    word ptr [bp+10]
        push    word ptr [bp+12]
        db	     9Ah
        dw	     X02C_21
        dw	     seg X02C_21
        mov     di,ax
        or	     di,di
        jne     short M001_@@INSPECT
        mov     ax,0D1h
        push    ax
        push    word ptr [bp+10]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        push    word ptr [bp+12]
        db	     9Ah
        dw	     X021_07
        dw	     seg X021_07
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        jmp     short M001_@@HAVE_MEMBER
M001_@@INSPECT:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     al,byte ptr es:[di+4]
        mov     ah,0
        and     ax,3
        cmp     ax,2
        jne     short M001_@@BAD_MEMBER
        push    word ptr [bp+14]
        mov     bx,word ptr es:[di+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+4]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        mov     ah,0
        or	     ax,ax
        jne     short M001_@@HAVE_MEMBER
M001_@@BAD_MEMBER:
        mov     ax,0ADh
        push    ax
        push    word ptr [bp+10]
        xor     ax,ax
        push    ax
        push    word ptr [bp+14]
        push    word ptr [bp+12]
        db	     9Ah
        dw	     X021_03
        dw	     seg X021_03
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        xor     di,di
M001_@@HAVE_MEMBER:
        or	     di,di
        jne     short M001_@@METHOD
        jmp     M001_@@RETURN_ZERO
M001_@@METHOD:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     si,word ptr es:[di+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[bx],11h
        jne     short M001_@@NOT_SPECIAL
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        test    byte ptr es:[bx+2],40h
        je	     short M001_@@NOT_SPECIAL
        mov     ax,1
        jmp     short M001_@@SET_SPECIAL
M001_@@NOT_SPECIAL:
        xor     ax,ax
M001_@@SET_SPECIAL:
        mov     byte ptr [bp-3],al
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        and     al,7
        or	     al,8
        mov     byte ptr es:[si+7],al
        or	     byte ptr es:[si+6],1
        push    si
        db	     9Ah
        dw	     X02C_0E
        dw	     seg X02C_0E
        mov     word ptr [bp-2],ax
        push    word ptr [bp-2]
        mov     ax,80h
        push    ax
        db	     9Ah
        dw	     X02C_10
        dw	     seg X02C_10
        cmp     byte ptr [bp+6],0
        je	     short M001_@@NORMAL
        push    word ptr [bp-2]
        cmp     byte ptr [bp-3],0
        jne     short M001_@@SIZE
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        test    byte ptr es:[si+6],80h
        je	     short M001_@@OWNER
M001_@@SIZE:
        db	     9Ah
        dw	     X035_02
        dw	     seg X035_02
        jmp     short M001_@@EMIT_SIZE
M001_@@OWNER:
        mov     ax,word ptr DGROUP:BCC_RD_86C8_W
M001_@@EMIT_SIZE:
        push    ax
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_MEMBER_HOOK
        jmp     short M001_@@RETURN_VALUE
M001_@@NORMAL:
        cmp     byte ptr [bp-3],0
        je	     short M001_@@COPY
        push    word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[si+4]
        db	     9Ah
        dw	     X011_00
        dw	     seg X011_00
        push    ax
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_MEMBER_HOOK
        push    si
        db	     9Ah
        dw	     X011_01
        dw	     seg X011_01
        jmp     short M001_@@RETURN_VALUE
M001_@@COPY:
        push    word ptr [bp-2]
        push    word ptr DGROUP:BCC_RD_86C8_W
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_MEMBER_HOOK
        push    si
        db	     9Ah
        dw	     X002_15
        dw	     seg X002_15
        mov     word ptr [bp-6],ax
        push    word ptr [bp+14]
        db	     9Ah
        dw	     X00A_03
        dw	     seg X00A_03
        push    ax
        db	     9Ah
        dw	     X002_09
        dw	     seg X002_09
        push    word ptr [bp-6]
        db	     9Ah
        dw	     X002_01
        dw	     seg X002_01
M001_@@RETURN_VALUE:
        mov     ax,si
        jmp     short M001_@@RETURN
M001_@@RETURN_ZERO:
        xor     ax,ax
M001_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    10
BCC_TYPE_METHOD endp
CO03E_TEXT	     ends

; END TMETHOD
; BEGIN TLINK (listing ovr_1cce_8758:7804)

        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_LINK_SEGMENT:word
        extrn   X019_05:far


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_03
X03E_03 label   far
BCC_TYPE_LINK   proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     word ptr [bp-2],0
        mov     bx,word ptr [bp+6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     di,word ptr es:[bx+9]
        mov     bx,word ptr [bp+8]
        mov     si,word ptr es:[bx+9]
        jmp     M002_@@TEST
M002_@@ITEM:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        cmp     word ptr es:[di+8],0
        je	     short M002_@@CHECK_SEEN
        cmp     word ptr es:[si+8],0
        je	     short M002_@@CHECK_SEEN
        mov     ax,0A1h
M002_@@RAISE:
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M002_@@NEXT
M002_@@CHECK_SEEN:
        cmp     word ptr [bp-2],0
        je	     short M002_@@CHECK_EMPTY
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        cmp     word ptr es:[di+8],0
        jne     short M002_@@CHECK_EMPTY
        cmp     word ptr es:[si+8],0
        jne     short M002_@@CHECK_EMPTY
        mov     ax,7Ah
        jmp     short M002_@@RAISE
M002_@@CHECK_EMPTY:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        cmp     word ptr es:[di+8],0
        jne     short M002_@@SELECT
        cmp     word ptr es:[si+8],0
        je	     short M002_@@NEXT
M002_@@SELECT:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        cmp     word ptr es:[si+8],0
        je	     short M002_@@CHOOSE
        inc     word ptr [bp-2]
M002_@@CHOOSE:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        cmp     word ptr es:[di+8],0
        jne     short M002_@@FROM_LEFT
        mov     ax,word ptr es:[si+8]
        jmp     short M002_@@STORE
M002_@@FROM_LEFT:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     ax,word ptr es:[di+8]
M002_@@STORE:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     word ptr es:[si+8],ax
M002_@@NEXT:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     di,word ptr es:[di]
        mov     si,word ptr es:[si]
M002_@@TEST:
        or	     di,di
        je	     short M002_@@FINISH
        jmp     M002_@@ITEM
M002_@@FINISH:
        mov     bx,word ptr [bp+6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     al,80h
        and     al,byte ptr es:[bx+12]
        mov     bx,word ptr [bp+8]
        or	     byte ptr es:[bx+12],al
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    4
BCC_TYPE_LINK   endp
CO03E_TEXT	     ends

; END TLINK
; BEGIN TCOMP (listing ovr_1cce_8758:78CD)

        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_LINK_SEGMENT:word
        extrn   X00F_15:far
        extrn   BCC_EXPR_FLAGS:byte


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_00
X03E_00 label   far
BCC_TYPE_COMPARE	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        push    di
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     si,word ptr es:[bx+9]
        mov     bx,word ptr [bp+6]
        mov     di,word ptr es:[bx+9]
        mov     bx,word ptr [bp+8]
        mov     ax,word ptr es:[bx+3]
        mov     bx,word ptr [bp+6]
        cmp     ax,word ptr es:[bx+3]
        jne     short M003_@@ADJUST_LEFT
        jmp     M003_@@TEST
M003_@@ADJUST_LEFT:
        mov     bx,word ptr [bp+8]
        cmp     word ptr es:[bx+3],0
        jne     short M003_@@ADJUST_RIGHT
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     di,word ptr es:[di]
M003_@@ADJUST_RIGHT:
        mov     bx,word ptr [bp+6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[bx+3],0
        je	     short M003_@@SKIP_RIGHT
        jmp     M003_@@TEST
M003_@@SKIP_RIGHT:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     si,word ptr es:[si]
        jmp     M003_@@TEST
M003_@@ITEM:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     ax,word ptr es:[si+2]
        mov     word ptr [bp-2],ax
        mov     ax,word ptr es:[di+2]
        mov     word ptr [bp-4],ax
        push    word ptr [bp-2]
        push    word ptr [bp-4]
        db	     9Ah
        dw	     X00F_15
        dw	     seg X00F_15
        mov     ah,0
        or	     ax,ax
        jne     short M003_@@NEXT
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-2]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],3
        je	     short M003_@@REVERSE
        mov     bx,word ptr [bp-4]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],14h
        je	     short M003_@@REVERSE
        mov     bx,word ptr [bp-4]
        test    byte ptr es:[bx+2],20h
        je	     short M003_@@REVERSE
        push    word ptr [bp-2]
        push    word ptr es:[bx+7]
        db	     9Ah
        dw	     X00F_15
        dw	     seg X00F_15
        mov     ah,0
        or	     ax,ax
        jne     short M003_@@NEXT
M003_@@RETURN_ONE_EARLY:
        mov     al,1
        db	     0E9h
        dw	     0007Fh
M003_@@REVERSE:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-4]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],3
        je	     short M003_@@RETURN_ONE_LATE
        mov     bx,word ptr [bp-2]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],14h
        je	     short M003_@@RETURN_ONE_LATE
        mov     bx,word ptr [bp-2]
        test    byte ptr es:[bx+2],20h
        je	     short M003_@@RETURN_ONE_LATE
        push    word ptr [bp-4]
        push    word ptr es:[bx+7]
        db	     9Ah
        dw	     X00F_15
        dw	     seg X00F_15
        mov     ah,0
        or	     ax,ax
        jne     short M003_@@NEXT
M003_@@RETURN_ONE:
        jmp     short M003_@@RETURN_ONE_EARLY
M003_@@RETURN_ONE_LATE:
        jmp     short M003_@@RETURN_ONE_EARLY
M003_@@NEXT:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     si,word ptr es:[si]
        mov     di,word ptr es:[di]
M003_@@TEST:
        or	     si,si
        je	     short M003_@@FINISH
        or	     di,di
        je	     short M003_@@FINISH
        jmp     M003_@@ITEM
M003_@@FINISH:
        cmp     si,di
        jne     short M003_@@DIFFERENT
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     al,byte ptr es:[bx+12]
        mov     ah,0
        and     ax,4
        mov     bx,word ptr [bp+6]
        mov     dl,byte ptr es:[bx+12]
        mov     dh,0
        db	     81h,0E2h,04h,00h
        cmp     ax,dx
        je	     short M003_@@SAME
M003_@@DIFFERENT:
        mov     ax,1
        jmp     short M003_@@RETURN
M003_@@SAME:
        xor     ax,ax
M003_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    4
BCC_TYPE_COMPARE	     endp
CO03E_TEXT	     ends

; END TCOMP
; BEGIN TMATCH (listing ovr_1cce_8758:7A0F)

        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_RD_63BA_W:word
        extrn   X019_05:far
        extrn   X00A_00:far
        extrn   X021_09:far
        extrn   X021_05:far
        extrn   X019_06:far
        extrn   X021_01:far
        extrn   BCC_RD_6398_W:word
        extrn   BCC_PARSE_HANDLE:word


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_06
X03E_06 label   far
BCC_TYPE_MATCH  proc    far
        push    bp
        mov     bp,sp
        sub     sp,6
        push    si
        push    di
        mov     di,word ptr [bp+16]
        or	     di,di
        je	     short M004_@@NO_INITIAL
        mov     ax,1
        jmp     short M004_@@SET_INITIAL
M004_@@NO_INITIAL:
        xor     ax,ax
M004_@@SET_INITIAL:
        mov     byte ptr [bp-5],al
        mov     byte ptr [bp-3],0
        mov     si,word ptr [bp+18]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[si+15],2
        jne     short M004_@@NOT_MODE2
        mov     ax,1
        jmp     short M004_@@SET_MODE
M004_@@NOT_MODE2:
        xor     ax,ax
M004_@@SET_MODE:
        mov     byte ptr [bp-4],al
        mov     bx,word ptr [bp+18]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+2]
        cmp     ax,word ptr DGROUP:BCC_RD_63BA_W
        je	     short M004_@@CHECK_FLAGS
        jmp     M004_@@TEST
M004_@@CHECK_FLAGS:
        mov     al,byte ptr es:[bx+6]
        mov     ah,0
        test    ax,10h
        je	     short M004_@@BAD_INITIAL
        jmp     M004_@@TEST
M004_@@BAD_INITIAL:
        les     bx,dword ptr [bp+6]
        mov     byte ptr es:[bx],0
        mov     ax,117h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     M004_@@RETURN
M004_@@CANDIDATE:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[si+4]
        mov     word ptr [bp-2],ax
        push    word ptr [bp-2]
        push    di
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        or	     al,al
        je	     short M004_@@CHECK_MODE
        mov     byte ptr [bp-3],1
        les     bx,dword ptr [bp+10]
        mov     word ptr es:[bx],si
        mov     byte ptr [bp-5],1
        jmp     short M004_@@NEXT
M004_@@CHECK_MODE:
        cmp     word ptr [bp+14],2
        jne     short M004_@@COMPARE
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[si+17],2
        jne     short M004_@@COMPARE
        mov     ax,94h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M004_@@COMPARE:
        mov     al,byte ptr [bp-4]
        mov     ah,0
        or	     ax,ax
        jne     short M004_@@MATCHED
        push    word ptr [bp-2]
        push    di
        push    cs
        db	     0E8h,0FEh,0FDh
        mov     byte ptr [bp-5],al
M004_@@MATCHED:
        mov     al,byte ptr [bp-5]
        mov     ah,0
        or	     ax,ax
        jne     short M004_@@NEXT
        mov     ax,66h
        push    ax
        push    si
        push    di
        db	     9Ah
        dw	     X021_09
        dw	     seg X021_09
        push    dx
        push    ax
        push    si
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M004_@@NEXT:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     si,word ptr es:[si+19]
M004_@@TEST:
        cmp     byte ptr [bp-5],0
        je	     short M004_@@FINISH_SEARCH
        or	     si,si
        je	     short M004_@@FINISH_SEARCH
        jmp     M004_@@CANDIDATE
M004_@@FINISH_SEARCH:
        cmp     byte ptr [bp-5],0
        jne     short M004_@@CHECK_FOUND
        jmp     M004_@@STORE_RESULT
M004_@@CHECK_FOUND:
        cmp     byte ptr [bp-3],0
        jne     short M004_@@VALIDATE
        jmp     M004_@@STORE_RESULT
M004_@@VALIDATE:
        les     bx,dword ptr [bp+10]
        mov     bx,word ptr es:[bx]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+4]
        mov     word ptr [bp-2],ax
        cmp     word ptr [bp+14],0
        je	     short M004_@@CHECK_MODE_FLAG
        les     bx,dword ptr [bp+10]
        mov     bx,word ptr es:[bx]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+17]
        cmp     ax,word ptr [bp+14]
        je	     short M004_@@CHECK_MODE_FLAG
        mov     ax,81h
        push    ax
        les     bx,dword ptr [bp+10]
        push    word ptr es:[bx]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        les     bx,dword ptr [bp+10]
        mov     bx,word ptr es:[bx]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+17]
        db	     9Ah
        dw	     X021_01
        dw	     seg X021_01
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M004_@@CHECK_MODE_FLAG:
        cmp     byte ptr [bp-4],0
        je	     short M004_@@CHECK_UPDATE
        mov     ax,0ADh
        push    ax
        les     bx,dword ptr [bp+10]
        push    word ptr es:[bx]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M004_@@CHECK_UPDATE:
        les     bx,dword ptr [bp+10]
        mov     bx,word ptr es:[bx]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[bx+6]
        mov     ah,0
        test    ax,2
        jne     short M004_@@COMPARE_LINKS
        mov     ax,word ptr DGROUP:BCC_RD_6398_W
        cmp     ax,word ptr DGROUP:BCC_PARSE_HANDLE
        jne     short M004_@@COMPARE_LINKS
        les     bx,dword ptr [bp+10]
        mov     bx,word ptr es:[bx]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[bx+4],di
M004_@@COMPARE_LINKS:
        cmp     di,word ptr [bp-2]
        je	     short M004_@@SUCCESS
        push    di
        push    word ptr [bp-2]
        push    cs
        db	     0E8h,038h,0FCh
M004_@@SUCCESS:
        mov     byte ptr [bp-5],0
M004_@@STORE_RESULT:
        les     bx,dword ptr [bp+6]
        mov     al,byte ptr [bp-5]
        mov     byte ptr es:[bx],al
M004_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    14
BCC_TYPE_MATCH  endp
CO03E_TEXT	     ends

; END TMATCH
; BEGIN TVALID (listing ovr_1cce_8758:7BE1)

        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_LINK_SEGMENT:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_RD_629E_W:word
        extrn   BCC_TYPE_CURRENT:word
        extrn   BCC_EXPR_FLAGS:byte
        extrn   X02C_12:far
        extrn   X019_05:far
        extrn   X00A_00:far
        extrn   X021_05:far
        extrn   X019_06:far
        extrn   X00A_01:far


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_05
X03E_05 label   far
BCC_TYPE_VALIDATE	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,8
        push    si
        push    di
        mov     di,word ptr [bp+6]
        mov     word ptr [bp-4],0
        mov     byte ptr [bp-8],0
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+15],2
        je	     short M005_@@INITIAL_DONE
        db	     26h,81h,4Fh,0Ah,01h,00h
M005_@@INITIAL_DONE:
        mov     word ptr [bp-2],0
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     si,word ptr es:[di+9]
        jmp     short M005_@@COUNT_TEST
M005_@@COUNT_ITEM:
        inc     word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     si,word ptr es:[si]
M005_@@COUNT_TEST:
        or	     si,si
        jne     short M005_@@COUNT_ITEM
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+15],4
        jne     short M005_@@COUNT_DONE
        dec     word ptr [bp-2]
M005_@@COUNT_DONE:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[di+3],0
        je	     short M005_@@NO_RESULT_TYPE
        mov     ax,1
        jmp     short M005_@@RESULT_TYPE_DONE
M005_@@NO_RESULT_TYPE:
        xor     ax,ax
M005_@@RESULT_TYPE_DONE:
        mov     byte ptr [bp-7],al
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X02C_12
        dw	     seg X02C_12
        dec     ax
        mov     bx,ax
        cmp     bx,6Bh
        jbe     short M005_@@DISPATCH
        db	     0E9h
        dw	     00233h
M005_@@DISPATCH:
        shl     bx,1
        db	     2Eh,0FFh,0A7h,48h,0Ah

M005_@@CASE_FIRST:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+7]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],14h
        je	     short M005_@@FIRST_BAD_TYPE
        mov     bx,word ptr es:[di+7]
        mov     bx,word ptr es:[bx+7]
        cmp     word ptr es:[bx],0Ch
        je	     short M005_@@FIRST_CHECK_COUNT
M005_@@FIRST_BAD_TYPE:
        mov     ax,8Fh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M005_@@FIRST_CHECK_COUNT:
        cmp     word ptr [bp-2],0
        jne     short M005_@@FIRST_ARGUMENTS
        mov     ax,91h
        push    ax
        push    ds
        mov     ax,3308h
        db	     0E9h
        dw	     0030Ch
M005_@@FIRST_ARGUMENTS:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     si,word ptr es:[di+9]
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        push    word ptr es:[si+2]
        push    word ptr DGROUP:BCC_TYPE_CURRENT
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        mov     ah,0
        or	     ax,ax
        je	     short M005_@@FIRST_FAILED
        db	     0E9h
        dw	     002F2h
M005_@@FIRST_FAILED:
        mov     ax,8Eh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     0E9h
        dw	     002E6h
M005_@@CASE_SECOND:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr es:[di+7]
        cmp     ax,word ptr DGROUP:BCC_RD_629E_W
        je	     short M005_@@SECOND_CHECK_COUNT
        mov     ax,7Ch
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M005_@@SECOND_CHECK_COUNT:
        cmp     word ptr [bp-2],0
        je	     short M005_@@SECOND_BAD_COUNT
        cmp     word ptr [bp-2],2
        jle     short M005_@@SECOND_ARGUMENTS
M005_@@SECOND_BAD_COUNT:
        mov     ax,91h
        push    ax
        push    ds
        mov     ax,3315h
        db	     0E9h
        dw	     002ACh
M005_@@SECOND_ARGUMENTS:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     si,word ptr es:[di+9]
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],14h
        je	     short M005_@@SECOND_FAILED
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+7]
        cmp     word ptr es:[bx],0Ch
        jne     short M005_@@SECOND_FAILED
        cmp     word ptr [bp-2],2
        je	     short M005_@@SECOND_PAIR
        db	     0E9h
        dw	     0027Bh
M005_@@SECOND_PAIR:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     bx,word ptr es:[si]
        push    word ptr es:[bx+2]
        push    word ptr DGROUP:BCC_TYPE_CURRENT
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        mov     ah,0
        or	     ax,ax
        je	     short M005_@@SECOND_FAILED
        db	     0E9h
        dw	     0025Ah
M005_@@SECOND_FAILED:
        mov     ax,7Bh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     0E9h
        dw	     0024Eh
M005_@@CASE_FLAG_ONLY:
        mov     byte ptr [bp-8],1
        db	     0E9h
        dw	     00121h
M005_@@CASE_CONVERT:
        mov     byte ptr [bp-8],1
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+9]
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     si,word ptr es:[bx]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+3]
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],4
        je	     short M005_@@CONVERT_HAVE_LINK
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     si,word ptr es:[si]
M005_@@CONVERT_HAVE_LINK:
        or	     si,si
        jne     short M005_@@CONVERT_CHECK_LINK
        db	     0E9h
        dw	     000E8h
M005_@@CONVERT_CHECK_LINK:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        cmp     word ptr es:[si],0
        je	     short M005_@@CONVERT_TEST
        mov     bx,word ptr es:[si]
        cmp     word ptr es:[bx+8],0
        jne     short M005_@@CONVERT_TEST
        db	     0E9h
        dw	     000D1h
M005_@@CONVERT_TEST:
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        push    word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        push    word ptr es:[di+3]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        or	     al,al
        jne     short M005_@@CONVERT_DO
        db	     0E9h
        dw	     000B1h
M005_@@CONVERT_DO:
        mov     ax,0A0h
        push    ax
        push    word ptr [bp+8]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        push    word ptr es:[si+2]
        xor     ax,ax
        push    ax
        mov     al,1
        push    ax
        db	     9Ah
        dw	     X00A_01
        dw	     seg X00A_01
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     word ptr es:[si+2],ax
        jmp     short M005_@@DISPATCH_DONE

M005_@@CASE_QUALIFY:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+7]
        mov     bx,word ptr es:[bx]
        mov     al,byte ptr DGROUP:BCC_EXPR_FLAGS[bx]
        mov     ah,0
        test    ax,40h
        jne     short M005_@@QUALIFY_VALID
        mov     bx,word ptr es:[di+7]
        mov     bx,word ptr es:[bx]
        mov     al,byte ptr DGROUP:BCC_EXPR_FLAGS[bx]
        mov     ah,0
        test    ax,14h
        jne     short M005_@@QUALIFY_VALID
        mov     ax,6Ch
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M005_@@QUALIFY_VALID:
        mov     byte ptr [bp-8],1
        jmp     short M005_@@MODE_ONE
M005_@@CASE_QUALIFY_RETRY:
        jmp     short M005_@@QUALIFY_VALID
M005_@@CASE_MODE_TWO:
        mov     byte ptr [bp-8],1
        jmp     short M005_@@MODE_TWO
M005_@@MODE_ONE:
        mov     word ptr [bp-4],1
        jmp     short M005_@@DISPATCH_DONE
M005_@@MODE_TWO:
        mov     word ptr [bp-4],2
        jmp     short M005_@@DISPATCH_DONE

M005_@@CASE_SELECT_MODE:
        cmp     byte ptr [bp-7],0
        je	     short M005_@@SELECT_CHECK_SINGLE
        cmp     word ptr [bp-2],0
        je	     short M005_@@SELECT_USE_COUNT
M005_@@SELECT_CHECK_SINGLE:
        cmp     word ptr [bp-2],1
        je	     short M005_@@SELECT_USE_COUNT
        mov     al,byte ptr [bp-7]
        mov     ah,0
        or	     ax,ax
        jne     short M005_@@SELECT_TWO
        cmp     word ptr [bp-2],2
        jne     short M005_@@SELECT_TWO
M005_@@SELECT_USE_COUNT:
        mov     ax,word ptr [bp-2]
        mov     word ptr [bp-4],ax
        jmp     short M005_@@DISPATCH_DONE
M005_@@SELECT_TWO:
        mov     word ptr [bp-4],2

M005_@@DISPATCH_DONE:
        cmp     byte ptr [bp-8],0
        je	     short M005_@@CHECK_MODE
        mov     al,byte ptr [bp-7]
        mov     ah,0
        or	     ax,ax
        jne     short M005_@@CHECK_MODE
        mov     ax,0C0h
        push    ax
        push    word ptr [bp+8]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M005_@@CHECK_MODE:
        cmp     word ptr [bp-4],0
        je	     short M005_@@CHECK_ARGUMENTS
        mov     ax,word ptr [bp-4]
        cmp     ax,word ptr [bp-2]
        jne     short M005_@@MODE_DIAGNOSTIC
        cmp     word ptr [bp-4],2
        jle     short M005_@@CHECK_ARGUMENTS
M005_@@MODE_DIAGNOSTIC:
        cmp     word ptr [bp-4],1
        jne     short M005_@@DIAGNOSTIC_OTHER
        cmp     byte ptr [bp-7],0
        je	     short M005_@@DIAGNOSTIC_OTHER
        mov     ax,90h
        jmp     short M005_@@DIAGNOSTIC_RAISE
M005_@@DIAGNOSTIC_OTHER:
        cmp     word ptr [bp-4],1
        je	     short M005_@@DIAGNOSTIC_COUNT
        cmp     byte ptr [bp-7],0
        je	     short M005_@@DIAGNOSTIC_INVALID
        cmp     word ptr [bp-4],2
        jne     short M005_@@DIAGNOSTIC_INVALID
M005_@@DIAGNOSTIC_COUNT:
        mov     ax,91h
        jmp     short M005_@@DIAGNOSTIC_RAISE
M005_@@DIAGNOSTIC_INVALID:
        mov     ax,92h
M005_@@DIAGNOSTIC_RAISE:
        push    ax
        push    word ptr [bp+8]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06

M005_@@CHECK_ARGUMENTS:
        cmp     word ptr [bp-2],0
        jg	     short M005_@@ARGUMENT_BEGIN
        db	     0E9h
        dw	     000A0h
M005_@@ARGUMENT_BEGIN:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     si,word ptr es:[di+9]
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     ax,word ptr es:[si+2]
        mov     word ptr [bp-6],ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-6]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],14h
        je	     short M005_@@ARGUMENT_FIRST_DONE
        mov     bx,word ptr [bp-6]
        mov     ax,word ptr es:[bx+7]
        mov     word ptr [bp-6],ax
M005_@@ARGUMENT_FIRST_DONE:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-6]
        mov     bx,word ptr es:[bx]
        mov     al,byte ptr DGROUP:BCC_EXPR_FLAGS[bx]
        mov     ah,0
        test    ax,40h
        jne     short M005_@@ARGUMENT_FINAL
        cmp     word ptr [bp-2],1
        jle     short M005_@@ARGUMENT_FINAL
        mov     es,word ptr DGROUP:BCC_LINK_SEGMENT
        mov     si,word ptr es:[si]
        mov     ax,word ptr es:[si+2]
        mov     word ptr [bp-6],ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-6]
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],14h
        je	     short M005_@@ARGUMENT_FINAL
        mov     bx,word ptr [bp-6]
        mov     ax,word ptr es:[bx+7]
        mov     word ptr [bp-6],ax
M005_@@ARGUMENT_FINAL:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-6]
        mov     bx,word ptr es:[bx]
        mov     al,byte ptr DGROUP:BCC_EXPR_FLAGS[bx]
        mov     ah,0
        test    ax,40h
        jne     short M005_@@RETURN
        mov     ax,93h
        push    ax
        push    word ptr [bp+8]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
M005_@@RAISE_NODE:
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M005_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    4
BCC_TYPE_VALIDATE	     endp
CO03E_TEXT	     ends

; END TVALID
; BEGIN LG0B4 (gap	ovr_1cce_8758:7FC8)
CO03E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO03E_TEXT
; Original-image layout stub: not recovered source


   	     db	     0F2h,007h,01Ah,009h,0F2h,007h,01Ah,009h,0F9h,007h,0D6h,008h,01Ah,009h  ; ovr_1cce_8758:7FC8
   	     db	     0E5h,008h,01Ah,009h,01Ah,009h,0D8h,008h,0E5h,008h,0E5h,008h,0E5h,008h  ; ovr_1cce_8758:7FD6
   	     db	     0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h  ; ovr_1cce_8758:7FE4
   	     db	     0ECh,008h,0ECh,008h,0ECh,008h,0E5h,008h,0E5h,008h,0ECh,008h,0E5h,008h  ; ovr_1cce_8758:7FF2
   	     db	     0E5h,008h,0E5h,008h,0E5h,008h,01Ah,009h,01Ah,009h,0E5h,008h,0E5h,008h  ; ovr_1cce_8758:8000
   	     db	     0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h,0E5h,008h,0ECh,008h  ; ovr_1cce_8758:800E
   	     db	     0DEh,008h,01Ah,009h,0DEh,008h,0DEh,008h,01Ah,009h,09Fh,008h,01Ah,009h  ; ovr_1cce_8758:801C
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,0D6h,008h,01Ah,009h  ; ovr_1cce_8758:802A
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h  ; ovr_1cce_8758:8038
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h  ; ovr_1cce_8758:8046
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h  ; ovr_1cce_8758:8054
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h  ; ovr_1cce_8758:8062
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h  ; ovr_1cce_8758:8070
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h,01Ah,009h  ; ovr_1cce_8758:807E
   	     db	     01Ah,009h,01Ah,009h,01Ah,009h,0E5h,008h,01Ah,009h,01Ah,009h,05Ah,007h  ; ovr_1cce_8758:808C
   	     db	     01Ah,009h,01Ah,009h,0EEh,006h   ; ovr_1cce_8758:809A

CO03E_TEXT	     ends
; END LG0B4
; BEGIN TBIND (listing ovr_1cce_8758:80A0)

        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   BCC_TYPE_DEFAULT_SCOPE:word
        extrn   X02C_22:far
        extrn   X02C_21:far
        extrn   X021_03:far
        extrn   X021_07:far
        extrn   X019_06:far
        extrn   X00A_00:far
        extrn   X00F_16:far
        extrn   X000_01:far


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_07
X03E_07 label   far
BCC_TYPE_BIND   proc    far
        push    bp
        mov     bp,sp
        sub     sp,8
        push    si
        push    di
        mov     di,word ptr [bp+12]
        mov     si,word ptr [bp+10]
        push    word ptr [bp+8]
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     word ptr [bp-4],ax
        cmp     word ptr [bp-4],0
        je	     short M007_@@FIND_MEMBER
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[bx+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,0Bh
        jne     short M007_@@FIND_MEMBER
        cmp     word ptr es:[bx+4],di
        jne     short M007_@@FIND_MEMBER
        mov     word ptr [bp+6],3
        mov     ax,word ptr DGROUP:BCC_TYPE_DEFAULT_SCOPE
        mov     word ptr [bp+8],ax
M007_@@FIND_MEMBER:
        push    word ptr [bp+8]
        push    di
        db	     9Ah
        dw	     X02C_21
        dw	     seg X02C_21
        mov     word ptr [bp-6],ax
        mov     word ptr [bp-4],0
        cmp     word ptr [bp-6],0
        jne     short M007_@@INSPECT_MEMBER
M007_@@MISSING_MEMBER:
        mov     ax,0D1h
        push    ax
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        push    si
        push    di
        db	     9Ah
        dw	     X021_03
        dw	     seg X021_03
        push    dx
        push    ax
        push    di
        db	     9Ah
        dw	     X021_07
        dw	     seg X021_07
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        db	     0E9h
        dw	     00160h
M007_@@INSPECT_MEMBER:
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     al,byte ptr es:[bx+4]
        mov     ah,0
        and     ax,3
        cmp     ax,3
        je	     short M007_@@MEMBER_KIND_OK
        db	     0E9h
        dw	     0011Ah
M007_@@MEMBER_KIND_OK:
        mov     ax,word ptr es:[bx+6]
        mov     word ptr [bp-4],ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[4],si
        jmp     short M007_@@SEARCH1_TEST
M007_@@SEARCH1_NEXT:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+19]
        mov     word ptr [bp-4],ax
M007_@@SEARCH1_TEST:
        push    si
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+4]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        mov     ah,0
        or	     ax,ax
        je	     short M007_@@SEARCH1_NEXT
        cmp     word ptr [bp-4],0
        jne     short M007_@@AFTER_RECONCILE
        push    di
        push    si
        db	     9Ah
        dw	     X00F_16
        dw	     seg X00F_16
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     ax,word ptr es:[bx+6]
        mov     word ptr [bp-4],ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[4],si
        jmp     short M007_@@SEARCH2_TEST
M007_@@SEARCH2_NEXT:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+19]
        mov     word ptr [bp-4],ax
M007_@@SEARCH2_TEST:
        push    si
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+4]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        mov     ah,0
        or	     ax,ax
        je	     short M007_@@SEARCH2_NEXT
M007_@@AFTER_RECONCILE:
        cmp     word ptr [bp-4],0
        je	     short M007_@@SPECIAL_FLAGS
        db	     0E9h
        dw	     0008Ch
M007_@@SPECIAL_FLAGS:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],800h
        je	     short M007_@@SELECTED
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        test    byte ptr es:[si+12],40h
        je	     short M007_@@SELECTED
        and     byte ptr es:[si+12],0BFh
        or	     byte ptr es:[si+12],1
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     ax,word ptr es:[bx+6]
        mov     word ptr [bp-4],ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[4],si
        jmp     short M007_@@SEARCH3_TEST
M007_@@SEARCH3_NEXT:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+19]
        mov     word ptr [bp-4],ax
M007_@@SEARCH3_TEST:
        push    si
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+4]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X00A_00
        dw	     seg X00A_00
        mov     ah,0
        or	     ax,ax
        je	     short M007_@@SEARCH3_NEXT
        cmp     word ptr [bp-4],0
        je	     short M007_@@SELECTED
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        test    word ptr es:[bx+10],100h
        jne     short M007_@@SELECTED
        mov     word ptr [bp-4],0
        jmp     short M007_@@SELECTED
M007_@@CLEAR_RESULT:
        mov     word ptr [bp-4],0
M007_@@SELECTED:
        cmp     word ptr [bp-4],0
        jne     short M007_@@HAVE_RESULT
        db	     0E9h
        dw	     0FE9Dh
M007_@@HAVE_RESULT:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+4],si
        je	     short M007_@@FINISH
        mov     ax,word ptr es:[bx+4]
        mov     word ptr [bp-2],ax
        mov     word ptr es:[bx+4],si
        push    si
        push    word ptr [bp-2]
        push    cs
        db	     0E8h,082h,0F5h
M007_@@FINISH:
        cmp     word ptr [bp-4],0
        jne     short M007_@@RETURN
        push    si
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        mov     ax,36h
        push    ax
        push    ss
        lea     ax,[bp-4]
        push    ax
        push    ss
        lea     ax,[bp-7]
        push    ax
        db	     9Ah
        dw	     X000_01
        dw	     seg X000_01
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     ax,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr [bp-4]
        mov     word ptr es:[bx],ax
        or	     byte ptr es:[bx+6],10h
        db	     26h,81h,4Fh,0Ah,01h,00h
M007_@@RETURN:
        mov     ax,word ptr [bp-4]
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    8
BCC_TYPE_BIND   endp
CO03E_TEXT	     ends

; END TBIND
; BEGIN TNORM (listing ovr_1cce_8758:82D2)

        extrn   BCC_TYPE_ACTIVE:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_RD_629E_W:word
        extrn   X02C_22:far
        extrn   X00F_24:far
        extrn   X019_03:far
        extrn   X00A_01:far


CO03E_TEXT	     segment byte public 'CODE'
        assume  cs:CO03E_TEXT,ds:DGROUP

   	     public  X03E_02
X03E_02 label   far
BCC_TYPE_NORMALIZE	     proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     di,word ptr [bp+14]
        mov     ax,word ptr [bp+16]
        mov     word ptr DGROUP:BCC_TYPE_ACTIVE,ax
        les     bx,dword ptr [bp+8]
        cmp     word ptr es:[bx],0
        jne     short M008_@@CHECK_KIND
        push    word ptr [bp+12]
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     si,ax
        or	     si,si
        je	     short M008_@@CHECK_KIND
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,0Bh
        jne     short M008_@@CHECK_KIND
        mov     ax,word ptr es:[si+4]
        cmp     ax,word ptr DGROUP:BCC_TYPE_ACTIVE
        jne     short M008_@@CHECK_KIND
        les     bx,dword ptr [bp+8]
        mov     word ptr es:[bx],3
M008_@@CHECK_KIND:
        les     bx,dword ptr [bp+8]
        cmp     word ptr es:[bx],3
        jne     short M008_@@CHECK_FOUR
        mov     bx,word ptr [bp+16]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],4
        je	     short M008_@@CHECK_FLAG
        push    di
        mov     ax,73h
        push    ax
        db	     9Ah
        dw	     X00F_24
        dw	     seg X00F_24
M008_@@CHECK_FLAG:
        mov     al,byte ptr [bp+6]
        mov     ah,0
        or	     ax,ax
        jne     short M008_@@COERCE
        mov     ax,76h
        push    ax
        push    word ptr [bp+12]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M008_@@COERCE:
        push    word ptr DGROUP:BCC_TYPE_ACTIVE
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X00A_01
        dw	     seg X00A_01
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     word ptr es:[di+7],ax
        jmp     short M008_@@RETURN
M008_@@CHECK_FOUR:
        les     bx,dword ptr [bp+8]
        cmp     word ptr es:[bx],4
        jne     short M008_@@RETURN
        mov     al,byte ptr [bp+6]
        mov     ah,0
        or	     ax,ax
        jne     short M008_@@USE_DEFAULT
        mov     ax,7Eh
        push    ax
        push    word ptr [bp+12]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M008_@@USE_DEFAULT:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_629E_W
        mov     word ptr es:[di+7],ax
        push    di
        mov     ax,69h
        push    ax
        db	     9Ah
        dw	     X00F_24
        dw	     seg X00F_24
M008_@@RETURN:
        pop     di
        pop     si
        pop     bp
        retf    12
BCC_TYPE_NORMALIZE	     endp
CO03E_TEXT	     ends

; END TNORM
   	     end
