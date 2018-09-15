;=================================================================
;
;   Le_Lisp  80   :   PEPE   -  PEPLN2  :  gestion des lignes (2)
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepln2 'version (version)))

 
 
;*****   2eme modele de gestion des lignes :
;        une ligne est un CONS :  (n . l)
;        dans lequel "n" est le nombre d'espaces en tete de ligne
;        et "l" les autres caracteres de la ligne
;        La gestion est un peu plus lourde que precedement
;        mais le gain est tres appreciable specialement pour
;        des programmes ecrits en Lisp.
;        Voici les 11 fonctions de gestion des lignes
 
(de pkldisplay (pkl)
    ; affiche la ligne tassee "pkl" a la position $ycursor$
    (tyco (car pkl) $ycursor$ (cdr pkl)))
 
(de pklprint (pkl)
    ; imprime (sur fichier) la ligne packee "pkl"
    (repeat (car pkl) (princn #/  ))
    (mapc 'princn (cdr pkl))
    (terpri))))
 
(de pkllength (pkl)
    ; retourne la taille d'une ligne tassee
    (+ (car pkl) (length (cdr pkl))))
 
(de pklbreak (pkl n)
    ; casse la ligne tassee "pkl" a la position "n"
    ; retourne un CONS  (pkl-gauche . pkl-droite)
    (if (>= n (car pkl))
        ; dans le texte
        (cons pkl
              (let ((l (nthcdr (- n (car pkl)) pkl)))
                   (pklimplode (prog1 (cdr l) (rplacd l () )))))
        ; dans le renfoncement
        (cons [n] (rplaca pkl (- (car pkl) n))))))
 
(de pkljoin (pkl1 pkl2)
    ; retourne la ligne composee des lignes pkl1 et pkl2
    (pklimplode
        (append (pklexplode pkl1) (pklexplode pkl2))))))
 
(de pklchar (pkl n)
    ; retourne le nieme caractere de la ligne pkl
    (if (>= n (car pkl))
        ; dans le texte
        (or (nth (- n (car pkl)) (cdr pkl)) #/  )
        ; dans le renfoncement
        #/  ))))
 
(de pklcharn (pkl n)
    ; retourne les "n" derniers caracteres de pkl
    ; sous forme d'une liste de caracteres
    (nthcdr n (pklexplode pkl))))))
 
(de pklinschar (pkl n c)
    ; insere dans "pkl" le caractere "c" a la position "n"
    ; ne change pas l'adresse physique de "pkl"
    (cond
       ((>= n (pkllength pkl))
        ; a la fin de la ligne
        (nconc pkl [c]))
       ((> n (car pkl))
        ; dans le texte
        (let ((l (nthcdr (- n (car pkl)) (cdr pkl))))
             (rplac l c (cons (car l) (cdr l)))))
       (t
        ; dans le renfoncement
        (if (= c #/ )
            (rplaca pkl (1+ (car pkl)))
            (rplac pkl n (cons c
                   (progn (repeat (- (nextl pkl) n)
                             (newl pkl #/ ))
                              pkl)))))))))))
 
(de pkldelchar (pkl n)
    ; enleve dans "pkl" le caractere a la position "n"
    ; ne change pas l'adresse physique de "pkl"
    (if (>= n (car pkl))
        ; je suis dans le texte
        (let ((l (nthcdr (- n (car pkl)) pkl)))
             (ifn (cddr l)
                  ; dernier caractere de la ligne
                  (rplacd l ())
                  ; au milieu du texte
                  (nextl l)
                  (displace l (cdr l))))
        ; je suis dans le renfoncement
        (rplaca pkl (1- (car pkl)))))))))
 
(de pklimplode (l)
    ; transforme la liste de caracteres "l" en
    ; une ligne packee "pkl"
    (let ((n 0))
         (while (and l (eq (car l) #/  ))
                (incr n)
                (nextl l))
         (cons n l)))))))
 
(de pklexplode (pkl)
    ; transforme la ligne packee "pkl"
    ; en une liste de caracteres "l"
    (let ((n (car pkl)) (l (cdr pkl)))
         (repeat n (newl l #/  ))
          l)))))
 

