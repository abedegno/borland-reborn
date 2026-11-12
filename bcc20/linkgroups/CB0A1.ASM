DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_161
; BEGIN LG054 (gap CODE_161:0000)
CODE_161	segment byte public 'CODE'
		assume	cs:CODE_161
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0B0h,088h,005h,000h,001h,000h,000h,000h,001h,000h	; CODE_161:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_161:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0EBh,0ABh,000h,000h,000h,000h,000h	; CODE_161:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_161:002A

CODE_161	ends
; END LG054
		end
