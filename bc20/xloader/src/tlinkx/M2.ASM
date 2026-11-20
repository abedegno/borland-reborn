	.286p
	locals
	public	L03F2A
	public	L03FCD
	extrn	S2F4_START:byte
	extrn	S6FEa_START:byte
	extrn	_DATA_START:byte

S3E6	segment para public 'CODE'
	assume	cs:S3E6
L03E60:	mov	si, 692h	;@03E60
	push	ds	;@03E63
	mov	ax, seg _DATA_START	;@03E64
	mov	ds, ax	;@03E67
	mov	ax, word ptr [si+12h]	;@03E69
	mov	word ptr es:[di], ax	;@03E6C
	mov	ax, word ptr [si+18h]	;@03E6F
	mov	word ptr es:[di+4], ax	;@03E72
	mov	ax, word ptr [si+14h]	;@03E76
	mov	word ptr es:[di+8], ax	;@03E79
	mov	ax, word ptr [si+16h]	;@03E7D
	mov	word ptr es:[di+0Ch], ax	;@03E80
	mov	ax, word ptr [si+1Eh]	;@03E84
	mov	word ptr es:[di+18h], ax	;@03E87
	mov	ax, word ptr [si+20h]	;@03E8B
	mov	word ptr es:[di+1Ch], ax	;@03E8E
	mov	ax, word ptr [si+1Ah]	;@03E92
	mov	word ptr es:[di+10h], ax	;@03E95
	mov	ax, word ptr [si+1Ch]	;@03E99
	mov	word ptr es:[di+14h], ax	;@03E9C
	mov	ax, word ptr [si+0Eh]	;@03EA0
	mov	word ptr es:[di+22h], ax	;@03EA3
	mov	ax, word ptr [si+24h]	;@03EA7
	mov	word ptr es:[di+26h], ax	;@03EAA
	mov	ax, word ptr [si+26h]	;@03EAE
	mov	word ptr es:[di+2Ah], ax	;@03EB1
	mov	ax, word ptr [si+28h]	;@03EB5
	mov	word ptr es:[di+28h], ax	;@03EB8
	mov	ax, word ptr [si+22h]	;@03EBC
	mov	word ptr es:[di+2Ch], ax	;@03EBF
	pop	ds	;@03EC3
	ret	;@03EC4
L03EC5:	mov	si, 692h	;@03EC5
	push	ds	;@03EC8
	mov	ax, seg _DATA_START	;@03EC9
	mov	ds, ax	;@03ECC
	mov	ax, word ptr es:[di]	;@03ECE
	mov	word ptr [si+12h], ax	;@03ED1
	mov	ax, word ptr es:[di+4]	;@03ED4
	mov	word ptr [si+18h], ax	;@03ED8
	mov	ax, word ptr es:[di+8]	;@03EDB
	mov	word ptr [si+14h], ax	;@03EDF
	mov	ax, word ptr es:[di+0Ch]	;@03EE2
	mov	word ptr [si+16h], ax	;@03EE6
	mov	ax, word ptr es:[di+18h]	;@03EE9
	mov	word ptr [si+1Eh], ax	;@03EED
	mov	ax, word ptr es:[di+1Ch]	;@03EF0
	mov	word ptr [si+20h], ax	;@03EF4
	mov	ax, word ptr es:[di+10h]	;@03EF7
	mov	word ptr [si+1Ah], ax	;@03EFB
	mov	ax, word ptr es:[di+14h]	;@03EFE
	mov	word ptr [si+1Ch], ax	;@03F02
	mov	ax, word ptr es:[di+22h]	;@03F05
	mov	word ptr [si+0Eh], ax	;@03F09
	mov	ax, word ptr es:[di+26h]	;@03F0C
	mov	word ptr [si+24h], ax	;@03F10
	mov	ax, word ptr es:[di+2Ah]	;@03F13
	mov	word ptr [si+26h], ax	;@03F17
	mov	ax, word ptr es:[di+28h]	;@03F1A
	mov	word ptr [si+28h], ax	;@03F1E
	mov	ax, word ptr es:[di+2Ch]	;@03F21
	mov	word ptr [si+22h], ax	;@03F25
	pop	ds	;@03F28
	ret	;@03F29
L03F2A:	push	ds	;@03F2A
	db	0BBh	;@03F2B
	dw	seg S2F4_START
	db	8Eh, 0C3h	; mov es, bx	;@03F2E
	mov	ax, word ptr ds:[83Ch]	;@03F30
	mov	word ptr es:[0Ch], ax	;@03F33
	mov	ax, word ptr ds:[0A3h]	;@03F37
	mov	word ptr es:[0Ah], ax	;@03F3A
	mov	ax, word ptr ds:[7Bh]	;@03F3E
	mov	word ptr es:[0Eh], ax	;@03F41
	mov	ax, word ptr ds:[77h]	;@03F45
	mov	word ptr es:[10h], ax	;@03F48
	mov	ds, bx	;@03F4C
	mov	si, 692h	;@03F4E
	mov	ax, seg _DATA_START	;@03F51
	mov	es, ax	;@03F54
	mov	bx, word ptr es:[si+18h]	;@03F56
	cmp	bx, -1	;@03F5A
	je	@@5	;@03F5D
	mov	word ptr ds:[6], bp	;@03F5F
	mov	word ptr ds:[8], sp	;@03F63
	mov	di, 12h	;@03F67
	push	ds	;@03F6A
	pop	es	;@03F6B
	call	L03E60	;@03F6C
	mov	dx, 10h	;@03F6F
	and	dx, dx	;@03F72
	je	@@3	;@03F74
	mov	ax, seg S6FEa_START	;@03F76
	mov	es, ax	;@03F79
	xor	di, di	;@03F7B
@@1:	cmp	bx, word ptr es:[di]	;@03F7D
	jb	@@2	;@03F80
	cmp	bx, word ptr es:[di+2]	;@03F82
	jbe	@@4	;@03F86
@@2:	add	di, 8	;@03F88
	cmp	di, dx	;@03F8B
	jb	@@1	;@03F8D
@@3:	mov	ax, 1	;@03F8F
	pop	ds	;@03F92
	retf	;@03F93
@@4:	mov	si, 12h	;@03F94
	sub	bx, word ptr es:[di]	;@03F97
	call	dword ptr es:[di+4]	;@03F9A
	mov	di, 12h	;@03F9E
	push	ds	;@03FA1
	pop	es	;@03FA2
	call	L03EC5	;@03FA3
	xor	ax, ax	;@03FA6
	pop	ds	;@03FA8
	retf	;@03FA9
@@5:	mov	di, word ptr ds:[444h]	;@03FAA
	mov	sp, di	;@03FAE
	mov	ax, ss	;@03FB0
	mov	es, ax	;@03FB2
	mov	cx, word ptr ds:[448h]	;@03FB4
	mov	si, 44h	;@03FB8
	rep movsw	;@03FBB
	les	di, dword ptr ds:[44Ah]	;@03FBD
	call	L03E60	;@03FC1
	mov	bp, word ptr ds:[446h]	;@03FC4
	mov	di, word ptr ds:[44Ah]	;@03FC8
	retf	;@03FCC
L03FCD:	mov	word ptr ds:[44Ah], di	;@03FCD
	mov	word ptr ds:[44Ch], es	;@03FD1
	call	L03EC5	;@03FD5
	mov	word ptr ds:[444h], sp	;@03FD8
	mov	word ptr ds:[446h], bp	;@03FDC
	mov	si, sp	;@03FE0
	mov	cx, word ptr ds:[6]	;@03FE2
	add	cx, 6	;@03FE6
	sub	cx, si	;@03FE9
	shr	cx, 1	;@03FEB
	mov	word ptr ds:[448h], cx	;@03FED
	mov	di, 44h	;@03FF1
	push	ds	;@03FF4
	push	ss	;@03FF5
	pop	ds	;@03FF6
	pop	es	;@03FF7
	rep movsw	;@03FF8
	push	es	;@03FFA
	pop	ds	;@03FFB
	mov	sp, word ptr ds:[8]	;@03FFC
	mov	bp, word ptr ds:[6]	;@04000
	xor	ax, ax	;@04004
	pop	ds	;@04006
	retf	;@04007
S3E6	ends
	end
