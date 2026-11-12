DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_69
; BEGIN LR69 (root CODE_69:0000)
CODE_69	segment byte public 'CODE'
		assume	cs:CODE_69

		public	BCC_RF_1BF2_0020
		public	BCC_RF_1BF2_0025
		public	BCC_RF_1BF2_002F
		public	BCC_RF_1BF2_0034
		public	BCC_RF_1BF2_003E
		public	BCC_RF_1BF2_0043

		db	0CDh,03Fh,000h,000h,010h,043h,001h,000h,09Eh,01Fh,072h,001h,008h,000h	; CODE_69:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_69:000E
		db	000h,000h,000h,000h	; CODE_69:001C
BCC_RF_1BF2_0020	label	far
		db	0EAh,05Ch,008h,016h,062h	; CODE_69:0020
BCC_RF_1BF2_0025	label	far
		db	0EAh,0CEh,004h,016h,062h,0EAh,0F4h,018h,016h,062h	; CODE_69:0025
BCC_RF_1BF2_002F	label	far
		db	0EAh,055h,012h,016h,062h	; CODE_69:002F
BCC_RF_1BF2_0034	label	far
		db	0EAh,067h,01Dh,016h,062h,0EAh,053h,018h,016h,062h	; CODE_69:0034
BCC_RF_1BF2_003E	label	far
		db	0EAh,049h,00Eh,016h,062h	; CODE_69:003E
BCC_RF_1BF2_0043	label	far
		db	0EAh,0E8h,00Ch,016h,062h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_69:0043

CODE_69	ends
; END LR69
		end
