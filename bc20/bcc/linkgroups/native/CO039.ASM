; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
   	     extrn   BCC_DEBUG_BUILD:far
   	     extrn   BCC_FAR_AB51:far
CO00A_TEXT	     segment byte public 'CODE'
CO00A_TEXT	     ends
CO00E_TEXT	     segment byte public 'CODE'
CO00E_TEXT	     ends
CO02C_TEXT	     segment byte public 'CODE'
CO02C_TEXT	     ends
CO05D_TEXT	     segment byte public 'CODE'
CO05D_TEXT	     ends
CO076_TEXT	     segment byte public 'CODE'
CO076_TEXT	     ends
CO077_TEXT	     segment byte public 'CODE'
CO077_TEXT	     ends
   	     public  X039_00
   	     public  X039_01
   	     public  X039_02
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cba_854f
; BEGIN NODEPRED (listing ovr_1cba_854f:54F0)

        extrn   BCC_OPTION_62A0:byte
        extrn   BCC_NODE_POOL:word
        extrn   BCC_TYPE_POOL:word


CO039_TEXT	     segment byte public 'CODE'
        assume  cs:CO039_TEXT,ds:DGROUP

BCC_NODE_PREDICATE	     proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    si
        mov     si,word ptr [bp+4]
        cmp     byte ptr DGROUP:BCC_OPTION_62A0,0
        je	     short M000_@@FALSE
        mov     es,word ptr DGROUP:BCC_NODE_POOL
        test    byte ptr es:[si+6],10h
        jne     short M000_@@TRUE
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_TYPE_POOL
        cmp     word ptr es:[bx],18
        jne     short M000_@@FALSE
        mov     es,word ptr DGROUP:BCC_NODE_POOL
        cmp     word ptr es:[si+17],1
        jne     short M000_@@FALSE
M000_@@TRUE:
        mov     ax,1
        jmp     short M000_@@DONE
M000_@@FALSE:
        xor     ax,ax
M000_@@DONE:
        pop     si
        pop     bp
        dec     bp
        ret     2
BCC_NODE_PREDICATE	     endp
CO039_TEXT	     ends

; END NODEPRED
; BEGIN DBGNUM (listing ovr_1cba_854f:5530)

        extrn   BCC_DEBUG_STATE:word
        extrn   X055_0A:far
        extrn   X05D_0A:far
        extrn   X076_05:far
        extrn   BCC_DEBUG_PREFIX:byte
        extrn   BCC_DEBUG_MORE:byte
        extrn   BCC_DEBUG_SUFFIX:byte


CO039_TEXT	     segment byte public 'CODE'
        assume  cs:CO039_TEXT,ds:DGROUP
   	     public  X039_00
X039_00 label   far
BCC_FAR_5530    label   far

BCC_DEBUG_NUMBERS	     proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     ax,word ptr DGROUP:BCC_DEBUG_STATE
        mov     word ptr [bp-2],ax
        db	     9Ah
        dw	     X055_0A
        dw	     seg X055_0A
        inc     ax
        mov     si,ax
        cmp     byte ptr [si],0E6h
        je	     short M001_@@PREFIX
        mov     word ptr DGROUP:BCC_DEBUG_STATE,0FFFFh
M001_@@PREFIX:
        push    ds
        mov     ax,offset DGROUP:BCC_DEBUG_PREFIX
M001_@@PRINT_STRING:
        push    ax
        db	     9Ah
        dw	     X05D_0A
        dw	     seg X05D_0A
        xor     di,di
M001_@@NEXT:
        mov     al,byte ptr [si]
        cbw
        push    ax
        db	     9Ah
        dw	     X076_05
        dw	     seg X076_05
        inc     di
        inc     si
        dec     word ptr [bp+6]
        cmp     word ptr [bp+6],1
        jle     short M001_@@SUFFIX
        cmp     di,20
        jl	     short M001_@@NEXT
        push    ds
        mov     ax,offset DGROUP:BCC_DEBUG_MORE
        jmp     short M001_@@PRINT_STRING
M001_@@SUFFIX:
        push    ds
        mov     ax,offset DGROUP:BCC_DEBUG_SUFFIX
        push    ax
        db	     9Ah
        dw	     X05D_0A
        dw	     seg X05D_0A
        mov     ax,word ptr [bp-2]
        mov     word ptr DGROUP:BCC_DEBUG_STATE,ax
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    2
BCC_DEBUG_NUMBERS	     endp
CO039_TEXT	     ends

; END DBGNUM
; BEGIN LG0AA (gap	ovr_1cba_854f:5593)
CO039_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO039_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,010h,056h,057h,08Bh,076h,004h,08Eh,006h  ; ovr_1cba_854f:5593
   	     db	     010h,064h,026h,08Ah,044h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h  ; ovr_1cba_854f:55A1
   	     db	     089h,046h,0F4h,083h,07Eh,0F4h,002h,074h,00Fh,083h,07Eh,0F4h,001h,074h  ; ovr_1cba_854f:55AF
   	     db	     009h,083h,07Eh,0F4h,003h,074h,003h,0E9h,06Eh,002h,08Eh,006h,010h,064h  ; ovr_1cba_854f:55BD
   	     db	     026h,083h,07Ch,008h,000h,075h,003h,0E9h,060h,002h,056h,09Ah

   	     dw	     066h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F8h,057h,09Ah
   	     dw	     089h
   	     dw	     seg CO02C_TEXT
   	     db	     089h,046h,0F6h,08Eh; ovr_1cba_854f:55CB
   	     db	     006h,010h,064h,026h,0F6h,044h,006h,006h,075h,00Ah,0F7h,046h,0F6h,080h  ; ovr_1cba_854f:55E7
   	     db	     000h,075h,003h,0E9h,03Ah,002h,08Eh,006h,010h,064h,026h,08Ah,044h,007h  ; ovr_1cba_854f:55F5
   	     db	     0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,001h,000h,075h,003h,0E9h  ; ovr_1cba_854f:5603
   	     db	     0D9h,000h,03Dh,002h,000h,074h,00Bh,03Dh,003h,000h,075h,003h,0E9h,0F7h  ; ovr_1cba_854f:5611
   	     db	     000h,0E9h,049h,001h,08Eh,006h,010h,064h,026h,08Bh,044h,004h,089h,046h  ; ovr_1cba_854f:561F
   	     db	     0F8h,0F7h,046h,0F6h,080h,000h,074h,066h,0C7h,046h,0FCh,000h,000h,0C7h  ; ovr_1cba_854f:562D
   	     db	     046h,0FAh,001h,000h,0EBh,02Eh,08Bh,05Eh,0F8h,08Eh,006h,09Ah,063h,026h  ; ovr_1cba_854f:563B
   	     db	     08Bh,04Fh,00Bh,026h,08Bh,05Fh,009h,08Bh,056h,0FCh,08Bh,046h,0FAh,09Ah  ; ovr_1cba_854f:5649
   	     dw	     03A9h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,056h,0FCh,089h,046h,0FAh,08Bh,05Eh,0F8h,08Eh;	ovr_1cba_854f:5657

   	     db	     006h,09Ah,063h,026h,08Bh,047h,007h,089h,046h,0F8h,08Eh,006h,09Ah,063h  ; ovr_1cba_854f:5665
   	     db	     08Bh,05Eh,0F8h,026h,083h,03Fh,011h,074h,0C5h,057h,08Bh,046h,0F6h,025h  ; ovr_1cba_854f:5673
   	     db	     010h,000h,050h,0FFh,076h,0F8h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     050h,0FFh,076h; ovr_1cba_854f:5681
   	     db	     0FCh,0FFh,076h,0FAh,09Ah
   	     dw	     03Eh
   	     dw	     seg CO076_TEXT
   	     db	     0E9h,0C7h,000h,01Eh,0B8h; ovr_1cba_854f:568F
   	     db	     052h,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,0C0h,080h,0B8h; ovr_1cba_854f:569D
   	     db	     03Ah,000h,050h,09Ah
   	     dw	     043h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,060h,081h,0B4h; ovr_1cba_854f:56AB
   	     db	     000h,089h,046h,0FEh,083h,07Eh,0FEh,012h,075h,011h,057h,0FFh,01Eh,034h  ; ovr_1cba_854f:56B9
   	     db	     081h,03Dh,0FFh,0FFh,074h,007h,01Eh,0B8h,05Ah,02Ah,050h,0EBh,00Fh,08Bh  ; ovr_1cba_854f:56C7
   	     db	     05Eh,0FEh,0D1h,0E3h,0D1h,0E3h,0FFh,0B7h,024h,059h,0FFh,0B7h,022h,059h  ; ovr_1cba_854f:56D5
   	     db	     09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     0EBh,078h,0EBh,076h,08Eh,006h,0C2h,063h,026h; ovr_1cba_854f:56E3

   	     db	     0F7h,045h,008h,000h,002h,074h,006h,01Eh,0B8h,05Fh,02Ah,0EBh,004h,01Eh  ; ovr_1cba_854f:56F1
   	     db	     0B8h,06Bh,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,0C0h,080h; ovr_1cba_854f:56FF
   	     db	     01Eh,0B8h,04Fh,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,034h; ovr_1cba_854f:570D
   	     db	     081h,00Bh,0C0h,075h,04Ch,08Eh,006h,010h,064h,026h,08Bh,05Ch,004h,08Eh  ; ovr_1cba_854f:571B
   	     db	     006h,09Ah,063h,026h,083h,03Fh,012h,074h,03Ah,08Eh,006h,010h,064h,026h  ; ovr_1cba_854f:5729
   	     db	     0F6h,044h,006h,020h,074h,00Bh,026h,08Ah,044h,006h,0B4h,000h,0A9h,004h  ; ovr_1cba_854f:5737
   	     db	     000h,074h,024h,057h,0FFh,01Eh,0C0h,080h,01Eh,0B8h,074h,02Ah,050h,09Ah  ; ovr_1cba_854f:5745
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,018h,081h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO077_TEXT
   	     db	     01Eh,0B8h,04Fh,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     08Eh,006h,010h; ovr_1cba_854f:5753
   	     db	     064h,026h,08Ah,044h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh  ; ovr_1cba_854f:576F
   	     db	     003h,000h,074h,003h,0E9h,0B1h,000h,057h,0FFh,01Eh,034h,081h,00Bh,0C0h  ; ovr_1cba_854f:577D
   	     db	     075h,003h,0E9h,0A5h,000h,0F7h,046h,0F6h,040h,000h,074h,051h,08Eh,006h  ; ovr_1cba_854f:578B
   	     db	     010h,064h,026h,08Bh,05Ch,002h,08Eh,006h,032h,078h,026h,08Bh,05Fh,004h  ; ovr_1cba_854f:5799
   	     db	     08Bh,007h,08Eh,006h,010h,064h,026h,08Bh,05Ch,002h,08Eh,006h,032h,078h  ; ovr_1cba_854f:57A7
   	     db	     026h,08Bh,057h,002h,089h,046h,0F2h,089h,056h,0F0h,0EBh,013h,0C4h,05Eh  ; ovr_1cba_854f:57B5
   	     db	     0F0h,026h,08Ah,007h,098h,08Bh,0D8h,0F6h,087h,081h,05Bh,008h,075h,00Ch  ; ovr_1cba_854f:57C3
   	     db	     0FFh,046h,0F0h,0C4h,05Eh,0F0h,026h,080h,03Fh,000h,075h,0E4h,0C4h,05Eh  ; ovr_1cba_854f:57D1
   	     db	     0F0h,026h,080h,03Fh,000h,075h,011h,0EBh,04Dh,080h,03Eh,016h,017h,000h  ; ovr_1cba_854f:57DF
   	     db	     074h,046h,056h,0E8h,0FDh,0FCh,00Bh,0C0h,075h,03Eh,08Eh,006h,010h,064h  ; ovr_1cba_854f:57ED
   	     db	     026h,08Ah,044h,007h,024h,007h,00Ch,008h,026h,088h,044h,007h,057h,0FFh  ; ovr_1cba_854f:57FB
   	     db	     01Eh,0C0h,080h,01Eh,0B8h,07Dh,02Ah,050h,09Ah

   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     08Eh; ovr_1cba_854f:5809
   	     db	     006h,010h,064h,026h,08Ah,044h,007h,024h,007h,00Ch,018h,026h,088h,044h  ; ovr_1cba_854f:5817
   	     db	     007h,057h,0FFh,01Eh,0C0h,080h,01Eh,0B8h,04Fh,02Ah,050h,09Ah

   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,002h,000h; ovr_1cba_854f:5825


CO039_TEXT	     ends
; END LG0AA
; BEGIN DUMPALL (listing ovr_1cba_854f:583E)

        extrn   X02C_0F:far
        extrn   BCC_NODE_COUNT:word
        extrn   BCC_OPTION_1700:byte


CO039_TEXT	     segment byte public 'CODE'
        assume  cs:CO039_TEXT,ds:DGROUP

   	     public  X039_02
X039_02 label   far
BCC_DUMP_ALL    proc    far
        push    bp
        mov     bp,sp
        push    si
        xor     si,si
        jmp     short M003_@@TEST
M003_@@NEXT:
        push    si
        db	     9Ah
        dw	     X02C_0F
        dw	     seg X02C_0F
        push    ax
        db	     0E8h,043h,0FDh
M003_@@TEST:
        add     si,10
        cmp     si,word ptr DGROUP:BCC_NODE_COUNT
        jc	     short M003_@@NEXT
        cmp     byte ptr DGROUP:BCC_OPTION_1700,0
        je	     short M003_@@DONE
        db	     0E8h,0A0h,000h
M003_@@DONE:
        pop     si
        pop     bp
        retf
BCC_DUMP_ALL    endp
CO039_TEXT	     ends

; END DUMPALL
; BEGIN DUMPNODE (listing ovr_1cba_854f:5866)

        extrn   X02C_0E:far
        extrn   X02C_15:far
        extrn   X05D_0A:far
        extrn   X05D_07:far
        extrn   X02C_08:far
        extrn   X077_04:far
        extrn   BCC_NAME_HOOK:word
        extrn   BCC_NODE_POOL:word
        extrn   BCC_TYPE_POOL:word
        extrn   BCC_DEBUG_NODE_PREFIX:byte
        extrn   BCC_DEBUG_SUFFIX:byte


CO039_TEXT	     segment byte public 'CODE'
        assume  cs:CO039_TEXT,ds:DGROUP

BCC_DUMP_NODE   proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        push    di
        mov     si,word ptr [bp+4]
        push    si
        db	     9Ah
        dw	     X02C_0E
        dw	     seg X02C_0E
        mov     di,ax
        push    di
        db	     9Ah
        dw	     X02C_15
        dw	     seg X02C_15
        mov     word ptr [bp-4],ax
        test    word ptr [bp-4],100h
        jne     short M004_@@DONE
        mov     byte ptr [bp-1],0
        test    word ptr [bp-4],20h
        je	     short M004_@@PRINT
        mov     es,word ptr DGROUP:BCC_NODE_POOL
        mov     bx,word ptr es:[si+4]
        mov     es,word ptr DGROUP:BCC_TYPE_POOL
        cmp     byte ptr es:[bx+11],4
        jne     short M004_@@ORDINARY
        mov     al,98h
        jmp     short M004_@@STORE_KIND
M004_@@ORDINARY:
        mov     al,18h
M004_@@STORE_KIND:
        mov     byte ptr [bp-1],al
M004_@@PRINT:
        push    ds
        mov     ax,offset DGROUP:BCC_DEBUG_NODE_PREFIX
        push    ax
        db	     9Ah
        dw	     X05D_0A
        dw	     seg X05D_0A
        push    di
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_NAME_HOOK
        mov     ax,20h
        push    ax
        db	     9Ah
        dw	     X05D_07
        dw	     seg X05D_07
        mov     es,word ptr DGROUP:BCC_NODE_POOL
        push    word ptr es:[si+4]
        db	     9Ah
        dw	     X02C_08
        dw	     seg X02C_08
        push    ax
        db	     9Ah
        dw	     X077_04
        dw	     seg X077_04
        mov     ax,20h
        push    ax
        db	     9Ah
        dw	     X05D_07
        dw	     seg X05D_07
        mov     al,byte ptr [bp-1]
        mov     ah,0
        push    ax
        db	     9Ah
        dw	     X077_04
        dw	     seg X077_04
        push    ds
        mov     ax,offset DGROUP:BCC_DEBUG_SUFFIX
        push    ax
        db	     9Ah
        dw	     X05D_0A
        dw	     seg X05D_0A
M004_@@DONE:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     2
BCC_DUMP_FINISH label   near
BCC_DUMP_NODE   endp
CO039_TEXT	     ends

; Original-target semantic	aliases	(zero bytes)
; END DUMPNODE
; BEGIN LG0AB (gap	ovr_1cba_854f:5903)
CO039_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO039_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,008h,056h,057h,01Eh,0B8h,036h,02Ah,050h  ; ovr_1cba_854f:5903
   	     db	     09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     0B8h,0EAh,000h,050h,09Ah
   	     dw	     039h
   	     dw	     seg CO076_TEXT
   	     db	     01Eh,080h,03Eh,0A0h,062h,000h,074h,005h,0B8h,08Eh,02Ah,0EBh,003h,0B8h  ; ovr_1cba_854f:591F
   	     db	     091h,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     0A0h,016h,017h,098h,0D1h,0E0h; ovr_1cba_854f:592D
   	     db	     0D1h,0E0h,0D1h,0E0h,050h,0A0h,0EFh,016h,098h,05Ah,00Bh,0C2h,050h,09Ah  ; ovr_1cba_854f:593B
   	     dw	     039h
   	     dw	     seg CO076_TEXT
   	     db	     01Eh,0B8h,04Fh,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     0FFh,01Eh,00Ch,081h,0C7h,046h,0FEh,000h,000h,0E9h,074h,001h,08Bh,05Eh  ; ovr_1cba_854f:5957
   	     db	     0FEh,0D1h,0E3h,08Bh,087h,0ACh,078h,0E9h,059h,001h,08Eh,006h,032h,078h  ; ovr_1cba_854f:5965
   	     db	     08Bh,05Eh,0FCh,026h,08Bh,03Fh,0E9h,03Bh,001h,08Bh,0F7h,08Eh,006h,010h  ; ovr_1cba_854f:5973
   	     db	     064h,026h,08Ah,044h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh  ; ovr_1cba_854f:5981
   	     db	     003h,000h,074h,008h,03Dh,00Bh,000h,074h,01Fh,0E9h,0EBh,000h,08Eh,006h  ; ovr_1cba_854f:598F
   	     db	     010h,064h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h,026h,083h,03Fh,012h  ; ovr_1cba_854f:599D
   	     db	     074h,003h,0E9h,0D6h,000h,056h,0E8h,0B2h,0FEh,0E9h,0CFh,000h,080h,03Eh  ; ovr_1cba_854f:59AB
   	     db	     0A0h,062h,000h,075h,003h,0E9h,0C5h,000h,08Eh,006h,010h,064h,026h,08Bh  ; ovr_1cba_854f:59B9
   	     db	     05Ch,004h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,0F6h,087h,0CAh,009h,040h  ; ovr_1cba_854f:59C7
   	     db	     075h,003h,0E9h,0ACh,000h,08Eh,006h,010h,064h,026h,08Bh,05Ch,004h,08Eh  ; ovr_1cba_854f:59D5
   	     db	     006h,09Ah,063h,026h,08Bh,05Fh,005h,08Eh,006h,03Eh,05Fh,026h,0F7h,047h  ; ovr_1cba_854f:59E3
   	     db	     018h,001h,000h,075h,003h,0E9h,08Dh,000h,08Eh,006h,010h,064h,026h,08Bh  ; ovr_1cba_854f:59F1
   	     db	     05Ch,004h,08Eh,006h,09Ah,063h,026h,08Bh,05Fh,005h,08Eh,006h,03Eh,05Fh  ; ovr_1cba_854f:59FF
   	     db	     026h,08Bh,047h,002h,0EBh,06Ah,08Bh,05Eh,0FAh,08Eh,006h,0A4h,078h,026h  ; ovr_1cba_854f:5A0D
   	     db	     08Ah,047h,004h,0B4h,000h,025h,003h,000h,03Dh,003h,000h,075h,04Bh,026h  ; ovr_1cba_854f:5A1B
   	     db	     0F6h,047h,004h,080h,075h,044h,08Bh,05Eh,0FAh,08Eh,006h,0A4h,078h,026h  ; ovr_1cba_854f:5A29
   	     db	     08Bh,047h,006h,0EBh,02Eh,08Bh,05Eh,0F8h,08Eh,006h,010h,064h,026h,08Ah  ; ovr_1cba_854f:5A37
   	     db	     047h,00Ch,0B4h,000h,025h,003h,000h,03Dh,001h,000h,075h,00Eh,026h,0F7h  ; ovr_1cba_854f:5A45
   	     db	     047h,00Ah,002h,000h,074h,006h,0FFh,076h,0F8h,0E8h,007h,0FEh,08Bh,05Eh  ; ovr_1cba_854f:5A53
   	     db	     0F8h,08Eh,006h,010h,064h,026h,08Bh,047h,013h,089h,046h,0F8h,083h,07Eh  ; ovr_1cba_854f:5A61
   	     db	     0F8h,000h,075h,0C9h,08Eh,006h,0A4h,078h,08Bh,05Eh,0FAh,026h,08Bh,007h  ; ovr_1cba_854f:5A6F
   	     db	     089h,046h,0FAh,083h,07Eh,0FAh,000h,075h,08Dh,080h,03Eh,0A0h,062h,000h  ; ovr_1cba_854f:5A7D
   	     db	     074h,023h,08Eh,006h,010h,064h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h  ; ovr_1cba_854f:5A8B
   	     db	     026h,083h,03Fh,012h,075h,011h,08Eh,006h,010h,064h,026h,08Bh,044h,013h  ; ovr_1cba_854f:5A99
   	     db	     08Bh,0F0h,00Bh,0C0h,074h,003h,0E9h,0CEh,0FEh,08Eh,006h,010h,064h,026h  ; ovr_1cba_854f:5AA7
   	     db	     08Bh,03Dh,00Bh,0FFh,074h,003h,0E9h,0BEh,0FEh,08Eh,006h,03Ah,078h,08Bh  ; ovr_1cba_854f:5AB5
   	     db	     05Eh,0FCh,026h,08Bh,007h,089h,046h,0FCh,083h,07Eh,0FCh,000h,074h,003h  ; ovr_1cba_854f:5AC3
   	     db	     0E9h,09Bh,0FEh,0FFh,046h,0FEh,081h,07Eh,0FEh,000h,004h,07Dh,003h,0E9h  ; ovr_1cba_854f:5AD1
   	     db	     082h,0FEh,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h; raw:5ADF

X039_01 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1cba_854f:5ADF
   	     db	     006h,056h,057h,08Bh,07Eh,006h,057h,09Ah

   	     dw	     06Bh
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F0h;	ovr_1cba_854f:5AED
   	     db	     056h,0E8h,0F1h,0F9h,089h,046h,0FAh,083h,07Eh,0FAh,000h,074h,008h,056h  ; ovr_1cba_854f:5AFB
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO00E_TEXT
   	     db	     0EBh,02Ch,01Eh,0B8h,050h,05Fh,050h,08Eh,006h; ovr_1cba_854f:5B09

   	     db	     010h,064h,026h,08Bh,05Ch,002h,08Eh,006h,032h,078h,026h,08Bh,05Fh,004h  ; ovr_1cba_854f:5B17
   	     db	     0FFh,037h,08Eh,006h,010h,064h,026h,08Bh,05Ch,002h,08Eh,006h,032h,078h  ; ovr_1cba_854f:5B25
   	     db	     026h,0FFh,077h,002h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     089h,056h,0FEh,089h,046h; ovr_1cba_854f:5B33
   	     db	     0FCh,057h,09Ah
   	     dw	     089h
   	     dw	     seg CO02C_TEXT
   	     db	     0A9h,000h,001h,074h,009h,0B8h,040h; ovr_1cba_854f:5B41
   	     db	     000h,050h,09Ah
   	     dw	     043h
   	     dw	     seg CO05D_TEXT
   	     db	     08Eh,006h,010h,064h,026h,08Ah,044h; ovr_1cba_854f:5B4F
   	     db	     007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,003h,000h,075h,003h  ; ovr_1cba_854f:5B5D
   	     db	     0E9h,09Ah,000h,08Eh,006h,010h,064h,026h,08Ah,044h,007h,0B4h,000h,0D1h  ; ovr_1cba_854f:5B6B
   	     db	     0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,004h,000h,075h,041h,057h,0FFh,01Eh,034h  ; ovr_1cba_854f:5B79
   	     db	     081h,03Bh,006h,0C8h,086h,075h,006h,01Eh,0B8h,094h,02Ah,0EBh,004h,01Eh  ; ovr_1cba_854f:5B87
   	     db	     0B8h,097h,02Ah,050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,060h,081h; ovr_1cba_854f:5B95
   	     db	     03Ch,002h,077h,006h,01Eh,0B8h,07Bh,02Ah,0EBh,004h,01Eh,0B8h,09Ah,02Ah  ; ovr_1cba_854f:5BA3
   	     db	     050h,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     057h,0FFh,01Eh,018h,081h,050h,09Ah
   	     dw	     034h
   	     dw	     seg CO077_TEXT
   	     db	     0EBh,04Fh,057h,09Ah
   	     dw	     057h
   	     dw	     seg CO02C_TEXT
   	     db	     0A9h,040h,000h; ovr_1cba_854f:5BB1
   	     db	     074h,023h,0EBh,016h,0C4h,05Eh,0FCh,026h,08Ah,007h,098h,050h,09Ah

   	     dw	     031h
   	     dw	     seg BCC_FAR_AB51
   	     db	     050h,09Ah
   	     dw	     043h
   	     dw	     seg CO05D_TEXT
   	     db	     0FFh,046h,0FCh,0C4h,05Eh; ovr_1cba_854f:5BCD
   	     db	     0FCh,026h,080h,03Fh,000h,075h,0E1h,0EBh,021h,083h,07Eh,0FAh,000h,075h  ; ovr_1cba_854f:5BE9
   	     db	     010h,080h,03Eh,016h,017h,000h,074h,009h,0B8h,05Fh,000h,050h,09Ah

   	     dw	     043h
   	     dw	     seg CO05D_TEXT
   	     db	     0FFh,076h,0FEh,0FFh,076h,0FCh,09Ah
   	     dw	     052h
   	     dw	     seg CO05D_TEXT
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h ; ovr_1cba_854f:5C13


CO039_TEXT	     ends
; END LG0AB
   	     end
