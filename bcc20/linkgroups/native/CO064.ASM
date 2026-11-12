   	     public  X064_02
   	     public  X064_03
   	     public  X064_00
   	     public  X064_01
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d94_aa11
; BEGIN STAOV0DC (listing ovr_1d94_aa11:A110)

   	     extrn   X043_03:far


CO064_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO064_TEXT,ds:DGROUP

M000_BCC_DATA_818E	     equ     818Eh
M000_BCC_DATA_8664	     equ     8664h
M000_BCC_DATA_86CA	     equ     86CAh

   	     public  X064_01
X064_01 label   far
BCC_NEAR_A110   label   near
STAOV0DC	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,818Eh
   	     push    AX
   	     mov     AX,0Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_818E
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI],AX
   	     cmp     word ptr DGROUP:M000_BCC_DATA_8664,0
   	     je	     short M000_L_A13A
   	     mov     AX,DGROUP:M000_BCC_DATA_8664
   	     jmp     short M000_L_A13D
M000_L_A13A:
   	     mov     AX,1
M000_L_A13D:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_818E
   	     mov     word ptr ES:[SI+8],AX
   	     mov     word ptr ES:[SI+0Ah],0
   	     mov     word ptr ES:[SI+2],0
   	     inc     word ptr DGROUP:M000_BCC_DATA_86CA
   	     mov     AX,DGROUP:M000_BCC_DATA_86CA
   	     mov     word ptr ES:[SI+4],AX
   	     mov     word ptr ES:[SI+6],0
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV0DC	     endp
CO064_TEXT	     ends

; END STAOV0DC
; BEGIN STAOV0DD (listing ovr_1d94_aa11:A167)

   	     extrn   X043_03:far


CO064_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO064_TEXT,ds:DGROUP

M001_BCC_DATA_818E	     equ     818Eh
M001_BCC_DATA_8664	     equ     8664h

   	     public  X064_03
X064_03 label   far
STAOV0DD	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     push    word ptr [BP+6]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     000E7h
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M001_L_A17E
   	     xor     AX,AX
   	     jmp     short M001_L_A1CF
M001_L_A17E:
   	     push    DS
   	     mov     AX,818Eh
   	     push    AX
   	     mov     AX,0Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_818E
   	     mov     AX,word ptr ES:[SI]
   	     mov     word ptr ES:[DI],AX
   	     mov     AX,DGROUP:M001_BCC_DATA_8664
   	     mov     word ptr ES:[DI+8],AX
   	     jmp     short M001_L_A1A9
M001_L_A1A1:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_818E
   	     mov     SI,word ptr ES:[SI+0Ah]
M001_L_A1A9:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_818E
   	     cmp     word ptr ES:[SI+0Ah],0
   	     jne     short M001_L_A1A1
   	     mov     word ptr ES:[DI+0Ah],SI
   	     mov     word ptr ES:[DI+2],0
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[DI+4],AX
   	     mov     word ptr ES:[DI+6],0
   	     mov     AX,word ptr ES:[DI+4]
M001_L_A1CF:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV0DD	     endp
CO064_TEXT	     ends

; END STAOV0DD
; BEGIN STAOV0DE (listing ovr_1d94_aa11:A1D5)

   	     extrn   X043_03:far


CO064_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO064_TEXT,ds:DGROUP

M002_BCC_DATA_818E	     equ     818Eh
M002_BCC_DATA_8664	     equ     8664h
M002_BCC_DATA_86CA	     equ     86CAh

   	     public  X064_00
X064_00 label   far
STAOV0DE	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     push    word ptr [BP+6]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00079h
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M002_L_A1EC
   	     xor     AX,AX
   	     jmp     short M002_L_A255
M002_L_A1EC:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_818E
   	     mov     AX,word ptr ES:[SI+8]
   	     cmp     AX,word ptr DGROUP:M002_BCC_DATA_8664
   	     je	     short M002_L_A203
   	     push    word ptr ES:[SI]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FF0Fh
   	     jmp     short M002_L_A255
M002_L_A203:
   	     push    DS
   	     mov     AX,818Eh
   	     push    AX
   	     mov     AX,0Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_818E
   	     mov     AX,word ptr ES:[SI]
   	     mov     word ptr ES:[DI],AX
   	     mov     AX,word ptr ES:[SI+8]
   	     mov     word ptr ES:[DI+8],AX
   	     jmp     short M002_L_A22F
M002_L_A227:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_818E
   	     mov     SI,word ptr ES:[SI+0Ah]
M002_L_A22F:
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_818E
   	     cmp     word ptr ES:[SI+0Ah],0
   	     jne     short M002_L_A227
   	     mov     word ptr ES:[DI+0Ah],SI
   	     mov     word ptr ES:[DI+2],0
   	     inc     word ptr DGROUP:M002_BCC_DATA_86CA
   	     mov     AX,DGROUP:M002_BCC_DATA_86CA
   	     mov     word ptr ES:[DI+4],AX
   	     mov     word ptr ES:[DI+6],0
M002_L_A255:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV0DE	     endp
CO064_TEXT	     ends

; END STAOV0DE
; BEGIN STAOV0DF (listing ovr_1d94_aa11:A25B)

CO064_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO064_TEXT,ds:DGROUP

M003_BCC_DATA_818E	     equ     818Eh
M003_BCC_DATA_8192	     equ     8192h


   	     public  X064_02
X064_02 label   far
BCC_NEAR_A25B   label   near
STAOV0DF	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DX,word ptr [BP+6]
   	     xor     DI,DI
   	     mov     SI,2
   	     jmp     short M003_L_A27B
M003_L_A26A:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_818E
   	     mov     AX,word ptr ES:[SI+4]
   	     cmp     AX,DX
   	     jne     short M003_L_A278
   	     mov     DI,SI
M003_L_A278:
   	     add     SI,0Eh
M003_L_A27B:
   	     cmp     SI,word ptr DGROUP:M003_BCC_DATA_8192
   	     jc	     short M003_L_A26A
   	     mov     AX,DI
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
STAOV0DF	     endp
CO064_TEXT	     ends

; END STAOV0DF
   	     end
