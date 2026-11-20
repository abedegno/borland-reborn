; Recovered FBOV far-pointer references
CO00F_TEXT	     segment byte public 'CODE'
CO00F_TEXT	     ends
   	     public  X06B_01
   	     public  X06B_00
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1db3_ae8f
; BEGIN STAOV12F (listing ovr_1db3_ae8f:E8F0)

   	     extrn   X019_06:far
   	     extrn   X021_00:far
   	     extrn   X021_05:far
   	     extrn   X06C_03:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M000_BCC_EXPR_SEGMENT   equ     639Ah
M000_BCC_DATA_6438	     equ     6438h

BCC_NEAR_E8F0   label   near
STAOV12F	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
   	     mov     AL,byte ptr ES:[SI+2]
   	     mov     AH,0
   	     test    AX,4
   	     jne     short M000_L_E90A
   	     jmp     short M000_L_E982
M000_L_E90A:
   	     mov     ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[SI],11h
   	     jne     short M000_L_E957
   	     jmp     short M000_L_E91E
M000_L_E916:
   	     mov     ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
   	     mov     SI,word ptr ES:[SI+7]
M000_L_E91E:
   	     mov     ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[SI],11h
   	     je	     short M000_L_E916
   	     push    SI
   	     mov     AL,1
   	     push    AX
   	     db	     0FFh,05Eh,4
   	     mov     DI,AX
   	     or	     DI,DI
   	     jne     short M000_L_E953
   	     mov     AX,0CCh
   	     push    AX
   	     push    word ptr [BP+8]
   	     mov     AX,1
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X021_00
   	     dw	     seg X021_00
M000_L_E946:
   	     push    DX
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X019_06
   	     dw	     seg X019_06
M000_L_E953:
   	     mov     AL,0
   	     jmp     short M000_L_E984
M000_L_E957:
   	     push    SI
   	     mov     AL,0
   	     push    AX
   	     db	     0FFh,05Eh,4
   	     mov     DI,AX
   	     or	     DI,DI
   	     jne     short M000_L_E966
   	     jmp     short M000_L_E982
M000_L_E966:
   	     push    DI
   	     push    word ptr DGROUP:M000_BCC_DATA_6438
   	     db	     09Ah
   	     dw	     X06C_03
   	     dw	     seg X06C_03
   	     mov     AH,0
   	     or	     AX,AX
   	     jne     short M000_L_E982
   	     mov     AX,0B6h
   	     push    AX
   	     push    DI
   	     db	     09Ah
   	     dw	     X021_05
   	     dw	     seg X021_05
   	     jmp     short M000_L_E946
M000_L_E982:
   	     mov     AL,1
M000_L_E984:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     8
STAOV12F	     endp
CO06B_TEXT	     ends

; END STAOV12F
; BEGIN STAOV130 (listing ovr_1db3_ae8f:E98B)



CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M001_BCC_DATA_5F3E	     equ     5F3Eh
M001_BCC_EXPR_SEGMENT   equ     639Ah
M001_BCC_DATA_6408	     equ     6408h
M001_BCC_DATA_78A4	     equ     78A4h

BCC_NEAR_E98B   label   near
STAOV130	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     byte ptr [BP-1],1
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_5F3E
   	     mov     DI,word ptr ES:[BX+0Ch]
   	     jmp     short M001_L_E9D2
M001_L_E9AC:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_6408
   	     push    word ptr ES:[DI+2]
   	     mov     AX,5
   	     push    AX
   	     mov     AX,seg CO00F_TEXT
   	     push    AX
   	     mov     AX,3Eh
   	     push    AX
   	     db	     0E8h
   	     dw	     0FF2Dh
   	     mov     DL,byte ptr [BP-1]
   	     and     DL,AL
   	     mov     byte ptr [BP-1],DL
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_6408
   	     mov     DI,word ptr ES:[DI]
M001_L_E9D2:
   	     or	     DI,DI
   	     jne     short M001_L_E9AC
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_5F3E
   	     mov     SI,word ptr ES:[BX+2]
   	     jmp     short M001_L_EA18
M001_L_E9EB:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_78A4
   	     test    byte ptr ES:[SI+4],3
   	     jne     short M001_L_EA11
   	     push    word ptr ES:[SI+8]
   	     mov     AX,5
   	     push    AX
   	     mov     AX,seg CO00F_TEXT
   	     push    AX
   	     mov     AX,3Eh
   	     push    AX
   	     db	     0E8h
   	     dw	     0FEE7h
   	     mov     DL,byte ptr [BP-1]
   	     and     DL,AL
   	     mov     byte ptr [BP-1],DL
M001_L_EA11:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_78A4
   	     mov     SI,word ptr ES:[SI]
M001_L_EA18:
   	     or	     SI,SI
   	     jne     short M001_L_E9EB
   	     mov     AL,byte ptr [BP-1]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV130	     endp
CO06B_TEXT	     ends

; END STAOV130
; BEGIN STAOV131 (listing ovr_1db3_ae8f:EA28)



CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M002_BCC_DATA_5F3E	     equ     5F3Eh
M002_BCC_EXPR_SEGMENT   equ     639Ah
M002_BCC_DATA_6408	     equ     6408h
M002_BCC_DATA_78A4	     equ     78A4h

BCC_NEAR_EA28   label   near
STAOV131	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     byte ptr [BP-1],1
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_5F3E
   	     mov     DI,word ptr ES:[BX+0Ch]
   	     jmp     short M002_L_EA6F
M002_L_EA49:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_6408
   	     push    word ptr ES:[DI+2]
   	     mov     AX,0Bh
   	     push    AX
   	     mov     AX,seg CO00F_TEXT
   	     push    AX
   	     mov     AX,70h
   	     push    AX
   	     db	     0E8h
   	     dw	     0FE90h
   	     mov     DL,byte ptr [BP-1]
   	     and     DL,AL
   	     mov     byte ptr [BP-1],DL
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_6408
   	     mov     DI,word ptr ES:[DI]
M002_L_EA6F:
   	     or	     DI,DI
   	     jne     short M002_L_EA49
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_5F3E
   	     mov     SI,word ptr ES:[BX+2]
   	     jmp     short M002_L_EAB5
M002_L_EA88:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_78A4
   	     test    byte ptr ES:[SI+4],3
   	     jne     short M002_L_EAAE
   	     push    word ptr ES:[SI+8]
   	     mov     AX,0Bh
   	     push    AX
   	     mov     AX,seg CO00F_TEXT
   	     push    AX
   	     mov     AX,70h
   	     push    AX
   	     db	     0E8h
   	     dw	     0FE4Ah
   	     mov     DL,byte ptr [BP-1]
   	     and     DL,AL
   	     mov     byte ptr [BP-1],DL
M002_L_EAAE:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_78A4
   	     mov     SI,word ptr ES:[SI]
M002_L_EAB5:
   	     or	     SI,SI
   	     jne     short M002_L_EA88
   	     mov     AL,byte ptr [BP-1]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV131	     endp
CO06B_TEXT	     ends

; END STAOV131
; BEGIN STAOV12B (listing ovr_1db3_ae8f:EAC5)


   	     extrn   X023_13:far
   	     extrn   X023_17:far
   	     extrn   X023_1F:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

BCC_NEAR_EAC5   label   near
STAOV12B	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,2Fh
   	     push    AX
   	     push    word ptr [BP+4]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X023_13
   	     dw	     seg X023_13
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_1F
   	     dw	     seg X023_1F
   	     pop     BP
   	     dec     BP
   	     ret     4
STAOV12B	     endp
CO06B_TEXT	     ends

; END STAOV12B
; BEGIN STAOV12C (listing ovr_1db3_ae8f:EAE9)

   	     extrn   BCC_FAR_03A9:far
   	     extrn   X00A_03:far
   	     extrn   X00F_09:far
   	     extrn   X021_00:far
   	     extrn   X023_03:far
   	     extrn   X023_06:far
   	     extrn   X023_14:far
   	     extrn   X023_16:far
   	     extrn   X023_17:far
   	     extrn   X023_21:far
   	     extrn   X02C_21:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M004_BCC_DATA_5EC4	     equ     5EC4h
M004_BCC_DATA_5EC8	     equ     5EC8h
M004_BCC_DATA_5F3C	     equ     5F3Ch
M004_BCC_DATA_5F3E	     equ     5F3Eh
M004_BCC_DATA_618C	     equ     618Ch
M004_BCC_DATA_6298	     equ     6298h
M004_BCC_EXPR_SEGMENT   equ     639Ah
M004_BCC_DATA_6410	     equ     6410h
M004_BCC_DATA_6428	     equ     6428h
M004_BCC_DATA_6498	     equ     6498h
M004_BCC_DATA_78A4	     equ     78A4h

   	     public  X06B_01
X06B_01 label   far
STAOV12C	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     word ptr [BP-2],0
   	     mov     word ptr [BP-4],1
   	     jmp     short M004_L_EB25
M004_L_EB00:
   	     mov     ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
   	     mov     CX,word ptr ES:[SI+0Bh]
   	     mov     BX,word ptr ES:[SI+9]
   	     mov     DX,word ptr [BP-2]
   	     mov     AX,word ptr [BP-4]
   	     db	     09Ah
   	     dw	     BCC_FAR_03A9
   	     dw	     seg BCC_FAR_03A9
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
   	     mov     SI,word ptr ES:[SI+7]
M004_L_EB25:
   	     mov     ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[SI],11h
   	     je	     short M004_L_EB00
   	     mov     BX,word ptr ES:[SI+5]
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_5F3E
   	     test    word ptr ES:[BX+18h],4
   	     je	     short M004_L_EB44
   	     mov     AX,1
   	     jmp     short M004_L_EB46
M004_L_EB44:
   	     xor     AX,AX
M004_L_EB46:
   	     mov     byte ptr [BP-7],AL
   	     push    word ptr DGROUP:M004_BCC_DATA_618C
   	     push    SI
   	     db	     09Ah
   	     dw	     X02C_21
   	     dw	     seg X02C_21
   	     mov     word ptr [BP-6],AX
   	     cmp     word ptr [BP-6],0
   	     jne     short M004_L_EB60
   	     xor     AX,AX
   	     jmp     short M004_L_EB6B
M004_L_EB60:
   	     mov     BX,word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_78A4
   	     mov     AX,word ptr ES:[BX+6]
M004_L_EB6B:
   	     mov     DI,AX
   	     jmp     short M004_L_EBAA
M004_L_EB6F:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_6410
   	     mov     BX,word ptr ES:[DI+4]
   	     mov     ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+9]
   	     mov     word ptr [BP-0Ah],AX
   	     cmp     byte ptr [BP-7],0
   	     je	     short M004_L_EB95
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_6428
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [BP-0Ah],AX
M004_L_EB95:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_6428
   	     mov     BX,word ptr [BP-0Ah]
   	     cmp     word ptr ES:[BX],0
   	     je	     short M004_L_EBAE
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_6410
   	     mov     DI,word ptr ES:[DI+13h]
M004_L_EBAA:
   	     or	     DI,DI
   	     jne     short M004_L_EB6F
M004_L_EBAE:
   	     or	     DI,DI
   	     jne     short M004_L_EBD3
   	     mov     AX,0E1h
   	     push    AX
   	     mov     AX,5
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X021_00
   	     dw	     seg X021_00
   	     push    DX
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_06
   	     dw	     seg X023_06
   	     jmp     short M004_L_EC4B
M004_L_EBD3:
   	     cmp     byte ptr [BP-7],0
   	     je	     short M004_L_EBDE
   	     mov     AX,DGROUP:M004_BCC_DATA_5F3C
   	     jmp     short M004_L_EBE1
M004_L_EBDE:
   	     mov     AX,DGROUP:M004_BCC_DATA_5EC4
M004_L_EBE1:
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     push    word ptr DGROUP:M004_BCC_DATA_6298
   	     mov     AX,1Dh
   	     push    AX
   	     push    word ptr [BP+8]
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_14
   	     dw	     seg X023_14
   	     push    AX
   	     push    word ptr DGROUP:M004_BCC_DATA_6498
   	     push    SI
   	     db	     09Ah
   	     dw	     X00A_03
   	     dw	     seg X00A_03
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     push    word ptr DGROUP:M004_BCC_DATA_5EC8
   	     push    word ptr [BP-2]
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     push    word ptr DGROUP:M004_BCC_DATA_5EC8
   	     push    SI
   	     push    DI
   	     db	     09Ah
   	     dw	     X00F_09
   	     dw	     seg X00F_09
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     mov     AX,1Dh
   	     push    AX
   	     push    DI
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_16
   	     dw	     seg X023_16
M004_L_EC4B:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV12C	     endp
CO06B_TEXT	     ends

; END STAOV12C
; BEGIN STAOV12D (listing ovr_1db3_ae8f:EC53)

   	     extrn   BCC_FAR_03A9:far
   	     extrn   X00A_00:far
   	     extrn   X00A_03:far
   	     extrn   X00F_09:far
   	     extrn   X021_00:far
   	     extrn   X023_03:far
   	     extrn   X023_06:far
   	     extrn   X023_14:far
   	     extrn   X023_16:far
   	     extrn   X023_17:far
   	     extrn   X023_1E:far
   	     extrn   X023_21:far
   	     extrn   X02C_21:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M005_BCC_DATA_5EC8	     equ     5EC8h
M005_BCC_DATA_5F3E	     equ     5F3Eh
M005_BCC_DATA_6162	     equ     6162h
M005_BCC_DATA_617E	     equ     617Eh
M005_BCC_DATA_6298	     equ     6298h
M005_BCC_EXPR_SEGMENT   equ     639Ah
M005_BCC_DATA_6410	     equ     6410h
M005_BCC_DATA_6428	     equ     6428h
M005_BCC_DATA_6498	     equ     6498h
M005_BCC_DATA_78A4	     equ     78A4h
M005_BCC_DATA_8186	     equ     8186h

BCC_NEAR_EC53   label   near
STAOV12D	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,10h
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     word ptr [BP-2],0
   	     mov     word ptr [BP-4],1
   	     jmp     short M005_L_EC90
M005_L_EC6B:
   	     mov     ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
   	     mov     CX,word ptr ES:[SI+0Bh]
   	     mov     BX,word ptr ES:[SI+9]
   	     mov     DX,word ptr [BP-2]
   	     mov     AX,word ptr [BP-4]
   	     db	     09Ah
   	     dw	     BCC_FAR_03A9
   	     dw	     seg BCC_FAR_03A9
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
   	     mov     SI,word ptr ES:[SI+7]
M005_L_EC90:
   	     mov     ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[SI],11h
   	     je	     short M005_L_EC6B
   	     mov     BX,word ptr ES:[SI+5]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_5F3E
   	     test    word ptr ES:[BX+18h],4
   	     je	     short M005_L_ECB5
   	     cmp     word ptr [BP+0Ah],5
   	     jne     short M005_L_ECB5
   	     mov     AX,1
   	     jmp     short M005_L_ECB7
M005_L_ECB5:
   	     xor     AX,AX
M005_L_ECB7:
   	     mov     byte ptr [BP-5],AL
   	     mov     BX,word ptr [BP+0Ah]
   	     shl     BX,1
   	     push    word ptr [BX+6182h]
   	     push    SI
   	     db	     09Ah
   	     dw	     X02C_21
   	     dw	     seg X02C_21
   	     mov     word ptr [BP-0Ah],AX
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_78A4
   	     mov     DI,word ptr ES:[BX+6]
   	     db	     0E9h
   	     dw	     00086h
M005_L_ECDA:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_6410
   	     mov     AX,word ptr ES:[DI+4]
   	     mov     word ptr [BP-8],AX
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+9]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_6428
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [BP-10h],AX
   	     cmp     byte ptr [BP-5],0
   	     je	     short M005_L_ED09
   	     mov     BX,word ptr [BP-10h]
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [BP-10h],AX
M005_L_ED09:
   	     mov     BX,word ptr [BP-10h]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_6428
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-0Ch],AX
   	     mov     ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr [BP-0Ch]
   	     mov     BX,word ptr ES:[BX]
   	     test    byte ptr [BX+9CAh],14h
   	     je	     short M005_L_ED58
   	     mov     BX,word ptr [BP-0Ch]
   	     test    byte ptr ES:[BX+2],20h
   	     je	     short M005_L_ED58
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_6428
   	     mov     BX,word ptr [BP-10h]
   	     cmp     word ptr ES:[BX],0
   	     jne     short M005_L_ED58
   	     mov     BX,word ptr [BP-0Ch]
   	     mov     ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+7]
   	     push    SI
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X00A_00
   	     dw	     seg X00A_00
   	     or	     AL,AL
   	     jne     short M005_L_ED67
M005_L_ED58:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_6410
   	     mov     DI,word ptr ES:[DI+13h]
M005_L_ED60:
   	     or	     DI,DI
   	     je	     short M005_L_ED67
   	     db	     0E9h
   	     dw	     0FF73h
M005_L_ED67:
   	     or	     DI,DI
   	     jne     short M005_L_ED8D
   	     mov     AX,0CCh
   	     push    AX
   	     push    word ptr [BP+0Ah]
   	     mov     AX,1
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X021_00
   	     dw	     seg X021_00
   	     push    DX
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_06
   	     dw	     seg X023_06
   	     db	     0E9h
   	     dw	     000B0h
M005_L_ED8D:
   	     push    word ptr DGROUP:M005_BCC_DATA_6298
   	     mov     AX,1Dh
   	     push    AX
   	     push    word ptr [BP+8]
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_14
   	     dw	     seg X023_14
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_6298
   	     mov     AX,1Dh
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_14
   	     dw	     seg X023_14
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_6498
   	     push    SI
   	     db	     09Ah
   	     dw	     X00A_03
   	     dw	     seg X00A_03
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_5EC8
   	     push    word ptr [BP-2]
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_5EC8
   	     push    SI
   	     push    DI
   	     db	     09Ah
   	     dw	     X00F_09
   	     dw	     seg X00F_09
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     mov     AX,1Dh
   	     push    AX
   	     push    DI
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_16
   	     dw	     seg X023_16
   	     mov     word ptr [BP-0Eh],AX
   	     cmp     byte ptr [BP-5],0
   	     je	     short M005_L_EE15
   	     mov     AX,DGROUP:M005_BCC_DATA_617E
   	     jmp     short M005_L_EE18
M005_L_EE15:
   	     mov     AX,DGROUP:M005_BCC_DATA_6162
M005_L_EE18:
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     BX,word ptr [BP-0Eh]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     push    word ptr ES:[BX+0Ch]
   	     db	     09Ah
   	     dw	     X023_1E
   	     dw	     seg X023_1E
   	     mov     BX,word ptr [BP-0Eh]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     word ptr ES:[BX+0Ch],AX
   	     mov     AX,word ptr [BP-0Eh]
M005_L_EE3D:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     8
STAOV12D	     endp
CO06B_TEXT	     ends

; END STAOV12D
; BEGIN STAOV12E (listing ovr_1db3_ae8f:EE46)

   	     extrn   X00F_01:far
   	     extrn   X00F_18:far
   	     extrn   X00F_1E:far
   	     extrn   X023_01:far
   	     extrn   X023_03:far
   	     extrn   X023_17:far
   	     extrn   X023_1E:far
   	     extrn   X023_1F:far
   	     extrn   X02C_13:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M006_BCC_DATA_5F3E	     equ     5F3Eh
M006_BCC_DATA_6398	     equ     6398h
M006_BCC_EXPR_SEGMENT   equ     639Ah
M006_BCC_DATA_6408	     equ     6408h
M006_BCC_DATA_6428	     equ     6428h
M006_BCC_DATA_782A	     equ     782Ah
M006_BCC_DATA_78A4	     equ     78A4h

BCC_NEAR_EE46   label   near
STAOV12E	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,10h
   	     push    SI
   	     push    DI
   	     mov     byte ptr [BP-0Fh],0A0h
   	     mov     BX,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+9]
   	     mov     word ptr [BP-0Eh],AX
   	     mov     BX,word ptr [BP-0Eh]
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6428
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M006_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6428
   	     mov     BX,word ptr [BP-0Eh]
   	     mov     BX,word ptr ES:[BX]
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M006_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-2],AX
   	     mov     word ptr [BP-6],0
   	     mov     word ptr [BP-8],0
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_5F3E
   	     mov     SI,word ptr ES:[BX+0Ch]
   	     db	     0E9h
   	     dw	     000F7h
M006_L_EEC1:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     cmp     byte ptr ES:[SI+7],0
   	     je	     short M006_L_EF23
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     push    word ptr ES:[SI+4]
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X00F_01
   	     dw	     seg X00F_01
   	     mov     word ptr [BP-0Ch],AX
   	     mov     AX,18h
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     mov     word ptr [BP-0Ch],AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     push    word ptr ES:[SI+4]
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X00F_01
   	     dw	     seg X00F_01
   	     mov     word ptr [BP-0Ah],AX
   	     mov     AX,18h
   	     push    AX
   	     push    word ptr [BP-0Ah]
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     jmp     short M006_L_EF5A
M006_L_EF23:
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     push    word ptr ES:[SI+4]
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X00F_1E
   	     dw	     seg X00F_1E
   	     mov     word ptr [BP-0Ch],AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     push    word ptr ES:[SI+4]
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X00F_1E
   	     dw	     seg X00F_1E
M006_L_EF5A:
   	     mov     word ptr [BP-0Ah],AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     test    byte ptr ES:[BX+2],10h
   	     je	     short M006_L_EF96
   	     push    word ptr [BP-8]
   	     mov     AX,0Bh
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Ah]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_1E
   	     dw	     seg X023_1E
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_18
   	     dw	     seg X00F_18
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     word ptr [BP-8],AX
   	     jmp     short M006_L_EFB1
M006_L_EF96:
   	     push    word ptr [BP-6]
   	     mov     AX,0Bh
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Ah]
   	     db	     09Ah
   	     dw	     X023_1F
   	     dw	     seg X023_1F
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     word ptr [BP-6],AX
M006_L_EFB1:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_6408
   	     mov     SI,word ptr ES:[SI]
M006_L_EFB8:
   	     or	     SI,SI
   	     je	     short M006_L_EFBF
   	     db	     0E9h
   	     dw	     0FF02h
M006_L_EFBF:
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_5F3E
   	     mov     DI,word ptr ES:[BX+2]
   	     db	     0E9h
   	     dw	     000F5h
M006_L_EFD5:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_78A4
   	     test    byte ptr ES:[DI+4],3
   	     je	     short M006_L_EFE3
   	     db	     0E9h
   	     dw	     000E0h
M006_L_EFE3:
   	     mov     AL,byte ptr ES:[DI+4]
   	     and     AL,byte ptr [BP-0Fh]
   	     mov     AH,0
   	     or	     AX,AX
   	     je	     short M006_L_EFFF
   	     mov     AL,byte ptr ES:[DI+4]
   	     and     AL,byte ptr [BP-0Fh]
   	     cmp     AL,byte ptr [BP-0Fh]
   	     je	     short M006_L_EFFF
   	     db	     0E9h
   	     dw	     000C4h
M006_L_EFFF:
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     0FABFh
   	     mov     word ptr [BP-0Ch],AX
   	     push    DI
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0FAB5h
   	     mov     word ptr [BP-0Ah],AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_78A4
   	     mov     BX,word ptr ES:[DI+8]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[BX],11h
   	     jne     short M006_L_F078
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_78A4
   	     mov     BX,word ptr ES:[DI+8]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     test    byte ptr ES:[BX+2],10h
   	     je	     short M006_L_F05B
   	     push    word ptr [BP-8]
   	     mov     AX,0Bh
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Ah]
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_78A4
   	     push    word ptr ES:[DI+8]
   	     db	     0E8h
   	     dw	     0FC03h
M006_L_F050:
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     word ptr [BP-8],AX
   	     jmp     short M006_L_F0C3
M006_L_F05B:
   	     push    word ptr [BP-6]
   	     mov     AX,5
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Ah]
   	     db	     09Ah
   	     dw	     X023_1F
   	     dw	     seg X023_1F
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     word ptr [BP-6],AX
   	     jmp     short M006_L_F0C3
M006_L_F078:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_78A4
   	     mov     BX,word ptr ES:[DI+8]
   	     mov     ES,word ptr DGROUP:M006_BCC_EXPR_SEGMENT
   	     test    byte ptr ES:[BX+2],10h
   	     je	     short M006_L_F0A8
   	     push    word ptr [BP-8]
   	     mov     AX,0Bh
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Ah]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_1E
   	     dw	     seg X023_1E
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_18
   	     dw	     seg X00F_18
   	     jmp     short M006_L_F050
M006_L_F0A8:
   	     push    word ptr [BP-6]
   	     mov     AX,0Bh
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Ah]
   	     db	     09Ah
   	     dw	     X023_1F
   	     dw	     seg X023_1F
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     word ptr [BP-6],AX
M006_L_F0C3:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_78A4
   	     mov     DI,word ptr ES:[DI]
M006_L_F0CA:
   	     or	     DI,DI
   	     je	     short M006_L_F0D1
   	     db	     0E9h
   	     dw	     0FF04h
M006_L_F0D1:
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-8]
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     push    AX
   	     mov     AX,1Dh
   	     push    AX
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV12E	     endp
CO06B_TEXT	     ends

; END STAOV12E
; BEGIN STAOV132 (listing ovr_1db3_ae8f:F0FD)

   	     extrn   X00F_07:far
   	     extrn   X00F_1E:far
   	     extrn   X00F_20:far
   	     extrn   X00F_29:far
   	     extrn   X023_01:far
   	     extrn   X023_03:far
   	     extrn   X023_17:far
   	     extrn   X023_1E:far
   	     extrn   X02C_13:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M007_BCC_DATA_5F3E	     equ     5F3Eh
M007_BCC_DATA_6398	     equ     6398h
M007_BCC_EXPR_SEGMENT   equ     639Ah
M007_BCC_DATA_6408	     equ     6408h
M007_BCC_DATA_6428	     equ     6428h
M007_BCC_DATA_782A	     equ     782Ah
M007_BCC_DATA_78A4	     equ     78A4h

BCC_NEAR_F0FD   label   near
STAOV132	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,12h
   	     push    SI
   	     push    DI
   	     mov     BX,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+9]
   	     mov     word ptr [BP-12h],AX
   	     mov     BX,word ptr [BP-12h]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6428
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M007_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-6],AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6428
   	     mov     BX,word ptr [BP-12h]
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [BP-12h],AX
   	     mov     BX,word ptr [BP-12h]
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M007_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_5F3E
   	     test    word ptr ES:[BX+18h],4
   	     je	     short M007_L_F198
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6428
   	     mov     BX,word ptr [BP-12h]
   	     mov     BX,word ptr ES:[BX]
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M007_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-2],AX
   	     jmp     short M007_L_F19D
M007_L_F198:
   	     mov     word ptr [BP-4],0
M007_L_F19D:
   	     push    word ptr [BP-4]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_07
   	     dw	     seg X00F_07
   	     mov     DI,AX
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_5F3E
   	     mov     SI,word ptr ES:[BX+0Ch]
   	     db	     0E9h
   	     dw	     0009Bh
M007_L_F1C0:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6408
   	     mov     AL,byte ptr ES:[SI+7]
   	     mov     AH,0
   	     or	     AX,AX
   	     je	     short M007_L_F1D1
   	     db	     0E9h
   	     dw	     00083h
M007_L_F1D1:
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
   	     test    byte ptr ES:[BX+2],4
   	     je	     short M007_L_F1EA
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     jmp     short M007_L_F204
M007_L_F1EA:
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6408
   	     push    word ptr ES:[SI+4]
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X00F_1E
   	     dw	     seg X00F_1E
M007_L_F204:
   	     mov     word ptr [BP-10h],AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6408
   	     push    word ptr ES:[SI+4]
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X00F_1E
   	     dw	     seg X00F_1E
   	     mov     word ptr [BP-0Eh],AX
   	     push    word ptr [BP-10h]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6408
   	     push    word ptr ES:[SI+2]
   	     push    word ptr [BP-0Eh]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_1E
   	     dw	     seg X023_1E
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AL,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_20
   	     dw	     seg X00F_20
   	     mov     word ptr [BP-8],AX
   	     push    DI
   	     push    word ptr [BP-8]
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     DI,AX
M007_L_F254:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_6408
   	     mov     SI,word ptr ES:[SI]
M007_L_F25B:
   	     or	     SI,SI
   	     je	     short M007_L_F262
   	     db	     0E9h
   	     dw	     0FF5Eh
M007_L_F262:
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_5F3E
   	     mov     AX,word ptr ES:[BX+2]
   	     db	     0E9h
   	     dw	     00094h
M007_L_F278:
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_78A4
   	     test    byte ptr ES:[BX+4],3
   	     jne     short M007_L_F302
   	     mov     AL,byte ptr ES:[BX+4]
   	     mov     AH,0
   	     test    AX,0A0h
   	     jne     short M007_L_F302
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-6]
   	     db	     0E8h
   	     dw	     0F82Bh
   	     mov     word ptr [BP-10h],AX
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0F81Fh
   	     mov     word ptr [BP-0Eh],AX
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_78A4
   	     mov     AX,word ptr ES:[BX+8]
   	     mov     word ptr [BP-0Ch],AX
   	     mov     BX,word ptr [BP-0Ch]
   	     mov     ES,word ptr DGROUP:M007_BCC_EXPR_SEGMENT
   	     test    byte ptr ES:[BX+2],4
   	     je	     short M007_L_F2DE
   	     cmp     word ptr ES:[BX],11h
   	     jne     short M007_L_F2DE
   	     push    DI
   	     mov     AX,5
   	     push    AX
   	     push    word ptr [BP-10h]
   	     push    word ptr [BP-0Eh]
   	     push    word ptr [BP-0Ch]
   	     db	     0E8h
   	     dw	     0F977h
   	     jmp     short M007_L_F2FA
M007_L_F2DE:
   	     push    DI
   	     push    word ptr [BP-10h]
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-0Eh]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_1E
   	     dw	     seg X023_1E
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_20
   	     dw	     seg X00F_20
M007_L_F2FA:
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     DI,AX
M007_L_F302:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_78A4
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr ES:[BX]
M007_L_F30C:
   	     mov     word ptr [BP-0Ah],AX
   	     cmp     word ptr [BP-0Ah],0
   	     je	     short M007_L_F318
   	     db	     0E9h
   	     dw	     0FF60h
M007_L_F318:
   	     push    DI
   	     push    word ptr [BP-6]
   	     push    word ptr [BP+8]
   	     db	     09Ah
   	     dw	     X00F_29
   	     dw	     seg X00F_29
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     DI,AX
   	     push    DI
   	     mov     AX,1Dh
   	     push    AX
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     DI,AX
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV132	     endp
CO06B_TEXT	     ends

; END STAOV132
; BEGIN STAOV133 (listing ovr_1db3_ae8f:F34F)

   	     extrn   X04F_0F:far
   	     extrn   X00F_07:far
   	     extrn   X00F_21:far
   	     extrn   X00F_29:far
   	     extrn   X023_01:far
   	     extrn   X023_03:far
   	     extrn   X023_05:far
   	     extrn   X023_17:far
   	     extrn   X023_21:far
   	     extrn   X02C_13:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M008_BCC_DATA_5EC8	     equ     5EC8h
M008_BCC_DATA_5F3E	     equ     5F3Eh
M008_BCC_DATA_6398	     equ     6398h
M008_BCC_EXPR_SEGMENT   equ     639Ah
M008_BCC_DATA_6428	     equ     6428h
M008_BCC_DATA_782A	     equ     782Ah

BCC_NEAR_F34F   label   near
STAOV133	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     BX,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
   	     mov     DI,word ptr ES:[BX+9]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_6428
   	     push    word ptr ES:[DI+4]
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+5]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_5F3E
   	     test    word ptr ES:[BX+18h],4
   	     je	     short M008_L_F3B6
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_6428
   	     mov     BX,word ptr ES:[DI]
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-4],AX
   	     jmp     short M008_L_F3BB
M008_L_F3B6:
   	     mov     word ptr [BP-4],0
M008_L_F3BB:
   	     push    word ptr [BP-4]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_07
   	     dw	     seg X00F_07
   	     mov     SI,AX
   	     or	     SI,SI
   	     je	     short M008_L_F3F1
   	     mov     AX,6Bh
   	     push    AX
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     push    word ptr DGROUP:M008_BCC_DATA_5EC8
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X023_21
   	     dw	     seg X023_21
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X023_05
   	     dw	     seg X023_05
   	     mov     SI,AX
M008_L_F3F1:
   	     push    SI
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     02Fh
   	     dw	     seg CO00F_TEXT
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     SI,AX
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X00F_21
   	     dw	     seg X00F_21
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     SI,AX
   	     push    SI
   	     push    word ptr [BP-2]
   	     push    word ptr [BP+8]
   	     db	     09Ah
   	     dw	     X00F_29
   	     dw	     seg X00F_29
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     SI,AX
   	     push    SI
   	     mov     AX,1Dh
   	     push    AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X023_17
   	     dw	     seg X023_17
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_03
   	     dw	     seg X023_03
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_01
   	     dw	     seg X023_01
   	     mov     SI,AX
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV133	     endp
CO06B_TEXT	     ends

; END STAOV133
; BEGIN STAOV134 (listing ovr_1db3_ae8f:F44D)

   	     extrn   X00F_04:far
   	     extrn   X02C_13:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M009_BCC_DATA_6398	     equ     6398h
M009_BCC_EXPR_SEGMENT   equ     639Ah
M009_BCC_DATA_6428	     equ     6428h
M009_BCC_DATA_782A	     equ     782Ah

BCC_NEAR_F44D   label   near
STAOV134	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     mov     BX,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M009_BCC_EXPR_SEGMENT
   	     mov     SI,word ptr ES:[BX+9]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_6428
   	     push    word ptr ES:[SI+4]
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_6428
   	     mov     BX,word ptr ES:[SI]
   	     push    word ptr ES:[BX+4]
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_6398
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_782A
   	     push    word ptr ES:[BX+4]
   	     db	     09Ah
   	     dw	     X02C_13
   	     dw	     seg X02C_13
   	     mov     word ptr [BP-4],AX
   	     push    word ptr [BP+8]
   	     push    word ptr [BP-2]
   	     mov     AL,1
   	     push    AX
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X00F_04
   	     dw	     seg X00F_04
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV134	     endp
CO06B_TEXT	     ends

; END STAOV134
; BEGIN STAOV135 (listing ovr_1db3_ae8f:F4B2)

   	     extrn   X023_23:far


CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT,ds:DGROUP

M00A_BCC_DATA_6410	     equ     6410h

   	     public  X06B_00
X06B_00 label   far
STAOV135	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_6410
   	     mov     BX,word ptr ES:[SI]
   	     mov     DI,word ptr ES:[BX+4]
   	     mov     BX,word ptr ES:[SI+0Dh]
   	     cmp     BX,3
   	     ja	     short M00A_L_F530
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0C48h
   	     push    DI
   	     db	     0E8h
   	     dw	     0F54Fh
   	     or	     AL,AL
   	     je	     short M00A_L_F4EC
   	     push    DI
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_6410
   	     push    word ptr ES:[SI+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F95Ch
   	     jmp     short M00A_L_F50C
M00A_L_F4EC:
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X023_23
   	     dw	     seg X023_23
M00A_L_F4F5:
   	     jmp     short M00A_L_F532
   	     push    DI
   	     db	     0E8h
   	     dw	     0F490h
   	     or	     AL,AL
   	     je	     short M00A_L_F50E
   	     push    DI
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_6410
   	     push    word ptr ES:[SI+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBF1h
M00A_L_F50C:
   	     jmp     short M00A_L_F4F5
M00A_L_F50E:
   	     jmp     short M00A_L_F4EC
   	     jmp     short M00A_L_F4F5
   	     push    DI
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_6410
   	     push    word ptr ES:[SI+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE30h
   	     jmp     short M00A_L_F52E
   	     push    DI
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_6410
   	     push    word ptr ES:[SI+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF1Fh
M00A_L_F52E:
   	     jmp     short M00A_L_F532
M00A_L_F530:
   	     xor     AX,AX
M00A_L_F532:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV135	     endp
CO06B_TEXT	     ends

; END STAOV135
; BEGIN LG0C7 (gap	ovr_1db3_ae8f:F538)
CO06B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06B_TEXT
; Original-image layout stub: not recovered source


   	     db	     0E5h,00Bh,007h,00Ch,022h,00Ch,031h,00Ch ; ovr_1db3_ae8f:F538


CO06B_TEXT	     ends
; END LG0C7
   	     end
