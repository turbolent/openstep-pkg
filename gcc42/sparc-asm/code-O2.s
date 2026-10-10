	.text
	.align	2
	.globl _sw
_sw:
	cmp	%o0, 7
	bgu	L12
	 mov	0, %g1
	sll	%o0, 2, %g1
	sethi	%hi(L11), %g2
	or	%g2, %lo(L11), %g2
	ld	[%g2+%g1], %g3
	jmp	%g3
	 nop
.const
	.text
L3:
	mov	11, %g1
L12:
	jmp	%o7+8
	 mov	%g1, %o0
L10:
	mov	88, %g1
	jmp	%o7+8
	 mov	%g1, %o0
L4:
	mov	22, %g1
	jmp	%o7+8
	 mov	%g1, %o0
L5:
	mov	33, %g1
	jmp	%o7+8
	 mov	%g1, %o0
L6:
	mov	44, %g1
	jmp	%o7+8
	 mov	%g1, %o0
L7:
	mov	55, %g1
	jmp	%o7+8
	 mov	%g1, %o0
L8:
	mov	66, %g1
	jmp	%o7+8
	 mov	%g1, %o0
L9:
	mov	77, %g1
	jmp	%o7+8
	 mov	%g1, %o0
	.align	2
L11:
	.long	L3
	.long	L4
	.long	L5
	.long	L6
	.long	L7
	.long	L8
	.long	L9
	.long	L10
	.align	2
	.globl _ll
_ll:
	save	%sp, -104, %sp
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	call	___moddi3, 0
	 mov	%i3, %o3
	umul	%i3, %i1, %g3
	rd	%y, %g2
	addcc	%o1, %g3, %o1
	smul	%i2, %i1, %g1
	smul	%i0, %i3, %g4
	mov	%i0, %l0
	add	%g1, %g4, %g1
	add	%g1, %g2, %g2
	addx	%o0, %g2, %o0
	andcc	%i4, 32, %g3
	be	L16
	 mov	%i1, %l1
	sll	%i1, %i4, %i0
	mov	0, %i1
L17:
	addcc	%o1, %i1, %o1
	sra	%l0, %i4, %i1
	addx	%o0, %i0, %o0
	cmp	%g3, 0
	bne	L19
	 sra	%l0, 31, %i0
	sll	%l0, 1, %g1
	xnor	%g0, %i4, %g2
	srl	%l1, %i4, %i1
	sll	%g1, %g2, %g1
	sra	%l0, %i4, %i0
	or	%g1, %i1, %i1
L19:
	addcc	%o1, %i1, %i1
	mov	%i2, %o2
	addx	%o0, %i0, %i0
	mov	%l1, %o1
	mov	%l0, %o0
	call	___divdi3, 0
	 mov	%i3, %o3
	subcc	%i1, %o1, %i1
	subx	%i0, %o0, %i0
	jmp	%i7+8
	 restore
L16:
	srl	%i1, 1, %g1
	xnor	%g0, %i4, %g2
	sll	%i0, %i4, %i0
	srl	%g1, %g2, %g1
	sll	%i1, %i4, %i1
	b	L17
	 or	%g1, %i0, %i0
	.align	2
	.globl _ull
_ull:
	save	%sp, -104, %sp
	mov	%i2, %o2
	mov	%i3, %o3
	mov	%i0, %o0
	call	___umoddi3, 0
	 mov	%i1, %o1
	mov	%i2, %o2
	mov	%o0, %l0
	mov	%o1, %l1
	mov	%i0, %o0
	mov	%i1, %o1
	call	___udivdi3, 0
	 mov	%i3, %o3
	addcc	%l1, %o1, %i1
	addx	%l0, %o0, %i0
	jmp	%i7+8
	 restore
	.align	2
	.globl _fp
_fp:
	save	%sp, -112, %sp
	std	%i0, [%fp-8]
	ldd	[%fp-8], %f10
	st	%i2, [%fp-8]
	ld	[%fp-8], %f12
	st	%i3, [%fp-8]
	ld	[%fp-8], %f14
	fstod	%f12, %f8
	fitod	%f14, %f12
	fdivd	%f10, %f8, %f14
	fmuld	%f8, %f10, %f8
	faddd	%f8, %f12, %f8
	fsubd	%f8, %f14, %f8
	std	%f10, [%fp-8]
	std	%f8, [%fp-16]
	mov	%i0, %o0
	call	___fixdfdi, 0
	 mov	%i1, %o1
	call	___floatdidf, 0
	 nop
	ldd	[%fp-16], %f8
	faddd	%f8, %f0, %f0
	jmp	%i7+8
	 restore
	.align	2
	.globl _fp2
_fp2:
	add	%sp, -112, %sp
	st	%o0, [%sp+100]
	ld	[%sp+100], %f0
	st	%o1, [%sp+100]
	ld	[%sp+100], %f8
	sub	%sp, -112, %sp
	fdivs	%f0, %f8, %f9
	fmuls	%f0, %f8, %f0
	jmp	%o7+8
	 fadds	%f0, %f9, %f0
	.align	2
	.globl _cmp
_cmp:
	add	%sp, -112, %sp
	std	%o0, [%sp+96]
	ldd	[%sp+96], %f10
	std	%o2, [%sp+96]
	ldd	[%sp+96], %f8
	fcmped	%f10, %f8
	nop
	fbl	L36
	 mov	1, %o0
	fcmpd	%f10, %f8
	nop
	fbe	L31
	 mov	2, %o0
	mov	3, %o0
L31:
	jmp	%o7+8
	 sub	%sp, -112, %sp
L36:
	jmp	%o7+8
	 sub	%sp, -112, %sp
	.align	2
	.globl _callptr
_callptr:
	save	%sp, -104, %sp
	call	%i0, 0
	 mov	%i1, %o0
	sethi	%hi(_fptr), %g1
	mov	%o0, %i0
	ld	[%g1+%lo(_fptr)], %g2
	call	%g2, 0
	 mov	%i1, %o0
	jmp	%i7+8
	 restore %o0, %i0, %o0
	.align	2
	.globl _retbig
_retbig:
	add	%sp, -184, %sp
	ld	[%sp+248], %g1
	sub	%sp, -184, %sp
	st	%o0, [%g1]
	jmp	%o7+12
	 mov	%g1, %o0
	.align	2
	.globl _usebig
_usebig:
	save	%sp, -184, %sp
	add	%fp, -88, %g1
	mov	3, %o0
	st	%g1, [%sp+64]
	call	_retbig, 0
	 nop
	unimp	80
	ld	[%fp-88], %i0
	jmp	%i7+8
	 restore
	.align	2
	.globl _weakfn
_weakfn:
	jmp	%o7+8
	 mov	1, %o0
	.align	2
	.globl _weakref_user
_weakref_user:
	or	%o7, %g0, %g1
	call	_weakfn, 0
	 or	%g1, %g0, %o7
	nop
	.align	2
	.globl _volatile_rw
_volatile_rw:
	mov	1, %g1
	st	%g1, [%o0]
	ld	[%o0], %o0
	jmp	%o7+8
	 nop
	.align	2
	.globl _dtor
_dtor:
	save	%sp, -104, %sp
	call	_ext, 0
	 mov	2, %o0
	jmp	%i7+8
	 restore
.destructor
	.align	2
	.long	_dtor
.reference .destructors_used
	.text
	.align	2
	.globl _ctor
_ctor:
	save	%sp, -104, %sp
	call	_ext, 0
	 mov	1, %o0
	jmp	%i7+8
	 restore
.constructor
	.align	2
	.long	_ctor
.reference .constructors_used
	.text
	.align	2
	.globl _mixed
_mixed:
	save	%sp, -112, %sp
	st	%i1, [%fp-16]
	st	%i2, [%fp-12]
	ldd	[%fp-16], %f8
	std	%i4, [%fp-16]
	ldd	[%fp-16], %f10
	faddd	%f8, %f10, %f10
	std	%f10, [%fp-16]
	call	_ext2, 0
	 ldd	[%fp-16], %o0
	ld	[%fp+92], %g1
	ld	[%fp+96], %g2
	add	%i3, %i0, %i3
	add	%i3, %g1, %i3
	ld	[%fp+100], %g1
	add	%i3, %g2, %i3
	ld	[%fp+104], %g2
	add	%i3, %g1, %i3
	add	%i3, %g2, %i3
	jmp	%i7+8
	 restore %i3, %o0, %o0
	.align	2
	.globl _al
_al:
	save	%sp, -104, %sp
	mov	1, %g1
	add	%i0, 7, %i0
	and	%i0, -8, %i0
	mov	1, %o0
	sub	%sp, %i0, %sp
	call	_ext, 0
	 stb	%g1, [%sp+96]
	jmp	%i7+8
	 restore %g0, %o0, %o0
	.align	2
	.globl _vsum
_vsum:
	add	%sp, -112, %sp
	st	%o5, [%sp+200]
	st	%o1, [%sp+184]
	add	%sp, 184, %o5
	st	%o2, [%sp+188]
	st	%o3, [%sp+192]
	st	%o4, [%sp+196]
	st	%o5, [%sp+100]
	orcc	%o0, 0, %g4
	be	L60
	 mov	0, %o0
	mov	%o5, %g3
	mov	0, %g2
L61:
	ld	[%g3], %g1
	add	%g2, 1, %g2
	add	%o0, %g1, %o0
	cmp	%g2, %g4
	bne	L61
	 add	%g3, 4, %g3
	sll	%g2, 2, %g1
	add	%g1, %o5, %g1
	st	%g1, [%sp+100]
L60:
	jmp	%o7+8
	 sub	%sp, -112, %sp
	.align	2
	.globl _usesq
_usesq:
	smul	%o0, %o0, %g1
	add	%o0, 1, %o0
	smul	%o0, %o0, %o0
	jmp	%o7+8
	 add	%o0, %g1, %o0
	.globl _fptr
	.data
	.align	2
_fptr:
	.long	_ext
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
