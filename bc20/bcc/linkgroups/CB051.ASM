DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_81
; BEGIN LR81 (root CODE_81:0006)
CODE_81	segment byte public 'CODE'
		assume	cs:CODE_81

		public	BCC_RF_1C23_002A
		public	BCC_RF_1C23_0034
		public	BCC_RF_1C23_0043

		db	001h,000h,004h,008h,016h,000h,00Ch,000h,000h,000h,000h,000h,000h,000h	; CODE_81:0006
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0EAh,0F9h	; CODE_81:0014
		db	006h,01Bh,06Ah,0EAh,069h,005h,01Bh,06Ah	; CODE_81:0022
BCC_RF_1C23_002A	label	far
		db	0EAh,00Dh,007h,01Bh,06Ah,0EAh,00Dh,006h,01Bh,06Ah	; CODE_81:002A
BCC_RF_1C23_0034	label	far
		db	0EAh,05Ah,007h,01Bh,06Ah,0EAh,08Ch,002h,01Bh,06Ah,0EAh,08Fh,005h,01Bh	; CODE_81:0034
		db	06Ah	; CODE_81:0042
BCC_RF_1C23_0043	label	far
		db	0EAh,0D7h,007h,01Bh,06Ah,0EAh,0EFh,004h,01Bh,06Ah,0EAh,0E5h,006h,01Bh	; CODE_81:0043
		db	06Ah,0EAh,0D1h,006h,01Bh,06Ah,0EAh,02Ah,006h,01Bh,06Ah,000h,000h,000h	; CODE_81:0051
		db	000h	; CODE_81:005F

CODE_81	ends
; END LR81
		end
