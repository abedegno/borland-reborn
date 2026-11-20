DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_87
; BEGIN LG03C (gap CODE_87:0000)
CODE_87	segment byte public 'CODE'
		assume	cs:CODE_87
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,050h,0F8h,001h,000h,073h,013h,0D8h,000h,006h,000h	; CODE_87:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_87:000E
		db	000h,000h,000h,000h,0EAh,0A8h,012h,0CDh,06Ch,0EAh,098h,012h,0CDh,06Ch	; CODE_87:001C
		db	0EAh,0B8h,012h,0CDh,06Ch,0EAh,041h,013h,0CDh,06Ch,0EAh,0D2h,006h,0CDh	; CODE_87:002A
		db	06Ch,0EAh,0E8h,009h,0CDh,06Ch,000h,000h	; CODE_87:0038

CODE_87	ends
; END LG03C
		end
