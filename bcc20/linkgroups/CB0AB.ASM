DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_171
; BEGIN LG059 (gap CODE_171:0000)
CODE_171	segment byte public 'CODE'
		assume	cs:CODE_171
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,010h,0E9h,005h,000h,000h,000h,000h,000h,000h,000h	; CODE_171:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_171:000E
		db	000h,000h,000h,000h	; CODE_171:001C

CODE_171	ends
; END LG059
		end
