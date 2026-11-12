; Direct-segment relocation references
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_245C:far
		extrn	BCC_FAR_5E22:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AB51:far
		extrn	BCC_FAR_AB9B:far
		extrn	BCC_FAR_ABBB:far
		extrn	BCC_FAR_AF23:far
		extrn	BCC_RF_15C5_010D:far
		extrn	BCC_SEG_15:far
		extrn	BCC_SEG_180:far
		extrn	BCC_SEG_24:far
		extrn	BCC_SEG_26:far
		extrn	BCC_SEG_28:far
		extrn	BCC_SEG_42:far
		extrn	X02E_00:far
		extrn	X034_01:far
		extrn	X036_00:far
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_1
; BEGIN RVECSET (derived actual CODE_1:0008..003D)
CODE_1	segment byte public 'CODE'
		assume	cs:CODE_1

		public	BCC_NEAR_0478
		public	BCC_NEAR_04AF

		db 055h,08Bh,0ECh,080h,03Eh,01Ah
		db 000h,008h,074h,010h,0FFh,076h,00Ah,0FFh,076h,008h,0FFh,076h,006h,09Ah
		db 01Bh,000h
		dw seg BCC_SEG_28
		db 0EBh,017h,050h,052h,08Ch,0D8h,01Eh,08Bh,056h,006h
		db 08Eh,05Eh,008h,08Ah,046h,00Ah,0B4h,025h,0CDh,021h,058h,08Eh,0D8h,05Ah
		db 058h,05Dh,0CAh,006h,000h
CODE_1 ends
; END RVECSET
; BEGIN RVECGET (derived true native CODE_1:003D..0068)
CODE_1 segment byte public 'CODE'
 assume cs:CODE_1
		db 055h,08Bh,0ECh,04Ch,04Ch,080h,03Eh,01Ah,000h
		db 008h,074h,00Ah,0FFh,076h,006h,09Ah,009h,000h
		dw seg BCC_SEG_28
		db 0EBh,00Fh,08Ah
		db 046h,006h,0B4h,035h,0CDh,021h,089h,05Eh,0FEh,08Ch,0C2h,08Bh,046h,0FEh
		db 08Bh,0E5h,05Dh,0CAh,002h,000h
CODE_1 ends
; END RVECGET
; BEGIN RCTRL23 (complete source CODE_1:0068..009F)
CODE_1 segment byte public 'CODE'
 assume cs:CODE_1
BCC_NEAR_0478	label	near
		db 055h,08Bh,0ECh,01Eh,0B8h
		dw seg BCC_SEG_180
		db 08Eh,0D8h,0B8h,018h,000h,050h,0FFh
		db 036h,09Ch,05Ch,0FFh,036h,09Ah,05Ch,00Eh,0E8h,087h,0FFh,0B8h,01Bh,000h
		db 050h,0FFh,036h,0A0h,05Ch,0FFh,036h,09Eh,05Ch,00Eh,0E8h,077h,0FFh,09Ah
		db 027h,001h
		dw seg BCC_FAR_5E22
		db 09Ah,067h,02Dh
		dw seg BCC_FAR_245C
		db 0F9h,01Fh,05Dh,0CBh
CODE_1 ends
; END RCTRL23
; BEGIN REXIT09F (complete source CODE_1:009F..00BF)
CODE_1 segment byte public 'CODE'
 assume cs:CODE_1
BCC_NEAR_04AF	label	near
		db 055h,08Bh,0ECh,0B8h,01Bh,000h,050h,0FFh,036h,0A0h,05Ch,0FFh,036h,09Eh
		db 05Ch,00Eh,0E8h,056h,0FFh,0FFh,076h,006h,09Ah,046h,001h
		dw seg BCC_COPY_WORDS
		db 059h
		db 05Dh,0CAh,002h,000h

CODE_1	ends
; END REXIT09F
; BEGIN RINIT (complete source CODE_1:00BF..00D0)




CODE_1	segment byte public 'CODE'
		assume	cs:CODE_1,ds:DGROUP
		public	BCC_FAR_04CF

		public	BCC_LINE_HOOK
BCC_LINE_HOOK	label	far
BCC_FAR_04CF	proc	far
		push	BP
		mov	BP,SP
		push	CS
		db	0E8h
		dw	0FFA2h
		mov	AX,100h
		push	AX
		push	CS
		db	0E8h
		dw	0FFD1h
		pop	BP
		retf
BCC_FAR_04CF	endp
CODE_1	ends

; Original-target semantic aliases (zero bytes)
		public	BCC_NAME_APPEND
BCC_NAME_APPEND	equ	BCC_FAR_04CF+450h
; Target-qualified reference aliases (zero bytes)
		public	BCC_RF_1041_009F
BCC_RF_1041_009F	equ	BCC_FAR_04CF-20h
; END RINIT
; BEGIN RIRQ1B (complete source CODE_1:00D0..00F0)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1


; Original-image layout stub: not recovered source


	db 050h,053h,051h,052h,006h,01Eh,056h,057h,055h,0BDh
		dw	seg BCC_SEG_180
	db 08Eh,0DDh
	db 08Bh,0ECh,0C7h,006h,0A2h,05Ch,001h,000h,05Dh,05Fh,05Eh,01Fh,007h,05Ah
	db 059h,05Bh,058h,0CFh
CODE_1 ends
; END RIRQ1B
; BEGIN RARGV0F0 (complete source CODE_1:00F0..013C)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1
	db 055h,08Bh,0ECh,083h,0ECh,004h,0EBh,026h,0C4h,05Eh
	db 0FCh,0FFh,046h,0FCh,026h,080h,03Fh,02Dh,075h,01Ah,0C4h,05Eh,0FCh,0FFh
	db 046h,0FCh,026h,080h,03Fh,023h,075h,00Eh,0FFh,076h,0FEh,0FFh,076h,0FCh
	db 09Ah,009h,000h
		dw	seg BCC_SEG_15
	db 0A3h,0A4h,05Ch,0C4h,05Eh,006h,083h,046h,006h
	db 004h,026h,08Bh,047h,002h,026h,08Bh,017h,089h,046h,0FEh,089h,056h,0FCh
	db 00Bh,0D0h,075h,0C2h,08Bh,0E5h,05Dh,0CAh,004h,000h
CODE_1 ends
; END RARGV0F0
; BEGIN RMAIN13C (complete source CODE_1:013C..0388)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1

	db 055h,08Bh,0ECh,083h
	db 0ECh,00Ch,0B8h,018h,000h,050h,00Eh,0E8h,0F3h,0FEh,089h,016h,09Ch,05Ch
	db 0A3h,09Ah,05Ch,0B8h,018h,000h,050h,0B8h
		dw	seg BCC_COPY_WORDS
	db 050h,0B8h,04Fh,001h
	db 050h,00Eh,0E8h,0A7h,0FEh,01Eh,0B8h,0A0h,082h,050h,09Ah,00Ch,000h
		dw	seg BCC_SEG_26
	db 01Eh,0B8h,09Ah,082h,050h,09Ah,021h,000h
		dw	seg BCC_SEG_26
	db 01Eh,0B8h,020h
	db 000h,050h,09Ah,0D6h,004h
		dw	seg BCC_FAR_04CF
	db 083h,07Eh,006h,001h,075h,005h,09Ah
	db 0F8h,004h
		dw	seg BCC_FAR_04CF
	db 0B8h,023h,000h,050h,00Eh,0E8h,0ABh,0FEh,089h,016h
	db 098h,05Ch,0A3h,096h,05Ch,0B8h,023h,000h,050h,0B8h
		dw	seg BCC_FAR_04CF
	db 050h,0B8h
	db 068h,000h,050h,00Eh,0E8h,05Fh,0FEh,0B8h,01Bh,000h,050h,00Eh,0E8h,08Ch
	db 0FEh,089h,016h,0A0h,05Ch,0A3h,09Eh,05Ch,0B8h,01Bh,000h,050h,0B8h
		dw	seg BCC_FAR_04CF
	db 050h,0B8h,0D0h,000h,050h,00Eh,0E8h,040h,0FEh,0A1h,008h,000h,02Bh
	db 006h,004h,000h,0A3h,0A4h,05Ch,0FFh,076h,00Ah,0FFh,076h,008h,00Eh,0E8h
	db 014h,0FFh,09Ah,00Dh,000h
		dw	seg BCC_RF_15C5_010D
	db 016h,08Dh,046h,006h,050h,016h,08Dh
	db 046h,008h,050h,09Ah,02Fh,000h
		dw	seg X034_01
	db 0FFh,076h,006h,0FFh,076h,00Ah
	db 0FFh,076h,008h,09Ah,020h,000h
		dw	seg X036_00
	db 09Ah,089h,000h
		dw	seg BCC_RF_15C5_010D
	db 0A1h
	db 04Eh,017h,00Bh,006h,050h,017h,074h,02Dh,0FFh,036h,050h,017h,0FFh,036h
	db 04Eh,017h,01Eh,0A0h,015h,017h,098h,00Bh,0C0h,075h,00Ch,080h,03Eh,014h
	db 017h,000h,074h,005h,0B8h,09Ch,006h,0EBh,003h,0B8h,0A1h,006h,050h,09Ah
	db 034h,000h
		dw	seg X034_01
	db 089h,016h,050h,017h,0A3h,04Eh,017h,080h,03Eh,074h
	db 017h,000h,074h,00Dh,0A0h,009h,017h,098h,00Bh,0C0h,075h,005h,0C6h,006h
	db 009h,017h,001h,09Ah,025h,000h
		dw	seg X02E_00
	db 0FFh,04Eh,006h,083h,046h,008h
	db 004h,0EBh,007h,083h,046h,008h,004h,0FFh,04Eh,006h,083h,07Eh,006h,000h
	db 07Eh,018h,0C4h,05Eh,008h,026h,0C4h,01Fh,026h,080h,03Fh,02Dh,074h,0E7h
	db 0C4h,05Eh,008h,026h,0C4h,01Fh,026h,080h,03Fh,02Bh,074h,0DBh,083h,07Eh
	db 006h,000h,075h,009h,0B8h,049h,000h,050h,09Ah,043h,000h
		dw	seg X034_01
	db 08Bh
	db 046h,006h,089h,046h,0FEh,08Bh,046h,00Ah,08Bh,056h,008h,089h,046h,0FCh
	db 089h,056h,0FAh,0A0h,000h,017h,088h,046h,0F9h,0EBh,045h,0C4h,05Eh,008h
	db 026h,0C4h,01Fh,026h,080h,03Fh,02Dh,074h,011h,0C4h,05Eh,008h,026h,0FFh
	db 077h,002h,026h,0FFh,037h,09Ah,039h,000h
		dw	seg X034_01
	db 0EBh,021h,0C4h,05Eh
	db 008h,026h,0C4h,01Fh,026h,080h,07Fh,001h,076h,075h,014h,0C4h,05Eh,008h
	db 026h,08Bh,007h,040h,026h,0FFh,077h,002h,050h,033h,0C0h,050h,09Ah,04Dh
	db 000h
		dw	seg X02E_00
	db 083h,046h,008h,004h,0FFh,04Eh,006h,083h,07Eh,006h,000h
	db 07Fh,0B5h,08Ah,046h,0F9h,0A2h,000h,017h,0FFh,076h,0FEh,0FFh,076h,0FCh
	db 0FFh,076h,0FAh,09Ah,02Ah,000h
		dw	seg X034_01
	db 09Ah,0B7h,02Dh
		dw	seg BCC_FAR_245C
	db 02Bh
	db 006h,022h,078h,01Bh,016h,024h,078h,089h,056h,0F6h,089h,046h,0F4h,0A1h
	db 0F6h,029h,08Bh,016h,0F4h,029h,03Bh,046h,0F6h,07Ch,014h,07Fh,005h,03Bh
	db 056h,0F4h,076h,00Dh,08Bh,046h,0F6h,08Bh,056h,0F4h,0A3h,0F6h,029h,089h
	db 016h,0F4h,029h,083h,03Eh,0F6h,029h,000h,07Fh,015h,07Ch,007h,083h,03Eh
	db 0F4h,029h,000h,073h,00Ch,0C7h,006h,0F6h,029h,000h,000h,0C7h,006h,0F4h
	db 029h,000h,000h,0FFh,036h,0F6h,029h,0FFh,036h,0F4h,029h,01Eh,0B8h,064h
	db 000h,050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_ABBB
	db 083h,0C4h,008h,09Ah,067h,02Dh
		dw	seg BCC_FAR_245C
	db 083h,03Eh,09Eh,082h,000h,074h,005h,0B8h,001h,000h,0EBh,002h,033h
	db 0C0h,050h,00Eh,0E8h,01Bh,0FDh,08Bh,0E5h,05Dh,0CBh
CODE_1 ends
; END RMAIN13C
; BEGIN RDRV388 (complete source CODE_1:0388..04D6)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1
	db 055h,08Bh,0ECh,083h
	db 0ECh,012h,056h,08Bh,046h,006h,040h,0FFh,076h,008h,050h,09Ah,002h,000h
		dw	seg BCC_FAR_AB12
	db 0C4h,05Eh,006h,026h,088h,007h,016h,08Dh,046h,0EEh,050h,033h
	db 0C0h,050h,0B8h,00Eh,000h,050h,09Ah,003h,000h
		dw	seg BCC_FAR_AF23
	db 0A1h,014h,000h
	db 089h,046h,0EEh,08Bh,046h,008h,08Bh,056h,006h,089h,046h,0F2h,089h,056h
	db 0F0h,0FFh,076h,00Ch,0FFh,076h,00Ah,09Ah,001h,000h
		dw	seg BCC_SEG_42
	db 089h,056h
	db 0FEh,089h,046h,0FCh,00Bh,046h,0FEh,075h,027h,0B0h,000h,0A2h,0F9h,016h
	db 0A2h,0FAh,016h,0FFh,076h,00Ch,0FFh,076h,00Ah,0B8h,02Ch,000h,050h,09Ah
	db 01Bh,001h
		dw	seg BCC_DIAGNOSTIC
	db 083h,0C4h,006h,09Ah,067h,02Dh
		dw	seg BCC_FAR_245C
	db 0B8h,001h
	db 000h,050h,00Eh,0E8h,09Dh,0FCh,09Ah,0C7h,000h
		dw	seg BCC_RF_15C5_010D
	db 0B8h,01Bh,000h
	db 050h,0FFh,036h,0A0h,05Ch,0FFh,036h,09Eh,05Ch,00Eh,0E8h,0F1h,0FBh,0B8h
	db 023h,000h,050h,0FFh,036h,098h,05Ch,0FFh,036h,096h,05Ch,00Eh,0E8h,0E1h
	db 0FBh,0B8h,018h,000h,050h,0FFh,036h,09Ch,05Ch,0FFh,036h,09Ah,05Ch,00Eh
	db 0E8h,0D1h,0FBh,0FFh,076h,0FEh,0FFh,076h,0FCh,033h,0C0h,050h,016h,08Dh
	db 046h,0EEh,050h,09Ah,001h,000h
		dw	seg BCC_SEG_24
	db 08Bh,0F0h,0B8h,018h,000h,050h
	db 0B8h
		dw	seg BCC_COPY_WORDS
	db 050h,0B8h,04Fh,001h,050h,00Eh,0E8h,0ACh,0FBh,0B8h,023h
	db 000h,050h,0B8h
		dw	seg BCC_FAR_04CF
	db 050h,0B8h,068h,000h,050h,00Eh,0E8h,09Ch,0FBh
	db 0B8h,01Bh,000h,050h,0B8h
		dw	seg BCC_FAR_04CF
	db 050h,0B8h,0D0h,000h,050h,00Eh,0E8h
	db 08Ch,0FBh,09Ah,0D5h,000h
		dw	seg BCC_RF_15C5_010D
	db 08Bh,0C6h,025h,000h,0FFh,03Dh,000h
	db 001h,074h,00Ah,08Bh,0C6h,025h,000h,0FFh,03Dh,000h,002h,075h,00Dh,09Ah
	db 067h,02Dh
		dw	seg BCC_FAR_245C
	db 0B8h,001h,000h,050h,00Eh,0E8h,0FDh,0FBh,00Bh,0F6h
	db 07Dh,027h,0B0h,000h,0A2h,0F9h,016h,0A2h,0FAh,016h,0FFh,076h,00Ch,0FFh
	db 076h,00Ah,0B8h,02Ch,000h,050h,09Ah,01Bh,001h
		dw	seg BCC_DIAGNOSTIC
	db 083h,0C4h,006h
	db 09Ah,067h,02Dh
		dw	seg BCC_FAR_245C
	db 0B8h,001h,000h,050h,00Eh,0E8h,0D2h,0FBh,08Bh
	db 0C6h,05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h
CODE_1 ends
; END RDRV388
; BEGIN RPUTS (derived raw function CODE_1:04D6..04F8)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1
	db 055h,08Bh,0ECh,0B8h,001h,000h
	db 050h,0FFh,076h,008h,0FFh,076h,006h,0FFh,076h,008h,0FFh,076h,006h,09Ah
	db 002h,000h
		dw	seg BCC_FAR_AB12
	db 050h,09Ah,00Bh,000h
		dw	seg BCC_FAR_AB9B
	db 05Dh,0CAh,004h,000h
CODE_1 ends
; END RPUTS
; BEGIN R4F8 (derived raw prefix CODE_1:04F8..050F)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1

	db 055h
	db 08Bh
	db 0ECh
	db 01Eh
	db 0B8h
	db 07Eh
	db 000h
	db 050h
	db 00Eh
	db 0E8h
	db 0D2h
	db 0FFh
	db 033h
	db 0C0h
	db 050h
	db 09Ah
	db 046h
	db 001h
		dw	seg BCC_COPY_WORDS
	db 059h
	db 05Dh
	db 0CBh
CODE_1 ends
; END R4F8
; BEGIN RSTRLOW (complete source RSTRLOW head33 CODE_1:050F..0530)
CODE_1 segment byte public 'CODE'
	assume cs:CODE_1
	db 055h
	db 08Bh
	db 0ECh
	db 08Bh
	db 046h
	db 006h
	db 00Bh
	db 046h
	db 008h
	db 075h
	db 018h
	db 0EBh
	db 01Fh
	db 0C4h
	db 05Eh
	db 006h
	db 026h
	db 08Ah
	db 007h
	db 098h
	db 050h
	db 09Ah
	db 031h
	db 000h
		dw	seg BCC_FAR_AB51
	db 0C4h
	db 05Eh
	db 006h
	db 026h
	db 088h
	db 007h
	db 0FFh
CODE_1 ends
; END RSTRLOW
		end
