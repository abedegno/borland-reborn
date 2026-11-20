DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_40
; BEGIN LG018 (gap CODE_40:0000)
CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40
; Original-image layout stub: not recovered source



CODE_40	ends
; END LG018
; BEGIN RAE41 (listing CODE_40:0001)

CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40,ds:DGROUP


		public	BCC_NEAR_AE41

BCC_NEAR_AE41	proc	near
		xor	SI,SI
		xor	DI,DI
		mov	BX,0Ah
		cmp	DX,BX
		jnc	short M001_L_AE52
		div	BX
		xchg	SI,DX
		jmp	short M001_L_AE6D
M001_L_AE52:
		mov	CX,20h
M001_L_AE55:
		shl	AX,1
		rcl	DX,1
		rcl	SI,1
		rcl	DI,1
		test	DI,DI
		jne	short M001_L_AE65
		cmp	SI,BX
		jc	short M001_L_AE6B
M001_L_AE65:
		sub	SI,BX
		sbb	DI,0
		inc	AX
M001_L_AE6B:
		loop	short M001_L_AE55
M001_L_AE6D:
		ret
BCC_NEAR_AE41	endp
CODE_40	ends

; END RAE41
; BEGIN RAHELP (listing CODE_40:002E)



CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40,ds:DGROUP
		public	BCC_NEAR_AE6E
		public	BCC_NEAR_AEAF

BCC_NEAR_AE6E	proc	near
		mov	byte ptr ES:[DI],0
		xor	BP,BP
M002_L_NEXT:
		mov	BX,AX
		or	BX,DX
		je	short M002_L_REVERSE
		push	DI
		db	0E8h
		dw	0FFC3h
		pop	DI
		mov	BX,SI
		add	BL,30h
		mov	word ptr ES:[DI],BX
		inc	DI
		inc	BP
		jmp	short M002_L_NEXT
M002_L_REVERSE:
		or	BP,BP
		jne	short M002_L_ORDER
		mov	word ptr ES:[DI],30h
		inc	DI
		inc	BP
M002_L_ORDER:
		mov	BX,BP
		sub	DI,BX
		dec	BX
M002_L_TEST:
		jle	short M002_L_RETURN
		mov	AL,byte ptr ES:[DI]
		mov	AH,byte ptr ES:[BX+DI]
		mov	byte ptr ES:[DI],AH
		mov	byte ptr ES:[BX+DI],AL
		inc	DI
		dec	BX
		dec	BX
		jmp	short M002_L_TEST
M002_L_RETURN:
		ret
BCC_NEAR_AE6E	endp

BCC_NEAR_AEAF	proc	near
		or	DX,DX
		jns	short M002_L_CONVERT
		mov	byte ptr ES:[DI],2Dh
		inc	DI
		not	DX
		not	AX
		add	AX,1
		adc	DX,0
M002_L_CONVERT:
		jmp	short BCC_NEAR_AE6E
BCC_NEAR_AEAF	endp
CODE_40	ends

; END RAHELP
; BEGIN RLTOA (complete source CODE_40:0084..00CC)
CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,056h,057h,01Eh,0C4h,046h,00Ah,08Ch,0C2h,0C4h,07Eh,006h	; CODE_40:0084
		db	0E8h,099h,0FFh,01Fh,05Fh,05Eh,05Dh,0CAh,008h,000h,055h,08Bh,0ECh,056h	; CODE_40:0092
		db	057h,01Eh,0C4h,046h,00Ah,08Ch,0C2h,0C4h,07Eh,006h,0E8h,0C2h,0FFh,01Fh	; CODE_40:00A0
		db	05Fh,05Eh,05Dh,0CAh,008h,000h,055h,08Bh,0ECh,056h,057h,01Eh,033h,0D2h	; CODE_40:00AE
		db	0C4h,07Eh,006h,08Bh,046h,00Ah,0E8h,069h,0FFh,01Fh,05Fh,05Eh,05Dh,0CAh	; CODE_40:00BC
		db	006h,000h	; CODE_40:00CA

CODE_40	ends
; END RLTOA
; BEGIN RMSET0 (listing CODE_40:00CC)



CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40,ds:DGROUP
		public	BCC_FAR_AF0C

BCC_FAR_AF0C	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		push	DS
		les	DI,[BP+6]
		mov	AX,word ptr [BP+0Ah]
		cwd
		db	0E8h
		dw	0FF93h
		pop	DS
		pop	DI
		pop	SI
		pop	BP
		retf	6
BCC_FAR_AF0C	endp
CODE_40	ends

; END RMSET0
		end
