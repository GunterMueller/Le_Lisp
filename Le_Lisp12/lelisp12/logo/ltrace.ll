(bind ((typecn 47 1)(typecn 59 2)(typecn 39 5)(typecn 94 5)(typecn 35 7)
       (typecn 43 8)(typecn 45 8)(typecn 42 8)(typecn 92 8)(typecn 64 8)
       (typecn 62 8)(typecn 60 8)(typecn 61 8)(typecn 46 9))
      (untilexit eof (eval (read))))
;=================================================================
;
;		Le_Lisp  80   :   TRACE et UNTRACE
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
;	1983	I.Borne  adaptation pour LOGO
;=================================================================
 
;_____	 La variable globale trace contient la liste des fonctions tracees
 
(setq trace ())
 
;-----	 Les fonctions de tracage
 
 
(df trace *l
    ; trace la liste de fonctions '*l
       (mapc (lambda (f)
	     (let ((fval (valfn f)))
		  (ifn (typefn f)
		       (print '|je ne connais pas | f)
		       (putprop f fval 'trace)
		       (unless (memq f trace) (newl trace f))
		       (valfn f
			      [(car fval)
				 ['prin (kwote f) ''| ---> | ]
				 ['mapc (lambda (trace)
					  (prin trace '| = |
						(cval trace) '|  |))
					  (kwote (flat (car fval))) ]
				 '(terpri)
				 ['print
				     (kwote f)
				     ''| <--- |
				     ['progn ! (cdr fval)]]]))))
	     *l)
      nil)))
 
(de flat (l r)
    ; retourne la liste de tous les atomes
    ; de la liste l
    (cond ((consp l) (flat (car l) (flat (cdr l) r)))
	  (l (cons l r))
	  (t r)))
 
 
(df detrace *l
      ; enleve la trace de toutes les fonctions
      ; de la liste '*l' ou de toutes les fonctions
      ; tracees si '*l' = ()
      (mapc (lambda (f)
		(let ((fval (getprop f 'trace)))
		  (if (atom fval)
		      (print f '| n'etait pas tracee.|)
		      (valfn f fval)
		      (remprop f 'trace))))
	    (or *l (setq *l trace trace ())))
       nil)
 
(de fintrace ()
    ; recupere la place de la TRACE
    (remfn 'flat)
    (=autl ltrace trace detrace fintrace)
    (setq trace ())
    nil)
 

