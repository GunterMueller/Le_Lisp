all: macro motmit lelisp

macro: macro.c
	cc -o macro macro.c

motmit: motmit.c
	cc -o motmit motmit.c

lelisp: lelisp ll68k.o llinit.o toperr.o gc.o physio.o read.o print.o \
		eval.o cntrl.o carcdr.o fntsd.o nbstrs.o bllsht.o
	ld68 -T 20000 -e ll68k -x -n ll68k.o llinit.o toperr.o gc.o physio.o read.o print.o \
		eval.o cntrl.o carcdr.o fntsd.o nbstrs.o bllsht.o -lnc -o lelisp
	bconv lelisp

ll68k.o: llunix.sa rtllm3.sa
	cat macros.sa llunix.sa rtllm3.sa >ll68k.sa
	<ll68k.sa macro >ll68k.ss
	<ll68k.ss motmit>ll68k.s
	a68 ll68k.s

llinit.o: llinit.llm3
	cat macros.sa llinit.llm3 | macro | motmit | sed -f script >llinit.s
	a68 llinit.s

toperr.o: toperr.llm3
	cat macros.sa toperr.llm3 | macro | motmit | sed -f script >toperr.s
	a68 toperr.s

gc.o: gc.llm3
	cat macros.sa macgc.sa gc.llm3 | macro | motmit | sed -f script>gc.s
	a68 gc.s

physio.o: physio.llm3
	cat macros.sa macio.sa physio.llm3 | macro | motmit | sed -f script>physio.s
	a68 physio.s

read.o: read.llm3
	cat macros.sa read.llm3 | macro | motmit | sed -f script>read.s
	a68 read.s

print.o: print.llm3
	cat macros.sa macio.sa print.llm3 | macro | motmit | sed -f script>print.s
	a68 print.s

eval.o: eval1.llm3 eval2.llm3
	cat macros.sa eval[12].llm3 | macro | motmit | sed -f script>eval.s
	a68 eval.s

cntrl.o: cntrl.llm3
	cat macros.sa cntrl.llm3 | macro | motmit | sed -f script>cntrl.s
	a68 cntrl.s

carcdr.o: carcdr.llm3
	cat macros.sa carcdr.llm3 | macro | motmit | sed -f script>carcdr.s
	a68 carcdr.s

fntsd.o: fntsd1.llm3 fntsd2.llm3
	cat macros.sa fntsd[12].llm3 | macro | motmit | sed -f script>fntsd.s
	a68 fntsd.s

nbstrs.o: nbstrs.llm3
	cat macros.sa nbstrs.llm3 | macro | motmit | sed -f script>nbstrs.s
	a68 nbstrs.s

bllsht.o: bllsht.llm3
	cat macros.sa bllsht.llm3 | macro | motmit | sed -f script>bllsht.s
	a68 bllsht.s



