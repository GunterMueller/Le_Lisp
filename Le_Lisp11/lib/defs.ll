;==========================================================================
;
;                  Le_Lisp 68K  :  la fonction DEFMACRO et autres DEFxxx
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================
 
 
;
;         Les fonctions qui manquent
;
 
(de constantp (x)
    (or (numberp x) (stringp x) (memq x '(nil t)))))))
 
(de variablep (x)
    (and (symbolp x) (not (memq x '(nil t)))))
 
(de fboundp (x)
    (not (ftype x)))
 
;
;   les fonctions internes de tests
;
 
(de def-check-all (name larg fnt)
    ; teste tout
    (when (or (not (variablep name))
              (def-check-larg larg))
          (syserror fnt "mauvaise definition" name)))))
 
(de def-check-larg (l)
    ; retourne T si la liste l est mauvaise
    (cond ((null l) ())
          ((atom l) (not (variablep l)))
          ((variablep (car l)) (def-check-larg (cdr l)))
          (t t))))))))
 
;
;         La protection des redefinitions STATUS-REDEF
;
 
(unless (fboundp 'de*) (synonym 'de* 'de))
(unless (fboundp 'df*) (synonym 'df* 'df))
(unless (fboundp 'dm*) (synonym 'dm* 'dm))
(unless (fboundp 'defun*) (synonym 'defun* 'defun))
 
 
(df* de (~~~l)
     (def-check-all (car ~~~l) (cadr ~~~l) 'DE)
     (when (and (not status-redef) (neq (fval (car ~~~l)) 0))
           (print "** " 'DE " : fonction redefinie : " (car ~~~l)))
     (eval (cons 'de* ~~~l)))
 
(df* df (~~~l)
     (def-check-all (car ~~~l) (cadr ~~~l) 'DF)
     (when (and (not status-redef) (neq (fval (car ~~~l)) 0))
           (print "** " 'DF " : fonction redefinie : " (car ~~~l)))
     (eval (cons 'df* ~~~l)))
 
(df* dm (~~~l)
     (def-check-all (car ~~~l) (cadr ~~~l) 'DM)
     (when (and (not status-redef) (neq (fval (car ~~~l)) 0))
           (print "** " 'DM " : fonction redefinie : " (car ~~~l)))
     (eval (cons 'dm* ~~~l)))
 
(df* defun (~~~l)
     (def-check-all (car ~~~l) (cadr ~~~l) 'DEFUN)
     (when (and (not status-redef) (neq (fval (car ~~~l)) 0))
           (print "** " 'DEFUN " : fonction redefinie : " (car ~~~l)))
     (eval (cons 'defun* ~~~l))))))
 
 
;
;         pour recuperer des definitions de fonctions
;
 
(de getdef (x)
    ; retourne la forme de definition
    (checktype 'getdef 'symbolp x)
    (selectq (ftype x)
        ((1 2 3 4 5 6 10 11 12 13)
           (mcons 'DS (ftype x) (fval x)))
        (7 (mcons 'DE x (fval x)))
        (8 (mcons 'DF x (fval x)))
        (9 (mcons 'DM x (fval x)))
        (t ()))))
 
(de getfn (x)
    ; retourne la fonction equivalente
    (checktype 'getfn 'symbolp x)
    (selectq (ftype x)
       (7 (cons 'lambda (fval x)))
       (8 (cons 'flambda (fval x)))
       (9 (cons 'mlambda (fval x)))
       (t ())))))
 
(de typefn (x)
    ; retourne le type en clair de la fonction
    (checktype 'typefn 'symbolp x)
    (selectq (ftype x)
       ((1 2 3 4 5 10 11 12 13) 'SUBR)
       (6 'FSUBR)
       (7 'EXPR)
       (8 'FEXPR)
       (9 'MACRO)
       (t ())))))
 
;
;         pour tester les macros
;
 
 
(de macroexpand (x)
    ; expanse un appel tant que l'on tombe sur une macro
    (let ((f (getdef (car x))))
         (if (eq (car f) 'dm)
             (macroexpand (apply  (cons lambda (cddr f)) (list x)))
             x)))))
 
(de macroexpand1 (x)
    ; expanse une macro un coup pour voir
    (let ((f (getdef (car x))))
         (if (eq (car f) 'dm)
             (apply (cons lambda (cddr f)) (list x))
             x))))
 
 
;
;          DEFMACRO  :  a la machine lisp, DESETQee et DISPLACEe
;
 
(de flat (l)
       (let ((r)) (flat-aux l) r))))
 
(de flat-aux (l)
       (cond
         ((null l) ())
         ((atom l) (setq r (cons l r)))
         (t (flat-aux (car l)) (flat-aux (cdr l)))))
 
(de deset (template values)
    (cond
         ((null template) ())
         ((symbolp template) (set template values))
         ((and (consp template) (listp values))
          (deset (car template) (car values))
          (deset (cdr template) (cdr values)))
         (t (syserror 'deset "affectation impossible"
               (list template values))))))
 
(df desetq (~~f)
    ; avant qu'il ne soit trop tard
    (deset (car ~~f) (eval (cadr ~~f))))
 
 
(df defmacro (~l)
    (eval  ['dm (car ~l) '(~l)
               ['let (mapcar 'ncons (flat (cadr ~l)))
                    ['desetq (cadr ~l) '(cdr ~l)]
                    ['displace '~l (cons 'progn (cddr ~l))]
                    '~l]]))))))))))))
 
