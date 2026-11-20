DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_67
; BEGIN LR67 (root CODE_67:0000)
CODE_67	segment byte public 'CODE'
		assume	cs:CODE_67

		public	BCC_RF_1BDE_0020
		public	BCC_RF_1BDE_002A

		db	0CDh,03Fh,000h,000h,0D0h,013h,001h,000h,019h,00Ch,00Ch,000h,005h,000h	; CODE_67:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_67:000E
		db	000h,000h,000h,000h	; CODE_67:001C
BCC_RF_1BDE_0020	label	far
		db	0EAh,095h,00Bh,04Fh,05Dh,0EAh,0A0h,000h,04Fh,05Dh	; CODE_67:0020
BCC_RF_1BDE_002A	label	far
		db	0EAh,069h,00Bh,04Fh,05Dh,0EAh,0DAh,008h,04Fh,05Dh,0EAh,0BEh,001h,04Fh	; CODE_67:002A
		db	05Dh,000h,000h,000h,000h,000h,000h,000h	; CODE_67:0038

CODE_67	ends
; END LR67
		end
