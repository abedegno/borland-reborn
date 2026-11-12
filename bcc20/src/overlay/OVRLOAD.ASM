; /* target: CODE_3_R3OVR */
; /* opts: /ml */
;
; Segment 059A:0004..00DD (CODE_3 through CODE_4:000D), part of the overlay
; manager (hand-written assembly; OVRMGR holds the rest in CODE_2).
;   far, ret 4: [bp+6] far pointer to an overlay header, [bp+4] the caller's
;   code segment.
; The low byte of the header segment is XORed with HOST_MODE (DS:001A).  When the header's
; word at 10h is 0 the routine calls OVR_SEGMENT_TO_STUB and, on success,
; LOCK_HEAP_NODE, then POOL_INIT with the header's size words (08h + 0Ah) and
; HEAP_MODE_SET_BIT5, then (only if 4DD4 succeeded) UNLOCK_HEAP_NODE, and
; OVR_LOAD_OVERLAY_FAR; when the word is
; 1000h or below the same 4DD4 / 28F4 / HEAP_MODE_SET_BIT13 / 2929 sequence runs.
; The calls into CODE_2 are far.  CODE_3:0003 is the padding byte between
; segments (OVRMGR's ret 4 at 0..2 belongs to segment 0094); the last 14
; bytes lay at the start of the old CODE_4 block.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

		extrn	OVR_SEGMENT_TO_STUB:far
		extrn	LOCK_HEAP_NODE:far
		extrn	POOL_INIT:far
		extrn	HEAP_MODE_SET_BIT5:far
		extrn	UNLOCK_HEAP_NODE:far
		extrn	OVR_LOAD_OVERLAY_FAR:far
		extrn	HEAP_MODE_SET_BIT13:far

CODE_3		segment byte public 'CODE'
		assume	cs:CODE_3,ds:DGROUP

HOST_MODE	equ	001Ah			; DS:001A, 8 under the DOS extender (as SETTOP)

		public	OVR_ENSURE_IMAGE_LOADED

OVR_ENSURE_IMAGE_LOADED	proc	far
		push	bp
		mov	bp,sp
		sub	sp,2
		push	bx
		push	cx
		push	si
		push	di
		push	ds
		les	bx,dword ptr [bp+6]
		mov	dx,es
		xor	dl,byte ptr DGROUP:HOST_MODE
		mov	es,dx
		push	bx
		mov	dx,word ptr es:[10h]
		mov	word ptr [bp-2],0
		or	dx,dx
		jne	M_LOADED
		mov	ax,word ptr [bp+4]
		push	ds
		push	es
		call	far ptr OVR_SEGMENT_TO_STUB
		pop	es
		pop	ds
		jb	M_NOSAVE
		push	ds
		push	es
		mov	word ptr [bp-2],ax
		push	ax
		mov	ax,0Eh
		push	ax
		call	far ptr LOCK_HEAP_NODE
		pop	es
		pop	ds
M_NOSAVE:
		push	es
		push	es
		mov	ax,10h
		push	ax
		push	es
		push	ax
		mov	ax,word ptr es:[8]
		add	ax,word ptr es:[0Ah]
		add	ax,10h
		push	ax
		call	far ptr POOL_INIT
		call	far ptr HEAP_MODE_SET_BIT5
		mov	ax,word ptr [bp-2]
		or	ax,ax
		je	M_RELEASE
		push	ds
		push	es
		push	ax
		mov	ax,0Eh
		push	ax
		call	far ptr UNLOCK_HEAP_NODE
		pop	es
		pop	ds
M_RELEASE:
		pop	es
		call	far ptr OVR_LOAD_OVERLAY_FAR
M_LOADED:
		mov	dx,word ptr es:[10h]
		cmp	dx,1000h
		ja	M_RETURN
		mov	ax,word ptr [bp+4]
		push	ds
		push	es
		call	far ptr OVR_SEGMENT_TO_STUB
		pop	es
		pop	ds
		jb	M_NOSAVE2
		push	ds
		push	es
		mov	word ptr [bp-2],ax
		push	ax
		mov	ax,0Eh
		push	ax
		call	far ptr LOCK_HEAP_NODE
		pop	es
		pop	ds
M_NOSAVE2:
		push	es
		push	es
		mov	ax,10h
		push	ax
		call	far ptr HEAP_MODE_SET_BIT13
		pop	es
		mov	ax,word ptr [bp-2]
		or	ax,ax
		je	M_RELOAD
		push	ds
		push	es
		push	ax
		mov	ax,0Eh
		push	ax
		call	far ptr UNLOCK_HEAP_NODE
		pop	es
		pop	ds
M_RELOAD:
		mov	dx,word ptr es:[10h]
M_RETURN:
		pop	ax
		pop	ds
		pop	di
		pop	si
		pop	cx
		pop	bx
		mov	sp,bp
		pop	bp
		retf	4
OVR_ENSURE_IMAGE_LOADED	endp

CODE_3		ends
		end
