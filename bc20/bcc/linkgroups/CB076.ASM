DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_118
; BEGIN LR118 (root CODE_118:0000)
CODE_118	segment byte public 'CODE'
		assume	cs:CODE_118

		public	BCC_RF_1CDA_002A

		db	0CDh,03Fh,000h,000h,030h,085h,003h,000h,045h,00Ch,094h,000h,005h,000h	; CODE_118:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_118:000E
		db	000h,000h,000h,000h,0EAh,08Ah,007h,05Bh,08Ah,0EAh,057h,009h,05Bh,08Ah	; CODE_118:001C
BCC_RF_1CDA_002A	label	far
		db	0EAh,006h,002h,05Bh,08Ah,0EAh,055h,005h,05Bh,08Ah,0EAh,08Bh,006h,05Bh	; CODE_118:002A
		db	08Ah,000h,000h,000h,000h,000h,000h,000h	; CODE_118:0038

CODE_118	ends
; END LR118
		end
