   	     public  X076_13
   	     public  X076_12
   	     public  X076_11
   	     public  X076_10
   	     public  X076_01
   	     public  X076_03
   	     public  X076_02
   	     public  X076_00
   	     public  X076_07
   	     public  X076_06
   	     public  X076_05
   	     public  X076_04
   	     public  X076_09
   	     public  X076_08
   	     public  X076_0C
   	     public  X076_0B
   	     public  X076_0A
   	     public  X076_0F
   	     public  X076_0E
   	     public  X076_0D
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1dda_b2c2
; BEGIN STAOV16F (listing ovr_1dda_b2c2:2C20)


   	     extrn   X05D_07:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

   	     public  X076_03
X076_03 label   far
BCC_NEAR_2C20   label   near
STAOV16F	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     AX,DI
   	     mov     CL,4
   	     shr     AX,CL
   	     and     AX,0Fh
   	     mov     SI,AX
   	     cmp     SI,0Ah
   	     jge     short M000_L_2C3D
   	     add     AX,30h
   	     jmp     short M000_L_2C42
M000_L_2C3D:
   	     mov     AX,SI
   	     add     AX,37h
M000_L_2C42:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     AX,DI
   	     and     AX,0Fh
   	     mov     SI,AX
   	     cmp     SI,0Ah
   	     jge     short M000_L_2C59
   	     add     AX,30h
   	     jmp     short M000_L_2C5E
M000_L_2C59:
   	     mov     AX,SI
   	     add     AX,37h
M000_L_2C5E:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV16F	     endp
CO076_TEXT	     ends

; END STAOV16F
; BEGIN STAOV170 (listing ovr_1dda_b2c2:2C6A)


   	     extrn   X05D_0A:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

   	     public  X076_04
X076_04 label   far
STAOV170	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,55B9h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     BP
   	     retf
STAOV170	     endp
CO076_TEXT	     ends

; END STAOV170
; BEGIN STAOV171 (listing ovr_1dda_b2c2:2C79)


   	     extrn   X05D_04:far
   	     extrn   X05D_0A:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

   	     public  X076_05
X076_05 label   far
STAOV171	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X05D_04
   	     dw	     seg X05D_04
   	     push    DS
   	     mov     AX,55C5h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     BP
   	     retf    2
STAOV171	     endp
CO076_TEXT	     ends

; END STAOV171
; BEGIN STAOV172 (listing ovr_1dda_b2c2:2C92)


   	     extrn   X05D_09:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

   	     public  X076_0C
X076_0C label   far
STAOV172	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X05D_09
   	     dw	     seg X05D_09
   	     pop     BP
   	     retf    2
STAOV172	     endp
CO076_TEXT	     ends

; END STAOV172
; BEGIN STAOV173 (listing ovr_1dda_b2c2:2CA1)


   	     extrn   X05D_02:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

   	     public  X076_08
X076_08 label   far
STAOV173	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    word ptr [BP+0Ah]
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X05D_02
   	     dw	     seg X05D_02
   	     pop     BP
   	     retf    6
STAOV173	     endp
CO076_TEXT	     ends

; END STAOV173
; BEGIN STAOV174 (listing ovr_1dda_b2c2:2CB6)

   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M005_BCC_DATA_80C0	     equ     80C0h

   	     public  X076_0E
X076_0E label   far
STAOV174	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+8]
   	     push    DS
   	     mov     AX,55D1h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     mov     AX,55DEh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     or	     SI,SI
   	     je	     short M005_L_2CDA
   	     mov     AX,4
   	     jmp     short M005_L_2CDD
M005_L_2CDA:
   	     mov     AX,2
M005_L_2CDD:
   	     mov     DX,word ptr [BP+6]
   	     add     DX,AX
   	     push    DX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,55EBh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     or	     SI,SI
   	     je	     short M005_L_2D04
   	     mov     AX,55EEh
   	     jmp     short M005_L_2D07
M005_L_2D04:
   	     mov     AX,55FEh
M005_L_2D07:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [BP+0Ch]
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     SI
   	     pop     BP
   	     retf    8
STAOV174	     endp
CO076_TEXT	     ends

; END STAOV174
; BEGIN STAOV175 (listing ovr_1dda_b2c2:2D23)

   	     extrn   BCC_FAR_0402:far
   	     extrn   BCC_FAR_5B44:far
   	     extrn   BCC_FAR_5E22:far
   	     extrn   BCC_FAR_AB12:far
   	     extrn   BCC_FAR_B072:far
   	     extrn   BCC_FAR_B146:far
   	     extrn   X043_03:far
   	     extrn   X05D_0A:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M006_BCC_DATA_16F0	     equ     16F0h
M006_BCC_DATA_16F3	     equ     16F3h
M006_BCC_DATA_7846	     equ     7846h
M006_BCC_DATA_8646	     equ     8646h
M006_BCC_DATA_86D2	     equ     86D2h

   	     public  X076_01
X076_01 label   far
STAOV175	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,50h
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     push    word ptr DGROUP:M006_BCC_DATA_7846
   	     push    word ptr DGROUP:M006_BCC_DATA_8646
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     mov     AX,87CCh
   	     push    DS
   	     push    AX
   	     mov     AX,5552h
   	     push    DS
   	     push    AX
   	     mov     CX,60h
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     test    word ptr DGROUP:M006_BCC_DATA_86D2,1
   	     jne     short M006_L_2D8F
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     push    DS
   	     mov     AX,560Fh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B146
   	     dw	     seg BCC_FAR_B146
   	     push    DS
   	     mov     AX,7846h
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     inc     AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     DGROUP:M006_BCC_DATA_8646,AX
   	     push    word ptr DGROUP:M006_BCC_DATA_7846
   	     push    word ptr DGROUP:M006_BCC_DATA_8646
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
M006_L_2D8F:
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5E22
   	     dw	     seg BCC_FAR_5E22
   	     cmp     AX,0FFFFh
   	     jne     short M006_L_2DAF
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     mov     AX,5
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     add     SP,6
M006_L_2DAF:
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_16F0,1
   	     jne     short M006_L_2DD3
   	     push    DS
   	     mov     AX,5614h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_16F3,2
   	     jne     short M006_L_2DF5
   	     push    DS
   	     mov     AX,561Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     jmp     short M006_L_2DF5
M006_L_2DD3:
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_16F0,2
   	     jne     short M006_L_2DF5
   	     push    DS
   	     mov     AX,5624h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_16F3,2
   	     jne     short M006_L_2DF5
   	     push    DS
   	     mov     AX,561Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M006_L_2DF5:
   	     push    DS
   	     mov     AX,562Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     mov     AX,5730h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV175	     endp
CO076_TEXT	     ends

; END STAOV175
; BEGIN STAOV176 (listing ovr_1dda_b2c2:2E1A)

   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X05D_0E:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M007_BCC_DATA_8894	     equ     8894h
M007_BCC_DATA_889E	     equ     889Eh

BCC_NEAR_2E1A   label   near
STAOV176	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     xor     DI,DI
   	     mov     SI,word ptr DGROUP:M007_BCC_DATA_889E
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8894
   	     push    word ptr ES:[BX+4]
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     push    DS
   	     mov     AX,5734h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     jmp     short M007_L_2E7B
M007_L_2E46:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8894
   	     mov     AX,word ptr ES:[SI+2]
   	     cmp     AX,word ptr [BP+4]
   	     jne     short M007_L_2E74
   	     or	     DI,DI
   	     je	     short M007_L_2E60
   	     mov     AX,2Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M007_L_2E60:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8894
   	     push    word ptr ES:[SI+11h]
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     mov     DI,1
M007_L_2E74:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M007_L_2E7B:
   	     or	     SI,SI
   	     jne     short M007_L_2E46
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV176	     endp
CO076_TEXT	     ends

; END STAOV176
; BEGIN STAOV177 (listing ovr_1dda_b2c2:2E90)

   	     extrn   X056_0D:far
   	     extrn   X05D_0A:far
   	     extrn   X05D_0E:far
   	     extrn   X077_06:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M008_BCC_DATA_8652	     equ     8652h
M008_BCC_DATA_8664	     equ     8664h
M008_BCC_STMT_CURRENT   equ     86C8h
M008_BCC_DATA_8894	     equ     8894h
M008_BCC_DATA_88A6	     equ     88A6h
M008_BCC_DATA_88AC	     equ     88ACh
M008_BCC_DATA_8B48	     equ     8B48h

   	     public  X076_0A
X076_0A label   far
STAOV177	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     db	     81h,0Eh,0ACh,88h,01h,00h
   	     push    word ptr DGROUP:M008_BCC_DATA_8664
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     mov     SI,word ptr DGROUP:M008_BCC_DATA_88A6
   	     jmp     short M008_L_2EC7
M008_L_2EB2:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     mov     word ptr ES:[SI+2],0
   	     push    SI
   	     db	     0E8h
   	     dw	     0FF5Ah
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M008_L_2EC7:
   	     or	     SI,SI
   	     jne     short M008_L_2EB2
   	     push    DS
   	     mov     AX,573Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr DGROUP:M008_BCC_DATA_8664
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     cmp     word ptr ES:[DI+2],0
   	     je	     short M008_L_2EF5
   	     mov     BX,word ptr ES:[DI+2]
   	     mov     AX,word ptr ES:[BX+4]
   	     jmp     short M008_L_2EFD
M008_L_2EF5:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     mov     AX,word ptr ES:[DI+11h]
M008_L_2EFD:
   	     push    AX
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     push    DS
   	     mov     AX,5748h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr DGROUP:M008_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     cmp     word ptr ES:[DI+2],0
   	     je	     short M008_L_2F31
   	     mov     BX,word ptr ES:[DI+2]
   	     mov     AX,word ptr ES:[BX+4]
   	     jmp     short M008_L_2F39
M008_L_2F31:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     mov     AX,word ptr ES:[DI+11h]
M008_L_2F39:
   	     push    AX
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr DGROUP:M008_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     push    DS
   	     mov     AX,574Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr DGROUP:M008_BCC_DATA_8652
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     push    DS
   	     mov     AX,576Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     word ptr DGROUP:M008_BCC_DATA_8B48,0
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf
STAOV177	     endp
CO076_TEXT	     ends

; END STAOV177
; BEGIN STAOV178 (listing ovr_1dda_b2c2:2F7D)

   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X077_01:far
   	     extrn   X077_06:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M009_BCC_DATA_811C	     equ     811Ch
M009_BCC_DATA_8664	     equ     8664h
M009_BCC_DATA_86B0	     equ     86B0h
M009_BCC_DATA_86B4	     equ     86B4h
M009_BCC_STMT_CURRENT   equ     86C8h
M009_BCC_DATA_86D2	     equ     86D2h
M009_BCC_DATA_8894	     equ     8894h
M009_BCC_DATA_88A6	     equ     88A6h
M009_BCC_DATA_88AC	     equ     88ACh

   	     public  X076_07
X076_07 label   far
STAOV178	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     push    DS
   	     mov     AX,578Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,DGROUP:M009_BCC_DATA_88A6
   	     jmp     short M009_L_2FB2
M009_L_2F94:
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8894
   	     cmp     word ptr ES:[BX+2],0
   	     je	     short M009_L_2FA8
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0FE72h
M009_L_2FA8:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8894
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr ES:[BX]
M009_L_2FB2:
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     jne     short M009_L_2F94
   	     push    word ptr DGROUP:M009_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     push    DS
   	     mov     AX,579Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     xor     SI,SI
   	     xor     DI,DI
   	     db	     0E9h
   	     dw	     0009Eh
M009_L_2FD5:
   	     push    DS
   	     mov     AX,57ACh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_86B0
   	     cmp     byte ptr ES:[SI],20h
   	     jl	     short M009_L_3059
   	     cmp     byte ptr ES:[SI],7Eh
   	     jg	     short M009_L_3059
   	     cmp     byte ptr ES:[SI],27h
   	     je	     short M009_L_3059
   	     mov     AX,27h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_86B0
   	     mov     AL,byte ptr ES:[SI]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     word ptr [BP-4],0
   	     jmp     short M009_L_3048
M009_L_3013:
   	     mov     AX,DI
   	     inc     AX
   	     cmp     AX,word ptr DGROUP:M009_BCC_DATA_86B4
   	     je	     short M009_L_304E
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_86B0
   	     cmp     byte ptr ES:[SI+1],20h
   	     jl	     short M009_L_304E
   	     cmp     byte ptr ES:[SI+1],7Eh
   	     jg	     short M009_L_304E
   	     cmp     byte ptr ES:[SI+1],27h
   	     je	     short M009_L_304E
   	     inc     SI
   	     inc     DI
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_86B0
   	     mov     AL,byte ptr ES:[SI]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     inc     word ptr [BP-4]
M009_L_3048:
   	     cmp     word ptr [BP-4],3Ch
   	     jl	     short M009_L_3013
M009_L_304E:
   	     mov     AX,27h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     jmp     short M009_L_3067
M009_L_3059:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_86B0
   	     mov     AL,byte ptr ES:[SI]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_01
   	     dw	     seg X077_01
M009_L_3067:
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     inc     SI
   	     inc     DI
M009_L_3073:
   	     cmp     DI,word ptr DGROUP:M009_BCC_DATA_86B4
   	     jnc     short M009_L_307C
   	     db	     0E9h
   	     dw	     0FF59h
M009_L_307C:
   	     push    word ptr DGROUP:M009_BCC_DATA_8664
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     test    word ptr DGROUP:M009_BCC_DATA_88AC,2
   	     je	     short M009_L_3097
   	     push    DS
   	     mov     AX,57B1h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M009_L_3097:
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_06
   	     dw	     seg X077_06
   	     test    word ptr DGROUP:M009_BCC_DATA_86D2,2
   	     je	     short M009_L_30B1
   	     push    DS
   	     mov     AX,57C7h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M009_L_30B1:
   	     db	     0FFh,01Eh
   	     dw	     811Ch
   	     push    DS
   	     mov     AX,57E2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf
STAOV178	     endp
CO076_TEXT	     ends

; END STAOV178
; BEGIN STAOV179 (listing ovr_1dda_b2c2:30C5)

   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M00A_BCC_DATA_86F5	     equ     86F5h
M00A_BCC_DATA_8894	     equ     8894h
M00A_BCC_DATA_88A2	     equ     88A2h

   	     public  X076_09
X076_09 label   far
STAOV179	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,57EAh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr DGROUP:M00A_BCC_DATA_86F5
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,57FDh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,5800h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     BX,word ptr DGROUP:M00A_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8894
   	     add     word ptr ES:[BX+0Ch],5
   	     adc     word ptr ES:[BX+0Eh],0
   	     pop     BP
   	     retf    2
STAOV179	     endp
CO076_TEXT	     ends

; END STAOV179
; BEGIN STAOV17A (listing ovr_1dda_b2c2:310D)

   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M00B_BCC_DATA_86F5	     equ     86F5h

   	     public  X076_0B
X076_0B label   far
STAOV17A	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,5807h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,40h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     push    word ptr DGROUP:M00B_BCC_DATA_86F5
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,57FDh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     BP
   	     retf    2
STAOV17A	     endp
CO076_TEXT	     ends

; END STAOV17A
; BEGIN STAOV17B (listing ovr_1dda_b2c2:314C)

   	     extrn   X035_01:far
   	     extrn   X056_0D:far
   	     extrn   X05D_0A:far
   	     extrn   X05D_0E:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M00C_BCC_DATA_16EF	     equ     16EFh
M00C_BCC_STMT_CURRENT   equ     86C8h
M00C_BCC_DATA_8894	     equ     8894h
M00C_BCC_DATA_88AC	     equ     88ACh

   	     public  X076_12
X076_12 label   far
STAOV17B	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     cmp     byte ptr DGROUP:M00C_BCC_DATA_16EF,0
   	     jne     short M00C_L_3186
   	     push    DS
   	     mov     AX,5817h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     mov     AL,6
   	     push    AX
   	     db	     09Ah
   	     dw	     X035_01
   	     dw	     seg X035_01
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     mov     AX,581Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     db	     81h,0Eh,0ACh,88h,02h,00h
   	     jmp     short M00C_L_31E8
M00C_L_3186:
   	     push    DS
   	     mov     AX,5817h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     mov     AL,6
   	     push    AX
   	     db	     09Ah
   	     dw	     X035_01
   	     dw	     seg X035_01
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     mov     AX,55ECh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr DGROUP:M00C_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M00C_L_31CD
   	     mov     BX,word ptr ES:[SI+2]
   	     push    word ptr ES:[BX+4]
   	     jmp     short M00C_L_31D5
M00C_L_31CD:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8894
   	     push    word ptr ES:[SI+11h]
M00C_L_31D5:
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M00C_L_31E8:
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV17B	     endp
CO076_TEXT	     ends

; END STAOV17B
; BEGIN STAOV17C (listing ovr_1dda_b2c2:31ED)

   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M00D_BCC_DATA_8894	     equ     8894h
M00D_BCC_DATA_88A2	     equ     88A2h

   	     public  X076_13
X076_13 label   far
STAOV17C	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,582Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,5803h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     add     word ptr ES:[BX+0Ch],5
   	     adc     word ptr ES:[BX+0Eh],0
   	     pop     BP
   	     retf    2
STAOV17C	     endp
CO076_TEXT	     ends

; END STAOV17C
; BEGIN STAOV17D (listing ovr_1dda_b2c2:3222)

   	     extrn   X05D_0A:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M00E_BCC_DATA_16F0	     equ     16F0h

   	     public  X076_0F
X076_0F label   far
STAOV17D	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     byte ptr DGROUP:M00E_BCC_DATA_16F0,0
   	     jne     short M00E_L_3232
   	     push    DS
   	     mov     AX,5841h
   	     jmp     short M00E_L_3236
M00E_L_3232:
   	     push    DS
   	     mov     AX,5860h
M00E_L_3236:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     BP
   	     retf
STAOV17D	     endp
CO076_TEXT	     ends

; END STAOV17D
; BEGIN STAOV17E (listing ovr_1dda_b2c2:323E)

   	     extrn   BCC_FAR_AB12:far
   	     extrn   X037_00:far
   	     extrn   X05D_0A:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M00F_BCC_DATA_16FE	     equ     16FEh
M00F_BCC_DATA_5924	     equ     5924h

   	     public  X076_0D
X076_0D label   far
STAOV17E	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     cmp     byte ptr DGROUP:M00F_BCC_DATA_16FE,0
   	     je	     short M00F_L_324F
   	     db	     0E9h
   	     dw	     000B0h
M00F_L_324F:
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     mov     word ptr [BP-0Ch],AX
   	     mov     AX,DGROUP:M00F_BCC_DATA_5924
   	     mov     word ptr [BP-6],AX
   	     mov     word ptr DGROUP:M00F_BCC_DATA_5924,0FFFFh
   	     push    DS
   	     mov     AX,5873h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,0E9h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9A5h
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X037_00
   	     dw	     seg X037_00
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     AL,byte ptr [BP-4]
   	     cbw
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F98Bh
   	     mov     AL,byte ptr [BP-3]
   	     cbw
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F982h
   	     mov     AL,byte ptr [BP-2]
   	     cbw
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F979h
   	     mov     AL,byte ptr [BP-1]
   	     cbw
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F970h
   	     push    word ptr [BP-0Ch]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F969h
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     mov     word ptr [BP-8],AX
   	     mov     word ptr [BP-0Ah],DX
M00F_L_32C3:
   	     xor     SI,SI
M00F_L_32C5:
   	     les     BX,[BP-0Ah]
   	     mov     AL,byte ptr ES:[BX]
   	     cbw
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F94Fh
   	     inc     word ptr [BP-0Ah]
   	     les     BX,[BP-0Ah]
   	     cmp     byte ptr ES:[BX],0
   	     je	     short M00F_L_32EF
   	     inc     SI
   	     cmp     SI,14h
   	     jle     short M00F_L_32C5
   	     push    DS
   	     mov     AX,587Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     jmp     short M00F_L_32C3
M00F_L_32EF:
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,word ptr [BP-6]
   	     mov     DGROUP:M00F_BCC_DATA_5924,AX
M00F_L_32FF:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV17E	     endp
CO076_TEXT	     ends

; END STAOV17E
; BEGIN STAOV17F (listing ovr_1dda_b2c2:3306)



CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M010_BCC_DATA_16F3	     equ     16F3h
M010_BCC_DATA_8B28	     equ     8B28h
M010_BCC_DATA_8B2C	     equ     8B2Ch
M010_BCC_DATA_8B31	     equ     8B31h

   	     public  X076_06
X076_06 label   far
BCC_NEAR_3306   label   near
STAOV17F	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+4]
   	     mov     AX,DI
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     word ptr [BP-4],AX
   	     mov     AX,8B28h
   	     push    AX
   	     push    DI
   	     db	     0E8h
   	     dw	     0007Fh
   	     push    AX
   	     mov     AX,8B31h
   	     push    AX
   	     push    DI
   	     db	     0E8h
   	     dw	     00076h
   	     pop     DX
   	     add     DX,AX
   	     mov     SI,DX
   	     cmp     DI,57h
   	     jne     short M010_L_3342
   	     cmp     byte ptr DGROUP:M010_BCC_DATA_16F3,1
   	     jne     short M010_L_3342
   	     inc     SI
M010_L_3342:
   	     mov     BX,word ptr [BP-4]
   	     mov     AL,byte ptr [BX+2]
   	     cbw
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],-1
   	     jne     short M010_L_3364
   	     cmp     word ptr DGROUP:M010_BCC_DATA_8B28,1
   	     jne     short M010_L_335E
   	     mov     AX,SI
   	     inc     AX
   	     jmp     short M010_L_339D
M010_L_335E:
   	     mov     AX,SI
   	     inc     AX
   	     inc     AX
   	     jmp     short M010_L_339D
M010_L_3364:
   	     cmp     word ptr [BP-2],-2
   	     jne     short M010_L_3398
   	     cmp     word ptr DGROUP:M010_BCC_DATA_8B31,4
   	     jne     short M010_L_3392
   	     cmp     word ptr DGROUP:M010_BCC_DATA_8B28,1
   	     jne     short M010_L_3392
   	     cmp     byte ptr DGROUP:M010_BCC_DATA_8B2C,0
   	     jne     short M010_L_3392
   	     mov     BX,word ptr [BP-4]
   	     cmp     byte ptr [BX+7],2
   	     jne     short M010_L_338D
   	     mov     AX,3
   	     jmp     short M010_L_339D
M010_L_338D:
   	     mov     AX,2
   	     jmp     short M010_L_339D
M010_L_3392:
   	     mov     AX,SI
   	     inc     AX
   	     inc     AX
   	     jmp     short M010_L_339D
M010_L_3398:
   	     mov     AX,SI
   	     add     AX,word ptr [BP-2]
M010_L_339D:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV17F	     endp
CO076_TEXT	     ends

; END STAOV17F
; BEGIN STAOV180 (listing ovr_1dda_b2c2:33A6)

CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP



BCC_NEAR_33A6   label   near
STAOV180	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     AX,word ptr [BP+4]
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     CX,AX
   	     mov     BX,word ptr [SI]
   	     dec     BX
   	     dec     BX
   	     cmp     BX,3
   	     jbe     short M011_L_33C8
   	     db	     0E9h
   	     dw	     0007Fh
M011_L_33C8:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     830h
   	     mov     BX,CX
   	     cmp     byte ptr [BX+7],0
   	     jne     short M011_L_33DC
   	     mov     AX,1
   	     jmp     short M011_L_3449
M011_L_33DC:
   	     mov     BX,CX
   	     mov     AX,word ptr [BX+3]
   	     and     AX,8000h
   	     or	     AX,0
   	     jne     short M011_L_33EE
   	     mov     AX,2
   	     jmp     short M011_L_3449
M011_L_33EE:
   	     cmp     word ptr [SI+5],7Fh
   	     jg	     short M011_L_33FA
   	     cmp     word ptr [SI+5],-80h
   	     jge     short M011_L_33FF
M011_L_33FA:
   	     mov     AX,2
   	     jmp     short M011_L_3449
M011_L_33FF:
   	     mov     AX,1
   	     jmp     short M011_L_3449
   	     mov     AX,2
   	     jmp     short M011_L_3449
   	     xor     DI,DI
   	     cmp     byte ptr [SI+2],0FFh
   	     je	     short M011_L_3412
   	     inc     DI
M011_L_3412:
   	     cmp     word ptr [SI+7],0
   	     je	     short M011_L_341C
   	     inc     DI
   	     inc     DI
   	     jmp     short M011_L_3443
M011_L_341C:
   	     cmp     byte ptr [SI+4],0FFh
   	     jne     short M011_L_342C
   	     cmp     byte ptr [SI+3],0FFh
   	     jne     short M011_L_342C
   	     inc     DI
   	     inc     DI
   	     jmp     short M011_L_3443
M011_L_342C:
   	     cmp     word ptr [SI+5],-80h
   	     jl	     short M011_L_3438
   	     cmp     word ptr [SI+5],7Fh
   	     jle     short M011_L_343C
M011_L_3438:
   	     inc     DI
   	     inc     DI
   	     jmp     short M011_L_3443
M011_L_343C:
   	     cmp     word ptr [SI+5],0
   	     je	     short M011_L_3443
   	     inc     DI
M011_L_3443:
   	     mov     AX,DI
   	     jmp     short M011_L_3449
M011_L_3447:
   	     xor     AX,AX
M011_L_3449:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
STAOV180	     endp
CO076_TEXT	     ends

; END STAOV180
; BEGIN STAOV182 (listing ovr_1dda_b2c2:3450)
CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT

STAOV182	     label   word
   	     dw	     007E4h
   	     dw	     007E4h
   	     dw	     007AFh
   	     dw	     007E9h

CO076_TEXT	     ends
; END STAOV182
; BEGIN STAOV181 (listing ovr_1dda_b2c2:3458)

   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M013_BCC_DATA_16EF	     equ     16EFh
M013_BCC_DATA_8134	     equ     8134h
M013_BCC_DATA_8150	     equ     8150h
M013_BCC_DATA_86D6	     equ     86D6h
M013_BCC_DATA_86F3	     equ     86F3h
M013_BCC_DATA_8894	     equ     8894h
M013_BCC_DATA_88A2	     equ     88A2h
M013_BCC_DATA_8B28	     equ     8B28h
M013_BCC_DATA_8B2C	     equ     8B2Ch
M013_BCC_DATA_8B2D	     equ     8B2Dh
M013_BCC_DATA_8B2F	     equ     8B2Fh
M013_BCC_DATA_8B31	     equ     8B31h
M013_BCC_DATA_8B36	     equ     8B36h

   	     public  X076_11
X076_11 label   far
STAOV181	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     push    SI
   	     db	     0E8h
   	     dw	     0FE9Fh
   	     cwd
   	     mov     BX,word ptr DGROUP:M013_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8894
   	     add     word ptr ES:[BX+0Ch],AX
   	     adc     word ptr ES:[BX+0Eh],DX
   	     mov     AX,SI
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     DI,AX
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     cmp     SI,78h
   	     jne     short M013_L_34DC
   	     mov     AX,DGROUP:M013_BCC_DATA_8B2F
   	     mov     word ptr [BP-4],AX
   	     cmp     byte ptr DGROUP:M013_BCC_DATA_16EF,0
   	     je	     short M013_L_34C7
   	     cmp     word ptr [BP-4],0
   	     jne     short M013_L_34A8
   	     db	     0E9h
   	     dw	     000B8h
M013_L_34A8:
   	     push    word ptr [BP-4]
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     cmp     AX,2
   	     jne     short M013_L_34B7
   	     db	     0E9h
   	     dw	     000A9h
M013_L_34B7:
   	     push    word ptr [BP-4]
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     cmp     AX,word ptr DGROUP:M013_BCC_DATA_86D6
   	     je	     short M013_L_34C7
   	     db	     0E9h
   	     dw	     00099h
M013_L_34C7:
   	     push    DS
   	     mov     AX,588Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,12h
   	     push    AX
   	     db	     0E9h
   	     dw	     00273h
M013_L_34DC:
   	     cmp     SI,0A1h
   	     jne     short M013_L_34F1
   	     test    word ptr DGROUP:M013_BCC_DATA_86F3,1
   	     jne     short M013_L_34F1
   	     push    DS
   	     mov     AX,589Ch
   	     db	     0E9h
   	     dw	     00265h
M013_L_34F1:
   	     cmp     SI,0C8h
   	     jl	     short M013_L_3511
   	     cmp     SI,0CAh
   	     jg	     short M013_L_3511
   	     push    DS
   	     push    word ptr [DI]
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,20h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     db	     0E9h
   	     dw	     0024Bh
M013_L_3511:
   	     mov     AX,word ptr [DI+3]
   	     and     AX,2
   	     or	     AX,0
   	     je	     short M013_L_3560
   	     cmp     SI,82h
   	     jl	     short M013_L_3536
   	     cmp     SI,84h
   	     jg	     short M013_L_3536
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B28,0
   	     jne     short M013_L_3536
   	     push    DS
   	     mov     AX,58A6h
   	     db	     0E9h
   	     dw	     00220h
M013_L_3536:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B31,1
   	     jne     short M013_L_3560
   	     push    DS
   	     push    word ptr [DI]
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     mov     AX,58AFh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,DGROUP:M013_BCC_DATA_8B2C
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,58B5h
   	     db	     0E9h
   	     dw	     001F6h
M013_L_3560:
   	     push    DS
   	     push    word ptr [DI]
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     BX,SI
   	     cmp     BX,3Dh
   	     jne     short M013_L_357B
   	     db	     0E9h
   	     dw	     000E7h
M013_L_357B:
   	     jg	     short M013_L_358F
   	     sub     BX,20h
   	     cmp     BX,1Ch
   	     jbe     short M013_L_3588
   	     db	     0E9h
   	     dw	     00154h
M013_L_3588:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0B70h
M013_L_358F:
   	     cmp     BX,82h
   	     jne     short M013_L_3598
   	     db	     0E9h
   	     dw	     000CAh
M013_L_3598:
   	     jg	     short M013_L_35E6
   	     cmp     BX,76h
   	     jne     short M013_L_35A2
   	     db	     0E9h
   	     dw	     0011Bh
M013_L_35A2:
   	     jg	     short M013_L_35D4
   	     cmp     BX,42h
   	     jne     short M013_L_35AC
   	     db	     0E9h
   	     dw	     00105h
M013_L_35AC:
   	     jg	     short M013_L_35C1
   	     cmp     BX,3Fh
   	     jne     short M013_L_35B6
   	     db	     0E9h
   	     dw	     000FBh
M013_L_35B6:
   	     cmp     BX,41h
   	     jne     short M013_L_35BE
   	     db	     0E9h
   	     dw	     000F3h
M013_L_35BE:
   	     db	     0E9h
   	     dw	     0011Bh
M013_L_35C1:
   	     cmp     BX,43h
   	     jne     short M013_L_35C9
   	     db	     0E9h
   	     dw	     000E8h
M013_L_35C9:
   	     cmp     BX,72h
   	     jne     short M013_L_35D1
   	     db	     0E9h
   	     dw	     000C3h
M013_L_35D1:
   	     db	     0E9h
   	     dw	     00108h
M013_L_35D4:
   	     sub     BX,77h
   	     cmp     BX,5
   	     jbe     short M013_L_35DF
   	     db	     0E9h
   	     dw	     000FDh
M013_L_35DF:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0B64h
M013_L_35E6:
   	     cmp     BX,92h
   	     jne     short M013_L_35EF
   	     db	     0E9h
   	     dw	     00095h
M013_L_35EF:
   	     jg	     short M013_L_3604
   	     sub     BX,83h
   	     cmp     BX,0Ah
   	     jbe     short M013_L_35FD
   	     db	     0E9h
   	     dw	     000DFh
M013_L_35FD:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0B4Eh
M013_L_3604:
   	     sub     BX,0A1h
   	     cmp     BX,4
   	     jbe     short M013_L_3610
   	     db	     0E9h
   	     dw	     000CCh
M013_L_3610:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0B44h
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B31,0
   	     je	     short M013_L_362A
   	     push    word ptr DGROUP:M013_BCC_DATA_8B36
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     db	     0E9h
   	     dw	     00128h
M013_L_362A:
   	     db	     0E9h
   	     dw	     00125h
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B28,4
   	     je	     short M013_L_363D
   	     push    word ptr DGROUP:M013_BCC_DATA_8B2F
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     004BDh
M013_L_363D:
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E9h
   	     dw	     00108h
   	     push    DS
   	     mov     AX,58B1h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,DGROUP:M013_BCC_DATA_8B2C
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,58BDh
   	     db	     0E9h
   	     dw	     000F4h
M013_L_3662:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B28,1
   	     jne     short M013_L_36DC
   	     push    DS
   	     mov     AX,58C1h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,DGROUP:M013_BCC_DATA_8B2C
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,58BDh
   	     db	     0E9h
   	     dw	     000D2h
M013_L_3684:
   	     push    word ptr DGROUP:M013_BCC_DATA_8B36
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,58CBh
   	     db	     0E9h
   	     dw	     000C2h
M013_L_3694:
   	     push    word ptr DGROUP:M013_BCC_DATA_8B2D
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     db	     0E9h
   	     dw	     000B2h
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B28,4
   	     jne     short M013_L_36B1
   	     push    DS
   	     mov     AX,58D0h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M013_L_36B1:
   	     mov     AX,8B31h
   	     push    AX
   	     push    SI
   	     db	     0E8h
   	     dw	     00111h
   	     push    AX
   	     db	     0E9h
   	     dw	     00092h
M013_L_36BD:
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,7
   	     push    AX
   	     db	     0E9h
   	     dw	     00087h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,15h
   	     push    AX
   	     jmp     short M013_L_374F
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,12h
   	     push    AX
   	     jmp     short M013_L_374F
M013_L_36DC:
   	     cmp     SI,5Dh
   	     jne     short M013_L_36E8
   	     mov     word ptr [BP-2],7
   	     jmp     short M013_L_36EF
M013_L_36E8:
   	     push    SI
   	     db	     0E8h
   	     dw	     000DEh
   	     mov     word ptr [BP-2],AX
M013_L_36EF:
   	     mov     AX,SI
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     cmp     byte ptr [BX+3FA1h],1
   	     jne     short M013_L_3709
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,1
   	     push    AX
   	     jmp     short M013_L_3710
M013_L_3709:
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [BP-2]
M013_L_3710:
   	     db	     0E8h
   	     dw	     000D7h
   	     cmp     word ptr DGROUP:M013_BCC_DATA_8B31,0
   	     je	     short M013_L_3752
   	     mov     AX,2Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     mov     AX,SI
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     cmp     byte ptr [BX+3FA2h],7
   	     je	     short M013_L_3743
   	     mov     AX,SI
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     cmp     byte ptr [BX+3FA2h],1
   	     jne     short M013_L_3748
M013_L_3743:
   	     mov     word ptr [BP-2],1
M013_L_3748:
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [BP-2]
M013_L_374F:
   	     db	     0E8h
   	     dw	     00098h
M013_L_3752:
   	     push    DS
   	     mov     AX,55C2h
M013_L_3756:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M013_L_375C:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
STAOV181	     endp
CO076_TEXT	     ends

; END STAOV181
; BEGIN STAOV183 (listing ovr_1dda_b2c2:3764)
CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT

STAOV183	     label   word
   	     dw	     009F7h
   	     dw	     009F7h
   	     dw	     00ABCh
   	     dw	     00A0Dh
   	     dw	     00A0Dh
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00A27h
   	     dw	     00A27h
   	     dw	     00AB2h
   	     dw	     00AA8h
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00A0Dh
   	     dw	     00A0Dh
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00ABCh
   	     dw	     00ABCh
   	     dw	     00A91h
   	     dw	     00A80h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A91h
   	     dw	     00A91h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h
   	     dw	     00A42h

CO076_TEXT	     ends
; END STAOV183
; BEGIN STAOV184 (listing ovr_1dda_b2c2:37CA)

CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP



BCC_NEAR_37CA   label   near
STAOV184	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,word ptr [BP+4]
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+3FA0h]
   	     mov     AH,0
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+55B2h]
   	     cbw
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV184	     endp
CO076_TEXT	     ends

; END STAOV184
; BEGIN STAOV185 (listing ovr_1dda_b2c2:37EA)

   	     extrn   X035_01:far
   	     extrn   X056_0D:far
   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X05D_0E:far
   	     extrn   X077_01:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M016_BCC_DATA_80C0	     equ     80C0h
M016_BCC_DATA_8134	     equ     8134h
M016_BCC_DATA_8150	     equ     8150h
M016_BCC_DATA_8160	     equ     8160h
M016_BCC_STMT_CURRENT   equ     86C8h
M016_BCC_DATA_8894	     equ     8894h

BCC_NEAR_37EA   label   near
STAOV185	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     xor     DI,DI
   	     mov     BX,word ptr [SI]
   	     dec     BX
   	     cmp     BX,4
   	     jbe     short M016_L_3803
   	     db	     0E9h
   	     dw	     002BAh
M016_L_3803:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0ED0h
   	     mov     BX,word ptr [BP+4]
   	     test    byte ptr [BX+9CAh],2
   	     je	     short M016_L_3835
   	     push    DS
   	     mov     AX,58B1h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,byte ptr [SI+4]
   	     cbw
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     push    DS
   	     mov     AX,58D7h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     db	     0E9h
   	     dw	     00288h
M016_L_3835:
   	     mov     AL,byte ptr [SI+4]
   	     push    AX
   	     cmp     word ptr [BP+4],2
   	     jg	     short M016_L_3843
   	     mov     AL,2
   	     jmp     short M016_L_3845
M016_L_3843:
   	     mov     AL,6
M016_L_3845:
   	     push    AX
   	     db	     09Ah
   	     dw	     X035_01
   	     dw	     seg X035_01
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     db	     0E9h
   	     dw	     00268h
   	     cmp     word ptr [BP+4],2
   	     jle     short M016_L_385E
   	     db	     0E9h
   	     dw	     00257h
M016_L_385E:
   	     mov     AX,word ptr [SI+5]
   	     and     AX,0FFh
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     db	     0E9h
   	     dw	     00250h
   	     push    DS
   	     mov     AX,580Fh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    word ptr [SI+7]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0027Bh
   	     cmp     word ptr [SI+7],0
   	     je	     short M016_L_388F
   	     push    word ptr [SI+7]
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     mov     DI,1
M016_L_388F:
   	     cmp     word ptr [SI+5],0
   	     jne     short M016_L_3898
   	     db	     0E9h
   	     dw	     00225h
M016_L_3898:
   	     or	     DI,DI
   	     je	     short M016_L_38AB
   	     cmp     word ptr [SI+5],0
   	     je	     short M016_L_38AB
   	     mov     AX,2Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M016_L_38AB:
   	     push    word ptr [SI+5]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     db	     0E9h
   	     dw	     00207h
   	     push    word ptr [SI+7]
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [SI+7]
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     cmp     AX,3
   	     jne     short M016_L_3932
   	     push    word ptr [SI+7]
   	     db	     0FFh,01Eh
   	     dw	     8160h
   	     cmp     AL,12h
   	     je	     short M016_L_3932
   	     cmp     word ptr [BP-2],-1
   	     je	     short M016_L_3932
   	     cmp     word ptr [BP-2],0
   	     jne     short M016_L_38EE
   	     push    word ptr DGROUP:M016_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     jmp     short M016_L_38F6
M016_L_38EE:
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
M016_L_38F6:
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8894
   	     cmp     word ptr ES:[BX+2],0
   	     je	     short M016_L_391B
   	     mov     BX,word ptr ES:[BX+2]
   	     push    word ptr ES:[BX+4]
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     db	     0E9h
   	     dw	     001A2h
M016_L_391B:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8894
   	     push    word ptr ES:[BX+11h]
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     db	     0E9h
   	     dw	     0018Bh
M016_L_3932:
   	     push    DS
   	     mov     AX,58D9h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     cmp     word ptr [SI+7],0
   	     jne     short M016_L_3945
   	     db	     0E9h
   	     dw	     00178h
M016_L_3945:
   	     push    word ptr [SI+7]
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     db	     0E9h
   	     dw	     0016Eh
   	     cmp     word ptr [BP+4],0
   	     je	     short M016_L_39A3
   	     mov     BX,word ptr [BP+4]
   	     dec     BX
   	     cmp     BX,14h
   	     ja	     short M016_L_398F
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0EA6h
   	     push    DS
   	     mov     AX,58DEh
   	     jmp     short M016_L_3993
   	     push    DS
   	     mov     AX,58E3h
   	     jmp     short M016_L_3993
   	     push    DS
   	     mov     AX,58E9h
   	     jmp     short M016_L_3993
   	     push    DS
   	     mov     AX,58EFh
   	     jmp     short M016_L_3993
   	     push    DS
   	     mov     AX,58F5h
   	     jmp     short M016_L_3993
   	     push    DS
   	     mov     AX,58F9h
   	     jmp     short M016_L_3993
   	     push    DS
   	     mov     AX,58E9h
   	     jmp     short M016_L_3993
M016_L_398F:
   	     push    DS
   	     mov     AX,58E4h
M016_L_3993:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     mov     AX,55F8h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M016_L_39A3:
   	     cmp     byte ptr [SI+2],0FFh
   	     je	     short M016_L_39C7
   	     mov     AL,byte ptr [SI+2]
   	     push    AX
   	     mov     AL,6
   	     push    AX
   	     db	     09Ah
   	     dw	     X035_01
   	     dw	     seg X035_01
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AX,3Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     jmp     short M016_L_39CF
M016_L_39C7:
   	     push    word ptr [SI+7]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0012Bh
M016_L_39CF:
   	     cmp     word ptr [SI+7],0
   	     je	     short M016_L_39E1
   	     push    word ptr [SI+7]
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     mov     DI,1
   	     jmp     short M016_L_3A1A
M016_L_39E1:
   	     cmp     byte ptr [SI+4],0FFh
   	     jne     short M016_L_3A1A
   	     cmp     byte ptr [SI+3],0FFh
   	     jne     short M016_L_3A1A
   	     cmp     byte ptr [SI+2],0FFh
   	     jne     short M016_L_39FD
   	     push    DS
   	     mov     AX,5749h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
M016_L_39FD:
   	     mov     AX,5Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     push    word ptr [SI+5]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     mov     AX,5Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     db	     0E9h
   	     dw	     000A3h
M016_L_3A1A:
   	     cmp     byte ptr [SI+4],0FFh
   	     jne     short M016_L_3A26
   	     cmp     byte ptr [SI+3],0FFh
   	     je	     short M016_L_3AA2
M016_L_3A26:
   	     mov     AX,5Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     xor     DI,DI
   	     cmp     byte ptr [SI+4],0FFh
   	     je	     short M016_L_3A4D
   	     mov     AL,byte ptr [SI+4]
   	     push    AX
   	     mov     AL,6
   	     push    AX
   	     db	     09Ah
   	     dw	     X035_01
   	     dw	     seg X035_01
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     DI,1
M016_L_3A4D:
   	     cmp     byte ptr [SI+3],0FFh
   	     je	     short M016_L_3A76
   	     or	     DI,DI
   	     je	     short M016_L_3A60
   	     mov     AX,2Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M016_L_3A60:
   	     mov     AL,byte ptr [SI+3]
   	     push    AX
   	     mov     AL,6
   	     push    AX
   	     db	     09Ah
   	     dw	     X035_01
   	     dw	     seg X035_01
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     DI,1
M016_L_3A76:
   	     cmp     word ptr [SI+5],0
   	     je	     short M016_L_3A97
   	     or	     DI,DI
   	     je	     short M016_L_3A8F
   	     cmp     word ptr [SI+5],0
   	     jle     short M016_L_3A8F
   	     mov     AX,2Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M016_L_3A8F:
   	     push    word ptr [SI+5]
   	     db	     09Ah
   	     dw	     X077_01
   	     dw	     seg X077_01
M016_L_3A97:
   	     mov     AX,5Dh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     jmp     short M016_L_3ABD
M016_L_3AA2:
   	     cmp     word ptr [SI+5],0
   	     je	     short M016_L_3ABD
   	     or	     DI,DI
   	     je	     short M016_L_3AB5
   	     mov     AX,2Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M016_L_3AB5:
   	     push    word ptr [SI+5]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
M016_L_3ABD:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
STAOV185	     endp
CO076_TEXT	     ends

; END STAOV185
; BEGIN LG0C9 (gap	ovr_1dda_b2c2:3AC6)
CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,00Dh,045h,00Dh,06Fh,00Dh,06Fh,00Dh,06Fh,00Dh,06Fh,00Dh,069h,00Dh  ; ovr_1dda_b2c2:3AC6
   	     db	     06Fh,00Dh,051h,00Dh,04Bh,00Dh,057h,00Dh,06Fh,00Dh,06Fh,00Dh,06Fh,00Dh  ; ovr_1dda_b2c2:3AD4
   	     db	     06Fh,00Dh,06Fh,00Dh,06Fh,00Dh,063h,00Dh,06Fh,00Dh,06Fh,00Dh,05Dh,00Dh  ; ovr_1dda_b2c2:3AE2
   	     db	     0EAh,00Bh,04Dh,00Ch,096h,00Ch,035h,00Ch,02Fh,00Dh	     ;		    ovr_1dda_b2c2:3AF0

CO076_TEXT	     ends
; END LG0C9
; BEGIN STAOV186 (listing ovr_1dda_b2c2:3AFA)

   	     extrn   X056_0D:far
   	     extrn   X05D_07:far
   	     extrn   X05D_0E:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M018_BCC_DATA_8134	     equ     8134h
M018_BCC_DATA_8894	     equ     8894h

   	     public  X076_00
X076_00 label   far
BCC_NEAR_3AFA   label   near
STAOV186	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     or	     DI,DI
   	     je	     short M018_L_3B3C
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     SI,AX
   	     or	     SI,SI
   	     je	     short M018_L_3B3C
   	     mov     ES,word ptr DGROUP:M018_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M018_L_3B3C
   	     mov     BX,word ptr ES:[SI+2]
   	     push    word ptr ES:[BX+4]
   	     mov     AX,7846h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0E
   	     dw	     seg X05D_0E
   	     mov     AX,3Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
M018_L_3B3C:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV186	     endp
CO076_TEXT	     ends

; END STAOV186
; BEGIN STAOV187 (listing ovr_1dda_b2c2:3B42)


   	     extrn   X05D_0A:far
   	     extrn   X077_01:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

   	     public  X076_10
X076_10 label   far
STAOV187	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,57ACh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     mov     AL,byte ptr [BP+6]
   	     mov     AH,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X077_01
   	     dw	     seg X077_01
   	     push    DS
   	     mov     AX,55C2h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     pop     BP
   	     retf    2
STAOV187	     endp
CO076_TEXT	     ends

; END STAOV187
; BEGIN STAOV188 (listing ovr_1dda_b2c2:3B68)

   	     extrn   BCC_FAR_03E3:far
   	     extrn   X05D_07:far
   	     extrn   X05D_0A:far
   	     extrn   X077_04:far


CO076_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO076_TEXT,ds:DGROUP

M01A_BCC_DATA_80C0	     equ     80C0h
M01A_BCC_DATA_8160	     equ     8160h

   	     public  X076_02
X076_02 label   far
STAOV188	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Eh]
   	     mov     SI,word ptr [BP+0Ah]
   	     cmp     word ptr [BP+8],0
   	     jne     short M01A_L_3BE2
   	     cmp     word ptr [BP+6],1
   	     jne     short M01A_L_3BE2
   	     cmp     SI,1
   	     je	     short M01A_L_3B98
   	     cmp     SI,2
   	     je	     short M01A_L_3B98
   	     cmp     SI,4
   	     je	     short M01A_L_3B98
   	     cmp     SI,8
   	     je	     short M01A_L_3B98
   	     cmp     SI,0Ah
   	     jne     short M01A_L_3BE2
M01A_L_3B98:
   	     push    DS
   	     mov     AX,58FEh
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DS
   	     cmp     word ptr [BP+0Ch],0
   	     je	     short M01A_L_3BAE
   	     mov     AX,5905h
   	     jmp     short M01A_L_3BB1
M01A_L_3BAE:
   	     mov     AX,590Ah
M01A_L_3BB1:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     mov     AX,3Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8160h
   	     mov     AH,0
   	     shl     AX,1
   	     shl     AX,1
   	     mov     BX,AX
   	     push    word ptr [BX+5924h]
   	     push    word ptr [BX+5922h]
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     db	     0E9h
   	     dw	     0008Fh
M01A_L_3BE2:
   	     push    DS
   	     mov     AX,5910h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80C0h
   	     mov     AX,2Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     push    DS
   	     cmp     word ptr [BP+0Ch],0
   	     je	     short M01A_L_3C06
   	     mov     AX,5918h
   	     jmp     short M01A_L_3C09
M01A_L_3C06:
   	     mov     AX,591Dh
M01A_L_3C09:
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_0A
   	     dw	     seg X05D_0A
   	     push    SI
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
   	     mov     AX,2Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     cmp     word ptr [BP+8],1
   	     jc	     short M01A_L_3C69
   	     jne     short M01A_L_3C2C
   	     cmp     word ptr [BP+6],0
   	     jc	     short M01A_L_3C69
M01A_L_3C2C:
   	     mov     DX,word ptr [BP+8]
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,18h
   	     db	     09Ah
   	     dw	     BCC_FAR_03E3
   	     dw	     seg BCC_FAR_03E3
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EFE2h
   	     push    word ptr [BP+8]
   	     push    CS
   	     db	     0E8h
   	     dw	     0EFDBh
   	     mov     DX,word ptr [BP+8]
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,8
   	     db	     09Ah
   	     dw	     BCC_FAR_03E3
   	     dw	     seg BCC_FAR_03E3
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EFC9h
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0EFC2h
   	     mov     AX,48h
   	     push    AX
   	     db	     09Ah
   	     dw	     X05D_07
   	     dw	     seg X05D_07
   	     jmp     short M01A_L_3C71
M01A_L_3C69:
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X077_04
   	     dw	     seg X077_04
M01A_L_3C71:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    0Ah
STAOV188	     endp
CO076_TEXT	     ends

; END STAOV188
   	     end
