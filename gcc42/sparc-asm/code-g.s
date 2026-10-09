	.stabs	"code.c",100,0,2,Ltext0
	.text
Ltext0:
	.stabs	"",102,0,0,0
	.stabs	"gcc2_compiled.",60,0,0,0
	.stabs	"int:t1=r1;-2147483648;2147483647;",128,0,0,0
	.stabs	"char:t2=r2;0;127;",128,0,0,0
	.stabs	"long int:t3=r3;-2147483648;2147483647;",128,0,0,0
	.stabs	"unsigned int:t4=r4;0;037777777777;",128,0,0,0
	.stabs	"long unsigned int:t5=r5;0;037777777777;",128,0,0,0
	.stabs	"long long int:t6=@s64;r6;01000000000000000000000;0777777777777777777777;",128,0,0,0
	.stabs	"long long unsigned int:t7=@s64;r7;0;01777777777777777777777;",128,0,0,0
	.stabs	"short int:t8=@s16;r8;-32768;32767;",128,0,0,0
	.stabs	"short unsigned int:t9=@s16;r9;0;65535;",128,0,0,0
	.stabs	"signed char:t10=@s8;r10;-128;127;",128,0,0,0
	.stabs	"unsigned char:t11=@s8;r11;0;255;",128,0,0,0
	.stabs	"float:t12=r1;4;0;",128,0,0,0
	.stabs	"double:t13=r1;8;0;",128,0,0,0
	.stabs	"long double:t14=r1;8;0;",128,0,0,0
	.stabs	"void:t15=15",128,0,0,0
	.stabs	"va_list:t16=17",128,0,2,0
	.stabs	"big:T18=s80a:19,0,640;;",128,0,0,0
	.align	2
	.globl _sw
_sw:
	.stabd	46,0,0
	.stabd	68,0,5
LFBB1:
	mov	%o0, %g1
	.stabd	68,0,6
	cmp	%g1, 7
	bgu	L14
	 mov	0, %o0
	sll	%g1, 2, %g1
	sethi	%hi(L11), %g2
	or	%g2, %lo(L11), %g2
	ld	[%g2+%g1], %g1
	jmp	%g1
	 nop
.const
	.text
L10:
	jmp	%o7+8
	 mov	88, %o0
L3:
	jmp	%o7+8
	 mov	11, %o0
L4:
	jmp	%o7+8
	 mov	22, %o0
L5:
	jmp	%o7+8
	 mov	33, %o0
L6:
	jmp	%o7+8
	 mov	44, %o0
L7:
	jmp	%o7+8
	 mov	55, %o0
L8:
	.stabd	68,0,7
	jmp	%o7+8
	 mov	66, %o0
L9:
	mov	77, %o0
L14:
	.stabd	68,0,8
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
	.stabs	"sw:F1",36,0,5,_sw
	.stabs	"x:P1",64,0,5,1
	.stabs	"__builtin_va_list:t17=*15",128,0,0,0
	.stabs	":t19=ar20=r20;0;037777777777;;0;19;1",128,0,0,0
Lscope1:
	.align	2
	.globl _ll
_ll:
	.stabd	46,0,0
	.stabd	68,0,9
LFBB2:
	save	%sp, -104, %sp
	mov	%i0, %l0
	mov	%i1, %l1
	.stabd	68,0,9
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	call	___moddi3, 0
	 mov	%i3, %o3
	smul	%i2, %i1, %g1
	smul	%i0, %i3, %g2
	add	%g1, %g2, %g1
	umul	%i3, %i1, %g3
	rd	%y, %g2
	add	%g1, %g2, %g2
	addcc	%o1, %g3, %o1
	addx	%o0, %g2, %o0
	sll	%i1, %i4, %i0
	andcc	%i4, 32, %g0
	bne	L17
	 mov	0, %i1
	srl	%l1, 1, %g1
	xnor	%g0, %i4, %g2
	srl	%g1, %g2, %g1
	sll	%l0, %i4, %i0
	or	%g1, %i0, %i0
	sll	%l1, %i4, %i1
L17:
	addcc	%o1, %i1, %o1
	addx	%o0, %i0, %o0
	sra	%l0, %i4, %i1
	andcc	%i4, 32, %g0
	bne	L19
	 sra	%l0, 31, %i0
	sll	%l0, 1, %g1
	xnor	%g0, %i4, %g2
	sll	%g1, %g2, %g1
	srl	%l1, %i4, %i1
	or	%g1, %i1, %i1
	sra	%l0, %i4, %i0
L19:
	addcc	%o1, %i1, %i1
	addx	%o0, %i0, %i0
	mov	%l0, %o0
	mov	%l1, %o1
	mov	%i2, %o2
	call	___divdi3, 0
	 mov	%i3, %o3
	subcc	%i1, %o1, %i1
	subx	%i0, %o0, %i0
	jmp	%i7+8
	 restore
	.stabs	"ll:F6",36,0,9,_ll
	.stabs	"a:P6",64,0,9,16
	.stabs	"b:P6",64,0,9,26
	.stabs	"s:P1",64,0,9,28
Lscope2:
	.align	2
	.globl _ull
_ull:
	.stabd	46,0,0
	.stabd	68,0,10
LFBB3:
	save	%sp, -104, %sp
	.stabd	68,0,10
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	call	___umoddi3, 0
	 mov	%i3, %o3
	mov	%o0, %l0
	mov	%o1, %l1
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	call	___udivdi3, 0
	 mov	%i3, %o3
	addcc	%l1, %o1, %i1
	addx	%l0, %o0, %i0
	jmp	%i7+8
	 restore
	.stabs	"ull:F7",36,0,10,_ull
	.stabs	"a:P7",64,0,10,24
	.stabs	"b:P7",64,0,10,26
Lscope3:
	.align	2
	.globl _fp
_fp:
	.stabd	46,0,0
	.stabd	68,0,11
LFBB4:
	save	%sp, -112, %sp
	std	%i0, [%fp-8]
	ldd	[%fp-8], %f12
	.stabd	68,0,11
	st	%i2, [%fp-8]
	ld	[%fp-8], %f10
	fstod	%f10, %f8
	fmuld	%f8, %f12, %f14
	st	%i3, [%fp-8]
	ld	[%fp-8], %f16
	fitod	%f16, %f10
	faddd	%f14, %f10, %f0
	fdivd	%f12, %f8, %f8
	fsubd	%f0, %f8, %f0
	std	%f0, [%fp-16]
	std	%f12, [%fp-8]
	mov	%i0, %o0
	call	___fixdfdi, 0
	 mov	%i1, %o1
	call	___floatdidf, 0
	 nop
	ldd	[%fp-16], %f8
	faddd	%f8, %f0, %f0
	jmp	%i7+8
	 restore
	.stabs	"fp:F13",36,0,11,_fp
	.stabs	"a:P13",64,0,11,44
	.stabs	"b:P12",64,0,11,26
	.stabs	"i:P1",64,0,11,27
Lscope4:
	.align	2
	.globl _fp2
_fp2:
	.stabd	46,0,0
	.stabd	68,0,12
LFBB5:
	add	%sp, -112, %sp
	st	%o0, [%sp+100]
	ld	[%sp+100], %f0
	st	%o1, [%sp+100]
	ld	[%sp+100], %f8
	.stabd	68,0,12
	fmuls	%f0, %f8, %f9
	fdivs	%f0, %f8, %f0
	fadds	%f9, %f0, %f0
	jmp	%o7+8
	 sub	%sp, -112, %sp
	.stabs	"fp2:F12",36,0,12,_fp2
	.stabs	"a:P12",64,0,12,32
	.stabs	"b:P12",64,0,12,40
Lscope5:
	.align	2
	.globl _cmp
_cmp:
	.stabd	46,0,0
	.stabd	68,0,13
LFBB6:
	add	%sp, -112, %sp
	std	%o0, [%sp+96]
	ldd	[%sp+96], %f10
	std	%o2, [%sp+96]
	ldd	[%sp+96], %f8
	.stabd	68,0,13
	fcmped	%f10, %f8
	nop
	fbuge	L28
	 nop
	b	L31
	 mov	1, %o0
L28:
	fcmpd	%f10, %f8
	nop
	fbe	L31
	 mov	2, %o0
	mov	3, %o0
L31:
	jmp	%o7+8
	 sub	%sp, -112, %sp
	.stabs	"cmp:F1",36,0,13,_cmp
	.stabs	"a:P13",64,0,13,42
	.stabs	"b:P13",64,0,13,40
Lscope6:
	.align	2
	.globl _callptr
_callptr:
	.stabd	46,0,0
	.stabd	68,0,17
LFBB7:
	save	%sp, -104, %sp
	.stabd	68,0,17
	call	%i0, 0
	 mov	%i1, %o0
	mov	%o0, %i0
	sethi	%hi(_fptr), %g1
	ld	[%g1+%lo(_fptr)], %g1
	call	%g1, 0
	 mov	%i1, %o0
	jmp	%i7+8
	 restore %o0, %i0, %o0
	.stabs	"callptr:F1",36,0,17,_callptr
	.stabs	"f:P21",64,0,17,24
	.stabs	"x:P1",64,0,17,25
	.stabs	":t21=*22",128,0,0,0
	.stabs	":t22=f1",128,0,0,0
Lscope7:
	.align	2
	.globl _retbig
_retbig:
	.stabd	46,0,0
	.stabd	68,0,21
LFBB8:
	add	%sp, -184, %sp
	ld	[%sp+248], %g1
	.stabd	68,0,21
	st	%o0, [%g1]
	mov	%g1, %o0
	jmp	%o7+12
	 sub	%sp, -184, %sp
	.stabs	"retbig:F18",36,0,21,_retbig
	.stabs	"x:P1",64,0,21,8
	.stabs	"b:18",128,0,21,96
	.stabn	192,0,0,LFBB8
	.stabn	224,0,0,Lscope8
Lscope8:
	.align	2
	.globl _usebig
_usebig:
	.stabd	46,0,0
	.stabd	68,0,22
LFBB9:
	save	%sp, -184, %sp
	.stabd	68,0,22
	add	%fp, -88, %g1
	st	%g1, [%sp+64]
	mov	3, %o0
	call	_retbig, 0
	 nop
	unimp	80
	ld	[%fp-88], %i0
	jmp	%i7+8
	 restore
	.stabs	"usebig:F1",36,0,22,_usebig
Lscope9:
	.align	2
	.globl _weakfn
_weakfn:
	.stabd	46,0,0
	.stabd	68,0,25
LFBB10:
	.stabd	68,0,25
	jmp	%o7+8
	 mov	1, %o0
	.stabs	"weakfn:F1",36,0,25,_weakfn
Lscope10:
	.align	2
	.globl _weakref_user
_weakref_user:
	.stabd	46,0,0
	.stabd	68,0,26
LFBB11:
	save	%sp, -104, %sp
	.stabd	68,0,26
	call	_weakfn, 0
	 nop
	jmp	%i7+8
	 restore %g0, %o0, %o0
	.stabs	"weakref_user:F1",36,0,26,_weakref_user
Lscope11:
	.align	2
	.globl _volatile_rw
_volatile_rw:
	.stabd	46,0,0
	.stabd	68,0,29
LFBB12:
	.stabd	68,0,29
	mov	1, %g1
	st	%g1, [%o0]
	ld	[%o0], %o0
	jmp	%o7+8
	 nop
	.stabs	"volatile_rw:F1",36,0,29,_volatile_rw
	.stabs	"p:P23",64,0,29,8
	.stabs	":t23=*24",128,0,0,0
	.stabs	":t24=B1",128,0,0,0
Lscope12:
	.align	2
	.globl _dtor
_dtor:
	.stabd	46,0,0
	.stabd	68,0,24
LFBB13:
	save	%sp, -104, %sp
	.stabd	68,0,24
	call	_ext, 0
	 mov	2, %o0
	jmp	%i7+8
	 restore
	.stabs	"dtor:F15",36,0,24,_dtor
Lscope13:
.destructor
	.align	2
	.long	_dtor
.reference .destructors_used
	.text
	.align	2
	.globl _ctor
_ctor:
	.stabd	46,0,0
	.stabd	68,0,23
LFBB14:
	save	%sp, -104, %sp
	.stabd	68,0,23
	call	_ext, 0
	 mov	1, %o0
	jmp	%i7+8
	 restore
	.stabs	"ctor:F15",36,0,23,_ctor
Lscope14:
.constructor
	.align	2
	.long	_ctor
.reference .constructors_used
	.text
	.align	2
	.globl _mixed
_mixed:
	.stabd	46,0,0
	.stabd	68,0,19
LFBB15:
	save	%sp, -112, %sp
	st	%i1, [%fp-16]
	st	%i2, [%fp-12]
	ldd	[%fp-16], %f8
	.stabd	68,0,19
	std	%i4, [%fp-16]
	ldd	[%fp-16], %f10
	faddd	%f8, %f10, %f10
	std	%f10, [%fp-16]
	call	_ext2, 0
	 ldd	[%fp-16], %o0
	add	%i3, %i0, %i3
	ld	[%fp+92], %g1
	add	%i3, %g1, %i3
	ld	[%fp+96], %g1
	add	%i3, %g1, %i3
	ld	[%fp+100], %g1
	add	%i3, %g1, %i3
	ld	[%fp+104], %g1
	add	%i3, %g1, %i3
	jmp	%i7+8
	 restore %i3, %o0, %o0
	.stabs	"mixed:F1",36,0,19,_mixed
	.stabs	"a:P1",64,0,19,24
	.stabs	"b:P13",64,0,19,40
	.stabs	"c:P1",64,0,19,27
	.stabs	"d:P13",64,0,19,28
	.stabs	"e:p1",160,0,19,92
	.stabs	"f:p1",160,0,19,96
	.stabs	"g:p1",160,0,19,100
	.stabs	"h:p1",160,0,19,104
	.stabs	"e:r1",64,0,19,1
	.stabs	"f:r1",64,0,19,1
	.stabs	"g:r1",64,0,19,1
	.stabs	"h:r1",64,0,19,1
Lscope15:
	.align	2
	.globl _al
_al:
	.stabd	46,0,0
	.stabd	68,0,18
LFBB16:
	save	%sp, -104, %sp
	.stabd	68,0,18
	add	%i0, 7, %i0
	and	%i0, -8, %i0
	sub	%sp, %i0, %sp
	mov	1, %g1
	stb	%g1, [%sp+96]
	call	_ext, 0
	 mov	1, %o0
	jmp	%i7+8
	 restore %g0, %o0, %o0
	.stabs	"al:F1",36,0,18,_al
	.stabs	"n:P1",64,0,18,24
Lscope16:
	.align	2
	.globl _vsum
_vsum:
	.stabd	46,0,0
	.stabd	68,0,14
LFBB17:
	add	%sp, -112, %sp
	st	%o1, [%sp+184]
	st	%o2, [%sp+188]
	st	%o3, [%sp+192]
	st	%o4, [%sp+196]
	st	%o5, [%sp+200]
	mov	%o0, %g4
	.stabd	68,0,14
	add	%sp, 184, %g1
	st	%g1, [%sp+100]
	.stabd	68,0,15
	cmp	%g4, 0
	be	L59
	 mov	0, %o0
	mov	0, %o0
	mov	0, %g3
L60:
	ld	[%sp+100], %g1
	ld	[%g1], %g2
	add	%o0, %g2, %o0
	add	%g1, 4, %g1
	add	%g3, 1, %g3
	cmp	%g3, %g4
	bne	L60
	 st	%g1, [%sp+100]
L59:
	jmp	%o7+8
	 sub	%sp, -112, %sp
	.stabs	"vsum:F1",36,0,14,_vsum
	.stabs	"n:P1",64,0,14,4
	.stabs	"ap:16",128,0,14,100
	.stabs	"s:r1",64,0,14,8
	.stabn	192,0,0,LFBB17
	.stabn	224,0,0,Lscope17
Lscope17:
	.align	2
	.globl _usesq
_usesq:
	.stabd	46,0,0
	.stabd	68,0,28
LFBB18:
	mov	%o0, %g1
	.stabd	68,0,28
	add	%o0, 1, %o0
	smul	%o0, %o0, %o0
	smul	%g1, %g1, %g1
	jmp	%o7+8
	 add	%o0, %g1, %o0
	.stabs	"usesq:F1",36,0,28,_usesq
	.stabs	"x:P1",64,0,28,1
Lscope18:
	.globl _fptr
	.data
	.align	2
_fptr:
	.long	_ext
	.stabs	"fptr:G21",32,0,16,0
	.text
	.stabs "",100,0,0,Letext
Letext:
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
