;==========================================================================
;
;                  Le_Lisp 68K  :  la macro `  (back_quote)
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================
 
 
;;;BACKQUOTE:
;;; The flags passed back by BACKQUOTIFY can be interpreted as follows:
;;;
;;;   |`,|: [a] => a
;;;    NIL: [a] => a              the NIL flag is used only when a is NIL
;;;      T: [a] => a              the T flag is used when a is self-evaluating
;;;  QUOTE: [a] => (QUOTE a)
;;; APPEND: [a] => (APPEND . a)
;;;  NCONC: [a] => (NCONC . a)
;;;   LIST: [a] => (LIST . a)
;;;  MCONS: [a] => (MCONS . a)
;;;
;;; The flags are combined according to the following set of rules:
;;;  ([a] means that a should be converted according to the previous table)
;;;
 
 
;*****    Les trucs qui manquent
 
 
(de copysymbol (x i) x)
 
 
;*****    le vieux bllsht de Maclisp
 
(declare (special **backquote-flag**
                  **backquote-count**
                  **backquote-/,-flag**
                  **backquote-/,/@-flag**
                  **backquote-/,/.-flag**))
 
 
 
(dmc |`| () (xr-backquote-macro))
(dmc |,| () (xr-comma-macro))
 
(setq **backquote-flag**)
(setq **backquote-count** 0)
(setq **backquote-/,-flag** (copysymbol '|`,| nil))
(setq **backquote-/,/@-flag** (copysymbol '|`,@| nil))
(setq **backquote-/,/.-flag** (copysymbol '|`,.| nil))
 
 
(de xr-backquote-macro ()
    (let ((**backquote-count** (1+ **backquote-count**))
          (**backquote-flag** nil)
          (thing nil)
          (old-at-sign (typecn #/@)))
         (unwind-protect
             (progn
                (typecn #/@ 12)
                (setq thing (backquotify (read)))
                (cond ((eq **backquote-flag** **backquote-/,/@-flag**)
                           (error " "",@"" right after a ""`"" : " thing))
                      ((eq **backquote-flag** **backquote-/,/.-flag**)
                           (error " "",."" right after a ""`"" : " thing ))
                      (t  (backquotify-1 **backquote-flag** thing))))
             (typecn #/@ old-at-sign))))))
 
(de xr-comma-macro ()
    (when (<= **backquote-count** 0)
          (error "Comma not inside a backquote. " nil))
    (let ((c (peekcn)) (**backquote-count** (1- **backquote-count**)))
         (cond ((= c #/@)
                (readcn)
                (cons **backquote-/,/@-flag** (read)))
               ((= c #/.)
                (readcn)
                (cons **backquote-/,/.-flag** (read)))
               (t (cons **backquote-/,-flag** (read))))))
 
(defun backquotify (code)
   (tag ecomma
     (tag return
       (let ((aflag) (a) (dflag) (d))
             (cond ((atom code)
                    (cond ((null code)
                           (setq **backquote-flag** nil)
                           (exit return nil))
                          ((or (numberp code)
                               (eq code t))
                           (setq **backquote-flag** t)
                           (exit return code))
                          (t (setq **backquote-flag** 'quote)
                             (exit return code))))
                   ((eq (car code) **backquote-/,-flag**)
                    (setq code (cdr code))
                    (comma))
                   ((eq (car code) **backquote-/,/@-flag**)
                    (setq **backquote-flag** **backquote-/,/@-flag**)
                    (exit return (cdr code)))
                   ((eq (car code) **backquote-/,/.-flag**)
                    (setq **backquote-flag** **backquote-/,/.-flag**)
                    (exit return (cdr code))))
             (setq a (backquotify (car code)))
             (setq aflag **backquote-flag**)
             (setq d (backquotify (cdr code)))
             (setq dflag **backquote-flag**)
             (and (eq dflag **backquote-/,/@-flag**)
                  (error " "",@"" after a ""."" : " code))
             (and (eq dflag **backquote-/,/.-flag**)
                  (error " "",."" after a ""."" : " code))
             (cond ((eq aflag **backquote-/,/@-flag**)
                    (cond ((null dflag)
                           (setq code a)
                           (comma)))
                    (setq **backquote-flag** 'append)
                    (exit return (cond ((eq dflag 'append)
                                   (cons a d))
                                  (t (list a (backquotify-1 dflag d))))))
                   ((eq aflag **backquote-/,/.-flag**)
                    (cond ((null dflag)
                           (setq code a)
                           (comma)))
                    (setq **backquote-flag** 'nconc)
                    (exit return (cond ((eq dflag 'nconc)
                                   (cons a d))
                                  (t (list a (backquotify-1 dflag d))))))
                   ((null dflag)
                    (cond ((memq aflag '(quote t nil))
                           (setq **backquote-flag** 'quote)
                           (exit return (list a)))
                          (t (setq **backquote-flag** 'list)
                             (exit return (list (backquotify-1 aflag a))))))
                   ((memq dflag '(quote t))
                    (cond ((memq aflag '(quote t nil))
                           (setq **backquote-flag** 'quote)
                           (exit return (cons a d)))
                          (t (setq **backquote-flag** 'mcons)
                             (exit return (list (backquotify-1 aflag a)
                                           (backquotify-1 dflag d)))))))
             (setq a (backquotify-1 aflag a))
             (and (memq dflag '(list mcons))
                  (setq **backquote-flag** dflag)
                  (exit return (cons a d)))
             (setq **backquote-flag** 'mcons)
             (exit return (list a (backquotify-1 dflag d))))))))
 
(de comma ()
  (exit ecomma
    (cond ((atom code)
              (cond ((null code)
                     (setq **backquote-flag** nil))
                    ((or (numberp code)
                         (eq code 't))
                     (setq **backquote-flag** t)
                     t)
                    (t (setq **backquote-flag**  **backquote-/,-flag**)
                       code)))
          ((eq (car code) 'quote)
               (setq **backquote-flag** 'quote)
               (cadr code))
          ((memq (car code) '(append list mcons nconc))
               (setq **backquote-flag** (car code))
               (cdr code))
          ((eq (car code) 'cons)
               (setq **backquote-flag** 'mcons)
               (cdr code))
          (t (setq **backquote-flag** **backquote-/,-flag**)
               code)))))))))
 
 
(de backquotify-1 (flag thing)
    (cond ((or (eq flag **backquote-/,-flag**)
               (memq flag '(t nil)))
           thing)
          ((eq flag 'quote)
               (list 'quote thing))
          ((eq flag 'mcons)
               (cons (if (null (cddr thing)) 'cons 'mcons) thing))
          (t (cons flag thing))))
 
 
