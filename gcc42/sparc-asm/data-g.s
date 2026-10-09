	.stabs	"data.c",100,0,2,Ltext0
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
	.stabs	"pk:T16=s7c:2,0,8;i:1,8,32;s:8,40,16;;",128,0,0,0
	.stabs	"bf:T17=s4a:4,0,3;b:4,3,5;c:4,8,24;;",128,0,0,0
	.align	2
	.globl _use
_use:
	.stabd	46,0,0
	.stabd	68,0,23
LFBB1:
	.stabd	68,0,23
	sethi	%hi(_common_int), %g1
	ld	[%g1+%lo(_common_int)], %g2
	sethi	%hi(_local_zero+4), %g1
	ld	[%g1+%lo(_local_zero+4)], %g1
	add	%g2, %g1, %g2
	sethi	%hi(_local_byte), %g1
	ldsb	[%g1+%lo(_local_byte)], %o0
	jmp	%o7+8
	 add	%g2, %o0, %o0
	.stabs	"use:F1",36,0,23,_use
Lscope1:
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
.lcomm _local_zero,40,2
.lcomm _local_byte,1,0
	.comm _common_int,8
	.comm _common_dbl,24
	.comm _uninit_big,4000
	.stabs	"local_zero:S18",40,0,4,_local_zero
	.stabs	"local_byte:S2",40,0,5,_local_byte
	.stabs	"common_int:G1",32,0,2,0
	.stabs	"common_dbl:G19",32,0,3,0
	.stabs	"buf:G20",32,0,6,0
	.stabs	"shorts:G21",32,0,7,0
	.stabs	"ints:G22",32,0,8,0
	.stabs	"quads:G23",32,0,9,0
	.stabs	"flts:G24",32,0,10,0
	.stabs	"dbls:G25",32,0,11,0
	.stabs	"ld:G14",32,0,12,0
	.stabs	"strs:G26",32,0,13,0
	.stabs	"msg:G27",32,0,14,0
	.stabs	"ptrs:G28",32,0,15,0
	.stabs	"packed_val:G16",32,0,17,0
	.stabs	"packed_arr:G29",32,0,18,0
	.stabs	"bits:G17",32,0,19,0
	.stabs	"uninit_big:G30",32,0,20,0
	.stabs	"ext_ptr:G31",32,0,22,0
	.stabs	":t18=ar32=r32;0;037777777777;;0;9;1",128,0,0,0
	.stabs	":t19=ar32;0;2;13",128,0,0,0
	.stabs	":t20=ar32;0;99;2",128,0,0,0
	.stabs	":t21=ar32;0;3;8",128,0,0,0
	.stabs	":t22=ar32;0;3;1",128,0,0,0
	.stabs	":t23=ar32;0;1;6",128,0,0,0
	.stabs	":t24=ar32;0;1;12",128,0,0,0
	.stabs	":t25=ar32;0;1;13",128,0,0,0
	.stabs	":t26=ar32;0;2;33",128,0,0,0
	.stabs	":t27=ar32;0;12;34",128,0,0,0
	.stabs	":t28=ar32;0;2;31",128,0,0,0
	.stabs	":t29=ar32;0;1;16",128,0,0,0
	.stabs	":t30=ar32;0;999;1",128,0,0,0
	.stabs	":t31=*1",128,0,0,0
	.stabs	":t33=*2",128,0,0,0
	.stabs	":t34=k2",128,0,0,0
	.text
	.stabs "",100,0,0,Letext
Letext:
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
