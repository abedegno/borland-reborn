	.286
	locals

STUB	segment para public 'CODE'
	assume	cs:STUB
	db	40h dup (0)	;@00000
v_40	db	50h dup (0)	;@00040
v_90	db	0, 0	;@00090
v_92	db	0, 0	;@00092
v_94	db	0, 0, 5Ch, 0	;@00094
v_98	db	0, 0, 0, 0	;@00098
v_9C	db	0, 0, 6Ch, 0, 0, 0, 0, 0, 0, 0, 'PATH='	;@0009C
v_AB	db	0, 0	;@000AB
v_AD	db	0, 0, 0	;@000AD
v_B0	db	0, 0	;@000B0
v_B2	db	0, 0	;@000B2
v_B4	db	0, 0, 'dpmiload.exe', 0, 'tasm.exe', 0, 0Dh, 0Ah, '     Shrink Error$'	;@000B4
	db	0Dh, 0Ah, '     Load & Execute Error$', 0Dh, 0Ah, '     Failed to locate real mode assembler (TASM.EX'
	db	'E)$', 0Dh, 0Ah, '     Failed to locate protected mode loader (DPMIL'
	db	'OAD.EXE)$', 0Dh, 0Ah, '     DPMI services not available: real mode assemb'
	db	'ler will be used', 0Dh, 0Ah, 24h, 0Dh, 0Ah, '     Fatal load error:  program loading aborted$'
	db	0Dh, 0Ah, '     DPMI services resident$'
L00207:	mov	ax, ds	;@00207
	mov	es, ax	;@00209
	mov	bx, 90h	;@0020B
	mov	dx, 0	;@0020E
	mov	ax, 4B00h	;@00211
	int	21h	;@00214
	jb	L00227	;@00216
L00218:	mov	ax, 4C00h	;@00218
	int	21h	;@0021B
L0021D:	mov	dx, 0CCh	;@0021D
	mov	ax, 900h	;@00220
	int	21h	;@00223
	jmp	L00218	;@00225
L00227:	mov	dx, 0FCh	;@00227
	mov	ax, 900h	;@0022A
	int	21h	;@0022D
	mov	dx, 1B7h	;@0022F
	mov	ax, 900h	;@00232
	int	21h	;@00235
	jmp	L00218	;@00237
start:	int	3	;@00239
	mov	ax, ds	;@0023A
	mov	es, ax	;@0023C
	push	cs	;@0023E
	pop	ds	;@0023F
	db	0A3h, 0B2h, 0	; mov word ptr v_B2, ax	;@00240
	db	8Ch, 0D3h	; mov bx, ss	;@00243
	mov	cx, sp	;@00245
	shr	cx, 4	;@00247
	inc	cx	;@0024A
	add	bx, cx	;@0024B
	mov	ax, es	;@0024D
	sub	bx, ax	;@0024F
	mov	ax, 4A00h	;@00251
	int	21h	;@00254
	jb	L0021D	;@00256
	db	0E8h, 4Ah, 0	; call @@3	;@00258
	mov	dx, word ptr es:[2Ch]	;@0025B
	mov	es, dx	;@00260
	db	0E8h, 7Bh, 0	; call @@8	;@00262
	db	89h, 3Eh, 0ABh, 0	; mov word ptr v_AB, di	;@00265
	db	0E8h, 94h, 0	; call @@13	;@00269
	jb	L00218	;@0026C
	db	8Eh, 6, 0B2h, 0	; mov es, word ptr v_B2	;@0026E
	db	8Ah, 0Eh, 40h, 0	; mov cl, byte ptr v_40	;@00272
	db	8Bh, 3Eh, 0B4h, 0	; mov di, word ptr v_B4	;@00276
	db	26h, 8Ah, 1Eh, 80h, 0	; mov bl, byte ptr es:[80h]	;@0027A
	cmp	bl, 0	;@0027F
	db	74h, 1Bh	; je @@2	;@00282
	add	cl, bl	;@00284
	db	88h, 0Eh, 40h, 0	; mov byte ptr v_40, cl	;@00286
	db	0FEh, 0Eh, 40h, 0	; dec byte ptr v_40	;@0028A
	mov	cl, bl	;@0028E
	mov	si, 81h	;@00290
@@1:	mov	al, byte ptr es:[si]	;@00293
	mov	byte ptr [di], al	;@00296
	inc	di	;@00298
	inc	si	;@00299
	loop	@@1	;@0029A
	mov	byte ptr [di], 0Dh	;@0029C
@@2:	db	0E8h, 55h, 1	; call @@32	;@0029F
	jmp	L00207	;@002A2
@@3:	push	es	;@002A5
	mov	dx, word ptr es:[2Ch]	;@002A6
	mov	es, dx	;@002AB
	sub	si, si	;@002AD
@@4:	mov	ax, word ptr es:[si]	;@002AF
	cmp	ax, 0	;@002B2
	je	@@5	;@002B5
	inc	si	;@002B7
	jmp	@@4	;@002B8
@@5:	inc	si	;@002BA
	inc	si	;@002BB
	inc	si	;@002BC
	inc	si	;@002BD
	sub	cx, cx	;@002BE
	mov	di, 41h	;@002C0
@@6:	mov	al, byte ptr es:[si]	;@002C3
	cmp	al, 0	;@002C6
	je	@@7	;@002C8
	mov	byte ptr [di], al	;@002CA
	inc	si	;@002CC
	inc	di	;@002CD
	inc	cx	;@002CE
	jmp	@@6	;@002CF
@@7:	inc	cl	;@002D1
	db	88h, 0Eh, 40h, 0	; mov byte ptr v_40, cl	;@002D3
	db	89h, 3Eh, 0B4h, 0	; mov word ptr v_B4, di	;@002D7
	mov	byte ptr [di], 0	;@002DB
	pop	es	;@002DE
	ret	;@002DF
@@8:	sub	di, di	;@002E0
@@9:	mov	si, 0A6h	;@002E2
	mov	cx, 5	;@002E5
	repe cmpsb	;@002E8
	je	@@12	;@002EA
@@10:	cmp	byte ptr es:[di], 0	;@002EC
	je	@@11	;@002F0
	inc	di	;@002F2
	jmp	@@10	;@002F3
@@11:	inc	di	;@002F5
	cmp	byte ptr es:[di], 0	;@002F6
	jne	@@9	;@002FA
	stc	;@002FC
	ret	;@002FD
@@12:	clc	;@002FE
	ret	;@002FF
@@13:	pusha	;@00300
	push	es	;@00301
	mov	ax, 1687h	;@00302
	int	2Fh	;@00305
	cmp	ax, 0	;@00307
	pop	es	;@0030A
	popa	;@0030B
	db	75h, 25h	; jne @@15	;@0030C
	mov	dx, 1E9h	;@0030E
	mov	ax, 900h	;@00311
	int	21h	;@00314
	db	0A1h, 0ABh, 0	; mov ax, word ptr v_AB	;@00316
	db	0BEh, 0B6h, 0	; mov si, 0B6h	;@00319
	db	0E8h, 7Bh, 0	; call @@23	;@0031C
	jae	@@14	;@0031F
	mov	dx, 133h	;@00321
	mov	ax, 900h	;@00324
	int	21h	;@00327
	mov	dx, 1B7h	;@00329
	mov	ax, 900h	;@0032C
	int	21h	;@0032F
	stc	;@00331
@@14:	ret	;@00332
@@15:	mov	dx, 170h	;@00333
	mov	ax, 900h	;@00336
	int	21h	;@00339
	db	0C7h, 6, 0B4h, 0, 41h, 0	; mov word ptr v_B4, 41h	;@0033B
	db	0C6h, 6, 40h, 0, 0	; mov byte ptr v_40, 0	;@00341
	db	8Eh, 6, 0B2h, 0	; mov es, word ptr v_B2	;@00346
	db	26h, 0FEh, 6, 80h, 0	; inc byte ptr es:[80h]	;@0034A
	mov	si, 81h	;@0034F
	mov	di, 0	;@00352
	mov	ax, word ptr es:[2Ch]	;@00355
	mov	es, ax	;@00359
	sub	si, si	;@0035B
@@16:	mov	ax, word ptr es:[si]	;@0035D
	cmp	ax, 0	;@00360
	je	@@17	;@00363
	inc	si	;@00365
	jmp	@@16	;@00366
@@17:	inc	si	;@00368
	inc	si	;@00369
	inc	si	;@0036A
	inc	si	;@0036B
	mov	di, 0	;@0036C
@@18:	mov	al, byte ptr es:[si]	;@0036F
	cmp	al, 0	;@00372
	je	@@19	;@00374
	mov	byte ptr [di], al	;@00376
	inc	si	;@00378
	inc	di	;@00379
	jmp	@@18	;@0037A
@@19:	dec	di	;@0037C
	mov	al, byte ptr [di]	;@0037D
	cmp	al, 5Ch	;@0037F
	je	@@20	;@00381
	jmp	@@19	;@00383
@@20:	inc	di	;@00385
	mov	si, 0C3h	;@00386
@@21:	mov	al, byte ptr [si]	;@00389
	cmp	al, 0	;@0038B
	je	@@22	;@0038D
	mov	byte ptr [di], al	;@0038F
	inc	si	;@00391
	inc	di	;@00392
	jmp	@@21	;@00393
@@22:	mov	byte ptr [di], 0	;@00395
	clc	;@00398
	ret	;@00399
@@23:	db	0A3h, 0ADh, 0	; mov word ptr v_AD, ax	;@0039A
	db	89h, 36h, 0B0h, 0	; mov word ptr v_B0, si	;@0039D
	mov	di, 0	;@003A1
@@24:	db	8Bh, 36h, 0B0h, 0	; mov si, word ptr v_B0	;@003A4
@@25:	db	8Ah, 4	; mov al, byte ptr [si]	;@003A8
	cmp	al, 0	;@003AA
	je	@@26	;@003AC
	mov	byte ptr [di], al	;@003AE
	inc	si	;@003B0
	inc	di	;@003B1
	jmp	@@25	;@003B2
@@26:	mov	byte ptr [di], 0	;@003B4
	mov	ax, 3D00h	;@003B7
	mov	dx, 0	;@003BA
	int	21h	;@003BD
	db	73h, 29h	; jae @@30	;@003BF
	db	8Bh, 36h, 0ADh, 0	; mov si, word ptr v_AD	;@003C1
	db	0BFh, 0, 0	; mov di, 0	;@003C5
@@27:	mov	al, byte ptr es:[si]	;@003C8
	cmp	al, 3Bh	;@003CB
	je	@@28	;@003CD
	cmp	al, 0	;@003CF
	db	74h, 1Eh	; je @@31	;@003D1
	mov	byte ptr [di], al	;@003D3
	inc	si	;@003D5
	inc	di	;@003D6
	jmp	@@27	;@003D7
@@28:	cmp	byte ptr [di-1], 5Ch	;@003D9
	je	@@29	;@003DD
	mov	byte ptr [di], 5Ch	;@003DF
	inc	di	;@003E2
@@29:	inc	si	;@003E3
	db	89h, 36h, 0ADh, 0	; mov word ptr v_AD, si	;@003E4
	db	0EBh, 0BAh	; jmp @@24	;@003E8
@@30:	mov	ax, 3E00h	;@003EA
	int	21h	;@003ED
	clc	;@003EF
	ret	;@003F0
@@31:	db	8Bh, 36h, 0B0h, 0	; mov si, word ptr v_B0	;@003F1
	db	0F9h	; stc	;@003F5
	ret	;@003F6
@@32:	mov	dx, word ptr es:[2Ch]	;@003F7
	db	89h, 16h, 90h, 0	; mov word ptr v_90, dx	;@003FC
	db	8Ch, 1Eh, 94h, 0	; mov word ptr v_94, ds	;@00400
	mov	ax, 40h	;@00404
	db	0A3h, 92h, 0	; mov word ptr v_92, ax	;@00407
	db	8Ch, 6, 98h, 0	; mov word ptr v_98, es	;@0040A
	db	8Ch, 6, 9Ch, 0	; mov word ptr v_9C, es	;@0040E
	db	0C3h	; ret	;@00412
STUB	ends

STK	segment byte stack 'STACK'
	db	0C8h dup (0)	;@00413
STK	ends
	end	start
