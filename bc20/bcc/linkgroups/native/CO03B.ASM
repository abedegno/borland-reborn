; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
CO043_TEXT	     segment byte public 'CODE'
CO043_TEXT	     ends
   	     public  X03B_01
   	     public  X03B_00
   	     public  X03B_03
   	     public  X03B_02
   	     public  X03B_05
   	     public  X03B_04
   	     public  X03B_07
   	     public  X03B_06
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cc0_863e
; BEGIN LG0AD (gap	ovr_1cc0_863e:63E0)
CO03B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO03B_TEXT
; Original-image layout stub: not recovered source


X03B_07 label   far
   	     db	     055h,08Bh,0ECh,0C7h,006h,08Ch,081h,000h,000h,0C7h,006h,08Ah,081h,002h; ovr_1cc0_863e:63E0
   	     db	     000h,05Dh,0CBh; raw:63EE
X03B_05 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,00Ah,01Eh,0B8h,086h;		    ovr_1cc0_863e:63EE
   	     db	     081h,050h,0B8h,014h,000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,08Eh; ovr_1cc0_863e:63FC
   	     db	     006h,086h,081h,026h,089h,07Ch,008h,08Ah,046h,00Ch,098h,026h,089h,004h  ; ovr_1cc0_863e:640A
   	     db	     026h,0C7h,044h,004h,000h,000h,026h,0C6h,044h,006h,000h,026h,0C6h,044h  ; ovr_1cc0_863e:6418
   	     db	     007h,000h,00Bh,0FFh,074h,011h,057h,0FFh,01Eh,05Ch,081h,0B4h,000h,08Eh  ; ovr_1cc0_863e:6426
   	     db	     006h,086h,081h,026h,089h,044h,002h,0EBh,00Ah,08Eh,006h,086h,081h,026h  ; ovr_1cc0_863e:6434
   	     db	     0C7h,044h,002h,000h,000h,08Eh,006h,086h,081h,08Bh,046h,008h,026h,089h  ; ovr_1cc0_863e:6442
   	     db	     044h,00Ah,08Bh,046h,006h,026h,089h,044h,00Ch,08Bh,0C6h,05Fh,05Eh,05Dh  ; ovr_1cc0_863e:6450
   	     db	     0CAh,008h,000h; raw:645E
X03B_00 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,00Ch,01Eh,0B8h,086h;		    ovr_1cc0_863e:645E
   	     db	     081h,050h,0B8h,014h,000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,08Eh; ovr_1cc0_863e:646C
   	     db	     006h,086h,081h,026h,089h,07Ch,008h,08Ah,046h,00Eh,098h,026h,089h,004h  ; ovr_1cc0_863e:647A
   	     db	     08Ah,046h,006h,098h,026h,089h,044h,004h,026h,0C6h,044h,006h,000h,026h  ; ovr_1cc0_863e:6488
   	     db	     0C6h,044h,007h,000h,00Bh,0FFh,074h,011h,057h,0FFh,01Eh,05Ch,081h,0B4h  ; ovr_1cc0_863e:6496
   	     db	     000h,08Eh,006h,086h,081h,026h,089h,044h,002h,0EBh,00Ah,08Eh,006h,086h  ; ovr_1cc0_863e:64A4
   	     db	     081h,026h,0C7h,044h,002h,000h,000h,08Eh,006h,086h,081h,08Bh,046h,00Ah  ; ovr_1cc0_863e:64B2
   	     db	     026h,089h,044h,00Ah,08Bh,046h,008h,026h,089h,044h,00Ch,08Bh,0C6h,05Fh  ; ovr_1cc0_863e:64C0
   	     db	     05Eh,05Dh,0CAh,00Ah,000h; raw:64CE
X03B_06 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,00Ah,01Eh; ovr_1cc0_863e:64CE

   	     db	     0B8h,086h,081h,050h,0B8h,014h,000h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh; ovr_1cc0_863e:64DC
   	     db	     0F0h,08Eh,006h,086h,081h,026h,089h,07Ch,008h,026h,0C7h,004h,002h,000h  ; ovr_1cc0_863e:64EA
   	     db	     026h,0C7h,044h,004h,000h,000h,026h,0C6h,044h,006h,000h,026h,0C6h,044h  ; ovr_1cc0_863e:64F8
   	     db	     007h,000h,00Bh,0FFh,074h,011h,057h,0FFh,01Eh,05Ch,081h,0B4h,000h,08Eh  ; ovr_1cc0_863e:6506
   	     db	     006h,086h,081h,026h,089h,044h,002h,0EBh,00Ah,08Eh,006h,086h,081h,026h  ; ovr_1cc0_863e:6514
   	     db	     0C7h,044h,002h,000h,000h,08Eh,006h,086h,081h,08Bh,046h,008h,08Bh,056h  ; ovr_1cc0_863e:6522
   	     db	     006h,026h,089h,044h,00Ch,026h,089h,054h,00Ah,08Bh,0C6h,05Fh,05Eh,05Dh  ; ovr_1cc0_863e:6530
   	     db	     0CAh,006h,000h; raw:653E
X03B_01 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,00Ah,01Eh,0B8h,086h;		    ovr_1cc0_863e:653E
   	     db	     081h,050h,0B8h,014h,000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,08Eh; ovr_1cc0_863e:654C
   	     db	     006h,086h,081h,026h,089h,07Ch,008h,026h,0C7h,004h,033h,000h,057h,0FFh  ; ovr_1cc0_863e:655A
   	     db	     01Eh,05Ch,081h,0B4h,000h,08Eh,006h,086h,081h,026h,089h,044h,002h,026h  ; ovr_1cc0_863e:6568
   	     db	     0C7h,044h,004h,000h,000h,026h,0C6h,044h,006h,000h,026h,0C6h,044h,007h  ; ovr_1cc0_863e:6576
   	     db	     000h,08Bh,046h,00Ch,026h,089h,044h,00Ah,08Ah,046h,008h,026h,088h,044h  ; ovr_1cc0_863e:6584
   	     db	     00Ch,08Ah,046h,006h,026h,088h,044h,00Dh,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh  ; ovr_1cc0_863e:6592
   	     db	     008h,000h;	raw:65A0
X03B_04 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,076h,006h,08Eh,006h,086h,081h;	    ovr_1cc0_863e:65A0
   	     db	     026h,08Bh,07Ch,00Ah,026h,083h,004h,0F5h,057h,0E8h,096h,000h,00Bh,0C0h  ; ovr_1cc0_863e:65AE
   	     db	     074h,00Eh,057h,0E8h,016h,002h,08Eh,006h,086h,081h,026h,089h,044h,00Ah  ; ovr_1cc0_863e:65BC
   	     db	     0EBh,012h,057h,0E8h,0E9h,000h,08Eh,006h,086h,081h,026h,089h,044h,00Ah  ; ovr_1cc0_863e:65CA
   	     db	     057h,0E8h,056h,001h,08Bh,0F8h,0B8h,012h,000h,050h,08Eh,006h,086h,081h  ; ovr_1cc0_863e:65D8
   	     db	     026h,0FFh,074h,008h,057h,0E8h,044h,001h,050h,056h,0FFh,01Eh,0B8h,080h  ; ovr_1cc0_863e:65E6
   	     db	     05Fh,05Eh,05Dh,0CAh,002h,000h   ; ovr_1cc0_863e:65F4

CO03B_TEXT	     ends
; END LG0AD
; BEGIN NODECNVT (listing ovr_1cc0_863e:65FA)

        extrn   BCC_NODE_REPLACE:word
        extrn   BCC_RD_8606_W:word


CO03B_TEXT	     segment byte public 'CODE'
        assume  cs:CO03B_TEXT,ds:DGROUP

   	     public  X03B_02
X03B_02 label   far
BCC_NODE_CONVERT	     proc    far
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        push    di
        mov     si,word ptr [bp+6]
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        mov     di,word ptr es:[si+10]
        add     word ptr es:[si],-16
        push    di
        db	     0E8h,03Ch,000h
        or	     ax,ax
        je	     short M001_@@REBUILD
        push    di
        db	     0E8h,0BCh,001h
        mov     word ptr [bp-2],ax
        jmp     short M001_@@REPLACE
M001_@@REBUILD:
        push    di
        db	     0E8h,094h,000h
        mov     word ptr [bp-2],ax
        push    di
        db	     0E8h,006h,001h
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        mov     word ptr es:[si+10],ax
M001_@@REPLACE:
        mov     ax,41
        push    ax
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        push    word ptr es:[si+8]
        push    word ptr [bp-2]
        push    si
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_NODE_REPLACE
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    2
BCC_NODE_CONVERT	     endp
CO03B_TEXT	     ends

; END NODECNVT
; BEGIN NODETST2 (listing ovr_1cc0_863e:6650)

        extrn   BCC_RD_8606_W:word


CO03B_TEXT	     segment byte public 'CODE'
        assume  cs:CO03B_TEXT,ds:DGROUP

BCC_NODE_TEST2  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    si
        mov     si,word ptr [bp+4]
        or	     si,si
        jne     short M002_@@CHECK_KIND
M002_@@FALSE_EARLY:
        xor     ax,ax
        jmp     short M002_@@DONE
M002_@@CHECK_KIND:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        cmp     word ptr es:[si],7
        jg	     short M002_@@CHECK_51
        jmp     short M002_@@FALSE_EARLY
M002_@@CHECK_51:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        cmp     word ptr es:[si],51
        jne     short M002_@@CHECK_54
        push    word ptr es:[si+10]
        call    near ptr BCC_NODE_TEST2
        jmp     short M002_@@DONE
M002_@@CHECK_54:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        cmp     word ptr es:[si],54
        jne     short M002_@@CHILDREN
        mov     ax,1
        jmp     short M002_@@DONE
M002_@@CHILDREN:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        push    word ptr es:[si+10]
        call    near ptr BCC_NODE_TEST2
        or	     ax,ax
        jne     short M002_@@TRUE
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        push    word ptr es:[si+12]
        call    near ptr BCC_NODE_TEST2
        or	     ax,ax
        je	     short M002_@@FALSE
M002_@@TRUE:
        mov     ax,1
        jmp     short M002_@@DONE
M002_@@FALSE:
        xor     ax,ax
M002_@@DONE:
        pop     si
        pop     bp
        dec     bp
        ret     2
BCC_NODE_REBUILD	     label   near
BCC_NODE_TEST2  endp
CO03B_TEXT	     ends

; Original-target semantic	aliases	(zero bytes)
BCC_NODE_CLONE  equ     BCC_NODE_TEST2+0E2h
BCC_NODE_NORMALIZE	     equ     BCC_NODE_TEST2+188h
; END NODETST2
; BEGIN LG0AE (gap	ovr_1cc0_863e:66B9)
CO03B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO03B_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,056h,08Bh,076h,004h,00Bh,0F6h,075h,004h,033h,0C0h  ; ovr_1cc0_863e:66B9
   	     db	     0EBh,063h,056h,0E8h,0DAh,000h,08Bh,0F0h,08Eh,006h,086h,081h,026h,083h  ; ovr_1cc0_863e:66C7
   	     db	     03Ch,007h,07Fh,002h,0EBh,04Fh,08Eh,006h,086h,081h,026h,083h,03Ch,033h  ; ovr_1cc0_863e:66D5
   	     db	     075h,002h,0EBh,030h,08Eh,006h,086h,081h,026h,083h,03Ch,023h,074h,006h  ; ovr_1cc0_863e:66E3
   	     db	     026h,083h,03Ch,024h,075h,00Dh,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah  ; ovr_1cc0_863e:66F1
   	     db	     0E8h,0B7h,0FFh,0EBh,028h,08Eh,006h,086h,081h,026h,0FFh,074h,00Ch,0E8h  ; ovr_1cc0_863e:66FF
   	     db	     0AAh,0FFh,08Eh,006h,086h,081h,026h,089h,044h,00Ch,08Eh,006h,086h,081h  ; ovr_1cc0_863e:670D
   	     db	     026h,0FFh,074h,00Ah,0E8h,097h,0FFh,08Eh,006h,086h,081h,026h,089h,044h  ; ovr_1cc0_863e:671B
   	     db	     00Ah,08Bh,0C6h,05Eh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,056h  ; ovr_1cc0_863e:6729
   	     db	     08Bh,076h,004h,00Bh,0F6h,075h,004h,033h,0C0h,0EBh,05Fh,056h,0E8h,061h  ; ovr_1cc0_863e:6737
   	     db	     000h,08Bh,0F0h,08Eh,006h,086h,081h,026h,083h,03Ch,007h,07Fh,002h,0EBh  ; ovr_1cc0_863e:6745
   	     db	     04Bh,08Eh,006h,086h,081h,026h,083h,03Ch,033h,075h,002h,0EBh,02Ch,08Eh  ; ovr_1cc0_863e:6753
   	     db	     006h,086h,081h,026h,083h,03Ch,012h,07Ch,00Fh,026h,083h,03Ch,01Ch,07Fh  ; ovr_1cc0_863e:6761
   	     db	     009h,026h,0FFh,074h,00Ah,0E8h,0BBh,0FFh,0EBh,028h,08Eh,006h,086h,081h  ; ovr_1cc0_863e:676F
   	     db	     026h,0FFh,074h,00Ch,0E8h,0AEh,0FFh,08Eh,006h,086h,081h,026h,089h,044h  ; ovr_1cc0_863e:677D
   	     db	     00Ch,08Eh,006h,086h,081h,026h,0FFh,074h,00Ah,0E8h,09Bh,0FFh,08Eh,006h  ; ovr_1cc0_863e:678B
   	     db	     086h,081h,026h,089h,044h,00Ah,08Bh,0C6h,05Eh,05Dh,04Dh,0C2h,002h,000h  ; ovr_1cc0_863e:6799
   	     db	     045h,055h,08Bh,0ECh,056h,01Eh,0B8h,086h,081h,050h,0B8h,014h,000h,050h  ; ovr_1cc0_863e:67A7
   	     db	     09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0FFh,036h,086h,081h,056h,0FFh,036h; ovr_1cc0_863e:67B5

   	     db	     086h,081h,0FFh,076h,004h,0B9h,014h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Bh; ovr_1cc0_863e:67C3
   	     db	     0C6h,05Eh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,083h,0ECh,00Ah  ; ovr_1cc0_863e:67D1
   	     db	     056h,057h,08Bh,076h,004h,08Eh,006h,086h,081h,026h,083h,03Ch,033h,075h  ; ovr_1cc0_863e:67DF
   	     db	     009h,026h,08Bh,044h,00Ah,089h,046h,0FEh,0EBh,003h,089h,076h,0FEh,08Bh  ; ovr_1cc0_863e:67ED
   	     db	     05Eh,0FEh,08Eh,006h,086h,081h,026h,08Bh,07Fh,00Ah,026h,0FFh,075h,008h  ; ovr_1cc0_863e:67FB
   	     db	     0FFh,01Eh,0C4h,080h,089h,046h,0F6h,0B8h,005h,000h,050h,08Eh,006h,086h  ; ovr_1cc0_863e:6809
   	     db	     081h,026h,0FFh,075h,008h,0FFh,076h,0F6h,033h,0C0h,050h,050h,0FFh,01Eh  ; ovr_1cc0_863e:6817
   	     db	     0BCh,080h,089h,046h,0FCh,0B8h,005h,000h,050h,08Eh,006h,086h,081h,026h  ; ovr_1cc0_863e:6825
   	     db	     0FFh,075h,008h,0FFh,076h,0F6h,033h,0C0h,050h,050h,0FFh,01Eh,0BCh,080h  ; ovr_1cc0_863e:6833
   	     db	     08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h,089h,047h,00Ah,0B8h,012h,000h  ; ovr_1cc0_863e:6841
   	     db	     050h,026h,0FFh,075h,008h,0FFh,076h,0FCh,057h,0FFh,01Eh,0B8h,080h,089h  ; ovr_1cc0_863e:684F
   	     db	     046h,0FAh,0B8h,031h,000h,050h,08Bh,05Eh,0FEh,08Eh,006h,086h,081h,026h  ; ovr_1cc0_863e:685D
   	     db	     0FFh,077h,008h,0FFh,076h,0FAh,033h,0C0h,050h,0FFh,01Eh,0B8h,080h,089h  ; ovr_1cc0_863e:686B
   	     db	     046h,0F8h,08Eh,006h,086h,081h,026h,083h,03Ch,033h,075h,018h,0FFh,076h  ; ovr_1cc0_863e:6879
   	     db	     0F8h,026h,0FFh,074h,008h,026h,08Ah,044h,00Ch,050h,026h,08Ah,044h,00Dh  ; ovr_1cc0_863e:6887
   	     db	     050h,0FFh,01Eh,0B0h,080h,089h,046h,0F8h,08Bh,046h,0F8h,05Fh,05Eh,08Bh  ; ovr_1cc0_863e:6895
   	     db	     0E5h,05Dh,04Dh,0C2h,002h,000h   ; ovr_1cc0_863e:68A3

CO03B_TEXT	     ends
; END LG0AE
; BEGIN NODESCAN (listing ovr_1cc0_863e:68A9)

        extrn   BCC_RD_8606_W:word
        extrn   BCC_NODE_TEST_HOOK:word


CO03B_TEXT	     segment byte public 'CODE'
        assume  cs:CO03B_TEXT,ds:DGROUP

   	     public  X03B_03
X03B_03 label   far
BCC_NODE_SCAN   proc    far
        push    bp
        mov     bp,sp
        push    si
        mov     si,word ptr [bp+6]
        jmp     short M004_@@TEST
M004_@@NEXT:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        mov     bx,word ptr es:[si]
        dec     bx
        cmp     bx,53
        ja	     short M004_@@CHILDREN
        shl     bx,1
        db	     02Eh,0FFh,0A7h,01Bh,005h
        jmp     short M004_@@FALSE
M004_@@TRUE:
        mov     ax,1
        jmp     short M004_@@DONE
        jmp     short M004_@@LEFT
M004_@@CHILDREN:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        cmp     word ptr es:[si+12],0
        je	     short M004_@@LEFT
        push    word ptr es:[si+12]
        db	     0FFh,01Eh
        dw	     DGROUP:BCC_NODE_TEST_HOOK
        or	     ax,ax
        je	     short M004_@@LEFT
        jmp     short M004_@@TRUE
M004_@@LEFT:
        mov     es,word ptr DGROUP:BCC_RD_8606_W
        mov     si,word ptr es:[si+10]
M004_@@TEST:
        or	     si,si
        jne     short M004_@@NEXT
M004_@@FALSE:
        xor     ax,ax
M004_@@DONE:
        pop     si
        pop     bp
        retf    2
BCC_NODE_SCAN   endp
CO03B_TEXT	     ends

; END NODESCAN
; BEGIN LG0AF (gap	ovr_1cc0_863e:68FB)
CO03B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO03B_TEXT
; Original-image layout stub: not recovered source


   	     db	     0E6h,004h,0E6h,004h,0E6h,004h,0E6h,004h,0E6h,004h,0E6h,004h,0E6h,004h  ; ovr_1cc0_863e:68FB
   	     db	     0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h  ; ovr_1cc0_863e:6909
   	     db	     0EFh,004h,0EFh,004h,0EFh,004h,0E8h,004h,0E8h,004h,0E8h,004h,0E8h,004h  ; ovr_1cc0_863e:6917
   	     db	     0E8h,004h,0E8h,004h,0E8h,004h,0E8h,004h,0E8h,004h,0E8h,004h,0E8h,004h  ; ovr_1cc0_863e:6925
   	     db	     0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0E8h,004h  ; ovr_1cc0_863e:6933
   	     db	     0E8h,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h  ; ovr_1cc0_863e:6941
   	     db	     0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h,0EFh,004h  ; ovr_1cc0_863e:694F
   	     db	     0EFh,004h,0EDh,004h,0EFh,004h,0EFh,004h,0E8h,004h	     ;		    ovr_1cc0_863e:695D

CO03B_TEXT	     ends
; END LG0AF
   	     end
