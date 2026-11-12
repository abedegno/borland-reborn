DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_89
; BEGIN LG03D (gap CODE_89:0000)
CODE_89	segment byte public 'CODE'
		assume	cs:CODE_89
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,070h,024h,002h,000h,055h,00Fh,0CCh,000h,005h,000h	; CODE_89:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_89:000E
		db	000h,000h,000h,000h,0EAh,08Fh,000h,000h,070h,0EAh,0C6h,00Eh,000h,070h	; CODE_89:001C
		db	0EAh,05Eh,001h,000h,070h,0EAh,008h,00Ch,000h,070h,0EAh,06Eh,00Dh,000h	; CODE_89:002A
		db	070h,000h,000h,000h,000h,000h,000h,000h	; CODE_89:0038

CODE_89	ends
; END LG03D
		end
