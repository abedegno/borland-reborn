DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_88
; BEGIN RC88 (listing CODE_88:0000)
CODE_88	segment byte public 'CODE'
		assume	cs:CODE_88

		public	BCC_FAR_C455
		public	BCC_FAR_C45F
		public	BCC_FAR_C469
		public	BCC_FAR_C46E
		public	BCC_FAR_C473
		public	BCC_FAR_C491
		public	BCC_FAR_C496
		public	BCC_FAR_C49B
		public	BCC_FAR_C4AF
		public	BCC_FAR_C4B4
		public	BCC_FAR_C4BE
		public	BCC_FAR_C4C3
		public	BCC_FAR_C4DC
		public	BCC_FAR_C4E6
		public	BCC_FAR_C4EB
		public	BCC_FAR_C4F0
		public	BCC_FAR_C4F5
		public	BCC_FAR_C4FA
		public	BCC_FAR_C4FF

		db	0CDh,03Fh,000h,000h,0A0h,00Ch,002h,000h,071h,017h,054h,000h,025h,000h	; CODE_88:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_88:000E
		db	000h,000h,000h,000h,0EAh,052h,00Ch,005h,06Eh	; CODE_88:001C
BCC_FAR_C455	label	far
		db	0EAh,006h,008h,005h,06Eh,0EAh,02Bh,009h,005h,06Eh	; CODE_88:0025
BCC_FAR_C45F	label	far
		db	0EAh,092h,003h,005h,06Eh
		public	BCC_TYPE_CAST
BCC_TYPE_CAST	label	far
		db	0EAh,0E0h,005h,005h,06Eh; CODE_88:002F
BCC_FAR_C469	label	far
		db	0EAh,003h,004h,005h,06Eh	; CODE_88:0039
BCC_FAR_C46E	label	far
		db	0EAh,04Dh,007h,005h,06Eh	; CODE_88:003E
		public	BCC_TYPE_RELEASE
BCC_TYPE_RELEASE	label	far
BCC_FAR_C473	label	far
		db	0EAh,0B5h,000h,005h,06Eh,0EAh,0DAh,007h,005h,06Eh,0EAh,09Ch,00Fh,005h	; CODE_88:0043
		db	06Eh,0EAh,073h,002h,005h,06Eh
		public	BCC_TYPE_CHECK
BCC_TYPE_CHECK	label	far
		db	0EAh,091h,00Eh,005h,06Eh,0EAh,0C8h,016h; CODE_88:0051
		db	005h,06Eh	; CODE_88:005F
BCC_FAR_C491	label	far
		db	0EAh,0BDh,015h,005h,06Eh	; CODE_88:0061
BCC_FAR_C496	label	far
		db	0EAh,005h,015h,005h,06Eh	; CODE_88:0066
BCC_FAR_C49B	label	far
		db	0EAh,035h,001h,005h,06Eh,0EAh,0A4h,000h,005h,06Eh,0EAh,081h,00Ch,005h	; CODE_88:006B
		db	06Eh,0EAh,018h,002h,005h,06Eh	; CODE_88:0079
BCC_FAR_C4AF	label	far
		db	0EAh,04Ch,002h,005h,06Eh	; CODE_88:007F
BCC_FAR_C4B4	label	far
		db	0EAh,029h,004h,005h,06Eh,0EAh,034h,003h,005h,06Eh	; CODE_88:0084
BCC_FAR_C4BE	label	far
		db	0EAh,079h,004h,005h,06Eh	; CODE_88:008E
BCC_FAR_C4C3	label	far
		db	0EAh,0EBh,001h,005h,06Eh,0EAh,0ACh,001h,005h,06Eh,0EAh,0F6h,004h,005h	; CODE_88:0093
		db	06Eh,0EAh,061h,000h,005h,06Eh,0EAh,047h,011h,005h,06Eh	; CODE_88:00A1
BCC_FAR_C4DC	label	far
		db	0EAh,0FAh,00Dh,005h,06Eh,0EAh,020h,012h,005h,06Eh	; CODE_88:00AC
BCC_FAR_C4E6	label	far
		db	0EAh,049h,001h,005h,06Eh	; CODE_88:00B6
BCC_FAR_C4EB	label	far
		db	0EAh,0CAh,003h,005h,06Eh	; CODE_88:00BB
BCC_FAR_C4F0	label	far
		db	0EAh,06Bh,006h,005h,06Eh	; CODE_88:00C0
BCC_FAR_C4F5	label	far
		db	0EAh,078h,001h,005h,06Eh	; CODE_88:00C5
BCC_FAR_C4FA	label	far
		db	0EAh,061h,00Dh,005h,06Eh	; CODE_88:00CA
BCC_FAR_C4FF	label	far
		db	0EAh,0C1h,007h,005h,06Eh,0EAh,0DCh,00Ch,005h,06Eh,000h,000h,000h,000h	; CODE_88:00CF
		db	000h,000h,000h	; CODE_88:00DD

CODE_88	ends
; Original-target semantic aliases (zero bytes)
; END RC88
		end
