DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_60
; BEGIN RC60 (listing CODE_60:0000)
CODE_60	segment byte public 'CODE'
		assume	cs:CODE_60

		public	BCC_FAR_BC55
		public	BCC_FAR_BC5A
		public	BCC_FAR_BC91

		db	0CDh,03Fh,000h,000h,0F0h,099h,000h,000h,09Eh,010h,06Ch,000h,00Eh,000h	; CODE_60:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_60:000E
		db	000h,000h,000h,000h,0EAh,09Fh,002h,010h,056h	; CODE_60:001C
BCC_FAR_BC55	label	far
		db	0EAh,0AAh,008h,010h,056h	; CODE_60:0025
BCC_FAR_BC5A	label	far
		db	0EAh,087h,002h,010h,056h,0EAh,0B3h,00Ah,010h,056h,0EAh,00Dh,007h,010h	; CODE_60:002A
		db	056h,0EAh,055h,007h,010h,056h,0EAh,053h,000h,010h,056h,0EAh,0BFh,00Ch	; CODE_60:0038
		db	010h,056h,0EAh,0C8h,005h,010h,056h,0EAh,01Ch,010h,010h,056h,0EAh,09Eh	; CODE_60:0046
		db	004h,010h,056h,0EAh,0EAh,005h,010h,056h,0EAh,010h,006h,010h,056h	; CODE_60:0054
BCC_FAR_BC91	label	far
		db	0EAh,000h,000h,010h,056h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_60:0061
		db	000h	; CODE_60:006F

CODE_60	ends
; END RC60
		end
