   	     public  X053_00
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d35_9d87
; BEGIN STOVR141 (listing ovr_1d35_9d87:D870)

   	     extrn   BCC_FAR_245C:far
   	     extrn   BCC_FAR_AF23:far
   	     extrn   X054_01:far
   	     extrn   X076_04:far


CO053_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO053_TEXT,ds:DGROUP

M000_BCC_DATA_1714	     equ     1714h
M000_BCC_DATA_1715	     equ     1715h
M000_BCC_DATA_174E	     equ     174Eh
M000_BCC_DATA_1750	     equ     1750h
M000_BCC_DATA_86CC	     equ     86CCh
M000_BCC_DATA_86D2	     equ     86D2h
M000_BCC_DATA_87C6	     equ     87C6h
M000_BCC_DATA_87C8	     equ     87C8h
M000_BCC_DATA_87CA	     equ     87CAh
M000_BCC_DATA_882E	     equ     882Eh
M000_BCC_DATA_8830	     equ     8830h
M000_BCC_DATA_8832	     equ     8832h
M000_BCC_DATA_8836	     equ     8836h
M000_BCC_DATA_8838	     equ     8838h
M000_BCC_DATA_883A	     equ     883Ah
M000_BCC_DATA_883E	     equ     883Eh
M000_BCC_DATA_8840	     equ     8840h
M000_BCC_DATA_8842	     equ     8842h
M000_BCC_DATA_8846	     equ     8846h
M000_BCC_DATA_8848	     equ     8848h
M000_BCC_DATA_884A	     equ     884Ah
M000_BCC_DATA_884E	     equ     884Eh
M000_BCC_DATA_8850	     equ     8850h
M000_BCC_DATA_8852	     equ     8852h
M000_BCC_DATA_8856	     equ     8856h
M000_BCC_DATA_8858	     equ     8858h
M000_BCC_DATA_885A	     equ     885Ah
M000_BCC_DATA_885E	     equ     885Eh
M000_BCC_DATA_8860	     equ     8860h
M000_BCC_DATA_8862	     equ     8862h
M000_BCC_DATA_8866	     equ     8866h
M000_BCC_DATA_8868	     equ     8868h
M000_BCC_DATA_886A	     equ     886Ah
M000_BCC_DATA_886E	     equ     886Eh
M000_BCC_DATA_8870	     equ     8870h
M000_BCC_DATA_8872	     equ     8872h
M000_BCC_DATA_8876	     equ     8876h
M000_BCC_DATA_8878	     equ     8878h
M000_BCC_DATA_887A	     equ     887Ah
M000_BCC_DATA_887E	     equ     887Eh
M000_BCC_DATA_8880	     equ     8880h
M000_BCC_DATA_8882	     equ     8882h
M000_BCC_DATA_8886	     equ     8886h
M000_BCC_DATA_8888	     equ     8888h
M000_BCC_DATA_888A	     equ     888Ah
M000_BCC_DATA_888E	     equ     888Eh
M000_BCC_DATA_8890	     equ     8890h
M000_BCC_DATA_8892	     equ     8892h
M000_BCC_DATA_8896	     equ     8896h
M000_BCC_DATA_8898	     equ     8898h
M000_BCC_DATA_889A	     equ     889Ah

   	     public  X053_00
X053_00 label   far
BCC_FAR_D870    proc    far
   	     push    BP
   	     mov     BP,SP
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_883E,AX
   	     mov     DGROUP:M000_BCC_DATA_8840,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8842,0
   	     push    DS
   	     mov     AX,883Ch
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     AX,2
   	     mov     DGROUP:M000_BCC_DATA_8846,AX
   	     mov     DGROUP:M000_BCC_DATA_8848,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_884A,0
   	     push    DS
   	     mov     AX,8844h
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     AX,2
   	     mov     DGROUP:M000_BCC_DATA_885E,AX
   	     mov     DGROUP:M000_BCC_DATA_8860,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8862,0
   	     push    DS
   	     mov     AX,885Ch
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     AX,2
   	     mov     DGROUP:M000_BCC_DATA_8886,AX
   	     mov     DGROUP:M000_BCC_DATA_8888,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_888A,0
   	     push    DS
   	     mov     AX,8884h
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     AX,2
   	     mov     DGROUP:M000_BCC_DATA_882E,AX
   	     mov     DGROUP:M000_BCC_DATA_8830,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8832,0
   	     push    DS
   	     mov     AX,882Ch
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     AX,2
   	     mov     DGROUP:M000_BCC_DATA_8836,AX
   	     mov     DGROUP:M000_BCC_DATA_8838,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_883A,0
   	     push    DS
   	     mov     AX,8834h
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_886E,AX
   	     mov     DGROUP:M000_BCC_DATA_8870,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8872,0
   	     push    DS
   	     mov     AX,886Ch
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_888E,AX
   	     mov     DGROUP:M000_BCC_DATA_8890,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8892,0
   	     push    DS
   	     mov     AX,888Ch
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_8866,AX
   	     mov     DGROUP:M000_BCC_DATA_8868,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_886A,0
   	     push    DS
   	     mov     AX,8864h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_8876,AX
   	     mov     DGROUP:M000_BCC_DATA_8878,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_887A,0
   	     push    DS
   	     mov     AX,8874h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_887E,AX
   	     mov     DGROUP:M000_BCC_DATA_8880,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8882,0
   	     push    DS
   	     mov     AX,887Ch
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_8856,AX
   	     mov     DGROUP:M000_BCC_DATA_8858,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_885A,0
   	     push    DS
   	     mov     AX,8854h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_87C6,AX
   	     mov     DGROUP:M000_BCC_DATA_87C8,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_87CA,0
   	     push    DS
   	     mov     AX,87C4h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     AX,2
   	     mov     DGROUP:M000_BCC_DATA_8896,AX
   	     mov     DGROUP:M000_BCC_DATA_8898,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_889A,0
   	     push    DS
   	     mov     AX,8894h
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     xor     AX,AX
   	     mov     DGROUP:M000_BCC_DATA_884E,AX
   	     mov     DGROUP:M000_BCC_DATA_8850,AX
   	     mov     word ptr DGROUP:M000_BCC_DATA_8852,0
   	     push    DS
   	     mov     AX,884Ch
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_245C
   	     dw	     seg BCC_FAR_245C
   	     mov     word ptr DGROUP:M000_BCC_DATA_86CC,18h
   	     push    DS
   	     mov     AX,889Eh
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,1Ch
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_AF23
   	     dw	     seg BCC_FAR_AF23
   	     mov     AX,DGROUP:M000_BCC_DATA_174E
   	     or	     AX,word ptr DGROUP:M000_BCC_DATA_1750
   	     je	     short M000_L_DA48
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1714,0
   	     je	     short M000_L_DA42
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1715,0
   	     jne     short M000_L_DA48
M000_L_DA42:
   	     db	     081h,00Eh,0D2h,086h,001h,000h
M000_L_DA48:
   	     cmp     byte ptr DGROUP:M000_BCC_DATA_1714,0
   	     je	     short M000_L_DA5C
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X076_04
   	     dw	     seg X076_04
   	     jmp     short M000_L_DA67
M000_L_DA5C:
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X054_01
   	     dw	     seg X054_01
M000_L_DA67:
   	     pop     BP
   	     retf    4
BCC_FAR_D870    endp
CO053_TEXT	     ends

; END STOVR141
   	     end
