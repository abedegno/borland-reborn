DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_128
; BEGIN RC128 (listing CODE_128:0000)
CODE_128	segment byte public 'CODE'
		assume	cs:CODE_128

		public	BCC_FAR_D065
		public	BCC_FAR_D06A
		public	BCC_FAR_D074
		public	BCC_FAR_D07E
		public	BCC_FAR_D0BA
		public	BCC_FAR_D0C4
		public	BCC_FAR_D0C9

		db	0CDh,03Fh,000h,000h,0F0h,039h,004h,000h,07Bh,00Eh,04Ah,000h,017h,000h	; CODE_128:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_128:000E
		db	000h,000h,000h,000h,0EAh,095h,00Dh,046h,097h	; CODE_128:001C
BCC_FAR_D065	label	far
		db	0EAh,087h,00Bh,046h,097h	; CODE_128:0025
		public	BCC_STMT_FIND
BCC_STMT_FIND	label	far
BCC_FAR_D06A	label	far
		db	0EAh,043h,000h,046h,097h,0EAh,042h,00Eh,046h,097h	; CODE_128:002A
BCC_FAR_D074	label	far
		db	0EAh,0F5h,008h,046h,097h,0EAh,0D3h,00Dh,046h,097h	; CODE_128:0034
BCC_FAR_D07E	label	far
		db	0EAh,071h,007h,046h,097h,0EAh,0EAh,00Dh,046h,097h,0EAh,001h,00Eh,046h	; CODE_128:003E
		db	097h,0EAh,018h,00Eh,046h,097h,0EAh,02Eh,00Eh,046h,097h,0EAh,073h,00Eh	; CODE_128:004C
		db	046h,097h,0EAh,0ABh,00Dh,046h,097h,0EAh,056h,00Eh,046h,097h
		public	BCC_STMT_FIND2
BCC_STMT_FIND2	label	far
		db	0EAh,0DDh; CODE_128:005A
		db	000h,046h,097h,0EAh,084h,00Ch,046h,097h,0EAh,068h,00Dh,046h,097h,0EAh	; CODE_128:0068
		db	0BFh,00Dh,046h,097h	; CODE_128:0076
		public	BCC_STMT_DEFINE
BCC_STMT_DEFINE	label	far
BCC_FAR_D0BA	label	far
		db	0EAh,06Bh,001h,046h,097h
		public	BCC_STMT_FIELD
BCC_STMT_FIELD	label	far
		db	0EAh,0F5h,00Ah,046h,097h; CODE_128:007A
BCC_FAR_D0C4	label	far
		db	0EAh,000h,000h,046h,097h	; CODE_128:0084
BCC_FAR_D0C9	label	far
		db	0EAh,03Bh,00Dh,046h,097h,0EAh,01Bh,00Dh,046h,097h,000h,000h,000h,000h	; CODE_128:0089
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_128:0097

CODE_128	ends
; Original-target semantic aliases (zero bytes)
; END RC128
		end
