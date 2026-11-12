DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_135
; BEGIN LG04E (gap CODE_135:0000)
CODE_135	segment byte public 'CODE'
		assume	cs:CODE_135
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0B0h,0A0h,004h,000h,001h,000h,000h,000h,001h,000h	; CODE_135:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_135:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,06Ch,09Dh,000h,000h,000h,000h,000h	; CODE_135:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_135:002A

CODE_135	ends
; END LG04E
		end
