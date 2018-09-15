;=================================================================
;
;    Le_Lisp  80   :   les routines graphiques du Micral 90
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 

;=====   ATTENTION  tout ce code est dependant du MICRAL 90!

#.(unless (eq (system) 'micral90) 
          (syserror 'graph 'micral90 (system)))

 
;-----   Les fonctions d'initialisation et de fin

(de grclear ()
    ; initialise l'ecran graphique et alphanumerique
    (tyo #$19))
 
(de grend ()
    ; fin du mode graphique
    (tyo #$19))
 
;-----   Les fonctions pout charger la forme des caracteres

(de grsmall ()
    ; passage en caracteres petits
    (tyo #$1B #$1B #/G 1 0 #$F9))
 
(de grregular ()
    ; passage en caracteres normaux
    (tyo #$1B #$1B #/G 1 0 #$F8))

(de grbig ()
    ; passage en caracteres gros
    (tyo #$1B #$1B #/G 1 0 #$FC))

(de ecrisgros (x y s)
    ; la fonction de LOGO
    (grpoint 3 (grxorth x) (gryorth y))
    (grbig) (apply 'tyo (explode s)) (grregular) ())

;-----   Les fonctions graphiques sur  640x432

(de grxorth (x)
    ; passage d'un x LOGO a un x MICRAL
    (cond ((< x -320) 0)
          ((> x 319) 639)
          (t (+ x 320))))

(de gryorth (y)
    ; passage d'un y LOGO a un y MICRAL
    (cond ((< y -216) 0)
          ((> y 215) 431)
          (t (+ y 216))))))))

(de grpoint (m x y)
    ; affiche dans le mode 'm' :
    ;    0 = eteindre,
    ;    1 = allumer,
    ;    2 = inverser,
    ;    3 = positionner.
    ; le point en x y
    (tyo #$1B #$1B #/G 6 0
         m 0 (logand x #$FF) (// x 256) (logand y #$FF) (// y 256))))))
 
(de grvect (m x y)
    ; affiche dans le mode 'm' :
    ;    0 : eteindre,
    ;    1 : allumer,
    ;    2 : inverser.
    ; le vecteur du point courant au point 'x' 'y'.
    ; ?!?!? BUG du soft MICRAL90 ?!?!?
    (when (or (= x 254) (= x 255)) (setq x 256))
    (when (or (= y 254) (= y 255)) (setq y 256))
    (tyo #$1B #$1B #/G 6 0
         (+ #$10 m) 0 (logand x #$FF) (// x 256) 
                      (logand y #$FF) (// y 256)))))))
 
(de grlsegs (m l)
    ; affiche dans le mode 'm' la liste de segments 'l'
    (while l (grvect m (nextl l) (nextl l))))
 
(de grcarre (n)
    ; et oui ca fait un carre.
    (let ((x n) (y n))
         (grpoint 3 x y)
         (grvect 1 x (+ y n))
         (grvect 1 (+ x n) (+ y n))
         (grvect 1 (+ x n) y)
         (grvect 1 x y))))
 
(de grtest ()
    ; histoire de tester l'ensemble.
    (grclear)
    (let ((x 20) (y 20))
         (repeat 40 (grpoint 1 (incr x) (incr y))))
         (let ((i 10))
              (repeat 20 (grcarre (incr i 10))))
    (tyi)
    (grend))
 
 
 
