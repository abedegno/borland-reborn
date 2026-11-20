DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_84
; BEGIN LG03A (gap CODE_84:0000)
CODE_84	segment byte public 'CODE'
		assume	cs:CODE_84
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,030h,0E1h,001h,000h,02Ah,004h,054h,000h,003h,000h	; CODE_84:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_84:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,066h,06Bh,0EAh,054h,001h,066h,06Bh	; CODE_84:001C
		db	0EAh,069h,000h,066h,06Bh,000h	; CODE_84:002A

CODE_84	ends
; END LG03A
		end
