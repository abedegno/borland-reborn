	.286p
S2A9	segment byte public 'CODE'
S2A9	ends
S2F4	segment byte public 'CODE'
S2F4	ends
S3E6	segment para public 'CODE'
S3E6	ends
S400	segment byte public 'CODE'
S400	ends
S434	segment para public 'CODE'
S434	ends
S444	segment para public 'CODE'
S444	ends
S446	segment para public 'CODE'
S446	ends
S51F	segment byte public 'CODE'
S51F	ends
S575	segment para public 'CODE'
S575	ends
S686	segment byte public 'CODE'
S686	ends
S6BA	segment para public 'CODE'
S6BA	ends
S6FE	segment para public 'CODE'
S6FE	ends
S6FF	segment para public 'CODE'
S6FF	ends
S707	segment para public 'CODE'
S707	ends
	locals
	extrn	_exit:far
	extrn	_fnsplit:far
	extrn	_printf:far
	extrn	_spawnlp:far
	extrn	_sprintf:far
	extrn	_getenv:far
	extrn	_memcpy:far
	extrn	_putenv:far
	extrn	_searchpath:far
	extrn	_strcat:far
	extrn	_strlen:far
	extrn	F_LXURSH@:far
	extrn	OVERFLOW@:far
	public	_main
	extrn	__setargv__:far
	extrn	__setenvp__:far
	extrn	L03F2A:far
	extrn	L04C92:far
	extrn	L04CE0:far
	extrn	L04D4B:far
	extrn	L04D91:far
	extrn	L04EEF:far
	extrn	L04F12:far
	extrn	L04F7B:far
	extrn	L04F9E:far
	extrn	L05165:far
	extrn	L05188:far
	extrn	L05347:far

S2A9	segment byte public 'CODE'
	assume	cs:S2A9
_main:	push	bp	;@02A96
	mov	bp, sp	;@02A97
	sub	sp, 4	;@02A99
	cmp	word ptr ds:[596h], sp	;@02A9C
	ja	@@1	;@02AA0
	call	far ptr OVERFLOW@	;@02AA2
@@1:	call	far ptr L04CE0	;@02AA7
	mov	word ptr ds:[956h], dx	;@02AAC
	mov	word ptr ds:[954h], ax	;@02AB0
	or	ax, dx	;@02AB3
	je	@@2	;@02AB5
	mov	ax, 1	;@02AB7
	jmp	short @@3	;@02ABA
@@2:	xor	ax, ax	;@02ABC
@@3:	mov	word ptr ds:[83Ah], ax	;@02ABE
	cmp	word ptr ds:[83Ah], 0	;@02AC1
	je	@@6	;@02AC6
	les	bx, dword ptr ds:[954h]	;@02AC8
	cmp	word ptr es:[bx+5Dh], 5	;@02ACC
	jbe	@@4	;@02AD1
	jmp	@@8	;@02AD3
@@4:	jb	@@5	;@02AD6
	cmp	word ptr es:[bx+5Bh], 0	;@02AD8
	jb	@@5	;@02ADD
	jmp	@@8	;@02ADF
@@5:	mov	ax, 140h	;@02AE2
	push	ax	;@02AE5
	les	bx, dword ptr ds:[954h]	;@02AE6
	mov	dx, word ptr es:[bx+5Dh]	;@02AEA
	mov	ax, word ptr es:[bx+5Bh]	;@02AEE
	mov	cl, 0Ah	;@02AF2
	call	far ptr F_LXURSH@	;@02AF4
	push	dx	;@02AF9
	push	ax	;@02AFA
	push	ds	;@02AFB
	mov	ax, 0A5h	;@02AFC
	push	ax	;@02AFF
	push	ds	;@02B00
	mov	ax, 195h	;@02B01
	push	ax	;@02B04
	call	far ptr _printf	;@02B05
	add	sp, 0Eh	;@02B0A
	mov	ax, 1	;@02B0D
	push	ax	;@02B10
	call	far ptr _exit	;@02B11
	pop	cx	;@02B16
	jmp	short @@8	;@02B17
@@6:	call	far ptr L05347	;@02B19
	mov	word ptr ds:[952h], dx	;@02B1E
	mov	word ptr ds:[950h], ax	;@02B22
	cmp	word ptr ds:[952h], 7	;@02B25
	ja	@@8	;@02B2A
	jb	@@7	;@02B2C
	cmp	word ptr ds:[950h], 800h	;@02B2E
	jae	@@8	;@02B34
@@7:	mov	ax, 1C2h	;@02B36
	push	ax	;@02B39
	mov	dx, word ptr ds:[952h]	;@02B3A
	mov	ax, word ptr ds:[950h]	;@02B3E
	mov	cl, 0Ah	;@02B41
	call	far ptr F_LXURSH@	;@02B43
	push	dx	;@02B48
	push	ax	;@02B49
	push	ds	;@02B4A
	mov	ax, 1C9h	;@02B4B
	push	ax	;@02B4E
	call	far ptr _printf	;@02B4F
	add	sp, 0Ah	;@02B54
	mov	ax, 1	;@02B57
	push	ax	;@02B5A
	call	far ptr _exit	;@02B5B
	pop	cx	;@02B60
@@8:	cmp	byte ptr ds:[7Dh], 3	;@02B61
	jb	@@9	;@02B66
	xor	ax, ax	;@02B68
	xor	dx, dx	;@02B6A
	push	ax	;@02B6C
	push	dx	;@02B6D
	push	ax	;@02B6E
	push	dx	;@02B6F
	push	ds	;@02B70
	mov	ax, 874h	;@02B71
	push	ax	;@02B74
	push	ds	;@02B75
	mov	ax, 86Ah	;@02B76
	push	ax	;@02B79
	les	bx, dword ptr [bp+8]	;@02B7A
	push	word ptr es:[bx+2]	;@02B7D
	push	word ptr es:[bx]	;@02B81
	call	far ptr _fnsplit	;@02B84
	add	sp, 14h	;@02B89
	push	ds	;@02B8C
	mov	ax, 874h	;@02B8D
	push	ax	;@02B90
	push	ds	;@02B91
	mov	ax, 86Ah	;@02B92
	push	ax	;@02B95
	push	ds	;@02B96
	mov	ax, 211h	;@02B97
	push	ax	;@02B9A
	push	ds	;@02B9B
	mov	ax, 84Ch	;@02B9C
	push	ax	;@02B9F
	call	far ptr _sprintf	;@02BA0
	add	sp, 10h	;@02BA5
	push	ds	;@02BA8
	mov	ax, 84Ch	;@02BA9
	push	ax	;@02BAC
	call	far ptr _strlen	;@02BAD
	pop	cx	;@02BB2
	pop	cx	;@02BB3
	mov	bx, ax	;@02BB4
	mov	byte ptr [bx+84Bh], 3Bh	;@02BB6
	push	ds	;@02BBB
	mov	ax, 21Bh	;@02BBC
	push	ax	;@02BBF
	call	far ptr _getenv	;@02BC0
	pop	cx	;@02BC5
	pop	cx	;@02BC6
	push	dx	;@02BC7
	push	ax	;@02BC8
	push	ds	;@02BC9
	mov	ax, 84Ch	;@02BCA
	push	ax	;@02BCD
	call	far ptr _strcat	;@02BCE
	add	sp, 8	;@02BD3
	push	ds	;@02BD6
	mov	ax, 84Ch	;@02BD7
	push	ax	;@02BDA
	call	far ptr _putenv	;@02BDB
	pop	cx	;@02BE0
	pop	cx	;@02BE1
@@9:	push	ds	;@02BE2
	mov	ax, 145h	;@02BE3
	push	ax	;@02BE6
	call	far ptr _searchpath	;@02BE7
	pop	cx	;@02BEC
	pop	cx	;@02BED
	mov	word ptr ds:[840h], dx	;@02BEE
	mov	word ptr ds:[83Eh], ax	;@02BF2
	or	ax, word ptr ds:[840h]	;@02BF5
	jne	@@10	;@02BF9
	push	ds	;@02BFB
	mov	ax, 145h	;@02BFC
	push	ax	;@02BFF
	push	ds	;@02C00
	mov	ax, 220h	;@02C01
	push	ax	;@02C04
	call	far ptr _printf	;@02C05
	add	sp, 8	;@02C0A
	mov	ax, 1	;@02C0D
	push	ax	;@02C10
	call	far ptr _exit	;@02C11
	pop	cx	;@02C16
@@10:	mov	es, word ptr ds:[7Bh]	;@02C17
	mov	al, byte ptr es:[80h]	;@02C1B
	mov	byte ptr ds:[95Ah], al	;@02C1F
	mov	ah, 0	;@02C22
	mov	word ptr ds:[84Ch], ax	;@02C24
	mov	al, byte ptr ds:[95Ah]	;@02C27
	mov	ah, 0	;@02C2A
	push	ax	;@02C2C
	push	word ptr ds:[7Bh]	;@02C2D
	mov	ax, 81h	;@02C31
	push	ax	;@02C34
	push	ds	;@02C35
	mov	ax, 84Eh	;@02C36
	push	ax	;@02C39
	call	far ptr _memcpy	;@02C3A
	add	sp, 0Ah	;@02C3F
	mov	al, byte ptr ds:[95Ah]	;@02C42
	mov	ah, 0	;@02C45
	mov	bx, ax	;@02C47
	mov	byte ptr [bx+84Eh], 0	;@02C49
	mov	byte ptr ds:[804h], 0	;@02C4E
	cmp	word ptr ds:[83Ah], 0	;@02C53
	je	@@11	;@02C58
	jmp	@@13	;@02C5A
@@11:	push	ds	;@02C5D
	mov	ax, 0A5h	;@02C5E
	push	ax	;@02C61
	call	far ptr _searchpath	;@02C62
	pop	cx	;@02C67
	pop	cx	;@02C68
	mov	word ptr [bp-2], dx	;@02C69
	mov	word ptr [bp-4], ax	;@02C6C
	or	ax, word ptr [bp-2]	;@02C6F
	jne	@@12	;@02C72
	push	ds	;@02C74
	mov	ax, 0A5h	;@02C75
	push	ax	;@02C78
	push	ds	;@02C79
	mov	ax, 220h	;@02C7A
	push	ax	;@02C7D
	call	far ptr _printf	;@02C7E
	add	sp, 8	;@02C83
	mov	ax, 1	;@02C86
	push	ax	;@02C89
	call	far ptr _exit	;@02C8A
	pop	cx	;@02C8F
@@12:	push	ds	;@02C90
	mov	ax, 243h	;@02C91
	push	ax	;@02C94
	push	ds	;@02C95
	mov	ax, 804h	;@02C96
	push	ax	;@02C99
	call	far ptr _strcat	;@02C9A
	add	sp, 8	;@02C9F
	xor	ax, ax	;@02CA2
	xor	dx, dx	;@02CA4
	push	ax	;@02CA6
	push	dx	;@02CA7
	push	ds	;@02CA8
	mov	ax, 804h	;@02CA9
	push	ax	;@02CAC
	push	word ptr [bp-2]	;@02CAD
	push	word ptr [bp-4]	;@02CB0
	push	word ptr [bp-2]	;@02CB3
	push	word ptr [bp-4]	;@02CB6
	xor	ax, ax	;@02CB9
	push	ax	;@02CBB
	call	far ptr _spawnlp	;@02CBC
	add	sp, 12h	;@02CC1
	cmp	ax, 0FFFFh	;@02CC4
	jne	@@13	;@02CC7
	push	ds	;@02CC9
	mov	ax, 0A5h	;@02CCA
	push	ax	;@02CCD
	push	ds	;@02CCE
	mov	ax, 24Fh	;@02CCF
	push	ax	;@02CD2
	call	far ptr _printf	;@02CD3
	add	sp, 8	;@02CD8
	mov	ax, 1	;@02CDB
	push	ax	;@02CDE
	call	far ptr _exit	;@02CDF
	pop	cx	;@02CE4
@@13:	call	far ptr L05188	;@02CE5
	or	ax, ax	;@02CEA
	je	@@14	;@02CEC
	push	ds	;@02CEE
	mov	ax, 0A5h	;@02CEF
	push	ax	;@02CF2
	push	ds	;@02CF3
	mov	ax, 145h	;@02CF4
	push	ax	;@02CF7
	push	ds	;@02CF8
	mov	ax, 26Bh	;@02CF9
	push	ax	;@02CFC
	call	far ptr _printf	;@02CFD
	add	sp, 0Ch	;@02D02
	mov	ax, 1	;@02D05
	push	ax	;@02D08
	call	far ptr _exit	;@02D09
	jmp	short @@15	;@02D0E
@@14:	mov	ax, 3	;@02D10
	push	ax	;@02D13
	call	far ptr L05165	;@02D14
@@15:	pop	cx	;@02D19
	mov	ax, 1	;@02D1A
	push	ax	;@02D1D
	call	far ptr L04C92	;@02D1E
	pop	cx	;@02D23
	or	ax, ax	;@02D24
	je	@@16	;@02D26
	push	ds	;@02D28
	mov	ax, 0A5h	;@02D29
	push	ax	;@02D2C
	push	ds	;@02D2D
	mov	ax, 2A1h	;@02D2E
	push	ax	;@02D31
	call	far ptr _printf	;@02D32
	add	sp, 8	;@02D37
	mov	ax, 1	;@02D3A
	push	ax	;@02D3D
	call	far ptr _exit	;@02D3E
	pop	cx	;@02D43
@@16:	push	ds	;@02D44
	mov	ax, 145h	;@02D45
	push	ax	;@02D48
	call	far ptr _searchpath	;@02D49
	pop	cx	;@02D4E
	pop	cx	;@02D4F
	mov	word ptr ds:[840h], dx	;@02D50
	mov	word ptr ds:[83Eh], ax	;@02D54
	push	ds	;@02D57
	mov	ax, 0A3h	;@02D58
	push	ax	;@02D5B
	push	word ptr ds:[77h]	;@02D5C
	xor	ax, ax	;@02D60
	push	ax	;@02D62
	push	ds	;@02D63
	mov	ax, 84Ch	;@02D64
	push	ax	;@02D67
	xor	ax, ax	;@02D68
	xor	dx, dx	;@02D6A
	push	ax	;@02D6C
	push	dx	;@02D6D
	push	word ptr ds:[840h]	;@02D6E
	push	word ptr ds:[83Eh]	;@02D72
	call	far ptr L04D4B	;@02D76
	add	sp, 14h	;@02D7B
	mov	word ptr ds:[958h], ax	;@02D7E
	or	ax, ax	;@02D81
	je	@@19	;@02D83
	cmp	word ptr ds:[958h], 14h	;@02D85
	jne	@@17	;@02D8A
	push	ds	;@02D8C
	mov	ax, 0A5h	;@02D8D
	push	ax	;@02D90
	push	ds	;@02D91
	mov	ax, 2C3h	;@02D92
	push	ax	;@02D95
	call	far ptr _printf	;@02D96
	add	sp, 8	;@02D9B
	jmp	short @@18	;@02D9E
@@17:	push	ds	;@02DA0
	mov	ax, 300h	;@02DA1
	push	ax	;@02DA4
	call	far ptr _printf	;@02DA5
	pop	cx	;@02DAA
	pop	cx	;@02DAB
@@18:	mov	ax, 1	;@02DAC
	push	ax	;@02DAF
	call	far ptr _exit	;@02DB0
	pop	cx	;@02DB5
@@19:	push	ds	;@02DB6
	mov	ax, 692h	;@02DB7
	push	ax	;@02DBA
	mov	ax, 172h	;@02DBB
	push	ax	;@02DBE
	xor	ax, ax	;@02DBF
	xor	dx, dx	;@02DC1
	push	ax	;@02DC3
	push	dx	;@02DC4
	push	word ptr ds:[0A3h]	;@02DC5
	call	far ptr L04F12	;@02DC9
	pop	cx	;@02DCE
	mov	word ptr ds:[83Ch], ax	;@02DCF
	push	ax	;@02DD2
	push	word ptr ds:[0A3h]	;@02DD3
	call	far ptr L04F7B	;@02DD7
@@20:	add	sp, 0Eh	;@02DDC
@@21:	xor	ax, ax	;@02DDF
	push	ax	;@02DE1
	push	word ptr ds:[0A3h]	;@02DE2
	call	far ptr L04D91	;@02DE6
	pop	cx	;@02DEB
	pop	cx	;@02DEC
	mov	word ptr [bp-2], ax	;@02DED
	push	ds	;@02DF0
	mov	ax, 692h	;@02DF1
	push	ax	;@02DF4
	mov	ax, 172h	;@02DF5
	push	ax	;@02DF8
	xor	ax, ax	;@02DF9
	xor	dx, dx	;@02DFB
	push	ax	;@02DFD
	push	dx	;@02DFE
	push	word ptr ds:[0A3h]	;@02DFF
	call	far ptr L04F12	;@02E03
	pop	cx	;@02E08
	mov	word ptr ds:[83Ch], ax	;@02E09
	push	ax	;@02E0C
	push	word ptr ds:[0A3h]	;@02E0D
	call	far ptr L04F7B	;@02E11
	add	sp, 0Eh	;@02E16
	cmp	word ptr [bp-2], 141h	;@02E19
	jne	@@23	;@02E1E
	call	far ptr L03F2A	;@02E20
	or	ax, ax	;@02E25
	jne	@@22	;@02E27
	push	ds	;@02E29
	mov	ax, 692h	;@02E2A
	push	ax	;@02E2D
	mov	ax, 172h	;@02E2E
	push	ax	;@02E31
	xor	ax, ax	;@02E32
	xor	dx, dx	;@02E34
	push	ax	;@02E36
	push	dx	;@02E37
	push	word ptr ds:[0A3h]	;@02E38
	call	far ptr L04F12	;@02E3C
	pop	cx	;@02E41
	mov	word ptr ds:[83Ch], ax	;@02E42
	push	ax	;@02E45
	push	word ptr ds:[0A3h]	;@02E46
	call	far ptr L04F9E	;@02E4A
	jmp	@@20	;@02E4F
@@22:	push	word ptr ds:[6AAh]	;@02E51
	push	ds	;@02E55
	mov	ax, 31Dh	;@02E56
	push	ax	;@02E59
	call	far ptr _printf	;@02E5A
	add	sp, 6	;@02E5F
	jmp	short @@27	;@02E62
@@23:	cmp	word ptr [bp-2], 103h	;@02E64
	jne	@@24	;@02E69
	jmp	@@21	;@02E6B
@@24:	cmp	word ptr [bp-2], 1Eh	;@02E6E
	je	@@27	;@02E72
	mov	ax, word ptr [bp-2]	;@02E74
	and	ax, 0FF00h	;@02E77
	cmp	ax, 100h	;@02E7A
	jne	@@25	;@02E7D
	mov	ax, word ptr [bp-2]	;@02E7F
	and	ax, 0FFh	;@02E82
	push	ax	;@02E85
	push	ds	;@02E86
	mov	ax, 34Eh	;@02E87
	jmp	short @@26	;@02E8A
@@25:	push	word ptr [bp-2]	;@02E8C
	push	ds	;@02E8F
	mov	ax, 373h	;@02E90
@@26:	push	ax	;@02E93
	call	far ptr _printf	;@02E94
	add	sp, 6	;@02E99
	nosmart
	nosmart
	call	far ptr L02F21	;@02E9C
	smart
	smart
@@27:	call	far ptr L04EEF	;@02EA1
	mov	word ptr ds:[958h], ax	;@02EA6
	cmp	word ptr ds:[83Ah], 0	;@02EA9
	jne	@@30	;@02EAE
	push	ds	;@02EB0
	mov	ax, 0A5h	;@02EB1
	push	ax	;@02EB4
	call	far ptr _searchpath	;@02EB5
	pop	cx	;@02EBA
	pop	cx	;@02EBB
	mov	word ptr ds:[844h], dx	;@02EBC
	mov	word ptr ds:[842h], ax	;@02EC0
	or	ax, word ptr ds:[844h]	;@02EC3
	jne	@@28	;@02EC7
	push	ds	;@02EC9
	mov	ax, 0A5h	;@02ECA
	push	ax	;@02ECD
	push	ds	;@02ECE
	mov	ax, 220h	;@02ECF
	jmp	short @@29	;@02ED2
@@28:	xor	ax, ax	;@02ED4
	xor	dx, dx	;@02ED6
	push	ax	;@02ED8
	push	dx	;@02ED9
	push	ds	;@02EDA
	mov	ax, 390h	;@02EDB
	push	ax	;@02EDE
	push	word ptr ds:[844h]	;@02EDF
	push	word ptr ds:[842h]	;@02EE3
	push	word ptr ds:[844h]	;@02EE7
	push	word ptr ds:[842h]	;@02EEB
	xor	ax, ax	;@02EEF
	push	ax	;@02EF1
	call	far ptr _spawnlp	;@02EF2
	add	sp, 12h	;@02EF7
	cmp	ax, 0FFFFh	;@02EFA
	jne	@@30	;@02EFD
	push	ds	;@02EFF
	mov	ax, 0A5h	;@02F00
	push	ax	;@02F03
	push	ds	;@02F04
	mov	ax, 398h	;@02F05
@@29:	push	ax	;@02F08
	call	far ptr _printf	;@02F09
	add	sp, 8	;@02F0E
@@30:	xor	ax, ax	;@02F11
	push	ax	;@02F13
	call	far ptr L05165	;@02F14
	pop	cx	;@02F19
	mov	ax, word ptr ds:[958h]	;@02F1A
	mov	sp, bp	;@02F1D
	pop	bp	;@02F1F
	retf	;@02F20
L02F21:	push	bp	;@02F21
	mov	bp, sp	;@02F22
	cmp	word ptr ds:[596h], sp	;@02F24
	ja	@@1	;@02F28
	call	far ptr OVERFLOW@	;@02F2A
@@1:	push	word ptr ds:[6A0h]	;@02F2F
	push	word ptr ds:[6B6h]	;@02F33
	push	ds	;@02F37
	mov	ax, 3B3h	;@02F38
	push	ax	;@02F3B
	call	far ptr _printf	;@02F3C
	add	sp, 8	;@02F41
	pop	bp	;@02F44
	retf	;@02F45
S2A9	ends
	end
