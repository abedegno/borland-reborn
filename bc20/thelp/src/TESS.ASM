; TESS.ASM: the resident kernel of the TesSeRact(tm) TSR library 1.10 (ASM),
; (c) 1986-1988 TesSeRact Development Team, which THELP is built on. It is the
; first module: it holds the COM entry point, the interrupt handlers that decide
; when the program may pop up, and the INT 2Fh interface.
;
; Borland linked this module as an object; it was assembled with MASM, which
; encodes OR and AND with a word immediate in full where TASM uses the short
; form, so those 14 instructions are written as bytes (see each comment).
; The library's own names are not known: the names here are descriptive, or
; give the address.
	locals
	.186
code	segment	byte public 'CODE'
	assume	cs:code,ds:code,es:code,ss:code
	org	100h
	public	dosmajor
	public	indosptr
	public	critptr
	public	tsrinfo
	public	tsrnumber
	public	tsrhotscan
	public	tsrhotshift
	public	tsrflags
	public	tsrpsp
	public	tsrdta
	public	tsrcs
	public	fgstack
	public	bgstack
	public	nullint
	public	tsrhook
	public	getpsp
	extrn	popup_main:near
	extrn	tsrdone:near
	extrn	beep:near
	extrn	tsrsetup:near
	extrn	main:near

; COM entry: TesSeRact's startup jumps to the program's own main (THELP.ASM)
start:	jmp	main

; TesSeRact's state; the names are descriptive (the library's own names are
; not known)
tsrclear	db	1Bh, '[2J', 1Ah, 0, 1
tsrpopkey	db	0
tsrin08	db	0
tsrin13	db	0
tsrstate	db	0
tsrkbstate	db	0
dosmajor	db	0
idlecount	db	0
indosptr	db	0, 0, 0, 0
critptr	db	0, 0, 0, 0
tsrsave1	dw	0, 0, 0, 0, 0, 0
fgss	db	0, 0
fgsp	db	0, 0
bgss	db	0, 0
bgsp	db	0, 0
userint24	db	0, 0, 0, 0
dosextsave	db	6 dup (0)
breakflag	db	0
verifyflag	db	0
tsrbyte139	db	0
tsrbyte13A	db	0
kbextended	db	0
tsrbyte13C	db	0
old08	dd	0
	db	8
	dw	offset int08
old09	dd	0
	db	9
	dw	offset int09
old13	dd	0
	db	13h
	dw	offset int13
old16	dd	0
	db	16h
	dw	offset int16
old1c	dd	0
	db	1Ch
	dw	offset int1c
old21	dd	0
	db	21h
	dw	offset int21
old28	dd	0
	db	28h
	dw	offset int28
old2f	dd	0
	db	2Fh
	dw	offset int2f_entry
old1b	dd	0
	db	1Bh
	dw	offset nullint
old23	dd	0
	db	23h
	dw	offset nullint
old24	dd	0
	db	24h
	dw	offset int24

; the INT 2Fh entry, also the old-vector slot of the INT 24h record above it
int2f_entry:	jmp	int2f

; the information block INT 2Fh function 1 returns
tsrinfo	db	8 dup (0)
tsrnumber	dw	0
tsrunused	db	0FFh, 0FFh, 0FFh, 0FFh
tsrhotscan	db	0
tsrhotshift	db	0
tsrbyte19D	db	0
tsruserdl	db	0
tsruserptr	dw	0, 0
tsrflags	db	0, 0
tsrpsp	db	0, 0
tsrdta	dw	0, 0
tsrcs	db	0, 0
fgstack	dw	0, 0
bgstack	dw	0, 0
tsrcopyright	db	'TesSeRact(tm) Library, Version 1.10 (ASM)', 0Dh, 0Ah, 'Copyright (c) 1986, 1987, 1988 TesSeRact Development Team'
	db	0Dh, 0Ah, 'All Rights Reserved', 0Dh, 0Ah
tsr2fpad	db	0

; INT 2Fh 5453h ('TS'): the handler of each function in BX
tsr2ftable	dw	offset tsr2f_check, offset tsr2f_info, offset tsr2f_query, offset tsr2f_setuser24, offset tsr2f_psp, offset tsr2f_setuser
	dw	offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain
	dw	offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_enable, offset tsr2f_disable
	dw	offset tsr2f_popup, offset tsr2f_cancel, offset tsr2f_getflags, offset tsr2f_setflags, offset tsr2f_getkey, offset tsr2f_chain
	dw	offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain
	dw	offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_wait, offset tsr2f_bgcall, offset tsr2f_unload, offset tsr2f_stuff
	dw	offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain
	dw	offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain, offset tsr2f_chain
tsr2f_done:	add	sp, 4
	xor	ax, ax
tsr2f_iret:	iret
tsr2f_inc:	inc	cx
tsr2f_chain:	pop	bx
	pop	ax
tsr2f_old:	jmp	dword ptr cs:old2f

; INT 2Fh: TesSeRact's multiplex interface (AX = 5453h, BX = function)
int2f:	cmp	ax, 5453h
	jne	tsr2f_old
	cmp	bx, 2Fh
	ja	tsr2f_old
	push	ax
	push	bx
	or	bx, bx
	je	tsr2f_check
	cmp	bx, 2
	je	tsr2f_query
	cmp	cx, word ptr cs:tsrnumber
	jne	tsr2f_chain
	shl	bx, 1
	add	bx, offset tsr2ftable
	jmp	word ptr cs:[bx]
tsr2f_check:	push	cx
	push	si
	mov	di, offset tsrinfo
	push	cs
	pop	es
	mov	cx, 8
	repe cmpsb
	pop	si
	pop	cx
	jne	tsr2f_inc
	pop	bx
	pop	ax
	mov	cx, word ptr es:[di]
	test	word ptr cs:tsrflags, 400h
	je	@@1
	or	cx, 0FF00h
@@1:	xor	ax, ax
	dec	ax
	jmp	tsr2f_iret
tsr2f_info:	mov	bx, offset tsrinfo
	push	cs
	pop	es
	jmp	tsr2f_done
tsr2f_query:	cmp	cl, byte ptr cs:tsrhotscan
	jne	tsr2f_chain
	xor	ax, ax
	dec	ax
	add	sp, 4
	jmp	tsr2f_iret
tsr2f_setuser24:	mov	word ptr cs:userint24, si
	mov	ax, ds
	mov	word ptr cs:userint24+2, ax
	or	word ptr cs:tsrflags, 800h
	jmp	tsr2f_done
tsr2f_psp:	mov	bx, 109h
	push	cs
	pop	es
	jmp	tsr2f_done
tsr2f_setuser:	mov	word ptr cs:tsruserptr, si
	mov	ax, ds
	mov	word ptr cs:tsruserptr+2, ax
	mov	byte ptr cs:tsruserdl, dl
	or	word ptr cs:tsrflags, 80h
	jmp	tsr2f_done
tsr2f_enable:	or	word ptr cs:tsrflags, 200h
	jmp	tsr2f_done
tsr2f_disable:	and	word ptr cs:tsrflags, 0FDFFh
	jmp	tsr2f_done
tsr2f_popup:	and	word ptr cs:tsrflags, 0FDFFh
	test	word ptr cs:tsrflags, 4
	jne	@@1
	db	2Eh, 81h, 0Eh, 0A3h, 1, 11h, 0	; or word ptr cs:tsrflags, 11h  (MASM's encoding: TASM sign-extends a byte immediate)
@@1:	or	word ptr cs:tsrflags, 400h
	jmp	tsr2f_done
tsr2f_cancel:	and	word ptr cs:tsrflags, 0FBFEh
	or	word ptr cs:tsrflags, 200h
	jmp	tsr2f_done
tsr2f_getflags:	mov	bx, word ptr cs:tsrflags
	jmp	tsr2f_done
tsr2f_setflags:	mov	word ptr cs:tsrflags, dx
	jmp	tsr2f_done
tsr2f_getkey:	test	word ptr cs:tsrflags, 4
	jne	@@1
	jmp	tsr2f_chain
@@1:	mov	bl, byte ptr cs:tsrpopkey
	xor	bh, bh
	jmp	tsr2f_done
tsr2f_wait:	test	word ptr cs:tsrflags, 100h
	jne	@@1
	jmp	tsr2f_chain
@@1:	test	word ptr cs:tsrflags, 8
	jne	tsr2f_wait
	db	2Eh, 81h, 0Eh, 0A3h, 1, 8, 0	; or word ptr cs:tsrflags, 8  (MASM's encoding: TASM sign-extends a byte immediate)
	cli
	mov	word ptr cs:bgss, ss
	mov	word ptr cs:bgsp, sp
	mov	ss, word ptr cs:bgstack+2
	mov	sp, word ptr cs:bgstack
	sti
	push	ds
	mov	ax, word ptr cs:tsrcs
	mov	ds, ax
	call	tsrdone
	pop	ds
	cli
	mov	ss, word ptr cs:bgss
	mov	sp, word ptr cs:bgsp
	sti
	db	2Eh, 81h, 26h, 0A3h, 1, 0F7h, 0FFh	; and word ptr cs:tsrflags, 0FFF7h  (MASM's encoding: TASM sign-extends a byte immediate)
	jmp	tsr2f_done
tsr2f_bgcall:	call	stuffnext
	add	sp, 4
	jmp	tsr2f_iret
tsr2f_unload:	db	2Eh, 81h, 0Eh, 0A3h, 1, 3, 0	; or word ptr cs:tsrflags, 3  (MASM's encoding: TASM sign-extends a byte immediate)
	jmp	tsr2f_done
tsr2f_stuff:	call	tsrstuff
	add	sp, 4
	jmp	tsr2f_iret

; INT 13h: notes when the BIOS disk services are in use
int13:	pushf
	or	byte ptr cs:tsrstate, 4
	mov	byte ptr cs:tsrin13, 1
	push	cs
	call	nullint
	pushf
	call	dword ptr cs:old13
	pushf
	and	byte ptr cs:tsrstate, 0FBh
	push	cs
	call	nullint
	retf	2

; puts AX into the BIOS keyboard buffer; AX = FFFFh when it is full
stuffkey:	push	es
	push	si
	push	bx
	pushf
	cli
	push	ax
	xor	ax, ax
	mov	ax, 40h
	mov	es, ax
	pop	ax
	mov	bx, word ptr es:[1Ch]
	mov	si, bx
	or	di, di
	jne	@@1
	cmp	bx, word ptr es:[1Ah]
	jne	@@3
@@1:	inc	bx
	inc	bx
	cmp	bx, word ptr es:[82h]
	jne	@@2
	mov	bx, word ptr es:[80h]
@@2:	cmp	bx, word ptr es:[1Ah]
	je	@@3
	mov	word ptr es:[si], ax
	mov	word ptr es:[1Ch], bx
	xor	ax, ax
	jmp	short @@4
@@3:	xor	ax, ax
	dec	ax
@@4:	push	cs
	call	nullint
	pop	bx
	pop	si
	pop	es
	ret

; INT 16h: watches for the hot key and feeds stuffed keys
int16:	or	byte ptr cs:tsrkbstate, 10h
	cmp	ax, 55FFh
	je	@@3
	test	ah, 10h
	je	@@1
	mov	byte ptr cs:kbextended, 10h
	and	ah, 0EFh
@@1:	cmp	ah, 0
	je	@@7
	cmp	ah, 1
	je	@@5
@@2:	and	byte ptr cs:tsrkbstate, 0EFh
	or	ah, byte ptr cs:kbextended
	mov	byte ptr cs:kbextended, 0
	jmp	dword ptr cs:old16
@@3:	cmp	bx, 4
	jne	@@2
	or	cx, cx
	je	@@4
	mov	byte ptr cs:tsrbyte139, 0
	jmp	@@2
@@4:	mov	byte ptr cs:tsrbyte139, 1
	jmp	@@2
@@5:	push	ds
	push	cs
	pop	ds
	call	kbcheck
	pushf
@@6:	mov	byte ptr kbextended, 0
	and	byte ptr tsrkbstate, 0EFh
	push	cs
	call	nullint
	pop	ds
	push	ax
	pushf
	pop	ax
	push	bp
	mov	bp, sp
	or	ax, 200h
	mov	word ptr [bp+8], ax
	pop	bp
	pop	ax
	iret
@@7:	push	ds
	push	cs
	pop	ds
@@8:	call	kbcheck
	je	@@8
	pushf
	mov	ah, 0
	or	ah, byte ptr kbextended
	call	dword ptr old16
	pushf
	jmp	@@6

; INT 1Ch: the user timer tick
int1c:	push	ds
	push	cs
	pop	ds
	pushf
	test	word ptr tsrflags, 200h
	je	@@1
	test	byte ptr tsrkbstate, 80h
	je	@@2
@@1:	push	cs
	call	nullint
	pop	ds
	jmp	dword ptr cs:old1c
@@2:	or	byte ptr tsrkbstate, 80h
	push	cs
	call	nullint
	pushf
	call	dword ptr old1c
	sti
	push	ax
	mov	ax, word ptr tsrflags
	test	ax, 40h
	je	@@3
	push	bx
	push	cx
	push	dx
	push	es
	mov	ax, word ptr tsrcs
	push	ax
	push	ax
	pop	ds
	pop	es
	sti
	call	tsrdone
	pop	es
	pop	dx
	pop	cx
	pop	bx
@@3:	and	byte ptr cs:tsrkbstate, 7Fh
	pop	ax
	pop	ds
	iret
tsrbuf562	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0FFh, 0FFh
	db	0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
	db	0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0
	db	0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0, 0FFh, 0, 0
	db	0, 0, 0, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
	db	0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0, 0, 0
	db	0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0, 0FFh, 0, 0FFh, 0FFh, 0, 0FFh
	db	0FFh, 0FFh, 0FFh, 0FFh, 0, 0, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
	db	0FFh, 0FFh

; INT 21h: watches DOS calls
int21:	pushf
	cli
	test	byte ptr cs:tsrstate, 8
	je	@@1
	cmp	ah, 0Ah
	jne	@@2
	and	byte ptr cs:tsrstate, 0F7h
	and	byte ptr cs:tsrkbstate, 0BFh
@@1:	cmp	ah, 63h
	ja	@@2
	push	ax
	push	bx
	mov	bx, 563h
	mov	al, ah
	xlat	byte ptr cs:[bx]
	or	al, al
	pop	bx
	pop	ax
	jne	@@4
@@2:	test	word ptr cs:tsrflags, 4
	je	@@3
	cmp	byte ptr cs:tsrpopkey, 1
	jne	@@3
	cmp	ah, 0Ch
	ja	@@3
	or	ah, ah
	je	@@3
	push	es
	push	di
	push	ax
	les	di, dword ptr cs:critptr
	mov	ax, 0FFFFh
	stosb
	pop	ax
	pop	di
	pop	es
	jmp	short @@4
@@3:	push	cs
	call	nullint
	jmp	dword ptr cs:old21
@@4:	or	byte ptr cs:tsrstate, 8
	push	cs
	call	nullint
	pushf
	call	dword ptr cs:old21
	pushf
	and	byte ptr cs:tsrstate, 0F7h
	push	cs
	call	nullint
	sti
	retf	2
tsrword64D	db	0, 0

; INT 24h: critical errors while popped up
int24:	pushf
	test	word ptr cs:tsrflags, 800h
	je	@@1
	push	cs
	call	nullint
	jmp	dword ptr cs:userint24
@@1:	cmp	byte ptr cs:dosmajor, 3
	jae	@@2
	push	cs
	call	nullint
	add	sp, 6
	mov	word ptr cs:tsrword64D, di
	les	di, dword ptr cs:critptr
	xor	al, al
	stosb
	sti
	pop	ax
	pop	bx
	pop	cx
	pop	dx
	pop	si
	pop	di
	pop	bp
	pop	ds
	pop	es
	push	ax
	push	dx
	mov	ax, 3300h
	int	21h
	pop	dx
	pop	ax
	mov	ax, word ptr cs:tsrword64D
	add	ax, 13h
	push	bp
	mov	bp, sp
	db	81h, 4Eh, 6, 1, 0	; or word ptr [bp+6], 1  (MASM's encoding: TASM sign-extends a byte immediate)
	pop	bp
	iret
@@2:	push	cs
	call	nullint
	mov	al, 3
	iret
tsrbyte6A9:	db	8
tsrstuff:	mov	ax, word ptr tsrflags
	test	ax, 20h
	je	@@3
	test	ax, 8
	je	@@1
	jmp	short @@3
@@1:	cld
	push	ds
	push	si
	lds	si, dword ptr critptr
	lodsb
	or	al, byte ptr cs:tsrstate
	mov	ah, al
	lds	si, dword ptr cs:indosptr
	lodsb
	mov	byte ptr cs:tsrpopkey, al
	and	al, 0FEh
	or	al, ah
	pop	si
	pop	ds
	jne	@@3
	db	81h, 0Eh, 0A3h, 1, 8, 0	; or word ptr tsrflags, 8  (MASM's encoding: TASM sign-extends a byte immediate)
	push	ds
	push	es
	mov	ax, word ptr tsrcs
	push	ax
	push	ax
	pop	es
	pop	ds
	call	tsrdone
	pop	es
	pop	ds
	or	ax, ax
	je	@@2
	call	bgcall
@@2:	db	81h, 26h, 0A3h, 1, 0F7h, 0FFh	; and word ptr tsrflags, 0FFF7h  (MASM's encoding: TASM sign-extends a byte immediate)
	mov	byte ptr tsrpopkey, 0
	xor	ax, ax
	jmp	short @@4
@@3:	mov	ax, 0FFFFh
@@4:	ret

; INT 28h: DOS idle
int28:	push	ds
	push	cs
	pop	ds
	pushf
	test	word ptr tsrflags, 400h
	jne	@@1
	test	word ptr tsrflags, 200h
	je	@@2
@@1:	test	byte ptr tsrkbstate, 20h
	je	@@3
@@2:	push	cs
	call	nullint
	pop	ds
	jmp	dword ptr cs:old28
@@3:	push	cs
	call	nullint
	pushf
	cli
	call	dword ptr old28
	sti
	or	byte ptr tsrkbstate, 20h
	push	dx
	push	cx
	push	bx
	push	ax
	call	tsrstuff
	mov	ax, word ptr tsrflags
	test	ax, 8
	jne	@@6
	test	ax, 10h
	je	@@6
	test	ax, 1
	je	@@6
	test	ax, 4
	jne	@@6
	cld
	push	ds
	push	si
	lds	si, dword ptr critptr
	lodsb
	or	al, byte ptr cs:tsrstate
	mov	ah, al
	lds	si, dword ptr cs:indosptr
	lodsb
	mov	byte ptr cs:tsrpopkey, al
	and	al, 0FEh
	or	al, ah
	pop	si
	pop	ds
	jne	@@5
	and	byte ptr tsrkbstate, 0DFh
	call	popup
	mov	byte ptr tsrpopkey, 0
@@4:	mov	byte ptr tsrbyte6A9, 8
	jmp	short @@6
@@5:	dec	byte ptr tsrbyte6A9
	jne	@@6
	test	word ptr tsrflags, 400h
	jne	@@4
	db	81h, 26h, 0A3h, 1, 0FEh, 0FFh	; and word ptr tsrflags, 0FFFEh  (MASM's encoding: TASM sign-extends a byte immediate)
	call	beep
	jmp	@@4
@@6:	and	byte ptr tsrkbstate, 0DFh
	mov	byte ptr idlecount, 0
	pop	ax
	pop	bx
	pop	cx
	pop	dx
	pop	ds
	iret
stuffcount	db	0, 0
stuffbyte1	db	0
stuffbyte2	db	0, 0
stuffbuf	db	160 dup (0)
stuffhead	db	0BEh, 7
stufftail	db	0BEh, 7
stuffbyte3	db	8
stuffticks	db	0
stuffinit:	push	ax
	xor	ax, ax
	mov	word ptr stuffcount, ax
	mov	ax, offset stuffbuf
	mov	word ptr stuffhead, ax
	mov	word ptr stufftail, ax
	mov	byte ptr stuffticks, 12h
	pop	ax
	ret
stuffnext:	push	ds
	push	cs
	pop	ds
	mov	al, byte ptr stuffticks
	or	al, al
	jne	@@5
	or	si, si
	je	@@6
	cli
	mov	ax, 4Fh
	sub	ax, word ptr stuffcount
	cmp	ax, si
	jbe	@@6
	mov	cx, si
	mov	byte ptr stuffbyte1, dl
@@1:	mov	bx, word ptr stufftail
	or	dh, dh
	je	@@2
	mov	al, byte ptr es:[di]
	xor	ah, ah
	cmp	al, 0Dh
	jne	@@3
	mov	ah, 1Ch
	jmp	short @@3
@@2:	mov	ax, word ptr es:[di]
	inc	di
@@3:	inc	di
	mov	word ptr [bx], ax
	inc	bx
	inc	bx
	cmp	bx, 85Ch
	jne	@@4
	mov	bx, offset stuffbuf
@@4:	mov	word ptr stufftail, bx
	inc	word ptr stuffcount
	loop	@@1
	xor	ax, ax
	jmp	short @@7
@@5:	mov	ax, 0F0F0h
	mov	byte ptr stuffticks, 0
	jmp	short @@7
@@6:	xor	ax, ax
	dec	ax
@@7:	sti
	pop	ds
	ret

; INT 08h: the hardware timer
int08:	push	ds
	pushf
	push	cs
	pop	ds
	mov	byte ptr tsrin08, 1
	test	word ptr tsrflags, 200h
	je	@@1
	test	byte ptr tsrkbstate, 40h
	je	@@2
@@1:	push	cs
	call	nullint
	pop	ds
	jmp	dword ptr cs:old08
@@2:	push	cs
	call	nullint
	or	byte ptr tsrkbstate, 40h
	push	dx
	push	cx
	push	bx
	push	ax
	push	di
	pushf
	call	dword ptr old08
	sti
	mov	al, byte ptr stuffticks
	or	al, al
	je	@@3
	dec	byte ptr stuffticks
@@3:	mov	al, byte ptr tsrbyte13C
	or	al, al
	je	@@4
	dec	byte ptr tsrbyte13C
	jne	@@4
	db	81h, 0Eh, 0A3h, 1, 1, 0	; or word ptr tsrflags, 1  (MASM's encoding: TASM sign-extends a byte immediate)
@@4:	mov	ax, word ptr tsrflags
	test	ax, 10h
	je	@@7
	test	ax, 1
	je	@@7
	test	ax, 0Ch
	jne	@@7
	call	@@10
	jne	@@6
	call	popup
@@5:	mov	byte ptr stuffbyte3, 8
	jmp	short @@7
@@6:	dec	byte ptr stuffbyte3
	jne	@@7
	test	word ptr tsrflags, 400h
	jne	@@5
	db	81h, 26h, 0A3h, 1, 0FEh, 0FFh	; and word ptr tsrflags, 0FFFEh  (MASM's encoding: TASM sign-extends a byte immediate)
	call	beep
	jmp	@@5
@@7:	mov	ax, word ptr stuffcount
	or	ax, ax
	je	@@9
	mov	al, byte ptr stuffbyte1
	xor	ah, ah
	mov	di, ax
	mov	bx, word ptr stuffhead
	mov	ax, word ptr [bx]
	call	stuffkey
	cmp	ax, 0FFFFh
	je	@@9
	inc	bx
	inc	bx
	cmp	bx, 85Ch
	jne	@@8
	mov	bx, offset stuffbuf
@@8:	mov	word ptr stuffhead, bx
	dec	word ptr stuffcount
	inc	word ptr stuffbyte2
	mov	ax, di
	or	al, al
	je	@@9
	dec	al
	jne	@@7
	cmp	word ptr stuffbyte2, 4
	jne	@@7
@@9:	xor	ax, ax
	mov	word ptr stuffbyte2, ax
	and	byte ptr tsrkbstate, 0BFh
	pop	di
	pop	ax
	pop	bx
	pop	cx
	pop	dx
	pop	ds
	iret
@@10:	push	ds
	push	si
	push	dx
	mov	dx, 20h
	mov	al, 0Bh
	out	dx, al
	nop
	nop
	nop
	in	al, dx
	and	al, 0FEh
	pop	dx
	lds	si, dword ptr critptr
	or	al, byte ptr [si]
	lds	si, dword ptr cs:indosptr
	or	al, byte ptr [si]
	or	al, byte ptr cs:tsrstate
	mov	si, 50h
	mov	ds, si
	or	al, byte ptr ds:[0]
	pop	si
	pop	ds
	ret

; INT 09h: the keyboard, spots the hot key
int09:	push	ax
	in	al, 60h
	mov	ah, al
	push	ds
	push	si
	push	ax
	mov	ax, 40h
	mov	ds, ax
	mov	si, 17h
	cld
	pop	ax
	lodsb
	pop	si
	pop	ds
	and	al, 0Fh
	push	ds
	push	cs
	pop	ds
	test	word ptr tsrflags, 200h
	je	@@9
	cmp	ah, 46h
	je	@@1
	cmp	ah, 2Eh
	jne	@@2
@@1:	cmp	al, 4
	jne	@@2
	call	stuffinit
	test	word ptr tsrflags, 0Ch
	jne	@@10
@@2:	test	word ptr tsrflags, 0Ch
	jne	@@9
	cmp	al, byte ptr tsrhotshift
	jne	@@5
	cmp	byte ptr tsrhotscan, 0
	je	@@3
	cmp	ah, byte ptr tsrhotscan
	jne	@@5
@@3:	xor	al, al
@@4:	db	81h, 0Eh, 0A3h, 1, 1, 0	; or word ptr tsrflags, 1  (MASM's encoding: TASM sign-extends a byte immediate)
	mov	byte ptr tsrbyte19D, al
	jmp	short @@10
@@5:	test	word ptr tsrflags, 80h
	je	@@9
	push	cx
	push	es
	push	bx
	xor	ch, ch
	mov	cl, byte ptr tsruserdl
	les	bx, dword ptr tsruserptr
@@6:	cmp	byte ptr es:[bx+1], al
	jne	@@8
	cmp	byte ptr es:[bx], 0
	je	@@7
	cmp	byte ptr es:[bx], ah
	jne	@@8
@@7:	mov	al, byte ptr es:[bx+2]
	pop	bx
	pop	es
	pop	cx
	jmp	@@4
@@8:	add	bx, 3
	loop	@@6
	pop	bx
	pop	es
	pop	cx
@@9:	pop	ds
	pop	ax
	jmp	dword ptr cs:old09
@@10:	in	al, 61h
	mov	ah, al
	or	al, 80h
	out	61h, al
	xchg	ah, al
	out	61h, al
	mov	al, 20h
	out	20h, al
	pop	ds
	pop	ax

; a do-nothing interrupt handler (INT 1Bh and 23h while popped up)
nullint:	iret
tsrvecAA4	db	0, 70h, 0, 0

; pops the program up: switches stacks, saves DOS's state, calls popup_main
popup:	cli
	db	81h, 0Eh, 0A3h, 1, 4, 0	; or word ptr tsrflags, 4  (MASM's encoding: TASM sign-extends a byte immediate)
	mov	word ptr fgss, ss
	mov	word ptr fgsp, sp
	mov	ss, word ptr fgstack+2
	mov	sp, word ptr fgstack
	sti
	push	bp
	push	di
	push	si
	push	es
	test	word ptr tsrflags, 400h
	je	@@1
	jmp	@@6
@@1:	mov	ah, 0Fh
	int	10h
	and	al, 7Fh
	mov	byte ptr tsrvecAA4+2, al
	mov	byte ptr tsrvecAA4+3, bh
	cmp	al, 7
	jne	@@2
	call	tsrcheckCB6
	jb	@@2
	xor	al, al
	dec	al
	mov	byte ptr tsrvecAA4+2, al
	mov	byte ptr tsrvecAA4+3, al
@@2:	test	word ptr tsrflags, 1000h
	je	@@5
	mov	al, byte ptr tsrvecAA4+2
	cmp	al, 3
	jbe	@@5
	cmp	al, 7
	je	@@5
	mov	al, byte ptr tsrbyte139
	or	al, al
	je	@@4
	mov	al, byte ptr tsrbyte13A
	or	al, al
	je	@@3
	mov	byte ptr tsrbyte13A, 0
	jmp	short @@4
@@3:	mov	ax, 5453h
	mov	bx, 21h
	mov	cx, word ptr tsrnumber
	mov	si, 1
	mov	di, offset tsrvecAA4
	mov	dx, 0
	push	cs
	pop	es
	int	2Fh
	mov	byte ptr tsrbyte13C, 20h
	mov	byte ptr tsrbyte13A, 1
	jmp	@@10
@@4:	call	beep
	jmp	@@10
@@5:	test	word ptr tsrflags, 2000h
	je	@@6
	mov	al, byte ptr tsrpopkey
	or	al, al
	je	@@6
	call	beep
	jmp	@@10
@@6:	push	es
	mov	ax, 2F00h
	int	21h
	mov	word ptr tsrsave1+6, es
	mov	word ptr tsrsave1+4, bx
	pop	es
	call	getpsp
	mov	word ptr tsrsave1, bx
	mov	bx, word ptr tsrpsp
	call	setpsp
	push	ds
	mov	ax, 1A00h
	mov	dx, word ptr tsrdta
	mov	ds, word ptr tsrdta+2
	int	21h
	pop	ds
	call	savextended
	call	getbreak
	call	getverify
	test	word ptr tsrflags, 400h
	je	@@7
	call	tsrdispatch
	jmp	short @@8
@@7:	xor	ax, ax
	call	tsrhook
	push	ds
	push	es
	mov	ax, word ptr tsrcs
	push	ax
	push	ax
	pop	ds
	pop	es
	call	popup_main
	pop	es
	pop	ds
	xor	ax, ax
	call	savestate
@@8:	mov	al, byte ptr tsrbyte13A
	or	al, al
	je	@@9
	mov	ax, 5453h
	mov	bx, 21h
	mov	cx, word ptr tsrnumber
	mov	si, 1
	mov	di, offset tsrvecAA4
	mov	dx, 0
	push	cs
	pop	es
	int	2Fh
	mov	byte ptr tsrbyte13A, 0
@@9:	call	setverify
	call	setbreak
	call	restextended
	push	ds
	mov	ax, 1A00h
	mov	dx, word ptr tsrsave1+4
	mov	ds, word ptr tsrsave1+6
	int	21h
	pop	ds
	mov	bx, word ptr tsrsave1
	call	setpsp
@@10:	pop	es
	pop	si
	pop	di
	pop	bp
	cli
	mov	ss, word ptr fgss
	mov	sp, word ptr fgsp
	db	81h, 26h, 0A3h, 1, 0F8h, 0FFh	; and word ptr tsrflags, 0FFF8h  (MASM's encoding: TASM sign-extends a byte immediate)
	test	word ptr tsrflags, 400h
	je	@@11
	db	81h, 0Eh, 0A3h, 1, 11h, 0	; or word ptr tsrflags, 11h  (MASM's encoding: TASM sign-extends a byte immediate)
	and	word ptr tsrflags, 0FDFFh
@@11:	sti
	ret
tsrbyteC1B:	db	0

; runs the program's background routine on its own stack
bgcall:	cli
	mov	word ptr bgss, ss
	mov	word ptr bgsp, sp
	mov	ss, word ptr bgstack+2
	mov	sp, word ptr bgstack
	sti
	push	bp
	push	di
	push	si
	push	es
	mov	byte ptr tsrbyteC1B, 0
	test	word ptr tsrflags, 4
	jne	@@1
	mov	byte ptr tsrbyteC1B, 1
	xor	ax, ax
	call	tsrhook
@@1:	push	es
	mov	ax, 2F00h
	int	21h
	mov	word ptr tsrsave1+10, es
	mov	word ptr tsrsave1+8, bx
	pop	es
	call	getpsp
	mov	word ptr tsrsave1+2, bx
	mov	bx, word ptr tsrpsp
	call	setpsp
	push	ds
	mov	ax, 1A00h
	mov	dx, word ptr tsrdta
	mov	ds, word ptr tsrdta+2
	int	21h
	pop	ds
	push	ds
	push	es
	mov	ds, word ptr tsrcs
	mov	es, word ptr tsrcs
	call	tsrdone
	pop	es
	pop	ds
	push	ds
	mov	ax, 1A00h
	mov	dx, word ptr tsrsave1+8
	mov	ds, word ptr tsrsave1+10
	int	21h
	pop	ds
	mov	bx, word ptr tsrsave1+2
	call	setpsp
	cmp	byte ptr tsrbyteC1B, 0
	je	@@2
	xor	ax, ax
	call	savestate
@@2:	pop	es
	pop	si
	pop	di
	pop	bp
	cli
	mov	ss, word ptr bgss
	mov	sp, word ptr bgsp
	sti
	ret
tsrbyteCB5:	db	0FFh
tsrcheckCB6:	cmp	byte ptr tsrbyteCB5, 0FFh
	jne	@@1
	inc	byte ptr tsrbyteCB5
	call	@@8
	jb	@@1
	inc	byte ptr tsrbyteCB5
@@1:	cmp	byte ptr tsrbyteCB5, 0
	je	@@6
	xor	al, al
	mov	dx, 3BAh
@@2:	in	al, dx
	test	al, 80h
	je	@@2
@@3:	in	al, dx
	test	al, 80h
	jne	@@3
	xor	al, al
	mov	dx, 3BBh
	out	dx, al
	mov	dx, 3B9h
	out	dx, al
	mov	al, 10h
	mov	dx, 3B4h
	out	dx, al
	inc	dx
	in	al, dx
	cmp	al, 0Dh
	jb	@@5
@@4:	clc
	jmp	short @@7
@@5:	xor	ax, ax
	mov	es, ax
	mov	al, byte ptr es:[465h]
	test	al, 2
	jne	@@4
@@6:	stc
@@7:	ret
@@8:	mov	dx, 3BAh
	xor	bl, bl
	in	al, dx
	and	al, 80h
	mov	ah, al
	mov	cx, 8000h
@@9:	in	al, dx
	and	al, 80h
	cmp	al, ah
	je	@@10
	inc	bl
	cmp	bl, 0Ah
	jae	@@11
@@10:	loop	@@9
	jmp	short @@12
@@11:	mov	dx, 3B9h
	out	dx, al
	mov	dx, 3BAh
	in	al, dx
	test	al, 2
	je	@@12
	mov	dx, 3BBh
	out	dx, al
	mov	dx, 3BAh
	in	al, dx
	test	al, 2
	jne	@@12
	clc
	jmp	short @@13
@@12:	stc
@@13:	ret

; saves and restores DOS's Ctrl-Break, extended error, verify and PSP state
getbreak:	mov	ax, 3302h
	xor	dl, dl
	int	21h
	mov	byte ptr breakflag, dl
	ret
setbreak:	mov	ax, 3301h
	mov	dl, byte ptr breakflag
	int	21h
	ret
savextended:	push	di
	cmp	byte ptr dosmajor, 3
	jb	@@1
	mov	ah, 59h
	xor	bx, bx
	push	ds
	int	21h
	pop	ds
	mov	word ptr dosextsave, ax
	mov	word ptr dosextsave+2, bx
	mov	word ptr dosextsave+4, cx
@@1:	pop	di
	ret
restextended:	push	di
	cmp	byte ptr dosmajor, 3
	jb	@@1
	mov	dx, offset dosextsave
	mov	ax, 5D0Ah
	int	21h
@@1:	pop	di
	ret
getverify:	mov	ax, 5400h
	int	21h
	mov	byte ptr verifyflag, al
	ret
setverify:	mov	ah, 2Eh
	mov	al, byte ptr verifyflag
	xor	dx, dx
	int	21h
	ret
savestate:	push	ds
	push	ax
	push	dx
	push	si
	push	di
	push	cx
	mov	di, 7
	or	ax, ax
	jne	@@1
	mov	cx, 3
	mov	si, offset old1b
	jmp	short @@2
@@1:	mov	cx, 8
	mov	si, offset old08
@@2:	push	di
	push	ds
	mov	al, byte ptr [si+4]
	mov	dx, word ptr [si]
	mov	ds, word ptr [si+2]
	mov	ah, 25h
	int	21h
	pop	ds
	xor	ax, ax
	mov	word ptr [si], ax
	mov	word ptr [si+2], ax
	pop	di
	add	si, di
	loop	@@2
	pop	cx
	pop	di
	pop	si
	pop	dx
	pop	ax
	pop	ds
	ret

; hooks the vectors of the records above (all when AX is not 0)
tsrhook:	push	es
	push	ax
	push	bx
	push	dx
	push	di
	push	si
	push	cx
	mov	di, 7
	or	ax, ax
	jne	@@1
	mov	cx, 3
	mov	si, offset old1b
	jmp	short @@2
@@1:	mov	cx, 8
	mov	si, offset old08
@@2:	push	di
	mov	ax, word ptr [si]
	or	ax, ax
	jne	@@3
	mov	al, byte ptr [si+4]
	mov	ah, 35h
	int	21h
	mov	word ptr [si], bx
	mov	word ptr [si+2], es
	mov	al, byte ptr [si+4]
	mov	dx, word ptr [si+5]
	mov	ah, 25h
	int	21h
@@3:	pop	di
	add	si, di
	loop	@@2
	pop	cx
	pop	si
	pop	di
	pop	dx
	pop	bx
	pop	ax
	pop	es
	ret

; puts the old vectors back
tsrunhook:	push	ds
	push	es
	push	dx
	push	si
	push	di
	push	cx
	push	bx
	mov	di, 7
	mov	cx, 8
	mov	si, offset old08
@@1:	mov	al, byte ptr [si+4]
	mov	ah, 35h
	int	21h
	mov	ax, es
	mov	bx, cs
	cmp	ax, bx
	jne	@@2
	add	si, di
	loop	@@1
	xor	ax, ax
	jmp	short @@3
@@2:	xor	ax, ax
	dec	ax
@@3:	pop	bx
	pop	cx
	pop	di
	pop	si
	pop	dx
	pop	es
	pop	ds
	ret
setpsp:	call	dosbusy
	je	@@1
	mov	byte ptr es:[di], 0FFh
@@1:	mov	ax, 5000h
	int	21h
	call	dosbusy
	je	@@2
	mov	byte ptr es:[di], 0
@@2:	ret
getpsp:	call	dosbusy
	je	@@1
	mov	byte ptr es:[di], 0FFh
@@1:	mov	ax, 5100h
	int	21h
	call	dosbusy
	je	@@2
	mov	byte ptr es:[di], 0
@@2:	ret
dosbusy:	mov	al, byte ptr dosmajor
	cmp	al, 3
	jae	@@1
	les	di, dword ptr indosptr
	mov	al, byte ptr es:[di]
	or	al, al
	je	@@1
	les	di, dword ptr critptr
	jmp	short @@2
@@1:	xor	al, al
@@2:	ret
tsrfind2f:	push	di
	xor	ax, ax
	mov	es, ax
	mov	bx, 2Fh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr es:[bx+2]
	mov	di, cs
	cmp	ax, di
	jne	@@1
	xor	ax, ax
	mov	word ptr es:[bx], ax
	mov	word ptr es:[bx+2], ax
@@1:	pop	di
	ret
tsrbyteEBC:	db	0
tsrdispatch:	push	ax
	push	bx
	push	es
	push	ds
	push	cs
	pop	ds
	call	tsrunhook
	or	ax, ax
	je	@@1
	jmp	short @@4
@@1:	mov	bx, word ptr tsrpsp
	mov	es, bx
	push	es
	mov	bx, word ptr es:[2Ch]
	mov	es, bx
	mov	ax, 4900h
	int	21h
	pop	es
	jb	@@4
	mov	ax, 4900h
	int	21h
	jb	@@4
	mov	byte ptr tsrbyteEBC, 0
	push	ds
	mov	ax, word ptr tsrcs
	mov	ds, ax
	mov	ax, ss
	cmp	ax, word ptr cs:fgstack+2
	je	@@2
	mov	byte ptr cs:tsrbyteEBC, 1
	cli
	mov	word ptr cs:fgss, ss
	mov	word ptr cs:fgsp, sp
	mov	ss, word ptr cs:fgstack+2
	mov	sp, word ptr cs:fgstack
	sti
@@2:	xor	ax, ax
	inc	ax
	call	tsrsetup
	mov	al, byte ptr cs:tsrbyteEBC
	or	al, al
	je	@@3
	cli
	mov	ss, word ptr cs:fgss
	mov	sp, word ptr cs:fgsp
	sti
@@3:	pop	ds
	xor	ax, ax
	inc	ax
	call	savestate
	call	tsrfind2f
	mov	word ptr tsrflags, 0
	jmp	short @@5
@@4:	or	word ptr tsrflags, 411h
	and	word ptr tsrflags, 0FDFFh
@@5:	pop	ds
	pop	es
	pop	bx
	pop	ax
	ret

; INT 16h function 1 through the old vector: is a key waiting?
kbcheck:	push	cx
	push	bx
	mov	ah, 1
	or	ah, byte ptr kbextended
	pushf
	call	dword ptr old16
	jne	@@3
	test	word ptr tsrflags, 200h
	je	@@2
	test	byte ptr tsrkbstate, 0EFh
	jne	@@2
	push	ds
	push	si
	lds	si, dword ptr critptr
	lodsb
	lds	si, dword ptr cs:indosptr
	or	al, byte ptr [si]
	or	al, byte ptr cs:tsrstate
	pop	si
	pop	ds
	je	@@1
	cmp	al, 1
	ja	@@2
	test	word ptr tsrflags, 4
	je	@@2
@@1:	inc	byte ptr idlecount
	cmp	byte ptr idlecount, 8
	jb	@@2
	int	28h
@@2:	xor	ax, ax
@@3:	pop	bx
	pop	cx
	ret
code	ends
	end	start
