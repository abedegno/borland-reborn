   	     public  X054_02
   	     public  X054_03
   	     public  X054_00
   	     public  X054_01
   	     public  X054_06
   	     public  X054_07
   	     public  X054_04
   	     public  X054_05
   	     public  X054_08
   	     public  X054_09
   	     public  X054_0B
   	     public  X054_0C
   	     public  X054_0A
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d3a_9da7
; BEGIN STOVR142 (listing ovr_1d3a_9da7:DA70)

   	     extrn   X043_03:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M000_BCC_DATA_883C	     equ     883Ch
M000_BCC_DATA_883E	     equ     883Eh
M000_BCC_DATA_8840	     equ     8840h
M000_BCC_DATA_8894	     equ     8894h
M000_BCC_DATA_88A2	     equ     88A2h

   	     public  X054_02
X054_02 label   far
BCC_NEAR_DA70   label   near
BCC_FAR_DA70    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,DGROUP:M000_BCC_DATA_8840
   	     cmp     AX,word ptr DGROUP:M000_BCC_DATA_883E
   	     jc	     short M000_L_DA98
   	     push    DS
   	     mov     AX,883Ch
   	     push    AX
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_883C
   	     mov     DL,byte ptr [BP+6]
   	     mov     BX,AX
   	     mov     byte ptr ES:[BX],DL
   	     jmp     short M000_L_DAAA
M000_L_DA98:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_883C
   	     mov     BX,word ptr DGROUP:M000_BCC_DATA_8840
   	     mov     AL,byte ptr [BP+6]
   	     mov     byte ptr ES:[BX],AL
   	     inc     word ptr DGROUP:M000_BCC_DATA_8840
M000_L_DAAA:
   	     mov     BX,word ptr DGROUP:M000_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8894
   	     add     word ptr ES:[BX+0Ch],1
   	     adc     word ptr ES:[BX+0Eh],0
   	     pop     BP
   	     retf    2
BCC_FAR_DA70    endp
CO054_TEXT	     ends

; END STOVR142
; BEGIN STOVR143 (listing ovr_1d3a_9da7:DAC0)

   	     extrn   X043_03:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M001_BCC_DATA_883C	     equ     883Ch
M001_BCC_DATA_883E	     equ     883Eh
M001_BCC_DATA_8840	     equ     8840h
M001_BCC_DATA_8894	     equ     8894h
M001_BCC_DATA_88A2	     equ     88A2h

   	     public  X054_0A
X054_0A label   far
BCC_NEAR_DAC0   label   near
BCC_FAR_DAC0    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     mov     AX,DGROUP:M001_BCC_DATA_8840
   	     inc     AX
   	     cmp     AX,word ptr DGROUP:M001_BCC_DATA_883E
   	     jc	     short M001_L_DAEA
   	     push    DS
   	     mov     AX,883Ch
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_883C
   	     mov     BX,AX
   	     mov     word ptr ES:[BX],SI
   	     jmp     short M001_L_DAFA
M001_L_DAEA:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_883C
   	     mov     BX,word ptr DGROUP:M001_BCC_DATA_8840
   	     mov     word ptr ES:[BX],SI
   	     add     word ptr DGROUP:M001_BCC_DATA_8840,2
M001_L_DAFA:
   	     mov     BX,word ptr DGROUP:M001_BCC_DATA_88A2
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8894
   	     add     word ptr ES:[BX+0Ch],2
   	     adc     word ptr ES:[BX+0Eh],0
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_DAC0    endp
CO054_TEXT	     ends

; END STOVR143
; BEGIN STOVR144 (listing ovr_1d3a_9da7:DB11)

CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP



BCC_NEAR_DB11   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,byte ptr [BP+4]
   	     cbw
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+54CEh]
   	     cbw
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_DB11   endp
CO054_TEXT	     ends

; END STOVR144
; BEGIN STOVR145 (listing ovr_1d3a_9da7:DB25)


   	     extrn   X05D_09:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

   	     public  X054_01
X054_01 label   far
BCC_FAR_DB25    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X05D_09
   	     dw	     seg X05D_09
   	     pop     BP
   	     retf    2
BCC_FAR_DB25    endp
CO054_TEXT	     ends

; END STOVR145
; BEGIN STOVR146 (listing ovr_1d3a_9da7:DB34)


   	     extrn   X05D_02:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

   	     public  X054_06
X054_06 label   far
BCC_FAR_DB34    proc    far
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
BCC_FAR_DB34    endp
CO054_TEXT	     ends

; END STOVR146
; BEGIN STOVR147 (listing ovr_1d3a_9da7:DB49)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

BCC_NEAR_DB49   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,1
   	     push    AX
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     0003Bh
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_DB49   endp
CO054_TEXT	     ends

; END STOVR147
; BEGIN STOVR148 (listing ovr_1d3a_9da7:DB5B)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

BCC_NEAR_DB5B   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,7
   	     push    AX
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     00029h
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_DB5B   endp
CO054_TEXT	     ends

; END STOVR148
; BEGIN STOVR149 (listing ovr_1d3a_9da7:DB6D)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

BCC_NEAR_DB6D   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,6
   	     push    AX
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     00017h
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_DB6D   endp
CO054_TEXT	     ends

; END STOVR149
; BEGIN STOVR150 (listing ovr_1d3a_9da7:DB7F)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

BCC_NEAR_DB7F   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,3
   	     push    AX
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     00005h
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_DB7F   endp
CO054_TEXT	     ends

; END STOVR150
; BEGIN STOVR151 (listing ovr_1d3a_9da7:DB91)


   	     extrn   X05D_03:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

BCC_NEAR_DB91   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,byte ptr [BP+6]
   	     cbw
   	     push    AX
   	     push    word ptr [BP+4]
   	     db	     09Ah
   	     dw	     X05D_03
   	     dw	     seg X05D_03
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_DB91   endp
CO054_TEXT	     ends

; END STOVR151
; BEGIN STOVR152 (listing ovr_1d3a_9da7:DBA7)


   	     extrn   X056_00:far
   	     extrn   X056_03:far
   	     extrn   X056_09:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

   	     public  X054_05
X054_05 label   far
BCC_FAR_DBA7    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ch]
   	     mov     DI,word ptr [BP+8]
   	     mov     AL,8Bh
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AL,0DCh
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AL,36h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     cmp     word ptr [BP+0Ah],7Fh
   	     jg	     short M00A_L_DBD6
   	     cmp     word ptr [BP+0Ah],-80h
   	     jge     short M00A_L_DBDA
M00A_L_DBD6:
   	     mov     AL,81h
   	     jmp     short M00A_L_DBDC
M00A_L_DBDA:
   	     mov     AL,83h
M00A_L_DBDC:
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     or	     DI,DI
   	     je	     short M00A_L_DBEB
   	     mov     AX,4
   	     jmp     short M00A_L_DBEE
M00A_L_DBEB:
   	     mov     AX,2
M00A_L_DBEE:
   	     add     word ptr [BP+6],AX
   	     cmp     word ptr [BP+6],7Fh
   	     jle     short M00A_L_DC11
   	     mov     AL,87h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AX,word ptr [BP+6]
   	     mov     CL,8
   	     sar     AX,CL
   	     jmp     short M00A_L_DC1C
M00A_L_DC11:
   	     mov     AL,47h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AL,byte ptr [BP+6]
M00A_L_DC1C:
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     cmp     word ptr [BP+0Ah],7Fh
   	     jg	     short M00A_L_DC2E
   	     cmp     word ptr [BP+0Ah],-80h
   	     jge     short M00A_L_DC40
M00A_L_DC2E:
   	     mov     AL,byte ptr [BP+0Ah]
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AX,word ptr [BP+0Ah]
   	     mov     CL,8
   	     sar     AX,CL
   	     jmp     short M00A_L_DC43
M00A_L_DC40:
   	     mov     AL,byte ptr [BP+0Ah]
M00A_L_DC43:
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     or	     DI,DI
   	     je	     short M00A_L_DC60
   	     mov     AL,0EAh
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_09
   	     dw	     seg X056_09
   	     jmp     short M00A_L_DC82
M00A_L_DC60:
   	     mov     AL,0E9h
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AX,6
   	     push    AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X056_00
   	     dw	     seg X056_00
   	     mov     AL,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
   	     mov     AL,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X056_03
   	     dw	     seg X056_03
M00A_L_DC82:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    8
BCC_FAR_DBA7    endp
CO054_TEXT	     ends

; END STOVR152
; BEGIN STOVR153 (listing ovr_1d3a_9da7:DC88)

   	     extrn   BCC_FAR_0402:far
   	     extrn   BCC_FAR_5B44:far
   	     extrn   BCC_FAR_5E22:far
   	     extrn   BCC_FAR_B072:far
   	     extrn   BCC_FAR_B146:far
   	     extrn   X055_0C:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M00B_BCC_DATA_7846	     equ     7846h
M00B_BCC_DATA_8646	     equ     8646h
M00B_BCC_DATA_86D2	     equ     86D2h

   	     public  X054_03
X054_03 label   far
BCC_FAR_DC88    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,50h
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     push    word ptr DGROUP:M00B_BCC_DATA_7846
   	     push    word ptr DGROUP:M00B_BCC_DATA_8646
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     mov     AX,87CCh
   	     push    DS
   	     push    AX
   	     mov     AX,546Eh
   	     push    DS
   	     push    AX
   	     mov     CX,60h
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     test    word ptr DGROUP:M00B_BCC_DATA_86D2,1
   	     jne     short M00B_L_DCC9
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     push    DS
   	     mov     AX,54DAh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B146
   	     dw	     seg BCC_FAR_B146
M00B_L_DCC9:
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5E22
   	     dw	     seg BCC_FAR_5E22
   	     cmp     AX,0FFFFh
   	     jne     short M00B_L_DCE9
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     mov     AX,5
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     add     SP,6
M00B_L_DCE9:
   	     push    word ptr DGROUP:M00B_BCC_DATA_7846
   	     push    word ptr DGROUP:M00B_BCC_DATA_8646
   	     push    SS
   	     lea     AX,[BP-50h]
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B072
   	     dw	     seg BCC_FAR_B072
   	     push    word ptr [BP+8]
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X055_0C
   	     dw	     seg X055_0C
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
BCC_FAR_DC88    endp
CO054_TEXT	     ends

; END STOVR153
; BEGIN STOVR154 (listing ovr_1d3a_9da7:DD0C)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

   	     public  X054_00
X054_00 label   far
BCC_FAR_DD0C    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,2Eh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD5Ah
   	     mov     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD53h
   	     mov     AL,0A7h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD4Ch
   	     mov     AL,5
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     0FE64h
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD8Ch
   	     pop     BP
   	     retf    2
BCC_FAR_DD0C    endp
CO054_TEXT	     ends

; END STOVR154
; BEGIN STOVR155 (listing ovr_1d3a_9da7:DD38)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

   	     public  X054_07
X054_07 label   far
BCC_FAR_DD38    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,0BBh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD2Eh
   	     mov     AL,5
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     0FE46h
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD6Eh
   	     pop     BP
   	     retf    2
BCC_FAR_DD38    endp
CO054_TEXT	     ends

; END STOVR155
; BEGIN STOVR156 (listing ovr_1d3a_9da7:DD56)



CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M00E_BCC_DATA_16EF	     equ     16EFh
M00E_BCC_DATA_814C	     equ     814Ch

   	     public  X054_0B
X054_0B label   far
BCC_FAR_DD56    proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     byte ptr DGROUP:M00E_BCC_DATA_16EF,0
   	     jne     short M00E_L_DD93
   	     mov     AL,2Eh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD09h
   	     mov     AL,8Bh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD02h
   	     cmp     byte ptr [BP+6],0Ah
   	     jne     short M00E_L_DD78
   	     mov     AL,28h
   	     jmp     short M00E_L_DD7A
M00E_L_DD78:
   	     mov     AL,0
M00E_L_DD7A:
   	     add     AL,6
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FCEFh
   	     mov     AX,54DFh
   	     push    AX
   	     mov     AX,1
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     814Ch
   	     push    AX
   	     db	     0E8h
   	     dw	     0FDB8h
   	     jmp     short M00E_L_DDAD
M00E_L_DD93:
   	     cmp     byte ptr [BP+6],0Ah
   	     jne     short M00E_L_DD9D
   	     mov     AL,0BDh
   	     jmp     short M00E_L_DD9F
M00E_L_DD9D:
   	     mov     AL,0B8h
M00E_L_DD9F:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FCCCh
   	     mov     AL,0Ah
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FDE4h
M00E_L_DDAD:
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD0Ch
   	     pop     BP
   	     retf    2
BCC_FAR_DD56    endp
CO054_TEXT	     ends

; END STOVR156
; BEGIN STOVR157 (listing ovr_1d3a_9da7:DDB8)

   	     extrn   X065_03:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M00F_BCC_DATA_16F0	     equ     16F0h

   	     public  X054_04
X054_04 label   far
BCC_FAR_DDB8    proc    far
   	     push    BP
   	     mov     BP,SP
   	     cmp     byte ptr DGROUP:M00F_BCC_DATA_16F0,0
   	     jne     short M00F_L_DDE8
   	     mov     AL,0B9h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FCA7h
   	     mov     AL,10h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FDBFh
   	     mov     AX,6
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FCE6h
   	     mov     AX,94h
   	     push    AX
   	     mov     AL,6
   	     push    AX
   	     db	     09Ah
   	     dw	     X065_03
   	     dw	     seg X065_03
   	     jmp     short M00F_L_DE00
M00F_L_DDE8:
   	     mov     AL,68h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC81h
   	     mov     AL,10h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FD99h
   	     mov     AX,5
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FCC0h
M00F_L_DE00:
   	     pop     BP
   	     retf
BCC_FAR_DDB8    endp
CO054_TEXT	     ends

; END STOVR157
; BEGIN STOVR158 (listing ovr_1d3a_9da7:DE02)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

   	     public  X054_09
X054_09 label   far
BCC_FAR_DE02    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,2Eh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC64h
   	     mov     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC5Dh
   	     cmp     word ptr [BP+6],80h
   	     jge     short M010_L_DE2B
   	     mov     AL,67h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC4Fh
   	     mov     AL,byte ptr [BP+6]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC47h
   	     jmp     short M010_L_DE39
M010_L_DE2B:
   	     mov     AL,0A7h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC3Eh
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC87h
M010_L_DE39:
   	     pop     BP
   	     retf    2
BCC_FAR_DE02    endp
CO054_TEXT	     ends

; END STOVR158
; BEGIN STOVR159 (listing ovr_1d3a_9da7:DE3D)



CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M011_BCC_DATA_814C	     equ     814Ch

   	     public  X054_08
X054_08 label   far
BCC_NEAR_DE3D   label   near
BCC_FAR_DE3D    proc    far
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,0Bh
   	     push    AX
   	     push    word ptr [BP+6]
   	     mov     AX,1
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     814Ch
   	     push    AX
   	     db	     0E8h
   	     dw	     0FD3Fh
   	     pop     BP
   	     retf    2
BCC_FAR_DE3D    endp
CO054_TEXT	     ends

; END STOVR159
; BEGIN STOVR160 (listing ovr_1d3a_9da7:DE56)

   	     extrn   BCC_FAR_0402:far
   	     extrn   X056_07:far
   	     extrn   X056_09:far


CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M012_BCC_DATA_16EF	     equ     16EFh
M012_BCC_DATA_8134	     equ     8134h
M012_BCC_DATA_8150	     equ     8150h
M012_BCC_DATA_86D6	     equ     86D6h
M012_BCC_DATA_8B28	     equ     8B28h
M012_BCC_DATA_8B2B	     equ     8B2Bh
M012_BCC_DATA_8B2C	     equ     8B2Ch
M012_BCC_DATA_8B2D	     equ     8B2Dh
M012_BCC_DATA_8B2F	     equ     8B2Fh
M012_BCC_DATA_8B31	     equ     8B31h
M012_BCC_DATA_8B34	     equ     8B34h
M012_BCC_DATA_8B35	     equ     8B35h
M012_BCC_DATA_8B36	     equ     8B36h

   	     public  X054_0C
X054_0C label   far
BCC_FAR_DE56    proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,8
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     AX,DI
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     SI,AX
   	     mov     AX,8B28h
   	     push    AX
   	     db	     0E8h
   	     dw	     00A53h
   	     mov     byte ptr [BP-7],AL
   	     cmp     byte ptr [BP-7],0FFh
   	     jne     short M012_L_DE87
   	     mov     AX,8B31h
   	     push    AX
   	     db	     0E8h
   	     dw	     00A43h
   	     mov     byte ptr [BP-7],AL
M012_L_DE87:
   	     mov     AX,word ptr [SI+3]
   	     and     AX,2
   	     or	     AX,0
   	     jne     short M012_L_DEB4
   	     cmp     byte ptr [BP-7],0FFh
   	     je	     short M012_L_DEA6
   	     mov     AL,byte ptr [BP-7]
   	     push    AX
   	     db	     0E8h
   	     dw	     00A42h
   	     add     AL,26h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBCAh
M012_L_DEA6:
   	     cmp     word ptr [SI+0Dh],0
   	     je	     short M012_L_DEB4
   	     mov     AL,byte ptr [SI+0Dh]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBBCh
M012_L_DEB4:
   	     mov     BX,DI
   	     cmp     BX,0D5h
   	     jbe     short M012_L_DEBF
   	     db	     0E9h
   	     dw	     0084Ch
M012_L_DEBF:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0CABh
   	     mov     AL,90h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FBA3h
   	     db	     0E9h
   	     dw	     0083Bh
   	     mov     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     00B20h
   	     db	     0E9h
   	     dw	     00831h
   	     push    word ptr DGROUP:M012_BCC_DATA_8B2F
   	     push    word ptr DGROUP:M012_BCC_DATA_8B2D
   	     db	     09Ah
   	     dw	     X056_07
   	     dw	     seg X056_07
   	     db	     0E9h
   	     dw	     00821h
   	     push    word ptr DGROUP:M012_BCC_DATA_8B2F
   	     push    word ptr DGROUP:M012_BCC_DATA_8B2D
   	     db	     09Ah
   	     dw	     X056_09
   	     dw	     seg X056_09
   	     db	     0E9h
   	     dw	     00811h
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2D
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB6Eh
   	     db	     0E9h
   	     dw	     00806h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B2D,3
   	     jne     short M012_L_DF16
   	     mov     AL,0CCh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB5Dh
   	     db	     0E9h
   	     dw	     007F5h
M012_L_DF16:
   	     mov     AL,0CDh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB53h
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2D
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB4Bh
   	     db	     0E9h
   	     dw	     007E3h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,4
   	     jne     short M012_L_DF4A
   	     cmp     DI,70h
   	     jne     short M012_L_DF38
   	     mov     AL,0E4h
   	     jmp     short M012_L_DF3A
M012_L_DF38:
   	     mov     AL,0E5h
M012_L_DF3A:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB31h
   	     mov     AL,DGROUP:M012_BCC_DATA_8B36
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB29h
   	     db	     0E9h
   	     dw	     007C1h
M012_L_DF4A:
   	     cmp     DI,70h
   	     jne     short M012_L_DF53
   	     mov     AL,0ECh
   	     jmp     short M012_L_DF55
M012_L_DF53:
   	     mov     AL,0EDh
M012_L_DF55:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FB16h
   	     db	     0E9h
   	     dw	     007AEh
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     je	     short M012_L_DF7F
   	     cmp     DI,6Eh
   	     jne     short M012_L_DF6D
   	     mov     AL,0E6h
   	     jmp     short M012_L_DF6F
M012_L_DF6D:
   	     mov     AL,0E7h
M012_L_DF6F:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FAFCh
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2D
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FAF4h
   	     db	     0E9h
   	     dw	     0078Ch
M012_L_DF7F:
   	     cmp     DI,6Eh
   	     jne     short M012_L_DF88
   	     mov     AL,0EEh
   	     jmp     short M012_L_DF8A
M012_L_DF88:
   	     mov     AL,0EFh
M012_L_DF8A:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FAE1h
   	     db	     0E9h
   	     dw	     00779h
   	     mov     AL,byte ptr [BP-7]
   	     cbw
   	     sub     AX,0Ch
   	     mov     BX,AX
   	     cmp     BX,3
   	     ja	     short M012_L_E00B
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0CA3h
   	     mov     AX,54E7h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE8Eh
   	     mov     AL,9Bh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FABAh
   	     mov     AX,54EEh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE7Fh
   	     mov     AL,3Eh
   	     jmp     short M012_L_E015
   	     mov     AX,54F5h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE73h
   	     mov     AL,9Bh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA9Fh
   	     mov     AL,26h
   	     jmp     short M012_L_E015
   	     mov     AX,54FCh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE60h
   	     mov     AL,9Bh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA8Ch
   	     mov     AX,5503h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE51h
   	     mov     AL,36h
   	     jmp     short M012_L_E015
   	     mov     AX,550Ah
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE45h
   	     mov     AL,9Bh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA71h
   	     mov     AX,5511h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE36h
   	     mov     AL,2Eh
   	     jmp     short M012_L_E015
M012_L_E00B:
   	     mov     AX,5518h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE2Ah
   	     mov     AL,9Bh
M012_L_E015:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA56h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,0
   	     jne     short M012_L_E02B
   	     push    word ptr [SI+0Dh]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA98h
   	     db	     0E9h
   	     dw	     006E0h
M012_L_E02B:
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E067
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,1
   	     jne     short M012_L_E052
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     cbw
   	     mov     CL,8
   	     shl     AX,CL
   	     mov     DX,word ptr [SI+0Dh]
   	     sub     DX,100h
   	     add     DX,AX
   	     push    DX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA71h
   	     db	     0E9h
   	     dw	     006B9h
M012_L_E052:
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     cbw
   	     mov     CL,8
   	     shl     AX,CL
   	     mov     DX,word ptr [SI+0Fh]
   	     add     DX,AX
   	     push    DX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA5Ch
   	     db	     0E9h
   	     dw	     006A4h
M012_L_E067:
   	     mov     AL,byte ptr [SI+11h]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA01h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,word ptr [SI+11h]
   	     mov     CL,8
   	     shr     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     009E3h
   	     db	     0E9h
   	     dw	     0068Ah
   	     mov     AX,551Fh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FDB4h
   	     mov     AX,9B90h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA2Fh
   	     db	     0E9h
   	     dw	     00677h
   	     push    word ptr DGROUP:M012_BCC_DATA_8B36
   	     push    CS
   	     db	     0E8h
   	     dw	     0FA24h
   	     mov     AL,0
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9CDh
   	     db	     0E9h
   	     dw	     00665h
   	     mov     AL,0FEh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9C3h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     db	     0E8h
   	     dw	     009A9h
   	     db	     0E9h
   	     dw	     00650h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E0D3
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0FA48h
   	     add     AL,48h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F9A0h
   	     db	     0E9h
   	     dw	     00638h
M012_L_E0D3:
   	     mov     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F996h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,8
   	     push    AX
   	     db	     0E8h
   	     dw	     0097Ch
   	     db	     0E9h
   	     dw	     00623h
   	     mov     AL,0FEh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F981h
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     00968h
   	     db	     0E9h
   	     dw	     0060Fh
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E114
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0FA07h
   	     add     AL,40h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F95Fh
   	     db	     0E9h
   	     dw	     005F7h
M012_L_E114:
   	     mov     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F955h
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0093Ch
   	     db	     0E9h
   	     dw	     005E3h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E15F
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0Ch
   	     jl	     short M012_L_E14E
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0Fh
   	     jg	     short M012_L_E14E
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0079Dh
   	     add     AL,7
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F925h
   	     db	     0E9h
   	     dw	     005BDh
M012_L_E14E:
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F9BCh
   	     add     AL,58h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F914h
   	     db	     0E9h
   	     dw	     005ACh
M012_L_E15F:
   	     mov     AL,8Fh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F90Ah
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     008F1h
   	     db	     0E9h
   	     dw	     00598h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E1AA
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0Ch
   	     jl	     short M012_L_E199
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0Fh
   	     jg	     short M012_L_E199
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     00752h
   	     add     AL,6
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8DAh
   	     db	     0E9h
   	     dw	     00572h
M012_L_E199:
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F971h
   	     add     AL,50h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8C9h
   	     db	     0E9h
   	     dw	     00561h
M012_L_E1AA:
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,4
   	     jne     short M012_L_E1E8
   	     mov     AX,DGROUP:M012_BCC_DATA_8B2D
   	     mov     word ptr [BP-4],AX
   	     cmp     word ptr [BP-4],7Fh
   	     jg	     short M012_L_E1D7
   	     cmp     word ptr [BP-4],-80h
   	     jl	     short M012_L_E1D7
   	     mov     AL,6Ah
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8A6h
   	     mov     AL,byte ptr [BP-4]
   	     and     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F89Ch
   	     db	     0E9h
   	     dw	     00534h
M012_L_E1D7:
   	     mov     AL,68h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F892h
   	     push    word ptr [BP-4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F8DBh
   	     db	     0E9h
   	     dw	     00523h
M012_L_E1E8:
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,2
   	     je	     short M012_L_E1F6
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,3
   	     jne     short M012_L_E218
M012_L_E1F6:
   	     mov     AL,68h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F873h
   	     mov     AX,8B31h
   	     push    DS
   	     push    AX
   	     mov     AX,8B28h
   	     push    DS
   	     push    AX
   	     mov     CX,9
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     007E2h
   	     db	     0E9h
   	     dw	     004F3h
M012_L_E218:
   	     mov     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F851h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,30h
   	     push    AX
   	     db	     0E8h
   	     dw	     00837h
   	     db	     0E9h
   	     dw	     004DEh
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [SI+0Fh]
   	     db	     0E8h
   	     dw	     0082Ah
   	     db	     0E9h
   	     dw	     004D1h
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [SI+0Fh]
   	     db	     0E8h
   	     dw	     0081Dh
   	     db	     0E9h
   	     dw	     004C4h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,4
   	     jne     short M012_L_E293
   	     mov     AX,DGROUP:M012_BCC_DATA_8B2D
   	     mov     word ptr [BP-4],AX
   	     cmp     word ptr [BP-4],7Fh
   	     jg	     short M012_L_E27B
   	     cmp     word ptr [BP-4],-80h
   	     jl	     short M012_L_E27B
   	     mov     AL,6Bh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F809h
   	     mov     AL,0C0h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F802h
   	     mov     AL,byte ptr [BP-4]
   	     and     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7F8h
   	     db	     0E9h
   	     dw	     00490h
M012_L_E27B:
   	     mov     AL,69h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7EEh
   	     mov     AL,0C0h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7E7h
   	     push    word ptr [BP-4]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F830h
   	     db	     0E9h
   	     dw	     00478h
M012_L_E293:
   	     mov     AL,0F7h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7D6h
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [SI+0Fh]
   	     db	     0E8h
   	     dw	     007BDh
   	     db	     0E9h
   	     dw	     00464h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,4
   	     jne     short M012_L_E2DF
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E2C5
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F855h
   	     add     AL,0B0h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7ADh
   	     jmp     short M012_L_E2D6
M012_L_E2C5:
   	     mov     AL,0C6h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F7A4h
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0078Bh
M012_L_E2D6:
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0071Bh
   	     db	     0E9h
   	     dw	     0042Ch
M012_L_E2DF:
   	     mov     word ptr [BP-4],88h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E359
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,1
   	     jne     short M012_L_E319
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0Ch
   	     jl	     short M012_L_E319
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0Fh
   	     jg	     short M012_L_E319
   	     mov     AL,8Ch
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F769h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     005CFh
   	     push    AX
   	     db	     0E8h
   	     dw	     0074Bh
   	     db	     0E9h
   	     dw	     003F2h
M012_L_E319:
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0
   	     jne     short M012_L_E343
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,1
   	     je	     short M012_L_E343
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0FFh
   	     jne     short M012_L_E343
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B34,0FFh
   	     jne     short M012_L_E343
   	     mov     AX,8B31h
   	     push    AX
   	     mov     AX,9Ah
   	     push    AX
   	     db	     0E8h
   	     dw	     00721h
   	     db	     0E9h
   	     dw	     003C8h
M012_L_E343:
   	     add     word ptr [BP-4],2
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F7C3h
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-6],AX
   	     jmp     short M012_L_E39E
M012_L_E359:
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0
   	     jne     short M012_L_E37C
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0FFh
   	     jne     short M012_L_E37C
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2B,0FFh
   	     jne     short M012_L_E37C
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,9Ch
   	     push    AX
   	     db	     0E8h
   	     dw	     006E8h
   	     db	     0E9h
   	     dw	     0038Fh
M012_L_E37C:
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     0F78Eh
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-6],AX
   	     mov     AX,8B31h
   	     push    DS
   	     push    AX
   	     mov     AX,8B28h
   	     push    DS
   	     push    AX
   	     mov     CX,9
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
M012_L_E39E:
   	     mov     AL,byte ptr [BP-4]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F6CAh
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [BP-6]
   	     db	     0E8h
   	     dw	     006B1h
   	     db	     0E9h
   	     dw	     00358h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,4
   	     je	     short M012_L_E3C8
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,2
   	     je	     short M012_L_E3C8
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,3
   	     jne     short M012_L_E401
M012_L_E3C8:
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E3E6
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F73Bh
   	     add     AX,0B8h
   	     mov     word ptr [BP-4],AX
   	     mov     AL,byte ptr [BP-4]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F68Ch
   	     jmp     short M012_L_E3F7
M012_L_E3E6:
   	     mov     AL,0C7h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F683h
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0066Ah
M012_L_E3F7:
   	     mov     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     005F9h
   	     db	     0E9h
   	     dw	     0030Ah
M012_L_E401:
   	     mov     word ptr [BP-4],89h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     je	     short M012_L_E410
   	     db	     0E9h
   	     dw	     00095h
M012_L_E410:
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0Ch
   	     jl	     short M012_L_E437
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0Fh
   	     jg	     short M012_L_E437
   	     mov     AL,8Eh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F64Bh
   	     mov     AX,8B31h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     004B1h
   	     push    AX
   	     db	     0E8h
   	     dw	     0062Dh
   	     db	     0E9h
   	     dw	     002D4h
M012_L_E437:
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,1
   	     jne     short M012_L_E465
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0Ch
   	     jl	     short M012_L_E465
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0Fh
   	     jg	     short M012_L_E465
   	     mov     AL,8Ch
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F61Dh
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     00483h
   	     push    AX
   	     db	     0E8h
   	     dw	     005FFh
   	     db	     0E9h
   	     dw	     002A6h
M012_L_E465:
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0
   	     jne     short M012_L_E48F
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,1
   	     je	     short M012_L_E48F
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0FFh
   	     jne     short M012_L_E48F
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B34,0FFh
   	     jne     short M012_L_E48F
   	     mov     AX,8B31h
   	     push    AX
   	     mov     AX,9Bh
   	     push    AX
   	     db	     0E8h
   	     dw	     005D5h
   	     db	     0E9h
   	     dw	     0027Ch
M012_L_E48F:
   	     add     word ptr [BP-4],2
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F677h
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-6],AX
   	     jmp     short M012_L_E511
M012_L_E4A5:
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0Ch
   	     jl	     short M012_L_E4CC
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0Fh
   	     jg	     short M012_L_E4CC
   	     mov     AL,8Ch
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F5B6h
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     0041Ch
   	     push    AX
   	     db	     0E8h
   	     dw	     00598h
   	     db	     0E9h
   	     dw	     0023Fh
M012_L_E4CC:
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B35,0
   	     jne     short M012_L_E4EF
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2C,0FFh
   	     jne     short M012_L_E4EF
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_8B2B,0FFh
   	     jne     short M012_L_E4EF
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AX,9Dh
   	     push    AX
   	     db	     0E8h
   	     dw	     00575h
   	     db	     0E9h
   	     dw	     0021Ch
M012_L_E4EF:
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     0F61Bh
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-6],AX
   	     mov     AX,8B31h
   	     push    DS
   	     push    AX
   	     mov     AX,8B28h
   	     push    DS
   	     push    AX
   	     mov     CX,9
   	     db	     09Ah
   	     dw	     BCC_FAR_0402
   	     dw	     seg BCC_FAR_0402
M012_L_E511:
   	     mov     AL,byte ptr [BP-4]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F557h
   	     mov     AX,8B31h
   	     push    AX
   	     push    word ptr [BP-6]
   	     db	     0E8h
   	     dw	     0053Eh
   	     db	     0E9h
   	     dw	     001E5h
   	     push    DI
   	     push    DS
   	     push    SI
   	     db	     0E8h
   	     dw	     003EEh
   	     or	     AX,AX
   	     je	     short M012_L_E533
   	     db	     0E9h
   	     dw	     001D8h
M012_L_E533:
   	     mov     AL,byte ptr [SI+0Fh]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F535h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E55A
   	     mov     AX,8B31h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F5C4h
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     0050Ah
   	     db	     0E9h
   	     dw	     001B1h
M012_L_E55A:
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     0F5ACh
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     004F2h
   	     db	     0E9h
   	     dw	     00199h
   	     push    DI
   	     push    DS
   	     push    SI
   	     db	     0E8h
   	     dw	     003A2h
   	     or	     AX,AX
   	     je	     short M012_L_E57F
   	     db	     0E9h
   	     dw	     0018Ch
M012_L_E57F:
   	     mov     AX,word ptr [SI+0Fh]
   	     mov     word ptr [BP-4],AX
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     db	     075h,022h,08Ah,046h,0FCh
   	     add     AL,2
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F4DAh
   	     mov     AX,8B31h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F570h
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     004B6h
   	     db	     0E9h
   	     dw	     0015Dh
   	     mov     AL,byte ptr [BP-4]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F4BAh
   	     mov     AX,8B28h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B35
   	     push    AX
   	     db	     0E8h
   	     dw	     0F550h
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     00496h
   	     db	     0E9h
   	     dw	     0013Dh
   	     mov     AX,8B31h
   	     push    AX
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F538h
   	     shl     AX,1
   	     shl     AX,1
   	     shl     AX,1
   	     push    AX
   	     db	     0E8h
   	     dw	     0047Eh
   	     db	     0E9h
   	     dw	     00125h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,4
   	     jne     short M012_L_E5FB
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B36,1
   	     je	     short M012_L_E5FB
   	     mov     word ptr [BP-4],0C0h
   	     jmp     short M012_L_E60B
M012_L_E5FB:
   	     mov     word ptr [BP-4],0D0h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,4
   	     je	     short M012_L_E60B
   	     add     word ptr [BP-4],2
M012_L_E60B:
   	     mov     AL,byte ptr [BP-4]
   	     add     AL,byte ptr [SI+0Fh]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F45Ah
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [SI+11h]
   	     db	     0E8h
   	     dw	     00441h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,4
   	     je	     short M012_L_E62A
   	     db	     0E9h
   	     dw	     000E1h
M012_L_E62A:
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B36,1
   	     jne     short M012_L_E634
   	     db	     0E9h
   	     dw	     000D7h
M012_L_E634:
   	     mov     AL,DGROUP:M012_BCC_DATA_8B36
   	     and     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F432h
   	     db	     0E9h
   	     dw	     000CAh
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B31,0
   	     je	     short M012_L_E65B
   	     mov     AL,byte ptr [SI+0Fh]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F420h
   	     push    word ptr DGROUP:M012_BCC_DATA_8B36
   	     push    CS
   	     db	     0E8h
   	     dw	     0F468h
   	     db	     0E9h
   	     dw	     000B0h
M012_L_E65B:
   	     mov     AL,byte ptr [SI+11h]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F40Dh
   	     db	     0E9h
   	     dw	     000A5h
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8B28,1
   	     jne     short M012_L_E67E
   	     mov     AL,DGROUP:M012_BCC_DATA_8B2C
   	     push    AX
   	     db	     0E8h
   	     dw	     0F49Dh
   	     add     AL,0D0h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F3F5h
   	     db	     0E9h
   	     dw	     0008Dh
M012_L_E67E:
   	     mov     AX,8B28h
   	     push    AX
   	     push    word ptr [SI+0Fh]
   	     db	     0E8h
   	     dw	     003D9h
   	     db	     0E9h
   	     dw	     00080h
   	     mov     AX,DGROUP:M012_BCC_DATA_8B2F
   	     mov     word ptr [BP-2],AX
   	     mov     AL,0E8h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F3D8h
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0F4CFh
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F41Bh
   	     jmp     short M012_L_E70B
   	     mov     AX,DGROUP:M012_BCC_DATA_8B2F
   	     mov     word ptr [BP-2],AX
   	     cmp     byte ptr DGROUP:M012_BCC_DATA_16EF,0
   	     je	     short M012_L_E6F0
   	     cmp     word ptr [BP-2],0
   	     je	     short M012_L_E6D3
   	     push    word ptr [BP-2]
   	     db	     0FFh,01Eh
   	     dw	     8150h
   	     cmp     AX,2
   	     je	     short M012_L_E6D3
   	     push    word ptr [BP-2]
   	     db	     0FFh,01Eh
   	     dw	     8134h
   	     cmp     AX,word ptr DGROUP:M012_BCC_DATA_86D6
   	     je	     short M012_L_E6F0
M012_L_E6D3:
   	     mov     AL,9Ah
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F396h
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0F47Bh
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F3D9h
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F3D2h
   	     jmp     short M012_L_E70B
M012_L_E6F0:
   	     mov     AL,0Eh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F379h
   	     mov     AL,0E8h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F372h
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0F469h
   	     xor     AX,AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F3B5h
M012_L_E70B:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
BCC_FAR_DE56    endp
CO054_TEXT	     ends

; END STOVR160
; BEGIN STOVT161 (listing ovr_1d3a_9da7:E713)
CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT

BCC_TABLE_E713  label   word
   	     dw	     00552h
   	     dw	     00537h
   	     dw	     00580h
   	     dw	     00565h
   	     dw	     00456h
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     007CAh
   	     dw	     007D7h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     007CAh
   	     dw	     007CAh
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     007CAh
   	     dw	     007CAh
   	     dw	     007CAh
   	     dw	     007CAh
   	     dw	     007CAh
   	     dw	     007CAh
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     007BDh
   	     dw	     007BDh
   	     dw	     00522h
   	     dw	     007BDh
   	     dw	     007BDh
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00611h
   	     dw	     00678h
   	     dw	     0068Ch
   	     dw	     00636h
   	     dw	     0064Bh
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00C9Bh
   	     dw	     004EDh
   	     dw	     004EDh
   	     dw	     004B8h
   	     dw	     004B8h
   	     dw	     00495h
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00BF6h
   	     dw	     00BF6h
   	     dw	     00C1Bh
   	     dw	     00C37h
   	     dw	     00C9Bh
   	     dw	     0048Ah
   	     dw	     00460h
   	     dw	     00460h
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     006B8h
   	     dw	     00B02h
   	     dw	     00B02h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00AB6h
   	     dw	     00AB6h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00522h
   	     dw	     00624h
   	     dw	     00C9Bh
   	     dw	     00703h
   	     dw	     00B5Eh
   	     dw	     00B5Eh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00B02h
   	     dw	     00837h
   	     dw	     00943h
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00BD1h
   	     dw	     00BD1h
   	     dw	     00C9Bh
   	     dw	     0046Ah
   	     dw	     0047Ah
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00C9Bh
   	     dw	     00B76h
   	     dw	     00B76h
   	     dw	     00522h

CO054_TEXT	     ends
; END STOVT161
; BEGIN STOVR162 (listing ovr_1d3a_9da7:E8C7)

CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP



BCC_NEAR_E8C7   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     cmp     word ptr [SI],5
   	     jne     short M014_L_E8D9
   	     mov     AL,byte ptr [SI+2]
   	     jmp     short M014_L_E8DB
M014_L_E8D9:
   	     mov     AL,0FFh
M014_L_E8DB:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_E8C7   endp
CO054_TEXT	     ends

; END STOVR162
; BEGIN STOVR163 (listing ovr_1d3a_9da7:E8E1)

CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP



BCC_NEAR_E8E1   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AL,byte ptr [BP+4]
   	     cbw
   	     sub     AX,0Ch
   	     mov     BX,AX
   	     cmp     BX,3
   	     ja	     short M015_L_E90A
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0EA2h
   	     xor     AX,AX
   	     jmp     short M015_L_E90D
   	     mov     AX,10h
   	     jmp     short M015_L_E90D
   	     mov     AX,18h
   	     jmp     short M015_L_E90D
   	     jmp     short M015_L_E90A
M015_L_E90A:
   	     mov     AX,8
M015_L_E90D:
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_E8E1   endp
CO054_TEXT	     ends

; END STOVR163
; BEGIN STOVT164 (listing ovr_1d3a_9da7:E912)
CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT

BCC_TABLE_E912  label   word
   	     dw	     00E8Ah
   	     dw	     00E93h
   	     dw	     00E98h
   	     dw	     00E8Eh

CO054_TEXT	     ends
; END STOVT164
; BEGIN STOVR165 (listing ovr_1d3a_9da7:E91A)



CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M017_BCC_DATA_8B28	     equ     8B28h
M017_BCC_DATA_8B2C	     equ     8B2Ch
M017_BCC_DATA_8B31	     equ     8B31h
M017_BCC_DATA_8B36	     equ     8B36h

BCC_NEAR_E91A   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     mov     AX,DGROUP:M017_BCC_DATA_8B31
   	     cmp     AX,2
   	     je	     short M017_L_E935
   	     cmp     AX,3
   	     je	     short M017_L_E935
   	     cmp     AX,4
   	     je	     short M017_L_E935
   	     db	     0E9h
   	     dw	     000B9h
M017_L_E935:
   	     cmp     word ptr DGROUP:M017_BCC_DATA_8B28,1
   	     jne     short M017_L_E965
   	     cmp     byte ptr DGROUP:M017_BCC_DATA_8B2C,0
   	     je	     short M017_L_E94A
   	     cmp     byte ptr DGROUP:M017_BCC_DATA_8B2C,0
   	     jne     short M017_L_E965
M017_L_E94A:
   	     les     BX,[BP+4]
   	     mov     AL,byte ptr ES:[BX+11h]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F11Ah
   	     les     BX,[BP+4]
   	     mov     AX,word ptr ES:[BX+0Fh]
   	     and     AX,1
   	     mov     word ptr [BP-2],AX
   	     jmp     short M017_L_E9E3
M017_L_E965:
   	     mov     AX,DGROUP:M017_BCC_DATA_8B36
   	     and     AX,0FF80h
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr DGROUP:M017_BCC_DATA_8B31,4
   	     jne     short M017_L_E997
   	     les     BX,[BP+4]
   	     mov     AX,word ptr ES:[BX+3]
   	     and     AX,8000h
   	     or	     AX,0
   	     je	     short M017_L_E997
   	     cmp     word ptr [BP-2],0
   	     db	     074h,006h
   	     cmp     word ptr [BP-2],-80h
   	     jne     short M017_L_E997
   	     mov     word ptr [BP-2],2
   	     jmp     short M017_L_E99C
M017_L_E997:
   	     mov     word ptr [BP-2],0
M017_L_E99C:
   	     les     BX,[BP+4]
   	     mov     AX,word ptr ES:[BX+0Fh]
   	     and     AX,1
   	     mov     DX,word ptr [BP-2]
   	     add     DX,AX
   	     mov     word ptr [BP-2],DX
   	     cmp     word ptr [BP+8],85h
   	     jl	     short M017_L_E9C7
   	     mov     AL,byte ptr [BP-2]
   	     add     AL,0F6h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F0B1h
   	     mov     AX,8B28h
   	     push    AX
   	     xor     AX,AX
   	     jmp     short M017_L_E9DF
M017_L_E9C7:
   	     mov     AL,byte ptr [BP-2]
   	     add     AL,80h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F09Fh
   	     mov     AX,8B28h
   	     push    AX
   	     les     BX,[BP+4]
   	     mov     AX,word ptr ES:[BX+0Fh]
   	     and     AX,0FFFEh
M017_L_E9DF:
   	     push    AX
   	     db	     0E8h
   	     dw	     0007Eh
M017_L_E9E3:
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     0000Eh
   	     mov     AX,1
   	     jmp     short M017_L_E9F0
M017_L_E9EE:
   	     xor     AX,AX
M017_L_E9F0:
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     6
BCC_NEAR_E91A   endp
CO054_TEXT	     ends

; END STOVR165
; BEGIN STOVR166 (listing ovr_1d3a_9da7:E9F7)



CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

M018_BCC_DATA_8B31	     equ     8B31h
M018_BCC_DATA_8B36	     equ     8B36h
M018_BCC_DATA_8B38	     equ     8B38h

BCC_NEAR_E9F7   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     mov     AX,DGROUP:M018_BCC_DATA_8B31
   	     cmp     AX,2
   	     je	     short M018_L_EA2D
   	     cmp     AX,4
   	     je	     short M018_L_EA0F
   	     cmp     AX,5
   	     je	     short M018_L_EA3A
   	     jmp     short M018_L_EA4E
M018_L_EA0F:
   	     mov     AL,DGROUP:M018_BCC_DATA_8B36
   	     and     AL,0FFh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F057h
   	     cmp     word ptr [BP+4],1
   	     jne     short M018_L_EA5C
   	     mov     AX,DGROUP:M018_BCC_DATA_8B36
   	     mov     CL,8
   	     sar     AX,CL
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F045h
   	     jmp     short M018_L_EA5C
M018_L_EA2D:
   	     push    word ptr DGROUP:M018_BCC_DATA_8B38
   	     db	     0E8h
   	     dw	     0F115h
   	     push    word ptr DGROUP:M018_BCC_DATA_8B36
   	     jmp     short M018_L_EA58
M018_L_EA3A:
   	     cmp     word ptr DGROUP:M018_BCC_DATA_8B38,0
   	     je	     short M018_L_EA48
   	     push    word ptr DGROUP:M018_BCC_DATA_8B38
   	     db	     0E8h
   	     dw	     0F101h
M018_L_EA48:
   	     push    word ptr DGROUP:M018_BCC_DATA_8B36
   	     jmp     short M018_L_EA58
M018_L_EA4E:
   	     push    word ptr DGROUP:M018_BCC_DATA_8B38
   	     db	     0E8h
   	     dw	     0F12Ah
   	     xor     AX,AX
   	     push    AX
M018_L_EA58:
   	     push    CS
   	     db	     0E8h
   	     dw	     0F064h
M018_L_EA5C:
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_E9F7   endp
CO054_TEXT	     ends

; END STOVR166
; BEGIN STOVR167 (listing ovr_1d3a_9da7:EA61)




CO054_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO054_TEXT,ds:DGROUP

BCC_NEAR_EA61   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     cmp     word ptr [SI],1
   	     jne     short M019_L_EA7E
   	     mov     AL,byte ptr [SI+4]
   	     push    AX
   	     db	     0E8h
   	     dw	     0F09Bh
   	     add     AL,byte ptr [BP+4]
   	     add     AL,0C0h
   	     db	     0E9h
   	     dw	     000AAh
M019_L_EA7E:
   	     cmp     byte ptr [SI+4],0FFh
   	     jne     short M019_L_EA93
   	     cmp     byte ptr [SI+3],0FFh
   	     jne     short M019_L_EA93
   	     add     word ptr [BP+4],6
   	     mov     DI,80h
   	     jmp     short M019_L_EAFD
M019_L_EA93:
   	     cmp     word ptr [SI+7],0
   	     jne     short M019_L_EAA5
   	     cmp     word ptr [SI+5],7Fh
   	     jg	     short M019_L_EAA5
   	     cmp     word ptr [SI+5],-80h
   	     jge     short M019_L_EAAA
M019_L_EAA5:
   	     mov     DI,80h
   	     jmp     short M019_L_EAC8
M019_L_EAAA:
   	     cmp     word ptr [SI+5],0
   	     je	     short M019_L_EAB5
   	     mov     DI,40h
   	     jmp     short M019_L_EAC8
M019_L_EAB5:
   	     cmp     byte ptr [SI+4],0Ah
   	     jne     short M019_L_EAC6
   	     cmp     byte ptr [SI+3],0FFh
   	     jne     short M019_L_EAC6
   	     mov     DI,40h
   	     jmp     short M019_L_EAC8
M019_L_EAC6:
   	     xor     DI,DI
M019_L_EAC8:
   	     or	     word ptr [BP+4],DI
   	     cmp     byte ptr [SI+3],9
   	     jne     short M019_L_EAD6
   	     db	     081h,04Eh,004h
   	     dw	     1
M019_L_EAD6:
   	     cmp     byte ptr [SI+4],0Ah
   	     jne     short M019_L_EAE1
   	     db	     081h,04Eh,004h
   	     dw	     2
M019_L_EAE1:
   	     cmp     byte ptr [SI+3],0FFh
   	     je	     short M019_L_EAED
   	     cmp     byte ptr [SI+4],0FFh
   	     jne     short M019_L_EAFD
M019_L_EAED:
   	     db	     081h,04Eh,004h
   	     dw	     4
   	     cmp     byte ptr [SI+4],4
   	     jne     short M019_L_EAFD
   	     db	     081h,04Eh,004h
   	     dw	     3
M019_L_EAFD:
   	     mov     AL,byte ptr [BP+4]
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EF6Bh
   	     cmp     DI,80h
   	     jne     short M019_L_EB20
   	     cmp     word ptr [SI+7],0
   	     je	     short M019_L_EB17
   	     push    word ptr [SI+7]
   	     db	     0E8h
   	     dw	     0F032h
M019_L_EB17:
   	     push    word ptr [SI+5]
   	     push    CS
   	     db	     0E8h
   	     dw	     0EFA2h
   	     jmp     short M019_L_EB2D
M019_L_EB20:
   	     cmp     DI,40h
   	     jne     short M019_L_EB2D
   	     mov     AL,byte ptr [SI+5]
M019_L_EB28:
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EF43h
M019_L_EB2D:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_EA61   endp
CO054_TEXT	     ends

; END STOVR167
   	     end
