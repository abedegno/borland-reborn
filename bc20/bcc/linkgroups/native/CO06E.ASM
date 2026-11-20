   	     public  X06E_02
   	     public  X06E_00
   	     public  X06E_01
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1dbe_b000
; BEGIN STAOV143 (listing ovr_1dbe_b000:0000)

   	     extrn   BCC_FAR_038B:far
   	     extrn   BCC_FAR_5B8B:far
   	     extrn   BCC_FAR_AB12:far
   	     extrn   BCC_FAR_AB51:far
   	     extrn   BCC_FAR_AF0C:far
   	     extrn   BCC_FAR_B072:far
   	     extrn   BCC_FAR_B146:far
   	     extrn   X02F_00:far
   	     extrn   X04A_02:far
   	     extrn   X060_02:far


CO06E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06E_TEXT,ds:DGROUP

M000_BCC_DATA_1714	     equ     1714h
M000_BCC_DATA_1716	     equ     1716h
M000_BCC_EXPR_SEGMENT   equ     639Ah
M000_BCC_STMT_RECORD_SEG	     equ     63C2h
M000_BCC_DATA_679C	     equ     679Ch
M000_BCC_DATA_679E	     equ     679Eh
M000_BCC_DATA_679F	     equ     679Fh
M000_BCC_DATA_67A0	     equ     67A0h
M000_BCC_DATA_67A1	     equ     67A1h
M000_BCC_DATA_67A2	     equ     67A2h
M000_BCC_DATA_67A3	     equ     67A3h
M000_BCC_DATA_67A4	     equ     67A4h
M000_BCC_DATA_67A5	     equ     67A5h
M000_BCC_DATA_7832	     equ     7832h
M000_BCC_DATA_7846	     equ     7846h
M000_BCC_DATA_8164	     equ     8164h
M000_BCC_DATA_8306	     equ     8306h
M000_BCC_DATA_866E	     equ     866Eh

   	     public  X06E_02
X06E_02 label   far
STAOV143	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     mov     AX,31h
   	     push    AX
   	     db	     09Ah
   	     dw	     X02F_00
   	     dw	     seg X02F_00
   	     mov     word ptr [BP-0Ch],AX
   	     push    word ptr [BP-0Ch]
   	     push    word ptr DGROUP:M000_BCC_DATA_679C
   	     mov     AL,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X04A_02
   	     dw	     seg X04A_02
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M000_L_0031
   	     db	     0E9h
   	     dw	     002A2h
M000_L_0031:
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     or	     word ptr ES:[SI+6],0C0h
   	     test    word ptr ES:[SI+6],8
   	     jne     short M000_L_0049
   	     or	     word ptr ES:[SI+6],100h
M000_L_0049:
   	     mov     byte ptr DGROUP:M000_BCC_DATA_679E,0
   	     push    SI
   	     mov     AL,0
   	     push    AX
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     mov     AL,byte ptr ES:[SI+6]
   	     push    AX
   	     db	     09Ah
   	     dw	     X060_02
   	     dw	     seg X060_02
   	     mov     word ptr [BP-0Ah],AX
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_866E
   	     inc     word ptr ES:[BX+11h]
   	     or	     byte ptr ES:[BX+0Eh],4
   	     mov     AL,DGROUP:M000_BCC_DATA_1714
   	     cbw
   	     or	     AX,AX
   	     je	     short M000_L_007E
   	     db	     0E9h
   	     dw	     000DBh
M000_L_007E:
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     mov     AL,byte ptr ES:[SI+5]
   	     mov     AH,0
   	     dec     AX
   	     mov     BX,AX
   	     cmp     BX,8
   	     jbe     short M000_L_0093
   	     db	     0E9h
   	     dw	     00240h
M000_L_0093:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     2EBh
   	     mov     byte ptr DGROUP:M000_BCC_DATA_679E,40h
   	     mov     byte ptr DGROUP:M000_BCC_DATA_679F,53h
   	     mov     AX,SI
   	     mov     CL,0Ch
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A0,AL
   	     mov     AX,SI
   	     mov     CL,8
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A1,AL
   	     mov     AX,SI
   	     mov     CL,4
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A2,AL
   	     mov     AX,SI
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A3,AL
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A4,AL
   	     mov     byte ptr DGROUP:M000_BCC_DATA_67A5,0
   	     db	     0E9h
   	     dw	     001E6h
   	     mov     byte ptr DGROUP:M000_BCC_DATA_679E,40h
   	     mov     byte ptr DGROUP:M000_BCC_DATA_679F,56h
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     CL,0Ch
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A0,AL
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     CL,8
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A1,AL
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     CL,4
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A2,AL
   	     mov     AX,word ptr [BP-0Ah]
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A3,AL
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A4,AL
   	     mov     byte ptr DGROUP:M000_BCC_DATA_67A5,0
   	     db	     0E9h
   	     dw	     0018Fh
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+0Eh]
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF0C
   	     dw	     seg BCC_FAR_AF0C
   	     db	     0E9h
   	     dw	     0017Ah
M000_L_0159:
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     mov     AL,byte ptr ES:[SI+5]
   	     mov     AH,0
   	     dec     AX
   	     mov     BX,AX
   	     cmp     BX,8
   	     jbe     short M000_L_016E
   	     db	     0E9h
   	     dw	     0015Ah
M000_L_016E:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     2D9h
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX],12h
   	     je	     short M000_L_01AF
   	     cmp     word ptr DGROUP:M000_BCC_DATA_8306,0
   	     je	     short M000_L_01AF
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     push    word ptr DGROUP:M000_BCC_DATA_7846
   	     push    word ptr DGROUP:M000_BCC_DATA_8306
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     push    DS
   	     mov     AX,38F8h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B146
   	     dw	     seg BCC_FAR_B146
M000_L_01AF:
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     add     AX,679Eh
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_7832
   	     mov     BX,word ptr ES:[BX+4]
   	     mov     AX,word ptr [BX]
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_7832
   	     mov     DX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-6],AX
   	     mov     word ptr [BP-8],DX
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],400h
   	     je	     short M000_L_0217
   	     jmp     short M000_L_0207
M000_L_01F4:
   	     les     BX,[BP-8]
   	     inc     word ptr [BP-8]
   	     mov     AL,byte ptr ES:[BX]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AB51
   	     dw	     seg BCC_FAR_AB51
   	     mov     byte ptr [DI],AL
   	     inc     DI
M000_L_0207:
   	     les     BX,[BP-8]
   	     cmp     byte ptr ES:[BX],0
   	     jne     short M000_L_01F4
   	     mov     byte ptr [DI],0
   	     inc     DI
   	     db	     0E9h
   	     dw	     000BCh
M000_L_0217:
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     test    word ptr ES:[SI+6],2000h
   	     je	     short M000_L_0240
   	     mov     byte ptr [DI],40h
   	     inc     DI
   	     push    DS
   	     push    DI
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-8]
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     push    DS
   	     push    DI
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     add     DI,AX
   	     db	     0E9h
   	     dw	     00093h
M000_L_0240:
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1716,0
   	     je	     short M000_L_024B
   	     mov     byte ptr [DI],5Fh
   	     inc     DI
M000_L_024B:
   	     push    DS
   	     push    DI
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-8]
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     jmp     short M000_L_02D3
   	     mov     byte ptr DGROUP:M000_BCC_DATA_679E,1Ah
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     word ptr [BP-2],0
   	     mov     word ptr [BP-4],AX
   	     mov     DX,word ptr [BP-2]
   	     mov     CL,0Ch
   	     db	     09Ah
   	     dw	     BCC_FAR_038B
   	     dw	     seg BCC_FAR_038B
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_679F,AL
   	     mov     DX,word ptr [BP-2]
   	     mov     AX,word ptr [BP-4]
   	     mov     CL,8
   	     db	     09Ah
   	     dw	     BCC_FAR_038B
   	     dw	     seg BCC_FAR_038B
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A0,AL
   	     mov     DX,word ptr [BP-2]
   	     mov     AX,word ptr [BP-4]
   	     mov     CL,4
   	     db	     09Ah
   	     dw	     BCC_FAR_038B
   	     dw	     seg BCC_FAR_038B
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A1,AL
   	     mov     AL,byte ptr [BP-4]
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     DGROUP:M000_BCC_DATA_67A2,AL
   	     mov     byte ptr DGROUP:M000_BCC_DATA_67A3,0
   	     jmp     short M000_L_02D3
   	     mov     ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[SI+0Eh]
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF0C
   	     dw	     seg BCC_FAR_AF0C
   	     jmp     short M000_L_02D3
M000_L_02C8:
   	     mov     AX,10h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
M000_L_02D3:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf
STAOV143	     endp
CO06E_TEXT	     ends

; END STAOV143
; BEGIN STOVT194 (listing ovr_1dbe_b000:02D9)
CO06E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06E_TEXT

STOVT194	     label   word
   	     dw	     00175h
   	     dw	     001AFh
   	     dw	     0025Ah
   	     dw	     0025Ah
   	     dw	     0025Ah
   	     dw	     0025Ah
   	     dw	     002C8h
   	     dw	     002C8h
   	     dw	     002B4h

CO06E_TEXT	     ends
; END STOVT194
; BEGIN STOVT195 (listing ovr_1dbe_b000:02EB)
CO06E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06E_TEXT

STOVT195	     label   word
   	     dw	     0009Ah
   	     dw	     0009Ah
   	     dw	     0009Ah
   	     dw	     0009Ah
   	     dw	     000EDh
   	     dw	     000EDh
   	     dw	     002D3h
   	     dw	     002D3h
   	     dw	     00144h

CO06E_TEXT	     ends
; END STOVT195
; BEGIN STAOV144 (listing ovr_1dbe_b000:02FD)

   	     extrn   BCC_FAR_5B8B:far
   	     extrn   BCC_FAR_AF0C:far
   	     extrn   BCC_FAR_B072:far
   	     extrn   X02F_00:far
   	     extrn   X031_0E:far
   	     extrn   X03C_01:far
   	     extrn   X03C_04:far
   	     extrn   X046_00:far
   	     extrn   X047_05:far
   	     extrn   X04A_04:far


CO06E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06E_TEXT,ds:DGROUP

M003_BCC_EXPR_SEGMENT   equ     639Ah
M003_BCC_DATA_679C	     equ     679Ch
M003_BCC_DATA_679E	     equ     679Eh
M003_BCC_TOKEN_SAVED    equ     77FDh
M003_BCC_DATA_7832	     equ     7832h
M003_BCC_DATA_78A4	     equ     78A4h
M003_BCC_STMT_TYPE_CURRENT	     equ     8260h
M003_BCC_DATA_8269	     equ     8269h

   	     public  X06E_00
X06E_00 label   far
STAOV144	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     db	     09Ah
   	     dw	     X03C_01
   	     dw	     seg X03C_01
   	     mov     DI,AX
   	     cmp     DI,1
   	     je	     short M003_L_0314
   	     db	     0E9h
   	     dw	     0009Bh
M003_L_0314:
   	     cmp     byte ptr DGROUP:M003_BCC_TOKEN_SAVED,0
   	     je	     short M003_L_0325
   	     mov     byte ptr DGROUP:M003_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M003_BCC_STMT_TYPE_CURRENT
   	     jmp     short M003_L_032A
M003_L_0325:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M003_L_032A:
   	     push    AX
   	     db	     09Ah
   	     dw	     X046_00
   	     dw	     seg X046_00
   	     or	     AX,AX
   	     jne     short M003_L_0345
   	     mov     AX,2Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     mov     AX,2
   	     db	     0E9h
   	     dw	     00117h
M003_L_0345:
   	     db	     09Ah
   	     dw	     X047_05
   	     dw	     seg X047_05
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M003_L_0355
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00107h
M003_L_0355:
   	     mov     ES,word ptr DGROUP:M003_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[SI],13h
   	     je	     short M003_L_0372
   	     cmp     byte ptr ES:[SI],14h
   	     je	     short M003_L_0372
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     xor     SI,SI
M003_L_0372:
   	     cmp     word ptr DGROUP:M003_BCC_STMT_TYPE_CURRENT,31h
   	     je	     short M003_L_038A
   	     mov     AX,18h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     mov     AX,2
   	     db	     0E9h
   	     dw	     000D2h
M003_L_038A:
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     mov     BX,word ptr DGROUP:M003_BCC_DATA_8269
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_7832
   	     mov     BX,word ptr ES:[BX+4]
   	     push    word ptr [BX]
   	     mov     BX,word ptr DGROUP:M003_BCC_DATA_8269
   	     push    word ptr ES:[BX+2]
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     mov     DI,31h
   	     jmp     short M003_L_03B1
M003_L_03AF:
   	     xor     SI,SI
M003_L_03B1:
   	     mov     BX,DI
   	     cmp     BX,7Bh
   	     je	     short M003_L_03F2
   	     jg	     short M003_L_03E3
   	     cmp     BX,77h
   	     je	     short M003_L_03F2
   	     jg	     short M003_L_03D2
   	     cmp     BX,31h
   	     je	     short M003_L_03F2
   	     cmp     BX,74h
   	     je	     short M003_L_03F2
   	     cmp     BX,76h
   	     je	     short M003_L_03F2
   	     jmp     short M003_L_043F
M003_L_03D2:
   	     cmp     BX,78h
   	     je	     short M003_L_03F2
   	     cmp     BX,79h
   	     je	     short M003_L_03F2
   	     cmp     BX,7Ah
   	     je	     short M003_L_03F2
   	     jmp     short M003_L_043F
M003_L_03E3:
   	     sub     BX,7Ch
   	     cmp     BX,5
   	     ja	     short M003_L_043F
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     462h
M003_L_03F2:
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     mov     AX,31h
   	     push    AX
   	     db	     09Ah
   	     dw	     X02F_00
   	     dw	     seg X02F_00
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     push    word ptr DGROUP:M003_BCC_DATA_679C
   	     push    SI
   	     db	     09Ah
   	     dw	     X04A_04
   	     dw	     seg X04A_04
   	     mov     word ptr [BP-4],AX
   	     cmp     word ptr [BP-4],0
   	     je	     short M003_L_0435
   	     mov     byte ptr DGROUP:M003_BCC_DATA_679E,2Bh
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_78A4
   	     push    word ptr ES:[BX+4]
   	     push    DS
   	     mov     AX,679Fh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF0C
   	     dw	     seg BCC_FAR_AF0C
   	     jmp     short M003_L_0459
M003_L_0435:
   	     mov     AL,2Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X03C_04
   	     dw	     seg X03C_04
   	     jmp     short M003_L_0459
M003_L_043F:
   	     mov     AL,2Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X03C_04
   	     dw	     seg X03C_04
   	     cmp     DI,7Ch
   	     jne     short M003_L_0450
   	     xor     AX,AX
   	     jmp     short M003_L_045C
M003_L_0450:
   	     cmp     DI,7
   	     jne     short M003_L_0459
   	     xor     AX,AX
   	     jmp     short M003_L_045C
M003_L_0459:
   	     mov     AX,1
M003_L_045C:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf
STAOV144	     endp
CO06E_TEXT	     ends

; END STAOV144
; BEGIN STOVT196 (listing ovr_1dbe_b000:0462)
CO06E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06E_TEXT

STOVT196	     label   word
   	     dw	     003F2h
   	     dw	     003F2h
   	     dw	     003F2h
   	     dw	     003F2h
   	     dw	     003F2h
   	     dw	     003F2h

CO06E_TEXT	     ends
; END STOVT196
; BEGIN STAOV145 (listing ovr_1dbe_b000:046E)

   	     extrn   X02F_00:far
   	     extrn   X03C_04:far
   	     extrn   X04A_02:far
   	     extrn   X04A_12:far
   	     extrn   X057_04:far
   	     extrn   X057_05:far
   	     extrn   X057_07:far


CO06E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO06E_TEXT,ds:DGROUP

M005_BCC_DATA_5EDC	     equ     5EDCh
M005_BCC_STMT_RECORD_SEG	     equ     63C2h
M005_BCC_DATA_77EC	     equ     77ECh
M005_BCC_DATA_8263	     equ     8263h
M005_BCC_DATA_8265	     equ     8265h
M005_BCC_DATA_8618	     equ     8618h
M005_BCC_DATA_8654	     equ     8654h

   	     public  X06E_01
X06E_01 label   far
STAOV145	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     AL,40h
   	     push    AX
   	     db	     09Ah
   	     dw	     X03C_04
   	     dw	     seg X03C_04
   	     push    DS
   	     mov     AX,679Eh
   	     push    AX
   	     mov     AX,31h
   	     push    AX
   	     db	     09Ah
   	     dw	     X02F_00
   	     dw	     seg X02F_00
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     push    word ptr DGROUP:M005_BCC_DATA_8618
   	     mov     AL,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X04A_02
   	     dw	     seg X04A_02
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M005_L_04CA
   	     push    word ptr [BP-2]
   	     push    word ptr DGROUP:M005_BCC_DATA_8618
   	     mov     AL,1
   	     push    AX
   	     mov     AX,3
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X04A_12
   	     dw	     seg X04A_12
   	     mov     SI,AX
   	     db	     09Ah
   	     dw	     X057_05
   	     dw	     seg X057_05
   	     mov     ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
   	     mov     word ptr ES:[SI+0Eh],AX
M005_L_04CA:
   	     mov     ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
   	     or	     word ptr ES:[SI+6],80h
   	     push    word ptr ES:[SI+0Eh]
   	     push    word ptr DGROUP:M005_BCC_DATA_8263
   	     push    word ptr DGROUP:M005_BCC_DATA_8265
   	     push    word ptr DGROUP:M005_BCC_DATA_8263
   	     push    word ptr DGROUP:M005_BCC_DATA_8265
   	     db	     09Ah
   	     dw	     X057_04
   	     dw	     seg X057_04
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8654
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[DI+8],AX
   	     or	     word ptr ES:[DI+1Ch],100h
   	     push    word ptr DGROUP:M005_BCC_DATA_5EDC
   	     push    DI
   	     push    word ptr DGROUP:M005_BCC_DATA_77EC
   	     db	     09Ah
   	     dw	     X057_07
   	     dw	     seg X057_07
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
STAOV145	     endp
CO06E_TEXT	     ends

; END STAOV145
   	     end
