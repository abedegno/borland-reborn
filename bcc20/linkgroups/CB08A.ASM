DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_138
; BEGIN LG050 (gap CODE_138:0000)
CODE_138	segment byte public 'CODE'
		assume	cs:CODE_138
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0B0h,0A4h,004h,000h,000h,000h,000h,000h,000h,000h	; CODE_138:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_138:000E
		db	000h,000h,000h,000h	; CODE_138:001C

CODE_138	ends
; END LG050
		end
