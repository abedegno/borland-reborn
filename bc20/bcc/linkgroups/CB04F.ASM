DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_79
; BEGIN LR79 (root CODE_79:0000)
CODE_79	segment byte public 'CODE'
		assume	cs:CODE_79

		public	BCC_RF_1C1C_0025

		db	0CDh,03Fh,000h,000h,070h,0BDh,001h,000h,0B3h,003h,034h,000h,002h,000h	; CODE_79:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_79:000E
		db	000h,000h,000h,000h,0EAh,0BAh,001h,048h,069h	; CODE_79:001C
BCC_RF_1C1C_0025	label	far
		db	0EAh,000h,000h,048h,069h,000h,000h,000h,000h,000h,000h	; CODE_79:0025

CODE_79	ends
; END LR79
		end
