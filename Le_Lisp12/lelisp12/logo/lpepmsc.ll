;=================================================================
;
;   Le_Lisp  80   :   PEPE   -	 PEPMSC  fonctions auxiliaires
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
(de  =dend ()
     ; fin de la route : on ne plus plus bouger
     (=tbip)
     (exit eoc))
 
(de  =curln ()
     ; retourne la ligne courante
     (nth (+ -ydisp -ycr) -buf))
 
(de  =lencurln ()
     ; retourne la longueur de la ligne courante (ajout pour Logo).
     (length (=curln)))
 
(de  =redisp (n)
     ; reaffiche toute la fenetre visible a partir de 'n' (optionnel)
     (let ((-ycr (or (numberp n) 0)))
	  (let ((b (nthcdr (+ -ydisp -ycr) -buf)))
	       (repeat (- -ym -ycr)
		       (fixecurseur -ycr 0)
		       (=tcleol)
		       (when b (=pdisp (nextl b)))
		       (incr -ycr))))
     (fixecurseur -ym 0)
     (=tcleol)
     (=tatt t)
     (tyo '#"Touches : ^A pour avoir de l'aide, ESC pour redefinir,"
	  '#"^C pour annuler.")
     (=tatt))
 
;-----	 une (petite...) brouette de predicats utiles
 
(de =0 (n) (= n 0)) ; comme son nom l'indique...(ajout pour Logo)
 
(de  =eolp ()
     ; teste si on se trouve en fin de ligne
     (>= -xcr (=lencurln)))
 
(de  =eobp ()
     ; teste si on se trouve en fin de buffer
     (>= (+ -ydisp -ycr 1) (length -buf)))
 

