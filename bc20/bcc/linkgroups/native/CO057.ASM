   	     public  X057_03
   	     public  X057_02
   	     public  X057_01
   	     public  X057_00
   	     public  X057_07
   	     public  X057_06
   	     public  X057_05
   	     public  X057_04
   	     public  X057_09
   	     public  X057_08
   	     public  X057_11
   	     public  X057_13
   	     public  X057_12
   	     public  X057_10
   	     public  X057_0C
   	     public  X057_0B
   	     public  X057_0A
   	     public  X057_0F
   	     public  X057_0E
   	     public  X057_0D
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d51_a076
; BEGIN STAOV017 (listing ovr_1d51_a076:0760)

   	     extrn   BCC_FAR_AF23:far
   	     extrn   X043_01:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M000_BCC_DATA_8654	     equ     8654h
M000_BCC_DATA_86F9	     equ     86F9h

   	     public  X057_10
X057_10 label   far
BCC_NEAR_0760   label   near
BCC_FAR_0760    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,8654h
   	     push    AX
   	     mov     AX,2Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_01
   	     dw	     seg X043_01
   	     mov     SI,AX
   	     push    word ptr DGROUP:M000_BCC_DATA_8654
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,2Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     mov     AX,DGROUP:M000_BCC_DATA_86F9
   	     mov     word ptr ES:[SI+4],AX
   	     mov     word ptr ES:[SI+1Eh],0FFFFh
   	     mov     AX,SI
   	     pop     SI
   	     pop     BP
   	     retf
BCC_FAR_0760    endp
CO057_TEXT	     ends

; END STAOV017
; BEGIN STAOV018 (listing ovr_1d51_a076:079B)

   	     extrn   BCC_FAR_AB12:far
   	     extrn   BCC_FAR_B0F1:far
   	     extrn   X043_03:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M001_BCC_DATA_7846	     equ     7846h
M001_BCC_DATA_8654	     equ     8654h
M001_BCC_DATA_86D8	     equ     86D8h

   	     public  X057_00
X057_00 label   far
BCC_FAR_079B    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     inc     AX
   	     mov     word ptr [BP-2],AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FFABh
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8654
   	     mov     word ptr ES:[DI],5
   	     push    DS
   	     mov     AX,7846h
   	     push    AX
   	     mov     AX,word ptr [BP-2]
   	     add     AX,7
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8654
   	     mov     word ptr ES:[DI+12h],SI
   	     mov     word ptr ES:[DI+8],0
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_7846
   	     mov     byte ptr ES:[SI],0FFh
   	     mov     byte ptr ES:[SI+1],1
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,0Ch
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     byte ptr ES:[SI+2],AL
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,8
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     byte ptr ES:[SI+3],AL
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,4
   	     shr     AX,CL
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     byte ptr ES:[SI+4],AL
   	     mov     AX,word ptr [BP+6]
   	     and     AL,0Fh
   	     add     AL,61h
   	     mov     byte ptr ES:[SI+5],AL
   	     push    ES
   	     mov     AX,word ptr [BP+8]
   	     cmp     AX,word ptr DGROUP:M001_BCC_DATA_86D8
   	     jne     short M001_L_0835
   	     mov     AX,1
   	     jmp     short M001_L_0837
M001_L_0835:
   	     xor     AX,AX
M001_L_0837:
   	     add     AL,30h
   	     pop     ES
   	     mov     byte ptr ES:[SI+6],AL
   	     mov     AX,SI
   	     add     AX,7
   	     push    word ptr DGROUP:M001_BCC_DATA_7846
   	     push    AX
   	     push    word ptr [BP+0Eh]
   	     push    word ptr [BP+0Ch]
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     mov     AX,DI
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    0Ah
BCC_FAR_079B    endp
CO057_TEXT	     ends

; END STAOV018
; BEGIN STAOV019 (listing ovr_1d51_a076:0860)

   	     extrn   BCC_FAR_AF23:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M002_BCC_DATA_86D4	     equ     86D4h
M002_BCC_DATA_86D6	     equ     86D6h
M002_BCC_DATA_86D8	     equ     86D8h
M002_BCC_DATA_86DA	     equ     86DAh
M002_BCC_DATA_86DC	     equ     86DCh
M002_BCC_DATA_86DE	     equ     86DEh
M002_BCC_DATA_86E4	     equ     86E4h
M002_BCC_DATA_86EE	     equ     86EEh
M002_BCC_DATA_86F0	     equ     86F0h
M002_BCC_DATA_86F2	     equ     86F2h
M002_BCC_DATA_86F3	     equ     86F3h
M002_BCC_DATA_86F5	     equ     86F5h
M002_BCC_DATA_86F9	     equ     86F9h
M002_BCC_DATA_86FB	     equ     86FBh
M002_BCC_DATA_86FD	     equ     86FDh

   	     public  X057_03
X057_03 label   far
BCC_FAR_0860    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,86D4h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,21h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     inc     word ptr DGROUP:M002_BCC_DATA_86F5
   	     mov     AX,word ptr [BP+18h]
   	     mov     DGROUP:M002_BCC_DATA_86D4,AX
   	     mov     AX,word ptr [BP+16h]
   	     mov     DGROUP:M002_BCC_DATA_86EE,AX
   	     mov     AX,word ptr [BP+14h]
   	     mov     DGROUP:M002_BCC_DATA_86F0,AX
   	     mov     AL,byte ptr [BP+12h]
   	     mov     DGROUP:M002_BCC_DATA_86F2,AL
   	     mov     AL,byte ptr [BP+10h]
   	     mov     AH,0
   	     mov     DGROUP:M002_BCC_DATA_86F3,AX
   	     mov     AX,word ptr [BP+0Eh]
   	     mov     DGROUP:M002_BCC_DATA_86D6,AX
   	     mov     AX,word ptr [BP+0Ch]
   	     mov     DGROUP:M002_BCC_DATA_86D8,AX
   	     mov     AX,word ptr [BP+0Ah]
   	     mov     DGROUP:M002_BCC_DATA_86DA,AX
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     mov     DGROUP:M002_BCC_DATA_86DE,AX
   	     mov     word ptr DGROUP:M002_BCC_DATA_86DC,DX
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     003FFh
   	     mov     DGROUP:M002_BCC_DATA_86E4,AX
   	     mov     word ptr DGROUP:M002_BCC_DATA_86F9,1
   	     mov     word ptr DGROUP:M002_BCC_DATA_86FB,0
   	     mov     word ptr DGROUP:M002_BCC_DATA_86FD,0
   	     mov     AX,1
   	     pop     BP
   	     retf    14h
BCC_FAR_0860    endp
CO057_TEXT	     ends

; END STAOV019
; BEGIN STAOV020 (listing ovr_1d51_a076:08D8)



CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M003_BCC_DATA_8654	     equ     8654h
M003_BCC_DATA_86EC	     equ     86ECh
M003_BCC_DATA_8707	     equ     8707h

   	     public  X057_0E
X057_0E label   far
BCC_FAR_08D8    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE7Ch
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8654
   	     mov     word ptr ES:[SI],1
   	     mov     word ptr ES:[SI+10h],DI
   	     cmp     word ptr ES:[DI+16h],0
   	     je	     short M003_L_0902
   	     mov     AX,word ptr ES:[DI+16h]
   	     mov     word ptr ES:[SI+18h],AX
M003_L_0902:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8654
   	     mov     word ptr ES:[DI+16h],SI
   	     mov     AX,word ptr [BP+8]
   	     mov     word ptr ES:[SI+12h],AX
   	     mov     word ptr ES:[SI+4],0
   	     cmp     word ptr DGROUP:M003_BCC_DATA_86EC,0
   	     jne     short M003_L_0922
   	     mov     word ptr DGROUP:M003_BCC_DATA_86EC,SI
M003_L_0922:
   	     mov     word ptr DGROUP:M003_BCC_DATA_8707,SI
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    4
BCC_FAR_08D8    endp
CO057_TEXT	     ends

; END STAOV020
; BEGIN STAOV021 (listing ovr_1d51_a076:092E)

   	     extrn   X058_02:far
   	     extrn   X059_04:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M004_BCC_DATA_1700	     equ     1700h
M004_BCC_DATA_1701	     equ     1701h
M004_BCC_DATA_1714	     equ     1714h
M004_BCC_DATA_80C8	     equ     80C8h
M004_BCC_DATA_8186	     equ     8186h
M004_BCC_DATA_8644	     equ     8644h
M004_BCC_DATA_8654	     equ     8654h
M004_BCC_DATA_86F7	     equ     86F7h
M004_BCC_DATA_86F9	     equ     86F9h

   	     public  X057_0A
X057_0A label   far
BCC_FAR_092E    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Eh]
   	     mov     DI,word ptr [BP+0Ch]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE20h
   	     mov     DGROUP:M004_BCC_DATA_86F7,AX
   	     cmp     byte ptr DGROUP:M004_BCC_DATA_1700,0
   	     jne     short M004_L_0958
   	     cmp     byte ptr DGROUP:M004_BCC_DATA_1701,0
   	     jne     short M004_L_0958
   	     cmp     byte ptr DGROUP:M004_BCC_DATA_1714,0
   	     je	     short M004_L_0991
M004_L_0958:
   	     or	     DI,DI
   	     je	     short M004_L_096C
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    DI
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M004_L_096C:
   	     cmp     word ptr [BP+8],0
   	     je	     short M004_L_0991
   	     cmp     word ptr [BP+8],DI
   	     jne     short M004_L_097F
   	     mov     AX,word ptr [BP+6]
   	     cmp     AX,word ptr [BP+0Ah]
   	     je	     short M004_L_0991
M004_L_097F:
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M004_L_0991:
   	     cmp     word ptr DGROUP:M004_BCC_DATA_8644,0
   	     jne     short M004_L_09AD
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     008C4h
   	     push    AX
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-2],DX
   	     jmp     short M004_L_09B2
M004_L_09AD:
   	     xor     AX,AX
   	     mov     word ptr [BP-2],AX
M004_L_09B2:
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr DGROUP:M004_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     mov     AX,word ptr [BP-2]
   	     mov     DX,word ptr [BP-4]
   	     mov     word ptr ES:[BX+18h],AX
   	     mov     word ptr ES:[BX+16h],DX
   	     mov     AX,DGROUP:M004_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[BX+4]
   	     mov     word ptr ES:[BX+6],AX
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],7
   	     jl	     short M004_L_09ED
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     db	     026h,081h,04Fh,01Ch
   	     dw	     4
   	     jmp     short M004_L_0A14
M004_L_09ED:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],2
   	     je	     short M004_L_0A06
   	     cmp     word ptr ES:[SI+2],4
   	     je	     short M004_L_0A06
   	     cmp     word ptr ES:[SI+2],6
   	     jne     short M004_L_0A14
M004_L_0A06:
   	     mov     BX,word ptr DGROUP:M004_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     or	     word ptr ES:[BX+1Ch],200h
M004_L_0A14:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8654
   	     mov     BX,word ptr DGROUP:M004_BCC_DATA_86F7
   	     mov     word ptr ES:[BX],4
   	     db	     0FFh,01Eh
   	     dw	     80C8h
   	     mov     AX,DGROUP:M004_BCC_DATA_86F7
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    0Ah
BCC_FAR_092E    endp
CO057_TEXT	     ends

; END STAOV021
; BEGIN STAOV022 (listing ovr_1d51_a076:0A30)

   	     extrn   BCC_FAR_36F7:far
   	     extrn   X05B_02:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M005_BCC_DATA_29F4	     equ     29F4h
M005_BCC_DATA_29F6	     equ     29F6h
M005_BCC_DATA_7822	     equ     7822h
M005_BCC_DATA_7824	     equ     7824h
M005_BCC_DATA_8644	     equ     8644h
M005_BCC_DATA_8658	     equ     8658h
M005_BCC_DATA_865A	     equ     865Ah
M005_BCC_DATA_8684	     equ     8684h
M005_BCC_DATA_8686	     equ     8686h
M005_BCC_DATA_868C	     equ     868Ch
M005_BCC_DATA_868E	     equ     868Eh
M005_BCC_DATA_869C	     equ     869Ch
M005_BCC_DATA_869E	     equ     869Eh
M005_BCC_DATA_86E4	     equ     86E4h

   	     public  X057_0D
X057_0D label   far
BCC_FAR_0A30    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr DGROUP:M005_BCC_DATA_86E4
   	     mov     AX,1
   	     push    AX
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     002A1h
   	     cmp     word ptr DGROUP:M005_BCC_DATA_8644,0
   	     jne     short M005_L_0A58
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X05B_02
   	     dw	     seg X05B_02
M005_L_0A58:
   	     db	     09Ah
   	     dw	     BCC_FAR_36F7
   	     dw	     seg BCC_FAR_36F7
   	     sub     AX,word ptr DGROUP:M005_BCC_DATA_7822
   	     sbb     DX,word ptr DGROUP:M005_BCC_DATA_7824
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     AX,word ptr [BP-2]
   	     mov     DX,word ptr [BP-4]
   	     cmp     AX,word ptr DGROUP:M005_BCC_DATA_29F6
   	     jg	     short M005_L_0A8C
   	     jl	     short M005_L_0A7F
   	     cmp     DX,word ptr DGROUP:M005_BCC_DATA_29F4
   	     jnc     short M005_L_0A8C
M005_L_0A7F:
   	     mov     AX,word ptr [BP-2]
   	     mov     DX,word ptr [BP-4]
   	     mov     DGROUP:M005_BCC_DATA_29F6,AX
   	     mov     word ptr DGROUP:M005_BCC_DATA_29F4,DX
M005_L_0A8C:
   	     mov     word ptr DGROUP:M005_BCC_DATA_8686,0
   	     mov     word ptr DGROUP:M005_BCC_DATA_8684,4
   	     mov     word ptr DGROUP:M005_BCC_DATA_869E,0
   	     mov     word ptr DGROUP:M005_BCC_DATA_869C,4
   	     mov     word ptr DGROUP:M005_BCC_DATA_865A,0
   	     mov     word ptr DGROUP:M005_BCC_DATA_8658,2
   	     mov     word ptr DGROUP:M005_BCC_DATA_868E,0
   	     mov     word ptr DGROUP:M005_BCC_DATA_868C,2
   	     mov     SP,BP
   	     pop     BP
   	     retf    6
BCC_FAR_0A30    endp
CO057_TEXT	     ends

; END STAOV022
; BEGIN STAOV023 (listing ovr_1d51_a076:0AC2)



CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M006_BCC_DATA_8654	     equ     8654h
M006_BCC_DATA_8707	     equ     8707h

   	     public  X057_0B
X057_0B label   far
BCC_FAR_0AC2    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC92h
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8654
   	     mov     word ptr ES:[SI],2
   	     mov     word ptr ES:[SI+10h],DI
   	     mov     AX,word ptr ES:[DI+10h]
   	     mov     DGROUP:M006_BCC_DATA_8707,AX
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_0AC2    endp
CO057_TEXT	     ends

; END STAOV023
; BEGIN STAOV024 (listing ovr_1d51_a076:0AEC)

CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M007_BCC_DATA_8654	     equ     8654h


   	     public  X057_0C
X057_0C label   far
BCC_FAR_0AEC    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+0Ah]
   	     jmp     short M007_L_0AFD
M007_L_0AF5:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+0Ch]
M007_L_0AFD:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8654
   	     cmp     word ptr ES:[SI],4
   	     jne     short M007_L_0AF5
   	     mov     AX,word ptr [BP+8]
   	     mov     word ptr ES:[SI+10h],AX
   	     mov     word ptr ES:[SI+8],1
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+12h],AX
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_0AEC    endp
CO057_TEXT	     ends

; END STAOV024
; BEGIN STAOV025 (listing ovr_1d51_a076:0B20)

   	     extrn   X058_02:far
   	     extrn   X059_04:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M008_BCC_DATA_1700	     equ     1700h
M008_BCC_DATA_1701	     equ     1701h
M008_BCC_DATA_1714	     equ     1714h
M008_BCC_DATA_80C8	     equ     80C8h
M008_BCC_DATA_8644	     equ     8644h
M008_BCC_DATA_8654	     equ     8654h
M008_BCC_DATA_86F7	     equ     86F7h
M008_BCC_DATA_86F9	     equ     86F9h

   	     public  X057_0F
X057_0F label   far
BCC_FAR_0B20    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ch]
   	     mov     DI,word ptr [BP+8]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC2Fh
   	     mov     word ptr [BP-2],AX
   	     mov     DGROUP:M008_BCC_DATA_86F7,AX
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_1700,0
   	     jne     short M008_L_0B4C
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_1701,0
   	     jne     short M008_L_0B4C
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_1714,0
   	     je	     short M008_L_0B80
M008_L_0B4C:
   	     or	     SI,SI
   	     je	     short M008_L_0B60
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    SI
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M008_L_0B60:
   	     or	     DI,DI
   	     je	     short M008_L_0B80
   	     cmp     DI,SI
   	     jne     short M008_L_0B70
   	     mov     AX,word ptr [BP+6]
   	     cmp     AX,word ptr [BP+0Ah]
   	     je	     short M008_L_0B80
M008_L_0B70:
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    DI
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M008_L_0B80:
   	     cmp     word ptr [BP+0Eh],0
   	     je	     short M008_L_0B9E
   	     cmp     word ptr DGROUP:M008_BCC_DATA_8644,0
   	     jne     short M008_L_0B9E
   	     push    word ptr [BP+0Eh]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     006CDh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
M008_L_0B9E:
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8654
   	     mov     AX,DGROUP:M008_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[BX+4]
   	     mov     word ptr ES:[BX+6],AX
   	     db	     0FFh,01Eh
   	     dw	     80C8h
   	     mov     AX,word ptr [BP-2]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    0Ah
BCC_FAR_0B20    endp
CO057_TEXT	     ends

; END STAOV025
; BEGIN STAOV026 (listing ovr_1d51_a076:0BC0)

   	     extrn   X058_03:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M009_BCC_DATA_8654	     equ     8654h
M009_BCC_DATA_86E0	     equ     86E0h

   	     public  X057_13
X057_13 label   far
BCC_FAR_0BC0    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ah]
   	     mov     SI,word ptr [BP+8]
   	     or	     SI,SI
   	     je	     short M009_L_0C2F
   	     push    SI
   	     db	     09Ah
   	     dw	     X058_03
   	     dw	     seg X058_03
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8654
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+24h],AX
   	     mov     word ptr ES:[SI+0Eh],DI
   	     or	     DI,DI
   	     jne     short M009_L_0BF6
   	     mov     AX,DGROUP:M009_BCC_DATA_86E0
   	     mov     word ptr [BP-2],AX
   	     mov     word ptr DGROUP:M009_BCC_DATA_86E0,SI
   	     jmp     short M009_L_0C16
M009_L_0BF6:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8654
   	     mov     AX,word ptr ES:[DI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     mov     word ptr ES:[DI+0Ch],SI
   	     jmp     short M009_L_0C16
M009_L_0C07:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+0Ch]
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+24h],AX
M009_L_0C16:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8654
   	     cmp     word ptr ES:[SI+0Ch],0
   	     jne     short M009_L_0C07
   	     mov     AX,word ptr [BP-2]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     BX,word ptr [BP-2]
   	     mov     word ptr ES:[BX+0Eh],SI
M009_L_0C2F:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    6
BCC_FAR_0BC0    endp
CO057_TEXT	     ends

; END STAOV026
; BEGIN STAOV027 (listing ovr_1d51_a076:0C37)

   	     extrn   X058_02:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M00A_BCC_DATA_1700	     equ     1700h
M00A_BCC_DATA_1701	     equ     1701h
M00A_BCC_DATA_1714	     equ     1714h
M00A_BCC_DATA_8654	     equ     8654h
M00A_BCC_DATA_86F9	     equ     86F9h

   	     public  X057_07
X057_07 label   far
BCC_NEAR_0C37   label   near
BCC_FAR_0C37    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ch]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB1Dh
   	     mov     SI,AX
   	     cmp     byte ptr DGROUP:M00A_BCC_DATA_1700,0
   	     jne     short M00A_L_0C5A
   	     cmp     byte ptr DGROUP:M00A_BCC_DATA_1701,0
   	     jne     short M00A_L_0C5A
   	     cmp     byte ptr DGROUP:M00A_BCC_DATA_1714,0
   	     je	     short M00A_L_0CA2
M00A_L_0C5A:
   	     or	     DI,DI
   	     je	     short M00A_L_0C6E
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    DI
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M00A_L_0C6E:
   	     cmp     word ptr [BP+8],0
   	     je	     short M00A_L_0C93
   	     cmp     word ptr [BP+8],DI
   	     jne     short M00A_L_0C81
   	     mov     AX,word ptr [BP+6]
   	     cmp     AX,word ptr [BP+0Ah]
   	     je	     short M00A_L_0C93
M00A_L_0C81:
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M00A_L_0C93:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8654
   	     mov     AX,DGROUP:M00A_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[SI+4]
   	     mov     word ptr ES:[SI+6],AX
M00A_L_0CA2:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8654
   	     mov     word ptr ES:[SI+8],1
   	     mov     AX,word ptr [BP+0Eh]
   	     mov     word ptr ES:[SI+10h],AX
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    0Ah
BCC_FAR_0C37    endp
CO057_TEXT	     ends

; END STAOV027
; BEGIN STAOV028 (listing ovr_1d51_a076:0CBB)



CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M00B_BCC_DATA_8654	     equ     8654h

   	     public  X057_06
X057_06 label   far
BCC_NEAR_0CBB   label   near
BCC_FAR_0CBB    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA9Dh
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M00B_BCC_DATA_8654
   	     mov     word ptr ES:[SI],3
   	     pop     SI
   	     pop     BP
   	     retf
BCC_FAR_0CBB    endp
CO057_TEXT	     ends

; END STAOV028
; BEGIN STAOV029 (listing ovr_1d51_a076:0CD1)

CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M00C_BCC_DATA_8654	     equ     8654h


   	     public  X057_11
X057_11 label   far
BCC_FAR_0CD1    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8654
   	     db	     026h,081h,04Ch,01Ch
   	     dw	     1
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_0CD1    endp
CO057_TEXT	     ends

; END STAOV029
; BEGIN STAOV030 (listing ovr_1d51_a076:0CE7)

   	     extrn   X058_03:far
   	     extrn   X059_08:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M00D_BCC_DATA_8654	     equ     8654h
M00D_BCC_DATA_86E0	     equ     86E0h
M00D_BCC_DATA_86E2	     equ     86E2h

   	     public  X057_04
X057_04 label   far
BCC_NEAR_0CE7   label   near
BCC_FAR_0CE7    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     mov     DI,word ptr [BP+6]
   	     or	     SI,SI
   	     jne     short M00D_L_0D00
   	     jmp     short M00D_L_0D6E
M00D_L_0CF8:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+0Eh]
M00D_L_0D00:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8654
   	     cmp     word ptr ES:[SI+0Eh],0
   	     jne     short M00D_L_0CF8
   	     push    SI
   	     db	     09Ah
   	     dw	     X058_03
   	     dw	     seg X058_03
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8654
   	     mov     word ptr ES:[SI+24h],DI
   	     cmp     word ptr DGROUP:M00D_BCC_DATA_86E0,0
   	     je	     short M00D_L_0D2C
   	     push    word ptr DGROUP:M00D_BCC_DATA_86E2
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00850h
   	     jmp     short M00D_L_0D4D
M00D_L_0D2C:
   	     mov     word ptr DGROUP:M00D_BCC_DATA_86E0,SI
   	     mov     word ptr DGROUP:M00D_BCC_DATA_86E2,SI
   	     jmp     short M00D_L_0D4D
M00D_L_0D36:
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_86E2
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8654
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     DGROUP:M00D_BCC_DATA_86E2,AX
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_86E2
   	     mov     word ptr ES:[BX+24h],DI
M00D_L_0D4D:
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_86E2
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8654
   	     cmp     word ptr ES:[BX+0Ch],0
   	     jne     short M00D_L_0D36
   	     cmp     word ptr ES:[SI],1
   	     jne     short M00D_L_0D6E
   	     cmp     word ptr ES:[SI+10h],0
   	     jne     short M00D_L_0D6E
   	     db	     09Ah
   	     dw	     X059_08
   	     dw	     seg X059_08
M00D_L_0D6E:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_0CE7    endp
CO057_TEXT	     ends

; END STAOV030
; BEGIN STAOV031 (listing ovr_1d51_a076:0D74)

   	     extrn   X058_02:far
   	     extrn   X059_01:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M00E_BCC_DATA_1700	     equ     1700h
M00E_BCC_DATA_1701	     equ     1701h
M00E_BCC_DATA_1714	     equ     1714h
M00E_BCC_DATA_80C8	     equ     80C8h
M00E_BCC_DATA_8644	     equ     8644h
M00E_BCC_DATA_8654	     equ     8654h
M00E_BCC_DATA_86E4	     equ     86E4h
M00E_BCC_DATA_86F7	     equ     86F7h
M00E_BCC_DATA_86F9	     equ     86F9h

   	     public  X057_12
X057_12 label   far
BCC_FAR_0D74    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ch]
   	     mov     DI,word ptr [BP+8]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9DBh
   	     mov     word ptr [BP-2],AX
   	     mov     DGROUP:M00E_BCC_DATA_86F7,AX
   	     cmp     byte ptr DGROUP:M00E_BCC_DATA_1700,0
   	     jne     short M00E_L_0DA0
   	     cmp     byte ptr DGROUP:M00E_BCC_DATA_1701,0
   	     jne     short M00E_L_0DA0
   	     cmp     byte ptr DGROUP:M00E_BCC_DATA_1714,0
   	     je	     short M00E_L_0DD4
M00E_L_0DA0:
   	     or	     SI,SI
   	     je	     short M00E_L_0DB4
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    SI
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M00E_L_0DB4:
   	     or	     DI,DI
   	     je	     short M00E_L_0DD4
   	     cmp     DI,SI
   	     jne     short M00E_L_0DC4
   	     mov     AX,word ptr [BP+6]
   	     cmp     AX,word ptr [BP+0Ah]
   	     je	     short M00E_L_0DD4
M00E_L_0DC4:
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    DI
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M00E_L_0DD4:
   	     cmp     word ptr [BP+0Eh],0
   	     je	     short M00E_L_0DE9
   	     cmp     word ptr DGROUP:M00E_BCC_DATA_8644,0
   	     jne     short M00E_L_0DE9
   	     push    word ptr [BP+0Eh]
   	     db	     09Ah
   	     dw	     X059_01
   	     dw	     seg X059_01
M00E_L_0DE9:
   	     mov     BX,word ptr DGROUP:M00E_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8654
   	     mov     AX,DGROUP:M00E_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[BX+4]
   	     mov     word ptr ES:[BX+6],AX
   	     db	     0FFh,01Eh
   	     dw	     80C8h
   	     push    word ptr [BP-2]
   	     push    word ptr DGROUP:M00E_BCC_DATA_86E4
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     push    AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE26h
   	     push    AX
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00763h
   	     mov     AX,word ptr [BP-2]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    0Ah
BCC_FAR_0D74    endp
CO057_TEXT	     ends

; END STAOV031
; BEGIN STAOV032 (listing ovr_1d51_a076:0E22)

   	     extrn   X043_04:far
   	     extrn   X058_02:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M00F_BCC_DATA_1700	     equ     1700h
M00F_BCC_DATA_1701	     equ     1701h
M00F_BCC_DATA_1714	     equ     1714h
M00F_BCC_DATA_8644	     equ     8644h
M00F_BCC_DATA_86F7	     equ     86F7h

   	     public  X057_09
X057_09 label   far
BCC_FAR_0E22    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ch]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F930h
   	     mov     DGROUP:M00F_BCC_DATA_86F7,AX
   	     mov     word ptr [BP-2],AX
   	     cmp     byte ptr DGROUP:M00F_BCC_DATA_1700,0
   	     jne     short M00F_L_0E4B
   	     cmp     byte ptr DGROUP:M00F_BCC_DATA_1701,0
   	     jne     short M00F_L_0E4B
   	     cmp     byte ptr DGROUP:M00F_BCC_DATA_1714,0
   	     je	     short M00F_L_0E84
M00F_L_0E4B:
   	     or	     DI,DI
   	     je	     short M00F_L_0E5F
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    DI
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M00F_L_0E5F:
   	     cmp     word ptr [BP+8],0
   	     je	     short M00F_L_0E84
   	     cmp     word ptr [BP+8],DI
   	     jne     short M00F_L_0E72
   	     mov     AX,word ptr [BP+6]
   	     cmp     AX,word ptr [BP+0Ah]
   	     je	     short M00F_L_0E84
M00F_L_0E72:
   	     mov     AX,1
   	     push    AX
   	     mov     AL,40h
   	     push    AX
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M00F_L_0E84:
   	     cmp     word ptr DGROUP:M00F_BCC_DATA_8644,0
   	     jne     short M00F_L_0EBA
   	     cmp     word ptr [BP+12h],0
   	     je	     short M00F_L_0E9C
   	     push    word ptr [BP+10h]
   	     push    word ptr [BP+0Eh]
   	     db	     0E8h
   	     dw	     0002Ch
   	     jmp     short M00F_L_0EA5
M00F_L_0E9C:
   	     push    word ptr [BP+10h]
   	     push    word ptr [BP+0Eh]
   	     db	     0E8h
   	     dw	     001D7h
M00F_L_0EA5:
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M00F_L_0EBC
   	     push    DS
   	     mov     AX,8654h
   	     push    AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X043_04
   	     dw	     seg X043_04
   	     jmp     short M00F_L_0EBC
M00F_L_0EBA:
   	     xor     SI,SI
M00F_L_0EBC:
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    0Eh
BCC_FAR_0E22    endp
CO057_TEXT	     ends

; END STAOV032
; BEGIN STAOV033 (listing ovr_1d51_a076:0EC6)

   	     extrn   X059_00:far
   	     extrn   X059_02:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M010_BCC_DATA_80B4	     equ     80B4h
M010_BCC_DATA_80B8	     equ     80B8h
M010_BCC_DATA_8108	     equ     8108h
M010_BCC_DATA_8186	     equ     8186h
M010_BCC_DATA_8654	     equ     8654h
M010_BCC_DATA_86F7	     equ     86F7h
M010_BCC_DATA_86F9	     equ     86F9h

BCC_NEAR_0EC6   proc    near
M010_L_0EC6:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     SI,word ptr DGROUP:M010_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,21h
   	     jne     short M010_L_0EE5
   	     db	     0E9h
   	     dw	     00183h
M010_L_0EE5:
   	     jg	     short M010_L_0F14
   	     cmp     AX,1Eh
   	     jne     short M010_L_0EEF
   	     db	     0E9h
   	     dw	     00179h
M010_L_0EEF:
   	     jg	     short M010_L_0F01
   	     cmp     AX,2
   	     je	     short M010_L_0F3B
   	     cmp     AX,1Dh
   	     jne     short M010_L_0EFE
   	     db	     0E9h
   	     dw	     0016Ah
M010_L_0EFE:
   	     db	     0E9h
   	     dw	     0010Bh
M010_L_0F01:
   	     cmp     AX,1Fh
   	     jne     short M010_L_0F09
   	     db	     0E9h
   	     dw	     0015Fh
M010_L_0F09:
   	     cmp     AX,20h
   	     jne     short M010_L_0F11
   	     db	     0E9h
   	     dw	     00157h
M010_L_0F11:
   	     db	     0E9h
   	     dw	     000F8h
M010_L_0F14:
   	     cmp     AX,28h
   	     jne     short M010_L_0F1C
   	     db	     0E9h
   	     dw	     000BCh
M010_L_0F1C:
   	     jg	     short M010_L_0F2E
   	     cmp     AX,22h
   	     jne     short M010_L_0F26
   	     db	     0E9h
   	     dw	     00142h
M010_L_0F26:
   	     cmp     AX,27h
   	     je	     short M010_L_0F91
   	     db	     0E9h
   	     dw	     000DEh
M010_L_0F2E:
   	     cmp     AX,30h
   	     je	     short M010_L_0F80
   	     cmp     AX,32h
   	     je	     short M010_L_0F61
   	     db	     0E9h
   	     dw	     000D1h
M010_L_0F3B:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     or	     AX,word ptr ES:[DI+0Ch]
   	     jne     short M010_L_0F61
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8654
   	     mov     AX,DGROUP:M010_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[SI+4]
   	     mov     word ptr ES:[SI+6],AX
   	     mov     word ptr ES:[SI+8],0
   	     db	     0E9h
   	     dw	     00110h
M010_L_0F61:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8654
   	     mov     AX,DGROUP:M010_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[SI+4]
   	     mov     word ptr ES:[SI+6],AX
   	     mov     word ptr ES:[SI+8],1
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+10h],AX
   	     db	     0E9h
   	     dw	     000F1h
M010_L_0F80:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     000EEh
   	     db	     0E9h
   	     dw	     000E2h
M010_L_0F91:
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD26h
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     000D6h
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7B6h
   	     mov     DGROUP:M010_BCC_DATA_86F7,AX
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ch]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FF08h
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     push    word ptr [BP-4]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     005AEh
   	     push    SI
   	     push    word ptr [BP-2]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     005A5h
   	     db	     0E9h
   	     dw	     00099h
M010_L_0FD8:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FEE0h
   	     push    CS
   	     db	     0E8h
   	     dw	     0F776h
   	     mov     DGROUP:M010_BCC_DATA_86F7,AX
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ch]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FEC8h
   	     mov     word ptr [BP-2],AX
   	     push    SI
   	     push    word ptr [BP-2]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00570h
   	     jmp     short M010_L_1071
M010_L_100C:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     cmp     word ptr ES:[DI+2],6
   	     jg	     short M010_L_1040
   	     mov     AX,1Eh
   	     push    AX
   	     mov     AX,5
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     push    AX
   	     push    DI
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[DI+8]
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     0FFh,01Eh
   	     dw	     80B4h
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     DI,AX
   	     jmp     short M010_L_1068
M010_L_1040:
   	     push    DI
   	     db	     09Ah
   	     dw	     X059_00
   	     dw	     seg X059_00
   	     mov     BX,word ptr DGROUP:M010_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8654
   	     mov     AX,DGROUP:M010_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[BX+4]
   	     mov     word ptr ES:[BX+6],AX
   	     mov     word ptr ES:[BX+8],0Bh
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[BX+10h],AX
   	     jmp     short M010_L_1071
M010_L_1068:
   	     push    DI
   	     push    word ptr [BP+4]
   	     db	     09Ah
   	     dw	     X059_02
   	     dw	     seg X059_02
M010_L_1071:
   	     mov     AX,SI
M010_L_1073:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_0EC6   endp
CO057_TEXT	     ends

; END STAOV033
; BEGIN STAOV034 (listing ovr_1d51_a076:107C)

   	     extrn   X059_00:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M011_BCC_DATA_80B4	     equ     80B4h
M011_BCC_DATA_80B8	     equ     80B8h
M011_BCC_DATA_8108	     equ     8108h
M011_BCC_DATA_8186	     equ     8186h
M011_BCC_DATA_8654	     equ     8654h
M011_BCC_DATA_86F7	     equ     86F7h
M011_BCC_DATA_86F9	     equ     86F9h

BCC_NEAR_107C   proc    near
M011_L_107C:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     SI,word ptr DGROUP:M011_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,21h
   	     jne     short M011_L_109B
   	     db	     0E9h
   	     dw	     001A4h
M011_L_109B:
   	     jg	     short M011_L_10CA
   	     cmp     AX,1Eh
   	     jne     short M011_L_10A5
   	     db	     0E9h
   	     dw	     0019Ah
M011_L_10A5:
   	     jg	     short M011_L_10B7
   	     cmp     AX,2
   	     je	     short M011_L_10F4
   	     cmp     AX,1Dh
   	     jne     short M011_L_10B4
   	     db	     0E9h
   	     dw	     0018Bh
M011_L_10B4:
   	     db	     0E9h
   	     dw	     0012Ah
M011_L_10B7:
   	     cmp     AX,1Fh
   	     jne     short M011_L_10BF
   	     db	     0E9h
   	     dw	     00180h
M011_L_10BF:
   	     cmp     AX,20h
   	     jne     short M011_L_10C7
   	     db	     0E9h
   	     dw	     00178h
M011_L_10C7:
   	     db	     0E9h
   	     dw	     00117h
M011_L_10CA:
   	     cmp     AX,28h
   	     jne     short M011_L_10D2
   	     db	     0E9h
   	     dw	     00090h
M011_L_10D2:
   	     jg	     short M011_L_10E7
   	     cmp     AX,22h
   	     jne     short M011_L_10DC
   	     db	     0E9h
   	     dw	     00163h
M011_L_10DC:
   	     cmp     AX,27h
   	     jne     short M011_L_10E4
   	     db	     0E9h
   	     dw	     000C7h
M011_L_10E4:
   	     db	     0E9h
   	     dw	     000FAh
M011_L_10E7:
   	     cmp     AX,30h
   	     je	     short M011_L_1157
   	     cmp     AX,32h
   	     je	     short M011_L_113D
   	     db	     0E9h
   	     dw	     000EDh
M011_L_10F4:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     or	     AX,word ptr ES:[DI+0Ch]
   	     jne     short M011_L_1123
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8654
   	     mov     AX,DGROUP:M011_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[SI+4]
   	     mov     word ptr ES:[SI+6],AX
   	     mov     word ptr ES:[SI+8],1
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+10h],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00136h
M011_L_1123:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8654
   	     mov     AX,DGROUP:M011_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[SI+4]
   	     mov     word ptr ES:[SI+6],AX
   	     mov     word ptr ES:[SI+8],0
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0011Ch
M011_L_113D:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8654
   	     mov     AX,DGROUP:M011_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[SI+4]
   	     mov     word ptr ES:[SI+6],AX
   	     mov     word ptr ES:[SI+8],0
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00102h
M011_L_1157:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     db	     0E9h
   	     dw	     000F1h
M011_L_1162:
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB55h
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     0FD4Fh
   	     push    CS
   	     db	     0E8h
   	     dw	     0F5E5h
   	     mov     DGROUP:M011_BCC_DATA_86F7,AX
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ch]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FEEDh
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     push    word ptr [BP-4]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     003DDh
   	     push    SI
   	     push    word ptr [BP-2]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     003D4h
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     000AEh
M011_L_11AB:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FEC3h
   	     push    CS
   	     db	     0E8h
   	     dw	     0F5A3h
   	     mov     DGROUP:M011_BCC_DATA_86F7,AX
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ch]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FEABh
   	     mov     word ptr [BP-2],AX
   	     push    SI
   	     push    word ptr [BP-2]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0039Dh
   	     mov     AX,SI
   	     jmp     short M011_L_1259
M011_L_11E1:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     cmp     word ptr ES:[DI+2],6
   	     jg	     short M011_L_1215
   	     mov     AX,1Eh
   	     push    AX
   	     mov     AX,5
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     push    AX
   	     push    DI
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI+8]
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     db	     0FFh,01Eh
   	     dw	     80B4h
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     DI,AX
   	     jmp     short M011_L_123F
M011_L_1215:
   	     push    DI
   	     db	     09Ah
   	     dw	     X059_00
   	     dw	     seg X059_00
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_86F7
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8654
   	     mov     AX,DGROUP:M011_BCC_DATA_86F9
   	     sub     AX,word ptr ES:[BX+4]
   	     mov     word ptr ES:[BX+6],AX
   	     mov     word ptr ES:[BX+8],0Ah
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[BX+10h],AX
   	     mov     AX,SI
   	     jmp     short M011_L_1259
M011_L_123F:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[DI]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00423h
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     mov     word ptr ES:[DI],AX
   	     push    DI
M011_L_1253:
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0FC6Dh
M011_L_1259:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_107C   endp
CO057_TEXT	     ends

; END STAOV034
; BEGIN STAOV035 (listing ovr_1d51_a076:1262)



CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M012_BCC_DATA_8186	     equ     8186h

   	     public  X057_05
X057_05 label   far
BCC_NEAR_1262   label   near
BCC_FAR_1262    proc    far
M012_L_1262:
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     or	     SI,SI
   	     je	     short M012_L_127B
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M012_L_127E
M012_L_127B:
   	     db	     0E9h
   	     dw	     002C1h
M012_L_127E:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     cmp     BX,5
   	     je	     short M012_L_12BE
   	     jg	     short M012_L_129C
   	     dec     BX
   	     cmp     BX,3
   	     jbe     short M012_L_1295
   	     db	     0E9h
   	     dw	     00091h
M012_L_1295:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0DE8h
M012_L_129C:
   	     cmp     BX,7
   	     je	     short M012_L_12BE
   	     cmp     BX,32h
   	     je	     short M012_L_12E0
   	     cmp     BX,33h
   	     je	     short M012_L_12C1
   	     jmp     short M012_L_1326
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     test    word ptr ES:[SI+4],10h
   	     je	     short M012_L_12BE
   	     mov     byte ptr ES:[SI+6],1
M012_L_12BE:
   	     db	     0E9h
   	     dw	     0027Eh
M012_L_12C1:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF95h
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     AL,byte ptr ES:[BX+6]
   	     db	     0E9h
   	     dw	     00255h
M012_L_12E0:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF76h
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX],5
   	     je	     short M012_L_1308
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX],6
   	     jne     short M012_L_1313
M012_L_1308:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     byte ptr ES:[SI+6],1
   	     jmp     short M012_L_1323
M012_L_1313:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     AL,byte ptr ES:[BX+6]
   	     mov     byte ptr ES:[SI+6],AL
M012_L_1323:
   	     db	     0E9h
   	     dw	     00219h
M012_L_1326:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF30h
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     cmp     word ptr ES:[SI+0Ch],0
   	     je	     short M012_L_1351
   	     push    word ptr ES:[SI+0Ch]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF19h
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
M012_L_1351:
   	     push    SI
   	     db	     0E8h
   	     dw	     001FBh
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     001EDh
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     AL,byte ptr ES:[BX+6]
   	     cbw
   	     cwd
   	     xor     AX,DX
   	     sub     AX,DX
   	     mov     word ptr [BP-8],AX
   	     cmp     word ptr ES:[SI],23h
   	     je	     short M012_L_1387
   	     cmp     word ptr ES:[SI],24h
   	     jne     short M012_L_138D
M012_L_1387:
   	     mov     AX,word ptr [BP-2]
   	     add     word ptr [BP-8],AX
M012_L_138D:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+0Ch],0
   	     je	     short M012_L_13CF
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     001B1h
   	     mov     word ptr [BP-6],AX
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ch]
   	     mov     AL,byte ptr ES:[BX+6]
   	     cbw
   	     cwd
   	     xor     AX,DX
   	     sub     AX,DX
   	     mov     word ptr [BP-0Ah],AX
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_13E2
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_13E8
M012_L_13CF:
   	     mov     AX,word ptr [BP-2]
   	     cmp     AX,word ptr [BP-8]
   	     jle     short M012_L_13DC
   	     mov     AL,byte ptr [BP-2]
   	     jmp     short M012_L_13DF
M012_L_13DC:
   	     mov     AL,byte ptr [BP-8]
M012_L_13DF:
   	     db	     0E9h
   	     dw	     00153h
M012_L_13E2:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_13E8:
   	     cmp     AX,word ptr [BP-2]
   	     jge     short M012_L_13F2
   	     mov     AX,word ptr [BP-2]
   	     jmp     short M012_L_1410
M012_L_13F2:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_140A
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_1410
M012_L_140A:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_1410:
   	     cmp     AX,word ptr [BP-8]
   	     jge     short M012_L_141A
   	     mov     AX,word ptr [BP-8]
   	     jmp     short M012_L_1460
M012_L_141A:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_1432
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_1438
M012_L_1432:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_1438:
   	     cmp     AX,word ptr [BP-2]
   	     jge     short M012_L_1442
   	     mov     AX,word ptr [BP-2]
   	     jmp     short M012_L_1460
M012_L_1442:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_145A
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_1460
M012_L_145A:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_1460:
   	     cmp     AX,word ptr [BP-0Ah]
   	     jge     short M012_L_146B
   	     mov     AL,byte ptr [BP-0Ah]
   	     db	     0E9h
   	     dw	     00096h
M012_L_146B:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_1483
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_1489
M012_L_1483:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_1489:
   	     cmp     AX,word ptr [BP-2]
   	     jge     short M012_L_1493
   	     mov     AX,word ptr [BP-2]
   	     jmp     short M012_L_14B1
M012_L_1493:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_14AB
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_14B1
M012_L_14AB:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_14B1:
   	     cmp     AX,word ptr [BP-8]
   	     jge     short M012_L_14BB
   	     mov     AL,byte ptr [BP-8]
   	     jmp     short M012_L_1501
M012_L_14BB:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_14D3
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     jmp     short M012_L_14D9
M012_L_14D3:
   	     mov     AX,word ptr [BP-8]
   	     add     AX,word ptr [BP-6]
M012_L_14D9:
   	     cmp     AX,word ptr [BP-2]
   	     jge     short M012_L_14E3
   	     mov     AL,byte ptr [BP-2]
   	     jmp     short M012_L_1501
M012_L_14E3:
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-4]
   	     mov     DX,word ptr [BP-8]
   	     add     DX,word ptr [BP-6]
   	     cmp     AX,DX
   	     jge     short M012_L_14FB
   	     mov     AL,byte ptr [BP-0Ah]
   	     add     AL,byte ptr [BP-4]
   	     jmp     short M012_L_1501
M012_L_14FB:
   	     mov     AL,byte ptr [BP-8]
   	     add     AL,byte ptr [BP-6]
M012_L_1501:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     byte ptr ES:[SI+6],AL
   	     mov     AX,word ptr [BP-8]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jge     short M012_L_1513
   	     jmp     short M012_L_153F
M012_L_1513:
   	     mov     AX,word ptr [BP-8]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jne     short M012_L_152D
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],12h
   	     jl	     short M012_L_152D
   	     cmp     word ptr ES:[SI],1Ch
   	     jg	     short M012_L_152D
   	     jmp     short M012_L_153F
M012_L_152D:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[SI+6]
M012_L_1535:
   	     neg     AL
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     byte ptr ES:[SI+6],AL
M012_L_153F:
   	     mov     AX,SI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_1262    endp
CO057_TEXT	     ends

; END STAOV035
; BEGIN STOVT165 (listing ovr_1d51_a076:1548)
CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT

BCC_TABLE_1548  label   word
   	     dw	     00B4Dh
   	     dw	     00B5Eh
   	     dw	     00B5Eh
   	     dw	     00B5Eh

CO057_TEXT	     ends
; END STOVT165
; BEGIN STAOV036 (listing ovr_1d51_a076:1550)

CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M014_BCC_DATA_8186	     equ     8186h


BCC_NEAR_1550   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M014_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     mov     AL,byte ptr [BX+5234h]
   	     cbw
   	     mov     DX,15h
   	     imul    DX
   	     add     AX,word ptr ES:[SI+2]
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+51DFh]
   	     cbw
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_1550   endp
CO057_TEXT	     ends

; END STAOV036
; BEGIN STAOV037 (listing ovr_1d51_a076:157A)

   	     extrn   X043_04:far


CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP

M015_BCC_DATA_8654	     equ     8654h

   	     public  X057_08
X057_08 label   far
BCC_NEAR_157A   label   near
BCC_FAR_157A    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+8]
   	     mov     SI,word ptr [BP+6]
   	     or	     SI,SI
   	     jne     short M015_L_1596
   	     db	     0E9h
   	     dw	     000D8h
M015_L_158E:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     mov     DI,word ptr ES:[DI+0Ch]
M015_L_1596:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     cmp     word ptr ES:[DI+0Ch],0
   	     jne     short M015_L_158E
   	     db	     0E9h
   	     dw	     000B3h
M015_L_15A4:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     cmp     word ptr ES:[DI],0
   	     je	     short M015_L_15B1
   	     db	     0E9h
   	     dw	     0009Ch
M015_L_15B1:
   	     cmp     word ptr ES:[SI],0
   	     je	     short M015_L_15BA
   	     db	     0E9h
   	     dw	     00093h
M015_L_15BA:
   	     cmp     word ptr ES:[DI+8],0
   	     je	     short M015_L_15C4
   	     db	     0E9h
   	     dw	     00089h
M015_L_15C4:
   	     cmp     word ptr ES:[SI+6],0
   	     jne     short M015_L_15FA
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     mov     AX,word ptr ES:[SI+10h]
   	     mov     word ptr ES:[DI+10h],AX
   	     mov     AX,word ptr ES:[SI+1Ch]
   	     or	     word ptr ES:[DI+1Ch],AX
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     push    DS
   	     mov     AX,8654h
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X043_04
   	     dw	     seg X043_04
   	     mov     SI,word ptr [BP-2]
   	     jmp     short M015_L_1657
M015_L_15FA:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     mov     AX,word ptr ES:[DI+4]
   	     add     AX,word ptr ES:[DI+6]
   	     cmp     AX,word ptr ES:[SI+4]
   	     jne     short M015_L_1643
   	     mov     AX,word ptr ES:[SI+6]
   	     add     word ptr ES:[DI+6],AX
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     mov     AX,word ptr ES:[SI+10h]
   	     mov     word ptr ES:[DI+10h],AX
   	     mov     AX,word ptr ES:[SI+1Ch]
   	     or	     word ptr ES:[DI+1Ch],AX
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr [BP-2],AX
   	     push    DS
   	     mov     AX,8654h
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X043_04
   	     dw	     seg X043_04
   	     mov     SI,word ptr [BP-2]
   	     jmp     short M015_L_1657
M015_L_1643:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     mov     word ptr ES:[SI+0Eh],DI
   	     jmp     short M015_L_165E
M015_L_164D:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     mov     word ptr ES:[SI+0Eh],DI
   	     jmp     short M015_L_165E
M015_L_1657:
   	     or	     SI,SI
   	     je	     short M015_L_165E
   	     db	     0E9h
   	     dw	     0FF46h
M015_L_165E:
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8654
   	     mov     word ptr ES:[DI+0Ch],SI
M015_L_1666:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
BCC_FAR_157A    endp
CO057_TEXT	     ends

; END STAOV037
; BEGIN STAOV038 (listing ovr_1d51_a076:166E)

CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP



   	     public  X057_02
X057_02 label   far
BCC_NEAR_166E   label   near
BCC_FAR_166E    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     BX,word ptr [BP+6]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+38C2h]
   	     pop     BP
   	     retf    2
BCC_FAR_166E    endp
CO057_TEXT	     ends

; END STAOV038
; BEGIN STAOV039 (listing ovr_1d51_a076:167E)

CO057_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO057_TEXT,ds:DGROUP



   	     public  X057_01
X057_01 label   far
BCC_FAR_167E    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     BX,word ptr [BP+6]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+38CEh]
   	     pop     BP
   	     retf    2
BCC_FAR_167E    endp
CO057_TEXT	     ends

; END STAOV039
   	     end
