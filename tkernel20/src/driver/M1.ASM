	.286p
	locals
S000	segment byte public 'CODE'
S000	ends
S50A	segment para public 'CODE'
S50A	ends
S589	segment para public 'CODE'
S589	ends
S59F	segment para public 'CODE'
S59F	ends
S5AD	segment para public 'CODE'
S5AD	ends
S5ED	segment para public 'CODE'
S5ED	ends
S5FD	segment para public 'CODE'
S5FD	ends
S8EF	segment para public 'CODE'
S8EF	ends
S8F6	segment para public 'CODE'
S8F6	ends
S908	segment para public 'CODE'
S908	ends
S9CF	segment para public 'CODE'
S9CF	ends
S9D2	segment para stack 'CODE'
S9D2	ends
S9F3	segment para public 'CODE'
S9F3	ends
S9FA	segment byte public 'CODE'
S9FA	ends
SBB9	segment para public 'CODE'
SBB9	ends
SD33	segment para public 'BSS'
SD33	ends

	public	L0A471
	extrn	L00000:byte
	extrn	L003A7:far
	extrn	L048E0:far
	extrn	S589_START:byte
	extrn	L09D20:byte
	extrn	S9F3_START:byte
	extrn	L0A7E4:near

S9FA	segment byte public 'CODE'
	assume	cs:S9FA
start:	mov	ax, seg L09D20	;@09FA9
	mov	ss, ax	;@09FAC
	mov	sp, 205h	;@09FAE
	db	0BBh	;@09FB1
	dw	SD33
	db	8Ch, 0C0h	; mov ax, es	;@09FB4
	sub	bx, ax	;@09FB6
	inc	bx	;@09FB8
	mov	ah, 4Ah	;@09FB9
	int	21h	;@09FBB
	mov	ax, seg S589_START	;@09FBD
	mov	ds, ax	;@09FC0
	mov	byte ptr ds:[4Ch], 0	;@09FC2
	mov	ax, seg L00000	;@09FC7
	mov	ds, ax	;@09FCA
	mov	ax, es	;@09FCC
	mov	word ptr ds:[21Fh], ax	;@09FCE
	db	0E8h, 0D9h, 2	; call L0A2AD	;@09FD1
	jae	@@1	;@09FD4
	mov	ax, 1	;@09FD6
	jmp	@@2	;@09FD9
@@1:	xor	ax, ax	;@09FDC
@@2:	db	0E8h, 3, 8	; call L0A7E4	;@09FDE
	cmp	ax, 0	;@09FE1
	jne	@@3	;@09FE4
	jmp	@@7	;@09FE6
@@3:	cmp	ax, 0FFFFh	;@09FE9
	jne	@@6	;@09FEC
	db	0E8h, 0BCh, 2	; call L0A2AD	;@09FEE
	jb	@@4	;@09FF1
	db	0E8h, 7Eh, 3	; call L0A374	;@09FF3
	jmp	@@5	;@09FF6
@@4:	sub	sp, 4	;@09FF9
	push	bp	;@09FFC
	mov	bp, sp	;@09FFD
	mov	word ptr [bp+4], 0	;@09FFF
	mov	word ptr [bp+2], 0Eh	;@0A004
	pop	bp	;@0A009
	call	far ptr L048E0	;@0A00A
	add	sp, 4	;@0A00F
@@5:	jmp	@@23	;@0A012
	db	0EBh, 1Dh, 90h	;@0A015
@@6:	sub	sp, 4	;@0A018
	push	bp	;@0A01B
	mov	bp, sp	;@0A01C
	mov	word ptr [bp+4], 0	;@0A01E
	mov	word ptr [bp+2], 10h	;@0A023
	pop	bp	;@0A028
	call	far ptr L048E0	;@0A029
	add	sp, 4	;@0A02E
	jmp	@@23	;@0A031
@@7:	cmp	byte ptr cs:L0A471+88, 0	;@0A034
	je	@@8	;@0A03A
	jmp	@@17	;@0A03C
@@8:	push	ds	;@0A03F
	push	dx	;@0A040
	push	ax	;@0A041
	mov	ax, seg S9F3_START	;@0A042
	mov	ds, ax	;@0A045
	mov	dx, 0	;@0A047
	mov	ah, 9	;@0A04A
	int	21h	;@0A04C
	pop	ax	;@0A04E
	pop	dx	;@0A04F
	pop	ds	;@0A050
	push	ax	;@0A051
	mov	ax, 2	;@0A052
	cmp	ax, 0Ah	;@0A055
	jae	@@9	;@0A058
	push	ds	;@0A05A
	push	dx	;@0A05B
	push	ax	;@0A05C
	mov	ax, seg S9F3_START	;@0A05D
	mov	ds, ax	;@0A060
	mov	dx, 20h	;@0A062
	mov	ah, 9	;@0A065
	int	21h	;@0A067
	pop	ax	;@0A069
	pop	dx	;@0A06A
	pop	ds	;@0A06B
	jmp	@@10	;@0A06C
@@9:	push	ds	;@0A06F
	push	dx	;@0A070
	push	ax	;@0A071
	mov	ax, seg S9F3_START	;@0A072
	mov	ds, ax	;@0A075
	mov	dx, 22h	;@0A077
	mov	ah, 9	;@0A07A
	int	21h	;@0A07C
	pop	ax	;@0A07E
	pop	dx	;@0A07F
	pop	ds	;@0A080
@@10:	pop	ax	;@0A081
	push	ds	;@0A082
	push	dx	;@0A083
	push	ax	;@0A084
	mov	ax, seg S9F3_START	;@0A085
	mov	ds, ax	;@0A088
	mov	dx, 24h	;@0A08A
	mov	ah, 9	;@0A08D
	int	21h	;@0A08F
	pop	ax	;@0A091
	pop	dx	;@0A092
	pop	ds	;@0A093
	push	ax	;@0A094
	mov	ax, 0	;@0A095
	cmp	ax, 0Ah	;@0A098
	jae	@@11	;@0A09B
	push	ds	;@0A09D
	push	dx	;@0A09E
	push	ax	;@0A09F
	mov	ax, seg S9F3_START	;@0A0A0
	mov	ds, ax	;@0A0A3
	mov	dx, 26h	;@0A0A5
	mov	ah, 9	;@0A0A8
	int	21h	;@0A0AA
	pop	ax	;@0A0AC
	pop	dx	;@0A0AD
	pop	ds	;@0A0AE
	jmp	@@12	;@0A0AF
@@11:	push	ds	;@0A0B2
	push	dx	;@0A0B3
	push	ax	;@0A0B4
	mov	ax, seg S9F3_START	;@0A0B5
	mov	ds, ax	;@0A0B8
	mov	dx, 28h	;@0A0BA
	mov	ah, 9	;@0A0BD
	int	21h	;@0A0BF
	pop	ax	;@0A0C1
	pop	dx	;@0A0C2
	pop	ds	;@0A0C3
@@12:	pop	ax	;@0A0C4
	push	ds	;@0A0C5
	push	dx	;@0A0C6
	push	ax	;@0A0C7
	mov	ax, seg S9F3_START	;@0A0C8
	mov	ds, ax	;@0A0CB
	mov	dx, 2Ah	;@0A0CD
	mov	ah, 9	;@0A0D0
	int	21h	;@0A0D2
	pop	ax	;@0A0D4
	pop	dx	;@0A0D5
	pop	ds	;@0A0D6
	push	ax	;@0A0D7
	mov	ax, 3	;@0A0D8
	cmp	ax, 0Ah	;@0A0DB
	jae	@@13	;@0A0DE
	push	ds	;@0A0E0
	push	dx	;@0A0E1
	push	ax	;@0A0E2
	mov	ax, seg S9F3_START	;@0A0E3
	mov	ds, ax	;@0A0E6
	mov	dx, 2Ch	;@0A0E8
	mov	ah, 9	;@0A0EB
	int	21h	;@0A0ED
	pop	ax	;@0A0EF
	pop	dx	;@0A0F0
	pop	ds	;@0A0F1
	jmp	@@14	;@0A0F2
@@13:	push	ds	;@0A0F5
	push	dx	;@0A0F6
	push	ax	;@0A0F7
	mov	ax, seg S9F3_START	;@0A0F8
	mov	ds, ax	;@0A0FB
	mov	dx, 2Eh	;@0A0FD
	mov	ah, 9	;@0A100
	int	21h	;@0A102
	pop	ax	;@0A104
	pop	dx	;@0A105
	pop	ds	;@0A106
@@14:	pop	ax	;@0A107
	push	ax	;@0A108
	mov	ax, 4	;@0A109
	cmp	ax, 0Ah	;@0A10C
	jae	@@15	;@0A10F
	push	ds	;@0A111
	push	dx	;@0A112
	push	ax	;@0A113
	mov	ax, seg S9F3_START	;@0A114
	mov	ds, ax	;@0A117
	mov	dx, 30h	;@0A119
	mov	ah, 9	;@0A11C
	int	21h	;@0A11E
	pop	ax	;@0A120
	pop	dx	;@0A121
	pop	ds	;@0A122
	jmp	@@16	;@0A123
@@15:	push	ds	;@0A126
	push	dx	;@0A127
	push	ax	;@0A128
	mov	ax, seg S9F3_START	;@0A129
	mov	ds, ax	;@0A12C
	mov	dx, 32h	;@0A12E
	mov	ah, 9	;@0A131
	int	21h	;@0A133
	pop	ax	;@0A135
	pop	dx	;@0A136
	pop	ds	;@0A137
@@16:	pop	ax	;@0A138
	push	ds	;@0A139
	push	dx	;@0A13A
	push	ax	;@0A13B
	mov	ax, seg S9F3_START	;@0A13C
	mov	ds, ax	;@0A13F
	mov	dx, 34h	;@0A141
	mov	ah, 9	;@0A144
	int	21h	;@0A146
	pop	ax	;@0A148
	pop	dx	;@0A149
	pop	ds	;@0A14A
	push	ds	;@0A14B
	push	dx	;@0A14C
	push	ax	;@0A14D
	mov	ax, seg S9F3_START	;@0A14E
	mov	ds, ax	;@0A151
	mov	dx, 38h	;@0A153
	mov	ah, 9	;@0A156
	int	21h	;@0A158
	pop	ax	;@0A15A
	pop	dx	;@0A15B
	pop	ds	;@0A15C
	push	ds	;@0A15D
	push	dx	;@0A15E
	push	ax	;@0A15F
	mov	ax, seg S9F3_START	;@0A160
	mov	ds, ax	;@0A163
	mov	dx, 63h	;@0A165
	mov	ah, 9	;@0A168
	int	21h	;@0A16A
	pop	ax	;@0A16C
	pop	dx	;@0A16D
	pop	ds	;@0A16E
@@17:	db	0E8h, 3Bh, 1	; call L0A2AD	;@0A16F
	push	ax	;@0A172
	jb	@@18	;@0A173
	sub	sp, 4	;@0A175
	push	bp	;@0A178
	mov	bp, sp	;@0A179
	mov	word ptr [bp+4], 0	;@0A17B
	mov	word ptr [bp+2], 13h	;@0A180
	pop	bp	;@0A185
	call	far ptr L048E0	;@0A186
	add	sp, 4	;@0A18B
	jmp	@@23	;@0A18E
@@18:	call	far ptr L003A7	;@0A191
	jae	@@19	;@0A196
	sub	sp, 4	;@0A198
	push	bp	;@0A19B
	mov	bp, sp	;@0A19C
	mov	word ptr [bp+4], 0	;@0A19E
	mov	word ptr [bp+2], 0Fh	;@0A1A3
	pop	bp	;@0A1A8
	call	far ptr L048E0	;@0A1A9
	add	sp, 4	;@0A1AE
	jmp	@@23	;@0A1B1
@@19:	mov	ds, word ptr cs:L0A471+70	;@0A1B4
	mov	si, word ptr cs:L0A471+68	;@0A1B9
	pop	ax	;@0A1BE
	cmp	byte ptr [si+6Ch], 0	;@0A1BF
	je	@@20	;@0A1C3
	db	0E8h, 13h, 1	; call L0A2DB	;@0A1C5
	jmp	@@21	;@0A1C8
@@20:	db	0E8h, 7Eh, 1	; call L0A34C	;@0A1CB
@@21:	cmp	byte ptr cs:L0A471+88, 0	;@0A1CE
	jne	@@22	;@0A1D4
	sub	sp, 4	;@0A1D6
	push	bp	;@0A1D9
	mov	bp, sp	;@0A1DA
	mov	word ptr [bp+4], 0	;@0A1DC
	mov	word ptr [bp+2], 11h	;@0A1E1
	pop	bp	;@0A1E6
	call	far ptr L048E0	;@0A1E7
	add	sp, 4	;@0A1EC
@@22:	mov	ds, word ptr cs:L0A471+70	;@0A1EF
	mov	si, word ptr cs:L0A471+68	;@0A1F4
	mov	ah, 62h	;@0A1F9
	int	21h	;@0A1FB
	mov	es, bx	;@0A1FD
	mov	dx, seg L09D20	;@0A1FF
	sub	dx, bx	;@0A202
	inc	dx	;@0A204
	mov	al, 0	;@0A205
	mov	ah, 31h	;@0A207
	int	21h	;@0A209
@@23:	mov	al, 1	;@0A20B
	mov	ah, 4Ch	;@0A20D
	int	21h	;@0A20F
L0A211:	push	dx	;@0A211
	push	ds	;@0A212
	push	cx	;@0A213
	push	si	;@0A214
	push	bp	;@0A215
	mov	bp, sp	;@0A216
	sub	sp, 2	;@0A218
	mov	byte ptr [bp-2], 0	;@0A21B
	mov	ax, 0FBA1h	;@0A21F
	mov	bx, 81h	;@0A222
	push	cs	;@0A225
	pop	es	;@0A226
	mov	di, 323h	;@0A227
	mov	word ptr cs:L0A2C3, 0	;@0A22A
	mov	word ptr cs:L0A2C3+2, 0	;@0A231
	int	2Fh	;@0A238
	jb	@@1	;@0A23A
	cmp	word ptr cs:L0A2C3, 4149h	;@0A23C
	jne	@@1	;@0A243
	cmp	word ptr cs:L0A2C3+2, 4842h	;@0A245
	jne	@@1	;@0A24C
	mov	ah, 1	;@0A24E
	mov	bx, 0FFFFh	;@0A250
	db	0EBh, 4Ch	; jmp @@5	;@0A253
	db	90h	;@0A255
@@1:	mov	ax, seg L00000	;@0A256
	mov	ds, ax	;@0A259
	xor	ax, ax	;@0A25B
	mov	dx, 5Ah	;@0A25D
	mov	ah, 3Dh	;@0A260
	int	21h	;@0A262
	jae	@@2	;@0A264
	jb	@@3	;@0A266
@@2:	push	dx	;@0A268
	push	cs	;@0A269
	pop	ds	;@0A26A
	mov	bx, ax	;@0A26B
	mov	al, 3	;@0A26D
	mov	cx, 4	;@0A26F
	mov	dx, 323h	;@0A272
	mov	si, dx	;@0A275
	mov	byte ptr [si], 81h	;@0A277
	mov	ah, 44h	;@0A27A
	int	21h	;@0A27C
	pop	dx	;@0A27E
	cmp	word ptr ds:[323h], 4149h	;@0A27F
	jne	@@3	;@0A285
	cmp	word ptr ds:[325h], 4842h	;@0A287
	jne	@@3	;@0A28D
	jmp	@@4	;@0A28F
@@3:	stc	;@0A292
	db	0EBh, 0Dh	; jmp @@6	;@0A293
	db	90h	;@0A295
@@4:	xor	ax, ax	;@0A296
	db	81h, 0FAh, 5Ah, 0	; cmp dx, 5Ah	;@0A298
	db	74h, 3	; je @@5	;@0A29C
	mov	ax, 1	;@0A29E
@@5:	clc	;@0A2A1
@@6:	mov	ah, byte ptr [bp-2]	;@0A2A2
	mov	sp, bp	;@0A2A5
	pop	bp	;@0A2A7
	pop	si	;@0A2A8
	pop	cx	;@0A2A9
	pop	ds	;@0A2AA
	pop	dx	;@0A2AB
	retf	;@0A2AC
L0A2AD:	push	bx	;@0A2AD
	nosmart
	nosmart
	call	far ptr L0A211	;@0A2AE
	smart
	smart
	push	ax	;@0A2B3
	jb	@@2	;@0A2B4
	cmp	bx, -1	;@0A2B6
	je	@@1	;@0A2B9
	mov	ah, 3Eh	;@0A2BB
	int	21h	;@0A2BD
@@1:	clc	;@0A2BF
@@2:	pop	ax	;@0A2C0
	pop	bx	;@0A2C1
	ret	;@0A2C2
L0A2C3	db	18h dup (0)	;@0A2C3
L0A2DB:	push	es	;@0A2DB
	db	0E8h, 6Eh, 1	; call L0A44D	;@0A2DC
	mov	ax, seg L00000	;@0A2DF
	mov	ds, ax	;@0A2E2
	mov	ax, word ptr es:[bx]	;@0A2E4
	mov	word ptr ds:[50h], ax	;@0A2E7
	mov	ax, word ptr es:[bx+2]	;@0A2EA
	mov	word ptr ds:[52h], ax	;@0A2EE
	mov	ax, 0	;@0A2F1
	mov	word ptr es:[bx], ax	;@0A2F4
	mov	ds, ax	;@0A2F7
	mov	word ptr es:[bx+2], seg L00000	;@0A2F9
	pop	es	;@0A2FF
	ret	;@0A300
L0A301:	push	es	;@0A301
	push	ds	;@0A302
	push	ax	;@0A303
	push	bx	;@0A304
	push	dx	;@0A305
	push	si	;@0A306
	db	0E8h, 43h, 1	; call L0A44D	;@0A307
@@1:	mov	si, es	;@0A30A
	mov	ds, si	;@0A30C
	mov	si, bx	;@0A30E
	mov	ax, word ptr es:[bx+2]	;@0A310
	mov	bx, word ptr es:[bx]	;@0A314
	mov	es, ax	;@0A317
	cmp	bx, -1	;@0A319
	db	74h, 27h	; je @@2	;@0A31C
	db	26h, 81h, 0BFh, 13h, 0, 49h, 41h	; cmp word ptr es:[bx+13h], 4149h	;@0A31E
	db	75h, 0E3h	; jne @@1	;@0A325
	db	26h, 81h, 0BFh, 15h, 0, 42h, 48h	; cmp word ptr es:[bx+15h], 4842h	;@0A327
	db	75h, 0DAh	; jne @@1	;@0A32E
	db	26h, 81h, 0BFh, 17h, 0, 50h, 55h	; cmp word ptr es:[bx+17h], 5550h	;@0A330
	db	75h, 0D1h	; jne @@1	;@0A337
	mov	ax, word ptr es:[bx]	;@0A339
	mov	word ptr [si], ax	;@0A33C
	mov	ax, word ptr es:[bx+2]	;@0A33E
	mov	word ptr [si+2], ax	;@0A342
@@2:	pop	si	;@0A345
	pop	dx	;@0A346
	pop	bx	;@0A347
	pop	ax	;@0A348
	pop	ds	;@0A349
	pop	es	;@0A34A
	ret	;@0A34B
L0A34C:	push	es	;@0A34C
	push	bx	;@0A34D
	push	ds	;@0A34E
	push	dx	;@0A34F
	push	ax	;@0A350
	pushf	;@0A351
	cli	;@0A352
	mov	ax, 352Fh	;@0A353
	int	21h	;@0A356
	mov	ax, seg L00000	;@0A358
	mov	ds, ax	;@0A35B
	mov	word ptr ds:[297h], bx	;@0A35D
	mov	word ptr ds:[299h], es	;@0A361
	mov	dx, 29Bh	;@0A365
	mov	ax, 252Fh	;@0A368
	int	21h	;@0A36B
	popf	;@0A36D
	pop	ax	;@0A36E
	pop	dx	;@0A36F
	pop	ds	;@0A370
	pop	bx	;@0A371
	pop	es	;@0A372
	ret	;@0A373
L0A374:	push	ax	;@0A374
	push	bx	;@0A375
	push	cx	;@0A376
	push	dx	;@0A377
	push	si	;@0A378
	push	es	;@0A379
	push	ds	;@0A37A
	push	bp	;@0A37B
	mov	bp, sp	;@0A37C
	sub	sp, 2	;@0A37E
	nosmart
	nosmart
	call	far ptr L0A211	;@0A381
	smart
	smart
	jae	@@1	;@0A386
	jmp	@@8	;@0A388
@@1:	cmp	bx, -1	;@0A38B
	je	@@2	;@0A38E
	mov	byte ptr [bp-2], 1	;@0A390
	push	cs	;@0A394
	pop	ds	;@0A395
	mov	al, 3	;@0A396
	mov	cx, 0Ch	;@0A398
	mov	dx, 323h	;@0A39B
	mov	si, dx	;@0A39E
	mov	byte ptr [si], 84h	;@0A3A0
	mov	ah, 44h	;@0A3A3
	int	21h	;@0A3A5
	mov	ah, 3Eh	;@0A3A7
	int	21h	;@0A3A9
	jmp	@@3	;@0A3AB
@@2:	mov	byte ptr [bp-2], 0	;@0A3AE
	push	cs	;@0A3B2
	pop	es	;@0A3B3
	mov	di, 323h	;@0A3B4
	mov	bx, 84h	;@0A3B7
	mov	ax, 0FBA1h	;@0A3BA
	int	2Fh	;@0A3BD
	push	es	;@0A3BF
	pop	ds	;@0A3C0
	mov	si, di	;@0A3C1
@@3:	cmp	word ptr [si+4], 0	;@0A3C3
	jne	@@9	;@0A3C7
	mov	ax, word ptr [si+8]	;@0A3C9
	cmp	ax, 0	;@0A3CC
	je	@@4	;@0A3CF
	mov	es, ax	;@0A3D1
	mov	ah, 49h	;@0A3D3
	int	21h	;@0A3D5
@@4:	mov	ax, word ptr [si+0Ah]	;@0A3D7
	cmp	ax, 0	;@0A3DA
	je	@@5	;@0A3DD
	mov	es, ax	;@0A3DF
	mov	ah, 49h	;@0A3E1
	int	21h	;@0A3E3
@@5:	mov	es, word ptr [si+6]	;@0A3E5
	cmp	byte ptr [bp-2], 0	;@0A3E8
	je	@@6	;@0A3EC
	call	L0A301	;@0A3EE
@@6:	push	es	;@0A3F1
	mov	es, word ptr es:[2Ch]	;@0A3F2
	mov	ah, 49h	;@0A3F7
	int	21h	;@0A3F9
	pop	es	;@0A3FB
	mov	ah, 49h	;@0A3FC
	int	21h	;@0A3FE
	cmp	byte ptr cs:L0A471+88, 0	;@0A400
	jne	@@7	;@0A406
	sub	sp, 4	;@0A408
	push	bp	;@0A40B
	mov	bp, sp	;@0A40C
	mov	word ptr [bp+4], 0	;@0A40E
	mov	word ptr [bp+2], 12h	;@0A413
	pop	bp	;@0A418
	call	far ptr L048E0	;@0A419
	add	sp, 4	;@0A41E
@@7:	mov	al, 0	;@0A421
	mov	ah, 4Ch	;@0A423
	int	21h	;@0A425
@@8:	mov	sp, bp	;@0A427
	pop	bp	;@0A429
	pop	ds	;@0A42A
	pop	es	;@0A42B
	pop	si	;@0A42C
	pop	dx	;@0A42D
	pop	cx	;@0A42E
	pop	bx	;@0A42F
	pop	ax	;@0A430
	ret	;@0A431
@@9:	sub	sp, 4	;@0A432
	push	bp	;@0A435
	mov	bp, sp	;@0A436
	mov	word ptr [bp+4], 0	;@0A438
	mov	word ptr [bp+2], 57h	;@0A43D
	pop	bp	;@0A442
	call	far ptr L048E0	;@0A443
	add	sp, 4	;@0A448
	jmp	@@8	;@0A44B
L0A44D:	push	cx	;@0A44D
	push	di	;@0A44E
	mov	ah, 52h	;@0A44F
	int	21h	;@0A451
	mov	di, bx	;@0A453
	mov	cx, 1000h	;@0A455
	mov	al, 4Eh	;@0A458
@@1:	repne scasb	;@0A45A
	cmp	byte ptr es:[di], 55h	;@0A45C
	jne	@@1	;@0A460
	cmp	byte ptr es:[di+1], 4Ch	;@0A462
	jne	@@1	;@0A467
	mov	bx, di	;@0A469
	sub	bx, 0Bh	;@0A46B
	pop	di	;@0A46E
	pop	cx	;@0A46F
	ret	;@0A470
L0A471	db	50h, 1Eh, 0B8h	;@0A471
	dw	seg S589_START
	db	8Eh, 0D8h, 0C6h, 6, 4Ch, 0, 1, 0B8h, 2, 0, 0E8h, 61h, 3, 3Dh, 0, 0
	db	75h, 3, 0EBh, 10h, 90h, 3Dh, 0FFh, 0FFh, 75h, 5, 0EBh, 3, 0EBh, 6, 90h, 1Fh
	db	83h, 0C4h, 2, 0CBh, 2Eh, 0C7h, 6, 5, 0, 88h, 0Eh, 2Eh, 0C7h, 6, 7, 0
	dw	seg L00000
	db	1Fh, 58h, 2Eh, 0FFh, 2Eh, 5, 0, 0, 41h, 49h, 41h, 3Dh, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24h, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 24h, 43h, 48h, 41h, 52h, 41h, 43h, 54h, 45h, 52h, 49h, 53h, 54h
	db	49h, 43h, 53h, 0, 43h, 4Fh, 4Eh, 46h, 49h, 47h, 0, 44h, 45h, 42h, 55h, 47h
	db	0, 44h, 45h, 56h, 49h, 43h, 45h, 0, 45h, 4Eh, 56h, 53h, 49h, 5Ah, 45h, 0
	db	45h, 58h, 50h, 57h, 49h, 4Eh, 44h, 4Fh, 57h, 53h, 0, 48h, 45h, 4Ch, 50h, 0
	db	48h, 49h, 47h, 48h, 4Bh, 45h, 52h, 4Eh, 45h, 4Ch, 0, 49h, 47h, 4Eh, 4Fh, 52h
	db	45h, 49h, 4Eh, 54h, 53h, 0, 4Bh, 45h, 52h, 4Eh, 45h, 4Ch, 0, 4Bh, 49h, 4Ch
	db	4Fh, 53h, 0, 4Ch, 44h, 54h, 53h, 49h, 5Ah, 45h, 0, 4Ch, 4Fh, 41h, 44h, 4Ch
	db	4Fh, 57h, 0, 4Ch, 4Fh, 57h, 41h, 4Ch, 4Ch, 4Fh, 43h, 41h, 54h, 45h, 0, 4Ch
	db	4Fh, 57h, 52h, 45h, 53h, 45h, 52h, 56h, 45h, 0, 4Dh, 45h, 47h, 53h, 0, 50h
	db	52h, 47h, 41h, 4Ch, 4Ch, 4Fh, 57h, 53h, 49h, 4Eh, 54h, 36h, 38h, 0, 50h, 53h
	db	32h, 0, 50h, 53h, 50h, 53h, 57h, 49h, 54h, 43h, 48h, 0, 52h, 45h, 45h, 4Eh
	db	41h, 42h, 4Ch, 45h, 41h, 32h, 30h, 0, 52h, 45h, 4Dh, 4Fh, 56h, 45h, 0, 52h
	db	4Bh, 45h, 52h, 4Eh, 45h, 4Ch, 0, 53h, 54h, 41h, 52h, 54h, 4Bh, 49h, 4Ch, 4Fh
	db	0, 53h, 54h, 41h, 52h, 54h, 4Dh, 45h, 47h, 0, 54h, 52h, 41h, 43h, 45h, 0
	db	58h, 38h, 37h, 0, 51h, 55h, 49h, 45h, 54h, 0, 0BCh, 6, 7, 0, 0, 0
	db	0CCh, 6, 0Ah, 0, 0, 0, 0D3h, 6, 2, 60h, 0, 0, 0D9h, 6, 1, 6Ch
	db	0, 0, 0E0h, 6, 0Bh, 0, 0, 0, 0E8h, 6, 1, 2Ah, 0, 0, 0F3h, 6
	db	0Dh, 0, 0, 0, 0F8h, 6, 1, 33h, 0, 1, 3, 7, 1, 2Fh, 0, 0
	db	0Eh, 7, 0Bh, 0, 0, 0, 15h, 7, 6, 5Bh, 0, 1, 1Bh, 7, 3, 6Ah
	db	0, 0, 23h, 7, 1, 34h, 0, 0, 2Bh, 7, 3, 62h, 0, 0, 37h, 7
	db	3, 64h, 0, 0, 42h, 7, 5, 5Bh, 0, 0, 47h, 7, 1, 4Ah, 0, 0
	db	56h, 7, 0Bh, 0, 0, 0, 5Ah, 7, 1, 30h, 0, 0, 64h, 7, 0Bh, 0
	db	0, 0, 70h, 7, 0Ch, 0, 0, 0, 77h, 7, 0Bh, 0, 0, 0, 7Fh, 7
	db	6, 57h, 0, 1, 89h, 7, 5, 57h, 0, 0, 92h, 7, 2, 27h, 0, 0
	db	98h, 7, 0Bh, 0, 0, 0, 9Ch, 7, 1, 91h, 0, 0
S9FA	ends
	end	start
