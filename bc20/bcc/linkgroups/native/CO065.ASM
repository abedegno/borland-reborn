   	     public  X065_02
   	     public  X065_09
   	     public  X065_03
   	     public  X065_00
   	     public  X065_01
   	     public  X065_06
   	     public  X065_07
   	     public  X065_04
   	     public  X065_05
   	     public  X065_08
   	     public  X065_0C
   	     public  X065_0B
   	     public  X065_0A
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d98_aa29
; BEGIN STAOV0E0 (listing ovr_1d98_aa29:A290)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M000_BCC_DATA_8B28	     equ     8B28h
M000_BCC_DATA_8B31	     equ     8B31h

   	     public  X065_02
X065_02 label   far
STAOV0E0	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     word ptr DGROUP:M000_BCC_DATA_8B28,0
   	     mov     word ptr DGROUP:M000_BCC_DATA_8B31,0
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     0022Eh
   	     pop     BP
   	     retf    2
STAOV0E0	     endp
CO065_TEXT	     ends

; END STAOV0E0
; BEGIN STAOV0E1 (listing ovr_1d98_aa29:A2A9)

   	     extrn   BCC_FAR_AF23:far


CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M001_BCC_DATA_8B28	     equ     8B28h
M001_BCC_DATA_8B2A	     equ     8B2Ah
M001_BCC_DATA_8B2B	     equ     8B2Bh
M001_BCC_DATA_8B2C	     equ     8B2Ch
M001_BCC_DATA_8B2D	     equ     8B2Dh
M001_BCC_DATA_8B31	     equ     8B31h
M001_BCC_DATA_8B35	     equ     8B35h

   	     public  X065_09
X065_09 label   far
STAOV0E1	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     byte ptr DGROUP:M001_BCC_DATA_8B2B,0FFh
   	     mov     byte ptr DGROUP:M001_BCC_DATA_8B2A,0FFh
   	     mov     word ptr DGROUP:M001_BCC_DATA_8B28,5
   	     mov     byte ptr DGROUP:M001_BCC_DATA_8B2C,0Ah
   	     mov     AX,word ptr [BP+8]
   	     mov     DGROUP:M001_BCC_DATA_8B2D,AX
   	     mov     word ptr DGROUP:M001_BCC_DATA_8B31,1
   	     mov     AL,byte ptr [BP+6]
   	     mov     DGROUP:M001_BCC_DATA_8B35,AL
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     001E9h
   	     pop     BP
   	     retf    6
STAOV0E1	     endp
CO065_TEXT	     ends

; END STAOV0E1
; BEGIN STAOV0E2 (listing ovr_1d98_aa29:A2EE)

   	     extrn   BCC_FAR_AF23:far


CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M002_BCC_DATA_8B28	     equ     8B28h
M002_BCC_DATA_8B2C	     equ     8B2Ch
M002_BCC_DATA_8B31	     equ     8B31h
M002_BCC_DATA_8B33	     equ     8B33h
M002_BCC_DATA_8B34	     equ     8B34h
M002_BCC_DATA_8B35	     equ     8B35h
M002_BCC_DATA_8B36	     equ     8B36h

   	     public  X065_06
X065_06 label   far
STAOV0E2	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    DS
   	     mov     AX,8B31h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     byte ptr DGROUP:M002_BCC_DATA_8B34,0FFh
   	     mov     byte ptr DGROUP:M002_BCC_DATA_8B33,0FFh
   	     mov     word ptr DGROUP:M002_BCC_DATA_8B31,5
   	     mov     byte ptr DGROUP:M002_BCC_DATA_8B35,0Ah
   	     mov     AX,word ptr [BP+6]
   	     mov     DGROUP:M002_BCC_DATA_8B36,AX
   	     mov     word ptr DGROUP:M002_BCC_DATA_8B28,1
   	     mov     AL,byte ptr [BP+8]
   	     mov     DGROUP:M002_BCC_DATA_8B2C,AL
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     001A4h
   	     pop     BP
   	     retf    6
STAOV0E2	     endp
CO065_TEXT	     ends

; END STAOV0E2
; BEGIN STAOV0E3 (listing ovr_1d98_aa29:A333)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M003_BCC_DATA_8B28	     equ     8B28h
M003_BCC_DATA_8B2C	     equ     8B2Ch
M003_BCC_DATA_8B31	     equ     8B31h

   	     public  X065_00
X065_00 label   far
BCC_NEAR_A333   label   near
STAOV0E3	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     word ptr DGROUP:M003_BCC_DATA_8B28,1
   	     mov     AL,byte ptr [BP+6]
   	     mov     DGROUP:M003_BCC_DATA_8B2C,AL
   	     mov     word ptr DGROUP:M003_BCC_DATA_8B31,0
   	     push    word ptr [BP+8]
   	     db	     0E8h
   	     dw	     00185h
   	     pop     BP
   	     retf    4
STAOV0E3	     endp
CO065_TEXT	     ends

; END STAOV0E3
; BEGIN STAOV0E4 (listing ovr_1d98_aa29:A352)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M004_BCC_DATA_8B31	     equ     8B31h

   	     public  X065_03
X065_03 label   far
STAOV0E4	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     004B6h
   	     mov     word ptr DGROUP:M004_BCC_DATA_8B31,0
   	     push    word ptr [BP+8]
   	     db	     0E8h
   	     dw	     00168h
   	     pop     BP
   	     retf    4
STAOV0E4	     endp
CO065_TEXT	     ends

; END STAOV0E4
; BEGIN STAOV0E5 (listing ovr_1d98_aa29:A36F)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M005_BCC_DATA_8B28	     equ     8B28h
M005_BCC_DATA_8B2C	     equ     8B2Ch
M005_BCC_DATA_8B31	     equ     8B31h
M005_BCC_DATA_8B35	     equ     8B35h

   	     public  X065_0B
X065_0B label   far
BCC_NEAR_A36F   label   near
STAOV0E5	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     byte ptr [BP+8],0Ch
   	     jl	     short M005_L_A3A0
   	     cmp     byte ptr [BP+6],0Ch
   	     jl	     short M005_L_A3A0
   	     mov     AL,byte ptr [BP+8]
   	     cmp     AL,byte ptr [BP+6]
   	     je	     short M005_L_A3BE
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FFA1h
   	     mov     AX,7Fh
   	     push    AX
   	     mov     AL,byte ptr [BP+8]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF95h
   	     jmp     short M005_L_A3BE
M005_L_A3A0:
   	     mov     word ptr DGROUP:M005_BCC_DATA_8B28,1
   	     mov     AL,byte ptr [BP+8]
   	     mov     DGROUP:M005_BCC_DATA_8B2C,AL
   	     mov     word ptr DGROUP:M005_BCC_DATA_8B31,1
   	     mov     AL,byte ptr [BP+6]
   	     mov     DGROUP:M005_BCC_DATA_8B35,AL
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     00115h
M005_L_A3BE:
   	     pop     BP
   	     retf    6
STAOV0E5	     endp
CO065_TEXT	     ends

; END STAOV0E5
; BEGIN STAOV0E6 (listing ovr_1d98_aa29:A3C2)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M006_BCC_DATA_8B28	     equ     8B28h
M006_BCC_DATA_8B2C	     equ     8B2Ch
M006_BCC_DATA_8B31	     equ     8B31h
M006_BCC_DATA_8B35	     equ     8B35h

   	     public  X065_0C
X065_0C label   far
STAOV0E6	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+0Ah]
   	     mov     word ptr DGROUP:M006_BCC_DATA_8B28,1
   	     mov     AL,byte ptr [BP+8]
   	     mov     DGROUP:M006_BCC_DATA_8B2C,AL
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     00436h
   	     cmp     word ptr DGROUP:M006_BCC_DATA_8B31,1
   	     jne     short M006_L_A3F5
   	     push    SI
   	     mov     AL,DGROUP:M006_BCC_DATA_8B2C
   	     push    AX
   	     mov     AL,DGROUP:M006_BCC_DATA_8B35
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF7Ch
   	     jmp     short M006_L_A3F9
M006_L_A3F5:
   	     push    SI
   	     db	     0E8h
   	     dw	     000DAh
M006_L_A3F9:
   	     pop     SI
   	     pop     BP
   	     retf    6
STAOV0E6	     endp
CO065_TEXT	     ends

; END STAOV0E6
; BEGIN STAOV0E7 (listing ovr_1d98_aa29:A3FE)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M007_BCC_DATA_8B28	     equ     8B28h
M007_BCC_DATA_8B2C	     equ     8B2Ch
M007_BCC_DATA_8B31	     equ     8B31h
M007_BCC_DATA_8B36	     equ     8B36h

   	     public  X065_08
X065_08 label   far
STAOV0E7	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     word ptr DGROUP:M007_BCC_DATA_8B28,1
   	     mov     AL,byte ptr [BP+8]
   	     mov     DGROUP:M007_BCC_DATA_8B2C,AL
   	     mov     word ptr DGROUP:M007_BCC_DATA_8B31,4
   	     mov     AX,word ptr [BP+6]
   	     mov     DGROUP:M007_BCC_DATA_8B36,AX
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     000B4h
   	     pop     BP
   	     retf    6
STAOV0E7	     endp
CO065_TEXT	     ends

; END STAOV0E7
; BEGIN STAOV0E8 (listing ovr_1d98_aa29:A423)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M008_BCC_DATA_8B31	     equ     8B31h
M008_BCC_DATA_8B35	     equ     8B35h

   	     public  X065_05
X065_05 label   far
STAOV0E8	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [BP+8]
   	     db	     0E8h
   	     dw	     003E5h
   	     mov     word ptr DGROUP:M008_BCC_DATA_8B31,1
   	     mov     AL,byte ptr [BP+6]
   	     mov     DGROUP:M008_BCC_DATA_8B35,AL
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     00091h
   	     pop     BP
   	     retf    6
STAOV0E8	     endp
CO065_TEXT	     ends

; END STAOV0E8
; BEGIN STAOV0E9 (listing ovr_1d98_aa29:A446)




CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

   	     public  X065_04
X065_04 label   far
STAOV0E9	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [BP+8]
   	     db	     0E8h
   	     dw	     003C2h
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     003B8h
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     00070h
   	     pop     BP
   	     retf    6
STAOV0E9	     endp
CO065_TEXT	     ends

; END STAOV0E9
; BEGIN STAOV0EA (listing ovr_1d98_aa29:A467)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M00A_BCC_DATA_8B31	     equ     8B31h
M00A_BCC_DATA_8B36	     equ     8B36h

   	     public  X065_07
X065_07 label   far
STAOV0EA	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [BP+8]
   	     db	     0E8h
   	     dw	     003A1h
   	     mov     word ptr DGROUP:M00A_BCC_DATA_8B31,4
   	     mov     AX,word ptr [BP+6]
   	     mov     DGROUP:M00A_BCC_DATA_8B36,AX
   	     push    word ptr [BP+0Ah]
   	     db	     0E8h
   	     dw	     0004Dh
   	     pop     BP
   	     retf    6
STAOV0EA	     endp
CO065_TEXT	     ends

; END STAOV0EA
; BEGIN STAOV0EB (listing ovr_1d98_aa29:A48A)

   	     extrn   BCC_FAR_AF23:far


CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M00B_BCC_DATA_866E	     equ     866Eh
M00B_BCC_DATA_8B28	     equ     8B28h
M00B_BCC_DATA_8B2A	     equ     8B2Ah
M00B_BCC_DATA_8B2B	     equ     8B2Bh
M00B_BCC_DATA_8B2C	     equ     8B2Ch
M00B_BCC_DATA_8B2D	     equ     8B2Dh
M00B_BCC_DATA_8B31	     equ     8B31h

   	     public  X065_01
X065_01 label   far
STAOV0EB	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     push    DS
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     word ptr DGROUP:M00B_BCC_DATA_8B28,5
   	     mov     byte ptr DGROUP:M00B_BCC_DATA_8B2C,0Ah
   	     mov     byte ptr DGROUP:M00B_BCC_DATA_8B2B,0FFh
   	     mov     byte ptr DGROUP:M00B_BCC_DATA_8B2A,0FFh
   	     mov     ES,word ptr DGROUP:M00B_BCC_DATA_866E
   	     mov     AX,word ptr ES:[SI+0Fh]
   	     mov     DGROUP:M00B_BCC_DATA_8B2D,AX
   	     mov     word ptr DGROUP:M00B_BCC_DATA_8B31,0
   	     push    word ptr [BP+8]
   	     db	     0E8h
   	     dw	     00005h
   	     pop     SI
   	     pop     BP
   	     retf    4
STAOV0EB	     endp
CO065_TEXT	     ends

; END STAOV0EB
; BEGIN STAOV0EC (listing ovr_1d98_aa29:A4D3)

   	     extrn   BCC_FAR_0402:far
   	     extrn   BCC_FAR_B0F1:far


CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M00C_BCC_DATA_87F4	     equ     87F4h
M00C_BCC_DATA_88B0	     equ     88B0h
M00C_BCC_DATA_88B1	     equ     88B1h
M00C_BCC_DATA_8B20	     equ     8B20h
M00C_BCC_DATA_8B21	     equ     8B21h
M00C_BCC_DATA_8B22	     equ     8B22h
M00C_BCC_DATA_8B23	     equ     8B23h
M00C_BCC_DATA_8B25	     equ     8B25h
M00C_BCC_DATA_8B28	     equ     8B28h
M00C_BCC_DATA_8B2C	     equ     8B2Ch
M00C_BCC_DATA_8B31	     equ     8B31h
M00C_BCC_DATA_8B33	     equ     8B33h
M00C_BCC_DATA_8B34	     equ     8B34h
M00C_BCC_DATA_8B35	     equ     8B35h
M00C_BCC_DATA_8B36	     equ     8B36h
M00C_BCC_DATA_8B38	     equ     8B38h

BCC_NEAR_A4D3   label   near
STAOV0EC	     proc    near
M00C_L_A4D3:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,1Ch
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     cmp     byte ptr DGROUP:M00C_BCC_DATA_88B1,0
   	     jne     short M00C_L_A4E8
   	     db	     0E9h
   	     dw	     0008Ah
M00C_L_A4E8:
   	     cmp     SI,9Ch
   	     jne     short M00C_L_A522
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B22
   	     cmp     AL,byte ptr DGROUP:M00C_BCC_DATA_8B35
   	     jne     short M00C_L_A522
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B21
   	     cmp     AL,byte ptr DGROUP:M00C_BCC_DATA_8B34
   	     jne     short M00C_L_A522
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B20
   	     cmp     AL,byte ptr DGROUP:M00C_BCC_DATA_8B33
   	     jne     short M00C_L_A522
   	     mov     AX,DGROUP:M00C_BCC_DATA_8B25
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_8B38
   	     jne     short M00C_L_A522
   	     mov     AX,DGROUP:M00C_BCC_DATA_8B36
   	     inc     AX
   	     inc     AX
   	     cmp     AX,word ptr DGROUP:M00C_BCC_DATA_8B23
   	     jne     short M00C_L_A522
   	     mov     SI,96h
   	     jmp     short M00C_L_A56D
M00C_L_A522:
   	     push    SS
   	     lea     AX,[BP-1Ch]
   	     push    AX
   	     push    DS
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,1Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     mov     byte ptr DGROUP:M00C_BCC_DATA_8B2C,0Ch
   	     mov     AX,8B31h
   	     push    DS
   	     push    AX
   	     mov     AX,8B1Eh
   	     push    DS
   	     push    AX
   	     mov     CX,9
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     mov     AX,9Ch
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     87F4h
   	     push    DS
   	     mov     AX,8B28h
   	     push    AX
   	     push    SS
   	     lea     AX,[BP-1Ch]
   	     push    AX
   	     mov     AX,1Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
M00C_L_A56D:
   	     mov     byte ptr DGROUP:M00C_BCC_DATA_88B1,0
M00C_L_A572:
   	     mov     AX,SI
   	     cmp     AX,93h
   	     jne     short M00C_L_A57C
   	     db	     0E9h
   	     dw	     000A8h
M00C_L_A57C:
   	     jg	     short M00C_L_A5B5
   	     cmp     AX,28h
   	     jne     short M00C_L_A586
   	     db	     0E9h
   	     dw	     00193h
M00C_L_A586:
   	     jg	     short M00C_L_A5A3
   	     cmp     AX,1Eh
   	     jne     short M00C_L_A590
   	     db	     0E9h
   	     dw	     00138h
M00C_L_A590:
   	     cmp     AX,1Fh
   	     jne     short M00C_L_A598
   	     db	     0E9h
   	     dw	     00130h
M00C_L_A598:
   	     cmp     AX,27h
   	     jne     short M00C_L_A5A0
   	     db	     0E9h
   	     dw	     00179h
M00C_L_A5A0:
   	     db	     0E9h
   	     dw	     001C1h
M00C_L_A5A3:
   	     cmp     AX,57h
   	     je	     short M00C_L_A5EC
   	     cmp     AX,80h
   	     je	     short M00C_L_A5F4
   	     cmp     AX,81h
   	     je	     short M00C_L_A5F4
   	     db	     0E9h
   	     dw	     001AFh
M00C_L_A5B5:
   	     cmp     AX,9Bh
   	     jne     short M00C_L_A5BD
   	     db	     0E9h
   	     dw	     000C3h
M00C_L_A5BD:
   	     jg	     short M00C_L_A5D4
   	     cmp     AX,97h
   	     jne     short M00C_L_A5C7
   	     db	     0E9h
   	     dw	     000B9h
M00C_L_A5C7:
   	     cmp     AX,98h
   	     je	     short M00C_L_A62A
   	     cmp     AX,99h
   	     je	     short M00C_L_A62A
   	     db	     0E9h
   	     dw	     00190h
M00C_L_A5D4:
   	     cmp     AX,9Ch
   	     je	     short M00C_L_A62A
   	     cmp     AX,0AEh
   	     jne     short M00C_L_A5E1
   	     db	     0E9h
   	     dw	     0018Ch
M00C_L_A5E1:
   	     cmp     AX,0B1h
   	     jne     short M00C_L_A5E9
   	     db	     0E9h
   	     dw	     00184h
M00C_L_A5E9:
   	     db	     0E9h
   	     dw	     00178h
M00C_L_A5EC:
   	     mov     byte ptr DGROUP:M00C_BCC_DATA_88B0,1
   	     db	     0E9h
   	     dw	     00179h
M00C_L_A5F4:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     je	     short M00C_L_A5FE
   	     db	     0E9h
   	     dw	     00166h
M00C_L_A5FE:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B31,4
   	     je	     short M00C_L_A608
   	     db	     0E9h
   	     dw	     0015Ch
M00C_L_A608:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,0
   	     je	     short M00C_L_A612
   	     db	     0E9h
   	     dw	     00152h
M00C_L_A612:
   	     add     SI,-34h
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,1
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B2C
   	     mov     DGROUP:M00C_BCC_DATA_8B35,AL
   	     db	     0E9h
   	     dw	     00140h
M00C_L_A624:
   	     mov     SI,94h
   	     db	     0E9h
   	     dw	     0013Ah
M00C_L_A62A:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     jne     short M00C_L_A659
   	     cmp     byte ptr DGROUP:M00C_BCC_DATA_8B2C,0Ch
   	     jne     short M00C_L_A659
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B31,5
   	     jne     short M00C_L_A659
   	     mov     AX,8B1Eh
   	     push    DS
   	     push    AX
   	     mov     AX,8B31h
   	     push    DS
   	     push    AX
   	     mov     CX,9
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     mov     byte ptr DGROUP:M00C_BCC_DATA_88B1,1
   	     db	     0E9h
   	     dw	     00114h
M00C_L_A659:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     jne     short M00C_L_A680
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B31,4
   	     jne     short M00C_L_A680
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,0
   	     jne     short M00C_L_A680
   	     mov     SI,4Fh
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,1
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B2C
   	     mov     DGROUP:M00C_BCC_DATA_8B35,AL
   	     db	     0E9h
   	     dw	     000E4h
M00C_L_A680:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     je	     short M00C_L_A68A
   	     db	     0E9h
   	     dw	     000DAh
M00C_L_A68A:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B31,1
   	     je	     short M00C_L_A694
   	     db	     0E9h
   	     dw	     000D0h
M00C_L_A694:
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B2C
   	     cmp     AL,byte ptr DGROUP:M00C_BCC_DATA_8B35
   	     jne     short M00C_L_A6A0
   	     db	     0E9h
   	     dw	     000CDh
M00C_L_A6A0:
   	     cmp     SI,9Ch
   	     jne     short M00C_L_A6A9
   	     db	     0E9h
   	     dw	     000BBh
M00C_L_A6A9:
   	     cmp     SI,98h
   	     jne     short M00C_L_A6B2
   	     db	     0E9h
   	     dw	     000B2h
M00C_L_A6B2:
   	     cmp     byte ptr DGROUP:M00C_BCC_DATA_8B35,7
   	     jg	     short M00C_L_A6BC
   	     db	     0E9h
   	     dw	     000A8h
M00C_L_A6BC:
   	     mov     SI,9Ch
   	     mov     AL,DGROUP:M00C_BCC_DATA_8B2C
   	     mov     DGROUP:M00C_BCC_DATA_8B2C,AL
   	     db	     0E9h
   	     dw	     0009Ch
M00C_L_A6C8:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B31,4
   	     je	     short M00C_L_A6D2
   	     db	     0E9h
   	     dw	     00092h
M00C_L_A6D2:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,1
   	     jne     short M00C_L_A6E5
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,0
   	     add     SI,3Ah
   	     db	     0E9h
   	     dw	     0007Fh
M00C_L_A6E5:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,2
   	     jne     short M00C_L_A707
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     jne     short M00C_L_A707
   	     cmp     SI,1Fh
   	     jne     short M00C_L_A707
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,0
   	     add     SI,3Ah
   	     push    SI
   	     db	     0E8h
   	     dw	     0FDCEh
   	     jmp     short M00C_L_A764
M00C_L_A707:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,-1
   	     jne     short M00C_L_A764
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,0
   	     add     SI,3Ch
   	     jmp     short M00C_L_A764
M00C_L_A719:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B31,4
   	     jne     short M00C_L_A764
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,1
   	     jne     short M00C_L_A732
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,0
   	     add     SI,33h
   	     jmp     short M00C_L_A764
M00C_L_A732:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,2
   	     jne     short M00C_L_A754
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B28,1
   	     jne     short M00C_L_A754
   	     cmp     SI,28h
   	     jne     short M00C_L_A754
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,0
   	     add     SI,33h
   	     push    SI
   	     db	     0E8h
   	     dw	     0FD81h
   	     jmp     short M00C_L_A764
M00C_L_A754:
   	     cmp     word ptr DGROUP:M00C_BCC_DATA_8B36,-1
   	     jne     short M00C_L_A764
   	     mov     word ptr DGROUP:M00C_BCC_DATA_8B31,0
   	     add     SI,31h
M00C_L_A764:
   	     push    SI
   	     db	     0E8h
   	     dw	     0000Dh
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     87F4h
M00C_L_A76D:
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV0EC	     endp
CO065_TEXT	     ends

; END STAOV0EC
; BEGIN STAOV0ED (listing ovr_1d98_aa29:A775)

CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M00D_BCC_DATA_87F4	     equ     87F4h
M00D_BCC_DATA_88B0	     equ     88B0h
M00D_BCC_DATA_8B28	     equ     8B28h
M00D_BCC_DATA_8B2C	     equ     8B2Ch
M00D_BCC_DATA_8B31	     equ     8B31h


BCC_NEAR_A775   label   near
STAOV0ED	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+4]
   	     mov     AL,DGROUP:M00D_BCC_DATA_88B0
   	     cbw
   	     or	     AX,AX
   	     jne     short M00D_L_A78C
   	     db	     0E9h
   	     dw	     00080h
M00D_L_A78C:
   	     mov     AX,SI
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     DI,AX
   	     cmp     word ptr DGROUP:M00D_BCC_DATA_8B28,5
   	     je	     short M00D_L_A7D0
   	     cmp     word ptr DGROUP:M00D_BCC_DATA_8B31,5
   	     je	     short M00D_L_A7D0
   	     cmp     SI,7Eh
   	     je	     short M00D_L_A7D0
   	     cmp     SI,7Fh
   	     je	     short M00D_L_A7D0
   	     cmp     SI,0A3h
   	     je	     short M00D_L_A7D0
   	     cmp     SI,0A2h
   	     je	     short M00D_L_A7D0
   	     cmp     SI,0A1h
   	     je	     short M00D_L_A7D0
   	     cmp     word ptr DGROUP:M00D_BCC_DATA_8B28,1
   	     jne     short M00D_L_A80C
   	     cmp     byte ptr DGROUP:M00D_BCC_DATA_8B2C,0Bh
   	     jne     short M00D_L_A80C
M00D_L_A7D0:
   	     mov     AX,word ptr [DI+3]
   	     and     AX,2
   	     or	     AX,0
   	     jne     short M00D_L_A807
   	     mov     AX,DGROUP:M00D_BCC_DATA_8B28
   	     mov     word ptr [BP-2],AX
   	     mov     AX,DGROUP:M00D_BCC_DATA_8B31
   	     mov     word ptr [BP-4],AX
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B28,0
   	     mov     word ptr DGROUP:M00D_BCC_DATA_8B31,0
   	     mov     AX,57h
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     87F4h
   	     mov     AX,word ptr [BP-2]
   	     mov     DGROUP:M00D_BCC_DATA_8B28,AX
   	     mov     AX,word ptr [BP-4]
   	     mov     DGROUP:M00D_BCC_DATA_8B31,AX
M00D_L_A807:
   	     mov     byte ptr DGROUP:M00D_BCC_DATA_88B0,0
M00D_L_A80C:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV0ED	     endp
CO065_TEXT	     ends

; END STAOV0ED
; BEGIN STAOV0EE (listing ovr_1d98_aa29:A815)

   	     extrn   BCC_FAR_AF23:far


CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M00E_BCC_DATA_866E	     equ     866Eh
M00E_BCC_DATA_8680	     equ     8680h
M00E_BCC_DATA_8698	     equ     8698h
M00E_BCC_DATA_86E6	     equ     86E6h
M00E_BCC_DATA_86E8	     equ     86E8h
M00E_BCC_DATA_88AE	     equ     88AEh
M00E_BCC_DATA_88B6	     equ     88B6h

BCC_NEAR_A815   label   near
STAOV0EE	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     push    DS
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     byte ptr [SI+2],0FFh
   	     mov     byte ptr [SI+4],0FFh
   	     mov     byte ptr [SI+3],0FFh
   	     mov     AX,word ptr [BP+4]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     cmp     byte ptr ES:[DI+2],0FFh
   	     je	     short M00E_L_A85D
   	     mov     word ptr [SI],1
   	     mov     AL,byte ptr ES:[DI+2]
   	     mov     byte ptr [SI+4],AL
   	     db	     0E9h
   	     dw	     0024Bh
M00E_L_A85D:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     cmp     AX,14h
   	     jne     short M00E_L_A86E
   	     db	     0E9h
   	     dw	     000FFh
M00E_L_A86E:
   	     jg	     short M00E_L_A884
   	     sub     AX,7
   	     mov     BX,AX
   	     cmp     BX,0Ch
   	     jbe     short M00E_L_A87D
   	     db	     0E9h
   	     dw	     00227h
M00E_L_A87D:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     82Dh
M00E_L_A884:
   	     cmp     AX,1Bh
   	     jne     short M00E_L_A88C
   	     db	     0E9h
   	     dw	     0019Fh
M00E_L_A88C:
   	     jg	     short M00E_L_A8A2
   	     sub     AX,15h
   	     mov     BX,AX
   	     cmp     BX,5
   	     jbe     short M00E_L_A89B
   	     db	     0E9h
   	     dw	     00209h
M00E_L_A89B:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     821h
M00E_L_A8A2:
   	     cmp     AX,7Bh
   	     jne     short M00E_L_A8AA
   	     db	     0E9h
   	     dw	     000ABh
M00E_L_A8AA:
   	     jg	     short M00E_L_A8BF
   	     cmp     AX,77h
   	     jne     short M00E_L_A8B4
   	     db	     0E9h
   	     dw	     000B9h
M00E_L_A8B4:
   	     cmp     AX,78h
   	     jne     short M00E_L_A8BC
   	     db	     0E9h
   	     dw	     000B1h
M00E_L_A8BC:
   	     db	     0E9h
   	     dw	     001E5h
M00E_L_A8BF:
   	     cmp     AX,7Ch
   	     je	     short M00E_L_A8F6
   	     cmp     AX,0B2h
   	     je	     short M00E_L_A8DD
   	     db	     0E9h
   	     dw	     001D8h
   	     mov     word ptr [SI],1
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AL,byte ptr ES:[DI]
   	     mov     byte ptr [SI+4],AL
   	     db	     0E9h
   	     dw	     001CBh
M00E_L_A8DD:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI]
   	     sub     AX,word ptr DGROUP:M00E_BCC_DATA_86E6
   	     sub     AX,word ptr DGROUP:M00E_BCC_DATA_88B6
   	     mov     word ptr [SI+5],AX
   	     mov     byte ptr [SI+4],0Ah
   	     db	     0E9h
   	     dw	     001AEh
M00E_L_A8F6:
   	     mov     word ptr [SI],2
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     word ptr [SI+5],AX
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     cmp     byte ptr ES:[BX+0Dh],5
   	     je	     short M00E_L_A925
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     cmp     byte ptr ES:[BX+0Dh],6
   	     jne     short M00E_L_A941
M00E_L_A925:
   	     mov     byte ptr [SI+4],0Ah
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     mov     AX,word ptr [SI+5]
   	     add     AX,word ptr ES:[BX+0Fh]
   	     mov     word ptr [SI+5],AX
   	     db	     0E9h
   	     dw	     00163h
M00E_L_A941:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [SI+7],AX
   	     db	     0E9h
   	     dw	     00153h
M00E_L_A955:
   	     mov     word ptr [SI],3
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [SI+7],AX
   	     db	     0E9h
   	     dw	     0013Bh
M00E_L_A96D:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI]
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     cmp     byte ptr ES:[BX+0Dh],5
   	     je	     short M00E_L_A98C
   	     cmp     byte ptr ES:[BX+0Dh],6
   	     jne     short M00E_L_A9FC
M00E_L_A98C:
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     test    byte ptr ES:[BX+0Eh],2
   	     je	     short M00E_L_A9DF
   	     mov     AL,byte ptr ES:[BX+7]
   	     mov     byte ptr [SI+4],AL
   	     mov     word ptr [SI],1
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+3F9Bh]
   	     and     AX,2
   	     or	     AX,0
   	     jne     short M00E_L_A9CA
   	     cmp     byte ptr [SI+4],10h
   	     jge     short M00E_L_A9CA
   	     db	     0E9h
   	     dw	     000DEh
M00E_L_A9CA:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI+3]
   	     and     AL,3Fh
   	     add     AL,byte ptr [SI+4]
   	     add     AL,0F0h
   	     mov     byte ptr [SI+4],AL
   	     db	     0E9h
   	     dw	     000C9h
M00E_L_A9DF:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     add     AX,word ptr ES:[BX+0Fh]
   	     mov     word ptr [SI+5],AX
   	     mov     byte ptr [SI+4],0Ah
   	     db	     0E9h
   	     dw	     000A8h
M00E_L_A9FC:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_866E
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [SI+7],AX
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     word ptr [SI+5],AX
   	     db	     0E9h
   	     dw	     00089h
   	     mov     AX,DGROUP:M00E_BCC_DATA_86E8
   	     add     AX,word ptr DGROUP:M00E_BCC_DATA_88AE
   	     mov     word ptr [SI+5],AX
   	     mov     byte ptr [SI+4],0Ah
   	     jmp     short M00E_L_AAA4
M00E_L_AA2B:
   	     push    SI
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     push    word ptr ES:[DI]
   	     db	     0E8h
   	     dw	     00102h
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     cmp     byte ptr ES:[DI],1Bh
   	     jne     short M00E_L_AA44
   	     add     word ptr [SI+5],2
M00E_L_AA44:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     cmp     word ptr ES:[DI+2],0
   	     je	     short M00E_L_AA70
   	     mov     AX,word ptr ES:[DI+2]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     00077h
   	     push    SI
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+2]
   	     push    AX
   	     db	     0E8h
   	     dw	     001EFh
M00E_L_AA70:
   	     cmp     byte ptr [SI+2],0Dh
   	     jne     short M00E_L_AA82
   	     cmp     byte ptr [SI+4],0Ah
   	     je	     short M00E_L_AAA4
   	     mov     byte ptr [SI+2],0FFh
   	     jmp     short M00E_L_AAA4
M00E_L_AA82:
   	     cmp     byte ptr [SI+2],0Fh
   	     jne     short M00E_L_AAA4
   	     cmp     byte ptr [SI+4],0Ah
   	     jne     short M00E_L_AAA4
   	     mov     byte ptr [SI+2],0FFh
   	     jmp     short M00E_L_AAA4
   	     mov     word ptr [SI],4
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI]
   	     mov     word ptr [SI+5],AX
   	     jmp     short M00E_L_AAA8
M00E_L_AAA4:
   	     mov     word ptr [SI],5
M00E_L_AAA8:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
STAOV0EE	     endp
CO065_TEXT	     ends

; END STAOV0EE
; BEGIN LG0C1 (gap	ovr_1d98_aa29:AAB1)
CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT
; Original-image layout stub: not recovered source


   	     db	     09Bh,007h,09Bh,007h,09Bh,007h,09Bh,007h,09Bh,007h,09Bh,007h,03Ch,006h  ; ovr_1d98_aa29:AAB1
   	     db	     03Ch,006h,004h,008h,004h,008h,004h,008h,0C5h,006h,066h,006h,08Bh,007h  ; ovr_1d98_aa29:AABF
   	     db	     0DDh,006h,0DDh,006h,0DDh,006h,0DDh,006h,0DDh,006h	     ;		    ovr_1d98_aa29:AACD

CO065_TEXT	     ends
; END LG0C1
; BEGIN STAOV0EF (listing ovr_1d98_aa29:AAD7)

CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M010_BCC_DATA_866E	     equ     866Eh
M010_BCC_DATA_8680	     equ     8680h
M010_BCC_DATA_8698	     equ     8698h


BCC_NEAR_AAD7   label   near
STAOV0EF	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI+2],0FFh
   	     jne     short M010_L_AB32
   	     cmp     byte ptr ES:[SI],8
   	     jne     short M010_L_AAF9
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8698
   	     mov     AL,byte ptr ES:[SI]
   	     jmp     short M010_L_AB2A
M010_L_AAF9:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],10h
   	     je	     short M010_L_AB09
   	     cmp     byte ptr ES:[SI],11h
   	     jne     short M010_L_AB32
M010_L_AB09:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_866E
   	     test    byte ptr ES:[BX+0Eh],2
   	     je	     short M010_L_AB32
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_866E
   	     mov     AL,byte ptr ES:[BX+7]
M010_L_AB2A:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],AL
M010_L_AB32:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
STAOV0EF	     endp
CO065_TEXT	     ends

; END STAOV0EF
; BEGIN STAOV0F0 (listing ovr_1d98_aa29:AB38)



CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP

M011_BCC_DATA_866E	     equ     866Eh
M011_BCC_DATA_8680	     equ     8680h
M011_BCC_DATA_8698	     equ     8698h

BCC_NEAR_AB38   label   near
STAOV0F0	     proc    near
M011_L_AB38:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     AX,word ptr [BP+4]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     push    SI
   	     db	     0E8h
   	     dw	     0FF89h
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI+2],0FFh
   	     je	     short M011_L_ABAC
   	     cmp     byte ptr ES:[SI+2],0Ah
   	     jne     short M011_L_AB6A
   	     mov     AL,byte ptr ES:[SI+2]
   	     mov     byte ptr [DI+4],AL
   	     db	     0E9h
   	     dw	     000EEh
M011_L_AB6A:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI+2],4
   	     jne     short M011_L_AB7F
   	     mov     AL,byte ptr ES:[SI+2]
   	     mov     byte ptr [DI+4],AL
   	     db	     0E9h
   	     dw	     000D9h
M011_L_AB7F:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI+2],8
   	     jne     short M011_L_AB94
   	     mov     AL,byte ptr ES:[SI+2]
   	     mov     byte ptr [DI+3],AL
   	     db	     0E9h
   	     dw	     000C4h
M011_L_AB94:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI+2],9
   	     je	     short M011_L_ABA2
   	     db	     0E9h
   	     dw	     000B6h
M011_L_ABA2:
   	     mov     AL,byte ptr ES:[SI+2]
   	     mov     byte ptr [DI+3],AL
   	     db	     0E9h
   	     dw	     000ACh
M011_L_ABAC:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI]
   	     mov     AH,0
   	     cmp     AX,0Bh
   	     je	     short M011_L_ABD6
   	     jg	     short M011_L_ABC9
   	     cmp     AX,9
   	     je	     short M011_L_ABD6
   	     cmp     AX,0Ah
   	     je	     short M011_L_ABD6
   	     db	     0E9h
   	     dw	     0008Fh
M011_L_ABC9:
   	     cmp     AX,0Dh
   	     je	     short M011_L_ABE5
   	     cmp     AX,1Fh
   	     je	     short M011_L_AC41
   	     db	     0E9h
   	     dw	     00082h
M011_L_ABD6:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     mov     AX,word ptr [DI+5]
   	     add     AX,word ptr ES:[SI]
   	     mov     word ptr [DI+5],AX
   	     jmp     short M011_L_AC58
M011_L_ABE5:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     mov     AX,word ptr [DI+5]
   	     add     AX,word ptr ES:[SI+2]
   	     mov     word ptr [DI+5],AX
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_866E
   	     cmp     byte ptr ES:[BX+0Dh],5
   	     je	     short M011_L_AC13
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_866E
   	     cmp     byte ptr ES:[BX+0Dh],6
   	     jne     short M011_L_AC2E
M011_L_AC13:
   	     mov     byte ptr [DI+4],0Ah
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_866E
   	     mov     AX,word ptr [DI+5]
   	     add     AX,word ptr ES:[BX+0Fh]
   	     mov     word ptr [DI+5],AX
   	     jmp     short M011_L_AC58
M011_L_AC2E:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_866E
   	     mov     AX,word ptr ES:[BX]
   	     mov     word ptr [DI+7],AX
   	     jmp     short M011_L_AC58
M011_L_AC41:
   	     push    DI
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     db	     0E8h
   	     dw	     0FEECh
   	     push    DI
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     db	     0E8h
   	     dw	     0FEE0h
M011_L_AC58:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
STAOV0F0	     endp
CO065_TEXT	     ends

; END STAOV0F0
; BEGIN STAOV0F1 (listing ovr_1d98_aa29:AC5F)

CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP



BCC_NEAR_AC5F   label   near
STAOV0F1	     proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     mov     AL,byte ptr [BP+4]
   	     mov     byte ptr [SI+2],AL
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
STAOV0F1	     endp
CO065_TEXT	     ends

; END STAOV0F1
; BEGIN STAOV0F2 (listing ovr_1d98_aa29:AC73)

CO065_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO065_TEXT,ds:DGROUP



   	     public  X065_0A
X065_0A label   far
STAOV0F2	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     BX,word ptr [BP+6]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+5446h]
   	     pop     BP
   	     retf    2
STAOV0F2	     endp
CO065_TEXT	     ends

; END STAOV0F2
   	     end
