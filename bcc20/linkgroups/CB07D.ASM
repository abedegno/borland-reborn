DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_125
; BEGIN RC125 (listing CODE_125:0000)
CODE_125	segment byte public 'CODE'
		assume	cs:CODE_125

		public	BCC_FAR_CF85
		public	BCC_FAR_CF8A
		public	BCC_FAR_CF8F
		public	BCC_FAR_CF99
		public	BCC_FAR_CFAD
		public	BCC_FAR_CFB2
		public	BCC_FAR_CFB7
		public	BCC_FAR_CFBC

		db	0CDh,03Fh,000h,000h,020h,0EFh,003h,000h,0D3h,02Eh,068h,001h,00Eh,000h	; CODE_125:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_125:000E
		db	000h,000h,000h,000h,0EAh,042h,01Eh,0BBh,092h	; CODE_125:001C
		public	BCC_RF_1CF6_0025
BCC_RF_1CF6_0025	label	far
		public	BCC_STMT_TOKEN_TEST
BCC_STMT_TOKEN_TEST	label	far
BCC_FAR_CF85	label	far
		db	0EAh,0B0h,00Dh,0BBh,092h	; CODE_125:0025
BCC_FAR_CF8A	label	far
		db	0EAh,000h,000h,0BBh,092h	; CODE_125:002A
BCC_FAR_CF8F	label	far
		db	0EAh,097h,02Eh,0BBh,092h,0EAh,0BCh,02Eh,0BBh,092h	; CODE_125:002F
BCC_FAR_CF99	label	far
		db	0EAh,031h,00Dh,0BBh,092h,0EAh,01Eh,02Dh,0BBh,092h,0EAh,0AFh,01Dh,0BBh	; CODE_125:0039
		db	092h,0EAh,0F7h,01Bh,0BBh,092h	; CODE_125:0047
BCC_FAR_CFAD	label	far
		db	0EAh,0EFh,02Dh,0BBh,092h	; CODE_125:004D
BCC_FAR_CFB2	label	far
		db	0EAh,079h,011h,0BBh,092h	; CODE_125:0052
BCC_FAR_CFB7	label	far
		db	0EAh,0ACh,01Bh,0BBh,092h	; CODE_125:0057
BCC_FAR_CFBC	label	far
		db	0EAh,0BFh,02Ah,0BBh,092h,0EAh,046h,01Dh,0BBh,092h,000h,000h,000h,000h	; CODE_125:005C
		db	000h,000h,000h,000h,000h,000h	; CODE_125:006A

CODE_125	ends
; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RC125
		end
