DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_114
; BEGIN RC114 (listing CODE_114:0000)
CODE_114	segment byte public 'CODE'
		assume	cs:CODE_114

		public	BCC_FAR_CC55
		public	BCC_FAR_CC5F
		public	BCC_FAR_CC64

		db	0CDh,03Fh,000h,000h,010h,046h,003h,000h,0A5h,009h,050h,000h,005h,000h	; CODE_114:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_114:000E
		db	000h,000h,000h,000h,0EAh,048h,000h,097h,086h	; CODE_114:001C
BCC_FAR_CC55	label	far
		db	0EAh,061h,000h,097h,086h,0EAh,0E8h,008h,097h,086h	; CODE_114:0025
		public	BCC_STMT_SPECIAL
BCC_STMT_SPECIAL	label	far
BCC_FAR_CC5F	label	far
		db	0EAh,0D1h,003h,097h,086h	; CODE_114:002F
BCC_FAR_CC64	label	far
		db	0EAh,0BCh,008h,097h,086h,000h,000h,000h,000h,000h,000h,000h	; CODE_114:0034

CODE_114	ends
; Original-target semantic aliases (zero bytes)
; END RC114
		end
