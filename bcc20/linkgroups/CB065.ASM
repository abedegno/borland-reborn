DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_101
; BEGIN RC101 (listing CODE_101:0000)
CODE_101	segment byte public 'CODE'
		assume	cs:CODE_101

		public	BCC_FAR_C8D0

		db	0CDh,03Fh,000h,000h,0E0h,0BEh,002h,000h,0F2h,001h,00Ch,000h,001h,000h	; CODE_101:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_101:000E
		db	000h,000h,000h,000h	; CODE_101:001C
		public	BCC_SYMBOL_CREATE
BCC_SYMBOL_CREATE	label	far
BCC_FAR_C8D0	label	far
		db	0EAh,079h,000h,0A3h,07Ch,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_101:0020
		db	000h,000h	; CODE_101:002E

CODE_101	ends
; Original-target semantic aliases (zero bytes)
; END RC101
		end
