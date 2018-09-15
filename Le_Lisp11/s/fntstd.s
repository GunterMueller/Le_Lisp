	.set	cval,0
	.set	plist,4
	.set	fval,8
	.set	pkgc,12
	.set	alink,16
	.set	ftype,20
	.set	ptype,21
	.set	plen,22
	.set	pname,24
	.set	val,0
	.set	car,0
	.set	cdr,4
	.set	subr0,1
	.set	subr1,2
	.set	subr2,3
	.set	subr3,4
	.set	subrn,5
	.set	subrf,6
	.set	expr,7
	.set	fexpr,8
	.set	macro,9
	.set	subrv1,10
	.set	subrv2,11
	.set	subrv3,12
	.set	subrvn,13
	.set	mk_eval,0xFFFFFFF0
	.set	mk_read,0xFFFFFFF1
	.set	mk_subrn,0xFFFFFFF2
	.set	mk_map,0xFFFFFFF3
	.text
	.globl	buildat
	.globl	csymb
	.globl	mstack
	.globl	errfs
	.globl	gc
	.globl	hashmax
	.globl	hashtab
	.globl	errnaa
	.globl	errnna
	.globl	errnla
	.globl	errnva
	.globl	evalcar
	.globl	evala1
	.globl	progna3
	.globl	savep
	.globl	progn
	.globl	apply
	.globl	.undef
	.globl	.t
	.globl	.void
	.globl	.quote
	.globl	.internal
	.globl	loc
	.globl	ini_std
	.globl	true
	.globl	false
	.globl	member
	.globl	.fcons
	.globl	.mcons
	.globl	.atom
ini_std:
	movl	csymb,r0
	movl	r0,.fcval
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fcval,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fcval
	.byte	0
	.word	4
	.ascii	"cval"
	movl	csymb,r0
	movl	r0,.makunbound
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	makunbound,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._makunbound
	.byte	0
	.word	10
	.ascii	"makunbound"
	movl	csymb,r0
	movl	r0,.fplist
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fplist,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fplist
	.byte	0
	.word	5
	.ascii	"plist"
	movl	csymb,r0
	movl	r0,.setplist
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	setplist,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._setplist
	.byte	0
	.word	8
	.ascii	"setplist"
	movl	csymb,r0
	movl	r0,.ffval
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ffval,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ffval
	.byte	0
	.word	4
	.ascii	"fval"
	movl	csymb,r0
	movl	r0,.fftype
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fftype,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fftype
	.byte	0
	.word	5
	.ascii	"ftype"
	movl	csymb,r0
	movl	r0,.makunfn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	makunfn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._makunfn
	.byte	0
	.word	12
	.ascii	"makunboundfn"
	movl	csymb,r0
	movl	r0,.findfn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	findfn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._findfn
	.byte	0
	.word	6
	.ascii	"findfn"
	movl	csymb,r0
	movl	r0,.synonym
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	synonym,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._synonym
	.byte	0
	.word	7
	.ascii	"synonym"
	movl	csymb,r0
	movl	r0,.true
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	true,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._true
	.byte	0
	.word	4
	.ascii	"true"
	movl	csymb,r0
	movl	r0,.false
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	false,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._false
	.byte	0
	.word	5
	.ascii	"false"
	movl	csymb,r0
	movl	r0,.not
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	not,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._not
	.byte	0
	.word	3
	.ascii	"not"
	movl	csymb,r0
	movl	r0,.null
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	null,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._null
	.byte	0
	.word	4
	.ascii	"null"
	movl	csymb,r0
	movl	r0,.atom
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	atom,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._atom
	.byte	0
	.word	4
	.ascii	"atom"
	movl	csymb,r0
	movl	r0,.symbolp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	symbolp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._symbolp
	.byte	0
	.word	7
	.ascii	"symbolp"
	movl	csymb,r0
	movl	r0,.numberp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	numberp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._numberp
	.byte	0
	.word	7
	.ascii	"numberp"
	movl	csymb,r0
	movl	r0,.stringp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	stringp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._stringp
	.byte	0
	.word	7
	.ascii	"stringp"
	movl	csymb,r0
	movl	r0,.listp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	listp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._listp
	.byte	0
	.word	5
	.ascii	"listp"
	movl	csymb,r0
	movl	r0,.consp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	consp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._consp
	.byte	0
	.word	5
	.ascii	"consp"
	movl	csymb,r0
	movl	r0,.boundp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	boundp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._boundp
	.byte	0
	.word	6
	.ascii	"boundp"
	movl	csymb,r0
	movl	r0,.eq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	eq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._eq
	.byte	0
	.word	2
	.ascii	"eq"
	movl	csymb,r0
	movl	r0,.neq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	neq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._neq
	.byte	0
	.word	3
	.ascii	"neq"
	movl	csymb,r0
	movl	r0,.equal
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	equal,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._equal
	.byte	0
	.word	5
	.ascii	"equal"
	movl	csymb,r0
	movl	r0,.nequal
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nequal,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nequal
	.byte	0
	.word	6
	.ascii	"nequal"
	movl	csymb,r0
	movl	r0,.memq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	memq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._memq
	.byte	0
	.word	4
	.ascii	"memq"
	movl	csymb,r0
	movl	r0,.member
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	member,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._member
	.byte	0
	.word	6
	.ascii	"member"
	movl	csymb,r0
	movl	r0,.last
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	last,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._last
	.byte	0
	.word	4
	.ascii	"last"
	movl	csymb,r0
	movl	r0,.nthcdr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nthcdr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nthcdr
	.byte	0
	.word	6
	.ascii	"nthcdr"
	movl	csymb,r0
	movl	r0,.nth
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nth,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nth
	.byte	0
	.word	3
	.ascii	"nth"
	movl	csymb,r0
	movl	r0,.length
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	length,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._length
	.byte	0
	.word	6
	.ascii	"length"
	movl	csymb,r0
	movl	r0,.fcons
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fcons,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fcons
	.byte	0
	.word	4
	.ascii	"cons"
	movl	csymb,r0
	movl	r0,.fxcons
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fxcons,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fxcons
	.byte	0
	.word	5
	.ascii	"xcons"
	movl	csymb,r0
	movl	r0,.fncons
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fncons,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fncons
	.byte	0
	.word	5
	.ascii	"ncons"
	movl	csymb,r0
	movl	r0,.mcons
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	mcons,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._mcons
	.byte	0
	.word	5
	.ascii	"mcons"
	movl	csymb,r0
	movl	r0,.kwote
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	kwote,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._kwote
	.byte	0
	.word	5
	.ascii	"kwote"
	movl	csymb,r0
	movl	r0,.makelist
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	makelist,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._makelist
	.byte	0
	.word	8
	.ascii	"makelist"
	movl	csymb,r0
	movl	r0,.reverse
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	reverse,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._reverse
	.byte	0
	.word	7
	.ascii	"reverse"
	movl	csymb,r0
	movl	r0,.append
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	append,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._append
	.byte	0
	.word	6
	.ascii	"append"
	movl	csymb,r0
	movl	r0,.appnd1
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	appnd1,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._appnd1
	.byte	0
	.word	7
	.ascii	"append1"
	movl	csymb,r0
	movl	r0,.remq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	remq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._remq
	.byte	0
	.word	4
	.ascii	"remq"
	movl	csymb,r0
	movl	r0,.remove
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	remove,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._remove
	.byte	0
	.word	6
	.ascii	"remove"
	movl	csymb,r0
	movl	r0,.copy
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	copy,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._copy
	.byte	0
	.word	4
	.ascii	"copy"
	movl	csymb,r0
	movl	r0,.substitute
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	substitute,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._substitute
	.byte	0
	.word	5
	.ascii	"subst"
	movl	csymb,r0
	movl	r0,.oblist
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	oblist,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._oblist
	.byte	0
	.word	6
	.ascii	"oblist"
	movl	csymb,r0
	movl	r0,.rplaca
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rplaca,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rplaca
	.byte	0
	.word	6
	.ascii	"rplaca"
	movl	csymb,r0
	movl	r0,.rplacd
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rplacd,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rplacd
	.byte	0
	.word	6
	.ascii	"rplacd"
	movl	csymb,r0
	movl	r0,.rplac
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rplac,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rplac
	.byte	0
	.word	5
	.ascii	"rplac"
	movl	csymb,r0
	movl	r0,.placdl
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	placdl,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._placdl
	.byte	0
	.word	6
	.ascii	"placdl"
	movl	csymb,r0
	movl	r0,.displace
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	displace,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._displace
	.byte	0
	.word	8
	.ascii	"displace"
	movl	csymb,r0
	movl	r0,.setq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	setq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._setq
	.byte	0
	.word	4
	.ascii	"setq"
	movl	csymb,r0
	movl	r0,.fset
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fset,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fset
	.byte	0
	.word	3
	.ascii	"set"
	movl	csymb,r0
	movl	r0,.setqq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	setqq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._setqq
	.byte	0
	.word	5
	.ascii	"setqq"
	movl	csymb,r0
	movl	r0,.psetq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	psetq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._psetq
	.byte	0
	.word	5
	.ascii	"psetq"
	movl	csymb,r0
	movl	r0,.nreverse
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nreverse,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nreverse
	.byte	0
	.word	8
	.ascii	"nreverse"
	movl	csymb,r0
	movl	r0,.nreconc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nreconc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nreconc
	.byte	0
	.word	7
	.ascii	"nreconc"
	movl	csymb,r0
	movl	r0,.nextl
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nextl,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nextl
	.byte	0
	.word	5
	.ascii	"nextl"
	movl	csymb,r0
	movl	r0,.newl
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	newl,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._newl
	.byte	0
	.word	4
	.ascii	"newl"
	movl	csymb,r0
	movl	r0,.nconc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nconc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nconc
	.byte	0
	.word	5
	.ascii	"nconc"
	movl	csymb,r0
	movl	r0,.nconc1
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	nconc1,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._nconc1
	.byte	0
	.word	6
	.ascii	"nconc1"
	movl	csymb,r0
	movl	r0,.get
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	get,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._get
	.byte	0
	.word	3
	.ascii	"get"
	movl	csymb,r0
	movl	r0,.getprop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	getprop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._getprop
	.byte	0
	.word	7
	.ascii	"getprop"
	movl	csymb,r0
	movl	r0,.getl
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	getl,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._getl
	.byte	0
	.word	4
	.ascii	"getl"
	movl	csymb,r0
	movl	r0,.addprop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	addprop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._addprop
	.byte	0
	.word	7
	.ascii	"addprop"
	movl	csymb,r0
	movl	r0,.putprop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	putprop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._putprop
	.byte	0
	.word	7
	.ascii	"putprop"
	movl	csymb,r0
	movl	r0,.defprop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	defprop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._defprop
	.byte	0
	.word	7
	.ascii	"defprop"
	movl	csymb,r0
	movl	r0,.remprop
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	remprop,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._remprop
	.byte	0
	.word	7
	.ascii	"remprop"
	movl	csymb,r0
	movl	r0,.acons
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	acons,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._acons
	.byte	0
	.word	5
	.ascii	"acons"
	movl	csymb,r0
	movl	r0,.assq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	assq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._assq
	.byte	0
	.word	4
	.ascii	"assq"
	movl	csymb,r0
	movl	r0,.cassq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cassq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cassq
	.byte	0
	.word	5
	.ascii	"cassq"
	movl	csymb,r0
	movl	r0,.assoc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	assoc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._assoc
	.byte	0
	.word	5
	.ascii	"assoc"
	movl	csymb,r0
	movl	r0,.cassoc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cassoc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cassoc
	.byte	0
	.word	6
	.ascii	"cassoc"
popj:
	rsb
	.data
.fcval:
	.long	0
	.set	._fcval,subr1
	.text
	.globl	fcval
fcval:
	cmpl	r7,r1
	jgtr	cvalerr
	cmpl	r9,r1
	jleq	cvalerr
	movl	cval(r1),r1
	rsb
cvalerr:
	movl	.fcval,r2
	jmp	errnaa
	.data
.makunbound:
	.long	0
	.set	._makunbound,subr1
	.text
	.globl	makunbound
makunbound:
	cmpl	r7,r1
	jgtr	makuerr
	cmpl	r9,r1
	jleq	makuerr
	cmpl	r7,r1
	jeql	makuerr
	movl	.undef,cval(r1)
	rsb
makuerr:
	movl	.makunbound,r2
	jmp	errnaa
	.data
.fplist:
	.long	0
	.set	._fplist,subr1
	.text
	.globl	fplist
fplist:
	cmpl	r7,r1
	jgtr	plisterr
	cmpl	r9,r1
	jleq	plisterr
	movl	plist(r1),r1
	rsb
plisterr:
	movl	.fplist,r2
	jmp	errnaa
	.data
.setplist:
	.long	0
	.set	._setplist,subr2
	.text
	.globl	setplist
setplist:
	cmpl	r7,r1
	jgtr	slisterr
	cmpl	r9,r1
	jleq	slisterr
	cmpl	r7,r1
	jeql	slisterr
	movl	r2,plist(r1)
	movl	r2,r1
	rsb
slisterr:
	movl	.setplist,r2
	jmp	errnaa
	.data
.ffval:
	.long	0
	.set	._ffval,subrv2
	.text
	.globl	ffval
ffval:
	cmpl	r7,r1
	jgtr	fvalerr
	cmpl	r9,r1
	jleq	fvalerr
	cmpl	r7,r2
	jeql	fval1
	movl	r2,fval(r1)
fval1:
	movl	fval(r1),r1
	cmpl	r6,r1
	jleq	popj
	jmp	loc
fvalerr:
	movl	.ffval,r2
	jmp	errnaa
	.data
.fftype:
	.long	0
	.set	._fftype,subrv2
	.text
	.globl	fftype
fftype:
	cmpl	r7,r1
	jgtr	ftypeerr
	cmpl	r9,r1
	jleq	ftypeerr
	cmpl	r7,r2
	jeql	ftyp1
	movb	r2,ftype(r1)
ftyp1:
	movzbl	ftype(r1),r1
	rsb
ftypeerr:
	movl	.fftype,r2
	jmp	errnaa
	.data
.makunfn:
	.long	0
	.set	._makunfn,subr1
	.text
	.globl	makunfn
makunfn:
	cmpl	r7,r1
	jgtr	makunfner
	cmpl	r9,r1
	jleq	makunfner
	movl	$0,fval(r1)
	movb	$0,ftype(r1)
	rsb
makunfner:
	movl	.makunfn,r2
	jmp	errnna
	.data
.findfn:
	.long	0
	.set	._findfn,subr1
	.text
	.globl	findfn
findfn:
	movl	r1,r2
	movl	hashmax,r4
findfn0:
	movl	*$hashtab[r4],r1
	jmp	findfn4
findfn1:
	movl	fval(r1),r3
	cmpl	r3,r2
	jeql	findfn9
	movl	alink(r1),r1
findfn4:
	cmpl	r7,r1
	jgtr	.1
	cmpl	r9,r1
	jgtr	findfn1
.1:
	sobgeq	r4,findfn0
	movl	r7,r1
findfn9:
	rsb
	.data
.synonym:
	.long	0
	.set	._synonym,subr2
	.text
	.globl	synonym
synonym:
	cmpl	r7,r1
	jgtr	synmerr2
	cmpl	r9,r1
	jleq	synmerr2
	cmpl	r7,r1
	jeql	synmerr2
	cmpl	r7,r2
	jgtr	synmerr1
	cmpl	r9,r2
	jleq	synmerr1
	movl	cval(r2),cval(r1)
	movl	plist(r2),plist(r1)
	movl	fval(r2),fval(r1)
	movzbl	ftype(r2),r3
	movb	r3,ftype(r1)
	movzbl	ptype(r2),r3
	movb	r3,ptype(r1)
	rsb
synmerr1:
	movl	r2,r1
synmerr2:
	movl	.synonym,r2
	jmp	errnaa
	.data
.true:
	.long	0
	.set	._true,subr0
	.text
	.globl	true
true:
	movl	.t,r1
	rsb
	.data
.false:
	.long	0
	.set	._false,subr0
	.text
	.globl	false
false:
	movl	r7,r1
	rsb
	.data
.null:
	.long	0
	.set	._null,subr1
	.text
	.globl	null
null:
	cmpl	r7,r1
	jeql	true
	movl	r7,r1
	rsb
	.data
.not:
	.long	0
	.set	._not,subr1
	.text
	.globl	not
not:
	cmpl	r7,r1
	jeql	true
	movl	r7,r1
	rsb
	.data
.atom:
	.long	0
	.set	._atom,subr1
	.text
	.globl	atom
atom:
	cmpl	r9,r1
	jgtr	true
	movl	r7,r1
	rsb
	.data
.symbolp:
	.long	0
	.set	._symbolp,subr1
	.text
	.globl	symbolp
symbolp:
	cmpl	r7,r1
	jgtr	.2
	cmpl	r9,r1
	jgtr	true
.2:
	movl	r7,r1
	rsb
	.data
.numberp:
	.long	0
	.set	._numberp,subr1
	.text
	.globl	numberp
numberp:
	cmpl	r6,r1
	jgtr	numbpret
	movl	r7,r1
numbpret:
	rsb
	.data
.stringp:
	.long	0
	.set	._stringp,subr1
	.text
	.globl	stringp
stringp:
	cmpl	r6,r1
	jgtr	.3
	cmpl	r7,r1
	jgtr	strgret
.3:
	movl	r7,r1
strgret:
	rsb
	.data
.listp:
	.long	0
	.set	._listp,subr1
	.text
	.globl	listp
listp:
	cmpl	r7,r1
	jeql	true
	cmpl	r9,r1
	jleq	true
	movl	r7,r1
	rsb
	.data
.consp:
	.long	0
	.set	._consp,subr1
	.text
	.globl	consp
consp:
	cmpl	r9,r1
	jleq	true
	movl	r7,r1
	rsb
	.data
.boundp:
	.long	0
	.set	._boundp,subr1
	.text
	.globl	boundp
boundp:
	movl	cval(r1),r2
	cmpl	.undef,r2
	jneq	true
	movl	r7,r1
	rsb
	.data
.eq:
	.long	0
	.set	._eq,subr2
	.text
	.globl	eq
eq:
	cmpl	r2,r1
	jeql	true
	movl	r7,r1
	rsb
	.data
.neq:
	.long	0
	.set	._neq,subr2
	.text
	.globl	neq
neq:
	cmpl	r2,r1
	jneq	true
	movl	r7,r1
	rsb
	.data
.nequal:
	.long	0
	.set	._nequal,subr2
	.text
	.globl	nequal
nequal:
	pushal	not
	jmp	equal
	nop
	.data
.equal:
	.long	0
	.set	._equal,subr2
	.text
	.globl	equal
equal:
	movl	r14,savep
	jsb	equal2
	movl	.t,r1
	rsb
equal1:
	cmpl	r9,r2
	jgtr	equno
	cmpl	r14,mstack
	jleq	errfs
	pushl	cdr(r1)
	movl	car(r1),r1
	pushl	cdr(r2)
	movl	car(r2),r2
	jsb	equal2
	movl	(r14)+,r2
	movl	(r14)+,r1
equal2:
	cmpl	r9,r1
	jleq	equal1
	cmpl	r2,r1
	jeql	equalret
equno:
	movl	savep,r14
	movl	r7,r1
equalret:
	rsb
	.data
.memq:
	.long	0
	.set	._memq,subr2
	.text
	.globl	memq
memq:
	jmp	memq2
memq1:
	movl	car(r2),r3
	cmpl	r1,r3
	jeql	memq3
	movl	cdr(r2),r2
memq2:
	cmpl	r9,r2
	jleq	memq1
memq3:
	movl	r2,r1
	rsb
	.data
.member:
	.long	0
	.set	._member,subr2
	.text
	.globl	member
member:
	jmp	memb2
memb1:
	pushl	r2
	pushl	r1
	movl	car(r2),r2
	jsb	equal
	cmpl	r7,r1
	jneq	memb3
	movl	(r14)+,r1
	movl	(r14)+,r2
	movl	cdr(r2),r2
memb2:
	cmpl	r9,r2
	jleq	memb1
	movl	r2,r1
	rsb
memb3:
	movl	(r14)+,r1
	movl	(r14)+,r1
	rsb
	.data
.last:
	.long	0
	.set	._last,subr1
	.text
	.globl	last
last:
	cmpl	r9,r1
	jgtr	lastret
last1:
	movl	cdr(r1),r2
	cmpl	r9,r2
	jgtr	lastret
	movl	cdr(r2),r1
	cmpl	r9,r1
	jleq	last1
	movl	r2,r1
lastret:
	rsb
	.data
.nth:
	.long	0
	.set	._nth,subr2
	.text
	.globl	nth
nth:
	cmpl	r6,r1
	jleq	ntherr
	jsb	nth2
	movl	car(r1),r1
	rsb
ntherr:
	movl	.nth,r2
	rsb
	.data
.nthcdr:
	.long	0
	.set	._nthcdr,subr2
	.text
	.globl	nthcdr
nthcdr:
	cmpl	r6,r1
	jleq	nthcerr
	jmp	nth2
nth1:
	movl	cdr(r2),r2
nth2:
	cmpl	r9,r2
	jgtr	false
	sobgeq	r1,nth1
	movl	r2,r1
	rsb
nthcerr:
	movl	.nthcdr,r2
	jmp	errnna
	.data
.length:
	.long	0
	.set	._length,subr1
	.text
	.globl	length
length:
	movl	$0,r2
	jmp	lengt2
lengt1:
	movl	cdr(r1),r1
	incl	r2
lengt2:
	cmpl	r9,r1
	jleq	lengt1
	movl	r2,r1
	rsb
	.data
.fcons:
	.long	0
	.set	._fcons,subr2
	.text
	.globl	fcons
fcons:
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r2,cdr(r1)
	rsb
	.data
.fxcons:
	.long	0
	.set	._fxcons,subr2
	.text
	.globl	fxcons
fxcons:
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.fncons:
	.long	0
	.set	._fncons,subr1
	.text
	.globl	fncons
fncons:
	cmpl	r5,r7
	jneq	.6
	jsb	gc
.6:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	rsb
	.data
.mcons:
	.long	0
	.set	._mcons,subrvn
	.text
	.globl	mcons
mcons:
	cmpl	$0,r4
	jeql	false
	movl	(r14)+,r1
	decl	r4
	jmp	mcons2
mcons1:
	movl	(r14)+,r2
	cmpl	r5,r7
	jneq	.7
	jsb	gc
.7:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
mcons2:
	sobgeq	r4,mcons1
	rsb
	.data
.kwote:
	.long	0
	.set	._kwote,subr1
	.text
	.globl	kwote
kwote:
	cmpl	r5,r7
	jneq	.8
	jsb	gc
.8:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	cmpl	r5,r7
	jneq	.9
	jsb	gc
.9:
	movl	r5,r0
	movl	.quote,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.makelist:
	.long	0
	.set	._makelist,subr2
	.text
	.globl	makelist
makelist:
	cmpl	r6,r1
	jleq	makeler
	movl	r7,r3
	jmp	makel3
makel2:
	cmpl	r5,r7
	jneq	.10
	jsb	gc
.10:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r3,cdr(r0)
	movl	r0,r3
makel3:
	sobgeq	r1,makel2
	movl	r3,r1
	rsb
makeler:
	movl	.makelist,r2
	jmp	errnna
	.data
.reverse:
	.long	0
	.set	._reverse,subrv2
	.text
	.globl	reverse
reverse:
	jmp	rev2
rev1:
	movl	car(r1),r3
	movl	cdr(r1),r1
	cmpl	r5,r7
	jneq	.11
	jsb	gc
.11:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
rev2:
	cmpl	r9,r1
	jleq	rev1
	movl	r2,r1
	rsb
	.data
.appnd1:
	.long	0
	.set	._appnd1,subr2
	.text
	.globl	appnd1
appnd1:
	cmpl	r5,r7
	jneq	.12
	jsb	gc
.12:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	jmp	append
	nop
	.data
.append:
	.long	0
	.set	._append,subr2
	.text
	.globl	append
append:
	movl	r7,r3
	cmpl	r5,r7
	jneq	.13
	jsb	gc
.13:
	movl	r3,car(r5)
	movl	r5,r3
	movl	cdr(r5),r5
	movl	r7,cdr(r3)
	pushl	r3
	jmp	appen3
appen2:
	movl	car(r1),r4
	cmpl	r5,r7
	jneq	.14
	jsb	gc
.14:
	movl	r4,car(r5)
	movl	r5,r4
	movl	cdr(r5),r5
	movl	r7,cdr(r4)
	movl	r4,cdr(r3)
	movl	r4,r3
	movl	cdr(r1),r1
appen3:
	cmpl	r9,r1
	jleq	appen2
	cmpl	r9,r2
	jgtr	appen4
	movl	r2,cdr(r3)
appen4:
	movl	(r14)+,r1
	movl	cdr(r1),r1
	rsb
	.data
.remq:
	.long	0
	.set	._remq,subr2
	.text
	.globl	remq
remq:
	jmp	remq4
remq3:
	movl	cdr(r2),r2
remq4:
	cmpl	r9,r2
	jgtr	remq6
	movl	car(r2),r3
	cmpl	r1,r3
	jeql	remq3
	cmpl	r14,mstack
	jleq	errfs
	pushl	r3
	movl	cdr(r2),r2
	jsb	remq
	movl	(r14)+,r3
	cmpl	r5,r7
	jneq	.15
	jsb	gc
.15:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
remq6:
	movl	r2,r1
	rsb
	.data
.remove:
	.long	0
	.set	._remove,subr2
	.text
	.globl	remove
remove:
	jmp	remv4
remv3:
	movl	cdr(r2),r2
remv4:
	cmpl	r7,r2
	jeql	remv6
	movl	car(r2),r3
	cmpl	r1,r3
	jeql	remv3
	cmpl	r14,mstack
	jleq	errfs
	pushl	r3
	movl	cdr(r2),r2
	jsb	remove
	movl	(r14)+,r3
	cmpl	r5,r7
	jneq	.16
	jsb	gc
.16:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
remv6:
	movl	r2,r1
	rsb
	.data
.copy:
	.long	0
	.set	._copy,subr1
	.text
	.globl	copy
copy:
	cmpl	r9,r1
	jgtr	copyret
	cmpl	r14,mstack
	jleq	errfs
	pushl	cdr(r1)
	movl	car(r1),r1
	jsb	copy
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	copy
	movl	(r14)+,r2
	cmpl	r5,r7
	jneq	.17
	jsb	gc
.17:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
copyret:
	rsb
	.data
.subst:
	.long	0
	.set	._subst,subr3
	.text
	.globl	subst
subst:
	cmpl	r7,r3
	jgtr	subst1
	cmpl	r9,r3
	jleq	subst1
	cmpl	r3,r2
	jeql	substret
	movl	r3,r1
substret:
	rsb
subst1:
	cmpl	r14,mstack
	jleq	errfs
	pushl	r1
	pushl	cdr(r3)
	movl	car(r3),r3
	jsb	subst
	movl	(r14)+,r3
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	subst
	movl	(r14)+,r4
	cmpl	r5,r7
	jneq	.18
	jsb	gc
.18:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.substitute:
	.long	0
	.set	._substitute,subr3
	.text
	.globl	substitute
substitute:
	cmpl	r2,r1
	jneq	substt1
	movl	r3,r1
	jmp	copy
substt1:
	cmpl	r14,mstack
	jleq	errfs
	pushl	r1
	movl	r3,r1
	movl	(r14)+,r3
substt2:
	pushl	r1
	pushl	r2
	pushl	r3
	jsb	equal
	movl	(r14)+,r3
	movl	(r14)+,r2
	cmpl	r7,r1
	jeql	substt4
	movl	(r14)+,r1
	movl	r3,r1
substt3:
	rsb
substt4:
	movl	(r14)+,r1
	cmpl	r9,r1
	jgtr	substt3
	pushl	cdr(r1)
	movl	car(r1),r1
	jsb	substt2
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
	jsb	substt2
	movl	(r14)+,r4
	cmpl	r5,r7
	jneq	.19
	jsb	gc
.19:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.oblist:
	.long	0
	.set	._oblist,subrv1
	.text
	.globl	oblist
oblist:
	cmpl	r7,r1
	jneq	oblist5
	movl	hashmax,r3
oblist0:
	movl	*$hashtab[r3],r2
	jmp	oblist3
oblist1:
	cmpl	.undef,r2
	jeql	oblist2
	cmpl	r5,r7
	jneq	.20
	jsb	gc
.20:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
oblist2:
	movl	alink(r2),r2
oblist3:
	cmpl	r7,r2
	jgtr	.21
	cmpl	r9,r2
	jgtr	oblist1
.21:
	sobgeq	r3,oblist0
	rsb
oblist5:
	movl	r7,r1
	movl	hashmax,r3
oblist6:
	movl	*$hashtab[r3],r2
	movl	r7,r4
	jmp	oblist9
oblist7:
	cmpl	.undef,r2
	jeql	oblist8
	cmpl	r5,r7
	jneq	.22
	jsb	gc
.22:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r4,cdr(r0)
	movl	r0,r4
oblist8:
	movl	alink(r2),r2
oblist9:
	cmpl	r7,r2
	jgtr	.23
	cmpl	r9,r2
	jgtr	oblist7
.23:
	cmpl	r5,r7
	jneq	.24
	jsb	gc
.24:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	sobgeq	r3,oblist6
	rsb
	.text
	.data
.rplaca:
	.long	0
	.set	._rplaca,subr2
	.text
	.globl	rplaca
rplaca:
	cmpl	r9,r1
	jgtr	rplaca1
	movl	r2,car(r1)
	rsb
rplaca1:
	movl	.rplaca,r2
	jmp	errnla
	.data
.rplacd:
	.long	0
	.set	._rplacd,subr2
	.text
	.globl	rplacd
rplacd:
	cmpl	r9,r1
	jgtr	rplacd1
	movl	r2,cdr(r1)
	rsb
rplacd1:
	movl	.rplacd,r2
	jmp	errnla
	.data
.rplac:
	.long	0
	.set	._rplac,subr3
	.text
	.globl	rplac
rplac:
	cmpl	r9,r1
	jgtr	rplac1
	movl	r2,car(r1)
	movl	r3,cdr(r1)
	rsb
rplac1:
	movl	.rplac,r2
	jmp	errnla
	.data
.displace:
	.long	0
	.set	._displace,subr2
	.text
	.globl	displace
displace:
	cmpl	r9,r1
	jgtr	displ2
	cmpl	r9,r2
	jgtr	displ1
	movl	car(r2),car(r1)
	movl	cdr(r2),cdr(r1)
	rsb
displ1:
	movl	r2,r1
displ2:
	movl	.displace,r2
	jmp	errnla
	.data
.placdl:
	.long	0
	.set	._placdl,subr2
	.text
	.globl	placdl
placdl:
	cmpl	r9,r1
	jgtr	placd1
	cmpl	r5,r7
	jneq	.25
	jsb	gc
.25:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	movl	r2,cdr(r1)
	movl	r2,r1
	rsb
placd1:
	movl	.placdl,r2
	jmp	errnla
	.data
.setq:
	.long	0
	.set	._setq,subrf
	.text
	.globl	setq
setq:
	jmp	setq2
setq1:
	movl	r2,r1
setq2:
	pushl	car(r1)
	movl	cdr(r1),r1
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r2
	movl	(r14)+,r3
	cmpl	r8,r3
	jgtr	setqerr
	cmpl	r9,r3
	jleq	setqerr
	movl	r1,cval(r3)
	cmpl	r9,r2
	jleq	setq1
	rsb
setqerr:
	movl	r3,r1
	movl	.setq,r2
	jmp	errnva
	.data
.fset:
	.long	0
	.set	._fset,subr2
	.text
	.globl	fset
fset:
	cmpl	r8,r1
	jgtr	seterr1
	cmpl	r9,r1
	jleq	seterr1
	movl	r2,cval(r1)
	movl	r2,r1
	rsb
seterr1:
	movl	.fset,r2
	jmp	errnva
	.data
.setqq:
	.long	0
	.set	._setqq,subrf
	.text
	.globl	setqq
setqq:
	movl	car(r1),r2
	cmpl	r8,r2
	jgtr	setqqerr
	cmpl	r9,r2
	jleq	setqqerr
	movl	cdr(r1),r1
	movl	car(r1),r1
	movl	r1,cval(r2)
	rsb
setqqerr:
	movl	r2,r1
	movl	.setqq,r2
	jmp	errnva
	.data
.psetq:
	.long	0
	.set	._psetq,subrf
	.text
	.globl	psetq
psetq:
	pushl	$mk_subrn
	jmp	psetq2
psetq1:
	pushl	car(r1)
	movl	cdr(r1),r1
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14),r0
	movl	r1,(r14)
	movl	r0,r1
psetq2:
	cmpl	r9,r1
	jleq	psetq1
	jmp	psetq4
psetq3:
	movl	(r14)+,r1
	cmpl	r8,r1
	jgtr	psetqerr
	cmpl	r9,r1
	jleq	psetqerr
	movl	r2,cval(r1)
psetq4:
	movl	(r14)+,r2
	cmpl	$mk_subrn,r2
	jneq	psetq3
	rsb
psetqerr:
	movl	r2,r1
	movl	.psetq,r2
	jmp	errnva
	.data
.nreconc:
	.long	0
	.set	._nreconc,subr2
	.text
	.globl	nreconc
nreconc:
	jmp	frev2
frev1:
	movl	cdr(r1),r3
	movl	r2,cdr(r1)
	cmpl	r9,r3
	jgtr	frevret
	movl	cdr(r3),r2
	movl	r1,cdr(r3)
	cmpl	r9,r2
	jgtr	frev9
	movl	cdr(r2),r1
	movl	r3,cdr(r2)
frev2:
	cmpl	r9,r1
	jleq	frev1
	movl	r2,r1
	rsb
frev9:
	movl	r3,r1
frevret:
	rsb
	.data
.nreverse:
	.long	0
	.set	._nreverse,subr1
	.text
	.globl	nreverse
nreverse:
	movl	r7,r2
	jmp	frev2
	.data
.nextl:
	.long	0
	.set	._nextl,subrf
	.text
	.globl	nextl
nextl:
	movl	car(r1),r2
	cmpl	r8,r2
	jgtr	nextlerr
	cmpl	r9,r2
	jleq	nextlerr
	movl	cval(r2),r3
	movl	car(r3),r1
	movl	cdr(r3),r3
	movl	r3,cval(r2)
	rsb
nextlerr:
	movl	r2,r1
	movl	.nextl,r2
	jmp	errnva
	.data
.newl:
	.long	0
	.set	._newl,subrf
	.text
	.globl	newl
newl:
	pushl	car(r1)
	movl	cdr(r1),r1
	jsb	evalcar
	movl	(r14)+,r2
	cmpl	r8,r2
	jgtr	newlerr
	cmpl	r9,r2
	jleq	newlerr
	movl	cval(r2),r3
	cmpl	r5,r7
	jneq	.26
	jsb	gc
.26:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r3,cdr(r1)
	movl	r1,cval(r2)
	rsb
newlerr:
	movl	r2,r1
	movl	.newl,r2
	jmp	errnva
	.data
.nconc1:
	.long	0
	.set	._nconc1,subr2
	.text
	.globl	nconc1
nconc1:
	cmpl	r5,r7
	jneq	.27
	jsb	gc
.27:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	jmp	nconc
	nop
	.data
.nconc:
	.long	0
	.set	._nconc,subr2
	.text
	.globl	nconc
nconc:
	cmpl	r9,r1
	jleq	nconc2
	movl	r2,r1
	rsb
nconc2:
	pushl	r1
	jmp	nconc4
nconc3:
	movl	r3,r1
nconc4:
	movl	cdr(r1),r3
	cmpl	r9,r3
	jleq	nconc3
	movl	r2,cdr(r1)
	movl	(r14)+,r1
	rsb
geti:
	movl	plist(r1),r4
	movl	r1,r3
	jmp	geti3
geti2:
	cmpl	car(r4),r2
	jeql	getiret
	movl	cdr(r4),r3
	movl	cdr(r3),r4
geti3:
	cmpl	r9,r4
	jleq	geti2
getiret:
	rsb
	.data
.get:
	.long	0
	.set	._get,subr2
	.text
	.globl	get
get:
	jmp	getprop
	nop
	.data
.getprop:
	.long	0
	.set	._getprop,subr2
	.text
	.globl	getprop
getprop:
	cmpl	r7,r1
	jgtr	geterr
	cmpl	r9,r1
	jleq	geterr
	cmpl	r7,r1
	jeql	geterr
	jsb	geti
	cmpl	r9,r4
	jgtr	false
	movl	cdr(r4),r4
	movl	car(r4),r1
	rsb
geterr:
	movl	.getprop,r2
	jmp	errnaa
	.data
.getl:
	.long	0
	.set	._getl,subr2
	.text
	.globl	getl
getl:
	cmpl	r7,r1
	jeql	getlerr
	cmpl	r7,r1
	jgtr	getlerr
	cmpl	r9,r1
	jleq	getlerr
	cmpl	r7,r2
	jeql	false
	cmpl	r9,r2
	jgtr	getlerr2
	movl	plist(r1),r1
	jmp	getl7
getl1:
	movl	car(r1),r3
	pushl	r2
getl2:
	movl	car(r2),r4
	cmpl	r4,r3
	jeql	getl8
	movl	(r14)+,r2
	movl	cdr(r2),r2
	cmpl	r9,r2
	jleq	getl2
	movl	(r14)+,r2
	movl	cdr(r1),r1
	movl	cdr(r1),r1
getl7:
	cmpl	r9,r1
	jleq	getl1
	rsb
getl8:
	movl	(r14)+,r2
	rsb
getlerr:
	movl	.getl,r2
	jmp	errnaa
getlerr2:
	movl	r2,r1
	movl	.getl,r2
	jmp	errnla
	.data
.addprop:
	.long	0
	.set	._addprop,subr3
	.text
	.globl	addprop
addprop:
	cmpl	r7,r1
	jeql	addpret
	cmpl	r7,r1
	jgtr	addpret
	cmpl	r9,r1
	jleq	addpret
	movl	plist(r1),r4
	cmpl	r5,r7
	jneq	.28
	jsb	gc
.28:
	movl	r5,r0
	movl	r2,car(r5)
	movl	cdr(r5),r5
	movl	r4,cdr(r0)
	movl	r0,r4
	cmpl	r5,r7
	jneq	.29
	jsb	gc
.29:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r4,cdr(r0)
	movl	r0,r4
	movl	r4,plist(r1)
	rsb
addpret:
	movl	.addprop,r2
	jmp	errnaa
	.data
.putprop:
	.long	0
	.set	._putprop,subr3
	.text
	.globl	putprop
putprop:
	cmpl	r7,r1
	jeql	putperr
	cmpl	r7,r1
	jgtr	putperr
	cmpl	r9,r1
	jleq	putperr
	pushl	r1
	pushl	r2
	pushl	r3
	movl	r3,r2
	jsb	remprop
	movl	(r14)+,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	jmp	addprop
putperr:
	movl	.putprop,r2
	jmp	errnaa
	.data
.defprop:
	.long	0
	.set	._defprop,subrf
	.text
	.globl	defprop
defprop:
	cmpl	r7,r1
	jeql	defperr
	cmpl	r7,r1
	jgtr	defperr
	cmpl	r9,r1
	jleq	defperr
	movl	cdr(r1),r4
	movl	car(r1),r1
	movl	car(r4),r2
	movl	cdr(r4),r3
	movl	car(r3),r3
	jmp	putprop
defperr:
	movl	.defprop,r2
	jmp	errnaa
	.data
.remprop:
	.long	0
	.set	._remprop,subr2
	.text
	.globl	remprop
remprop:
	cmpl	r7,r1
	jeql	remperr
	cmpl	r7,r1
	jgtr	remperr
	cmpl	r9,r1
	jleq	remperr
	jsb	geti
	cmpl	r9,r4
	jgtr	false
	movl	cdr(r4),r2
	movl	cdr(r2),r2
	cmpl	r9,r2
	jgtr	rempr4
	movl	car(r2),r3
	movl	r3,car(r4)
	movl	cdr(r2),r3
	movl	r3,cdr(r4)
	rsb
rempr4:
	movl	r7,cdr(r3)
	rsb
remperr:
	movl	.remprop,r2
	jmp	errnaa
	.data
.acons:
	.long	0
	.set	._acons,subr3
	.text
	.globl	acons
acons:
	pushl	r3
	cmpl	r5,r7
	jneq	.30
	jsb	gc
.30:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r2,cdr(r1)
	movl	(r14)+,r2
	cmpl	r5,r7
	jneq	.31
	jsb	gc
.31:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r2,cdr(r1)
	rsb
	.data
.assq:
	.long	0
	.set	._assq,subr2
	.text
	.globl	assq
assq:
	cmpl	r9,r2
	jgtr	assq2
	movl	r1,r3
assq1:
	movl	car(r2),r1
	movl	car(r1),r4
	cmpl	r3,r4
	jeql	assqret
	movl	cdr(r2),r2
	cmpl	r9,r2
	jleq	assq1
assq2:
	movl	r7,r1
assqret:
	rsb
	.data
.assoc:
	.long	0
	.set	._assoc,subr2
	.text
	.globl	assoc
assoc:
	jmp	asso8
asso1:
	movl	car(r2),r3
	pushl	r1
	pushl	r2
	pushl	r3
	movl	car(r3),r2
	jsb	equal
	cmpl	r7,r1
	jneq	asso9
	movl	(r14)+,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	movl	cdr(r2),r2
asso8:
	cmpl	r9,r2
	jleq	asso1
	movl	r7,r1
	rsb
asso9:
	movl	(r14)+,r1
	movl	(r14)+,r3
	movl	(r14)+,r3
	rsb
	.data
.cassq:
	.long	0
	.set	._cassq,subr2
	.text
	.globl	cassq
cassq:
	jmp	cassq2
cassq1:
	movl	car(r2),r3
	movl	car(r3),r4
	cmpl	r1,r4
	jeql	cassq3
	movl	cdr(r2),r2
cassq2:
	cmpl	r9,r2
	jleq	cassq1
	movl	r7,r1
	rsb
cassq3:
	movl	cdr(r3),r1
	rsb
	.data
.cassoc:
	.long	0
	.set	._cassoc,subr2
	.text
	.globl	cassoc
cassoc:
	jmp	casso8
casso1:
	movl	car(r2),r3
	pushl	r1
	pushl	r2
	pushl	r3
	movl	car(r3),r2
	jsb	equal
	cmpl	r7,r1
	jneq	casso9
	movl	(r14)+,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	movl	cdr(r2),r2
casso8:
	cmpl	r9,r2
	jleq	casso1
	movl	r7,r1
	rsb
casso9:
	movl	(r14)+,r1
	movl	cdr(r1),r1
	movl	(r14)+,r3
	movl	(r14)+,r3
	rsb
