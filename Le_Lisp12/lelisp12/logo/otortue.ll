;=================================================================
;
;    Le_Lisp  80   :   TORTUE  :  la tortue de Logo
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================
 
(unless (= (version) 12)
        (syserror 'tortue 'version (version)))

 
;-----   Variables globales

(setq $cap 0       ; l'angle courant de la bete
      $mode 1      ; le type d'affichage 0=invisible,
                   ;                     1=visible
                   ;                     2=inverse(xor)
      $stat t      ; faut-il montrer la tortue (t=oui)
      $xx 4096     ; x xourant
      $yy 4096     ; y courant
)
 

;-----   La mecanique pour passer de rho/theta -> x y

 
(de *msd (*x1)
    ; multiplication sinus degres 0 a 360
    (cond
       ((<= *x1 90) (*msdr *x1))
       ((<= (decr *x1 90) 90) (*mcdr *x1))
       ((<= (decr *x1 90) 90) (- (*msdr *x1)))
       ((<= (decr *x1 90) 90) (- (*mcdr *x1)))))
 
(de *mcd (*x1)
    ; multiplication cosinus degres 0 a 360
    (if (<= *x1 90) (*mcdr  *x1) (- (*msd (- *x1 90)))))
 
(de *msdr (*x1)
    ; multiplication 4096 sinus degres reduits 0 a 90
    (setq *x1 (+ -tsin *x1 *x1))
    (+ (* 256 (memoryb (1- *x1)))
       (memoryb *x1)))

 
;-----   Installation de la table des sinus a partir de $bcode$ + 6
 
(apply '(lambda l
           (setq -tsin (+ 7
                          (* 256 (car $bcode$))
                          (cadr $bcode$)))
           (let ((n (- -tsin 2)))
                (while l (memoryb (incr n)
                                  (// (car l)
                                      256))
                         (memoryb (incr n)
                                  (\ (nextl l)
                                     256)))))
 
       '(    0   71  143  214  286  357  428  499  570  641  711  782  852  921
 991 1060 1129 1198 1266 1334 1401 1468 1534 1600 1666 1731 1796 1860 1923 1986
2048 2110 2171 2231 2290 2349 2408 2465 2522 2578 2633 2687 2741 2793 2845 2896
2946 2996 3044 3091 3138 3183 3228 3271 3314 3355 3396 3435 3474 3511 3547 3582
3617 3650 3681 3712 3742 3770 3798 3824 3849 3873 3896 3917 3937 3956 3974 3991
4006 4021 4034 4046 4056 4065 4074 4080 4086 4090 4094 4095 4096 )
)
 
(de *mcdr (*x1)
    ; multiplication 4096 cosinus degre reduit 0 a 90
    (*msdr (- 90 *x1)))
 
(de *cal (*x1 *y1)
    ; calcule x1*y1/64 jusqu'a 127*4096/64
    (+ (* *x1 (// *y1 64))
       (// (* *x1 (\ *y1 64))
           64)))

 
;-----   Les fonctions internes de manipulation de la tortue

(de *av (*a1)
    ; avance la bete de rho
    (let ((*aa (*cal *a1 (*msd $cap)))
          (*bb (*cal *a1 (*mcd $cap)))
          (*x1 ()) 
          (*y1 ()))
         (when (or (> (- *aa) $xx)
                   (> *aa (- 8000 $xx))
                   (> (- *bb) $yy)
                   (> *bb (- 8000 $yy)))
               (*l-err nil 'erhl))
         (setq $xx (+ $xx *aa) $yy (+ $yy *bb))
         (grvect $mode (grxorth $xx) (gryorth $yy)))))

(de *dt (m)
    ; dessine la tortue dans le mode m
    (grpoint 3 (grxorth $xx) (gryorth $yy))
    (let (($mode m) ($cap $cap) ($xx $xx) ($yy $yy))
         (setq $cap (*norm (+ $cap 150)))
         (*av 7) 
         (setq $cap (*norm (+ $cap 120)))
         (*av 7) 
         (setq $cap (*norm (+ $cap 120)))
         (*av 7)))))


(de *norm (*x1)
    ; normalise l'angle '*x1' dans l'intervalle [0,,360[
    (while (< *x1 0)
           (incr *x1 360))
    (while (>= *x1 360)
           (decr *x1 360))
    *x1))))
 
 
(de fixexy (*x1 *y1)
    ; defini avec avance pour coherence dans les calculs
    (let (($cap $cap)($mode $mode))
         (origine)
         (lc)
         (cache)
         (td 90)
         (av *x1)
         (tg 90)
         (av *y1))
    ())
 
;--- chargement des primitives d'acces a la tortue plancher :
 
(de *recup ()
    (mapc 'remfn
          '(*msd *mcd *msdr *mcdr
            *cal cache montre *dft ; dans LOGOGRAP
            nettoie *i origine gomme
            fixexy fixecap cap         ; dans LOGOGRAF
           )))
 
;-----   Les fonctions accessibles de Logo

(de te ()
    ; pour "T"ortue "E"cran : initialise la bete
    (lc)
    (nettoie)    
    (origine)
    (bc)
    (montre))
 

(de origine ()
    (setq $cap 0 $xx 4096 $yy 4096 $stat t)
    (*dt 1))
 
(de nettoie ()
    (grclear))

(de tg (*x1)
    (fixecap (- $cap *x1)))
 
(de td (*x1)
   (fixecap (+ $cap *x1)))
 
(de fixecap (*x1)
    ; on efface la tortue
    (*dt 0)
    ; ramene l'angle dans l'intervalle  [0 360[
    (setq $cap (*norm *x1))
    (when $stat (montre))
    ())

(de lc ()
    ; leve crayon
    (setq $mode 0))
 
(de bc ()
    ; baisse crayon
    (setq $mode 1))
 
(de av (*a1)
    ; avance de '*a1' pas
    (*dt 0)
    (*av *a1)
    (when $stat (*dt 1))))

(de re (*x1)
    ; recule de '*x1' pas
    (av (- *x1)))
 
(de montre ()
   ; visualise la tortue.
   (*dt 1)
   (setq $stat t))

(de cache ()
    ; cache la tortue.
    (*dt 0)
    (setq $stat ()))

(de cap ()
    $cap)
 
(de gomme ()
    (setq $mode 2)
    ())
 
