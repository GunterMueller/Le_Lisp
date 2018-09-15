;=================================================================
;
;   Le_Lisp  80   :   PEPE   -  PEPLN1  :  gestion des lignes (1)
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepln1 'version (version)))


;*****   1er modele de gestion des lignes :
;        une ligne n'est qu'une liste de code ASCII.
;        C'est TRES facile a gerer mais l'occupation
;        memoire est prohibitive.
;
;        C'est la meilleure maniere de decrire les 11 fonctions
;        de gestion des lignes (et cela permet de mettre au point
;        les gestions plus sophitiquees comme PEPLN2 puis PEPLN3)
 
 
(de  pkldisplay (pkl)
     ; affiche la ligne tassee "pkl"
     (tyco 0 $ycursor$ pkl))
 
(de  pklprint (pkl)
     (mapc 'princn pkl)
     (terpri))
 
(de  pkllength (pkl)
     ; retourne la taille d'une ligne tassee
     (length pkl))
 
(de  pklbreak (pkl n)
     ; casse la ligne tassee "pkl" a la position "n"
     ; retourne un CONS  (pkl-gauche . pkl-droite)
     (cond
        ((= n 0) (cons () pkl))
        ((> n (pkllength pkl)) (cons pkl ()))
        (t (cons pkl (let ((l (nthcdr (1- n) pkl)))
                          (prog1 (cdr l) (rplacd l () ))))))))))
 
(de  pkljoin (pkl1 pkl2)
     ; retourne la ligne composee des lignes pkl1 et pkl2
     (nconc pkl1 pkl2)))
 
(de  pklchar (pkl n)
     ; retourne le nieme caractere de la ligne pkl
     (or (nth n pkl) #/  )))
 
(de  pklcharn (pkl n)
     ; retourne les "n" derniers caracteres de "pkl"
     (nthcdr n pkl))
 
(de  pklinschar (pkl n c)
     ; insere dans "pkl" le caractere "c" a la position "n"
     ; ne change pas l'adresse physique de "pkl"
     (cond
        ((= n 0) (rplac pkl c (cons (car pkl) (cdr pkl))))
        ((> n (pkllength pkl)) (nconc1 pkl c))
        (t (let ((l (nthcdr n pkl)))
                (rplac l c (cons (car l) (cdr l))))))))
 
(de  pkldelchar (pkl n)
     ; enleve dans "pkl" le caractere a la position "n"
     ; ne change pas l'adresse physique de "pkl"
     (cond
        ((= n 0)
            (if (cdr pkl)
                (rplac pkl (cadr pkl) (cddr pkl))
                (rplacd pkl ())))
        ((> n (pkllength pkl)) ())
        (t (let ((l (nthcdr (1- n) pkl)))
                (rplacd l (cddr l)))))))
 
(de  pklimplode (l)
     ; transforme la liste de caracteres "l" en
     ; une ligne packee "pkl"
     l))
 
(de  pklexplode (pkl)
     ; transforme la ligne packee "pkl"
     ; en une liste de caracteres "l"
     pkl))))
 

