  xrefoff
 ttl 'fast floating point demo program'
***************************************
* (c) copyright 1981 by motorola inc. *
***************************************
 
***************************************************
* this is a demo of the 68343 fast floating point *
***************************************************
 
* ?          opt       frs
 
 extern      ffpsqrt  external routines
 extern      ffpadd,ffpdiv,ffpmul
 extern      ffpsincs
 extern      ffpafp,ffpfpa
 extern  _write,_exit
 
 entry      ffpdemo,_main
 
 
_main   equ  *
ffpdemo equ  *
         bsr       msg                 blank line at first
         dc.l      '        '          blank line
         lea       hello,a0            setup start message
         lea       helloe,a1           end of msg
         bsr       put                 put this out
         lea       hello2,a0           second message
         lea       hello2e,a1          end of msg
         bsr       put                 put copyright out
         bsr       msg                 another blank now
         dc.l      '        '          blank line
 
         lea       asciipi,a0          convert pi to float
	 jsr       ffpafp
         move.l    d7,d0               save pi in d0
 
         lea       asciie,a0           convert 'e' to float
	 jsr       ffpafp
         move.l    d7,d1               save e in d1
 
*****************
* addition demo *
*****************
 
         lea       msgadd,a0 point to message
         lea       msgadde,a1 point to end
         bsr       put       send to console
 
         move.w    #50000,d2           save loop count
         move.l    d0,d6               move pi
 
addloop  move.l    d1,d7               reload e
	 jsr       ffpadd              perform add
         dbra      d2,addloop
 
         bsr       result              display result
 
 
*****************
* multiply demo *
*****************
 
         lea       msgmul,a0 point to message
         lea       msgmule,a1 and end
         bsr       put send to console
 
         move.w    #50000,d2 setup loop count
         move.l    d0,d6     setup pi
 
mulloop  move.l    d1,d7     setup e
	 jsr       ffpmul    perform multiply
         dbra      d2,mulloop loop until done
 
	 bsr       result    display result
 
***************
* divide demo *
***************
 
         lea       msgdiv,a0 point to message
         lea       msgdive,a1 and end
         bsr       put send to console
 
         move.w    #50000,d2 setup loop count
         move.l    d0,d6     setup pi
 
divloop  move.l    d1,d7     setup e
	 jsr       ffpdiv    perform divide
         dbra      d2,divloop loop until done
 
         bsr.s     result    display result
 
********************
* square root demo *
********************
 
         lea       msgsqr,a0 point to message
         lea       msgsqre,a1 and end
         bsr       put send to console
 
         move.w    #20000,d2 setup loop count
 
sqrloop  move.l    d0,d7     setup pi
	 jsr       ffpsqrt   perform square root
         dbra      d2,sqrloop loop until done
 
         bsr.s     result    display result
 
************************
* sine and cosine demo *
************************
 
         lea       msgsin,a0 point to message
         lea       msgsine,a1 and end
         bsr.s     put send to console
 
         move.w    #10000,d2 setup loop count
 
sinloop  move.l    d1,d7     setup e
	 jsr       ffpsincs  perform sine and cosine
         dbra      d2,sinloop loop until done
 
         bsr.s     result    display cosine
         move.l    d6,d7     also display sine
         bsr.s     result    as well
 
************
* end test *
************
quit     bsr.s     msg       issue done message
         dc.l      '  done  '
         bsr.s     msg       and final blank line
         dc.l      '        '
	 moveq     #0,d0    setup exit task code
**       trap      #1        here
	 jsr  _exit
 
 
*   *
*   * result display subroutine
*   *   input is float in d7
*   *
result   jsr       ffpfpa
         move.l    #'lt: ',-(a7)   move result header
         move.l    #'resu',-(a7)   onto stack
         lea       (a7),a0   point to message
	 lea       14+8(a7),a1 point to end of message
         bsr.s     put       issue to console
         lea       14+8(a7),a7         get rid of conversion and heading
         bsr.s     msg       put blank line out
         dc.l      '        '
         rts                 return to caller
 
 
*   *
*   * msg subroutine
*   *  input: (sp) point to eight byte text following bsr/jsr
*   *
msg      movem.l   d0/a0/a1,-(a7) save regs
         move.l    3*4(a7),a0 load return pointer
         lea       7(a0),a1   point to buffer end
         bsr.s     put       issue ios call
         movem.l   (a7)+,d0/a0/a1 reload registers
         addi.l     #8,(a7)   adjust return address
         rts                 return to caller
 
*   *
*   * put subroutine
*   *  input: a0->text start, a1->text end
*   *
put     movem.l   d0-d3/a0-a3,-(a7) save regs
 suba.l a0,a1
 move   a1,-(a7)
 move.l a0,-(a7)
 move   #1,-(a7)

 jsr    _write
 addq   #8,a7
 move   #1,-(a7)
 pea    nl
 move   #1,-(a7)
 jsr    _write
 addq   #8,a7
	movem.l   (a7)+,d0-d3/a0-a3  reload registers
	rts                 return to caller
nl  dc.b  $0a

**              movem.l   a0-a1,bufptr setup buffer pointers
**              suba.l     a0,a1     compute length-1
**              lea       1(a1),a1  add one
**              move.l    a1,buflen insert length
**              move.b    #6,device to output stream
**              move.b    #2,iosblk+1 and write function
**              lea       iosblk,a0  load block address
**              trap      #2        issue ios call
 
**        data
**      * ios block for terminal formated send
**      iosblk   dc.b     0,2,0,0    write formatted wait
**               dc.b     0
**      device   dc.b     0,0,0
**               dc.l     0
**      bufptr   dc.l      0,0
**      buflen   dc.l      0,0
 
* pi and e ascii constants
asciipi  dc.b      '+3.1415926535897 '
asciie   dc.b      '+2.718281828459045 '
 
* messages for the demo parts
hello    dc.w      'motorola mc68000 fast floating point demo'
helloe   dc.b      0
 
hello2   dc.w      '     (c) copyright 1981 by motorola'
hello2e  dc.b      0
 
	 ds.w  0
msgadd   dc.b      'fifty thousand additions of '
	 dc.b      '3.14159265 to 2.718281828'
msgadde  dc.b      0
 
	 ds.w  0
msgmul   dc.b      'fifty thousand multiplies of '
	 dc.b      '3.14159265 with 2.718281828'
msgmule  dc.b      0
 
	 ds.w  0
msgdiv   dc.b      'fifty thousand divides of '
	 dc.b      '3.14159265 into 2.718281828'
msgdive  dc.b      0
 
msgsqr   dc.w      'twenty thousand square roots of 3.14159265'
msgsqre  dc.b      0
 
msgsin   dc.w      'ten thousand cosines and sines of 2.718281828'
msgsine  dc.b      0,0
 
 
         end       ffpdemo
