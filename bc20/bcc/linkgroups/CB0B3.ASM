DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_179
; BEGIN RC179 (listing CODE_179:0000)
CODE_179	segment byte public 'CODE'
		assume	cs:CODE_179

		public	BCC_FAR_DED0
		public	BCC_FAR_DED5
		public	BCC_FAR_DEDA
		public	BCC_FAR_DEDF
		public	BCC_FAR_DEE4
		public	BCC_FAR_DEE9

		db	0CDh,03Fh,000h,000h,0C0h,01Ah,006h,000h,0C0h,002h,028h,000h,006h,000h	; CODE_179:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_179:000E
		db	000h,000h,000h,000h	; CODE_179:001C
BCC_FAR_DED0	label	far
		db	0EAh,0F0h,001h,0A9h,0B4h	; CODE_179:0020
BCC_FAR_DED5	label	far
		db	0EAh,05Eh,001h,0A9h,0B4h	; CODE_179:0025
BCC_FAR_DEDA	label	far
		db	0EAh,0E7h,001h,0A9h,0B4h	; CODE_179:002A
BCC_FAR_DEDF	label	far
		db	0EAh,067h,001h,0A9h,0B4h	; CODE_179:002F
BCC_FAR_DEE4	label	far
		db	0EAh,092h,001h,0A9h,0B4h	; CODE_179:0034
BCC_FAR_DEE9	label	far
		db	0EAh,000h,000h,0A9h,0B4h,000h,000h	; CODE_179:0039

CODE_179	ends
; END RC179
		end
