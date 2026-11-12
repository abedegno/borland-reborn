   	     public  X055_02
   	     public  X055_03
   	     public  X055_00
   	     public  X055_01
   	     public  X055_06
   	     public  X055_07
   	     public  X055_04
   	     public  X055_05
   	     public  X055_08
   	     public  X055_09
   	     public  X055_0B
   	     public  X055_0C
   	     public  X055_0A
   	     public  X055_0D
   	     public  X055_0E
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d43_9eb4
; BEGIN LG0BF (gap	ovr_1d43_9eb4:EB40)
CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT
; Original-image layout stub: not recovered source


X055_01 label   far
   	     db	     055h,08Bh,0ECh,0C7h,006h,044h,08Bh,09Eh,067h,05Dh,0CBh;		    ovr_1d43_9eb4:EB40

CO055_TEXT	     ends
; END LG0BF
; BEGIN STOVR168 (listing ovr_1d43_9eb4:EB4B)

CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M001_BCC_DATA_8B44	     equ     8B44h


   	     public  X055_06
X055_06 label   far
BCC_NEAR_EB4B   label   near
BCC_FAR_EB4B    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     BX,word ptr DGROUP:M001_BCC_DATA_8B44
   	     mov     AL,byte ptr [BP+6]
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M001_BCC_DATA_8B44
   	     pop     BP
   	     retf    2
BCC_FAR_EB4B    endp
CO055_TEXT	     ends

; END STOVR168
; BEGIN STOVR169 (listing ovr_1d43_9eb4:EB5F)




CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

   	     public  X055_09
X055_09 label   far
BCC_NEAR_EB5F   label   near
BCC_FAR_EB5F    proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     word ptr [BP+6],7Fh
   	     jbe     short M002_L_EB7D
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,8
   	     shr     AX,CL
   	     mov     DL,80h
   	     or	     DL,AL
   	     push    DX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FFD3h
   	     and     word ptr [BP+6],0FFh
M002_L_EB7D:
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FFC6h
   	     pop     BP
   	     retf    2
BCC_FAR_EB5F    endp
CO055_TEXT	     ends

; END STOVR169
; BEGIN STOVR170 (listing ovr_1d43_9eb4:EB89)

CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M003_BCC_DATA_8B44	     equ     8B44h


   	     public  X055_07
X055_07 label   far
BCC_FAR_EB89    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,DGROUP:M003_BCC_DATA_8B44
   	     sub     AX,679Eh
   	     pop     BP
   	     retf
BCC_FAR_EB89    endp
CO055_TEXT	     ends

; END STOVR170
; BEGIN STOVR171 (listing ovr_1d43_9eb4:EB94)


   	     extrn   BCC_FAR_AB12:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

   	     public  X055_03
X055_03 label   far
BCC_NEAR_EB94   label   near
BCC_FAR_EB94    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     jmp     short M004_L_EBAD
M004_L_EBA4:
   	     les     BX,[BP+6]
   	     inc     word ptr [BP+6]
   	     mov     AL,byte ptr ES:[BX]
M004_L_EBAD:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF99h
   	     les     BX,[BP+6]
   	     cmp     byte ptr ES:[BX],0
   	     jne     short M004_L_EBA4
   	     pop     BP
   	     retf    4
BCC_FAR_EB94    endp
CO055_TEXT	     ends

; END STOVR171
; BEGIN STOVR172 (listing ovr_1d43_9eb4:EBBF)




CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

   	     public  X055_0E
X055_0E label   far
BCC_FAR_EBBF    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF81h
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,8
   	     shr     AX,CL
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF75h
   	     pop     BP
   	     retf    2
BCC_FAR_EBBF    endp
CO055_TEXT	     ends

; END STOVR172
; BEGIN STOVR173 (listing ovr_1d43_9eb4:EBDA)



CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M006_BCC_DATA_1714	     equ     1714h
M006_BCC_DATA_80AC	     equ     80ACh
M006_BCC_DATA_8B44	     equ     8B44h

   	     public  X055_04
X055_04 label   far
BCC_NEAR_EBDA   label   near
BCC_FAR_EBDA    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     mov     AX,DGROUP:M006_BCC_DATA_8B44
   	     sub     AX,679Eh
   	     mov     SI,AX
   	     or	     SI,SI
   	     jle     short M006_L_EC28
   	     cmp     byte ptr DGROUP:M006_BCC_DATA_1714,0
   	     je	     short M006_L_EBFB
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80ACh
   	     jmp     short M006_L_EC28
M006_L_EBFB:
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     mov     AX,SI
   	     inc     AX
   	     push    AX
   	     db	     0E8h
   	     dw	     00C79h
   	     mov     word ptr [BP-2],DS
   	     mov     word ptr [BP-4],679Eh
   	     jmp     short M006_L_EC1D
M006_L_EC10:
   	     les     BX,[BP-4]
   	     mov     AL,byte ptr ES:[BX]
   	     push    AX
   	     db	     0E8h
   	     dw	     00C8Fh
   	     inc     word ptr [BP-4]
M006_L_EC1D:
   	     mov     AX,DGROUP:M006_BCC_DATA_8B44
   	     cmp     AX,word ptr [BP-4]
   	     ja	     short M006_L_EC10
   	     db	     0E8h
   	     dw	     00C9Ch
M006_L_EC28:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_EBDA    endp
CO055_TEXT	     ends

; END STOVR173
; BEGIN STOVR174 (listing ovr_1d43_9eb4:EC2F)

   	     extrn   X043_03:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M007_BCC_DATA_884C	     equ     884Ch

   	     public  X055_00
X055_00 label   far
BCC_FAR_EC2F    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,884Ch
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_884C
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI],AX
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_EC2F    endp
CO055_TEXT	     ends

; END STOVR174
; BEGIN STOVR175 (listing ovr_1d43_9eb4:EC52)



CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M008_BCC_DATA_884C	     equ     884Ch
M008_BCC_DATA_8850	     equ     8850h
M008_BCC_DATA_8852	     equ     8852h
M008_BCC_DATA_8894	     equ     8894h
M008_BCC_DATA_88A2	     equ     88A2h
M008_BCC_DATA_8B44	     equ     8B44h

   	     public  X055_08
X055_08 label   far
BCC_FAR_EC52    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     cmp     word ptr DGROUP:M008_BCC_DATA_8850,0
   	     jne     short M008_L_EC61
   	     db	     0E9h
   	     dw	     00089h
M008_L_EC61:
   	     mov     word ptr DGROUP:M008_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_8B44
   	     mov     word ptr [BX],0EE00h
   	     add     word ptr DGROUP:M008_BCC_DATA_8B44,2
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     push    word ptr ES:[BX+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FEDBh
   	     xor     DI,DI
   	     xor     SI,SI
   	     jmp     short M008_L_ECD1
M008_L_EC8A:
   	     cmp     DI,3FFh
   	     jle     short M008_L_ECBC
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF43h
   	     mov     word ptr DGROUP:M008_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_8B44
   	     mov     word ptr [BX],0EE00h
   	     add     word ptr DGROUP:M008_BCC_DATA_8B44,2
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8894
   	     push    word ptr ES:[BX+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FEA5h
   	     xor     DI,DI
M008_L_ECBC:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_884C
   	     mov     AX,word ptr ES:[SI]
   	     mov     BX,word ptr DGROUP:M008_BCC_DATA_8B44
   	     mov     word ptr [BX],AX
   	     add     word ptr DGROUP:M008_BCC_DATA_8B44,2
   	     inc     DI
   	     inc     SI
   	     inc     SI
M008_L_ECD1:
   	     cmp     SI,word ptr DGROUP:M008_BCC_DATA_8850
   	     jc	     short M008_L_EC8A
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FEFCh
   	     mov     word ptr DGROUP:M008_BCC_DATA_8852,0
   	     mov     word ptr DGROUP:M008_BCC_DATA_8850,0
M008_L_ECEA:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf
BCC_FAR_EC52    endp
CO055_TEXT	     ends

; END STOVR175
; BEGIN STOVR176 (listing ovr_1d43_9eb4:ECEE)

   	     extrn   BCC_FAR_B072:far
   	     extrn   X037_00:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M009_BCC_DATA_7846	     equ     7846h
M009_BCC_DATA_818E	     equ     818Eh
M009_BCC_DATA_8192	     equ     8192h
M009_BCC_DATA_8B44	     equ     8B44h

   	     public  X055_0D
X055_0D label   far
BCC_NEAR_ECEE   label   near
BCC_FAR_ECEE    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,56h
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     word ptr [BP-6],0
   	     mov     word ptr DGROUP:M009_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     word ptr [BX],0E800h
   	     add     word ptr DGROUP:M009_BCC_DATA_8B44,2
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_818E
   	     cmp     word ptr ES:[DI+0Ah],0
   	     je	     short M009_L_ED20
   	     mov     DI,word ptr ES:[DI+0Ah]
M009_L_ED20:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_818E
   	     cmp     word ptr ES:[DI+6],0
   	     je	     short M009_L_ED2E
   	     db	     0E9h
   	     dw	     0009Fh
M009_L_ED2E:
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     byte ptr [BX],0
   	     inc     word ptr DGROUP:M009_BCC_DATA_8B44
   	     push    word ptr DGROUP:M009_BCC_DATA_7846
   	     push    word ptr ES:[DI]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE50h
   	     push    SS
   	     lea     AX,[BP-56h]
   	     push    AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_818E
   	     push    word ptr DGROUP:M009_BCC_DATA_7846
   	     push    word ptr ES:[DI]
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     push    SS
   	     lea     AX,[BP-56h]
   	     push    AX
   	     db	     09Ah
   	     dw	     X037_00
   	     dw	     seg X037_00
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     AL,byte ptr [BP-4]
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     AL,byte ptr [BP-3]
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     AL,byte ptr [BP-2]
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     BX,word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     AL,byte ptr [BP-1]
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M009_BCC_DATA_8B44
   	     mov     SI,2
   	     jmp     short M009_L_EDB9
M009_L_EDA2:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_818E
   	     mov     AX,word ptr ES:[SI+6]
   	     cmp     AX,word ptr [BP-6]
   	     jbe     short M009_L_EDB6
   	     mov     AX,word ptr ES:[SI+6]
   	     mov     word ptr [BP-6],AX
M009_L_EDB6:
   	     add     SI,0Eh
M009_L_EDB9:
   	     cmp     SI,word ptr DGROUP:M009_BCC_DATA_8192
   	     jc	     short M009_L_EDA2
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_818E
   	     mov     AX,word ptr [BP-6]
   	     inc     AX
   	     mov     word ptr ES:[DI+6],AX
   	     jmp     short M009_L_EDD9
M009_L_EDCD:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_818E
   	     push    word ptr ES:[DI+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD86h
M009_L_EDD9:
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FDFAh
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_ECEE    endp
CO055_TEXT	     ends

; END STOVR176
; BEGIN STOVR177 (listing ovr_1d43_9eb4:EDE8)

   	     extrn   X056_0D:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M00A_BCC_DATA_818E	     equ     818Eh
M00A_BCC_DATA_8192	     equ     8192h
M00A_BCC_DATA_86B8	     equ     86B8h
M00A_BCC_DATA_86CA	     equ     86CAh
M00A_BCC_DATA_8894	     equ     8894h
M00A_BCC_DATA_8B44	     equ     8B44h

BCC_NEAR_EDE8   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     word ptr [BP-2],0
   	     mov     word ptr DGROUP:M00A_BCC_DATA_86CA,0
   	     mov     SI,2
   	     jmp     short M00A_L_EE20
M00A_L_EE01:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M00A_L_EE13
   	     mov     word ptr [BP-2],1
   	     jmp     short M00A_L_EE26
M00A_L_EE13:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     mov     word ptr ES:[SI+4],0
   	     add     SI,0Eh
M00A_L_EE20:
   	     cmp     SI,word ptr DGROUP:M00A_BCC_DATA_8192
   	     jc	     short M00A_L_EE01
M00A_L_EE26:
   	     cmp     word ptr [BP-2],0
   	     jne     short M00A_L_EE3E
   	     cmp     word ptr DGROUP:M00A_BCC_DATA_8192,2
   	     jbe     short M00A_L_EE3E
   	     mov     AX,2
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FEB3h
   	     db	     0E9h
   	     dw	     00142h
M00A_L_EE3E:
   	     mov     word ptr [BP-0Ah],0FFFFh
   	     xor     SI,SI
   	     mov     word ptr [BP-0Ch],2
   	     jmp     short M00A_L_EE71
M00A_L_EE4C:
   	     mov     BX,word ptr [BP-0Ch]
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     cmp     word ptr ES:[BX+2],0
   	     je	     short M00A_L_EE6D
   	     mov     AX,word ptr ES:[BX+8]
   	     cmp     AX,word ptr [BP-0Ah]
   	     jnc     short M00A_L_EE6D
   	     mov     SI,word ptr [BP-0Ch]
   	     mov     AX,word ptr ES:[BX+8]
   	     mov     word ptr [BP-0Ah],AX
M00A_L_EE6D:
   	     add     word ptr [BP-0Ch],0Eh
M00A_L_EE71:
   	     mov     AX,word ptr [BP-0Ch]
   	     cmp     AX,word ptr DGROUP:M00A_BCC_DATA_8192
   	     jc	     short M00A_L_EE4C
   	     or	     SI,SI
   	     je	     short M00A_L_EE81
   	     db	     0E9h
   	     dw	     000F3h
M00A_L_EE81:
   	     db	     0E9h
   	     dw	     000FCh
M00A_L_EE84:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M00A_L_EE92
   	     db	     0E9h
   	     dw	     000DFh
M00A_L_EE92:
   	     mov     AX,word ptr ES:[SI+8]
   	     cmp     AX,word ptr [BP-0Ah]
   	     je	     short M00A_L_EE9E
   	     db	     0E9h
   	     dw	     000D3h
M00A_L_EE9E:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     mov     AX,word ptr ES:[SI+2]
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr ES:[SI+2],0
   	     push    SI
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE3Ah
   	     mov     word ptr [BP-2],0
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     push    word ptr ES:[SI+8]
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     word ptr [BP-8],AX
   	     cmp     word ptr [BP-8],0
   	     je	     short M00A_L_EEEA
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8894
   	     cmp     word ptr ES:[BX+2],0
   	     je	     short M00A_L_EEEA
   	     mov     BX,word ptr ES:[BX+2]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-6],AX
   	     jmp     short M00A_L_EEEF
M00A_L_EEEA:
   	     mov     word ptr [BP-6],0
M00A_L_EEEF:
   	     mov     word ptr DGROUP:M00A_BCC_DATA_8B44,679Eh
   	     push    word ptr [BP-6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC63h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     push    word ptr ES:[SI+8]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC57h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     mov     DI,word ptr ES:[SI+0Ch]
   	     jmp     short M00A_L_EF65
M00A_L_EF12:
   	     cmp     word ptr [BP-2],3E8h
   	     jl	     short M00A_L_EF3E
   	     mov     AL,94h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FCBAh
   	     mov     word ptr DGROUP:M00A_BCC_DATA_8B44,679Eh
   	     push    word ptr [BP-6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC32h
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_818E
   	     push    word ptr ES:[SI+8]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC26h
   	     mov     word ptr [BP-2],0
M00A_L_EF3E:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_86B8
   	     mov     AX,word ptr ES:[DI]
   	     mov     BX,word ptr DGROUP:M00A_BCC_DATA_8B44
   	     mov     word ptr [BX],AX
   	     add     word ptr DGROUP:M00A_BCC_DATA_8B44,2
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     BX,word ptr DGROUP:M00A_BCC_DATA_8B44
   	     mov     word ptr [BX],AX
   	     add     word ptr DGROUP:M00A_BCC_DATA_8B44,2
   	     add     DI,4
   	     inc     word ptr [BP-2]
M00A_L_EF65:
   	     dec     word ptr [BP-4]
   	     jge     short M00A_L_EF12
   	     mov     AL,94h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC69h
M00A_L_EF71:
   	     add     SI,0Eh
M00A_L_EF74:
   	     cmp     SI,word ptr DGROUP:M00A_BCC_DATA_8192
   	     jnc     short M00A_L_EF7D
   	     db	     0E9h
   	     dw	     0FF07h
M00A_L_EF7D:
   	     db	     0E9h
   	     dw	     0FEBEh
M00A_L_EF80:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret
BCC_NEAR_EDE8   endp
CO055_TEXT	     ends

; END STOVR177
; BEGIN STOVR178 (listing ovr_1d43_9eb4:EF87)



CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M00B_BCC_DATA_1709	     equ     1709h
M00B_BCC_DATA_8B44	     equ     8B44h

   	     public  X055_0A
X055_0A label   far
BCC_FAR_EF87    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     word ptr DGROUP:M00B_BCC_DATA_8B44,679Eh
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBFAh
   	     mov     AL,80h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC39h
   	     mov     word ptr DGROUP:M00B_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M00B_BCC_DATA_8B44
   	     mov     word ptr [BX],0
   	     add     word ptr DGROUP:M00B_BCC_DATA_8B44,2
   	     push    DS
   	     mov     AX,5537h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBD7h
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC16h
   	     cmp     byte ptr DGROUP:M00B_BCC_DATA_1709,0
   	     je	     short M00B_L_EFFD
   	     mov     word ptr DGROUP:M00B_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M00B_BCC_DATA_8B44
   	     mov     word ptr [BX],0A100h
   	     add     word ptr DGROUP:M00B_BCC_DATA_8B44,2
   	     mov     BX,word ptr DGROUP:M00B_BCC_DATA_8B44
   	     mov     byte ptr [BX],1
   	     inc     word ptr DGROUP:M00B_BCC_DATA_8B44
   	     mov     BX,word ptr DGROUP:M00B_BCC_DATA_8B44
   	     mov     word ptr [BX],4454h
   	     add     word ptr DGROUP:M00B_BCC_DATA_8B44,2
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBDDh
M00B_L_EFFD:
   	     pop     BP
   	     retf    4
BCC_FAR_EF87    endp
CO055_TEXT	     ends

; END STOVR178
; BEGIN STOVR179 (listing ovr_1d43_9eb4:F001)

   	     extrn   BCC_FAR_AB12:far
   	     extrn   X037_00:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M00C_BCC_DATA_16FE	     equ     16FEh

   	     public  X055_05
X055_05 label   far
BCC_FAR_F001    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     cmp     byte ptr DGROUP:M00C_BCC_DATA_16FE,0
   	     je	     short M00C_L_F011
   	     db	     0E9h
   	     dw	     00082h
M00C_L_F011:
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     BCC_FAR_AB12
   	     dw	     seg BCC_FAR_AB12
   	     mov     word ptr [BP-2],AX
   	     mov     AL,88h
   	     push    AX
   	     mov     AX,word ptr [BP-2]
   	     add     AX,8
   	     push    AX
   	     db	     0E8h
   	     dw	     00853h
   	     mov     AL,0
   	     push    AX
   	     db	     0E8h
   	     dw	     00877h
   	     mov     AL,0E9h
   	     push    AX
   	     db	     0E8h
   	     dw	     00871h
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X037_00
   	     dw	     seg X037_00
   	     mov     word ptr [BP-8],DX
   	     mov     word ptr [BP-0Ah],AX
   	     mov     AL,byte ptr [BP-0Ah]
   	     push    AX
   	     db	     0E8h
   	     dw	     00859h
   	     mov     AL,byte ptr [BP-9]
   	     push    AX
   	     db	     0E8h
   	     dw	     00852h
   	     mov     AL,byte ptr [BP-8]
   	     push    AX
   	     db	     0E8h
   	     dw	     0084Bh
   	     mov     AL,byte ptr [BP-7]
   	     push    AX
   	     db	     0E8h
   	     dw	     00844h
   	     mov     AL,byte ptr [BP-2]
   	     push    AX
   	     db	     0E8h
   	     dw	     0083Dh
   	     mov     AX,word ptr [BP+8]
   	     mov     DX,word ptr [BP+6]
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],DX
   	     jmp     short M00C_L_F087
M00C_L_F07A:
   	     les     BX,[BP-6]
   	     mov     AL,byte ptr ES:[BX]
   	     push    AX
   	     db	     0E8h
   	     dw	     00825h
   	     inc     word ptr [BP-6]
M00C_L_F087:
   	     les     BX,[BP-6]
   	     cmp     byte ptr ES:[BX],0
   	     jne     short M00C_L_F07A
   	     db	     0E8h
   	     dw	     00831h
M00C_L_F093:
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
BCC_FAR_F001    endp
CO055_TEXT	     ends

; END STOVR179
; BEGIN STOVR180 (listing ovr_1d43_9eb4:F099)

   	     extrn   BCC_FAR_5B44:far
   	     extrn   BCC_FAR_B072:far
   	     extrn   X056_03:far
   	     extrn   X056_04:far
   	     extrn   X056_05:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M00D_BCC_DATA_16EF	     equ     16EFh
M00D_BCC_DATA_16FE	     equ     16FEh
M00D_BCC_DATA_1716	     equ     1716h
M00D_BCC_DATA_1762	     equ     1762h
M00D_BCC_DATA_7846	     equ     7846h
M00D_BCC_DATA_8120	     equ     8120h
M00D_BCC_DATA_8154	     equ     8154h
M00D_BCC_DATA_86B0	     equ     86B0h
M00D_BCC_DATA_86B4	     equ     86B4h
M00D_BCC_STMT_CURRENT   equ     86C8h
M00D_BCC_DATA_8894	     equ     8894h
M00D_BCC_DATA_889E	     equ     889Eh
M00D_BCC_DATA_88A2	     equ     88A2h
M00D_BCC_DATA_88A6	     equ     88A6h
M00D_BCC_DATA_8B44	     equ     8B44h

   	     public  X055_02
X055_02 label   far
BCC_FAR_F099    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4Ch
   	     push    SI
   	     push    DI
   	     push    word ptr DGROUP:M00D_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X056_05
   	     dw	     seg X056_05
   	     db	     0FFh,01Eh
   	     dw	     8154h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_04
   	     dw	     seg X056_04
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     AX,word ptr ES:[BX+0Ch]
   	     mov     word ptr [BP-0Ch],AX
   	     mov     word ptr [BP-0Ah],0
   	     mov     word ptr [BP-8],0
   	     jmp     short M00D_L_F0E5
M00D_L_F0CF:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_86B0
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr ES:[BX]
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     inc     word ptr [BP-0Ah]
   	     inc     word ptr [BP-8]
M00D_L_F0E5:
   	     mov     AX,word ptr [BP-8]
   	     cmp     AX,word ptr DGROUP:M00D_BCC_DATA_86B4
   	     jc	     short M00D_L_F0CF
   	     mov     AL,DGROUP:M00D_BCC_DATA_16FE
   	     cbw
   	     or	     AX,AX
   	     jne     short M00D_L_F110
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     word ptr [BX],0E900h
   	     add     word ptr DGROUP:M00D_BCC_DATA_8B44,2
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FACAh
M00D_L_F110:
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     word ptr [BX],0EA00h
   	     add     word ptr DGROUP:M00D_BCC_DATA_8B44,2
   	     cmp     byte ptr DGROUP:M00D_BCC_DATA_1762,0
   	     je	     short M00D_L_F12E
   	     mov     AL,5
   	     jmp     short M00D_L_F130
M00D_L_F12E:
   	     mov     AL,1
M00D_L_F130:
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     AL,DGROUP:M00D_BCC_DATA_1716
   	     shl     AL,1
   	     shl     AL,1
   	     shl     AL,1
   	     mov     DL,byte ptr DGROUP:M00D_BCC_DATA_16EF
   	     or	     DL,AL
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],DL
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     AL,88h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA80h
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],0
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     SI,word ptr DGROUP:M00D_BCC_DATA_889E
   	     jmp     short M00D_L_F1A3
M00D_L_F171:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+19h],0
   	     jne     short M00D_L_F19C
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     push    word ptr DGROUP:M00D_BCC_DATA_7846
   	     push    word ptr ES:[SI+11h]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA08h
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     push    word ptr DGROUP:M00D_BCC_DATA_7846
   	     push    word ptr ES:[SI+0Ah]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9F8h
M00D_L_F19C:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M00D_L_F1A3:
   	     or	     SI,SI
   	     jne     short M00D_L_F171
   	     mov     DI,word ptr DGROUP:M00D_BCC_DATA_88A6
   	     jmp     short M00D_L_F1C4
M00D_L_F1AD:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     push    word ptr DGROUP:M00D_BCC_DATA_7846
   	     push    word ptr ES:[DI+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9D7h
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     DI,word ptr ES:[DI]
M00D_L_F1C4:
   	     or	     DI,DI
   	     jne     short M00D_L_F1AD
   	     mov     AL,96h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA0Bh
   	     mov     word ptr [BP-6],2
   	     mov     SI,word ptr DGROUP:M00D_BCC_DATA_889E
   	     db	     0E9h
   	     dw	     00095h
M00D_L_F1DB:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+19h],0
   	     je	     short M00D_L_F1E9
   	     db	     0E9h
   	     dw	     00080h
M00D_L_F1E9:
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     cmp     byte ptr ES:[SI+10h],10h
   	     jne     short M00D_L_F1FF
   	     mov     byte ptr ES:[SI+10h],3
M00D_L_F1FF:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     AL,byte ptr ES:[SI+10h]
   	     mov     CL,5
   	     shl     AL,CL
   	     push    AX
   	     cmp     word ptr ES:[SI+0Eh],1
   	     jne     short M00D_L_F21E
   	     cmp     word ptr ES:[SI+0Ch],0
   	     jne     short M00D_L_F21E
   	     mov     AL,2
   	     jmp     short M00D_L_F220
M00D_L_F21E:
   	     mov     AL,0
M00D_L_F220:
   	     pop     DX
   	     add     DL,AL
   	     add     DL,8
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],DL
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     word ptr [BX],AX
   	     add     word ptr DGROUP:M00D_BCC_DATA_8B44,2
   	     push    word ptr [BP-6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F915h
   	     mov     AX,word ptr [BP-6]
   	     inc     AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F90Ch
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],1
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     AL,98h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F975h
   	     add     word ptr [BP-6],2
M00D_L_F269:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M00D_L_F270:
   	     or	     SI,SI
   	     je	     short M00D_L_F277
   	     db	     0E9h
   	     dw	     0FF64h
M00D_L_F277:
   	     mov     SI,word ptr DGROUP:M00D_BCC_DATA_889E
   	     db	     0E9h
   	     dw	     00094h
M00D_L_F27E:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+19h],0
   	     jne     short M00D_L_F28C
   	     db	     0E9h
   	     dw	     0007Fh
M00D_L_F28C:
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     push    word ptr DGROUP:M00D_BCC_DATA_7846
   	     push    word ptr ES:[SI+11h]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8F2h
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],0
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     AX,word ptr ES:[SI+19h]
   	     and     AX,7FFFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8A2h
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+0Eh],0
   	     jg	     short M00D_L_F2E6
   	     jne     short M00D_L_F2D2
   	     cmp     word ptr ES:[SI+0Ch],80h
   	     ja	     short M00D_L_F2E6
M00D_L_F2D2:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     AL,byte ptr ES:[SI+0Ch]
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     jmp     short M00D_L_F304
M00D_L_F2E6:
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],81h
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     AX,word ptr ES:[SI+0Ch]
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     word ptr [BX],AX
   	     add     word ptr DGROUP:M00D_BCC_DATA_8B44,2
M00D_L_F304:
   	     mov     AL,0B0h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8CFh
M00D_L_F30B:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M00D_L_F312:
   	     or	     SI,SI
   	     je	     short M00D_L_F319
   	     db	     0E9h
   	     dw	     0FF65h
M00D_L_F319:
   	     mov     DI,word ptr DGROUP:M00D_BCC_DATA_88A6
   	     db	     0E9h
   	     dw	     00099h
M00D_L_F320:
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     push    word ptr [BP-6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F832h
   	     mov     word ptr [BP-2],0
   	     mov     word ptr [BP-4],0
   	     mov     SI,word ptr DGROUP:M00D_BCC_DATA_889E
   	     jmp     short M00D_L_F36F
M00D_L_F33D:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+2],DI
   	     jne     short M00D_L_F368
   	     mov     AX,word ptr ES:[SI+0Eh]
   	     mov     DX,word ptr ES:[SI+0Ch]
   	     add     word ptr [BP-4],DX
   	     adc     word ptr [BP-2],AX
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],0FFh
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     push    word ptr ES:[SI+4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7F7h
M00D_L_F368:
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M00D_L_F36F:
   	     or	     SI,SI
   	     jne     short M00D_L_F33D
   	     cmp     word ptr [BP-2],1
   	     jl	     short M00D_L_F3A8
   	     jg	     short M00D_L_F381
   	     cmp     word ptr [BP-4],0
   	     jbe     short M00D_L_F3A8
M00D_L_F381:
   	     push    SS
   	     lea     AX,[BP-4Ch]
   	     push    AX
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     push    word ptr DGROUP:M00D_BCC_DATA_7846
   	     push    word ptr ES:[DI+4]
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     push    SS
   	     lea     AX,[BP-4Ch]
   	     push    AX
   	     mov     AX,34h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     add     SP,6
M00D_L_F3A8:
   	     mov     AL,9Ah
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F82Bh
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     DI,word ptr ES:[DI]
   	     inc     word ptr [BP-6]
M00D_L_F3B9:
   	     or	     DI,DI
   	     je	     short M00D_L_F3C0
   	     db	     0E9h
   	     dw	     0FF60h
M00D_L_F3C0:
   	     push    word ptr [BP-0Ch]
   	     db	     0FFh,01Eh
   	     dw	     8120h
   	     mov     SI,word ptr DGROUP:M00D_BCC_DATA_889E
   	     jmp     short M00D_L_F3D8
M00D_L_F3CD:
   	     push    SI
   	     db	     0E8h
   	     dw	     00031h
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8894
   	     mov     SI,word ptr ES:[SI]
M00D_L_F3D8:
   	     or	     SI,SI
   	     jne     short M00D_L_F3CD
   	     db	     0E8h
   	     dw	     0FA09h
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B44,679Eh
   	     mov     BX,word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     byte ptr [BX],0
   	     inc     word ptr DGROUP:M00D_BCC_DATA_8B44
   	     mov     AL,8Ah
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7E3h
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf
BCC_FAR_F099    endp
CO055_TEXT	     ends

; END STOVR180
; BEGIN STOVR181 (listing ovr_1d43_9eb4:F3FD)

CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP



   	     public  X055_0C
X055_0C label   far
BCC_FAR_F3FD    proc    far
   	     push    BP
   	     mov     BP,SP
   	     pop     BP
   	     retf
BCC_FAR_F3FD    endp
CO055_TEXT	     ends

; END STOVR181
; BEGIN STOVR182 (listing ovr_1d43_9eb4:F402)



CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M00F_BCC_DATA_885C	     equ     885Ch
M00F_BCC_DATA_8884	     equ     8884h
M00F_BCC_DATA_8894	     equ     8894h
M00F_BCC_DATA_8B44	     equ     8B44h

BCC_NEAR_F402   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     word ptr [BP-0Ch],0
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8894
   	     mov     AX,word ptr ES:[SI+6]
   	     db	     0E9h
   	     dw	     000E2h
M00F_L_F41E:
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_885C
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr [BP-6],AX
   	     mov     word ptr DGROUP:M00F_BCC_DATA_8B44,679Eh
   	     mov     DI,word ptr ES:[BX+4]
   	     jmp     short M00F_L_F44A
M00F_L_F43B:
   	     push    SI
   	     push    word ptr [BP-2]
   	     push    DI
   	     db	     0E8h
   	     dw	     00110h
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8884
   	     mov     DI,word ptr ES:[DI]
M00F_L_F44A:
   	     or	     DI,DI
   	     jne     short M00F_L_F43B
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+4],7Fh
   	     jle     short M00F_L_F47A
   	     mov     AL,0A0h
   	     push    AX
   	     mov     AX,word ptr [BP-4]
   	     add     AX,5
   	     push    AX
   	     db	     0E8h
   	     dw	     00419h
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8894
   	     mov     AX,word ptr ES:[SI+4]
   	     mov     CL,8
   	     sar     AX,CL
   	     or	     AL,80h
   	     push    AX
   	     db	     0E8h
   	     dw	     00431h
   	     jmp     short M00F_L_F487
M00F_L_F47A:
   	     mov     AL,0A0h
   	     push    AX
   	     mov     AX,word ptr [BP-4]
   	     add     AX,4
   	     push    AX
   	     db	     0E8h
   	     dw	     003F8h
M00F_L_F487:
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8894
   	     mov     AL,byte ptr ES:[SI+4]
   	     push    AX
   	     db	     0E8h
   	     dw	     00416h
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_885C
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [BP-8],AX
   	     mov     AL,byte ptr [BP-8]
   	     and     AL,0FFh
   	     push    AX
   	     db	     0E8h
   	     dw	     00400h
   	     mov     AX,word ptr [BP-8]
   	     mov     CL,8
   	     shr     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     003F5h
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8894
   	     mov     AX,word ptr [BP-8]
   	     sub     AX,word ptr ES:[SI+17h]
   	     mov     word ptr [BP-0Ah],AX
   	     jmp     short M00F_L_F4DF
M00F_L_F4C4:
   	     dec     word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8894
   	     les     BX,ES:[SI+13h]
   	     mov     ES,word ptr ES:[BX]
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr ES:[BX]
   	     push    AX
   	     db	     0E8h
   	     dw	     003CDh
   	     inc     word ptr [BP-0Ah]
M00F_L_F4DF:
   	     cmp     word ptr [BP-4],0
   	     ja	     short M00F_L_F4C4
   	     db	     0E8h
   	     dw	     003DCh
   	     mov     AL,9Ch
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F6EBh
   	     mov     AX,word ptr [BP-6]
   	     add     word ptr [BP-0Ch],AX
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_885C
   	     mov     AX,word ptr ES:[BX+8]
M00F_L_F500:
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     je	     short M00F_L_F50C
   	     db	     0E9h
   	     dw	     0FF12h
M00F_L_F50C:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_F402   endp
CO055_TEXT	     ends

; END STOVR182
; BEGIN STOVR183 (listing ovr_1d43_9eb4:F515)

CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M010_BCC_DATA_885C	     equ     885Ch
M010_BCC_DATA_8894	     equ     8894h


BCC_NEAR_F515   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ah]
   	     mov     DI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_885C
   	     mov     BX,word ptr [BP+8]
   	     add     DI,word ptr ES:[BX]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8894
   	     mov     AX,DI
   	     sub     AX,word ptr ES:[SI+17h]
   	     mov     word ptr [BP-2],AX
   	     les     BX,ES:[SI+13h]
   	     mov     ES,word ptr ES:[BX]
   	     mov     BX,word ptr [BP-2]
   	     mov     AX,word ptr [BP+4]
   	     add     word ptr ES:[BX],AX
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     8
BCC_NEAR_F515   endp
CO055_TEXT	     ends

; END STOVR183
; BEGIN STOVR184 (listing ovr_1d43_9eb4:F553)

   	     extrn   X056_0D:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M011_BCC_DATA_1709	     equ     1709h
M011_BCC_DATA_1776	     equ     1776h
M011_BCC_STMT_RECORD_SEG	     equ     63C2h
M011_BCC_DATA_80D4	     equ     80D4h
M011_BCC_DATA_8118	     equ     8118h
M011_BCC_DATA_8134	     equ     8134h
M011_BCC_DATA_8150	     equ     8150h
M011_BCC_DATA_8160	     equ     8160h
M011_BCC_DATA_8168	     equ     8168h
M011_BCC_STMT_CURRENT   equ     86C8h
M011_BCC_DATA_885C	     equ     885Ch
M011_BCC_DATA_8884	     equ     8884h
M011_BCC_DATA_8894	     equ     8894h
M011_BCC_DATA_8B44	     equ     8B44h

BCC_NEAR_F553   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8884
   	     mov     DI,word ptr ES:[BX+4]
   	     mov     AX,word ptr ES:[BX+2]
   	     mov     word ptr [BP-6],AX
   	     mov     AX,word ptr ES:[BX+6]
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],6
   	     jne     short M011_L_F5D3
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     cmp     AX,2
   	     jne     short M011_L_F58B
   	     db	     0E9h
   	     dw	     000A7h
M011_L_F58B:
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8118h
   	     mov     word ptr [BP-0Ah],AX
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     AX,word ptr ES:[SI+4]
   	     jne     short M011_L_F5B4
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_885C
   	     mov     BX,word ptr [BP+6]
   	     mov     AX,word ptr ES:[BX]
   	     add     AX,word ptr [BP-6]
   	     inc     AX
   	     inc     AX
   	     sub     word ptr [BP-0Ah],AX
M011_L_F5B4:
   	     push    SI
   	     push    word ptr [BP+6]
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-0Ah]
   	     db	     0E8h
   	     dw	     0FF54h
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     AX,word ptr ES:[SI+4]
   	     jne     short M011_L_F632
   	     db	     0E9h
   	     dw	     0029Bh
M011_L_F5D3:
   	     cmp     word ptr [BP-2],1
   	     je	     short M011_L_F5DF
   	     cmp     word ptr [BP-2],7
   	     jne     short M011_L_F5FB
M011_L_F5DF:
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     cmp     AX,2
   	     je	     short M011_L_F632
   	     push    SI
   	     push    word ptr [BP+6]
   	     push    word ptr [BP-6]
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8118h
   	     push    AX
   	     db	     0E8h
   	     dw	     0FF1Ch
   	     jmp     short M011_L_F632
M011_L_F5FB:
   	     cmp     word ptr [BP-2],10h
   	     jne     short M011_L_F61B
   	     push    SI
   	     push    word ptr [BP+6]
   	     push    word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_885C
   	     mov     BX,word ptr [BP+6]
   	     mov     AX,word ptr ES:[BX]
   	     add     AX,word ptr [BP-6]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FEFCh
   	     jmp     short M011_L_F632
M011_L_F61B:
   	     cmp     word ptr [BP-2],5
   	     jne     short M011_L_F632
   	     or	     DI,DI
   	     je	     short M011_L_F632
   	     push    SI
   	     push    word ptr [BP+6]
   	     push    word ptr [BP-6]
   	     push    DI
   	     db	     0E8h
   	     dw	     0FEE5h
   	     xor     DI,DI
M011_L_F632:
   	     mov     BX,word ptr [BP-2]
   	     mov     AL,byte ptr [BX+5526h]
   	     cbw
   	     mov     word ptr [BP-4],AX
   	     cmp     byte ptr DGROUP:M011_BCC_DATA_1709,0
   	     jne     short M011_L_F64B
   	     cmp     byte ptr DGROUP:M011_BCC_DATA_1776,0
   	     je	     short M011_L_F66E
M011_L_F64B:
   	     cmp     word ptr [BP-2],1
   	     jne     short M011_L_F66E
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8160h
   	     cmp     AL,12h
   	     jne     short M011_L_F66E
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8168h
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80D4h
   	     test    AX,1
   	     je	     short M011_L_F66E
   	     mov     word ptr [BP-4],0D4h
M011_L_F66E:
   	     mov     AX,word ptr [BP-6]
   	     mov     CL,8
   	     shr     AX,CL
   	     mov     DL,byte ptr [BP-4]
   	     or	     DL,AL
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],DL
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     AL,byte ptr [BP-6]
   	     and     AL,0FFh
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     cmp     word ptr [BP-2],0
   	     jne     short M011_L_F6EE
   	     push    SI
   	     push    word ptr [BP+6]
   	     push    word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M011_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[DI]
   	     db	     0E8h
   	     dw	     0FE6Bh
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M011_L_F6CE
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],14h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     BX,word ptr ES:[SI+2]
   	     push    word ptr ES:[BX+2]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F493h
   	     jmp     short M011_L_F6D9
M011_L_F6CE:
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],54h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
M011_L_F6D9:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     mov     AL,byte ptr ES:[SI+4]
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],AL
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     db	     0E9h
   	     dw	     00180h
M011_L_F6EE:
   	     cmp     word ptr [BP-2],5
   	     je	     short M011_L_F6FA
   	     cmp     word ptr [BP-2],10h
   	     jne     short M011_L_F734
M011_L_F6FA:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M011_L_F71E
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],14h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     BX,word ptr ES:[SI+2]
   	     push    word ptr ES:[BX+2]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F443h
   	     jmp     short M011_L_F729
M011_L_F71E:
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],54h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
M011_L_F729:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     push    word ptr ES:[SI+4]
   	     db	     0E9h
   	     dw	     00136h
M011_L_F734:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8884
   	     cmp     word ptr ES:[BX+6],0Ah
   	     jne     short M011_L_F78A
   	     push    word ptr DGROUP:M011_BCC_STMT_CURRENT
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     word ptr [BP-8],AX
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     word ptr ES:[BX+2],0
   	     je	     short M011_L_F779
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],14h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     BX,word ptr [BP-8]
   	     mov     BX,word ptr ES:[BX+2]
   	     push    word ptr ES:[BX+2]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F3E9h
   	     db	     0E9h
   	     dw	     000E6h
M011_L_F779:
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],54h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     db	     0E9h
   	     dw	     000D8h
   	     db	     0E9h
   	     dw	     000D5h
M011_L_F78A:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8884
   	     cmp     word ptr ES:[BX+6],0Bh
   	     jne     short M011_L_F7AC
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],46h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8118h
   	     push    AX
   	     db	     0E9h
   	     dw	     000BEh
M011_L_F7AC:
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     dec     AX
   	     mov     BX,AX
   	     cmp     BX,3
   	     jbe     short M011_L_F7BC
   	     db	     0E9h
   	     dw	     000B2h
M011_L_F7BC:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0D37h
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     word ptr [BP-8],AX
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     cmp     AX,0FFFFh
   	     je	     short M011_L_F7E9
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     word ptr ES:[BX+2],0
   	     jne     short M011_L_F7F6
M011_L_F7E9:
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],56h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     jmp     short M011_L_F814
M011_L_F7F6:
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],16h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     mov     BX,word ptr ES:[BX+2]
   	     push    word ptr ES:[BX+2]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F34Bh
M011_L_F814:
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8118h
   	     push    AX
   	     jmp     short M011_L_F86A
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_0D
   	     dw	     seg X056_0D
   	     mov     word ptr [BP-8],AX
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     cmp     word ptr ES:[BX+2],0
   	     je	     short M011_L_F854
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],14h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     BX,word ptr [BP-8]
   	     mov     BX,word ptr ES:[BX+2]
   	     push    word ptr ES:[BX+2]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F30Dh
   	     jmp     short M011_L_F85F
M011_L_F854:
   	     mov     BX,word ptr DGROUP:M011_BCC_DATA_8B44
   	     mov     byte ptr [BX],54h
   	     inc     word ptr DGROUP:M011_BCC_DATA_8B44
M011_L_F85F:
   	     mov     BX,word ptr [BP-8]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8894
   	     push    word ptr ES:[BX+4]
M011_L_F86A:
   	     push    CS
   	     db	     0E8h
   	     dw	     0F2F1h
M011_L_F86E:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     6
BCC_NEAR_F553   endp
CO055_TEXT	     ends

; END STOVR184
; BEGIN LG0C0 (gap	ovr_1d43_9eb4:F877)
CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT
; Original-image layout stub: not recovered source


   	     db	     0DCh,00Ch,083h,00Ch,0DCh,00Ch,0DCh,00Ch ; ovr_1d43_9eb4:F877


CO055_TEXT	     ends
; END LG0C0
; BEGIN STOVR185 (listing ovr_1d43_9eb4:F87F)



CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M013_BCC_DATA_8B46	     equ     8B46h

BCC_NEAR_F87F   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     word ptr DGROUP:M013_BCC_DATA_8B46,0
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     db	     0E8h
   	     dw	     00019h
   	     mov     AL,byte ptr [BP+4]
   	     and     AL,0FFh
   	     push    AX
   	     db	     0E8h
   	     dw	     00010h
   	     mov     AX,word ptr [BP+4]
   	     mov     CL,8
   	     shr     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     00005h
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_F87F   endp
CO055_TEXT	     ends

; END STOVR185
; BEGIN STOVR186 (listing ovr_1d43_9eb4:F8A9)

   	     extrn   BCC_FAR_5E92:far


CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M014_BCC_DATA_8B46	     equ     8B46h

BCC_NEAR_F8A9   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,byte ptr [BP+4]
   	     mov     AH,0
   	     add     word ptr DGROUP:M014_BCC_DATA_8B46,AX
   	     mov     AL,byte ptr [BP+4]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5E92
   	     dw	     seg BCC_FAR_5E92
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_F8A9   endp
CO055_TEXT	     ends

; END STOVR186
; BEGIN STOVR187 (listing ovr_1d43_9eb4:F8C4)



CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP

M015_BCC_DATA_8B46	     equ     8B46h

BCC_NEAR_F8C4   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     mov     AX,DGROUP:M015_BCC_DATA_8B46
   	     neg     AX
   	     and     AX,0FFh
   	     mov     word ptr [BP-2],AX
   	     mov     AL,byte ptr [BP-2]
   	     push    AX
   	     db	     0E8h
   	     dw	     0FFCDh
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret
BCC_NEAR_F8C4   endp
CO055_TEXT	     ends

; END STOVR187
; BEGIN STOVR188 (listing ovr_1d43_9eb4:F8E1)

CO055_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO055_TEXT,ds:DGROUP



   	     public  X055_0B
X055_0B label   far
BCC_FAR_F8E1    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,679Eh
   	     pop     BP
   	     retf
BCC_FAR_F8E1    endp
CO055_TEXT	     ends

; END STOVR188
   	     end
