; MAIN.ASM: Turbo CREF 2.0 of Borland C++ 2.0 (TCREF.EXE): the start, the command line
; (xrffiles, reffile [options], @response files) and the messages. TCREF.EXE keeps no
; symbols: the names are descriptive, and names like L01624 or v_0380 are addresses
; (linear in the image, or offsets in DATA).


CODE	segment word public 'CODE'
CODE	ends
DOSIO	segment byte public 'CODE'
DOSIO	ends
MAIN	segment byte public 'CODE'
MAIN	ends
DATA	segment word public 'DATA'
DATA	ends
STK	segment para stack 'STACK'
STK	ends
	extrn	L00000:far
	extrn	L0000F:far
	extrn	L00018:far
	extrn	L00021:far
	extrn	L00720:far
	extrn	dosinit:far
	extrn	dosexit:far
	extrn	dosopen:far
	extrn	dosclose:far
	extrn	dosread:far
	extrn	doswrite:far
	extrn	dosseek:far
	extrn	dosdelete:far
	public	s_Copyright_c_1988, s_Cref_defined_at, s_Global_Symbol_Name, s_Module, s_Symbol_Name, v_0002
	public	v_0016, v_068E, v_0690, v_0692, v_0694, v_0696
	public	v_0698, v_069A, v_069C, v_069E, v_06A0, v_06A2
	public	v_06A4, v_06A6, v_06A8, v_06AA, v_06AC, v_06AE
	public	v_06B0, v_06B1, v_06B2, v_06B4, v_06B6, v_06B8
	public	v_06BA, v_06C5, v_06C7, v_06DA, v_06DC, v_06DE
	public	v_06E0, v_06E2, v_06E3, v_0AE6, v_0AE8, v_0AEA
	public	v_0AEC, v_0AEE, v_0AF0, v_0AF2, v_0AF4, v_0AF6
	public	v_0AF8, v_0AFC, v_0AFE, v_0B00, v_0B02, v_0B06
	public	v_0B08, v_0B0A, v_0B0C, v_0B10, v_0B12, v_0B14
	public	v_0B16, v_0B1A, v_0B1C, v_0B1E, v_0B20, v_0B24
	public	v_0B26

MAIN	segment byte public 'CODE'
	assume	cs:MAIN,ds:DATA
start:	cld
	mov	ax, DATA
	mov	ds, ax
	cli
	mov	ss, ax
	mov	sp, 102Ah
	sti
	mov	bx, 81h
	mov	word ptr v_038E, bx
	mov	word ptr v_0390, es
	mov	ax, word ptr es:[2]
	mov	word ptr v_0392, ax
	add	bl, byte ptr es:[80h]
	mov	byte ptr es:[bx], 0
	push	ss
	pop	es
	mov	dx, offset s_Turbo_CREF_Version
	call	putstr
	mov	dx, offset s_Copyright_c_1988
	call	putstr
	call	init
	mov	ax, word ptr v_0388
	mov	cx, word ptr v_038A
	push	es
	call	far ptr L00720
	pop	es
	call	cmdline
	jb	L01227
	cmp	word ptr v_038C, 0
	jne	L01201
	mov	dx, offset s_Syntax_TCREF_xrffile
	call	putstr
	mov	byte ptr v_0018, 0
L01201:	mov	al, byte ptr v_0018
	cmp	al, 2
	jb	L01213
	mov	dx, 43Dh
	call	far ptr dosdelete
	mov	al, byte ptr v_0018
L01213:	cmp	al, 1
	jb	L01222
	mov	dx, 3EDh
	call	far ptr dosdelete
	mov	al, byte ptr v_0018
L01222:	jmp	far ptr dosexit
L01227:	push	ds
	push	es
	mov	dx, 0
	mov	es, word ptr v_0382
	lds	ax, dword ptr v_0380
	mov	bx, ax
	cmp	ax, 41h
	jb	L0124D
	mov	dx, ax
	sub	dx, 37h
	mov	bx, 37h
	mov	si, dx
	mov	word ptr [si], 2E2Eh
	mov	byte ptr [si+2], 2Eh
L0124D:	mov	si, dx
	mov	cx, 4Bh
L01252:	mov	al, byte ptr [si]
	or	al, al
	je	L0126B
	cmp	al, 20h
	jae	L0125F
	mov	byte ptr [si], 20h
L0125F:	inc	si
	loop	L01252
	mov	word ptr [si], 2E2Eh
	mov	word ptr [si+2], 2Eh
L0126B:	push	dx
	push	bx
	call	putstr
	pop	bx
	pop	dx
	pop	ds
	pop	es
	mov	cx, bx
	dec	cx
	mov	ax, ss
	mov	es, ax
	mov	di, 39Dh
	mov	ax, 0A0Dh
	stosw
	mov	al, 20h
	rep stosb
	mov	al, 5Eh
	stosb
	mov	ax, 0A0Dh
	stosw
	xor	al, al
	stosb
	mov	dx, 39Dh
	call	putstr
	mov	dx, offset s_Fatal_Invalid_comman
	call	putstr
	mov	byte ptr v_0018, 2
	jmp	L01201
L012A4:	push	ds
	push	cs
	pop	ds
	mov	dx, 116h
	mov	ax, 2523h
	int	21h
	pop	ds
	mov	byte ptr v_0386, 0
	ret
	push	ss
	pop	ds
	cmp	byte ptr v_0386, 0
	je	L012C4
	call	far ptr L00021
L012C4:	mov	byte ptr v_0018, 3
	jmp	L01201
	ret
L012CD:	cmp	al, 61h
	jb	L012D7
	cmp	al, 7Ah
	ja	L012D7
	sub	al, 20h
L012D7:	ret
L012D8:	push	di
	push	di
	xor	al, al
	mov	cx, 0FFFFh
	repne scasb
	dec	di
	pop	ax
	sub	di, ax
	mov	cx, di
	pop	di
	ret
L012E9:	push	si
	push	di
L012EB:	lodsb
	stosb
	or	al, al
	jne	L012EB
	pop	di
	pop	si
	ret
L012F4:	cmp	byte ptr v_0019, 2Fh
	jne	L012FF
	cmp	al, 2Dh
	je	L01303
L012FF:	cmp	al, byte ptr v_0019
L01303:	ret
L01304:	cmp	al, byte ptr v_0019
	je	L0130E
	cmp	al, 2Fh
	je	L01310
L0130E:	cmp	al, 5Ch
L01310:	ret
L01311:	push	cx
	push	di
	push	es
	mov	ax, ds
	mov	es, ax
	mov	di, si
	xor	al, al
	mov	cx, 0FFFFh
	repne scasb
	dec	di
	std
	xchg	si, di
L01325:	lodsb
	call	L01304
	je	L0132F
	cmp	si, di
	jae	L01325
L0132F:	inc	si
	pop	es
	pop	di
	pop	cx
	cld
	ret
L01335:	lodsb
	or	al, al
	je	L0133E
	cmp	al, 2Eh
	jne	L01335
L0133E:	dec	si
	ret
L01340:	lodsb
	or	al, al
	je	L01365
	cmp	al, 3Fh
	je	L01350
	cmp	al, 2Ah
	je	L01356
	stosb
	jmp	short L01340
L01350:	mov	al, byte ptr [bx]
	inc	bx
	stosb
	jmp	short L01340
L01356:	xchg	si, bx
L01358:	lodsb
	or	al, al
	je	L01360
	stosb
	jmp	short L01358
L01360:	xchg	si, bx
	dec	bx
	jmp	short L01340
L01365:	xor	al, al
	stosb
	ret
L01369:	push	si
	push	di
	xchg	si, di
	call	L01311
	call	L01335
	cmp	byte ptr [si], 0
	jne	L01380
	xchg	si, di
L0137A:	lodsb
	stosb
	or	al, al
	jne	L0137A
L01380:	pop	di
	pop	si
	ret
L01383:	cmp	al, 20h
	ja	L0138A
	cmp	al, al
	ret
L0138A:	push	cx
	push	di
	mov	di, offset s_02F1
	mov	cx, 7
	repne scasb
	je	L01399
	call	L012F4
L01399:	pop	di
	pop	cx
	ret
L0139C:	cmp	al, 20h
	jbe	L013AD
	push	cx
	push	di
	mov	di, 2F8h
	mov	cx, 11
	repne scasb
	pop	di
	pop	cx
	ret
L013AD:	cmp	al, al
	ret
L013B0:	mov	di, word ptr v_0394
L013B4:	call	L01892
	call	L0139C
	je	L013C2
	call	L0184E
	stosb
	jmp	short L013B4
L013C2:	cmp	di, word ptr v_0394
	je	L013CF
	mov	byte ptr es:[di], 0
	xor	al, al
	ret
L013CF:	xor	al, al
	inc	al
	ret
L013D4:	call	L01892
	or	al, al
	je	L013F8
	cmp	al, 20h
	ja	L013E4
	call	L0184E
	jmp	short L013D4
L013E4:	call	L012F4
	je	L013FC
	call	L013B0
	je	L01403
	call	L0184E
	mov	byte ptr v_001C, al
	mov	ax, 3
	ret
L013F8:	mov	ax, 0
	ret
L013FC:	call	L0184E
	mov	ax, 2
	ret
L01403:	mov	ax, 1
	ret
L01407:	push	word ptr v_0384
	call	L018A6
	push	ax
L0140F:	call	L013D4
	cmp	ax, 2
	jne	L01421
	call	L015DB
	pop	ax
	call	L018A6
	push	ax
	jmp	short L0140F
L01421:	mov	bx, ax
	pop	ax
	push	bx
	call	L018AA
	pop	ax
	pop	word ptr v_0384
	ret
L0142E:	call	L013D4
	cmp	ax, 2
	jne	L0143B
	call	L015DB
	jmp	short L0142E
L0143B:	ret
L0143C:	push	bp
	sub	sp, 20h
	mov	bp, sp
	push	si
	mov	bl, 10
	xor	si, si
L01447:	push	si
	call	L01892
	call	L012CD
	call	L01383
	pop	si
	je	L01479
	cmp	si, 20h
	jae	L014B3
	cmp	al, 30h
	jb	L01479
	cmp	al, 39h
	jbe	L0146D
	cmp	al, 41h
	jb	L01479
	cmp	al, 46h
	ja	L01479
	mov	bl, 10h
	sub	al, 7
L0146D:	sub	al, 30h
	mov	byte ptr [bp+si], al
	push	si
	call	L0184E
	pop	si
	inc	si
	jmp	short L01447
L01479:	mov	byte ptr [bp+si], 0FFh
	call	L01892
	call	L012CD
	cmp	al, 48h
	jne	L0148D
	call	L0184E
	mov	bl, 10h
	jmp	short L01492
L0148D:	cmp	bl, 10h
	je	L014B3
L01492:	call	L01892
	call	L01383
	jne	L014B3
	xor	si, si
	xor	bh, bh
	xor	ax, ax
L014A0:	cmp	byte ptr [bp+si], 0FFh
	je	L014AF
	mul	bx
	add	al, byte ptr [bp+si]
	adc	ah, 0
	inc	si
	jmp	short L014A0
L014AF:	or	si, si
	jne	L014B8
L014B3:	xor	ax, ax
	stc
	jmp	short L014B9
L014B8:	clc
L014B9:	pop	si
	pushf
	pop	bp
	add	sp, 20h
	push	bp
	popf
	pop	bp
	ret
L014C3:	call	L01407
	cmp	ax, 1
	clc
	jne	L014FE
	call	L0142E
	mov	si, word ptr v_0396
	mov	di, word ptr v_0394
	call	L01369
	cmp	byte ptr v_001D, 1
	jne	L014FC
	mov	si, word ptr v_0394
	call	L01311
	mov	di, 3EDh
	call	L012E9
	mov	si, 3EDh
	call	L01335
	mov	byte ptr [si], 0
	mov	byte ptr v_001D, 0
L014FC:	xor	ax, ax
L014FE:	ret
L014FF:	call	L014C3
	jb	L0151D
	jne	L0151D
	mov	dx, word ptr v_0394
	inc	word ptr v_038C
	push	es
	call	far ptr L0000F
	pop	es
	jae	L014FF
	call	fatal
	jmp	L01201
L0151D:	xor	ax, ax
	ret
L01520:	call	L01407
	cmp	ax, 3
	jne	L01535
	cmp	byte ptr v_001C, 2Ch
	jne	L0153D
	call	L0142E
	call	L01407
L01535:	cmp	ax, 1
	jne	L0153D
	call	L014C3
L0153D:	xor	ax, ax
	ret
option:	mov	al, byte ptr v_0019
	mov	byte ptr v_0398, al
	call	L0184E
	mov	byte ptr v_0399, al
	call	L012CD
	cmp	al, 0
	je	L0158E
	cmp	al, 43h
	je	L01598
	cmp	al, 52h
	je	L0159E
	cmp	al, 50h
	je	L015A4
	cmp	al, 57h
	je	L015B3
	cmp	al, 58h
	je	L01596
	cmp	al, 4Dh
	je	L01596
	cmp	al, 53h
	je	L01596
	cmp	al, 49h
	je	L01596
	cmp	al, 4Ch
	je	L01596
	cmp	al, 4Eh
	je	L01596
	cmp	al, 44h
	je	L01596
	cmp	al, 56h
	je	L01596
	mov	byte ptr v_00D5, al
	mov	dx, offset s_Fatal_Bad_switch
	call	putstr
	stc
	ret
L0158E:	mov	dx, offset s_Fatal_Missing_switch
	call	putstr
	stc
	ret
L01596:	clc
	ret
L01598:	or	byte ptr v_0016, 1
	ret
L0159E:	or	byte ptr v_0016, 2
	ret
L015A4:	mov	word ptr v_0394, 39Dh
	call	L0143C
	jb	L015C2
	mov	word ptr v_0692, ax
	ret
L015B3:	mov	word ptr v_0394, 39Dh
	call	L0143C
	jb	L015C2
	mov	word ptr v_0694, ax
	ret
L015C2:	mov	dx, offset s_Fatal_Invalid_number
	call	putstr
	mov	byte ptr v_039A, 0
	mov	dx, 398h
	call	putstr
	mov	dx, 75h
	call	putstr
	stc
	ret
L015DB:	call	L0184E
	call	L012CD
	cmp	al, 50h
	je	L015EB
	cmp	al, 57h
	je	L015EB
	clc
	ret
L015EB:	push	word ptr v_0394
	mov	word ptr v_0394, 39Dh
	call	L0143C
	pop	word ptr v_0394
	clc
	ret
L015FE:	call	L018A6
	push	ax
L01602:	call	L01892
	or	al, al
	je	L01620
	call	L013D4
	cmp	ax, 2
	jne	L01602
	push	word ptr v_0394
	call	option
	pop	word ptr v_0394
	jae	L01602
	pop	ax
	ret
L01620:	pop	ax
	jmp	L018AA
cmdline:	mov	byte ptr v_0385, 1
	xor	ax, ax
	mov	word ptr v_038C, ax
	mov	byte ptr v_039D, al
	mov	byte ptr v_03ED, al
	mov	byte ptr v_043D, al
	mov	word ptr v_0394, 39Dh
	call	L015FE
	jb	L01652
	push	es
	mov	bx, word ptr v_001A
	call	far ptr L00000
	pop	es
	jae	L01657
	jmp	L0170D
L01652:	clc
	ret
L01654:	jmp	L01717
L01657:	mov	byte ptr v_0386, 1
	mov	word ptr v_0394, 39Dh
	mov	word ptr v_0396, 1Eh
	call	L014FF
	jb	L01654
	jne	L01654
	mov	word ptr v_0394, 3EDh
	mov	word ptr v_0396, 23h
	call	L01520
	mov	si, 3EDh
	mov	di, 43Dh
	call	L012E9
	mov	si, 43Dh
	call	L01311
	call	L01335
	mov	byte ptr [si], 0
	mov	word ptr v_0394, 43Dh
	mov	word ptr v_0396, 23h
	call	L01520
	mov	word ptr v_0394, 39Dh
	mov	word ptr v_0396, 1Eh
	call	L01407
	cmp	ax, 3
	jne	L016C3
	cmp	byte ptr v_001C, 2Ch
	jne	L016CD
	call	L0142E
	call	L01407
L016C3:	cmp	ax, 1
	jne	L016CD
	call	L014C3
	jmp	short L016C3
L016CD:	mov	byte ptr v_0385, 0
	call	L01407
	cmp	ax, 3
	jne	L016E7
	cmp	byte ptr v_001C, 3Bh
	jne	L016E7
	call	L0142E
	call	L01407
L016E7:	cmp	ax, 0
	jne	L01713
	mov	si, offset s_REF
	mov	di, 3EDh
	call	L01369
	cmp	word ptr v_038C, 0
	je	L01717
	mov	dx, 3EDh
	mov	bx, offset s_Turbo_CREF_Version
	push	es
	call	far ptr L00018
	pop	es
	jb	L0170D
	clc
	ret
L0170D:	call	fatal
	jmp	L01201
L01713:	call	L0142E
	stc
L01717:	ret
	inc	al
	mov	bl, al
	xor	bh, bh
	mov	al, byte ptr [bx+306h]
	call	L018AE
	mov	dx, si
	mov	bx, 1
	mov	ax, ds
	call	far ptr doswrite
	mov	ax, ss
	mov	es, ax
	mov	dx, 303h
	call	putstr
	clc
	ret
putstr:	push	si
	push	di
	mov	si, dx
	mov	di, dx
	push	ds
	pop	es
	call	L012D8
	mov	bx, 1
	mov	ax, ds
	call	far ptr doswrite
	pop	di
	pop	si
	ret
L01755:	push	ds
	push	es
	mov	ax, word ptr v_0388
	mov	es, ax
	xor	di, di
	mov	word ptr v_0382, ax
	mov	word ptr v_0380, di
	mov	byte ptr v_0384, 0
	lds	si, dword ptr v_038E
L0176E:	lodsb
	and	al, al
	je	L01782
	cmp	al, 40h
	je	L0177A
	stosb
	jmp	short L0176E
L0177A:	call	L0182B
	call	respfile
	jmp	short L0176E
L01782:	stosb
	mov	bx, di
	add	bx, 15
	mov	cl, 4
	shr	bx, cl
	pop	es
	pop	ds
	add	word ptr v_0388, bx
	sub	word ptr v_038A, bx
	ret
respfile:	push	si
	push	ds
	mov	ax, ss
	mov	ds, ax
	mov	dx, 39Dh
	mov	al, 0
	call	far ptr dosopen
	jb	L0180B
L017A9:	mov	cx, 200h
	mov	dx, 48Dh
	mov	ax, ds
	call	far ptr dosread
	jb	L01806
	mov	bx, ax
	mov	byte ptr [bx+48Dh], 0
	mov	si, 48Dh
L017C2:	lodsb
	and	al, al
	je	L017FE
	cmp	al, 40h
	je	L017D4
	stosb
	cmp	si, 68Dh
	je	L017A9
	jmp	short L017C2
L017D4:	mov	dx, cx
	neg	dx
	mov	cx, 0FFFFh
	mov	al, 1
	call	far ptr dosseek
	mov	cx, 200h
	mov	dx, 48Dh
	mov	ax, ds
	call	far ptr dosread
	mov	bx, ax
	mov	byte ptr [bx+48Dh], 0
	call	L0182B
	call	respfile
	jmp	short L017C2
L017FE:	call	far ptr dosclose
	pop	ds
	pop	si
	ret
L01806:	call	far ptr dosclose
L0180B:	mov	ax, ss
	mov	ds, ax
	mov	es, ax
	mov	dx, offset s_Fatal_Can_t
	call	putstr
	mov	dx, 39Dh
	call	putstr
	mov	dx, 115h
	call	putstr
	mov	byte ptr v_0018, 2
	jmp	L01201
L0182B:	push	di
	push	es
	mov	ax, ss
	mov	es, ax
	mov	di, 39Dh
L01834:	mov	al, byte ptr [si]
	and	al, al
	je	L01848
	push	ds
	mov	dx, ss
	mov	ds, dx
	call	L01383
	pop	ds
	je	L01848
	movsb
	jmp	short L01834
L01848:	xor	al, al
	stosb
	pop	es
	pop	di
	ret
L0184E:	push	ds
	lds	si, dword ptr v_0380
	lodsb
	pop	ds
	mov	ah, al
	cmp	byte ptr v_0385, 1
	jne	L01866
	cmp	al, 2Bh
	je	L01873
	cmp	al, 13
	je	L01877
L01866:	mov	byte ptr v_0384, ah
	or	al, al
	je	L01872
	inc	word ptr v_0380
L01872:	ret
L01873:	mov	al, 20h
	jmp	short L01866
L01877:	mov	al, 20h
	cmp	byte ptr v_0384, 2Bh
	je	L01866
	cmp	byte ptr v_0384, 2Ch
	je	L01866
	cmp	byte ptr v_0384, 20h
	je	L01866
	mov	al, 2Ch
	jmp	short L01866
L01892:	push	word ptr v_0384
	push	word ptr v_0380
	call	L0184E
	pop	word ptr v_0380
	pop	word ptr v_0384
	ret
L018A6:	mov	ax, word ptr v_0380
	ret
L018AA:	mov	word ptr v_0380, ax
	ret
L018AE:	cmp	al, byte ptr v_0018
	jbe	L018B7
	mov	byte ptr v_0018, al
L018B7:	ret
fatal:	mov	bl, byte ptr v_0696
	xor	bh, bh
	shl	bx, 1
	mov	dx, word ptr [bx+258h]
	or	dx, dx
	je	L018D3
	push	dx
	mov	dx, offset s_Fatal
	call	putstr
	pop	dx
	call	putstr
L018D3:	mov	al, 2
	call	L018AE
	stc
	ret
init:	mov	ax, 102Ah
	add	ax, 15
	mov	cl, 4
	shr	ax, cl
	mov	cx, ds
	add	ax, cx
	mov	word ptr v_0388, ax
	mov	ax, word ptr v_0392
	sub	ax, word ptr v_0388
	mov	word ptr v_038A, ax
	push	es
	call	far ptr dosinit
	pop	es
	jb	baddos
	call	L012A4
	call	L01755
	mov	word ptr v_0692, 3Eh
	mov	word ptr v_0694, 84h
	mov	word ptr v_0016, 0
	mov	ax, 3700h
	int	21h
	mov	byte ptr v_0019, dl
	ret
baddos:	push	word ptr v_0390
	xor	ax, ax
	push	ax
	push	ss
	pop	ds
	mov	dx, offset s_Fatal_Incorrect_DOS
	mov	ah, 9
	int	21h
	retf
MAIN	ends

DATA	segment word public 'DATA'
	assume	cs:DATA,ds:DATA
v_0002	db	24h, 2Ah, 24h, 2Ah, 24h, 2Ah, 1, 3, 0, 2
s_TURBOCREF	db	'TURBOCREF', 0
v_0016	db	0, 0
v_0018	db	0
v_0019	db	2Fh
v_001A	db	0FFh, 1Fh
v_001C	db	0
v_001D	db	1
s_XRF	db	'.XRF', 0
s_REF	db	'.REF', 0
s_Turbo_CREF_Version	db	'Turbo CREF  Version 2.0', 0
s_Copyright_c_1988	db	'  Copyright (c) 1988, 1991 Borland International', 13, 10, 13, 10, 0, 13, 10, 0
s_Fatal_Invalid_comman	db	'**Fatal** Invalid command line', 13, 10, 0
s_Fatal_Missing_switch	db	'**Fatal** Missing switch character', 13, 10, 0
s_Fatal_Bad_switch	db	'**Fatal** Bad switch: /'
v_00D5	db	0, 13, 10, 0
s_Fatal_Invalid_number	db	'**Fatal** Invalid number after ', 0
s_Fatal_Can_t	db	'**Fatal** Can', 27h, 't find @file ', 0, 13, 10, 0
s_Fatal_Incorrect_DOS	db	'**Fatal** Incorrect DOS version', 13, 10, '$'
s_Syntax_TCREF_xrffile	db	'Syntax:  TCREF xrffiles, reffile [options]', 13, 10, 13, 10, '@xxxx indicates use response file xxxx', 13, 10, 'Options:', 13, 10, '         /c  = lower case significant in symbols', 13, 10, '         /r  = full module level report', 13, 10, '         /p# = page length (# in lines)', 13, 10, '         /w# = page width  (# in characters)', 13, 10, 0
s_Fatal	db	'**Fatal** ', 0, 'd', 2, 7Fh, 2, 8Fh, 2, 0A6h, 2, 0BCh, 2, 0DAh, 2
s_Internal_undefined_e	db	'Internal undefined error', 13, 10, 0
s_Out_of_memory	db	'Out of memory', 13, 10, 0
s_Can_t_write	db	'Can', 27h, 't write REF file', 13, 10, 0
s_Invalid_file_format	db	'Invalid file format', 13, 10, 0
s_Maximum_hash_space	db	'Maximum hash space exceeded', 13, 10, 0
s_Array_overflowed_64K	db	'Array overflowed 64K', 13, 10, 0
s_02F1	db	' ,;=+[]/+;[]"|<>=,', 13, 10, 0, 0, 0, 1, 2, 0, 0, 15h, 2, 8, 1, '<', 2, 10h, 2, '`', 0, 18h, 3, 0, 1, 0FFh, 0FFh, 0, 0, 0FAh, 0, '(', 14h, 18h, 3, 0FFh, 0FFh, 3
s_Page	db	'(Page ', 0
s_Global_Symbol_Name	db	'Global Symbol Name', 0
s_Module	db	'Module "', 0
s_Symbol_Name	db	'" Symbol Name', 0
s_Cref_defined_at	db	'Cref (defined at #)', 0, 'NUL', 0, 8Dh, 11, 8Dh, 11, 8Eh, 11, 0DBh, 11, 0AFh, 12, 8Dh, 11, 8Eh, 11, 0D6h, 11
v_0380	db	2 dup (?)
v_0382	db	2 dup (?)
v_0384	db	1 dup (?)
v_0385	db	1 dup (?)
v_0386	db	2 dup (?)
v_0388	db	2 dup (?)
v_038A	db	2 dup (?)
v_038C	db	2 dup (?)
v_038E	db	2 dup (?)
v_0390	db	2 dup (?)
v_0392	db	2 dup (?)
v_0394	db	2 dup (?)
v_0396	db	2 dup (?)
v_0398	db	1 dup (?)
v_0399	db	1 dup (?)
v_039A	db	3 dup (?)
v_039D	db	50h dup (?)
v_03ED	db	50h dup (?)
v_043D	db	251h dup (?)
v_068E	db	2 dup (?)
v_0690	db	2 dup (?)
v_0692	db	2 dup (?)
v_0694	db	2 dup (?)
v_0696	db	2 dup (?)
v_0698	db	2 dup (?)
v_069A	db	2 dup (?)
v_069C	db	2 dup (?)
v_069E	db	2 dup (?)
v_06A0	db	2 dup (?)
v_06A2	db	2 dup (?)
v_06A4	db	2 dup (?)
v_06A6	db	2 dup (?)
v_06A8	db	2 dup (?)
v_06AA	db	2 dup (?)
v_06AC	db	2 dup (?)
v_06AE	db	2 dup (?)
v_06B0	db	1 dup (?)
v_06B1	db	1 dup (?)
v_06B2	db	2 dup (?)
v_06B4	db	2 dup (?)
v_06B6	db	2 dup (?)
v_06B8	db	2 dup (?)
v_06BA	db	11 dup (?)
v_06C5	db	2 dup (?)
v_06C7	db	13h dup (?)
v_06DA	db	2 dup (?)
v_06DC	db	2 dup (?)
v_06DE	db	2 dup (?)
v_06E0	db	2 dup (?)
v_06E2	db	1 dup (?)
v_06E3	db	403h dup (?)
v_0AE6	db	2 dup (?)
v_0AE8	db	2 dup (?)
v_0AEA	db	2 dup (?)
v_0AEC	db	2 dup (?)
v_0AEE	db	2 dup (?)
v_0AF0	db	2 dup (?)
v_0AF2	db	2 dup (?)
v_0AF4	db	2 dup (?)
v_0AF6	db	2 dup (?)
v_0AF8	db	4 dup (?)
v_0AFC	db	2 dup (?)
v_0AFE	db	2 dup (?)
v_0B00	db	2 dup (?)
v_0B02	db	4 dup (?)
v_0B06	db	2 dup (?)
v_0B08	db	2 dup (?)
v_0B0A	db	2 dup (?)
v_0B0C	db	4 dup (?)
v_0B10	db	2 dup (?)
v_0B12	db	2 dup (?)
v_0B14	db	2 dup (?)
v_0B16	db	4 dup (?)
v_0B1A	db	2 dup (?)
v_0B1C	db	2 dup (?)
v_0B1E	db	2 dup (?)
v_0B20	db	4 dup (?)
v_0B24	db	2 dup (?)
v_0B26	db	0FAh dup (?)
DATA	ends

STK	segment para stack 'STACK'
	assume	cs:STK,ds:DATA
	db	40Ah dup (?)
STK	ends
	end	start
