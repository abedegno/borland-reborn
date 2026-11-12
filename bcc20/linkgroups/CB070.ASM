DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_112
; BEGIN RC112 (listing CODE_112:0000)
CODE_112	segment byte public 'CODE'
		assume	cs:CODE_112

		public	BCC_FAR_CBD5

		db	0CDh,03Fh,000h,000h,010h,038h,003h,000h,0B3h,007h,0A2h,000h,002h,000h	; CODE_112:0000
		db	000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; CODE_112:000E
		db	000h,000h,000h,000h,0EAh,000h,000h,0C2h,085h	; CODE_112:001C
		public	BCC_RF_1CBB_0025
BCC_RF_1CBB_0025	label	far
BCC_FAR_CBD5	label	far
		db	0EAh,0A8h,006h,0C2h,085h,000h,000h,000h,000h,000h,000h	; CODE_112:0025

CODE_112	ends
; Target-qualified reference aliases (zero bytes)
; END RC112
		end
