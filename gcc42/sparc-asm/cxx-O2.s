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
	jmp	%o7+8
	 mov	1, %o0
	.align	2
__ZN1B1fEv:
	jmp	%o7+8
	 mov	2, %o0
	.align	2
__Z5twiceIiET_S0_:
	jmp	%o7+8
	 add	%o0, %o0, %o0
	.align	2
__Z5twiceIdET_S0_:
	add	%sp, -112, %sp
	std	%o0, [%sp+96]
	ldd	[%sp+96], %f8
	sub	%sp, -112, %sp
	fmovs	%f8, %f10
	fmovs	%f9, %f11
	jmp	%o7+8
	 faddd	%f8, %f10, %f0
	.align	2
__ZN1BD0Ev:
	sethi	%hi(__ZTV1B+8), %g1
	or	%g1, %lo(__ZTV1B+8), %g1
	st	%g1, [%o0]
	or	%o7, %g0, %g1
	call	__ZdlPv, 0
	 or	%g1, %g0, %o7
	nop
	.align	2
__ZN1BD1Ev:
	sethi	%hi(__ZTV1B+8), %g1
	or	%g1, %lo(__ZTV1B+8), %g1
	jmp	%o7+8
	 st	%g1, [%o0]
	.align	2
__ZN1AD0Ev:
	sethi	%hi(__ZTV1A+8), %g1
	or	%g1, %lo(__ZTV1A+8), %g1
	st	%g1, [%o0]
	or	%o7, %g0, %g1
	call	__ZdlPv, 0
	 or	%g1, %g0, %o7
	nop
	.align	2
__ZN1AD1Ev:
	sethi	%hi(__ZTV1A+8), %g1
	or	%g1, %lo(__ZTV1A+8), %g1
	jmp	%o7+8
	 st	%g1, [%o0]
.literal8
	.align	3
LC0:
	.long	1074003968
	.long	0
	.text
	.align	2
	.globl __Z1gP1A
__Z1gP1A:
	save	%sp, -168, %sp
	sethi	%hi(___gxx_personality_sj0), %g1
	or	%g1, %lo(___gxx_personality_sj0), %g1
	add	%fp, -8, %g3
	st	%g1, [%fp-36]
	st	%i0, [%fp+68]
	st	%sp, [%fp-20]
	sethi	%hi(LLSDA9), %g2
	st	%g3, [%fp-28]
	or	%g2, %lo(LLSDA9), %g2
	sethi	%hi(L28), %g1
	st	%g2, [%fp-32]
	or	%g1, %lo(L28), %g1
	st	%g1, [%fp-24]
	call	__Unwind_SjLj_Register, 0
	 add	%fp, -60, %o0
	ld	[%fp+68], %g1
	cmp	%g1, 0
	be	L30
	 ld	[%fp+68], %o0
	mov	1, %g2
	ld	[%o0], %g1
	ld	[%g1+8], %g3
	call	%g3, 0
	 st	%g2, [%fp-56]
	st	%o0, [%fp-72]
	call	__Z5twiceIiET_S0_, 0
	 mov	3, %o0
	sethi	%hi(LC0), %g1
	st	%o0, [%fp-68]
	call	__Z5twiceIdET_S0_, 0
	 ldd	[%g1+%lo(LC0)], %o0
	ld	[%fp-68], %g2
	fdtoi	%f0, %f0
	st	%f0, [%fp-8]
	ld	[%fp-8], %g1
	add	%g1, %g2, %g1
	ld	[%fp-72], %g2
	add	%g1, %g2, %g1
	st	%g1, [%fp-64]
L24:
L21:
	call	__Unwind_SjLj_Unregister, 0
	 add	%fp, -60, %o0
	ld	[%fp-64], %i0
	jmp	%i7+8
	 restore
L30:
	call	___cxa_allocate_exception, 0
	 mov	4, %o0
	mov	7, %g1
	st	%g1, [%o0]
	sethi	%hi(__ZTIi), %o1
	mov	1, %g1
	or	%o1, %lo(__ZTIi), %o1
	st	%g1, [%fp-56]
	call	___cxa_throw, 0
	 mov	0, %o2
L28:
	ld	[%fp-48], %g1
	cmp	%g1, 1
	be	L25
	 ld	[%fp-52], %o0
	mov	-1, %g1
	call	__Unwind_SjLj_Resume, 0
	 st	%g1, [%fp-56]
L25:
	call	___cxa_begin_catch, 0
	 nop
	ld	[%o0], %o0
	call	___cxa_end_catch, 0
	 st	%o0, [%fp-64]
	b,a	L24
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
	.align	2
__Z3inli:
	save	%sp, -104, %sp
	orcc	%i0, 0, %o0
	be	L64
	 mov	0, %i0
	cmp	%o0, 1
	bne	L59
	 mov	1, %i0
L64:
	jmp	%i7+8
	 restore
L59:
	cmp	%o0, 2
	be	L39
	 cmp	%o0, 3
	be	L42
	 mov	1, %g1
	cmp	%o0, 4
	be,a	L42
	 add	%g1, 1, %g1
	cmp	%o0, 5
	be,a	L61
	 add	%g1, 1, %g1
	cmp	%o0, 6
	be,a	L62
	 add	%g1, 1, %g1
	cmp	%o0, 7
	be,a	L63
	 add	%g1, 1, %g1
	cmp	%o0, 8
	bne	L60
	 nop
	add	%g1, 1, %g1
L54:
	add	%g1, 1, %g1
L63:
	add	%g1, 1, %g1
L62:
	add	%g1, 1, %g1
L61:
	add	%g1, 1, %g1
L42:
	add	%g1, 1, %i0
L39:
	jmp	%i7+8
	 restore %i0, 1, %o0
L60:
	call	__Z3inli, 0
	 add	%o0, -9, %o0
	add	%o0, 2, %g1
	b	L54
	 add	%g1, 1, %g1
	.align	2
	.globl __Z1hv
__Z1hv:
	save	%sp, -104, %sp
	call	__Z3inli, 0
	 mov	2, %o0
	jmp	%i7+8
	 restore %o0, 3, %o0
	.align	2
__Z41__static_initialization_and_destruction_0ii:
	cmp	%o0, 1
	be	L75
	 cmp	%o0, 0
	bne	L76
	 sethi	%hi(64512), %g1
	or	%g1, 1023, %g1
	cmp	%o1, %g1
	bne	L76
	 sethi	%hi(__ZTV1B+8), %g1
	sethi	%hi(__ZL8global_b), %g2
	or	%g1, %lo(__ZTV1B+8), %g1
	st	%g1, [%g2+%lo(__ZL8global_b)]
L76:
	jmp	%o7+8
	 nop
L75:
	sethi	%hi(64512), %g1
	or	%g1, 1023, %g1
	cmp	%o1, %g1
	bne	L76
	 sethi	%hi(__ZTV1B+8), %g1
	sethi	%hi(__ZL8global_b), %g2
	or	%g1, %lo(__ZTV1B+8), %g1
	jmp	%o7+8
	 st	%g1, [%g2+%lo(__ZL8global_b)]
	.align	2
__GLOBAL__D__Z1gP1A:
	save	%sp, -104, %sp
	sethi	%hi(64512), %o1
	mov	0, %o0
	call	__Z41__static_initialization_and_destruction_0ii, 0
	 or	%o1, 1023, %o1
	jmp	%i7+8
	 restore
	.align	2
__GLOBAL__I__Z1gP1A:
	save	%sp, -104, %sp
	sethi	%hi(64512), %o1
	mov	1, %o0
	call	__Z41__static_initialization_and_destruction_0ii, 0
	 or	%o1, 1023, %o1
	jmp	%i7+8
	 restore
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
