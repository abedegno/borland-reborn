DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_168
; BEGIN RC168 (listing CODE_168:0000)
CODE_168	segment byte public 'CODE'
		assume	cs:CODE_168

		public	BCC_FAR_DC1F
		public	BCC_FAR_DC24

		db	0CDh,03Fh,000h,000h,000h,0D2h,005h,000h,068h,008h,004h,000h,005h,000h	; CODE_168:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_168:000E
		db	000h,000h,000h,000h,0EAh,098h,007h,052h,0B0h,0EAh,059h,004h,052h,0B0h	; CODE_168:001C
		db	0EAh,060h,007h,052h,0B0h	; CODE_168:002A
BCC_FAR_DC1F	label	far
		db	0EAh,000h,000h,052h,0B0h	; CODE_168:002F
BCC_FAR_DC24	label	far
		db	0EAh,023h,001h,052h,0B0h,000h,000h,000h,000h,000h,000h,000h	; CODE_168:0034

CODE_168	ends
; END RC168
		end
