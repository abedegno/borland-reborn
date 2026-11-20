DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_169
; BEGIN RC169 (listing CODE_169:0000)
CODE_169	segment byte public 'CODE'
		assume	cs:CODE_169

		public	BCC_FAR_DC50

		db	0CDh,03Fh,000h,000h,080h,0DAh,005h,000h,000h,008h,004h,000h,001h,000h	; CODE_169:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_169:000E
		db	000h,000h,000h,000h	; CODE_169:001C
BCC_FAR_DC50	label	far
		db	0EAh,012h,006h,0D9h,0B0h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_169:0020
		db	000h,000h	; CODE_169:002E

CODE_169	ends
; END RC169
		end
