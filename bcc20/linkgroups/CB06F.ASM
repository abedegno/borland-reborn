DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_111
; BEGIN LG046 (gap CODE_111:0000)
CODE_111	segment byte public 'CODE'
		assume	cs:CODE_111
; Original-image layout stub: not recovered source


		db	0CDh,03Fh,000h,000h,080h,030h,003h,000h,02Bh,007h,05Eh,000h,003h,000h	; CODE_111:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_111:000E
		db	000h,000h,000h,000h,0EAh,040h,000h,04Fh,085h,0EAh,0F8h,005h,04Fh,085h	; CODE_111:001C
		db	0EAh,04Eh,003h,04Fh,085h,000h	; CODE_111:002A

CODE_111	ends
; END LG046
		end
