;=====================================================================
;
;    Logo-Lisp	:   LOGOLECT	    le lecteur Logo
;
;=====================================================================
;    1983     Isabelle BORNE  et  Universite PARIS VI
;	      2  place Jussieu	  75005 PARIS
;=====================================================================
 
(de *llect ()
   (teread)
   (*readl))
 
(de *readl ()
  (let ((*i -1) (*c) (*n 0))
     (flet ((bol ()
		 (*l-err nil 'ersxt)))
	   (tyo (explode (prompt)))
	   (inbuf (incr *i) '#/()
	   (untilexit return
	      (setq *c (tyi))
	      (selectq *c
		(13 (exit return))
		 ;pour <- et EFF CAR
		((127 8)
		   (when (> *i 0)
			 (selectq (inbuf *i)
			     (40 (decr *n))
			     (41 (incr *n)))
			 (tyo 8 32 8) (decr *i)))
		(t (if (= *c 40) (incr *n)
		       (if (= *c 41) (decr *n)))
		   (inbuf (incr *i) *c) (tyo *c))))
	   (tyo 13 10)
	   (inbuf (incr *i) '#/))
	   (inbuf (incr *i) 13)
	   (inpos 0)
	   (inmax (1+ *i))
	   (if (<> *n 0) (*l-err nil 'ersxt)
	       (read))	)))
 

