; /* target: CODE_2_RG2CREST */
; /* opts: /ml */
;
; CODE_2:45E6..4664, hand-written assembly: DOS file wrappers used by the
; CODE_2 overlay and swap code (callers at 3484..4FE1).  Near pascal.
; RH_DOS_DELETE (delete, AH=41h) and RH_DOS_CLOSE (close, AH=3Eh), accepted as C, and
; the dup wrapper at 4682 (AH=45h, not yet source) follow in the same
; style; they may have been one original module.
;
; RH_DOS_OPEN(path, mode)     AH=3Dh: handle, or -1 with CF set.
; RH_DOS_CREATE(path, unused) AH=3Ch, attribute 0: handle, or -1 with CF.
; RH_DOS_READ(handle, buf, n) AH=3Fh: bytes read, or the DOS error code
;                             with CF set; after a short read CF is also
;                             set (cmp ax,n borrows), so callers cannot
;                             tell the two apart.  ZF when all were read.
; RH_DOS_WRITE(handle, buf, n) AH=40h: as read.
; RH_DOS_SEEK(handle, offset, whence) AH=42h: the new position in DX:AX,
;                             or -1L with CF set.

CODE2		segment byte public 'CODE'
		assume	cs:CODE2

		public	RH_DOS_OPEN
		public	RH_DOS_CREATE
		public	RH_DOS_READ
		public	RH_DOS_WRITE
		public	RH_DOS_SEEK

RH_DOS_OPEN	proc	near
		push	bp
		mov	bp,sp
		push	ds
		lds	dx,[bp+6]		; path
		mov	al,[bp+4]		; access mode
		mov	ah,3Dh
		int	21h
		pop	ds
		jae	opened
		sbb	ax,ax			; -1
opened:
		pop	bp
		ret	6
RH_DOS_OPEN	endp

RH_DOS_CREATE	proc	near
		push	bp
		mov	bp,sp
		push	ds
		lds	dx,[bp+6]		; path
		mov	ax,3C00h
		xor	cx,cx			; normal file
		int	21h
		pop	ds
		jae	created
		sbb	ax,ax			; -1
created:
		pop	bp
		ret	6
RH_DOS_CREATE	endp

RH_DOS_READ	proc	near
		push	bp
		mov	bp,sp
		push	ds
		mov	bx,[bp+0Ah]		; handle
		lds	dx,[bp+6]		; buffer
		mov	cx,[bp+4]		; count
		mov	ah,3Fh
		int	21h
		jb	read_done
		cmp	ax,cx
read_done:
		pop	ds
		pop	bp
		ret	8
RH_DOS_READ	endp

RH_DOS_WRITE	proc	near
		push	bp
		mov	bp,sp
		push	ds
		mov	bx,[bp+0Ah]		; handle
		lds	dx,[bp+6]		; buffer
		mov	cx,[bp+4]		; count
		mov	ah,40h
		int	21h
		jb	write_done
		cmp	ax,cx
write_done:
		pop	ds
		pop	bp
		ret	8
RH_DOS_WRITE	endp

RH_DOS_SEEK	proc	near
		push	bp
		mov	bp,sp
		mov	bx,[bp+0Ah]		; handle
		mov	dx,[bp+6]		; offset, low word
		mov	cx,[bp+8]		; offset, high word
		mov	al,[bp+4]		; whence
		mov	ah,42h
		int	21h
		jae	seeked
		sbb	ax,ax
		cwd				; -1L
seeked:
		pop	bp
		ret	8
RH_DOS_SEEK	endp

CODE2		ends

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		end
