DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_70
; BEGIN LR70 (root CODE_70:0000)
CODE_70	segment byte public 'CODE'
		assume	cs:CODE_70

		public	BCC_RF_1BF7_0025

		db	0CDh,03Fh,000h,000h,030h,064h,001h,000h,094h,003h,020h,000h,005h,000h	; CODE_70:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_70:000E
		db	000h,000h,000h,000h,0EAh,0FAh,000h,010h,064h	; CODE_70:001C
BCC_RF_1BF7_0025	label	far
		db	0EAh,040h,001h,010h,064h,0EAh,0CEh,002h,010h,064h,0EAh,004h,003h,010h	; CODE_70:0025
		db	064h,0EAh,034h,002h,010h,064h,000h,000h,000h,000h,000h,000h,000h	; CODE_70:0033

CODE_70	ends
; END LR70
		end
