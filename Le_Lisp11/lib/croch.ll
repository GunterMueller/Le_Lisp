;==========================================================================
;
;                  Le_Lisp 68K  :  les macros crochets [ ] et !
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================
 
;------------------------------------------------------------
;-----    Une version adaptee du crochet Le_Lisp 80
;-----            de Emmanuel Saint-James
;-----               (Saint-James.Styp)
;------------------------------------------------------------
 
;         [a b c d e]        =>           (LIST A B C D E F)
;         [a !b]             =>           (CONS A B)
;         [a b c !d]         =>           (MCONS A B C D)
;         [a !b !c !d]       =>           (CONS A (APPEND B C D))
;         [!a b !c]          =>           (APPEND A (CONS B C))
;         [!a !b c]          =>           (APPEND A B (LIST C))
 
;-----    Les fonctions qui manquent
 
(synonym 'defvar 'setq)
 
(de rplac (x a d)
    (rplaca x a)
    (rplacd x d)
    x)))
 
;-----    La variable globale d'etat
 
(defvar in-bracketp nil)
 
 
;-----    Les macros carateres eux-memes
 
(dmc |!| ()
     (if in-bracketp
         '|!|
         (syserror '|!| "pas dans un [ ]" nil)))
 
(dmc |]| ()
     (if in-bracketp
         '|]|
         (syserror '|]| "pas dans un [ ]" nil)))
 
(dmc |[| ()
     (let ((begin (list 'LIST)) (in-bracketp T))
          (readbracket begin begin (read))
          begin)))
 
 
;-----    Lecture d'un [
 
(de readbracket (begin current new)
    (cond ((eq new '|]|))
          ((neq new '|!|)
           (readbracket begin (cdr (rplacd current (list new))) (read)))
          (t (let ((elemseq (list (read))))
               (if (memq elemseq '(|!| |]|))
                   (syserror '|!| "erreur de syntaxe" elemseq)
                   (if (eq begin current)
                       (sequence (cdr (rplac begin 'APPEND elemseq)) (read))
                       (rplaca begin
                               (if (eq current (cdr begin)) 'CONS 'MCONS))
                       (let ((nextseq (read)))
                            (if (eq nextseq '|]|)
                                (rplacd current elemseq)
                                (sequence
                                     (cdadr (rplacd current
                                            (list (cons 'APPEND elemseq))))
                                     nextseq)))))))))))
 
(de sequence (last next)
    (if (eq next '|!|)
        (sequence (cdr (rplacd last (list (read)))) (read))
        (when (neq next '|]|)
              (let ((begin (list 'LIST next)))
                   (rplacd last (list begin))
                   (readbracket begin (cdr begin) (read)))))))
 
