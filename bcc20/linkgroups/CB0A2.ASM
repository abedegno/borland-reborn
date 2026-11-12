DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_162
; BEGIN LR162 (root CODE_162:0000)
CODE_162	segment byte public 'CODE'
		assume	cs:CODE_162

		public	BCC_RF_1DA6_0025
		public	BCC_RF_1DA6_002F

		db	0CDh,03Fh,000h,000h,0C0h,088h,005h,000h,06Dh,01Eh,058h,001h,007h,000h	; CODE_162:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_162:000E
		db	000h,000h,000h,000h,0EAh,0BAh,01Dh,0ECh,0ABh	; CODE_162:001C
BCC_RF_1DA6_0025	label	far
		db	0EAh,0EDh,018h,0ECh,0ABh,0EAh,000h,000h,0ECh,0ABh	; CODE_162:0025
BCC_RF_1DA6_002F	label	far
		db	0EAh,02Bh,019h,0ECh,0ABh,0EAh,035h,019h,0ECh,0ABh,0EAh,023h,01Ah,0ECh	; CODE_162:002F
		db	0ABh,0EAh,0FAh,01Ch,0ECh,0ABh,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_162:003D
		db	000h,000h,000h,000h,000h	; CODE_162:004B

CODE_162	ends
; END LR162
		end
