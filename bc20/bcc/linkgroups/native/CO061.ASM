   	     public  X061_00
   	     public  X061_01
   	     public  X061_02
   	     public  X061_03
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1d83_a6f1
; BEGIN STAOV0A4 (listing ovr_1d83_a6f1:6F10)

   	     extrn   BCC_FAR_5B44:far
   	     extrn   X05F_05:far
   	     extrn   X05F_0C:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M000_BCC_DATA_8654	     equ     8654h
M000_BCC_DATA_866A	     equ     866Ah
M000_BCC_DATA_866C	     equ     866Ch
M000_BCC_DATA_86C4	     equ     86C4h
M000_BCC_DATA_86C6	     equ     86C6h
M000_BCC_DATA_86E0	     equ     86E0h
M000_BCC_DATA_86E2	     equ     86E2h
M000_BCC_DATA_8703	     equ     8703h
M000_BCC_DATA_8705	     equ     8705h
M000_BCC_DATA_8720	     equ     8720h
M000_BCC_DATA_8722	     equ     8722h
M000_BCC_DATA_8756	     equ     8756h

   	     public  X061_03
X061_03 label   far
BCC_FAR_6F10    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     word ptr DGROUP:M000_BCC_DATA_866A,0
   	     mov     word ptr DGROUP:M000_BCC_DATA_866C,0
   	     mov     word ptr DGROUP:M000_BCC_DATA_86C4,0
   	     mov     word ptr DGROUP:M000_BCC_DATA_86C6,0
   	     mov     SI,word ptr DGROUP:M000_BCC_DATA_86E2
   	     jmp     short M000_L_6F50
M000_L_6F32:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     mov     AX,word ptr ES:[SI]
   	     or	     AX,AX
   	     je	     short M000_L_6F44
   	     cmp     AX,4
   	     je	     short M000_L_6F44
   	     jmp     short M000_L_6F48
M000_L_6F44:
   	     push    SI
   	     db	     0E8h
   	     dw	     00158h
M000_L_6F48:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+0Eh]
M000_L_6F50:
   	     or	     SI,SI
   	     jne     short M000_L_6F32
   	     mov     word ptr DGROUP:M000_BCC_DATA_8703,0
   	     mov     word ptr DGROUP:M000_BCC_DATA_8705,0
   	     db	     09Ah
   	     dw	     X05F_0C
   	     dw	     seg X05F_0C
   	     mov     DGROUP:M000_BCC_DATA_8720,AX
   	     mov     DGROUP:M000_BCC_DATA_8756,AX
   	     mov     SI,word ptr DGROUP:M000_BCC_DATA_86E0
   	     jmp     short M000_L_6FCC
M000_L_6F71:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     mov     AX,DGROUP:M000_BCC_DATA_866A
   	     mov     word ptr ES:[SI+0Ah],AX
   	     mov     BX,word ptr ES:[SI]
   	     cmp     BX,4
   	     ja	     short M000_L_6FC4
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     0D7h
   	     mov     word ptr DGROUP:M000_BCC_DATA_8722,SI
   	     push    word ptr DGROUP:M000_BCC_DATA_8722
   	     db	     09Ah
   	     dw	     X05F_05
   	     dw	     seg X05F_05
   	     mov     DGROUP:M000_BCC_DATA_8720,AX
   	     mov     DGROUP:M000_BCC_DATA_8756,AX
   	     jmp     short M000_L_6FC4
   	     mov     BX,word ptr DGROUP:M000_BCC_DATA_8722
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     mov     AX,word ptr ES:[BX+10h]
   	     mov     DGROUP:M000_BCC_DATA_8722,AX
   	     push    word ptr DGROUP:M000_BCC_DATA_8722
   	     db	     09Ah
   	     dw	     X05F_05
   	     dw	     seg X05F_05
   	     mov     DGROUP:M000_BCC_DATA_8720,AX
   	     mov     DGROUP:M000_BCC_DATA_8756,AX
   	     jmp     short M000_L_6FC4
   	     push    SI
   	     db	     0E8h
   	     dw	     003CBh
M000_L_6FC4:
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+0Ch]
M000_L_6FCC:
   	     or	     SI,SI
   	     jne     short M000_L_6F71
   	     cmp     word ptr DGROUP:M000_BCC_DATA_8705,0
   	     je	     short M000_L_6FE2
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
M000_L_6FE2:
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_6F10    endp
CO061_TEXT	     ends

; END STAOV0A4
; BEGIN STOVT183 (listing ovr_1d83_a6f1:6FE7)
CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT

BCC_TABLE_6FE7  label   word
   	     dw	     000B0h
   	     dw	     0007Bh
   	     dw	     00090h
   	     dw	     000B4h
   	     dw	     000B0h

CO061_TEXT	     ends
; END STOVT183
; BEGIN STAOV0A5 (listing ovr_1d83_a6f1:6FF1)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M002_BCC_DATA_866E	     equ     866Eh
M002_BCC_DATA_8680	     equ     8680h
M002_BCC_DATA_8698	     equ     8698h


BCC_NEAR_6FF1   proc    near
M002_L_6FF1:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     AX,word ptr [BP+4]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     DI,AX
   	     cmp     word ptr [BP+4],0
   	     jne     short M002_L_701D
   	     xor     AX,AX
   	     jmp     short M002_L_7099
M002_L_701D:
   	     mov     AX,word ptr [DI+3]
   	     and     AX,1
   	     or	     AX,0
   	     je	     short M002_L_7060
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_866E
   	     test    byte ptr ES:[BX+0Eh],2
   	     je	     short M002_L_705C
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_866E
   	     mov     CL,byte ptr ES:[BX+7]
   	     mov     AX,1
   	     shl     AX,CL
   	     cmp     AX,word ptr [BP+6]
   	     jne     short M002_L_7058
   	     mov     AX,1
   	     jmp     short M002_L_7099
M002_L_7058:
   	     jmp     short M002_L_7097
   	     jmp     short M002_L_7099
M002_L_705C:
   	     xor     AX,AX
   	     jmp     short M002_L_7099
M002_L_7060:
   	     mov     AX,word ptr [DI+3]
   	     and     AX,28h
   	     or	     AX,0
   	     je	     short M002_L_706F
   	     xor     AX,AX
   	     jmp     short M002_L_7099
M002_L_706F:
   	     push    word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     db	     0E8h
   	     dw	     0FF75h
   	     or	     AX,AX
   	     jne     short M002_L_7092
   	     push    word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M002_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     db	     0E8h
   	     dw	     0FF63h
   	     or	     AX,AX
   	     je	     short M002_L_7097
M002_L_7092:
   	     mov     AX,1
   	     jmp     short M002_L_7099
M002_L_7097:
   	     xor     AX,AX
M002_L_7099:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_6FF1   endp
CO061_TEXT	     ends

; END STAOV0A5
; BEGIN STAOV0A6 (listing ovr_1d83_a6f1:70A0)

   	     extrn   X05F_01:far
   	     extrn   X05F_0A:far
   	     extrn   X073_00:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M003_BCC_DATA_535E	     equ     535Eh
M003_BCC_DATA_5360	     equ     5360h
M003_BCC_DATA_8654	     equ     8654h
M003_BCC_DATA_866E	     equ     866Eh
M003_BCC_DATA_8680	     equ     8680h
M003_BCC_DATA_8698	     equ     8698h

BCC_NEAR_70A0   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8654
   	     mov     AX,word ptr ES:[BX+6]
   	     mov     word ptr [BP-2],AX
   	     mov     AX,word ptr ES:[BX+4]
   	     add     AX,word ptr [BP-2]
   	     dec     AX
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     db	     0E9h
   	     dw	     0024Fh
M003_L_70C8:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],40h
   	     je	     short M003_L_70D6
   	     db	     0E9h
   	     dw	     0023Bh
M003_L_70D6:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     word ptr [BP-0Ah],AX
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,29h
   	     or	     AX,0
   	     je	     short M003_L_70FB
   	     db	     0E9h
   	     dw	     00216h
M003_L_70FB:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],3
   	     jne     short M003_L_7140
   	     push    word ptr [BP-2]
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X05F_0A
   	     dw	     seg X05F_0A
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     AX,word ptr ES:[SI+2]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     001FDh
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     AX,word ptr ES:[SI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     push    DI
   	     push    word ptr [BP-4]
   	     db	     0E9h
   	     dw	     001CEh
M003_L_7140:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],2
   	     jne     short M003_L_715A
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     AX,word ptr ES:[SI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     db	     0E9h
   	     dw	     001A8h
M003_L_715A:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],1
   	     je	     short M003_L_71E1
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     cmp     word ptr ES:[SI],0
   	     je	     short M003_L_719E
   	     mov     AX,word ptr ES:[SI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     test    byte ptr ES:[DI+1],1
   	     jne     short M003_L_719E
   	     push    DI
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr [BX+9]
   	     mov     AH,0
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X073_00
   	     dw	     seg X073_00
   	     push    AX
   	     db	     0E8h
   	     dw	     0018Bh
M003_L_719E:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M003_L_71AC
   	     db	     0E9h
   	     dw	     00165h
M003_L_71AC:
   	     mov     AX,word ptr ES:[SI+2]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     test    byte ptr ES:[DI+1],1
   	     je	     short M003_L_71C4
   	     db	     0E9h
   	     dw	     0014Dh
M003_L_71C4:
   	     push    DI
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr [BX+0Ah]
   	     mov     AH,0
   	     push    AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     db	     09Ah
   	     dw	     X073_00
   	     dw	     seg X073_00
   	     push    AX
   	     db	     0E8h
   	     dw	     0014Bh
   	     db	     0E9h
   	     dw	     00130h
M003_L_71E1:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M003_L_720E
   	     mov     AX,word ptr ES:[SI+2]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     test    byte ptr ES:[DI+1],1
   	     jne     short M003_L_720E
   	     push    DI
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr [BX+0Ah]
   	     mov     AH,0
   	     push    AX
   	     db	     0E8h
   	     dw	     0011Bh
M003_L_720E:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     cmp     word ptr ES:[SI],0
   	     jne     short M003_L_721B
   	     db	     0E9h
   	     dw	     000F6h
M003_L_721B:
   	     mov     AX,word ptr ES:[SI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     test    byte ptr ES:[DI+1],1
   	     je	     short M003_L_7232
   	     db	     0E9h
   	     dw	     000DFh
M003_L_7232:
   	     push    DI
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr [BX+9]
   	     mov     AH,0
   	     push    AX
   	     db	     0E8h
   	     dw	     000EAh
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,100h
   	     or	     AX,0
   	     jne     short M003_L_7250
   	     db	     0E9h
   	     dw	     000C1h
M003_L_7250:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI+3]
   	     mov     AH,0
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-8],AX
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-6],AX
   	     mov     AX,DGROUP:M003_BCC_DATA_535E
   	     test    word ptr [BP-6],AX
   	     je	     short M003_L_72C2
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+3F9Bh]
   	     and     AX,1
   	     or	     AX,0
   	     je	     short M003_L_72C2
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_866E
   	     test    byte ptr ES:[BX+0Eh],2
   	     je	     short M003_L_72C2
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     BX,word ptr ES:[DI]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_866E
   	     mov     CL,byte ptr ES:[BX+7]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr DGROUP:M003_BCC_DATA_5360,AX
   	     je	     short M003_L_7311
M003_L_72C2:
   	     push    word ptr [BP-6]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X05F_01
   	     dw	     seg X05F_01
   	     or	     AX,AX
   	     jne     short M003_L_7311
   	     cmp     word ptr [BP-6],0
   	     je	     short M003_L_7311
   	     mov     AX,word ptr [BP-8]
   	     and     AX,word ptr [BP-6]
   	     cmp     AX,word ptr [BP-6]
   	     jne     short M003_L_7311
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8698
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,word ptr ES:[SI+2]
   	     ja	     short M003_L_7302
   	     push    word ptr [BP-6]
   	     push    word ptr ES:[SI+2]
   	     db	     0E8h
   	     dw	     0FCF3h
   	     or	     AX,AX
   	     jne     short M003_L_7311
M003_L_7302:
   	     push    DI
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     push    AX
M003_L_730E:
   	     db	     0E8h
   	     dw	     00018h
M003_L_7311:
   	     dec     word ptr [BP-2]
   	     sub     SI,4
M003_L_7317:
   	     cmp     word ptr [BP-2],0
   	     je	     short M003_L_7320
   	     db	     0E9h
   	     dw	     0FDA8h
M003_L_7320:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_70A0   endp
CO061_TEXT	     ends

; END STAOV0A6
; BEGIN STAOV0A7 (listing ovr_1d83_a6f1:7329)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M004_BCC_DATA_8680	     equ     8680h


BCC_NEAR_7329   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     DX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI+3],0
   	     je	     short M004_L_737C
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-2],AX
   	     mov     BX,DX
   	     shl     BX,1
   	     mov     DI,word ptr [BX+4F7Ah]
   	     mov     AX,DI
   	     and     AX,word ptr [BP-2]
   	     cmp     AX,DI
   	     jne     short M004_L_7386
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+4FBCh]
   	     mov     BX,DX
   	     cmp     AL,byte ptr [BX+4FBCh]
   	     jne     short M004_L_7386
M004_L_737C:
   	     mov     ES,word ptr DGROUP:M004_BCC_DATA_8680
   	     mov     AL,DL
   	     mov     byte ptr ES:[SI+3],AL
M004_L_7386:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7329   endp
CO061_TEXT	     ends

; END STAOV0A7
; BEGIN STAOV0A8 (listing ovr_1d83_a6f1:738F)

   	     extrn   X05F_06:far
   	     extrn   X05F_07:far
   	     extrn   X05F_0B:far
   	     extrn   X062_02:far
   	     extrn   X062_04:far
   	     extrn   X062_07:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M005_BCC_DATA_535E	     equ     535Eh
M005_BCC_DATA_8654	     equ     8654h
M005_BCC_DATA_8680	     equ     8680h
M005_BCC_DATA_8698	     equ     8698h
M005_BCC_DATA_8703	     equ     8703h
M005_BCC_DATA_8705	     equ     8705h
M005_BCC_DATA_871C	     equ     871Ch
M005_BCC_DATA_871E	     equ     871Eh
M005_BCC_DATA_8720	     equ     8720h
M005_BCC_DATA_8756	     equ     8756h
M005_BCC_DATA_8758	     equ     8758h

BCC_NEAR_738F   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8654
   	     mov     AX,word ptr ES:[BX+6]
   	     mov     word ptr [BP-2],AX
   	     mov     AX,word ptr ES:[BX+4]
   	     mov     DGROUP:M005_BCC_DATA_871C,AX
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     mov     word ptr DGROUP:M005_BCC_DATA_871E,0
   	     db	     0E9h
   	     dw	     0041Ch
M005_L_73BC:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     word ptr [BP-0Ah],AX
   	     push    SI
   	     db	     09Ah
   	     dw	     X05F_0B
   	     dw	     seg X05F_0B
   	     or	     AX,AX
   	     je	     short M005_L_73EF
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     db	     0E8h
   	     dw	     010DCh
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     db	     0E8h
   	     dw	     010D1h
M005_L_73EF:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],41h
   	     je	     short M005_L_73FD
   	     db	     0E9h
   	     dw	     003D1h
M005_L_73FD:
   	     mov     byte ptr DGROUP:M005_BCC_DATA_8758,0FFh
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,29h
   	     or	     AX,0
   	     jne     short M005_L_7448
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],2
   	     jne     short M005_L_7425
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M005_L_7448
M005_L_7425:
   	     cmp     word ptr [BP-2],1
   	     jbe     short M005_L_7435
   	     push    SI
   	     db	     09Ah
   	     dw	     X05F_06
   	     dw	     seg X05F_06
   	     or	     AX,AX
   	     jne     short M005_L_743D
M005_L_7435:
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     xor     AX,AX
   	     jmp     short M005_L_7444
M005_L_743D:
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     mov     AX,1
M005_L_7444:
   	     push    AX
   	     db	     0E8h
   	     dw	     00425h
M005_L_7448:
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,2
   	     or	     AX,0
   	     je	     short M005_L_7495
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],0FFh
   	     mov     AX,word ptr [BX+3]
   	     and     AX,1
   	     or	     AX,0
   	     jne     short M005_L_7474
   	     push    SI
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     db	     09Ah
   	     dw	     X062_02
   	     dw	     seg X062_02
M005_L_7474:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+1]
   	     mov     AH,0
   	     and     AX,9
   	     cmp     AX,8
   	     je	     short M005_L_7489
   	     db	     0E9h
   	     dw	     00345h
M005_L_7489:
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     db	     09Ah
   	     dw	     X062_07
   	     dw	     seg X062_07
   	     db	     0E9h
   	     dw	     00339h
M005_L_7495:
   	     mov     BX,word ptr [BP-0Ah]
   	     cmp     byte ptr [BX+0Ch],0
   	     je	     short M005_L_74AD
   	     mov     AL,byte ptr [BX+0Ch]
   	     mov     AH,0
   	     shl     AX,1
   	     mov     BX,AX
   	     push    word ptr [BX+4FDDh]
   	     jmp     short M005_L_74DC
M005_L_74AD:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],5
   	     jne     short M005_L_74C0
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     jmp     short M005_L_74DC
M005_L_74C0:
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,401h
   	     xor     DX,DX
   	     or	     DX,DX
   	     jne     short M005_L_74DF
   	     cmp     AX,401h
   	     jne     short M005_L_74DF
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
M005_L_74DC:
   	     db	     0E8h
   	     dw	     00320h
M005_L_74DF:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],8
   	     jne     short M005_L_7561
   	     cmp     byte ptr ES:[SI],6
   	     jne     short M005_L_7519
   	     jmp     short M005_L_74F5
M005_L_74F2:
   	     db	     0E8h
   	     dw	     0080Ah
M005_L_74F5:
   	     mov     AX,DGROUP:M005_BCC_DATA_8703
   	     cmp     AX,word ptr DGROUP:M005_BCC_DATA_8705
   	     jnc     short M005_L_750D
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     mov     AX,DGROUP:M005_BCC_DATA_8720
   	     and     AX,word ptr ES:[SI]
   	     cmp     AX,word ptr ES:[SI]
   	     jne     short M005_L_74F2
M005_L_750D:
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     db	     09Ah
   	     dw	     X062_04
   	     dw	     seg X062_04
   	     db	     0E9h
   	     dw	     002B5h
M005_L_7519:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],3
   	     jne     short M005_L_7530
   	     push    SI
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     db	     09Ah
   	     dw	     X062_02
   	     dw	     seg X062_02
   	     db	     0E9h
   	     dw	     0029Eh
M005_L_7530:
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,100h
   	     or	     AX,0
   	     jne     short M005_L_7541
   	     db	     0E9h
   	     dw	     0028Dh
M005_L_7541:
   	     mov     AX,1
   	     mov     CL,byte ptr DGROUP:M005_BCC_DATA_8758
   	     shl     AX,CL
   	     mov     word ptr [BP-8],AX
   	     push    word ptr [BP-8]
   	     db	     0E8h
   	     dw	     00EDEh
   	     mov     AX,word ptr [BP-8]
   	     and     AX,word ptr DGROUP:M005_BCC_DATA_8756
   	     or	     word ptr DGROUP:M005_BCC_DATA_8720,AX
   	     db	     0E9h
   	     dw	     0026Dh
M005_L_7561:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],2
   	     je	     short M005_L_756E
   	     db	     0E9h
   	     dw	     000E9h
M005_L_756E:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M005_L_75D0
   	     mov     BX,word ptr ES:[SI+2]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+2]
   	     mov     byte ptr [BP-0Bh],AL
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     mov     AX,word ptr ES:[SI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     AL,byte ptr [BP-0Bh]
   	     push    AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+3F9Fh]
   	     mov     AH,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X05F_07
   	     dw	     seg X05F_07
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+3],AL
   	     mov     byte ptr ES:[DI+3],AL
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-0Bh]
   	     shl     AX,CL
   	     mov     word ptr [BP-4],AX
M005_L_75D0:
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     00293h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M005_L_75EF
   	     push    SI
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     db	     09Ah
   	     dw	     X062_02
   	     dw	     seg X062_02
M005_L_75EF:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     db	     0E8h
   	     dw	     00D91h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],AL
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M005_L_760F
   	     db	     0E9h
   	     dw	     001BFh
M005_L_760F:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+2]
   	     cmp     AL,byte ptr [BP-0Bh]
   	     jne     short M005_L_761F
   	     db	     0E9h
   	     dw	     001AFh
M005_L_761F:
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     00678h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],AL
   	     mov     AL,3
   	     push    AX
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr [BX+0Bh]
   	     mov     AH,0
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+4FBCh]
   	     push    AX
   	     mov     AL,byte ptr ES:[SI+2]
   	     push    AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     007BEh
   	     db	     0E9h
   	     dw	     00177h
M005_L_7657:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],3
   	     jne     short M005_L_76B8
   	     mov     DI,SI
M005_L_7663:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     mov     AX,word ptr ES:[DI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     AX,word ptr ES:[DI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[DI],3
   	     je	     short M005_L_7663
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+3F9Bh]
   	     and     AX,2
   	     or	     AX,0
   	     je	     short M005_L_769E
   	     db	     0E9h
   	     dw	     00130h
M005_L_769E:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     mov     BX,word ptr ES:[SI]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+2]
   	     mov     byte ptr ES:[SI+2],AL
   	     db	     0E9h
   	     dw	     00106h
M005_L_76B8:
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],1Bh
   	     jne     short M005_L_770B
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     cmp     AX,15h
   	     jne     short M005_L_770B
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8698
   	     cmp     word ptr ES:[SI+2],0
   	     je	     short M005_L_770B
   	     mov     AX,1000h
   	     test    word ptr DGROUP:M005_BCC_DATA_8720,AX
   	     jne     short M005_L_770B
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AL,byte ptr [BX+0Bh]
   	     mov     AH,0
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-6],AX
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-6]
   	     db	     0E8h
   	     dw	     005A0h
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],AL
   	     db	     0E9h
   	     dw	     000B3h
M005_L_770B:
   	     mov     BX,word ptr [BP-0Ah]
   	     cmp     byte ptr [BX+0Bh],0
   	     jne     short M005_L_7717
   	     db	     0E9h
   	     dw	     000B7h
M005_L_7717:
   	     mov     AL,byte ptr [BX+0Bh]
   	     mov     AH,0
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-6],AX
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     test    byte ptr ES:[SI+3],3Fh
   	     je	     short M005_L_7745
   	     mov     AL,byte ptr ES:[SI+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+4F7Ah]
   	     jmp     short M005_L_7748
M005_L_7745:
   	     mov     AX,word ptr [BP-6]
M005_L_7748:
   	     mov     word ptr [BP-4],AX
   	     mov     AX,word ptr [BP-4]
   	     and     AX,word ptr DGROUP:M005_BCC_DATA_535E
   	     cmp     AX,word ptr [BP-4]
   	     jne     short M005_L_7771
   	     mov     AX,word ptr [BP-6]
   	     test    word ptr [BP-4],AX
   	     je	     short M005_L_7771
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+3]
   	     and     AL,3Fh
   	     dec     AL
   	     mov     byte ptr ES:[SI+2],AL
   	     jmp     short M005_L_77CE
M005_L_7771:
   	     mov     BX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BX+3]
   	     and     AX,100h
   	     or	     AX,0
   	     je	     short M005_L_77AD
   	     mov     AX,1
   	     mov     CL,byte ptr DGROUP:M005_BCC_DATA_8758
   	     shl     AX,CL
   	     test    word ptr [BP-6],AX
   	     je	     short M005_L_779A
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,DGROUP:M005_BCC_DATA_8758
   	     mov     byte ptr ES:[SI+2],AL
   	     jmp     short M005_L_77BE
M005_L_779A:
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     0E8h
   	     dw	     004FDh
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],AL
   	     jmp     short M005_L_77BE
M005_L_77AD:
   	     push    word ptr [BP-4]
   	     push    word ptr [BP-6]
   	     db	     0E8h
   	     dw	     004EAh
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     byte ptr ES:[SI+2],AL
M005_L_77BE:
   	     push    word ptr DGROUP:M005_BCC_DATA_871C
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+2]
   	     push    AX
   	     db	     0E8h
   	     dw	     00C99h
M005_L_77CE:
   	     dec     word ptr [BP-2]
   	     add     SI,4
   	     inc     word ptr DGROUP:M005_BCC_DATA_871C
M005_L_77D8:
   	     cmp     word ptr [BP-2],0
   	     je	     short M005_L_77E1
   	     db	     0E9h
   	     dw	     0FBDBh
M005_L_77E1:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M005_BCC_DATA_8654
   	     test    word ptr ES:[BX+1Ch],8
   	     je	     short M005_L_77F6
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     00BFDh
M005_L_77F6:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_738F   endp
CO061_TEXT	     ends

; END STAOV0A8
; BEGIN STAOV0A9 (listing ovr_1d83_a6f1:77FF)



CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M006_BCC_DATA_8703	     equ     8703h
M006_BCC_DATA_8705	     equ     8705h
M006_BCC_DATA_8720	     equ     8720h

BCC_NEAR_77FF   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     jmp     short M006_L_780E
M006_L_780B:
   	     db	     0E8h
   	     dw	     004F1h
M006_L_780E:
   	     mov     AX,DGROUP:M006_BCC_DATA_8703
   	     cmp     AX,word ptr DGROUP:M006_BCC_DATA_8705
   	     jnc     short M006_L_7820
   	     mov     AX,DGROUP:M006_BCC_DATA_8720
   	     and     AX,SI
   	     cmp     AX,SI
   	     jne     short M006_L_780B
M006_L_7820:
   	     mov     AX,DGROUP:M006_BCC_DATA_8720
   	     mov     word ptr [BP-2],AX
   	     push    SI
   	     db	     0E8h
   	     dw	     00C07h
   	     mov     AX,word ptr [BP-2]
   	     mov     DGROUP:M006_BCC_DATA_8720,AX
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_77FF   endp
CO061_TEXT	     ends

; END STAOV0A9
; BEGIN STAOV0AA (listing ovr_1d83_a6f1:7838)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M007_BCC_DATA_8680	     equ     8680h


   	     public  X061_01
X061_01 label   far
BCC_FAR_7838    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     or	     DI,DI
   	     jne     short M007_L_7848
   	     mov     AL,0FFh
   	     jmp     short M007_L_7867
M007_L_7848:
   	     mov     AX,DI
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],1
   	     je	     short M007_L_785F
   	     mov     AL,0FFh
   	     jmp     short M007_L_7867
M007_L_785F:
   	     mov     ES,word ptr DGROUP:M007_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI+2]
M007_L_7867:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_7838    endp
CO061_TEXT	     ends

; END STAOV0AA
; BEGIN STAOV0AB (listing ovr_1d83_a6f1:786D)

   	     extrn   BCC_FAR_5B44:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M008_BCC_DATA_8698	     equ     8698h
M008_BCC_DATA_871A	     equ     871Ah
M008_BCC_DATA_8720	     equ     8720h
M008_BCC_DATA_8724	     equ     8724h
M008_BCC_DATA_8726	     equ     8726h
M008_BCC_DATA_8729	     equ     8729h
M008_BCC_DATA_8754	     equ     8754h
M008_BCC_DATA_8756	     equ     8756h
M008_BCC_DATA_8758	     equ     8758h
M008_BCC_DATA_875A	     equ     875Ah
M008_BCC_DATA_875C	     equ     875Ch

BCC_NEAR_786D   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ch
   	     push    SI
   	     push    DI
   	     mov     AX,word ptr [BP+6]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-8],AX
   	     mov     word ptr DGROUP:M008_BCC_DATA_875A,0
   	     mov     byte ptr DGROUP:M008_BCC_DATA_871A,0
   	     mov     word ptr DGROUP:M008_BCC_DATA_8754,0
   	     mov     byte ptr DGROUP:M008_BCC_DATA_875C,0
   	     push    word ptr [BP+6]
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     002B6h
   	     cmp     word ptr DGROUP:M008_BCC_DATA_875A,0
   	     jne     short M008_L_78A9
   	     db	     0E9h
   	     dw	     002A3h
M008_L_78A9:
   	     mov     AL,DGROUP:M008_BCC_DATA_871A
   	     cbw
   	     cmp     AX,word ptr DGROUP:M008_BCC_DATA_875A
   	     jne     short M008_L_78B6
   	     db	     0E9h
   	     dw	     00221h
M008_L_78B6:
   	     cmp     word ptr DGROUP:M008_BCC_DATA_875A,1
   	     jne     short M008_L_78CF
   	     push    word ptr DGROUP:M008_BCC_DATA_8724
   	     mov     AL,DGROUP:M008_BCC_DATA_8729
   	     cbw
   	     push    AX
   	     db	     0E8h
   	     dw	     006E3h
   	     mov     DGROUP:M008_BCC_DATA_8726,AL
   	     db	     0E9h
   	     dw	     00208h
M008_L_78CF:
   	     mov     AL,DGROUP:M008_BCC_DATA_875C
   	     cbw
   	     cmp     AX,word ptr DGROUP:M008_BCC_DATA_875A
   	     jl	     short M008_L_7911
   	     mov     word ptr [BP-6],0
   	     mov     word ptr [BP-2],DS
   	     mov     word ptr [BP-4],8724h
   	     jmp     short M008_L_7905
M008_L_78E8:
   	     les     BX,[BP-4]
   	     push    word ptr ES:[BX]
   	     mov     AL,byte ptr ES:[BX+5]
   	     cbw
   	     push    AX
   	     db	     0E8h
   	     dw	     006B5h
   	     les     BX,[BP-4]
   	     mov     byte ptr ES:[BX+2],AL
   	     add     word ptr [BP-4],0Ch
   	     inc     word ptr [BP-6]
M008_L_7905:
   	     mov     AX,word ptr [BP-6]
   	     cmp     AX,word ptr DGROUP:M008_BCC_DATA_875A
   	     jl	     short M008_L_78E8
   	     db	     0E9h
   	     dw	     001C6h
M008_L_7911:
   	     xor     DI,DI
   	     mov     word ptr [BP-6],0
   	     mov     word ptr [BP-2],DS
   	     mov     word ptr [BP-4],8724h
   	     jmp     short M008_L_7975
M008_L_7922:
   	     les     BX,[BP-4]
   	     cmp     byte ptr ES:[BX+2],0FFh
   	     je	     short M008_L_796E
   	     les     BX,[BP-4]
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr ES:[BX+6],AX
   	     jne     short M008_L_796E
   	     mov     AX,DGROUP:M008_BCC_DATA_8754
   	     test    word ptr ES:[BX+6],AX
   	     jne     short M008_L_796E
   	     push    word ptr ES:[BX]
   	     mov     AL,byte ptr ES:[BX+5]
   	     cbw
   	     push    AX
   	     db	     0E8h
   	     dw	     00659h
   	     les     BX,[BP-4]
   	     mov     byte ptr ES:[BX+2],AL
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     mov     word ptr ES:[BX+6],AX
   	     inc     byte ptr DGROUP:M008_BCC_DATA_871A
   	     mov     DI,1
M008_L_796E:
   	     add     word ptr [BP-4],0Ch
   	     inc     word ptr [BP-6]
M008_L_7975:
   	     mov     AX,word ptr [BP-6]
   	     cmp     AX,word ptr DGROUP:M008_BCC_DATA_875A
   	     jl	     short M008_L_7922
   	     mov     AL,DGROUP:M008_BCC_DATA_871A
   	     cbw
   	     push    AX
   	     mov     AL,DGROUP:M008_BCC_DATA_875C
   	     cbw
   	     mov     DX,word ptr DGROUP:M008_BCC_DATA_875A
   	     sub     DX,AX
   	     pop     AX
   	     cmp     AX,DX
   	     jne     short M008_L_7995
   	     db	     0E9h
   	     dw	     00106h
M008_L_7995:
   	     or	     DI,DI
   	     je	     short M008_L_799C
   	     db	     0E9h
   	     dw	     0FF75h
M008_L_799C:
   	     mov     word ptr [BP-6],0
   	     mov     word ptr [BP-2],DS
   	     mov     word ptr [BP-4],8724h
   	     db	     0E9h
   	     dw	     000CCh
M008_L_79AC:
   	     les     BX,[BP-4]
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr ES:[BX+6],AX
   	     je	     short M008_L_79C1
   	     db	     0E9h
   	     dw	     000B0h
M008_L_79C1:
   	     mov     word ptr [BP-0Ah],DS
   	     mov     word ptr [BP-0Ch],8724h
   	     xor     SI,SI
   	     jmp     short M008_L_79D2
M008_L_79CD:
   	     add     word ptr [BP-0Ch],0Ch
   	     inc     SI
M008_L_79D2:
   	     les     BX,[BP-4]
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     les     BX,[BP-0Ch]
   	     test    word ptr ES:[BX+6],AX
   	     jne     short M008_L_79ED
   	     cmp     SI,word ptr DGROUP:M008_BCC_DATA_875A
   	     jl	     short M008_L_79CD
M008_L_79ED:
   	     cmp     SI,word ptr DGROUP:M008_BCC_DATA_875A
   	     jge     short M008_L_7A64
   	     mov     AL,6
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     les     BX,[BP-0Ch]
   	     mov     AL,byte ptr ES:[BX+2]
   	     push    AX
   	     les     BX,[BP-4]
   	     push    word ptr ES:[BX]
   	     les     BX,[BP-0Ch]
   	     push    word ptr ES:[BX]
   	     db	     0E8h
   	     dw	     00402h
   	     les     BX,[BP-0Ch]
   	     mov     AL,byte ptr ES:[BX+2]
   	     cbw
   	     mov     word ptr [BP-6],AX
   	     les     BX,[BP-4]
   	     mov     AL,byte ptr ES:[BX+2]
   	     les     BX,[BP-0Ch]
   	     mov     byte ptr ES:[BX+2],AL
   	     les     BX,[BP-4]
   	     mov     AL,byte ptr [BP-6]
   	     mov     byte ptr ES:[BX+2],AL
   	     inc     byte ptr DGROUP:M008_BCC_DATA_871A
   	     les     BX,[BP-0Ch]
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr ES:[BX+6],AX
   	     je	     short M008_L_7A84
   	     les     BX,[BP-4]
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     les     BX,[BP-0Ch]
   	     test    word ptr ES:[BX+6],AX
   	     jne     short M008_L_7A84
   	     inc     byte ptr DGROUP:M008_BCC_DATA_871A
   	     jmp     short M008_L_7A84
M008_L_7A64:
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     jmp     short M008_L_7A84
M008_L_7A71:
   	     add     word ptr [BP-4],0Ch
   	     inc     word ptr [BP-6]
M008_L_7A78:
   	     mov     AX,word ptr [BP-6]
   	     cmp     AX,word ptr DGROUP:M008_BCC_DATA_875A
   	     jge     short M008_L_7A84
   	     db	     0E9h
   	     dw	     0FF28h
M008_L_7A84:
   	     mov     AL,DGROUP:M008_BCC_DATA_871A
   	     cbw
   	     push    AX
   	     mov     AL,DGROUP:M008_BCC_DATA_875C
   	     cbw
   	     mov     DX,word ptr DGROUP:M008_BCC_DATA_875A
   	     sub     DX,AX
   	     pop     AX
   	     cmp     AX,DX
   	     je	     short M008_L_7A9B
   	     db	     0E9h
   	     dw	     0FE76h
M008_L_7A9B:
   	     mov     word ptr [BP-6],0
   	     mov     word ptr [BP-2],DS
   	     mov     word ptr [BP-4],8724h
   	     jmp     short M008_L_7ACE
M008_L_7AAA:
   	     les     BX,[BP-4]
   	     cmp     byte ptr ES:[BX+2],0FFh
   	     jne     short M008_L_7AC7
   	     push    word ptr ES:[BX]
   	     mov     AL,byte ptr ES:[BX+5]
   	     cbw
   	     push    AX
   	     db	     0E8h
   	     dw	     004ECh
   	     les     BX,[BP-4]
   	     mov     byte ptr ES:[BX+2],AL
M008_L_7AC7:
   	     add     word ptr [BP-4],0Ch
   	     inc     word ptr [BP-6]
M008_L_7ACE:
   	     mov     AX,word ptr [BP-6]
   	     cmp     AX,word ptr DGROUP:M008_BCC_DATA_875A
   	     jl	     short M008_L_7AAA
M008_L_7AD7:
   	     mov     word ptr [BP-2],DS
   	     mov     word ptr [BP-4],8724h
   	     jmp     short M008_L_7B3F
M008_L_7AE1:
   	     les     BX,[BP-4]
   	     cmp     word ptr ES:[BX+0Ah],1
   	     jle     short M008_L_7AF8
   	     push    word ptr ES:[BX]
   	     mov     AL,byte ptr ES:[BX+2]
   	     push    AX
   	     db	     0E8h
   	     dw	     00971h
   	     jmp     short M008_L_7B1E
M008_L_7AF8:
   	     les     BX,[BP-4]
   	     cmp     word ptr ES:[BX+0Ah],0
   	     je	     short M008_L_7B1E
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr DGROUP:M008_BCC_DATA_8756,AX
   	     je	     short M008_L_7B1E
   	     mov     CL,byte ptr ES:[BX+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     or	     word ptr DGROUP:M008_BCC_DATA_8720,AX
M008_L_7B1E:
   	     mov     ES,word ptr DGROUP:M008_BCC_DATA_8698
   	     mov     BX,word ptr [BP-8]
   	     mov     AX,word ptr ES:[BX]
   	     les     BX,[BP-4]
   	     cmp     AX,word ptr ES:[BX]
   	     jne     short M008_L_7B37
   	     mov     AL,byte ptr ES:[BX+2]
   	     mov     DGROUP:M008_BCC_DATA_8758,AL
M008_L_7B37:
   	     add     word ptr [BP-4],0Ch
   	     dec     word ptr DGROUP:M008_BCC_DATA_875A
M008_L_7B3F:
   	     cmp     word ptr DGROUP:M008_BCC_DATA_875A,0
   	     jne     short M008_L_7AE1
   	     mov     word ptr DGROUP:M008_BCC_DATA_8754,0
M008_L_7B4C:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_786D   endp
CO061_TEXT	     ends

; END STAOV0AB
; BEGIN STAOV0AC (listing ovr_1d83_a6f1:7B55)

   	     extrn   X073_00:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M009_BCC_DATA_8680	     equ     8680h
M009_BCC_DATA_8698	     equ     8698h

BCC_NEAR_7B55   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     AX,word ptr [BP+6]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[SI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     add     AX,3F98h
   	     mov     DI,AX
   	     mov     AX,word ptr [DI+3]
   	     and     AX,20h
   	     or	     AX,0
   	     je	     short M009_L_7B88
   	     db	     0E9h
   	     dw	     000BCh
M009_L_7B88:
   	     mov     AX,word ptr [DI+3]
   	     and     AX,9
   	     or	     AX,0
   	     je	     short M009_L_7BD4
   	     mov     AX,word ptr [DI+3]
   	     and     AX,2
   	     or	     AX,0
   	     je	     short M009_L_7BA1
   	     db	     0E9h
   	     dw	     000A3h
M009_L_7BA1:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8680
   	     test    byte ptr ES:[SI+3],80h
   	     je	     short M009_L_7BBE
   	     cmp     word ptr [BP+4],0
   	     jne     short M009_L_7BBE
   	     push    word ptr [BP+6]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0029Fh
   	     db	     0E9h
   	     dw	     00086h
M009_L_7BBE:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],1
   	     jne     short M009_L_7C44
   	     push    word ptr [BP+6]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     00288h
   	     jmp     short M009_L_7C44
M009_L_7BD4:
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8680
   	     test    byte ptr ES:[SI+1],1
   	     je	     short M009_L_7C09
   	     mov     AL,byte ptr [DI+9]
   	     mov     AH,0
   	     push    AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     db	     09Ah
   	     dw	     X073_00
   	     dw	     seg X073_00
   	     mov     word ptr [BP-2],AX
   	     mov     AL,byte ptr [DI+0Ah]
   	     mov     AH,0
   	     push    AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     db	     09Ah
   	     dw	     X073_00
   	     dw	     seg X073_00
   	     jmp     short M009_L_7C16
M009_L_7C09:
   	     mov     AL,byte ptr [DI+9]
   	     mov     AH,0
   	     mov     word ptr [BP-2],AX
   	     mov     AL,byte ptr [DI+0Ah]
   	     mov     AH,0
M009_L_7C16:
   	     mov     word ptr [BP-4],AX
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8698
   	     push    word ptr ES:[SI]
   	     push    word ptr [BP+4]
   	     push    word ptr [BP-2]
   	     db	     0E8h
   	     dw	     00024h
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8680
   	     cmp     byte ptr ES:[SI],2
   	     je	     short M009_L_7C44
   	     mov     ES,word ptr DGROUP:M009_BCC_DATA_8698
   	     push    word ptr ES:[SI+2]
   	     push    word ptr [BP+4]
   	     push    word ptr [BP-4]
   	     db	     0E8h
   	     dw	     00009h
M009_L_7C44:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7B55   endp
CO061_TEXT	     ends

; END STAOV0AC
; BEGIN STAOV0AD (listing ovr_1d83_a6f1:7C4D)



CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M00A_BCC_DATA_8680	     equ     8680h

BCC_NEAR_7C4D   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     or	     SI,SI
   	     je	     short M00A_L_7C99
   	     mov     AX,SI
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8680
   	     test    byte ptr ES:[DI+1],1
   	     je	     short M00A_L_7C76
   	     push    SI
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     0FEE1h
   	     jmp     short M00A_L_7C99
M00A_L_7C76:
   	     mov     ES,word ptr DGROUP:M00A_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+3F9Bh]
   	     and     AX,2
   	     or	     AX,0
   	     jne     short M00A_L_7C99
   	     push    SI
   	     push    word ptr [BP+4]
   	     db	     0E8h
   	     dw	     001C1h
M00A_L_7C99:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     6
BCC_NEAR_7C4D   endp
CO061_TEXT	     ends

; END STAOV0AD
; BEGIN STAOV0AE (listing ovr_1d83_a6f1:7CA0)



CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M00B_BCC_DATA_8720	     equ     8720h
M00B_BCC_DATA_8754	     equ     8754h
M00B_BCC_DATA_8756	     equ     8756h

   	     public  X061_00
X061_00 label   far
BCC_NEAR_7CA0   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     AX,word ptr [BP+4]
   	     test    word ptr [BP+6],AX
   	     je	     short M00B_L_7CC6
   	     and     AX,word ptr [BP+6]
   	     mov     SI,AX
   	     and     AX,word ptr DGROUP:M00B_BCC_DATA_8754
   	     cmp     AX,SI
   	     je	     short M00B_L_7CC6
   	     test    word ptr DGROUP:M00B_BCC_DATA_8756,SI
   	     je	     short M00B_L_7CC6
   	     mov     word ptr [BP+4],SI
M00B_L_7CC6:
   	     mov     byte ptr [BP-1],0
   	     mov     AX,DGROUP:M00B_BCC_DATA_8720
   	     and     AX,word ptr [BP+4]
   	     mov     DI,AX
   	     or	     DI,DI
   	     je	     short M00B_L_7CF1
   	     mov     SI,1
   	     jmp     short M00B_L_7CED
M00B_L_7CDB:
   	     mov     AX,SI
   	     and     AX,DI
   	     cmp     AX,SI
   	     jne     short M00B_L_7CE8
   	     mov     AL,byte ptr [BP-1]
   	     jmp     short M00B_L_7CF6
M00B_L_7CE8:
   	     shl     SI,1
   	     inc     byte ptr [BP-1]
M00B_L_7CED:
   	     or	     SI,SI
   	     jne     short M00B_L_7CDB
M00B_L_7CF1:
   	     db	     0E8h
   	     dw	     0000Bh
   	     jmp     short M00B_L_7CC6
M00B_L_7CF6:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7CA0   endp
CO061_TEXT	     ends

; END STAOV0AE
; BEGIN STAOV0AF (listing ovr_1d83_a6f1:7CFF)

   	     extrn   BCC_FAR_5B44:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M00C_BCC_DATA_8680	     equ     8680h
M00C_BCC_DATA_86C0	     equ     86C0h
M00C_BCC_DATA_8703	     equ     8703h
M00C_BCC_DATA_8705	     equ     8705h
M00C_BCC_DATA_871C	     equ     871Ch
M00C_BCC_DATA_8720	     equ     8720h
M00C_BCC_DATA_8756	     equ     8756h

BCC_NEAR_7CFF   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr DGROUP:M00C_BCC_DATA_8703
   	     jmp     short M00C_L_7D11
M00C_L_7D0E:
   	     add     SI,4
M00C_L_7D11:
   	     cmp     SI,word ptr DGROUP:M00C_BCC_DATA_8705
   	     jnc     short M00C_L_7D21
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_86C0
   	     cmp     word ptr ES:[SI],0
   	     je	     short M00C_L_7D0E
M00C_L_7D21:
   	     cmp     SI,word ptr DGROUP:M00C_BCC_DATA_8705
   	     jc	     short M00C_L_7D32
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
M00C_L_7D32:
   	     mov     AX,DGROUP:M00C_BCC_DATA_871C
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8680
   	     cmp     byte ptr ES:[DI],94h
   	     je	     short M00C_L_7D4E
   	     cmp     byte ptr ES:[DI],93h
   	     je	     short M00C_L_7D4E
   	     db	     0E9h
   	     dw	     00086h
M00C_L_7D4E:
   	     mov     AX,DGROUP:M00C_BCC_DATA_8756
   	     test    word ptr DGROUP:M00C_BCC_DATA_8720,AX
   	     je	     short M00C_L_7DC7
   	     push    word ptr DGROUP:M00C_BCC_DATA_8720
   	     push    word ptr DGROUP:M00C_BCC_DATA_8720
   	     db	     0E8h
   	     dw	     0FF3Eh
   	     mov     byte ptr [BP-3],AL
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[SI]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     mov     word ptr [BP-2],AX
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_86C0
   	     push    word ptr ES:[SI]
   	     db	     0E8h
   	     dw	     005FEh
   	     mov     DX,1
   	     mov     CL,AL
   	     shl     DX,CL
   	     and     DX,word ptr DGROUP:M00C_BCC_DATA_8756
   	     or	     word ptr DGROUP:M00C_BCC_DATA_8720,DX
   	     mov     AL,3
   	     push    AX
   	     mov     BX,word ptr [BP-2]
   	     mov     AL,byte ptr [BX+4FBCh]
   	     push    AX
   	     mov     AL,byte ptr [BP-3]
   	     push    AX
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_86C0
   	     push    word ptr ES:[SI]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0005Bh
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-3]
   	     shl     AX,CL
   	     not     AX
   	     and     word ptr DGROUP:M00C_BCC_DATA_8720,AX
   	     jmp     short M00C_L_7E0B
M00C_L_7DC7:
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
   	     jmp     short M00C_L_7E0B
M00C_L_7DD4:
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_86C0
   	     push    word ptr ES:[SI]
   	     db	     0E8h
   	     dw	     005ACh
   	     mov     DX,1
   	     mov     CL,AL
   	     shl     DX,CL
   	     and     DX,word ptr DGROUP:M00C_BCC_DATA_8756
   	     or	     word ptr DGROUP:M00C_BCC_DATA_8720,DX
   	     mov     AL,1
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AL,0FFh
   	     push    AX
   	     mov     ES,word ptr DGROUP:M00C_BCC_DATA_86C0
   	     push    word ptr ES:[SI]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0000Fh
   	     mov     AX,SI
   	     add     AX,4
   	     mov     DGROUP:M00C_BCC_DATA_8703,AX
M00C_L_7E0B:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret
BCC_NEAR_7CFF   endp
CO061_TEXT	     ends

; END STAOV0AF
; BEGIN STAOV0B0 (listing ovr_1d83_a6f1:7E12)

   	     extrn   X043_03:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M00D_BCC_DATA_8666	     equ     8666h
M00D_BCC_DATA_871C	     equ     871Ch

BCC_NEAR_7E12   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DS
   	     mov     AX,8666h
   	     push    AX
   	     mov     AX,9
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M00D_BCC_DATA_8666
   	     mov     AL,byte ptr [BP+0Ch]
   	     mov     byte ptr ES:[SI],AL
   	     mov     AX,DGROUP:M00D_BCC_DATA_871C
   	     mov     word ptr ES:[SI+3],AX
   	     mov     AL,byte ptr [BP+0Ah]
   	     mov     byte ptr ES:[SI+1],AL
   	     mov     AL,byte ptr [BP+8]
   	     mov     byte ptr ES:[SI+2],AL
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI+5],AX
   	     mov     AX,word ptr [BP+4]
   	     mov     word ptr ES:[SI+7],AX
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     0Ah
BCC_NEAR_7E12   endp
CO061_TEXT	     ends

; END STAOV0B0
; BEGIN STAOV0B1 (listing ovr_1d83_a6f1:7E5A)

   	     extrn   BCC_FAR_B0F1:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M00E_BCC_DATA_8680	     equ     8680h
M00E_BCC_DATA_86C0	     equ     86C0h
M00E_BCC_DATA_86C4	     equ     86C4h
M00E_BCC_DATA_86C6	     equ     86C6h
M00E_BCC_DATA_8703	     equ     8703h
M00E_BCC_DATA_8705	     equ     8705h
M00E_BCC_DATA_871A	     equ     871Ah
M00E_BCC_DATA_8754	     equ     8754h
M00E_BCC_DATA_875A	     equ     875Ah
M00E_BCC_DATA_875C	     equ     875Ch

BCC_NEAR_7E5A   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,4
   	     push    SI
   	     push    DI
   	     mov     word ptr [BP-4],0
   	     xor     DI,DI
M00E_L_7E6A:
   	     cmp     DI,word ptr DGROUP:M00E_BCC_DATA_8705
   	     jc	     short M00E_L_7E97
   	     mov     AX,DGROUP:M00E_BCC_DATA_875A
   	     mov     DX,0Ch
   	     imul    DX
   	     add     AX,8718h
   	     mov     SI,AX
   	     jmp     short M00E_L_7E8F
M00E_L_7E7F:
   	     mov     AX,word ptr [SI]
   	     cmp     AX,word ptr [BP+6]
   	     jne     short M00E_L_7E8C
   	     dec     word ptr [SI+0Ah]
   	     db	     0E9h
   	     dw	     00117h
M00E_L_7E8C:
   	     sub     SI,0Ch
M00E_L_7E8F:
   	     cmp     SI,8724h
   	     jnc     short M00E_L_7E7F
   	     jmp     short M00E_L_7EDA
M00E_L_7E97:
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,word ptr [BP+6]
   	     jne     short M00E_L_7ED5
   	     mov     AX,DGROUP:M00E_BCC_DATA_875A
   	     mov     DX,0Ch
   	     imul    DX
   	     add     AX,8718h
   	     mov     SI,AX
   	     jmp     short M00E_L_7EC2
M00E_L_7EB2:
   	     mov     AX,word ptr [SI]
   	     cmp     AX,word ptr [BP+6]
   	     jne     short M00E_L_7EBF
   	     dec     word ptr [SI+0Ah]
   	     db	     0E9h
   	     dw	     000E4h
M00E_L_7EBF:
   	     sub     SI,0Ch
M00E_L_7EC2:
   	     cmp     SI,8724h
   	     jnc     short M00E_L_7EB2
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[DI+2]
   	     mov     word ptr [BP-4],AX
   	     jmp     short M00E_L_7EDA
M00E_L_7ED5:
   	     add     DI,4
   	     jmp     short M00E_L_7E6A
M00E_L_7EDA:
   	     mov     AX,DGROUP:M00E_BCC_DATA_875A
   	     mov     DX,0Ch
   	     imul    DX
   	     add     AX,8724h
   	     mov     SI,AX
   	     inc     word ptr DGROUP:M00E_BCC_DATA_875A
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr [SI],AX
   	     mov     BX,word ptr [BP+4]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [SI+6],AX
   	     mov     AL,byte ptr [BP+4]
   	     mov     byte ptr [SI+4],AL
   	     mov     BX,word ptr [BP+6]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M00E_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     mov     word ptr [BP-2],AX
   	     mov     byte ptr [SI+5],AL
   	     mov     BX,word ptr [BP-2]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [SI+8],AX
   	     mov     AX,word ptr [BP-4]
   	     mov     word ptr [SI+0Ah],AX
   	     cmp     DI,word ptr DGROUP:M00E_BCC_DATA_8703
   	     jnc     short M00E_L_7F42
   	     mov     AL,0FFh
   	     mov     byte ptr [SI+3],AL
   	     mov     byte ptr [SI+2],AL
   	     inc     byte ptr DGROUP:M00E_BCC_DATA_875C
   	     jmp     short M00E_L_7FA3
M00E_L_7F42:
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     00442h
   	     mov     byte ptr [SI+2],AL
   	     mov     CL,byte ptr [SI+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     or	     word ptr DGROUP:M00E_BCC_DATA_8754,AX
   	     mov     byte ptr [SI+3],0FFh
   	     cmp     DI,word ptr DGROUP:M00E_BCC_DATA_8705
   	     jnc     short M00E_L_7F9F
   	     mov     CL,byte ptr [SI+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr [SI+6],AX
   	     je	     short M00E_L_7F72
   	     inc     byte ptr DGROUP:M00E_BCC_DATA_871A
M00E_L_7F72:
   	     sub     word ptr DGROUP:M00E_BCC_DATA_8705,4
   	     push    word ptr DGROUP:M00E_BCC_DATA_86C0
   	     push    DI
   	     mov     AX,DI
   	     add     AX,4
   	     push    word ptr DGROUP:M00E_BCC_DATA_86C0
   	     push    AX
   	     mov     AX,DGROUP:M00E_BCC_DATA_8705
   	     sub     AX,DI
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     mov     word ptr DGROUP:M00E_BCC_DATA_86C6,0
   	     mov     AX,DGROUP:M00E_BCC_DATA_8705
   	     mov     DGROUP:M00E_BCC_DATA_86C4,AX
   	     jmp     short M00E_L_7FA3
M00E_L_7F9F:
   	     inc     byte ptr DGROUP:M00E_BCC_DATA_871A
M00E_L_7FA3:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7E5A   endp
CO061_TEXT	     ends

; END STAOV0B1
; BEGIN STAOV0B2 (listing ovr_1d83_a6f1:7FAC)

   	     extrn   BCC_FAR_B0F1:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M00F_BCC_DATA_8680	     equ     8680h
M00F_BCC_DATA_86C0	     equ     86C0h
M00F_BCC_DATA_86C4	     equ     86C4h
M00F_BCC_DATA_86C6	     equ     86C6h
M00F_BCC_DATA_8703	     equ     8703h
M00F_BCC_DATA_8705	     equ     8705h
M00F_BCC_DATA_8720	     equ     8720h
M00F_BCC_DATA_8754	     equ     8754h
M00F_BCC_DATA_8756	     equ     8756h

BCC_NEAR_7FAC   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,8
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr DGROUP:M00F_BCC_DATA_8705
   	     db	     0E9h
   	     dw	     000BBh
M00F_L_7FBC:
   	     sub     DI,4
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[DI]
   	     cmp     AX,word ptr [BP+6]
   	     je	     short M00F_L_7FCE
   	     db	     0E9h
   	     dw	     000A9h
M00F_L_7FCE:
   	     cmp     DI,word ptr DGROUP:M00F_BCC_DATA_8703
   	     jnc     short M00F_L_8040
M00F_L_7FD4:
   	     sub     word ptr DGROUP:M00F_BCC_DATA_8703,4
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_86C0
   	     mov     BX,word ptr DGROUP:M00F_BCC_DATA_8703
   	     mov     BX,word ptr ES:[BX]
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     shl     AX,1
   	     mov     BX,AX
   	     mov     SI,word ptr [BX+4F7Ah]
   	     test    word ptr DGROUP:M00F_BCC_DATA_8720,SI
   	     je	     short M00F_L_800A
   	     push    SI
   	     push    SI
   	     db	     0E8h
   	     dw	     0FC98h
   	     jmp     short M00F_L_800E
M00F_L_800A:
   	     push    SI
   	     db	     0E8h
   	     dw	     0013Ch
M00F_L_800E:
   	     mov     byte ptr [BP-5],AL
   	     mov     AL,2
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     mov     AL,byte ptr [BP-5]
   	     push    AX
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_86C0
   	     mov     BX,word ptr DGROUP:M00F_BCC_DATA_8703
   	     push    word ptr ES:[BX]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FDE6h
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-5]
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     003F9h
   	     cmp     DI,word ptr DGROUP:M00F_BCC_DATA_8703
   	     jc	     short M00F_L_7FD4
   	     jmp     short M00F_L_8049
M00F_L_8040:
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     00344h
   	     mov     byte ptr [BP-5],AL
M00F_L_8049:
   	     sub     word ptr DGROUP:M00F_BCC_DATA_8705,4
   	     push    word ptr DGROUP:M00F_BCC_DATA_86C0
   	     push    DI
   	     mov     AX,DI
   	     add     AX,4
   	     push    word ptr DGROUP:M00F_BCC_DATA_86C0
   	     push    AX
   	     mov     AX,DGROUP:M00F_BCC_DATA_8705
   	     sub     AX,DI
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_B0F1
   	     dw	     seg BCC_FAR_B0F1
   	     mov     word ptr DGROUP:M00F_BCC_DATA_86C6,0
   	     mov     AX,DGROUP:M00F_BCC_DATA_8705
   	     mov     DGROUP:M00F_BCC_DATA_86C4,AX
   	     db	     0E9h
   	     dw	     000C7h
M00F_L_8077:
   	     or	     DI,DI
   	     je	     short M00F_L_807E
   	     db	     0E9h
   	     dw	     0FF3Eh
M00F_L_807E:
   	     mov     AX,word ptr [BP+6]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP+6]
   	     db	     0E8h
   	     dw	     002FCh
   	     mov     byte ptr [BP-5],AL
   	     cmp     byte ptr [BP-5],0FFh
   	     jne     short M00F_L_809A
   	     db	     0E9h
   	     dw	     000A4h
M00F_L_809A:
   	     mov     BX,word ptr [BP-2]
   	     mov     ES,word ptr DGROUP:M00F_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     mov     word ptr [BP-4],AX
   	     mov     BX,word ptr [BP-4]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-8],AX
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-5]
   	     shl     AX,CL
   	     test    word ptr [BP-8],AX
   	     jne     short M00F_L_813E
   	     mov     AX,DGROUP:M00F_BCC_DATA_8720
   	     test    word ptr [BP-8],AX
   	     jne     short M00F_L_80DE
   	     mov     AX,1
   	     shl     AX,CL
   	     mov     BX,word ptr [BP+4]
   	     shl     BX,1
   	     test    word ptr [BX+4F7Ah],AX
   	     jne     short M00F_L_813E
M00F_L_80DE:
   	     push    word ptr [BP-8]
   	     mov     BX,word ptr [BP+4]
   	     shl     BX,1
   	     push    word ptr [BX+4F7Ah]
   	     db	     0E8h
   	     dw	     0FBB3h
   	     mov     byte ptr [BP-6],AL
   	     mov     AL,3
   	     push    AX
   	     mov     BX,word ptr [BP-4]
   	     mov     AL,byte ptr [BX+4FBCh]
   	     push    AX
   	     mov     AL,byte ptr [BP-6]
   	     push    AX
   	     push    word ptr [BP+6]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FD0Ah
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-5]
   	     shl     AX,CL
   	     and     AX,word ptr DGROUP:M00F_BCC_DATA_8756
   	     or	     word ptr DGROUP:M00F_BCC_DATA_8720,AX
   	     mov     AX,1
   	     shl     AX,CL
   	     not     AX
   	     and     word ptr DGROUP:M00F_BCC_DATA_8754,AX
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-6]
   	     shl     AX,CL
   	     or	     word ptr DGROUP:M00F_BCC_DATA_8754,AX
   	     mov     AX,1
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     002F9h
   	     mov     AL,byte ptr [BP-6]
   	     mov     byte ptr [BP-5],AL
M00F_L_813E:
   	     mov     AL,byte ptr [BP-5]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_7FAC   endp
CO061_TEXT	     ends

; END STAOV0B2
; BEGIN STAOV0B3 (listing ovr_1d83_a6f1:814A)

   	     extrn   BCC_FAR_5B44:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M010_BCC_DATA_8680	     equ     8680h
M010_BCC_DATA_86C0	     equ     86C0h
M010_BCC_DATA_8703	     equ     8703h
M010_BCC_DATA_8705	     equ     8705h
M010_BCC_DATA_8720	     equ     8720h
M010_BCC_DATA_8756	     equ     8756h
M010_BCC_DATA_875A	     equ     875Ah

BCC_NEAR_814A   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     AX,DGROUP:M010_BCC_DATA_8703
   	     add     AX,4
   	     mov     DI,AX
   	     db	     0E9h
   	     dw	     00097h
M010_L_815E:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[DI]
   	     mov     word ptr [BP-8],AX
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-4],AX
   	     push    word ptr [BP-8]
   	     db	     0E8h
   	     dw	     00215h
   	     mov     byte ptr [BP-1],AL
   	     mov     BX,word ptr [BP-4]
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+3]
   	     mov     AH,0
   	     and     AX,3Fh
   	     mov     word ptr [BP-6],AX
   	     mov     BX,word ptr [BP-6]
   	     shl     BX,1
   	     mov     AX,word ptr [BX+4F7Ah]
   	     mov     word ptr [BP-0Ah],AX
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-1]
   	     shl     AX,CL
   	     test    word ptr [BP+4],AX
   	     je	     short M010_L_81F2
   	     mov     AX,DGROUP:M010_BCC_DATA_8720
   	     test    word ptr [BP-0Ah],AX
   	     je	     short M010_L_81F2
   	     push    word ptr [BP-0Ah]
   	     push    word ptr [BP-0Ah]
   	     db	     0E8h
   	     dw	     0FAEBh
   	     mov     byte ptr [BP-2],AL
   	     mov     AL,3
   	     push    AX
   	     mov     BX,word ptr [BP-6]
   	     mov     AL,byte ptr [BX+4FBCh]
   	     push    AX
   	     mov     AL,byte ptr [BP-2]
   	     push    AX
   	     push    word ptr [BP-8]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FC42h
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-2]
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     00255h
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-1]
   	     shl     AX,CL
   	     and     AX,word ptr DGROUP:M010_BCC_DATA_8756
   	     or	     word ptr DGROUP:M010_BCC_DATA_8720,AX
   	     mov     AL,byte ptr [BP-1]
   	     db	     0E9h
   	     dw	     0018Fh
M010_L_81F2:
   	     add     DI,4
M010_L_81F5:
   	     cmp     DI,word ptr DGROUP:M010_BCC_DATA_8705
   	     jnc     short M010_L_81FE
   	     db	     0E9h
   	     dw	     0FF60h
M010_L_81FE:
   	     mov     AX,DGROUP:M010_BCC_DATA_8703
   	     add     AX,4
   	     mov     DI,AX
   	     jmp     short M010_L_8275
M010_L_8208:
   	     mov     ES,word ptr DGROUP:M010_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[DI]
   	     mov     word ptr [BP-8],AX
   	     shl     AX,1
   	     shl     AX,1
   	     mov     word ptr [BP-4],AX
   	     push    word ptr [BP-8]
   	     db	     0E8h
   	     dw	     0016Bh
   	     mov     byte ptr [BP-1],AL
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-1]
   	     shl     AX,CL
   	     test    word ptr [BP+4],AX
   	     je	     short M010_L_8272
   	     push    word ptr DGROUP:M010_BCC_DATA_8720
   	     push    word ptr DGROUP:M010_BCC_DATA_8720
   	     db	     0E8h
   	     dw	     0FA66h
   	     mov     byte ptr [BP-2],AL
   	     mov     AL,3
   	     push    AX
   	     mov     AL,1
   	     push    AX
   	     mov     AL,byte ptr [BP-2]
   	     push    AX
   	     push    word ptr [BP-8]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FBC2h
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-2]
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     001D5h
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-1]
   	     shl     AX,CL
   	     and     AX,word ptr DGROUP:M010_BCC_DATA_8756
   	     or	     word ptr DGROUP:M010_BCC_DATA_8720,AX
   	     mov     AL,byte ptr [BP-1]
   	     db	     0E9h
   	     dw	     0010Fh
M010_L_8272:
   	     add     DI,4
M010_L_8275:
   	     cmp     DI,word ptr DGROUP:M010_BCC_DATA_8705
   	     jc	     short M010_L_8208
   	     mov     AX,DGROUP:M010_BCC_DATA_875A
   	     mov     DX,0Ch
   	     imul    DX
   	     add     AX,8718h
   	     mov     SI,AX
   	     jmp     short M010_L_82F6
M010_L_828A:
   	     mov     CL,byte ptr [SI+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr [BP+4],AX
   	     je	     short M010_L_82F3
   	     mov     AX,DGROUP:M010_BCC_DATA_8720
   	     test    word ptr [SI+6],AX
   	     je	     short M010_L_82F3
   	     mov     AL,byte ptr [SI+2]
   	     mov     byte ptr [BP-1],AL
   	     push    word ptr [SI+6]
   	     push    word ptr [SI+6]
   	     db	     0E8h
   	     dw	     0F9F2h
   	     mov     byte ptr [BP-2],AL
   	     mov     AL,3
   	     push    AX
   	     mov     AL,byte ptr [SI+4]
   	     cbw
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+4FBCh]
   	     push    AX
   	     mov     AL,byte ptr [BP-2]
   	     push    AX
   	     push    word ptr [SI]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FB47h
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-2]
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     0015Ah
   	     mov     AL,byte ptr [BP-2]
   	     mov     byte ptr [SI+2],AL
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-1]
   	     shl     AX,CL
   	     and     AX,word ptr DGROUP:M010_BCC_DATA_8756
   	     or	     word ptr DGROUP:M010_BCC_DATA_8720,AX
   	     mov     AL,byte ptr [BP-1]
   	     db	     0E9h
   	     dw	     0008Eh
M010_L_82F3:
   	     sub     SI,0Ch
M010_L_82F6:
   	     cmp     SI,8724h
   	     jnc     short M010_L_828A
   	     mov     AX,DGROUP:M010_BCC_DATA_875A
   	     mov     DX,0Ch
   	     imul    DX
   	     add     AX,8718h
   	     mov     SI,AX
   	     jmp     short M010_L_8370
M010_L_830B:
   	     mov     CL,byte ptr [SI+2]
   	     mov     AX,1
   	     shl     AX,CL
   	     test    word ptr [BP+4],AX
   	     je	     short M010_L_836D
   	     mov     AL,byte ptr [SI+2]
   	     mov     byte ptr [BP-1],AL
   	     push    word ptr DGROUP:M010_BCC_DATA_8720
   	     push    word ptr DGROUP:M010_BCC_DATA_8720
   	     db	     0E8h
   	     dw	     0F977h
   	     mov     byte ptr [BP-2],AL
   	     mov     AL,3
   	     push    AX
   	     mov     AL,byte ptr [SI+4]
   	     cbw
   	     mov     BX,AX
   	     mov     AL,byte ptr [BX+4FBCh]
   	     push    AX
   	     mov     AL,byte ptr [BP-2]
   	     push    AX
   	     push    word ptr [SI]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0FACCh
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-2]
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     000DFh
   	     mov     AL,byte ptr [BP-2]
   	     mov     byte ptr [SI+2],AL
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-1]
   	     shl     AX,CL
   	     and     AX,word ptr DGROUP:M010_BCC_DATA_8756
   	     or	     word ptr DGROUP:M010_BCC_DATA_8720,AX
   	     mov     AL,byte ptr [BP-1]
   	     jmp     short M010_L_8381
M010_L_836D:
   	     sub     SI,0Ch
M010_L_8370:
   	     cmp     SI,8724h
   	     jnc     short M010_L_830B
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B44
   	     dw	     seg BCC_FAR_5B44
   	     inc     SP
   	     inc     SP
M010_L_8381:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_814A   endp
CO061_TEXT	     ends

; END STAOV0B3
; BEGIN STAOV0B4 (listing ovr_1d83_a6f1:838A)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M011_BCC_DATA_8666	     equ     8666h
M011_BCC_DATA_866A	     equ     866Ah
M011_BCC_DATA_8680	     equ     8680h


BCC_NEAR_838A   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+4]
   	     mov     SI,word ptr DGROUP:M011_BCC_DATA_866A
   	     jmp     short M011_L_83DA
M011_L_8399:
   	     sub     SI,9
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8666
   	     cmp     word ptr ES:[SI+3],DI
   	     jc	     short M011_L_83DE
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8666
   	     cmp     word ptr ES:[SI+5],DI
   	     jne     short M011_L_83C6
   	     cmp     byte ptr ES:[SI],6
   	     jne     short M011_L_83BC
   	     mov     DI,word ptr ES:[SI+7]
   	     jmp     short M011_L_83DA
M011_L_83BC:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8666
   	     mov     AL,byte ptr ES:[SI+2]
   	     jmp     short M011_L_83EC
M011_L_83C6:
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8666
   	     cmp     byte ptr ES:[SI],6
   	     jne     short M011_L_83DA
   	     cmp     word ptr ES:[SI+7],DI
   	     jne     short M011_L_83DA
   	     mov     DI,word ptr ES:[SI+5]
M011_L_83DA:
   	     or	     SI,SI
   	     jne     short M011_L_8399
M011_L_83DE:
   	     mov     BX,DI
   	     shl     BX,1
   	     shl     BX,1
   	     mov     ES,word ptr DGROUP:M011_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[BX+2]
M011_L_83EC:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_838A   endp
CO061_TEXT	     ends

; END STAOV0B4
; BEGIN STAOV0B5 (listing ovr_1d83_a6f1:83F3)



CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M012_BCC_DATA_8654	     equ     8654h
M012_BCC_DATA_8705	     equ     8705h
M012_BCC_DATA_871C	     equ     871Ch

BCC_NEAR_83F3   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+4]
   	     cmp     word ptr DGROUP:M012_BCC_DATA_8705,0
   	     je	     short M012_L_842B
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8654
   	     mov     SI,word ptr ES:[SI+0Ch]
   	     cmp     word ptr ES:[SI+6],0
   	     jne     short M012_L_8415
   	     mov     SI,word ptr ES:[SI+0Ch]
M012_L_8415:
   	     mov     AX,DGROUP:M012_BCC_DATA_871C
   	     neg     AX
   	     mov     DGROUP:M012_BCC_DATA_871C,AX
   	     mov     ES,word ptr DGROUP:M012_BCC_DATA_8654
   	     push    word ptr ES:[SI+4]
   	     xor     AX,AX
   	     push    AX
   	     db	     0E8h
   	     dw	     0F442h
M012_L_842B:
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_83F3   endp
CO061_TEXT	     ends

; END STAOV0B5
; BEGIN STAOV0B6 (listing ovr_1d83_a6f1:8431)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M013_BCC_DATA_8654	     equ     8654h
M013_BCC_DATA_86FD	     equ     86FDh
M013_BCC_DATA_871E	     equ     871Eh
M013_BCC_DATA_8720	     equ     8720h
M013_BCC_DATA_8722	     equ     8722h


BCC_NEAR_8431   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+4]
   	     or	     word ptr DGROUP:M013_BCC_DATA_871E,DI
   	     or	     word ptr DGROUP:M013_BCC_DATA_86FD,DI
   	     mov     AX,DI
   	     not     AX
   	     and     word ptr DGROUP:M013_BCC_DATA_8720,AX
   	     mov     SI,word ptr DGROUP:M013_BCC_DATA_8722
   	     jmp     short M013_L_845C
M013_L_8450:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_8654
   	     or	     word ptr ES:[SI+4],DI
   	     mov     SI,word ptr ES:[SI+10h]
M013_L_845C:
   	     or	     SI,SI
   	     jne     short M013_L_8450
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_8431   endp
CO061_TEXT	     ends

; END STAOV0B6
; BEGIN STAOV0B7 (listing ovr_1d83_a6f1:8467)

   	     extrn   X043_03:far


CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M014_BCC_DATA_86C0	     equ     86C0h
M014_BCC_DATA_8705	     equ     8705h

BCC_NEAR_8467   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     AX,1
   	     mov     CL,byte ptr [BP+4]
   	     shl     AX,CL
   	     push    AX
   	     db	     0E8h
   	     dw	     0FFB9h
   	     push    DS
   	     mov     AX,86C0h
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     db	     09Ah
   	     dw	     X043_03
   	     dw	     seg X043_03
   	     mov     SI,AX
   	     mov     ES,word ptr DGROUP:M014_BCC_DATA_86C0
   	     mov     AX,word ptr [BP+6]
   	     mov     word ptr ES:[SI],AX
   	     mov     word ptr ES:[SI+2],1
   	     mov     AX,SI
   	     add     AX,4
   	     mov     DGROUP:M014_BCC_DATA_8705,AX
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_NEAR_8467   endp
CO061_TEXT	     ends

; END STAOV0B7
; BEGIN STAOV0B8 (listing ovr_1d83_a6f1:84A6)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP



   	     public  X061_02
X061_02 label   far
BCC_FAR_84A6    proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     mov     SI,word ptr [BP+6]
   	     mov     DL,0FFh
   	     jmp     short M015_L_84B5
M015_L_84B1:
   	     inc     DL
   	     shr     SI,1
M015_L_84B5:
   	     or	     SI,SI
   	     jne     short M015_L_84B1
   	     mov     AL,DL
   	     pop     SI
   	     pop     BP
   	     retf    2
BCC_FAR_84A6    endp
CO061_TEXT	     ends

; END STAOV0B8
; BEGIN STAOV0B9 (listing ovr_1d83_a6f1:84C0)

CO061_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO061_TEXT,ds:DGROUP

M016_BCC_DATA_8680	     equ     8680h
M016_BCC_DATA_8698	     equ     8698h
M016_BCC_DATA_86C0	     equ     86C0h
M016_BCC_DATA_8705	     equ     8705h


BCC_NEAR_84C0   proc    near
M016_L_84C0:
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     cmp     word ptr [BP+4],0
   	     je	     short M016_L_8532
   	     mov     AX,word ptr [BP+4]
   	     shl     AX,1
   	     shl     AX,1
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8680
   	     cmp     byte ptr ES:[DI+2],0FFh
   	     je	     short M016_L_8501
   	     xor     SI,SI
   	     jmp     short M016_L_84F9
M016_L_84E4:
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_86C0
   	     mov     AX,word ptr ES:[SI]
   	     cmp     AX,word ptr [BP+4]
   	     jne     short M016_L_84F6
   	     inc     word ptr ES:[SI+2]
   	     jmp     short M016_L_8532
M016_L_84F6:
   	     add     SI,4
M016_L_84F9:
   	     cmp     SI,word ptr DGROUP:M016_BCC_DATA_8705
   	     jc	     short M016_L_84E4
   	     jmp     short M016_L_8532
M016_L_8501:
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8680
   	     mov     AL,byte ptr ES:[DI]
   	     mov     AH,0
   	     mov     DX,13h
   	     imul    DX
   	     mov     BX,AX
   	     mov     AX,word ptr [BX+3F9Bh]
   	     and     AX,29h
   	     or	     AX,0
   	     jne     short M016_L_8532
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8698
   	     push    word ptr ES:[DI]
   	     db	     0E8h
   	     dw	     0FF99h
   	     mov     ES,word ptr DGROUP:M016_BCC_DATA_8698
   	     push    word ptr ES:[DI+2]
   	     db	     0E8h
   	     dw	     0FF8Eh
M016_L_8532:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_NEAR_84C0   endp
CO061_TEXT	     ends

; END STAOV0B9
   	     end
