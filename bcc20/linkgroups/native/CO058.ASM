   	     public  X058_04
   	     public  X058_00
   	     public  X058_01
   	     public  X058_02
   	     public  X058_03
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d5a_a169
; BEGIN STAOV040 (listing ovr_1d5a_a169:1690)

   	     extrn   X043_03:far


CO058_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO058_TEXT,ds:DGROUP

M000_BCC_DATA_8680	     equ     8680h
M000_BCC_DATA_8698	     equ     8698h
M000_BCC_DATA_86F9	     equ     86F9h

   	     public  X058_01
X058_01 label   far
BCC_FAR_1690    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+8]
   	     push    DS
   	     mov     AX,8680h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     push    DS
   	     mov     AX,8698h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8680
   	     mov     AL,byte ptr [BP+0Ch]
   	     mov     byte ptr ES:[SI],AL
   	     mov     AL,byte ptr [BP+0Ah]
   	     mov     byte ptr ES:[SI+1],AL
   	     mov     AX,word ptr [BP+0Ch]
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,4
   	     or	     AX,0
   	     je	     short M000_L_16F0
   	     mov     BX,DI
   	     shl     BX,1
   	     shl     BX,1
   	     or	     byte ptr ES:[BX+1],4
M000_L_16F0:
   	     test    byte ptr [BP+0Ah],2
   	     je	     short M000_L_1705
   	     mov     BX,DI
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8680
   	     or	     byte ptr ES:[BX+1],1
M000_L_1705:
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,20h
   	     or	     AX,0
   	     jne     short M000_L_1742
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],1
   	     je	     short M000_L_1742
   	     or	     DI,DI
   	     je	     short M000_L_172C
   	     mov     BX,DI
   	     shl     BX,1
   	     shl     BX,1
   	     or	     byte ptr ES:[BX+1],8
M000_L_172C:
   	     cmp     word ptr [BP+6],0
   	     je	     short M000_L_1742
   	     mov     BX,word ptr [BP+6]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8680
   	     or	     byte ptr ES:[BX+1],8
M000_L_1742:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8680
   	     mov     word ptr ES:[SI+2],0
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8698
   	     mov     word ptr ES:[SI],DI
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+2],AX
   	     mov     AX,DGROUP:M000_BCC_DATA_86F9
   	     inc     word ptr DGROUP:M000_BCC_DATA_86F9
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    8
BCC_FAR_1690    endp
CO058_TEXT	     ends

; END STAOV040
; BEGIN STAOV041 (listing ovr_1d5a_a169:1769)

   	     extrn   X043_03:far
   	     extrn   X060_02:far


CO058_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO058_TEXT,ds:DGROUP

M001_BCC_DATA_8680	     equ     8680h
M001_BCC_DATA_8698	     equ     8698h
M001_BCC_DATA_86F9	     equ     86F9h

   	     public  X058_03
X058_03 label   far
BCC_FAR_1769    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DS
   	     mov     AX,8680h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     push    DS
   	     mov     AX,8698h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8680
   	     mov     AL,byte ptr [BP+0Ch]
   	     mov     byte ptr ES:[SI],AL
   	     mov     byte ptr ES:[SI+1],0
   	     mov     word ptr ES:[SI+2],0
   	     push    word ptr [BP+0Ah]
   	     mov     AL,0
   	     push    AX
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     db	     09Ah
   	     dw	     X060_02
   	     dw	     seg X060_02
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8698
   	     mov     word ptr ES:[SI],AX
   	     mov     AX,word ptr [BP+8]
   	     mov     word ptr ES:[SI+2],AX
   	     mov     AX,DGROUP:M001_BCC_DATA_86F9
   	     inc     word ptr DGROUP:M001_BCC_DATA_86F9
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    8
BCC_FAR_1769    endp
CO058_TEXT	     ends

; END STAOV041
; BEGIN STAOV042 (listing ovr_1d5a_a169:17D0)

   	     extrn   X043_03:far


CO058_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO058_TEXT,ds:DGROUP

M002_BCC_DATA_8680	     equ     8680h
M002_BCC_DATA_8698	     equ     8698h
M002_BCC_DATA_86F9	     equ     86F9h

   	     public  X058_00
X058_00 label   far
BCC_FAR_17D0    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,8680h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     push    DS
   	     mov     AX,8698h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8680
   	     mov     AL,byte ptr [BP+0Ah]
   	     mov     byte ptr ES:[SI],AL
   	     mov     byte ptr ES:[SI+1],0
   	     mov     word ptr ES:[SI+2],0
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8698
   	     mov     AX,word ptr [BP+8]
   	     mov     word ptr ES:[SI],AX
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+2],AX
   	     mov     AX,DGROUP:M002_BCC_DATA_86F9
   	     inc     word ptr DGROUP:M002_BCC_DATA_86F9
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_17D0    endp
CO058_TEXT	     ends

; END STAOV042
; BEGIN STAOV043 (listing ovr_1d5a_a169:1824)

   	     extrn   X043_03:far


CO058_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO058_TEXT,ds:DGROUP

M003_BCC_DATA_8680	     equ     8680h
M003_BCC_DATA_8698	     equ     8698h
M003_BCC_DATA_86F9	     equ     86F9h

   	     public  X058_04
X058_04 label   far
BCC_FAR_1824    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,8680h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     push    DS
   	     mov     AX,8698h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     mov     AL,byte ptr [BP+0Ah]
   	     mov     byte ptr ES:[SI],AL
   	     mov     byte ptr ES:[SI+1],0
   	     mov     word ptr ES:[SI+2],0
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+2],AX
   	     mov     word ptr ES:[SI],DX
   	     mov     AX,DGROUP:M003_BCC_DATA_86F9
   	     inc     word ptr DGROUP:M003_BCC_DATA_86F9
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_1824    endp
CO058_TEXT	     ends

; END STAOV043
; BEGIN STAOV044 (listing ovr_1d5a_a169:1878)

CO058_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO058_TEXT,ds:DGROUP

M004_BCC_DATA_8654	     equ     8654h
M004_BCC_DATA_866E	     equ     866Eh
M004_BCC_DATA_8680	     equ     8680h
M004_BCC_DATA_8698	     equ     8698h


   	     public  X058_02
X058_02 label   far
BCC_FAR_1878    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     db	     0E9h
   	     dw	     000ACh
M004_L_1886:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     cmp     word ptr ES:[DI],0
   	     je	     short M004_L_1899
   	     cmp     word ptr ES:[DI],4
   	     je	     short M004_L_1899
   	     db	     0E9h
   	     dw	     00091h
M004_L_1899:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     mov     AX,word ptr ES:[DI+4]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     mov     AX,word ptr ES:[DI+6]
   	     mov     CX,AX
   	     jmp     short M004_L_1926
M004_L_18AF:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+3F9Dh]
   	     mov     DX,word ptr [BX+3F9Bh]
   	     mov     word ptr [BP-2],AX
   	     mov     word ptr [BP-4],DX
   	     mov     AX,word ptr [BP-4]
   	     and     AX,1
   	     or	     AX,0
   	     je	     short M004_L_1922
   	     mov     AX,word ptr [BP-4]
   	     and     AX,8
   	     or	     AX,0
   	     je	     short M004_L_18F5
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     or	     byte ptr ES:[BX+0Eh],34h
   	     jmp     short M004_L_1922
M004_L_18F5:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],4
   	     je	     short M004_L_1912
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     or	     byte ptr ES:[BX+0Eh],20h
   	     jmp     short M004_L_1922
M004_L_1912:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_866E
   	     or	     byte ptr ES:[BX+0Eh],40h
M004_L_1922:
   	     dec     CX
   	     add     SI,4
M004_L_1926:
   	     or	     CX,CX
   	     jne     short M004_L_18AF
M004_L_192A:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     mov     DI,word ptr ES:[DI+0Ch]
M004_L_1932:
   	     or	     DI,DI
   	     je	     short M004_L_1939
   	     db	     0E9h
   	     dw	     0FF4Dh
M004_L_1939:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_1878    endp
CO058_TEXT	     ends

; END STAOV044
   	     end
