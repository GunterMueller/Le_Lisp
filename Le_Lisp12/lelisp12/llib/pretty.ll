;=================================================================
;
;   Le_Lisp  80   :   PRETTY  :  le paragrapheur interprete
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pretty 'version (version)))

 
 
;-----   Les fonctions internes
 
(de  p-p (l)
     ; paragraphe l'expression "l"
     (cond
       ((null l) (princn #/( ) (princn #/) ))
       ((atom l) (prin l))
       ((and (eq (car l) quote) (null (cddr l)))
          ; le cas de (QUOTE s)  =>  's
          (princn #/' )
          (p-p (cadr l)))
       ((and (consp (car l)) (eq (caar l) lambda))
          ; le cas ((LAMBDA ...) ...)  =>  (LET ...)
          (p-p (mcons 'let
                  (mapcar 'list (cadar l) (cdr l))
                  (cddar l))))
       ((p-inlinep l) (p-l l))
       (t (princn #/( )
          (let ((f (car l)) (l (cdr l)))
               (p-p f)
               (selectq (if (symbolp f)
                            (ptype f)
                            t)
                    (1 (p-progn))
                    (2 (p-p1) (p-progn t))
                    (3 (p-p1) (p-p1) (p-progn t))
                    (4 (p-cond))
                    (5 (p-p1) (p-cond))
                    (6 (bind ((lmargin (+ (lmargin) 5)))
                            (while l (p-p1) (p-p1) (when l (terpri)))))
                    (t (p-progn)))
               (and
                  l
                  (princn #/  )
                  (princn #/. )
                  (princn #/  )
                  (prin l)))
         (princn #/) ))))))
 
(de  p-p1 ()
     ; edite l'element suivant (sauf le 1er)
     (bind ((lmargin (p-lmargin f)))
              (princn #/  )
              (p-p (nextl l)))))))
 
(de  p-l (l)
     ; imprime "l" sur la ligne (et ca rentre)
     (princn #/( )
     (p-p (nextl l))
     (while (consp l) (p-p1))
     (when l
           (princn #/  )
           (princn #/. )
           (princn #/  )
           (prin l))
     (princn #/) ))))
 
(de  p-progn (i)
     (if (and (null (cdr l)) (null i))
         (p-p1)
         (bind ((lmargin (p-lmargin f)))
            (while (consp l)
                   (if (numberp (car l))
                   (p-p1)
                   (if (< (outpos) (lmargin))
                       (outpos (lmargin))
                       (terpri))
                (p-p (nextl l)))))))
 
(de  p-cond ()
     ; paragraphe le COND courant
     (bind ((lmargin (+ (lmargin) 3)))
          (while (consp l)
             (terpri)
             (if (p-inlinep (car l))
                 (p-l (nextl l))
                 (princn #/( )
                 (let ((l (nextl l)) (f T))
                      (p-p (nextl l))
                      (when l (p-progn t)))
                 (princn #/) )))))))
 
(de  p-lmargin (f)
     ; calcule la nouvelle marge gauche
     (+ (lmargin)
        (cond
           ((listp f) 1)
           ((< (lmargin) 40)
               (if (< (plength f) 8)
                   (+ (plength f) 2)
                   4))
           ((< (lmargin) 60)
               2)
           (t 0))))))))
 
(de  p-inlinep (s)
     (let ((n (- (rmargin) (outpos))))
          (tag false (p-inlinep1 s))
          (> n 0)))))
 
(de  p-inlinep1 (s)
     (cond
       ((numberp s)
          (when (< (decr n (length (explode s))) 0)
                (exit false)))
       ((atom s)
          (decr n (plength s))
          (when (<> (logand (ptype s) 128) 0)
                (decr n 2))
          (when (< n 0) (exit false)))
       ((and (eq (car s) quote) (null (cddr s)))
          (decr n)
          (p-inlinep1 (cadr s)))
       (t (decr n 2)
          (while (consp s)
                 (p-inlinep1 (nextl s))
                 (when (consp s) (decr n)))
          (when s (decr n 2) (p-inlinep1 s))))))))
 
 
;-----   Les fonctions utilisateur
 
 
(de  pprint (s)
     ; fonction utilisateur : paragraphe l'expression "s"
     (bind ((sprint T) (lmargin 0) (rmargin 76))
           (let ((f ())) (p-p s))
           (terpri))
   s)
 
(df pretty l
      ; paragraphe la liste de fonctions : "l"
      (mapc (lambda (l) (pprint (getdef l))
                        (terpri))
            l)))
 
 
(df prettyf (f . l)
      ; comme PRETTY mais le resultat est sorti sur fichier
      ; le nom du fichier est donne en 1er argument
      (output (filename f))
      (mapc (lambda (l) (pprint (getdef l))
                        (terpri))
            l)
      (output))))
 
 
(de prettyend ()
    (mapc 'remfn
          '(p-p p-p1 p-l p-progn p-cond p-lmargin p-inlinep p-inlinep1))
    (autoload pretty pprint pretty prettyf prettyend)
    'prettyend)
 
 
;-----   Pose des ptypes standards manquants
 
 
(while (setq x (read))
   (ptype x (read)))
 
 progn   1
 
 lambda  2
 let     2
 lmargin 2
 map     2
 rmargin 2
 tag     2
 unless  2
 untilexit 2
 when    2
 
 de      3
 df      3
 dm      3
 dmc     3
 
 cond    4
 
 selectq 5
 
 set     6
 setq    6
 
 ()
 ()
 

