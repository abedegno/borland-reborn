; /* target: CODE_2_RG2CEND */
; /* opts: /ml */
;
; CODE_2:4682..5060, hand-written assembly: the overlay manager (Borland's
; VROOMM, OVERLAY.LIB-like; the publics __OVRINIT, __OVRGROUP and
; __OvrPrepare keep Borland's names).  The routine at 504A ends with its
; ret 4 at 5060..5062: the FBOV segment table puts those bytes in segment
; 0094 (span 000F..5063); the old block layout had cut them into CODE_3.
;
;   4682  DOS dup handle (AH=45h), like the HPDOSIO wrappers
;   4694  data: __OVRGROUP (overlay data segment), HEAP_PROGRAM_DS, 'PATH=',
;         PROGRAM_LOAD_SEGMENT
;   469F  __OVRINIT: open the overlay file, find the FBOV header, set up the
;         stubs and the memory limit
;   47DA  toggle the INT 3Fh vector and open/close the file
;   482F  shut down
;   4847/4853/4893/48F0  open by name / from argv[0]'s directory / along
;         PATH / copy a name and open it
;   4916  read the header;  4924  set up the stub segments and buffers
;   49FB  read overlay data at an offset
;   4A87  __OvrPrepare: fix up a loaded overlay and patch its stubs
;   4AE4  linear address to paragraphs;  4AF1  far load;  4AFC  seek and read
;   4B3D/4B4A  apply fixups;  4B7A  rewrite call thunks;  4BDA  load from file
;   4C08  the INT 3Fh trap handler;  4C71  make an overlay resident
;   4CAE  far preload;  4CF0/4D2F  stubs to JMP FAR / back to INT 3Fh
;   4D62/4D6E  fix return segments on the stack;  4D94/4DB0/4DBC  sizes
;   4DD4  map a segment to its stub
;   4E0B  C45_SETJUMP: overlay-aware setjmp;  4E3C  overlay-aware longjmp
;   4F4D  heap callback, dispatching through the word table at ds:76h:
;         4F73 load, 4FF7 discard, 5011 set address, 501A moved
;   504A  overlay image size
;
; Bytes kept as db: call word ptr [bx+76h] at 4F64 has a 16-bit displacement,
; which TASM never emits for a small constant (no fixup in the baseline).
DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		extrn	BCC_SEG_46:far
		extrn	BCC_SEG_47:far
		extrn	__SEGTABLE__:far
		extrn	_abort:far
		extrn	C31_SET_MEMORY_LIMIT:far
		extrn	ALLOC_BANK5_NODE:far
		extrn	POOL_INIT:far
		extrn	HEAP_MODE_SET_BIT13:far
		extrn	HANDLE_ITEM_POINTER:far
		.186
CODE2		segment byte public 'CODE'
		assume	cs:CODE2
		extrn	RH_DOS_CLOSE:near
		extrn	RH_DOS_SEEK:near
		extrn	RH_DOS_OPEN:near
		extrn	RH_DOS_READ:near
		extrn	RESIZE_HANDLE_BLOCK_NEAR:near
		public	RH_DOS_DUP
		public	__OVRINIT
		public	OVR_SHUTDOWN
		public	OVR_READ_AT_OFFSET
		public	__OvrPrepare
		public	C45_SETJUMP
		public	C45_LONGJUMP
		public	HEAP_PROGRAM_DS
		public	__OVRGROUP
RH_DOS_DUP:
		push	bp		; 4682
		mov	bp, sp		; 4683
		mov	bx, word ptr [bp+4]		; 4685
		mov	ah, 45h		; 4688
		int	21h		; 468A
		jae	L4690		; 468C
		sbb	ax, ax		; 468E
L4690:
		pop	bp		; 4690
		ret	2		; 4691
__OVRGROUP	dw	seg BCC_SEG_46		; 4694: the overlay manager's data segment
HEAP_PROGRAM_DS	dw	DGROUP		; 4696
PATH_PREFIX	db	'PATH='		; 4698
PROGRAM_LOAD_SEGMENT	dw	0		; 469D: the program's load segment (PSP+10h)
__OVRINIT:
		push	bp		; 469F
		mov	bp, sp		; 46A0
		sub	sp, 14h		; 46A2
		push	ds		; 46A5
		mov	ds, word ptr cs:__OVRGROUP		; 46A6
		push	si		; 46AB
		push	di		; 46AC
		cmp	word ptr ds:[132h], 0		; 46AD
		je	L46B7		; 46B2
		jmp	L47CF		; 46B4
L46B7:
		cld		; 46B7
		cmp	word ptr ds:[120h], 0		; 46B8
		jne	L46C2		; 46BD
		jmp	L47CF		; 46BF
L46C2:
		call	L4853		; 46C2
		jae	L46F6		; 46C5
		mov	ax, word ptr [bp+6]		; 46C7
		or	ax, word ptr [bp+8]		; 46CA
		jne	L46D9		; 46CD
		mov	word ptr [bp+6], 5E0h		; 46CF
		mov	word ptr [bp+8],seg __SEGTABLE__		; 46D4
L46D9:
		call	L4847		; 46D9
		jae	L46F6		; 46DC
		call	L4893		; 46DE
		jae	L46F6		; 46E1
		mov	ax, 0FFFEh		; 46E3
		jmp	L47D1		; 46E6
L46E9:
		push	word ptr ds:[138h]		; 46E9
		call	RH_DOS_CLOSE		; 46ED
		mov	ax, 0FFFFh		; 46F0
		jmp	L47D1		; 46F3
L46F6:
		mov	bx, ax		; 46F6
		mov	word ptr ds:[138h], bx		; 46F8
		mov	cx, 14h		; 46FC
		call	L4916		; 46FF
		mov	cx, 0FFFDh		; 4702
		jb	L46E9		; 4705
		xor	ax, ax		; 4707
		xor	dx, dx		; 4709
		cmp	word ptr [bp-14h], 5A4Dh		; 470B
		je	L4717		; 4710
		mov	cx, 0FFFCh		; 4712
		jmp	L46E9		; 4715
L4717:
		mov	ax, word ptr [bp-10h]		; 4717
		mov	cx, word ptr [bp-12h]		; 471A
		jcxz	L4720		; 471D
		dec	ax		; 471F
L4720:
		mov	dx, 200h		; 4720
		mul	dx		; 4723
		add	ax, cx		; 4725
L4727:
		push	dx		; 4727
		push	ax		; 4728
		push	word ptr ds:[138h]		; 4729
		push	dx		; 472D
		push	ax		; 472E
		xor	ax, ax		; 472F
		push	ax		; 4731
		call	RH_DOS_SEEK		; 4732
		mov	cx, 10h		; 4735
		call	L4916		; 4738
		pop	ax		; 473B
		pop	dx		; 473C
		mov	cx, 0FFFDh		; 473D
		jb	L46E9		; 4740
		add	ax, 10h		; 4742
		adc	dx, 0		; 4745
		cmp	word ptr [bp-14h], 4246h		; 4748
		mov	cx, 0FFFCh		; 474D
		jne	L46E9		; 4750
		cmp	word ptr [bp-12h], 564Fh		; 4752
		je	L4761		; 4757
		add	ax, word ptr [bp-10h]		; 4759
		adc	dx, word ptr [bp-0Eh]		; 475C
		jmp	L4727		; 475F
L4761:
		mov	word ptr ds:[124h], ax		; 4761
		mov	word ptr ds:[126h], dx		; 4764
		mov	es, word ptr cs:HEAP_PROGRAM_DS		; 4768
		mov	ax, word ptr [bp-10h]		; 476D
		mov	word ptr es:[6FEh], ax		; 4770
		mov	ax, word ptr [bp-0Eh]		; 4774
		mov	word ptr es:[700h], ax		; 4777
		push	word ptr ds:[138h]		; 477B
		call	RH_DOS_CLOSE		; 477F
		mov	word ptr ds:[138h], 0		; 4782
		nosmart
		call	far ptr L47DA
		smart		; 4788
		mov	ax, word ptr [bp+0Ch]		; 478D
		mov	word ptr ds:[134h], ax		; 4790
		mov	ax, word ptr [bp+0Ah]		; 4793
		mov	word ptr ds:[136h], ax		; 4796
		call	L4924		; 4799
		or	ax, ax		; 479C
		jne	L47D1		; 479E
		mov	ax, word ptr ds:[12Ah]		; 47A0
		xor	dx, dx		; 47A3
		shl	ax, 1		; 47A5
		rcl	dx, 1		; 47A7
		shl	ax, 1		; 47A9
		rcl	dx, 1		; 47AB
		shl	ax, 1		; 47AD
		rcl	dx, 1		; 47AF
		shl	ax, 1		; 47B1
		rcl	dx, 1		; 47B3
		push	dx		; 47B5
		push	ax		; 47B6
		mov	di, dx		; 47B7
		mov	si, ax		; 47B9
		call	far ptr C31_SET_MEMORY_LIMIT		; 47BB
		cmp	dx, di		; 47C0
		jb	L47CA		; 47C2
		ja	L47CF		; 47C4
		cmp	ax, si		; 47C6
		jae	L47CF		; 47C8
L47CA:
		mov	ax, 0FFFFh		; 47CA
		jmp	short L47D1		; 47CD
L47CF:
		xor	ax, ax		; 47CF
L47D1:
		pop	di		; 47D1
		pop	si		; 47D2
		pop	ds		; 47D3
		mov	sp, bp		; 47D4
		pop	bp		; 47D6
		retf	8		; 47D7
L47DA:
		push	bp		; 47DA
		mov	bp, sp		; 47DB
		push	ds		; 47DD
		mov	ds, word ptr cs:__OVRGROUP		; 47DE
		mov	al, byte ptr ds:[121h]		; 47E3
		mov	ah, 35h		; 47E6
		int	21h		; 47E8
		push	es		; 47EA
		push	bx		; 47EB
		push	ds		; 47EC
		mov	al, byte ptr ds:[121h]		; 47ED
		mov	dx, word ptr ds:[72h]		; 47F0
		mov	ds, word ptr ds:[74h]		; 47F4
		mov	ah, 25h		; 47F8
		int	21h		; 47FA
		pop	ds		; 47FC
		pop	word ptr ds:[72h]		; 47FD
		pop	word ptr ds:[74h]		; 4801
		cmp	word ptr ds:[138h], 0		; 4805
		je	L481B		; 480A
		push	word ptr ds:[138h]		; 480C
		call	RH_DOS_CLOSE		; 4810
		mov	word ptr ds:[138h], 0		; 4813
		jmp	short L482C		; 4819
L481B:
		mov	ax,seg BCC_SEG_46		; 481B
		push	ax		; 481E
		mov	ax, 9Ah		; 481F
		push	ax		; 4822
		xor	ax, ax		; 4823
		push	ax		; 4825
		call	RH_DOS_OPEN		; 4826
		mov	word ptr ds:[138h], ax		; 4829
L482C:
		pop	ds		; 482C
		pop	bp		; 482D
		retf		; 482E
OVR_SHUTDOWN:
		push	bp		; 482F
		mov	bp, sp		; 4830
		push	ds		; 4832
		mov	ds, word ptr cs:__OVRGROUP		; 4833
		cmp	word ptr ds:[138h], 0		; 4838
		je	L4844		; 483D
		nosmart
		call	far ptr L47DA
		smart		; 483F
L4844:
		pop	ds		; 4844
		pop	bp		; 4845
		retf		; 4846
L4847:
		push	ds		; 4847
		nosmart
		lea	di, ds:[9Ah]		; 4848
		smart
		push	ds		; 484C
		pop	es		; 484D
		call	L48F0		; 484E
		pop	ds		; 4851
		ret		; 4852
L4853:
		mov	ah, 30h		; 4853
		int	21h		; 4855
		cmp	al, 3		; 4857
		jb	L4892		; 4859
		push	ds		; 485B
		mov	ax,DGROUP		; 485C
		mov	ds, ax		; 485F
		mov	ds, word ptr ds:[14h]		; 4861
		xor	si, si		; 4865
		cld		; 4867
L4868:
		lodsb		; 4868
		or	al, al		; 4869
		jne	L4868		; 486B
		lodsb		; 486D
		or	al, al		; 486E
		jne	L4868		; 4870
		lodsw		; 4872
		nosmart
		lea	di, ds:[9Ah]		; 4873
		smart
		mov	ax,seg BCC_SEG_46		; 4877
		mov	es, ax		; 487A
		mov	bx, di		; 487C
L487E:
		lodsb		; 487E
		stosb		; 487F
		or	al, al		; 4880
		je	L488C		; 4882
		cmp	al, 5Ch		; 4884
		jne	L487E		; 4886
		mov	bx, di		; 4888
		jmp	L487E		; 488A
L488C:
		mov	di, bx		; 488C
		call	L48F0		; 488E
		pop	ds		; 4891
L4892:
		ret		; 4892
L4893:
		push	ds		; 4893
		mov	ax,DGROUP		; 4894
		mov	ds, ax		; 4897
		mov	ds, word ptr ds:[14h]		; 4899
		xor	si, si		; 489D
L489F:
		mov	di, offset PATH_PREFIX		; 489F
		push	cs		; 48A2
		pop	es		; 48A3
		mov	cx, 5		; 48A4
		cld		; 48A7
		repe cmpsb		; 48A8
		je	L48B9		; 48AA
		dec	si		; 48AC
L48AD:
		lodsb		; 48AD
		or	al, al		; 48AE
		jne	L48AD		; 48B0
		cmp	al, byte ptr [si]		; 48B2
		jne	L489F		; 48B4
L48B6:
		pop	ds		; 48B6
		stc		; 48B7
		ret		; 48B8
L48B9:
		cmp	byte ptr [si], 0		; 48B9
		je	L48B6		; 48BC
		nosmart
		lea	di, ds:[9Ah]		; 48BE
		smart
		mov	ax,seg BCC_SEG_46		; 48C2
		mov	es, ax		; 48C5
		xor	al, al		; 48C7
L48C9:
		mov	ah, al		; 48C9
		lodsb		; 48CB
		or	al, al		; 48CC
		je	L48D7		; 48CE
		cmp	al, 3Bh		; 48D0
		je	L48D8		; 48D2
		stosb		; 48D4
		jmp	L48C9		; 48D5
L48D7:
		dec	si		; 48D7
L48D8:
		cmp	ah, 3Ah		; 48D8
		je	L48E5		; 48DB
		cmp	ah, 5Ch		; 48DD
		je	L48E5		; 48E0
		mov	al, 5Ch		; 48E2
		stosb		; 48E4
L48E5:
		push	ds		; 48E5
		push	si		; 48E6
		call	L48F0		; 48E7
		pop	si		; 48EA
		pop	ds		; 48EB
		jb	L48B9		; 48EC
		pop	ds		; 48EE
		ret		; 48EF
L48F0:
		lds	si, dword ptr [bp+6]		; 48F0
		mov	ax, ds		; 48F3
		or	ax, si		; 48F5
		je	L4907		; 48F7
		mov	cx, 0Ch		; 48F9
L48FC:
		lodsb		; 48FC
		stosb		; 48FD
		or	al, al		; 48FE
		je	L4907		; 4900
		loop	L48FC		; 4902
		sub	al, al		; 4904
		stosb		; 4906
L4907:
		mov	ax,seg BCC_SEG_46		; 4907
		push	ax		; 490A
		mov	ax, 9Ah		; 490B
		push	ax		; 490E
		xor	ax, ax		; 490F
		push	ax		; 4911
		call	RH_DOS_OPEN		; 4912
		ret		; 4915
L4916:
		push	word ptr ds:[138h]		; 4916
		push	ss		; 491A
		nosmart
		lea	ax, [bp-14h]		; 491B
		smart
		push	ax		; 491E
		push	cx		; 491F
		call	RH_DOS_READ		; 4920
		ret		; 4923
L4924:
		mov	ax,DGROUP		; 4924
		mov	es, ax		; 4927
		mov	ax, word ptr es:[16h]		; 4929
		add	ax, 10h		; 492D
		mov	word ptr cs:PROGRAM_LOAD_SEGMENT, ax		; 4930
		mov	ax,seg BCC_SEG_47		; 4934
		mov	es, ax		; 4937
		xor	bx, bx		; 4939
		xor	di, di		; 493B
		nosmart
		lea	si, ds:[1B0h]		; 493D
		smart
L4941:
		test	word ptr [si+4], 2		; 4941
		je	L494E		; 4946
		cmp	word ptr [si+2], 0		; 4948
		jne	L4951		; 494C
L494E:
		jmp	L49CC		; 494E
L4951:
		mov	ax, word ptr [si]		; 4951
		push	es		; 4953
		mov	word ptr es:[12h], ax		; 4954
		mov	es, ax		; 4958
		cmp	byte ptr es:[1Ah], 0FFh		; 495A
		jne	L496D		; 4960
		pop	es		; 4962
		mov	word ptr es:[12h], 0		; 4963
		jmp	L49CC		; 496A
L496D:
		pop	ax		; 496D
		mov	word ptr es:[18h], offset L4BDA		; 496E
		mov	ax, word ptr ds:[124h]		; 4975
		mov	dx, word ptr ds:[126h]		; 4978
		add	word ptr es:[4], ax		; 497C
		adc	word ptr es:[6], dx		; 4981
		mov	dx, word ptr es:[8]		; 4986
		add	dx, word ptr es:[0Ah]		; 498B
		jae	L49A3		; 4990
		mov	dx, word ptr es:[8]		; 4992
		cmp	di, word ptr es:[0Ah]		; 4997
		jae	L49A3		; 499C
		mov	di, word ptr es:[0Ah]		; 499E
L49A3:
		cmp	bx, dx		; 49A3
		jae	L49A9		; 49A5
		mov	bx, dx		; 49A7
L49A9:
		push	es		; 49A9
		push	bx		; 49AA
		push	es		; 49AB
		mov	ax, 0Eh		; 49AC
		push	ax		; 49AF
		push	dx		; 49B0
		mov	ax,CODE2		; 49B1
		push	ax		; 49B4
		mov	ax, offset L4F4D		; 49B5
		push	ax		; 49B8
		call	far ptr ALLOC_BANK5_NODE		; 49B9
		pop	bx		; 49BE
		pop	es		; 49BF
		or	ax, ax		; 49C0
		je	L49CC		; 49C2
		mov	ax, 0F000h		; 49C4
		jmp	far ptr _abort		; 49C7
L49CC:
		add	si, 8		; 49CC
		cmp	si, 790h		; 49CF
		jae	L49D8		; 49D3
		jmp	L4941		; 49D5
L49D8:
		xor	ax, ax		; 49D8
		add	bx, 0Fh		; 49DA
		mov	cl, 4		; 49DD
		shr	bx, cl		; 49DF
		add	bx, 2		; 49E1
		mov	word ptr ds:[12Ah], bx		; 49E4
		or	di, di		; 49E8
		je	L49FA		; 49EA
		mov	ax,seg BCC_SEG_46		; 49EC
		push	ax		; 49EF
		mov	ax, 70h		; 49F0
		push	ax		; 49F3
		push	di		; 49F4
		call	far ptr POOL_INIT		; 49F5
L49FA:
		ret		; 49FA
OVR_READ_AT_OFFSET:
		push	bp		; 49FB
		mov	bp, sp		; 49FC
		push	ds		; 49FE
		mov	ds, word ptr cs:__OVRGROUP		; 49FF
		push	si		; 4A04
		push	di		; 4A05
		mov	cx, word ptr [bp+0Ch]		; 4A06
		mov	word ptr ds:[13Ch], cx		; 4A09
		mov	ds, cx		; 4A0D
		mov	si, word ptr ds:[4]		; 4A0F
		mov	di, word ptr ds:[6]		; 4A13
		mov	ax, word ptr [bp+4]		; 4A17
		mov	dx, 10h		; 4A1A
		mul	dx		; 4A1D
		add	si, ax		; 4A1F
		adc	di, dx		; 4A21
		xor	bx, bx		; 4A23
L4A25:
		mov	ds, cx		; 4A25
		mov	cx, word ptr ds:[12h]		; 4A27
		jcxz	L4A46		; 4A2B
		mov	es, cx		; 4A2D
		mov	ax, word ptr es:[4]		; 4A2F
		mov	dx, word ptr es:[6]		; 4A33
		sub	ax, si		; 4A38
		sbb	dx, di		; 4A3A
		jns	L4A46		; 4A3C
		mov	word ptr ds:[1Ch], cx		; 4A3E
		mov	bx, ds		; 4A42
		jmp	L4A25		; 4A44
L4A46:
		or	bx, bx		; 4A46
		je	L4A79		; 4A48
		mov	si, word ptr ds:[4]		; 4A4A
		mov	di, word ptr ds:[6]		; 4A4E
		mov	ds, bx		; 4A52
		mov	word ptr ds:[1Ch], 0		; 4A54
		mov	ds, word ptr cs:__OVRGROUP		; 4A5A
		mov	ax, word ptr [bp+8]		; 4A5F
		mov	es, word ptr ds:[13Ch]		; 4A62
		mov	dx, word ptr es:[4]		; 4A66
		mov	cx, word ptr es:[6]		; 4A6B
		sub	si, dx		; 4A70
		sbb	di, cx		; 4A72
		call	L4AFC		; 4A74
		jae	L4A7E		; 4A77
L4A79:
		mov	ax, 0FFFFh		; 4A79
		jmp	short L4A80		; 4A7C
L4A7E:
		xor	ax, ax		; 4A7E
L4A80:
		pop	di		; 4A80
		pop	si		; 4A81
		pop	ds		; 4A82
		pop	bp		; 4A83
		ret	0Ah		; 4A84
__OvrPrepare:
		push	ds		; 4A87
		push	si		; 4A88
		push	di		; 4A89
		mov	ds, word ptr cs:__OVRGROUP		; 4A8A
		mov	di, word ptr es:[0Eh]		; 4A8F
		mov	word ptr es:[10h], di		; 4A94
		mov	cx, word ptr es:[0Ah]		; 4A99
		jcxz	L4AC4		; 4A9E
		mov	ax, word ptr es:[8]		; 4AA0
		add	ax, cx		; 4AA4
		jae	L4AC1		; 4AA6
		push	cx		; 4AA8
		mov	ax, word ptr es:[8]		; 4AA9
		mov	si, ax		; 4AAD
		and	si, 0Fh		; 4AAF
		mov	cl, 4		; 4AB2
		shr	ax, cl		; 4AB4
		add	ax, word ptr es:[10h]		; 4AB6
		pop	cx		; 4ABB
		call	L4B4A		; 4ABC
		jmp	short L4AC4		; 4ABF
L4AC1:
		call	L4B3D		; 4AC1
L4AC4:
		call	L4CF0		; 4AC4
		mov	ax, word ptr es:[10h]		; 4AC7
		dec	ax		; 4ACB
		mov	ds, ax		; 4ACC
		mov	word ptr ds:[0Ch], es		; 4ACE
		mov	ax, 0FFFFh		; 4AD2
		mov	bx, ax		; 4AD5
		mov	ds, word ptr cs:__OVRGROUP		; 4AD7
		call	dword ptr ds:[90h]		; 4ADC
		pop	di		; 4AE0
		pop	si		; 4AE1
		pop	ds		; 4AE2
		ret		; 4AE3
		mov	cl, 4		; 4AE4
		shr	ax, cl		; 4AE6
		ror	dx, cl		; 4AE8
		and	dx, 0F000h		; 4AEA
		or	ax, dx		; 4AEE
		ret		; 4AF0
		push	ds		; 4AF1
		mov	ax,seg BCC_SEG_46		; 4AF2
		mov	ds, ax		; 4AF5
		call	L4BDA		; 4AF7
		pop	ds		; 4AFA
		retf		; 4AFB
L4AFC:
		push	ax		; 4AFC
		push	word ptr ds:[138h]		; 4AFD
		push	cx		; 4B01
		push	dx		; 4B02
		xor	ax, ax		; 4B03
		push	ax		; 4B05
		call	RH_DOS_SEEK		; 4B06
		mov	bx, word ptr ds:[138h]		; 4B09
		pop	ax		; 4B0D
		push	ds		; 4B0E
		mov	ds, ax		; 4B0F
		jmp	short L4B1A		; 4B11
L4B13:
		mov	ax, ds		; 4B13
		add	ax, 0FFFh		; 4B15
		mov	ds, ax		; 4B18
L4B1A:
		mov	cx, 0FFF0h		; 4B1A
		or	di, di		; 4B1D
		jne	L4B23		; 4B1F
		mov	cx, si		; 4B21
L4B23:
		push	bx		; 4B23
		push	bx		; 4B24
		push	ds		; 4B25
		xor	ax, ax		; 4B26
		push	ax		; 4B28
		push	cx		; 4B29
		call	RH_DOS_READ		; 4B2A
		pop	bx		; 4B2D
		jb	L4B3B		; 4B2E
		sub	si, ax		; 4B30
		sbb	di, 0		; 4B32
		mov	ax, si		; 4B35
		or	ax, di		; 4B37
		jne	L4B13		; 4B39
L4B3B:
		pop	ds		; 4B3B
		ret		; 4B3C
L4B3D:
		push	ds		; 4B3D
		push	es		; 4B3E
		mov	si, word ptr es:[8]		; 4B3F
		mov	ax, word ptr es:[10h]		; 4B44
		jmp	short L4B4C		; 4B48
L4B4A:
		push	ds		; 4B4A
		push	es		; 4B4B
L4B4C:
		mov	ds, ax		; 4B4C
		mov	es, word ptr es:[10h]		; 4B4E
		shr	cx, 1		; 4B53
		cld		; 4B55
L4B56:
		lodsw		; 4B56
		mov	bx, ax		; 4B57
		mov	di, word ptr es:[bx]		; 4B59
		push	ds		; 4B5C
		mov	ax,seg __SEGTABLE__		; 4B5D
		mov	ds, ax		; 4B60
		mov	ax, di		; 4B62
		and	di, 0FFF8h		; 4B64
		mov	dx, word ptr [di]		; 4B67
		mov	word ptr es:[bx], dx		; 4B69
		test	ax, 1		; 4B6C
		je	L4B74		; 4B6F
		call	L4B7A		; 4B71
L4B74:
		pop	ds		; 4B74
		loop	L4B56		; 4B75
		pop	es		; 4B77
		pop	ds		; 4B78
		ret		; 4B79
L4B7A:
		push	cx		; 4B7A
		mov	ds, dx		; 4B7B
		mov	ah, byte ptr es:[bx-1]		; 4B7D
		mov	al, ah		; 4B81
		and	ax, 0F807h		; 4B83
		cmp	ah, 0B8h		; 4B86
		jne	L4BD6		; 4B89
		mov	cx, ax		; 4B8B
		mov	ah, byte ptr es:[bx+2]		; 4B8D
		mov	al, ah		; 4B91
		and	ax, 0F807h		; 4B93
		cmp	ah, 50h		; 4B96
		jne	L4BD6		; 4B99
		cmp	al, cl		; 4B9B
		jne	L4BD6		; 4B9D
		mov	dx, ax		; 4B9F
		mov	ah, byte ptr es:[bx+3]		; 4BA1
		mov	al, ah		; 4BA5
		and	ax, 0F807h		; 4BA7
		cmp	cx, ax		; 4BAA
		jne	L4BD6		; 4BAC
		mov	ah, byte ptr es:[bx+6]		; 4BAE
		mov	al, ah		; 4BB2
		and	ax, 0F807h		; 4BB4
		cmp	ax, dx		; 4BB7
		jne	L4BD6		; 4BB9
		mov	di, 20h		; 4BBB
		mov	cx, word ptr ds:[0Ch]		; 4BBE
		mov	ax, word ptr es:[bx+4]		; 4BC2
L4BC6:
		cmp	ax, word ptr [di+2]		; 4BC6
		je	L4BD2		; 4BC9
		add	di, 5		; 4BCB
		loop	L4BC6		; 4BCE
		jmp	short L4BD8		; 4BD0
L4BD2:
		mov	word ptr es:[bx+4], di		; 4BD2
L4BD6:
		pop	cx		; 4BD6
		ret		; 4BD7
L4BD8:
		pop	cx		; 4BD8
		ret		; 4BD9
L4BDA:
		mov	si, word ptr es:[8]		; 4BDA
		xor	di, di		; 4BDF
		add	si, word ptr es:[0Ah]		; 4BE1
		adc	di, 0		; 4BE6
		mov	dx, word ptr es:[4]		; 4BE9
		mov	cx, word ptr es:[6]		; 4BEE
		mov	ax, word ptr es:[10h]		; 4BF3
		call	L4AFC		; 4BF7
		jb	L4C07		; 4BFA
		mov	cx, word ptr es:[0Ah]		; 4BFC
		jcxz	L4C06		; 4C01
		call	L4B3D		; 4C03
L4C06:
		clc		; 4C06
L4C07:
		ret		; 4C07
		push	bp		; 4C08
		mov	bp, sp		; 4C09
		test	bp, 1		; 4C0B
		je	L4C19		; 4C0F
		mov	ax, 0F001h		; 4C11
		jmp	far ptr _abort		; 4C14
L4C19:
		push	ax		; 4C19
		push	bx		; 4C1A
		push	cx		; 4C1B
		push	dx		; 4C1C
		push	si		; 4C1D
		push	di		; 4C1E
		push	ds		; 4C1F
		push	es		; 4C20
		mov	ax,seg BCC_SEG_46		; 4C21
		mov	ds, ax		; 4C24
		sti		; 4C26
		les	bx, dword ptr [bp+2]		; 4C27
		push	word ptr es:[bx]		; 4C2A
		sub	word ptr [bp+2], 2		; 4C2D
		jne	L4C38		; 4C31
		call	L4C71		; 4C33
		jmp	short L4C50		; 4C36
L4C38:
		add	bp, 6		; 4C38
		mov	ax, word ptr [bp]		; 4C3B
		xchg	word ptr [bp-6], ax		; 4C3E
		mov	word ptr [bp], ax		; 4C41
		call	L4C71		; 4C44
		mov	ax, word ptr [bp]		; 4C47
		xchg	word ptr [bp-6], ax		; 4C4A
		mov	word ptr [bp], ax		; 4C4D
L4C50:
		pop	bx		; 4C50
		mov	al, byte ptr es:[1Ah]		; 4C51
		and	al, 8		; 4C55
		and	byte ptr es:[1Ah], 0F7h		; 4C57
		cbw		; 4C5D
		mov	ds, word ptr cs:__OVRGROUP		; 4C5E
		call	dword ptr ds:[90h]		; 4C63
		pop	es		; 4C67
		pop	ds		; 4C68
		pop	di		; 4C69
		pop	si		; 4C6A
		pop	dx		; 4C6B
		pop	cx		; 4C6C
		pop	bx		; 4C6D
		pop	ax		; 4C6E
		pop	bp		; 4C6F
		iret		; 4C70
L4C71:
		cmp	word ptr es:[10h], 0		; 4C71
		je	L4C7B		; 4C77
		jmp	short L4C81		; 4C79
L4C7B:
		or	byte ptr es:[1Ah], 8		; 4C7B
L4C81:
		push	es		; 4C81
		push	es		; 4C82
		mov	ax, 0Eh		; 4C83
		push	ax		; 4C86
		call	far ptr HEAP_MODE_SET_BIT13		; 4C87
		pop	es		; 4C8C
		or	ax, ax		; 4C8D
		jne	L4CA6		; 4C8F
		mov	ax, word ptr es:[0Eh]		; 4C91
		mov	word ptr es:[10h], ax		; 4C95
		push	ds		; 4C99
		dec	ax		; 4C9A
		mov	ds, ax		; 4C9B
		mov	word ptr ds:[0Ch], es		; 4C9D
		pop	ds		; 4CA1
		call	L4CF0		; 4CA2
		ret		; 4CA5
L4CA6:
		mov	ax, 0F004h		; 4CA6
		jmp	far ptr _abort		; 4CA9
		push	bp		; 4CAE
		mov	bp, sp		; 4CAF
		push	ds		; 4CB1
		mov	ds, word ptr cs:__OVRGROUP		; 4CB2
		push	si		; 4CB7
		push	di		; 4CB8
		mov	es, word ptr [bp+6]		; 4CB9
		cmp	word ptr es:[10h], 0		; 4CBC
		je	L4CCD		; 4CC2
		cmp	word ptr es:[0Eh], 1000h		; 4CC4
		jae	L4CE9		; 4CCB
L4CCD:
		call	L4C71		; 4CCD
		mov	bx, 0FFFFh		; 4CD0
		mov	al, byte ptr es:[1Ah]		; 4CD3
		and	al, 8		; 4CD7
		and	byte ptr es:[1Ah], 0F7h		; 4CD9
		cbw		; 4CDF
		mov	ds, word ptr cs:__OVRGROUP		; 4CE0
		call	dword ptr ds:[90h]		; 4CE5
L4CE9:
		pop	di		; 4CE9
		pop	si		; 4CEA
		pop	ds		; 4CEB
		pop	bp		; 4CEC
		retf	2		; 4CED
L4CF0:
		cmp	word ptr es:[0Ch], 0		; 4CF0
		jne	L4CF9		; 4CF6
		ret		; 4CF8
L4CF9:
		cmp	byte ptr es:[20h], 0EAh		; 4CF9
		je	L4D2E		; 4CFF
		mov	cx, word ptr es:[2]		; 4D01
		jcxz	L4D11		; 4D06
		mov	ax, word ptr es:[10h]		; 4D08
		mov	dx, es		; 4D0C
		call	L4D62		; 4D0E
L4D11:
		mov	bx, word ptr es:[10h]		; 4D11
		mov	cx, word ptr es:[0Ch]		; 4D16
		mov	di, 20h		; 4D1B
		cld		; 4D1E
L4D1F:
		mov	dx, word ptr es:[di+2]		; 4D1F
		mov	al, 0EAh		; 4D23
		stosb		; 4D25
		mov	ax, dx		; 4D26
		stosw		; 4D28
		mov	ax, bx		; 4D29
		stosw		; 4D2B
		loop	L4D1F		; 4D2C
L4D2E:
		ret		; 4D2E
L4D2F:
		cmp	byte ptr es:[20h], 0CDh		; 4D2F
		je	L4D61		; 4D35
		mov	ax, es		; 4D37
		mov	dx, word ptr es:[10h]		; 4D39
		xor	cx, cx		; 4D3E
		call	L4D62		; 4D40
		mov	word ptr es:[2], cx		; 4D43
		mov	cx, word ptr es:[0Ch]		; 4D48
		mov	di, 20h		; 4D4D
		cld		; 4D50
L4D51:
		mov	dx, word ptr es:[di+1]		; 4D51
		mov	ax, word ptr ds:[120h]		; 4D55
		stosw		; 4D58
		mov	ax, dx		; 4D59
		stosw		; 4D5B
		xor	al, al		; 4D5C
		stosb		; 4D5E
		loop	L4D51		; 4D5F
L4D61:
		ret		; 4D61
L4D62:
		call	L4D6E		; 4D62
		or	bx, bx		; 4D65
		je	L4D6D		; 4D67
		xchg	word ptr ss:[bx+2], cx		; 4D69
L4D6D:
		ret		; 4D6D
L4D6E:
		xor	bx, bx		; 4D6E
		push	cx		; 4D70
		push	bp		; 4D71
		jmp	short L4D78		; 4D72
L4D74:
		shl	cx, 1		; 4D74
		mov	bp, cx		; 4D76
L4D78:
		mov	cx, word ptr [bp]		; 4D78
		shr	cx, 1		; 4D7B
		je	L4D91		; 4D7D
		jb	L4D74		; 4D7F
		cmp	dx, word ptr [bp+4]		; 4D81
		jne	L4D74		; 4D84
		mov	word ptr [bp+4], ax		; 4D86
		or	bx, bx		; 4D89
		jne	L4D74		; 4D8B
		mov	bx, bp		; 4D8D
		jmp	L4D74		; 4D8F
L4D91:
		pop	bp		; 4D91
		pop	cx		; 4D92
		ret		; 4D93
		mov	ax, word ptr ds:[13Ch]		; 4D94
		or	ax, ax		; 4D97
		je	L4DA7		; 4D99
		mov	es, ax		; 4D9B
		mov	ax, word ptr es:[10h]		; 4D9D
		sub	ax, word ptr ds:[130h]		; 4DA1
		jae	L4DAF		; 4DA5
L4DA7:
		mov	ax, word ptr ds:[136h]		; 4DA7
		sub	ax, word ptr ds:[130h]		; 4DAA
		stc		; 4DAE
L4DAF:
		ret		; 4DAF
		mov	ax, word ptr es:[8]		; 4DB0
		add	ax, 11h		; 4DB4
		mov	cl, 4		; 4DB7
		shr	ax, cl		; 4DB9
		ret		; 4DBB
		mov	cl, 4		; 4DBC
		mov	ax, word ptr es:[8]		; 4DBE
		add	ax, 11h		; 4DC2
		shr	ax, cl		; 4DC5
		mov	dx, word ptr es:[0Ah]		; 4DC7
		add	dx, 0Fh		; 4DCC
		shr	dx, cl		; 4DCF
		add	dx, ax		; 4DD1
		ret		; 4DD3
L4DD4:
		push	ds		; 4DD4
		push	es		; 4DD5
		mov	ds, word ptr cs:__OVRGROUP		; 4DD6
		cmp	ax, word ptr ds:[134h]		; 4DDB
		jb	L4E05		; 4DDF
		cmp	ax, word ptr ds:[136h]		; 4DE1
		jae	L4E05		; 4DE5
		push	ax		; 4DE7
		push	ax		; 4DE8
		call	far ptr HANDLE_ITEM_POINTER		; 4DE9
		pop	ax		; 4DEE
		mov	es, dx		; 4DEF
		mov	bx, word ptr ds:[120h]		; 4DF1
		cmp	bx, word ptr es:[0]		; 4DF5
		jne	L4E05		; 4DFA
		cmp	ax, word ptr es:[10h]		; 4DFC
		mov	ax, es		; 4E01
		je	L4E08		; 4E03
L4E05:
		xor	ax, ax		; 4E05
		stc		; 4E07
L4E08:
		pop	es		; 4E08
		pop	ds		; 4E09
		retf		; 4E0A
C45_SETJUMP:
		push	bp		; 4E0B
		mov	bp, sp		; 4E0C
		push	di		; 4E0E
		push	di		; 4E0F
		les	di, dword ptr [bp+6]		; 4E10
		cld		; 4E13
		mov	ax, bp		; 4E14
		stosw		; 4E16
		mov	ax, word ptr [bp]		; 4E17
		stosw		; 4E1A
		mov	ax, word ptr [bp+2]		; 4E1B
		stosw		; 4E1E
		mov	ax, word ptr [bp+4]		; 4E1F
		nosmart
		call	far ptr L4DD4
		smart		; 4E22
		jae	L4E2C		; 4E27
		mov	ax, word ptr [bp+4]		; 4E29
L4E2C:
		stosw		; 4E2C
		pop	ax		; 4E2D
		stosw		; 4E2E
		mov	ax, ds		; 4E2F
		stosw		; 4E31
		mov	ax, si		; 4E32
		stosw		; 4E34
		xor	ax, ax		; 4E35
		pop	di		; 4E37
		pop	bp		; 4E38
		retf	4		; 4E39
C45_LONGJUMP:
		push	bp		; 4E3C
		mov	bp, sp		; 4E3D
		sub	sp, 2		; 4E3F
		mov	ds, word ptr cs:__OVRGROUP		; 4E42
		mov	byte ptr [bp-2], 0		; 4E47
		les	si, dword ptr [bp+8]		; 4E4B
		mov	cx, word ptr es:[si+2]		; 4E4E
		mov	bx, bp		; 4E52
		mov	ax, word ptr ds:[120h]		; 4E54
		mov	dx, word ptr ds:[134h]		; 4E57
		jmp	short L4E61		; 4E5B
L4E5D:
		shl	si, 1		; 4E5D
		mov	bx, si		; 4E5F
L4E61:
		cmp	bx, cx		; 4E61
		jae	L4E8F		; 4E63
		mov	si, word ptr ss:[bx]		; 4E65
		shr	si, 1		; 4E68
		je	L4E8F		; 4E6A
		jb	L4E5D		; 4E6C
		mov	di, word ptr ss:[bx+4]		; 4E6E
		cmp	di, dx		; 4E72
		jae	L4E5D		; 4E74
		mov	es, di		; 4E76
		mov	di, word ptr ss:[bx+2]		; 4E78
		or	di, di		; 4E7C
		jne	L4E5D		; 4E7E
		cmp	word ptr es:[di], ax		; 4E80
		jne	L4E5D		; 4E83
		mov	byte ptr [bp-2], 1		; 4E85
		mov	word ptr es:[di+2], di		; 4E89
		jmp	L4E5D		; 4E8D
L4E8F:
		cmp	byte ptr [bp-2], 1		; 4E8F
		je	L4E9C		; 4E93
		jmp	L4ED1		; 4E95
L4E98:
		shl	si, 1		; 4E98
		mov	bx, si		; 4E9A
L4E9C:
		mov	si, word ptr ss:[bx]		; 4E9C
		shr	si, 1		; 4E9F
		je	L4ED1		; 4EA1
		jb	L4E98		; 4EA3
		mov	di, word ptr ss:[bx+4]		; 4EA5
		cmp	di, dx		; 4EA9
		jae	L4E98		; 4EAB
		mov	es, di		; 4EAD
		mov	di, word ptr ss:[bx+2]		; 4EAF
		or	di, di		; 4EB3
		je	L4E98		; 4EB5
		cmp	word ptr es:[0], ax		; 4EB7
		jne	L4E98		; 4EBC
		cmp	word ptr es:[2], 0		; 4EBE
		jne	L4E98		; 4EC4
		xchg	word ptr es:[2], di		; 4EC6
		mov	word ptr ss:[bx+2], di		; 4ECB
		jmp	L4E98		; 4ECF
L4ED1:
		mov	di, word ptr [bp+6]		; 4ED1
		les	si, dword ptr [bp+8]		; 4ED4
		cld		; 4ED7
		lods	word ptr es:[si]		; 4ED8
		xchg	bp, ax		; 4EDA
		lods	word ptr es:[si]		; 4EDB
		mov	word ptr [bp], ax		; 4EDD
		lods	word ptr es:[si]		; 4EE0
		mov	word ptr [bp+2], ax		; 4EE2
		lods	word ptr es:[si]		; 4EE5
		push	es		; 4EE7
		mov	es, ax		; 4EE8
		mov	cx, word ptr ds:[120h]		; 4EEA
		cmp	cx, word ptr es:[0]		; 4EEE
		jne	L4F30		; 4EF3
		cmp	word ptr es:[10h], 0		; 4EF5
		je	L4F05		; 4EFB
		cmp	byte ptr es:[20h], 0CDh		; 4EFD
		jne	L4F2C		; 4F03
L4F05:
		mov	word ptr [bp+4], 0		; 4F05
		push	si		; 4F0A
		push	di		; 4F0B
		call	L4C71		; 4F0C
		pop	di		; 4F0F
		pop	si		; 4F10
		mov	bx, word ptr [bp+2]		; 4F11
		push	es		; 4F14
		mov	al, byte ptr es:[1Ah]		; 4F15
		and	al, 8		; 4F19
		and	byte ptr es:[1Ah], 0F7h		; 4F1B
		cbw		; 4F21
		mov	ds, word ptr cs:__OVRGROUP		; 4F22
		call	dword ptr ds:[90h]		; 4F27
		pop	es		; 4F2B
L4F2C:
		mov	ax, word ptr es:[10h]		; 4F2C
L4F30:
		pop	es		; 4F30
		mov	word ptr [bp+4], ax		; 4F31
		mov	dx, di		; 4F34
		lods	word ptr es:[si]		; 4F36
		xchg	di, ax		; 4F38
		lods	word ptr es:[si]		; 4F39
		mov	ds, ax		; 4F3B
		lods	word ptr es:[si]		; 4F3D
		xchg	si, ax		; 4F3F
		cmp	dx, 1		; 4F40
		adc	dx, 0		; 4F43
		xchg	dx, ax		; 4F46
		mov	sp, bp		; 4F47
		pop	bp		; 4F49
		retf	4		; 4F4A
L4F4D:
		push	bp		; 4F4D
		mov	bp, sp		; 4F4E
		sub	sp, 2		; 4F50
		push	ds		; 4F53
		mov	ds, word ptr cs:__OVRGROUP		; 4F54
		push	si		; 4F59
		push	di		; 4F5A
		mov	es, word ptr [bp+0Ah]		; 4F5B
		mov	bx, word ptr [bp+0Ch]		; 4F5E
		dec	bx		; 4F61
		shl	bx, 1		; 4F62
		db	0FFh,97h		; call word ptr [bx+76h] with a 16-bit
		dw	76h		; displacement, which TASM never emits for a small constant
		pop	di		; 4F68
		pop	si		; 4F69
		xor	ax, ax		; 4F6A
		pop	ds		; 4F6C
		mov	sp, bp		; 4F6D
		pop	bp		; 4F6F
		retf	8		; 4F70
		mov	ax, word ptr es:[0Eh]		; 4F73
		mov	word ptr es:[10h], ax		; 4F77
		push	word ptr ds:[138h]		; 4F7B
		push	word ptr es:[6]		; 4F7F
		push	word ptr es:[4]		; 4F84
		xor	ax, ax		; 4F89
		push	ax		; 4F8B
		call	RH_DOS_SEEK		; 4F8C
		mov	cx, word ptr es:[8]		; 4F8F
		add	cx, word ptr es:[0Ah]		; 4F94
		jae	L4FA0		; 4F99
		mov	cx, word ptr es:[8]		; 4F9B
L4FA0:
		pushf		; 4FA0
		push	word ptr ds:[138h]		; 4FA1
		push	word ptr es:[10h]		; 4FA5
		xor	ax, ax		; 4FAA
		push	ax		; 4FAC
		push	cx		; 4FAD
		call	RH_DOS_READ		; 4FAE
		jb	L4FEF		; 4FB1
		mov	cx, word ptr es:[0Ah]		; 4FB3
		popf		; 4FB8
		jcxz	L4FEE		; 4FB9
		jb	L4FD1		; 4FBB
		call	L4B3D		; 4FBD
		push	es		; 4FC0
		push	es		; 4FC1
		mov	ax, 0Eh		; 4FC2
		push	ax		; 4FC5
		push	word ptr es:[8]		; 4FC6
		call	RESIZE_HANDLE_BLOCK_NEAR		; 4FCB
		pop	es		; 4FCE
		jmp	short L4FEE		; 4FCF
L4FD1:
		push	word ptr ds:[138h]		; 4FD1
		push	word ptr ds:[70h]		; 4FD5
		xor	ax, ax		; 4FD9
		push	ax		; 4FDB
		push	word ptr es:[0Ah]		; 4FDC
		call	RH_DOS_READ		; 4FE1
		jb	L4FEF		; 4FE4
		mov	ax, word ptr ds:[70h]		; 4FE6
		xor	si, si		; 4FE9
		call	L4B4A		; 4FEB
L4FEE:
		ret		; 4FEE
L4FEF:
		mov	ax, 0F002h		; 4FEF
		jmp	far ptr _abort		; 4FF2
		call	L4D2F		; 4FF7
		cmp	word ptr [bp+6], 0		; 4FFA
		je	L5009		; 4FFE
		push	es		; 5000
		mov	ax, 1		; 5001
		call	dword ptr ds:[90h]		; 5004
		pop	es		; 5008
L5009:
		mov	word ptr es:[10h], 0		; 5009
		ret		; 5010
		mov	ax, word ptr es:[0Eh]		; 5011
		mov	word ptr es:[10h], ax		; 5015
		ret		; 5019
		mov	ax, word ptr [bp+6]		; 501A
		cmp	byte ptr es:[20h], 0CDh		; 501D
		je	L503C		; 5023
		mov	dx, word ptr es:[10h]		; 5025
		call	L4D6E		; 502A
		mov	cx, word ptr es:[0Ch]		; 502D
		mov	di, 23h		; 5032
		cld		; 5035
L5036:
		stosw		; 5036
		add	di, 3		; 5037
		loop	L5036		; 503A
L503C:
		mov	word ptr es:[10h], ax		; 503C
		push	ds		; 5040
		dec	ax		; 5041
		mov	ds, ax		; 5042
		mov	word ptr ds:[0Ch], es		; 5044
		pop	ds		; 5048
		ret		; 5049
		push	bp		; 504A
		mov	bp, sp		; 504B
		mov	es, word ptr [bp+6]		; 504D
		mov	ax, word ptr es:[8]		; 5050
		add	ax, word ptr es:[0Ah]		; 5054
		jae	L505F		; 5059
		mov	ax, word ptr es:[8]		; 505B
L505F:
		pop	bp		; 505F
		ret	4		; 5060

CODE2		ends
		end
