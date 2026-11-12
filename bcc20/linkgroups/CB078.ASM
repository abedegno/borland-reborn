DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_120
; BEGIN LG049 (gap CODE_120:0000)
CODE_120	segment byte public 'CODE'
		assume	cs:CODE_120
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,050h,0B6h,003h,000h,001h,000h,000h,000h,001h,000h	; CODE_120:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_120:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,042h,08Dh,000h,000h,000h,000h,000h	; CODE_120:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_120:002A

CODE_120	ends
; END LG049
		end
