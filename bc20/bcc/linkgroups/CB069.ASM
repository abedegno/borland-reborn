DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_105
; BEGIN RC105 (listing CODE_105:0000)
CODE_105	segment byte public 'CODE'
		assume	cs:CODE_105

		public	BCC_FAR_CA30

		db	0CDh,03Fh,000h,000h,020h,00Ah,003h,000h,022h,003h,020h,000h,005h,000h	; CODE_105:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_105:000E
		db	000h,000h,000h,000h	; CODE_105:001C
		public	BCC_MACRO_DEFINED
BCC_MACRO_DEFINED	label	far
		public	BCC_RF_1CA1_0020
BCC_RF_1CA1_0020	label	far
BCC_FAR_CA30	label	far
		db	0EAh,01Eh,002h,007h,083h
		public	BCC_MACRO_REMOVE
BCC_MACRO_REMOVE	label	far
		db	0EAh,0FDh,001h,007h,083h
		public	BCC_MACRO_COMMIT
BCC_MACRO_COMMIT	label	far
		db	0EAh,07Ch,000h,007h; CODE_105:0020
		db	083h,0EAh,073h,002h,007h,083h
		public	BCC_MACRO_LOOKUP
BCC_MACRO_LOOKUP	label	far
		db	0EAh,09Eh,002h,007h,083h,000h,000h,000h; CODE_105:002E
		db	000h,000h,000h,000h	; CODE_105:003C

CODE_105	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC105
		end
