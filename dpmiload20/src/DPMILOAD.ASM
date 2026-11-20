; DPMILOAD.ASM: the DPMI Loader 1.000 of Borland C++ 2.0 (DPMILOAD.EXE). It runs under a
; DPMI host and loads a protected-mode program linked by TLINK /2 (BCCX, TLINKX), loading its
; segments on demand through the segment-not-present exception (exc0bhandler), and hooks
; INT 21h (to catch the program's exit) and INT 2Fh. DPMILOAD.EXE keeps no symbols: names
; like L00894 are linear addresses in the image, v_0016 offsets in _DATA.
;
; It refers to __SEGTABLE__, so TLINK writes the segment table (FBOV) into the program.
; The two far jumps at int2fhook and int21hook hold the old vectors, saved through a data
; alias of the code segment (the [17Eh], [180h], [2C2h], [2C4h] below).

	.286
	extrn	__SEGTABLE__:far
_TEXT	segment byte public 'CODE'
_TEXT	ends
_DATA	segment byte public 'DATA'
_DATA	ends
_STACK	segment byte stack 'STACK'
_STACK	ends

_TEXT	segment byte public 'CODE'
	assume	cs:_TEXT,ds:_DATA
	db	13, 10, 45h, 58h, 43h, 45h, 50h, 54h, 49h, 4Fh, 4Eh, 31h, 31h, 48h, 41h, 4Eh
	db	44h, 4Ch, 45h, 52h, 3Ah, 45h, 72h, 72h, 6Fh, 72h, 20h, 77h, 68h, 69h, 6Ch, 65h
	db	20h, 6Ch, 6Fh, 61h, 64h, 69h, 6Eh, 67h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h
	db	24h
start:	int	3
	mov	ax, ds
	mov	es, ax
	mov	bx, _DATA
	mov	ds, bx
	mov	bx, ss
	mov	cx, sp
	shr	cx, 4
	inc	cx
	add	bx, cx
	sub	bx, ax
	mov	ax, 4A00h
	int	21h
	jae	L00051
	jmp	L000E9
L00051:	call	dpmiinit
	jae	L00059
	jmp	L000DC
L00059:	mov	word ptr v_0002, cx
	mov	word ptr v_0004, dx
	mov	ax, 3
	int	31h
	jae	L0006B
	jmp	L000DC
L0006B:	mov	word ptr ds:[0], ax
	push	es
	mov	bl, 11
	mov	cx, cs
	mov	dx, 0F6h
	mov	ax, 203h
	int	31h
	jae	L00080
	jmp	L000DB
L00080:	push	ds
	mov	ax, 10
	mov	bx, cs
	int	31h
	jb	L000DA
	mov	ds, ax
	mov	bl, 2Fh
	mov	ax, 204h
	int	31h
	jb	L000DB
	mov	word ptr ds:[180h], cx
	mov	word ptr ds:[17Eh], dx
	mov	bl, 2Fh
	mov	cx, cs
	mov	dx, 178h
	mov	ax, 205h
	int	31h
	jb	L000DA
	mov	ax, 204h
	mov	bl, 21h
	int	31h
	jb	L000DA
	mov	word ptr ds:[2C4h], cx
	mov	word ptr ds:[2C2h], dx
	mov	ax, 1
	mov	bx, ds
	pop	ds
	int	31h
	jb	L000DA
	jb	L000DB
	mov	bl, 21h
	mov	cx, cs
	mov	dx, 2BCh
	mov	ax, 205h
	int	31h
	jb	L000DB
	pop	es
	jmp	L002FF
L000DA:	pop	ds
L000DB:	pop	es
L000DC:	mov	dx, offset s_INITIAL_Error_in
	mov	ax, 900h
	int	21h
	mov	ax, 4C00h
	int	21h
L000E9:	mov	dx, offset s_INITIAL_Shrink_Error
	mov	ax, 900h
	int	21h
	mov	ax, 4C00h
	int	21h
exc0bhandler:	push	bp
	mov	bp, sp
	push	ds
	push	es
	push	bx
	push	cx
	push	si
	push	di
	push	dx
	push	ax
	mov	bx, word ptr [bp+6]
	mov	ax, cs
	and	ax, 3
	or	bx, ax
	call	L009F5
	jb	L00167
	test	word ptr es:[si+4], 4
	je	L00123
	call	L0119B
	jb	L00152
	add	sp, 4
	jmp	L0015F
L00123:	push	ds
	mov	ax, es
	mov	ds, ax
	mov	dx, 58h
	mov	ax, 3D00h
	int	21h
	pop	ds
	jb	L00167
	mov	word ptr es:[56h], ax
	mov	dx, word ptr es:[si]
	call	L00BA6
	mov	word ptr es:[si+1Ah], cx
	mov	word ptr es:[si+1Ch], dx
	call	L00A19
	jb	L00167
	call	L00FC2
	jae	L0015D
	mov	ax, offset s_DLL_Initialization_E
L00152:	call	L006C3
	add	sp, 12h
	mov	ax, 4C00h
	int	21h
L0015D:	pop	ax
	pop	dx
L0015F:	pop	di
	pop	si
	pop	cx
	pop	bx
	pop	es
	pop	ds
	pop	bp
	retf
L00167:	mov	dx, 0
	mov	ax, 900h
	int	21h
	pop	es
	pop	ds
	popa
	pop	bp
	mov	ax, 4C00h
	int	21h
int2fhook:	cmp	ax, 0FB42h
	je	L00182
	db	0EAh	; jmp far 0000:0000, patched at run time
	dd	0
L00182:	push	ds
	push	ax
	push	bx
	mov	bx, _DATA
	mov	ax, 2
	int	31h
	pop	bx
	jae	L00193
	jmp	L002AD
L00193:	mov	ds, ax
	pop	ax
	cmp	bx, 1
	jne	L001B1
	mov	ax, 1
	mov	cx, word ptr ds:[0]
	mov	dx, word ptr v_0004
	mov	es, word ptr v_0444
	mov	bx, word ptr v_0446
	jmp	L002AB
L001B1:	cmp	bx, 2
	jne	L001CC
	push	es
	mov	ax, si
	mov	bx, di
	call	L007AA
	pop	es
	jb	L001C4
	jmp	L002AB
L001C4:	call	L006C3
	sub	ax, ax
	jmp	L002AB
L001CC:	cmp	bx, 3
	jne	L00206
	push	di
	push	es
	mov	ax, ds
	mov	es, ax
	mov	ax, 500h
	mov	di, 6
	int	31h
	pop	es
	jb	L001FB
	mov	dx, word ptr [di+2]
	mov	ax, word ptr [di]
	pop	di
	shr	dx, 1
	rcr	ax, 1
	shr	dx, 1
	rcr	ax, 1
	shr	dx, 1
	rcr	ax, 1
	shr	dx, 1
	rcr	ax, 1
	jmp	L002AB
L001FB:	mov	dx, offset s_INTERRUPT_2F_HOOKx
	mov	ax, 900h
	int	21h
	pop	di
	pop	ds
	iret
L00206:	cmp	bx, 4
	jne	L0022B
	pop	ax
	push	ax
	push	es
	pusha
	call	L0043E
	jb	L0021E
	popa
	mov	cx, es
	pop	es
	mov	ax, 0FB42h
	jmp	L002AB
L0021E:	call	L006C3
	popa
	pop	es
	mov	ax, 0FB42h
	xor	cx, cx
	jmp	L002AB
L0022B:	cmp	bx, 5
	jne	L0025D
	pop	ax
	push	ax
	push	es
	push	si
	push	ds
	mov	ds, ax
	mov	si, dx
	mov	es, cx
	call	L0110C
	pop	ds
	jb	L00252
	push	bx
	call	L01138
	mov	dx, bx
	pop	bx
	pop	si
	pop	es
	pop	ds
	push	ax
	mov	ax, 0FB42h
	jmp	L002AB
L00252:	pop	si
	pop	es
	mov	dx, 0FFFFh
	mov	ax, 0FB42h
	jmp	L002AB
L0025D:	cmp	bx, 6
	jne	L00277
	push	es
	push	bx
	mov	ax, dx
	mov	es, cx
	call	L01138
	mov	dx, bx
	pop	bx
	pop	es
	pop	ds
	push	ax
	mov	ax, 0FB42h
	jmp	L002AB
L00277:	cmp	bx, 7
	jne	L0028B
	push	es
	mov	es, cx
	pusha
	call	L010E0
	call	L00BB6
	popa
	pop	es
	jmp	L002AB
L0028B:	cmp	bx, 8
	jne	L002A8
	push	ax
	push	dx
	mov	ax, dx
	mov	dx, cx
	call	L00817
	pop	dx
	pop	ax
	jb	L002A0
	jmp	L002AB
L002A0:	call	L006C3
	sub	dx, dx
	jmp	L002AB
L002A8:	jmp	L002B0
L002AB:	pop	ds
	iret
L002AD:	pop	ax
	pop	ds
	iret
L002B0:	pusha
	mov	dx, offset s_INTERRUPT_2F_HOOK
	mov	ax, 900h
	int	21h
	popa
	jmp	short L002AB
int21hook:	cmp	ah, 4Ch
	je	L002C6
L002C1:	db	0EAh	; jmp far 0000:0000, patched at run time
	dd	0
L002C6:	push	ds
	push	es
	pusha
	mov	bx, _DATA
	mov	ax, 2
	int	31h
	jb	L002D8
	mov	ds, ax
	call	L010BF
L002D8:	mov	bl, 2Fh
	mov	cx, word ptr cs:[180h]
	mov	dx, word ptr cs:[17Eh]
	mov	ax, 205h
	int	31h
	mov	bl, 21h
	mov	cx, word ptr cs:[2C4h]
	mov	dx, word ptr cs:[2C2h]
	mov	ax, 205h
	int	31h
	popa
	pop	es
	pop	ds
	jmp	short L002C1
L002FF:	mov	word ptr v_0442, es
	mov	dx, offset s_DPMI_Loader_Version
	mov	ax, 900h
	int	21h
	mov	word ptr v_0444, ds
	mov	ax, 477h
	mov	word ptr v_0446, ax
	mov	word ptr v_0475, ax
	call	L00378
	jb	L00355
	call	L0043E
	jb	L00355
	push	es
	call	L003E6
	pop	es
	mov	ax, word ptr es:[16h]
	call	L00C36
	mov	word ptr es:[16h], ax
	call	L0040B
	jb	L00341
	push	ds
	mov	ds, ax
	pop	ds
	cli
	mov	ss, ax
	mov	sp, bx
	sti
L00341:	mov	ax, word ptr es:[16h]
	push	ax
	mov	ax, word ptr es:[14h]
	push	ax
	mov	ax, word ptr v_0442
	mov	ds, ax
	mov	es, ax
	retf
	sub	ax, ax
L00355:	call	L006C3
	mov	dx, offset s_Error_loading_proces
	mov	ax, 900h
	int	21h
	mov	ax, 4C00h
	int	21h
L00365:	mov	si, word ptr v_0475
	mov	word ptr [si], es
	inc	word ptr v_0475
	inc	word ptr v_0475
	inc	word ptr v_0473
	ret
L00378:	mov	es, word ptr v_0442
	mov	si, 81h
	mov	di, 418h
	sub	cx, cx
	mov	cl, byte ptr es:[80h]
	cmp	cx, 0
	je	L003E1
L0038E:	mov	al, byte ptr es:[si]
	cmp	al, 20h
	jne	L0039E
	inc	si
	dec	cx
	cmp	cx, 0
	je	L003E1
	jmp	short L0038E
L0039E:	mov	al, byte ptr es:[si]
	cmp	al, 20h
	je	L003B3
	cmp	al, 2Eh
	jne	L003AD
	inc	word ptr v_044E
L003AD:	mov	byte ptr [di], al
	inc	di
	inc	si
	loop	L0039E
L003B3:	cmp	word ptr v_044E, 0
	jne	L003CA
	mov	byte ptr [di], 2Eh
	inc	di
	mov	byte ptr [di], 65h
	inc	di
	mov	byte ptr [di], 78h
	inc	di
	mov	byte ptr [di], 65h
	inc	di
L003CA:	mov	byte ptr [di], 0
	cmp	cx, 0
	je	L003DA
	mov	word ptr v_044A, si
	mov	word ptr v_044C, cx
L003DA:	mov	ax, ds
	mov	dx, 418h
	clc
	ret
L003E1:	mov	ax, offset s_Missing_filename
	stc
	ret
L003E6:	mov	es, word ptr v_0442
	mov	si, word ptr v_044A
	mov	di, 81h
	mov	cx, word ptr v_044C
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	byte ptr es:[80h], cl
	cmp	cx, 0
	je	L00409
	rep movsb
	mov	byte ptr [di], 13
L00409:	pop	ds
	ret
L0040B:	mov	ax, word ptr es:[1Ah]
	test	ax, ax
	je	L0043C
	push	ax
	call	L00C36
	mov	word ptr es:[1Ah], ax
	pop	ax
	mov	bx, word ptr es:[18h]
	test	bx, bx
	jne	L00436
	call	L00C91
	mov	bx, word ptr es:[12h]
	test	bx, bx
	jne	L00434
	mov	bx, 13E8h
L00434:	add	bx, ax
L00436:	mov	ax, word ptr es:[1Ah]
	clc
	ret
L0043C:	stc
	ret
L0043E:	push	ax
	push	dx
	push	ds
	mov	ds, ax
	mov	ax, 3D00h
	int	21h
	pop	ds
	jae	L0044E
	jmp	L004DB
L0044E:	mov	bx, ax
	push	bx
	call	L004E1
	pop	bx
	jae	L0045A
	jmp	L004D8
L0045A:	push	bx
	call	L004ED
	pop	bx
	jb	L004D8
	push	bx
	call	L0051E
	pop	bx
	jb	L004D8
	call	L00365
	mov	word ptr es:[56h], bx
	mov	ax, word ptr v_126A
	mov	word ptr es:[43h], ax
	pop	dx
	pop	ax
	mov	byte ptr es:[42h], 0
	mov	byte ptr es:[45h], 0
	mov	word ptr es:[40h], ds
	call	L0057C
	call	L00597
	call	L005B2
	jb	L004D7
	call	L005FF
	jb	L004D7
	call	L0067A
	jb	L004D7
	call	L0105D
	jb	L004D7
	call	L00B3F
	jb	L004D7
	call	L00FC2
	jae	L004C4
	mov	bx, word ptr es:[56h]
	mov	word ptr es:[56h], 0FFFFh
	mov	ax, 3E00h
	int	21h
	mov	ax, offset s_DLL_Initialization_E
	stc
	ret
L004C4:	mov	bx, word ptr es:[56h]
	mov	word ptr es:[56h], 0FFFFh
	mov	ax, 3E00h
	int	21h
	jb	L004DD
L004D7:	ret
L004D8:	pop	dx
	pop	dx
	ret
L004DB:	pop	ax
	pop	ax
L004DD:	sub	ax, ax
	stc
	ret
L004E1:	mov	cx, 2A8h
	mov	dx, 170h
	mov	ax, 3F00h
	int	21h
	ret
L004ED:	push	bx
	mov	cx, word ptr v_01AE
	mov	dx, word ptr v_01AC
	mov	word ptr v_0440, dx
	mov	ax, 4200h
	int	21h
	pop	bx
	jb	L00518
	mov	cx, 40h
	mov	dx, 0F0h
	mov	ax, 3F00h
	int	21h
	jb	L00518
	mov	ax, word ptr v_00F0
	cmp	ax, 454Eh
	jne	L00519
	clc
L00518:	ret
L00519:	mov	ax, offset s_Invalid_format_tlink
	stc
	ret
L0051E:	mov	bx, word ptr v_010C
	cmp	bx, 0
	je	L0056D
	mov	ax, word ptr v_010C
	mov	bx, 1Eh
	mul	bl
	mov	dx, word ptr v_0440
	add	dx, word ptr v_0114
	mov	cx, word ptr v_011C
	sub	cx, dx
	add	cx, word ptr v_0110
	add	cx, 80h
	add	cx, ax
	mov	word ptr v_0448, cx
	push	cx
	mov	bx, 1
	call	L00712
	pop	cx
	jb	L00572
	mov	si, ax
	mov	di, bx
	mov	ax, 0FB42h
	mov	bx, 2
	int	2Fh
	cmp	ax, 0
	je	L00577
	call	L00911
	mov	es, ax
	clc
	ret
L0056D:	mov	ax, offset s_JLOADER_CheckSegTabl
	stc
	ret
L00572:	mov	ax, offset s_Cannot_allocate_LDT
	stc
	ret
L00577:	mov	ax, offset s_Cannot_allocate_requ
	stc
	ret
L0057C:	push	ds
	mov	ds, ax
	mov	si, dx
	mov	di, 58h
L00584:	mov	al, byte ptr [si]
	cmp	al, 0
	je	L00591
	mov	byte ptr es:[di], al
	inc	si
	inc	di
	jmp	short L00584
L00591:	mov	byte ptr es:[di], 0
	pop	ds
	ret
L00597:	mov	si, 0F0h
	sub	di, di
	mov	cx, 40h
	shr	cx, 1
	rep movsw
	mov	word ptr es:[46h], 0
	mov	word ptr es:[48h], 80h
	ret
L005B2:	cmp	word ptr v_010C, 0
	je	L005F5
	mov	bx, word ptr es:[56h]
	sub	cx, cx
	mov	dx, word ptr v_0440
	add	dx, word ptr es:[22h]
	adc	cx, cx
	mov	ax, 4200h
	int	21h
	jb	L005F1
	mov	ax, word ptr v_010C
	mov	bx, 8
	mul	bl
	cmp	ax, 2A8h
	jg	L005FA
	mov	cx, ax
	mov	bx, word ptr es:[56h]
	mov	dx, 170h
	mov	ax, 3F00h
	int	21h
	jb	L005F1
	ret
L005F1:	sub	ax, ax
	stc
	ret
L005F5:	mov	ax, offset s_JLOADER_CheckSegTabl
	stc
	ret
L005FA:	mov	ax, offset s_Cannot_load_EXE
	stc
	ret
L005FF:	mov	di, word ptr es:[48h]
	mov	si, 170h
	mov	bx, word ptr es:[1Ch]
L0060C:	push	bx
	mov	bx, word ptr [si+4]
	call	L00712
	jae	L00618
	jmp	L00678
L00618:	mov	dx, word ptr [si]
	mov	word ptr es:[di], dx
	mov	dx, word ptr [si+2]
	mov	word ptr es:[di+2], dx
	mov	dx, word ptr [si+4]
	mov	word ptr es:[di+4], dx
	mov	dx, word ptr [si+6]
	mov	word ptr es:[di+6], dx
	mov	word ptr es:[di+10], ax
	mov	word ptr es:[di+12], bx
	mov	word ptr es:[di+8], cx
	test	byte ptr es:[di+4], 4
	je	L0064E
	push	si
	push	di
	pop	si
	call	L00A8E
	pop	si
	jb	L00678
L0064E:	add	si, 8
	add	di, 1Eh
	pop	bx
	dec	bx
	je	L0065A
	jmp	short L0060C
L0065A:	mov	ax, word ptr es:[1Ch]
	mov	bx, 1Eh
	mul	bl
	sub	di, word ptr es:[48h]
	cmp	ax, di
	jne	L00678
	add	di, word ptr es:[48h]
	mov	word ptr es:[4Ah], di
	clc
	ret
L00678:	stc
	ret
L0067A:	mov	di, word ptr es:[4Ah]
	call	L00E1C
	jb	L006BD
	mov	word ptr es:[4Ch], di
	call	L00E64
	jb	L006BD
	mov	word ptr es:[4Eh], di
	call	L00EAD
	jb	L006BD
	mov	word ptr es:[50h], di
	call	L00EF6
	jb	L006BD
	mov	word ptr es:[52h], di
	call	L00F80
	jb	L006BD
	mov	word ptr es:[54h], di
	call	L00F41
	jb	L006BD
	cmp	di, word ptr v_0448
	jne	L006BE
	clc
L006BD:	ret
L006BE:	mov	ax, offset s_JLOADER_Inconsistent
	stc
	ret
L006C3:	cmp	ax, 0
	je	L006CD
	mov	dx, ax
	jmp	L006FC
L006CD:	mov	ax, 5900h
	mov	bx, 0
	int	21h
	mov	di, 0A9Fh
	call	L00702
	mov	di, 0AB1h
	sub	ax, ax
	mov	al, bh
	call	L00702
	mov	di, 0AC8h
	sub	ax, ax
	mov	al, bl
	call	L00702
	mov	di, 0AD4h
	sub	ax, ax
	mov	al, ch
	call	L00702
	mov	dx, offset s_DOS_V3_30
L006FC:	mov	ax, 900h
	int	21h
	ret
L00702:	cmp	ax, 10
	jge	L0070D
	add	ax, 30h
	mov	word ptr [di], ax
	ret
L0070D:	mov	word ptr [di], 3939h
	ret
L00712:	test	bx, 1
	jne	L00756
	test	bx, 4
	je	L00724
	mov	cx, 3
	jmp	L00727
L00724:	mov	cx, 2
L00727:	mov	ax, 0
	int	31h
	jb	L00769
	mov	cx, 0FFFFh
	test	bx, 4
	je	L00742
	push	ax
	call	L00776
	jb	L0076E
	pop	cx
	add	ax, word ptr ds:[0]
L00742:	push	ax
	call	L00776
	jb	L0076E
	add	ax, word ptr ds:[0]
	call	L00790
	jb	L0076E
	mov	bx, ax
	pop	ax
	clc
	ret
L00756:	mov	cx, 1
	mov	ax, 0
	int	31h
	jb	L00769
	push	ax
	call	L00790
	jb	L0076E
	pop	bx
	clc
	ret
L00769:	mov	ax, offset s_DPMIALLOC_AllocateLD
	stc
	ret
L0076E:	add	sp, 2
	mov	ax, offset s_DPMIALLOC_AllocateLDx
	stc
	ret
L00776:	push	cx
	push	ax
	mov	bx, ax
	mov	cx, word ptr v_0AEA
	mov	ax, cs
	and	ax, 3
	shl	ax, 5
	or	cx, ax
	mov	ax, 9
	int	31h
	pop	ax
	pop	cx
	ret
L00790:	push	cx
	push	ax
	mov	bx, ax
	mov	cx, word ptr v_0AE8
	mov	ax, cs
	and	ax, 3
	shl	ax, 5
	or	cx, ax
	mov	ax, 9
	int	31h
	pop	ax
	pop	cx
	ret
L007AA:	push	ax
	push	bx
	sub	bx, bx
	mov	word ptr v_0AE0, bx
	mov	word ptr v_0AE2, cx
	test	dx, 4
	jne	L007E0
	mov	ax, 501h
	int	31h
	jb	L0080F
	mov	word ptr v_0AE4, bx
	mov	word ptr v_0AE6, cx
	pop	bx
	pop	ax
	push	si
	push	di
	call	L00834
	pop	di
	pop	si
	jb	L0080E
	mov	cx, word ptr v_0AE4
	mov	dx, word ptr v_0AE6
	clc
	ret
L007E0:	mov	ax, 100h
	mov	bx, cx
	shr	bx, 4
	inc	bx
	int	31h
	jb	L0080F
	mov	cx, ax
	mov	di, dx
	mov	bx, 4
	mul	bx
	mov	word ptr v_0AE4, dx
	mov	word ptr v_0AE6, ax
	pop	bx
	pop	ax
	push	cx
	push	di
	call	L00834
	pop	dx
	pop	cx
	jb	L0080E
	mov	si, 0FFFFh
	mov	di, si
	clc
L0080E:	ret
L0080F:	add	sp, 4
	mov	ax, offset s_xxxALLOC_AllocateMem
	stc
	ret
L00817:	test	dx, 4
	jne	L00825
	mov	ax, 502h
	int	31h
	jb	L0082F
	ret
L00825:	mov	dx, ax
	mov	ax, 101h
	int	31h
	jb	L0082F
	ret
L0082F:	mov	ax, offset s_xxxALLOC_DeallocateM
	stc
	ret
L00834:	push	bx
	push	ax
	mov	cx, word ptr v_0AE4
	mov	dx, word ptr v_0AE6
	mov	bx, ax
	mov	ax, 7
	int	31h
	pop	bx
	jb	L0088C
	mov	cx, word ptr v_0AE0
	mov	dx, word ptr v_0AE2
	mov	ax, 8
	push	bx
	int	31h
	pop	bx
	jb	L00886
	mov	ax, bx
	pop	bx
	cmp	ax, bx
	je	L00884
	mov	cx, word ptr v_0AE4
	mov	dx, word ptr v_0AE6
	push	ax
	push	bx
	mov	ax, 7
	int	31h
	pop	bx
	jb	L0088C
	mov	cx, word ptr v_0AE0
	mov	dx, word ptr v_0AE2
	mov	ax, 8
	push	bx
	int	31h
	pop	bx
	jb	L00886
	pop	ax
L00884:	clc
	ret
L00886:	mov	ax, offset s_DPMIALLOC_SetupLDT_S
	jmp	L0088F
L0088C:	mov	ax, offset s_DPMIALLOC_SetupLDT_Sx
L0088F:	add	sp, 2
	stc
	ret
dpmiinit:	mov	ax, 1687h
	int	2Fh
	cmp	ax, 0
	jne	L008C4
	mov	word ptr v_0AEE, es
	mov	word ptr v_0AEC, di
	test	si, si
	je	L008BB
	push	bx
	push	cx
	push	dx
	mov	bx, si
	mov	ax, 4800h
	int	21h
	pop	dx
	pop	cx
	pop	bx
	jb	L008CE
	mov	es, ax
L008BB:	xor	ax, ax
	call	dword ptr v_0AEC
	jb	L008D8
	ret
L008C4:	mov	dx, offset s_Error_getting_protec
	mov	ax, 900h
	int	21h
	stc
	ret
L008CE:	mov	dx, offset s_Error_allocating_mem
	mov	ax, 900h
	int	21h
	stc
	ret
L008D8:	mov	dx, offset s_Error_switching_to
	mov	ax, 900h
	int	21h
	stc
	ret
	db	13, 10, 44h, 50h, 4Dh, 49h, 4Ch, 44h, 54h, 3Ah, 47h, 65h, 74h, 53h, 65h, 67h
	db	6Dh, 65h, 6Eh, 74h, 49h, 6Eh, 66h, 6Fh, 3Ah, 44h, 50h, 4Dh, 49h, 47h, 65h, 74h
	db	41h, 64h, 64h, 72h, 65h, 73h, 73h, 20h, 46h, 61h, 69h, 6Ch, 65h, 64h, 24h
L00911:	mov	word ptr v_0B78, ax
	mov	word ptr v_0B7A, bx
	push	es
	push	si
	mov	bx, ax
	mov	ax, ds
	mov	es, ax
	mov	di, 0B70h
	mov	ax, 11
	int	31h
	jb	L00973
	mov	cx, word ptr v_0B75
	or	cx, 80h
	mov	bx, word ptr v_0B78
	mov	ax, 9
	int	31h
	jb	L00979
	mov	bx, word ptr v_0B7A
	cmp	bx, word ptr v_0B78
	je	L00968
	mov	ax, ds
	mov	es, ax
	mov	di, 0B70h
	mov	ax, 11
	int	31h
	jb	L00973
	mov	cx, word ptr v_0B75
	or	cx, 80h
	mov	ax, 9
	mov	bx, word ptr v_0B7A
	int	31h
	jb	L00979
L00968:	pop	si
	pop	es
	mov	ax, word ptr v_0B78
	mov	bx, word ptr v_0B7A
	clc
	ret
L00973:	mov	ax, offset s_DPMISETP_Cannot_get
	jmp	L0097C
L00979:	mov	ax, offset s_DPMISETP_Cannot_set
L0097C:	pop	si
	pop	es
	stc
	ret
L00980:	mov	word ptr v_0B78, ax
	mov	word ptr v_0B7A, bx
	push	es
	push	si
	mov	bx, ax
	mov	ax, ds
	mov	es, ax
	mov	di, 0B70h
	mov	ax, 11
	int	31h
	jb	L00973
	mov	cx, word ptr v_0B75
	xor	cx, 80h
	mov	bx, word ptr v_0B78
	mov	ax, 9
	int	31h
	jb	L00979
	mov	bx, word ptr v_0B7A
	cmp	bx, word ptr v_0B78
	je	L009D7
	mov	ax, ds
	mov	es, ax
	mov	di, 0B70h
	mov	ax, 11
	int	31h
	jb	L00973
	mov	cx, word ptr v_0B75
	xor	cx, 80h
	mov	ax, 9
	mov	bx, word ptr v_0B7A
	int	31h
	jb	L00979
L009D7:	pop	si
	pop	es
	mov	ax, word ptr v_0B78
	mov	bx, word ptr v_0B7A
	clc
	ret
L009E2:	push	bx
	mov	cx, es
	mov	dx, si
	mov	ax, 7
	int	31h
	pop	bx
	jb	L009F0
	ret
L009F0:	mov	ax, offset s_DPMILDT_SaveSegmentI
	stc
	ret
L009F5:	mov	ax, 6
	push	bx
	int	31h
	pop	bx
	jae	L00A01
	jmp	L00A0C
L00A01:	mov	es, cx
	mov	si, dx
	mov	ds, word ptr es:[40h]
	clc
	ret
L00A0C:	mov	dx, 8E2h
	mov	ax, 900h
	int	21h
	mov	ax, offset s_DPMILDT_GetSegmentIn
	stc
	ret
L00A19:	test	byte ptr es:[si+4], 4
	jne	L00A28
	call	L00A8E
	jae	L00A28
	jmp	L00A8B
L00A28:	cmp	word ptr es:[si+2], 0
	je	L00A80
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[si+1Ah]
	mov	dx, word ptr es:[si+1Ch]
	mov	ax, 4200h
	int	21h
	jb	L00A87
	mov	cx, word ptr es:[si+2]
	mov	bx, word ptr es:[56h]
	mov	dx, word ptr es:[si+12]
	test	byte ptr es:[si+4], 4
	je	L00A5B
	mov	dx, word ptr es:[si+12h]
L00A5B:	push	ds
	mov	ds, dx
	sub	dx, dx
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00A87
	call	L00B1C
	mov	ax, word ptr es:[si+4]
	and	ax, 100h
	je	L00A80
	push	si
	mov	bx, word ptr es:[56h]
	call	L00CA6
	pop	si
	jb	L00A8B
L00A80:	inc	byte ptr es:[45h]
	clc
	ret
L00A87:	sub	ax, ax
	stc
	ret
L00A8B:	pop	si
	pop	di
	ret
L00A8E:	push	di
	push	si
	push	es
	mov	dx, word ptr es:[si+4]
	mov	cx, word ptr es:[si+6]
	mov	di, word ptr es:[si+12]
	mov	si, word ptr es:[si+10]
	mov	ax, 0FB42h
	mov	bx, 2
	int	2Fh
	pop	es
	cmp	ax, 0
	je	L00B09
	push	si
	push	bp
	mov	bp, sp
	mov	si, word ptr [bp+4]
	test	word ptr es:[si+4], 4
	je	L00AE1
	mov	word ptr es:[si+14h], cx
	mov	word ptr es:[si+12h], dx
	mov	word ptr es:[si+14], 0FFFFh
	mov	word ptr es:[si+10h], 0FFFFh
	mov	word ptr es:[si+16h], 0FFFFh
	mov	word ptr es:[si+18h], 0FFFFh
	jmp	L00B00
L00AE1:	mov	word ptr es:[si+14], cx
	mov	word ptr es:[si+10h], dx
	mov	cx, word ptr [bp+2]
	mov	word ptr es:[si+16h], cx
	mov	word ptr es:[si+18h], di
	mov	word ptr es:[si+14h], 0FFFFh
	mov	word ptr es:[si+12h], 0FFFFh
L00B00:	pop	bp
	add	sp, 4
	call	L00911
	pop	di
	ret
L00B09:	pop	si
	pop	di
	ret
	sub	ax, ax
	mov	cx, word ptr es:[32h]
L00B13:	shl	dx, 1
	rcl	ax, 1
	loop	L00B13
	mov	cx, ax
	ret
L00B1C:	mov	cx, word ptr es:[si+6]
	sub	cx, word ptr es:[si+2]
	je	L00B3E
	push	es
	push	si
	mov	di, word ptr es:[si+2]
	mov	es, word ptr es:[si+12]
	sub	ax, ax
	clc
	shr	cx, 1
	je	L00B3B
	rep stosw
	jae	L00B3C
L00B3B:	stosb
L00B3C:	pop	si
	pop	es
L00B3E:	ret
L00B3F:	mov	bx, word ptr es:[1Ch]
	cmp	bx, 0
	jne	L00B4C
	jmp	L00B9C
L00B4C:	mov	si, 80h
L00B4F:	push	bx
	mov	dx, word ptr es:[si]
	call	L00BA6
	mov	word ptr es:[si+1Ah], cx
	mov	word ptr es:[si+1Ch], dx
	test	word ptr es:[si+4], 4
	je	L00B78
	test	word ptr es:[si+4], 1
	jne	L00B80
	mov	bx, word ptr es:[si+8]
	call	L009E2
	jmp	L00B80
L00B78:	test	word ptr es:[si+4], 40h
	je	L00B88
L00B80:	call	L00A19
	jb	L00BA1
	jmp	L00B91
L00B88:	mov	bx, word ptr es:[si+10]
	call	L009E2
	jb	L00B9B
L00B91:	add	si, 1Eh
	pop	bx
	dec	bx
	je	L00B9A
	jmp	short L00B4F
L00B9A:	clc
L00B9B:	ret
L00B9C:	mov	ax, offset s_JLOADER_CheckSegTabl
	stc
	ret
L00BA1:	mov	ax, offset s_JLOADER_Error_while
	stc
	ret
L00BA6:	sub	ax, ax
	mov	cx, word ptr es:[32h]
L00BAD:	shl	dx, 1
	rcl	ax, 1
	loop	L00BAD
	mov	cx, ax
	ret
L00BB6:	xor	cx, cx
	mov	cl, byte ptr es:[45h]
	cmp	cx, 0
	je	L00BD1
	mov	si, word ptr es:[48h]
L00BC7:	push	cx
	call	L00BD3
	pop	cx
	add	si, 1Eh
	loop	L00BC7
L00BD1:	clc
	ret
L00BD3:	mov	ax, word ptr es:[si+10]
	mov	bx, word ptr es:[si+12]
	call	L00980
	jb	L00C2F
	push	dx
	push	cx
	push	di
	push	ax
	push	bx
	push	si
	mov	dx, word ptr es:[si+12h]
	mov	cx, word ptr es:[si+4]
	mov	di, word ptr es:[si+18h]
	mov	ax, word ptr es:[si+16h]
	mov	word ptr es:[si+18h], 0FFFFh
	mov	word ptr es:[si+16h], 0FFFFh
	mov	word ptr es:[si+14], 0FFFFh
	mov	word ptr es:[si+10h], 0FFFh
	mov	word ptr es:[si+12h], 0FFFFh
	mov	word ptr es:[si+14h], 0FFFFh
	mov	si, ax
	mov	ax, 0FB42h
	mov	bx, 8
	int	2Fh
	pop	si
	pop	bx
	pop	ax
	pop	di
	pop	cx
	cmp	dx, 0
	je	L00C30
	pop	dx
L00C2F:	ret
L00C30:	pop	dx
	mov	ax, offset s_xxxALLOC_DeallocateM
	stc
	ret
L00C36:	dec	ax
	push	bx
	mov	bx, 1Eh
	imul	bl
	mov	bl, byte ptr es:[si+4]
	push	si
	mov	si, ax
	add	si, 80h
	mov	ax, word ptr es:[si+10]
	test	byte ptr es:[si+4], 4
	je	L00C6E
	test	byte ptr es:[si+4], 1
	jne	L00C61
	mov	ax, word ptr es:[si+8]
	jmp	L00C6E
L00C61:	mov	ax, word ptr es:[si+12h]
	test	bl, 4
	je	L00C6E
	mov	ax, word ptr es:[si+14h]
L00C6E:	pop	si
	pop	bx
	ret
	dec	ax
	push	bx
	mov	bx, 1Eh
	imul	bl
	pop	bx
	push	si
	mov	si, ax
	add	si, 80h
	mov	ax, word ptr es:[si+12]
	test	byte ptr es:[si+4], 4
	je	L00C8F
	mov	ax, word ptr es:[si+12h]
L00C8F:	pop	si
	ret
L00C91:	dec	ax
	push	bx
	mov	bx, 1Eh
	imul	bl
	pop	bx
	push	si
	mov	si, ax
	add	si, 80h
	mov	ax, word ptr es:[si+6]
	pop	si
	ret
L00CA6:	mov	word ptr v_123C, bx
	mov	cx, 2
	mov	dx, 1238h
	mov	ax, 3F00h
	int	21h
	jb	L00CDB
	mov	cx, word ptr v_1238
	cmp	cx, 0
	je	L00CD9
	mov	ax, 0F90h
	add	ax, 2A8h
	mov	word ptr v_123A, ax
L00CC9:	push	cx
	call	L00CDD
	jb	L00CDB
	call	L00D09
	pop	cx
	jb	L00CD8
	loop	L00CC9
	clc
L00CD8:	ret
L00CD9:	stc
	ret
L00CDB:	pop	cx
	ret
L00CDD:	mov	di, word ptr v_123A
	add	di, 8
	mov	dx, 0F90h
	add	dx, 2A8h
	cmp	di, dx
	jl	L00D03
	mov	bx, word ptr v_123C
	mov	cx, 2A8h
	mov	dx, 0F90h
	mov	ax, 3F00h
	int	21h
	jb	L00D08
	mov	di, 0F90h
L00D03:	mov	word ptr v_123A, di
	clc
L00D08:	ret
L00D09:	mov	cl, byte ptr [di+1]
	and	cl, 3
	cmp	cl, 0
	jne	L00D17
	jmp	L00DA5
L00D17:	cmp	cl, 1
	jne	L00D1F
	jmp	L00D40
L00D1F:	cmp	cl, 2
	jne	L00D27
	jmp	L00D68
L00D27:	cmp	cl, 3
	je	L00D31
	mov	ax, offset s_RELOCATE_FixIt_Inval
	stc
	ret
L00D31:	mov	bx, word ptr [di+4]
	dec	bx
	shl	bx, 1
	add	bx, 1240h
	mov	dx, word ptr [bx]
	jmp	L00DC2
L00D40:	push	es
	push	si
	mov	ax, word ptr [di+4]
	add	ax, word ptr es:[43h]
	shl	ax, 1
	mov	si, word ptr v_123E
	add	si, ax
	mov	es, word ptr [si]
	mov	ax, word ptr [di+6]
	call	L01138
	jb	L00D65
	mov	dx, ax
	mov	cx, bx
	pop	si
	pop	es
	jmp	L00DC2
L00D65:	pop	si
	pop	es
	ret
L00D68:	push	es
	push	si
	mov	si, word ptr es:[50h]
	add	si, word ptr [di+6]
	inc	si
	mov	ax, word ptr [di+4]
	add	ax, word ptr es:[43h]
	shl	ax, 1
	push	di
	mov	di, word ptr v_123E
	add	di, ax
	push	ds
	mov	ax, es
	mov	es, word ptr [di]
	mov	ds, ax
	call	L0110C
	pop	ds
	pop	di
	jb	L00D9E
	call	L01138
	mov	dx, ax
	mov	cx, bx
	pop	si
	pop	es
	jmp	L00DC2
L00D9E:	pop	si
	pop	es
	mov	ax, offset s_RELOCATE_FixIt_Unabl
	stc
	ret
L00DA5:	mov	ax, word ptr [di+4]
	cmp	ax, 0FFh
	jne	L00DBA
	mov	ax, word ptr [di+6]
	call	L01138
	mov	dx, ax
	mov	cx, bx
	jmp	L00DC2
L00DBA:	call	L00C36
	mov	dx, ax
	mov	cx, word ptr [di+6]
L00DC2:	mov	ax, word ptr es:[si+12]
	test	byte ptr es:[si+4], 4
	je	L00DD1
	mov	ax, word ptr es:[si+12h]
L00DD1:	mov	bx, word ptr [di+2]
	push	di
	push	ds
	test	byte ptr [di+1], 4
	je	L00DF2
	cmp	byte ptr [di], 3
	je	L00DE8
	mov	ds, ax
	add	word ptr [bx], dx
	jmp	L00E18
L00DE8:	mov	ds, ax
	add	word ptr [bx+2], dx
	add	word ptr [bx], cx
	jmp	L00E18
L00DF2:	cmp	byte ptr [di], 3
	je	L00E06
	mov	ds, ax
L00DF9:	mov	di, word ptr [bx]
	mov	word ptr [bx], dx
	cmp	di, -1
	je	L00E18
	mov	bx, di
	jmp	short L00DF9
L00E06:	mov	ds, ax
L00E08:	mov	di, word ptr [bx]
	mov	word ptr [bx+2], dx
	mov	word ptr [bx], cx
	cmp	di, -1
	je	L00E18
	mov	bx, di
	jmp	short L00E08
L00E18:	pop	ds
	pop	di
	clc
	ret
L00E1C:	mov	cx, word ptr es:[26h]
	cmp	cx, word ptr es:[24h]
	je	L00E61
	mov	bx, word ptr es:[56h]
	sub	cx, cx
	mov	dx, word ptr v_0440
	add	dx, word ptr es:[24h]
	adc	cx, cx
	mov	ax, 4200h
	int	21h
	jb	L00E63
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[26h]
	sub	cx, word ptr es:[24h]
	mov	dx, di
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00E63
	add	di, cx
L00E61:	clc
	ret
L00E63:	ret
L00E64:	mov	cx, word ptr es:[28h]
	cmp	cx, word ptr es:[26h]
	je	L00EA9
	mov	bx, word ptr es:[56h]
	sub	cx, cx
	mov	dx, word ptr v_0440
	add	dx, word ptr es:[26h]
	adc	cx, cx
	mov	ax, 4200h
	int	21h
	jb	L00EAB
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[28h]
	sub	cx, word ptr es:[26h]
	mov	dx, di
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00EAB
	add	di, cx
L00EA9:	clc
	ret
L00EAB:	stc
	ret
L00EAD:	mov	cx, word ptr es:[2Ah]
	cmp	cx, word ptr es:[28h]
	je	L00EF2
	mov	bx, word ptr es:[56h]
	sub	cx, cx
	mov	dx, word ptr v_0440
	add	dx, word ptr es:[28h]
	adc	cx, cx
	mov	ax, 4200h
	int	21h
	jb	L00EF4
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[2Ah]
	sub	cx, word ptr es:[28h]
	mov	dx, di
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00EF4
	add	di, cx
L00EF2:	clc
	ret
L00EF4:	stc
	ret
L00EF6:	mov	bx, word ptr es:[56h]
	sub	cx, cx
	mov	dx, word ptr v_0440
	add	dx, word ptr es:[2Ah]
	adc	cx, cx
	cmp	dx, word ptr es:[2Ch]
	jne	L00F16
	cmp	cx, word ptr es:[2Eh]
	je	L00F3D
L00F16:	mov	ax, 4200h
	int	21h
	jb	L00F3F
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[4]
	sub	cx, word ptr es:[2Ah]
	mov	dx, di
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00F3F
	add	di, cx
L00F3D:	clc
	ret
L00F3F:	stc
	ret
L00F41:	mov	cx, word ptr es:[20h]
	cmp	cx, 0
	je	L00F7C
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[2Eh]
	mov	dx, word ptr es:[2Ch]
	mov	ax, 4200h
	int	21h
	jb	L00F7E
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[20h]
	mov	dx, di
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00F7E
	add	di, cx
L00F7C:	clc
	ret
L00F7E:	stc
	ret
L00F80:	mov	cx, word ptr es:[6]
	cmp	cx, 0
	je	L00FBE
	mov	bx, word ptr es:[56h]
	sub	cx, cx
	mov	dx, word ptr v_0440
	add	dx, word ptr es:[4]
	adc	cx, cx
	mov	ax, 4200h
	int	21h
	jb	L00FC0
	mov	bx, word ptr es:[56h]
	mov	cx, word ptr es:[6]
	mov	dx, di
	push	ds
	mov	ax, es
	mov	ds, ax
	mov	ax, 3F00h
	int	21h
	pop	ds
	jb	L00FC0
	add	di, cx
L00FBE:	clc
	ret
L00FC0:	stc
	ret
L00FC2:	test	word ptr es:[12], 8000h
	je	L01005
	cmp	byte ptr es:[42h], 0
	jne	L01005
	cmp	byte ptr es:[45h], 0
	je	L01005
	mov	ax, word ptr es:[16h]
	cmp	ax, 0
	je	L01005
	push	ds
	push	es
	push	si
	call	L00C36
	inc	byte ptr es:[42h]
	push	ax
	push	word ptr es:[14h]
	mov	bp, sp
	call	dword ptr [bp]
	add	sp, 4
	pop	si
	pop	es
	pop	ds
	cmp	ax, 1
	jne	L01007
L01005:	clc
	ret
L01007:	pusha
	mov	byte ptr es:[42h], 0
	call	L01033
	mov	di, 127Eh
	mov	si, 58h
L01017:	mov	al, byte ptr es:[si]
	cmp	al, 0
	je	L01024
	mov	byte ptr [di], al
	inc	si
	inc	di
	jmp	short L01017
L01024:	mov	byte ptr [di], 24h
	mov	ax, offset s_Error_code
	call	L006C3
	popa
	mov	ax, offset s_DLL_Initialization_E
	stc
	ret
L01033:	pusha
	mov	word ptr v_12A6, ax
	mov	di, 1279h
	mov	cx, 4
L0103D:	mov	ax, word ptr v_12A6
	and	ax, 15
	add	ax, 30h
	cmp	ax, 39h
	jle	L0104E
	add	ax, 7
L0104E:	mov	dx, ax
	mov	byte ptr [di+3], dl
	shr	word ptr v_12A6, 4
	dec	di
	loop	L0103D
	popa
	ret
L0105D:	mov	cx, word ptr es:[2Ah]
	sub	cx, word ptr es:[28h]
	cmp	cx, 0
	je	L010B9
	shr	cx, 1
	mov	si, word ptr es:[4Eh]
	inc	word ptr v_126A
L01077:	push	cx
	push	si
	mov	ax, word ptr es:[si]
	mov	si, word ptr es:[50h]
	add	si, ax
	sub	cx, cx
	mov	cl, byte ptr es:[si]
	inc	si
	mov	di, 418h
L0108C:	mov	al, byte ptr es:[si]
	mov	byte ptr [di], al
	inc	di
	inc	si
	loop	L0108C
	mov	si, 1263h
	mov	cx, 5
	push	es
	mov	ax, ds
	mov	es, ax
	rep movsb
	pop	es
	push	es
	mov	ax, ds
	mov	dx, 418h
	call	L0043E
	pop	es
	jb	L010BB
	pop	si
	inc	si
	inc	si
	pop	cx
	loop	L01077
	dec	word ptr v_126A
L010B9:	clc
	ret
L010BB:	pop	si
	pop	cx
	stc
	ret
L010BF:	mov	cx, word ptr v_0473
	cmp	cx, 0
	je	L010DE
	mov	si, word ptr v_1268
L010CC:	mov	es, word ptr [si]
	test	word ptr es:[12], 8000h
	je	L010DA
	call	L010E0
L010DA:	inc	si
	inc	si
	loop	L010CC
L010DE:	clc
	ret
L010E0:	cmp	byte ptr es:[42h], 0
	je	L0110B
	push	si
	push	cx
	mov	si, offset s_WEP_DLL
	call	L0110C
	jb	L01109
	call	L01138
	push	es
	push	ds
	push	ax
	push	bx
	mov	bp, sp
	call	dword ptr [bp]
	add	sp, 4
	pop	ds
	pop	es
	mov	byte ptr es:[42h], 0
L01109:	pop	cx
	pop	si
L0110B:	ret
L0110C:	push	di
	push	cx
	mov	di, word ptr es:[4Ch]
L01113:	push	si
	sub	cx, cx
	mov	cl, byte ptr es:[di]
	cmp	cx, 0
	je	L01133
	inc	di
	repe cmpsb
	je	L0112B
	add	di, cx
	add	di, 2
	pop	si
	jmp	short L01113
L0112B:	mov	ax, word ptr es:[di]
	pop	si
	pop	cx
	pop	di
	clc
	ret
L01133:	pop	si
	pop	cx
	pop	di
	stc
	ret
L01138:	push	cx
	push	dx
	push	si
	push	di
	and	ax, 0FFh
	cmp	ax, 0
	je	L0118F
	mov	si, word ptr es:[52h]
	mov	dx, 1
	xor	cx, cx
L0114E:	mov	cl, byte ptr es:[si]
	cmp	cx, 0
	je	L0118F
	inc	si
	mov	di, si
	inc	si
	mov	bx, 3
	cmp	byte ptr es:[di], 0FFh
	jne	L01166
	add	bx, 3
L01166:	cmp	ax, dx
	je	L01171
	add	si, bx
	inc	dx
	loop	L01166
	jmp	short L0114E
L01171:	xor	ax, ax
	mov	al, byte ptr es:[di]
	mov	bx, word ptr es:[si+1]
	cmp	al, 0FFh
	jne	L01186
	mov	al, byte ptr es:[si+3]
	mov	bx, word ptr es:[si+4]
L01186:	call	L00C36
	pop	di
	pop	si
	pop	dx
	pop	cx
	clc
	ret
L0118F:	pop	di
	pop	si
	pop	dx
	pop	cx
	mov	bx, 0FFFFh
	mov	ax, offset s_EXETABLES_ConvertOrd
	stc
	ret
L0119B:	mov	ax, word ptr es:[si+14h]
	push	es
	push	di
	push	si
	push	ds
	push	ds
	pop	es
	mov	di, 12B0h
	mov	word ptr es:[di+2Ch], ax
	lds	si, dword ptr [bp+8]
	cmp	byte ptr [si], 9Ah
	jne	L01201
	pop	ds
	pop	si
	push	bp
	mov	ax, ss
	mov	bx, word ptr [bp+10h]
	mov	bp, word ptr [bp+14]
	mov	ss, bx
	mov	cx, word ptr [bp]
	mov	bx, word ptr [bp+2]
	mov	ss, ax
	pop	bp
	push	cx
	call	L01207
	pop	cx
	jb	L011F2
	push	bx
	push	cx
	mov	cx, 2
	xor	bx, bx
	mov	ax, 301h
	int	31h
	jb	L011F8
	add	sp, 4
	mov	ax, word ptr es:[di+1Ch]
	mov	dx, word ptr es:[di+14h]
	add	word ptr [bp+8], 5
	clc
L011EF:	pop	di
	pop	es
	ret
L011F2:	mov	ax, offset s_EXCEPTION_11_HANDLER
	stc
	jmp	short L011EF
L011F8:	mov	ax, offset s_EXCEPTION_11_HANDLERx
	add	sp, 4
	stc
	jmp	short L011EF
L01201:	mov	ax, offset s_EXCEPTION_11_HANDER
	stc
	jmp	short L011EF
L01207:	mov	ax, 6
	int	31h
	jb	L0121F
	mov	ax, dx
	mov	dx, cx
	mov	bx, 10h
	div	bx
	cmp	dx, 0
	jne	L0121F
	mov	bx, ax
	clc
L0121F:	ret
_TEXT	ends

_DATA	segment byte public 'DATA'
	assume	cs:_DATA,ds:_DATA
	db	0, 0
v_0002	db	0, 0
v_0004	db	50 dup (0)
s_INITIAL_Error_in	db	13, 10, 'INITIAL: Error in loader initialization -- loading process terminated$'
s_INTERRUPT_2F_HOOK	db	13, 10, 'INTERRUPT_2F_HOOK: Invalid request code$'
s_INTERRUPT_2F_HOOKx	db	13, 10, 'INTERRUPT_2F_HOOK: Get Available Memory Error$'
s_INITIAL_Shrink_Error	db	13, 10, 'INITIAL: Shrink Error$'
v_00F0	db	28 dup (0)
v_010C	db	0, 0, 0, 0
v_0110	db	0, 0, 0, 0
v_0114	db	8 dup (0)
v_011C	db	144 dup (0)
v_01AC	db	0, 0
v_01AE	db	658 dup (0)
v_0440	db	0, 0
v_0442	db	0, 0
v_0444	db	0, 0
v_0446	db	0, 0
v_0448	db	0, 0
v_044A	db	0, 0
v_044C	db	0, 0
v_044E	db	0, 0
s_Error_loading_proces	db	13, 10, 'Error: loading process aborted', 13, 10, '$'
v_0473	db	0, 0
v_0475	db	82 dup (0)
s_DPMI_Loader_Version	db	13, 10, 'DPMI Loader Version 1.000 Copyright (c) 1991 Borland International', 13, 10, '$'
	db	20h, 24h, 2Ah, 24h, 2Ah, 24h, 2Ah, 5, 2, 0, 0
s_DPMI_LOADER	db	'DPMI LOADER', 0, 0
s_EXCEPTION_11_HANDLER	db	13, 10, 'EXCEPTION_11_HANDLER:PMtoRMCallTHUNK:ConvertDOSSelectorToDOSSegmentAddressError$'
s_EXCEPTION_11_HANDLERx	db	13, 10, 'EXCEPTION_11_HANDLER:PMtoRMCallTHUNK:DPMICallRealModeProcedureError$'
s_EXCEPTION_11_HANDER	db	13, 10, 'EXCEPTION_11_HANDER:PMtoRMCallTHUNK:InvalidTHUNKInstruction$'
s_EXETABLES_ConvertOrd	db	13, 10, 'EXETABLES:ConvertOrdNumToSelectorOffset:InvalidOrdinalNumber$'
s_xxxALLOC_AllocateMem	db	13, 10, 'xxxALLOC:AllocateMemory:MemoryAllocationError$'
s_xxxALLOC_DeallocateM	db	13, 10, 'xxxALLOC:DeallocateMemory:MemoryDeallocationError$'
s_DPMIALLOC_AllocateLD	db	13, 10, 'DPMIALLOC:AllocateLDT:GetLDTError$'
s_DPMIALLOC_AllocateLDx	db	13, 10, 'DPMIALLOC:AllocateLDT:SetLDTAccessError$'
s_DPMIALLOC_SetupLDT_S	db	13, 10, 'DPMIALLOC:SetupLDT:SetLDTLimitError$'
s_DPMIALLOC_SetupLDT_Sx	db	13, 10, 'DPMIALLOC:SetupLDT:SetLDTAddressError$'
s_DLL_Initialization_E	db	' -- DLL Initialization Error$'
s_RELOCATE_FixIt_Reloc	db	13, 10, 'RELOCATE:FixIt:Relocatable code has zero relocations$'
s_RELOCATE_FixIt_Unabl	db	13, 10, 'RELOCATE:FixIt:Unable to find imported name in resident name table$'
s_RELOCATE_FixIt_Inval	db	13, 10, 'RELOCATE:FixIt:Invalid Fix Up Type in relocation table$'
s_DPMILDT_SaveSegmentI	db	13, 10, 'DPMILDT:SaveSegmentInfo:Failed to set segment base address$'
s_DPMILDT_SaveSegmentIx	db	13, 10, 'DPMILDT:SaveSegmentInfo:Failed to set segment limit$'
s_DPMILDT_GetSegmentIn	db	13, 10, 'DPMILDT:GetSegmentInfo:Failed to get segment base address$'
s_Invalid_format_tlink	db	13, 10, 'Invalid format -- tlink with /2 option', 13, 10, '$'
s_Cannot_load_EXE	db	13, 10, 'Cannot load EXE file with more than 85 segments', 13, 10, '$'
s_JLOADER_CheckSegTabl	db	13, 10, 'JLOADER:CheckSegTableSpace: 0 segments in EXE file', 13, 10, '$'
s_Cannot_allocate_requ	db	13, 10, 'Cannot allocate required memory', 13, 10, '$'
s_Cannot_allocate_LDT	db	13, 10, 'Cannot allocate LDT', 13, 10, '$'
s_Missing_filename	db	13, 10, 'Missing filename', 13, 10, '$'
s_DPMISETP_Cannot_get	db	13, 10, 'DPMISETP: Cannot get descriptor', 13, 10, '$'
s_DPMISETP_Cannot_set	db	13, 10, 'DPMISETP: Cannot set descriptor access rights', 13, 10, '$'
s_JLOADER_Error_while	db	13, 10, 'JLOADER: Error while loading segment', 13, 10, '$'
s_JLOADER_Inconsistent	db	13, 10, 'JLOADER: Inconsistent Module Table size', 13, 10, '$'
s_DOS_V3_30	db	13, 10, 'DOS V3.30 Error (pp 6-42 thru 6-46/Technical Ref Manual', 13, 10, '  Extended Error Code ', 0, 0
s_Error_Class	db	13, 10, '  Error Class ', 0, 0
s_Suggested_Action	db	13, 10, '  Suggested Action ', 0, 0
s_Locus	db	13, 10, '  Locus ', 0
	db	0, 13, 10, 24h, 0, 0, 0, 0, 0, 0, 0
v_0AE0	db	0, 0
v_0AE2	db	0, 0
v_0AE4	db	0, 0
v_0AE6	db	0, 0
v_0AE8	db	12h, 0
v_0AEA	db	1Ah, 0
v_0AEC	db	0, 0
v_0AEE	db	0, 0
s_Error_getting_protec	db	13, 10, 'Error getting protected mode entry point$'
s_Error_allocating_mem	db	13, 10, 'Error allocating memory for DOS extender$'
s_Error_switching_to	db	13, 10, 'Error switching to protected mode$'
	db	11 dup (0)
v_0B75	db	0, 0, 0
v_0B78	db	0, 0
v_0B7A	db	822 dup (0)
s_LOADMODULE_DemandLoa	db	13, 10, 'LOADMODULE:DemandLoad Segment$'
s_LOADMODULE_Begin_Loa	db	13, 10, 'LOADMODULE:Begin Loading$'
s_LOADMODULE_Segment	db	13, 10, 'LOADMODULE:Segment ', 0
	db	0, 24h
	db	821 dup (0)
v_1238	db	0, 0
v_123A	db	0, 0
v_123C	db	0, 0
v_123E	db	77h, 4, 32h, 0FEh, 32h, 6, 32h, 14, 32h, 16h, 32h, 5Ch, 3Dh, 0A2h, 0, 40h
	db	0, 80h, 0, 0C0h
	db	14 dup (0)
s_WEP_DLL	db	'WEP.DLL', 0
v_1268	db	77h, 4
v_126A	db	0, 0
s_Error_code	db	13, 10, 'Error code:', 0
	db	0, 0, 0, 20h
	db	40 dup (0)
v_12A6	db	60 dup (0)
_DATA	ends

_STACK	segment byte stack 'STACK'
	assume	cs:_STACK,ds:_DATA
	db	320h dup (?)
_STACK	ends
	end	start
