; /* target: CODE_0_C0 */
; /* opts: /ml */
;
; CODE_0:0000..02C9, hand-written assembly: BCC's start-up code (C0).
;   0000  BCC_START: the program entry (declared by the link, CB000).  Fills the DGROUP start-up words
;         (+04h..+1Dh) from the PSP and stack, probes a DOS extender
;         (int 21h AX=E800h/E802h), copies the command tail onto the stack
;         and splits it into argv, adds the program path (DOS 3+), moves
;         SS to DGROUP, clears the BSS and stack, and calls the main
;         driver (COMPILER_MAIN_ENTRY).
;   0146  C0_TERMINATE (terminate): int 21h AH=4Ch with the status at [bp+4].
;   014F  an INT handler dispatching through HANDLER_TABLE by the byte
;         after the caller's INT instruction.
;   0180  HANDLER_TABLE (128 words, 9090h until filled).
;   0280  retf / int 40h / retf stubs.
;   0284  "Runtime overlay error"
;   029B  _abort: report through the status hook, print the message on
;         stderr and exit with status 4.
; The DGROUP offsets 5C96h, 8C4Eh and 8C50h are the BSS start, end and
; stack bottom in the original link.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends
		extrn	COMPILER_MAIN_ENTRY:far
		.186
CODE0		segment byte public 'CODE'
		assume	cs:CODE0
		public	BCC_START
		public	C0_TERMINATE
		public	C0_INT_DISPATCH_HANDLER
		public	_abort
BCC_START:
		mov	dx,DGROUP		; 0000
		mov	es, dx		; 0003
		mov	di, sp		; 0005
		mov	word ptr es:[16h], ds		; 0007
		mov	bx, ss		; 000C
		mov	ax, di		; 000E
		add	ax, 0Fh		; 0010
		shr	ax, 1		; 0013
		shr	ax, 1		; 0015
		shr	ax, 1		; 0017
		shr	ax, 1		; 0019
		add	bx, ax		; 001B
		cmp	word ptr es:[16h], 7		; 001D
		jne	L005E		; 0023
		push	dx		; 0025
		mov	ax, 0E800h		; 0026
		mov	cx, 0FFFFh		; 0029
		mov	dx, cx		; 002C
		int	21h		; 002E
		mov	ax, 0E800h		; 0030
		int	21h		; 0033
		mov	word ptr es:[4], ax		; 0035
		mov	word ptr es:[0Ch], ax		; 0039
		mov	byte ptr es:[1Ah], 8		; 003D
		mov	ax, 0E802h		; 0043
		mov	cx, 0FFFFh		; 0046
		mov	dx, cx		; 0049
		int	21h		; 004B
		mov	ax, 0E802h		; 004D
		int	21h		; 0050
		mov	word ptr es:[1Bh], ax		; 0052
		mov	word ptr es:[1Dh], bx		; 0056
		pop	dx		; 005B
		jmp	short L007A		; 005C
L005E:
		mov	word ptr es:[4], bx		; 005E
		mov	word ptr es:[0Ch], bx		; 0063
		mov	ax, bx		; 0068
		mov	cx, word ptr ds:[2]		; 006A
		mov	word ptr es:[8], cx		; 006E
		mov	word ptr es:[10h], cx		; 0073
		sub	cx, ax		; 0078
L007A:
		mov	word ptr es:[12h], ds		; 007A
		mov	cx, word ptr ds:[2Ch]		; 007F
		mov	word ptr es:[14h], cx		; 0083
		mov	ch, 0		; 0088
		mov	si, 81h		; 008A
		mov	cl, byte ptr ds:[80h]		; 008D
		mov	ax, cx		; 0091
		sub	di, cx		; 0093
		dec	di		; 0095
		and	di, 0FFFEh		; 0096
		mov	sp, di		; 0099
		push	ss		; 009B
		pop	es		; 009C
		cld		; 009D
		rep movsb		; 009E
		mov	bp, di		; 00A0
		mov	ds, dx		; 00A2
		mov	es, dx		; 00A4
		push	ax		; 00A6
		xor	ax, ax		; 00A7
		mov	cx, 8C4Eh		; 00A9
		mov	di, 5C96h		; 00AC
		sub	cx, di		; 00AF
		rep stosb		; 00B1
		pop	cx		; 00B3
		mov	bx, 1		; 00B4
		push	ax		; 00B7
		push	ax		; 00B8
		mov	byte ptr [bp], al		; 00B9
		jcxz	L00DF		; 00BC
L00BE:
		dec	bp		; 00BE
		cmp	byte ptr [bp], 20h		; 00BF
		je	L00CF		; 00C3
		cmp	byte ptr [bp], 9		; 00C5
		je	L00CF		; 00C9
		mov	ah, 1		; 00CB
		jmp	short L00DD		; 00CD
L00CF:
		or	ah, ah		; 00CF
		mov	byte ptr [bp], al		; 00D1
		je	L00DD		; 00D4
		inc	bp		; 00D6
		push	ss		; 00D7
		push	bp		; 00D8
		dec	bp		; 00D9
		inc	bx		; 00DA
		xor	ax, ax		; 00DB
L00DD:
		loop	L00BE		; 00DD
L00DF:
		or	ah, ah		; 00DF
		je	L00E6		; 00E1
		inc	bx		; 00E3
		push	ss		; 00E4
		push	bp		; 00E5
L00E6:
		push	ss		; 00E6
		push	bp		; 00E7
		push	bx		; 00E8
		mov	ah, 30h		; 00E9
		int	21h		; 00EB
		pop	bx		; 00ED
		cmp	al, 3		; 00EE
		jb	L010C		; 00F0
		pop	ax		; 00F2
		pop	ax		; 00F3
		mov	es, word ptr ds:[14h]		; 00F4
		xor	ax, ax		; 00F8
		mov	di, ax		; 00FA
		mov	cx, ax		; 00FC
		dec	cx		; 00FE
L00FF:
		repne scasb		; 00FF
		inc	di		; 0101
		cmp	byte ptr es:[di-1], al		; 0102
		jne	L00FF		; 0106
		inc	di		; 0108
		inc	di		; 0109
		push	es		; 010A
		push	di		; 010B
L010C:
		mov	ax, sp		; 010C
		push	ss		; 010E
		push	ax		; 010F
		push	bx		; 0110
		cmp	byte ptr ds:[1Ah], 8		; 0111
		jne	L011D		; 0116
		mov	ax, 8C50h		; 0118
		jmp	short L0127		; 011B
L011D:
		mov	ax, ss		; 011D
		mov	bx, ds		; 011F
		sub	ax, bx		; 0121
		mov	cl, 4		; 0123
		shl	ax, cl		; 0125
L0127:
		mov	bx, ds		; 0127
		cli		; 0129
		mov	ss, bx		; 012A
		add	sp, ax		; 012C
		sti		; 012E
		xor	ax, ax		; 012F
		mov	es, bx		; 0131
		mov	cx, sp		; 0133
		mov	di, 8C50h		; 0135
		sub	cx, di		; 0138
		rep stosb		; 013A
		xor	bp, bp		; 013C
		call	far ptr COMPILER_MAIN_ENTRY		; 013E
		push	ax		; 0143
		push	ax		; 0144
		push	ax		; 0145
C0_TERMINATE:
		mov	bp, sp		; 0146
		mov	al, byte ptr [bp+4]		; 0148
		mov	ah, 4Ch		; 014B
		int	21h		; 014D
C0_INT_DISPATCH_HANDLER:
		sti		; 014F
		push	bx		; 0150
		push	bp		; 0151
		mov	bp, sp		; 0152
		push	es		; 0154
		mov	bx, word ptr [bp+4]		; 0155
		xchg	word ptr [bp+6], bx		; 0158
		xchg	word ptr [bp+8], bx		; 015B
		xchg	word ptr [bp+2], bx		; 015E
		mov	word ptr [bp+4], bx		; 0161
		les	bx, dword ptr [bp+6]		; 0164
		inc	word ptr [bp+6]		; 0167
		mov	bl, byte ptr es:[bx]		; 016A
		mov	bh, 0		; 016D
		shl	bx, 1		; 016F
		neg	bx		; 0171
		mov	bx, word ptr cs:[bx+offset HANDLER_TABLE+0FEh]		; 0173
		xchg	word ptr [bp+4], bx		; 0178
		pop	es		; 017B
		pop	bp		; 017C
		popf		; 017D
		ret		; 017E
		db	90h			; 017F
HANDLER_TABLE	label	word		; 0180: 128 words filled at run time; the handler at
					; 014F indexes them down from 027Eh
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		dw	9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h,9090h
		retf		; 0280
		int	40h		; 0281
		retf		; 0283
OVERLAY_ERROR	db	'Runtime overlay error',13,10	; 0284
_abort:
		mov	bx,DGROUP		; 029B
		mov	ds, bx		; 029E
		mov	word ptr ds:[6C2h], ax		; 02A0
		mov	bx, 2		; 02A3
		push	bx		; 02A6
		push	ax		; 02A7
		call	dword ptr ds:[5EA8h]		; 02A8
		mov	cx, 17h		; 02AC
		mov	dx, offset OVERLAY_ERROR		; 02AF
		push	cs		; 02B2
		pop	ds		; 02B3
		mov	ah, 40h		; 02B4
		mov	bx, 2		; 02B6
		int	21h		; 02B9
		mov	ax, 4		; 02BB
		push	ax		; 02BE
		mov	ax,DGROUP		; 02BF
		mov	ds, ax		; 02C2
		nosmart
		call	far ptr C0_TERMINATE
		smart		; 02C4

CODE0		ends
		end
