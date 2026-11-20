DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_76
; BEGIN LG036 (gap CODE_76:0000)
CODE_76	segment byte public 'CODE'
		assume	cs:CODE_76
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0E0h,0B6h,001h,000h,0EBh,001h,024h,000h,002h,000h	; CODE_76:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_76:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0E3h,068h,0EAh,060h,001h,0E3h,068h	; CODE_76:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_76:002A

CODE_76	ends
; END LG036
		end
