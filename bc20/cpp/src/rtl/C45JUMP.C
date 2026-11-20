/* target: C45JUMP */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module C45JUMP (image 0x1186D..0x118D7, frame 1186h; C45_LONGJUMP at
   1186:000D, C45_SETJUMP at 1186:0043): C45_LONGJUMP and
   C45_SETJUMP, the error-recovery jump of the driver (OPTIONS.C sets ERROR_JUMP_BUFFER
   with C45_SETJUMP; fatal errors long-jump back through C45_LONGJUMP).
   CPP.EXE edit: BCC.EXE has these two entry points inside its overlay manager
   (overlay/OVRMGR.ASM), where setjmp records the overlay stub of the caller and longjmp
   walks the stack to reload overlays. CPP.EXE is not overlaid and has a plain
   setjmp/longjmp pair instead, linked between RVECT and RLSEEK among the run-time
   library modules.
   Written the way Borland wrote its run-time setjmp/longjmp (.CAS style): C with inline
   assembly, compiled by Turbo C 2.01 through TASM. The evidence for C: longjmp tests and
   sets its argument with compiler code (cmp/jne/mov word ptr [bp+6]) and keeps the
   compiler's unreachable epilogue (pop di/pop si/pop bp/retf 6) after the inline retf;
   both functions have the compiler's push si/push di for inline code that uses SI and DI.
   The jump buffer is Turbo C's jmp_buf layout: j_sp 0, j_ss 2, j_flag 4, j_cs 6, j_ip 8,
   j_bp 0Ah, j_di 0Ch, j_es 0Eh, j_si 10h, j_ds 12h; only sp, cs, ip, bp, di and si are
   used here (the offsets are the ones in the code). */
#pragma inline

/* Restore the context saved by C45_SETJUMP; C45_SETJUMP then returns retval (1 if 0). */
void far pascal C45_LONGJUMP(void far *jmpb,int retval)
{
    if(retval==0)
        retval=1;
    _AX=retval;
    asm les si,jmpb
    asm mov bp,es:[si+0Ah]          /* j_bp */
    asm mov sp,es:[si]              /* j_sp */
    asm push word ptr es:[si+6]     /* j_cs */
    asm push word ptr es:[si+8]     /* j_ip */
    asm mov di,es:[si+0Ch]          /* j_di */
    asm mov si,es:[si+10h]          /* j_si */
    asm retf 4                      /* into the caller of C45_SETJUMP, past its argument */
}

/* Save the caller's context in jmpb and return 0. */
int far pascal C45_SETJUMP(void far *jmpb)
{
    asm mov ax,[bp+4]               /* caller's CS */
    asm mov bx,[bp+2]               /* caller's IP */
    asm push di
    asm les di,jmpb
    asm pop word ptr es:[di+0Ch]    /* j_di */
    asm mov es:[di+8],bx            /* j_ip */
    asm mov es:[di+6],ax            /* j_cs */
    asm lea ax,jmpb
    asm mov es:[di],ax              /* j_sp: the stack as the caller's retf leaves it */
    asm mov cx,[bp]
    asm mov es:[di+0Ah],cx          /* j_bp: the caller's BP */
    asm mov es:[di+10h],si          /* j_si */
    return 0;
}
