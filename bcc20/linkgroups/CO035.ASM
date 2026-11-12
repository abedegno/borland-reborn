; Recovered FBOV far-pointer references
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_04CF:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AF0C:far
		extrn	BCC_FAR_B146:far
		extrn	BCC_RF_1A47_0039:far
		extrn	BCC_RF_1AAA_0008:far
		extrn	BCC_SEG_16:far
CO033_TEXT	segment byte public 'CODE'
CO033_TEXT	ends
CO043_TEXT	segment byte public 'CODE'
CO043_TEXT	ends
CO056_TEXT	segment byte public 'CODE'
CO056_TEXT	ends
		public	X035_02
		public	X035_03
		public	X035_00
		public	X035_01
		public	X035_06
		public	X035_07
		public	X035_04
		public	X035_05
		public	X035_08
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cac_845f
; BEGIN C52UNIT (listing ovr_1cac_845f:45F0)

	extrn	BCC_RF_1AB2_000D:far
	extrn	BCC_TOKEN_TABLE:word
	extrn	BCC_RD_82D8_B:byte


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP

		public	X035_03
X035_03	label	far
BCC_TOKEN_MAP	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	mov	word ptr [bp-2],ds
	mov	word ptr [bp-4],offset DGROUP:BCC_TOKEN_TABLE
	jmp	short M000_@@TEST
M000_@@NEXT:
	les	bx,dword ptr [bp-4]
	mov	al,byte ptr [bp+8]
	cbw
	cmp	word ptr es:[bx+2],ax
	jne	short M000_@@ADVANCE
	mov	al,byte ptr es:[bx+4]
	cmp	al,byte ptr [bp+6]
	jne	short M000_@@ADVANCE
	mov	byte ptr DGROUP:BCC_RD_82D8_B+2,0
	mov	bx,word ptr es:[bx]
	mov	al,byte ptr [bx+1]
	cbw
	push	ax
	db	9Ah
	dw	BCC_RF_1AB2_000D
	dw	seg BCC_RF_1AB2_000D
	mov	byte ptr DGROUP:BCC_RD_82D8_B,al
	les	bx,dword ptr [bp-4]
	mov	bx,word ptr es:[bx]
	mov	al,byte ptr [bx+2]
	cbw
	push	ax
	db	9Ah
	dw	BCC_RF_1AB2_000D
	dw	seg BCC_RF_1AB2_000D
	mov	byte ptr DGROUP:BCC_RD_82D8_B+1,al
	mov	dx,ds
	mov	ax,offset DGROUP:BCC_RD_82D8_B
	jmp	short M000_@@DONE
M000_@@ADVANCE:
	add	word ptr [bp-4],7
M000_@@TEST:
	les	bx,dword ptr [bp-4]
	cmp	word ptr es:[bx],0
	jne	short M000_@@NEXT
	xor	dx,dx
	xor	ax,ax
M000_@@DONE:
	mov	sp,bp
	pop	bp
	retf	4
BCC_TOKEN_MAP	endp
CO035_TEXT	ends


	extrn	BCC_TOKEN_TABLE:word


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP

		public	X035_06
X035_06	label	far
BCC_TOKEN_FLAG	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	mov	word ptr [bp-2],ds
	mov	word ptr [bp-4],offset DGROUP:BCC_TOKEN_TABLE
	jmp	short M001_@@TEST
M001_@@NEXT:
	les	bx,dword ptr [bp-4]
	mov	al,byte ptr [bp+6]
	cbw
	cmp	word ptr es:[bx+2],ax
	jne	short M001_@@ADVANCE
	mov	al,byte ptr es:[bx+5]
	cbw
	jmp	short M001_@@DONE
M001_@@ADVANCE:
	add	word ptr [bp-4],7
M001_@@TEST:
	les	bx,dword ptr [bp-4]
	cmp	word ptr es:[bx],0
	jne	short M001_@@NEXT
	xor	ax,ax
M001_@@DONE:
	mov	sp,bp
	pop	bp
	retf	2
BCC_TOKEN_FLAG	endp
CO035_TEXT	ends

CO035_TEXT	segment byte public 'CODE'
		assume	cs:CO035_TEXT
; Original-image layout stub: not recovered source


X035_07	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,0FFh,076h,008h,0FFh,076h,006h,033h,0C0h; ovr_1cac_845f:4695
		db	033h,0D2h,050h,052h,050h,052h,01Eh,0B8h,0F4h,082h,050h,033h,0C0h,050h	; ovr_1cac_845f:46A3
		db	052h,09Ah
		dw	039h
		dw	seg BCC_RF_1A47_0039
		db	0C7h,006h,0DEh,082h,005h,000h,033h,0C0h; ovr_1cac_845f:46B1
		db	0A3h,004h,083h,0A3h,0E8h,082h,01Eh,0B8h,0E6h,028h,050h,090h,00Eh,0E8h	; ovr_1cac_845f:46BF
		db	07Bh,005h,0A3h,0E2h,082h,01Eh,0B8h,0ECh,028h,050h,090h,00Eh,0E8h,06Eh	; ovr_1cac_845f:46CD
		db	005h,0A3h,0F2h,082h,0C7h,006h,0EAh,082h,000h,000h,01Eh,0B8h,0F1h,028h	; ovr_1cac_845f:46DB
		db	050h,090h,00Eh,0E8h,05Bh,005h,0A3h,002h,083h,01Eh,0B8h,0F7h,028h,050h	; ovr_1cac_845f:46E9
		db	090h,00Eh,0E8h,04Eh,005h,0A3h,006h,083h,01Eh,0B8h,0F2h,028h,050h,090h	; ovr_1cac_845f:46F7
		db	00Eh,0E8h,041h,005h,0A3h,00Ch,083h,01Eh,0B8h,0F7h,028h,050h,090h,00Eh	; ovr_1cac_845f:4705
		db	0E8h,034h,005h,0A3h,0E4h,082h,01Eh,0B8h,0FEh,028h,050h,090h,00Eh,0E8h	; ovr_1cac_845f:4713
		db	027h,005h,0A3h,0DCh,082h,01Eh,0B8h,0FFh,028h,050h,090h,00Eh,0E8h,01Ah	; ovr_1cac_845f:4721
		db	005h,0A3h,0EEh,082h,0C7h,006h,0ECh,082h,001h,000h,0A0h,0EFh,016h,098h	; ovr_1cac_845f:472F
		db	08Bh,0D8h,083h,0FBh,005h,076h,003h,0E9h,0D6h,000h,0D1h,0E3h,02Eh,0FFh	; ovr_1cac_845f:473D
		db	0A7h,04Eh,006h,01Eh,0B8h,046h,078h,050h,01Eh,0B8h,0F4h,082h,050h,09Ah	; ovr_1cac_845f:474B
		dw	02h
		dw	seg BCC_FAR_AB12
		db	005h,006h,000h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h; ovr_1cac_845f:4759
		db	002h,083h,0FFh,036h,046h,078h,0FFh,036h,002h,083h,01Eh,0B8h,0F4h,082h	; ovr_1cac_845f:4767
		db	050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,036h,046h,078h,0FFh,036h,002h,083h; ovr_1cac_845f:4775
		db	01Eh,0B8h,0F1h,028h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0C7h,006h,0ECh,082h; ovr_1cac_845f:4783
		db	000h,000h,0C7h,006h,0E4h,082h,000h,000h,01Eh,0B8h,05Ah,028h,050h,090h	; ovr_1cac_845f:4791
		db	00Eh,0E8h,0A7h,004h,0A3h,0EEh,082h,0C7h,006h,006h,083h,000h,000h,01Eh	; ovr_1cac_845f:479F
		db	0B8h,003h,029h,050h,090h,00Eh,0E8h,094h,004h,0A3h,00Ch,083h,01Eh,0B8h	; ovr_1cac_845f:47AD
		db	046h,078h,050h,01Eh,0B8h,0F4h,082h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	005h; ovr_1cac_845f:47BB
		db	006h,000h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h,0E2h,082h,0FFh,036h,046h; ovr_1cac_845f:47C9
		db	078h,0FFh,036h,0E2h,082h,01Eh,0B8h,0F4h,082h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,036h,046h,078h,0FFh,036h,0E2h,082h,01Eh,0B8h,00Ch,029h,050h; ovr_1cac_845f:47D7
		db	09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0EBh,023h,080h,03Eh,009h,017h,000h,074h,01Ch; ovr_1cac_845f:47F3
		db	0A1h,0BEh,066h,089h,046h,0FAh,0C7h,006h,0BEh,066h,000h,000h,0B8h,023h	; ovr_1cac_845f:4801
		db	001h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,08Bh,046h,0FAh,0A3h,0BEh,066h; ovr_1cac_845f:480F
		db	080h,03Eh,076h,017h,000h,074h,018h,080h,03Eh,0EFh,016h,000h,074h,007h	; ovr_1cac_845f:481D
		db	080h,03Eh,0EFh,016h,005h,075h,00Ah,0B8h,039h,001h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0A0h,0EFh,016h,098h,0BAh,006h,000h,0F7h,0EAh,08Bh,0D8h; ovr_1cac_845f:482B
		db	0FFh,0B7h,096h,027h,0FFh,0B7h,094h,027h,01Eh,0B8h,012h,029h,050h,0B0h	; ovr_1cac_845f:4847
		db	0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	0A0h,0EFh,016h,098h; ovr_1cac_845f:4855
		db	0BAh,006h,000h,0F7h,0EAh,08Bh,0D8h,08Ah,087h,098h,027h,0A2h,0D2h,077h	; ovr_1cac_845f:4863
		db	0A0h,0EFh,016h,098h,0BAh,006h,000h,0F7h,0EAh,08Bh,0D8h,08Ah,087h,099h	; ovr_1cac_845f:4871
		db	027h,0A2h,0D1h,077h,080h,03Eh,00Ah,017h,000h,074h,044h,080h,03Eh,00Bh	; ovr_1cac_845f:487F
		db	017h,000h,074h,006h,01Eh,0B8h,015h,029h,0EBh,004h,01Eh,0B8h,026h,029h	; ovr_1cac_845f:488D
		db	050h,01Eh,0B8h,013h,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	080h,03Eh,00Ch,017h,000h,074h,015h,01Eh,0B8h,038h,029h; ovr_1cac_845f:489B
		db	050h,01Eh,0B8h,013h,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	01Eh,0B8h,040h,029h,0EBh,004h,01Eh,0B8h,048h,029h,050h; ovr_1cac_845f:48B7
		db	01Eh,0B8h,012h,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	080h,03Eh,076h,017h,000h,074h,038h,01Eh,0B8h,052h,029h,050h; ovr_1cac_845f:48D3
		db	01Eh,0B8h,013h,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	080h,03Eh,076h,017h,002h,074h,007h,080h,03Eh,076h,017h,005h; ovr_1cac_845f:48EF
		db	075h,015h,01Eh,0B8h,038h,029h,050h,01Eh,0B8h,012h,029h,050h,0B0h,0FFh	; ovr_1cac_845f:490B
		db	050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	01Eh,0B8h,05Bh,029h,050h; ovr_1cac_845f:4919
		db	01Eh,0B8h,066h,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	01Eh,0B8h,06Eh,029h,050h,01Eh,0B8h,07Bh,029h,050h,0B0h,0FFh; ovr_1cac_845f:4927
		db	050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	080h,03Eh,062h,017h,000h; ovr_1cac_845f:4943
		db	074h,02Ah,01Eh,0B8h,083h,029h,050h,01Eh,0B8h,07Bh,029h,050h,0B0h,0FFh	; ovr_1cac_845f:4951
		db	050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	01Eh,0B8h,092h,029h,050h; ovr_1cac_845f:495F
		db	01Eh,0B8h,07Bh,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	080h,03Eh,009h,017h,000h,074h,015h,01Eh,0B8h,0A1h,029h,050h; ovr_1cac_845f:496D
		db	01Eh,0B8h,012h,029h,050h,0B0h,0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	080h,03Eh,005h,017h,001h,075h,00Ah,08Ch,05Eh,0FEh,0C7h,046h; ovr_1cac_845f:4989
		db	0FCh,0ADh,029h,0EBh,019h,080h,03Eh,005h,017h,002h,075h,00Ah,08Ch,05Eh	; ovr_1cac_845f:49A5
		db	0FEh,0C7h,046h,0FCh,0B8h,029h,0EBh,008h,08Ch,05Eh,0FEh,0C7h,046h,0FCh	; ovr_1cac_845f:49B3
		db	0C5h,029h,0FFh,076h,0FEh,0FFh,076h,0FCh,01Eh,0B8h,012h,029h,050h,0B0h	; ovr_1cac_845f:49C1
		db	0FFh,050h,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO033_TEXT
		db	0C4h,01Eh,01Ah,017h; ovr_1cac_845f:49CF
		db	026h,080h,03Fh,02Ah,074h,010h,0FFh,036h,01Ch,017h,0FFh,036h,01Ah,017h	; ovr_1cac_845f:49DD
		db	090h,00Eh,0E8h,05Ah,002h,0A3h,0E2h,082h,0C4h,01Eh,01Eh,017h,026h,080h	; ovr_1cac_845f:49EB
		db	03Fh,02Ah,074h,01Eh,026h,080h,03Fh,000h,075h,008h,0C7h,006h,0EAh,082h	; ovr_1cac_845f:49F9
		db	000h,000h,0EBh,010h,0FFh,036h,020h,017h,0FFh,036h,01Eh,017h,090h,00Eh	; ovr_1cac_845f:4A07
		db	0E8h,032h,002h,0A3h,0EAh,082h,0C4h,01Eh,022h,017h,026h,080h,03Fh,02Ah	; ovr_1cac_845f:4A15
		db	074h,010h,0FFh,036h,024h,017h,0FFh,036h,022h,017h,090h,00Eh,0E8h,018h	; ovr_1cac_845f:4A23
		db	002h,0A3h,0F2h,082h,0C4h,01Eh,032h,017h,026h,080h,03Fh,02Ah,074h,010h	; ovr_1cac_845f:4A31
		db	0FFh,036h,034h,017h,0FFh,036h,032h,017h,090h,00Eh,0E8h,0FEh,001h,0A3h	; ovr_1cac_845f:4A3F
		db	0DCh,082h,0C4h,01Eh,036h,017h,026h,080h,03Fh,02Ah,074h,01Eh,026h,080h	; ovr_1cac_845f:4A4D
		db	03Fh,000h,075h,008h,0C7h,006h,0E4h,082h,000h,000h,0EBh,010h,0FFh,036h	; ovr_1cac_845f:4A5B
		db	038h,017h,0FFh,036h,036h,017h,090h,00Eh,0E8h,0D6h,001h,0A3h,0E4h,082h	; ovr_1cac_845f:4A69
		db	0C4h,01Eh,03Ah,017h,026h,080h,03Fh,02Ah,074h,010h,0FFh,036h,03Ch,017h	; ovr_1cac_845f:4A77
		db	0FFh,036h,03Ah,017h,090h,00Eh,0E8h,0BCh,001h,0A3h,0EEh,082h,0C4h,01Eh	; ovr_1cac_845f:4A85
		db	026h,017h,026h,080h,03Fh,02Ah,074h,010h,0FFh,036h,028h,017h,0FFh,036h	; ovr_1cac_845f:4A93
		db	026h,017h,090h,00Eh,0E8h,0A2h,001h,0A3h,002h,083h,0C4h,01Eh,02Ah,017h	; ovr_1cac_845f:4AA1
		db	026h,080h,03Fh,02Ah,074h,01Eh,026h,080h,03Fh,000h,075h,008h,0C7h,006h	; ovr_1cac_845f:4AAF
		db	006h,083h,000h,000h,0EBh,010h,0FFh,036h,02Ch,017h,0FFh,036h,02Ah,017h	; ovr_1cac_845f:4ABD
		db	090h,00Eh,0E8h,07Ah,001h,0A3h,006h,083h,0C4h,01Eh,02Eh,017h,026h,080h	; ovr_1cac_845f:4ACB
		db	03Fh,02Ah,074h,010h,0FFh,036h,030h,017h,0FFh,036h,02Eh,017h,090h,00Eh	; ovr_1cac_845f:4AD9
		db	0E8h,060h,001h,0A3h,00Ch,083h,08Eh,006h,046h,078h,08Bh,01Eh,0EEh,082h	; ovr_1cac_845f:4AE7
		db	026h,080h,03Fh,000h,074h,039h,0C7h,006h,0ECh,082h,001h,000h,083h,03Eh	; ovr_1cac_845f:4AF5
		db	006h,083h,000h,074h,020h,083h,03Eh,0E4h,082h,000h,074h,019h,0FFh,036h	; ovr_1cac_845f:4B03
		db	046h,078h,0FFh,036h,006h,083h,0FFh,036h,046h,078h,0FFh,036h,0E4h,082h	; ovr_1cac_845f:4B11
		db	09Ah
		dw	08h
		dw	seg BCC_RF_1AAA_0008
		db	00Bh,0C0h,074h,005h,0B8h,001h,000h,0EBh,002h; ovr_1cac_845f:4B1F
		db	033h,0C0h,0A3h,0E6h,082h,0EBh,006h,0C7h,006h,0E6h,082h,000h,000h,0A1h	; ovr_1cac_845f:4B2D
		db	04Eh,017h,00Bh,006h,050h,017h,074h,020h,080h,03Eh,014h,017h,000h,074h	; ovr_1cac_845f:4B3B
		db	007h,080h,03Eh,015h,017h,000h,075h,012h,0FFh,036h,050h,017h,0FFh,036h	; ovr_1cac_845f:4B49
		db	04Eh,017h,090h,00Eh,0E8h,0ECh,000h,0A3h,046h,086h,0EBh,060h,01Eh,0B8h	; ovr_1cac_845f:4B57
		db	046h,078h,050h,0FFh,036h,04Ch,017h,0FFh,036h,04Ah,017h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	050h,01Eh,0B8h,0F4h,082h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	05Ah; ovr_1cac_845f:4B65
		db	003h,0D0h,083h,0C2h,006h,052h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h,046h,086h; ovr_1cac_845f:4B81
		db	0FFh,036h,046h,078h,0FFh,036h,046h,086h,0FFh,036h,04Ch,017h,0FFh,036h	; ovr_1cac_845f:4B8F
		db	04Ah,017h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,036h,046h,078h,0FFh,036h,046h; ovr_1cac_845f:4B9D
		db	086h,09Ah
		dw	03h
		dw	seg BCC_SEG_16
		db	0FFh,036h,046h,078h,0FFh,036h,046h,086h; ovr_1cac_845f:4BAB
		db	01Eh,0B8h,0F4h,082h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0FFh,036h,046h,078h; ovr_1cac_845f:4BB9
		db	0FFh,036h,0E2h,082h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh; ovr_1cac_845f:4BC7
		db	036h,0F2h,082h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h; ovr_1cac_845f:4BD5
		db	0EAh,082h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h,002h; ovr_1cac_845f:4BE3
		db	083h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h,00Ch,083h; ovr_1cac_845f:4BF1
		db	09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h,006h,083h,09Ah; ovr_1cac_845f:4BFF
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h,0DCh,082h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h,0EEh,082h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,036h,046h,078h,0FFh,036h,0E4h,082h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	08Bh,0E5h,05Dh,0CAh,004h,000h,00Ah,002h,00Ah,002h,0C9h,001h,00Ah; ovr_1cac_845f:4C0D
		db	002h,0C9h,001h,05Eh,001h	; ovr_1cac_845f:4C45

CO035_TEXT	ends

	extrn	BCC_STRING_LENGTH:far
	extrn	X043_02:far
	extrn	BCC_STRING_COPY:far
	extrn	BCC_LITERAL_POOL:word


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP

		public	X035_05
X035_05	label	far
BCC_INTERN_STRING	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	ds
	mov	ax,offset DGROUP:BCC_LITERAL_POOL
	push	ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	inc	ax
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	si,ax
	push	word ptr DGROUP:BCC_LITERAL_POOL
	push	si
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	mov	ax,si
	pop	si
	pop	bp
	retf	4
BCC_INTERN_STRING	endp
CO035_TEXT	ends

CO035_TEXT	segment byte public 'CODE'
		assume	cs:CO035_TEXT
; Original-image layout stub: not recovered source


X035_00	label	far
		db	055h,08Bh,0ECh,083h,0ECh,00Ah,056h,057h,01Eh,0B8h,003h,029h,050h,00Eh; ovr_1cac_845f:4C7E
		db	0E8h,0BBh,0FFh,08Bh,0F8h,0C4h,01Eh,046h,017h,026h,080h,03Fh,02Ah,074h	; ovr_1cac_845f:4C8C
		db	018h,0FFh,036h,048h,017h,0FFh,036h,046h,017h,00Eh,0E8h,0A3h,0FFh,08Bh	; ovr_1cac_845f:4C9A
		db	0F8h,0FFh,036h,046h,078h,057h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0C4h,01Eh,03Eh; ovr_1cac_845f:4CA8
		db	017h,026h,080h,03Fh,02Ah,075h,069h,0FFh,036h,0DEh,082h,016h,08Dh,046h	; ovr_1cac_845f:4CB6
		db	0F6h,050h,09Ah
		dw	0CCh
		dw	seg BCC_FAR_AF0C
		db	0FFh,006h,0DEh,082h,01Eh,0B8h,046h; ovr_1cac_845f:4CC4
		db	078h,050h,01Eh,0B8h,0F4h,082h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	050h,016h; ovr_1cac_845f:4CD2
		db	08Dh,046h,0F6h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	05Ah,003h,0D0h,083h,0C2h; ovr_1cac_845f:4CE0
		db	005h,052h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,0FFh,036h,046h,078h,056h; ovr_1cac_845f:4CEE
		db	01Eh,0B8h,0F4h,082h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,036h,046h,078h; ovr_1cac_845f:4CFC
		db	056h,016h,08Dh,046h,0F6h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0FFh,036h,046h; ovr_1cac_845f:4D0A
		db	078h,056h,01Eh,0B8h,0CFh,029h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0EBh,00Eh; ovr_1cac_845f:4D18
		db	0FFh,036h,040h,017h,0FFh,036h,03Eh,017h,00Eh,0E8h,018h,0FFh,08Bh,0F0h	; ovr_1cac_845f:4D26
		db	0FFh,036h,046h,078h,056h,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0C4h,01Eh,042h,017h; ovr_1cac_845f:4D34
		db	026h,080h,03Fh,02Ah,075h,007h,0C7h,046h,0FEh,000h,000h,0EBh,01Bh,0FFh	; ovr_1cac_845f:4D42
		db	036h,044h,017h,0FFh,036h,042h,017h,00Eh,0E8h,0EFh,0FEh,089h,046h,0FEh	; ovr_1cac_845f:4D50
		db	0FFh,036h,046h,078h,0FFh,076h,0FEh,09Ah
		dw	050Fh
		dw	seg BCC_FAR_04CF
		db	0B8h,010h; ovr_1cac_845f:4D5E
		db	000h,050h,056h,0FFh,076h,0FEh,057h,09Ah
		dw	066h
		dw	seg CO056_TEXT
		db	05Fh,05Eh; ovr_1cac_845f:4D6C
		db	08Bh,0E5h,05Dh,0CBh	; ovr_1cac_845f:4D7A

CO035_TEXT	ends

	extrn	BCC_RD_8606_W:word
	extrn	BCC_MODE_HOOK:word


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP

		public	X035_01
X035_01	label	far
BCC_EMIT_MODE	proc	far
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+6]
	mov	es,word ptr DGROUP:BCC_RD_8606_W
	cmp	word ptr es:[si+2],16
	jne	short M005_@@SHORT_MODE
	mov	ax,7
	jmp	short M005_@@EMIT
M005_@@SHORT_MODE:
	mov	ax,5
M005_@@EMIT:
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_MODE_HOOK
	pop	si
	pop	bp
	retf	2
BCC_EMIT_MODE	endp
CO035_TEXT	ends


	extrn	X056_0D:far
	extrn	BCC_STREAM_HOOK:word
	extrn	BCC_TYPE_HOOK:word
	extrn	BCC_FLAG_HOOK:word
	extrn	BCC_BYTE_HOOK:word
	extrn	BCC_WORD_HOOK:word
	extrn	BCC_ALT_HOOK:word
	extrn	BCC_OPTION_16EF:byte


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP

		public	X035_08
X035_08	label	far
BCC_EMIT_PAIR	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	mov	si,word ptr [bp+12]
	mov	ax,2
	push	ax
	push	word ptr [bp+8]
	xor	ax,ax
	push	ax
	push	word ptr [bp+6]
	db	9Ah
	dw	X056_0D
	dw	seg X056_0D
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_STREAM_HOOK
	mov	word ptr [bp-2],ax
	push	si
	db	0FFh,01Eh
	dw	DGROUP:BCC_TYPE_HOOK
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_FLAG_HOOK
	test	ax,1
	je	short M006_@@FALSE
	mov	al,1
	jmp	short M006_@@FLAG_READY
M006_@@FALSE:
	mov	al,0
M006_@@FLAG_READY:
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_BYTE_HOOK
	mov	al,byte ptr [bp+10]
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_BYTE_HOOK
	cmp	byte ptr DGROUP:BCC_OPTION_16EF,0
	jne	short M006_@@ALTERNATE
	push	si
	xor	ax,ax
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_WORD_HOOK
	mov	al,0
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_BYTE_HOOK
	mov	al,0
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_BYTE_HOOK
	jmp	short M006_@@RESTORE
M006_@@ALTERNATE:
	push	si
	xor	ax,ax
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_ALT_HOOK
M006_@@RESTORE:
	push	word ptr [bp-2]
	db	0FFh,01Eh
	dw	DGROUP:BCC_STREAM_HOOK
	pop	si
	mov	sp,bp
	pop	bp
	retf	8
BCC_EMIT_PAIR	endp
CO035_TEXT	ends


	extrn	BCC_NAME_A1:byte
	extrn	BCC_NAME_A2:byte
	extrn	BCC_SYMBOL_A2:word
		extrn	BCC_RD_E83E_W:word
		extrn	BCC_RD_82E8_W:word


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP
		public	X035_02
X035_02	label	far
BCC_FAR_4E1C	label	far

BCC_EMIT_A	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_E83E_W,0
	jne	short M007_@@EMIT
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_A1
	push	ax
	push	cs
	db	0E8h,01Bh,0FEh
	mov	word ptr DGROUP:BCC_RD_82E8_W,ax
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_A2
	push	ax
	push	cs
	db	0E8h,00Fh,0FEh
	mov	word ptr DGROUP:BCC_SYMBOL_A2,ax
M007_@@EMIT:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	word ptr DGROUP:BCC_RD_82E8_W
	push	word ptr DGROUP:BCC_SYMBOL_A2
	push	cs
	db	0E8h,052h,0FFh
	pop	bp
	retf	4
BCC_EMIT_A	endp
CO035_TEXT	ends


	extrn	BCC_NAME_B1:byte
	extrn	BCC_NAME_B2:byte
	extrn	BCC_SYMBOL_B2:word
		extrn	BCC_RD_043E_W:word
		extrn	BCC_RD_8304_W:word


CO035_TEXT	segment byte public 'CODE'
	assume	cs:CO035_TEXT,ds:DGROUP
		public	X035_04
X035_04	label	far
BCC_FAR_4E54	label	far

BCC_EMIT_B	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_043E_W,0
	jne	short M008_@@EMIT
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_B1
	push	ax
	push	cs
	db	0E8h,0E3h,0FDh
	mov	word ptr DGROUP:BCC_RD_8304_W,ax
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_B2
	push	ax
	push	cs
	db	0E8h,0D7h,0FDh
	mov	word ptr DGROUP:BCC_SYMBOL_B2,ax
M008_@@EMIT:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	word ptr DGROUP:BCC_RD_8304_W
	push	word ptr DGROUP:BCC_SYMBOL_B2
	push	cs
	db	0E8h,01Ah,0FFh
	pop	bp
	retf	4
BCC_EMIT_B	endp
CO035_TEXT	ends

; END C52UNIT
		end
