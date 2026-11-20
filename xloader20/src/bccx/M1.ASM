	.286p
S2BF	segment byte public 'CODE'
S2BF	ends
S32C	segment byte public 'CODE'
S32C	ends
S41D	segment byte public 'CODE'
S41D	ends
S438	segment byte public 'CODE'
S438	ends
S46C	segment para public 'CODE'
S46C	ends
S47C	segment para public 'CODE'
S47C	ends
S47E	segment para public 'CODE'
S47E	ends
S557	segment byte public 'CODE'
S557	ends
S5AD	segment para public 'CODE'
S5AD	ends
S6BE	segment byte public 'CODE'
S6BE	ends
S6F2	segment para public 'CODE'
S6F2	ends
S736	segment para public 'CODE'
S736	ends
S737	segment para public 'CODE'
S737	ends
S73F	segment para public 'CODE'
S73F	ends
	locals
	extrn	_exit:far
	extrn	_fnsplit:far
	extrn	_printf:far
	extrn	_spawnlp:far
	extrn	_sprintf:far
	extrn	_atol:far
	extrn	_getenv:far
	extrn	_itoa:far
	extrn	_memcpy:far
	extrn	_memmove:far
	extrn	_putenv:far
	extrn	_searchpath:far
	extrn	_strcat:far
	extrn	_strlen:far
	extrn	_strstr:far
	extrn	F_LXURSH@:far
	extrn	OVERFLOW@:far
	public	_main
	extrn	__setargv__:far
	extrn	__setenvp__:far
	extrn	L042A6:far
	extrn	L05012:far
	extrn	L05060:far
	extrn	L050CB:far
	extrn	L05111:far
	extrn	L0526F:far
	extrn	L05292:far
	extrn	L052FB:far
	extrn	L0531E:far
	extrn	L054E5:far
	extrn	L05508:far
	extrn	L056C7:far

S2BF	segment byte public 'CODE'
	assume	cs:S2BF
_main:	push	bp	;@02BFD
	mov	bp, sp	;@02BFE
	sub	sp, 4	;@02C00
	cmp	word ptr ds:[718h], sp	;@02C03
	ja	@@1	;@02C07
	call	far ptr OVERFLOW@	;@02C09
@@1:	call	far ptr L05060	;@02C0E
	mov	word ptr ds:[0AD8h], dx	;@02C13
	mov	word ptr ds:[0AD6h], ax	;@02C17
	or	ax, dx	;@02C1A
	je	@@2	;@02C1C
	mov	ax, 1	;@02C1E
	jmp	short @@3	;@02C21
@@2:	xor	ax, ax	;@02C23
@@3:	mov	word ptr ds:[9BCh], ax	;@02C25
	cmp	word ptr ds:[9BCh], 0	;@02C28
	je	@@6	;@02C2D
	les	bx, dword ptr ds:[0AD6h]	;@02C2F
	cmp	word ptr es:[bx+5Dh], 5	;@02C33
	jbe	@@4	;@02C38
	jmp	@@8	;@02C3A
@@4:	jb	@@5	;@02C3D
	cmp	word ptr es:[bx+5Bh], 0	;@02C3F
	jb	@@5	;@02C44
	jmp	@@8	;@02C46
@@5:	mov	ax, 140h	;@02C49
	push	ax	;@02C4C
	les	bx, dword ptr ds:[0AD6h]	;@02C4D
	mov	dx, word ptr es:[bx+5Dh]	;@02C51
	mov	ax, word ptr es:[bx+5Bh]	;@02C55
	mov	cl, 0Ah	;@02C59
	call	far ptr F_LXURSH@	;@02C5B
	push	dx	;@02C60
	push	ax	;@02C61
	push	ds	;@02C62
	mov	ax, 0A3h	;@02C63
	push	ax	;@02C66
	push	ds	;@02C67
	mov	ax, 193h	;@02C68
	push	ax	;@02C6B
	call	far ptr _printf	;@02C6C
	add	sp, 0Eh	;@02C71
	mov	ax, 1	;@02C74
	push	ax	;@02C77
	call	far ptr _exit	;@02C78
	pop	cx	;@02C7D
	jmp	short @@8	;@02C7E
@@6:	call	far ptr L056C7	;@02C80
	mov	word ptr ds:[0AD4h], dx	;@02C85
	mov	word ptr ds:[0AD2h], ax	;@02C89
	cmp	word ptr ds:[0AD4h], 7	;@02C8C
	ja	@@8	;@02C91
	jb	@@7	;@02C93
	cmp	word ptr ds:[0AD2h], 800h	;@02C95
	jae	@@8	;@02C9B
@@7:	mov	ax, 1C2h	;@02C9D
	push	ax	;@02CA0
	mov	dx, word ptr ds:[0AD4h]	;@02CA1
	mov	ax, word ptr ds:[0AD2h]	;@02CA5
	mov	cl, 0Ah	;@02CA8
	call	far ptr F_LXURSH@	;@02CAA
	push	dx	;@02CAF
	push	ax	;@02CB0
	push	ds	;@02CB1
	mov	ax, 1C7h	;@02CB2
	push	ax	;@02CB5
	call	far ptr _printf	;@02CB6
	add	sp, 0Ah	;@02CBB
	mov	ax, 1	;@02CBE
	push	ax	;@02CC1
	call	far ptr _exit	;@02CC2
	pop	cx	;@02CC7
@@8:	cmp	byte ptr ds:[7Dh], 3	;@02CC8
	jb	@@9	;@02CCD
	xor	ax, ax	;@02CCF
	xor	dx, dx	;@02CD1
	push	ax	;@02CD3
	push	dx	;@02CD4
	push	ax	;@02CD5
	push	dx	;@02CD6
	push	ds	;@02CD7
	mov	ax, 9F6h	;@02CD8
	push	ax	;@02CDB
	push	ds	;@02CDC
	mov	ax, 9ECh	;@02CDD
	push	ax	;@02CE0
	les	bx, dword ptr [bp+8]	;@02CE1
	push	word ptr es:[bx+2]	;@02CE4
	push	word ptr es:[bx]	;@02CE8
	call	far ptr _fnsplit	;@02CEB
	add	sp, 14h	;@02CF0
	push	ds	;@02CF3
	mov	ax, 9F6h	;@02CF4
	push	ax	;@02CF7
	push	ds	;@02CF8
	mov	ax, 9ECh	;@02CF9
	push	ax	;@02CFC
	push	ds	;@02CFD
	mov	ax, 20Fh	;@02CFE
	push	ax	;@02D01
	push	ds	;@02D02
	mov	ax, 9CEh	;@02D03
	push	ax	;@02D06
	call	far ptr _sprintf	;@02D07
	add	sp, 10h	;@02D0C
	push	ds	;@02D0F
	mov	ax, 9CEh	;@02D10
	push	ax	;@02D13
	call	far ptr _strlen	;@02D14
	pop	cx	;@02D19
	pop	cx	;@02D1A
	mov	bx, ax	;@02D1B
	mov	byte ptr [bx+9CDh], 3Bh	;@02D1D
	push	ds	;@02D22
	mov	ax, 219h	;@02D23
	push	ax	;@02D26
	call	far ptr _getenv	;@02D27
	pop	cx	;@02D2C
	pop	cx	;@02D2D
	push	dx	;@02D2E
	push	ax	;@02D2F
	push	ds	;@02D30
	mov	ax, 9CEh	;@02D31
	push	ax	;@02D34
	call	far ptr _strcat	;@02D35
	add	sp, 8	;@02D3A
	push	ds	;@02D3D
	mov	ax, 9CEh	;@02D3E
	push	ax	;@02D41
	call	far ptr _putenv	;@02D42
	pop	cx	;@02D47
	pop	cx	;@02D48
@@9:	push	ds	;@02D49
	mov	ax, 143h	;@02D4A
	push	ax	;@02D4D
	call	far ptr _searchpath	;@02D4E
	pop	cx	;@02D53
	pop	cx	;@02D54
	mov	word ptr ds:[9C2h], dx	;@02D55
	mov	word ptr ds:[9C0h], ax	;@02D59
	or	ax, word ptr ds:[9C2h]	;@02D5C
	jne	@@10	;@02D60
	push	ds	;@02D62
	mov	ax, 143h	;@02D63
	push	ax	;@02D66
	push	ds	;@02D67
	mov	ax, 21Eh	;@02D68
	push	ax	;@02D6B
	call	far ptr _printf	;@02D6C
	add	sp, 8	;@02D71
	mov	ax, 1	;@02D74
	push	ax	;@02D77
	call	far ptr _exit	;@02D78
	pop	cx	;@02D7D
@@10:	mov	es, word ptr ds:[7Bh]	;@02D7E
	mov	al, byte ptr es:[80h]	;@02D82
	mov	byte ptr ds:[0ADCh], al	;@02D86
	mov	ah, 0	;@02D89
	mov	word ptr ds:[9CEh], ax	;@02D8B
	mov	al, byte ptr ds:[0ADCh]	;@02D8E
	mov	ah, 0	;@02D91
	push	ax	;@02D93
	push	word ptr ds:[7Bh]	;@02D94
	mov	ax, 81h	;@02D98
	push	ax	;@02D9B
	push	ds	;@02D9C
	mov	ax, 9D0h	;@02D9D
	push	ax	;@02DA0
	call	far ptr _memcpy	;@02DA1
	add	sp, 0Ah	;@02DA6
	mov	al, byte ptr ds:[0ADCh]	;@02DA9
	mov	ah, 0	;@02DAC
	mov	bx, ax	;@02DAE
	mov	byte ptr [bx+9D0h], 0	;@02DB0
	mov	byte ptr ds:[986h], 0	;@02DB5
	push	ds	;@02DBA
	mov	ax, 241h	;@02DBB
	push	ax	;@02DBE
	push	ds	;@02DBF
	mov	ax, 9D0h	;@02DC0
	push	ax	;@02DC3
	call	far ptr _strstr	;@02DC4
	add	sp, 8	;@02DC9
	mov	word ptr ds:[9B2h], dx	;@02DCC
	mov	word ptr ds:[9B0h], ax	;@02DD0
	or	ax, dx	;@02DD3
	jne	@@11	;@02DD5
	push	ds	;@02DD7
	mov	ax, 245h	;@02DD8
	push	ax	;@02DDB
	push	ds	;@02DDC
	mov	ax, 9D0h	;@02DDD
	push	ax	;@02DE0
	call	far ptr _strstr	;@02DE1
	add	sp, 8	;@02DE6
	mov	word ptr ds:[9B2h], dx	;@02DE9
	mov	word ptr ds:[9B0h], ax	;@02DED
	or	ax, dx	;@02DF0
	jne	@@11	;@02DF2
	jmp	@@24	;@02DF4
@@11:	mov	ax, word ptr ds:[9B2h]	;@02DF7
	mov	dx, word ptr ds:[9B0h]	;@02DFA
	add	dx, 3	;@02DFE
	mov	word ptr ds:[9BAh], ax	;@02E01
	mov	word ptr ds:[9B8h], dx	;@02E04
	mov	al, byte ptr ds:[0ADCh]	;@02E08
	add	al, 0FDh	;@02E0B
	mov	byte ptr ds:[0ADCh], al	;@02E0D
	cmp	word ptr ds:[9BCh], 0	;@02E10
	je	@@12	;@02E15
	push	ds	;@02E17
	mov	ax, 0A3h	;@02E18
	push	ax	;@02E1B
	push	ds	;@02E1C
	mov	ax, 249h	;@02E1D
	push	ax	;@02E20
	call	far ptr _printf	;@02E21
	add	sp, 8	;@02E26
@@12:	les	bx, dword ptr ds:[9B8h]	;@02E29
	cmp	byte ptr es:[bx], 3Dh	;@02E2D
	je	@@13	;@02E31
	jmp	@@23	;@02E33
@@13:	mov	word ptr ds:[0AD0h], ds	;@02E36
	mov	word ptr ds:[0ACEh], 9C8h	;@02E3A
	mov	word ptr ds:[9B6h], 0	;@02E40
	inc	word ptr ds:[9B8h]	;@02E46
	dec	byte ptr ds:[0ADCh]	;@02E4A
	jmp	short @@15	;@02E4E
@@14:	les	bx, dword ptr ds:[9B8h]	;@02E50
	cmp	byte ptr es:[bx], 30h	;@02E54
	jl	@@16	;@02E58
	cmp	byte ptr es:[bx], 39h	;@02E5A
	jg	@@16	;@02E5E
	mov	al, byte ptr es:[bx]	;@02E60
	les	bx, dword ptr ds:[0ACEh]	;@02E63
	mov	byte ptr es:[bx], al	;@02E67
	inc	word ptr ds:[9B8h]	;@02E6A
	inc	word ptr ds:[0ACEh]	;@02E6E
	dec	byte ptr ds:[0ADCh]	;@02E72
	inc	word ptr ds:[9B6h]	;@02E76
@@15:	cmp	word ptr ds:[9B6h], 5	;@02E7A
	jb	@@14	;@02E7F
@@16:	les	bx, dword ptr ds:[0ACEh]	;@02E81
	mov	byte ptr es:[bx], 0	;@02E85
	cmp	byte ptr ds:[9C8h], 0	;@02E89
	je	@@17	;@02E8E
	cmp	word ptr ds:[9BCh], 0	;@02E90
	jne	@@17	;@02E95
	push	ds	;@02E97
	mov	ax, 9C8h	;@02E98
	push	ax	;@02E9B
	call	far ptr _atol	;@02E9C
	pop	cx	;@02EA1
	pop	cx	;@02EA2
	mov	word ptr ds:[9B6h], ax	;@02EA3
	add	word ptr ds:[9B6h], 400h	;@02EA6
	mov	ax, 0Ah	;@02EAC
	push	ax	;@02EAF
	push	ds	;@02EB0
	mov	ax, 9C8h	;@02EB1
	push	ax	;@02EB4
	push	word ptr ds:[9B6h]	;@02EB5
	call	far ptr _itoa	;@02EB9
	add	sp, 8	;@02EBE
	push	ds	;@02EC1
	mov	ax, 9C8h	;@02EC2
	push	ax	;@02EC5
	push	ds	;@02EC6
	mov	ax, 277h	;@02EC7
	push	ax	;@02ECA
	push	ds	;@02ECB
	mov	ax, 986h	;@02ECC
	push	ax	;@02ECF
	call	far ptr _strcat	;@02ED0
	add	sp, 8	;@02ED5
	push	dx	;@02ED8
	push	ax	;@02ED9
	call	far ptr _strcat	;@02EDA
	add	sp, 8	;@02EDF
@@17:	les	bx, dword ptr ds:[9B8h]	;@02EE2
	inc	word ptr ds:[9B8h]	;@02EE6
	cmp	byte ptr es:[bx], 2Ch	;@02EEA
	je	@@18	;@02EEE
	jmp	@@23	;@02EF0
@@18:	dec	byte ptr ds:[0ADCh]	;@02EF3
	mov	word ptr ds:[0AD0h], ds	;@02EF7
	mov	word ptr ds:[0ACEh], 9C8h	;@02EFB
	mov	word ptr ds:[9B6h], 0	;@02F01
	jmp	short @@20	;@02F07
@@19:	les	bx, dword ptr ds:[9B8h]	;@02F09
	cmp	byte ptr es:[bx], 30h	;@02F0D
	jl	@@21	;@02F11
	cmp	byte ptr es:[bx], 39h	;@02F13
	jg	@@21	;@02F17
	mov	al, byte ptr es:[bx]	;@02F19
	les	bx, dword ptr ds:[0ACEh]	;@02F1C
	mov	byte ptr es:[bx], al	;@02F20
	inc	word ptr ds:[9B8h]	;@02F23
	inc	word ptr ds:[0ACEh]	;@02F27
	dec	byte ptr ds:[0ADCh]	;@02F2B
	inc	word ptr ds:[9B6h]	;@02F2F
@@20:	cmp	word ptr ds:[9B6h], 5	;@02F33
	jb	@@19	;@02F38
@@21:	les	bx, dword ptr ds:[0ACEh]	;@02F3A
	mov	byte ptr es:[bx], 0	;@02F3E
	cmp	byte ptr ds:[9C8h], 0	;@02F42
	je	@@23	;@02F47
	cmp	word ptr ds:[9BCh], 0	;@02F49
	jne	@@23	;@02F4E
	push	ds	;@02F50
	mov	ax, 9C8h	;@02F51
	push	ax	;@02F54
	call	far ptr _atol	;@02F55
	pop	cx	;@02F5A
	pop	cx	;@02F5B
	cmp	ax, 140h	;@02F5C
	jge	@@22	;@02F5F
	mov	ax, 140h	;@02F61
	push	ax	;@02F64
	push	ds	;@02F65
	mov	ax, 283h	;@02F66
	push	ax	;@02F69
	call	far ptr _printf	;@02F6A
	add	sp, 6	;@02F6F
	mov	ax, 1	;@02F72
	push	ax	;@02F75
	call	far ptr _exit	;@02F76
	pop	cx	;@02F7B
@@22:	push	ds	;@02F7C
	mov	ax, 9C8h	;@02F7D
	push	ax	;@02F80
	push	ds	;@02F81
	mov	ax, 2BBh	;@02F82
	push	ax	;@02F85
	push	ds	;@02F86
	mov	ax, 986h	;@02F87
	push	ax	;@02F8A
	call	far ptr _strcat	;@02F8B
	add	sp, 8	;@02F90
	push	dx	;@02F93
	push	ax	;@02F94
	call	far ptr _strcat	;@02F95
	add	sp, 8	;@02F9A
@@23:	push	word ptr ds:[9BAh]	;@02F9D
	push	word ptr ds:[9B8h]	;@02FA1
	call	far ptr _strlen	;@02FA5
	pop	cx	;@02FAA
	pop	cx	;@02FAB
	inc	ax	;@02FAC
	push	ax	;@02FAD
	push	word ptr ds:[9BAh]	;@02FAE
	push	word ptr ds:[9B8h]	;@02FB2
	push	word ptr ds:[9B2h]	;@02FB6
	push	word ptr ds:[9B0h]	;@02FBA
	call	far ptr _memmove	;@02FBE
	add	sp, 0Ah	;@02FC3
	mov	al, byte ptr ds:[0ADCh]	;@02FC6
	mov	ah, 0	;@02FC9
	mov	word ptr ds:[9CEh], ax	;@02FCB
@@24:	cmp	word ptr ds:[9BCh], 0	;@02FCE
	je	@@25	;@02FD3
	jmp	@@27	;@02FD5
@@25:	push	ds	;@02FD8
	mov	ax, 0A3h	;@02FD9
	push	ax	;@02FDC
	call	far ptr _searchpath	;@02FDD
	pop	cx	;@02FE2
	pop	cx	;@02FE3
	mov	word ptr [bp-2], dx	;@02FE4
	mov	word ptr [bp-4], ax	;@02FE7
	or	ax, word ptr [bp-2]	;@02FEA
	jne	@@26	;@02FED
	push	ds	;@02FEF
	mov	ax, 0A3h	;@02FF0
	push	ax	;@02FF3
	push	ds	;@02FF4
	mov	ax, 21Eh	;@02FF5
	push	ax	;@02FF8
	call	far ptr _printf	;@02FF9
	add	sp, 8	;@02FFE
	mov	ax, 1	;@03001
	push	ax	;@03004
	call	far ptr _exit	;@03005
	pop	cx	;@0300A
@@26:	push	ds	;@0300B
	mov	ax, 2C3h	;@0300C
	push	ax	;@0300F
	push	ds	;@03010
	mov	ax, 986h	;@03011
	push	ax	;@03014
	call	far ptr _strcat	;@03015
	add	sp, 8	;@0301A
	xor	ax, ax	;@0301D
	xor	dx, dx	;@0301F
	push	ax	;@03021
	push	dx	;@03022
	push	ds	;@03023
	mov	ax, 986h	;@03024
	push	ax	;@03027
	push	word ptr [bp-2]	;@03028
	push	word ptr [bp-4]	;@0302B
	push	word ptr [bp-2]	;@0302E
	push	word ptr [bp-4]	;@03031
	xor	ax, ax	;@03034
	push	ax	;@03036
	call	far ptr _spawnlp	;@03037
	add	sp, 12h	;@0303C
	cmp	ax, 0FFFFh	;@0303F
	jne	@@27	;@03042
	push	ds	;@03044
	mov	ax, 0A3h	;@03045
	push	ax	;@03048
	push	ds	;@03049
	mov	ax, 2CFh	;@0304A
	push	ax	;@0304D
	call	far ptr _printf	;@0304E
	add	sp, 8	;@03053
	mov	ax, 1	;@03056
	push	ax	;@03059
	call	far ptr _exit	;@0305A
	pop	cx	;@0305F
@@27:	call	far ptr L05508	;@03060
	or	ax, ax	;@03065
	je	@@28	;@03067
	push	ds	;@03069
	mov	ax, 0A3h	;@0306A
	push	ax	;@0306D
	push	ds	;@0306E
	mov	ax, 143h	;@0306F
	push	ax	;@03072
	push	ds	;@03073
	mov	ax, 2EBh	;@03074
	push	ax	;@03077
	call	far ptr _printf	;@03078
	add	sp, 0Ch	;@0307D
	mov	ax, 1	;@03080
	push	ax	;@03083
	call	far ptr _exit	;@03084
	jmp	short @@29	;@03089
@@28:	mov	ax, 2	;@0308B
	push	ax	;@0308E
	call	far ptr L054E5	;@0308F
@@29:	pop	cx	;@03094
	mov	ax, 1	;@03095
	push	ax	;@03098
	call	far ptr L05012	;@03099
	pop	cx	;@0309E
	or	ax, ax	;@0309F
	je	@@30	;@030A1
	push	ds	;@030A3
	mov	ax, 0A3h	;@030A4
	push	ax	;@030A7
	push	ds	;@030A8
	mov	ax, 321h	;@030A9
	push	ax	;@030AC
	call	far ptr _printf	;@030AD
	add	sp, 8	;@030B2
	mov	ax, 1	;@030B5
	push	ax	;@030B8
	call	far ptr _exit	;@030B9
	pop	cx	;@030BE
@@30:	push	ds	;@030BF
	mov	ax, 143h	;@030C0
	push	ax	;@030C3
	call	far ptr _searchpath	;@030C4
	pop	cx	;@030C9
	pop	cx	;@030CA
	mov	word ptr ds:[9C2h], dx	;@030CB
	mov	word ptr ds:[9C0h], ax	;@030CF
	push	ds	;@030D2
	mov	ax, 0A1h	;@030D3
	push	ax	;@030D6
	push	word ptr ds:[77h]	;@030D7
	xor	ax, ax	;@030DB
	push	ax	;@030DD
	push	ds	;@030DE
	mov	ax, 9CEh	;@030DF
	push	ax	;@030E2
	xor	ax, ax	;@030E3
	xor	dx, dx	;@030E5
	push	ax	;@030E7
	push	dx	;@030E8
	push	word ptr ds:[9C2h]	;@030E9
	push	word ptr ds:[9C0h]	;@030ED
	call	far ptr L050CB	;@030F1
	add	sp, 14h	;@030F6
	mov	word ptr ds:[0ADAh], ax	;@030F9
	or	ax, ax	;@030FC
	je	@@33	;@030FE
	cmp	word ptr ds:[0ADAh], 14h	;@03100
	jne	@@31	;@03105
	push	ds	;@03107
	mov	ax, 0A3h	;@03108
	push	ax	;@0310B
	push	ds	;@0310C
	mov	ax, 343h	;@0310D
	push	ax	;@03110
	call	far ptr _printf	;@03111
	add	sp, 8	;@03116
	jmp	short @@32	;@03119
@@31:	push	ds	;@0311B
	mov	ax, 380h	;@0311C
	push	ax	;@0311F
	call	far ptr _printf	;@03120
	pop	cx	;@03125
	pop	cx	;@03126
@@32:	mov	ax, 1	;@03127
	push	ax	;@0312A
	call	far ptr _exit	;@0312B
	pop	cx	;@03130
@@33:	push	ds	;@03131
	mov	ax, 814h	;@03132
	push	ax	;@03135
	mov	ax, 172h	;@03136
	push	ax	;@03139
	xor	ax, ax	;@0313A
	xor	dx, dx	;@0313C
	push	ax	;@0313E
	push	dx	;@0313F
	push	word ptr ds:[0A1h]	;@03140
	call	far ptr L05292	;@03144
	pop	cx	;@03149
	mov	word ptr ds:[9BEh], ax	;@0314A
	push	ax	;@0314D
	push	word ptr ds:[0A1h]	;@0314E
	call	far ptr L052FB	;@03152
@@34:	add	sp, 0Eh	;@03157
@@35:	xor	ax, ax	;@0315A
	push	ax	;@0315C
	push	word ptr ds:[0A1h]	;@0315D
	call	far ptr L05111	;@03161
	pop	cx	;@03166
	pop	cx	;@03167
	mov	word ptr [bp-2], ax	;@03168
	push	ds	;@0316B
	mov	ax, 814h	;@0316C
	push	ax	;@0316F
	mov	ax, 172h	;@03170
	push	ax	;@03173
	xor	ax, ax	;@03174
	xor	dx, dx	;@03176
	push	ax	;@03178
	push	dx	;@03179
	push	word ptr ds:[0A1h]	;@0317A
	call	far ptr L05292	;@0317E
	pop	cx	;@03183
	mov	word ptr ds:[9BEh], ax	;@03184
	push	ax	;@03187
	push	word ptr ds:[0A1h]	;@03188
	call	far ptr L052FB	;@0318C
	add	sp, 0Eh	;@03191
	cmp	word ptr [bp-2], 141h	;@03194
	jne	@@37	;@03199
	call	far ptr L042A6	;@0319B
	or	ax, ax	;@031A0
	jne	@@36	;@031A2
	push	ds	;@031A4
	mov	ax, 814h	;@031A5
	push	ax	;@031A8
	mov	ax, 172h	;@031A9
	push	ax	;@031AC
	xor	ax, ax	;@031AD
	xor	dx, dx	;@031AF
	push	ax	;@031B1
	push	dx	;@031B2
	push	word ptr ds:[0A1h]	;@031B3
	call	far ptr L05292	;@031B7
	pop	cx	;@031BC
	mov	word ptr ds:[9BEh], ax	;@031BD
	push	ax	;@031C0
	push	word ptr ds:[0A1h]	;@031C1
	call	far ptr L0531E	;@031C5
	jmp	@@34	;@031CA
@@36:	push	word ptr ds:[82Ch]	;@031CC
	push	ds	;@031D0
	mov	ax, 39Dh	;@031D1
	push	ax	;@031D4
	call	far ptr _printf	;@031D5
	add	sp, 6	;@031DA
	jmp	short @@41	;@031DD
@@37:	cmp	word ptr [bp-2], 103h	;@031DF
	jne	@@38	;@031E4
	jmp	@@35	;@031E6
@@38:	cmp	word ptr [bp-2], 1Eh	;@031E9
	je	@@41	;@031ED
	mov	ax, word ptr [bp-2]	;@031EF
	and	ax, 0FF00h	;@031F2
	cmp	ax, 100h	;@031F5
	jne	@@39	;@031F8
	mov	ax, word ptr [bp-2]	;@031FA
	and	ax, 0FFh	;@031FD
	push	ax	;@03200
	push	ds	;@03201
	mov	ax, 3CEh	;@03202
	jmp	short @@40	;@03205
@@39:	push	word ptr [bp-2]	;@03207
	push	ds	;@0320A
	mov	ax, 3F3h	;@0320B
@@40:	push	ax	;@0320E
	call	far ptr _printf	;@0320F
	add	sp, 6	;@03214
	nosmart
	nosmart
	call	far ptr L0329C	;@03217
	smart
	smart
@@41:	call	far ptr L0526F	;@0321C
	mov	word ptr ds:[0ADAh], ax	;@03221
	cmp	word ptr ds:[9BCh], 0	;@03224
	jne	@@44	;@03229
	push	ds	;@0322B
	mov	ax, 0A3h	;@0322C
	push	ax	;@0322F
	call	far ptr _searchpath	;@03230
	pop	cx	;@03235
	pop	cx	;@03236
	mov	word ptr ds:[9C6h], dx	;@03237
	mov	word ptr ds:[9C4h], ax	;@0323B
	or	ax, word ptr ds:[9C6h]	;@0323E
	jne	@@42	;@03242
	push	ds	;@03244
	mov	ax, 0A3h	;@03245
	push	ax	;@03248
	push	ds	;@03249
	mov	ax, 21Eh	;@0324A
	jmp	short @@43	;@0324D
@@42:	xor	ax, ax	;@0324F
	xor	dx, dx	;@03251
	push	ax	;@03253
	push	dx	;@03254
	push	ds	;@03255
	mov	ax, 410h	;@03256
	push	ax	;@03259
	push	word ptr ds:[9C6h]	;@0325A
	push	word ptr ds:[9C4h]	;@0325E
	push	word ptr ds:[9C6h]	;@03262
	push	word ptr ds:[9C4h]	;@03266
	xor	ax, ax	;@0326A
	push	ax	;@0326C
	call	far ptr _spawnlp	;@0326D
	add	sp, 12h	;@03272
	cmp	ax, 0FFFFh	;@03275
	jne	@@44	;@03278
	push	ds	;@0327A
	mov	ax, 0A3h	;@0327B
	push	ax	;@0327E
	push	ds	;@0327F
	mov	ax, 418h	;@03280
@@43:	push	ax	;@03283
	call	far ptr _printf	;@03284
	add	sp, 8	;@03289
@@44:	xor	ax, ax	;@0328C
	push	ax	;@0328E
	call	far ptr L054E5	;@0328F
	pop	cx	;@03294
	mov	ax, word ptr ds:[0ADAh]	;@03295
	mov	sp, bp	;@03298
	pop	bp	;@0329A
	retf	;@0329B
L0329C:	push	bp	;@0329C
	mov	bp, sp	;@0329D
	cmp	word ptr ds:[718h], sp	;@0329F
	ja	@@1	;@032A3
	call	far ptr OVERFLOW@	;@032A5
@@1:	push	word ptr ds:[822h]	;@032AA
	push	word ptr ds:[838h]	;@032AE
	push	ds	;@032B2
	mov	ax, 433h	;@032B3
	push	ax	;@032B6
	call	far ptr _printf	;@032B7
	add	sp, 8	;@032BC
	pop	bp	;@032BF
L032C0:	retf	;@032C0
S2BF	ends
	end
