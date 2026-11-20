; TLINK.ASM: the core of Turbo Link 4.0 (Borland C++ 2.0's TLINK.EXE), 0000h..BF90h of
; the image: everything but the C++ name demangler (UNMANGLE.C), the run-time routines and
; the far-memory heap (heap/).  Hand-written 286 assembler.
;
; Recovered from TLINK.EXE: TASM 2.51 assembles this file to the original bytes (tools/
; asmcheck.py checks it line by line, tools/build.py links the whole program).  It began as
; a generated draft; labels still named Lnnnnn are the address of the line, and ;@nnnnn
; gives each line's address in the image.  Named routines have a comment above them.
;
; Data: DS is TLINK's tables (TLBSS, 7AC0h bytes, see DATA_SEGMENT), set up by STARTUP and
; cleared by CLEAR_TABLES; TLDATA holds the messages (MESSAGE_TEXT) and constant tables.
; Names, segments, modules and the like live in the far heap (POOL_INIT and friends) and are
; reached through handles.
;
; The flow: start -> STARTUP, CHECK_MEMORY, CLEAR_TABLES, RUN (banner, GET_OPTIONS,
; INIT_MEMORY, LINK), CLOSE_FILES, SHUTDOWN, exit with the code in [10h].  LINK reads every
; object module twice: pass 1 (PASS1_RECORDS) collects names, segments and groups, the
; layout is fixed, pass 2 (PASS2_RECORDS) writes the data with its fixups applied
; (FIXUP_LOCATIONS).  Records are read in the dispatcher at 059CAh; COMENT records go on
; to the class tables (PASS1_COMENT_CLASSES, PASS2_COMENT_CLASSES).  A Windows or OS/2
; link reads a module definition file (.DEF) with the lexer at 0A85Ah (DEF_CHAR_CLASSES,
; DEF_CLASS_HANDLERS) and the section table DEF_SECTIONS.
;
; Output (the map file, and the console for the banner and messages) goes through a 2000h
; byte buffer at 5540h: PUT_CHAR, PUT_INLINE (the counted string after the call), PUT_HEX_*,
; PUT_DECIMAL, PUT_SYMBOL_NAME (C++ names demangled), FLUSH_OUTPUT.  Messages go through
; FATAL, ERROR and WARNING with a message number and arguments.

	.286
	locals
	extrn	UNMANGLE:far
	extrn	F_LXMUL@:far
	extrn	STRING_LENGTH:far
	extrn	STRING_COPY:far
	extrn	STRING_APPEND:far
	extrn	GATHER_ALL_FREE_SPACE:far
	extrn	POOL_INIT:far
	extrn	FREE_HANDLE_BLOCK:far
	extrn	SET_NODE_INFO:far
	extrn	HANDLE_IN_BANK_5:far
	extrn	INIT_HEAP:far
	extrn	SHUTDOWN_HEAP_BANKS:far
	extrn	HEAP_SPACE_BELOW_LIMIT:far
	extrn	INIT_EMS_BANK:far
	extrn	INIT_EXT_BANK:far
	extrn	RESIZE_POOL_BLOCK:far
	extrn	HEAP_MODE_SET_BIT13:far
	extrn	HEAP_MODE_SET_BITS56:far
	extrn	D1019_START:byte
	extrn	B117E_START:byte

DGROUP	group	_DATA
_DATA	segment para public 'DATA'
_DATA	ends

CODE0	segment byte public 'CODE'
	assume	cs:CODE0
L00000	db	24h, 2Ah, 24h, 2Ah, 24h, 2Ah, 0, 2Eh, 5, 3, 54h, 4Ch, 49h, 4Eh, 4Bh, 0	;@00000
DATA_SEGMENT	dw	seg B117E_START	; TLINK's tables (TLBSS), loaded into DS
; SET_DEFAULTS: the option flags' defaults (exit code 0, EMS and extended memory on, ...).
SET_DEFAULTS:	mov	byte ptr ds:[10h], 0	;@00012
	mov	byte ptr ds:[11h], 1	;@00017
	mov	byte ptr ds:[14h], 0	;@0001C
	mov	byte ptr ds:[15h], 0	;@00021
	mov	word ptr ds:[0Ah], 1	;@00026
	mov	byte ptr ds:[0C32h], 0	;@0002C
	mov	byte ptr ds:[125h], 0	;@00031
	mov	byte ptr ds:[8], 0	;@00036
	mov	byte ptr ds:[9], 1	;@0003B
	xor	ax, ax	;@00040
	mov	word ptr ds:[3472h], ax	;@00042
	mov	word ptr ds:[188h], ax	;@00045
	mov	word ptr ds:[0C49h], ax	;@00048
	mov	word ptr ds:[186h], ax	;@0004B
	mov	byte ptr ds:[16h], 1	;@0004E
	ret	;@00053
; RUN: the banner, the options (GET_OPTIONS), the memory set-up, then the link itself
; (LINK).
RUN:	call	SET_DEFAULTS	;@00054
	mov	word ptr ds:[7641h], 5540h	;@00057
	call CONSOLE_ON	;@0005D
	call PUT_INLINE	;@00060
	db	14h, 'Turbo Link  Version '	;@00063
	call PUT_INLINE	;@00078
	db	3, '4.0'	;@0007B
	call PUT_INLINE	;@0007F
	db	') Copyright (c) 1991 Borland International'	;@00082
	call PUT_NEWLINE	;@000AC
	call CONSOLE_OFF	;@000AF
	call GET_OPTIONS	;@000B2
	cmp	byte ptr ds:[129h], 1	;@000B5
	jne	@@1	;@000BA
	cmp	byte ptr ds:[124h], 0	;@000BC
	je	@@1	;@000C1
	mov	byte ptr ds:[124h], 0	;@000C3
	xor	ax, ax	;@000C8
	push	ax	;@000CA
	mov	ax, 41h	;@000CB
	push	ax	;@000CE
	call WARNING	;@000CF
@@1:	mov	al, byte ptr ds:[124h]	;@000D2
	mov	byte ptr ds:[14h], al	;@000D5
	mov	byte ptr ds:[15h], al	;@000D8
	mov	al, byte ptr ds:[125h]	;@000DB
	cbw	;@000DE
	shl	ax, 1	;@000DF
	mov	word ptr ds:[18h], ax	;@000E1
	shl	ax, 1	;@000E4
	mov	word ptr ds:[1Ah], ax	;@000E6
	cmp	byte ptr ds:[128h], 0	;@000E9
	jne	@@2	;@000EE
	mov	byte ptr ds:[128h], 1	;@000F0
@@2:	xor	ax, ax	;@000F5
	cmp	byte ptr ds:[128h], 1	;@000F7
	je	@@3	;@000FC
	inc	ax	;@000FE
@@3:	mov	byte ptr ds:[17h], al	;@000FF
	call L09496	;@00102
	call	INIT_MEMORY	;@00105
	call L0BC1F	;@00108
	cmp	byte ptr ds:[129h], 0	;@0010B
	jne	@@4	;@00110
	mov	byte ptr ds:[129h], 2	;@00112
@@4:	xor	ax, ax	;@00117
	cmp	byte ptr ds:[128h], 2	;@00119
	jb	@@5	;@0011E
	inc	ax	;@00120
@@5:	mov	byte ptr ds:[17h], al	;@00121
	cmp	byte ptr ds:[17h], 1	;@00124
	je	@@6	;@00129
	mov	byte ptr ds:[126h], 0	;@0012B
@@6:	call LINK	;@00130
	ret	;@00133
; SHUTDOWN: give back the EMS and extended memory the heap took.
SHUTDOWN:	cmp	word ptr ds:[1Ch], 1	;@00134
	jne	@@1	;@00139
	call	far ptr SHUTDOWN_HEAP_BANKS	;@0013B
@@1:	ret	;@00140
; MSG_NO_MEMORY: printed with int 21h/09h when DOS cannot give TLINK its 31K of tables.
MSG_NO_MEMORY	db	'Not enough memory', 0Dh, 0Ah, 24h	;@00141
; CTRL_BREAK_HANDLER (int 23h): close and delete the output file when it was being
; written, give back EMS and extended memory, then let DOS end the program.
CTRL_BREAK_HANDLER:	push	ax	;@00155
	push	bx	;@00156
	push	dx	;@00157
	push	ds	;@00158
	mov	ds, word ptr cs:DATA_SEGMENT	;@00159
	cmp	byte ptr ds:[11Ch], 0FFh	;@0015E
	jne	@@1	;@00163
	mov	bx, word ptr ds:[22h]	;@00165
	call	CLOSE_FILE	;@00169
	mov	word ptr ds:[22h], 0FFFFh	;@0016C
	call	L09353	;@00172
	call	SHUTDOWN	;@00175
@@1:	pop	ds	;@00178
	pop	dx	;@00179
	pop	bx	;@0017A
	pop	ax	;@0017B
	stc	;@0017C
	retf	;@0017D
; INIT_MEMORY: start the far-memory heap (INIT_HEAP, with OUT_OF_MEMORY as its hook) on
; all memory above TLINK's tables, then extended memory (/ye) and EMS (/yx) unless off.
INIT_MEMORY:	mov	ax, word ptr ds:[0Ch]	;@0017E
	add	ax, 0Fh	;@00181
	mov	cl, 4	;@00184
	shr	ax, cl	;@00186
	sub	word ptr ds:[6], ax	;@00188
	mov	bx, ds	;@0018C
	add	ax, bx	;@0018E
	push	ax	;@00190
	mov	ax, word ptr ds:[4]	;@00191
	dec	ax	;@00194
	push	ax	;@00195
	mov	ax, 80h	;@00196
	push	ax	;@00199
	push	cs	;@0019A
	mov	ax, offset OUT_OF_MEMORY	;@0019B
	push	ax	;@0019E
	xor	ax, ax	;@0019F
	push	ax	;@001A1
	push	ax	;@001A2
	call	far ptr INIT_HEAP	;@001A3
	and	ax, ax	;@001A8
	je	@@1	;@001AA
	jmp OUT_OF_MEMORY	;@001AC
@@1:	cmp	byte ptr ds:[8], 1	;@001AF
	jne	@@2	;@001B4
	push	ax	;@001B6
	push	ax	;@001B7
	push	ax	;@001B8
	push	ax	;@001B9
	call	far ptr INIT_EXT_BANK	;@001BA
@@2:	cmp	byte ptr ds:[9], 1	;@001BF
	jne	@@3	;@001C4
	push	ax	;@001C6
	push	ax	;@001C7
	push	ax	;@001C8
	call	far ptr INIT_EMS_BANK	;@001C9
@@3:	mov	word ptr ds:[1Ch], 1	;@001CE
	ret	;@001D4
; UNUSED_FATAL_19: nothing calls this (fatal message 19h).
UNUSED_FATAL_19:	xor	ax, ax	;@001D5
	push	ax	;@001D7
	mov	ax, 19h	;@001D8
	push	ax	;@001DB
	call	FATAL	;@001DC
; STARTUP: keep the environment segment (DGROUP:0) and the PSP, set DS to TLINK's
; tables, install CTRL_BREAK_HANDLER.
STARTUP:	mov	ax, DGROUP	;@001DF
	mov	ds, ax	;@001E2
	mov	ax, word ptr es:[2Ch]	;@001E4
	mov	word ptr ds:[0], ax	;@001E8
	mov	ax, seg B117E_START	;@001EB
	mov	ds, ax	;@001EE
	xor	ax, ax	;@001F0
	mov	byte ptr ds:[11Ch], al	;@001F2
	mov	word ptr ds:[1Ch], ax	;@001F5
	dec	ax	;@001F8
	mov	word ptr ds:[132h], ax	;@001F9
	mov	word ptr ds:[134h], ax	;@001FC
	push	ds	;@001FF
	push	cs	;@00200
	pop	ds	;@00201
	mov	dx, offset CTRL_BREAK_HANDLER	;@00202
	mov	ax, 2523h	;@00205
	int	21h	;@00208
	pop	ds	;@0020A
	mov	word ptr ds:[0], es	;@0020B
	mov	word ptr ds:[2], 80h	;@0020F
	mov	bx, word ptr es:[2]	;@00215
	ret	;@0021A
; CHECK_MEMORY: room for the 7AC0h bytes of tables above DS, else MSG_NO_MEMORY and exit 2;
; the rest of DOS's block is the heap's.
CHECK_MEMORY:	mov	word ptr ds:[0Ch], 7AC0h	;@0021B
	mov	ax, ds	;@00221
	mov	dx, 7AC0h	;@00223
	add	dx, 0Fh	;@00226
	mov	cl, 4	;@00229
	shr	dx, cl	;@0022B
	add	ax, dx	;@0022D
	cmp	bx, ax	;@0022F
	ja	@@1	;@00231
	push	cs	;@00233
	pop	ds	;@00234
	mov	dx, offset MSG_NO_MEMORY	;@00235
	mov	ah, 9	;@00238
	int	21h	;@0023A
	mov	ax, 4C02h	;@0023C
	int	21h	;@0023F
@@1:	mov	word ptr ds:[4], bx	;@00241
	sub	bx, ax	;@00245
	mov	word ptr ds:[6], bx	;@00247
	cmp	bx, 1000h	;@0024B
	jb	@@2	;@0024F
	mov	bx, 0FFF0h	;@00251
@@2:	shl	bx, cl	;@00254
	mov	word ptr ds:[0Eh], bx	;@00256
	ret	;@0025A
; CLEAR_TABLES: fill the tables with FFFFh ("none") and a few with 0.
CLEAR_TABLES:	push	ds	;@0025B
	pop	es	;@0025C
	mov	ax, 0FFFFh	;@0025D
	mov	di, 1Ch	;@00260
	mov	cx, 146h	;@00263
	sub	cx, di	;@00266
	shr	cx, 1	;@00268
	rep stosw	;@0026A
	mov	di, 146h	;@0026C
	mov	cx, 0C4Ch	;@0026F
	sub	cx, di	;@00272
	shr	cx, 1	;@00274
	rep stosw	;@00276
	mov	di, 344Eh	;@00278
	mov	cx, 7AC0h	;@0027B
	sub	cx, di	;@0027E
	shr	cx, 1	;@00280
	rep stosw	;@00282
	xor	ax, ax	;@00284
	mov	di, 290h	;@00286
	mov	cx, 3A8h	;@00289
	sub	cx, di	;@0028C
	shr	cx, 1	;@0028E
	rep stosw	;@00290
	ret	;@00292
; CLOSE_FILES: close the map file and the output file.
CLOSE_FILES:	mov	bx, word ptr ds:[20h]	;@00293
	call CLOSE_FILE	;@00297
	mov	bx, word ptr ds:[22h]	;@0029A
	call CLOSE_FILE	;@0029E
	ret	;@002A1
start:	cld	;@002A2
	call	STARTUP	;@002A3
	call	CHECK_MEMORY	;@002A6
	call	CLEAR_TABLES	;@002A9
	call	RUN	;@002AC
	call	CLOSE_FILES	;@002AF
	call	SHUTDOWN	;@002B2
	mov	al, byte ptr ds:[10h]	;@002B5
	mov	ah, 4Ch	;@002B8
	int	21h	;@002BA
; STR_LIB: the default extension of a library.
STR_LIB	db	'.lib'	;@002BC
; OUT_OF_MEMORY: the heap's hook: report what TLINK holds (DATA_OVERFLOW) and stop with
; fatal message 3.
OUT_OF_MEMORY:	mov	ds, word ptr cs:DATA_SEGMENT	;@002C0
	call DATA_OVERFLOW	;@002C5
	xor	ax, ax	;@002C8
	push	ax	;@002CA
	mov	ax, 3	;@002CB
	push	ax	;@002CE
	call FATAL	;@002CF
; DOS_CALL: int 21h; on an error, fatal message 4 (DOS error) with the code.
DOS_CALL:	push	bx	;@002D2
	int	21h	;@002D3
	pop	bx	;@002D5
	cld	;@002D6
	jb	@@1	;@002D7
	ret	;@002D9
@@1:	push	ax	;@002DA
	mov	cx, 2	;@002DB
	push	cx	;@002DE
	mov	ax, 4	;@002DF
	push	ax	;@002E2
	call FATAL	;@002E3
; CLOSE_FILE: close handle BX unless it is 0 or FFFFh.
CLOSE_FILE:	or	bx, bx	;@002E6
	je	@@1	;@002E8
	cmp	bx, -1	;@002EA
	je	@@1	;@002ED
	mov	ah, 3Eh	;@002EF
	call	DOS_CALL	;@002F1
@@1:	ret	;@002F4
; DOS_CALL_FULL: as DOS_CALL; a write (AH=40h) must write all CX bytes (else fatal 2,
; disk full).
DOS_CALL_FULL:	cmp	ah, 40h	;@002F5
	jne	DOS_CALL	;@002F8
	call	DOS_CALL	;@002FA
	cmp	ax, cx	;@002FD
	je	@@1	;@002FF
	xor	cx, cx	;@00301
	push	cx	;@00303
	mov	ax, 2	;@00304
	push	ax	;@00307
	call FATAL	;@00308
@@1:	ret	;@0030B
; OPEN_FILE: int 21h open/create; when DOS is out of handles (error 4), close a cached
; input file (CLOSE_CACHED_FILE) and try again; other errors are fatal 1 (can't open).
OPEN_FILE:	push	ax	;@0030C
	push	cx	;@0030D
	push	dx	;@0030E
	int	21h	;@0030F
	pop	dx	;@00311
	pop	cx	;@00312
	pop	bx	;@00313
	cld	;@00314
	jb	@@1	;@00315
	ret	;@00317
@@1:	cmp	ax, 4	;@00318
	jne	@@2	;@0031B
	push	bx	;@0031D
	push	cx	;@0031E
	push	ds	;@0031F
	mov	ds, word ptr cs:DATA_SEGMENT	;@00320
	call CLOSE_CACHED_FILE	;@00325
	pop	ds	;@00328
	pop	cx	;@00329
	pop	ax	;@0032A
	jae	OPEN_FILE	;@0032B
@@2:	push	ds	;@0032D
	push	dx	;@0032E
	mov	ax, 4	;@0032F
	push	ax	;@00332
	mov	ax, 1	;@00333
	push	ax	;@00336
	call FATAL	;@00337
; FILE_SIZE: the size of file DS:DX (find first) in DX:AX.
FILE_SIZE:	push	bx	;@0033A
	push	cx	;@0033B
	mov	ah, 4Eh	;@0033C
	xor	cx, cx	;@0033E
	int	21h	;@00340
	jb	@@2	;@00342
	mov	ah, 2Fh	;@00344
	int	21h	;@00346
	mov	ax, word ptr es:[bx+1Ah]	;@00348
	mov	dx, word ptr es:[bx+1Ch]	;@0034C
@@1:	pop	cx	;@00350
	pop	bx	;@00351
	ret	;@00352
@@2:	xor	ax, ax	;@00353
	cwd	;@00355
	jmp	@@1	;@00356
	db	8 dup (0)	;@00358
L00360:	cmp	byte ptr ds:[11Ah], 0FFh	;@00360
	je	@@1	;@00365
	mov	al, 0FFh	;@00367
	xchg	byte ptr ds:[11Ah], al	;@00369
	mov	ah, al	;@0036D
	ret	;@0036F
@@1:	push	dx	;@00370
	push	cx	;@00371
	push	bx	;@00372
	mov	al, 2Ch	;@00373
	cmp	byte ptr ds:[116h], 1	;@00375
	je	@@4	;@0037A
	mov	bx, word ptr ds:[1Eh]	;@0037C
	cmp	bx, -1	;@00380
	jne	@@2	;@00383
	mov	es, word ptr ds:[0]	;@00385
	mov	bx, word ptr ds:[2]	;@00389
	mov	cl, byte ptr es:[bx]	;@0038D
	sub	ch, ch	;@00390
	mov	bx, word ptr ds:[150h]	;@00392
	cmp	bx, cx	;@00396
	mov	al, 3Bh	;@00398
	ja	@@4	;@0039A
	mov	al, byte ptr es:[bx+80h]	;@0039C
	inc	word ptr ds:[150h]	;@003A1
	jmp	short @@4	;@003A5
@@2:	mov	ah, 3Fh	;@003A7
	mov	cx, 1	;@003A9
	mov	dx, 118h	;@003AC
	int	21h	;@003AF
	cld	;@003B1
	and	ax, ax	;@003B2
	mov	al, byte ptr ds:[118h]	;@003B4
	jne	@@4	;@003B7
	mov	word ptr ds:[1Eh], 0FFFFh	;@003B9
	call	CLOSE_FILE	;@003BF
	cmp	byte ptr ds:[15Ch], 1	;@003C2
	jne	@@3	;@003C7
	dec	byte ptr ds:[15Ch]	;@003C9
@@3:	mov	al, 20h	;@003CD
@@4:	pop	bx	;@003CF
	pop	cx	;@003D0
	pop	dx	;@003D1
	mov	ah, al	;@003D2
	cmp	al, 41h	;@003D4
	jb	@@5	;@003D6
	cmp	al, 5Ah	;@003D8
	ja	@@5	;@003DA
	add	al, 20h	;@003DC
@@5:	ret	;@003DE
L003DF:	call	L00360	;@003DF
	sub	al, 30h	;@003E2
	cmp	al, 9	;@003E4
	jbe	@@1	;@003E6
	sub	al, 27h	;@003E8
@@1:	ret	;@003EA
L003EB	db	0Ah, 0	;@003EB
L003ED:	xor	bx, bx	;@003ED
	call	L00360	;@003EF
	cmp	al, 30h	;@003F2
	jb	@@5	;@003F4
	cmp	al, 39h	;@003F6
	ja	@@5	;@003F8
@@1:	and	ax, 0Fh	;@003FA
	xchg	ax, bx	;@003FD
	mul	word ptr cs:L003EB	;@003FE
	jb	@@5	;@00403
	add	bx, ax	;@00405
	jb	@@3	;@00407
	call	L00360	;@00409
	cmp	al, 30h	;@0040C
	jb	@@2	;@0040E
	cmp	al, 39h	;@00410
	jbe	@@1	;@00412
@@2:	mov	byte ptr ds:[11Ah], ah	;@00414
	clc	;@00418
	jmp	short @@7	;@00419
@@3:	call	L00360	;@0041B
	cmp	al, 30h	;@0041E
	jb	@@6	;@00420
	cmp	al, 39h	;@00422
	ja	@@6	;@00424
@@4:	mov	byte ptr ds:[11Ah], ah	;@00426
@@5:	stc	;@0042A
	jmp	short @@7	;@0042B
@@6:	cmp	bx, 0	;@0042D
	jne	@@4	;@00430
@@7:	ret	;@00432
L00433:	push	bx	;@00433
@@1:	mov	al, byte ptr ds:[159h]	;@00434
	mov	byte ptr ds:[158h], al	;@00437
	mov	byte ptr ds:[159h], 0FFh	;@0043A
	call	L00360	;@0043F
	cmp	word ptr ds:[154h], 0	;@00442
	jne	@@10	;@00447
	cmp	word ptr ds:[156h], 0	;@00449
	jne	@@8	;@0044E
	cmp	al, byte ptr ds:[15Ah]	;@00450
	jne	@@2	;@00454
	mov	ah, 1	;@00456
	jmp	@@27	;@00458
@@2:	sub	bh, bh	;@0045B
	mov	bl, al	;@0045D
	mov	ah, byte ptr cs:L0090D[bx]	;@0045F
	cmp	ah, 0	;@00464
	jne	@@3	;@00467
	jmp	@@81	;@00469
@@3:	cmp	ah, 2	;@0046C
	jae	@@4	;@0046F
	jmp	@@21	;@00471
@@4:	jbe	@@5	;@00474
	jmp	@@17	;@00476
@@5:	mov	byte ptr ds:[117h], 0	;@00479
	cmp	al, 2Eh	;@0047E
	jne	@@6	;@00480
	jmp	@@19	;@00482
@@6:	cmp	al, 5Ch	;@00485
	jne	@@7	;@00487
	jmp	@@20	;@00489
@@7:	cmp	ah, 2	;@0048C
	pop	bx	;@0048F
	ret	;@00490
@@8:	mov	byte ptr ds:[11Ah], ah	;@00491
	mov	bx, word ptr ds:[156h]	;@00495
	cmp	bh, 0	;@00499
	jne	@@9	;@0049C
	mov	al, bl	;@0049E
	mov	ah, 2	;@004A0
	mov	bh, 1	;@004A2
	mov	word ptr ds:[156h], bx	;@004A4
	jmp	@@7	;@004A8
@@9:	mov	ah, 1	;@004AA
	mov	word ptr ds:[156h], 0	;@004AC
	jmp	@@7	;@004B2
@@10:	mov	bx, word ptr ds:[154h]	;@004B4
	cmp	bh, 0	;@004B8
	je	@@12	;@004BB
	mov	byte ptr ds:[11Bh], 0	;@004BD
	cmp	al, 28h	;@004C2
	jne	@@11	;@004C4
	mov	byte ptr ds:[11Bh], 1	;@004C6
@@11:	mov	byte ptr ds:[11Ah], al	;@004CB
	mov	ah, bh	;@004CE
	mov	bh, 0	;@004D0
	mov	word ptr ds:[154h], bx	;@004D2
@@12:	mov	al, ah	;@004D6
	sub	bh, bh	;@004D8
	mov	bl, al	;@004DA
	mov	ah, byte ptr cs:L0090D[bx]	;@004DC
	cmp	byte ptr ds:[11Bh], 1	;@004E1
	jne	@@13	;@004E6
	mov	ah, 1	;@004E8
	cmp	al, 29h	;@004EA
	je	@@15	;@004EC
	jmp	short @@14	;@004EE
@@13:	cmp	ah, 1	;@004F0
	je	@@15	;@004F3
	cmp	ah, 3	;@004F5
	je	@@15	;@004F8
@@14:	mov	ah, 2	;@004FA
	jmp	@@7	;@004FC
@@15:	cmp	al, 2Bh	;@004FE
	jne	@@16	;@00500
	mov	byte ptr ds:[11Ah], al	;@00502
@@16:	mov	word ptr ds:[154h], 0	;@00505
	jmp	@@7	;@0050B
@@17:	cmp	al, 3Bh	;@0050E
	je	@@18	;@00510
	jmp	@@7	;@00512
@@18:	mov	byte ptr ds:[116h], 1	;@00515
	jmp	@@7	;@0051A
@@19:	mov	byte ptr ds:[119h], 1	;@0051D
	jmp	@@7	;@00522
@@20:	mov	byte ptr ds:[119h], 0	;@00525
	jmp	@@7	;@0052A
@@21:	cmp	al, 2Fh	;@0052D
	je	@@27	;@0052F
	cmp	al, 2Dh	;@00531
	jne	@@22	;@00533
	cmp	byte ptr ds:[158h], 1	;@00535
	je	@@27	;@0053A
	mov	ah, 2	;@0053C
	jmp	@@5	;@0053E
@@22:	mov	byte ptr ds:[159h], 1	;@00541
	cmp	al, 2Bh	;@00546
	je	@@26	;@00548
	cmp	al, 0Ah	;@0054A
	je	@@23	;@0054C
	jmp	@@7	;@0054E
@@23:	cmp	byte ptr ds:[15Ch], 1	;@00551
	jne	@@24	;@00556
	jmp	@@7	;@00558
@@24:	cmp	byte ptr ds:[117h], 1	;@0055B
	jne	@@25	;@00560
	jmp	@@7	;@00562
@@25:	mov	al, 2Ch	;@00565
	mov	ah, 3	;@00567
	jmp	@@7	;@00569
@@26:	mov	byte ptr ds:[117h], 1	;@0056C
	jmp	@@7	;@00571
@@27:	call	L00360	;@00574
	push	ax	;@00577
	mov	byte ptr ds:[117h], 0	;@00578
	cmp	ah, 6Fh	;@0057D
	jne	@@28	;@00580
	jmp	@@92	;@00582
@@28:	cmp	ah, 76h	;@00585
	jne	@@29	;@00588
	jmp	@@82	;@0058A
@@29:	cmp	ah, 79h	;@0058D
	jne	@@30	;@00590
	jmp	@@78	;@00592
@@30:	cmp	ah, 54h	;@00595
	jne	@@31	;@00598
	jmp	@@66	;@0059A
@@31:	cmp	ah, 44h	;@0059D
	jne	@@32	;@005A0
	jmp	@@75	;@005A2
@@32:	cmp	ah, 43h	;@005A5
	jne	@@33	;@005A8
	jmp	@@87	;@005AA
@@33:	cmp	ah, 5Ah	;@005AD
	jne	@@34	;@005B0
	jmp	@@90	;@005B2
@@34:	cmp	ah, 4Ch	;@005B5
	jne	@@35	;@005B8
	jmp	@@98	;@005BA
@@35:	cmp	ah, 50h	;@005BD
	jne	@@36	;@005C0
	jmp	@@101	;@005C2
@@36:	cmp	ah, 41h	;@005C5
	jne	@@37	;@005C8
	jmp	@@105	;@005CA
@@37:	call	L00360	;@005CD
	xor	bh, bh	;@005D0
	mov	bl, al	;@005D2
	cmp	byte ptr cs:L0090D[bx], 2	;@005D4
	je	@@37	;@005DA
	mov	byte ptr ds:[11Ah], al	;@005DC
	pop	cx	;@005DF
	xor	ax, ax	;@005E0
	mov	bx, 1	;@005E2
	cmp	ch, 6Dh	;@005E5
	jne	@@38	;@005E8
	jmp	@@54	;@005EA
@@38:	cmp	ch, 76h	;@005ED
	je	@@49	;@005F0
	cmp	ch, 63h	;@005F2
	je	@@50	;@005F5
	cmp	ch, 69h	;@005F7
	je	@@51	;@005FA
	cmp	ch, 6Ch	;@005FC
	je	@@52	;@005FF
	cmp	ch, 78h	;@00601
	je	@@53	;@00604
	cmp	ch, 73h	;@00606
	jne	@@39	;@00609
	jmp	@@55	;@0060B
@@39:	cmp	ch, 64h	;@0060E
	jne	@@40	;@00611
	jmp	@@56	;@00613
@@40:	cmp	ch, 62h	;@00616
	jne	@@41	;@00619
	jmp	@@57	;@0061B
@@41:	cmp	ch, 33h	;@0061E
	jne	@@42	;@00621
	jmp	@@58	;@00623
@@42:	cmp	ch, 65h	;@00626
	jne	@@43	;@00629
	jmp	@@59	;@0062B
@@43:	cmp	ch, 6Eh	;@0062E
	je	@@48	;@00631
	cmp	ch, 74h	;@00633
	jne	@@44	;@00636
	jmp	@@72	;@00638
@@44:	cmp	ch, 68h	;@0063B
	jne	@@45	;@0063E
	jmp	@@107	;@00640
@@45:	cmp	ch, 48h	;@00643
	jne	@@46	;@00646
	jmp	@@107	;@00648
@@46:	cmp	ch, 3Fh	;@0064B
	jne	@@47	;@0064E
	jmp	@@107	;@00650
@@47:	jmp	@@80	;@00653
@@48:	mov	byte ptr ds:[123h], bl	;@00656
	jmp	@@1	;@0065A
@@49:	mov	byte ptr ds:[124h], 1	;@0065D
	jmp	@@1	;@00662
@@50:	mov	byte ptr ds:[120h], bl	;@00665
	jmp	@@1	;@00669
@@51:	mov	byte ptr ds:[121h], bl	;@0066C
	jmp	@@1	;@00670
@@52:	mov	byte ptr ds:[11Fh], bl	;@00673
	jmp	@@1	;@00677
@@53:	mov	byte ptr ds:[11h], al	;@0067A
	mov	byte ptr ds:[11Fh], al	;@0067D
	mov	byte ptr ds:[12h], al	;@00680
	mov	byte ptr ds:[13h], al	;@00683
	jmp	@@1	;@00686
@@54:	mov	byte ptr ds:[11h], bl	;@00689
	mov	byte ptr ds:[12h], bl	;@0068D
	jmp	@@1	;@00691
@@55:	mov	byte ptr ds:[11h], bl	;@00694
	mov	byte ptr ds:[12h], bl	;@00698
	mov	byte ptr ds:[13h], bl	;@0069C
	jmp	@@1	;@006A0
@@56:	mov	byte ptr ds:[122h], bl	;@006A3
	jmp	@@1	;@006A7
@@57:	mov	word ptr ds:[0Ah], ax	;@006AA
	jmp	@@1	;@006AD
@@58:	mov	byte ptr ds:[125h], bl	;@006B0
	jmp	@@1	;@006B4
@@59:	mov	byte ptr ds:[254h], bl	;@006B7
	jmp	@@1	;@006BB
@@60:	call	L00360	;@006BE
	cmp	al, 2Bh	;@006C1
	je	@@61	;@006C3
	cmp	al, 2Dh	;@006C5
	je	@@62	;@006C7
	mov	byte ptr ds:[11Ah], ah	;@006C9
@@61:	mov	byte ptr ds:[8], 1	;@006CD
	jmp	@@1	;@006D2
@@62:	mov	byte ptr ds:[8], 0	;@006D5
	jmp	@@1	;@006DA
@@63:	call	L00360	;@006DD
	cmp	al, 2Bh	;@006E0
	je	@@64	;@006E2
	cmp	al, 2Dh	;@006E4
	je	@@65	;@006E6
	mov	byte ptr ds:[11Ah], ah	;@006E8
@@64:	mov	byte ptr ds:[9], 1	;@006EC
	jmp	@@1	;@006F1
@@65:	mov	byte ptr ds:[9], 0	;@006F4
	jmp	@@1	;@006F9
@@66:	pop	cx	;@006FC
	mov	bx, 1	;@006FD
	call	L00360	;@00700
	cmp	al, 64h	;@00703
	je	@@67	;@00705
	cmp	al, 77h	;@00707
	je	@@68	;@00709
	cmp	al, 6Fh	;@0070B
	je	@@69	;@0070D
	cmp	al, 70h	;@0070F
	je	@@70	;@00711
	jmp	@@80	;@00713
@@67:	mov	byte ptr ds:[128h], 1	;@00716
	jmp	short @@71	;@0071B
@@68:	mov	byte ptr ds:[128h], 2	;@0071D
	jmp	short @@71	;@00722
@@69:	mov	byte ptr ds:[128h], 3	;@00724
	jmp	short @@71	;@00729
@@70:	mov	byte ptr ds:[128h], 4	;@0072B
@@71:	call	L00360	;@00730
	cmp	al, 63h	;@00733
	je	@@72	;@00735
	cmp	al, 65h	;@00737
	je	@@73	;@00739
	cmp	al, 64h	;@0073B
	je	@@74	;@0073D
	mov	byte ptr ds:[11Ah], ah	;@0073F
	jmp	@@1	;@00743
@@72:	mov	byte ptr ds:[128h], 1	;@00746
	mov	byte ptr ds:[129h], 1	;@0074B
	mov	ax, 6F63h	;@00750
	mov	bl, 6Dh	;@00753
	call L0962A	;@00755
	jmp	@@1	;@00758
@@73:	mov	byte ptr ds:[129h], 2	;@0075B
	jmp	@@1	;@00760
@@74:	mov	byte ptr ds:[129h], 3	;@00763
	mov	ax, 6C64h	;@00768
	mov	bl, 6Ch	;@0076B
	call L0962A	;@0076D
	jmp	@@1	;@00770
@@75:	pop	cx	;@00773
	mov	bx, 1	;@00774
	call	L00360	;@00777
	cmp	al, 2Bh	;@0077A
	je	@@76	;@0077C
	cmp	al, 2Dh	;@0077E
	je	@@77	;@00780
	mov	byte ptr ds:[11Ah], ah	;@00782
@@76:	mov	byte ptr ds:[16h], bl	;@00786
	jmp	@@1	;@0078A
@@77:	mov	byte ptr ds:[16h], bh	;@0078D
	jmp	@@1	;@00791
@@78:	pop	cx	;@00794
	call	L00360	;@00795
	cmp	al, 78h	;@00798
	jne	@@79	;@0079A
	jmp	@@60	;@0079C
@@79:	cmp	al, 65h	;@0079F
	jne	@@80	;@007A1
	jmp	@@63	;@007A3
@@80:	xor	ax, ax	;@007A6
	push	ax	;@007A8
	mov	ax, 1Ah	;@007A9
	push	ax	;@007AC
	call FATAL	;@007AD
@@81:	xor	ax, ax	;@007B0
	push	ax	;@007B2
	mov	ax, 1Bh	;@007B3
	push	ax	;@007B6
	call FATAL	;@007B7
@@82:	call	L00360	;@007BA
	cmp	al, 2Dh	;@007BD
	je	@@84	;@007BF
	cmp	al, 2Bh	;@007C1
	je	@@83	;@007C3
	mov	byte ptr ds:[11Ah], ah	;@007C5
	jmp	@@37	;@007C9
@@83:	mov	bx, 3	;@007CC
	jmp	short @@85	;@007CF
@@84:	mov	bx, 4	;@007D1
@@85:	cmp	byte ptr ds:[15Bh], 1	;@007D4
	je	@@86	;@007D9
	pop	cx	;@007DB
	jmp	@@1	;@007DC
@@86:	mov	word ptr ds:[156h], bx	;@007DF
	pop	cx	;@007E3
	jmp	short @@96	;@007E4
@@87:	pop	cx	;@007E6
	call	L00360	;@007E7
	cmp	al, 2Dh	;@007EA
	je	@@89	;@007EC
	cmp	al, 2Bh	;@007EE
	je	@@88	;@007F0
	mov	byte ptr ds:[11Ah], ah	;@007F2
@@88:	mov	byte ptr ds:[127h], 1	;@007F6
	jmp	@@1	;@007FB
@@89:	mov	byte ptr ds:[127h], 0	;@007FE
	jmp	@@1	;@00803
@@90:	pop	cx	;@00806
	call	L00360	;@00807
	cmp	al, 32h	;@0080A
	je	@@91	;@0080C
	mov	byte ptr ds:[11Ah], ah	;@0080E
	jmp	@@1	;@00812
@@91:	mov	byte ptr ds:[12Dh], 1	;@00815
	jmp	@@1	;@0081A
@@92:	pop	cx	;@0081D
	call	L00360	;@0081E
	cmp	al, 23h	;@00821
	je	@@97	;@00823
	cmp	byte ptr ds:[15Bh], 1	;@00825
	jne	@@93	;@0082A
	cmp	al, 2Dh	;@0082C
	jne	@@94	;@0082E
	mov	bh, 2	;@00830
	jmp	short @@95	;@00832
@@93:	mov	byte ptr ds:[11Ah], ah	;@00834
	jmp	@@1	;@00838
@@94:	or	byte ptr ds:[0C32h], 1	;@0083B
	mov	bh, 1	;@00840
	mov	byte ptr ds:[11Ah], ah	;@00842
@@95:	mov	bl, 1	;@00846
	mov	word ptr ds:[154h], bx	;@00848
@@96:	mov	al, 0FFh	;@0084C
	mov	ah, 2	;@0084E
	dec	byte ptr ds:[153h]	;@00850
	mov	byte ptr ds:[119h], 1	;@00854
	jmp	@@7	;@00859
@@97:	call	L003DF	;@0085C
	mov	cl, 4	;@0085F
	shl	ax, cl	;@00861
	mov	bl, al	;@00863
	call	L003DF	;@00865
	add	al, bl	;@00868
	mov	ah, al	;@0086A
	mov	al, 0CDh	;@0086C
	mov	word ptr ds:[47Ch], ax	;@0086E
	jmp	@@1	;@00871
@@98:	pop	cx	;@00874
	mov	cx, 80h	;@00875
	mov	ax, cx	;@00878
	call L094FA	;@0087A
	mov	word ptr ds:[140h], di	;@0087D
	dec	cx	;@00881
	push	ds	;@00882
	pop	es	;@00883
@@99:	call	L00360	;@00884
	push	ds	;@00887
	pop	es	;@00888
	xor	bx, bx	;@00889
	mov	bl, al	;@0088B
	cmp	byte ptr cs:L0090D[bx], 1	;@0088D
	je	@@100	;@00893
	stosb	;@00895
	loop	@@99	;@00896
@@100:	mov	byte ptr ds:[11Ah], ah	;@00898
	xor	ax, ax	;@0089C
	stosb	;@0089E
	mov	word ptr ds:[0Ch], di	;@0089F
	jmp	@@1	;@008A3
@@101:	pop	cx	;@008A6
	call	L00360	;@008A7
	cmp	al, 2Dh	;@008AA
	je	@@102	;@008AC
	cmp	al, 3Dh	;@008AE
	je	@@103	;@008B0
	mov	byte ptr ds:[11Ah], ah	;@008B2
	mov	byte ptr ds:[126h], 1	;@008B6
	jmp	@@1	;@008BB
@@102:	mov	byte ptr ds:[126h], 0	;@008BE
	jmp	@@1	;@008C3
@@103:	call	L003ED	;@008C6
	jb	@@104	;@008C9
	mov	word ptr ds:[142h], bx	;@008CB
	mov	byte ptr ds:[126h], 1	;@008CF
	jmp	@@1	;@008D4
@@104:	xor	ax, ax	;@008D7
	push	ax	;@008D9
	mov	ax, 2Bh	;@008DA
	push	ax	;@008DD
	call ERROR	;@008DE
	mov	byte ptr ds:[126h], 0	;@008E1
	jmp	@@1	;@008E6
@@105:	pop	cx	;@008E9
	call	L00360	;@008EA
	cmp	al, 3Dh	;@008ED
	jne	@@106	;@008EF
	call	L003ED	;@008F1
	jb	@@106	;@008F4
	mov	word ptr ds:[144h], bx	;@008F6
	jmp	@@1	;@008FA
@@106:	xor	ax, ax	;@008FD
	push	ax	;@008FF
	mov	ax, 2Dh	;@00900
	push	ax	;@00903
	call ERROR	;@00904
	jmp	@@1	;@00907
@@107:	jmp	L00BD0	;@0090A
L0090D	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0	;@0090D
	db	0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 2, 0, 2, 2, 2, 2, 2, 2, 2
	db	0, 1, 3, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0
	db	0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2
	db	2, 0, 'tlink.cfg', 0
L00997:	push	bp	;@00997
	mov	bp, sp	;@00998
	sub	sp, 8Ah	;@0099A
	mov	word ptr [bp-2], bx	;@0099E
	mov	word ptr [bp-4], si	;@009A1
	mov	byte ptr [bp-8], 0	;@009A4
	mov	word ptr [bp-6], di	;@009A8
	mov	byte ptr ds:[153h], 0	;@009AB
	cmp	byte ptr ds:[15Ch], 0FFh	;@009B0
	je	@@1	;@009B5
	jmp	@@4	;@009B7
@@1:	push	cs	;@009BA
	mov	ax, 98Dh	;@009BB
	push	ax	;@009BE
	call L0971B	;@009BF
	jb	@@2	;@009C2
	push	ss	;@009C4
	lea	ax, [bp-8Ah]	;@009C5
	push	ax	;@009C9
	push	cs	;@009CA
	mov	ax, 98Dh	;@009CB
	push	ax	;@009CE
	call	far ptr STRING_COPY	;@009CF
	jmp	short @@3	;@009D4
@@2:	mov	ah, 30h	;@009D6
	int	21h	;@009D8
	cmp	al, 3	;@009DA
	jb	@@4	;@009DC
	call L09686	;@009DE
	jb	@@4	;@009E1
	push	ss	;@009E3
	lea	cx, [bp-8Ah]	;@009E4
	push	cx	;@009E8
	push	ss	;@009E9
	push	cx	;@009EA
	push	dx	;@009EB
	push	ax	;@009EC
	call	far ptr STRING_COPY	;@009ED
	call	far ptr STRING_LENGTH	;@009F2
	push	ss	;@009F7
	pop	es	;@009F8
	lea	di, [bp-8Ah]	;@009F9
	add	di, ax	;@009FD
	mov	cx, ax	;@009FF
	mov	al, 5Ch	;@00A01
	std	;@00A03
	repne scasb	;@00A04
	cld	;@00A06
	jne	@@4	;@00A07
	add	di, 2	;@00A09
	push	ds	;@00A0C
	push	cs	;@00A0D
	pop	ds	;@00A0E
	mov	si, 98Dh	;@00A0F
	mov	cx, 0Ah	;@00A12
	rep movsb	;@00A15
	xor	ax, ax	;@00A17
	stosb	;@00A19
	pop	ds	;@00A1A
	push	ss	;@00A1B
	lea	ax, [bp-8Ah]	;@00A1C
	push	ax	;@00A20
	call L0971B	;@00A21
	jb	@@4	;@00A24
@@3:	mov	byte ptr ds:[15Ch], 1	;@00A26
	push	ds	;@00A2B
	push	ss	;@00A2C
	pop	ds	;@00A2D
	lea	dx, [bp-8Ah]	;@00A2E
	mov	ax, 3D00h	;@00A32
	call	OPEN_FILE	;@00A35
	pop	ds	;@00A38
	mov	word ptr ds:[1Eh], ax	;@00A39
	mov	byte ptr ds:[116h], 0	;@00A3C
	mov	byte ptr ds:[159h], 1	;@00A41
@@4:	mov	byte ptr ds:[119h], 0	;@00A46
@@5:	call	L00433	;@00A4B
	jb	@@5	;@00A4E
	lahf	;@00A50
	je	@@6	;@00A51
	cmp	word ptr [bp-2], 0	;@00A53
	jne	@@6	;@00A57
	jmp	@@16	;@00A59
@@6:	push	ax	;@00A5C
	mov	ax, 64h	;@00A5D
	call L094FA	;@00A60
	pop	ax	;@00A63
	push	ds	;@00A64
	pop	es	;@00A65
	mov	bx, di	;@00A66
	cmp	al, 40h	;@00A68
	je	@@7	;@00A6A
	mov	bx, word ptr [bp-6]	;@00A6C
	mov	word ptr [bx], di	;@00A6F
	mov	word ptr [bp-6], di	;@00A71
	push	ax	;@00A74
	xor	ax, ax	;@00A75
	stosw	;@00A77
	pop	ax	;@00A78
	mov	bx, di	;@00A79
@@7:	sahf	;@00A7B
	je	@@11	;@00A7C
	mov	si, word ptr [bp-2]	;@00A7E
@@8:	cmp	byte ptr [si+2], 0FFh	;@00A81
	jne	@@9	;@00A85
	mov	si, word ptr [si]	;@00A87
	or	si, si	;@00A89
	jne	@@8	;@00A8B
@@9:	inc	si	;@00A8D
	inc	si	;@00A8E
@@10:	lodsb	;@00A8F
	stosb	;@00A90
	cmp	al, 2Eh	;@00A91
	jne	@@10	;@00A93
	cmp	byte ptr [si], 2Eh	;@00A95
	je	@@10	;@00A98
	cmp	byte ptr [si], 5Ch	;@00A9A
	je	@@10	;@00A9D
	mov	word ptr ds:[0Ch], di	;@00A9F
	mov	word ptr [bp-2], 0	;@00AA3
	jmp	short @@14	;@00AA8
@@11:	mov	word ptr [bp-2], 0	;@00AAA
@@12:	stosb	;@00AAF
	push	es	;@00AB0
	call	L00433	;@00AB1
	pop	es	;@00AB4
	je	@@12	;@00AB5
	xor	al, al	;@00AB7
	stosb	;@00AB9
	cmp	byte ptr [bx], 40h	;@00ABA
	jne	@@13	;@00ABD
	cmp	word ptr ds:[1Eh], -1	;@00ABF
	jne	@@13	;@00AC4
	mov	word ptr ds:[0Ch], bx	;@00AC6
	lea	dx, [bx+1]	;@00ACA
	mov	ax, 3D00h	;@00ACD
	call	OPEN_FILE	;@00AD0
	mov	word ptr ds:[1Eh], ax	;@00AD3
	mov	byte ptr ds:[116h], 0	;@00AD6
	mov	al, 1	;@00ADB
	mov	byte ptr ds:[159h], al	;@00ADD
	jmp	@@4	;@00AE0
@@13:	cmp	byte ptr ds:[119h], 1	;@00AE3
	je	@@15	;@00AE8
@@14:	dec	di	;@00AEA
	mov	cx, 4	;@00AEB
	mov	si, word ptr [bp-4]	;@00AEE
	push	ds	;@00AF1
	push	cs	;@00AF2
	pop	ds	;@00AF3
	rep movsb	;@00AF4
	pop	ds	;@00AF6
	xor	al, al	;@00AF7
	stosb	;@00AF9
	mov	byte ptr [bp-8], 1	;@00AFA
@@15:	inc	byte ptr ds:[153h]	;@00AFE
	mov	word ptr ds:[0Ch], di	;@00B02
	cmp	ah, 2	;@00B06
	jae	@@16	;@00B09
	jmp	@@4	;@00B0B
@@16:	mov	bl, byte ptr [bp-8]	;@00B0E
	mov	sp, bp	;@00B11
	pop	bp	;@00B13
	ret	;@00B14
; GET_OPTIONS: the option defaults, then the command line (and response files).
GET_OPTIONS:	mov	di, 11Eh	;@00B15
	mov	cx, 28h	;@00B18
	xor	ax, ax	;@00B1B
	push	ds	;@00B1D
	pop	es	;@00B1E
	rep stosb	;@00B1F
	mov	byte ptr ds:[126h], 1	;@00B21
	mov	word ptr ds:[142h], 2000h	;@00B26
	mov	word ptr ds:[144h], 200h	;@00B2C
	mov	word ptr ds:[132h], 10h	;@00B32
	mov	word ptr ds:[134h], seg L00000	;@00B38
	call L0950F	;@00B3E
	mov	byte ptr ds:[15Ah], al	;@00B41
	xor	ax, ax	;@00B44
	mov	word ptr ds:[154h], ax	;@00B46
	mov	word ptr ds:[156h], ax	;@00B49
	mov	byte ptr ds:[116h], al	;@00B4C
	dec	ax	;@00B4F
	mov	byte ptr ds:[158h], al	;@00B50
	mov	byte ptr ds:[159h], al	;@00B53
	mov	word ptr ds:[150h], 1	;@00B56
	mov	byte ptr ds:[15Bh], 1	;@00B5C
	mov	si, 1099h	;@00B61
	mov	di, 136h	;@00B64
	xor	bx, bx	;@00B67
	call	L00997	;@00B69
	cmp	byte ptr ds:[153h], 0	;@00B6C
	je	L00BD0	;@00B71
	mov	byte ptr ds:[15Bh], 0	;@00B73
	mov	si, 10B1h	;@00B78
	cmp	byte ptr ds:[129h], 1	;@00B7B
	je	@@1	;@00B80
	mov	si, 10A1h	;@00B82
	cmp	byte ptr ds:[129h], 3	;@00B85
	je	@@1	;@00B8A
	mov	si, 109Dh	;@00B8C
@@1:	mov	di, 138h	;@00B8F
	mov	bx, word ptr ds:[136h]	;@00B92
	call	L00997	;@00B96
	mov	byte ptr ds:[11Dh], bl	;@00B99
	mov	byte ptr ds:[152h], 1	;@00B9D
	mov	si, 10A5h	;@00BA2
	mov	di, 13Ah	;@00BA5
	mov	bx, word ptr ds:[138h]	;@00BA8
	call	L00997	;@00BAC
	mov	byte ptr ds:[15Bh], 1	;@00BAF
	mov	si, 10A9h	;@00BB4
	mov	di, 13Ch	;@00BB7
	xor	bx, bx	;@00BBA
	call	L00997	;@00BBC
	mov	byte ptr ds:[15Bh], 0	;@00BBF
	mov	si, 10ADh	;@00BC4
	mov	di, 13Eh	;@00BC7
	xor	bx, bx	;@00BCA
	call	L00997	;@00BCC
	ret	;@00BCF
L00BD0:	call CONSOLE_ON	;@00BD0
	call PUT_INLINE	;@00BD3
	db	';Syntax: TLINK objfiles, exefile, mapfile, libfile', 's, deffile'	;@00BD6
	call PUT_NEWLINE	;@00C12
	call PUT_INLINE	;@00C15
	db	'&@xxxx indicates use response file xxxx'	;@00C18
	call PUT_NEWLINE	;@00C3F
	call PUT_INLINE	;@00C42
	db	'#Options: /m = map file with publics'	;@00C45
	call PUT_NEWLINE	;@00C69
	call PUT_INLINE	;@00C6C
	db	'          /x = no map file at all'	;@00C6F
	call PUT_NEWLINE	;@00C90
	call PUT_INLINE	;@00C93
	db	'%         /i = initialize all segments'	;@00C96
	call PUT_NEWLINE	;@00CBC
	call PUT_INLINE	;@00CBF
	db	')         /l = include source line numbers'	;@00CC2
	call PUT_NEWLINE	;@00CEC
	call PUT_INLINE	;@00CEF
	db	'*         /L = specify library search paths'	;@00CF2
	call PUT_NEWLINE	;@00D1D
	call PUT_INLINE	;@00D20
	db	'&         /s = detailed map of segments'	;@00D23
	call PUT_NEWLINE	;@00D4A
	call PUT_INLINE	;@00D4D
	db	'"         /n = no default libraries'	;@00D50
	call PUT_NEWLINE	;@00D73
	call PUT_INLINE	;@00D76
	db	'4         /d = warn if duplicate symbols in librar', 'ies'	;@00D79
	call PUT_NEWLINE	;@00DAE
	call PUT_INLINE	;@00DB1
	db	'/         /c = lower case significant in symbols'	;@00DB4
	call PUT_NEWLINE	;@00DE4
	call PUT_INLINE	;@00DE7
	db	'&         /3 = enable 32-bit processing'	;@00DEA
	call PUT_NEWLINE	;@00E11
	call PUT_INLINE	;@00E14
	db	'5         /v = include full symbolic debug informa', 'tion'	;@00E17
	call PUT_NEWLINE	;@00E4D
	call PUT_INLINE	;@00E50
	db	'(         /e = ignore Extended Dictionary'	;@00E53
	call PUT_NEWLINE	;@00E7C
	call PUT_INLINE	;@00E7F
	db	'+         /t = create COM file (same as /Tc)'	;@00E82
	call PUT_NEWLINE	;@00EAE
	call PUT_INLINE	;@00EB1
	db	1Ch, '         /o = overlay switch'	;@00EB4
	call PUT_NEWLINE	;@00ED1
	call PUT_INLINE	;@00ED4
	db	'(         /P[=NNNNN] = pack code segments'	;@00ED7
	call PUT_NEWLINE	;@00F00
	call PUT_INLINE	;@00F03
	db	'6         /A=NNNN = set NewExe segment alignment f', 'actor'	;@00F06
	call PUT_NEWLINE	;@00F3D
	call PUT_INLINE	;@00F40
	db	27h, '         /ye = expanded memory swapping'	;@00F43
	call PUT_NEWLINE	;@00F6B
	call PUT_INLINE	;@00F6E
	db	27h, '         /yx = extended memory swapping'	;@00F71
	call PUT_NEWLINE	;@00F99
	call PUT_INLINE	;@00F9C
	db	'1         /C  = case sensitive exports and imports'	;@00F9F
	call PUT_NEWLINE	;@00FD1
	call PUT_INLINE	;@00FD4
	db	'(         /Txx = specify output file type'	;@00FD7
	call PUT_NEWLINE	;@01000
	call PUT_INLINE	;@01003
	db	22h, 9, '       /Tdx = DOS image (default)'	;@01006
	call PUT_NEWLINE	;@01029
	call PUT_INLINE	;@0102C
	db	1Ch, 9, '       /Twx = Windows image'	;@0102F
	call PUT_NEWLINE	;@0104C
	call PUT_INLINE	;@0104F
	db	'9                (third letter can be c=COM, e=EXE', ', d=DLL)'	;@01052
	call PUT_NEWLINE	;@0108C
	mov	word ptr ds:[7641h], di	;@0108F
	call CONSOLE_OFF	;@01093
	call L087D0	;@01096
; EXTENSIONS: the extensions TLINK knows, 4 bytes each.
EXTENSIONS	db	'.obj.exe.dll.map.lib.def.com', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@01099
; P1_COMENT_E0: pass 1, Borland COMENT class E0h (debug information).
P1_COMENT_E0:	cmp	byte ptr ds:[3D2h], 2	;@010C0
	je	@@3	;@010C5
	sub	bx, bx	;@010C7
	add	bl, byte ptr [si]	;@010C9
	jge	@@1	;@010CB
	inc	si	;@010CD
	sub	bl, 80h	;@010CE
	mov	bh, bl	;@010D1
	mov	bl, byte ptr [si]	;@010D3
@@1:	inc	si	;@010D5
	cmp	bx, 18h	;@010D6
	jb	@@2	;@010D9
	add	bx, word ptr ds:[38Fh]	;@010DB
@@2:	mov	di, word ptr ds:[174h]	;@010DF
	push	di	;@010E3
	and	di, 3	;@010E4
	shl	di, 1	;@010E7
	shl	di, 1	;@010E9
	shl	di, 1	;@010EB
	mov	es, word ptr [di+716h]	;@010ED
	pop	di	;@010F1
	mov	word ptr es:[di-6], bx	;@010F2
@@3:	ret	;@010F6
; P1_COMENT_E1: pass 1, Borland COMENT class E1h (debug information).
P1_COMENT_E1:	sub	bx, bx	;@010F7
	add	bl, byte ptr [si]	;@010F9
	jge	@@1	;@010FB
	inc	si	;@010FD
	sub	bl, 80h	;@010FE
	mov	bh, bl	;@01101
	mov	bl, byte ptr [si]	;@01103
@@1:	inc	si	;@01105
	cmp	bx, 18h	;@01106
	jb	@@2	;@01109
	add	bx, word ptr ds:[38Fh]	;@0110B
@@2:	mov	di, word ptr ds:[176h]	;@0110F
	push	di	;@01113
	and	di, 3	;@01114
	shl	di, 1	;@01117
	shl	di, 1	;@01119
	shl	di, 1	;@0111B
	mov	es, word ptr [di+756h]	;@0111D
	pop	di	;@01121
	mov	word ptr es:[di+10h], bx	;@01122
	lodsb	;@01126
	or	byte ptr es:[di+0Fh], al	;@01127
	ret	;@0112B
L0112C:	nop	;@0112C
L0112D:	nop	;@0112D
L0112E:	call	L0885D	;@0112E
; P1_COMENT_E2: pass 1, Borland COMENT class E2h (debug information).
P1_COMENT_E2:	cmp	si, word ptr ds:[3E0h]	;@01131
	jb	@@2	;@01135
	jne	L0112C	;@01137
	ret	;@01139
@@1:	add	si, 4	;@0113A
	jmp	P1_COMENT_E2	;@0113D
@@2:	inc	word ptr [di+1Ah]	;@0113F
	lodsb	;@01142
	cmp	al, 40h	;@01143
	je	@@1	;@01145
	cmp	al, 0C0h	;@01147
	je	@@1	;@01149
	lodsb	;@0114B
	cbw	;@0114C
	add	si, ax	;@0114D
	cmp	byte ptr [si], 80h	;@0114F
	sbb	si, -2	;@01152
	jmp	P1_COMENT_E2	;@01155
	db	1, 1, 1, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1	;@01157
	db	1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2
	db	1, 1, 0, 2, 1, 0, 2, 0, 0, 2, 1, 1
; P1_COMENT_E3: pass 1, Borland COMENT class E3h (debug information).
P1_COMENT_E3:	cmp	byte ptr [si], 80h	;@0118D
	sbb	si, -2	;@01190
	lodsb	;@01193
	cbw	;@01194
	add	si, ax	;@01195
	lodsw	;@01197
	lodsb	;@01198
	mov	bx, 1157h	;@01199
	xlat	byte ptr cs:[bx]	;@0119C
	cbw	;@0119E
	add	word ptr [di+18h], ax	;@0119F
	add	word ptr ds:[490h], ax	;@011A2
	jb	@@2	;@011A6
@@1:	ret	;@011A8
@@2:	xor	ax, ax	;@011A9
	push	ax	;@011AB
	mov	ax, 1Fh	;@011AC
	push	ax	;@011AF
	call	ERROR	;@011B0
	or	byte ptr ds:[410h], 4	;@011B3
	jmp	@@1	;@011B8
; P1_COMENT_E4: pass 1, Borland COMENT class E4h (debug information).
P1_COMENT_E4:	cmp	si, word ptr ds:[3E0h]	;@011BA
	jb	@@2	;@011BE
	je	@@1	;@011C0
	jmp	L0112D	;@011C2
@@1:	ret	;@011C5
@@2:	inc	word ptr [di+1Ah]	;@011C6
	lodsb	;@011C9
	lodsb	;@011CA
	cbw	;@011CB
	add	si, ax	;@011CC
	lodsw	;@011CE
	jmp	P1_COMENT_E4	;@011CF
L011D1:	push	ax	;@011D1
	push	bx	;@011D2
	sub	bx, 4001h	;@011D3
	shl	bx, 1	;@011D7
	add	bx, word ptr ds:[52Ch]	;@011D9
	mov	di, word ptr ds:[530h]	;@011DD
@@1:	cmp	di, word ptr ds:[7ACh]	;@011E1
	jae	@@2	;@011E5
	mov	es, word ptr ds:[7AEh]	;@011E7
	cmp	word ptr es:[di], bx	;@011EB
	je	@@4	;@011EE
	add	di, 11h	;@011F0
	jmp	@@1	;@011F3
@@2:	mov	di, 11h	;@011F5
	push	di	;@011F8
	mov	di, 7AAh	;@011F9
	call	L054ED	;@011FC
	jae	@@3	;@011FF
	call	TABLE_OVERFLOW	;@01201
@@3:	push	di	;@01204
	mov	cx, 11h	;@01205
	xor	ax, ax	;@01208
	rep stosb	;@0120A
	pop	di	;@0120C
	mov	word ptr es:[di], bx	;@0120D
@@4:	pop	bx	;@01210
	pop	ax	;@01211
	ret	;@01212
; P1_COMENT_E5: pass 1, Borland COMENT class E5h (debug information).
P1_COMENT_E5:	inc	word ptr ds:[178h]	;@01213
	mov	ax, word ptr ds:[178h]	;@01217
	cmp	ax, word ptr ds:[488h]	;@0121A
	jbe	@@1	;@0121E
	mov	word ptr ds:[488h], ax	;@01220
@@1:	sub	bx, bx	;@01223
	add	bl, byte ptr [si]	;@01225
	jge	@@2	;@01227
	inc	si	;@01229
	sub	bl, 80h	;@0122A
	mov	bh, bl	;@0122D
	mov	bl, byte ptr [si]	;@0122F
@@2:	inc	si	;@01231
	cmp	bx, 4000h	;@01232
	jg	L01257	;@01236
	inc	word ptr [di+20h]	;@01238
	call	L01ADD	;@0123B
	mov	word ptr ds:[182h], 0FFFFh	;@0123E
L01244:	mov	ax, word ptr ds:[367h]	;@01244
	cmp	ax, word ptr ds:[48Ch]	;@01247
	jbe	@@1	;@0124B
	mov	word ptr ds:[48Ch], ax	;@0124D
@@1:	mov	word ptr ds:[367h], 0	;@01250
	ret	;@01256
L01257:	call	L011D1	;@01257
	mov	word ptr ds:[182h], bx	;@0125A
	inc	word ptr es:[di+8]	;@0125E
	jmp	L01244	;@01262
L01264:	cmp	si, word ptr ds:[3E0h]	;@01264
	jb	@@2	;@01268
	je	@@1	;@0126A
	jmp	L0112E	;@0126C
@@1:	ret	;@0126F
@@2:	lodsb	;@01270
	cbw	;@01271
	add	si, ax	;@01272
	cmp	byte ptr [si], 80h	;@01274
	sbb	si, -2	;@01277
	lodsb	;@0127A
	and	al, 7	;@0127B
	xlat	byte ptr cs:[bx]	;@0127D
	test	al, 80h	;@0127F
	je	@@3	;@01281
	inc	word ptr ds:[367h]	;@01283
	cmp	byte ptr [si], 80h	;@01287
	sbb	si, -2	;@0128A
	cmp	al, 90h	;@0128D
	jb	@@3	;@0128F
	cmp	byte ptr [si], 80h	;@01291
	sbb	si, -2	;@01294
@@3:	push	bx	;@01297
	cmp	word ptr ds:[178h], 0	;@01298
	je	@@4	;@0129D
	mov	bx, word ptr ds:[182h]	;@0129F
	cmp	bx, -1	;@012A3
	je	@@4	;@012A6
	push	di	;@012A8
	call	L011D1	;@012A9
	inc	word ptr es:[di+6]	;@012AC
	pop	di	;@012B0
	jmp	short @@5	;@012B1
@@4:	inc	word ptr [di+1Ch]	;@012B3
@@5:	pop	bx	;@012B6
	and	ax, 7	;@012B7
	add	si, ax	;@012BA
	jmp	L01264	;@012BC
	db	92h, 82h, 2, 2, 1, 4, 0, 0	;@012BE
; P1_COMENT_E6: pass 1, Borland COMENT class E6h (debug information).
P1_COMENT_E6:	mov	bx, 12BEh	;@012C6
	call	L01264	;@012C9
	ret	;@012CC
; P1_COMENT_E7: pass 1, Borland COMENT class E7h (debug information).
P1_COMENT_E7:	dec	word ptr ds:[178h]	;@012CD
	jmp	L01244	;@012D1
; P1_COMENT_E8: pass 1, Borland COMENT class E8h (debug information).
P1_COMENT_E8:	sub	bx, bx	;@012D4
	add	bl, byte ptr [si]	;@012D6
	jge	@@1	;@012D8
	inc	si	;@012DA
	sub	bl, 80h	;@012DB
	mov	bh, bl	;@012DE
	mov	bl, byte ptr [si]	;@012E0
@@1:	inc	si	;@012E2
	and	bx, bx	;@012E3
	jne	@@2	;@012E5
	inc	word ptr [di+24h]	;@012E7
@@2:	mov	word ptr ds:[39Bh], 1	;@012EA
	mov	word ptr ds:[17Ah], 0FFFFh	;@012F0
	ret	;@012F6
; P1_COMENT_SKIP: pass 1, a Borland COMENT class TLINK has nothing to do with.
P1_COMENT_SKIP:	ret	;@012F7
; P1_COMENT_EA: pass 1, Borland COMENT class EAh (debug information).
P1_COMENT_EA:	lodsw	;@012F8
	mov	byte ptr [di+30h], al	;@012F9
	mov	byte ptr [di+31h], ah	;@012FC
	ret	;@012FF
; P1_COMENT_EB: pass 1, Borland COMENT class EBh (debug information).
P1_COMENT_EB:	cmp	byte ptr ds:[3D2h], 2	;@01300
	je	@@3	;@01305
	mov	ah, 0	;@01307
	call	L0910B	;@01309
	mov	di, bx	;@0130C
	sub	bx, bx	;@0130E
	add	bl, byte ptr [si]	;@01310
	jge	@@1	;@01312
	inc	si	;@01314
	sub	bl, 80h	;@01315
	mov	bh, bl	;@01318
	mov	bl, byte ptr [si]	;@0131A
@@1:	inc	si	;@0131C
	cmp	bx, 18h	;@0131D
	jb	@@2	;@01320
	add	bx, word ptr ds:[38Fh]	;@01322
@@2:	mov	word ptr es:[di-6], bx	;@01326
@@3:	ret	;@0132A
; P1_COMENT_EC: pass 1, Borland COMENT class ECh (debug information).
P1_COMENT_EC:	mov	ah, 0	;@0132B
	call	L0910B	;@0132D
	mov	di, word ptr es:[bx]	;@01330
	cmp	di, -1	;@01333
	je	@@3	;@01336
	push	di	;@01338
	and	di, 3	;@01339
	shl	di, 1	;@0133C
	shl	di, 1	;@0133E
	shl	di, 1	;@01340
	mov	es, word ptr [di+756h]	;@01342
	pop	di	;@01346
	sub	bx, bx	;@01347
	add	bl, byte ptr [si]	;@01349
	jge	@@1	;@0134B
	inc	si	;@0134D
	sub	bl, 80h	;@0134E
	mov	bh, bl	;@01351
	mov	bl, byte ptr [si]	;@01353
@@1:	inc	si	;@01355
	cmp	bx, 18h	;@01356
	jb	@@2	;@01359
	add	bx, word ptr ds:[38Fh]	;@0135B
@@2:	mov	word ptr es:[di+10h], bx	;@0135F
	lodsb	;@01363
	or	byte ptr es:[di+0Fh], al	;@01364
@@3:	ret	;@01368
; P1_COMENT_ED: pass 1, Borland COMENT class EDh (debug information).
P1_COMENT_ED:	lodsb	;@01369
	and	al, al	;@0136A
	je	@@2	;@0136C
	lodsb	;@0136E
	cbw	;@0136F
	and	al, al	;@01370
	jns	@@1	;@01372
	sub	al, 80h	;@01374
	mov	ah, al	;@01376
	lodsb	;@01378
@@1:	add	word ptr [di+2Ch], ax	;@01379
	ret	;@0137C
@@2:	mov	ax, word ptr ds:[178h]	;@0137D
	or	word ptr ds:[3A8h], ax	;@01380
	cmp	byte ptr [si], 80h	;@01384
	sbb	si, -2	;@01387
	add	si, 3	;@0138A
	lodsb	;@0138D
	cbw	;@0138E
	and	al, al	;@0138F
	jns	@@3	;@01391
	sub	al, 80h	;@01393
	mov	ah, al	;@01395
	lodsb	;@01397
@@3:	add	word ptr [di+2Eh], ax	;@01398
	inc	word ptr [di+2Ah]	;@0139B
	ret	;@0139E
; P1_COMENT_F8: pass 1, Borland COMENT class F8h (debug information).
P1_COMENT_F8:	mov	ah, 0	;@0139F
	call	L0910B	;@013A1
	ret	;@013A4
; P1_COMENT_EE: pass 1, Borland COMENT class EEh (debug information).
P1_COMENT_EE:	cmp	byte ptr ds:[12Dh], 1	;@013A5
	je	@@2	;@013AA
	push	di	;@013AC
	sub	bx, bx	;@013AD
	add	bl, byte ptr [si]	;@013AF
	jge	@@1	;@013B1
	inc	si	;@013B3
	sub	bl, 80h	;@013B4
	mov	bh, bl	;@013B7
	mov	bl, byte ptr [si]	;@013B9
@@1:	inc	si	;@013BB
	cmp	bx, 4000h	;@013BC
	jg	@@3	;@013C0
	call	L01ADD	;@013C2
	mov	ax, word ptr ds:[3E0h]	;@013C5
	sub	ax, si	;@013C8
	shr	ax, 1	;@013CA
	pop	di	;@013CC
	add	word ptr [di+32h], ax	;@013CD
	inc	word ptr [di+34h]	;@013D0
@@2:	mov	si, word ptr ds:[3E0h]	;@013D3
	ret	;@013D7
@@3:	add	sp, 2	;@013D8
	call	L011D1	;@013DB
	mov	ax, word ptr ds:[3E0h]	;@013DE
	sub	ax, si	;@013E1
	shr	ax, 1	;@013E3
	add	word ptr es:[di+0Ch], ax	;@013E5
	inc	word ptr es:[di+0Eh]	;@013E9
	jmp	@@2	;@013ED

; pass 1: the handlers of the COMENT classes E0h..F8h
PASS1_COMENT_CLASSES	dw	P1_COMENT_E0, P1_COMENT_E1, P1_COMENT_E2, P1_COMENT_E3, P1_COMENT_E4, P1_COMENT_E5, P1_COMENT_E6, P1_COMENT_E7	;@013EF
	dw	P1_COMENT_E8, P1_COMENT_SKIP, P1_COMENT_EA, P1_COMENT_EB, P1_COMENT_EC, P1_COMENT_ED, P1_COMENT_EE, P1_COMENT_SKIP
	dw	P1_COMENT_SKIP, P1_COMENT_SKIP, P1_COMENT_SKIP, P1_COMENT_SKIP, P1_COMENT_SKIP, P1_COMENT_SKIP, P1_COMENT_SKIP, P1_COMENT_SKIP
	dw	P1_COMENT_F8
L01421:	mov	si, 18Ah	;@01421
	mov	cx, word ptr ds:[54Eh]	;@01424
	mov	di, word ptr ds:[52Ah]	;@01428
	mov	es, word ptr ds:[77Eh]	;@0142C
	mov	dx, word ptr ds:[774h]	;@01430
	mov	ax, 1	;@01434
@@1:	test	word ptr [si], ax	;@01437
	je	@@2	;@01439
	mov	byte ptr es:[di+9], 1	;@0143B
@@2:	shl	ax, 1	;@01440
	jb	@@4	;@01442
@@3:	add	di, 0Ah	;@01444
	cmp	di, dx	;@01447
	jb	@@1	;@01449
	ret	;@0144B
@@4:	rcl	ax, 1	;@0144C
	inc	si	;@0144E
	inc	si	;@0144F
	jmp	@@3	;@01450
L01452:	mov	al, byte ptr [si]	;@01452
	add	al, 2	;@01454
	sub	si, 2	;@01456
	mov	byte ptr [si], al	;@01459
	mov	ax, word ptr ds:[186h]	;@0145B
	mov	word ptr [si+1], ax	;@0145E
	ret	;@01461
; P1_THEADR: pass 1, THEADR (80h): a new module.
P1_THEADR:	cmp	byte ptr ds:[492h], 0	;@01462
	je	@@1	;@01467
	mov	si, word ptr ds:[3E0h]	;@01469
	jmp	L059AB	;@0146D
@@1:	dec	byte ptr ds:[492h]	;@01470
	mov	word ptr ds:[164h], 0	;@01474
	mov	word ptr ds:[166h], 0	;@0147A
	mov	word ptr ds:[78Ch], 0	;@01480
	mov	ah, 40h	;@01486
	cmp	byte ptr ds:[3D2h], 1	;@01488
	jae	@@9	;@0148D
	mov	word ptr ds:[534h], 0	;@0148F
	cmp	word ptr [si], 4101h	;@01495
	jne	@@10	;@01499
	push	ax	;@0149B
	push	cx	;@0149C
	push	si	;@0149D
	push	di	;@0149E
	mov	word ptr ds:[2BCh], 4101h	;@0149F
	push	ds	;@014A5
	pop	es	;@014A6
	mov	bx, 54BBh	;@014A7
	mov	si, bx	;@014AA
@@2:	cmp	byte ptr [bx], 3Ah	;@014AC
	je	@@3	;@014AF
	cmp	byte ptr [bx], 5Ch	;@014B1
	je	@@3	;@014B4
	cmp	byte ptr [bx], 2Fh	;@014B6
	jne	@@4	;@014B9
@@3:	lea	si, [bx+1]	;@014BB
@@4:	cmp	byte ptr [bx], 0	;@014BE
	je	@@5	;@014C1
	inc	bx	;@014C3
	jmp	@@2	;@014C4
@@5:	mov	cx, bx	;@014C6
	sub	cx, si	;@014C8
	je	@@8	;@014CA
@@6:	dec	bx	;@014CC
	cmp	bx, si	;@014CD
	jb	@@7	;@014CF
	cmp	byte ptr [bx], 2Eh	;@014D1
	jne	@@6	;@014D4
	mov	cx, bx	;@014D6
	sub	cx, si	;@014D8
@@7:	mov	di, 2BCh	;@014DA
	cld	;@014DD
	mov	al, cl	;@014DE
	stosb	;@014E0
	rep movsb	;@014E1
@@8:	push	es	;@014E3
	pop	ds	;@014E4
	mov	si, 2BCh	;@014E5
	call	L0910B	;@014E8
	pop	di	;@014EB
	pop	si	;@014EC
	pop	cx	;@014ED
	pop	ax	;@014EE
	add	si, 2	;@014EF
	jmp	short @@11	;@014F2
@@9:	mov	ax, si	;@014F4
	sub	ax, 1451h	;@014F6
	sbb	dx, dx	;@014F9
	add	ax, word ptr ds:[3468h]	;@014FB
	adc	dx, word ptr ds:[346Ah]	;@014FF
	div	word ptr ds:[3462h]	;@01503
	mov	word ptr ds:[534h], ax	;@01507
	mov	ah, 40h	;@0150A
@@10:	call	L0910B	;@0150C
@@11:	push	ds	;@0150F
	pop	es	;@01510
	mov	di, 528h	;@01511
	mov	ax, bx	;@01514
	stosw	;@01516
	mov	ax, word ptr ds:[774h]	;@01517
	stosw	;@0151A
	mov	ax, word ptr ds:[784h]	;@0151B
	stosw	;@0151E
	mov	ax, word ptr ds:[794h]	;@0151F
	stosw	;@01522
	mov	ax, word ptr ds:[7ACh]	;@01523
	stosw	;@01526
	xor	ax, ax	;@01527
	cmp	byte ptr ds:[3D2h], 2	;@01529
	jne	@@12	;@0152E
	inc	ax	;@01530
@@12:	stosw	;@01531
	inc	di	;@01532
	inc	di	;@01533
	xor	ax, ax	;@01534
	mov	cx, 2Ah	;@01536
	rep stosb	;@01539
	mov	word ptr ds:[178h], ax	;@0153B
	mov	di, 18Ah	;@0153E
	mov	cx, 40h	;@01541
	rep stosw	;@01544
	mov	word ptr ds:[17Ah], 0FFFFh	;@01546
	mov	word ptr ds:[39Bh], 0FFFFh	;@0154C
	mov	word ptr ds:[367h], 0	;@01552
	mov	word ptr ds:[3A8h], 0	;@01558
	jmp	L059AB	;@0155E
; P1_COMENT: pass 1, COMENT (88h): Microsoft and Borland comment classes.
P1_COMENT:	lodsw	;@01561
	cmp	byte ptr ds:[3D4h], 0	;@01562
	jne	@@1	;@01567
	cmp	byte ptr ds:[17h], 0	;@01569
	je	@@1	;@0156E
	cmp	ah, 0A0h	;@01570
	jne	@@1	;@01573
	call	L09A90	;@01575
	jmp	@@13	;@01578
@@1:	mov	dx, 2BCh	;@0157B
	or	ah, ah	;@0157E
	je	@@5	;@01580
	cmp	ah, 0A1h	;@01582
	je	@@6	;@01585
	cmp	ah, 9Fh	;@01587
	je	@@7	;@0158A
	xor	dx, dx	;@0158C
	cmp	ah, 0B4h	;@0158E
	je	@@7	;@01591
	cmp	byte ptr ds:[16h], 1	;@01593
	jne	@@2	;@01598
	cmp	ah, 9Eh	;@0159A
	je	@@4	;@0159D
@@2:	cmp	byte ptr ds:[15h], 0	;@0159F
	je	@@3	;@015A4
	mov	bl, ah	;@015A6
	xor	bh, bh	;@015A8
	sub	bx, 0E0h	;@015AA
	jl	@@3	;@015AE
	cmp	bx, 19h	;@015B0
	jae	@@3	;@015B3
	mov	di, 528h	;@015B5
	shl	bx, 1	;@015B8
	call	word ptr cs:PASS1_COMENT_CLASSES[bx]	;@015BA
	mov	byte ptr ds:[538h], 4	;@015BF
@@3:	jmp	@@13	;@015C4
@@4:	mov	byte ptr ds:[3D7h], 1	;@015C7
	jmp	@@13	;@015CC
@@5:	jmp	@@13	;@015CF
@@6:	or	byte ptr ds:[53Dh], 1	;@015D2
	jmp	@@13	;@015D7
@@7:	cmp	byte ptr ds:[123h], 1	;@015DA
	je	@@3	;@015DF
	cmp	word ptr ds:[17Ch], 0	;@015E1
	je	@@3	;@015E6
	mov	di, word ptr ds:[180h]	;@015E8
	push	ds	;@015EC
	pop	es	;@015ED
	inc	di	;@015EE
	inc	di	;@015EF
	mov	cx, word ptr ds:[3E0h]	;@015F0
	sub	cx, si	;@015F4
	xor	bl, bl	;@015F6
@@8:	lodsb	;@015F8
	cmp	al, 41h	;@015F9
	jb	@@9	;@015FB
	cmp	al, 5Ah	;@015FD
	ja	@@9	;@015FF
	add	al, 20h	;@01601
@@9:	cmp	di, word ptr ds:[17Eh]	;@01603
	jae	@@13	;@01607
	stosb	;@01609
	cmp	al, 5Ch	;@0160A
	je	@@10	;@0160C
	cmp	al, 3Ah	;@0160E
	je	@@10	;@01610
	cmp	al, 2Fh	;@01612
	je	@@10	;@01614
	cmp	al, 2Eh	;@01616
	jne	@@11	;@01618
	mov	bl, 1	;@0161A
	jmp	short @@11	;@0161C
@@10:	xor	bl, bl	;@0161E
@@11:	loop	@@8	;@01620
	and	dx, dx	;@01622
	je	@@12	;@01624
	and	bl, bl	;@01626
	jne	@@12	;@01628
	lea	ax, [di+4]	;@0162A
	cmp	ax, word ptr ds:[17Eh]	;@0162D
	jae	@@13	;@01631
	mov	si, dx	;@01633
	push	ds	;@01635
	push	cs	;@01636
	pop	ds	;@01637
	movsw	;@01638
	movsw	;@01639
	pop	ds	;@0163A
@@12:	cmp	di, word ptr ds:[17Eh]	;@0163B
	jae	@@13	;@0163F
	sub	al, al	;@01641
	stosb	;@01643
	mov	cx, di	;@01644
	mov	di, word ptr ds:[180h]	;@01646
	inc	di	;@0164A
	inc	di	;@0164B
	sub	cx, di	;@0164C
	push	ds	;@0164E
	mov	si, 136h	;@0164F
	call	@@14	;@01652
	pop	ds	;@01655
	jb	@@13	;@01656
	push	ds	;@01658
	mov	si, 13Ch	;@01659
	call	@@14	;@0165C
	pop	ds	;@0165F
	jb	@@13	;@01660
	add	di, cx	;@01662
	xchg	word ptr ds:[180h], di	;@01664
	push	si	;@01668
	mov	si, word ptr ds:[3470h]	;@01669
	mov	word ptr [si], di	;@0166D
	mov	word ptr ds:[3470h], di	;@0166F
	mov	word ptr [di], 0	;@01673
	pop	si	;@01677
	dec	word ptr ds:[17Ch]	;@01678
@@13:	jmp	L059AB	;@0167C
@@14:	mov	si, word ptr [si]	;@0167F
	lds	bx, dword ptr ds:[132h]	;@01681
	mov	ds, word ptr [bx]	;@01685
@@15:	cmp	si, 0	;@01687
	je	@@16	;@0168A
	push	word ptr [si]	;@0168C
	push	di	;@0168E
	push	cx	;@0168F
	inc	si	;@01690
	inc	si	;@01691
	repe cmpsb	;@01692
	pop	cx	;@01694
	pop	di	;@01695
	pop	si	;@01696
	jne	@@15	;@01697
	stc	;@01699
	ret	;@0169A
@@16:	clc	;@0169B
	ret	;@0169C
; P1_MODEND: pass 1, MODEND (8Ah): the end of a module, and its start address.
P1_MODEND:	inc	byte ptr ds:[492h]	;@0169D
	mov	al, byte ptr [si]	;@016A1
	cmp	al, 0C1h	;@016A3
	jne	@@1	;@016A5
	cmp	word ptr ds:[3F6h], -1	;@016A7
	jne	@@1	;@016AC
	mov	di, word ptr ds:[186h]	;@016AE
	mov	word ptr ds:[3F6h], di	;@016B2
	cmp	byte ptr ds:[129h], 1	;@016B6
	jne	@@1	;@016BB
	inc	si	;@016BD
	call	L01F27	;@016BE
	mov	word ptr ds:[0C33h], cx	;@016C1
@@1:	mov	ax, word ptr ds:[166h]	;@016C5
	cmp	byte ptr ds:[3D6h], 1	;@016C8
	jne	@@2	;@016CD
	cmp	ax, word ptr ds:[164h]	;@016CF
	jbe	@@2	;@016D3
	sub	ax, word ptr ds:[164h]	;@016D5
	nop	;@016D9
	mov	ah, 0Ah	;@016DA
	mul	ah	;@016DC
	nop	;@016DE
	sub	word ptr ds:[774h], ax	;@016DF
	sub	word ptr ds:[77Ch], ax	;@016E3
	mov	ax, word ptr ds:[164h]	;@016E7
@@2:	mov	word ptr ds:[53Bh], ax	;@016EA
	mov	bl, byte ptr ds:[538h]	;@016ED
	and	bx, 0FFh	;@016F1
	je	@@4	;@016F5
	cmp	word ptr ds:[3A8h], 0	;@016F7
	je	@@3	;@016FC
	or	byte ptr ds:[558h], 80h	;@016FE
@@3:	mov	ax, word ptr ds:[54Eh]	;@01703
	and	ax, ax	;@01706
	je	@@4	;@01708
	push	bx	;@0170A
	call	L01421	;@0170B
	pop	bx	;@0170E
@@4:	mov	ax, word ptr ds:[367h]	;@0170F
	cmp	ax, word ptr ds:[48Ch]	;@01712
	jbe	@@5	;@01716
	mov	word ptr ds:[48Ch], ax	;@01718
@@5:	mov	ax, word ptr ds:[55Ah]	;@0171B
	cmp	ax, word ptr ds:[3C8h]	;@0171E
	jbe	@@6	;@01722
	mov	word ptr ds:[3C8h], ax	;@01724
@@6:	mov	ax, word ptr ds:[55Ch]	;@01727
	cmp	ax, word ptr ds:[3C6h]	;@0172A
	jbe	@@7	;@0172E
	mov	word ptr ds:[3C6h], ax	;@01730
@@7:	mov	ax, word ptr ds:[540h]	;@01733
	add	word ptr ds:[38Fh], ax	;@01736
	mov	cx, word ptr cs:L05780[bx]	;@0173A
	push	bx	;@0173F
	mov	bx, word ptr ds:[738h]	;@01740
	les	di, dword ptr [bx+2]	;@01744
	add	di, cx	;@01747
	cmp	di, word ptr [bx]	;@01749
	jbe	@@8	;@0174B
	call	L05519	;@0174D
	pop	bx	;@01750
	jae	@@9	;@01751
	call	TABLE_OVERFLOW	;@01753
@@8:	xchg	word ptr [bx+2], di	;@01756
	pop	bx	;@01759
@@9:	mov	word ptr ds:[184h], di	;@0175A
	mov	si, di	;@0175E
	and	si, 3	;@01760
	shl	si, 1	;@01763
	shl	si, 1	;@01765
	shl	si, 1	;@01767
	lea	si, [si+732h]	;@01769
	mov	si, word ptr [si+2]	;@0176D
	mov	word ptr ds:[186h], si	;@01770
	add	si, 38h	;@01774
	cmp	si, -80h	;@01777
	jbe	@@10	;@0177A
	and	si, 3	;@0177C
	inc	si	;@0177F
	mov	word ptr ds:[186h], si	;@01780
	mov	si, di	;@01784
	and	si, 3	;@01786
	shl	si, 1	;@01789
	shl	si, 1	;@0178B
	shl	si, 1	;@0178D
	lea	si, [si+732h]	;@0178F
	mov	word ptr [si+2], 0FF80h	;@01793
@@10:	mov	si, 528h	;@01798
	shr	cx, 1	;@0179B
	rep movsw	;@0179D
	rcl	cx, 1	;@0179F
	rep movsb	;@017A1
	cmp	byte ptr ds:[3D2h], 0	;@017A3
	je	@@13	;@017A8
	mov	si, word ptr ds:[3E0h]	;@017AA
	inc	si	;@017AE
	push	ds	;@017AF
	pop	es	;@017B0
@@11:	mov	cx, word ptr ds:[3458h]	;@017B1
	sub	cx, si	;@017B5
	cmp	cx, 2	;@017B7
	jae	@@12	;@017BA
	call	L087E1	;@017BC
	jmp	@@11	;@017BF
@@12:	sub	ax, ax	;@017C1
	mov	di, si	;@017C3
	shr	cx, 1	;@017C5
	repe scasw	;@017C7
	mov	si, di	;@017C9
	je	@@11	;@017CB
	dec	si	;@017CD
	dec	si	;@017CE
	cmp	byte ptr [si], 1	;@017CF
	adc	si, ax	;@017D2
	jmp	L059B4	;@017D4
@@13:	ret	;@017D7
L017D8:	push	ax	;@017D8
	push	cx	;@017D9
	mov	cx, word ptr ds:[48Eh]	;@017DA
	push	bx	;@017DE
	mov	bx, word ptr ds:[758h]	;@017DF
	les	di, dword ptr [bx+2]	;@017E3
	add	di, cx	;@017E6
	cmp	di, word ptr [bx]	;@017E8
	ja	@@2	;@017EA
	xchg	word ptr [bx+2], di	;@017EC
	pop	bx	;@017EF
@@1:	mov	word ptr ds:[176h], di	;@017F0
	push	di	;@017F4
	mov	al, 0	;@017F5
	cld	;@017F7
	rep stosb	;@017F8
	pop	di	;@017FA
	dec	word ptr es:[di+8]	;@017FB
	dec	word ptr es:[di+0Ah]	;@017FF
	pop	cx	;@01803
	pop	ax	;@01804
	ret	;@01805
@@2:	call	L05519	;@01806
	pop	bx	;@01809
	jae	@@1	;@0180A
	jmp L09219	;@0180C
L0180F:	mov	ax, word ptr es:[bx]	;@0180F
	cmp	ax, 0FFFFh	;@01812
	jne	@@1	;@01815
	call	L017D8	;@01817
	or	byte ptr es:[di+0Eh], dl	;@0181A
	mov	word ptr es:[di+0Ch], bx	;@0181E
	mov	ax, word ptr ds:[186h]	;@01822
	mov	word ptr es:[di+2], ax	;@01825
	xchg	ax, di	;@01829
	push	bx	;@0182A
	and	bx, 3	;@0182B
	shl	bx, 1	;@0182E
	shl	bx, 1	;@01830
	shl	bx, 1	;@01832
	mov	es, word ptr [bx+716h]	;@01834
	pop	bx	;@01838
	mov	word ptr es:[bx], ax	;@01839
@@1:	les	di, dword ptr ds:[784h]	;@0183C
	add	di, 2	;@01840
	cmp	di, word ptr ds:[782h]	;@01843
	jbe	@@2	;@01847
	mov	di, 2	;@01849
	push	di	;@0184C
	mov	di, 782h	;@0184D
	call	L054ED	;@01850
	jae	@@3	;@01853
	call	TABLE_OVERFLOW	;@01855
@@2:	xchg	word ptr ds:[784h], di	;@01858
@@3:	mov	word ptr ds:[188h], di	;@0185C
	mov	word ptr es:[di], ax	;@01860
	ret	;@01863
L01864:	mov	bx, word ptr ds:[174h]	;@01864
	or	dl, 10h	;@01868
	jmp	short @@3	;@0186B
@@1:	test	dl, 4	;@0186D
	je	@@2	;@01870
	call	L01452	;@01872
@@2:	mov	ah, 0	;@01875
	call	L0910B	;@01877
	call	L0180F	;@0187A
	cmp	byte ptr [si], 80h	;@0187D
	sbb	si, -2	;@01880
@@3:	cmp	si, word ptr ds:[3E0h]	;@01883
	jb	@@1	;@01887
	mov	word ptr ds:[174h], bx	;@01889
	jmp	L059AB	;@0188D
; P1_EXTDEF: pass 1, EXTDEF (8Ch): external names.
P1_EXTDEF:	mov	dl, 0	;@01890
	jmp	L01864	;@01892
; P1_LEXTDEF: pass 1, LEXTDEF (B4h): module-local external names.
P1_LEXTDEF:	mov	dl, 4	;@01894
	jmp	L01864	;@01896
L01898:	cmp	byte ptr [si], 80h	;@01898
	sbb	si, -2	;@0189B
	sub	bx, bx	;@0189E
	add	bl, byte ptr [si]	;@018A0
	jge	@@1	;@018A2
	inc	si	;@018A4
	sub	bl, 80h	;@018A5
	mov	bh, bl	;@018A8
	mov	bl, byte ptr [si]	;@018AA
@@1:	inc	si	;@018AC
	or	bx, bx	;@018AD
	jne	@@2	;@018AF
	mov	dl, 2	;@018B1
	lodsw	;@018B3
	sub	ax, ax	;@018B4
	jmp	short @@4	;@018B6
@@2:	mov	dl, 0	;@018B8
	cmp	bx, 4000h	;@018BA
	jg	@@5	;@018BE
	cmp	bx, word ptr ds:[164h]	;@018C0
	jbe	@@3	;@018C4
	mov	word ptr ds:[164h], bx	;@018C6
@@3:	dec	bx	;@018CA
	xchg	ax, bx	;@018CB
	mov	ah, 0Ah	;@018CC
	mul	ah	;@018CE
	xchg	ax, bx	;@018D0
	add	bx, word ptr ds:[52Ah]	;@018D1
	xchg	ax, bx	;@018D5
@@4:	ret	;@018D6
@@5:	mov	ax, 0FFFFh	;@018D7
	jmp	@@4	;@018DA
L018DC:	push	bx	;@018DC
	and	bx, 3	;@018DD
	shl	bx, 1	;@018E0
	shl	bx, 1	;@018E2
	shl	bx, 1	;@018E4
	mov	es, word ptr [bx+716h]	;@018E6
	pop	bx	;@018EA
	mov	si, word ptr es:[bx]	;@018EB
	push	si	;@018EE
	and	si, 3	;@018EF
	shl	si, 1	;@018F2
	shl	si, 1	;@018F4
	shl	si, 1	;@018F6
	mov	es, word ptr [si+756h]	;@018F8
	pop	si	;@018FC
	mov	si, word ptr es:[si+2]	;@018FD
	ret	;@01901
L01902:	cmp	word ptr es:[bx], -1	;@01902
	je	@@1	;@01906
	jmp	@@6	;@01908
@@1:	call	L017D8	;@0190B
@@2:	mov	word ptr ds:[176h], di	;@0190E
	mov	ax, word ptr ds:[16Ch]	;@01912
	mov	word ptr es:[di], ax	;@01915
	mov	ax, word ptr ds:[186h]	;@01918
	mov	word ptr es:[di+2], ax	;@0191B
	mov	ax, word ptr ds:[16Eh]	;@0191F
	mov	word ptr es:[di+4], ax	;@01922
	mov	ax, word ptr ds:[170h]	;@01926
	mov	word ptr es:[di+6], ax	;@01929
	mov	word ptr es:[di+0Ch], bx	;@0192D
	mov	al, byte ptr ds:[172h]	;@01931
	mov	byte ptr es:[di+0Eh], al	;@01934
	test	al, 2	;@01938
	je	@@3	;@0193A
	mov	byte ptr es:[di+0Fh], 5	;@0193C
@@3:	mov	dx, 0FFFFh	;@01941
	push	bx	;@01944
	test	al, 2	;@01945
	jne	@@4	;@01947
	mov	bx, word ptr ds:[16Ch]	;@01949
	mov	cx, word ptr ds:[44Eh]	;@0194D
	mov	es, word ptr ds:[776h]	;@01951
	cmp	cx, word ptr es:[bx+2]	;@01955
	jne	@@4	;@01959
	mov	dx, di	;@0195B
	mov	es, word ptr ds:[77Eh]	;@0195D
	xchg	word ptr es:[bx+4], dx	;@01961
	push	di	;@01965
	and	di, 3	;@01966
	shl	di, 1	;@01969
	shl	di, 1	;@0196B
	shl	di, 1	;@0196D
	mov	es, word ptr [di+756h]	;@0196F
	pop	di	;@01973
	mov	word ptr es:[di+0Ah], dx	;@01974
@@4:	pop	bx	;@01978
	push	bx	;@01979
	and	bx, 3	;@0197A
	shl	bx, 1	;@0197D
	shl	bx, 1	;@0197F
	shl	bx, 1	;@01981
	mov	es, word ptr [bx+716h]	;@01983
	pop	bx	;@01987
	mov	word ptr es:[bx], di	;@01988
@@5:	ret	;@0198B
@@6:	mov	di, word ptr es:[bx]	;@0198C
	push	di	;@0198F
	and	di, 3	;@01990
	shl	di, 1	;@01993
	shl	di, 1	;@01995
	shl	di, 1	;@01997
	mov	es, word ptr [di+756h]	;@01999
	pop	di	;@0199D
	test	byte ptr es:[di+0Eh], 18h	;@0199E
	je	@@8	;@019A3
	test	byte ptr es:[di+0Eh], 10h	;@019A5
	je	@@7	;@019AA
	jmp	@@2	;@019AC
@@7:	cmp	word ptr es:[di], -2	;@019AF
	jb	@@8	;@019B3
	jmp	@@2	;@019B5
@@8:	cmp	byte ptr ds:[3D2h], 1	;@019B8
	jbe	@@9	;@019BD
	cmp	byte ptr ds:[122h], 1	;@019BF
	jne	@@5	;@019C4
@@9:	push	si	;@019C6
	push	di	;@019C7
	push	bx	;@019C8
	push	di	;@019C9
	push	ax	;@019CA
	push	dx	;@019CB
	push	bx	;@019CC
	call	L018DC	;@019CD
	mov	bx, si	;@019D0
	pop	si	;@019D2
	push	bx	;@019D3
	mov	di, 26h	;@019D4
	push	si	;@019D7
	and	si, 3	;@019D8
	shl	si, 1	;@019DB
	shl	si, 1	;@019DD
	shl	si, 1	;@019DF
	mov	es, word ptr [si+716h]	;@019E1
	pop	si	;@019E5
	cmp	byte ptr es:[si+3], 40h	;@019E6
	je	@@10	;@019EB
	call	COPY_NAME	;@019ED
	jmp	short @@11	;@019F0
@@10:	call	DEMANGLE_NAME	;@019F2
@@11:	pop	si	;@019F5
	mov	word ptr ds:[422h], 1	;@019F6
	and	si, -2	;@019FC
	cmp	si, word ptr ds:[186h]	;@019FF
	je	@@13	;@01A03
	push	si	;@01A05
	and	si, 3	;@01A06
	shl	si, 1	;@01A09
	shl	si, 1	;@01A0B
	shl	si, 1	;@01A0D
	mov	es, word ptr [si+736h]	;@01A0F
	pop	si	;@01A13
	mov	si, word ptr es:[si]	;@01A14
	mov	di, 76h	;@01A17
	call	COPY_NAME	;@01A1A
	push	ds	;@01A1D
	mov	ax, 76h	;@01A1E
	push	ax	;@01A21
	push	ds	;@01A22
	mov	ax, 26h	;@01A23
	push	ax	;@01A26
	mov	cx, 8	;@01A27
	push	cx	;@01A2A
	cmp	byte ptr ds:[3D2h], 2	;@01A2B
	je	@@12	;@01A30
	mov	ax, 25h	;@01A32
	push	ax	;@01A35
	call	ERROR	;@01A36
	jmp	short @@15	;@01A39
@@12:	mov	ax, 31h	;@01A3B
	push	ax	;@01A3E
	call	WARNING	;@01A3F
	jmp	short @@15	;@01A42
@@13:	push	ds	;@01A44
	mov	ax, 26h	;@01A45
	push	ax	;@01A48
	mov	cx, 4	;@01A49
	push	cx	;@01A4C
	cmp	byte ptr ds:[3D2h], 2	;@01A4D
	je	@@14	;@01A52
	mov	ax, 24h	;@01A54
	push	ax	;@01A57
	call	ERROR	;@01A58
	jmp	short @@15	;@01A5B
@@14:	mov	ax, 30h	;@01A5D
	push	ax	;@01A60
	call	WARNING	;@01A61
@@15:	pop	dx	;@01A64
	pop	ax	;@01A65
	pop	di	;@01A66
	pop	bx	;@01A67
	pop	di	;@01A68
	pop	si	;@01A69
	jmp	@@5	;@01A6A
L01A6D:	mov	byte ptr ds:[172h], al	;@01A6D
	call	L01898	;@01A70
	or	byte ptr ds:[172h], dl	;@01A73
	mov	word ptr ds:[16Ch], ax	;@01A77
	jmp	short @@6	;@01A7A
@@1:	test	byte ptr ds:[172h], 4	;@01A7C
	je	@@2	;@01A81
	call	L01452	;@01A83
@@2:	mov	ah, 0	;@01A86
	call	L0910B	;@01A88
	cmp	byte ptr ds:[129h], 3	;@01A8B
	jne	@@4	;@01A90
	cmp	bx, word ptr ds:[472h]	;@01A92
	jne	@@4	;@01A96
	cmp	byte ptr ds:[20Ah], 0FFh	;@01A98
	je	@@3	;@01A9D
	mov	bx, word ptr ds:[474h]	;@01A9F
	jmp	short @@4	;@01AA3
@@3:	inc	byte ptr ds:[20Ah]	;@01AA5
@@4:	push	bx	;@01AA9
	lodsw	;@01AAA
	mov	word ptr ds:[16Eh], ax	;@01AAB
	xor	ax, ax	;@01AAE
	cmp	ax, word ptr ds:[41Eh]	;@01AB0
	je	@@5	;@01AB4
	lodsw	;@01AB6
@@5:	mov	word ptr ds:[170h], ax	;@01AB7
	cmp	byte ptr [si], 80h	;@01ABA
	sbb	si, -2	;@01ABD
	pop	bx	;@01AC0
	cmp	word ptr ds:[16Ch], -1	;@01AC1
	je	@@6	;@01AC6
	call	L01902	;@01AC8
@@6:	cmp	si, word ptr ds:[3E0h]	;@01ACB
	jb	@@1	;@01ACF
	jmp	L059AB	;@01AD1
; P1_PUBDEF: pass 1, PUBDEF (90h): public names.
P1_PUBDEF:	sub	ax, ax	;@01AD4
	jmp	L01A6D	;@01AD6
; P1_LPUBDEF: pass 1, LPUBDEF (B6h, and 92h): module-local public names.
P1_LPUBDEF:	mov	ax, 4	;@01AD8
	jmp	L01A6D	;@01ADB
L01ADD:	push	si	;@01ADD
	dec	bx	;@01ADE
	cmp	bx, 400h	;@01ADF
	jae	@@2	;@01AE3
	mov	si, bx	;@01AE5
	and	si, 7	;@01AE7
	shr	bx, 1	;@01AEA
	shr	bx, 1	;@01AEC
	shr	bx, 1	;@01AEE
	mov	al, byte ptr cs:L01B08[si]	;@01AF0
	test	byte ptr [bx+18Ah], al	;@01AF5
	jne	@@1	;@01AF9
	inc	word ptr ds:[54Eh]	;@01AFB
	or	byte ptr [bx+18Ah], al	;@01AFF
@@1:	pop	si	;@01B03
	ret	;@01B04
@@2:	call	L0885D	;@01B05
L01B08	db	1, 2, 4, 8, 10h, 20h, 40h, 80h	;@01B08
; P1_LINNUM: pass 1, LINNUM (94h).
P1_LINNUM:	cmp	byte ptr [si], 80h	;@01B10
	sbb	si, -2	;@01B13
	sub	bx, bx	;@01B16
	add	bl, byte ptr [si]	;@01B18
	jge	@@1	;@01B1A
	inc	si	;@01B1C
	sub	bl, 80h	;@01B1D
	mov	bh, bl	;@01B20
	mov	bl, byte ptr [si]	;@01B22
@@1:	inc	si	;@01B24
	cmp	byte ptr ds:[15h], 0	;@01B25
	je	@@5	;@01B2A
	cmp	bx, 4000h	;@01B2C
	jg	@@6	;@01B30
	cmp	bx, word ptr ds:[17Ah]	;@01B32
	je	@@3	;@01B36
	mov	word ptr ds:[17Ah], bx	;@01B38
	inc	word ptr ds:[550h]	;@01B3C
	mov	ax, word ptr ds:[550h]	;@01B40
	cmp	ax, word ptr ds:[48Ah]	;@01B43
	jbe	@@2	;@01B47
	mov	word ptr ds:[48Ah], ax	;@01B49
@@2:	call	L01ADD	;@01B4C
@@3:	cmp	word ptr ds:[39Bh], -1	;@01B4F
	jne	@@4	;@01B54
	inc	word ptr ds:[54Ch]	;@01B56
	mov	word ptr ds:[39Bh], 0	;@01B5A
@@4:	mov	ax, word ptr ds:[3E0h]	;@01B60
	sub	ax, si	;@01B63
	shr	ax, 1	;@01B65
	shr	ax, 1	;@01B67
	add	word ptr ds:[54Ah], ax	;@01B69
	cmp	byte ptr ds:[538h], 0	;@01B6D
	jne	@@5	;@01B72
	mov	byte ptr ds:[538h], 2	;@01B74
@@5:	jmp	L059AB	;@01B79
@@6:	call	L011D1	;@01B7C
	cmp	word ptr ds:[39Bh], -1	;@01B7F
	jne	@@7	;@01B84
	inc	word ptr es:[di+2]	;@01B86
	mov	word ptr ds:[39Bh], 0	;@01B8A
@@7:	mov	ax, word ptr ds:[3E0h]	;@01B90
	sub	ax, si	;@01B93
	shr	ax, 1	;@01B95
	shr	ax, 1	;@01B97
	add	word ptr es:[di+4], ax	;@01B99
	cmp	byte ptr es:[di+10h], 0	;@01B9D
	jne	@@8	;@01BA2
	mov	byte ptr es:[di+10h], 2	;@01BA4
@@8:	inc	word ptr es:[di+0Ah]	;@01BA9
	jmp	L059AB	;@01BAD
; P1_LNAMES: pass 1, LNAMES (96h): segment, class and group names.
P1_LNAMES:	jmp	short @@3	;@01BB0
@@1:	mov	ah, 80h	;@01BB2
	call	L0910B	;@01BB4
	mov	di, 2	;@01BB7
	push	di	;@01BBA
	mov	di, 78Ah	;@01BBB
	call	L054ED	;@01BBE
	jae	@@2	;@01BC1
	call	TABLE_OVERFLOW	;@01BC3
@@2:	mov	word ptr es:[di], bx	;@01BC6
@@3:	cmp	si, word ptr ds:[3E0h]	;@01BC9
	jb	@@1	;@01BCD
	jmp	L059AB	;@01BCF
L01BD2:	mov	word ptr es:[di], bx	;@01BD2
	mov	word ptr es:[di+2], dx	;@01BD5
	cmp	word ptr ds:[0C41h], -1	;@01BD9
	jne	@@1	;@01BDE
	cmp	bx, word ptr ds:[438h]	;@01BE0
	jne	@@1	;@01BE4
	cmp	dx, word ptr ds:[44Ch]	;@01BE6
	jne	@@1	;@01BEA
	mov	word ptr ds:[0C41h], di	;@01BEC
@@1:	mov	ax, word ptr ds:[3D8h]	;@01BF0
	push	bx	;@01BF3
	and	bx, 3	;@01BF4
	shl	bx, 1	;@01BF7
	shl	bx, 1	;@01BF9
	shl	bx, 1	;@01BFB
	mov	es, word ptr [bx+716h]	;@01BFD
	pop	bx	;@01C01
	cmp	word ptr es:[bx], -1	;@01C02
	jne	@@2	;@01C06
	inc	ax	;@01C08
	mov	word ptr es:[bx], ax	;@01C09
@@2:	xchg	bx, dx	;@01C0C
	push	bx	;@01C0E
	and	bx, 3	;@01C0F
	shl	bx, 1	;@01C12
	shl	bx, 1	;@01C14
	shl	bx, 1	;@01C16
	mov	es, word ptr [bx+716h]	;@01C18
	pop	bx	;@01C1C
	cmp	word ptr es:[bx], -1	;@01C1D
	jne	@@3	;@01C21
	inc	ax	;@01C23
	mov	word ptr es:[bx], ax	;@01C24
@@3:	mov	word ptr ds:[3D8h], ax	;@01C27
	ret	;@01C2A
; P1_SEGDEF: pass 1, SEGDEF (98h).
P1_SEGDEF:	call	L05C16	;@01C2B
	mov	ax, word ptr ds:[186h]	;@01C2E
	mov	word ptr es:[di+4], ax	;@01C31
	lodsb	;@01C35
	mov	byte ptr es:[di+9], al	;@01C36
	cmp	al, 0C0h	;@01C3A
	jb	@@1	;@01C3C
	jmp	@@13	;@01C3E
@@1:	test	al, 0E0h	;@01C41
	jne	@@2	;@01C43
	lodsw	;@01C45
	mov	es, word ptr ds:[77Eh]	;@01C46
	mov	word ptr es:[di], ax	;@01C4A
	inc	si	;@01C4D
@@2:	lodsw	;@01C4E
	mov	es, word ptr ds:[776h]	;@01C4F
	mov	word ptr es:[di+6], ax	;@01C53
	xchg	ax, cx	;@01C57
	mov	ax, 2	;@01C58
	and	al, byte ptr es:[di+9]	;@01C5B
	shr	ax, 1	;@01C5F
	cmp	word ptr ds:[41Eh], 0	;@01C61
	je	@@3	;@01C66
	lodsw	;@01C68
@@3:	or	cl, al	;@01C69
	mov	byte ptr es:[di+8], al	;@01C6B
	sub	bx, bx	;@01C6F
	add	bl, byte ptr [si]	;@01C71
	jge	@@4	;@01C73
	inc	si	;@01C75
	sub	bl, 80h	;@01C76
	mov	bh, bl	;@01C79
	mov	bl, byte ptr [si]	;@01C7B
@@4:	inc	si	;@01C7D
	dec	bx	;@01C7E
	shl	bx, 1	;@01C7F
	mov	dx, bx	;@01C81
	sub	bx, bx	;@01C83
	add	bl, byte ptr [si]	;@01C85
	jge	@@5	;@01C87
	inc	si	;@01C89
	sub	bl, 80h	;@01C8A
	mov	bh, bl	;@01C8D
	mov	bl, byte ptr [si]	;@01C8F
@@5:	inc	si	;@01C91
	dec	bx	;@01C92
	shl	bx, 1	;@01C93
	mov	es, word ptr ds:[78Eh]	;@01C95
	mov	bx, word ptr es:[bx]	;@01C99
	xchg	dx, bx	;@01C9C
	mov	bx, word ptr es:[bx]	;@01C9E
	mov	ax, word ptr ds:[166h]	;@01CA1
	inc	ax	;@01CA4
	mov	word ptr ds:[166h], ax	;@01CA5
	or	cx, cx	;@01CA8
	jne	@@6	;@01CAA
	cmp	dx, word ptr ds:[426h]	;@01CAC
	je	@@7	;@01CB0
	cmp	dx, word ptr ds:[42Ch]	;@01CB2
	je	@@7	;@01CB6
@@6:	mov	word ptr ds:[164h], ax	;@01CB8
@@7:	push	si	;@01CBB
	push	di	;@01CBC
	cmp	word ptr ds:[41Ah], 1	;@01CBD
	jne	@@12	;@01CC2
	xor	di, di	;@01CC4
@@8:	cmp	di, word ptr ds:[82Ch]	;@01CC6
	jae	@@12	;@01CCA
	mov	es, word ptr ds:[82Eh]	;@01CCC
	cmp	word ptr es:[di], -2	;@01CD0
	je	@@10	;@01CD4
	cmp	dx, word ptr es:[di]	;@01CD6
	je	@@11	;@01CD9
@@9:	inc	di	;@01CDB
	inc	di	;@01CDC
	jmp	@@8	;@01CDD
@@10:	mov	si, dx	;@01CDF
	push	si	;@01CE1
	and	si, 3	;@01CE2
	shl	si, 1	;@01CE5
	shl	si, 1	;@01CE7
	shl	si, 1	;@01CE9
	mov	es, word ptr [si+716h]	;@01CEB
	pop	si	;@01CEF
	mov	al, byte ptr es:[si+2]	;@01CF0
	and	ax, 3Fh	;@01CF4
	cmp	ax, 4	;@01CF7
	jb	@@9	;@01CFA
	add	si, ax	;@01CFC
	cmp	word ptr es:[si-1], 4F43h	;@01CFE
	jne	@@9	;@01D04
	cmp	word ptr es:[si+1], 4544h	;@01D06
	jne	@@9	;@01D0C
@@11:	mov	dx, word ptr ds:[44Eh]	;@01D0E
@@12:	pop	di	;@01D12
	pop	si	;@01D13
	mov	es, word ptr ds:[776h]	;@01D14
	call	L01BD2	;@01D18
	jmp	L059AB	;@01D1B
@@13:	mov	word ptr ds:[422h], 1	;@01D1E
	xor	ax, ax	;@01D24
	push	ax	;@01D26
	mov	ax, 6	;@01D27
	push	ax	;@01D2A
	call	FATAL	;@01D2B
L01D2E:	or	bx, bx	;@01D2E
	je	@@2	;@01D30
	dec	bx	;@01D32
	xchg	ax, bx	;@01D33
	mov	ah, 0Ah	;@01D34
	mul	ah	;@01D36
	xchg	ax, bx	;@01D38
	add	bx, word ptr ds:[52Ah]	;@01D39
	mov	es, word ptr ds:[77Eh]	;@01D3D
	cmp	word ptr es:[bx], -1	;@01D41
	jne	@@2	;@01D45
	mov	word ptr es:[bx], dx	;@01D47
	cmp	cx, -1	;@01D4A
	jne	@@1	;@01D4D
	mov	cx, bx	;@01D4F
@@1:	ret	;@01D51
@@2:	mov	si, dx	;@01D52
	mov	di, 26h	;@01D54
	call	COPY_NAME	;@01D57
	mov	word ptr ds:[422h], 1	;@01D5A
	push	ds	;@01D60
	mov	ax, 26h	;@01D61
	push	ax	;@01D64
	mov	cx, 4	;@01D65
	push	cx	;@01D68
	mov	ax, 7	;@01D69
	push	ax	;@01D6C
	call	FATAL	;@01D6D
; P1_GRPDEF: pass 1, GRPDEF (9Ah).
P1_GRPDEF:	mov	byte ptr ds:[160h], 1	;@01D70
	sub	bx, bx	;@01D75
	add	bl, byte ptr [si]	;@01D77
	jge	@@1	;@01D79
	inc	si	;@01D7B
	sub	bl, 80h	;@01D7C
	mov	bh, bl	;@01D7F
	mov	bl, byte ptr [si]	;@01D81
@@1:	inc	si	;@01D83
	dec	bx	;@01D84
	shl	bx, 1	;@01D85
	mov	es, word ptr ds:[78Eh]	;@01D87
	mov	dx, word ptr es:[bx]	;@01D8B
	mov	di, 4	;@01D8E
	push	di	;@01D91
	mov	di, 792h	;@01D92
	call	L054ED	;@01D95
	jae	@@2	;@01D98
	call	TABLE_OVERFLOW	;@01D9A
@@2:	mov	word ptr es:[di], dx	;@01D9D
	mov	cx, 0FFFFh	;@01DA0
	jmp	short @@6	;@01DA3
@@3:	lodsb	;@01DA5
	cmp	al, 0FFh	;@01DA6
	jne	@@7	;@01DA8
	sub	bx, bx	;@01DAA
	add	bl, byte ptr [si]	;@01DAC
	jge	@@4	;@01DAE
	inc	si	;@01DB0
	sub	bl, 80h	;@01DB1
	mov	bh, bl	;@01DB4
	mov	bl, byte ptr [si]	;@01DB6
@@4:	inc	si	;@01DB8
	dec	byte ptr ds:[160h]	;@01DB9
	jne	@@5	;@01DBD
	cmp	bx, word ptr ds:[164h]	;@01DBF
	jbe	@@5	;@01DC3
	mov	word ptr ds:[164h], bx	;@01DC5
@@5:	call	L01D2E	;@01DC9
@@6:	cmp	si, word ptr ds:[3E0h]	;@01DCC
	jb	@@3	;@01DD0
	mov	es, word ptr ds:[796h]	;@01DD2
	mov	word ptr es:[di+2], cx	;@01DD6
	jmp	L059AB	;@01DDA
@@7:	xor	bx, bx	;@01DDD
	jmp	@@5	;@01DDF
L01DE1:	push	cx	;@01DE1
	push	dx	;@01DE2
	push	si	;@01DE3
	push	di	;@01DE4
	mov	si, 0C4Eh	;@01DE5
	add	di, si	;@01DE8
@@1:	call	@@2	;@01DEA
	jae	@@1	;@01DED
	pop	di	;@01DEF
	pop	si	;@01DF0
	pop	dx	;@01DF1
	pop	cx	;@01DF2
	ret	;@01DF3
@@2:	lodsw	;@01DF4
	push	ax	;@01DF5
	xor	ax, ax	;@01DF6
	cmp	word ptr ds:[3ECh], 0	;@01DF8
	je	@@3	;@01DFD
	lodsw	;@01DFF
@@3:	push	ax	;@01E00
	lodsw	;@01E01
	mov	cx, ax	;@01E02
	jcxz	@@5	;@01E04
@@4:	push	cx	;@01E06
	call	@@2	;@01E07
	pop	cx	;@01E0A
	jb	@@6	;@01E0B
	loop	@@4	;@01E0D
	jmp	short @@7	;@01E0F
@@5:	lodsb	;@01E11
	sub	ah, ah	;@01E12
	add	si, ax	;@01E14
	cmp	si, di	;@01E16
	jb	@@7	;@01E18
	mov	ax, 1	;@01E1A
@@6:	pop	dx	;@01E1D
	and	dx, dx	;@01E1E
	jne	L01E2F	;@01E20
	pop	dx	;@01E22
	mul	dx	;@01E23
	and	dx, dx	;@01E25
	jne	L01E2F	;@01E27
	stc	;@01E29
	ret	;@01E2A
@@7:	pop	dx	;@01E2B
	pop	dx	;@01E2C
	clc	;@01E2D
	ret	;@01E2E
L01E2F:	xor	ax, ax	;@01E2F
	push	ax	;@01E31
	mov	ax, 1Ch	;@01E32
	push	ax	;@01E35
	call	FATAL	;@01E36
; P1_FIXUPP: pass 1, FIXUPP (9Ch).
P1_FIXUPP:	cmp	byte ptr ds:[17h], 0	;@01E39
	je	@@1	;@01E3E
	jmp	L020E7	;@01E40
@@1:	mov	ax, word ptr ds:[3ECh]	;@01E43
	shl	ax, 1	;@01E46
	mov	word ptr ds:[16Ah], ax	;@01E48
	xor	cx, cx	;@01E4B
	jmp	short @@11	;@01E4D
@@2:	and	al, 7	;@01E4F
	jmp	short @@4	;@01E51
@@3:	lodsb	;@01E53
	test	al, 80h	;@01E54
	jne	@@6	;@01E56
	shr	al, 1	;@01E58
	shr	al, 1	;@01E5A
	test	al, 10h	;@01E5C
	jne	@@2	;@01E5E
	and	al, 3	;@01E60
@@4:	cmp	al, 3	;@01E62
	je	@@5	;@01E64
	ja	@@11	;@01E66
	cmp	byte ptr [si], 80h	;@01E68
	sbb	si, -2	;@01E6B
	jmp	short @@11	;@01E6E
@@5:	add	si, 2	;@01E70
	jmp	short @@11	;@01E73
@@6:	mov	ah, al	;@01E75
	lodsb	;@01E77
	mov	di, ax	;@01E78
	and	ah, 1Ch	;@01E7A
	cmp	ah, 18h	;@01E7D
	ja	@@7	;@01E80
	and	ah, 18h	;@01E82
	cmp	ah, 8	;@01E85
	jne	@@8	;@01E88
@@7:	inc	cx	;@01E8A
	cmp	byte ptr ds:[3F1h], 1	;@01E8B
	jne	@@8	;@01E90
	and	di, 3Fh	;@01E92
	call	L01DE1	;@01E95
	dec	ax	;@01E98
	add	cx, ax	;@01E99
	jae	@@8	;@01E9B
	jmp	L01E2F	;@01E9D
@@8:	lodsb	;@01E9F
	test	al, 80h	;@01EA0
	jne	@@9	;@01EA2
	cmp	al, 30h	;@01EA4
	jae	@@17	;@01EA6
	cmp	byte ptr [si], 80h	;@01EA8
	sbb	si, -2	;@01EAB
@@9:	not	al	;@01EAE
	test	al, 8	;@01EB0
	je	@@10	;@01EB2
	test	al, 3	;@01EB4
	je	@@16	;@01EB6
	cmp	byte ptr [si], 80h	;@01EB8
	sbb	si, -2	;@01EBB
@@10:	test	al, 4	;@01EBE
	je	@@11	;@01EC0
	add	si, 2	;@01EC2
	add	si, word ptr ds:[16Ah]	;@01EC5
@@11:	cmp	si, word ptr ds:[3E0h]	;@01EC9
	jae	@@12	;@01ECD
	jmp	@@3	;@01ECF
@@12:	mov	bx, word ptr ds:[168h]	;@01ED1
	cmp	bx, -1	;@01ED5
	je	@@14	;@01ED8
	mov	es, word ptr ds:[77Eh]	;@01EDA
	add	word ptr es:[bx+6], cx	;@01EDE
	mov	es, word ptr ds:[776h]	;@01EE2
	mov	ax, word ptr es:[bx+2]	;@01EE6
	cmp	ax, word ptr ds:[44Eh]	;@01EEA
	je	@@13	;@01EEE
	cmp	ax, word ptr ds:[450h]	;@01EF0
	je	@@13	;@01EF4
	add	word ptr ds:[536h], cx	;@01EF6
@@13:	jmp	L059AB	;@01EFA
@@14:	mov	bx, word ptr ds:[162h]	;@01EFD
	cmp	bx, -1	;@01F01
	je	@@15	;@01F04
	mov	es, word ptr ds:[7A6h]	;@01F06
	add	word ptr es:[bx+0Ah], cx	;@01F0A
@@15:	jmp	L059AB	;@01F0E
@@16:	add	si, 2	;@01F11
	add	si, word ptr ds:[16Ah]	;@01F14
	jmp	@@10	;@01F18
@@17:	cmp	al, 40h	;@01F1A
	jae	@@9	;@01F1C
	add	si, 2	;@01F1E
	add	si, word ptr ds:[16Ah]	;@01F21
	jmp	@@9	;@01F25
L01F27:	push	ax	;@01F27
	lodsb	;@01F28
	mov	ah, al	;@01F29
	and	al, 0F0h	;@01F2B
	js	@@2	;@01F2D
	cmp	al, 30h	;@01F2F
	jae	@@1	;@01F31
	cmp	byte ptr [si], 80h	;@01F33
	sbb	si, -2	;@01F36
	jmp	short @@2	;@01F39
@@1:	ja	@@2	;@01F3B
	add	si, 2	;@01F3D
@@2:	test	ah, 8	;@01F40
	jne	@@3	;@01F43
	test	ah, 4	;@01F45
	jne	@@7	;@01F48
	and	ah, 3	;@01F4A
	cmp	ah, 3	;@01F4D
	je	@@5	;@01F50
	cmp	byte ptr [si], 80h	;@01F52
	sbb	si, -2	;@01F55
	mov	cx, word ptr [si]	;@01F58
	add	si, 2	;@01F5A
	cmp	word ptr ds:[41Eh], 0	;@01F5D
	je	@@8	;@01F62
	add	si, 2	;@01F64
	jmp	short @@8	;@01F67
@@3:	test	ah, 4	;@01F69
	jne	@@4	;@01F6C
	mov	cx, word ptr [si]	;@01F6E
	add	si, 2	;@01F70
	cmp	word ptr ds:[41Eh], 0	;@01F73
	je	@@4	;@01F78
	add	si, 2	;@01F7A
@@4:	jmp	short @@8	;@01F7D
@@5:	add	si, 2	;@01F7F
	mov	cx, word ptr [si]	;@01F82
	add	si, 2	;@01F84
	jmp	short @@8	;@01F87
@@6:	add	si, 2	;@01F89
	jmp	short @@8	;@01F8C
@@7:	and	ah, 3	;@01F8E
	cmp	ah, 3	;@01F91
	je	@@6	;@01F94
	cmp	byte ptr [si], 80h	;@01F96
	sbb	si, -2	;@01F99
@@8:	pop	ax	;@01F9C
	ret	;@01F9D
L01F9E:	push	bp	;@01F9E
	mov	bp, sp	;@01F9F
	sub	sp, 4	;@01FA1
	push	dx	;@01FA4
	xor	ax, ax	;@01FA5
	mov	word ptr [bp-2], ax	;@01FA7
	mov	word ptr [bp-4], ax	;@01FAA
	lodsb	;@01FAD
	mov	ah, al	;@01FAE
	and	al, 0F0h	;@01FB0
	js	@@2	;@01FB2
	cmp	al, 30h	;@01FB4
	jae	@@1	;@01FB6
	cmp	byte ptr [si], 80h	;@01FB8
	sbb	si, -2	;@01FBB
	jmp	short @@2	;@01FBE
@@1:	ja	@@2	;@01FC0
	add	si, 2	;@01FC2
@@2:	test	ah, 8	;@01FC5
	jne	@@4	;@01FC8
	test	ah, 4	;@01FCA
	jne	@@8	;@01FCD
	and	ah, 3	;@01FCF
	cmp	ah, 3	;@01FD2
	je	@@6	;@01FD5
	sub	bx, bx	;@01FD7
	add	bl, byte ptr [si]	;@01FD9
	jge	@@3	;@01FDB
	inc	si	;@01FDD
	sub	bl, 80h	;@01FDE
	mov	bh, bl	;@01FE1
	mov	bl, byte ptr [si]	;@01FE3
@@3:	inc	si	;@01FE5
	mov	dx, word ptr [si]	;@01FE6
	mov	word ptr [bp-2], dx	;@01FE8
	add	si, 2	;@01FEB
	cmp	word ptr ds:[41Eh], 0	;@01FEE
	je	@@10	;@01FF3
	mov	dx, word ptr [si]	;@01FF5
	mov	word ptr [bp-4], dx	;@01FF7
	add	si, 2	;@01FFA
	jmp	short @@10	;@01FFD
@@4:	test	ah, 4	;@01FFF
	jne	@@5	;@02002
	mov	dx, word ptr [si]	;@02004
	mov	word ptr [bp-2], dx	;@02006
	add	si, 2	;@02009
	cmp	word ptr ds:[41Eh], 0	;@0200C
	je	@@5	;@02011
	mov	dx, word ptr [si]	;@02013
	mov	word ptr [bp-4], dx	;@02015
	add	si, 2	;@02018
@@5:	mov	bl, ah	;@0201B
	and	bx, 3	;@0201D
	mov	ah, byte ptr [bx+232h]	;@02020
	shl	bx, 1	;@02024
	mov	bx, word ptr [bx+236h]	;@02026
	jmp	short @@10	;@0202A
@@6:	mov	bx, word ptr [si]	;@0202C
	add	si, 4	;@0202E
	jmp	short @@10	;@02031
@@7:	mov	bx, word ptr [si]	;@02033
	add	si, 2	;@02035
	jmp	short @@10	;@02038
@@8:	and	ah, 3	;@0203A
	cmp	ah, 3	;@0203D
	je	@@7	;@02040
	sub	bx, bx	;@02042
	add	bl, byte ptr [si]	;@02044
	jge	@@9	;@02046
	inc	si	;@02048
	sub	bl, 80h	;@02049
	mov	bh, bl	;@0204C
	mov	bl, byte ptr [si]	;@0204E
@@9:	inc	si	;@02050
@@10:	pop	dx	;@02051
	push	dx	;@02052
	and	dh, 1Ch	;@02053
	cmp	dh, 4	;@02056
	je	@@12	;@02059
	cmp	dh, 8	;@0205B
	jne	@@11	;@0205E
	db	0E9h	;@02060
	dw	@@19-$-2		; jmp near ptr @@19: a near jump TASM's one pass would make short + nop
@@11:	cmp	dh, 0Ch	;@02063
	je	@@19	;@02066
	cmp	dh, 14h	;@02068
	je	@@19	;@0206B
	jmp	short @@20	;@0206D
@@12:	cmp	ah, 2	;@0206F
	jne	@@20	;@02072
	dec	bx	;@02074
	shl	bx, 1	;@02075
	add	bx, word ptr ds:[52Ch]	;@02077
	mov	es, word ptr ds:[786h]	;@0207B
	mov	bx, word ptr es:[bx]	;@0207F
	push	bx	;@02082
	and	bx, 3	;@02083
	shl	bx, 1	;@02086
	shl	bx, 1	;@02088
	shl	bx, 1	;@0208A
	mov	es, word ptr [bx+756h]	;@0208C
	pop	bx	;@02090
	push	ax	;@02091
	push	bx	;@02092
	push	si	;@02093
	mov	ax, word ptr es:[bx+0Ch]	;@02094
	mov	si, 460h	;@02098
	mov	bx, 9	;@0209B
@@13:	cmp	ax, word ptr [si]	;@0209E
	je	@@18	;@020A0
	add	si, 2	;@020A2
	dec	bx	;@020A5
	jne	@@13	;@020A6
@@14:	pop	si	;@020A8
	pop	bx	;@020A9
	pop	ax	;@020AA
	mov	ax, word ptr ds:[168h]	;@020AB
	cmp	ax, 0FFFFh	;@020AE
	jne	@@15	;@020B1
	mov	ax, word ptr ds:[162h]	;@020B3
	or	ax, 1	;@020B6
@@15:	push	bx	;@020B9
	mov	bx, word ptr ds:[810h]	;@020BA
	les	di, dword ptr [bx+2]	;@020BE
	add	di, 4	;@020C1
	cmp	di, word ptr [bx]	;@020C4
	jbe	@@16	;@020C6
	call	L05519	;@020C8
	pop	bx	;@020CB
	jae	@@17	;@020CC
	call	TABLE_OVERFLOW	;@020CE
@@16:	xchg	word ptr [bx+2], di	;@020D1
	pop	bx	;@020D4
@@17:	mov	word ptr es:[di], ax	;@020D5
	mov	word ptr es:[di+2], bx	;@020D8
	jmp	short @@20	;@020DC
@@18:	inc	cx	;@020DE
	jmp	@@14	;@020DF
@@19:	inc	cx	;@020E1
@@20:	pop	dx	;@020E2
	mov	sp, bp	;@020E3
	pop	bp	;@020E5
	ret	;@020E6
L020E7:	mov	ax, word ptr ds:[3ECh]	;@020E7
	shl	ax, 1	;@020EA
	mov	word ptr ds:[16Ah], ax	;@020EC
	xor	cx, cx	;@020EF
	jmp	@@8	;@020F1
@@1:	cbw	;@020F4
	mov	di, ax	;@020F5
	and	di, 3	;@020F7
	test	al, 40h	;@020FA
	jne	@@4	;@020FC
	shr	al, 1	;@020FE
	shr	al, 1	;@02100
	and	al, 3	;@02102
	mov	byte ptr [di+232h], al	;@02104
	shl	di, 1	;@02108
	cmp	al, 3	;@0210A
	je	@@3	;@0210C
	sub	bx, bx	;@0210E
	add	bl, byte ptr [si]	;@02110
	jge	@@2	;@02112
	inc	si	;@02114
	sub	bl, 80h	;@02115
	mov	bh, bl	;@02118
	mov	bl, byte ptr [si]	;@0211A
@@2:	inc	si	;@0211C
	mov	word ptr [di+236h], bx	;@0211D
	jmp	short @@8	;@02121
@@3:	mov	bx, word ptr [si]	;@02123
	add	si, 2	;@02125
	mov	word ptr [di+236h], bx	;@02128
	jmp	short @@8	;@0212C
@@4:	shl	al, 1	;@0212E
	shl	al, 1	;@02130
	and	al, 7	;@02132
	mov	byte ptr [di+23Eh], al	;@02134
	shl	di, 1	;@02138
	cmp	al, 3	;@0213A
	je	@@6	;@0213C
	sub	bx, bx	;@0213E
	add	bl, byte ptr [si]	;@02140
	jge	@@5	;@02142
	inc	si	;@02144
	sub	bl, 80h	;@02145
	mov	bh, bl	;@02148
	mov	bl, byte ptr [si]	;@0214A
@@5:	inc	si	;@0214C
	mov	word ptr [di+242h], bx	;@0214D
	jmp	short @@8	;@02151
@@6:	mov	bx, word ptr [si]	;@02153
	add	si, 2	;@02155
	mov	word ptr [di+242h], bx	;@02158
	jmp	short @@8	;@0215C
@@7:	lodsb	;@0215E
	test	al, 80h	;@0215F
	je	@@1	;@02161
	mov	ah, al	;@02163
	lodsb	;@02165
	mov	dx, ax	;@02166
	call	L01F9E	;@02168
	cmp	byte ptr ds:[3F1h], 1	;@0216B
	jne	@@8	;@02170
	mov	di, dx	;@02172
	and	di, 3Fh	;@02174
	call	L01DE1	;@02177
	dec	ax	;@0217A
	add	cx, ax	;@0217B
	jae	@@8	;@0217D
	jmp	L01E2F	;@0217F
@@8:	cmp	si, word ptr ds:[3E0h]	;@02182
	jae	@@9	;@02186
	jmp	@@7	;@02188
@@9:	mov	bx, word ptr ds:[168h]	;@0218A
	cmp	bx, -1	;@0218E
	je	@@11	;@02191
	mov	es, word ptr ds:[77Eh]	;@02193
	add	word ptr es:[bx+6], cx	;@02197
	mov	es, word ptr ds:[776h]	;@0219B
	mov	ax, word ptr es:[bx+2]	;@0219F
	cmp	ax, word ptr ds:[44Eh]	;@021A3
	je	@@10	;@021A7
	cmp	ax, word ptr ds:[450h]	;@021A9
	je	@@10	;@021AD
	add	word ptr ds:[536h], cx	;@021AF
@@10:	jmp	L059AB	;@021B3
@@11:	mov	bx, word ptr ds:[162h]	;@021B6
	cmp	bx, -1	;@021BA
	je	@@12	;@021BD
	mov	es, word ptr ds:[7A6h]	;@021BF
	add	word ptr es:[bx+0Ah], cx	;@021C3
@@12:	jmp	L059AB	;@021C7
; P1_LEDATA: pass 1, LEDATA (A0h).
P1_LEDATA:	sub	bx, bx	;@021CA
	add	bl, byte ptr [si]	;@021CC
	jge	@@1	;@021CE
	inc	si	;@021D0
	sub	bl, 80h	;@021D1
	mov	bh, bl	;@021D4
	mov	bl, byte ptr [si]	;@021D6
@@1:	inc	si	;@021D8
	cmp	bx, 4000h	;@021D9
	jg	@@2	;@021DD
	dec	bx	;@021DF
	xchg	ax, bx	;@021E0
	mov	ah, 0Ah	;@021E1
	mul	ah	;@021E3
	xchg	ax, bx	;@021E5
	add	bx, word ptr ds:[52Ah]	;@021E6
	mov	word ptr ds:[168h], bx	;@021EA
	mov	byte ptr ds:[3F1h], 0	;@021EE
	jmp	L059AB	;@021F3
@@2:	call	L093A1	;@021F6
	jb	@@4	;@021F9
	mov	word ptr ds:[168h], 0FFFFh	;@021FB
@@3:	mov	word ptr ds:[162h], bx	;@02201
	mov	byte ptr ds:[3F1h], 0	;@02205
	jmp	L059AB	;@0220A
@@4:	cmp	bx, -1	;@0220D
	je	@@5	;@02210
	mov	bx, 0FFFFh	;@02212
	jmp	@@3	;@02215
@@5:	call	L0885D	;@02217
; P1_LIDATA: pass 1, LIDATA (A2h).
P1_LIDATA:	mov	byte ptr ds:[3F1h], 1	;@0221A
	sub	bx, bx	;@0221F
	add	bl, byte ptr [si]	;@02221
	jge	@@1	;@02223
	inc	si	;@02225
	sub	bl, 80h	;@02226
	mov	bh, bl	;@02229
	mov	bl, byte ptr [si]	;@0222B
@@1:	inc	si	;@0222D
	dec	bx	;@0222E
	xchg	ax, bx	;@0222F
	mov	ah, 0Ah	;@02230
	mul	ah	;@02232
	xchg	ax, bx	;@02234
	add	bx, word ptr ds:[52Ah]	;@02235
	mov	word ptr ds:[168h], bx	;@02239
	mov	es, word ptr ds:[776h]	;@0223D
	test	byte ptr es:[bx+9], 0E0h	;@02241
	je	@@4	;@02246
	mov	word ptr ds:[3E6h], bx	;@02248
	lodsw	;@0224C
	cmp	word ptr ds:[41Eh], 0	;@0224D
	je	@@2	;@02252
	lodsw	;@02254
@@2:	mov	cx, word ptr ds:[3E0h]	;@02255
	sub	cx, si	;@02259
	mov	word ptr ds:[3E4h], cx	;@0225B
	push	ds	;@0225F
	pop	es	;@02260
	mov	di, 0C4Eh	;@02261
	shr	cx, 1	;@02264
	rep movsw	;@02266
	rcl	cx, 1	;@02268
	rep movsb	;@0226A
@@3:	jmp	L059AB	;@0226C
@@4:	mov	byte ptr ds:[3F1h], 0FFh	;@0226F
	jmp	@@3	;@02274
; LIBRARY_HEADER: a library's header record (F0h, also A4h), both passes.
LIBRARY_HEADER:	mov	ax, word ptr ds:[3E0h]	;@02276
	sub	ax, si	;@02279
	add	ax, 4	;@0227B
	mov	di, word ptr ds:[494h]	;@0227E
	mov	word ptr [di+6], ax	;@02282
	mov	word ptr ds:[3462h], ax	;@02285
	lodsw	;@02288
	mov	word ptr ds:[3464h], ax	;@02289
	mov	word ptr [di+2], ax	;@0228C
	xchg	ax, dx	;@0228F
	lodsw	;@02290
	mov	word ptr ds:[3466h], ax	;@02291
	mov	word ptr [di+4], ax	;@02294
	xchg	ax, cx	;@02297
	mov	byte ptr ds:[161h], 1	;@02298
	mov	byte ptr ds:[3D2h], 2	;@0229D
	cmp	byte ptr ds:[3D5h], 1	;@022A2
	je	@@1	;@022A7
	cmp	byte ptr ds:[3D5h], 4	;@022A9
	je	@@1	;@022AE
	dec	byte ptr ds:[3D2h]	;@022B0
@@1:	cmp	byte ptr ds:[254h], 0	;@022B4
	jne	@@2	;@022B9
	call	L04466	;@022BB
	jb	@@2	;@022BE
	ret	;@022C0
@@2:	jmp	L059AB	;@022C1
L022C4:	push	bp	;@022C4
	mov	bp, sp	;@022C5
	sub	sp, 0Ah	;@022C7
	or	al, 8	;@022CA
	mov	byte ptr [bp-2], al	;@022CC
	jmp	short @@2	;@022CF
@@1:	mov	sp, bp	;@022D1
	pop	bp	;@022D3
	jmp L059AB	;@022D4
@@2:	cmp	si, word ptr ds:[3E0h]	;@022D7
	jae	@@1	;@022DB
	test	byte ptr [bp-2], 4	;@022DD
	je	@@3	;@022E1
	call	L01452	;@022E3
@@3:	mov	ah, 0	;@022E6
	call L0910B	;@022E8
	push	bx	;@022EB
	cmp	byte ptr [si], 80h	;@022EC
	sbb	si, -2	;@022EF
	lodsb	;@022F2
	mov	ah, 0	;@022F3
	cmp	al, 60h	;@022F5
	ja	@@4	;@022F7
	dec	ax	;@022F9
	nop	;@022FA
	mov	ah, 0Ah	;@022FB
	mul	ah	;@022FD
	nop	;@022FF
	add	ax, word ptr ds:[52Ah]	;@02300
	jmp	short @@5	;@02304
@@4:	sub	ax, 63h	;@02306
@@5:	mov	word ptr [bp-6], ax	;@02309
	push	bx	;@0230C
	xor	ax, ax	;@0230D
	mov	dx, ax	;@0230F
	lodsb	;@02311
	mov	bx, ax	;@02312
	cmp	bl, 81h	;@02314
	jb	@@8	;@02317
	lodsw	;@02319
	cmp	bl, 81h	;@0231A
	je	@@8	;@0231D
	xchg	ax, dx	;@0231F
	cmp	bl, 84h	;@02320
	jne	@@6	;@02323
	lodsb	;@02325
	jmp	short @@7	;@02326
@@6:	lodsw	;@02328
@@7:	xchg	ax, dx	;@02329
@@8:	pop	bx	;@0232A
	cmp	word ptr [bp-6], -2	;@0232B
	jne	@@12	;@0232F
	push	dx	;@02331
	push	ax	;@02332
	push	bx	;@02333
	xor	ax, ax	;@02334
	mov	dx, ax	;@02336
	lodsb	;@02338
	mov	bx, ax	;@02339
	cmp	bl, 81h	;@0233B
	jb	@@11	;@0233E
	lodsw	;@02340
	cmp	bl, 81h	;@02341
	je	@@11	;@02344
	xchg	ax, dx	;@02346
	cmp	bl, 84h	;@02347
	jne	@@9	;@0234A
	lodsb	;@0234C
	jmp	short @@10	;@0234D
@@9:	lodsw	;@0234F
@@10:	xchg	ax, dx	;@02350
@@11:	pop	bx	;@02351
	pop	bx	;@02352
	pop	cx	;@02353
	call	far ptr F_LXMUL@	;@02354
@@12:	mov	word ptr [bp-8], ax	;@02359
	mov	word ptr [bp-0Ah], dx	;@0235C
	pop	bx	;@0235F
	cmp	word ptr es:[bx], -1	;@02360
	je	@@13	;@02364
	jmp	@@21	;@02366
@@13:	call	L017D8	;@02369
	mov	word ptr es:[di+0Ch], bx	;@0236C
@@14:	mov	word ptr ds:[176h], di	;@02370
	mov	ax, word ptr [bp-6]	;@02374
	mov	word ptr es:[di], ax	;@02377
	mov	ax, word ptr ds:[186h]	;@0237A
	mov	word ptr es:[di+2], ax	;@0237D
	mov	al, byte ptr [bp-2]	;@02381
	mov	byte ptr es:[di+0Eh], al	;@02384
@@15:	push	di	;@02388
	push	word ptr es:[di+0Ah]	;@02389
	les	di, dword ptr ds:[7A4h]	;@0238D
	add	di, 0Ch	;@02391
	cmp	di, word ptr ds:[7A2h]	;@02394
	jbe	@@16	;@02398
	mov	di, 0Ch	;@0239A
	push	di	;@0239D
	mov	di, 7A2h	;@0239E
	call	L054ED	;@023A1
	jae	@@17	;@023A4
	call	TABLE_OVERFLOW	;@023A6
@@16:	xchg	word ptr ds:[7A4h], di	;@023A9
@@17:	push	di	;@023AD
	xor	ax, ax	;@023AE
	mov	cx, 0Ch	;@023B0
	cld	;@023B3
	rep stosb	;@023B4
	pop	di	;@023B6
	pop	word ptr es:[di]	;@023B7
	mov	ax, word ptr ds:[186h]	;@023BA
	mov	word ptr es:[di+2], ax	;@023BD
	mov	ax, word ptr [bp-8]	;@023C1
	mov	word ptr es:[di+6], ax	;@023C4
	mov	ax, word ptr [bp-0Ah]	;@023C8
	mov	word ptr es:[di+8], ax	;@023CB
	mov	ax, word ptr [bp-6]	;@023CF
	mov	word ptr es:[di+4], ax	;@023D2
	mov	ax, di	;@023D6
	pop	di	;@023D8
	push	di	;@023D9
	and	di, 3	;@023DA
	shl	di, 1	;@023DD
	shl	di, 1	;@023DF
	shl	di, 1	;@023E1
	mov	es, word ptr [di+756h]	;@023E3
	pop	di	;@023E7
	xchg	word ptr es:[di+0Ah], ax	;@023E8
	cmp	ax, 0FFFFh	;@023EC
	jne	@@18	;@023EF
	push	bx	;@023F1
	and	bx, 3	;@023F2
	shl	bx, 1	;@023F5
	shl	bx, 1	;@023F7
	shl	bx, 1	;@023F9
	mov	es, word ptr [bx+716h]	;@023FB
	pop	bx	;@023FF
	mov	word ptr es:[bx], di	;@02400
@@18:	mov	ax, di	;@02403
	les	di, dword ptr ds:[784h]	;@02405
	add	di, 2	;@02409
	cmp	di, word ptr ds:[782h]	;@0240C
	jbe	@@19	;@02410
	mov	di, 2	;@02412
	push	di	;@02415
	mov	di, 782h	;@02416
	call	L054ED	;@02419
	jae	@@20	;@0241C
	call	TABLE_OVERFLOW	;@0241E
@@19:	xchg	word ptr ds:[784h], di	;@02421
@@20:	mov	word ptr ds:[188h], di	;@02425
	mov	word ptr es:[di], ax	;@02429
	mov	word ptr ds:[174h], bx	;@0242C
	jmp	@@2	;@02430
@@21:	mov	di, word ptr es:[bx]	;@02433
	push	di	;@02436
	and	di, 3	;@02437
	shl	di, 1	;@0243A
	shl	di, 1	;@0243C
	shl	di, 1	;@0243E
	mov	es, word ptr [di+756h]	;@02440
	pop	di	;@02444
	test	byte ptr es:[di+0Eh], 18h	;@02445
	je	@@18	;@0244A
	test	byte ptr es:[di+0Eh], 8	;@0244C
	jne	@@22	;@02451
	jmp	@@14	;@02453
@@22:	cmp	word ptr [bp-6], -2	;@02456
	jb	@@23	;@0245A
	cmp	word ptr es:[di], -2	;@0245C
	jb	@@24	;@02460
	jmp	@@15	;@02462
@@23:	cmp	word ptr es:[di], -2	;@02465
	jae	@@24	;@02469
	jmp	@@15	;@0246B
@@24:	push	si	;@0246E
	push	di	;@0246F
	mov	word ptr ds:[422h], 1	;@02470
	mov	di, word ptr es:[di+0Ah]	;@02476
	mov	es, word ptr ds:[7A6h]	;@0247A
	push	word ptr es:[di+2]	;@0247E
	mov	si, bx	;@02482
	mov	di, 26h	;@02484
	call COPY_NAME	;@02487
	pop	si	;@0248A
	push	si	;@0248B
	and	si, 3	;@0248C
	shl	si, 1	;@0248F
	shl	si, 1	;@02491
	shl	si, 1	;@02493
	mov	es, word ptr [si+736h]	;@02495
	pop	si	;@02499
	mov	si, word ptr es:[si]	;@0249A
	mov	di, 76h	;@0249D
	call COPY_NAME	;@024A0
	mov	ds, word ptr cs:DATA_SEGMENT	;@024A3
	push	ds	;@024A8
	mov	ax, 76h	;@024A9
	push	ax	;@024AC
	push	ds	;@024AD
	mov	ax, 26h	;@024AE
	push	ax	;@024B1
	mov	cx, 8	;@024B2
	push	cx	;@024B5
	mov	ax, 33h	;@024B6
	push	ax	;@024B9
	call WARNING	;@024BA
	pop	di	;@024BD
	pop	si	;@024BE
	jmp	@@2	;@024BF
; P1_COMDEF: pass 1, COMDEF (B0h): communal names.
P1_COMDEF:	sub	ax, ax	;@024C2
	jmp	L022C4	;@024C4
; P1_LCOMDEF: pass 1, LCOMDEF (B8h).
P1_LCOMDEF:	mov	ax, 4	;@024C7
	jmp	L022C4	;@024CA
	db	0, 0, 0, '%s:%x', 0, '%s:%x%x', 0	;@024CD
L024DE:	push	bp	;@024DE
	mov	bp, sp	;@024DF
	sub	sp, 82h	;@024E1
	inc	word ptr ds:[4EAh]	;@024E5
	push	ds	;@024E9
	pop	es	;@024EA
	mov	di, 2A0h	;@024EB
	mov	cx, 10h	;@024EE
	xor	ax, ax	;@024F1
	rep stosb	;@024F3
	mov	si, word ptr ds:[528h]	;@024F5
	push	si	;@024F9
	and	si, 3	;@024FA
	shl	si, 1	;@024FD
	shl	si, 1	;@024FF
	shl	si, 1	;@02501
	mov	es, word ptr [si+716h]	;@02503
	pop	si	;@02507
	add	si, 2	;@02508
	xor	ax, ax	;@0250B
	call	L05327	;@0250D
	mov	word ptr ds:[22Ah], ax	;@02510
	cmp	byte ptr ds:[3D2h], 1	;@02513
	jae	@@5	;@02518
	push	ds	;@0251A
	pop	es	;@0251B
	mov	di, 54BBh	;@0251C
	mov	si, di	;@0251F
	xor	al, al	;@02521
	mov	cx, 0FFFFh	;@02523
	repne scasb	;@02526
	sub	di, 5	;@02528
	xor	cx, cx	;@0252B
@@1:	cmp	si, di	;@0252D
	je	@@2	;@0252F
	mov	al, byte ptr es:[di-1]	;@02531
	cmp	al, 5Ch	;@02535
	je	@@2	;@02537
	cmp	al, 3Ah	;@02539
	je	@@2	;@0253B
	cmp	al, 2Fh	;@0253D
	je	@@2	;@0253F
	dec	di	;@02541
	inc	cx	;@02542
	jmp	@@1	;@02543
@@2:	mov	si, di	;@02545
	mov	ax, es	;@02547
	mov	ds, ax	;@02549
	mov	ax, ss	;@0254B
	mov	es, ax	;@0254D
	lea	di, [bp-82h]	;@0254F
	push	es	;@02553
	push	di	;@02554
	mov	al, cl	;@02555
	stosb	;@02557
@@3:	lodsb	;@02558
	cmp	al, 61h	;@02559
	jb	@@4	;@0255B
	cmp	al, 7Ah	;@0255D
	ja	@@4	;@0255F
	sub	al, 20h	;@02561
@@4:	stosb	;@02563
	dec	cl	;@02564
	jne	@@3	;@02566
	pop	si	;@02568
	pop	es	;@02569
	mov	ds, word ptr cs:DATA_SEGMENT	;@0256A
	xor	ax, ax	;@0256F
	call	L05327	;@02571
@@5:	mov	di, 2A0h	;@02574
	mov	word ptr [di], ax	;@02577
	mov	si, 528h	;@02579
	xor	ax, ax	;@0257C
	mov	bx, ax	;@0257E
	mov	cx, ax	;@02580
	mov	dx, ax	;@02582
	mov	word ptr [bp-2], ax	;@02584
	cmp	byte ptr [si+10h], 0	;@02587
	je	@@8	;@0258B
	mov	ax, word ptr [si+24h]	;@0258D
	and	ax, ax	;@02590
	je	@@6	;@02592
	mov	bx, word ptr ds:[4F2h]	;@02594
	inc	bx	;@02598
@@6:	mov	cx, word ptr [si+28h]	;@02599
	jcxz	@@7	;@0259C
	mov	dx, word ptr ds:[4F6h]	;@0259E
	inc	dx	;@025A2
@@7:	push	ax	;@025A3
	mov	ax, word ptr [si+30h]	;@025A4
	mov	word ptr [bp-2], ax	;@025A7
	pop	ax	;@025AA
	and	word ptr [bp-2], 0FF7Fh	;@025AB
@@8:	mov	word ptr [di+0Ah], ax	;@025B0
	mov	word ptr [di+8], bx	;@025B3
	mov	word ptr [di+0Eh], cx	;@025B6
	mov	word ptr [di+0Ch], dx	;@025B9
	mov	ax, word ptr [bp-2]	;@025BC
	mov	word ptr [di+2], ax	;@025BF
	mov	ax, word ptr ds:[508h]	;@025C2
	inc	ax	;@025C5
	mov	word ptr ds:[2B4h], ax	;@025C6
	mov	ax, word ptr ds:[50Eh]	;@025C9
	inc	ax	;@025CC
	mov	word ptr ds:[2B0h], ax	;@025CD
	mov	ax, word ptr ds:[4E4h]	;@025D0
	inc	ax	;@025D3
	mov	word ptr ds:[39Dh], ax	;@025D4
	mov	ax, word ptr ds:[4F2h]	;@025D7
	mov	word ptr ds:[39Fh], ax	;@025DA
	xor	ax, ax	;@025DD
	mov	word ptr ds:[385h], ax	;@025DF
	mov	word ptr ds:[365h], ax	;@025E2
	mov	word ptr ds:[387h], ax	;@025E5
	mov	word ptr ds:[389h], ax	;@025E8
	mov	word ptr ds:[367h], ax	;@025EB
	mov	word ptr ds:[38Bh], ax	;@025EE
	mov	word ptr ds:[383h], ax	;@025F1
	mov	word ptr ds:[178h], ax	;@025F4
	mov	word ptr ds:[38Dh], ax	;@025F7
	dec	ax	;@025FA
	mov	word ptr ds:[393h], ax	;@025FB
	mov	word ptr ds:[17Ah], ax	;@025FE
	mov	word ptr ds:[39Bh], ax	;@02601
	mov	sp, bp	;@02604
	pop	bp	;@02606
	ret	;@02607
; P2_THEADR: pass 2, THEADR (80h).
P2_THEADR:	cmp	byte ptr ds:[492h], 0	;@02608
	je	@@1	;@0260D
	mov	si, word ptr ds:[3E0h]	;@0260F
	jmp	L059AB	;@02613
@@1:	dec	byte ptr ds:[492h]	;@02616
	mov	si, word ptr ds:[3E2h]	;@0261A
	mov	word ptr ds:[228h], si	;@0261E
	push	si	;@02622
	and	si, 3	;@02623
	shl	si, 1	;@02626
	shl	si, 1	;@02628
	shl	si, 1	;@0262A
	mov	es, word ptr [si+736h]	;@0262C
	pop	si	;@02630
	mov	bl, byte ptr es:[si+10h]	;@02631
	mov	bh, 0	;@02635
	mov	cx, word ptr cs:L05780[bx]	;@02637
	mov	ax, 38h	;@0263C
	sub	ax, cx	;@0263F
	add	word ptr ds:[3E2h], cx	;@02641
	cmp	word ptr es:[si+0Ah], 2	;@02645
	jb	@@3	;@0264A
	mov	di, 528h	;@0264C
	push	es	;@0264F
	push	ds	;@02650
	pop	es	;@02651
	pop	ds	;@02652
	shr	cx, 1	;@02653
	rep movsw	;@02655
	rcl	cx, 1	;@02657
	rep movsb	;@02659
	xchg	ax, cx	;@0265B
	rep stosb	;@0265C
	push	es	;@0265E
	push	ds	;@0265F
	pop	es	;@02660
	pop	ds	;@02661
	mov	al, byte ptr ds:[53Dh]	;@02662
	mov	byte ptr ds:[411h], al	;@02665
	cmp	byte ptr ds:[14h], 0	;@02668
	je	@@2	;@0266D
	push	word ptr ds:[120h]	;@0266F
	mov	byte ptr ds:[120h], 0	;@02673
	call	L024DE	;@02678
	pop	ax	;@0267B
	mov	byte ptr ds:[120h], al	;@0267C
@@2:	jmp	L059AB	;@0267F
@@3:	mov	si, word ptr ds:[3E0h]	;@02682
	inc	si	;@02686
@@4:	mov	cx, word ptr ds:[3458h]	;@02687
	sub	cx, si	;@0268B
	cmp	cx, 3	;@0268D
	jae	@@5	;@02690
	call	L087E1	;@02692
	jmp	@@4	;@02695
@@5:	mov	bl, byte ptr [si]	;@02697
	inc	si	;@02699
	lodsw	;@0269A
@@6:	mov	cx, word ptr ds:[3458h]	;@0269B
	sub	cx, si	;@0269F
	cmp	cx, ax	;@026A1
	jae	@@7	;@026A3
	call	L087E1	;@026A5
	jmp	@@6	;@026A8
@@7:	mov	di, si	;@026AA
	add	di, ax	;@026AC
	dec	di	;@026AE
	mov	word ptr ds:[3E0h], di	;@026AF
	cmp	bl, 8Ah	;@026B3
	jne	@@3	;@026B6
	jmp	L03CE3	;@026B8
L026BB:	push	di	;@026BB
	push	ds	;@026BC
	pop	es	;@026BD
	push	si	;@026BE
	call	L05327	;@026BF
	pop	si	;@026C2
	mov	bx, ax	;@026C3
	lodsb	;@026C5
	cbw	;@026C6
	add	si, ax	;@026C7
	mov	ax, bx	;@026C9
	pop	di	;@026CB
	ret	;@026CC
L026CD:	mov	ah, 0	;@026CD
	call	L0910B	;@026CF
	cmp	word ptr es:[bx], -1	;@026D2
	je	@@1	;@026D6
	push	bx	;@026D8
	and	bx, 3	;@026D9
	shl	bx, 1	;@026DC
	shl	bx, 1	;@026DE
	shl	bx, 1	;@026E0
	mov	es, word ptr [bx+716h]	;@026E2
	pop	bx	;@026E6
	mov	bx, word ptr es:[bx]	;@026E7
	push	bx	;@026EA
	and	bx, 3	;@026EB
	shl	bx, 1	;@026EE
	shl	bx, 1	;@026F0
	shl	bx, 1	;@026F2
	mov	es, word ptr [bx+756h]	;@026F4
	pop	bx	;@026F8
	mov	ax, word ptr es:[bx+12h]	;@026F9
	ret	;@026FD
@@1:	xor	ax, ax	;@026FE
	ret	;@02700
; P2_COMENT_E2: pass 2, Borland COMENT class E2h (debug information).
P2_COMENT_E2:	xor	dx, dx	;@02701
L02703:	jmp	short @@6	;@02703
@@1:	inc	word ptr ds:[4E4h]	;@02705
	mov	di, 290h	;@02709
	lodsb	;@0270C
	mov	byte ptr [di], al	;@0270D
	cmp	al, 40h	;@0270F
	je	@@7	;@02711
	cmp	al, 0C0h	;@02713
	je	@@7	;@02715
	push	si	;@02717
	lodsb	;@02718
	cbw	;@02719
	and	ax, ax	;@0271A
	je	@@2	;@0271C
	dec	si	;@0271E
	push	dx	;@0271F
	xor	ax, ax	;@02720
	call	L026BB	;@02722
	pop	dx	;@02725
@@2:	pop	bx	;@02726
	mov	word ptr [di+1], ax	;@02727
	and	dx, dx	;@0272A
	jne	@@8	;@0272C
	cmp	byte ptr [di], 60h	;@0272E
	je	@@9	;@02731
	sub	bx, bx	;@02733
	add	bl, byte ptr [si]	;@02735
	jge	@@3	;@02737
	inc	si	;@02739
	sub	bl, 80h	;@0273A
	mov	bh, bl	;@0273D
	mov	bl, byte ptr [si]	;@0273F
@@3:	inc	si	;@02741
	cmp	bx, 18h	;@02742
	jb	@@4	;@02745
	add	bx, word ptr ds:[38Fh]	;@02747
@@4:	mov	word ptr [di+3], bx	;@0274B
@@5:	push	dx	;@0274E
	push	si	;@0274F
	mov	si, di	;@02750
	mov	cx, 5	;@02752
	mov	bp, 47Eh	;@02755
	mov	bx, 325h	;@02758
	call	L051DC	;@0275B
	pop	si	;@0275E
	pop	dx	;@0275F
@@6:	cmp	si, word ptr ds:[3E0h]	;@02760
	jb	@@1	;@02764
	ret	;@02766
@@7:	lodsw	;@02767
	mov	word ptr [di+1], ax	;@02768
	lodsw	;@0276B
	mov	word ptr [di+3], ax	;@0276C
	jmp	@@5	;@0276F
@@8:	lodsw	;@02771
	mov	bx, ax	;@02772
	jmp	@@4	;@02774
@@9:	push	si	;@02776
	push	di	;@02777
	push	dx	;@02778
	mov	si, bx	;@02779
	call	L026CD	;@0277B
	mov	bx, ax	;@0277E
	pop	dx	;@02780
	pop	di	;@02781
	pop	si	;@02782
	cmp	byte ptr [si], 80h	;@02783
	sbb	si, -2	;@02786
	jmp	@@4	;@02789
; P2_COMENT_E4: pass 2, Borland COMENT class E4h (debug information).
P2_COMENT_E4:	mov	dx, 1	;@0278B
	jmp	L02703	;@0278E

; COMENT subtypes: (type, handler) for 20 types, then the handler for any other
P2_TYPE_HANDLERS	db	23h	;@02791
	dw	L02869
	db	1Eh
	dw	L02846
	db	1Fh
	dw	L02846
	db	15h
	dw	L02884
	db	16h
	dw	L02884
	db	1Ah
	dw	L0284D
	db	22h
	dw	L028A4
	db	24h
	dw	L028A1
	db	2Eh
	dw	L0290C
	db	34h
	dw	L02884
	db	35h
	dw	L02884
	db	2Dh
	dw	L02932
	db	33h
	dw	L0298E
	db	20h
	dw	L02822
	db	21h
	dw	L02822
	db	17h
	dw	L02884
	db	30h
	dw	L028E6
	db	18h
	dw	L02884
	db	19h
	dw	L02884
	db	1Bh
	dw	L02828
	dw	L028BD
; P2_COMENT_E3: pass 2, Borland COMENT class E3h (debug information).
P2_COMENT_E3:	mov	di, 290h	;@027CF
	xor	ax, ax	;@027D2
	push	ds	;@027D4
	pop	es	;@027D5
	mov	cx, 4	;@027D6
	rep stosw	;@027D9
	sub	bx, bx	;@027DB
	add	bl, byte ptr [si]	;@027DD
	jge	@@1	;@027DF
	inc	si	;@027E1
	sub	bl, 80h	;@027E2
	mov	bh, bl	;@027E5
	mov	bl, byte ptr [si]	;@027E7
@@1:	inc	si	;@027E9
	push	bx	;@027EA
	lodsb	;@027EB
	cbw	;@027EC
	and	ax, ax	;@027ED
	je	@@2	;@027EF
	dec	si	;@027F1
	xor	ax, ax	;@027F2
	call	L026BB	;@027F4
@@2:	mov	bx, 290h	;@027F7
	mov	word ptr [bx+1], ax	;@027FA
	lodsw	;@027FD
	mov	word ptr [bx+3], ax	;@027FE
	lodsb	;@02801
	mov	byte ptr [bx], al	;@02802
	mov	di, offset P2_TYPE_HANDLERS	;@02804
	push	cs	;@02807
	pop	es	;@02808
	mov	cx, 14h	;@02809
@@3:	scasb	;@0280C
	je	@@4	;@0280D
	scasw	;@0280F
	loop	@@3	;@02810
@@4:	push	word ptr es:[di]	;@02812
	push	ds	;@02815
	pop	es	;@02816
	lea	di, [bx+5]	;@02817
	mov	cx, 8	;@0281A
	mov	dx, word ptr ds:[38Fh]	;@0281D
	ret	;@02821
L02822:	movsw	;@02822
	mov	cx, 10h	;@02823
	jmp	short L02847	;@02826
L02828:	movsw	;@02828
	mov	cx, 10h	;@02829
	sub	bx, bx	;@0282C
	add	bl, byte ptr [si]	;@0282E
	jge	@@1	;@02830
	inc	si	;@02832
	sub	bl, 80h	;@02833
	mov	bh, bl	;@02836
	mov	bl, byte ptr [si]	;@02838
@@1:	inc	si	;@0283A
	mov	word ptr [di], bx	;@0283B
	cmp	bx, 18h	;@0283D
	jb	L028BD	;@02840
	add	word ptr [di], dx	;@02842
	jmp	short L028BD	;@02844
L02846:	inc	di	;@02846
L02847:	mov	ax, word ptr ds:[39Dh]	;@02847
	stosw	;@0284A
	jmp	short L028B6	;@0284B
L0284D:	sub	bx, bx	;@0284D
	add	bl, byte ptr [si]	;@0284F
	jge	@@1	;@02851
	inc	si	;@02853
	sub	bl, 80h	;@02854
	mov	bh, bl	;@02857
	mov	bl, byte ptr [si]	;@02859
@@1:	inc	si	;@0285B
	mov	word ptr [di+1], bx	;@0285C
	cmp	bx, 18h	;@0285F
	jb	L028BD	;@02862
	add	word ptr [di+1], dx	;@02864
	jmp	short L028BD	;@02867
L02869:	sub	bx, bx	;@02869
	add	bl, byte ptr [si]	;@0286B
	jge	@@1	;@0286D
	inc	si	;@0286F
	sub	bl, 80h	;@02870
	mov	bh, bl	;@02873
	mov	bl, byte ptr [si]	;@02875
@@1:	inc	si	;@02877
	push	bx	;@02878
	lodsw	;@02879
	ror	ah, 1	;@0287A
	and	ah, 80h	;@0287C
	or	al, ah	;@0287F
	stosb	;@02881
	jmp	short L02895	;@02882
L02884:	sub	bx, bx	;@02884
	add	bl, byte ptr [si]	;@02886
	jge	@@1	;@02888
	inc	si	;@0288A
	sub	bl, 80h	;@0288B
	mov	bh, bl	;@0288E
	mov	bl, byte ptr [si]	;@02890
@@1:	inc	si	;@02892
	push	bx	;@02893
	movsb	;@02894
L02895:	pop	ax	;@02895
	stosw	;@02896
	cmp	ax, 18h	;@02897
	jb	L028BD	;@0289A
	add	word ptr [di-2], dx	;@0289C
	jmp	short L028BD	;@0289F
L028A1:	movsb	;@028A1
	jmp	short L028BD	;@028A2
L028A4:	cmp	byte ptr [si], 80h	;@028A4
	sbb	si, -2	;@028A7
	mov	cx, 10h	;@028AA
	add	di, 3	;@028AD
	movsw	;@028B0
	movsw	;@028B1
	mov	ax, word ptr ds:[39Dh]	;@028B2
	stosw	;@028B5
L028B6:	mov	ax, word ptr ds:[4E4h]	;@028B6
	inc	ax	;@028B9
	mov	word ptr ds:[39Dh], ax	;@028BA
L028BD:	pop	ax	;@028BD
L028BE:	sub	ax, 18h	;@028BE
	mov	di, cx	;@028C1
	push	cx	;@028C3
	mov	cl, 3	;@028C4
	shl	ax, cl	;@028C6
	shr	di, cl	;@028C8
	add	word ptr ds:[4E2h], di	;@028CA
	pop	cx	;@028CE
	push	si	;@028CF
	mov	si, 290h	;@028D0
	mov	dx, word ptr ds:[323h]	;@028D3
	add	ax, word ptr ds:[321h]	;@028D7
	adc	dx, 0	;@028DB
	mov	bx, 47Eh	;@028DE
	call	L08AC5	;@028E1
	pop	si	;@028E4
	ret	;@028E5
L028E6:	sub	bx, bx	;@028E6
	add	bl, byte ptr [si]	;@028E8
	jge	@@1	;@028EA
	inc	si	;@028EC
	sub	bl, 80h	;@028ED
	mov	bh, bl	;@028F0
	mov	bl, byte ptr [si]	;@028F2
@@1:	inc	si	;@028F4
	push	bx	;@028F5
	xor	al, al	;@028F6
	stosb	;@028F8
	push	di	;@028F9
	push	dx	;@028FA
	push	es	;@028FB
	xor	ax, ax	;@028FC
	call	L026BB	;@028FE
	pop	es	;@02901
	pop	dx	;@02902
	pop	di	;@02903
	mov	word ptr [di+2], ax	;@02904
	mov	cx, 10h	;@02907
	jmp	L02895	;@0290A
L0290C:	mov	ax, word ptr [bx+1]	;@0290C
	mov	word ptr ds:[3A5h], ax	;@0290F
	sub	bx, bx	;@02912
	add	bl, byte ptr [si]	;@02914
	jge	@@1	;@02916
	inc	si	;@02918
	sub	bl, 80h	;@02919
	mov	bh, bl	;@0291C
	mov	bl, byte ptr [si]	;@0291E
@@1:	inc	si	;@02920
	add	bx, word ptr ds:[3A1h]	;@02921
	mov	word ptr ds:[3A3h], bx	;@02925
	mov	word ptr [di+1], bx	;@02929
	pop	ax	;@0292C
	mov	word ptr ds:[22Ch], ax	;@0292D
	jmp	L028BE	;@02930
L02932:	lodsb	;@02932
	cbw	;@02933
	and	al, al	;@02934
	jns	@@1	;@02936
	sub	al, 80h	;@02938
	mov	ah, al	;@0293A
	lodsb	;@0293C
@@1:	movsb	;@0293D
	cmp	ax, 18h	;@0293E
	jb	@@2	;@02941
	add	ax, dx	;@02943
@@2:	stosw	;@02945
	lodsb	;@02946
	mov	cl, al	;@02947
	test	al, 1	;@02949
	je	@@7	;@0294B
	lodsb	;@0294D
	cbw	;@0294E
	and	al, al	;@0294F
	jns	@@3	;@02951
	sub	al, 80h	;@02953
	mov	ah, al	;@02955
	lodsb	;@02957
@@3:	add	ax, dx	;@02958
	stosw	;@0295A
	lodsb	;@0295B
	cbw	;@0295C
	and	al, al	;@0295D
	jns	@@4	;@0295F
	sub	al, 80h	;@02961
	mov	ah, al	;@02963
	lodsb	;@02965
@@4:	shl	ax, 1	;@02966
	stosw	;@02968
	xor	ax, ax	;@02969
	test	cl, 8	;@0296B
	jne	@@5	;@0296E
	push	di	;@02970
	push	cx	;@02971
	call	L026CD	;@02972
	pop	cx	;@02975
	pop	di	;@02976
	push	ds	;@02977
	pop	es	;@02978
@@5:	stosw	;@02979
@@6:	xor	ax, ax	;@0297A
	mov	ah, cl	;@0297C
	mov	cl, 4	;@0297E
	shl	ah, cl	;@02980
	stosw	;@02982
	mov	cx, 10h	;@02983
	jmp	L028BD	;@02986
@@7:	add	di, 6	;@02989
	jmp	@@6	;@0298C
L0298E:	inc	di	;@0298E
	lodsb	;@0298F
	cbw	;@02990
	and	al, al	;@02991
	jns	@@1	;@02993
	sub	al, 80h	;@02995
	mov	ah, al	;@02997
	lodsb	;@02999
@@1:	cmp	ax, 18h	;@0299A
	jb	@@2	;@0299D
	add	ax, dx	;@0299F
@@2:	stosw	;@029A1
	lodsb	;@029A2
	cbw	;@029A3
	and	al, al	;@029A4
	jns	@@3	;@029A6
	sub	al, 80h	;@029A8
	mov	ah, al	;@029AA
	lodsb	;@029AC
@@3:	add	ax, word ptr ds:[3A1h]	;@029AD
	stosw	;@029B1
	mov	cx, 10h	;@029B2
	jmp	L028BD	;@029B5
L029B8:	push	ax	;@029B8
	push	es	;@029B9
	mov	es, word ptr ds:[37Dh]	;@029BA
	mov	al, byte ptr es:[si+8]	;@029BE
	mov	ah, byte ptr es:[di+8]	;@029C2
	and	ax, 303h	;@029C6
	cmp	ah, al	;@029C9
	jne	@@1	;@029CB
	mov	ax, word ptr es:[si+6]	;@029CD
	cmp	ax, word ptr es:[di+6]	;@029D1
	jne	@@1	;@029D5
	mov	ax, word ptr es:[si+4]	;@029D7
	cmp	ax, word ptr es:[di+4]	;@029DB
@@1:	pop	es	;@029DF
	pop	ax	;@029E0
	ret	;@029E1
L029E2:	push	bp	;@029E2
	mov	cx, word ptr ds:[367h]	;@029E3
	jcxz	@@3	;@029E7
	cmp	cx, 1	;@029E9
	je	@@1	;@029EC
	shl	cx, 1	;@029EE
	mov	bp, offset L029B8	;@029F0
	mov	es, word ptr ds:[381h]	;@029F3
	call L09252	;@029F7
@@1:	mov	cx, word ptr ds:[367h]	;@029FA
	xor	bx, bx	;@029FE
@@2:	mov	es, word ptr ds:[381h]	;@02A00
	mov	si, word ptr es:[bx]	;@02A04
	push	bx	;@02A07
	push	cx	;@02A08
	mov	bp, 37Dh	;@02A09
	mov	cx, 9	;@02A0C
	mov	bx, 309h	;@02A0F
	call	L051DC	;@02A12
	pop	cx	;@02A15
	pop	bx	;@02A16
	inc	bx	;@02A17
	inc	bx	;@02A18
	loop	@@2	;@02A19
	xor	ax, ax	;@02A1B
	mov	word ptr ds:[389h], ax	;@02A1D
	mov	word ptr ds:[367h], ax	;@02A20
	mov	word ptr ds:[38Bh], ax	;@02A23
@@3:	cmp	word ptr ds:[178h], 0	;@02A26
	je	@@4	;@02A2B
	cmp	word ptr ds:[3A8h], 0	;@02A2D
	je	@@4	;@02A32
	mov	di, word ptr ds:[383h]	;@02A34
	sub	di, 16h	;@02A38
	mov	es, word ptr ds:[36Dh]	;@02A3B
	cmp	word ptr es:[di+14h], -1	;@02A3F
	jne	@@4	;@02A44
	mov	ax, word ptr ds:[508h]	;@02A46
	inc	ax	;@02A49
	sub	ax, word ptr es:[di+12h]	;@02A4A
	mov	word ptr es:[di+14h], ax	;@02A4E
@@4:	pop	bp	;@02A52
	ret	;@02A53
L02A54:	mov	es, word ptr ds:[77Eh]	;@02A54
	mov	cx, word ptr es:[bx+6]	;@02A58
	mov	al, byte ptr es:[bx+9]	;@02A5C
	and	ax, 0FFh	;@02A60
	je	@@2	;@02A63
	mov	es, word ptr ds:[776h]	;@02A65
	mov	bx, word ptr es:[bx+4]	;@02A69
	push	bx	;@02A6D
	and	bx, 3	;@02A6E
	shl	bx, 1	;@02A71
	shl	bx, 1	;@02A73
	shl	bx, 1	;@02A75
	mov	es, word ptr [bx+736h]	;@02A77
	pop	bx	;@02A7B
	mov	bx, word ptr es:[bx+16h]	;@02A7C
	dec	ax	;@02A80
	push	ax	;@02A81
	mov	ah, 10h	;@02A82
	mul	ah	;@02A84
	xchg	ax, si	;@02A86
	pop	ax	;@02A87
	mov	es, word ptr ds:[371h]	;@02A88
@@1:	cmp	bx, word ptr es:[si]	;@02A8C
	je	@@3	;@02A8F
	add	ax, 0FFh	;@02A91
	add	si, 0FF0h	;@02A94
	cmp	si, word ptr ds:[399h]	;@02A98
	jb	@@1	;@02A9C
@@2:	call L0885D	;@02A9E
@@3:	mov	word ptr ds:[397h], cx	;@02AA1
	inc	ax	;@02AA5
	mov	word ptr ds:[395h], si	;@02AA6
	ret	;@02AAA
; P2_COMENT_E5: pass 2, Borland COMENT class E5h (debug information).
P2_COMENT_E5:	push	bp	;@02AAB
	mov	bp, sp	;@02AAC
	sub	sp, 8	;@02AAE
	push	si	;@02AB1
	call	L029E2	;@02AB2
	pop	si	;@02AB5
	sub	bx, bx	;@02AB6
	add	bl, byte ptr [si]	;@02AB8
	jge	@@1	;@02ABA
	inc	si	;@02ABC
	sub	bl, 80h	;@02ABD
	mov	bh, bl	;@02AC0
	mov	bl, byte ptr [si]	;@02AC2
@@1:	inc	si	;@02AC4
	cmp	bx, 4000h	;@02AC5
	jle	@@2	;@02AC9
	jmp	@@10	;@02ACB
@@2:	mov	byte ptr [bp-8], 0	;@02ACE
	xor	ax, ax	;@02AD2
@@3:	mov	word ptr [bp-2], bx	;@02AD4
	mov	word ptr [bp-4], ax	;@02AD7
	mov	di, word ptr ds:[383h]	;@02ADA
	add	word ptr ds:[383h], 16h	;@02ADE
	mov	bx, di	;@02AE3
	mov	es, word ptr ds:[36Dh]	;@02AE5
	mov	cx, 0Bh	;@02AE9
	xor	ax, ax	;@02AEC
	rep stosw	;@02AEE
	cmp	word ptr ds:[178h], 0	;@02AF0
	je	@@4	;@02AF5
	mov	ax, word ptr es:[bx-6]	;@02AF7
	mov	word ptr es:[bx+4], ax	;@02AFB
@@4:	mov	word ptr [bp-6], bx	;@02AFF
	inc	word ptr ds:[4EEh]	;@02B02
	mov	ax, word ptr ds:[4EEh]	;@02B06
	mov	word ptr es:[bx+10h], ax	;@02B09
	mov	ax, word ptr ds:[319h]	;@02B0D
	mov	word ptr es:[bx+0Ch], ax	;@02B10
	mov	ax, word ptr ds:[31Bh]	;@02B14
	mov	word ptr es:[bx+0Eh], ax	;@02B17
	mov	ax, word ptr ds:[508h]	;@02B1B
	inc	ax	;@02B1E
	mov	word ptr es:[bx+12h], ax	;@02B1F
	mov	word ptr es:[bx+14h], 0FFFFh	;@02B23
	add	word ptr ds:[319h], 0Ch	;@02B29
	adc	word ptr ds:[31Bh], 0	;@02B2E
	mov	bx, word ptr [bp-2]	;@02B33
	push	si	;@02B36
	push	es	;@02B37
	cmp	byte ptr [bp-8], 0	;@02B38
	je	@@5	;@02B3C
	mov	word ptr ds:[393h], 0FFFFh	;@02B3E
	jmp	short @@6	;@02B44
@@5:	cmp	bx, word ptr ds:[393h]	;@02B46
	je	@@7	;@02B4A
	mov	word ptr ds:[393h], bx	;@02B4C
	dec	bx	;@02B50
	xchg	ax, bx	;@02B51
	mov	ah, 0Ah	;@02B52
	mul	ah	;@02B54
	xchg	ax, bx	;@02B56
	add	bx, word ptr ds:[52Ah]	;@02B57
@@6:	call	L02A54	;@02B5B
	mov	ax, word ptr [bp-4]	;@02B5E
	and	ax, ax	;@02B61
	je	@@7	;@02B63
	mov	word ptr ds:[397h], ax	;@02B65
@@7:	mov	si, word ptr ds:[395h]	;@02B68
	mov	es, word ptr ds:[371h]	;@02B6C
	cmp	word ptr es:[si+0Ah], 0	;@02B70
	jne	@@8	;@02B75
	mov	ax, word ptr ds:[4EEh]	;@02B77
	mov	word ptr es:[si+8], ax	;@02B7A
@@8:	inc	word ptr es:[si+0Ah]	;@02B7E
	pop	es	;@02B82
	pop	si	;@02B83
	lodsw	;@02B84
	mov	bx, word ptr [bp-6]	;@02B85
	mov	word ptr es:[bx+8], ax	;@02B88
	inc	word ptr ds:[178h]	;@02B8C
	mov	word ptr ds:[230h], 0FFFFh	;@02B90
@@9:	mov	sp, bp	;@02B96
	pop	bp	;@02B98
	ret	;@02B99
@@10:	sub	bx, 4001h	;@02B9A
	shl	bx, 1	;@02B9E
	add	bx, word ptr ds:[52Ch]	;@02BA0
	mov	es, word ptr ds:[786h]	;@02BA4
	mov	bx, word ptr es:[bx]	;@02BA8
	push	bx	;@02BAB
	and	bx, 3	;@02BAC
	shl	bx, 1	;@02BAF
	shl	bx, 1	;@02BB1
	shl	bx, 1	;@02BB3
	mov	es, word ptr [bx+756h]	;@02BB5
	pop	bx	;@02BB9
	mov	ax, word ptr es:[bx+2]	;@02BBA
	cmp	ax, word ptr ds:[228h]	;@02BBE
	jne	@@11	;@02BC2
	mov	ax, word ptr es:[bx+4]	;@02BC4
	mov	bx, word ptr es:[bx]	;@02BC8
	mov	byte ptr [bp-8], 0FFh	;@02BCB
	jmp	@@3	;@02BCF
@@11:	inc	word ptr ds:[178h]	;@02BD2
	mov	word ptr ds:[230h], 1	;@02BD6
	mov	si, word ptr ds:[3E0h]	;@02BDC
	jmp	@@9	;@02BE0
L02BE2:	dec	bx	;@02BE2
	xchg	ax, bx	;@02BE3
	mov	ah, 0Ah	;@02BE4
	mul	ah	;@02BE6
	xchg	ax, bx	;@02BE8
	mov	si, bx	;@02BE9
	add	si, word ptr ds:[52Ah]	;@02BEB
	mov	es, word ptr ds:[776h]	;@02BEF
	mov	al, byte ptr es:[si+9]	;@02BF3
	mov	es, word ptr ds:[77Eh]	;@02BF7
	mov	cx, word ptr es:[si+6]	;@02BFB
	mov	si, word ptr es:[si]	;@02BFF
	test	al, 0E0h	;@02C02
	je	@@2	;@02C04
	call	L093E8	;@02C06
	xor	bx, bx	;@02C09
@@1:	ret	;@02C0B
@@2:	mov	ax, si	;@02C0C
	mov	bx, 1	;@02C0E
	jmp	@@1	;@02C11
; P2_COMENT_E6: pass 2, Borland COMENT class E6h (debug information).
P2_COMENT_E6:	cmp	word ptr ds:[230h], 1	;@02C13
	jne	@@1	;@02C18
	cmp	word ptr ds:[178h], 0	;@02C1A
	je	@@1	;@02C1F
	jmp	L02D7F	;@02C21
@@1:	mov	ax, word ptr ds:[4E6h]	;@02C24
	inc	ax	;@02C27
	cmp	word ptr ds:[178h], 0	;@02C28
	jne	@@3	;@02C2D
	cmp	word ptr ds:[38Dh], 0	;@02C2F
	jne	@@2	;@02C34
	mov	word ptr ds:[38Dh], ax	;@02C36
@@2:	jmp	short L02CB6	;@02C39
@@3:	mov	di, word ptr ds:[383h]	;@02C3B
	mov	es, word ptr ds:[36Dh]	;@02C3F
	cmp	word ptr es:[di-16h], 0	;@02C43
	jne	L02CB6	;@02C48
	mov	word ptr es:[di-16h], ax	;@02C4A
	jmp	short L02CB6	;@02C4E
L02C50:	inc	word ptr ds:[4E6h]	;@02C50
	cmp	word ptr ds:[178h], 0	;@02C54
	je	@@1	;@02C59
	mov	di, word ptr ds:[383h]	;@02C5B
	mov	es, word ptr ds:[36Dh]	;@02C5F
	inc	word ptr es:[di-14h]	;@02C63
@@1:	xor	ax, ax	;@02C67
	call	L026BB	;@02C69
	mov	di, 290h	;@02C6C
	mov	word ptr [di], ax	;@02C6F
	sub	bx, bx	;@02C71
	add	bl, byte ptr [si]	;@02C73
	jge	@@2	;@02C75
	inc	si	;@02C77
	sub	bl, 80h	;@02C78
	mov	bh, bl	;@02C7B
	mov	bl, byte ptr [si]	;@02C7D
@@2:	inc	si	;@02C7F
	cmp	bx, 18h	;@02C80
	jb	@@3	;@02C83
	add	bx, word ptr ds:[38Fh]	;@02C85
@@3:	mov	word ptr [di+2], bx	;@02C89
	lodsb	;@02C8C
	mov	byte ptr [di+8], al	;@02C8D
	and	ax, 7	;@02C90
	mov	bx, ax	;@02C93
	shl	bx, 1	;@02C95
	call	word ptr cs:L02CE5[bx]	;@02C97
	push	si	;@02C9C
	mov	si, 290h	;@02C9D
	mov	cx, 9	;@02CA0
	mov	al, byte ptr [si+8]	;@02CA3
	and	al, 7	;@02CA6
	cmp	al, 1	;@02CA8
	jbe	L02CBD	;@02CAA
	mov	bp, 47Eh	;@02CAC
	mov	bx, 309h	;@02CAF
	call	L051DC	;@02CB2
L02CB5:	pop	si	;@02CB5
L02CB6:	cmp	si, word ptr ds:[3E0h]	;@02CB6
	jb	L02C50	;@02CBA
L02CBC:	ret	;@02CBC
L02CBD:	mov	es, word ptr ds:[381h]	;@02CBD
	mov	di, word ptr ds:[38Bh]	;@02CC1
	mov	ax, word ptr ds:[389h]	;@02CC5
	stosw	;@02CC8
	mov	word ptr ds:[38Bh], di	;@02CC9
	mov	di, ax	;@02CCD
	mov	es, word ptr ds:[37Dh]	;@02CCF
	shr	cx, 1	;@02CD3
	rep movsw	;@02CD5
	rcl	cx, 1	;@02CD7
	rep movsb	;@02CD9
	inc	word ptr ds:[367h]	;@02CDB
	mov	word ptr ds:[389h], di	;@02CDF
	jmp	L02CB5	;@02CE3
L02CE5	dw	L02CFE, L02D42, L02D71, L02D71, L02D7B, L02CF5, L02D70, L02D70	;@02CE5
L02CF5:	lodsw	;@02CF5
	mov	word ptr [di+4], ax	;@02CF6
	lodsw	;@02CF9
	mov	word ptr [di+6], ax	;@02CFA
	ret	;@02CFD
L02CFE:	sub	bx, bx	;@02CFE
	add	bl, byte ptr [si]	;@02D00
	jge	@@1	;@02D02
	inc	si	;@02D04
	sub	bl, 80h	;@02D05
	mov	bh, bl	;@02D08
	mov	bl, byte ptr [si]	;@02D0A
@@1:	inc	si	;@02D0C
	and	bx, bx	;@02D0D
	je	L02D42	;@02D0F
	dec	bx	;@02D11
	shl	bx, 1	;@02D12
	shl	bx, 1	;@02D14
	add	bx, word ptr ds:[52Eh]	;@02D16
	mov	es, word ptr ds:[796h]	;@02D1A
	mov	bx, word ptr es:[bx]	;@02D1E
	push	bx	;@02D21
	and	bx, 3	;@02D22
	shl	bx, 1	;@02D25
	shl	bx, 1	;@02D27
	shl	bx, 1	;@02D29
	mov	es, word ptr [bx+716h]	;@02D2B
	pop	bx	;@02D2F
	mov	ax, word ptr es:[bx]	;@02D30
	xor	cx, cx	;@02D33
	cmp	byte ptr [si], 0	;@02D35
	jne	L02D42	;@02D38
	cmp	byte ptr [si], 80h	;@02D3A
	sbb	si, -2	;@02D3D
	jmp	short L02D67	;@02D40
L02D42:	sub	bx, bx	;@02D42
	add	bl, byte ptr [si]	;@02D44
	jge	@@1	;@02D46
	inc	si	;@02D48
	sub	bl, 80h	;@02D49
	mov	bh, bl	;@02D4C
	mov	bl, byte ptr [si]	;@02D4E
@@1:	inc	si	;@02D50
	push	si	;@02D51
	call	L02BE2	;@02D52
	pop	si	;@02D55
	cmp	bx, 1	;@02D56
	jne	L02D67	;@02D59
	mov	bl, byte ptr [di+8]	;@02D5B
	and	bl, 0F8h	;@02D5E
	or	bl, 1	;@02D61
	or	byte ptr [di+8], bl	;@02D64
L02D67:	mov	word ptr [di+6], ax	;@02D67
	lodsw	;@02D6A
	add	ax, cx	;@02D6B
	mov	word ptr [di+4], ax	;@02D6D
L02D70:	ret	;@02D70
L02D71:	lodsw	;@02D71
L02D72:	mov	word ptr [di+6], 0	;@02D72
	mov	word ptr [di+4], ax	;@02D77
	ret	;@02D7A
L02D7B:	lodsb	;@02D7B
	cbw	;@02D7C
	jmp	L02D72	;@02D7D
L02D7F:	mov	si, word ptr ds:[3E0h]	;@02D7F
	jmp	L02CBC	;@02D83
; P2_COMENT_E7: pass 2, Borland COMENT class E7h (debug information).
P2_COMENT_E7:	push	si	;@02D86
	call	L029E2	;@02D87
	pop	si	;@02D8A
	cmp	word ptr ds:[230h], 1	;@02D8B
	je	@@4	;@02D90
	sub	word ptr ds:[383h], 16h	;@02D92
	jl	@@3	;@02D97
	mov	bx, word ptr ds:[383h]	;@02D99
	mov	es, word ptr ds:[36Dh]	;@02D9D
	lodsw	;@02DA1
	sub	ax, word ptr es:[bx+8]	;@02DA2
	mov	word ptr es:[bx+0Ah], ax	;@02DA6
	mov	ax, word ptr ds:[397h]	;@02DAA
	add	word ptr es:[bx+8], ax	;@02DAD
	push	si	;@02DB1
	mov	ax, word ptr es:[bx+0Ch]	;@02DB2
	mov	dx, word ptr es:[bx+0Eh]	;@02DB6
	mov	si, bx	;@02DBA
	mov	cx, 0Ch	;@02DBC
	mov	bx, 36Dh	;@02DBF
	call	L08AC5	;@02DC2
	dec	word ptr ds:[178h]	;@02DC5
	cmp	word ptr ds:[3A8h], 0	;@02DC9
	je	@@1	;@02DCE
	mov	si, word ptr ds:[383h]	;@02DD0
	mov	es, word ptr ds:[36Dh]	;@02DD4
	mov	cx, 4	;@02DD8
	mov	ax, word ptr es:[si+10h]	;@02DDB
	dec	ax	;@02DDF
	mul	cx	;@02DE0
	add	ax, word ptr ds:[341h]	;@02DE2
	adc	dx, word ptr ds:[343h]	;@02DE6
	add	si, 12h	;@02DEA
	mov	bx, 36Dh	;@02DED
	call	L08AC5	;@02DF0
@@1:	pop	si	;@02DF3
@@2:	ret	;@02DF4
@@3:	call	L0885D	;@02DF5
@@4:	dec	word ptr ds:[178h]	;@02DF8
	mov	si, word ptr ds:[3E0h]	;@02DFC
	jmp	@@2	;@02E00
L02E02:	inc	word ptr ds:[4F2h]	;@02E02
	mov	bx, word ptr ds:[4F2h]	;@02E06
	mov	word ptr ds:[39Bh], bx	;@02E0A
	mov	di, 290h	;@02E0E
	mov	bx, di	;@02E11
	push	ds	;@02E13
	pop	es	;@02E14
	stosw	;@02E15
	movsw	;@02E16
	movsw	;@02E17
	push	si	;@02E18
	mov	si, bx	;@02E19
	mov	cx, 6	;@02E1B
	mov	bp, 47Eh	;@02E1E
	mov	bx, 311h	;@02E21
	call	L051DC	;@02E24
	pop	si	;@02E27
	ret	;@02E28
; P2_COMENT_E8: pass 2, Borland COMENT class E8h (debug information).
P2_COMENT_E8:	mov	word ptr ds:[17Ah], 0FFFFh	;@02E29
	sub	bx, bx	;@02E2F
	add	bl, byte ptr [si]	;@02E31
	jge	@@1	;@02E33
	inc	si	;@02E35
	sub	bl, 80h	;@02E36
	mov	bh, bl	;@02E39
	mov	bl, byte ptr [si]	;@02E3B
@@1:	inc	si	;@02E3D
	and	bx, bx	;@02E3E
	jne	@@2	;@02E40
	mov	ax, 1	;@02E42
	call	L026BB	;@02E45
	call	L02E02	;@02E48
	jmp	short @@3	;@02E4B
@@2:	add	bx, word ptr ds:[39Fh]	;@02E4D
	mov	word ptr ds:[39Bh], bx	;@02E51
	mov	si, word ptr ds:[3E0h]	;@02E55
@@3:	ret	;@02E59
; P2_COMENT_SKIP: pass 2, a Borland COMENT class TLINK has nothing to do with.
P2_COMENT_SKIP:	mov	si, word ptr ds:[3E0h]	;@02E5A
	ret	;@02E5E
; P2_COMENT_ED: pass 2, Borland COMENT class EDh (debug information).
P2_COMENT_ED:	lodsb	;@02E5F
	and	al, al	;@02E60
	je	@@4	;@02E62
	lodsb	;@02E64
	cbw	;@02E65
	and	al, al	;@02E66
	jns	@@1	;@02E68
	sub	al, 80h	;@02E6A
	mov	ah, al	;@02E6C
	lodsb	;@02E6E
@@1:	add	word ptr ds:[50Eh], ax	;@02E6F
	mov	cx, ax	;@02E73
@@2:	push	ds	;@02E75
	pop	es	;@02E76
	mov	di, 290h	;@02E77
	lodsb	;@02E7A
	cbw	;@02E7B
	and	al, al	;@02E7C
	jns	@@3	;@02E7E
	sub	al, 80h	;@02E80
	mov	ah, al	;@02E82
	lodsb	;@02E84
@@3:	add	ax, word ptr ds:[39Fh]	;@02E85
	stosw	;@02E89
	movsw	;@02E8A
	lodsb	;@02E8B
	mov	ah, 0	;@02E8C
	stosw	;@02E8E
	push	cx	;@02E8F
	xor	ax, ax	;@02E90
	call	L026BB	;@02E92
	push	si	;@02E95
	mov	si, 290h	;@02E96
	mov	word ptr [si+6], ax	;@02E99
	mov	cx, 8	;@02E9C
	mov	bx, 33Dh	;@02E9F
	mov	bp, 47Eh	;@02EA2
	call	L051DC	;@02EA5
	pop	si	;@02EA8
	pop	cx	;@02EA9
	loop	@@2	;@02EAA
	ret	;@02EAC
@@4:	sub	bx, bx	;@02EAD
	add	bl, byte ptr [si]	;@02EAF
	jge	@@5	;@02EB1
	inc	si	;@02EB3
	sub	bl, 80h	;@02EB4
	mov	bh, bl	;@02EB7
	mov	bl, byte ptr [si]	;@02EB9
@@5:	inc	si	;@02EBB
	push	bx	;@02EBC
	mov	di, 290h	;@02EBD
	mov	ax, word ptr ds:[3A5h]	;@02EC0
	mov	word ptr [di+6], ax	;@02EC3
	mov	ax, word ptr ds:[39Dh]	;@02EC6
	mov	word ptr [di+4], ax	;@02EC9
	mov	ax, word ptr ds:[4E4h]	;@02ECC
	inc	ax	;@02ECF
	mov	word ptr ds:[39Dh], ax	;@02ED0
	lodsw	;@02ED3
	mov	word ptr [di+8], ax	;@02ED4
	lodsb	;@02ED7
	mov	byte ptr [di+0Ah], al	;@02ED8
	mov	ax, word ptr ds:[50Ah]	;@02EDB
	inc	ax	;@02EDE
	mov	word ptr [di], ax	;@02EDF
	lodsb	;@02EE1
	cbw	;@02EE2
	and	al, al	;@02EE3
	jns	@@6	;@02EE5
	sub	al, 80h	;@02EE7
	mov	ah, al	;@02EE9
	lodsb	;@02EEB
@@6:	mov	word ptr [di+2], ax	;@02EEC
	add	word ptr ds:[50Ah], ax	;@02EEF
	mov	cx, ax	;@02EF3
	pop	ax	;@02EF5
	push	si	;@02EF6
	push	cx	;@02EF7
	add	ax, word ptr ds:[3A1h]	;@02EF8
	dec	ax	;@02EFC
	mov	cx, 0Bh	;@02EFD
	mul	cx	;@02F00
	add	ax, word ptr ds:[335h]	;@02F02
	adc	dx, word ptr ds:[337h]	;@02F06
	mov	si, 290h	;@02F0A
	mov	bx, 47Eh	;@02F0D
	call	L08AC5	;@02F10
	pop	cx	;@02F13
	pop	si	;@02F14
	jcxz	@@8	;@02F15
	mov	bx, si	;@02F17
	mov	dx, cx	;@02F19
	mov	ax, word ptr ds:[3A1h]	;@02F1B
@@7:	add	word ptr [bx], ax	;@02F1E
	inc	bx	;@02F20
	inc	bx	;@02F21
	loop	@@7	;@02F22
	push	bx	;@02F24
	mov	cx, dx	;@02F25
	shl	cx, 1	;@02F27
	mov	bx, 339h	;@02F29
	mov	bp, 47Eh	;@02F2C
	call	L051DC	;@02F2F
	pop	si	;@02F32
@@8:	inc	word ptr ds:[508h]	;@02F33
	ret	;@02F37
; P2_COMENT_F8: pass 2, Borland COMENT class F8h (debug information).
P2_COMENT_F8:	call	L026CD	;@02F38
	and	ax, ax	;@02F3B
	jne	@@1	;@02F3D
	mov	ax, 0FFFFh	;@02F3F
@@1:	mov	es, word ptr ds:[36Dh]	;@02F42
	mov	word ptr es:[6], ax	;@02F46
	ret	;@02F4A
; P2_COMENT_EE: pass 2, Borland COMENT class EEh (debug information).
P2_COMENT_EE:	cmp	byte ptr ds:[12Dh], 1	;@02F4B
	je	@@5	;@02F50
	sub	bx, bx	;@02F52
	add	bl, byte ptr [si]	;@02F54
	jge	@@1	;@02F56
	inc	si	;@02F58
	sub	bl, 80h	;@02F59
	mov	bh, bl	;@02F5C
	mov	bl, byte ptr [si]	;@02F5E
@@1:	inc	si	;@02F60
	cmp	bx, 4000h	;@02F61
	jg	@@6	;@02F65
	dec	bx	;@02F67
	xchg	ax, bx	;@02F68
	mov	ah, 0Ah	;@02F69
	mul	ah	;@02F6B
	xchg	ax, bx	;@02F6D
	add	bx, word ptr ds:[52Ah]	;@02F6E
@@2:	mov	es, word ptr ds:[77Eh]	;@02F72
	mov	dx, word ptr es:[bx+6]	;@02F76
	les	di, dword ptr ds:[3B2h]	;@02F7A
	mov	word ptr es:[di], bx	;@02F7E
	inc	di	;@02F81
	inc	di	;@02F82
	mov	cx, word ptr ds:[3E0h]	;@02F83
	sub	cx, si	;@02F87
	shr	cx, 1	;@02F89
	mov	word ptr es:[di], cx	;@02F8B
	inc	di	;@02F8E
	inc	di	;@02F8F
	jcxz	@@4	;@02F90
@@3:	lodsw	;@02F92
	add	ax, dx	;@02F93
	stosw	;@02F95
	mov	word ptr ds:[3B2h], di	;@02F96
	loop	@@3	;@02F9A
@@4:	ret	;@02F9C
@@5:	mov	si, word ptr ds:[3E0h]	;@02F9D
	jmp	@@4	;@02FA1
@@6:	sub	bx, 4001h	;@02FA3
	shl	bx, 1	;@02FA7
	add	bx, word ptr ds:[52Ch]	;@02FA9
	mov	es, word ptr ds:[786h]	;@02FAD
	mov	bx, word ptr es:[bx]	;@02FB1
	push	bx	;@02FB4
	and	bx, 3	;@02FB5
	shl	bx, 1	;@02FB8
	shl	bx, 1	;@02FBA
	shl	bx, 1	;@02FBC
	mov	es, word ptr [bx+756h]	;@02FBE
	pop	bx	;@02FC2
	mov	ax, word ptr es:[bx+2]	;@02FC3
	cmp	ax, word ptr ds:[228h]	;@02FC7
	jne	@@7	;@02FCB
	mov	bx, word ptr es:[bx]	;@02FCD
	jmp	@@2	;@02FD0
@@7:	mov	si, word ptr ds:[3E0h]	;@02FD2
	jmp	@@4	;@02FD6

; pass 2: the handlers of the COMENT classes E2h..F8h
PASS2_COMENT_CLASSES	dw	P2_COMENT_E2, P2_COMENT_E3, P2_COMENT_E4, P2_COMENT_E5, P2_COMENT_E6, P2_COMENT_E7, P2_COMENT_E8, P2_COMENT_SKIP	;@02FD8
	dw	P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_ED, P2_COMENT_EE, P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_SKIP
	dw	P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_SKIP, P2_COMENT_F8
; P2_COMENT: pass 2, COMENT (88h).
P2_COMENT:	lodsw	;@03006
	cmp	byte ptr ds:[15h], 0	;@03007
	je	@@1	;@0300C
	cmp	byte ptr ds:[3478h], 0	;@0300E
	jne	@@1	;@03013
	mov	bl, ah	;@03015
	xor	bh, bh	;@03017
	sub	bx, 0E2h	;@03019
	jl	@@1	;@0301D
	cmp	bx, 17h	;@0301F
	jae	@@1	;@03022
	shl	bx, 1	;@03024
	call	word ptr cs:PASS2_COMENT_CLASSES[bx]	;@03026
	cmp	si, word ptr ds:[3E0h]	;@0302B
	je	@@1	;@0302F
	call	L0885D	;@03031
@@1:	jmp	L059AB	;@03034
L03037:	push	ax	;@03037
	lodsw	;@03038
	xchg	ax, bx	;@03039
	mov	di, word ptr ds:[3ECh]	;@0303A
	and	di, di	;@0303E
	je	@@2	;@03040
	lodsw	;@03042
	xchg	ax, di	;@03043
	jmp	short @@2	;@03044
@@1:	pop	si	;@03046
@@2:	push	si	;@03047
	lodsw	;@03048
	or	ax, ax	;@03049
	je	@@5	;@0304B
	push	di	;@0304D
	push	bx	;@0304E
@@3:	call	L03037	;@0304F
	dec	ax	;@03052
	jne	@@3	;@03053
	pop	bx	;@03055
	pop	di	;@03056
	sub	bx, 1	;@03057
	sbb	di, 0	;@0305A
	jne	@@1	;@0305D
	or	bx, bx	;@0305F
	jne	@@1	;@03061
	jmp	short @@6	;@03063
@@4:	pop	si	;@03065
@@5:	push	si	;@03066
	push	di	;@03067
	push	bx	;@03068
	lodsb	;@03069
	mov	ah, 0	;@0306A
	xchg	ax, cx	;@0306C
	call	L08B1D	;@0306D
	xchg	ax, cx	;@03070
	pop	bx	;@03071
	pop	di	;@03072
	sub	bx, 1	;@03073
	sbb	di, 0	;@03076
	jne	@@4	;@03079
	or	bx, bx	;@0307B
	jne	@@4	;@0307D
	pop	ax	;@0307F
@@6:	pop	ax	;@03080
	pop	ax	;@03081
	ret	;@03082
L03083:	push	si	;@03083
	cmp	byte ptr ds:[3F1h], 0FFh	;@03084
	je	@@5	;@03089
	mov	cx, word ptr ds:[3E4h]	;@0308B
	mov	si, 0C4Eh	;@0308F
	mov	bx, cx	;@03092
	mov	al, byte ptr [bx+si-1]	;@03094
	mov	byte ptr ds:[214h], al	;@03097
	mov	bx, word ptr ds:[3E8h]	;@0309A
	mov	dx, cx	;@0309E
	add	dx, bx	;@030A0
	mov	word ptr ds:[212h], dx	;@030A2
	mov	dx, word ptr ds:[3E6h]	;@030A6
	mov	word ptr ds:[210h], dx	;@030AA
	sub	ax, ax	;@030AE
	xchg	byte ptr ds:[0C4Ch], al	;@030B0
	add	cx, ax	;@030B4
	sub	si, ax	;@030B6
	sub	bx, ax	;@030B8
	mov	ax, word ptr ds:[3EEh]	;@030BA
	add	ax, word ptr ds:[3FEh]	;@030BD
	mov	dl, byte ptr ds:[3F0h]	;@030C1
	mov	dh, 0	;@030C5
	adc	dl, dh	;@030C7
	shl	ax, 1	;@030C9
	rcl	dx, 1	;@030CB
	shl	ax, 1	;@030CD
	rcl	dx, 1	;@030CF
	shl	ax, 1	;@030D1
	rcl	dx, 1	;@030D3
	shl	ax, 1	;@030D5
	rcl	dx, 1	;@030D7
	add	ax, bx	;@030D9
	adc	dx, word ptr ds:[3EAh]	;@030DB
	cmp	byte ptr ds:[3F1h], 1	;@030DF
	je	@@2	;@030E4
	call	L08B1D	;@030E6
@@1:	pop	si	;@030E9
	mov	byte ptr ds:[3F1h], 0FFh	;@030EA
	ret	;@030EF
@@2:	xchg	ax, cx	;@030F0
	add	ax, 0C4Eh	;@030F1
	jmp	short @@4	;@030F4
@@3:	call	L03037	;@030F6
@@4:	cmp	si, ax	;@030F9
	jb	@@3	;@030FB
	jmp	@@1	;@030FD
@@5:	mov	word ptr ds:[210h], 0FFFFh	;@030FF
	jmp	@@1	;@03105
L03107:	push	di	;@03107
	push	si	;@03108
	push	ax	;@03109
	mov	di, word ptr ds:[3E6h]	;@0310A
	mov	es, word ptr ds:[77Eh]	;@0310E
	mov	di, word ptr es:[di]	;@03112
	mov	es, word ptr ds:[79Eh]	;@03115
	cmp	byte ptr es:[di+1], 1	;@03119
	je	@@1	;@0311E
	cmp	byte ptr es:[di+1], 3	;@03120
	jne	@@7	;@03125
@@1:	cmp	bx, word ptr es:[di+4]	;@03127
	jne	@@7	;@0312B
	mov	di, 3FFh	;@0312D
	and	di, dx	;@03130
	je	@@6	;@03132
	mov	al, byte ptr [di+0C4Dh]	;@03134
@@2:	mov	si, word ptr [di+0C4Eh]	;@03138
	cmp	al, 9Ah	;@0313C
	je	@@3	;@0313E
	cmp	al, 0EAh	;@03140
	jne	@@7	;@03142
	mov	word ptr [di+0C4Dh], 9090h	;@03144
	mov	byte ptr [di+0C4Fh], 0E9h	;@0314A
	jmp	short @@4	;@0314F
@@3:	mov	word ptr [di+0C4Dh], 0E90h	;@03151
	mov	byte ptr [di+0C4Fh], 0E8h	;@03157
@@4:	or	di, di	;@0315C
	jne	@@5	;@0315E
	mov	byte ptr ds:[0C4Ch], 1	;@03160
@@5:	add	dx, 0F802h	;@03165
	mov	word ptr [di+0C50h], si	;@03169
	sub	cx, di	;@0316D
	sub	cx, 4	;@0316F
	sub	cx, word ptr ds:[3E8h]	;@03172
	mov	word ptr ds:[21Ch], 0FFFFh	;@03176
	stc	;@0317C
	jmp	short @@8	;@0317D
@@6:	mov	si, word ptr ds:[210h]	;@0317F
	cmp	si, word ptr ds:[3E6h]	;@03183
	jne	@@7	;@03187
	mov	si, word ptr ds:[212h]	;@03189
	cmp	si, word ptr ds:[3E8h]	;@0318D
	jne	@@7	;@03191
	mov	al, byte ptr ds:[214h]	;@03193
	jmp	@@2	;@03196
@@7:	clc	;@03198
@@8:	pop	ax	;@03199
	pop	si	;@0319A
	pop	di	;@0319B
	ret	;@0319C
L0319D:	mov	di, 3FFh	;@0319D
	and	di, dx	;@031A0
	mov	es, word ptr ds:[77Eh]	;@031A2
	mov	bx, word ptr es:[bx+4]	;@031A6
	cmp	word ptr ds:[21Ch], 0	;@031AA
	je	@@1	;@031AF
	cmp	word ptr [di+0C4Eh], 0	;@031B1
	jne	@@1	;@031B6
	mov	cx, word ptr ds:[21Ch]	;@031B8
	ret	;@031BC
@@1:	add	cx, word ptr [di+0C4Eh]	;@031BD
	mov	si, word ptr es:[bx+4]	;@031C1
	jmp	short @@3	;@031C5
@@2:	mov	si, word ptr es:[si+0Ah]	;@031C7
@@3:	cmp	si, -1	;@031CB
	je	@@4	;@031CE
	push	si	;@031D0
	and	si, 3	;@031D1
	shl	si, 1	;@031D4
	shl	si, 1	;@031D6
	shl	si, 1	;@031D8
	mov	es, word ptr [si+756h]	;@031DA
	pop	si	;@031DE
	cmp	cx, word ptr es:[si+4]	;@031DF
	jne	@@2	;@031E3
	mov	word ptr [di+0C4Eh], 0	;@031E5
	mov	cx, word ptr es:[si+8]	;@031EB
	ret	;@031EF
@@4:	sub	cx, word ptr [di+0C4Eh]	;@031F0
	ret	;@031F4

; the fixup handlers, by frame method
FIXUP_FRAMES	dw	FIX_LOBYTE, FIX_OFFSET, FIX_BASE, FIX_POINTER, FIX_LOBYTE, FIX_LOADER_OFFSET, FIX_LOBYTE, FIX_LOBYTE	;@031F5
L03205:	push	di	;@03205
	push	si	;@03206
	push	ax	;@03207
	mov	ax, 1Ch	;@03208
	and	al, dh	;@0320B
	shr	ax, 1	;@0320D
	xchg	ax, di	;@0320F
	jmp	word ptr cs:FIXUP_FRAMES[di]	;@03210
; FIX_OFFSET: the fixup handler for an offset location.
FIX_OFFSET:	mov	ax, word ptr ds:[450h]	;@03215
	mov	es, word ptr ds:[776h]	;@03218
	cmp	ax, word ptr es:[bx+2]	;@0321C
	je	FIX_LOBYTE	;@03220
	mov	di, word ptr ds:[3E6h]	;@03222
	mov	es, word ptr ds:[77Eh]	;@03226
	mov	di, word ptr es:[di]	;@0322A
	mov	es, word ptr ds:[79Eh]	;@0322D
	cmp	byte ptr es:[di+1], 1	;@03231
	je	@@1	;@03236
	cmp	byte ptr es:[di+1], 3	;@03238
	jne	FIX_LOBYTE	;@0323D
@@1:	cmp	bx, word ptr es:[di+4]	;@0323F
	jne	FIX_LOADER_OFFSET	;@03243
	jmp	short FIX_LOBYTE	;@03245
; FIX_POINTER: the fixup handler for a far pointer location.
FIX_POINTER:	mov	ax, word ptr ds:[450h]	;@03247
	mov	es, word ptr ds:[776h]	;@0324A
	cmp	ax, word ptr es:[bx+2]	;@0324E
	je	L03278	;@03252
	call	L03107	;@03254
	jb	FIX_LOBYTE	;@03257
; FIX_LOADER_OFFSET: the fixup handler for a loader-resolved offset location.
FIX_LOADER_OFFSET:	call	L0319D	;@03259
	cmp	si, -1	;@0325C
	je	L03282	;@0325F
; FIX_LOBYTE: the fixup handler for a low-byte (also high-byte and unknown) location.
FIX_LOBYTE:	pop	ax	;@03261
	pop	si	;@03262
	pop	di	;@03263
	ret	;@03264
; FIX_BASE: the fixup handler for a segment (base) location.
FIX_BASE:	mov	ax, word ptr ds:[450h]	;@03265
	mov	es, word ptr ds:[776h]	;@03268
	cmp	ax, word ptr es:[bx+2]	;@0326C
	jne	L03278	;@03270
	mov	word ptr ds:[216h], 0FFFFh	;@03272
L03278:	mov	es, word ptr ds:[77Eh]	;@03278
	mov	bx, word ptr es:[bx+4]	;@0327C
	jmp	FIX_LOBYTE	;@03280
L03282:	push	si	;@03282
	mov	si, word ptr ds:[3E6h]	;@03283
	mov	es, word ptr ds:[776h]	;@03287
	mov	si, word ptr es:[si]	;@0328B
	mov	di, 26h	;@0328E
	call	COPY_NAME	;@03291
	mov	ax, word ptr ds:[224h]	;@03294
	and	ax, 3FFh	;@03297
	add	ax, word ptr ds:[3E8h]	;@0329A
	mov	di, 76h	;@0329E
	push	ax	;@032A1
	mov	al, ah	;@032A2
	call	HEX_BYTE	;@032A4
	pop	ax	;@032A7
	call	HEX_BYTE	;@032A8
	mov	byte ptr [di], 0	;@032AB
	mov	ds, word ptr cs:DATA_SEGMENT	;@032AE
	mov	word ptr ds:[422h], 1	;@032B3
	push	ds	;@032B9
	mov	ax, 76h	;@032BA
	push	ax	;@032BD
	push	ds	;@032BE
	mov	ax, 26h	;@032BF
	push	ax	;@032C2
	mov	cx, 8	;@032C3
	push	cx	;@032C6
	mov	ax, 34h	;@032C7
	push	ax	;@032CA
	call	WARNING	;@032CB
	pop	si	;@032CE
	jmp	FIX_LOBYTE	;@032CF
L032D1:	push	ax	;@032D1
	push	bx	;@032D2
	push	si	;@032D3
	mov	ax, word ptr es:[bx+0Ch]	;@032D4
	mov	si, 460h	;@032D8
	mov	bx, 9	;@032DB
@@1:	cmp	ax, word ptr [si]	;@032DE
	je	@@3	;@032E0
	add	si, 2	;@032E2
	dec	bx	;@032E5
	jne	@@1	;@032E6
@@2:	pop	si	;@032E8
	pop	bx	;@032E9
	pop	ax	;@032EA
	ret	;@032EB
@@3:	xor	cx, cx	;@032EC
	mov	word ptr ds:[420h], cx	;@032EE
	or	byte ptr ds:[215h], 40h	;@032F2
	mov	word ptr ds:[24Ah], ax	;@032F7
	jmp	@@2	;@032FA
L032FC:	mov	word ptr ds:[224h], dx	;@032FC
	xor	ax, ax	;@03300
	mov	word ptr ds:[21Ch], ax	;@03302
	mov	word ptr ds:[21Eh], ax	;@03305
	mov	word ptr ds:[220h], ax	;@03308
	mov	byte ptr ds:[215h], al	;@0330B
	mov	word ptr ds:[420h], ax	;@0330E
	dec	ax	;@03311
	mov	word ptr ds:[218h], ax	;@03312
	mov	word ptr ds:[21Ah], ax	;@03315
	lodsb	;@03318
	mov	ah, al	;@03319
	and	al, 0F0h	;@0331B
	js	@@2	;@0331D
	cmp	al, 30h	;@0331F
	jae	@@3	;@03321
	sub	bx, bx	;@03323
	add	bl, byte ptr [si]	;@03325
	jge	@@1	;@03327
	inc	si	;@03329
	sub	bl, 80h	;@0332A
	mov	bh, bl	;@0332D
	mov	bl, byte ptr [si]	;@0332F
@@1:	inc	si	;@03331
	mov	bp, bx	;@03332
	jmp	short @@4	;@03334
@@2:	shr	al, 1	;@03336
	shr	al, 1	;@03338
	shr	al, 1	;@0333A
	mov	bx, ax	;@0333C
	and	bx, 6	;@0333E
	mov	bp, word ptr [bx+242h]	;@03341
	shr	bx, 1	;@03345
	mov	al, byte ptr [bx+23Eh]	;@03347
	jmp	short @@4	;@0334B
@@3:	ja	@@4	;@0334D
	xchg	ax, bp	;@0334F
	lodsw	;@03350
	xchg	ax, bp	;@03351
@@4:	test	ah, 8	;@03352
	jne	@@6	;@03355
	test	ah, 4	;@03357
	jne	@@10	;@0335A
	and	ah, 3	;@0335C
	cmp	ah, 3	;@0335F
	je	@@8	;@03362
	sub	bx, bx	;@03364
	add	bl, byte ptr [si]	;@03366
	jge	@@5	;@03368
	inc	si	;@0336A
	sub	bl, 80h	;@0336B
	mov	bh, bl	;@0336E
	mov	bl, byte ptr [si]	;@03370
@@5:	inc	si	;@03372
	xchg	ax, cx	;@03373
	lodsw	;@03374
	xchg	ax, cx	;@03375
	cmp	word ptr ds:[41Eh], 0	;@03376
	je	@@12	;@0337B
	push	word ptr [si]	;@0337D
	inc	si	;@0337F
	inc	si	;@03380
	pop	word ptr ds:[420h]	;@03381
	jmp	short @@12	;@03385
@@6:	sub	cx, cx	;@03387
	test	ah, 4	;@03389
	jne	@@7	;@0338C
	xchg	ax, cx	;@0338E
	lodsw	;@0338F
	xchg	ax, cx	;@03390
	cmp	word ptr ds:[41Eh], 0	;@03391
	je	@@7	;@03396
	xchg	ax, bx	;@03398
	lodsw	;@03399
	xchg	ax, bx	;@0339A
	mov	word ptr ds:[420h], bx	;@0339B
@@7:	mov	bl, ah	;@0339F
	and	bx, 3	;@033A1
	mov	ah, byte ptr [bx+232h]	;@033A4
	shl	bx, 1	;@033A8
	mov	bx, word ptr [bx+236h]	;@033AA
	jmp	short @@12	;@033AE
@@8:	mov	bx, word ptr [si]	;@033B0
	mov	cx, word ptr [si+2]	;@033B2
	add	si, 4	;@033B5
	jmp	short @@12	;@033B8
@@9:	mov	bx, word ptr [si]	;@033BA
	add	si, 2	;@033BC
	jmp	short @@12	;@033BF
@@10:	sub	cx, cx	;@033C1
	and	ah, 3	;@033C3
	cmp	ah, 3	;@033C6
	je	@@9	;@033C9
	sub	bx, bx	;@033CB
	add	bl, byte ptr [si]	;@033CD
	jge	@@11	;@033CF
	inc	si	;@033D1
	sub	bl, 80h	;@033D2
	mov	bh, bl	;@033D5
	mov	bl, byte ptr [si]	;@033D7
@@11:	inc	si	;@033D9
@@12:	cmp	ah, 2	;@033DA
	je	@@13	;@033DD
	ja	@@14	;@033DF
	or	ah, ah	;@033E1
	je	@@16	;@033E3
	jmp	@@20	;@033E5
@@13:	jmp	@@27	;@033E8
@@14:	jmp	@@35	;@033EB
@@15:	jmp	L0391A	;@033EE
@@16:	cmp	bx, 4000h	;@033F1
	jle	@@17	;@033F5
	jmp	@@26	;@033F7
@@17:	or	byte ptr ds:[215h], 4	;@033FA
	cmp	bx, word ptr ds:[53Bh]	;@033FF
	ja	@@15	;@03403
	dec	bx	;@03405
	xchg	ax, bx	;@03406
	mov	ah, 0Ah	;@03407
	mul	ah	;@03409
	xchg	ax, bx	;@0340B
	add	bx, word ptr ds:[52Ah]	;@0340C
	mov	es, word ptr ds:[77Eh]	;@03410
	add	cx, word ptr es:[bx+6]	;@03414
	xchg	ax, di	;@03418
	mov	al, byte ptr es:[bx+8]	;@03419
	mov	ah, 0	;@0341D
	adc	word ptr ds:[420h], ax	;@0341F
	xchg	ax, di	;@03423
	mov	es, word ptr ds:[776h]	;@03424
	test	byte ptr es:[bx+9], 0E0h	;@03428
	je	@@18	;@0342D
	mov	es, word ptr ds:[77Eh]	;@0342F
	mov	di, word ptr es:[bx+2]	;@03433
	or	byte ptr ds:[215h], 10h	;@03437
	jmp	short @@21	;@0343C
@@18:	or	byte ptr ds:[215h], 1	;@0343E
	mov	word ptr ds:[21Ch], 0FFFFh	;@03443
	mov	es, word ptr ds:[77Eh]	;@03449
	mov	di, word ptr es:[bx]	;@0344D
	jmp	@@36	;@03450
@@19:	mov	bx, word ptr es:[bx]	;@03453
	push	bx	;@03456
	and	bx, 3	;@03457
	shl	bx, 1	;@0345A
	shl	bx, 1	;@0345C
	shl	bx, 1	;@0345E
	mov	es, word ptr [bx+716h]	;@03460
	pop	bx	;@03464
	mov	bx, word ptr es:[bx]	;@03465
	mov	es, word ptr ds:[79Eh]	;@03468
	mov	di, word ptr es:[bx+4]	;@0346C
	jmp	short @@21	;@03470
@@20:	dec	bx	;@03472
	shl	bx, 1	;@03473
	shl	bx, 1	;@03475
	add	bx, word ptr ds:[52Eh]	;@03477
	mov	es, word ptr ds:[796h]	;@0347B
	cmp	byte ptr ds:[17h], 1	;@0347F
	je	@@19	;@03484
	mov	di, word ptr es:[bx]	;@03486
	mov	bx, word ptr es:[bx+2]	;@03489
	push	di	;@0348D
	and	di, 3	;@0348E
	shl	di, 1	;@03491
	shl	di, 1	;@03493
	shl	di, 1	;@03495
	mov	es, word ptr [di+716h]	;@03497
	pop	di	;@0349B
	mov	di, word ptr es:[di]	;@0349C
	mov	word ptr ds:[22Eh], di	;@0349F
	mov	es, word ptr ds:[77Eh]	;@034A3
	mov	di, word ptr es:[bx]	;@034A7
	cmp	di, word ptr ds:[22Eh]	;@034AA
	jne	@@24	;@034AE
	mov	es, word ptr ds:[79Eh]	;@034B0
	mov	di, word ptr es:[di+4]	;@034B4
@@21:	test	dh, 40h	;@034B8
	je	@@22	;@034BB
	jmp	@@36	;@034BD
@@22:	mov	word ptr ds:[21Ch], 0FFFFh	;@034C0
	push	ax	;@034C6
	mov	ax, 3FFh	;@034C7
	and	ax, dx	;@034CA
	push	dx	;@034CC
	mov	dx, word ptr ds:[3EAh]	;@034CD
	add	ax, word ptr ds:[3E8h]	;@034D1
	adc	dx, 0	;@034D5
	add	ax, 2	;@034D8
	adc	dx, 0	;@034DB
	cmp	word ptr ds:[41Eh], 0	;@034DE
	je	@@23	;@034E3
	add	ax, 2	;@034E5
	adc	dx, 0	;@034E8
@@23:	mov	word ptr ds:[21Eh], ax	;@034EB
	mov	word ptr ds:[220h], dx	;@034EE
	pop	dx	;@034F2
	pop	ax	;@034F3
	jmp	@@36	;@034F4
@@24:	mov	di, word ptr es:[bx+2]	;@034F7
	jmp	@@21	;@034FB
@@25:	jmp	L039E8	;@034FD
@@26:	sub	bx, 4000h	;@03500
@@27:	dec	bx	;@03504
	shl	bx, 1	;@03505
	add	bx, word ptr ds:[52Ch]	;@03507
	mov	es, word ptr ds:[786h]	;@0350B
	mov	bx, word ptr es:[bx]	;@0350F
	mov	word ptr ds:[21Ah], bx	;@03512
	push	bx	;@03516
	and	bx, 3	;@03517
	shl	bx, 1	;@0351A
	shl	bx, 1	;@0351C
	shl	bx, 1	;@0351E
	mov	es, word ptr [bx+756h]	;@03520
	pop	bx	;@03524
	push	word ptr es:[bx+0Ch]	;@03525
	pop	word ptr ds:[218h]	;@03529
	test	byte ptr es:[bx+0Eh], 10h	;@0352D
	jne	@@25	;@03532
	cmp	word ptr es:[bx], -1	;@03534
	je	@@25	;@03538
	add	cx, word ptr es:[bx+4]	;@0353A
	mov	di, word ptr es:[bx+6]	;@0353E
	adc	word ptr ds:[420h], di	;@03542
	test	dh, 40h	;@03546
	je	@@28	;@03549
	mov	di, word ptr es:[bx+8]	;@0354B
	cmp	di, -1	;@0354F
	mov	word ptr ds:[21Ch], di	;@03552
	je	@@30	;@03556
	jmp	short @@31	;@03558
@@28:	mov	word ptr ds:[21Ch], 0FFFFh	;@0355A
	push	ax	;@03560
	mov	ax, 3FFh	;@03561
	and	ax, dx	;@03564
	push	dx	;@03566
	mov	dx, word ptr ds:[3EAh]	;@03567
	add	ax, word ptr ds:[3E8h]	;@0356B
	adc	dx, 0	;@0356F
	add	ax, 2	;@03572
	adc	dx, 0	;@03575
	cmp	word ptr ds:[41Eh], 0	;@03578
	je	@@29	;@0357D
	add	ax, 2	;@0357F
	adc	dx, 0	;@03582
@@29:	mov	word ptr ds:[21Eh], ax	;@03585
	mov	word ptr ds:[220h], dx	;@03588
	pop	dx	;@0358C
	pop	ax	;@0358D
@@30:	test	byte ptr es:[bx+0Eh], 20h	;@0358E
	jne	@@32	;@03593
	test	byte ptr es:[bx+0Eh], 2	;@03595
	jne	@@33	;@0359A
@@31:	mov	di, word ptr es:[bx]	;@0359C
	mov	es, word ptr ds:[77Eh]	;@0359F
	mov	bx, word ptr es:[di]	;@035A3
	mov	es, word ptr ds:[776h]	;@035A6
	test	byte ptr es:[di+9], 0E0h	;@035AA
	je	@@35	;@035AF
	mov	es, word ptr ds:[77Eh]	;@035B1
	mov	di, word ptr es:[di+2]	;@035B5
	jmp	short @@36	;@035B9
@@32:	mov	cx, word ptr es:[bx+2]	;@035BB
	mov	bx, 0FFFDh	;@035BF
	jmp	L0384F	;@035C2
@@33:	cmp	byte ptr ds:[17h], 0	;@035C5
	je	@@34	;@035CA
	call	L032D1	;@035CC
@@34:	mov	bx, word ptr es:[bx]	;@035CF
@@35:	or	byte ptr ds:[215h], 1	;@035D2
	mov	word ptr ds:[21Ch], 0FFFFh	;@035D7
	mov	di, bx	;@035DD
@@36:	mov	bx, bp	;@035DF
	cmp	al, 20h	;@035E1
	jbe	@@37	;@035E3
	jmp	@@50	;@035E5
@@37:	jne	@@38	;@035E8
	jmp	@@52	;@035EA
@@38:	or	al, al	;@035ED
	jne	@@44	;@035EF
	cmp	bx, 4000h	;@035F1
	jle	@@39	;@035F5
	jmp	@@51	;@035F7
@@39:	cmp	bx, word ptr ds:[53Bh]	;@035FA
	ja	@@42	;@035FE
	dec	bx	;@03600
	xchg	ax, bx	;@03601
	mov	ah, 0Ah	;@03602
	mul	ah	;@03604
	xchg	ax, bx	;@03606
	add	bx, word ptr ds:[52Ah]	;@03607
@@40:	mov	es, word ptr ds:[776h]	;@0360B
	test	byte ptr es:[bx+9], 0E0h	;@0360F
	je	@@43	;@03614
	mov	es, word ptr ds:[77Eh]	;@03616
	mov	bx, word ptr es:[bx+2]	;@0361A
	cmp	byte ptr ds:[17h], 1	;@0361E
	jne	@@41	;@03623
	jmp	@@59	;@03625
@@41:	or	byte ptr ds:[215h], 4	;@03628
	mov	ax, word ptr es:[bx+6]	;@0362D
	and	al, 0F0h	;@03631
	sub	cx, ax	;@03633
	mov	al, byte ptr es:[bx+8]	;@03635
	mov	ah, 0	;@03639
	sbb	word ptr ds:[420h], ax	;@0363B
	or	byte ptr ds:[215h], 10h	;@0363F
	jmp	@@59	;@03644
@@42:	jmp	L0391A	;@03647
@@43:	mov	es, word ptr ds:[77Eh]	;@0364A
	mov	bx, word ptr es:[bx]	;@0364E
	jmp	@@53	;@03651
@@44:	dec	bx	;@03654
	jge	@@45	;@03655
	jmp	@@49	;@03657
@@45:	shl	bx, 1	;@0365A
	shl	bx, 1	;@0365C
	add	bx, word ptr ds:[52Eh]	;@0365E
	mov	es, word ptr ds:[796h]	;@03662
	cmp	byte ptr ds:[17h], 1	;@03666
	je	@@48	;@0366B
	push	di	;@0366D
	mov	di, word ptr es:[bx]	;@0366E
	mov	bx, word ptr es:[bx+2]	;@03671
	push	di	;@03675
	and	di, 3	;@03676
	shl	di, 1	;@03679
	shl	di, 1	;@0367B
	shl	di, 1	;@0367D
	mov	es, word ptr [di+716h]	;@0367F
	pop	di	;@03683
	mov	di, word ptr es:[di]	;@03684
	mov	word ptr ds:[22Eh], di	;@03687
	mov	es, word ptr ds:[77Eh]	;@0368B
	mov	di, word ptr es:[bx]	;@0368F
	cmp	di, word ptr ds:[22Eh]	;@03692
	jne	@@46	;@03696
	mov	bx, di	;@03698
	pop	di	;@0369A
	jmp	@@58	;@0369B
@@46:	pop	di	;@0369E
	test	byte ptr ds:[215h], 1	;@0369F
	je	@@47	;@036A4
	jmp	L0388B	;@036A6
@@47:	mov	bx, word ptr es:[bx]	;@036A9
	mov	es, word ptr ds:[79Eh]	;@036AC
	mov	bx, word ptr es:[bx+4]	;@036B0
	mov	es, word ptr ds:[77Eh]	;@036B4
	mov	di, word ptr es:[di+2]	;@036B8
	or	byte ptr ds:[215h], 4	;@036BC
	jmp	@@59	;@036C1
@@48:	mov	bx, word ptr es:[bx]	;@036C4
	push	bx	;@036C7
	and	bx, 3	;@036C8
	shl	bx, 1	;@036CB
	shl	bx, 1	;@036CD
	shl	bx, 1	;@036CF
	mov	es, word ptr [bx+716h]	;@036D1
	pop	bx	;@036D5
	mov	bx, word ptr es:[bx]	;@036D6
	or	byte ptr ds:[215h], 10h	;@036D9
	mov	es, word ptr ds:[77Eh]	;@036DE
	jmp	@@58	;@036E2
@@49:	inc	bx	;@036E5
	jmp	@@45	;@036E6
@@50:	cmp	al, 40h	;@036E9
	je	@@56	;@036EB
	jb	@@53	;@036ED
	jmp	short @@55	;@036EF
@@51:	sub	bx, 4000h	;@036F1
@@52:	dec	bx	;@036F5
	shl	bx, 1	;@036F6
	add	bx, word ptr ds:[52Ch]	;@036F8
	mov	es, word ptr ds:[786h]	;@036FC
	mov	bx, word ptr es:[bx]	;@03700
	mov	word ptr ds:[21Ah], bx	;@03703
	push	bx	;@03707
	and	bx, 3	;@03708
	shl	bx, 1	;@0370B
	shl	bx, 1	;@0370D
	shl	bx, 1	;@0370F
	mov	es, word ptr [bx+756h]	;@03711
	pop	bx	;@03715
	push	word ptr es:[bx+0Ch]	;@03716
	pop	word ptr ds:[218h]	;@0371A
	test	byte ptr es:[bx+0Eh], 10h	;@0371E
	jne	@@54	;@03723
	test	byte ptr es:[bx+0Eh], 2	;@03725
	mov	bx, word ptr es:[bx]	;@0372A
	jne	@@53	;@0372D
	jmp	short @@57	;@0372F
@@53:	or	byte ptr ds:[215h], 2	;@03731
	jmp	short @@59	;@03736
@@54:	jmp	L039E8	;@03738
@@55:	mov	bx, di	;@0373B
	mov	al, byte ptr ds:[215h]	;@0373D
	test	al, 1	;@03740
	jne	@@53	;@03742
	cmp	byte ptr ds:[17h], 1	;@03744
	je	@@59	;@03749
	test	al, 4	;@0374B
	je	@@59	;@0374D
	jmp	@@40	;@0374F
@@56:	test	byte ptr ds:[215h], 1	;@03752
	jne	@@55	;@03757
	mov	bx, word ptr ds:[3E6h]	;@03759
@@57:	mov	es, word ptr ds:[776h]	;@0375D
	test	byte ptr es:[bx+9], 0E0h	;@03761
	mov	es, word ptr ds:[77Eh]	;@03766
	mov	bx, word ptr es:[bx]	;@0376A
	je	@@53	;@0376D
@@58:	mov	di, word ptr es:[di]	;@0376F
	mov	es, word ptr ds:[79Eh]	;@03772
	mov	bx, word ptr es:[bx+4]	;@03776
	test	byte ptr ds:[215h], 1	;@0377A
	jne	@@59	;@0377F
	mov	di, word ptr es:[di+4]	;@03781
@@59:	mov	al, byte ptr ds:[215h]	;@03785
	test	al, 3	;@03788
	je	@@60	;@0378A
	jmp	L0388E	;@0378C
@@60:	mov	es, word ptr ds:[77Eh]	;@0378F
	cmp	bx, di	;@03793
	je	@@61	;@03795
	jmp	L038B0	;@03797
@@61:	cmp	byte ptr ds:[17h], 0	;@0379A
	je	L037C4	;@0379F
	sub	cx, word ptr ds:[21Eh]	;@037A1
	push	dx	;@037A5
	mov	dx, word ptr ds:[420h]	;@037A6
	sbb	dx, word ptr ds:[220h]	;@037AA
	mov	word ptr ds:[420h], dx	;@037AE
	pop	dx	;@037B2
	mov	al, 1Ch	;@037B3
	and	al, dh	;@037B5
	cmp	al, 0Ch	;@037B7
	je	@@62	;@037B9
	jmp	L0384F	;@037BB
@@62:	call	L03107	;@037BE
	jmp	L0384F	;@037C1
L037C4:	sub	cx, word ptr ds:[21Eh]	;@037C4
	push	dx	;@037C8
	mov	dx, word ptr ds:[420h]	;@037C9
	sbb	dx, word ptr ds:[220h]	;@037CD
	mov	word ptr ds:[420h], dx	;@037D1
	pop	dx	;@037D5
	push	dx	;@037D6
	mov	dx, word ptr ds:[21Eh]	;@037D7
	or	dx, word ptr ds:[220h]	;@037DB
	pop	dx	;@037DF
	je	@@1	;@037E0
	push	di	;@037E2
	push	bx	;@037E3
	mov	di, word ptr es:[bx]	;@037E4
	mov	bx, word ptr ds:[3E6h]	;@037E7
	mov	bx, word ptr es:[bx]	;@037EB
	mov	es, word ptr ds:[79Eh]	;@037EE
	mov	bx, word ptr es:[bx+8]	;@037F2
	mov	di, word ptr es:[di+8]	;@037F6
	sub	bx, di	;@037FA
	cmp	bx, 1000h	;@037FC
	pop	bx	;@03800
	pop	di	;@03801
	jb	@@1	;@03802
	jmp	L0388B	;@03804
@@1:	cmp	byte ptr ds:[125h], 0	;@03807
	je	@@2	;@0380C
	mov	word ptr ds:[21Ch], 0FFFFh	;@0380E
@@2:	mov	es, word ptr ds:[776h]	;@03814
	mov	di, word ptr es:[bx+2]	;@03818
	cmp	di, word ptr ds:[450h]	;@0381C
	je	@@3	;@03820
	cmp	word ptr ds:[21Ch], -1	;@03822
	je	L0384F	;@03827
	mov	di, word ptr es:[bx+2]	;@03829
	cmp	di, word ptr ds:[44Eh]	;@0382D
	je	@@3	;@03831
	cmp	di, word ptr ds:[450h]	;@03833
	jne	L0384F	;@03837
@@3:	test	al, 4	;@03839
	je	@@4	;@0383B
	mov	es, word ptr ds:[77Eh]	;@0383D
	test	word ptr es:[bx+6], 0FFF0h	;@03841
	je	@@4	;@03847
	call	L03856	;@03849
@@4:	call	L03205	;@0384C
L0384F:	mov	di, 3FFh	;@0384F
	and	di, dx	;@03852
	clc	;@03854
	ret	;@03855
L03856:	mov	es, word ptr ds:[77Eh]	;@03856
	mov	di, word ptr es:[bx]	;@0385A
	mov	es, word ptr ds:[79Eh]	;@0385D
	cmp	byte ptr es:[di+1], 1	;@03861
	jb	@@1	;@03866
	and	byte ptr ds:[215h], 0FBh	;@03868
	mov	di, word ptr es:[di+4]	;@0386D
	mov	es, word ptr ds:[77Eh]	;@03871
	mov	ax, word ptr es:[bx+6]	;@03875
	and	al, 0F0h	;@03879
	add	cx, ax	;@0387B
	mov	al, byte ptr es:[bx+8]	;@0387D
	mov	ah, 0	;@03881
	adc	word ptr ds:[420h], ax	;@03883
	mov	bx, di	;@03887
	ret	;@03889
@@1:	pop	di	;@0388A
L0388B:	jmp	L0391A	;@0388B
L0388E:	sub	bp, bp	;@0388E
	and	al, 3	;@03890
	cmp	al, 2	;@03892
	je	L0388B	;@03894
	jmp	L0384F	;@03896
L03898:	cmp	bx, di	;@03898
	jne	L038B0	;@0389A
	sub	cx, word ptr ds:[21Eh]	;@0389C
	push	dx	;@038A0
	mov	dx, word ptr ds:[420h]	;@038A1
	sbb	dx, word ptr ds:[220h]	;@038A5
	mov	word ptr ds:[420h], dx	;@038A9
	pop	dx	;@038AD
	jmp	L0384F	;@038AE
L038B0:	cmp	byte ptr ds:[17h], 0	;@038B0
	jne	L0388B	;@038B5
	cmp	word ptr es:[di+4], -1	;@038B7
	jne	L0388B	;@038BC
	mov	ax, word ptr es:[bx]	;@038BE
	cmp	ax, word ptr es:[di]	;@038C1
	jne	@@2	;@038C4
	mov	ax, word ptr es:[di+6]	;@038C6
	sub	ax, word ptr es:[bx+6]	;@038CA
	mov	al, byte ptr es:[di+8]	;@038CE
	sbb	al, byte ptr es:[bx+8]	;@038D2
	jb	@@1	;@038D6
	jmp	L037C4	;@038D8
@@1:	add	cx, word ptr es:[bx+6]	;@038DB
	sub	cx, word ptr es:[di+6]	;@038DF
	adc	cl, byte ptr es:[bx+8]	;@038E3
	sbb	cl, byte ptr es:[di+8]	;@038E7
	jmp	L0388B	;@038EB
@@2:	push	bx	;@038ED
	push	di	;@038EE
	mov	di, word ptr es:[di]	;@038EF
	mov	bx, word ptr es:[bx]	;@038F2
	mov	es, word ptr ds:[79Eh]	;@038F5
	mov	ax, word ptr es:[di+8]	;@038F9
	sub	ax, word ptr es:[bx+8]	;@038FD
	pop	di	;@03901
	pop	bx	;@03902
	test	ah, 0F0h	;@03903
	jne	L0388B	;@03906
	shl	ax, 1	;@03908
	shl	ax, 1	;@0390A
	shl	ax, 1	;@0390C
	shl	ax, 1	;@0390E
	add	cx, ax	;@03910
	jb	@@3	;@03912
	jmp	L037C4	;@03914
@@3:	jmp	L0388B	;@03917
L0391A:	push	dx	;@0391A
	push	si	;@0391B
	push	di	;@0391C
	push	cx	;@0391D
	xor	dx, dx	;@0391E
	mov	ax, word ptr ds:[224h]	;@03920
	and	ax, 3FFh	;@03923
	add	ax, word ptr ds:[3E8h]	;@03926
	adc	dx, word ptr ds:[3EAh]	;@0392A
	mov	si, word ptr ds:[3E6h]	;@0392E
	mov	es, word ptr ds:[77Eh]	;@03932
	sub	ax, word ptr es:[si+6]	;@03936
	sbb	dl, byte ptr es:[si+8]	;@0393A
	push	ax	;@0393E
	cmp	byte ptr ds:[125h], 0	;@0393F
	je	@@1	;@03944
	push	dx	;@03946
@@1:	mov	si, word ptr ds:[3E6h]	;@03947
	mov	es, word ptr ds:[776h]	;@0394B
	mov	si, word ptr es:[si]	;@0394F
	mov	di, 0C6h	;@03952
	call	COPY_NAME	;@03955
	mov	ax, 0C6h	;@03958
	push	ds	;@0395B
	push	ax	;@0395C
	mov	ax, 24D0h	;@0395D
	cmp	byte ptr ds:[125h], 0	;@03960
	je	@@2	;@03965
	mov	ax, 24D6h	;@03967
@@2:	push	cs	;@0396A
	push	ax	;@0396B
	mov	ax, 26h	;@0396C
	push	ds	;@0396F
	push	ax	;@03970
	push	cs	;@03971
	call	FORMAT	;@03972
	mov	si, word ptr ds:[218h]	;@03975
	inc	si	;@03979
	je	@@3	;@0397A
	dec	si	;@0397C
	mov	di, 76h	;@0397D
	call	COPY_NAME	;@03980
	add	sp, 4	;@03983
	jmp	short @@6	;@03986
@@3:	pop	ax	;@03988
	mov	dx, word ptr ds:[420h]	;@03989
	add	ax, word ptr ds:[21Eh]	;@0398D
	adc	dx, word ptr ds:[220h]	;@03991
	pop	si	;@03995
	push	ax	;@03996
	cmp	byte ptr ds:[125h], 0	;@03997
	je	@@4	;@0399C
	push	dx	;@0399E
@@4:	mov	es, word ptr ds:[776h]	;@0399F
	mov	si, word ptr es:[si]	;@039A3
	mov	di, 0C6h	;@039A6
	call	COPY_NAME	;@039A9
	mov	ax, 0C6h	;@039AC
	push	ds	;@039AF
	push	ax	;@039B0
	mov	ax, 24D0h	;@039B1
	cmp	byte ptr ds:[125h], 0	;@039B4
	je	@@5	;@039B9
	mov	ax, 24D6h	;@039BB
@@5:	push	cs	;@039BE
	push	ax	;@039BF
	push	ds	;@039C0
	mov	ax, 76h	;@039C1
	push	ax	;@039C4
	push	cs	;@039C5
	call	FORMAT	;@039C6
@@6:	mov	ax, 76h	;@039C9
	push	ds	;@039CC
	push	ax	;@039CD
	mov	ax, 26h	;@039CE
	push	ds	;@039D1
	push	ax	;@039D2
	mov	ax, 8	;@039D3
	push	ax	;@039D6
	mov	ax, 23h	;@039D7
	push	ax	;@039DA
	mov	word ptr ds:[422h], 1	;@039DB
	call	ERROR	;@039E1
	pop	si	;@039E4
	pop	dx	;@039E5
	jmp	short L03A32	;@039E6
L039E8:	test	byte ptr es:[bx+0Eh], 40h	;@039E8
	jne	L03A32	;@039ED
	or	byte ptr es:[bx+0Eh], 40h	;@039EF
	mov	bx, word ptr ds:[218h]	;@039F4
	push	bx	;@039F8
	push	si	;@039F9
	mov	si, bx	;@039FA
	mov	di, 26h	;@039FC
	push	ds	;@039FF
	push	di	;@03A00
	push	si	;@03A01
	and	si, 3	;@03A02
	shl	si, 1	;@03A05
	shl	si, 1	;@03A07
	shl	si, 1	;@03A09
	mov	es, word ptr [si+716h]	;@03A0B
	pop	si	;@03A0F
	cmp	byte ptr es:[si+3], 40h	;@03A10
	je	@@1	;@03A15
	call	COPY_NAME	;@03A17
	jmp	short @@2	;@03A1A
@@1:	call	DEMANGLE_NAME	;@03A1C
@@2:	mov	word ptr ds:[422h], 1	;@03A1F
	mov	cx, 4	;@03A25
	push	cx	;@03A28
	mov	ax, 26h	;@03A29
	push	ax	;@03A2C
	call	ERROR	;@03A2D
	pop	si	;@03A30
	pop	bx	;@03A31
L03A32:	stc	;@03A32
	ret	;@03A33
L03A34:	push	ax	;@03A34
	push	es	;@03A35
	mov	es, word ptr ds:[375h]	;@03A36
	mov	ax, word ptr es:[si]	;@03A3A
	cmp	ax, word ptr es:[di]	;@03A3D
	jne	@@1	;@03A40
	cmp	si, di	;@03A42
@@1:	pop	es	;@03A44
	pop	ax	;@03A45
	ret	;@03A46
L03A47:	push	bp	;@03A47
	call	L029E2	;@03A48
	mov	bx, 2A0h	;@03A4B
	mov	di, 4D8h	;@03A4E
	mov	cx, word ptr ds:[38Dh]	;@03A51
	mov	ax, word ptr [di+0Eh]	;@03A55
	inc	ax	;@03A58
	jcxz	@@1	;@03A59
	sub	ax, cx	;@03A5B
	xchg	ax, cx	;@03A5D
	jmp	short @@2	;@03A5E
@@1:	xor	cx, cx	;@03A60
@@2:	mov	word ptr [bx+4], ax	;@03A62
	mov	word ptr [bx+6], cx	;@03A65
	mov	ax, word ptr ds:[2A6h]	;@03A68
	and	ax, ax	;@03A6B
	jne	@@3	;@03A6D
	mov	word ptr ds:[2A4h], ax	;@03A6F
@@3:	mov	si, word ptr ds:[365h]	;@03A72
	mov	word ptr ds:[2AEh], si	;@03A76
	mov	si, 2A0h	;@03A7A
	mov	cx, 10h	;@03A7D
	mov	bp, 47Eh	;@03A80
	mov	bx, 30Dh	;@03A83
	call	L051DC	;@03A86
	cmp	word ptr ds:[512h], 0	;@03A89
	je	@@4	;@03A8E
	mov	si, 2B0h	;@03A90
	mov	ax, word ptr ds:[554h]	;@03A93
	mov	word ptr [si+2], ax	;@03A96
	mov	ax, word ptr ds:[552h]	;@03A99
	mov	word ptr [si+6], ax	;@03A9C
	add	word ptr ds:[3A1h], ax	;@03A9F
	mov	cx, 8	;@03AA3
	mov	bp, 47Eh	;@03AA6
	mov	bx, 345h	;@03AA9
	call	L051DC	;@03AAC
@@4:	mov	ax, word ptr ds:[4E2h]	;@03AAF
	sub	ax, 17h	;@03AB2
	mov	bx, word ptr ds:[38Fh]	;@03AB5
	mov	word ptr ds:[38Fh], ax	;@03AB9
	sub	ax, bx	;@03ABC
	xor	dx, dx	;@03ABE
	shl	ax, 1	;@03AC0
	rcl	dx, 1	;@03AC2
	shl	ax, 1	;@03AC4
	rcl	dx, 1	;@03AC6
	shl	ax, 1	;@03AC8
	rcl	dx, 1	;@03ACA
	add	word ptr ds:[321h], ax	;@03ACC
	adc	word ptr ds:[323h], dx	;@03AD0
	cmp	word ptr ds:[54Eh], 0	;@03AD4
	jne	@@5	;@03AD9
	jmp	@@12	;@03ADB
@@5:	cmp	word ptr ds:[365h], 0	;@03ADE
	jne	@@6	;@03AE3
	jmp	@@12	;@03AE5
@@6:	mov	cx, word ptr ds:[365h]	;@03AE8
	cmp	cx, 1	;@03AEC
	jbe	@@7	;@03AEF
	shl	cx, 1	;@03AF1
	mov	bp, offset L03A34	;@03AF3
	mov	es, word ptr ds:[379h]	;@03AF6
	call L09252	;@03AFA
@@7:	mov	ax, word ptr ds:[4F6h]	;@03AFD
	inc	ax	;@03B00
	mov	cx, word ptr ds:[365h]	;@03B01
	add	word ptr ds:[4F6h], cx	;@03B05
	xor	si, si	;@03B09
@@8:	mov	es, word ptr ds:[379h]	;@03B0B
	mov	di, word ptr es:[si]	;@03B0F
	mov	es, word ptr ds:[375h]	;@03B12
	mov	bx, word ptr es:[di]	;@03B16
	mov	bp, bx	;@03B19
	dec	bx	;@03B1B
	shl	bx, 1	;@03B1C
	shl	bx, 1	;@03B1E
	shl	bx, 1	;@03B20
	shl	bx, 1	;@03B22
	mov	es, word ptr ds:[371h]	;@03B24
	mov	word ptr es:[bx+0Ch], ax	;@03B28
	mov	es, word ptr ds:[375h]	;@03B2C
	push	ds	;@03B30
	mov	ds, word ptr ds:[379h]	;@03B31
	mov	dx, 1	;@03B35
	dec	cx	;@03B38
	je	@@10	;@03B39
@@9:	inc	si	;@03B3B
	inc	si	;@03B3C
	mov	di, word ptr [si]	;@03B3D
	cmp	bp, word ptr es:[di]	;@03B3F
	jne	@@10	;@03B42
	inc	dx	;@03B44
	loop	@@9	;@03B45
@@10:	pop	ds	;@03B47
	mov	es, word ptr ds:[371h]	;@03B48
	mov	word ptr es:[bx+0Eh], dx	;@03B4C
	add	ax, dx	;@03B50
	inc	cx	;@03B52
	loop	@@8	;@03B53
	mov	cx, word ptr ds:[365h]	;@03B55
	xor	bx, bx	;@03B59
@@11:	push	bx	;@03B5B
	push	cx	;@03B5C
	mov	es, word ptr ds:[379h]	;@03B5D
	mov	si, word ptr es:[bx]	;@03B61
	mov	cx, 8	;@03B64
	mov	bx, 331h	;@03B67
	mov	bp, 375h	;@03B6A
	call	L051DC	;@03B6D
	pop	cx	;@03B70
	pop	bx	;@03B71
	add	bx, 2	;@03B72
	loop	@@11	;@03B75
@@12:	mov	cx, word ptr ds:[55Ch]	;@03B77
	jcxz	@@13	;@03B7B
	jmp	short @@14	;@03B7D
@@13:	jmp	@@18	;@03B7F
@@14:	xor	si, si	;@03B82
	xor	di, di	;@03B84
	push	cx	;@03B86
@@15:	mov	es, word ptr ds:[3B8h]	;@03B87
	mov	word ptr es:[di], si	;@03B8B
	mov	es, word ptr ds:[3B4h]	;@03B8E
	mov	dx, word ptr es:[si+2]	;@03B92
	shl	dx, 1	;@03B96
	add	si, 4	;@03B98
	add	si, dx	;@03B9B
	inc	di	;@03B9D
	inc	di	;@03B9E
	loop	@@15	;@03B9F
	pop	cx	;@03BA1
	push	cx	;@03BA2
	mov	bp, offset L0441E	;@03BA3
	shl	cx, 1	;@03BA6
	mov	es, word ptr ds:[3B8h]	;@03BA8
	call L09252	;@03BAC
	pop	cx	;@03BAF
	xor	di, di	;@03BB0
	mov	dx, 0FFFFh	;@03BB2
@@16:	push	cx	;@03BB5
	mov	es, word ptr ds:[3B8h]	;@03BB6
	mov	si, word ptr es:[di]	;@03BBA
	mov	es, word ptr ds:[3B4h]	;@03BBD
	mov	bx, word ptr es:[si]	;@03BC1
	cmp	bx, dx	;@03BC4
	je	@@17	;@03BC6
	push	si	;@03BC8
	mov	dx, bx	;@03BC9
	push	dx	;@03BCB
	call	L02A54	;@03BCC
	xor	dx, dx	;@03BCF
	mov	ax, si	;@03BD1
	mov	bx, 10h	;@03BD3
	div	bx	;@03BD6
	shl	ax, 1	;@03BD8
	mov	bx, 47Eh	;@03BDA
	mov	si, 3C4h	;@03BDD
	mov	dx, word ptr ds:[3C0h]	;@03BE0
	add	ax, word ptr ds:[3BEh]	;@03BE4
	mov	cx, 2	;@03BE8
	push	di	;@03BEB
	call L08AC5	;@03BEC
	pop	di	;@03BEF
	pop	dx	;@03BF0
	pop	si	;@03BF1
@@17:	push	dx	;@03BF2
	inc	si	;@03BF3
	inc	si	;@03BF4
	mov	es, word ptr ds:[3B4h]	;@03BF5
	mov	cx, word ptr es:[si]	;@03BF9
	add	word ptr ds:[3C4h], cx	;@03BFC
	shl	cx, 1	;@03C00
	inc	si	;@03C02
	inc	si	;@03C03
	mov	bx, 3B4h	;@03C04
	mov	dx, word ptr ds:[3BCh]	;@03C07
	mov	ax, word ptr ds:[3BAh]	;@03C0B
	add	word ptr ds:[3BAh], cx	;@03C0E
	adc	word ptr ds:[3BCh], 0	;@03C12
	push	di	;@03C17
	call L08AC5	;@03C18
	pop	di	;@03C1B
	pop	dx	;@03C1C
	pop	cx	;@03C1D
	inc	di	;@03C1E
	inc	di	;@03C1F
	loop	@@16	;@03C20
	mov	word ptr ds:[3B2h], 0	;@03C22
@@18:	pop	bp	;@03C28
	ret	;@03C29
; P2_MODEND: pass 2, MODEND (8Ah).
P2_MODEND:	inc	byte ptr ds:[492h]	;@03C2A
	call	L03083	;@03C2E
	mov	al, byte ptr [si]	;@03C31
	cmp	al, 0C1h	;@03C33
	je	@@1	;@03C35
	jmp	L03CD9	;@03C37
@@1:	cmp	word ptr ds:[4B0h], -1	;@03C3A
	je	@@2	;@03C3F
	jmp	L03CD9	;@03C41
@@2:	inc	si	;@03C44
	mov	dx, 0CC00h	;@03C45
	call	L032FC	;@03C48
	mov	es, word ptr ds:[776h]	;@03C4B
	push	si	;@03C4F
	mov	si, bx	;@03C50
	call	L09591	;@03C52
	pop	si	;@03C55
	cmp	al, 2	;@03C56
	jl	@@3	;@03C58
	xor	cx, cx	;@03C5A
	push	cx	;@03C5C
	mov	ax, 27h	;@03C5D
	push	ax	;@03C60
	call	ERROR	;@03C61
@@3:	mov	es, word ptr ds:[77Eh]	;@03C64
	mov	ax, word ptr es:[bx+6]	;@03C68
	mov	bx, word ptr es:[bx]	;@03C6C
	mov	es, word ptr ds:[79Eh]	;@03C6F
	cmp	byte ptr ds:[17h], 0	;@03C73
	je	@@4	;@03C78
	mov	bx, word ptr es:[bx+6]	;@03C7A
	jmp	short @@5	;@03C7E
@@4:	mov	bx, word ptr es:[bx+8]	;@03C80
	test	byte ptr ds:[215h], 4	;@03C84
	je	@@5	;@03C89
	push	cx	;@03C8B
	mov	cl, 4	;@03C8C
	shr	ax, cl	;@03C8E
	add	bx, ax	;@03C90
	pop	cx	;@03C92
@@5:	mov	word ptr ds:[4AEh], cx	;@03C93
	mov	word ptr ds:[4B0h], bx	;@03C97
	mov	word ptr ds:[6B1h], cx	;@03C9B
	mov	word ptr ds:[6B3h], bx	;@03C9F
	cmp	byte ptr ds:[129h], 1	;@03CA3
	jne	L03CC3	;@03CA8
	and	bx, bx	;@03CAA
	jne	L03CB9	;@03CAC
	cmp	cx, 100h	;@03CAE
	je	L03CC3	;@03CB2
	call	L0937E	;@03CB4
	jne	L03CC3	;@03CB7
L03CB9:	xor	ax, ax	;@03CB9
	push	ax	;@03CBB
	mov	ax, 15h	;@03CBC
	push	ax	;@03CBF
	call FATAL	;@03CC0
L03CC3:	cmp	word ptr ds:[420h], 0	;@03CC3
	je	L03CD9	;@03CC8
	xor	ax, ax	;@03CCA
	push	ax	;@03CCC
	mov	ax, 29h	;@03CCD
	push	ax	;@03CD0
	call ERROR	;@03CD1
	or	byte ptr ds:[410h], 1	;@03CD4
L03CD9:	cmp	byte ptr ds:[14h], 0	;@03CD9
	je	L03CE3	;@03CDE
	call	L03A47	;@03CE0
L03CE3:	cmp	byte ptr ds:[3D2h], 1	;@03CE3
	jb	@@4	;@03CE8
	je	@@1	;@03CEA
	mov	di, word ptr ds:[3E2h]	;@03CEC
	push	di	;@03CF0
	and	di, 3	;@03CF1
	shl	di, 1	;@03CF4
	shl	di, 1	;@03CF6
	shl	di, 1	;@03CF8
	mov	es, word ptr [di+736h]	;@03CFA
	pop	di	;@03CFE
	cmp	word ptr es:[di+0Ah], 2	;@03CFF
	jae	@@1	;@03D04
	mov	di, word ptr ds:[228h]	;@03D06
	jmp L09003	;@03D0A
@@1:	mov	si, word ptr ds:[3E0h]	;@03D0D
	inc	si	;@03D11
	push	ds	;@03D12
	pop	es	;@03D13
@@2:	mov	cx, word ptr ds:[3458h]	;@03D14
	sub	cx, si	;@03D18
	cmp	cx, 2	;@03D1A
	jae	@@3	;@03D1D
	call L087E1	;@03D1F
	jmp	@@2	;@03D22
@@3:	sub	ax, ax	;@03D24
	mov	di, si	;@03D26
	shr	cx, 1	;@03D28
	repe scasw	;@03D2A
	mov	si, di	;@03D2C
	je	@@2	;@03D2E
	dec	si	;@03D30
	dec	si	;@03D31
	cmp	byte ptr [si], 1	;@03D32
	adc	si, ax	;@03D35
	jmp L059B4	;@03D37
@@4:	ret	;@03D3A
L03D3B:	push	si	;@03D3B
	cmp	word ptr ds:[39Bh], -1	;@03D3C
	jne	@@1	;@03D41
	push	ax	;@03D43
	push	cx	;@03D44
	push	dx	;@03D45
	push	si	;@03D46
	mov	word ptr ds:[17Ah], 0FFFFh	;@03D47
	mov	ax, word ptr ds:[22Ah]	;@03D4D
	call	L02E02	;@03D50
	pop	si	;@03D53
	pop	dx	;@03D54
	pop	cx	;@03D55
	pop	ax	;@03D56
@@1:	push	bx	;@03D57
	mov	bx, word ptr ds:[3E0h]	;@03D58
	sub	bx, si	;@03D5C
	shr	bx, 1	;@03D5E
	shr	bx, 1	;@03D60
	or	dx, dx	;@03D62
	je	@@2	;@03D64
	add	sp, 2	;@03D66
	cmp	dx, word ptr ds:[17Ah]	;@03D69
	jne	@@3	;@03D6D
	mov	si, word ptr ds:[385h]	;@03D6F
	sub	si, 8	;@03D73
	mov	es, word ptr ds:[375h]	;@03D76
	jmp	short @@5	;@03D7A
@@2:	pop	dx	;@03D7C
	push	ax	;@03D7D
	push	bx	;@03D7E
	push	cx	;@03D7F
	mov	word ptr ds:[393h], 0FFFFh	;@03D80
	mov	word ptr ds:[17Ah], 0FFFFh	;@03D86
	mov	bx, dx	;@03D8C
	jmp	short @@4	;@03D8E
@@3:	mov	word ptr ds:[17Ah], dx	;@03D90
	push	ax	;@03D94
	push	bx	;@03D95
	push	cx	;@03D96
	mov	bx, dx	;@03D97
	mov	word ptr ds:[393h], bx	;@03D99
	dec	bx	;@03D9D
	xchg	ax, bx	;@03D9E
	mov	ah, 0Ah	;@03D9F
	mul	ah	;@03DA1
	xchg	ax, bx	;@03DA3
	add	bx, word ptr ds:[52Ah]	;@03DA4
@@4:	call	L02A54	;@03DA8
	mov	si, word ptr ds:[385h]	;@03DAB
	add	word ptr ds:[385h], 8	;@03DAF
	mov	es, word ptr ds:[375h]	;@03DB4
	mov	word ptr es:[si], ax	;@03DB8
	mov	ax, word ptr ds:[39Bh]	;@03DBB
	mov	word ptr es:[si+2], ax	;@03DBE
	mov	ax, word ptr ds:[4F0h]	;@03DC2
	inc	ax	;@03DC5
	mov	word ptr es:[si+4], ax	;@03DC6
	mov	word ptr es:[si+6], 0	;@03DCA
	push	es	;@03DD0
	mov	es, word ptr ds:[379h]	;@03DD1
	mov	di, word ptr ds:[387h]	;@03DD5
	mov	ax, si	;@03DD9
	stosw	;@03DDB
	mov	word ptr ds:[387h], di	;@03DDC
	pop	es	;@03DE0
	pop	cx	;@03DE1
	pop	bx	;@03DE2
	pop	ax	;@03DE3
	inc	word ptr ds:[365h]	;@03DE4
@@5:	add	word ptr es:[si+6], bx	;@03DE8
	add	word ptr ds:[4F0h], bx	;@03DEC
	xchg	cx, bx	;@03DF0
	pop	si	;@03DF2
	mov	dx, si	;@03DF3
	inc	si	;@03DF5
	inc	si	;@03DF6
	push	cx	;@03DF7
@@6:	add	word ptr [si], bx	;@03DF8
	add	si, 4	;@03DFA
	loop	@@6	;@03DFD
	mov	si, dx	;@03DFF
	pop	cx	;@03E01
	shl	cx, 1	;@03E02
	shl	cx, 1	;@03E04
	mov	bp, 47Eh	;@03E06
	mov	bx, 315h	;@03E09
	call	L051DC	;@03E0C
	mov	si, word ptr ds:[3E0h]	;@03E0F
	ret	;@03E13
; P2_LINNUM: pass 2, LINNUM (94h): line numbers for the map (/l).
P2_LINNUM:	cmp	byte ptr ds:[3478h], 0	;@03E14
	jne	@@1	;@03E19
	cmp	byte ptr ds:[15h], 0	;@03E1B
	jne	@@2	;@03E20
@@1:	cmp	byte ptr ds:[11Fh], 1	;@03E22
	je	@@2	;@03E27
	jmp	L059AB	;@03E29
@@2:	cmp	byte ptr [si], 80h	;@03E2C
	sbb	si, -2	;@03E2F
	sub	bx, bx	;@03E32
	add	bl, byte ptr [si]	;@03E34
	jge	@@3	;@03E36
	inc	si	;@03E38
	sub	bl, 80h	;@03E39
	mov	bh, bl	;@03E3C
	mov	bl, byte ptr [si]	;@03E3E
@@3:	inc	si	;@03E40
	cmp	bx, 4000h	;@03E41
	jle	@@4	;@03E45
	jmp	@@17	;@03E47
@@4:	mov	dx, bx	;@03E4A
	dec	bx	;@03E4C
	xchg	ax, bx	;@03E4D
	mov	ah, 0Ah	;@03E4E
	mul	ah	;@03E50
	xchg	ax, bx	;@03E52
	add	bx, word ptr ds:[52Ah]	;@03E53
	mov	es, word ptr ds:[77Eh]	;@03E57
	mov	cx, word ptr es:[bx+6]	;@03E5B
	mov	di, word ptr es:[bx]	;@03E5F
@@5:	xor	bp, bp	;@03E62
	cmp	byte ptr ds:[125h], 0	;@03E64
	je	@@6	;@03E69
	xchg	ax, bp	;@03E6B
	mov	al, byte ptr es:[bx+8]	;@03E6C
	mov	ah, 0	;@03E70
	xchg	ax, bp	;@03E72
@@6:	mov	es, word ptr ds:[79Eh]	;@03E73
	mov	ax, word ptr es:[di+8]	;@03E77
	cmp	byte ptr ds:[17h], 0	;@03E7B
	je	@@7	;@03E80
	mov	ax, word ptr es:[di+6]	;@03E82
@@7:	cmp	byte ptr ds:[15h], 0	;@03E86
	je	@@9	;@03E8B
	cmp	byte ptr ds:[3478h], 0	;@03E8D
	jne	@@8	;@03E92
	push	ax	;@03E94
	push	bx	;@03E95
	push	si	;@03E96
	push	bp	;@03E97
	call	L03D3B	;@03E98
	pop	bp	;@03E9B
	pop	si	;@03E9C
	pop	bx	;@03E9D
	pop	ax	;@03E9E
	xor	cx, cx	;@03E9F
@@8:	cmp	byte ptr ds:[11Fh], 1	;@03EA1
	je	@@9	;@03EA6
	jmp	L059AB	;@03EA8
@@9:	mov	dx, ax	;@03EAB
	mov	di, word ptr ds:[7641h]	;@03EAD
	cmp	bx, word ptr ds:[226h]	;@03EB1
	mov	word ptr ds:[226h], bx	;@03EB5
	je	@@10	;@03EB9
	push	si	;@03EBB
	call	PUT_INLINE	;@03EBC
	db	11h, 'Line numbers for '	;@03EBF
	call	L09A0A	;@03ED1
	mov	al, 28h	;@03ED4
	call	PUT_CHAR	;@03ED6
	call	L090E6	;@03ED9
	call	PUT_INLINE	;@03EDC
	db	0Ah, ') segment '	;@03EDF
	mov	es, word ptr ds:[776h]	;@03EEA
	mov	si, word ptr es:[bx]	;@03EEE
	call	PUT_PLAIN_NAME	;@03EF1
	call	PUT_NEWLINE	;@03EF4
	call	PUT_NEWLINE	;@03EF7
	pop	si	;@03EFA
@@10:	xor	bx, bx	;@03EFB
	jmp	short @@14	;@03EFD
@@11:	cmp	bx, 4	;@03EFF
	jb	@@12	;@03F02
	call	PUT_NEWLINE	;@03F04
	xor	bx, bx	;@03F07
@@12:	inc	bx	;@03F09
	lodsw	;@03F0A
	push	cx	;@03F0B
	mov	cx, 5	;@03F0C
	call	L092F5	;@03F0F
	pop	cx	;@03F12
	mov	al, 20h	;@03F13
	call	PUT_CHAR	;@03F15
	mov	ax, dx	;@03F18
	call	PUT_HEX_WORD	;@03F1A
	mov	al, 3Ah	;@03F1D
	call	PUT_CHAR	;@03F1F
	lodsw	;@03F22
	cmp	byte ptr ds:[125h], 0	;@03F23
	jne	@@15	;@03F28
	add	ax, cx	;@03F2A
@@13:	call	PUT_HEX_WORD	;@03F2C
@@14:	cmp	si, word ptr ds:[3E0h]	;@03F2F
	jb	@@11	;@03F33
	call	PUT_NEWLINE	;@03F35
	mov	word ptr ds:[7641h], di	;@03F38
	jmp	L059AB	;@03F3C
@@15:	push	dx	;@03F3F
	xor	dx, dx	;@03F40
	cmp	word ptr ds:[41Eh], 0	;@03F42
	je	@@16	;@03F47
	mov	dx, word ptr [si]	;@03F49
	inc	si	;@03F4B
	inc	si	;@03F4C
@@16:	add	ax, cx	;@03F4D
	adc	dx, bp	;@03F4F
	push	ax	;@03F51
	mov	ax, dx	;@03F52
	call	PUT_HEX_WORD	;@03F54
	pop	ax	;@03F57
	pop	dx	;@03F58
	jmp	@@13	;@03F59
@@17:	sub	bx, 4001h	;@03F5B
	shl	bx, 1	;@03F5F
	add	bx, word ptr ds:[52Ch]	;@03F61
	mov	es, word ptr ds:[786h]	;@03F65
	mov	bx, word ptr es:[bx]	;@03F69
	push	bx	;@03F6C
	and	bx, 3	;@03F6D
	shl	bx, 1	;@03F70
	shl	bx, 1	;@03F72
	shl	bx, 1	;@03F74
	mov	es, word ptr [bx+756h]	;@03F76
	pop	bx	;@03F7A
	mov	ax, word ptr es:[bx+2]	;@03F7B
	cmp	ax, word ptr ds:[228h]	;@03F7F
	jne	@@18	;@03F83
	mov	cx, word ptr es:[bx+4]	;@03F85
	mov	bx, word ptr es:[bx]	;@03F89
	mov	es, word ptr ds:[77Eh]	;@03F8C
	mov	di, word ptr es:[bx]	;@03F90
	xor	dx, dx	;@03F93
	jmp	@@5	;@03F95
@@18:	jmp	L059AB	;@03F98
L03F9B:	push	si	;@03F9B
	mov	si, 0C4Eh	;@03F9C
	add	di, si	;@03F9F
	sub	bx, bx	;@03FA1
	mov	ax, word ptr ds:[3E4h]	;@03FA3
	add	ax, 0C4Eh	;@03FA6
@@1:	push	ax	;@03FA9
	call	@@2	;@03FAA
	pop	ax	;@03FAD
	cmp	si, ax	;@03FAE
	jb	@@1	;@03FB0
	pop	si	;@03FB2
	ret	;@03FB3
@@2:	push	bp	;@03FB4
	push	cx	;@03FB5
	lodsw	;@03FB6
	mov	cx, ax	;@03FB7
	mov	bp, si	;@03FB9
	cmp	word ptr ds:[3ECh], 0	;@03FBB
	je	@@3	;@03FC0
	lodsw	;@03FC2
@@3:	mov	si, bp	;@03FC3
	lodsw	;@03FC5
	push	cx	;@03FC6
	mov	cx, ax	;@03FC7
	jcxz	@@5	;@03FC9
@@4:	call	@@2	;@03FCB
	loop	@@4	;@03FCE
	jmp	short @@7	;@03FD0
@@5:	lodsb	;@03FD2
	sub	ah, ah	;@03FD3
	cmp	di, si	;@03FD5
	jb	@@6	;@03FD7
	mov	dx, si	;@03FD9
	add	dx, ax	;@03FDB
	cmp	di, dx	;@03FDD
	jae	@@6	;@03FDF
	push	di	;@03FE1
	sub	di, si	;@03FE2
	add	di, bx	;@03FE4
	call	word ptr ds:[222h]	;@03FE6
	pop	di	;@03FEA
@@6:	add	si, ax	;@03FEB
	add	bx, ax	;@03FED
@@7:	pop	cx	;@03FEF
	loop	@@3	;@03FF0
	pop	cx	;@03FF2
	pop	bp	;@03FF3
	ret	;@03FF4
L03FF5:	add	di, word ptr ds:[3E8h]	;@03FF5
	mov	word ptr ds:[660h], di	;@03FF9
	sub	di, word ptr ds:[3E8h]	;@03FFD
L04001:	push	es	;@04001
	push	si	;@04002
	push	di	;@04003
	push	ax	;@04004
	push	bx	;@04005
	push	cx	;@04006
	push	dx	;@04007
	mov	si, word ptr ds:[3E6h]	;@04008
	mov	es, word ptr ds:[77Eh]	;@0400C
	mov	si, word ptr es:[si]	;@04010
	mov	es, word ptr ds:[79Eh]	;@04013
	mov	ax, word ptr es:[si+0Dh]	;@04017
	mov	dx, word ptr es:[si+11h]	;@0401B
	inc	word ptr es:[si+11h]	;@0401F
	call	L05C58	;@04023
	mov	bx, word ptr es:[si+8]	;@04026
	mov	cl, byte ptr es:[si+0Ah]	;@0402A
	mov	ch, 0	;@0402E
	add	bx, word ptr ds:[3FEh]	;@04030
	adc	cl, ch	;@04034
	shl	bx, 1	;@04036
	rcl	cx, 1	;@04038
	shl	bx, 1	;@0403A
	rcl	cx, 1	;@0403C
	shl	bx, 1	;@0403E
	rcl	cx, 1	;@04040
	shl	bx, 1	;@04042
	rcl	cx, 1	;@04044
	add	ax, bx	;@04046
	adc	dx, cx	;@04048
	mov	cx, word ptr ds:[400h]	;@0404A
	mov	si, word ptr ds:[402h]	;@0404E
	call	L08B1D	;@04052
	pop	dx	;@04055
	pop	cx	;@04056
	pop	bx	;@04057
	pop	ax	;@04058
	pop	di	;@04059
	pop	si	;@0405A
	pop	es	;@0405B
	ret	;@0405C
L0405D:	test	byte ptr ds:[215h], 1	;@0405D
	je	@@2	;@04062
	ret	;@04064
@@1:	xor	ax, ax	;@04065
	push	ax	;@04067
	mov	ax, 16h	;@04068
	push	ax	;@0406B
	call	FATAL	;@0406C
@@2:	cmp	byte ptr ds:[129h], 1	;@0406F
	je	@@1	;@04074
	inc	word ptr ds:[4A0h]	;@04076
	push	ax	;@0407A
	push	bx	;@0407B
	push	cx	;@0407C
	push	dx	;@0407D
	push	si	;@0407E
	push	di	;@0407F
	push	bp	;@04080
	cmp	word ptr ds:[3ECh], 0	;@04081
	je	@@3	;@04086
	xor	bx, bx	;@04088
	add	di, word ptr ds:[3E8h]	;@0408A
	adc	bx, word ptr ds:[3EAh]	;@0408E
	je	@@4	;@04092
	mov	word ptr ds:[422h], 1	;@04094
	xor	ax, ax	;@0409A
	push	ax	;@0409C
	mov	ax, 18h	;@0409D
	push	ax	;@040A0
	call	FATAL	;@040A1
@@3:	add	di, word ptr ds:[3E8h]	;@040A4
@@4:	mov	word ptr ds:[496h], di	;@040A8
	mov	di, word ptr ds:[3EEh]	;@040AC
	mov	word ptr ds:[498h], di	;@040B0
	mov	ax, word ptr ds:[3F2h]	;@040B4
	mov	dx, word ptr ds:[3F4h]	;@040B7
	mov	cx, 4	;@040BB
	add	word ptr ds:[3F2h], cx	;@040BE
	adc	word ptr ds:[3F4h], 0	;@040C2
	mov	si, 496h	;@040C7
	call	L08B1D	;@040CA
	pop	bp	;@040CD
	pop	di	;@040CE
	pop	si	;@040CF
	pop	dx	;@040D0
	pop	cx	;@040D1
	pop	bx	;@040D2
	pop	ax	;@040D3
	ret	;@040D4
; P2_FIXUPP: pass 2, FIXUPP (9Ch): apply the fixups to the data just read.
P2_FIXUPP:	jmp	@@16	;@040D5
@@1:	jmp	L059AB	;@040D8
@@2:	cbw	;@040DB
	mov	di, ax	;@040DC
	and	di, 3	;@040DE
	test	al, 40h	;@040E1
	jne	@@5	;@040E3
	shr	al, 1	;@040E5
	shr	al, 1	;@040E7
	and	al, 3	;@040E9
	mov	byte ptr [di+232h], al	;@040EB
	shl	di, 1	;@040EF
	cmp	al, 3	;@040F1
	je	@@4	;@040F3
	sub	bx, bx	;@040F5
	add	bl, byte ptr [si]	;@040F7
	jge	@@3	;@040F9
	inc	si	;@040FB
	sub	bl, 80h	;@040FC
	mov	bh, bl	;@040FF
	mov	bl, byte ptr [si]	;@04101
@@3:	inc	si	;@04103
	mov	word ptr [di+236h], bx	;@04104
	jmp	@@16	;@04108
@@4:	mov	bx, word ptr [si]	;@0410B
	add	si, 2	;@0410D
	mov	word ptr [di+236h], bx	;@04110
	jmp	@@16	;@04114
@@5:	shl	al, 1	;@04117
	shl	al, 1	;@04119
	and	al, 7	;@0411B
	mov	byte ptr [di+23Eh], al	;@0411D
	shl	di, 1	;@04121
	cmp	al, 3	;@04123
	je	@@7	;@04125
	sub	bx, bx	;@04127
	add	bl, byte ptr [si]	;@04129
	jge	@@6	;@0412B
	inc	si	;@0412D
	sub	bl, 80h	;@0412E
	mov	bh, bl	;@04131
	mov	bl, byte ptr [si]	;@04133
@@6:	inc	si	;@04135
	mov	word ptr [di+242h], bx	;@04136
	jmp	short @@16	;@0413A
@@7:	mov	bx, word ptr [si]	;@0413C
	add	si, 2	;@0413E
	mov	word ptr [di+242h], bx	;@04141
	jmp	short @@16	;@04145
@@8:	cmp	bx, -3	;@04147
	je	@@10	;@0414A
	cmp	dh, 4	;@0414C
	je	@@14	;@0414F
	jb	@@13	;@04151
	cmp	dh, 10h	;@04153
	ja	@@9	;@04156
	je	@@12	;@04158
@@9:	mov	es, word ptr ds:[77Eh]	;@0415A
	mov	bx, word ptr es:[bx]	;@0415E
@@10:	call	L09BDC	;@04161
	jmp	short @@16	;@04164
@@11:	add	word ptr [di+0C4Eh], cx	;@04166
	mov	ax, word ptr ds:[420h]	;@0416A
	adc	word ptr [di+0C50h], ax	;@0416D
	jmp	short @@16	;@04171
@@12:	mov	cl, ch	;@04173
@@13:	add	byte ptr [di+0C4Eh], cl	;@04175
	jmp	short @@16	;@04179
@@14:	add	word ptr [di+0C4Eh], cx	;@0417B
	test	byte ptr ds:[215h], 40h	;@0417F
	je	@@16	;@04184
	call	L09B96	;@04186
	jmp	short @@16	;@04189
@@15:	cmp	word ptr ds:[41Eh], 1	;@0418B
	je	@@11	;@04190
	add	word ptr [di+0C4Eh], cx	;@04192
@@16:	cmp	si, word ptr ds:[3E0h]	;@04196
	jb	@@17	;@0419A
	jmp	@@1	;@0419C
@@17:	lodsb	;@0419F
	test	al, 80h	;@041A0
	jne	@@18	;@041A2
	jmp	@@2	;@041A4
@@18:	cmp	byte ptr ds:[3F1h], 0FFh	;@041A7
	jne	@@19	;@041AC
	jmp	@@1	;@041AE
@@19:	mov	dh, al	;@041B1
	mov	dl, byte ptr [si]	;@041B3
	inc	si	;@041B5
	call	L032FC	;@041B6
	jb	@@16	;@041B9
	and	dh, 1Ch	;@041BB
	cmp	byte ptr ds:[17h], 0	;@041BE
	jne	@@8	;@041C3
	cmp	dh, 4	;@041C5
	je	@@15	;@041C8
	jb	@@13	;@041CA
	cmp	dh, 10h	;@041CC
	ja	@@22	;@041CF
	je	@@12	;@041D1
	mov	es, word ptr ds:[77Eh]	;@041D3
	cmp	dh, 8	;@041D7
	je	@@26	;@041DA
	cmp	word ptr ds:[41Eh], 1	;@041DC
	je	@@21	;@041E1
	add	word ptr [di+0C4Eh], cx	;@041E3
	inc	di	;@041E7
	inc	di	;@041E8
@@20:	mov	word ptr ds:[216h], 0FFFFh	;@041E9
	or	byte ptr ds:[215h], 8	;@041EF
	jmp	short @@27	;@041F4
@@21:	add	word ptr [di+0C4Eh], cx	;@041F6
	push	ax	;@041FA
	mov	ax, word ptr ds:[420h]	;@041FB
	add	word ptr [di+0C50h], ax	;@041FE
	pop	ax	;@04202
	add	di, 4	;@04203
	jmp	@@20	;@04206
@@22:	cmp	byte ptr ds:[125h], 0	;@04208
	jne	@@24	;@0420D
	cmp	dh, 14h	;@0420F
	jne	@@23	;@04212
	jmp	@@15	;@04214
@@23:	jmp	@@16	;@04217
@@24:	add	word ptr [di+0C4Eh], cx	;@0421A
	push	ax	;@0421E
	mov	ax, word ptr ds:[420h]	;@0421F
	add	word ptr [di+0C50h], ax	;@04222
	pop	ax	;@04226
	add	di, 4	;@04227
	cmp	dh, 14h	;@0422A
	jne	@@25	;@0422D
	jmp	@@16	;@0422F
@@25:	mov	es, word ptr ds:[77Eh]	;@04232
	mov	word ptr ds:[216h], 0FFFFh	;@04236
	jmp	short @@27	;@0423C
@@26:	test	word ptr ds:[411h], 1	;@0423E
	jne	@@27	;@04244
	mov	word ptr ds:[216h], bx	;@04246
@@27:	push	si	;@0424A
	mov	si, word ptr ds:[3E6h]	;@0424B
	mov	dx, word ptr es:[si+4]	;@0424F
	test	byte ptr ds:[215h], 1	;@04253
	jne	@@28	;@04258
	mov	cx, word ptr es:[bx+6]	;@0425A
	mov	si, word ptr es:[bx]	;@0425E
	mov	es, word ptr ds:[79Eh]	;@04261
@@28:	cmp	dx, -1	;@04265
	je	@@32	;@04268
	mov	word ptr ds:[222h], offset L03FF5	;@0426A
	test	byte ptr ds:[215h], 4	;@04270
	je	@@30	;@04275
@@29:	cmp	bx, word ptr es:[si+4]	;@04277
	je	@@30	;@0427B
	add	si, 14h	;@0427D
	cmp	si, word ptr ds:[79Ch]	;@04280
	jb	@@29	;@04284
	mov	ax, 1	;@04286
	call	L0961E	;@04289
@@30:	mov	bx, word ptr es:[si+6]	;@0428C
	dec	bx	;@04290
	shl	bx, 1	;@04291
	shl	bx, 1	;@04293
	shl	bx, 1	;@04295
	pop	si	;@04297
	cmp	dx, word ptr ds:[216h]	;@04298
	jne	@@31	;@0429C
	or	bl, 1	;@0429E
	jmp	short @@33	;@042A1
@@31:	test	byte ptr ds:[215h], 8	;@042A3
	je	@@33	;@042A8
	jmp	short @@33	;@042AA
@@32:	mov	word ptr ds:[222h], offset L0405D	;@042AC
	test	byte ptr ds:[215h], 1	;@042B2
	jne	@@35	;@042B7
	cmp	byte ptr es:[si+0Ah], 0	;@042B9
	jne	@@34	;@042BE
	mov	bx, word ptr es:[si+8]	;@042C0
	pop	si	;@042C4
	test	byte ptr ds:[215h], 4	;@042C5
	je	@@33	;@042CA
	xchg	ax, cx	;@042CC
	mov	cl, 4	;@042CD
	shr	ax, cl	;@042CF
	add	bx, ax	;@042D1
@@33:	add	word ptr [di+0C4Eh], bx	;@042D3
	cmp	byte ptr ds:[3F1h], 1	;@042D7
	je	@@36	;@042DC
	call	word ptr ds:[222h]	;@042DE
	jmp	@@16	;@042E2
@@34:	xor	ax, ax	;@042E5
	push	ax	;@042E7
	mov	ax, 22h	;@042E8
	push	ax	;@042EB
	call	FATAL	;@042EC
@@35:	pop	si	;@042EF
	jmp	@@33	;@042F0
@@36:	call	L03F9B	;@042F2
	jmp	@@16	;@042F5
L042F8:	push	bp	;@042F8
	mov	bp, sp	;@042F9
	lea	sp, [bp-4]	;@042FB
	mov	word ptr [bp-2], ax	;@042FE
	mov	al, byte ptr es:[bx+8]	;@04301
	mov	ah, 0	;@04305
	mov	word ptr [bp-4], ax	;@04307
	mov	word ptr ds:[3E6h], bx	;@0430A
	mov	bx, word ptr es:[bx]	;@0430E
	mov	es, word ptr ds:[79Eh]	;@04311
	mov	ax, word ptr es:[bx+8]	;@04315
	mov	word ptr ds:[3EEh], ax	;@04319
	mov	dl, byte ptr es:[bx+0Ah]	;@0431C
	mov	byte ptr ds:[3F0h], dl	;@04320
	lodsw	;@04324
	xor	dx, dx	;@04325
	mov	cx, word ptr ds:[41Eh]	;@04327
	mov	word ptr ds:[3ECh], cx	;@0432B
	jcxz	@@1	;@0432F
	xchg	ax, dx	;@04331
	lodsw	;@04332
	xchg	ax, dx	;@04333
@@1:	add	ax, word ptr [bp-2]	;@04334
	adc	dx, word ptr [bp-4]	;@04337
	mov	word ptr ds:[3EAh], dx	;@0433A
	mov	word ptr ds:[3E8h], ax	;@0433E
	mov	cx, word ptr ds:[3E0h]	;@04341
	sub	cx, si	;@04345
	mov	word ptr ds:[3E4h], cx	;@04347
	push	ds	;@0434B
	pop	es	;@0434C
	mov	di, 0C4Eh	;@0434D
	shr	cx, 1	;@04350
	rep movsw	;@04352
	rcl	cx, 1	;@04354
	rep movsb	;@04356
	mov	sp, bp	;@04358
	pop	bp	;@0435A
	ret	;@0435B
; P2_LEDATA: pass 2, LEDATA (A0h): data for the output.
P2_LEDATA:	call	L03083	;@0435C
	mov	byte ptr ds:[3F1h], 0	;@0435F
	sub	bx, bx	;@04364
	add	bl, byte ptr [si]	;@04366
	jge	@@1	;@04368
	inc	si	;@0436A
	sub	bl, 80h	;@0436B
	mov	bh, bl	;@0436E
	mov	bl, byte ptr [si]	;@04370
@@1:	inc	si	;@04372
	cmp	bx, 4000h	;@04373
	jle	L043DE	;@04377
L04379:	sub	bx, 4001h	;@04379
	shl	bx, 1	;@0437D
	add	bx, word ptr ds:[52Ch]	;@0437F
	mov	es, word ptr ds:[786h]	;@04383
	mov	bx, word ptr es:[bx]	;@04387
	push	bx	;@0438A
	and	bx, 3	;@0438B
	shl	bx, 1	;@0438E
	shl	bx, 1	;@04390
	shl	bx, 1	;@04392
	mov	es, word ptr [bx+756h]	;@04394
	pop	bx	;@04398
	mov	ax, word ptr es:[bx+2]	;@04399
	cmp	ax, word ptr ds:[228h]	;@0439D
	jne	@@2	;@043A1
	mov	ax, word ptr es:[bx+4]	;@043A3
	mov	bx, word ptr es:[bx]	;@043A7
	mov	word ptr ds:[168h], bx	;@043AA
	mov	es, word ptr ds:[77Eh]	;@043AE
	call	L042F8	;@043B2
@@1:	jmp	L059AB	;@043B5
@@2:	mov	byte ptr ds:[3F1h], 0FFh	;@043B8
	jmp	@@1	;@043BD
; P2_LIDATA: pass 2, LIDATA (A2h): iterated data for the output.
P2_LIDATA:	call	L03083	;@043BF
	mov	byte ptr ds:[3F1h], 1	;@043C2
	sub	bx, bx	;@043C7
	add	bl, byte ptr [si]	;@043C9
	jge	@@1	;@043CB
	inc	si	;@043CD
	sub	bl, 80h	;@043CE
	mov	bh, bl	;@043D1
	mov	bl, byte ptr [si]	;@043D3
@@1:	inc	si	;@043D5
	cmp	bx, 4000h	;@043D6
	jle	L043DE	;@043DA
	jmp	L04379	;@043DC
L043DE:	dec	bx	;@043DE
	xchg	ax, bx	;@043DF
	mov	ah, 0Ah	;@043E0
	mul	ah	;@043E2
	xchg	ax, bx	;@043E4
	add	bx, word ptr ds:[52Ah]	;@043E5
	mov	word ptr ds:[168h], bx	;@043E9
	mov	es, word ptr ds:[776h]	;@043ED
	test	byte ptr es:[bx+9], 0E0h	;@043F1
	je	@@2	;@043F6
	cmp	byte ptr es:[bx+9], 0FFh	;@043F8
	je	@@2	;@043FD
	mov	ax, word ptr es:[bx+2]	;@043FF
	cmp	ax, word ptr ds:[436h]	;@04403
	je	@@2	;@04407
	mov	es, word ptr ds:[77Eh]	;@04409
	mov	ax, word ptr es:[bx+6]	;@0440D
	call	L042F8	;@04411
@@1:	jmp	L059AB	;@04414
@@2:	mov	byte ptr ds:[3F1h], 0FFh	;@04417
	jmp	@@1	;@0441C
L0441E:	push	ax	;@0441E
	mov	es, word ptr ds:[3B4h]	;@0441F
	mov	ax, word ptr es:[si]	;@04423
	cmp	ax, word ptr es:[di]	;@04426
	je	@@3	;@04429
	jb	@@2	;@0442B
	clc	;@0442D
@@1:	mov	es, word ptr ds:[3B8h]	;@0442E
	pop	ax	;@04432
	ret	;@04433
@@2:	stc	;@04434
	jmp	@@1	;@04435
@@3:	cmp	si, di	;@04437
	jmp	@@1	;@04439
	db	0C3h, 0, 0, 0, 0, 1, 5, 28h, 2, 6, 48h, 3, 7, 48h, 0, 0, 0, 0E0h	;@0443B
	db	5, 28h, 0E1h, 6, 48h, 0, 0, 0, 0, 0, 0
L04458	dw	L0445C, L04461	;@04458
L0445C	db	'_TEXT'	;@0445C
L04461	db	'_DATA'	;@04461
L04466:	mov	word ptr ds:[259h], dx	;@04466
	mov	word ptr ds:[25Bh], cx	;@0446A
	lodsw	;@0446E
	cmp	ax, 80h	;@0446F
	jae	@@2	;@04472
	shl	ax, 1	;@04474
	xchg	al, ah	;@04476
	mov	word ptr ds:[25Dh], ax	;@04478
	mov	word ptr ds:[280h], ax	;@0447B
	add	dx, ax	;@0447E
	adc	cx, 0	;@04480
	mov	ax, word ptr ds:[250h]	;@04483
	mov	bx, word ptr ds:[252h]	;@04486
	or	bx, bx	;@0448A
	jne	@@1	;@0448C
	cmp	ax, 2000h	;@0448E
	jb	@@2	;@04491
@@1:	sub	ax, dx	;@04493
	sbb	bx, cx	;@04495
	jne	@@2	;@04497
	and	ax, ax	;@04499
	je	@@2	;@0449B
	mov	word ptr ds:[268h], ax	;@0449D
	add	ax, word ptr ds:[25Dh]	;@044A0
	mov	word ptr ds:[260h], ax	;@044A4
	jae	@@4	;@044A7
@@2:	stc	;@044A9
	ret	;@044AA
@@3:	mov	dx, word ptr ds:[255h]	;@044AB
	mov	cx, word ptr ds:[257h]	;@044AF
	mov	ax, 4200h	;@044B3
	mov	bx, word ptr ds:[24h]	;@044B6
	call	DOS_CALL	;@044BA
	mov	byte ptr ds:[254h], 1	;@044BD
	jmp	@@2	;@044C2
@@4:	mov	ax, word ptr ds:[3458h]	;@044C4
	sub	ax, 144Eh	;@044C7
	sub	dx, dx	;@044CA
	mov	word ptr ds:[255h], ax	;@044CC
	mov	word ptr ds:[257h], dx	;@044CF
	mov	ax, 4200h	;@044D3
	mov	bx, word ptr ds:[24h]	;@044D6
	mov	dx, word ptr ds:[259h]	;@044DA
	mov	cx, word ptr ds:[25Bh]	;@044DE
	call	DOS_CALL	;@044E2
	jb	@@3	;@044E5
	push	ds	;@044E7
	mov	ax, 282h	;@044E8
	push	ax	;@044EB
	push	word ptr ds:[260h]	;@044EC
	cmp	byte ptr ds:[25Fh], 1	;@044F0
	je	@@5	;@044F5
	call	far ptr POOL_INIT	;@044F7
	jmp	short @@6	;@044FC
@@5:	call	far ptr RESIZE_POOL_BLOCK	;@044FE
@@6:	and	ax, ax	;@04503
	jne	@@3	;@04505
	mov	byte ptr ds:[25Fh], 1	;@04507
	push	ds	;@0450C
	mov	ah, 3Fh	;@0450D
	mov	bx, word ptr ds:[24h]	;@0450F
	mov	cx, word ptr ds:[260h]	;@04513
	xor	dx, dx	;@04517
	mov	ds, word ptr ds:[282h]	;@04519
	call	DOS_CALL	;@0451D
	pop	ds	;@04520
	jb	@@7	;@04521
	cmp	ax, word ptr ds:[260h]	;@04523
	jne	@@7	;@04527
	les	bx, dword ptr ds:[280h]	;@04529
	cmp	word ptr es:[bx], 2BADh	;@0452D
	jne	@@7	;@04532
	call	L04580	;@04534
	jb	@@7	;@04537
	mov	di, word ptr ds:[494h]	;@04539
	mov	byte ptr [di+8], 1	;@0453D
	ret	;@04541
@@7:	call	L04548	;@04542
	jmp	@@3	;@04545
L04548:	cmp	byte ptr ds:[25Fh], 1	;@04548
	jne	@@1	;@0454D
	push	ds	;@0454F
	mov	ax, 282h	;@04550
	push	ax	;@04553
	xor	ax, ax	;@04554
	push	ax	;@04556
	call	far ptr RESIZE_POOL_BLOCK	;@04557
@@1:	ret	;@0455C
L0455D:	lodsb	;@0455D
	cbw	;@0455E
	and	al, al	;@0455F
	js	@@1	;@04561
	ret	;@04563
@@1:	push	bx	;@04564
	mov	bl, al	;@04565
	lodsb	;@04567
	mov	bh, al	;@04568
	shl	bl, 1	;@0456A
	shr	bx, 1	;@0456C
	and	al, al	;@0456E
	jns	@@2	;@04570
	lodsb	;@04572
	and	bh, 3Fh	;@04573
	ror	al, 1	;@04576
	ror	al, 1	;@04578
	or	bh, al	;@0457A
@@2:	mov	ax, bx	;@0457C
	pop	bx	;@0457E
	ret	;@0457F
L04580:	push	ds	;@04580
	pop	es	;@04581
	mov	di, 528h	;@04582
	mov	cx, 38h	;@04585
	mov	al, 0	;@04588
	rep stosb	;@0458A
	lds	si, dword ptr ds:[280h]	;@0458C
	push	word ptr [si+2]	;@04590
	add	si, 8	;@04593
	lodsw	;@04596
	mov	cx, ax	;@04597
	lodsw	;@04599
	mov	word ptr es:[264h], si	;@0459A
	mov	bx, si	;@0459F
	add	bx, ax	;@045A1
	push	bx	;@045A3
	jcxz	@@1	;@045A4
	mov	ah, 80h	;@045A6
	call	@@12	;@045A8
@@1:	pop	si	;@045AB
	lodsw	;@045AC
	mov	cx, ax	;@045AD
	lodsw	;@045AF
	mov	word ptr es:[262h], si	;@045B0
	mov	bx, si	;@045B5
	add	bx, ax	;@045B7
	push	bx	;@045B9
	jcxz	@@2	;@045BA
	mov	ah, 0	;@045BC
	call	@@12	;@045BE
@@2:	pop	si	;@045C1
	pop	bp	;@045C2
@@3:	push	bp	;@045C3
	lodsw	;@045C4
	mov	cl, 40h	;@045C5
	call	@@14	;@045C7
	mov	word ptr es:[266h], ax	;@045CA
	mov	di, 528h	;@045CE
	mov	ax, bx	;@045D1
	stosw	;@045D3
	mov	ax, word ptr es:[77Ch]	;@045D4
	stosw	;@045D8
	mov	ax, word ptr es:[784h]	;@045D9
	stosw	;@045DD
	mov	ax, word ptr es:[794h]	;@045DE
	stosw	;@045E2
	mov	ax, word ptr es:[7ACh]	;@045E3
	stosw	;@045E7
	mov	ax, 1	;@045E8
	stosw	;@045EB
	mov	ax, dx	;@045EC
	stosw	;@045EE
	lodsb	;@045EF
	cbw	;@045F0
	and	al, al	;@045F1
	jns	@@4	;@045F3
	sub	al, 80h	;@045F5
	mov	ah, al	;@045F7
	lodsb	;@045F9
@@4:	stosw	;@045FA
	xor	ax, ax	;@045FB
	stosb	;@045FD
	stosw	;@045FE
	dec	ax	;@045FF
	stosw	;@04600
	inc	ax	;@04601
	stosb	;@04602
	stosw	;@04603
	lodsw	;@04604
	push	ax	;@04605
	and	ax, 7	;@04606
	je	@@5	;@04609
	call	@@19	;@0460B
@@5:	pop	ax	;@0460E
	shr	al, 1	;@0460F
	shr	al, 1	;@04611
	shr	al, 1	;@04613
	push	ax	;@04615
	and	ax, 3	;@04616
	je	@@6	;@04619
	call	@@26	;@0461B
@@6:	pop	ax	;@0461E
	mov	al, ah	;@0461F
	push	ax	;@04621
	and	ax, 0Fh	;@04622
	je	@@7	;@04625
	call	@@40	;@04627
@@7:	pop	ax	;@0462A
	shr	ax, 1	;@0462B
	shr	ax, 1	;@0462D
	shr	ax, 1	;@0462F
	shr	ax, 1	;@04631
	and	ax, 7	;@04633
	je	@@8	;@04636
	call	@@33	;@04638
@@8:	push	si	;@0463B
	push	es	;@0463C
	pop	ds	;@0463D
	push	bx	;@0463E
	mov	bx, word ptr ds:[738h]	;@0463F
	les	di, dword ptr [bx+2]	;@04643
	add	di, 18h	;@04646
	cmp	di, word ptr [bx]	;@04649
	jbe	@@9	;@0464B
	call	L05519	;@0464D
	pop	bx	;@04650
	jae	@@10	;@04651
	call	TABLE_OVERFLOW	;@04653
@@9:	xchg	word ptr [bx+2], di	;@04656
	pop	bx	;@04659
@@10:	mov	si, 528h	;@0465A
	mov	cx, 18h	;@0465D
	shr	cx, 1	;@04660
	rep movsw	;@04662
	rcl	cx, 1	;@04664
	rep movsb	;@04666
	push	ds	;@04668
	pop	es	;@04669
	mov	ds, word ptr ds:[282h]	;@0466A
	pop	si	;@0466E
	pop	bp	;@0466F
	dec	bp	;@04670
	je	@@11	;@04671
	jmp	@@3	;@04673
@@11:	push	es	;@04676
	pop	ds	;@04677
	clc	;@04678
	ret	;@04679
@@12:	push	ds	;@0467A
	push	es	;@0467B
	pop	ds	;@0467C
	pop	es	;@0467D
	mov	di, si	;@0467E
	add	si, cx	;@04680
	add	si, cx	;@04682
@@13:	push	ax	;@04684
	push	cx	;@04685
	push	di	;@04686
	mov	word ptr ds:[3450h], es	;@04687
	call	L0910F	;@0468B
	mov	es, word ptr ds:[282h]	;@0468E
	pop	di	;@04692
	mov	ax, bx	;@04693
	stosw	;@04695
	pop	cx	;@04696
	pop	ax	;@04697
	loop	@@13	;@04698
	push	ds	;@0469A
	push	es	;@0469B
	pop	ds	;@0469C
	pop	es	;@0469D
	ret	;@0469E
@@14:	push	si	;@0469F
	push	ds	;@046A0
	push	es	;@046A1
	pop	ds	;@046A2
	pop	es	;@046A3
	mov	si, ax	;@046A4
	push	si	;@046A6
	mov	bl, byte ptr es:[si]	;@046A7
	and	bx, 3Fh	;@046AA
	push	word ptr es:[bx+si+1]	;@046AD
	cmp	byte ptr es:[bx+si], 21h	;@046B1
	jne	@@15	;@046B5
	dec	byte ptr es:[si]	;@046B7
@@15:	mov	ah, cl	;@046BA
	and	byte ptr es:[si], 3Fh	;@046BC
	mov	word ptr ds:[3450h], es	;@046C0
	call	L0910F	;@046C4
	push	ds	;@046C7
	pop	es	;@046C8
	pop	dx	;@046C9
	pop	ax	;@046CA
	pop	si	;@046CB
	mov	ds, word ptr ds:[282h]	;@046CC
	ret	;@046D0
@@16:	lodsb	;@046D1
	cbw	;@046D2
	cmp	al, 0E0h	;@046D3
	jae	@@17	;@046D5
	dec	si	;@046D7
	lodsb	;@046D8
	cbw	;@046D9
	and	al, al	;@046DA
	jns	@@17	;@046DC
	sub	al, 80h	;@046DE
	mov	ah, al	;@046E0
	lodsb	;@046E2
@@17:	and	ax, ax	;@046E3
	js	@@18	;@046E5
	mov	bx, ax	;@046E7
	shl	bx, 1	;@046E9
	add	bx, word ptr es:[264h]	;@046EB
	mov	bx, word ptr [bx]	;@046F0
	ret	;@046F2
@@18:	push	si	;@046F3
	push	di	;@046F4
	mov	bl, al	;@046F5
	mov	si, word ptr es:[266h]	;@046F7
	lodsb	;@046FC
	and	ax, 3Fh	;@046FD
	mov	cx, ax	;@04700
	mov	di, 273h	;@04702
	rep movsb	;@04705
	and	bx, 7	;@04707
	shl	bx, 1	;@0470A
	mov	si, word ptr cs:L04458[bx]	;@0470C
	push	cs	;@04711
	pop	ds	;@04712
	mov	cx, 5	;@04713
	rep movsb	;@04716
	push	es	;@04718
	pop	ds	;@04719
	mov	si, 272h	;@0471A
	mov	ax, di	;@0471D
	sub	ax, si	;@0471F
	dec	ax	;@04721
	mov	byte ptr [si], al	;@04722
	mov	ah, 80h	;@04724
	call	L0910B	;@04726
	push	ds	;@04729
	pop	es	;@0472A
	mov	ds, word ptr ds:[282h]	;@0472B
	pop	di	;@0472F
	pop	si	;@04730
	ret	;@04731
@@19:	cmp	ax, 7	;@04732
	jb	@@20	;@04735
	lodsb	;@04737
	cbw	;@04738
	and	al, al	;@04739
	jns	@@20	;@0473B
	sub	al, 80h	;@0473D
	mov	ah, al	;@0473F
	lodsb	;@04741
@@20:	push	ax	;@04742
	mov	al, byte ptr [si]	;@04743
	and	al, 0E0h	;@04745
	cmp	al, 0C0h	;@04747
	jne	@@21	;@04749
	lodsb	;@0474B
	and	ax, 7	;@0474C
	mov	di, ax	;@0474F
	shl	ax, 1	;@04751
	add	di, ax	;@04753
	add	di, 4440h	;@04755
	mov	al, byte ptr cs:[di+1]	;@04759
	cbw	;@0475D
	call	@@17	;@0475E
	push	bx	;@04761
	mov	al, byte ptr cs:[di]	;@04762
	cbw	;@04765
	call	@@17	;@04766
	push	bx	;@04769
	mov	al, byte ptr cs:[di+2]	;@0476A
	jmp	short @@22	;@0476E
@@21:	call	@@16	;@04770
	push	bx	;@04773
	call	@@16	;@04774
	push	bx	;@04777
	lodsb	;@04778
@@22:	push	ax	;@04779
	and	al, 0E0h	;@0477A
	jne	@@23	;@0477C
	lodsw	;@0477E
	push	ax	;@0477F
@@23:	call	L0455D	;@04780
	push	ax	;@04783
	push	es	;@04784
	pop	ds	;@04785
	call	L05C16	;@04786
	mov	ax, word ptr ds:[734h]	;@04789
	mov	word ptr es:[di+4], ax	;@0478C
	pop	word ptr es:[di+6]	;@04790
	pop	ax	;@04794
	mov	byte ptr es:[di+9], al	;@04795
	test	al, 0E0h	;@04799
	jne	@@24	;@0479B
	mov	es, word ptr ds:[77Eh]	;@0479D
	pop	word ptr es:[di]	;@047A1
@@24:	pop	bx	;@047A4
	pop	dx	;@047A5
	mov	es, word ptr ds:[776h]	;@047A6
	call	L01BD2	;@047AA
	push	ds	;@047AD
	pop	es	;@047AE
	mov	ds, word ptr ds:[282h]	;@047AF
	pop	ax	;@047B3
	dec	ax	;@047B4
	je	@@25	;@047B5
	jmp	@@20	;@047B7
@@25:	ret	;@047B9
@@26:	cmp	ax, 3	;@047BA
	jb	@@27	;@047BD
	lodsb	;@047BF
	cbw	;@047C0
	and	al, al	;@047C1
	jns	@@27	;@047C3
	sub	al, 80h	;@047C5
	mov	ah, al	;@047C7
	lodsb	;@047C9
@@27:	xchg	ax, cx	;@047CA
@@28:	push	cx	;@047CB
	lodsw	;@047CC
	mov	cx, ax	;@047CD
	and	ax, 0Fh	;@047CF
	mov	bx, cx	;@047D2
	mov	cl, 4	;@047D4
	shr	bx, cl	;@047D6
	shl	bx, 1	;@047D8
	add	bx, word ptr es:[264h]	;@047DA
	mov	dx, word ptr [bx]	;@047DF
	push	es	;@047E1
	pop	ds	;@047E2
	mov	di, 4	;@047E3
	push	di	;@047E6
	mov	di, 792h	;@047E7
	call	L054ED	;@047EA
	jae	@@29	;@047ED
	call	TABLE_OVERFLOW	;@047EF
@@29:	mov	word ptr es:[di], dx	;@047F2
	mov	cx, 0FFFFh	;@047F5
	jmp	short @@32	;@047F8
@@30:	mov	es, word ptr ds:[282h]	;@047FA
	sub	bx, bx	;@047FE
	add	bl, byte ptr es:[si]	;@04800
	jge	@@31	;@04803
	inc	si	;@04805
	sub	bl, 80h	;@04806
	mov	bh, bl	;@04809
	mov	bl, byte ptr es:[si]	;@0480B
@@31:	inc	si	;@0480E
	call	L01D2E	;@0480F
@@32:	dec	ax	;@04812
	jge	@@30	;@04813
	mov	es, word ptr ds:[796h]	;@04815
	mov	word ptr es:[di+2], cx	;@04819
	push	ds	;@0481D
	pop	es	;@0481E
	mov	ds, word ptr ds:[282h]	;@0481F
	pop	cx	;@04823
	loop	@@28	;@04824
	ret	;@04826
@@33:	cmp	ax, 7	;@04827
	jb	@@34	;@0482A
	lodsb	;@0482C
	cbw	;@0482D
	and	al, al	;@0482E
	jns	@@34	;@04830
	sub	al, 80h	;@04832
	mov	ah, al	;@04834
	lodsb	;@04836
@@34:	mov	cx, ax	;@04837
@@35:	push	cx	;@04839
	sub	bx, bx	;@0483A
	add	bl, byte ptr [si]	;@0483C
	jge	@@36	;@0483E
	inc	si	;@04840
	sub	bl, 80h	;@04841
	mov	bh, bl	;@04844
	mov	bl, byte ptr [si]	;@04846
@@36:	inc	si	;@04848
	and	bx, bx	;@04849
	je	@@37	;@0484B
	dec	bx	;@0484D
	shl	bx, 1	;@0484E
	add	bx, word ptr es:[262h]	;@04850
	mov	bx, word ptr [bx]	;@04855
	jmp	short @@39	;@04857
@@37:	lodsb	;@04859
	cbw	;@0485A
	and	al, al	;@0485B
	jns	@@38	;@0485D
	sub	al, 80h	;@0485F
	mov	ah, al	;@04861
	lodsb	;@04863
@@38:	mov	cl, 0	;@04864
	call	@@14	;@04866
@@39:	push	es	;@04869
	pop	ds	;@0486A
	push	bx	;@0486B
	and	bx, 3	;@0486C
	shl	bx, 1	;@0486F
	shl	bx, 1	;@04871
	shl	bx, 1	;@04873
	mov	es, word ptr [bx+716h]	;@04875
	pop	bx	;@04879
	mov	dl, 10h	;@0487A
	call	L0180F	;@0487C
	push	ds	;@0487F
	pop	es	;@04880
	mov	ds, word ptr ds:[282h]	;@04881
	pop	cx	;@04885
	loop	@@35	;@04886
	ret	;@04888
@@40:	cmp	ax, 0Fh	;@04889
	jb	@@41	;@0488C
	lodsb	;@0488E
	cbw	;@0488F
	and	al, al	;@04890
	jns	@@41	;@04892
	sub	al, 80h	;@04894
	mov	ah, al	;@04896
	lodsb	;@04898
@@41:	push	ax	;@04899
	lodsw	;@0489A
	mov	cl, 0	;@0489B
	call	@@14	;@0489D
	push	bx	;@048A0
	cmp	byte ptr [si], 80h	;@048A1
	sbb	si, -2	;@048A4
	sub	bx, bx	;@048A7
	add	bl, byte ptr [si]	;@048A9
	jge	@@42	;@048AB
	inc	si	;@048AD
	sub	bl, 80h	;@048AE
	mov	bh, bl	;@048B1
	mov	bl, byte ptr [si]	;@048B3
@@42:	inc	si	;@048B5
	mov	dl, 0	;@048B6
	or	bx, bx	;@048B8
	jne	@@43	;@048BA
	mov	dl, 2	;@048BC
	lodsw	;@048BE
@@43:	lodsw	;@048BF
	push	es	;@048C0
	pop	ds	;@048C1
	mov	byte ptr ds:[172h], dl	;@048C2
	mov	word ptr ds:[16Eh], ax	;@048C6
	mov	word ptr ds:[170h], 0	;@048C9
	test	dl, 2	;@048CF
	jne	@@44	;@048D2
	dec	bx	;@048D4
	xchg	ax, bx	;@048D5
	mov	ah, 0Ah	;@048D6
	mul	ah	;@048D8
	xchg	ax, bx	;@048DA
	add	bx, word ptr ds:[52Ah]	;@048DB
@@44:	mov	word ptr ds:[16Ch], bx	;@048DF
	pop	bx	;@048E3
	push	bx	;@048E4
	and	bx, 3	;@048E5
	shl	bx, 1	;@048E8
	shl	bx, 1	;@048EA
	shl	bx, 1	;@048EC
	mov	es, word ptr [bx+716h]	;@048EE
	pop	bx	;@048F2
	call	L01902	;@048F3
	push	ds	;@048F6
	pop	es	;@048F7
	mov	ds, word ptr ds:[282h]	;@048F8
	pop	ax	;@048FC
	dec	ax	;@048FD
	jne	@@41	;@048FE
	ret	;@04900
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@04901
	db	0, 0, 4, 0, 0, 1, 0, 0, 2, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh, 0, 0
	db	0, 5, 0, 0, 2, 0, 0, 4, 0, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh, 0, 0
	db	6, 0, 0, 4, 0, 0, 6, 0, 0, 0, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh, 8
	db	0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0FFh, 0, 0, 0, 9, 0, 0, 2, 0
	db	0, 0Ah, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0Ah, 0, 0, 4, 0, 0, 0Ch
	db	0, 0, 0, 0, 0, 0FFh, 0FFh, 0FFh, 0FFh, 0Dh, 0, 0, 4, 0, 0, 0, 0
	db	0Fh, 0, 0, 8, 0, 0, 0, 0, 10h, 0, 0, 0Ah, 0, 0, 0, 0, 0Eh, 0, 0
	db	6, 0, 0, 0, 0, 28h, 0, 0, 1, 0, 0, 0, 0, 0Ch, 0, 0, 1, 0, 0, 13h
	db	0, 0, 0, 0, 0, 0FFh, 0, 0, 0, 7, 0, 0, 8, 0, 0, 0, 0, 0Bh, 0, 0
	db	8, 0, 0, 0, 0, 2Bh, 0, 0, 0Ah, 0, 0, 0, 0, 5, 3, 9, 0, 0E6h, 4
	db	0Dh, 3, 10h, 0, 0EAh, 4, 11h, 3, 6, 0, 0F2h, 4, 15h, 3, 4, 0, 0F0h
	db	4, 19h, 3, 0Ch, 0, 0EEh, 4, 2Dh, 3, 10h, 0, 0F4h, 4, 31h, 3, 8
	db	0, 0F6h, 4, 1Dh, 3, 8, 0, 0ECh, 4, 21h, 3, 8, 0, 0E2h, 4, 25h
	db	3, 5, 0, 0E4h, 4, 35h, 3, 0Bh, 0, 8, 5, 39h, 3, 2, 0, 0Ah, 5, 3Dh
	db	3, 8, 0, 0Eh, 5, 41h, 3, 4, 0, 10h, 5, 45h, 3, 8, 0, 12h, 5, 0BEh
	db	3, 2, 0, 0CAh, 3, 0BAh, 3, 2, 0, 14h, 5
; POOL_INIT_OR_DIE: POOL_INIT, or OUT_OF_MEMORY.
POOL_INIT_OR_DIE:	push	ds	;@04A2E
	push	bx	;@04A2F
	push	ax	;@04A30
	call	far ptr POOL_INIT	;@04A31
	and	ax, ax	;@04A36
	jne	@@1	;@04A38
	ret	;@04A3A
@@1:	jmp	OUT_OF_MEMORY	;@04A3B
L04A3E:	xor	ax, ax	;@04A3E
	push	ax	;@04A40
	mov	ax, 1Fh	;@04A41
	push	ax	;@04A44
	call FATAL	;@04A45
L04A48:	push	bp	;@04A48
	mov	bp, sp	;@04A49
	sub	sp, 0Ah	;@04A4B
	mov	si, 732h	;@04A4E
	mov	word ptr [bp-8], si	;@04A51
	xor	si, si	;@04A54
	mov	word ptr ds:[3A8h], si	;@04A56
	push	ds	;@04A5A
	pop	es	;@04A5B
@@1:	push	si	;@04A5C
	and	si, 3	;@04A5D
	shl	si, 1	;@04A60
	shl	si, 1	;@04A62
	shl	si, 1	;@04A64
	mov	ds, word ptr es:[si+736h]	;@04A66
	pop	si	;@04A6B
	mov	bl, byte ptr [si+10h]	;@04A6C
	mov	bh, 0	;@04A6F
	cmp	word ptr [si+0Ah], 2	;@04A71
	jb	@@2	;@04A75
	inc	word ptr es:[4EAh]	;@04A77
	mov	ax, word ptr es:[4EAh]	;@04A7C
	mov	word ptr [si+16h], ax	;@04A80
	and	bx, bx	;@04A83
	je	@@2	;@04A85
	mov	word ptr [bp-6], si	;@04A87
	lea	si, [si+18h]	;@04A8A
	mov	di, 4E2h	;@04A8D
	mov	cx, 3	;@04A90
	call	L051CF	;@04A93
	mov	si, word ptr [bp-6]	;@04A96
	lea	si, [si+1Eh]	;@04A99
	mov	di, 4ECh	;@04A9C
	mov	cx, 5	;@04A9F
	call	L051CF	;@04AA2
	mov	si, word ptr [bp-6]	;@04AA5
	mov	di, 4D8h	;@04AA8
	mov	ax, word ptr [si+28h]	;@04AAB
	add	word ptr es:[di+1Eh], ax	;@04AAE
	mov	ax, word ptr [si+2Ah]	;@04AB2
	add	word ptr es:[di+30h], ax	;@04AB5
	mov	ax, word ptr [si+2Eh]	;@04AB9
	add	word ptr es:[di+32h], ax	;@04ABC
	mov	ax, word ptr [si+2Ch]	;@04AC0
	add	word ptr es:[di+36h], ax	;@04AC3
	mov	ax, word ptr [si+32h]	;@04AC7
	add	word ptr es:[di+3Ch], ax	;@04ACA
	mov	ax, word ptr [si+34h]	;@04ACE
	add	word ptr es:[3E6h], ax	;@04AD1
	mov	al, byte ptr [si+30h]	;@04AD6
	or	byte ptr es:[3A8h], al	;@04AD9
	and	byte ptr [si+30h], 7Fh	;@04ADE
@@2:	cmp	si, word ptr es:[184h]	;@04AE2
	je	@@5	;@04AE7
	add	si, word ptr cs:L05780[bx]	;@04AE9
	push	es	;@04AEE
	pop	ds	;@04AEF
	push	di	;@04AF0
	mov	di, word ptr [bp-8]	;@04AF1
	cmp	si, word ptr [di+2]	;@04AF4
	pop	di	;@04AF7
	jae	@@3	;@04AF8
	push	si	;@04AFA
	add	si, 38h	;@04AFB
	cmp	si, -80h	;@04AFE
	pop	si	;@04B01
	jae	@@3	;@04B02
	jmp	@@1	;@04B04
@@3:	push	di	;@04B07
	mov	di, word ptr [bp-8]	;@04B08
	cmp	di, 742h	;@04B0B
	jbe	@@4	;@04B0F
	pop	di	;@04B11
	jmp	short @@5	;@04B12
@@4:	add	di, 8	;@04B14
	mov	word ptr [bp-8], di	;@04B17
	and	si, 3	;@04B1A
	inc	si	;@04B1D
	pop	di	;@04B1E
	jmp	@@1	;@04B1F
@@5:	push	es	;@04B22
	pop	ds	;@04B23
	and	word ptr ds:[3A8h], 80h	;@04B24
	push	bp	;@04B2A
	mov	word ptr ds:[3B0h], 1	;@04B2B
	mov	bp, offset L04F93	;@04B31
	call	L04F5A	;@04B34
	pop	bp	;@04B37
	mov	di, 4D8h	;@04B38
	mov	ax, word ptr [di+10h]	;@04B3B
	add	word ptr [di+0Eh], ax	;@04B3E
	add	word ptr [di+0Ah], 17h	;@04B41
	mov	word ptr [di+38h], 0	;@04B45
	mov	ax, word ptr [di+30h]	;@04B4A
	mov	word ptr [di+3Ah], ax	;@04B4D
	or	ax, word ptr [di+36h]	;@04B50
	je	@@6	;@04B53
	mov	word ptr ds:[3A1h], 0	;@04B55
	mov	ax, word ptr [di+12h]	;@04B5B
	mov	word ptr [di+3Ah], ax	;@04B5E
	cmp	word ptr ds:[3A8h], 0	;@04B61
	je	@@6	;@04B66
	mov	ax, word ptr [di+16h]	;@04B68
	mov	word ptr [di+38h], ax	;@04B6B
@@6:	mov	cx, 18h	;@04B6E
	mov	si, 732h	;@04B71
	mov	word ptr [bp-8], si	;@04B74
	xor	si, si	;@04B77
	push	si	;@04B79
	and	si, 3	;@04B7A
	shl	si, 1	;@04B7D
	shl	si, 1	;@04B7F
	shl	si, 1	;@04B81
	mov	es, word ptr [si+736h]	;@04B83
	pop	si	;@04B87
@@7:	mov	bl, byte ptr es:[si+10h]	;@04B88
	and	bx, 0FFh	;@04B8C
	je	@@8	;@04B90
	cmp	word ptr es:[si+18h], 0	;@04B92
	je	@@8	;@04B97
	cmp	word ptr es:[si+0Ah], 2	;@04B99
	jb	@@12	;@04B9E
	add	cx, word ptr es:[si+18h]	;@04BA0
@@8:	cmp	si, word ptr ds:[184h]	;@04BA4
	jne	@@9	;@04BA8
	jmp	@@34	;@04BAA
@@9:	add	si, word ptr cs:L05780[bx]	;@04BAD
	push	di	;@04BB2
	mov	di, word ptr [bp-8]	;@04BB3
	cmp	si, word ptr [di+2]	;@04BB6
	pop	di	;@04BB9
	jae	@@10	;@04BBA
	push	si	;@04BBC
	add	si, 38h	;@04BBD
	cmp	si, -80h	;@04BC0
	pop	si	;@04BC3
	jb	@@7	;@04BC4
@@10:	push	di	;@04BC6
	mov	di, word ptr [bp-8]	;@04BC7
	cmp	di, 742h	;@04BCA
	jbe	@@11	;@04BCE
	pop	di	;@04BD0
	jmp	@@34	;@04BD1
@@11:	add	di, 8	;@04BD4
	mov	word ptr [bp-8], di	;@04BD7
	and	si, 3	;@04BDA
	inc	si	;@04BDD
	pop	di	;@04BDE
	push	si	;@04BDF
	and	si, 3	;@04BE0
	shl	si, 1	;@04BE3
	shl	si, 1	;@04BE5
	shl	si, 1	;@04BE7
	mov	es, word ptr [si+736h]	;@04BE9
	pop	si	;@04BED
	jmp	@@7	;@04BEE
	db	0E9h, 4Bh, 0FEh	;@04BF0
@@12:	mov	ax, word ptr ds:[490h]	;@04BF3
	add	ax, 17h	;@04BF6
	sub	ax, cx	;@04BF9
	inc	ax	;@04BFB
	mov	word ptr ds:[3AEh], cx	;@04BFC
	push	si	;@04C00
	or	ax, ax	;@04C01
	jns	@@13	;@04C03
	push	ax	;@04C05
	mov	ax, 0FFFFh	;@04C06
	mov	bx, 3AAh	;@04C09
	call	POOL_INIT_OR_DIE	;@04C0C
	pop	ax	;@04C0F
	sub	ax, 8000h	;@04C10
	shl	ax, 1	;@04C13
	mov	bx, 3ACh	;@04C15
	call	POOL_INIT_OR_DIE	;@04C18
	pop	si	;@04C1B
	jmp	short @@14	;@04C1C
@@13:	shl	ax, 1	;@04C1E
	mov	bx, 3AAh	;@04C20
	call	POOL_INIT_OR_DIE	;@04C23
	pop	si	;@04C26
@@14:	mov	di, si	;@04C27
	and	di, 3	;@04C29
	shl	di, 1	;@04C2C
	shl	di, 1	;@04C2E
	shl	di, 1	;@04C30
	lea	di, [di+732h]	;@04C32
	mov	word ptr [bp-8], di	;@04C36
	xor	di, di	;@04C39
	mov	ax, word ptr ds:[3AAh]	;@04C3B
	mov	word ptr [bp-0Ah], ax	;@04C3E
	mov	ax, word ptr ds:[3AEh]	;@04C41
@@15:	push	si	;@04C44
	and	si, 3	;@04C45
	shl	si, 1	;@04C48
	shl	si, 1	;@04C4A
	shl	si, 1	;@04C4C
	mov	es, word ptr [si+736h]	;@04C4E
	pop	si	;@04C52
	mov	bl, byte ptr es:[si+10h]	;@04C53
	and	bx, 0FFh	;@04C57
	je	@@23	;@04C5B
	mov	cx, word ptr es:[si+18h]	;@04C5D
	jcxz	@@23	;@04C61
	mov	dx, word ptr [bp-0Ah]	;@04C63
	cmp	dx, word ptr ds:[3ACh]	;@04C66
	je	@@16	;@04C6A
	push	di	;@04C6C
	push	cx	;@04C6D
	shl	cx, 1	;@04C6E
	add	di, cx	;@04C70
	pop	cx	;@04C72
	pop	di	;@04C73
	jb	@@19	;@04C74
@@16:	cmp	word ptr es:[si+0Ah], 2	;@04C76
	mov	es, dx	;@04C7B
	jb	@@18	;@04C7D
@@17:	stosw	;@04C7F
	inc	ax	;@04C80
	loop	@@17	;@04C81
	jmp	short @@23	;@04C83
@@18:	push	ax	;@04C85
	xor	ax, ax	;@04C86
	rep stosw	;@04C88
	pop	ax	;@04C8A
	jmp	short @@23	;@04C8B
@@19:	push	cx	;@04C8D
	mov	cx, di	;@04C8E
	neg	cx	;@04C90
	shr	cx, 1	;@04C92
	push	cx	;@04C94
	cmp	word ptr es:[si+0Ah], 2	;@04C95
	mov	es, dx	;@04C9A
	jb	@@22	;@04C9C
@@20:	stosw	;@04C9E
	inc	ax	;@04C9F
	loop	@@20	;@04CA0
	pop	dx	;@04CA2
	pop	cx	;@04CA3
	sub	cx, dx	;@04CA4
	mov	dx, word ptr ds:[3ACh]	;@04CA6
	mov	word ptr [bp-0Ah], dx	;@04CAA
	mov	es, dx	;@04CAD
	xor	di, di	;@04CAF
@@21:	stosw	;@04CB1
	inc	ax	;@04CB2
	loop	@@21	;@04CB3
	jmp	short @@23	;@04CB5
@@22:	push	ax	;@04CB7
	xor	ax, ax	;@04CB8
	rep stosw	;@04CBA
	pop	ax	;@04CBC
	pop	dx	;@04CBD
	pop	cx	;@04CBE
	sub	cx, dx	;@04CBF
	mov	dx, word ptr ds:[3ACh]	;@04CC1
	mov	word ptr [bp-0Ah], dx	;@04CC5
	mov	es, dx	;@04CC8
	xor	di, di	;@04CCA
	push	ax	;@04CCC
	xor	ax, ax	;@04CCD
	rep stosw	;@04CCF
	pop	ax	;@04CD1
@@23:	cmp	si, word ptr ds:[184h]	;@04CD2
	je	@@26	;@04CD6
	add	si, word ptr cs:L05780[bx]	;@04CD8
	push	di	;@04CDD
	mov	di, word ptr [bp-8]	;@04CDE
	cmp	si, word ptr [di+2]	;@04CE1
	pop	di	;@04CE4
	jae	@@24	;@04CE5
	push	si	;@04CE7
	add	si, 38h	;@04CE8
	cmp	si, -80h	;@04CEB
	pop	si	;@04CEE
	jae	@@24	;@04CEF
	jmp	@@15	;@04CF1
@@24:	push	di	;@04CF4
	mov	di, word ptr [bp-8]	;@04CF5
	cmp	di, 742h	;@04CF8
	jbe	@@25	;@04CFC
	pop	di	;@04CFE
	jmp	short @@26	;@04CFF
@@25:	add	di, 8	;@04D01
	mov	word ptr [bp-8], di	;@04D04
	and	si, 3	;@04D07
	inc	si	;@04D0A
	pop	di	;@04D0B
	push	si	;@04D0C
	and	si, 3	;@04D0D
	shl	si, 1	;@04D10
	shl	si, 1	;@04D12
	shl	si, 1	;@04D14
	mov	es, word ptr [si+736h]	;@04D16
	pop	si	;@04D1A
	jmp	@@15	;@04D1B
@@26:	sub	si, si	;@04D1E
	push	si	;@04D20
	mov	bx, 752h	;@04D21
	mov	dx, word ptr ds:[48Eh]	;@04D24
@@27:	push	si	;@04D28
	and	si, 3	;@04D29
	shl	si, 1	;@04D2C
	shl	si, 1	;@04D2E
	shl	si, 1	;@04D30
	mov	es, word ptr [si+756h]	;@04D32
	pop	si	;@04D36
	mov	ax, word ptr [bx+2]	;@04D37
	push	ds	;@04D3A
	jmp	short @@32	;@04D3B
@@28:	pop	ds	;@04D3D
	push	ds	;@04D3E
	mov	di, word ptr es:[si+10h]	;@04D3F
	sub	di, word ptr ds:[3AEh]	;@04D43
	jb	@@31	;@04D47
	js	@@29	;@04D49
	shl	di, 1	;@04D4B
	push	ax	;@04D4D
	mov	ax, word ptr ds:[3AAh]	;@04D4E
	mov	ds, ax	;@04D51
	pop	ax	;@04D53
	jmp	short @@30	;@04D54
@@29:	sub	di, 8000h	;@04D56
	shl	di, 1	;@04D5A
	pop	ds	;@04D5C
	push	ds	;@04D5D
	push	ax	;@04D5E
	mov	ax, word ptr ds:[3ACh]	;@04D5F
	mov	ds, ax	;@04D62
	pop	ax	;@04D64
@@30:	mov	di, word ptr [di]	;@04D65
	mov	word ptr es:[si+10h], di	;@04D67
@@31:	add	si, dx	;@04D6B
@@32:	cmp	si, ax	;@04D6D
	jb	@@28	;@04D6F
	pop	ds	;@04D71
	cmp	bx, 762h	;@04D72
	ja	@@33	;@04D76
	add	bx, 8	;@04D78
	pop	si	;@04D7B
	inc	si	;@04D7C
	push	si	;@04D7D
	jmp	@@27	;@04D7E
@@33:	pop	ax	;@04D80
	push	ds	;@04D81
	mov	ax, 3AAh	;@04D82
	push	ax	;@04D85
	call	far ptr FREE_HANDLE_BLOCK	;@04D86
	cmp	word ptr ds:[3ACh], -1	;@04D8B
	je	@@34	;@04D90
	push	ds	;@04D92
	mov	ax, 3ACh	;@04D93
	push	ax	;@04D96
	call	far ptr FREE_HANDLE_BLOCK	;@04D97
@@34:	xor	di, di	;@04D9C
	mov	ax, 10h	;@04D9E
	mul	word ptr ds:[3FEh]	;@04DA1
	xchg	ax, si	;@04DA5
	mov	di, dx	;@04DA6
	add	si, word ptr ds:[3DCh]	;@04DA8
	adc	di, word ptr ds:[3DEh]	;@04DAC
	add	si, 0Fh	;@04DB0
	adc	di, 0	;@04DB3
	and	si, -10h	;@04DB6
	cmp	byte ptr ds:[17h], 0	;@04DB9
	je	@@35	;@04DBE
	add	si, 10h	;@04DC0
	adc	di, 0	;@04DC3
@@35:	add	si, 30h	;@04DC6
	adc	di, 0	;@04DC9
	xor	ax, ax	;@04DCC
	cmp	word ptr ds:[512h], 0	;@04DCE
	jne	@@36	;@04DD3
	cmp	word ptr ds:[514h], 0	;@04DD5
	je	@@38	;@04DDA
	mov	ax, word ptr ds:[4F4h]	;@04DDC
	mov	word ptr ds:[3CAh], ax	;@04DDF
@@36:	mov	ax, 20h	;@04DE2
	cmp	byte ptr ds:[12Dh], 1	;@04DE5
	jne	@@37	;@04DEA
	sub	ax, 14h	;@04DEC
@@37:	add	si, ax	;@04DEF
	adc	di, 0	;@04DF1
@@38:	mov	word ptr ds:[506h], ax	;@04DF4
	mov	word ptr [bp-4], si	;@04DF7
	mov	word ptr [bp-2], di	;@04DFA
	push	bp	;@04DFD
	mov	bp, 49C8h	;@04DFE
	mov	cx, 11h	;@04E01
@@39:	mov	bx, word ptr cs:[bp]	;@04E04
	mov	word ptr [bx], si	;@04E08
	mov	word ptr [bx+2], di	;@04E0A
	mov	ax, word ptr cs:[bp+2]	;@04E0D
	mov	bx, word ptr cs:[bp+4]	;@04E11
	mul	word ptr [bx]	;@04E15
	add	si, ax	;@04E17
	adc	di, dx	;@04E19
	add	bp, 6	;@04E1B
	loop	@@39	;@04E1E
	pop	bp	;@04E20
	mov	word ptr ds:[329h], si	;@04E21
	mov	word ptr ds:[32Bh], di	;@04E25
	sub	si, word ptr [bp-4]	;@04E29
	sbb	di, word ptr [bp-2]	;@04E2C
	mov	word ptr ds:[516h], si	;@04E2F
	mov	word ptr ds:[518h], di	;@04E33
	mov	di, 4D8h	;@04E37
	mov	ax, 9	;@04E3A
	mul	word ptr [di+10h]	;@04E3D
	add	ax, word ptr ds:[305h]	;@04E40
	adc	dx, word ptr ds:[307h]	;@04E44
	mov	word ptr ds:[309h], ax	;@04E48
	mov	word ptr ds:[30Bh], dx	;@04E4B
	mov	ax, word ptr [di+10h]	;@04E4F
	mov	word ptr [di+0Eh], ax	;@04E52
	xor	ax, ax	;@04E55
	mov	word ptr [di+18h], ax	;@04E57
	mov	word ptr [di+16h], ax	;@04E5A
	mov	word ptr [di+14h], ax	;@04E5D
	mov	word ptr [di+0Ah], 17h	;@04E60
	mov	word ptr [di+0Ch], ax	;@04E65
	mov	word ptr [di+1Ah], ax	;@04E68
	mov	word ptr [di+12h], ax	;@04E6B
	mov	word ptr [di+1Ch], ax	;@04E6E
	mov	word ptr [di+1Eh], ax	;@04E71
	mov	word ptr [di+32h], ax	;@04E74
	mov	word ptr [di+36h], ax	;@04E77
	mov	word ptr [di+30h], ax	;@04E7A
	mov	ax, 4000h	;@04E7D
	mov	bx, 2BAh	;@04E80
	call	POOL_INIT_OR_DIE	;@04E83
	mov	word ptr ds:[2B8h], 0	;@04E86
	mov	ax, 16h	;@04E8C
	mul	word ptr ds:[488h]	;@04E8F
	mov	bx, 36Dh	;@04E93
	call	POOL_INIT_OR_DIE	;@04E96
	mov	ax, 8	;@04E99
	mul	word ptr ds:[48Ah]	;@04E9C
	mov	bx, 375h	;@04EA0
	call	POOL_INIT_OR_DIE	;@04EA3
	mov	ax, word ptr ds:[48Ah]	;@04EA6
	shl	ax, 1	;@04EA9
	mov	bx, 379h	;@04EAB
	call	POOL_INIT_OR_DIE	;@04EAE
	mov	ax, 9	;@04EB1
	mul	word ptr ds:[48Ch]	;@04EB4
	mov	bx, 37Dh	;@04EB8
	call	POOL_INIT_OR_DIE	;@04EBB
	mov	ax, word ptr ds:[48Ch]	;@04EBE
	shl	ax, 1	;@04EC1
	mov	bx, 381h	;@04EC3
	call	POOL_INIT_OR_DIE	;@04EC6
	mov	ax, 7FDh	;@04EC9
	mov	bx, 349h	;@04ECC
	call	POOL_INIT_OR_DIE	;@04ECF
	mov	ax, word ptr ds:[3C8h]	;@04ED2
	shl	ax, 1	;@04ED5
	mov	bx, word ptr ds:[3C6h]	;@04ED7
	shl	bx, 1	;@04EDB
	shl	bx, 1	;@04EDD
	add	ax, bx	;@04EDF
	mov	bx, 3B4h	;@04EE1
	call	POOL_INIT_OR_DIE	;@04EE4
	mov	ax, word ptr ds:[3C6h]	;@04EE7
	shl	ax, 1	;@04EEA
	mov	bx, 3B8h	;@04EEC
	call	POOL_INIT_OR_DIE	;@04EEF
	xor	ax, ax	;@04EF2
	mov	word ptr ds:[36Bh], ax	;@04EF4
	mov	word ptr ds:[373h], ax	;@04EF7
	mov	word ptr ds:[377h], ax	;@04EFA
	mov	word ptr ds:[37Bh], ax	;@04EFD
	mov	word ptr ds:[37Fh], ax	;@04F00
	mov	word ptr ds:[36Fh], ax	;@04F03
	mov	word ptr ds:[3B2h], ax	;@04F06
	mov	word ptr ds:[3B6h], ax	;@04F09
	xor	ax, ax	;@04F0C
	mov	word ptr ds:[363h], ax	;@04F0E
	mov	word ptr ds:[35Dh], ax	;@04F11
	mov	word ptr ds:[361h], 7FDh	;@04F14
	mov	word ptr ds:[35Fh], 349h	;@04F1A
	mov	word ptr ds:[359h], ax	;@04F20
	mov	word ptr ds:[35Bh], ax	;@04F23
	mov	word ptr ds:[391h], ax	;@04F26
	mov	word ptr ds:[38Fh], ax	;@04F29
	mov	byte ptr ds:[3476h], 2	;@04F2C
	les	di, dword ptr ds:[2B8h]	;@04F31
	mov	cx, 2000h	;@04F35
	rep stosw	;@04F38
	mov	ax, word ptr ds:[321h]	;@04F3A
	mov	dx, word ptr ds:[323h]	;@04F3D
	mov	si, 4910h	;@04F41
	mov	cx, 0B8h	;@04F44
	add	word ptr ds:[321h], cx	;@04F47
	adc	word ptr ds:[323h], 0	;@04F4B
	mov	bx, 480h	;@04F50
	call L08AC5	;@04F53
	mov	sp, bp	;@04F56
	pop	bp	;@04F58
	ret	;@04F59
L04F5A:	xor	bx, bx	;@04F5A
	jmp	short @@3	;@04F5C
@@1:	mov	es, word ptr ds:[7BEh]	;@04F5E
	mov	si, word ptr es:[bx]	;@04F62
	push	si	;@04F65
	and	si, 3	;@04F66
	shl	si, 1	;@04F69
	shl	si, 1	;@04F6B
	shl	si, 1	;@04F6D
	mov	es, word ptr [si+756h]	;@04F6F
	pop	si	;@04F73
	cmp	word ptr es:[si+0Ch], -1	;@04F74
	je	@@2	;@04F79
	push	di	;@04F7B
	mov	di, si	;@04F7C
	call L09418	;@04F7E
	pop	di	;@04F81
	jae	@@2	;@04F82
	push	bx	;@04F84
	push	bp	;@04F85
	call	bp	;@04F86
	pop	bp	;@04F88
	pop	bx	;@04F89
@@2:	inc	bx	;@04F8A
	inc	bx	;@04F8B
@@3:	cmp	bx, word ptr ds:[7BCh]	;@04F8C
	jb	@@1	;@04F90
	ret	;@04F92
L04F93:	mov	ax, word ptr ds:[3B0h]	;@04F93
	mov	word ptr es:[si+12h], ax	;@04F96
	inc	word ptr ds:[3B0h]	;@04F9A
	mov	bx, word ptr es:[si+0Ch]	;@04F9E
	cmp	word ptr es:[si+10h], 0	;@04FA2
	jne	@@1	;@04FA7
	mov	bx, word ptr es:[si+0Ch]	;@04FA9
	push	bx	;@04FAD
	and	bx, 3	;@04FAE
	shl	bx, 1	;@04FB1
	shl	bx, 1	;@04FB3
	shl	bx, 1	;@04FB5
	mov	es, word ptr [bx+716h]	;@04FB7
	pop	bx	;@04FBB
	mov	ax, word ptr es:[bx-6]	;@04FBC
	push	si	;@04FC0
	and	si, 3	;@04FC1
	shl	si, 1	;@04FC4
	shl	si, 1	;@04FC6
	shl	si, 1	;@04FC8
	mov	es, word ptr [si+756h]	;@04FCA
	pop	si	;@04FCE
	mov	word ptr es:[si+10h], ax	;@04FCF
@@1:	push	bx	;@04FD3
	and	bx, 3	;@04FD4
	shl	bx, 1	;@04FD7
	shl	bx, 1	;@04FD9
	shl	bx, 1	;@04FDB
	mov	es, word ptr [bx+716h]	;@04FDD
	pop	bx	;@04FE1
	mov	al, byte ptr es:[bx+2]	;@04FE2
	and	ax, 3Fh	;@04FE6
	inc	ax	;@04FE9
	add	word ptr ds:[4DCh], ax	;@04FEA
	adc	word ptr ds:[4DEh], 0	;@04FEE
	inc	word ptr ds:[4E0h]	;@04FF3
	mov	ax, word ptr ds:[4E0h]	;@04FF7
	mov	word ptr es:[bx-4], ax	;@04FFA
	inc	word ptr ds:[4E8h]	;@04FFE
	ret	;@05002
L05003:	push	si	;@05003
	push	ds	;@05004
	mov	si, word ptr es:[si+0Ch]	;@05005
	push	ds	;@05009
	pop	es	;@0500A
	push	si	;@0500B
	and	si, 3	;@0500C
	shl	si, 1	;@0500F
	shl	si, 1	;@05011
	shl	si, 1	;@05013
	mov	ds, word ptr [si+716h]	;@05015
	pop	si	;@05019
	mov	ax, word ptr [si-4]	;@0501A
	mov	word ptr es:[391h], ax	;@0501D
	inc	si	;@05021
	inc	si	;@05022
	mov	cx, 3Fh	;@05023
	and	cl, byte ptr [si]	;@05026
	mov	byte ptr [si], cl	;@05028
	inc	cx	;@0502A
	mov	bx, cx	;@0502B
	add	bx, si	;@0502D
	mov	al, 0	;@0502F
	xchg	byte ptr [bx], al	;@05031
	pop	ds	;@05033
	push	ax	;@05034
	push	bx	;@05035
	mov	ax, word ptr ds:[329h]	;@05036
	mov	dx, word ptr ds:[32Bh]	;@05039
	add	word ptr ds:[329h], cx	;@0503D
	adc	word ptr ds:[32Bh], 0	;@05041
	dec	si	;@05046
	dec	si	;@05047
	mov	bx, si	;@05048
	and	bx, 3	;@0504A
	shl	bx, 1	;@0504D
	shl	bx, 1	;@0504F
	shl	bx, 1	;@05051
	lea	bx, [bx+716h]	;@05053
	push	si	;@05057
	add	si, 3	;@05058
	call	L08AC5	;@0505B
	pop	si	;@0505E
	push	si	;@0505F
	and	si, 3	;@05060
	shl	si, 1	;@05063
	shl	si, 1	;@05065
	shl	si, 1	;@05067
	mov	es, word ptr [si+716h]	;@05069
	pop	si	;@0506D
	pop	bx	;@0506E
	pop	ax	;@0506F
	mov	byte ptr es:[bx], al	;@05070
	pop	si	;@05073
	push	si	;@05074
	and	si, 3	;@05075
	shl	si, 1	;@05078
	shl	si, 1	;@0507A
	shl	si, 1	;@0507C
	mov	es, word ptr [si+756h]	;@0507E
	pop	si	;@05082
	call	L053A0	;@05083
	ret	;@05086
L05087:	push	ax	;@05087
	push	bx	;@05088
	mov	es, word ptr ds:[776h]	;@05089
	mov	ax, word ptr es:[si+2]	;@0508D
	mov	bx, word ptr es:[di+2]	;@05091
	cmp	ax, bx	;@05095
	je	@@3	;@05097
	cmp	ax, word ptr ds:[44Eh]	;@05099
	je	@@2	;@0509D
	cmp	bx, word ptr ds:[44Eh]	;@0509F
	je	@@1	;@050A3
	cmp	ax, word ptr ds:[450h]	;@050A5
	je	@@2	;@050A9
	cmp	bx, word ptr ds:[450h]	;@050AB
	jne	@@3	;@050AF
@@1:	stc	;@050B1
	jmp	short @@4	;@050B2
@@2:	clc	;@050B4
	jmp	short @@4	;@050B5
@@3:	mov	es, word ptr ds:[77Eh]	;@050B7
	mov	ax, word ptr es:[si]	;@050BB
	cmp	ax, word ptr es:[di]	;@050BE
	jne	@@4	;@050C1
	mov	ax, word ptr es:[si+6]	;@050C3
	cmp	ax, word ptr es:[di+6]	;@050C7
	je	@@5	;@050CB
@@4:	mov	es, word ptr ds:[371h]	;@050CD
	pop	bx	;@050D1
	pop	ax	;@050D2
	ret	;@050D3
@@5:	cmp	si, di	;@050D4
	jmp	@@4	;@050D6
L050D8:	push	si	;@050D8
	push	di	;@050D9
	xor	si, si	;@050DA
	mov	di, 0C4Eh	;@050DC
	mov	dx, word ptr ds:[774h]	;@050DF
	jmp	short @@3	;@050E3
@@1:	mov	es, word ptr ds:[77Eh]	;@050E5
	mov	al, 0	;@050E9
	xchg	byte ptr es:[si+9], al	;@050EB
	mov	es, word ptr ds:[776h]	;@050EF
	cmp	byte ptr es:[si+9], 0FFh	;@050F3
	je	@@2	;@050F8
	test	al, 1	;@050FA
	je	@@2	;@050FC
	mov	word ptr [di], si	;@050FE
	inc	di	;@05100
	inc	di	;@05101
@@2:	add	si, 0Ah	;@05102
@@3:	cmp	si, dx	;@05105
	jb	@@1	;@05107
	sub	di, 0C4Eh	;@05109
	jne	@@4	;@0510D
	jmp	@@6	;@0510F
@@4:	mov	ax, di	;@05112
	shr	ax, 1	;@05114
	mov	word ptr ds:[4F4h], ax	;@05116
	mov	dx, 10h	;@05119
	mul	dx	;@0511C
	push	ax	;@0511E
	push	di	;@0511F
	mov	bx, 371h	;@05120
	call	POOL_INIT_OR_DIE	;@05123
	les	di, dword ptr ds:[36Fh]	;@05126
	mov	si, 0C4Eh	;@0512A
	mov	cx, word ptr ds:[4F4h]	;@0512D
	rep movsw	;@05131
	mov	bp, offset L05087	;@05133
	pop	cx	;@05136
	push	cx	;@05137
	call L09252	;@05138
	pop	cx	;@0513B
	pop	di	;@0513C
	mov	si, cx	;@0513D
	sub	di, 2	;@0513F
	sub	si, 2	;@05142
	push	ds	;@05145
	push	es	;@05146
	pop	ds	;@05147
	std	;@05148
	shr	cx, 1	;@05149
	rep movsw	;@0514B
	pop	ds	;@0514D
	cld	;@0514E
	add	di, 2	;@0514F
	mov	dl, 0	;@05152
	sub	bx, bx	;@05154
@@5:	add	dl, 1	;@05156
	adc	dl, 0	;@05159
	mov	es, word ptr ds:[371h]	;@0515C
	mov	si, word ptr es:[di]	;@05160
	mov	es, word ptr ds:[77Eh]	;@05163
	mov	byte ptr es:[si+9], dl	;@05167
	push	word ptr es:[si+6]	;@0516B
	mov	es, word ptr ds:[776h]	;@0516F
	push	word ptr es:[si+6]	;@05173
	push	word ptr es:[si+4]	;@05177
	mov	es, word ptr ds:[77Eh]	;@0517B
	mov	si, word ptr es:[si]	;@0517F
	call L093E8	;@05182
	pop	si	;@05185
	push	si	;@05186
	and	si, 3	;@05187
	shl	si, 1	;@0518A
	shl	si, 1	;@0518C
	shl	si, 1	;@0518E
	mov	es, word ptr [si+736h]	;@05190
	pop	si	;@05194
	mov	si, word ptr es:[si+16h]	;@05195
	mov	es, word ptr ds:[371h]	;@05199
	mov	word ptr es:[bx], si	;@0519D
	mov	word ptr es:[bx+2], ax	;@051A0
	pop	word ptr es:[bx+6]	;@051A4
	pop	word ptr es:[bx+4]	;@051A8
	sub	ax, ax	;@051AC
	mov	word ptr es:[bx+8], ax	;@051AE
	mov	word ptr es:[bx+0Ah], ax	;@051B2
	mov	word ptr es:[bx+0Ch], ax	;@051B6
	mov	word ptr es:[bx+0Eh], ax	;@051BA
	add	bx, 10h	;@051BE
	add	di, 2	;@051C1
	cmp	di, bx	;@051C4
	ja	@@5	;@051C6
@@6:	mov	word ptr ds:[399h], bx	;@051C8
	pop	di	;@051CC
	pop	si	;@051CD
	ret	;@051CE
L051CF:	lodsw	;@051CF
	add	ax, word ptr es:[di]	;@051D0
	jb	@@1	;@051D3
	stosw	;@051D5
	loop	L051CF	;@051D6
	ret	;@051D8
@@1:	jmp	L04A3E	;@051D9
L051DC:	mov	ax, word ptr [bx]	;@051DC
	mov	dx, word ptr [bx+2]	;@051DE
	add	word ptr [bx], cx	;@051E1
	adc	word ptr [bx+2], 0	;@051E3
	mov	bx, bp	;@051E7
	call L08AC5	;@051E9
	ret	;@051EC
L051ED:	push	si	;@051ED
	mov	word ptr ds:[3450h], es	;@051EE
	call L0910F	;@051F2
	pop	dx	;@051F5
	jb	@@1	;@051F6
	mov	ax, word ptr es:[bx-4]	;@051F8
	and	ax, ax	;@051FC
	je	@@1	;@051FE
	ret	;@05200
@@1:	mov	es, word ptr ds:[3450h]	;@05201
	mov	ax, word ptr ds:[3452h]	;@05205
	shl	ax, 1	;@05208
	mov	word ptr ds:[369h], 2BAh	;@0520A
	lds	bx, dword ptr ds:[2B8h]	;@05210
	add	bx, ax	;@05214
@@2:	mov	si, word ptr [bx]	;@05216
	and	si, si	;@05218
	je	@@4	;@0521A
	push	ds	;@0521C
	push	bx	;@0521D
	mov	bp, word ptr [bx+2]	;@0521E
	mov	ds, word ptr cs:DATA_SEGMENT	;@05221
	mov	word ptr ds:[369h], si	;@05226
	mov	ds, word ptr [si]	;@0522A
	lea	si, [bp+6]	;@0522C
	mov	di, dx	;@0522F
	lodsb	;@05231
	scasb	;@05232
	jne	@@3	;@05233
	and	ax, 3Fh	;@05235
	mov	cx, ax	;@05238
	repe cmpsb	;@0523A
	jne	@@3	;@0523C
	mov	ax, word ptr ds:[bp+4]	;@0523E
	add	sp, 4	;@05242
	mov	ds, word ptr cs:DATA_SEGMENT	;@05245
	ret	;@0524A
@@3:	add	sp, 4	;@0524B
	mov	bx, bp	;@0524E
	jmp	@@2	;@05250
@@4:	mov	si, dx	;@05252
	mov	al, byte ptr es:[si]	;@05254
	and	ax, 3Fh	;@05257
	inc	ax	;@0525A
	mov	cx, ax	;@0525B
	add	ax, 7	;@0525D
	push	es	;@05260
	mov	ds, word ptr cs:DATA_SEGMENT	;@05261
@@5:	mov	di, word ptr ds:[35Dh]	;@05266
	add	di, ax	;@0526A
	jb	@@6	;@0526C
	add	di, 2	;@0526E
	jb	@@6	;@05271
	cmp	di, word ptr ds:[361h]	;@05273
	ja	@@6	;@05277
	add	word ptr ds:[359h], ax	;@05279
	adc	word ptr ds:[35Bh], 0	;@0527D
	add	word ptr ds:[4DCh], cx	;@05282
	adc	word ptr ds:[4DEh], 0	;@05286
	dec	di	;@0528B
	dec	di	;@0528C
	xchg	word ptr ds:[35Dh], di	;@0528D
	mov	si, word ptr ds:[35Fh]	;@05291
	mov	ax, ds	;@05295
	push	bx	;@05297
	mov	bx, word ptr ds:[369h]	;@05298
	mov	ds, word ptr [bx]	;@0529C
	pop	bx	;@0529E
	mov	word ptr [bx+2], di	;@0529F
	mov	word ptr [bx], si	;@052A2
	mov	ds, ax	;@052A4
	mov	es, word ptr [si]	;@052A6
	mov	si, dx	;@052A8
	xor	ax, ax	;@052AA
	stosw	;@052AC
	stosw	;@052AD
	inc	word ptr ds:[4E0h]	;@052AE
	mov	ax, word ptr ds:[4E0h]	;@052B2
	stosw	;@052B5
	mov	dx, ds	;@052B6
	pop	ds	;@052B8
	lodsb	;@052B9
	and	al, 3Fh	;@052BA
	stosb	;@052BC
	dec	cx	;@052BD
	shr	cx, 1	;@052BE
	rep movsw	;@052C0
	rcl	cx, 1	;@052C2
	rep movsb	;@052C4
	xor	al, al	;@052C6
	stosb	;@052C8
	mov	ds, dx	;@052C9
	mov	ax, word ptr ds:[4E0h]	;@052CB
	inc	word ptr ds:[363h]	;@052CE
	ret	;@052D2
@@6:	push	ax	;@052D3
	push	bx	;@052D4
	push	cx	;@052D5
	push	dx	;@052D6
	add	word ptr ds:[361h], 800h	;@052D7
	jb	@@9	;@052DD
	push	ds	;@052DF
	push	word ptr ds:[35Fh]	;@052E0
	push	word ptr ds:[361h]	;@052E4
	call	far ptr RESIZE_POOL_BLOCK	;@052E8
@@7:	and	ax, ax	;@052ED
	jne	@@8	;@052EF
	pop	dx	;@052F1
	pop	cx	;@052F2
	pop	bx	;@052F3
	pop	ax	;@052F4
	jmp	@@5	;@052F5
@@8:	jmp	OUT_OF_MEMORY	;@052F8
@@9:	mov	di, word ptr ds:[35Fh]	;@052FB
	mov	es, word ptr [di]	;@052FF
	mov	di, word ptr ds:[35Dh]	;@05301
	mov	ax, 0FFFFh	;@05305
	stosw	;@05308
	add	word ptr ds:[35Fh], 2	;@05309
	mov	ax, 7FDh	;@0530E
	mov	word ptr ds:[361h], ax	;@05311
	mov	word ptr ds:[35Dh], 0	;@05314
	push	ds	;@0531A
	push	word ptr ds:[35Fh]	;@0531B
	push	ax	;@0531F
	call	far ptr POOL_INIT	;@05320
	jmp	@@7	;@05325
L05327:	push	bp	;@05327
	push	ax	;@05328
	push	ds	;@05329
	push	es	;@0532A
	pop	ds	;@0532B
	pop	es	;@0532C
	mov	di, 2C5h	;@0532D
	cmp	al, 0	;@05330
	jne	@@1	;@05332
	lodsb	;@05334
	and	ax, 3Fh	;@05335
	stosb	;@05338
	mov	cx, ax	;@05339
	shr	cx, 1	;@0533B
	rep movsw	;@0533D
	rcl	cx, 1	;@0533F
	rep movsb	;@05341
	jmp	short @@4	;@05343
@@1:	lodsb	;@05345
	and	ax, 3Fh	;@05346
	stosb	;@05349
	mov	cx, ax	;@0534A
	jcxz	@@4	;@0534C
@@2:	lodsb	;@0534E
	cmp	al, 61h	;@0534F
	jb	@@3	;@05351
	cmp	al, 7Ah	;@05353
	ja	@@3	;@05355
	sub	al, 20h	;@05357
@@3:	stosb	;@05359
	loop	@@2	;@0535A
@@4:	push	es	;@0535C
	pop	ds	;@0535D
	mov	si, 2C5h	;@0535E
	cmp	byte ptr es:[si+1], 40h	;@05361
	jne	@@6	;@05366
	mov	al, byte ptr es:[si]	;@05368
	and	ax, 3Fh	;@0536B
	mov	cx, ax	;@0536E
	jcxz	@@6	;@05370
	xor	bx, bx	;@05372
@@5:	inc	bx	;@05374
	cmp	byte ptr es:[bx+si], 24h	;@05375
	loopne	@@5	;@05379
	jne	@@6	;@0537B
	cmp	byte ptr es:[bx+si-1], 40h	;@0537D
	je	@@6	;@05382
	push	si	;@05384
	push	es	;@05385
	mov	al, byte ptr es:[si]	;@05386
	push	ax	;@05389
	dec	bl	;@0538A
	mov	byte ptr es:[si], bl	;@0538C
	xor	ah, ah	;@0538F
	call	L051ED	;@05391
	pop	ax	;@05394
	pop	es	;@05395
	pop	si	;@05396
	mov	byte ptr es:[si], al	;@05397
@@6:	pop	ax	;@0539A
	call	L051ED	;@0539B
	pop	bp	;@0539E
	ret	;@0539F
L053A0:	push	bx	;@053A0
	push	cx	;@053A1
	push	dx	;@053A2
	push	si	;@053A3
	push	es	;@053A4
	mov	di, 290h	;@053A5
	mov	al, byte ptr es:[si+0Fh]	;@053A8
	mov	byte ptr [di+8], al	;@053AC
	mov	ax, word ptr es:[si+10h]	;@053AF
	mov	word ptr [di+2], ax	;@053B3
	push	word ptr es:[si+0Ch]	;@053B6
	test	byte ptr es:[si+0Eh], 20h	;@053BA
	jne	L05411	;@053BF
	call	L07E30	;@053C1
	cmp	dh, 1	;@053C4
	jne	L053D5	;@053C7
	mov	dh, byte ptr [di+8]	;@053C9
	and	dh, 0F8h	;@053CC
	or	dh, 1	;@053CF
	or	byte ptr [di+8], dh	;@053D2
L053D5:	mov	word ptr [di+6], ax	;@053D5
	mov	word ptr [di+4], cx	;@053D8
	pop	si	;@053DB
	mov	ax, word ptr ds:[391h]	;@053DC
	and	ax, ax	;@053DF
	jne	@@1	;@053E1
	push	si	;@053E3
	and	si, 3	;@053E4
	shl	si, 1	;@053E7
	shl	si, 1	;@053E9
	shl	si, 1	;@053EB
	mov	es, word ptr [si+716h]	;@053ED
	pop	si	;@053F1
	add	si, 2	;@053F2
	xor	ax, ax	;@053F5
	call	L05327	;@053F7
@@1:	mov	si, 290h	;@053FA
	mov	word ptr [si], ax	;@053FD
	mov	cx, 9	;@053FF
	mov	bx, 309h	;@05402
	mov	bp, 47Eh	;@05405
	call	L051DC	;@05408
L0540B:	pop	es	;@0540B
	pop	si	;@0540C
	pop	dx	;@0540D
	pop	cx	;@0540E
	pop	bx	;@0540F
	ret	;@05410
L05411:	push	di	;@05411
	mov	si, word ptr es:[si+2]	;@05412
	mov	es, word ptr ds:[806h]	;@05416
	mov	ax, word ptr es:[si+4]	;@0541A
	or	ax, ax	;@0541E
	je	@@1	;@05420
	or	ax, 4000h	;@05422
@@1:	mov	si, word ptr es:[si+0Ah]	;@05425
	or	ax, 8000h	;@05429
	push	ax	;@0542C
	mov	es, word ptr ds:[7CEh]	;@0542D
	mov	si, word ptr es:[si]	;@05431
	push	si	;@05434
	and	si, 3	;@05435
	shl	si, 1	;@05438
	shl	si, 1	;@0543A
	shl	si, 1	;@0543C
	mov	es, word ptr [si+716h]	;@0543E
	pop	si	;@05442
	add	si, 2	;@05443
	mov	ax, 0C000h	;@05446
	call	L05327	;@05449
	mov	cx, ax	;@0544C
	pop	ax	;@0544E
	pop	di	;@0544F
	jmp	L053D5	;@05450
L05452:	add	sp, 2	;@05452
	jmp	L0540B	;@05455
L05457:	mov	ax, 10h	;@05457
	mul	word ptr ds:[4F4h]	;@0545A
	xchg	ax, cx	;@0545E
	jcxz	@@1	;@0545F
	mov	bx, 371h	;@05461
	mov	si, word ptr ds:[36Fh]	;@05464
	mov	dx, word ptr ds:[32Fh]	;@05468
	mov	ax, word ptr ds:[32Dh]	;@0546C
	call L08AC5	;@0546F
	push	ds	;@05472
	mov	ax, 371h	;@05473
	push	ax	;@05476
	call	far ptr FREE_HANDLE_BLOCK	;@05477
@@1:	add	word ptr ds:[4E2h], 0	;@0547C
	mov	ax, word ptr ds:[305h]	;@05481
	mov	word ptr ds:[309h], ax	;@05484
	mov	ax, word ptr ds:[307h]	;@05487
	mov	word ptr ds:[30Bh], ax	;@0548A
	mov	bp, offset L05003	;@0548D
	call	L04F5A	;@05490
	mov	word ptr ds:[391h], 0	;@05493
	mov	ax, word ptr ds:[329h]	;@05499
	mov	dx, word ptr ds:[32Bh]	;@0549C
	mov	bx, 349h	;@054A0
	xor	si, si	;@054A3
@@2:	push	ds	;@054A5
	mov	ds, word ptr [bx]	;@054A6
	cmp	word ptr [si], -1	;@054A8
	je	@@3	;@054AB
	add	si, 6	;@054AD
	mov	cl, byte ptr [si]	;@054B0
	and	cx, 3Fh	;@054B2
	pop	ds	;@054B5
	inc	si	;@054B6
	inc	cx	;@054B7
	push	si	;@054B8
	call L08AC5	;@054B9
	pop	si	;@054BC
	add	ax, cx	;@054BD
	adc	dx, 0	;@054BF
	add	si, cx	;@054C2
	dec	word ptr ds:[363h]	;@054C4
	jne	@@2	;@054C8
	ret	;@054CA
@@3:	pop	ds	;@054CB
	add	bx, 2	;@054CC
	xor	si, si	;@054CF
	jmp	@@2	;@054D1
	db	0Dh dup (0)	;@054D3
; TABLE_OVERFLOW: DATA_OVERFLOW, then fatal message 8.
TABLE_OVERFLOW:	call	DATA_OVERFLOW	;@054E0
	xor	ax, ax	;@054E3
	push	ax	;@054E5
	mov	ax, 8	;@054E6
	push	ax	;@054E9
	call FATAL	;@054EA
L054ED:	push	bp	;@054ED
	mov	bp, sp	;@054EE
	push	si	;@054F0
	mov	si, di	;@054F1
	mov	di, 0FF80h	;@054F3
	sub	di, word ptr [bp+4]	;@054F6
	cmp	di, word ptr [si+2]	;@054F9
	jbe	@@2	;@054FC
@@1:	les	di, dword ptr [si+2]	;@054FE
	add	di, word ptr [bp+4]	;@05501
	cmp	di, word ptr [si]	;@05504
	jbe	@@3	;@05506
	call	L055C4	;@05508
	jmp	@@1	;@0550B
@@2:	stc	;@0550D
	jmp	short @@4	;@0550E
@@3:	xchg	word ptr [si+2], di	;@05510
	clc	;@05513
@@4:	pop	si	;@05514
	pop	bp	;@05515
	ret	2	;@05516
L05519:	push	si	;@05519
	mov	si, bx	;@0551A
	mov	bx, word ptr [si+2]	;@0551C
	sub	di, bx	;@0551F
	push	di	;@05521
	jmp	short @@2	;@05522
@@1:	mov	bx, word ptr [si+6]	;@05524
	push	bx	;@05527
	add	bx, 18h	;@05528
	cmp	bx, si	;@0552B
	pop	bx	;@0552D
	je	@@5	;@0552E
	add	si, 8	;@05530
	mov	word ptr [bx+6], si	;@05533
@@2:	push	di	;@05536
	mov	di, si	;@05537
	call	L054ED	;@05539
	jae	@@3	;@0553C
	pop	di	;@0553E
	push	di	;@0553F
	jmp	@@1	;@05540
@@3:	clc	;@05542
@@4:	pop	si	;@05543
	pop	si	;@05544
	ret	;@05545
@@5:	stc	;@05546
	jmp	@@4	;@05547
L05549:	call	PUT_HEX_WORD	;@05549
	call	PUT_INLINE	;@0554C
	db	2, 2Ch, 20h	;@0554F
	pop	dx	;@05552
	pop	ax	;@05553
	push	dx	;@05554
	call	PUT_HEX_WORD	;@05555
	call	PUT_NEWLINE	;@05558
	ret	;@0555B
; DATA_OVERFLOW: start the "Internal linker data ..." report of what overflowed.
DATA_OVERFLOW:	push	ax	;@0555C
	push	bx	;@0555D
	push	cx	;@0555E
	push	dx	;@0555F
	push	si	;@05560
	push	di	;@05561
	mov	di, word ptr ds:[7641h]	;@05562
	call PUT_NEWLINE	;@05566
	call PUT_INLINE	;@05569
	db	14h, 'Internal linker data'	;@0556C
	call PUT_NEWLINE	;@05581
	mov	bx, 712h	;@05584
@@1:	mov	ax, word ptr [bx]	;@05587
	call PUT_HEX_WORD	;@05589
	call PUT_INLINE	;@0558C
	db	1, 20h	;@0558F
	mov	ax, word ptr [bx+2]	;@05591
	call PUT_HEX_WORD	;@05594
	call PUT_INLINE	;@05597
	db	1, 20h	;@0559A
	mov	ax, word ptr [bx+4]	;@0559C
	call PUT_HEX_WORD	;@0559F
	call PUT_INLINE	;@055A2
	db	1, 20h	;@055A5
	mov	ax, word ptr [bx+6]	;@055A7
	call PUT_HEX_WORD	;@055AA
	call PUT_NEWLINE	;@055AD
	add	bx, 8	;@055B0
	cmp	bx, 832h	;@055B3
	jb	@@1	;@055B7
	mov	word ptr ds:[7641h], di	;@055B9
	pop	di	;@055BD
	pop	si	;@055BE
	pop	dx	;@055BF
	pop	cx	;@055C0
	pop	bx	;@055C1
	pop	ax	;@055C2
	ret	;@055C3
L055C4:	push	ax	;@055C4
	push	bx	;@055C5
	push	cx	;@055C6
	push	dx	;@055C7
	push	di	;@055C8
	push	si	;@055C9
	push	bp	;@055CA
	mov	ax, word ptr [si]	;@055CB
	cmp	ax, 0FF80h	;@055CD
	jae	@@3	;@055D0
	cmp	ax, 0F80h	;@055D2
	jae	@@1	;@055D5
	add	ax, ax	;@055D7
	add	ax, 80h	;@055D9
	jmp	short @@2	;@055DC
@@1:	add	ax, 1000h	;@055DE
@@2:	mov	di, ax	;@055E1
	xchg	word ptr [si], di	;@055E3
	push	ds	;@055E5
	lea	si, [si+4]	;@055E6
	push	si	;@055E9
	push	ax	;@055EA
	push	ds	;@055EB
	push	si	;@055EC
	call	far ptr HEAP_MODE_SET_BIT13	;@055ED
	call	far ptr RESIZE_POOL_BLOCK	;@055F2
	and	ax, ax	;@055F7
	jne	@@3	;@055F9
	pop	bp	;@055FB
	pop	si	;@055FC
	pop	di	;@055FD
	pop	dx	;@055FE
	pop	cx	;@055FF
	pop	bx	;@05600
	pop	ax	;@05601
	ret	;@05602
@@3:	jmp	OUT_OF_MEMORY	;@05603
; NEW_POOL: a new 80h-byte pool in the far heap (POOL_INIT) for the list at DI.
NEW_POOL:	push	cx	;@05606
	push	di	;@05607
	mov	word ptr [di+2], 0	;@05608
	mov	ax, 80h	;@0560D
	mov	word ptr [di], ax	;@05610
	add	di, 4	;@05612
	push	ds	;@05615
	push	di	;@05616
	push	ax	;@05617
	call	far ptr POOL_INIT	;@05618
	pop	di	;@0561D
	pop	cx	;@0561E
	ret	;@0561F
L05620:	mov	di, 712h	;@05620
@@1:	call	NEW_POOL	;@05623
	and	ax, ax	;@05626
	je	@@2	;@05628
	jmp	L056C7	;@0562A
@@2:	add	di, 8	;@0562D
	cmp	di, 7BAh	;@05630
	jbe	@@1	;@05634
	mov	word ptr ds:[754h], 0	;@05636
	mov	word ptr ds:[75Ch], 1	;@0563C
	mov	word ptr ds:[764h], 2	;@05642
	mov	word ptr ds:[76Ch], 3	;@05648
	mov	word ptr ds:[758h], 752h	;@0564E
	mov	word ptr ds:[760h], 752h	;@05654
	mov	word ptr ds:[768h], 752h	;@0565A
	mov	word ptr ds:[770h], 752h	;@05660
	mov	word ptr ds:[714h], 2	;@05666
	mov	word ptr ds:[71Ch], 3	;@0566C
	mov	word ptr ds:[724h], 4	;@05672
	mov	word ptr ds:[72Ch], 5	;@05678
	mov	word ptr ds:[718h], 712h	;@0567E
	mov	word ptr ds:[720h], 712h	;@05684
	mov	word ptr ds:[728h], 712h	;@0568A
	mov	word ptr ds:[730h], 712h	;@05690
	mov	word ptr ds:[734h], 0	;@05696
	mov	word ptr ds:[73Ch], 1	;@0569C
	mov	word ptr ds:[744h], 2	;@056A2
	mov	word ptr ds:[74Ch], 3	;@056A8
	mov	word ptr ds:[738h], 732h	;@056AE
	mov	word ptr ds:[740h], 732h	;@056B4
	mov	word ptr ds:[748h], 732h	;@056BA
	mov	word ptr ds:[750h], 732h	;@056C0
	ret	;@056C6
L056C7:	jmp	OUT_OF_MEMORY	;@056C7
L056CA:	push	cx	;@056CA
	push	di	;@056CB
	mov	cx, 4	;@056CC
@@1:	call	NEW_POOL	;@056CF
	and	ax, ax	;@056D2
	jne	L056C7	;@056D4
	add	di, 8	;@056D6
	loop	@@1	;@056D9
	pop	di	;@056DB
	mov	word ptr [di+2], 0	;@056DC
	mov	word ptr [di+0Ah], 1	;@056E1
	mov	word ptr [di+12h], 2	;@056E6
	mov	word ptr [di+1Ah], 3	;@056EB
	mov	word ptr [di+6], di	;@056F0
	mov	word ptr [di+0Eh], di	;@056F3
	mov	word ptr [di+16h], di	;@056F6
	mov	word ptr [di+1Eh], di	;@056F9
	pop	cx	;@056FC
	ret	;@056FD
L056FE:	mov	word ptr [di+2], 0	;@056FE
	mov	word ptr [di+0Ah], 0	;@05703
	mov	word ptr [di+12h], 0	;@05708
	mov	word ptr [di+1Ah], 0	;@0570D
	ret	;@05712
L05713:	push	cx	;@05713
	push	di	;@05714
	mov	cx, 4	;@05715
@@1:	push	cx	;@05718
	call	L05725	;@05719
	pop	cx	;@0571C
	add	di, 8	;@0571D
	loop	@@1	;@05720
	pop	di	;@05722
	pop	cx	;@05723
	ret	;@05724
L05725:	push	si	;@05725
	push	di	;@05726
	cmp	word ptr [di], 0	;@05727
	je	@@3	;@0572A
	mov	ax, word ptr [di+2]	;@0572C
	mov	word ptr [di], ax	;@0572F
	lea	di, [di+4]	;@05731
	push	ds	;@05734
	push	di	;@05735
	and	ax, ax	;@05736
	je	@@1	;@05738
	push	ax	;@0573A
	call	far ptr RESIZE_POOL_BLOCK	;@0573B
	jmp	short @@2	;@05740
@@1:	call	far ptr FREE_HANDLE_BLOCK	;@05742
@@2:	and	ax, ax	;@05747
	jne	@@4	;@05749
@@3:	pop	di	;@0574B
	pop	si	;@0574C
	ret	;@0574D
@@4:	jmp	OUT_OF_MEMORY	;@0574E
L05751:	add	word ptr ds:[714h], 4	;@05751
	add	word ptr ds:[71Ch], 4	;@05756
	add	word ptr ds:[724h], 4	;@0575B
	add	word ptr ds:[72Ch], 4	;@05760
	mov	di, 712h	;@05765
@@1:	call	L05725	;@05768
	add	di, 8	;@0576B
	cmp	di, 7BAh	;@0576E
	jbe	@@1	;@05772
	call	far ptr GATHER_ALL_FREE_SPACE	;@05774
	ret	;@05779
	db	6 dup (0)	;@0577A
L05780	db	18h, 0, 38h, 0, 38h, 0, ' in module ', 0, ' and ', 0, 6, 'DGROUP'	;@05780
	db	7, 'BEGDATA', 7, 'ENDCODE', 3, 'BSS', 7, 'FAR_BSS', 9, '__GHOST__'
	db	6, 'DEBSYM', 6, 'DEBTYP', 8, '_COMDEF_', 5, 'STACK', 4, 'CODE'
	db	4, '????', 8, '@OVYDATA', 7, 'STUBSEG', 9, '_EXEINFO_', 7, 'OVRINFO'
	db	0Ch, '__SEGTABLE__', 0Dh, '__SEGTABEND__', 0Bh, '__OVRTRAP__'
	db	0Bh, '__EXENAME__', 0Bh, '__EXEDATE__', 0Ch, '__OvrPrepare', 5
	db	'_TEXT', 6, '_edata', 4, '_end', 6, 'FIARQQ', 6, 'FISRQQ', 6, 'FICRQQ'
	db	6, 'FIERQQ', 6, 'FIDRQQ', 6, 'FIWRQQ', 6, 'FJARQQ', 6, 'FJSRQQ'
	db	6, 'FJCRQQ', 5, '__WEP', 3, 'WEP', 0E2h, 57h, 4Ch, 4, 80h, 0FDh
	db	57h, 54h, 4, 80h, 7, 58h, 56h, 4, 80h, 0F5h, 57h, 52h, 4, 80h
	db	98h, 57h, 24h, 4, 80h, 9Fh, 57h, 2Eh, 4, 80h, 0A7h, 57h, 30h, 4
	db	80h, 0AFh, 57h, 26h, 4, 80h, 0B3h, 57h, 28h, 4, 80h, 0D3h, 57h
	db	2Ah, 4, 80h, 0DCh, 57h, 2Ch, 4, 80h, 0BBh, 57h, 36h, 4, 80h, '[X8'
	db	4, 80h, 0C5h, 57h, 32h, 4, 80h, 0CCh, 57h, 34h, 4, 80h, 0E7h, 57h
	db	4Eh, 4, 80h, 0ECh, 57h, 50h, 4, 80h, 'mX`', 4, 0, 'tXb', 4, 0
	db	'{Xd', 4, 0, 82h, 58h, 66h, 4, 0, 89h, 58h, 68h, 4, 0, 90h, 58h
	db	6Ah, 4, 0, 97h, 58h, 6Ch, 4, 0, 9Eh, 58h, 6Eh, 4, 0, 0A5h, 58h
	db	70h, 4, 0, 0B2h, 58h, 72h, 4, 0, 0ACh, 58h, 74h, 4, 0
L05942:	mov	byte ptr ds:[3D6h], 0	;@05942
	cmp	byte ptr ds:[3D5h], 1	;@05947
	jne	@@1	;@0594C
	cmp	byte ptr ds:[254h], 0	;@0594E
	je	@@1	;@05953
	mov	byte ptr ds:[3D6h], 1	;@05955
@@1:	mov	byte ptr ds:[3D2h], 0	;@0595A
	mov	si, 144Eh	;@0595F
	cmp	byte ptr ds:[3D4h], 1	;@05962
	jne L059B4	;@05967
	mov	di, word ptr ds:[3E2h]	;@05969
	push	di	;@0596D
	and	di, 3	;@0596E
	shl	di, 1	;@05971
	shl	di, 1	;@05973
	shl	di, 1	;@05975
	mov	es, word ptr [di+736h]	;@05977
	pop	di	;@0597B
	cmp	word ptr es:[di+0Ch], 0	;@0597C
	je L059B4	;@05981
	mov	byte ptr ds:[3D2h], 2	;@05983
	cmp	byte ptr ds:[3D5h], 4	;@05988
	je	@@2	;@0598D
	dec	byte ptr ds:[3D2h]	;@0598F
	jmp short L059B4	;@05993
@@2:	cmp	word ptr es:[di+0Ah], 2	;@05995
	jae L059B4	;@0599A
	jmp L09003	;@0599C
L0599F:	call L087E1	;@0599F
	jmp short L059B4	;@059A2
L059A4:	call L087E1	;@059A4
	jmp short L059CA	;@059A7
; BAD_RECORD, SKIP_TYPDEF, SKIP_RECORD: entries of the record tables for record types
; TLINK does not handle: an unknown type is an error, TYPDEF and the obsolete Intel types are
; skipped.  (The two NOPs are separate entry points.)
BAD_RECORD:	nop	;@059A9
L059AA:	nop	;@059AA
L059AB:	inc word ptr ds:[41Ch]	;@059AB
	mov	si, word ptr ds:[3E0h]	;@059AF
	inc	si	;@059B3
L059B4:	mov	cx, word ptr ds:[3458h]	;@059B4
	sub	cx, si	;@059B8
	cmp	cx, 3	;@059BA
	jb	L0599F	;@059BD
	mov	bl, byte ptr [si]	;@059BF
	inc	si	;@059C1
	sub	bh, bh	;@059C2
	lodsw	;@059C4
	cmp	ax, 2300h	;@059C5
	ja	L059F0	;@059C8
L059CA:	mov	cx, word ptr ds:[3458h]	;@059CA
	sub	cx, si	;@059CE
	cmp	cx, ax	;@059D0
	jb	L059A4	;@059D2
	mov	di, si	;@059D4
	add	di, ax	;@059D6
	dec	di	;@059D8
	mov	word ptr ds:[3E0h], di	;@059D9
	shr	bx, 1	;@059DD
	jb	L059F3	;@059DF
	mov	word ptr ds:[41Eh], 0	;@059E1
L059E7:	shl	bx, 1	;@059E7
	add	bx, word ptr ds:[3D0h]	;@059E9
	jmp	word ptr cs:[bx]	;@059ED
L059F0:	call	L0885D	;@059F0
L059F3:	mov	word ptr ds:[41Eh], 1	;@059F3
	cmp	bx, 78h	;@059F9
	je	IGNORE_RECORD	;@059FC
	cmp	byte ptr ds:[125h], 0	;@059FE
	jne	L059E7	;@05A03
	mov	word ptr ds:[422h], 1	;@05A05
	xor	cx, cx	;@05A0B
	push	cx	;@05A0D
	mov	ax, 1Dh	;@05A0E
	push	ax	;@05A11
	call FATAL	;@05A12
; IGNORE_RECORD: a record type ignored without a word (A6h..AAh).
IGNORE_RECORD:	ret	;@05A15

; the pass-1 handlers of the object records, by record type / 2 (80h THEADR at 40h ...)
PASS1_RECORDS	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD	;@05A16
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, L059AB
	dw	L059AB, L059AB, L059AB, L059AB, L059AB, L059AB, L059AB, L059AB
	dw	P1_THEADR, L059AB, L059AB, L059AB, P1_COMENT, P1_MODEND, P1_EXTDEF, L059AA
	dw	P1_PUBDEF, P1_LPUBDEF, P1_LINNUM, P1_LNAMES, P1_SEGDEF, P1_GRPDEF, P1_FIXUPP, L059AB
	dw	P1_LEDATA, P1_LIDATA, LIBRARY_HEADER, IGNORE_RECORD, IGNORE_RECORD, IGNORE_RECORD, BAD_RECORD, BAD_RECORD
	dw	P1_COMDEF, BAD_RECORD, P1_LEXTDEF, P1_LPUBDEF, P1_LCOMDEF, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	LIBRARY_HEADER, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD

; the pass-2 handlers of the object records
PASS2_RECORDS	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD	;@05B16
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, L059AB
	dw	L059AB, L059AB, L059AB, L059AB, L059AB, L059AB, L059AB, L059AB
	dw	P2_THEADR, L059AB, L059AB, L059AB, P2_COMENT, P2_MODEND, L059AB, L059AB
	dw	L059AB, L059AB, P2_LINNUM, L059AB, L059AB, L059AB, P2_FIXUPP, L059AB
	dw	P2_LEDATA, P2_LIDATA, LIBRARY_HEADER, IGNORE_RECORD, IGNORE_RECORD, IGNORE_RECORD, BAD_RECORD, BAD_RECORD
	dw	L059AB, L059AB, L059AB, L059AB, L059AB, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
	dw	LIBRARY_HEADER, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD, BAD_RECORD
L05C16:	push	cx	;@05C16
	mov	cx, 0Ah	;@05C17
	mov	di, cx	;@05C1A
	push	di	;@05C1C
	mov	di, 77Ah	;@05C1D
	call	L054ED	;@05C20
	jae	@@1	;@05C23
	call	TABLE_OVERFLOW	;@05C25
@@1:	mov	word ptr ds:[0C49h], di	;@05C28
	push	di	;@05C2C
	xor	ax, ax	;@05C2D
	cld	;@05C2F
	rep stosb	;@05C30
	pop	di	;@05C32
	dec	word ptr es:[di]	;@05C33
	dec	word ptr es:[di+4]	;@05C36
	dec	word ptr es:[di+2]	;@05C3A
	mov	cx, 0Ah	;@05C3E
	mov	di, cx	;@05C41
	push	di	;@05C43
	mov	di, 772h	;@05C44
	call	L054ED	;@05C47
	jae	@@2	;@05C4A
	call	TABLE_OVERFLOW	;@05C4C
@@2:	push	di	;@05C4F
	xor	ax, ax	;@05C50
	cld	;@05C52
	rep stosb	;@05C53
	pop	di	;@05C55
	pop	cx	;@05C56
	ret	;@05C57
L05C58:	shl	dx, 1	;@05C58
	cmp	byte ptr ds:[17h], 0	;@05C5A
	je	@@1	;@05C5F
	shl	dx, 1	;@05C61
	shl	dx, 1	;@05C63
	add	dx, 2	;@05C65
@@1:	add	ax, dx	;@05C68
	mov	dx, 0	;@05C6A
	adc	dx, dx	;@05C6D
	ret	;@05C6F
L05C70:	mov	word ptr ds:[47Ah], 0	;@05C70
	mov	si, 580Fh	;@05C76
	mov	ah, 0	;@05C79
	mov	word ptr ds:[3450h], cs	;@05C7B
	call	L0921C	;@05C7F
	mov	word ptr ds:[458h], bx	;@05C82
	jb	@@1	;@05C86
	or	word ptr ds:[47Ah], 1	;@05C88
@@1:	mov	si, 581Ch	;@05C8D
	mov	ah, 0	;@05C90
	mov	word ptr ds:[3450h], cs	;@05C92
	call	L0921C	;@05C96
	mov	word ptr ds:[45Ah], bx	;@05C99
	jb	@@2	;@05C9D
	or	word ptr ds:[47Ah], 2	;@05C9F
@@2:	mov	si, 5836h	;@05CA4
	mov	ah, 0	;@05CA7
	mov	word ptr ds:[3450h], cs	;@05CA9
	call	L0921C	;@05CAD
	mov	word ptr ds:[45Ch], bx	;@05CB0
	jb	@@3	;@05CB4
	or	word ptr ds:[47Ah], 4	;@05CB6
@@3:	mov	si, 5842h	;@05CBB
	mov	ah, 0	;@05CBE
	mov	word ptr ds:[3450h], cs	;@05CC0
	call	L0921C	;@05CC4
	mov	word ptr ds:[45Eh], bx	;@05CC7
	jb	@@4	;@05CCB
	or	word ptr ds:[47Ah], 8	;@05CCD
@@4:	cmp	word ptr ds:[47Ah], 0	;@05CD2
	jne	@@5	;@05CD7
	jmp	@@11	;@05CD9
@@5:	push	bx	;@05CDC
	mov	bx, word ptr ds:[738h]	;@05CDD
	les	di, dword ptr [bx+2]	;@05CE1
	add	di, 18h	;@05CE4
	cmp	di, word ptr [bx]	;@05CE7
	jbe	@@6	;@05CE9
	call	L05519	;@05CEB
	pop	bx	;@05CEE
	jae	@@7	;@05CEF
	call	TABLE_OVERFLOW	;@05CF1
@@6:	xchg	word ptr [bx+2], di	;@05CF4
	pop	bx	;@05CF7
@@7:	mov	dx, di	;@05CF8
	mov	ax, word ptr ds:[456h]	;@05CFA
	stosw	;@05CFD
	mov	ax, word ptr ds:[774h]	;@05CFE
	stosw	;@05D01
	mov	ax, word ptr ds:[784h]	;@05D02
	stosw	;@05D05
	mov	ax, word ptr ds:[794h]	;@05D06
	stosw	;@05D09
	mov	ax, word ptr ds:[7ACh]	;@05D0A
	stosw	;@05D0D
	mov	ax, 1	;@05D0E
	stosw	;@05D11
	mov	al, 0	;@05D12
	stosw	;@05D14
	stosw	;@05D15
	stosb	;@05D16
	mov	bx, word ptr ds:[454h]	;@05D17
	mov	ax, word ptr ds:[3D8h]	;@05D1B
	inc	ax	;@05D1E
	mov	word ptr ds:[3D8h], ax	;@05D1F
	push	bx	;@05D22
	and	bx, 3	;@05D23
	shl	bx, 1	;@05D26
	shl	bx, 1	;@05D28
	shl	bx, 1	;@05D2A
	mov	es, word ptr [bx+716h]	;@05D2C
	pop	bx	;@05D30
	mov	word ptr es:[bx], ax	;@05D31
	call	L05C16	;@05D34
	mov	word ptr es:[di], bx	;@05D37
	mov	ax, word ptr ds:[456h]	;@05D3A
	mov	word ptr es:[di+2], ax	;@05D3D
	mov	byte ptr es:[di+9], 68h	;@05D41
	mov	word ptr es:[di+4], dx	;@05D46
	mov	word ptr ds:[408h], di	;@05D4A
	test	word ptr ds:[47Ah], 1	;@05D4E
	je	@@8	;@05D54
	mov	bx, word ptr ds:[458h]	;@05D56
	call	@@12	;@05D5A
@@8:	test	word ptr ds:[47Ah], 2	;@05D5D
	je	@@9	;@05D63
	mov	bx, word ptr ds:[45Ah]	;@05D65
	call	@@12	;@05D69
@@9:	test	word ptr ds:[47Ah], 4	;@05D6C
	je	@@10	;@05D72
	mov	bx, word ptr ds:[45Ch]	;@05D74
	call	@@12	;@05D78
@@10:	test	word ptr ds:[47Ah], 8	;@05D7B
	je	@@11	;@05D81
	mov	bx, word ptr ds:[45Eh]	;@05D83
	call	@@12	;@05D87
@@11:	ret	;@05D8A
@@12:	push	bx	;@05D8B
	and	bx, 3	;@05D8C
	shl	bx, 1	;@05D8F
	shl	bx, 1	;@05D91
	shl	bx, 1	;@05D93
	mov	es, word ptr [bx+756h]	;@05D95
	pop	bx	;@05D99
	mov	word ptr es:[bx], di	;@05D9A
	and	byte ptr es:[bx+0Eh], 0EFh	;@05D9D
	mov	word ptr es:[bx+2], dx	;@05DA2
	ret	;@05DA6
L05DA7:	push	bp	;@05DA7
	mov	bp, sp	;@05DA8
	push	bx	;@05DAA
	push	cx	;@05DAB
	push	di	;@05DAC
	mov	si, word ptr [bp+4]	;@05DAD
	push	si	;@05DB0
	and	si, 3	;@05DB1
	shl	si, 1	;@05DB4
	shl	si, 1	;@05DB6
	shl	si, 1	;@05DB8
	mov	es, word ptr [si+736h]	;@05DBA
	pop	si	;@05DBE
	mov	di, si	;@05DBF
	and	di, 3	;@05DC1
	shl	di, 1	;@05DC4
	shl	di, 1	;@05DC6
	shl	di, 1	;@05DC8
	lea	di, [di+732h]	;@05DCA
	xor	bx, bx	;@05DCE
	mov	bl, byte ptr es:[si+10h]	;@05DD0
	mov	bx, word ptr cs:L05780[bx]	;@05DD4
	add	bx, si	;@05DD9
	mov	si, word ptr es:[si+8]	;@05DDB
	cmp	bx, word ptr [di+2]	;@05DDF
	je	@@2	;@05DE2
@@1:	mov	bx, word ptr es:[bx+8]	;@05DE4
	jmp	short @@4	;@05DE8
@@2:	cmp	di, 762h	;@05DEA
	ja	@@3	;@05DEE
	mov	bx, si	;@05DF0
	and	bx, 3	;@05DF2
	inc	bx	;@05DF5
	push	bx	;@05DF6
	and	bx, 3	;@05DF7
	shl	bx, 1	;@05DFA
	shl	bx, 1	;@05DFC
	shl	bx, 1	;@05DFE
	mov	es, word ptr [bx+736h]	;@05E00
	pop	bx	;@05E04
	jmp	@@1	;@05E05
@@3:	mov	bx, word ptr ds:[7ACh]	;@05E07
@@4:	cmp	si, bx	;@05E0B
	jae	@@5	;@05E0D
	mov	es, word ptr ds:[7AEh]	;@05E0F
	mov	di, word ptr es:[si]	;@05E13
	mov	es, word ptr ds:[786h]	;@05E16
	mov	di, word ptr es:[di]	;@05E1A
	cmp	di, word ptr [bp+6]	;@05E1D
	je	@@6	;@05E20
	add	si, 11h	;@05E22
	jmp	@@4	;@05E25
@@5:	stc	;@05E27
	jmp	short @@7	;@05E28
@@6:	mov	es, word ptr ds:[7AEh]	;@05E2A
	clc	;@05E2E
@@7:	pop	di	;@05E2F
	pop	cx	;@05E30
	pop	bx	;@05E31
	mov	sp, bp	;@05E32
	pop	bp	;@05E34
	ret	4	;@05E35
L05E38:	push	bp	;@05E38
	mov	bp, sp	;@05E39
	sub	sp, 90h	;@05E3B
	push	si	;@05E3F
	push	di	;@05E40
	xor	ax, ax	;@05E41
	mov	word ptr [bp-90h], ax	;@05E43
	mov	word ptr [bp-0Eh], ax	;@05E47
	mov	word ptr [bp-0Ah], ax	;@05E4A
	dec	ax	;@05E4D
	mov	word ptr [bp-6], ax	;@05E4E
	mov	ax, word ptr es:[di]	;@05E51
	mov	word ptr [bp-8], ax	;@05E54
	mov	si, word ptr es:[di+0Ah]	;@05E57
@@1:	cmp	si, -1	;@05E5B
	jae	@@6	;@05E5E
	mov	es, word ptr ds:[7A6h]	;@05E60
	mov	ax, word ptr es:[si+0Ah]	;@05E64
	mov	word ptr [bp-0Ch], ax	;@05E68
	mov	ax, word ptr es:[si+6]	;@05E6B
	mov	bx, word ptr es:[si+2]	;@05E6F
	mov	cx, word ptr es:[si+8]	;@05E73
	mov	dx, word ptr es:[si+4]	;@05E77
	mov	si, word ptr es:[si]	;@05E7B
	push	bx	;@05E7E
	and	bx, 3	;@05E7F
	shl	bx, 1	;@05E82
	shl	bx, 1	;@05E84
	shl	bx, 1	;@05E86
	mov	es, word ptr [bx+736h]	;@05E88
	pop	bx	;@05E8C
	cmp	word ptr es:[bx+0Ah], 2	;@05E8D
	jb	@@1	;@05E92
	cmp	word ptr [bp-8], -2	;@05E94
	jb	@@4	;@05E98
	cmp	dx, word ptr [bp-8]	;@05E9A
	je	@@2	;@05E9D
	jmp	@@17	;@05E9F
@@2:	cmp	cx, word ptr [bp-0Eh]	;@05EA2
	jb	@@1	;@05EA5
	jne	@@3	;@05EA7
	cmp	ax, word ptr [bp-90h]	;@05EA9
	jb	@@1	;@05EAD
@@3:	mov	word ptr [bp-90h], ax	;@05EAF
	mov	word ptr [bp-6], bx	;@05EB3
	mov	word ptr [bp-0Eh], cx	;@05EB6
	mov	ax, word ptr [bp-0Ch]	;@05EB9
	mov	word ptr [bp-0Ah], ax	;@05EBC
	mov	word ptr [bp-8], dx	;@05EBF
	jmp	@@1	;@05EC2
@@4:	cmp	word ptr [bp-6], -1	;@05EC4
	je	@@3	;@05EC8
	cmp	ax, word ptr [bp-90h]	;@05ECA
	jne	@@5	;@05ECE
	cmp	cx, word ptr [bp-0Eh]	;@05ED0
	jne	@@5	;@05ED3
	jmp	@@3	;@05ED5
@@5:	call	@@19	;@05ED7
	jmp	@@3	;@05EDA
@@6:	cmp	word ptr [bp-6], -1	;@05EDC
	jne	@@7	;@05EE0
	jmp	@@16	;@05EE2
@@7:	push	di	;@05EE5
	and	di, 3	;@05EE6
	shl	di, 1	;@05EE9
	shl	di, 1	;@05EEB
	shl	di, 1	;@05EED
	mov	es, word ptr [di+756h]	;@05EEF
	pop	di	;@05EF3
	mov	ax, word ptr [bp-90h]	;@05EF4
	mov	word ptr es:[di+4], ax	;@05EF8
	mov	ax, word ptr [bp-0Eh]	;@05EFC
	mov	word ptr es:[di+6], ax	;@05EFF
	mov	bx, word ptr [bp-6]	;@05F03
	mov	word ptr es:[di+2], bx	;@05F06
	mov	si, word ptr [bp-8]	;@05F0A
	mov	word ptr es:[di], si	;@05F0D
	mov	word ptr es:[di+0Ah], 0FFFFh	;@05F10
	cmp	si, -2	;@05F16
	jb	@@8	;@05F19
	jmp	@@16	;@05F1B
@@8:	mov	es, word ptr ds:[77Eh]	;@05F1E
	mov	cx, word ptr es:[si+4]	;@05F22
	cmp	cx, -1	;@05F26
	je	@@9	;@05F29
	mov	cx, di	;@05F2B
	xchg	word ptr es:[si+4], cx	;@05F2D
	push	di	;@05F31
	and	di, 3	;@05F32
	shl	di, 1	;@05F35
	shl	di, 1	;@05F37
	shl	di, 1	;@05F39
	mov	es, word ptr [di+756h]	;@05F3B
	pop	di	;@05F3F
	mov	word ptr es:[di+0Ah], cx	;@05F40
	mov	es, word ptr ds:[77Eh]	;@05F44
@@9:	mov	cx, word ptr [bp-0Ah]	;@05F48
	add	word ptr es:[si+6], cx	;@05F4B
	add	word ptr ds:[4A0h], cx	;@05F4F
	mov	bx, word ptr [bp-6]	;@05F53
	push	bx	;@05F56
	and	bx, 3	;@05F57
	shl	bx, 1	;@05F5A
	shl	bx, 1	;@05F5C
	shl	bx, 1	;@05F5E
	mov	es, word ptr [bx+736h]	;@05F60
	pop	bx	;@05F64
	add	word ptr es:[bx+0Eh], cx	;@05F65
	push	di	;@05F69
	push	bx	;@05F6A
	call	L05DA7	;@05F6B
	jae	@@10	;@05F6E
	jmp	@@16	;@05F70
@@10:	mov	di, bx	;@05F73
	mov	al, byte ptr es:[si+10h]	;@05F75
	mov	bx, word ptr es:[si+2]	;@05F79
	mov	cx, word ptr es:[si+4]	;@05F7D
	mov	dx, word ptr es:[si+6]	;@05F81
	push	word ptr es:[si+0Ch]	;@05F85
	push	word ptr es:[si+0Eh]	;@05F89
	push	word ptr es:[si+0Ah]	;@05F8D
	push	word ptr es:[si+8]	;@05F91
	push	di	;@05F95
	and	di, 3	;@05F96
	shl	di, 1	;@05F99
	shl	di, 1	;@05F9B
	shl	di, 1	;@05F9D
	mov	es, word ptr [di+736h]	;@05F9F
	pop	di	;@05FA3
	cmp	byte ptr es:[di+10h], 0	;@05FA4
	jne	@@11	;@05FA9
	mov	byte ptr es:[di+10h], al	;@05FAB
@@11:	add	word ptr es:[di+24h], bx	;@05FAF
	pop	bx	;@05FB3
	add	word ptr es:[di+20h], bx	;@05FB4
	pop	bx	;@05FB8
	add	word ptr es:[di+28h], bx	;@05FB9
	add	word ptr es:[di+22h], cx	;@05FBD
	mov	ax, word ptr es:[di+28h]	;@05FC1
	cmp	ax, word ptr ds:[48Ah]	;@05FC5
	jbe	@@12	;@05FC9
	mov	word ptr ds:[48Ah], ax	;@05FCB
@@12:	cmp	dx, word ptr ds:[48Ch]	;@05FCE
	jbe	@@13	;@05FD2
	mov	word ptr ds:[48Ch], dx	;@05FD4
@@13:	add	word ptr es:[di+1Ch], dx	;@05FD8
	pop	dx	;@05FDC
	add	word ptr es:[di+34h], dx	;@05FDD
	mov	dx, word ptr es:[di+34h]	;@05FE1
	cmp	dx, word ptr ds:[3C6h]	;@05FE5
	jbe	@@14	;@05FE9
	mov	word ptr ds:[3C6h], dx	;@05FEB
@@14:	pop	dx	;@05FEF
	add	word ptr es:[di+32h], dx	;@05FF0
	mov	dx, word ptr es:[di+32h]	;@05FF4
	cmp	dx, word ptr ds:[3C8h]	;@05FF8
	jbe	@@15	;@05FFC
	mov	word ptr ds:[3C8h], dx	;@05FFE
@@15:	mov	es, word ptr ds:[7AEh]	;@06002
	mov	si, word ptr es:[si]	;@06006
	mov	es, word ptr ds:[786h]	;@06009
	mov	si, word ptr es:[si]	;@0600D
	push	si	;@06010
	and	si, 3	;@06011
	shl	si, 1	;@06014
	shl	si, 1	;@06016
	shl	si, 1	;@06018
	mov	es, word ptr [si+756h]	;@0601A
	pop	si	;@0601E
	mov	si, word ptr es:[si]	;@0601F
	mov	es, word ptr ds:[77Eh]	;@06022
	or	byte ptr es:[si+9], 1	;@06026
@@16:	pop	di	;@0602B
	pop	si	;@0602C
	mov	sp, bp	;@0602D
	pop	bp	;@0602F
	ret	;@06030
@@17:	cmp	word ptr [bp-6], -1	;@06031
	jne	@@18	;@06035
	jmp	@@2	;@06037
@@18:	call	@@19	;@0603A
	jmp	@@16	;@0603D
@@19:	push	ax	;@0603F
	push	bx	;@06040
	push	cx	;@06041
	push	dx	;@06042
	push	si	;@06043
	push	di	;@06044
	push	di	;@06045
	push	di	;@06046
	and	di, 3	;@06047
	shl	di, 1	;@0604A
	shl	di, 1	;@0604C
	shl	di, 1	;@0604E
	mov	es, word ptr [di+756h]	;@06050
	pop	di	;@06054
	mov	si, word ptr es:[di+0Ch]	;@06055
	push	si	;@06059
	and	si, 3	;@0605A
	shl	si, 1	;@0605D
	shl	si, 1	;@0605F
	shl	si, 1	;@06061
	mov	es, word ptr [si+716h]	;@06063
	pop	si	;@06067
	cmp	byte ptr es:[si+3], 40h	;@06068
	mov	di, 26h	;@0606D
	je	@@20	;@06070
	call COPY_NAME	;@06072
	jmp	short @@21	;@06075
@@20:	push	bx	;@06077
	call DEMANGLE_NAME	;@06078
	pop	bx	;@0607B
@@21:	mov	si, word ptr [bp-6]	;@0607C
	push	si	;@0607F
	and	si, 3	;@06080
	shl	si, 1	;@06083
	shl	si, 1	;@06085
	shl	si, 1	;@06087
	mov	es, word ptr [si+736h]	;@06089
	pop	si	;@0608D
	mov	si, word ptr es:[si]	;@0608E
	mov	di, 76h	;@06091
	call COPY_NAME	;@06094
	push	bx	;@06097
	mov	ds, word ptr cs:DATA_SEGMENT	;@06098
	push	ds	;@0609D
	mov	ax, 76h	;@0609E
	push	ax	;@060A1
	push	cs	;@060A2
	mov	ax, 5786h	;@060A3
	push	ax	;@060A6
	call	far ptr STRING_APPEND	;@060A7
	pop	bx	;@060AC
	push	bx	;@060AD
	push	ss	;@060AE
	lea	ax, [bp-8Eh]	;@060AF
	push	ax	;@060B3
	push	bx	;@060B4
	and	bx, 3	;@060B5
	shl	bx, 1	;@060B8
	shl	bx, 1	;@060BA
	shl	bx, 1	;@060BC
	mov	es, word ptr [bx+736h]	;@060BE
	pop	bx	;@060C2
	mov	si, word ptr es:[bx]	;@060C3
	push	si	;@060C6
	and	si, 3	;@060C7
	shl	si, 1	;@060CA
	shl	si, 1	;@060CC
	shl	si, 1	;@060CE
	mov	es, word ptr [si+716h]	;@060D0
	pop	si	;@060D4
	inc	si	;@060D5
	inc	si	;@060D6
	push	es	;@060D7
	push	si	;@060D8
	call	L095A3	;@060D9
	push	ds	;@060DC
	mov	ax, 76h	;@060DD
	push	ax	;@060E0
	push	ss	;@060E1
	lea	ax, [bp-8Eh]	;@060E2
	push	ax	;@060E6
	call	far ptr STRING_APPEND	;@060E7
	push	ds	;@060EC
	mov	ax, 76h	;@060ED
	push	ax	;@060F0
	push	ds	;@060F1
	mov	ax, 26h	;@060F2
	push	ax	;@060F5
	mov	cx, 8	;@060F6
	push	cx	;@060F9
	mov	ax, 33h	;@060FA
	push	ax	;@060FD
	call WARNING	;@060FE
	pop	bx	;@06101
	pop	di	;@06102
	pop	di	;@06103
	pop	si	;@06104
	pop	dx	;@06105
	pop	cx	;@06106
	pop	bx	;@06107
	pop	ax	;@06108
	ret	;@06109
L0610A:	push	bp	;@0610A
	mov	bp, sp	;@0610B
	sub	sp, 0Ah	;@0610D
	mov	word ptr [bp-0Ah], 0FFFFh	;@06110
	push	ax	;@06115
	push	bx	;@06116
	push	cx	;@06117
	push	dx	;@06118
	push	si	;@06119
	push	di	;@0611A
	call	L05E38	;@0611B
	mov	si, di	;@0611E
	push	si	;@06120
	and	si, 3	;@06121
	shl	si, 1	;@06124
	shl	si, 1	;@06126
	shl	si, 1	;@06128
	mov	es, word ptr [si+756h]	;@0612A
	pop	si	;@0612E
	mov	ax, word ptr es:[si+2]	;@0612F
	mov	word ptr [bp-2], ax	;@06133
	cmp	ax, 0FFFFh	;@06136
	jne	@@1	;@06139
	jmp	@@12	;@0613B
@@1:	mov	ax, word ptr es:[si+4]	;@0613E
	mov	word ptr [bp-4], ax	;@06142
	mov	ax, word ptr es:[si+6]	;@06145
	mov	word ptr [bp-6], ax	;@06149
	mov	di, word ptr es:[si]	;@0614C
	mov	word ptr [bp-8], di	;@0614F
	cmp	di, -2	;@06152
	jae	@@2	;@06155
	jmp	@@10	;@06157
@@2:	jne	@@8	;@0615A
	mov	dx, word ptr [bp-6]	;@0615C
	mov	ax, word ptr [bp-4]	;@0615F
	mov	cx, 60h	;@06162
	jmp	short @@5	;@06165
@@3:	cmp	dx, 1	;@06167
	jb	@@7	;@0616A
	ja	@@4	;@0616C
	cmp	ax, 0	;@0616E
	je	@@7	;@06171
@@4:	push	dx	;@06173
	push	ax	;@06174
	mov	dx, 1	;@06175
	xor	ax, ax	;@06178
	call	@@14	;@0617A
	mov	cx, 20h	;@0617D
	pop	ax	;@06180
	pop	dx	;@06181
	sub	ax, 0	;@06182
	sbb	dx, 1	;@06185
	jmp	short @@5	;@06188
@@5:	cmp	dx, 0	;@0618A
	ja	@@3	;@0618D
	cmp	ax, 0	;@0618F
	jne	@@3	;@06192
@@6:	xor	ax, ax	;@06194
	push	si	;@06196
	and	si, 3	;@06197
	shl	si, 1	;@0619A
	shl	si, 1	;@0619C
	shl	si, 1	;@0619E
	mov	es, word ptr [si+756h]	;@061A0
	pop	si	;@061A4
	mov	word ptr es:[si+6], ax	;@061A5
	mov	word ptr es:[si+4], ax	;@061A9
	mov	ax, word ptr [bp-0Ah]	;@061AD
	mov	word ptr es:[si], ax	;@061B0
	and	byte ptr es:[si+0Eh], 0F7h	;@061B3
	jmp	@@12	;@061B8
@@7:	call	@@14	;@061BB
	jmp	@@6	;@061BE
@@8:	mov	di, word ptr ds:[43Eh]	;@061C0
	cmp	di, -1	;@061C4
	jne	@@10	;@061C7
	call	L05C16	;@061C9
	mov	word ptr ds:[43Eh], di	;@061CC
	mov	ax, word ptr ds:[42Ah]	;@061D0
	mov	word ptr es:[di], ax	;@061D3
	mov	es, word ptr ds:[77Eh]	;@061D6
	mov	ax, word ptr ds:[424h]	;@061DA
	mov	word ptr es:[di], ax	;@061DD
	mov	dx, word ptr ds:[426h]	;@061E0
	mov	al, 48h	;@061E4
	mov	es, word ptr ds:[776h]	;@061E6
	mov	byte ptr es:[di+9], al	;@061EA
	mov	word ptr es:[di+2], dx	;@061EE
	mov	ax, word ptr [bp-2]	;@061F2
	mov	word ptr es:[di+4], ax	;@061F5
	xchg	ax, di	;@061F9
	push	ax	;@061FA
	mov	di, 2	;@061FB
	push	di	;@061FE
	mov	di, 7BAh	;@061FF
	call	L054ED	;@06202
	jae	@@9	;@06205
	call	TABLE_OVERFLOW	;@06207
@@9:	pop	ax	;@0620A
	mov	word ptr es:[di], ax	;@0620B
	xchg	ax, di	;@0620E
@@10:	mov	es, word ptr ds:[776h]	;@0620F
	mov	ax, word ptr es:[di+6]	;@06213
	push	ax	;@06217
	add	ax, word ptr [bp-4]	;@06218
	mov	word ptr es:[di+6], ax	;@0621B
	mov	al, byte ptr es:[di+8]	;@0621F
	mov	ah, 0	;@06223
	push	ax	;@06225
	adc	ax, word ptr [bp-6]	;@06226
	mov	byte ptr es:[di+8], al	;@06229
	cmp	byte ptr ds:[125h], 0	;@0622D
	jne	@@11	;@06232
	cmp	ax, 0	;@06234
	jne	@@13	;@06237
@@11:	push	si	;@06239
	and	si, 3	;@0623A
	shl	si, 1	;@0623D
	shl	si, 1	;@0623F
	shl	si, 1	;@06241
	mov	es, word ptr [si+756h]	;@06243
	pop	si	;@06247
	pop	word ptr es:[si+6]	;@06248
	pop	word ptr es:[si+4]	;@0624C
	mov	word ptr es:[si], di	;@06250
	and	byte ptr es:[si+0Eh], 0F7h	;@06253
@@12:	pop	di	;@06258
	pop	si	;@06259
	pop	dx	;@0625A
	pop	cx	;@0625B
	pop	bx	;@0625C
	pop	ax	;@0625D
	mov	sp, bp	;@0625E
	pop	bp	;@06260
	ret	;@06261
@@13:	cmp	word ptr [bp-8], -1	;@06262
	jne	@@11	;@06266
	cmp	word ptr ds:[0C3Fh], -1	;@06268
	jne	@@11	;@0626D
	mov	word ptr ds:[0C3Fh], 1	;@0626F
	push	ax	;@06275
	push	bx	;@06276
	push	cx	;@06277
	push	dx	;@06278
	push	si	;@06279
	push	di	;@0627A
	xor	ax, ax	;@0627B
	push	ax	;@0627D
	mov	ax, 2Ah	;@0627E
	push	ax	;@06281
	call ERROR	;@06282
	pop	di	;@06285
	pop	si	;@06286
	pop	dx	;@06287
	pop	cx	;@06288
	pop	bx	;@06289
	pop	ax	;@0628A
	jmp	@@11	;@0628B
@@14:	push	cx	;@0628D
	push	dx	;@0628E
	push	ax	;@0628F
	push	cx	;@06290
	mov	ax, word ptr ds:[43Ch]	;@06291
	inc	ax	;@06294
	mov	word ptr ds:[43Ch], ax	;@06295
	mov	dl, 1Ah	;@06298
	div	dl	;@0629A
	add	ax, 4141h	;@0629C
	push	si	;@0629F
	mov	si, 440h	;@062A0
	mov	byte ptr [si], 0Bh	;@062A3
	mov	word ptr [si+1], 435Fh	;@062A6
	mov	word ptr [si+3], 4D4Fh	;@062AB
	mov	word ptr [si+5], 4544h	;@062B0
	mov	word ptr [si+7], 5F46h	;@062B5
	mov	word ptr [si+9], ax	;@062BA
	mov	byte ptr [si+0Bh], 5Fh	;@062BD
	mov	ah, 80h	;@062C1
	mov	word ptr ds:[3450h], ds	;@062C3
	call	L0910F	;@062C7
	push	bx	;@062CA
	call	L05C16	;@062CB
	pop	bx	;@062CE
	mov	word ptr es:[di], bx	;@062CF
	mov	ax, word ptr ds:[3D8h]	;@062D2
	inc	ax	;@062D5
	mov	word ptr ds:[3D8h], ax	;@062D6
	push	bx	;@062D9
	and	bx, 3	;@062DA
	shl	bx, 1	;@062DD
	shl	bx, 1	;@062DF
	shl	bx, 1	;@062E1
	mov	es, word ptr [bx+716h]	;@062E3
	pop	bx	;@062E7
	mov	word ptr es:[bx], ax	;@062E8
	mov	es, word ptr ds:[77Eh]	;@062EB
	mov	word ptr es:[di], 0FFFFh	;@062EF
	pop	si	;@062F4
	mov	es, word ptr ds:[776h]	;@062F5
	pop	cx	;@062F9
	mov	byte ptr es:[di+9], cl	;@062FA
	mov	dx, word ptr ds:[428h]	;@062FE
	mov	word ptr es:[di+2], dx	;@06302
	mov	ax, word ptr [bp-2]	;@06306
	mov	word ptr es:[di+4], ax	;@06309
	xchg	ax, di	;@0630D
	push	ax	;@0630E
	mov	di, 2	;@0630F
	push	di	;@06312
	mov	di, 7BAh	;@06313
	call	L054ED	;@06316
	jae	@@15	;@06319
	call	TABLE_OVERFLOW	;@0631B
@@15:	pop	ax	;@0631E
	mov	word ptr es:[di], ax	;@0631F
	xchg	ax, di	;@06322
	pop	ax	;@06323
	pop	dx	;@06324
	mov	es, word ptr ds:[776h]	;@06325
	mov	word ptr es:[di+6], ax	;@06329
	mov	byte ptr es:[di+8], dl	;@0632D
	cmp	word ptr [bp-0Ah], -1	;@06331
	jne	@@16	;@06335
	mov	word ptr [bp-0Ah], di	;@06337
@@16:	pop	cx	;@0633A
	ret	;@0633B
L0633C:	push	ax	;@0633C
	push	bx	;@0633D
	push	cx	;@0633E
	push	dx	;@0633F
	push	si	;@06340
	push	di	;@06341
	xor	di, di	;@06342
	push	di	;@06344
	mov	bx, 752h	;@06345
@@1:	push	di	;@06348
	and	di, 3	;@06349
	shl	di, 1	;@0634C
	shl	di, 1	;@0634E
	shl	di, 1	;@06350
	mov	es, word ptr [di+756h]	;@06352
	pop	di	;@06356
	jmp	short @@5	;@06357
@@2:	test	byte ptr es:[di+0Eh], 14h	;@06359
	jne	@@4	;@0635E
	test	byte ptr es:[di+0Eh], 8	;@06360
	je	@@4	;@06365
	push	bx	;@06367
	mov	bx, word ptr es:[di+2]	;@06368
	push	bx	;@0636C
	and	bx, 3	;@0636D
	shl	bx, 1	;@06370
	shl	bx, 1	;@06372
	shl	bx, 1	;@06374
	mov	es, word ptr [bx+736h]	;@06376
	pop	bx	;@0637A
	mov	ax, word ptr es:[bx+0Ah]	;@0637B
	pop	bx	;@0637F
	push	di	;@06380
	and	di, 3	;@06381
	shl	di, 1	;@06384
	shl	di, 1	;@06386
	shl	di, 1	;@06388
	mov	es, word ptr [di+756h]	;@0638A
	pop	di	;@0638E
	cmp	ax, 2	;@0638F
	jae	@@3	;@06392
	cmp	byte ptr es:[di+0Eh], 1	;@06394
	je	@@4	;@06399
@@3:	call	L0610A	;@0639B
@@4:	add	di, word ptr ds:[48Eh]	;@0639E
@@5:	cmp	di, word ptr [bx+2]	;@063A2
	jb	@@2	;@063A5
	cmp	bx, 762h	;@063A7
	ja	@@6	;@063AB
	add	bx, 8	;@063AD
	pop	di	;@063B0
	inc	di	;@063B1
	push	di	;@063B2
	jmp	@@1	;@063B3
@@6:	pop	ax	;@063B5
	mov	word ptr ds:[7A4h], 0	;@063B6
	mov	di, 7A2h	;@063BC
	call	L05725	;@063BF
	pop	di	;@063C2
	pop	si	;@063C3
	pop	dx	;@063C4
	pop	cx	;@063C5
	pop	bx	;@063C6
	pop	ax	;@063C7
	ret	;@063C8
L063C9:	push	si	;@063C9
	and	si, 3	;@063CA
	shl	si, 1	;@063CD
	shl	si, 1	;@063CF
	shl	si, 1	;@063D1
	mov	es, word ptr [si+736h]	;@063D3
	pop	si	;@063D7
	cmp	word ptr es:[si+0Ah], 2	;@063D8
	jb	@@1	;@063DD
	ret	;@063DF
@@1:	push	bp	;@063E0
	mov	bp, sp	;@063E1
	sub	sp, 2	;@063E3
	push	bx	;@063E6
	push	cx	;@063E7
	push	di	;@063E8
	mov	di, si	;@063E9
	and	di, 3	;@063EB
	shl	di, 1	;@063EE
	shl	di, 1	;@063F0
	shl	di, 1	;@063F2
	lea	di, [di+732h]	;@063F4
	mov	word ptr es:[si+0Ah], 2	;@063F8
	push	si	;@063FE
	add	ax, word ptr es:[si+0Eh]	;@063FF
	cmp	si, word ptr ds:[186h]	;@06403
	jne	@@2	;@06407
	mov	cx, word ptr ds:[188h]	;@06409
	add	cx, 2	;@0640D
	mov	word ptr [bp-2], 0FFFFh	;@06410
	jmp	short @@3	;@06415
@@2:	mov	bl, byte ptr es:[si+10h]	;@06417
	mov	bh, 0	;@0641B
	mov	bx, word ptr cs:L05780[bx]	;@0641D
	push	si	;@06422
	add	si, bx	;@06423
	mov	word ptr [bp-2], si	;@06425
	cmp	si, word ptr [di+2]	;@06428
	pop	si	;@0642B
	jae	@@6	;@0642C
	mov	cx, word ptr es:[bx+si+4]	;@0642E
@@3:	mov	bx, word ptr es:[si+4]	;@06432
@@4:	cmp	bx, cx	;@06436
	jb	@@5	;@06438
	jmp	@@9	;@0643A
@@5:	mov	es, word ptr ds:[786h]	;@0643D
	mov	si, word ptr es:[bx]	;@06441
	push	si	;@06444
	and	si, 3	;@06445
	shl	si, 1	;@06448
	shl	si, 1	;@0644A
	shl	si, 1	;@0644C
	mov	es, word ptr [si+756h]	;@0644E
	pop	si	;@06452
	or	byte ptr es:[si+0Eh], 1	;@06453
	test	byte ptr es:[si+0Eh], 18h	;@06458
	jne	@@8	;@0645D
	cmp	byte ptr ds:[17h], 0	;@0645F
	je	@@7	;@06464
	test	byte ptr es:[si+0Eh], 20h	;@06466
	je	@@7	;@0646B
	mov	si, word ptr es:[si+2]	;@0646D
	mov	es, word ptr ds:[806h]	;@06471
	mov	word ptr es:[si+6], 0FFFFh	;@06475
	jmp	short @@8	;@0647B
@@6:	mov	bx, word ptr es:[si+4]	;@0647D
	add	di, 8	;@06481
	push	si	;@06484
	and	si, 3	;@06485
	inc	si	;@06488
	push	si	;@06489
	and	si, 3	;@0648A
	shl	si, 1	;@0648D
	shl	si, 1	;@0648F
	shl	si, 1	;@06491
	mov	es, word ptr [si+736h]	;@06493
	pop	si	;@06497
	mov	cx, word ptr es:[si+4]	;@06498
	mov	word ptr [bp-2], si	;@0649C
	pop	si	;@0649F
	push	si	;@064A0
	and	si, 3	;@064A1
	shl	si, 1	;@064A4
	shl	si, 1	;@064A6
	shl	si, 1	;@064A8
	mov	es, word ptr [si+736h]	;@064AA
	pop	si	;@064AE
	jmp	@@4	;@064AF
@@7:	mov	si, word ptr es:[si+2]	;@064B1
	call	L063C9	;@064B5
@@8:	add	bx, 2	;@064B8
	jmp	@@4	;@064BB
@@9:	pop	si	;@064BE
	push	si	;@064BF
	and	si, 3	;@064C0
	shl	si, 1	;@064C3
	shl	si, 1	;@064C5
	shl	si, 1	;@064C7
	mov	es, word ptr [si+736h]	;@064C9
	pop	si	;@064CD
	inc	dx	;@064CE
	mov	word ptr es:[si+0Ah], dx	;@064CF
	mov	bx, word ptr es:[si+2]	;@064D3
	push	si	;@064D7
	mov	si, word ptr [bp-2]	;@064D8
	cmp	si, -1	;@064DB
	jne	@@10	;@064DE
	mov	cx, word ptr ds:[0C49h]	;@064E0
	add	cx, 0Ah	;@064E4
	jmp	short @@11	;@064E7
@@10:	push	si	;@064E9
	and	si, 3	;@064EA
	shl	si, 1	;@064ED
	shl	si, 1	;@064EF
	shl	si, 1	;@064F1
	mov	es, word ptr [si+736h]	;@064F3
	pop	si	;@064F7
	mov	cx, word ptr es:[si+2]	;@064F8
@@11:	pop	si	;@064FC
@@12:	cmp	bx, cx	;@064FD
	jae	@@16	;@064FF
	mov	es, word ptr ds:[776h]	;@06501
	push	ax	;@06505
	mov	ax, word ptr es:[bx+2]	;@06506
	cmp	ax, word ptr ds:[432h]	;@0650A
	je	@@15	;@0650E
	cmp	ax, word ptr ds:[434h]	;@06510
	je	@@15	;@06514
	pop	ax	;@06516
	mov	di, 2	;@06517
	push	di	;@0651A
	mov	di, 7BAh	;@0651B
	call	L054ED	;@0651E
	jae	@@13	;@06521
	call	TABLE_OVERFLOW	;@06523
@@13:	mov	word ptr es:[di], bx	;@06526
@@14:	add	bx, 0Ah	;@06529
	jmp	@@12	;@0652C
@@15:	pop	ax	;@0652E
	mov	byte ptr es:[bx+9], 0FFh	;@0652F
	jmp	@@14	;@06534
@@16:	pop	di	;@06536
	pop	cx	;@06537
	pop	bx	;@06538
	mov	sp, bp	;@06539
	pop	bp	;@0653B
	ret	;@0653C
L0653D:	xor	ax, ax	;@0653D
	mov	dx, 2	;@0653F
	mov	si, word ptr ds:[3F6h]	;@06542
	cmp	si, -1	;@06546
	je	@@2	;@06549
	cmp	byte ptr ds:[17h], 1	;@0654B
	jne	@@1	;@06550
	push	si	;@06552
	and	si, 3	;@06553
	shl	si, 1	;@06556
	shl	si, 1	;@06558
	shl	si, 1	;@0655A
	mov	es, word ptr [si+736h]	;@0655C
	pop	si	;@06560
	cmp	word ptr es:[si+0Ah], 1	;@06561
	je	@@2	;@06566
@@1:	call	L063C9	;@06568
@@2:	push	di	;@0656B
	xor	si, si	;@0656C
	push	si	;@0656E
	mov	di, 732h	;@0656F
	push	si	;@06572
	and	si, 3	;@06573
	shl	si, 1	;@06576
	shl	si, 1	;@06578
	shl	si, 1	;@0657A
	mov	es, word ptr [si+736h]	;@0657C
	pop	si	;@06580
@@3:	cmp	word ptr es:[si+0Ah], 0	;@06581
	jne	@@4	;@06586
	call	L063C9	;@06588
@@4:	cmp	si, word ptr ds:[184h]	;@0658B
	je	@@7	;@0658F
	push	si	;@06591
	and	si, 3	;@06592
	shl	si, 1	;@06595
	shl	si, 1	;@06597
	shl	si, 1	;@06599
	mov	es, word ptr [si+736h]	;@0659B
	pop	si	;@0659F
	mov	bl, byte ptr es:[si+10h]	;@065A0
	mov	bh, 0	;@065A4
	add	si, word ptr cs:L05780[bx]	;@065A6
	cmp	si, word ptr [di+2]	;@065AB
	jae	@@5	;@065AE
	push	si	;@065B0
	add	si, 38h	;@065B1
	cmp	si, -80h	;@065B4
	pop	si	;@065B7
	jb	@@3	;@065B8
@@5:	cmp	di, 742h	;@065BA
	jbe	@@6	;@065BE
	jmp	short @@7	;@065C0
@@6:	add	di, 8	;@065C2
	and	si, 3	;@065C5
	inc	si	;@065C8
	push	si	;@065C9
	and	si, 3	;@065CA
	shl	si, 1	;@065CD
	shl	si, 1	;@065CF
	shl	si, 1	;@065D1
	mov	es, word ptr [si+736h]	;@065D3
	pop	si	;@065D7
	jmp	@@3	;@065D8
@@7:	add	sp, 2	;@065DA
	pop	di	;@065DD
	mov	word ptr ds:[3DAh], dx	;@065DE
	mov	word ptr ds:[4A0h], ax	;@065E2
	call	L0633C	;@065E5
	ret	;@065E8
L065E9:	mov	si, 584Eh	;@065E9
	mov	ah, 0	;@065EC
	mov	word ptr ds:[3450h], cs	;@065EE
	call	L0921C	;@065F2
	jb	@@1	;@065F5
	push	bx	;@065F7
	and	bx, 3	;@065F8
	shl	bx, 1	;@065FB
	shl	bx, 1	;@065FD
	shl	bx, 1	;@065FF
	mov	es, word ptr [bx+756h]	;@06601
	pop	bx	;@06605
	test	byte ptr es:[bx+0Eh], 18h	;@06606
	jne	@@1	;@0660B
	mov	bx, word ptr es:[bx+2]	;@0660D
	push	bx	;@06611
	and	bx, 3	;@06612
	shl	bx, 1	;@06615
	shl	bx, 1	;@06617
	shl	bx, 1	;@06619
	mov	es, word ptr [bx+736h]	;@0661B
	pop	bx	;@0661F
	cmp	word ptr es:[bx+0Ah], 2	;@06620
	jae	@@1	;@06625
	mov	dx, word ptr ds:[3DAh]	;@06627
	mov	si, bx	;@0662B
	xor	ax, ax	;@0662D
	call	L063C9	;@0662F
	mov	word ptr ds:[3DAh], dx	;@06632
	add	word ptr ds:[4A0h], ax	;@06636
@@1:	ret	;@0663A
L0663B:	push	bx	;@0663B
	push	ax	;@0663C
	mov	es, word ptr ds:[776h]	;@0663D
	test	byte ptr es:[si+9], 0E0h	;@06641
	je	@@1	;@06646
	test	byte ptr es:[di+9], 0E0h	;@06648
	je	@@2	;@0664D
	mov	bx, word ptr es:[di+2]	;@0664F
	mov	ax, word ptr es:[si+2]	;@06653
	cmp	ax, bx	;@06657
	je	@@3	;@06659
	cmp	ax, 0FFFFh	;@0665B
	je	@@1	;@0665E
	cmp	bx, -1	;@06660
	je	@@2	;@06663
	cmp	byte ptr ds:[486h], 0	;@06665
	je	@@7	;@0666A
	cmp	ax, word ptr ds:[44Eh]	;@0666C
	je	@@2	;@06670
	cmp	bx, word ptr ds:[44Eh]	;@06672
	je	@@1	;@06676
	cmp	ax, word ptr ds:[450h]	;@06678
	je	@@2	;@0667C
	cmp	bx, word ptr ds:[450h]	;@0667E
	jne	@@7	;@06682
@@1:	stc	;@06684
	jmp	short @@6	;@06685
@@2:	clc	;@06687
	jmp	short @@6	;@06688
@@3:	mov	ax, word ptr es:[si]	;@0668A
	cmp	ax, word ptr es:[di]	;@0668D
	je	@@4	;@06690
	push	ax	;@06692
	mov	bx, word ptr es:[di]	;@06693
	push	bx	;@06696
	and	bx, 3	;@06697
	shl	bx, 1	;@0669A
	shl	bx, 1	;@0669C
	shl	bx, 1	;@0669E
	mov	es, word ptr [bx+716h]	;@066A0
	pop	bx	;@066A4
	mov	ax, word ptr es:[bx]	;@066A5
	pop	bx	;@066A8
	push	bx	;@066A9
	and	bx, 3	;@066AA
	shl	bx, 1	;@066AD
	shl	bx, 1	;@066AF
	shl	bx, 1	;@066B1
	mov	es, word ptr [bx+716h]	;@066B3
	pop	bx	;@066B7
	cmp	word ptr es:[bx], ax	;@066B8
	jmp	short @@6	;@066BB
@@4:	cmp	byte ptr ds:[3D7h], 1	;@066BD
	jne	@@5	;@066C2
	mov	ax, word ptr ds:[43Ah]	;@066C4
	cmp	si, ax	;@066C7
	je	@@1	;@066C9
	cmp	di, ax	;@066CB
	je	@@2	;@066CD
@@5:	cmp	si, di	;@066CF
@@6:	lahf	;@066D1
	mov	es, word ptr ds:[7BEh]	;@066D2
	sahf	;@066D6
	pop	ax	;@066D7
	pop	bx	;@066D8
	ret	;@066D9
@@7:	cmp	byte ptr ds:[3D7h], 1	;@066DA
	je	@@9	;@066DF
@@8:	push	word ptr es:[si+2]	;@066E1
	mov	bx, word ptr es:[di+2]	;@066E5
	push	bx	;@066E9
	and	bx, 3	;@066EA
	shl	bx, 1	;@066ED
	shl	bx, 1	;@066EF
	shl	bx, 1	;@066F1
	mov	es, word ptr [bx+716h]	;@066F3
	pop	bx	;@066F7
	mov	ax, word ptr es:[bx]	;@066F8
	pop	bx	;@066FB
	push	bx	;@066FC
	and	bx, 3	;@066FD
	shl	bx, 1	;@06700
	shl	bx, 1	;@06702
	shl	bx, 1	;@06704
	mov	es, word ptr [bx+716h]	;@06706
	pop	bx	;@0670A
	cmp	word ptr es:[bx], ax	;@0670B
	jmp	@@6	;@0670E
@@9:	push	si	;@06710
	push	di	;@06711
	push	cx	;@06712
	push	si	;@06713
	push	di	;@06714
	mov	si, word ptr es:[si+2]	;@06715
	mov	di, word ptr es:[di+2]	;@06719
	push	si	;@0671D
	and	si, 3	;@0671E
	shl	si, 1	;@06721
	shl	si, 1	;@06723
	shl	si, 1	;@06725
	mov	es, word ptr [si+716h]	;@06727
	pop	si	;@0672B
	xor	cx, cx	;@0672C
	mov	al, byte ptr es:[si+2]	;@0672E
	and	ax, 3Fh	;@06732
	cmp	ax, 4	;@06735
	jb	@@10	;@06738
	add	si, ax	;@0673A
	cmp	word ptr es:[si-1], 4F43h	;@0673C
	jne	@@10	;@06742
	cmp	word ptr es:[si+1], 4544h	;@06744
	jne	@@10	;@0674A
	inc	cl	;@0674C
@@10:	push	di	;@0674E
	and	di, 3	;@0674F
	shl	di, 1	;@06752
	shl	di, 1	;@06754
	shl	di, 1	;@06756
	mov	es, word ptr [di+716h]	;@06758
	pop	di	;@0675C
	mov	al, byte ptr es:[di+2]	;@0675D
	and	ax, 3Fh	;@06761
	cmp	ax, 4	;@06764
	jb	@@11	;@06767
	add	di, ax	;@06769
	cmp	word ptr es:[di-1], 4F43h	;@0676B
	jne	@@11	;@06771
	cmp	word ptr es:[di+1], 4544h	;@06773
	jne	@@11	;@06779
	inc	ch	;@0677B
@@11:	pop	di	;@0677D
	pop	si	;@0677E
	mov	es, word ptr ds:[776h]	;@0677F
	cmp	ch, cl	;@06783
	je	@@12	;@06785
	jmp	@@27	;@06787
@@12:	and	cx, cx	;@0678A
	jne	@@19	;@0678C
	mov	ax, word ptr ds:[42Ch]	;@0678E
	cmp	ax, word ptr es:[si+2]	;@06791
	jne	@@13	;@06795
	inc	cl	;@06797
@@13:	cmp	ax, word ptr es:[di+2]	;@06799
	jne	@@14	;@0679D
	inc	ch	;@0679F
@@14:	cmp	cl, ch	;@067A1
	je	@@15	;@067A3
	jmp	@@27	;@067A5
@@15:	and	cx, cx	;@067A8
	je	@@16	;@067AA
	jmp	@@28	;@067AC
@@16:	xor	cx, cx	;@067AF
	mov	ax, word ptr ds:[424h]	;@067B1
	mov	es, word ptr ds:[77Eh]	;@067B4
	cmp	ax, word ptr es:[si]	;@067B8
	jne	@@17	;@067BB
	inc	cl	;@067BD
@@17:	cmp	ax, word ptr es:[di]	;@067BF
	jne	@@18	;@067C2
	inc	ch	;@067C4
@@18:	cmp	cl, ch	;@067C6
	jne	@@27	;@067C8
	and	cx, cx	;@067CA
	jne	@@22	;@067CC
	pop	cx	;@067CE
	pop	di	;@067CF
	pop	si	;@067D0
	mov	es, word ptr ds:[776h]	;@067D1
	jmp	@@8	;@067D5
@@19:	xor	cx, cx	;@067D8
	mov	ax, word ptr ds:[430h]	;@067DA
	mov	es, word ptr ds:[776h]	;@067DD
	cmp	ax, word ptr es:[si+2]	;@067E1
	jne	@@20	;@067E5
	inc	cl	;@067E7
@@20:	cmp	ax, word ptr es:[di+2]	;@067E9
	jne	@@21	;@067ED
	inc	ch	;@067EF
@@21:	cmp	cl, ch	;@067F1
	jne	@@27	;@067F3
	jmp	short @@28	;@067F5
@@22:	xor	cx, cx	;@067F7
	mov	ax, word ptr ds:[42Eh]	;@067F9
	mov	es, word ptr ds:[776h]	;@067FC
	cmp	ax, word ptr es:[si+2]	;@06800
	jne	@@23	;@06804
	inc	cl	;@06806
@@23:	cmp	ax, word ptr es:[di+2]	;@06808
	jne	@@24	;@0680C
	inc	ch	;@0680E
@@24:	cmp	ch, cl	;@06810
	jne	@@27	;@06812
	and	cx, cx	;@06814
	jne	@@28	;@06816
	xor	cx, cx	;@06818
	mov	ax, word ptr ds:[426h]	;@0681A
	cmp	ax, word ptr es:[si+2]	;@0681D
	jne	@@25	;@06821
	inc	cl	;@06823
@@25:	cmp	ax, word ptr es:[di+2]	;@06825
	jne	@@26	;@06829
	inc	ch	;@0682B
@@26:	cmp	cl, ch	;@0682D
	jne	@@27	;@0682F
	and	cx, cx	;@06831
	jne	@@28	;@06833
	pop	cx	;@06835
	pop	di	;@06836
	pop	si	;@06837
	jmp	@@8	;@06838
	db	3Ah, 0CDh	;@0683B
@@27:	pop	cx	;@0683D
	pop	di	;@0683E
	pop	si	;@0683F
	jmp	@@6	;@06840
@@28:	xor	al, al	;@06843
	jmp	@@27	;@06845
L06847:	push	ax	;@06847
	push	cx	;@06848
	push	si	;@06849
	mov	ax, word ptr es:[bx+4]	;@0684A
	mov	si, word ptr es:[di+4]	;@0684E
	mov	word ptr es:[di+4], bx	;@06852
	mov	es, word ptr ds:[776h]	;@06856
	mov	cx, word ptr es:[bx+6]	;@0685A
@@1:	cmp	si, -1	;@0685E
	je	@@2	;@06861
	push	si	;@06863
	and	si, 3	;@06864
	shl	si, 1	;@06867
	shl	si, 1	;@06869
	shl	si, 1	;@0686B
	mov	es, word ptr [si+756h]	;@0686D
	pop	si	;@06871
	push	word ptr es:[si+0Ah]	;@06872
	mov	word ptr es:[si+8], cx	;@06876
	mov	word ptr es:[si+0Ah], ax	;@0687A
	mov	ax, si	;@0687E
	add	cx, 5	;@06880
	pop	si	;@06883
	jmp	@@1	;@06884
@@2:	mov	es, word ptr ds:[77Eh]	;@06886
	mov	word ptr es:[bx+4], ax	;@0688A
	mov	es, word ptr ds:[776h]	;@0688E
	mov	word ptr es:[bx+6], cx	;@06892
	pop	si	;@06896
	pop	cx	;@06897
	pop	ax	;@06898
	ret	;@06899
L0689A:	push	bp	;@0689A
	mov	bp, sp	;@0689B
	lea	sp, [bp-6]	;@0689D
	push	si	;@068A0
	push	di	;@068A1
	xor	si, si	;@068A2
	mov	ax, word ptr ds:[774h]	;@068A4
	mov	word ptr [bp-2], ax	;@068A7
	mov	es, word ptr ds:[77Eh]	;@068AA
	jmp	short @@3	;@068AE
@@1:	jmp	@@7	;@068B0
@@2:	add	si, 0Ah	;@068B3
@@3:	cmp	si, word ptr [bp-2]	;@068B6
	jae	@@1	;@068B9
	cmp	word ptr es:[si+2], -1	;@068BB
	je	@@2	;@068C0
	mov	dx, word ptr es:[si]	;@068C2
	mov	es, word ptr ds:[776h]	;@068C5
	call	L09591	;@068C9
	mov	byte ptr [bp-4], al	;@068CC
	mov	di, si	;@068CF
	cmp	al, 3	;@068D1
	jl	@@5	;@068D3
	call	L05C16	;@068D5
	mov	byte ptr es:[di+9], 60h	;@068D8
	mov	cx, word ptr es:[si]	;@068DD
	mov	word ptr es:[di], cx	;@068E0
	mov	cx, word ptr es:[si+4]	;@068E3
	mov	word ptr es:[di+4], cx	;@068E7
	mov	cx, word ptr ds:[452h]	;@068EB
	mov	word ptr es:[di+2], cx	;@068EF
	mov	word ptr es:[di+6], 20h	;@068F3
	mov	bx, di	;@068F9
	mov	di, 2	;@068FB
	push	di	;@068FE
	mov	di, 7BAh	;@068FF
	call	L054ED	;@06902
	jae	@@4	;@06905
	call	TABLE_OVERFLOW	;@06907
@@4:	mov	word ptr es:[di], bx	;@0690A
	mov	es, word ptr ds:[77Eh]	;@0690D
	mov	di, si	;@06911
	jmp	short @@6	;@06913
@@5:	mov	ax, 0FFFFh	;@06915
	mov	es, word ptr ds:[77Eh]	;@06918
	xchg	word ptr es:[di+2], ax	;@0691C
	cmp	ax, 0FFFEh	;@06920
	je	@@2	;@06923
	xchg	ax, di	;@06925
	mov	word ptr es:[di], dx	;@06926
	cmp	byte ptr [bp-4], 3	;@06929
	jne	@@5	;@0692D
@@6:	call	L06847	;@0692F
	jmp	@@5	;@06932
@@7:	pop	di	;@06934
	pop	si	;@06935
	mov	sp, bp	;@06936
	pop	bp	;@06938
	ret	;@06939
L0693A:	push	cx	;@0693A
	push	dx	;@0693B
	mov	es, word ptr ds:[77Eh]	;@0693C
	mov	cx, word ptr es:[si]	;@06940
	jmp	short @@2	;@06943
@@1:	mov	es, word ptr ds:[77Eh]	;@06945
	add	bx, 0Ah	;@06949
@@2:	cmp	bx, si	;@0694C
	jae	@@6	;@0694E
	cmp	cx, word ptr es:[bx]	;@06950
	jne	@@3	;@06953
	cmp	cx, -1	;@06955
	jne	@@4	;@06958
@@3:	mov	es, word ptr ds:[776h]	;@0695A
	cmp	ax, word ptr es:[bx]	;@0695E
	jne	@@1	;@06961
	mov	dx, word ptr es:[si+2]	;@06963
	cmp	dx, word ptr es:[bx+2]	;@06967
	jne	@@1	;@0696B
@@4:	mov	es, word ptr ds:[776h]	;@0696D
	mov	dh, byte ptr es:[bx+9]	;@06971
	cmp	dh, 0FFh	;@06975
	je	@@1	;@06978
	test	dh, 1Ch	;@0697A
	je	@@1	;@0697D
	test	dh, 2	;@0697F
	jne	@@1	;@06982
@@5:	pop	dx	;@06984
	pop	cx	;@06985
	ret	;@06986
@@6:	cmp	cx, -1	;@06987
	jne	@@5	;@0698A
@@7:	add	bx, 0Ah	;@0698C
	cmp	bx, word ptr ds:[774h]	;@0698F
	jae	@@5	;@06993
	mov	es, word ptr ds:[77Eh]	;@06995
	cmp	cx, word ptr es:[bx]	;@06999
	je	@@7	;@0699C
	mov	es, word ptr ds:[776h]	;@0699E
	cmp	ax, word ptr es:[bx]	;@069A2
	jne	@@7	;@069A5
	mov	dx, word ptr es:[si+2]	;@069A7
	cmp	dx, word ptr es:[bx+2]	;@069AB
	jne	@@7	;@069AF
	mov	dh, byte ptr es:[bx+9]	;@069B1
	cmp	dh, 0FFh	;@069B5
	je	@@7	;@069B8
	test	dh, 1Ch	;@069BA
	je	@@7	;@069BD
	test	dh, 2	;@069BF
	jne	@@7	;@069C2
	mov	es, word ptr ds:[77Eh]	;@069C4
	mov	cx, word ptr es:[bx]	;@069C8
	mov	word ptr es:[si], cx	;@069CB
	jmp	@@5	;@069CE
L069D0:	push	bp	;@069D0
	mov	bp, sp	;@069D1
	push	si	;@069D3
	push	di	;@069D4
	xor	si, si	;@069D5
	jmp	short @@3	;@069D7
@@1:	mov	es, word ptr ds:[776h]	;@069D9
	mov	byte ptr es:[si+9], 0FFh	;@069DD
@@2:	add	si, 0Ah	;@069E2
@@3:	cmp	si, word ptr ds:[774h]	;@069E5
	jae	@@5	;@069E9
	mov	es, word ptr ds:[776h]	;@069EB
	mov	dl, byte ptr es:[si+9]	;@069EF
	cmp	dl, 0FFh	;@069F3
	je	@@2	;@069F6
	mov	bx, word ptr es:[si+4]	;@069F8
	push	bx	;@069FC
	and	bx, 3	;@069FD
	shl	bx, 1	;@06A00
	shl	bx, 1	;@06A02
	shl	bx, 1	;@06A04
	mov	es, word ptr [bx+736h]	;@06A06
	pop	bx	;@06A0A
	mov	ax, word ptr es:[bx+0Ah]	;@06A0B
	cmp	ax, 1	;@06A0F
	je	@@1	;@06A12
	mov	es, word ptr ds:[77Eh]	;@06A14
	mov	word ptr es:[si+2], 0FFFEh	;@06A18
	test	dl, 1Ch	;@06A1E
	je	@@2	;@06A21
	test	dl, 2	;@06A23
	jne	@@2	;@06A26
	mov	es, word ptr ds:[776h]	;@06A28
	mov	ax, word ptr es:[si]	;@06A2C
	xor	bx, bx	;@06A2F
	call	L0693A	;@06A31
	cmp	bx, si	;@06A34
	jae	@@2	;@06A36
	mov	es, word ptr ds:[77Eh]	;@06A38
	mov	ax, word ptr es:[si]	;@06A3C
	cmp	ax, 0FFFFh	;@06A3F
	je	@@4	;@06A42
	cmp	word ptr es:[bx], ax	;@06A44
	je	@@4	;@06A47
	cmp	word ptr es:[bx], -1	;@06A49
	jne	@@6	;@06A4D
	mov	word ptr es:[bx], ax	;@06A4F
@@4:	mov	ax, si	;@06A52
	xchg	word ptr es:[bx+2], ax	;@06A54
	mov	word ptr es:[si+2], ax	;@06A58
	jmp	@@2	;@06A5C
@@5:	call	L0689A	;@06A5E
	pop	di	;@06A61
	pop	si	;@06A62
	mov	sp, bp	;@06A63
	pop	bp	;@06A65
	ret	;@06A66
@@6:	push	bx	;@06A67
	push	si	;@06A68
	push	di	;@06A69
	mov	es, word ptr ds:[776h]	;@06A6A
	push	word ptr es:[si]	;@06A6E
	mov	es, word ptr ds:[77Eh]	;@06A71
	push	word ptr es:[bx]	;@06A75
	mov	di, 76h	;@06A78
	mov	si, ax	;@06A7B
	call COPY_NAME	;@06A7D
	push	ds	;@06A80
	mov	ax, 76h	;@06A81
	push	ax	;@06A84
	push	cs	;@06A85
	mov	ax, 5792h	;@06A86
	push	ax	;@06A89
	call	far ptr STRING_APPEND	;@06A8A
	mov	di, 26h	;@06A8F
	pop	si	;@06A92
	call COPY_NAME	;@06A93
	push	ds	;@06A96
	mov	ax, 76h	;@06A97
	push	ax	;@06A9A
	push	ds	;@06A9B
	mov	ax, 26h	;@06A9C
	push	ax	;@06A9F
	call	far ptr STRING_APPEND	;@06AA0
	pop	si	;@06AA5
	mov	di, 26h	;@06AA6
	call COPY_NAME	;@06AA9
	push	ds	;@06AAC
	mov	ax, 76h	;@06AAD
	push	ax	;@06AB0
	push	ds	;@06AB1
	mov	ax, 26h	;@06AB2
	push	ax	;@06AB5
	mov	cx, 8	;@06AB6
	push	cx	;@06AB9
	mov	ax, 35h	;@06ABA
	push	ax	;@06ABD
	call WARNING	;@06ABE
	pop	di	;@06AC1
	pop	si	;@06AC2
	pop	bx	;@06AC3
	mov	es, word ptr ds:[77Eh]	;@06AC4
	jmp	@@4	;@06AC8
L06ACA:	push	bp	;@06ACA
	mov	bp, sp	;@06ACB
	sub	sp, 0Ch	;@06ACD
	push	dx	;@06AD0
	push	si	;@06AD1
	push	di	;@06AD2
	cmp	byte ptr ds:[126h], 1	;@06AD3
	jne	@@1	;@06AD8
	mov	di, 7EAh	;@06ADA
	call	NEW_POOL	;@06ADD
@@1:	xor	di, di	;@06AE0
	mov	cx, di	;@06AE2
	mov	bx, 0FFFFh	;@06AE4
@@2:	cmp	di, word ptr ds:[7BCh]	;@06AE7
	jb	@@3	;@06AEB
	jmp	@@20	;@06AED
@@3:	mov	word ptr [bp-6], di	;@06AF0
	mov	es, word ptr ds:[7BEh]	;@06AF3
	mov	si, word ptr es:[di]	;@06AF7
	mov	es, word ptr ds:[776h]	;@06AFA
	call	L09591	;@06AFE
	mov	byte ptr [bp-0Ah], al	;@06B01
	cmp	al, 0FFh	;@06B04
	jne	@@4	;@06B06
	cmp	word ptr ds:[0C39h], -1	;@06B08
	jne	@@4	;@06B0D
	mov	word ptr ds:[0C39h], si	;@06B0F
@@4:	mov	al, byte ptr es:[si+9]	;@06B13
	cmp	al, 0FFh	;@06B17
	jne	@@5	;@06B19
	jmp	@@18	;@06B1B
@@5:	test	al, 0E0h	;@06B1E
	je	@@6	;@06B20
	and	al, 1Ch	;@06B22
	je	@@6	;@06B24
	cmp	bx, word ptr es:[si]	;@06B26
	je	@@9	;@06B29
	mov	bx, word ptr es:[si]	;@06B2B
	mov	cx, si	;@06B2E
@@6:	mov	ax, word ptr es:[si+6]	;@06B30
	mov	word ptr [bp-2], ax	;@06B34
	mov	al, byte ptr es:[si+8]	;@06B37
	mov	ah, 0	;@06B3B
	mov	word ptr [bp-4], ax	;@06B3D
	mov	es, word ptr ds:[77Eh]	;@06B40
	mov	word ptr es:[si+2], si	;@06B44
	cmp	byte ptr ds:[126h], 1	;@06B48
	jne	@@8	;@06B4D
	mov	di, 6	;@06B4F
	push	di	;@06B52
	mov	di, 7EAh	;@06B53
	call	L054ED	;@06B56
	jae	@@7	;@06B59
	call	TABLE_OVERFLOW	;@06B5B
@@7:	mov	word ptr es:[di], si	;@06B5E
	mov	ax, word ptr [bp-4]	;@06B61
	mov	word ptr es:[di+4], ax	;@06B64
	mov	ax, word ptr [bp-2]	;@06B68
	mov	word ptr es:[di+2], ax	;@06B6B
	mov	word ptr [bp-8], di	;@06B6F
@@8:	jmp	@@18	;@06B72
@@9:	mov	es, word ptr ds:[77Eh]	;@06B75
	mov	word ptr es:[si+2], cx	;@06B79
	cmp	al, 18h	;@06B7D
	jb	@@11	;@06B7F
	mov	di, cx	;@06B81
	mov	es, word ptr ds:[776h]	;@06B83
	mov	ax, word ptr es:[si+6]	;@06B87
	cmp	ax, word ptr es:[di+6]	;@06B8B
	jbe	@@10	;@06B8F
	xchg	word ptr es:[di+6], ax	;@06B91
	xchg	word ptr es:[si+6], ax	;@06B95
@@10:	jmp	short @@18	;@06B99
@@11:	mov	dx, word ptr [bp-4]	;@06B9B
	mov	ax, word ptr [bp-2]	;@06B9E
	push	cx	;@06BA1
	push	bx	;@06BA2
	mov	es, word ptr ds:[776h]	;@06BA3
	mov	cl, byte ptr es:[si+9]	;@06BA7
	and	cl, 0E0h	;@06BAB
	cmp	cl, 40h	;@06BAE
	jb	@@16	;@06BB1
	je	@@14	;@06BB3
	cmp	cl, 80h	;@06BB5
	je	@@12	;@06BB8
	ja	@@13	;@06BBA
	mov	bx, 0Fh	;@06BBC
	jmp	short @@15	;@06BBF
@@12:	mov	bx, 0FFh	;@06BC1
	jmp	short @@15	;@06BC4
@@13:	mov	bx, 3	;@06BC6
	jmp	short @@15	;@06BC9
@@14:	mov	bx, 1	;@06BCB
@@15:	add	ax, bx	;@06BCE
	adc	dx, 0	;@06BD0
	and	bx, ax	;@06BD3
	xor	ax, bx	;@06BD5
@@16:	pop	bx	;@06BD7
	add	ax, word ptr es:[si+6]	;@06BD8
	adc	dl, byte ptr es:[si+8]	;@06BDC
	mov	word ptr [bp-2], ax	;@06BE0
	mov	word ptr [bp-4], dx	;@06BE3
	pop	cx	;@06BE6
	or	dx, dx	;@06BE7
	je	@@17	;@06BE9
	or	ax, ax	;@06BEB
	je	@@17	;@06BED
	cmp	byte ptr ds:[125h], 0	;@06BEF
	je	@@21	;@06BF4
@@17:	cmp	byte ptr ds:[126h], 1	;@06BF6
	jne	@@18	;@06BFB
	mov	di, word ptr [bp-8]	;@06BFD
	mov	es, word ptr ds:[7EEh]	;@06C00
	mov	word ptr es:[di+4], dx	;@06C04
	mov	word ptr es:[di+2], ax	;@06C08
@@18:	cmp	byte ptr [bp-0Ah], 0FFh	;@06C0C
	jne	@@19	;@06C10
	mov	ax, word ptr [bp-2]	;@06C12
	mov	word ptr ds:[0C43h], ax	;@06C15
	mov	ax, word ptr [bp-4]	;@06C18
	mov	word ptr ds:[0C45h], ax	;@06C1B
@@19:	mov	di, word ptr [bp-6]	;@06C1E
	add	di, 2	;@06C21
	jmp	@@2	;@06C24
@@20:	pop	di	;@06C27
	pop	si	;@06C28
	pop	dx	;@06C29
	mov	sp, bp	;@06C2A
	pop	bp	;@06C2C
	ret	;@06C2D
@@21:	cmp	word ptr ds:[0C3Dh], -1	;@06C2E
	jne	@@18	;@06C33
	mov	es, word ptr ds:[776h]	;@06C35
	push	ax	;@06C39
	push	bx	;@06C3A
	push	cx	;@06C3B
	push	dx	;@06C3C
	push	si	;@06C3D
	push	di	;@06C3E
	mov	si, word ptr es:[si]	;@06C3F
	mov	di, 26h	;@06C42
	call COPY_NAME	;@06C45
	push	ds	;@06C48
	mov	bx, 26h	;@06C49
	push	bx	;@06C4C
	mov	cx, 4	;@06C4D
	push	cx	;@06C50
	mov	ax, 0Ah	;@06C51
	push	ax	;@06C54
	call ERROR	;@06C55
	or	byte ptr ds:[410h], 4	;@06C58
	pop	di	;@06C5D
	pop	si	;@06C5E
	pop	dx	;@06C5F
	pop	cx	;@06C60
	pop	bx	;@06C61
	pop	ax	;@06C62
	jmp	@@18	;@06C63
L06C65:	push	ax	;@06C65
	push	bx	;@06C66
	push	cx	;@06C67
	push	si	;@06C68
	call L0B626	;@06C69
	cmp	bx, 0	;@06C6C
	je	@@5	;@06C6F
	mov	si, word ptr ds:[774h]	;@06C71
	or	si, si	;@06C75
	je	@@5	;@06C77
	mov	cx, 0FFFFh	;@06C79
	mov	es, word ptr ds:[776h]	;@06C7C
	jmp	short @@4	;@06C80
@@1:	call	L09591	;@06C82
	cmp	al, 0FFh	;@06C85
	je	@@2	;@06C87
	cmp	cx, -1	;@06C89
	jne	@@5	;@06C8C
	jmp	short @@4	;@06C8E
@@2:	cmp	cx, -1	;@06C90
	jne	@@3	;@06C93
	mov	cx, si	;@06C95
	mov	byte ptr es:[si+8], 0	;@06C97
	mov	word ptr es:[si+6], bx	;@06C9C
	jmp	short @@4	;@06CA0
@@3:	mov	byte ptr es:[si+8], 0	;@06CA2
	mov	word ptr es:[si+6], 0	;@06CA7
@@4:	sub	si, 0Ah	;@06CAD
	jne	@@1	;@06CB0
@@5:	pop	si	;@06CB2
	pop	cx	;@06CB3
	pop	bx	;@06CB4
	pop	ax	;@06CB5
	ret	;@06CB6
L06CB7:	push	cx	;@06CB7
	push	bx	;@06CB8
	mov	cx, word ptr es:[di]	;@06CB9
	cmp	cx, -1	;@06CBC
	je	@@4	;@06CBF
	xor	bx, bx	;@06CC1
@@1:	cmp	bx, word ptr ds:[7B4h]	;@06CC3
	jae	@@2	;@06CC7
	mov	es, word ptr ds:[7B6h]	;@06CC9
	cmp	word ptr es:[bx], cx	;@06CCD
	je	@@4	;@06CD0
	add	bx, 4	;@06CD2
	jmp	@@1	;@06CD5
@@2:	mov	di, 4	;@06CD7
	push	di	;@06CDA
	mov	di, 7B2h	;@06CDB
	call	L054ED	;@06CDE
	jae	@@3	;@06CE1
	call	TABLE_OVERFLOW	;@06CE3
@@3:	mov	word ptr es:[bx], cx	;@06CE6
	mov	word ptr es:[bx+2], si	;@06CE9
@@4:	pop	bx	;@06CED
	pop	cx	;@06CEE
	ret	;@06CEF
L06CF0:	push	bp	;@06CF0
	mov	bp, sp	;@06CF1
	xor	di, di	;@06CF3
@@1:	cmp	di, word ptr ds:[7B4h]	;@06CF5
	jae	@@2	;@06CF9
	mov	es, word ptr ds:[7B6h]	;@06CFB
	mov	ax, word ptr [bp+4]	;@06CFF
	cmp	word ptr es:[di], ax	;@06D02
	je	@@3	;@06D05
	add	di, 4	;@06D07
	jmp	@@1	;@06D0A
@@2:	mov	ax, 3	;@06D0C
	call	L0961E	;@06D0F
@@3:	mov	ax, word ptr es:[di+2]	;@06D12
	mov	sp, bp	;@06D16
	pop	bp	;@06D18
	ret	2	;@06D19
L06D1C:	mov	si, word ptr ds:[7BCh]	;@06D1C
	jmp	short @@2	;@06D20
@@1:	mov	es, word ptr ds:[7BEh]	;@06D22
	mov	di, word ptr es:[si]	;@06D26
	mov	es, word ptr ds:[77Eh]	;@06D29
	call	L06CB7	;@06D2D
@@2:	sub	si, 2	;@06D30
	jae	@@1	;@06D33
	ret	;@06D35
L06D36:	push	ax	;@06D36
	push	cx	;@06D37
	mov	cx, 14h	;@06D38
	mov	di, cx	;@06D3B
	push	di	;@06D3D
	mov	di, 79Ah	;@06D3E
	call	L054ED	;@06D41
	jae	@@1	;@06D44
	call	TABLE_OVERFLOW	;@06D46
@@1:	push	di	;@06D49
	mov	al, 0	;@06D4A
	cld	;@06D4C
	rep stosb	;@06D4D
	pop	di	;@06D4F
	mov	word ptr es:[di+4], si	;@06D50
	mov	ax, word ptr ds:[6B9h]	;@06D54
	inc	ax	;@06D57
	mov	word ptr ds:[6B9h], ax	;@06D58
	mov	word ptr es:[di+6], ax	;@06D5B
	pop	cx	;@06D5F
	pop	ax	;@06D60
	ret	;@06D61
L06D62:	push	di	;@06D62
	xor	di, di	;@06D63
	mov	es, word ptr ds:[7EEh]	;@06D65
	jmp	short @@2	;@06D69
@@1:	cmp	si, word ptr es:[di]	;@06D6B
	je	@@4	;@06D6E
	add	di, 6	;@06D70
@@2:	cmp	di, word ptr ds:[7ECh]	;@06D73
	jb	@@1	;@06D77
	mov	ax, 4	;@06D79
	call	L0961E	;@06D7C
@@3:	jmp	short @@5	;@06D7F
@@4:	cmp	word ptr es:[di+4], 0	;@06D81
	jne	@@3	;@06D86
	cmp	word ptr ds:[142h], 0	;@06D88
	je	@@7	;@06D8D
	add	ax, word ptr es:[di+2]	;@06D8F
	jb	@@5	;@06D93
	cmp	ax, word ptr ds:[142h]	;@06D95
	jbe	@@6	;@06D99
@@5:	stc	;@06D9B
	jmp	short @@8	;@06D9C
@@6:	clc	;@06D9E
	jmp	short @@8	;@06D9F
@@7:	add	ax, word ptr es:[di+2]	;@06DA1
	jb	@@8	;@06DA5
@@8:	pop	di	;@06DA7
	ret	;@06DA8
L06DA9:	push	bp	;@06DA9
	mov	bp, sp	;@06DAA
	sub	sp, 1Ah	;@06DAC
	push	si	;@06DAF
	push	di	;@06DB0
	call	L06D1C	;@06DB1
	mov	ax, 0FFFFh	;@06DB4
	mov	word ptr [bp-8], ax	;@06DB7
	mov	word ptr [bp-12h], ax	;@06DBA
	mov	word ptr [bp-14h], ax	;@06DBD
	mov	word ptr [bp-1Ah], ax	;@06DC0
	xor	si, si	;@06DC3
	jmp	short @@3	;@06DC5
@@1:	jmp	@@39	;@06DC7
@@2:	mov	si, word ptr [bp-6]	;@06DCA
	add	si, 2	;@06DCD
@@3:	cmp	si, word ptr ds:[7BCh]	;@06DD0
	jae	@@1	;@06DD4
	mov	word ptr [bp-6], si	;@06DD6
	mov	es, word ptr ds:[7BEh]	;@06DD9
	mov	si, word ptr es:[si]	;@06DDD
	mov	es, word ptr ds:[77Eh]	;@06DE0
	cmp	byte ptr ds:[3D7h], 1	;@06DE4
	jne	@@5	;@06DE9
	mov	cx, word ptr es:[si]	;@06DEB
	mov	es, word ptr ds:[776h]	;@06DEE
	mov	dx, word ptr es:[si+2]	;@06DF2
	cmp	word ptr ds:[0C35h], -1	;@06DF6
	jne	@@4	;@06DFB
	cmp	cx, word ptr ds:[424h]	;@06DFD
	jne	@@4	;@06E01
	cmp	dx, word ptr ds:[426h]	;@06E03
	jne	@@4	;@06E07
	mov	word ptr ds:[0C35h], si	;@06E09
	jmp	short @@5	;@06E0D
@@4:	cmp	word ptr ds:[0C37h], -1	;@06E0F
	jne	@@5	;@06E14
	cmp	cx, word ptr ds:[424h]	;@06E16
	jne	@@5	;@06E1A
	cmp	dx, word ptr ds:[42Ch]	;@06E1C
	jne	@@5	;@06E20
	mov	word ptr ds:[0C37h], si	;@06E22
@@5:	mov	es, word ptr ds:[776h]	;@06E26
	call	L09591	;@06E2A
	mov	byte ptr [bp-16h], al	;@06E2D
	mov	dl, byte ptr es:[si+9]	;@06E30
	mov	byte ptr [bp-18h], dl	;@06E34
	test	dl, 0E0h	;@06E37
	je	@@2	;@06E3A
	mov	ax, word ptr es:[si+6]	;@06E3C
	mov	word ptr [bp-0Eh], ax	;@06E40
	mov	al, byte ptr es:[si+8]	;@06E43
	mov	ah, 0	;@06E47
	mov	word ptr [bp-0Ch], ax	;@06E49
	mov	es, word ptr ds:[77Eh]	;@06E4C
	xor	ax, ax	;@06E50
	xchg	word ptr es:[si+6], ax	;@06E52
	mov	word ptr [bp-4], ax	;@06E56
	mov	bx, word ptr es:[si+2]	;@06E59
	mov	di, 0FFFFh	;@06E5D
	xchg	word ptr es:[si], di	;@06E60
	mov	word ptr [bp-2], di	;@06E63
	cmp	di, -1	;@06E66
	jne	@@6	;@06E69
	cmp	word ptr [bp-12h], -1	;@06E6B
	jne	@@8	;@06E6F
	jmp	@@12	;@06E71
@@6:	cmp	word ptr [bp-12h], -1	;@06E74
	jne	@@8	;@06E78
	push	di	;@06E7A
	push	di	;@06E7B
	call	L06CF0	;@06E7C
	pop	di	;@06E7F
	mov	word ptr [bp-12h], ax	;@06E80
	mov	word ptr [bp-14h], di	;@06E83
	cmp	word ptr [bp-6], ax	;@06E86
	je	@@7	;@06E89
	jmp	@@16	;@06E8B
@@7:	mov	word ptr [bp-12h], 0FFFFh	;@06E8E
	jmp	@@16	;@06E93
@@8:	mov	ax, word ptr [bp-6]	;@06E96
	cmp	ax, word ptr [bp-12h]	;@06E99
	je	@@11	;@06E9C
	mov	cx, word ptr [bp-2]	;@06E9E
	cmp	cx, -1	;@06EA1
	je	@@9	;@06EA4
	cmp	cx, word ptr [bp-14h]	;@06EA6
	je	@@9	;@06EA9
	mov	al, byte ptr ds:[17h]	;@06EAB
	or	al, byte ptr ds:[486h]	;@06EAE
	je	@@9	;@06EB2
	push	si	;@06EB4
	mov	si, word ptr [bp-14h]	;@06EB5
	mov	di, 26h	;@06EB8
	call COPY_NAME	;@06EBB
	mov	si, word ptr [bp-2]	;@06EBE
	mov	di, 76h	;@06EC1
	call COPY_NAME	;@06EC4
	push	ds	;@06EC7
	mov	ax, 76h	;@06EC8
	push	ax	;@06ECB
	push	ds	;@06ECC
	mov	ax, 26h	;@06ECD
	push	ax	;@06ED0
	mov	word ptr ds:[422h], 1	;@06ED1
	mov	cx, 8	;@06ED7
	push	cx	;@06EDA
	mov	ax, 36h	;@06EDB
	push	ax	;@06EDE
	call WARNING	;@06EDF
	pop	si	;@06EE2
@@9:	mov	es, word ptr ds:[77Eh]	;@06EE3
	mov	ax, word ptr [bp-14h]	;@06EE7
	mov	word ptr es:[si], ax	;@06EEA
@@10:	mov	di, word ptr [bp-14h]	;@06EED
	push	di	;@06EF0
	and	di, 3	;@06EF1
	shl	di, 1	;@06EF4
	shl	di, 1	;@06EF6
	shl	di, 1	;@06EF8
	mov	es, word ptr [di+716h]	;@06EFA
	pop	di	;@06EFE
	mov	di, word ptr es:[di]	;@06EFF
	jmp	@@23	;@06F02
@@11:	mov	word ptr [bp-12h], 0FFFFh	;@06F05
	jmp	@@10	;@06F0A
@@12:	test	dl, 1Ch	;@06F0C
	jne	@@13	;@06F0F
	jmp	@@18	;@06F11
@@13:	test	dl, 2	;@06F14
	je	@@14	;@06F17
	jmp	@@18	;@06F19
@@14:	mov	es, word ptr ds:[776h]	;@06F1C
	mov	ax, word ptr es:[si]	;@06F20
	mov	bx, word ptr [bp-6]	;@06F23
	sub	bx, 2	;@06F26
	jl	@@16	;@06F29
	mov	es, word ptr ds:[7BEh]	;@06F2B
	mov	bx, word ptr es:[bx]	;@06F2F
	mov	es, word ptr ds:[776h]	;@06F32
	cmp	ax, word ptr es:[bx]	;@06F36
	jne	@@16	;@06F39
	mov	ax, word ptr es:[bx+2]	;@06F3B
	cmp	ax, word ptr es:[si+2]	;@06F3F
	jne	@@16	;@06F43
	mov	dh, byte ptr es:[bx+9]	;@06F45
	test	dh, 1Ch	;@06F49
	je	@@16	;@06F4C
	test	dh, 2	;@06F4E
	jne	@@16	;@06F51
@@15:	mov	es, word ptr ds:[77Eh]	;@06F53
	mov	di, word ptr es:[bx]	;@06F57
	jmp	@@23	;@06F5A
@@16:	cmp	byte ptr ds:[126h], 1	;@06F5D
	jne	@@18	;@06F62
	cmp	byte ptr [bp-16h], 1	;@06F64
	jne	@@18	;@06F68
	cmp	word ptr [bp-2], -1	;@06F6A
	jne	@@18	;@06F6E
	cmp	word ptr [bp-8], -1	;@06F70
	je	@@18	;@06F74
	mov	ax, word ptr [bp-0Ah]	;@06F76
	call	L06D62	;@06F79
	jb	@@18	;@06F7C
	mov	bx, word ptr [bp-8]	;@06F7E
	jmp	@@15	;@06F81
@@17:	mov	di, word ptr [bp-1Ah]	;@06F83
	cmp	di, -1	;@06F86
	je	@@19	;@06F89
	mov	es, word ptr ds:[79Eh]	;@06F8B
	cmp	word ptr es:[di+0Dh], 0	;@06F8F
	jne	@@19	;@06F94
	cmp	word ptr es:[di+0Fh], 0	;@06F96
	jne	@@19	;@06F9B
	mov	word ptr es:[di+4], si	;@06F9D
	jmp	short @@20	;@06FA1
@@18:	and	dl, 0E0h	;@06FA3
	cmp	byte ptr ds:[17h], 0	;@06FA6
	jne	@@17	;@06FAB
@@19:	call	L06D36	;@06FAD
	mov	word ptr [bp-1Ah], di	;@06FB0
@@20:	mov	byte ptr es:[di], dl	;@06FB3
	mov	ax, word ptr [bp-4]	;@06FB6
	mov	word ptr es:[di+11h], ax	;@06FB9
	mov	ax, word ptr [bp-0Eh]	;@06FBD
	mov	cx, word ptr [bp-0Ch]	;@06FC0
	mov	word ptr es:[di+0Dh], ax	;@06FC3
	mov	word ptr es:[di+0Fh], cx	;@06FC7
	mov	al, byte ptr [bp-16h]	;@06FCB
	mov	byte ptr es:[di+1], al	;@06FCE
	cmp	al, 3	;@06FD2
	jl	@@21	;@06FD4
	cmp	word ptr ds:[404h], -1	;@06FD6
	jne	@@21	;@06FDB
	mov	word ptr ds:[404h], di	;@06FDD
@@21:	mov	bx, word ptr [bp-2]	;@06FE1
	mov	word ptr es:[di+2], bx	;@06FE4
	cmp	bx, -1	;@06FE8
	je	@@22	;@06FEB
	push	bx	;@06FED
	and	bx, 3	;@06FEE
	shl	bx, 1	;@06FF1
	shl	bx, 1	;@06FF3
	shl	bx, 1	;@06FF5
	mov	es, word ptr [bx+716h]	;@06FF7
	pop	bx	;@06FFB
	mov	word ptr es:[bx], di	;@06FFC
@@22:	mov	es, word ptr ds:[77Eh]	;@06FFF
	mov	word ptr es:[si], di	;@07003
	jmp	@@37	;@07006
@@23:	mov	es, word ptr ds:[79Eh]	;@07009
	mov	ax, word ptr es:[di+4]	;@0700D
	mov	word ptr [bp-10h], ax	;@07011
	mov	dh, dl	;@07014
	and	dx, 1CE0h	;@07016
	cmp	dl, byte ptr es:[di]	;@0701A
	jbe	@@24	;@0701D
	mov	byte ptr es:[di], dl	;@0701F
@@24:	cmp	byte ptr ds:[17h], 1	;@07022
	jne	@@25	;@07027
	cmp	byte ptr [bp-16h], 1	;@07029
	jne	@@25	;@0702D
	mov	byte ptr es:[di+1], 1	;@0702F
@@25:	cmp	byte ptr [bp-16h], 0FFh	;@07034
	jne	@@27	;@07038
	cmp	word ptr ds:[0C39h], -1	;@0703A
	jne	@@26	;@0703F
	mov	word ptr ds:[0C39h], bx	;@07041
@@26:	mov	byte ptr es:[di+1], 0FFh	;@07045
@@27:	mov	ax, word ptr [bp-4]	;@0704A
	add	word ptr es:[di+11h], ax	;@0704D
	mov	ax, word ptr es:[di+0Dh]	;@07051
	mov	cx, word ptr es:[di+0Fh]	;@07055
	cmp	bx, si	;@07059
	je	@@28	;@0705B
	cmp	dh, 14h	;@0705D
	je	@@28	;@07060
	cmp	dh, 8	;@07062
	jne	@@29	;@07065
@@28:	push	bx	;@07067
	cmp	dl, 40h	;@07068
	jb	@@34	;@0706B
	je	@@32	;@0706D
	cmp	dl, 80h	;@0706F
	je	@@30	;@07072
	ja	@@31	;@07074
	mov	bx, 0Fh	;@07076
	jmp	short @@33	;@07079
@@29:	mov	es, word ptr ds:[77Eh]	;@0707B
	push	word ptr es:[bx+6]	;@0707F
	push	word ptr es:[bx+8]	;@07083
	cmp	dh, 18h	;@07087
	jb	@@35	;@0708A
	jmp	short @@36	;@0708C
@@30:	mov	bx, 0FFh	;@0708E
	jmp	short @@33	;@07091
@@31:	mov	bx, 3	;@07093
	jmp	short @@33	;@07096
@@32:	mov	bx, 1	;@07098
@@33:	add	ax, bx	;@0709B
	adc	cx, 0	;@0709D
	and	bx, ax	;@070A0
	xor	ax, bx	;@070A2
@@34:	pop	bx	;@070A4
	push	ax	;@070A5
	push	cx	;@070A6
@@35:	add	ax, word ptr [bp-0Eh]	;@070A7
	adc	cx, word ptr [bp-0Ch]	;@070AA
	cmp	byte ptr ds:[125h], 0	;@070AD
	jne	@@36	;@070B2
	or	cx, cx	;@070B4
	je	@@36	;@070B6
	or	ax, ax	;@070B8
	jne	@@40	;@070BA
@@36:	mov	es, word ptr ds:[79Eh]	;@070BC
	mov	word ptr es:[di+0Dh], ax	;@070C0
	mov	word ptr es:[di+0Fh], cx	;@070C4
	mov	es, word ptr ds:[77Eh]	;@070C8
	pop	cx	;@070CC
	mov	byte ptr es:[si+8], cl	;@070CD
	pop	word ptr es:[si+6]	;@070D1
	mov	word ptr es:[si], di	;@070D5
	cmp	byte ptr ds:[17h], 0	;@070D8
	jne	@@37	;@070DD
	cmp	si, word ptr [bp-10h]	;@070DF
	je	@@37	;@070E2
	cmp	si, word ptr es:[si+2]	;@070E4
	jne	@@37	;@070E8
	cmp	byte ptr [bp-16h], 1	;@070EA
	jge	@@37	;@070EE
	mov	ax, word ptr es:[si+6]	;@070F0
	call	L06D36	;@070F4
	mov	byte ptr es:[di], 20h	;@070F7
	mov	word ptr es:[di+11h], 0	;@070FB
	mov	word ptr es:[di+0Bh], ax	;@07101
	mov	byte ptr es:[di+1], 0FEh	;@07105
@@37:	cmp	byte ptr ds:[126h], 1	;@0710A
	jne	@@38	;@0710F
	mov	word ptr [bp-8], 0FFFFh	;@07111
	cmp	byte ptr [bp-16h], 1	;@07116
	jne	@@38	;@0711A
	mov	word ptr [bp-8], si	;@0711C
	mov	es, word ptr ds:[79Eh]	;@0711F
	mov	ax, word ptr es:[di+0Dh]	;@07123
	mov	word ptr [bp-0Ah], ax	;@07127
@@38:	jmp	@@2	;@0712A
@@39:	pop	di	;@0712D
	pop	si	;@0712E
	mov	sp, bp	;@0712F
	pop	bp	;@07131
	ret	;@07132
@@40:	mov	es, word ptr ds:[77Eh]	;@07133
	cmp	word ptr [bp-14h], -1	;@07137
	jne	@@41	;@0713B
	cmp	word ptr es:[si], -1	;@0713D
	jne	@@41	;@07141
	jmp	@@36	;@07143
@@41:	cmp	word ptr ds:[0C3Bh], -1	;@07146
	je	@@42	;@0714B
	jmp	@@36	;@0714D
@@42:	mov	word ptr ds:[0C3Bh], 1	;@07150
	push	ax	;@07156
	push	bx	;@07157
	push	cx	;@07158
	push	dx	;@07159
	push	si	;@0715A
	push	di	;@0715B
	mov	si, word ptr [bp-14h]	;@0715C
	cmp	si, -1	;@0715F
	jne	@@43	;@07162
	mov	si, word ptr es:[si]	;@07164
@@43:	mov	di, 26h	;@07167
	call COPY_NAME	;@0716A
	push	ds	;@0716D
	mov	bx, 26h	;@0716E
	push	bx	;@07171
	mov	cx, 4	;@07172
	push	cx	;@07175
	mov	ax, 9	;@07176
	push	ax	;@07179
	call ERROR	;@0717A
	or	byte ptr ds:[410h], 4	;@0717D
	pop	di	;@07182
	pop	si	;@07183
	pop	dx	;@07184
	pop	cx	;@07185
	pop	bx	;@07186
	pop	ax	;@07187
	jmp	@@36	;@07188
L0718B:	push	bp	;@0718B
	mov	bp, sp	;@0718C
	sub	sp, 6	;@0718E
	sub	cx, cx	;@07191
	mov	byte ptr [bp-4], cl	;@07193
	mov	word ptr ds:[6B5h], cx	;@07196
	mov	word ptr ds:[6B7h], cx	;@0719A
	mov	word ptr ds:[4A8h], cx	;@0719E
	mov	word ptr ds:[4AAh], cx	;@071A2
	sub	cx, cx	;@071A6
	sub	dx, dx	;@071A8
	sub	si, si	;@071AA
	mov	di, si	;@071AC
	jmp	short @@5	;@071AE
@@1:	mov	ax, 0Fh	;@071B0
	add	cx, ax	;@071B3
	adc	dl, dh	;@071B5
	and	cl, 0F0h	;@071B7
	and	ax, dx	;@071BA
	or	ax, cx	;@071BC
	ror	ax, 1	;@071BE
	ror	ax, 1	;@071C0
	ror	ax, 1	;@071C2
	ror	ax, 1	;@071C4
	mov	word ptr ds:[418h], ax	;@071C6
	add	cx, 10h	;@071C9
	adc	dl, dh	;@071CC
	ret	;@071CE
@@2:	cmp	word ptr ds:[414h], 1	;@071CF
	jne	@@3	;@071D4
	cmp	word ptr ds:[418h], -1	;@071D6
	jne	@@3	;@071DB
	call	@@1	;@071DD
@@3:	jmp	@@23	;@071E0
@@4:	add	si, 14h	;@071E3
@@5:	cmp	si, word ptr ds:[79Ch]	;@071E6
	jae	@@2	;@071EA
	cmp	si, word ptr ds:[404h]	;@071EC
	jne	@@6	;@071F0
	call	@@1	;@071F2
@@6:	mov	es, word ptr ds:[79Eh]	;@071F5
	cmp	byte ptr ds:[17h], 0	;@071F9
	jne	@@7	;@071FE
	mov	al, byte ptr es:[si+1]	;@07200
	cmp	al, 0FEh	;@07204
	je	@@4	;@07206
	cmp	al, 0FDh	;@07208
	je	@@4	;@0720A
	cmp	al, 3	;@0720C
	jge	@@7	;@0720E
	jmp	short @@10	;@07210
@@7:	mov	bx, word ptr ds:[3FAh]	;@07212
	add	cx, bx	;@07216
	adc	dx, 0	;@07218
	and	bx, cx	;@0721B
	xor	cx, bx	;@0721D
	mov	ax, word ptr es:[si+0Dh]	;@0721F
	mov	word ptr [bp-2], ax	;@07223
	mov	bx, word ptr es:[si+11h]	;@07226
	cmp	byte ptr ds:[17h], 0	;@0722A
	jne	@@8	;@0722F
	cmp	bx, 3	;@07231
	jae	@@8	;@07234
	mov	bx, 3	;@07236
@@8:	cmp	byte ptr ds:[17h], 0	;@07239
	je	@@9	;@0723E
	cmp	bx, 0	;@07240
	je	@@16	;@07243
@@9:	xchg	dx, bx	;@07245
	call	L05C58	;@07247
	xchg	bx, dx	;@0724A
	mov	word ptr es:[si+11h], 0	;@0724C
	jmp	short @@16	;@07252
@@10:	cmp	byte ptr es:[si], 40h	;@07254
	jb	@@15	;@07258
	je	@@13	;@0725A
	cmp	byte ptr es:[si], 80h	;@0725C
	je	@@11	;@07260
	ja	@@12	;@07262
	mov	bx, 0Fh	;@07264
	jmp	short @@14	;@07267
@@11:	mov	bx, 0FFh	;@07269
	jmp	short @@14	;@0726C
@@12:	mov	bx, 3	;@0726E
	jmp	short @@14	;@07271
@@13:	mov	bx, 1	;@07273
@@14:	add	cx, bx	;@07276
	adc	dx, 0	;@07278
	and	bx, cx	;@0727B
	xor	cx, bx	;@0727D
@@15:	mov	ax, word ptr es:[si+0Dh]	;@0727F
	mov	word ptr [bp-2], ax	;@07283
	mov	bx, word ptr es:[si+0Fh]	;@07286
@@16:	push	dx	;@0728A
	push	cx	;@0728B
	push	bx	;@0728C
	push	ax	;@0728D
	mov	ax, 0Fh	;@0728E
	and	ax, cx	;@07291
	mov	word ptr es:[si+0Bh], ax	;@07293
	xor	ax, cx	;@07297
	mov	cx, 4	;@07299
@@17:	shr	dx, 1	;@0729C
	rcr	ax, 1	;@0729E
	loop	@@17	;@072A0
	mov	word ptr es:[si+8], ax	;@072A2
	mov	byte ptr es:[si+0Ah], dl	;@072A6
	cmp	byte ptr es:[si+1], 0FFh	;@072AA
	jne	@@21	;@072AF
	mov	byte ptr ds:[3D3h], 1	;@072B1
	mov	word ptr ds:[4A8h], ax	;@072B6
	cmp	byte ptr ds:[129h], 3	;@072B9
	je	@@18	;@072BE
	mov	bx, word ptr es:[si+6]	;@072C0
	mov	word ptr ds:[6B7h], bx	;@072C4
	mov	ax, word ptr [bp-2]	;@072C8
	mov	word ptr ds:[6B5h], ax	;@072CB
@@18:	pop	ax	;@072CE
	pop	bx	;@072CF
	pop	cx	;@072D0
	pop	dx	;@072D1
	push	ax	;@072D2
	push	bx	;@072D3
	push	cx	;@072D4
	cmp	byte ptr ds:[17h], 1	;@072D5
	je	@@19	;@072DA
	mov	bx, word ptr ds:[0C39h]	;@072DC
	cmp	bx, -1	;@072E0
	je	@@19	;@072E3
	mov	byte ptr [bp-4], 1	;@072E5
	mov	es, word ptr ds:[77Eh]	;@072E9
	mov	ax, word ptr es:[bx+6]	;@072ED
	mov	cl, 4	;@072F1
	shr	ax, cl	;@072F3
	add	word ptr ds:[4A8h], ax	;@072F5
	mov	ax, word ptr ds:[0C43h]	;@072F9
@@19:	pop	cx	;@072FC
	pop	bx	;@072FD
	mov	word ptr ds:[4AAh], ax	;@072FE
	pop	ax	;@07301
	cmp	byte ptr ds:[129h], 1	;@07302
	je	@@25	;@07307
	cmp	byte ptr [bp-4], 1	;@07309
	je	@@20	;@0730D
	or	bx, bx	;@0730F
	je	@@22	;@07311
	jmp	short @@26	;@07313
@@20:	cmp	word ptr ds:[0C45h], 0	;@07315
	jne	@@26	;@0731A
	jmp	short @@22	;@0731C
@@21:	pop	ax	;@0731E
	pop	bx	;@0731F
	pop	cx	;@07320
	pop	dx	;@07321
@@22:	add	cx, ax	;@07322
	adc	dx, bx	;@07324
	jmp	@@4	;@07326
@@23:	mov	word ptr ds:[3DEh], dx	;@07329
	mov	word ptr ds:[3DCh], cx	;@0732D
	cmp	byte ptr ds:[129h], 1	;@07331
	je	@@27	;@07336
	mov	word ptr ds:[3F2h], 3Eh	;@07338
	mov	word ptr ds:[3F4h], 0	;@0733E
	mov	ax, word ptr ds:[4A0h]	;@07344
	add	ax, 8Fh	;@07347
	and	al, 80h	;@0734A
	shr	ax, 1	;@0734C
	shr	ax, 1	;@0734E
@@24:	mov	word ptr ds:[4A2h], ax	;@07350
	mov	word ptr ds:[3FEh], ax	;@07353
	mov	word ptr ds:[4B2h], 3Eh	;@07356
	mov	word ptr ds:[4ACh], 0	;@0735C
	mov	word ptr ds:[4A0h], 0	;@07362
	mov	sp, bp	;@07368
	pop	bp	;@0736A
	ret	;@0736B
@@25:	xor	ax, ax	;@0736C
	push	ax	;@0736E
	mov	ax, 13h	;@0736F
	push	ax	;@07372
	call FATAL	;@07373
@@26:	push	ax	;@07376
	push	bx	;@07377
	push	cx	;@07378
	push	dx	;@07379
	push	si	;@0737A
	push	di	;@0737B
	xor	cx, cx	;@0737C
	push	cx	;@0737E
	mov	ax, 0Bh	;@0737F
	push	ax	;@07382
	call ERROR	;@07383
	or	byte ptr ds:[410h], 2	;@07386
	pop	di	;@0738B
	pop	si	;@0738C
	pop	dx	;@0738D
	pop	cx	;@0738E
	pop	bx	;@0738F
	pop	ax	;@07390
	jmp	@@22	;@07391
@@27:	push	cx	;@07393
	call	L0937E	;@07394
	pop	cx	;@07397
	mov	ax, 0	;@07398
	jne	@@28	;@0739B
	or	dx, dx	;@0739D
	jne	@@29	;@0739F
@@28:	jmp	@@24	;@073A1
@@29:	xor	ax, ax	;@073A3
	push	ax	;@073A5
	mov	ax, 14h	;@073A6
	push	ax	;@073A9
	call FATAL	;@073AA
L073AD:	push	ax	;@073AD
	push	bx	;@073AE
	push	dx	;@073AF
	push	si	;@073B0
	push	di	;@073B1
	sub	si, si	;@073B2
	jmp	short @@3	;@073B4
@@1:	mov	es, word ptr ds:[776h]	;@073B6
	cmp	byte ptr es:[si+9], 0FFh	;@073BA
	je	@@2	;@073BF
	test	byte ptr es:[si+9], 0E0h	;@073C1
	je	@@2	;@073C6
	mov	es, word ptr ds:[77Eh]	;@073C8
	mov	di, word ptr es:[si]	;@073CC
	mov	es, word ptr ds:[79Eh]	;@073CF
	mov	ax, word ptr es:[di+0Bh]	;@073D3
	mov	es, word ptr ds:[77Eh]	;@073D7
	add	word ptr es:[si+6], ax	;@073DB
	adc	byte ptr es:[si+8], 0	;@073DF
@@2:	add	si, 0Ah	;@073E4
@@3:	cmp	si, word ptr ds:[774h]	;@073E7
	jb	@@1	;@073EB
	pop	di	;@073ED
	pop	si	;@073EE
	pop	dx	;@073EF
	pop	bx	;@073F0
	pop	ax	;@073F1
	ret	;@073F2
L073F3:	push	ax	;@073F3
	push	bx	;@073F4
	push	dx	;@073F5
	push	si	;@073F6
	push	di	;@073F7
	sub	si, si	;@073F8
	push	si	;@073FA
	mov	bx, 752h	;@073FB
@@1:	push	si	;@073FE
	and	si, 3	;@073FF
	shl	si, 1	;@07402
	shl	si, 1	;@07404
	shl	si, 1	;@07406
	mov	es, word ptr [si+756h]	;@07408
	pop	si	;@0740C
	jmp	short @@4	;@0740D
@@2:	mov	al, byte ptr es:[si+0Eh]	;@0740F
	test	al, 18h	;@07413
	jne	@@3	;@07415
	test	al, 2	;@07417
	jne	@@3	;@07419
	mov	di, word ptr es:[si]	;@0741B
	mov	es, word ptr ds:[77Eh]	;@0741E
	mov	ax, word ptr es:[di+6]	;@07422
	mov	dl, byte ptr es:[di+8]	;@07426
	mov	dh, 0	;@0742A
	push	si	;@0742C
	and	si, 3	;@0742D
	shl	si, 1	;@07430
	shl	si, 1	;@07432
	shl	si, 1	;@07434
	mov	es, word ptr [si+756h]	;@07436
	pop	si	;@0743A
	add	word ptr es:[si+4], ax	;@0743B
	adc	word ptr es:[si+6], dx	;@0743F
@@3:	add	si, word ptr ds:[48Eh]	;@07443
@@4:	cmp	si, word ptr [bx+2]	;@07447
	jb	@@2	;@0744A
	cmp	bx, 762h	;@0744C
	ja	@@5	;@07450
	add	bx, 8	;@07452
	pop	si	;@07455
	inc	si	;@07456
	push	si	;@07457
	jmp	@@1	;@07458
@@5:	pop	si	;@0745A
	pop	di	;@0745B
	pop	si	;@0745C
	pop	dx	;@0745D
	pop	bx	;@0745E
	pop	ax	;@0745F
	ret	;@07460
L07461:	push	bp	;@07461
	mov	bp, sp	;@07462
	sub	si, si	;@07464
	jmp	short @@3	;@07466
@@1:	mov	dx, word ptr es:[si+8]	;@07468
@@2:	add	si, 14h	;@0746C
@@3:	cmp	si, word ptr ds:[79Ch]	;@0746F
	jae	@@4	;@07473
	mov	es, word ptr ds:[79Eh]	;@07475
	cmp	byte ptr es:[si+1], 0FEh	;@07479
	jne	@@1	;@0747E
	mov	ax, word ptr es:[si+0Bh]	;@07480
	mov	cx, 0Fh	;@07484
	and	cx, ax	;@07487
	xor	ax, cx	;@07489
	mov	word ptr es:[si+0Bh], cx	;@0748B
	mov	cl, 4	;@0748F
	ror	ax, cl	;@07491
	add	ax, dx	;@07493
	mov	word ptr es:[si+8], ax	;@07495
	mov	word ptr es:[si+0Dh], 0FFFFh	;@07499
	jmp	@@2	;@0749F
@@4:	mov	sp, bp	;@074A1
	pop	bp	;@074A3
	ret	;@074A4
L074A5:	push	bp	;@074A5
	mov	bp, sp	;@074A6
	sub	sp, 4	;@074A8
	cmp	byte ptr ds:[17h], 0	;@074AB
	je	@@1	;@074B0
	cmp	byte ptr ds:[14h], 0	;@074B2
	jne	@@1	;@074B7
	mov	ax, 1000h	;@074B9
	mul	word ptr ds:[482h]	;@074BC
	add	ax, word ptr ds:[484h]	;@074C0
	adc	dx, 0	;@074C4
	jmp	short @@2	;@074C7
@@1:	mov	dx, 10h	;@074C9
	mul	dx	;@074CC
	add	ax, word ptr ds:[3DCh]	;@074CE
	adc	dx, word ptr ds:[3DEh]	;@074D2
	add	ax, 0Fh	;@074D6
	adc	dx, 0	;@074D9
	and	ax, 0FFF0h	;@074DC
@@2:	call L09792	;@074DF
	cmp	byte ptr ds:[17h], 0	;@074E2
	je	@@3	;@074E7
	cmp	byte ptr ds:[14h], 0	;@074E9
	je	@@3	;@074EE
	push	dx	;@074F0
	push	ax	;@074F1
	mov	di, 6F9h	;@074F2
	push	di	;@074F5
	push	ds	;@074F6
	pop	es	;@074F7
	mov	ax, 424Eh	;@074F8
	stosw	;@074FB
	mov	ax, 3230h	;@074FC
	stosw	;@074FF
	mov	cx, 0Ch	;@07500
	shr	cx, 1	;@07503
	mov	ax, 0FFFFh	;@07505
	rep stosw	;@07508
	pop	si	;@0750A
	pop	ax	;@0750B
	pop	dx	;@0750C
	mov	cx, 10h	;@0750D
	call	L08B1D	;@07510
@@3:	mov	word ptr [bp-4], ax	;@07513
	mov	word ptr [bp-2], dx	;@07516
	mov	si, 4D8h	;@07519
	mov	word ptr [si], 52FBh	;@0751C
	mov	ax, 300h	;@07520
	cmp	byte ptr ds:[12Dh], 1	;@07523
	jne	@@4	;@07528
	mov	ax, 209h	;@0752A
@@4:	mov	word ptr [si+2], ax	;@0752D
	mov	al, byte ptr ds:[120h]	;@07530
	mov	byte ptr [si+28h], al	;@07533
	mov	ax, word ptr [bp-4]	;@07536
	mov	dx, word ptr [bp-2]	;@07539
	cmp	byte ptr ds:[17h], 1	;@0753C
	je	@@5	;@07541
	cmp	word ptr ds:[418h], -1	;@07543
	je	@@5	;@07548
	add	ax, word ptr ds:[666h]	;@0754A
	adc	dx, word ptr ds:[668h]	;@0754E
	add	ax, 10h	;@07552
	adc	dx, 0	;@07555
@@5:	mov	word ptr [si+20h], ax	;@07558
	mov	word ptr [si+22h], dx	;@0755B
	cmp	byte ptr ds:[14h], 0	;@0755E
	jne	@@6	;@07563
	cmp	byte ptr ds:[17h], 0	;@07565
	jne	@@8	;@0756A
	xor	cx, cx	;@0756C
	cmp	byte ptr ds:[14h], 0	;@0756E
	je	@@7	;@07573
@@6:	mov	cx, 30h	;@07575
	add	cx, word ptr ds:[506h]	;@07578
@@7:	call	L08B1D	;@0757C
@@8:	cmp	byte ptr ds:[17h], 0	;@0757F
	je	@@9	;@07584
	cmp	byte ptr ds:[14h], 0	;@07586
	je	@@9	;@0758B
	mov	di, 709h	;@0758D
	push	di	;@07590
	push	ds	;@07591
	pop	es	;@07592
	mov	ax, 424Eh	;@07593
	stosw	;@07596
	mov	ax, 3230h	;@07597
	stosw	;@0759A
	mov	ax, 1000h	;@0759B
	mul	word ptr ds:[482h]	;@0759E
	add	ax, word ptr ds:[484h]	;@075A2
	adc	dx, 0	;@075A6
	push	dx	;@075A9
	push	ax	;@075AA
	sub	ax, word ptr [bp-4]	;@075AB
	sbb	dx, word ptr [bp-2]	;@075AE
	add	ax, 10h	;@075B1
	adc	dx, 0	;@075B4
	add	ax, 8	;@075B7
	adc	dx, 0	;@075BA
	stosw	;@075BD
	mov	ax, dx	;@075BE
	stosw	;@075C0
	pop	ax	;@075C1
	pop	dx	;@075C2
	pop	si	;@075C3
	mov	cx, 8	;@075C4
	call	L08B1D	;@075C7
@@9:	xor	dx, dx	;@075CA
	mov	sp, bp	;@075CC
	pop	bp	;@075CE
	ret	;@075CF
L075D0:	xor	ax, ax	;@075D0
	push	ax	;@075D2
	mov	ax, 32h	;@075D3
	push	ax	;@075D6
	call WARNING	;@075D7
	ret	;@075DA
L075DB:	mov	ax, word ptr ds:[482h]	;@075DB
	inc	ax	;@075DE
	jne	@@1	;@075DF
	mov	ax, 10h	;@075E1
	mul	word ptr ds:[4A2h]	;@075E4
	push	ax	;@075E8
	and	ax, 1FFFh	;@075E9
	mov	word ptr ds:[484h], ax	;@075EC
	pop	ax	;@075EF
	mov	cl, 0Dh	;@075F0
	shr	ax, cl	;@075F2
	shl	ax, 1	;@075F4
	mov	word ptr ds:[482h], ax	;@075F6
@@1:	mov	ax, word ptr ds:[418h]	;@075F9
	cmp	ax, 0FFFFh	;@075FC
	je	@@2	;@075FF
	mov	dx, 10h	;@07601
	mul	dx	;@07604
	mov	word ptr ds:[3DCh], ax	;@07606
	mov	word ptr ds:[3DEh], dx	;@07609
	jmp	short @@3	;@0760D
@@2:	cmp	byte ptr ds:[14h], 0	;@0760F
	je	@@4	;@07614
@@3:	mov	ax, word ptr ds:[4A2h]	;@07616
	call	L074A5	;@07619
	jmp	short @@5	;@0761C
@@4:	mov	ax, 1000h	;@0761E
	mul	word ptr ds:[482h]	;@07621
	add	ax, word ptr ds:[484h]	;@07625
	adc	dx, 0	;@07629
	call L09792	;@0762C
	mov	bx, word ptr ds:[4A2h]	;@0762F
	mov	cl, 4	;@07633
	shl	bx, cl	;@07635
	sub	ax, bx	;@07637
	sbb	dx, 0	;@07639
	mov	cx, word ptr ds:[3DEh]	;@0763C
	mov	bx, word ptr ds:[3DCh]	;@07640
	add	bx, 0Fh	;@07644
	adc	cx, 0	;@07647
	sub	bx, ax	;@0764A
	sbb	cx, dx	;@0764C
	shr	cx, 1	;@0764E
	rcr	bx, 1	;@07650
	shr	cx, 1	;@07652
	rcr	bx, 1	;@07654
	shr	cx, 1	;@07656
	rcr	bx, 1	;@07658
	shr	cx, 1	;@0765A
	rcr	bx, 1	;@0765C
	mov	dx, bx	;@0765E
@@5:	mov	word ptr ds:[4A4h], dx	;@07660
	mov	word ptr ds:[4A6h], 0FFFFh	;@07664
	mov	word ptr ds:[4B4h], 0	;@0766A
	mov	word ptr ds:[4B6h], 1	;@07670
	cmp	word ptr ds:[4B0h], -1	;@07676
	jne	@@6	;@0767B
	mov	word ptr ds:[4B0h], 0	;@0767D
	mov	word ptr ds:[4AEh], 0	;@07683
@@6:	mov	word ptr ds:[49Ah], 5A4Dh	;@07689
	mov	word ptr ds:[4B8h], 30FBh	;@0768F
	mov	word ptr ds:[4BAh], 726Ah	;@07695
	sub	ax, ax	;@0769B
	cwd	;@0769D
	mov	cx, 3Eh	;@0769E
	mov	si, 49Ah	;@076A1
	call	L08B1D	;@076A4
	mov	di, word ptr ds:[7641h]	;@076A7
	call PUT_INLINE	;@076AB
	db	17h, 'Program entry point at '	;@076AE
	mov	ax, word ptr ds:[4B0h]	;@076C6
	call PUT_HEX_WORD	;@076C9
	mov	al, 3Ah	;@076CC
	call PUT_CHAR	;@076CE
	mov	ax, word ptr ds:[4AEh]	;@076D1
	call PUT_HEX_WORD	;@076D4
	call PUT_NEWLINE	;@076D7
	mov	word ptr ds:[7641h], di	;@076DA
	cmp	byte ptr ds:[3D3h], 1	;@076DE
	je	@@7	;@076E3
	cmp	byte ptr ds:[12Ah], 1	;@076E5
	je	@@7	;@076EA
	call	L075D0	;@076EC
@@7:	ret	;@076EF
L076F0:	mov	word ptr ds:[414h], 0	;@076F0
	mov	word ptr ds:[416h], 0	;@076F6
	mov	bx, word ptr ds:[408h]	;@076FC
	cmp	bx, -1	;@07700
	jne	@@1	;@07703
	jmp	@@7	;@07705
@@1:	mov	es, word ptr ds:[776h]	;@07708
	cmp	byte ptr es:[bx+9], 0FFh	;@0770C
	jne	@@2	;@07711
	jmp	@@7	;@07713
@@2:	mov	si, word ptr es:[bx+4]	;@07716
	mov	dx, word ptr es:[bx+6]	;@0771A
	mov	es, word ptr ds:[77Eh]	;@0771E
	mov	bx, word ptr es:[bx]	;@07722
	push	dx	;@07725
	test	word ptr ds:[47Ah], 3	;@07726
	je	@@4	;@0772C
	mov	word ptr ds:[414h], 1	;@0772E
	mov	ax, word ptr ds:[6B9h]	;@07734
	push	bx	;@07737
	mov	es, word ptr ds:[79Eh]	;@07738
	mov	bx, word ptr ds:[404h]	;@0773C
	cmp	bx, -1	;@07740
	je	@@3	;@07743
	mov	ax, word ptr es:[bx+6]	;@07745
	dec	ax	;@07749
@@3:	pop	bx	;@0774A
	add	word ptr es:[bx+11h], ax	;@0774B
	push	si	;@0774F
	and	si, 3	;@07750
	shl	si, 1	;@07753
	shl	si, 1	;@07755
	shl	si, 1	;@07757
	mov	es, word ptr [si+736h]	;@07759
	pop	si	;@0775D
	add	word ptr es:[si+0Eh], ax	;@0775E
	add	word ptr ds:[4A0h], ax	;@07762
	shl	ax, 1	;@07766
	shl	ax, 1	;@07768
	shl	ax, 1	;@0776A
	add	dx, ax	;@0776C
	test	word ptr ds:[47Ah], 2	;@0776E
	je	@@4	;@07774
	mov	di, word ptr ds:[45Ah]	;@07776
	call	@@8	;@0777A
@@4:	test	word ptr ds:[47Ah], 4	;@0777D
	je	@@5	;@07783
	mov	word ptr ds:[416h], 1	;@07785
	mov	di, word ptr ds:[45Ch]	;@0778B
	call	@@8	;@0778F
@@5:	add	dx, 0Ch	;@07792
	test	word ptr ds:[47Ah], 8	;@07795
	je	@@6	;@0779B
	mov	di, word ptr ds:[45Eh]	;@0779D
	call	@@8	;@077A1
@@6:	add	dx, 4	;@077A4
	mov	es, word ptr ds:[79Eh]	;@077A7
	pop	ax	;@077AB
	sub	ax, dx	;@077AC
	sub	word ptr es:[bx+0Dh], ax	;@077AE
	mov	bx, word ptr ds:[408h]	;@077B2
	mov	es, word ptr ds:[776h]	;@077B6
	mov	word ptr es:[bx+6], dx	;@077BA
@@7:	ret	;@077BE
@@8:	push	di	;@077BF
	and	di, 3	;@077C0
	shl	di, 1	;@077C3
	shl	di, 1	;@077C5
	shl	di, 1	;@077C7
	mov	es, word ptr [di+756h]	;@077C9
	pop	di	;@077CD
	mov	word ptr es:[di+4], dx	;@077CE
	ret	;@077D2
L077D3:	mov	si, 582Ah	;@077D3
	mov	ah, 0	;@077D6
	mov	word ptr ds:[3450h], cs	;@077D8
	call	L0921C	;@077DC
	mov	ds, word ptr cs:DATA_SEGMENT	;@077DF
	jb	@@1	;@077E4
	push	bx	;@077E6
	and	bx, 3	;@077E7
	shl	bx, 1	;@077EA
	shl	bx, 1	;@077EC
	shl	bx, 1	;@077EE
	mov	es, word ptr [bx+756h]	;@077F0
	pop	bx	;@077F4
	test	byte ptr es:[bx+0Eh], 10h	;@077F5
	je	@@3	;@077FA
@@1:	mov	word ptr ds:[476h], 0FFFFh	;@077FC
	mov	word ptr ds:[478h], 0FFFFh	;@07802
	cmp	word ptr ds:[404h], -1	;@07808
	je	@@2	;@0780D
	xor	cx, cx	;@0780F
	push	cx	;@07811
	mov	ax, 37h	;@07812
	push	ax	;@07815
	call WARNING	;@07816
@@2:	stc	;@07819
	ret	;@0781A
@@3:	mov	ax, word ptr es:[bx+4]	;@0781B
	mov	word ptr ds:[478h], ax	;@0781F
	mov	bx, word ptr es:[bx]	;@07822
	mov	es, word ptr ds:[77Eh]	;@07825
	mov	bx, word ptr es:[bx]	;@07829
	mov	es, word ptr ds:[79Eh]	;@0782C
	mov	ax, word ptr es:[bx+8]	;@07830
	mov	word ptr ds:[476h], ax	;@07834
	clc	;@07837
	ret	;@07838
L07839:	push	cx	;@07839
	push	di	;@0783A
	mov	di, si	;@0783B
	sub	ax, ax	;@0783D
	cwd	;@0783F
	jmp	short @@4	;@07840
@@1:	mov	es, word ptr ds:[776h]	;@07842
	mov	cl, byte ptr es:[di+9]	;@07846
	and	cl, 1Ch	;@0784A
	cmp	cl, 8	;@0784D
	je	@@4	;@07850
	jb	@@2	;@07852
	cmp	cl, 18h	;@07854
	jae	@@2	;@07857
	add	ax, word ptr es:[di+6]	;@07859
	adc	dl, byte ptr es:[di+8]	;@0785D
	jmp	short @@5	;@07861
@@2:	cmp	dl, byte ptr es:[di+8]	;@07863
	ja	@@5	;@07867
	jb	@@3	;@07869
	cmp	ax, word ptr es:[di+6]	;@0786B
	jae	@@5	;@0786F
@@3:	mov	dl, byte ptr es:[di+8]	;@07871
	mov	ax, word ptr es:[di+6]	;@07875
	jmp	short @@5	;@07879
@@4:	mov	es, word ptr ds:[77Eh]	;@0787B
	mov	ax, word ptr es:[di+6]	;@0787F
	mov	es, word ptr ds:[776h]	;@07883
	add	ax, word ptr es:[di+6]	;@07887
	mov	dl, byte ptr es:[di+8]	;@0788B
	mov	es, word ptr ds:[77Eh]	;@0788F
	adc	dl, byte ptr es:[di+8]	;@07893
@@5:	add	bx, 2	;@07897
	cmp	bx, word ptr ds:[7BCh]	;@0789A
	jae	@@6	;@0789E
	mov	es, word ptr ds:[7BEh]	;@078A0
	mov	di, word ptr es:[bx]	;@078A4
	mov	es, word ptr ds:[77Eh]	;@078A7
	cmp	si, word ptr es:[di+2]	;@078AB
	je	@@1	;@078AF
@@6:	pop	di	;@078B1
	pop	cx	;@078B2
	ret	;@078B3
L078B4:	push	bp	;@078B4
	mov	bp, sp	;@078B5
	sub	sp, 1Ah	;@078B7
	push	ax	;@078BA
	push	bx	;@078BB
	push	cx	;@078BC
	push	di	;@078BD
	push	si	;@078BE
	mov	bx, di	;@078BF
	mov	es, word ptr ds:[776h]	;@078C1
	mov	al, byte ptr es:[si+9]	;@078C5
	mov	byte ptr [bp-18h], al	;@078C9
	mov	ax, word ptr es:[si]	;@078CC
	mov	word ptr [bp-2], ax	;@078CF
	mov	ax, word ptr es:[si+2]	;@078D2
	mov	word ptr [bp-4], ax	;@078D6
	mov	ax, word ptr es:[si+4]	;@078D9
	mov	word ptr [bp-6], ax	;@078DD
	mov	ax, word ptr es:[si+6]	;@078E0
	mov	word ptr [bp-16h], ax	;@078E4
	mov	al, byte ptr es:[si+8]	;@078E7
	mov	byte ptr [bp-1Ah], al	;@078EB
	mov	es, word ptr ds:[77Eh]	;@078EE
	mov	ax, word ptr es:[si+6]	;@078F2
	mov	word ptr [bp-0Ah], ax	;@078F6
	mov	al, byte ptr es:[si+8]	;@078F9
	mov	ah, 0	;@078FD
	mov	word ptr [bp-0Ch], ax	;@078FF
	mov	di, word ptr es:[si]	;@07902
	mov	es, word ptr ds:[776h]	;@07905
	test	byte ptr es:[si+9], 0E0h	;@07909
	jne	@@1	;@0790E
	mov	word ptr [bp-14h], 0FFFFh	;@07910
	mov	word ptr [bp-8], di	;@07915
	jmp	short @@3	;@07918
@@1:	mov	es, word ptr ds:[79Eh]	;@0791A
	mov	ax, word ptr es:[di+2]	;@0791E
	mov	word ptr [bp-14h], ax	;@07922
	mov	ax, word ptr es:[di+8]	;@07925
	cmp	byte ptr ds:[17h], 1	;@07929
	jne	@@2	;@0792E
	mov	ax, word ptr es:[di+6]	;@07930
@@2:	mov	word ptr [bp-8], ax	;@07934
@@3:	mov	di, word ptr ds:[7641h]	;@07937
	mov	al, 20h	;@0793B
	call PUT_CHAR	;@0793D
	cmp	word ptr [bp+4], 1	;@07940
	je	@@6	;@07944
	call	L07839	;@07946
	mov	word ptr [bp-0Eh], ax	;@07949
	mov	word ptr [bp-10h], dx	;@0794C
	cmp	byte ptr ds:[17h], 1	;@0794F
	je	@@7	;@07954
	mov	bx, word ptr [bp-8]	;@07956
	mov	cl, 4	;@07959
	mov	ax, word ptr [bp-0Ah]	;@0795B
	mov	dx, word ptr [bp-0Ch]	;@0795E
	call	L0931E	;@07961
	mov	ax, word ptr [bp-0Eh]	;@07964
	mov	dx, word ptr [bp-10h]	;@07967
	cmp	dx, word ptr [bp-0Ch]	;@0796A
	ja	@@4	;@0796D
	cmp	ax, word ptr [bp-0Ah]	;@0796F
	jbe	@@5	;@07972
@@4:	sub	ax, 1	;@07974
	sbb	dx, 0	;@07977
@@5:	call	L0931E	;@0797A
	mov	ax, word ptr [bp-0Eh]	;@0797D
	mov	dx, word ptr [bp-10h]	;@07980
	sub	ax, word ptr [bp-0Ah]	;@07983
	sbb	dx, word ptr [bp-0Ch]	;@07986
	sub	bx, bx	;@07989
	call	L0931E	;@0798B
	jmp	short @@8	;@0798E
@@6:	jmp	short @@9	;@07990
@@7:	mov	al, 20h	;@07992
	call PUT_CHAR	;@07994
	mov	ax, word ptr [bp-8]	;@07997
	call PUT_HEX_WORD	;@0799A
	call PUT_INLINE	;@0799D
	db	1, 3Ah	;@079A0
	mov	ax, word ptr [bp-0Ah]	;@079A2
	call PUT_HEX_WORD	;@079A5
	call PUT_INLINE	;@079A8
	db	4, '    '	;@079AB
	mov	ax, word ptr [bp-0Eh]	;@079B0
	sub	ax, word ptr [bp-0Ah]	;@079B3
	call PUT_HEX_WORD	;@079B6
	call PUT_INLINE	;@079B9
	db	3, 'H  '	;@079BC
@@8:	mov	si, word ptr [bp-2]	;@079C0
	mov	cx, 12h	;@079C3
	call	L0933D	;@079C6
	mov	si, word ptr [bp-4]	;@079C9
	call PUT_PLAIN_NAME	;@079CC
	jmp	@@15	;@079CF
@@9:	mov	ax, word ptr [bp-8]	;@079D2
	call PUT_HEX_WORD	;@079D5
	mov	al, 3Ah	;@079D8
	call PUT_CHAR	;@079DA
	mov	ax, word ptr [bp-0Ah]	;@079DD
	call PUT_HEX_WORD	;@079E0
	mov	al, 20h	;@079E3
	call PUT_CHAR	;@079E5
	xor	ax, ax	;@079E8
	mov	al, byte ptr [bp-1Ah]	;@079EA
	cmp	al, 0	;@079ED
	je	@@10	;@079EF
	call PUT_HEX_WORD	;@079F1
@@10:	mov	ax, word ptr [bp-16h]	;@079F4
	call PUT_HEX_WORD	;@079F7
	call PUT_INLINE	;@079FA
	db	3, ' C='	;@079FD
	mov	si, word ptr [bp-4]	;@07A01
	mov	cx, 6	;@07A04
	call	L0933D	;@07A07
	call PUT_INLINE	;@07A0A
	db	2, 53h, 3Dh	;@07A0D
	mov	si, word ptr [bp-2]	;@07A10
	mov	cx, 0Eh	;@07A13
	call	L0933D	;@07A16
	call PUT_INLINE	;@07A19
	db	2, 47h, 3Dh	;@07A1C
	test	byte ptr [bp-18h], 0E0h	;@07A1F
	je	@@11	;@07A23
	mov	si, word ptr [bp-14h]	;@07A25
	mov	cx, 7	;@07A28
	call	L0933D	;@07A2B
	jmp	short @@12	;@07A2E
@@11:	call PUT_INLINE	;@07A30
	db	7, '<none> '	;@07A33
@@12:	call PUT_INLINE	;@07A3B
	db	2, 4Dh, 3Dh	;@07A3E
	mov	si, word ptr [bp-6]	;@07A41
	cmp	si, -1	;@07A44
	jne	@@13	;@07A47
	call PUT_INLINE	;@07A49
	db	0Ah, '<none>    '	;@07A4C
	jmp	short @@14	;@07A57
@@13:	push	si	;@07A59
	and	si, 3	;@07A5A
	shl	si, 1	;@07A5D
	shl	si, 1	;@07A5F
	shl	si, 1	;@07A61
	mov	es, word ptr [si+736h]	;@07A63
	pop	si	;@07A67
	mov	si, word ptr es:[si]	;@07A68
	mov	cx, 0Ah	;@07A6B
	call	L0933D	;@07A6E
@@14:	call PUT_INLINE	;@07A71
	db	5, 'ACBP='	;@07A74
	mov	al, byte ptr [bp-18h]	;@07A7A
	call PUT_HEX_BYTE	;@07A7D
@@15:	call PUT_NEWLINE	;@07A80
	mov	word ptr ds:[7641h], di	;@07A83
	pop	si	;@07A87
	pop	di	;@07A88
	pop	cx	;@07A89
	pop	bx	;@07A8A
	pop	ax	;@07A8B
	mov	sp, bp	;@07A8C
	pop	bp	;@07A8E
	ret	2	;@07A8F
L07A92:	push	bp	;@07A92
	mov	bp, sp	;@07A93
	sub	sp, 2	;@07A95
	mov	word ptr [bp-2], ax	;@07A98
	push	si	;@07A9B
	push	di	;@07A9C
	mov	di, word ptr ds:[7641h]	;@07A9D
	call PUT_NEWLINE	;@07AA1
	cmp	word ptr [bp-2], 0	;@07AA4
	je	@@1	;@07AA8
	call PUT_INLINE	;@07AAA
	db	18h, 'Detailed map of segments'	;@07AAD
	jmp	short @@3	;@07AC6
@@1:	cmp	byte ptr ds:[17h], 0	;@07AC8
	je	@@2	;@07ACD
	call PUT_INLINE	;@07ACF
	db	'. Start         Length Name               Class'	;@07AD2
	jmp	short @@3	;@07B01
@@2:	call PUT_INLINE	;@07B03
	db	'. Start  Stop   Length Name               Class'	;@07B06
@@3:	call PUT_NEWLINE	;@07B35
	call PUT_NEWLINE	;@07B38
	mov	word ptr ds:[7641h], di	;@07B3B
	sub	di, di	;@07B3F
@@4:	cmp	di, word ptr ds:[7BCh]	;@07B41
	jae	@@7	;@07B45
	mov	es, word ptr ds:[7BEh]	;@07B47
	mov	si, word ptr es:[di]	;@07B4B
	mov	es, word ptr ds:[77Eh]	;@07B4E
	mov	ax, word ptr es:[si+2]	;@07B52
	cmp	ax, 0FFFFh	;@07B56
	je	@@6	;@07B59
	cmp	word ptr [bp-2], 1	;@07B5B
	je	@@5	;@07B5F
	mov	es, word ptr ds:[776h]	;@07B61
	test	byte ptr es:[si+9], 0E0h	;@07B65
	je	@@6	;@07B6A
	cmp	ax, si	;@07B6C
	jne	@@6	;@07B6E
@@5:	push	word ptr [bp-2]	;@07B70
	call	L078B4	;@07B73
@@6:	add	di, 2	;@07B76
	jmp	@@4	;@07B79
@@7:	pop	di	;@07B7B
	pop	si	;@07B7C
	mov	sp, bp	;@07B7D
	pop	bp	;@07B7F
	ret	;@07B80
L07B81:	push	si	;@07B81
	and	si, 3	;@07B82
	shl	si, 1	;@07B85
	shl	si, 1	;@07B87
	shl	si, 1	;@07B89
	mov	es, word ptr [si+756h]	;@07B8B
	pop	si	;@07B8F
	mov	ax, word ptr es:[si+4]	;@07B90
	mov	dl, byte ptr es:[si+0Eh]	;@07B94
	mov	si, word ptr es:[si]	;@07B98
	push	di	;@07B9B
	and	di, 3	;@07B9C
	shl	di, 1	;@07B9F
	shl	di, 1	;@07BA1
	shl	di, 1	;@07BA3
	mov	es, word ptr [di+756h]	;@07BA5
	pop	di	;@07BA9
	mov	bx, word ptr es:[di+4]	;@07BAA
	mov	dh, byte ptr es:[di+0Eh]	;@07BAE
	mov	di, word ptr es:[di]	;@07BB2
	mov	es, word ptr ds:[77Eh]	;@07BB5
	and	dx, 202h	;@07BB9
	jne	@@3	;@07BBD
	cmp	word ptr es:[si+4], -1	;@07BBF
	je	@@1	;@07BC4
	or	dl, 1	;@07BC6
	mov	si, word ptr es:[si+4]	;@07BC9
@@1:	mov	si, word ptr es:[si]	;@07BCD
	cmp	word ptr es:[di+4], -1	;@07BD0
	je	@@2	;@07BD5
	or	dh, 1	;@07BD7
	mov	di, word ptr es:[di+4]	;@07BDA
@@2:	mov	di, word ptr es:[di]	;@07BDE
	mov	es, word ptr ds:[79Eh]	;@07BE1
@@3:	ret	;@07BE5
L07BE6:	push	ax	;@07BE6
	push	bx	;@07BE7
	push	cx	;@07BE8
	push	dx	;@07BE9
	push	di	;@07BEA
	push	si	;@07BEB
	call	L07B81	;@07BEC
	test	dx, 202h	;@07BEF
	jne	@@4	;@07BF3
	mov	si, word ptr es:[si+8]	;@07BF5
	mov	di, word ptr es:[di+8]	;@07BF9
	test	dx, 101h	;@07BFD
	je	@@1	;@07C01
	cmp	si, di	;@07C03
	jne	@@3	;@07C05
	jmp	short @@2	;@07C07
@@1:	cmp	si, di	;@07C09
	je	@@2	;@07C0B
	mov	cl, 4	;@07C0D
	rol	si, cl	;@07C0F
	rol	di, cl	;@07C11
	mov	cx, 0Fh	;@07C13
	and	cx, si	;@07C16
	xor	si, cx	;@07C18
	add	ax, si	;@07C1A
	adc	cl, ch	;@07C1C
	mov	dx, 0Fh	;@07C1E
	and	dx, di	;@07C21
	xor	di, dx	;@07C23
	add	bx, di	;@07C25
	adc	dl, dh	;@07C27
	cmp	cx, dx	;@07C29
	jne	@@3	;@07C2B
@@2:	cmp	ax, bx	;@07C2D
	je	@@5	;@07C2F
@@3:	lahf	;@07C31
	mov	es, word ptr ds:[7BEh]	;@07C32
	sahf	;@07C36
	pop	si	;@07C37
	pop	di	;@07C38
	pop	dx	;@07C39
	pop	cx	;@07C3A
	pop	bx	;@07C3B
	pop	ax	;@07C3C
	ret	;@07C3D
@@4:	and	dx, 202h	;@07C3E
	cmp	dl, dh	;@07C42
	jne	@@3	;@07C44
	jmp	@@2	;@07C46
@@5:	pop	si	;@07C48
	pop	di	;@07C49
	push	di	;@07C4A
	push	si	;@07C4B
	cmp	si, di	;@07C4C
	jmp	@@3	;@07C4E
L07C50:	push	ax	;@07C50
	push	bx	;@07C51
	push	cx	;@07C52
	push	dx	;@07C53
	push	di	;@07C54
	push	si	;@07C55
	call	L07B81	;@07C56
	and	dx, 202h	;@07C59
	jne	@@3	;@07C5D
	mov	cx, word ptr es:[si+6]	;@07C5F
	cmp	cx, word ptr es:[di+6]	;@07C63
	jne	@@2	;@07C67
@@1:	cmp	ax, bx	;@07C69
	je	@@4	;@07C6B
@@2:	lahf	;@07C6D
	mov	es, word ptr ds:[7BEh]	;@07C6E
	sahf	;@07C72
	pop	si	;@07C73
	pop	di	;@07C74
	pop	dx	;@07C75
	pop	cx	;@07C76
	pop	bx	;@07C77
	pop	ax	;@07C78
	ret	;@07C79
@@3:	cmp	dh, dl	;@07C7A
	jne	@@2	;@07C7C
	jmp	@@1	;@07C7E
@@4:	pop	si	;@07C80
	pop	di	;@07C81
	push	di	;@07C82
	push	si	;@07C83
	cmp	si, di	;@07C84
	jmp	@@2	;@07C86
L07C88:	push	ax	;@07C88
	push	bx	;@07C89
	push	cx	;@07C8A
	push	dx	;@07C8B
	push	di	;@07C8C
	push	si	;@07C8D
	push	si	;@07C8E
	and	si, 3	;@07C8F
	shl	si, 1	;@07C92
	shl	si, 1	;@07C94
	shl	si, 1	;@07C96
	mov	es, word ptr [si+756h]	;@07C98
	pop	si	;@07C9C
	push	word ptr es:[si+6]	;@07C9D
	push	word ptr es:[si+4]	;@07CA1
	mov	dl, byte ptr es:[si+0Eh]	;@07CA5
	mov	si, word ptr es:[si]	;@07CA9
	push	di	;@07CAC
	and	di, 3	;@07CAD
	shl	di, 1	;@07CB0
	shl	di, 1	;@07CB2
	shl	di, 1	;@07CB4
	mov	es, word ptr [di+756h]	;@07CB6
	pop	di	;@07CBA
	mov	ax, word ptr es:[di+4]	;@07CBB
	mov	bx, word ptr es:[di+6]	;@07CBF
	mov	dh, byte ptr es:[di+0Eh]	;@07CC3
	mov	di, word ptr es:[di]	;@07CC7
	and	dx, 202h	;@07CCA
	cmp	dx, 202h	;@07CCE
	je	@@5	;@07CD2
	mov	es, word ptr ds:[77Eh]	;@07CD4
	or	dl, dl	;@07CD8
	jne	@@1	;@07CDA
	mov	si, word ptr es:[si]	;@07CDC
@@1:	or	dh, dh	;@07CDF
	jne	@@2	;@07CE1
	mov	di, word ptr es:[di]	;@07CE3
@@2:	mov	es, word ptr ds:[79Eh]	;@07CE6
	sub	cx, cx	;@07CEA
	or	dl, dl	;@07CEC
	jne	@@3	;@07CEE
	mov	cx, word ptr es:[si+6]	;@07CF0
@@3:	or	dh, dh	;@07CF4
	mov	dx, 0	;@07CF6
	jne	@@4	;@07CF9
	mov	dx, word ptr es:[di+6]	;@07CFB
@@4:	cmp	cx, dx	;@07CFF
@@5:	pop	cx	;@07D01
	pop	dx	;@07D02
	jne	@@6	;@07D03
	cmp	bx, dx	;@07D05
	jne	@@6	;@07D07
	cmp	ax, cx	;@07D09
	je	@@7	;@07D0B
@@6:	lahf	;@07D0D
	mov	es, word ptr ds:[7BEh]	;@07D0E
	sahf	;@07D12
	pop	si	;@07D13
	pop	di	;@07D14
	pop	dx	;@07D15
	pop	cx	;@07D16
	pop	bx	;@07D17
	pop	ax	;@07D18
	ret	;@07D19
@@7:	pop	si	;@07D1A
	pop	di	;@07D1B
	push	di	;@07D1C
	push	si	;@07D1D
	cmp	si, di	;@07D1E
	jmp	@@6	;@07D20
L07D22:	push	ax	;@07D22
	push	bx	;@07D23
	push	cx	;@07D24
	push	di	;@07D25
	push	si	;@07D26
	push	ds	;@07D27
	push	di	;@07D28
	and	di, 3	;@07D29
	shl	di, 1	;@07D2C
	shl	di, 1	;@07D2E
	shl	di, 1	;@07D30
	mov	es, word ptr [di+756h]	;@07D32
	pop	di	;@07D36
	mov	di, word ptr es:[di+0Ch]	;@07D37
	push	si	;@07D3B
	and	si, 3	;@07D3C
	shl	si, 1	;@07D3F
	shl	si, 1	;@07D41
	shl	si, 1	;@07D43
	mov	es, word ptr [si+756h]	;@07D45
	pop	si	;@07D49
	mov	si, word ptr es:[si+0Ch]	;@07D4A
	push	di	;@07D4E
	and	di, 3	;@07D4F
	shl	di, 1	;@07D52
	shl	di, 1	;@07D54
	shl	di, 1	;@07D56
	mov	es, word ptr [di+716h]	;@07D58
	pop	di	;@07D5C
	inc	di	;@07D5D
	inc	di	;@07D5E
	push	si	;@07D5F
	and	si, 3	;@07D60
	shl	si, 1	;@07D63
	shl	si, 1	;@07D65
	shl	si, 1	;@07D67
	mov	ds, word ptr [si+716h]	;@07D69
	pop	si	;@07D6D
	inc	si	;@07D6E
	inc	si	;@07D6F
	lodsb	;@07D70
	cmp	al, byte ptr es:[di]	;@07D71
	lahf	;@07D74
	jbe	@@1	;@07D75
	mov	al, byte ptr es:[di]	;@07D77
@@1:	inc	di	;@07D7A
	mov	cl, al	;@07D7B
	xor	ch, ch	;@07D7D
@@2:	lodsb	;@07D7F
	mov	bl, byte ptr es:[di]	;@07D80
	inc	di	;@07D83
	or	al, 20h	;@07D84
	or	bl, 20h	;@07D86
	cmp	al, bl	;@07D89
	jne	@@3	;@07D8B
	loop	@@2	;@07D8D
	sahf	;@07D8F
@@3:	pop	ds	;@07D90
	lahf	;@07D91
	mov	es, word ptr ds:[7BEh]	;@07D92
	sahf	;@07D96
	pop	si	;@07D97
	pop	di	;@07D98
	pop	cx	;@07D99
	pop	bx	;@07D9A
	pop	ax	;@07D9B
	ret	;@07D9C
L07D9D:	push	si	;@07D9D
	push	di	;@07D9E
	mov	word ptr ds:[7BCh], 0	;@07D9F
	sub	si, si	;@07DA5
	push	si	;@07DA7
	mov	bx, 752h	;@07DA8
	jmp	short @@7	;@07DAB
@@1:	mov	bx, word ptr es:[si+2]	;@07DAD
	mov	es, word ptr ds:[806h]	;@07DB1
	cmp	word ptr es:[bx+6], 0	;@07DB5
	jne	@@4	;@07DBA
	jmp	short @@6	;@07DBC
@@2:	push	bx	;@07DBE
	push	si	;@07DBF
	and	si, 3	;@07DC0
	shl	si, 1	;@07DC3
	shl	si, 1	;@07DC5
	shl	si, 1	;@07DC7
	mov	es, word ptr [si+756h]	;@07DC9
	pop	si	;@07DCD
	cmp	byte ptr ds:[17h], 0	;@07DCE
	je	@@3	;@07DD3
	test	byte ptr es:[si+0Eh], 20h	;@07DD5
	jne	@@1	;@07DDA
@@3:	test	byte ptr es:[si+0Eh], 14h	;@07DDC
	jne	@@6	;@07DE1
	mov	bx, word ptr es:[si+2]	;@07DE3
	cmp	bx, -1	;@07DE7
	je	@@6	;@07DEA
	push	bx	;@07DEC
	and	bx, 3	;@07DED
	shl	bx, 1	;@07DF0
	shl	bx, 1	;@07DF2
	shl	bx, 1	;@07DF4
	mov	es, word ptr [bx+736h]	;@07DF6
	pop	bx	;@07DFA
	cmp	word ptr es:[bx+0Ah], 2	;@07DFB
	jb	@@6	;@07E00
@@4:	mov	di, 2	;@07E02
	push	di	;@07E05
	mov	di, 7BAh	;@07E06
	call	L054ED	;@07E09
	jae	@@5	;@07E0C
	call	TABLE_OVERFLOW	;@07E0E
@@5:	mov	word ptr es:[di], si	;@07E11
@@6:	pop	bx	;@07E14
	add	si, word ptr ds:[48Eh]	;@07E15
@@7:	cmp	si, word ptr [bx+2]	;@07E19
	jb	@@2	;@07E1C
	cmp	bx, 762h	;@07E1E
	ja	@@8	;@07E22
	add	bx, 8	;@07E24
	pop	si	;@07E27
	inc	si	;@07E28
	push	si	;@07E29
	jmp	@@7	;@07E2A
@@8:	pop	si	;@07E2C
	pop	di	;@07E2D
	pop	si	;@07E2E
	ret	;@07E2F
L07E30:	xor	ax, ax	;@07E30
	cwd	;@07E32
	test	byte ptr es:[si+0Eh], 20h	;@07E33
	je	@@1	;@07E38
	mov	cx, ax	;@07E3A
	mov	bx, ax	;@07E3C
	ret	;@07E3E
@@1:	push	si	;@07E3F
	mov	cx, word ptr es:[si+4]	;@07E40
	mov	bx, word ptr es:[si+6]	;@07E44
	mov	dl, byte ptr es:[si+0Eh]	;@07E48
	mov	si, word ptr es:[si]	;@07E4C
	test	dl, 2	;@07E4F
	jne	@@5	;@07E52
	mov	es, word ptr ds:[77Eh]	;@07E54
	cmp	word ptr es:[si+4], -1	;@07E58
	je	@@2	;@07E5D
	mov	si, word ptr es:[si+4]	;@07E5F
@@2:	mov	es, word ptr ds:[776h]	;@07E63
	mov	al, byte ptr es:[si+9]	;@07E67
	mov	es, word ptr ds:[77Eh]	;@07E6B
	mov	si, word ptr es:[si]	;@07E6F
	test	al, 0E0h	;@07E72
	je	@@4	;@07E74
	mov	es, word ptr ds:[79Eh]	;@07E76
	mov	ax, word ptr es:[si+8]	;@07E7A
	cmp	byte ptr ds:[17h], 0	;@07E7E
	je	@@3	;@07E83
	mov	ax, word ptr es:[si+6]	;@07E85
@@3:	pop	si	;@07E89
	ret	;@07E8A
@@4:	mov	dh, 1	;@07E8B
@@5:	mov	ax, si	;@07E8D
	jmp	@@3	;@07E8F
L07E91:	call	L07D9D	;@07E91
	mov	di, word ptr ds:[7641h]	;@07E94
	call PUT_INLINE	;@07E98
	db	'!  Address         Publics by Name'	;@07E9B
	mov	bp, offset L07D22	;@07EBD
	call	@@1	;@07EC0
	mov	di, word ptr ds:[7641h]	;@07EC3
	call PUT_INLINE	;@07EC7
	db	'"  Address         Publics by Value'	;@07ECA
	mov	bp, offset L07C50	;@07EED
	cmp	byte ptr ds:[125h], 0	;@07EF0
	je	@@1	;@07EF5
	mov	bp, offset L07C88	;@07EF7
	call	@@1	;@07EFA
	ret	;@07EFD
@@1:	push	di	;@07EFE
	mov	cx, word ptr ds:[7BCh]	;@07EFF
	mov	es, word ptr ds:[7BEh]	;@07F03
	call	L09252	;@07F07
	pop	di	;@07F0A
	call PUT_NEWLINE	;@07F0B
	call PUT_NEWLINE	;@07F0E
	sub	bx, bx	;@07F11
	jmp	short @@7	;@07F13
@@2:	mov	al, 20h	;@07F15
	call PUT_CHAR	;@07F17
	mov	es, word ptr ds:[7BEh]	;@07F1A
	mov	si, word ptr es:[bx]	;@07F1E
	push	bx	;@07F21
	push	si	;@07F22
	and	si, 3	;@07F23
	shl	si, 1	;@07F26
	shl	si, 1	;@07F28
	shl	si, 1	;@07F2A
	mov	es, word ptr [si+756h]	;@07F2C
	pop	si	;@07F30
	push	word ptr es:[si+0Ch]	;@07F31
	call	L07E30	;@07F35
	call PUT_HEX_WORD	;@07F38
	mov	al, 3Ah	;@07F3B
	call PUT_CHAR	;@07F3D
	cmp	byte ptr ds:[125h], 0	;@07F40
	je	@@3	;@07F45
	xchg	ax, bx	;@07F47
	call PUT_HEX_DIGIT	;@07F48
@@3:	xchg	ax, cx	;@07F4B
	call PUT_HEX_WORD	;@07F4C
	cmp	byte ptr ds:[13h], 1	;@07F4F
	jne	@@4	;@07F54
	test	dl, 1	;@07F56
	jne	@@4	;@07F59
	call PUT_INLINE	;@07F5B
	db	7, ' idle  '	;@07F5E
	jmp	short @@6	;@07F66
@@4:	test	dl, 2	;@07F68
	jne	@@5	;@07F6B
	call PUT_INLINE	;@07F6D
	db	7, '       '	;@07F70
	jmp	short @@6	;@07F78
@@5:	call PUT_INLINE	;@07F7A
	db	7, '  Abs  '	;@07F7D
@@6:	pop	si	;@07F85
	call PUT_SYMBOL_NAME	;@07F86
	call PUT_NEWLINE	;@07F89
	pop	bx	;@07F8C
	add	bx, 2	;@07F8D
@@7:	cmp	bx, word ptr ds:[7BCh]	;@07F90
	jae	@@8	;@07F94
	jmp	@@2	;@07F96
@@8:	call PUT_NEWLINE	;@07F99
	mov	word ptr ds:[7641h], di	;@07F9C
	ret	;@07FA0
L07FA1:	push	si	;@07FA1
	push	di	;@07FA2
	push	ax	;@07FA3
	push	bx	;@07FA4
	push	cx	;@07FA5
	push	dx	;@07FA6
	mov	cl, 3	;@07FA7
	dec	ax	;@07FA9
	shl	ax, cl	;@07FAA
	mov	es, word ptr ds:[77Eh]	;@07FAC
	mov	bx, word ptr ds:[408h]	;@07FB0
	mov	dx, word ptr es:[bx+6]	;@07FB4
	mov	cl, 4	;@07FB8
	shr	dx, cl	;@07FBA
	mov	bx, word ptr es:[bx]	;@07FBC
	mov	es, word ptr ds:[79Eh]	;@07FBF
	add	dx, word ptr es:[bx+8]	;@07FC3
	mov	word ptr ds:[496h], ax	;@07FC7
	mov	word ptr ds:[498h], dx	;@07FCA
	xchg	ax, cx	;@07FCE
	add	dx, word ptr ds:[3FEh]	;@07FCF
	mov	ax, 8	;@07FD3
	mov	si, 695h	;@07FD6
	call	L08A4F	;@07FD9
	inc	word ptr ds:[4A0h]	;@07FDC
	mov	ax, word ptr ds:[3F2h]	;@07FE0
	mov	dx, word ptr ds:[3F4h]	;@07FE3
	mov	cx, 4	;@07FE7
	add	word ptr ds:[3F2h], cx	;@07FEA
	adc	word ptr ds:[3F4h], 0	;@07FEE
	mov	si, 496h	;@07FF3
	call	L08B1D	;@07FF6
	pop	dx	;@07FF9
	pop	cx	;@07FFA
	pop	bx	;@07FFB
	pop	ax	;@07FFC
	pop	di	;@07FFD
	pop	si	;@07FFE
	ret	;@07FFF
L08000:	push	si	;@08000
	push	di	;@08001
	mov	ax, word ptr es:[di+8]	;@08002
	mov	word ptr ds:[695h], ax	;@08006
	mov	ax, word ptr es:[di+0Bh]	;@08009
	mov	word ptr ds:[69Bh], ax	;@0800D
	mov	si, 0Fh	;@08010
	and	si, ax	;@08013
	add	si, word ptr es:[di+0Dh]	;@08015
	mov	word ptr ds:[697h], si	;@08019
	sub	dx, dx	;@0801D
	mov	cl, byte ptr es:[di+1]	;@0801F
	cmp	cl, 0FEh	;@08023
	jne	@@1	;@08026
	or	dx, 4	;@08028
@@1:	cmp	cl, 0	;@0802B
	jle	@@2	;@0802E
	or	dx, 1	;@08030
	cmp	cl, 2	;@08033
	jl	@@2	;@08036
	cmp	si, 20h	;@08038
	jb	@@2	;@0803B
	or	dx, 2	;@0803D
@@2:	mov	word ptr ds:[699h], dx	;@08040
	mov	ax, word ptr es:[di+6]	;@08044
	call	L07FA1	;@08048
	pop	di	;@0804B
	pop	si	;@0804C
	ret	;@0804D
L0804E:	mov	bx, word ptr ds:[45Ch]	;@0804E
	push	bx	;@08052
	and	bx, 3	;@08053
	shl	bx, 1	;@08056
	shl	bx, 1	;@08058
	shl	bx, 1	;@0805A
	mov	es, word ptr [bx+756h]	;@0805C
	pop	bx	;@08060
	mov	cx, word ptr es:[bx+4]	;@08061
	mov	si, word ptr ds:[408h]	;@08065
	mov	es, word ptr ds:[77Eh]	;@08069
	mov	si, word ptr es:[si]	;@0806D
	mov	es, word ptr ds:[79Eh]	;@08070
	mov	dx, word ptr es:[si+8]	;@08074
	add	dx, word ptr ds:[3FEh]	;@08078
	push	dx	;@0807C
	push	ds	;@0807D
	mov	si, word ptr ds:[138h]	;@0807E
	lds	bx, dword ptr ds:[132h]	;@08082
	mov	di, ds	;@08086
	mov	ds, word ptr [bx]	;@08088
	push	bx	;@0808A
	lea	si, [si+2]	;@0808B
	cld	;@0808E
@@1:	mov	bx, si	;@0808F
@@2:	lodsb	;@08091
	cmp	al, 5Ch	;@08092
	je	@@1	;@08094
	or	al, al	;@08096
	jne	@@2	;@08098
	mov	si, bx	;@0809A
	mov	ax, 0Ch	;@0809C
	pop	bx	;@0809F
	pop	ds	;@080A0
	call	L08A45	;@080A1
	test	word ptr ds:[47Ah], 8	;@080A4
	je	@@4	;@080AA
	mov	ah, 2Ah	;@080AC
	int	21h	;@080AE
	mov	word ptr ds:[40Ch], dx	;@080B0
	mov	word ptr ds:[40Eh], cx	;@080B4
	mov	bx, word ptr ds:[45Eh]	;@080B8
	push	bx	;@080BC
	and	bx, 3	;@080BD
	shl	bx, 1	;@080C0
	shl	bx, 1	;@080C2
	shl	bx, 1	;@080C4
	mov	es, word ptr [bx+756h]	;@080C6
	pop	bx	;@080CA
	mov	cx, word ptr es:[bx+4]	;@080CB
	pop	dx	;@080CF
	mov	ax, 4	;@080D0
	mov	si, 40Ch	;@080D3
	call	L08A4F	;@080D6
@@3:	ret	;@080D9
@@4:	add	sp, 2	;@080DA
	jmp	@@3	;@080DD
L080DF:	cmp	word ptr ds:[414h], 1	;@080DF
	je	@@1	;@080E4
	cmp	word ptr ds:[416h], 1	;@080E6
	je	@@4	;@080EB
	ret	;@080ED
@@1:	mov	bx, word ptr ds:[408h]	;@080EE
	mov	es, word ptr ds:[77Eh]	;@080F2
	mov	ax, word ptr es:[bx+6]	;@080F6
	mov	bx, word ptr es:[bx]	;@080FA
	mov	es, word ptr ds:[79Eh]	;@080FD
	mov	dx, word ptr es:[bx+8]	;@08101
	mov	cl, 4	;@08105
	shr	ax, cl	;@08107
	add	dx, ax	;@08109
	mov	word ptr ds:[40Ah], dx	;@0810B
	sub	si, si	;@0810F
	jmp	short @@3	;@08111
@@2:	mov	es, word ptr ds:[79Eh]	;@08113
	cmp	byte ptr es:[si+1], 3	;@08117
	jge	@@4	;@0811C
	mov	di, si	;@0811E
	call	L08000	;@08120
	add	si, 14h	;@08123
@@3:	cmp	si, word ptr ds:[79Ch]	;@08126
	jb	@@2	;@0812A
@@4:	cmp	word ptr ds:[416h], 1	;@0812C
	jne	@@5	;@08131
	call	L0804E	;@08133
@@5:	ret	;@08136
L08137:	mov	dx, word ptr ds:[476h]	;@08137
	cmp	dx, -1	;@0813B
	je	@@1	;@0813E
	add	dx, word ptr ds:[3FEh]	;@08140
	mov	cx, word ptr ds:[478h]	;@08144
	mov	ax, 2	;@08148
	mov	si, 47Ch	;@0814B
	call	L08A4F	;@0814E
@@1:	ret	;@08151
L08152:	push	ax	;@08152
	push	bx	;@08153
	push	cx	;@08154
	push	dx	;@08155
	push	di	;@08156
	push	si	;@08157
	mov	es, word ptr ds:[77Eh]	;@08158
	mov	si, word ptr es:[di+4]	;@0815C
	mov	si, word ptr es:[si]	;@08160
	mov	es, word ptr ds:[79Eh]	;@08163
	mov	ax, word ptr es:[bx+8]	;@08167
	mov	cl, byte ptr es:[bx+0Ah]	;@0816B
	mov	ch, 0	;@0816F
	sub	ax, word ptr ds:[406h]	;@08171
	sbb	cl, ch	;@08175
	mov	ch, 4	;@08177
@@1:	shl	ax, 1	;@08179
	rcl	cl, 1	;@0817B
	dec	ch	;@0817D
	jne	@@1	;@0817F
	mov	word ptr ds:[674h], ax	;@08181
	mov	word ptr ds:[676h], cx	;@08184
	mov	ax, word ptr es:[bx+0Dh]	;@08188
	mov	word ptr ds:[678h], ax	;@0818C
	mov	ax, word ptr es:[bx+11h]	;@0818F
	shl	ax, 1	;@08193
	mov	word ptr ds:[67Ah], ax	;@08195
	mov	ax, word ptr es:[si+0Dh]	;@08198
	sub	ax, 20h	;@0819C
	mov	cx, 5	;@0819F
	sub	dx, dx	;@081A2
	div	cx	;@081A4
	mov	word ptr ds:[67Ch], ax	;@081A6
	mov	dx, word ptr es:[si+8]	;@081A9
	add	dx, word ptr ds:[3FEh]	;@081AD
	sub	cx, cx	;@081B1
	mov	ax, 20h	;@081B3
	mov	si, 670h	;@081B6
	call	L08A4F	;@081B9
	pop	si	;@081BC
	pop	di	;@081BD
	pop	dx	;@081BE
	pop	cx	;@081BF
	pop	bx	;@081C0
	pop	ax	;@081C1
	ret	;@081C2
L081C3:	push	ax	;@081C3
	push	bx	;@081C4
	push	cx	;@081C5
	push	dx	;@081C6
	push	di	;@081C7
	push	si	;@081C8
	mov	byte ptr ds:[694h], 0	;@081C9
	mov	bx, word ptr ds:[47Ch]	;@081CE
	mov	word ptr ds:[690h], bx	;@081D2
	mov	es, word ptr ds:[77Eh]	;@081D6
	mov	si, word ptr es:[di+4]	;@081DA
	mov	di, word ptr es:[si]	;@081DE
	mov	si, word ptr es:[si+4]	;@081E1
	mov	es, word ptr ds:[79Eh]	;@081E5
	mov	dx, word ptr es:[di+8]	;@081E9
	add	dx, word ptr ds:[3FEh]	;@081ED
@@1:	cmp	si, -1	;@081F1
	je	@@2	;@081F4
	push	si	;@081F6
	and	si, 3	;@081F7
	shl	si, 1	;@081FA
	shl	si, 1	;@081FC
	shl	si, 1	;@081FE
	mov	es, word ptr [si+756h]	;@08200
	pop	si	;@08204
	push	word ptr es:[si+0Ah]	;@08205
	mov	ax, word ptr es:[si+4]	;@08209
	mov	word ptr ds:[692h], ax	;@0820D
	mov	cx, word ptr es:[si+8]	;@08210
	mov	ax, 5	;@08214
	mov	si, 690h	;@08217
	call	L08A4F	;@0821A
	pop	si	;@0821D
	jmp	@@1	;@0821E
@@2:	pop	si	;@08220
	pop	di	;@08221
	pop	dx	;@08222
	pop	cx	;@08223
	pop	bx	;@08224
	pop	ax	;@08225
	ret	;@08226
L08227:	push	bx	;@08227
	push	cx	;@08228
	mov	bx, word ptr ds:[404h]	;@08229
	cmp	bx, -1	;@0822D
	jne	@@1	;@08230
	sub	ax, ax	;@08232
	cwd	;@08234
	jmp	short @@2	;@08235
@@1:	mov	es, word ptr ds:[79Eh]	;@08237
	mov	ax, 10h	;@0823B
	mul	word ptr es:[bx+8]	;@0823E
	xchg	ax, bx	;@08242
	mov	cx, dx	;@08243
	mov	dx, word ptr ds:[3DEh]	;@08245
	mov	ax, word ptr ds:[3DCh]	;@08249
	sub	ax, bx	;@0824C
	sbb	dx, cx	;@0824E
	add	ax, 0Fh	;@08250
	adc	dx, 0	;@08253
	and	al, 0F0h	;@08256
@@2:	pop	cx	;@08258
	pop	bx	;@08259
	ret	;@0825A
L0825B:	push	si	;@0825B
	push	di	;@0825C
	mov	di, 662h	;@0825D
	mov	word ptr [di], 4246h	;@08260
	mov	word ptr [di+2], 564Fh	;@08264
	call	L08227	;@08269
	mov	word ptr [di+4], ax	;@0826C
	mov	word ptr [di+6], dx	;@0826F
	mov	dx, word ptr ds:[40Ah]	;@08272
	cmp	dx, -1	;@08276
	jne	@@1	;@08279
	sub	ax, ax	;@0827B
	cwd	;@0827D
	sub	cx, cx	;@0827E
	jmp	short @@3	;@08280
@@1:	add	dx, word ptr ds:[3FEh]	;@08282
	mov	ax, 10h	;@08286
	mul	dx	;@08289
	mov	bx, word ptr ds:[404h]	;@0828B
	cmp	bx, -1	;@0828F
	je	@@2	;@08292
	mov	es, word ptr ds:[79Eh]	;@08294
	mov	cx, word ptr es:[bx+6]	;@08298
	dec	cx	;@0829C
	jmp	short @@3	;@0829D
@@2:	mov	cx, word ptr ds:[6B9h]	;@0829F
@@3:	mov	word ptr [di+8], ax	;@082A3
	mov	word ptr [di+0Ah], dx	;@082A6
	mov	word ptr [di+0Ch], cx	;@082A9
	mov	ax, 0Eh	;@082AC
	xor	cx, cx	;@082AF
	mov	dx, word ptr ds:[418h]	;@082B1
	add	dx, word ptr ds:[3FEh]	;@082B5
	mov	si, 662h	;@082B9
	call	L08A4F	;@082BC
	pop	di	;@082BF
	pop	si	;@082C0
	ret	;@082C1
L082C2:	push	si	;@082C2
	push	di	;@082C3
	mov	bx, word ptr ds:[404h]	;@082C4
	cmp	bx, -1	;@082C8
	jne	@@1	;@082CB
	cmp	word ptr ds:[414h], 1	;@082CD
	je	@@3	;@082D2
	jmp	short @@4	;@082D4
@@1:	push	ds	;@082D6
	pop	es	;@082D7
	xor	ax, ax	;@082D8
	mov	cx, 20h	;@082DA
	mov	di, 670h	;@082DD
	rep stosb	;@082E0
	mov	ax, word ptr ds:[47Ch]	;@082E2
	mov	word ptr ds:[670h], ax	;@082E5
	mov	es, word ptr ds:[79Eh]	;@082E8
	mov	ax, word ptr es:[bx+8]	;@082EC
	mov	word ptr ds:[406h], ax	;@082F0
@@2:	mov	di, word ptr es:[bx+4]	;@082F3
	call	L08152	;@082F7
	call	L081C3	;@082FA
	add	bx, 14h	;@082FD
	cmp	bx, word ptr ds:[79Ch]	;@08300
	jae	@@3	;@08304
	mov	es, word ptr ds:[79Eh]	;@08306
	jmp	@@2	;@0830A
@@3:	call	L0825B	;@0830C
@@4:	pop	di	;@0830F
	pop	si	;@08310
	ret	;@08311
L08312:	cmp	byte ptr ds:[11h], 1	;@08312
	jne	@@1	;@08317
	push	ds	;@08319
	mov	dx, word ptr ds:[13Ah]	;@0831A
	lds	bx, dword ptr ds:[132h]	;@0831E
	mov	ds, word ptr [bx]	;@08322
	add	dx, 2	;@08324
	mov	ah, 3Ch	;@08327
	xor	cx, cx	;@08329
	call	OPEN_FILE	;@0832B
	pop	ds	;@0832E
	mov	word ptr ds:[20h], ax	;@0832F
@@1:	ret	;@08332
L08333:	mov	di, 58B6h	;@08333
	mov	cx, 1Ch	;@08336
	push	cs	;@08339
	pop	es	;@0833A
@@1:	mov	si, word ptr es:[di]	;@0833B
	mov	word ptr ds:[3450h], es	;@0833E
	push	cx	;@08342
	push	di	;@08343
	mov	ah, byte ptr es:[di+4]	;@08344
	call	L0910F	;@08348
	pop	di	;@0834B
	pop	cx	;@0834C
	push	cs	;@0834D
	pop	es	;@0834E
	mov	si, word ptr es:[di+2]	;@0834F
	mov	word ptr [si], bx	;@08353
	dec	cx	;@08355
	je	@@2	;@08356
	add	di, 5	;@08358
	jmp	@@1	;@0835B
@@2:	mov	bx, word ptr ds:[44Eh]	;@0835D
	push	bx	;@08361
	and	bx, 3	;@08362
	shl	bx, 1	;@08365
	shl	bx, 1	;@08367
	shl	bx, 1	;@08369
	mov	es, word ptr [bx+716h]	;@0836B
	pop	bx	;@0836F
	mov	word ptr es:[bx+3], 4F3Ah	;@08370
	mov	word ptr es:[bx+5], 5956h	;@08376
	ret	;@0837C
L0837D:	push	bp	;@0837D
	mov	bp, sp	;@0837E
	cmp	byte ptr ds:[3D7h], 1	;@08380
	jne	@@2	;@08385
	cmp	word ptr ds:[3FCh], -1	;@08387
	je	@@2	;@0838C
	mov	si, 5861h	;@0838E
	mov	ah, 0	;@08391
	mov	word ptr ds:[3450h], cs	;@08393
	call	L0921C	;@08397
	jb	@@1	;@0839A
	push	bx	;@0839C
	and	bx, 3	;@0839D
	shl	bx, 1	;@083A0
	shl	bx, 1	;@083A2
	shl	bx, 1	;@083A4
	mov	es, word ptr [bx+756h]	;@083A6
	pop	bx	;@083AA
	test	byte ptr es:[bx+0Eh], 10h	;@083AB
	je	@@1	;@083B0
	mov	si, word ptr ds:[0C35h]	;@083B2
	cmp	si, -1	;@083B6
	je	@@1	;@083B9
	call	@@3	;@083BB
@@1:	mov	si, 5868h	;@083BE
	mov	ah, 0	;@083C1
	mov	word ptr ds:[3450h], cs	;@083C3
	call	L0921C	;@083C7
	jb	@@2	;@083CA
	push	bx	;@083CC
	and	bx, 3	;@083CD
	shl	bx, 1	;@083D0
	shl	bx, 1	;@083D2
	shl	bx, 1	;@083D4
	mov	es, word ptr [bx+756h]	;@083D6
	pop	bx	;@083DA
	test	byte ptr es:[bx+0Eh], 10h	;@083DB
	je	@@2	;@083E0
	mov	si, word ptr ds:[0C37h]	;@083E2
	cmp	si, -1	;@083E6
	je	@@2	;@083E9
	call	@@3	;@083EB
@@2:	mov	sp, bp	;@083EE
	pop	bp	;@083F0
	ret	;@083F1
@@3:	mov	word ptr es:[bx], si	;@083F2
	mov	word ptr es:[bx+4], 0	;@083F5
	mov	word ptr es:[bx+6], 0	;@083FB
	mov	al, 0EFh	;@08401
	and	byte ptr es:[bx+0Eh], al	;@08403
	ret	;@08407
; LINK: the link itself: pass 1 over the objects and libraries, the layout, pass 2,
; the map and the output file.
LINK:	mov	word ptr ds:[47Eh], ds	;@08408
	mov	word ptr ds:[480h], cs	;@0840C
	mov	al, byte ptr ds:[0C32h]	;@08410
	or	al, byte ptr ds:[14h]	;@08413
	or	al, byte ptr ds:[17h]	;@08417
	or	byte ptr ds:[254h], al	;@0841B
	mov	word ptr ds:[0C33h], 0	;@0841F
	mov	byte ptr ds:[410h], 0	;@08425
	cmp	word ptr ds:[47Ch], -1	;@0842A
	jne	@@1	;@0842F
	mov	word ptr ds:[47Ch], 3FCDh	;@08431
@@1:	push	ds	;@08437
	pop	es	;@08438
	xor	ax, ax	;@08439
	mov	di, 49Ah	;@0843B
	mov	cx, 1Fh	;@0843E
	rep stosw	;@08441
	mov	word ptr ds:[4B0h], 0FFFFh	;@08443
	mov	di, 69Dh	;@08449
	mov	cx, 40h	;@0844C
	shr	cx, 1	;@0844F
	rep stosw	;@08451
	call	L08CE9	;@08453
	mov	word ptr ds:[38Fh], 0	;@08456
	mov	ax, 10h	;@0845C
	cmp	byte ptr ds:[14h], ah	;@0845F
	je	@@2	;@08463
	push	ds	;@08465
	pop	es	;@08466
	mov	di, 4D8h	;@08467
	mov	cx, 28h	;@0846A
	xor	ax, ax	;@0846D
	rep stosw	;@0846F
	mov	word ptr ds:[488h], ax	;@08471
	mov	word ptr ds:[48Ah], ax	;@08474
	mov	word ptr ds:[48Ch], ax	;@08477
	mov	word ptr ds:[490h], ax	;@0847A
	mov	di, 3B2h	;@0847D
	mov	cx, 1Ah	;@08480
	rep stosb	;@08483
	mov	word ptr ds:[3C4h], 1	;@08485
	mov	ax, 14h	;@0848B
@@2:	mov	word ptr ds:[48Eh], ax	;@0848E
	sub	ax, ax	;@08491
	mov	word ptr ds:[3EAh], ax	;@08493
	mov	word ptr ds:[3ECh], ax	;@08496
	mov	word ptr ds:[41Eh], ax	;@08499
	mov	word ptr ds:[420h], ax	;@0849C
	call	L05620	;@0849F
	cmp	byte ptr ds:[17h], 1	;@084A2
	jne	@@3	;@084A7
	mov	di, 802h	;@084A9
	call	NEW_POOL	;@084AC
	mov	di, 80Ah	;@084AF
	call	L056CA	;@084B2
@@3:	mov	byte ptr ds:[3D4h], 0	;@084B5
	mov	byte ptr ds:[492h], 0	;@084BA
	mov	byte ptr ds:[486h], 0	;@084BF
	call	L08312	;@084C4
	call L09751	;@084C7
	cmp	byte ptr ds:[17h], 0	;@084CA
	je	@@4	;@084CF
	mov	word ptr ds:[400h], 8	;@084D1
	mov	word ptr ds:[402h], 6F1h	;@084D7
	call L09DCF	;@084DD
	jmp	short @@5	;@084E0
@@4:	mov	word ptr ds:[400h], 2	;@084E2
	mov	word ptr ds:[402h], 660h	;@084E8
@@5:	mov	word ptr ds:[411h], 0	;@084EE
	call	L08333	;@084F4
	mov	word ptr ds:[41Ch], 0	;@084F7
	mov	word ptr ds:[3D0h], offset PASS1_RECORDS	;@084FD
	mov	byte ptr ds:[3D5h], 0	;@08503
	call	L08BBA	;@08508
	mov	ax, word ptr ds:[3474h]	;@0850B
	mov	word ptr ds:[494h], ax	;@0850E
	mov	si, word ptr ds:[136h]	;@08511
	call	L08D03	;@08515
	mov	byte ptr ds:[3D5h], 1	;@08518
	mov	si, word ptr ds:[13Ch]	;@0851D
	call	L08BBA	;@08521
	call	L08D03	;@08524
	mov	word ptr ds:[494h], 0	;@08527
	call	L04548	;@0852D
	mov	byte ptr ds:[254h], 1	;@08530
	mov	byte ptr ds:[3D5h], 2	;@08535
	call	@@30	;@0853A
	call	L05C70	;@0853D
	push	bx	;@08540
	mov	bx, word ptr ds:[738h]	;@08541
	les	di, dword ptr [bx+2]	;@08545
	add	di, 18h	;@08548
	cmp	di, word ptr [bx]	;@0854B
	jbe	@@6	;@0854D
	call	L05519	;@0854F
	pop	bx	;@08552
	jae	@@7	;@08553
	call	TABLE_OVERFLOW	;@08555
@@6:	xchg	word ptr [bx+2], di	;@08558
	pop	bx	;@0855B
@@7:	stosw	;@0855C
	mov	ax, word ptr ds:[774h]	;@0855D
	stosw	;@08560
	mov	ax, word ptr ds:[784h]	;@08561
	stosw	;@08564
	mov	ax, word ptr ds:[794h]	;@08565
	stosw	;@08568
	mov	ax, word ptr ds:[7ACh]	;@08569
	stosw	;@0856C
	mov	ax, 3	;@0856D
	stosw	;@08570
	mov	al, 0	;@08571
	stosw	;@08573
	stosw	;@08574
	stosb	;@08575
	cmp	byte ptr ds:[17h], 0	;@08576
	je	@@8	;@0857B
	call L0BA61	;@0857D
	call L0BCEA	;@08580
@@8:	call	L0653D	;@08583
	mov	ax, word ptr ds:[4A0h]	;@08586
	mov	word ptr ds:[0C47h], ax	;@08589
	cmp	byte ptr ds:[17h], 1	;@0858C
	jne	@@10	;@08591
	call L09D1D	;@08593
	and	ax, ax	;@08596
	je	@@9	;@08598
	inc	ax	;@0859A
@@9:	mov	word ptr ds:[3F8h], ax	;@0859B
@@10:	cmp	byte ptr ds:[486h], 1	;@0859E
	jne	@@11	;@085A3
	call	L065E9	;@085A5
@@11:	call	L069D0	;@085A8
	mov	es, word ptr ds:[7BEh]	;@085AB
	mov	cx, word ptr ds:[7BCh]	;@085AF
	mov	bp, offset L0663B	;@085B3
	call	L09252	;@085B6
	call	L06ACA	;@085B9
	cmp	byte ptr ds:[17h], 1	;@085BC
	jne	@@12	;@085C1
	call	L06C65	;@085C3
@@12:	mov	word ptr ds:[6B9h], 0	;@085C6
	call	L06DA9	;@085CC
	mov	bx, word ptr ds:[424h]	;@085CF
	push	bx	;@085D3
	and	bx, 3	;@085D4
	shl	bx, 1	;@085D7
	shl	bx, 1	;@085D9
	shl	bx, 1	;@085DB
	mov	es, word ptr [bx+716h]	;@085DD
	pop	bx	;@085E1
	mov	ax, word ptr es:[bx]	;@085E2
	cmp	ax, 0FFFFh	;@085E5
	je	@@13	;@085E8
	mov	word ptr ds:[3FCh], ax	;@085EA
@@13:	call	L076F0	;@085ED
	cmp	byte ptr ds:[17h], 1	;@085F0
	jne	@@14	;@085F5
	call L0A3CE	;@085F7
@@14:	call	L0718B	;@085FA
	call	L0837D	;@085FD
	call	L073AD	;@08600
	call	L073F3	;@08603
	call	L077D3	;@08606
	cmp	byte ptr ds:[17h], 0	;@08609
	jne	@@15	;@0860E
	call	L07461	;@08610
@@15:	cmp	byte ptr ds:[11h], 1	;@08613
	jne	@@17	;@08618
	xor	ax, ax	;@0861A
	call	L07A92	;@0861C
	mov	di, word ptr ds:[7641h]	;@0861F
	call PUT_NEWLINE	;@08623
	mov	word ptr ds:[7641h], di	;@08626
	cmp	byte ptr ds:[13h], 1	;@0862A
	jne	@@16	;@0862F
	mov	ax, 1	;@08631
	call	L07A92	;@08634
	mov	di, word ptr ds:[7641h]	;@08637
	call PUT_NEWLINE	;@0863B
	mov	word ptr ds:[7641h], di	;@0863E
@@16:	cmp	byte ptr ds:[12h], 1	;@08642
	jne	@@17	;@08647
	call	L07E91	;@08649
	mov	di, word ptr ds:[7641h]	;@0864C
	mov	word ptr ds:[7641h], di	;@08650
	cmp	byte ptr ds:[14h], 0	;@08654
	jne	@@18	;@08659
@@17:	cmp	byte ptr ds:[14h], 0	;@0865B
	je	@@19	;@08660
	call	L07D9D	;@08662
@@18:	mov	bp, offset L07BE6	;@08665
	mov	cx, word ptr ds:[7BCh]	;@08668
	mov	es, word ptr ds:[7BEh]	;@0866C
	call	L09252	;@08670
	jmp	short @@20	;@08673
@@19:	mov	word ptr ds:[7BCh], 0	;@08675
@@20:	mov	word ptr ds:[78Ch], 0	;@0867B
	cmp	byte ptr ds:[410h], 0	;@08681
	je	@@21	;@08686
	call	L087D0	;@08688
@@21:	mov	byte ptr ds:[0C4Ch], 0	;@0868B
	call	@@29	;@08690
	mov	byte ptr ds:[3D4h], 1	;@08693
	call	L05751	;@08698
	cmp	byte ptr ds:[17h], 0	;@0869B
	je	@@22	;@086A0
	call L0B698	;@086A2
	call L0B795	;@086A5
	call L09FBD	;@086A8
@@22:	cmp	byte ptr ds:[14h], 0	;@086AB
	je	@@23	;@086B0
	call	L04A48	;@086B2
	call	L050D8	;@086B5
@@23:	mov	word ptr ds:[3EAh], 0	;@086B8
	xor	dx, dx	;@086BE
	cmp	byte ptr ds:[121h], 1	;@086C0
	jne	@@24	;@086C5
	mov	dx, word ptr ds:[3FEh]	;@086C7
	mov	ax, 10h	;@086CB
	mul	dx	;@086CE
	add	ax, word ptr ds:[3DCh]	;@086D0
	adc	dx, word ptr ds:[3DEh]	;@086D4
	mov	cx, 0	;@086D8
	call	L08B1D	;@086DB
@@24:	mov	word ptr ds:[3D0h], offset PASS2_RECORDS	;@086DE
	mov	word ptr ds:[3E2h], 0	;@086E4
	mov	byte ptr ds:[3F1h], 0FFh	;@086EA
	mov	byte ptr ds:[492h], 0	;@086EF
	call	L08BBA	;@086F4
	mov	al, byte ptr ds:[124h]	;@086F7
	mov	byte ptr ds:[15h], al	;@086FA
	mov	byte ptr ds:[3D5h], 3	;@086FD
	mov	ax, word ptr ds:[3474h]	;@08702
	mov	word ptr ds:[494h], ax	;@08705
	mov	si, word ptr ds:[136h]	;@08708
	call	L08D03	;@0870C
	mov	byte ptr ds:[3D5h], 4	;@0870F
	call	L08BBA	;@08714
	mov	si, word ptr ds:[13Ch]	;@08717
	call	L08D03	;@0871B
	call	L080DF	;@0871E
	call	L08137	;@08721
	call	L082C2	;@08724
	cmp	byte ptr ds:[14h], 0	;@08727
	je	@@25	;@0872C
	call	L05457	;@0872E
@@25:	cmp	byte ptr ds:[129h], 1	;@08731
	jne	@@26	;@08736
	cmp	word ptr ds:[4AEh], 100h	;@08738
	je	@@28	;@0873E
	call	L0937E	;@08740
	jne	@@28	;@08743
	jmp	L03CB9	;@08745
@@26:	cmp	byte ptr ds:[17h], 0	;@08748
	je	@@27	;@0874D
	call L0A3B5	;@0874F
	jmp	short @@28	;@08752
@@27:	call	L075DB	;@08754
@@28:	mov	di, word ptr ds:[7641h]	;@08757
	call PUT_NEWLINE	;@0875B
	call FLUSH_OUTPUT	;@0875E
	call	L088AC	;@08761
	sub	ax, ax	;@08764
	ret	;@08766
@@29:	push	ds	;@08767
	mov	dx, word ptr ds:[138h]	;@08768
	lds	bx, dword ptr ds:[132h]	;@0876C
	mov	ds, word ptr [bx]	;@08770
	add	dx, 2	;@08772
	mov	ax, 3C00h	;@08775
	xor	cx, cx	;@08778
	call	OPEN_FILE	;@0877A
	pop	ds	;@0877D
	mov	word ptr ds:[22h], ax	;@0877E
	ret	;@08781
@@30:	cmp	byte ptr ds:[3D7h], 1	;@08782
	jne	@@31	;@08787
	mov	bx, word ptr ds:[0C41h]	;@08789
	cmp	bx, -1	;@0878D
	je	@@31	;@08790
	mov	es, word ptr ds:[776h]	;@08792
	mov	al, byte ptr es:[bx+9]	;@08796
	mov	cx, word ptr es:[bx]	;@0879A
	push	ax	;@0879D
	call	L05C16	;@0879E
	pop	ax	;@087A1
	mov	byte ptr es:[di+9], al	;@087A2
	mov	word ptr es:[di], cx	;@087A6
	mov	word ptr es:[di+6], 10h	;@087A9
	mov	bx, word ptr ds:[438h]	;@087AF
	mov	word ptr es:[di], bx	;@087B3
	mov	bx, word ptr ds:[44Ch]	;@087B6
	mov	word ptr es:[di+2], bx	;@087BA
	mov	word ptr ds:[43Ah], di	;@087BE
@@31:	ret	;@087C2
	db	0Dh dup (0)	;@087C3
L087D0:	mov	di, word ptr ds:[7641h]	;@087D0
	call PUT_NEWLINE	;@087D4
	call FLUSH_OUTPUT	;@087D7
	call	L095C9	;@087DA
	call	L095DA	;@087DD
	ret	;@087E0
L087E1:	push	ax	;@087E1
	push	bx	;@087E2
	push	dx	;@087E3
	push	di	;@087E4
	push	es	;@087E5
	mov	bx, cx	;@087E6
	and	cx, 3FFh	;@087E8
	xor	bx, cx	;@087EC
	mov	di, 144Eh	;@087EE
	sub	di, cx	;@087F1
	push	di	;@087F3
	or	cx, bx	;@087F4
	je	@@1	;@087F6
	push	ds	;@087F8
	pop	es	;@087F9
	shr	cx, 1	;@087FA
	rep movsw	;@087FC
	rcl	cx, 1	;@087FE
	rep movsb	;@08800
@@1:	mov	ax, word ptr ds:[346Ch]	;@08802
	mov	dx, word ptr ds:[346Eh]	;@08805
	sub	ax, bx	;@08809
	sbb	dl, dh	;@0880B
	mov	word ptr ds:[3468h], ax	;@0880D
	mov	word ptr ds:[346Ah], dx	;@08810
	mov	cx, 2000h	;@08814
	sub	cx, bx	;@08817
	cmp	byte ptr ds:[161h], 0	;@08819
	je	@@2	;@0881E
	mov	ax, word ptr ds:[3464h]	;@08820
	mov	dx, word ptr ds:[3466h]	;@08823
	sub	ax, word ptr ds:[346Ch]	;@08827
	sbb	dx, word ptr ds:[346Eh]	;@0882B
	jne	@@2	;@0882F
	cmp	ax, cx	;@08831
	ja	@@2	;@08833
	xchg	ax, cx	;@08835
@@2:	mov	ah, 3Fh	;@08836
	mov	bx, word ptr ds:[24h]	;@08838
	mov	dx, di	;@0883C
	call	DOS_CALL	;@0883E
	or	ax, ax	;@08841
	je	@@3	;@08843
	add	word ptr ds:[346Ch], ax	;@08845
	adc	word ptr ds:[346Eh], 0	;@08849
	add	ax, di	;@0884E
	mov	word ptr ds:[3458h], ax	;@08850
	pop	si	;@08853
	pop	es	;@08854
	pop	di	;@08855
	pop	dx	;@08856
	pop	bx	;@08857
	pop	ax	;@08858
	ret	;@08859
@@3:	call	L0885D	;@0885A
L0885D:	push	ds	;@0885D
	mov	ax, 54BBh	;@0885E
	push	ax	;@08861
	mov	ax, 4	;@08862
	push	ax	;@08865
	mov	ax, 5	;@08866
	push	ax	;@08869
	call FATAL	;@0886A
L0886D:	xchg	bx, si	;@0886D
	push	bx	;@0886F
	push	cx	;@08870
	push	dx	;@08871
	push	ds	;@08872
	push	ax	;@08873
	mov	dx, si	;@08874
	mov	cl, 4	;@08876
	shl	dx, cl	;@08878
	xchg	dl, dh	;@0887A
	sub	cx, cx	;@0887C
	xchg	dl, cl	;@0887E
	mov	bx, word ptr ds:[22h]	;@08880
	mov	ax, 4200h	;@08884
	call	DOS_CALL	;@08887
	mov	bx, word ptr ds:[22h]	;@0888A
	mov	cx, 2000h	;@0888E
	cmp	si, word ptr ds:[482h]	;@08891
	jne	@@1	;@08895
	mov	cx, word ptr ds:[484h]	;@08897
@@1:	pop	ax	;@0889B
	xor	dx, dx	;@0889C
	mov	ds, word ptr [si+832h]	;@0889E
	call	DOS_CALL_FULL	;@088A2
	pop	ds	;@088A5
	pop	dx	;@088A6
	pop	cx	;@088A7
	pop	bx	;@088A8
	xchg	bx, si	;@088A9
	ret	;@088AB
L088AC:	cmp	word ptr ds:[482h], -1	;@088AC
	jne	@@1	;@088B1
	ret	;@088B3
@@1:	push	ds	;@088B4
	mov	ax, 832h	;@088B5
	push	ax	;@088B8
	call	far ptr HEAP_MODE_SET_BIT13	;@088B9
	and	ax, ax	;@088BE
	je	@@2	;@088C0
	jmp	@@7	;@088C2
@@2:	xor	bx, bx	;@088C5
@@3:	cmp	word ptr [bx+832h], -1	;@088C7
	jne	@@4	;@088CC
	push	bx	;@088CE
	push	ds	;@088CF
	mov	ax, 832h	;@088D0
	push	ax	;@088D3
	call	far ptr HEAP_MODE_SET_BIT13	;@088D4
	and	ax, ax	;@088D9
	pop	bx	;@088DB
	jne	@@7	;@088DC
	mov	es, word ptr ds:[832h]	;@088DE
	sub	di, di	;@088E2
	sub	ax, ax	;@088E4
	mov	cx, 1000h	;@088E6
	cld	;@088E9
	rep stosw	;@088EA
	mov	word ptr [bx+832h], es	;@088EC
	mov	ah, 40h	;@088F0
	call	L0886D	;@088F2
	jmp	short @@6	;@088F5
@@4:	push	bx	;@088F7
	push	ds	;@088F8
	add	bx, 832h	;@088F9
	push	bx	;@088FD
	call	far ptr HANDLE_IN_BANK_5	;@088FE
	pop	bx	;@08903
	and	ax, ax	;@08904
	jne	@@6	;@08906
	push	bx	;@08908
	push	ds	;@08909
	add	bx, 832h	;@0890A
	push	bx	;@0890E
	call	far ptr HEAP_MODE_SET_BIT13	;@0890F
	pop	bx	;@08914
	and	ax, ax	;@08915
	jne	@@7	;@08917
	mov	ah, 40h	;@08919
	call	L0886D	;@0891B
	and	bx, bx	;@0891E
	jne	@@5	;@08920
	jmp	short @@6	;@08922
@@5:	push	bx	;@08924
	push	ds	;@08925
	add	bx, 832h	;@08926
	push	bx	;@0892A
	call	far ptr FREE_HANDLE_BLOCK	;@0892B
	pop	bx	;@08930
@@6:	add	bx, 2	;@08931
	cmp	bx, word ptr ds:[482h]	;@08934
	jbe	@@3	;@08938
	push	ds	;@0893A
	mov	ax, 832h	;@0893B
	push	ax	;@0893E
	call	far ptr FREE_HANDLE_BLOCK	;@0893F
	ret	;@08944
@@7:	jmp	OUT_OF_MEMORY	;@08945
L08948:	push	bp	;@08948
	mov	bp, sp	;@08949
	push	ds	;@0894B
	push	si	;@0894C
	push	di	;@0894D
	mov	ds, word ptr cs:DATA_SEGMENT	;@0894E
	mov	ax, word ptr [bp+0Ch]	;@08953
	dec	ax	;@08956
	je	@@1	;@08957
	dec	ax	;@08959
	jne	@@3	;@0895A
	mov	ah, 3Fh	;@0895C
	jmp	short @@2	;@0895E
@@1:	mov	ah, 40h	;@08960
@@2:	mov	bx, word ptr [bp+8]	;@08962
	sub	bx, 832h	;@08965
	call	L0886D	;@08969
@@3:	xor	ax, ax	;@0896C
	pop	di	;@0896E
	pop	si	;@0896F
	pop	ds	;@08970
	pop	bp	;@08971
	retf	8	;@08972
L08975	dd	L08948	;@08975
L08979:	push	bx	;@08979
	push	ds	;@0897A
	add	bx, 832h	;@0897B
	push	bx	;@0897F
	push	word ptr cs:L08975+2	;@08980
	push	word ptr cs:L08975	;@08985
	call	far ptr SET_NODE_INFO	;@0898A
	pop	bx	;@0898F
	push	bx	;@08990
	push	ds	;@08991
	add	bx, 832h	;@08992
	push	bx	;@08996
	call	far ptr HEAP_MODE_SET_BITS56	;@08997
	pop	bx	;@0899C
	ret	;@0899D
L0899E:	push	ax	;@0899E
	push	cx	;@0899F
	push	dx	;@089A0
	xchg	ax, cx	;@089A1
	mov	cl, 4	;@089A2
	rol	dx, cl	;@089A4
	mov	cx, 0FFF0h	;@089A6
	and	cx, dx	;@089A9
	xor	dx, cx	;@089AB
	add	ax, cx	;@089AD
	adc	dl, dh	;@089AF
	jmp	short L089C0	;@089B1
L089B3:	xor	ax, ax	;@089B3
	push	ax	;@089B5
	mov	ax, 17h	;@089B6
	push	ax	;@089B9
	call FATAL	;@089BA
L089BD:	push	ax	;@089BD
	push	cx	;@089BE
	push	dx	;@089BF
L089C0:	sub	ax, word ptr ds:[0C33h]	;@089C0
	sbb	dx, 0	;@089C4
	jb	L089B3	;@089C7
	mov	bx, 0E000h	;@089C9
	and	bx, ax	;@089CC
	xor	ax, bx	;@089CE
	xchg	ax, di	;@089D0
	or	bx, dx	;@089D1
	mov	cl, 4	;@089D3
	rol	bx, cl	;@089D5
	mov	ax, word ptr [bx+832h]	;@089D7
	cmp	ah, 0FFh	;@089DB
	je	@@5	;@089DE
	cmp	ax, 1000h	;@089E0
	jb	@@2	;@089E3
	mov	es, ax	;@089E5
@@1:	mov	word ptr ds:[345Ch], bx	;@089E7
	pop	dx	;@089EB
	pop	cx	;@089EC
	pop	ax	;@089ED
	ret	;@089EE
@@2:	push	di	;@089EF
	push	bx	;@089F0
	push	ds	;@089F1
	add	bx, 832h	;@089F2
	push	bx	;@089F6
	call	far ptr HEAP_MODE_SET_BIT13	;@089F7
	pop	bx	;@089FC
	pop	di	;@089FD
	and	ax, ax	;@089FE
	jne	@@4	;@08A00
@@3:	call	L08979	;@08A02
	mov	es, word ptr [bx+832h]	;@08A05
	jmp	@@1	;@08A09
@@4:	jmp	OUT_OF_MEMORY	;@08A0B
@@5:	cmp	bx, word ptr ds:[482h]	;@08A0E
	jle	@@6	;@08A12
	mov	word ptr ds:[482h], bx	;@08A14
	mov	word ptr ds:[484h], 0	;@08A18
@@6:	push	di	;@08A1E
	push	bx	;@08A1F
	push	ds	;@08A20
	add	bx, 832h	;@08A21
	push	bx	;@08A25
	mov	ax, 2000h	;@08A26
	push	ax	;@08A29
	call	far ptr POOL_INIT	;@08A2A
	and	ax, ax	;@08A2F
	jne	@@4	;@08A31
	pop	bx	;@08A33
	mov	es, word ptr [bx+832h]	;@08A34
	mov	cx, 1000h	;@08A38
	xor	di, di	;@08A3B
	mov	ax, di	;@08A3D
	cld	;@08A3F
	rep stosw	;@08A40
	pop	di	;@08A42
	jmp	@@3	;@08A43
L08A45:	mov	word ptr ds:[3456h], di	;@08A45
	mov	word ptr ds:[3454h], bx	;@08A49
	jmp	short L08A59	;@08A4D
L08A4F:	mov	word ptr ds:[3456h], ds	;@08A4F
	mov	word ptr ds:[3454h], 47Eh	;@08A53
L08A59:	push	ax	;@08A59
	push	bx	;@08A5A
	push	cx	;@08A5B
@@1:	call	L0899E	;@08A5C
	push	ds	;@08A5F
	lds	bx, dword ptr ds:[3454h]	;@08A60
	mov	ds, word ptr [bx]	;@08A64
	mov	bx, cx	;@08A66
	mov	cx, 2000h	;@08A68
	sub	cx, di	;@08A6B
	cmp	cx, ax	;@08A6D
	jb	@@4	;@08A6F
	mov	cx, ax	;@08A71
	shr	cx, 1	;@08A73
	rep movsw	;@08A75
	rcl	cx, 1	;@08A77
	rep movsb	;@08A79
	pop	ds	;@08A7B
	mov	cx, word ptr ds:[345Ch]	;@08A7C
	cmp	cx, word ptr ds:[482h]	;@08A80
	je	@@5	;@08A84
@@2:	cmp	cx, word ptr ds:[345Eh]	;@08A86
	jge	@@6	;@08A8A
@@3:	pop	cx	;@08A8C
	pop	bx	;@08A8D
	pop	ax	;@08A8E
	ret	;@08A8F
@@4:	add	bx, cx	;@08A90
	sub	ax, cx	;@08A92
	shr	cx, 1	;@08A94
	rep movsw	;@08A96
	rcl	cx, 1	;@08A98
	rep movsb	;@08A9A
	pop	ds	;@08A9C
	mov	cx, bx	;@08A9D
	jmp	@@1	;@08A9F
@@5:	cmp	di, word ptr ds:[484h]	;@08AA1
	jb	@@2	;@08AA5
	mov	word ptr ds:[484h], di	;@08AA7
	jmp	@@2	;@08AAB
@@6:	jg	@@7	;@08AAD
	cmp	di, word ptr ds:[3460h]	;@08AAF
	jb	@@3	;@08AB3
	mov	word ptr ds:[3460h], di	;@08AB5
	jmp	@@3	;@08AB9
@@7:	mov	word ptr ds:[345Eh], cx	;@08ABB
	mov	word ptr ds:[3460h], di	;@08ABF
	jmp	@@3	;@08AC3
L08AC5:	push	ax	;@08AC5
	push	bx	;@08AC6
	push	cx	;@08AC7
	push	dx	;@08AC8
	mov	word ptr ds:[3456h], ds	;@08AC9
	mov	word ptr ds:[3454h], bx	;@08ACD
@@1:	call	L089BD	;@08AD1
	push	ds	;@08AD4
	lds	bx, dword ptr ds:[3454h]	;@08AD5
	mov	ds, word ptr [bx]	;@08AD9
	mov	bx, 2000h	;@08ADB
	sub	bx, di	;@08ADE
	cmp	cx, bx	;@08AE0
	ja	@@3	;@08AE2
	shr	cx, 1	;@08AE4
	rep movsw	;@08AE6
	rcl	cx, 1	;@08AE8
	rep movsb	;@08AEA
	pop	ds	;@08AEC
	mov	cx, word ptr ds:[345Ch]	;@08AED
	cmp	cx, word ptr ds:[482h]	;@08AF1
	je	@@4	;@08AF5
@@2:	pop	dx	;@08AF7
	pop	cx	;@08AF8
	pop	bx	;@08AF9
	pop	ax	;@08AFA
	ret	;@08AFB
@@3:	push	cx	;@08AFC
	mov	cx, bx	;@08AFD
	shr	cx, 1	;@08AFF
	rep movsw	;@08B01
	rcl	cx, 1	;@08B03
	rep movsb	;@08B05
	pop	cx	;@08B07
	pop	ds	;@08B08
	add	ax, bx	;@08B09
	adc	dl, dh	;@08B0B
	sub	cx, bx	;@08B0D
	jmp	@@1	;@08B0F
@@4:	cmp	di, word ptr ds:[484h]	;@08B11
	jb	@@2	;@08B15
	mov	word ptr ds:[484h], di	;@08B17
	jmp	@@2	;@08B1B
L08B1D:	push	bx	;@08B1D
	push	cx	;@08B1E
@@1:	call	L089BD	;@08B1F
	mov	bx, 2000h	;@08B22
	sub	bx, di	;@08B25
	cmp	cx, bx	;@08B27
	ja	@@3	;@08B29
	add	ax, cx	;@08B2B
	adc	dl, dh	;@08B2D
	shr	cx, 1	;@08B2F
	rep movsw	;@08B31
	rcl	cx, 1	;@08B33
	rep movsb	;@08B35
	mov	cx, word ptr ds:[345Ch]	;@08B37
	cmp	cx, word ptr ds:[482h]	;@08B3B
	je	@@4	;@08B3F
@@2:	pop	cx	;@08B41
	pop	bx	;@08B42
	push	cs	;@08B43
	pop	es	;@08B44
	ret	;@08B45
@@3:	push	cx	;@08B46
	mov	cx, bx	;@08B47
	add	ax, cx	;@08B49
	adc	dl, dh	;@08B4B
	shr	cx, 1	;@08B4D
	rep movsw	;@08B4F
	rcl	cx, 1	;@08B51
	rep movsb	;@08B53
	pop	cx	;@08B55
	sub	cx, bx	;@08B56
	jmp	@@1	;@08B58
@@4:	cmp	di, word ptr ds:[484h]	;@08B5A
	jb	@@2	;@08B5E
	mov	word ptr ds:[484h], di	;@08B60
	jmp	@@2	;@08B64
L08B66:	push	di	;@08B66
	push	si	;@08B67
	push	bx	;@08B68
	push	cx	;@08B69
	push	dx	;@08B6A
	mov	word ptr es:[3450h], es	;@08B6B
	mov	si, 547Ah	;@08B70
	mov	ax, 0FFFFh	;@08B73
	cmp	byte ptr es:[si], 0	;@08B76
	je	@@1	;@08B7A
	mov	ds, word ptr cs:DATA_SEGMENT	;@08B7C
	mov	ah, 80h	;@08B81
	call	L0910F	;@08B83
	mov	ax, bx	;@08B86
	mov	es, word ptr cs:DATA_SEGMENT	;@08B88
	lds	bx, dword ptr es:[132h]	;@08B8D
	mov	ds, word ptr [bx]	;@08B92
@@1:	pop	dx	;@08B94
	pop	cx	;@08B95
	pop	bx	;@08B96
	pop	si	;@08B97
	pop	di	;@08B98
	ret	;@08B99
L08B9A:	push	di	;@08B9A
	push	bx	;@08B9B
	mov	di, 547Bh	;@08B9C
	mov	cx, 40h	;@08B9F
@@1:	lodsb	;@08BA2
	or	al, al	;@08BA3
	je	@@3	;@08BA5
	jcxz	@@2	;@08BA7
	dec	cx	;@08BA9
	stosb	;@08BAA
@@2:	jmp	@@1	;@08BAB
@@3:	sub	cx, 40h	;@08BAD
	neg	cx	;@08BB0
	mov	byte ptr es:[547Ah], cl	;@08BB2
	pop	bx	;@08BB7
	pop	di	;@08BB8
	ret	;@08BB9
L08BBA:	push	ds	;@08BBA
	mov	ds, word ptr cs:DATA_SEGMENT	;@08BBB
	mov	word ptr ds:[41Ah], 0	;@08BC0
	mov	word ptr ds:[82Ch], 0	;@08BC6
	pop	ds	;@08BCC
	ret	;@08BCD
L08BCE:	push	ds	;@08BCE
	mov	ds, word ptr cs:DATA_SEGMENT	;@08BCF
	xor	di, di	;@08BD4
	mov	es, word ptr ds:[82Eh]	;@08BD6
	cmp	di, word ptr ds:[82Ch]	;@08BDA
	jae	@@2	;@08BDE
@@1:	scasw	;@08BE0
	je	@@4	;@08BE1
	loop	@@1	;@08BE3
@@2:	mov	di, 2	;@08BE5
	push	di	;@08BE8
	mov	di, 82Ah	;@08BE9
	call	L054ED	;@08BEC
	jae	@@3	;@08BEF
	call	TABLE_OVERFLOW	;@08BF1
@@3:	mov	word ptr es:[di], ax	;@08BF4
@@4:	pop	ds	;@08BF7
	ret	;@08BF8
L08BF9:	push	si	;@08BF9
	inc	si	;@08BFA
	inc	si	;@08BFB
	mov	ax, 0FFFEh	;@08BFC
	cmp	byte ptr [si], 0	;@08BFF
	je	@@1	;@08C02
	call	L08B9A	;@08C04
	call	L08B66	;@08C07
@@1:	call	L08BCE	;@08C0A
	pop	si	;@08C0D
	ret	;@08C0E
L08C0F:	push	bx	;@08C0F
	push	ds	;@08C10
	push	es	;@08C11
	mov	es, word ptr cs:DATA_SEGMENT	;@08C12
	lds	bx, dword ptr es:[132h]	;@08C17
	mov	ds, word ptr [bx]	;@08C1C
	cmp	byte ptr [si], 0FFh	;@08C1E
	je	@@1	;@08C21
	jmp	@@11	;@08C23
@@1:	mov	al, byte ptr [si+1]	;@08C26
	cmp	al, 1	;@08C29
	je	@@2	;@08C2B
	cmp	al, 2	;@08C2D
	je	@@6	;@08C2F
	cmp	al, 3	;@08C31
	je	@@7	;@08C33
	cmp	al, 4	;@08C35
	je	@@8	;@08C37
	call	L087D0	;@08C39
@@2:	cmp	byte ptr es:[17h], 1	;@08C3C
	jne	@@4	;@08C42
	cmp	byte ptr es:[3477h], 1	;@08C44
	je	@@3	;@08C4A
	mov	byte ptr es:[3477h], 1	;@08C4C
	push	si	;@08C52
	xor	ax, ax	;@08C53
	push	ax	;@08C55
	mov	ax, 3Ch	;@08C56
	push	ax	;@08C59
	call WARNING	;@08C5A
	mov	es, word ptr cs:DATA_SEGMENT	;@08C5D
	lds	bx, dword ptr es:[132h]	;@08C62
	mov	ds, word ptr [bx]	;@08C67
	pop	si	;@08C69
@@3:	jmp	short @@10	;@08C6A
@@4:	xor	ah, ah	;@08C6C
	mov	word ptr es:[41Ah], ax	;@08C6E
	mov	byte ptr es:[486h], 1	;@08C72
	cmp	word ptr es:[82Eh], -1	;@08C78
	jne	@@5	;@08C7E
	push	es	;@08C80
	pop	ds	;@08C81
	push	si	;@08C82
	mov	di, 82Ah	;@08C83
	call	NEW_POOL	;@08C86
	pop	si	;@08C89
	mov	es, word ptr cs:DATA_SEGMENT	;@08C8A
	lds	bx, dword ptr es:[132h]	;@08C8F
	mov	ds, word ptr [bx]	;@08C94
@@5:	call	L08BF9	;@08C96
	jmp	short @@10	;@08C99
@@6:	call	L08BBA	;@08C9B
	jmp	short @@10	;@08C9E
@@7:	mov	al, 0	;@08CA0
	cmp	byte ptr es:[129h], 1	;@08CA2
	je	@@10	;@08CA8
	mov	al, 1	;@08CAA
	jmp	short @@9	;@08CAC
@@8:	xor	ax, ax	;@08CAE
@@9:	mov	byte ptr es:[15h], al	;@08CB0
@@10:	dec	si	;@08CB4
	dec	si	;@08CB5
	mov	si, word ptr [si]	;@08CB6
	stc	;@08CB8
	jmp	short @@12	;@08CB9
@@11:	clc	;@08CBB
@@12:	pop	es	;@08CBC
	pop	ds	;@08CBD
	pop	bx	;@08CBE
	ret	;@08CBF
L08CC0:	push	bx	;@08CC0
	push	es	;@08CC1
	les	bx, dword ptr ds:[132h]	;@08CC2
	mov	es, word ptr es:[bx]	;@08CC6
@@1:	and	si, si	;@08CC9
	je	@@3	;@08CCB
	cmp	byte ptr es:[si+2], 0FFh	;@08CCD
	jne	@@2	;@08CD2
	mov	al, byte ptr es:[si+3]	;@08CD4
	cmp	al, 3	;@08CD8
	jne	@@2	;@08CDA
	mov	byte ptr ds:[14h], 1	;@08CDC
@@2:	mov	si, word ptr es:[si]	;@08CE1
	jmp	@@1	;@08CE4
@@3:	pop	es	;@08CE6
	pop	bx	;@08CE7
	ret	;@08CE8
L08CE9:	push	si	;@08CE9
	mov	si, word ptr ds:[136h]	;@08CEA
	call	L08CC0	;@08CEE
	jb	@@1	;@08CF1
	mov	si, word ptr ds:[13Ch]	;@08CF3
	call	L08CC0	;@08CF7
	jae	@@2	;@08CFA
@@1:	mov	byte ptr ds:[14h], 1	;@08CFC
@@2:	pop	si	;@08D01
	ret	;@08D02
L08D03:	push	bp	;@08D03
	mov	bp, sp	;@08D04
	sub	sp, 80h	;@08D06
@@1:	and	si, si	;@08D0A
	jne	@@2	;@08D0C
	jmp	@@23	;@08D0E
@@2:	add	si, 2	;@08D11
	call	L08C0F	;@08D14
	jb	@@1	;@08D17
	push	si	;@08D19
	push	ds	;@08D1A
	mov	bx, 54BBh	;@08D1B
	push	bx	;@08D1E
	les	bx, dword ptr ds:[132h]	;@08D1F
	push	word ptr es:[bx]	;@08D23
	push	si	;@08D26
	call	far ptr STRING_COPY	;@08D27
	cmp	word ptr ds:[140h], 0	;@08D2C
	je	@@4	;@08D31
	cmp	byte ptr ds:[3D5h], 1	;@08D33
	je	@@3	;@08D38
	cmp	byte ptr ds:[3D5h], 4	;@08D3A
	je	@@3	;@08D3F
	mov	ax, word ptr ds:[54BBh]	;@08D41
	cmp	ax, 3043h	;@08D44
	je	@@3	;@08D47
	cmp	ax, 3063h	;@08D49
	jne	@@4	;@08D4C
@@3:	push	ds	;@08D4E
	pop	es	;@08D4F
	mov	di, 54BBh	;@08D50
	push	es	;@08D53
	push	di	;@08D54
	call	far ptr STRING_LENGTH	;@08D55
	mov	cx, ax	;@08D5A
	mov	al, 5Ch	;@08D5C
	repne scasb	;@08D5E
	je	@@4	;@08D60
	push	ds	;@08D62
	mov	ax, 54BBh	;@08D63
	push	ax	;@08D66
	call L0971B	;@08D67
	jae	@@4	;@08D6A
	les	bx, dword ptr ds:[132h]	;@08D6C
	push	word ptr es:[bx]	;@08D70
	mov	ax, word ptr ds:[140h]	;@08D73
	push	ax	;@08D76
	mov	di, 54BBh	;@08D77
	push	ds	;@08D7A
	push	di	;@08D7B
	lea	ax, [bp-80h]	;@08D7C
	push	ss	;@08D7F
	push	ax	;@08D80
	mov	ax, 80h	;@08D81
	push	ax	;@08D84
	call L096B5	;@08D85
	jb	@@4	;@08D88
	mov	di, 54BBh	;@08D8A
	push	ds	;@08D8D
	pop	es	;@08D8E
	push	ss	;@08D8F
	pop	ds	;@08D90
	lea	si, [bp-80h]	;@08D91
	mov	cx, 80h	;@08D94
	rep movsb	;@08D97
	mov	ds, word ptr cs:DATA_SEGMENT	;@08D99
@@4:	xor	dx, dx	;@08D9E
	mov	word ptr ds:[3468h], dx	;@08DA0
	mov	word ptr ds:[346Ah], dx	;@08DA4
	mov	word ptr ds:[346Ch], dx	;@08DA8
	mov	word ptr ds:[346Eh], dx	;@08DAC
	mov	byte ptr ds:[161h], dl	;@08DB0
	cmp	byte ptr ds:[3D4h], 1	;@08DB4
	jne	@@5	;@08DB9
	jmp	@@13	;@08DBB
@@5:	push	ds	;@08DBE
	cmp	byte ptr ds:[3D5h], 1	;@08DBF
	jne	@@6	;@08DC4
	mov	dx, 54BBh	;@08DC6
	call	FILE_SIZE	;@08DC9
	mov	word ptr ds:[250h], ax	;@08DCC
	mov	word ptr ds:[252h], dx	;@08DCF
@@6:	mov	ax, 3D00h	;@08DD3
	mov	dx, 54BBh	;@08DD6
	call	OPEN_FILE	;@08DD9
	pop	ds	;@08DDC
	cmp	word ptr ds:[345Ah], 0	;@08DDD
	je	@@7	;@08DE2
	mov	si, word ptr ds:[494h]	;@08DE4
	mov	word ptr [si], ax	;@08DE8
	mov	word ptr [si+6], 0	;@08DEA
@@7:	mov	word ptr ds:[24h], ax	;@08DEF
	xchg	ax, bx	;@08DF2
	mov	ah, 3Fh	;@08DF3
	mov	dx, 144Eh	;@08DF5
	mov	cx, 2000h	;@08DF8
	cmp	byte ptr ds:[254h], 0	;@08DFB
	jne	@@8	;@08E00
	cmp	byte ptr ds:[3D5h], 1	;@08E02
	jne	@@8	;@08E07
	mov	cx, 200h	;@08E09
@@8:	call	DOS_CALL	;@08E0C
	or	ax, ax	;@08E0F
	je	@@12	;@08E11
	add	word ptr ds:[346Ch], ax	;@08E13
	adc	word ptr ds:[346Eh], 0	;@08E17
	add	dx, ax	;@08E1C
	mov	word ptr ds:[3458h], dx	;@08E1E
	cmp	byte ptr ds:[3D5h], 1	;@08E22
	jne	@@9	;@08E27
	jmp	@@19	;@08E29
@@9:	cmp	ax, 2000h	;@08E2C
	jb	@@10	;@08E2F
	jmp	@@19	;@08E31
@@10:	cmp	byte ptr ds:[0Ah], 0	;@08E34
	jne	@@11	;@08E39
	jmp	@@19	;@08E3B
@@11:	call	@@24	;@08E3E
	jmp	@@19	;@08E41
@@12:	call	L0885D	;@08E44
@@13:	mov	si, word ptr ds:[494h]	;@08E47
	mov	al, byte ptr [si+8]	;@08E4B
	mov	byte ptr ds:[3478h], al	;@08E4E
	mov	ax, word ptr [si+6]	;@08E51
	mov	word ptr ds:[3462h], ax	;@08E54
	or	al, ah	;@08E57
	mov	byte ptr ds:[161h], al	;@08E59
	mov	ax, word ptr [si+2]	;@08E5C
	mov	word ptr ds:[3464h], ax	;@08E5F
	mov	ax, word ptr [si+4]	;@08E62
	mov	word ptr ds:[3466h], ax	;@08E65
	cmp	byte ptr [si+9], 1	;@08E68
	jne	@@15	;@08E6C
	cmp	word ptr [si+0Ch], 1000h	;@08E6E
	jae	@@14	;@08E73
	push	si	;@08E75
	lea	bx, [si+0Ch]	;@08E76
	push	ds	;@08E79
	push	bx	;@08E7A
	call	far ptr HEAP_MODE_SET_BIT13	;@08E7B
	pop	si	;@08E80
	and	ax, ax	;@08E81
	je	@@14	;@08E83
	mov	byte ptr [si+9], 0	;@08E85
	jmp	short @@15	;@08E89
@@14:	mov	bx, ds	;@08E8B
	mov	di, 144Eh	;@08E8D
	sub	ax, ax	;@08E90
	mov	cx, word ptr [si+0Ah]	;@08E92
	mov	ds, word ptr [si+0Ch]	;@08E95
	mov	es, bx	;@08E98
	xchg	ax, si	;@08E9A
	cld	;@08E9B
	shr	cx, 1	;@08E9C
	rep movsw	;@08E9E
	rcl	cx, 1	;@08EA0
	rep movsb	;@08EA2
	xchg	ax, si	;@08EA4
	mov	ds, bx	;@08EA5
	mov	word ptr ds:[3458h], di	;@08EA7
	mov	byte ptr [si+9], 0	;@08EAB
	push	ds	;@08EAF
	lea	ax, [si+0Ch]	;@08EB0
	push	ax	;@08EB3
	call	far ptr FREE_HANDLE_BLOCK	;@08EB4
	jmp	short @@19	;@08EB9
@@15:	mov	ax, word ptr [si]	;@08EBB
	and	ax, ax	;@08EBD
	je	@@16	;@08EBF
	mov	word ptr ds:[24h], ax	;@08EC1
	mov	bx, ax	;@08EC4
	xor	cx, cx	;@08EC6
	mov	dx, cx	;@08EC8
	mov	ax, 4200h	;@08ECA
	call	DOS_CALL	;@08ECD
	jmp	short @@17	;@08ED0
@@16:	push	ds	;@08ED2
	mov	dx, 54BBh	;@08ED3
	mov	ax, 3D00h	;@08ED6
	call	OPEN_FILE	;@08ED9
	pop	ds	;@08EDC
	mov	word ptr ds:[24h], ax	;@08EDD
@@17:	mov	bx, word ptr ds:[24h]	;@08EE0
	mov	ah, 3Fh	;@08EE4
	mov	dx, 144Eh	;@08EE6
	mov	cx, 2000h	;@08EE9
	call	DOS_CALL	;@08EEC
	or	ax, ax	;@08EEF
	jne	@@18	;@08EF1
	jmp	@@12	;@08EF3
@@18:	add	word ptr ds:[346Ch], ax	;@08EF6
	adc	word ptr ds:[346Eh], 0	;@08EFA
	add	dx, ax	;@08EFF
	mov	word ptr ds:[3458h], dx	;@08F01
@@19:	push	bp	;@08F05
	call	L05942	;@08F06
	pop	bp	;@08F09
	mov	bx, word ptr ds:[24h]	;@08F0A
	mov	si, word ptr ds:[494h]	;@08F0E
	cmp	byte ptr ds:[3D4h], 1	;@08F12
	je	@@20	;@08F17
	cmp	word ptr ds:[345Ah], 0	;@08F19
	je	@@21	;@08F1E
	cmp	byte ptr [si+9], 0	;@08F20
	je	@@22	;@08F24
	jmp	short @@21	;@08F26
@@20:	cmp	byte ptr [si+9], 0	;@08F28
	je	@@21	;@08F2C
	push	bx	;@08F2E
	push	ds	;@08F2F
	add	si, 0Ch	;@08F30
	push	si	;@08F33
	call	far ptr FREE_HANDLE_BLOCK	;@08F34
	pop	bx	;@08F39
	jmp	short @@22	;@08F3A
@@21:	mov	word ptr [si], 0	;@08F3C
	call	CLOSE_FILE	;@08F40
@@22:	mov	word ptr ds:[24h], 0FFFFh	;@08F43
	add	word ptr ds:[494h], 0Eh	;@08F49
	les	si, dword ptr ds:[132h]	;@08F4E
	mov	es, word ptr es:[si]	;@08F52
	pop	si	;@08F55
	mov	si, word ptr es:[si-2]	;@08F56
	jmp	@@1	;@08F5A
@@23:	mov	sp, bp	;@08F5D
	pop	bp	;@08F5F
	ret	;@08F60
L08F61	dd	L08FDD	;@08F61
@@24:	push	si	;@08F65
	push	di	;@08F66
	push	ax	;@08F67
	call	far ptr HEAP_SPACE_BELOW_LIMIT	;@08F68
	pop	bx	;@08F6D
	shr	dx, 1	;@08F6E
	rcr	ax, 1	;@08F70
	shr	dx, 1	;@08F72
	rcr	ax, 1	;@08F74
	sub	ax, bx	;@08F76
	sbb	dl, dh	;@08F78
	jl	@@25	;@08F7A
	mov	si, word ptr ds:[494h]	;@08F7C
	mov	word ptr [si+0Ah], bx	;@08F80
	push	ds	;@08F83
	add	si, 0Ch	;@08F84
	push	si	;@08F87
	push	bx	;@08F88
	call	far ptr POOL_INIT	;@08F89
	and	ax, ax	;@08F8E
	jne	@@25	;@08F90
	mov	si, word ptr ds:[494h]	;@08F92
	mov	byte ptr [si+9], 1	;@08F96
	mov	es, word ptr [si+0Ch]	;@08F9A
	sub	di, di	;@08F9D
	mov	cx, word ptr [si+0Ah]	;@08F9F
	mov	ax, 144Eh	;@08FA2
	cld	;@08FA5
	xchg	ax, si	;@08FA6
	shr	cx, 1	;@08FA7
	rep movsw	;@08FA9
	rcl	cx, 1	;@08FAB
	rep movsb	;@08FAD
	xchg	ax, si	;@08FAF
	push	ds	;@08FB0
	lea	ax, [si+0Ch]	;@08FB1
	push	ax	;@08FB4
	push	word ptr cs:L08F61+2	;@08FB5
	push	word ptr cs:L08F61	;@08FBA
	call	far ptr SET_NODE_INFO	;@08FBF
	push	ds	;@08FC4
	mov	si, word ptr ds:[494h]	;@08FC5
	lea	ax, [si+0Ch]	;@08FC9
	push	ax	;@08FCC
	call	far ptr HEAP_MODE_SET_BITS56	;@08FCD
	pop	di	;@08FD2
	pop	si	;@08FD3
	ret	;@08FD4
@@25:	mov	byte ptr ds:[0Ah], 0	;@08FD5
	pop	di	;@08FDA
	pop	si	;@08FDB
	ret	;@08FDC
L08FDD:	push	bp	;@08FDD
	mov	bp, sp	;@08FDE
	push	ds	;@08FE0
	mov	ds, word ptr cs:DATA_SEGMENT	;@08FE1
	cmp	word ptr [bp+0Ch], 1	;@08FE6
	jne	@@1	;@08FEA
	mov	byte ptr ds:[0Ah], 0	;@08FEC
	mov	bx, word ptr [bp+8]	;@08FF1
	sub	bx, 0Ch	;@08FF4
	mov	byte ptr [bx+9], 0	;@08FF7
@@1:	mov	ax, 1	;@08FFB
	pop	ds	;@08FFE
	pop	bp	;@08FFF
	retf	8	;@09000
L09003:	mov	dx, word ptr es:[di+0Ch]	;@09003
	push	si	;@09007
	mov	si, 732h	;@09008
	push	si	;@0900B
	mov	si, word ptr [si+2]	;@0900C
	sub	si, 18h	;@0900F
@@1:	mov	bl, byte ptr es:[di+10h]	;@09012
	mov	bh, 0	;@09016
	add	di, word ptr cs:L05780[bx]	;@09018
	cmp	di, si	;@0901D
	jae	@@4	;@0901F
@@2:	cmp	dx, word ptr es:[di+0Ch]	;@09021
	jae	@@5	;@09025
	cmp	word ptr es:[di+0Ah], 2	;@09027
	jb	@@1	;@0902C
	add	sp, 2	;@0902E
	pop	si	;@09031
	mov	word ptr ds:[3E2h], di	;@09032
	mov	ax, word ptr es:[di+0Ch]	;@09036
	mul	word ptr ds:[3462h]	;@0903A
	cmp	dx, word ptr ds:[346Eh]	;@0903E
	ja	@@7	;@09042
	jb	@@3	;@09044
	cmp	ax, word ptr ds:[346Ch]	;@09046
	jae	@@7	;@0904A
@@3:	mov	si, 144Eh	;@0904C
	sub	ax, word ptr ds:[3468h]	;@0904F
	add	si, ax	;@09053
	jmp	L059B4	;@09055
@@4:	pop	si	;@09058
	cmp	si, 742h	;@09059
	ja	@@6	;@0905D
	and	di, 3	;@0905F
	add	si, 8	;@09062
	push	si	;@09065
	push	di	;@09066
	and	di, 3	;@09067
	shl	di, 1	;@0906A
	shl	di, 1	;@0906C
	shl	di, 1	;@0906E
	mov	es, word ptr [di+736h]	;@09070
	pop	di	;@09074
	jmp	@@2	;@09075
@@5:	add	sp, 2	;@09077
@@6:	mov	word ptr ds:[3E2h], di	;@0907A
	pop	si	;@0907E
	ret	;@0907F
@@7:	mov	cx, ax	;@09080
	and	ax, 0FC00h	;@09082
	xor	cx, ax	;@09085
	push	cx	;@09087
	mov	cx, dx	;@09088
	xchg	ax, dx	;@0908A
	mov	bx, word ptr ds:[24h]	;@0908B
	mov	ax, 4200h	;@0908F
	call	DOS_CALL	;@09092
	mov	word ptr ds:[3468h], ax	;@09095
	mov	word ptr ds:[346Ah], dx	;@09098
	mov	word ptr ds:[346Ch], ax	;@0909C
	mov	word ptr ds:[346Eh], dx	;@0909F
	mov	cx, 2000h	;@090A3
	cmp	byte ptr ds:[161h], 0	;@090A6
	je	@@8	;@090AB
	sub	ax, word ptr ds:[3464h]	;@090AD
	sbb	dx, word ptr ds:[3466h]	;@090B1
	not	dx	;@090B5
	neg	ax	;@090B7
	sbb	dx, -1	;@090B9
	jne	@@8	;@090BC
	cmp	ax, cx	;@090BE
	ja	@@8	;@090C0
	xchg	ax, cx	;@090C2
@@8:	mov	ah, 3Fh	;@090C3
	mov	bx, word ptr ds:[24h]	;@090C5
	mov	dx, 144Eh	;@090C9
	call	DOS_CALL	;@090CC
	add	word ptr ds:[346Ch], ax	;@090CF
	adc	word ptr ds:[346Eh], 0	;@090D3
	add	ax, 144Eh	;@090D8
	mov	word ptr ds:[3458h], ax	;@090DB
	pop	si	;@090DE
	add	si, 144Eh	;@090DF
	jmp	L059B4	;@090E3
L090E6:	mov	si, word ptr ds:[528h]	;@090E6
	call PUT_PLAIN_NAME	;@090EA
	ret	;@090ED
L090EE:	push	si	;@090EE
	and	si, 3	;@090EF
	shl	si, 1	;@090F2
	shl	si, 1	;@090F4
	shl	si, 1	;@090F6
	mov	es, word ptr [si+736h]	;@090F8
	pop	si	;@090FC
	mov	si, word ptr es:[si]	;@090FD
	call	PUT_PLAIN_NAME	;@09100
	ret	;@09103
L09104:	call PUT_NEWLINE	;@09104
	call CONSOLE_OFF	;@09107
	ret	;@0910A
L0910B:	mov	word ptr ds:[3450h], ds	;@0910B
L0910F:	push	bp	;@0910F
	push	dx	;@09110
	push	di	;@09111
	mov	dl, byte ptr ds:[120h]	;@09112
	push	ds	;@09116
	pop	es	;@09117
	mov	di, 547Ah	;@09118
	mov	ds, word ptr ds:[3450h]	;@0911B
	cld	;@0911F
	lodsb	;@09120
	and	al, 3Fh	;@09121
	mov	bx, ax	;@09123
	or	ah, al	;@09125
	mov	byte ptr es:[di], ah	;@09127
	inc	di	;@0912A
	mov	ah, 0	;@0912B
	mov	cx, ax	;@0912D
	jcxz	@@5	;@0912F
	push	cx	;@09131
	or	dl, dl	;@09132
	jne	@@3	;@09134
@@1:	lodsb	;@09136
	cmp	al, 61h	;@09137
	jb	@@2	;@09139
	cmp	al, 7Ah	;@0913B
	ja	@@2	;@0913D
	sub	al, 20h	;@0913F
@@2:	stosb	;@09141
	xor	bl, al	;@09142
	rol	bx, 1	;@09144
	loop	@@1	;@09146
	jmp	short @@4	;@09148
@@3:	lodsb	;@0914A
	stosb	;@0914B
	xor	bl, al	;@0914C
	rol	bx, 1	;@0914E
	dec	cx	;@09150
	je	@@4	;@09151
	lodsb	;@09153
	stosb	;@09154
	xor	bl, al	;@09155
	rol	bx, 1	;@09157
	loop	@@3	;@09159
@@4:	pop	ax	;@0915B
@@5:	push	si	;@0915C
	inc	ax	;@0915D
	push	es	;@0915E
	pop	ds	;@0915F
	xor	bl, bh	;@09160
	mov	si, 547Ah	;@09162
	and	bx, 1FFEh	;@09165
	mov	word ptr ds:[3452h], bx	;@09169
	add	bx, 347Ah	;@0916D
	mov	dx, ds	;@09171
	mov	di, word ptr [bx]	;@09173
	cmp	di, -1	;@09175
	je	@@10	;@09178
	mov	dx, si	;@0917A
@@6:	mov	bp, di	;@0917C
	mov	cx, ax	;@0917E
	push	di	;@09180
	and	di, 3	;@09181
	shl	di, 1	;@09184
	shl	di, 1	;@09186
	shl	di, 1	;@09188
	mov	es, word ptr [di+716h]	;@0918A
	pop	di	;@0918E
	inc	di	;@0918F
	inc	di	;@09190
	repe cmpsb	;@09191
	jne	@@9	;@09193
@@7:	mov	bx, bp	;@09195
	pop	si	;@09197
	pop	di	;@09198
	pop	dx	;@09199
	pop	bp	;@0919A
	clc	;@0919B
	ret	;@0919C
@@8:	pop	si	;@0919D
	pop	di	;@0919E
	pop	dx	;@0919F
	pop	bp	;@091A0
	stc	;@091A1
	ret	;@091A2
@@9:	mov	si, dx	;@091A3
	lea	bx, [bp-2]	;@091A5
	mov	di, word ptr es:[bx]	;@091A8
	cmp	di, -1	;@091AB
	jne	@@6	;@091AE
	xor	dx, dx	;@091B0
@@10:	cmp	byte ptr ds:[3476h], 2	;@091B2
	je	@@8	;@091B7
	mov	cx, ax	;@091B9
	add	ax, 7	;@091BB
	and	al, 0FCh	;@091BE
	cmp	byte ptr ds:[14h], 0	;@091C0
	je	@@11	;@091C5
	add	ax, 4	;@091C7
@@11:	push	bx	;@091CA
	mov	bx, word ptr ds:[718h]	;@091CB
	les	di, dword ptr [bx+2]	;@091CF
	add	di, ax	;@091D2
	cmp	di, word ptr [bx]	;@091D4
	ja	@@15	;@091D6
	xchg	word ptr [bx+2], di	;@091D8
	pop	bx	;@091DB
@@12:	xor	ax, ax	;@091DC
	cmp	byte ptr ds:[14h], 0	;@091DE
	je	@@13	;@091E3
	stosw	;@091E5
	stosw	;@091E6
@@13:	dec	ax	;@091E7
	stosw	;@091E8
	push	di	;@091E9
	stosw	;@091EA
	shr	cx, 1	;@091EB
	rep movsw	;@091ED
	rcl	cx, 1	;@091EF
	rep movsb	;@091F1
	pop	di	;@091F3
	push	ds	;@091F4
	and	dx, dx	;@091F5
	jne	@@14	;@091F7
	inc	bx	;@091F9
	inc	bx	;@091FA
	push	bx	;@091FB
	and	bx, 3	;@091FC
	shl	bx, 1	;@091FF
	shl	bx, 1	;@09201
	shl	bx, 1	;@09203
	mov	ds, word ptr [bx+716h]	;@09205
	pop	bx	;@09209
	dec	bx	;@0920A
	dec	bx	;@0920B
@@14:	mov	word ptr [bx], di	;@0920C
	mov	bp, di	;@0920E
	pop	ds	;@09210
	jmp	@@7	;@09211
@@15:	call	L05519	;@09213
	pop	bx	;@09216
	jae	@@12	;@09217
L09219:	call	TABLE_OVERFLOW	;@09219
L0921C:	call	L0910F	;@0921C
	cmp	word ptr es:[bx], -1	;@0921F
	jne	@@2	;@09223
@@1:	stc	;@09225
	ret	;@09226
@@2:	mov	bx, word ptr es:[bx]	;@09227
	push	bx	;@0922A
	and	bx, 3	;@0922B
	shl	bx, 1	;@0922E
	shl	bx, 1	;@09230
	shl	bx, 1	;@09232
	mov	es, word ptr [bx+756h]	;@09234
	pop	bx	;@09238
	test	byte ptr es:[bx+0Eh], 1	;@09239
	jne	@@3	;@0923E
	push	bx	;@09240
	mov	bx, word ptr es:[bx]	;@09241
	mov	es, word ptr ds:[776h]	;@09244
	cmp	byte ptr es:[bx+9], 0FFh	;@09248
	pop	bx	;@0924D
	je	@@1	;@0924E
@@3:	clc	;@09250
	ret	;@09251
L09252:	cmp	cx, 2	;@09252
	ja	@@1	;@09255
	ret	;@09257
@@1:	mov	dx, cx	;@09258
	shr	dx, 1	;@0925A
	and	dx, -2	;@0925C
@@2:	mov	ax, dx	;@0925F
	mov	bx, ax	;@09261
@@3:	shl	bx, 1	;@09263
	cmp	bx, cx	;@09265
	ja	@@5	;@09267
	mov	si, word ptr es:[bx-2]	;@09269
	je	@@4	;@0926D
	mov	di, word ptr es:[bx]	;@0926F
	call	bp	;@09272
	jae	@@4	;@09274
	add	bx, 2	;@09276
	mov	si, di	;@09279
@@4:	mov	di, si	;@0927B
	mov	si, ax	;@0927D
	mov	si, word ptr es:[si-2]	;@0927F
	call	bp	;@09283
	jae	@@5	;@09285
	mov	word ptr es:[bx-2], si	;@09287
	mov	si, ax	;@0928B
	mov	word ptr es:[si-2], di	;@0928D
	mov	ax, bx	;@09291
	jmp	@@3	;@09293
@@5:	sub	dx, 2	;@09295
	jne	@@2	;@09298
	mov	dx, cx	;@0929A
	sub	dx, 2	;@0929C
@@6:	sub	bx, bx	;@0929F
	mov	ax, word ptr es:[bx]	;@092A1
	mov	di, dx	;@092A4
	push	word ptr es:[di]	;@092A6
	mov	word ptr es:[di], ax	;@092A9
	sub	dx, 2	;@092AC
@@7:	mov	ax, bx	;@092AF
	inc	bx	;@092B1
	shl	bx, 1	;@092B2
	cmp	bx, dx	;@092B4
	ja	@@9	;@092B6
	mov	si, word ptr es:[bx]	;@092B8
	je	@@8	;@092BB
	mov	di, word ptr es:[bx+2]	;@092BD
	call	bp	;@092C1
	jae	@@8	;@092C3
	mov	si, di	;@092C5
	add	bx, 2	;@092C7
@@8:	mov	di, ax	;@092CA
	mov	word ptr es:[di], si	;@092CC
	jmp	@@7	;@092CF
@@9:	pop	di	;@092D1
@@10:	or	ax, ax	;@092D2
	je	@@11	;@092D4
	mov	bx, ax	;@092D6
	shr	bx, 1	;@092D8
	dec	bx	;@092DA
	and	bx, -2	;@092DB
	mov	si, word ptr es:[bx]	;@092DE
	call	bp	;@092E1
	jae	@@11	;@092E3
	xchg	ax, bx	;@092E5
	mov	word ptr es:[bx], si	;@092E6
	jmp	@@10	;@092E9
@@11:	mov	bx, ax	;@092EB
	mov	word ptr es:[bx], di	;@092ED
	or	dx, dx	;@092F0
	jne	@@6	;@092F2
	ret	;@092F4
L092F5:	cmp	ax, 0Ah	;@092F5
	jb	@@1	;@092F8
	push	dx	;@092FA
	push	bx	;@092FB
	mov	bx, 0Ah	;@092FC
	sub	dx, dx	;@092FF
	div	bx	;@09301
	pop	bx	;@09303
	dec	cx	;@09304
	call	L092F5	;@09305
	mov	ax, dx	;@09308
	pop	dx	;@0930A
	jmp	short @@3	;@0930B
@@1:	push	ax	;@0930D
	mov	al, 20h	;@0930E
@@2:	mov	al, 20h	;@09310
	call	PUT_CHAR	;@09312
	loop	@@2	;@09315
	pop	ax	;@09317
@@3:	add	al, 30h	;@09318
	call	PUT_CHAR	;@0931A
	ret	;@0931D
L0931E:	mov	dh, 0Fh	;@0931E
	and	dl, dh	;@09320
	and	dh, al	;@09322
	xor	al, dh	;@09324
	or	al, dl	;@09326
	mov	cl, 4	;@09328
	ror	ax, cl	;@0932A
	add	ax, bx	;@0932C
	call PUT_HEX_WORD	;@0932E
	mov	al, dh	;@09331
	call PUT_HEX_DIGIT	;@09333
	call PUT_INLINE	;@09336
	db	2, 48h, 20h	;@09339
	ret	;@0933C
L0933D:	push	cx	;@0933D
	call PUT_PLAIN_NAME	;@0933E
	mov	al, 20h	;@09341
	sub	cx, word ptr ds:[7643h]	;@09343
	jbe	@@2	;@09347
@@1:	call PUT_CHAR	;@09349
	loop	@@1	;@0934C
@@2:	call PUT_CHAR	;@0934E
	pop	cx	;@09351
	ret	;@09352
L09353:	push	ds	;@09353
	mov	ds, word ptr cs:DATA_SEGMENT	;@09354
	cmp	byte ptr ds:[152h], 0	;@09359
	pop	ds	;@0935E
	je	@@2	;@0935F
	push	ds	;@09361
	mov	dx, word ptr ds:[132h]	;@09362
	cmp	dx, -1	;@09366
	je	@@1	;@09369
	mov	dx, word ptr ds:[138h]	;@0936B
	lds	bx, dword ptr ds:[132h]	;@0936F
	mov	ds, word ptr [bx]	;@09373
	add	dx, 2	;@09375
	mov	ah, 41h	;@09378
	int	21h	;@0937A
@@1:	pop	ds	;@0937C
@@2:	ret	;@0937D
L0937E:	mov	di, word ptr ds:[138h]	;@0937E
	les	bx, dword ptr ds:[132h]	;@09382
	mov	es, word ptr es:[bx]	;@09386
	add	di, 2	;@09389
	xor	al, al	;@0938C
	mov	cx, 64h	;@0938E
	repne scasb	;@09391
	cmp	word ptr es:[di-4], 6F63h	;@09393
	jne	@@1	;@09399
	cmp	byte ptr es:[di-2], 6Dh	;@0939B
@@1:	ret	;@093A0
L093A1:	push	ax	;@093A1
	sub	bx, 4001h	;@093A2
	shl	bx, 1	;@093A6
	add	bx, word ptr ds:[52Ch]	;@093A8
	mov	es, word ptr ds:[786h]	;@093AC
	mov	bx, word ptr es:[bx]	;@093B0
	push	bx	;@093B3
	and	bx, 3	;@093B4
	shl	bx, 1	;@093B7
	shl	bx, 1	;@093B9
	shl	bx, 1	;@093BB
	mov	es, word ptr [bx+756h]	;@093BD
	pop	bx	;@093C1
	push	bx	;@093C2
	mov	bx, word ptr es:[bx+0Ah]	;@093C3
	mov	es, word ptr ds:[7A6h]	;@093C7
	mov	ax, word ptr ds:[186h]	;@093CB
	jmp	short @@2	;@093CE
@@1:	cmp	ax, word ptr es:[bx+2]	;@093D0
	je	@@3	;@093D4
	mov	bx, word ptr es:[bx]	;@093D6
@@2:	cmp	bx, -1	;@093D9
	jne	@@1	;@093DC
	stc	;@093DE
	pop	bx	;@093DF
	jmp	short @@4	;@093E0
@@3:	clc	;@093E2
	add	sp, 2	;@093E3
@@4:	pop	ax	;@093E6
	ret	;@093E7
L093E8:	push	si	;@093E8
	mov	es, word ptr ds:[79Eh]	;@093E9
	mov	ax, word ptr es:[si+6]	;@093ED
	cmp	byte ptr ds:[17h], 0	;@093F1
	jne	@@2	;@093F6
	cmp	byte ptr es:[si+1], 3	;@093F8
	jl	@@1	;@093FD
	mov	si, word ptr es:[si+4]	;@093FF
	mov	es, word ptr ds:[77Eh]	;@09403
	mov	si, word ptr es:[si+4]	;@09407
	mov	si, word ptr es:[si]	;@0940B
	mov	es, word ptr ds:[79Eh]	;@0940E
@@1:	mov	ax, word ptr es:[si+8]	;@09412
@@2:	pop	si	;@09416
	ret	;@09417
L09418:	push	di	;@09418
	cmp	byte ptr ds:[17h], 0	;@09419
	je	@@1	;@0941E
	test	byte ptr es:[di+0Eh], 20h	;@09420
	jne	@@5	;@09425
@@1:	mov	di, word ptr es:[di+2]	;@09427
	cmp	di, -1	;@0942B
	je	@@3	;@0942E
	push	di	;@09430
	and	di, 3	;@09431
	shl	di, 1	;@09434
	shl	di, 1	;@09436
	shl	di, 1	;@09438
	mov	es, word ptr [di+736h]	;@0943A
	pop	di	;@0943E
	cmp	word ptr es:[di+0Ah], 2	;@0943F
	jb	@@3	;@09444
@@2:	stc	;@09446
	jmp	short @@4	;@09447
@@3:	clc	;@09449
@@4:	pop	di	;@0944A
	lahf	;@0944B
	push	di	;@0944C
	and	di, 3	;@0944D
	shl	di, 1	;@09450
	shl	di, 1	;@09452
	shl	di, 1	;@09454
	mov	es, word ptr [di+756h]	;@09456
	pop	di	;@0945A
	sahf	;@0945B
	ret	;@0945C
@@5:	mov	di, word ptr es:[di+2]	;@0945D
	mov	es, word ptr ds:[806h]	;@09461
	cmp	word ptr es:[di+6], 0	;@09465
	jne	@@2	;@0946A
	jmp	@@3	;@0946C
; CLOSE_CACHED_FILE: close one of the input files TLINK keeps open, to free a handle.
CLOSE_CACHED_FILE:	mov	word ptr ds:[345Ah], 0	;@0946E
	mov	cx, word ptr ds:[3472h]	;@09474
	jcxz	@@2	;@09478
	mov	si, word ptr ds:[3474h]	;@0947A
@@1:	mov	bx, word ptr [si]	;@0947E
	and	bx, bx	;@09480
	jne	@@3	;@09482
	add	si, 0Eh	;@09484
	loop	@@1	;@09487
@@2:	stc	;@09489
	ret	;@0948A
@@3:	mov	word ptr [si], 0	;@0948B
	push	dx	;@0948F
	call	CLOSE_FILE	;@09490
	pop	dx	;@09493
	clc	;@09494
	ret	;@09495
L09496:	xor	dx, dx	;@09496
	xor	ax, ax	;@09498
	mov	cx, 0Eh	;@0949A
	mov	si, 136h	;@0949D
	call	@@1	;@094A0
	mov	si, 13Ch	;@094A3
	call	@@1	;@094A6
	mov	word ptr ds:[3470h], si	;@094A9
	mov	word ptr ds:[3472h], dx	;@094AD
	add	ax, 1C0h	;@094B1
	push	ax	;@094B4
	call	L094FA	;@094B5
	pop	cx	;@094B8
	mov	word ptr ds:[3474h], di	;@094B9
	xor	ax, ax	;@094BD
	shr	cx, 1	;@094BF
	rep stosw	;@094C1
	mov	ax, 200h	;@094C3
	call	L094FA	;@094C6
	mov	word ptr ds:[180h], di	;@094C9
	add	di, 200h	;@094CD
	mov	word ptr ds:[17Eh], di	;@094D1
	mov	word ptr ds:[17Ch], 20h	;@094D5
	ret	;@094DB
@@1:	push	ds	;@094DC
	mov	es, word ptr cs:DATA_SEGMENT	;@094DD
	lds	bx, dword ptr ds:[132h]	;@094E2
	mov	ds, word ptr [bx]	;@094E6
@@2:	mov	bx, word ptr es:[si]	;@094E8
	push	ds	;@094EB
	pop	es	;@094EC
	and	bx, bx	;@094ED
	je	@@3	;@094EF
	add	ax, cx	;@094F1
	inc	dx	;@094F3
	mov	si, bx	;@094F4
	jmp	@@2	;@094F6
@@3:	pop	ds	;@094F8
	ret	;@094F9
L094FA:	mov	di, word ptr ds:[0Ch]	;@094FA
	add	ax, di	;@094FE
	mov	word ptr ds:[0Ch], ax	;@09500
	cmp	ax, word ptr ds:[0Eh]	;@09503
	jae	@@1	;@09507
	push	ds	;@09509
	pop	es	;@0950A
	ret	;@0950B
@@1:	jmp	OUT_OF_MEMORY	;@0950C
L0950F:	push	dx	;@0950F
	mov	ax, 3700h	;@09510
	int	21h	;@09513
	mov	al, dl	;@09515
	pop	dx	;@09517
	ret	;@09518
L09519:	push	bx	;@09519
	push	ds	;@0951A
	mov	ah, 0	;@0951B
	cmp	si, word ptr ds:[42Ch]	;@0951D
	jne	@@1	;@09521
	inc	ah	;@09523
@@1:	and	al, 1Ch	;@09525
	cmp	al, 14h	;@09527
	jne	@@2	;@09529
	inc	ah	;@0952B
@@2:	mov	al, 0FFh	;@0952D
	dec	ah	;@0952F
	jg	@@5	;@09531
	mov	al, 2	;@09533
	cmp	si, word ptr ds:[452h]	;@09535
	je	@@5	;@09539
	mov	al, 0	;@0953B
	cmp	si, -1	;@0953D
	je	@@5	;@09540
	cmp	byte ptr ds:[486h], 0	;@09542
	je	@@3	;@09547
	mov	al, 4	;@09549
	cmp	si, word ptr ds:[450h]	;@0954B
	je	@@5	;@0954F
	mov	al, 3	;@09551
	cmp	si, word ptr ds:[44Eh]	;@09553
	je	@@5	;@09557
@@3:	mov	al, 0FDh	;@09559
	cmp	si, word ptr ds:[436h]	;@0955B
	je	@@5	;@0955F
	mov	al, 1	;@09561
	push	si	;@09563
	and	si, 3	;@09564
	shl	si, 1	;@09567
	shl	si, 1	;@09569
	shl	si, 1	;@0956B
	mov	ds, word ptr [si+716h]	;@0956D
	pop	si	;@09571
	mov	bl, byte ptr [si+2]	;@09572
	and	bx, 3Fh	;@09575
	cmp	bl, 4	;@09578
	jb	@@4	;@0957B
	cmp	word ptr [bx+si+1], 4544h	;@0957D
	jne	@@4	;@09582
	cmp	word ptr [bx+si-1], 4F43h	;@09584
	je	@@5	;@09589
@@4:	mov	al, 0	;@0958B
@@5:	cbw	;@0958D
	pop	ds	;@0958E
	pop	bx	;@0958F
	ret	;@09590
L09591:	push	si	;@09591
	mov	al, byte ptr es:[si+9]	;@09592
	mov	si, word ptr es:[si+2]	;@09596
	call	L09519	;@0959A
	pop	si	;@0959D
	mov	es, word ptr ds:[776h]	;@0959E
	ret	;@095A2
L095A3:	push	bp	;@095A3
	mov	bp, sp	;@095A4
	push	ds	;@095A6
	push	es	;@095A7
	push	si	;@095A8
	push	di	;@095A9
	push	ax	;@095AA
	push	cx	;@095AB
	les	di, dword ptr [bp+8]	;@095AC
	lds	si, dword ptr [bp+4]	;@095AF
	lodsb	;@095B2
	mov	cl, al	;@095B3
	and	cx, 3Fh	;@095B5
	rep movsb	;@095B8
	xor	ax, ax	;@095BA
	stosb	;@095BC
	pop	cx	;@095BD
	pop	ax	;@095BE
	pop	di	;@095BF
	pop	si	;@095C0
	pop	es	;@095C1
	pop	ds	;@095C2
	mov	sp, bp	;@095C3
	pop	bp	;@095C5
	ret	8	;@095C6
L095C9:	push	bx	;@095C9
	mov	bx, word ptr ds:[20h]	;@095CA
	call	CLOSE_FILE	;@095CE
	mov	bx, word ptr ds:[22h]	;@095D1
	call	CLOSE_FILE	;@095D5
	pop	bx	;@095D8
	ret	;@095D9
L095DA:	push	ds	;@095DA
	mov	dx, word ptr ds:[138h]	;@095DB
	cmp	dx, 0	;@095DF
	je	@@1	;@095E2
	lds	bx, dword ptr ds:[132h]	;@095E4
	mov	ds, word ptr [bx]	;@095E8
	add	dx, 2	;@095EA
	push	ds	;@095ED
	push	dx	;@095EE
	call	@@2	;@095EF
@@1:	mov	ax, 2	;@095F2
	push	ax	;@095F5
	call	@@3	;@095F6
	pop	ds	;@095F9
	ret	;@095FA
@@2:	push	bp	;@095FB
	mov	bp, sp	;@095FC
	push	ds	;@095FE
	push	dx	;@095FF
	lds	dx, dword ptr [bp+4]	;@09600
	mov	ah, 41h	;@09603
	int	21h	;@09605
	pop	dx	;@09607
	pop	ds	;@09608
	pop	bp	;@09609
	ret	4	;@0960A
@@3:	push	bp	;@0960D
	mov	bp, sp	;@0960E
	call	SHUTDOWN	;@09610
	mov	ax, word ptr [bp+4]	;@09613
	mov	ah, 4Ch	;@09616
	int	21h	;@09618
	pop	bp	;@0961A
	ret	2	;@0961B
L0961E:	push	ax	;@0961E
	mov	ax, 2	;@0961F
	push	ax	;@09622
	mov	ax, 1Eh	;@09623
	push	ax	;@09626
	call FATAL	;@09627
L0962A:	cmp	byte ptr ds:[11Dh], 1	;@0962A
	jne	@@1	;@0962F
	push	di	;@09631
	push	ax	;@09632
	push	bx	;@09633
	les	bx, dword ptr ds:[132h]	;@09634
	mov	es, word ptr es:[bx]	;@09638
	mov	di, word ptr ds:[138h]	;@0963B
	add	di, 2	;@0963F
	xor	al, al	;@09642
	mov	cx, 64h	;@09644
	repne scasb	;@09647
	pop	bx	;@09649
	pop	ax	;@0964A
	mov	word ptr es:[di-4], ax	;@0964B
	mov	byte ptr es:[di-2], bl	;@0964F
	pop	di	;@09653
@@1:	ret	;@09654
L09655:	push	bp	;@09655
	mov	bp, sp	;@09656
	push	ds	;@09658
	les	di, dword ptr [bp+4]	;@09659
@@1:	cmp	byte ptr es:[di], 0	;@0965C
	je	@@2	;@09660
	lds	si, dword ptr [bp+8]	;@09662
	mov	cx, word ptr [bp+0Ch]	;@09665
	repe cmpsb	;@09668
	je	@@3	;@0966A
	xor	ax, ax	;@0966C
	mov	cx, 0FFFFh	;@0966E
	repne scasb	;@09671
	je	@@1	;@09673
@@2:	xor	ax, ax	;@09675
	mov	dx, ax	;@09677
	jmp	short @@4	;@09679
@@3:	mov	dx, es	;@0967B
	mov	ax, di	;@0967D
@@4:	pop	ds	;@0967F
	mov	sp, bp	;@09680
	pop	bp	;@09682
	ret	0Ah	;@09683
L09686:	push	es	;@09686
	push	cx	;@09687
	push	di	;@09688
	db	0BFh	;@09689
	dw	DGROUP
	mov es, di	;@0968C
	mov	di, word ptr es:[0]	;@0968E
	mov	es, di	;@09693
	xor	di, di	;@09695
@@1:	xor	ax, ax	;@09697
	mov	cx, 0FFFFh	;@09699
	repne scasb	;@0969C
	je	@@2	;@0969E
	stc	;@096A0
	jmp	short @@3	;@096A1
@@2:	cmp	byte ptr es:[di], 0	;@096A3
	jne	@@1	;@096A7
	add	di, 3	;@096A9
	mov	dx, es	;@096AC
	mov	ax, di	;@096AE
	clc	;@096B0
@@3:	pop	di	;@096B1
	pop	cx	;@096B2
	pop	es	;@096B3
	ret	;@096B4
L096B5:	push	bp	;@096B5
	mov	bp, sp	;@096B6
	sub	sp, 4	;@096B8
	push	ds	;@096BB
	push	si	;@096BC
	lds	si, dword ptr [bp+0Eh]	;@096BD
	mov	byte ptr [bp-2], 0	;@096C0
@@1:	mov	cx, word ptr [bp+4]	;@096C4
	dec	cx	;@096C7
	les	di, dword ptr [bp+6]	;@096C8
	lodsb	;@096CB
	or	al, al	;@096CC
	jne	@@3	;@096CE
	jmp	short @@7	;@096D0
@@2:	lodsb	;@096D2
	or	al, al	;@096D3
	jne	@@3	;@096D5
	mov	byte ptr [bp-2], 1	;@096D7
	jmp	short @@4	;@096DB
@@3:	cmp	al, 3Bh	;@096DD
	je	@@4	;@096DF
	stosb	;@096E1
	loop	@@2	;@096E2
	jmp	short @@7	;@096E4
@@4:	mov	word ptr [bp+0Eh], si	;@096E6
	mov	al, 5Ch	;@096E9
	stosb	;@096EB
	lds	si, dword ptr [bp+0Ah]	;@096EC
@@5:	lodsb	;@096EF
	or	al, al	;@096F0
	je	@@6	;@096F2
	stosb	;@096F4
	loop	@@5	;@096F5
	jmp	short @@7	;@096F7
@@6:	xor	al, al	;@096F9
	stosb	;@096FB
	push	word ptr [bp+8]	;@096FC
	push	word ptr [bp+6]	;@096FF
	call	L0971B	;@09702
	jae	@@8	;@09705
	lds	si, dword ptr [bp+0Eh]	;@09707
	jmp	@@1	;@0970A
@@7:	stc	;@0970C
@@8:	mov	dx, word ptr [bp+8]	;@0970D
	mov	ax, word ptr [bp+6]	;@09710
	pop	si	;@09713
	pop	ds	;@09714
	mov	sp, bp	;@09715
	pop	bp	;@09717
	ret	0Eh	;@09718
L0971B:	push	bp	;@0971B
	mov	bp, sp	;@0971C
	sub	sp, 2Fh	;@0971E
	push	ds	;@09721
	mov	ah, 2Fh	;@09722
	int	21h	;@09724
	mov	word ptr [bp-2], es	;@09726
	mov	word ptr [bp-4], bx	;@09729
	mov	ah, 1Ah	;@0972C
	push	ss	;@0972E
	pop	ds	;@0972F
	lea	dx, [bp-2Fh]	;@09730
	int	21h	;@09733
	mov	ah, 4Eh	;@09735
	xor	cx, cx	;@09737
	lds	dx, dword ptr [bp+4]	;@09739
	int	21h	;@0973C
	pushf	;@0973E
	mov	ds, word ptr [bp-2]	;@0973F
	mov	dx, word ptr [bp-4]	;@09742
	mov	ah, 1Ah	;@09745
	int	21h	;@09747
	popf	;@09749
	pop	ds	;@0974A
	mov	sp, bp	;@0974B
	pop	bp	;@0974D
	ret	4	;@0974E
L09751:	cmp	byte ptr ds:[17h], 0	;@09751
	jne	@@2	;@09756
	mov	word ptr ds:[6CFh], 4	;@09758
	mov	word ptr ds:[3FAh], 0Fh	;@0975E
	jmp	short @@5	;@09764
@@1:	xor	ax, ax	;@09766
	push	ax	;@09768
	mov	ax, 2Dh	;@09769
	push	ax	;@0976C
	call ERROR	;@0976D
	jmp	short @@5	;@09770
@@2:	mov	cx, word ptr ds:[144h]	;@09772
	jcxz	@@1	;@09776
	xor	bx, bx	;@09778
@@3:	inc	bx	;@0977A
	shr	cx, 1	;@0977B
	jne	@@3	;@0977D
	dec	bx	;@0977F
	mov	word ptr ds:[6CFh], bx	;@09780
	mov	cx, bx	;@09784
	mov	ax, 1	;@09786
@@4:	shl	ax, 1	;@09789
	loop	@@4	;@0978B
	dec	ax	;@0978D
	mov	word ptr ds:[3FAh], ax	;@0978E
@@5:	ret	;@09791
L09792:	push	ax	;@09792
	push	bx	;@09793
	push	dx	;@09794
	mov	bx, 200h	;@09795
	div	bx	;@09798
	mov	word ptr ds:[49Ch], dx	;@0979A
	neg	dx	;@0979E
	adc	ax, 0	;@097A0
	mov	word ptr ds:[49Eh], ax	;@097A3
	pop	dx	;@097A6
	pop	bx	;@097A7
	pop	ax	;@097A8
	ret	;@097A9
	db	6 dup (0)	;@097AA
; FLUSH_OUTPUT: write the output buffer (5540h up to DI) to the map file (handle at
; [20h], unless FFFFh) and, when [7645h] is 1, to the console too; at most 2000h
; bytes at a time; whatever went past 7540h is moved back to the start.  DI is left
; at the next free byte, also kept in [7641h].
FLUSH_OUTPUT:	push	ax	;@097B0
	push	bx	;@097B1
	push	cx	;@097B2
	push	dx	;@097B3
	push	si	;@097B4
	push	es	;@097B5
	mov	cx, di	;@097B6
	mov	dx, 5540h	;@097B8
	sub	cx, dx	;@097BB
	cmp	cx, 2000h	;@097BD
	jb	@@1	;@097C1
	mov	cx, 2000h	;@097C3
@@1:	mov	ah, 40h	;@097C6
	mov	bx, word ptr ds:[20h]	;@097C8
	cmp	bx, -1	;@097CC
	je	@@2	;@097CF
	call	DOS_CALL	;@097D1
@@2:	cmp	byte ptr ds:[7645h], 1	;@097D4
	jne	@@3	;@097D9
	mov	ah, 40h	;@097DB
	mov	bx, 1	;@097DD
	call	DOS_CALL	;@097E0
@@3:	mov	si, 7540h	;@097E3
	mov	cx, di	;@097E6
	mov	di, 5540h	;@097E8
	sub	cx, si	;@097EB
	jbe	@@4	;@097ED
	push	ds	;@097EF
	pop	es	;@097F0
	cld	;@097F1
	rep movsb	;@097F2
@@4:	mov	word ptr ds:[7641h], di	;@097F4
	pop	es	;@097F8
	pop	si	;@097F9
	pop	dx	;@097FA
	pop	cx	;@097FB
	pop	bx	;@097FC
	pop	ax	;@097FD
	ret	;@097FE
; PUT_CHAR: AL to the output buffer at DI, flushing when it fills.
PUT_CHAR:	mov	byte ptr [di], al	;@097FF
	inc	di	;@09801
	cmp	di, 7540h	;@09802
	jae	@@1	;@09806
	ret	;@09808
@@1:	call	FLUSH_OUTPUT	;@09809
	ret	;@0980C
HEX_DIGITS	db	'0123456789ABCDEF'	;@0980D
; PUT_HEX_DIGIT: the low hex digit of AL to the output buffer.
PUT_HEX_DIGIT:	push	bx	;@0981D
	mov	bx, offset HEX_DIGITS	;@0981E
	and	al, 0Fh	;@09821
	xlat	byte ptr cs:[bx]	;@09823
	mov	byte ptr [di], al	;@09825
	inc	di	;@09827
	pop	bx	;@09828
	cmp	di, 7540h	;@09829
	jae	@@1	;@0982D
	ret	;@0982F
@@1:	call	FLUSH_OUTPUT	;@09830
	ret	;@09833
; HEX_BYTE: AL as two hex digits at DI (no flush).
HEX_BYTE:	push	ax	;@09834
	push	bx	;@09835
	mov	bx, offset HEX_DIGITS	;@09836
	mov	ah, al	;@09839
	and	al, 0Fh	;@0983B
	xlat	byte ptr cs:[bx]	;@0983D
	xchg	al, ah	;@0983F
	shr	al, 1	;@09841
	shr	al, 1	;@09843
	shr	al, 1	;@09845
	shr	al, 1	;@09847
	xlat	byte ptr cs:[bx]	;@09849
	mov	word ptr [di], ax	;@0984B
	inc	di	;@0984D
	inc	di	;@0984E
	pop	bx	;@0984F
	pop	ax	;@09850
	ret	;@09851
; PUT_HEX_BYTE: AL as two hex digits to the output buffer.
PUT_HEX_BYTE:	call	HEX_BYTE	;@09852
	cmp	di, 7540h	;@09855
	jae	@@1	;@09859
	ret	;@0985B
@@1:	call	FLUSH_OUTPUT	;@0985C
	ret	;@0985F
; PUT_HEX_WORD: AX as four hex digits to the output buffer.
PUT_HEX_WORD:	push	ax	;@09860
	mov	al, ah	;@09861
	call	PUT_HEX_BYTE	;@09863
	pop	ax	;@09866
	call	PUT_HEX_BYTE	;@09867
	ret	;@0986A
; HEX_WORD: AX as four hex digits at DI (no flush).
HEX_WORD:	push	ax	;@0986B
	mov	al, ah	;@0986C
	call	HEX_BYTE	;@0986E
	pop	ax	;@09871
	call	HEX_BYTE	;@09872
	ret	;@09875
; PUT_NEWLINE: CR LF to the output buffer.
PUT_NEWLINE:	mov	al, 0Dh	;@09876
	call	PUT_CHAR	;@09878
	mov	al, 0Ah	;@0987B
	jmp	PUT_CHAR	;@0987D
; PUT_PSTRING: the counted string at DS:SI to the output buffer; its length
; is kept in [7643h] (for column alignment).
PUT_PSTRING:	push	ax	;@0987F
	push	cx	;@09880
	mov	cx, 0FFh	;@09881
; PUT_PSTRING_MASKED: as PUT_PSTRING with CX the mask for the length byte.
PUT_PSTRING_MASKED:	push	es	;@09884
	push	ds	;@09885
	pop	es	;@09886
	pop	ds	;@09887
	lodsb	;@09888
	and	cx, ax	;@09889
	push	cx	;@0988B
	je	@@1	;@0988C
	rep movsb	;@0988E
@@1:	push	es	;@09890
	push	ds	;@09891
	pop	es	;@09892
	pop	ds	;@09893
	pop	word ptr ds:[7643h]	;@09894
	pop	cx	;@09898
	pop	ax	;@09899
	cmp	di, 7540h	;@0989A
	jae	@@2	;@0989E
	ret	;@098A0
@@2:	call	FLUSH_OUTPUT	;@098A1
	ret	;@098A4
; PUT_NAME_STRING: a name record's counted string (length in the low 6 bits).
PUT_NAME_STRING:	push	ax	;@098A5
	push	cx	;@098A6
	mov	cx, 3Fh	;@098A7
	jmp	PUT_PSTRING_MASKED	;@098AA
L098AC:	push	ds	;@098AC
	push	es	;@098AD
	mov	es, word ptr cs:DATA_SEGMENT	;@098AE
	cld	;@098B3
	jmp	short @@2	;@098B4
@@1:	stosb	;@098B6
@@2:	lodsb	;@098B7
	cmp	al, 0	;@098B8
	jne	@@1	;@098BA
	pop	es	;@098BC
	pop	ds	;@098BD
	cmp	di, 7540h	;@098BE
	jae	@@3	;@098C2
	ret	;@098C4
@@3:	push	ds	;@098C5
	mov	ds, word ptr cs:DATA_SEGMENT	;@098C6
	call	FLUSH_OUTPUT	;@098CB
	pop	ds	;@098CE
	ret	;@098CF
; PUT_INLINE: print the counted string that follows the call, and return after it.
; Most messages are written this way: call PUT_INLINE / db length, 'text'.
PUT_INLINE:	pop	si	;@098D0
	push	cs	;@098D1
	pop	es	;@098D2
	call	PUT_PSTRING	;@098D3
	jmp	si	;@098D6
; DEMANGLE_NAME: copy the name at ES:SI+2 (a counted string) to 7601h as ASCIZ,
; lower-case it unless names are case sensitive ([120h]), and demangle it with
; UNMANGLE (DGROUP's C code) into the output buffer at DI.
DEMANGLE_NAME:	push	es	;@098D8
	pop	ds	;@098D9
	mov	es, word ptr cs:DATA_SEGMENT	;@098DA
	inc	si	;@098DF
	inc	si	;@098E0
	push	di	;@098E1
	mov	di, 7601h	;@098E2
	cld	;@098E5
	lodsb	;@098E6
	and	ax, 3Fh	;@098E7
	stosb	;@098EA
	xchg	ax, cx	;@098EB
	rep movsb	;@098EC
	mov	al, 0	;@098EE
	stosb	;@098F0
	push	es	;@098F1
	pop	ds	;@098F2
	mov	si, 7601h	;@098F3
	cmp	byte ptr ds:[120h], 0	;@098F6
	jne	@@3	;@098FB
	inc	si	;@098FD
@@1:	lodsb	;@098FE
	cmp	al, 5Ah	;@098FF
	ja	@@1	;@09901
	cmp	al, 41h	;@09903
	jae	@@2	;@09905
	or	al, al	;@09907
	jne	@@1	;@09909
	jmp	short @@3	;@0990B
@@2:	add	byte ptr [si-1], 20h	;@0990D
	jmp	@@1	;@09911
@@3:	pop	di	;@09913
	mov	si, 7602h	;@09914
	push	ds	;@09917
	push	si	;@09918
	push	ds	;@09919
	push	di	;@0991A
	mov	ax, 0FFh	;@0991B
	push	ax	;@0991E
	xor	ax, ax	;@0991F
	push	ax	;@09921
	push	ax	;@09922
	push	ax	;@09923
	push	ax	;@09924
	inc	ax	;@09925
	push	ax	;@09926
	mov	ax, DGROUP	;@09927
	mov	ds, ax	;@0992A
	call	far ptr UNMANGLE	;@0992C
	mov	ds, word ptr cs:DATA_SEGMENT	;@09931
	push	ds	;@09936
	pop	es	;@09937
	ret	;@09938
; PUT_SYMBOL_NAME: a symbol's name (SI = its name handle, FFFFh for none), demangled
; when it is a C++ name (starts with '@').
PUT_SYMBOL_NAME:	push	cx	;@09939
	cmp	si, -1	;@0993A
	je	@@1	;@0993D
	push	si	;@0993F
	and	si, 3	;@09940
	shl	si, 1	;@09943
	shl	si, 1	;@09945
	shl	si, 1	;@09947
	mov	es, word ptr [si+716h]	;@09949
	pop	si	;@0994D
	cmp	byte ptr es:[si+3], 40h	;@0994E
	je	@@2	;@09953
	push	si	;@09955
	inc	si	;@09956
	inc	si	;@09957
	call	PUT_NAME_STRING	;@09958
	pop	si	;@0995B
	pop	cx	;@0995C
	ret	;@0995D
@@1:	call	PUT_INLINE	;@0995E
	db	6, '(none)'	;@09961
	pop	cx	;@09968
	ret	;@09969
@@2:	push	ax	;@0996A
	push	bx	;@0996B
	push	dx	;@0996C
	push	si	;@0996D
	push	di	;@0996E
	call	DEMANGLE_NAME	;@0996F
	pop	di	;@09972
	mov	bx, di	;@09973
	mov	cx, 0FFh	;@09975
	cld	;@09978
	mov	al, 0	;@09979
	repne scasb	;@0997B
	dec	di	;@0997D
	sub	bx, di	;@0997E
	neg	bx	;@09980
	mov	word ptr ds:[7643h], bx	;@09982
	pop	si	;@09986
	pop	dx	;@09987
	pop	bx	;@09988
	pop	ax	;@09989
	pop	cx	;@0998A
	cmp	di, 7540h	;@0998B
	jae	@@3	;@0998F
	ret	;@09991
@@3:	push	ds	;@09992
	mov	ds, word ptr cs:DATA_SEGMENT	;@09993
	call	FLUSH_OUTPUT	;@09998
	pop	ds	;@0999B
	ret	;@0999C
; PUT_PLAIN_NAME: as PUT_SYMBOL_NAME, never demangled.
PUT_PLAIN_NAME:	push	cx	;@0999D
	cmp	si, -1	;@0999E
	je	@@1	;@099A1
	push	si	;@099A3
	and	si, 3	;@099A4
	shl	si, 1	;@099A7
	shl	si, 1	;@099A9
	shl	si, 1	;@099AB
	mov	es, word ptr [si+716h]	;@099AD
	pop	si	;@099B1
	push	si	;@099B2
	inc	si	;@099B3
	inc	si	;@099B4
	call	PUT_NAME_STRING	;@099B5
	pop	si	;@099B8
	pop	cx	;@099B9
	ret	;@099BA
@@1:	call	PUT_INLINE	;@099BB
	db	6, '(none)'	;@099BE
	pop	cx	;@099C5
	ret	;@099C6
; PUT_DECIMAL: SI as a decimal number (no leading zeros) at DI.
PUT_DECIMAL:	push	ax	;@099C7
	push	bx	;@099C8
	push	cx	;@099C9
	mov	bx, 0Ah	;@099CA
	mov	cx, 5	;@099CD
	mov	ax, 2710h	;@099D0
	cwd	;@099D3
@@1:	cmp	ax, si	;@099D4
	jbe	@@2	;@099D6
	div	bx	;@099D8
	loop	@@1	;@099DA
	mov	al, 30h	;@099DC
	mov	byte ptr [di], al	;@099DE
	inc	di	;@099E0
	jmp	short @@3	;@099E1
@@2:	xchg	ax, si	;@099E3
	div	si	;@099E4
	push	dx	;@099E6
	push	si	;@099E7
	add	al, 30h	;@099E8
	push	bx	;@099EA
	push	cx	;@099EB
	mov	byte ptr [di], al	;@099EC
	inc	di	;@099EE
	pop	cx	;@099EF
	pop	bx	;@099F0
	pop	ax	;@099F1
	cwd	;@099F2
	div	bx	;@099F3
	pop	si	;@099F5
	loop	@@2	;@099F6
@@3:	pop	cx	;@099F8
	pop	bx	;@099F9
	pop	ax	;@099FA
	ret	;@099FB
L099FC:	call	PUT_DECIMAL	;@099FC
	cmp	di, 7540h	;@099FF
	jae	@@1	;@09A03
	ret	;@09A05
@@1:	call	FLUSH_OUTPUT	;@09A06
	ret	;@09A09
L09A0A:	push	ds	;@09A0A
	push	bx	;@09A0B
	mov	si, 54BBh	;@09A0C
	call	L098AC	;@09A0F
	pop	bx	;@09A12
	pop	ds	;@09A13
	ret	;@09A14
; CONSOLE_ON: flush, then copy all further output to the console.
CONSOLE_ON:	mov	ds, word ptr cs:DATA_SEGMENT	;@09A15
	mov	di, word ptr ds:[7641h]	;@09A1A
	call	FLUSH_OUTPUT	;@09A1E
	mov	byte ptr ds:[7645h], 1	;@09A21
	ret	;@09A26
; CONSOLE_OFF: flush, then stop copying output to the console.
CONSOLE_OFF:	call	FLUSH_OUTPUT	;@09A27
	mov	byte ptr ds:[7645h], 0FFh	;@09A2A
	ret	;@09A2F
; COPY_NAME: the name of handle SI to ES:DI as an ASCIZ string.
COPY_NAME:	push	ds	;@09A30
	mov	es, word ptr cs:DATA_SEGMENT	;@09A31
	push	si	;@09A36
	and	si, 3	;@09A37
	shl	si, 1	;@09A3A
	shl	si, 1	;@09A3C
	shl	si, 1	;@09A3E
	mov	ds, word ptr [si+716h]	;@09A40
	pop	si	;@09A44
	lodsw	;@09A45
	lodsb	;@09A46
	and	ax, 3Fh	;@09A47
	mov	cx, ax	;@09A4A
	rep movsb	;@09A4C
	xor	al, al	;@09A4E
	stosb	;@09A50
	pop	ds	;@09A51
	ret	;@09A52
; PUT_FAR_STRING: an ASCIZ far string ([bp+4]) to the output buffer.
PUT_FAR_STRING:	push	bp	;@09A53
	mov	bp, sp	;@09A54
	push	ds	;@09A56
	push	es	;@09A57
	push	si	;@09A58
	push	di	;@09A59
	lds	si, dword ptr [bp+4]	;@09A5A
	mov	es, word ptr cs:DATA_SEGMENT	;@09A5D
	mov	di, word ptr ds:[7641h]	;@09A62
	cld	;@09A66
	jmp	short @@2	;@09A67
@@1:	stosb	;@09A69
@@2:	lodsb	;@09A6A
	cmp	al, 0	;@09A6B
	jne	@@1	;@09A6D
	mov	ds, word ptr cs:DATA_SEGMENT	;@09A6F
	cmp	di, 7540h	;@09A74
	jb	@@3	;@09A78
	call	FLUSH_OUTPUT	;@09A7A
@@3:	mov	word ptr ds:[7641h], di	;@09A7D
	pop	di	;@09A81
	pop	si	;@09A82
	pop	es	;@09A83
	pop	ds	;@09A84
	pop	bp	;@09A85
	ret	4	;@09A86
	db	7 dup (0)	;@09A89
L09A90:	push	bp	;@09A90
	mov	bp, sp	;@09A91
	sub	sp, 8	;@09A93
	xor	ax, ax	;@09A96
	lodsb	;@09A98
	cmp	ax, 2	;@09A99
	je	@@7	;@09A9C
	cmp	ax, 1	;@09A9E
	je	@@1	;@09AA1
	call	L0885D	;@09AA3
@@1:	xor	ax, ax	;@09AA6
	lodsb	;@09AA8
	push	ax	;@09AA9
	xor	bx, bx	;@09AAA
	cmp	byte ptr [si], 0	;@09AAC
	je	@@3	;@09AAF
	xor	ax, ax	;@09AB1
	cmp	byte ptr ds:[127h], 0	;@09AB3
	je	@@2	;@09AB8
	inc	ax	;@09ABA
@@2:	push	word ptr ds:[120h]	;@09ABB
	mov	byte ptr ds:[120h], al	;@09ABF
	mov	ah, 0	;@09AC2
	call	L0910B	;@09AC4
	pop	ax	;@09AC7
	mov	byte ptr ds:[120h], al	;@09AC8
@@3:	mov	word ptr ds:[6E5h], bx	;@09ACB
	mov	word ptr ds:[6DDh], bx	;@09ACF
	mov	ah, 0C0h	;@09AD3
	call	L0910B	;@09AD5
	mov	word ptr ds:[6DFh], bx	;@09AD8
	pop	ax	;@09ADC
	or	ax, ax	;@09ADD
	je	@@4	;@09ADF
	lodsw	;@09AE1
	jmp	short @@6	;@09AE2
@@4:	cmp	byte ptr [si], 0	;@09AE4
	je	@@5	;@09AE7
	mov	ah, 0	;@09AE9
	call	L0910B	;@09AEB
	mov	word ptr ds:[6DDh], bx	;@09AEE
@@5:	xor	ax, ax	;@09AF2
@@6:	mov	word ptr ds:[6E1h], ax	;@09AF4
	mov	word ptr ds:[6E3h], 0	;@09AF7
	call	L0BAFE	;@09AFD
	mov	word ptr ds:[539h], di	;@09B00
	jmp	@@11	;@09B04
@@7:	xor	ax, ax	;@09B07
	lodsb	;@09B09
	mov	word ptr [bp-2], ax	;@09B0A
	mov	ah, 0	;@09B0D
	call	L0910B	;@09B0F
	mov	word ptr [bp-4], bx	;@09B12
	cmp	byte ptr [si], 0	;@09B15
	je	@@9	;@09B18
	xor	ax, ax	;@09B1A
	cmp	byte ptr ds:[127h], 0	;@09B1C
	je	@@8	;@09B21
	inc	ax	;@09B23
@@8:	push	word ptr ds:[120h]	;@09B24
	mov	byte ptr ds:[120h], al	;@09B28
	mov	ah, 0	;@09B2B
	call	L0910B	;@09B2D
	pop	ax	;@09B30
	mov	byte ptr ds:[120h], al	;@09B31
@@9:	mov	word ptr [bp-6], bx	;@09B34
	mov	bx, 0	;@09B37
	mov	ax, word ptr [bp-2]	;@09B3A
	test	al, 80h	;@09B3D
	je	@@10	;@09B3F
	mov	bx, word ptr [si]	;@09B41
@@10:	mov	word ptr [bp-8], bx	;@09B43
	mov	bx, word ptr [bp-6]	;@09B46
	push	bx	;@09B49
	and	bx, 3	;@09B4A
	shl	bx, 1	;@09B4D
	shl	bx, 1	;@09B4F
	shl	bx, 1	;@09B51
	mov	es, word ptr [bx+716h]	;@09B53
	pop	bx	;@09B57
	mov	bx, word ptr es:[bx]	;@09B58
	cmp	bx, -1	;@09B5B
	je	@@11	;@09B5E
	call	L0BB94	;@09B60
	mov	word ptr es:[di+4], bx	;@09B63
	mov	bx, word ptr [bp-4]	;@09B67
	mov	word ptr es:[di+2], bx	;@09B6A
	mov	bx, word ptr [bp-8]	;@09B6E
	mov	word ptr es:[di+6], bx	;@09B71
	mov	ax, word ptr [bp-2]	;@09B75
	or	al, 80h	;@09B78
	mov	byte ptr es:[di+8], al	;@09B7A
	inc	word ptr ds:[76A4h]	;@09B7E
	inc	word ptr ds:[76A6h]	;@09B82
@@11:	mov	sp, bp	;@09B86
	pop	bp	;@09B88
	ret	;@09B89
	db	60h, 4, 62h, 4, 64h, 4, 66h, 4, 68h, 4, 6Ah, 4	;@09B8A
L09B96:	push	bx	;@09B96
	push	cx	;@09B97
	push	si	;@09B98
	push	di	;@09B99
	mov	si, 9B8Ah	;@09B9A
	mov	cx, 6	;@09B9D
@@1:	mov	bx, word ptr cs:[si]	;@09BA0
	mov	bx, word ptr [bx]	;@09BA3
	cmp	bx, word ptr ds:[24Ah]	;@09BA5
	je	@@2	;@09BA9
	add	si, 2	;@09BAB
	dec	cx	;@09BAE
	jne	@@1	;@09BAF
	jmp	short @@3	;@09BB1
@@2:	not	cx	;@09BB3
	and	cx, 7	;@09BB5
	mov	byte ptr ds:[6F1h], 5	;@09BB8
	mov	byte ptr ds:[6F2h], 7	;@09BBD
	add	di, word ptr ds:[3E8h]	;@09BC2
	mov	word ptr ds:[6F3h], di	;@09BC6
	mov	word ptr ds:[6F5h], cx	;@09BCA
	mov	word ptr ds:[6F7h], 0	;@09BCE
	call	L04001	;@09BD4
@@3:	pop	di	;@09BD7
	pop	si	;@09BD8
	pop	cx	;@09BD9
	pop	bx	;@09BDA
	ret	;@09BDB
L09BDC:	push	si	;@09BDC
	push	di	;@09BDD
	push	es	;@09BDE
	mov	al, dh	;@09BDF
	shr	al, 1	;@09BE1
	shr	al, 1	;@09BE3
	cmp	al, 1	;@09BE5
	jne	@@1	;@09BE7
	mov	al, 5	;@09BE9
@@1:	mov	byte ptr ds:[6F1h], al	;@09BEB
	cmp	bx, -3	;@09BEE
	jne	@@3	;@09BF1
	mov	byte ptr ds:[6F2h], 1	;@09BF3
	mov	es, word ptr ds:[806h]	;@09BF8
	mov	si, cx	;@09BFC
	mov	bx, word ptr es:[si+2]	;@09BFE
	mov	cx, word ptr es:[si+4]	;@09C02
	and	cx, 7FFFh	;@09C06
	or	cx, cx	;@09C0A
	jne	@@2	;@09C0C
	mov	byte ptr ds:[6F2h], 2	;@09C0E
	mov	cx, word ptr es:[si+6]	;@09C13
@@2:	jmp	short @@9	;@09C17
@@3:	mov	es, word ptr ds:[79Eh]	;@09C19
	cmp	byte ptr ds:[768Bh], 1	;@09C1D
	je	@@5	;@09C22
	test	byte ptr es:[bx+13h], 1	;@09C24
	je	@@5	;@09C29
	push	cx	;@09C2B
	add	cx, word ptr ds:[21Eh]	;@09C2C
	test	byte ptr ds:[215h], 20h	;@09C30
	jne	@@4	;@09C35
	add	cx, word ptr [di+0C4Eh]	;@09C37
	cmp	dh, 8	;@09C3B
	jne	@@4	;@09C3E
	xor	cx, cx	;@09C40
@@4:	call	L0B963	;@09C42
	cmp	ax, 0FFFFh	;@09C45
	je	@@11	;@09C48
	add	sp, 2	;@09C4A
	mov	cx, ax	;@09C4D
	mov	bx, 0FFFFh	;@09C4F
	jmp	short @@6	;@09C52
@@5:	mov	bx, word ptr es:[bx+6]	;@09C54
@@6:	xor	bh, bh	;@09C58
	mov	byte ptr ds:[6F2h], 0	;@09C5A
	cmp	dh, 8	;@09C5F
	jne	@@7	;@09C62
	test	byte ptr ds:[215h], 10h	;@09C64
	jne	@@7	;@09C69
	or	byte ptr ds:[6F2h], 4	;@09C6B
	jmp	short @@8	;@09C70
@@7:	cmp	bl, 0FFh	;@09C72
	je	@@8	;@09C75
	add	cx, word ptr [di+0C4Eh]	;@09C77
@@8:	test	byte ptr ds:[6F2h], 4	;@09C7B
	jne	@@10	;@09C80
@@9:	mov	word ptr [di+0C4Eh], 0FFFFh	;@09C82
@@10:	mov	word ptr ds:[6F5h], bx	;@09C88
	mov	word ptr ds:[6F7h], cx	;@09C8C
	add	di, word ptr ds:[3E8h]	;@09C90
	mov	word ptr ds:[6F3h], di	;@09C94
	call	L04001	;@09C98
	pop	es	;@09C9B
	pop	di	;@09C9C
	pop	si	;@09C9D
	ret	;@09C9E
@@11:	push	ax	;@09C9F
	push	bx	;@09CA0
	push	dx	;@09CA1
	push	si	;@09CA2
	push	di	;@09CA3
	push	cx	;@09CA4
	mov	es, word ptr ds:[79Eh]	;@09CA5
	mov	bx, word ptr es:[bx+6]	;@09CA9
	push	bx	;@09CAD
	mov	cx, 4	;@09CAE
	push	cx	;@09CB1
	mov	ax, 39h	;@09CB2
	push	ax	;@09CB5
	call	WARNING	;@09CB6
	pop	di	;@09CB9
	pop	si	;@09CBA
	pop	dx	;@09CBB
	pop	bx	;@09CBC
	pop	ax	;@09CBD
	pop	cx	;@09CBE
	mov	es, word ptr ds:[79Eh]	;@09CBF
	jmp	@@5	;@09CC3
L09CC5:	push	es	;@09CC5
	push	si	;@09CC6
	xor	si, si	;@09CC7
	mov	es, word ptr ds:[7CEh]	;@09CC9
@@1:	cmp	si, word ptr ds:[7CCh]	;@09CCD
	jae	@@2	;@09CD1
	cmp	ax, word ptr es:[si]	;@09CD3
	je	@@4	;@09CD6
	add	si, 6	;@09CD8
	jmp	@@1	;@09CDB
@@2:	mov	di, 6	;@09CDD
	push	di	;@09CE0
	mov	di, 7CAh	;@09CE1
	call	L054ED	;@09CE4
	jae	@@3	;@09CE7
	call	TABLE_OVERFLOW	;@09CE9
@@3:	mov	word ptr es:[di], ax	;@09CEC
	mov	word ptr es:[di+4], cx	;@09CEF
	inc	word ptr es:[di+4]	;@09CF3
	mov	bx, ax	;@09CF7
	push	bx	;@09CF9
	and	bx, 3	;@09CFA
	shl	bx, 1	;@09CFD
	shl	bx, 1	;@09CFF
	shl	bx, 1	;@09D01
	mov	es, word ptr [bx+716h]	;@09D03
	pop	bx	;@09D07
	add	bx, 2	;@09D08
	mov	al, byte ptr es:[bx]	;@09D0B
	and	ax, 3Fh	;@09D0E
	inc	ax	;@09D11
	mov	bx, di	;@09D12
	jmp	short @@5	;@09D14
@@4:	mov	bx, si	;@09D16
	xor	ax, ax	;@09D18
@@5:	pop	si	;@09D1A
	pop	es	;@09D1B
	ret	;@09D1C
L09D1D:	push	bx	;@09D1D
	push	cx	;@09D1E
	push	dx	;@09D1F
	push	si	;@09D20
	push	di	;@09D21
	push	es	;@09D22
	mov	di, 7C2h	;@09D23
	call	NEW_POOL	;@09D26
	mov	di, 7CAh	;@09D29
	call	NEW_POOL	;@09D2C
	xor	si, si	;@09D2F
	xor	cx, cx	;@09D31
	jmp	short @@3	;@09D33
@@1:	mov	es, word ptr ds:[806h]	;@09D35
	cmp	word ptr es:[si+6], -1	;@09D39
	je	@@4	;@09D3E
@@2:	add	si, 0Ch	;@09D40
@@3:	cmp	si, word ptr ds:[804h]	;@09D43
	jb	@@1	;@09D47
	mov	ax, cx	;@09D49
	pop	es	;@09D4B
	pop	di	;@09D4C
	pop	si	;@09D4D
	pop	dx	;@09D4E
	pop	cx	;@09D4F
	pop	bx	;@09D50
	ret	;@09D51
@@4:	mov	ax, word ptr es:[si+2]	;@09D52
	call	L09CC5	;@09D56
	or	ax, ax	;@09D59
	je	@@6	;@09D5B
	mov	dx, bx	;@09D5D
	mov	di, 2	;@09D5F
	push	di	;@09D62
	mov	di, 7C2h	;@09D63
	call	L054ED	;@09D66
	jae	@@5	;@09D69
	call	TABLE_OVERFLOW	;@09D6B
@@5:	mov	bx, di	;@09D6E
	mov	word ptr es:[bx], cx	;@09D70
	inc	word ptr es:[bx]	;@09D73
	shr	bx, 1	;@09D76
	inc	bx	;@09D78
	xchg	dx, bx	;@09D79
	mov	es, word ptr ds:[7CEh]	;@09D7B
	mov	word ptr es:[bx+2], dx	;@09D7F
	mov	es, word ptr ds:[806h]	;@09D83
	mov	word ptr es:[si+2], dx	;@09D87
	mov	word ptr es:[si+0Ah], bx	;@09D8B
	add	cx, ax	;@09D8F
	jmp	short @@7	;@09D91
@@6:	mov	es, word ptr ds:[7CEh]	;@09D93
	mov	ax, word ptr es:[bx+2]	;@09D97
	mov	es, word ptr ds:[806h]	;@09D9B
	mov	word ptr es:[si+2], ax	;@09D9F
	mov	word ptr es:[si+0Ah], bx	;@09DA3
@@7:	mov	ax, word ptr es:[si+4]	;@09DA7
	or	ax, ax	;@09DAB
	jne	@@2	;@09DAD
	mov	ax, word ptr es:[si]	;@09DAF
	call	L09CC5	;@09DB2
	add	cx, ax	;@09DB5
	mov	es, word ptr ds:[7CEh]	;@09DB7
	mov	ax, word ptr es:[bx+4]	;@09DBB
	mov	es, word ptr ds:[806h]	;@09DBF
	mov	word ptr es:[si+6], ax	;@09DC3
	jmp	@@2	;@09DC7
	db	'PATH='	;@09DCA
L09DCF:	push	bp	;@09DCF
	mov	bp, sp	;@09DD0
	sub	sp, 88h	;@09DD2
	mov	di, 7FAh	;@09DD6
	call	NEW_POOL	;@09DD9
	mov	bx, word ptr ds:[769Ah]	;@09DDC
	cmp	bx, 0	;@09DE0
	jne	@@5	;@09DE3
	mov	cx, 40h	;@09DE5
	mov	ax, 44h	;@09DE8
	cmp	byte ptr ds:[128h], 2	;@09DEB
	je	@@1	;@09DF0
	mov	ax, 37h	;@09DF2
@@1:	add	cx, ax	;@09DF5
	add	cx, 0Fh	;@09DF7
	and	cl, 0F0h	;@09DFA
	push	cx	;@09DFD
	mov	di, cx	;@09DFE
	push	di	;@09E00
	mov	di, 7FAh	;@09E01
	call	L054ED	;@09E04
	jae	@@2	;@09E07
	call	TABLE_OVERFLOW	;@09E09
@@2:	xor	ax, ax	;@09E0C
	rep stosb	;@09E0E
	pop	cx	;@09E10
	push	cx	;@09E11
	push	cs	;@09E12
	pop	ds	;@09E13
	mov	si, 0A451h	;@09E14
	mov	cx, 1Ah	;@09E17
	xor	di, di	;@09E1A
	rep movsb	;@09E1C
	mov	di, 3Eh	;@09E1E
	add	di, 0Fh	;@09E21
	and	di, -10h	;@09E24
	mov	ds, word ptr cs:DATA_SEGMENT	;@09E27
	mov	si, 0A46Bh	;@09E2C
	mov	cx, 44h	;@09E2F
	cmp	byte ptr ds:[128h], 2	;@09E32
	je	@@3	;@09E37
	mov	si, 0A4AFh	;@09E39
	mov	cx, 37h	;@09E3C
@@3:	push	cs	;@09E3F
	pop	ds	;@09E40
	rep movsb	;@09E41
	mov	ds, word ptr cs:DATA_SEGMENT	;@09E43
	pop	ax	;@09E48
	jmp	@@11	;@09E49
@@4:	mov	ax, 26h	;@09E4C
	mov	dx, ds	;@09E4F
	jmp	short @@9	;@09E51
@@5:	mov	es, word ptr ds:[766Ch]	;@09E53
	mov	di, 26h	;@09E57
	push	di	;@09E5A
	xor	cx, cx	;@09E5B
	mov	cl, byte ptr es:[bx]	;@09E5D
	push	cx	;@09E60
	push	ds	;@09E61
	push	di	;@09E62
	push	es	;@09E63
	push	bx	;@09E64
	call	L095A3	;@09E65
	pop	cx	;@09E68
	jcxz	@@7	;@09E69
	mov	bx, 26h	;@09E6B
@@6:	cmp	byte ptr [bx], 5Ch	;@09E6E
	je	@@4	;@09E71
	cmp	byte ptr [bx], 3Ah	;@09E73
	je	@@4	;@09E76
	inc	bx	;@09E78
	loop	@@6	;@09E79
	push	ds	;@09E7B
	mov	ax, 26h	;@09E7C
	push	ax	;@09E7F
	call	L0971B	;@09E80
	jb	@@8	;@09E83
@@7:	mov	dx, ds	;@09E85
	mov	ax, 26h	;@09E87
	jmp	short @@9	;@09E8A
@@8:	mov	ax, 5	;@09E8C
	push	ax	;@09E8F
	push	cs	;@09E90
	mov	ax, 9DCAh	;@09E91
	push	ax	;@09E94
	mov	ax, DGROUP	;@09E95
	mov	es, ax	;@09E98
	mov	ax, word ptr es:[0]	;@09E9A
	push	ax	;@09E9E
	xor	ax, ax	;@09E9F
	push	ax	;@09EA1
	call	L09655	;@09EA2
	push	dx	;@09EA5
	push	ax	;@09EA6
	mov	di, 26h	;@09EA7
	push	ds	;@09EAA
	push	di	;@09EAB
	push	ss	;@09EAC
	lea	ax, [bp-88h]	;@09EAD
	push	ax	;@09EB1
	mov	ax, 80h	;@09EB2
	push	ax	;@09EB5
	call	L096B5	;@09EB6
	jb	@@12	;@09EB9
@@9:	mov	word ptr [bp-6], dx	;@09EBB
	mov	word ptr [bp-8], ax	;@09EBE
	mov	ax, 3D00h	;@09EC1
	mov	ds, word ptr [bp-6]	;@09EC4
	mov	dx, word ptr [bp-8]	;@09EC7
	call	OPEN_FILE	;@09ECA
	mov	ds, word ptr cs:DATA_SEGMENT	;@09ECD
	mov	word ptr [bp-2], ax	;@09ED2
	mov	bx, ax	;@09ED5
	xor	cx, cx	;@09ED7
	mov	dx, cx	;@09ED9
	mov	ax, 4202h	;@09EDB
	call	DOS_CALL	;@09EDE
	cmp	dx, 0	;@09EE1
	jne	@@13	;@09EE4
	mov	word ptr [bp-4], ax	;@09EE6
	mov	di, ax	;@09EE9
	push	di	;@09EEB
	mov	di, 7FAh	;@09EEC
	call	L054ED	;@09EEF
	jae	@@10	;@09EF2
	call	TABLE_OVERFLOW	;@09EF4
@@10:	mov	bx, word ptr [bp-2]	;@09EF7
	xor	cx, cx	;@09EFA
	mov	dx, cx	;@09EFC
	mov	ax, 4200h	;@09EFE
	call	DOS_CALL	;@09F01
	mov	bx, word ptr [bp-2]	;@09F04
	push	ds	;@09F07
	mov	ds, word ptr ds:[7FEh]	;@09F08
	xor	dx, dx	;@09F0C
	mov	cx, word ptr [bp-4]	;@09F0E
	mov	ax, 3F00h	;@09F11
	call	DOS_CALL	;@09F14
	pop	ds	;@09F17
	call	@@14	;@09F18
	mov	ax, word ptr [bp-4]	;@09F1B
@@11:	mov	word ptr ds:[7654h], ax	;@09F1E
	mov	word ptr ds:[7FCh], ax	;@09F21
	add	ax, 0Fh	;@09F24
	and	ax, 0FFF0h	;@09F27
	mov	word ptr ds:[7652h], ax	;@09F2A
	mov	sp, bp	;@09F2D
	pop	bp	;@09F2F
	ret	;@09F30
@@12:	mov	ax, 26h	;@09F31
	push	ds	;@09F34
	push	ax	;@09F35
	mov	ax, 4	;@09F36
	push	ax	;@09F39
	mov	ax, 1	;@09F3A
	push	ax	;@09F3D
	call FATAL	;@09F3E
@@13:	call	@@14	;@09F41
	xor	ax, ax	;@09F44
	push	ax	;@09F46
	mov	ax, 21h	;@09F47
	push	ax	;@09F4A
	call FATAL	;@09F4B
@@14:	mov	bx, word ptr [bp-2]	;@09F4E
	call	CLOSE_FILE	;@09F51
	ret	;@09F54
L09F55:	push	ds	;@09F55
	push	word ptr ds:[7652h]	;@09F56
	push	word ptr ds:[769Ah]	;@09F5A
	mov	ds, word ptr ds:[7FEh]	;@09F5E
	cmp	word ptr ds:[6], 0	;@09F62
	je	@@1	;@09F67
	cmp	word ptr ds:[18h], 40h	;@09F69
	je	@@1	;@09F6E
	mov	cx, word ptr ds:[6]	;@09F70
	shl	cx, 1	;@09F74
	push	cx	;@09F76
	shl	cx, 1	;@09F77
	push	ds	;@09F79
	pop	es	;@09F7A
	mov	si, word ptr ds:[18h]	;@09F7B
	add	si, cx	;@09F7F
	sub	si, 2	;@09F81
	mov	di, 40h	;@09F84
	add	di, cx	;@09F87
	sub	di, 2	;@09F89
	pop	cx	;@09F8C
	std	;@09F8D
	rep movsw	;@09F8E
	cld	;@09F90
@@1:	pop	bx	;@09F91
	pop	ax	;@09F92
	mov	word ptr ds:[3Ch], ax	;@09F93
	mov	word ptr ds:[3Eh], 0	;@09F96
	mov	word ptr ds:[18h], 40h	;@09F9C
	or	bx, bx	;@09FA2
	je	@@2	;@09FA4
	mov	word ptr ds:[0Ah], 0	;@09FA6
@@2:	pop	ds	;@09FAC
	mov	cx, word ptr ds:[7654h]	;@09FAD
	sub	ax, ax	;@09FB1
	cwd	;@09FB3
	xor	si, si	;@09FB4
	mov	bx, 7FEh	;@09FB6
	call	L08AC5	;@09FB9
	ret	;@09FBC
L09FBD:	mov	word ptr ds:[69Dh], 454Eh	;@09FBD
	mov	byte ptr ds:[69Fh], 5	;@09FC3
	mov	byte ptr ds:[6A0h], 0Ah	;@09FC8
	mov	ax, word ptr ds:[7650h]	;@09FCD
	cmp	byte ptr ds:[768Bh], 1	;@09FD0
	jne	@@1	;@09FD5
	or	ax, 8	;@09FD7
@@1:	mov	word ptr ds:[6A9h], ax	;@09FDA
	call	L0B626	;@09FDD
	mov	word ptr ds:[6ADh], ax	;@09FE0
	cmp	byte ptr ds:[3D3h], 1	;@09FE3
	je	@@2	;@09FE8
	cmp	byte ptr ds:[129h], 3	;@09FEA
	je	@@2	;@09FEF
	mov	word ptr ds:[6AFh], bx	;@09FF1
@@2:	xor	ax, ax	;@09FF5
	test	word ptr ds:[7650h], 3	;@09FF7
	je	@@6	;@09FFD
	mov	bx, word ptr ds:[3FCh]	;@09FFF
	cmp	bx, -1	;@0A003
	jne	@@4	;@0A006
	xor	cx, cx	;@0A008
	push	cx	;@0A00A
	mov	ax, 38h	;@0A00B
	push	ax	;@0A00E
	call WARNING	;@0A00F
	jmp	short @@7	;@0A012
@@3:	xor	cx, cx	;@0A014
	push	cx	;@0A016
	mov	ax, 2Ch	;@0A017
	push	ax	;@0A01A
	call ERROR	;@0A01B
	jmp	short @@5	;@0A01E
@@4:	mov	es, word ptr ds:[79Eh]	;@0A020
	mov	ax, word ptr es:[bx+6]	;@0A024
	push	ax	;@0A028
	mov	ax, word ptr es:[bx+0Dh]	;@0A029
	add	ax, word ptr ds:[6ADh]	;@0A02D
	jb	@@3	;@0A031
	add	ax, word ptr ds:[6AFh]	;@0A033
	jae	@@5	;@0A037
	cmp	ax, 0	;@0A039
	jne	@@3	;@0A03C
@@5:	pop	ax	;@0A03E
@@6:	mov	word ptr ds:[6ABh], ax	;@0A03F
@@7:	cmp	word ptr ds:[6B7h], 0	;@0A042
	jne	@@8	;@0A047
	cmp	byte ptr ds:[129h], 3	;@0A049
	je	@@8	;@0A04E
	mov	ax, word ptr ds:[6ABh]	;@0A050
	mov	word ptr ds:[6B7h], ax	;@0A053
@@8:	cmp	byte ptr ds:[3D3h], 1	;@0A056
	je	@@9	;@0A05B
	cmp	word ptr ds:[6AFh], 0	;@0A05D
	jne	@@9	;@0A062
	cmp	byte ptr ds:[129h], 3	;@0A064
	je	@@9	;@0A069
	call	L075D0	;@0A06B
@@9:	mov	ax, word ptr ds:[7C4h]	;@0A06E
	shr	ax, 1	;@0A071
	mov	word ptr ds:[6BBh], ax	;@0A073
	call	L0B4CB	;@0A076
	mov	word ptr ds:[6BDh], cx	;@0A079
	mov	ax, 40h	;@0A07D
	mov	word ptr ds:[6BFh], ax	;@0A080
	mov	cx, word ptr ds:[6B9h]	;@0A083
	cmp	cx, 0FEh	;@0A087
	jbe	@@10	;@0A08B
	jmp	@@13	;@0A08D
@@10:	mov	bx, word ptr ds:[79Ch]	;@0A090
	or	bx, bx	;@0A094
	je	@@12	;@0A096
	sub	bx, 14h	;@0A098
	mov	es, word ptr ds:[79Eh]	;@0A09B
	mov	dx, word ptr ds:[404h]	;@0A09F
	cmp	dx, -1	;@0A0A3
	je	@@11	;@0A0A6
	mov	bx, dx	;@0A0A8
	mov	cx, word ptr es:[bx+6]	;@0A0AA
@@11:	push	ax	;@0A0AE
	mov	ax, word ptr es:[bx+0Dh]	;@0A0AF
	or	ax, word ptr es:[bx+0Fh]	;@0A0B3
	pop	ax	;@0A0B7
	jne	@@12	;@0A0B8
	dec	cx	;@0A0BA
	mov	word ptr ds:[6B9h], cx	;@0A0BB
@@12:	shl	cx, 1	;@0A0BF
	shl	cx, 1	;@0A0C1
	shl	cx, 1	;@0A0C3
	add	ax, cx	;@0A0C5
	mov	word ptr ds:[6C1h], ax	;@0A0C7
	mov	word ptr ds:[6C3h], ax	;@0A0CA
	push	ax	;@0A0CD
	call	L0B103	;@0A0CE
	pop	ax	;@0A0D1
	add	ax, cx	;@0A0D2
	mov	word ptr ds:[6C5h], ax	;@0A0D4
	add	ax, word ptr ds:[7C4h]	;@0A0D7
	mov	word ptr ds:[6C7h], ax	;@0A0DB
	add	ax, word ptr ds:[3F8h]	;@0A0DE
	mov	word ptr ds:[6A1h], ax	;@0A0E2
	push	ax	;@0A0E5
	call	L0B172	;@0A0E6
	mov	word ptr ds:[6A3h], ax	;@0A0E9
	pop	ax	;@0A0EC
	add	ax, word ptr ds:[6A3h]	;@0A0ED
	push	ax	;@0A0F1
	push	cx	;@0A0F2
	add	ax, word ptr ds:[7652h]	;@0A0F3
	mov	word ptr ds:[6C9h], ax	;@0A0F7
	mov	word ptr ds:[6CBh], 0	;@0A0FA
	mov	word ptr ds:[6D1h], 0	;@0A100
	call	L0BB8D	;@0A106
	mov	byte ptr ds:[6D3h], al	;@0A109
	mov	ax, word ptr ds:[6C9h]	;@0A10C
	add	ax, word ptr ds:[6BDh]	;@0A10F
	add	ax, 0Fh	;@0A113
	and	ax, 0FFF0h	;@0A116
	mov	bx, word ptr ds:[3FAh]	;@0A119
	add	ax, bx	;@0A11D
	and	bx, ax	;@0A11F
	xor	ax, bx	;@0A121
	mov	cl, 4	;@0A123
	shr	ax, cl	;@0A125
	mov	word ptr ds:[3FEh], ax	;@0A127
	pop	cx	;@0A12A
	pop	ax	;@0A12B
	ret	;@0A12C
@@13:	xor	ax, ax	;@0A12D
	push	ax	;@0A12F
	mov	ax, 20h	;@0A130
	push	ax	;@0A133
	call FATAL	;@0A134
L0A137:	mov	ax, word ptr ds:[6B1h]	;@0A137
	or	ax, word ptr ds:[6B3h]	;@0A13A
	jne	@@1	;@0A13E
	cmp	byte ptr ds:[129h], 3	;@0A140
	je	@@1	;@0A145
	xor	ax, ax	;@0A147
	push	ax	;@0A149
	mov	ax, 3Bh	;@0A14A
	push	ax	;@0A14D
	call WARNING	;@0A14E
@@1:	call	L09F55	;@0A151
	mov	ax, word ptr ds:[3FEh]	;@0A154
	call	L074A5	;@0A157
	mov	ax, 2	;@0A15A
	cwd	;@0A15D
	mov	cx, 4	;@0A15E
	mov	si, 49Ch	;@0A161
	call	L08B1D	;@0A164
	mov	cx, 40h	;@0A167
	mov	si, 69Dh	;@0A16A
	mov	ax, word ptr ds:[7652h]	;@0A16D
	xor	dx, dx	;@0A170
	call	L08B1D	;@0A172
	ret	;@0A175
L0A176:	push	bp	;@0A176
	mov	bp, sp	;@0A177
	sub	sp, 0Ah	;@0A179
	push	ax	;@0A17C
	push	bx	;@0A17D
	push	cx	;@0A17E
	push	dx	;@0A17F
	push	di	;@0A180
	mov	ax, 1000h	;@0A181
	mul	word ptr ds:[482h]	;@0A184
	add	ax, word ptr ds:[484h]	;@0A188
	adc	dx, 0	;@0A18C
	mov	word ptr [bp-8], dx	;@0A18F
	mov	word ptr [bp-6], ax	;@0A192
	mov	es, word ptr ds:[79Eh]	;@0A195
	mov	ax, word ptr es:[bx+0Dh]	;@0A199
	mov	word ptr [bp-0Ah], ax	;@0A19D
	mov	di, bx	;@0A1A0
	mov	ax, word ptr ds:[3FEh]	;@0A1A2
	xor	dx, dx	;@0A1A5
	add	ax, word ptr es:[di+8]	;@0A1A7
	adc	dl, byte ptr es:[di+0Ah]	;@0A1AB
	mov	cx, 4	;@0A1AF
@@1:	shl	ax, 1	;@0A1B2
	rcl	dx, 1	;@0A1B4
	loop	@@1	;@0A1B6
	mov	word ptr [bp-4], dx	;@0A1B8
	mov	word ptr [bp-2], ax	;@0A1BB
	cmp	dx, word ptr [bp-8]	;@0A1BE
	ja	@@7	;@0A1C1
	jb	@@2	;@0A1C3
	cmp	ax, word ptr [bp-6]	;@0A1C5
	jae	@@7	;@0A1C8
@@2:	add	ax, word ptr [bp-0Ah]	;@0A1CA
	adc	dx, 0	;@0A1CD
	cmp	dx, word ptr [bp-8]	;@0A1D0
	ja	@@8	;@0A1D3
	jb	@@3	;@0A1D5
	cmp	ax, word ptr [bp-6]	;@0A1D7
	ja	@@8	;@0A1DA
@@3:	mov	ax, word ptr [bp-0Ah]	;@0A1DC
	mov	word ptr ds:[6EFh], ax	;@0A1DF
	mov	word ptr ds:[6EBh], ax	;@0A1E2
	jmp	short @@9	;@0A1E5
@@4:	jbe	@@5	;@0A1E7
	jmp	@@21	;@0A1E9
@@5:	or	ax, ax	;@0A1EC
	je	@@6	;@0A1EE
	jmp	@@21	;@0A1F0
@@6:	mov	word ptr ds:[6EBh], 0	;@0A1F3
	mov	ax, word ptr [bp-0Ah]	;@0A1F9
	mov	word ptr ds:[6EFh], ax	;@0A1FC
	jmp	short @@9	;@0A1FF
@@7:	mov	ax, 0	;@0A201
	mov	word ptr ds:[6E9h], ax	;@0A204
	mov	word ptr ds:[6EBh], ax	;@0A207
	mov	ax, word ptr [bp-0Ah]	;@0A20A
	mov	word ptr ds:[6EFh], ax	;@0A20D
	jmp	short @@11	;@0A210
@@8:	mov	dx, word ptr [bp-8]	;@0A212
	mov	ax, word ptr [bp-6]	;@0A215
	sub	ax, word ptr [bp-2]	;@0A218
	sbb	dx, word ptr [bp-4]	;@0A21B
	cmp	dx, 1	;@0A21E
	jae	@@4	;@0A221
	mov	word ptr ds:[6EBh], ax	;@0A223
	mov	ax, word ptr [bp-0Ah]	;@0A226
	mov	word ptr ds:[6EFh], ax	;@0A229
@@9:	mov	dx, word ptr [bp-4]	;@0A22C
	mov	ax, word ptr [bp-2]	;@0A22F
	mov	cx, word ptr ds:[6CFh]	;@0A232
@@10:	shr	dx, 1	;@0A236
	rcr	ax, 1	;@0A238
	loop	@@10	;@0A23A
	or	dx, dx	;@0A23C
	jne	@@20	;@0A23E
	mov	word ptr ds:[6E9h], ax	;@0A240
@@11:	mov	dx, 0C00h	;@0A243
	cmp	byte ptr es:[di+1], 4	;@0A246
	jne	@@12	;@0A24B
	or	dx, 11h	;@0A24D
@@12:	cmp	byte ptr es:[di+1], 0	;@0A250
	jg	@@13	;@0A255
	or	dx, 1	;@0A257
@@13:	cmp	word ptr es:[di+11h], 0	;@0A25A
	je	@@14	;@0A25F
	or	dx, 100h	;@0A261
@@14:	test	byte ptr es:[di+13h], 1	;@0A265
	je	@@15	;@0A26A
	or	dx, 10h	;@0A26C
@@15:	test	byte ptr es:[di+13h], 2	;@0A26F
	je	@@16	;@0A274
	or	dx, 20h	;@0A276
@@16:	test	byte ptr es:[di+13h], 4	;@0A279
	je	@@17	;@0A27E
	or	dx, 40h	;@0A280
@@17:	test	byte ptr es:[di+13h], 8	;@0A283
	je	@@18	;@0A288
	or	dx, 80h	;@0A28A
@@18:	test	byte ptr es:[di+13h], 10h	;@0A28E
	je	@@19	;@0A293
	or	dx, 1000h	;@0A295
@@19:	mov	word ptr ds:[6EDh], dx	;@0A299
	pop	di	;@0A29D
	pop	dx	;@0A29E
	pop	cx	;@0A29F
	pop	bx	;@0A2A0
	pop	ax	;@0A2A1
	mov	sp, bp	;@0A2A2
	pop	bp	;@0A2A4
	ret	;@0A2A5
@@20:	xor	ax, ax	;@0A2A6
	push	ax	;@0A2A8
	mov	ax, 11h	;@0A2A9
	push	ax	;@0A2AC
	call FATAL	;@0A2AD
@@21:	xor	ax, ax	;@0A2B0
	push	ax	;@0A2B2
	mov	ax, 12h	;@0A2B3
	push	ax	;@0A2B6
	call FATAL	;@0A2B7
L0A2BA:	mov	ax, word ptr ds:[7652h]	;@0A2BA
	add	ax, word ptr ds:[6BFh]	;@0A2BD
	xor	bx, bx	;@0A2C1
@@1:	cmp	bx, word ptr ds:[79Ch]	;@0A2C3
	jae	@@3	;@0A2C7
	mov	es, word ptr ds:[79Eh]	;@0A2C9
	push	ax	;@0A2CD
	mov	ax, word ptr es:[bx+0Dh]	;@0A2CE
	or	ax, word ptr es:[bx+0Fh]	;@0A2D2
	pop	ax	;@0A2D6
	je	@@2	;@0A2D7
	call	L0A176	;@0A2D9
	mov	cx, 8	;@0A2DC
	mov	si, 6E9h	;@0A2DF
	xor	dx, dx	;@0A2E2
	call	L08B1D	;@0A2E4
@@2:	add	bx, 14h	;@0A2E7
	jmp	@@1	;@0A2EA
@@3:	ret	;@0A2EC
L0A2ED:	mov	cx, word ptr ds:[7C4h]	;@0A2ED
	jcxz	@@1	;@0A2F1
	push	ds	;@0A2F3
	push	si	;@0A2F4
	mov	ax, word ptr ds:[7652h]	;@0A2F5
	add	ax, word ptr ds:[6C5h]	;@0A2F8
	xor	dx, dx	;@0A2FC
	xor	si, si	;@0A2FE
	mov	bx, 7C6h	;@0A300
	call	L08AC5	;@0A303
	pop	si	;@0A306
	pop	ds	;@0A307
@@1:	ret	;@0A308
L0A309:	xor	bx, bx	;@0A309
	mov	cx, word ptr ds:[7652h]	;@0A30B
	add	cx, word ptr ds:[6C7h]	;@0A30F
	inc	cx	;@0A313
@@1:	cmp	bx, word ptr ds:[7CCh]	;@0A314
	jae	@@2	;@0A318
	mov	es, word ptr ds:[7CEh]	;@0A31A
	mov	si, word ptr es:[bx]	;@0A31E
	push	bx	;@0A321
	xchg	ax, cx	;@0A322
	xor	dx, dx	;@0A323
	mov	bx, si	;@0A325
	and	bx, 3	;@0A327
	shl	bx, 1	;@0A32A
	shl	bx, 1	;@0A32C
	shl	bx, 1	;@0A32E
	lea	bx, [bx+716h]	;@0A330
	push	si	;@0A334
	and	si, 3	;@0A335
	shl	si, 1	;@0A338
	shl	si, 1	;@0A33A
	shl	si, 1	;@0A33C
	mov	es, word ptr [si+716h]	;@0A33E
	pop	si	;@0A342
	add	si, 2	;@0A343
	mov	cl, byte ptr es:[si]	;@0A346
	and	cx, 3Fh	;@0A349
	mov	byte ptr es:[si], cl	;@0A34C
	inc	cx	;@0A34F
	call	L08AC5	;@0A350
	add	cx, ax	;@0A353
	pop	bx	;@0A355
	add	bx, 6	;@0A356
	jmp	@@1	;@0A359
@@2:	ret	;@0A35B
L0A35C:	push	bx	;@0A35C
	push	cx	;@0A35D
	push	dx	;@0A35E
	push	si	;@0A35F
	push	di	;@0A360
	sub	si, si	;@0A361
@@1:	cmp	si, word ptr ds:[79Ch]	;@0A363
	jae	@@3	;@0A367
	mov	es, word ptr ds:[79Eh]	;@0A369
	mov	ax, word ptr es:[si+8]	;@0A36D
	mov	dl, byte ptr es:[si+0Ah]	;@0A371
	mov	dh, 0	;@0A375
	add	ax, word ptr ds:[3FEh]	;@0A377
	adc	dl, dh	;@0A37B
	shl	ax, 1	;@0A37D
	rcl	dx, 1	;@0A37F
	shl	ax, 1	;@0A381
	rcl	dx, 1	;@0A383
	shl	ax, 1	;@0A385
	rcl	dx, 1	;@0A387
	shl	ax, 1	;@0A389
	rcl	dx, 1	;@0A38B
	add	ax, word ptr es:[si+0Dh]	;@0A38D
	adc	dx, word ptr es:[si+0Fh]	;@0A391
	push	si	;@0A395
	mov	cx, 2	;@0A396
	cmp	word ptr es:[si+11h], 0	;@0A399
	je	@@2	;@0A39E
	lea	si, [si+11h]	;@0A3A0
	mov	bx, 79Eh	;@0A3A3
	call	L08AC5	;@0A3A6
@@2:	pop	si	;@0A3A9
	add	si, 14h	;@0A3AA
	jmp	@@1	;@0A3AD
@@3:	pop	di	;@0A3AF
	pop	si	;@0A3B0
	pop	dx	;@0A3B1
	pop	cx	;@0A3B2
	pop	bx	;@0A3B3
	ret	;@0A3B4
L0A3B5:	call	L0A137	;@0A3B5
	call	L0A2BA	;@0A3B8
	call	L0B5D0	;@0A3BB
	call	L0A2ED	;@0A3BE
	call	L0A309	;@0A3C1
	call	L0B608	;@0A3C4
	call	L0B5EE	;@0A3C7
	call	L0A35C	;@0A3CA
	ret	;@0A3CD
L0A3CE:	push	si	;@0A3CE
	push	di	;@0A3CF
	xor	si, si	;@0A3D0
	push	si	;@0A3D2
	mov	bx, 80Ah	;@0A3D3
	jmp	short @@4	;@0A3D6
@@1:	push	si	;@0A3D8
	xor	ax, ax	;@0A3D9
	push	ax	;@0A3DB
	mov	ax, 2Eh	;@0A3DC
	push	ax	;@0A3DF
	call ERROR	;@0A3E0
	pop	si	;@0A3E3
	jmp	short @@3	;@0A3E4
@@2:	push	bx	;@0A3E6
	push	si	;@0A3E7
	and	si, 3	;@0A3E8
	shl	si, 1	;@0A3EB
	shl	si, 1	;@0A3ED
	shl	si, 1	;@0A3EF
	mov	es, word ptr [si+80Eh]	;@0A3F1
	pop	si	;@0A3F5
	mov	di, word ptr es:[si+2]	;@0A3F6
	mov	bx, word ptr es:[si]	;@0A3FA
	push	di	;@0A3FD
	and	di, 3	;@0A3FE
	shl	di, 1	;@0A401
	shl	di, 1	;@0A403
	shl	di, 1	;@0A405
	mov	es, word ptr [di+756h]	;@0A407
	pop	di	;@0A40B
	test	byte ptr es:[di+0Eh], 20h	;@0A40C
	je	@@3	;@0A411
	test	bx, 1	;@0A413
	jne	@@1	;@0A417
	mov	es, word ptr ds:[77Eh]	;@0A419
	mov	bx, word ptr es:[bx]	;@0A41D
	cmp	bx, -1	;@0A420
	je	@@3	;@0A423
	mov	es, word ptr ds:[79Eh]	;@0A425
	inc	word ptr es:[bx+11h]	;@0A429
@@3:	pop	bx	;@0A42D
	add	si, 4	;@0A42E
@@4:	cmp	si, word ptr [bx+2]	;@0A431
	jb	@@2	;@0A434
	cmp	bx, 81Ah	;@0A436
	ja	@@5	;@0A43A
	add	bx, 8	;@0A43C
	pop	si	;@0A43F
	inc	si	;@0A440
	push	si	;@0A441
	jmp	@@4	;@0A442
@@5:	pop	si	;@0A444
	mov	di, 80Ah	;@0A445
	call	L056FE	;@0A448
	call	L05713	;@0A44B
	pop	di	;@0A44E
	pop	si	;@0A44F
	ret	;@0A450
L0A451	db	4Dh, 5Ah, 0, 0, 0, 0, 0, 0, 4, 0, 0Fh, 0, 0FFh, 0FFh, 0, 0, 0B8h	;@0A451
	db	0, 0, 0, 0, 0, 0, 0, 40h, 0, 0BAh, 10h, 0, 0Eh, 1Fh, 0B4h, 9, 0CDh
	db	21h, 0B8h, 1, 4Ch, 0CDh, 21h, 90h, 90h, 'This program must be run under Microsoft Windows.'
	db	0Dh, 0Ah, 24h, 0BAh, 10h, 0, 0Eh, 1Fh, 0B4h, 9, 0CDh, 21h, 0B8h
	db	1, 4Ch, 0CDh, 21h, 90h, 90h, 'This program must be run under OS/2.'
	db	0Dh, 0Ah, 24h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0Ah, 0, 10h, 0

; module definition keywords: token number and handler
DEF_SECTIONS	dw	25, L0AD8D	;@0A4F4
	dw	20, L0AD60
	dw	9, L0ADCB
	dw	14, L0ADD8
	dw	7, L0AE13
	dw	8, L0AE1D
	dw	37, L0AE84
	dw	17, L0AE6B
	dw	40, L0AE70
	dw	15, L0AF34
	dw	18, L0B019
	dw	41, L0ADEE
	dw	32, L0ADFF
	dw	35, L0AE06
L0A52C:	cmp	al, 30h	;@0A52C
	jb	@@4	;@0A52E
	cmp	al, 39h	;@0A530
	ja	@@1	;@0A532
	sub	al, 30h	;@0A534
	jmp	short @@3	;@0A536
@@1:	cmp	al, 41h	;@0A538
	jb	@@4	;@0A53A
	cmp	al, 46h	;@0A53C
	ja	@@2	;@0A53E
	sub	al, 37h	;@0A540
	jmp	short @@3	;@0A542
@@2:	cmp	al, 61h	;@0A544
	jb	@@4	;@0A546
	cmp	al, 66h	;@0A548
	ja	@@4	;@0A54A
	sub	al, 57h	;@0A54C
@@3:	xor	ah, ah	;@0A54E
	clc	;@0A550
	jmp	short @@5	;@0A551
@@4:	stc	;@0A553
@@5:	ret	;@0A554
L0A555:	push	ds	;@0A555
	lea	ax, [bx+4]	;@0A556
	push	ax	;@0A559
	mov	word ptr [bx+2], cx	;@0A55A
	mov	word ptr [bx], cx	;@0A55D
	push	cx	;@0A55F
	call	far ptr POOL_INIT	;@0A560
	ret	;@0A565
L0A566:	push	bx	;@0A566
	push	cx	;@0A567
	push	di	;@0A568
	push	es	;@0A569
	xor	ax, ax	;@0A56A
	mov	word ptr ds:[76ADh], ax	;@0A56C
	mov	bx, 7660h	;@0A56F
	mov	cx, 2	;@0A572
	call	L0A555	;@0A575
	mov	bx, 7668h	;@0A578
	mov	cx, 2	;@0A57B
	call	L0A555	;@0A57E
	cld	;@0A581
	push	ds	;@0A582
	pop	es	;@0A583
	call	L0ACBA	;@0A584
	call	L0ACAF	;@0A587
	mov	ax, 0	;@0A58A
	pop	es	;@0A58D
	pop	di	;@0A58E
	pop	cx	;@0A58F
	pop	bx	;@0A590
	ret	;@0A591
L0A592:	push	bx	;@0A592
	push	si	;@0A593
	push	di	;@0A594
	push	ds	;@0A595
	mov	di, word ptr ds:[138h]	;@0A596
	les	bx, dword ptr ds:[132h]	;@0A59A
	mov	es, word ptr es:[bx]	;@0A59E
	add	di, 2	;@0A5A1
	xor	ax, ax	;@0A5A4
	mov	cx, 0FFFFh	;@0A5A6
	cld	;@0A5A9
	repne scasb	;@0A5AA
	neg	cx	;@0A5AC
	sub	cx, 2	;@0A5AE
	sub	di, 2	;@0A5B1
@@1:	cmp	byte ptr es:[di], 5Ch	;@0A5B4
	je	@@2	;@0A5B8
	cmp	byte ptr es:[di], 3Ah	;@0A5BA
	je	@@2	;@0A5BE
	dec	di	;@0A5C0
	loop	@@1	;@0A5C1
@@2:	inc	di	;@0A5C3
	mov	si, di	;@0A5C4
	push	es	;@0A5C6
	pop	ds	;@0A5C7
	mov	es, word ptr cs:DATA_SEGMENT	;@0A5C8
	mov	di, 3E7Bh	;@0A5CD
@@3:	lodsb	;@0A5D0
	or	al, al	;@0A5D1
	je	@@4	;@0A5D3
	stosb	;@0A5D5
	jmp	@@3	;@0A5D6
@@4:	pop	ds	;@0A5D8
	mov	ax, di	;@0A5D9
	mov	bx, 3E7Bh	;@0A5DB
	sub	ax, bx	;@0A5DE
	dec	bx	;@0A5E0
	mov	byte ptr [bx], al	;@0A5E1
	call	L0ACF1	;@0A5E3
	mov	word ptr ds:[76A8h], bx	;@0A5E6
	mov	ax, bx	;@0A5EA
	pop	di	;@0A5EC
	pop	si	;@0A5ED
	pop	bx	;@0A5EE
	ret	;@0A5EF
L0A5F0:	push	bx	;@0A5F0
	push	cx	;@0A5F1
	push	si	;@0A5F2
	push	di	;@0A5F3
	mov	si, word ptr ds:[76A8h]	;@0A5F4
	or	si, si	;@0A5F8
	jne	@@1	;@0A5FA
	call	L0A592	;@0A5FC
	mov	si, ax	;@0A5FF
@@1:	push	ds	;@0A601
	push	ds	;@0A602
	pop	es	;@0A603
	mov	di, 3E7Bh	;@0A604
	mov	ds, word ptr ds:[766Ch]	;@0A607
	xor	ax, ax	;@0A60B
	lodsb	;@0A60D
	mov	cx, ax	;@0A60E
	jcxz	@@3	;@0A610
@@2:	lodsb	;@0A612
	cmp	al, 2Eh	;@0A613
	je	@@3	;@0A615
	stosb	;@0A617
	loop	@@2	;@0A618
@@3:	pop	ds	;@0A61A
	mov	ax, di	;@0A61B
	mov	bx, 3E7Bh	;@0A61D
	sub	ax, bx	;@0A620
	dec	bx	;@0A622
	mov	byte ptr [bx], al	;@0A623
	call	L0ACF1	;@0A625
	mov	ax, bx	;@0A628
	pop	di	;@0A62A
	pop	si	;@0A62B
	pop	cx	;@0A62C
	pop	bx	;@0A62D
	ret	;@0A62E
L0A62F:	cmp	word ptr ds:[769Ch], 0	;@0A62F
	jne	@@1	;@0A634
	call	L0A592	;@0A636
	mov	word ptr ds:[769Ch], ax	;@0A639
@@1:	cmp	word ptr ds:[768Ch], 0	;@0A63C
	jne	@@2	;@0A641
	call	L0A5F0	;@0A643
	mov	word ptr ds:[768Ch], ax	;@0A646
@@2:	cmp	byte ptr ds:[17h], 0	;@0A649
	je	@@4	;@0A64E
	mov	al, 2	;@0A650
	cmp	byte ptr ds:[128h], 2	;@0A652
	je	@@3	;@0A657
	mov	al, 1	;@0A659
@@3:	mov	byte ptr ds:[76AAh], al	;@0A65B
	jmp	short @@6	;@0A65E
@@4:	cmp	byte ptr ds:[76AAh], 2	;@0A660
	je	@@5	;@0A665
	mov	byte ptr ds:[128h], 3	;@0A667
	jmp	short @@6	;@0A66C
@@5:	mov	byte ptr ds:[128h], 2	;@0A66E
@@6:	cmp	byte ptr ds:[768Ah], 0	;@0A673
	jne	@@8	;@0A678
	cmp	byte ptr ds:[129h], 3	;@0A67A
	je	@@7	;@0A67F
	mov	byte ptr ds:[768Ah], 1	;@0A681
	jmp	short @@8	;@0A686
@@7:	and	word ptr ds:[7650h], -3	;@0A688
	or	word ptr ds:[7650h], 8000h	;@0A68D
	or	word ptr ds:[7692h], 2	;@0A693
@@8:	ret	;@0A698
L0A699:	push	es	;@0A699
	push	di	;@0A69A
	push	ds	;@0A69B
	pop	es	;@0A69C
	call	L0A85A	;@0A69D
	cmp	al, 3	;@0A6A0
	je	@@1	;@0A6A2
	cmp	al, 2	;@0A6A4
	jne	@@2	;@0A6A6
	call	L0AC53	;@0A6A8
	jae	@@2	;@0A6AB
@@1:	push	ax	;@0A6AD
	call	L0ACF1	;@0A6AE
	pop	ax	;@0A6B1
@@2:	pop	di	;@0A6B2
	pop	es	;@0A6B3
	ret	;@0A6B4
L0A6B5:	push	ax	;@0A6B5
	push	cx	;@0A6B6
	push	di	;@0A6B7
	push	es	;@0A6B8
	xor	ax, ax	;@0A6B9
	lodsb	;@0A6BB
	mov	cx, ax	;@0A6BC
	jcxz	@@3	;@0A6BE
	push	ds	;@0A6C0
	pop	es	;@0A6C1
	mov	di, 3EFAh	;@0A6C2
	stosb	;@0A6C5
@@1:	lodsb	;@0A6C6
	cmp	al, 61h	;@0A6C7
	jb	@@2	;@0A6C9
	cmp	al, 7Ah	;@0A6CB
	ja	@@2	;@0A6CD
	sub	al, 20h	;@0A6CF
@@2:	stosb	;@0A6D1
	loop	@@1	;@0A6D2
	mov	si, 3EFAh	;@0A6D4
@@3:	pop	es	;@0A6D7
	pop	di	;@0A6D8
	pop	cx	;@0A6D9
	pop	ax	;@0A6DA
	ret	;@0A6DB
L0A6DC:	push	bp	;@0A6DC
	mov	bp, sp	;@0A6DD
	sub	sp, 0Ah	;@0A6DF
	push	ds	;@0A6E2
	push	si	;@0A6E3
	push	di	;@0A6E4
	mov	word ptr [bp-2], 0	;@0A6E5
	mov	word ptr [bp-4], 0	;@0A6EA
	mov	byte ptr [bp-8], 0	;@0A6EF
	mov	word ptr ds:[76B1h], sp	;@0A6F3
	mov	word ptr ds:[7684h], bx	;@0A6F7
	xor	ax, ax	;@0A6FB
	mov	word ptr ds:[76ABh], ax	;@0A6FD
	mov	word ptr ds:[76AFh], ax	;@0A700
L0A703:	call	L0A699	;@0A703
L0A706:	push	ds	;@0A706
	pop	es	;@0A707
	cmp	al, 0	;@0A708
	je	L0A738	;@0A70A
	cmp	al, 1	;@0A70C
	je	L0A703	;@0A70E
	cmp	al, 6	;@0A710
	jb	L0A72B	;@0A712
	push	es	;@0A714
	push	cs	;@0A715
	pop	es	;@0A716
	mov	di, offset DEF_SECTIONS	;@0A717
	mov	cx, 0Eh	;@0A71A
@@1:	scasw	;@0A71D
	je	@@2	;@0A71E
	inc	di	;@0A720
	inc	di	;@0A721
	loop	@@1	;@0A722
	pop	es	;@0A724
	jmp	short L0A72B	;@0A725
@@2:	pop	es	;@0A727
	jmp	word ptr cs:[di]	;@0A728
L0A72B:	mov	ax, 0Dh	;@0A72B
L0A72E:	mov	cx, word ptr ds:[76B3h]	;@0A72E
	mov	sp, word ptr ds:[76B1h]	;@0A732
	jmp	short L0A790	;@0A736
L0A738:	mov	bx, 768Ah	;@0A738
	cmp	byte ptr [bx], 0	;@0A73B
	je	@@1	;@0A73E
	dec	byte ptr [bx]	;@0A740
@@1:	mov	ax, word ptr [bp-2]	;@0A742
	mov	word ptr ds:[76A4h], ax	;@0A745
	sub	ax, word ptr [bp-4]	;@0A748
	mov	word ptr ds:[76A6h], ax	;@0A74B
	xor	ax, ax	;@0A74E
	test	word ptr ds:[7694h], 10h	;@0A750
	jne	@@3	;@0A756
	mov	si, 2	;@0A758
	cmp	byte ptr ds:[768Ah], 1	;@0A75B
	je	@@2	;@0A760
	mov	si, 1	;@0A762
@@2:	or	ax, si	;@0A765
@@3:	test	word ptr ds:[7692h], 20h	;@0A767
	je	@@4	;@0A76D
	or	ax, 2	;@0A76F
	jmp	short @@5	;@0A772
@@4:	test	word ptr ds:[7692h], 10h	;@0A774
	je	@@5	;@0A77A
	or	ax, 1	;@0A77C
@@5:	mov	word ptr ds:[7650h], ax	;@0A77F
	mov	al, byte ptr [bp-8]	;@0A782
	cmp	al, 0	;@0A785
	jne	@@6	;@0A787
	mov	al, 1	;@0A789
@@6:	mov	byte ptr ds:[76AAh], al	;@0A78B
	xor	ax, ax	;@0A78E
L0A790:	pop	di	;@0A790
	pop	si	;@0A791
	pop	ds	;@0A792
	mov	sp, bp	;@0A793
	pop	bp	;@0A795
	ret	;@0A796
L0A797:	mov	dx, 367Ah	;@0A797
	mov	cx, 800h	;@0A79A
	mov	bx, word ptr ds:[7684h]	;@0A79D
	mov	ah, 3Fh	;@0A7A1
	call	DOS_CALL	;@0A7A3
	cmp	ax, 0FFFFh	;@0A7A6
	je	@@2	;@0A7A9
	mov	si, 367Ah	;@0A7AB
	or	ax, ax	;@0A7AE
	jne	@@1	;@0A7B0
	mov	ax, 1	;@0A7B2
	mov	byte ptr [si], 1Ah	;@0A7B5
@@1:	mov	word ptr ds:[7686h], si	;@0A7B8
	add	ax, si	;@0A7BC
	mov	word ptr ds:[7688h], ax	;@0A7BE
	ret	;@0A7C1
@@2:	mov	ax, 0Eh	;@0A7C2
	jmp	L0A72E	;@0A7C5

; the lexer's handler for each character class (below)
DEF_CLASS_HANDLERS	dw	L0A87D, L0A894, L0A880, L0A888, L0A8D3, L0A967, L0A896, L0A9A5, L0A8BF	;@0A7C8
DEF_CHAR_CLASSES	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0	;@0A7DA
	db	0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 2, 0Ch, 0Eh, 0Ch, 0Ah, 0Ch, 0Ch
	db	0Eh, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 8, 8, 8, 8, 8, 8
	db	8, 8, 8, 8, 0Ch, 10h, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ch, 0Ch, 0Ch, 0Ch
	db	0Ah, 0Ch, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch
L0A85A:	mov	si, word ptr ds:[7686h]	;@0A85A
L0A85E:	cmp	si, word ptr ds:[7688h]	;@0A85E
	jb	@@1	;@0A862
	call	L0A797	;@0A864
@@1:	lodsb	;@0A867
	xor	ah, ah	;@0A868
	mov	bx, ax	;@0A86A
	jns	@@2	;@0A86C
	jmp	L0A72B	;@0A86E
@@2:	mov	bl, byte ptr cs:DEF_CHAR_CLASSES[bx]	;@0A871
	xor	bh, bh	;@0A876
	jmp	word ptr cs:DEF_CLASS_HANDLERS[bx]	;@0A878
L0A87D:	jmp	L0A72B	;@0A87D
L0A880:	mov	ax, 0	;@0A880
	mov	word ptr ds:[7686h], si	;@0A883
	ret	;@0A887
L0A888:	inc	word ptr ds:[76B3h]	;@0A888
	mov	ax, 1	;@0A88C
	mov	word ptr ds:[7686h], si	;@0A88F
	ret	;@0A893
L0A894:	jmp	L0A85E	;@0A894
L0A896:	cmp	al, 40h	;@0A896
	je	@@2	;@0A898
@@1:	mov	ah, al	;@0A89A
	mov	al, 5	;@0A89C
	mov	word ptr ds:[7686h], si	;@0A89E
	ret	;@0A8A2
@@2:	push	ax	;@0A8A3
	cmp	si, word ptr ds:[7688h]	;@0A8A4
	jb	@@3	;@0A8A8
	call	L0A797	;@0A8AA
@@3:	lodsb	;@0A8AD
	xor	ah, ah	;@0A8AE
	mov	di, ax	;@0A8B0
	dec	si	;@0A8B2
	pop	ax	;@0A8B3
	cmp	byte ptr cs:[di-5826h], 0Ah	;@0A8B4
	jne	@@1	;@0A8BA
	jmp	L0A967	;@0A8BC
L0A8BF:	cmp	si, word ptr ds:[7688h]	;@0A8BF
	jb	@@1	;@0A8C3
	call	L0A797	;@0A8C5
@@1:	lodsb	;@0A8C8
	cmp	al, 0Ah	;@0A8C9
	je	L0A888	;@0A8CB
	cmp	al, 1Ah	;@0A8CD
	je	L0A888	;@0A8CF
	jmp	L0A8BF	;@0A8D1
L0A8D3:	xor	bx, bx	;@0A8D3
	cmp	al, 30h	;@0A8D5
	jne	@@2	;@0A8D7
	push	bx	;@0A8D9
	cmp	si, word ptr ds:[7688h]	;@0A8DA
	jb	@@1	;@0A8DE
	call	L0A797	;@0A8E0
@@1:	lodsb	;@0A8E3
	pop	bx	;@0A8E4
	cmp	al, 78h	;@0A8E5
	je	@@7	;@0A8E7
	cmp	al, 58h	;@0A8E9
	je	@@7	;@0A8EB
	xor	ah, ah	;@0A8ED
	mov	di, ax	;@0A8EF
	cmp	byte ptr cs:[di-5826h], 8	;@0A8F1
	jne	@@5	;@0A8F7
	dec	si	;@0A8F9
@@2:	xor	bx, bx	;@0A8FA
@@3:	and	ax, 0Fh	;@0A8FC
	xchg	ax, bx	;@0A8FF
	mul	word ptr cs:L0A451+159	;@0A900
	jb	@@6	;@0A905
	add	bx, ax	;@0A907
	jb	@@6	;@0A909
	push	bx	;@0A90B
	cmp	si, word ptr ds:[7688h]	;@0A90C
	jb	@@4	;@0A910
	call	L0A797	;@0A912
@@4:	lodsb	;@0A915
	pop	bx	;@0A916
	xor	ah, ah	;@0A917
	mov	di, ax	;@0A919
	cmp	byte ptr cs:[di-5826h], 8	;@0A91B
	je	@@3	;@0A921
@@5:	dec	si	;@0A923
	mov	al, 4	;@0A924
	mov	word ptr ds:[7686h], si	;@0A926
	ret	;@0A92A
@@6:	jmp	L0A72B	;@0A92B
@@7:	cmp	si, word ptr ds:[7688h]	;@0A92E
	jb	@@8	;@0A932
	call	L0A797	;@0A934
@@8:	lodsb	;@0A937
	call	L0A52C	;@0A938
	jb	L0A964	;@0A93B
	xor	bx, bx	;@0A93D
@@9:	xchg	ax, bx	;@0A93F
	mul	word ptr cs:L0A451+161	;@0A940
	jb	L0A964	;@0A945
	add	bx, ax	;@0A947
	jb	L0A964	;@0A949
	push	bx	;@0A94B
	cmp	si, word ptr ds:[7688h]	;@0A94C
	jb	@@10	;@0A950
	call	L0A797	;@0A952
@@10:	lodsb	;@0A955
	pop	bx	;@0A956
	call	L0A52C	;@0A957
	jae	@@9	;@0A95A
	dec	si	;@0A95C
	mov	al, 4	;@0A95D
	mov	word ptr ds:[7686h], si	;@0A95F
	ret	;@0A963
L0A964:	jmp	L0A72B	;@0A964
L0A967:	mov	di, 3E7Bh	;@0A967
@@1:	cmp	di, 3EFAh	;@0A96A
	jae	L0A964	;@0A96E
	stosb	;@0A970
	cmp	si, word ptr ds:[7688h]	;@0A971
	jb	@@2	;@0A975
	call	L0A797	;@0A977
@@2:	lodsb	;@0A97A
	xor	ah, ah	;@0A97B
	mov	bx, ax	;@0A97D
	cmp	byte ptr cs:[bx-5826h], 0Ah	;@0A97F
	je	@@1	;@0A985
	cmp	byte ptr cs:[bx-5826h], 8	;@0A987
	je	@@1	;@0A98D
	cmp	al, 40h	;@0A98F
	je	@@1	;@0A991
	mov	bx, 3E7Ah	;@0A993
	sub	di, bx	;@0A996
	dec	di	;@0A998
	mov	ax, di	;@0A999
	mov	byte ptr [bx], al	;@0A99B
	dec	si	;@0A99D
	mov	word ptr ds:[7686h], si	;@0A99E
	mov	al, 2	;@0A9A2
	ret	;@0A9A4
L0A9A5:	mov	di, 3E7Bh	;@0A9A5
	cmp	si, word ptr ds:[7688h]	;@0A9A8
	jb	@@1	;@0A9AC
	call	L0A797	;@0A9AE
@@1:	lodsb	;@0A9B1
	jmp	short @@4	;@0A9B2
@@2:	cmp	di, 3EFAh	;@0A9B4
	jae	@@5	;@0A9B8
	stosb	;@0A9BA
	cmp	si, word ptr ds:[7688h]	;@0A9BB
	jb	@@3	;@0A9BF
	call	L0A797	;@0A9C1
@@3:	lodsb	;@0A9C4
@@4:	cmp	al, 27h	;@0A9C5
	je	@@6	;@0A9C7
	cmp	al, 22h	;@0A9C9
	je	@@6	;@0A9CB
	xor	ah, ah	;@0A9CD
	mov	bx, ax	;@0A9CF
	cmp	byte ptr cs:[bx-5826h], 4	;@0A9D1
	je	@@5	;@0A9D7
	cmp	byte ptr cs:[bx-5826h], 6	;@0A9D9
	jne	@@2	;@0A9DF
@@5:	jmp	L0A72B	;@0A9E1
@@6:	inc	si	;@0A9E4
	mov	bx, 3E7Ah	;@0A9E5
	sub	di, bx	;@0A9E8
	dec	di	;@0A9EA
	mov	ax, di	;@0A9EB
	mov	byte ptr [bx], al	;@0A9ED
	dec	si	;@0A9EF
	mov	word ptr ds:[7686h], si	;@0A9F0
	mov	al, 3	;@0A9F4
	ret	;@0A9F6
	db	1Fh, 0ABh, 0, 0, 0, 0, 0, 0, 25h, 0ABh, 0, 0, 0, 0, 0, 0, 2Ah	;@0A9F7
	db	0ABh, 0, 0, 0, 0, 0, 0, 2Fh, 0ABh, 0, 0, 0, 0, 0, 0, 3Bh, 0ABh
	db	7, 0, 0, 1, 0, 1, 47h, 0ABh, 8, 0, 1, 0, 3, 0, 4Ch, 0ABh, 5, 0
	db	4, 0, 0, 0, 58h, 0ABh, 5, 0, 4, 0, 4, 0, 64h, 0ABh, 0, 0, 0, 0
	db	0, 0, 6Ch, 0ABh, 0, 0, 0, 0, 0, 0, 74h, 0ABh, 7, 0, 80h, 0, 0
	db	0, 7Ah, 0ABh, 0, 0, 0, 0, 0, 0, 83h, 0ABh, 0, 0, 0, 0, 0, 0, 8Bh
	db	0ABh, 4, 0, 8, 0, 8, 0, 90h, 0ABh, 0, 0, 0, 0, 0, 0, 98h, 0ABh
	db	7, 0, 1, 0, 0, 0, 0A3h, 0ABh, 7, 0, 80h, 0, 80h, 0, 0ABh, 0ABh
	db	7, 0, 80h, 0, 80h, 0, 0B4h, 0ABh, 2, 0, 30h, 0, 30h, 0, 0BDh, 0ABh
	db	0, 0, 0, 0, 0, 0, 0C2h, 0ABh, 0, 0, 0, 0, 0, 0, 0C9h, 0ABh, 7
	db	0, 0, 1, 0, 0, 0D8h, 0ABh, 2, 0, 30h, 0, 0, 0, 0DDh, 0ABh, 7, 0
	db	2, 0, 0, 0, 0E7h, 0ABh, 8, 0, 1, 0, 1, 0, 0EBh, 0ABh, 7, 0, 1
	db	0, 1, 0, 0F3h, 0ABh, 0, 0, 0, 0, 0, 0, 0FCh, 0ABh, 6, 0, 40h, 0
	db	0, 0, 5, 0ACh, 6, 0, 40h, 0, 40h, 0, 0Fh, 0ACh, 0, 0, 0, 0, 0
	db	0, 18h, 0ACh, 0, 0, 0, 0, 0, 0, 25h, 0ACh, 0, 0, 0, 0, 0, 0, 2Eh
	db	0ACh, 7, 0, 2, 0, 2, 0, 35h, 0ACh, 2, 0, 30h, 0, 10h, 0, 3Ch, 0ACh
	db	0, 0, 0, 0, 0, 0, 46h, 0ACh, 0, 0, 0, 0, 0, 0, 4Bh, 0ACh, 8, 0
	db	1, 0, 2, 0, 5, 'CLASS', 4, 'CODE', 4, 'DATA', 0Bh, 'DESCRIPTION'
	db	0Bh, 'DISCARDABLE', 4, 'DOS4', 0Bh, 'EXECUTEONLY', 0Bh, 'EXECUTEREAD'
	db	7, 'EXETYPE', 7, 'EXPORTS', 5, 'FIXED', 8, 'HEAPSIZE', 7, 'IMPORTS'
	db	4, 'IOPL', 7, 'LIBRARY', 0Ah, 'LOADONCALL', 7, 'MOVABLE', 8, 'MOVEABLE'
	db	8, 'MULTIPLE', 4, 'NAME', 6, 'NODATA', 0Eh, 'NONDISCARDABLE', 4
	db	'NONE', 9, 'NONSHARED', 3, 'OS2', 7, 'PRELOAD', 8, 'PROTMODE'
	db	8, 'READONLY', 9, 'READWRITE', 8, 'REALMODE', 0Ch, 'RESIDENTNAME'
	db	8, 'SEGMENTS', 6, 'SHARED', 6, 'SINGLE', 9, 'STACKSIZE', 4, 'STUB'
	db	7, 'WINDOWS'
L0AC53:	push	ax	;@0AC53
	mov	dx, bx	;@0AC54
	mov	al, byte ptr [bx]	;@0AC56
	xor	ah, ah	;@0AC58
	push	cs	;@0AC5A
	pop	es	;@0AC5B
	mov	bx, 0A9F7h	;@0AC5C
	mov	cx, 25h	;@0AC5F
@@1:	mov	di, word ptr es:[bx]	;@0AC62
	cmp	al, byte ptr es:[di]	;@0AC65
	je	@@4	;@0AC68
@@2:	add	bx, 8	;@0AC6A
	loop	@@1	;@0AC6D
	mov	bx, dx	;@0AC6F
	pop	ax	;@0AC71
	push	ds	;@0AC72
	pop	es	;@0AC73
	stc	;@0AC74
	ret	;@0AC75
@@3:	mov	si, dx	;@0AC76
	call	L0A6B5	;@0AC78
	inc	si	;@0AC7B
	pop	di	;@0AC7C
	push	cx	;@0AC7D
	mov	cx, ax	;@0AC7E
	repe cmpsb	;@0AC80
	pop	cx	;@0AC82
	jne	@@2	;@0AC83
	jmp	short @@5	;@0AC85
@@4:	inc	di	;@0AC87
	push	di	;@0AC88
	push	cx	;@0AC89
	mov	si, dx	;@0AC8A
	inc	si	;@0AC8C
	mov	cx, ax	;@0AC8D
	repe cmpsb	;@0AC8F
	pop	cx	;@0AC91
	jne	@@3	;@0AC92
	add	sp, 2	;@0AC94
@@5:	add	sp, 2	;@0AC97
	lea	ax, [bx+2]	;@0AC9A
	sub	bx, 0A9F7h	;@0AC9D
	shr	bx, 1	;@0ACA1
	shr	bx, 1	;@0ACA3
	shr	bx, 1	;@0ACA5
	add	bx, 6	;@0ACA7
	xchg	ax, bx	;@0ACAA
	push	ds	;@0ACAB
	pop	es	;@0ACAC
	clc	;@0ACAD
	ret	;@0ACAE
L0ACAF:	mov	di, 347Ah	;@0ACAF
	mov	cx, 100h	;@0ACB2
	xor	ax, ax	;@0ACB5
	rep stosw	;@0ACB7
	ret	;@0ACB9
L0ACBA:	mov	word ptr ds:[7686h], bx	;@0ACBA
	mov	word ptr ds:[7688h], bx	;@0ACBE
	mov	word ptr ds:[76B3h], 1	;@0ACC2
	ret	;@0ACC8
L0ACC9:	mov	dx, cx	;@0ACC9
	add	dx, 3	;@0ACCB
	mov	di, dx	;@0ACCE
	push	di	;@0ACD0
	mov	di, 7668h	;@0ACD1
	call	L054ED	;@0ACD4
	jae	@@1	;@0ACD7
	call	TABLE_OVERFLOW	;@0ACD9
@@1:	xor	ax, ax	;@0ACDC
	stosw	;@0ACDE
	mov	si, bx	;@0ACDF
	mov	bx, di	;@0ACE1
	mov	al, cl	;@0ACE3
	stosb	;@0ACE5
	shr	cx, 1	;@0ACE6
	rep movsw	;@0ACE8
	rcl	cx, 1	;@0ACEA
	rep movsb	;@0ACEC
	push	ds	;@0ACEE
	pop	es	;@0ACEF
	ret	;@0ACF0
L0ACF1:	mov	al, byte ptr [bx]	;@0ACF1
	xor	ah, ah	;@0ACF3
	inc	bx	;@0ACF5
	push	ax	;@0ACF6
	mov	cx, ax	;@0ACF7
	mov	si, bx	;@0ACF9
	xor	dx, dx	;@0ACFB
	jcxz	@@2	;@0ACFD
@@1:	lodsb	;@0ACFF
	xor	dl, al	;@0AD00
	add	dx, cx	;@0AD02
	rol	dx, 1	;@0AD04
	rol	dx, 1	;@0AD06
	rol	dx, 1	;@0AD08
	loop	@@1	;@0AD0A
@@2:	pop	cx	;@0AD0C
	and	dx, 1FEh	;@0AD0D
	mov	si, dx	;@0AD11
	add	si, 347Ah	;@0AD13
	mov	dx, word ptr [si]	;@0AD17
	and	dx, dx	;@0AD19
	jne	@@3	;@0AD1B
	push	si	;@0AD1D
	call	L0ACC9	;@0AD1E
	pop	si	;@0AD21
	mov	word ptr [si], bx	;@0AD22
	ret	;@0AD24
@@3:	xchg	bx, dx	;@0AD25
	mov	es, word ptr ds:[766Ch]	;@0AD27
@@4:	cmp	cl, byte ptr es:[bx]	;@0AD2B
	je	@@6	;@0AD2E
	mov	ax, word ptr es:[bx-2]	;@0AD30
@@5:	and	ax, ax	;@0AD34
	je	@@7	;@0AD36
	mov	bx, ax	;@0AD38
	jmp	@@4	;@0AD3A
@@6:	lea	di, [bx+1]	;@0AD3C
	mov	si, dx	;@0AD3F
	mov	ax, cx	;@0AD41
	repe cmpsb	;@0AD43
	mov	cx, ax	;@0AD45
	mov	ax, word ptr es:[bx-2]	;@0AD47
	jne	@@5	;@0AD4B
	push	ds	;@0AD4D
	pop	es	;@0AD4E
	ret	;@0AD4F
@@7:	push	es	;@0AD50
	push	bx	;@0AD51
	mov	bx, dx	;@0AD52
	call	L0ACC9	;@0AD54
	pop	si	;@0AD57
	pop	es	;@0AD58
	mov	word ptr es:[si-2], bx	;@0AD59
	push	ds	;@0AD5D
	pop	es	;@0AD5E
	ret	;@0AD5F
L0AD60:	cmp	byte ptr ds:[768Ah], 0	;@0AD60
	jne	L0ADC8	;@0AD65
	cmp	byte ptr ds:[129h], 2	;@0AD67
	je	L0ADAC	;@0AD6C
	mov	byte ptr ds:[768Ah], 1	;@0AD6E
	cmp	byte ptr ds:[129h], 0	;@0AD73
	jne	L0ADAC	;@0AD78
	mov	byte ptr ds:[129h], 3	;@0AD7A
	push	ax	;@0AD7F
	push	bx	;@0AD80
	mov	ax, 6C64h	;@0AD81
	mov	bl, 6Ch	;@0AD84
	call	L0962A	;@0AD86
	pop	bx	;@0AD89
	pop	ax	;@0AD8A
	jmp	short L0ADAC	;@0AD8B
L0AD8D:	cmp	byte ptr ds:[768Ah], 0	;@0AD8D
	jne	L0ADC8	;@0AD92
	cmp	byte ptr ds:[129h], 3	;@0AD94
	je	L0ADAC	;@0AD99
	mov	byte ptr ds:[768Ah], 2	;@0AD9B
	cmp	byte ptr ds:[129h], 0	;@0ADA0
	je	L0ADAC	;@0ADA5
	mov	byte ptr ds:[129h], 2	;@0ADA7
L0ADAC:	call	L0A699	;@0ADAC
	cmp	al, 2	;@0ADAF
	jne	L0ADBA	;@0ADB1
	mov	word ptr ds:[768Ch], bx	;@0ADB3
L0ADB7:	call	L0A699	;@0ADB7
L0ADBA:	cmp	al, 0	;@0ADBA
	je	@@1	;@0ADBC
	cmp	al, 1	;@0ADBE
	jne	L0ADC8	;@0ADC0
	jmp	L0A703	;@0ADC2
@@1:	jmp	L0A706	;@0ADC5
L0ADC8:	jmp	L0A72B	;@0ADC8
L0ADCB:	call	L0A699	;@0ADCB
	cmp	al, 3	;@0ADCE
	jne	L0ADC8	;@0ADD0
	mov	word ptr ds:[769Ch], bx	;@0ADD2
	jmp	L0ADB7	;@0ADD6
L0ADD8:	call	L0A699	;@0ADD8
	cmp	al, 6	;@0ADDB
	jb	L0ADC8	;@0ADDD
	test	byte ptr cs:[bx], 8	;@0ADDF
	je	L0ADC8	;@0ADE3
	mov	ax, word ptr cs:[bx+4]	;@0ADE5
	mov	byte ptr [bp-8], al	;@0ADE9
	jmp	L0ADB7	;@0ADEC
L0ADEE:	call	L0A699	;@0ADEE
	cmp	al, 2	;@0ADF1
	je	@@1	;@0ADF3
	cmp	al, 3	;@0ADF5
	jne	L0ADC8	;@0ADF7
@@1:	mov	word ptr ds:[769Ah], bx	;@0ADF9
	jmp	L0ADB7	;@0ADFD
L0ADFF:	mov	byte ptr ds:[768Bh], 1	;@0ADFF
	jmp	L0ADB7	;@0AE04
L0AE06:	mov	byte ptr ds:[768Bh], 0	;@0AE06
	jmp	L0ADB7	;@0AE0B
L0AE0D:	mov	ax, 10h	;@0AE0D
	jmp	L0A72E	;@0AE10
L0AE13:	mov	cl, 1	;@0AE13
	mov	di, 768Eh	;@0AE15
	mov	si, 7690h	;@0AE18
	jmp	short L0AE25	;@0AE1B
L0AE1D:	mov	cl, 2	;@0AE1D
	mov	di, 7692h	;@0AE1F
	mov	si, 7694h	;@0AE22
L0AE25:	xor	dx, dx	;@0AE25
	mov	word ptr [bp-6], dx	;@0AE27
@@1:	push	di	;@0AE2A
	push	cx	;@0AE2B
	push	dx	;@0AE2C
	push	si	;@0AE2D
	call	L0A699	;@0AE2E
	pop	si	;@0AE31
	pop	dx	;@0AE32
	pop	cx	;@0AE33
	pop	di	;@0AE34
	cmp	al, 0	;@0AE35
	je	@@2	;@0AE37
	cmp	al, 1	;@0AE39
	je	@@2	;@0AE3B
	cmp	al, 6	;@0AE3D
	jb	L0ADC8	;@0AE3F
	test	byte ptr cs:[bx], cl	;@0AE41
	je	L0ADC8	;@0AE44
	mov	ax, word ptr cs:[bx+2]	;@0AE46
	test	word ptr [si], ax	;@0AE4A
	jne	L0AE0D	;@0AE4C
	or	word ptr [si], ax	;@0AE4E
	not	ax	;@0AE50
	and	dx, ax	;@0AE52
	or	dx, word ptr cs:[bx+4]	;@0AE54
	inc	word ptr [bp-6]	;@0AE58
	jmp	@@1	;@0AE5B
@@2:	cmp	word ptr [bp-6], 0	;@0AE5D
	jne	@@3	;@0AE61
	jmp	L0ADC8	;@0AE63
@@3:	mov	word ptr [di], dx	;@0AE66
	jmp	L0A703	;@0AE68
L0AE6B:	mov	di, 7696h	;@0AE6B
	jmp	short L0AE73	;@0AE6E
L0AE70:	mov	di, 7698h	;@0AE70
L0AE73:	push	di	;@0AE73
	call	L0A699	;@0AE74
	pop	di	;@0AE77
	cmp	al, 4	;@0AE78
	jne	L0AEC1	;@0AE7A
	mov	word ptr [di], bx	;@0AE7C
	jmp	L0ADB7	;@0AE7E
L0AE81:	jmp	L0A706	;@0AE81
L0AE84:	call	L0A699	;@0AE84
	cmp	al, 0	;@0AE87
	je	L0AE81	;@0AE89
	cmp	al, 1	;@0AE8B
	je	L0AE84	;@0AE8D
	cmp	al, 6	;@0AE8F
	jae	L0AE81	;@0AE91
	cmp	al, 2	;@0AE93
	je	@@1	;@0AE95
	cmp	al, 3	;@0AE97
	jne	L0AEC1	;@0AE99
@@1:	mov	di, 0Ch	;@0AE9B
	push	di	;@0AE9E
	mov	di, 7660h	;@0AE9F
	call	L054ED	;@0AEA2
	jae	@@2	;@0AEA5
	call	TABLE_OVERFLOW	;@0AEA7
@@2:	push	di	;@0AEAA
	mov	cx, 6	;@0AEAB
	xor	ax, ax	;@0AEAE
	rep stosw	;@0AEB0
	pop	di	;@0AEB2
	mov	si, word ptr ds:[76ABh]	;@0AEB3
	and	si, si	;@0AEB7
	jne	L0AEC4	;@0AEB9
	mov	word ptr ds:[769Eh], di	;@0AEBB
	jmp	short L0AEC7	;@0AEBF
L0AEC1:	jmp	L0A72B	;@0AEC1
L0AEC4:	mov	word ptr es:[si], di	;@0AEC4
L0AEC7:	mov	word ptr ds:[76ABh], di	;@0AEC7
	mov	word ptr es:[di+2], bx	;@0AECB
	call	L0A699	;@0AECF
	cmp	al, 6	;@0AED2
	jne	@@1	;@0AED4
	call	L0A699	;@0AED6
	cmp	al, 3	;@0AED9
	jne	L0AEC1	;@0AEDB
	mov	word ptr es:[di+4], bx	;@0AEDD
	call	L0A699	;@0AEE1
@@1:	cmp	al, 4	;@0AEE4
	jne	@@2	;@0AEE6
	mov	word ptr es:[di+6], bx	;@0AEE8
	call	L0A699	;@0AEEC
@@2:	xor	cx, cx	;@0AEEF
	xor	dx, dx	;@0AEF1
@@3:	cmp	al, 0	;@0AEF3
	je	@@5	;@0AEF5
	cmp	al, 1	;@0AEF7
	je	@@5	;@0AEF9
	cmp	al, 6	;@0AEFB
	jb	L0AEC1	;@0AEFD
	test	byte ptr cs:[bx], 4	;@0AEFF
	je	L0AEC1	;@0AF03
	mov	ax, word ptr cs:[bx+2]	;@0AF05
	test	cx, ax	;@0AF09
	je	@@4	;@0AF0B
	jmp	L0AE0D	;@0AF0D
@@4:	or	cx, ax	;@0AF10
	not	ax	;@0AF12
	and	dx, ax	;@0AF14
	or	dx, word ptr cs:[bx+4]	;@0AF16
	push	cx	;@0AF1A
	push	dx	;@0AF1B
	call	L0A699	;@0AF1C
	pop	dx	;@0AF1F
	pop	cx	;@0AF20
	jmp	@@3	;@0AF21
@@5:	mov	word ptr es:[di+8], cx	;@0AF23
	mov	word ptr es:[di+0Ah], dx	;@0AF27
	jmp	L0AE84	;@0AF2B
L0AF2E:	jmp	L0A706	;@0AF2E
L0AF31:	jmp	L0A72B	;@0AF31
L0AF34:	call	L0A699	;@0AF34
@@1:	cmp	al, 0	;@0AF37
	je	L0AF2E	;@0AF39
	cmp	al, 1	;@0AF3B
	je	L0AF34	;@0AF3D
	cmp	al, 6	;@0AF3F
	jae	L0AF2E	;@0AF41
	cmp	al, 2	;@0AF43
	jne	L0AF31	;@0AF45
	mov	cx, 0Ah	;@0AF47
	xor	ax, ax	;@0AF4A
	push	ds	;@0AF4C
	pop	es	;@0AF4D
	push	di	;@0AF4E
	mov	di, 7670h	;@0AF4F
	rep stosb	;@0AF52
	pop	di	;@0AF54
	mov	word ptr ds:[7672h], bx	;@0AF55
	call	L0A699	;@0AF59
	cmp	al, 5	;@0AF5C
	jne	@@2	;@0AF5E
	cmp	ah, 3Dh	;@0AF60
	jne	@@3	;@0AF63
	call	L0A699	;@0AF65
	cmp	al, 2	;@0AF68
	jne	L0AF31	;@0AF6A
	mov	word ptr ds:[7674h], bx	;@0AF6C
	call	L0A699	;@0AF70
@@2:	cmp	al, 5	;@0AF73
	jne	@@4	;@0AF75
@@3:	cmp	ah, 40h	;@0AF77
	jne	L0AF31	;@0AF7A
	call	L0A699	;@0AF7C
	cmp	al, 4	;@0AF7F
	jne	L0AF31	;@0AF81
	inc	word ptr [bp-4]	;@0AF83
	mov	word ptr ds:[7676h], bx	;@0AF86
	or	byte ptr ds:[7678h], 8	;@0AF8A
	call	L0A699	;@0AF8F
@@4:	cmp	al, 24h	;@0AF92
	jne	@@5	;@0AF94
	or	byte ptr ds:[7678h], 1	;@0AF96
	call	L0A699	;@0AF9B
@@5:	cmp	al, 1Ah	;@0AF9E
	jne	@@6	;@0AFA0
	or	byte ptr ds:[7678h], 2	;@0AFA2
	call	L0A699	;@0AFA7
@@6:	cmp	al, 4	;@0AFAA
	jne	@@7	;@0AFAC
	cmp	bx, 100h	;@0AFAE
	ja	@@14	;@0AFB2
	mov	byte ptr ds:[7679h], bl	;@0AFB4
	or	byte ptr ds:[7678h], 4	;@0AFB8
	call	L0A699	;@0AFBD
@@7:	push	ax	;@0AFC0
	cmp	word ptr ds:[7674h], 0	;@0AFC1
	jne	@@8	;@0AFC6
	mov	ax, word ptr ds:[7672h]	;@0AFC8
	mov	word ptr ds:[7674h], ax	;@0AFCB
@@8:	call	L0BBC8	;@0AFCE
	or	ax, ax	;@0AFD1
	jne	@@13	;@0AFD3
	inc	word ptr [bp-2]	;@0AFD5
	push	cx	;@0AFD8
	push	si	;@0AFD9
	mov	di, 0Ah	;@0AFDA
	push	di	;@0AFDD
	mov	di, 7660h	;@0AFDE
	call	L054ED	;@0AFE1
	jae	@@9	;@0AFE4
	call	TABLE_OVERFLOW	;@0AFE6
@@9:	push	di	;@0AFE9
	mov	cx, 5	;@0AFEA
	mov	si, 7670h	;@0AFED
	rep movsw	;@0AFF0
	pop	di	;@0AFF2
	mov	si, word ptr ds:[76ADh]	;@0AFF3
	and	si, si	;@0AFF7
	jne	@@10	;@0AFF9
	mov	word ptr ds:[76A0h], di	;@0AFFB
	jmp	short @@11	;@0AFFF
@@10:	mov	word ptr es:[si], di	;@0B001
@@11:	mov	word ptr ds:[76ADh], di	;@0B004
	pop	si	;@0B008
	pop	cx	;@0B009
@@12:	pop	ax	;@0B00A
	jmp	@@1	;@0B00B
@@13:	call	L0B0DA	;@0B00E
	jmp	@@12	;@0B011
@@14:	jmp	L0A72B	;@0B013
L0B016:	jmp	L0A706	;@0B016
L0B019:	call	L0A699	;@0B019
	cmp	al, 0	;@0B01C
	je	L0B016	;@0B01E
	cmp	al, 1	;@0B020
	je	L0B019	;@0B022
	cmp	al, 6	;@0B024
	jae	L0B016	;@0B026
	cmp	al, 2	;@0B028
	je	@@1	;@0B02A
	jmp	@@7	;@0B02C
@@1:	mov	cx, 0Ah	;@0B02F
	xor	ax, ax	;@0B032
	push	ds	;@0B034
	pop	es	;@0B035
	push	di	;@0B036
	mov	di, 767Ah	;@0B037
	rep stosb	;@0B03A
	pop	di	;@0B03C
	push	bx	;@0B03D
	call	L0A699	;@0B03E
	pop	dx	;@0B041
	cmp	al, 5	;@0B042
	jne	@@2	;@0B044
	cmp	ah, 3Dh	;@0B046
	jne	@@2	;@0B049
	mov	word ptr ds:[767Ch], dx	;@0B04B
	call	L0A699	;@0B04F
	cmp	al, 2	;@0B052
	jne	@@7	;@0B054
	push	bx	;@0B056
	call	L0A699	;@0B057
	pop	dx	;@0B05A
@@2:	mov	word ptr ds:[767Eh], dx	;@0B05B
	cmp	al, 5	;@0B05F
	jne	@@7	;@0B061
	cmp	ah, 2Eh	;@0B063
	jne	@@7	;@0B066
	call	L0A699	;@0B068
	cmp	al, 4	;@0B06B
	je	@@3	;@0B06D
	cmp	al, 2	;@0B06F
	jne	@@7	;@0B071
	mov	word ptr ds:[7680h], bx	;@0B073
	jmp	short @@4	;@0B077
@@3:	cmp	word ptr ds:[767Ch], 0	;@0B079
	je	@@11	;@0B07E
	mov	word ptr ds:[7682h], bx	;@0B080
@@4:	cmp	word ptr ds:[767Ch], 0	;@0B084
	jne	@@5	;@0B089
	mov	ax, word ptr ds:[7680h]	;@0B08B
	mov	word ptr ds:[767Ch], ax	;@0B08E
@@5:	call	L0BBFA	;@0B091
	or	ax, ax	;@0B094
	jne	@@12	;@0B096
	mov	di, 0Ah	;@0B098
	push	di	;@0B09B
	mov	di, 7660h	;@0B09C
	call	L054ED	;@0B09F
	jae	@@6	;@0B0A2
	call	TABLE_OVERFLOW	;@0B0A4
@@6:	push	di	;@0B0A7
	mov	si, 767Ah	;@0B0A8
	mov	cx, 5	;@0B0AB
	rep movsw	;@0B0AE
	pop	di	;@0B0B0
	mov	si, word ptr ds:[76AFh]	;@0B0B1
	and	si, si	;@0B0B5
	jne	@@8	;@0B0B7
	mov	word ptr ds:[76A2h], di	;@0B0B9
	jmp	short @@9	;@0B0BD
@@7:	jmp	L0A72B	;@0B0BF
@@8:	mov	word ptr es:[si], di	;@0B0C2
@@9:	mov	word ptr ds:[76AFh], di	;@0B0C5
@@10:	call	L0A699	;@0B0C9
	jmp	L0B019	;@0B0CC
@@11:	mov	ax, 0Fh	;@0B0CF
	jmp	L0A72E	;@0B0D2
@@12:	call	L0B0DA	;@0B0D5
	jmp	@@10	;@0B0D8
L0B0DA:	push	bx	;@0B0DA
	push	si	;@0B0DB
	push	word ptr ds:[76B3h]	;@0B0DC
	mov	si, word ptr ds:[13Eh]	;@0B0E0
	add	si, 2	;@0B0E4
	lds	bx, dword ptr ds:[132h]	;@0B0E7
	mov	ds, word ptr [bx]	;@0B0EB
	push	ds	;@0B0ED
	push	si	;@0B0EE
	mov	ds, word ptr cs:DATA_SEGMENT	;@0B0EF
	mov	bx, ax	;@0B0F4
	mov	ax, 6	;@0B0F6
	push	ax	;@0B0F9
	mov	ax, bx	;@0B0FA
	push	ax	;@0B0FC
	call	WARNING	;@0B0FD
	pop	si	;@0B100
	pop	bx	;@0B101
	ret	;@0B102
L0B103:	push	es	;@0B103
	push	si	;@0B104
	push	di	;@0B105
	mov	di, 7DAh	;@0B106
	call	NEW_POOL	;@0B109
	mov	si, word ptr ds:[768Ch]	;@0B10C
	xor	cx, cx	;@0B110
	push	bx	;@0B112
	push	dx	;@0B113
	xor	dx, dx	;@0B114
	xor	bx, bx	;@0B116
	call	L0B53C	;@0B118
	pop	dx	;@0B11B
	pop	bx	;@0B11C
	mov	bx, word ptr ds:[76A0h]	;@0B11D
	jmp	short @@4	;@0B121
@@1:	mov	bx, word ptr es:[bx]	;@0B123
	jmp	short @@4	;@0B126
@@2:	mov	es, word ptr ds:[7664h]	;@0B128
	mov	si, word ptr es:[bx+2]	;@0B12C
	mov	cx, word ptr es:[bx+6]	;@0B130
	cmp	cx, -1	;@0B134
	je	@@1	;@0B137
	mov	al, byte ptr es:[bx+8]	;@0B139
	test	al, 1	;@0B13D
	jne	@@3	;@0B13F
	test	al, 8	;@0B141
	jne	@@1	;@0B143
@@3:	mov	bx, word ptr es:[bx]	;@0B145
	push	bx	;@0B148
	push	dx	;@0B149
	xor	dx, dx	;@0B14A
	mov	bx, ax	;@0B14C
	call	L0B53C	;@0B14E
	pop	dx	;@0B151
	pop	bx	;@0B152
@@4:	or	bx, bx	;@0B153
	jne	@@2	;@0B155
	mov	di, 1	;@0B157
	push	di	;@0B15A
	mov	di, 7DAh	;@0B15B
	call	L054ED	;@0B15E
	jae	@@5	;@0B161
	call	TABLE_OVERFLOW	;@0B163
@@5:	mov	byte ptr es:[di], 0	;@0B166
	mov	cx, word ptr ds:[7DCh]	;@0B16A
	pop	di	;@0B16E
	pop	si	;@0B16F
	pop	es	;@0B170
	ret	;@0B171
L0B172:	push	bp	;@0B172
	mov	bp, sp	;@0B173
	sub	sp, 14h	;@0B175
	push	di	;@0B178
	push	si	;@0B179
	push	es	;@0B17A
	push	bx	;@0B17B
	push	cx	;@0B17C
	push	dx	;@0B17D
	mov	byte ptr [bp-14h], 0FFh	;@0B17E
	mov	di, 7D2h	;@0B182
	call	NEW_POOL	;@0B185
	cmp	word ptr ds:[7F6h], -1	;@0B188
	jne	@@1	;@0B18D
	mov	di, 7F2h	;@0B18F
	call	NEW_POOL	;@0B192
	jmp	short @@2	;@0B195
@@1:	mov	word ptr ds:[7F4h], 0	;@0B197
@@2:	mov	si, word ptr ds:[76A0h]	;@0B19D
	mov	es, word ptr ds:[7664h]	;@0B1A1
	jmp	short @@6	;@0B1A5
@@3:	cmp	word ptr es:[si+6], -1	;@0B1A7
	je	@@5	;@0B1AC
	mov	di, 2	;@0B1AE
	push	di	;@0B1B1
	mov	di, 7F2h	;@0B1B2
	call	L054ED	;@0B1B5
	jae	@@4	;@0B1B8
	call	TABLE_OVERFLOW	;@0B1BA
@@4:	mov	word ptr es:[di], si	;@0B1BD
@@5:	mov	es, word ptr ds:[7664h]	;@0B1C0
	mov	si, word ptr es:[si]	;@0B1C4
@@6:	or	si, si	;@0B1C7
	jne	@@3	;@0B1C9
	push	bp	;@0B1CB
	mov	bp, offset L0B8D9	;@0B1CC
	mov	cx, word ptr ds:[7F4h]	;@0B1CF
	mov	es, word ptr ds:[7F6h]	;@0B1D3
	call	L09252	;@0B1D7
	pop	bp	;@0B1DA
	xor	di, di	;@0B1DB
	mov	word ptr [bp-4], di	;@0B1DD
	mov	word ptr [bp-10h], 1	;@0B1E0
	jmp	@@19	;@0B1E5
@@7:	mov	ax, 7	;@0B1E8
	call	L0961E	;@0B1EB
@@8:	push	word ptr es:[di+6]	;@0B1EE
	call	L0B8B6	;@0B1F2
	jmp	@@18	;@0B1F5
@@9:	mov	word ptr [bp-0Eh], 1	;@0B1F8
	mov	es, word ptr ds:[7F6h]	;@0B1FD
	mov	di, word ptr es:[di]	;@0B201
	mov	es, word ptr ds:[7664h]	;@0B204
	cmp	word ptr es:[di+6], -1	;@0B208
	jne	@@10	;@0B20D
	jmp	@@20	;@0B20F
@@10:	cmp	byte ptr ds:[129h], 3	;@0B212
	jne	@@11	;@0B217
	test	byte ptr es:[di+8], 2	;@0B219
	jne	@@11	;@0B21E
	or	word ptr [bp-0Eh], 2	;@0B220
@@11:	mov	bx, word ptr es:[di+4]	;@0B224
	mov	cx, word ptr es:[di+6]	;@0B228
	mov	dl, byte ptr es:[di+8]	;@0B22C
	sub	cx, word ptr [bp-10h]	;@0B230
	jb	@@8	;@0B233
	je	@@12	;@0B235
	call	L0B49D	;@0B237
@@12:	test	dl, 80h	;@0B23A
	je	@@15	;@0B23D
	cmp	bx, -1	;@0B23F
	je	@@17	;@0B242
	push	bx	;@0B244
	and	bx, 3	;@0B245
	shl	bx, 1	;@0B248
	shl	bx, 1	;@0B24A
	shl	bx, 1	;@0B24C
	mov	es, word ptr [bx+756h]	;@0B24E
	pop	bx	;@0B252
	mov	cx, word ptr es:[bx+4]	;@0B253
	mov	word ptr [bp-8], cx	;@0B257
	mov	bx, word ptr es:[bx]	;@0B25A
	cmp	bx, -1	;@0B25D
	je	@@7	;@0B260
	mov	es, word ptr ds:[776h]	;@0B262
	cmp	byte ptr es:[bx+9], 0FFh	;@0B266
	je	@@18	;@0B26B
	mov	dx, word ptr es:[bx]	;@0B26D
	mov	es, word ptr ds:[77Eh]	;@0B270
	mov	di, word ptr es:[bx]	;@0B274
	mov	es, word ptr ds:[79Eh]	;@0B277
	mov	cx, word ptr es:[di+6]	;@0B27B
	mov	word ptr [bp-0Ah], cx	;@0B27F
	mov	byte ptr [bp-12h], 0	;@0B282
	test	byte ptr es:[di+13h], 1	;@0B286
	je	@@13	;@0B28B
	inc	byte ptr [bp-12h]	;@0B28D
@@13:	call	L0B3D8	;@0B290
	jae	@@14	;@0B293
	call	L0B404	;@0B295
@@14:	mov	ax, word ptr [bp-0Eh]	;@0B298
	cmp	byte ptr [bp-12h], 0	;@0B29B
	je	@@16	;@0B29F
	call	L0B464	;@0B2A1
	jmp	short @@17	;@0B2A4
@@15:	jmp	L0B4C3	;@0B2A6
@@16:	call	L0B43E	;@0B2A9
@@17:	inc	word ptr [bp-10h]	;@0B2AC
@@18:	mov	di, word ptr [bp-4]	;@0B2AF
	add	di, 2	;@0B2B2
	mov	word ptr [bp-4], di	;@0B2B5
@@19:	cmp	di, word ptr ds:[7F4h]	;@0B2B8
	jae	@@20	;@0B2BC
	jmp	@@9	;@0B2BE
@@20:	mov	word ptr ds:[7F4h], 0	;@0B2C1
	cmp	byte ptr ds:[768Bh], 1	;@0B2C7
	jne	@@21	;@0B2CC
	jmp	@@33	;@0B2CE
@@21:	push	bx	;@0B2D1
	push	si	;@0B2D2
	xor	di, di	;@0B2D3
	push	di	;@0B2D5
	mov	bx, 752h	;@0B2D6
@@22:	push	di	;@0B2D9
	and	di, 3	;@0B2DA
	shl	di, 1	;@0B2DD
	shl	di, 1	;@0B2DF
	shl	di, 1	;@0B2E1
	mov	es, word ptr [di+756h]	;@0B2E3
	pop	di	;@0B2E7
	jmp	short @@26	;@0B2E8
@@23:	push	bx	;@0B2EA
	push	di	;@0B2EB
	and	di, 3	;@0B2EC
	shl	di, 1	;@0B2EF
	shl	di, 1	;@0B2F1
	shl	di, 1	;@0B2F3
	mov	es, word ptr [di+756h]	;@0B2F5
	pop	di	;@0B2F9
	test	byte ptr es:[di+0Eh], 0A2h	;@0B2FA
	jne	@@25	;@0B2FF
	mov	ax, word ptr es:[di+4]	;@0B301
	mov	word ptr [bp-8], ax	;@0B305
	mov	ax, word ptr es:[di]	;@0B308
	mov	word ptr [bp-0Ch], ax	;@0B30B
	mov	bx, word ptr es:[di+2]	;@0B30E
	cmp	bx, -1	;@0B312
	je	@@25	;@0B315
	push	bx	;@0B317
	and	bx, 3	;@0B318
	shl	bx, 1	;@0B31B
	shl	bx, 1	;@0B31D
	shl	bx, 1	;@0B31F
	mov	es, word ptr [bx+736h]	;@0B321
	pop	bx	;@0B325
	cmp	word ptr es:[bx+0Ah], 2	;@0B326
	jb	@@25	;@0B32B
	mov	bx, word ptr [bp-0Ch]	;@0B32D
	mov	es, word ptr ds:[77Eh]	;@0B330
	mov	si, word ptr es:[bx]	;@0B334
	mov	es, word ptr ds:[79Eh]	;@0B337
	mov	ax, word ptr es:[si+6]	;@0B33B
	mov	word ptr [bp-0Ah], ax	;@0B33F
	test	byte ptr es:[si+13h], 1	;@0B342
	je	@@25	;@0B347
	mov	byte ptr [bp-12h], 1	;@0B349
	call	L0B3D8	;@0B34D
	jae	@@24	;@0B350
	call	L0B404	;@0B352
@@24:	xor	ax, ax	;@0B355
	call	L0B464	;@0B357
@@25:	add	di, word ptr ds:[48Eh]	;@0B35A
	pop	bx	;@0B35E
@@26:	cmp	di, word ptr [bx+2]	;@0B35F
	jae	@@27	;@0B362
	jmp	@@23	;@0B364
@@27:	cmp	bx, 762h	;@0B366
	ja	@@28	;@0B36A
	add	bx, 8	;@0B36C
	pop	di	;@0B36F
	inc	di	;@0B370
	push	di	;@0B371
	jmp	@@22	;@0B372
@@28:	pop	si	;@0B375
	pop	bx	;@0B376
	xor	di, di	;@0B377
	jmp	short @@32	;@0B379
@@29:	mov	es, word ptr ds:[79Eh]	;@0B37B
	test	byte ptr es:[di+13h], 1	;@0B37F
	je	@@31	;@0B384
	mov	ax, word ptr es:[di+6]	;@0B386
	mov	word ptr [bp-0Ah], ax	;@0B38A
	mov	word ptr [bp-8], 0	;@0B38D
	mov	byte ptr [bp-12h], 1	;@0B392
	call	L0B3D8	;@0B396
	jae	@@30	;@0B399
	call	L0B404	;@0B39B
@@30:	xor	al, al	;@0B39E
	call	L0B464	;@0B3A0
@@31:	add	di, 14h	;@0B3A3
@@32:	cmp	di, word ptr ds:[79Ch]	;@0B3A6
	jb	@@29	;@0B3AA
@@33:	mov	di, 2	;@0B3AC
	push	di	;@0B3AF
	mov	di, 7D2h	;@0B3B0
	call	L054ED	;@0B3B3
	jae	@@34	;@0B3B6
	call	TABLE_OVERFLOW	;@0B3B8
@@34:	mov	word ptr es:[di], 0	;@0B3BB
	mov	ax, word ptr ds:[7D4h]	;@0B3C0
	pop	dx	;@0B3C3
	pop	cx	;@0B3C4
	pop	bx	;@0B3C5
	pop	es	;@0B3C6
	pop	si	;@0B3C7
	pop	di	;@0B3C8
	mov	sp, bp	;@0B3C9
	pop	bp	;@0B3CB
	ret	;@0B3CC
L0B3CD:	xor	al, al	;@0B3CD
	and	si, 80h	;@0B3CF
	je	@@1	;@0B3D3
	inc	al	;@0B3D5
@@1:	ret	;@0B3D7
L0B3D8:	push	di	;@0B3D8
	mov	al, byte ptr [bp-14h]	;@0B3D9
	cmp	al, 0FFh	;@0B3DC
	je	@@1	;@0B3DE
	mov	di, word ptr [bp-2]	;@0B3E0
	mov	es, word ptr ds:[7D6h]	;@0B3E3
	cmp	byte ptr es:[di], 0FFh	;@0B3E7
	je	@@1	;@0B3EB
	cmp	al, byte ptr [bp-12h]	;@0B3ED
	jne	@@1	;@0B3F0
	or	al, al	;@0B3F2
	jne	@@2	;@0B3F4
	mov	ax, word ptr [bp-0Ah]	;@0B3F6
	cmp	ax, word ptr [bp-6]	;@0B3F9
	je	@@2	;@0B3FC
@@1:	stc	;@0B3FE
	jmp	short @@3	;@0B3FF
@@2:	clc	;@0B401
@@3:	pop	di	;@0B402
	ret	;@0B403
L0B404:	push	di	;@0B404
	push	ax	;@0B405
	mov	al, byte ptr [bp-14h]	;@0B406
	cmp	al, 0FFh	;@0B409
	jne	@@1	;@0B40B
@@1:	mov	di, 2	;@0B40D
	push	di	;@0B410
	mov	di, 7D2h	;@0B411
	call	L054ED	;@0B414
	jae	@@2	;@0B417
	call	TABLE_OVERFLOW	;@0B419
@@2:	mov	byte ptr es:[di], 0	;@0B41C
	mov	word ptr [bp-2], di	;@0B420
	mov	al, byte ptr [bp-12h]	;@0B423
	mov	byte ptr [bp-14h], al	;@0B426
	or	al, al	;@0B429
	mov	al, 0FFh	;@0B42B
	jne	@@3	;@0B42D
	xor	ax, ax	;@0B42F
	mov	al, byte ptr [bp-0Ah]	;@0B431
	mov	word ptr [bp-6], ax	;@0B434
@@3:	mov	byte ptr es:[di+1], al	;@0B437
	pop	ax	;@0B43B
	pop	di	;@0B43C
	ret	;@0B43D
L0B43E:	push	di	;@0B43E
	mov	es, word ptr ds:[7D6h]	;@0B43F
	mov	di, word ptr [bp-2]	;@0B443
	inc	byte ptr es:[di]	;@0B446
	mov	di, 3	;@0B449
	push	di	;@0B44C
	mov	di, 7D2h	;@0B44D
	call	L054ED	;@0B450
	jae	@@1	;@0B453
	call	TABLE_OVERFLOW	;@0B455
@@1:	mov	byte ptr es:[di], al	;@0B458
	mov	ax, word ptr [bp-8]	;@0B45B
	mov	word ptr es:[di+1], ax	;@0B45E
	pop	di	;@0B462
	ret	;@0B463
L0B464:	push	di	;@0B464
	inc	word ptr ds:[6CDh]	;@0B465
	mov	es, word ptr ds:[7D6h]	;@0B469
	mov	di, word ptr [bp-2]	;@0B46D
	inc	byte ptr es:[di]	;@0B470
	mov	di, 6	;@0B473
	push	di	;@0B476
	mov	di, 7D2h	;@0B477
	call	L054ED	;@0B47A
	jb	@@1	;@0B47D
	mov	byte ptr es:[di], al	;@0B47F
	mov	ax, word ptr cs:L0B4C9	;@0B482
	mov	word ptr es:[di+1], ax	;@0B486
	mov	al, byte ptr [bp-0Ah]	;@0B48A
	mov	byte ptr es:[di+3], al	;@0B48D
	mov	ax, word ptr [bp-8]	;@0B491
	mov	word ptr es:[di+4], ax	;@0B494
	pop	di	;@0B498
	ret	;@0B499
@@1:	call	TABLE_OVERFLOW	;@0B49A
L0B49D:	push	di	;@0B49D
	mov	byte ptr [bp-14h], 0FFh	;@0B49E
	mov	di, 2	;@0B4A2
	push	di	;@0B4A5
	mov	di, 7D2h	;@0B4A6
	call	L054ED	;@0B4A9
	jae	@@1	;@0B4AC
	call	TABLE_OVERFLOW	;@0B4AE
@@1:	mov	byte ptr es:[di], cl	;@0B4B1
	mov	byte ptr es:[di+1], 0	;@0B4B4
	mov	di, word ptr [bp-10h]	;@0B4B9
	add	di, cx	;@0B4BC
	mov	word ptr [bp-10h], di	;@0B4BE
	pop	di	;@0B4C1
	ret	;@0B4C2
L0B4C3:	mov	ax, 5	;@0B4C3
	call	L0961E	;@0B4C6
L0B4C9:	int	3Fh	;@0B4C9
L0B4CB:	push	bx	;@0B4CB
	push	si	;@0B4CC
	push	di	;@0B4CD
	push	es	;@0B4CE
	mov	di, 7E2h	;@0B4CF
	call	NEW_POOL	;@0B4D2
	mov	si, word ptr ds:[769Ch]	;@0B4D5
	xor	cx, cx	;@0B4D9
	push	bx	;@0B4DB
	push	dx	;@0B4DC
	xor	dx, dx	;@0B4DD
	xor	bx, bx	;@0B4DF
	call	L0B563	;@0B4E1
	pop	dx	;@0B4E4
	pop	bx	;@0B4E5
	mov	bx, word ptr ds:[76A0h]	;@0B4E6
	jmp	short @@3	;@0B4EA
@@1:	mov	bx, word ptr es:[bx]	;@0B4EC
	jmp	short @@3	;@0B4EF
@@2:	mov	es, word ptr ds:[7664h]	;@0B4F1
	mov	si, word ptr es:[bx+2]	;@0B4F5
	mov	cx, word ptr es:[bx+6]	;@0B4F9
	cmp	cx, -1	;@0B4FD
	je	@@1	;@0B500
	mov	al, byte ptr es:[bx+8]	;@0B502
	test	al, 8	;@0B506
	je	@@1	;@0B508
	test	al, 1	;@0B50A
	jne	@@1	;@0B50C
	mov	bx, word ptr es:[bx]	;@0B50E
	push	bx	;@0B511
	push	dx	;@0B512
	xor	dx, dx	;@0B513
	mov	bx, ax	;@0B515
	call	L0B563	;@0B517
	pop	dx	;@0B51A
	pop	bx	;@0B51B
@@3:	or	bx, bx	;@0B51C
	jne	@@2	;@0B51E
	mov	di, 1	;@0B520
	push	di	;@0B523
	mov	di, 7E2h	;@0B524
	call	L054ED	;@0B527
	jae	@@4	;@0B52A
	call	TABLE_OVERFLOW	;@0B52C
@@4:	mov	byte ptr es:[di], 0	;@0B52F
	mov	cx, word ptr ds:[7E4h]	;@0B533
	pop	es	;@0B537
	pop	di	;@0B538
	pop	si	;@0B539
	pop	bx	;@0B53A
	ret	;@0B53B
L0B53C:	push	cx	;@0B53C
	push	si	;@0B53D
	push	di	;@0B53E
	push	cx	;@0B53F
	call	L0B58A	;@0B540
	push	cx	;@0B543
	add	cx, 2	;@0B544
	mov	di, cx	;@0B547
	push	di	;@0B549
	mov	di, 7DAh	;@0B54A
	call	L054ED	;@0B54D
	jae	@@1	;@0B550
	call	TABLE_OVERFLOW	;@0B552
@@1:	mov	si, 560h	;@0B555
	pop	cx	;@0B558
	rep movsb	;@0B559
	pop	cx	;@0B55B
	mov	word ptr es:[di], cx	;@0B55C
	pop	di	;@0B55F
	pop	si	;@0B560
	pop	cx	;@0B561
	ret	;@0B562
L0B563:	push	si	;@0B563
	push	di	;@0B564
	push	cx	;@0B565
	push	cx	;@0B566
	call	L0B58A	;@0B567
	push	cx	;@0B56A
	add	cx, 2	;@0B56B
	mov	di, cx	;@0B56E
	push	di	;@0B570
	mov	di, 7E2h	;@0B571
	call	L054ED	;@0B574
	jae	@@1	;@0B577
	call	TABLE_OVERFLOW	;@0B579
@@1:	mov	si, 560h	;@0B57C
	pop	cx	;@0B57F
	rep movsb	;@0B580
	pop	cx	;@0B582
	mov	word ptr es:[di], cx	;@0B583
	pop	cx	;@0B586
	pop	di	;@0B587
	pop	si	;@0B588
	ret	;@0B589
L0B58A:	test	bl, 80h	;@0B58A
	jne	@@5	;@0B58D
	mov	es, word ptr ds:[766Ch]	;@0B58F
@@1:	xor	cx, cx	;@0B593
	mov	cl, byte ptr es:[si]	;@0B595
	inc	cl	;@0B598
	push	cx	;@0B59A
	mov	di, 560h	;@0B59B
	push	ds	;@0B59E
	push	ds	;@0B59F
	push	es	;@0B5A0
	pop	ds	;@0B5A1
	pop	es	;@0B5A2
	lodsb	;@0B5A3
	stosb	;@0B5A4
@@2:	dec	cx	;@0B5A5
	jcxz	@@4	;@0B5A6
	lodsb	;@0B5A8
	or	dx, dx	;@0B5A9
	je	@@3	;@0B5AB
	cmp	al, 61h	;@0B5AD
	jb	@@3	;@0B5AF
	cmp	al, 7Ah	;@0B5B1
	ja	@@3	;@0B5B3
	sub	al, 20h	;@0B5B5
@@3:	stosb	;@0B5B7
	jmp	@@2	;@0B5B8
@@4:	pop	ds	;@0B5BA
	pop	cx	;@0B5BB
	ret	;@0B5BC
@@5:	push	si	;@0B5BD
	and	si, 3	;@0B5BE
	shl	si, 1	;@0B5C1
	shl	si, 1	;@0B5C3
	shl	si, 1	;@0B5C5
	mov	es, word ptr [si+716h]	;@0B5C7
	pop	si	;@0B5CB
	inc	si	;@0B5CC
	inc	si	;@0B5CD
	jmp	@@1	;@0B5CE
L0B5D0:	push	si	;@0B5D0
	push	bx	;@0B5D1
	push	cx	;@0B5D2
	push	dx	;@0B5D3
	xor	si, si	;@0B5D4
	mov	cx, word ptr ds:[7DCh]	;@0B5D6
	mov	ax, word ptr ds:[7652h]	;@0B5DA
	add	ax, word ptr ds:[6C3h]	;@0B5DD
	xor	dx, dx	;@0B5E1
	mov	bx, 7DEh	;@0B5E3
	call	L08AC5	;@0B5E6
	pop	dx	;@0B5E9
	pop	cx	;@0B5EA
	pop	bx	;@0B5EB
	pop	si	;@0B5EC
	ret	;@0B5ED
L0B5EE:	push	si	;@0B5EE
	push	bx	;@0B5EF
	push	cx	;@0B5F0
	push	dx	;@0B5F1
	xor	si, si	;@0B5F2
	mov	cx, word ptr ds:[7E4h]	;@0B5F4
	mov	ax, word ptr ds:[6C9h]	;@0B5F8
	xor	dx, dx	;@0B5FB
	mov	bx, 7E6h	;@0B5FD
	call	L08AC5	;@0B600
	pop	dx	;@0B603
	pop	cx	;@0B604
	pop	bx	;@0B605
	pop	si	;@0B606
	ret	;@0B607
L0B608:	push	si	;@0B608
	push	bx	;@0B609
	push	cx	;@0B60A
	push	dx	;@0B60B
	xor	si, si	;@0B60C
	mov	cx, word ptr ds:[7D4h]	;@0B60E
	mov	ax, word ptr ds:[7652h]	;@0B612
	add	ax, word ptr ds:[6A1h]	;@0B615
	xor	dx, dx	;@0B619
	mov	bx, 7D6h	;@0B61B
	call	L08AC5	;@0B61E
	pop	dx	;@0B621
	pop	cx	;@0B622
	pop	bx	;@0B623
	pop	si	;@0B624
	ret	;@0B625
L0B626:	mov	ax, word ptr ds:[7696h]	;@0B626
	mov	bx, word ptr ds:[7698h]	;@0B629
	ret	;@0B62D
L0B62E:	xor	si, si	;@0B62E
	mov	es, word ptr ds:[776h]	;@0B630
	jmp	short @@3	;@0B634
@@1:	cmp	bx, word ptr es:[si]	;@0B636
	jne	@@2	;@0B639
	cmp	cx, word ptr es:[si+2]	;@0B63B
	je	@@4	;@0B63F
@@2:	add	si, 0Ah	;@0B641
@@3:	cmp	si, word ptr ds:[774h]	;@0B644
	jb	@@1	;@0B648
	stc	;@0B64A
	jmp	short @@5	;@0B64B
@@4:	clc	;@0B64D
@@5:	ret	;@0B64E
L0B64F:	test cx, ax	;@0B64F
	je	@@2	;@0B651
	test dx, ax	;@0B653
	jne	@@1	;@0B655
	not	si	;@0B657
	and	bx, si	;@0B659
	jmp	short @@2	;@0B65B
@@1:	or	bx, si	;@0B65D
@@2:	ret	;@0B65F
L0B660:	push	bx	;@0B660
	push	si	;@0B661
	xor	bx, bx	;@0B662
	mov	bl, al	;@0B664
	mov	ax, 80h	;@0B666
	mov	si, 1	;@0B669
	call	L0B64F	;@0B66C
	mov	ax, 2	;@0B66F
	mov	si, 2	;@0B672
	call	L0B64F	;@0B675
	mov	ax, 1	;@0B678
	mov	si, 4	;@0B67B
	call	L0B64F	;@0B67E
	mov	ax, 100h	;@0B681
	mov	si, 10h	;@0B684
	call	L0B64F	;@0B687
	mov	ax, 100h	;@0B68A
	mov	si, 1	;@0B68D
	call	L0B64F	;@0B690
	mov	al, bl	;@0B693
	pop	si	;@0B695
	pop	bx	;@0B696
	ret	;@0B697
L0B698:	push	di	;@0B698
	push	si	;@0B699
	push	bx	;@0B69A
	push	cx	;@0B69B
	push	dx	;@0B69C
	mov	ax, word ptr ds:[768Eh]	;@0B69D
	or	ax, word ptr ds:[7692h]	;@0B6A0
	je	@@10	;@0B6A4
	xor	di, di	;@0B6A6
	mov	es, word ptr ds:[79Eh]	;@0B6A8
	jmp	short @@9	;@0B6AC
@@1:	mov	si, word ptr ds:[768Eh]	;@0B6AE
	cmp	byte ptr es:[di+1], 1	;@0B6B2
	je	@@2	;@0B6B7
	mov	si, word ptr ds:[7692h]	;@0B6B9
@@2:	test	si, 80h	;@0B6BD
	je	@@3	;@0B6C1
	or	byte ptr es:[di+13h], 1	;@0B6C3
@@3:	test	si, 2	;@0B6C8
	je	@@4	;@0B6CC
	or	byte ptr es:[di+13h], 2	;@0B6CE
@@4:	test	si, 20h	;@0B6D3
	jne	@@5	;@0B6D7
	test	si, 10h	;@0B6D9
	je	@@5	;@0B6DD
	or	byte ptr es:[di+13h], 2	;@0B6DF
@@5:	test	si, 1	;@0B6E4
	je	@@6	;@0B6E8
	or	byte ptr es:[di+13h], 4	;@0B6EA
@@6:	test	si, 4	;@0B6EF
	je	@@7	;@0B6F3
	or	byte ptr es:[di+13h], 8	;@0B6F5
@@7:	test	si, 100h	;@0B6FA
	je	@@8	;@0B6FE
	or	byte ptr es:[di+13h], 10h	;@0B700
	or	byte ptr es:[di+13h], 1	;@0B705
@@8:	add	di, 14h	;@0B70A
@@9:	cmp	di, word ptr ds:[79Ch]	;@0B70D
	jb	@@1	;@0B711
@@10:	mov	al, byte ptr ds:[3476h]	;@0B713
	push	ax	;@0B716
	mov	byte ptr ds:[3476h], 2	;@0B717
	mov	di, word ptr ds:[769Eh]	;@0B71C
	mov	es, word ptr ds:[7664h]	;@0B720
	jmp	short @@14	;@0B724
@@11:	mov	si, word ptr es:[di+2]	;@0B726
	push	word ptr es:[di+8]	;@0B72A
	push	word ptr es:[di+0Ah]	;@0B72E
	push	word ptr es:[di+4]	;@0B732
	mov	es, word ptr ds:[766Ch]	;@0B736
	mov	ah, 80h	;@0B73A
	mov	word ptr ds:[3450h], es	;@0B73C
	call	L0910F	;@0B740
	pop	si	;@0B743
	push	bx	;@0B744
	mov	bx, word ptr ds:[44Ch]	;@0B745
	cmp	si, 0	;@0B749
	je	@@12	;@0B74C
	mov	es, word ptr ds:[766Ch]	;@0B74E
	mov	ah, 80h	;@0B752
	mov	word ptr ds:[3450h], es	;@0B754
	call	L0910F	;@0B758
@@12:	mov	cx, bx	;@0B75B
	pop	bx	;@0B75D
	call	L0B62E	;@0B75E
	pop	dx	;@0B761
	pop	cx	;@0B762
	jb	@@13	;@0B763
	mov	es, word ptr ds:[77Eh]	;@0B765
	mov	si, word ptr es:[si]	;@0B769
	cmp	si, -1	;@0B76C
	je	@@13	;@0B76F
	mov	es, word ptr ds:[79Eh]	;@0B771
	mov	al, byte ptr es:[si+13h]	;@0B775
	call	L0B660	;@0B779
	mov	byte ptr es:[si+13h], al	;@0B77C
@@13:	mov	es, word ptr ds:[7664h]	;@0B780
	mov	di, word ptr es:[di]	;@0B784
@@14:	or	di, di	;@0B787
	jne	@@11	;@0B789
	pop	ax	;@0B78B
	mov	byte ptr ds:[3476h], al	;@0B78C
	pop	dx	;@0B78F
	pop	cx	;@0B790
	pop	bx	;@0B791
	pop	si	;@0B792
	pop	di	;@0B793
	ret	;@0B794
L0B795:	push	bp	;@0B795
	mov	bp, sp	;@0B796
	lea	sp, [bp-2]	;@0B798
	push	ax	;@0B79B
	push	si	;@0B79C
	push	cx	;@0B79D
	cmp	word ptr ds:[76A6h], 0	;@0B79E
	jne	@@2	;@0B7A3
@@1:	pop	cx	;@0B7A5
	pop	si	;@0B7A6
	pop	ax	;@0B7A7
	mov	sp, bp	;@0B7A8
	pop	bp	;@0B7AA
	ret	;@0B7AB
@@2:	mov	ax, word ptr ds:[76A4h]	;@0B7AC
	sub	ax, word ptr ds:[76A6h]	;@0B7AF
	jne	@@6	;@0B7B3
	mov	si, word ptr ds:[76A0h]	;@0B7B5
	mov	cx, 1	;@0B7B9
	jmp	short @@5	;@0B7BC
@@3:	mov	es, word ptr ds:[7664h]	;@0B7BE
	cmp	word ptr es:[si+6], -1	;@0B7C2
	je	@@4	;@0B7C7
	mov	word ptr es:[si+6], cx	;@0B7C9
	inc	cx	;@0B7CD
@@4:	mov	si, word ptr es:[si]	;@0B7CE
@@5:	or	si, si	;@0B7D1
	jne	@@3	;@0B7D3
	jmp	@@1	;@0B7D5
@@6:	mov	di, 7F2h	;@0B7D7
	call	NEW_POOL	;@0B7DA
	mov	cx, 1	;@0B7DD
	mov	si, word ptr ds:[76A0h]	;@0B7E0
	mov	es, word ptr ds:[7664h]	;@0B7E4
	jmp	short @@9	;@0B7E8
@@7:	test	byte ptr es:[si+8], 8	;@0B7EA
	je	@@8	;@0B7EF
	mov	ax, word ptr es:[si+6]	;@0B7F1
	cmp	ax, 0FFFFh	;@0B7F5
	je	@@8	;@0B7F8
	cmp	ax, cx	;@0B7FA
	jb	@@8	;@0B7FC
	mov	cx, ax	;@0B7FE
@@8:	mov	si, word ptr es:[si]	;@0B800
@@9:	or	si, si	;@0B803
	jne	@@7	;@0B805
	add	cx, word ptr ds:[76A6h]	;@0B807
	add	cx, 8	;@0B80B
	shr	cx, 1	;@0B80E
	shr	cx, 1	;@0B810
	shr	cx, 1	;@0B812
	mov	di, cx	;@0B814
	push	di	;@0B816
	mov	di, 7F2h	;@0B817
	call	L054ED	;@0B81A
	jae	@@10	;@0B81D
	call	TABLE_OVERFLOW	;@0B81F
@@10:	mov	word ptr [bp-2], di	;@0B822
	xor	al, al	;@0B825
	cld	;@0B827
	rep stosb	;@0B828
	mov	di, word ptr [bp-2]	;@0B82A
	mov	si, word ptr ds:[76A0h]	;@0B82D
	jmp	short @@14	;@0B831
@@11:	mov	es, word ptr ds:[7664h]	;@0B833
	test	byte ptr es:[si+8], 8	;@0B837
	je	@@13	;@0B83C
	mov	ax, word ptr es:[si+6]	;@0B83E
	cmp	ax, 0FFFFh	;@0B842
	je	@@13	;@0B845
	dec	ax	;@0B847
	mov	es, word ptr ds:[7F6h]	;@0B848
	mov	di, word ptr [bp-2]	;@0B84C
	mov	cx, word ptr ds:[7F4h]	;@0B84F
	call	L0B91E	;@0B853
	jne	@@18	;@0B856
	call	L0B90D	;@0B858
@@12:	mov	es, word ptr ds:[7664h]	;@0B85B
@@13:	mov	si, word ptr es:[si]	;@0B85F
@@14:	or	si, si	;@0B862
	jne	@@11	;@0B864
	mov	si, word ptr ds:[76A0h]	;@0B866
	jmp	short @@17	;@0B86A
@@15:	test	byte ptr es:[si+8], 8	;@0B86C
	jne	@@16	;@0B871
	cmp	word ptr es:[si+6], -1	;@0B873
	je	@@16	;@0B878
	mov	es, word ptr ds:[7F6h]	;@0B87A
	mov	di, word ptr [bp-2]	;@0B87E
	mov	cx, word ptr ds:[7F4h]	;@0B881
	call	L0B92F	;@0B885
	cmp	ax, 0FFFFh	;@0B888
	je	@@19	;@0B88B
	call	L0B90D	;@0B88D
	inc	ax	;@0B890
	mov	es, word ptr ds:[7664h]	;@0B891
	mov	word ptr es:[si+6], ax	;@0B895
@@16:	mov	si, word ptr es:[si]	;@0B899
@@17:	or	si, si	;@0B89C
	jne	@@15	;@0B89E
	jmp	@@1	;@0B8A0
@@18:	mov	es, word ptr ds:[7664h]	;@0B8A3
	push	word ptr es:[si+6]	;@0B8A7
	call	L0B8B6	;@0B8AB
	jmp	@@12	;@0B8AE
@@19:	mov	ax, 8	;@0B8B0
	call	L0961E	;@0B8B3
L0B8B6:	push	bp	;@0B8B6
	mov	bp, sp	;@0B8B7
	push	ax	;@0B8B9
	push	bx	;@0B8BA
	push	cx	;@0B8BB
	push	dx	;@0B8BC
	push	si	;@0B8BD
	push	di	;@0B8BE
	push	word ptr [bp+4]	;@0B8BF
	mov	ax, 2	;@0B8C2
	push	ax	;@0B8C5
	mov	ax, 3Dh	;@0B8C6
	push	ax	;@0B8C9
	call WARNING	;@0B8CA
	pop	di	;@0B8CD
	pop	si	;@0B8CE
	pop	dx	;@0B8CF
	pop	cx	;@0B8D0
	pop	bx	;@0B8D1
	pop	ax	;@0B8D2
	mov	sp, bp	;@0B8D3
	pop	bp	;@0B8D5
	ret	2	;@0B8D6
L0B8D9:	push	bx	;@0B8D9
	push	ax	;@0B8DA
	mov	es, word ptr ds:[7664h]	;@0B8DB
	mov	bx, word ptr es:[si+6]	;@0B8DF
	cmp	bx, word ptr es:[di+6]	;@0B8E3
	jg	@@1	;@0B8E7
	stc	;@0B8E9
	jmp	short @@2	;@0B8EA
@@1:	clc	;@0B8EC
@@2:	lahf	;@0B8ED
	mov	es, word ptr ds:[7F6h]	;@0B8EE
	sahf	;@0B8F2
	pop	ax	;@0B8F3
	pop	bx	;@0B8F4
	ret	;@0B8F5
L0B8F6:	push	dx	;@0B8F6
	mov	cx, ax	;@0B8F7
	shr	ax, 1	;@0B8F9
	shr	ax, 1	;@0B8FB
	shr	ax, 1	;@0B8FD
	mov	dx, ax	;@0B8FF
	shl	ax, 1	;@0B901
	shl	ax, 1	;@0B903
	shl	ax, 1	;@0B905
	sub	cx, ax	;@0B907
	add	di, dx	;@0B909
	pop	dx	;@0B90B
	ret	;@0B90C
L0B90D:	push	ax	;@0B90D
	push	cx	;@0B90E
	push	di	;@0B90F
	call	L0B8F6	;@0B910
	mov	al, 80h	;@0B913
	shr	al, cl	;@0B915
	or	byte ptr es:[di], al	;@0B917
	pop	di	;@0B91A
	pop	cx	;@0B91B
	pop	ax	;@0B91C
	ret	;@0B91D
L0B91E:	push	ax	;@0B91E
	push	cx	;@0B91F
	push	di	;@0B920
	call	L0B8F6	;@0B921
	mov	al, 80h	;@0B924
	shr	al, cl	;@0B926
	test	byte ptr es:[di], al	;@0B928
	pop	di	;@0B92B
	pop	cx	;@0B92C
	pop	ax	;@0B92D
	ret	;@0B92E
L0B92F:	push	es	;@0B92F
	push	di	;@0B930
	push	bx	;@0B931
	push	cx	;@0B932
	push	cx	;@0B933
	mov	al, 0FFh	;@0B934
	cld	;@0B936
	repe scasb	;@0B937
	je	@@2	;@0B939
	pop	bx	;@0B93B
	sub	bx, cx	;@0B93C
	dec	bx	;@0B93E
	shl	bx, 1	;@0B93F
	shl	bx, 1	;@0B941
	shl	bx, 1	;@0B943
	mov	al, byte ptr es:[di-1]	;@0B945
	xor	cx, cx	;@0B949
@@1:	shl	al, 1	;@0B94B
	jae	@@3	;@0B94D
	inc	cx	;@0B94F
	jmp	@@1	;@0B950
@@2:	add	sp, 2	;@0B952
	mov	ax, 0FFFFh	;@0B955
	jmp	short @@4	;@0B958
@@3:	add	bx, cx	;@0B95A
	mov	ax, bx	;@0B95C
@@4:	pop	cx	;@0B95E
	pop	bx	;@0B95F
	pop	di	;@0B960
	pop	es	;@0B961
	ret	;@0B962
L0B963:	push	bp	;@0B963
	mov	bp, sp	;@0B964
	lea	sp, [bp-0Ah]	;@0B966
	push	bx	;@0B969
	push	cx	;@0B96A
	push	dx	;@0B96B
	push	si	;@0B96C
	mov	ax, word ptr es:[bx+6]	;@0B96D
	mov	word ptr [bp-2], ax	;@0B971
	mov	word ptr [bp-4], cx	;@0B974
	xor	ax, ax	;@0B977
	mov	byte ptr [bp-0Ah], al	;@0B979
	inc	ax	;@0B97C
	mov	word ptr [bp-8], ax	;@0B97D
	test	byte ptr es:[bx+13h], 1	;@0B980
	je	@@1	;@0B985
	dec	byte ptr [bp-0Ah]	;@0B987
@@1:	mov	es, word ptr ds:[7D6h]	;@0B98A
	xor	si, si	;@0B98E
	mov	word ptr [bp-6], si	;@0B990
	cmp	byte ptr es:[si], 0	;@0B993
	je	@@4	;@0B997
@@2:	call	@@6	;@0B999
	jb	@@3	;@0B99C
	call	@@11	;@0B99E
	jae	@@5	;@0B9A1
@@3:	call	@@19	;@0B9A3
	jb	@@4	;@0B9A6
	jmp	@@2	;@0B9A8
@@4:	mov	ax, 0FFFFh	;@0B9AA
@@5:	pop	si	;@0B9AD
	pop	dx	;@0B9AE
	pop	cx	;@0B9AF
	pop	bx	;@0B9B0
	mov	sp, bp	;@0B9B1
	pop	bp	;@0B9B3
	ret	;@0B9B4
@@6:	cmp	byte ptr [bp-0Ah], 0	;@0B9B5
	jne	@@8	;@0B9B9
	mov	si, word ptr [bp-6]	;@0B9BB
	xor	ax, ax	;@0B9BE
	mov	al, byte ptr es:[si+1]	;@0B9C0
	cmp	al, 0FFh	;@0B9C4
	je	@@9	;@0B9C6
	cmp	ax, word ptr [bp-2]	;@0B9C8
	jne	@@9	;@0B9CB
@@7:	clc	;@0B9CD
	jmp	short @@10	;@0B9CE
@@8:	cmp	byte ptr es:[si+1], 0FFh	;@0B9D0
	je	@@7	;@0B9D5
@@9:	stc	;@0B9D7
@@10:	ret	;@0B9D8
@@11:	mov	si, word ptr [bp-6]	;@0B9D9
	xor	cx, cx	;@0B9DC
	mov	cl, byte ptr es:[si]	;@0B9DE
	mov	dx, word ptr [bp-4]	;@0B9E1
	cmp	byte ptr es:[si+1], 0FFh	;@0B9E4
	je	@@13	;@0B9E9
	add	si, 2	;@0B9EB
@@12:	cmp	word ptr es:[si+1], dx	;@0B9EE
	je	@@17	;@0B9F2
	add	si, 3	;@0B9F4
	dec	cx	;@0B9F7
	jne	@@12	;@0B9F8
	jmp	short @@16	;@0B9FA
@@13:	add	si, 2	;@0B9FC
	mov	ax, word ptr [bp-2]	;@0B9FF
@@14:	cmp	byte ptr es:[si+3], al	;@0BA02
	jne	@@15	;@0BA06
	cmp	word ptr es:[si+4], dx	;@0BA08
	je	@@17	;@0BA0C
@@15:	add	si, 6	;@0BA0E
	dec	cx	;@0BA11
	jne	@@14	;@0BA12
@@16:	mov	ax, 0FFFFh	;@0BA14
	stc	;@0BA17
	jmp	short @@18	;@0BA18
@@17:	mov	ax, word ptr [bp-8]	;@0BA1A
	mov	si, word ptr [bp-6]	;@0BA1D
	xor	bx, bx	;@0BA20
	mov	bl, byte ptr es:[si]	;@0BA22
	add	ax, bx	;@0BA25
	sub	ax, cx	;@0BA27
	clc	;@0BA29
@@18:	ret	;@0BA2A
@@19:	mov	si, word ptr [bp-6]	;@0BA2B
	xor	cx, cx	;@0BA2E
	mov	cl, byte ptr es:[si]	;@0BA30
	add	word ptr [bp-8], cx	;@0BA33
	mov	ax, 6	;@0BA36
	cmp	byte ptr es:[si+1], 0FFh	;@0BA39
	je	@@20	;@0BA3E
	xor	ax, ax	;@0BA40
	cmp	byte ptr es:[si+1], 0	;@0BA42
	je	@@20	;@0BA47
	mov	ax, 3	;@0BA49
@@20:	mul	cx	;@0BA4C
	add	si, 2	;@0BA4E
	add	si, ax	;@0BA51
	mov	word ptr [bp-6], si	;@0BA53
	cmp	byte ptr es:[si], 0	;@0BA56
	je	@@21	;@0BA5A
	clc	;@0BA5C
	jmp	short @@22	;@0BA5D
@@21:	stc	;@0BA5F
@@22:	ret	;@0BA60
L0BA61:	push	bp	;@0BA61
	mov	bp, sp	;@0BA62
	push	di	;@0BA64
	push	bx	;@0BA65
	push	dx	;@0BA66
	mov	di, word ptr ds:[76A2h]	;@0BA67
	jmp	@@4	;@0BA6B
@@1:	mov	es, word ptr ds:[7664h]	;@0BA6E
	mov	si, word ptr es:[di+4]	;@0BA72
	mov	dx, word ptr es:[di+8]	;@0BA76
	mov	word ptr ds:[6E1h], dx	;@0BA7A
	mov	es, word ptr ds:[766Ch]	;@0BA7E
	xor	ah, ah	;@0BA82
	mov	word ptr ds:[3450h], es	;@0BA84
	call	L0910F	;@0BA88
	mov	word ptr ds:[6DFh], bx	;@0BA8B
	mov	es, word ptr ds:[7664h]	;@0BA8F
	mov	si, word ptr es:[di+6]	;@0BA93
	or	si, si	;@0BA97
	je	@@2	;@0BA99
	mov	es, word ptr ds:[766Ch]	;@0BA9B
	xor	ah, ah	;@0BA9F
	push	di	;@0BAA1
	mov	word ptr ds:[3450h], es	;@0BAA2
	call	L0910F	;@0BAA6
	pop	di	;@0BAA9
	mov	word ptr ds:[6DDh], bx	;@0BAAA
@@2:	mov	es, word ptr ds:[7664h]	;@0BAAE
	mov	si, word ptr es:[di+2]	;@0BAB2
	mov	es, word ptr ds:[766Ch]	;@0BAB6
	xor	ax, ax	;@0BABA
	cmp	byte ptr ds:[127h], 0	;@0BABC
	je	@@3	;@0BAC1
	inc	ax	;@0BAC3
@@3:	push	word ptr ds:[120h]	;@0BAC4
	mov	byte ptr ds:[120h], al	;@0BAC8
	push	di	;@0BACB
	xor	ah, ah	;@0BACC
	mov	word ptr ds:[3450h], es	;@0BACE
	call	L0910F	;@0BAD2
	pop	di	;@0BAD5
	pop	ax	;@0BAD6
	mov	byte ptr ds:[120h], al	;@0BAD7
	mov	word ptr ds:[6E5h], bx	;@0BADA
	mov	word ptr ds:[6E3h], 0	;@0BADE
	push	di	;@0BAE4
	call	L0BAFE	;@0BAE5
	pop	di	;@0BAE8
	mov	es, word ptr ds:[7664h]	;@0BAE9
	mov	di, word ptr es:[di]	;@0BAED
@@4:	or	di, di	;@0BAF0
	je	@@5	;@0BAF2
	jmp	@@1	;@0BAF4
@@5:	pop	dx	;@0BAF7
	pop	bx	;@0BAF8
	pop	di	;@0BAF9
	mov	sp, bp	;@0BAFA
	pop	bp	;@0BAFC
	ret	;@0BAFD
L0BAFE:	push	bx	;@0BAFE
	mov	di, 0Ch	;@0BAFF
	push	di	;@0BB02
	mov	di, 802h	;@0BB03
	call	L054ED	;@0BB06
	jae	@@1	;@0BB09
	call	TABLE_OVERFLOW	;@0BB0B
@@1:	push	di	;@0BB0E
	mov	si, 6DDh	;@0BB0F
	mov	cx, 0Ch	;@0BB12
	shr	cx, 1	;@0BB15
	rep movsw	;@0BB17
	rcl	cx, 1	;@0BB19
	rep movsb	;@0BB1B
	mov	bx, word ptr ds:[6E5h]	;@0BB1D
	push	bx	;@0BB21
	and	bx, 3	;@0BB22
	shl	bx, 1	;@0BB25
	shl	bx, 1	;@0BB27
	shl	bx, 1	;@0BB29
	mov	es, word ptr [bx+716h]	;@0BB2B
	pop	bx	;@0BB2F
	cmp	word ptr es:[bx], -1	;@0BB30
	jne	@@2	;@0BB34
	call	L017D8	;@0BB36
	mov	word ptr es:[di], 0	;@0BB39
	pop	word ptr es:[di+2]	;@0BB3E
	mov	word ptr es:[di+0Ch], bx	;@0BB42
	mov	byte ptr es:[di+0Eh], 20h	;@0BB46
	push	bx	;@0BB4B
	and	bx, 3	;@0BB4C
	shl	bx, 1	;@0BB4F
	shl	bx, 1	;@0BB51
	shl	bx, 1	;@0BB53
	mov	es, word ptr [bx+716h]	;@0BB55
	pop	bx	;@0BB59
	mov	word ptr es:[bx], di	;@0BB5A
	jmp	short @@3	;@0BB5D
@@2:	mov	di, word ptr es:[bx]	;@0BB5F
	push	di	;@0BB62
	and	di, 3	;@0BB63
	shl	di, 1	;@0BB66
	shl	di, 1	;@0BB68
	shl	di, 1	;@0BB6A
	mov	es, word ptr [di+756h]	;@0BB6C
	pop	di	;@0BB70
	test	byte ptr es:[di+0Eh], 10h	;@0BB71
	je	@@4	;@0BB76
	pop	word ptr es:[di+2]	;@0BB78
	or	byte ptr es:[di+0Eh], 20h	;@0BB7C
	and	byte ptr es:[di+0Eh], 0EFh	;@0BB81
@@3:	pop	bx	;@0BB86
	ret	;@0BB87
@@4:	add	sp, 2	;@0BB88
	jmp	@@3	;@0BB8B
L0BB8D:	mov	al, byte ptr ds:[76AAh]	;@0BB8D
	ret	;@0BB90
	db	3Bh, 0F7h, 0C3h	;@0BB91
L0BB94:	push	ax	;@0BB94
	push	cx	;@0BB95
	push	si	;@0BB96
	mov	di, 0Ah	;@0BB97
	push	di	;@0BB9A
	mov	di, 7660h	;@0BB9B
	call	L054ED	;@0BB9E
	jae	@@1	;@0BBA1
	call	TABLE_OVERFLOW	;@0BBA3
@@1:	push	di	;@0BBA6
	mov	cx, 5	;@0BBA7
	xor	ax, ax	;@0BBAA
	rep stosw	;@0BBAC
	pop	di	;@0BBAE
	mov	si, word ptr ds:[76ADh]	;@0BBAF
	and	si, si	;@0BBB3
	jne	@@2	;@0BBB5
	mov	word ptr ds:[76A0h], di	;@0BBB7
	jmp	short @@3	;@0BBBB
@@2:	mov	word ptr es:[si], di	;@0BBBD
@@3:	mov	word ptr ds:[76ADh], di	;@0BBC0
	pop	si	;@0BBC4
	pop	cx	;@0BBC5
	pop	ax	;@0BBC6
	ret	;@0BBC7
L0BBC8:	push	bx	;@0BBC8
	push	si	;@0BBC9
	mov	si, word ptr ds:[76A0h]	;@0BBCA
	mov	es, word ptr ds:[7664h]	;@0BBCE
	jmp	short @@2	;@0BBD2
@@1:	mov	ax, 3Fh	;@0BBD4
	mov	bx, word ptr es:[si+4]	;@0BBD7
	cmp	bx, word ptr ds:[7674h]	;@0BBDB
	je	@@3	;@0BBDF
	mov	ax, 3Eh	;@0BBE1
	mov	bx, word ptr es:[si+2]	;@0BBE4
	cmp	bx, word ptr ds:[7672h]	;@0BBE8
	je	@@3	;@0BBEC
	mov	si, word ptr es:[si]	;@0BBEE
@@2:	or	si, si	;@0BBF1
	jne	@@1	;@0BBF3
	xor	ax, ax	;@0BBF5
@@3:	pop	si	;@0BBF7
	pop	bx	;@0BBF8
	ret	;@0BBF9
L0BBFA:	push	bx	;@0BBFA
	push	si	;@0BBFB
	mov	si, word ptr ds:[76A2h]	;@0BBFC
	mov	es, word ptr ds:[7664h]	;@0BC00
	jmp	short @@2	;@0BC04
@@1:	mov	ax, 40h	;@0BC06
	mov	bx, word ptr es:[si+2]	;@0BC09
	cmp	bx, word ptr ds:[767Ch]	;@0BC0D
	je	@@3	;@0BC11
	mov	si, word ptr es:[si]	;@0BC13
@@2:	or	si, si	;@0BC16
	jne	@@1	;@0BC18
	xor	ax, ax	;@0BC1A
@@3:	pop	si	;@0BC1C
	pop	bx	;@0BC1D
	ret	;@0BC1E
L0BC1F:	push	ds	;@0BC1F
	pop	es	;@0BC20
	mov	di, 768Ah	;@0BC21
	mov	cx, 21h	;@0BC24
	xor	ax, ax	;@0BC27
	rep stosb	;@0BC29
	mov	byte ptr ds:[768Bh], 1	;@0BC2B
	cmp	byte ptr ds:[17h], 1	;@0BC30
	jne	@@3	;@0BC35
	cmp	word ptr ds:[13Eh], 0	;@0BC37
	jne	@@4	;@0BC3C
	mov	word ptr ds:[768Eh], 181h	;@0BC3E
	cmp	byte ptr ds:[129h], 3	;@0BC44
	je	@@1	;@0BC49
	mov	word ptr ds:[7692h], 81h	;@0BC4B
	mov	word ptr ds:[7650h], 2	;@0BC51
	jmp	short @@2	;@0BC57
@@1:	mov	word ptr ds:[7692h], 3	;@0BC59
	mov	word ptr ds:[7650h], 8001h	;@0BC5F
@@2:	mov	word ptr ds:[7696h], 1000h	;@0BC65
	mov	word ptr ds:[7698h], 1400h	;@0BC6B
	xor	ax, ax	;@0BC71
	push	ax	;@0BC73
	mov	ax, 42h	;@0BC74
	push	ax	;@0BC77
	call WARNING	;@0BC78
	jmp	short @@4	;@0BC7B
@@3:	cmp	word ptr ds:[13Eh], 0	;@0BC7D
	je	@@6	;@0BC82
	mov	word ptr ds:[7650h], 2	;@0BC84
@@4:	call	L0A566	;@0BC8A
	mov	dx, word ptr ds:[13Eh]	;@0BC8D
	and	dx, dx	;@0BC91
	je	@@5	;@0BC93
	push	ds	;@0BC95
	add	dx, 2	;@0BC96
	mov	ax, 3D00h	;@0BC99
	lds	bx, dword ptr ds:[132h]	;@0BC9C
	mov	ds, word ptr [bx]	;@0BCA0
	call	OPEN_FILE	;@0BCA2
	pop	ds	;@0BCA5
	mov	bx, ax	;@0BCA6
	push	bx	;@0BCA8
	call	L0A6DC	;@0BCA9
	pop	dx	;@0BCAC
	push	ax	;@0BCAD
	push	bx	;@0BCAE
	mov	bx, dx	;@0BCAF
	call	CLOSE_FILE	;@0BCB1
	pop	bx	;@0BCB4
	pop	ax	;@0BCB5
	and	ax, ax	;@0BCB6
	jne	@@7	;@0BCB8
@@5:	call	L0A62F	;@0BCBA
	push	ds	;@0BCBD
	pop	es	;@0BCBE
	mov	di, 347Ah	;@0BCBF
	mov	cx, 2000h	;@0BCC2
	shr	cx, 1	;@0BCC5
	mov	ax, 0FFFFh	;@0BCC7
	rep stosw	;@0BCCA
@@6:	ret	;@0BCCC
@@7:	push	cx	;@0BCCD
	mov	si, word ptr ds:[13Eh]	;@0BCCE
	add	si, 2	;@0BCD2
	lds	bx, dword ptr ds:[132h]	;@0BCD5
	mov	ds, word ptr [bx]	;@0BCD9
	push	ds	;@0BCDB
	push	si	;@0BCDC
	mov	ds, word ptr cs:DATA_SEGMENT	;@0BCDD
	mov	bx, 6	;@0BCE2
	push	bx	;@0BCE5
	push	ax	;@0BCE6
	call FATAL	;@0BCE7
L0BCEA:	mov	di, word ptr ds:[76A0h]	;@0BCEA
	mov	es, word ptr ds:[7664h]	;@0BCEE
	jmp	@@6	;@0BCF2
@@1:	mov	dl, byte ptr es:[di+8]	;@0BCF5
	mov	bx, word ptr es:[di+4]	;@0BCF9
	mov	cx, word ptr es:[di+2]	;@0BCFD
	test	dl, 80h	;@0BD01
	jne	@@3	;@0BD04
	mov	es, word ptr ds:[766Ch]	;@0BD06
	mov	si, cx	;@0BD0A
	mov	word ptr ds:[3450h], es	;@0BD0C
	xor	ax, ax	;@0BD10
	cmp	byte ptr ds:[127h], 0	;@0BD12
	je	@@2	;@0BD17
	inc	ax	;@0BD19
@@2:	push	word ptr ds:[120h]	;@0BD1A
	mov	byte ptr ds:[120h], al	;@0BD1E
	push	bx	;@0BD21
	xor	ah, ah	;@0BD22
	call	L0910F	;@0BD24
	pop	si	;@0BD27
	mov	es, word ptr ds:[766Ch]	;@0BD28
	push	bx	;@0BD2C
	mov	word ptr ds:[3450h], es	;@0BD2D
	xor	ah, ah	;@0BD31
	mov	byte ptr ds:[3476h], 2	;@0BD33
	push	si	;@0BD38
	call	L0910F	;@0BD39
	pop	si	;@0BD3C
	pop	cx	;@0BD3D
	pop	ax	;@0BD3E
	mov	byte ptr ds:[120h], al	;@0BD3F
	mov	byte ptr ds:[3476h], 0FFh	;@0BD42
	jb	@@8	;@0BD47
	mov	bx, word ptr es:[bx]	;@0BD49
@@3:	cmp	bx, -1	;@0BD4C
	je	@@8	;@0BD4F
	mov	es, word ptr ds:[7664h]	;@0BD51
	mov	word ptr es:[di+4], bx	;@0BD55
	mov	word ptr es:[di+2], cx	;@0BD59
	or	byte ptr es:[di+8], 80h	;@0BD5D
	push	bx	;@0BD62
	and	bx, 3	;@0BD63
	shl	bx, 1	;@0BD66
	shl	bx, 1	;@0BD68
	shl	bx, 1	;@0BD6A
	mov	es, word ptr [bx+756h]	;@0BD6C
	pop	bx	;@0BD70
	test	byte ptr es:[bx+0Eh], 80h	;@0BD71
	jne	@@9	;@0BD76
	or	byte ptr es:[bx+0Eh], 81h	;@0BD78
	mov	bx, word ptr es:[bx+2]	;@0BD7D
	push	bx	;@0BD81
	and	bx, 3	;@0BD82
	shl	bx, 1	;@0BD85
	shl	bx, 1	;@0BD87
	shl	bx, 1	;@0BD89
	mov	es, word ptr [bx+736h]	;@0BD8B
	pop	bx	;@0BD8F
	cmp	word ptr es:[bx+0Ah], 1	;@0BD90
	jne	@@4	;@0BD95
	dec	word ptr es:[bx+0Ah]	;@0BD97
@@4:	mov	es, word ptr ds:[7664h]	;@0BD9B
@@5:	mov	di, word ptr es:[di]	;@0BD9F
@@6:	or	di, di	;@0BDA2
	je	@@7	;@0BDA4
	jmp	@@1	;@0BDA6
@@7:	ret	;@0BDA9
@@8:	push	ax	;@0BDAA
	push	bx	;@0BDAB
	push	cx	;@0BDAC
	push	dx	;@0BDAD
	push	si	;@0BDAE
	push	di	;@0BDAF
	mov	es, word ptr ds:[766Ch]	;@0BDB0
	push	ds	;@0BDB4
	mov	di, 26h	;@0BDB5
	push	di	;@0BDB8
	push	es	;@0BDB9
	push	si	;@0BDBA
	call	L095A3	;@0BDBB
	push	ds	;@0BDBE
	mov	si, 26h	;@0BDBF
	push	si	;@0BDC2
	mov	ax, 4	;@0BDC3
	push	ax	;@0BDC6
	mov	ax, 3Ah	;@0BDC7
	push	ax	;@0BDCA
	call WARNING	;@0BDCB
	pop	di	;@0BDCE
	pop	si	;@0BDCF
	pop	dx	;@0BDD0
	pop	cx	;@0BDD1
	pop	bx	;@0BDD2
	pop	ax	;@0BDD3
@@9:	mov	es, word ptr ds:[7664h]	;@0BDD4
	mov	word ptr es:[di+6], 0FFFFh	;@0BDD8
	jmp	@@5	;@0BDDE
; FORMAT: a small printf: format string and arguments into a buffer.
FORMAT:	pop	ax	;@0BDE0
	pop	dx	;@0BDE1
	push	bp	;@0BDE2
	mov	bp, sp	;@0BDE3
	sub	sp, 6	;@0BDE5
	push	ds	;@0BDE8
	mov	word ptr [bp-6], ax	;@0BDE9
	mov	word ptr [bp-4], dx	;@0BDEC
	mov	word ptr [bp-2], 0Ah	;@0BDEF
	les	di, dword ptr [bp+2]	;@0BDF4
	lds	si, dword ptr [bp+6]	;@0BDF7
@@1:	lodsb	;@0BDFA
	cmp	al, 0	;@0BDFB
	je	@@8	;@0BDFD
	cmp	al, 25h	;@0BDFF
	je	@@2	;@0BE01
	stosb	;@0BE03
	jmp	@@1	;@0BE04
@@2:	lodsb	;@0BE06
	cmp	al, 73h	;@0BE07
	je	@@3	;@0BE09
	cmp	al, 64h	;@0BE0B
	je	@@6	;@0BE0D
	cmp	al, 78h	;@0BE0F
	je	@@7	;@0BE11
	jmp	@@1	;@0BE13
@@3:	push	ds	;@0BE15
	push	si	;@0BE16
	mov	si, word ptr [bp-2]	;@0BE17
	mov	ax, word ptr [bp+si+2]	;@0BE1A
	mov	ds, ax	;@0BE1D
	mov	si, word ptr [bp+si]	;@0BE1F
@@4:	lodsb	;@0BE21
	cmp	al, 0	;@0BE22
	je	@@5	;@0BE24
	stosb	;@0BE26
	jmp	@@4	;@0BE27
@@5:	pop	si	;@0BE29
	pop	ds	;@0BE2A
	add	word ptr [bp-2], 4	;@0BE2B
	jmp	@@1	;@0BE2F
@@6:	push	ds	;@0BE31
	push	si	;@0BE32
	mov	si, word ptr [bp-2]	;@0BE33
	mov	si, word ptr [bp+si]	;@0BE36
	push	ds	;@0BE38
	push	es	;@0BE39
	pop	ds	;@0BE3A
	call	PUT_DECIMAL	;@0BE3B
	pop	ds	;@0BE3E
	pop	si	;@0BE3F
	pop	ds	;@0BE40
	add	word ptr [bp-2], 2	;@0BE41
	jmp	@@1	;@0BE45
@@7:	push	ds	;@0BE47
	push	si	;@0BE48
	mov	si, word ptr [bp-2]	;@0BE49
	mov	ax, word ptr [bp+si]	;@0BE4C
	push	ds	;@0BE4E
	push	es	;@0BE4F
	pop	ds	;@0BE50
	call	HEX_WORD	;@0BE51
	pop	ds	;@0BE54
	pop	si	;@0BE55
	pop	ds	;@0BE56
	add	word ptr [bp-2], 2	;@0BE57
	jmp	@@1	;@0BE5B
@@8:	mov	al, 0	;@0BE5D
	stosb	;@0BE5F
	mov	bx, word ptr [bp-6]	;@0BE60
	mov	cx, word ptr [bp-4]	;@0BE63
	mov	ax, word ptr [bp-2]	;@0BE66
	add	ax, bp	;@0BE69
	pop	ds	;@0BE6B
	mov	sp, bp	;@0BE6C
	pop	bp	;@0BE6E
	mov	sp, ax	;@0BE6F
	push	cx	;@0BE71
	push	bx	;@0BE72
	retf	;@0BE73
; MESSAGE_TEXT: the far address (DX:AX) of message number [bp+4] in TLDATA's table.
MESSAGE_TEXT:	push	bp	;@0BE74
	mov	bp, sp	;@0BE75
	push	es	;@0BE77
	push	bx	;@0BE78
	db	0BAh	;@0BE79
	dw	seg D1019_START
	mov ax, 8CDh	;@0BE7C
	mov	es, dx	;@0BE7F
	mov	bx, word ptr [bp+4]	;@0BE81
	shl	bx, 1	;@0BE84
	add	bx, ax	;@0BE86
	mov	ax, word ptr es:[bx]	;@0BE88
	pop	bx	;@0BE8B
	pop	es	;@0BE8C
	pop	bp	;@0BE8D
	ret	2	;@0BE8E
; FATAL, ERROR, WARNING: report message number [sp+2] (with its arguments after it) as
; "Fatal:", "Error:" or "Warning:"; an error sets the exit code to 1, and a fatal error
; ends the link.
FATAL:	mov	ax, 4	;@0BE91
	jmp	short REPORT	;@0BE94
ERROR:	mov	ax, 1	;@0BE96
	jmp	short REPORT	;@0BE99
WARNING:	mov	ax, 0	;@0BE9B
	jmp	short REPORT	;@0BE9E
; REPORT: the common part of FATAL, ERROR and WARNING (AX: 4, 1 or 0).
REPORT:	pop	dx	;@0BEA0
	push	bp	;@0BEA1
	mov	bp, sp	;@0BEA2
	sub	sp, 0Ch	;@0BEA4
	push	ds	;@0BEA7
	push	bx	;@0BEA8
	push	si	;@0BEA9
	push	di	;@0BEAA
	mov	word ptr [bp-6], ax	;@0BEAB
	mov	word ptr [bp-8], dx	;@0BEAE
	call	CONSOLE_ON	;@0BEB1
	cmp	word ptr [bp-6], 1	;@0BEB4
	jne	@@1	;@0BEB8
	mov	byte ptr ds:[10h], 1	;@0BEBA
	call	PUT_INLINE	;@0BEBF
	db	7, 'Error: '	;@0BEC2
	jmp	short @@3	;@0BECA
@@1:	cmp	word ptr [bp-6], 0	;@0BECC
	jne	@@2	;@0BED0
	call	PUT_INLINE	;@0BED2
	db	9, 'Warning: '	;@0BED5
	jmp	short @@3	;@0BEDF
@@2:	call	PUT_INLINE	;@0BEE1
	db	7, 'Fatal: '	;@0BEE4
@@3:	mov	word ptr ds:[7641h], di	;@0BEEC
	mov	ax, word ptr [bp+2]	;@0BEF0
	push	ax	;@0BEF3
	call	MESSAGE_TEXT	;@0BEF4
	mov	word ptr [bp-0Ch], ax	;@0BEF7
	mov	word ptr [bp-0Ah], dx	;@0BEFA
	sub	sp, word ptr [bp+4]	;@0BEFD
	lea	si, [bp+6]	;@0BF00
	mov	di, sp	;@0BF03
	mov	ax, ss	;@0BF05
	mov	ds, ax	;@0BF07
	mov	es, ax	;@0BF09
	mov	cx, word ptr [bp+4]	;@0BF0B
	rep movsb	;@0BF0E
	mov	ds, word ptr cs:DATA_SEGMENT	;@0BF10
	push	word ptr [bp-0Ah]	;@0BF15
	push	word ptr [bp-0Ch]	;@0BF18
	push	ds	;@0BF1B
	mov	ax, 76C0h	;@0BF1C
	push	ax	;@0BF1F
	push	cs	;@0BF20
	call	FORMAT	;@0BF21
	push	ds	;@0BF24
	mov	ax, 76C0h	;@0BF25
	push	ax	;@0BF28
	call	PUT_FAR_STRING	;@0BF29
	cmp	word ptr ds:[422h], 1	;@0BF2C
	jne	@@4	;@0BF31
	mov	di, word ptr ds:[7641h]	;@0BF33
	call	PUT_INLINE	;@0BF37
	db	0Bh, ' in module '	;@0BF3A
	call	L090E6	;@0BF46
	mov	word ptr ds:[7641h], di	;@0BF49
@@4:	mov	di, word ptr ds:[7641h]	;@0BF4D
	call	L09104	;@0BF51
	mov	word ptr ds:[422h], 0FFFFh	;@0BF54
	cmp	word ptr [bp-6], 4	;@0BF5A
	jne	@@5	;@0BF5E
	call	L087D0	;@0BF60
@@5:	pop	di	;@0BF63
	pop	si	;@0BF64
	pop	bx	;@0BF65
	pop	ds	;@0BF66
	mov	dx, word ptr [bp-8]	;@0BF67
	mov	ax, word ptr [bp+4]	;@0BF6A
	add	ax, 6	;@0BF6D
	add	ax, bp	;@0BF70
	mov	sp, bp	;@0BF72
	pop	bp	;@0BF74
	mov	sp, ax	;@0BF75
	push	dx	;@0BF77
	ret	;@0BF78
	db	0, 0, 0, 0, 0, 0, 0, 0B8h, 2Fh, 0, 0CBh, 0, 0, 0, 0, 0, 0, 0, 0	;@0BF79
	db	0, 0, 0, 0
CODE0	ends
	end	start
