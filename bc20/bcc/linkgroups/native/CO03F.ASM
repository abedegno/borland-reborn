; Recovered FBOV far-pointer references
CO00A_TEXT	     segment byte public 'CODE'
CO00A_TEXT	     ends
   	     public  X03F_0B
   	     public  X03F_0C
   	     public  X03F_0A
   	     public  X03F_0F
   	     public  X03F_0E
   	     public  X03F_0D
   	     public  X03F_09
   	     public  X03F_08
   	     public  X03F_03
   	     public  X03F_02
   	     public  X03F_01
   	     public  X03F_00
   	     public  X03F_07
   	     public  X03F_06
   	     public  X03F_05
   	     public  X03F_04
   	     public  X03F_13
   	     public  X03F_12
   	     public  X03F_11
   	     public  X03F_10
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cd3_883b
; BEGIN PSTATE (listing ovr_1cd3_883b:83B0)

        extrn   X01C_07:far
        extrn   X01C_02:far
        extrn   X01E_04:far
        extrn   X01C_04:far
        extrn   BCC_RD_C23E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_02
X03F_02 label   far
BCC_RF_8000_83B0	     proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        mov     byte ptr [bp-1],0
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X01C_07
        dw	     seg X01C_07
        or	     al,al
        je	     short M000_@@RETURN
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X01C_02
        dw	     seg X01C_02
        cmp     word ptr DGROUP:BCC_RD_C23E_W,1
        jne     short M000_@@POP
        db	     9Ah
        dw	     X01E_04
        dw	     seg X01E_04
        mov     byte ptr [bp-1],al
M000_@@POP:
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X01C_04
        dw	     seg X01C_04
M000_@@RETURN:
        mov     al,byte ptr [bp-1]
        mov     sp,bp
        pop     bp
        retf
BCC_RF_8000_83B0	     endp
CO03F_TEXT	     ends

; END PSTATE
; BEGIN TNAME (listing ovr_1cd3_883b:83EE)

        extrn   BCC_TYPE_NAME:word
        extrn   X02C_05:far
        extrn   X02C_22:far
        extrn   X019_05:far
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_FLAGS:byte
        extrn   X019_03:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_06
X03F_06 label   far
BCC_TYPE_RESOLVE_NAME   proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        xor     di,di
        push    word ptr DGROUP:BCC_TYPE_NAME
        db	     9Ah
        dw	     X02C_05
        dw	     seg X02C_05
        mov     si,ax
        or	     si,si
        jne     short M001_@@HAVE_TYPE
        push    word ptr DGROUP:BCC_TYPE_NAME
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     si,ax
M001_@@HAVE_TYPE:
        or	     si,si
        jne     short M001_@@INSPECT
        mov     ax,5Ah
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M001_@@RETURN
M001_@@INSPECT:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,0Bh
        je	     short M001_@@CHECK_VALUE
        mov     al,byte ptr es:[si+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,8
        jne     short M001_@@INVALID
M001_@@CHECK_VALUE:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[si+4],0
        je	     short M001_@@INVALID
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],40h
        je	     short M001_@@INVALID
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     di,word ptr es:[si+4]
        jmp     short M001_@@RETURN
M001_@@INVALID:
        mov     ax,96h
        push    ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M001_@@RETURN:
        mov     ax,di
        pop     di
        pop     si
        pop     bp
        retf
BCC_TYPE_RESOLVE_NAME   endp
CO03F_TEXT	     ends

; END TNAME
; BEGIN TPATH (listing ovr_1cd3_883b:8482)

        extrn   BCC_EXPR_SCRATCH:byte
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_RUNTIME_COPY:far
        extrn   BCC_RUNTIME_BUILD:far
        extrn   X019_05:far
        extrn   X02D_01:far
        extrn   X010_07:far
        extrn   X010_01:far
        extrn   X02C_0C:far
        extrn   BCC_EXPR_SEGMENT:word
        extrn   X02D_00:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_03
X03F_03 label   far
BCC_TYPE_PATH   proc    far
        push    bp
        mov     bp,sp
        sub     sp,12
        push    si
        push    di
        mov     si,word ptr [bp+20]
        xor     di,di
        mov     byte ptr [bp-1],0
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        mov     ax,offset DGROUP:BCC_EXPR_SCRATCH
        push    ds
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        les     bx,dword ptr [bp+14]
        mov     word ptr es:[bx],0
        jmp     short M002_@@INITIAL_TEST
M002_@@INITIAL_ERROR:
        mov     ax,75h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M002_@@INITIAL_TEST:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,67h
        je	     short M002_@@INITIAL_ERROR
        push    word ptr [bp+12]
        push    word ptr [bp+10]
        push    ss
        lea     ax,[bp-8]
        push    ax
        mov     dx,word ptr [bp+12]
        mov     ax,word ptr [bp+10]
        mov     cx,4
        db	     9Ah
        dw	     BCC_RUNTIME_BUILD
        dw	     seg BCC_RUNTIME_BUILD
        db	     9Ah
        dw	     X010_07
        dw	     seg X010_07
        lea     ax,[bp-8]
        push    ss
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        lea     ax,[bp-4]
        push    ss
        push    ax
        push    word ptr [bp+12]
        push    word ptr [bp+10]
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        db	     0E9h
        dw	     00117h
M002_@@LOOP_BODY:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,18h
        jne     short M002_@@CHECK_CHAIN
        or	     di,di
        je	     short M002_@@CHECK_CHAIN
        or	     si,si
        je	     short M002_@@CHECK_NAME
        push    si
        db	     9Ah
        dw	     X02C_0C
        dw	     seg X02C_0C
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[si+3],0
        jne     short M002_@@DUPLICATE_BASE
        mov     word ptr es:[si+3],di
        jmp     short M002_@@BASE_DONE
M002_@@DUPLICATE_BASE:
        mov     ax,0BEh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M002_@@BASE_DONE:
        xor     di,di
M002_@@CHECK_NAME:
        les     bx,dword ptr [bp+10]
        cmp     byte ptr es:[bx+1],0
        je	     short M002_@@NAME_DONE
        mov     ax,31h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M002_@@NAME_DONE:
        mov     byte ptr [bp-3],0Bh
M002_@@CHECK_CHAIN:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,18h
        je	     short M002_@@CHAIN
        cmp     word ptr DGROUP:BCC_RD_C23E_W,1Bh
        je	     short M002_@@CHAIN
        db	     0E9h
        dw	     0007Fh
M002_@@CHAIN:
        mov     byte ptr [bp-1],1
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        lea     ax,[bp-4]
        push    ss
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        push    si
        lea     ax,[bp-4]
        mov     dx,ss
        mov     cx,4
        db	     9Ah
        dw	     BCC_RUNTIME_BUILD
        dw	     seg BCC_RUNTIME_BUILD
        db	     9Ah
        dw	     X010_01
        dw	     seg X010_01
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     word ptr es:[si+11],di
        xor     di,di
        lea     ax,[bp-4]
        push    ss
        push    ax
        push    ss
        lea     ax,[bp-12]
        push    ax
        mov     ax,offset DGROUP:BCC_EXPR_SCRATCH
        mov     dx,ds
        mov     cx,4
        db	     9Ah
        dw	     BCC_RUNTIME_BUILD
        dw	     seg BCC_RUNTIME_BUILD
        db	     9Ah
        dw	     X010_07
        dw	     seg X010_07
        lea     ax,[bp-12]
        push    ss
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[si+11],0
        je	     short M002_@@LOOP_TEST
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        lea     ax,[bp-4]
        push    ss
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        jmp     short M002_@@LOOP_TEST

M002_@@NOT_CHAIN:
        or	     di,di
        je	     short M002_@@RESOLVE_NAME
        mov     ax,0BEh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M002_@@RESOLVE_NAME:
        push    cs
        db	     0E8h,0FDh,0FDh
        mov     di,ax
        mov     byte ptr [bp-1],0
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,2Fh
        jne     short M002_@@CHECK_RPAREN
        mov     ax,15Eh
        jmp     short M002_@@RAISE_TOKEN
M002_@@CHECK_RPAREN:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M002_@@SKIP_TOKEN
        mov     ax,10Ch
M002_@@RAISE_TOKEN:
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M002_@@SKIP_TOKEN:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01

M002_@@LOOP_TEST:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,18h
        jne     short M002_@@TEST_SCOPE
        db	     0E9h
        dw	     0FEDFh
M002_@@TEST_SCOPE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,1Bh
        jne     short M002_@@TEST_SPECIAL
        db	     0E9h
        dw	     0FED5h
M002_@@TEST_SPECIAL:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        jne     short M002_@@FINISH
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,67h
        jne     short M002_@@TEST_SECOND
        db	     0E9h
        dw	     0FEBFh
M002_@@TEST_SECOND:
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,2Fh
        jne     short M002_@@TEST_THIRD
        db	     0E9h
        dw	     0FEB0h
M002_@@TEST_THIRD:
        cmp     word ptr [bp+18],0
        jne     short M002_@@FINISH
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,21h
        jne     short M002_@@FINISH
        db	     0E9h
        dw	     0FE9Bh
M002_@@FINISH:
        mov     al,byte ptr [bp-1]
        mov     ah,0
        or	     ax,ax
        jne     short M002_@@COPY_RESULT
        les     bx,dword ptr [bp+14]
        mov     word ptr es:[bx],di
M002_@@COPY_RESULT:
        push    word ptr [bp+12]
        push    word ptr [bp+10]
        lea     ax,[bp-4]
        push    ss
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RUNTIME_COPY
        dw	     seg BCC_RUNTIME_COPY
        mov     ax,si
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    16
BCC_TYPE_PATH   endp
CO03F_TEXT	     ends

; END TPATH
; BEGIN TOPER (listing ovr_1cd3_883b:8697)
        extrn   X02D_01:far
        extrn   X02D_00:far
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_TREE_TEXT:byte
        extrn   BCC_TREE_VALUE:word
        extrn   X03D_01:far
        extrn   X010_04:far
        extrn   X010_06:far
        extrn   BCC_NODE_NAMES:word
        extrn   X019_02:far
        extrn   X019_06:far
        extrn   X019_05:far
        extrn   BCC_RD_DA3E_W:word
        extrn   BCC_RD_6306_B:byte
        extrn   BCC_TREE_ATTRIBUTES:word
        extrn   X03D_06:far
        extrn   BCC_RD_618E_W:word
        extrn   BCC_RD_62E8_W:word
        extrn   BCC_TYPE_NAME:word
        extrn   X02C_22:far
        extrn   BCC_TYPE_SEGMENT:word
   	     extrn   BCC_RD_C23E_W:word
   	     extrn   BCC_RD_5EC2_W:word
   	     extrn   BCC_RD_C21E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_00
X03F_00 label   far
BCC_TYPE_OPERATOR	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,22
        push    si
        push    di
        mov     si,82h
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Dh
        je	     short M003_@@LEADING
        db	     0E9h
        dw	     00181h
M003_@@LEADING:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        mov     si,word ptr DGROUP:BCC_RD_5EC2_W
        cmp     word ptr DGROUP:BCC_RD_C23E_W,2Bh
        jne     short M003_@@CHECK_PREDICATE
        db	     0E9h
        dw	     000FBh
M003_@@CHECK_PREDICATE:
        push    ds
        mov     ax,offset DGROUP:BCC_TREE_TEXT
        push    ax
        db	     9Ah
        dw	     X03D_01
        dw	     seg X03D_01
        or	     al,al
        jne     short M003_@@SCAN_AHEAD
        db	     0E9h
        dw	     000EAh
M003_@@SCAN_AHEAD:
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,67h
        jne     short M003_@@ANALYZE
        db	     0E9h
        dw	     000DBh
M003_@@ANALYZE:
        mov     si,37h
        mov     ax,word ptr DGROUP:BCC_TREE_VALUE
        mov     word ptr [bp-22],ax
        mov     ax,6
        push    ax
        push    ss
        lea     ax,[bp-4]
        push    ax
        push    ss
        lea     ax,[bp-1]
        push    ax
        push    ss
        lea     ax,[bp-2]
        push    ax
        push    ss
        lea     ax,[bp-22]
        push    ax
        push    ss
        lea     ax,[bp-14]
        push    ax
        push    ss
        lea     ax,[bp-19]
        push    ax
        db	     9Ah
        dw	     X010_04
        dw	     seg X010_04
        cmp     word ptr [bp-4],82h
        jne     short M003_@@BAD_OPERATOR
        cmp     byte ptr [bp-1],0
        jne     short M003_@@BAD_OPERATOR
        cmp     byte ptr [bp-2],0
        je	     short M003_@@PARSE_OPERATOR
M003_@@BAD_OPERATOR:
        mov     ax,102h
        push    ax
        cmp     byte ptr [bp-1],0
        je	     short M003_@@BAD_SECOND
        mov     dx,ds
        mov     ax,3326h
        jmp     short M003_@@RAISE_OPERATOR
M003_@@BAD_SECOND:
        cmp     byte ptr [bp-2],0
        je	     short M003_@@BAD_NAMED
        mov     dx,ds
        mov     ax,332Dh
        jmp     short M003_@@RAISE_OPERATOR
M003_@@BAD_NAMED:
        mov     bx,word ptr [bp-4]
        shl     bx,1
        push    word ptr DGROUP:BCC_NODE_NAMES[bx]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
M003_@@RAISE_OPERATOR:
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M003_@@PARSE_OPERATOR:
        push    word ptr [bp-22]
        mov     ax,6
        push    ax
        push    ss
        lea     ax,[bp-22]
        push    ax
        push    ss
        lea     ax,[bp-10]
        push    ax
        push    ss
        lea     ax,[bp-6]
        push    ax
        push    ss
        lea     ax,[bp-8]
        push    ax
        push    ss
        lea     ax,[bp-14]
        push    ax
        push    ss
        lea     ax,[bp-18]
        push    ax
        db	     9Ah
        dw	     X010_06
        dw	     seg X010_06
        cmp     word ptr DGROUP:BCC_RD_DA3E_W,0
        je	     short M003_@@COMPLEX_RESULT
        mov     al,byte ptr DGROUP:BCC_RD_6306_B
        mov     ah,0
        or	     ax,ax
        jne     short M003_@@COMPLEX_RESULT
        mov     ax,10Eh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M003_@@COMPLEX_RESULT:
        les     bx,dword ptr [bp+6]
        mov     word ptr es:[bx],2
        mov     bx,si
        shl     bx,1
        mov     ax,word ptr DGROUP:BCC_NODE_NAMES[bx]
        les     bx,dword ptr [bp+10]
        mov     word ptr es:[bx],ax
        mov     ax,word ptr [bp-22]
        db	     0E9h
        dw	     000EFh
M003_@@SIMPLE:
        les     bx,dword ptr [bp+6]
        mov     word ptr es:[bx],1
        mov     bx,si
        shl     bx,1
        mov     ax,word ptr DGROUP:BCC_NODE_NAMES[bx]
        les     bx,dword ptr [bp+10]
        mov     word ptr es:[bx],ax
        mov     bx,word ptr DGROUP:BCC_RD_C21E_W
        shl     bx,1
        test    word ptr DGROUP:BCC_TREE_ATTRIBUTES[bx],400h
        jne     short M003_@@SIMPLE_SYNC
        mov     ax,9Fh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M003_@@SIMPLE_SYNC:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        cmp     si,1
        jne     short M003_@@SIMPLE_THREE
        mov     ax,2
        push    ax
        mov     ax,0E9h
        push    ax
        db	     9Ah
        dw	     X03D_06
        dw	     seg X03D_06
        db	     0E9h
        dw	     000A5h
M003_@@SIMPLE_THREE:
        cmp     si,3
        jne     short M003_@@SIMPLE_DONE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,4
        jne     short M003_@@SIMPLE_ERROR
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        db	     0E9h
        dw	     00091h
M003_@@SIMPLE_ERROR:
        mov     ax,0E5h
        push    ax
        push    ds
        mov     ax,3335h
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        jmp     short M003_@@RETURN_DEFAULT
M003_@@SIMPLE_DONE:
        jmp     short M003_@@RETURN_DEFAULT

M003_@@TRAILING:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,2Bh
        jne     short M003_@@RETURN_DEFAULT
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        les     bx,dword ptr [bp+10]
        mov     ax,word ptr DGROUP:BCC_RD_618E_W
        mov     word ptr es:[bx],ax
        les     bx,dword ptr [bp+6]
        mov     word ptr es:[bx],4
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        jne     short M003_@@RETURN_DEFAULT
        cmp     word ptr [bp+14],0
        jne     short M003_@@TRAILING_LOOKUP
        cmp     word ptr DGROUP:BCC_RD_DA3E_W,0
        je	     short M003_@@TRAILING_LOOKUP
        mov     ax,word ptr DGROUP:BCC_RD_62E8_W
        mov     word ptr [bp+14],ax
M003_@@TRAILING_LOOKUP:
        push    word ptr DGROUP:BCC_TYPE_NAME
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     di,ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[di+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,0Bh
        jne     short M003_@@TRAILING_BAD_TYPE
        mov     ax,word ptr es:[di+4]
        cmp     ax,word ptr [bp+14]
        je	     short M003_@@TRAILING_SYNC
        mov     ax,7Dh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M003_@@TRAILING_SYNC
M003_@@TRAILING_BAD_TYPE:
        mov     ax,0F7h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M003_@@TRAILING_SYNC:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M003_@@RETURN_DEFAULT:
        mov     ax,word ptr [bp+16]
M003_@@RETURN_VALUE:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    12
BCC_TYPE_OPERATOR	     endp
CO03F_TEXT	     ends

; END TOPER
; BEGIN LFIND (listing ovr_1cd3_883b:88B1)

        extrn   BCC_PARAM_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_LIST_FIND   proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     di,word ptr [bp+6]
        mov     si,word ptr [bp+4]
        jmp     short M004_@@TEST
M004_@@ITEM:
        cmp     si,di
        je	     short M004_@@RECURSE
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[di+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     ax,word ptr es:[bx+5]
        jne     short M004_@@RECURSE
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        cmp     byte ptr es:[di+7],0
        je	     short M004_@@RETURN
        cmp     byte ptr es:[si+7],0
        je	     short M004_@@RETURN
M004_@@RECURSE:
        push    di
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        push    word ptr es:[bx+12]
        call    BCC_LIST_FIND
        or	     ax,ax
        jne     short M004_@@RETURN
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[si]
M004_@@TEST:
        or	     si,si
        jne     short M004_@@ITEM
M004_@@RETURN:
        mov     ax,si
        pop     di
        pop     si
        pop     bp
        dec     bp
        ret     4
BCC_LIST_FIND   endp
CO03F_TEXT	     ends

; END LFIND
; BEGIN LPARSE (listing ovr_1cd3_883b:892B)

        extrn   X02D_01:far
        extrn   BCC_RD_C23E_W:word
        extrn   X019_05:far
        extrn   BCC_RD_F43E_W:word
        extrn   X019_00:far
        extrn   BCC_TYPE_NAME:word
        extrn   X03D_02:far
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_FLAGS:byte
        extrn   X00A_03:far
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   X019_03:far
        extrn   BCC_RUNTIME_BUILD:far
        extrn   X00F_25:far
        extrn   BCC_PARAM_SEGMENT:word
        extrn   X021_07:far
        extrn   X019_06:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_LIST_PARSE  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,20
        push    si
        push    di
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        jne     short M005_@@INITIALIZE
        mov     ax,0F7h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M005_@@INITIALIZE:
        cmp     word ptr DGROUP:BCC_RD_F43E_W,0
        jne     short M005_@@SCOPE_FALSE
        mov     ax,1
        jmp     short M005_@@SCOPE_DONE
M005_@@SCOPE_FALSE:
        xor     ax,ax
M005_@@SCOPE_DONE:
        mov     byte ptr [bp-2],al
        mov     byte ptr [bp-3],0
        mov     word ptr [bp-6],0
        db	     0E9h
        dw	     00195h
M005_@@OUTER_BODY:
        mov     byte ptr [bp-1],0
        jmp     short M005_@@QUALIFIER_TEST
M005_@@QUALIFIER_BODY:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,73h
        jne     short M005_@@QUALIFIER_OTHER
        cmp     byte ptr [bp-1],0
        je	     short M005_@@QUALIFIER_SET
        mov     ax,0B1h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M005_@@QUALIFIER_SET:
        mov     byte ptr [bp-1],1
        jmp     short M005_@@QUALIFIER_SYNC
M005_@@QUALIFIER_OTHER:
        cmp     byte ptr [bp-3],0
        je	     short M005_@@QUALIFIER_KIND
        mov     ax,0A9h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M005_@@QUALIFIER_KIND:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,70h
        jne     short M005_@@QUALIFIER_VALUE
        mov     ax,6Fh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M005_@@QUALIFIER_MARK
M005_@@QUALIFIER_VALUE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,71h
        jne     short M005_@@QUALIFIER_FALSE
        mov     ax,1
        jmp     short M005_@@QUALIFIER_VALUE_DONE
M005_@@QUALIFIER_FALSE:
        xor     ax,ax
M005_@@QUALIFIER_VALUE_DONE:
        mov     byte ptr [bp-2],al
M005_@@QUALIFIER_MARK:
        mov     byte ptr [bp-3],1
M005_@@QUALIFIER_SYNC:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M005_@@QUALIFIER_TEST:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,71h
        je	     short M005_@@QUALIFIER_BODY
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Fh
        je	     short M005_@@QUALIFIER_BODY
        cmp     word ptr DGROUP:BCC_RD_C23E_W,70h
        je	     short M005_@@QUALIFIER_BODY
        cmp     word ptr DGROUP:BCC_RD_C23E_W,73h
        je	     short M005_@@QUALIFIER_BODY
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        je	     short M005_@@NAMED_ITEM
        mov     ax,0D4h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        cmp     word ptr DGROUP:BCC_RD_C23E_W,8
        jne     short M005_@@ITEM_SEPARATOR
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M005_@@ITEM_SEPARATOR:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        jne     short M005_@@ITEM_RECOVER
        db	     0E9h
        dw	     000D3h
M005_@@ITEM_RECOVER:
        mov     ax,5
        push    ax
        db	     9Ah
        dw	     X019_00
        dw	     seg X019_00
        db	     0E9h
        dw	     000C7h
M005_@@NAMED_ITEM:
        push    word ptr DGROUP:BCC_TYPE_NAME
        db	     9Ah
        dw	     X03D_02
        dw	     seg X03D_02
        mov     di,ax
        or	     di,di
        jne     short M005_@@VALIDATE_ITEM
        mov     ax,0F7h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     0E9h
        dw	     000ACh
M005_@@VALIDATE_ITEM:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di]
        mov     al,byte ptr DGROUP:BCC_EXPR_FLAGS[bx]
        mov     ah,0
        test    ax,40h
        je	     short M005_@@INVALID_ITEM
        cmp     word ptr es:[di],14h
        je	     short M005_@@INVALID_ITEM
        push    di
        db	     9Ah
        dw	     X00A_03
        dw	     seg X00A_03
        or	     ax,dx
        jne     short M005_@@ACCEPT_ITEM
M005_@@INVALID_ITEM:
        mov     ax,6Eh
        push    ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
        jmp     short M005_@@ITEM_DONE
M005_@@ACCEPT_ITEM:
        mov     word ptr [bp-14],di
        mov     word ptr [bp-12],0
        mov     al,byte ptr [bp-2]
        mov     byte ptr [bp-10],al
        mov     al,byte ptr [bp-1]
        mov     byte ptr [bp-9],al
        mov     byte ptr [bp-8],0
        push    ss
        lea     ax,[bp-6]
        push    ax
        lea     ax,[bp-16]
        mov     dx,ss
        mov     cx,10
        db	     9Ah
        dw	     BCC_RUNTIME_BUILD
        dw	     seg BCC_RUNTIME_BUILD
        push    ss
        lea     ax,[bp-19]
        push    ax
        db	     9Ah
        dw	     X00F_25
        dw	     seg X00F_25
        cmp     byte ptr [bp-19],0
        je	     short M005_@@ACCEPTED_DONE
        mov     ax,0AAh
        push    ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M005_@@ACCEPTED_DONE:
        mov     byte ptr [bp-1],0
        mov     byte ptr [bp-2],0
        mov     byte ptr [bp-3],0
M005_@@ITEM_DONE:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,8
        jne     short M005_@@ITEM_FINAL
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        jmp     short M005_@@OUTER_TEST
M005_@@ITEM_FINAL:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M005_@@OUTER_TEST
        mov     ax,0CAh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05

M005_@@OUTER_TEST:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,71h
        jne     short M005_@@OUTER_TEST2
        db	     0E9h
        dw	     0FE61h
M005_@@OUTER_TEST2:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Fh
        jne     short M005_@@OUTER_TEST3
        db	     0E9h
        dw	     0FE57h
M005_@@OUTER_TEST3:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,70h
        jne     short M005_@@OUTER_TEST4
        db	     0E9h
        dw	     0FE4Dh
M005_@@OUTER_TEST4:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,73h
        jne     short M005_@@OUTER_TEST5
        db	     0E9h
        dw	     0FE43h
M005_@@OUTER_TEST5:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        jne     short M005_@@OUTER_FINISH
        db	     0E9h
        dw	     0FE39h
M005_@@OUTER_FINISH:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M005_@@REVERSE_BEGIN
        mov     ax,0D8h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        mov     ax,5
        push    ax
        db	     9Ah
        dw	     X019_00
        dw	     seg X019_00

M005_@@REVERSE_BEGIN:
        xor     si,si
        jmp     short M005_@@REVERSE_TEST
M005_@@REVERSE_ITEM:
        mov     ax,word ptr [bp-6]
        mov     word ptr [bp-18],ax
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr [bp-18]
        mov     ax,word ptr es:[bx]
        mov     word ptr [bp-6],ax
        mov     word ptr es:[bx],si
        mov     si,word ptr [bp-18]
M005_@@REVERSE_TEST:
        cmp     word ptr [bp-6],0
        jne     short M005_@@REVERSE_ITEM
        mov     word ptr [bp-6],si
        mov     si,word ptr [bp-6]
        jmp     short M005_@@CHECK_TEST
M005_@@CHECK_ITEM:
        push    si
        push    word ptr [bp-6]
        db	     0E8h,039h,0FDh
        mov     word ptr [bp-18],ax
        or	     ax,ax
        je	     short M005_@@CHECK_NEXT
        mov     ax,67h
        push    ax
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X021_07
        dw	     seg X021_07
        push    dx
        push    ax
        mov     bx,word ptr [bp-18]
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X021_07
        dw	     seg X021_07
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M005_@@CHECK_NEXT:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[si]
M005_@@CHECK_TEST:
        or	     si,si
        jne     short M005_@@CHECK_ITEM
        mov     ax,word ptr [bp-6]
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret
BCC_LIST_PARSE  endp
CO03F_TEXT	     ends

; END LPARSE
; BEGIN LFIN (listing ovr_1cd3_883b:8BBE)

        extrn   BCC_RD_E83E_W:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_PARAM_SEGMENT:word
        extrn   X021_07:far
        extrn   X019_06:far
        extrn   X00A_03:far
        extrn   BCC_OPTION_FLAG:byte
        extrn   BCC_DEFAULT_FLAG:byte
        extrn   BCC_TYPE_SIZE_HIGH:word
        extrn   BCC_TYPE_SIZE_LOW:word
   	     extrn   BCC_RD_630F_W:word
   	     extrn   BCC_RD_0F3E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_LIST_FINISH proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,10
        push    si
        push    di
        mov     di,word ptr DGROUP:BCC_RD_E83E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],8
        je	     short M006_@@FLAG1_FALSE
        mov     ax,1
        jmp     short M006_@@FLAG1_DONE
M006_@@FLAG1_FALSE:
        xor     ax,ax
M006_@@FLAG1_DONE:
        mov     byte ptr [bp-8],al
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],10h
        je	     short M006_@@FLAG2_FALSE
        mov     ax,1
        jmp     short M006_@@FLAG2_DONE
M006_@@FLAG2_FALSE:
        xor     ax,ax
M006_@@FLAG2_DONE:
        mov     byte ptr [bp-9],al
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],100h
        je	     short M006_@@FLAG3_FALSE
        mov     ax,1
        jmp     short M006_@@FLAG3_DONE
M006_@@FLAG3_FALSE:
        xor     ax,ax
M006_@@FLAG3_DONE:
        mov     byte ptr [bp-10],al
        mov     word ptr [bp-2],0
        mov     word ptr [bp-4],0
        mov     si,word ptr [bp+4]
        mov     word ptr DGROUP:BCC_RD_630F_W,0
        mov     byte ptr [bp-7],0
        db	     0E9h
        dw	     001D2h
M006_@@LIST_ITEM:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     ax,word ptr [bp-4]
        mov     word ptr es:[si+4],ax
        mov     ax,word ptr es:[si+2]
        mov     word ptr [bp-6],ax
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        db	     26h,81h,4Fh,18h,01h,00h
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     ax,word ptr es:[bx+24]
        and     ax,400h
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        or	     word ptr es:[bx+24],ax
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],800h
        je	     short M006_@@CHECK_FLAGS
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        or	     word ptr es:[bx+24],800h
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     byte ptr es:[si+8],1
M006_@@CHECK_FLAGS:
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],8
        je	     short M006_@@CHECK_FLAG100
        cmp     byte ptr [bp-9],0
        je	     short M006_@@FLAG8_CHECK3
        mov     ax,0A5h
M006_@@RAISE:
        push    ax
        push    word ptr [bp-6]
        db	     9Ah
        dw	     X021_07
        dw	     seg X021_07
        push    dx
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        jmp     short M006_@@FLAGS_DONE
M006_@@FLAG8_CHECK3:
        cmp     byte ptr [bp-10],0
        je	     short M006_@@FLAG8_ACCEPT
        mov     ax,134h
        jmp     short M006_@@RAISE
M006_@@FLAG8_ACCEPT:
        mov     byte ptr [bp-8],1
        jmp     short M006_@@FLAGS_DONE
M006_@@CHECK_FLAG100:
        mov     bx,word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],100h
        je	     short M006_@@CHECK_PLAIN
        cmp     byte ptr [bp-9],0
        je	     short M006_@@FLAG100_CHECK1
        mov     ax,137h
        jmp     short M006_@@RAISE
M006_@@FLAG100_CHECK1:
        cmp     byte ptr [bp-8],0
        je	     short M006_@@FLAG100_ACCEPT
        mov     ax,135h
        jmp     short M006_@@RAISE
M006_@@FLAG100_ACCEPT:
        mov     byte ptr [bp-10],1
        jmp     short M006_@@FLAGS_DONE
M006_@@CHECK_PLAIN:
        cmp     byte ptr [bp-8],0
        je	     short M006_@@PLAIN_CHECK3
        mov     ax,0A4h
        jmp     short M006_@@RAISE
M006_@@PLAIN_CHECK3:
        cmp     byte ptr [bp-10],0
        je	     short M006_@@PLAIN_ACCEPT
        mov     ax,136h
        jmp     short M006_@@RAISE
M006_@@PLAIN_ACCEPT:
        mov     byte ptr [bp-9],1
M006_@@FLAGS_DONE:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        cmp     byte ptr es:[si+7],0
        je	     short M006_@@REGULAR_SIZE
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        push    word ptr es:[bx+20]
        db	     9Ah
        dw	     X00A_03
        dw	     seg X00A_03
        add     word ptr [bp-4],ax
        adc     word ptr [bp-2],dx
        mov     byte ptr [bp-7],1
        db	     0E9h
        dw	     00085h
M006_@@REGULAR_SIZE:
        cmp     byte ptr [bp-7],0
        jne     short M006_@@SIZE_FLAG_TRUE
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],4
        je	     short M006_@@SIZE_FLAG_FALSE
M006_@@SIZE_FLAG_TRUE:
        mov     ax,1
        jmp     short M006_@@SIZE_FLAG_DONE
M006_@@SIZE_FLAG_FALSE:
        xor     ax,ax
M006_@@SIZE_FLAG_DONE:
        mov     byte ptr [bp-7],al
        cmp     word ptr DGROUP:BCC_RD_0F3E_W,0
        jne     short M006_@@ADD_REGULAR
        mov     ax,word ptr [bp-4]
        or	     ax,word ptr [bp-2]
        jne     short M006_@@ADD_REGULAR
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     ax,word ptr es:[bx+16]
        mov     word ptr DGROUP:BCC_RD_630F_W,ax
        cmp     word ptr DGROUP:BCC_RD_0F3E_W,0
        je	     short M006_@@ADD_REGULAR
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     byte ptr es:[si+8],1
M006_@@ADD_REGULAR:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     ax,word ptr es:[bx+22]
        add     word ptr [bp-4],ax
        adc     word ptr [bp-2],0
M006_@@NEXT_ITEM:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[si]
M006_@@LIST_TEST:
        or	     si,si
        je	     short M006_@@LIST_DONE
        db	     0E9h
        dw	     0FE27h
M006_@@LIST_DONE:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     ax,word ptr [bp+4]
        mov     word ptr es:[bx+12],ax
        cmp     byte ptr [bp-7],0
        je	     short M006_@@SELECT_RESULT
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        db	     26h,81h,4Fh,18h,04h,00h
M006_@@SELECT_RESULT:
        mov     al,byte ptr [bp-8]
        mov     ah,0
        or	     ax,ax
        jne     short M006_@@RESULT_READY
        mov     al,byte ptr [bp-9]
        mov     ah,0
        or	     ax,ax
        jne     short M006_@@RESULT_READY
        mov     al,byte ptr [bp-10]
        mov     ah,0
        or	     ax,ax
        jne     short M006_@@RESULT_READY
        cmp     byte ptr DGROUP:BCC_OPTION_FLAG,0
        je	     short M006_@@USE_DEFAULT
        mov     byte ptr [bp-10],1
        jmp     short M006_@@RESULT_READY
M006_@@USE_DEFAULT:
        mov     al,byte ptr DGROUP:BCC_DEFAULT_FLAG
        mov     byte ptr [bp-8],al
M006_@@RESULT_READY:
        cmp     byte ptr [bp-8],0
        je	     short M006_@@RESULT_THIRD
        mov     ax,8
        jmp     short M006_@@RESULT_MASK_DONE
M006_@@RESULT_THIRD:
        cmp     byte ptr [bp-10],0
        je	     short M006_@@RESULT_SECOND
        mov     ax,100h
        jmp     short M006_@@RESULT_MASK_DONE
M006_@@RESULT_SECOND:
        mov     ax,10h
M006_@@RESULT_MASK_DONE:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[di+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        or	     word ptr es:[bx+24],ax
        mov     ax,word ptr [bp-2]
        mov     dx,word ptr [bp-4]
        mov     word ptr DGROUP:BCC_TYPE_SIZE_HIGH,ax
        mov     word ptr DGROUP:BCC_TYPE_SIZE_LOW,dx
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     2
BCC_LIST_FINISH endp
CO03F_TEXT	     ends

; END LFIN
; BEGIN CADD (listing ovr_1cd3_883b:8EB0)

        extrn   BCC_CACHE_HEAD:word
        extrn   X043_03:far
        extrn   X02C_23:far
   	     extrn   BCC_RD_9006_W:word
   	     extrn   BCC_RD_6490_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_CACHE_ADD   proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     di,word ptr [bp+6]
        mov     si,word ptr DGROUP:BCC_CACHE_HEAD
        jmp     short M007_@@TEST
M007_@@ITEM:
        mov     es,word ptr DGROUP:BCC_RD_9006_W
        cmp     word ptr es:[si+2],di
        je	     short M007_@@FOUND
        mov     es,word ptr DGROUP:BCC_RD_9006_W
        mov     si,word ptr es:[si]
M007_@@TEST:
        or	     si,si
        jne     short M007_@@ITEM
M007_@@FOUND:
        or	     si,si
        jne     short M007_@@APPEND
        push    ds
        mov     ax,offset DGROUP:BCC_RD_6490_W
        push    ax
        mov     ax,6
        push    ax
        db	     9Ah
        dw	     X043_03
        dw	     seg X043_03
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_RD_9006_W
        mov     ax,word ptr DGROUP:BCC_CACHE_HEAD
        mov     word ptr es:[si],ax
        mov     word ptr es:[si+2],di
        mov     word ptr es:[si+4],0
        mov     word ptr DGROUP:BCC_CACHE_HEAD,si
M007_@@APPEND:
        mov     es,word ptr DGROUP:BCC_RD_9006_W
        push    word ptr es:[si+4]
        push    word ptr [bp+4]
        db	     9Ah
        dw	     X02C_23
        dw	     seg X02C_23
        mov     es,word ptr DGROUP:BCC_RD_9006_W
        mov     word ptr es:[si+4],ax
        pop     di
        pop     si
        pop     bp
        dec     bp
        ret     4
BCC_CACHE_ADD   endp
CO03F_TEXT	     ends

; END CADD
; BEGIN TFIN (listing ovr_1cd3_883b:8F1F)

        extrn   BCC_PARSE_FLAG2:byte
        extrn   X019_06:far
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_FLAGS:byte
        extrn   X019_05:far
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_ACTIVE_LIST:word
        extrn   X02C_23:far
        extrn   X02C_22:far
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_RD_6306_B:byte
        extrn   X019_03:far
        extrn   BCC_TYPE_DEFAULT_SCOPE:word
        extrn   BCC_RD_F83E_W:word
        extrn   BCC_RD_FC3E_W:word
        extrn   BCC_RD_6304_B:byte
        extrn   X00F_24:far
        extrn   X00A_01:far
        extrn   BCC_RD_629E_W:word
        extrn   X03E_05:far
        extrn   X000_01:far
        extrn   BCC_TREE_VALUE:word
        extrn   X02C_18:far
        extrn   X010_03:far
   	     extrn   BCC_RD_003E_W:word
   	     extrn   BCC_RD_6300_W:word
   	     extrn   BCC_RD_001E_W:word
   	     extrn   BCC_RD_F63E_W:word
   	     extrn   BCC_RD_62F6_W:word
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_62FE_W:word
   	     extrn   BCC_RD_FA3E_W:word
   	     extrn   BCC_RD_62FA_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_0F
X03F_0F label   far
BCC_TYPE_FINALIZE	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        cmp     byte ptr DGROUP:BCC_PARSE_FLAG2,0
        je	     short M008_@@INSPECT_EXPR
        cmp     word ptr DGROUP:BCC_RD_003E_W,0
        jne     short M008_@@INSPECT_EXPR
        mov     ax,102h
        push    ax
        push    ds
        mov     ax,332Dh
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M008_@@INSPECT_EXPR:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     bx,word ptr es:[bx]
        test    byte ptr DGROUP:BCC_EXPR_FLAGS[bx],40h
        je	     short M008_@@CHECK_SPECIAL
        cmp     word ptr DGROUP:BCC_RD_F63E_W,0
        je	     short M008_@@APPEND_EXPR
        mov     ax,0D2h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M008_@@APPEND_EXPR:
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        push    word ptr es:[bx+10]
        push    word ptr DGROUP:BCC_ACTIVE_LIST
        db	     9Ah
        dw	     X02C_23
        dw	     seg X02C_23
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+10],ax
        db	     0E9h
        dw	     0021Eh
M008_@@CHECK_SPECIAL:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        cmp     word ptr es:[bx],12h
        je	     short M008_@@SPECIAL
        db	     0E9h
        dw	     0014Ah
M008_@@SPECIAL:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,0
        jne     short M008_@@SPECIAL_KIND
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     si,ax
        or	     si,si
        je	     short M008_@@SPECIAL_KIND
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,0Bh
        jne     short M008_@@SPECIAL_KIND
        mov     ax,word ptr es:[si+4]
        cmp     ax,word ptr DGROUP:BCC_RD_6300_W
        jne     short M008_@@SPECIAL_KIND
        mov     word ptr DGROUP:BCC_RD_62FA_W,3
        mov     al,byte ptr DGROUP:BCC_RD_6306_B
        mov     ah,0
        or	     ax,ax
        jne     short M008_@@SPECIAL_SCOPE_DONE
        mov     ax,76h
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M008_@@SPECIAL_SCOPE_DONE:
        mov     ax,word ptr DGROUP:BCC_TYPE_DEFAULT_SCOPE
        mov     word ptr DGROUP:BCC_RD_62F6_W,ax
M008_@@SPECIAL_KIND:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,1
        jne     short M008_@@KIND_THREE
        cmp     word ptr DGROUP:BCC_RD_F83E_W,6Ch
        je	     short M008_@@KIND_ONE_CHECK
        cmp     word ptr DGROUP:BCC_RD_F83E_W,69h
        je	     short M008_@@KIND_ONE_CHECK
        db	     0E9h
        dw	     0008Bh
M008_@@KIND_ONE_CHECK:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,6Bh
        je	     short M008_@@KIND_ONE_OK
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        je	     short M008_@@KIND_ONE_OK
        mov     ax,8Dh
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M008_@@KIND_ONE_OK:
        mov     byte ptr DGROUP:BCC_RD_6304_B,1
        jmp     short M008_@@BUILD_RESULT
M008_@@KIND_THREE:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,3
        jne     short M008_@@KIND_FOUR
        mov     bx,word ptr DGROUP:BCC_RD_001E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],4
        je	     short M008_@@KIND_THREE_COERCE
        push    word ptr DGROUP:BCC_RD_62FE_W
        mov     ax,73h
        push    ax
        db	     9Ah
        dw	     X00F_24
        dw	     seg X00F_24
M008_@@KIND_THREE_COERCE:
        push    word ptr DGROUP:BCC_RD_6300_W
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X00A_01
        dw	     seg X00A_01
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        jmp     short M008_@@STORE_TYPE
M008_@@KIND_FOUR:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,4
        jne     short M008_@@BUILD_RESULT
        push    word ptr DGROUP:BCC_RD_62FE_W
        mov     ax,69h
        push    ax
        db	     9Ah
        dw	     X00F_24
        dw	     seg X00F_24
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_629E_W
M008_@@STORE_TYPE:
        mov     word ptr es:[bx+7],ax

M008_@@BUILD_RESULT:
        cmp     word ptr DGROUP:BCC_RD_003E_W,0
        je	     short M008_@@BUILD_NEW
        push    word ptr DGROUP:BCC_RD_6300_W
        push    word ptr DGROUP:BCC_RD_62FE_W
        push    word ptr DGROUP:BCC_RD_62F6_W
        push    word ptr DGROUP:BCC_RD_62FA_W
        db	     9Ah
        dw	     X03E_05
        dw	     seg X03E_05
        mov     word ptr [bp-4],ax
        jmp     short M008_@@CACHE_RESULT
M008_@@BUILD_NEW:
        push    word ptr DGROUP:BCC_RD_62FE_W
        push    word ptr DGROUP:BCC_RD_62F6_W
        push    word ptr DGROUP:BCC_RD_62FA_W
        mov     ax,82h
        push    ax
        push    ss
        lea     ax,[bp-4]
        push    ax
        push    ss
        lea     ax,[bp-1]
        push    ax
        db	     9Ah
        dw	     X000_01
        dw	     seg X000_01
M008_@@CACHE_RESULT:
        push    word ptr [bp-4]
        push    word ptr DGROUP:BCC_ACTIVE_LIST
        db	     0E8h,0BDh,0FDh
        mov     ax,word ptr [bp-4]
        db	     0E9h
        dw	     000C5h
M008_@@CHECK_OTHER:
        mov     ax,word ptr DGROUP:BCC_RD_62FE_W
        cmp     ax,word ptr DGROUP:BCC_TREE_VALUE
        je	     short M008_@@OTHER_HAVE_TYPE
        db	     0E9h
        dw	     000AEh
M008_@@OTHER_HAVE_TYPE:
        cmp     word ptr DGROUP:BCC_RD_F63E_W,0
        jne     short M008_@@OTHER_CHECK_SCOPE
        db	     0E9h
        dw	     000A4h
M008_@@OTHER_CHECK_SCOPE:
        cmp     word ptr DGROUP:BCC_RD_003E_W,0
        je	     short M008_@@OTHER_LOOKUP
M008_@@OTHER_SCOPE_ERROR:
        mov     ax,114h
        db	     0E9h
        dw	     0009Ah
M008_@@OTHER_LOOKUP:
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     word ptr [bp-4],ax
        cmp     word ptr [bp-4],0
        je	     short M008_@@OTHER_CHECK_NEW
        jmp     short M008_@@OTHER_SCOPE_ERROR
M008_@@OTHER_CHECK_NEW:
        cmp     word ptr DGROUP:BCC_RD_003E_W,0
        jne     short M008_@@OTHER_INVALID
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,0
        jne     short M008_@@OTHER_INVALID
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X02C_18
        dw	     seg X02C_18
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        and     al,7
        or	     al,58h
        mov     byte ptr es:[si+7],al
        mov     ax,42h
        push    ax
        mov     ax,82h
        push    ax
        db	     9Ah
        dw	     X010_03
        dw	     seg X010_03
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[si+4],ax
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+6],si
        xor     ax,ax
        push    ax
        push    word ptr DGROUP:BCC_ACTIVE_LIST
        db	     9Ah
        dw	     X02C_23
        dw	     seg X02C_23
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+10],ax
        jmp     short M008_@@RETURN_ZERO
M008_@@OTHER_INVALID:
        mov     ax,0D2h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M008_@@RETURN_ZERO
M008_@@OTHER_ERROR:
        mov     ax,0D2h
M008_@@OTHER_RAISE:
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M008_@@RETURN_ZERO:
        xor     ax,ax
M008_@@RETURN_VALUE:
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_FINALIZE	     endp
CO03F_TEXT	     ends

; END TFIN
; BEGIN TDECL (listing ovr_1cd3_883b:91C3)

        extrn   BCC_TYPE_NAME:word
        extrn   X03D_02:far
        extrn   X019_05:far
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_PARAM_SEGMENT:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   X019_02:far
        extrn   X021_07:far
        extrn   X019_06:far
        extrn   X02D_01:far
        extrn   BCC_RD_C23E_W:word
        extrn   X019_00:far
        extrn   X06C_01:far
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   X02C_02:far
   	     extrn   BCC_RD_F43E_W:word
   	     extrn   BCC_RD_62F4_W:word
   	     extrn   BCC_RD_E81E_W:word
   	     extrn   BCC_RD_62E8_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_13
X03F_13 label   far
BCC_TYPE_DECLARE	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,8
        push    si
        push    di
        push    word ptr DGROUP:BCC_TYPE_NAME
        db	     9Ah
        dw	     X03D_02
        dw	     seg X03D_02
        mov     word ptr [bp-2],ax
        cmp     word ptr DGROUP:BCC_RD_F43E_W,2
        jne     short M009_@@CHECK_LOOKUP
        mov     ax,104h
M009_@@RAISE_INITIAL:
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     0E9h
        dw	     0007Fh
M009_@@CHECK_LOOKUP:
        cmp     word ptr [bp-2],0
        jne     short M009_@@CHECK_EXISTING
        mov     ax,0F7h
        jmp     short M009_@@RAISE_INITIAL
M009_@@CHECK_EXISTING:
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     si,word ptr es:[bx+12]
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     ax,word ptr [bp-2]
        mov     word ptr es:[2],ax
        jmp     short M009_@@EXISTING_TEST
M009_@@EXISTING_NEXT:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[si]
M009_@@EXISTING_TEST:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     bx,word ptr es:[si+2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr es:[bx+5]
        mov     bx,word ptr [bp-2]
        cmp     ax,word ptr es:[bx+5]
        jne     short M009_@@EXISTING_NEXT
        or	     si,si
        jne     short M009_@@AFTER_INITIAL
        mov     ax,0BFh
        push    ax
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        push    word ptr DGROUP:BCC_RD_62E8_W
        db	     9Ah
        dw	     X021_07
        dw	     seg X021_07
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06

M009_@@AFTER_INITIAL:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Dh
        jne     short M009_@@CHECK_NAME
        xor     ax,ax
        push    ax
        push    ax
        push    ss
        lea     ax,[bp-4]
        push    ax
        push    ss
        lea     ax,[bp-6]
        push    ax
        push    cs
        db	     0E8h,00Bh,0F4h
        cmp     word ptr [bp-6],2
        jne     short M009_@@AFTER_OPERATOR
        mov     ax,9Fh
M009_@@RAISE_OPERATOR:
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        mov     ax,7
        push    ax
        db	     9Ah
        dw	     X019_00
        dw	     seg X019_00
        db	     0E9h
        dw	     000E1h
M009_@@CHECK_NAME:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        jne     short M009_@@BAD_NAME
        mov     ax,word ptr DGROUP:BCC_TYPE_NAME
        mov     word ptr [bp-4],ax
        mov     word ptr [bp-6],0
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        jmp     short M009_@@AFTER_OPERATOR
M009_@@BAD_NAME:
        mov     ax,0D4h
        jmp     short M009_@@RAISE_OPERATOR

M009_@@AFTER_OPERATOR:
        cmp     word ptr [bp-2],0
        jne     short M009_@@MEMBER_LOOKUP
        db	     0E9h
        dw	     000BAh
M009_@@MEMBER_LOOKUP:
        push    word ptr [bp-4]
        push    word ptr [bp-2]
        db	     9Ah
        dw	     X06C_01
        dw	     seg X06C_01
        mov     di,ax
        or	     di,di
        jne     short M009_@@INSPECT_MEMBER
        mov     ax,0D0h
M009_@@RAISE_MEMBER:
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M009_@@AFTER_MEMBER
M009_@@INSPECT_MEMBER:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     al,byte ptr es:[di+4]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        and     ax,7
        cmp     ax,word ptr DGROUP:BCC_RD_62F4_W
        je	     short M009_@@MEMBER_KIND
        mov     ax,69h
        jmp     short M009_@@RAISE_MEMBER
M009_@@MEMBER_KIND:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     al,byte ptr es:[di+4]
        mov     ah,0
        and     ax,3
        cmp     ax,3
        jne     short M009_@@AFTER_MEMBER
        mov     ax,word ptr es:[di+6]
        jmp     short M009_@@INHERIT_STORE
M009_@@INHERIT_LOOP:
        mov     bx,word ptr [bp-8]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[bx+12]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        cmp     ax,word ptr DGROUP:BCC_RD_62F4_W
        je	     short M009_@@INHERIT_NEXT
        mov     ax,69h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        xor     di,di
        jmp     short M009_@@AFTER_MEMBER
M009_@@INHERIT_NEXT:
        mov     bx,word ptr [bp-8]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+19]
M009_@@INHERIT_STORE:
        mov     word ptr [bp-8],ax
        cmp     word ptr [bp-8],0
        jne     short M009_@@INHERIT_LOOP

M009_@@AFTER_MEMBER:
        or	     di,di
        je	     short M009_@@RETURN
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        push    word ptr es:[bx+14]
        push    di
        db	     9Ah
        dw	     X02C_02
        dw	     seg X02C_02
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+14],ax
M009_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_DECLARE	     endp
CO03F_TEXT	     ends

; END TDECL
; BEGIN TCOMMIT (listing ovr_1cd3_883b:938E)

        extrn   BCC_RD_FA3E_W:word
        extrn   BCC_RD_F83E_W:word
        extrn   BCC_RD_FC3E_W:word
        extrn   BCC_RD_62F6_W:word
        extrn   X019_03:far
        extrn   BCC_RD_6304_B:byte
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   X00F_24:far
        extrn   X00A_01:far
        extrn   BCC_RD_629E_W:word
        extrn   X00F_16:far
   	     extrn   BCC_RD_62FE_W:word
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_E81E_W:word
   	     extrn   BCC_RD_62E8_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_TYPE_COMMIT proc    near
        inc     bp
        push    bp
        mov     bp,sp
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,1
        jne     short M00A_@@KIND_THREE
        cmp     word ptr DGROUP:BCC_RD_F83E_W,6Ch
        je	     short M00A_@@KIND_ONE
        cmp     word ptr DGROUP:BCC_RD_F83E_W,69h
        je	     short M00A_@@KIND_ONE
        db	     0E9h
        dw	     0008Bh
M00A_@@KIND_ONE:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,6Bh
        je	     short M00A_@@KIND_ONE_OK
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        je	     short M00A_@@KIND_ONE_OK
        mov     ax,8Dh
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M00A_@@KIND_ONE_OK:
        mov     byte ptr DGROUP:BCC_RD_6304_B,1
        jmp     short M00A_@@FINISH
M00A_@@KIND_THREE:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,3
        jne     short M00A_@@KIND_FOUR
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+24],4
        je	     short M00A_@@KIND_THREE_COERCE
        push    word ptr DGROUP:BCC_RD_62FE_W
        mov     ax,73h
        push    ax
        db	     9Ah
        dw	     X00F_24
        dw	     seg X00F_24
M00A_@@KIND_THREE_COERCE:
        push    word ptr DGROUP:BCC_RD_62E8_W
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X00A_01
        dw	     seg X00A_01
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        jmp     short M00A_@@STORE_TYPE
M00A_@@KIND_FOUR:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,4
        jne     short M00A_@@FINISH
        push    word ptr DGROUP:BCC_RD_62FE_W
        mov     ax,69h
        push    ax
        db	     9Ah
        dw	     X00F_24
        dw	     seg X00F_24
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_629E_W
M00A_@@STORE_TYPE:
        mov     word ptr es:[bx+7],ax
M00A_@@FINISH:
        mov     al,byte ptr DGROUP:BCC_RD_6304_B
        mov     ah,0
        or	     ax,ax
        jne     short M00A_@@RETURN
        push    word ptr DGROUP:BCC_RD_62E8_W
        push    word ptr DGROUP:BCC_RD_62FE_W
        db	     9Ah
        dw	     X00F_16
        dw	     seg X00F_16
M00A_@@RETURN:
        pop     bp
        dec     bp
        ret
BCC_TYPE_COMMIT endp
CO03F_TEXT	     ends

; END TCOMMIT
; BEGIN TRESOLV (listing ovr_1cd3_883b:944E)

        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_PARAM_SEGMENT:word
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   X02C_21:far
        extrn   X03E_02:far
        extrn   X00F_08:far
        extrn   X021_05:far
        extrn   X019_06:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_TYPE_RESOLVE	     proc    far
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,6
        push    si
        push    di
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     si,word ptr es:[bx+0Ch]
        mov     bx,word ptr [bp+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+4]
        mov     word ptr [bp-6],ax
        push    word ptr es:[bx+2]
        push    word ptr [bp+8]
        db	     9Ah
        dw	     X02C_21
        dw	     seg X02C_21
        mov     word ptr [bp-2],ax
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     al,byte ptr es:[bx+4]
        mov     ah,0
        and     ax,3
        cmp     ax,3
        je	     short M00B_@@MEMBER_OK
        db	     0E9h
        dw	     000FBh
M00B_@@MEMBER_OK:
        mov     di,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr [bp-6]
        mov     word ptr es:[4],ax
        cmp     word ptr es:[di+0Fh],2
        jne     short M00B_@@EQUIV_LOOP
        jmp     short M00B_@@COMPARE_TEST
M00B_@@COMPARE_NEXT:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     di,word ptr es:[di+13h]
M00B_@@COMPARE_TEST:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[di+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        push    word ptr es:[bx+7]
        mov     bx,word ptr [bp-6]
        push    word ptr es:[bx+7]
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     020h
        dw	     seg CO00A_TEXT
        mov     ah,0
        or	     ax,ax
        je	     short M00B_@@COMPARE_NEXT
        jmp     short M00B_@@CANDIDATE_FOUND
M00B_@@EQUIV_NEXT:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     di,word ptr es:[di+13h]
M00B_@@EQUIV_LOOP:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[di+4]
        push    word ptr [bp-6]
        db	     9Ah
        dw	     X00F_08
        dw	     seg X00F_08
        mov     ah,0
        or	     ax,ax
        je	     short M00B_@@EQUIV_NEXT
M00B_@@CANDIDATE_FOUND:
        or	     di,di
        jne     short M00B_@@CANDIDATE_VALID
        db	     0E9h
        dw	     0008Fh
M00B_@@CANDIDATE_VALID:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[di+15h],0
        jne     short M00B_@@CANDIDATE_READY
        test    word ptr es:[di+0Ah],100h
        je	     short M00B_@@NEXT_PARAM
M00B_@@CANDIDATE_READY:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[di+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        push    word ptr es:[bx+7]
        mov     bx,word ptr [bp-6]
        push    word ptr es:[bx+7]
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     020h
        dw	     seg CO00A_TEXT
        mov     ah,0
        or	     ax,ax
        jne     short M00B_@@RETURN_CANDIDATE
        mov     ax,9Ch
        push    ax
        push    word ptr [bp+6]
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        push    di
        db	     9Ah
        dw	     X021_05
        dw	     seg X021_05
        push    dx
        push    ax
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M00B_@@RETURN_CANDIDATE:
        mov     ax,di
        jmp     short M00B_@@RETURN
M00B_@@PARAM_LOOP:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        cmp     byte ptr es:[si+8],0
        jne     short M00B_@@TRY_PARAM
        mov     al,byte ptr [bp+4]
        mov     ah,0
        or	     ax,ax
        jne     short M00B_@@ADVANCE_PARAM
M00B_@@TRY_PARAM:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        push    word ptr es:[si+2]
        push    word ptr [bp+6]
        mov     al,byte ptr [bp+4]
        push    ax
        db	     0E8h
        dw	     0FEC6h
        mov     word ptr [bp-4],ax
        cmp     word ptr [bp-4],0
        je	     short M00B_@@ADVANCE_PARAM
        jmp     short M00B_@@RETURN
M00B_@@ADVANCE_PARAM:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[si]
M00B_@@NEXT_PARAM:
        or	     si,si
        jne     short M00B_@@PARAM_LOOP
        xor     ax,ax
M00B_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        db	     0C2h
        dw	     6
BCC_TYPE_RESOLVE	     endp
CO03F_TEXT	     ends

; END TRESOLV
; BEGIN TOFFSET (listing ovr_1cd3_883b:95A9)

        extrn   BCC_RD_62E8_W:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_RD_630F_W:word
        extrn   BCC_TYPE_SIZE1:word
        extrn   BCC_TYPE_SIZE2:word
        extrn   X00A_03:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_05
X03F_05 label   far
BCC_TYPE_OFFSET proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     si,word ptr [bp+6]
        push    word ptr DGROUP:BCC_RD_62E8_W
        push    si
        mov     al,1
        push    ax
        db	     0E8h
        dw	     0FE90h
        mov     di,ax
        or	     di,di
        je	     short M00C_@@SECOND_PASS
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[di+15h],0
        jbe     short M00C_@@SECOND_PASS
        mov     ax,word ptr es:[di+15h]
        jmp     short M00C_@@RETURN
M00C_@@SECOND_PASS:
        mov     al,byte ptr [bp+8]
        mov     ah,0
        or	     ax,ax
        jne     short M00C_@@CALCULATE
        push    word ptr DGROUP:BCC_RD_62E8_W
        push    si
        mov     al,0
        push    ax
        db	     0E8h
        dw	     0FE65h
        or	     ax,ax
        jne     short M00C_@@CALCULATE
        xor     ax,ax
        jmp     short M00C_@@RETURN
M00C_@@CALCULATE:
        mov     ax,word ptr DGROUP:BCC_RD_630F_W
        mov     word ptr [bp-2],ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        test    byte ptr es:[bx+0Ch],1
        je	     short M00C_@@SIZE_ONE
        mov     ax,word ptr DGROUP:BCC_TYPE_SIZE2
        jmp     short M00C_@@CAST
M00C_@@SIZE_ONE:
        mov     ax,word ptr DGROUP:BCC_TYPE_SIZE1
M00C_@@CAST:
        push    ax
        db	     9Ah
        dw	     X00A_03
        dw	     seg X00A_03
        add     word ptr DGROUP:BCC_RD_630F_W,ax
        mov     ax,word ptr [bp-2]
        inc     ax
M00C_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    4
BCC_TYPE_OFFSET endp
CO03F_TEXT	     ends

; END TOFFSET
; BEGIN TSETUP (listing ovr_1cd3_883b:9628)
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_PARAM_SEGMENT:word
        extrn   BCC_RD_6308_W:word
        extrn   BCC_RD_6307_B:byte
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_TEXT_E5:byte
        extrn   BCC_RF_15A7_017D:far
        extrn   X02D_01:far
        extrn   X03D_03:far
        extrn   X019_06:far
   	     extrn   BCC_RD_6302_B:byte
   	     extrn   BCC_RD_E81E_W:word
   	     extrn   BCC_RD_62E8_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_TYPE_SETUP  proc    far
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+18h],800h
        jne     short M00D_@@SYNCHRONIZED
        mov     si,word ptr DGROUP:BCC_RD_62E8_W
M00D_@@PARAM_LOOP:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        cmp     word ptr es:[bx+0Ch],0
        je	     short M00D_@@MARK_DONE
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+0Ch]
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        cmp     word ptr es:[bx],0
        je	     short M00D_@@SELECT_PARAM
        mov     ax,13Dh
        push    ax
        db	     9Ah
        dw	     BCC_RF_15A7_017D
        dw	     seg BCC_RF_15A7_017D
        pop     cx
        jmp     short M00D_@@MARK_DONE
M00D_@@SELECT_PARAM:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+0Ch]
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[bx+2]
        jmp     short M00D_@@PARAM_LOOP
M00D_@@MARK_DONE:
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        or	     word ptr es:[bx+18h],800h
M00D_@@SYNCHRONIZED:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        mov     ax,4
        push    ax
        push    ss
        lea     ax,[bp-4]
        push    ax
        db	     9Ah
        dw	     X03D_03
        dw	     seg X03D_03
        mov     ax,word ptr [bp-4]
        mov     word ptr DGROUP:BCC_RD_6308_W,ax
        mov     byte ptr DGROUP:BCC_RD_6307_B,1
        mov     byte ptr DGROUP:BCC_RD_6302_B,0
        cmp     word ptr DGROUP:BCC_RD_C23E_W,4
        jne     short M00D_@@ERROR
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        jmp     short M00D_@@RETURN
M00D_@@ERROR:
        mov     ax,0E5h
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_E5
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M00D_@@RETURN:
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_SETUP  endp
CO03F_TEXT	     ends

; END TSETUP
; BEGIN TINHER (listing ovr_1cd3_883b:9703)
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_RD_073E_B:byte
        extrn   BCC_RD_6308_W:word
        extrn   X021_05:far
        extrn   X019_06:far
   	     extrn   BCC_RD_6302_B:byte
   	     extrn   BCC_RD_62E8_W:word
   	     extrn   BCC_RD_E81E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

BCC_TYPE_INHERIT	     proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     si,word ptr [bp+6]
        push    word ptr DGROUP:BCC_RD_62E8_W
        push    si
        mov     al,0
        push    ax
        db	     0E8h
        dw	     0FD38h
        mov     di,ax
        or	     di,di
        jne     short M00E_@@RESOLVED
        db	     0E9h
        dw	     0008Ah
M00E_@@RESOLVED:
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        test    word ptr es:[di+0Ah],100h
        je	     short M00E_@@UNRESOLVED
        or	     word ptr es:[si+0Ah],100h
        mov     ax,word ptr es:[di+15h]
        mov     word ptr es:[si+15h],ax
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        inc     word ptr es:[bx+1Ah]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        and     byte ptr es:[bx+0Ch],0BFh
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        or	     byte ptr es:[bx+0Ch],1
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        or	     byte ptr es:[si+6],80h
        cmp     byte ptr DGROUP:BCC_RD_073E_B,0
        jne     short M00E_@@CHECK_VALUE
        db	     0E9h
        dw	     000B3h
M00E_@@CHECK_VALUE:
        mov     ax,word ptr es:[si+15h]
        cmp     ax,word ptr DGROUP:BCC_RD_6308_W
        jne     short M00E_@@VALUE_CHANGED
        db	     0E9h
        dw	     000A6h
M00E_@@VALUE_CHANGED:
        mov     ax,13Eh
        push    ax
        push    si
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
        db	     0E9h
        dw	     0008Ch
M00E_@@UNRESOLVED:
        cmp     byte ptr DGROUP:BCC_RD_073E_B,0
        je	     short M00E_@@CALCULATE
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        or	     word ptr es:[si+0Ah],100h
        mov     ax,word ptr DGROUP:BCC_RD_6308_W
        mov     word ptr es:[si+15h],ax
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        inc     word ptr es:[bx+1Ah]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        and     byte ptr es:[bx+0Ch],0BFh
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        or	     byte ptr es:[bx+0Ch],1
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        or	     byte ptr es:[si+6],80h
        or	     di,di
        je	     short M00E_@@RETURN
        cmp     word ptr es:[di+15h],0
        je	     short M00E_@@RETURN
        mov     ax,13Fh
        push    ax
        push    si
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
        jmp     short M00E_@@RETURN
M00E_@@CALCULATE:
        mov     al,byte ptr DGROUP:BCC_RD_6302_B
        push    ax
        push    si
        push    cs
        db	     0E8h
        dw	     0FD7Ch
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[si+15h],ax
M00E_@@RETURN:
        pop     di
        pop     si
        pop     bp
        retf    2
BCC_TYPE_INHERIT	     endp
CO03F_TEXT	     ends

; END TINHER
; BEGIN TDEFINE (listing ovr_1cd3_883b:983B)
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_TYPE_OUTER:word
        extrn   BCC_RD_62F4_B:byte
        extrn   BCC_RD_043E_B:byte
        extrn   BCC_RD_133E_B:byte
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_TYPE_NAME:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   BCC_TEXT_102:byte
        extrn   X019_05:far
        extrn   X019_06:far
        extrn   X02D_00:far
        extrn   X02D_01:far
        extrn   X019_01:far
        extrn   X02C_21:far
        extrn   X019_03:far
        extrn   X03E_02:far
        extrn   X021_05:far
        extrn   X02C_1E:far
        extrn   X000_05:far
        extrn   X02C_16:far
   	     extrn   BCC_RD_62FE_W:word
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_FA3E_W:word
   	     extrn   BCC_RD_62FA_W:word
   	     extrn   BCC_RD_FC3E_W:word
   	     extrn   BCC_RD_62FC_W:word
   	     extrn   BCC_RD_023E_B:byte
   	     extrn   BCC_RD_6302_B:byte
   	     extrn   BCC_RD_62E8_W:word
   	     extrn   BCC_RD_E81E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_10
X03F_10 label   far
BCC_TYPE_DEFINE proc    far
        push    bp
        mov     bp,sp
        sub     sp,6
        push    si
        push    di
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,6Bh
        je	     short M00F_@@TOKEN_OK
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        je	     short M00F_@@TOKEN_OK
        mov     ax,8Dh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M00F_@@TOKEN_OK:
        cmp     byte ptr DGROUP:BCC_RD_023E_B,0
        je	     short M00F_@@CHECK_TREE
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,3
        je	     short M00F_@@STATE_ERROR
        cmp     byte ptr DGROUP:BCC_RD_043E_B,0
        je	     short M00F_@@CHECK_TREE
M00F_@@STATE_ERROR:
        mov     ax,102h
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_102
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M00F_@@CHECK_TREE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,0Bh
        jne     short M00F_@@COMMIT
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,3
        jne     short M00F_@@COMMIT
        push    cs
        db	     0E8h
        dw	     0FD8Dh
M00F_@@COMMIT:
        db	     0E8h
        dw	     0FAF0h
        push    word ptr DGROUP:BCC_RD_62F6_W
        push    word ptr DGROUP:BCC_RD_62E8_W
        db	     9Ah
        dw	     X02C_21
        dw	     seg X02C_21
        mov     si,ax
        or	     si,si
        je	     short M00F_@@NO_MEMBER
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     al,byte ptr es:[si+4]
        mov     ah,0
        and     ax,3
        cmp     ax,3
        jne     short M00F_@@NO_MEMBER
        mov     di,word ptr es:[si+6]
        jmp     short M00F_@@MEMBER_DONE
M00F_@@NO_MEMBER:
        or	     si,si
        je	     short M00F_@@CLEAR_MEMBER
        mov     ax,0ADh
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M00F_@@CLEAR_MEMBER:
        xor     si,si
        xor     di,di
M00F_@@MEMBER_DONE:
        mov     word ptr [bp-4],0
        or	     di,di
        je	     short M00F_@@SEARCH_DONE
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[di+0Fh],2
        je	     short M00F_@@SEARCH_MARK
        db	     26h,81h,4Dh,0Ah,1,0
M00F_@@SEARCH_MARK:
        mov     word ptr [bp-4],di
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_62FE_W
        mov     word ptr es:[4],ax
        jmp     short M00F_@@SEARCH_TEST
M00F_@@SEARCH_NEXT:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr es:[bx+13h]
        mov     word ptr [bp-4],ax
M00F_@@SEARCH_TEST:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        push    word ptr es:[bx+4]
        push    word ptr DGROUP:BCC_RD_62FE_W
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     020h
        dw	     seg CO00A_TEXT
        mov     ah,0
        or	     ax,ax
        je	     short M00F_@@SEARCH_NEXT
M00F_@@SEARCH_DONE:
        cmp     word ptr [bp-4],0
        je	     short M00F_@@CREATE
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+0Fh],2
        jne     short M00F_@@DUPLICATE
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[bx+7],0
        je	     short M00F_@@CREATE
M00F_@@DUPLICATE:
        mov     ax,0ADh
        push    ax
        push    word ptr [bp-4]
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
        xor     ax,ax
        db	     0E9h
        dw	     001D5h
M00F_@@CREATE:
        push    word ptr DGROUP:BCC_RD_62F6_W
        mov     ax,6
        push    ax
        db	     9Ah
        dw	     X02C_1E
        dw	     seg X02C_1E
        mov     word ptr [bp-2],ax
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_62FA_W
        mov     word ptr es:[bx+0Fh],ax
        or	     byte ptr es:[bx+6],10h
        mov     ax,word ptr DGROUP:BCC_TYPE_OUTER
        mov     word ptr es:[bx],ax
        push    word ptr DGROUP:BCC_RD_62FA_W
        push    word ptr DGROUP:BCC_RD_62FE_W
        push    ss
        lea     ax,[bp-2]
        push    ax
        push    di
        push    word ptr DGROUP:BCC_RD_62FC_W
        push    ss
        lea     ax,[bp-5]
        push    ax
        db	     9Ah
        dw	     X000_05
        dw	     seg X000_05
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[bx+0Ch]
        and     al,0E3h
        mov     dl,byte ptr DGROUP:BCC_RD_62F4_B
        and     dl,7
        shl     dl,1
        shl     dl,1
        or	     al,dl
        mov     byte ptr es:[bx+0Ch],al
        or	     di,di
        je	     short M00F_@@KIND_FLAGS
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,2
        je	     short M00F_@@KIND_FLAGS
        db	     26h,81h,4Fh,0Ah,1,0
M00F_@@KIND_FLAGS:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,3
        jne     short M00F_@@MODE_FLAGS
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        db	     26h,81h,4Fh,0Ah,10h,0
M00F_@@MODE_FLAGS:
        cmp     byte ptr DGROUP:BCC_RD_043E_B,0
        je	     short M00F_@@SPECIAL_FLAGS
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        db	     26h,81h,4Fh,0Ah,40h,0
M00F_@@SPECIAL_FLAGS:
        cmp     byte ptr DGROUP:BCC_RD_133E_B,0
        je	     short M00F_@@LINK_FLAGS
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        or	     byte ptr es:[bx+0Ch],80h
M00F_@@LINK_FLAGS:
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+18h],800h
        je	     short M00F_@@CALCULATE_OFFSET
        push    word ptr [bp-2]
        push    cs
        db	     0E8h
        dw	     0FCC0h
        jmp     short M00F_@@OFFSET_DONE
M00F_@@CALCULATE_OFFSET:
        mov     al,byte ptr DGROUP:BCC_RD_6302_B
        push    ax
        push    word ptr [bp-2]
        push    cs
        db	     0E8h
        dw	     0FB59h
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[bx+15h],ax
M00F_@@OFFSET_DONE:
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[bx+11h],1
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[bx+0Bh],2
        jne     short M00F_@@ENSURE_MEMBER
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+15h],0
        je	     short M00F_@@ENSURE_MEMBER
        mov     ax,31h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M00F_@@ENSURE_MEMBER:
        or	     si,si
        jne     short M00F_@@MEMBER_READY
        push    word ptr DGROUP:BCC_RD_62F6_W
        mov     ax,3
        push    ax
        db	     9Ah
        dw	     X02C_16
        dw	     seg X02C_16
        mov     si,ax
M00F_@@MEMBER_READY:
        cmp     byte ptr [bp-5],0
        jne     short M00F_@@APPEND_MEMBER
        or	     di,di
        jne     short M00F_@@TRAILING
M00F_@@APPEND_MEMBER:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     ax,word ptr es:[si+6]
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     word ptr es:[bx+13h],ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     ax,word ptr [bp-2]
        mov     word ptr es:[si+6],ax
M00F_@@TRAILING:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,0Bh
        jne     short M00F_@@SUCCESS
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,32h
        jne     short M00F_@@TRAILING_ERROR
        mov     ax,word ptr DGROUP:BCC_TYPE_NAME
        or	     ax,word ptr DGROUP:BCC_TYPE_NAME+2
        jne     short M00F_@@TRAILING_ERROR
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+15h],0
        jne     short M00F_@@TRAILING_FLAGS
        mov     ax,118h
        push    ax
        push    word ptr [bp-2]
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
        jmp     short M00F_@@TRAILING_SYNC
M00F_@@TRAILING_FLAGS:
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        db	     26h,81h,4Fh,0Ah,20h,0
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        db	     26h,81h,4Fh,18h,80h,0
M00F_@@TRAILING_SYNC:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        jmp     short M00F_@@SUCCESS
M00F_@@TRAILING_ERROR:
        mov     ax,119h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     9Ah
        dw	     X019_01
        dw	     seg X019_01
M00F_@@SUCCESS:
        mov     ax,word ptr [bp-2]
M00F_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_DEFINE endp
CO03F_TEXT	     ends

; END TDEFINE
; BEGIN TVIRT (listing ovr_1cd3_883b:9B4F)

        extrn   BCC_EXPR_COUNT:word
        extrn   BCC_RD_E81E_W:word
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_TYPE_OUTER:word
        extrn   BCC_PARSE_CLASS:byte
        extrn   BCC_RD_133E_B:byte
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   BCC_TEXT_13A:byte
        extrn   X019_06:far
        extrn   X02C_16:far
        extrn   X02C_1E:far
        extrn   X02C_0E:far
        extrn   X02C_14:far
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_62FE_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_07
X03F_07 label   far
BCC_TYPE_VIRTUAL	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        push    di
        cmp     word ptr DGROUP:BCC_EXPR_COUNT,0
        jle     short M010_@@CHECK_KIND
        mov     ax,13Ah
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_13A
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M010_@@CHECK_KIND:
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+18h],108h
        je	     short M010_@@CHECK_CLASS
        cmp     byte ptr DGROUP:BCC_PARSE_CLASS,8
        jne     short M010_@@SPECIAL
M010_@@CHECK_CLASS:
        cmp     byte ptr DGROUP:BCC_PARSE_CLASS,9
        je	     short M010_@@SPECIAL
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        cmp     word ptr es:[bx],11h
        jne     short M010_@@ORDINARY
        test    byte ptr es:[bx+2],40h
        je	     short M010_@@ORDINARY
M010_@@SPECIAL:
        mov     ax,1
        jmp     short M010_@@SAVE_FLAG
M010_@@ORDINARY:
        xor     ax,ax
M010_@@SAVE_FLAG:
        mov     byte ptr [bp-3],al
        push    word ptr DGROUP:BCC_RD_62F6_W
        mov     ax,2
        push    ax
        db	     9Ah
        dw	     X02C_16
        dw	     seg X02C_16
        mov     di,ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        mov     ax,5
        push    ax
        db	     9Ah
        dw	     X02C_1E
        dw	     seg X02C_1E
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     word ptr es:[di+6],ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_62FE_W
        mov     word ptr es:[si+4],ax
        mov     ax,word ptr DGROUP:BCC_TYPE_OUTER
        mov     word ptr es:[si],ax
        mov     al,byte ptr es:[si+7]
        and     al,7
        or	     al,10h
        mov     byte ptr es:[si+7],al
        cmp     byte ptr [bp-3],0
        je	     short M010_@@NORMAL_ATTR
        mov     al,80h
        jmp     short M010_@@MERGE_ATTR
M010_@@NORMAL_ATTR:
        mov     al,0
M010_@@MERGE_ATTR:
        mov     dl,12h
        or	     dl,al
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        or	     byte ptr es:[si+6],dl
        mov     word ptr es:[si+8],0
        push    si
        db	     9Ah
        dw	     X02C_0E
        dw	     seg X02C_0E
        mov     word ptr [bp-2],ax
        push    word ptr [bp-2]
        cmp     byte ptr [bp-3],0
        je	     short M010_@@ORDINARY_ATTR
        mov     ax,10h
        jmp     short M010_@@APPLY_ATTR
M010_@@ORDINARY_ATTR:
        mov     ax,4
M010_@@APPLY_ATTR:
        push    ax
        db	     9Ah
        dw	     X02C_14
        dw	     seg X02C_14
        cmp     byte ptr DGROUP:BCC_RD_133E_B,0
        je	     short M010_@@RETURN
        push    word ptr [bp-2]
        mov     ax,200h
        push    ax
        db	     9Ah
        dw	     X02C_14
        dw	     seg X02C_14
M010_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_VIRTUAL	     endp
CO03F_TEXT	     ends

; END TVIRT
; BEGIN TRELINK (listing ovr_1cd3_883b:9C51)
        extrn   BCC_EXPR_CURRENT2:word
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_RD_62F4_W:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   X00A_03:far
        extrn   X019_05:far
        extrn   X040_02:far
        extrn   X02C_21:far
        extrn   X00F_11:far
        extrn   X02C_1A:far
        extrn   X019_03:far
   	     extrn   BCC_RD_62FE_W:word
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_62E8_W:word
   	     extrn   BCC_RD_E81E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_0E
X03F_0E label   far
BCC_TYPE_RELINK proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        push    word ptr DGROUP:BCC_RD_62FE_W
        db	     9Ah
        dw	     X00A_03
        dw	     seg X00A_03
        or	     ax,dx
        jne     short M011_@@TYPE_OK
        mov     ax,10Ah
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M011_@@TYPE_OK:
        mov     ax,word ptr DGROUP:BCC_EXPR_CURRENT2
        mov     word ptr DGROUP:BCC_RD_62F6_W,ax
        db	     9Ah
        dw	     X040_02
        dw	     seg X040_02
        push    word ptr DGROUP:BCC_RD_62F6_W
        push    word ptr DGROUP:BCC_RD_62E8_W
        db	     9Ah
        dw	     X02C_21
        dw	     seg X02C_21
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        or	     byte ptr es:[si+4],0A0h
        mov     ax,word ptr es:[si+6]
        mov     word ptr [bp-2],ax
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     si,word ptr es:[bx+2]
        jmp     short M011_@@LOOP_TEST
M011_@@MEMBER_LOOP:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        test    byte ptr es:[si+4],3
        jne     short M011_@@MEMBER_ERROR
        push    si
        push    word ptr [bp-2]
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        push    word ptr es:[bx+2]
        push    word ptr DGROUP:BCC_RD_62F4_W
        db	     9Ah
        dw	     X00F_11
        dw	     seg X00F_11
        mov     di,ax
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+2],di
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        push    word ptr es:[di+2]
        push    word ptr DGROUP:BCC_RD_62E8_W
        push    di
        db	     9Ah
        dw	     X02C_1A
        dw	     seg X02C_1A
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     ax,word ptr DGROUP:BCC_RD_62E8_W
        mov     word ptr es:[di+0Ah],ax
        or	     byte ptr es:[di+4],20h
        jmp     short M011_@@NEXT_MEMBER
M011_@@MEMBER_ERROR:
        mov     ax,112h
        push    ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M011_@@NEXT_MEMBER:
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     si,word ptr es:[si]
M011_@@LOOP_TEST:
        or	     si,si
        je	     short M011_@@RETURN
        db	     0E9h
        dw	     0FF7Bh
M011_@@RETURN:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_RELINK endp
CO03F_TEXT	     ends

; END TRELINK
; BEGIN TBASE (listing ovr_1cd3_883b:9D39)

        extrn   BCC_RD_F23E_W:word
        extrn   BCC_RD_62F4_W:word
        extrn   BCC_RD_630F_W:word
        extrn   BCC_EXPR_OFFSET2:word
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   X019_05:far
        extrn   X00A_01:far
   	     extrn   BCC_RD_62E8_W:word
   	     extrn   BCC_RD_E81E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_12
X03F_12 label   far
BCC_TYPE_BASE   proc    far
        push    bp
        mov     bp,sp
        push    si
        xor     si,si
        cmp     word ptr DGROUP:BCC_RD_F23E_W,68h
        jne     short M012_@@SCOPE_ZERO
        mov     ax,2
        jmp     short M012_@@SET_SCOPE
M012_@@SCOPE_ZERO:
        xor     ax,ax
M012_@@SET_SCOPE:
        mov     word ptr DGROUP:BCC_RD_62F4_W,ax
        mov     word ptr DGROUP:BCC_RD_630F_W,0
        mov     word ptr DGROUP:BCC_EXPR_OFFSET2,0
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M012_@@FINISH_LIST
        cmp     word ptr DGROUP:BCC_RD_F23E_W,43h
        jne     short M012_@@PARSE_LIST
        mov     ax,0F8h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M012_@@PARSE_LIST:
        db	     0E8h
        dw	     0EBB5h
        mov     si,ax
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M012_@@FINISH_LIST
        mov     ax,0C3h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M012_@@FINISH_LIST:
        push    si
        db	     0E8h
        dw	     0EE32h
        push    word ptr DGROUP:BCC_RD_62E8_W
        xor     ax,ax
        push    ax
        mov     al,1
        push    ax
        db	     9Ah
        dw	     X00A_01
        dw	     seg X00A_01
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+14h],ax
        pop     si
        pop     bp
        retf
BCC_TYPE_BASE   endp
CO03F_TEXT	     ends

; END TBASE
; BEGIN TSCOPE (listing ovr_1cd3_883b:9DB2)

        extrn   BCC_RD_F23E_W:word
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_RD_62F4_W:word
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   X019_05:far
        extrn   X02D_00:far
        extrn   X02D_01:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_09
X03F_09 label   far
BCC_TYPE_SCOPE  proc    far
        push    bp
        mov     bp,sp
        cmp     word ptr DGROUP:BCC_RD_F23E_W,43h
        jne     short M013_@@SELECT_SCOPE
        mov     ax,111h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M013_@@SELECT_SCOPE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Fh
        jne     short M013_@@CHECK_PRIVATE
        mov     word ptr DGROUP:BCC_RD_62F4_W,2
        jmp     short M013_@@SCAN
M013_@@CHECK_PRIVATE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,70h
        jne     short M013_@@SCOPE_PUBLIC
        mov     word ptr DGROUP:BCC_RD_62F4_W,1
        jmp     short M013_@@SCAN
M013_@@SCOPE_PUBLIC:
        mov     word ptr DGROUP:BCC_RD_62F4_W,0
M013_@@SCAN:
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,21h
        je	     short M013_@@SYNC
        mov     ax,0C8h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M013_@@SYNC_LAST
M013_@@SYNC:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M013_@@SYNC_LAST:
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        pop     bp
        retf
BCC_TYPE_SCOPE  endp
CO03F_TEXT	     ends

; END TSCOPE
; BEGIN TENUM (listing ovr_1cd3_883b:9E0C)

        extrn   BCC_RD_62E8_W:word
        extrn   BCC_RD_630A_B:byte
        extrn   BCC_RD_62FE_W:word
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_RD_62FA_W:word
        extrn   BCC_TYPE_DEFAULT_SCOPE:word
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_EXPR_COUNT:word
        extrn   BCC_TEXT_13A2:byte
        extrn   X00A_01:far
        extrn   BCC_STRUCT_COPY:far
        extrn   X010_00:far
        extrn   X02D_00:far
        extrn   X019_05:far
        extrn   X02D_01:far
        extrn   X01A_01:far
        extrn   X019_06:far
   	     extrn   BCC_RD_FC3E_W:word
   	     extrn   BCC_RD_62FC_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_0A
X03F_0A label   far
BCC_TYPE_ENUM   proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    word ptr DGROUP:BCC_RD_62E8_W
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X00A_01
        dw	     seg X00A_01
        push    ax
        mov     ax,offset DGROUP:BCC_RD_630A_B
        mov     dx,ds
        mov     cx,4
        db	     9Ah
        dw	     BCC_STRUCT_COPY
        dw	     seg BCC_STRUCT_COPY
        db	     9Ah
        dw	     X010_00
        dw	     seg X010_00
        mov     word ptr DGROUP:BCC_RD_62FE_W,ax
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        jne     short M014_@@SET_KIND
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M014_@@NORMALIZE_TOKEN
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M014_@@SET_KIND
M014_@@NORMALIZE_TOKEN:
        mov     word ptr DGROUP:BCC_RD_62FC_W,6Bh
M014_@@SET_KIND:
        mov     word ptr DGROUP:BCC_RD_62FA_W,3
        mov     ax,word ptr DGROUP:BCC_TYPE_DEFAULT_SCOPE
        mov     word ptr DGROUP:BCC_RD_62F6_W,ax
        push    cs
        db	     0E8h
        dw	     0F9D9h
        mov     word ptr [bp-2],ax
        cmp     word ptr DGROUP:BCC_RD_C23E_W,7
        jne     short M014_@@CHECK_TAIL
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,5
        jne     short M014_@@CHECK_TAIL
        mov     ax,78h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M014_@@CHECK_TAIL:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M014_@@EVALUATE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M014_@@NOT_CLOSED
M014_@@EVALUATE:
        push    word ptr [bp-2]
        db	     9Ah
        dw	     X01A_01
        dw	     seg X01A_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,7
        jne     short M014_@@CLOSED
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M014_@@CLOSED:
        mov     al,1
        jmp     short M014_@@RETURN
M014_@@NOT_CLOSED:
        cmp     word ptr DGROUP:BCC_EXPR_COUNT,0
        jle     short M014_@@NOT_VALID
        mov     ax,13Ah
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_13A2
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M014_@@NOT_VALID:
        mov     al,0
M014_@@RETURN:
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_ENUM   endp
CO03F_TEXT	     ends

; END TENUM
; BEGIN TDEFER (listing ovr_1cd3_883b:9ECD)
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_PARAM_SEGMENT:word
        extrn   BCC_EXPR_DEFAULT:word
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_RD_5F2C_W:word
        extrn   BCC_TYPE_LOCAL:word
        extrn   BCC_RD_62FE_W:word
        extrn   BCC_RD_62F4_W:word
        extrn   BCC_MEMBER_SEGMENT:word
        extrn   X040_02:far
        extrn   X02C_21:far
   	     extrn   BCC_RD_0F3E_W:word
   	     extrn   BCC_RD_630F_W:word
   	     extrn   BCC_RD_E81E_W:word
   	     extrn   BCC_RD_62E8_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_04
X03F_04 label   far
BCC_TYPE_DEFER  proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        cmp     word ptr DGROUP:BCC_RD_0F3E_W,0
        jne     short M015_@@APPLY
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+18h],0C00h
        jne     short M015_@@APPLY
        db	     0E9h
        dw	     0009Ch
M015_@@APPLY:
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     ax,word ptr DGROUP:BCC_RD_630F_W
        mov     word ptr es:[bx+10h],ax
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     si,word ptr es:[bx+0Ch]
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     byte ptr es:[8],1
        jmp     short M015_@@SCAN_TEST
M015_@@SCAN_NEXT:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     si,word ptr es:[si]
M015_@@SCAN_TEST:
        mov     es,word ptr DGROUP:BCC_PARAM_SEGMENT
        mov     al,byte ptr es:[si+8]
        mov     ah,0
        or	     ax,ax
        je	     short M015_@@SCAN_NEXT
        or	     si,si
        jne     short M015_@@RETURN
        mov     ax,word ptr DGROUP:BCC_EXPR_DEFAULT
        mov     word ptr DGROUP:BCC_RD_62F6_W,ax
        mov     bx,word ptr DGROUP:BCC_RD_E81E_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        test    word ptr es:[bx+18h],100h
        je	     short M015_@@LOCAL_TYPE
        mov     ax,word ptr DGROUP:BCC_RD_5F2C_W
        jmp     short M015_@@SET_TYPE
M015_@@LOCAL_TYPE:
        mov     ax,word ptr DGROUP:BCC_TYPE_LOCAL
M015_@@SET_TYPE:
        mov     word ptr DGROUP:BCC_RD_62FE_W,ax
        mov     word ptr DGROUP:BCC_RD_62F4_W,4
        db	     9Ah
        dw	     X040_02
        dw	     seg X040_02
        push    word ptr DGROUP:BCC_RD_62F6_W
        push    word ptr DGROUP:BCC_RD_62E8_W
        db	     9Ah
        dw	     X02C_21
        dw	     seg X02C_21
        mov     di,ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        or	     byte ptr es:[di+4],80h
M015_@@RETURN:
        pop     di
        pop     si
        pop     bp
        retf
BCC_TYPE_DEFER  endp
CO03F_TEXT	     ends

; END TDEFER
; BEGIN TASSIGN (listing ovr_1cd3_883b:9F94)

        extrn   BCC_RD_FA3E_W:word
        extrn   BCC_RD_62FE_W:word
        extrn   BCC_RD_630A_B:byte
        extrn   BCC_RD_62F6_W:word
        extrn   X019_05:far
        extrn   BCC_STRUCT_COPY:far
        extrn   X000_06:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_0B
X03F_0B label   far
BCC_TYPE_APPLY  proc    far
        push    bp
        mov     bp,sp
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,0
        je	     short M016_@@APPLY
        mov     ax,79h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M016_@@RETURN
M016_@@APPLY:
        push    word ptr DGROUP:BCC_RD_62FE_W
        mov     ax,offset DGROUP:BCC_RD_630A_B
        mov     dx,ds
        mov     cx,4
        db	     9Ah
        dw	     BCC_STRUCT_COPY
        dw	     seg BCC_STRUCT_COPY
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X000_06
        dw	     seg X000_06
M016_@@RETURN:
        pop     bp
        retf
BCC_TYPE_APPLY  endp
CO03F_TEXT	     ends

; END TASSIGN
; BEGIN TARRAY (listing ovr_1cd3_883b:9FC5)

        extrn   BCC_RD_C23E_W:word
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_RD_6292_W:word
        extrn   BCC_EXPR_COUNT:word
        extrn   BCC_TEXT_13A2:byte
        extrn   X02D_00:far
        extrn   X019_05:far
        extrn   X02D_01:far
        extrn   X01A_01:far
        extrn   X02C_23:far
        extrn   X019_06:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_08
X03F_08 label   far
BCC_TYPE_ARRAY  proc    far
        push    bp
        mov     bp,sp
        push    si
        push    cs
        db	     0E8h
        dw	     0EF52h
        mov     si,ax
        cmp     word ptr DGROUP:BCC_RD_C23E_W,7
        jne     short M017_@@CHECK_CLOSE
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,5
        jne     short M017_@@CHECK_CLOSE
        mov     ax,78h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M017_@@CHECK_CLOSE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        jne     short M017_@@NOT_ARRAY
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[bx],12h
        jne     short M017_@@NOT_ARRAY
        cmp     word ptr [bp+6],1
        jbe     short M017_@@EVAL
        mov     ax,0FCh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M017_@@EVAL:
        push    si
        db	     9Ah
        dw	     X01A_01
        dw	     seg X01A_01
        push    word ptr DGROUP:BCC_RD_6292_W
        push    si
        db	     9Ah
        dw	     X02C_23
        dw	     seg X02C_23
        mov     word ptr DGROUP:BCC_RD_6292_W,ax
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        and     al,7
        or	     al,18h
        mov     byte ptr es:[si+7],al
        cmp     word ptr DGROUP:BCC_RD_C23E_W,7
        jne     short M017_@@VALID
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M017_@@VALID:
        mov     al,1
        jmp     short M017_@@RETURN
M017_@@NOT_ARRAY:
        cmp     word ptr DGROUP:BCC_EXPR_COUNT,0
        jle     short M017_@@INVALID
        mov     ax,13Ah
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_13A2
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M017_@@INVALID:
        mov     al,0
M017_@@RETURN:
        pop     si
        pop     bp
        retf    2
BCC_TYPE_ARRAY  endp
CO03F_TEXT	     ends

; END TARRAY
; BEGIN TRECORD (listing ovr_1cd3_883b:A06D)
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_RD_62E8_W:word
        extrn   BCC_RD_6306_B:byte
        extrn   BCC_TYPE_DEFAULT_SCOPE:word
        extrn   BCC_RD_6304_B:byte
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_RD_62FE_W:word
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_EXPR_COUNT:word
        extrn   BCC_TEXT_13A2:byte
        extrn   X02C_22:far
        extrn   X019_03:far
        extrn   X02C_12:far
        extrn   X021_03:far
        extrn   X019_06:far
        extrn   X02D_00:far
        extrn   X019_05:far
        extrn   X02D_01:far
        extrn   X01A_01:far
   	     extrn   BCC_RD_FA3E_W:word
   	     extrn   BCC_RD_62FA_W:word
   	     extrn   BCC_RD_62F8_W:word
   	     extrn   BCC_RD_F83E_W:word
   	     extrn   BCC_RD_FC3E_W:word
   	     extrn   BCC_RD_62FC_W:word
   	     extrn   BCC_RD_003E_W:word
   	     extrn   BCC_RD_6300_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_0D
X03F_0D label   far
BCC_TYPE_RECORD proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,0
        jne     short M018_@@MEMBER_KIND
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X02C_22
        dw	     seg X02C_22
        mov     si,ax
        or	     si,si
        je	     short M018_@@MEMBER_KIND
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        mov     al,byte ptr es:[si+7]
        mov     ah,0
        sar     ax,1
        sar     ax,1
        sar     ax,1
        cmp     ax,0Bh
        jne     short M018_@@MEMBER_KIND
        mov     ax,word ptr es:[si+4]
        cmp     ax,word ptr DGROUP:BCC_RD_62E8_W
        jne     short M018_@@MEMBER_KIND
        mov     word ptr DGROUP:BCC_RD_62FA_W,3
        mov     al,byte ptr DGROUP:BCC_RD_6306_B
        mov     ah,0
        or	     ax,ax
        jne     short M018_@@RESET_EXPR
        mov     ax,76h
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M018_@@RESET_EXPR:
        mov     ax,word ptr DGROUP:BCC_TYPE_DEFAULT_SCOPE
        mov     word ptr DGROUP:BCC_RD_62F6_W,ax
M018_@@MEMBER_KIND:
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X02C_12
        dw	     seg X02C_12
        mov     word ptr DGROUP:BCC_RD_62F8_W,ax
        mov     byte ptr DGROUP:BCC_RD_6304_B,0
        cmp     word ptr DGROUP:BCC_RD_003E_W,0
        je	     short M018_@@NORMALIZE_TOKEN
        mov     ax,word ptr DGROUP:BCC_RD_6300_W
        cmp     ax,word ptr DGROUP:BCC_RD_62E8_W
        je	     short M018_@@NORMALIZE_TOKEN
        mov     ax,0FDh
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M018_@@NORMALIZE_TOKEN:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        jne     short M018_@@CHECK_FRIEND
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M018_@@NORMALIZE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M018_@@CHECK_FRIEND
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,3
        jne     short M018_@@CHECK_FRIEND
M018_@@NORMALIZE:
        mov     word ptr DGROUP:BCC_RD_62FC_W,6Bh
M018_@@CHECK_FRIEND:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,35h
        jne     short M018_@@DEFINE
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,0
        je	     short M018_@@FRIEND_OK
        cmp     word ptr DGROUP:BCC_RD_F83E_W,6Ch
        je	     short M018_@@FRIEND_OK
        cmp     word ptr DGROUP:BCC_RD_F83E_W,69h
        je	     short M018_@@FRIEND_OK
        mov     ax,115h
        push    ax
        push    word ptr DGROUP:BCC_RD_62F6_W
        push    word ptr DGROUP:BCC_RD_62FA_W
        push    word ptr DGROUP:BCC_RD_62FE_W
        push    word ptr DGROUP:BCC_RD_62E8_W
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
        jmp     short M018_@@FRIEND_DONE
M018_@@FRIEND_OK:
        mov     byte ptr DGROUP:BCC_RD_6304_B,1
M018_@@FRIEND_DONE:
        mov     word ptr DGROUP:BCC_RD_62FC_W,82h
M018_@@DEFINE:
        push    cs
        db	     0E8h
        dw	     0F6CDh
        mov     word ptr [bp-2],ax
        cmp     word ptr DGROUP:BCC_RD_C23E_W,7
        jne     short M018_@@CHECK_TAIL
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,5
        jne     short M018_@@CHECK_TAIL
        mov     ax,78h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M018_@@CHECK_TAIL:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,5
        je	     short M018_@@EVALUATE_COUNT
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M018_@@NOT_CLOSED
M018_@@CHECK_KIND_TAIL:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,3
        jne     short M018_@@NOT_CLOSED
M018_@@EVALUATE_COUNT:
        cmp     word ptr [bp+6],1
        jbe     short M018_@@EVALUATE
        mov     ax,0FCh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M018_@@EVALUATE:
        push    word ptr [bp-2]
        db	     9Ah
        dw	     X01A_01
        dw	     seg X01A_01
        cmp     word ptr DGROUP:BCC_RD_C23E_W,7
        jne     short M018_@@VALID
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
M018_@@VALID:
        mov     al,1
        jmp     short M018_@@RETURN
M018_@@NOT_CLOSED:
        cmp     word ptr DGROUP:BCC_EXPR_COUNT,0
        jle     short M018_@@INVALID
        mov     ax,13Ah
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_13A2
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
M018_@@INVALID:
        mov     al,0
M018_@@RETURN:
        pop     si
        mov     sp,bp
        pop     bp
        retf    2
BCC_TYPE_RECORD endp
CO03F_TEXT	     ends

; END TRECORD
; BEGIN TCLASS (listing ovr_1cd3_883b:A1F2)
        extrn   BCC_TREE_LOOKAHEAD:word
        extrn   BCC_TYPE_NAME:word
        extrn   BCC_RD_62E8_W:word
        extrn   BCC_RD_6305_B:byte
        extrn   BCC_RD_62F6_W:word
        extrn   BCC_RD_6304_B:byte
        extrn   BCC_RD_630A_B:byte
        extrn   BCC_EXPR_TEMP2:byte
        extrn   BCC_RD_6300_W:word
        extrn   BCC_RD_6307_B:byte
        extrn   BCC_RD_6382_B:byte
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   BCC_TYPE_SEGMENT:word
        extrn   BCC_EXPR_FLAGS:byte
        extrn   X02D_00:far
        extrn   X03D_02:far
        extrn   BCC_STRUCT_COPY2:far
        extrn   X03D_01:far
        extrn   X02D_01:far
        extrn   X010_04:far
        extrn   X019_03:far
        extrn   BCC_PARSE_STATE_CHECK:far
        extrn   X019_05:far
   	     extrn   BCC_RD_62FE_W:word
   	     extrn   BCC_RD_FE3E_W:word
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_62FC_W:word
   	     extrn   BCC_RD_FC3E_W:word
   	     extrn   BCC_RD_FC1E_W:word
   	     extrn   BCC_RD_6302_B:byte
   	     extrn   BCC_RD_6303_B:byte
   	     extrn   BCC_RD_033E_B:byte
   	     extrn   BCC_RD_C23E_W:word
   	     extrn   BCC_RD_C21E_W:word


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

M019_BCC_TOKEN_FLAGS    equ     07B3h
M019_BCC_TOKEN_NAMES    equ     6182h

   	     public  X03F_11
X03F_11 label   far
BCC_TYPE_CLASSIFY	     proc    far
        push    bp
        mov     bp,sp
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Fh
        je	     short M019_@@RETURN_TWO
        cmp     word ptr DGROUP:BCC_RD_C23E_W,71h
        je	     short M019_@@RETURN_TWO
        cmp     word ptr DGROUP:BCC_RD_C23E_W,70h
        jne     short M019_@@CHECK_OPERATOR
M019_@@RETURN_TWO:
        mov     ax,2
        db	     0E9h
        dw	     001A5h
M019_@@CHECK_OPERATOR:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,31h
        jne     short M019_@@INITIALIZE
        db	     9Ah
        dw	     X02D_00
        dw	     seg X02D_00
        cmp     word ptr DGROUP:BCC_TREE_LOOKAHEAD,67h
        jne     short M019_@@INITIALIZE
        push    word ptr DGROUP:BCC_TYPE_NAME
        db	     9Ah
        dw	     X03D_02
        dw	     seg X03D_02
        cmp     ax,word ptr DGROUP:BCC_RD_62E8_W
        je	     short M019_@@INITIALIZE
        mov     ax,3
        db	     0E9h
        dw	     0017Dh
M019_@@INITIALIZE:
        mov     word ptr DGROUP:BCC_RD_62FC_W,82h
        mov     al,0
        mov     byte ptr DGROUP:BCC_RD_6302_B,al
        mov     byte ptr DGROUP:BCC_RD_6303_B,al
        mov     word ptr DGROUP:BCC_RD_62FE_W,0
        mov     byte ptr DGROUP:BCC_RD_6305_B,0
        mov     word ptr DGROUP:BCC_RD_62F6_W,0
        mov     byte ptr DGROUP:BCC_RD_6304_B,0
        mov     ax,offset DGROUP:BCC_RD_630A_B
        push    ds
        push    ax
        mov     ax,offset DGROUP:BCC_EXPR_TEMP2
        push    ds
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_STRUCT_COPY2
        dw	     seg BCC_STRUCT_COPY2
        mov     word ptr DGROUP:BCC_RD_6300_W,0
        mov     byte ptr DGROUP:BCC_RD_6307_B,0
        push    ds
        mov     ax,offset DGROUP:BCC_RD_6382_B
        push    ax
        db	     9Ah
        dw	     X03D_01
        dw	     seg X03D_01
        or	     al,al
        je	     short M019_@@AFTER_PARSE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,6Bh
        jne     short M019_@@PARSE_DECL
        db	     9Ah
        dw	     X02D_01
        dw	     seg X02D_01
        mov     word ptr DGROUP:BCC_RD_62FC_W,6Bh
M019_@@PARSE_DECL:
        mov     ax,2
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_62FC_W
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_6303_B
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_6302_B
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_62FE_W
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_630A_B
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_6305_B
        push    ax
        db	     9Ah
        dw	     X010_04
        dw	     seg X010_04
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        je	     short M019_@@AFTER_PARSE
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,35h
        je	     short M019_@@AFTER_PARSE
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,6Bh
        je	     short M019_@@AFTER_PARSE
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,37h
        je	     short M019_@@AFTER_PARSE
        mov     ax,82h
        push    ax
        mov     bx,word ptr DGROUP:BCC_RD_FC1E_W
        shl     bx,1
        push    word ptr [bx+M019_BCC_TOKEN_NAMES]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
        mov     word ptr DGROUP:BCC_RD_62FC_W,82h
M019_@@AFTER_PARSE:
        mov     ax,word ptr DGROUP:BCC_RD_62FE_W
        cmp     ax,word ptr DGROUP:BCC_RD_62E8_W
        jne     short M019_@@CHECK_TREE_FLAGS
        cmp     word ptr DGROUP:BCC_RD_C23E_W,1
        jne     short M019_@@CHECK_TREE_FLAGS
        push    cs
        db	     0E8h
        dw	     0E0A6h
        or	     al,al
        je	     short M019_@@CHECK_TREE_FLAGS
        mov     ax,6
        db	     0E9h
        dw	     000A1h
M019_@@CHECK_TREE_FLAGS:
        mov     bx,word ptr DGROUP:BCC_RD_C21E_W
        shl     bx,1
        test    word ptr [bx+M019_BCC_TOKEN_FLAGS],10h
        jne     short M019_@@RETURN_ONE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        je	     short M019_@@RETURN_ONE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,2Bh
        jne     short M019_@@CHECK_STATE
M019_@@RETURN_ONE:
        mov     ax,1
        db	     0E9h
        dw	     0007Fh
M019_@@CHECK_STATE:
        cmp     byte ptr DGROUP:BCC_RD_033E_B,0
        je	     short M019_@@CHECK_ACTIVE
        mov     ax,5
        jmp     short M019_@@RETURN
M019_@@CHECK_ACTIVE:
        cmp     word ptr DGROUP:BCC_RD_FE3E_W,0
        je	     short M019_@@CHECK_INVALID
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        cmp     word ptr es:[bx],14h
        jne     short M019_@@CHECK_INVALID
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+2],0
        jne     short M019_@@CHECK_INVALID
        mov     ax,4
        jmp     short M019_@@RETURN
M019_@@CHECK_INVALID:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        cmp     word ptr es:[bx],15h
        je	     short M019_@@RETURN_ZERO
        mov     bx,word ptr es:[bx]
        mov     al,byte ptr [bx+09CAh]
        mov     ah,0
        test    ax,40h
        je	     short M019_@@INVALID
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     bx,word ptr es:[bx+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     bx,word ptr es:[bx+6]
        mov     es,word ptr DGROUP:BCC_TYPE_SEGMENT
        cmp     word ptr es:[bx+2],0
        jne     short M019_@@RETURN_ZERO
M019_@@INVALID:
        mov     ax,0B3h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M019_@@RETURN_ZERO:
        xor     ax,ax
M019_@@RETURN:
        pop     bp
        retf
BCC_TYPE_CLASSIFY	     endp
CO03F_TEXT	     ends

; END TCLASS
; BEGIN TDISPAT (listing ovr_1cd3_883b:A3B7)
        extrn   BCC_RD_6300_W:word
        extrn   BCC_RD_C23E_W:word
        extrn   BCC_RD_629E_W:word
        extrn   BCC_TREE_BASE:word
        extrn   BCC_RD_630A_B:byte
        extrn   BCC_RD_821E_W:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_RD_053E_B:byte
        extrn   BCC_RD_F23E_W:word
        extrn   BCC_TEXT_82:byte
        extrn   X019_05:far
        extrn   X010_06:far
        extrn   X019_03:far
        extrn   X019_06:far
   	     extrn   BCC_RD_62FE_W:word
   	     extrn   BCC_RD_FE1E_W:word
   	     extrn   BCC_RD_62F6_W:word
   	     extrn   BCC_RD_F63E_W:word
   	     extrn   BCC_RD_62FA_W:word
   	     extrn   BCC_RD_FA3E_W:word
   	     extrn   BCC_RD_FC3E_W:word
   	     extrn   BCC_RD_FC1E_W:word
   	     extrn   BCC_RD_6306_B:byte
   	     extrn   BCC_RD_063E_B:byte
   	     extrn   BCC_RD_6303_B:byte
   	     extrn   BCC_RD_033E_B:byte


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

M01A_BCC_TOKEN_NAMES    equ     6182h

   	     public  X03F_01
X03F_01 label   far
BCC_TYPE_DISPATCH	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        mov     si,word ptr DGROUP:BCC_RD_62FE_W
        mov     byte ptr DGROUP:BCC_RD_6306_B,0
        mov     word ptr DGROUP:BCC_RD_6300_W,0
        or	     si,si
        jne     short M01A_@@HAVE_TYPE
        cmp     word ptr DGROUP:BCC_RD_C23E_W,2Bh
        jne     short M01A_@@TREE_TYPE
        mov     ax,word ptr DGROUP:BCC_RD_629E_W
        jmp     short M01A_@@SET_TYPE
M01A_@@TREE_TYPE:
        mov     ax,word ptr DGROUP:BCC_TREE_BASE
M01A_@@SET_TYPE:
        mov     word ptr DGROUP:BCC_RD_62FE_W,ax
        mov     byte ptr DGROUP:BCC_RD_6306_B,1
        jmp     short M01A_@@PARSE
M01A_@@HAVE_TYPE:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,2Bh
        jne     short M01A_@@PARSE
        mov     ax,7Eh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M01A_@@PARSE:
        push    word ptr DGROUP:BCC_RD_62FE_W
        mov     ax,2
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_62FE_W
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_62F6_W
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_62FA_W
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_6300_W
        push    ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_630A_B
        push    ax
        push    ss
        lea     ax,[bp-4]
        push    ax
        db	     9Ah
        dw	     X010_06
        dw	     seg X010_06
        cmp     word ptr DGROUP:BCC_RD_F63E_W,0
        jne     short M01A_@@HAVE_EXPR
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M01A_@@MISSING_EXPR
M01A_@@RETURN_TWO:
        mov     ax,2
        db	     0E9h
        dw	     00115h
M01A_@@MISSING_EXPR:
        mov     ax,0D4h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        mov     bx,word ptr DGROUP:BCC_RD_821E_W
        shl     bx,1
        mov     ax,word ptr [bx+M01A_BCC_TOKEN_NAMES]
        mov     word ptr DGROUP:BCC_RD_62F6_W,ax
        jmp     short M01A_@@CLASSIFY
M01A_@@HAVE_EXPR:
        cmp     byte ptr DGROUP:BCC_RD_063E_B,0
        je	     short M01A_@@CLASSIFY
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        cmp     word ptr es:[bx],12h
        je	     short M01A_@@CLASSIFY
        mov     al,byte ptr DGROUP:BCC_RD_6303_B
        mov     ah,0
        or	     ax,ax
        jne     short M01A_@@CLASSIFY
        mov     bx,word ptr es:[bx]
        test    byte ptr [bx+09CAh],14h
        je	     short M01A_@@CHECK_TOKEN
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        mov     bx,word ptr es:[bx+7]
        cmp     word ptr es:[bx],12h
        je	     short M01A_@@CLASSIFY
M01A_@@CHECK_TOKEN:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        jne     short M01A_@@CLASSIFY
        mov     ax,0F7h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M01A_@@CLASSIFY:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,37h
        jne     short M01A_@@CHECK_STATE
        mov     ax,4
        db	     0E9h
        dw	     000A9h
M01A_@@CHECK_STATE:
        cmp     byte ptr DGROUP:BCC_RD_033E_B,0
        je	     short M01A_@@CHECK_ARRAY
        mov     ax,5
        db	     0E9h
        dw	     0009Ch
M01A_@@CHECK_ARRAY:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_FE1E_W
        cmp     word ptr es:[bx],12h
        jne     short M01A_@@CHECK_FRIEND
        cmp     si,word ptr DGROUP:BCC_RD_62FE_W
        jne     short M01A_@@ARRAY
        cmp     byte ptr DGROUP:BCC_RD_053E_B,0
        je	     short M01A_@@ARRAY
        mov     ax,0F3h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M01A_@@ARRAY:
        mov     ax,6
        jmp     short M01A_@@RETURN
M01A_@@CHECK_FRIEND:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,35h
        jne     short M01A_@@FINISH
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M01A_@@CHECK_OP
        mov     ax,0EDh
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
        jmp     short M01A_@@FINISH
M01A_@@CHECK_OP:
        cmp     word ptr DGROUP:BCC_RD_F23E_W,43h
        jne     short M01A_@@RETURN_SEVEN
        mov     ax,82h
        push    ax
        push    ds
        mov     ax,offset BCC_TEXT_82
        push    ax
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        db	     9Ah
        dw	     X019_06
        dw	     seg X019_06
        jmp     short M01A_@@FINISH
M01A_@@RETURN_SEVEN:
        mov     ax,7
        jmp     short M01A_@@RETURN
M01A_@@FINISH:
        cmp     word ptr DGROUP:BCC_RD_FC3E_W,82h
        je	     short M01A_@@CHECK_KIND
        mov     ax,82h
        push    ax
        mov     bx,word ptr DGROUP:BCC_RD_FC1E_W
        shl     bx,1
        push    word ptr [bx+M01A_BCC_TOKEN_NAMES]
        db	     9Ah
        dw	     X019_03
        dw	     seg X019_03
M01A_@@CHECK_KIND:
        cmp     word ptr DGROUP:BCC_RD_FA3E_W,0
        je	     short M01A_@@CHECK_COLON
        mov     ax,0D4h
        push    ax
        db	     9Ah
        dw	     X019_05
        dw	     seg X019_05
M01A_@@CHECK_COLON:
        cmp     word ptr DGROUP:BCC_RD_C23E_W,21h
        jne     short M01A_@@RETURN_THREE
        db	     0E9h
        dw	     0FEE8h
M01A_@@RETURN_THREE:
        mov     ax,3
M01A_@@RETURN:
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_TYPE_DISPATCH	     endp
CO03F_TEXT	     ends

; END TDISPAT
; BEGIN TATTACH (listing ovr_1cd3_883b:A553)

        extrn   BCC_MEMBER_SEGMENT:word
        extrn   BCC_RD_62E8_W:word
        extrn   BCC_EXPR_SEGMENT:word
        extrn   BCC_EXPR_LINKSEG:word
        extrn   X02C_16:far


CO03F_TEXT	     segment byte public 'CODE'
        assume  cs:CO03F_TEXT,ds:DGROUP

   	     public  X03F_0C
X03F_0C label   far
BCC_TYPE_ATTACH proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     si,word ptr [bp+0Ch]
        push    word ptr [bp+0Ah]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     X02C_16
        dw	     seg X02C_16
        mov     di,ax
        mov     es,word ptr DGROUP:BCC_MEMBER_SEGMENT
        mov     word ptr es:[di+8],si
        mov     ax,word ptr [bp+6]
        mov     word ptr es:[di+6],ax
        mov     ax,word ptr DGROUP:BCC_RD_62E8_W
        mov     word ptr es:[di+0Ah],ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        cmp     word ptr es:[bx+2],0
        jne     short M01B_@@RETURN
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[si+5]
        mov     es,word ptr DGROUP:BCC_EXPR_LINKSEG
        mov     word ptr es:[bx+2],di
M01B_@@RETURN:
        pop     di
        pop     si
        pop     bp
        retf    8
BCC_TYPE_ATTACH endp
CO03F_TEXT	     ends

; END TATTACH
   	     end
