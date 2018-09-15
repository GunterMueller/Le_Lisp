(bind ((typecn 47 1)(typecn 59 2)(typecn 39 5)(typecn 94 5)(typecn 35 7)
       (typecn 43 8)(typecn 45 8)(typecn 42 8)(typecn 92 8)(typecn 64 8)
       (typecn 62 8)(typecn 60 8)(typecn 61 8)(typecn 46 9))
      (untilexit eof (eval (read))))
;=================================================================
;
;                          LOGOGRAP
;
;    J.L Jourdan  ---  Lycee de l'Isle-Adam  ---  juin 83
;
;=================================================================
 
;      Etat au 19 juin 83 du module LOGOGRAP definissant les
;      primitives GRAPHIQUES de LOGO en realisant un interfacage
;      avec LLG
 
;              CE MODULE EST COMPLETE PAR LOGOGRAF
;              ===================================
 
;variables globales
(setq *cap 0 *all 17 *mo t *xx 4096 *yy 4096)
 
(de tg (*x1)
    (td (- *x1)))
 
(de td (*x1)
   (fixecap (+ *cap *x1)))
 
(de fixecap (*x1)
    (*mc)
    ; morceau fixecap. Le ramene a  [0 360[
    (while (< *x1 0)
           (incr *x1 360))
    (while (>= *x1 360)
           (decr *x1 360))
    (setq *cap *x1)
    (if *mo (montre))
    ())
 
(de *msd (*x1)
    ; multiplication sinus degres 0 a 360
    (cond
       ((<= *x1 90) (*msdr *x1))
       ((<= (decr *x1 90) 90) (*mcdr *x1))
       ((<= (decr *x1 90) 90)(- (*msdr *x1)))
       ((<= (decr *x1 90) 90) (- (*mcdr *x1)))))
 
(de *mcd (*x1)
    ; multiplication cosinus degres 0 a 360
    (if (<= *x1 90) (*mcdr  *x1) (- (*msd (- *x1 90)))))
 
(de *msdr (*x1)
    ; multiplication 4096 sinus degres reduits 0 a 90
    (setq *x1 (+ -tsin *x1 *x1))
    (+ (* 256 (memoryb (1- *x1)))
       (memoryb *x1)))
 
;--- installation de la table des sinus a partir de $bcode$ + 6
 
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
 
(de lc ()
    ; leve crayon
    (setq *all 3) ())
 
(de bc ()
    ; baisse crayon
    (setq *all 17) ())
 
(de re (*x1)
    (av (- *x1)))
 
(de *cal (*x1 *y1)
    ; calcule x1*y1/64 jusqu'a 127*4096/64
    (+ (* *x1 (// *y1 64))
       (// (* *x1 (\ *y1 64))
           64)))
 
(de *mc ()
    ; pour effacer la tortue
    (let ((*all 16))
         (tg 150) (av 10) (tg 60) (av 10) (tg 60) (av 10) (td 30))
;    (grpoint 3 (+ 320 (// (- *xx 4096) 13)) (+ 216 (// (- 4096 *yy) 13)))
;    (grlsegs #$12 dessintortue)
;    (grpoint 3 (+ 320 (// (- *xx 4096) 13)) (+ 216 (// (- 4096 *yy) 13)))))
 )))))


(de cache ()
    (*mc)
    (setq *mo))
 
(setq dessintortue [ (+ 128 (// (*msd *cap) 281))
                     (- 128 (// (*mcd *cap) 400))
                     (+ 128 (// (*msd (\ (+ *cap 150) 360)) 162))
                     (- 128 (// (*mcd (\ (+ *cap 150) 360)) 231))
                     (+ 128 (// (*msd (\ (+ *cap 270) 360)) 162))
                     (- 128 (// (*mcd (\ (+ *cap 270) 360)) 231))
                     (+ 128 (// (*msd (\ (+ *cap 30) 360)) 162))
                     (- 128 (// (*mcd (\ (+ *cap 30) 360)) 231))])

(de montre ()
    ; visualise la tortue
;    (grpoint 3 (+ 320 (// (- *xx 4096) 13)) (+ 216 (// (- 4096 *yy) 13)))
;    (grlsegs #$11 dessintortue)
;    (grpoint 3 (+ 320 (// (- *xx 4096) 13)) (+ 216 (// (- 4096 *yy) 13)))
    (let ((*all 17))
         (tg 150) (av 10) (tg 60) (av 10) (tg 60) (av 10) (td 30))
    (setq *mo t)
    ())
 
 
(de av (*a1)
   (let ((*aa (*cal *a1 (*msd *cap)))
         (*bb (*cal *a1 (*mcd *cap)))
         (*x1 ()) (*y1 ()))
    (if (or (> (- *aa) *xx)
            (> *aa (- 8000 *xx))
            (> (- *bb) *yy)
            (> *bb (- 8000 *yy)))
        (*l-err nil 'erhl))
    (setq *xx (+ *xx *aa)
          *yy (+ *yy *bb))
    (*mc)
    ; pour orthonormer.
    (setq *x1 (+ 320 (// (- *xx 4096) 13))
          *y1 (+ 216 (// (- 4096 *yy) 13)))
    (grvect (selectq *all (3 #$10) (17 #$11) (t #$12)) *x1 *y1)
    (if *mo (montre))))
 

