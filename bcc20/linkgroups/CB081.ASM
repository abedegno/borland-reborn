DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_129
; BEGIN RC129 (listing CODE_129:0000)
CODE_129	segment byte public 'CODE'
		assume	cs:CODE_129

		public	BCC_FAR_D10A

		db	0CDh,03Fh,000h,000h,0C0h,048h,004h,000h,04Fh,018h,052h,001h,003h,000h	; CODE_129:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_129:000E
		db	000h,000h,000h,000h
		public	BCC_RF_1D0E_0020
BCC_RF_1D0E_0020	label	far
		db	0EAh,000h,000h,02Eh,098h,0EAh,0C3h,014h,02Eh,098h; CODE_129:001C
BCC_FAR_D10A	label	far
		db	0EAh,0CCh,015h,02Eh,098h,000h	; CODE_129:002A

CODE_129	ends
; Target-qualified reference aliases (zero bytes)
; END RC129
		end
