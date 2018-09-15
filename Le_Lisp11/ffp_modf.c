typedef long ff; /*  fast floating   mantissa :24   sign :1   exp+64 :7  */
union float_ff { 
	float asfloat;
	long  aslong;
};
#define  reg  register

float  modf( val, intpart ) /*  12.3  ->  12.0  +  0.3   in *intpart, ret  */
union float_ff val;  
reg ff* intpart;
{       
	reg long  f  = val.aslong,   e;

	if( e = f & 0x7f )  e -= 64;
	if( e <= 0 ){
		*intpart = 0;  
		return  val .asfloat; 
	}
	if( e >= 24 ){
		*intpart = f;  
		return  0.0; 
	}

	*intpart = f & (( 0x80000000 >> ( e - 1 )) /*  e bits from mantissa */
	    + 0x000000ff);
	return  val .asfloat - (*intpart) .asfloat; /*  12.3 - 12.0  = 0.3  */
}


ff  frexp( f, exp ) /*  split f = fraction * 2^exp  */
reg ff f;  
reg int* exp;
{       
	reg long e;
	if( e = f & 0x7f )  e -= 64;
	*exp = e;       /*  e.g.  f = 800000 46         */
	return  f - e;  /*          = 800000 40  * 2^6  */
}


ff  ldexp( f, exp ) /*  f * 2^exp  */
reg ff f;  
reg int exp;
{       
	reg long e;
	e = (f & 0x7f) + exp;
	if( e < 0   || f == 0 )
		return  0;
	if( e > 127 )
		return  (f & 0x80) + 0xffffff7f; /*  +- maxfloat  */
	return  f + exp;
}
