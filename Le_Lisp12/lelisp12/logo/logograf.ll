(bind ((typecn 47 1)(typecn 59 2)(typecn 39 5)(typecn 94 5)(typecn 35 7)
       (typecn 43 8)(typecn 45 8)(typecn 42 8)(typecn 92 8)(typecn 64 8)
       (typecn 62 8)(typecn 60 8)(typecn 61 8)(typecn 46 9))
      (untilexit eof (eval (read))))
;========================================================================
;
;                            LOGOGRAF
;
;                  complement du module LOGOGRAP
;
;     J.L Jourdan  ---  Lycee de l'Isle-Adam  ---  juin 83
;
;========================================================================
 
;        Etat au 20 juin de la partie evolutive de logograp concernant
;        le graphisme d'ecran et la tortue de sol.
 
(de nettoie ()
;    (execute [#$3E #$80
;             #$CF])
;             ; MVI A,80H RST 1
    (grclear)
;    (vt)
    (*o))
 
(de *o ()
    (let ((*all *all))
          (lc)
          (av 0)))
 
(de *i ()
    ; initialisation
    (setq *cap 0
          *xx 4096
          *yy 4096))
 
(de origine ()
    (*i)
    (*mc)
    (*o))
 
(de te ()
    ; pour "T"ortue "E"cran
    (bc)
    (cache)
    (*i)
    (origine)
    (nettoie)
    (vt)
    (montre))
 
(de gomme ()
    (setq *all 16)
    ())
 
(de fixexy (*x1 *y1)
    ; defini avec avance pour coherence dans les calculs
    (let ((*cap *cap)(*all *all))
         (origine)
         (lc)
         (cache)
         (td 90)
         (av *x1)
         (tg 90)
         (av *y1))
    ())
 
(de cap ()
    *cap)
 
;--- chargement des primitives d'acces a la tortue plancher :
 
(de *recup ()
    (mapc 'remfn
          '(*msd *mcd *msdr *mcdr
            *cal *mc cache montre *dft ; dans LOGOGRAP
            nettoie *i origine gomme
            fixexy fixecap cap         ; dans LOGOGRAF
           )))
 
(de mobile ()
    (*recup)
    (=lf 'logomobi))
 
(de cocci ()
    (*recup)
    (=lf 'lcocci))
 

