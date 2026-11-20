DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_110
; BEGIN LG045 (gap CODE_110:0000)
CODE_110	segment byte public 'CODE'
		assume	cs:CODE_110
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,070h,02Fh,003h,000h,0FCh,000h,000h,000h,001h,000h	; CODE_110:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_110:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,03Fh,085h,000h,000h,000h,000h,000h	; CODE_110:001C
		db	000h,000h,000h,000h,000h,000h	; CODE_110:002A

CODE_110	ends
; END LG045
		end
