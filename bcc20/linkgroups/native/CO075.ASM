   	     public  X075_00
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1dd7_b258
; BEGIN STAOV167 (listing ovr_1dd7_b258:2580)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X078_01:far


CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M000_BCC_DATA_80D0	     equ     80D0h
M000_BCC_DATA_80FC	     equ     80FCh
M000_BCC_DATA_8186	     equ     8186h
M000_BCC_DATA_88BA	     equ     88BAh

   	     public  X075_00
X075_00 label   far
STAOV167	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Eh
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     push    SI
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X078_01
   	     dw	     seg X078_01
   	     mov     word ptr [BP-0Ch],DX
   	     mov     word ptr [BP-0Eh],AX
   	     cmp     word ptr [BP-0Eh],0
   	     je	     short M000_L_25A3
   	     db	     0E9h
   	     dw	     0011Bh
M000_L_25A3:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     push    word ptr ES:[BX+8]
   	     db	     0FFh,01Eh
   	     dw	     80FCh
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     push    word ptr ES:[BX+8]
   	     db	     0FFh,01Eh
   	     dw	     80D0h
   	     mov     DGROUP:M000_BCC_DATA_88BA,AX
   	     xor     AX,AX
   	     mov     word ptr [BP-6],AX
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-8],AX
   	     xor     DI,DI
   	     mov     AX,6
   	     push    AX
   	     xor     AX,AX
   	     mov     DX,1055h
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+0Ch],0
   	     je	     short M000_L_2643
   	     cmp     word ptr [BP-2],1
   	     je	     short M000_L_2633
   	     push    word ptr [BP-8]
   	     db	     0E8h
   	     dw	     000DBh
   	     mov     DI,AX
   	     cmp     word ptr DGROUP:M000_BCC_DATA_88BA,0
   	     jge     short M000_L_262E
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],2Bh
   	     jne     short M000_L_262A
   	     mov     word ptr [BP-0Ah],DI
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     DI,word ptr ES:[BX+0Ah]
   	     mov     word ptr ES:[BX+0Ah],0
   	     jmp     short M000_L_2633
M000_L_262A:
   	     xor     DI,DI
   	     jmp     short M000_L_2633
M000_L_262E:
   	     mov     word ptr [BP-8],0
M000_L_2633:
   	     push    word ptr [BP-8]
   	     db	     0E8h
   	     dw	     000E1h
   	     add     word ptr [BP-6],AX
   	     push    DI
   	     db	     0E8h
   	     dw	     00127h
   	     add     word ptr [BP-4],AX
M000_L_2643:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     00175h
   	     mov     word ptr [BP-0Eh],AX
   	     mov     word ptr [BP-0Ch],0
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     sub     BX,7
   	     cmp     BX,9
   	     ja	     short M000_L_2694
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     14Ch
   	     mov     AX,0C3h
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-0Ch],AX
   	     jmp     short M000_L_2694
   	     mov     AX,0B3h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-0Eh],AX
M000_L_2694:
   	     cmp     word ptr [BP-4],0
   	     je	     short M000_L_26A9
   	     mov     AX,0AEh
   	     push    AX
   	     mov     AX,word ptr [BP-4]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
M000_L_26A9:
   	     cmp     word ptr [BP-6],0
   	     je	     short M000_L_26BE
   	     mov     AX,0ADh
   	     push    AX
   	     mov     AX,word ptr [BP-6]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
M000_L_26BE:
   	     mov     DX,word ptr [BP-0Ch]
   	     mov     AX,word ptr [BP-0Eh]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV167	     endp
CO075_TEXT	     ends

; END STAOV167
; BEGIN STOVT19A (listing ovr_1dd7_b258:26CC)
CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT

STOVT19A	     label   word
   	     dw	     000EDh
   	     dw	     000EDh
   	     dw	     00101h
   	     dw	     00101h
   	     dw	     00101h
   	     dw	     00114h
   	     dw	     00114h
   	     dw	     00114h
   	     dw	     000EDh
   	     dw	     000EDh

CO075_TEXT	     ends
; END STOVT19A
; BEGIN STAOV168 (listing ovr_1dd7_b258:26E0)

CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M002_BCC_DATA_8186	     equ     8186h
M002_BCC_DATA_88BA	     equ     88BAh


BCC_NEAR_26E0   label   near
STAOV168	     proc    near
M002_L_26E0:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Bh
   	     jne     short M002_L_270C
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFE5h
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr DGROUP:M002_BCC_DATA_88BA,0
   	     jl	     short M002_L_2707
   	     jmp     short M002_L_270C
M002_L_2707:
   	     mov     AX,word ptr [BP-2]
   	     jmp     short M002_L_2712
M002_L_270C:
   	     dec     word ptr DGROUP:M002_BCC_DATA_88BA
   	     mov     AX,SI
M002_L_2712:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV168	     endp
CO075_TEXT	     ends

; END STAOV168
; BEGIN STAOV169 (listing ovr_1dd7_b258:271A)



CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M003_BCC_DATA_8186	     equ     8186h

BCC_NEAR_271A   label   near
STAOV169	     proc    near
M003_L_271A:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M003_L_272B
   	     xor     AX,AX
   	     jmp     short M003_L_2760
M003_L_272B:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Bh
   	     jne     short M003_L_274D
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FFDEh
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFD1h
   	     add     DI,AX
   	     jmp     short M003_L_275E
M003_L_274D:
   	     push    SI
   	     db	     0E8h
   	     dw	     001DAh
   	     mov     DI,AX
   	     push    SI
   	     db	     0E8h
   	     dw	     001F2h
   	     test    DI,1
   	     je	     short M003_L_275E
   	     inc     DI
M003_L_275E:
   	     mov     AX,DI
M003_L_2760:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV169	     endp
CO075_TEXT	     ends

; END STAOV169
; BEGIN STAOV16A (listing ovr_1dd7_b258:2767)



CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M004_BCC_DATA_8186	     equ     8186h

BCC_NEAR_2767   label   near
STAOV16A	     proc    near
M004_L_2767:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M004_L_2778
   	     xor     AX,AX
   	     jmp     short M004_L_27BC
M004_L_2778:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Bh
   	     jne     short M004_L_279A
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFDEh
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FFD1h
   	     add     DI,AX
   	     jmp     short M004_L_27BA
M004_L_279A:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     cmp     byte ptr ES:[SI+7],0
   	     je	     short M004_L_27A9
   	     xor     AX,AX
   	     jmp     short M004_L_27BC
M004_L_27A9:
   	     push    SI
   	     db	     0E8h
   	     dw	     0017Eh
   	     mov     DI,AX
   	     push    SI
   	     db	     0E8h
   	     dw	     00196h
   	     test    DI,1
   	     je	     short M004_L_27BA
   	     inc     DI
M004_L_27BA:
   	     mov     AX,DI
M004_L_27BC:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV16A	     endp
CO075_TEXT	     ends

; END STAOV16A
; BEGIN STAOV16B (listing ovr_1dd7_b258:27C3)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X058_04:far
   	     extrn   X059_04:far


CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M005_BCC_DATA_80D4	     equ     80D4h
M005_BCC_DATA_80FC	     equ     80FCh
M005_BCC_DATA_8186	     equ     8186h
M005_BCC_DATA_866E	     equ     866Eh
M005_BCC_DATA_8680	     equ     8680h
M005_BCC_DATA_8698	     equ     8698h

BCC_NEAR_27C3   label   near
STAOV16B	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     80FCh
   	     mov     word ptr [BP-8],AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     80D4h
   	     and     AX,1
   	     mov     word ptr [BP-0Ah],AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],31h
   	     je	     short M005_L_27FD
   	     db	     0E9h
   	     dw	     000E4h
M005_L_27FD:
   	     mov     SI,word ptr ES:[SI+0Ah]
   	     mov     AX,5
   	     push    AX
   	     xor     AX,AX
   	     mov     DX,1055h
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     cmp     word ptr [BP-8],4
   	     jne     short M005_L_2837
   	     mov     AX,73h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M005_L_2837:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0Dh
   	     jne     short M005_L_2880
   	     cmp     word ptr [BP-0Ah],0
   	     je	     short M005_L_286B
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,0Eh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M005_L_286B:
   	     mov     AX,75h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     db	     0E9h
   	     dw	     0009Ch
M005_L_2880:
   	     cmp     word ptr [BP-0Ah],0
   	     jne     short M005_L_289B
   	     mov     AX,75h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     db	     0E9h
   	     dw	     00081h
M005_L_289B:
   	     mov     AX,word ptr [BP-6]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[DI],10h
   	     je	     short M005_L_28B4
   	     cmp     byte ptr ES:[DI],11h
   	     jne     short M005_L_28CA
M005_L_28B4:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI]
   	     mov     word ptr [BP-0Ch],AX
   	     mov     BX,word ptr [BP-0Ch]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_866E
   	     or	     byte ptr ES:[BX+0Eh],4
M005_L_28CA:
   	     mov     AX,76h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-2],AX
   	     jmp     short M005_L_291F
M005_L_28E1:
   	     cmp     word ptr [BP-8],4
   	     jne     short M005_L_28F7
   	     mov     AX,73h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M005_L_28F7:
   	     cmp     word ptr [BP-0Ah],0
   	     je	     short M005_L_2902
   	     mov     AX,78h
   	     jmp     short M005_L_2905
M005_L_2902:
   	     mov     AX,77h
M005_L_2905:
   	     push    AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     mov     AX,1055h
   	     push    AX
   	     mov     AL,byte ptr ES:[SI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
M005_L_291C:
   	     mov     word ptr [BP-2],AX
M005_L_291F:
   	     mov     AX,word ptr [BP-2]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV16B	     endp
CO075_TEXT	     ends

; END STAOV16B
; BEGIN STAOV16C (listing ovr_1dd7_b258:292B)

CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M006_BCC_DATA_8164	     equ     8164h
M006_BCC_DATA_8186	     equ     8186h


BCC_NEAR_292B   label   near
STAOV16C	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     inc     AX
   	     and     AX,0FFFEh
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV16C	     endp
CO075_TEXT	     ends

; END STAOV16C
; BEGIN STAOV16D (listing ovr_1dd7_b258:2949)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X059_04:far
   	     extrn   X059_06:far
   	     extrn   X059_09:far
   	     extrn   X062_09:far


CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M007_BCC_DATA_8104	     equ     8104h
M007_BCC_DATA_8186	     equ     8186h
M007_BCC_DATA_86D2	     equ     86D2h

BCC_NEAR_2949   label   near
STAOV16D	     proc    near
M007_L_2949:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,6
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],32h
   	     jne     short M007_L_2973
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     BX,word ptr ES:[BX+2]
   	     test    byte ptr [BX+9CAh],2
   	     je	     short M007_L_2973
   	     db	     81h,0Eh,0D2h,86h,02h,00h
M007_L_2973:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     dec     BX
   	     cmp     BX,13h
   	     jbe     short M007_L_2984
   	     db	     0E9h
   	     dw	     001A1h
M007_L_2984:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     5ADh
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],32h
   	     jne     short M007_L_299F
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     001B9h
   	     db	     0E9h
   	     dw	     00186h
M007_L_299F:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Dh
   	     jne     short M007_L_29BE
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FF99h
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FF8Eh
   	     db	     0E9h
   	     dw	     00167h
M007_L_29BE:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],35h
   	     jne     short M007_L_2A31
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX+2],0Dh
   	     jne     short M007_L_2A31
   	     mov     SI,word ptr ES:[SI+0Ah]
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     8104h
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_06
   	     dw	     seg X059_06
   	     mov     byte ptr [BP-1],AL
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AL,byte ptr [BP-1]
   	     cbw
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     db	     0E9h
   	     dw	     000F4h
M007_L_2A31:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],35h
   	     jne     short M007_L_2A92
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX+2],0Eh
   	     jne     short M007_L_2A92
   	     push    word ptr ES:[SI+0Ah]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,0Ah
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-6],AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     db	     0E9h
   	     dw	     00093h
M007_L_2A92:
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-4]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     jmp     short M007_L_2B25
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     jmp     short M007_L_2B25
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     AX,93h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     jmp     short M007_L_2B25
   	     push    SI
   	     db	     09Ah
   	     dw	     X062_09
   	     dw	     seg X062_09
   	     jmp     short M007_L_2B25
   	     push    SI
   	     db	     09Ah
   	     dw	     X059_09
   	     dw	     seg X059_09
   	     or	     AX,AX
   	     je	     short M007_L_2B25
   	     db	     0E9h
   	     dw	     0FE4Eh
M007_L_2B25:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV16D	     endp
CO075_TEXT	     ends

; END STAOV16D
; BEGIN STOVT19B (listing ovr_1dd7_b258:2B2D)
CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT

STOVT19B	     label   word
   	     dw	     0056Ch
   	     dw	     0056Ch
   	     dw	     00548h
   	     dw	     00548h
   	     dw	     00548h
   	     dw	     00548h
   	     dw	     0043Eh
   	     dw	     0043Eh
   	     dw	     00590h
   	     dw	     00590h
   	     dw	     00590h
   	     dw	     005A5h
   	     dw	     00548h
   	     dw	     00548h
   	     dw	     0040Bh
   	     dw	     0040Bh
   	     dw	     005A5h
   	     dw	     005A5h
   	     dw	     00598h
   	     dw	     00598h

CO075_TEXT	     ends
; END STOVT19B
; BEGIN STAOV16E (listing ovr_1dd7_b258:2B55)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X058_04:far


CO075_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO075_TEXT,ds:DGROUP

M009_BCC_DATA_8186	     equ     8186h

BCC_NEAR_2B55   label   near
STAOV16E	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],1
   	     jne     short M009_L_2B89
   	     mov     AX,0Ch
   	     push    AX
   	     push    word ptr ES:[SI+0Ah]
   	     xor     AX,AX
   	     push    AX
   	     mov     AL,byte ptr ES:[SI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
   	     mov     DI,AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    DI
   	     jmp     short M009_L_2BE2
M009_L_2B89:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],7
   	     jne     short M009_L_2BC7
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,0Fh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,0Eh
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     jmp     short M009_L_2C04
M009_L_2BC7:
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,0Fh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    AX
M009_L_2BE2:
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,0Dh
   	     push    AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     push    word ptr ES:[SI+0Ch]
   	     mov     AL,byte ptr ES:[SI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
M009_L_2C04:
   	     mov     DI,AX
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    DI
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV16E	     endp
CO075_TEXT	     ends

; END STAOV16E
   	     end
