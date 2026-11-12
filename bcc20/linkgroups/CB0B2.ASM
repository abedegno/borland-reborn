DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_178
; BEGIN RC178 (listing CODE_178:0000)
CODE_178	segment byte public 'CODE'
		assume	cs:CODE_178

		public	BCC_FAR_DEA0
		public	BCC_FAR_DEA5

		db	0CDh,03Fh,000h,000h,090h,012h,006h,000h,0C7h,007h,062h,000h,002h,000h	; CODE_178:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_178:000E
		db	000h,000h,000h,000h	; CODE_178:001C
BCC_FAR_DEA0	label	far
		db	0EAh,03Dh,007h,02Ch,0B4h	; CODE_178:0020
BCC_FAR_DEA5	label	far
		db	0EAh,0F2h,000h,02Ch,0B4h,000h,000h,000h,000h,000h,000h	; CODE_178:0025

CODE_178	ends
; END RC178
		end
