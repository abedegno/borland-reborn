   	     public  X078_00
   	     public  X078_01
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1dea_b42c
; BEGIN STAOV203 (listing ovr_1dea_b42c:42C0)

   	     extrn   X059_04:far


CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT,ds:DGROUP

M000_BCC_DATA_8186	     equ     8186h

BCC_NEAR_42C0   label   near
STAOV203	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     xor     SI,SI
   	     jmp     short M000_L_431A
M000_L_42CC:
   	     mov     AX,SI
   	     shl     AX,1
   	     shl     AX,1
   	     les     BX,[BP+4]
   	     add     BX,AX
   	     xor     AX,AX
   	     mov     word ptr ES:[BX+2],AX
   	     mov     DX,SI
   	     shl     DX,1
   	     shl     DX,1
   	     mov     BX,word ptr [BP+4]
   	     add     BX,DX
   	     mov     word ptr ES:[BX],AX
   	     mov     AX,SI
   	     shl     AX,1
   	     les     BX,[BP+8]
   	     add     BX,AX
   	     mov     BX,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[BX+6]
   	     cbw
   	     cwd
   	     xor     AX,DX
   	     sub     AX,DX
   	     mov     DX,SI
   	     shl     DX,1
   	     les     BX,[BP+8]
   	     add     BX,DX
   	     mov     BX,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     byte ptr ES:[BX+6],AL
   	     inc     SI
M000_L_431A:
   	     cmp     SI,word ptr [BP+0Ch]
   	     jl	     short M000_L_42CC
M000_L_431F:
   	     mov     DI,0FFFFh
   	     xor     SI,SI
   	     jmp     short M000_L_436B
M000_L_4326:
   	     mov     AX,SI
   	     shl     AX,1
   	     shl     AX,1
   	     les     BX,[BP+4]
   	     add     BX,AX
   	     cmp     word ptr ES:[BX],0
   	     jne     short M000_L_436A
   	     mov     AX,SI
   	     shl     AX,1
   	     les     BX,[BP+8]
   	     add     BX,AX
   	     mov     BX,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[BX+6]
   	     cbw
   	     cmp     AX,DI
   	     jle     short M000_L_436A
   	     mov     AX,SI
   	     shl     AX,1
   	     les     BX,[BP+8]
   	     add     BX,AX
   	     mov     BX,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[BX+6]
   	     cbw
   	     mov     DI,AX
   	     mov     word ptr [BP-2],SI
M000_L_436A:
   	     inc     SI
M000_L_436B:
   	     cmp     SI,word ptr [BP+0Ch]
   	     jl	     short M000_L_4326
   	     or	     DI,DI
   	     jl	     short M000_L_43A9
   	     mov     AX,word ptr [BP-2]
   	     shl     AX,1
   	     les     BX,[BP+8]
   	     add     BX,AX
   	     push    word ptr ES:[BX]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr [BP+6]
   	     push    AX
   	     push    DX
   	     push    BX
   	     mov     BX,word ptr [BP+4]
   	     pop     AX
   	     add     BX,AX
   	     pop     AX
   	     mov     word ptr ES:[BX+2],AX
   	     pop     AX
   	     mov     word ptr ES:[BX],AX
   	     db	     0E9h
   	     dw	     0FF76h
M000_L_43A9:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     0Ah
STAOV203	     endp
CO078_TEXT	     ends

; END STAOV203
; BEGIN STAOV204 (listing ovr_1dea_b42c:43B2)

   	     extrn   BCC_FAR_5B44:far
   	     extrn   X058_00:far
   	     extrn   X058_02:far


CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT,ds:DGROUP

M001_BCC_DATA_8118	     equ     8118h
M001_BCC_DATA_8150	     equ     8150h
M001_BCC_DATA_8186	     equ     8186h

   	     public  X078_01
X078_01 label   far
STAOV204	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,32h
   	     push    SI
   	     push    DI
   	     xor     AX,AX
   	     mov     word ptr [BP-16h],AX
   	     mov     word ptr [BP-18h],AX
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr ES:[BX+0Ah]
   	     cmp     word ptr ES:[BX],1
   	     je	     short M001_L_43D6
   	     db	     0E9h
   	     dw	     003B5h
M001_L_43D6:
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     mov     word ptr [BP-10h],AX
   	     push    word ptr [BP-10h]
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     cmp     AX,0Ah
   	     je	     short M001_L_43FD
   	     db	     0E9h
   	     dw	     0038Eh
M001_L_43FD:
   	     push    word ptr [BP-10h]
   	     db	     0FFh,01Eh
   	     dw	     8118h
   	     mov     DX,0Ah
   	     imul    DX
   	     add     AX,5A28h
   	     mov     word ptr [BP-12h],DS
   	     mov     word ptr [BP-14h],AX
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     SI,word ptr ES:[BX+0Ch]
   	     les     BX,[BP-14h]
   	     mov     AL,byte ptr ES:[BX+4]
   	     cbw
   	     mov     word ptr [BP-0Ch],AX
   	     mov     BX,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr ES:[BX+2]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     AL,byte ptr [BX+3928h]
   	     les     BX,[BP-14h]
   	     push    AX
   	     mov     AL,byte ptr ES:[BX+2]
   	     cbw
   	     shl     AX,1
   	     shl     AX,1
   	     mov     BX,AX
   	     pop     AX
   	     cmp     AL,byte ptr [BX+3928h]
   	     je	     short M001_L_445F
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     0032Ch
M001_L_445F:
   	     or	     SI,SI
   	     jne     short M001_L_4466
   	     db	     0E9h
   	     dw	     00082h
M001_L_4466:
   	     cmp     word ptr [BP-0Ch],0
   	     jl	     short M001_L_44E8
   	     mov     DI,word ptr [BP-0Ch]
   	     jmp     short M001_L_44B6
M001_L_4471:
   	     or	     DI,DI
   	     jle     short M001_L_448F
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ch]
   	     push    BX
   	     push    ES
   	     les     BX,[BP-14h]
   	     mov     AL,byte ptr ES:[BX+DI+5]
   	     cbw
   	     pop     ES
   	     pop     BX
   	     cmp     word ptr ES:[BX+2],AX
   	     je	     short M001_L_449D
M001_L_448F:
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     002EEh
M001_L_449D:
   	     mov     BX,DI
   	     shl     BX,1
   	     lea     AX,[BP-0Ch]
   	     add     BX,AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr SS:[BX],AX
   	     dec     DI
   	     mov     SI,word ptr ES:[SI+0Ah]
M001_L_44B6:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Bh
   	     je	     short M001_L_4471
   	     cmp     DI,1
   	     jne     short M001_L_44D5
   	     push    ES
   	     les     BX,[BP-14h]
   	     mov     AL,byte ptr ES:[BX+6]
   	     cbw
   	     pop     ES
   	     cmp     word ptr ES:[SI+2],AX
   	     je	     short M001_L_44E3
M001_L_44D5:
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     002A8h
M001_L_44E3:
   	     mov     word ptr [BP-0Ah],SI
   	     jmp     short M001_L_44FC
M001_L_44E8:
   	     cmp     word ptr [BP-0Ch],0
   	     jle     short M001_L_44FC
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     0028Fh
M001_L_44FC:
   	     mov     word ptr [BP-0Eh],0
   	     push    word ptr [BP-0Ch]
   	     push    SS
   	     lea     AX,[BP-0Ah]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-32h]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FDAFh
   	     push    word ptr [BP-10h]
   	     db	     0FFh,01Eh
   	     dw	     8118h
   	     mov     BX,AX
   	     cmp     BX,6
   	     jbe     short M001_L_4522
   	     db	     0E9h
   	     dw	     00219h
M001_L_4522:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     4D9h
   	     mov     AX,word ptr [BP-30h]
   	     mov     DX,word ptr [BP-32h]
   	     mov     word ptr [BP-1Ah],AX
   	     mov     word ptr [BP-1Ch],DX
   	     mov     AX,0ACh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Ch]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-1Ch],AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-1Ah],AX
   	     mov     AX,4Fh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Ch]
   	     push    word ptr [BP-1Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-1Ch],AX
   	     mov     AX,28h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Ch]
   	     push    word ptr [BP-1Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-18h],AX
   	     db	     0E9h
   	     dw	     001B9h
   	     mov     AX,6Eh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-32h]
   	     push    word ptr [BP-2Eh]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-18h],AX
   	     db	     0E9h
   	     dw	     001A1h
   	     mov     AX,70h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    AX
   	     push    word ptr [BP-32h]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,0C2h
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-18h],AX
   	     db	     0E9h
   	     dw	     0016Ch
   	     mov     AX,6Fh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-32h]
   	     push    word ptr [BP-2Eh]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-18h],AX
   	     db	     0E9h
   	     dw	     00154h
   	     mov     AX,71h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    AX
   	     push    word ptr [BP-32h]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,0C2h
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-18h],AX
   	     db	     0E9h
   	     dw	     0011Fh
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr [BP-0Ah]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M001_L_466B
   	     cmp     word ptr ES:[BX+0Ah],0FFh
   	     jbe     short M001_L_464A
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     00141h
M001_L_464A:
   	     mov     AX,72h
   	     push    AX
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     and     AX,0FFh
   	     xor     DX,DX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-18h],AX
   	     db	     0E9h
   	     dw	     000DBh
M001_L_466B:
   	     mov     AX,word ptr [BP-30h]
   	     mov     DX,word ptr [BP-32h]
   	     mov     word ptr [BP-1Ah],AX
   	     mov     word ptr [BP-1Ch],DX
   	     mov     AX,45h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Ch]
   	     mov     AX,9
   	     push    AX
   	     xor     AX,AX
   	     mov     DX,1
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-1Eh],AX
   	     mov     AX,45h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Eh]
   	     mov     AX,9
   	     push    AX
   	     xor     AX,AX
   	     mov     DX,1
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-1Eh],AX
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
   	     mov     AX,0A6h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     xor     AX,AX
   	     push    AX
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
   	     mov     word ptr [BP-22h],AX
   	     mov     AX,1Bh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Eh]
   	     push    word ptr [BP-22h]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-20h],AX
   	     mov     AX,16h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Eh]
   	     push    word ptr [BP-22h]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-1Eh],AX
   	     mov     AX,76h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-1Eh]
   	     push    word ptr [BP-20h]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-18h],AX
   	     jmp     short M001_L_4746
   	     push    SI
   	     db	     0E8h
   	     dw	     00073h
   	     mov     word ptr [BP-18h],1
   	     jmp     short M001_L_4746
M001_L_473B:
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
M001_L_4746:
   	     cmp     word ptr [BP-0Eh],0
   	     je	     short M001_L_476F
   	     mov     AX,7Fh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AX,0Dh
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
M001_L_476F:
   	     les     BX,[BP-14h]
   	     cmp     byte ptr ES:[BX+2],0Fh
   	     jne     short M001_L_478B
   	     mov     AX,0C7h
   	     push    AX
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-16h],AX
M001_L_478B:
   	     mov     DX,word ptr [BP-16h]
   	     mov     AX,word ptr [BP-18h]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV204	     endp
CO078_TEXT	     ends

; END STAOV204
; BEGIN STAOV205 (listing ovr_1dea_b42c:4799)
CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT

STAOV205	     label   word
   	     dw	     00367h
   	     dw	     00269h
   	     dw	     002CDh
   	     dw	     002E5h
   	     dw	     0031Ah
   	     dw	     00332h
   	     dw	     00470h

CO078_TEXT	     ends
; END STAOV205
; BEGIN STAOV206 (listing ovr_1dea_b42c:47A7)

   	     extrn   BCC_FAR_5B44:far
   	     extrn   X058_00:far
   	     extrn   X058_04:far
   	     extrn   X060_02:far
   	     extrn   X063_02:far
   	     extrn   X063_03:far


CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT,ds:DGROUP

M003_BCC_DATA_8186	     equ     8186h
M003_BCC_DATA_866E	     equ     866Eh
M003_BCC_DATA_86E6	     equ     86E6h
M003_BCC_DATA_86EA	     equ     86EAh
M003_BCC_DATA_86EC	     equ     86ECh

BCC_NEAR_47A7_B label   near
STAOV206	     proc    near
M003_L_47A7:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Bh
   	     jne     short M003_L_47CC
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFE3h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     SI,word ptr ES:[SI+0Ch]
M003_L_47CC:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],3
   	     je	     short M003_L_47DE
   	     cmp     word ptr ES:[SI+2],5
   	     jne     short M003_L_4813
M003_L_47DE:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2
   	     jne     short M003_L_4813
   	     cmp     word ptr ES:[SI+0Ch],0
   	     jl	     short M003_L_4813
   	     jne     short M003_L_47F8
   	     cmp     word ptr ES:[SI+0Ah],0
   	     jc	     short M003_L_4813
M003_L_47F8:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+0Ch],0
   	     jg	     short M003_L_4813
   	     jne     short M003_L_480D
   	     cmp     word ptr ES:[SI+0Ah],0FFh
   	     ja	     short M003_L_4813
M003_L_480D:
   	     mov     byte ptr [BP-1],1
   	     jmp     short M003_L_481E
M003_L_4813:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[SI+2]
   	     mov     byte ptr [BP-1],AL
M003_L_481E:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,2
   	     jne     short M003_L_482D
   	     db	     0E9h
   	     dw	     00120h
M003_L_482D:
   	     cmp     AX,32h
   	     je	     short M003_L_4835
   	     db	     0E9h
   	     dw	     0018Ch
M003_L_4835:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     DI,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[DI],5
   	     je	     short M003_L_4849
   	     cmp     word ptr ES:[DI],6
   	     jne     short M003_L_48BA
M003_L_4849:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     mov     AL,byte ptr ES:[DI+2]
   	     push    AX
   	     mov     AL,byte ptr ES:[DI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X060_02
   	     dw	     seg X060_02
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_866E
   	     inc     word ptr ES:[BX+11h]
   	     cmp     byte ptr ES:[BX+0Dh],6
   	     je	     short M003_L_4889
   	     push    word ptr DGROUP:M003_BCC_DATA_86EC
   	     mov     AX,DGROUP:M003_BCC_DATA_86E6
   	     neg     AX
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X063_03
   	     dw	     seg X063_03
   	     jmp     short M003_L_489B
M003_L_4889:
   	     cmp     word ptr DGROUP:M003_BCC_DATA_86EC,0
   	     je	     short M003_L_489B
   	     mov     word ptr DGROUP:M003_BCC_DATA_86EA,2
   	     db	     09Ah
   	     dw	     X063_02
   	     dw	     seg X063_02
M003_L_489B:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_866E
   	     mov     byte ptr ES:[BX+0Eh],4
   	     mov     AX,7Ah
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr ES:[BX+0Fh]
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     db	     0E9h
   	     dw	     00112h
M003_L_48BA:
   	     mov     AL,byte ptr [BP-1]
   	     mov     AH,0
   	     sub     AX,0Dh
   	     mov     BX,AX
   	     cmp     BX,3
   	     ja	     short M003_L_493F
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     735h
   	     mov     AX,7Ch
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr ES:[DI+0Ch]
   	     mov     AL,byte ptr ES:[DI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
   	     db	     0E9h
   	     dw	     000DFh
   	     mov     AX,7Bh
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     xor     AX,AX
   	     push    AX
   	     mov     AL,byte ptr ES:[DI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
   	     db	     0E9h
   	     dw	     000C3h
   	     mov     AX,7Ch
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr ES:[DI+0Ch]
   	     mov     AL,byte ptr ES:[DI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
   	     mov     AX,7Bh
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     xor     AX,AX
   	     push    AX
   	     mov     AL,byte ptr ES:[DI+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_04
   	     dw	     seg X058_04
   	     db	     0E9h
   	     dw	     0008Dh
M003_L_493F:
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     0007Fh
M003_L_494D:
   	     mov     AL,byte ptr [BP-1]
   	     mov     AH,0
   	     dec     AX
   	     mov     BX,AX
   	     cmp     BX,0Fh
   	     ja	     short M003_L_497B
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     715h
   	     mov     AX,7Ah
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     and     AX,0FFh
   	     xor     DX,DX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     jmp     short M003_L_49CC
M003_L_497B:
   	     mov     AX,79h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     and     AX,0FFFFh
   	     xor     DX,DX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     jmp     short M003_L_49CC
   	     mov     AX,79h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     and     AX,0FFFFh
   	     xor     DX,DX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     AX,79h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
M003_L_49C1:
   	     mov     AX,3
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
M003_L_49CC:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV206	     endp
CO078_TEXT	     ends

; END STAOV206
; BEGIN STAOV207 (listing ovr_1dea_b42c:49D5)
CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT

STAOV207	     label   word
   	     dw	     006A1h
   	     dw	     006A1h
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006D5h
   	     dw	     006D5h
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006BBh
   	     dw	     006D5h
   	     dw	     006D5h
   	     dw	     00610h
   	     dw	     0062Dh
   	     dw	     00649h
   	     dw	     00649h

CO078_TEXT	     ends
; END STAOV207
; BEGIN STAOV208 (listing ovr_1dea_b42c:49FD)


   	     extrn   BCC_FAR_5B8B:far


CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT,ds:DGROUP

   	     public  X078_00
X078_00 label   far
STAOV208	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     cmp     word ptr [BP+8],6
   	     jne     short M005_L_4A23
   	     or	     SI,SI
   	     jne     short M005_L_4A1F
   	     push    DS
   	     mov     AX,5ABAh
   	     push    AX
   	     mov     AX,2Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     add     SP,6
M005_L_4A1F:
   	     push    SI
   	     db	     0E8h
   	     dw	     00005h
M005_L_4A23:
   	     pop     SI
   	     pop     BP
   	     retf    4
STAOV208	     endp
CO078_TEXT	     ends

; END STAOV208
; BEGIN STAOV209 (listing ovr_1dea_b42c:4A28)

   	     extrn   BCC_FAR_5B8B:far


CO078_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO078_TEXT,ds:DGROUP

M006_BCC_DATA_8186	     equ     8186h

BCC_NEAR_4A28   label   near
STAOV209	     proc    near
M006_L_4A28:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2Bh
   	     jne     short M006_L_4A49
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFE7h
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     mov     SI,word ptr ES:[SI+0Ch]
M006_L_4A49:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,32h
   	     je	     short M006_L_4A81
   	     jg	     short M006_L_4A63
   	     cmp     AX,2
   	     je	     short M006_L_4A81
   	     cmp     AX,3
   	     je	     short M006_L_4A81
   	     jmp     short M006_L_4A74
M006_L_4A63:
   	     cmp     AX,35h
   	     je	     short M006_L_4A6A
   	     jmp     short M006_L_4A74
M006_L_4A6A:
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     mov     SI,word ptr ES:[SI+0Ah]
   	     jmp     short M006_L_4A49
M006_L_4A74:
   	     mov     AX,19h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     jmp     short M006_L_4A49
M006_L_4A81:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV209	     endp
CO078_TEXT	     ends

; END STAOV209
   	     end
