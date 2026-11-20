DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_91
; BEGIN LG03F (gap CODE_91:0000)
CODE_91	segment byte public 'CODE'
		assume	cs:CODE_91
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0C0h,04Bh,002h,000h,000h,000h,000h,000h,000h,000h	; CODE_91:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_91:000E
		db	000h,000h,000h,000h	; CODE_91:001C

CODE_91	ends
; END LG03F
		end
