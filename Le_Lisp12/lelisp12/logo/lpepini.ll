;=================================================================
;
;   Le_Lisp  80   :   PEPE   -	PEPINI	initialisation des cles
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
;-----	Initialisation des variables globales
 
(setq -cmds ())
 
(df f (k . f)
      (newl -cmds
	    (cons (eval k) (if (symbolp (car f))
			       (car f)
			       f))))
 
(progn
 
; -- les mouvements du curseur
  (f  -l   =l)
  (f  -r   =r)
  (f  -d   =d)
  (f  -u   =u)
 
; -- "VALIDE" et "DEL-CAR"
  (f  #^M  (=brln) (=r))
  (f  #$7F (=l) (fixecurseur -ycr -xcr) (=delch))
 
; -- "F1" : le panneau d'aide
  (f  #^A  (ifn (input '|LPEPHLP LL |)
		(input)
		(vt)
		(untilexit eof (tyo (readcn)))
		(input)
		(until (tyi))
		(=redisp)))
 
; -- "F3" : pour sortir sans sauvegarde
  (f  #^C  (fixecurseur (min -ym (- (length -buf) -ydisp)) 0)
	   (=tcleos)
	   (setq -buf ())
	   (exit =pepe))
 
; -- "SORTIE" : evaluation de tout le tampon et sortie de PEPE
  (f  27   (let ((f -buf))
		(fixecurseur (min -ym
			       (- (length -buf) -ydisp)) 0)
		(=tcleos)
		(flet ((*readl () (read))
		       (bol ()
			    (ifn f
				 (exit eoc)
				 (let ((l (nextl f)) (n -1))
				      (ifn l
					   (bol)
					   (inbuf (incr n) '#/( )
					   (while l (inbuf (incr n) (nextl l)))
					   (inbuf (incr n) 13)
					   (inbuf (incr n) 10)
					   (inbuf (incr n) '#/) )
					   (inmax (1+ n)))))))
		      (untilexit eoc
			     (*l-eval (read))))
		(setq -buf ())
		(exit =pepe)))
)
 
; -- on libere un peu de place
(remfn 'f)
 

