DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_126
; BEGIN LG04C (gap CODE_126:0000)
CODE_126	segment byte public 'CODE'
		assume	cs:CODE_126
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0B0h,01Fh,004h,000h,07Bh,000h,008h,000h,002h,000h	; CODE_126:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_126:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0A9h,095h,0EAh,00Eh,000h,0A9h,095h	; CODE_126:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_126:002A

CODE_126	ends
; END LG04C
		end
