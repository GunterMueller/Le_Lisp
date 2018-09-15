;=================================================================
;
;               Le_Lisp  80   :   Les Tours de Hanoi Animees
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 
#.(unless (= (version) 12)
          (syserror 'hanoi 'version (version)))

 
(de init-disque ()
    (setq l-disque
      '(#"          |          "
        #"         *|*         "
        #"        **|**        "
        #"       ***|***       "
        #"      ****|****      "
        #"     *****|*****     "
        #"    ******|******    "
        #"   *******|*******   "
        #"  ********|********  "
        #" *********|********* "
        #"====================="
        #"                     ")))
     ()))
 
 
;-----   La fonction principale
 
(de hanoi (n)
    (unless n
            (print '|Combien de disque |)
            (setq n (read)))
    (unless (and (numberp n) (> n 2) (< n 10))
            (syserror 'hanoi 'eroob n))
    (let ((a1 '(10))        ; contenu de la 1ere aiguille
          (a2 '(10))        ; contenu de la 2eme aiguille
          (a3 '(10))        ; contenu de la 3eme aiguille
          (nmv 0)           ; nombre de mouvements
          (l-disque))
         (tycls)
         (putprop 'a1 0 'pos)
         (putprop 'a2 25 'pos)
         (putprop 'a3 50 'pos)
         (init-disque)
         (let ((n n)) (repeat n (newl a1 n) (decr n)))
         (tyattrib t)
         (tyco 28 1 '#"Les Tours de Hanoi")
         (tyattrib ())
         (affiche 'a1)
         (affiche 'a2)
         (affiche 'a3)
         (hanoi-moteur n 'a1 'a2 'a3)
         (tycursor 0 #.(1- $ymax$))
         'HANOI)))
 
(de hanoi-moteur (n dep arr int)
    (when (> n 0)
          (hanoi-moteur (1- n) dep int arr)
          (bouge n dep arr)
          (hanoi-moteur (1- n) int arr dep))))
 
(de bouge (n dep arr)
    (tycursor 18 5)
    (tyo (explode (incr nmv)) '#" : je bouge le disque " (explode n)
         '#" de " (explode dep) '#" vers " (explode arr))
    (monte n (getprop dep 'pos) (- 10 (length (eval dep))))
    (avance n (getprop dep 'pos) (getprop arr 'pos))
    (descend n (getprop arr 'pos) (- 10 (length (eval arr))))
    (set dep (cdr (eval dep)) arr (cons n (eval arr))))))
 
 
;-----   La fonction d'affichage
 
(de affiche (a)
    ; affiche toute l'aiguille "a"
    (let ((y 21)
          (l (reverse (eval a)))
          (x (getprop a 'pos)))
         (repeat 10
                 (tyco x (decr y) (nth (or (nextl l) 0) l-disque)))
         (tyco (+ x 10) 21 (explode a))))
 
;-----   Les fonctions de mouvement de disque
 
(de monte (n x nb)
    ; disque "n" en "x" "nb" fois
    (let ((y (+ nb 10)))
         (repeat (1+ nb)
                 (tyco x y (nth n l-disque))
                 (tyco x (1+ y) (car l-disque))
                 (decr y))))))))))
 
(de descend (n x nb)
    ; disque "n" en "x" "nb" fois
    (let ((y 11))
         (tyco x 10 (nth 11 l-disque))
         (repeat (1- nb)
                 (tyco x y (car l-disque))
                 (tyco x (incr y) (nth n l-disque))))))
 
(de avance (n x1 x2)
    ; avance horizontalement le disque "n" de "x1" vers "x2"
    (if (> x1 x2)
        (repeat (- x1 x2) (tyco (decr x1) 10 (nth n l-disque))))
        (repeat (- x2 x1) (tyco (incr x1) 10 (nth n l-disque))))))))
 
 
;-----   Pour recuperer la place occupee par HANOI
 
(de hanoiend ()
    (mapc 'remfn
          '(init-disque hanoi hanoi-moteur
            bouge affiche monte descend avance))
    (autoload hanoi hanoi)
    'hanoiend)
 

