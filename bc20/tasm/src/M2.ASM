	.286
	locals
CODE0	segment byte public 'CODE'
CODE0	ends
DATA	segment byte public 'DATA'
DATA	ends
BSS	segment byte public 'BSS'
BSS	ends
DGROUP	group	DATA,BSS
	public	L0FA44
	public	L0FAA6
	public	L0FAFB
	public	L0FB18
	public	L0FB8D
	public	L0FC4F
	public	L0FCE0
	public	L0FCFE
	public	L0FD9E
	public	L0FDA5
	public	L0FDBE
	public	L0FF1A
	public	L0FF43
	public	L0FFD1
	public	L0FFFF
	public	L10007
	public	L10027
	public	L1002C
	public	L10036
	public	L10060
	public	L10086
	public	L100A5
	public	L100A6
	public	L100B8
	public	L100D0
	public	L100D8
	public	L100DE
	public	L1010C
	public	L1011E
	public	L10138
	public	L10152
	public	L1016C
	public	L10177
	public	L1018B
	public	L101BF
	public	L101DD
	public	L101EC
	public	L101F0
	public	L10207
	public	L10216
	public	L10225
	public	L1022E
	public	L10233
	public	L10238
	public	L1023D
	public	L10242
	public	L108C1
	public	L10B6F
	public	L10BAA
	public	L11156
	extrn	L0003E:far
	extrn	L00042:far
	extrn	L00046:far
	extrn	L0004A:far
	extrn	L0004E:far
	extrn	L00052:far
	extrn	L00056:far
	extrn	L0005A:far
	extrn	L0005E:far
	extrn	L00066:far
	extrn	L0006A:far
	extrn	L0006E:far
	extrn	L00072:far
	extrn	L00076:far
	extrn	L0007A:far
	extrn	L0007E:far
	extrn	L0F0A1:far
	extrn	L11293:near
	extrn	L1129C:near
	extrn	L112DA:near
	extrn	L112E6:near
	extrn	L112F6:near
	extrn	L11694:near
	extrn	L11699:near
	extrn	L116B9:near
	extrn	L11763:near
	extrn	L12051:near
	extrn	L1455E:far

C0F9B	segment byte public 'CODE'
	assume	cs:C0F9B
L0FA44:	push	bx	;@0FA44
	push	cx	;@0FA45
	push	dx	;@0FA46
	push	es	;@0FA47
	push	ds	;@0FA48
@@1:	mov	bx, 38E0h	;@0FA49
@@2:	mov	cx, word ptr [bx]	;@0FA4C
	jcxz	@@3	;@0FA4E
	mov	es, cx	;@0FA50
	cmp	word ptr es:[2], ax	;@0FA52
	je	@@5	;@0FA57
	jae	@@4	;@0FA59
	mov	ds, cx	;@0FA5B
	mov	bx, 0	;@0FA5D
	jmp	@@2	;@0FA60
@@3:	pop	ds	;@0FA62
	push	ds	;@0FA63
	call	far ptr L0F0A1	;@0FA64
	jae	@@1	;@0FA69
	push	ax	;@0FA6B
	call	L0FD6D	;@0FA6C
	pop	ax	;@0FA6F
	jae	@@1	;@0FA70
	mov	byte ptr ds:[38D6h], 1	;@0FA72
	mov	sp, word ptr ds:[38BAh]	;@0FA77
	retf	;@0FA7B
@@4:	add	cx, ax	;@0FA7C
	mov	word ptr [bx], cx	;@0FA7E
	mov	ds, cx	;@0FA80
	mov	bx, word ptr es:[0]	;@0FA82
	mov	word ptr ds:[0], bx	;@0FA87
	mov	bx, word ptr es:[2]	;@0FA8B
	sub	bx, ax	;@0FA90
	mov	word ptr ds:[2], bx	;@0FA92
	jmp	short @@6	;@0FA96
@@5:	mov	ax, word ptr es:[0]	;@0FA98
	mov	word ptr [bx], ax	;@0FA9C
@@6:	mov	ax, es	;@0FA9E
	pop	ds	;@0FAA0
	pop	es	;@0FAA1
	pop	dx	;@0FAA2
	pop	cx	;@0FAA3
	pop	bx	;@0FAA4
	retf	;@0FAA5
L0FAA6:	push	ax	;@0FAA6
	push	bx	;@0FAA7
	push	cx	;@0FAA8
	push	dx	;@0FAA9
	push	ds	;@0FAAA
	push	es	;@0FAAB
	add	dx, ax	;@0FAAC
	mov	bx, 38E0h	;@0FAAE
@@1:	mov	cx, word ptr [bx]	;@0FAB1
@@2:	mov	es, cx	;@0FAB3
	jcxz	@@5	;@0FAB5
	cmp	dx, cx	;@0FAB7
	jb	@@5	;@0FAB9
	je	@@4	;@0FABB
	add	cx, word ptr es:[2]	;@0FABD
	cmp	cx, ax	;@0FAC2
	je	@@3	;@0FAC4
	push	es	;@0FAC6
	pop	ds	;@0FAC7
	mov	bx, 0	;@0FAC8
	jmp	@@1	;@0FACB
@@3:	mov	ax, es	;@0FACD
	mov	cx, word ptr es:[0]	;@0FACF
	mov	word ptr [bx], cx	;@0FAD4
	jmp	@@2	;@0FAD6
@@4:	add	dx, word ptr es:[2]	;@0FAD8
	mov	cx, word ptr es:[0]	;@0FADD
	mov	word ptr [bx], cx	;@0FAE2
	jmp	@@2	;@0FAE4
@@5:	mov	word ptr [bx], ax	;@0FAE6
	sub	dx, ax	;@0FAE8
	mov	ds, ax	;@0FAEA
	mov	word ptr ds:[2], dx	;@0FAEC
	mov	word ptr ds:[0], es	;@0FAF0
	pop	es	;@0FAF4
	pop	ds	;@0FAF5
	pop	dx	;@0FAF6
	pop	cx	;@0FAF7
	pop	bx	;@0FAF8
	pop	ax	;@0FAF9
	retf	;@0FAFA
L0FAFB:	xor	ax, ax	;@0FAFB
	mov	cx, word ptr ds:[38E0h]	;@0FAFD
@@1:	jcxz	@@3	;@0FB01
	mov	es, cx	;@0FB03
	cmp	ax, word ptr es:[2]	;@0FB05
	jae	@@2	;@0FB0A
	mov	ax, word ptr es:[2]	;@0FB0C
@@2:	mov	cx, word ptr es:[0]	;@0FB10
	jmp	@@1	;@0FB15
@@3:	retf	;@0FB17
L0FB18:	push	bx	;@0FB18
	push	dx	;@0FB19
	push	si	;@0FB1A
	push	es	;@0FB1B
	push	ds	;@0FB1C
	mov	si, cx	;@0FB1D
@@1:	mov	bx, 38E0h	;@0FB1F
@@2:	mov	cx, word ptr [bx]	;@0FB22
	jcxz	@@3	;@0FB24
	mov	es, cx	;@0FB26
	cmp	word ptr es:[2], ax	;@0FB28
	je	@@6	;@0FB2D
	jae	@@4	;@0FB2F
	mov	ds, cx	;@0FB31
	mov	bx, 0	;@0FB33
	jmp	@@2	;@0FB36
@@3:	pop	ds	;@0FB38
	push	ds	;@0FB39
	call	far ptr L0F0A1	;@0FB3A
	jae	@@1	;@0FB3F
	push	ax	;@0FB41
	push	si	;@0FB42
	call	L0FD6D	;@0FB43
	pop	si	;@0FB46
	pop	ax	;@0FB47
	jae	@@1	;@0FB48
	mov	byte ptr ds:[38D6h], 1	;@0FB4A
	mov	sp, word ptr ds:[38BAh]	;@0FB4F
	retf	;@0FB53
@@4:	cmp	word ptr es:[2], si	;@0FB54
	je	@@7	;@0FB59
	jae	@@5	;@0FB5B
	mov	si, ax	;@0FB5D
@@5:	add	cx, si	;@0FB5F
	mov	word ptr [bx], cx	;@0FB61
	mov	ds, cx	;@0FB63
	mov	bx, word ptr es:[0]	;@0FB65
	mov	word ptr ds:[0], bx	;@0FB6A
	mov	bx, word ptr es:[2]	;@0FB6E
	sub	bx, si	;@0FB73
	mov	word ptr ds:[2], bx	;@0FB75
	jmp	short @@8	;@0FB79
@@6:	mov	si, ax	;@0FB7B
@@7:	mov	ax, word ptr es:[0]	;@0FB7D
	mov	word ptr [bx], ax	;@0FB81
@@8:	mov	ax, es	;@0FB83
	mov	cx, si	;@0FB85
	pop	ds	;@0FB87
	pop	es	;@0FB88
	pop	si	;@0FB89
	pop	dx	;@0FB8A
	pop	bx	;@0FB8B
	retf	;@0FB8C
L0FB8D:	add	ax, 3	;@0FB8D
	shr	ax, 1	;@0FB90
	shr	ax, 1	;@0FB92
	push	bx	;@0FB94
	push	cx	;@0FB95
	push	dx	;@0FB96
	push	ds	;@0FB97
	mov	bx, 38E2h	;@0FB98
@@1:	mov	cx, word ptr [bx]	;@0FB9B
	jcxz	@@4	;@0FB9D
	mov	di, cx	;@0FB9F
	mov	es, word ptr ss:[38E4h]	;@0FBA1
@@2:	sub	di, word ptr es:[4]	;@0FBA6
	jb	@@3	;@0FBAB
	mov	es, word ptr es:[2]	;@0FBAD
	jmp	@@2	;@0FBB2
@@3:	add	di, word ptr es:[4]	;@0FBB4
	shl	di, 1	;@0FBB9
	shl	di, 1	;@0FBBB
	cmp	word ptr es:[di+2], ax	;@0FBBD
	je	@@8	;@0FBC1
	jae	@@9	;@0FBC3
	push	es	;@0FBC5
	pop	ds	;@0FBC6
	mov	bx, di	;@0FBC7
	add	bx, 0	;@0FBC9
	jmp	@@1	;@0FBCC
@@4:	pop	ds	;@0FBCE
	push	ds	;@0FBCF
@@5:	mov	cx, word ptr ds:[38E6h]	;@0FBD0
	jcxz	@@6	;@0FBD4
	mov	es, cx	;@0FBD6
	mov	cx, word ptr es:[6]	;@0FBD8
	shl	cx, 1	;@0FBDD
	shl	cx, 1	;@0FBDF
	sub	cx, word ptr es:[4]	;@0FBE1
	cmp	cx, ax	;@0FBE6
	jae	@@7	;@0FBE8
	push	ax	;@0FBEA
	call	L0FD6D	;@0FBEB
	pop	ax	;@0FBEE
@@6:	push	ax	;@0FBEF
	call	L0FD0A	;@0FBF0
	pop	ax	;@0FBF3
	jmp	@@5	;@0FBF4
@@7:	add	ax, word ptr es:[4]	;@0FBF6
	mov	cx, ax	;@0FBFB
	xchg	word ptr es:[4], ax	;@0FBFD
	add	ax, word ptr es:[0]	;@0FC02
	add	cx, word ptr es:[0]	;@0FC07
	jae	@@10	;@0FC0C
	mov	byte ptr ds:[38D6h], 2	;@0FC0E
	mov	sp, word ptr ds:[38BAh]	;@0FC13
	stc	;@0FC17
	retf	;@0FC18
@@8:	mov	ax, word ptr es:[di]	;@0FC19
	mov	word ptr [bx], ax	;@0FC1C
	mov	ax, cx	;@0FC1E
	jmp	short @@13	;@0FC20
@@9:	sub	word ptr es:[di+2], ax	;@0FC22
	mov	ax, word ptr es:[di+2]	;@0FC26
	add	ax, cx	;@0FC2A
@@10:	mov	di, ax	;@0FC2C
	mov	es, word ptr ss:[38E4h]	;@0FC2E
@@11:	sub	di, word ptr es:[4]	;@0FC33
	jb	@@12	;@0FC38
	mov	es, word ptr es:[2]	;@0FC3A
	jmp	@@11	;@0FC3F
@@12:	add	di, word ptr es:[4]	;@0FC41
	shl	di, 1	;@0FC46
	shl	di, 1	;@0FC48
@@13:	pop	ds	;@0FC4A
	pop	dx	;@0FC4B
	pop	cx	;@0FC4C
	pop	bx	;@0FC4D
	retf	;@0FC4E
L0FC4F:	add	dx, 3	;@0FC4F
	shr	dx, 1	;@0FC52
	shr	dx, 1	;@0FC54
	push	bx	;@0FC56
	push	cx	;@0FC57
	push	si	;@0FC58
	push	di	;@0FC59
	push	es	;@0FC5A
	push	ds	;@0FC5B
	add	dx, ax	;@0FC5C
	mov	bx, 38E2h	;@0FC5E
@@1:	mov	cx, word ptr [bx]	;@0FC61
@@2:	jcxz	@@7	;@0FC63
	mov	di, cx	;@0FC65
	mov	es, word ptr ss:[38E4h]	;@0FC67
@@3:	sub	di, word ptr es:[4]	;@0FC6C
	jb	@@4	;@0FC71
	mov	es, word ptr es:[2]	;@0FC73
	jmp	@@3	;@0FC78
@@4:	add	di, word ptr es:[4]	;@0FC7A
	shl	di, 1	;@0FC7F
	shl	di, 1	;@0FC81
	cmp	dx, cx	;@0FC83
	jb	@@7	;@0FC85
	jne	@@5	;@0FC87
	add	dx, word ptr es:[di+2]	;@0FC89
	mov	cx, word ptr es:[di]	;@0FC8D
	mov	word ptr [bx], cx	;@0FC90
	jmp	@@2	;@0FC92
@@5:	mov	si, cx	;@0FC94
	add	si, word ptr es:[di+2]	;@0FC96
	cmp	si, ax	;@0FC9A
	jne	@@6	;@0FC9C
	mov	ax, cx	;@0FC9E
	mov	cx, word ptr es:[di]	;@0FCA0
	mov	word ptr [bx], cx	;@0FCA3
	jmp	@@2	;@0FCA5
@@6:	push	es	;@0FCA7
	pop	ds	;@0FCA8
	mov	bx, di	;@0FCA9
	add	bx, 0	;@0FCAB
	jmp	@@1	;@0FCAE
@@7:	mov	word ptr [bx], ax	;@0FCB0
	sub	dx, ax	;@0FCB2
	mov	di, ax	;@0FCB4
	mov	es, word ptr ss:[38E4h]	;@0FCB6
@@8:	sub	di, word ptr es:[4]	;@0FCBB
	jb	@@9	;@0FCC0
	mov	es, word ptr es:[2]	;@0FCC2
	jmp	@@8	;@0FCC7
@@9:	add	di, word ptr es:[4]	;@0FCC9
	shl	di, 1	;@0FCCE
	shl	di, 1	;@0FCD0
	mov	word ptr es:[di+2], dx	;@0FCD2
	mov	word ptr es:[di], cx	;@0FCD6
	pop	ds	;@0FCD9
	pop	es	;@0FCDA
	pop	di	;@0FCDB
	pop	si	;@0FCDC
	pop	cx	;@0FCDD
	pop	bx	;@0FCDE
	retf	;@0FCDF
L0FCE0:	mov	di, ax	;@0FCE0
	mov	es, word ptr ds:[38E4h]	;@0FCE2
@@1:	sub	di, word ptr es:[4]	;@0FCE6
	jb	@@2	;@0FCEB
	mov	es, word ptr es:[2]	;@0FCED
	jmp	@@1	;@0FCF2
@@2:	add	di, word ptr es:[4]	;@0FCF4
	shl	di, 1	;@0FCF9
	shl	di, 1	;@0FCFB
	retf	;@0FCFD
L0FCFE:	mov	ax, di	;@0FCFE
	shr	ax, 1	;@0FD00
	shr	ax, 1	;@0FD02
	add	ax, word ptr es:[0]	;@0FD04
	retf	;@0FD09
L0FD0A:	add	ax, 5	;@0FD0A
	shr	ax, 1	;@0FD0D
	shr	ax, 1	;@0FD0F
	mov	dx, ax	;@0FD11
@@1:	push	cs	;@0FD13
	call	L0FAFB	;@0FD14
	cmp	ax, dx	;@0FD17
	jae	@@2	;@0FD19
	push	dx	;@0FD1B
	call	far ptr L0F0A1	;@0FD1C
	pop	dx	;@0FD21
	jae	@@1	;@0FD22
@@2:	cmp	ax, 1000h	;@0FD24
	jb	@@3	;@0FD27
	mov	ax, 1000h	;@0FD29
@@3:	mov	dx, ax	;@0FD2C
	push	cs	;@0FD2E
	call	L0FA44	;@0FD2F
	mov	cx, word ptr ds:[38E6h]	;@0FD32
	jcxz	@@4	;@0FD36
	mov	es, cx	;@0FD38
	mov	word ptr es:[2], ax	;@0FD3A
	mov	cx, word ptr es:[0]	;@0FD3E
	add	cx, word ptr es:[4]	;@0FD43
	jmp	short @@5	;@0FD48
@@4:	mov	word ptr ds:[38E4h], ax	;@0FD4A
	xor	cx, cx	;@0FD4D
@@5:	mov	word ptr ds:[38E6h], ax	;@0FD4F
	mov	es, ax	;@0FD52
	mov	word ptr es:[2], 0	;@0FD54
	mov	word ptr es:[0], cx	;@0FD5B
	mov	word ptr es:[6], dx	;@0FD60
	mov	word ptr es:[4], 2	;@0FD65
	ret	;@0FD6C
L0FD6D:	mov	cx, word ptr ds:[38E6h]	;@0FD6D
	jcxz	@@1	;@0FD71
	mov	es, cx	;@0FD73
	mov	ax, word ptr es:[4]	;@0FD75
	add	ax, 3	;@0FD79
	shr	ax, 1	;@0FD7C
	shr	ax, 1	;@0FD7E
	cmp	ax, word ptr es:[6]	;@0FD80
	je	@@1	;@0FD85
	mov	dx, word ptr es:[6]	;@0FD87
	mov	word ptr es:[6], ax	;@0FD8C
	sub	dx, ax	;@0FD90
	mov	bx, es	;@0FD92
	add	ax, bx	;@0FD94
	push	cs	;@0FD96
	call	L0FAA6	;@0FD97
	clc	;@0FD9A
	ret	;@0FD9B
@@1:	stc	;@0FD9C
	ret	;@0FD9D
L0FD9E:	mov	word ptr ds:[38EAh], 0	;@0FD9E
	retf	;@0FDA4
L0FDA5:	mov	dx, word ptr ds:[38EAh]	;@0FDA5
	and	dx, dx	;@0FDA9
	je	@@1	;@0FDAB
	mov	word ptr ds:[38EAh], 0	;@0FDAD
	mov	ax, word ptr ds:[38E8h]	;@0FDB3
	push	cs	;@0FDB6
	call	L0FAA6	;@0FDB7
	clc	;@0FDBA
	retf	;@0FDBB
@@1:	stc	;@0FDBC
	retf	;@0FDBD
L0FDBE:	mov	word ptr ds:[38EEh], di	;@0FDBE
	mov	word ptr ds:[38ECh], bx	;@0FDC2
	xor	ax, ax	;@0FDC6
	mov	cx, 3Bh	;@0FDC8
	push	ds	;@0FDCB
	pop	es	;@0FDCC
	mov	di, 3960h	;@0FDCD
	rep stosb	;@0FDD0
	mov	word ptr ds:[397Ah], 3Eh	;@0FDD2
	mov	word ptr ds:[397Ch], 84h	;@0FDD8
	mov	byte ptr ds:[3997h], 1	;@0FDDE
	mov	word ptr ds:[399Bh], 8	;@0FDE3
	call	L0FE63	;@0FDE9
	push	cs	;@0FDEC
	call	L112DA	;@0FDED
	jae	@@1	;@0FDF0
	jmp	L0FFC6	;@0FDF2
@@1:	mov	word ptr ds:[396Ch], bx	;@0FDF5
	mov	word ptr ds:[3960h], 0	;@0FDF9
	mov	byte ptr ds:[376h], 4	;@0FDFF
	mov	byte ptr ds:[382h], 60h	;@0FE04
	cmp	byte ptr ds:[38DBh], 0	;@0FE09
	je	@@2	;@0FE0E
	add	byte ptr ds:[376h], 4	;@0FE10
	sub	byte ptr ds:[382h], 4	;@0FE15
@@2:	mov	si, 34Ch	;@0FE1A
	call	L0FE9D	;@0FE1D
	mov	si, 366h	;@0FE20
	call	L0FE9D	;@0FE23
	mov	es, word ptr ds:[3926h]	;@0FE26
	mov	di, 6	;@0FE2A
	mov	si, word ptr ds:[38ECh]	;@0FE2D
	call	L102FA	;@0FE31
	mov	al, 20h	;@0FE34
	mov	cx, 8	;@0FE36
	rep stosb	;@0FE39
	call	L10347	;@0FE3B
	mov	al, 20h	;@0FE3E
	stosb	;@0FE40
	call	L10360	;@0FE41
	sub	di, 6	;@0FE44
	mov	word ptr es:[2], di	;@0FE47
	mov	es, word ptr ds:[3930h]	;@0FE4C
	mov	di, 6	;@0FE50
	mov	si, word ptr ds:[38EEh]	;@0FE53
	call	L102FA	;@0FE57
	sub	di, 6	;@0FE5A
	mov	word ptr es:[2], di	;@0FE5D
	retf	;@0FE62
L0FE63:	push	cs	;@0FE63
	call	L0FAFB	;@0FE64
	cmp	ax, 800h	;@0FE67
	jae	@@1	;@0FE6A
	cmp	ax, 40h	;@0FE6C
	jae	@@2	;@0FE6F
	mov	ax, 40h	;@0FE71
	jmp	short @@2	;@0FE74
@@1:	mov	ax, 800h	;@0FE76
@@2:	mov	cx, ax	;@0FE79
	push	cs	;@0FE7B
	call	L0FA44	;@0FE7C
	mov	word ptr ds:[3962h], ax	;@0FE7F
	mov	es, ax	;@0FE82
	xor	ax, ax	;@0FE84
	xor	di, di	;@0FE86
	mov	word ptr ds:[3968h], cx	;@0FE88
	shl	cx, 1	;@0FE8C
	shl	cx, 1	;@0FE8E
	shl	cx, 1	;@0FE90
	push	cx	;@0FE92
	shl	cx, 1	;@0FE93
	mov	word ptr ds:[3964h], cx	;@0FE95
	pop	cx	;@0FE99
	rep stosw	;@0FE9A
	ret	;@0FE9C
L0FE9D:	mov	bx, word ptr [si]	;@0FE9D
	cmp	bx, -1	;@0FE9F
	je	@@1	;@0FEA2
	xor	ah, ah	;@0FEA4
	mov	al, byte ptr [si+4]	;@0FEA6
	mov	word ptr [bx+6], ax	;@0FEA9
	mov	al, byte ptr [si+5]	;@0FEAC
	mov	word ptr [bx+4], ax	;@0FEAF
	mov	ax, word ptr [si+2]	;@0FEB2
	mov	word ptr [bx+8], ax	;@0FEB5
	push	si	;@0FEB8
	call	L0FEF3	;@0FEB9
	pop	si	;@0FEBC
	mov	word ptr [bx], ax	;@0FEBD
	mov	word ptr [bx+2], ax	;@0FEBF
	add	si, 6	;@0FEC2
	jmp	L0FE9D	;@0FEC5
@@1:	ret	;@0FEC7
L0FEC8:	mov	bx, word ptr [si]	;@0FEC8
	cmp	bx, -1	;@0FECA
	je	@@3	;@0FECD
	mov	cx, word ptr [bx]	;@0FECF
@@1:	jcxz	@@2	;@0FED1
	mov	ax, cx	;@0FED3
	mov	es, ax	;@0FED5
	push	word ptr es:[0]	;@0FED7
	mov	dx, word ptr [bx+8]	;@0FEDC
	add	dx, 15h	;@0FEDF
	mov	cl, 4	;@0FEE2
	shr	dx, cl	;@0FEE4
	push	cs	;@0FEE6
	call	L0FAA6	;@0FEE7
	pop	cx	;@0FEEA
	jmp	@@1	;@0FEEB
@@2:	add	si, 6	;@0FEED
	jmp	L0FEC8	;@0FEF0
@@3:	ret	;@0FEF2
L0FEF3:	mov	ax, word ptr [bx+8]	;@0FEF3
	add	ax, 15h	;@0FEF6
	mov	cl, 4	;@0FEF9
	shr	ax, cl	;@0FEFB
	mov	cx, ax	;@0FEFD
	push	cs	;@0FEFF
	call	L0FB18	;@0FF00
	mov	es, ax	;@0FF03
	xor	cx, cx	;@0FF05
	mov	word ptr es:[0], cx	;@0FF07
	mov	word ptr es:[2], cx	;@0FF0C
	mov	cx, 6	;@0FF11
	mov	word ptr es:[4], cx	;@0FF14
	ret	;@0FF19
L0FF1A:	mov	ax, word ptr ds:[3962h]	;@0FF1A
	and	ax, ax	;@0FF1D
	je	@@1	;@0FF1F
	mov	dx, word ptr ds:[3968h]	;@0FF21
	push	cs	;@0FF25
	call	L0FAA6	;@0FF26
	mov	word ptr ds:[3962h], 0	;@0FF29
@@1:	mov	bx, word ptr ds:[396Ch]	;@0FF2F
	and	bx, bx	;@0FF33
	jne	@@2	;@0FF35
	retf	;@0FF37
@@2:	push	cs	;@0FF38
	call	L112E6	;@0FF39
	mov	word ptr ds:[396Ch], 0	;@0FF3C
	retf	;@0FF42
L0FF43:	call	L10053	;@0FF43
	mov	si, 366h	;@0FF46
	call	L0FEC8	;@0FF49
	mov	bx, 3942h	;@0FF4C
	call	L10665	;@0FF4F
	test	word ptr ds:[5198h], 80h	;@0FF52
	je	@@2	;@0FF58
	mov	si, 38Ch	;@0FF5A
	call	L0FE9D	;@0FF5D
	call	L105E3	;@0FF60
	mov	si, 562h	;@0FF63
	call	@@4	;@0FF66
	test	word ptr ds:[5198h], 400h	;@0FF69
	jne	@@1	;@0FF6F
	and	word ptr ds:[5198h], 0FCFFh	;@0FF71
@@1:	and	word ptr ds:[5198h], -41h	;@0FF77
	call	L1093E	;@0FF7C
	call	L10053	;@0FF7F
	mov	si, 38Ch	;@0FF82
	call	L0FEC8	;@0FF85
@@2:	mov	ax, word ptr ds:[397Ch]	;@0FF88
	mov	byte ptr ds:[3A4h], al	;@0FF8B
	mov	si, 3A0h	;@0FF8E
	call	L0FE9D	;@0FF91
	mov	si, 56Fh	;@0FF94
	call	@@4	;@0FF97
	call	L10F66	;@0FF9A
	cmp	byte ptr ds:[399Ah], 0	;@0FF9D
	je	@@3	;@0FFA2
	call	L10053	;@0FFA4
@@3:	mov	si, 3A0h	;@0FFA7
	call	L0FEC8	;@0FFAA
	mov	si, 34Ch	;@0FFAD
	call	L0FEC8	;@0FFB0
	push	cs	;@0FFB3
	call	L0FF1A	;@0FFB4
	jb	L0FFC6	;@0FFB7
	retf	;@0FFB9
@@4:	mov	bx, 392Eh	;@0FFBA
	call	L10641	;@0FFBD
	call	L102FA	;@0FFC0
	jmp	L1064A	;@0FFC3
L0FFC6:	mov	byte ptr ds:[38D6h], 7	;@0FFC6
	stc	;@0FFCB
	mov	sp, word ptr ds:[38BAh]	;@0FFCC
	retf	;@0FFD0
L0FFD1:	push	si	;@0FFD1
	push	dx	;@0FFD2
	call	L0FE63	;@0FFD3
	pop	dx	;@0FFD6
	push	cs	;@0FFD7
	call	L112DA	;@0FFD8
	pop	si	;@0FFDB
	jb	L0FFF4	;@0FFDC
	mov	word ptr ds:[396Ch], bx	;@0FFDE
	xor	ax, ax	;@0FFE2
	mov	word ptr ds:[3960h], ax	;@0FFE4
	mov	word ptr ds:[396Ah], ax	;@0FFE7
	call	L10FA6	;@0FFEA
	push	cs	;@0FFED
	call	L0FF1A	;@0FFEE
	jb	L0FFF4	;@0FFF1
	retf	;@0FFF3
L0FFF4:	mov	byte ptr ds:[38D6h], 0Dh	;@0FFF4
	stc	;@0FFF9
	mov	sp, word ptr ds:[38BAh]	;@0FFFA
	retf	;@0FFFE
L0FFFF:	mov	byte ptr ds:[397Ch], cl	;@0FFFF
	call	L105C1	;@10003
	retf	;@10006
L10007:	mov	byte ptr ds:[397Ah], cl	;@10007
	retf	;@1000B
L1000C:	mov	bx, 3938h	;@1000C
L1000F:	cmp	cx, 100h	;@1000F
	jb	@@1	;@10013
	mov	cx, 100h	;@10015
@@1:	mov	si, di	;@10018
	push	es	;@1001A
	call	L10641	;@1001B
	pop	ds	;@1001E
	rep movsb	;@1001F
	push	ss	;@10021
	pop	ds	;@10022
	call	L1064A	;@10023
	retf	;@10026
L10027:	mov	bx, 3942h	;@10027
	jmp	L1000F	;@1002A
L1002C:	inc	word ptr ds:[3970h]	;@1002C
	mov	word ptr ds:[396Eh], 0	;@10030
L10036:	cmp	byte ptr ds:[3997h], 1	;@10036
	je	@@1	;@1003B
	call	L10041	;@1003D
@@1:	retf	;@10040
L10041:	mov	cx, 2	;@10041
	call	L106D5	;@10044
	mov	al, 0Ch	;@10047
	stosb	;@10049
	call	L106C5	;@1004A
	mov	byte ptr ds:[3997h], 1	;@1004D
	ret	;@10052
L10053:	cmp	byte ptr ds:[3997h], 0	;@10053
	jne	@@1	;@10058
	call	L10041	;@1005A
@@1:	jmp	L1071D	;@1005D
L10060:	mov	si, bx	;@10060
	mov	bx, 391Ah	;@10062
	mov	cx, word ptr [bx+8]	;@10065
	call	L10641	;@10068
	call	L10303	;@1006B
	call	L1064A	;@1006E
L10071:	mov	ax, word ptr es:[0]	;@10071
	and	ax, ax	;@10075
	jne	@@1	;@10077
	push	es	;@10079
	call	L0FEF3	;@1007A
	pop	es	;@1007D
	mov	word ptr es:[0], ax	;@1007E
@@1:	mov	word ptr [bx+2], ax	;@10082
	retf	;@10085
L10086:	mov	word ptr ds:[3976h], ax	;@10086
	mov	word ptr ds:[3978h], dx	;@10089
	mov	bx, 3906h	;@1008D
	call	L10641	;@10090
	cmp	word ptr es:[2], 0	;@10093
	jne	@@1	;@10099
	mov	si, 3976h	;@1009B
	call	L107A0	;@1009E
	call	L1064A	;@100A1
@@1:	retf	;@100A4
L100A5:	retf	;@100A5
L100A6:	mov	bx, 3956h	;@100A6
	call	L10641	;@100A9
	push	es	;@100AC
	call	far ptr L1455E	;@100AD
	pop	es	;@100B2
	call	L1064A	;@100B3
	jmp	L10071	;@100B6
L100B8:	mov	bx, 38F2h	;@100B8
	call	L10641	;@100BB
	or	ax, ax	;@100BE
	je	@@2	;@100C0
	mov	cx, ax	;@100C2
	call	L1073E	;@100C4
@@1:	call	L1064A	;@100C7
	retf	;@100CA
@@2:	mov	al, 20h	;@100CB
	stosb	;@100CD
	jmp	@@1	;@100CE
L100D0:	test	word ptr ds:[38C4h], 8000h	;@100D0
	jne	L100DD	;@100D6
L100D8:	mov	byte ptr ds:[3998h], 1	;@100D8
L100DD:	retf	;@100DD
L100DE:	mov	bx, 3910h	;@100DE
	call	L10641	;@100E1
	call	L107A0	;@100E4
	call	@@1	;@100E7
	call	L10655	;@100EA
	retf	;@100ED
@@1:	mov	si, 3A8h	;@100EE
@@2:	cmp	dl, 0	;@100F1
	je	@@3	;@100F4
	mov	al, byte ptr [si]	;@100F6
	mov	ah, 0	;@100F8
	inc	ax	;@100FA
	add	si, ax	;@100FB
	dec	dl	;@100FD
	jmp	@@2	;@100FF
@@3:	lodsb	;@10101
	mov	cl, al	;@10102
	mov	ch, 0	;@10104
	rep movsb	;@10106
	mov	al, 20h	;@10108
	stosb	;@1010A
	ret	;@1010B
L1010C:	mov	bx, 3910h	;@1010C
	call	L10641	;@1010F
	mov	ax, 3F3Fh	;@10112
	rep stosw	;@10115
	mov	al, 20h	;@10117
	stosb	;@10119
	call	L10655	;@1011A
	retf	;@1011D
L1011E:	mov	word ptr ds:[3976h], ax	;@1011E
	mov	bx, 3910h	;@10121
	call	L10641	;@10124
	mov	si, 3976h	;@10127
	mov	cx, 1	;@1012A
	call	L107A0	;@1012D
	mov	ax, 203Ah	;@10130
	stosw	;@10133
	call	L10655	;@10134
	retf	;@10137
L10138:	mov	word ptr ds:[3976h], ax	;@10138
	mov	bx, 3910h	;@1013B
	call	L10641	;@1013E
	mov	si, 3976h	;@10141
	mov	cx, 1	;@10144
	call	L107A0	;@10147
	mov	ax, 207Ch	;@1014A
	stosw	;@1014D
	call	L10655	;@1014E
	retf	;@10151
L10152:	mov	word ptr ds:[3976h], ax	;@10152
	mov	bx, 3910h	;@10155
	call	L10641	;@10158
	mov	si, 3976h	;@1015B
	mov	cx, 1	;@1015E
	call	L107A0	;@10161
	mov	ax, 203Eh	;@10164
	stosw	;@10167
	call	L10655	;@10168
	retf	;@1016B
L1016C:	mov	bx, 3910h	;@1016C
	call	L10641	;@1016F
	stosb	;@10172
	call	L10655	;@10173
	retf	;@10176
L10177:	push	ds	;@10177
	mov	si, di	;@10178
	push	es	;@1017A
	push	cx	;@1017B
	mov	bx, 3910h	;@1017C
	call	L10641	;@1017F
	pop	cx	;@10182
	pop	ds	;@10183
	rep movsb	;@10184
	pop	ds	;@10186
	call	L10655	;@10187
	retf	;@1018A
L1018B:	mov	bx, 3910h	;@1018B
	call	L10641	;@1018E
	cmp	cl, 0FFh	;@10191
	jne	@@1	;@10194
	not	ax	;@10196
	not	dx	;@10198
	add	ax, 1	;@1019A
	adc	dx, 0	;@1019D
	push	ax	;@101A0
	mov	al, 2Dh	;@101A1
	stosb	;@101A3
	pop	ax	;@101A4
@@1:	mov	word ptr ds:[3976h], ax	;@101A5
	mov	cx, 2	;@101A8
	or	dx, dx	;@101AB
	je	@@2	;@101AD
	mov	word ptr ds:[3978h], dx	;@101AF
	add	cx, cx	;@101B3
@@2:	mov	si, 3976h	;@101B5
	call	L107A0	;@101B8
	call	L10655	;@101BB
	retf	;@101BE
L101BF:	mov	word ptr ds:[3976h], ax	;@101BF
	mov	word ptr ds:[3978h], dx	;@101C2
	mov	bx, 3910h	;@101C6
	call	L10641	;@101C9
	mov	si, 3976h	;@101CC
	mov	cx, 4	;@101CF
	call	L10793	;@101D2
	mov	ax, 282Ah	;@101D5
	stosw	;@101D8
	call	L10655	;@101D9
	retf	;@101DC
L101DD:	mov	bx, 3910h	;@101DD
	call	L10641	;@101E0
	dec	di	;@101E3
	mov	ax, 2029h	;@101E4
	stosw	;@101E7
	call	L10655	;@101E8
	retf	;@101EB
L101EC:	call	L103B4	;@101EC
	retf	;@101EF
L101F0:	test	word ptr ds:[5198h], 400h	;@101F0
	je	@@1	;@101F6
	mov	bx, ax	;@101F8
	call	L107C7	;@101FA
	mov	byte ptr es:[6], 1	;@101FD
	call	L10811	;@10203
@@1:	retf	;@10206
L10207:	test	word ptr ds:[5198h], 400h	;@10207
	je	@@1	;@1020D
	call	L107C7	;@1020F
	call	L10811	;@10212
@@1:	retf	;@10215
L10216:	mov	bx, ax	;@10216
	call	L107C7	;@10218
	mov	byte ptr es:[6], 2	;@1021B
	call	L10811	;@10221
	retf	;@10224
L10225:	mov	bx, 38F2h	;@10225
L10228:	xor	ch, ch	;@10228
	mov	word ptr [bx+6], cx	;@1022A
	retf	;@1022D
L1022E:	mov	bx, 38FCh	;@1022E
	jmp	L10228	;@10231
L10233:	mov	bx, 3906h	;@10233
	jmp	L10228	;@10236
L10238:	mov	bx, 3910h	;@10238
	jmp	L10228	;@1023B
L1023D:	mov	bx, 391Ah	;@1023D
	jmp	L10228	;@10240
L10242:	jcxz	@@1	;@10242
	cmp	cx, 10h	;@10244
	jb	@@2	;@10247
@@1:	mov	cx, 8	;@10249
@@2:	mov	word ptr ds:[399Bh], cx	;@1024C
	retf	;@10250
L10251:	cmp	byte ptr ds:[3997h], 0	;@10251
	je	@@1	;@10256
	push	si	;@10258
	mov	byte ptr ds:[3997h], 0	;@10259
	mov	word ptr ds:[3972h], 0	;@1025E
	inc	word ptr ds:[396Eh]	;@10264
	mov	cx, word ptr ds:[392Ah]	;@10268
	add	cx, 14h	;@1026C
	call	L106CA	;@1026F
	mov	bx, 3924h	;@10272
	call	@@2	;@10275
	mov	si, 450h	;@10278
	call	L102FA	;@1027B
	call	L1036A	;@1027E
	call	L10683	;@10281
	mov	cx, word ptr ds:[3934h]	;@10284
	call	L106CA	;@10288
	mov	bx, 392Eh	;@1028B
	call	@@3	;@1028E
	call	L10683	;@10291
	push	ss	;@10294
	pop	es	;@10295
	mov	di, 51ABh	;@10296
	mov	cx, word ptr ds:[519Ch]	;@10299
	push	cs	;@1029D
	call	L1000C	;@1029E
	mov	cx, word ptr ds:[393Eh]	;@102A1
	call	L106CA	;@102A5
	mov	bx, 3938h	;@102A8
	call	@@3	;@102AB
	call	L10683	;@102AE
	mov	cx, word ptr ds:[3948h]	;@102B1
	call	L106CA	;@102B5
	mov	bx, 3942h	;@102B8
	call	@@3	;@102BB
	call	L10683	;@102BE
	xor	cx, cx	;@102C1
	call	L106CA	;@102C3
	call	L10683	;@102C6
	add	word ptr ds:[3972h], 5	;@102C9
	pop	si	;@102CE
@@1:	ret	;@102CF
@@2:	call	@@3	;@102D0
	mov	cx, dx	;@102D3
	mov	al, 20h	;@102D5
	rep stosb	;@102D7
	ret	;@102D9
@@3:	push	ds	;@102DA
	mov	dx, word ptr [bx+6]	;@102DB
	mov	ax, word ptr [bx]	;@102DE
	mov	ds, ax	;@102E0
	mov	cx, word ptr ds:[2]	;@102E2
	jcxz	@@5	;@102E6
	mov	si, word ptr ds:[4]	;@102E8
	cmp	cx, dx	;@102EC
	jb	@@4	;@102EE
	mov	cx, word ptr ss:[bx+6]	;@102F0
@@4:	sub	dx, cx	;@102F4
	rep movsb	;@102F6
@@5:	pop	ds	;@102F8
	ret	;@102F9
L102FA:	lodsb	;@102FA
	or	al, al	;@102FB
	je	@@1	;@102FD
	stosb	;@102FF
	jmp	L102FA	;@10300
@@1:	ret	;@10302
L10303:	push	bx	;@10303
	mov	dx, di	;@10304
	mov	bx, cx	;@10306
@@1:	lodsb	;@10308
	cmp	al, 9	;@10309
	je	@@2	;@1030B
	cmp	al, 0Ah	;@1030D
	je	@@1	;@1030F
	cmp	al, 1Ah	;@10311
	je	@@1	;@10313
	cmp	al, 0Dh	;@10315
	je	@@4	;@10317
	mov	cx, di	;@10319
	sub	cx, dx	;@1031B
	cmp	cx, bx	;@1031D
	jae	@@4	;@1031F
	stosb	;@10321
	jmp	@@1	;@10322
@@2:	mov	cx, di	;@10324
	sub	cx, dx	;@10326
	mov	ax, word ptr ds:[399Bh]	;@10328
@@3:	sub	cx, ax	;@1032B
	jae	@@3	;@1032D
	add	cx, ax	;@1032F
	neg	cx	;@10331
	add	cx, ax	;@10333
	mov	ax, di	;@10335
	sub	ax, dx	;@10337
	add	ax, cx	;@10339
	cmp	ax, bx	;@1033B
	ja	@@4	;@1033D
	mov	al, 20h	;@1033F
	rep stosb	;@10341
	jmp	@@1	;@10343
@@4:	pop	bx	;@10345
	ret	;@10346
L10347:	push	es	;@10347
	push	di	;@10348
	push	cs	;@10349
	call	L1129C	;@1034A
	pop	di	;@1034D
	pop	es	;@1034E
L1034F:	push	cx	;@1034F
	mov	cl, ch	;@10350
	call	L10777	;@10352
	stosb	;@10355
	pop	cx	;@10356
	call	L10777	;@10357
	stosb	;@1035A
	mov	cl, dh	;@1035B
	jmp	L10777	;@1035D
L10360:	push	es	;@10360
	push	di	;@10361
	push	cs	;@10362
	call	L11293	;@10363
	pop	di	;@10366
	pop	es	;@10367
	jmp	L1034F	;@10368
L1036A:	mov	cx, word ptr ds:[3970h]	;@1036A
	jcxz	@@1	;@1036E
	call	L1073E	;@10370
	mov	al, 2Dh	;@10373
	stosb	;@10375
@@1:	mov	cx, word ptr ds:[396Eh]	;@10376
	jmp	L1073E	;@1037A
L1037D:	cmp	byte ptr ds:[3998h], 0	;@1037D
	jne	@@2	;@10382
	call	L10251	;@10384
	push	si	;@10387
	call	si	;@10388
	pop	si	;@1038A
	inc	word ptr ds:[3972h]	;@1038B
	mov	ax, word ptr ds:[3972h]	;@1038F
	cmp	ax, word ptr ds:[397Ah]	;@10392
	jb	@@1	;@10396
	push	si	;@10398
	call	L10041	;@10399
	pop	si	;@1039C
@@1:	test	word ptr ds:[5198h], 40h	;@1039D
	jne	@@2	;@103A3
	cmp	byte ptr ds:[3999h], 0	;@103A5
	je	@@2	;@103AA
	mov	byte ptr ds:[3999h], 0	;@103AC
	jmp	L1037D	;@103B1
@@2:	ret	;@103B3
L103B4:	mov	ax, word ptr ds:[391Ah]	;@103B4
	mov	word ptr ds:[391Ch], ax	;@103B7
	mov	ax, word ptr ds:[3956h]	;@103BA
	mov	word ptr ds:[3958h], ax	;@103BD
	mov	es, word ptr ds:[3910h]	;@103C0
	mov	ax, 6	;@103C4
	mov	word ptr es:[4], ax	;@103C7
	mov	si, 0A74h	;@103CB
	call	L1037D	;@103CE
	mov	es, word ptr ds:[3956h]	;@103D1
	cmp	word ptr es:[2], 0	;@103D5
	je	@@1	;@103DB
	mov	si, 0A5Dh	;@103DD
	call	L1037D	;@103E0
	mov	bx, 3956h	;@103E3
	call	L10665	;@103E6
@@1:	mov	byte ptr ds:[3998h], 0	;@103E9
	mov	bx, 38F2h	;@103EE
	call	L10665	;@103F1
	mov	bx, 38FCh	;@103F4
	call	L10665	;@103F7
	mov	bx, 3906h	;@103FA
	call	L10665	;@103FD
	mov	bx, 3910h	;@10400
	call	L10665	;@10403
	mov	bx, 391Ah	;@10406
	call	L10665	;@10409
	ret	;@1040C
L1040D:	mov	ax, word ptr ds:[397Ch]	;@1040D
	mov	word ptr ds:[395Ch], ax	;@10410
	mov	cx, ax	;@10413
	add	cx, 3	;@10415
	call	L106CA	;@10418
	mov	bx, 3956h	;@1041B
	call	L1047B	;@1041E
	jmp	L10683	;@10421
L10424:	mov	ax, word ptr ds:[38FCh]	;@10424
	mov	word ptr ds:[38FEh], ax	;@10427
	mov	bx, 38FCh	;@1042A
	call	L10641	;@1042D
	inc	word ptr ds:[3974h]	;@10430
	mov	cx, word ptr ds:[3974h]	;@10434
	call	L1073E	;@10438
	call	L1064A	;@1043B
	call	L10591	;@1043E
	call	L106CA	;@10441
	mov	bx, 38F2h	;@10444
	call	L10510	;@10447
	mov	bx, 38FCh	;@1044A
	call	L10510	;@1044D
	mov	bx, 3906h	;@10450
	call	L10510	;@10453
	mov	bx, 3910h	;@10456
	call	L10468	;@10459
	mov	bx, 391Ah	;@1045C
	call	L1047B	;@1045F
	call	L1057B	;@10462
	jmp	L10683	;@10465
L10468:	call	L1047B	;@10468
	cmp	word ptr [bx+6], 0	;@1046B
	je	@@1	;@1046F
	mov	cx, dx	;@10471
	add	cx, word ptr [bx+4]	;@10473
	mov	al, 20h	;@10476
	rep stosb	;@10478
@@1:	ret	;@1047A
L1047B:	mov	ax, word ptr [bx+2]	;@1047B
	mov	dx, word ptr [bx+6]	;@1047E
	and	ax, ax	;@10481
	je	@@2	;@10483
	mov	ds, ax	;@10485
	and	dx, dx	;@10487
	je	@@2	;@10489
	mov	si, word ptr ds:[4]	;@1048B
	mov	cx, word ptr ds:[2]	;@1048F
	cmp	cx, dx	;@10493
	ja	@@3	;@10495
	sub	dx, cx	;@10497
	rep movsb	;@10499
@@1:	call	L10560	;@1049B
@@2:	push	ss	;@1049E
	pop	ds	;@1049F
	ret	;@104A0
@@3:	mov	cx, dx	;@104A1
	add	si, dx	;@104A3
	dec	si	;@104A5
	mov	al, byte ptr [si]	;@104A6
	jmp	short @@5	;@104A8
@@4:	dec	si	;@104AA
	mov	al, byte ptr [si]	;@104AB
	cmp	al, 2Ch	;@104AD
	je	@@10	;@104AF
@@5:	cmp	al, 20h	;@104B1
	je	@@6	;@104B3
	cmp	al, 28h	;@104B5
	je	@@6	;@104B7
	cmp	al, 5Bh	;@104B9
	je	@@6	;@104BB
	cmp	al, 2Bh	;@104BD
	loopne	@@4	;@104BF
	jcxz	@@11	;@104C1
@@6:	mov	cx, si	;@104C3
	mov	si, word ptr ds:[4]	;@104C5
	sub	cx, si	;@104C9
	je	@@11	;@104CB
	sub	dx, cx	;@104CD
	mov	ax, cx	;@104CF
	rep movsb	;@104D1
	mov	cx, word ptr ds:[2]	;@104D3
	sub	cx, ax	;@104D7
@@7:	cmp	byte ptr [si], 20h	;@104D9
	jne	@@8	;@104DC
	inc	si	;@104DE
	loop	@@7	;@104DF
@@8:	sub	si, word ptr ds:[4]	;@104E1
	add	word ptr ds:[4], si	;@104E5
	sub	word ptr ds:[2], si	;@104E9
	je	@@1	;@104ED
	mov	cx, dx	;@104EF
	jcxz	@@9	;@104F1
	dec	cx	;@104F3
	mov	al, 20h	;@104F4
	rep stosb	;@104F6
	mov	al, 2Bh	;@104F8
	stosb	;@104FA
	xor	dx, dx	;@104FB
@@9:	push	ss	;@104FD
	pop	ds	;@104FE
	mov	byte ptr ds:[3999h], 1	;@104FF
	ret	;@10504
@@10:	inc	si	;@10505
	jmp	@@6	;@10506
@@11:	mov	cx, dx	;@10508
	rep movsb	;@1050A
	xor	dx, dx	;@1050C
	jmp	@@8	;@1050E
L10510:	call	@@2	;@10510
	cmp	word ptr [bx+6], 0	;@10513
	je	@@1	;@10517
	mov	cx, dx	;@10519
	add	cx, word ptr [bx+4]	;@1051B
	mov	al, 20h	;@1051E
	rep stosb	;@10520
@@1:	ret	;@10522
@@2:	mov	ax, word ptr [bx+2]	;@10523
	mov	dx, word ptr [bx+6]	;@10526
	and	ax, ax	;@10529
	je	@@4	;@1052B
	mov	ds, ax	;@1052D
	and	dx, dx	;@1052F
	je	@@4	;@10531
	mov	si, word ptr ds:[4]	;@10533
	mov	cx, word ptr ds:[2]	;@10537
	cmp	cx, dx	;@1053B
	ja	@@5	;@1053D
	sub	dx, cx	;@1053F
	xchg	dx, cx	;@10541
	mov	al, 20h	;@10543
	rep stosb	;@10545
	mov	cx, dx	;@10547
	rep movsb	;@10549
@@3:	xor	dx, dx	;@1054B
	call	L10560	;@1054D
@@4:	push	ss	;@10550
	pop	ds	;@10551
	ret	;@10552
@@5:	sub	cx, dx	;@10553
	add	si, cx	;@10555
	mov	byte ptr [si], 2Ah	;@10557
	mov	cx, dx	;@1055A
	rep movsb	;@1055C
	jmp	@@3	;@1055E
L10560:	mov	ax, word ptr ds:[0]	;@10560
	and	ax, ax	;@10563
	je	@@1	;@10565
	mov	ds, ax	;@10567
	cmp	word ptr ds:[2], 0	;@10569
	je	L10560	;@1056E
	mov	byte ptr ss:[3999h], 1	;@10570
@@1:	mov	word ptr ss:[bx+2], ax	;@10576
	ret	;@1057A
L1057B:	mov	cx, di	;@1057B
	jcxz	@@1	;@1057D
	dec	di	;@1057F
	std	;@10580
	mov	al, 20h	;@10581
	repe scasb	;@10583
	cld	;@10585
	inc	di	;@10586
	inc	di	;@10587
@@1:	ret	;@10588
L10589:	call	L10591	;@10589
	add	cx, word ptr ds:[3952h]	;@1058C
	ret	;@10590
L10591:	call	L1059C	;@10591
	add	cx, word ptr ds:[3920h]	;@10594
	add	cx, 3	;@10598
	ret	;@1059B
L1059C:	mov	cx, word ptr ds:[38F8h]	;@1059C
	add	cx, word ptr ds:[3902h]	;@105A0
	add	cx, word ptr ds:[390Ch]	;@105A4
	add	cx, word ptr ds:[3916h]	;@105A8
	add	cx, word ptr ds:[38F6h]	;@105AC
	add	cx, word ptr ds:[3900h]	;@105B0
	add	cx, word ptr ds:[390Ah]	;@105B4
	add	cx, word ptr ds:[3914h]	;@105B8
	add	cx, word ptr ds:[391Eh]	;@105BC
	ret	;@105C0
L105C1:	call	L1059C	;@105C1
	mov	ax, word ptr ds:[397Ch]	;@105C4
	cmp	ax, 3Ch	;@105C7
	jae	@@1	;@105CA
	mov	ax, 4Fh	;@105CC
@@1:	mov	word ptr ds:[393Eh], ax	;@105CF
	mov	word ptr ds:[3948h], ax	;@105D2
	sub	ax, cx	;@105D5
	cmp	ax, 17h	;@105D7
	ja	@@2	;@105DA
	mov	ax, 17h	;@105DC
@@2:	mov	word ptr ds:[3920h], ax	;@105DF
	ret	;@105E2
L105E3:	test	word ptr ds:[5198h], 800h	;@105E3
	je	@@1	;@105E9
	mov	si, 3C8h	;@105EB
	jmp	short @@2	;@105EE
@@1:	mov	si, 3DAh	;@105F0
@@2:	xor	di, di	;@105F3
@@3:	cmp	word ptr [si+2], -1	;@105F5
	je	@@6	;@105F9
	mov	bx, 64h	;@105FB
	mov	ax, word ptr ds:[397Ch]	;@105FE
	mul	bx	;@10601
	div	word ptr [si+2]	;@10603
	xor	bx, bx	;@10606
	mov	bl, byte ptr [si+4]	;@10608
	cmp	ax, bx	;@1060B
	ja	@@4	;@1060D
	mov	bl, byte ptr [si+5]	;@1060F
	cmp	ax, bx	;@10612
	ja	@@5	;@10614
@@4:	mov	ax, bx	;@10616
@@5:	mov	bx, word ptr [si]	;@10618
	mov	word ptr [bx+6], ax	;@1061A
	add	di, ax	;@1061D
	add	si, 6	;@1061F
	jmp	@@3	;@10622
@@6:	mov	cl, byte ptr [si+4]	;@10624
	xor	ch, ch	;@10627
	add	di, cx	;@10629
	mov	ax, word ptr ds:[397Ch]	;@1062B
	sub	ax, di	;@1062E
	jb	@@7	;@10630
	mov	cl, byte ptr [si+5]	;@10632
	cmp	ax, cx	;@10635
	ja	@@8	;@10637
@@7:	mov	ax, cx	;@10639
@@8:	mov	bx, word ptr [si]	;@1063B
	mov	word ptr [bx+6], ax	;@1063D
	ret	;@10640
L10641:	mov	es, word ptr [bx+2]	;@10641
	mov	di, word ptr es:[4]	;@10644
	ret	;@10649
L1064A:	sub	di, word ptr es:[4]	;@1064A
	mov	word ptr es:[2], di	;@1064F
	ret	;@10654
L10655:	sub	di, word ptr es:[4]	;@10655
	add	word ptr es:[2], di	;@1065A
	add	word ptr es:[4], di	;@1065F
	ret	;@10664
L10665:	mov	ax, word ptr [bx]	;@10665
	mov	word ptr [bx+2], ax	;@10667
@@1:	mov	es, ax	;@1066A
	mov	word ptr es:[2], 0	;@1066C
	mov	ax, 6	;@10673
	mov	word ptr es:[4], ax	;@10676
	mov	ax, word ptr es:[0]	;@1067A
	and	ax, ax	;@1067E
	jne	@@1	;@10680
	ret	;@10682
L10683:	push	si	;@10683
	mov	si, word ptr ds:[3966h]	;@10684
	push	es	;@10688
	pop	ds	;@10689
	mov	cx, di	;@1068A
	mov	di, si	;@1068C
	sub	cx, si	;@1068E
	xor	dx, dx	;@10690
	xor	bx, bx	;@10692
	jcxz	@@4	;@10694
@@1:	test	bl, 7	;@10696
	jne	@@2	;@10699
	and	dx, dx	;@1069B
	je	@@2	;@1069D
	mov	al, 9	;@1069F
	stosb	;@106A1
	xor	dx, dx	;@106A2
@@2:	inc	bx	;@106A4
	lodsb	;@106A5
	cmp	al, 20h	;@106A6
	je	@@3	;@106A8
	push	cx	;@106AA
	push	ax	;@106AB
	mov	cx, dx	;@106AC
	mov	al, 20h	;@106AE
	rep stosb	;@106B0
	pop	ax	;@106B2
	pop	cx	;@106B3
	xor	dx, dx	;@106B4
	stosb	;@106B6
	loop	@@1	;@106B7
	jmp	short @@4	;@106B9
@@3:	inc	dx	;@106BB
	loop	@@1	;@106BC
@@4:	pop	si	;@106BE
	push	ss	;@106BF
	pop	ds	;@106C0
	mov	ax, 0A0Dh	;@106C1
	stosw	;@106C4
L106C5:	mov	word ptr ds:[3960h], di	;@106C5
	ret	;@106C9
L106CA:	add	cx, 2	;@106CA
	call	L106D5	;@106CD
	mov	word ptr ds:[3966h], di	;@106D0
	ret	;@106D4
L106D5:	les	di, dword ptr ds:[3960h]	;@106D5
	add	cx, di	;@106D9
	cmp	cx, word ptr ds:[3964h]	;@106DB
	ja	@@1	;@106DF
	ret	;@106E1
@@1:	mov	ax, word ptr ds:[3960h]	;@106E2
	and	ax, 0F000h	;@106E5
	je	L1071D	;@106E8
	mov	cx, ax	;@106EA
	mov	ax, word ptr ds:[3962h]	;@106EC
	xor	dx, dx	;@106EF
	mov	bx, word ptr ds:[396Ch]	;@106F1
	push	cx	;@106F5
	push	cs	;@106F6
	call	L112F6	;@106F7
	pop	si	;@106FA
	jb	@@2	;@106FB
	xor	di, di	;@106FD
	mov	cx, word ptr ds:[3960h]	;@106FF
	sub	cx, si	;@10703
	mov	ds, word ptr ds:[3962h]	;@10705
	push	ds	;@10709
	pop	es	;@1070A
	shr	cx, 1	;@1070B
	rep movsw	;@1070D
	rcl	cx, 1	;@1070F
	rep movsb	;@10711
	push	ss	;@10713
	pop	ds	;@10714
	mov	word ptr ds:[3960h], di	;@10715
	ret	;@10719
@@2:	jmp	L0FFC6	;@1071A
L1071D:	mov	cx, word ptr ds:[3960h]	;@1071D
	mov	ax, word ptr ds:[3962h]	;@10721
	xor	dx, dx	;@10724
	mov	bx, word ptr ds:[396Ch]	;@10726
	push	cs	;@1072A
	call	L112F6	;@1072B
	jb	@@1	;@1072E
	mov	es, word ptr ds:[3962h]	;@10730
	xor	di, di	;@10734
	mov	word ptr ds:[3960h], di	;@10736
	ret	;@1073A
@@1:	jmp	L0FFC6	;@1073B
L1073E:	push	ax	;@1073E
	push	si	;@1073F
	mov	ah, 30h	;@10740
	mov	si, 2710h	;@10742
	call	L10765	;@10745
	mov	si, 3E8h	;@10748
	call	L10765	;@1074B
	mov	si, 64h	;@1074E
	call	L10765	;@10751
	mov	si, 0Ah	;@10754
	call	L10765	;@10757
	mov	si, 1	;@1075A
	mov	ah, 0FFh	;@1075D
	call	L10765	;@1075F
	pop	si	;@10762
	pop	ax	;@10763
	ret	;@10764
L10765:	mov	al, 2Fh	;@10765
@@1:	inc	al	;@10767
	sub	cx, si	;@10769
	jae	@@1	;@1076B
	add	cx, si	;@1076D
	cmp	al, ah	;@1076F
	je	@@2	;@10771
	mov	ah, 0FFh	;@10773
	stosb	;@10775
@@2:	ret	;@10776
L10777:	push	ax	;@10777
	push	si	;@10778
	mov	ah, 30h	;@10779
	cmp	cl, 63h	;@1077B
	ja	@@1	;@1077E
	mov	ch, 0	;@10780
	mov	ah, 0FFh	;@10782
	mov	si, 0Ah	;@10784
	call	L10765	;@10787
	mov	si, 1	;@1078A
	call	L10765	;@1078D
@@1:	pop	si	;@10790
	pop	ax	;@10791
	ret	;@10792
L10793:	add	si, cx	;@10793
	dec	si	;@10795
	std	;@10796
@@1:	lodsb	;@10797
	or	al, al	;@10798
	loope	@@1	;@1079A
	inc	cx	;@1079C
	inc	si	;@1079D
	jmp	short L107A4	;@1079E
L107A0:	add	si, cx	;@107A0
	dec	si	;@107A2
L107A3:	std	;@107A3
L107A4:	lodsb	;@107A4
	cld	;@107A5
	push	ax	;@107A6
	shr	al, 1	;@107A7
	shr	al, 1	;@107A9
	shr	al, 1	;@107AB
	shr	al, 1	;@107AD
	call	@@1	;@107AF
	pop	ax	;@107B2
	call	@@1	;@107B3
	loop	L107A3	;@107B6
	ret	;@107B8
@@1:	and	al, 0Fh	;@107B9
	cmp	al, 0Ah	;@107BB
	jae	@@2	;@107BD
	add	al, 30h	;@107BF
	stosb	;@107C1
	ret	;@107C2
@@2:	add	al, 37h	;@107C3
	stosb	;@107C5
	ret	;@107C6
L107C7:	cmp	word ptr ds:[38EAh], 0	;@107C7
	jne	@@1	;@107CC
	mov	ax, 1	;@107CE
	mov	cx, 100h	;@107D1
	push	cs	;@107D4
	call	L0FB18	;@107D5
	mov	word ptr ds:[38E8h], ax	;@107D8
	mov	word ptr ds:[38EAh], cx	;@107DB
@@1:	mov	es, word ptr ds:[38E8h]	;@107DF
	mov	ax, 1	;@107E3
	add	word ptr ds:[38E8h], ax	;@107E6
	sub	word ptr ds:[38EAh], ax	;@107EA
	xor	ax, ax	;@107EE
	mov	di, ax	;@107F0
	stosw	;@107F2
	stosw	;@107F3
	stosw	;@107F4
	stosw	;@107F5
	mov	word ptr es:[8], bx	;@107F6
	mov	ax, word ptr ds:[3974h]	;@107FB
	mov	word ptr es:[0Eh], ax	;@107FE
	mov	ax, word ptr ds:[515Eh]	;@10802
	mov	word ptr es:[0Ah], ax	;@10805
	mov	ax, word ptr ds:[5152h]	;@10809
	mov	word ptr es:[0Ch], ax	;@1080C
	ret	;@10810
L10811:	mov	bx, es	;@10811
	mov	cx, word ptr ds:[3994h]	;@10813
	jcxz	@@9	;@10817
@@1:	mov	dx, word ptr es:[8]	;@10819
	mov	si, word ptr es:[6]	;@1081E
	push	es	;@10823
	mov	es, cx	;@10824
	mov	ax, word ptr es:[8]	;@10826
	cmp	ax, dx	;@1082A
	je	@@5	;@1082C
	push	es	;@1082E
	push	bx	;@1082F
	call	L10890	;@10830
	pop	bx	;@10833
	pop	es	;@10834
	ja	@@3	;@10835
	mov	cx, word ptr es:[0]	;@10837
	jcxz	@@2	;@1083C
	pop	es	;@1083E
	jmp	@@1	;@1083F
@@2:	pop	ax	;@10841
	mov	word ptr es:[0], bx	;@10842
	ret	;@10847
@@3:	mov	cx, word ptr es:[2]	;@10848
	jcxz	@@4	;@1084D
	pop	es	;@1084F
	jmp	@@1	;@10850
@@4:	pop	ax	;@10852
	mov	word ptr es:[2], bx	;@10853
	ret	;@10858
@@5:	pop	ax	;@10859
	test	byte ptr es:[6], 2	;@1085A
	jne	@@8	;@10860
	and	si, 2	;@10862
	or	word ptr es:[6], si	;@10865
@@6:	mov	cx, word ptr es:[4]	;@1086A
	jcxz	@@7	;@1086F
	mov	es, cx	;@10871
	jmp	@@6	;@10873
@@7:	mov	word ptr es:[4], bx	;@10875
	ret	;@1087A
@@8:	test	si, 1	;@1087B
	jne	@@6	;@1087F
	mov	ax, bx	;@10881
	mov	dx, 1	;@10883
	push	cs	;@10886
	call	L0FAA6	;@10887
	ret	;@1088A
@@9:	mov	word ptr ds:[3994h], bx	;@1088B
	ret	;@1088F
L10890:	mov	es, ax	;@10890
	call	far ptr L0003E	;@10892
	push	es	;@10897
	mov	si, di	;@10898
	mov	bx, cx	;@1089A
	mov	es, dx	;@1089C
	call	far ptr L0003E	;@1089E
	pop	ds	;@108A3
	cmp	cx, bx	;@108A4
	mov	bh, cl	;@108A6
	jb	@@1	;@108A8
	mov	cl, bl	;@108AA
@@1:	repe cmpsb	;@108AC
	je	@@2	;@108AE
	push	ss	;@108B0
	pop	ds	;@108B1
	ret	;@108B2
@@2:	cmp	bl, bh	;@108B3
	push	ss	;@108B5
	pop	ds	;@108B6
	ret	;@108B7
L108B8:	mov	si, 8Eh	;@108B8
	call	far ptr L00076	;@108BB
	ret	;@108C0
L108C1:	cmp	ax, word ptr ds:[5862h]	;@108C1
	je	@@2	;@108C5
	mov	bx, ax	;@108C7
	call	far ptr L00046	;@108C9
	and	al, 3Fh	;@108CE
	je	@@2	;@108D0
	test	al, 20h	;@108D2
	jne	@@1	;@108D4
	cmp	al, 0Bh	;@108D6
	je	@@2	;@108D8
	cmp	al, 7	;@108DA
	je	@@2	;@108DC
@@1:	call	L107C7	;@108DE
	mov	byte ptr es:[6], 4	;@108E1
	call	@@3	;@108E7
@@2:	retf	;@108EA
@@3:	mov	bx, es	;@108EB
	mov	cx, word ptr ds:[3994h]	;@108ED
	jcxz	@@9	;@108F1
@@4:	mov	dx, word ptr es:[8]	;@108F3
	push	es	;@108F8
	mov	es, cx	;@108F9
	mov	ax, word ptr es:[8]	;@108FB
	cmp	ax, dx	;@108FF
	je	@@8	;@10901
	push	es	;@10903
	push	bx	;@10904
	call	L10890	;@10905
	pop	bx	;@10908
	pop	es	;@10909
	ja	@@6	;@1090A
	mov	cx, word ptr es:[0]	;@1090C
	jcxz	@@5	;@10911
	pop	es	;@10913
	jmp	@@4	;@10914
@@5:	pop	ax	;@10916
	mov	word ptr es:[0], bx	;@10917
	ret	;@1091C
@@6:	mov	cx, word ptr es:[2]	;@1091D
	jcxz	@@7	;@10922
	pop	es	;@10924
	jmp	@@4	;@10925
@@7:	pop	ax	;@10927
	mov	word ptr es:[2], bx	;@10928
	ret	;@1092D
@@8:	pop	ax	;@1092E
	mov	ax, bx	;@1092F
	mov	dx, 1	;@10931
	push	cs	;@10934
	call	L0FAA6	;@10935
	ret	;@10938
@@9:	mov	word ptr ds:[3994h], bx	;@10939
	ret	;@1093D
L1093E:	call	L108B8	;@1093E
	call	L10E52	;@10941
	call	L10EFB	;@10944
	call	@@11	;@10947
	jcxz	@@2	;@1094A
	mov	word ptr ds:[3992h], cx	;@1094C
	mov	word ptr ds:[3990h], cx	;@10950
	call	L10BDA	;@10954
@@1:	call	@@11	;@10957
	jcxz	@@2	;@1095A
	mov	es, word ptr ds:[3990h]	;@1095C
	mov	word ptr es:[0], cx	;@10960
	mov	word ptr ds:[3990h], cx	;@10965
	call	L10BDA	;@10969
	jmp	@@1	;@1096C
@@2:	mov	word ptr ds:[38F0h], 3E6h	;@1096E
@@3:	cmp	word ptr ds:[38F0h], 3FEh	;@10974
	je	@@6	;@1097A
	mov	cx, word ptr ds:[3992h]	;@1097C
	mov	byte ptr ds:[399Ah], 1	;@10980
@@4:	jcxz	@@10	;@10985
	mov	es, cx	;@10987
	push	es	;@10989
	mov	word ptr ds:[398Ch], cx	;@1098A
	mov	word ptr ds:[3990h], cx	;@1098E
	mov	ax, word ptr es:[8]	;@10992
	mov	word ptr ds:[3982h], ax	;@10996
	call	far ptr L00046	;@10999
	mov	word ptr ds:[3986h], di	;@1099E
	mov	byte ptr ds:[3996h], al	;@109A2
	test	al, 20h	;@109A5
	jne	@@5	;@109A7
	mov	bx, word ptr ds:[38F0h]	;@109A9
	mov	ah, byte ptr [bx]	;@109AD
	and	al, 1Fh	;@109AF
	cmp	al, ah	;@109B1
	je	@@8	;@109B3
	cmp	ah, 6	;@109B5
	je	@@7	;@109B8
@@5:	pop	es	;@109BA
	mov	cx, word ptr es:[0]	;@109BB
	jmp	@@4	;@109C0
@@6:	ret	;@109C2
@@7:	cmp	al, 5	;@109C3
	jne	@@5	;@109C5
@@8:	cmp	byte ptr ds:[399Ah], 0	;@109C7
	je	@@9	;@109CC
	mov	byte ptr ds:[399Ah], 0	;@109CE
	mov	bx, word ptr ds:[38F0h]	;@109D3
	call	word ptr [bx+2]	;@109D7
	call	L10EFB	;@109DA
@@9:	mov	bx, word ptr ds:[38F0h]	;@109DD
	call	word ptr [bx+4]	;@109E1
	jmp	@@5	;@109E4
@@10:	add	word ptr ds:[38F0h], 6	;@109E6
	jmp	@@3	;@109EB
@@11:	mov	ax, word ptr ds:[398Eh]	;@109ED
	or	ax, ax	;@109F0
	je	@@15	;@109F2
	mov	es, ax	;@109F4
	mov	cx, word ptr es:[2]	;@109F6
	jcxz	@@15	;@109FB
@@12:	mov	dx, es	;@109FD
	mov	es, cx	;@109FF
	mov	cx, word ptr es:[2]	;@10A01
	jcxz	@@13	;@10A06
	jmp	@@12	;@10A08
@@13:	mov	bx, word ptr es:[0]	;@10A0A
	mov	cx, es	;@10A0F
	mov	es, dx	;@10A11
	mov	word ptr es:[2], bx	;@10A13
	mov	word ptr ds:[398Eh], es	;@10A18
@@14:	mov	word ptr ds:[398Ch], cx	;@10A1C
	ret	;@10A20
@@15:	mov	cx, word ptr ds:[3994h]	;@10A21
	jcxz	@@14	;@10A25
	mov	ax, cx	;@10A27
	mov	es, ax	;@10A29
	mov	cx, word ptr es:[2]	;@10A2B
	or	cx, cx	;@10A30
	jne	@@12	;@10A32
	mov	cx, ax	;@10A34
	mov	ax, word ptr es:[0]	;@10A36
	mov	word ptr ds:[3994h], ax	;@10A3A
	mov	word ptr ds:[398Eh], ax	;@10A3D
	jmp	@@14	;@10A40
L10A42:	jmp	L10C5C	;@10A42
L10A45:	mov	al, byte ptr ds:[3996h]	;@10A45
	and	al, 1Fh	;@10A48
	cmp	al, 6	;@10A4A
	je	@@1	;@10A4C
	mov	es, word ptr ds:[3982h]	;@10A4E
	call	far ptr L00066	;@10A52
	or	bx, bx	;@10A57
	jne	@@2	;@10A59
	mov	es, word ptr ds:[3982h]	;@10A5B
	call	@@9	;@10A5F
	jmp	L10C5C	;@10A62
@@1:	mov	ax, word ptr ds:[3982h]	;@10A65
	mov	word ptr ds:[3984h], ax	;@10A68
	mov	bx, 3910h	;@10A6B
	mov	si, 4C0h	;@10A6E
	call	L10E49	;@10A71
	call	L10C5C	;@10A74
	call	@@3	;@10A77
@@2:	ret	;@10A7A
@@3:	mov	cx, word ptr ds:[3992h]	;@10A7B
@@4:	jcxz	@@8	;@10A7F
	mov	es, cx	;@10A81
	mov	word ptr ds:[398Ch], cx	;@10A83
	mov	ax, word ptr es:[8]	;@10A87
	mov	word ptr ds:[3982h], ax	;@10A8B
	push	es	;@10A8E
	call	far ptr L00046	;@10A8F
	pop	es	;@10A94
	test	al, 20h	;@10A95
	jne	@@5	;@10A97
	and	al, 1Fh	;@10A99
	cmp	al, 5	;@10A9B
	je	@@6	;@10A9D
@@5:	mov	cx, word ptr es:[0]	;@10A9F
	jmp	@@4	;@10AA4
@@6:	push	es	;@10AA6
	mov	es, word ptr ds:[3982h]	;@10AA7
	call	far ptr L00066	;@10AAB
	cmp	bx, word ptr ds:[3984h]	;@10AB0
	jne	@@7	;@10AB4
	mov	es, word ptr ds:[3982h]	;@10AB6
	mov	ax, 2	;@10ABA
	push	es	;@10ABD
	call	L10CEB	;@10ABE
	pop	es	;@10AC1
	call	@@9	;@10AC2
	call	L10C63	;@10AC5
@@7:	pop	es	;@10AC8
	jmp	@@5	;@10AC9
@@8:	ret	;@10ACB
@@9:	call	far ptr L0006A	;@10ACC
	mov	word ptr ds:[3976h], ax	;@10AD1
	mov	word ptr ds:[3978h], dx	;@10AD4
	call	far ptr L00066	;@10AD8
	mov	word ptr ds:[398Ah], cx	;@10ADD
	push	di	;@10AE1
	push	ax	;@10AE2
	mov	bx, 3910h	;@10AE3
	call	L10641	;@10AE6
	test	word ptr ds:[398Ah], 2	;@10AE9
	je	@@10	;@10AEF
	mov	si, 471h	;@10AF1
	call	L102FA	;@10AF4
	call	L10CB1	;@10AF7
	mov	si, 48Bh	;@10AFA
	call	L102FA	;@10AFD
	pop	cx	;@10B00
	pop	ax	;@10B01
	jcxz	@@13	;@10B02
	call	L10D45	;@10B04
	jmp	short @@13	;@10B07
@@10:	test	word ptr ds:[398Ah], 1	;@10B09
	mov	si, 467h	;@10B0F
	je	@@11	;@10B12
	mov	si, 46Ch	;@10B14
@@11:	call	L102FA	;@10B17
	call	L10CB1	;@10B1A
	mov	cl, 4	;@10B1D
	mov	si, word ptr ds:[398Ah]	;@10B1F
	and	si, 0E0h	;@10B23
	push	si	;@10B27
	shr	si, cl	;@10B28
	add	si, 3FEh	;@10B2A
	mov	si, word ptr [si]	;@10B2E
	call	L102FA	;@10B30
	pop	cx	;@10B33
	pop	ax	;@10B34
	jcxz	@@12	;@10B35
	mov	si, word ptr ds:[398Ah]	;@10B37
	and	si, 1Ch	;@10B3B
	shr	si, 1	;@10B3E
	add	si, 40Ah	;@10B40
	mov	si, word ptr [si]	;@10B44
	call	L102FA	;@10B46
	pop	cx	;@10B49
	jcxz	@@13	;@10B4A
	call	L10D45	;@10B4C
	jmp	short @@13	;@10B4F
@@12:	pop	si	;@10B51
	mov	word ptr ds:[3976h], ax	;@10B52
	mov	word ptr ds:[3978h], cx	;@10B55
	call	L10CB1	;@10B59
@@13:	jmp	L1064A	;@10B5C
L10B5F:	call	L10C5C	;@10B5F
	mov	es, word ptr ds:[3982h]	;@10B62
	mov	si, 82h	;@10B66
	call	far ptr L0006E	;@10B69
	ret	;@10B6E
L10B6F:	mov	word ptr ds:[3976h], ax	;@10B6F
	mov	word ptr ds:[3978h], dx	;@10B72
	mov	byte ptr ds:[3996h], bl	;@10B76
	mov	word ptr ds:[3986h], cx	;@10B7A
	mov	ax, 1	;@10B7E
	call	L10CEB	;@10B81
	mov	bx, 3910h	;@10B84
	call	L10641	;@10B87
	call	L10CC7	;@10B8A
	call	L10CB1	;@10B8D
	call	L10CD9	;@10B90
	call	L10655	;@10B93
	call	L10EB5	;@10B96
	retf	;@10B99
L10B9A:	call	L10C5C	;@10B9A
	mov	es, word ptr ds:[3982h]	;@10B9D
	mov	si, 88h	;@10BA1
	call	far ptr L00072	;@10BA4
	ret	;@10BA9
L10BAA:	mov	word ptr ds:[3976h], cx	;@10BAA
	mov	ax, 1	;@10BAE
	call	L10CEB	;@10BB1
	mov	bx, 3910h	;@10BB4
	call	L10641	;@10BB7
	mov	si, 3976h	;@10BBA
	mov	cx, 1	;@10BBD
	call	L107A0	;@10BC0
	mov	al, 20h	;@10BC3
	mov	cx, 4	;@10BC5
	rep stosb	;@10BC8
	mov	cx, 1	;@10BCA
	mov	si, 3977h	;@10BCD
	call	L107A0	;@10BD0
	call	L10655	;@10BD3
	call	L10EB5	;@10BD6
	retf	;@10BD9
L10BDA:	mov	es, cx	;@10BDA
	mov	ax, word ptr ds:[5198h]	;@10BDC
	cmp	word ptr es:[4], 0	;@10BDF
	je	@@1	;@10BE5
	test	ax, 100h	;@10BE7
	je	@@2	;@10BEA
	ret	;@10BEC
@@1:	test	ax, 200h	;@10BED
	jne	@@3	;@10BF0
@@2:	mov	ax, word ptr es:[8]	;@10BF2
	mov	word ptr ds:[3982h], ax	;@10BF6
	call	far ptr L00046	;@10BF9
	mov	byte ptr ds:[3996h], al	;@10BFE
	test	al, 20h	;@10C01
	jne	@@4	;@10C03
	and	al, 1Fh	;@10C05
	mov	ah, 0	;@10C07
	mov	si, 418h	;@10C09
	add	si, ax	;@10C0C
	add	si, ax	;@10C0E
	mov	bx, 3910h	;@10C10
	call	L10641	;@10C13
	cmp	word ptr [si], 0	;@10C16
	je	@@3	;@10C19
	call	word ptr [si]	;@10C1B
	jmp	short L10C5C	;@10C1D
@@3:	ret	;@10C1F
@@4:	mov	word ptr ds:[3986h], di	;@10C20
	mov	es, word ptr ds:[3982h]	;@10C24
	call	far ptr L0004A	;@10C28
	mov	word ptr ds:[3976h], ax	;@10C2D
	mov	word ptr ds:[3978h], dx	;@10C30
	mov	word ptr ds:[3988h], di	;@10C34
	mov	bx, 3910h	;@10C38
	call	L10641	;@10C3B
	call	L10CC7	;@10C3E
	call	L10D5B	;@10C41
	test	byte ptr ds:[3996h], 10h	;@10C44
	je	@@5	;@10C49
	mov	si, 582h	;@10C4B
	call	L102FA	;@10C4E
	jmp	short @@6	;@10C51
@@5:	call	L10CB1	;@10C53
@@6:	call	L10CD9	;@10C56
	call	L10655	;@10C59
L10C5C:	mov	es, word ptr ds:[3982h]	;@10C5C
	call	L10CE9	;@10C60
L10C63:	test	word ptr ds:[5198h], 800h	;@10C63
	je	@@4	;@10C69
	mov	bx, 394Ch	;@10C6B
	call	L10641	;@10C6E
@@1:	mov	ax, word ptr ds:[398Ch]	;@10C71
	or	ax, ax	;@10C74
	je	@@3	;@10C76
	mov	cx, di	;@10C78
	sub	cx, -2	;@10C7A
	cmp	cx, word ptr [bx+8]	;@10C7D
	ja	@@3	;@10C80
	push	es	;@10C82
	mov	es, ax	;@10C83
	mov	cx, word ptr es:[0Eh]	;@10C85
	mov	ax, word ptr es:[4]	;@10C8A
	mov	word ptr ds:[398Ch], ax	;@10C8E
	mov	al, byte ptr es:[6]	;@10C91
	pop	es	;@10C95
	test	al, 4	;@10C96
	jne	@@3	;@10C98
	test	al, 1	;@10C9A
	je	@@2	;@10C9C
	mov	al, 23h	;@10C9E
	stosb	;@10CA0
@@2:	inc	cx	;@10CA1
	call	L1073E	;@10CA2
	mov	ax, 2020h	;@10CA5
	stosw	;@10CA8
	jmp	@@1	;@10CA9
@@3:	call	L1064A	;@10CAB
@@4:	jmp	L10EB5	;@10CAE
L10CB1:	mov	si, 3976h	;@10CB1
	mov	cx, 2	;@10CB4
	cmp	word ptr ds:[3978h], 0	;@10CB7
	je	@@1	;@10CBC
	add	cx, cx	;@10CBE
@@1:	call	L107A0	;@10CC0
	mov	al, 20h	;@10CC3
	stosb	;@10CC5
	ret	;@10CC6
L10CC7:	mov	al, byte ptr ds:[3996h]	;@10CC7
	and	ax, 0Fh	;@10CCA
	mov	si, 43Ah	;@10CCD
	add	si, ax	;@10CD0
	add	si, ax	;@10CD2
	mov	si, word ptr [si]	;@10CD4
	jmp	L102FA	;@10CD6
L10CD9:	mov	al, byte ptr ds:[3996h]	;@10CD9
	and	al, 0Fh	;@10CDC
	cmp	al, 0Ah	;@10CDE
	je	@@1	;@10CE0
	ret	;@10CE2
@@1:	mov	cx, word ptr ds:[3986h]	;@10CE3
	jmp	short L10D45	;@10CE7
L10CE9:	xor	ax, ax	;@10CE9
L10CEB:	push	es	;@10CEB
	push	ax	;@10CEC
	mov	bx, 391Ah	;@10CED
	call	L10641	;@10CF0
	pop	cx	;@10CF3
	mov	al, 20h	;@10CF4
	rep stosb	;@10CF6
	mov	ax, es	;@10CF8
	pop	es	;@10CFA
	push	es	;@10CFB
	push	ax	;@10CFC
	push	di	;@10CFD
	call	far ptr L0003E	;@10CFE
	mov	si, di	;@10D03
	push	es	;@10D05
	pop	ds	;@10D06
	pop	di	;@10D07
	pop	es	;@10D08
	mov	bx, si	;@10D09
	mov	dx, ds	;@10D0B
	rep movsb	;@10D0D
	push	ss	;@10D0F
	pop	ds	;@10D10
	pop	ax	;@10D11
	push	di	;@10D12
	push	es	;@10D13
	mov	es, ax	;@10D14
	push	bx	;@10D16
	push	dx	;@10D17
	call	far ptr L00042	;@10D18
	pop	dx	;@10D1D
	pop	bx	;@10D1E
	mov	ax, es	;@10D1F
	cmp	ax, dx	;@10D21
	jne	@@1	;@10D23
	cmp	di, bx	;@10D25
	jne	@@1	;@10D27
	pop	es	;@10D29
	pop	di	;@10D2A
	jmp	short @@2	;@10D2B
@@1:	mov	si, di	;@10D2D
	mov	ds, ax	;@10D2F
	pop	es	;@10D31
	pop	di	;@10D32
	mov	ax, 2820h	;@10D33
	stosw	;@10D36
	rep movsb	;@10D37
	mov	al, 29h	;@10D39
	stosb	;@10D3B
	push	ss	;@10D3C
	pop	ds	;@10D3D
@@2:	mov	es, word ptr ds:[391Ch]	;@10D3E
	jmp	L1064A	;@10D42
L10D45:	push	bx	;@10D45
	push	es	;@10D46
	push	di	;@10D47
	mov	es, cx	;@10D48
	call	far ptr L0003E	;@10D4A
	mov	si, di	;@10D4F
	push	es	;@10D51
	pop	ds	;@10D52
	pop	di	;@10D53
	pop	es	;@10D54
	rep movsb	;@10D55
	push	ss	;@10D57
	pop	ds	;@10D58
	pop	bx	;@10D59
	ret	;@10D5A
L10D5B:	mov	ax, word ptr ds:[3982h]	;@10D5B
	mov	cx, word ptr ds:[3988h]	;@10D5E
	jcxz	@@2	;@10D62
	cmp	ax, cx	;@10D64
	je	@@2	;@10D66
	call	L10D45	;@10D68
@@1:	mov	al, 3Ah	;@10D6B
	stosb	;@10D6D
	ret	;@10D6E
@@2:	mov	si, 57Dh	;@10D6F
	call	L102FA	;@10D72
	jmp	@@1	;@10D75
L10D77:	mov	es, word ptr ds:[3982h]	;@10D77
	call	far ptr L0004E	;@10D7B
	mov	word ptr ds:[3976h], ax	;@10D80
	mov	word ptr ds:[3978h], dx	;@10D83
	mov	word ptr ds:[3988h], di	;@10D87
	mov	bx, 3910h	;@10D8B
	call	L10641	;@10D8E
	mov	si, 5E7h	;@10D91
	call	L102FA	;@10D94
	call	L10D5B	;@10D97
	call	L10CB1	;@10D9A
	jmp	L10655	;@10D9D
L10DA0:	mov	si, 597h	;@10DA0
	call	L102FA	;@10DA3
	call	L10655	;@10DA6
	mov	es, word ptr ds:[3982h]	;@10DA9
	call	far ptr L0005E	;@10DAD
	mov	es, ax	;@10DB2
	call	far ptr L0003E	;@10DB4
	mov	si, di	;@10DB9
	mov	dx, es	;@10DBB
	mov	bx, 3910h	;@10DBD
	call	L10641	;@10DC0
	push	ds	;@10DC3
	mov	ds, dx	;@10DC4
	rep movsb	;@10DC6
	pop	ds	;@10DC8
	jmp	L10655	;@10DC9
L10DCC:	mov	si, 58Fh	;@10DCC
	call	L102FA	;@10DCF
	call	L10655	;@10DD2
	mov	es, word ptr ds:[3982h]	;@10DD5
	call	far ptr L0005A	;@10DD9
	push	cs	;@10DDE
	call	L0FCE0	;@10DDF
	mov	si, di	;@10DE2
	mov	dx, es	;@10DE4
	mov	bx, 3910h	;@10DE6
	call	L10641	;@10DE9
	push	ds	;@10DEC
	mov	ds, dx	;@10DED
	rep movsb	;@10DEF
	pop	ds	;@10DF1
	mov	al, 20h	;@10DF2
	stosb	;@10DF4
	call	L10655	;@10DF5
	ret	;@10DF8
L10DF9:	mov	si, 59Fh	;@10DF9
	call	L102FA	;@10DFC
	mov	si, 582h	;@10DFF
	call	L102FA	;@10E02
	call	L10655	;@10E05
	ret	;@10E08
L10E09:	mov	si, 5FFh	;@10E09
	call	L102FA	;@10E0C
	call	L10655	;@10E0F
	mov	es, word ptr ds:[3982h]	;@10E12
	call	far ptr L00052	;@10E16
	je	@@1	;@10E1B
	mov	es, ax	;@10E1D
	call	far ptr L0007A	;@10E1F
	call	far ptr L0007E	;@10E24
@@1:	ret	;@10E29
L10E2A:	mov	si, 5FFh	;@10E2A
	call	L102FA	;@10E2D
	call	L10655	;@10E30
	mov	es, word ptr ds:[3982h]	;@10E33
	call	far ptr L00056	;@10E37
	mov	es, ax	;@10E3C
	call	far ptr L0007A	;@10E3E
	call	far ptr L0007E	;@10E43
	ret	;@10E48
L10E49:	call	L10641	;@10E49
	call	L102FA	;@10E4C
	jmp	L1064A	;@10E4F
L10E52:	mov	bx, 391Ah	;@10E52
	mov	si, 4C6h	;@10E55
	call	L10E49	;@10E58
	mov	bx, 3910h	;@10E5B
	mov	si, 50Ah	;@10E5E
	call	L10E49	;@10E61
L10E64:	mov	bx, 394Ch	;@10E64
	mov	si, 54Eh	;@10E67
	call	L10E49	;@10E6A
	ret	;@10E6D
L10E6E:	mov	bx, 391Ah	;@10E6E
	mov	si, 4D2h	;@10E71
	call	L10E49	;@10E74
	jmp	L10E64	;@10E77
L10E79:	mov	bx, 391Ah	;@10E79
	mov	si, 4EFh	;@10E7C
	call	L10E49	;@10E7F
	mov	bx, 3910h	;@10E82
	mov	si, 517h	;@10E85
	call	L10E49	;@10E88
	jmp	L10E64	;@10E8B
L10E8D:	mov	bx, 391Ah	;@10E8D
	mov	si, 4FEh	;@10E90
	call	L10E49	;@10E93
	mov	bx, 3910h	;@10E96
	mov	si, 524h	;@10E99
	call	L10E49	;@10E9C
	jmp	L10E64	;@10E9F
L10EA1:	mov	bx, 391Ah	;@10EA1
	mov	si, 4DDh	;@10EA4
	call	L10E49	;@10EA7
	mov	bx, 3910h	;@10EAA
	mov	si, 530h	;@10EAD
	call	L10E49	;@10EB0
	jmp	L10E64	;@10EB3
L10EB5:	mov	ax, word ptr ds:[3910h]	;@10EB5
	mov	word ptr ds:[3912h], ax	;@10EB8
	mov	es, ax	;@10EBB
	mov	ax, 6	;@10EBD
	mov	word ptr es:[4], ax	;@10EC0
	mov	si, 152Dh	;@10EC4
	call	L1037D	;@10EC7
	mov	bx, 391Ah	;@10ECA
	call	L10665	;@10ECD
	mov	bx, 3910h	;@10ED0
	call	L10665	;@10ED3
	mov	bx, 394Ch	;@10ED6
	call	L10665	;@10ED9
	ret	;@10EDC
L10EDD:	call	L10589	;@10EDD
	call	L106CA	;@10EE0
	mov	bx, 391Ah	;@10EE3
	call	L10468	;@10EE6
	mov	bx, 3910h	;@10EE9
	call	L10468	;@10EEC
	mov	bx, 394Ch	;@10EEF
	call	L1047B	;@10EF2
	call	L1057B	;@10EF5
	jmp	L10683	;@10EF8
L10EFB:	mov	es, word ptr ds:[3962h]	;@10EFB
	cmp	byte ptr ds:[3997h], 1	;@10EFF
	je	@@1	;@10F04
	mov	ax, word ptr ds:[3972h]	;@10F06
	add	ax, 6	;@10F09
	cmp	ax, word ptr ds:[397Ah]	;@10F0C
	jbe	@@1	;@10F10
	call	L10041	;@10F12
@@1:	call	L10251	;@10F15
	xor	cx, cx	;@10F18
	call	L106CA	;@10F1A
	call	L10683	;@10F1D
	call	L10591	;@10F20
	call	L106CA	;@10F23
	mov	bx, 391Ah	;@10F26
	call	L10468	;@10F29
	mov	bx, 3910h	;@10F2C
	call	L10468	;@10F2F
	test	word ptr ds:[5198h], 800h	;@10F32
	je	@@2	;@10F38
	mov	bx, 394Ch	;@10F3A
	call	L10468	;@10F3D
@@2:	call	L1057B	;@10F40
	call	L10683	;@10F43
	xor	cx, cx	;@10F46
	call	L106CA	;@10F48
	call	L10683	;@10F4B
	add	word ptr ds:[3972h], 3	;@10F4E
	mov	bx, 394Ch	;@10F53
	call	L10665	;@10F56
	mov	bx, 3910h	;@10F59
	call	L10665	;@10F5C
	mov	bx, 391Ah	;@10F5F
	call	L10665	;@10F62
	ret	;@10F65
L10F66:	mov	byte ptr ds:[399Ah], 0	;@10F66
	mov	si, 15C3h	;@10F6B
	push	cs	;@10F6E
	call	L12051	;@10F6F
	ret	;@10F72
L10F73:	mov	byte ptr ds:[399Ah], 1	;@10F73
	mov	si, bx	;@10F78
	mov	bx, 391Ah	;@10F7A
	call	L10641	;@10F7D
	push	es	;@10F80
	call	far ptr L1455E	;@10F81
	pop	es	;@10F86
	call	L1064A	;@10F87
	mov	si, 15E6h	;@10F8A
	call	L1037D	;@10F8D
	mov	bx, 391Ah	;@10F90
	jmp	L10665	;@10F93
L10F96:	mov	cx, word ptr ds:[397Ch]	;@10F96
	call	L106CA	;@10F9A
	mov	bx, 391Ah	;@10F9D
	call	L1047B	;@10FA0
	jmp	L10683	;@10FA3
L10FA6:	mov	ax, ds	;@10FA6
	mov	es, ax	;@10FA8
	mov	di, si	;@10FAA
	mov	cx, 0FFFFh	;@10FAC
	xor	al, al	;@10FAF
	repne scasb	;@10FB1
	neg	cx	;@10FB3
	sub	cx, 2	;@10FB5
	mov	al, 0	;@10FB8
	call	L11149	;@10FBA
	mov	al, cl	;@10FBD
	stosb	;@10FBF
	rep movsb	;@10FC0
	call	L110D7	;@10FC2
	mov	word ptr ds:[3980h], 1	;@10FC5
	mov	si, 1633h	;@10FCB
	mov	ax, cs	;@10FCE
	push	cs	;@10FD0
	call	L11763	;@10FD1
	call	L10FF8	;@10FD4
	mov	al, 1	;@10FD7
	call	L11149	;@10FD9
	call	L110D7	;@10FDC
	call	L11119	;@10FDF
	ret	;@10FE2
L10FE3:	mov	ax, word ptr ds:[3980h]	;@10FE3
	push	cs	;@10FE6
	call	L11694	;@10FE7
	mov	dx, es	;@10FEA
	push	cs	;@10FEC
	call	L116B9	;@10FED
	call	L1112B	;@10FF0
	inc	word ptr ds:[3980h]	;@10FF3
	retf	;@10FF7
L10FF8:	mov	ax, word ptr ds:[3992h]	;@10FF8
@@1:	or	ax, ax	;@10FFB
	je	@@2	;@10FFD
	mov	es, ax	;@10FFF
	push	es	;@11001
	call	@@3	;@11002
	pop	es	;@11005
	mov	ax, word ptr es:[0]	;@11006
	jmp	@@1	;@1100A
@@2:	ret	;@1100C
@@3:	mov	word ptr ds:[398Ch], ax	;@1100D
	test	byte ptr es:[6], 4	;@11010
	je	@@4	;@11016
	ret	;@11018
@@4:	push	word ptr es:[8]	;@11019
	mov	al, 3	;@1101E
	call	L11149	;@11020
	pop	ax	;@11023
	push	ax	;@11024
	push	es	;@11025
	push	di	;@11026
	call	far ptr L00046	;@11027
	pop	di	;@1102C
	pop	es	;@1102D
	test	al, 80h	;@1102E
	jne	@@8	;@11030
	test	al, 20h	;@11032
	jne	@@6	;@11034
	and	al, 1Fh	;@11036
	cmp	al, 9	;@11038
	je	@@7	;@1103A
@@5:	xor	al, al	;@1103C
	jmp	short @@9	;@1103E
@@6:	test	al, 10h	;@11040
	je	@@5	;@11042
@@7:	mov	al, 40h	;@11044
	jmp	short @@9	;@11046
@@8:	mov	al, 80h	;@11048
@@9:	mov	byte ptr ds:[3998h], al	;@1104A
	stosb	;@1104D
	mov	bx, es	;@1104E
	mov	si, di	;@11050
	pop	ax	;@11052
	mov	es, ax	;@11053
	call	far ptr L00042	;@11055
	xchg	si, di	;@1105A
	push	ds	;@1105C
	push	es	;@1105D
	pop	ds	;@1105E
	mov	es, bx	;@1105F
	mov	al, cl	;@11061
	stosb	;@11063
	rep movsb	;@11064
	pop	ds	;@11066
@@10:	mov	cx, word ptr ds:[398Ch]	;@11067
	jcxz	@@14	;@1106B
	push	ds	;@1106D
	mov	ds, cx	;@1106E
	xor	al, al	;@11070
	test	byte ptr ss:[3998h], 40h	;@11072
	jne	@@11	;@11078
	mov	al, byte ptr ds:[6]	;@1107A
	and	al, 1	;@1107D
@@11:	stosb	;@1107F
	mov	ax, word ptr ds:[0Ch]	;@11080
	mov	bx, word ptr ds:[0Eh]	;@11083
	mov	dx, word ptr ds:[0Ah]	;@11087
	pop	ds	;@1108B
	push	di	;@1108C
	push	cs	;@1108D
	call	L11699	;@1108E
	pop	di	;@11091
	xchg	ax, cx	;@11092
	mov	es, word ptr ds:[3962h]	;@11093
	cmp	ax, 7Fh	;@11097
	ja	@@12	;@1109A
	stosb	;@1109C
	jmp	short @@13	;@1109D
@@12:	or	ah, 80h	;@1109F
	xchg	ah, al	;@110A2
	stosw	;@110A4
@@13:	mov	ax, cx	;@110A5
	inc	ax	;@110A7
	stosw	;@110A8
	mov	ax, bx	;@110A9
	inc	ax	;@110AB
	stosw	;@110AC
	push	es	;@110AD
	mov	es, word ptr ds:[398Ch]	;@110AE
	mov	cx, word ptr es:[4]	;@110B2
	mov	word ptr ds:[398Ch], cx	;@110B7
	pop	es	;@110BB
	jcxz	@@14	;@110BC
	mov	ax, di	;@110BE
	sub	ax, word ptr ds:[396Ah]	;@110C0
	cmp	ax, 3FAh	;@110C4
	jb	@@10	;@110C7
	call	L110D7	;@110C9
	mov	es, word ptr ds:[398Ch]	;@110CC
	jmp	@@4	;@110D0
@@14:	call	L110D7	;@110D3
	ret	;@110D6
L110D7:	push	bx	;@110D7
	mov	bx, word ptr ds:[396Ah]	;@110D8
	mov	ax, di	;@110DC
	sub	ax, 3	;@110DE
	sub	ax, bx	;@110E1
	mov	word ptr es:[bx+1], ax	;@110E3
	pop	bx	;@110E7
	mov	ax, word ptr ds:[3964h]	;@110E8
	sub	ax, 404h	;@110EB
	cmp	di, ax	;@110EE
	ja	L110F7	;@110F0
	mov	word ptr ds:[396Ah], di	;@110F2
	ret	;@110F6
L110F7:	push	bx	;@110F7
	push	si	;@110F8
	push	dx	;@110F9
	xor	dx, dx	;@110FA
	mov	cx, di	;@110FC
	sub	cx, dx	;@110FE
	mov	ax, es	;@11100
	mov	bx, word ptr ds:[396Ch]	;@11102
	push	cs	;@11106
	call	L112F6	;@11107
	pop	dx	;@1110A
	pop	si	;@1110B
	pop	bx	;@1110C
	jae	@@1	;@1110D
	jmp	L0FFF4	;@1110F
@@1:	mov	word ptr ds:[396Ah], 0	;@11112
	ret	;@11118
L11119:	mov	di, word ptr ds:[396Ah]	;@11119
	mov	ax, di	;@1111D
	and	ax, ax	;@1111F
	je	@@1	;@11121
	mov	es, word ptr ds:[3962h]	;@11123
	call	L110F7	;@11127
@@1:	ret	;@1112A
L1112B:	mov	si, di	;@1112B
	mov	cx, 0FFFFh	;@1112D
	xor	al, al	;@11130
	repne scasb	;@11132
	neg	cx	;@11134
	sub	cx, 2	;@11136
	mov	al, 2	;@11139
	push	ds	;@1113B
	push	es	;@1113C
	call	L11149	;@1113D
	pop	ds	;@11140
	mov	al, cl	;@11141
	stosb	;@11143
	rep movsb	;@11144
	pop	ds	;@11146
	jmp	L110D7	;@11147
L11149:	mov	es, word ptr ds:[3962h]	;@11149
	mov	di, word ptr ds:[396Ah]	;@1114D
	stosb	;@11151
	add	di, 2	;@11152
	ret	;@11155
L11156:	xor	ax, ax	;@11156
	mov	word ptr ds:[39AAh], ax	;@11158
	mov	word ptr ds:[39AEh], ax	;@1115B
	mov	word ptr ds:[399Eh], ax	;@1115E
	mov	byte ptr ds:[39B8h], al	;@11161
	mov	bx, ax	;@11164
	mov	cx, 0Ah	;@11166
@@1:	mov	word ptr [bx+39B9h], ax	;@11169
	mov	word ptr [bx+39CDh], ax	;@1116D
	mov	word ptr [bx+39E1h], ax	;@11171
	mov	word ptr [bx+39F5h], ax	;@11175
	inc	bx	;@11179
	inc	bx	;@1117A
	loop	@@1	;@1117B
	mov	ax, word ptr ds:[38C8h]	;@1117D
	cmp	ax, 0Fh	;@11180
	jae	@@2	;@11183
	mov	ax, 0Fh	;@11185
@@2:	cmp	ax, 100h	;@11188
	jb	@@3	;@1118B
	mov	ax, 0FFh	;@1118D
@@3:	mov	word ptr ds:[38C8h], ax	;@11190
	add	ax, 3E0Ch	;@11193
	mov	word ptr ds:[39B6h], ax	;@11196
	retf	;@11199
C0F9B	ends
	end
