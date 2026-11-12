   	     public  X048_00
   	     public  X048_01
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cff_95a9
; BEGIN STOVR1 (listing ovr_1cff_95a9:5A90)


   	     extrn   X047_01:far


CO048_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO048_TEXT,ds:DGROUP

   	     public  X048_00
X048_00 label   far
BCC_FAR_5A90    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,5
   	     push    AX
   	     db	     09Ah
   	     dw	     X047_01
   	     dw	     seg X047_01
   	     pop     BP
   	     retf
BCC_FAR_5A90    endp
CO048_TEXT	     ends

; END STOVR1
; BEGIN STOVR2 (listing ovr_1cff_95a9:5A9E)

   	     extrn   X02F_00:far
   	     extrn   X030_03:far
   	     extrn   X04A_02:far


CO048_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO048_TEXT,ds:DGROUP

M001_BCC_EXPR_SEGMENT   equ     639Ah
M001_BCC_STMT_RECORD_SEG	     equ     63C2h
M001_BCC_DATA_679C	     equ     679Ch

   	     public  X048_01
X048_01 label   far
BCC_FAR_5A9E    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,779Eh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X02F_00
   	     dw	     seg X02F_00
   	     push    AX
   	     push    word ptr DGROUP:M001_BCC_DATA_679C
   	     mov     AL,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X04A_02
   	     dw	     seg X04A_02
   	     mov     SI,AX
   	     or	     SI,SI
   	     jne     short M001_L_5AD5
   	     mov     AX,5Ah
   	     push    AX
   	     push    DS
   	     mov     AX,779Eh
   	     push    AX
   	     db	     09Ah
   	     dw	     X030_03
   	     dw	     seg X030_03
   	     mov     AX,0FFFFh
   	     jmp     short M001_L_5B06
M001_L_5AD5:
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX],12h
   	     jne     short M001_L_5B04
   	     cmp     word ptr [BP+6],0
   	     jne     short M001_L_5B00
   	     mov     ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
   	     mov     BX,word ptr ES:[SI+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[BX+5],0
   	     je	     short M001_L_5B06
M001_L_5B00:
   	     mov     AX,SI
   	     jmp     short M001_L_5B06
M001_L_5B04:
   	     xor     AX,AX
M001_L_5B06:
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_5A9E    endp
CO048_TEXT	     ends

; END STOVR2
   	     end
