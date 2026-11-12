   	     public  X06D_02
   	     public  X06D_00
   	     public  X06D_01
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1dbb_afa6
; BEGIN STAOV13F (listing ovr_1dbb_afa6:FA60)

   	     extrn   X055_0A:far
   	     extrn   X05D_0A:far
   	     extrn   X076_05:far


CO06D_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06D_TEXT,ds:DGROUP

M000_BCC_DATA_5924	     equ     5924h

   	     public  X06D_00
X06D_00 label   far
STAOV13F	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     AX,DGROUP:M000_BCC_DATA_5924
   	     mov     word ptr [BP-2],AX
   	     db	     09Ah
   	     dw	     X055_0A
   	     dw	     seg X055_0A
   	     inc     AX
   	     mov     SI,AX
   	     cmp     byte ptr [SI],0E6h
   	     je	     short M000_L_FA80
   	     mov     word ptr DGROUP:M000_BCC_DATA_5924,0FFFFh
M000_L_FA80:
   	     push    DS
   	     mov     AX,381Ah
M000_L_FA84:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     xor     DI,DI
M000_L_FA8C:
   	     mov     AL,byte ptr [SI]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X076_05
   	     dw	     seg X076_05
   	     inc     DI
   	     inc     SI
   	     dec     word ptr [BP+6]
   	     cmp     word ptr [BP+6],1
   	     jle     short M000_L_FAAB
   	     cmp     DI,14h
   	     jl	     short M000_L_FA8C
   	     push    DS
   	     mov     AX,3825h
   	     jmp     short M000_L_FA84
M000_L_FAAB:
   	     push    DS
   	     mov     AX,3833h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,word ptr [BP-2]
   	     mov     DGROUP:M000_BCC_DATA_5924,AX
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
STAOV13F	     endp
CO06D_TEXT	     ends

; END STAOV13F
; BEGIN STAOV140 (listing ovr_1dbb_afa6:FAC3)

   	     extrn   BCC_FAR_03A9:far
   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X076_06:far
   	     extrn   X077_01:far


CO06D_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06D_TEXT,ds:DGROUP

M001_BCC_DATA_1700	     equ     1700h
M001_BCC_DATA_1716	     equ     1716h
M001_BCC_EXPR_SEGMENT   equ     639Ah
M001_BCC_STMT_RECORD_SEG	     equ     63C2h
M001_BCC_DATA_782A	     equ     782Ah
M001_BCC_DATA_7832	     equ     7832h
M001_BCC_DATA_80C0	     equ     80C0h
M001_BCC_DATA_8160	     equ     8160h
M001_BCC_DATA_8164	     equ     8164h
M001_BCC_DATA_85F4	     equ     85F4h
M001_BCC_DATA_8652	     equ     8652h

   	     public  X06D_02
X06D_02 label   far
STAOV140	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     BX,word ptr DGROUP:M001_BCC_DATA_85F4
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_782A
   	     mov     AX,word ptr ES:[BX+6]
   	     mov     word ptr [BP-8],AX
   	     mov     SI,word ptr [BP-8]
   	     db	     0E9h
   	     dw	     0022Ch
M001_L_FAE0:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],0C0h
   	     jne     short M001_L_FAEF
   	     db	     0E9h
   	     dw	     00216h
M001_L_FAEF:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     AL,byte ptr ES:[SI+5]
   	     mov     AH,0
   	     cmp     AX,1
   	     jne     short M001_L_FB01
   	     db	     0E9h
   	     dw	     000D9h
M001_L_FB01:
   	     cmp     AX,2
   	     je	     short M001_L_FB11
   	     cmp     AX,3
   	     jne     short M001_L_FB0E
   	     db	     0E9h
   	     dw	     00110h
M001_L_FB0E:
   	     db	     0E9h
   	     dw	     00150h
M001_L_FB11:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],800h
   	     je	     short M001_L_FB87
   	     mov     DI,word ptr ES:[SI+8]
   	     mov     word ptr [BP-4],0
   	     mov     word ptr [BP-6],1
   	     jmp     short M001_L_FB52
M001_L_FB2D:
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     mov     CX,word ptr ES:[DI+5]
   	     mov     BX,word ptr ES:[DI+3]
   	     mov     DX,word ptr [BP-4]
   	     mov     AX,word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_03A9
   	     dw	     seg BCC_FAR_03A9
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     mov     DI,word ptr ES:[DI+7]
M001_L_FB52:
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[DI],11h
   	     je	     short M001_L_FB2D
   	     push    SI
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     cmp     AX,word ptr DGROUP:M001_BCC_DATA_8652
   	     je	     short M001_L_FB70
   	     mov     AX,1
   	     jmp     short M001_L_FB72
M001_L_FB70:
   	     xor     AX,AX
M001_L_FB72:
   	     push    AX
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     push    AX
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     X076_06
   	     dw	     seg X076_06
   	     db	     0E9h
   	     dw	     000D0h
M001_L_FB87:
   	     push    DS
   	     mov     AX,3836h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     mov     AX,3Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     8160h
   	     mov     AH,0
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],12h
   	     jne     short M001_L_FBC1
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     cmp     word ptr ES:[SI+0Ch],-1
   	     je	     short M001_L_FBC1
   	     push    DS
   	     mov     AX,383Eh
   	     push    AX
   	     jmp     short M001_L_FBD0
M001_L_FBC1:
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     shl     BX,1
   	     push    word ptr [BX+5924h]
   	     push    word ptr [BX+5922h]
M001_L_FBD0:
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     db	     0E9h
   	     dw	     0007Fh
   	     jmp     short M001_L_FC57
M001_L_FBDA:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX],12h
   	     jne     short M001_L_FC05
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     test    byte ptr ES:[BX+8],80h
   	     je	     short M001_L_FC05
   	     push    DS
   	     mov     AX,3843h
   	     jmp     short M001_L_FC09
M001_L_FC05:
   	     push    DS
   	     mov     AX,384Fh
M001_L_FC09:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     push    DS
   	     mov     AX,3833h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M001_L_FC1E:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     cmp     word ptr ES:[SI+0Ch],0
   	     jne     short M001_L_FC61
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX],12h
   	     je	     short M001_L_FC61
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     push    DS
   	     mov     AX,3858h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+0Eh]
   	     db	     09Ah
   	     dw	     X077_01
   	     dw	     seg X077_01
M001_L_FC57:
   	     push    DS
   	     mov     AX,3833h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M001_L_FC61:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     cmp     byte ptr ES:[SI+5],3
   	     je	     short M001_L_FC6F
   	     db	     0E9h
   	     dw	     00096h
M001_L_FC6F:
   	     cmp     word ptr ES:[SI+0Ch],0
   	     jne     short M001_L_FC79
   	     db	     0E9h
   	     dw	     0008Ch
M001_L_FC79:
   	     test    word ptr ES:[SI+6],400h
   	     je	     short M001_L_FCCE
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_7832
   	     mov     BX,word ptr ES:[BX+4]
   	     mov     AX,word ptr [BX]
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_7832
   	     mov     DX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-0Ah],AX
   	     mov     word ptr [BP-0Ch],DX
   	     jmp     short M001_L_FCBA
M001_L_FCA7:
   	     les     BX,[BP-0Ch]
   	     mov     AL,byte ptr ES:[BX]
   	     cbw
   	     mov     BX,AX
   	     test    byte ptr [BX+5B81h],8
   	     jne     short M001_L_FCC3
   	     inc     word ptr [BP-0Ch]
M001_L_FCBA:
   	     les     BX,[BP-0Ch]
   	     cmp     byte ptr ES:[BX],0
   	     jne     short M001_L_FCA7
M001_L_FCC3:
   	     les     BX,[BP-0Ch]
   	     cmp     byte ptr ES:[BX],0
   	     jne     short M001_L_FCD5
   	     jmp     short M001_L_FD05
M001_L_FCCE:
   	     cmp     byte ptr DGROUP:M001_BCC_DATA_1716,0
   	     je	     short M001_L_FD05
M001_L_FCD5:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     byte ptr ES:[SI+5],1
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     push    DS
   	     mov     AX,3861h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     byte ptr ES:[SI+5],3
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     push    DS
   	     mov     AX,3833h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M001_L_FD05:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     SI,word ptr ES:[SI]
M001_L_FD0C:
   	     or	     SI,SI
   	     je	     short M001_L_FD13
   	     db	     0E9h
   	     dw	     0FDCDh
M001_L_FD13:
   	     cmp     byte ptr DGROUP:M001_BCC_DATA_1700,0
   	     je	     short M001_L_FD20
   	     push    word ptr [BP-8]
   	     db	     0E8h
   	     dw	     00006h
M001_L_FD20:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf
STAOV140	     endp
CO06D_TEXT	     ends

; END STAOV140
; BEGIN STAOV141 (listing ovr_1dbb_afa6:FD26)

   	     extrn   X019_02:far
   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X076_05:far
   	     extrn   X077_04:far


CO06D_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06D_TEXT,ds:DGROUP

M002_BCC_DATA_16EF	     equ     16EFh
M002_BCC_DATA_1716	     equ     1716h
M002_BCC_EXPR_SEGMENT   equ     639Ah
M002_BCC_STMT_RECORD_SEG	     equ     63C2h
M002_BCC_DATA_810C	     equ     810Ch

BCC_NEAR_FD26   label   near
STAOV141	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DS
   	     mov     AX,381Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,0EAh
   	     push    AX
   	     db	     09Ah
   	     dw	     X076_05
   	     dw	     seg X076_05
   	     push    DS
   	     mov     AX,3867h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,DGROUP:M002_BCC_DATA_1716
   	     cbw
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     push    AX
   	     mov     AL,DGROUP:M002_BCC_DATA_16EF
   	     cbw
   	     pop     DX
   	     or	     AX,DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X076_05
   	     dw	     seg X076_05
   	     push    DS
   	     mov     AX,3833h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     db	     0FFh,01Eh
   	     dw	     810Ch
   	     mov     SI,word ptr [BP+4]
   	     db	     0E9h
   	     dw	     000ACh
M002_L_FD76:
   	     mov     ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
   	     cmp     byte ptr ES:[SI+5],3
   	     je	     short M002_L_FD84
   	     db	     0E9h
   	     dw	     00097h
M002_L_FD84:
   	     mov     ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX],12h
   	     je	     short M002_L_FD99
   	     db	     0E9h
   	     dw	     00082h
M002_L_FD99:
   	     mov     byte ptr [BP-1],0
   	     mov     ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],20h
   	     je	     short M002_L_FDC1
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX+7],4
   	     jne     short M002_L_FDBC
   	     mov     AL,98h
   	     jmp     short M002_L_FDBE
M002_L_FDBC:
   	     mov     AL,18h
M002_L_FDBE:
   	     or	     byte ptr [BP-1],AL
M002_L_FDC1:
   	     push    DS
   	     mov     AX,386Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X019_02
   	     dw	     seg X019_02
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,20h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M002_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+1]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     mov     AX,20h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     AL,byte ptr [BP-1]
   	     mov     AH,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,3833h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M002_L_FE1B:
   	     mov     ES,word ptr DGROUP:M002_BCC_STMT_RECORD_SEG
   	     mov     SI,word ptr ES:[SI]
M002_L_FE22:
   	     or	     SI,SI
   	     je	     short M002_L_FE29
   	     db	     0E9h
   	     dw	     0FF4Dh
M002_L_FE29:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV141	     endp
CO06D_TEXT	     ends

; END STAOV141
; BEGIN STAOV142 (listing ovr_1dbb_afa6:FE31)

   	     extrn   BCC_FAR_AB51:far
   	     extrn   BCC_FAR_B072:far
   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO06D_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06D_TEXT,ds:DGROUP

M003_BCC_DATA_1716	     equ     1716h
M003_BCC_STMT_RECORD_SEG	     equ     63C2h
M003_BCC_DATA_7832	     equ     7832h
M003_BCC_DATA_8160	     equ     8160h
M003_BCC_STMT_CURRENT   equ     86C8h

   	     public  X06D_01
X06D_01 label   far
STAOV142	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     cmp     byte ptr ES:[SI+5],4
   	     jne     short M003_L_FE8B
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     cmp     AX,word ptr DGROUP:M003_BCC_STMT_CURRENT
   	     jne     short M003_L_FE56
   	     push    DS
   	     mov     AX,3875h
   	     jmp     short M003_L_FE5A
M003_L_FE56:
   	     push    DS
   	     mov     AX,3878h
M003_L_FE5A:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     8160h
   	     cmp     AL,2
   	     jbe     short M003_L_FE72
   	     mov     AX,77h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M003_L_FE72:
   	     mov     AX,2Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+0Eh]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     db	     0E9h
   	     dw	     0009Ah
M003_L_FE8B:
   	     push    DS
   	     mov     AX,5F50h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_7832
   	     mov     BX,word ptr ES:[BX+4]
   	     push    word ptr [BX]
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_7832
   	     push    word ptr ES:[BX+2]
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     cmp     byte ptr ES:[SI+5],3
   	     jne     short M003_L_FECA
   	     jmp     short M003_L_FF1A
M003_L_FECA:
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],400h
   	     je	     short M003_L_FEF9
   	     jmp     short M003_L_FEEE
M003_L_FED8:
   	     les     BX,[BP-4]
   	     mov     AL,byte ptr ES:[BX]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AB51
   	     dw	     seg BCC_FAR_AB51
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     inc     word ptr [BP-4]
M003_L_FEEE:
   	     les     BX,[BP-4]
   	     cmp     byte ptr ES:[BX],0
   	     jne     short M003_L_FED8
   	     jmp     short M003_L_FF25
M003_L_FEF9:
   	     mov     ES,word ptr DGROUP:M003_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],2000h
   	     je	     short M003_L_FF0A
   	     mov     AX,40h
   	     jmp     short M003_L_FF14
M003_L_FF0A:
   	     cmp     byte ptr DGROUP:M003_BCC_DATA_1716,0
   	     je	     short M003_L_FF1A
   	     mov     AX,5Fh
M003_L_FF14:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M003_L_FF1A:
   	     push    word ptr [BP-2]
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M003_L_FF25:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
STAOV142	     endp
CO06D_TEXT	     ends

; END STAOV142
   	     end
