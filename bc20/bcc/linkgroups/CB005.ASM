; Direct-segment relocation references
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_04CF:far
		extrn	BCC_FAR_245C:far
		extrn	X042_00:far
		extrn	X043_00:far
		extrn	X044_00:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_5
; BEGIN C5INIT (raw prefix CODE_5:000D..0089)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5



		public	BCC_RF_15C5_010D

	db 055h,08Bh,0ECh,056h,080h,03Eh,01Ah,000h,008h,075h,006h,08Bh,036h,01Bh
	db 000h,0EBh,009h,0A1h,004h,000h,003h,006h,0A4h,05Ch,08Bh,0F0h,0FFh,036h
	db 004h,000h,056h,0B8h,0FEh,000h,050h,0B8h
		dw	seg BCC_RF_15C5_010D
	db 050h,0B8h,02Ch,001h
	db 050h,033h,0C0h,033h,0D2h,050h,052h,09Ah,0AFh,02Ch
		dw	seg BCC_FAR_245C
	db 00Bh,0C0h
	db 074h,013h,0B8h,006h,000h,050h,09Ah,01Bh,001h
		dw	seg BCC_DIAGNOSTIC
	db 059h,0B8h,001h
	db 000h,050h,09Ah,09Fh,000h
		dw	seg BCC_FAR_04CF
	db 0B8h
		dw	seg X042_00
	db 050h,0B8h
		dw	seg X044_00
	db 050h,09Ah,083h,028h
		dw	seg BCC_FAR_245C
	db 0B0h,042h,050h,09Ah,0B0h,02Bh
		dw	seg BCC_FAR_245C
	db 01Eh,0B8h,010h,083h,050h,033h,0C0h,050h,09Ah,01Ch,01Bh
		dw	seg BCC_FAR_245C
	db 01Eh
	db 0B8h,010h,083h,050h,09Ah,092h,045h
		dw	seg BCC_FAR_245C
	db 05Eh,05Dh,0CBh
CODE_5 ends
; END C5INIT
; BEGIN R5CLEAN (derived raw functions CODE_5:0089..00C7)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5
	db 055h,08Bh
	db 0ECh,083h,03Eh,06Ah,017h,000h,07Ch,00Dh,033h,0C0h,050h,050h,0FFh,036h
	db 06Ah,017h,09Ah,0A1h,03Bh
		dw	seg BCC_FAR_245C
	db 083h,03Eh,06Eh,017h,000h,07Ch,01Eh
	db 075h,007h,083h,03Eh,06Ch,017h,000h,072h,015h,0FFh,036h,06Eh,017h,0FFh
	db 036h,06Ch,017h,0FFh,036h,072h,017h,0FFh,036h,070h,017h,09Ah,01Eh,03Eh
		dw	seg BCC_FAR_245C
	db 05Dh,0CBh
CODE_5 ends
; END R5CLEAN
; BEGIN R5PAIR (derived raw functions CODE_5:00C7..00F1)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5
	db 055h,08Bh,0ECh,09Ah,01Ah,01Ah
		dw	seg BCC_FAR_245C
	db 050h,0E8h
	db 09Dh,000h,05Dh,0CBh,055h,08Bh,0ECh,056h,0B8h,0FFh,0FFh,050h,0E8h,090h
	db 000h,08Bh,0F0h,056h,0E8h,08Ah,000h,08Bh,0F0h,056h,09Ah,0E0h,01Ah
		dw	seg BCC_FAR_245C
	db 05Eh,05Dh,0CBh
CODE_5 ends
; END R5PAIR
; BEGIN STPAIR (derived raw functions CODE_5:00F1..010D)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5
		db	055h,08Bh,0ECh,0A1h,014h,083h,0A3h,00Eh,083h,05Dh,0CBh
		db	055h,08Bh,0ECh,0C7h,006h,016h,083h,000h,000h,0A1h,00Eh,083h,0A3h,014h
		db	083h,05Dh,0CBh
CODE_5 ends
; END STPAIR
; BEGIN R5ALLOC (derived raw function CODE_5:010D..012C)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5

BCC_RF_15C5_010D	label	far
	db 055h,08Bh,0ECh,056h,08Bh,076h,006h,046h,083h,0E6h,0FEh,01Eh,0B8h,010h
	db 083h,050h,056h,09Ah,02Fh,000h
		dw	seg X043_00
	db 08Bh,016h,010h,083h,05Eh,05Dh
	db 0CAh,002h,000h
CODE_5 ends
; END R5ALLOC
; BEGIN C5CB (derived raw callback CODE_5:012C..0170)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5

	db 055h,08Bh,0ECh,01Eh,0B8h,032h,078h,050h,09Ah,04Fh,01Ch
		dw	seg BCC_FAR_245C
	db 01Eh,0B8h,03Ah,078h,050h,09Ah,04Fh,01Ch
		dw	seg BCC_FAR_245C
	db 083h,03Eh
	db 0E4h,014h,000h,075h,01Ah,0C6h,006h,0F9h,016h,000h,0B8h,006h,000h,050h
	db 09Ah,01Bh,001h
		dw	seg BCC_DIAGNOSTIC
	db 059h,0B8h,001h,000h,050h,09Ah,09Fh,000h
		dw	seg BCC_FAR_04CF
	db 0EBh,00Ah,0B8h,006h,000h,050h,09Ah,0D4h,000h
		dw	seg BCC_DIAGNOSTIC
	db 059h,05Dh
	db 0CBh
CODE_5 ends
; END C5CB
; BEGIN R5SETBLK (CODE_5:0170)
CODE_5 segment byte public 'CODE'
	assume cs:CODE_5
	db 045h,055h,08Bh,0ECh,080h,03Eh,01Ah,000h,008h,074h,01Dh,08Eh,006h
	db 016h,000h,08Bh,046h,004h,02Bh,006h,016h,000h,08Bh,0D8h,0B4h,04Ah,0CDh
	db 021h,073h,008h,08Bh,0C3h,003h,006h,016h,000h,0EBh,037h,0EBh,033h,08Bh
	db 046h,004h,08Bh,016h,01Dh,000h,02Bh,0C2h,033h,0D2h,0B9h,010h,000h,0F7h
	db 0E1h,08Bh,0CAh,08Bh,0D0h,08Bh,01Eh,01Bh,000h,0B8h,005h,0E9h,0CDh,021h
	db 073h,014h,0D1h,0E9h,0D1h,0DAh,0D1h,0E9h,0D1h,0DAh,0D1h,0E9h,0D1h,0DAh
	db 0D1h,0E9h,0D1h,0DAh,08Bh,0C2h,0EBh,002h,033h,0C0h,05Dh,04Dh,0C2h
		db	002h,000h	; moved from CODE_6:0000 (segment span per FBOV table)
CODE_5 ends
; END R5SETBLK
		end
