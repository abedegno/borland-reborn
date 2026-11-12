; Recovered FBOV far-pointer references
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_04CF:far
		extrn	BCC_FAR_245C:far
		extrn	BCC_FAR_5E22:far
		extrn	BCC_FAR_A7C4:far
		extrn	BCC_FAR_A9C1:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AB75:far
		extrn	BCC_FAR_ABBB:far
		extrn	BCC_FAR_B146:far
		extrn	BCC_RF_15C5_010D:far
		extrn	BCC_RF_1A47_0039:far
		extrn	BCC_RF_1AAA_0008:far
		extrn	BCC_SEG_16:far
CO02E_TEXT	segment byte public 'CODE'
CO02E_TEXT	ends
CO037_TEXT	segment byte public 'CODE'
CO037_TEXT	ends
		public	X034_02
		public	X034_03
		public	X034_00
		public	X034_01
		public	X034_06
		public	X034_07
		public	X034_04
		public	X034_05
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1ca7_833a
; BEGIN C51UNIT (listing ovr_1ca7_833a:33A0)
CO034_TEXT	segment byte public 'CODE'
		assume	cs:CO034_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,012h,0FFh,076h,006h,0FFh,076h,004h,033h	; ovr_1ca7_833a:33A0
		db	0C0h,033h,0D2h,050h,052h,050h,052h,016h,08Dh,046h,0F0h,050h,016h,08Dh	; ovr_1ca7_833a:33AE
		db	046h,0FAh,050h,09Ah
		dw	039h
		dw	seg BCC_RF_1A47_0039
		db	016h,08Dh,046h,0FAh,050h,01Eh; ovr_1ca7_833a:33BC
		db	0B8h,019h,025h,050h,09Ah
		dw	08h
		dw	seg BCC_RF_1AAA_0008
		db	00Bh,0C0h,075h,044h,0FFh; ovr_1ca7_833a:33CA
		db	076h,006h,0FFh,076h,004h,0E8h,0C5h,00Dh,0A1h,05Eh,017h,00Bh,006h,060h	; ovr_1ca7_833a:33D8
		db	017h,074h,003h,0E9h,0D8h,000h,0FFh,076h,006h,0FFh,076h,004h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	010Dh
		dw	seg BCC_RF_15C5_010D
		db	089h,016h,060h,017h; ovr_1ca7_833a:33E6
		db	0A3h,05Eh,017h,0FFh,036h,060h,017h,0FFh,036h,05Eh,017h,0FFh,076h,006h	; ovr_1ca7_833a:3402
		db	0FFh,076h,004h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0E9h,0A9h,000h,0FFh,076h,006h; ovr_1ca7_833a:3410
		db	0FFh,076h,004h,09Ah
		dw	04D6h
		dw	seg BCC_FAR_04CF
		db	01Eh,0B8h,04Dh,026h,050h,09Ah; ovr_1ca7_833a:341E
		dw	04D6h
		dw	seg BCC_FAR_04CF
		db	016h,08Dh,046h,0FAh,050h,01Eh,0B8h,051h,026h,050h; ovr_1ca7_833a:342C
		db	09Ah
		dw	08h
		dw	seg BCC_RF_1AAA_0008
		db	00Bh,0C0h,075h,014h,0FFh,076h,006h,0FFh,076h; ovr_1ca7_833a:343A
		db	004h,033h,0C0h,050h,0B8h,001h,000h,050h,090h,00Eh,0E8h,099h,001h,0EBh	; ovr_1ca7_833a:3448
		db	031h,0A0h,062h,017h,088h,046h,0EFh,016h,08Dh,046h,0FAh,050h,01Eh,0B8h	; ovr_1ca7_833a:3456
		db	056h,026h,050h,09Ah
		dw	08h
		dw	seg BCC_RF_1AAA_0008
		db	00Bh,0C0h,075h,009h,080h,00Eh; ovr_1ca7_833a:3464
		db	062h,017h,001h,080h,04Eh,0EFh,002h,0FFh,076h,006h,0FFh,076h,004h,0E8h	; ovr_1ca7_833a:3472
		db	0A1h,003h,08Ah,046h,0EFh,0A2h,062h,017h,0FFh,076h,006h,0FFh,076h,004h	; ovr_1ca7_833a:3480
		db	0E8h,014h,00Dh,0A1h,05Eh,017h,00Bh,006h,060h,017h,075h,02Ah,016h,08Dh	; ovr_1ca7_833a:348E
		db	046h,0F0h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	010Dh
		dw	seg BCC_RF_15C5_010D
		db	089h,016h,060h,017h,0A3h,05Eh,017h,0FFh,036h,060h,017h,0FFh,036h; ovr_1ca7_833a:349C
		db	05Eh,017h,016h,08Dh,046h,0F0h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0B8h,001h; ovr_1ca7_833a:34B8
		db	000h,08Bh,0E5h,05Dh,04Dh,0C2h,004h,000h	; ovr_1ca7_833a:34C6

CO034_TEXT	ends

	extrn	BCC_RF_1A47_0039:far
	extrn	BCC_STRING_LENGTH:far
	extrn	BCC_RF_15C5_010D:far
	extrn	BCC_STRING_COPY:far
	extrn	BCC_STRING_APPEND:far


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

		public	X034_06
X034_06	label	far
BCC_STRING_CONCAT	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	push	word ptr [bp+12]
	push	word ptr [bp+10]
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	push	ax
	push	dx
	push	ax
	push	dx
	push	ax
	push	dx
	db	9Ah
	dw	BCC_RF_1A47_0039
	dw	seg BCC_RF_1A47_0039
	test	ax,2
	jne	short M001_@@DONE
	push	word ptr [bp+12]
	push	word ptr [bp+10]
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	push	ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	pop	dx
	add	dx,ax
	inc	dx
	push	dx
	db	9Ah
	dw	BCC_RF_15C5_010D
	dw	seg BCC_RF_15C5_010D
	mov	word ptr [bp-2],dx
	mov	word ptr [bp-4],ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	push	word ptr [bp+12]
	push	word ptr [bp+10]
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_APPEND
	dw	seg BCC_STRING_APPEND
	mov	ax,word ptr [bp-2]
	mov	dx,word ptr [bp-4]
	mov	word ptr [bp+12],ax
	mov	word ptr [bp+10],dx
M001_@@DONE:
	mov	dx,word ptr [bp+12]
	mov	ax,word ptr [bp+10]
	mov	sp,bp
	pop	bp
	retf	8
BCC_STRING_CONCAT	endp
CO034_TEXT	ends




CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_STRING_CONCAT_NEAR	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	word ptr [bp+10]
	push	word ptr [bp+8]
	db	0E8h,047h,00Ch
	push	word ptr [bp+10]
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	push	cs
	db	0E8h,060h,0FFh
	pop	bp
	dec	bp
	ret	8
BCC_STRING_CONCAT_NEAR	endp
CO034_TEXT	ends


	extrn	BCC_OUTPUT_ERROR:far
	extrn	BCC_PATH_EMPTY:byte
	extrn	BCC_STATE_16F9:byte
	extrn	BCC_STATE_16FA:byte
	extrn	BCC_STATE_829E:word


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

		public	X034_07
X034_07	label	far
BCC_STRING_PATH_APPEND	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	0E8h,01Fh,00Bh
	or	ax,ax
	jne	short M003_@@DONE
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PATH_EMPTY
	push	ax
	push	cs
	db	0E8h,039h,0FFh
	mov	word ptr [bp+8],dx
	mov	word ptr [bp+6],ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	mov	ax,0
	push	ax
	db	0E8h,045h,00Bh
	or	ax,ax
	jge	short M003_@@DONE
	mov	al,byte ptr DGROUP:BCC_STATE_16F9
	mov	ah,0
	mov	word ptr [bp-2],ax
	mov	al,byte ptr DGROUP:BCC_STATE_16FA
	mov	ah,0
	mov	word ptr [bp-4],ax
	mov	al,0
	mov	byte ptr DGROUP:BCC_STATE_16F9,al
	mov	byte ptr DGROUP:BCC_STATE_16FA,al
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	mov	ax,5Ch
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_ERROR
	dw	seg BCC_OUTPUT_ERROR
	add	sp,6
	mov	word ptr DGROUP:BCC_STATE_829E,1
	mov	al,byte ptr [bp-2]
	mov	byte ptr DGROUP:BCC_STATE_16F9,al
	mov	al,byte ptr [bp-4]
	mov	byte ptr DGROUP:BCC_STATE_16FA,al
M003_@@DONE:
	mov	sp,bp
	pop	bp
	retf	4
BCC_STRING_PATH_APPEND	endp
CO034_TEXT	ends

CO034_TEXT	segment byte public 'CODE'
		assume	cs:CO034_TEXT
; Original-image layout stub: not recovered source


X034_03	label	far
		db	055h,08Bh,0ECh,081h,0ECh,0E6h,000h,056h,057h,08Dh,086h,06Dh,0FFh,08Bh; ovr_1ca7_833a:35EE
		db	0F0h,033h,0C0h,0A3h,0BEh,066h,0A3h,0C4h,066h,0FFh,076h,00Ch,0FFh,076h	; ovr_1ca7_833a:35FC
		db	00Ah,0E8h,077h,002h,016h,08Dh,086h,01Ah,0FFh,050h,0FFh,076h,00Ch,0FFh	; ovr_1ca7_833a:360A
		db	076h,00Ah,0B8h,050h,000h,050h,09Ah
		dw	02Dh
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,076h,00Ch; ovr_1ca7_833a:3618
		db	0FFh,076h,00Ah,033h,0C0h,033h,0D2h,050h,052h,050h,052h,016h,08Dh,046h	; ovr_1ca7_833a:3626
		db	0F0h,050h,033h,0C0h,050h,052h,09Ah
		dw	039h
		dw	seg BCC_RF_1A47_0039
		db	0FFh,076h,00Ch; ovr_1ca7_833a:3634
		db	0FFh,076h,00Ah,0E8h,05Dh,00Bh,01Eh,056h,0FFh,076h,00Ch,0FFh,076h,00Ah	; ovr_1ca7_833a:3642
		db	09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	080h,03Eh,009h,017h,000h,075h,007h,080h,03Eh; ovr_1ca7_833a:3650
		db	076h,017h,000h,074h,00Ch,01Eh,056h,01Eh,0B8h,05Bh,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0A0h,0EFh,016h,098h,08Bh,0D8h,083h,0FBh,005h,077h,023h; ovr_1ca7_833a:365E
		db	0D1h,0E3h,02Eh,0FFh,0A7h,077h,004h,0BFh,05Eh,026h,0EBh,017h,0BFh,06Ah	; ovr_1ca7_833a:367A
		db	026h,0EBh,012h,0BFh,077h,026h,0EBh,00Dh,0BFh,085h,026h,0EBh,008h,0BFh	; ovr_1ca7_833a:3688
		db	094h,026h,0EBh,003h,0BFh,0A1h,026h,01Eh,056h,01Eh,057h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	080h,03Eh,005h,017h,001h,075h,008h,01Eh,056h,01Eh,0B8h,0ADh; ovr_1ca7_833a:3696
		db	026h,0EBh,015h,080h,03Eh,005h,017h,002h,075h,008h,01Eh,056h,01Eh,0B8h	; ovr_1ca7_833a:36B2
		db	0BBh,026h,0EBh,006h,01Eh,056h,01Eh,0B8h,0CBh,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,056h,01Eh,080h,03Eh,0F3h,016h,001h,075h,005h,0B8h,0D8h; ovr_1ca7_833a:36C0
		db	026h,0EBh,003h,0B8h,0DBh,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	080h,03Eh; ovr_1ca7_833a:36DC
		db	000h,017h,000h,074h,012h,083h,07Eh,006h,000h,074h,00Ch,01Eh,056h,01Eh	; ovr_1ca7_833a:36EA
		db	0B8h,0DEh,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,056h,01Eh,0B8h,0E2h; ovr_1ca7_833a:36F8
		db	026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0A1h,056h,024h,08Bh,016h,054h,024h; ovr_1ca7_833a:3706
		db	0EBh,027h,01Eh,056h,01Eh,0B8h,0E6h,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,056h,08Bh,046h,0FAh,005h,004h,000h,0FFh,076h,0FCh,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0C4h,05Eh,0FAh,026h,08Bh,047h,002h,026h,08Bh,017h,089h; ovr_1ca7_833a:3722
		db	046h,0FCh,089h,056h,0FAh,08Bh,046h,0FAh,00Bh,046h,0FCh,075h,0CBh,01Eh	; ovr_1ca7_833a:373E
		db	056h,01Eh,0B8h,0E9h,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	083h,07Eh,006h; ovr_1ca7_833a:374C
		db	000h,075h,020h,0A1h,04Eh,017h,00Bh,006h,050h,017h,074h,017h,0FFh,036h	; ovr_1ca7_833a:375A
		db	050h,017h,0FFh,036h,04Eh,017h,0E8h,014h,001h,01Eh,056h,0FFh,036h,050h	; ovr_1ca7_833a:3768
		db	017h,0FFh,036h,04Eh,017h,0EBh,038h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	08Bh,0D6h,003h,0D0h,089h,056h,0FEh,0FFh,036h,04Ch,017h,0FFh,036h,04Ah	; ovr_1ca7_833a:3784
		db	017h,0E8h,0EFh,000h,01Eh,056h,0FFh,036h,04Ch,017h,0FFh,036h,04Ah,017h	; ovr_1ca7_833a:3792
		db	09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,0FFh,076h,0FEh,09Ah
		dw	03h
		dw	seg BCC_SEG_16
		db	01Eh,056h,016h,08Dh,046h,0F0h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,056h; ovr_1ca7_833a:37AE
		db	01Eh,0B8h,0ECh,026h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	0FFh,036h,0BEh,024h; ovr_1ca7_833a:37BC
		db	0FFh,036h,0BCh,024h,016h,08Dh,086h,06Ch,0FFh,050h,09Ah
		dw	0388h
		dw	seg BCC_FAR_04CF
		db	089h,046h,0EEh,083h,07Eh,0EEh,00Bh,075h,00Eh,09Ah
		dw	02D67h
		dw	seg BCC_FAR_245C
		db	0B8h,001h,000h,050h,09Ah
		dw	09Fh
		dw	seg BCC_FAR_04CF
		db	083h,07Eh,0EEh,000h; ovr_1ca7_833a:37CA
		db	074h,008h,0C7h,006h,09Eh,082h,001h,000h,0EBh,011h,083h,07Eh,008h,000h	; ovr_1ca7_833a:37F4
		db	074h,00Bh,016h,08Dh,086h,01Ah,0FFh,050h,09Ah
		dw	05h
		dw	seg BCC_FAR_AB75
		db	05Fh; ovr_1ca7_833a:3802
		db	05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h,0E1h,002h,0E6h,002h,0EBh,002h,0F0h	; ovr_1ca7_833a:3810
		db	002h,0F5h,002h,0FAh,002h,045h,055h,08Bh,0ECh,04Ch,04Ch,0FFh,076h,006h	; ovr_1ca7_833a:381E
		db	0FFh,076h,004h,09Ah
		dw	02Ah
		dw	seg CO02E_TEXT
		db	089h,046h,0FEh,083h,07Eh,0FEh; ovr_1ca7_833a:382C
		db	000h,075h,007h,083h,03Eh,044h,086h,000h,074h,017h,0FFh,036h,044h,086h	; ovr_1ca7_833a:383A
		db	01Eh,0B8h,0A4h,010h,050h,09Ah
		dw	0Bh
		dw	seg BCC_FAR_ABBB
		db	083h,0C4h,006h,0C7h; ovr_1ca7_833a:3848
		db	006h,09Eh,082h,001h,000h,08Bh,0E5h,05Dh,04Dh,0C2h,004h,000h	; ovr_1ca7_833a:3856

CO034_TEXT	ends

	extrn	BCC_OUTPUT_CHAR:far


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_PUT_STRING	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	jmp	short M005_@@TEST
M005_@@NEXT:
	les	bx,dword ptr [bp+4]
	inc	word ptr [bp+4]
	mov	al,byte ptr es:[bx]
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_CHAR
	dw	seg BCC_OUTPUT_CHAR
M005_@@TEST:
	les	bx,dword ptr [bp+4]
	cmp	byte ptr es:[bx],0
	jne	short M005_@@NEXT
	pop	bp
	dec	bp
	ret	4
BCC_PUT_STRING	endp
CO034_TEXT	ends


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP


BCC_SLASH_FIX	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	jmp	short M006_@@TEST
M006_@@NEXT:
	les	bx,dword ptr [bp+4]
	cmp	byte ptr es:[bx],2Fh
	jne	short M006_@@ADVANCE
	mov	byte ptr es:[bx],5Ch
M006_@@ADVANCE:
	inc	word ptr [bp+4]
M006_@@TEST:
	les	bx,dword ptr [bp+4]
	cmp	byte ptr es:[bx],0
	jne	short M006_@@NEXT
	pop	bp
	dec	bp
	ret	4
BCC_SLASH_FIX	endp
CO034_TEXT	ends




CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_PUT_PATH	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	db	0E8h,0CFh,0FFh
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	db	0E8h,0A3h,0FFh
	pop	bp
	dec	bp
	ret	4
BCC_PUT_PATH	endp
CO034_TEXT	ends

CO034_TEXT	segment byte public 'CODE'
		assume	cs:CO034_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,010h,0FFh,076h,006h,0FFh,076h,004h,033h	; ovr_1ca7_833a:38C4
		db	0C0h,033h,0D2h,050h,052h,050h,052h,016h,08Dh,046h,0F0h,050h,016h,08Dh	; ovr_1ca7_833a:38D2
		db	046h,0FAh,050h,09Ah
		dw	039h
		dw	seg BCC_RF_1A47_0039
		db	016h,08Dh,046h,0FAh,050h,01Eh; ovr_1ca7_833a:38E0
		db	0B8h,019h,025h,050h,09Ah
		dw	08h
		dw	seg BCC_RF_1AAA_0008
		db	00Bh,0C0h,075h,019h,0FFh; ovr_1ca7_833a:38EE
		db	076h,006h,0FFh,076h,004h,0E8h,0A1h,008h,01Eh,0B8h,0F0h,026h,050h,0E8h	; ovr_1ca7_833a:38FC
		db	056h,0FFh,0FFh,076h,006h,0FFh,076h,004h,0EBh,031h,01Eh,0B8h,0F0h,026h	; ovr_1ca7_833a:390A
		db	050h,0E8h,046h,0FFh,01Eh,0B8h,09Eh,067h,050h,0FFh,036h,04Ch,017h,0FFh	; ovr_1ca7_833a:3918
		db	036h,04Ah,017h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,09Eh,067h,050h,09Ah; ovr_1ca7_833a:3926
		dw	03h
		dw	seg BCC_SEG_16
		db	01Eh,0B8h,09Eh,067h,050h,0E8h,069h,0FFh,016h,08Dh; ovr_1ca7_833a:3934
		db	046h,0F0h,050h,0E8h,061h,0FFh,0B8h,001h,000h,08Bh,0E5h,05Dh,04Dh,0C2h	; ovr_1ca7_833a:3942
		db	004h,000h	; ovr_1ca7_833a:3950

CO034_TEXT	ends

	extrn	BCC_PATH_EMPTY:byte
	extrn	BCC_STATE_250E:word


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

		public	X034_04
X034_04	label	far
BCC_STRING_FILE_APPEND	proc	far
	push	bp
	mov	bp,sp
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	0E8h,043h,007h
	or	ax,ax
	je	short M009_@@APPEND
	mov	word ptr DGROUP:BCC_STATE_250E,1
	jmp	short M009_@@DONE
M009_@@APPEND:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PATH_EMPTY
	push	ax
	push	cs
	db	0E8h,055h,0FBh
	mov	word ptr [bp+8],dx
	mov	word ptr [bp+6],ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	mov	ax,524h
	push	ax
	db	0E8h,061h,007h
M009_@@DONE:
	pop	bp
	retf	4
BCC_STRING_FILE_APPEND	endp
CO034_TEXT	ends

CO034_TEXT	segment byte public 'CODE'
		assume	cs:CO034_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,0FFh,076h,006h,0FFh,076h,004h,0E8h,00Ch,0FFh,01Eh	; ovr_1ca7_833a:3990
		db	0B8h,0F0h,026h,050h,0E8h,0BDh,0FEh,0B8h,001h,000h,05Dh,04Dh,0C2h,004h	; ovr_1ca7_833a:399E
		db	000h; raw:39AC
X034_00	label	far
		db	055h,08Bh,0ECh,083h,0ECh,012h,056h,057h,01Eh,0B8h,08Eh,078h,050h; ovr_1ca7_833a:39AC
		db	09Ah
		dw	04E0Bh
		dw	seg BCC_FAR_245C
		db	00Bh,0C0h,074h,003h,0E9h,0D3h,006h,080h,03Eh; ovr_1ca7_833a:39BA
		db	0FCh,016h,000h,074h,003h,0E9h,0C9h,006h,083h,03Eh,09Eh,082h,000h,07Eh	; ovr_1ca7_833a:39C8
		db	003h,0E9h,0BFh,006h,01Eh,0B8h,0F4h,026h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_5E22
		db	089h,046h,0FEh,083h,07Eh,0FEh,000h,07Dh,009h,0B8h,03Bh,000h,050h,090h	; ovr_1ca7_833a:39E4
		db	00Eh,0E8h,0EBh,007h,080h,03Eh,076h,017h,000h,074h,03Dh,080h,03Eh,076h	; ovr_1ca7_833a:39F2
		db	017h,002h,074h,007h,080h,03Eh,076h,017h,005h,075h,005h,0B8h,001h,000h	; ovr_1ca7_833a:3A00
		db	0EBh,002h,033h,0C0h,088h,046h,0EEh,0A0h,0EFh,016h,098h,0BAh,006h,000h	; ovr_1ca7_833a:3A0E
		db	0F7h,0EAh,005h,08Ch,024h,089h,046h,0F6h,080h,07Eh,0EEh,000h,074h,004h	; ovr_1ca7_833a:3A1C
		db	0B0h,064h,0EBh,002h,0B0h,077h,08Bh,05Eh,0F6h,08Bh,01Fh,088h,047h,002h	; ovr_1ca7_833a:3A2A
		db	0EBh,00Fh,0A0h,0EFh,016h,098h,0BAh,006h,000h,0F7h,0EAh,005h,05Ch,024h	; ovr_1ca7_833a:3A38
		db	089h,046h,0F6h,080h,03Eh,07Ah,017h,000h,074h,017h,0A0h,076h,017h,098h	; ovr_1ca7_833a:3A46
		db	00Bh,0C0h,075h,00Fh,01Eh,0A0h,0EFh,016h,098h,0D1h,0E0h,08Bh,0D8h,0FFh	; ovr_1ca7_833a:3A54
		db	0B7h,080h,024h,0EBh,006h,01Eh,08Bh,05Eh,0F6h,0FFh,037h,033h,0C0h,050h	; ovr_1ca7_833a:3A62
		db	0E8h,0B3h,007h,01Eh,0B8h,09Eh,067h,050h,0E8h,02Eh,0FEh,080h,03Eh,076h	; ovr_1ca7_833a:3A70
		db	017h,000h,074h,022h,0A0h,0EFh,016h,088h,046h,0EFh,080h,07Eh,0EEh,000h	; ovr_1ca7_833a:3A7E
		db	074h,016h,098h,08Bh,0D8h,08Ah,087h,010h,025h,088h,046h,0EFh,098h,0BAh	; ovr_1ca7_833a:3A8C
		db	006h,000h,0F7h,0EAh,005h,08Ch,024h,089h,046h,0F6h,08Bh,046h,00Ah,089h	; ovr_1ca7_833a:3A9A
		db	046h,0FCh,08Bh,046h,008h,08Bh,056h,006h,089h,046h,0FAh,089h,056h,0F8h	; ovr_1ca7_833a:3AA8
		db	0C7h,046h,0F0h,000h,000h,0A0h,000h,017h,098h,08Bh,0F8h,033h,0F6h,0EBh	; ovr_1ca7_833a:3AB6
		db	059h,0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h,03Fh,02Dh,075h,046h,0C4h	; ovr_1ca7_833a:3AC4
		db	05Eh,006h,026h,0C4h,01Fh,026h,080h,07Fh,001h,076h,075h,039h,0C4h,05Eh	; ovr_1ca7_833a:3AD2
		db	006h,026h,0C4h,01Fh,026h,080h,07Fh,002h,069h,074h,02Ch,0C4h,05Eh,006h	; ovr_1ca7_833a:3AE0
		db	026h,0C4h,01Fh,026h,08Ah,047h,002h,098h,0F7h,0D8h,01Bh,0C0h,040h,08Bh	; ovr_1ca7_833a:3AEE
		db	0F0h,00Bh,0F6h,074h,004h,00Bh,0FFh,074h,008h,00Bh,0F6h,075h,009h,00Bh	; ovr_1ca7_833a:3AFC
		db	0FFh,074h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,009h,046h,0F0h,083h	; ovr_1ca7_833a:3B0A
		db	046h,006h,004h,0FFh,04Eh,00Ah,083h,07Eh,00Ah,000h,07Fh,0A1h,08Bh,046h	; ovr_1ca7_833a:3B18
		db	0FCh,089h,046h,00Ah,08Bh,046h,0FAh,08Bh,056h,0F8h,089h,046h,008h,089h	; ovr_1ca7_833a:3B26
		db	056h,006h,0A0h,000h,017h,098h,08Bh,0F0h,080h,03Eh,000h,017h,000h,074h	; ovr_1ca7_833a:3B34
		db	00Bh,083h,07Eh,0F0h,000h,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h	; ovr_1ca7_833a:3B42
		db	08Bh,0F8h,0C7h,046h,0F4h,000h,000h,0A0h,074h,017h,098h,089h,046h,0F2h	; ovr_1ca7_833a:3B50
		db	0E9h,009h,001h,0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h,03Fh,02Dh,075h	; ovr_1ca7_833a:3B5E
		db	048h,0C4h,05Eh,006h,026h,0C4h,01Fh,026h,080h,07Fh,001h,059h,075h,016h	; ovr_1ca7_833a:3B6C
		db	0C4h,05Eh,006h,026h,0C4h,01Fh,026h,08Ah,047h,003h,098h,0F7h,0D8h,01Bh	; ovr_1ca7_833a:3B7A
		db	0C0h,040h,089h,046h,0F2h,0E9h,0D3h,000h,0C4h,05Eh,006h,026h,0C4h,01Fh	; ovr_1ca7_833a:3B88
		db	026h,080h,07Fh,002h,069h,075h,003h,0E9h,0C3h,000h,0C4h,05Eh,006h,026h	; ovr_1ca7_833a:3B96
		db	0C4h,01Fh,026h,08Ah,047h,002h,098h,0F7h,0D8h,01Bh,0C0h,040h,08Bh,0F0h	; ovr_1ca7_833a:3BA4
		db	0E9h,0AEh,000h,0C4h,05Eh,006h,026h,0FFh,077h,002h,026h,0FFh,037h,0E8h	; ovr_1ca7_833a:3BB2
		db	0DFh,004h,00Bh,0C0h,074h,003h,0E9h,094h,000h,083h,07Eh,0F2h,000h,074h	; ovr_1ca7_833a:3BC0
		db	006h,083h,07Eh,0F4h,000h,074h,01Ch,083h,07Eh,0F2h,000h,075h,006h,083h	; ovr_1ca7_833a:3BCE
		db	07Eh,0F4h,000h,075h,010h,00Bh,0F6h,074h,004h,00Bh,0FFh,074h,008h,00Bh	; ovr_1ca7_833a:3BDC
		db	0F6h,075h,060h,00Bh,0FFh,074h,05Ch,01Eh,0B8h,0F0h,026h,050h,0E8h,069h	; ovr_1ca7_833a:3BEA
		db	0FCh,083h,07Eh,0F4h,000h,074h,006h,083h,07Eh,0F2h,000h,074h,00Ch,083h	; ovr_1ca7_833a:3BF8
		db	07Eh,0F4h,000h,075h,01Fh,083h,07Eh,0F2h,000h,074h,019h,08Bh,046h,0F2h	; ovr_1ca7_833a:3C06
		db	089h,046h,0F4h,01Eh,083h,07Eh,0F4h,000h,074h,005h,0B8h,05Bh,026h,0EBh	; ovr_1ca7_833a:3C14
		db	003h,0B8h,0FFh,026h,050h,0E8h,038h,0FCh,00Bh,0FFh,074h,004h,00Bh,0F6h	; ovr_1ca7_833a:3C22
		db	074h,008h,00Bh,0FFh,075h,017h,00Bh,0F6h,074h,013h,08Bh,0FEh,01Eh,00Bh	; ovr_1ca7_833a:3C30
		db	0FFh,074h,005h,0B8h,003h,027h,0EBh,003h,0B8h,007h,027h,050h,0E8h,015h	; ovr_1ca7_833a:3C3E
		db	0FCh,0C4h,05Eh,006h,026h,0FFh,077h,002h,026h,0FFh,037h,00Eh,0E8h,0F7h	; ovr_1ca7_833a:3C4C
		db	0FCh,0EBh,006h,0C7h,006h,00Eh,025h,001h,000h,083h,046h,006h,004h,0FFh	; ovr_1ca7_833a:3C5A
		db	04Eh,00Ah,083h,07Eh,00Ah,000h,07Eh,003h,0E9h,0EEh,0FEh,01Eh,0B8h,04Eh	; ovr_1ca7_833a:3C68
		db	026h,050h,0E8h,0E7h,0FBh,01Eh,0B8h,09Eh,067h,050h,0FFh,036h,04Ch,017h	; ovr_1ca7_833a:3C76
		db	0FFh,036h,04Ah,017h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,09Eh,067h,050h; ovr_1ca7_833a:3C84
		db	09Ah
		dw	03h
		dw	seg BCC_SEG_16
		db	01Eh,0B8h,09Eh,067h,050h,0E8h,00Ah,0FCh,0FFh; ovr_1ca7_833a:3C92
		db	036h,060h,017h,0FFh,036h,05Eh,017h,0E8h,0FFh,0FBh,080h,03Eh,076h,017h	; ovr_1ca7_833a:3CA0
		db	000h,074h,02Ch,080h,07Eh,0EEh,000h,074h,026h,0FFh,036h,060h,017h,0FFh	; ovr_1ca7_833a:3CAE
		db	036h,05Eh,017h,033h,0C0h,033h,0D2h,050h,052h,050h,052h,050h,052h,050h	; ovr_1ca7_833a:3CBC
		db	052h,09Ah
		dw	039h
		dw	seg BCC_RF_1A47_0039
		db	0A9h,002h,000h,075h,008h,01Eh,0B8h,00Bh; ovr_1ca7_833a:3CCA
		db	027h,050h,0E8h,085h,0FBh,01Eh,0B8h,04Eh,026h,050h,0E8h,07Dh,0FBh,083h	; ovr_1ca7_833a:3CD8
		db	07Eh,0F0h,000h,074h,005h,0C6h,006h,0D9h,024h,000h,0C7h,046h,0FEh,000h	; ovr_1ca7_833a:3CE6
		db	000h,0EBh,020h,08Bh,05Eh,0FEh,080h,0BFh,0C4h,024h,000h,074h,013h,0B0h	; ovr_1ca7_833a:3CF4
		db	02Fh,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	08Ah,046h,0FEh,004h,061h,050h,09Ah; ovr_1ca7_833a:3D02
		dw	072h
		dw	seg BCC_FAR_5E22
		db	0FFh,046h,0FEh,083h,07Eh,0FEh,01Ah,07Ch,0DAh,0C7h; ovr_1ca7_833a:3D10
		db	046h,0FEh,000h,000h,0EBh,020h,08Bh,05Eh,0FEh,080h,0BFh,0DEh,024h,000h	; ovr_1ca7_833a:3D1E
		db	074h,013h,0B0h,02Fh,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	08Ah,046h,0FEh,004h; ovr_1ca7_833a:3D2C
		db	041h,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	0FFh,046h,0FEh,083h,07Eh,0FEh,01Ah; ovr_1ca7_833a:3D3A
		db	07Ch,0DAh,0C7h,046h,0FEh,000h,000h,0EBh,020h,08Bh,05Eh,0FEh,080h,0BFh	; ovr_1ca7_833a:3D48
		db	0F8h,024h,000h,074h,013h,0B0h,02Fh,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	08Ah; ovr_1ca7_833a:3D56
		db	046h,0FEh,004h,030h,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	0FFh,046h,0FEh,083h; ovr_1ca7_833a:3D64
		db	07Eh,0FEh,00Ah,07Ch,0DAh,0C7h,046h,0FEh,000h,000h,0EBh,020h,08Bh,05Eh	; ovr_1ca7_833a:3D72
		db	0FEh,080h,0BFh,0A4h,082h,000h,074h,013h,01Eh,0B8h,010h,027h,050h,0E8h	; ovr_1ca7_833a:3D80
		db	0D2h,0FAh,08Ah,046h,0FEh,004h,061h,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	0FFh; ovr_1ca7_833a:3D8E
		db	046h,0FEh,083h,07Eh,0FEh,01Ah,07Ch,0DAh,080h,03Eh,076h,017h,000h,074h	; ovr_1ca7_833a:3D9C
		db	013h,080h,07Eh,0EEh,000h,074h,00Dh,0C6h,006h,0D4h,082h,000h,01Eh,0B8h	; ovr_1ca7_833a:3DAA
		db	013h,027h,050h,0E8h,0A4h,0FAh,0C7h,046h,0FEh,000h,000h,0EBh,020h,08Bh	; ovr_1ca7_833a:3DB8
		db	05Eh,0FEh,080h,0BFh,0BEh,082h,000h,074h,013h,01Eh,0B8h,018h,027h,050h	; ovr_1ca7_833a:3DC6
		db	0E8h,08Bh,0FAh,08Ah,046h,0FEh,004h,061h,050h,09Ah
		dw	072h
		dw	seg BCC_FAR_5E22
		db	0FFh,046h,0FEh,083h,07Eh,0FEh,01Ah,07Ch,0DAh,01Eh,0B8h,04Eh,026h,050h	; ovr_1ca7_833a:3DE2
		db	0E8h,06Fh,0FAh,083h,03Eh,00Eh,025h,000h,075h,003h,0E9h,038h,001h,033h	; ovr_1ca7_833a:3DF0
		db	0C0h,089h,046h,0F2h,089h,046h,0F4h,0A0h,000h,017h,098h,08Bh,0F0h,0E9h	; ovr_1ca7_833a:3DFE
		db	010h,001h,0C4h,05Eh,0F8h,026h,0C4h,01Fh,026h,080h,03Fh,02Dh,075h,048h	; ovr_1ca7_833a:3E0C
		db	0C4h,05Eh,0F8h,026h,0C4h,01Fh,026h,080h,07Fh,001h,059h,075h,016h,0C4h	; ovr_1ca7_833a:3E1A
		db	05Eh,0F8h,026h,0C4h,01Fh,026h,08Ah,047h,003h,098h,0F7h,0D8h,01Bh,0C0h	; ovr_1ca7_833a:3E28
		db	040h,089h,046h,0F2h,0E9h,0DAh,000h,0C4h,05Eh,0F8h,026h,0C4h,01Fh,026h	; ovr_1ca7_833a:3E36
		db	080h,07Fh,002h,069h,075h,003h,0E9h,0CAh,000h,0C4h,05Eh,0F8h,026h,0C4h	; ovr_1ca7_833a:3E44
		db	01Fh,026h,08Ah,047h,002h,098h,0F7h,0D8h,01Bh,0C0h,040h,08Bh,0F0h,0E9h	; ovr_1ca7_833a:3E52
		db	0B5h,000h,0C4h,05Eh,0F8h,026h,0FFh,077h,002h,026h,0FFh,037h,0E8h,032h	; ovr_1ca7_833a:3E60
		db	002h,00Bh,0C0h,075h,003h,0E9h,0A1h,000h,083h,07Eh,0F2h,000h,074h,006h	; ovr_1ca7_833a:3E6E
		db	083h,07Eh,0F4h,000h,074h,01Ch,083h,07Eh,0F2h,000h,075h,006h,083h,07Eh	; ovr_1ca7_833a:3E7C
		db	0F4h,000h,075h,010h,00Bh,0F6h,074h,004h,00Bh,0FFh,074h,008h,00Bh,0F6h	; ovr_1ca7_833a:3E8A
		db	075h,060h,00Bh,0FFh,074h,05Ch,083h,07Eh,0F2h,000h,074h,006h,083h,07Eh	; ovr_1ca7_833a:3E98
		db	0F4h,000h,074h,00Ch,083h,07Eh,0F2h,000h,075h,01Fh,083h,07Eh,0F4h,000h	; ovr_1ca7_833a:3EA6
		db	074h,019h,08Bh,046h,0F2h,089h,046h,0F4h,01Eh,083h,07Eh,0F4h,000h,074h	; ovr_1ca7_833a:3EB4
		db	005h,0B8h,05Bh,026h,0EBh,003h,0B8h,0FFh,026h,050h,0E8h,093h,0F9h,00Bh	; ovr_1ca7_833a:3EC2
		db	0F6h,074h,004h,00Bh,0FFh,074h,008h,00Bh,0F6h,075h,017h,00Bh,0FFh,074h	; ovr_1ca7_833a:3ED0
		db	013h,08Bh,0FEh,01Eh,00Bh,0FFh,074h,005h,0B8h,003h,027h,0EBh,003h,0B8h	; ovr_1ca7_833a:3EDE
		db	007h,027h,050h,0E8h,070h,0F9h,01Eh,0B8h,0F0h,026h,050h,0E8h,068h,0F9h	; ovr_1ca7_833a:3EEC
		db	0C4h,05Eh,0F8h,026h,0FFh,077h,002h,026h,0FFh,037h,0B8h,001h,000h,050h	; ovr_1ca7_833a:3EFA
		db	0E8h,01Bh,003h,01Eh,0B8h,09Eh,067h,050h,0B8h,0F0h,005h,050h,0E8h,0D6h	; ovr_1ca7_833a:3F08
		db	001h,083h,046h,0F8h,004h,0FFh,04Eh,0FCh,083h,07Eh,0FCh,000h,07Eh,003h	; ovr_1ca7_833a:3F16
		db	0E9h,0E7h,0FEh,083h,07Eh,0F4h,000h,074h,008h,01Eh,0B8h,01Bh,027h,050h	; ovr_1ca7_833a:3F24
		db	0E8h,02Dh,0F9h,080h,03Eh,009h,017h,000h,074h,01Bh,01Eh,0B8h,022h,027h	; ovr_1ca7_833a:3F32
		db	050h,033h,0C0h,050h,0E8h,0DFh,002h,01Eh,0B8h,09Eh,067h,050h,0E8h,05Ah	; ovr_1ca7_833a:3F40
		db	0F9h,01Eh,0B8h,0F0h,026h,050h,0E8h,00Bh,0F9h,080h,03Eh,076h,017h,000h	; ovr_1ca7_833a:3F4E
		db	074h,064h,01Eh,0B8h,02Eh,027h,050h,033h,0C0h,050h,0E8h,0BDh,002h,01Eh	; ovr_1ca7_833a:3F5C
		db	0B8h,09Eh,067h,050h,0E8h,038h,0F9h,01Eh,0B8h,0F0h,026h,050h,0E8h,0E9h	; ovr_1ca7_833a:3F6A
		db	0F8h,01Eh,08Ah,046h,0EFh,098h,0D1h,0E0h,08Bh,0D8h,0FFh,0B7h,0B0h,024h	; ovr_1ca7_833a:3F78
		db	033h,0C0h,050h,0E8h,09Ah,002h,01Eh,0B8h,09Eh,067h,050h,0E8h,015h,0F9h	; ovr_1ca7_833a:3F86
		db	01Eh,0B8h,0F0h,026h,050h,0E8h,0C6h,0F8h,080h,03Eh,0F3h,016h,000h,074h	; ovr_1ca7_833a:3F94
		db	06Bh,01Eh,08Bh,05Eh,0F6h,0FFh,077h,004h,033h,0C0h,050h,0E8h,076h,002h	; ovr_1ca7_833a:3FA2
		db	01Eh,0B8h,09Eh,067h,050h,0E8h,0F1h,0F8h,01Eh,0B8h,0F0h,026h,050h,0E8h	; ovr_1ca7_833a:3FB0
		db	0A2h,0F8h,0EBh,04Ch,080h,03Eh,0F3h,016h,000h,074h,045h,080h,03Eh,0F3h	; ovr_1ca7_833a:3FBE
		db	016h,001h,075h,006h,01Eh,0B8h,039h,027h,0EBh,004h,01Eh,0B8h,041h,027h	; ovr_1ca7_833a:3FCC
		db	050h,033h,0C0h,050h,0E8h,045h,002h,01Eh,0B8h,09Eh,067h,050h,0E8h,0C0h	; ovr_1ca7_833a:3FDA
		db	0F8h,01Eh,0B8h,0F0h,026h,050h,0E8h,071h,0F8h,01Eh,08Bh,05Eh,0F6h,0FFh	; ovr_1ca7_833a:3FE8
		db	077h,004h,033h,0C0h,050h,0E8h,028h,002h,01Eh,0B8h,09Eh,067h,050h,0E8h	; ovr_1ca7_833a:3FF6
		db	0A3h,0F8h,01Eh,0B8h,0F0h,026h,050h,0E8h,054h,0F8h,01Eh,08Bh,05Eh,0F6h	; ovr_1ca7_833a:4004
		db	0FFh,077h,002h,033h,0C0h,050h,0E8h,00Bh,002h,01Eh,0B8h,09Eh,067h,050h	; ovr_1ca7_833a:4012
		db	0E8h,086h,0F8h,080h,03Eh,076h,017h,000h,074h,042h,01Eh,0B8h,09Eh,067h	; ovr_1ca7_833a:4020
		db	050h,0FFh,036h,060h,017h,0FFh,036h,05Eh,017h,01Eh,0B8h,04Ah,027h,050h	; ovr_1ca7_833a:402E
		db	0E8h,012h,0F5h,052h,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,09Eh,067h; ovr_1ca7_833a:403C
		db	050h,0E8h,037h,0F8h,01Eh,0B8h,09Eh,067h,050h,09Ah
		dw	020h
		dw	seg CO037_TEXT
		db	00Bh,0C2h,074h,010h,01Eh,0B8h,04Eh,026h,050h,0E8h,0FEh,0F7h,01Eh,0B8h	; ovr_1ca7_833a:4058
		db	09Eh,067h,050h,0E8h,0F6h,0F7h,09Ah
		dw	0C3h
		dw	seg BCC_FAR_5E22
		db	01Eh,0B8h,04Fh; ovr_1ca7_833a:4066
		db	027h,050h,01Eh,0B8h,059h,027h,050h,09Ah
		dw	0388h
		dw	seg BCC_FAR_04CF
		db	089h,046h; ovr_1ca7_833a:4074
		db	0FEh,01Eh,0B8h,0F4h,026h,050h,09Ah
		dw	05h
		dw	seg BCC_FAR_AB75
		db	083h,07Eh,0FEh; ovr_1ca7_833a:4082
		db	001h,07Ch,006h,0C7h,006h,09Eh,082h,001h,000h,05Fh,05Eh,08Bh,0E5h,05Dh	; ovr_1ca7_833a:4090
		db	0CAh,006h,000h	; ovr_1ca7_833a:409E

CO034_TEXT	ends

	extrn	BCC_RF_1A47_0039:far
	extrn	BCC_RF_1AAA_0008:far
	extrn	BCC_SPECIAL_NAME:byte


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_POINTER_CHECK	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,8
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	push	ax
	push	dx
	push	ax
	push	dx
	push	ss
	lea	ax,[bp-6]
	push	ax
	db	9Ah
	dw	BCC_RF_1A47_0039
	dw	seg BCC_RF_1A47_0039
	mov	word ptr [bp-8],ax
	test	word ptr [bp-8],2
	je	short M00B_@@FALSE
	push	ss
	lea	ax,[bp-6]
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_SPECIAL_NAME
	push	ax
	db	9Ah
	dw	BCC_RF_1AAA_0008
	dw	seg BCC_RF_1AAA_0008
	or	ax,ax
	jne	short M00B_@@FALSE
	mov	ax,1
	jmp	short M00B_@@DONE
M00B_@@FALSE:
	xor	ax,ax
M00B_@@DONE:
	mov	sp,bp
	pop	bp
	dec	bp
	ret	4
BCC_POINTER_CHECK	endp
CO034_TEXT	ends


	extrn	BCC_RF_1A86_0002:far
	extrn	BCC_RF_1A47_0039:far
	extrn	BCC_RF_1A47_0202:far
	extrn	BCC_RF_1AB2_000D:far
	extrn	BCC_RF_1A86_0033:far


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_STREAM_POSITION	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,202
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ss
	lea	ax,[bp-52]
	push	ax
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_RF_1A86_0002
	dw	seg BCC_RF_1A86_0002
	or	ax,ax
	jge	short M00C_@@OPEN
	mov	ax,0FFFFh
	jmp	M00C_@@DONE
M00C_@@OPEN:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ss
	lea	ax,[bp-4]
	push	ax
	push	ss
	lea	ax,[bp-202]
	push	ax
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	push	ax
	push	dx
	db	9Ah
	dw	BCC_RF_1A47_0039
	dw	seg BCC_RF_1A47_0039
M00C_@@NEXT:
	push	ss
	lea	ax,[bp-134]
	push	ax
	push	ss
	lea	ax,[bp-4]
	push	ax
	push	ss
	lea	ax,[bp-202]
	push	ax
	push	ss
	lea	ax,[bp-22]
	push	ax
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	db	9Ah
	dw	BCC_RF_1A47_0202
	dw	seg BCC_RF_1A47_0202
	lea	ax,[bp-134]
	mov	word ptr [bp-6],ss
	mov	word ptr [bp-8],ax
	jmp	short M00C_@@CASE_TEST
M00C_@@CONVERT:
	les	bx,dword ptr [bp-8]
	mov	al,byte ptr es:[bx]
	cbw
	push	ax
	db	9Ah
	dw	BCC_RF_1AB2_000D
	dw	seg BCC_RF_1AB2_000D
	les	bx,dword ptr [bp-8]
	mov	byte ptr es:[bx],al
	inc	word ptr [bp-8]
M00C_@@CASE_TEST:
	les	bx,dword ptr [bp-8]
	cmp	byte ptr es:[bx],0
	jne	short M00C_@@CONVERT
	push	ss
	lea	ax,[bp-134]
	push	ax
	call	word ptr [bp+4]
	or	ax,ax
	jne	short M00C_@@CLOSE
	xor	ax,ax
	jmp	short M00C_@@DONE
M00C_@@CLOSE:
	push	ss
	lea	ax,[bp-52]
	push	ax
	db	9Ah
	dw	BCC_RF_1A86_0033
	dw	seg BCC_RF_1A86_0033
	or	ax,ax
	jge	short M00C_@@NEXT
	mov	ax,1
M00C_@@DONE:
	mov	sp,bp
	pop	bp
	dec	bp
	ret	6
BCC_STREAM_POSITION	endp
CO034_TEXT	ends


	extrn	BCC_RF_1A47_0039:far
	extrn	BCC_RF_1AA0_002F:far


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_POINTER_TRIM	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	push	ax
	push	dx
	push	ax
	push	dx
	push	ax
	push	dx
	db	9Ah
	dw	BCC_RF_1A47_0039
	dw	seg BCC_RF_1A47_0039
	test	ax,2
	je	short M00D_@@DONE
	push	word ptr [bp+6]
	push	word ptr [bp+4]
	mov	ax,2Eh
	push	ax
	db	9Ah
	dw	BCC_RF_1AA0_002F
	dw	seg BCC_RF_1AA0_002F
	mov	bx,ax
	db	08Eh,0C2h
	mov	byte ptr es:[bx],0
M00D_@@DONE:
	pop	bp
	dec	bp
	ret	4
BCC_POINTER_TRIM	endp
CO034_TEXT	ends


	extrn	BCC_OUTPUT_ERROR:far
	extrn	BCC_RF_1041_009F:far
	extrn	BCC_STATE_16F9:byte
	extrn	BCC_STATE_16FA:byte


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

		public	X034_05
X034_05	label	far
BCC_FATAL_ERROR	proc	far
	push	bp
	mov	bp,sp
	mov	al,0
	mov	byte ptr DGROUP:BCC_STATE_16F9,al
	mov	byte ptr DGROUP:BCC_STATE_16FA,al
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_OUTPUT_ERROR
	dw	seg BCC_OUTPUT_ERROR
	pop	cx
	mov	ax,1
	push	ax
	db	9Ah
	dw	BCC_RF_1041_009F
	dw	seg BCC_RF_1041_009F
	pop	bp
	retf	2
BCC_FATAL_ERROR	endp
CO034_TEXT	ends


	extrn	BCC_RF_1A44_000F:far
		extrn	BCC_RD_8298_W:word
		extrn	BCC_RD_8298_W:word


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

		public	X034_02
X034_02	label	far
BCC_NESTING_CHECK	proc	far
	push	bp
	mov	bp,sp
	inc	word ptr DGROUP:BCC_RD_8298_W
	cmp	word ptr DGROUP:BCC_RD_8298_W,200
	jbe	short M00F_@@DONE
	mov	ax,11
	push	ax
	xor	ax,ax
	push	ax
	push	ax
	db	9Ah
	dw	BCC_RF_1A44_000F
	dw	seg BCC_RF_1A44_000F
	mov	word ptr DGROUP:BCC_RD_8298_W,0
M00F_@@DONE:
	pop	bp
	retf
BCC_NESTING_CHECK	endp
CO034_TEXT	ends


	extrn	BCC_RF_1A86_0002:far
	extrn	BCC_STRING_COPY:far
	extrn	BCC_STRING_APPEND:far
	extrn	BCC_SEARCH_LIST:word
	extrn	BCC_RD_679E_B:byte


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_FIND_FILE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,48
	les	bx,dword ptr [bp+6]
	cmp	byte ptr es:[bx+1],3Ah
	je	short M010_@@COPY_ORIGINAL_EARLY
	cmp	byte ptr es:[bx],5Ch
	je	short M010_@@COPY_ORIGINAL_EARLY
	cmp	byte ptr es:[bx],2Fh
	jne	short M010_@@RELATIVE
M010_@@COPY_ORIGINAL_EARLY:
	jmp	short M010_@@COPY_ORIGINAL
M010_@@RELATIVE:
	cmp	word ptr [bp+4],0
	je	short M010_@@SEARCH
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ss
	lea	ax,[bp-48]
	push	ax
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_RF_1A86_0002
	dw	seg BCC_RF_1A86_0002
	or	ax,ax
	jl	short M010_@@SEARCH
	jmp	short M010_@@COPY_ORIGINAL
M010_@@SEARCH:
	mov	ax,word ptr DGROUP:BCC_SEARCH_LIST+2
	mov	dx,word ptr DGROUP:BCC_SEARCH_LIST
	jmp	short M010_@@LIST_TEST
M010_@@TRY_DIRECTORY:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	les	bx,dword ptr [bp-4]
	push	word ptr es:[bx+8]
	push	word ptr es:[bx+6]
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_APPEND
	dw	seg BCC_STRING_APPEND
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	push	ss
	lea	ax,[bp-48]
	push	ax
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_RF_1A86_0002
	dw	seg BCC_RF_1A86_0002
	or	ax,ax
	jge	short M010_@@DONE
	les	bx,dword ptr [bp-4]
	mov	ax,word ptr es:[bx+4]
	mov	dx,word ptr es:[bx+2]
M010_@@LIST_TEST:
	mov	word ptr [bp-2],ax
	mov	word ptr [bp-4],dx
	mov	ax,word ptr [bp-4]
	or	ax,word ptr [bp-2]
	jne	short M010_@@TRY_DIRECTORY
M010_@@COPY_ORIGINAL:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
M010_@@DONE:
	mov	sp,bp
	pop	bp
	dec	bp
	ret	6
BCC_FIND_FILE	endp
CO034_TEXT	ends


	extrn	BCC_RF_15C5_010D:far
	extrn	BCC_INPUT_SEEK:far
	extrn	BCC_INPUT_READ:far
	extrn	_CTYPE:byte


CO034_TEXT	segment byte public 'CODE'
	assume	cs:CO034_TEXT,ds:DGROUP

BCC_READ_FILE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,8
	push	si
	push	di
	mov	ax,8
	push	ax
	db	9Ah
	dw	BCC_RF_15C5_010D
	dw	seg BCC_RF_15C5_010D
	mov	word ptr [bp-2],dx
	mov	word ptr [bp-4],ax
	les	bx,dword ptr [bp+4]
	mov	word ptr es:[bx+2],dx
	mov	word ptr es:[bx],ax
	push	word ptr [bp+8]
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	mov	ax,2
	push	ax
	db	9Ah
	dw	BCC_INPUT_SEEK
	dw	seg BCC_INPUT_SEEK
	mov	di,ax
	push	word ptr [bp+8]
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	push	ax
	db	9Ah
	dw	BCC_INPUT_SEEK
	dw	seg BCC_INPUT_SEEK
	mov	ax,di
	inc	ax
	push	ax
	db	9Ah
	dw	BCC_RF_15C5_010D
	dw	seg BCC_RF_15C5_010D
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
	push	word ptr [bp+8]
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	push	di
	db	9Ah
	dw	BCC_INPUT_READ
	dw	seg BCC_INPUT_READ
	les	bx,dword ptr [bp-8]
	mov	byte ptr es:[bx+di],1Ah
	les	bx,dword ptr [bp-4]
	mov	ax,word ptr [bp-6]
	mov	dx,word ptr [bp-8]
	mov	word ptr es:[bx+6],ax
	mov	word ptr es:[bx+4],dx
	xor	di,di
M011_@@SKIP_SPACE:
	les	bx,dword ptr [bp-8]
	mov	al,byte ptr es:[bx]
	cbw
	mov	si,ax
	inc	word ptr [bp-8]
	test	byte ptr DGROUP:_CTYPE[si+1],1
	jne	short M011_@@SKIP_SPACE
	cmp	si,13
	je	short M011_@@SKIP_SPACE
	or	si,si
	je	short M011_@@SKIP_SPACE
	cmp	si,26
	je	short M011_@@DONE
	cmp	si,3Bh
	jne	short M011_@@LINE
	jmp	short M011_@@COMMENT_TEST
M011_@@COMMENT_NEXT:
	les	bx,dword ptr [bp-8]
	mov	al,byte ptr es:[bx]
	cbw
	mov	si,ax
	inc	word ptr [bp-8]
M011_@@COMMENT_TEST:
	or	si,si
	je	short M011_@@SKIP_SPACE
	cmp	si,10
	jne	short M011_@@COMMENT_NEXT
	jmp	short M011_@@SKIP_SPACE
M011_@@LINE:
	inc	di
M011_@@LINE_NEXT:
	les	bx,dword ptr [bp-8]
	mov	al,byte ptr es:[bx]
	cbw
	mov	si,ax
	inc	word ptr [bp-8]
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,1
	jne	short M011_@@LINE_END
	cmp	si,13
	je	short M011_@@LINE_END
	cmp	si,26
	jne	short M011_@@LINE_NEXT
M011_@@LINE_END:
	cmp	si,26
	je	short M011_@@DONE
	les	bx,dword ptr [bp-8]
	mov	byte ptr es:[bx-1],0
	jmp	short M011_@@SKIP_SPACE
M011_@@DONE:
	mov	ax,di
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	6
BCC_READ_FILE	endp
CO034_TEXT	ends

CO034_TEXT	segment byte public 'CODE'
		assume	cs:CO034_TEXT
; Original-image layout stub: not recovered source


X034_01	label	far
		db	055h,08Bh,0ECh,083h,0ECh,01Eh,056h,057h,0C4h,05Eh,00Ah,026h,08Bh,007h; ovr_1ca7_833a:43CF
		db	089h,046h,0FCh,033h,0FFh,0C4h,05Eh,006h,026h,08Bh,047h,002h,026h,08Bh	; ovr_1ca7_833a:43DD
		db	017h,089h,046h,0F8h,089h,056h,0F6h,0EBh,011h,0C4h,05Eh,0F6h,026h,0C4h	; ovr_1ca7_833a:43EB
		db	01Fh,026h,080h,03Fh,040h,074h,00Ah,047h,083h,046h,0F6h,004h,03Bh,07Eh	; ovr_1ca7_833a:43F9
		db	0FCh,07Ch,0EAh,03Bh,07Eh,0FCh,075h,003h,0E9h,0D5h,001h,033h,0C0h,033h	; ovr_1ca7_833a:4407
		db	0D2h,089h,046h,0E8h,089h,056h,0E6h,089h,046h,0ECh,089h,056h,0EAh,08Bh	; ovr_1ca7_833a:4415
		db	046h,0FCh,089h,046h,0FEh,0E9h,0AFh,000h,0C4h,05Eh,0F6h,026h,0C4h,01Fh	; ovr_1ca7_833a:4423
		db	026h,080h,03Fh,040h,074h,003h,0E9h,09Bh,000h,0FFh,04Eh,0FEh,0C4h,05Eh	; ovr_1ca7_833a:4431
		db	0F6h,026h,08Bh,007h,040h,026h,0FFh,077h,002h,050h,033h,0C0h,050h,09Ah	; ovr_1ca7_833a:443F
		dw	01h
		dw	seg BCC_FAR_A9C1
		db	089h,046h,0FAh,083h,07Eh,0FAh,000h,07Dh,02Eh,0B0h; ovr_1ca7_833a:444D
		db	000h,0A2h,0F9h,016h,0A2h,0FAh,016h,0C4h,05Eh,0F6h,026h,08Bh,007h,040h	; ovr_1ca7_833a:445B
		db	026h,0FFh,077h,002h,050h,0B8h,05Ch,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,09Ah
		dw	02D67h
		dw	seg BCC_FAR_245C
		db	0B8h,001h,000h,050h,09Ah
		dw	09Fh
		dw	seg BCC_FAR_04CF
		db	0FFh,076h,0FAh,016h,08Dh,046h,0E2h,050h,0E8h,045h,0FEh; ovr_1ca7_833a:4477
		db	08Bh,056h,0FEh,003h,0D0h,089h,056h,0FEh,0FFh,076h,0FAh,09Ah
		dw	04h
		dw	seg BCC_FAR_A7C4
		db	08Bh,046h,0E6h,00Bh,046h,0E8h,074h,012h,0C4h,05Eh,0E6h,08Bh; ovr_1ca7_833a:4493
		db	046h,0E4h,08Bh,056h,0E2h,026h,089h,047h,002h,026h,089h,017h,0EBh,00Ch	; ovr_1ca7_833a:44AF
		db	08Bh,046h,0E4h,08Bh,056h,0E2h,089h,046h,0ECh,089h,056h,0EAh,08Bh,046h	; ovr_1ca7_833a:44BD
		db	0E4h,08Bh,056h,0E2h,089h,046h,0E8h,089h,056h,0E6h,047h,083h,046h,0F6h	; ovr_1ca7_833a:44CB
		db	004h,03Bh,07Eh,0FCh,07Dh,003h,0E9h,049h,0FFh,0C4h,05Eh,006h,026h,08Bh	; ovr_1ca7_833a:44D9
		db	047h,002h,026h,08Bh,017h,089h,046h,0F8h,089h,056h,0F6h,0C4h,05Eh,00Ah	; ovr_1ca7_833a:44E7
		db	08Bh,046h,0FEh,026h,089h,007h,0D1h,0E0h,0D1h,0E0h,050h,09Ah
		dw	010Dh
		dw	seg BCC_RF_15C5_010D
		db	089h,056h,0F4h,089h,046h,0F2h,0C4h,05Eh,006h,026h,089h,057h; ovr_1ca7_833a:44F5
		db	002h,026h,089h,007h,033h,0FFh,0E9h,0C5h,000h,0C4h,05Eh,0F6h,026h,0C4h	; ovr_1ca7_833a:4511
		db	01Fh,026h,080h,03Fh,040h,074h,003h,0E9h,099h,000h,0C4h,05Eh,0EAh,026h	; ovr_1ca7_833a:451F
		db	08Bh,047h,006h,026h,08Bh,057h,004h,089h,046h,0F0h,089h,056h,0EEh,0C4h	; ovr_1ca7_833a:452D
		db	05Eh,0EEh,026h,08Ah,007h,098h,08Bh,0F0h,0FFh,046h,0EEh,0F6h,084h,081h	; ovr_1ca7_833a:453B
		db	05Bh,001h,075h,0EDh,083h,0FEh,00Dh,074h,0E8h,00Bh,0F6h,074h,0E4h,083h	; ovr_1ca7_833a:4549
		db	0FEh,01Ah,074h,055h,083h,0FEh,03Bh,075h,019h,0EBh,00Ch,0C4h,05Eh,0EEh	; ovr_1ca7_833a:4557
		db	026h,08Ah,007h,098h,08Bh,0F0h,0FFh,046h,0EEh,00Bh,0F6h,074h,0C8h,083h	; ovr_1ca7_833a:4565
		db	0FEh,00Ah,075h,0EBh,0EBh,0C1h,08Bh,046h,0F0h,08Bh,056h,0EEh,04Ah,0C4h	; ovr_1ca7_833a:4573
		db	05Eh,0F2h,026h,089h,047h,002h,026h,089h,017h,083h,046h,0F2h,004h,0C4h	; ovr_1ca7_833a:4581
		db	05Eh,0EEh,026h,08Ah,007h,098h,08Bh,0F0h,0FFh,046h,0EEh,00Bh,0F6h,074h	; ovr_1ca7_833a:458F
		db	005h,083h,0FEh,01Ah,075h,0EBh,083h,0FEh,01Ah,075h,092h,0C4h,05Eh,0EEh	; ovr_1ca7_833a:459D
		db	026h,0C6h,047h,0FFh,000h,0C4h,05Eh,0EAh,026h,08Bh,047h,002h,026h,08Bh	; ovr_1ca7_833a:45AB
		db	017h,089h,046h,0ECh,089h,056h,0EAh,0EBh,018h,0C4h,05Eh,0F6h,026h,08Bh	; ovr_1ca7_833a:45B9
		db	047h,002h,026h,08Bh,017h,0C4h,05Eh,0F2h,026h,089h,047h,002h,026h,089h	; ovr_1ca7_833a:45C7
		db	017h,083h,046h,0F2h,004h,047h,083h,046h,0F6h,004h,03Bh,07Eh,0FCh,07Dh	; ovr_1ca7_833a:45D5
		db	003h,0E9h,033h,0FFh,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h	; ovr_1ca7_833a:45E3

CO034_TEXT	ends
; END C51UNIT
		end
