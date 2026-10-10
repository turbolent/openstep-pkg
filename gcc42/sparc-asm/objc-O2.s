.const
	.align	2
L_OBJC_IMAGE_INFO:
	.space 8
	.globl .objc_class_name_Kid
	.align	2
.objc_class_name_Kid:
	.space 4
	.globl .objc_class_name_Base
	.align	2
.objc_class_name_Base:
	.space 4
.literal8
	.align	3
LC0:
	.long	1074397184
	.long	0
	.text
	.align	2
"-[Base result:]":
	ld	[%o0], %g3
	ld	[%sp+64], %g2
	sethi	%hi(LC0), %g1
	st	%o2, [%g2+4]
	ldd	[%g1+%lo(LC0)], %f8
	add	%o2, %g3, %o2
	st	%g3, [%g2]
	mov	%g2, %o0
	std	%f8, [%g2+16]
	jmp	%o7+12
	 st	%o2, [%g2+8]
.literal8
	.align	3
LC1:
	.long	1074397184
	.long	0
	.text
	.align	2
"-[Base dbl]":
	sethi	%hi(LC1), %g1
	jmp	%o7+8
	 ldd	[%g1+%lo(LC1)], %f0
	.align	2
"+[Base make]":
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
	sethi	%hi(LC2), %o0
	jmp	%o7+8
	 or	%o0, %lo(LC2), %o0
	.align	2
"-[Kid result:]":
	save	%sp, -136, %sp
	sethi	%hi(L_OBJC_CLASS_Kid+4), %g1
	ld	[%g1+%lo(L_OBJC_CLASS_Kid+4)], %g2
	sethi	%hi(L_OBJC_SELECTOR_REFERENCES_0), %g1
	ld	[%fp+64], %l0
	st	%i0, [%fp-16]
	ld	[%g1+%lo(L_OBJC_SELECTOR_REFERENCES_0)], %o1
	mov	%i2, %o2
	st	%l0, [%sp+64]
	st	%g2, [%fp-12]
	add	%fp, -16, %o0
	call	_objc_msgSendSuper, 0
	 nop
	unimp	24
	ld	[%l0+8], %g1
	add	%g1, 100, %g1
	st	%g1, [%l0+8]
	jmp	%i7+12
	 restore %g0, %l0, %o0
	.align	2
	.globl _go2
_go2:
	save	%sp, -104, %sp
	sethi	%hi(L_OBJC_SELECTOR_REFERENCES_1), %g1
	mov	%i0, %o0
	call	_objc_msgSend, 0
	 ld	[%g1+%lo(L_OBJC_SELECTOR_REFERENCES_1)], %o1
	jmp	%i7+8
	 restore
	.align	2
	.globl _go
_go:
	save	%sp, -104, %sp
	sethi	%hi(L_OBJC_SELECTOR_REFERENCES_0), %g1
	mov	%i0, %o0
	ld	[%g1+%lo(L_OBJC_SELECTOR_REFERENCES_0)], %o1
	ld	[%fp+64], %i0
	mov	11, %o2
	st	%i0, [%sp+64]
	call	_objc_msgSend, 0
	 nop
	unimp	24
	jmp	%i7+12
	 restore
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
	.ident	"GCC: (GNU) 4.2.1 (Apple Inc. build 5666) (dot 3)"
