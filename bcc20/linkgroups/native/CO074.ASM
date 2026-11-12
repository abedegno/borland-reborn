   	     public  X074_00
   	     public  X074_02
   	     public  X074_03
   	     public  X074_01
   	     public  X074_04
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1dd3_b1f8
; BEGIN STAOV162 (listing ovr_1dd3_b1f8:1F80)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X059_04:far


CO074_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO074_TEXT,ds:DGROUP

M000_BCC_DATA_8186	     equ     8186h

   	     public  X074_04
X074_04 label   far
STAOV162	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Eh
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+6]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[DI+0Dh]
   	     cbw
   	     mov     word ptr [BP-0Ah],AX
   	     mov     AL,byte ptr ES:[DI+0Ch]
   	     cbw
   	     mov     word ptr [BP-0Ch],AX
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     mov     word ptr [BP-0Eh],AX
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-0Ch]
   	     cmp     AX,8
   	     jg	     short M000_L_1FC1
   	     mov     BX,word ptr [BP-0Eh]
   	     mov     word ptr ES:[BX+2],1
   	     mov     word ptr [BP-2],0FFh
   	     jmp     short M000_L_1FD3
M000_L_1FC1:
   	     mov     BX,word ptr [BP-0Eh]
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     word ptr ES:[BX+2],5
   	     mov     word ptr [BP-2],0FFFFh
M000_L_1FD3:
   	     push    word ptr [BP-0Eh]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-4],DX
   	     mov     word ptr [BP-6],AX
   	     mov     ES,word ptr DGROUP:M000_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     mov     AL,byte ptr [BX+9CAh]
   	     mov     AH,0
   	     test    AX,20h
   	     jne     short M000_L_2037
   	     mov     AX,word ptr [BP-0Ah]
   	     add     AX,word ptr [BP-0Ch]
   	     mov     DX,10h
   	     sub     DX,AX
   	     mov     SI,DX
   	     or	     SI,SI
   	     je	     short M000_L_2019
   	     push    word ptr [BP-6]
   	     mov     AX,45h
   	     push    AX
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0052Bh
   	     mov     word ptr [BP-6],AX
M000_L_2019:
   	     mov     AX,10h
   	     sub     AX,word ptr [BP-0Ch]
   	     mov     SI,AX
   	     or	     SI,SI
   	     je	     short M000_L_2083
   	     push    word ptr [BP-6]
   	     mov     AX,49h
   	     push    AX
   	     push    SI
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0050Fh
   	     mov     word ptr [BP-6],AX
   	     jmp     short M000_L_2083
M000_L_2037:
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-0Ch]
   	     shl     AX,CL
   	     dec     AX
   	     mov     SI,AX
   	     cmp     word ptr [BP-0Ah],0
   	     je	     short M000_L_205A
   	     push    word ptr [BP-6]
   	     mov     AX,47h
   	     push    AX
   	     push    word ptr [BP-0Ah]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     004EAh
   	     mov     word ptr [BP-6],AX
M000_L_205A:
   	     mov     AX,0Ah
   	     push    AX
   	     mov     AX,SI
   	     and     AX,word ptr [BP-2]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-8],AX
   	     mov     AX,4Bh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-8]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-6],AX
M000_L_2083:
   	     mov     DX,word ptr [BP-4]
   	     mov     AX,word ptr [BP-6]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    2
STAOV162	     endp
CO074_TEXT	     ends

; END STAOV162
; BEGIN STAOV163 (listing ovr_1dd3_b1f8:2091)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X059_04:far


CO074_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO074_TEXT,ds:DGROUP

M001_BCC_DATA_8186	     equ     8186h

   	     public  X074_02
X074_02 label   far
STAOV163	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,1Ch
   	     push    SI
   	     push    DI
   	     mov     DI,word ptr [BP+0Ah]
   	     mov     SI,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[DI+0Dh]
   	     cbw
   	     mov     word ptr [BP-16h],AX
   	     mov     AL,byte ptr ES:[DI+0Ch]
   	     cbw
   	     mov     word ptr [BP-18h],AX
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-18h]
   	     shl     AX,CL
   	     dec     AX
   	     mov     word ptr [BP-1Ah],AX
   	     mov     CL,byte ptr [BP-16h]
   	     shl     AX,CL
   	     not     AX
   	     mov     word ptr [BP-1Ch],AX
   	     mov     AX,word ptr [BP-16h]
   	     add     AX,word ptr [BP-18h]
   	     cmp     AX,8
   	     jg	     short M001_L_20F9
   	     mov     BX,word ptr ES:[DI+0Ah]
   	     mov     word ptr ES:[BX+2],1
   	     mov     word ptr [BP-10h],9
   	     mov     word ptr [BP-12h],4Ch
   	     mov     word ptr [BP-14h],4Ah
   	     and     word ptr [BP-1Ch],0FFh
   	     and     word ptr [BP-1Ah],0FFh
   	     jmp     short M001_L_2108
M001_L_20F9:
   	     mov     word ptr [BP-10h],0Ah
   	     mov     word ptr [BP-12h],4Dh
   	     mov     word ptr [BP-14h],4Bh
M001_L_2108:
   	     cmp     word ptr [BP-18h],1
   	     je	     short M001_L_2111
   	     db	     0E9h
   	     dw	     00095h
M001_L_2111:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2
   	     je	     short M001_L_211E
   	     db	     0E9h
   	     dw	     00088h
M001_L_211E:
   	     push    word ptr ES:[DI+0Ah]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-6],DX
   	     mov     word ptr [BP-8],AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     db	     26h,81h,64h,0Ah,01h,00h
   	     db	     26h,81h,64h,0Ch,00h,00h
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     or	     AX,word ptr ES:[SI+0Ch]
   	     je	     short M001_L_2166
   	     push    word ptr [BP-10h]
   	     mov     AX,1
   	     mov     CL,byte ptr [BP-16h]
   	     shl     AX,CL
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-0Eh],AX
   	     push    word ptr [BP-12h]
   	     jmp     short M001_L_217A
M001_L_2166:
   	     push    word ptr [BP-10h]
   	     mov     AX,word ptr [BP-1Ch]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-0Eh],AX
   	     push    word ptr [BP-14h]
M001_L_217A:
   	     mov     AL,2
   	     push    AX
   	     push    word ptr [BP-8]
   	     push    word ptr [BP-0Eh]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-8],AX
   	     mov     AX,0Ah
   	     push    AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-0Ch],AX
   	     db	     0E9h
   	     dw	     00120h
M001_L_21A6:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2
   	     je	     short M001_L_21E2
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-2],DX
   	     mov     word ptr [BP-4],AX
   	     mov     AX,4Bh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-4]
   	     mov     AX,0Ah
   	     push    AX
   	     mov     AX,word ptr [BP-1Ah]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-4],AX
M001_L_21E2:
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[DI+0Ah]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-6],DX
   	     mov     word ptr [BP-8],AX
   	     push    word ptr [BP-10h]
   	     mov     AX,word ptr [BP-1Ch]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-0Eh],AX
   	     push    word ptr [BP-14h]
   	     mov     AL,2
   	     push    AX
   	     push    word ptr [BP-8]
   	     push    word ptr [BP-0Eh]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     AX,word ptr [BP-16h]
   	     mov     word ptr [BP-1Ch],AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],2
   	     jne     short M001_L_2288
   	     mov     AX,word ptr [BP-1Ah]
   	     cwd
   	     and     word ptr ES:[SI+0Ah],AX
   	     and     word ptr ES:[SI+0Ch],DX
   	     mov     AX,word ptr ES:[SI+0Ah]
   	     mov     CL,byte ptr [BP-1Ch]
   	     shl     AX,CL
   	     mov     word ptr [BP-1Ch],AX
   	     cmp     word ptr [BP-1Ch],0
   	     je	     short M001_L_2268
   	     push    word ptr [BP-10h]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-4],AX
   	     push    word ptr [BP-12h]
   	     mov     AL,2
   	     push    AX
   	     push    word ptr [BP-8]
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M001_L_2268:
   	     cmp     word ptr [BP+6],0
   	     je	     short M001_L_22C6
   	     mov     AX,0Ah
   	     push    AX
   	     mov     ES,word ptr DGROUP:M001_BCC_DATA_8186
   	     push    word ptr ES:[SI+0Ch]
   	     push    word ptr ES:[SI+0Ah]
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     mov     word ptr [BP-0Ch],AX
   	     jmp     short M001_L_22C6
M001_L_2288:
   	     cmp     word ptr [BP+6],0
   	     je	     short M001_L_22A3
   	     mov     AX,98h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-4]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-0Ch],AX
M001_L_22A3:
   	     push    word ptr [BP-4]
   	     mov     AX,45h
   	     push    AX
   	     push    word ptr [BP-1Ch]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     0028Fh
   	     mov     word ptr [BP-4],AX
   	     push    word ptr [BP-12h]
   	     mov     AL,2
   	     push    AX
   	     push    word ptr [BP-8]
   	     push    word ptr [BP-4]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M001_L_22C6:
   	     mov     word ptr [BP-0Ah],0
   	     mov     DX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BP-0Ch]
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    6
STAOV163	     endp
CO074_TEXT	     ends

; END STAOV163
; BEGIN STAOV164 (listing ovr_1dd3_b1f8:22D9)

   	     extrn   X059_04:far


CO074_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO074_TEXT,ds:DGROUP

M002_BCC_DATA_812C	     equ     812Ch

   	     public  X074_01
X074_01 label   far
STAOV164	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    word ptr [BP+8]
   	     db	     0FFh,01Eh
   	     dw	     812Ch
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     pop     BP
   	     retf    4
STAOV164	     endp
CO074_TEXT	     ends

; END STAOV164
; BEGIN STAOV165 (listing ovr_1dd3_b1f8:22F0)

   	     extrn   X058_00:far
   	     extrn   X058_02:far
   	     extrn   X059_04:far


CO074_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO074_TEXT,ds:DGROUP

M003_BCC_DATA_80E8	     equ     80E8h
M003_BCC_DATA_812C	     equ     812Ch
M003_BCC_DATA_8130	     equ     8130h
M003_BCC_DATA_8186	     equ     8186h

   	     public  X074_00
X074_00 label   far
STAOV165	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,14h
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+8]
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     DI,word ptr ES:[SI+0Ah]
   	     mov     AX,word ptr ES:[DI+0Ah]
   	     mov     word ptr [BP-14h],AX
   	     push    word ptr [BP-14h]
   	     db	     0FFh,01Eh
   	     dw	     80E8h
   	     or	     AX,AX
   	     je	     short M003_L_2347
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],13h
   	     je	     short M003_L_2325
   	     cmp     word ptr ES:[SI],14h
   	     jne     short M003_L_2336
M003_L_2325:
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     812Ch
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     db	     0E9h
   	     dw	     00203h
M003_L_2336:
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     8130h
   	     push    AX
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     db	     0E9h
   	     dw	     001F2h
M003_L_2347:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     CL,byte ptr ES:[DI+0Dh]
   	     mov     AX,1
   	     shl     AX,CL
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-14h]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-6],DX
   	     mov     word ptr [BP-8],AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     CL,byte ptr ES:[DI+0Ch]
   	     mov     AX,1
   	     shl     AX,CL
   	     dec     AX
   	     mov     CL,byte ptr ES:[DI+0Dh]
   	     shl     AX,CL
   	     mov     word ptr [BP-12h],AX
   	     xor     AX,AX
   	     mov     word ptr [BP-0Ah],AX
   	     mov     word ptr [BP-0Eh],AX
   	     mov     AX,98h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-8]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-10h],AX
   	     cmp     word ptr [BP+6],0
   	     je	     short M003_L_23C2
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],14h
   	     jle     short M003_L_23C2
   	     mov     AX,98h
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-10h]
   	     xor     AX,AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-0Ch],AX
M003_L_23C2:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],23h
   	     je	     short M003_L_23D2
   	     cmp     word ptr ES:[SI],13h
   	     jne     short M003_L_23D9
M003_L_23D2:
   	     mov     word ptr [BP-4],1Fh
   	     jmp     short M003_L_23DE
M003_L_23D9:
   	     mov     word ptr [BP-4],28h
M003_L_23DE:
   	     push    word ptr [BP-4]
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-10h]
   	     mov     AX,0Ah
   	     push    AX
   	     mov     AX,word ptr [BP-2]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-10h],AX
   	     mov     AX,4Bh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-10h]
   	     mov     AX,0Ah
   	     push    AX
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr [BP-12h]
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     mov     word ptr [BP-10h],AX
   	     push    word ptr [BP-14h]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-6],DX
   	     mov     word ptr [BP-8],AX
   	     mov     AX,4Bh
   	     push    AX
   	     mov     AL,2
   	     push    AX
   	     push    word ptr [BP-8]
   	     mov     AX,0Ah
   	     push    AX
   	     mov     AX,word ptr [BP-12h]
   	     not     AX
   	     xor     DX,DX
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     push    word ptr [BP-14h]
   	     mov     AX,1
   	     push    AX
   	     db	     09Ah
   	     dw	     X059_04
   	     dw	     seg X059_04
   	     mov     word ptr [BP-6],DX
   	     mov     word ptr [BP-8],AX
   	     mov     AX,4Dh
   	     push    AX
   	     mov     AL,2
   	     push    AX
   	     push    word ptr [BP-8]
   	     push    word ptr [BP-10h]
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     cmp     word ptr [BP+6],0
   	     jne     short M003_L_2482
   	     db	     0E9h
   	     dw	     000B1h
M003_L_2482:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     cmp     word ptr ES:[SI],14h
   	     jg	     short M003_L_2492
   	     mov     AX,word ptr [BP-10h]
   	     mov     word ptr [BP-0Ch],AX
M003_L_2492:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     BX,word ptr ES:[DI+2]
   	     test    byte ptr [BX+9CAh],20h
   	     je	     short M003_L_24E4
   	     mov     CL,byte ptr ES:[DI+0Ch]
   	     mov     AX,1
   	     shl     AX,CL
   	     dec     AX
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-0Ch]
   	     mov     AX,47h
   	     push    AX
   	     mov     AL,byte ptr ES:[DI+0Dh]
   	     cbw
   	     push    AX
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00081h
   	     mov     word ptr [BP-0Ch],AX
   	     mov     AX,4Bh
   	     push    AX
   	     mov     AL,0
   	     push    AX
   	     push    word ptr [BP-0Ch]
   	     mov     AX,0Ah
   	     push    AX
   	     mov     AX,word ptr [BP-2]
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
   	     jmp     short M003_L_2530
M003_L_24E4:
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[DI+0Dh]
   	     cbw
   	     push    AX
   	     mov     AL,byte ptr ES:[DI+0Ch]
   	     cbw
   	     pop     DX
   	     add     DX,AX
   	     mov     AX,10h
   	     sub     AX,DX
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-0Ch]
   	     mov     AX,45h
   	     push    AX
   	     push    word ptr [BP-2]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00034h
   	     mov     word ptr [BP-0Ch],AX
   	     mov     ES,word ptr DGROUP:M003_BCC_DATA_8186
   	     mov     AL,byte ptr ES:[DI+0Ch]
   	     cbw
   	     mov     DX,10h
   	     sub     DX,AX
   	     mov     word ptr [BP-2],DX
   	     push    word ptr [BP-0Ch]
   	     mov     AX,49h
   	     push    AX
   	     push    word ptr [BP-2]
   	     nop
   	     push    CS
   	     db	     0E8h
   	     dw	     00011h
M003_L_2530:
   	     mov     word ptr [BP-0Ch],AX
M003_L_2533:
   	     mov     DX,word ptr [BP-0Ah]
   	     mov     AX,word ptr [BP-0Ch]
M003_L_2539:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    4
STAOV165	     endp
CO074_TEXT	     ends

; END STAOV165
; BEGIN STAOV166 (listing ovr_1dd3_b1f8:2541)


   	     extrn   X058_00:far
   	     extrn   X058_02:far


CO074_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO074_TEXT,ds:DGROUP

   	     public  X074_03
X074_03 label   far
BCC_NEAR_2541   label   near
STAOV166	     proc    far
   	     push    BP
   	     mov     BP,SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+0Ah]
   	     mov     DI,word ptr [BP+6]
   	     or	     DI,DI
   	     jne     short M004_L_2554
   	     mov     AX,SI
   	     jmp     short M004_L_256F
M004_L_2554:
   	     push    word ptr [BP+8]
   	     mov     AL,0
   	     push    AX
   	     push    SI
   	     mov     AX,9
   	     push    AX
   	     mov     AX,DI
   	     cwd
   	     push    DX
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_00
   	     dw	     seg X058_00
   	     push    AX
   	     db	     09Ah
   	     dw	     X058_02
   	     dw	     seg X058_02
M004_L_256F:
   	     pop     DI
   	     pop     SI
   	     pop     BP
   	     retf    6
STAOV166	     endp
CO074_TEXT	     ends

; END STAOV166
   	     end
