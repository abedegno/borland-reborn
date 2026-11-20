DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_132
; BEGIN RC132 (listing CODE_132:0000)
CODE_132	segment byte public 'CODE'
		assume	cs:CODE_132

		public	BCC_FAR_D1F0

		db	0CDh,03Fh,000h,000h,020h,080h,004h,000h,030h,000h,000h,000h,001h,000h	; CODE_132:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_132:000E
		db	000h,000h,000h,000h	; CODE_132:001C
BCC_FAR_D1F0	label	far
		db	0EAh,000h,000h,081h,09Bh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_132:0020
		db	000h,000h	; CODE_132:002E

CODE_132	ends
; END RC132
		end
