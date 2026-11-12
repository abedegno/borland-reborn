; /* target: OVREXMEM */
; /* opts: /ml */
; /* CPP.EXE module OVREXMEM (image 2AFE..314F, 0054:25BE..0054:2C0F): source taken
;    from the BCC.EXE reconstruction (bcc20/src/overlay/OVREXMEM.ASM)
;    with three edits marked "CPP.EXE edit": __OVRGROUP and HEAP_PROGRAM_DS are
;    defined here (BCC: OVRMGR.ASM, which CPP.EXE lacks), BCC's two empty retf stubs
;    after MOVE_EXTENDED_MEMORY become one retf before the last stub, and the
;    owner-tag byte is named (BCC wrote its address).  The 4-digit addresses in the
;    line comments are CPP.EXE offsets in the heap frame 0054h (0054:xxxx); "image"
;    marks a CPP.EXE image offset.  The local labels (L2AD6 and so on) are named
;    after their CPP.EXE offsets in frame 0054h. */
;
; Hand-written assembly: BCC's overlay manager's EMS and extended-memory support,
; kept in CPP.EXE (which has no overlay manager) as the last module of the heap's
; code segment, frame 0054h.  Its data are in the far data segment 1B2Dh
; (__OVRGROUP's segment; BCC_SEG_46 is BCC's name, DFAR.ASM holds it in CPP).  In
; BCC it is part of the same library as OVRMGR.  In CPP.EXE the heap's EMS and
; extended-memory banks (EMSBANK.C, EMSINIT.C, EXTBANK.C, EXTINIT.C) and the
; release functions in HPEMSREL.C and HPEXTREL.C call it, HEAPMAIN.C, HPEVICT.C and
; RHAPI.C call RH_DISPATCH_NODE, RHAPI.C REGISTER_FAR_CALLBACK, POOLS.C RESIZE_POOL_BLOCK
; and MEMINIT.C FIX_HEAP_NODE_LOW.  It ends with the mode stubs that call
; CHANGE_HEAP_NODE_MODE.
;
;   25C2  EMM_NAME 'EMMXXXX0'
;   25CB  DETECT_EMS: detect EMS (device, status, version 3.2+, frame,
;         free pages); returns the free page count
;   267D  ALLOCATE_EMS_PAGES(handle, first, pages): handle 0 allocates; saves and
;         restores the page map; 0 = OK
;   26E2  FREE_EMS_HANDLE: free our EMS handle
;   270C  DETECT_EXTENDED_MEMORY: detect extended memory (286+, not OS/2, machine model
;         byte; XMS 2.0+, else int 15h/88h with VDISK checks at 1M and the
;         int 19h vector); sets start and end, returns the bytes free
;   28BC  CLAIM_EXTENDED_MEMORY(base, size): claim it (XMS allocate and lock, or a
;         VDISK header plus an int 19h hook)
;   2994  OVR_RELEASE_EXT_MEMORY: release extended memory
;   29E8  MOVE_EXTENDED_MEMORY: move SI bytes from DX:AX to CX:BX (linear) by XMS
;         function 0Bh or int 15h/87h; carry set on error
;   2A95  callback-table segment and its CS copy
;   2A99  RH_DISPATCH_NODE: calls far table[node->field18]
;   2AB4  REGISTER_FAR_CALLBACK: register a far callback and return its index (up to 64)
;   2B7F/2B96  shims into CHANGE_HEAP_NODE_MODE(mode, mask, ptr[, size])
;   2BAE..2C0F  mode stubs (2BAE RESIZE_POOL_BLOCK: 1000h; 2BCA FIX_HEAP_NODE_LOW: 8),
;         an empty retf at 2C09 and a jump to FREE_HANDLE_BLOCK at 2C0A
DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		extrn	CHANGE_HEAP_NODE_MODE:far
		extrn	POOL_INIT:far
		extrn	FREE_HANDLE_BLOCK:far
		extrn	BCC_SEG_50:far
		extrn	BCC_SEG_46:far
_DATA		segment word public 'DATA'
		extrn	HEAP_DEFAULT_OWNER_TAG:byte	; CPP.EXE edit: BCC wrote es:[6C0h] (its address)
_DATA		ends
		.186
CODE2		segment byte public 'CODE'
		assume	cs:CODE2
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
		public	__OVRGROUP
		public	CALLBACK_TABLE_PTR_SEG	; link: HEAPMAIN.C stores CS here
		public	HEAP_PROGRAM_DS
; CPP.EXE edit: CPP.EXE has no overlay manager (OVRMGR.ASM), and the two words BCC
; keeps there sit here, in front of EMM_NAME (image 2AFE: 1B2Dh and 122Ah, both
; relocated; every cs:__OVRGROUP / cs:HEAP_PROGRAM_DS in the heap frame reads them).
__OVRGROUP	dw	seg BCC_SEG_46		; the overlay data segment (CPP: the far data segment)
HEAP_PROGRAM_DS	dw	DGROUP
EMM_NAME	db	'EMMXXXX0',0		; 25C2
DETECT_EMS:
		push	bp		; 25CB
		mov	bp, sp		; 25CC
		sub	sp, 102h		; 25CE
		push	ds		; 25D2
		mov	ds, word ptr cs:__OVRGROUP		; 25D3
		push	si		; 25D8
		push	di		; 25D9
		test	byte ptr ds:[28h], 1		; 25DA
		je	L25F1		; 25DF
		test	byte ptr ds:[28h], 2		; 25E1
		jne	L25EB		; 25E6
		jmp	L2659		; 25E8
L25EB:
		mov	ax, word ptr ds:[26h]		; 25EB
		jmp	L2676		; 25EE
L25F1:
		push	ds		; 25F1
		push	cs		; 25F2
		pop	ds		; 25F3
		mov	dx, offset EMM_NAME		; 25F4
		mov	ax, 3D00h		; 25F7
		int	21h		; 25FA
		pop	ds		; 25FC
		mov	bx, ax		; 25FD
		jb	L2623		; 25FF
		mov	ax, 4400h		; 2601
		int	21h		; 2604
		jb	L261F		; 2606
		test	dx, 80h		; 2608
		je	L261F		; 260C
		mov	ax, 4407h		; 260E
		int	21h		; 2611
		jb	L261F		; 2613
		push	ax		; 2615
		mov	ah, 3Eh		; 2616
		int	21h		; 2618
		pop	ax		; 261A
		cmp	al, 0FFh		; 261B
		je	L2626		; 261D
L261F:
		mov	ah, 3Eh		; 261F
		int	21h		; 2621
L2623:
		jmp	L266F		; 2623
L2626:
		mov	ax, 3567h		; 2626
		int	21h		; 2629
		mov	ax, es		; 262B
		or	ax, bx		; 262D
		je	L2623		; 262F
		mov	ah, 40h		; 2631
		int	67h		; 2633
		or	ah, ah		; 2635
		jne	L2623		; 2637
		mov	byte ptr ds:[28h], 1		; 2639
		mov	ah, 46h		; 263E
		int	67h		; 2640
		or	ah, ah		; 2642
		jne	L2623		; 2644
		cmp	al, 32h		; 2646
		jb	L2623		; 2648
		mov	byte ptr ds:[29h], al		; 264A
		mov	ah, 41h		; 264D
		int	67h		; 264F
		or	ah, ah		; 2651
		jne	L2623		; 2653
		mov	word ptr ds:[20h], bx		; 2655
L2659:
		mov	ah, 42h		; 2659
		int	67h		; 265B
		or	ah, ah		; 265D
		jne	L266F		; 265F
		mov	word ptr ds:[26h], bx		; 2661
		mov	word ptr ds:[22h], 0FFFFh		; 2665
		mov	ax, bx		; 266B
		jmp	short L2676		; 266D
L266F:
		xor	ax, ax		; 266F
		mov	byte ptr ds:[28h], 0		; 2671
L2676:
		pop	di		; 2676
		pop	si		; 2677
		pop	ds		; 2678
		mov	sp, bp		; 2679
		pop	bp		; 267B
		retf		; 267C
ALLOCATE_EMS_PAGES:
		push	bp		; 267D
		mov	bp, sp		; 267E
		push	ds		; 2680
		mov	ds, word ptr cs:__OVRGROUP		; 2681
		test	byte ptr ds:[28h], 1		; 2686
		jne	L2690		; 268B
		jmp	L26DA		; 268D
L2690:
		test	byte ptr ds:[28h], 2		; 2690
		je	L269C		; 2695
		xor	ax, ax		; 2697
		jmp	L26DD		; 2699
L269C:
		or	byte ptr ds:[28h], 2		; 269C
		mov	ax, word ptr [bp+8]		; 26A1
		mov	word ptr ds:[24h], ax		; 26A4
		mov	bx, word ptr [bp+6]		; 26A7
		mov	word ptr ds:[26h], bx		; 26AA
		mov	dx, word ptr [bp+0Ah]		; 26AE
		or	dx, dx		; 26B1
		jne	L26C2		; 26B3
		mov	ah, 43h		; 26B5
		int	67h		; 26B7
		or	ah, ah		; 26B9
		jne	L26DA		; 26BB
		or	byte ptr ds:[28h], 4		; 26BD
L26C2:
		mov	word ptr ds:[22h], dx		; 26C2
		mov	ah, 47h		; 26C6
		int	67h		; 26C8
		or	ah, ah		; 26CA
		jne	L26DA		; 26CC
		mov	dx, word ptr ds:[22h]		; 26CE
		mov	ah, 48h		; 26D2
		int	67h		; 26D4
		mov	al, ah		; 26D6
		jmp	short L26DD		; 26D8
L26DA:
		mov	ax, 0FFFFh		; 26DA
L26DD:
		pop	ds		; 26DD
		pop	bp		; 26DE
		retf	6		; 26DF
FREE_EMS_HANDLE:
		push	bp		; 26E2
		mov	bp, sp		; 26E3
		push	ds		; 26E5
		mov	ds, word ptr cs:__OVRGROUP		; 26E6
		test	byte ptr ds:[28h], 4		; 26EB
		je	L2709		; 26F0
		mov	dx, word ptr ds:[22h]		; 26F2
		or	dx, dx		; 26F6
		js	L2709		; 26F8
		mov	ah, 45h		; 26FA
		int	67h		; 26FC
		mov	word ptr ds:[22h], 0FFFFh		; 26FE
		mov	byte ptr ds:[28h], 0		; 2704
L2709:
		pop	ds		; 2709
		pop	bp		; 270A
		retf		; 270B
DETECT_EXTENDED_MEMORY:
		push	bp		; 270C
		mov	bp, sp		; 270D
		sub	sp, 22h		; 270F
		push	ds		; 2712
		mov	ds, word ptr cs:__OVRGROUP		; 2713
		push	si		; 2718
		push	di		; 2719
		test	byte ptr ds:[32h], 1		; 271A
		je	L272B		; 271F
		test	byte ptr ds:[32h], 2		; 2721
		je	L2730		; 2726
		jmp	L28A1		; 2728
L272B:
		mov	byte ptr ds:[32h], 1		; 272B
L2730:
		mov	word ptr ds:[2Ah], 0		; 2730
		mov	word ptr ds:[2Ch], 10h		; 2736
		mov	word ptr ds:[2Eh], 0		; 273C
		mov	word ptr ds:[30h], 10h		; 2742
		push	sp		; 2748
		pop	ax		; 2749
		cmp	ax, sp		; 274A
		jne	L2756		; 274C
		mov	ah, 30h		; 274E
		int	21h		; 2750
		cmp	al, 0Ah		; 2752
		jb	L2759		; 2754
L2756:
		jmp	L28B2		; 2756
L2759:
		xchg	al, ah		; 2759
		mov	word ptr [bp-22h], ax		; 275B
		mov	ax, 0F000h		; 275E
		mov	es, ax		; 2761
		mov	al, byte ptr es:[0FFFEh]		; 2763
		cmp	al, 0FCh		; 2767
		ja	L2756		; 2769
		cmp	al, 0FBh		; 276B
		je	L2756		; 276D
		cmp	al, 0F9h		; 276F
		je	L2756		; 2771
		cmp	word ptr [bp-22h], 31h		; 2773
		jae	L277C		; 2777
L2779:
		jmp	L27FB		; 2779
L277C:
		mov	ax, 4300h		; 277C
		int	2Fh		; 277F
		cmp	al, 80h		; 2781
		jne	L2779		; 2783
		mov	ax, 4310h		; 2785
		int	2Fh		; 2788
		mov	word ptr ds:[33h], bx		; 278A
		mov	word ptr ds:[35h], es		; 278E
		xor	ax, ax		; 2792
		call	dword ptr ds:[33h]		; 2794
		cmp	ah, 2		; 2798
		jb	L27FB		; 279B
		mov	ah, 8		; 279D
		call	dword ptr ds:[33h]		; 279F
		or	ax, ax		; 27A3
		je	L27F8		; 27A5
		mov	si, ax		; 27A7
		xchg	dx, ax		; 27A9
		mov	ah, 9		; 27AA
		call	dword ptr ds:[33h]		; 27AC
		or	ax, ax		; 27B0
		je	L27F8		; 27B2
		mov	word ptr ds:[37h], dx		; 27B4
		mov	ah, 0Ch		; 27B8
		call	dword ptr ds:[33h]		; 27BA
		or	ax, ax		; 27BE
		je	L27DE		; 27C0
		mov	word ptr ds:[2Ah], bx		; 27C2
		mov	word ptr ds:[2Ch], dx		; 27C6
		mov	ax, 400h		; 27CA
		mul	si		; 27CD
		add	ax, word ptr ds:[2Ah]		; 27CF
		adc	dx, word ptr ds:[2Ch]		; 27D3
		mov	word ptr ds:[2Eh], ax		; 27D7
		mov	word ptr ds:[30h], dx		; 27DA
L27DE:
		mov	ah, 0Dh		; 27DE
		mov	dx, word ptr ds:[37h]		; 27E0
		call	dword ptr ds:[33h]		; 27E4
		mov	ah, 0Ah		; 27E8
		mov	dx, word ptr ds:[37h]		; 27EA
		call	dword ptr ds:[33h]		; 27EE
		mov	word ptr ds:[37h], 0		; 27F2
L27F8:
		jmp	L28A1		; 27F8
L27FB:
		mov	ah, 88h		; 27FB
		int	15h		; 27FD
		or	ax, ax		; 27FF
		jne	L2806		; 2801
L2803:
		jmp	L28B2		; 2803
L2806:
		mov	dx, 400h		; 2806
		mul	dx		; 2809
		add	dl, 10h		; 280B
		mov	word ptr ds:[2Eh], ax		; 280E
		mov	word ptr ds:[30h], dx		; 2811
		mov	cx, word ptr ds:[33h]		; 2815
		or	cx, word ptr ds:[35h]		; 2819
		jcxz	L282A		; 281D
		mov	byte ptr ds:[2Ch], 11h		; 281F
		mov	word ptr ds:[2Ah], 0		; 2824
L282A:
		mov	ax, ss		; 282A
		mov	dx, 10h		; 282C
		mul	dx		; 282F
		nosmart
		lea	bx, [bp-20h]		; 2831
		smart
		xor	cx, cx		; 2834
		add	bx, ax		; 2836
		adc	cx, dx		; 2838
		mov	ax, 0		; 283A
		mov	dx, 10h		; 283D
		mov	si, 20h		; 2840
		xor	di, di		; 2843
		call	MOVE_EXTENDED_MEMORY		; 2845
		jb	L2803		; 2848
		nosmart
		lea	di, [bp-1Dh]		; 284A
		smart
		push	ss		; 284D
		pop	es		; 284E
		nosmart
		lea	si, ds:[0]		; 284F
		smart
		mov	cx, 5		; 2853
		cld		; 2856
		repe cmpsb		; 2857
		jne	L286B		; 2859
		mov	ax, word ptr [bp-15h]		; 285B
		mul	word ptr [bp-0Dh]		; 285E
		add	dl, 10h		; 2861
		mov	word ptr ds:[2Ah], ax		; 2864
		mov	byte ptr ds:[2Ch], dl		; 2867
L286B:
		xor	ax, ax		; 286B
		mov	es, ax		; 286D
		mov	es, word ptr es:[66h]		; 286F
		mov	di, 12h		; 2874
		nosmart
		lea	si, ds:[0]		; 2877
		smart
		mov	cx, 5		; 287B
		cld		; 287E
		repe cmpsb		; 287F
		jne	L28A1		; 2881
		mov	ax, word ptr es:[2Ch]		; 2883
		mov	dl, byte ptr es:[2Eh]		; 2887
		cmp	dl, byte ptr ds:[2Ch]		; 288C
		jb	L28A1		; 2890
		ja	L289A		; 2892
		cmp	ax, word ptr ds:[2Ah]		; 2894
		jbe	L28A1		; 2898
L289A:
		mov	word ptr ds:[2Ah], ax		; 289A
		mov	byte ptr ds:[2Ch], dl		; 289D
L28A1:
		mov	ax, word ptr ds:[2Eh]		; 28A1
		mov	dx, word ptr ds:[30h]		; 28A4
		sub	ax, word ptr ds:[2Ah]		; 28A8
		sbb	dx, word ptr ds:[2Ch]		; 28AC
		jmp	short L28B5		; 28B0
L28B2:
		xor	ax, ax		; 28B2
		cwd		; 28B4
L28B5:
		pop	di		; 28B5
		pop	si		; 28B6
		pop	ds		; 28B7
		mov	sp, bp		; 28B8
		pop	bp		; 28BA
		retf		; 28BB
CLAIM_EXTENDED_MEMORY:
		push	bp		; 28BC
		mov	bp, sp		; 28BD
		push	ds		; 28BF
		mov	ds, word ptr cs:__OVRGROUP		; 28C0
		push	si		; 28C5
		push	di		; 28C6
		test	byte ptr ds:[32h], 1		; 28C7
		jne	L28D1		; 28CC
		jmp	L298A		; 28CE
L28D1:
		test	byte ptr ds:[32h], 2		; 28D1
		je	L28DD		; 28D6
		xor	ax, ax		; 28D8
		jmp	L298D		; 28DA
L28DD:
		or	byte ptr ds:[32h], 2		; 28DD
		mov	ax, word ptr [bp+0Ah]		; 28E2
		mov	dx, word ptr [bp+0Ch]		; 28E5
		mov	si, word ptr [bp+6]		; 28E8
		mov	di, word ptr [bp+8]		; 28EB
		mov	bx, word ptr ds:[33h]		; 28EE
		or	bx, word ptr ds:[35h]		; 28F2
		je	L293B		; 28F6
		mov	ax, si		; 28F8
		mov	dx, di		; 28FA
		add	ax, 3FFh		; 28FC
		adc	dx, 0		; 28FF
		mov	bx, 400h		; 2902
		div	bx		; 2905
		xchg	dx, ax		; 2907
		mov	ah, 9		; 2908
		call	dword ptr ds:[33h]		; 290A
		or	ax, ax		; 290E
		je	L2938		; 2910
		mov	word ptr ds:[37h], dx		; 2912
		mov	ah, 0Ch		; 2916
		call	dword ptr ds:[33h]		; 2918
		or	ax, ax		; 291C
		je	L2938		; 291E
		mov	word ptr ds:[2Ah], bx		; 2920
		mov	word ptr ds:[2Ch], dx		; 2924
		mov	word ptr ds:[39h], bx		; 2928
		mov	word ptr ds:[3Bh], dx		; 292C
		mov	ax, bx		; 2930
		add	ax, si		; 2932
		adc	dx, di		; 2934
		jmp	short L297F		; 2936
L2938:
		jmp	L298A		; 2938
L293B:
		mov	word ptr ds:[2Ah], ax		; 293B
		mov	word ptr ds:[2Ch], dx		; 293E
		xor	bx, bx		; 2942
		mov	es, bx		; 2944
		push	ds		; 2946
		mov	bx,seg BCC_SEG_50		; 2947
		mov	ds, bx		; 294A
		mov	bx, word ptr es:[64h]		; 294C
		mov	word ptr ds:[2Fh], bx		; 2951
		mov	bx, word ptr es:[66h]		; 2955
		mov	word ptr ds:[31h], bx		; 295A
		mov	word ptr es:[64h], 3Fh		; 295E
		mov	word ptr es:[66h],seg BCC_SEG_50		; 2965
		mov	word ptr ds:[3Ah], ax		; 296C
		mov	byte ptr ds:[3Ch], dl		; 296F
		add	ax, si		; 2973
		adc	dx, di		; 2975
		mov	word ptr ds:[2Ch], ax		; 2977
		mov	byte ptr ds:[2Eh], dl		; 297A
		pop	ds		; 297E
L297F:
		mov	word ptr ds:[2Eh], ax		; 297F
		mov	word ptr ds:[30h], dx		; 2982
		xor	ax, ax		; 2986
		jmp	short L298D		; 2988
L298A:
		mov	ax, 0FFFFh		; 298A
L298D:
		pop	di		; 298D
		pop	si		; 298E
		pop	ds		; 298F
		pop	bp		; 2990
		retf	8		; 2991
OVR_RELEASE_EXT_MEMORY:
		push	bp		; 2994
		mov	bp, sp		; 2995
		push	ds		; 2997
		mov	ds, word ptr cs:__OVRGROUP		; 2998
		cmp	byte ptr ds:[32h], 0		; 299D
		je	L29E5		; 29A2
		cmp	word ptr ds:[37h], 0		; 29A4
		je	L29C1		; 29A9
		mov	ah, 0Dh		; 29AB
		mov	dx, word ptr ds:[37h]		; 29AD
		call	dword ptr ds:[33h]		; 29B1
		mov	ah, 0Ah		; 29B5
		mov	dx, word ptr ds:[37h]		; 29B7
		call	dword ptr ds:[33h]		; 29BB
		jmp	short L29E5		; 29BF
L29C1:
		xor	ax, ax		; 29C1
		mov	es, ax		; 29C3
		mov	ax, word ptr es:[66h]		; 29C5
		cmp	ax,seg BCC_SEG_50		; 29C9
		jne	L29E5		; 29CC
		push	ds		; 29CE
		mov	ds, ax		; 29CF
		mov	ax, word ptr ds:[2Fh]		; 29D1
		mov	word ptr es:[64h], ax		; 29D4
		mov	ax, word ptr ds:[31h]		; 29D8
		mov	word ptr es:[66h], ax		; 29DB
		pop	ds		; 29DF
		mov	byte ptr ds:[32h], 0		; 29E0
L29E5:
		pop	ds		; 29E5
		pop	bp		; 29E6
		retf		; 29E7
MOVE_EXTENDED_MEMORY:
		push	ds		; 29E8
		push	es		; 29E9
		add	si, 1		; 29EA
		adc	di, 0		; 29ED
		and	si, 0FFFEh		; 29F0
		cld		; 29F3
		mov	ds, word ptr cs:__OVRGROUP		; 29F4
		cmp	word ptr ds:[37h], 0		; 29F9
		je	L2A6A		; 29FE
		mov	word ptr ds:[3Dh], si		; 2A00
		mov	word ptr ds:[3Fh], di		; 2A04
		cmp	dl, 10h		; 2A08
		jb	L2A20		; 2A0B
		mov	si, word ptr ds:[37h]		; 2A0D
		mov	word ptr ds:[41h], si		; 2A11
		sub	ax, word ptr ds:[39h]		; 2A15
		sbb	dx, word ptr ds:[3Bh]		; 2A19
		jmp	L2A29		; 2A1D
L2A20:
		mov	word ptr ds:[41h], 0		; 2A20
		ror	dx, 4		; 2A26
L2A29:
		mov	word ptr ds:[43h], ax		; 2A29
		mov	word ptr ds:[45h], dx		; 2A2C
		cmp	cl, 10h		; 2A30
		jb	L2A48		; 2A33
		mov	si, word ptr ds:[37h]		; 2A35
		mov	word ptr ds:[47h], si		; 2A39
		sub	bx, word ptr ds:[39h]		; 2A3D
		sbb	cx, word ptr ds:[3Bh]		; 2A41
		jmp	L2A51		; 2A45
L2A48:
		mov	word ptr ds:[47h], 0		; 2A48
		ror	cx, 4		; 2A4E
L2A51:
		mov	word ptr ds:[49h], bx		; 2A51
		mov	word ptr ds:[4Bh], cx		; 2A55
		mov	ah, 0Bh		; 2A59
		nosmart
		lea	si, ds:[3Dh]		; 2A5B
		smart
		call	dword ptr ds:[33h]		; 2A5F
		or	ax, ax		; 2A63
		jne	L2A90		; 2A65
		stc		; 2A67
		jmp	short L2A8B		; 2A68
L2A6A:
		shr	di, 1		; 2A6A
		rcr	si, 1		; 2A6C
		mov	word ptr ds:[4Fh], ax		; 2A6E
		mov	byte ptr ds:[51h], dl		; 2A71
		mov	word ptr ds:[57h], bx		; 2A75
		mov	byte ptr ds:[59h], cl		; 2A79
		mov	cx, si		; 2A7D
		nosmart
		lea	si, ds:[3Dh]		; 2A7F
		smart
		push	ds		; 2A83
		pop	es		; 2A84
		mov	ah, 87h		; 2A85
		int	15h		; 2A87
		jae	L2A90		; 2A89
L2A8B:
		sbb	ax, ax		; 2A8B
		stc		; 2A8D
		jmp	short L2A92		; 2A8E
L2A90:
		xor	ax, ax		; 2A90
L2A92:
		pop	es		; 2A92
		pop	ds		; 2A93
		ret		; 2A94
; CPP.EXE edit: BCC's two empty retf stubs (BCC.EXE 445B, 445C, after
; MOVE_EXTENDED_MEMORY) are not here; CPP.EXE has one retf, in front of the last
; stub (2C09, image 3149).
CALLBACK_TABLE_SEG	dw	0		; 2A95: segment of the callback table (REGISTER_FAR_CALLBACK)
CALLBACK_TABLE_PTR_SEG	dw	0		; 2A97: CS, stored at start-up (INIT_MAIN_HEAP, 1F1A), so
					; cs:2A95 can be passed as a far pointer
RH_DISPATCH_NODE:
		pop	ax		; 2A99
		mov	bx, sp		; 2A9A
		xchg	word ptr ss:[bx+8], ax		; 2A9C
		mov	bx, ax		; 2AA0
		mov	bl, byte ptr [bx+12h]		; 2AA2
		xor	bh, bh		; 2AA5
		shl	bx, 1		; 2AA7
		shl	bx, 1		; 2AA9
		mov	es, word ptr cs:CALLBACK_TABLE_SEG		; 2AAB
		call	dword ptr es:[bx]		; 2AB0
		ret		; 2AB3
REGISTER_FAR_CALLBACK:
		push	bp		; 2AB4
		mov	bp, sp		; 2AB5
		push	ds		; 2AB7
		mov	ds, word ptr cs:__OVRGROUP		; 2AB8
		mov	cx, word ptr cs:CALLBACK_TABLE_SEG		; 2ABD
		jcxz	L2B3E		; 2AC2
		mov	es, cx		; 2AC4
		mov	ax, word ptr [bp+4]		; 2AC6
		mov	dx, word ptr [bp+6]		; 2AC9
		mov	cx, word ptr ds:[12h]		; 2ACC
		shr	cx, 1		; 2AD0
		shr	cx, 1		; 2AD2
		xor	bx, bx		; 2AD4
L2AD6:
		cmp	word ptr es:[bx+2], dx		; 2AD6
		jne	L2AE1		; 2ADA
		cmp	word ptr es:[bx], ax		; 2ADC
		je	L2B33		; 2ADF
L2AE1:
		add	bx, 4		; 2AE1
		loop	L2AD6		; 2AE4
		mov	bx, word ptr ds:[12h]		; 2AE6
		cmp	bx, word ptr ds:[10h]		; 2AEA
		jb	L2B18		; 2AEE
		cmp	bx, 100h		; 2AF0
		jb	L2AFB		; 2AF4
		xor	bx, bx		; 2AF6
		jmp	L2B37		; 2AF8
L2AFB:
		mov	ax, 1000h		; 2AFB
		push	ax		; 2AFE
		push	ax		; 2AFF
		push	word ptr cs:CALLBACK_TABLE_PTR_SEG		; 2B00
		mov	ax, offset CALLBACK_TABLE_SEG		; 2B05
		push	ax		; 2B08
		add	bx, 10h		; 2B09
		push	bx		; 2B0C
		call	far ptr CHANGE_HEAP_NODE_MODE		; 2B0D
		xor	bx, bx		; 2B12
		or	ax, ax		; 2B14
		jne	L2B37		; 2B16
L2B18:
		mov	es, word ptr cs:CALLBACK_TABLE_SEG		; 2B18
		mov	bx, word ptr ds:[12h]		; 2B1D
		mov	ax, word ptr [bp+4]		; 2B21
		mov	word ptr es:[bx], ax		; 2B24
		mov	ax, word ptr [bp+6]		; 2B27
		mov	word ptr es:[bx+2], ax		; 2B2A
		add	word ptr ds:[12h], 4		; 2B2E
L2B33:
		shr	bx, 1		; 2B33
		shr	bx, 1		; 2B35
L2B37:
		mov	ax, bx		; 2B37
		pop	ds		; 2B39
		pop	bp		; 2B3A
		ret	4		; 2B3B
L2B3E:
		mov	es, word ptr cs:HEAP_PROGRAM_DS		; 2B3E
		mov	al, byte ptr es:HEAP_DEFAULT_OWNER_TAG		; 2B43
		push	ax		; 2B47
		mov	byte ptr es:HEAP_DEFAULT_OWNER_TAG, 0		; 2B48
		push	word ptr cs:CALLBACK_TABLE_PTR_SEG		; 2B4E
		mov	ax, offset CALLBACK_TABLE_SEG		; 2B53
		push	ax		; 2B56
		mov	ax, 10h		; 2B57
		push	ax		; 2B5A
		call	far ptr POOL_INIT		; 2B5B
		mov	es, word ptr cs:HEAP_PROGRAM_DS		; 2B60
		pop	bx		; 2B65
		mov	byte ptr es:HEAP_DEFAULT_OWNER_TAG, bl		; 2B66
		xor	bx, bx		; 2B6B
		or	ax, ax		; 2B6D
		jne	L2B37		; 2B6F
		mov	word ptr ds:[10h], 10h		; 2B71
		mov	word ptr ds:[12h], 4		; 2B77
		jmp	L2B18		; 2B7D
L2B7F:
		mov	bx, sp		; 2B7F
		xchg	word ptr ss:[bx+8], dx		; 2B81
		xchg	word ptr ss:[bx+6], ax		; 2B85
		pop	bx		; 2B89
		pop	es		; 2B8A
		pop	cx		; 2B8B
		push	dx		; 2B8C
		push	ax		; 2B8D
		push	cx		; 2B8E
		push	es		; 2B8F
		push	bx		; 2B90
		jmp	far ptr CHANGE_HEAP_NODE_MODE		; 2B91
L2B96:
		mov	bx, sp		; 2B96
		xchg	word ptr ss:[bx+6], dx		; 2B98
		xchg	word ptr ss:[bx+4], ax		; 2B9C
		pop	bx		; 2BA0
		pop	es		; 2BA1
		push	dx		; 2BA2
		push	ax		; 2BA3
		xor	cx, cx		; 2BA4
		push	cx		; 2BA6
		push	es		; 2BA7
		push	bx		; 2BA8
		jmp	far ptr CHANGE_HEAP_NODE_MODE		; 2BA9
RESIZE_POOL_BLOCK:
		mov	dx, 1000h		; 2BAE
		mov	ax, dx		; 2BB1
		jmp	L2B7F		; 2BB3
		mov	dx, 20h		; 2BB5
		mov	ax, dx		; 2BB8
		jmp	L2B96		; 2BBA
		xor	dx, dx		; 2BBC
		mov	ax, 20h		; 2BBE
		jmp	L2B96		; 2BC1
		mov	dx, 2000h		; 2BC3
		mov	ax, dx		; 2BC6
		jmp	L2B96		; 2BC8
FIX_HEAP_NODE_LOW:
		mov	dx, 8		; 2BCA
		mov	ax, dx		; 2BCD
		jmp	L2B96		; 2BCF
		mov	dx, 10h		; 2BD1
		mov	ax, dx		; 2BD4
		jmp	L2B96		; 2BD6
		xor	dx, dx		; 2BD8
		mov	ax, 18h		; 2BDA
		jmp	L2B96		; 2BDD
		mov	dx, 808h		; 2BDF
		mov	ax, dx		; 2BE2
		jmp	L2B7F		; 2BE4
		mov	dx, 810h		; 2BE6
		mov	ax, dx		; 2BE9
		jmp	L2B7F		; 2BEB
		mov	dx, 2008h		; 2BED
		mov	ax, dx		; 2BF0
		jmp	L2B96		; 2BF2
		mov	dx, 40h		; 2BF4
		mov	ax, dx		; 2BF7
		jmp	L2B96		; 2BF9
		mov	dx, 60h		; 2BFB
		mov	ax, dx		; 2BFE
		jmp	L2B96		; 2C00
		xor	dx, dx		; 2C02
		mov	ax, 40h		; 2C04
		jmp	L2B96		; 2C07
		retf			; CPP.EXE edit: empty far stub (2C09, image 3149)
		jmp	far ptr FREE_HANDLE_BLOCK		; 2C0A

CODE2		ends
		end
