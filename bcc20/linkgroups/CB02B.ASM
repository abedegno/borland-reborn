; Direct-segment relocation references
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AF23:far
		extrn	BCC_FAR_B0F1:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_43
; BEGIN RSCPY (listing CODE_43:0002)

		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_B0F1:far


RSCPY_TEXT	segment byte public 'CODE'
		assume	cs:RSCPY_TEXT,ds:DGROUP
		public	BCC_FAR_B072

		public	BCC_DEBUG_BUILD
BCC_DEBUG_BUILD	label	far
		public	BCC_PARSE_COPY
BCC_PARSE_COPY	label	far
		public	BCC_STMT_NAME_BUILD
BCC_STMT_NAME_BUILD	label	far
		public	BCC_STRING_COPY
BCC_STRING_COPY	label	far
BCC_FAR_B072	proc	far
		push	BP
		mov	BP,SP
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
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
BCC_FAR_B072	endp
RSCPY_TEXT	ends

; Original-target semantic aliases (zero bytes)
RSCPY_TEXT	segment byte public 'CODE'
		assume	cs:RSCPY_TEXT
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h,0FFh,076h,00Ah,0FFh,076h,008h	; CODE_43:002D
		db	09Ah,002h,000h
		dw	seg BCC_FAR_AB12
		db	08Bh,0F0h,03Bh,0F7h,076h,002h,08Bh,0F7h,0FFh; CODE_43:003B
		db	076h,00Eh,0FFh,076h,00Ch,0FFh,076h,00Ah,0FFh,076h,008h,056h,09Ah,001h	; CODE_43:0049
		db	000h
		dw	seg BCC_FAR_B0F1
		db	03Bh,0F7h,073h,017h,08Bh,056h,00Eh,08Bh,046h,00Ch,003h; CODE_43:0057
		db	0C6h,052h,050h,033h,0C0h,050h,08Bh,0C7h,02Bh,0C6h,050h,09Ah,003h,000h	; CODE_43:0065
		dw	seg BCC_FAR_AF23
		db	08Bh,056h,00Eh,08Bh,046h,00Ch,05Fh,05Eh,05Dh,0CAh,00Ah; CODE_43:0073

		db	000h	; moved from CODE_44:0000 (segment span per FBOV table)
RSCPY_TEXT	ends
; END RSCPY
		end
