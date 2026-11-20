   	     public  X02F_00
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1c8d_7ca3
; BEGIN POOLCOPY (listing ovr_1c8d_7ca3:CA30)

        extrn   BCC_POOL_CREATE_BLOCK:far
        extrn   X043_03:far
        extrn   BCC_POOL_INDEX:word
        extrn   BCC_POOL_TABLE:byte


CO02F_TEXT	     segment byte public 'CODE'
        assume  cs:CO02F_TEXT,ds:DGROUP

BCC_POOL_COPY   proc    near
        inc     bp
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     ax,word ptr DGROUP:BCC_POOL_INDEX
        shl     ax,1
        shl     ax,1
        shl     ax,1
        add     ax,offset DGROUP:BCC_POOL_TABLE
        mov     word ptr [bp-2],ax
        mov     bx,word ptr [bp-2]
        mov     ax,word ptr [bx+4]
        add     ax,word ptr [bp+4]
        cmp     ax,0ff00h
        jc	     short M000_@@ALLOCATE
        inc     word ptr DGROUP:BCC_POOL_INDEX
        add     word ptr [bp-2],8
        mov     bx,word ptr [bp-2]
        mov     ax,1
        mov     word ptr [bx+2],ax
        mov     word ptr [bx+4],ax
        mov     word ptr [bx+6],0
        push    ds
        push    word ptr [bp-2]
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     BCC_POOL_CREATE_BLOCK
        dw	     seg BCC_POOL_CREATE_BLOCK
M000_@@ALLOCATE:
        push    ds
        push    word ptr [bp-2]
        push    word ptr [bp+4]
        db	     9Ah
        dw	     X043_03
        dw	     seg X043_03
        mov     di,ax
        mov     bx,word ptr [bp-2]
        mov     dx,bx
        mov     es,word ptr [bx]
        mov     cx,word ptr [bp+4]
        push    ds
        lds     si,dword ptr [bp+6]
        shr     cx,1
        rep     movsw
        adc     cx,cx
        rep     movsb
        pop     ds
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     6
BCC_POOL_COPY   endp
CO02F_TEXT	     ends

; Original-target semantic	aliases	(zero bytes)
BCC_DIRECTIVE_DECODE    equ     BCC_POOL_COPY+21Fh
; END POOLCOPY
; BEGIN POOLINT (listing ovr_1c8d_7ca3:CAA9)

        extrn   X043_03:far
        extrn   BCC_POOL_HASH:word
   	     extrn   BCC_RD_783A_W:word
   	     extrn   BCC_RD_3A06_W:word
   	     extrn   BCC_RD_7832_W:word
   	     extrn   BCC_RD_3206_W:word


CO02F_TEXT	     segment byte public 'CODE'
        assume  cs:CO02F_TEXT,ds:DGROUP

   	     public  X02F_00
X02F_00 label   far
BCC_POOL_INTERN proc    far
        push    bp
        mov     bp,sp
        sub     sp,8
        push    si
        push    di
        cld
        les     di,dword ptr [bp+8]
        mov     cx,0ffffh
        xor     al,al
        repne   scasb
        not     cx
        mov     word ptr [bp-6],cx
        cmp     word ptr [bp-6],2
        jbe     short M001_@@SHORT_STRING
        mov     ax,word ptr [bp-6]
        mov     cl,6
        shl     ax,cl
        les     bx,dword ptr [bp+8]
        add     ax,word ptr es:[bx]
        mov     dx,word ptr [bp-6]
        sub     dx,3
        add     bx,dx
        mov     dx,word ptr es:[bx]
        shl     dx,1
        shl     dx,1
        shl     dx,1
        add     ax,dx
        and     ax,03ffh
        jmp     short M001_@@HASH_READY
M001_@@SHORT_STRING:
        les     bx,dword ptr [bp+8]
        mov     al,byte ptr es:[bx]
        cbw
M001_@@HASH_READY:
        mov     word ptr [bp-8],ax
        mov     bx,word ptr [bp-8]
        shl     bx,1
        cmp     word ptr DGROUP:BCC_POOL_HASH[bx],0
        jne     short M001_@@FIND_ENTRY
        push    ds
        mov     ax,offset DGROUP:BCC_RD_7832_W
        push    ax
        mov     ax,6
        push    ax
        db	     9Ah
        dw	     X043_03
        dw	     seg X043_03
        mov     word ptr [bp-2],ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_783A_W
        push    ax
        mov     ax,6
        push    ax
        db	     9Ah
        dw	     X043_03
        dw	     seg X043_03
        mov     bx,word ptr [bp-8]
        shl     bx,1
        mov     ax,word ptr [bp-2]
        mov     word ptr DGROUP:BCC_POOL_HASH[bx],ax
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     bx,word ptr [bp-2]
        mov     word ptr es:[bx],0
        mov     es,word ptr DGROUP:BCC_RD_3206_W
        mov     word ptr es:[bx],0
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     word ptr es:[bx+2],0
        mov     ax,word ptr [bp+6]
        mov     word ptr es:[bx+4],ax
        push    word ptr [bp+10]
        push    word ptr [bp+8]
        push    word ptr [bp-6]
        db	     0E8h,0D1h,0FEh
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_RD_3206_W
        mov     word ptr es:[bx+4],dx
        mov     word ptr es:[bx+2],ax
        mov     ax,word ptr [bp-2]
        jmp     M001_@@EPILOGUE

M001_@@FIND_ENTRY:
        mov     bx,word ptr [bp-8]
        shl     bx,1
        mov     bx,word ptr DGROUP:BCC_POOL_HASH[bx]
        mov     ax,word ptr [bp-6]
M001_@@COMPARE_ENTRY:
        mov     es,word ptr DGROUP:BCC_RD_3206_W
        mov     si,word ptr es:[bx+4]
        mov     di,word ptr es:[bx+2]
        mov     es,word ptr [si]
        push    ds
        lds     si,dword ptr [bp+8]
        mov     cx,ax
        repe    cmpsb
        pop     ds
        jne     short M001_@@NEXT_ENTRY
        mov     ax,bx
        jmp     short M001_@@EPILOGUE
        nop
M001_@@NEXT_ENTRY:
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     dx,bx
        mov     bx,word ptr es:[bx]
        or	     bx,bx
        jne     short M001_@@COMPARE_ENTRY
        mov     word ptr [bp-2],dx
        push    ds
        mov     ax,offset DGROUP:BCC_RD_7832_W
        push    ax
        mov     ax,6
        push    ax
        db	     9Ah
        dw	     X043_03
        dw	     seg X043_03
        mov     word ptr [bp-4],ax
        push    ds
        mov     ax,offset DGROUP:BCC_RD_783A_W
        push    ax
        mov     ax,6
        push    ax
        db	     9Ah
        dw	     X043_03
        dw	     seg X043_03
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     bx,word ptr [bp-2]
        mov     ax,word ptr [bp-4]
        mov     word ptr es:[bx],ax
        mov     bx,word ptr [bp-4]
        mov     word ptr es:[bx],0
        mov     es,word ptr DGROUP:BCC_RD_3206_W
        mov     word ptr es:[bx],0
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     word ptr es:[bx+2],0
        mov     ax,word ptr [bp+6]
        mov     word ptr es:[bx+4],ax
        push    word ptr [bp+10]
        push    word ptr [bp+8]
        push    word ptr [bp-6]
        db	     0E8h,028h,0FEh
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_RD_3206_W
        mov     word ptr es:[bx+4],dx
        mov     word ptr es:[bx+2],ax
        mov     ax,word ptr [bp-4]
M001_@@EPILOGUE:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    6
BCC_POOL_INTERN endp
CO02F_TEXT	     ends

; END POOLINT
   	     end
