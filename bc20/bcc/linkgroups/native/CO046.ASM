; Recovered FBOV far-pointer references
   	     extrn   BCC_DIAGNOSTIC:far
CO019_TEXT	     segment byte public 'CODE'
CO019_TEXT	     ends
CO04A_TEXT	     segment byte public 'CODE'
CO04A_TEXT	     ends
   	     public  X046_03
   	     public  X046_02
   	     public  X046_01
   	     public  X046_00
   	     public  X046_07
   	     public  X046_06
   	     public  X046_05
   	     public  X046_04
   	     public  X046_09
   	     public  X046_08
   	     public  X046_0A
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1cf2_9000
; BEGIN STMAIN (listing ovr_1cf2_9000:0000)

   	     extrn   BCC_STMT_DEPTH:word
   	     extrn   X031_0E:far
   	     extrn   BCC_TOKEN_HOOK:dword
   	     extrn   BCC_OPTION_16F5:byte
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   X034_00:far
   	     extrn   BCC_RD_66BE_W:word
   	     extrn   BCC_SOURCE_LINE:word
   	     extrn   BCC_TOKEN_POSITION:dword
   	     extrn   BCC_RD_8628_D:dword
   	     extrn   X03C_03:far
   	     extrn   BCC_STMT_RESULT:word
   	     extrn   BCC_STMT_HOOK:dword
   	     extrn   BCC_RD_243E_W:word
   	     extrn   BCC_RD_8624_W:word
   	     extrn   BCC_RD_241E_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_FD3E_B:byte
   	     extrn   BCC_RD_77FD_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP
M000_BCC_STMT_MESSAGES  equ     37DAh

   	     public  X046_04
X046_04 label   far
BCC_STATEMENT_MAIN	     proc    far
        push    bp
        mov     bp,sp
        push    si
        mov     word ptr DGROUP:BCC_STMT_DEPTH,0
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M000_L_001B
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M000_L_0020
M000_L_001B:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M000_L_0020:
        db	     0FFh,1Eh
        dw	     BCC_TOKEN_HOOK
        cmp     word ptr DGROUP:BCC_RD_603E_W,0
        jne     short M000_L_003D
        cmp     byte ptr DGROUP:BCC_OPTION_16F5,1
        jne     short M000_L_003D
        mov     ax,0B2h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M000_L_003D:
        db	     9Ah
        dw	     X034_00
        dw	     seg X034_00
        cmp     word ptr DGROUP:BCC_RD_603E_W,0
        jne     short M000_L_004C
        db	     0E9h
        dw	     000C9h
M000_L_004C:
        mov     ax,word ptr DGROUP:BCC_SOURCE_LINE
        mov     word ptr DGROUP:BCC_RD_66BE_W,ax
        mov     ax,word ptr DGROUP:BCC_TOKEN_POSITION+2
        mov     dx,word ptr DGROUP:BCC_TOKEN_POSITION
        mov     word ptr DGROUP:BCC_RD_8628_D+2,ax
        mov     word ptr DGROUP:BCC_RD_8628_D,dx
        cmp     word ptr DGROUP:BCC_RD_603E_W,57h
        jne     short M000_L_006F
        db	     9Ah
        dw	     X03C_03
        dw	     seg X03C_03
        db	     0E9h
        dw	     00089h
M000_L_006F:
        cmp     word ptr DGROUP:BCC_RD_603E_W,6
        jne     short M000_L_0083
        mov     ax,0B5h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        jmp     short M000_L_00F8
M000_L_0083:
        push    word ptr DGROUP:BCC_RD_8260_W
        nop
        push    cs
        db	     0E8h
        dw	     0008Ch
        or	     ax,ax
        je	     short M000_L_00D7
        nop
        push    cs
        db	     0E8h
        dw	     000B2h
        mov     si,ax
        or	     si,si
        je	     short M000_L_00FC
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        jne     short M000_L_00AA
        mov     word ptr DGROUP:BCC_RD_8624_W,1
        jmp     short M000_L_00DF
M000_L_00AA:
        cmp     word ptr DGROUP:BCC_RD_243E_W,5
        je	     short M000_L_00B8
        cmp     word ptr DGROUP:BCC_RD_243E_W,0Dh
        jne     short M000_L_00DF
M000_L_00B8:
        push    ds
        mov     bx,word ptr DGROUP:BCC_RD_241E_W
        shl     bx,1
        push    word ptr [bx+M000_BCC_STMT_MESSAGES]
        mov     ax,102h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        mov     word ptr DGROUP:BCC_RD_8624_W,1
        jmp     short M000_L_00DF
M000_L_00D7:
        mov     word ptr DGROUP:BCC_RD_8624_W,1
        xor     si,si
M000_L_00DF:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M000_L_00F8
        mov     word ptr DGROUP:BCC_STMT_RESULT,0
        push    word ptr DGROUP:BCC_RD_8624_W
        push    si
        mov     ax,1
        push    ax
        db	     0E8h
        dw	     00F16h
M000_L_00F8:
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK
M000_L_00FC:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M000_L_010D
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M000_L_0112
M000_L_010D:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M000_L_0112:
        db	     0E9h
        dw	     0FF28h
M000_L_0115:
        pop     si
        pop     bp
        retf
BCC_STATEMENT_MAIN	     endp
CO046_TEXT	     ends

; END STMAIN
; BEGIN STCLASS (listing ovr_1cf2_9000:0118)

   	     extrn   BCC_RD_8269_W:word


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M001_BCC_STMT_ATTRIBUTES	     equ     2064h

   	     public  X046_03
X046_03 label   far
BCC_STMT_CLASSIFY	     proc    far
        push    bp
        mov     bp,sp
        push    si
        mov     si,word ptr [bp+6]
        test    byte ptr [si+M001_BCC_STMT_ATTRIBUTES],30h
        je	     short M001_L_012B
        mov     ax,1
        jmp     short M001_L_0142
M001_L_012B:
        cmp     si,31h
        jne     short M001_L_0140
        push    word ptr DGROUP:BCC_RD_8269_W
        db	     0E8h
        dw	     00405h
        or	     ax,ax
        je	     short M001_L_0140
        mov     ax,1
        jmp     short M001_L_0142
M001_L_0140:
        xor     ax,ax
M001_L_0142:
        pop     si
        pop     bp
        retf    2
BCC_STMT_CLASSIFY	     endp
CO046_TEXT	     ends

; END STCLASS
; BEGIN STBUILD (listing ovr_1cf2_9000:0147)

   	     extrn   BCC_STMT_LOCAL1:byte
   	     extrn   BCC_STMT_LOCAL2:byte
   	     extrn   BCC_STMT_LOCAL3:byte
   	     extrn   BCC_RTL_03C2:far
   	     extrn   X04D_00:far
   	     extrn   BCC_RTL_0402:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_RD_8269_W:word
   	     extrn   X031_0E:far
   	     extrn   BCC_SOURCE_LINE:word
   	     extrn   BCC_RD_66BE_W:word
   	     extrn   BCC_OPTION_16F6:byte
   	     extrn   BCC_STMT_FACTORY:dword
   	     extrn   BCC_RD_862E_W:word
   	     extrn   BCC_RD_8624_W:word
   	     extrn   BCC_RD_243E_W:word
   	     extrn   BCC_RD_601E_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_77FD_B:byte
   	     extrn   BCC_RD_FD3E_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

   	     public  X046_07
X046_07 label   far
BCC_STMT_BUILD  proc    far
        push    bp
        mov     bp,sp
        sub     sp,10h
        push    si
        push    di
        xor     di,di
        mov     word ptr [bp-2],0
        mov     word ptr [bp-4],0
        mov     word ptr [bp-6],0
        mov     word ptr [bp-8],0
        xor     si,si
        mov     word ptr [bp-0Ah],0
        mov     byte ptr DGROUP:BCC_STMT_LOCAL1,0
        mov     byte ptr DGROUP:BCC_STMT_LOCAL2,0
        mov     byte ptr DGROUP:BCC_STMT_LOCAL3,0
        mov     word ptr DGROUP:BCC_RD_8624_W,0
M002_L_0181:
        mov     word ptr [bp-0Ch],0
        mov     ax,offset DGROUP:BCC_STMT_LOCAL1
        push    ds
        push    ax
        push    ss
        lea     ax,[bp-10h]
        push    ax
        mov     ax,offset DGROUP:BCC_STMT_LOCAL1
        mov     dx,ds
        mov     cx,4
        db	     9Ah
        dw	     BCC_RTL_03C2
        dw	     seg BCC_RTL_03C2
        db	     9Ah
        dw	     X04D_00
        dw	     seg X04D_00
        lea     ax,[bp-10h]
        push    ss
        push    ax
        mov     cx,3
        db	     9Ah
        dw	     BCC_RTL_0402
        dw	     seg BCC_RTL_0402
        mov     bx,word ptr DGROUP:BCC_RD_601E_W
        sub     bx,31h
        cmp     bx,1Ah
        jbe     short M002_L_01BE
        db	     0E9h
        dw	     00205h
M002_L_01BE:
        shl     bx,1
        jmp     word ptr cs:[bx+0506h]
M002_L_01C5:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        je	     short M002_L_01D7
        mov     ax,23h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_01D7:
        mov     word ptr DGROUP:BCC_RD_8624_W,3
        db	     0E9h
        dw	     001EDh
M002_L_01E0:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        je	     short M002_L_01F2
        mov     ax,23h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_01F2:
        mov     word ptr DGROUP:BCC_RD_8624_W,2
        db	     0E9h
        dw	     001D2h
M002_L_01FB:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        je	     short M002_L_020D
        mov     ax,23h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_020D:
        mov     word ptr DGROUP:BCC_RD_8624_W,8
        db	     0E9h
        dw	     001B7h
M002_L_0216:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        je	     short M002_L_0228
        mov     ax,23h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0228:
        mov     word ptr DGROUP:BCC_RD_8624_W,5
        db	     0E9h
        dw	     0019Ch
M002_L_0231:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        je	     short M002_L_0243
        mov     ax,23h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0243:
        mov     word ptr DGROUP:BCC_RD_8624_W,0Dh
        db	     0E9h
        dw	     00181h
M002_L_024C:
        test    word ptr [bp-0Ah],1
        je	     short M002_L_025E
        mov     ax,31h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_025E:
        db	     81h,4Eh,0F6h
        dw	     1
        db	     0E9h
        dw	     00167h
M002_L_0266:
        test    word ptr [bp-0Ah],2
        je	     short M002_L_0278
        mov     ax,31h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0278:
        db	     81h,4Eh,0F6h
        dw	     2
        db	     0E9h
        dw	     0014Dh
M002_L_0280:
        or	     si,si
        je	     short M002_L_028F
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_028F:
        mov     si,0Ch
        db	     0E9h
        dw	     00138h
M002_L_0295:
        or	     si,si
        je	     short M002_L_02A4
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_02A4:
        mov     si,1
        db	     0E9h
        dw	     00123h
M002_L_02AA:
        mov     word ptr [bp-6],1
        db	     0E9h
        dw	     0011Bh
M002_L_02B2:
        mov     word ptr [bp-8],1
        db	     0E9h
        dw	     00113h
M002_L_02BA:
        mov     word ptr [bp-2],1
        db	     0E9h
        dw	     0010Bh
M002_L_02C2:
        mov     word ptr [bp-4],1
        db	     0E9h
        dw	     00103h
M002_L_02CA:
        or	     si,si
        je	     short M002_L_02D9
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_02D9:
        mov     si,5
        db	     0E9h
        dw	     000EEh
M002_L_02DF:
        or	     si,si
        je	     short M002_L_02EE
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_02EE:
        mov     si,0Ah
        db	     0E9h
        dw	     000D9h
M002_L_02F4:
        or	     si,si
        je	     short M002_L_0303
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0303:
        mov     si,9
        db	     0E9h
        dw	     000C4h
M002_L_0309:
        or	     si,si
        jne     short M002_L_0325
        cmp     word ptr [bp-6],0
        jne     short M002_L_0325
        cmp     word ptr [bp-2],0
        jne     short M002_L_0325
        cmp     word ptr [bp-8],0
        jne     short M002_L_0325
        cmp     word ptr [bp-4],0
        je	     short M002_L_0330
M002_L_0325:
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0330:
        db	     0E8h
        dw	     00915h
        mov     di,ax
        or	     di,di
        jne     short M002_L_033E
        xor     ax,ax
        db	     0E9h
        dw	     001ACh
M002_L_033E:
        mov     si,15h
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
        db	     0E9h
        dw	     00084h
M002_L_0349:
        or	     si,si
        je	     short M002_L_0358
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0358:
        mov     ax,1
        push    ax
        db	     0E8h
        dw	     00233h
        mov     di,ax
        or	     di,di
        jne     short M002_L_036A
        xor     ax,ax
        db	     0E9h
        dw	     00180h
M002_L_036A:
        mov     si,13h
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
        jmp     short M002_L_03CD
M002_L_0374:
        or	     si,si
        je	     short M002_L_0383
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0383:
        mov     ax,2
        push    ax
        db	     0E8h
        dw	     00208h
        mov     di,ax
        or	     di,di
        jne     short M002_L_0395
        xor     ax,ax
        db	     0E9h
        dw	     00155h
M002_L_0395:
        mov     si,13h
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
        jmp     short M002_L_03CD
M002_L_039F:
        or	     si,si
        je	     short M002_L_03A5
        jmp     short M002_L_03C3
M002_L_03A5:
        push    word ptr DGROUP:BCC_RD_8269_W
        db	     0E8h
        dw	     00190h
        mov     di,ax
        or	     di,di
        je	     short M002_L_03B7
        mov     si,-1
        jmp     short M002_L_03CD
M002_L_03B7:
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
        mov     word ptr [bp-0Ch],1
        jmp     short M002_L_03CD
M002_L_03C3:
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
        mov     word ptr [bp-0Ch],1
M002_L_03CD:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M002_L_03DE
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M002_L_03E3
M002_L_03DE:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M002_L_03E3:
        mov     ax,word ptr DGROUP:BCC_SOURCE_LINE
        mov     word ptr DGROUP:BCC_RD_66BE_W,ax
        cmp     word ptr [bp-0Ch],0
        jne     short M002_L_03F2
        db	     0E9h
        dw	     0FD8Fh
M002_L_03F2:
        cmp     word ptr [bp-8],0
        je	     short M002_L_0400
        cmp     word ptr [bp-6],0
        je	     short M002_L_0400
        jmp     short M002_L_040C
M002_L_0400:
        cmp     word ptr [bp-4],0
        je	     short M002_L_0417
        cmp     word ptr [bp-2],0
        je	     short M002_L_0417
M002_L_040C:
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M002_L_0417:
        mov     bx,si
        cmp     bx,0Ah
        jbe     short M002_L_0421
        db	     0E9h
        dw	     000B6h
M002_L_0421:
        shl     bx,1
        jmp     word ptr cs:[bx+04F0h]
M002_L_0428:
        cmp     word ptr [bp-2],0
        je	     short M002_L_0434
        mov     si,2
        db	     0E9h
        dw	     000A3h
M002_L_0434:
        cmp     word ptr [bp-4],0
        je	     short M002_L_043D
        db	     0E9h
        dw	     0009Ah
M002_L_043D:
        cmp     byte ptr DGROUP:BCC_OPTION_16F6,0
        jne     short M002_L_0447
        db	     0E9h
        dw	     00090h
M002_L_0447:
        mov     si,2
        db	     0E9h
        dw	     0008Ah
M002_L_044D:
        cmp     word ptr [bp-8],0
        je	     short M002_L_0456
        mov     si,0Ah
M002_L_0456:
        cmp     word ptr [bp-2],0
        jne     short M002_L_0462
        cmp     word ptr [bp-4],0
        je	     short M002_L_04D7
M002_L_0462:
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        jmp     short M002_L_04D7
M002_L_046F:
        cmp     word ptr [bp-8],0
        je	     short M002_L_0478
        mov     si,0Bh
M002_L_0478:
        cmp     word ptr [bp-2],0
        jne     short M002_L_0484
        cmp     word ptr [bp-4],0
        je	     short M002_L_04D7
M002_L_0484:
        mov     ax,24h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        jmp     short M002_L_04D7
M002_L_0491:
        cmp     word ptr [bp-8],0
        je	     short M002_L_04A2
        cmp     word ptr [bp-2],0
        je	     short M002_L_04A2
        mov     si,8
        jmp     short M002_L_04D7
M002_L_04A2:
        cmp     word ptr [bp-8],0
        je	     short M002_L_04AD
        mov     si,7
        jmp     short M002_L_04D7
M002_L_04AD:
        cmp     word ptr [bp-6],0
        je	     short M002_L_04BE
        cmp     word ptr [bp-2],0
        je	     short M002_L_04BE
        mov     si,4
        jmp     short M002_L_04D7
M002_L_04BE:
        cmp     word ptr [bp-6],0
        je	     short M002_L_04C9
        mov     si,3
        jmp     short M002_L_04D7
M002_L_04C9:
        cmp     word ptr [bp-2],0
        je	     short M002_L_04D4
        mov     si,6
        jmp     short M002_L_04D7
M002_L_04D4:
        mov     si,5
M002_L_04D7:
        or	     di,di
        jne     short M002_L_04E2
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_FACTORY
        mov     di,ax
M002_L_04E2:
        mov     ax,word ptr [bp-0Ah]
        mov     word ptr DGROUP:BCC_RD_862E_W,ax
        mov     ax,di
M002_L_04EA:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf
BCC_STMT_BUILD  endp
M002_L_KIND_TABLE:
        dw	     0491h
        dw	     0428h
        dw	     04D7h
        dw	     04D7h
        dw	     04D7h
        dw	     0491h
        dw	     04D7h
        dw	     04D7h
        dw	     04D7h
        dw	     044Dh
        dw	     046Fh
M002_L_TOKEN_TABLE:
        dw	     039Fh
        dw	     03C3h
        dw	     03C3h
        dw	     03C3h
        dw	     01C5h
        dw	     01E0h
        dw	     01FBh
        dw	     0231h
        dw	     0216h
        dw	     0295h
        dw	     02AAh
        dw	     02CAh
        dw	     02BAh
        dw	     02C2h
        dw	     02B2h
        dw	     02F4h
        dw	     02DFh
        dw	     0349h
        dw	     0374h
        dw	     0309h
        dw	     0280h
        dw	     03C3h
        dw	     03C3h
        dw	     03C3h
        dw	     03C3h
        dw	     024Ch
        dw	     0266h
CO046_TEXT	     ends

; END STBUILD
; BEGIN LG0BB (gap	ovr_1cf2_9000:053C)
CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,056h,0FFh,076h,004h,0FFh,036h,09Ch,067h,0B0h,000h  ; ovr_1cf2_9000:053C
   	     db	     050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO04A_TEXT
   	     db	     08Bh,0F0h,00Bh,0F6h,074h,034h,08Eh,006h; ovr_1cf2_9000:054A

   	     db	     0C2h,063h,026h,080h,07Ch,005h,008h,075h,029h,026h,0F7h,044h,006h,010h  ; ovr_1cf2_9000:0558
   	     db	     000h,074h,017h,080h,03Eh,035h,086h,000h,074h,00Bh,0B8h,031h,000h,050h  ; ovr_1cf2_9000:0566
   	     db	     09Ah
   	     dw	     011Bh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     044h,044h,0C6h,006h,035h,086h,009h,08Eh,006h; ovr_1cf2_9000:0574

   	     db	     0C2h,063h,026h,08Bh,044h,008h,0EBh,002h,033h,0C0h,05Eh,05Dh,04Dh,0C2h  ; ovr_1cf2_9000:0582
   	     db	     002h,000h	     ; ovr_1cf2_9000:0590

CO046_TEXT	     ends
; END LG0BB
; BEGIN STALLOC (listing ovr_1cf2_9000:0592)
   	     extrn   X031_0E:far
   	     extrn   BCC_RD_8269_W:word
   	     extrn   BCC_STMT_SCOPE:word
   	     extrn   X04A_0E:far
   	     extrn   X04A_02:far
   	     extrn   X04F_01:far
   	     extrn   BCC_EXPR_CURRENT:word
   	     extrn   BCC_STMT_SAVE:word
   	     extrn   X04A_12:far
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   BCC_STMT_RECORD_SEG:word
   	     extrn   BCC_STMT_ERROR:word
   	     extrn   X019_02:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_OPTION_16F5:byte
   	     extrn   X047_01:far
   	     extrn   BCC_STMT_ALIGNMENT:byte
   	     extrn   X04D_08:far
   	     extrn   BCC_STMT_NAME_CURRENT:word
   	     extrn   X04D_01:far
   	     extrn   BCC_STMT_FACTORY:dword
   	     extrn   BCC_STMT_ALIGN_HOOK:dword
   	     extrn   X04A_13:far
   	     extrn   BCC_STMT_SIZE_HOOK:dword
   	     extrn   BCC_RD_862E_W:word
   	     extrn   BCC_RD_F23E_B:byte
   	     extrn   BCC_RD_16F2_B:byte
   	     extrn   BCC_RD_8624_W:word
   	     extrn   BCC_RD_243E_W:word
   	     extrn   BCC_RD_241E_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_FD3E_B:byte
   	     extrn   BCC_RD_77FD_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M004_BCC_STMT_MESSAGES  equ     37DAh

BCC_STMT_ALLOC  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,18h
        push    si
        push    di
        mov     word ptr [bp-18h],0
        mov     ax,word ptr DGROUP:BCC_RD_8624_W
        mov     word ptr [bp-0Eh],ax
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_05B7
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_05BC
M004_L_05B7:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_05BC:
        cmp     ax,31h
        jne     short M004_L_05DF
        mov     ax,word ptr DGROUP:BCC_RD_8269_W
        mov     word ptr [bp-0Ch],ax
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_05D8
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_05DD
M004_L_05D8:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_05DD:
        jmp     short M004_L_05E4
M004_L_05DF:
        mov     word ptr [bp-0Ch],0
M004_L_05E4:
        cmp     word ptr DGROUP:BCC_RD_603E_W,5
        jne     short M004_L_05EE
        db	     0E9h
        dw	     000CEh
M004_L_05EE:
        cmp     word ptr [bp-0Ch],0
        jne     short M004_L_05F7
        db	     0E9h
        dw	     000A8h
M004_L_05F7:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        jne     short M004_L_060F
        push    word ptr [bp-0Ch]
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        db	     9Ah
        dw	     X04A_0E
        dw	     seg X04A_0E
        jmp     short M004_L_061E
M004_L_060F:
        push    word ptr [bp-0Ch]
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        db	     9Ah
        dw	     X04A_02
        dw	     seg X04A_02
M004_L_061E:
        mov     word ptr [bp-8],ax
        cmp     word ptr [bp-8],0
        jne     short M004_L_0661
        mov     al,byte ptr [bp+4]
        push    ax
        db	     9Ah
        dw	     X04F_01
        dw	     seg X04F_01
        mov     word ptr [bp-4],ax
        mov     ax,word ptr DGROUP:BCC_EXPR_CURRENT
        mov     word ptr DGROUP:BCC_STMT_SAVE,ax
        push    word ptr [bp-0Ch]
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        mov     ax,0Bh
        push    ax
        push    word ptr [bp-4]
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     word ptr es:[bx+7],ax
        db	     0E9h
        dw	     005D5h
M004_L_0661:
        mov     bx,word ptr [bp-8]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     ax,word ptr es:[bx+8]
        mov     word ptr [bp-4],ax
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     al,byte ptr es:[bx+9]
        cbw
        cmp     ax,word ptr [bp+4]
        je	     short M004_L_06B9
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        push    word ptr [bp-0Ch]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,41h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        db	     0E9h
        dw	     00597h
M004_L_069F:
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,0D8h
        push    ax
        nop
        push    cs
        db	     0E8h
        dw	     00841h
        add     sp,6
        mov     word ptr [bp-4],0
        db	     0E9h
        dw	     0057Dh
M004_L_06B9:
        db	     0E9h
        dw	     0057Ah
M004_L_06BC:
        mov     word ptr [bp-14h],0
        mov     word ptr [bp-16h],0
        mov     word ptr [bp-12h],0
        xor     di,di
        cmp     word ptr [bp-0Ch],0
        jne     short M004_L_06D6
        db	     0E9h
        dw	     000A1h
M004_L_06D6:
        push    word ptr [bp-0Ch]
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        db	     9Ah
        dw	     X04A_0E
        dw	     seg X04A_0E
        mov     word ptr [bp-8],ax
        cmp     word ptr [bp-8],0
        jne     short M004_L_0721
        mov     al,byte ptr [bp+4]
        push    ax
        db	     9Ah
        dw	     X04F_01
        dw	     seg X04F_01
        mov     word ptr [bp-4],ax
        push    word ptr [bp-0Ch]
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        mov     ax,0Bh
        push    ax
        push    word ptr [bp-4]
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     word ptr es:[bx+7],ax
        jmp     short M004_L_0770
M004_L_0721:
        mov     bx,word ptr [bp-8]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     ax,word ptr es:[bx+8]
        mov     word ptr [bp-4],ax
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[bx+5],0
        je	     short M004_L_0743
        push    word ptr [bp-0Ch]
        db	     0E8h
        dw	     017DBh
M004_L_0743:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     al,byte ptr es:[bx+9]
        cbw
        cmp     ax,word ptr [bp+4]
        je	     short M004_L_0770
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        push    word ptr [bp-0Ch]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,41h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M004_L_0770:
        mov     word ptr [bp-18h],1
        jmp     short M004_L_079D
M004_L_0777:
        mov     al,byte ptr [bp+4]
        push    ax
        db	     9Ah
        dw	     X04F_01
        dw	     seg X04F_01
        mov     word ptr [bp-4],ax
        xor     ax,ax
        push    ax
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        mov     ax,0Bh
        push    ax
        push    word ptr [bp-4]
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
M004_L_079D:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     word ptr es:[bx+3],1
        db	     0E9h
        dw	     003B0h
M004_L_07AD:
        cmp     byte ptr DGROUP:BCC_OPTION_16F5,1
        jne     short M004_L_07CB
        push    word ptr DGROUP:BCC_RD_8260_W
        push    cs
        db	     0E8h
        dw	     0F95Ch
        or	     ax,ax
        jne     short M004_L_07CB
        mov     ax,0F7h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M004_L_07CB:
        push    cs
        db	     0E8h
        dw	     0F978h
        mov     word ptr [bp-2],ax
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        je	     short M004_L_07F0
        push    ds
        mov     bx,word ptr DGROUP:BCC_RD_241E_W
        shl     bx,1
        push    word ptr [bx+M004_BCC_STMT_MESSAGES]
        mov     ax,102h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M004_L_07F0:
        cmp     word ptr [bp-2],0
        jne     short M004_L_07F9
        db	     0E9h
        dw	     0035Dh
M004_L_07F9:
        cmp     word ptr DGROUP:BCC_RD_603E_W,21h
        je	     short M004_L_0803
        db	     0E9h
        dw	     00106h
M004_L_0803:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_0814
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_0819
M004_L_0814:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_0819:
        mov     ax,2
        push    ax
        db	     9Ah
        dw	     X047_01
        dw	     seg X047_01
        or	     ax,ax
        je	     short M004_L_07F9
        mov     ax,word ptr DGROUP:BCC_RD_8269_W
        mov     word ptr [bp-10h],ax
        cmp     word ptr [bp-10h],10h
        jle     short M004_L_0842
        mov     ax,9Dh
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        mov     word ptr [bp-10h],0
M004_L_0842:
        cmp     word ptr [bp-10h],0
        jne     short M004_L_0871
        cmp     word ptr [bp-12h],0
        je	     short M004_L_089D
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M004_L_0862
        mov     al,byte ptr DGROUP:BCC_STMT_ALIGNMENT
        cbw
        cwd
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],dx
        jmp     short M004_L_086A
M004_L_0862:
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
M004_L_086A:
        mov     word ptr [bp-12h],0
        jmp     short M004_L_089D
M004_L_0871:
        mov     ax,word ptr [bp-12h]
        add     ax,word ptr [bp-10h]
        cmp     ax,10h
        jle     short M004_L_089D
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M004_L_0890
        mov     al,byte ptr DGROUP:BCC_STMT_ALIGNMENT
        cbw
        cwd
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],dx
        jmp     short M004_L_0898
M004_L_0890:
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
M004_L_0898:
        mov     word ptr [bp-12h],0
M004_L_089D:
        mov     ax,word ptr [bp-10h]
        add     word ptr [bp-12h],ax
        mov     al,byte ptr DGROUP:BCC_RD_16F2_B
        cbw
        or	     ax,ax
        jne     short M004_L_08CA
        cmp     word ptr [bp-12h],8
        jle     short M004_L_08CA
        mov     ax,word ptr [bp-12h]
        shr     ax,1
        shr     ax,1
        shr     ax,1
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],0
        mov     ax,word ptr [bp-12h]
        and     ax,7
        mov     word ptr [bp-12h],ax
M004_L_08CA:
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        je	     short M004_L_08F0
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        jne     short M004_L_08DB
        db	     0E9h
        dw	     0027Bh
M004_L_08DB:
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,1Fh
        push    ax
        nop
        push    cs
        db	     0E8h
        dw	     00605h
        add     sp,6
        db	     0E9h
        dw	     00266h
M004_L_08F0:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_0901
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_0906
M004_L_0901:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_0906:
        db	     0E9h
        dw	     0FEF0h
M004_L_0909:
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X04D_08
        dw	     seg X04D_08
        mov     word ptr [bp-6],ax
        cmp     word ptr [bp-6],0
        jne     short M004_L_091D
        db	     0E9h
        dw	     00239h
M004_L_091D:
        mov     ax,word ptr DGROUP:BCC_STMT_NAME_CURRENT
        mov     word ptr [bp-0Ch],ax
        push    word ptr [bp-6]
        push    word ptr [bp-2]
        db	     9Ah
        dw	     X04D_01
        dw	     seg X04D_01
        mov     si,ax
        cmp     word ptr DGROUP:BCC_RD_603E_W,21h
        je	     short M004_L_093A
        db	     0E9h
        dw	     000A8h
M004_L_093A:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_094B
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_0950
M004_L_094B:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_0950:
        mov     ax,2
        push    ax
        db	     9Ah
        dw	     X047_01
        dw	     seg X047_01
        or	     ax,ax
        jne     short M004_L_0960
        db	     0E9h
        dw	     001F6h
M004_L_0960:
        mov     ax,word ptr DGROUP:BCC_RD_8269_W
        mov     word ptr [bp-10h],ax
        cmp     word ptr [bp-10h],0
        jne     short M004_L_0977
        mov     ax,9Eh
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M004_L_0977:
        cmp     word ptr [bp-10h],10h
        jne     short M004_L_097F
        jmp     short M004_L_0990
M004_L_097F:
        cmp     word ptr [bp-10h],10h
        jle     short M004_L_0995
        mov     ax,9Dh
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M004_L_0990:
        mov     word ptr [bp-10h],0
M004_L_0995:
        mov     ax,word ptr [bp-12h]
        add     ax,word ptr [bp-10h]
        cmp     ax,10h
        jle     short M004_L_09C1
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M004_L_09B4
        mov     al,byte ptr DGROUP:BCC_STMT_ALIGNMENT
        cbw
        cwd
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],dx
        jmp     short M004_L_09BC
M004_L_09B4:
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
M004_L_09BC:
        mov     word ptr [bp-12h],0
M004_L_09C1:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[si],6
        jbe     short M004_L_09FC
        mov     ax,70h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        mov     ax,5
        push    ax
        db	     0FFh,1Eh
        dw	     BCC_STMT_FACTORY
        mov     si,ax
        jmp     short M004_L_09FC
M004_L_09E2:
        mov     word ptr [bp-10h],0
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[si],12h
        jne     short M004_L_09FC
        mov     ax,0D3h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M004_L_09FC:
        cmp     word ptr [bp+4],1
        je	     short M004_L_0A05
        db	     0E9h
        dw	     000B0h
M004_L_0A05:
        cmp     word ptr [bp-10h],0
        jne     short M004_L_0A2C
        cmp     word ptr [bp-12h],0
        je	     short M004_L_0A2C
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
        cmp     word ptr [bp-12h],8
        jle     short M004_L_0A27
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
M004_L_0A27:
        mov     word ptr [bp-12h],0
M004_L_0A2C:
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M004_L_0A48
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_ALIGN_HOOK
        push    ax
        mov     ax,word ptr [bp-16h]
        xor     dx,dx
        pop     bx
        div     bx
        add     word ptr [bp-16h],dx
        adc     word ptr [bp-14h],0
M004_L_0A48:
        push    word ptr [bp-0Ch]
        push    di
        push    si
        push    word ptr [bp-16h]
        mov     al,byte ptr [bp-12h]
        push    ax
        mov     al,byte ptr [bp-10h]
        push    ax
        push    word ptr DGROUP:BCC_RD_862E_W
        db	     9Ah
        dw	     X04A_13
        dw	     seg X04A_13
        mov     word ptr [bp-0Ah],ax
        or	     di,di
        jne     short M004_L_0A6B
        mov     di,word ptr [bp-0Ah]
M004_L_0A6B:
        cmp     word ptr [bp-10h],0
        jne     short M004_L_0A80
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],0
        db	     0E9h
        dw	     0009Bh
M004_L_0A80:
        mov     ax,word ptr [bp-10h]
        add     word ptr [bp-12h],ax
        mov     al,byte ptr DGROUP:BCC_RD_16F2_B
        cbw
        or	     ax,ax
        je	     short M004_L_0A91
        db	     0E9h
        dw	     0008Ah
M004_L_0A91:
        cmp     word ptr [bp-12h],8
        jge     short M004_L_0A9A
        db	     0E9h
        dw	     00081h
M004_L_0A9A:
        mov     ax,word ptr [bp-12h]
        shr     ax,1
        shr     ax,1
        shr     ax,1
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],0
        mov     ax,word ptr [bp-12h]
        and     ax,7
        mov     word ptr [bp-12h],ax
        jmp     short M004_L_0B1B
M004_L_0AB5:
        push    word ptr [bp-0Ch]
        push    di
        push    si
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        mov     al,byte ptr [bp-10h]
        push    ax
        push    word ptr DGROUP:BCC_RD_862E_W
        db	     9Ah
        dw	     X04A_13
        dw	     seg X04A_13
        mov     word ptr [bp-0Ah],ax
        or	     di,di
        jne     short M004_L_0AD7
        mov     di,word ptr [bp-0Ah]
M004_L_0AD7:
        cmp     word ptr [bp-10h],0
        jne     short M004_L_0AFF
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        xor     dx,dx
        cmp     dx,word ptr [bp-14h]
        jc	     short M004_L_0B1B
        ja	     short M004_L_0AF0
        cmp     ax,word ptr [bp-16h]
        jbe     short M004_L_0B1B
M004_L_0AF0:
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        mov     word ptr [bp-14h],0
        mov     word ptr [bp-16h],ax
        jmp     short M004_L_0B1B
M004_L_0AFF:
        mov     al,byte ptr DGROUP:BCC_STMT_ALIGNMENT
        cbw
        cwd
        cmp     dx,word ptr [bp-14h]
        jc	     short M004_L_0B1B
        ja	     short M004_L_0B10
        cmp     ax,word ptr [bp-16h]
        jbe     short M004_L_0B1B
M004_L_0B10:
        mov     al,byte ptr DGROUP:BCC_STMT_ALIGNMENT
        cbw
        cwd
        mov     word ptr [bp-14h],dx
        mov     word ptr [bp-16h],ax
M004_L_0B1B:
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        je	     short M004_L_0B3D
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M004_L_0B56
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,1Fh
        push    ax
        nop
        push    cs
        db	     0E8h
        dw	     003B7h
        add     sp,6
        jmp     short M004_L_0B56
M004_L_0B3D:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_0B4E
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_0B53
M004_L_0B4E:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_0B53:
        db	     0E9h
        dw	     0FCA3h
M004_L_0B56:
        cmp     word ptr DGROUP:BCC_RD_603E_W,6
        je	     short M004_L_0B82
M004_L_0B5D:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_0B6E
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_0B73
M004_L_0B6E:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_0B73:
        cmp     ax,6
        je	     short M004_L_0B82
        cmp     word ptr DGROUP:BCC_RD_603E_W,0
        je	     short M004_L_0B82
        db	     0E9h
        dw	     0FC2Bh
M004_L_0B82:
        cmp     word ptr [bp-12h],0
        je	     short M004_L_0BA6
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M004_L_0B9C
        mov     al,byte ptr DGROUP:BCC_STMT_ALIGNMENT
        cbw
        cwd
        add     word ptr [bp-16h],ax
        adc     word ptr [bp-14h],dx
        jmp     short M004_L_0BC3
M004_L_0B9C:
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
        jmp     short M004_L_0BC3
M004_L_0BA6:
        mov     ax,word ptr [bp-16h]
        or	     ax,word ptr [bp-14h]
        jne     short M004_L_0BC3
        mov     ax,10Ah
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        mov     word ptr [bp-14h],0
        mov     word ptr [bp-16h],1
M004_L_0BC3:
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M004_L_0BDC
        add     word ptr [bp-16h],1
        adc     word ptr [bp-14h],0
        db	     81h,66h,0EAh
        dw	     0FFFEh
        db	     81h,66h,0ECh
        dw	     0FFFFh
M004_L_0BDC:
        mov     ax,word ptr [bp-14h]
        mov     dx,word ptr [bp-16h]
        db	     81h,0E2h
        dw	     0
        and     ax,0FFFFh
        or	     dx,ax
        je	     short M004_L_0C02
        mov     ax,57h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        mov     word ptr [bp-14h],0
        mov     word ptr [bp-16h],1
M004_L_0C02:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr [bp-16h]
        mov     word ptr es:[bx+3],ax
        mov     word ptr es:[bx+5],di
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M004_L_0C25
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M004_L_0C2A
M004_L_0C25:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M004_L_0C2A:
        cmp     word ptr [bp-18h],0
        je	     short M004_L_0C36
        mov     ax,word ptr DGROUP:BCC_EXPR_CURRENT
        mov     word ptr DGROUP:BCC_STMT_SAVE,ax
M004_L_0C36:
        mov     ax,word ptr [bp-0Eh]
        mov     word ptr DGROUP:BCC_RD_8624_W,ax
        mov     ax,word ptr [bp-4]
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     2
BCC_STMT_ALLOC  endp
CO046_TEXT	     ends

; Target-qualified	reference aliases (zero	bytes)
BCC_RN_9000_053C	     equ     BCC_STMT_ALLOC-56h
; END STALLOC
; BEGIN STLOOK (listing ovr_1cf2_9000:0C48)
   	     extrn   X031_0E:far
   	     extrn   BCC_STMT_SCOPE:word
   	     extrn   X04A_0E:far
   	     extrn   X04F_13:far
   	     extrn   X04A_12:far
   	     extrn   BCC_STMT_RECORD_SEG:word
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   X047_01:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_OPTION_1700:byte
   	     extrn   BCC_RD_77E2_W:word
   	     extrn   X04A_13:far
   	     extrn   X04A_02:far
   	     extrn   BCC_EXPR_CURRENT:word
   	     extrn   BCC_STMT_SAVE:word
   	     extrn   BCC_RD_643E_B:byte
   	     extrn   BCC_RD_1764_B:byte
   	     extrn   BCC_RD_693E_W:word
   	     extrn   BCC_RD_8269_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_FD3E_B:byte
   	     extrn   BCC_RD_77FD_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M005_BCC_STMT_ENUM_PREV equ     39A4h

BCC_STMT_LOOKUP proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,0Ch
        push    si
        push    di
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M005_L_0C62
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M005_L_0C67
M005_L_0C62:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M005_L_0C67:
        cmp     ax,31h
        jne     short M005_L_0C88
        mov     di,word ptr DGROUP:BCC_RD_693E_W
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M005_L_0C81
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M005_L_0C86
M005_L_0C81:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M005_L_0C86:
        jmp     short M005_L_0C8A
M005_L_0C88:
        xor     di,di
M005_L_0C8A:
        mov     word ptr [bp-6],0
        cmp     word ptr DGROUP:BCC_RD_603E_W,5
        je	     short M005_L_0C99
        db	     0E9h
        dw	     001CEh
M005_L_0C99:
        or	     di,di
        je	     short M005_L_0CFA
        push    di
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        db	     9Ah
        dw	     X04A_0E
        dw	     seg X04A_0E
        mov     word ptr [bp-4],ax
        cmp     word ptr [bp-4],0
        jne     short M005_L_0CD8
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X04F_13
        dw	     seg X04F_13
        mov     word ptr [bp-2],ax
        push    di
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        mov     ax,0Bh
        push    ax
        push    word ptr [bp-2]
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        jmp     short M005_L_0D05
M005_L_0CD8:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     ax,word ptr es:[bx+8]
        mov     word ptr [bp-2],ax
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[bx+5],0
        je	     short M005_L_0D05
        push    di
        db	     0E8h
        dw	     01226h
        jmp     short M005_L_0D05
M005_L_0CFA:
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X04F_13
        dw	     seg X04F_13
        mov     word ptr [bp-2],ax
M005_L_0D05:
        mov     si,0FFFFh
        mov     word ptr [bp-0Ah],0
        mov     word ptr [bp-0Ch],0
        db	     0E9h
        dw	     000D0h
M005_L_0D15:
        cmp     word ptr DGROUP:BCC_RD_603E_W,31h
        je	     short M005_L_0D1F
        db	     0E9h
        dw	     000E4h
M005_L_0D1F:
        mov     di,word ptr DGROUP:BCC_RD_693E_W
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M005_L_0D34
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M005_L_0D39
M005_L_0D34:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M005_L_0D39:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        jne     short M005_L_0D65
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M005_L_0D51
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M005_L_0D56
M005_L_0D51:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M005_L_0D56:
        mov     ax,4
        push    ax
        db	     9Ah
        dw	     X047_01
        dw	     seg X047_01
        mov     si,word ptr DGROUP:BCC_RD_8269_W
        jmp     short M005_L_0D80
M005_L_0D65:
        mov     ax,si
        cwd
        cmp     dx,word ptr DGROUP:M005_BCC_STMT_ENUM_PREV+2
        jne     short M005_L_0D7F
        cmp     ax,word ptr DGROUP:M005_BCC_STMT_ENUM_PREV
        jne     short M005_L_0D7F
        mov     ax,4Bh
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M005_L_0D7F:
        inc     si
M005_L_0D80:
        push    di
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,0
        push    ax
        mov     ax,9
        push    ax
        push    word ptr [bp-2]
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     word ptr [bp-4],ax
        cmp     byte ptr DGROUP:BCC_OPTION_1700,0
        je	     short M005_L_0DC3
        push    di
        push    word ptr [bp-6]
        push    word ptr DGROUP:BCC_RD_77E2_W
        push    si
        mov     al,0
        push    ax
        push    ax
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X04A_13
        dw	     seg X04A_13
        mov     word ptr [bp-8],ax
        cmp     word ptr [bp-6],0
        jne     short M005_L_0DC3
        mov     word ptr [bp-6],ax
M005_L_0DC3:
        cmp     si,word ptr [bp-0Ah]
        jge     short M005_L_0DCB
        mov     word ptr [bp-0Ah],si
M005_L_0DCB:
        cmp     si,word ptr [bp-0Ch]
        jle     short M005_L_0DD3
        mov     word ptr [bp-0Ch],si
M005_L_0DD3:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     word ptr es:[bx+0Eh],si
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        jne     short M005_L_0E03
M005_L_0DE5:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M005_L_0DF6
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M005_L_0DFB
M005_L_0DF6:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M005_L_0DFB:
        cmp     ax,6
        je	     short M005_L_0E03
        db	     0E9h
        dw	     0FF12h
M005_L_0E03:
        cmp     word ptr DGROUP:BCC_RD_603E_W,6
        je	     short M005_L_0E21
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,28h
        push    ax
        nop
        push    cs
        db	     0E8h
        dw	     000D6h
        add     sp,6
        xor     ax,ax
        db	     0E9h
        dw	     000C7h
M005_L_0E21:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M005_L_0E32
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M005_L_0E37
M005_L_0E32:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M005_L_0E37:
        cmp     byte ptr DGROUP:BCC_RD_643E_B,0
        jne     short M005_L_0E57
        cmp     word ptr [bp-0Ah],-80h
        jl	     short M005_L_0E57
        cmp     word ptr [bp-0Ch],7Fh
        jg	     short M005_L_0E57
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     word ptr es:[bx+3],1
M005_L_0E57:
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr [bp-6]
        mov     word ptr es:[bx+5],ax
        jmp     short M005_L_0EDF
M005_L_0E67:
        or	     di,di
        je	     short M005_L_0EC9
        push    di
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        db	     9Ah
        dw	     X04A_02
        dw	     seg X04A_02
        mov     word ptr [bp-4],ax
        cmp     word ptr [bp-4],0
        jne     short M005_L_0EB9
        mov     al,byte ptr DGROUP:BCC_RD_1764_B
        cbw
        or	     ax,ax
        jne     short M005_L_0E94
        mov     ax,0CEh
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M005_L_0E94:
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X04F_13
        dw	     seg X04F_13
        mov     word ptr [bp-2],ax
        push    di
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,2
        push    ax
        mov     ax,0Bh
        push    ax
        push    word ptr [bp-2]
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        jmp     short M005_L_0EDF
M005_L_0EB9:
        mov     bx,word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     ax,word ptr es:[bx+8]
        mov     word ptr [bp-2],ax
        jmp     short M005_L_0EDF
M005_L_0EC9:
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,28h
        push    ax
        nop
        push    cs
        db	     0E8h
        dw	     00017h
        add     sp,6
        xor     ax,ax
        jmp     short M005_L_0EE8
M005_L_0EDF:
        mov     ax,word ptr DGROUP:BCC_EXPR_CURRENT
        mov     word ptr DGROUP:BCC_STMT_SAVE,ax
        mov     ax,word ptr [bp-2]
M005_L_0EE8:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret
BCC_STMT_LOOKUP endp
CO046_TEXT	     ends

; END STLOOK
; BEGIN STERR (listing ovr_1cf2_9000:0EEF)

   	     extrn   BCC_RD_77D3_W:word
   	     extrn   BCC_STMT_DIAG_LINE:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_STMT_RECOVERY:byte
   	     extrn   X031_0E:far
   	     extrn   X031_0B:far
   	     extrn   BCC_RD_FD3E_B:byte
   	     extrn   BCC_RD_77FD_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

   	     public  X046_09
X046_09 label   far
BCC_STMT_ERROR_NEAR     proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     ax,word ptr DGROUP:BCC_RD_77D3_W
        mov     word ptr DGROUP:BCC_STMT_DIAG_LINE,ax
        mov     si,word ptr DGROUP:BCC_RD_8260_W
        push    word ptr [bp+0Ah]
        push    word ptr [bp+8]
        push    word ptr [bp+6]
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        cmp     byte ptr DGROUP:BCC_STMT_RECOVERY,0
        je	     short M006_L_0F3F
        jmp     short M006_L_0F30
M006_L_0F18:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M006_L_0F29
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M006_L_0F2E
M006_L_0F29:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M006_L_0F2E:
        mov     si,ax
M006_L_0F30:
        or	     si,si
        jne     short M006_L_0F37
        db	     0E9h
        dw	     000A3h
M006_L_0F37:
        cmp     si,0Ah
        jne     short M006_L_0F18
        db	     0E9h
        dw	     0009Bh
M006_L_0F3F:
        cmp     si,6
        jne     short M006_L_0FBF
        db	     0E9h
        dw	     0008Eh
M006_L_0F47:
        cmp     si,5
        jne     short M006_L_0F94
        mov     di,1
M006_L_0F4F:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M006_L_0F60
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M006_L_0F65
M006_L_0F60:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M006_L_0F65:
        mov     si,ax
        mov     ax,word ptr DGROUP:BCC_RD_77D3_W
        mov     word ptr DGROUP:BCC_STMT_DIAG_LINE,ax
        or	     si,si
        je	     short M006_L_0FDA
        cmp     si,6
        jne     short M006_L_0F7D
        dec     di
        or	     di,di
        jg	     short M006_L_0F4F
        jmp     short M006_L_0FA1
M006_L_0F7D:
        cmp     si,5
        jne     short M006_L_0F85
        inc     di
        jmp     short M006_L_0F4F
M006_L_0F85:
        cmp     si,34h
        jne     short M006_L_0F4F
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X031_0B
        dw	     seg X031_0B
        jmp     short M006_L_0F4F
M006_L_0F94:
        cmp     si,34h
        jne     short M006_L_0FA1
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X031_0B
        dw	     seg X031_0B
M006_L_0FA1:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M006_L_0FB2
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M006_L_0FB7
M006_L_0FB2:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M006_L_0FB7:
        mov     si,ax
        mov     ax,word ptr DGROUP:BCC_RD_77D3_W
        mov     word ptr DGROUP:BCC_STMT_DIAG_LINE,ax
M006_L_0FBF:
        or	     si,si
        je	     short M006_L_0FD0
        cmp     si,7
        je	     short M006_L_0FD0
        cmp     si,6
        je	     short M006_L_0FD0
        db	     0E9h
        dw	     0FF77h
M006_L_0FD0:
        cmp     si,6
        jne     short M006_L_0FDA
M006_L_0FD5:
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
M006_L_0FDA:
        pop     di
        pop     si
        pop     bp
        retf
BCC_STMT_ERROR_NEAR     endp
CO046_TEXT	     ends

; END STERR
; BEGIN STWRAP (listing ovr_1cf2_9000:0FDE)

   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_243E_W:word
   	     extrn   BCC_RD_8624_W:word


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

   	     public  X046_01
X046_01 label   far
BCC_STMT_DECL_PARSE     proc    far
        push    bp
        mov     bp,sp
        push    si
        push    cs
        db	     0E8h,061h,0F1h
        mov     si,ax
        or	     si,si
        je	     short M007_L_100B
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        jne     short M007_L_0FF9
        mov     word ptr DGROUP:BCC_RD_8624_W,5
M007_L_0FF9:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M007_L_100B
        push    word ptr DGROUP:BCC_RD_8624_W
        push    si
        xor     ax,ax
        push    ax
        db	     0E8h,003h,000h
M007_L_100B:
        pop     si
        pop     bp
        retf
BCC_STMT_DECL_PARSE     endp
CO046_TEXT	     ends

; END STWRAP
; BEGIN STPARSE (listing ovr_1cf2_9000:100E)

   	     extrn   BCC_RD_203E_W:word
   	     extrn   BCC_STMT_NAME_CURRENT:word
   	     extrn   BCC_STMT_FLAGS_EXTRA:word
   	     extrn   X04D_08:far
   	     extrn   X04D_07:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_RD_77E2_W:word
   	     extrn   X04D_01:far
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   BCC_STMT_SCOPE:word
   	     extrn   BCC_STMT_GLOBAL_SCOPE:word
   	     extrn   BCC_OPTION_16F5:byte
   	     extrn   X04A_12:far
   	     extrn   X031_0E:far
   	     extrn   BCC_STMT_ERROR:word
   	     extrn   BCC_STMT_RECORD_SEG:word
   	     extrn   X019_02:far
   	     extrn   BCC_STMT_LINKAGE:word
   	     extrn   BCC_STMT_LANGUAGE:word
   	     extrn   BCC_OPTION_1705:byte
   	     extrn   BCC_OPTION_16EF:byte
   	     extrn   BCC_STMT_DEFINE_COUNT:word
   	     extrn   X04F_05:far
   	     extrn   X035_02:far
   	     extrn   BCC_STMT_CURRENT:word
   	     extrn   BCC_STMT_SIZE_HOOK:dword
   	     extrn   BCC_OPTION_177B:byte
   	     extrn   BCC_STMT_OPTIMIZE:byte
   	     extrn   BCC_STMT_LIMIT:word
   	     extrn   X060_02:far
   	     extrn   BCC_OPTION_1708:byte
   	     extrn   X05A_01:far
   	     extrn   BCC_STMT_HOOK_D8:dword
   	     extrn   BCC_RD_F23E_B:byte
   	     extrn   BCC_STMT_ALIGN_HOOK:dword
   	     extrn   BCC_STMT_HOOK_D4:dword
   	     extrn   BCC_STMT_HOOK_D0:dword
   	     extrn   X05A_00:far
   	     extrn   BCC_DIAGNOSTIC_ALT:far
   	     extrn   BCC_STMT_HOOK_DC:dword
   	     extrn   BCC_RD_793E_B:byte
   	     extrn   BCC_RD_1779_B:byte
   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_FD3E_B:byte
   	     extrn   BCC_RD_77FD_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M008_BCC_STMT_MESSAGE   equ     37A4h

BCC_RN_9000_100E	     label   near
BCC_STMT_PARSE_NEXT     proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,14h
        push    si
        push    di
        cmp     word ptr [bp+8],0Dh
        jne     short M008_L_1029
        mov     word ptr [bp-0Ah],8
        mov     word ptr [bp+8],5
        jmp     short M008_L_102E
M008_L_1029:
        mov     word ptr [bp-0Ah],0
M008_L_102E:
        mov     ax,word ptr DGROUP:BCC_STMT_FLAGS_EXTRA
        mov     word ptr [bp-8],ax
M008_L_1034:
        mov     ax,word ptr [bp-8]
        mov     word ptr DGROUP:BCC_STMT_FLAGS_EXTRA,ax
        push    word ptr [bp+4]
        db	     9Ah
        dw	     X04D_08
        dw	     seg X04D_08
        mov     word ptr [bp-6],ax
        xor     di,di
        cmp     word ptr [bp-6],0
        jne     short M008_L_1052
        xor     ax,ax
        db	     0E9h
        dw	     00666h
M008_L_1052:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M008_L_1067
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        je	     short M008_L_1067
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        jne     short M008_L_1084
M008_L_1067:
        cmp     word ptr [bp+6],0
        jne     short M008_L_1084
        push    word ptr [bp-6]
        db	     9Ah
        dw	     X04D_07
        dw	     seg X04D_07
        or	     ax,ax
        je	     short M008_L_1084
        mov     ax,0F7h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M008_L_1084:
        cmp     word ptr [bp+6],0
        jne     short M008_L_1090
        mov     ax,word ptr DGROUP:BCC_RD_77E2_W
        mov     word ptr [bp+6],ax
M008_L_1090:
        push    word ptr [bp-6]
        push    word ptr [bp+6]
        db	     9Ah
        dw	     X04D_01
        dw	     seg X04D_01
        mov     word ptr [bp-2],ax
        mov     ax,word ptr [bp+8]
        mov     word ptr [bp-4],ax
        cmp     word ptr [bp+8],8
        jne     short M008_L_10CA
        cmp     word ptr DGROUP:BCC_RD_203E_W,9
        je	     short M008_L_10B4
        db	     0E9h
        dw	     002E8h
M008_L_10B4:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-2]
        cmp     byte ptr es:[bx],12h
        jne     short M008_L_10C4
        db	     0E9h
        dw	     002D8h
M008_L_10C4:
        mov     di,10h
        db	     0E9h
        dw	     002D2h
M008_L_10CA:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-2]
        cmp     byte ptr es:[bx],12h
        je	     short M008_L_10DA
        db	     0E9h
        dw	     0012Ah
M008_L_10DA:
        mov     ax,word ptr DGROUP:BCC_STMT_SCOPE
        cmp     ax,word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        jne     short M008_L_10F5
        cmp     word ptr [bp+4],0
        je	     short M008_L_10F5
        cmp     word ptr DGROUP:BCC_RD_603E_W,5
        jne     short M008_L_10F5
        nop
        push    cs
        db	     0E8h
        dw	     00B10h
M008_L_10F5:
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        test    byte ptr es:[bx+8],1
        je	     short M008_L_1108
        mov     di,10h
        jmp     short M008_L_110B
M008_L_1108:
        mov     di,4
M008_L_110B:
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[bx+7],2
        jne     short M008_L_1120
        or	     word ptr [bp-0Ah],400h
        jmp     short M008_L_1133
M008_L_1120:
        mov     bx,word ptr [bp-2]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[bx+7],3
        jne     short M008_L_1133
        or	     word ptr [bp-0Ah],2000h
M008_L_1133:
        mov     ax,word ptr DGROUP:BCC_STMT_SCOPE
        cmp     ax,word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        je	     short M008_L_116B
        cmp     word ptr [bp+4],0
        je	     short M008_L_116B
        cmp     byte ptr DGROUP:BCC_OPTION_16F5,1
        jne     short M008_L_115C
        mov     ax,word ptr [bp+6]
        cmp     ax,word ptr [bp-2]
        jne     short M008_L_115C
        mov     ax,0F3h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M008_L_115C:
        push    word ptr [bp+8]
        push    word ptr [bp-2]
        push    word ptr [bp-0Ah]
        db	     0E8h
        dw	     00563h
        db	     0E9h
        dw	     0054Dh
M008_L_116B:
        cmp     word ptr [bp+8],3
        jne     short M008_L_118F
        cmp     word ptr [bp+4],0
        jne     short M008_L_1194
        push    ds
        mov     ax,M008_BCC_STMT_MESSAGE
        push    ax
        mov     ax,102h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        mov     word ptr [bp-4],2
        jmp     short M008_L_1194
M008_L_118F:
        mov     word ptr [bp-4],2
M008_L_1194:
        push    word ptr DGROUP:BCC_STMT_NAME_CURRENT
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,0
        push    ax
        push    word ptr [bp-4]
        push    word ptr [bp-2]
        xor     ax,ax
        push    ax
        mov     ax,word ptr [bp-0Ah]
        or	     ax,di
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     si,ax
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        jne     short M008_L_11D5
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M008_L_11CD
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M008_L_11D2
M008_L_11CD:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M008_L_11D2:
        db	     0E9h
        dw	     0FE5Fh
M008_L_11D5:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M008_L_1201
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,0Ah
        push    ax
        push    cs
        db	     0E8h
        dw	     0FCF6h
        add     sp,6
        xor     ax,ax
        db	     0E9h
        dw	     004B7h
M008_L_1201:
        db	     0E9h
        dw	     004B1h
M008_L_1204:
        mov     ax,word ptr DGROUP:BCC_STMT_LINKAGE
        mov     word ptr [bp-0Ch],ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-2]
        cmp     byte ptr es:[bx],13h
        jne     short M008_L_121C
        db	     81h,66h,0F6h,0F7h,0FFh
M008_L_121C:
        mov     bx,word ptr [bp-4]
        dec     bx
        cmp     bx,4
        jbe     short M008_L_1228
        db	     0E9h
        dw	     00174h
M008_L_1228:
        shl     bx,1
        db	     2Eh,0FFh,0A7h
        dw	     16C1h
M008_L_122F:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        je	     short M008_L_1287
        cmp     word ptr DGROUP:BCC_STMT_LANGUAGE,2
        jne     short M008_L_123F
        jmp     short M008_L_124D
M008_L_123F:
        cmp     word ptr DGROUP:BCC_STMT_LANGUAGE,0
        jne     short M008_L_1251
        cmp     byte ptr DGROUP:BCC_OPTION_1705,1
        jne     short M008_L_1251
M008_L_124D:
        or	     di,400h
M008_L_1251:
        cmp     word ptr DGROUP:BCC_RD_203E_W,8
        jne     short M008_L_125F
        db	     81h,0CFh,4,0
        db	     0E9h
        dw	     0013Dh
M008_L_125F:
        cmp     word ptr DGROUP:BCC_RD_203E_W,9
        je	     short M008_L_1274
        cmp     byte ptr DGROUP:BCC_OPTION_16EF,5
        je	     short M008_L_1274
        cmp     word ptr DGROUP:BCC_STMT_DEFINE_COUNT,0
        je	     short M008_L_1280
M008_L_1274:
        db	     81h,0CFh,10h,0
        mov     word ptr [bp-0Ch],0FFFFh
        db	     0E9h
        dw	     0011Ch
M008_L_1280:
        db	     81h,0CFh,4,0
        db	     0E9h
        dw	     00115h
M008_L_1287:
        cmp     word ptr [bp+4],0
        jne     short M008_L_12A3
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,87h
        push    ax
        push    cs
        db	     0E8h
        dw	     0FC54h
        add     sp,6
        xor     ax,ax
        db	     0E9h
        dw	     00415h
M008_L_12A3:
        mov     word ptr [bp-4],1
M008_L_12A8:
        cmp     word ptr DGROUP:BCC_STMT_LANGUAGE,2
        jne     short M008_L_12B1
        jmp     short M008_L_12BF
M008_L_12B1:
        cmp     word ptr DGROUP:BCC_STMT_LANGUAGE,0
        jne     short M008_L_12C3
        cmp     byte ptr DGROUP:BCC_OPTION_1705,1
        jne     short M008_L_12C3
M008_L_12BF:
        or	     di,400h
M008_L_12C3:
        mov     ax,word ptr DGROUP:BCC_STMT_SCOPE
        cmp     ax,word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        je	     short M008_L_12D5
        db	     81h,0CFh,20h,0
        mov     word ptr [bp-4],4
M008_L_12D5:
        cmp     word ptr DGROUP:BCC_RD_203E_W,9
        jne     short M008_L_1323
        cmp     byte ptr DGROUP:BCC_RD_793E_B,0
        je	     short M008_L_12F7
        cmp     word ptr [bp-4],1
        jne     short M008_L_12F7
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        je	     short M008_L_12F7
        mov     word ptr [bp-0Ch],0FFFFh
        jmp     short M008_L_131D
M008_L_12F7:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-2]
        cmp     byte ptr es:[bx],11h
        jne     short M008_L_1315
        cmp     byte ptr es:[bx+9],0
        je	     short M008_L_1315
        push    word ptr [bp-2]
        db	     9Ah
        dw	     X04F_05
        dw	     seg X04F_05
        jmp     short M008_L_131A
M008_L_1315:
        db	     9Ah
        dw	     X035_02
        dw	     seg X035_02
M008_L_131A:
        mov     word ptr [bp-0Ch],ax
M008_L_131D:
        db	     81h,0CFh,10h,0
        jmp     short M008_L_1348
M008_L_1323:
        cmp     word ptr DGROUP:BCC_STMT_DEFINE_COUNT,0
        je	     short M008_L_1337
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        je	     short M008_L_1337
        db	     81h,0CFh,10h,0
        jmp     short M008_L_1348
M008_L_1337:
        db	     81h,0CFh,4,0
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        jne     short M008_L_1348
        mov     ax,word ptr DGROUP:BCC_STMT_CURRENT
        mov     word ptr [bp-0Ch],ax
M008_L_1348:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        jne     short M008_L_139C
        db	     81h,0CFh,20h,0
        jmp     short M008_L_139C
M008_L_1355:
        cmp     word ptr DGROUP:BCC_RD_203E_W,0
        je	     short M008_L_1367
        mov     ax,31h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
M008_L_1367:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        jne     short M008_L_1374
        db	     81h,0CFh,24h,0
        jmp     short M008_L_139C
M008_L_1374:
        push    word ptr [bp-2]
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        or	     ax,ax
        jne     short M008_L_139C
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        push    word ptr DGROUP:BCC_STMT_NAME_CURRENT
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,109h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M008_L_139C:
        cmp     byte ptr DGROUP:BCC_OPTION_177B,0
        je	     short M008_L_140D
        cmp     byte ptr DGROUP:BCC_STMT_OPTIMIZE,0
        je	     short M008_L_140D
        cmp     word ptr DGROUP:BCC_RD_203E_W,8
        je	     short M008_L_140D
        test    di,10h
        jne     short M008_L_140D
        cmp     word ptr [bp-4],2
        jne     short M008_L_13BF
        jmp     short M008_L_1400
M008_L_13BF:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        je	     short M008_L_13D4
        mov     al,byte ptr DGROUP:BCC_RD_1779_B
        cbw
        or	     ax,ax
        jne     short M008_L_13F3
        cmp     word ptr [bp-4],1
        jne     short M008_L_13F3
M008_L_13D4:
        push    word ptr [bp-2]
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        cmp     ax,word ptr DGROUP:BCC_STMT_LIMIT
        jc	     short M008_L_140D
        db	     9Ah
        dw	     X035_02
        dw	     seg X035_02
        mov     word ptr [bp-0Ch],ax
        db	     81h,0E7h,0FBh,0FFh
        db	     81h,0CFh,10h,0
        jmp     short M008_L_140D
M008_L_13F3:
        cmp     word ptr [bp-4],1
        jne     short M008_L_140D
        cmp     byte ptr DGROUP:BCC_RD_793E_B,0
        je	     short M008_L_140D
M008_L_1400:
        mov     word ptr [bp-0Ch],0FFFFh
        db	     81h,0E7h,0FBh,0FFh
        db	     81h,0CFh,10h,0
M008_L_140D:
        push    word ptr DGROUP:BCC_STMT_NAME_CURRENT
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,0
        push    ax
        push    word ptr [bp-4]
        push    word ptr [bp-2]
        push    word ptr [bp-0Ch]
        mov     ax,word ptr [bp-0Ah]
        or	     ax,di
        or	     ax,word ptr DGROUP:BCC_STMT_FLAGS_EXTRA
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     si,ax
        cmp     word ptr [bp-4],5
        je	     short M008_L_143E
        cmp     word ptr [bp-4],6
        jne     short M008_L_1460
M008_L_143E:
        push    si
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-2]
        mov     al,byte ptr es:[bx]
        push    ax
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     al,byte ptr es:[si+6]
        push    ax
        db	     9Ah
        dw	     X060_02
        dw	     seg X060_02
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     word ptr es:[si+0Ah],ax
M008_L_1460:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0Bh
        je	     short M008_L_146A
        db	     0E9h
        dw	     00169h
M008_L_146A:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M008_L_147B
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M008_L_1480
M008_L_147B:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M008_L_1480:
        cmp     word ptr [bp-4],1
        je	     short M008_L_1495
        cmp     word ptr [bp-4],4
        je	     short M008_L_1495
        cmp     word ptr [bp-4],3
        je	     short M008_L_1495
        db	     0E9h
        dw	     00128h
M008_L_1495:
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        and     word ptr es:[si+6],0F7FFh
        test    word ptr es:[si+6],1
        je	     short M008_L_14F6
        cmp     byte ptr DGROUP:BCC_OPTION_1708,0
        je	     short M008_L_14F6
        cmp     word ptr [bp-4],4
        je	     short M008_L_14F6
        mov     bx,word ptr es:[si+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[bx],11h
        jne     short M008_L_14F6
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     bx,word ptr es:[si+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr es:[bx+7]
        cmp     byte ptr es:[bx],2
        ja	     short M008_L_14F6
        mov     word ptr [bp-10h],1
        db	     9Ah
        dw	     X05A_01
        dw	     seg X05A_01
        mov     word ptr [bp-14h],ax
        mov     word ptr [bp-12h],2
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     word ptr es:[si+0Ch],0
        jmp     short M008_L_1529
M008_L_14F6:
        mov     word ptr [bp-12h],1
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+0Ch]
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_D8
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M008_L_151F
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+8]
        db	     0FFh,1Eh
        dw	     BCC_STMT_ALIGN_HOOK
        push    ax
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_D4
M008_L_151F:
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_D0
        mov     word ptr [bp-10h],0
M008_L_1529:
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+8]
        mov     ax,1
        push    ax
        push    word ptr [bp-12h]
        nop
        push    cs
        db	     0E8h
        dw	     00A52h
        mov     word ptr [bp-0Eh],ax
        cmp     word ptr [bp-10h],0
        je	     short M008_L_1556
        push    word ptr [bp-14h]
        db	     9Ah
        dw	     X05A_00
        dw	     seg X05A_00
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     word ptr es:[si+0Eh],ax
M008_L_1556:
        cmp     word ptr [bp-0Eh],0
        je	     short M008_L_15B0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     ax,word ptr [bp-0Eh]
        mov     word ptr es:[si+8],ax
        cmp     byte ptr DGROUP:BCC_OPTION_177B,0
        je	     short M008_L_15B0
        cmp     byte ptr DGROUP:BCC_STMT_OPTIMIZE,0
        je	     short M008_L_15B0
        cmp     word ptr DGROUP:BCC_RD_203E_W,8
        je	     short M008_L_15B0
        test    di,10h
        jne     short M008_L_15B0
        push    word ptr [bp-0Eh]
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        cmp     ax,word ptr DGROUP:BCC_STMT_LIMIT
        jc	     short M008_L_15B0
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,188h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC_ALT
        dw	     seg BCC_DIAGNOSTIC_ALT
        add     sp,6
M008_L_15B0:
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        or	     word ptr es:[si+6],240h
        db	     0E9h
        dw	     000A2h
M008_L_15BD:
        cmp     word ptr [bp-4],5
        je	     short M008_L_15CC
        cmp     word ptr [bp-4],0Dh
        je	     short M008_L_15CC
        db	     0E9h
        dw	     00093h
M008_L_15CC:
        push    si
        db	     0E8h
        dw	     0130Fh
        db	     0E9h
        dw	     0008Ch
M008_L_15D3:
        cmp     word ptr [bp-4],4
        jne     short M008_L_1643
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+0Ch]
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_D8
        cmp     byte ptr DGROUP:BCC_RD_F23E_B,0
        je	     short M008_L_15FD
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+8]
        db	     0FFh,1Eh
        dw	     BCC_STMT_ALIGN_HOOK
        push    ax
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_D4
M008_L_15FD:
        push    si
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_D0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+8]
        db	     0FFh,1Eh
        dw	     BCC_STMT_SIZE_HOOK
        mov     word ptr [bp-0Eh],ax
        cmp     word ptr [bp-0Eh],0
        jne     short M008_L_163A
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,109h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        jmp     short M008_L_165F
M008_L_163A:
        push    word ptr [bp-0Eh]
        db	     0FFh,1Eh
        dw	     BCC_STMT_HOOK_DC
        jmp     short M008_L_165F
M008_L_1643:
        cmp     byte ptr DGROUP:BCC_RD_793E_B,0
        je	     short M008_L_165F
        cmp     word ptr [bp-4],1
        jne     short M008_L_165F
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     byte ptr es:[si+5],2
        or	     word ptr es:[si+6],800h
M008_L_165F:
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        jne     short M008_L_167F
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M008_L_1677
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M008_L_167C
M008_L_1677:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M008_L_167C:
        db	     0E9h
        dw	     0F9B5h
M008_L_167F:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M008_L_16B5
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        cmp     word ptr [bp-4],8
        jne     short M008_L_16A6
        mov     ax,0CAh
        jmp     short M008_L_16A9
M008_L_16A6:
        mov     ax,0Ah
M008_L_16A9:
        push    ax
        push    cs
        db	     0E8h
        dw	     0F841h
        add     sp,6
        xor     ax,ax
        jmp     short M008_L_16B8
M008_L_16B5:
        mov     ax,1
M008_L_16B8:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     6
BCC_STMT_PARSE_NEXT     endp
        dw	     12A8h
        dw	     122Fh
        dw	     12C3h
        dw	     139Ch
        dw	     1355h
CO046_TEXT	     ends

; Target-qualified	reference aliases (zero	bytes)
; END STPARSE
; BEGIN STMEMBER (listing ovr_1cf2_9000:16CB)

   	     extrn   BCC_STMT_NAME_CURRENT:word
   	     extrn   BCC_STMT_GLOBAL_SCOPE:word
   	     extrn   X04A_12:far
   	     extrn   BCC_STMT_MEMBER_FLAGS:word
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   BCC_STMT_PARSE_MODE:byte
   	     extrn   BCC_STMT_ERROR:word
   	     extrn   BCC_STMT_RECORD_SEG:word
   	     extrn   X019_02:far
   	     extrn   BCC_STMT_NAME_BUILD:far
   	     extrn   BCC_STMT_NAME_BUFFER:dword
   	     extrn   X043_02:far
   	     extrn   X057_00:far
   	     extrn   BCC_STMT_CONTEXT_A:word
   	     extrn   BCC_STMT_CONTEXT_B:word
   	     extrn   BCC_STMT_CONTEXT_C:word
   	     extrn   BCC_STMT_CONTEXT_D:word
   	     extrn   BCC_STMT_NODE_CURRENT:word
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_STMT_SCOPE:word
   	     extrn   BCC_STMT_RECORD_SEG_SAVED:word
   	     extrn   BCC_STMT_RECORD_PREV:word
   	     extrn   X031_0E:far
   	     extrn   X057_11:far
   	     extrn   BCC_RD_8618_W:word
   	     extrn   BCC_STMT_NODE:word
   	     extrn   X057_06:far
   	     extrn   BCC_STMT_ATTACH_TARGET:word
   	     extrn   BCC_STMT_SCOPE_ID:word
   	     extrn   BCC_OPTION_1776:byte
   	     extrn   BCC_OPTION_1716:byte
   	     extrn   BCC_STMT_OUTPUT_HOOK:dword
   	     extrn   BCC_STMT_ACTIVE:word
   	     extrn   X04B_00:far
   	     extrn   BCC_STMT_STATE:byte
   	     extrn   BCC_DIAGNOSTIC_ALT:far
   	     extrn   X057_0E:far
   	     extrn   BCC_RD_77D3_W:word
   	     extrn   BCC_STMT_DIAG_LINE:word
   	     extrn   BCC_RD_8263_W:word
   	     extrn   BCC_STMT_POSITION_END:word
   	     extrn   X057_12:far
   	     extrn   BCC_STMT_LOCAL_FLAG:byte
   	     extrn   BCC_RD_243E_W:word
   	     extrn   BCC_RD_241E_W:word
   	     extrn   BCC_RD_8624_W:word
   	     extrn   BCC_RD_1A3E_W:word
   	     extrn   BCC_RD_861A_W:word
   	     extrn   BCC_RD_D93E_B:byte
   	     extrn   BCC_RD_77D9_B:byte
   	     extrn   BCC_RD_5EDE_W:word
   	     extrn   BCC_RD_DE1E_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_77FD_B:byte
   	     extrn   BCC_RD_FD3E_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M009_BCC_STMT_MESSAGES  equ     37DAh
M009_BCC_STMT_MEMBER_NAME	     equ     85F6h
M009_BCC_STMT_MEMBER_FORMAT     equ     8274h
M009_BCC_STMT_TEXT_37AB equ     37ABh
M009_BCC_STMT_TEXT_37B6 equ     37B6h
M009_BCC_STMT_TEXT_37C2 equ     37C2h
M009_BCC_STMT_TEXT_37CD equ     37CDh

BCC_STMT_MEMBER_NEAR    proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,0Ah
        push    si
        push    di
        mov     di,word ptr [bp+6]
        cmp     word ptr [bp+8],2
        jne     short M009_L_16E2
        mov     word ptr [bp+8],1
M009_L_16E2:
        push    word ptr DGROUP:BCC_STMT_NAME_CURRENT
        push    word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        mov     al,0
        push    ax
        push    word ptr [bp+8]
        push    di
        push    word ptr DGROUP:BCC_STMT_MEMBER_FLAGS
        mov     ax,word ptr [bp+4]
        or	     ax,24h
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr es:[di+3]
        mov     word ptr DGROUP:BCC_RD_5EDE_W,ax
        mov     byte ptr DGROUP:BCC_STMT_PARSE_MODE,1
        push    ds
        mov     ax,M009_BCC_STMT_MEMBER_NAME
        push    ax
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        db	     9Ah
        dw	     BCC_STMT_NAME_BUILD
        dw	     seg BCC_STMT_NAME_BUILD
        mov     word ptr DGROUP:BCC_STMT_NAME_BUFFER+2,dx
        mov     word ptr DGROUP:BCC_STMT_NAME_BUFFER,ax
        mov     word ptr [bp-0Ah],0
        cmp     byte ptr DGROUP:BCC_RD_D93E_B,0
        je	     short M009_L_174A
        mov     word ptr [bp-0Ah],20h
M009_L_174A:
        mov     byte ptr DGROUP:BCC_RD_77D9_B,0
        push    ds
        mov     ax,M009_BCC_STMT_MEMBER_FORMAT
        push    ax
        mov     ax,64h
        push    ax
        db	     9Ah
        dw	     X043_02
        dw	     seg X043_02
        push    si
        push    word ptr DGROUP:BCC_RD_5EDE_W
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        push    word ptr es:[di+5]
        mov     al,byte ptr es:[di+7]
        push    ax
        mov     al,byte ptr es:[di+8]
        or	     al,byte ptr [bp-0Ah]
        push    ax
        push    word ptr DGROUP:BCC_STMT_MEMBER_FLAGS
        push    word ptr DGROUP:BCC_STMT_CONTEXT_A
        push    word ptr DGROUP:BCC_STMT_CONTEXT_B
        push    word ptr DGROUP:BCC_STMT_CONTEXT_C
        push    word ptr DGROUP:BCC_STMT_CONTEXT_D
        db	     9Ah
        dw	     X057_00
        dw	     seg X057_00
        mov     word ptr DGROUP:BCC_STMT_NODE_CURRENT,ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     word ptr es:[di+5],0
        je	     short M009_L_17A1
        db	     0E9h
        dw	     0010Ch
M009_L_17A1:
        cmp     word ptr DGROUP:BCC_RD_1A3E_W,0
        jne     short M009_L_17AB
        db	     0E9h
        dw	     00102h
M009_L_17AB:
        db	     0E9h
        dw	     000ABh
M009_L_17AE:
        push    word ptr DGROUP:BCC_RD_8260_W
        push    cs
        db	     0E8h
        dw	     0E962h
        or	     ax,ax
        je	     short M009_L_1824
        push    cs
        db	     0E8h
        dw	     0E989h
        mov     word ptr [bp-2],ax
        cmp     word ptr [bp-2],0
        jne     short M009_L_17CA
        db	     0E9h
        dw	     0008Fh
M009_L_17CA:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0
        jne     short M009_L_17D3
        jmp     short M009_L_17F8
M009_L_17D3:
        cmp     word ptr DGROUP:BCC_RD_243E_W,0Dh
        je	     short M009_L_17FE
        cmp     word ptr DGROUP:BCC_RD_243E_W,8
        je	     short M009_L_17FE
        push    ds
        mov     bx,word ptr DGROUP:BCC_RD_241E_W
        shl     bx,1
        push    word ptr [bx+M009_BCC_STMT_MESSAGES]
        mov     ax,102h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M009_L_17F8:
        mov     word ptr DGROUP:BCC_RD_8624_W,6
M009_L_17FE:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M009_L_1843
        push    word ptr DGROUP:BCC_RD_8624_W
        push    word ptr [bp-2]
        db	     0E8h
        dw	     0032Ch
        or	     ax,ax
        jne     short M009_L_1843
        mov     ax,word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        mov     word ptr DGROUP:BCC_STMT_SCOPE,ax
        mov     ax,word ptr DGROUP:BCC_STMT_RECORD_SEG_SAVED
        mov     word ptr DGROUP:BCC_STMT_RECORD_PREV,ax
        xor     ax,ax
        db	     0E9h
        dw	     001A4h
M009_L_1824:
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,0CDh
        push    ax
        push    cs
        db	     0E8h
        dw	     0F6BDh
        add     sp,6
        cmp     word ptr DGROUP:BCC_RD_603E_W,6
        jne     short M009_L_1843
        mov     byte ptr DGROUP:BCC_RD_77FD_B,1
        jmp     short M009_L_186A
M009_L_1843:
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M009_L_1854
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M009_L_1859
M009_L_1854:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M009_L_1859:
        cmp     word ptr DGROUP:BCC_RD_603E_W,0
        je	     short M009_L_186A
        cmp     word ptr DGROUP:BCC_RD_603E_W,5
        je	     short M009_L_186A
        db	     0E9h
        dw	     0FF44h
M009_L_186A:
        mov     ax,word ptr DGROUP:BCC_RD_861A_W
        mov     word ptr [bp-4],ax
        push    ax
        nop
        push    cs
        db	     0E8h
        dw	     00482h
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr es:[di+5]
        mov     word ptr [bp-6],ax
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     bx,word ptr es:[si+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        test    byte ptr es:[bx+8],8
        jne     short M009_L_18B8
        push    si
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     bx,word ptr es:[si+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        push    word ptr es:[bx+5]
        push    word ptr [bp-4]
        db	     0E8h
        dw	     00126h
        jmp     short M009_L_18B8
M009_L_18AD:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     ax,word ptr es:[di+5]
        mov     word ptr [bp-4],ax
M009_L_18B8:
        push    word ptr DGROUP:BCC_STMT_NODE_CURRENT
        push    word ptr DGROUP:BCC_RD_8618_W
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X057_11
        dw	     seg X057_11
        mov     word ptr DGROUP:BCC_STMT_NODE,ax
        push    ax
        push    word ptr DGROUP:BCC_STMT_ATTACH_TARGET
        db	     9Ah
        dw	     X057_06
        dw	     seg X057_06
        push    word ptr [bp-4]
        nop
        push    cs
        db	     0E8h
        dw	     00526h
        mov     word ptr [bp-8],ax
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     ax,word ptr es:[si+2]
        cmp     ax,word ptr DGROUP:BCC_STMT_SCOPE_ID
        jne     short M009_L_1930
        mov     al,byte ptr DGROUP:BCC_OPTION_1776
        cbw
        or	     ax,ax
        jne     short M009_L_1930
        cmp     word ptr [bp-8],0
        jle     short M009_L_1930
        cmp     byte ptr DGROUP:BCC_OPTION_1716,0
        je	     short M009_L_1908
        mov     ax,M009_BCC_STMT_TEXT_37AB
        jmp     short M009_L_190B
M009_L_1908:
        mov     ax,M009_BCC_STMT_TEXT_37B6
M009_L_190B:
        push    ax
        xor     ax,ax
        push    ax
        db	     0FFh,1Eh
        dw	     BCC_STMT_OUTPUT_HOOK
        cmp     word ptr [bp-8],3
        jl	     short M009_L_1930
        cmp     byte ptr DGROUP:BCC_OPTION_1716,0
        je	     short M009_L_1925
        mov     ax,M009_BCC_STMT_TEXT_37C2
        jmp     short M009_L_1928
M009_L_1925:
        mov     ax,M009_BCC_STMT_TEXT_37CD
M009_L_1928:
        push    ax
        xor     ax,ax
        push    ax
        db	     0FFh,1Eh
        dw	     BCC_STMT_OUTPUT_HOOK
M009_L_1930:
        mov     word ptr DGROUP:BCC_STMT_ACTIVE,si
        mov     ax,1
        push    ax
        push    ax
        db	     9Ah
        dw	     X04B_00
        dw	     seg X04B_00
        mov     word ptr [bp-8],ax
        mov     word ptr DGROUP:BCC_STMT_ACTIVE,0
        mov     ax,word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        mov     word ptr DGROUP:BCC_STMT_SCOPE,ax
        mov     ax,word ptr DGROUP:BCC_STMT_RECORD_SEG_SAVED
        mov     word ptr DGROUP:BCC_STMT_RECORD_PREV,ax
        db	     0E8h
        dw	     005EDh
        cmp     word ptr [bp-8],0
        je	     short M009_L_1981
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_DE1E_W
        cmp     byte ptr es:[bx],0Ch
        je	     short M009_L_196F
        mov     ax,16Fh
        jmp     short M009_L_1979
M009_L_196F:
        cmp     byte ptr DGROUP:BCC_STMT_STATE,2
        jne     short M009_L_1981
        mov     ax,157h
M009_L_1979:
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC_ALT
        dw	     seg BCC_DIAGNOSTIC_ALT
        inc     sp
        inc     sp
M009_L_1981:
        push    word ptr DGROUP:BCC_STMT_NODE_CURRENT
        push    word ptr DGROUP:BCC_STMT_NODE
        db	     9Ah
        dw	     X057_0E
        dw	     seg X057_0E
        push    ax
        push    word ptr DGROUP:BCC_STMT_ATTACH_TARGET
        db	     9Ah
        dw	     X057_06
        dw	     seg X057_06
        mov     ax,word ptr DGROUP:BCC_RD_77D3_W
        mov     word ptr DGROUP:BCC_STMT_DIAG_LINE,ax
        push    word ptr DGROUP:BCC_STMT_NODE_CURRENT
        push    word ptr DGROUP:BCC_RD_8263_W
        push    word ptr DGROUP:BCC_STMT_POSITION_END
        db	     9Ah
        dw	     X057_12
        dw	     seg X057_12
        mov     word ptr DGROUP:BCC_STMT_NAME_BUFFER+2,0
        mov     word ptr DGROUP:BCC_STMT_NAME_BUFFER,0
        mov     byte ptr DGROUP:BCC_STMT_PARSE_MODE,1
        mov     byte ptr DGROUP:BCC_STMT_LOCAL_FLAG,0
        mov     ax,1
M009_L_19C8:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     6
BCC_STMT_MEMBER_NEAR    endp
CO046_TEXT	     ends

; END STMEMBER
; BEGIN STEND (listing ovr_1cf2_9000:19D1)

   	     extrn   BCC_STMT_FIELD_SEG:word
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   BCC_STMT_LOOKUP_HOOK:dword
   	     extrn   X04F_0E:far
   	     extrn   BCC_OPTION_16F5:byte
   	     extrn   BCC_STMT_ERROR:word
   	     extrn   X019_02:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_STMT_RECORD_SEG:word


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M00A_BCC_STMT_SIZE_TABLE	     equ     2766h

BCC_STMT_END_NEAR	     proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,6
        push    si
        push    di
        mov     di,word ptr [bp+6]
        mov     si,word ptr [bp+4]
        db	     0E9h
        dw	     000D8h
M00A_L_19E3:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     ax,word ptr es:[si+2]
        mov     word ptr [bp-4],ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-4]
        cmp     byte ptr es:[bx],9
        jne     short M00A_L_1A02
        mov     word ptr [bp-2],0Ah
        jmp     short M00A_L_1A19
M00A_L_1A02:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-4]
        mov     al,byte ptr es:[bx]
        mov     ah,0
        shl     ax,1
        mov     bx,ax
        mov     ax,word ptr [bx+M00A_BCC_STMT_SIZE_TABLE]
        mov     word ptr [bp-2],ax
M00A_L_1A19:
        cmp     word ptr [bp-2],0
        je	     short M00A_L_1A77
        push    word ptr [bp-2]
        db	     0FFh,1Eh
        dw	     BCC_STMT_LOOKUP_HOOK
        mov     word ptr [bp-6],ax
        push    word ptr [bp-6]
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        push    word ptr es:[di+2]
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X04F_0E
        dw	     seg X04F_0E
        or	     ax,ax
        jne     short M00A_L_1AAF
        cmp     byte ptr DGROUP:BCC_OPTION_16F5,1
        je	     short M00A_L_1A54
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp-4]
        cmp     byte ptr es:[bx],9
        jne     short M00A_L_1AAF
M00A_L_1A54:
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        push    word ptr es:[si+4]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,50h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        jmp     short M00A_L_1AAF
M00A_L_1A77:
        push    word ptr [bp-4]
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        push    word ptr es:[di+2]
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X04F_0E
        dw	     seg X04F_0E
        or	     ax,ax
        jne     short M00A_L_1AAF
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        push    word ptr es:[si+4]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,50h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M00A_L_1AAF:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     si,word ptr es:[si+6]
        mov     di,word ptr es:[di+6]
M00A_L_1ABB:
        or	     si,si
        je	     short M00A_L_1AC6
        or	     di,di
        je	     short M00A_L_1AC6
        db	     0E9h
        dw	     0FF1Dh
M00A_L_1AC6:
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     bx,word ptr es:[bx+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        test    byte ptr es:[bx+8],4
        je	     short M00A_L_1B06
        or	     di,di
        je	     short M00A_L_1B32
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,41h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
        jmp     short M00A_L_1B32
M00A_L_1B06:
        or	     si,si
        jne     short M00A_L_1B0E
        or	     di,di
        je	     short M00A_L_1B32
M00A_L_1B0E:
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        mov     bx,word ptr [bp+8]
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        push    word ptr es:[bx+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,41h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M00A_L_1B32:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     6
BCC_STMT_END_NEAR	     endp
CO046_TEXT	     ends

; END STEND
; BEGIN STCTYPE (listing ovr_1cf2_9000:1B3B)

   	     extrn   BCC_STMT_FLAGS_EXTRA:word
   	     extrn   X04D_08:far
   	     extrn   X04D_01:far
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   X04D_05:far
   	     extrn   BCC_STMT_NAME_CURRENT:word
   	     extrn   BCC_STMT_GLOBAL_SCOPE:word
   	     extrn   X04A_12:far
   	     extrn   BCC_RD_861A_W:word
   	     extrn   X031_0E:far
   	     extrn   BCC_RD_603E_W:word
   	     extrn   BCC_RD_8260_W:word
   	     extrn   BCC_RD_FD3E_B:byte
   	     extrn   BCC_RD_77FD_B:byte


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

BCC_STMT_CHECK_TYPE_NEAR	     proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        push    di
        mov     di,word ptr [bp+6]
        mov     ax,word ptr DGROUP:BCC_STMT_FLAGS_EXTRA
        mov     word ptr [bp-4],ax
M00B_L_1B4D:
        mov     ax,word ptr [bp-4]
        mov     word ptr DGROUP:BCC_STMT_FLAGS_EXTRA,ax
        xor     ax,ax
        push    ax
        db	     9Ah
        dw	     X04D_08
        dw	     seg X04D_08
        mov     word ptr [bp-2],ax
        cmp     word ptr [bp-2],0
        jne     short M00B_L_1B69
        xor     ax,ax
        db	     0E9h
        dw	     00093h
M00B_L_1B69:
        push    word ptr [bp-2]
        push    word ptr [bp+4]
        db	     9Ah
        dw	     X04D_01
        dw	     seg X04D_01
        mov     si,ax
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[si],12h
        jne     short M00B_L_1B91
        push    si
        mov     al,0
        push    ax
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X04D_05
        dw	     seg X04D_05
        mov     si,ax
M00B_L_1B91:
        cmp     di,8
        jne     short M00B_L_1BAE
        push    word ptr DGROUP:BCC_STMT_NAME_CURRENT
        push    word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        mov     al,0
        push    ax
        push    di
        push    si
        xor     ax,ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        jmp     short M00B_L_1BBD
M00B_L_1BAE:
        push    word ptr DGROUP:BCC_RD_861A_W
        push    word ptr DGROUP:BCC_STMT_NAME_CURRENT
        push    di
        push    si
        nop
        push    cs
        db	     0E8h
        dw	     000A0h
M00B_L_1BBD:
        cmp     word ptr DGROUP:BCC_RD_603E_W,8
        jne     short M00B_L_1BDD
        cmp     byte ptr DGROUP:BCC_RD_FD3E_B,0
        je	     short M00B_L_1BD5
        mov     byte ptr DGROUP:BCC_RD_77FD_B,0
        mov     ax,word ptr DGROUP:BCC_RD_8260_W
        jmp     short M00B_L_1BDA
M00B_L_1BD5:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M00B_L_1BDA:
        db	     0E9h
        dw	     0FF70h
M00B_L_1BDD:
        cmp     word ptr DGROUP:BCC_RD_603E_W,7
        je	     short M00B_L_1BF9
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,0CAh
        push    ax
        push    cs
        db	     0E8h
        dw	     0F2FDh
        add     sp,6
        xor     ax,ax
        jmp     short M00B_L_1BFC
M00B_L_1BF9:
        mov     ax,1
M00B_L_1BFC:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     4
BCC_STMT_CHECK_TYPE_NEAR	     endp
CO046_TEXT	     ends

; END STCTYPE
; BEGIN STFUNC (listing ovr_1cf2_9000:1C05)

   	     extrn   BCC_STMT_SCOPE:word
   	     extrn   BCC_STMT_GLOBAL_SCOPE:word
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_STMT_SCOPE_PUSH:far
   	     extrn   BCC_STMT_SCOPE_FLAGS:word
   	     extrn   BCC_RD_8618_W:word
   	     extrn   BCC_STMT_RECORD_PREV:word
   	     extrn   BCC_RD_782A_W:word
   	     extrn   BCC_RD_861A_W:word


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M00C_BCC_STMT_NODE_ADDRESS	     equ     5EDCh

   	     public  X046_02
X046_02 label   far
BCC_STMT_FUNCTION_NEAR  proc    far
        push    bp
        mov     bp,sp
        mov     ax,word ptr DGROUP:BCC_STMT_SCOPE
        cmp     ax,word ptr DGROUP:BCC_STMT_GLOBAL_SCOPE
        je	     short M00C_L_1C1E
        mov     ax,86h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        inc     sp
        inc     sp
        jmp     short M00C_L_1C5B
M00C_L_1C1E:
        push    ds
        mov     ax,M00C_BCC_STMT_NODE_ADDRESS
        push    ax
        xor     ax,ax
        push    ax
        mov     ax,9
        push    ax
        db	     9Ah
        dw	     BCC_STMT_SCOPE_PUSH
        dw	     seg BCC_STMT_SCOPE_PUSH
        mov     word ptr DGROUP:BCC_STMT_SCOPE_FLAGS,0
        mov     ax,word ptr DGROUP:BCC_RD_8618_W
        mov     word ptr DGROUP:BCC_STMT_SCOPE,ax
        mov     ax,word ptr DGROUP:BCC_RD_8618_W
        mov     word ptr DGROUP:BCC_STMT_RECORD_PREV,ax
        push    word ptr DGROUP:BCC_RD_782A_W
        push    word ptr DGROUP:BCC_RD_8618_W
        xor     ax,ax
        push    ax
        mov     ax,8
        push    ax
        db	     9Ah
        dw	     BCC_STMT_SCOPE_PUSH
        dw	     seg BCC_STMT_SCOPE_PUSH
        mov     word ptr DGROUP:BCC_RD_861A_W,0
M00C_L_1C5B:
        pop     bp
        retf
BCC_STMT_FUNCTION_NEAR  endp
CO046_TEXT	     ends

; END STFUNC
; BEGIN STFIELD (listing ovr_1cf2_9000:1C5D)

   	     extrn   BCC_STMT_FIELD_SEG:word
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   X04D_05:far
   	     extrn   BCC_STMT_ERROR:word
   	     extrn   X019_02:far
   	     extrn   BCC_DIAGNOSTIC:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

   	     public  X046_0A
X046_0A label   far
BCC_STMT_BIND_FIELD     proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     di,word ptr [bp+6]
        mov     si,word ptr [bp+0Ch]
        jmp     short M00D_L_1CD2
M00D_L_1C6A:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     ax,word ptr es:[si+4]
        cmp     ax,word ptr [bp+0Ah]
        jne     short M00D_L_1CCA
        cmp     word ptr es:[si+2],0
        je	     short M00D_L_1C86
        push    word ptr [bp+0Ah]
        db	     0E8h
        dw	     0029Ah
        jmp     short M00D_L_1CF2
M00D_L_1C86:
        or	     di,di
        je	     short M00D_L_1CB5
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[di],11h
        jne     short M00D_L_1C9A
        push    word ptr es:[di+7]
        jmp     short M00D_L_1CA5
M00D_L_1C9A:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        cmp     byte ptr es:[di],12h
        jne     short M00D_L_1CB5
        push    di
M00D_L_1CA5:
        mov     al,0
        push    ax
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X04D_05
        dw	     seg X04D_05
        mov     di,ax
M00D_L_1CB5:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     word ptr es:[si+2],di
        test    word ptr [bp+8],8
        je	     short M00D_L_1CF2
        mov     byte ptr es:[si],0FEh
        jmp     short M00D_L_1CF2
M00D_L_1CCA:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     si,word ptr es:[si+6]
M00D_L_1CD2:
        or	     si,si
        jne     short M00D_L_1C6A
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        push    word ptr [bp+0Ah]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,95h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M00D_L_1CF2:
        pop     di
        pop     si
        pop     bp
        retf    8
BCC_STMT_BIND_FIELD     endp
CO046_TEXT	     ends

; END STFIELD
; BEGIN STBEGIN (listing ovr_1cf2_9000:1CF8)

   	     extrn   BCC_STMT_FIELD_SEG:word
   	     extrn   BCC_RD_77E2_W:word


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

   	     public  X046_06
X046_06 label   far
BCC_STMT_BEGIN_NEAR     proc    far
        push    bp
        mov     bp,sp
        push    si
        mov     si,word ptr [bp+6]
        jmp     short M00E_L_1D1B
M00E_L_1D01:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        cmp     word ptr es:[si+2],0
        jne     short M00E_L_1D13
        mov     ax,word ptr DGROUP:BCC_RD_77E2_W
        mov     word ptr es:[si+2],ax
M00E_L_1D13:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     si,word ptr es:[si+6]
M00E_L_1D1B:
        or	     si,si
        jne     short M00E_L_1D01
        pop     si
        pop     bp
        retf    2
BCC_STMT_BEGIN_NEAR     endp
CO046_TEXT	     ends

; END STBEGIN
; BEGIN STADD (listing ovr_1cf2_9000:1D24)

   	     extrn   BCC_STMT_FIELD_SEG:word
   	     extrn   X043_01:far
   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   X04D_05:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M00F_BCC_STMT_FIELD_SEG_ADDR    equ     8196h

   	     public  X046_08
X046_08 label   far
BCC_STMT_ADD_FIELD	     proc    far
        push    bp
        mov     bp,sp
        push    si
        push    di
        cmp     word ptr [bp+0Ah],0
        je	     short M00F_L_1D58
        mov     si,word ptr [bp+0Ch]
        jmp     short M00F_L_1D54
M00F_L_1D34:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     ax,word ptr es:[si+4]
        cmp     ax,word ptr [bp+0Ah]
        jne     short M00F_L_1D4C
        push    word ptr [bp+0Ah]
        db	     0E8h
        dw	     001D7h
        mov     ax,si
        db	     0E9h
        dw	     000B1h
M00F_L_1D4C:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     si,word ptr es:[si+6]
M00F_L_1D54:
        or	     si,si
        jne     short M00F_L_1D34
M00F_L_1D58:
        push    ds
        mov     ax,M00F_BCC_STMT_FIELD_SEG_ADDR
        push    ax
        mov     ax,8
        push    ax
        db	     9Ah
        dw	     X043_01
        dw	     seg X043_01
        mov     si,ax
        cmp     word ptr [bp+0Ch],0
        je	     short M00F_L_1D8C
        mov     di,word ptr [bp+0Ch]
        jmp     short M00F_L_1D7B
M00F_L_1D73:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     di,word ptr es:[di+6]
M00F_L_1D7B:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        cmp     word ptr es:[di+6],0
        jne     short M00F_L_1D73
        mov     word ptr es:[di+6],si
        jmp     short M00F_L_1D8F
M00F_L_1D8C:
        mov     word ptr [bp+0Ch],si
M00F_L_1D8F:
        test    word ptr [bp+6],8
        je	     short M00F_L_1D9A
        mov     al,0FEh
        jmp     short M00F_L_1D9C
M00F_L_1D9A:
        mov     al,0FFh
M00F_L_1D9C:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     byte ptr es:[si],al
        mov     byte ptr es:[si+1],0FFh
        mov     word ptr es:[si+6],0
        mov     ax,word ptr [bp+0Ah]
        mov     word ptr es:[si+4],ax
        cmp     word ptr [bp+8],0
        je	     short M00F_L_1DEF
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp+8]
        cmp     byte ptr es:[bx],11h
        jne     short M00F_L_1DCE
        push    word ptr es:[bx+7]
        jmp     short M00F_L_1DDE
M00F_L_1DCE:
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr [bp+8]
        cmp     byte ptr es:[bx],12h
        jne     short M00F_L_1DEF
        push    word ptr [bp+8]
M00F_L_1DDE:
        mov     al,0
        push    ax
        xor     ax,ax
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X04D_05
        dw	     seg X04D_05
        mov     word ptr [bp+8],ax
M00F_L_1DEF:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     ax,word ptr [bp+8]
        mov     word ptr es:[si+2],ax
        mov     ax,word ptr [bp+0Ch]
M00F_L_1DFD:
        pop     di
        pop     si
        pop     bp
        retf    8
BCC_STMT_ADD_FIELD	     endp
CO046_TEXT	     ends

; END STADD
; BEGIN STCOUNT (listing ovr_1cf2_9000:1E03)

   	     extrn   BCC_EXPR_SEGMENT:word
   	     extrn   X04F_02:far
   	     extrn   BCC_STMT_SCOPE:word
   	     extrn   X04A_12:far
   	     extrn   X060_02:far
   	     extrn   BCC_STMT_RECORD_SEG:word
   	     extrn   BCC_STMT_FIELD_SEG:word
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_RD_5EE3_W:word
   	     extrn   BCC_RD_E31E_W:word
   	     extrn   BCC_RD_DE1E_W:word
   	     extrn   BCC_RD_5EDE_W:word


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

   	     public  X046_00
X046_00 label   far
BCC_STMT_COUNT_NEAR     proc    far
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        push    di
        mov     si,word ptr [bp+6]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     bx,word ptr DGROUP:BCC_RD_DE1E_W
        cmp     byte ptr es:[bx],13h
        jne     short M010_L_1E84
        mov     ax,word ptr es:[bx+3]
        mov     word ptr [bp-2],ax
        cmp     word ptr [bp-2],1
        je	     short M010_L_1E84
        cmp     word ptr [bp-2],2
        je	     short M010_L_1E84
        cmp     word ptr [bp-2],4
        je	     short M010_L_1E84
        push    word ptr DGROUP:BCC_RD_5EDE_W
        mov     al,0Fh
        push    ax
        xor     ax,ax
        push    ax
        push    ax
        push    ax
        db	     9Ah
        dw	     X04F_02
        dw	     seg X04F_02
        mov     word ptr [bp-4],ax
        xor     ax,ax
        push    ax
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,0
        push    ax
        mov     ax,6
        push    ax
        push    word ptr [bp-4]
        xor     ax,ax
        push    ax
        mov     ax,40h
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     word ptr DGROUP:BCC_RD_5EE3_W,ax
        push    word ptr DGROUP:BCC_RD_5EE3_W
        mov     al,0Fh
        push    ax
        mov     al,0
        push    ax
        db	     9Ah
        dw	     X060_02
        dw	     seg X060_02
        mov     bx,word ptr DGROUP:BCC_RD_E31E_W
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     word ptr es:[bx+0Ah],ax
M010_L_1E84:
        mov     word ptr [bp-2],1
        db	     0E9h
        dw	     0007Fh
M010_L_1E8C:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        cmp     word ptr es:[si+4],0
        jne     short M010_L_1EA9
        mov     ax,word ptr [bp-2]
        cwd
        push    dx
        push    ax
        mov     ax,0C2h
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M010_L_1EA9:
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        push    word ptr es:[si+4]
        push    word ptr DGROUP:BCC_STMT_SCOPE
        mov     al,0
        push    ax
        mov     ax,6
        push    ax
        push    word ptr es:[si+2]
        xor     ax,ax
        push    ax
        cmp     byte ptr es:[si],0FEh
        jne     short M010_L_1ECE
        mov     ax,48h
        jmp     short M010_L_1ED1
M010_L_1ECE:
        mov     ax,40h
M010_L_1ED1:
        push    ax
        db	     9Ah
        dw	     X04A_12
        dw	     seg X04A_12
        mov     di,ax
        push    di
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     bx,word ptr es:[di+8]
        mov     es,word ptr DGROUP:BCC_EXPR_SEGMENT
        mov     al,byte ptr es:[bx]
        push    ax
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     al,byte ptr es:[di+6]
        push    ax
        db	     9Ah
        dw	     X060_02
        dw	     seg X060_02
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     word ptr es:[di+0Ah],ax
        mov     es,word ptr DGROUP:BCC_STMT_FIELD_SEG
        mov     si,word ptr es:[si+6]
        inc     word ptr [bp-2]
M010_L_1F0B:
        or	     si,si
        je	     short M010_L_1F12
        db	     0E9h
        dw	     0FF7Ah
M010_L_1F12:
        mov     ax,word ptr [bp-2]
        dec     ax
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        retf    2
BCC_STMT_COUNT_NEAR     endp
CO046_TEXT	     ends

; END STCOUNT
; BEGIN LG0BC (gap	ovr_1cf2_9000:1F1E)
CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,0C7h,006h,04Eh,05Fh,000h,000h,0FFh,076h,004h,09Ah  ; ovr_1cf2_9000:1F1E
   	     dw	     02Ah
   	     dw	     seg CO019_TEXT
   	     db	     052h,050h,0B8h,0ADh,000h,050h,09Ah
   	     dw	     011Bh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     083h,0C4h,006h,05Dh,04Dh,0C2h,002h,000h; ovr_1cf2_9000:1F2C


CO046_TEXT	     ends
; END LG0BC
; BEGIN STFLUSH (listing ovr_1cf2_9000:1F43)

   	     extrn   BCC_RD_181E_W:word
   	     extrn   BCC_RD_2A06_W:word
   	     extrn   BCC_STMT_RECORD_SEG:word
   	     extrn   BCC_STMT_ERROR:word
   	     extrn   X019_02:far
   	     extrn   BCC_DIAGNOSTIC:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

BCC_STMT_FLUSH_NEAR     proc    near
        push    si
        mov     bx,word ptr DGROUP:BCC_RD_181E_W
        mov     es,word ptr DGROUP:BCC_RD_2A06_W
        mov     si,word ptr es:[bx+6]
        jmp     short M012_L_1F89
M012_L_1F52:
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        cmp     byte ptr es:[si+4],1
        jne     short M012_L_1F82
        test    word ptr es:[si+6],40h
        jne     short M012_L_1F82
        mov     word ptr DGROUP:BCC_STMT_ERROR,0
        push    word ptr es:[si+2]
        db	     9Ah
        dw	     X019_02
        dw	     seg X019_02
        push    dx
        push    ax
        mov     ax,0BBh
        push    ax
        db	     9Ah
        dw	     BCC_DIAGNOSTIC
        dw	     seg BCC_DIAGNOSTIC
        add     sp,6
M012_L_1F82:
        mov     es,word ptr DGROUP:BCC_STMT_RECORD_SEG
        mov     si,word ptr es:[si]
M012_L_1F89:
        or	     si,si
        jne     short M012_L_1F52
        pop     si
        ret
BCC_STMT_FLUSH_NEAR     endp
CO046_TEXT	     ends

; Target-qualified	reference aliases (zero	bytes)
BCC_RN_9000_1F1E	     equ     BCC_STMT_FLUSH_NEAR-25h
; END STFLUSH
; BEGIN STINIT (listing ovr_1cf2_9000:1F8F)

   	     extrn   BCC_FAR_03A9:far
   	     extrn   BCC_FAR_5B8B:far
   	     extrn   X031_0B:far
   	     extrn   X031_0E:far
   	     extrn   X047_02:far
   	     extrn   X047_0A:far
   	     extrn   X049_03:far
   	     extrn   X04B_02:far
   	     extrn   X04F_00:far
   	     extrn   X04F_10:far
   	     extrn   X04F_11:far
   	     extrn   X05A_02:far
   	     extrn   X072_00:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M013_BCC_OPTION_16F2    equ     16F2h
M013_BCC_EXPR_SEGMENT   equ     639Ah
M013_BCC_DATA_639E	     equ     639Eh
M013_BCC_DATA_63A0	     equ     63A0h
M013_BCC_DATA_77DD	     equ     77DDh
M013_BCC_TOKEN_SAVED    equ     77FDh
M013_BCC_DATA_7809	     equ     7809h
M013_BCC_DATA_780B	     equ     780Bh
M013_BCC_DATA_780D	     equ     780Dh
M013_BCC_DATA_78A4	     equ     78A4h
M013_BCC_DATA_80E0	     equ     80E0h
M013_BCC_DATA_8164	     equ     8164h
M013_BCC_STMT_TYPE_CURRENT	     equ     8260h
M013_BCC_DATA_8269	     equ     8269h
M013_BCC_DATA_87D4	     equ     87D4h
M013_BCC_DATA_87DC	     equ     87DCh
M013_BCC_DATA_87E0	     equ     87E0h

   	     public  X046_05
X046_05 label   far
BCC_STMT_INIT_NEAR	     proc    far
M013_L_1F8F:
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,5
   	     jne     short M013_L_1FC0
   	     mov     word ptr [BP-6],1
   	     mov     word ptr [BP-0Ah],0
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_1FB9
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_1FBE
M013_L_1FB9:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_1FBE:
   	     jmp     short M013_L_1FC5
M013_L_1FC0:
   	     mov     word ptr [BP-6],0
M013_L_1FC5:
   	     mov     AX,DGROUP:M013_BCC_DATA_639E
   	     mov     DGROUP:M013_BCC_DATA_77DD,AX
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     AL,byte ptr ES:[BX]
   	     mov     AH,0
   	     sub     AX,0Ch
   	     mov     BX,AX
   	     cmp     BX,7
   	     jbe     short M013_L_1FE4
   	     db	     0E9h
   	     dw	     0073Eh
M013_L_1FE4:
   	     shl     BX,1
   	     db	     02Eh,0FFh,0A7h
   	     dw	     27BAh
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+3]
   	     or	     AX,word ptr ES:[BX+5]
   	     jne     short M013_L_2003
   	     mov     word ptr [BP-8],0FFFFh
   	     jmp     short M013_L_2011
M013_L_2003:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+3]
   	     mov     word ptr [BP-8],AX
M013_L_2011:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     BX,word ptr ES:[BX+7]
   	     cmp     byte ptr ES:[BX],2
   	     jbe     short M013_L_2025
   	     db	     0E9h
   	     dw	     000DFh
M013_L_2025:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,34h
   	     je	     short M013_L_202F
   	     db	     0E9h
   	     dw	     000D5h
M013_L_202F:
   	     xor     SI,SI
M013_L_2031:
   	     push    word ptr [BP+6]
   	     db	     09Ah
   	     dw	     X031_0B
   	     dw	     seg X031_0B
   	     add     SI,word ptr DGROUP:M013_BCC_DATA_8269
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_204E
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_2053
M013_L_204E:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_2053:
   	     cmp     AX,34h
   	     je	     short M013_L_2031
   	     mov     word ptr [BP-0Ah],1
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+3]
   	     or	     AX,word ptr ES:[BX+5]
   	     jne     short M013_L_2088
   	     cmp     word ptr [BP+6],1
   	     jne     short M013_L_207D
   	     mov     AL,0
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     87E0h
   	     jmp     short M013_L_2085
M013_L_207D:
   	     mov     AL,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X05A_02
   	     dw	     seg X05A_02
M013_L_2085:
   	     inc     SI
   	     jmp     short M013_L_20B0
M013_L_2088:
   	     cmp     word ptr [BP+6],2
   	     jne     short M013_L_20B0
   	     jmp     short M013_L_2099
M013_L_2090:
   	     inc     SI
   	     mov     AL,0
   	     push    AX
   	     db	     09Ah
   	     dw	     X05A_02
   	     dw	     seg X05A_02
M013_L_2099:
   	     xor     AX,AX
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     cmp     AX,word ptr ES:[BX+5]
   	     jl	     short M013_L_2090
   	     jne     short M013_L_20B0
   	     cmp     SI,word ptr ES:[BX+3]
   	     jc	     short M013_L_2090
M013_L_20B0:
   	     cmp     SI,word ptr [BP-8]
   	     jbe     short M013_L_20C5
   	     mov     AX,46h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     mov     word ptr [BP-8],0FFFFh
M013_L_20C5:
   	     cmp     word ptr [BP-6],0
   	     jne     short M013_L_20CE
   	     db	     0E9h
   	     dw	     001B5h
M013_L_20CE:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_20EB
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0E6h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EE0Ch
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     006C7h
M013_L_20EB:
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_20FC
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_2101
M013_L_20FC:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_2101:
   	     db	     0E9h
   	     dw	     0017Fh
M013_L_2104:
   	     cmp     word ptr [BP-6],0
   	     je	     short M013_L_210D
   	     db	     0E9h
   	     dw	     000C4h
M013_L_210D:
   	     cmp     word ptr [BP+8],0
   	     je	     short M013_L_2129
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0D8h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EDCEh
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00689h
M013_L_2129:
   	     mov     word ptr [BP-0Ah],1
   	     xor     SI,SI
   	     db	     0E9h
   	     dw	     00093h
M013_L_2133:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+7]
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FE47h
   	     or	     AX,AX
   	     jne     short M013_L_2151
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00661h
M013_L_2151:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     je	     short M013_L_217C
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,7
   	     je	     short M013_L_217C
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_217C
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0CAh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0ED7Bh
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00636h
M013_L_217C:
   	     inc     SI
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX+9],0
   	     je	     short M013_L_2190
   	     db	     09Ah
   	     dw	     X04F_11
   	     dw	     seg X04F_11
M013_L_2190:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     jne     short M013_L_21B2
   	     cmp     SI,word ptr [BP-8]
   	     jnc     short M013_L_21B2
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_21AD
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_21B2
M013_L_21AD:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_21B2:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     jne     short M013_L_21BC
   	     db	     0E9h
   	     dw	     000C7h
M013_L_21BC:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,7
   	     jne     short M013_L_21C6
   	     db	     0E9h
   	     dw	     000BDh
M013_L_21C6:
   	     cmp     SI,word ptr [BP-8]
   	     jnc     short M013_L_21CE
   	     db	     0E9h
   	     dw	     0FF65h
M013_L_21CE:
   	     db	     0E9h
   	     dw	     000B2h
M013_L_21D1:
   	     xor     SI,SI
   	     db	     0E9h
   	     dw	     0008Dh
M013_L_21D6:
   	     cmp     SI,word ptr [BP-8]
   	     jc	     short M013_L_21EB
   	     mov     AX,46h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     mov     word ptr [BP-8],0FFFFh
M013_L_21EB:
   	     mov     word ptr [BP-0Ah],1
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+7]
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FD8Ah
   	     or	     AX,AX
   	     jne     short M013_L_220E
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     005A4h
M013_L_220E:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     je	     short M013_L_2232
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_2232
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0CAh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0ECC5h
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00580h
M013_L_2232:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX+9],0
   	     je	     short M013_L_2245
   	     db	     09Ah
   	     dw	     X04F_11
   	     dw	     seg X04F_11
M013_L_2245:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     jne     short M013_L_2262
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_225D
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_2262
M013_L_225D:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_2262:
   	     inc     SI
M013_L_2263:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_226D
   	     db	     0E9h
   	     dw	     0FF69h
M013_L_226D:
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_227E
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_2283
M013_L_227E:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_2283:
   	     cmp     word ptr [BP-0Ah],0
   	     jne     short M013_L_2294
   	     mov     AX,0CFh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
M013_L_2294:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     AX,word ptr ES:[BX+3]
   	     or	     AX,word ptr ES:[BX+5]
   	     jne     short M013_L_22D9
   	     cmp     word ptr [BP+8],0
   	     jne     short M013_L_22B8
   	     mov     AX,10Ah
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     jmp     short M013_L_22D0
M013_L_22B8:
   	     xor     AX,AX
   	     push    AX
   	     push    SI
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+7]
   	     push    AX
   	     db	     09Ah
   	     dw	     X04F_00
   	     dw	     seg X04F_00
   	     mov     word ptr [BP+0Ah],AX
M013_L_22D0:
   	     mov     AX,DGROUP:M013_BCC_DATA_639E
   	     mov     DGROUP:M013_BCC_DATA_77DD,AX
   	     db	     0E9h
   	     dw	     004D6h
M013_L_22D9:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[BX+5],0
   	     jge     short M013_L_22EA
   	     db	     0E9h
   	     dw	     004C5h
M013_L_22EA:
   	     jg	     short M013_L_22F5
   	     cmp     word ptr ES:[BX+3],SI
   	     ja	     short M013_L_22F5
   	     db	     0E9h
   	     dw	     004BAh
M013_L_22F5:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[BX+9],0
   	     je	     short M013_L_230F
   	     push    word ptr [BP+0Ah]
   	     push    SI
   	     db	     09Ah
   	     dw	     X04F_10
   	     dw	     seg X04F_10
   	     db	     0E9h
   	     dw	     004A0h
M013_L_230F:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     push    word ptr ES:[BX+7]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     xor     CX,CX
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     DX,word ptr ES:[BX+5]
   	     push    AX
   	     mov     AX,word ptr ES:[BX+3]
   	     sub     AX,SI
   	     sbb     DX,0
   	     pop     BX
   	     db	     09Ah
   	     dw	     BCC_FAR_03A9
   	     dw	     seg BCC_FAR_03A9
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     87DCh
   	     db	     0E9h
   	     dw	     0046Ch
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     mov     DI,word ptr ES:[BX+5]
   	     mov     word ptr DGROUP:M013_BCC_DATA_780B,0
   	     mov     word ptr DGROUP:M013_BCC_DATA_7809,0
   	     cmp     byte ptr ES:[BX+9],2
   	     je	     short M013_L_2364
   	     db	     0E9h
   	     dw	     000B0h
M013_L_2364:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     cmp     byte ptr ES:[DI+7],0
   	     je	     short M013_L_237C
   	     push    DI
   	     db	     0E8h
   	     dw	     00457h
   	     or	     AX,AX
   	     jne     short M013_L_2397
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00436h
M013_L_237C:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FC01h
   	     or	     AX,AX
   	     jne     short M013_L_2397
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0041Bh
M013_L_2397:
   	     mov     word ptr [BP-0Ah],1
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     je	     short M013_L_23C7
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,7
   	     je	     short M013_L_23C7
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_23C7
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0CAh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EB30h
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     003EBh
M013_L_23C7:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     mov     SI,AX
   	     cmp     word ptr [BP-6],0
   	     jne     short M013_L_23DE
   	     db	     0E9h
   	     dw	     002E3h
M013_L_23DE:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_23FB
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0E6h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EAFCh
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     003B7h
M013_L_23FB:
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_240C
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_2411
M013_L_240C:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_2411:
   	     db	     0E9h
   	     dw	     002ADh
M013_L_2414:
   	     cmp     word ptr [BP-6],0
   	     je	     short M013_L_241D
   	     db	     0E9h
   	     dw	     00157h
M013_L_241D:
   	     cmp     word ptr [BP+8],0
   	     je	     short M013_L_2439
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0D8h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0EABEh
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00379h
M013_L_2439:
   	     mov     word ptr [BP-0Ah],1
   	     xor     SI,SI
   	     db	     0E9h
   	     dw	     00127h
M013_L_2443:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_7809,0
   	     je	     short M013_L_2479
   	     jmp     short M013_L_245E
M013_L_244C:
   	     mov     AL,DGROUP:M013_BCC_DATA_780B
   	     push    AX
   	     db	     0E8h
   	     dw	     00473h
   	     mov     CL,8
   	     shr     word ptr DGROUP:M013_BCC_DATA_780B,CL
   	     inc     word ptr DGROUP:M013_BCC_DATA_780D
   	     inc     SI
M013_L_245E:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     mov     AX,word ptr ES:[DI+4]
   	     cmp     AX,word ptr DGROUP:M013_BCC_DATA_780D
   	     jne     short M013_L_244C
   	     cmp     word ptr DGROUP:M013_BCC_DATA_780B,0
   	     jne     short M013_L_2479
   	     mov     word ptr DGROUP:M013_BCC_DATA_7809,0
M013_L_2479:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     db	     0FFh,01Eh
   	     dw	     80E0h
   	     mov     word ptr [BP-4],AX
   	     cmp     byte ptr DGROUP:M013_BCC_OPTION_16F2,0
   	     je	     short M013_L_24B5
   	     cmp     word ptr [BP-4],1
   	     jle     short M013_L_24B5
   	     mov     AX,SI
   	     xor     DX,DX
   	     div     word ptr [BP-4]
   	     or	     DX,DX
   	     je	     short M013_L_24B5
   	     push    word ptr [BP-4]
   	     db	     0FFh,01Eh
   	     dw	     87D4h
   	     mov     AX,SI
   	     xor     DX,DX
   	     div     word ptr [BP-4]
   	     mov     AX,word ptr [BP-4]
   	     sub     AX,DX
   	     add     SI,AX
M013_L_24B5:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     cmp     byte ptr ES:[DI+7],0
   	     je	     short M013_L_24CD
   	     push    DI
   	     db	     0E8h
   	     dw	     00306h
   	     or	     AX,AX
   	     jne     short M013_L_24E8
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     002E5h
M013_L_24CD:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0FAB0h
   	     or	     AX,AX
   	     jne     short M013_L_24E8
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     002CAh
M013_L_24E8:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     je	     short M013_L_2513
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,7
   	     je	     short M013_L_2513
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_2513
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0CAh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0E9E4h
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0029Fh
M013_L_2513:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_7809,0
   	     jne     short M013_L_2528
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     add     SI,AX
M013_L_2528:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     jne     short M013_L_254F
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     cmp     word ptr ES:[DI],0
   	     je	     short M013_L_254F
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_254A
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_254F
M013_L_254A:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_254F:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,7
   	     jne     short M013_L_2559
   	     db	     0E9h
   	     dw	     00168h
M013_L_2559:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     jne     short M013_L_2563
   	     db	     0E9h
   	     dw	     0015Eh
M013_L_2563:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     mov     DI,word ptr ES:[DI]
M013_L_256A:
   	     or	     DI,DI
   	     je	     short M013_L_2571
   	     db	     0E9h
   	     dw	     0FED2h
M013_L_2571:
   	     db	     0E9h
   	     dw	     0014Dh
M013_L_2574:
   	     xor     SI,SI
   	     db	     0E9h
   	     dw	     00107h
M013_L_2579:
   	     mov     word ptr [BP-0Ah],1
   	     cmp     word ptr DGROUP:M013_BCC_DATA_7809,0
   	     je	     short M013_L_25B4
   	     jmp     short M013_L_2599
M013_L_2587:
   	     mov     AL,DGROUP:M013_BCC_DATA_780B
   	     push    AX
   	     db	     0E8h
   	     dw	     00338h
   	     mov     CL,8
   	     shr     word ptr DGROUP:M013_BCC_DATA_780B,CL
   	     inc     word ptr DGROUP:M013_BCC_DATA_780D
   	     inc     SI
M013_L_2599:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     mov     AX,word ptr ES:[DI+4]
   	     cmp     AX,word ptr DGROUP:M013_BCC_DATA_780D
   	     ja	     short M013_L_2587
   	     cmp     word ptr DGROUP:M013_BCC_DATA_780B,0
   	     jne     short M013_L_25B4
   	     mov     word ptr DGROUP:M013_BCC_DATA_7809,0
M013_L_25B4:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     db	     0FFh,01Eh
   	     dw	     80E0h
   	     mov     word ptr [BP-4],AX
   	     cmp     byte ptr DGROUP:M013_BCC_OPTION_16F2,0
   	     je	     short M013_L_25F0
   	     cmp     word ptr [BP-4],1
   	     jle     short M013_L_25F0
   	     mov     AX,SI
   	     xor     DX,DX
   	     div     word ptr [BP-4]
   	     or	     DX,DX
   	     je	     short M013_L_25F0
   	     push    word ptr [BP-4]
   	     db	     0FFh,01Eh
   	     dw	     87D4h
   	     mov     AX,SI
   	     xor     DX,DX
   	     div     word ptr [BP-4]
   	     mov     AX,word ptr [BP-4]
   	     sub     AX,DX
   	     add     SI,AX
M013_L_25F0:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     cmp     byte ptr ES:[DI+7],0
   	     je	     short M013_L_2608
   	     push    DI
   	     db	     0E8h
   	     dw	     001CBh
   	     or	     AX,AX
   	     jne     short M013_L_2623
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     001AAh
M013_L_2608:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr [BP+6]
   	     push    CS
   	     db	     0E8h
   	     dw	     0F975h
   	     or	     AX,AX
   	     jne     short M013_L_2623
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0018Fh
M013_L_2623:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     je	     short M013_L_2647
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_2647
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0CAh
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0E8B0h
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     0016Bh
M013_L_2647:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,8
   	     jne     short M013_L_2664
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_265F
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_2664
M013_L_265F:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_2664:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_7809,0
   	     jne     short M013_L_2679
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     push    word ptr ES:[DI+9]
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     add     SI,AX
M013_L_2679:
   	     mov     ES,word ptr DGROUP:M013_BCC_DATA_78A4
   	     mov     DI,word ptr ES:[DI]
M013_L_2680:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_268E
   	     or	     DI,DI
   	     je	     short M013_L_268E
   	     db	     0E9h
   	     dw	     0FEEBh
M013_L_268E:
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_26AB
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,46h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0E84Ch
   	     add     SP,6
   	     xor     AX,AX
   	     db	     0E9h
   	     dw	     00107h
M013_L_26AB:
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_26BC
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_26C1
M013_L_26BC:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_26C1:
   	     cmp     word ptr [BP-0Ah],0
   	     jne     short M013_L_26D2
   	     mov     AX,0CFh
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
M013_L_26D2:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_7809,0
   	     je	     short M013_L_26F6
   	     jmp     short M013_L_26E9
M013_L_26DB:
   	     mov     AL,DGROUP:M013_BCC_DATA_780B
   	     push    AX
   	     db	     0E8h
   	     dw	     001E4h
   	     mov     CL,8
   	     shr     word ptr DGROUP:M013_BCC_DATA_780B,CL
   	     inc     SI
M013_L_26E9:
   	     cmp     word ptr DGROUP:M013_BCC_DATA_780B,0
   	     jne     short M013_L_26DB
   	     mov     word ptr DGROUP:M013_BCC_DATA_7809,0
M013_L_26F6:
   	     mov     BX,word ptr [BP+0Ah]
   	     mov     ES,word ptr DGROUP:M013_BCC_EXPR_SEGMENT
   	     cmp     word ptr ES:[BX+3],SI
   	     ja	     short M013_L_2706
   	     db	     0E9h
   	     dw	     000A9h
M013_L_2706:
   	     mov     AX,word ptr ES:[BX+3]
   	     sub     AX,SI
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     87DCh
   	     db	     0E9h
   	     dw	     0009Bh
   	     mov     AX,38h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     db	     0E9h
   	     dw	     0008Dh
M013_L_2722:
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X047_02
   	     dw	     seg X047_02
   	     mov     word ptr [BP-2],AX
   	     cmp     word ptr [BP-2],0
   	     jne     short M013_L_273B
   	     xor     AX,AX
   	     jmp     short M013_L_27B2
M013_L_273B:
   	     push    word ptr [BP-2]
   	     push    word ptr [BP+0Ah]
   	     db	     09Ah
   	     dw	     X047_0A
   	     dw	     seg X047_0A
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X04B_02
   	     dw	     seg X04B_02
   	     push    word ptr [BP-2]
   	     db	     09Ah
   	     dw	     X049_03
   	     dw	     seg X049_03
   	     mov     word ptr [BP-2],AX
   	     push    word ptr [BP-2]
   	     mov     AX,word ptr [BP+6]
   	     and     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X072_00
   	     dw	     seg X072_00
   	     mov     word ptr DGROUP:M013_BCC_DATA_63A0,0
   	     mov     AX,DGROUP:M013_BCC_DATA_77DD
   	     mov     DGROUP:M013_BCC_DATA_639E,AX
   	     cmp     word ptr [BP-6],0
   	     je	     short M013_L_27AF
   	     cmp     word ptr DGROUP:M013_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M013_L_2799
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0E6h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0E75Dh
   	     add     SP,6
   	     xor     AX,AX
   	     jmp     short M013_L_27B2
M013_L_2799:
   	     cmp     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     je	     short M013_L_27AA
   	     mov     byte ptr DGROUP:M013_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M013_BCC_STMT_TYPE_CURRENT
   	     jmp     short M013_L_27AF
M013_L_27AA:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M013_L_27AF:
   	     mov     AX,word ptr [BP+0Ah]
M013_L_27B2:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     retf    6
BCC_STMT_INIT_NEAR	     endp

M013_L_27BA:
   	     dw	     2714h
   	     dw	     2722h
   	     dw	     2722h
   	     dw	     2722h
   	     dw	     2722h
   	     dw	     1FEBh
   	     dw	     2714h
   	     dw	     2343h
CO046_TEXT	     ends

; END STINIT
; BEGIN STBITS (listing ovr_1cf2_9000:27CA)

   	     extrn   BCC_FAR_5B8B:far
   	     extrn   X031_0E:far
   	     extrn   X047_02:far
   	     extrn   X047_0A:far
   	     extrn   X049_03:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M014_BCC_DATA_7809	     equ     7809h
M014_BCC_DATA_780B	     equ     780Bh
M014_BCC_DATA_780D	     equ     780Dh
M014_BCC_DATA_78A4	     equ     78A4h
M014_BCC_DATA_8186	     equ     8186h
M014_BCC_TOKEN_SAVED    equ     77FDh
M014_BCC_STMT_TYPE_CURRENT	     equ     8260h

BCC_STMT_BITFIELD_NEAR  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,4
        push    si
        push    di
        mov     si,word ptr [bp+4]
        cmp     word ptr DGROUP:M014_BCC_STMT_TYPE_CURRENT,5
        jne     short M014_L_27FA
        mov     word ptr [bp-2],1
        cmp     byte ptr DGROUP:M014_BCC_TOKEN_SAVED,0
        je	     short M014_L_27F3
        mov     byte ptr DGROUP:M014_BCC_TOKEN_SAVED,0
        mov     ax,word ptr DGROUP:M014_BCC_STMT_TYPE_CURRENT
        jmp     short M014_L_27F8
M014_L_27F3:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M014_L_27F8:
        jmp     short M014_L_27FF
M014_L_27FA:
        mov     word ptr [bp-2],0
M014_L_27FF:
        xor     ax,ax
        push    ax
        mov     ax,2
        push    ax
        db	     9Ah
        dw	     X047_02
        dw	     seg X047_02
        mov     di,ax
        or	     di,di
        jne     short M014_L_2816
        xor     ax,ax
        db	     0E9h
        dw	     000A7h
M014_L_2816:
        push    di
        mov     es,word ptr DGROUP:M014_BCC_DATA_78A4
        push    word ptr es:[si+9]
        db	     9Ah
        dw	     X047_0A
        dw	     seg X047_0A
        push    ax
        db	     9Ah
        dw	     X049_03
        dw	     seg X049_03
        mov     di,ax
        cmp     word ptr DGROUP:M014_BCC_DATA_7809,0
        jne     short M014_L_2839
        mov     word ptr DGROUP:M014_BCC_DATA_780B,0
M014_L_2839:
        mov     word ptr DGROUP:M014_BCC_DATA_7809,1
        mov     es,word ptr DGROUP:M014_BCC_DATA_8186
        cmp     word ptr es:[di],2
        je	     short M014_L_2854
        mov     ax,38h
        push    ax
        db	     9Ah
        dw	     BCC_FAR_5B8B
        dw	     seg BCC_FAR_5B8B
        inc     sp
        inc     sp
M014_L_2854:
        mov     es,word ptr DGROUP:M014_BCC_DATA_78A4
        mov     cl,byte ptr es:[si+7]
        mov     ax,1
        shl     ax,cl
        dec     ax
        mov     es,word ptr DGROUP:M014_BCC_DATA_8186
        and     ax,word ptr es:[di+0Ah]
        mov     word ptr [bp-4],ax
        mov     es,word ptr DGROUP:M014_BCC_DATA_78A4
        mov     cl,byte ptr es:[si+6]
        shl     ax,cl
        add     word ptr DGROUP:M014_BCC_DATA_780B,ax
        mov     ax,word ptr es:[si+4]
        mov     word ptr DGROUP:M014_BCC_DATA_780D,ax
        cmp     word ptr [bp-2],0
        je	     short M014_L_28BA
        cmp     word ptr DGROUP:M014_BCC_STMT_TYPE_CURRENT,6
        je	     short M014_L_28A4
        xor     ax,ax
        xor     dx,dx
        push    ax
        push    dx
        mov     ax,0E6h
        push    ax
        push    cs
        db	     0E8h
        dw	     0E652h
        add     sp,6
        xor     ax,ax
        jmp     short M014_L_28BD
M014_L_28A4:
        cmp     byte ptr DGROUP:M014_BCC_TOKEN_SAVED,0
        je	     short M014_L_28B5
        mov     byte ptr DGROUP:M014_BCC_TOKEN_SAVED,0
        mov     ax,word ptr DGROUP:M014_BCC_STMT_TYPE_CURRENT
        jmp     short M014_L_28BA
M014_L_28B5:
        db	     9Ah
        dw	     X031_0E
        dw	     seg X031_0E
M014_L_28BA:
        mov     ax,1
M014_L_28BD:
        pop     di
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     2
BCC_STMT_BITFIELD_NEAR  endp
CO046_TEXT	     ends

; END STBITS
; BEGIN STOUT (listing ovr_1cf2_9000:28C6)

CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M015_BCC_STMT_CURRENT   equ     86C8h
M015_BCC_STMT_HOOK_D8   equ     87D8h
M015_BCC_STMT_HOOK_E0   equ     87E0h


BCC_STMT_OUTPUT_NEAR    proc    near
        inc     bp
        push    bp
        mov     bp,sp
        push    word ptr DGROUP:M015_BCC_STMT_CURRENT
        db	     0FFh,01Eh
        dw	     M015_BCC_STMT_HOOK_D8
        mov     al,byte ptr [bp+4]
        push    ax
        db	     0FFh,01Eh
        dw	     M015_BCC_STMT_HOOK_E0
        pop     bp
        dec     bp
        ret     2
BCC_STMT_OUTPUT_NEAR    endp
CO046_TEXT	     ends

; END STOUT
; BEGIN STFIN (listing ovr_1cf2_9000:28DF)

   	     extrn   X031_0E:far
   	     extrn   X047_02:far
   	     extrn   X049_03:far
   	     extrn   X04A_12:far
   	     extrn   X04B_02:far
   	     extrn   X057_07:far
   	     extrn   X057_11:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M016_BCC_OPTION_16F2    equ     16F2h
M016_BCC_DATA_5EDC	     equ     5EDCh
M016_BCC_EXPR_SEGMENT   equ     639Ah
M016_BCC_DATA_639E	     equ     639Eh
M016_BCC_DATA_63A0	     equ     63A0h
M016_BCC_STMT_RECORD_SEG	     equ     63C2h
M016_BCC_DATA_77DD	     equ     77DDh
M016_BCC_DATA_77E2	     equ     77E2h
M016_BCC_DATA_77EC	     equ     77ECh
M016_BCC_TOKEN_SAVED    equ     77FDh
M016_BCC_DATA_80B4	     equ     80B4h
M016_BCC_DATA_80B8	     equ     80B8h
M016_BCC_DATA_80BC	     equ     80BCh
M016_BCC_DATA_80E0	     equ     80E0h
M016_BCC_DATA_8108	     equ     8108h
M016_BCC_DATA_8164	     equ     8164h
M016_BCC_STMT_TYPE_CURRENT	     equ     8260h
M016_BCC_DATA_8263	     equ     8263h
M016_BCC_DATA_8265	     equ     8265h
M016_BCC_DATA_8618	     equ     8618h
M016_BCC_STMT_CURRENT   equ     86C8h
M016_BCC_DATA_87D0	     equ     87D0h
M016_BCC_DATA_87D4	     equ     87D4h
M016_BCC_DATA_87D8	     equ     87D8h

BCC_STMT_FINISH_NEAR    proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     sub     SP,0Ah
   	     push    SI
   	     push    DI
   	     mov     AX,DGROUP:M016_BCC_DATA_639E
   	     mov     DGROUP:M016_BCC_DATA_77DD,AX
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M016_BCC_STMT_RECORD_SEG
   	     mov     SI,word ptr ES:[BX+8]
   	     mov     AX,DGROUP:M016_BCC_DATA_8263
   	     mov     word ptr [BP-6],AX
   	     mov     AX,DGROUP:M016_BCC_DATA_8265
   	     mov     word ptr [BP-8],AX
   	     cmp     word ptr DGROUP:M016_BCC_STMT_TYPE_CURRENT,5
   	     je	     short M016_L_2916
   	     cmp     word ptr DGROUP:M016_BCC_STMT_TYPE_CURRENT,34h
   	     je	     short M016_L_2916
   	     db	     0E9h
   	     dw	     000EEh
M016_L_2916:
   	     mov     ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[SI],11h
   	     je	     short M016_L_2929
   	     cmp     byte ptr ES:[SI],13h
   	     je	     short M016_L_2929
   	     db	     0E9h
   	     dw	     000DBh
M016_L_2929:
   	     push    word ptr DGROUP:M016_BCC_STMT_CURRENT
   	     db	     0FFh,01Eh
   	     dw	     87D8h
   	     cmp     byte ptr DGROUP:M016_BCC_OPTION_16F2,0
   	     je	     short M016_L_2942
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     80E0h
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     87D4h
M016_L_2942:
   	     xor     AX,AX
   	     push    AX
   	     push    word ptr DGROUP:M016_BCC_DATA_8618
   	     mov     AL,0
   	     push    AX
   	     mov     AX,4
   	     push    AX
   	     push    SI
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     09Ah
   	     dw	     X04A_12
   	     dw	     seg X04A_12
   	     mov     word ptr [BP-0Ah],AX
   	     push    word ptr [BP-0Ah]
   	     db	     0FFh,01Eh
   	     dw	     87D0h
   	     push    SI
   	     mov     AX,1
   	     push    AX
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0F621h
   	     mov     SI,AX
   	     or	     SI,SI
   	     je	     short M016_L_2981
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M016_BCC_STMT_RECORD_SEG
   	     mov     word ptr ES:[BX+8],SI
   	     jmp     short M016_L_298C
M016_L_2981:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M016_BCC_STMT_RECORD_SEG
   	     mov     SI,word ptr ES:[BX+8]
M016_L_298C:
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M016_BCC_STMT_RECORD_SEG
   	     or	     word ptr ES:[BX+6],260h
   	     mov     AX,1
   	     push    AX
   	     push    SI
   	     push    word ptr [BP-0Ah]
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80BCh
   	     mov     DI,AX
   	     mov     AX,5
   	     push    AX
   	     push    SI
   	     push    word ptr [BP+4]
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80BCh
   	     mov     word ptr [BP-2],AX
   	     mov     AX,12h
   	     push    AX
   	     push    SI
   	     push    word ptr [BP-2]
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     DI,AX
   	     mov     ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[SI],11h
   	     jne     short M016_L_29FA
   	     push    word ptr DGROUP:M016_BCC_DATA_77E2
   	     push    SI
   	     db	     0FFh,01Eh
   	     dw	     8164h
   	     xor     DX,DX
   	     push    DX
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     80B4h
   	     mov     word ptr [BP-2],AX
   	     mov     AX,34h
   	     push    AX
   	     push    SI
   	     push    DI
   	     push    word ptr [BP-2]
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     DI,AX
M016_L_29FA:
   	     push    DI
   	     xor     AX,AX
   	     push    AX
   	     push    AX
   	     push    AX
   	     push    AX
   	     db	     0E9h
   	     dw	     000CFh
M016_L_2A04:
   	     cmp     word ptr DGROUP:M016_BCC_STMT_TYPE_CURRENT,5
   	     jne     short M016_L_2A61
   	     cmp     byte ptr DGROUP:M016_BCC_TOKEN_SAVED,0
   	     je	     short M016_L_2A1C
   	     mov     byte ptr DGROUP:M016_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M016_BCC_STMT_TYPE_CURRENT
   	     jmp     short M016_L_2A21
M016_L_2A1C:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M016_L_2A21:
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X047_02
   	     dw	     seg X047_02
   	     mov     DI,AX
   	     cmp     word ptr DGROUP:M016_BCC_STMT_TYPE_CURRENT,6
   	     je	     short M016_L_2A49
   	     xor     AX,AX
   	     xor     DX,DX
   	     push    AX
   	     push    DX
   	     mov     AX,0E6h
   	     push    AX
   	     push    CS
   	     db	     0E8h
   	     dw	     0E4ABh
   	     add     SP,6
   	     jmp     short M016_L_2A6F
M016_L_2A49:
   	     cmp     byte ptr DGROUP:M016_BCC_TOKEN_SAVED,0
   	     je	     short M016_L_2A5A
   	     mov     byte ptr DGROUP:M016_BCC_TOKEN_SAVED,0
   	     mov     AX,DGROUP:M016_BCC_STMT_TYPE_CURRENT
   	     jmp     short M016_L_2A5F
M016_L_2A5A:
   	     db	     09Ah
   	     dw	     X031_0E
   	     dw	     seg X031_0E
M016_L_2A5F:
   	     jmp     short M016_L_2A6F
M016_L_2A61:
   	     xor     AX,AX
   	     push    AX
   	     mov     AX,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X047_02
   	     dw	     seg X047_02
   	     mov     DI,AX
M016_L_2A6F:
   	     mov     ES,word ptr DGROUP:M016_BCC_EXPR_SEGMENT
   	     cmp     byte ptr ES:[SI],15h
   	     jne     short M016_L_2A90
   	     cmp     word ptr ES:[SI+3],1
   	     jne     short M016_L_2A8C
   	     mov     AX,1
   	     push    AX
   	     db	     0FFh,01Eh
   	     dw	     8108h
   	     mov     SI,AX
   	     jmp     short M016_L_2A90
M016_L_2A8C:
   	     mov     SI,word ptr DGROUP:M016_BCC_DATA_77E2
M016_L_2A90:
   	     mov     AX,5
   	     push    AX
   	     push    SI
   	     push    word ptr [BP+4]
   	     xor     AX,AX
   	     push    AX
   	     mov     BX,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M016_BCC_STMT_RECORD_SEG
   	     push    word ptr ES:[BX+6]
   	     db	     0FFh,01Eh
   	     dw	     80BCh
   	     mov     word ptr [BP-2],AX
   	     push    DI
   	     db	     09Ah
   	     dw	     X049_03
   	     dw	     seg X049_03
   	     mov     DI,AX
   	     push    word ptr [BP-2]
   	     push    DI
   	     db	     0E8h
   	     dw	     00044h
   	     mov     DI,AX
   	     push    DI
   	     db	     09Ah
   	     dw	     X04B_02
   	     dw	     seg X04B_02
   	     push    DI
   	     push    word ptr [BP-6]
   	     push    word ptr [BP-8]
   	     push    word ptr DGROUP:M016_BCC_DATA_8263
   	     push    word ptr DGROUP:M016_BCC_DATA_8265
M016_L_2AD3:
   	     db	     09Ah
   	     dw	     X057_11
   	     dw	     seg X057_11
   	     mov     word ptr [BP-4],AX
   	     push    word ptr DGROUP:M016_BCC_DATA_5EDC
   	     push    word ptr [BP-4]
   	     push    word ptr DGROUP:M016_BCC_DATA_77EC
   	     db	     09Ah
   	     dw	     X057_07
   	     dw	     seg X057_07
   	     mov     word ptr DGROUP:M016_BCC_DATA_63A0,0
   	     mov     AX,DGROUP:M016_BCC_DATA_77DD
   	     mov     DGROUP:M016_BCC_DATA_639E,AX
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     2
BCC_STMT_FINISH_NEAR    endp
CO046_TEXT	     ends

; END STFIN
; BEGIN STCONV (listing ovr_1cf2_9000:2B00)

   	     extrn   BCC_FAR_5B8B:far
   	     extrn   X047_0A:far
   	     extrn   X047_0B:far
   	     extrn   X04F_0E:far


CO046_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO046_TEXT,ds:DGROUP

M017_BCC_DATA_80B8	     equ     80B8h
M017_BCC_DATA_8186	     equ     8186h

BCC_STMT_CONVERT_NEAR   proc    near
   	     inc     BP
   	     push    BP
   	     mov     BP,SP
   	     dec     SP
   	     dec     SP
   	     push    SI
   	     push    DI
   	     mov     SI,word ptr [BP+6]
   	     mov     DI,word ptr [BP+4]
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],0
   	     jne     short M017_L_2B1E
   	     mov     AX,SI
   	     db	     0E9h
   	     dw	     00088h
M017_L_2B1E:
   	     or	     DI,DI
   	     je	     short M017_L_2B31
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     cmp     word ptr ES:[DI+2],0
   	     jne     short M017_L_2B31
   	     mov     AX,DI
   	     jmp     short M017_L_2BA6
M017_L_2B31:
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     cmp     word ptr ES:[SI+2],13h
   	     je	     short M017_L_2B43
   	     cmp     word ptr ES:[DI+2],13h
   	     jne     short M017_L_2B84
M017_L_2B43:
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     push    word ptr ES:[DI+8]
   	     mov     AL,2
   	     push    AX
   	     db	     09Ah
   	     dw	     X04F_0E
   	     dw	     seg X04F_0E
   	     or	     AX,AX
   	     jne     short M017_L_2B6D
   	     mov     AX,54h
   	     push    AX
   	     db	     09Ah
   	     dw	     BCC_FAR_5B8B
   	     dw	     seg BCC_FAR_5B8B
   	     inc     SP
   	     inc     SP
   	     db	     09Ah
   	     dw	     X047_0B
   	     dw	     seg X047_0B
   	     jmp     short M017_L_2BA6
M017_L_2B6D:
   	     mov     AX,12h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     push    SI
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
   	     mov     word ptr [BP-2],AX
   	     jmp     short M017_L_2BA6
M017_L_2B84:
   	     push    DI
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     db	     09Ah
   	     dw	     X047_0A
   	     dw	     seg X047_0A
   	     mov     DI,AX
   	     mov     AX,12h
   	     push    AX
   	     mov     ES,word ptr DGROUP:M017_BCC_DATA_8186
   	     push    word ptr ES:[SI+8]
   	     push    SI
   	     push    DI
   	     db	     0FFh,01Eh
   	     dw	     80B8h
M017_L_2BA6:
   	     pop     DI
   	     pop     SI
   	     mov     SP,BP
   	     pop     BP
   	     dec     BP
   	     ret     4
BCC_STMT_CONVERT_NEAR   endp
CO046_TEXT	     ends

; END STCONV
   	     end
