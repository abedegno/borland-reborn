DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_115
; BEGIN LR115 (root CODE_115:0000)
CODE_115	segment byte public 'CODE'
		assume	cs:CODE_115

		public	BCC_RF_1CC7_0025
		public	BCC_RF_1CC7_002A
		public	BCC_RF_1CC7_002F
		public	BCC_RF_1CC7_003E

		db	0CDh,03Fh,000h,000h,020h,050h,003h,000h,05Dh,002h,02Ch,000h,007h,000h	; CODE_115:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_115:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,032h,087h	; CODE_115:001C
BCC_RF_1CC7_0025	label	far
		db	0EAh,026h,000h,032h,087h	; CODE_115:0025
BCC_RF_1CC7_002A	label	far
		db	0EAh,07Bh,000h,032h,087h	; CODE_115:002A
BCC_RF_1CC7_002F	label	far
		db	0EAh,0EAh,001h,032h,087h,0EAh,034h,001h,032h,087h,0EAh,063h,001h,032h	; CODE_115:002F
		db	087h	; CODE_115:003D
BCC_RF_1CC7_003E	label	far
		db	0EAh,016h,001h,032h,087h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_115:003E
		db	000h,000h,000h,000h	; CODE_115:004C

CODE_115	ends
; END LR115
		end
