; Recovered FBOV far-pointer references
   	     extrn   BCC_COMPARE_NAME:far
   	     extrn   BCC_DEBUG_BUILD:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_FAR_AB12:far
   	     extrn   BCC_FAR_B0F1:far
CO02F_TEXT	     segment byte public 'CODE'
CO02F_TEXT	     ends
CO043_TEXT	     segment byte public 'CODE'
CO043_TEXT	     ends
   	     public  X033_01
   	     public  X033_00
   	     public  X033_03
   	     public  X033_02
   	     public  X033_04
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1ca3_8307
; BEGIN INPLEN (listing ovr_1ca3_8307:3070)

        extrn   BCC_STRING_LENGTH:far
        extrn   BCC_COMMENT_MODE:byte
   	     extrn   BCC_RD_823E_W:word
   	     extrn   BCC_RD_3E06_W:word


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

BCC_PACKED_LIST_LENGTH  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     si,word ptr [bp+4]
        cmp     byte ptr DGROUP:BCC_COMMENT_MODE,1
        je	     short M000_@@COUNT
        xor     ax,ax
        jmp     short M000_@@DONE
M000_@@COUNT:
        mov     di,1
        jmp     short M000_@@TEST
M000_@@NEXT:
        push    word ptr DGROUP:BCC_RD_823E_W
        push    si
        db	     9Ah
        dw	     BCC_STRING_LENGTH
        dw	     seg BCC_STRING_LENGTH
        inc     ax
        mov     word ptr [bp-2],ax
        add     di,word ptr [bp-2]
        add     si,word ptr [bp-2]
M000_@@TEST:
        mov     es,word ptr DGROUP:BCC_RD_3E06_W
        cmp     byte ptr es:[si],0
        jne     short M000_@@NEXT
        mov     ax,di
M000_@@DONE:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     2
BCC_PACKED_LIST_LENGTH  endp
CO033_TEXT	     ends

; END INPLEN
; BEGIN INPREFIX (listing ovr_1ca3_8307:30B4)

        extrn   BCC_RD_3E06_W:word


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

BCC_COUNTED_COMPARE     proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     si,word ptr [bp+10]
        mov     di,word ptr [bp+4]
        or	     di,di
        jne     short M001_@@TEST
        jmp     short M001_@@EQUAL
M001_@@COMPARE:
        mov     es,word ptr DGROUP:BCC_RD_3E06_W
        mov     al,byte ptr es:[si]
        les     bx,dword ptr [bp+6]
        cmp     al,byte ptr es:[bx]
        je	     short M001_@@MATCHED
        xor     ax,ax
        jmp     short M001_@@DONE
M001_@@MATCHED:
        dec     di
        inc     si
        inc     word ptr [bp+6]
M001_@@TEST:
        or	     di,di
        jne     short M001_@@COMPARE
M001_@@EQUAL:
        mov     ax,1
M001_@@DONE:
        pop     di
        pop     si
        pop     bp
        dec     bp
        ret     8
BCC_COUNTED_COMPARE     endp
CO033_TEXT	     ends

; END INPREFIX
; BEGIN LG0A0 (gap	ovr_1ca3_8307:30EC)
CO033_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO033_TEXT
; Original-image layout stub: not recovered source


X033_03 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,00Ch,056h,057h,0FFh,076h,010h,0FFh,076h,00Eh; ovr_1ca3_8307:30EC
   	     db	     033h,0C0h,050h,09Ah
   	     dw	     020h
   	     dw	     seg CO02F_TEXT
   	     db	     089h,046h,0FEh,08Bh,05Eh,0FEh; ovr_1ca3_8307:30FA
   	     db	     08Eh,006h,03Ah,078h,026h,08Bh,077h,002h,080h,07Eh,008h,000h,074h,011h  ; ovr_1ca3_8307:3108
   	     db	     080h,07Eh,008h,0FFh,074h,00Bh,0FFh,076h,006h,0E8h,04Eh,0FFh,089h,046h  ; ovr_1ca3_8307:3116
   	     db	     0F4h,0EBh,005h,0C7h,046h,0F4h,000h,000h,00Bh,0F6h,075h,003h,0E9h,08Ah  ; ovr_1ca3_8307:3124
   	     db	     000h,0F7h,0C6h,001h,000h,074h,005h,0A1h,0A8h,086h,0EBh,003h,0A1h,090h  ; ovr_1ca3_8307:3132
   	     db	     086h,089h,046h,0FCh,089h,076h,0FAh,08Bh,046h,0FAh,040h,0FFh,076h,0FCh  ; ovr_1ca3_8307:3140
   	     db	     050h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     08Bh,056h,0FCh,08Bh,05Eh,0FAh,003h,0D8h; ovr_1ca3_8307:314E

   	     db	     043h,043h,089h,056h,0F8h,089h,05Eh,0F6h,0C4h,05Eh,0FAh,026h,08Ah,007h  ; ovr_1ca3_8307:315C
   	     db	     03Ah,046h,008h,075h,02Ah,0FFh,076h,00Ch,0FFh,076h,00Ah,08Bh,046h,0FAh  ; ovr_1ca3_8307:316A
   	     db	     040h,0FFh,076h,0FCh,050h,09Ah
   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,075h,013h; ovr_1ca3_8307:3178
   	     db	     0FFh,076h,006h,0FFh,076h,0F8h,0FFh,076h,0F6h,0FFh,076h,0F4h,0E8h,01Fh  ; ovr_1ca3_8307:3186
   	     db	     0FFh,00Bh,0C0h,075h,021h,0FFh,076h,010h,0FFh,076h,00Eh,0B8h,06Dh,001h  ; ovr_1ca3_8307:3194
   	     db	     050h,09Ah
   	     dw	     017Dh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     083h,0C4h,006h,08Bh,05Eh,0FEh,08Eh,006h; ovr_1ca3_8307:31A2

   	     db	     03Ah,078h,026h,0C7h,047h,002h,000h,000h,0EBh,003h,0E9h,0A6h,000h,0FFh  ; ovr_1ca3_8307:31B0
   	     db	     076h,00Ch,0FFh,076h,00Ah,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     003h,046h,0F4h,040h; ovr_1ca3_8307:31BE
   	     db	     040h,08Bh,0F8h,025h,001h,000h,003h,0F8h,0A1h,094h,086h,033h,0D2h,050h  ; ovr_1ca3_8307:31CC
   	     db	     08Bh,0C7h,052h,099h,05Bh,059h,003h,0C8h,013h,0DAh,00Bh,0DBh,07Ch,019h  ; ovr_1ca3_8307:31DA
   	     db	     07Fh,005h,083h,0F9h,0FFh,076h,012h,01Eh,0B8h,0A8h,086h,050h,057h,09Ah  ; ovr_1ca3_8307:31E8
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0A1h,0A8h,086h,0EBh,010h,01Eh,0B8h,090h;	ovr_1ca3_8307:31F6

   	     db	     086h,050h,057h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0A1h,090h,086h,089h; ovr_1ca3_8307:3204
   	     db	     046h,0FCh,089h,076h,0FAh,0C4h,05Eh,0FAh,08Ah,046h,008h,026h,088h,007h  ; ovr_1ca3_8307:3212
   	     db	     08Bh,046h,0FAh,040h,0FFh,076h,0FCh,050h,0FFh,076h,00Ch,0FFh,076h,00Ah  ; ovr_1ca3_8307:3220
   	     db	     09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0FFh,076h,00Ch,0FFh,076h,00Ah,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     040h,040h,001h,046h,0FAh,0FFh,076h,0FCh,0FFh,076h,0FAh,0FFh;	    ovr_1ca3_8307:322E
   	     db	     036h,03Eh,082h,0FFh,076h,006h,0FFh,076h,0F4h,09Ah

   	     dw	     01h
   	     dw	     seg BCC_FAR_B0F1
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,03Ah,078h,026h,089h,077h,002h,08Bh,0C6h,05Fh  ; ovr_1ca3_8307:3258
   	     db	     05Eh,08Bh,0E5h,05Dh,0CAh,00Ch,000h	     ; ovr_1ca3_8307:3266

CO033_TEXT	     ends
; END LG0A0
; BEGIN SYMRESET (listing ovr_1ca3_8307:326D)

        extrn   X02F_00:far
        extrn   BCC_RD_3A06_W:word


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

   	     public  X033_00
X033_00 label   far
BCC_SYMBOL_RESET	     proc    far
        push    bp
        mov     bp,sp
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X02F_00
        dw	     seg X02F_00
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     bx,ax
        mov     word ptr es:[bx+2],0
        pop     bp
        retf    4
BCC_SYMBOL_RESET	     endp
CO033_TEXT	     ends

; END SYMRESET
; BEGIN SYMLOOK (listing ovr_1ca3_8307:328E)

        extrn   X031_02:far
        extrn   X02F_00:far
        extrn   BCC_RD_3A06_W:word
        extrn   BCC_RESERVED_HOOK:word


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

   	     public  X033_01
X033_01 label   far
BCC_SYMBOL_TEST proc    far
        push    bp
        mov     bp,sp
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        db	     9Ah
        dw	     X031_02
        dw	     seg X031_02
        or	     ax,ax
        je	     short M004_@@MISSING
        mov     ax,1
        jmp     short M004_@@DONE
M004_@@MISSING:
        les     bx,dword ptr [bp+6]
        cmp     byte ptr es:[bx],5Fh
        jne     short M004_@@CREATE
        cmp     byte ptr es:[bx+1],5Fh
        je	     short M004_@@RESERVED
        cmp     byte ptr es:[bx+1],57h
        jne     short M004_@@CREATE
M004_@@RESERVED:
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_RESERVED_HOOK
M004_@@CREATE:
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X02F_00
        dw	     seg X02F_00
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        mov     bx,ax
        cmp     word ptr es:[bx+2],0
        je	     short M004_@@UNUSED
        jmp     short BCC_SYMBOL_TEST+12h
M004_@@UNUSED:
        xor     ax,ax
M004_@@DONE:
        pop     bp
        retf    4
BCC_SYMBOL_TEST endp
CO033_TEXT	     ends

; END SYMLOOK
; BEGIN SYMCUR (listing ovr_1ca3_8307:32E3)

        extrn   X02F_00:far
        extrn   BCC_RD_8254_W:word
        extrn   BCC_RD_3A06_W:word
   	     extrn   BCC_RD_8296_W:word
   	     extrn   BCC_RD_961E_W:word


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

   	     public  X033_02
X033_02 label   far
BCC_SYMBOL_CURRENT_TEST proc    far
        push    bp
        mov     bp,sp
        push    ds
        push    word ptr DGROUP:BCC_RD_8254_W
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X02F_00
        dw	     seg X02F_00
        mov     word ptr DGROUP:BCC_RD_8296_W,ax
        mov     bx,word ptr DGROUP:BCC_RD_961E_W
        mov     es,word ptr DGROUP:BCC_RD_3A06_W
        cmp     word ptr es:[bx+2],0
        je	     short M005_@@UNUSED
        mov     ax,1
        jmp     short M005_@@DONE
M005_@@UNUSED:
        xor     ax,ax
M005_@@DONE:
        pop     bp
        retf
BCC_SYMBOL_CURRENT_TEST endp
CO033_TEXT	     ends

; END SYMCUR
; BEGIN SYMFIND (listing ovr_1ca3_8307:330E)

        extrn   BCC_STRING_LENGTH:far
        extrn   BCC_RD_8254_W:word
   	     extrn   BCC_RD_823E_W:word
   	     extrn   BCC_RD_3E06_W:word


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

   	     public  X033_04
X033_04 label   far
BCC_PACKED_LIST_FIND    proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     si,word ptr [bp+6]
        or	     si,si
        jne     short M006_@@BEGIN
        jmp     short M006_@@NOT_FOUND
M006_@@BEGIN:
        mov     di,1
        jmp     short M006_@@TEST
M006_@@COMPARE:
        push    word ptr DGROUP:BCC_RD_823E_W
        push    si
        push    ds
        push    word ptr DGROUP:BCC_RD_8254_W
        db	     0E8h,028h,000h
        or	     ax,ax
        je	     short M006_@@NEXT
        mov     ax,di
        jmp     short M006_@@DONE
M006_@@NEXT:
        inc     di
        push    word ptr DGROUP:BCC_RD_823E_W
        push    si
        db	     9Ah
        dw	     BCC_STRING_LENGTH
        dw	     seg BCC_STRING_LENGTH
        inc     ax
        add     si,ax
M006_@@TEST:
        mov     es,word ptr DGROUP:BCC_RD_3E06_W
        cmp     byte ptr es:[si],0
        jne     short M006_@@COMPARE
M006_@@NOT_FOUND:
        xor     ax,ax
M006_@@DONE:
        pop     di
        pop     si
        pop     bp
        retf    2
BCC_PACKED_LIST_FIND    endp
CO033_TEXT	     ends

; END SYMFIND
; BEGIN SYMMATCH (listing ovr_1ca3_8307:3356)

        extrn   BCC_RD_16FB_B:byte


CO033_TEXT	     segment byte public 'CODE'
        assume  cs:CO033_TEXT,ds:DGROUP

BCC_SYMBOL_MATCH	     proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    si
        xor     si,si
        jmp     short M007_@@TEST
M007_@@COMPARE:
        les     bx,dword ptr [bp+8]
        mov     al,byte ptr es:[bx]
        les     bx,dword ptr [bp+4]
        cmp     al,byte ptr es:[bx]
        je	     short M007_@@MATCHED
        xor     ax,ax
        jmp     short M007_@@DONE
M007_@@MATCHED:
        les     bx,dword ptr [bp+8]
        cmp     byte ptr es:[bx],0
        je	     short M007_@@EQUAL
        inc     si
        inc     word ptr [bp+8]
        inc     word ptr [bp+4]
M007_@@TEST:
        mov     al,byte ptr DGROUP:BCC_RD_16FB_B
        cbw
        cmp     ax,si
        jg	     short M007_@@COMPARE
M007_@@EQUAL:
        mov     ax,1
M007_@@DONE:
        pop     si
        pop     bp
        dec     bp
        ret     8
BCC_SYMBOL_MATCH	     endp
CO033_TEXT	     ends

; END SYMMATCH
   	     end
