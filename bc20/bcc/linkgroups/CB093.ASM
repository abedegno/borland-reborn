DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_147
; BEGIN LG052 (gap CODE_147:0000)
CODE_147	segment byte public 'CODE'
		assume	cs:CODE_147
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,040h,002h,005h,000h,000h,000h,000h,000h,000h,000h	; CODE_147:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_147:000E
		db	000h,000h,000h,000h	; CODE_147:001C

CODE_147	ends
; END LG052
		end
