; THELP.ASM: Turbo Help 2.0 of Borland C++ 2.0, by David Stafford.
;
; A TSR that shows the help file of Turbo C++ (TCHELP.TCH) over any program:
; the hot key (keypad 5) pops up a window with the help for the word under the
; cursor, with links between topics, an index, a history and pasting of
; examples into the program underneath.
;
; The resident part (the viewer) comes first, then its options, then the
; transient part, which reads the command line, checks the help file and calls
; TsrInstall (TSRINST.ASM). THELP.COM keeps no symbols: all names are
; descriptive.
	locals
	.186
code	segment	byte public 'CODE'
	assume	cs:code,ds:code,es:code,ss:code

; the keyboard buffer in the BIOS data area
bios	segment	at 40h
	org	17h
kbflag	db	?		; the shift state
	org	1Ah
kbhead	dw	?		; the next key to read
kbtail	dw	?		; where the next key goes
kbbuf	dw	16 dup (?)	; the buffer itself
kbend	label	word		; its end
bios	ends

; memory past the end of THELP.COM, kept resident
TEXTMAX	equ	0C13Fh		; end of the topic text buffer (text up to here)
SCREENBUF	equ	0C140h		; the screen under the window
LINKS	equ	0CBE0h		; the file position of each link's target
LINKTOP	equ	0E350h		; where the next link position goes
TSRSTACK	equ	0E552h		; TesSeRact's stack pointers
KBSAVE	equ	0E556h		; the keyboard buffer tail before INT 9
RESEND	equ	0E558h		; the end of the resident part
	public	popup_main
	public	tsrdone
	public	beep
	public	tsrsetup
	public	main
	extrn	tsrinstall:near
	extrn	tsrcheck:near
	extrn	tsrstacks:near

; four jumps whose targets showtopic and showindex patch, so that the
; viewer can draw and move in a topic or in the index
vgetchar:	db	0E9h		; jmp near: the character to draw: tgetchar or igetchar
	dw	0
vfindlink:	db	0E9h		; jmp near: find the link at the cursor: tfindlink or ifindlink
	dw	0
vnextlink:	db	0E9h		; jmp near: Tab: tnextlink or inextlink
	dw	0
vprevlink:	db	0E9h		; jmp near: Shift-Tab: tprevlink or iprevlink
	dw	0

; the viewer's state
indexpos	dw	0, 0
topicbase	dw	0, 0

; the file positions of the last 20 topics, newest first (Alt-F1)
history	db	80 dup (0)
contents	db	0, 0, 0, 0
pushhist	db	0

; the help file's handle
helpfile	db	0, 0
rechdr	db	0, 0
reclinks	db	0, 0
reclinks2	db	0, 0
pasting	db	0
readpos	db	0, 0, 0, 0

; the word typed or picked up from the screen
searchword	db	22 dup (0)
wordlen	db	0, 0
filehdr	db	15 dup (0)

; the header of each record in the help file: its type, then its length
rec	db	0
reclen	db	0, 0
oldint16	dw	0, 0
oldint09	dw	0, 0
textlen	db	0, 0
textend	db	0, 0
lastline	db	0, 0
topline	db	0, 0
leftcol	db	0, 0
topptr	db	0, 0
drawptr	db	0, 0
haspaste	db	0
pasteptr	db	0, 0
marking	db	0
markrow1	db	0, 0
markcol1	db	0, 0
markrow2	db	0, 0
markcol2	db	0, 0
pasterow	db	0, 0
pastecol	db	0, 0
currow	db	0, 0
curcol	db	0, 0
curptr	db	0, 0
curlink	db	0, 0

; the bottom line of the window: narrow, then wide (/D)
status1	db	0C0h, 0C4h, 0C4h, 0C4h, 'F1=Help', 0C4h, 0C4h, 0C4h, 0C4h, 0C4h
	db	0C4h, 'Alt F1=Last', 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 'Shift F1=Index'
	db	0C4h, 0C4h, 0C4h, 0D9h
status2	db	0C0h, 0C4h, 0C4h, 0C4h, 'F1=Help', 0C4h, 0C4h, 0C4h, 0C4h, 0C4h
	db	0C4h, 'Alt F1=Last', 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 'Shift F1=Index'
	db	0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h
	db	0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h
	db	0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0C4h, 0D9h

; Shift and a cursor key: the shift state and scan code of each, and the code
; newint09 puts into the keyboard buffer for it
shiftkeys	db	3, 48h, 3, 4Bh, 3, 4Dh, 3, 50h, 3, 47h, 3, 4Fh
	db	3, 49h, 3, 51h
shiftcodes	dw	6FFh, 7FFh, 8FFh, 9FFh, 0AFFh, 0BFFh
	dw	0CFFh, 0DFFh

; the keys the viewer knows
keys	dw	4800h, 5000h, 4B00h, 4D00h, 4700h, 4F00h
	dw	4900h, 5100h, 8400h, 7600h, 3B00h, 5400h
	dw	6800h, 1C0Dh, 3920h, 0F09h, 1910h, 0F00h
	dw	6FFh, 9FFh, 7FFh, 8FFh, 0AFFh, 0BFFh
	dw	0CFFh, 0DFFh

; what each key does; the last entry is for any other key
keyproc	dw	offset lineup, offset linedown, offset colleft, offset colright, offset colhome, offset colend
	dw	offset pageup, offset pagedown, offset gototop, offset gotoend, offset showcontents, offset showindex
	dw	offset goback, offset follow, offset follow, offset vnextlink, offset paste, offset vprevlink
	dw	offset lineup, offset linedown, offset colleft, offset colright, offset colhome, offset colend
	dw	offset pageup, offset pagedown, offset noop

; the screen as THELP found it
oldcursor	db	0, 0
oldpos	db	0, 0
vpage	db	0
vseg	db	0, 0
crtstatus	db	0, 0

; the characters that can be part of a word besides letters and digits
wordchars	db	'+-*/|^&%!~<>=:?'
wordchars2	db	'$#._'

; waits for a key
getkey:	mov	ah, 0
	int	16h
iswordch:	cmp	byte ptr cs:casesens, 0
	jne	iswordch2
upcase:	cmp	al, 61h
	jb	iswordch2
	cmp	al, 7Ah
	ja	iswordch2
	and	al, 5Fh
iswordch2:	push	cx
	push	di
	mov	di, offset wordchars2
	mov	cx, 4
	call	isalnum
	pop	di
	pop	cx
	ret

; carry clear when AL is a letter, a digit or one of the CX characters at DI
isalnum:	cmp	al, 30h
	jb	@@1
	cmp	al, 39h
	jbe	@@4
@@1:	cmp	al, 41h
	jb	@@2
	cmp	al, 5Ah
	jbe	@@4
@@2:	cmp	al, 61h
	jb	@@3
	cmp	al, 7Ah
	jbe	@@4
@@3:	repne scasb
	jne	@@5
	jcxz	@@5
@@4:	clc
	ret
@@5:	stc
	ret

; writes AX CX+1 times at ES:DI
putchars:	jcxz	noop
	dec	cx
	call	putchars

; writes AX at ES:DI, waiting for the retrace first (CGA snow)
putchar:	push	dx
	push	bx
	mov	dx, word ptr crtstatus
	xchg	ax, bx
@@1:	in	al, dx
	shr	al, 1
	jae	@@1
	xchg	ax, bx
	stosw
	pop	bx
	pop	dx
noop:	ret

; draws the frame and the bottom line. videosetup patches the calls marked
; snowN into plain stosw when snow checking is off
drawframe:	push	ax
	push	cx
	push	si
	push	di
	push	es
	mov	es, word ptr vseg
	cmp	byte ptr cs:wide, 0
	jne	@@1
	mov	di, 29Ch
	jmp	@@2
@@1:	mov	di, 280h
@@2:	mov	ah, byte ptr frameattr
	mov	al, 0DAh
snow1:	call	putchar
	cmp	byte ptr cs:wide, 0
	jne	@@1
	mov	cx, 32h
	jmp	@@2
@@1:	mov	cx, 4Eh
@@2:	mov	al, 0C4h
snow2:	call	putchars
	mov	al, 0BFh
snow3:	call	putchar
	mov	al, 0B3h
	mov	cl, 0Fh
framesides:	cmp	byte ptr cs:wide, 0
	jne	@@1
	add	di, 38h
	jmp	snow4
@@1:	add	di, 0
snow4:	call	putchar
	cmp	byte ptr cs:wide, 0
	jne	@@1
	add	di, 64h
	jmp	snow5
@@1:	add	di, 9Ch
snow5:	call	putchar
	loop	framesides
	cmp	byte ptr cs:wide, 0
	jne	@@1
	add	di, 38h
	jmp	@@2
@@1:	add	di, 0
@@2:	cmp	byte ptr cs:wide, 0
	jne	@@3
	mov	si, offset status1
	mov	cx, 34h
	jmp	statusloop
@@3:	mov	si, offset status2
	mov	cx, 50h
statusloop:	lodsb
snow6:	call	putchar
	loop	statusloop
	pop	es
	pop	di
	pop	si
	pop	cx
	pop	ax
	ret

; draws the text in the window from topptr
drawtext:	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	push	es
	call	vfindlink
	mov	es, word ptr vseg
	mov	ah, 2
	mov	bh, byte ptr vpage
	mov	dh, byte ptr currow
	sub	dh, byte ptr topline
	add	dh, 5
	mov	dl, byte ptr curcol
	sub	dl, byte ptr leftcol
	cmp	byte ptr cs:wide, 0
	jne	@@1
	add	dl, 0Fh
	jmp	@@2
@@1:	add	dl, 1
@@2:	int	10h
	mov	es, word ptr vseg
	cmp	byte ptr cs:wide, 0
	jne	drawwide
	mov	di, 33Eh
	jmp	drawrows
drawwide:	mov	di, 322h
drawrows:	mov	bx, 0Fh
	call	drawstart
drawrow:	cmp	byte ptr cs:wide, 0
	jne	drawrowwide
	mov	cx, 32h
	jmp	drawcols
drawrowwide:	mov	cx, 4Eh
drawcols:	mov	dx, word ptr leftcol
drawcol:	call	vgetchar
	dec	dx
	jns	drawcol
snow7:	call	putchar
drawnext:	loop	drawcol
	call	drawline
	cmp	byte ptr cs:wide, 0
	jne	@@1
	add	di, 3Ch
	jmp	@@2
@@1:	add	di, 4
@@2:	dec	bx
	mov	ah, byte ptr textattr
	mov	byte ptr curattr, ah
	jne	drawrow
	pop	es
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; saves the screen under the window, finds the video segment and sets the
; cursor
savescreen:	push	ds
	mov	dx, 0B000h
	mov	ah, 0Fh
	int	10h
	mov	byte ptr vpage, bh
	cmp	al, 7
	je	@@1
	mov	dh, 0B8h
	add	dh, bh
	cmp	byte ptr swapped, 0
	jmp	@@2
@@1:	cmp	byte ptr swapped, 1
@@2:	je	@@4
	mov	di, offset frameattr
	mov	cx, 6
@@3:	mov	ax, word ptr [di]
	xchg	ah, al
	stosw
	loop	@@3
	xor	byte ptr swapped, 1
@@4:	mov	word ptr vseg, dx
	mov	ds, dx
	cmp	byte ptr cs:wide, 0
	jne	@@5
	mov	si, 29Ch
	jmp	@@6
@@5:	mov	si, 280h
@@6:	mov	di, offset SCREENBUF
	mov	bx, 11h
@@7:	cmp	byte ptr cs:wide, 0
	jne	@@8
	mov	cx, 34h
	jmp	@@9
@@8:	mov	cx, 50h
@@9:	rep movsw
	cmp	byte ptr cs:wide, 0
	jne	@@10
	add	si, 38h
	jmp	@@11
@@10:	add	si, 0
@@11:	dec	bx
	jne	@@7
	pop	ds
	mov	ah, 3
	mov	bh, byte ptr vpage
	int	10h
	mov	word ptr oldcursor, cx
	mov	word ptr oldpos, dx
	mov	cx, 607h
	cmp	word ptr vseg, 0B000h
	jne	@@12
	mov	cx, 0B0Ch
@@12:	mov	ah, 1
	int	10h
	ret

; puts the screen back
restscreen:	push	es
	mov	es, word ptr vseg
	cmp	byte ptr cs:wide, 0
	jne	@@1
	mov	di, 29Ch
	jmp	@@2
@@1:	mov	di, 280h
@@2:	mov	si, offset SCREENBUF
	mov	bx, 11h
@@3:	cmp	byte ptr cs:wide, 0
	jne	@@4
	mov	cx, 34h
	jmp	@@5
@@4:	mov	cx, 50h
@@5:	rep movsw
	cmp	byte ptr cs:wide, 0
	jne	@@6
	add	di, 38h
	jmp	@@7
@@6:	add	di, 0
@@7:	dec	bx
	jne	@@3
	pop	es
	mov	ah, 2
	mov	bh, byte ptr vpage
	mov	dx, word ptr oldpos
	int	10h
	mov	ah, 1
	mov	cx, word ptr oldcursor
	int	10h
	ret

; picks up the word under the cursor from linebuf
getword:	push	ax
	push	bx
	push	cx
	push	si
	push	di
	mov	al, byte ptr oldpos
	cbw
	mov	si, offset linebuf
	add	si, ax
	push	si
@@1:	cmp	byte ptr [si], 0
	jne	@@2
	cmp	byte ptr [si+1], 0
	jne	@@6
@@2:	dec	si
	cmp	si, 20EDh
	jae	@@1
	pop	si
	mov	cx, 50h
	sub	cl, byte ptr oldpos
	jle	@@5
@@3:	lodsb
	or	al, al
	je	@@4
	dec	si
	jmp	short @@7
@@4:	loop	@@3
@@5:	mov	byte ptr searchword, 0
	jmp	short @@9
@@6:	pop	ax
	inc	si
@@7:	mov	di, offset searchword
	mov	cx, 15h
	xor	ax, ax
	mov	word ptr wordlen, ax
@@8:	lodsb
	mov	byte ptr [si-1], 0
	stosb
	or	al, al
	je	@@9
	inc	word ptr wordlen
	loop	@@8
@@9:	pop	di
	pop	si
	pop	cx
	pop	bx
	pop	ax
	ret

; copies the cursor's screen line into linebuf, marking word starts
readline:	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	mov	bl, 0A0h
	mov	al, byte ptr oldpos+1
	mul	bl
	xchg	ax, si
	mov	ds, word ptr vseg
	mov	di, offset linebuf
	mov	cx, 50h
	mov	bl, 80h
	mov	dl, 0
@@1:	lodsw
	call	iswordch
	jae	@@2
	or	byte ptr es:[di-1], dl
	mov	al, 0
	mov	bl, 80h
	mov	dl, 0
	jmp	short @@3
@@2:	or	al, bl
	mov	bl, 0
	mov	dl, 80h
@@3:	stosb
	loop	@@1
	push	es
	pop	ds
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; looks the word up in the index; AX = its topic's position, 0 if none
findindex:	push	bx
	push	cx
	push	dx
	push	si
	push	di
	mov	bx, offset textbuf
	mov	dx, word ptr textlen
	mov	di, offset text
	mov	cx, word ptr textlen
@@1:	cmp	di, word ptr textend
	jae	@@4
	mov	si, offset searchword
	lodsb
	repne scasb
	jne	@@4
	push	di
	push	cx
	mov	cx, word ptr wordlen
	dec	cx
	repe cmpsb
	pop	cx
	pop	di
	jne	@@1
	mov	si, offset LINKS-1
@@2:	dec	di
	mov	al, byte ptr [di]
	test	al, 80h
	je	@@3
	inc	si
@@3:	cmp	di, offset text
	jne	@@2
	mov	ax, word ptr [si]
	jmp	short @@5
@@4:	xor	ax, ax
@@5:	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	ret

; cursor movement, from the key table
linedown:	push	ax
	push	si
	mov	ax, word ptr currow
	cmp	ax, word ptr lastline
	je	@@2
	sub	ax, word ptr topline
	cmp	ax, 0Eh
	jl	@@1
	mov	si, word ptr topptr
	call	nextline
	mov	word ptr topptr, si
	inc	word ptr topline
@@1:	mov	si, word ptr curptr
	call	nextline
	mov	word ptr curptr, si
	inc	word ptr currow
@@2:	pop	si
	pop	ax
	ret
lineup:	push	cx
	push	si
	mov	cx, word ptr currow
	jcxz	@@2
	cmp	cx, word ptr topline
	jg	@@1
	mov	si, word ptr topptr
	call	prevline
	mov	word ptr topptr, si
	dec	word ptr topline
@@1:	mov	si, word ptr curptr
	call	prevline
	mov	word ptr curptr, si
	dec	word ptr currow
@@2:	pop	si
	pop	cx
	ret
pageup:	push	cx
	push	si
	mov	cx, 0Fh
@@1:	cmp	word ptr topline, 0
	je	@@2
	mov	si, word ptr topptr
	call	prevline
	mov	word ptr topptr, si
	dec	word ptr topline
@@2:	call	lineup
	loop	@@1
	pop	si
	pop	cx
	ret
pagedown:	push	ax
	push	cx
	push	si
	mov	ax, word ptr lastline
	sub	ax, word ptr topline
	mov	cx, 0Fh
	sub	ax, cx
@@1:	sahf
	js	@@2
	mov	si, word ptr topptr
	call	nextline
	mov	word ptr topptr, si
	inc	word ptr topline
@@2:	call	linedown
	loop	@@1
	pop	si
	pop	cx
	pop	ax
	ret
colright:	push	ax
	mov	ax, word ptr curcol
	cmp	ax, 80h
	jge	@@4
	sub	ax, word ptr leftcol
	cmp	byte ptr cs:wide, 0
	jne	@@1
	cmp	ax, 31h
	jmp	@@2
@@1:	cmp	ax, 4Dh
@@2:	jl	@@3
	inc	word ptr leftcol
@@3:	inc	word ptr curcol
@@4:	pop	ax
	ret
colleft:	push	cx
	mov	cx, word ptr curcol
	jcxz	colleft3
colleft2:	cmp	cx, word ptr leftcol
	jg	@@1
	dec	word ptr leftcol
@@1:	dec	word ptr curcol
colleft3:	pop	cx
	ret
colhome:	push	ax
	xor	ax, ax
	mov	word ptr leftcol, ax
	mov	word ptr curcol, ax
	pop	ax
	ret
colend:	push	ax
	push	si
	xor	ax, ax
	mov	word ptr leftcol, ax
	mov	word ptr curcol, ax
	mov	si, word ptr curptr
@@1:	lodsb
	or	al, al
	je	@@2
	cmp	al, 0Ah
	jbe	@@1
	call	colright
	jmp	@@1
@@2:	pop	si
	pop	ax
	ret

; DX, CX = the row and column of the position at SI in the text
poscoord:	push	ax
	push	bx
	push	si
	push	di
	mov	di, offset text
	lea	bx, [di-1]
	xor	dx, dx
@@1:	cmp	byte ptr [di], 0
	jne	@@2
	inc	dx
	mov	bx, di
@@2:	inc	di
	cmp	di, si
	jne	@@1
	xor	cx, cx
@@3:	inc	bx
	cmp	bx, si
	je	@@4
	cmp	byte ptr [bx], 0Ah
	jb	@@3
	inc	cx
	jmp	@@3
@@4:	pop	di
	pop	si
	pop	bx
	pop	ax
	ret

; Tab and Shift-Tab between links, in a topic and in the index
tprevlink:	push	cx
	push	dx
	push	bp
	push	si
	xor	cx, cx
	call	vfindlink
	mov	bp, si
	jmp	short @@2
@@1:	cmp	si, bp
	je	@@6
@@2:	cmp	si, offset textbuf
	jne	@@3
	mov	si, word ptr textend
@@3:	cmp	byte ptr [si], 2
	jne	@@4
	cmp	word ptr curlink, cx
	je	@@5
	mov	word ptr curlink, cx
@@4:	dec	si
	jmp	@@1
@@5:	call	poscoord
	call	gotorowcol
@@6:	pop	si
	pop	bp
	pop	dx
	pop	cx
	ret
tnextlink:	push	cx
	push	dx
	push	bp
	push	si
	call	vfindlink
	mov	bp, si
	jmp	short @@2
@@1:	cmp	si, bp
	je	@@6
@@2:	cmp	si, word ptr textend
	jne	@@3
	mov	si, offset textbuf
@@3:	cmp	byte ptr [si], 2
	jne	@@4
	cmp	word ptr curlink, si
	jne	@@5
@@4:	inc	si
	jmp	@@1
@@5:	call	poscoord
	call	gotorowcol
@@6:	pop	si
	pop	bp
	pop	dx
	pop	cx
	ret
iprevlink:	push	cx
	push	dx
	push	bp
	push	si
	push	di
	call	vfindlink
	xor	cx, cx
	mov	dx, word ptr curlink
	or	dx, dx
	je	@@1
	inc	byte ptr linkflag
	inc	cx
@@1:	mov	bp, si
	jmp	short @@3
@@2:	cmp	si, bp
	je	@@7
@@3:	cmp	si, offset textbuf
	jne	@@4
	mov	si, word ptr textend
@@4:	test	byte ptr [si], 80h
	je	@@5
	xor	byte ptr linkflag, 1
	jne	@@5
	jcxz	@@6
	dec	cx
@@5:	dec	si
	jmp	@@2
@@6:	call	poscoord
	call	gotorowcol
@@7:	mov	byte ptr linkflag, 0
	nop
	pop	si
	pop	di
	pop	bp
	pop	dx
	pop	cx
	ret
inextlink:	push	cx
	push	dx
	push	bp
	push	si
	push	di
	call	vfindlink
	cmp	si, word ptr curlink
	jae	@@1
	inc	si
@@1:	cmp	word ptr curlink, 0
	je	@@2
	inc	byte ptr linkflag
	mov	bp, si
	jmp	short @@3
@@2:	cmp	si, bp
	je	@@7
@@3:	cmp	si, word ptr textend
	jne	@@4
	mov	si, offset textbuf
@@4:	test	byte ptr [si], 80h
	je	@@5
	xor	byte ptr linkflag, 1
	jne	@@6
@@5:	inc	si
	jmp	@@2
@@6:	call	poscoord
	call	gotorowcol
@@7:	mov	byte ptr linkflag, 0
	nop
	pop	si
	pop	di
	pop	bp
	pop	dx
	pop	cx
	ret
gotoend:	push	ax
@@1:	mov	ax, 5100h
	call	keyhandler
	mov	ax, word ptr lastline
	cmp	word ptr currow, ax
	jne	@@1
	pop	ax
	ret
gototop:	xor	ax, ax
	mov	word ptr topline, ax
	mov	word ptr leftcol, ax
	mov	word ptr currow, ax
	mov	word ptr curcol, ax
	mov	ax, offset text
	mov	word ptr topptr, ax
	mov	word ptr curptr, ax
	ret

; the procedure for the key in AX, through the key tables
keyhandler:	push	ax
	push	ax
	push	cx
	push	di
	push	bp
	mov	bp, sp
	mov	di, offset keys
	mov	cx, 1Bh
	repne scasw
	cmp	ax, 1910h
	je	@@1
	mov	byte ptr marking, ch
	cmp	al, 0FFh
	jne	@@1
	inc	byte ptr marking
@@1:	mov	ax, word ptr [di+32h]
	mov	word ptr [bp+8], ax
	pop	bp
	pop	di
	pop	cx
	pop	ax
	ret

; Ctrl-P: pastes the topic's example (or the marked block) into the
; program underneath, through newint16
paste:	push	bx
	push	cx
	push	dx
	push	si
	push	di
	cmp	byte ptr marking, 0
	jne	@@6
	cmp	byte ptr haspaste, 0
	je	@@9
	mov	word ptr markcol1, 0
	mov	word ptr markcol2, 3E7h
	mov	si, offset text
	mov	bx, 0
@@1:	lodsb
	cmp	al, 5
	je	@@2
	or	al, al
	jne	@@1
	inc	bx
	jmp	@@1
@@2:	mov	word ptr markrow1, bx
@@3:	lodsb
	cmp	al, 6
	jne	@@4
	mov	word ptr markrow2, bx
@@4:	or	al, al
	jne	@@5
	inc	bx
@@5:	cmp	si, word ptr textend
	jb	@@3
@@6:	mov	ax, word ptr markcol1
	mov	word ptr pastecol, ax
	mov	ax, word ptr markrow1
	mov	word ptr pasterow, ax
	xchg	ax, cx
	mov	si, offset text
	jcxz	@@8
@@7:	lodsb
	or	al, al
	jne	@@7
	loop	@@7
@@8:	mov	word ptr pasteptr, si
	inc	byte ptr pasting
	mov	ax, 11Bh
	mov	byte ptr marking, 0
@@9:	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	ret

; the next character to paste; peekpaste leaves it, nextpaste takes it
peekpaste:	push	cx
	push	si
	xor	ax, ax
	mov	cx, word ptr pasterow
	cmp	cx, word ptr markrow2
	ja	@@2
	mov	si, word ptr pasteptr
	mov	cx, word ptr pastecol
	cmp	cx, word ptr markcol2
	ja	@@3
	inc	cx
@@1:	lodsb
	or	al, al
	je	@@3
	cmp	al, 0Ah
	jb	@@1
	loop	@@1
@@2:	pop	si
	pop	cx
	ret
@@3:	mov	ax, 1C0Dh
	jmp	@@2
nextpaste:	push	si
	call	peekpaste
	or	al, al
	je	@@2
	inc	word ptr pastecol
	cmp	al, 0Dh
	jne	@@2
	mov	si, word ptr markcol1
	mov	word ptr pastecol, si
	inc	word ptr pasterow
	mov	si, word ptr pasteptr
@@1:	lodsb
	or	al, al
	jne	@@1
	mov	word ptr pasteptr, si
	mov	al, 0Dh
@@2:	pop	si
	ret

; typing a word in the index moves to the first entry that starts with it
typesearch:	push	bx
	push	cx
	push	dx
	push	si
	push	di
	push	bp
	cmp	word ptr vgetchar+1, offset tgetchar - offset vfindlink
	je	@@7
	cmp	ax, 0E08h
	jne	@@1
	cmp	word ptr wordlen, 0
	je	@@1
	dec	word ptr wordlen
	jmp	short @@2
@@1:	mov	di, offset wordchars
	mov	cx, 13h
	call	isalnum
	jb	@@7
	cmp	word ptr wordlen, 15h
	je	@@7
	mov	di, word ptr wordlen
	mov	byte ptr [di+searchword], al
	inc	word ptr wordlen
@@2:	mov	bx, offset textbuf
	mov	ax, word ptr textlen
	mov	word ptr readpos, ax
	xor	dx, dx
@@3:	inc	bx
	dec	word ptr readpos
	je	@@6
	cmp	byte ptr [bx], 0
	jne	@@3
@@4:	inc	dx
	inc	bx
	dec	word ptr readpos
	je	@@6
	cmp	byte ptr [bx], 0
	je	@@4
	mov	si, bx
	mov	di, offset searchword
	mov	cx, word ptr wordlen
@@5:	lodsb
	and	al, 5Fh
	push	bx
	mov	bl, byte ptr [di]
	and	bl, 5Fh
	cmp	al, bl
	pop	bx
	jne	@@3
	inc	di
	loop	@@5
	mov	cx, word ptr wordlen
	dec	cx
	call	gotorowcol
	xor	ax, ax
@@6:	pop	bp
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	ret
@@7:	mov	word ptr wordlen, 0
	jmp	@@6

; the marked block: the cursor, the anchor and the other end (row, column)
mark	dw	0, 0
markA	db	0, 0, 0, 0
markB	db	0, 0, 0, 0

; the viewer: draws and handles keys until Esc
viewer:	call	drawframe
@@1:	call	drawtext
	cmp	byte ptr marking, 0
	jne	@@2
	mov	ax, word ptr currow
	mov	word ptr markA, ax
	mov	word ptr markB, ax
	mov	ax, word ptr curcol
	mov	word ptr markA+2, ax
	mov	word ptr markB+2, ax
@@2:	mov	ax, word ptr currow
	mov	word ptr mark, ax
	mov	ax, word ptr curcol
	mov	word ptr mark+2, ax
	call	getkey
	call	typesearch
	call	keyhandler
	cmp	ax, 11Bh
	je	@@4
	cmp	byte ptr marking, 0
	je	@@1
	mov	bx, offset markA
	mov	ax, word ptr mark
	cmp	word ptr markB, ax
	jne	@@3
	mov	ax, word ptr mark+2
	cmp	word ptr markB+2, ax
	jne	@@3
	mov	bx, offset markB
@@3:	mov	ax, word ptr currow
	mov	word ptr [bx], ax
	mov	ax, word ptr curcol
	mov	word ptr [bx+2], ax
	call	@@5
	jmp	@@1
@@4:	ret
@@5:	mov	ax, word ptr markA
	mov	bx, word ptr markB
	mov	cx, word ptr markA+2
	mov	dx, word ptr markB+2
	cmp	ax, bx
	jle	@@6
	xchg	ax, bx
@@6:	cmp	cx, dx
	jle	@@7
	xchg	cx, dx
@@7:	mov	word ptr markrow1, ax
	mov	word ptr markrow2, bx
	mov	word ptr markcol1, cx
	mov	word ptr markcol2, dx
	ret
drawy	dw	0
drawx	db	0, 0

; the drawing position
drawstart:	push	word ptr topptr
	pop	word ptr drawptr
	push	word ptr topline
	pop	word ptr drawy
	mov	word ptr drawx, 0
	ret
drawline:	push	bx
	mov	bx, word ptr drawptr
	dec	bx
@@1:	inc	bx
	cmp	byte ptr [bx], 0
	jne	@@1
	inc	bx
	mov	word ptr drawptr, bx
	mov	word ptr drawx, 0
	inc	word ptr drawy
	pop	bx
	ret

; SI to the next or previous line of the text
nextline:	push	ax
	push	si
@@1:	lodsb
	or	al, al
	jne	@@1
	cmp	si, word ptr textend
	je	@@2
	pop	ax
	pop	ax
	ret
@@2:	pop	si
	pop	ax
	ret
prevline:	cmp	si, offset text
	je	@@2
	push	ax
	std
	dec	si
	dec	si
@@1:	lodsb
	or	al, al
	jne	@@1
	inc	si
	inc	si
	cld
	pop	ax
@@2:	ret

; moves the cursor to column CX, row DX
gotorowcol:	cmp	cx, word ptr curcol
	je	@@2
	jg	@@1
	call	colleft
	jmp	gotorowcol
@@1:	call	colright
	jmp	gotorowcol
@@2:	or	dx, dx
	jns	@@3
	xor	dx, dx
@@3:	cmp	dx, word ptr lastline
	jle	gotorow
	mov	dx, word ptr lastline
gotorow:	cmp	dx, word ptr currow
gotorow2:	je	@@2
	jg	@@1
	call	lineup
	jmp	gotorow
@@1:	call	linedown
	jmp	gotorow
@@2:	ret

; inside a link while drawing, and the attribute
inlink	db	0
curattr	db	0

; the next character to draw, with its attribute: index (igetchar), topic (tgetchar)
igetchar:	push	si
	mov	si, word ptr drawptr
	lodsb
	or	al, al
	je	@@2
	inc	word ptr drawptr
	mov	ah, byte ptr curattr
	test	al, 80h
	je	@@4
	and	al, 7Fh
	xor	byte ptr inlink, 1
	je	@@5
	cmp	si, word ptr curlink
	je	@@1
	mov	ah, byte ptr linkattr
	jmp	short @@3
@@1:	mov	ah, byte ptr curlinkattr
	jmp	short @@3
@@2:	mov	ah, byte ptr textattr
@@3:	mov	byte ptr curattr, ah
@@4:	pop	si
	ret
@@5:	push	ax
	mov	al, byte ptr textattr
	mov	byte ptr curattr, al
	pop	ax
	jmp	@@4
tgetchar:	push	si
	mov	si, word ptr drawptr
	lodsb
	or	al, al
	jne	@@1
	mov	ah, byte ptr textattr
	mov	al, 20h
	jmp	short @@2
@@1:	call	@@4
@@2:	cmp	byte ptr marking, 0
	je	@@3
	mov	si, word ptr drawx
	cmp	si, word ptr markcol1
	jb	@@3
	cmp	si, word ptr markcol2
	ja	@@3
	mov	si, word ptr drawy
	cmp	si, word ptr markrow1
	jb	@@3
	cmp	si, word ptr markrow2
	ja	@@3
	mov	ah, byte ptr markattr
@@3:	inc	word ptr drawx
	pop	si
	ret
@@4:	push	si
	mov	si, word ptr drawptr
tattr:	inc	word ptr drawptr
	lodsb
	or	al, al
	je	tattrend
	mov	ah, byte ptr curattr
	cmp	al, 2
	jne	tattrcode
	mov	al, byte ptr curlinkattr
tattrlink:	cmp	si, word ptr curlink
	je	tattrset
	mov	al, byte ptr linkattr
	jmp	short tattrset
tattrcode:	cmp	al, 3
	je	@@1
	cmp	al, 5
	je	tattrxref
	cmp	al, 6
	jne	tattrdone
@@1:	mov	al, byte ptr textattr
	jmp	short tattrset
tattrend:	mov	ah, byte ptr textattr
	mov	byte ptr curattr, ah
	dec	word ptr drawptr
tattrdone:	pop	si
	ret
tattrxref:	mov	al, byte ptr xrefattr
tattrset:	mov	byte ptr curattr, al
	jmp	tattr

; expands a topic's compressed text: nibbles, with codes for runs and
; for the most common characters
nibflag	db	0
getnibble:	xor	byte ptr nibflag, 1
	je	@@1
	mov	al, byte ptr [si]
	and	al, 0Fh
	ret
@@1:	lodsb
	shr	al, 1
	shr	al, 1
	shr	al, 1
	shr	al, 1
	ret
linkflag	db	0
xrefflag	db	0
expand:	push	ax
	push	bx
	push	cx
	mov	byte ptr nibflag, 0
	mov	bx, 1038h
@@1:	mov	cx, 1
@@2:	call	getnibble
	cmp	al, 0Fh
	jne	@@3
	call	getnibble
	mov	ah, al
	call	getnibble
	shl	al, 1
	shl	al, 1
	shl	al, 1
	shl	al, 1
	or	al, ah
	cmp	al, 1
	je	@@9
	cmp	al, 5
	jne	@@5
	mov	byte ptr haspaste, al
	add	al, byte ptr xrefflag
	xor	byte ptr xrefflag, 1
	jmp	short @@5
@@3:	cmp	al, 0Eh
	jne	@@4
	call	getnibble
	mov	cl, al
	inc	cx
	inc	cx
	jmp	@@2
@@4:	xlat
@@5:	or	al, al
	jne	@@7
	cmp	byte ptr xrefflag, 0
	je	@@8
@@6:	jcxz	@@1
	mov	al, 6
	stosb
	mov	al, 0
	stosb
	mov	al, 5
	stosb
	dec	cx
	jmp	@@6
@@7:	cmp	al, 2
	jne	@@8
	add	al, byte ptr linkflag
	xor	byte ptr linkflag, 1
@@8:	rep stosb
	jmp	@@1
@@9:	pop	cx
	pop	bx
	pop	ax
	ret

; the link on the cursor's line at or after the cursor
ifindlink:	push	ax
	push	cx
	xor	ax, ax
	mov	word ptr curlink, ax
	mov	si, word ptr curptr
	mov	cx, word ptr curcol
@@1:	lodsb
	or	al, al
	je	@@4
	test	al, 80h
	je	@@3
	xor	byte ptr linkflag, 1
	je	@@2
	mov	word ptr curlink, si
	jmp	short @@3
@@2:	jcxz	@@4
	xor	ax, ax
	mov	word ptr curlink, ax
@@3:	dec	cx
	jns	@@1
@@4:	mov	byte ptr linkflag, 0
	dec	si
	pop	cx
	pop	ax
	ret
tfindlink:	push	ax
	push	cx
	mov	si, word ptr curptr
tfindlink2:	mov	cx, word ptr curcol
@@1:	xor	ax, ax
	mov	word ptr curlink, ax
@@2:	lodsb
	cmp	byte ptr marking, 0
	jne	@@4
	or	al, al
	je	@@4
	cmp	al, 2
	jne	@@3
	mov	word ptr curlink, si
	jmp	@@2
@@3:	cmp	al, 3
	je	@@1
	dec	cx
	jns	@@2
@@4:	dec	si
	pop	cx
	pop	ax
	ret

; reads the topic, or index entry, whose number is in AX
gototopic:	push	si
	mov	si, offset showtopic
	jmp	short gotoentry
gotoindex:	push	si
	mov	si, offset readtopic
gotoentry:	push	bx
	push	cx
	push	dx
	or	ax, ax
	je	@@2
	mov	dx, word ptr topicbase
	mov	cx, word ptr topicbase+2
	mov	bx, 3
@@1:	add	dx, ax
	adc	cx, 0
	dec	bx
	jne	@@1
	call	fseek
	mov	cx, 3
	mov	dx, offset readpos
	call	fread
	mov	dx, word ptr readpos
	mov	cx, word ptr readpos+2
	call	fseek
	call	si
@@2:	pop	si
	pop	dx
	pop	cx
	pop	bx
	ret

; Enter or space: follows the link under the cursor
follow:	cmp	word ptr curlink, 0
	je	@@4
	mov	byte ptr pushhist, 1
	push	ax
	push	bx
	push	si
	mov	si, offset text
	mov	bx, offset LINKS
	cmp	word ptr vgetchar+1, offset tgetchar - offset vfindlink
	je	@@2
@@1:	lodsb
	cmp	si, word ptr curlink
	je	@@3
	test	al, 80h
	je	@@1
	inc	bx
	jmp	@@1
@@2:	lodsb
	cmp	si, word ptr curlink
	je	@@3
	cmp	al, 3
	jne	@@2
	inc	bx
	inc	bx
	jmp	@@2
@@3:	pop	si
	mov	ax, word ptr [bx]
	pop	bx
	call	gototopic
	pop	ax
@@4:	ret

; counts the text's lines
countlines:	push	ax
	push	cx
	push	di
	mov	word ptr lastline, 0FFFFh
	mov	di, offset text
	mov	al, 0
@@1:	mov	cl, 0FFh
	repne scasb
	inc	word ptr lastline
	cmp	di, word ptr textend
	jb	@@1
	pop	di
	pop	cx
	pop	ax
	ret

; looks up the word under the cursor; shows the contents if it is not found
lookup:	call	showindex2
	call	readline
@@1:	call	getword
	cmp	byte ptr searchword, 0
	je	showcontents
	cmp	byte ptr searchword+1, 0
	je	@@1
	call	findindex
	or	ax, ax
	je	@@1
	inc	byte ptr pushhist
	jmp	gototopic

; F1: the contents
showcontents:	push	cx
	push	dx
	mov	dx, word ptr contents
	mov	cx, word ptr contents+2
	call	fseek
	mov	byte ptr pushhist, 1
	pop	dx
	pop	cx

; shows the topic at the file position: the topic jumps, the text, its links
showtopic:	push	ax
	push	bx
	push	cx
	push	di
	mov	word ptr vgetchar+1, offset tgetchar - offset vfindlink
	mov	word ptr vfindlink+1, offset tfindlink - offset vnextlink
	mov	word ptr vprevlink+1, offset tprevlink - offset indexpos
	mov	word ptr vnextlink+1, offset tnextlink - offset vprevlink
	mov	byte ptr haspaste, 0
	mov	ax, 4201h
	mov	bx, word ptr helpfile
	xor	cx, cx
	mov	dx, cx
	int	21h
	mov	cx, dx
	xchg	ax, dx
	call	savehist
	call	gototop
	mov	word ptr drawptr, offset text
	mov	word ptr ds:[LINKTOP], offset LINKS
	call	readtopic
	mov	di, word ptr textend
	xor	ax, ax
	mov	cx, 8
	rep stosw
	mov	ax, offset text
	mov	word ptr drawptr, ax
	call	countlines
	pop	di
	pop	cx
	pop	bx
	pop	ax
	ret

; reads the table of the most common characters
readtable:	push	ax
	push	bx
	push	cx
	push	dx
	call	readrec
	mov	dx, offset TEXTMAX
	mov	cx, word ptr reclen
	sub	dx, cx
	mov	si, dx
	call	fread
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; reads a topic's text and its link table
readtopic:	push	ax
	push	bx
	push	cx
	push	dx
	push	di
	push	si
	call	readtable
	xor	ax, ax
	mov	word ptr reclinks, ax
	call	readrec
	cmp	byte ptr rec, 3
	jne	@@1
	mov	cx, 6
	mov	dx, offset rechdr
	call	fread
	mov	cx, word ptr reclinks2
	add	cx, cx
	mov	dx, word ptr ds:[LINKTOP]
	add	word ptr ds:[LINKTOP], cx
	call	fread
@@1:	mov	di, word ptr drawptr
	call	expand
	mov	word ptr drawptr, di
	mov	word ptr textend, di
	mov	word ptr textlen, di
	sub	word ptr textlen, offset text
	mov	ax, word ptr reclinks
	call	gotoindex
	pop	si
	pop	di
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; Shift-F1: the index
showindex:	mov	byte ptr pushhist, 1
showindex2:	push	ax
	push	bx
	push	cx
	push	dx
	push	di
	push	si
	push	bp
	mov	word ptr vgetchar+1, offset igetchar - offset vfindlink
	mov	word ptr vfindlink+1, offset ifindlink - offset vnextlink
	mov	word ptr vprevlink+1, offset iprevlink - offset indexpos
	mov	word ptr vnextlink+1, offset inextlink - offset vprevlink
	xor	dx, dx
	mov	cx, dx
	call	savehist
	mov	byte ptr haspaste, cl
	mov	dx, word ptr indexpos
	mov	cx, word ptr indexpos+2
	call	fseek
	call	readtable
	call	gototop
	mov	bp, offset LINKS
	lodsw
	xchg	ax, dx
	mov	bx, si
	mov	di, offset text
@@1:	mov	cl, byte ptr [bx]
	mov	ch, 0
	shr	cl, 1
	shr	cl, 1
	shr	cl, 1
	shr	cl, 1
	shr	cl, 1
	or	cl, cl
	jne	@@3
	mov	al, byte ptr [bx+1]
	xor	al, byte ptr [si]
	cmp	al, 0A0h
	je	@@2
	mov	al, 0
	stosb
@@2:	push	di
	jmp	short @@4
@@3:	push	di
	rep movsb
	and	byte ptr [di-1], 7Fh
@@4:	mov	cl, byte ptr [bx]
	inc	bx
	and	cl, 1Fh
@@5:	mov	al, byte ptr [bx]
	inc	bx
	stosb
	loop	@@5
	pop	si
	or	byte ptr [si], 80h
	dec	di
	cmp	si, di
	jne	@@6
	inc	di
	mov	byte ptr [di], 20h
@@6:	or	byte ptr [di], 80h
	inc	di
	mov	al, 0
	stosb
	mov	ax, word ptr [bx]
	inc	bx
	inc	bx
	mov	word ptr ds:[bp], ax
	inc	bp
	inc	bp
	dec	dx
	jne	@@1
	mov	word ptr textend, di
	mov	word ptr textlen, di
	sub	word ptr textlen, offset text
	xor	ax, ax
	mov	cx, 8
	rep stosw
	call	countlines
	pop	bp
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; reads a record header; then the file routines (DOS calls on helpfile)
readrec:	push	cx
	push	dx
	mov	dx, offset rec
	mov	cx, 3
	call	fread
	pop	dx
	pop	cx
	ret
fread:	push	ax
	mov	ah, 3Fh
fdos:	push	bx
	mov	bx, word ptr helpfile
	int	21h
	pop	bx
	pop	ax
	ret
fseek:	push	ax
	mov	ax, 4200h
	jmp	fdos
fseekcur:	push	ax
	mov	ax, 4201h
	jmp	fdos
fopen:	push	ax
	mov	ax, 3D00h
	int	21h
	mov	word ptr helpfile, ax
	pop	ax
	ret
fclose:	push	ax
	mov	ah, 3Eh
	jmp	fdos

; popped up: opens the help file, hooks INT 9, saves the screen, runs the
; viewer and puts everything back
popup_main:	cld
	mov	di, offset history
	mov	cx, 14h
@@1:	mov	ax, word ptr contents
	stosw
	mov	ax, word ptr contents+2
	stosw
	loop	@@1
	mov	byte ptr pushhist, cl
	mov	byte ptr textbuf, cl
	mov	dx, offset helpname
	call	fopen
	jb	beep
	push	es
	mov	ax, 3509h
	int	21h
	mov	word ptr oldint09, bx
	mov	word ptr oldint09+2, es
	pop	es
	mov	ax, 2509h
	mov	dx, offset newint09
	int	21h
	call	savescreen
	mov	al, byte ptr textattr
	mov	byte ptr curattr, al
	call	lookup
	call	viewer
	call	restscreen
	push	ds
	mov	ax, 2509h
	mov	dx, word ptr oldint09
	mov	ds, word ptr oldint09+2
	int	21h
	pop	ds
	jmp	fclose
tsrdone:	ret

; beeps (the help file could not be opened)
beep:	mov	ax, 0E07h
	xor	bx, bx
	int	10h
	ret

; hooks (CX 0) or unhooks INT 16h, for pasting
tsrsetup:	xchg	ax, cx
	jcxz	@@1
	push	ds
	mov	ax, 2516h
	mov	dx, word ptr oldint16
	mov	ds, word ptr oldint16+2
	int	21h
	pop	ds
	ret
@@1:	mov	ax, 3516h
	int	21h
	mov	word ptr oldint16, bx
	mov	word ptr oldint16+2, es
	mov	ax, 2516h
	mov	dx, offset newint16
	int	21h
	ret

; INT 16h while pasting: hands out the paste text as keystrokes
newint16:	sti
	push	bx
	push	cx
	push	dx
	push	bp
	push	si
	push	di
	push	ds
	push	es
	push	ax
	push	cs
	pop	ds
	push	cs
	pop	es
	cld
	cmp	byte ptr pasting, 0
	je	@@2
	cmp	ah, 0
	je	@@3
	cmp	ah, 1
	je	@@4
	cmp	ah, 10h
	je	@@3
	cmp	ah, 11h
	je	@@4
	jmp	short @@2
@@1:	mov	byte ptr pasting, 0
@@2:	pop	ax
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	bp
	pop	dx
	pop	cx
	pop	bx
	jmp	dword ptr cs:oldint16
@@3:	call	nextpaste
	or	al, al
	je	@@1
	jmp	short @@5
@@4:	call	peekpaste
	or	al, al
	je	@@1
	mov	bx, sp
	and	byte ptr ss:[bx+16h], 0BFh
@@5:	pop	bx
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	bp
	pop	dx
	pop	cx
	pop	bx
	iret

; INT 9 while popped up: Shift with a cursor key becomes a marking key
newint09:	push	ax
	push	cx
	push	di
	push	ds
	push	es
	push	cs
	pop	ds
	mov	ax, 40h
	mov	es, ax
	mov	ax, word ptr es:kbtail
	mov	word ptr ds:[KBSAVE], ax
	in	al, 60h
	mov	ah, byte ptr es:kbflag
	push	ax
	xor	ah, ah
	pushf
	call	dword ptr oldint09
	sti
	pop	ax
	test	al, 80h
	jne	@@6
	mov	di, offset shiftkeys
	mov	cx, 8
@@1:	cmp	al, byte ptr [di+1]
	jne	@@2
	test	byte ptr [di], ah
	jne	@@3
@@2:	inc	di
	inc	di
	loop	@@1
	jmp	short @@6
@@3:	mov	ax, word ptr [di+10h]
	mov	di, word ptr ds:[KBSAVE]
	cmp	di, word ptr es:kbtail
	jne	@@5
	mov	cx, di
	inc	di
	inc	di
	cmp	di, offset kbend
	jne	@@4
	mov	di, offset kbbuf
@@4:	cmp	di, word ptr es:kbhead
	je	@@6
	mov	word ptr es:kbtail, di
	mov	di, cx
@@5:	mov	word ptr es:[di], ax
@@6:	pop	es
	pop	ds
	pop	di
	pop	cx
	pop	ax
	iret

; Alt-F1: back to the previous topic
goback:	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	mov	si, 0FC1h
	mov	di, offset history
	mov	cx, 50h
	rep movsb
	mov	dx, word ptr history
	mov	ax, word ptr history+2
	mov	cx, ax
	or	ax, dx
	je	@@1
	call	fseek
	call	showtopic
	jmp	short @@2
@@1:	call	showindex2
@@2:	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret

; pushes the current topic onto the history
savehist:	cmp	byte ptr pushhist, 0
	je	@@1
	push	si
	push	di
	push	cx
	std
	mov	di, 100Ch
	mov	si, 1008h
	mov	cx, 4Ch
	rep movsb
	cld
	mov	byte ptr pushhist, cl
	pop	cx
	mov	word ptr history, dx
	mov	word ptr history+2, cx
	pop	di
	pop	si
@@1:	ret

; THELP's options. /W writes them back into THELP.COM from hotkey on
tsrid	db	'THELP2.0'
tsrnum	db	0, 0

; the hot key: shift state and scan code (/K); 4Ch is keypad 5
hotkey	db	4Ch, 0
snowcheck	db	0
casesens	db	1
wide	db	0
swapped	db	0

; the colours, each a colour and a monochrome attribute (/C): frame, text,
; link, link under the cursor, cross reference, marked block
frameattr	db	30h, 7
textattr	db	30h, 7
linkattr	db	3Eh, 71h
curlinkattr	db	1Eh, 70h
xrefattr	db	31h, 2Fh
markattr	db	70h, 71h

; the help file (/F)
helpname	db	'C:\BORLANDC\BIN\TCHELP.TCH', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0

; from here on the transient part's data, which the resident part reuses as
; buffers
linebuf	db	0, 0
hdrcontents	db	7 dup (0)
installed	db	0
quiet	db	0
saveopts	db	0
progname	db	'THELP.COM', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
textbuf	db	0

; the text of the current topic or index runs from here up to TEXTMAX
text	db	0
idblock	db	'$*$*$*', 1, 0Fh, 0, 2, 'THELP', 0, '2.0  '
sigword	db	'TURBO'
sigrest	db	'$*$* &&&&$*$', 0, 0
hdrbuf	db	14 dup (0)

; messages
banner	db	'Turbo Help  Version 2.0   Copyright (c) 1991 Borland International.'
	db	0Dh, 0Ah, 0Ah, 24h
msgindex	db	'Index too large for THelp', 0Dh, 0Ah, 24h
msgactivate	db	'To activate THelp, Press 5 on the numeric keypad.', 0Dh, 0Ah
	db	24h
msgunloaded	db	'THelp has been unloaded.', 0Dh, 0Ah, 24h
msgcantunload	db	'Cannot unload until TSRs loaded after THelp are removed.', 0Dh
	db	0Ah, 24h
msgloaded	db	'THelp already installed.', 0Dh, 0Ah, 24h
msgsaved	db	'Options saved in THELP.COM.', 0Dh, 0Ah, 24h
msgcantopen	db	'Cannot open $'
msginvalid	db	'Invalid help file.', 0Dh, 0Ah, 24h
msgauthor	db	'Written by David Stafford', 0Dh, 0Ah, 24h
msgoption	db	'Unrecognized option.', 0Dh, 0Ah, 0Ah

; /H
usage	db	'USAGE:', 9, 'THELP [options]', 0Dh, 0Ah, 0Ah, '/C#xx', 9, 'Select color: #=color number, xx=hex color value'
	db	0Dh, 0Ah, '/Fname', 9, 'Full pathname of help file', 0Dh, 0Ah
	db	'/H,/?', 9, 'Display this help screen', 0Dh, 0Ah, '/Kxxyy', 9
	db	'Hotkey: xx=shift state, yy=scan code', 0Dh, 0Ah, '/S+-', 9, 'Snow checking for video switch (default=S'
snowdefault	db	2Dh, 29h, 0Dh, 0Ah, 2Fh, 55h, 9, 'Remove THELP from memory', 0Dh
	db	0Ah, 2Fh, 57h, 9, 'Write Options to THELP.COM and exit', 0Dh, 0Ah
	db	2Fh, 44h, 9, 'Increase THELP Display Width', 0Dh, 0Ah, 24h

; the command line
options:	mov	al, 2Dh
	cmp	byte ptr snowcheck, 0
	je	@@1
	mov	al, 2Bh
@@1:	mov	byte ptr snowdefault, al
	mov	si, 81h
	mov	ch, 0
	mov	cl, byte ptr ds:[80h]
	jcxz	@@13
@@2:	lodsb
	cmp	al, 2Fh
	jbe	@@12
	call	upcase
	cmp	al, 48h
	jne	@@3
	dec	byte ptr quiet
	mov	ah, 9
	mov	dx, offset usage
	int	21h
	jmp	short @@12
@@3:	cmp	al, 44h
	jne	@@4
	mov	byte ptr wide, 1
	jmp	short @@12
@@4:	cmp	al, 55h
	jne	@@5
	call	unload
	jmp	short @@12
@@5:	cmp	al, 57h
	jne	@@6
	inc	byte ptr saveopts
	dec	byte ptr quiet
	jmp	short @@12
@@6:	cmp	al, 46h
	jne	@@9
	mov	di, offset helpname
@@7:	dec	cx
	jcxz	@@8
	lodsb
	stosb
	cmp	al, 20h
	jne	@@7
	dec	di
@@8:	mov	byte ptr [di], 0
	jmp	short @@12
@@9:	cmp	al, 4Bh
	jne	@@10
	mov	bx, 4
	sub	cx, bx
	jb	@@14
	call	@@17
	jmp	short @@12
@@10:	cmp	al, 43h
	jne	@@11
	sub	cx, 3
	jb	@@14
	call	@@18
	jmp	short @@12
@@11:	cmp	al, 53h
	jne	@@14
	lodsb
	sub	al, 2Dh
	mov	byte ptr snowcheck, al
	dec	cx
@@12:	dec	cx
	jg	@@2
@@13:	ret
@@14:	dec	byte ptr quiet
	mov	ah, 9
	mov	dx, offset msgoption
	cmp	al, 49h
	jne	@@15
	mov	dx, offset msgauthor
@@15:	int	21h
	ret
@@16:	lodsb
	and	al, 4Fh
	aam	41h
	aad	0Ah
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	or	dl, al
	ret
@@17:	call	@@16
	dec	bx
	jne	@@17
	mov	word ptr hotkey, dx
	ret
@@18:	call	@@16
	mov	bx, offset frameattr
	add	bx, ax
	call	@@16
	call	@@16
	mov	byte ptr [bx], dl
	ret

; /W: writes the options into THELP.COM
writeopts:	mov	dx, offset progname
	mov	ax, 3D01h
	int	21h
	jb	@@1
	mov	word ptr helpfile, ax
	xor	cx, cx
	mov	dx, 1F8Ch
	call	fseek
	mov	ah, 40h
	mov	bx, word ptr helpfile
	mov	cx, 62h
	mov	dx, offset hotkey
	int	21h
	call	fclose
	mov	ah, 9
	mov	dx, offset msgsaved
	int	21h
	ret
@@1:	mov	di, offset progname
cantopen:	push	di
	mov	cl, 0FFh
	mov	al, 0
	repne scasb
	mov	byte ptr [di], 24h
	mov	ah, 9
	mov	dx, offset msgcantopen
	int	21h
	pop	dx
	int	21h
	ret

; /U: unloads the resident copy through INT 2Fh
unload:	push	cx
	dec	byte ptr quiet
	cmp	byte ptr installed, 0
	je	@@4
	push	es
	mov	ax, 3509h
	int	21h
	mov	cx, 1Bh
	xor	ax, ax
@@1:	xor	ax, word ptr es:[bx]
	add	ax, word ptr es:[bx]
	inc	bx
	loop	@@1
	pop	es
	cmp	ax, 9DAh
	je	@@2
	mov	dx, offset msgcantunload
	jmp	short @@3
@@2:	mov	ax, 5453h
	mov	bx, 12h
	mov	cx, word ptr tsrnum
	int	2Fh
	mov	dx, offset msgunloaded
@@3:	mov	ah, 9
	int	21h
@@4:	pop	cx
	ret

; the program's own path, from the environment (DOS 3 and later)
getprogname:	mov	ah, 30h
	int	21h
	cmp	al, 3
	jb	@@3
	push	ds
	mov	ds, word ptr ds:[2Ch]
	xor	si, si
@@1:	lodsb
	or	al, al
	jne	@@1
	lodsb
	or	al, al
	jne	@@1
	lodsw
	mov	di, offset progname
@@2:	lodsb
	stosb
	or	al, al
	jne	@@2
	pop	ds
@@3:	ret
skiprec:	xor	cx, cx
	mov	dx, word ptr reclen
	jmp	fseekcur
ftell:	mov	ax, 4201h
	mov	bx, word ptr helpfile
	xor	cx, cx
	mov	dx, cx
	int	21h
	ret

; checks the help file's signature
checksig:	mov	cx, 5
	mov	dx, offset hdrbuf
	call	fread
	jb	@@2
	mov	si, offset hdrbuf
	mov	di, offset sigword
	mov	cx, 5
	repe cmpsb
	jne	@@2
@@1:	mov	cx, 1
	call	fread
	jb	@@2
	cmp	byte ptr hdrbuf, 1Ah
	jne	@@1
	mov	cx, 0Fh
	call	fread
	jb	@@2
	mov	si, offset hdrbuf
	mov	di, offset sigrest
	mov	cx, 0Dh
	repe cmpsb
	jne	@@2
	lodsb
	cmp	al, 5
	je	@@3
	cmp	al, 33h
	je	@@3
@@2:	stc
	ret
@@3:	clc
	ret
readcontents:	mov	ax, word ptr hdrcontents
	mov	bx, 3
	mul	bx
	add	ax, word ptr topicbase
	adc	dx, word ptr topicbase+2
	mov	cx, dx
	xchg	ax, dx
	call	fseek
	mov	cx, 3
	mov	dx, offset contents
	jmp	fread
readfilehdr:	mov	cx, 0Fh
	mov	dx, offset filehdr
	call	fread
	jb	@@1
	cmp	byte ptr filehdr, 2
	je	@@1
	stc
@@1:	ret

; opens the help file and finds its index, contents and tables
openhelp:	mov	dx, offset helpname
	call	fopen
	jae	@@1
	mov	di, offset helpname
	call	cantopen
	stc
	ret
@@1:	call	checksig
	jb	@@2
	call	readrec
	jb	@@2
	cmp	byte ptr rec, 0
	jne	@@3
	mov	cx, 9
	mov	dx, offset linebuf
	call	fread
	jb	@@4
	mov	al, byte ptr linebuf
	and	al, 4
	mov	byte ptr casesens, al
	call	readrec
@@2:	jb	@@4
	cmp	byte ptr rec, 5
	jne	@@4
	call	readfilehdr
	jb	@@4
	call	readrec
	jb	@@4
	cmp	byte ptr rec, 1
@@3:	jne	@@4
	call	ftell
	add	ax, 2
	adc	dx, 0
	mov	word ptr topicbase, ax
	mov	word ptr topicbase+2, dx
	call	skiprec
	jb	@@4
	call	ftell
	mov	word ptr indexpos, ax
	mov	word ptr indexpos+2, dx
	call	readrec
	jb	@@4
	cmp	byte ptr rec, 4
	jne	@@4
	mov	ax, word ptr reclen
	cmp	ax, 9E00h
	jae	@@7
	sub	ax, 3
	call	readrec
	cmp	word ptr rec, 0BB8h
	mov	word ptr reclen, ax
	jae	@@7
	call	skiprec
	jb	@@4
	call	readrec
	jb	@@4
	cmp	byte ptr rec, 2
	je	@@6
@@4:	mov	dx, offset msginvalid
@@5:	call	fclose
	mov	ah, 9
	int	21h
	stc
	ret
@@6:	call	readcontents
	call	fclose
	clc
	ret
@@7:	mov	dx, offset msgindex
	jmp	@@5

; the CRT status port, and the snow patches (see drawframe)
videosetup:	push	ds
	xor	ax, ax
	mov	ds, ax
	mov	ax, word ptr ds:[463h]
	pop	ds
	add	ax, 6
	mov	word ptr crtstatus, ax
	cmp	byte ptr snowcheck, 0
	jne	@@1
	mov	ax, 0ABF3h
	mov	word ptr snow2, ax
	mov	al, 90h
	mov	byte ptr snow2+2, al
	mov	al, 0ABh
	mov	byte ptr snow1, al
	mov	byte ptr snow3, al
	mov	byte ptr snow4, al
	mov	byte ptr snow5, al
	mov	byte ptr snow6, al
	mov	byte ptr snow7, al
	mov	ax, 0E489h
	mov	word ptr snow1+1, ax
	mov	word ptr snow3+1, ax
	mov	word ptr snow4+1, ax
	mov	word ptr snow5+1, ax
	mov	word ptr snow6+1, ax
	mov	word ptr snow7+1, ax
@@1:	ret

; THELP starts here
main:	mov	ah, 9
	mov	dx, offset banner
	int	21h
	call	getprogname
	mov	si, offset tsrid
	mov	di, offset tsrnum
	call	tsrcheck
	mov	byte ptr installed, al
	push	cs
	pop	es
	call	options
	call	videosetup
	cmp	byte ptr saveopts, 0
	je	@@1
	call	writeopts
@@1:	cmp	byte ptr quiet, 0
	jne	@@4
	cmp	byte ptr installed, 0
	je	@@2
	mov	ah, 9
	mov	dx, offset msgloaded
	int	21h
	ret
@@2:	mov	di, offset TSRSTACK
	mov	si, offset KBSAVE
	call	tsrstacks
	call	openhelp
	jb	@@4
	cmp	word ptr hotkey, 4Ch
	jne	@@3
	mov	ah, 9
	mov	dx, offset msgactivate
	int	21h
@@3:	mov	ax, word ptr hotkey
	mov	bx, 1010h
	mov	dx, offset RESEND
	call	tsrinstall
@@4:	ret
code	ends
	end
