DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_136
; BEGIN LG04F (gap CODE_136:0000)
CODE_136	segment byte public 'CODE'
		assume	cs:CODE_136
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,0C0h,0A0h,004h,000h,09Ch,001h,02Ah,000h,003h,000h	; CODE_136:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_136:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,06Dh,09Dh,0EAh,05Bh,001h,06Dh,09Dh	; CODE_136:001C
		db	0EAh,016h,000h,06Dh,09Dh,000h	; CODE_136:002A

CODE_136	ends
; END LG04F
		end
