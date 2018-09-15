;=================================================================
;
;   Le_Lisp  80   :   PEPE   -  PEPLN3  :  gestion des lignes (3)
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepln3 'version (version)))

 
 
;*****   3eme modele de gestion des lignes :
;        une ligne est une suite d'objets de type :
;             nnnnnn cccccccc
;        cccccccc  est le code interne ASCII d'un caractere
;        nnnnnn    est le facteur de repetition de ce caractere
;        La gestion est encore un peu plus lourde que precedement
;        mais le gain est encore plus appreciable.
;        Voici les 11 fonctions de gestion des lignes
 
 
(de pkldisplay (pkl)
    ; affiche la ligne tassee "pkl" a la position $ycursor$+2
    ; tyo et tyco connaissent les facteurs de repetition.
    (tyco 0 (+ $ycursor$ 2) pkl))
 
(de pklprint (pkl)
    ; imprime (sur fichier) la ligne packee "pkl"
    (while pkl
           (if (< (car pkl) 256)
               (princn (nextl pkl))
               (repeat (1+ (// (car pkl) 256))
                       (princn (logand (nextl pkl) #$FF)))))
    (terpri))))
 
(de pkllength (pkl)
    ; retourne la taille d'une ligne tassee
    (let ((n 0))
         (while pkl
                (incr n (if (< (car pkl) 256)
                            1
                            (1+ (// (car pkl) 256))))
                (nextl pkl))
         n))
 
(de pklbreak (pkl n)
    ; casse la ligne tassee "pkl" a la position "n"
    ; retourne un CONS  (pkl-gauche . pkl-droite)
    (if (= n 0)
        ; en debute ligne
        (cons () pkl)
        (let ((l (pklexplode pkl)))
             (if (> n (length l))
                 ; en fin de ligne
                 (cons pkl ())
                 ; au milieu de la ligne
                 (setq l (cons l (let ((l (nthcdr (1- n) l)))
                                      (prog1 (cdr l)
                                             (rplacd l ())))))
                 (rplac l (pklimplode (car l)) (pklimplode (cdr l))))))))
 
(de pkljoin (pkl1 pkl2)
    ; retourne la ligne composee des lignes pkl1 et pkl2
    (nconc (pklexplode pkl1) (pklexplode pkl2)))
 
(de pklchar (pkl n)
    ; retourne le nieme caractere de la ligne pkl
    (nth n (pklexplode pkl)))
 
(de pklcharn (pkl n)
    ; retourne les "n" derniers caracteres de pkl
    ; sous forme d'une liste de caracteres
    (nthcdr n (pklexplode pkl))))))
 
(de pklinschar (pkl n c)
    ; insere dans "pkl" le caractere "c" a la position "n"
    ; en gardant l'adresse physique de "pkl"
    (displace pkl (pklexplode pkl))
    (cond
       ((= n 0)
        ; au debut de la ligne
        (rplac pkl c (cons (car pkl) (cdr pkl))))
       ((>= n (length pkl))
        ; a la fin de la ligne
        (nconc pkl [c]))
       (t
        ; dans le texte
        (let ((l (nthcdr n pkl)))
             (rplac l c (cons (car l) (cdr l))))))
    (displace pkl (pklimplode pkl)))
 
(de pkldelchar (pkl n)
    ; enleve dans "pkl" le caractere a la position "n"
    ; ne change pas l'adresse physique de "pkl"
    (displace pkl (pklexplode pkl))
    (cond ((= n 0) (if (cdr pkl)
                       (rplac pkl (cadr pkl) (cddr pkl))
                       (rplacd pkl ())))
          ((> n (length pkl)) ())
          (t (let ((l (nthcdr (1- n) pkl)))
                  (rplacd l (cddr l)))))
    (displace pkl (pklimplode pkl)))
 
(de pklimplode (l)
    ; transforme la liste de caracteres "l" en
    ; une ligne packee "pkl"
    (when l
          (let ((l (cdr l)) (pkl) (c (car l)) (n 0))
               (cond ((null l) (nreconc (cons (+ c (* n 256)) pkl)))
                     ((and (= (car l) c) (< n 63))
                        (self (cdr l) pkl c (1+ n)))
                     (t (self (cdr l)
                              (cons (+ c (* n 256)) pkl) (car l) 0)))))))
 
(de pklexplode (pkl)
    ; transforme la ligne packee "pkl"
    ; en une liste de caracteres "l"
    (let ((l) (c))
         (while pkl
                (if (< (car pkl) 256)
                    (newl l (nextl pkl))
                    (setq c (\ (car pkl) 256))
                    (repeat (1+ (// (nextl pkl) 256))
                            (newl l c))))
         (nreconc l ())))
 

