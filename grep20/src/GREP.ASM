; GREP.ASM: Turbo GREP 3.0 of Borland C++ 2.0, a .COM program in assembler.
;
; GREP searches files for lines that match a string or, with -r, a regular expression.
; usage() and getopts() read the command line, getpat() and compile() turn the search
; string into pattern and patlit, and for each file of each file set (nextspec(), dofiles(),
; recursively with -d) grepfile() searches the file in one buffer from the end of the
; program to the end of memory. A pattern with a literal character in it is searched for
; through its rarest literal, the anchor, with repne scasb (scanfast()); then
; matchleft() and matchright() try the rest of the pattern on each side of it.
;
; The buffer is laid over the help text and the messages that only the start needs, and
; -u writes the new default options into defopts and saves the whole program, as far as
; progend, as a new GREP.COM.
;
; Assembled with TASM 2.51 in one pass (two forward jumps written without SHORT carry the
; NOP that a single pass leaves) and linked with TLINK /t. GREP.COM keeps no symbols, so
; every name is descriptive.
	locals
	.8086

O_R	equ	0001h	; -r regular expression search
O_L	equ	0002h	; -l file names only
O_C	equ	0004h	; -c match count only
O_N	equ	0008h	; -n line numbers
O_V	equ	0010h	; -v non-matching lines
O_I	equ	0020h	; -i ignore case
O_D	equ	0040h	; -d search subdirectories
O_Z	equ	0080h	; -z verbose
O_W	equ	0100h	; -w word search
O_O	equ	0200h	; -o UNIX output format
O_U	equ	0400h	; -u update the default options

; the codes of the pattern (with patlit L_CODE)
P_BOL	equ	1	; ^
P_EOL	equ	2	; $
P_ANY	equ	3	; .
P_STAR	equ	4	; *
P_PLUS	equ	5	; +
P_SET	equ	6	; [
P_ENDSET equ	7	; ]
P_NOT	equ	8	; ^ after [
P_RANGE	equ	9	; - in a set

; patlit: what an element of pattern is
L_LIT	equ	0	; a character
L_CODE	equ	1	; a code P_...
L_SET	equ	2	; a [ ] set, numbered from 1, in the buffer

code	segment
	assume	cs:code,ds:code,es:code,ss:code
	org	100h
start:	jmp	init
defopts	dw	O_R	; the default options, rewritten by -u


; stdintty: ZF set when stdin is the console (IOCTL 4400h on handle 0)
stdintty:	xor	bx, bx
	mov	ax, 4400h
	int	21h
	not	dl
	test	dl, 80h
	jne	@@1
	test	dl, 2
@@1:	ret

; catch: saves SP and the return address and returns with CF clear; throw
; returns to the same place again, with CF set
catch:	mov	ax, sp
	inc	ax
	inc	ax
	mov	word ptr catchsp, ax
	pop	bx
	mov	word ptr catchip, bx
	clc
	jmp	bx

; throw: see catch
throw:	mov	sp, word ptr catchsp
	mov	bx, word ptr catchip
	stc
	jmp	bx

; puts: writes the ASCIIZ string at AX through DOS function 2; CR becomes
; CR LF and LF is dropped
puts:	push	dx
	push	si
	mov	si, ax
@@1:	lodsb
	or	al, al
	je	@@3
	cmp	al, 10
	je	@@1
	cmp	al, 13
	je	@@2
	mov	dl, al
	mov	ah, 2
	int	21h
	jmp	short @@1
@@2:	mov	dl, 13
	mov	ah, 2
	int	21h
	mov	dl, 10
	mov	ah, 2
	int	21h
	jmp	short @@1
@@3:	pop	si
	pop	dx
	ret

; putnum: writes DX:AX in decimal
putnum:	push	bx
	push	cx
	mov	bx, offset numend
	mov	cx, 10
@@1:	div	cx
	add	dl, '0'
	dec	bx
	mov	byte ptr [bx], dl
	xor	dx, dx
	or	ax, ax
	jne	@@1
	mov	ax, bx
	call	puts
	pop	cx
	pop	bx
	ret

; error: writes "Error: " and the message at AX
error:	push	ax
	mov	ax, offset errmsg
	call	puts
	pop	ax
	call	puts
	mov	ax, offset crlf
	call	puts
	ret

; fatal: error, then exit with code 4Ch... AL
fatal:	call	error
	mov	ah, 4Ch
	int	21h

; filehead: writes "File name:" before a file's first matching line
filehead:	cmp	byte ptr headdone, 0FFh
	je	@@4
	mov	ax, offset fullname
	cmp	byte ptr fname, 0
	jne	@@1
	mov	ax, offset stdinmsg
@@1:	test	word ptr opts, O_O
	je	@@3
	call	puts
	mov	ax, word ptr opts
	and	ax, O_L or O_C or O_N or O_Z
	cmp	ax, O_L
	je	@@2
	mov	dl, 9
	mov	ah, 2
	int	21h
	jmp	short @@4
@@2:	mov	ax, offset crlf
	call	puts
	jmp	short @@4
@@3:	push	ax
	mov	ax, offset filemsg
	call	puts
	pop	ax
	call	puts
	mov	ax, offset colon
	call	puts
	mov	byte ptr headdone, 0FFh
@@4:	ret

; noecho: CF set when the line is not to be written: -l, -c, or -v with a match
noecho:	or	bp, bp
	je	@@2
	test	word ptr opts, O_N or O_Z
	jne	@@1
	test	word ptr opts, O_L or O_C
	jne	@@2
@@1:	clc
	ret
@@2:	stc
	ret

; report: a line has been found (or not, with -v): counts it, or writes it with its
; number and its file name as the options say
report:	mov	al, byte ptr matched
	cbw
	xor	ax, word ptr opts
	and	ax, O_V
	mov	bp, ax
	je	@@4
	mov	ax, word ptr opts
	and	ax, O_C or O_N or O_Z or O_O
	cmp	ax, O_C or O_O
	je	@@1
	call	filehead
@@1:	test	word ptr opts, O_C or O_Z
	jne	@@2
	test	word ptr opts, O_L
	je	@@3
	xor	cx, cx
	mov	byte ptr lastblock, 0FFh
	jmp	@@10
@@2:	test	word ptr opts, O_C or O_Z
	je	@@3
	inc	word ptr nlines
	test	word ptr opts, O_Z
	jne	@@3
	mov	al, 13
	push	di
	repne scasb
	pop	ax
	mov	di, ax
@@3:	test	word ptr opts, O_N or O_Z
	je	@@4
	mov	ax, word ptr lineno
	mov	dx, word ptr lineno+2
	call	putnum
	mov	dl, 9
	mov	ah, 2
	int	21h
@@4:	mov	al, 10
	mov	cx, 0FFFFh
	push	di
	std
	repne scasb
	cld
	xchg	si, di
	pop	cx
	lodsw
@@5:	lodsb
	cmp	si, cx
	jbe	@@6
	cmp	al, 13
	je	@@8
@@6:	call	noecho
	jb	@@5
	mov	dl, al
	cmp	al, 20h
	jae	@@7
	cmp	al, 9
	je	@@7
	mov	dh, dl
	mov	dl, '^'
	mov	ah, 2
	int	21h
	mov	dl, dh
	or	dl, 40h
@@7:	mov	ah, 2
	int	21h
	jmp	short @@5
@@8:	xchg	di, si
	call	noecho
	jb	@@9
	mov	dl, 13
	mov	ah, 2
	int	21h
	mov	dl, 10
	mov	ah, 2
	int	21h
@@9:	call	restlen
@@10:	ret

; inset: ZF set when AL is one of the CX bytes at BX; AX its index
inset:	push	di
	mov	di, bx
	repne scasb
	pushf
	sub	di, bx
	mov	ax, di
	dec	ax
	popf
	pop	di
	ret

; issep: ZF set when AL is : \ or /
issep:	cmp	al, ':'
	je	@@1
	cmp	al, '\'
	je	@@1
	cmp	al, '/'
@@1:	ret

; strcpy: copies the string at SI to DI; DI is left on its NUL
strcpy:	push	si
@@1:	lodsb
	stosb
	or	al, al
	jne	@@1
	dec	di
	pop	si
	ret

; strlen: the length of the string at DI, in AX
strlen:	push	di
	push	cx
	cld
	mov	al, 0
	mov	cx, 0FFFFh
	repne scasb
	not	cx
	mov	ax, cx
	dec	ax
	pop	cx
	pop	di
	ret

; setbit: sets bit AL of the 256-bit set at DI to CH (0 or FFh)
setbit:	mov	ah, 0
	mov	cl, 3
	ror	ax, cl
	rol	ah, cl
	mov	cl, ah
	cbw
	mov	bx, ax
	mov	al, 1
	shl	al, cl
	mov	ah, al
	not	ah
	and	ah, byte ptr [bx+di]
	and	al, ch
	or	ah, al
	mov	byte ptr [bx+di], ah
	ret

; testbit: ZF clear when bit AL of the 256-bit set at SI is set
testbit:	push	ax
	push	cx
	push	si
	mov	ah, 0
	mov	cl, 3
	ror	ax, cl
	rol	ah, cl
	mov	cl, ah
	cbw
	add	si, ax
	mov	al, 1
	shl	al, cl
	test	byte ptr [si], al
	pop	si
	pop	cx
	pop	ax
	ret

; readmore: reads the file into the rest of the buffer and makes sure it ends
; with a whole line (a CR is added at the end of the file)
readmore:	push	bx
	push	cx
	push	dx
	push	di
	mov	ah, 11
	int	21h
	mov	bx, word ptr handle
	mov	cx, word ptr bufsize
	mov	ax, word ptr buflen
	sub	cx, ax
	mov	dx, word ptr bufp
	add	dx, ax
	mov	ah, 3Fh
	int	21h
	jae	@@1
	mov	ax, offset readmsg
	jmp	fatal
@@1:	add	word ptr buflen, ax
	mov	bx, dx
	add	bx, ax
	dec	bx
	cmp	ax, cx
	mov	cx, word ptr buflen
	je	@@5
	mov	byte ptr lastblock, 0FFh
@@2:	cmp	byte ptr [bx], 1Ah
	jne	@@3
	dec	bx
	dec	cx
	jmp	short @@2
@@3:	cmp	byte ptr [bx], 10
	jne	@@4
	dec	bx
	dec	cx
@@4:	cmp	byte ptr [bx], 13
	je	@@5
	inc	bx
	inc	cx
	mov	byte ptr [bx], 13
@@5:	mov	word ptr buflen, cx
	mov	cx, bx
	sub	cx, dx
	inc	cx
	mov	di, bx
	mov	al, 13
	std
	repne scasb
	cld
	je	@@6
	call	filehead
	mov	ax, offset longmsg
	call	error
	call	throw
@@6:	inc	di
	mov	word ptr blockstart, di
	pop	di
	pop	dx
	pop	cx
	pop	bx
	ret

; restlen: CX = the bytes of the buffer from DI to its end
restlen:	mov	cx, word ptr bufp
	add	cx, word ptr buflen
	sub	cx, di
	ret

; nextblock: moves the partial line at the end of the buffer to its start and
; reads more after it; a line longer than the buffer stops the search
nextblock:	push	di
	mov	cx, di
	sub	cx, word ptr bufp
	inc	cx
	mov	al, 10
	std
	repne scasb
	cld
	inc	di
	cmp	di, word ptr bufp
	jne	@@1
	call	filehead
	mov	ax, offset longmsg
	call	error
	call	throw
@@1:	mov	cx, word ptr bufp
	mov	si, di
	mov	di, cx
	add	cx, word ptr buflen
	sub	cx, si
	mov	word ptr buflen, cx
	shr	cx, 1
	jae	@@2
	movsb
@@2:	rep movsw
	mov	ax, si
	sub	ax, di
	pop	di
	sub	di, ax
	call	readmore
	call	restlen
	clc
	ret

; enterdir: appends the subdirectory found (in the DTA) and \ to path
enterdir:	mov	di, offset path
	call	strlen
	add	di, ax
	mov	si, offset dta+1Eh
@@1:	lodsb
	or	al, al
	je	@@2
	stosb
	jmp	short @@1
@@2:	mov	ax, 5Ch
	stosw
	dec	di
	ret

; leavedir: takes the last directory off path
leavedir:	mov	dx, offset path
	mov	di, dx
	call	strlen
	add	di, ax
	dec	di
	dec	di
	mov	si, di
	std
@@1:	lodsb
	call	issep
	je	@@2
	cmp	si, dx
	jae	@@1
	dec	si
@@2:	inc	si
	inc	si
	mov	byte ptr [si], 0
	cld
	ret

; pushdta: copies the search state of the DTA onto the stack, for a recursive search
pushdta:	pop	ax
	sub	sp, 16h
	mov	si, offset dta
	mov	di, sp
	mov	cx, 15h
	rep movsb
	push	ax
	ret

; popdta: and back
popdta:	pop	ax
	mov	si, sp
	mov	di, offset dta
	mov	cx, 15h
	rep movsb
	add	sp, 16h
	push	ax
	ret

; dofiles: searches every file of the current file set, and with -d every
; subdirectory, recursively
dofiles:	call	stackchk
	cmp	byte ptr fname, 0
	jne	@@1
	xor	ax, ax
	jmp	short @@6
@@1:	test	word ptr opts, O_D
	je	@@4
	mov	ah, 4Eh
@@2:	mov	dx, offset fullname
	mov	di, dx
	mov	si, offset path
	call	strcpy
	mov	si, offset allfiles
	call	strcpy
	mov	cx, 10h
	int	21h
	jb	@@4
	test	byte ptr dta+15h, cl
	je	@@3
	cmp	byte ptr dta+1Eh, 2Eh
	je	@@3
	call	enterdir
	call	pushdta
	call	dofiles
	call	popdta
	call	leavedir
@@3:	mov	ah, 4Fh
	jmp	short @@2
@@4:	mov	ah, 4Eh
	mov	byte ptr dta+1Eh, 0
@@5:	mov	dx, offset fullname
	mov	di, dx
	mov	si, offset path
	call	strcpy
	mov	si, offset fname
	call	strcpy
	xor	cx, cx
	int	21h
	jb	@@8
	mov	di, dx
	mov	si, offset path
	call	strcpy
	mov	si, offset dta+1Eh
	call	strcpy
	mov	ah, 3Dh
	int	21h
	jae	@@6
	mov	ax, offset openmsg
	jmp	fatal
@@6:	mov	word ptr handle, ax
	mov	byte ptr lastblock, 0
	mov	byte ptr headdone, 0
	mov	word ptr buflen, 1
	call	catch
	jb	@@7
	call	readmore
	call	grepfile
@@7:	mov	bx, word ptr handle
	or	bx, bx
	je	@@10
	mov	ah, 3Eh
	int	21h
	mov	ah, 4Fh
	jmp	short @@5
@@8:	cmp	byte ptr dta+1Eh, 0
	jne	@@10
	test	word ptr opts, O_Z
	jne	@@9
	test	word ptr opts, O_D
	jne	@@10
@@9:	mov	ax, offset nomatchmsg
	call	puts
	mov	ax, dx
	call	puts
	mov	ax, offset crlf
	call	puts
@@10:	xor	ax, ax
	ret

; cutpat: removes pattern elements BX..DI-1, moving SI.. down over them
cutpat:	mov	cx, di
	sub	cx, bx
	inc	cx
	mov	di, si
	mov	si, bx
	push	cx
	push	si
	push	di
	add	si, offset pattern
	add	di, offset pattern
	rep movsb
	pop	di
	pop	si
	pop	cx
	add	di, offset patlit
	add	si, offset patlit
	rep movsb
	mov	di, offset pattern
	call	strlen
	mov	di, ax
	ret

; compile: turns the parsed pattern into the form the matcher uses: ^ and $
; inside the pattern become literals, * and + at its ends are dropped, [ ] sets
; become bit sets in the buffer, and the rarest literal becomes the anchor
compile:	mov	dx, 0FFh
	cmp	byte ptr pattern, 0
	jne	@@1
	mov	ax, offset nopatmsg
	jmp	fatal
@@1:	mov	bx, 0FFFFh
@@2:	inc	bx
	mov	al, byte ptr [bx+pattern]
	or	al, al
	je	@@4
	cmp	al, P_EOL
	jne	@@3
	cmp	byte ptr [bx+pattern+1], 0
	je	@@4
	mov	byte ptr [bx+pattern], 24h
	mov	byte ptr [bx+patlit], L_LIT
@@3:	cmp	al, P_BOL
	jne	@@2
	or	bx, bx
	je	@@2
	mov	byte ptr [bx+pattern], 5Eh
	mov	byte ptr [bx+patlit], L_LIT
	jmp	short @@2
@@4:	test	word ptr opts, O_W
	je	@@5
	jmp	@@17
@@5:	cmp	byte ptr patlit, L_LIT
	je	@@7
	mov	al, byte ptr pattern
	cmp	al, P_STAR
	jne	@@6
	mov	ax, offset starmsg
	jmp	fatal
@@6:	cmp	al, P_PLUS
	jne	@@7
	mov	ax, offset plusmsg
	jmp	fatal
@@7:	mov	di, offset pattern
	call	strlen
	mov	di, ax
@@8:	xor	bx, bx
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@10
	cmp	byte ptr [bx+pattern], P_SET
	jne	@@10
@@9:	inc	bx
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@9
	cmp	byte ptr [bx+pattern], P_ENDSET
	jne	@@9
@@10:	inc	bx
	cmp	bx, di
	jae	@@12
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@12
	cmp	byte ptr [bx+pattern], P_STAR
	jne	@@11
	inc	bx
	xor	si, si
	call	cutpat
	jmp	short @@8
@@11:	cmp	byte ptr [bx+pattern], P_PLUS
	jne	@@12
	mov	si, bx
	inc	bx
	call	cutpat
@@12:	mov	bx, di
@@13:	sub	bx, 1
	jb	@@17
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@16
	cmp	byte ptr [bx+pattern], P_STAR
	jne	@@16
	dec	bx
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@15
	cmp	byte ptr [bx+pattern], P_ENDSET
	jne	@@15
@@14:	dec	bx
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@14
	cmp	byte ptr [bx+pattern], P_SET
	jne	@@14
@@15:	mov	byte ptr [bx+pattern], 0
	jmp	short @@13
	mov	word ptr pattern, 1	; never reached: nothing jumps here
	mov	word ptr patlit, 1
	jmp	short @@17
@@16:	cmp	byte ptr [bx+patlit], L_LIT
	je	@@17
	cmp	byte ptr [bx+pattern], P_PLUS
	je	@@15
@@17:	xor	si, si
@@18:	mov	al, byte ptr [si+pattern]
	mov	ah, byte ptr [si+patlit]
	inc	si
	or	al, al
	jne	@@19
	jmp	@@39
@@19:	cmp	ah, 0
	je	@@24
	cmp	al, P_ANY
	je	@@28
	cmp	al, P_STAR
	je	@@20
	cmp	al, P_PLUS
	jne	@@22
@@20:	cmp	byte ptr [si+patlit], L_LIT
	je	@@28
	mov	al, byte ptr [si+pattern]
	cmp	al, P_STAR
	je	@@21
	cmp	al, P_PLUS
	jne	@@28
@@21:	mov	ax, offset misusemsg
	jmp	fatal
@@22:	cmp	al, P_BOL
	jne	@@23
	mov	al, 10
	jmp	short @@26
@@23:	cmp	al, P_EOL
	jne	@@29
	mov	al, 13
	jmp	short @@26
@@24:	cmp	byte ptr [si+patlit], L_LIT
	je	@@25
	cmp	byte ptr [si+pattern], P_STAR
	je	@@28
@@25:	test	word ptr opts, O_I
	je	@@26
	cmp	al, 'A'
	jb	@@26
	cmp	al, 'Z'
	ja	@@26
	mov	ah, al
	mov	bx, offset rarity
	xlat
	mov	al, cl
	mov	al, ah
	or	al, 20h
	xlat
	cmp	al, cl
	jae	@@27
	mov	al, cl
	jmp	short @@27
@@26:	mov	bx, offset rarity
	mov	ah, al
	xlat
@@27:	cmp	al, dl
	jae	@@28
	mov	dl, al
	mov	byte ptr anchorch, ah
	mov	byte ptr anchor, dh
	mov	byte ptr anchorch-1, 0
@@28:	inc	dh
	jmp	@@18
@@29:	cmp	al, P_SET
	jne	@@24
	cmp	word ptr bufsize, 400h
	jae	@@30
	mov	ax, offset memmsg
	jmp	fatal
@@30:	push	si
	mov	al, byte ptr [si+pattern]
	mov	ah, byte ptr [si+patlit]
	mov	cx, 10h
	mov	di, word ptr bufp
	cmp	ah, 0
	jne	@@32
@@31:	mov	ax, 0FFFFh
	jmp	short @@33
@@32:	cmp	al, P_NOT
	jne	@@31
	xor	ax, ax
@@33:	push	di
	rep stosw
	pop	di
	not	al
	mov	ch, al
@@34:	mov	al, byte ptr [si+pattern]
	mov	ah, byte ptr [si+patlit]
	inc	si
	cmp	ah, 0
	je	@@35
	cmp	al, P_ENDSET
	je	@@38
@@35:	cmp	byte ptr [si+patlit], L_LIT
	je	@@37
	cmp	byte ptr [si+pattern], P_RANGE
	jne	@@37
	cmp	al, byte ptr [si+pattern+1]
	jbe	@@36
	inc	si
	inc	si
	jmp	short @@34
@@36:	dec	si
	inc	byte ptr [si+pattern]
@@37:	call	setbit
	jmp	short @@34
@@38:	mov	ax, 20h
	add	word ptr bufp, ax
	sub	word ptr bufsize, ax
	mov	bx, si
	pop	si
	inc	byte ptr nsets
	mov	al, byte ptr nsets
	mov	byte ptr [si+pattern-1], al
	mov	byte ptr [si+patlit-1], L_SET
	mov	di, offset pattern
	call	strlen
	mov	di, ax
	push	si
	call	cutpat
	pop	si
	jmp	@@28
@@39:	mov	byte ptr [di+patlit], L_LIT
	ret

; skipblank: skips blanks at DI
skipblank:	mov	al, byte ptr [di]
	mov	bx, offset blanks
	mov	cx, 2
	call	inset
	jne	@@1
	inc	di
	jmp	short skipblank
@@1:	ret

; usage: GREP with no arguments, or GREP ?: the syntax or the help, then exit
usage:	mov	di, word ptr argp
	call	skipblank
	mov	al, byte ptr [di]
	or	al, al
	je	@@8
	cmp	al, '?'
	je	@@1
	jmp	@@10
@@1:	mov	ax, word ptr defopts
	xor	bx, bx
	mov	cx, 11
@@2:	mov	di, word ptr [bx+helpopts]
	mov	byte ptr [di], 2Dh
	clc
	rcr	ax, 1
	jae	@@3
	mov	byte ptr [di], 2Bh
@@3:	inc	bx
	inc	bx
	loop	@@2
	mov	ax, offset banner
	call	puts
	mov	ax, offset help
	call	puts
	xor	ax, ax
	mov	si, offset wordset
@@4:	inc	al
	je	@@7
	cmp	al, 'a'
	jb	@@5
	cmp	al, 'z'
	jbe	@@4
@@5:	call	testbit
	je	@@6
	or	ah, ah
	jne	@@4
	mov	ah, al
	push	ax
	mov	dl, al
	mov	ah, 2
	int	21h
	pop	ax
	jmp	short @@4
@@6:	or	ah, ah
	je	@@4
	inc	ah
	cmp	al, ah
	mov	ah, 0
	je	@@4
	push	ax
	mov	dl, '-'
	mov	ah, 2
	int	21h
	pop	ax
	push	ax
	dec	al
	mov	dl, al
	mov	ah, 2
	int	21h
	pop	ax
	jmp	short @@4
@@7:	mov	ax, offset help2
	call	puts
	jmp	short @@9
@@8:	mov	ax, offset banner
	call	puts
	mov	ax, offset syntax
	call	puts
@@9:	mov	ah, 4Ch
	int	21h
@@10:	mov	word ptr argp, di
	ret

; getopts: reads the -options at the start of the command line
getopts:	mov	di, word ptr argp
@@1:	call	skipblank
	mov	al, byte ptr [di]
	cmp	al, '-'
	je	@@2
	jmp	@@19
@@2:	inc	di
@@3:	mov	al, byte ptr [di]
	inc	di
	mov	byte ptr optch, al
	or	al, 20h
	mov	bx, offset optlets
	mov	cx, 11
	call	inset
	je	@@4
	mov	ax, offset buffer
	jmp	fatal
@@4:	inc	al
	mov	cl, al
	xor	dx, dx
	stc
	rcl	dx, cl
	mov	ax, dx
	mov	cl, byte ptr [di]
	cmp	cl, '+'
	je	@@6
	cmp	cl, '-'
	je	@@5
	jmp	@@7
@@5:	xor	ax, ax
@@6:	inc	di
@@7:	not	dx
	and	dx, word ptr opts
	push	ax
	or	ax, dx
	mov	word ptr opts, ax
	pop	ax
	cmp	ax, O_W
	jne	@@17
	cmp	byte ptr [di], 5Bh
	jne	@@17
	inc	di
	xor	ax, ax
	cmp	byte ptr [di], 5Eh
	jne	@@8
	dec	ax
	inc	di
@@8:	push	di
	mov	di, offset wordset
	mov	cx, 10h
	cld
	rep stosw
	pop	di
	not	al
	mov	ch, al
@@9:	mov	al, byte ptr [di]
	inc	di
	cmp	al, '-'
	jne	@@10
	mov	ax, offset rangemsg
	jmp	fatal
@@10:	push	ax
	push	cx
	mov	bx, offset blanks
	mov	cx, 2
	call	inset
	pop	cx
	pop	ax
	jne	@@11
	mov	ax, offset rbrkmsg
	jmp	fatal
@@11:	cmp	al, ']'
	je	@@17
	cmp	byte ptr [di], 2Dh
	jne	@@13
	cmp	al, byte ptr [di+1]
	jbe	@@12
	inc	di
	inc	di
	jmp	short @@9
@@12:	dec	di
	inc	byte ptr [di]
@@13:	push	di
	push	ax
	mov	di, offset wordset
	call	setbit
	pop	ax
	cmp	al, 'a'
	jb	@@14
	cmp	al, 'z'
	ja	@@16
	and	al, 0DFh
	jmp	short @@15
@@14:	cmp	al, 'A'
	jb	@@16
	cmp	al, 'Z'
	ja	@@16
	or	al, 20h
@@15:	call	setbit
@@16:	pop	di
	jmp	short @@9
@@17:	mov	al, byte ptr [di]
	or	al, al
	je	@@19
	mov	bx, offset blanks
	mov	cx, 2
	call	inset
	je	@@18
	jmp	@@3
@@18:	jmp	@@1
@@19:	mov	word ptr argp, di
	ret

; getpat: reads the search string into pattern and patlit
getpat:	mov	di, word ptr argp
	xor	si, si
	mov	dl, 0
	xor	bp, bp
@@1:	mov	al, byte ptr [di]
	or	al, al
	jne	@@2
	jmp	@@27
@@2:	mov	byte ptr iscode, L_LIT
	inc	di
	push	ax
	mov	bx, offset internal
	mov	cx, 9
	call	inset
	pop	ax
	jne	@@3
	mov	ax, offset badchmsg
	jmp	fatal
@@3:	mov	bx, offset casemap
	xlat
	cmp	al, '"'
	jne	@@4
	xor	dl, 0FFh
	jmp	short @@1
@@4:	test	word ptr opts, O_R
	je	@@6
	cmp	al, '\'
	jne	@@6
	mov	al, byte ptr [di]
	or	al, al
	je	@@5
	mov	dh, al
	inc	di
	jmp	@@25
@@5:	mov	ax, offset bslashmsg
	jmp	fatal
@@6:	mov	dh, al
	or	dl, dl
	jne	@@7
	mov	bx, offset blanks
	mov	cx, 2
	call	inset
	jne	@@7
	jmp	@@27
@@7:	test	word ptr opts, O_R
	jne	@@8
	jmp	@@25
@@8:	or	bp, bp
	je	@@9
	jmp	@@17
@@9:	cmp	dh, '['
	jne	@@10
	not	bp
	mov	dh, P_SET
	mov	byte ptr iscode, L_CODE
	jmp	@@25
@@10:	cmp	dh, ']'
	jne	@@11
	mov	ax, offset lbrkmsg
	jmp	fatal
@@11:	cmp	dh, '.'
	jne	@@12
	mov	dh, P_ANY
	mov	byte ptr iscode, L_CODE
	jmp	@@25
@@12:	cmp	dh, '*'
	jne	@@13
	mov	dh, P_STAR
	mov	byte ptr iscode, L_CODE
	jmp	@@25
@@13:	cmp	dh, '+'
	jne	@@14
	mov	dh, P_PLUS
	mov	byte ptr iscode, L_CODE
	jmp	@@25
@@14:	cmp	dh, '^'
	jne	@@15
	mov	dh, P_BOL
	mov	byte ptr iscode, L_CODE
	jmp	@@25
@@15:	cmp	dh, '$'
	je	@@16
	jmp	@@25
@@16:	mov	dh, P_EOL
	mov	byte ptr iscode, L_CODE
	jmp	short @@25
@@17:	cmp	dh, ']'
	jne	@@20
	cmp	byte ptr [si+patlit-1], L_LIT
	je	@@18
	mov	al, byte ptr [si+pattern-1]
	cmp	al, P_SET
	je	@@19
	cmp	al, P_NOT
	je	@@19
@@18:	not	bp
	mov	dh, P_ENDSET
	mov	byte ptr iscode, L_CODE
	jmp	short @@25
@@19:	mov	ax, offset nullmsg
	jmp	fatal
@@20:	cmp	dh, '['
	jne	@@21
	mov	ax, offset rbrkmsg
	jmp	fatal
@@21:	cmp	byte ptr [si+patlit-1], L_LIT
	je	@@22
	cmp	byte ptr [si+pattern-1], P_SET
	jne	@@22
	cmp	dh, '^'
	jne	@@22
	mov	dh, P_NOT
	mov	byte ptr iscode, L_CODE
	jmp	short @@25
@@22:	cmp	dh, '-'
	jne	@@25
	cmp	byte ptr [si+patlit-1], L_LIT
	jne	@@23
	cmp	byte ptr [si+pattern-1], P_SET
	jne	@@24
@@23:	mov	ax, offset rangemsg
	jmp	fatal
@@24:	mov	al, byte ptr [di]
	cmp	al, '-'
	je	@@23
	cmp	al, ']'
	je	@@23
	mov	dh, P_RANGE
	mov	byte ptr iscode, L_CODE
@@25:	cmp	si, 3Fh
	jb	@@26
	mov	ax, offset patmsg
	jmp	fatal
@@26:	mov	byte ptr [si+pattern], dh
	mov	al, byte ptr iscode
	mov	byte ptr [si+patlit], al
	inc	si
	jmp	@@1
@@27:	or	dl, dl
	je	@@28
	mov	ax, offset quotemsg
	jmp	fatal
@@28:	or	bp, bp
	je	@@29
	mov	ax, offset rbrkmsg
	jmp	fatal
@@29:	mov	word ptr argp, di
	call	compile
	ret

; splitname: splits path into its directory (left in path) and file name (fname)
splitname:	mov	si, offset path
	mov	bx, si
@@1:	lodsb
	or	al, al
	je	@@2
	call	issep
	jne	@@1
	mov	bx, si
	jmp	short @@1
@@2:	mov	si, bx
	mov	di, offset fname
	mov	cx, 8
@@3:	lodsb
	or	al, al
	je	@@7
	cmp	al, '.'
	je	@@5
	stosb
	loop	@@3
@@4:	lodsb
	or	al, al
	je	@@7
	cmp	al, '.'
	jne	@@4
@@5:	stosb
	mov	cx, 3
@@6:	lodsb
	or	al, al
	je	@@7
	stosb
	loop	@@6
@@7:	mov	al, 0
	stosb
	mov	byte ptr [bx], al
	cmp	byte ptr fname, 0
	jne	@@8
	mov	si, offset allfiles
	mov	di, offset fname
	call	strcpy
@@8:	ret

; nextspec: takes the next file spec from the command line; a directory
; stands for every file in it. ZF set when there are no more
nextspec:	push	bp
	mov	bp, sp
	sub	sp, 43h
	mov	di, word ptr argp
	call	skipblank
	xor	si, si
	mov	al, 0
	mov	byte ptr dta+1Eh, al
	mov	byte ptr fname, al
@@1:	mov	al, byte ptr [di]
	or	al, al
	je	@@4
	inc	di
	cmp	al, 'a'
	jb	@@2
	cmp	al, 'z'
	ja	@@2
	and	al, 0DFh
@@2:	mov	bx, offset blanks
	mov	cx, 2
	mov	dl, al
	call	inset
	je	@@4
	cmp	si, 4Fh
	jb	@@3
	mov	ax, offset specmsg
	jmp	fatal
@@3:	mov	byte ptr [si+path], dl
	inc	si
	jmp	short @@1
@@4:	mov	byte ptr [si+path], 0
	mov	word ptr argp, di
	cmp	byte ptr path, 0
	je	@@5
	mov	byte ptr nospec, 0
	call	splitname
	jmp	short @@6
@@5:	cmp	byte ptr nospec, 0
	je	@@8
	call	stdintty
	jne	@@8
	mov	ax, offset nofilemsg
	jmp	fatal
@@6:	mov	ax, word ptr path
	cmp	ah, ':'
	je	@@7
	mov	ah, 19h
	int	21h
	add	al, 'A'
	mov	ah, 3Ah
@@7:	mov	word ptr [bp-43h], ax
	mov	byte ptr [bp-41h], 5Ch
	lea	si, [bp-40h]
	mov	dl, al
	sub	dl, 40h
	mov	ah, 47h
	int	21h
	mov	ah, 3Bh
	mov	dx, offset fullname
	mov	di, dx
	mov	si, offset path
	call	strcpy
	mov	si, offset fname
	call	strcpy
	int	21h
	jb	@@8
	mov	ah, 3Bh
	lea	dx, [bp-43h]
	int	21h
	mov	di, offset path
	call	strlen
	add	di, ax
	mov	si, offset fname
	call	strcpy
	mov	word ptr [di], 5Ch
	mov	di, offset fname
	mov	si, offset allfiles
	call	strcpy
@@8:	cmp	byte ptr fname, 0
	mov	sp, bp
	pop	bp
	ret

; chmatch: ZF set when character AL matches pattern element BX (code AH)
chmatch:	mov	bp, bx
	mov	bx, offset casemap
	xlat
	mov	bx, bp
	cmp	byte ptr [bx+patlit], L_SET
	jne	@@1
	push	cx
	mov	cl, ah
	dec	cl
	mov	ch, 0
	mov	si, cx
	mov	cl, 5
	shl	si, cl
	add	si, offset buffer
	pop	cx
	call	testbit
	jmp	short @@5
@@1:	cmp	byte ptr [bx+patlit], L_CODE
	jne	@@4
	cmp	al, 10
	jne	@@2
	cmp	ah, P_BOL
	jmp	short @@5
@@2:	cmp	al, 13
	jne	@@3
	cmp	ah, P_EOL
	jmp	short @@5
@@3:	cmp	ah, P_ANY
	je	@@5
@@4:	cmp	ah, al
@@5:	ret

; stackchk: stops with a message when the recursion has used the stack
stackchk:	cmp	sp, offset stkbot
	jae	@@1
	mov	ax, offset stackmsg
	jmp	fatal
@@1:	ret

; matchleft: matches the pattern leftwards from element BX at DI
matchleft:	call	stackchk
@@1:	or	bx, bx
	je	@@7
	dec	bx
	dec	di
	mov	ah, byte ptr [bx+pattern]
	mov	al, byte ptr [di]
	cmp	byte ptr [bx+patlit], L_LIT
	je	@@6
	cmp	byte ptr [bx+patlit], L_SET
	je	@@6
	cmp	ah, P_STAR
	jne	@@5
	dec	bx
	mov	ah, byte ptr [bx+pattern]
@@2:	push	ax
	push	bx
	push	di
	inc	di
	call	matchleft
	jne	@@3
	pop	ax
	pop	ax
	pop	ax
	jmp	short @@8
@@3:	pop	di
	pop	bx
	pop	ax
	call	chmatch
	jne	@@8
@@4:	dec	di
	mov	al, byte ptr [di]
	jmp	short @@2
@@5:	cmp	ah, P_PLUS
	jne	@@6
	dec	bx
	mov	ah, byte ptr [bx+pattern]
	call	chmatch
	je	@@4
	jmp	short @@7
@@6:	call	chmatch
	je	@@1
@@7:	jne	@@8
	test	word ptr opts, O_W
	je	@@8
	mov	al, byte ptr [di-1]
	mov	si, offset wordset
	call	testbit
@@8:	ret

; matchright: matches the pattern rightwards from element BX at DI
matchright:	call	stackchk
@@1:	mov	ah, byte ptr [bx+pattern+1]
	or	ah, ah
	je	@@7
	cmp	byte ptr [bx+patlit+1], L_CODE
	jne	@@2
	cmp	ah, P_PLUS
	jne	@@2
	dec	bx
	dec	di
	jmp	short @@1
@@2:	inc	bx
	inc	di
	mov	al, byte ptr [di]
	cmp	byte ptr [bx+patlit+1], L_CODE
	jne	@@6
	cmp	byte ptr [bx+pattern+1], P_STAR
	je	@@4
	cmp	byte ptr [bx+pattern+1], P_PLUS
	jne	@@6
@@3:	call	chmatch
	jne	@@8
	inc	di
	mov	al, byte ptr [di]
@@4:	push	ax
	push	bx
	push	di
	inc	bx
	dec	di
	call	matchright
	jne	@@5
	pop	ax
	pop	ax
	pop	ax
	jmp	short @@8
@@5:	pop	di
	pop	bx
	pop	ax
	jmp	short @@3
@@6:	call	chmatch
	je	@@1
@@7:	jne	@@8
	test	word ptr opts, O_W
	je	@@8
	mov	al, byte ptr [di+1]
	mov	si, offset wordset
	call	testbit
@@8:	ret

; tryline: tries the pattern around the anchor found at DI
tryline:	dec	di
	cmp	di, word ptr blockstart
	jbe	@@1
	call	nextblock
@@1:	mov	dx, di
	mov	bx, word ptr anchor
	cmp	byte ptr anchorch, 0
	jne	@@2
	dec	di
	dec	bx
@@2:	call	matchright
	jne	@@3
	mov	di, dx
	mov	bx, word ptr anchor
	call	matchleft
	je	@@4
@@3:	inc	dx
@@4:	mov	di, dx
	ret

; scanfast: finds lines through the anchor character with repne scasb
scanfast:	mov	al, byte ptr anchorch
	repne scasb
	jne	@@1
	call	tryline
	jne	scanfast
	call	report
	or	cx, cx
	jne	scanfast
@@1:	cmp	byte ptr lastblock, 0FFh
	je	@@2
	call	nextblock
	jmp	short scanfast
@@2:	ret

; scanall: tries every position, counting lines (for -n, -v and patterns
; without an anchor)
scanall:	jcxz	@@5
	mov	dh, byte ptr anchorch
	mov	dl, byte ptr [di]
	inc	di
	dec	cx
	cmp	dl, 10
	jne	@@1
	test	word ptr opts, O_N or O_Z
	je	@@1
	add	word ptr lineno, 1
	adc	word ptr lineno+2, 0
@@1:	or	dh, dh
	je	@@2
	mov	al, dl
	mov	bx, offset casemap
	xlat
	cmp	al, dh
	jne	@@4
@@2:	push	dx
	call	tryline
	pop	dx
	jne	@@4
	mov	byte ptr matched, 0FFh
@@3:	call	report
	jmp	short scanall
@@4:	cmp	dl, 13
	jne	scanall
	test	word ptr opts, O_V
	je	scanall
	dec	di
	inc	cx
	mov	byte ptr matched, 0
	jmp	short @@3
@@5:	cmp	byte ptr lastblock, 0FFh
	je	@@6
	call	nextblock
	jmp	short scanall
@@6:	ret

; grepfile: searches the open file
grepfile:	call	catch
	jb	@@6
	test	word ptr opts, O_Z
	je	@@1
	call	filehead
@@1:	xor	ax, ax
	mov	word ptr lineno, ax
	mov	word ptr lineno+2, ax
	mov	word ptr nlines, ax
	mov	cx, word ptr buflen
	mov	di, word ptr bufp
	mov	byte ptr [di], 10
	test	word ptr opts, O_N or O_V or O_Z
	jne	@@3
	mov	al, byte ptr anchorch
	cmp	al, 0
	je	@@3
	test	word ptr opts, O_I
	je	@@2
	cmp	al, 'A'
	jb	@@2
	cmp	al, 'Z'
	jbe	@@3
@@2:	call	scanfast
	jmp	short @@4
@@3:	call	scanall
@@4:	mov	ax, word ptr nlines
	or	ax, ax
	jne	@@5
	test	word ptr opts, O_Z
	je	@@6
@@5:	push	ax
	call	filehead
	pop	ax
	xor	dx, dx
	call	putnum
	mov	ax, offset countmsg
	call	puts
@@6:	ret

; init: the entry point
init:	mov	sp, offset stktop
	cld
	mov	ax, cs
	neg	ax
	add	ax, word ptr ds:[2]	; the PSP: the top of memory
	cmp	ax, 1000h
	jb	@@1
	mov	ax, 0FFFFh
	jmp	short @@2
@@1:	mov	cl, 4
	shl	ax, cl
@@2:	sub	ax, word ptr bufp
	inc	ax
	cmp	ax, 400h
	jae	@@3
	mov	ax, offset memmsg
	jmp	fatal
@@3:	mov	word ptr bufsize, ax
	mov	ax, word ptr cs:defopts
	mov	word ptr opts, ax
	mov	dx, offset dta
	mov	ah, 1Ah
	int	21h
	mov	di, 80h
	mov	bl, byte ptr [di]
	inc	di
	mov	bh, 0
	mov	byte ptr [bx+di], 0
	mov	word ptr argp, di
	call	usage
	call	getopts
	test	word ptr opts, O_U
	jne	update
	test	word ptr opts, O_I
	je	@@5
	mov	di, offset casemap+'a'
	mov	al, 'A'
	mov	cx, 1Ah
@@4:	stosb
	inc	al
	loop	@@4
@@5:	call	getpat
	call	stdintty
	jne	@@7
@@6:	call	nextspec
	je	@@8
@@7:	call	dofiles
	jmp	short @@6
@@8:	mov	ah, 4Ch
	int	21h

; update: -u: writes the options into a copy of GREP.COM
update:	mov	ax, word ptr opts
	and	ax, not O_U
	mov	word ptr defopts, ax
	mov	ah, 30h
	int	21h
	cmp	al, 3
	jb	@@4
	mov	ax, word ptr ds:[2Ch]	; the PSP: the environment
	mov	es, ax
	xor	di, di
	mov	al, 0
	mov	cx, 0FFFFh
@@1:	repne scasb
	cmp	byte ptr es:[di], 0
	jne	@@1
	inc	di
@@2:	mov	bx, word ptr es:[di]
	inc	di
	inc	di
	cmp	bl, 0
	je	@@4
	cmp	bx, 1
	je	@@3
	repne scasb
	jmp	short @@2
@@3:	mov	si, offset progpath
	xchg	si, di
	push	ds
	push	es
	pop	ds
	pop	es
	call	strcpy
	push	ds
	push	es
	pop	ds
	pop	es
@@4:	push	ds
	pop	es
	mov	ax, offset outprompt
	call	puts
	mov	ax, offset progpath
	call	puts
	mov	ax, offset outprompt2
	call	puts
	mov	word ptr kbdbuf, 50h
	mov	dx, offset kbdbuf
	mov	ah, 10
	int	21h
	mov	ax, offset crlf
	call	puts
	mov	bx, offset kbdbuf+1
	mov	cl, byte ptr [bx]
	mov	ch, 0
	jcxz	@@5
	add	bx, cx
	inc	bx
	mov	byte ptr [bx], 0
	mov	dx, offset kbdbuf+2
	jmp	short @@6
@@5:	mov	dx, offset progpath
@@6:	mov	word ptr kbdbuf, dx
	xor	cx, cx
	mov	ah, 3Ch
	int	21h
	mov	word ptr outhandle, ax
	jae	@@7
	mov	ax, offset createmsg
	call	puts
	jmp	short @@4
@@7:	mov	si, offset defname
	mov	di, offset progpath
	call	strcpy
	mov	dx, offset start
	mov	cx, offset progend
	sub	cx, offset start
	mov	bx, word ptr outhandle
	mov	ah, 40h
	int	21h
	jb	@@8
	cmp	ax, cx
	je	@@9
@@8:	mov	ah, 3Eh
	int	21h
	mov	ax, offset writemsg
	jmp	fatal
@@9:	mov	ah, 3Eh
	int	21h
	mov	ah, 4Ch
	int	21h
	add	byte ptr [bx+si], al
	add	byte ptr [bx+si], al
	add	byte ptr [bx+si], al
	add	byte ptr [bx+si], al


; the stack, filled with FFh
stkbot	db	512 dup (0FFh)

; the ID block, as MAKE, TLIB and OBJXREF have one; never read
stktop	db	'$*$*$*', 2, 0, 0, 3, 'GREP', 0

; character translation for xlat: identity, or with -i the small letters
; mapped to capitals (init)
casemap	label	byte
x = 0
	rept	256
	db	x
x = x + 1
	endm

; how common each character is in text: compile() takes the rarest
; literal of the pattern as the anchor that scanfast() looks for
rarity	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 0FCh, 0FDh, 1
	db	98h, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 0FFh, 0A7h, 0C9h, 0B3h
	db	0B7h, 0A0h, 0B6h, 0C7h, 0E7h, 0E6h, 0EEh, 0BBh, 0F0h, 0DDh, 0E1h, 0CFh
	db	0DBh, 0D3h, 0C4h, 0BAh, 0B8h, 0ABh, 0AEh, 0B1h, 0B2h, 0ADh, 0D6h, 0EDh
	db	0A8h, 0EAh, 0C3h, 0B0h, 0A6h, 0D5h, 0C8h, 0DFh, 0CCh, 0E2h, 0C6h, 0BEh
	db	0BDh, 0D2h, 0A9h, 0AAh, 0D8h, 0CEh, 0D0h, 0D7h, 0D1h, 0A3h, 0D4h, 0DEh
	db	0DCh, 0BFh, 0B9h, 0C5h, 0C2h, 0B5h, 0A2h, 0C1h, 0ACh, 0C0h, 0A4h, 0E8h
	db	9Bh, 0F6h, 0E4h, 0F2h, 0F4h, 0FEh, 0F1h, 0E5h, 0E9h, 0F9h, 0BCh, 0CDh
	db	0F3h, 0ECh, 0F7h, 0F8h, 0EFh, 0A5h, 0FAh, 0F5h, 0FBh, 0EBh, 0D9h, 0E0h
	db	0E3h, 0DAh, 0B4h, 0CBh, 0AFh, 0CAh, 9Dh, 1, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 90h, 90h, 9Ch
	db	99h, 91h, 95h, 91h, 91h, 92h, 9Eh, 94h, 94h, 91h, 91h, 93h
	db	97h, 95h, 9Ah, 98h, 0A1h, 91h, 91h, 96h, 94h, 94h, 90h, 90h
	db	92h, 9Fh, 90h, 91h, 91h, 91h, 90h, 91h, 91h, 91h, 91h, 90h
	db	90h, 97h, 93h, 90h, 90h, 90h, 90h, 90h, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	db	1, 1, 1, 1

; the characters of a word for -w: 0-9 A-Z _ a-z, or the set given
; after -w
wordset	db	0, 0, 0, 0, 0, 0, 0FFh, 3, 0FEh, 0FFh, 0FFh, 87h
	db	0FEh, 0FFh, 0FFh, 7, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0

; the codes the pattern uses inside: not allowed in a search string
internal	db	1, 2, 3, 4, 5, 6, 7, 8, 9

; the option letters, in the order of their bits (O_...)
optlets	db	'rlcnvidzwou'

; what separates the arguments
blanks	db	20h, 9
	db	0

; the element of the pattern that is the anchor
anchor	dw	0

; the anchor character, 0 when there is none
anchorch	db	0

; FFh when the line matched
matched	db	0FFh

; FFh when the file's name has been written
headdone	db	0

; FFh when the file has been read to its end
lastblock	db	0

; [ ] sets made
nsets	db	0

; putnum()'s digits, backwards from numend
numbuf	db	6 dup (0)
numend	db	0

; FFh while no file spec has been given
nospec	db	0FFh

; catch()
catchsp	dw	0
catchip	dw	0
errmsg	db	'Error: ', 0
specmsg	db	'File spec too long', 13

; the file name part of the current spec
fname	db	13 dup (0)

; its directory, with \ at the end
path	db	80 dup (0)
openmsg	db	'Unable to open file: '

; path and file name, for DOS
fullname	db	80 dup (0)
patmsg	db	'Search string is too long', 13

; the search string: a character, or with patlit 1 a code (P_...)
pattern	db	64 dup (0)

; per element: 0 a literal, 1 a code, 2 a [ ] set (pattern holds its number)
patlit	db	64 dup (0)

; getpat(): the element is a code
iscode	db	0
longmsg	db	'Line too long (file may be binary) - search aborted', 0
readmsg	db	'Unexpected DOS error reading file', 0
starmsg	db	'Expected character before "*"', 0
plusmsg	db	'Expected character before "+"', 0
misusemsg	db	'Misuse of "*" or "+"', 0
nofilemsg	db	'No file sets specified', 0
stackmsg	db	'*** Stack Overflow ***', 0
memmsg	db	'*** Out Of Memory ***', 0
countmsg	db	' lines match', 13, 0
nomatchmsg	db	'No files matching: ', 0
filemsg	db	'File ', 0
colon	db	3Ah
crlf	db	13, 0
bsallfiles	db	5Ch
allfiles	db	'*.*', 0
stdinmsg	db	'STDIN', 0

; the next character of the command line
argp	dw	0

; the file being searched
handle	dw	0FFFFh

; its line number, a long
lineno	dw	0
	dw	0

; lines found
nlines	dw	0

; the options: O_...
opts	dw	0

; bytes in the buffer
buflen	dw	0

; where the last read started
blockstart	dw	0

; the DTA of the file search (attribute at +15h, name at +1Eh)
dta	db	43 dup (0)

; the buffer: from here to the end of memory
bufp	dw	buffer
bufsize	dw	0

; the text below is needed only before the search, and the buffer
; is laid over it
buffer	db	'Invalid option -'
optch	db	0, 0
lbrkmsg	db	'Missing "["', 0
rbrkmsg	db	'Missing "]"', 0
quotemsg	db	'Missing matching "', 0
bslashmsg	db	'Expected character after "\"', 0
rangemsg	db	'Misuse of "-" in range', 0
nullmsg	db	'Null [] set defined', 0
badchmsg	db	'Invalid character in search string', 0
nopatmsg	db	'No pattern specified', 0
banner	db	'Turbo GREP  Version 3.0  Copyright (c) 1991 Borland International'
	db	13, 'Syntax:  GREP [-rlcnvidzuwo] searchstring file[s]', 13, 0
syntax	db	'         GREP ? for help', 13, 0
help	db	13, 'Options are one or more option characters preceeded by "-", and optionally'
	db	13, 'followed by "+" (turn option on), or "-" (turn it off).  The default is "+".'
	db	13, '   -r   Regular expression search', 9, '-l   File names only'
	db	13, '   -c   match Count only', 9, 9, '-n   Line numbers', 13
	db	'   -v   Non-matching lines only', 9, 9, '-i   Ignore case', 13
	db	'   -d   Search subdirectories', 9, 9, '-z   Verbose', 13, '   -u   Update default options'
	db	9, 9, '-w   Word search', 13, '   -o   UNIX output format', 9
	db	9, '     Default set: [', 0
help2	db	']', 13, 13, 'A regular expression is one or more occurrences of:  One or more characters'
	db	13, 'optionally enclosed in quotes.  The following symbols are treated specially:'
	db	13, '   ^  start of line', 9, 9, '$  end of line', 13, '   .  any character'
	db	9, 9, '\  quote next character', 13, '   *  match zero or more'
	db	9, '+  match one or more', 13, 13, '   [aeiou0-9]', 9, 'match a, e, i, o, u, and 0 thru 9'
	db	13, '   [^aeiou0-9]', 9, 'match anything but a, e, i, o, u, and 0 thru 9'
	db	13, 0

; where usage() writes + or - after each option letter
helpopts	dw	help+9Eh, help+0BDh, help+0D5h, help+0ECh, help+101h, help+11Fh
	dw	help+133h, help+14Fh, help+15Fh, help+17Ch, help+190h
outprompt	db	'Enter output name for new program file [', 0
outprompt2	db	']: ', 0
createmsg	db	'DOS error trying to create new program file', 13, 0
writemsg	db	'DOS error trying to write to new program file', 13, 0
outhandle	dw	0

; DOS function 0Ah: the size, the length, the text
kbdbuf	db	0
	db	0
	db	80 dup (0)
defname	db	'GREP.COM', 0

; -u: the path of GREP.COM, from the environment (DOS 3 and later)
progpath	db	80 dup (?)
progend	label	byte

code	ends
	end	start
