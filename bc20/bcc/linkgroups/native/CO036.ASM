; Recovered FBOV far-pointer references
   	     extrn   BCC_BUFFER_ALLOC:far
   	     extrn   BCC_COMPARE_NAME:far
   	     extrn   BCC_DEBUG_BUILD:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_FAR_04CF:far
   	     extrn   BCC_FAR_245C:far
   	     extrn   BCC_FAR_A7C4:far
   	     extrn   BCC_FAR_A9C1:far
   	     extrn   BCC_FAR_A9E0:far
   	     extrn   BCC_FAR_AB12:far
   	     extrn   BCC_RF_15C5_010D:far
   	     extrn   BCC_RF_1A44_000F:far
   	     extrn   BCC_RF_1A47_0039:far
CO02E_TEXT	     segment byte public 'CODE'
CO02E_TEXT	     ends
   	     public  X036_00
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cb1_84e9
; BEGIN LG0A8 (gap	ovr_1cb1_84e9:4E90)
CO036_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO036_TEXT
; Original-image layout stub: not recovered source


X036_00 label   far
   	     db	     055h,08Bh,0ECh,081h,0ECh,02Eh,001h,056h,057h,08Bh,076h,00Ah,09Ah

   	     dw	     03Eh
   	     dw	     seg CO02E_TEXT
   	     db	     0C7h,046h,0F0h,000h,000h,0C7h,046h,0EEh,000h,000h,0B8h;		    ovr_1cb1_84e9:4E90
   	     db	     030h,000h,050h,033h,0C0h,050h,050h,09Ah

   	     dw	     0Fh
   	     dw	     seg BCC_RF_1A44_000F
   	     db	     025h,0FFh;	ovr_1cb1_84e9:4EAC
   	     db	     000h,089h,046h,0F6h,083h,07Eh,0F6h,003h,07Ch,048h,0A1h,014h,000h,099h  ; ovr_1cb1_84e9:4EBA
   	     db	     089h,046h,0F0h,0C7h,046h,0EEh,000h,000h,0EBh,00Fh,0FFh,046h,0EEh,0C4h  ; ovr_1cb1_84e9:4EC8
   	     db	     05Eh,0EEh,026h,080h,03Fh,000h,075h,0F4h,0FFh,046h,0EEh,0C4h,05Eh,0EEh  ; ovr_1cb1_84e9:4ED6
   	     db	     026h,080h,03Fh,000h,075h,0E8h,083h,046h,0EEh,003h,0FFh,076h,0F0h,0FFh  ; ovr_1cb1_84e9:4EE4
   	     db	     076h,0EEh,016h,08Dh,046h,0F8h,050h,016h,08Dh,086h,024h,0FFh,050h,033h  ; ovr_1cb1_84e9:4EF2
   	     db	     0C0h,033h,0D2h,050h,052h,050h,052h,09Ah

   	     dw	     039h
   	     dw	     seg BCC_RF_1A47_0039
   	     db	     08Ch,01Eh;	ovr_1cb1_84e9:4F00
   	     db	     068h,017h,0C7h,006h,066h,017h,0F8h,029h,0FFh,036h,068h,017h,0FFh,036h  ; ovr_1cb1_84e9:4F0E
   	     db	     066h,017h,0E8h,031h,004h,00Bh,0C0h,075h,052h,08Bh,046h,0EEh,00Bh,046h  ; ovr_1cb1_84e9:4F1C
   	     db	     0F0h,074h,04Ah,01Eh,0B8h,09Eh,067h,050h,016h,08Dh,046h,0F8h,050h,016h  ; ovr_1cb1_84e9:4F2A
   	     db	     08Dh,086h,024h,0FFh,050h,01Eh,0B8h,0F8h,029h,050h,033h,0C0h,033h,0D2h  ; ovr_1cb1_84e9:4F38
   	     db	     050h,052h,09Ah
   	     dw	     0202h
   	     dw	     seg BCC_RF_1A47_0039
   	     db	     01Eh,0B8h,09Eh,067h,050h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     040h,050h,09Ah
   	     dw	     010Dh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     089h,016h,068h,017h; ovr_1cb1_84e9:4F46
   	     db	     0A3h,066h,017h,0FFh,036h,068h,017h,0FFh,036h,066h,017h,01Eh,0B8h,09Eh  ; ovr_1cb1_84e9:4F62
   	     db	     067h,050h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0C7h,046h,0F2h,000h,000h,08Bh,0C6h; ovr_1cb1_84e9:4F70
   	     db	     048h,089h,046h,0F6h,08Bh,046h,008h,08Bh,056h,006h,083h,0C2h,004h,089h  ; ovr_1cb1_84e9:4F7E
   	     db	     046h,0FEh,089h,056h,0FCh,0EBh,07Ah,0C4h,05Eh,0FCh,026h,0C4h,01Fh,026h  ; ovr_1cb1_84e9:4F8C
   	     db	     080h,03Fh,02Bh,075h,03Ch,0C4h,05Eh,0FCh,026h,0FFh,077h,002h,026h,0FFh  ; ovr_1cb1_84e9:4F9A
   	     db	     037h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     050h,09Ah
   	     dw	     010Dh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     089h,016h;	ovr_1cb1_84e9:4FA8
   	     db	     0C2h,024h,0A3h,0C0h,024h,0FFh,036h,0C2h,024h,0FFh,036h,0C0h,024h,0C4h  ; ovr_1cb1_84e9:4FB6
   	     db	     05Eh,0FCh,026h,08Bh,007h,040h,026h,0FFh,077h,002h,050h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0C7h,046h,0F2h,001h,000h,0EBh,02Bh,0C4h,05Eh,0FCh,026h,08Bh;	    ovr_1cb1_84e9:4FC4
   	     db	     007h,040h,026h,0FFh,077h,002h,050h,0B8h,0FFh,0FFh,050h,09Ah

   	     dw	     04Dh
   	     dw	     seg CO02E_TEXT
   	     db	     00Bh,0C0h,075h,012h,01Eh,0B8h,002h,02Ah,050h,0C4h,05Eh,0FCh;	    ovr_1cb1_84e9:4FE0
   	     db	     026h,0FFh,077h,002h,026h,0FFh,037h,0E8h,078h,003h,083h,046h,0FCh,004h  ; ovr_1cb1_84e9:4FFC
   	     db	     0FFh,04Eh,0F6h,083h,07Eh,0F6h,000h,07Eh,01Eh,0C4h,05Eh,0FCh,026h,0C4h  ; ovr_1cb1_84e9:500A
   	     db	     01Fh,026h,080h,03Fh,02Dh,075h,003h,0E9h,071h,0FFh,0C4h,05Eh,0FCh,026h  ; ovr_1cb1_84e9:5018
   	     db	     0C4h,01Fh,026h,080h,03Fh,02Bh,075h,003h,0E9h,062h,0FFh,0FFh,036h,0C2h  ; ovr_1cb1_84e9:5026
   	     db	     024h,0FFh,036h,0C0h,024h,033h,0C0h,050h,09Ah

   	     dw	     01h
   	     dw	     seg BCC_FAR_A9C1
   	     db	     08Bh; ovr_1cb1_84e9:5034
   	     db	     0F8h,00Bh,0FFh,07Dh,06Bh,083h,07Eh,0F2h,000h,074h,029h,0C6h,006h,0F9h  ; ovr_1cb1_84e9:5042
   	     db	     016h,000h,0FFh,036h,0C2h,024h,0FFh,036h,0C0h,024h,0B8h,05Ch,000h,050h  ; ovr_1cb1_84e9:5050
   	     db	     09Ah
   	     dw	     011Bh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     083h,0C4h,006h,09Ah
   	     dw	     02D67h
   	     dw	     seg BCC_FAR_245C
   	     db	     0B8h; ovr_1cb1_84e9:505E
   	     db	     001h,000h,050h,09Ah
   	     dw	     09Fh
   	     dw	     seg BCC_FAR_04CF
   	     db	     0EBh,03Ch,08Bh,046h,0EEh,00Bh; ovr_1cb1_84e9:506C
   	     db	     046h,0F0h,074h,034h,016h,08Dh,086h,0D2h,0FEh,050h,016h,08Dh,046h,0F8h  ; ovr_1cb1_84e9:507A
   	     db	     050h,016h,08Dh,086h,024h,0FFh,050h,0FFh,036h,0C2h,024h,0FFh,036h,0C0h  ; ovr_1cb1_84e9:5088
   	     db	     024h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     0202h
   	     dw	     seg BCC_RF_1A47_0039
   	     db	     016h,08Dh;	ovr_1cb1_84e9:5096
   	     db	     086h,0D2h,0FEh,050h,033h,0C0h,050h,09Ah

   	     dw	     01h
   	     dw	     seg BCC_FAR_A9C1
   	     db	     08Bh,0F8h;	ovr_1cb1_84e9:50A4
   	     db	     00Bh,0FFh,07Dh,003h,0E9h,0A0h,000h,057h,033h,0C0h,033h,0D2h,050h,052h  ; ovr_1cb1_84e9:50B2
   	     db	     0B8h,002h,000h,050h,09Ah
   	     dw	     0Eh
   	     dw	     seg BCC_BUFFER_ALLOC
   	     db	     089h,046h,0F4h,057h,033h; ovr_1cb1_84e9:50C0
   	     db	     0C0h,033h,0D2h,050h,052h,050h,09Ah
   	     dw	     0Eh
   	     dw	     seg BCC_BUFFER_ALLOC
   	     db	     01Eh,0B8h,01Ah; ovr_1cb1_84e9:50CE
   	     db	     083h,050h,08Bh,046h,0F4h,040h,050h,09Ah

   	     dw	     01B1Ch
   	     dw	     seg BCC_FAR_245C
   	     db	     0C7h,006h;	ovr_1cb1_84e9:50DC
   	     db	     018h,083h,000h,000h,057h,0FFh,036h,01Ah,083h,033h,0C0h,050h,0FFh,076h  ; ovr_1cb1_84e9:50EA
   	     db	     0F4h,09Ah
   	     dw	     00h
   	     dw	     seg BCC_FAR_A9E0
   	     db	     057h,09Ah
   	     dw	     04h
   	     dw	     seg BCC_FAR_A7C4
   	     db	     08Bh,01Eh;	ovr_1cb1_84e9:50F8
   	     db	     018h,083h,003h,05Eh,0F4h,08Eh,006h,01Ah,083h,026h,0C6h,007h,01Ah,016h  ; ovr_1cb1_84e9:5106
   	     db	     08Dh,086h,068h,0FFh,050h,0E8h,083h,001h,089h,046h,0F6h,083h,07Eh,0F6h  ; ovr_1cb1_84e9:5114
   	     db	     0FFh,074h,02Ah,080h,0BEh,068h,0FFh,02Dh,075h,013h,016h,08Dh,086h,069h  ; ovr_1cb1_84e9:5122
   	     db	     0FFh,050h,0B8h,001h,000h,050h,09Ah
   	     dw	     04Dh
   	     dw	     seg CO02E_TEXT
   	     db	     00Bh,0C0h,075h; ovr_1cb1_84e9:5130
   	     db	     0D4h,01Eh,0B8h,00Fh,02Ah,050h,016h,08Dh,086h,068h,0FFh,050h,0E8h,031h  ; ovr_1cb1_84e9:513E
   	     db	     002h,0EBh,0C4h,01Eh,0B8h,01Ah,083h,050h,09Ah

   	     dw	     01C4Fh
   	     dw	     seg BCC_FAR_245C
   	     db	     04Eh; ovr_1cb1_84e9:514C
   	     db	     083h,046h,006h,004h,0EBh,03Bh,0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h  ; ovr_1cb1_84e9:515A
   	     db	     03Fh,02Dh,075h,02Ah,0C4h,05Eh,006h,026h,08Bh,007h,040h,026h,0FFh,077h  ; ovr_1cb1_84e9:5168
   	     db	     002h,050h,033h,0C0h,050h,09Ah
   	     dw	     04Dh
   	     dw	     seg CO02E_TEXT
   	     db	     00Bh,0C0h,075h,012h; ovr_1cb1_84e9:5176
   	     db	     01Eh,0B8h,002h,02Ah,050h,0C4h,05Eh,006h,026h,0FFh,077h,002h,026h,0FFh  ; ovr_1cb1_84e9:5184
   	     db	     037h,0E8h,0E8h,001h,083h,046h,006h,004h,04Eh,00Bh,0F6h,07Fh,003h,0E9h  ; ovr_1cb1_84e9:5192
   	     db	     0D1h,000h,0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h,03Fh,02Dh,074h,0B2h  ; ovr_1cb1_84e9:51A0
   	     db	     0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h,03Fh,02Bh,074h,0A6h,0E9h,0B6h  ; ovr_1cb1_84e9:51AE
   	     db	     000h,0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h,03Fh,02Dh,074h,003h,0E9h  ; ovr_1cb1_84e9:51BC
   	     db	     0A2h,000h,0C4h,05Eh,006h,026h,08Bh,047h,002h,026h,08Bh,017h,042h,089h  ; ovr_1cb1_84e9:51CA
   	     db	     046h,0ECh,089h,056h,0EAh,0FFh,076h,0ECh,0FFh,076h,0EAh,01Eh,0B8h,022h  ; ovr_1cb1_84e9:51D8
   	     db	     02Ah,050h,09Ah
   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,074h,014h,0FFh,076h,0ECh; ovr_1cb1_84e9:51E6
   	     db	     0FFh,076h,0EAh,01Eh,0B8h,025h,02Ah,050h,09Ah

   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh; ovr_1cb1_84e9:51F4
   	     db	     0C0h,075h,007h,0C6h,006h,009h,017h,001h,0EBh,062h,0FFh,076h,0ECh,0FFh  ; ovr_1cb1_84e9:5202
   	     db	     076h,0EAh,01Eh,0B8h,029h,02Ah,050h,09Ah

   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h;	ovr_1cb1_84e9:5210
   	     db	     074h,04Eh,0FFh,076h,0ECh,0FFh,076h,0EAh,01Eh,0B8h,02Bh,02Ah,050h,09Ah  ; ovr_1cb1_84e9:521E
   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,074h,03Ah,0FFh,076h,0ECh,0FFh,076h,0EAh;	ovr_1cb1_84e9:522C

   	     db	     01Eh,0B8h,02Eh,02Ah,050h,09Ah
   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,074h,026h; ovr_1cb1_84e9:523A
   	     db	     0FFh,076h,0ECh,0FFh,076h,0EAh,01Eh,0B8h,031h,02Ah,050h,09Ah

   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,074h,012h,01Eh,0B8h,002h,02Ah,050h,0C4h,05Eh,006h;	    ovr_1cb1_84e9:5248
   	     db	     026h,0FFh,077h,002h,026h,0FFh,037h,0E8h,010h,001h,083h,046h,006h,004h  ; ovr_1cb1_84e9:5264
   	     db	     04Eh,00Bh,0F6h,07Eh,003h,0E9h,043h,0FFh,0A0h,014h,017h,008h,006h,0FCh  ; ovr_1cb1_84e9:5272
   	     db	     016h,0A0h,015h,017h,008h,006h,014h,017h,09Ah

   	     dw	     039h
   	     dw	     seg CO02E_TEXT
   	     db	     0C4h; ovr_1cb1_84e9:5280
   	     db	     05Eh,006h,026h,08Bh,057h,002h,026h,08Bh,007h,05Fh,05Eh,08Bh,0E5h,05Dh  ; ovr_1cb1_84e9:528E
   	     db	     0CAh,006h,000h  ; ovr_1cb1_84e9:529C

CO036_TEXT	     ends
; END LG0A8
; BEGIN LINEREAD (listing ovr_1cb1_84e9:529F)
        extrn   BCC_LINE_SEGMENT:word
        extrn   _CTYPE:byte
   	     extrn   BCC_RD_181E_W:word
   	     extrn   BCC_RD_8318_W:word
   	     extrn   BCC_RD_180E_W:word


CO036_TEXT	     segment byte public 'CODE'
        assume  cs:CO036_TEXT,ds:DGROUP

BCC_LINE_READ   proc    near
        inc     bp
        push    bp
        mov     bp,sp
M001_@@SKIP_SPACE:
        mov     es,word ptr DGROUP:BCC_LINE_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_181E_W
        mov     al,byte ptr es:[bx]
        cbw
        mov     dx,ax
        inc     word ptr DGROUP:BCC_RD_8318_W
        mov     bx,dx
        test    byte ptr DGROUP:_CTYPE[bx+1],1
        jne     short M001_@@SKIP_SPACE
        cmp     dx,13
        je	     short M001_@@SKIP_SPACE
        or	     dx,dx
        je	     short M001_@@EOF
        cmp     dx,26
        jne     short M001_@@NOT_EOF
M001_@@EOF:
        mov     ax,0FFFFh
        jmp     short M001_@@DONE
M001_@@NOT_EOF:
        cmp     dx,3Bh
        jne     short M001_@@COPY
        jmp     short M001_@@COMMENT_TEST
M001_@@COMMENT_NEXT:
        mov     es,word ptr DGROUP:BCC_LINE_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_181E_W
        mov     al,byte ptr es:[bx]
        cbw
        mov     dx,ax
        inc     word ptr DGROUP:BCC_RD_8318_W
M001_@@COMMENT_TEST:
        or	     dx,dx
        je	     short M001_@@COMMENT_END
        cmp     dx,10
        je	     short M001_@@COMMENT_END
        cmp     dx,26
        jne     short M001_@@COMMENT_NEXT
M001_@@COMMENT_END:
        cmp     dx,26
        jne     short M001_@@SKIP_SPACE
        dec     word ptr DGROUP:BCC_RD_180E_W
        jmp     short M001_@@SKIP_SPACE
M001_@@COPY:
        les     bx,dword ptr [bp+4]
        mov     al,dl
        mov     byte ptr es:[bx],al
        inc     word ptr [bp+4]
        mov     es,word ptr DGROUP:BCC_LINE_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_181E_W
        mov     al,byte ptr es:[bx]
        cbw
        mov     dx,ax
        inc     word ptr DGROUP:BCC_RD_8318_W
        mov     bx,dx
        mov     al,byte ptr DGROUP:_CTYPE[bx+1]
        cbw
        test    ax,1
        jne     short M001_@@LINE_END
        or	     dx,dx
        je	     short M001_@@LINE_END
        cmp     dx,13
        je	     short M001_@@LINE_END
        cmp     dx,26
        jne     short M001_@@COPY
M001_@@LINE_END:
        cmp     dx,26
        jne     short M001_@@TERMINATE
        dec     word ptr DGROUP:BCC_RD_180E_W
M001_@@TERMINATE:
        les     bx,dword ptr [bp+4]
        mov     byte ptr es:[bx],0
        mov     ax,1
M001_@@DONE:
        pop     bp
        dec     bp
        ret     4
BCC_LINE_READ   endp
CO036_TEXT	     ends

; END LINEREAD
; BEGIN FILETEST (listing ovr_1cb1_84e9:5352)

        extrn   BCC_RF_1A86_0002:far


CO036_TEXT	     segment byte public 'CODE'
        assume  cs:CO036_TEXT,ds:DGROUP

BCC_FILE_TEST   proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,44
        push    word ptr [bp+6]
        push    word ptr [bp+4]
        push    ss
        lea     ax,[bp-44]
        push    ax
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     BCC_RF_1A86_0002
        dw	     seg BCC_RF_1A86_0002
        or	     ax,ax
        jne     short M002_@@MISSING
        mov     ax,1
        jmp     short M002_@@DONE
M002_@@MISSING:
        xor     ax,ax
M002_@@DONE:
        mov     sp,bp
        pop     bp
        dec     bp
        ret     4
BCC_FILE_TEST   endp
CO036_TEXT	     ends

; END FILETEST
; BEGIN FILEDIE (listing ovr_1cb1_84e9:537E)

        extrn   BCC_OUTPUT_ERROR:far
        extrn   BCC_OUTPUT_FLUSH:far
        extrn   BCC_RF_1041_009F:far
        extrn   BCC_STATE_16F9:byte


CO036_TEXT	     segment byte public 'CODE'
        assume  cs:CO036_TEXT,ds:DGROUP

BCC_FILE_FATAL  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        mov     byte ptr DGROUP:BCC_STATE_16F9,0
        push    word ptr [bp+6]
        push    word ptr [bp+4]
        push    word ptr [bp+10]
        push    word ptr [bp+8]
        mov     ax,5Bh
        push    ax
        db	     9Ah
        dw	     BCC_OUTPUT_ERROR
        dw	     seg BCC_OUTPUT_ERROR
        add     sp,10
        db	     9Ah
        dw	     BCC_OUTPUT_FLUSH
        dw	     seg BCC_OUTPUT_FLUSH
        mov     ax,1
        push    ax
        db	     9Ah
        dw	     BCC_RF_1041_009F
        dw	     seg BCC_RF_1041_009F
        pop     bp
        dec     bp
        ret     8
BCC_FILE_FATAL  endp
CO036_TEXT	     ends

; END FILEDIE
   	     end
