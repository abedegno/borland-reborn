; /* target: CODE_2_RG2BREST */
; /* opts: /ml */
;
; CODE_2:3F88..45D6, hand-written assembly: the overlay manager's EMS and
; extended-memory support (its data in __OVRGROUP's segment, BCC_SEG_46),
; part of the same library as OVRMGR (OVERLAY.LIB-like; BANKINIT calls the
; set-ups in EMSBANK/EXTBANK).  It includes the switch stubs at 4576..45D6
; that the old layout split off as R4EB6 and RG2C.
;
;   3F88  EMM_NAME 'EMMXXXX0'
;   3F91  DETECT_EMS: detect EMS (device, status, version 3.2+, frame,
;         free pages); returns the free page count
;   4043  ALLOCATE_EMS_PAGES(handle, first, pages): handle 0 allocates; saves and
;         restores the page map; 0 = OK
;   40A8  free our EMS handle
;   40D2  DETECT_EXTENDED_MEMORY: detect extended memory (286+, not OS/2, machine model
;         byte; XMS 2.0+, else int 15h/88h with VDISK checks at 1M and the
;         int 19h vector); sets start and end, returns the bytes free
;   4282  CLAIM_EXTENDED_MEMORY(base, size): claim it (XMS allocate and lock, or a
;         VDISK header plus an int 19h hook)
;   435A  release extended memory
;   43AE  move SI bytes from DX:AX to CX:BX (linear) by XMS function 0Bh or
;         int 15h/87h; carry set on error
;   445B, 445C  empty retf stubs
;   445D  callback-table segment and its CS copy
;   4461  RH_DISPATCH_NODE: calls far table[node->field18]
;   447C  register a far callback and return its index (up to 64)
;   4547/455E  shims into CHANGE_HEAP_NODE_MODE(mode, mask, ptr[, size])
;   4576..45D1  mode stubs (4576 RESIZE_POOL_BLOCK: 1000h; 4592: 8)
DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		extrn	CHANGE_HEAP_NODE_MODE:far
		extrn	POOL_INIT:far
		extrn	FREE_HANDLE_BLOCK:far
		extrn	BCC_SEG_50:far
		.186
CODE2		segment byte public 'CODE'
		assume	cs:CODE2
		extrn	__OVRGROUP:word
		extrn	HEAP_PROGRAM_DS:word
		public	DETECT_EMS
		public	ALLOCATE_EMS_PAGES
		public	FREE_EMS_HANDLE
		public	DETECT_EXTENDED_MEMORY
		public	CLAIM_EXTENDED_MEMORY
		public	OVR_RELEASE_EXT_MEMORY
		public	MOVE_EXTENDED_MEMORY
		public	RH_DISPATCH_NODE
		public	REGISTER_FAR_CALLBACK
		public	RESIZE_POOL_BLOCK
		public	FIX_HEAP_NODE_LOW
		public	CALLBACK_TABLE_SEG
EMM_NAME	db	'EMMXXXX0',0		; 3F88
DETECT_EMS:
		push	bp		; 3F91
		mov	bp, sp		; 3F92
		sub	sp, 102h		; 3F94
		push	ds		; 3F98
		mov	ds, word ptr cs:__OVRGROUP		; 3F99
		push	si		; 3F9E
		push	di		; 3F9F
		test	byte ptr ds:[28h], 1		; 3FA0
		je	L3FB7		; 3FA5
		test	byte ptr ds:[28h], 2		; 3FA7
		jne	L3FB1		; 3FAC
		jmp	L401F		; 3FAE
L3FB1:
		mov	ax, word ptr ds:[26h]		; 3FB1
		jmp	L403C		; 3FB4
L3FB7:
		push	ds		; 3FB7
		push	cs		; 3FB8
		pop	ds		; 3FB9
		mov	dx, offset EMM_NAME		; 3FBA
		mov	ax, 3D00h		; 3FBD
		int	21h		; 3FC0
		pop	ds		; 3FC2
		mov	bx, ax		; 3FC3
		jb	L3FE9		; 3FC5
		mov	ax, 4400h		; 3FC7
		int	21h		; 3FCA
		jb	L3FE5		; 3FCC
		test	dx, 80h		; 3FCE
		je	L3FE5		; 3FD2
		mov	ax, 4407h		; 3FD4
		int	21h		; 3FD7
		jb	L3FE5		; 3FD9
		push	ax		; 3FDB
		mov	ah, 3Eh		; 3FDC
		int	21h		; 3FDE
		pop	ax		; 3FE0
		cmp	al, 0FFh		; 3FE1
		je	L3FEC		; 3FE3
L3FE5:
		mov	ah, 3Eh		; 3FE5
		int	21h		; 3FE7
L3FE9:
		jmp	L4035		; 3FE9
L3FEC:
		mov	ax, 3567h		; 3FEC
		int	21h		; 3FEF
		mov	ax, es		; 3FF1
		or	ax, bx		; 3FF3
		je	L3FE9		; 3FF5
		mov	ah, 40h		; 3FF7
		int	67h		; 3FF9
		or	ah, ah		; 3FFB
		jne	L3FE9		; 3FFD
		mov	byte ptr ds:[28h], 1		; 3FFF
		mov	ah, 46h		; 4004
		int	67h		; 4006
		or	ah, ah		; 4008
		jne	L3FE9		; 400A
		cmp	al, 32h		; 400C
		jb	L3FE9		; 400E
		mov	byte ptr ds:[29h], al		; 4010
		mov	ah, 41h		; 4013
		int	67h		; 4015
		or	ah, ah		; 4017
		jne	L3FE9		; 4019
		mov	word ptr ds:[20h], bx		; 401B
L401F:
		mov	ah, 42h		; 401F
		int	67h		; 4021
		or	ah, ah		; 4023
		jne	L4035		; 4025
		mov	word ptr ds:[26h], bx		; 4027
		mov	word ptr ds:[22h], 0FFFFh		; 402B
		mov	ax, bx		; 4031
		jmp	short L403C		; 4033
L4035:
		xor	ax, ax		; 4035
		mov	byte ptr ds:[28h], 0		; 4037
L403C:
		pop	di		; 403C
		pop	si		; 403D
		pop	ds		; 403E
		mov	sp, bp		; 403F
		pop	bp		; 4041
		retf		; 4042
ALLOCATE_EMS_PAGES:
		push	bp		; 4043
		mov	bp, sp		; 4044
		push	ds		; 4046
		mov	ds, word ptr cs:__OVRGROUP		; 4047
		test	byte ptr ds:[28h], 1		; 404C
		jne	L4056		; 4051
		jmp	L40A0		; 4053
L4056:
		test	byte ptr ds:[28h], 2		; 4056
		je	L4062		; 405B
		xor	ax, ax		; 405D
		jmp	L40A3		; 405F
L4062:
		or	byte ptr ds:[28h], 2		; 4062
		mov	ax, word ptr [bp+8]		; 4067
		mov	word ptr ds:[24h], ax		; 406A
		mov	bx, word ptr [bp+6]		; 406D
		mov	word ptr ds:[26h], bx		; 4070
		mov	dx, word ptr [bp+0Ah]		; 4074
		or	dx, dx		; 4077
		jne	L4088		; 4079
		mov	ah, 43h		; 407B
		int	67h		; 407D
		or	ah, ah		; 407F
		jne	L40A0		; 4081
		or	byte ptr ds:[28h], 4		; 4083
L4088:
		mov	word ptr ds:[22h], dx		; 4088
		mov	ah, 47h		; 408C
		int	67h		; 408E
		or	ah, ah		; 4090
		jne	L40A0		; 4092
		mov	dx, word ptr ds:[22h]		; 4094
		mov	ah, 48h		; 4098
		int	67h		; 409A
		mov	al, ah		; 409C
		jmp	short L40A3		; 409E
L40A0:
		mov	ax, 0FFFFh		; 40A0
L40A3:
		pop	ds		; 40A3
		pop	bp		; 40A4
		retf	6		; 40A5
FREE_EMS_HANDLE:
		push	bp		; 40A8
		mov	bp, sp		; 40A9
		push	ds		; 40AB
		mov	ds, word ptr cs:__OVRGROUP		; 40AC
		test	byte ptr ds:[28h], 4		; 40B1
		je	L40CF		; 40B6
		mov	dx, word ptr ds:[22h]		; 40B8
		or	dx, dx		; 40BC
		js	L40CF		; 40BE
		mov	ah, 45h		; 40C0
		int	67h		; 40C2
		mov	word ptr ds:[22h], 0FFFFh		; 40C4
		mov	byte ptr ds:[28h], 0		; 40CA
L40CF:
		pop	ds		; 40CF
		pop	bp		; 40D0
		retf		; 40D1
DETECT_EXTENDED_MEMORY:
		push	bp		; 40D2
		mov	bp, sp		; 40D3
		sub	sp, 22h		; 40D5
		push	ds		; 40D8
		mov	ds, word ptr cs:__OVRGROUP		; 40D9
		push	si		; 40DE
		push	di		; 40DF
		test	byte ptr ds:[32h], 1		; 40E0
		je	L40F1		; 40E5
		test	byte ptr ds:[32h], 2		; 40E7
		je	L40F6		; 40EC
		jmp	L4267		; 40EE
L40F1:
		mov	byte ptr ds:[32h], 1		; 40F1
L40F6:
		mov	word ptr ds:[2Ah], 0		; 40F6
		mov	word ptr ds:[2Ch], 10h		; 40FC
		mov	word ptr ds:[2Eh], 0		; 4102
		mov	word ptr ds:[30h], 10h		; 4108
		push	sp		; 410E
		pop	ax		; 410F
		cmp	ax, sp		; 4110
		jne	L411C		; 4112
		mov	ah, 30h		; 4114
		int	21h		; 4116
		cmp	al, 0Ah		; 4118
		jb	L411F		; 411A
L411C:
		jmp	L4278		; 411C
L411F:
		xchg	al, ah		; 411F
		mov	word ptr [bp-22h], ax		; 4121
		mov	ax, 0F000h		; 4124
		mov	es, ax		; 4127
		mov	al, byte ptr es:[0FFFEh]		; 4129
		cmp	al, 0FCh		; 412D
		ja	L411C		; 412F
		cmp	al, 0FBh		; 4131
		je	L411C		; 4133
		cmp	al, 0F9h		; 4135
		je	L411C		; 4137
		cmp	word ptr [bp-22h], 31h		; 4139
		jae	L4142		; 413D
L413F:
		jmp	L41C1		; 413F
L4142:
		mov	ax, 4300h		; 4142
		int	2Fh		; 4145
		cmp	al, 80h		; 4147
		jne	L413F		; 4149
		mov	ax, 4310h		; 414B
		int	2Fh		; 414E
		mov	word ptr ds:[33h], bx		; 4150
		mov	word ptr ds:[35h], es		; 4154
		xor	ax, ax		; 4158
		call	dword ptr ds:[33h]		; 415A
		cmp	ah, 2		; 415E
		jb	L41C1		; 4161
		mov	ah, 8		; 4163
		call	dword ptr ds:[33h]		; 4165
		or	ax, ax		; 4169
		je	L41BE		; 416B
		mov	si, ax		; 416D
		xchg	dx, ax		; 416F
		mov	ah, 9		; 4170
		call	dword ptr ds:[33h]		; 4172
		or	ax, ax		; 4176
		je	L41BE		; 4178
		mov	word ptr ds:[37h], dx		; 417A
		mov	ah, 0Ch		; 417E
		call	dword ptr ds:[33h]		; 4180
		or	ax, ax		; 4184
		je	L41A4		; 4186
		mov	word ptr ds:[2Ah], bx		; 4188
		mov	word ptr ds:[2Ch], dx		; 418C
		mov	ax, 400h		; 4190
		mul	si		; 4193
		add	ax, word ptr ds:[2Ah]		; 4195
		adc	dx, word ptr ds:[2Ch]		; 4199
		mov	word ptr ds:[2Eh], ax		; 419D
		mov	word ptr ds:[30h], dx		; 41A0
L41A4:
		mov	ah, 0Dh		; 41A4
		mov	dx, word ptr ds:[37h]		; 41A6
		call	dword ptr ds:[33h]		; 41AA
		mov	ah, 0Ah		; 41AE
		mov	dx, word ptr ds:[37h]		; 41B0
		call	dword ptr ds:[33h]		; 41B4
		mov	word ptr ds:[37h], 0		; 41B8
L41BE:
		jmp	L4267		; 41BE
L41C1:
		mov	ah, 88h		; 41C1
		int	15h		; 41C3
		or	ax, ax		; 41C5
		jne	L41CC		; 41C7
L41C9:
		jmp	L4278		; 41C9
L41CC:
		mov	dx, 400h		; 41CC
		mul	dx		; 41CF
		add	dl, 10h		; 41D1
		mov	word ptr ds:[2Eh], ax		; 41D4
		mov	word ptr ds:[30h], dx		; 41D7
		mov	cx, word ptr ds:[33h]		; 41DB
		or	cx, word ptr ds:[35h]		; 41DF
		jcxz	L41F0		; 41E3
		mov	byte ptr ds:[2Ch], 11h		; 41E5
		mov	word ptr ds:[2Ah], 0		; 41EA
L41F0:
		mov	ax, ss		; 41F0
		mov	dx, 10h		; 41F2
		mul	dx		; 41F5
		nosmart
		lea	bx, [bp-20h]		; 41F7
		smart
		xor	cx, cx		; 41FA
		add	bx, ax		; 41FC
		adc	cx, dx		; 41FE
		mov	ax, 0		; 4200
		mov	dx, 10h		; 4203
		mov	si, 20h		; 4206
		xor	di, di		; 4209
		call	MOVE_EXTENDED_MEMORY		; 420B
		jb	L41C9		; 420E
		nosmart
		lea	di, [bp-1Dh]		; 4210
		smart
		push	ss		; 4213
		pop	es		; 4214
		nosmart
		lea	si, ds:[0]		; 4215
		smart
		mov	cx, 5		; 4219
		cld		; 421C
		repe cmpsb		; 421D
		jne	L4231		; 421F
		mov	ax, word ptr [bp-15h]		; 4221
		mul	word ptr [bp-0Dh]		; 4224
		add	dl, 10h		; 4227
		mov	word ptr ds:[2Ah], ax		; 422A
		mov	byte ptr ds:[2Ch], dl		; 422D
L4231:
		xor	ax, ax		; 4231
		mov	es, ax		; 4233
		mov	es, word ptr es:[66h]		; 4235
		mov	di, 12h		; 423A
		nosmart
		lea	si, ds:[0]		; 423D
		smart
		mov	cx, 5		; 4241
		cld		; 4244
		repe cmpsb		; 4245
		jne	L4267		; 4247
		mov	ax, word ptr es:[2Ch]		; 4249
		mov	dl, byte ptr es:[2Eh]		; 424D
		cmp	dl, byte ptr ds:[2Ch]		; 4252
		jb	L4267		; 4256
		ja	L4260		; 4258
		cmp	ax, word ptr ds:[2Ah]		; 425A
		jbe	L4267		; 425E
L4260:
		mov	word ptr ds:[2Ah], ax		; 4260
		mov	byte ptr ds:[2Ch], dl		; 4263
L4267:
		mov	ax, word ptr ds:[2Eh]		; 4267
		mov	dx, word ptr ds:[30h]		; 426A
		sub	ax, word ptr ds:[2Ah]		; 426E
		sbb	dx, word ptr ds:[2Ch]		; 4272
		jmp	short L427B		; 4276
L4278:
		xor	ax, ax		; 4278
		cwd		; 427A
L427B:
		pop	di		; 427B
		pop	si		; 427C
		pop	ds		; 427D
		mov	sp, bp		; 427E
		pop	bp		; 4280
		retf		; 4281
CLAIM_EXTENDED_MEMORY:
		push	bp		; 4282
		mov	bp, sp		; 4283
		push	ds		; 4285
		mov	ds, word ptr cs:__OVRGROUP		; 4286
		push	si		; 428B
		push	di		; 428C
		test	byte ptr ds:[32h], 1		; 428D
		jne	L4297		; 4292
		jmp	L4350		; 4294
L4297:
		test	byte ptr ds:[32h], 2		; 4297
		je	L42A3		; 429C
		xor	ax, ax		; 429E
		jmp	L4353		; 42A0
L42A3:
		or	byte ptr ds:[32h], 2		; 42A3
		mov	ax, word ptr [bp+0Ah]		; 42A8
		mov	dx, word ptr [bp+0Ch]		; 42AB
		mov	si, word ptr [bp+6]		; 42AE
		mov	di, word ptr [bp+8]		; 42B1
		mov	bx, word ptr ds:[33h]		; 42B4
		or	bx, word ptr ds:[35h]		; 42B8
		je	L4301		; 42BC
		mov	ax, si		; 42BE
		mov	dx, di		; 42C0
		add	ax, 3FFh		; 42C2
		adc	dx, 0		; 42C5
		mov	bx, 400h		; 42C8
		div	bx		; 42CB
		xchg	dx, ax		; 42CD
		mov	ah, 9		; 42CE
		call	dword ptr ds:[33h]		; 42D0
		or	ax, ax		; 42D4
		je	L42FE		; 42D6
		mov	word ptr ds:[37h], dx		; 42D8
		mov	ah, 0Ch		; 42DC
		call	dword ptr ds:[33h]		; 42DE
		or	ax, ax		; 42E2
		je	L42FE		; 42E4
		mov	word ptr ds:[2Ah], bx		; 42E6
		mov	word ptr ds:[2Ch], dx		; 42EA
		mov	word ptr ds:[39h], bx		; 42EE
		mov	word ptr ds:[3Bh], dx		; 42F2
		mov	ax, bx		; 42F6
		add	ax, si		; 42F8
		adc	dx, di		; 42FA
		jmp	short L4345		; 42FC
L42FE:
		jmp	L4350		; 42FE
L4301:
		mov	word ptr ds:[2Ah], ax		; 4301
		mov	word ptr ds:[2Ch], dx		; 4304
		xor	bx, bx		; 4308
		mov	es, bx		; 430A
		push	ds		; 430C
		mov	bx,seg BCC_SEG_50		; 430D
		mov	ds, bx		; 4310
		mov	bx, word ptr es:[64h]		; 4312
		mov	word ptr ds:[2Fh], bx		; 4317
		mov	bx, word ptr es:[66h]		; 431B
		mov	word ptr ds:[31h], bx		; 4320
		mov	word ptr es:[64h], 3Fh		; 4324
		mov	word ptr es:[66h],seg BCC_SEG_50		; 432B
		mov	word ptr ds:[3Ah], ax		; 4332
		mov	byte ptr ds:[3Ch], dl		; 4335
		add	ax, si		; 4339
		adc	dx, di		; 433B
		mov	word ptr ds:[2Ch], ax		; 433D
		mov	byte ptr ds:[2Eh], dl		; 4340
		pop	ds		; 4344
L4345:
		mov	word ptr ds:[2Eh], ax		; 4345
		mov	word ptr ds:[30h], dx		; 4348
		xor	ax, ax		; 434C
		jmp	short L4353		; 434E
L4350:
		mov	ax, 0FFFFh		; 4350
L4353:
		pop	di		; 4353
		pop	si		; 4354
		pop	ds		; 4355
		pop	bp		; 4356
		retf	8		; 4357
OVR_RELEASE_EXT_MEMORY:
		push	bp		; 435A
		mov	bp, sp		; 435B
		push	ds		; 435D
		mov	ds, word ptr cs:__OVRGROUP		; 435E
		cmp	byte ptr ds:[32h], 0		; 4363
		je	L43AB		; 4368
		cmp	word ptr ds:[37h], 0		; 436A
		je	L4387		; 436F
		mov	ah, 0Dh		; 4371
		mov	dx, word ptr ds:[37h]		; 4373
		call	dword ptr ds:[33h]		; 4377
		mov	ah, 0Ah		; 437B
		mov	dx, word ptr ds:[37h]		; 437D
		call	dword ptr ds:[33h]		; 4381
		jmp	short L43AB		; 4385
L4387:
		xor	ax, ax		; 4387
		mov	es, ax		; 4389
		mov	ax, word ptr es:[66h]		; 438B
		cmp	ax,seg BCC_SEG_50		; 438F
		jne	L43AB		; 4392
		push	ds		; 4394
		mov	ds, ax		; 4395
		mov	ax, word ptr ds:[2Fh]		; 4397
		mov	word ptr es:[64h], ax		; 439A
		mov	ax, word ptr ds:[31h]		; 439E
		mov	word ptr es:[66h], ax		; 43A1
		pop	ds		; 43A5
		mov	byte ptr ds:[32h], 0		; 43A6
L43AB:
		pop	ds		; 43AB
		pop	bp		; 43AC
		retf		; 43AD
MOVE_EXTENDED_MEMORY:
		push	ds		; 43AE
		push	es		; 43AF
		add	si, 1		; 43B0
		adc	di, 0		; 43B3
		and	si, 0FFFEh		; 43B6
		cld		; 43B9
		mov	ds, word ptr cs:__OVRGROUP		; 43BA
		cmp	word ptr ds:[37h], 0		; 43BF
		je	L4430		; 43C4
		mov	word ptr ds:[3Dh], si		; 43C6
		mov	word ptr ds:[3Fh], di		; 43CA
		cmp	dl, 10h		; 43CE
		jb	L43E6		; 43D1
		mov	si, word ptr ds:[37h]		; 43D3
		mov	word ptr ds:[41h], si		; 43D7
		sub	ax, word ptr ds:[39h]		; 43DB
		sbb	dx, word ptr ds:[3Bh]		; 43DF
		jmp	L43EF		; 43E3
L43E6:
		mov	word ptr ds:[41h], 0		; 43E6
		ror	dx, 4		; 43EC
L43EF:
		mov	word ptr ds:[43h], ax		; 43EF
		mov	word ptr ds:[45h], dx		; 43F2
		cmp	cl, 10h		; 43F6
		jb	L440E		; 43F9
		mov	si, word ptr ds:[37h]		; 43FB
		mov	word ptr ds:[47h], si		; 43FF
		sub	bx, word ptr ds:[39h]		; 4403
		sbb	cx, word ptr ds:[3Bh]		; 4407
		jmp	L4417		; 440B
L440E:
		mov	word ptr ds:[47h], 0		; 440E
		ror	cx, 4		; 4414
L4417:
		mov	word ptr ds:[49h], bx		; 4417
		mov	word ptr ds:[4Bh], cx		; 441B
		mov	ah, 0Bh		; 441F
		nosmart
		lea	si, ds:[3Dh]		; 4421
		smart
		call	dword ptr ds:[33h]		; 4425
		or	ax, ax		; 4429
		jne	L4456		; 442B
		stc		; 442D
		jmp	short L4451		; 442E
L4430:
		shr	di, 1		; 4430
		rcr	si, 1		; 4432
		mov	word ptr ds:[4Fh], ax		; 4434
		mov	byte ptr ds:[51h], dl		; 4437
		mov	word ptr ds:[57h], bx		; 443B
		mov	byte ptr ds:[59h], cl		; 443F
		mov	cx, si		; 4443
		nosmart
		lea	si, ds:[3Dh]		; 4445
		smart
		push	ds		; 4449
		pop	es		; 444A
		mov	ah, 87h		; 444B
		int	15h		; 444D
		jae	L4456		; 444F
L4451:
		sbb	ax, ax		; 4451
		stc		; 4453
		jmp	short L4458		; 4454
L4456:
		xor	ax, ax		; 4456
L4458:
		pop	es		; 4458
		pop	ds		; 4459
		ret		; 445A
		retf		; 445B: empty far stub
		retf		; 445C: empty far stub
CALLBACK_TABLE_SEG	dw	0		; 445D: segment of the callback table (447C)
CALLBACK_TABLE_PTR_SEG	dw	0		; 445F: CS, stored at start-up (HEAPMAIN 332C), so
					; cs:445D can be passed as a far pointer
RH_DISPATCH_NODE:
		pop	ax		; 4461
		mov	bx, sp		; 4462
		xchg	word ptr ss:[bx+8], ax		; 4464
		mov	bx, ax		; 4468
		mov	bl, byte ptr [bx+12h]		; 446A
		xor	bh, bh		; 446D
		shl	bx, 1		; 446F
		shl	bx, 1		; 4471
		mov	es, word ptr cs:CALLBACK_TABLE_SEG		; 4473
		call	dword ptr es:[bx]		; 4478
		ret		; 447B
REGISTER_FAR_CALLBACK:
		push	bp		; 447C
		mov	bp, sp		; 447D
		push	ds		; 447F
		mov	ds, word ptr cs:__OVRGROUP		; 4480
		mov	cx, word ptr cs:CALLBACK_TABLE_SEG		; 4485
		jcxz	L4506		; 448A
		mov	es, cx		; 448C
		mov	ax, word ptr [bp+4]		; 448E
		mov	dx, word ptr [bp+6]		; 4491
		mov	cx, word ptr ds:[12h]		; 4494
		shr	cx, 1		; 4498
		shr	cx, 1		; 449A
		xor	bx, bx		; 449C
L449E:
		cmp	word ptr es:[bx+2], dx		; 449E
		jne	L44A9		; 44A2
		cmp	word ptr es:[bx], ax		; 44A4
		je	L44FB		; 44A7
L44A9:
		add	bx, 4		; 44A9
		loop	L449E		; 44AC
		mov	bx, word ptr ds:[12h]		; 44AE
		cmp	bx, word ptr ds:[10h]		; 44B2
		jb	L44E0		; 44B6
		cmp	bx, 100h		; 44B8
		jb	L44C3		; 44BC
		xor	bx, bx		; 44BE
		jmp	L44FF		; 44C0
L44C3:
		mov	ax, 1000h		; 44C3
		push	ax		; 44C6
		push	ax		; 44C7
		push	word ptr cs:CALLBACK_TABLE_PTR_SEG		; 44C8
		mov	ax, offset CALLBACK_TABLE_SEG		; 44CD
		push	ax		; 44D0
		add	bx, 10h		; 44D1
		push	bx		; 44D4
		call	far ptr CHANGE_HEAP_NODE_MODE		; 44D5
		xor	bx, bx		; 44DA
		or	ax, ax		; 44DC
		jne	L44FF		; 44DE
L44E0:
		mov	es, word ptr cs:CALLBACK_TABLE_SEG		; 44E0
		mov	bx, word ptr ds:[12h]		; 44E5
		mov	ax, word ptr [bp+4]		; 44E9
		mov	word ptr es:[bx], ax		; 44EC
		mov	ax, word ptr [bp+6]		; 44EF
		mov	word ptr es:[bx+2], ax		; 44F2
		add	word ptr ds:[12h], 4		; 44F6
L44FB:
		shr	bx, 1		; 44FB
		shr	bx, 1		; 44FD
L44FF:
		mov	ax, bx		; 44FF
		pop	ds		; 4501
		pop	bp		; 4502
		ret	4		; 4503
L4506:
		mov	es, word ptr cs:HEAP_PROGRAM_DS		; 4506
		mov	al, byte ptr es:[6C0h]		; 450B
		push	ax		; 450F
		mov	byte ptr es:[6C0h], 0		; 4510
		push	word ptr cs:CALLBACK_TABLE_PTR_SEG		; 4516
		mov	ax, offset CALLBACK_TABLE_SEG		; 451B
		push	ax		; 451E
		mov	ax, 10h		; 451F
		push	ax		; 4522
		call	far ptr POOL_INIT		; 4523
		mov	es, word ptr cs:HEAP_PROGRAM_DS		; 4528
		pop	bx		; 452D
		mov	byte ptr es:[6C0h], bl		; 452E
		xor	bx, bx		; 4533
		or	ax, ax		; 4535
		jne	L44FF		; 4537
		mov	word ptr ds:[10h], 10h		; 4539
		mov	word ptr ds:[12h], 4		; 453F
		jmp	L44E0		; 4545
L4547:
		mov	bx, sp		; 4547
		xchg	word ptr ss:[bx+8], dx		; 4549
		xchg	word ptr ss:[bx+6], ax		; 454D
		pop	bx		; 4551
		pop	es		; 4552
		pop	cx		; 4553
		push	dx		; 4554
		push	ax		; 4555
		push	cx		; 4556
		push	es		; 4557
		push	bx		; 4558
		jmp	far ptr CHANGE_HEAP_NODE_MODE		; 4559
L455E:
		mov	bx, sp		; 455E
		xchg	word ptr ss:[bx+6], dx		; 4560
		xchg	word ptr ss:[bx+4], ax		; 4564
		pop	bx		; 4568
		pop	es		; 4569
		push	dx		; 456A
		push	ax		; 456B
		xor	cx, cx		; 456C
		push	cx		; 456E
		push	es		; 456F
		push	bx		; 4570
		jmp	far ptr CHANGE_HEAP_NODE_MODE		; 4571
RESIZE_POOL_BLOCK:
		mov	dx, 1000h		; 4576
		mov	ax, dx		; 4579
		jmp	L4547		; 457B
		mov	dx, 20h		; 457D
		mov	ax, dx		; 4580
		jmp	L455E		; 4582
		xor	dx, dx		; 4584
		mov	ax, 20h		; 4586
		jmp	L455E		; 4589
		mov	dx, 2000h		; 458B
		mov	ax, dx		; 458E
		jmp	L455E		; 4590
FIX_HEAP_NODE_LOW:
		mov	dx, 8		; 4592
		mov	ax, dx		; 4595
		jmp	L455E		; 4597
		mov	dx, 10h		; 4599
		mov	ax, dx		; 459C
		jmp	L455E		; 459E
		xor	dx, dx		; 45A0
		mov	ax, 18h		; 45A2
		jmp	L455E		; 45A5
		mov	dx, 808h		; 45A7
		mov	ax, dx		; 45AA
		jmp	L4547		; 45AC
		mov	dx, 810h		; 45AE
		mov	ax, dx		; 45B1
		jmp	L4547		; 45B3
		mov	dx, 2008h		; 45B5
		mov	ax, dx		; 45B8
		jmp	L455E		; 45BA
		mov	dx, 40h		; 45BC
		mov	ax, dx		; 45BF
		jmp	L455E		; 45C1
		mov	dx, 60h		; 45C3
		mov	ax, dx		; 45C6
		jmp	L455E		; 45C8
		xor	dx, dx		; 45CA
		mov	ax, 40h		; 45CC
		jmp	L455E		; 45CF
		jmp	far ptr FREE_HANDLE_BLOCK		; 45D1

CODE2		ends
		end
