DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_166
; BEGIN LG057 (gap CODE_166:0000)
CODE_166	segment byte public 'CODE'
		assume	cs:CODE_166
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,080h,0C7h,005h,000h,0CCh,004h,04Ch,000h,003h,000h	; CODE_166:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_166:000E
		db	000h,000h,000h,000h,0EAh,063h,000h,0A6h,0AFh,0EAh,000h,000h,0A6h,0AFh	; CODE_166:001C
		db	0EAh,0D1h,003h,0A6h,0AFh,000h	; CODE_166:002A

CODE_166	ends
; END LG057
		end
