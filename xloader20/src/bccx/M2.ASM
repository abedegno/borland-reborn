	.286p
	locals
	public	L042A6
	public	L04349
	extrn	S32C_START:byte
	extrn	S736a_START:byte
	extrn	_DATA_START:byte

S41D	segment byte public 'CODE'
	assume	cs:S41D
L041DC:	mov	si, 814h	;@041DC
	push	ds	;@041DF
	mov	ax, seg _DATA_START	;@041E0
	mov	ds, ax	;@041E3
	mov	ax, word ptr [si+12h]	;@041E5
	mov	word ptr es:[di], ax	;@041E8
	mov	ax, word ptr [si+18h]	;@041EB
	mov	word ptr es:[di+4], ax	;@041EE
	mov	ax, word ptr [si+14h]	;@041F2
	mov	word ptr es:[di+8], ax	;@041F5
	mov	ax, word ptr [si+16h]	;@041F9
	mov	word ptr es:[di+0Ch], ax	;@041FC
	mov	ax, word ptr [si+1Eh]	;@04200
	mov	word ptr es:[di+18h], ax	;@04203
	mov	ax, word ptr [si+20h]	;@04207
	mov	word ptr es:[di+1Ch], ax	;@0420A
	mov	ax, word ptr [si+1Ah]	;@0420E
	mov	word ptr es:[di+10h], ax	;@04211
	mov	ax, word ptr [si+1Ch]	;@04215
	mov	word ptr es:[di+14h], ax	;@04218
	mov	ax, word ptr [si+0Eh]	;@0421C
	mov	word ptr es:[di+22h], ax	;@0421F
	mov	ax, word ptr [si+24h]	;@04223
	mov	word ptr es:[di+26h], ax	;@04226
	mov	ax, word ptr [si+26h]	;@0422A
	mov	word ptr es:[di+2Ah], ax	;@0422D
	mov	ax, word ptr [si+28h]	;@04231
	mov	word ptr es:[di+28h], ax	;@04234
	mov	ax, word ptr [si+22h]	;@04238
	mov	word ptr es:[di+2Ch], ax	;@0423B
	pop	ds	;@0423F
	ret	;@04240
L04241:	mov	si, 814h	;@04241
	push	ds	;@04244
	mov	ax, seg _DATA_START	;@04245
	mov	ds, ax	;@04248
	mov	ax, word ptr es:[di]	;@0424A
	mov	word ptr [si+12h], ax	;@0424D
	mov	ax, word ptr es:[di+4]	;@04250
	mov	word ptr [si+18h], ax	;@04254
	mov	ax, word ptr es:[di+8]	;@04257
	mov	word ptr [si+14h], ax	;@0425B
	mov	ax, word ptr es:[di+0Ch]	;@0425E
	mov	word ptr [si+16h], ax	;@04262
	mov	ax, word ptr es:[di+18h]	;@04265
	mov	word ptr [si+1Eh], ax	;@04269
	mov	ax, word ptr es:[di+1Ch]	;@0426C
	mov	word ptr [si+20h], ax	;@04270
	mov	ax, word ptr es:[di+10h]	;@04273
	mov	word ptr [si+1Ah], ax	;@04277
	mov	ax, word ptr es:[di+14h]	;@0427A
	mov	word ptr [si+1Ch], ax	;@0427E
	mov	ax, word ptr es:[di+22h]	;@04281
	mov	word ptr [si+0Eh], ax	;@04285
	mov	ax, word ptr es:[di+26h]	;@04288
	mov	word ptr [si+24h], ax	;@0428C
	mov	ax, word ptr es:[di+2Ah]	;@0428F
	mov	word ptr [si+26h], ax	;@04293
	mov	ax, word ptr es:[di+28h]	;@04296
	mov	word ptr [si+28h], ax	;@0429A
	mov	ax, word ptr es:[di+2Ch]	;@0429D
	mov	word ptr [si+22h], ax	;@042A1
	pop	ds	;@042A4
	ret	;@042A5
L042A6:	push	ds	;@042A6
	mov	bx, seg S32C_START	;@042A7
	mov	es, bx	;@042AA
	mov	ax, word ptr ds:[9BEh]	;@042AC
	mov	word ptr es:[8], ax	;@042AF
	mov	ax, word ptr ds:[0A1h]	;@042B3
	mov	word ptr es:[6], ax	;@042B6
	mov	ax, word ptr ds:[7Bh]	;@042BA
	mov	word ptr es:[0Ah], ax	;@042BD
	mov	ax, word ptr ds:[77h]	;@042C1
	mov	word ptr es:[0Ch], ax	;@042C4
	mov	ds, bx	;@042C8
	mov	si, 814h	;@042CA
	mov	ax, seg _DATA_START	;@042CD
	mov	es, ax	;@042D0
	mov	bx, word ptr es:[si+18h]	;@042D2
	cmp	bx, -1	;@042D6
	je	@@5	;@042D9
	mov	word ptr ds:[2], bp	;@042DB
	mov	word ptr ds:[4], sp	;@042DF
	mov	di, 0Eh	;@042E3
	push	ds	;@042E6
	pop	es	;@042E7
	call	L041DC	;@042E8
	mov	dx, 10h	;@042EB
	and	dx, dx	;@042EE
	je	@@3	;@042F0
	mov	ax, seg S736a_START	;@042F2
	mov	es, ax	;@042F5
	xor	di, di	;@042F7
@@1:	cmp	bx, word ptr es:[di]	;@042F9
	jb	@@2	;@042FC
	cmp	bx, word ptr es:[di+2]	;@042FE
	jbe	@@4	;@04302
@@2:	add	di, 8	;@04304
	cmp	di, dx	;@04307
	jb	@@1	;@04309
@@3:	mov	ax, 1	;@0430B
	pop	ds	;@0430E
	retf	;@0430F
@@4:	mov	si, 0Eh	;@04310
	sub	bx, word ptr es:[di]	;@04313
	call	dword ptr es:[di+4]	;@04316
	mov	di, 0Eh	;@0431A
	push	ds	;@0431D
	pop	es	;@0431E
	call	L04241	;@0431F
	xor	ax, ax	;@04322
	pop	ds	;@04324
	retf	;@04325
@@5:	mov	di, word ptr ds:[440h]	;@04326
	mov	sp, di	;@0432A
	mov	ax, ss	;@0432C
	mov	es, ax	;@0432E
	mov	cx, word ptr ds:[444h]	;@04330
	mov	si, 40h	;@04334
	rep movsw	;@04337
	les	di, dword ptr ds:[446h]	;@04339
	call	L041DC	;@0433D
	mov	bp, word ptr ds:[442h]	;@04340
	mov	di, word ptr ds:[446h]	;@04344
	retf	;@04348
L04349:	mov	word ptr ds:[446h], di	;@04349
	mov	word ptr ds:[448h], es	;@0434D
	call	L04241	;@04351
	mov	word ptr ds:[440h], sp	;@04354
	mov	word ptr ds:[442h], bp	;@04358
	mov	si, sp	;@0435C
	mov	cx, word ptr ds:[2]	;@0435E
	add	cx, 6	;@04362
	sub	cx, si	;@04365
	shr	cx, 1	;@04367
	mov	word ptr ds:[444h], cx	;@04369
	mov	di, 40h	;@0436D
	push	ds	;@04370
	push	ss	;@04371
	pop	ds	;@04372
	pop	es	;@04373
	rep movsw	;@04374
	push	es	;@04376
	pop	ds	;@04377
	mov	sp, word ptr ds:[4]	;@04378
	mov	bp, word ptr ds:[2]	;@0437C
	xor	ax, ax	;@04380
	pop	ds	;@04382
	retf	;@04383
	db	0D1h, 0E3h, 0FFh, 97h, 7Eh, 0Dh, 0CBh, 0BEh	;@04384
S41D	ends
	end
