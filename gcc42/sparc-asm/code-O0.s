	.text
	.align	2
	.globl _sw
_sw:
	save	%sp, -112, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, 7
	bgu	L2
	 nop
	ld	[%fp+68], %g1
	sll	%g1, 2, %g2
	sethi	%hi(L11), %g1
	or	%g1, %lo(L11), %g1
	ld	[%g2+%g1], %g1
	jmp	%g1
	 nop
.const
	.text
L3:
	mov	11, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L4:
	mov	22, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L5:
	mov	33, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L6:
	mov	44, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L7:
	mov	55, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L8:
	mov	66, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L9:
	mov	77, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L10:
	mov	88, %g1
	st	%g1, [%fp-12]
	b	L12
	 nop
L2:
	st	%g0, [%fp-12]
L12:
	ld	[%fp-12], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
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
	save	%sp, -144, %sp
	std	%i0, [%fp-16]
	std	%i2, [%fp-24]
	st	%i4, [%fp+84]
	ld	[%fp+84], %g1
	and	%g1, 32, %g1
	cmp	%g1, 0
	be	L15
	 nop
	ld	[%fp-12], %g2
	ld	[%fp+84], %g1
	sll	%g2, %g1, %g2
	st	%g2, [%fp-48]
	mov	0, %g1
	st	%g1, [%fp-44]
	b	L16
	 nop
L15:
	ld	[%fp-12], %g1
	srl	%g1, 1, %g2
	ld	[%fp+84], %g1
	xor	%g1, -1, %g1
	srl	%g2, %g1, %g3
	ld	[%fp-16], %g2
	ld	[%fp+84], %g1
	sll	%g2, %g1, %g2
	st	%g2, [%fp-48]
	ld	[%fp-48], %o2
	or	%g3, %o2, %o2
	st	%o2, [%fp-48]
	ld	[%fp-12], %g2
	ld	[%fp+84], %g1
	sll	%g2, %g1, %g2
	st	%g2, [%fp-44]
L16:
	ld	[%fp-16], %g2
	ld	[%fp-20], %g1
	smul	%g2, %g1, %g4
	ld	[%fp-24], %g2
	ld	[%fp-12], %g1
	smul	%g2, %g1, %g1
	add	%g4, %g1, %g4
	ld	[%fp-12], %g2
	ld	[%fp-20], %g1
	umul	%g2, %g1, %g3
	rd	%y, %g2
	add	%g4, %g2, %g4
	mov	%g4, %g2
	ldd	[%fp-48], %o4
	addcc	%o5, %g3, %l1
	addx	%o4, %g2, %l0
	ldd	[%fp-16], %o0
	ldd	[%fp-24], %o2
	call	___divdi3, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	subcc	%l1, %g3, %l1
	subx	%l0, %g2, %l0
	ldd	[%fp-16], %g2
	mov	%g2, %o0
	mov	%g3, %o1
	ldd	[%fp-24], %o2
	call	___moddi3, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	addcc	%l1, %g3, %l1
	addx	%l0, %g2, %l0
	std	%l0, [%fp-40]
	ld	[%fp+84], %g1
	and	%g1, 32, %g1
	cmp	%g1, 0
	be	L17
	 nop
	ld	[%fp-16], %g1
	ld	[%fp+84], %g2
	sra	%g1, %g2, %g1
	st	%g1, [%fp-28]
	ld	[%fp-16], %g1
	sra	%g1, 31, %g1
	st	%g1, [%fp-32]
	b	L18
	 nop
L17:
	ld	[%fp-16], %g1
	sll	%g1, 1, %g2
	ld	[%fp+84], %g1
	xor	%g1, -1, %g1
	sll	%g2, %g1, %g3
	ld	[%fp-12], %g2
	ld	[%fp+84], %g1
	srl	%g2, %g1, %g2
	st	%g2, [%fp-28]
	ld	[%fp-28], %o5
	or	%g3, %o5, %o5
	st	%o5, [%fp-28]
	ld	[%fp-16], %g2
	ld	[%fp+84], %g1
	sra	%g2, %g1, %g2
	st	%g2, [%fp-32]
L18:
	ldd	[%fp-40], %o2
	ldd	[%fp-32], %o4
	addcc	%o3, %o5, %g3
	addx	%o2, %o4, %g2
	mov	%g2, %i0
	mov	%g3, %i1
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _ull
_ull:
	save	%sp, -120, %sp
	std	%i0, [%fp-16]
	std	%i2, [%fp-24]
	ldd	[%fp-16], %o0
	ldd	[%fp-24], %o2
	call	___udivdi3, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	mov	%g2, %l0
	mov	%g3, %l1
	ldd	[%fp-16], %g2
	mov	%g2, %o0
	mov	%g3, %o1
	ldd	[%fp-24], %o2
	call	___umoddi3, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	addcc	%l1, %g3, %g3
	addx	%l0, %g2, %g2
	mov	%g2, %i0
	mov	%g3, %i1
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _fp
_fp:
	save	%sp, -120, %sp
	std	%i0, [%fp-16]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	ld	[%fp+76], %f8
	fstod	%f8, %f10
	ldd	[%fp-16], %f8
	fmuld	%f10, %f8, %f10
	ld	[%fp+80], %f8
	fitod	%f8, %f8
	faddd	%f10, %f8, %f12
	ld	[%fp+76], %f8
	fstod	%f8, %f10
	ldd	[%fp-16], %f8
	fdivd	%f8, %f10, %f8
	fsubd	%f12, %f8, %f12
	std	%f12, [%fp-24]
	ldd	[%fp-16], %o0
	call	___fixdfdi, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	mov	%g2, %o0
	mov	%g3, %o1
	call	___floatdidf, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	ldd	[%fp-24], %f10
	faddd	%f10, %f8, %f8
	fmovs	%f8, %f0
	fmovs	%f9, %f1
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _fp2
_fp2:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %f9
	ld	[%fp+72], %f8
	fmuls	%f9, %f8, %f10
	ld	[%fp+68], %f9
	ld	[%fp+72], %f8
	fdivs	%f9, %f8, %f8
	fadds	%f10, %f8, %f8
	fmovs	%f8, %f0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _cmp
_cmp:
	save	%sp, -128, %sp
	std	%i0, [%fp-16]
	std	%i2, [%fp-24]
	ldd	[%fp-16], %f10
	ldd	[%fp-24], %f8
	fcmped	%f10, %f8
	nop
	fbl	L29
	 nop
	b	L27
	 nop
L29:
	mov	1, %g1
	st	%g1, [%fp-32]
	b	L30
	 nop
L27:
	ldd	[%fp-16], %f10
	ldd	[%fp-24], %f8
	fcmpd	%f10, %f8
	nop
	fbe	L33
	 nop
	b	L31
	 nop
L33:
	mov	2, %g1
	st	%g1, [%fp-28]
	b	L34
	 nop
L31:
	mov	3, %g1
	st	%g1, [%fp-28]
L34:
	ld	[%fp-28], %g1
	st	%g1, [%fp-32]
L30:
	ld	[%fp-32], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _vsum
_vsum:
	save	%sp, -112, %sp
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
	st	%i5, [%fp+88]
	st	%i0, [%fp+68]
	st	%g0, [%fp-12]
	add	%fp, 72, %g1
	st	%g1, [%fp-16]
	b	L37
	 nop
L38:
	ld	[%fp-16], %g3
	mov	%g3, %g1
	ld	[%g1], %g2
	ld	[%fp-12], %g1
	add	%g1, %g2, %g1
	st	%g1, [%fp-12]
	add	%g3, 4, %g1
	st	%g1, [%fp-16]
L37:
	ld	[%fp+68], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, -1
	bne	L38
	 nop
	ld	[%fp-12], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.globl _fptr
	.data
	.align	2
_fptr:
	.long	_ext
	.text
	.align	2
	.globl _callptr
_callptr:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %g1
	ld	[%fp+72], %o0
	call	%g1, 0
	 nop
	mov	%o0, %l0
	sethi	%hi(_fptr), %g1
	or	%g1, %lo(_fptr), %g1
	ld	[%g1], %g1
	ld	[%fp+72], %o0
	call	%g1, 0
	 nop
	mov	%o0, %g1
	add	%l0, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _al
_al:
	save	%sp, -120, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	add	%g1, 7, %g1
	srl	%g1, 3, %g1
	sll	%g1, 3, %g1
	add	%g1, 7, %g1
	srl	%g1, 3, %g1
	sll	%g1, 3, %g1
	sub	%sp, %g1, %sp
	add	%sp, 92, %g1
	st	%g1, [%fp-20]
	ld	[%fp-20], %g2
	add	%g2, 7, %g1
	srl	%g1, 3, %g1
	sll	%g1, 3, %g1
	st	%g1, [%fp-20]
	ld	[%fp-20], %g1
	st	%g1, [%fp-12]
	ld	[%fp-12], %g2
	mov	1, %g1
	stb	%g1, [%g2]
	ld	[%fp-12], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	call	_ext, 0
	 nop
	mov	%o0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _mixed
_mixed:
	save	%sp, -120, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp-16]
	st	%i2, [%fp-12]
	st	%i3, [%fp+80]
	std	%i4, [%fp-24]
	ld	[%fp+68], %g2
	ld	[%fp+80], %g1
	add	%g2, %g1, %g2
	ld	[%fp+92], %g1
	add	%g2, %g1, %g2
	ld	[%fp+96], %g1
	add	%g2, %g1, %g2
	ld	[%fp+100], %g1
	add	%g2, %g1, %g2
	ld	[%fp+104], %g1
	add	%g2, %g1, %l0
	ldd	[%fp-16], %f10
	ldd	[%fp-24], %f8
	faddd	%f10, %f8, %f8
	std	%f8, [%fp-8]
	ldd	[%fp-8], %o0
	call	_ext2, 0
	 nop
	mov	%o0, %g1
	add	%l0, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _retbig
_retbig:
	save	%sp, -184, %sp
	ld	[%fp+64], %l0
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	st	%g1, [%fp-88]
	mov	%l0, %g1
	add	%fp, -88, %g2
	mov	80, %g3
	mov	%g1, %o0
	mov	%g2, %o1
	mov	%g3, %o2
	call	_memcpy, 0
	 nop
	mov	%l0, %i0
	restore
	jmp	%o7+12
	 nop
	.align	2
	.globl _usebig
_usebig:
	save	%sp, -184, %sp
	add	%fp, -88, %g1
	st	%g1, [%sp+64]
	mov	3, %o0
	call	_retbig, 0
	 nop
	unimp	80
	ld	[%fp-88], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _ctor
_ctor:
	save	%sp, -104, %sp
	mov	1, %o0
	call	_ext, 0
	 nop
	restore
	jmp	%o7+8
	 nop
.constructor
	.align	2
	.long	_ctor
.reference .constructors_used
	.text
	.align	2
	.globl _dtor
_dtor:
	save	%sp, -104, %sp
	mov	2, %o0
	call	_ext, 0
	 nop
	restore
	jmp	%o7+8
	 nop
.destructor
	.align	2
	.long	_dtor
.reference .destructors_used
	.text
	.align	2
	.globl _weakfn
_weakfn:
	save	%sp, -104, %sp
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _weakref_user
_weakref_user:
	save	%sp, -104, %sp
	call	_weakfn, 0
	 nop
	mov	%o0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _usesq
_usesq:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %o0
	call	_sq, 0
	 nop
	mov	%o0, %l0
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	mov	%g1, %o0
	call	_sq, 0
	 nop
	mov	%o0, %g1
	add	%l0, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
_sq:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g2
	ld	[%fp+68], %g1
	smul	%g2, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl _volatile_rw
_volatile_rw:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g2
	mov	1, %g1
	st	%g1, [%g2]
	ld	[%fp+68], %g1
	ld	[%g1], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
