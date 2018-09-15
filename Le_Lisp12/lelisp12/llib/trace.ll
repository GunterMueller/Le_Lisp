;=================================================================
;
;    Le_Lisp  80   :  TRACE et UNTRACE  (250 doublets)
;
;=================================================================
;   (c) 1983    Emmanuel Saint-James  et  Universite Paris 6
;               4 Place Jussieu, 75005 Paris
;=================================================================

#.(unless (= (version) 12)
          (syserror 'trace 'version (version)))

 
 
;-----   La variable globale trace contient la liste des fonctions tracees
 
(setq trace ())
 
 
;-----   Les fonctions de tracage
 
(df trace l
    ; trace la liste de fonctions 'l'
    ; sans capture de variables a l'impression!
    (mapcan (lambda (f)
               (ifn (and (memq (typefn f) '(expr fexpr macro))
                         (null (memq f trace)) )
                    (print '|je ne peux pas tracer | f)
                    (newr trace f)
                    (putprop f (valfn f) 'trace)
                    (valfn f
                      [(car (valfn f))
                         ['prin (kwote f) ''| ---> | ]
                         (let ((entete (kwote (flat (car (valfn f))))))
                              [ 'mapc ''prin entete ''| = |
                                     [ 'mapcar ''cval entete ] ''|  | ])
                         '(terpri)
                         ['print
                             (kwote f)
                             ''| <--- |
                             ['progn ! (cdr (valfn f))]]])
                    (list f)))
             l))
 
(de flat (l r)
    ; retourne la liste des variables contenues dans l
    (cond ((consp l) (flat (car l) (flat (cdr l) r)))
          (l (cons l r))
          (t r )))
 
 
(df untrace l
    ; enleve la trace de toutes les fonctions
    ; de la liste 'l' ou de toutes les fonctions
    ; tracees si 'l' = ()
    (mapcan (lambda (f)
                (ifn (memq f trace)
                     (print f '| n'etait pas tracee.|)
                     (valfn f (getprop f 'trace))
                     (remprop f 'trace)
                     (map (lambda (x)
                              (when (eq (cadr x) f) (rplacd x (cddr x))))
                          trace)
                      (list f)))
            (or l (cdr trace))))
 
(de tracend ()
    ; recupere la place de la TRACE
    (autoload trace trace untrace tracend)
    (setq trace ())
 

