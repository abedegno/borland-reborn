		public	BCC_SEG_28
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_28
; BEGIN RVECT (CODE_28:0009)
CODE_28	segment byte public 'CODE'
BCC_SEG_28	label far
		assume	cs:CODE_28
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,08Ah,046h
		db	006h,0B4h,035h,0CDh,021h,08Bh,0C3h,08Ch,0C2h,05Dh,0CAh,002h,000h,055h	; CODE_28:000E
		db	08Bh,0ECh,01Eh,0C5h	; CODE_28:001C

		db	056h,006h,08Ah,046h,00Ah,0B4h,025h,0CDh,021h,01Fh,05Dh,0CAh,006h,000h	; moved from CODE_29:0000 (segment span per FBOV table)
CODE_28	ends
; END RVECT
		end
