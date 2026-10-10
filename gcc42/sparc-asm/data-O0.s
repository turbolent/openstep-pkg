	.globl _buf
	.data
	.align	3
_buf:
	.byte	1
	.byte	2
	.byte	3
	.space 97
	.globl _shorts
	.align	1
_shorts:
	.short	1
	.short	-2
	.short	3
	.short	-4
	.globl _ints
	.align	2
_ints:
	.long	1
	.long	-2
	.long	3
	.long	-4
	.globl _quads
	.align	3
_quads:
	.long	287454020
	.long	1432778632
	.long	-1
	.long	-1
	.globl _flts
	.align	2
_flts:
	.long	1069547520
	.long	3222274048
	.globl _dbls
	.align	3
_dbls:
	.long	1074340345
	.long	4028335726
	.long	-726513235
	.long	630506365
	.globl _ld
	.align	3
_ld:
	.long	1074003968
	.long	0
	.globl _strs
.cstring
	.align	3
LC0:
	.ascii "alpha\0"
	.align	3
LC1:
	.ascii "beta\12\0"
	.align	3
LC2:
	.ascii "gamma\11\"quoted\"\0"
	.data
	.align	2
_strs:
	.long	LC0
	.long	LC1
	.long	LC2
	.globl _msg
.const
	.align	3
_msg:
	.ascii "hello, world\0"
	.globl _ptrs
	.data
	.align	2
_ptrs:
	.long	_common_int
	.long	_ints
	.long	_ints+8
	.globl _packed_val
_packed_val:
	.byte	1
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	0
	.byte	5
	.globl _packed_arr
_packed_arr:
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	3
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	5
	.byte	0
	.byte	6
	.globl _bits
	.align	2
_bits:
	.byte	34
	.byte	0
	.byte	0
	.byte	3
	.globl _ext_ptr
	.align	2
_ext_ptr:
	.long	_ext_sym
	.text
	.align	2
	.globl _use
_use:
	save	%sp, -104, %sp
	sethi	%hi(_local_zero), %g1
	or	%g1, %lo(_local_zero), %g1
	ld	[%g1+4], %g2
	sethi	%hi(_local_byte), %g1
	or	%g1, %lo(_local_byte), %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	add	%g2, %g1, %g2
	sethi	%hi(_common_int), %g1
	or	%g1, %lo(_common_int), %g1
	ld	[%g1], %g1
	add	%g2, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
.lcomm _local_zero,40,2
.lcomm _local_byte,1,0
	.comm _common_int,8
	.comm _common_dbl,24
	.comm _uninit_big,4000
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
