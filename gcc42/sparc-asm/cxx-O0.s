.constructor
	.align	2
	.long	__GLOBAL__I__Z1gP1A
.reference .constructors_used
.destructor
	.align	2
	.long	__GLOBAL__D__Z1gP1A
.reference .destructors_used
	.text
	.align	2
__ZN1A1fEv:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1B1fEv:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	mov	2, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
__Z3inli:
	save	%sp, -112, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, 0
	be	L6
	 nop
	ld	[%fp+68], %g1
	add	%g1, -1, %g1
	mov	%g1, %o0
	call	__Z3inli, 0
	 nop
	mov	%o0, %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	b	L8
	 nop
L6:
	st	%g0, [%fp-12]
L8:
	ld	[%fp-12], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
	.globl __Z1hv
__Z1hv:
	save	%sp, -104, %sp
	mov	3, %o0
	call	__Z3inli, 0
	 nop
	mov	%o0, %l0
	sethi	%hi(__ZL8global_b), %g1
	or	%g1, %lo(__ZL8global_b), %o0
	call	__ZN1B1fEv, 0
	 nop
	mov	%o0, %g1
	add	%l0, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
__Z5twiceIiET_S0_:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g2
	ld	[%fp+68], %g1
	add	%g2, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
__Z5twiceIdET_S0_:
	save	%sp, -112, %sp
	std	%i0, [%fp-16]
	ldd	[%fp-16], %f8
	faddd	%f8, %f8, %f8
	fmovs	%f8, %f0
	fmovs	%f9, %f1
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1AC2Ev:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	sethi	%hi(__ZTV1A+8), %g1
	or	%g1, %lo(__ZTV1A+8), %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1BC1Ev:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	mov	%g1, %o0
	call	__ZN1AC2Ev, 0
	 nop
	sethi	%hi(__ZTV1B+8), %g1
	or	%g1, %lo(__ZTV1B+8), %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1BD0Ev:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	sethi	%hi(__ZTV1B+8), %g1
	or	%g1, %lo(__ZTV1B+8), %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
	mov	1, %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	be	L24
	 nop
	ld	[%fp+68], %o0
	call	__ZdlPv, 0
	 nop
L24:
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1AD0Ev:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	sethi	%hi(__ZTV1A+8), %g1
	or	%g1, %lo(__ZTV1A+8), %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
	mov	1, %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	be	L29
	 nop
	ld	[%fp+68], %o0
	call	__ZdlPv, 0
	 nop
L29:
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1AD1Ev:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	sethi	%hi(__ZTV1A+8), %g1
	or	%g1, %lo(__ZTV1A+8), %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
	mov	0, %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	be	L34
	 nop
	ld	[%fp+68], %o0
	call	__ZdlPv, 0
	 nop
L34:
	restore
	jmp	%o7+8
	 nop
	.align	2
__ZN1BD1Ev:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	sethi	%hi(__ZTV1B+8), %g1
	or	%g1, %lo(__ZTV1B+8), %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
	mov	0, %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	be	L39
	 nop
	ld	[%fp+68], %o0
	call	__ZdlPv, 0
	 nop
L39:
	restore
	jmp	%o7+8
	 nop
	.align	2
__Z41__static_initialization_and_destruction_0ii:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %g1
	cmp	%g1, 1
	bne	L41
	 nop
	ld	[%fp+72], %g1
	sethi	%hi(64512), %g2
	or	%g2, 1023, %g2
	cmp	%g1, %g2
	bne	L41
	 nop
	sethi	%hi(__ZL8global_b), %g1
	or	%g1, %lo(__ZL8global_b), %o0
	call	__ZN1BC1Ev, 0
	 nop
L41:
	ld	[%fp+68], %g1
	cmp	%g1, 0
	bne	L47
	 nop
	ld	[%fp+72], %g1
	sethi	%hi(64512), %g2
	or	%g2, 1023, %g2
	cmp	%g1, %g2
	bne	L47
	 nop
	sethi	%hi(__ZL8global_b), %g1
	or	%g1, %lo(__ZL8global_b), %o0
	call	__ZN1BD1Ev, 0
	 nop
L47:
	restore
	jmp	%o7+8
	 nop
	.align	2
__GLOBAL__D__Z1gP1A:
	save	%sp, -104, %sp
	mov	0, %o0
	sethi	%hi(64512), %g1
	or	%g1, 1023, %o1
	call	__Z41__static_initialization_and_destruction_0ii, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.align	2
__GLOBAL__I__Z1gP1A:
	save	%sp, -104, %sp
	mov	1, %o0
	sethi	%hi(64512), %g1
	or	%g1, 1023, %o1
	call	__Z41__static_initialization_and_destruction_0ii, 0
	 nop
	restore
	jmp	%o7+8
	 nop
.literal8
	.align	3
LC0:
	.long	1074003968
	.long	0
	.text
	.align	2
	.globl __Z1gP1A
__Z1gP1A:
	save	%sp, -184, %sp
	st	%i0, [%fp+68]
	sethi	%hi(___gxx_personality_sj0), %g1
	or	%g1, %lo(___gxx_personality_sj0), %g1
	st	%g1, [%fp-44]
	sethi	%hi(LLSDA9), %g1
	or	%g1, %lo(LLSDA9), %g1
	st	%g1, [%fp-40]
	add	%fp, -36, %g2
	add	%fp, -8, %g1
	st	%g1, [%g2]
	sethi	%hi(L59), %g1
	or	%g1, %lo(L59), %g1
	st	%g1, [%g2+4]
	st	%sp, [%g2+8]
	add	%fp, -68, %g1
	mov	%g1, %o0
	call	__Unwind_SjLj_Register, 0
	 nop
	ld	[%fp+68], %g1
	cmp	%g1, 0
	bne	L53
	 nop
	mov	4, %o0
	call	___cxa_allocate_exception, 0
	 nop
	mov	%o0, %g1
	mov	%g1, %g3
	mov	%g3, %g2
	mov	7, %g1
	st	%g1, [%g2]
	sethi	%hi(__ZTIi), %g1
	or	%g1, %lo(__ZTIi), %g2
	mov	1, %g1
	st	%g1, [%fp-64]
	mov	%g3, %o0
	mov	%g2, %o1
	mov	0, %o2
	call	___cxa_throw, 0
	 nop
L53:
	ld	[%fp+68], %g1
	ld	[%g1], %g1
	add	%g1, 8, %g1
	ld	[%g1], %g2
	mov	1, %g1
	st	%g1, [%fp-64]
	ld	[%fp+68], %o0
	call	%g2, 0
	 nop
	st	%o0, [%fp-76]
	mov	3, %o0
	call	__Z5twiceIiET_S0_, 0
	 nop
	mov	%o0, %g1
	ld	[%fp-76], %g2
	add	%g2, %g1, %g1
	st	%g1, [%fp-72]
	sethi	%hi(LC0), %g1
	or	%g1, %lo(LC0), %g1
	ldd	[%g1], %f8
	std	%f8, [%fp-8]
	ldd	[%fp-8], %o0
	call	__Z5twiceIdET_S0_, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	fdtoi	%f8, %f8
	st	%f8, [%fp-8]
	ld	[%fp-8], %g1
	ld	[%fp-72], %g2
	add	%g2, %g1, %g1
	st	%g1, [%fp-80]
	b	L55
	 nop
L59:
	ld	[%fp-60], %g1
	st	%g1, [%fp-88]
	ld	[%fp-56], %g1
	cmp	%g1, 1
	be	L56
	 nop
	mov	-1, %g1
	st	%g1, [%fp-64]
	ld	[%fp-88], %o0
	call	__Unwind_SjLj_Resume, 0
	 nop
L56:
	ld	[%fp-88], %o0
	call	___cxa_begin_catch, 0
	 nop
	mov	%o0, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-12]
	ld	[%fp-12], %g2
	st	%g2, [%fp-80]
	call	___cxa_end_catch, 0
	 nop
L55:
	ld	[%fp-80], %g1
	st	%g1, [%fp-84]
L52:
	add	%fp, -68, %g1
	mov	%g1, %o0
	call	__Unwind_SjLj_Unregister, 0
	 nop
	ld	[%fp-84], %i0
	restore
	jmp	%o7+8
	 nop
.section __TEXT,__gcc_except_tab,regular
	.align	2
LLSDA9:
	.byte	0xff
	.byte	0x0
	.byte	0xd
	.byte	0x3
	.byte	0x2
	.byte	0x0
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.align	2
	.long	__ZTIi
	.text
.lcomm __ZL8global_b,8,2
.const
	.align	3
__ZTV1B:
	.long	0
	.long	__ZTI1B
	.long	__ZN1BD1Ev
	.long	__ZN1BD0Ev
	.long	__ZN1B1fEv
	.align	2
__ZTI1B:
	.long	__ZTVN10__cxxabiv120__si_class_type_infoE+8
	.long	__ZTS1B
	.long	__ZTI1A
	.align	3
__ZTS1B:
	.ascii "1B\0"
	.align	2
__ZTI1A:
	.long	__ZTVN10__cxxabiv117__class_type_infoE+8
	.long	__ZTS1A
	.align	3
__ZTS1A:
	.ascii "1A\0"
	.align	3
__ZTV1A:
	.long	0
	.long	__ZTI1A
	.long	__ZN1AD1Ev
	.long	__ZN1AD0Ev
	.long	__ZN1A1fEv
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
