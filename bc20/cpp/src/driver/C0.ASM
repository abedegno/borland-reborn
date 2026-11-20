; /* target: C0 */
; /* opts: /ml */
;
; CPP.EXE module C0 (image 0x0..0x1F4, frame 0000h), hand-written assembly: the
; start-up code. A smaller variant of BCC.EXE's driver/C0.ASM (same author, same
; command-line splitting, same INT dispatch table idea):
;   0000  CPP_START: the program entry (MZ entry 0000:0000). Moves SS:SP to DGROUP:9030h
;         (the header's 19AD:1800 is the same address), fills the DGROUP start-up words
;         from the PSP and the far data segment, copies the command tail onto the stack,
;         clears the BSS, splits the tail into argv and calls main (0034:002B).
;   00B1  _exit: cdecl exit(status). Puts back INT 18h if main hooked it, then
;         int 21h AH=4Ch with the status at [bp+4].
;   00CC  C0_INT_DISPATCH_HANDLER: an INT handler dispatching through HANDLER_TABLE by
;         the byte after the caller's INT instruction (installed as INT 18h by main).
;   00F0  HANDLER_TABLE (128 words, 9090h until filled).
;   01F0  retf / int 40h / retf stubs.
; CPP.EXE edit (against BCC's C0.ASM): no DOS-extender probe (int 21h E800h/E802h), no
; program path in argv (DOS 3+ environment scan), no second move of SS and no stack
; clear; SS:SP is set first. The start-up words are at DGROUP 0Eh..21h instead of
; 04h..1Dh, and the heap words are set from the far data segment (the paragraph after
; DGROUP's stack). exit is a cdecl entry here (BCC: C0_TERMINATE, reached through
; pascal EXIT) and also restores INT 18h. No _abort / overlay error message.
; The DGROUP offsets of the start-up words are written as numbers, as in BCC's C0.ASM
; (es:[16h] etc.); SP's start, 9030h, is the end of DGROUP (the stack's top).

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
		extrn	SAVED_INT18_VECTOR:dword	; DS:574C, set by main
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		extrn	_main:far
		; The cleared area runs from the BSS's first variable (DS:5744, ERROR_COUNT,
		; which BCC's C0 calls BSS_START) to BSS_CLEAR_END (DS:782A).
		extrn	ERROR_COUNT:byte,BSS_CLEAR_END:byte
CODE0		segment byte public 'CODE'
		assume	cs:CODE0
		public	CPP_START
		public	_exit
		public	C0_INT_DISPATCH_HANDLER
		public	C0_EMPTY_FAR_HOOK
CPP_START:
		mov	dx,DGROUP		; 0000
		mov	es, dx
		cli
		mov	ss, dx
		mov	sp, 9030h		; the top of DGROUP
		sti
		mov	ax, seg CPP_FAR_DATA	; 000C: the far data segment (forward reference)
		mov	bx, ax
		mov	cx, word ptr ds:[2]	; PSP: top of memory
		mov	word ptr es:[0Eh], cx
		mov	word ptr es:[12h], cx
		sub	cx, ax
		shr	cx, 1
		add	cx, bx			; halfway between that segment and the top
		mov	word ptr es:[16h], cx
		mov	word ptr es:[1Ah], cx
		mov	word ptr es:[1Ch], ds	; the PSP
		mov	word ptr es:[20h], ds
		mov	cx, word ptr ds:[2Ch]	; the environment segment
		mov	word ptr es:[1Eh], cx
		mov	di, sp			; 0042
		mov	si, 81h
		mov	ch, 0
		mov	cl, byte ptr ds:[80h]
		mov	ax, cx
		sub	di, cx
		dec	di
		and	di, 0FFFEh
		mov	sp, di
		push	ss
		pop	es
		cld
		rep movsb
		mov	bp, di
		mov	ds, dx
		mov	es, dx
		push	ax
		xor	ax, ax
		mov	cx, offset DGROUP:BSS_CLEAR_END	; 0065
		mov	di, offset DGROUP:ERROR_COUNT	; the start of the BSS
		sub	cx, di
		rep stosb
		pop	cx
		mov	bx, 1
		push	ax
		push	ax
		mov	byte ptr [bp], al
		jcxz	L009B
L007A:
		dec	bp
		cmp	byte ptr [bp], 20h
		je	L008B
		cmp	byte ptr [bp], 9
		je	L008B
		mov	ah, 1
		jmp	short L0099
L008B:
		or	ah, ah
		mov	byte ptr [bp], al
		je	L0099
		inc	bp
		push	ss
		push	bp
		dec	bp
		inc	bx
		xor	ax, ax
L0099:
		loop	L007A
L009B:
		or	ah, ah
		je	L00A2
		inc	bx
		push	ss
		push	bp
L00A2:
		push	ss
		push	bp
		mov	ax, sp
		push	ss
		push	ax
		push	bx
		call	far ptr _main		; 00A9
		push	ax
		push	ax
		push	ax
_exit:
		mov	ax, word ptr ds:SAVED_INT18_VECTOR	; 00B1
		or	ax, word ptr ds:SAVED_INT18_VECTOR+2
		je	L00C3
		lds	dx, dword ptr ds:SAVED_INT18_VECTOR
		mov	ax, 2518h
		int	21h
L00C3:
		mov	bp, sp
		mov	al, byte ptr [bp+4]
		mov	ah, 4Ch
		int	21h
C0_INT_DISPATCH_HANDLER:
		push	ax			; 00CC
		push	bp
		mov	bp, sp
		pushf
		push	bx
		push	es
		les	bx, dword ptr [bp+4]
		inc	word ptr [bp+4]
		mov	bl, byte ptr es:[bx]
		mov	bh, 0
		shl	bx, 1
		pop	es
		neg	bx
		mov	bx, word ptr cs:[bx+offset HANDLER_TABLE+0FEh]
		mov	word ptr [bp+2], bx
		pop	bx
		popf
		pop	bp
		ret
		db	90h			; 00EF
HANDLER_TABLE	label	word		; 00F0: 128 words filled at run time; the handler
					; at 00CC indexes them down from 01EEh
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
C0_EMPTY_FAR_HOOK label far		; 01F0: an empty far routine; the far data segment's
					; callback slot at 1B2D:0076 points here (name: descriptive)
		retf			; 01F0
		int	40h
		retf

CODE0		ends
; CPP_FAR_DATA is the far data segment right after DGROUP's stack (1B2Dh; it starts with
; the heap's "VDISK" extended-memory block). It is declared only here, after its use: the
; MZ relocations of this module come in the order 0001, 00AC, 000D, and TASM writes the
; fixup of `mov ax,seg CPP_FAR_DATA` after the call's only when the symbol is a forward
; reference (declared before use, the order is 0001, 000D, 00AC; tested). A segment
; defined at this point gives the same order; which of the two the original had and the
; symbol's name are not known.
		extrn	CPP_FAR_DATA:far
		end
