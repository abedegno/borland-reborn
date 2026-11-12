DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_102
; BEGIN RC102 (listing CODE_102:0000)
CODE_102	segment byte public 'CODE'
		assume	cs:CODE_102

		public	BCC_FAR_C905
		public	BCC_FAR_C90F
		public	BCC_FAR_C919

		db	0CDh,03Fh,000h,000h,0E0h,0C0h,002h,000h,0A3h,015h,0DAh,000h,00Bh,000h	; CODE_102:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_102:000E
		db	000h,000h,000h,000h
		public	BCC_RF_1C8E_0020
BCC_RF_1C8E_0020	label	far
		db	0EAh,036h,015h,0C3h,07Ch; CODE_102:001C
		public	BCC_INPUT_FILTER
BCC_INPUT_FILTER	label	far
BCC_FAR_C905	label	far
		db	0EAh,067h,011h,0C3h,07Ch
		public	BCC_TOKEN_EMIT
BCC_TOKEN_EMIT	label	far
		db	0EAh,00Ah,011h,0C3h,07Ch; CODE_102:0025
BCC_FAR_C90F	label	far
		db	0EAh,000h,000h,0C3h,07Ch,0EAh,09Ch,015h,0C3h,07Ch	; CODE_102:002F
		public	BCC_DIRECTIVE_START
BCC_DIRECTIVE_START	label	far
BCC_FAR_C919	label	far
		db	0EAh,01Fh,000h,0C3h,07Ch,0EAh,06Bh,013h,0C3h,07Ch
		public	BCC_LEX_STAR
BCC_LEX_STAR	label	far
		db	0EAh,083h,014h,0C3h; CODE_102:0039
		db	07Ch
		public	BCC_IDENTIFIER_READ
BCC_IDENTIFIER_READ	label	far
		db	0EAh,02Eh,00Fh,0C3h,07Ch,0EAh,02Bh,009h,0C3h,07Ch
		public	BCC_RF_1C8E_0052
BCC_RF_1C8E_0052	label	far
		db	0EAh,02Dh,011h; CODE_102:0047
		db	0C3h,07Ch,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_102:0055

CODE_102	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC102
		end
