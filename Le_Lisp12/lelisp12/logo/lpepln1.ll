;=================================================================
;
;   Le_Lisp  80   :   PEPE   -	PEPLN1	:  gestion des lignes (1)
;
;=================================================================
;   (c) 1982	Jerome CHAILLOUX   et	I.N.R.I.A.
;		B.P. 105, 78153 Le Chesnay Cedex France
;   (c) 1983	C.N.D.P.
;		pour l'adaptation a l'interpreteur Logo
;=================================================================
 
; Une ligne n'est qu'une liste de code ASCII. C'est TRES facile a gerer
; mais l'occupation memoire est prohibitive.
 
; Pour Logo :
; nouveaux noms des variables : (pour ne pas interferer avec l'utilisateur)
; "pkl" devient "-l", "n" devient "-n".
 
(de  =pdisp (-l)
     ; affiche la ligne tassee "-l"
     (=tco 0 -ycr -l))
 
(de  =ppr (-l)
     (mapc 'princn -l)
     (terpri))
 
(de  =pbr (-l -n)
     ; casse la ligne tassee "-l" a la position "n"
     ; retourne un CONS  (pkl-gauche . pkl-droite)
     (if (=0 -n)
	 (cons () -l)
	 (cons -l (let ((l (nthcdr (1- -n) -l)))
		       (prog1 (cdr l) (rplacd l () ))))))
 
(de  =pinsch (-l -n -c)
     ; insere dans "-l" le caractere "-c" a la position "-n"
     ; ne change pas l'adresse physique de "-l"
     (cond
	((=0 -n) (rplac -l -c (cons (car -l) (cdr -l))))
	((>= -n (length -l)) (nconc -l [-c]))
	(t (let ((l (nthcdr -n -l)))
		(rplac l -c (cons (car l) (cdr l)))))))
 
(de  =pdelch (-l -n)
     ; enleve dans "-l" le caractere a la position "-n"
     ; ne change pas l'adresse physique de "-l"
     (if (=0 -n)
	 (if (cdr -l)
	     (rplac -l (cadr -l) (cddr -l))
	     (let ((l (nthcdr (+ -ycr -ydisp) -buf)))
		  (rplaca l ())))
	 (let ((l (nthcdr (1- -n) -l)))
	      (rplacd l (cddr l)))))
 

