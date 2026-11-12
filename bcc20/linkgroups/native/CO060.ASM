   	     public  X060_00
   	     public  X060_01
   	     public  X060_02
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d80_a69d
; BEGIN STAOV09D (listing ovr_1d80_a69d:69D0)

   	     extrn   X05F_09:far


CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP

M000_BCC_DATA_8144	     equ     8144h
M000_BCC_DATA_8654	     equ     8654h
M000_BCC_DATA_866E	     equ     866Eh
M000_BCC_DATA_86EC	     equ     86ECh
M000_BCC_DATA_86FD	     equ     86FDh

   	     public  X060_00
X060_00 label   far
BCC_FAR_69D0    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     AX,DGROUP:M000_BCC_DATA_86EC
   	     mov     word ptr [BP-2],AX
   	     db	     09Ah
   	     dw	     X05F_09
   	     dw	     seg X05F_09
   	     mov     word ptr [BP-4],AX
   	     cmp     word ptr [BP-4],0
   	     jne     short M000_L_69EF
   	     db	     0E9h
   	     dw	     00095h
M000_L_69EF:
   	     mov     word ptr [BP-6],0
   	     mov     word ptr [BP-8],0
   	     mov     word ptr [BP-0Ah],1
   	     mov     byte ptr [BP-0Bh],0
   	     push    word ptr [BP-2]
   	     push    SS
   	     lea     AX,[BP-0Ah]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-8]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-6]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-0Bh]
   	     push    AX
   	     db	     0E8h
   	     dw	     0006Eh
   	     cmp     word ptr [BP-8],0
   	     je	     short M000_L_6A84
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_866E
   	     or	     byte ptr ES:[BX+0Eh],2
   	     mov     AL,byte ptr [BP-0Bh]
   	     mov     byte ptr ES:[BX+7],AL
   	     cmp     word ptr ES:[BX],0
   	     je	     short M000_L_6A44
   	     push    word ptr ES:[BX]
   	     cbw
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8144h
M000_L_6A44:
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-0Bh]
   	     shl     AX,CL
   	     mov     DI,AX
   	     or	     word ptr DGROUP:M000_BCC_DATA_86FD,DI
   	     mov     BX,word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     or	     word ptr ES:[BX+14h],DI
   	     mov     SI,word ptr [BP-6]
   	     jmp     short M000_L_6A6E
M000_L_6A62:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     or	     word ptr ES:[SI+4],DI
   	     mov     SI,word ptr ES:[SI+10h]
M000_L_6A6E:
   	     or	     SI,SI
   	     jne     short M000_L_6A62
   	     mov     BX,word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     push    word ptr ES:[BX+16h]
   	     push    DI
   	     db	     0E8h
   	     dw	     000B7h
   	     db	     0E9h
   	     dw	     0FF6Bh
M000_L_6A84:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf
BCC_FAR_69D0    endp
CO060_TEXT	     ends

; END STAOV09D
; BEGIN STAOV09E (listing ovr_1d80_a69d:6A8A)



CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP

M001_BCC_DATA_8654	     equ     8654h
M001_BCC_DATA_866E	     equ     866Eh
M001_BCC_DATA_8672	     equ     8672h
M001_BCC_DATA_86FB	     equ     86FBh

BCC_NEAR_6A8A   proc    near
M001_L_6A8A:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,6
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+14h]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8654
   	     mov     AX,word ptr ES:[SI+4]
   	     or	     AX,word ptr DGROUP:M001_BCC_DATA_86FB
   	     not     AX
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     je	     short M001_L_6AFD
   	     mov     DI,2
   	     jmp     short M001_L_6AF7
M001_L_6AB2:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_866E
   	     cmp     word ptr ES:[DI+2],SI
   	     jne     short M001_L_6AF4
   	     push    DI
   	     push    SS
   	     lea     AX,[BP-3]
   	     push    AX
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     000C7h
   	     mov     word ptr [BP-6],AX
   	     les     BX,[BP+10h]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr [BP-6]
   	     jnc     short M001_L_6AF4
   	     les     BX,[BP+0Ch]
   	     mov     word ptr ES:[BX],DI
   	     les     BX,[BP+8]
   	     mov     word ptr ES:[BX],SI
   	     les     BX,[BP+10h]
   	     mov     AX,word ptr [BP-6]
   	     mov     word ptr ES:[BX],AX
   	     les     BX,[BP+4]
   	     mov     AL,byte ptr [BP-3]
   	     mov     byte ptr ES:[BX],AL
M001_L_6AF4:
   	     add     DI,1Dh
M001_L_6AF7:
   	     cmp     DI,word ptr DGROUP:M001_BCC_DATA_8672
   	     jc	     short M001_L_6AB2
M001_L_6AFD:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+16h]
   	     jmp     short M001_L_6B2B
M001_L_6B07:
   	     push    SI
   	     push    word ptr [BP+12h]
   	     push    word ptr [BP+10h]
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     push    word ptr [BP+0Ah]
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FF67h
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+18h]
M001_L_6B2B:
   	     or	     SI,SI
   	     jne     short M001_L_6B07
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     12h
BCC_NEAR_6A8A   endp
CO060_TEXT	     ends

; END STAOV09E
; BEGIN STAOV09F (listing ovr_1d80_a69d:6B38)

CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP

M002_BCC_DATA_8654	     equ     8654h


BCC_NEAR_6B38   proc    near
M002_L_6B38:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     DI,word ptr [BP+4]
   	     jmp     short M002_L_6B62
M002_L_6B46:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8654
   	     or	     word ptr ES:[SI+4],DI
   	     or	     word ptr ES:[SI+14h],DI
   	     push    word ptr ES:[SI+16h]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FFDEh
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+18h]
M002_L_6B62:
   	     or	     SI,SI
   	     jne     short M002_L_6B46
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_6B38   endp
CO060_TEXT	     ends

; END STAOV09F
; BEGIN STAOV0A0 (listing ovr_1d80_a69d:6B6D)

CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP



BCC_NEAR_6B6D   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+4]
   	     mov     DL,0
   	     mov     SI,1
   	     jmp     short M003_L_6B81
M003_L_6B7D:
   	     shl     SI,1
   	     inc     DL
M003_L_6B81:
   	     db	     085h,0F7h
   	     je	     short M003_L_6B7D
   	     mov     AL,DL
   	     cbw
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_6B6D   endp
CO060_TEXT	     ends

; END STAOV0A0
; BEGIN STAOV0A1 (listing ovr_1d80_a69d:6B8F)

   	     extrn   X05F_00:far


CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP

M004_BCC_DATA_5356	     equ     5356h
M004_BCC_DATA_5358	     equ     5358h
M004_BCC_DATA_535C	     equ     535Ch
M004_BCC_DATA_866E	     equ     866Eh

BCC_NEAR_6B8F   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,6
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ah]
   	     mov     DI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M004_L_6BA7
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     001CBh
M004_L_6BA7:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     test    byte ptr ES:[SI+0Eh],86h
   	     je	     short M004_L_6BB7
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     001BBh
M004_L_6BB7:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     test    byte ptr ES:[SI+0Eh],1
   	     je	     short M004_L_6BD5
   	     cmp     SI,2
   	     jbe     short M004_L_6BD5
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,word ptr ES:[SI-1Dh]
   	     jne     short M004_L_6BD5
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0019Dh
M004_L_6BD5:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     AX,word ptr ES:[SI+1Bh]
   	     not     AX
   	     and     DI,AX
   	     or	     DI,DI
   	     jne     short M004_L_6BEA
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00188h
M004_L_6BEA:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     AL,byte ptr ES:[SI+6]
   	     mov     AH,0
   	     dec     AX
   	     mov     BX,AX
   	     cmp     BX,14h
   	     jbe     short M004_L_6BFF
   	     db	     0E9h
   	     dw	     0009Fh
M004_L_6BFF:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     3ABh
   	     db	     09Ah
   	     dw	     X05F_00
   	     dw	     seg X05F_00
   	     mov     word ptr [BP-6],AX
   	     test    word ptr [BP-6],DI
   	     jne     short M004_L_6C18
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0015Ah
M004_L_6C18:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     cmp     word ptr ES:[SI+17h],0
   	     je	     short M004_L_6C2D
   	     test    word ptr DGROUP:M004_BCC_DATA_535C,DI
   	     je	     short M004_L_6C2D
   	     and     DI,word ptr DGROUP:M004_BCC_DATA_535C
M004_L_6C2D:
   	     push    DI
   	     db	     0E8h
   	     dw	     0FF3Ch
   	     les     BX,[BP+6]
   	     mov     byte ptr ES:[BX],AL
   	     jmp     short M004_L_6CA3
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     cmp     word ptr ES:[SI+15h],0
   	     je	     short M004_L_6C62
   	     test    word ptr DGROUP:M004_BCC_DATA_5358,DI
   	     je	     short M004_L_6C62
   	     mov     AX,word ptr ES:[SI+13h]
   	     cmp     AX,word ptr ES:[SI+15h]
   	     jbe     short M004_L_6C5C
   	     test    word ptr DGROUP:M004_BCC_DATA_5356,DI
   	     je	     short M004_L_6C5C
   	     jmp     short M004_L_6C73
M004_L_6C5C:
   	     and     DI,word ptr DGROUP:M004_BCC_DATA_5358
   	     jmp     short M004_L_6C77
M004_L_6C62:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     cmp     word ptr ES:[SI+13h],0
   	     je	     short M004_L_6C77
   	     test    word ptr DGROUP:M004_BCC_DATA_5356,DI
   	     je	     short M004_L_6C77
M004_L_6C73:
   	     and     DI,word ptr DGROUP:M004_BCC_DATA_5356
M004_L_6C77:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     cmp     word ptr ES:[SI+13h],0
   	     jne     short M004_L_6C89
   	     mov     AX,DGROUP:M004_BCC_DATA_5356
   	     not     AX
   	     and     DI,AX
M004_L_6C89:
   	     or	     DI,DI
   	     jne     short M004_L_6C92
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     000E0h
M004_L_6C92:
   	     push    DI
   	     db	     0E8h
   	     dw	     0FED7h
   	     les     BX,[BP+6]
   	     mov     byte ptr ES:[BX],AL
   	     jmp     short M004_L_6CA3
M004_L_6C9E:
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     000CFh
M004_L_6CA3:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     test    byte ptr ES:[SI+0Eh],8
   	     je	     short M004_L_6CB5
   	     mov     word ptr [BP-2],8000h
   	     jmp     short M004_L_6CDC
M004_L_6CB5:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     CL,byte ptr ES:[SI+8]
   	     mov     AX,1
   	     shl     AX,CL
   	     db	     085h,0C7h
   	     je	     short M004_L_6CD7
   	     mov     word ptr [BP-2],2
   	     mov     AL,byte ptr ES:[SI+8]
   	     les     BX,[BP+6]
   	     mov     byte ptr ES:[BX],AL
   	     jmp     short M004_L_6CDC
M004_L_6CD7:
   	     mov     word ptr [BP-2],0
M004_L_6CDC:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     AX,word ptr ES:[SI+11h]
   	     add     word ptr [BP-2],AX
   	     les     BX,[BP+6]
   	     mov     CL,byte ptr ES:[BX]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr DGROUP:M004_BCC_DATA_5358,AX
   	     je	     short M004_L_6D03
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     AX,word ptr ES:[SI+15h]
   	     add     word ptr [BP-2],AX
M004_L_6D03:
   	     les     BX,[BP+6]
   	     mov     CL,byte ptr ES:[BX]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr DGROUP:M004_BCC_DATA_5356,AX
   	     je	     short M004_L_6D1F
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     AX,word ptr ES:[SI+13h]
   	     add     word ptr [BP-2],AX
M004_L_6D1F:
   	     les     BX,[BP+6]
   	     mov     CL,byte ptr ES:[BX]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr DGROUP:M004_BCC_DATA_535C,AX
   	     je	     short M004_L_6D3B
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     mov     AX,word ptr ES:[SI+17h]
   	     add     word ptr [BP-2],AX
M004_L_6D3B:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     cmp     byte ptr ES:[SI+0Dh],6
   	     jne     short M004_L_6D5B
   	     cmp     byte ptr ES:[SI+8],0
   	     je	     short M004_L_6D54
   	     mov     word ptr [BP-4],0
   	     jmp     short M004_L_6D60
M004_L_6D54:
   	     mov     word ptr [BP-4],2
   	     jmp     short M004_L_6D60
M004_L_6D5B:
   	     mov     word ptr [BP-4],1
M004_L_6D60:
   	     mov     AX,word ptr [BP-2]
   	     cmp     AX,word ptr [BP-4]
   	     jnc     short M004_L_6D6C
   	     xor     AX,AX
   	     jmp     short M004_L_6D72
M004_L_6D6C:
   	     mov     AX,word ptr [BP-2]
   	     sub     AX,word ptr [BP-4]
M004_L_6D72:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     8
BCC_NEAR_6B8F   endp
CO060_TEXT	     ends

; END STAOV0A1
; BEGIN STOVT182 (listing ovr_1d80_a69d:6D7B)
CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT

BCC_TABLE_6D7B  label   word
   	     dw	     00236h
   	     dw	     00236h
   	     dw	     00269h
   	     dw	     00269h
   	     dw	     00269h
   	     dw	     00269h
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     00269h
   	     dw	     00269h
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     002CEh
   	     dw	     00269h

CO060_TEXT	     ends
; END STOVT182
; BEGIN STAOV0A2 (listing ovr_1d80_a69d:6DA5)

   	     extrn   BCC_FAR_AF23:far
   	     extrn   X043_03:far


CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP

M006_BCC_DATA_1707	     equ     1707h
M006_BCC_DATA_8134	     equ     8134h
M006_BCC_DATA_8148	     equ     8148h
M006_BCC_DATA_8150	     equ     8150h
M006_BCC_DATA_815C	     equ     815Ch
M006_BCC_DATA_8168	     equ     8168h
M006_BCC_DATA_816C	     equ     816Ch
M006_BCC_DATA_866E	     equ     866Eh
M006_BCC_DATA_86EC	     equ     86ECh
M006_BCC_DATA_86F2	     equ     86F2h
M006_BCC_DATA_8707	     equ     8707h

   	     public  X060_02
X060_02 label   far
BCC_FAR_6DA5    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ah]
   	     or	     DI,DI
   	     je	     short M006_L_6DC1
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     816Ch
   	     mov     SI,AX
   	     or	     SI,SI
   	     je	     short M006_L_6DC1
   	     db	     0E9h
   	     dw	     000FFh
M006_L_6DC1:
   	     push    DS
   	     mov     AX,866Eh
   	     push    AX
   	     mov     AX,1Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     push    word ptr DGROUP:M006_BCC_DATA_866E
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,1Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     word ptr ES:[SI],DI
   	     mov     byte ptr ES:[SI+8],0FFh
   	     or	     DI,DI
   	     jne     short M006_L_6DF5
   	     db	     0E9h
   	     dw	     000B4h
M006_L_6DF5:
   	     push    DI
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     8148h
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8168h
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     word ptr ES:[SI+0Bh],AX
   	     push    word ptr ES:[SI+0Bh]
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     byte ptr ES:[SI+6],AL
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     word ptr ES:[SI+9],AX
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     byte ptr ES:[SI+0Dh],AL
   	     mov     AX,DGROUP:M006_BCC_DATA_8707
   	     mov     word ptr ES:[SI+2],AX
   	     cmp     word ptr [BP-2],6
   	     jne     short M006_L_6E4B
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_86F2,4
   	     jne     short M006_L_6E4B
   	     jmp     short M006_L_6E71
M006_L_6E4B:
   	     test    byte ptr [BP+6],8
   	     je	     short M006_L_6E5C
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     byte ptr ES:[SI+0Eh],8
   	     jmp     short M006_L_6E7A
M006_L_6E5C:
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_1707,2
   	     jne     short M006_L_6E65
   	     jmp     short M006_L_6E71
M006_L_6E65:
   	     cmp     word ptr [BP-2],6
   	     je	     short M006_L_6E7A
   	     cmp     word ptr [BP-2],5
   	     je	     short M006_L_6E7A
M006_L_6E71:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     byte ptr ES:[SI+0Eh],4
M006_L_6E7A:
   	     test    byte ptr [BP+6],2
   	     je	     short M006_L_6E89
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     or	     byte ptr ES:[SI+0Eh],80h
M006_L_6E89:
   	     test    byte ptr [BP+6],10h
   	     je	     short M006_L_6E98
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     or	     byte ptr ES:[SI+0Eh],1
M006_L_6E98:
   	     cmp     word ptr [BP-2],5
   	     je	     short M006_L_6EC0
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     or	     byte ptr ES:[SI+0Eh],20h
   	     jmp     short M006_L_6EC0
M006_L_6EA9:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_866E
   	     mov     AX,DGROUP:M006_BCC_DATA_86EC
   	     mov     word ptr ES:[SI+2],AX
   	     mov     AL,byte ptr [BP+8]
   	     mov     byte ptr ES:[SI+6],AL
   	     mov     byte ptr ES:[SI+0Dh],5
M006_L_6EC0:
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    6
BCC_FAR_6DA5    endp
CO060_TEXT	     ends

; END STAOV0A2
; BEGIN STAOV0A3 (listing ovr_1d80_a69d:6ECA)

   	     extrn   X062_0D:far


CO060_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO060_TEXT,ds:DGROUP

M007_BCC_DATA_8148	     equ     8148h
M007_BCC_DATA_866E	     equ     866Eh
M007_BCC_DATA_8672	     equ     8672h
M007_BCC_DATA_8674	     equ     8674h

   	     public  X060_01
X060_01 label   far
BCC_FAR_6ECA    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,2
   	     jmp     short M007_L_6EEA
M007_L_6ED3:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_866E
   	     cmp     word ptr ES:[SI],0
   	     je	     short M007_L_6EE7
   	     push    word ptr ES:[SI]
   	     xor     AX,AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8148h
M007_L_6EE7:
   	     add     SI,1Dh
M007_L_6EEA:
   	     cmp     SI,word ptr DGROUP:M007_BCC_DATA_8672
   	     jc	     short M007_L_6ED3
   	     mov     word ptr DGROUP:M007_BCC_DATA_8674,0
   	     mov     word ptr DGROUP:M007_BCC_DATA_8672,2
   	     db	     09Ah
   	     dw	     X062_0D
   	     dw	     seg X062_0D
   	     pop     SI
   	     pop     BP
   	     retf
BCC_FAR_6ECA    endp
CO060_TEXT	     ends

; END STAOV0A3
   	     end
