DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_156
; BEGIN RC156 (listing CODE_156:0000)
CODE_156	segment byte public 'CODE'
		assume	cs:CODE_156

		public	BCC_FAR_D900
		public	BCC_FAR_D905
		public	BCC_FAR_D90A
		public	BCC_FAR_D90F
		public	BCC_FAR_D914
		public	BCC_FAR_D919

		db	0CDh,03Fh,000h,000h,070h,057h,005h,000h,0B5h,011h,010h,001h,006h,000h	; CODE_156:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_156:000E
		db	000h,000h,000h,000h	; CODE_156:001C
BCC_FAR_D900	label	far
		db	0EAh,0E7h,005h,0F5h,0A8h	; CODE_156:0020
BCC_FAR_D905	label	far
		db	0EAh,016h,00Ah,0F5h,0A8h	; CODE_156:0025
BCC_FAR_D90A	label	far
		db	0EAh,00Fh,00Fh,0F5h,0A8h	; CODE_156:002A
BCC_FAR_D90F	label	far
		db	0EAh,063h,00Dh,0F5h,0A8h	; CODE_156:002F
BCC_FAR_D914	label	far
		db	0EAh,04Dh,00Dh,0F5h,0A8h	; CODE_156:0034
BCC_FAR_D919	label	far
		db	0EAh,0A2h,00Eh,0F5h,0A8h,000h,000h	; CODE_156:0039

CODE_156	ends
; END RC156
		end
