DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_142
; BEGIN RC142 (listing CODE_142:0000)
CODE_142	segment byte public 'CODE'
		assume	cs:CODE_142

		public	BCC_FAR_D4A0
		public	BCC_FAR_D4AF
		public	BCC_FAR_D4B4
		public	BCC_FAR_D4B9
		public	BCC_FAR_D4C3
		public	BCC_FAR_D4CD
		public	BCC_FAR_D4D7
		public	BCC_FAR_D4DC
		public	BCC_FAR_D4E1

		db	0CDh,03Fh,000h,000h,0B0h,0C3h,004h,000h,053h,007h,028h,000h,00Fh,000h	; CODE_142:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_142:000E
		db	000h,000h,000h,000h	; CODE_142:001C
BCC_FAR_D4A0	label	far
		db	0EAh,0CDh,003h,000h,0A0h,0EAh,050h,001h,000h,0A0h,0EAh,0F6h,004h,000h	; CODE_142:0020
		db	0A0h	; CODE_142:002E
BCC_FAR_D4AF	label	far
		db	0EAh,066h,005h,000h,0A0h	; CODE_142:002F
BCC_FAR_D4B4	label	far
		db	0EAh,079h,006h,000h,0A0h	; CODE_142:0034
BCC_FAR_D4B9	label	far
		db	0EAh,08Fh,001h,000h,0A0h,0EAh,0A5h,006h,000h,0A0h	; CODE_142:0039
BCC_FAR_D4C3	label	far
		db	0EAh,0CCh,006h,000h,0A0h,0EAh,07Eh,004h,000h,0A0h	; CODE_142:0043
BCC_FAR_D4CD	label	far
		db	0EAh,0F2h,006h,000h,0A0h,0EAh,06Eh,002h,000h,0A0h	; CODE_142:004D
BCC_FAR_D4D7	label	far
		db	0EAh,026h,007h,000h,0A0h	; CODE_142:0057
BCC_FAR_D4DC	label	far
		db	0EAh,0B9h,001h,000h,0A0h	; CODE_142:005C
		public	BCC_DEBUG_OPEN
BCC_DEBUG_OPEN	label	far
BCC_FAR_D4E1	label	far
		db	0EAh,0CEh,001h,000h,0A0h
		public	BCC_CODE_OPERAND
BCC_CODE_OPERAND	label	far
		public	BCC_DECLARATION_COMMIT
BCC_DECLARATION_COMMIT	label	far
		db	0EAh,000h,000h,000h,0A0h,000h,000h,000h,000h; CODE_142:0061
		db	000h,0CDh,03Fh,000h,000h,040h,0CBh	; CODE_142:006F

CODE_142	ends
; Original-target semantic aliases (zero bytes)
; END RC142
		end
