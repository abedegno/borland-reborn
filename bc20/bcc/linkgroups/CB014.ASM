DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_20
; BEGIN RBSRCH (CODE_20:0007)
CODE_20	segment byte public 'CODE'
		assume	cs:CODE_20

		public	BCC_RF_1A72_0007

BCC_RF_1A72_0007	label	far
		db	055h,08Bh,0ECh,083h,0ECh,00Ah,056h,057h,08Bh,076h,00Ch,0C4h,05Eh,00Eh	; CODE_20:0007
		db	08Ch,046h,0F8h,089h,05Eh,0F6h,0EBh,04Dh,08Bh,0FEh,0D1h,0FFh,08Bh,0C7h	; CODE_20:0015
		db	0F7h,066h,00Ah,0C4h,05Eh,0F6h,003h,0D8h,08Ch,046h,0FCh,089h,05Eh,0FAh	; CODE_20:0023
		db	0FFh,076h,014h,0FFh,076h,012h,0FFh,076h,0FCh,053h,0FFh,05Eh,006h,089h	; CODE_20:0031
		db	046h,0FEh,00Bh,0C0h,075h,008h,08Bh,056h,0FCh,08Bh,046h,0FAh,0EBh,025h	; CODE_20:003F
		db	083h,07Eh,0FEh,000h,07Dh,004h,08Bh,0F7h,0EBh,013h,0C4h,05Eh,0FAh,003h	; CODE_20:004D
		db	05Eh,00Ah,08Ch,046h,0F8h,089h,05Eh,0F6h,08Bh,0C6h,02Bh,0C7h,048h,08Bh	; CODE_20:005B
		db	0F0h,00Bh,0F6h,07Fh,0AFh,033h,0D2h	; CODE_20:0069

		db	08Bh,0C2h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,010h,000h	; moved from CODE_21:0000 (segment span per FBOV table)
CODE_20	ends
; END RBSRCH
		end
