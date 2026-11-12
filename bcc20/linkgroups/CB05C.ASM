DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_92
; BEGIN LG040 (gap CODE_92:0000)
CODE_92	segment byte public 'CODE'
		assume	cs:CODE_92
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,000h,000h,000h,000h,05Eh,034h,000h,000h,000h,000h	; CODE_92:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_92:000E
		db	000h,000h,000h,000h	; CODE_92:001C

CODE_92	ends
; END LG040
		end
