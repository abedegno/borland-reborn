   	     public  X05B_02
   	     public  X05B_01
   	     public  X05B_00
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d69_a3c6
; BEGIN STAOV06B (listing ovr_1d69_a3c6:3C60)

   	     extrn   X05C_00:far
   	     extrn   X05D_01:far
   	     extrn   X05D_0B:far
   	     extrn   X05E_00:far
   	     extrn   X05F_02:far
   	     extrn   X05F_03:far
   	     extrn   X05F_04:far
   	     extrn   X05F_08:far
   	     extrn   X060_00:far
   	     extrn   X060_01:far
   	     extrn   X061_03:far
   	     extrn   X062_03:far
   	     extrn   X063_00:far
   	     extrn   X063_01:far
   	     extrn   X063_03:far
   	     extrn   X063_04:far
   	     extrn   X063_05:far
   	     extrn   X066_00:far
   	     extrn   X06F_03:far
   	     extrn   X06F_04:far
   	     extrn   X070_00:far
   	     extrn   X071_00:far


CO05B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO05B_TEXT,ds:DGROUP

M000_BCC_DATA_1703	     equ     1703h
M000_BCC_DATA_1707	     equ     1707h
M000_BCC_DATA_1776	     equ     1776h
M000_BCC_DATA_86E6	     equ     86E6h
M000_BCC_DATA_86EC	     equ     86ECh
M000_BCC_DATA_86F3	     equ     86F3h

   	     public  X05B_00
X05B_00 label   far
BCC_FAR_3C60    proc    far
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00115h
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1703,0
   	     je	     short M000_L_3C7C
   	     db	     09Ah
   	     dw	     X06F_03
   	     dw	     seg X06F_03
   	     db	     09Ah
   	     dw	     X06F_04
   	     dw	     seg X06F_04
M000_L_3C7C:
   	     db	     09Ah
   	     dw	     X05D_01
   	     dw	     seg X05D_01
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     000FFh
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1703,0
   	     je	     short M000_L_3C92
   	     db	     09Ah
   	     dw	     X05F_02
   	     dw	     seg X05F_02
M000_L_3C92:
   	     db	     09Ah
   	     dw	     X05E_00
   	     dw	     seg X05E_00
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1707,0
   	     je	     short M000_L_3CB3
   	     db	     09Ah
   	     dw	     X05F_03
   	     dw	     seg X05F_03
   	     mov     word ptr [BP-2],AX
   	     db	     09Ah
   	     dw	     X060_00
   	     dw	     seg X060_00
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X05F_04
   	     dw	     seg X05F_04
M000_L_3CB3:
   	     db	     09Ah
   	     dw	     X05F_08
   	     dw	     seg X05F_08
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X061_03
   	     dw	     seg X061_03
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1707,0
   	     je	     short M000_L_3CCD
   	     db	     09Ah
   	     dw	     X060_00
   	     dw	     seg X060_00
M000_L_3CCD:
   	     db	     09Ah
   	     dw	     X062_03
   	     dw	     seg X062_03
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1703,0
   	     je	     short M000_L_3CE3
   	     db	     09Ah
   	     dw	     X070_00
   	     dw	     seg X070_00
   	     db	     09Ah
   	     dw	     X071_00
   	     dw	     seg X071_00
M000_L_3CE3:
   	     cmp     word ptr DGROUP:M000_BCC_DATA_86EC,0
   	     je	     short M000_L_3D50
   	     xor     SI,SI
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1776,1
   	     je	     short M000_L_3D01
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1776,2
   	     je	     short M000_L_3D01
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1776,4
   	     jne     short M000_L_3D0E
M000_L_3D01:
   	     test    word ptr DGROUP:M000_BCC_DATA_86F3,1
   	     je	     short M000_L_3D27
   	     mov     SI,0FFFEh
   	     jmp     short M000_L_3D27
M000_L_3D0E:
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1776,3
   	     je	     short M000_L_3D1C
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1776,5
   	     jne     short M000_L_3D27
M000_L_3D1C:
   	     test    word ptr DGROUP:M000_BCC_DATA_86F3,80h
   	     je	     short M000_L_3D27
   	     mov     SI,0FFFEh
M000_L_3D27:
   	     push    word ptr DGROUP:M000_BCC_DATA_86EC
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X063_03
   	     dw	     seg X063_03
   	     push    word ptr DGROUP:M000_BCC_DATA_86EC
   	     mov     AX,DGROUP:M000_BCC_DATA_86E6
   	     neg     AX
   	     push    AX
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X063_03
   	     dw	     seg X063_03
   	     add     word ptr DGROUP:M000_BCC_DATA_86E6,SI
   	     db	     09Ah
   	     dw	     X063_05
   	     dw	     seg X063_05
M000_L_3D50:
   	     db	     09Ah
   	     dw	     X063_00
   	     dw	     seg X063_00
   	     db	     09Ah
   	     dw	     X066_00
   	     dw	     seg X066_00
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X063_01
   	     dw	     seg X063_01
   	     db	     09Ah
   	     dw	     X05C_00
   	     dw	     seg X05C_00
   	     db	     09Ah
   	     dw	     X05D_0B
   	     dw	     seg X05D_0B
   	     db	     09Ah
   	     dw	     X060_01
   	     dw	     seg X060_01
   	     db	     09Ah
   	     dw	     X063_04
   	     dw	     seg X063_04
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
BCC_FAR_3C60    endp
CO05B_TEXT	     ends

; END STAOV06B
; BEGIN STAOV06C (listing ovr_1d69_a3c6:3D80)

CO05B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO05B_TEXT,ds:DGROUP



   	     public  X05B_01
X05B_01 label   far
BCC_NEAR_3D80   label   near
BCC_FAR_3D80    proc    far
   	     push    BP
   	     mov     BP,SP
   	     pop     BP
   	     retf
BCC_FAR_3D80    endp
CO05B_TEXT	     ends

; END STAOV06C
; BEGIN STAOV06D (listing ovr_1d69_a3c6:3D85)

   	     extrn   X05C_01:far


CO05B_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO05B_TEXT,ds:DGROUP

M002_BCC_DATA_8654	     equ     8654h
M002_BCC_DATA_86E0	     equ     86E0h
M002_BCC_DATA_8B1A	     equ     8B1Ah

   	     public  X05B_02
X05B_02 label   far
BCC_NEAR_3D85   label   near
BCC_FAR_3D85    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     word ptr DGROUP:M002_BCC_DATA_8B1A,0
   	     mov     SI,word ptr DGROUP:M002_BCC_DATA_86E0
   	     jmp     short M002_L_3DAC
M002_L_3D96:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8654
   	     mov     DI,word ptr ES:[SI+0Ch]
   	     cmp     word ptr ES:[SI],4
   	     jne     short M002_L_3DAA
   	     push    SI
   	     db	     09Ah
   	     dw	     X05C_01
   	     dw	     seg X05C_01
M002_L_3DAA:
   	     mov     SI,DI
M002_L_3DAC:
   	     or	     SI,SI
   	     jne     short M002_L_3D96
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf
BCC_FAR_3D85    endp
CO05B_TEXT	     ends

; END STAOV06D
   	     end
