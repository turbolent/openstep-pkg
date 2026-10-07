.literal8
	.align	3
LC0:
	.long	1074397184
	.long	0
	.text
	.align	2
"-[Base result:]":
	save	%sp, -128, %sp
	ld	[%fp+64], %g4
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-32]
	ld	[%fp+76], %g1
	st	%g1, [%fp-28]
	ld	[%fp+68], %g1
	ld	[%g1], %g2
	ld	[%fp+76], %g1
	add	%g2, %g1, %g1
	st	%g1, [%fp-24]
	sethi	%hi(LC0), %g1
	or	%g1, %lo(LC0), %g1
	ldd	[%g1], %f8
	std	%f8, [%fp-16]
	ldd	[%fp-32], %g2
	std	%g2, [%g4]
	ldd	[%fp-24], %g2
	std	%g2, [%g4+8]
	ldd	[%fp-16], %g2
	std	%g2, [%g4+16]
	mov	%g4, %i0
	restore
	jmp	%o7+12
	 nop
.literal8
	.align	3
LC1:
	.long	1074397184
	.long	0
	.text
	.align	2
"-[Base dbl]":
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	sethi	%hi(LC1), %g1
	or	%g1, %lo(LC1), %g1
	ldd	[%g1], %f8
	fmovs	%f8, %f0
	fmovs	%f9, %f1
	restore
	jmp	%o7+8
	 nop
	.align	2
"+[Base make]":
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align	2
"-[Kid result:]":
	save	%sp, -136, %sp
	ld	[%fp+64], %l0
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %g1
	st	%g1, [%fp-40]
	sethi	%hi(L_OBJC_CLASS_Kid), %g1
	or	%g1, %lo(L_OBJC_CLASS_Kid), %g1
	ld	[%g1+4], %g1
	st	%g1, [%fp-36]
	add	%fp, -40, %g3
	sethi	%hi(L_OBJC_SELECTOR_REFERENCES_0), %g1
	or	%g1, %lo(L_OBJC_SELECTOR_REFERENCES_0), %g1
	ld	[%g1], %g2
	add	%fp, -32, %g1
	st	%g1, [%sp+64]
	mov	%g3, %o0
	mov	%g2, %o1
	ld	[%fp+76], %o2
	call	_objc_msgSendSuper, 0
	 nop
	unimp	24
	ld	[%fp-24], %g1
	add	%g1, 100, %g1
	st	%g1, [%fp-24]
	ldd	[%fp-32], %g2
	std	%g2, [%l0]
	ldd	[%fp-24], %g2
	std	%g2, [%l0+8]
	ldd	[%fp-16], %g2
	std	%g2, [%l0+16]
	mov	%l0, %i0
	restore
	jmp	%o7+12
	 nop
	.align	2
	.globl _go
_go:
	save	%sp, -104, %sp
	ld	[%fp+64], %l0
	st	%i0, [%fp+68]
	ld	[%fp+68], %g2
	sethi	%hi(L_OBJC_SELECTOR_REFERENCES_0), %g1
	or	%g1, %lo(L_OBJC_SELECTOR_REFERENCES_0), %g1
	ld	[%g1], %g1
	st	%l0, [%sp+64]
	mov	%g2, %o0
	mov	%g1, %o1
	mov	11, %o2
	call	_objc_msgSend, 0
	 nop
	unimp	24
	mov	%l0, %i0
	restore
	jmp	%o7+12
	 nop
	.align	2
	.globl _go2
_go2:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g2
	sethi	%hi(L_OBJC_SELECTOR_REFERENCES_1), %g1
	or	%g1, %lo(L_OBJC_SELECTOR_REFERENCES_1), %g1
	ld	[%g1], %g1
	mov	%g2, %o0
	mov	%g1, %o1
	call	_objc_msgSend, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	fmovs	%f8, %f0
	fmovs	%f9, %f1
	restore
	jmp	%o7+8
	 nop
.cstring
	.align	3
LC2:
	.ascii "x\0"
	.text
	.align	2
	.globl _str
_str:
	save	%sp, -104, %sp
	sethi	%hi(LC2), %g1
	or	%g1, %lo(LC2), %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
.objc_class
.objc_meta_class
.objc_cat_cls_meth
.objc_cat_inst_meth
.objc_cls_meth
.objc_inst_meth
.objc_message_refs
.objc_symbols
.objc_category
.objc_protocol
.objc_class_vars
.objc_instance_vars
.objc_module_info
.objc_string_object
.objc_class_names
.objc_meth_var_names
.objc_meth_var_types
.objc_cls_refs
.objc_symbols
	.align	2
L_OBJC_SYMBOLS:
	.long	0
	.long	0
	.short	2
	.short	0
	.long	L_OBJC_CLASS_Kid
	.long	L_OBJC_CLASS_Base
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_0:
	.ascii "result:\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_0:
	.ascii "{?=iiid}12@0:4i8\0"
.objc_inst_meth
	.align	2
L_OBJC_INSTANCE_METHODS_Kid:
	.long	0
	.long	1
	.long	L_OBJC_METH_VAR_NAME_0
	.long	L_OBJC_METH_VAR_TYPE_0
	.long	"-[Kid result:]"
.objc_class_names
L_OBJC_CLASS_NAME_0:
	.ascii "Kid\0"
L_OBJC_CLASS_NAME_1:
	.ascii "Base\0"
.objc_meta_class
	.align	2
L_OBJC_METACLASS_Kid:
	.long	L_OBJC_CLASS_NAME_1
	.long	L_OBJC_CLASS_NAME_1
	.long	L_OBJC_CLASS_NAME_0
	.long	0
	.long	2
	.long	48
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
.objc_class
	.align	2
L_OBJC_CLASS_Kid:
	.long	L_OBJC_METACLASS_Kid
	.long	L_OBJC_CLASS_NAME_1
	.long	L_OBJC_CLASS_NAME_0
	.long	0
	.long	1
	.long	4
	.long	0
	.long	L_OBJC_INSTANCE_METHODS_Kid
	.long	0
	.long	0
	.long	0
	.long	0
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_1:
	.ascii "isa\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_1:
	.ascii "^{_objc_class=^{_objc_class}^{_objc_class}*lll^{_objc_ivar_list}^{_objc_method_list}^{objc_cache}^^{_objc_protocol}*^{_objc_class_ext}}\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_2:
	.ascii "super_class\0"
L_OBJC_METH_VAR_NAME_3:
	.ascii "name\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_2:
	.ascii "*\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_4:
	.ascii "version\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_3:
	.ascii "l\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_5:
	.ascii "info\0"
L_OBJC_METH_VAR_NAME_6:
	.ascii "instance_size\0"
L_OBJC_METH_VAR_NAME_7:
	.ascii "ivars\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_4:
	.ascii "^{_objc_ivar_list=}\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_8:
	.ascii "methods\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_5:
	.ascii "^{_objc_method_list=}\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_9:
	.ascii "cache\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_6:
	.ascii "^{objc_cache=}\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_10:
	.ascii "protocol_list\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_7:
	.ascii "^^{_objc_protocol}\0"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_11:
	.ascii "ivar_layout\0"
L_OBJC_METH_VAR_NAME_12:
	.ascii "ext\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_8:
	.ascii "^{_objc_class_ext=i*^{_prop_list_t}}\0"
.objc_class_vars
	.align	2
L_OBJC_CLASS_VARIABLES_Base:
	.long	12
	.long	L_OBJC_METH_VAR_NAME_1
	.long	L_OBJC_METH_VAR_TYPE_1
	.long	0
	.long	L_OBJC_METH_VAR_NAME_2
	.long	L_OBJC_METH_VAR_TYPE_1
	.long	4
	.long	L_OBJC_METH_VAR_NAME_3
	.long	L_OBJC_METH_VAR_TYPE_2
	.long	8
	.long	L_OBJC_METH_VAR_NAME_4
	.long	L_OBJC_METH_VAR_TYPE_3
	.long	12
	.long	L_OBJC_METH_VAR_NAME_5
	.long	L_OBJC_METH_VAR_TYPE_3
	.long	16
	.long	L_OBJC_METH_VAR_NAME_6
	.long	L_OBJC_METH_VAR_TYPE_3
	.long	20
	.long	L_OBJC_METH_VAR_NAME_7
	.long	L_OBJC_METH_VAR_TYPE_4
	.long	24
	.long	L_OBJC_METH_VAR_NAME_8
	.long	L_OBJC_METH_VAR_TYPE_5
	.long	28
	.long	L_OBJC_METH_VAR_NAME_9
	.long	L_OBJC_METH_VAR_TYPE_6
	.long	32
	.long	L_OBJC_METH_VAR_NAME_10
	.long	L_OBJC_METH_VAR_TYPE_7
	.long	36
	.long	L_OBJC_METH_VAR_NAME_11
	.long	L_OBJC_METH_VAR_TYPE_2
	.long	40
	.long	L_OBJC_METH_VAR_NAME_12
	.long	L_OBJC_METH_VAR_TYPE_8
	.long	44
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_13:
	.ascii "bias\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_9:
	.ascii "i\0"
.objc_instance_vars
	.align	2
L_OBJC_INSTANCE_VARIABLES_Base:
	.long	1
	.long	L_OBJC_METH_VAR_NAME_13
	.long	L_OBJC_METH_VAR_TYPE_9
	.long	0
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_14:
	.ascii "make\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_10:
	.ascii "@8@0:4\0"
.objc_cls_meth
	.align	2
L_OBJC_CLASS_METHODS_Base:
	.long	0
	.long	1
	.long	L_OBJC_METH_VAR_NAME_14
	.long	L_OBJC_METH_VAR_TYPE_10
	.long	"+[Base make]"
.objc_meth_var_names
L_OBJC_METH_VAR_NAME_15:
	.ascii "dbl\0"
.objc_meth_var_types
L_OBJC_METH_VAR_TYPE_11:
	.ascii "d8@0:4\0"
.objc_inst_meth
	.align	2
L_OBJC_INSTANCE_METHODS_Base:
	.long	0
	.long	2
	.long	L_OBJC_METH_VAR_NAME_15
	.long	L_OBJC_METH_VAR_TYPE_11
	.long	"-[Base dbl]"
	.long	L_OBJC_METH_VAR_NAME_0
	.long	L_OBJC_METH_VAR_TYPE_0
	.long	"-[Base result:]"
.objc_meta_class
	.align	2
L_OBJC_METACLASS_Base:
	.long	L_OBJC_CLASS_NAME_1
	.long	0
	.long	L_OBJC_CLASS_NAME_1
	.long	0
	.long	2
	.long	48
	.long	L_OBJC_CLASS_VARIABLES_Base
	.long	L_OBJC_CLASS_METHODS_Base
	.long	0
	.long	0
	.long	0
	.long	0
.objc_class
	.align	2
L_OBJC_CLASS_Base:
	.long	L_OBJC_METACLASS_Base
	.long	0
	.long	L_OBJC_CLASS_NAME_1
	.long	0
	.long	1
	.long	4
	.long	L_OBJC_INSTANCE_VARIABLES_Base
	.long	L_OBJC_INSTANCE_METHODS_Base
	.long	0
	.long	0
	.long	0
	.long	0
.objc_message_refs
	.align	2
L_OBJC_SELECTOR_REFERENCES_1:
	.long	L_OBJC_METH_VAR_NAME_15
	.align	2
L_OBJC_SELECTOR_REFERENCES_0:
	.long	L_OBJC_METH_VAR_NAME_0
.const
	.align	2
L_OBJC_IMAGE_INFO:
	.space 8
.objc_class_names
L_OBJC_CLASS_NAME_2:
	.ascii "\0"
.objc_module_info
	.align	2
L_OBJC_MODULES:
	.long	7
	.long	16
	.long	L_OBJC_CLASS_NAME_2
	.long	L_OBJC_SYMBOLS
	.data
	.align	2
_.objc_class_ref_Base:
	.long	.objc_class_name_Base
	.globl .objc_class_name_Kid
.const
	.align	2
.objc_class_name_Kid:
	.space 4
	.globl .objc_class_name_Base
	.align	2
.objc_class_name_Base:
	.space 4
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
