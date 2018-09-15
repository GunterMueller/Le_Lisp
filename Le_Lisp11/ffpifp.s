  nolist 
  xrefoff
 ttl 'fast floating point integer to float (ffpifp)'
************************************
* (c) copyright 1980 motorla inc.  *
************************************
 
***********************************************************
*               integer to floating point                 *
*                                                         *
*      input: d7 = fixed point integer (2's complement)   *
*      output: d7 = fast floating point equivalent        *
*                                                         *
*      condition codes:                                   *
*                n - set if result is negative            *
*                z - set if result is zero                *
*                v - cleared                              *
*                c - undefined                            *
*                x - undefined                            *
*                                                         *
*      d5 is destroyed                                    *
*                                                         *
*      integers of greater than 24 bits will be rounded   *
*      and imprecise.                                     *
*                                                         *
*      code size: 56 bytes      stack work area: 0 bytes  *
*                                                         *
*      timings: (8mhz no wait states assumed)             *
*         composite averate 31.75 microseconds            *
*            arg = 0   4.25          microseconds         *
*            arg > 0   13.75 - 47.50 microseconds         *
*            arg < 0   15.50 - 50.25 microseconds         *
*                                                         *
***********************************************************


 entry    ffpifp      external name
 extern    ffpcpyrt    copyright notice
 
*ffpifp idnt    1,1  ffp integer to float
 
 
ffpifp   move.l  #64+31,d5  setup high end exponent
         tst.l   d7         Q integer a zero
         beq.s   itortn     return same result if so
         bpl.s   itopls     branch if positive integer
         move.l  #-32,d5    setup negative high exponent -#80+64+32
         neg.l   d7         find positive value
         bvs.s   itorti     branch maximum negative number
         subi.b   #1,d5       adjust for extra zero bit
itopls   cmpi.l     #$00007fff,d7 Q possible 17 bits zero
         bhi.s     itolp     branch if not
         swap    d7        quick shift by swap
         subi.b     #16,d5    deduct 16 shifts from exponent
itolp    add.l   d7,d7      shift mantissa up
         dbmi    d5,itolp   loop until normalized
         tst.b     d7        Q test for round up
         bpl.s     itorti    branch no rounding needed
         addi.l     #$100,d7  round up
         bcc.s     itorti    branch no overflow
         roxr.l    #1,d7     adjust down one bit
         addi.b     #1,d5     reflect right shift in exponent bias
itorti   move.b  d5,d7      insert sign/exponent
itortn   rts                return to caller
 
         end
