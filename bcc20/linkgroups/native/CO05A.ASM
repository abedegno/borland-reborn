   	     public  X05A_00
   	     public  X05A_01
   	     public  X05A_02
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d64_a3bb
; BEGIN STAOV068 (listing ovr_1d64_a3bb:3BB0)

CO05A_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO05A_TEXT,ds:DGROUP

M000_BCC_DATA_86B4	     equ     86B4h


   	     public  X05A_01
X05A_01 label   far
BCC_FAR_3BB0    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,DGROUP:M000_BCC_DATA_86B4
   	     pop     BP
   	     retf
BCC_FAR_3BB0    endp
CO05A_TEXT	     ends

; END STAOV068
; BEGIN STAOV069 (listing ovr_1d64_a3bb:3BB8)

   	     extrn   X043_03:far


CO05A_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO05A_TEXT,ds:DGROUP

M001_BCC_DATA_86B0	     equ     86B0h

   	     public  X05A_02
X05A_02 label   far
BCC_FAR_3BB8    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,86B0h
   	     push    AX
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_86B0
   	     mov     AL,byte ptr [BP+6]
   	     mov     byte ptr ES:[SI],AL
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_3BB8    endp
CO05A_TEXT	     ends

; END STAOV069
; BEGIN STAOV06A (listing ovr_1d64_a3bb:3BDB)

CO05A_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO05A_TEXT,ds:DGROUP

M002_BCC_DATA_86B0	     equ     86B0h
M002_BCC_DATA_86B4	     equ     86B4h
M002_BCC_DATA_86B6	     equ     86B6h


   	     public  X05A_00
X05A_00 label   far
BCC_FAR_3BDB    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,6
   	     push    SI
   	     push    DI
   	     mov     AX,DGROUP:M002_BCC_DATA_86B4
   	     sub     AX,word ptr [BP+6]
   	     mov     word ptr [BP-2],AX
   	     mov     AX,word ptr [BP+6]
   	     cmp     AX,word ptr [BP-2]
   	     jc	     short M002_L_3BFA
   	     cmp     word ptr [BP-2],0
   	     jne     short M002_L_3BFD
M002_L_3BFA:
   	     jmp     short M002_L_3C4A
   	     nop
M002_L_3BFD:
   	     dec     word ptr [BP-2]
   	     mov     AX,word ptr [BP+6]
   	     sub     AX,word ptr [BP-2]
   	     mov     word ptr [BP-4],AX
   	     push    DS
   	     cld
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_86B0
   	     xor     DI,DI
   	     mov     SI,word ptr [BP+6]
   	     mov     DS,word ptr DGROUP:M002_BCC_DATA_86B0
   	     mov     CX,word ptr [BP-4]
   	     db	     0ACh
M002_L_3C1C:
   	     db	     0F2h,0AEh
   	     jne     short M002_L_3C49
   	     mov     DX,CX
   	     mov     CX,word ptr [BP-2]
   	     jcxz    short M002_L_3C33
   	     mov     BX,DI
   	     push    SI
   	     db	     0F3h,0A6h
   	     pop     SI
   	     mov     DI,BX
   	     mov     CX,DX
   	     jne     short M002_L_3C1C
M002_L_3C33:
   	     dec     DI
   	     mov     word ptr [BP-6],DI
   	     pop     DS
   	     mov     word ptr DGROUP:M002_BCC_DATA_86B6,0
   	     mov     AX,word ptr [BP+6]
   	     mov     DGROUP:M002_BCC_DATA_86B4,AX
   	     mov     AX,word ptr [BP-6]
   	     jmp     short M002_L_3C4D
M002_L_3C49:
   	     pop     DS
M002_L_3C4A:
   	     mov     AX,word ptr [BP+6]
M002_L_3C4D:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_3BDB    endp
CO05A_TEXT	     ends

; END STAOV06A
   	     end
