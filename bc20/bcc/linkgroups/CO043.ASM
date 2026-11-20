; Recovered FBOV far-pointer references
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_245C:far
		public	X043_01
		public	X043_00
		public	X043_03
		public	X043_02
		public	X043_04
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1ce8_8d43
; BEGIN C237UNIT (listing ovr_1ce8_8d43:D430)
CO043_TEXT	segment byte public 'CODE'
		assume	cs:CO043_TEXT
; Original-image layout stub: not recovered source


X043_00	label	far
		db	055h,08Bh,0ECh,056h,0C4h,05Eh,008h,026h,083h,07Fh,006h,000h,074h,015h; ovr_1ce8_8d43:D430
		db	026h,08Bh,077h,006h,026h,08Eh,007h,026h,08Bh,004h,08Eh,046h,00Ah,026h	; ovr_1ce8_8d43:D43E
		db	089h,047h,006h,08Bh,0C6h,0EBh,00Eh,0FFh,076h,00Ah,0FFh,076h,008h,0FFh	; ovr_1ce8_8d43:D44C
		db	076h,006h,090h,00Eh,0E8h,025h,000h,05Eh,05Dh,0CAh,006h,000h; raw:D45A
X043_04	label	far
		db	055h,08Bh; ovr_1ce8_8d43:D45A
		db	0ECh,056h,08Bh,076h,006h,0C4h,05Eh,008h,026h,08Bh,047h,006h,026h,08Eh	; ovr_1ce8_8d43:D468
		db	007h,026h,089h,004h,08Eh,046h,00Ah,026h,089h,077h,006h,05Eh,05Dh,0CAh	; ovr_1ce8_8d43:D476
		db	006h,000h; raw:D484
X043_02	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,07Eh,006h,0C4h,05Eh; ovr_1ce8_8d43:D484
		db	008h,026h,08Bh,047h,004h,089h,046h,0FEh,026h,08Bh,047h,004h,033h,0D2h	; ovr_1ce8_8d43:D492
		db	003h,0C7h,083h,0D2h,000h,00Bh,0D2h,07Ch,012h,075h,005h,03Dh,0FFh,0FFh	; ovr_1ce8_8d43:D4A0
		db	072h,00Bh,0B8h,009h,000h,050h,09Ah
		dw	0D4h
		dw	seg BCC_DIAGNOSTIC
		db	044h,044h,0C4h; ovr_1ce8_8d43:D4AE
		db	05Eh,008h,026h,003h,07Fh,004h,026h,039h,07Fh,002h,073h,03Bh,026h,08Bh	; ovr_1ce8_8d43:D4BC
		db	077h,002h,081h,0FEh,000h,001h,073h,01Ah,0BEh,000h,001h,0EBh,015h,081h	; ovr_1ce8_8d43:D4CA
		db	0FEh,000h,020h,077h,004h,0D1h,0E6h,0EBh,00Bh,081h,0C6h,000h,020h,073h	; ovr_1ce8_8d43:D4D8
		db	005h,0BEh,0FFh,0FFh,0EBh,004h,03Bh,0F7h,072h,0E7h,0FFh,076h,00Ah,0FFh	; ovr_1ce8_8d43:D4E6
		db	076h,008h,056h,09Ah
		dw	04576h
		dw	seg BCC_FAR_245C
		db	0C4h,05Eh,008h,026h,089h,077h; ovr_1ce8_8d43:D4F4
		db	002h,0C4h,05Eh,008h,026h,089h,07Fh,004h,08Bh,046h,0FEh,05Fh,05Eh,08Bh	; ovr_1ce8_8d43:D502
		db	0E5h,05Dh,0CAh,006h,000h; raw:D510
X043_03	label	far
		db	055h,08Bh,0ECh,056h,0C4h,05Eh,008h,026h,08Bh; ovr_1ce8_8d43:D510
		db	047h,004h,003h,046h,006h,08Bh,0F0h,026h,039h,077h,002h,076h,010h,026h	; ovr_1ce8_8d43:D51E
		db	089h,077h,002h,0FFh,076h,00Ah,0FFh,076h,008h,056h,09Ah
		dw	04576h
		dw	seg BCC_FAR_245C
		db	05Eh,05Dh,0CAh,006h,000h; ovr_1ce8_8d43:D52C
X043_01	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h; ovr_1ce8_8d43:D53A
		db	0C4h,05Eh,008h,026h,039h,07Fh,002h,073h,023h,08Bh,0C7h,005h,0FFh,000h	; ovr_1ce8_8d43:D548
		db	025h,000h,0FFh,08Bh,0F0h,00Bh,0F6h,075h,002h,04Eh,04Eh,0FFh,076h,00Ah	; ovr_1ce8_8d43:D556
		db	0FFh,076h,008h,056h,09Ah
		dw	04576h
		dw	seg BCC_FAR_245C
		db	0C4h,05Eh,008h,026h,089h; ovr_1ce8_8d43:D564
		db	077h,002h,0C4h,05Eh,008h,026h,089h,07Fh,004h,05Fh,05Eh,05Dh,0CAh,006h	; ovr_1ce8_8d43:D572
		db	000h	; ovr_1ce8_8d43:D580

CO043_TEXT	ends
; END C237UNIT
		end
