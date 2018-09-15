  nolist 
  xrefoff
 ttl 'fast floating point float to integer (ffpfpi)'
**************************************
* (c) copyright 1980 by motorla inc. *
**************************************
 
***********************************************************
*            fast floating point to integer               *
*                                                         *
*      input:  d7 = fast floating point number            *
*      output: d7 = fixed point integer (2's complement)  *
*                                                         *
*  condition codes:                                       *
*             n - set if result is negative               *
*             z - set if result is zero                   *
*             v - set if overflow occurred                *
*             c - undefined                               *
*             x - undefined                               *
*                                                         *
*  register d5 is destroyed                               *
*                                                         *
*  integers of over 24 bit precision will be imprecise    *
*                                                         *
*  note: maximum size integer returned if overflow        *
*                                                         *
*   code size: 78 bytes        stack work area: 0 bytes   *
*                                                         *
*      timings:  (8 mhz no wait states assumed)           *
*           composite average 15.00 microseconds          *
*            arg = 0   4.75 microseconds                  *
*            arg # 0   10.50 - 18.25 microseconds         *
*                                                         *
***********************************************************


 entry      ffpfpi     entry point
 extern      ffpcpyrt   copyright notice
 
*ffpfpi  idnt      1,1  ffp float to integer
 
 
ffpfpi  move.b    d7,d5          save sign/exponent                4
        bmi.s     fpimi          branch if minus value             8/10
        beq.s     fpirtn         return if zero                    8/10
        clr.b     d7             clear for shift                   4
        subi.b     #65,d5         exponent-1 to binary              8
        bmi.s     fpirt0         return zero for fraction          8/10
        subi.b     #31,d5         Q overflow                        8
        bpl.s     fpiovp         branch if too large               8/10
        neg.b     d5             adjust for shift                  4
        lsr.l     d5,d7          finalize integer                  8-70
fpirtn  rts                      return to caller                  16
 
* positive overflow
fpiovp  moveq     #-1,d7         load all ones
        lsr.l     #1,d7          put zero in as sign
*       or.b      #$02,ccr       set overflow bit on
        dc.l      $003c0002     ****sick assembler****
        rts                      return to caller
 
* fraction only returns zero
fpirt0  move.l    #0,d7          return zero
        rts                      back to caller
 
* input is a minus integer
fpimi   clr.b     d7             clear for clean shift                 4
        subi.b     #$80+65,d5     exponent-1 to binary and strip sign   8
        bmi.s     fpirt0         return zero for fraction              8/10
        subi.b     #31,d5         Q overflow                            8
        bpl.s     fpichm         branch possible minus overflow        8/10
        neg.b     d5             adjust for shift count                4
        lsr.l     d5,d7          shift to proper magnitude             8-70
        neg.l     d7             to minus now                          6
        rts                      return to caller                      16
 
* check for maximum minus number or minus overflow
fpichm  bne.s     fpiovm         branch minus overflow
        neg.l     d7             attempt convert to negative
        tst.l     d7             clear overflow bit
        bmi.s     fpirtn         return if maximum negative integer
fpiovm  move.l    #0,d7          clear d7
	bset      #31,d7         set high bit on for maximum negative    QQ
*       or.b      #$02,ccr       set overflow bit on
        dc.l      $003c0002      ****sick assembler****
        rts                      and return to caller
 
        end
