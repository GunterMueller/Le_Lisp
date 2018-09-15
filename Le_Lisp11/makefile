all: macvax lelisp

macvax: macvax.c
	cc -o macvax macvax.c

lelisp: lelisp o/llvax.o o/llinit.o o/toperr.o o/gc.o o/physio.o o/read.o o/print.o o/eval.o o/cntrl.o o/carcdr.o o/fntstd.o o/nbstrs.o o/bllsht.o
	ld -n -X  o/llvax.o o/llinit.o o/toperr.o o/gc.o o/physio.o o/read.o o/print.o o/eval.o o/cntrl.o o/carcdr.o o/fntstd.o o/nbstrs.o o/bllsht.o -lc -o lelisp

o/llvax.o: llvax.sa rtllm3.sa
	as -o o/llvax.o llvax.sa rtllm3.sa

o/llinit.o: llm3/llinit.llm3
	(cat macros.sa llm3/llinit.llm3 | macvax) >s/llinit.s
	as -o o/llinit.o s/llinit.s

o/toperr.o: llm3/toperr.llm3
	(cat macros.sa llm3/toperr.llm3 | macvax) >s/toperr.s
	as -o o/toperr.o s/toperr.s

o/gc.o: llm3/gc.llm3 macgc.sa
	(cat macros.sa macgc.sa llm3/gc.llm3 | macvax) >s/gc.s
	as -o o/gc.o  s/gc.s

o/physio.o: llm3/physio.llm3 macio.sa
	(cat macros.sa macio.sa llm3/physio.llm3 | macvax) >s/physio.s
	as -o o/physio.o s/physio.s

o/read.o: llm3/read.llm3
	(cat macros.sa llm3/read.llm3 | macvax) >s/read.s
	as -o o/read.o s/read.s

o/print.o: llm3/print.llm3
	(cat macros.sa macio.sa llm3/print.llm3 | macvax) >s/print.s
	as -o o/print.o s/print.s

o/eval.o: llm3/eval1.llm3 llm3/eval2.llm3
	(cat macros.sa llm3/eval[12].llm3 | macvax) >s/eval.s
	as -o o/eval.o s/eval.s

o/cntrl.o: llm3/cntrl.llm3
	(cat macros.sa llm3/cntrl.llm3 | macvax) >s/cntrl.s
	as -o o/cntrl.o s/cntrl.s

o/carcdr.o: llm3/carcdr.llm3
	(cat macros.sa llm3/carcdr.llm3 | macvax) >s/carcdr.s
	as -o o/carcdr.o s/carcdr.s

o/fntstd.o: llm3/fntsd1.llm3 llm3/fntsd2.llm3
	(cat macros.sa llm3/fntsd[12].llm3 | macvax) >s/fntstd.s
	as -o o/fntstd.o s/fntstd.s

o/nbstrs.o: llm3/nbstrs.llm3
	(cat macros.sa llm3/nbstrs.llm3 | macvax) >s/nbstrs.s
	as -o o/nbstrs.o s/nbstrs.s

o/bllsht.o: llm3/bllsht.llm3
	(cat macros.sa llm3/bllsht.llm3 | macvax) >s/bllsht.s
	as -o o/bllsht.o s/bllsht.s

