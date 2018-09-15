;=================================================================
;
;    Le_Lisp  80   : la fonction de tri de liste
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'sortl 'version (version)))

 
 
(de sortl (l)
    (if (null (cdr l))
        l
        (let ((l1 l))
             (let ((l (nthcdr (1- (// (length l1) 2)) l1)))
                   (let ((l2 (prog1 (cdr l) (rplacd l ()))))
                        (ffusion (sortl l1) (sortl l2)))))))))
 
(de ffusion (l1 l2)
    (when (alphalessp (car l2) (car l1))
          (setq l1 (prog1 l2 (setq l2 l1))))
    (let ((r l1) (l1 (cdr l1)) (l2 l2))
         (cond ((null l1) (rplacd r l2))
               ((null l2) (rplacd r l1))
               ((alphalessp (car l1) (car l2))
                  (rplacd r l1)
                  (self l1 (cdr l1) l2))
               (t (rplacd r l2)
                  (self l2 l1 (cdr l2)))))
     l1))))
 
 
(de shoblist ()
    ; imprime l'OBLIST triee avec les indicateurs des fonctions
    (let ((n 0))
         (mapc (lambda (a)
               (outpos 3)
               (prin (incr n))
               (outpos 8)
               (bind ((sprint t)) (prin a))
               (when (or (typefn a) (and a (getprop a 'typefn)))
                     (outpos (max (plength a) 22))
                     (prin (or (typefn a) (getprop a 'typefn))))
               (when (and a (getprop a 'from))
                     (outpos 31)
                     (prin '|dans | (getprop a 'from)))
               (terpri))
            (sortl (oblist))))))))
 
(de indexf ()
    ; fabrique un index de l'OBLIST avec les noms de fichiers
    (mapc (lambda (f)
             (input (filename f))
             (untilexit eof
                (let ((s (read)))
                     (when (and (consp s)
                                (memq (car s) '(de df dm dmc)))
                           (putprop (cadr s) f 'from)
                           (putprop (cadr s)
                               (cassq (car s)
                                 '((de . expr) (df . fexpr)
                                   (dm . macro) (dmc . macrocar)))
                               'typefn))
                     (when (and (consp s) (eq (car s) 'setq))
                           (let ((s (cdr s)))
                                (putprop (car s) f 'from)
                                (putprop (car s)
                                        '|variable| 'typefn)
                                (and (cddr s) (self (cddr s)))))
                     (when (and (consp s) (eq (car s) 'progn))
                           (while s (self (nextl s))))))
              (input ()))
          '(startup virtty hanoi vdt pepe peptop pepln2 pepmsc pepcmd
            pepini pepesc pepato trace debug pretty impr sortl 
            virv24 loader))
     (output (filename 'oblist))
     (shoblist)
     (output ()))))
 
