;=================================================================
;
;    Le_Lisp  80   :   PEPE   -   PEPEND
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
;-----	 Le recuperateur de l'espace de PEPE
 
(df =pend ()
    (mapc 'remfn
	    '(
	    =pdisp =ppr =pllength pklbreak
	    pkljoin pklchar pklcharn  pklinschar
	    pkldelchar pklimplode pklexplode	     ; dans PEPLN2
 
	    deadend currentline cursor
	    redisplayhome redisplay
	    bolp eolp bobp eobp bosp eosp	     ; dans PEPMSC
 
	    left right endline up down
	    insertchar deletechar breakline
	    joinlines killline			    ; dans PEPCMD
 
	    =pepe				    ; dans PEPTOP
 
	))
      (mapc (lambda (f) (set f ()))
	    '(-buf -cmds))
 
      (=autl pepe =pepe =pend)
      ())
 

