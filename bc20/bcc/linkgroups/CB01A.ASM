		public	BCC_SEG_26
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_26
; BEGIN RDATE (CODE_26:000C)
CODE_26	segment byte public 'CODE'
BCC_SEG_26	label far
		assume	cs:CODE_26
; Original-image layout stub: not recovered source


		db	055h,08Bh
		db	0ECh,0B4h,02Ah,0CDh,021h,0C4h,05Eh,006h,026h,089h,00Fh,026h,089h,057h	; CODE_26:000E
		db	002h,05Dh,0CAh,004h,000h,055h,08Bh,0ECh,0B4h,02Ch,0CDh,021h,0C4h,05Eh	; CODE_26:001C
		db	006h,026h,089h,00Fh,026h,089h	; CODE_26:002A

		db	057h,002h,05Dh,0CAh,004h,000h	; moved from CODE_27:0000 (segment span per FBOV table)
CODE_26	ends
; END RDATE
		end
