   	     public  X04C_00
   	     public  X04C_09
   	     public  X04C_08
   	     public  X04C_01
   	     public  X04C_03
   	     public  X04C_02
   	     public  X04C_05
   	     public  X04C_04
   	     public  X04C_07
   	     public  X04C_06
   	     public  X04C_0A
   	     public  X04C_0C
   	     public  X04C_0B
   	     public  X04C_0E
   	     public  X04C_0D
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d13_99b3
; BEGIN STOVR58 (listing ovr_1d13_99b3:9B30)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M000_BCC_DATA_818A	     equ     818Ah


   	     public  X04C_04
X04C_04 label   far
BCC_FAR_9B30    proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     word ptr DGROUP:M000_BCC_DATA_818A,2
   	     jbe     short M000_L_9B3E
   	     xor     AX,AX
   	     jmp     short M000_L_9B41
M000_L_9B3E:
   	     mov     AX,1
M000_L_9B41:
   	     pop     BP
   	     retf
BCC_FAR_9B30    endp
CO04C_TEXT	     ends

; END STOVR58
; BEGIN STOVR59 (listing ovr_1d13_99b3:9B43)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M001_BCC_DATA_818A	     equ     818Ah
M001_BCC_DATA_818C	     equ     818Ch


   	     public  X04C_07
X04C_07 label   far
BCC_FAR_9B43    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     word ptr DGROUP:M001_BCC_DATA_818C,0
   	     mov     word ptr DGROUP:M001_BCC_DATA_818A,2
   	     pop     BP
   	     retf
BCC_FAR_9B43    endp
CO04C_TEXT	     ends

; END STOVR59
; BEGIN STOVR60 (listing ovr_1d13_99b3:9B54)

   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M002_BCC_DATA_815C	     equ     815Ch
M002_BCC_DATA_8186	     equ     8186h

   	     public  X04C_08
X04C_08 label   far
BCC_FAR_9B54    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ah]
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     AL,byte ptr [BP+0Ch]
   	     cbw
   	     mov     word ptr ES:[SI],AX
   	     mov     word ptr ES:[SI+4],0
   	     mov     byte ptr ES:[SI+6],0
   	     mov     byte ptr ES:[SI+7],0
   	     or	     DI,DI
   	     je	     short M002_L_9BA0
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     jmp     short M002_L_9BAA
M002_L_9BA0:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],0
M002_L_9BAA:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8186
   	     mov     AX,word ptr [BP+8]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    8
BCC_FAR_9B54    endp
CO04C_TEXT	     ends

; END STOVR60
; BEGIN STOVR61 (listing ovr_1d13_99b3:9BC4)

   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M003_BCC_DATA_815C	     equ     815Ch
M003_BCC_DATA_8186	     equ     8186h

   	     public  X04C_09
X04C_09 label   far
BCC_FAR_9BC4    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+8]
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     AL,byte ptr [BP+0Ah]
   	     cbw
   	     mov     word ptr ES:[SI],AX
   	     mov     word ptr ES:[SI+4],0
   	     mov     byte ptr ES:[SI+6],0
   	     mov     byte ptr ES:[SI+7],0
   	     or	     DI,DI
   	     je	     short M003_L_9C10
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     jmp     short M003_L_9C1A
M003_L_9C10:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],0
M003_L_9C1A:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     word ptr ES:[SI+0Ah],0
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_9BC4    endp
CO04C_TEXT	     ends

; END STOVR61
; BEGIN STOVR62 (listing ovr_1d13_99b3:9C33)

   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M004_BCC_DATA_815C	     equ     815Ch
M004_BCC_DATA_8186	     equ     8186h

   	     public  X04C_0C
X04C_0C label   far
BCC_FAR_9C33    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ch]
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     AL,byte ptr [BP+0Eh]
   	     cbw
   	     mov     word ptr ES:[SI],AX
   	     mov     AL,byte ptr [BP+6]
   	     cbw
   	     mov     word ptr ES:[SI+4],AX
   	     mov     byte ptr ES:[SI+6],0
   	     mov     byte ptr ES:[SI+7],0
   	     or	     DI,DI
   	     je	     short M004_L_9C81
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     jmp     short M004_L_9C8B
M004_L_9C81:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],0
M004_L_9C8B:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8186
   	     mov     AX,word ptr [BP+0Ah]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     AX,word ptr [BP+8]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    0Ah
BCC_FAR_9C33    endp
CO04C_TEXT	     ends

; END STOVR62
; BEGIN STOVR63 (listing ovr_1d13_99b3:9CA5)

   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M005_BCC_DATA_815C	     equ     815Ch
M005_BCC_DATA_8186	     equ     8186h

   	     public  X04C_06
X04C_06 label   far
BCC_FAR_9CA5    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ah]
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     word ptr ES:[SI],2
   	     mov     word ptr ES:[SI+4],0
   	     mov     byte ptr ES:[SI+6],0
   	     mov     byte ptr ES:[SI+7],0
   	     or	     DI,DI
   	     je	     short M005_L_9CEF
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     jmp     short M005_L_9CF9
M005_L_9CEF:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],0
M005_L_9CF9:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8186
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+0Ch],AX
   	     mov     word ptr ES:[SI+0Ah],DX
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_9CA5    endp
CO04C_TEXT	     ends

; END STOVR63
; BEGIN STOVR64 (listing ovr_1d13_99b3:9D13)

   	     extrn   BCC_FAR_B0F1:far
   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M006_BCC_DATA_815C	     equ     815Ch
M006_BCC_DATA_8186	     equ     8186h

   	     public  X04C_00
X04C_00 label   far
BCC_NEAR_9D13   label   near
BCC_FAR_9D13    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     word ptr ES:[SI],3
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M006_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     mov     word ptr ES:[SI+4],0
   	     mov     byte ptr ES:[SI+6],0
   	     mov     byte ptr ES:[SI+7],0
   	     push    word ptr DGROUP:M006_BCC_DATA_8186
   	     mov     AX,SI
   	     add     AX,0Ah
   	     push    AX
   	     push    word ptr [BP+0Ah]
   	     push    word ptr [BP+8]
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_9D13    endp
CO04C_TEXT	     ends

; END STOVR64
; BEGIN STOVR65 (listing ovr_1d13_99b3:9D78)

   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M007_BCC_DATA_815C	     equ     815Ch
M007_BCC_DATA_8186	     equ     8186h

   	     public  X04C_0A
X04C_0A label   far
BCC_FAR_9D78    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ah]
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     mov     word ptr ES:[SI+8],DI
   	     mov     word ptr ES:[SI],33h
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],AX
   	     mov     word ptr ES:[SI+4],0
   	     mov     byte ptr ES:[SI+6],0
   	     mov     byte ptr ES:[SI+7],0
   	     mov     AX,word ptr [BP+0Ch]
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     AL,byte ptr [BP+8]
   	     mov     byte ptr ES:[SI+0Ch],AL
   	     mov     AL,byte ptr [BP+6]
   	     mov     byte ptr ES:[SI+0Dh],AL
   	     mov     AX,SI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    8
BCC_FAR_9D78    endp
CO04C_TEXT	     ends

; END STOVR65
; BEGIN STOVR66 (listing ovr_1d13_99b3:9DD9)

   	     extrn   BCC_FAR_5B8B:far
   	     extrn   BCC_FAR_9E16:far
   	     extrn   BCC_FAR_9EE5:far
   	     extrn   BCC_FAR_A0ED:far
   	     extrn   BCC_FAR_A121:far
   	     extrn   BCC_FAR_A14F:far
   	     extrn   BCC_FAR_A17D:far
   	     extrn   BCC_FAR_B0F1:far
   	     extrn   X031_06:far
   	     extrn   X047_09:far
   	     extrn   X049_03:far
   	     extrn   X04F_0E:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M008_BCC_DATA_16F5	     equ     16F5h
M008_BCC_EXPR_SEGMENT   equ     639Ah
M008_BCC_DATA_77E2	     equ     77E2h
M008_BCC_DATA_80B8	     equ     80B8h
M008_BCC_DATA_80F0	     equ     80F0h
M008_BCC_DATA_80F4	     equ     80F4h
M008_BCC_DATA_8104	     equ     8104h
M008_BCC_DATA_8108	     equ     8108h
M008_BCC_DATA_815C	     equ     815Ch
M008_BCC_DATA_8164	     equ     8164h
M008_BCC_DATA_8186	     equ     8186h

   	     public  X04C_0E
X04C_0E label   far
BCC_NEAR_9DD9   label   near
BCC_FAR_9DD9    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,10h
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],0
   	     jne     short M008_L_9DF3
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00444h
M008_L_9DF3:
   	     push    SI
   	     db	     09Ah
   	     dw	     X049_03
   	     dw	     seg X049_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr [BP+6]
   	     cmp     byte ptr ES:[BX],15h
   	     jne     short M008_L_9E1F
   	     cmp     word ptr ES:[BX+3],1
   	     jne     short M008_L_9E19
   	     mov     AX,1
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     jmp     short M008_L_9E1C
M008_L_9E19:
   	     mov     AX,DGROUP:M008_BCC_DATA_77E2
M008_L_9E1C:
   	     mov     word ptr [BP+6],AX
M008_L_9E1F:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+8]
   	     cmp     AX,word ptr [BP+6]
   	     jne     short M008_L_9E31
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00406h
M008_L_9E31:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP+6]
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     mov     AH,0
   	     mov     DI,AX
   	     mov     BX,DI
   	     sub     BX,0Ch
   	     cmp     BX,8
   	     ja	     short M008_L_9E92
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     733h
   	     db	     0E9h
   	     dw	     003CDh
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     003D7h
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],32h
   	     jne     short M008_L_9E92
   	     cmp     word ptr [BP-2],DI
   	     jne     short M008_L_9E92
   	     push    word ptr ES:[SI+8]
   	     push    word ptr [BP+6]
   	     mov     AL,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X04F_0E
   	     dw	     seg X04F_0E
   	     or	     AX,AX
   	     je	     short M008_L_9E92
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     003A5h
M008_L_9E92:
   	     mov     BX,word ptr [BP-2]
   	     sub     BX,9
   	     cmp     BX,0Bh
   	     jbe     short M008_L_9EA0
   	     db	     0E9h
   	     dw	     0008Eh
M008_L_9EA0:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     71Bh
   	     test    byte ptr [DI+9CAh],2
   	     je	     short M008_L_9EB3
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00384h
M008_L_9EB3:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     80F4h
   	     or	     AX,AX
   	     je	     short M008_L_9ED0
   	     cmp     DI,0Fh
   	     jne     short M008_L_9ED0
   	     push    SI
   	     db	     09Ah
   	     dw	     X047_09
   	     dw	     seg X047_09
   	     mov     SI,AX
M008_L_9ED0:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2
   	     jne     short M008_L_9EE8
   	     cmp     DI,0Fh
   	     jne     short M008_L_9EE8
   	     cmp     word ptr [BP-2],0Fh
   	     je	     short M008_L_9EE8
   	     db	     0E9h
   	     dw	     00340h
M008_L_9EE8:
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_16F5,1
   	     je	     short M008_L_9F2E
   	     cmp     DI,word ptr [BP-2]
   	     jne     short M008_L_9F2E
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     8104h
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     0FFh,01Eh
   	     dw	     8104h
   	     pop     DX
   	     cmp     DX,AX
   	     jne     short M008_L_9F2E
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0031Ah
   	     test    byte ptr [DI+9CAh],14h
   	     je	     short M008_L_9F2E
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0030Eh
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00309h
M008_L_9F2E:
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_16F5,1
   	     je	     short M008_L_9F9A
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     006F0h
   	     or	     AX,AX
   	     je	     short M008_L_9F9A
   	     mov     BX,word ptr [BP-2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,2
   	     jne     short M008_L_9F9A
   	     mov     AL,byte ptr [DI+9CAh]
   	     mov     AH,0
   	     test    AX,2
   	     jne     short M008_L_9F9A
   	     push    word ptr [BP+6]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     mov     word ptr [BP-6],AX
   	     mov     AX,word ptr [BP-4]
   	     cmp     AX,word ptr [BP-6]
   	     jbe     short M008_L_9F7C
   	     db	     0E9h
   	     dw	     002ACh
M008_L_9F7C:
   	     push    SI
   	     push    word ptr [BP-2]
   	     push    DI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00AA8h
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],DI
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0029Dh
M008_L_9F9A:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],32h
   	     jne     short M008_L_9FBB
   	     test    byte ptr [DI+9CAh],14h
   	     je	     short M008_L_9FBB
   	     mov     word ptr ES:[SI+2],DI
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0027Ch
M008_L_9FBB:
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_16F5,1
   	     je	     short M008_L_9FED
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     AL,byte ptr [BX+3928h]
   	     mov     BX,DI
   	     shl     BX,1
   	     shl     BX,1
   	     cmp     AL,byte ptr [BX+3928h]
   	     jne     short M008_L_9FED
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],DI
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0024Ah
M008_L_9FED:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2
   	     je	     short M008_L_9FFA
   	     db	     0E9h
   	     dw	     000F2h
M008_L_9FFA:
   	     mov     BX,DI
   	     sub     BX,9
   	     cmp     BX,5
   	     jbe     short M008_L_A007
   	     db	     0E9h
   	     dw	     000B8h
M008_L_A007:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     70Fh
   	     mov     BX,word ptr [BP-2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M008_L_A030
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_A17D
   	     dw	     seg BCC_FAR_A17D
   	     jmp     short M008_L_A046
M008_L_A030:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_A14F
   	     dw	     seg BCC_FAR_A14F
M008_L_A046:
   	     cmp     DI,9
   	     jne     short M008_L_A057
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9E16
   	     dw	     seg BCC_FAR_9E16
   	     jmp     short M008_L_A066
M008_L_A057:
   	     cmp     DI,0Ah
   	     jne     short M008_L_A066
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9EE5
   	     dw	     seg BCC_FAR_9EE5
M008_L_A066:
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_16F5,1
   	     jne     short M008_L_A086
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     X031_06
   	     dw	     seg X031_06
   	     or	     AX,AX
   	     je	     short M008_L_A086
   	     mov     AX,4Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
M008_L_A086:
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC81h
   	     db	     0E9h
   	     dw	     001A2h
   	     cmp     word ptr [BP-2],0Fh
   	     je	     short M008_L_A0AD
   	     cmp     word ptr [BP-2],10h
   	     je	     short M008_L_A0AD
   	     cmp     word ptr [BP-2],8
   	     je	     short M008_L_A0AD
   	     cmp     word ptr [BP-2],7
   	     jne     short M008_L_A0BF
M008_L_A0AD:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     word ptr ES:[SI+0Ch],0
   	     mov     word ptr ES:[SI+0Ah],AX
M008_L_A0BF:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80F0h
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],DX
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     word ptr ES:[SI+2],DI
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     0014Bh
M008_L_A0EC:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],3
   	     je	     short M008_L_A0F9
   	     db	     0E9h
   	     dw	     000B5h
M008_L_A0F9:
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     push    word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,SI
   	     add     AX,0Ah
   	     push    AX
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     cmp     DI,9
   	     jne     short M008_L_A13A
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9E16
   	     dw	     seg BCC_FAR_9E16
   	     push    word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,SI
   	     add     AX,0Ah
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     jmp     short M008_L_A19A
M008_L_A13A:
   	     cmp     DI,0Ah
   	     jne     short M008_L_A163
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_9EE5
   	     dw	     seg BCC_FAR_9EE5
   	     push    word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     AX,SI
   	     add     AX,0Ah
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     mov     AX,0Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     jmp     short M008_L_A19A
M008_L_A163:
   	     cmp     DI,0Bh
   	     je	     short M008_L_A19A
   	     test    byte ptr [DI+9CAh],20h
   	     je	     short M008_L_A17B
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_A121
   	     dw	     seg BCC_FAR_A121
   	     jmp     short M008_L_A185
M008_L_A17B:
   	     push    SS
   	     lea     AX,[BP-10h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_A0ED
   	     dw	     seg BCC_FAR_A0ED
M008_L_A185:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],DX
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI],2
M008_L_A19A:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     word ptr ES:[SI+2],DI
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+8],AX
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00089h
M008_L_A1AE:
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_16F5,1
   	     je	     short M008_L_A1FB
   	     test    byte ptr [DI+9CAh],1
   	     je	     short M008_L_A1FB
   	     mov     BX,word ptr [BP-2]
   	     test    byte ptr [BX+9CAh],1
   	     je	     short M008_L_A1FB
   	     mov     BX,DI
   	     shl     BX,1
   	     shl     BX,1
   	     mov     AL,byte ptr [BX+3929h]
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     shl     BX,1
   	     cmp     AL,byte ptr [BX+3929h]
   	     jge     short M008_L_A1FB
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     cmp     byte ptr [BX+388Ah],0
   	     jne     short M008_L_A1ED
   	     jmp     short M008_L_A228
M008_L_A1ED:
   	     push    SI
   	     push    word ptr [BP+6]
   	     db	     0FFh,01Eh
   	     dw	     815Ch
   	     push    AX
   	     db	     0E8h
   	     dw	     0007Ch
   	     jmp     short M008_L_A237
M008_L_A1FB:
   	     cmp     byte ptr DGROUP:M008_BCC_DATA_16F5,1
   	     je	     short M008_L_A228
   	     cmp     DI,9
   	     jne     short M008_L_A228
   	     cmp     word ptr [BP-2],0Ah
   	     jne     short M008_L_A228
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],35h
   	     jne     short M008_L_A228
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     cmp     word ptr ES:[BX+2],9
   	     jne     short M008_L_A228
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     jmp     short M008_L_A237
M008_L_A228:
   	     mov     AX,35h
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B8h
M008_L_A237:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
BCC_FAR_9DD9    endp
CO04C_TEXT	     ends

; END STOVR66
; BEGIN STOVT67 (listing ovr_1d13_99b3:A23F)
CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT

BCC_TABLE_A23F  label   word
   	     dw	     004DEh
   	     dw	     004DEh
   	     dw	     004DEh
   	     dw	     0058Fh
   	     dw	     0058Fh
   	     dw	     00565h
   	     dw	     003EDh
   	     dw	     003EDh
   	     dw	     003FEh
   	     dw	     003F9h
   	     dw	     00377h
   	     dw	     00377h
   	     dw	     00377h
   	     dw	     00377h
   	     dw	     003FEh
   	     dw	     003FEh
   	     dw	     003F9h
   	     dw	     003F9h
   	     dw	     00328h
   	     dw	     00330h
   	     dw	     00330h
   	     dw	     00330h
   	     dw	     00330h
   	     dw	     0032Bh
   	     dw	     0032Bh
   	     dw	     0032Bh
   	     dw	     0032Bh

CO04C_TEXT	     ends
; END STOVT67
; BEGIN STOVR68 (listing ovr_1d13_99b3:A275)



CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M00A_BCC_DATA_80F0	     equ     80F0h
M00A_BCC_DATA_8108	     equ     8108h
M00A_BCC_DATA_8186	     equ     8186h

BCC_NEAR_A275   proc    near
M00A_L_A275:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     or	     SI,SI
   	     je	     short M00A_L_A28F
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],0
   	     jne     short M00A_L_A294
M00A_L_A28F:
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00104h
M00A_L_A294:
   	     mov     AL,byte ptr [BP+4]
   	     mov     AH,0
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     mov     AL,byte ptr [BX+388Ah]
   	     mov     byte ptr [BP-3],AL
   	     cbw
   	     mov     BX,AX
   	     cmp     BX,3
   	     jbe     short M00A_L_A2B9
   	     db	     0E9h
   	     dw	     00092h
M00A_L_A2B9:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     871h
   	     push    SI
   	     push    DI
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB13h
   	     db	     0E9h
   	     dw	     000CFh
   	     push    SI
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     push    word ptr ES:[SI+2]
   	     mov     AL,byte ptr [BP+4]
   	     mov     AH,0
   	     push    AX
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00751h
   	     db	     0E9h
   	     dw	     000A5h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     mov     AL,byte ptr [BP+4]
   	     mov     AH,0
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80F0h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],DX
   	     mov     word ptr ES:[SI+0Ah],AX
   	     db	     0E9h
   	     dw	     00080h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],8
   	     jle     short M00A_L_A31C
   	     jmp     short M00A_L_A385
M00A_L_A31C:
   	     mov     AL,byte ptr [BP+4]
   	     mov     AH,0
   	     shl     AX,1
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+3929h]
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     shl     BX,1
   	     cmp     AL,byte ptr [BX+3929h]
   	     jle     short M00A_L_A33A
   	     jmp     short M00A_L_A385
M00A_L_A33A:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     mov     AL,byte ptr [BP+4]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FF2Ch
   	     jmp     short M00A_L_A398
M00A_L_A34B:
   	     test    byte ptr [BP-3],10h
   	     je	     short M00A_L_A368
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     mov     AL,byte ptr [BP+4]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FF15h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
M00A_L_A368:
   	     test    byte ptr [BP-3],20h
   	     je	     short M00A_L_A385
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     mov     AL,byte ptr [BP+4]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FEF8h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
M00A_L_A385:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8186
   	     mov     AL,byte ptr [BP+4]
   	     mov     AH,0
   	     mov     word ptr ES:[SI+2],AX
   	     mov     word ptr ES:[SI+8],DI
   	     mov     AX,SI
M00A_L_A398:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_A275   endp
CO04C_TEXT	     ends

; END STOVR68
; BEGIN STOVT69 (listing ovr_1d13_99b3:A3A1)
CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT

BCC_TABLE_A3A1  label   word
   	     dw	     00790h
   	     dw	     00799h
   	     dw	     007D5h
   	     dw	     007B0h

CO04C_TEXT	     ends
; END STOVT69
; BEGIN STOVR70 (listing ovr_1d13_99b3:A3A9)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M00C_BCC_DATA_3980	     equ     3980h
M00C_BCC_DATA_3982	     equ     3982h
M00C_BCC_DATA_3984	     equ     3984h
M00C_BCC_DATA_3986	     equ     3986h
M00C_BCC_DATA_398C	     equ     398Ch
M00C_BCC_DATA_398E	     equ     398Eh
M00C_BCC_DATA_3990	     equ     3990h
M00C_BCC_DATA_3992	     equ     3992h
M00C_BCC_DATA_3994	     equ     3994h
M00C_BCC_DATA_3996	     equ     3996h
M00C_BCC_DATA_399C	     equ     399Ch
M00C_BCC_DATA_399E	     equ     399Eh
M00C_BCC_DATA_39A0	     equ     39A0h
M00C_BCC_DATA_39A2	     equ     39A2h
M00C_BCC_DATA_39A4	     equ     39A4h
M00C_BCC_DATA_39A6	     equ     39A6h
M00C_BCC_DATA_39AC	     equ     39ACh
M00C_BCC_DATA_39AE	     equ     39AEh
M00C_BCC_DATA_8186	     equ     8186h


BCC_NEAR_A3A9   proc    near
M00C_L_A3A9:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M00C_L_A3BE
   	     mov     AL,0
   	     db	     0E9h
   	     dw	     0020Dh
M00C_L_A3BE:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     mov     AL,byte ptr [BX+38C1h]
   	     cbw
   	     mov     DI,AX
   	     or	     AX,AX
   	     je	     short M00C_L_A3E0
   	     cmp     AX,2
   	     jne     short M00C_L_A3D8
   	     db	     0E9h
   	     dw	     00156h
M00C_L_A3D8:
   	     cmp     AX,3
   	     je	     short M00C_L_A3EB
   	     db	     0E9h
   	     dw	     00199h
M00C_L_A3E0:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[SI+2]
   	     db	     0E9h
   	     dw	     001E0h
M00C_L_A3EB:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     DX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-8],AX
   	     mov     word ptr [BP-0Ah],DX
   	     mov     AX,word ptr [BP-8]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_3982
   	     jl	     short M00C_L_A42A
   	     jne     short M00C_L_A40E
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_3980
   	     jc	     short M00C_L_A42A
M00C_L_A40E:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_3986
   	     jg	     short M00C_L_A42A
   	     jne     short M00C_L_A422
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_3984
   	     ja	     short M00C_L_A42A
M00C_L_A422:
   	     mov     word ptr [BP-4],1
   	     db	     0E9h
   	     dw	     000E6h
M00C_L_A42A:
   	     cmp     word ptr [BP-8],0
   	     jl	     short M00C_L_A454
   	     jne     short M00C_L_A438
   	     cmp     word ptr [BP-0Ah],0
   	     jc	     short M00C_L_A454
M00C_L_A438:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_398E
   	     jg	     short M00C_L_A454
   	     jne     short M00C_L_A44C
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_398C
   	     ja	     short M00C_L_A454
M00C_L_A44C:
   	     mov     word ptr [BP-4],2
   	     db	     0E9h
   	     dw	     000BCh
M00C_L_A454:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_3992
   	     jl	     short M00C_L_A484
   	     jne     short M00C_L_A468
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_3990
   	     jc	     short M00C_L_A484
M00C_L_A468:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_3996
   	     jg	     short M00C_L_A484
   	     jne     short M00C_L_A47C
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_3994
   	     ja	     short M00C_L_A484
M00C_L_A47C:
   	     mov     word ptr [BP-4],3
   	     db	     0E9h
   	     dw	     0008Ch
M00C_L_A484:
   	     cmp     word ptr [BP-8],0
   	     jl	     short M00C_L_A4AD
   	     jne     short M00C_L_A492
   	     cmp     word ptr [BP-0Ah],0
   	     jc	     short M00C_L_A4AD
M00C_L_A492:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_399E
   	     jg	     short M00C_L_A4AD
   	     jne     short M00C_L_A4A6
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_399C
   	     ja	     short M00C_L_A4AD
M00C_L_A4A6:
   	     mov     word ptr [BP-4],4
   	     jmp     short M00C_L_A510
M00C_L_A4AD:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_39A2
   	     jl	     short M00C_L_A4DC
   	     jne     short M00C_L_A4C1
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_39A0
   	     jc	     short M00C_L_A4DC
M00C_L_A4C1:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_39A6
   	     jg	     short M00C_L_A4DC
   	     jne     short M00C_L_A4D5
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_39A4
   	     ja	     short M00C_L_A4DC
M00C_L_A4D5:
   	     mov     word ptr [BP-4],5
   	     jmp     short M00C_L_A510
M00C_L_A4DC:
   	     cmp     word ptr [BP-8],0
   	     jl	     short M00C_L_A505
   	     jne     short M00C_L_A4EA
   	     cmp     word ptr [BP-0Ah],0
   	     jc	     short M00C_L_A505
M00C_L_A4EA:
   	     mov     AX,word ptr [BP-8]
   	     mov     DX,word ptr [BP-0Ah]
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_39AE
   	     jg	     short M00C_L_A505
   	     jne     short M00C_L_A4FE
   	     cmp     DX,word ptr DGROUP:M00C_BCC_DATA_39AC
   	     ja	     short M00C_L_A505
M00C_L_A4FE:
   	     mov     word ptr [BP-4],6
   	     jmp     short M00C_L_A510
M00C_L_A505:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[SI+2]
   	     db	     0E9h
   	     dw	     000BBh
M00C_L_A510:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+2]
   	     cmp     AX,word ptr [BP-4]
   	     jle     short M00C_L_A523
   	     mov     AL,byte ptr [BP-4]
   	     db	     0E9h
   	     dw	     000A8h
M00C_L_A523:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[SI+2]
   	     db	     0E9h
   	     dw	     0009Dh
M00C_L_A52E:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr [BP-2],AX
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-4],AX
   	     cmp     word ptr [BP-4],8
   	     jg	     short M00C_L_A562
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     AL,byte ptr [BX+3929h]
   	     mov     BX,word ptr [BP-4]
   	     shl     BX,1
   	     shl     BX,1
   	     cmp     AL,byte ptr [BX+3929h]
   	     jg	     short M00C_L_A56C
M00C_L_A562:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[SI+2]
   	     jmp     short M00C_L_A5CB
M00C_L_A56C:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FE32h
   	     jmp     short M00C_L_A5CB
M00C_L_A579:
   	     test    DI,40h
   	     je	     short M00C_L_A58F
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FE1Fh
   	     mov     byte ptr [BP-5],AL
   	     jmp     short M00C_L_A593
M00C_L_A58F:
   	     mov     byte ptr [BP-5],0
M00C_L_A593:
   	     test    DI,80h
   	     je	     short M00C_L_A5A9
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FE05h
   	     mov     byte ptr [BP-6],AL
   	     jmp     short M00C_L_A5AD
M00C_L_A5A9:
   	     mov     byte ptr [BP-6],0
M00C_L_A5AD:
   	     cmp     byte ptr [BP-5],0
   	     jne     short M00C_L_A5B5
   	     jmp     short M00C_L_A5C8
M00C_L_A5B5:
   	     cmp     byte ptr [BP-6],0
   	     je	     short M00C_L_A5C3
   	     mov     AL,byte ptr [BP-5]
   	     cmp     AL,byte ptr [BP-6]
   	     jbe     short M00C_L_A5C8
M00C_L_A5C3:
   	     mov     AL,byte ptr [BP-5]
   	     jmp     short M00C_L_A5CB
M00C_L_A5C8:
   	     mov     AL,byte ptr [BP-6]
M00C_L_A5CB:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_A3A9   endp
CO04C_TEXT	     ends

; END STOVR70
; BEGIN STOVR71 (listing ovr_1d13_99b3:A5D4)



CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M00D_BCC_DATA_8186	     equ     8186h

   	     public  X04C_03
X04C_03 label   far
BCC_FAR_A5D4    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     or	     SI,SI
   	     jne     short M00D_L_A5E5
   	     mov     AX,SI
   	     jmp     short M00D_L_A624
M00D_L_A5E5:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],2
   	     jle     short M00D_L_A601
   	     cmp     word ptr ES:[SI+2],8
   	     jg	     short M00D_L_A601
   	     mov     BX,word ptr ES:[SI]
   	     cmp     byte ptr [BX+38C1h],0
   	     jne     short M00D_L_A605
M00D_L_A601:
   	     mov     AX,SI
   	     jmp     short M00D_L_A624
M00D_L_A605:
   	     push    SI
   	     db	     0E8h
   	     dw	     0FDA0h
   	     mov     byte ptr [BP-1],AL
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8186
   	     mov     AH,0
   	     cmp     word ptr ES:[SI+2],AX
   	     jne     short M00D_L_A61C
   	     mov     AX,SI
   	     jmp     short M00D_L_A624
M00D_L_A61C:
   	     push    SI
   	     mov     AL,byte ptr [BP-1]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FC51h
M00D_L_A624:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_A5D4    endp
CO04C_TEXT	     ends

; END STOVR71
; BEGIN STOVR72 (listing ovr_1d13_99b3:A62B)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M00E_BCC_DATA_8186	     equ     8186h


   	     public  X04C_05
X04C_05 label   far
BCC_NEAR_A62B   label   near
BCC_FAR_A62B    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],4
   	     je	     short M00E_L_A654
   	     cmp     word ptr ES:[SI],6
   	     je	     short M00E_L_A654
   	     cmp     word ptr ES:[SI],5
   	     je	     short M00E_L_A654
   	     cmp     word ptr ES:[SI],1
   	     je	     short M00E_L_A654
   	     cmp     word ptr ES:[SI],31h
   	     jne     short M00E_L_A659
M00E_L_A654:
   	     mov     AX,1
   	     jmp     short M00E_L_A65B
M00E_L_A659:
   	     xor     AX,AX
M00E_L_A65B:
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_A62B    endp
CO04C_TEXT	     ends

; END STOVR72
; BEGIN STOVR73 (listing ovr_1d13_99b3:A660)



CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M00F_BCC_DATA_80B8	     equ     80B8h
M00F_BCC_DATA_8186	     equ     8186h

   	     public  X04C_01
X04C_01 label   far
BCC_FAR_A660    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8186
   	     mov     DI,word ptr ES:[SI+0Ah]
   	     add     word ptr ES:[SI],-0Bh
   	     push    DI
   	     db	     0E8h
   	     dw	     0009Ah
   	     or	     AX,AX
   	     je	     short M00F_L_A68A
   	     push    DI
   	     db	     0E8h
   	     dw	     0021Ch
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     jmp     short M00F_L_A69C
M00F_L_A68A:
   	     push    DI
   	     db	     0E8h
   	     dw	     000EFh
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
   	     push    DI
   	     db	     0E8h
   	     dw	     0015Ch
   	     mov     DI,AX
M00F_L_A69C:
   	     mov     AX,12h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     push    DI
   	     db	     0E8h
   	     dw	     0014Ah
   	     push    AX
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_A660    endp
CO04C_TEXT	     ends

; END STOVR73
; BEGIN STOVR74 (listing ovr_1d13_99b3:A6B8)



CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M010_BCC_DATA_80B8	     equ     80B8h
M010_BCC_DATA_8186	     equ     8186h

   	     public  X04C_0D
X04C_0D label   far
BCC_FAR_A6B8    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     mov     DI,word ptr ES:[SI+0Ah]
   	     add     word ptr ES:[SI],-10h
   	     push    DI
   	     db	     0E8h
   	     dw	     0003Fh
   	     or	     AX,AX
   	     je	     short M010_L_A6E0
   	     push    DI
   	     db	     0E8h
   	     dw	     001C1h
   	     mov     word ptr [BP-4],AX
   	     jmp     short M010_L_A6F3
M010_L_A6E0:
   	     push    DI
   	     db	     0E8h
   	     dw	     00099h
   	     mov     word ptr [BP-4],AX
   	     push    DI
   	     db	     0E8h
   	     dw	     0010Bh
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
M010_L_A6F3:
   	     mov     AX,29h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     push    word ptr [BP-4]
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     word ptr [BP-2],AX
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_A6B8    endp
CO04C_TEXT	     ends

; END STOVR74
; BEGIN STOVR75 (listing ovr_1d13_99b3:A712)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M011_BCC_DATA_8186	     equ     8186h


BCC_NEAR_A712   proc    near
M011_L_A712:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M011_L_A722
   	     xor     AX,AX
   	     jmp     short M011_L_A777
M011_L_A722:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],7
   	     jg	     short M011_L_A730
   	     xor     AX,AX
   	     jmp     short M011_L_A777
M011_L_A730:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],33h
   	     jne     short M011_L_A743
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFD1h
   	     jmp     short M011_L_A777
M011_L_A743:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],36h
   	     jne     short M011_L_A752
   	     mov     AX,1
   	     jmp     short M011_L_A777
M011_L_A752:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFB5h
   	     or	     AX,AX
   	     jne     short M011_L_A770
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FFA6h
   	     or	     AX,AX
   	     je	     short M011_L_A775
M011_L_A770:
   	     mov     AX,1
   	     jmp     short M011_L_A777
M011_L_A775:
   	     xor     AX,AX
M011_L_A777:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_A712   endp
CO04C_TEXT	     ends

; END STOVR75
; BEGIN STOVR76 (listing ovr_1d13_99b3:A77D)



CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M012_BCC_DATA_8186	     equ     8186h

BCC_NEAR_A77D   proc    near
M012_L_A77D:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M012_L_A78D
   	     xor     AX,AX
   	     jmp     short M012_L_A7F0
M012_L_A78D:
   	     push    SI
   	     db	     0E8h
   	     dw	     000DAh
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],7
   	     jg	     short M012_L_A79F
   	     jmp     short M012_L_A7EE
M012_L_A79F:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],33h
   	     jne     short M012_L_A7AB
   	     jmp     short M012_L_A7DB
M012_L_A7AB:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],23h
   	     je	     short M012_L_A7BB
   	     cmp     word ptr ES:[SI],24h
   	     jne     short M012_L_A7C8
M012_L_A7BB:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFB7h
   	     jmp     short M012_L_A7F0
M012_L_A7C8:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FFAAh
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
M012_L_A7DB:
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FF97h
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
M012_L_A7EE:
   	     mov     AX,SI
M012_L_A7F0:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_A77D   endp
CO04C_TEXT	     ends

; END STOVR76
; BEGIN STOVR77 (listing ovr_1d13_99b3:A7F6)



CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M013_BCC_DATA_8186	     equ     8186h

BCC_NEAR_A7F6   proc    near
M013_L_A7F6:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     or	     SI,SI
   	     jne     short M013_L_A806
   	     xor     AX,AX
   	     jmp     short M013_L_A865
M013_L_A806:
   	     push    SI
   	     db	     0E8h
   	     dw	     00061h
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],7
   	     jg	     short M013_L_A818
   	     jmp     short M013_L_A863
M013_L_A818:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],33h
   	     jne     short M013_L_A824
   	     jmp     short M013_L_A850
M013_L_A824:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],12h
   	     jl	     short M013_L_A83D
   	     cmp     word ptr ES:[SI],1Ch
   	     jg	     short M013_L_A83D
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FFBBh
   	     jmp     short M013_L_A865
M013_L_A83D:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0E8h
   	     dw	     0FFAEh
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ch],AX
M013_L_A850:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ah]
   	     db	     0E8h
   	     dw	     0FF9Bh
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
M013_L_A863:
   	     mov     AX,SI
M013_L_A865:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_A7F6   endp
CO04C_TEXT	     ends

; END STOVR77
; BEGIN STOVR78 (listing ovr_1d13_99b3:A86B)

   	     extrn   BCC_FAR_0402:far
   	     extrn   X043_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M014_BCC_DATA_8186	     equ     8186h

BCC_NEAR_A86B   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,8186h
   	     push    AX
   	     mov     AX,14h
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     push    word ptr DGROUP:M014_BCC_DATA_8186
   	     push    SI
   	     push    word ptr DGROUP:M014_BCC_DATA_8186
   	     push    word ptr [BP+4]
   	     mov     CX,14h
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     mov     AX,SI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_A86B   endp
CO04C_TEXT	     ends

; END STOVR78
; BEGIN STOVR79 (listing ovr_1d13_99b3:A89C)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M015_BCC_DATA_80B0	     equ     80B0h
M015_BCC_DATA_80B8	     equ     80B8h
M015_BCC_DATA_80BC	     equ     80BCh
M015_BCC_DATA_80C4	     equ     80C4h
M015_BCC_DATA_8186	     equ     8186h


BCC_NEAR_A89C   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],33h
   	     jne     short M015_L_A8BB
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     word ptr [BP-2],AX
   	     jmp     short M015_L_A8BE
M015_L_A8BB:
   	     mov     word ptr [BP-2],SI
M015_L_A8BE:
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     mov     DI,word ptr ES:[BX+0Ah]
   	     push    word ptr ES:[DI+8]
   	     db	     0FFh,01Eh
   	     dw	     80C4h
   	     mov     word ptr [BP-0Ah],AX
   	     mov     AX,5
   	     push    AX
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     push    word ptr ES:[DI+8]
   	     push    word ptr [BP-0Ah]
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80BCh
   	     mov     word ptr [BP-4],AX
   	     mov     AX,5
   	     push    AX
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     push    word ptr ES:[DI+8]
   	     push    word ptr [BP-0Ah]
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80BCh
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     mov     word ptr ES:[BX+0Ah],AX
   	     mov     AX,12h
   	     push    AX
   	     push    word ptr ES:[DI+8]
   	     push    word ptr [BP-4]
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     word ptr [BP-6],AX
   	     mov     AX,31h
   	     push    AX
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     push    word ptr ES:[BX+8]
   	     push    word ptr [BP-6]
   	     xor     AX,AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     word ptr [BP-8],AX
   	     mov     ES,word ptr DGROUP:M015_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],33h
   	     jne     short M015_L_A961
   	     push    word ptr [BP-8]
   	     push    word ptr ES:[SI+8]
   	     mov     AL,byte ptr ES:[SI+0Ch]
   	     push    AX
   	     mov     AL,byte ptr ES:[SI+0Dh]
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B0h
   	     mov     word ptr [BP-8],AX
M015_L_A961:
   	     mov     AX,word ptr [BP-8]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_A89C   endp
CO04C_TEXT	     ends

; END STOVR79
; BEGIN STOVR80 (listing ovr_1d13_99b3:A96D)

CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M016_BCC_DATA_80E8	     equ     80E8h
M016_BCC_DATA_8186	     equ     8186h


   	     public  X04C_0B
X04C_0B label   far
BCC_FAR_A96D    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     jmp     short M016_L_A9B7
M016_L_A976:
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI]
   	     dec     BX
   	     cmp     BX,35h
   	     ja	     short M016_L_A993
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0E92h
   	     jmp     short M016_L_A9BB
   	     mov     AX,1
   	     jmp     short M016_L_A9BD
   	     jmp     short M016_L_A9AF
M016_L_A993:
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+0Ch],0
   	     je	     short M016_L_A9AF
   	     push    word ptr ES:[SI+0Ch]
   	     db	     0FFh,01Eh
   	     dw	     80E8h
   	     or	     AX,AX
   	     je	     short M016_L_A9AF
   	     mov     AX,1
   	     jmp     short M016_L_A9BD
M016_L_A9AF:
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8186
   	     mov     SI,word ptr ES:[SI+0Ah]
M016_L_A9B7:
   	     or	     SI,SI
   	     jne     short M016_L_A976
M016_L_A9BB:
   	     xor     AX,AX
M016_L_A9BD:
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_A96D    endp
CO04C_TEXT	     ends

; END STOVR80
; BEGIN STOVT81 (listing ovr_1d13_99b3:A9C2)
CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT

BCC_TABLE_A9C2  label   word
   	     dw	     00E5Ah
   	     dw	     00E5Ah
   	     dw	     00E5Ah
   	     dw	     00E5Ah
   	     dw	     00E5Ah
   	     dw	     00E5Ah
   	     dw	     00E5Ah
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E5Ch
   	     dw	     00E5Ch
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E61h
   	     dw	     00E63h
   	     dw	     00E63h
   	     dw	     00E5Ch

CO04C_TEXT	     ends
; END STOVT81
; BEGIN STOVR82 (listing ovr_1d13_99b3:AA2E)

   	     extrn   X049_03:far


CO04C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO04C_TEXT,ds:DGROUP

M018_BCC_DATA_80B4	     equ     80B4h
M018_BCC_DATA_80B8	     equ     80B8h
M018_BCC_DATA_8108	     equ     8108h
M018_BCC_DATA_8186	     equ     8186h

   	     public  X04C_02
X04C_02 label   far
BCC_NEAR_AA2E   label   near
BCC_FAR_AA2E    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ah]
   	     cmp     word ptr [BP+6],0Eh
   	     jne     short M018_L_AAB3
   	     cmp     word ptr [BP+8],0Fh
   	     je	     short M018_L_AA48
   	     cmp     word ptr [BP+8],10h
   	     jne     short M018_L_AAB3
M018_L_AA48:
   	     mov     ES,word ptr DGROUP:M018_BCC_DATA_8186
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,6
   	     je	     short M018_L_AA69
   	     jg	     short M018_L_AA62
   	     cmp     AX,1
   	     je	     short M018_L_AA69
   	     cmp     AX,5
   	     je	     short M018_L_AA69
   	     jmp     short M018_L_AAB3
M018_L_AA62:
   	     cmp     AX,31h
   	     je	     short M018_L_AA74
   	     jmp     short M018_L_AAB3
M018_L_AA69:
   	     mov     ES,word ptr DGROUP:M018_BCC_DATA_8186
   	     add     word ptr ES:[SI+0Ch],2
   	     jmp     short M018_L_AAB3
M018_L_AA74:
   	     mov     AX,5
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     push    AX
   	     xor     AX,AX
   	     mov     DX,2
   	     push    AX
   	     push    DX
   	     db	     0FFh,01Eh
   	     dw	     80B4h
   	     mov     DI,AX
   	     mov     AX,8
   	     push    AX
   	     mov     ES,word ptr DGROUP:M018_BCC_DATA_8186
   	     mov     BX,word ptr ES:[SI+0Ah]
   	     push    word ptr ES:[BX+8]
   	     push    word ptr ES:[SI+0Ah]
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     DI,AX
   	     push    DI
   	     db	     09Ah
   	     dw	     X049_03
   	     dw	     seg X049_03
   	     mov     ES,word ptr DGROUP:M018_BCC_DATA_8186
   	     mov     word ptr ES:[SI+0Ah],AX
M018_L_AAB3:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    6
BCC_FAR_AA2E    endp
CO04C_TEXT	     ends

; END STOVR82
   	     end
