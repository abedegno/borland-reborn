   	     public  X049_04
   	     public  X049_00
   	     public  X049_01
   	     public  X049_02
   	     public  X049_03
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d02_95b1
; BEGIN STOVR3 (listing ovr_1d02_95b1:5B10)



CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M000_BCC_DATA_8186	     equ     8186h

   	     public  X049_03
X049_03 label   far
BCC_FAR_5B10    proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     word ptr [BP+6],0
   	     je	     short M000_L_5B27
   	     mov     BX,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     cmp     word ptr ES:[BX+2],0
   	     jne     short M000_L_5B2C
M000_L_5B27:
   	     mov     AX,word ptr [BP+6]
   	     jmp     short M000_L_5B45
M000_L_5B2C:
   	     push    SS
   	     lea     AX,[BP+6]
   	     push    AX
   	     push    SS
   	     push    AX
   	     push    word ptr [BP+6]
   	     mov     AX,3
   	     push    AX
   	     db	     0E8h
   	     dw	     0000Ch
   	     push    word ptr [BP+6]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     002ADh
M000_L_5B45:
   	     pop     BP
   	     retf    2
BCC_FAR_5B10    endp
CO049_TEXT	     ends

; END STOVR3
; BEGIN STOVR4 (listing ovr_1d02_95b1:5B49)

   	     extrn   BCC_FAR_0402:far
   	     extrn   X043_03:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M001_BCC_DATA_80B8	     equ     80B8h
M001_BCC_DATA_8186	     equ     8186h

BCC_NEAR_5B49   proc    near
M001_L_5B49:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     DI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr ES:[SI]
   	     cmp     BX,14h
   	     je	     short M001_L_5B8F
   	     jg	     short M001_L_5B7D
   	     dec     BX
   	     cmp     BX,12h
   	     jbe     short M001_L_5B76
   	     db	     0E9h
   	     dw	     001C5h
M001_L_5B76:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     2BCh
M001_L_5B7D:
   	     sub     BX,23h
   	     cmp     BX,13h
   	     jbe     short M001_L_5B88
   	     db	     0E9h
   	     dw	     001B3h
M001_L_5B88:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     294h
M001_L_5B8F:
   	     les     BX,[BP+0Ch]
   	     cmp     word ptr ES:[BX],SI
   	     jne     short M001_L_5B9A
   	     db	     0E9h
   	     dw	     001A1h
M001_L_5B9A:
   	     test    DI,1
   	     jne     short M001_L_5BA3
   	     db	     0E9h
   	     dw	     00198h
M001_L_5BA3:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],7
   	     jle     short M001_L_5BB3
   	     db	     0E9h
   	     dw	     00188h
M001_L_5BB3:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[SI]
   	     push    word ptr ES:[SI+8]
   	     push    word ptr [BP-2]
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     word ptr [BP-4],AX
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     les     BX,[BP+8]
   	     mov     word ptr ES:[BX],AX
   	     push    word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[BX]
   	     push    word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr [BP-2]
   	     mov     CX,14h
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     mov     AX,2Ah
   	     push    AX
   	     les     BX,[BP+0Ch]
   	     mov     BX,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[BX+8]
   	     push    word ptr [BP-4]
   	     les     BX,[BP+0Ch]
   	     push    word ptr ES:[BX]
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     les     BX,[BP+0Ch]
   	     mov     word ptr ES:[BX],AX
   	     db	     0E9h
   	     dw	     0017Dh
   	     les     BX,[BP+0Ch]
   	     cmp     word ptr ES:[BX],SI
   	     jne     short M001_L_5C29
   	     db	     0E9h
   	     dw	     00112h
M001_L_5C29:
   	     test    DI,2
   	     jne     short M001_L_5C32
   	     db	     0E9h
   	     dw	     00109h
M001_L_5C32:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],7
   	     jle     short M001_L_5C42
   	     db	     0E9h
   	     dw	     000F9h
M001_L_5C42:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     mov     AL,byte ptr [BX+35B9h]
   	     cbw
   	     push    AX
   	     push    word ptr ES:[SI+8]
   	     push    word ptr [BP-2]
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     word ptr [BP-4],AX
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     les     BX,[BP+8]
   	     mov     word ptr ES:[BX],AX
   	     push    word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[BX]
   	     push    word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr [BP-2]
   	     mov     CX,14h
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     mov     AX,29h
   	     push    AX
   	     les     BX,[BP+0Ch]
   	     mov     BX,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[BX+8]
   	     les     BX,[BP+0Ch]
   	     push    word ptr ES:[BX]
   	     push    word ptr [BP-4]
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     les     BX,[BP+0Ch]
   	     mov     word ptr ES:[BX],AX
   	     db	     0E9h
   	     dw	     000E8h
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     push    SS
   	     lea     AX,[BP-2]
   	     push    AX
   	     push    word ptr ES:[SI+0Ah]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FE78h
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     db	     0E9h
   	     dw	     000BCh
   	     test    DI,2
   	     je	     short M001_L_5D11
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     push    SS
   	     lea     AX,[BP-2]
   	     push    AX
   	     push    word ptr ES:[SI+0Ch]
   	     mov     AX,2
   	     push    AX
   	     db	     0E8h
   	     dw	     0FE43h
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ch],AX
M001_L_5D11:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-2],AX
   	     push    SS
   	     lea     AX,[BP-2]
   	     push    AX
   	     push    SS
   	     push    AX
   	     push    word ptr ES:[SI+0Ah]
   	     mov     AX,3
   	     push    AX
   	     db	     0E8h
   	     dw	     0FE1Bh
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     jmp     short M001_L_5D9B
M001_L_5D3B:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+0Ch],0
   	     je	     short M001_L_5D6B
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     push    SS
   	     lea     AX,[BP-2]
   	     push    AX
   	     push    word ptr ES:[SI+0Ch]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FDE9h
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ch],AX
M001_L_5D6B:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+0Ah],0
   	     je	     short M001_L_5D9B
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     push    SS
   	     lea     AX,[BP-2]
   	     push    AX
   	     push    word ptr ES:[SI+0Ah]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FDB9h
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ah],AX
M001_L_5D9B:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     0Ch
BCC_NEAR_5B49   endp
CO049_TEXT	     ends

; END STOVR4
; BEGIN STOVTBL1 (listing ovr_1d02_95b1:5DA4)
CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT

BCC_TABLE_5DA4  label   word
   	     dw	     0010Eh
   	     dw	     0010Eh
   	     dw	     0028Bh
   	     dw	     0022Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0022Bh
   	     dw	     001CFh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     001A3h
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0028Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0022Bh
   	     dw	     0007Fh

CO049_TEXT	     ends
; END STOVTBL1
; BEGIN STOVR5 (listing ovr_1d02_95b1:5DF2)

   	     extrn   BCC_FAR_5B44:far
   	     extrn   X04C_04:far
   	     extrn   X04C_06:far
   	     extrn   X04C_0D:far
   	     extrn   X057_01:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M003_BCC_EXPR_SEGMENT   equ     639Ah
M003_BCC_DATA_77E2	     equ     77E2h
M003_BCC_DATA_8108	     equ     8108h
M003_BCC_DATA_8186	     equ     8186h

   	     public  X049_02
X049_02 label   far
BCC_NEAR_5DF2   label   near
BCC_FAR_5DF2    proc    far
M003_L_5DF2:
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     cmp     SP,8F0Ch
   	     jnc     short M003_L_5E0E
   	     mov     AX,6
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
M003_L_5E0E:
   	     or	     SI,SI
   	     je	     short M003_L_5E23
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M003_L_5E23
   	     cmp     word ptr ES:[SI],35h
   	     jne     short M003_L_5E28
M003_L_5E23:
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     006A4h
M003_L_5E28:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],15h
   	     jne     short M003_L_5E7A
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr [BP-8],AX
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M003_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[BX+3],1
   	     jne     short M003_L_5E56
   	     mov     AX,1
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     jmp     short M003_L_5E5D
M003_L_5E56:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,DGROUP:M003_BCC_DATA_77E2
M003_L_5E5D:
   	     mov     word ptr ES:[SI+8],AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M003_BCC_EXPR_SEGMENT
   	     mov     AL,byte ptr ES:[BX]
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
M003_L_5E7A:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],7
   	     jg	     short M003_L_5E89
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00643h
M003_L_5E89:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF5Dh
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     DI,AX
   	     cmp     word ptr ES:[SI],33h
   	     jne     short M003_L_5EAA
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00622h
M003_L_5EAA:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF3Ch
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr ES:[SI]
   	     sub     BX,8
   	     cmp     BX,2Ah
   	     jbe     short M003_L_5ECF
   	     db	     0E9h
   	     dw	     005F7h
M003_L_5ECF:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     9D0h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_5EEE
   	     push    SI
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     00DD9h
   	     mov     SI,AX
   	     jmp     short M003_L_5F1E
M003_L_5EEE:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_5F09
   	     push    SI
   	     push    word ptr [BP-4]
   	     push    DI
   	     db	     0E8h
   	     dw	     00DBEh
   	     mov     SI,AX
   	     jmp     short M003_L_5F1E
M003_L_5F09:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],2
   	     jne     short M003_L_5F1E
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     word ptr ES:[SI+0Ch],DI
M003_L_5F1E:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-4],AX
   	     mov     DI,word ptr ES:[SI+0Ah]
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_5F39
   	     db	     0E9h
   	     dw	     0058Dh
M003_L_5F39:
   	     cmp     word ptr ES:[BX+0Ch],0
   	     jl	     short M003_L_5F95
   	     jg	     short M003_L_5F49
   	     cmp     word ptr ES:[BX+0Ah],0
   	     jbe     short M003_L_5F95
M003_L_5F49:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[BX+0Ch]
   	     push    word ptr ES:[BX+0Ah]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     011FEh
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     jne     short M003_L_5F6B
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     00561h
M003_L_5F6B:
   	     cmp     word ptr [BP-2],0
   	     jg	     short M003_L_5F74
   	     db	     0E9h
   	     dw	     00552h
M003_L_5F74:
   	     mov     AX,word ptr [BP-2]
   	     cwd
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[BX+0Ch],DX
   	     mov     word ptr ES:[BX+0Ah],AX
   	     mov     word ptr ES:[BX+2],2
   	     mov     word ptr ES:[SI],0Dh
   	     db	     0E9h
   	     dw	     00531h
M003_L_5F95:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     je	     short M003_L_5FA9
   	     db	     0E9h
   	     dw	     0051Dh
M003_L_5FA9:
   	     cmp     word ptr ES:[DI],2
   	     jne     short M003_L_5FB2
   	     db	     0E9h
   	     dw	     00514h
M003_L_5FB2:
   	     mov     word ptr ES:[SI],2Ah
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00510h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_5FCC
   	     db	     0E9h
   	     dw	     004FAh
M003_L_5FCC:
   	     cmp     word ptr ES:[BX+0Ch],0
   	     jge     short M003_L_5FD6
   	     db	     0E9h
   	     dw	     004F0h
M003_L_5FD6:
   	     jg	     short M003_L_5FE2
   	     cmp     word ptr ES:[BX+0Ah],0
   	     ja	     short M003_L_5FE2
   	     db	     0E9h
   	     dw	     004E4h
M003_L_5FE2:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[BX+0Ch]
   	     push    word ptr ES:[BX+0Ah]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     01165h
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     jne     short M003_L_6004
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     004C8h
M003_L_6004:
   	     cmp     word ptr [BP-2],0
   	     jg	     short M003_L_600D
   	     db	     0E9h
   	     dw	     004B9h
M003_L_600D:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     jne     short M003_L_601F
   	     db	     0E9h
   	     dw	     004A7h
M003_L_601F:
   	     mov     AX,word ptr [BP-2]
   	     cwd
   	     mov     BX,word ptr [BP-4]
   	     mov     word ptr ES:[BX+0Ch],DX
   	     mov     word ptr ES:[BX+0Ah],AX
   	     mov     word ptr ES:[BX+2],2
   	     mov     word ptr ES:[SI],0Eh
   	     db	     0E9h
   	     dw	     0048Ah
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_604C
   	     db	     0E9h
   	     dw	     0047Ah
M003_L_604C:
   	     cmp     word ptr ES:[BX+0Ch],0
   	     jge     short M003_L_6056
   	     db	     0E9h
   	     dw	     00470h
M003_L_6056:
   	     jg	     short M003_L_6062
   	     cmp     word ptr ES:[BX+0Ah],0
   	     ja	     short M003_L_6062
   	     db	     0E9h
   	     dw	     00464h
M003_L_6062:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     push    word ptr ES:[BX+0Ch]
   	     push    word ptr ES:[BX+0Ah]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     010E5h
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     jne     short M003_L_6098
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[BX+0Ch],0
   	     mov     word ptr ES:[BX+0Ah],0
   	     mov     AX,word ptr [BP-4]
   	     db	     0E9h
   	     dw	     00434h
M003_L_6098:
   	     cmp     word ptr [BP-2],0
   	     jg	     short M003_L_60A1
   	     db	     0E9h
   	     dw	     00425h
M003_L_60A1:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     jne     short M003_L_60B3
   	     db	     0E9h
   	     dw	     00413h
M003_L_60B3:
   	     mov     BX,word ptr [BP-4]
   	     sub     word ptr ES:[BX+0Ah],1
   	     sbb     word ptr ES:[BX+0Ch],0
   	     mov     word ptr ES:[SI],0Fh
   	     db	     0E9h
   	     dw	     003FEh
   	     push    DI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     010E2h
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],32h
   	     jne     short M003_L_6104
   	     push    word ptr ES:[DI+0Ah]
   	     db	     09Ah
   	     dw	     X04C_06
   	     dw	     seg X04C_06
   	     or	     AX,AX
   	     je	     short M003_L_6104
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     DI,word ptr ES:[DI+0Ah]
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     003C8h
M003_L_6104:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],DI
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     003BBh
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],31h
   	     jne     short M003_L_612B
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr ES:[SI+8]
   	     db	     09Ah
   	     dw	     X04C_0D
   	     dw	     seg X04C_0D
   	     db	     0E9h
   	     dw	     003A1h
M003_L_612B:
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0039Ch
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr [BP-8],AX
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M003_L_615A
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     jne     short M003_L_615A
   	     push    DI
   	     push    word ptr [BP-8]
   	     db	     09Ah
   	     dw	     X04C_0D
   	     dw	     seg X04C_0D
   	     db	     0E9h
   	     dw	     00372h
M003_L_615A:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],32h
   	     jne     short M003_L_61A8
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M003_L_61A2
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     cmp     word ptr ES:[BX],1
   	     je	     short M003_L_6184
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     cmp     word ptr ES:[BX],5
   	     je	     short M003_L_6184
   	     db	     0E9h
   	     dw	     00342h
M003_L_6184:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     mov     word ptr [BP-6],AX
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     mov     BX,word ptr [BP-6]
   	     add     word ptr ES:[BX+0Ch],AX
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     0032Ah
M003_L_61A2:
   	     push    DI
   	     push    word ptr [BP-4]
   	     jmp     short M003_L_61B9
M003_L_61A8:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],32h
   	     jne     short M003_L_61BC
   	     push    word ptr [BP-4]
   	     push    DI
M003_L_61B9:
   	     db	     0E8h
   	     dw	     00E55h
M003_L_61BC:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],2
   	     je	     short M003_L_61CC
   	     cmp     word ptr ES:[DI],32h
   	     jne     short M003_L_61D8
M003_L_61CC:
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr [BP-6],AX
   	     mov     word ptr [BP-4],DI
   	     mov     DI,word ptr [BP-6]
M003_L_61D8:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     word ptr ES:[SI+0Ah],DI
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_61FA
   	     push    SI
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     00ACCh
   	     db	     0E9h
   	     dw	     002D2h
M003_L_61FA:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_6214
   	     push    SI
   	     push    word ptr [BP-4]
   	     push    DI
   	     db	     0E8h
   	     dw	     00AB2h
   	     db	     0E9h
   	     dw	     002B8h
M003_L_6214:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_6224
   	     db	     0E9h
   	     dw	     002A2h
M003_L_6224:
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     je	     short M003_L_6231
   	     db	     0E9h
   	     dw	     00295h
M003_L_6231:
   	     mov     AX,word ptr ES:[DI+2]
   	     cmp     AX,word ptr ES:[SI+2]
   	     je	     short M003_L_6247
   	     push    DI
   	     push    word ptr ES:[SI+8]
   	     db	     09Ah
   	     dw	     X04C_0D
   	     dw	     seg X04C_0D
   	     mov     DI,AX
M003_L_6247:
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     00280h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_6263
   	     push    SI
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     00A63h
   	     db	     0E9h
   	     dw	     00269h
M003_L_6263:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr ES:[SI]
   	     je	     short M003_L_6275
   	     db	     0E9h
   	     dw	     00251h
M003_L_6275:
   	     push    SI
   	     push    word ptr [BP-4]
   	     push    DI
   	     db	     0E8h
   	     dw	     00A46h
   	     db	     0E9h
   	     dw	     0024Ch
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_6297
   	     push    SI
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     00A2Fh
   	     db	     0E9h
   	     dw	     00235h
M003_L_6297:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M003_L_62B1
   	     push    SI
   	     push    word ptr [BP-4]
   	     push    DI
   	     db	     0E8h
   	     dw	     00A15h
   	     db	     0E9h
   	     dw	     0021Bh
M003_L_62B1:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_62C1
   	     db	     0E9h
   	     dw	     00205h
M003_L_62C1:
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     je	     short M003_L_62CE
   	     db	     0E9h
   	     dw	     001F8h
M003_L_62CE:
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     001F9h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_62E3
   	     db	     0E9h
   	     dw	     001E3h
M003_L_62E3:
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     je	     short M003_L_62F0
   	     db	     0E9h
   	     dw	     001D6h
M003_L_62F0:
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     001C7h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M003_L_6315
   	     db	     0E9h
   	     dw	     001B1h
M003_L_6315:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     jne     short M003_L_632B
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     001A1h
M003_L_632B:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],32h
   	     jne     short M003_L_6361
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     cmp     word ptr ES:[BX],1
   	     je	     short M003_L_6349
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     cmp     word ptr ES:[BX],5
   	     jne     short M003_L_6361
M003_L_6349:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     SI,word ptr ES:[DI+0Ah]
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     sub     word ptr ES:[SI+0Ch],AX
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     0016Bh
M003_L_6361:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M003_L_6373
   	     db	     0E9h
   	     dw	     00153h
M003_L_6373:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     DX,word ptr ES:[BX+0Ah]
   	     neg     AX
   	     neg     DX
   	     sbb     AX,0
   	     mov     word ptr ES:[BX+0Ch],AX
   	     mov     word ptr ES:[BX+0Ah],DX
   	     mov     word ptr ES:[SI],8
   	     cmp     word ptr ES:[DI],8
   	     je	     short M003_L_639F
   	     db	     0E9h
   	     dw	     00127h
M003_L_639F:
   	     push    SI
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     0091Ch
   	     db	     0E9h
   	     dw	     00122h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],2
   	     jne     short M003_L_63D6
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     or	     AX,word ptr ES:[DI+0Ch]
   	     je	     short M003_L_63C8
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     db	     0E9h
   	     dw	     00104h
M003_L_63C8:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     db	     0E9h
   	     dw	     000F6h
M003_L_63D6:
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     000F1h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     BX,word ptr ES:[BX]
   	     sub     BX,1Dh
   	     cmp     BX,5
   	     jbe     short M003_L_63F1
   	     db	     0E9h
   	     dw	     000D5h
M003_L_63F1:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     9C4h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     SI,word ptr ES:[SI+0Ah]
   	     push    word ptr ES:[SI]
   	     db	     09Ah
   	     dw	     X057_01
   	     dw	     seg X057_01
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     000B8h
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI+2],0Fh
   	     je	     short M003_L_6422
   	     db	     0E9h
   	     dw	     000A4h
M003_L_6422:
   	     mov     AX,6
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     mov     word ptr [BP-0Ah],AX
   	     push    DI
   	     push    word ptr [BP-0Ah]
   	     db	     09Ah
   	     dw	     X04C_0D
   	     dw	     seg X04C_0D
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-0Ah]
   	     db	     09Ah
   	     dw	     X04C_0D
   	     dw	     seg X04C_0D
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     word ptr ES:[SI+2],6
   	     jmp     short M003_L_64C6
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr [BP-4]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M003_L_6494
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     or	     AX,word ptr ES:[BX+0Ch]
   	     jne     short M003_L_6494
   	     push    DI
   	     db	     09Ah
   	     dw	     X04C_04
   	     dw	     seg X04C_04
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     BX,word ptr [BP-4]
   	     mov     word ptr ES:[BX+2],AX
   	     jmp     short M003_L_64C6
M003_L_6494:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],2
   	     jne     short M003_L_64C6
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     or	     AX,word ptr ES:[DI+0Ch]
   	     jne     short M003_L_64C6
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X04C_04
   	     dw	     seg X04C_04
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr ES:[DI+2],AX
M003_L_64C6:
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0006Ah
M003_L_64CC:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_5DF2    endp
CO049_TEXT	     ends

; END STOVR5
; BEGIN STOVTBL2 (listing ovr_1d02_95b1:64D4)
CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT

BCC_TABLE_64D4  label   word
   	     dw	     008E8h
   	     dw	     008E8h
   	     dw	     008E8h
   	     dw	     008E8h
   	     dw	     008E8h
   	     dw	     008E8h
   	     dw	     00620h
   	     dw	     007F5h
   	     dw	     003C6h
   	     dw	     004ACh
   	     dw	     0052Ch
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     0073Ch
   	     dw	     00770h
   	     dw	     00770h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     00950h
   	     dw	     00950h
   	     dw	     00904h
   	     dw	     00904h
   	     dw	     00904h
   	     dw	     00904h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     0089Ah
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     007C3h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     009B6h
   	     dw	     008CBh
   	     dw	     005B8h
   	     dw	     00601h

CO049_TEXT	     ends
; END STOVTBL2
; BEGIN STOVR6 (listing ovr_1d02_95b1:6536)

   	     extrn   BCC_FAR_02C9:far
   	     extrn   BCC_FAR_02CD:far
   	     extrn   BCC_FAR_02D2:far
   	     extrn   BCC_FAR_02D7:far
   	     extrn   BCC_FAR_036C:far
   	     extrn   BCC_FAR_038B:far
   	     extrn   BCC_FAR_03A9:far
   	     extrn   BCC_FAR_03E3:far
   	     extrn   BCC_FAR_5BED:far
   	     extrn   BCC_FAR_992F:far
   	     extrn   BCC_FAR_9949:far
   	     extrn   BCC_FAR_9963:far
   	     extrn   BCC_FAR_9B4E:far
   	     extrn   BCC_FAR_9DA4:far
   	     extrn   BCC_FAR_B0F1:far
   	     extrn   X04E_00:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M005_BCC_DATA_80B4	     equ     80B4h
M005_BCC_DATA_80F0	     equ     80F0h
M005_BCC_DATA_8108	     equ     8108h
M005_BCC_DATA_8186	     equ     8186h

   	     public  X049_01
X049_01 label   far
BCC_NEAR_6536   label   near
BCC_FAR_6536    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,20h
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     DI,word ptr ES:[SI+0Ah]
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr ES:[DI],3
   	     je	     short M005_L_6559
   	     db	     0E9h
   	     dw	     0019Ch
M005_L_6559:
   	     cmp     word ptr [BP-2],0
   	     je	     short M005_L_656B
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],3
   	     je	     short M005_L_656B
   	     db	     0E9h
   	     dw	     0018Ah
M005_L_656B:
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     AX,DI
   	     add     AX,0Ah
   	     push    AX
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     cmp     word ptr [BP-2],0
   	     je	     short M005_L_65A2
   	     push    SS
   	     lea     AX,[BP-20h]
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     add     AX,0Ah
   	     push    AX
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
M005_L_65A2:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     cmp     BX,1Eh
   	     je	     short M005_L_65EF
   	     jg	     short M005_L_65DD
   	     cmp     BX,0Ah
   	     jne     short M005_L_65B8
   	     db	     0E9h
   	     dw	     000F4h
M005_L_65B8:
   	     jg	     short M005_L_65CD
   	     cmp     BX,8
   	     jne     short M005_L_65C2
   	     db	     0E9h
   	     dw	     000C8h
M005_L_65C2:
   	     cmp     BX,9
   	     jne     short M005_L_65CA
   	     db	     0E9h
   	     dw	     000D1h
M005_L_65CA:
   	     db	     0E9h
   	     dw	     00108h
M005_L_65CD:
   	     cmp     BX,0Bh
   	     jne     short M005_L_65D5
   	     db	     0E9h
   	     dw	     000E8h
M005_L_65D5:
   	     cmp     BX,1Dh
   	     je	     short M005_L_65EF
   	     db	     0E9h
   	     dw	     000F8h
M005_L_65DD:
   	     sub     BX,1Fh
   	     cmp     BX,0Fh
   	     jbe     short M005_L_65E8
   	     db	     0E9h
   	     dw	     000EDh
M005_L_65E8:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     1187h
M005_L_65EF:
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-20h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9DA4
   	     dw	     seg BCC_FAR_9DA4
   	     mov     word ptr [BP-8],AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     sub     BX,1Dh
   	     cmp     BX,5
   	     ja	     short M005_L_6672
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     117Bh
   	     cmp     word ptr [BP-8],0
   	     jne     short M005_L_6622
   	     mov     AX,1
   	     jmp     short M005_L_666F
M005_L_6622:
   	     jmp     short M005_L_666D
   	     jmp     short M005_L_666F
   	     cmp     word ptr [BP-8],0
   	     je	     short M005_L_6631
   	     mov     AX,1
   	     jmp     short M005_L_666F
M005_L_6631:
   	     jmp     short M005_L_666D
   	     jmp     short M005_L_666F
   	     cmp     word ptr [BP-8],0
   	     jle     short M005_L_6640
   	     mov     AX,1
   	     jmp     short M005_L_666F
M005_L_6640:
   	     jmp     short M005_L_666D
   	     jmp     short M005_L_666F
   	     cmp     word ptr [BP-8],0
   	     jge     short M005_L_664F
   	     mov     AX,1
   	     jmp     short M005_L_666F
M005_L_664F:
   	     jmp     short M005_L_666D
   	     jmp     short M005_L_666F
   	     cmp     word ptr [BP-8],0
   	     jl	     short M005_L_665E
   	     mov     AX,1
   	     jmp     short M005_L_666F
M005_L_665E:
   	     jmp     short M005_L_666D
   	     jmp     short M005_L_666F
   	     cmp     word ptr [BP-8],0
   	     jg	     short M005_L_666D
   	     mov     AX,1
   	     jmp     short M005_L_666F
M005_L_666D:
   	     xor     AX,AX
M005_L_666F:
   	     mov     word ptr [BP-8],AX
M005_L_6672:
   	     mov     AX,5
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     push    AX
   	     mov     AX,word ptr [BP-8]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B4h
   	     mov     DI,AX
   	     db	     0E9h
   	     dw	     005A5h
M005_L_668A:
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-20h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_992F
   	     dw	     seg BCC_FAR_992F
   	     jmp     short M005_L_66DA
M005_L_669B:
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-20h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9949
   	     dw	     seg BCC_FAR_9949
   	     jmp     short M005_L_66DA
M005_L_66AC:
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-20h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9963
   	     dw	     seg BCC_FAR_9963
   	     jmp     short M005_L_66DA
M005_L_66BD:
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-20h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9B4E
   	     dw	     seg BCC_FAR_9B4E
   	     jmp     short M005_L_66DA
   	     xor     word ptr [BP-0Eh],8000h
   	     jmp     short M005_L_66DA
M005_L_66D5:
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00557h
M005_L_66DA:
   	     push    word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     AX,DI
   	     add     AX,0Ah
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-16h]
   	     push    AX
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     db	     0E9h
   	     dw	     0053Ah
M005_L_66F5:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],2
   	     jne     short M005_L_670E
   	     cmp     word ptr [BP-2],0
   	     je	     short M005_L_6713
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M005_L_6713
M005_L_670E:
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0051Eh
M005_L_6713:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI+0Ch]
   	     mov     DX,word ptr ES:[DI+0Ah]
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],DX
   	     cmp     word ptr [BP-2],0
   	     je	     short M005_L_673C
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     DX,word ptr ES:[BX+0Ah]
   	     mov     word ptr [BP-0Ah],AX
   	     mov     word ptr [BP-0Ch],DX
M005_L_673C:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     sub     BX,8
   	     cmp     BX,28h
   	     jbe     short M005_L_674E
   	     db	     0E9h
   	     dw	     004AFh
M005_L_674E:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     1129h
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     DX,word ptr [BP-0Ch]
   	     add     word ptr [BP-6],DX
   	     adc     word ptr [BP-4],AX
   	     jo	     short M005_L_6766
   	     db	     0E9h
   	     dw	     0049Bh
M005_L_6766:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,20h
   	     je	     short M005_L_677C
   	     db	     0E9h
   	     dw	     00485h
M005_L_677C:
   	     db	     0E8h
   	     dw	     00538h
   	     mov     word ptr [BP-4],0
   	     mov     word ptr [BP-6],1
   	     db	     0E9h
   	     dw	     00475h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     cmp     word ptr ES:[DI+2],0Eh
   	     jne     short M005_L_67AB
   	     mov     AX,word ptr [BP-6]
   	     xor     DX,DX
   	     add     DX,word ptr [BP-0Ch]
   	     adc     AX,word ptr [BP-0Ah]
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],DX
   	     db	     0E9h
   	     dw	     00456h
M005_L_67AB:
   	     mov     AX,word ptr [BP-0Ch]
   	     xor     DX,DX
   	     add     DX,word ptr [BP-6]
   	     adc     AX,word ptr [BP-4]
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],DX
   	     db	     0E9h
   	     dw	     00442h
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     DX,word ptr [BP-0Ch]
   	     sub     word ptr [BP-6],DX
   	     sbb     word ptr [BP-4],AX
   	     jo	     short M005_L_67D0
   	     db	     0E9h
   	     dw	     00431h
M005_L_67D0:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,20h
   	     je	     short M005_L_67E6
   	     db	     0E9h
   	     dw	     0041Bh
M005_L_67E6:
   	     db	     0E8h
   	     dw	     004CEh
   	     mov     word ptr [BP-4],0
   	     mov     word ptr [BP-6],1
   	     db	     0E9h
   	     dw	     0040Bh
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,20h
   	     jne     short M005_L_6835
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-0Ch]
   	     db	     09Ah
   	     dw	     X04E_00
   	     dw	     seg X04E_00
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     jo	     short M005_L_6825
   	     db	     0E9h
   	     dw	     003DCh
M005_L_6825:
   	     db	     0E8h
   	     dw	     0048Fh
   	     mov     word ptr [BP-4],0
   	     mov     word ptr [BP-6],1
   	     db	     0E9h
   	     dw	     003CCh
M005_L_6835:
   	     mov     CX,word ptr [BP-0Ah]
   	     mov     BX,word ptr [BP-0Ch]
   	     mov     DX,word ptr [BP-4]
   	     mov     AX,word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_03A9
   	     dw	     seg BCC_FAR_03A9
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     003B2h
   	     mov     AX,word ptr [BP-0Ch]
   	     or	     AX,word ptr [BP-0Ah]
   	     jne     short M005_L_6865
   	     mov     AX,17Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5BED
   	     dw	     seg BCC_FAR_5BED
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     0039Ch
M005_L_6865:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_688E
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_02CD
   	     dw	     seg BCC_FAR_02CD
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00373h
M005_L_688E:
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_02C9
   	     dw	     seg BCC_FAR_02C9
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00359h
   	     mov     AX,word ptr [BP-0Ch]
   	     or	     AX,word ptr [BP-0Ah]
   	     jne     short M005_L_68BE
   	     mov     AX,17Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5BED
   	     dw	     seg BCC_FAR_5BED
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     00343h
M005_L_68BE:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_68E7
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_02D7
   	     dw	     seg BCC_FAR_02D7
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     0031Ah
M005_L_68E7:
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-0Ch]
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_02D2
   	     dw	     seg BCC_FAR_02D2
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00300h
   	     mov     CL,byte ptr [BP-0Ch]
   	     mov     DX,word ptr [BP-4]
   	     mov     AX,word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_036C
   	     dw	     seg BCC_FAR_036C
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     002E9h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_693E
   	     mov     DX,word ptr [BP-4]
   	     mov     AX,word ptr [BP-6]
   	     mov     CL,byte ptr [BP-0Ch]
   	     db	     09Ah
   	     dw	     BCC_FAR_03E3
   	     dw	     seg BCC_FAR_03E3
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     002C3h
M005_L_693E:
   	     mov     CL,byte ptr [BP-0Ch]
   	     mov     DX,word ptr [BP-4]
   	     mov     AX,word ptr [BP-6]
   	     db	     09Ah
   	     dw	     BCC_FAR_038B
   	     dw	     seg BCC_FAR_038B
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     002ACh
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     DX,word ptr [BP-0Ch]
   	     and     word ptr [BP-6],DX
   	     and     word ptr [BP-4],AX
   	     db	     0E9h
   	     dw	     0029Dh
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     DX,word ptr [BP-0Ch]
   	     or	     word ptr [BP-6],DX
   	     or	     word ptr [BP-4],AX
   	     db	     0E9h
   	     dw	     0028Eh
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     DX,word ptr [BP-0Ch]
   	     xor     word ptr [BP-6],DX
   	     xor     word ptr [BP-4],AX
   	     db	     0E9h
   	     dw	     0027Fh
   	     mov     AX,word ptr [BP-6]
   	     neg     AX
   	     sbb     AX,AX
   	     inc     AX
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     0026Dh
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     neg     AX
   	     neg     DX
   	     sbb     AX,0
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],DX
   	     db	     0E9h
   	     dw	     00257h
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     not     DX
   	     not     AX
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],DX
   	     db	     0E9h
   	     dw	     00244h
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jne     short M005_L_69D2
   	     cmp     DX,word ptr [BP-0Ch]
   	     jne     short M005_L_69D2
   	     mov     AX,1
   	     jmp     short M005_L_69D4
M005_L_69D2:
   	     xor     AX,AX
M005_L_69D4:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00223h
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jne     short M005_L_69EE
   	     cmp     DX,word ptr [BP-0Ch]
   	     je	     short M005_L_69F3
M005_L_69EE:
   	     mov     AX,1
   	     jmp     short M005_L_69F5
M005_L_69F3:
   	     xor     AX,AX
M005_L_69F5:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00202h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_6A31
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     ja	     short M005_L_6A25
   	     jc	     short M005_L_6A20
   	     cmp     DX,word ptr [BP-0Ch]
   	     jnc     short M005_L_6A25
M005_L_6A20:
   	     mov     AX,1
   	     jmp     short M005_L_6A27
M005_L_6A25:
   	     xor     AX,AX
M005_L_6A27:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     001D0h
M005_L_6A31:
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jg	     short M005_L_6A48
   	     jl	     short M005_L_6A43
   	     cmp     DX,word ptr [BP-0Ch]
   	     jnc     short M005_L_6A48
M005_L_6A43:
   	     mov     AX,1
   	     jmp     short M005_L_6A4A
M005_L_6A48:
   	     xor     AX,AX
M005_L_6A4A:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     001ADh
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_6A86
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jc	     short M005_L_6A7A
   	     ja	     short M005_L_6A75
   	     cmp     DX,word ptr [BP-0Ch]
   	     jbe     short M005_L_6A7A
M005_L_6A75:
   	     mov     AX,1
   	     jmp     short M005_L_6A7C
M005_L_6A7A:
   	     xor     AX,AX
M005_L_6A7C:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     0017Bh
M005_L_6A86:
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jl	     short M005_L_6A9D
   	     jg	     short M005_L_6A98
   	     cmp     DX,word ptr [BP-0Ch]
   	     jbe     short M005_L_6A9D
M005_L_6A98:
   	     mov     AX,1
   	     jmp     short M005_L_6A9F
M005_L_6A9D:
   	     xor     AX,AX
M005_L_6A9F:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00158h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_6ADB
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     ja	     short M005_L_6ACF
   	     jne     short M005_L_6ACA
   	     cmp     DX,word ptr [BP-0Ch]
   	     ja	     short M005_L_6ACF
M005_L_6ACA:
   	     mov     AX,1
   	     jmp     short M005_L_6AD1
M005_L_6ACF:
   	     xor     AX,AX
M005_L_6AD1:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00126h
M005_L_6ADB:
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jg	     short M005_L_6AF2
   	     jne     short M005_L_6AED
   	     cmp     DX,word ptr [BP-0Ch]
   	     ja	     short M005_L_6AF2
M005_L_6AED:
   	     mov     AX,1
   	     jmp     short M005_L_6AF4
M005_L_6AF2:
   	     xor     AX,AX
M005_L_6AF4:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00103h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M005_L_6B30
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jc	     short M005_L_6B24
   	     jne     short M005_L_6B1F
   	     cmp     DX,word ptr [BP-0Ch]
   	     jc	     short M005_L_6B24
M005_L_6B1F:
   	     mov     AX,1
   	     jmp     short M005_L_6B26
M005_L_6B24:
   	     xor     AX,AX
M005_L_6B26:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     000D1h
M005_L_6B30:
   	     mov     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jl	     short M005_L_6B47
   	     jne     short M005_L_6B42
   	     cmp     DX,word ptr [BP-0Ch]
   	     jc	     short M005_L_6B47
M005_L_6B42:
   	     mov     AX,1
   	     jmp     short M005_L_6B49
M005_L_6B47:
   	     xor     AX,AX
M005_L_6B49:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     000AEh
   	     cmp     word ptr [BP-6],0
   	     je	     short M005_L_6B64
   	     cmp     word ptr [BP-0Ch],0
   	     je	     short M005_L_6B64
   	     mov     AX,1
   	     jmp     short M005_L_6B66
M005_L_6B64:
   	     xor     AX,AX
M005_L_6B66:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     db	     0E9h
   	     dw	     00091h
   	     cmp     word ptr [BP-6],0
   	     jne     short M005_L_6B7C
   	     cmp     word ptr [BP-0Ch],0
   	     je	     short M005_L_6B81
M005_L_6B7C:
   	     mov     AX,1
   	     jmp     short M005_L_6B83
M005_L_6B81:
   	     xor     AX,AX
M005_L_6B83:
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     jmp     short M005_L_6C01
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0Dh
   	     jne     short M005_L_6BA6
   	     mov     AX,word ptr [BP-6]
   	     sub     AX,word ptr [BP-0Ch]
   	     cwd
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     jmp     short M005_L_6C01
M005_L_6BA6:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],10h
   	     jne     short M005_L_6BE1
   	     mov     AX,word ptr [BP-4]
   	     mov     CL,0Ch
   	     shl     AX,CL
   	     add     AX,word ptr [BP-6]
   	     mov     word ptr [BP-4],0
   	     mov     word ptr [BP-6],AX
   	     mov     AX,word ptr [BP-0Ah]
   	     shl     AX,CL
   	     add     AX,word ptr [BP-0Ch]
   	     mov     word ptr [BP-0Ah],0
   	     mov     word ptr [BP-0Ch],AX
   	     mov     AX,word ptr [BP-0Ah]
   	     mov     DX,word ptr [BP-0Ch]
   	     sub     word ptr [BP-6],DX
   	     sbb     word ptr [BP-4],AX
   	     jmp     short M005_L_6C01
M005_L_6BE1:
   	     mov     AX,word ptr [BP-6]
   	     and     AX,0FFFFh
   	     xor     DX,DX
   	     mov     BX,word ptr [BP-0Ch]
   	     db	     081h,0E3h,0FFh,0FFh
   	     sub     AX,BX
   	     sbb     DX,0
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     jmp     short M005_L_6C01
M005_L_6BFD:
   	     mov     AX,SI
   	     jmp     short M005_L_6C31
M005_L_6C01:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     push    word ptr ES:[DI+2]
   	     db	     0FFh,01Eh
   	     dw	     80F0h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     word ptr ES:[DI+0Ch],DX
   	     mov     word ptr ES:[DI+0Ah],AX
M005_L_6C2F:
   	     mov     AX,DI
M005_L_6C31:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_6536    endp
CO049_TEXT	     ends

; END STOVR6
; BEGIN STOVTBL3 (listing ovr_1d02_95b1:6C39)
CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT

BCC_TABLE_6C39  label   word
   	     dw	     00C45h
   	     dw	     00CAFh
   	     dw	     00CE6h
   	     dw	     00D3Fh
   	     dw	     00D98h
   	     dw	     00DF1h
   	     dw	     00E08h
   	     dw	     00E45h
   	     dw	     00E54h
   	     dw	     00E63h
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     00EADh
   	     dw	     00ECEh
   	     dw	     00F44h
   	     dw	     00EEFh
   	     dw	     00FEEh
   	     dw	     00F99h
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     01043h
   	     dw	     01060h
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     010EDh
   	     dw	     0107Ch
   	     dw	     00C7Ch
   	     dw	     00E84h
   	     dw	     00E9Ah
   	     dw	     00E72h
   	     dw	     00B07h
   	     dw	     00B16h
   	     dw	     00B25h
   	     dw	     00B34h
   	     dw	     00B43h
   	     dw	     00B52h
   	     dw	     00ADFh
   	     dw	     00ADFh
   	     dw	     00ADFh
   	     dw	     00ADFh
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BC5h
   	     dw	     00BBEh

CO049_TEXT	     ends
; END STOVTBL3
; BEGIN STOVR7 (listing ovr_1d02_95b1:6CB7)


   	     extrn   BCC_FAR_5B8B:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

BCC_NEAR_6CB7   proc    near
   	     mov     AX,4Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     ret
BCC_NEAR_6CB7   endp
CO049_TEXT	     ends

; END STOVR7
; BEGIN STOVR8 (listing ovr_1d02_95b1:6CC3)



CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M008_BCC_DATA_8186	     equ     8186h

BCC_NEAR_6CC3   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,8
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     mov     DI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI]
   	     mov     word ptr [BP-8],AX
   	     mov     word ptr ES:[SI+0Ah],DI
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,word ptr ES:[DI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M008_L_6CFA
   	     db	     0E9h
   	     dw	     0008Ah
M008_L_6CFA:
   	     cmp     word ptr ES:[BX],32h
   	     jne     short M008_L_6D03
   	     db	     0E9h
   	     dw	     00081h
M008_L_6D03:
   	     mov     BX,word ptr [BP+4]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr [BP-8]
   	     jne     short M008_L_6D81
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+2]
   	     test    byte ptr [BX+9CAh],15h
   	     je	     short M008_L_6D81
   	     mov     BX,word ptr [BP+4]
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     mov     word ptr [BP-4],AX
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     word ptr [BP-6],AX
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],14h
   	     jne     short M008_L_6D47
   	     mov     BX,word ptr [BP-6]
   	     mov     BX,word ptr ES:[BX+2]
   	     test    byte ptr [BX+9CAh],14h
   	     je	     short M008_L_6D5E
M008_L_6D47:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     BX,word ptr [BP+4]
   	     mov     word ptr ES:[BX+2],AX
   	     mov     AX,word ptr ES:[DI+8]
   	     mov     word ptr ES:[BX+8],AX
M008_L_6D5E:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr [BP-6]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     BX,word ptr [BP+4]
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr ES:[BX+0Ch],AX
   	     mov     word ptr ES:[BX+0Ah],DI
   	     db	     0E9h
   	     dw	     00285h
M008_L_6D81:
   	     db	     0E9h
   	     dw	     00282h
M008_L_6D84:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr [BP+4]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M008_L_6DED
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     mov     BX,word ptr ES:[BX+2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,14h
   	     jne     short M008_L_6DC3
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr ES:[SI+2],AX
   	     mov     AX,word ptr ES:[BX+8]
   	     mov     word ptr ES:[SI+8],AX
M008_L_6DC3:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     push    SI
   	     push    CS
   	     db	     0E8h
   	     dw	     0F01Fh
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[DI+0Ch],SI
   	     push    word ptr ES:[DI+0Ch]
   	     push    word ptr ES:[DI+0Ah]
   	     db	     0E8h
   	     dw	     00229h
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     0021Bh
M008_L_6DED:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr [BP+4]
   	     cmp     word ptr ES:[BX],32h
   	     jne     short M008_L_6E50
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M008_L_6E3E
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     push    SI
   	     push    CS
   	     db	     0E8h
   	     dw	     0EFDCh
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[DI+0Ch],AX
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     push    word ptr ES:[DI+0Ch]
   	     push    word ptr ES:[DI+0Ah]
   	     db	     0E8h
   	     dw	     001D8h
   	     mov     AX,DI
   	     db	     0E9h
   	     dw	     001CAh
M008_L_6E3E:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     001C4h
   	     db	     0E9h
   	     dw	     001B6h
M008_L_6E50:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr [BP+4]
   	     mov     AX,word ptr ES:[BX]
   	     cmp     AX,word ptr [BP-8]
   	     je	     short M008_L_6EB2
   	     mov     BX,word ptr [BP-2]
   	     mov     BX,word ptr ES:[BX+2]
   	     test    byte ptr [BX+9CAh],14h
   	     jne     short M008_L_6E7B
   	     mov     BX,word ptr [BP+4]
   	     mov     BX,word ptr ES:[BX+2]
   	     test    byte ptr [BX+9CAh],14h
   	     je	     short M008_L_6E92
M008_L_6E7B:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[BX+8]
   	     mov     word ptr ES:[DI+8],AX
M008_L_6E92:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[DI+0Ch],AX
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     00162h
   	     db	     0E9h
   	     dw	     00154h
M008_L_6EB2:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     mov     word ptr [BP-4],AX
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     word ptr [BP-6],AX
   	     mov     BX,word ptr [BP-6]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M008_L_6ED3
   	     db	     0E9h
   	     dw	     00080h
M008_L_6ED3:
   	     cmp     word ptr ES:[BX],32h
   	     je	     short M008_L_6F53
   	     mov     BX,word ptr [BP-2]
   	     mov     BX,word ptr ES:[BX+2]
   	     test    byte ptr [BX+9CAh],14h
   	     je	     short M008_L_6EFC
   	     mov     BX,word ptr [BP-4]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[BX+8]
   	     mov     word ptr ES:[DI+8],AX
   	     jmp     short M008_L_6F1E
M008_L_6EFC:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],14h
   	     je	     short M008_L_6F1E
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     BX,word ptr [BP+4]
   	     mov     word ptr ES:[BX+2],AX
   	     mov     AX,word ptr ES:[DI+8]
   	     mov     word ptr ES:[BX+8],AX
M008_L_6F1E:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[BX+0Ah],DI
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr ES:[DI+0Ch],AX
   	     mov     AX,word ptr [BP-6]
   	     mov     word ptr ES:[BX+0Ch],AX
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     000C1h
   	     db	     0E9h
   	     dw	     000B3h
M008_L_6F53:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr [BP-6]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M008_L_6FC5
   	     mov     BX,word ptr ES:[DI+2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,14h
   	     je	     short M008_L_6F7D
   	     mov     BX,word ptr [BP-2]
   	     mov     BX,word ptr ES:[BX+2]
   	     test    byte ptr [BX+9CAh],14h
   	     je	     short M008_L_6F94
M008_L_6F7D:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr ES:[DI+2],AX
   	     mov     AX,word ptr ES:[BX+8]
   	     mov     word ptr ES:[DI+8],AX
M008_L_6F94:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[BX+0Ah],AX
   	     push    word ptr [BP+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0EE49h
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr ES:[DI+0Ch],AX
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0004Eh
   	     jmp     short M008_L_7006
M008_L_6FC5:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr [BP-2]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M008_L_7006
   	     mov     BX,word ptr [BP+4]
   	     mov     AX,word ptr [BP-6]
   	     mov     word ptr ES:[BX+0Ah],AX
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[BX+0Ch],AX
   	     push    word ptr [BP+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0EE08h
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr ES:[DI+0Ch],AX
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0000Dh
   	     jmp     short M008_L_7006
M008_L_7006:
   	     mov     AX,SI
M008_L_7008:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     6
BCC_NEAR_6CC3   endp
CO049_TEXT	     ends

; END STOVR8
; BEGIN STOVR9 (listing ovr_1d02_95b1:7011)

   	     extrn   BCC_FAR_03A9:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M009_BCC_DATA_8186	     equ     8186h

BCC_NEAR_7011   proc    near
M009_L_7011:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,6
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     cmp     word ptr ES:[DI],32h
   	     je	     short M009_L_702D
   	     db	     0E9h
   	     dw	     00125h
M009_L_702D:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     cmp     word ptr ES:[BX],1
   	     je	     short M009_L_7048
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     cmp     word ptr ES:[BX],5
   	     je	     short M009_L_7048
   	     db	     0E9h
   	     dw	     0010Ah
M009_L_7048:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,8
   	     je	     short M009_L_7061
   	     cmp     AX,0Ah
   	     je	     short M009_L_707C
   	     cmp     AX,0Dh
   	     je	     short M009_L_70CC
   	     db	     0E9h
   	     dw	     000F1h
M009_L_7061:
   	     push    DI
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFA4h
   	     push    DI
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FF98h
   	     db	     0E9h
   	     dw	     000D6h
M009_L_707C:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ch]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M009_L_708D
   	     db	     0E9h
   	     dw	     000C5h
M009_L_708D:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ch]
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     DX,word ptr ES:[BX+0Ah]
   	     mov     word ptr [BP-2],AX
   	     mov     word ptr [BP-4],DX
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-6],AX
   	     mov     BX,word ptr [BP-6]
   	     cmp     word ptr ES:[BX],8
   	     je	     short M009_L_70B6
   	     db	     0E9h
   	     dw	     0009Ch
M009_L_70B6:
   	     mov     BX,word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[BX+0Ch]
   	     cmp     word ptr ES:[BX],2
   	     je	     short M009_L_70CA
   	     db	     0E9h
   	     dw	     00088h
M009_L_70CA:
   	     jmp     short M009_L_7113
M009_L_70CC:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ch]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M009_L_7152
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ch]
   	     mov     CL,byte ptr ES:[BX+0Ah]
   	     mov     AX,1
   	     shl     AX,CL
   	     cwd
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-6],AX
   	     mov     BX,word ptr [BP-6]
   	     cmp     word ptr ES:[BX],8
   	     jne     short M009_L_7152
   	     mov     BX,word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[BX+0Ch]
   	     cmp     word ptr ES:[BX],2
   	     jne     short M009_L_7152
M009_L_7113:
   	     mov     BX,word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[BX+0Ch]
   	     mov     CX,word ptr ES:[BX+0Ch]
   	     mov     BX,word ptr ES:[BX+0Ah]
   	     mov     DX,word ptr [BP-2]
   	     mov     AX,word ptr [BP-4]
   	     db	     09Ah
   	     dw	     BCC_FAR_03A9
   	     dw	     seg BCC_FAR_03A9
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     mov     DX,word ptr ES:[BX+0Ch]
   	     add     DX,AX
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     mov     word ptr ES:[BX+0Ch],DX
   	     mov     BX,word ptr [BP-6]
   	     mov     AX,word ptr ES:[BX+0Ah]
   	     mov     word ptr ES:[SI+0Ah],AX
M009_L_7152:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7011   endp
CO049_TEXT	     ends

; END STOVR9
; BEGIN STOVR10 (listing ovr_1d02_95b1:715B)

CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP



   	     public  X049_04
X049_04 label   far
BCC_NEAR_715B   label   near
BCC_FAR_715B    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     AX,word ptr [BP+6]
   	     or	     AX,word ptr [BP+8]
   	     jne     short M00A_L_716C
   	     mov     AX,0FFFFh
   	     jmp     short M00A_L_71AB
M00A_L_716C:
   	     xor     SI,SI
   	     jmp     short M00A_L_7181
M00A_L_7170:
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     shr     AX,1
   	     rcr     DX,1
   	     mov     word ptr [BP+8],AX
   	     mov     word ptr [BP+6],DX
   	     inc     SI
M00A_L_7181:
   	     mov     AX,word ptr [BP+6]
   	     and     AX,1
   	     or	     AX,0
   	     je	     short M00A_L_7170
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     shr     AX,1
   	     rcr     DX,1
   	     mov     word ptr [BP+8],AX
   	     mov     word ptr [BP+6],DX
   	     mov     AX,word ptr [BP+6]
   	     or	     AX,word ptr [BP+8]
   	     je	     short M00A_L_71A9
   	     mov     AX,0FFFFh
   	     jmp     short M00A_L_71AB
M00A_L_71A9:
   	     mov     AX,SI
M00A_L_71AB:
   	     pop     SI
   	     pop     BP
   	     retf    4
BCC_FAR_715B    endp
CO049_TEXT	     ends

; END STOVR10
; BEGIN STOVR11 (listing ovr_1d02_95b1:71B0)

   	     extrn   X04F_02:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M00B_BCC_EXPR_SEGMENT   equ     639Ah
M00B_BCC_DATA_8186	     equ     8186h
M00B_BCC_DATA_82E6	     equ     82E6h

   	     public  X049_00
X049_00 label   far
BCC_NEAR_71B0   label   near
BCC_FAR_71B0    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     cmp     word ptr DGROUP:M00B_BCC_DATA_82E6,0
   	     je	     short M00B_L_71C2
   	     jmp     short M00B_L_71F8
M00B_L_71C2:
   	     push    SI
   	     db	     0E8h
   	     dw	     0010Eh
   	     mov     word ptr [BP-2],AX
   	     or	     AX,AX
   	     je	     short M00B_L_71F8
   	     push    SI
   	     mov     ES,word ptr DGROUP:M00B_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M00B_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+3]
   	     mov     AL,0Dh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X04F_02
   	     dw	     seg X04F_02
   	     push    AX
   	     db	     0E8h
   	     dw	     00010h
   	     push    SI
   	     push    CS
   	     db	     0E8h
   	     dw	     0EBFCh
   	     mov     SI,AX
M00B_L_71F8:
   	     mov     AX,SI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_71B0    endp
CO049_TEXT	     ends

; END STOVR11
; BEGIN STOVR12 (listing ovr_1d02_95b1:7201)

   	     extrn   BCC_FAR_0402:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M00C_BCC_EXPR_SEGMENT   equ     639Ah
M00C_BCC_DATA_8186	     equ     8186h

BCC_NEAR_7201   proc    near
M00C_L_7201:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     DI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M00C_L_7214
   	     db	     0E9h
   	     dw	     00095h
M00C_L_7214:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0Fh
   	     je	     short M00C_L_7222
   	     db	     0E9h
   	     dw	     00087h
M00C_L_7222:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     mov     BX,word ptr ES:[SI]
   	     cmp     BX,7
   	     je	     short M00C_L_72A9
   	     jg	     short M00C_L_7252
   	     dec     BX
   	     cmp     BX,5
   	     ja	     short M00C_L_728F
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     17B8h
M00C_L_7252:
   	     sub     BX,2Ah
   	     cmp     BX,0Bh
   	     ja	     short M00C_L_728F
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     17A0h
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX+2],0Dh
   	     jne     short M00C_L_72A9
   	     push    word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    SI
   	     push    word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     mov     CX,14h
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     jmp     short M00C_L_72A9
M00C_L_728F:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FF66h
   	     jmp     short M00C_L_729D
M00C_L_729D:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FF58h
M00C_L_72A9:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7201   endp
CO049_TEXT	     ends

; END STOVR12
; BEGIN STOVT13 (listing ovr_1d02_95b1:72B0)
CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT

BCC_TABLE_72B0  label   word
   	     dw	     0178Dh
   	     dw	     0177Fh
   	     dw	     0177Fh
   	     dw	     0177Fh
   	     dw	     0177Fh
   	     dw	     0177Fh
   	     dw	     0177Fh
   	     dw	     01799h
   	     dw	     01799h
   	     dw	     01799h
   	     dw	     0177Fh
   	     dw	     01751h
   	     dw	     01799h
   	     dw	     01799h
   	     dw	     01799h
   	     dw	     01799h
   	     dw	     01799h
   	     dw	     01799h

CO049_TEXT	     ends
; END STOVT13
; BEGIN STOVR14 (listing ovr_1d02_95b1:72D4)

   	     extrn   X047_03:far


CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT,ds:DGROUP

M00E_BCC_DATA_177A	     equ     177Ah
M00E_BCC_EXPR_SEGMENT   equ     639Ah
M00E_BCC_DATA_8186	     equ     8186h

BCC_NEAR_72D4   proc    near
M00E_L_72D4:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     je	     short M00E_L_72EC
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0Fh
   	     je	     short M00E_L_72F1
M00E_L_72EC:
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     000F6h
M00E_L_72F1:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     dec     BX
   	     cmp     BX,35h
   	     jbe     short M00E_L_7301
   	     db	     0E9h
   	     dw	     000C8h
M00E_L_7301:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     18DEh
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     000DAh
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX+2],0Dh
   	     jne     short M00E_L_7330
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     BX,word ptr ES:[BX+8]
   	     mov     ES,word ptr DGROUP:M00E_BCC_EXPR_SEGMENT
   	     mov     AL,byte ptr ES:[BX+8]
   	     cbw
   	     db	     0E9h
   	     dw	     000B7h
M00E_L_7330:
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     000B2h
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX],1
   	     jne     short M00E_L_736E
   	     push    word ptr ES:[SI+0Ah]
   	     db	     09Ah
   	     dw	     X047_03
   	     dw	     seg X047_03
   	     or	     AX,AX
   	     jne     short M00E_L_736A
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX+2],12h
   	     jne     short M00E_L_7365
   	     mov     AX,2
   	     db	     0E9h
   	     dw	     00082h
M00E_L_7365:
   	     mov     AX,4
   	     jmp     short M00E_L_73E7
M00E_L_736A:
   	     xor     AX,AX
   	     jmp     short M00E_L_73E7
M00E_L_736E:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX],36h
   	     je	     short M00E_L_7386
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX],31h
   	     jne     short M00E_L_738A
M00E_L_7386:
   	     xor     AX,AX
   	     jmp     short M00E_L_73E7
M00E_L_738A:
   	     cmp     byte ptr DGROUP:M00E_BCC_DATA_177A,0
   	     je	     short M00E_L_7396
   	     mov     AX,4
   	     jmp     short M00E_L_73E7
M00E_L_7396:
   	     mov     AX,3
   	     jmp     short M00E_L_73E7
   	     jmp     short M00E_L_73DC
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FF2Ch
   	     mov     DI,AX
   	     or	     DI,DI
   	     jne     short M00E_L_73B2
   	     xor     AX,AX
   	     jmp     short M00E_L_73E7
M00E_L_73B2:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FF17h
   	     cmp     AX,DI
   	     je	     short M00E_L_73C5
   	     xor     AX,AX
   	     jmp     short M00E_L_73E7
M00E_L_73C5:
   	     mov     AX,DI
   	     jmp     short M00E_L_73E7
M00E_L_73C9:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FF00h
   	     mov     DI,AX
   	     or	     DI,DI
   	     je	     short M00E_L_73DC
   	     jmp     short M00E_L_73E7
M00E_L_73DC:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FEEDh
M00E_L_73E7:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_72D4   endp
CO049_TEXT	     ends

; END STOVR14
; BEGIN STOVT15 (listing ovr_1d02_95b1:73EE)
CO049_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO049_TEXT

BCC_TABLE_73EE  label   word
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     017F8h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     0188Dh
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     017F8h
   	     dw	     0188Bh
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     018B9h
   	     dw	     017F8h
   	     dw	     01825h
   	     dw	     017F8h
   	     dw	     018B9h
   	     dw	     017FDh
   	     dw	     017F8h

CO049_TEXT	     ends
; END STOVT15
   	     end
