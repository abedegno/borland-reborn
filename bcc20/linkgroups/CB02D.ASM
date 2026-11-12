; Direct-segment relocation references
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B0F1:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_45
; BEGIN LG01F (gap CODE_45:0000)
RSCAT_TEXT	segment byte public 'CODE'
		assume	cs:RSCAT_TEXT
; Original-image layout stub: not recovered source



RSCAT_TEXT	ends
; END LG01F
; BEGIN RSCAT (listing CODE_45:0006)

		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B0F1:far


RSCAT_TEXT	segment byte public 'CODE'
		assume	cs:RSCAT_TEXT,ds:DGROUP
		public	BCC_FAR_B146

		public	BCC_STRING_APPEND
BCC_STRING_APPEND	label	far
BCC_FAR_B146	proc	far
		push	BP
		mov	BP,SP
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		mov	CX,word ptr [BP+0Ch]
		mov	BX,word ptr [BP+0Ah]
		add	BX,AX
		push	CX
		push	BX
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AX
		push	AX
		db	09Ah
		dw	BCC_FAR_B0F1
		dw	seg BCC_FAR_B0F1
		mov	DX,word ptr [BP+0Ch]
		mov	AX,word ptr [BP+0Ah]
		pop	BP
		retf	8
BCC_FAR_B146	endp
RSCAT_TEXT	ends

; Original-target semantic aliases (zero bytes)
RSCAT_TEXT	segment byte public 'CODE'
		assume	cs:RSCAT_TEXT
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,056h,057h,0FFh,076h,00Eh,0FFh,076h,00Ch,09Ah,002h,000h	; CODE_45:0040
		dw	seg BCC_FAR_AB12
		db	08Bh,0F8h,0FFh,076h,00Ah,0FFh,076h,008h,09Ah,002h,000h
		dw	seg BCC_FAR_AB12
		db	08Bh,0F0h,03Bh,076h,006h,076h,003h,08Bh,076h,006h,08Bh,056h,00Eh; CODE_45:004E
		db	08Bh,046h,00Ch,003h,0C7h,052h,050h,0FFh,076h,00Ah,0FFh,076h,008h,056h	; CODE_45:006A
		db	09Ah,001h,000h
		dw	seg BCC_FAR_B0F1
		db	08Bh,0C7h,003h,0C6h,0C4h,05Eh,00Ch,003h,0D8h; CODE_45:0078
		db	026h,0C6h,007h,000h,08Bh,056h,00Eh,08Bh,046h,00Ch,05Fh,05Eh,05Dh,0CAh	; CODE_45:0086
		db	00Ah,000h	; CODE_45:0094
RSCAT_TEXT	ends
; END RSCAT
; BEGIN LG020 (gap CODE_45:0096)
RSCAT_TEXT	segment byte public 'CODE'
; Alignment padding before the overlay data: not source
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_45:0096

RSCAT_TEXT	ends
; END LG020
		end
