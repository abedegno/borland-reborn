DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_172
; BEGIN RC172 (listing CODE_172:0000)
CODE_172	segment byte public 'CODE'
		assume	cs:CODE_172

		public	BCC_FAR_DCD0

		db	0CDh,03Fh,000h,000h,020h,0E9h,005h,000h,06Fh,002h,014h,000h,001h,000h	; CODE_172:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_172:000E
		db	000h,000h,000h,000h	; CODE_172:001C
BCC_FAR_DCD0	label	far
		db	0EAh,000h,000h,0C0h,0B1h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_172:0020
		db	000h,000h	; CODE_172:002E

CODE_172	ends
; END RC172
		end
