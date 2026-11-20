DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_163
; BEGIN LG055 (gap CODE_163:0000)
CODE_163	segment byte public 'CODE'
		assume	cs:CODE_163
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,090h,0A8h,005h,000h,0BEh,00Bh,0BCh,000h,00Ah,000h	; CODE_163:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_163:000E
		db	000h,000h,000h,000h,0EAh,090h,00Ah,0D3h,0ADh,0EAh,05Dh,003h,0D3h,0ADh	; CODE_163:001C
		db	0EAh,01Eh,008h,0D3h,0ADh,0EAh,0A1h,004h,0D3h,0ADh,0EAh,0C0h,008h,0D3h	; CODE_163:002A
		db	0ADh,0EAh,068h,000h,0D3h,0ADh,0EAh,09Bh,005h,0D3h,0ADh,0EAh,030h,007h	; CODE_163:0038
		db	0D3h,0ADh,0EAh,0F4h,000h,0D3h,0ADh,0EAh,08Fh,009h,0D3h,0ADh,000h,000h	; CODE_163:0046
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_163:0054

CODE_163	ends
; END LG055
		end
