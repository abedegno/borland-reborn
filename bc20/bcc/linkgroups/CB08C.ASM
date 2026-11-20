DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_140
; BEGIN LG051 (gap CODE_140:0000)
CODE_140	segment byte public 'CODE'
		assume	cs:CODE_140
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0D0h,0B5h,004h,000h,000h,000h,000h,000h,000h,000h	; CODE_140:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_140:000E
		db	000h,000h,000h,000h	; CODE_140:001C

CODE_140	ends
; END LG051
		end
