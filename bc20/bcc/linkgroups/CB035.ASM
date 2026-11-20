DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_53
; BEGIN LR53 (root CODE_53:0000)
CODE_53	segment byte public 'CODE'
		assume	cs:CODE_53

		public	BCC_RF_1B99_0025
		public	BCC_RF_1B99_0039
		public	BCC_RF_1B99_003E

		db	0CDh,03Fh,000h,000h,070h,034h,000h,000h,0A9h,018h,02Ah,001h,007h,000h	; CODE_53:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_53:000E
		db	000h,000h,000h,000h,0EAh,030h,009h,000h,050h	; CODE_53:001C
BCC_RF_1B99_0025	label	far
		db	0EAh,087h,006h,000h,050h,0EAh,01Eh,003h,000h,050h,0EAh,0BFh,017h,000h	; CODE_53:0025
		db	050h,0EAh,025h,011h,000h,050h	; CODE_53:0033
BCC_RF_1B99_0039	label	far
		db	0EAh,035h,004h,000h,050h	; CODE_53:0039
BCC_RF_1B99_003E	label	far
		db	0EAh,084h,007h,000h,050h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_53:003E
		db	000h,000h,000h,000h	; CODE_53:004C

CODE_53	ends
; END LR53
		end
