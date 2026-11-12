DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_153
; BEGIN RC153 (listing CODE_153:0000)
CODE_153	segment byte public 'CODE'
		assume	cs:CODE_153

		public	BCC_FAR_D800
		public	BCC_FAR_D805
		public	BCC_FAR_D80A

		db	0CDh,03Fh,000h,000h,050h,031h,005h,000h,034h,005h,00Ah,000h,003h,000h	; CODE_153:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_153:000E
		db	000h,000h,000h,000h	; CODE_153:001C
BCC_FAR_D800	label	far
		db	0EAh,000h,000h,09Dh,0A6h	; CODE_153:0020
BCC_FAR_D805	label	far
		db	0EAh,0FAh,004h,09Dh,0A6h	; CODE_153:0025
		public	BCC_STMT_COMBINE
BCC_STMT_COMBINE	label	far
BCC_FAR_D80A	label	far
		db	0EAh,0D5h,003h,09Dh,0A6h,000h	; CODE_153:002A

CODE_153	ends
; Original-target semantic aliases (zero bytes)
; END RC153
		end
