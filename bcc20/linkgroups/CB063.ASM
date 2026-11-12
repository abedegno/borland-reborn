DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_99
; BEGIN LR99 (root CODE_99:0000)
CODE_99	segment byte public 'CODE'
		assume	cs:CODE_99

		public	BCC_RF_1C82_0020
		public	BCC_RF_1C82_0025
		public	BCC_RF_1C82_002A

		db	0CDh,03Fh,000h,000h,040h,0ACh,002h,000h,016h,001h,010h,000h,003h,000h	; CODE_99:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_99:000E
		db	000h,000h,000h,000h	; CODE_99:001C
BCC_RF_1C82_0020	label	far
		db	0EAh,02Dh,000h,084h,07Bh	; CODE_99:0020
BCC_RF_1C82_0025	label	far
		db	0EAh,0A3h,000h,084h,07Bh	; CODE_99:0025
BCC_RF_1C82_002A	label	far
		db	0EAh,000h,000h,084h,07Bh,000h	; CODE_99:002A

CODE_99	ends
; END LR99
		end
