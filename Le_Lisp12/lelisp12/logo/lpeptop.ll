;======================================================================
;
;    Le_Lisp  80   :   PEPE   -   PEPTOP  la boucle principale
;
;======================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;======================================================================
; Pour Logo :
; Voir les nouveaux noms des fonctions et des variables globales dans LOGONOMS.
 
;-----	 l'appel de PEPE
 
(df  =pepe (f)
     (setq -xcr 0 -ycr 0 -ydisp 0 -buf ())
	   ; -buf sera cree par redefinition de EOL (et utilisation de print)
     (flet ((eol ()
		 (let ((i 0) (r ()))
		      (repeat (outpos) (newr r (outbuf i))
				       (outbuf i 32) ; code du "blanc"
				       (incr i))
		      (outpos 0)
		      (newr -buf r)))) ; et non newl
	   (eval f))
     (=tatt)
     (=redisp)
     ;
     ; le top-level proprement dit de PEPE
     ;
     (let ((-lcmd))
      ; -lcmd est la liste des commandes non encore executees
	  (flet ((iteval (n) (newr -lcmd n)))
		(untilexit =pepe
		      (tag eoc
			   (fixecurseur -ycr -xcr)
			   (let ((c (or (nextl -lcmd)
					(tyi))))
				(let ((l (cassq c -cmds)))
				     (cond
					 ((null l)
					      (if (< c 32)
						  ; ce n'est pas une commande
						  (=dend)
						  (=insch c)))
					 ((symbolp l)
					      ; c'est une commande
					      (apply l))
					 (t   ; egalement
					      (eprogn l)))))))
     ())))
 

