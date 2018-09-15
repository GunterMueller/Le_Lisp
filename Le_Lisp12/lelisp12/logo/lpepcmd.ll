;=================================================================
;
;   Le_Lisp  80   :   PEPE   -	PEPCMD	les commandes de PEPE
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
(de  =l ()
     ; un coup a gauche
     (ifn (=0 -xcr)
	  (decr -xcr)
	  (=u)
	  (setq -xcr (=lencurln))))
 
(de  =r ()
     ; un coup a droite
     (ifn (=eolp)
	  (incr -xcr)
	  (=d)
	  (setq -xcr 0)))
 
(de  =u ()
     ; va la ligne precedente
     (if (=0 (+ -ydisp -ycr))
	 (=dend)
	 (ifn (=0 -ycr)
	      (decr -ycr)
	      (decr -ydisp 6)
	      (incr -ycr 5)
	      (=redisp))
	 (setq -xcr (min -xcr (=lencurln)))))
 
(de  =d ()
     ; va a la ligne suivante
     (if (=eobp)
	 (=dend)
	 (ifn (>= -ycr #.(1- -ym))
	      (incr -ycr)
	      (incr -ydisp 6)
	      (decr -ycr 5)
	      (=redisp))
	 (setq -xcr (min -xcr (=lencurln)))))
 
(de  =insch (c)
     ; rajoute le caractere "c" a la position courante
     (let ((n (=lencurln)))
	  (cond
	     ((>= n -xm) (=dend))
	     ((=0 n)	 (rplaca (nthcdr (+ -ydisp -ycr) -buf)
				 [c]))
	     (t 	 (=pinsch (=curln) -xcr c)))
	  #.(if (=tinsch 12)
		'(=tinsch c)
		'(tyo (nthcdr -xcr (=curln))))
	  (incr -xcr)))
 
(de  =delch ()
     ; enleve le caractere a la position du curseur
     (if (=eolp)
	 (=jlns)
	 (=pdelch (=curln) -xcr)
	 #.(if (=tdelch)
	       '(=tdelch)
	       '(tyo (nthcdr -xcr (=curln)) 32))))
 
(de  =brln ()
     ; casse la ligne a la position du curseur
     (let ((l (nthcdr (+ -ycr -ydisp) -buf)))
	  (ifn (=eolp)
	       (let ((l1 (=pbr (car l) -xcr)))
		    (rplac l (car l1) (cons (cdr l1) (cdr l))))
	       (if (=eobp)
		   (nconc -buf [()])
		   (rplacd l (cons () (cdr l)))))
	  (=redisp -ycr)))
 
(de  =jlns ()
     ; accroche la ligne suivante a la courante
     (let ((l (nthcdr (+ -ycr -ydisp) -buf)))
	  (rplac l (nconc (car l) (cadr l)) (cddr l))
	  (=redisp -ycr)))
 

