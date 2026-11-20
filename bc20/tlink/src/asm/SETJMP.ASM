; /* target: A_SETJMP */
; /* opts: /ml */
; SETJMP.ASM: TLINK's own setjmp and longjmp, far pascal (the run-time library's are
; cdecl).  The C++ name demangler (UNMANGLE.C) leaves through them when a name does not
; parse.  A jump buffer is 10 words: SP and SS as they will be after SETJMP returns,
; the flags, the return address (segment, then offset), BP, DI, ES, SI and DS.
; SETJMP(buffer) fills it and returns 0; LONGJMP(buffer, value) restores it and returns
; from SETJMP again with value (1 when value is 0), through an iret on the saved flags
; and return address.  The pop and retf after the iret are never reached.

		public	SETJMP
		public	LONGJMP

SETJMP_TEXT	segment para public 'CODE'
		assume	cs:SETJMP_TEXT

; int far pascal SETJMP(JUMP_BUFFER far *buffer)
SETJMP		proc	far
		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	dx, es
		mov	cx, di
		les	di, [bp+6]		; buffer
		cld
		lea	ax, [bp+6]		; SP after the return (the argument popped)
		stosw
		mov	ax, ss
		stosw
		pushf
		pop	ax
		stosw
		mov	ax, [bp+4]		; return segment
		stosw
		mov	ax, [bp+2]		; return offset
		stosw
		mov	ax, [bp]		; the caller's BP
		stosw
		mov	ax, cx			; DI
		stosw
		mov	ax, dx			; ES
		stosw
		mov	ax, si
		stosw
		mov	ax, ds
		stosw
		mov	es, dx
		xor	ax, ax
		pop	di
		pop	si
		pop	bp
		ret	4
SETJMP		endp

; void far pascal LONGJMP(JUMP_BUFFER far *buffer, int value)
LONGJMP		proc	far
		push	bp
		mov	bp, sp
		push	si
		push	di
		mov	bx, [bp+6]		; value
		cmp	bx, 1			; 0 becomes 1
		adc	bx, 0
		lds	si, [bp+8]		; buffer
		cld
		lodsw
		mov	ss, [si]
		mov	sp, ax
		lodsw
		lodsw				; flags
		push	ax
		lodsw				; return segment
		push	ax
		lodsw				; return offset
		push	ax
		lodsw
		mov	bp, ax
		lodsw
		mov	di, ax
		lodsw
		mov	es, ax
		lodsw
		mov	ds, [si]
		mov	si, ax
		mov	ax, bx
		iret
		pop	di
		pop	si
		pop	bp
		ret	6
LONGJMP		endp

SETJMP_TEXT	ends
		end
