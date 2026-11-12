DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_83
; BEGIN LR83 (root CODE_83:0000)
CODE_83	segment byte public 'CODE'
		assume	cs:CODE_83

		public	BCC_RF_1C2E_0034

		db	0CDh,03Fh,000h,000h,0D0h,0DCh,001h,000h,013h,004h,040h,000h,005h,000h	; CODE_83:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_83:000E
		db	000h,000h,000h,000h,0EAh,0BEh,003h,024h,06Bh,0EAh,08Dh,000h,024h,06Bh	; CODE_83:001C
		db	0EAh,000h,000h,024h,06Bh,0EAh,058h,001h,024h,06Bh	; CODE_83:002A
BCC_RF_1C2E_0034	label	far
		db	0EAh,0F6h,002h,024h,06Bh,000h,000h,000h,000h,000h,000h,000h	; CODE_83:0034

CODE_83	ends
; END LR83
		end
