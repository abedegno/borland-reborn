DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_63
; BEGIN RC63 (listing CODE_63:0000)
CODE_63	segment byte public 'CODE'
		assume	cs:CODE_63

		public	BCC_FAR_BD30
		public	BCC_FAR_BD35
		public	BCC_FAR_BD3F

		db	0CDh,03Fh,000h,000h,050h,0E5h,000h,000h,02Dh,006h,008h,000h,004h,000h	; CODE_63:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_63:000E
		db	000h,000h,000h,000h	; CODE_63:001C
		public	BCC_TYPE_TEST
BCC_TYPE_TEST	label	far
BCC_FAR_BD30	label	far
		db	0EAh,056h,001h,088h,05Ah	; CODE_63:0020
		public	BCC_TYPE_COERCE
BCC_TYPE_COERCE	label	far
		public	BCC_TYPE_REWRITE
BCC_TYPE_REWRITE	label	far
BCC_FAR_BD35	label	far
		db	0EAh,000h,000h,088h,05Ah,0EAh,047h,005h,088h,05Ah	; CODE_63:0025
		public	BCC_TYPE_CAST2
BCC_TYPE_CAST2	label	far
BCC_FAR_BD3F	label	far
		db	0EAh,070h,005h,088h,05Ah,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_63:002F
		db	000h,000h,000h	; CODE_63:003D

CODE_63	ends
; Original-target semantic aliases (zero bytes)
; END RC63
		end
