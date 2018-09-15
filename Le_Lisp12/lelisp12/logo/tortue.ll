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

 
;-----   Variables globales (toutes encadrees du caractere $)

(setq $theta$ 0     ; l'angle courant de la bete
      $mode$ 1      ; le type d'affichage 0=invisible,
                    ;                     1=visible
                    ;                     2=inverse(xor)
      $stat$ t      ; faut-il montrer la tortue (t=oui)
      $scale$ 1     ; l'echelle du dessin
      $x$ 0         ; x xourant
      $y$ 0         ; y courant
)
 

;-----   Les fonctions internes de manipulation de la tortue

(de *av (rho)
    ; avance la bete de rho
    (let ((x (scale rho (sinus $theta$) 4096))
          (y (scale rho (cosinus $theta$) 4096)))
         (setq $x$ (+ $x$ x) $y$ (+ $y$ y))
         (grvect $mode$  (grxorth $x$) (gryorth $y$))))


                 
(de *dt (m)
    ; dessine la tortue dans le mode m
    (grpoint 3 (grxorth $x$) (gryorth $y$))
    (let (($mode$ m) ($theta$ $theta$) ($x$ $x$) ($y$ $y$))
         (setq $theta$ (*reduc (+ $theta$ 150)))
         (*av 16) 
         (setq $theta$ (*reduc (+ $theta$ 120)))
         (*av 16) 
         (setq $theta$ (*reduc (+ $theta$ 120)))
         (*av 16)))))


(de *reduc (theta)
    ; reduit l'angle 'theta' dans l'intervalle [0,,360[
    (while (< theta 0)
           (incr theta 360))
    (while (>= theta 360)
           (decr theta 360))
    theta))))
 
 
 
;-----   Les fonctions accessibles de Logo

(de te ()
    ; pour "T"ortue "E"cran : initialise la bete
    (setq $theta$ 0 $x$ 0 $y$ 0 $mode$ 1 $stat$ t $scale$ 1)
    (nettoie)    
    ())

(de origine ()
    (setq $theta$ 0 $x$ 0 $y$ 0)
    (when $stat$ (*dt $mode$))
    ())
 
(de nettoie ()
    (grclear)
    (when $stat$ (*dt $mode$))
    ())

(de tg (theta)
    (fixecap (- $theta$ theta)))
 
(de td (theta)
   (fixecap (+ $theta$ theta)))
 
(de fixecap (theta)
    ; se positionne a la position absolue 'theta'
    (when $stat$ (*dt 2))
    ; ramene l'angle dans l'intervalle  [0 360[
    (setq $theta$ (*reduc theta))
    ; reaffiche la tortue s'il le faut
    (when $stat$ (*dt 2))
    ())

(de lc ()
    ; leve crayon
    (setq $mode$ 0)
    ())
 
(de bc ()
    ; baisse crayon
    (setq $mode$ 1)
    ())
 
(de av (rho)
    ; avance de 'rho' pas dans l'echelle '$scale$'
    (when $stat$ (*dt 2))
    (*av (* rho $scale$))
    (when $stat$ (*dt 2))
    ()))

(de re (rho)
    ; recule de 'rho' pas
    (av (- rho)))
 
(de montre ()
   ; visualise la tortue.
   (*dt 1)
   (setq $stat$ t)
   ())

(de cache ()
    ; cache la tortue.
    (*dt 0)
    (setq $stat$ ())
    ())

(de cap ()
    $theta$)
 
(de gomme ()
    (setq $mode$ 2)
    ())
 
 
(de fixexy (x y)
    ; defini avec avance pour coherence dans les calculs
    (when $stat$ (*dt 2))
    (setq $x$ (* x $scale$) $y$ (* y $scale$))
    (grpoint 3 (grxorth $x$) (gryorth $y$))
    (when $stat$ (*dt 2))
    ())

(de echelle (n)
    ; l'echelle du dessin (15 au max!)
    (setq $scale$ (cond ((<= n 1) 1)
                        ((>= n 10) 10)
                        (t n)))
    ())

