

		llutsource.mail	12/17/82	1110.3 hfh Fri


 \#5 (485 lines)  12/10/82 20:40  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:40 hfh
From:  Chailloux.Vlsi
Subject:	ptf exll.sysini.ll TRANSFERT DU 12/10/82  1947.7 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  le fichier initial
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;------------------------------------------------------------
;	Le nouveau toplevel et le handler d'erreur
;------------------------------------------------------------

(progn		; pour etre tres silencieux
		; durant la redefinition du toplevel lisp

   ;-----  La mecanique de traitement des erreurs

   (df errset (**errset-body**)
       ; le 'catcheur' d'erreur
       (let ((**errset-flag** (eval (cadr **errset-body**) )))
	  (tag **errset-tag**
	      (ncons (eval (car **errset-body**) )))))

   (de err (l)
       (tyflush)
       (exit **errset-tag** l))

   (de errsetp () **errset-flag**)

   (dm error (call)
       (displace call ['syserror ''error (cadr call) (caddr call)]))

   (de break ()
       (print "** " 'BREAK)
       (err))

   (de syserror (f m b)
       (output ()) (tyflush)
       (when (errsetp)
	   (print "** " f " : " m " : " b)
	   (stacktracen 4))
       (err))

   ;--- et pour la suite de la lecture :

   (setq eofval (ascii 26))

   (de topread (l)
       ; lecture de la S-expr suivante
       (setq l (read))
       (if (neq l eofval)
	 l
	 (input)
	 (topread)))

   (setq - () + () * () )

   (de toplevel ()
       (setq ; l'ancienne forme lue
	   - +
	   ; la nouvelle forme lue
	   + (car (errset (catch-all-but **errset-tag** (read)) t))
	   ; la valeur de l'evaluation
	   * (errset (catch-all-but **errset-tag** (eval +)) t))
       (when (and (listp *) status-toplevel) (print "= " (car *)))
       (setq * (car *)))


   ; petit reglage du print

   (printline 5000)

   "Chargement de EXLL.SYSINI.LL"

))) ; du PROGN


;------------------------------------------
;	Les variables globales
;------------------------------------------

(setq   status-toplevel () )

(setq   status-redef () )

(setq   loaded-from-file () )

(setq   default-sys-directory  "LLIB.")


;--------------------------------------------------
;	Les fonctions qui manquent
;	et qui sont vriment indispensables
;--------------------------------------------------

(df dmd (l)
    ; realise un DM avec displace
    (eval  ['dm (car l) (cadr l) ['displace (caadr l)
			         ['progn . (cddr l)]]])))

(de concat (at1 at2)
    (implode (append (explode at1) (explode at2))))))

(setq gensym-counter 100)

(de gensym (n)
    (when (numberp n) (setq gensym-counter n))
    (concat 'G (incr gensym-counter)))

(dmd incr (call)
     ['setq (cadr call)
        (if (caddr call) ['+ (cadr call) (caddr call)]
		     ['1+ (cadr call)])])

(dmd decr (call)
     ['setq (cadr call)
        (if (caddr call) ['- (cadr call) (caddr call)]
		     ['1- (cadr call)])])

(de pairlis (-l1- -l2- -al-)
   (if (null -l1-)
      -al-
      (cons (cons (car -l1-) (car -l2-))
	(pairlis (cdr -l1-) (cdr -l2-) -al-))))

(dm untilexit (l)
     (displace l ['tag (cadr l) ['while t . (cddr l)]]))))))))

(de teread () nil)

;;; il faudait que je me mette .....

(de allcar (l)
    (if (null l) () (cons (caar l) (allcar (cdr l)))))

(de allcdr (l)
    (if (null l) () (cons (cdar l) (allcdr (cdr l)))))

(de maplist (f . l)
    (maplistaux l))

(de maplistaux (l)
    (when (car l)
	(cons (apply f l)
	      (maplistaux (allcdr l)))))

(de mapcar (f . l)
    (mapcaraux l))

(de mapcaraux (l)
    (when (car l)
	(cons (apply f (allcar l))
	      (mapcaraux (allcdr l)))))

(de mapcon (f . l)
    (mapconaux l))

(de mapconaux (l)
    (when (car l)
	(nconc (apply f l)
	       (mapconaux (allcdr l)))))

(de mapcan (f . l)
    (mapcanaux l))

(de mapcanaux (l)
    (when (car l)
	(nconc (apply f (allcar l))
	       (mapcanaux (allcdr l)))))



;;; helas encore actuellement (desole JMH)

(de deposit-byte (num position size byte)
    (let ((byte1 (mask-field (logshift byte position) position size))
	(numr  (logand num (1- (2** position))))
	(numl  (logshift
	         (logshift num (- (+ size position)))
	         (+ size position))))
         (+ byte1 numl numr))))))

(de deposit-field (num position size byte)
    (let ((byte1 (mask-field byte position size))
	(numr  (logand num (1- (2** position))))
	(numl  (logshift
	         (logshift num (- (+ size position)))
	         (+ size position))))
         (+ byte1 numl numr))))))

;---------------------------------------------------
;	Sauvetage sur disque de fonctions
;---------------------------------------------------

(df savef (l)
    ; sauvegarde de fonctions sur disque
    ; ex d'appel :
    ; (SAVEF file at1 ... atN)  sans quote!
    (output (nextl l))
    (lmargin 0)
    (while l
      (print
         (if (symbolp (car l))
	   (getfn (nextl l))
	   (nextl l)))
      (terpri))
   (output))))


;--------------------------------------------------
;	Les macros-caracteres standards
;--------------------------------------------------

(dmc @(ASCII 12) ()
     ; ^L  :  pour charger un fichier d'extension .LL
     (let ((status-redef t))		; on peut redefinir
	['LOAD (PRINT (concat (read) ".LL"))]))))))

(dmc |\#| () (xr-sharp-macro))

(dmc |`| () (xr-backquote-macro))

(dmc |,| () (xr-comma-macro))

(dmc @(ASCII 6) ()
     ; ^F  :  appel de Emacs
     (LET ((lu (READ)))
         ['EMACS (AND lu ['QUOTE (PRINT (concat lu ".LL"))])])))

(dmc @(ASCII 24) ()
     ; ^S  :  appel du systeme experimental
     (print "Je passe en systeme experimental")
     (setq default-sys-directory "EXLLIB."))


;--------------------------------------------------
;	Autoload et fonctions Autoloads
;--------------------------------------------------

;-----	pour avoir 2 arguments et lier les variables
;-----	'status-redef' et 'loaded-from-file'

(synonym 'load* 'load)
(synonym 'loadfile* 'loadfile)

(df load (-f)
    (let ((status-redef (cadr -f))
	(loaded-from-file (car -f)))
         (errset (eval (list 'load* (car -f))) t)
         (car -f))))))

(de loadfile (f i)
    (let ((status-redef i)
	(loaded-from-file f))
         (errset (loadfile* f) t)
         f)))

;-----	Load et Autoload  systeme

(dm sys-load (l)
    ['load (concat default-sys-directory (cadr l))]))

(df sys-autoload (l)
    ; definition de fonctions systeme autoload
    ; (sys-autoload file at1 ... atN)
    (mapc (lambda (a)
        (eval ['DM a '(l)
	         ['FTYPE (kwote a) 0]
	         ['sys-load (car l)]
	         'l]))
        (cdr l)))))

(df autoload (l)
   ; definition de fonction autoload
   ; (autoload fichier at1 ... atn)
   (mapc (lambda (a)
      (eval ['dm a '(l)
	       ['ftype (kwote a) 0]
	       ['load  (car l)]

  'l]))
      (cdr l)))


(sys-autoload "BACKQ.LL" xr-backquote-macro xr-comma-macro)
(sys-autoload "SHARPM.LL" xr-sharp-macro)

(sys-autoload "STACKTR.LL" stacktrace stacktracen)
(sys-autoload "DEFS.LL" defmacro macroexpand)
(sys-autoload "TRACE.LL" trace untrace)
(sys-autoload "PRETTY.LL" pretty pprint)
(sys-autoload "STREAMO.LL" stream-output)
(sys-autoload "CLOSURE.LL" closure)
(sys-autoload "PROGDO.LL" for prog do)
(sys-autoload "LETN.LL" let-named)
(sys-autoload "BACKTRAC.LL" backtrack)
(sys-autoload "SORT.LL" sortl)

(sys-autoload "EMACS.LL" emacs)
(sys-autoload "EHP.LL" ehp hp2621)
(sys-autoload "EMI.LL" emi)
(sys-autoload "EXOR155.LL" e155 exor155)
(sys-autoload "TAB132.LL" tab132)

(sys-autoload "LOADER.LL" loader)
(sys-autoload "LLCP.LL" compile compiler compilef)

(sys-autoload "COLFONT.LL" colfont)
(sys-autoload "LUCIFER.LL" lucifer)
(sys-autoload "LUCIOLE.LL" luciole luc)


;-----	Tassage d'un fichier disque

(de packfile ()
    ; tasse un fichier disque
    (prin "Fichier d'entree	") (flush) (setq fi (read))
    (prin "Fichier de sortie	") (flush) (setq fo (read))
    (errset (progn
       (input fi) (output fo)
       (untilexit eof
	  (if (eq (print (read)) EOFVAL) (exit eof))))
       t)
    (input () )
    (output () )
    fo))))))


;------------------------------------------------------------
;	Construction de l'environnement standard
;------------------------------------------------------------


(de save-std (msg)
    ; sauve une image standard
    (gc t)
    (save-core 'llinit.sysstd.)
    (initasq)
    (initbrk)
    (setbrk 1)
    msg)

(de load-std ()
    ; charge l'image standard
    (mapc (lambda (x)
	   (setq x (concat default-sys-directory x))
	   (print "Je charge " x)
	   (loadfile x))
	'(; Macros
	  SHARPM.LL
	  BACKQ.LL
	  STACKTR.LL
	  DEFS.LL
	  TRACE.LL
	  PRETTY.LL
	  STREAMO.LL
	  CLOSURE.LL
	  PROGDO.LL
	  LETN.LL
	  BACKTRAC.LL
	  SORT.LL
	  LHELP.LL
	  ; Chargeur et Compilateur
;	   LOADER.LL
;	   LLCP.LL
;	   LLCPA.LL
;	   LLCPM.LL
;	   LLCPE.LL
;	   LLCPG.LL
	  ; Emacs
	  EMACS.LL
	  IO.LL
	  TOPLEVEL.LL
	  COMMANDS.LL
	  EXTENDED.LL
	  BUFFER.LL
	  KILL.LL
	  FILES.LL
	  SEARCH.LL
	  WORDS.LL
	  MACROS.LL
	  LLMODE.LL
	  HP2621.LL
	  ; pour les LUC*
	  COLFONT.LL
	))
     (save-std "Systeme standard.")
))))))


;------------------------------------------------------------
;	Manipulation de l'environnement experimental
;------------------------------------------------------------


(de save-exl ()
    ; sauvetage de l'image memoire experimentale
    (progn (gc t)
	 (save-core 'core:.exll.exll.)
	 (initasq)
	 (initbrk)
	 (setbrk 1)
	 "Systeme experimental sur core:.exll.exll.")))

(de load-exl ()
    (mapc (lambda (x)
	   (print "Je charge " x)
	   (loadfile x))
	'(; Macros
	  LLUT.SHARPM.LL
	  LLUT.BACKQ.LL
	  LLUT.STACKTR.LL
	  LLUT.DEFS.LL
	  LLUT.TRACE.LL
	  LLUT.PRETTY.LL
	  LLUT.STREAMO.LL
	  LLUT.CLOSURE.LL
	  LLUT.PROGDO.LL
	  LLUT.LETN.LL
	  LLUT.BACKTRAC.LL
	  LLUT.SORT.LL
	  LLUT.LHELP.LL
	  ; Chargeur et Compilateur
	  LLAP.LOADER.LL
	  LLCP.LLCP.LL
	  LLCP.LLCPA.LL
	  LLCP.LLCPM.LL
	  LLCP.LLCPE.LL
	  LLCP.LLCPG.LL
	  ; Emacs
	  EMACS.EMACS.LL
	  EMACS.IO.LL
	  EMACS.TOPLEVEL.LL
	  EMACS.COMMANDS.LL
	  EMACS.EXTENDED.LL
	  EMACS.BUFFER.LL
	  EMACS.KILL.LL
	  EMACS.FILES.LL
	  EMACS.SEARCH.LL
	  EMACS.WORDS.LL
	  EMACS.MACROS.LL
	  EMACS.LLMODE.LL
	  ECTLS.HP2621.LL
	  ; pour les LUCxxx
	  LLUT.COLFONT.LL
	 ))
     (print " (llcp-exl)  pour compiler l'environnement exl")
     (save-exl))))

(de llcp-exl ()
    ; compilation de l'environnement experimental
    (compile p-p t)
    (emacs-llcp)
    (compile loader t)
    (compile (compilindic compiledef) t)
    (compile-all-in-core)
    (save-core 'core:.exll.exec.)
    "Systeme compile sur CORE:.EXLL.EXEC."))


;--------------------------------------------
;	Final de l'initialisation
;--------------------------------------------

(progn


   (setq STATUS-TOPLEVEL t)
   (rmargin 78)
   (print  " (load-std)  pour charger l'environnement std")
   (print  " (load-exl)  pour charger l'environnement exl")
   (print  " (load-emx)  pour charger Emacs")
   'LLIB.STARTUP.LL
)))


(input () )






 ---(5)---

\014 \#6 (125 lines)  12/10/82 20:40  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:40 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.sharpm.ll TRANSFERT DU 12/10/82  1947.7 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  la macro \#  (sharp-macro)
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



(de xr-sharp-macro ()
    ; fonction lancee par \# (cf: sysini.ll)
     (let ((c (readch)))
	(let ((f (getprop c 'sharp-macro)))
	     (if f
	         (apply f ())
	         (syserror 'sharp-macro "selecteur inconnu" c)))))

(df defsharp (l)
    ; definition d'une nouvelle macro-sharp
    (putprop (car l) (cons lambda (cdr l)) 'sharp-macro)
    (car l))


;	Les Macros


(defsharp |.| ()
    ; retourne la valeur d'une evaluation au moment du READ
    (eval (read)))

(defsharp |+| ()
    ; eval conditionnel
    (if (eval (read)) (eval (read)) (read)))

(defsharp |-| ()
    ; eval conditionnel
    (if (eval (read)) (read) (eval (read))))

(defsharp |/| ()
    ; retourne le code ascii du caractere
    (let ((n (readcn)))
         (if (eq (peekcn) 124)   ; i.e	val
	   (sharp-lowbyte n)
	   n))))

(defsharp |\| ()
    ; retourne une valeur
    (let ((l (read)))
         (let ((n (getprop l 'sharp-value)))
	    (ifn n
	         (syserror '|\#| "\ :	pas de valeur pour" l)
	         (if (eq (peekcn) 124)  ; i.e. val abs
		   (sharp-lowbyte n)
		   n))))))))

(mapc
   (lambda (x y) (putprop x y 'sharp-value))
   '(null bell bs tab lf cr eof esc sp del rubout)
   '(0	7    8  9   10 13 26  27  32 127 127)))))

(defsharp |^| ()
    ; retourne la valeur d'un caractere control
    (let ((n (logand 31 (readcn))))
         (if (eq (peekcn) 124)  ; i.e. val abs
	   (sharp-lowbyte n)
	   n))))))

(de sharp-lowbyte (n)
    ; si on a une val abs apres
    (readcn)  ; saute le val abs
    (let ((n1 (logshift n 8)) (n2 (readcn)))
         (selectq n2
	(47 ; i.e le slash
	  (+ n1 (readcn)))
	(94 ; i.e. chapeau
	  (+ n1 (logand 31 (readcn))))
	(92 ; i.e le backslash
	  (let ((n (getprop (read) 'sharp-value)))
	       (if n
		 (+ n1 n)
		 (syserror '|\#| "\	: pas de valeur pour" ))))
        (t  ; tous les autres
	  (+ n1 (readcn)))))))))

(defsharp |"| ()
   ; retoure la liste des codes ascii
   (let ((l) (i))
        (untilexit finl
	 (if (= (setq i (readcn)) \#/")
	     (exit finl (kwote (nreverse l)))
	     (newl l i)))))))

(defsharp |$| ()  ($-aux 4 0 (peekcn))))

(de $-aux (n a c)
    ; lecture d'un nb hexa : a refaire avec peekcn et reread!!!
         (if (setq c (cassq c
	     '((48 . 0)(49 . 1)(50 . 2)(51 . 3)
	       (52 . 4)(53 . 5)(54 . 6)(55 . 7)
	       (56 . 8)(57 . 9)(65 . 10)(97 . 10)(66 . 11)(98 . 11)
	       (67 . 12)(99 . 12)(68 . 13)(100 . 13)
	       (69 . 14)(101 . 14)(70 . 15)(102 . 15))))
	   (progn (readcn) ($-aux (1- n) (+ (* a 16) c) (peekcn)))
	   (cond
	       ((= n 4) (syserror '|\#|
			 "$ : il faut 1 moins 1 chiffre hexa" ))
	       ((< n 0) (syserror '|\#|
			 "$ : plus de 4 chiffres hexa" n))
	       (t a))))))))

(defsharp |%| ()  (%-aux 16 0 (peekcn))))))

(de %-aux (n a c)
    ; lecture d'un nb binaire : a refaire avec peekcn & reread
         (if (setq c (cassq c '((48 . 0) (49 . 1))))
	   (progn (readcn) (%-aux (1- n) (+ (* a 2) c) (peekcn)))
	   (cond
	       ((= n 16) (syserror '|\#|
			 "% : il faut 1 moins 1 chiffre binaire" ))
	       ((< n 0) (syserror '|\#|
			 "% : plus de 16 chiffres binaires" n))
	       (t a))))))))


 ---(6)---

\014 \#7 (183 lines)  12/10/82 20:41  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:41 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.backq.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  la macro `  (back_quote)
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;;;BACKQUOTE:
;;; The flags passed back by BACKQUOTIFY can be interpreted as follows:
;;;
;;;   |`,|: [a] => a
;;;    NIL: [a] => a	    the NIL flag is used only when a is NIL
;;;      T: [a] => a	    the T flag is used when a is self-evaluating
;;;  QUOTE: [a] => (QUOTE a)
;;; APPEND: [a] => (APPEND . a)
;;;  NCONC: [a] => (NCONC . a)
;;;   LIST: [a] => (LIST . a)
;;;  MCONS: [a] => (MCONS . a)
;;;
;;; The flags are combined according to the following set of rules:
;;;  ([a] means that a should be converted according to the previous table)
;;;


;*****	Les trucs qui manquent


(de copysymbol (x i) x)


;*****	le vieux bllsht de Maclisp

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
	(old-at-sign (typecn \#/@)))
         (unwind-protect
	   (progn
	      (typecn \#/@ 12)
	      (setq thing (backquotify (read)))
	      (cond ((eq **backquote-flag** **backquote-/,/@-flag**)
		       (error " "",@"" right after a ""`"" : " thing))
		  ((eq **backquote-flag** **backquote-/,/.-flag**)
		       (error " "",."" right after a ""`"" : " thing ))
		  (t  (backquotify-1 **backquote-flag** thing))))
	   (typecn \#/@ old-at-sign))))))

(de xr-comma-macro ()
    (when (<= **backquote-count** 0)
	(error "Comma not inside a backquote. " nil))
    (let ((c (peekcn)) (**backquote-count** (1- **backquote-count**)))
         (cond ((= c \#/@)
	      (readcn)
	      (cons **backquote-/,/@-flag** (read)))
	     ((= c \#/.)
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


 ---(7)---

\014 \#8 (173 lines)  12/10/82 20:42  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:42 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.defs.ll TRANSFERT DU 12/10/82	1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  la fonction DEFMACRO et autres DEFxxx
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;
;	Les fonctions qui manquent
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

(de def-check-larg (  ; retourne T si la liste l est mauvaise
    (cond ((null l) ())
	((atom l) (not (variablep l)))
	((variablep (car l)) (def-check-larg (cdr l)))
	(t t))))))))

;
;	La protection des redefinitions STATUS-REDEF
;

(unless (fboundp 'de*) (synonym 'de* 'de))
(unless (fboundp 'df*) (synonym 'df* 'df))
(unless (fboundp 'dm*) (synonym 'dm* 'dm))
(unless (fboundp 'defun*) (synonym 'defun* 'defun))


(df* de (---l)
     (def-check-all (car ---l) (cadr ---l) 'DE)
     (when (and (not status-redef) (neq (fval (car ---l)) 0))
	 (print "** " 'DE " : fonction redefinie : " (car ---l)))
     (eval (cons 'de* ---l)))

(df* df (---l)
     (def-check-all (car ---l) (cadr ---l) 'DF)
     (when (and (not status-redef) (neq (fval (car ---l)) 0))
	 (print "** " 'DF " : fonction redefinie : " (car ---l)))
     (eval (cons 'df* ---l)))

(df* dm (---l)
     (def-check-all (car ---l) (cadr ---l) 'DM)
     (when (and (not status-redef) (neq (fval (car ---l)) 0))
	 (print "** " 'DM " : fonction redefinie : " (car ---l)))
     (eval (cons 'dm* ---l)))

(df* defun (---l)
     (def-check-all (car ---l) (cadr ---l) 'DEFUN)
     (when (and (not status-redef) (neq (fval (car ---l)) 0))
	 (print "** " 'DEFUN " : fonction redefinie : " (car ---l)))
     (eval (cons 'defun* ---l))))))


;
;	pour recuperer des definitions de fonctions
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
;	pour tester les macros
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
;	 DEFMACRO  :  a la machine lisp, DESETQee et DISPLACEe
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

(df desetq (-f)
    ; avant qu'il ne soit trop tard
    (deset (car -f) (eval (cadr -f))))


(df defmacro (-l)
    (eval  ['dm (car -l) '(-l)
	     ['let (mapcar 'ncons (flat (cadr -l)))
		['desetq (cadr -l) '(cdr -l)]
		['displace '-l (cons 'progn (cddr -l))]
		'-l]]))))))))))))



;
;	Les  DEFVAR (oui, c'est encore un peu leger)
;

(synonym 'defvar 'setq)


 ---(8)---

\014 \#9 (18 lines)	12/10/82 20:42  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:42 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.letn.ll TRANSFERT DU 12/10/82	1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  la fonction LET-NAMED
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================

; encore un joli coup de la macro backquote

(defmacro let-named (name larg . body)
      `(flet (,name ,(mapcar 'car `,larg) ,@body)
	   (,name ,@(mapcar 'cadr `,larg)))))))))




 ---(9)---

\014 \#10 (93 lines)  12/10/82 20:43  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:43 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.stacktr.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  traces de la pile et tests de type
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;*****	Points d'entree autoload :
;	stacktracen	visualise 'n' blocks de la pile
;	stacktrace	visualise toute la pile


(de stacktracen (n)
    ; imprime une trace de la pile jusqu'a 'n' niveaux
    (let ((l (cur-stack)))
         (repeat n (stacktrace1 (length l) (nextl l) ))))))

(de stacktrace ()
    ; imprime une trace de toute la pile
    (let ((l (cur-stack)))
         (while l (stacktrace1 (length l) (nextl l))))))))

(de stacktrace1 (n obj)
    ; imprime 1 frame de la pile (de profondeur n)
    (if (null obj)
        ()         ; trop profond
        (prin "   [stack " n "]")
        (outpos 16)
        (selectq (car obj)
	  ; sur le type du bloc
	  (0  ; type lambda
	      (print "(" (or (and (symbolp (cadr obj)) (cadr obj))
			 (findfn (cadr obj))
			 '|let|)
		   " ..."))
	  (1  ; type label
	      (print "(label " (cadr obj) " ..."))
	  (2  ; type escape
	      (print "(tag " (cadr obj) " ..."))
	  (3  ; type stepeval
	      (print "(stepeval " (cadr obj) " " (caddr obj) ")"))
	  (4  ; type catch-all-but
	      (print "(catch-all-but " (cadr obj) " ..."))
	  (5  ; type uwind-protect
	      (print "(unwind-protect ..."))
	  (t  ; type erronne
	      (print "** bloc inconnu : " (car obj))))))))))


(de cur-stack ()
    ; retourne le contenu courant de la pile
    ; en enlevant la tete et la queue (utilisees par le systeme)
    (let ((l (cstack)))
         (repeat 4 (nextl l))
         (setq l (nreverse l))
         (repeat 6 (nextl l))
         (nreverse l))))))


;*****	tests de type


(de typerror (f m a)
    ; provoque une erreur de type
    (syserror f
	    (if (symbolp m)
	        (selectq m
		  ((null not) "l'argument n'est pas NIL")
		  (numberp    "l'argument n'est pas un nombre")
		  (stringp    "l'argument n'est pas une chaine")
		  (symbolp    "l'argument n'est pas un symbole")
		  (variablep  "l'argument n'est pas une variable")
		  (consp	    "l'argument n'est pas une liste")
		  (t	    "l'argument n'est pas du bon type"))
	        "l'argument n'est pas du bon type")
	    a)))



(de checktype (f p a)
    ; dans la fonction : f
    ; teste avec le predicat : p
    ; l'argument : a
    (or (applyn p a)
        (typerror f p a))))





 ---(10)---

\014 \#11 (53 lines)  12/10/82 20:43  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:43 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.trace.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  TRACE et UNTRACE
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;   La variable TRACE contient le nom des fonctions qui sont actuellement
;   tracees. Cette variable est utilisee par UNTRACE.

(defvar TRACE ())

(df trace (l)
    ; trace la liste de fonctions 'l'
    (mapc 'trace1 l)
    TRACE))

(de trace1 (f)
    ; trace la fonction 'f'
    (let ((fval (fval f)))
         (cond
	  ((atom fval)
	      (print 'TRACE " : je ne peux pas tracer " f))
	  ((getprop f 'trace)
	      (print 'TRACE " la fonction " f " est deja tracee"))
	  (t
	   (newl trace f)
	   (putprop f fval 'trace)
	   (fval f
	      `(,(car fval)
	        (print ',f '| ---> | (list ,@(car fval)))
	        (print ',f '| <--- | (progn ,@(cdr fval)))))))))


(df untrace (l)
    ; enleve la trace de la liste de fonctions "l"
    ; ou bien de toutes les fonctions precedemment tracees.
    (mapc (lambda (f)
	   (let ((fval (getprop f 'trace)))
	      (if (atom fval)
		(print f " n'etait pas tracee.")
		(fval f fval)
		(setq trace (remq f trace))
		(remprop f 'trace))))
	(or l trace))
    TRACE)))))))




 ---(11)---

\014 \#12 (209 lines)  12/10/82 20:44  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:44 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.pretty.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  le PRETTY-PRINT interprete
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



(de p-p (l)
    (cond
       ((null l) (princh "(") (princh ")"))
       ((atom l) (prin l))
       ((and (eq (car l) quote) (null (cddr l)))
	(princh "'")
	(p-p (cadr l)))
       ((and (consp (car l)) (eq (caar l) lambda)) (p-let))
       ((inlinep l) (p-l l))
       (t (princh "(")
	(p-p (car l))
	(selectq (if (symbolp (car l)) (ptype (nextl l)) (nextl l) t)
	   (1 (p-progn))
	   (2 (p-p1) (p-progn t))
	   (3 (p-p1) (p-p1) (p-progn t))
	   (4 (p-cond))
	   (5 (p-p1) (p-cond))
	   (6 (t+ 4)
	      (while l (p-p1) (p-p1) (if l (terpri)))
	      (t- 4))
	   (t (p-progn)))
	(and
	   l
	   (princh " ")
	   (princh ".")
	   (princh " ")
	   (prin l))
	(princh ")"))))

(de p-p1 () (princh " ") (t+ 1) (p-p (nextl l)) (t- 1))

(de p-l (l)
    (princh "(")
    (p-p (nextl l))
    (while (consp l) (p-p1))
    (if l (progn (princh " ") (princh ".") (princh " ") (prin l)))
    (princh ")"))

(de p-progn (?)
    (if (and (null (cdr l)) (null ?))
        (p-p1)
        (t+ 4)
        (while (consp l)
	 (if (numberp (car l))
	     (p-p1)
	     (if (< (outpos) (lmargin))
	         (outpos  (lmargin))
	         (terpri))
	     (p-p (nextl l))))
       (t- 4)))

(de p-cond ()
    (t+ 4)
    (while (consp l)
       (terpri)
       (if (inlinep (car l))
	 (p-l (nextl l))
	 (princh "(")
	 (let ((l (nextl l))) (p-p (nextl l)) (if l (p-progn t)))
	 (princh ")")))
    (t- 4))

(de p-let ()
    (p-p (mcons
	  'let
	  (p-let-aux (cadar l) (cdr l) ())
	  (cddar l)))))))

(de p-let-aux (l1 l2 l)
    (if (null l1)
        (nreverse l)
        (p-let-aux
	        (cdr l1)
	        (cdr l2)
	        (cons (cons (car l1) (cons (car l2) ())) l)))))))

(de t+ (n) (lmargin (+ (lmargin) n)))

(de t- (n) (lmargin (- (lmargin) n)))

(de inlinep (s n)
    (setq n (- (rmargin) (outpos)))
    (tag false (inlinep-aux s))
    (> n 0))))

(de inlinep-aux (s)
    (cond
       ((numberp s)
	(setq n (- n (length (explode s))))
	(if (< n 0) (exit false)))
       ((atom s)
	(setq n (- n (plength s)))
	(if (<> (logand (ptype s) 128) 0)
	    (setq n (- n 2)))
	(if (< n 0) (exit false)))
       ((and (eq (car s) quote) (null (cddr s)))
	(setq n (1- n))
	(inlinep-aux (cadr s)))
       (t (setq n (- n 2))
	(while (consp s)
	   (inlinep-aux (nextl s))
	   (if (consp s) (setq n (1- n))))
	(if s (progn (setq n (- n 2)) (inlinep-aux s))))))

(de pprint (s)
    (lmargin 0)
    (rmargin 76)
    (p-p s)
    (terpri)
    s)

(df pretty (l) (pprint (getdef (car l))) (car l))


(df prettyf (f)
    (let ((fi (concat (car f) ".LL"))
	(fo (concat (car f) ".LS")))
         (unless (input fi)
	       (syserror 'prettyf "fichier inexistant" fi))
         (output fo)
         (untilexit eof
		(errset
		   (let ((l (read)))
		        (if (= l \#^z) (exit eof) (pprint l)))
		   t))
         (input)
         (output)
         fo))


; pose des p11:15
types standard

(while (setq x (read))
   (ptype x (read)))

 and     1
 list    1
 mcons   1
 or      1
 prin    1
 print   1
 prog1   1
 progn   1

 evexit  2
 evtag   2
 exit    2
 if      2
 ifn     2
 lambda  2
 let     2
 map     2
 mapc    2
 mapcar  2
 maplist 2
 mapcon  2
 mapcan  2
 repeat  2
 tag     2
 unless  2
 until   2
 untilexit   2
 when    2
 while   2

 de      3
 defun   3
 df      3
 dm      3
 dmd     3
 dmc     3
 defmacro 2

 defclosure	3
 defrecord	3
 defwalk		3
 lambda-named	3
 backtrack	3

 cond    4

 selectq 5

 setq    6
 setqq   6
 pset    6
 psetq   6

 ()
 ()
 ()

(print "j'ai pose les indicateurs")






 ---(12)---

\014 \#13 (29 lines)  12/10/82 20:44  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:44 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.streamo.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  la fonction stream output
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



(df stream-output (so-l)
    ; "so-l" est le PROGN a executer
    (let ((so-lo))
         ; "so-lo" est la liste des lignes retournee par STREAM-OUTPUT
         ; redefinition de l'interuption programmee EOL :
         (flet (eol ()  (let ((so-i 0) (so-r))
	         (repeat (outpos)
		    (newl so-r (outbuf so-i))
		    (outbuf so-i \#\SP)
		    (incr so-i))
	         (outpos 0)
	         (while (< (outpos) (lmargin))
		      (outbuf (outpos) \#\SP)
		      (outpos (1+ (outpos))))
	         (newl so-lo (nreverse so-r))))
	     (eprogn so-l))
         (nreverse so-lo)))


 ---(13)---

\014 \#14 (72 lines)  12/10/82 20:44  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:44 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.progdo.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  FOR/PROG/GO/RETURN/DO
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;-----	Le FOR

(defmacro for ((var init step until) . body)
     `(let ((,var ,init)
	  (*for-step* ,step))
	 (if (= *for-step* 0)
	     (syserror 'for "increment nul" *for-step*)
	     (while ((if (> *for-step* 0) '<= '>=) ,var ,until)
		  ,@body
		  (incr ,var *for-step*))
	     t))))))


;-----	PROG/RETURN/GO


;(defmacro prog (lvar . body)
;     `(let (,@(mapcar 'ncons '`,lvar)
;	    (*prog-in* t)
;	    (*prog-body* '`,body)
;	    (*prog-result* () )
;	    (*prog-pc* () ))
;	  (setq *prog-pc* *prog-body*)
;	  (tag return
;	       (while *prog-pc*
;		    (tag go
;		         (if (symbolp (car *prog-body*))
;			   (nextl *prog-body*)
;			   (setq *prog-result*
;			         (eval (nextl *prog-body*))))))
;	       *prog-result*)))))


(de return (s)
    (if (boundp '*prog-in*)
        (exit return s)
        (syserror 'return "not in a PROG" s)))

(df go (l)
    (if (not (boundp '*prog-in*))
        (syserror 'go "not in a PROG" l)
        (setq *prog-pc* (memq (car l) *prog-body*))
        (if (null *prog-pc*)
	  (syserror 'go "unseen tag" l)
	  (exit go))))


;-----   DO  a la Mclisp


(defmacro do (lvar (test . result) . body)
    `(prog ,(mapcar 'car '`,lvar)
	 (setq ,@(mapcan '(lambda (x) (list (car x) (cadr x))) `,lvar))
	 (go *do-end*)
     *do-start*
	 ,@body
	 (setq ,@(mapcan '(lambda (x) (list (car x) (caddr x))) `,lvar))
     *do-end*
	 (if ,test
	     (return (progn ,@result))
	     (go *do-start)))))))

 ---(14)---

\014 \#15 (18 lines)  12/10/82 20:45  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:45 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.letn.ll TRANSFERT DU 12/10/82	1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  la fonction LET-NAMED
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================

; encore un joli coup de la macro backquote

(defmacro let-named (name larg . body)
      `(flet (,name ,(mapcar 'car `,larg) ,@body)
	   (,name ,@(mapcar 'cadr `,larg)))))))))




 ---(15)---

\014 \#16 (44 lines)  12/10/82 20:45  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:45 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.backtrac.ll TRANSFERT DU 12/10/82  1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi


;==========================================================================
;
;	         Le_Lisp 68K  :  la fonction de 'backtracking'
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


; on en finit pas de jouer avec le back-quote .....

(defmacro backtrack (name lvar . body)
	(unless (symbolp name)
	        (syserror 'backtrack "mauvais nom" name))
	(let ((temp (gensym)))
	     `(tag backtrack
		 ,@(if (null lvar)
		       (mapcar (lambda (e)
			        `(tag ,name ,e (exit backtrack)))
			     body)
		       `((let ((,temp (list ,@lvar)))
			    ,@(mapcar (lambda (e)
				 `(progn
				      (tag ,name ,e (exit backtrack))
				      (deset ,(kwote `,lvar) ,temp)))
			       body))))))))))


;(de testbs ()
;    (backtrack foo ()
;	     (progn (print 1)(exit foo))
;	     (progn (print 2)(exit foo))
;	     (print 3)
;	     (print 4))))))

;(de testbv (x y z)
;    (backtrack foo (x y z)
;	     (progn (print x y z)(exit foo))
;	     (progn (print y z x)(exit foo))
;	     (print z x y)
;	     (print x y z))))))


 ---(16)---

\014 \#17 (113 lines)  12/10/82 20:45  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:45 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.sort.ll TRANSFERT DU 12/10/82	1947.8 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  des tris en tout genre
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;*****	Les fonctions qui manquent

(de alphalessp (a1 a2)
    ; si elle n'est pas encore definie
    (alphalessp1 (explode a1) (explode a2)))

(de alphalessp1 (l1 l2)
    (cond ((null l1) t)
	((null l2) nil)
	((= (car l1) (car l2))
	    (alphalessp1 (cdr l1) (cdr l2)))
	((< (car l1) (car l2))
	    t)))))


;--------------------------------------------
;	Tri par echange physique
;--------------------------------------------


(de sortl-exch (l)
    ; tri par echange physique
    (let ((s (append l () )))
      (map (lambda (sl1)
	  (if (cdr l)
	      (map (lambda (sl2)
		    (if (alphalessp (car sl1) (car sl2))
		        ()
		        (rplaca sl2
			   (prog1 (car sl1)
			      (rplaca sl1 (car sl2))))))
		  (cdr sl1))))
	s)
    s))


;--------------------------------------------
;	Un TRI-FUSION qui conse a mort
;--------------------------------------------


(de tri-fusion (l)
    ; tri la liste l
    (if (null (cdr l))
        l
        (fusion (tri-fusion (moitie1 l)) (tri-fusion (moitie2 l)))))

(de moitie1 (l)
    ; retourne la 1ere moitie de l
    (let-named moitie1-1 ((l l) (n (// (length l) 2)))
         (if (<= n 0)
	   ()
	   (cons (car l) (moitie1-1 (cdr l) (1- n))))))

(de moitie2 (l)
    ; retourne la 2eme moitie de l
    (nthcdr (1+ (// (length l) 2)) l)))

(de fusion (l1 l2)
    ; fusionne les 2 listes triees
    (cond ((null l1) l2)
	((null l2) l1)
	((alphalessp (car l1) (car l2))
	   (cons (car l1) (fusion (cdr l1) l2)))
	(t (cons (car l2) (fusion l1 (cdr l2)))))))



;---------------------------------------------------
;	QUICKSORT physique sans aucun cons
;---------------------------------------------------


(de sortl (l l1 l2)
    (if (null (cdr l))
        l
        (setq l1 l
	    l  (nthcdr (1- (// (length l) 2)) l)
	    l2 (prog1 (cdr l) (rplacd l ())))
        (ffusion (sortl l1 () ())
	       (sortl l2 () ()))))))))

(de ffusion (l1 l2)
    ; fusionne physiquement les 2 listes triees
    (if (alphalessp (car l2) (car l1))
        (psetq l1 l2 l2 l1))
    (ffusion1 l1 (cdr l1) l2)
    l1)))

(de ffusion1 (r l1 l2)
    (cond ((null l1) (rplacd r l2))
	((null l2) (rplacd r l1))
	((alphalessp (car l1) (car l2))
	        (rplacd r l1)
	        (ffusion1 l1 (cdr l1) l2))
	(t (rplacd r l2)
	   (ffusion1 l2 l1 (cdr l2))
	   l1)))))






 ---(17)---

\014 \#18 (123 lines)  12/10/82 20:46  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:46 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.lhelp.ll TRANSFERT DU 12/10/82  1947.9 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  les HELP on line
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;-----	comptage de la taille d'une S-expression (toujours < 9999)

(de countcons (l)
    (let ((n 0))
         (tag countcons (countcons1 l)) n))

(de countcons1 (l)
    ; la version purement recursive fait sauter la pile!
    ; avec des trucs comme (OBLIST) !!
    ; mais attention aux lites circulaires!
    (when (consp l)
	(if (< n 9999) (incr n) (exit countcons))
	(countcons1 (car l))
	(countcons1 (cdr l)))))

;-----	Description exhaustive d'un symbole quelconque

(de describe-symbol (sym)
    (unless (symbolp sym)
	  (syserror 'describe-symbol
		  "il faut un symbole"
		  sym))
    (prin sym)
    (unwind-protect (progn
        (lmargin 18)
        (if (> (outpos) 18) (terpri) (outpos 18))
        ; la cval
        (if (boundp sym)
	  (prin "  cval: "
	        (if (eq sym (eval sym))
		  '|constant|
		  (countcons (eval sym)))))
        ; la p-list
        (if (plist sym)
	  (unless (and (get sym 'loaded-from-file)
		     (= (length (plist sym)) 2))
		(prin "  plist: " (countcons (plist sym)))))
        ; la fonction associee au symbole
        (if (typefn sym)
	  (prin "  fval: "))
        (selectq  (typefn sym)
	   ((SUBR FSUBR)
		(prin (typefn sym)))
	   ((EXPR FEXPR MACRO)
		(prin (typefn sym))
		(prin "  size: " (countcons (fval sym)))
		(when (get sym 'loaded-from-file)
		      (outpos 44)
		      (prin "  loaded-from: "
			(get sym 'loaded-from-file))))
	   (t ())))
   ; suite du UNWIND-PROTECT
   (lmargin 0)
   (terpri))
)))

 ;-----	 pour tester sous Emacs la description des symboles

(comment

(mapoblist 'describe-symbol)

(progn
    (describe-symbol 'T)
    (describe-symbol 'CAR)
    (describe-symbol 'COND)
    (describe-symbol 'PRETTY)
    (describe-symbol 'COMPILE)
    (describe-symbol 'INCR)
)
))))))

;-----	Le pattern-matching du  'list-symbols'

(de match-sym (pat dat)
   (tag match-sym-ko
        (cond
	((null pat) T)
	((null dat) (exit match-sym-ko () ))
	((atom pat) (eq pat dat))
	(t (selectq (car pat)
	      (\#/?  (match-sym (cdr pat) (cdr dat)))
	      (\#/*  (match-sym (cdr pat) dat))
	      (t	  (and (or (match-sym (uppercase (car pat))
				  (car dat))
			 (match-sym (lowercase (car pat))
				  (car dat)))
		       (match-sym (cdr pat) (cdr dat))))))
 )))))))

;-----	la superbe fonction 'list-symbols'

(de list-symbols (ls)
    (mapoblist (lambda (x)
	       (if (match-sym ls (explode x))
		 (describe-symbol x)))))))

(synonym 'lh 'list-symbols)

;-----	pour tester sous Emacs 'list-symbols'

(comment

(list-symbols \#"c")

(print
      (match-sym \#"abc*" (explode 'AXBC))
      (match-sym \#"aBc" (explode 'AbC))

   ))))))




 ---(18)---

\014 \#19 (333 lines)  12/10/82 20:47  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:47 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.testfn.ll TRANSFERT DU 12/10/82  1947.9 hfh Fri TERMINE
To:  Chailloux.Vlsi

; Le_Lisp 68K  :  test des fonctions standards  [Jerome 11/81]
;=============================================================

(progn
    (terpri () )
    (print "Debut du test des fonctions.")
    (terpri () ))


(df test (--l)
    ; la fonction de test
    (let ((?speak (nextl --l)) (lu) (val) (res))
       (untilexit eof
	(setq lu (read))
	(cond
	   ((null lu) (exit eof))
	   ((eq lu \#^Z) (exit eof))
	   ((and (listp lu) (eq (car lu) 'testt))
	       (terpri) (print (cadr lu)) (terpri))
	   (t (setq  res (read)
		   val (car (errset (eval lu () () ) t)))
	      (if (not (equal val res))
		(print "***** la valeur de " lu " est " res " pas " val)
		(if ?speak (print "      " lu " = " res))))))))))



; Appel de la fonction de test


(test    T)



         (testt "Fonctions d'evaluation.")


(eval '(1+ 55))			56
(eval ['+ 8 '(1+ 3)])		12
;(eval '(2 '(a b c)))		b
(eval '((car '(cdr)) '(a b c)))	(b c)

(evlis '((1+ 4)(1+ 5)(1+ 6))) 	(5 6 7)

(eprogn '(1 2 3))			3
(progn)				NIL
(progn 1 2 3)			3
(prog1 1 2 3)			1

'a				a
''a				'a
'''a				''a

(lambda (x) x)			(lambda (x) x)
(internal)			(internal)

         (testt "Fonctions d'application.")

(apply (lambda (x y) (+ x y)) '(1 2))	         3
(apply '+ '(2 3))			         5
(applyn '+ 3 4)			         7


         (testt "Macro standard LET.")

(setq l '(let () 'foo))		         (let () 'foo)
(eval l)				         foo
 l				         ((lambda () 'foo))
(setq l '(let ((x 2)(y 3)) (* x y)))	         (let ((x 2)(y 3)) (* x y))
(eval l)				         6
 l				         ((lambda (x y)(* x y)) 2 3)


         (testt "Fonctions de controle.")

(if t 1 2 3)			         1
(if nil 1 2 3)			         3

(ifn t 1 2 3)			         3
(ifn nil 1 2 3)			         1

(or)				         nil
(or nil)				         nil
(or nil nil 2 3)			         2

(and)				         T
(and nil) 			         nil
(and 1)				         1
(and 1 2 3 4)			         4
(and 1 2 () 4)			         nil

(cond (nil 1 2) (t 3 4 5))		         5

;----- SELECTQ
;----- WHILE
;----- UNTIL

         (testt "Predicats de base.")

(atom ()) 			         T
(atom "arg")			         T
(atom 'a) 			         T
(atom 42) 			         T
(atom '(a b))			         NIL

(litatom ())			         T
(litatom "arg")			         T
(litatom 'a)			         T
(litatom 42)			         NIL
(litatom '(a b))			         NIL

(numbp ())			         NIL
(numbp "arg")			         NIL
(numbp 'a)			         NIL
(numbp 42)			         42
(numbp '(a b))			         NIL

(numberp ())			         NIL
(numberp "arg")			         NIL
(numberp 'a)			         NIL
(numberp 42)			         t
(numberp '(a b))			         NIL

(listp ())			         NIL
(listp "arg")			         NIL
(listp 'a)			         NIL
(listp 42)			         NIL
(listp '(a b))			         (a b)

(eq 'a (car '(a)))			         t
(eq "ARG" 'ARG)			         t
(eq (1+ 119) 120)			         t
(eq '(a b) '(a b))			         nil
(setq l '(a b c))			         (a b c)
(eq l l)				         t

(equal "Foo bar" "Foo bar")		         t
(equal 1214 (1+ 1213))		         1214
(equal '(a (b . c) d) '(a (b . c) d))	         t
(equal '(a b c d) '(a b c . d))	         nil

(nequal "Foo bar" "Foo bar")		         nil
(nequal 1214 (1+ 1213))		         nil
(nequal 1215 1214)			         1215
(nequal '(a (b . c) d) '(a (b . d) d))	         t

(null nil)			         t
(null t)				         nil

(boundp ())			         t
(boundp t)			         t
(boundp 'sur-qu-il-existe-pas)	         nil


         (testt "Fonctions de recherche")

(setq x '(a b))			(a b)
(cval 'x) 			(a b)

(car '(a . b))			a
(cdr '(a . b))			b
(caar '((a . c) b . d))		a
(cadr '((a . c) b . d))		b
(cdar '((a . c) b . d))		c
(cddr '((a . c) b . d))		d
(setq l '(((a . e) c . g) (b . f) d . h)) (((a . e) c . g) (b . f) d . h)
(caaar l) 			a
(caadr l) 			b
(cadar l) 			c
(caddr l) 			d
(cdaar l) 			e
(cdadr l) 			f
(cddar l) 			g
(cdddr l) 			h
(setq l '((((a . i) e . m) (c . k) g . o) ((b . j) f . n) (d . l) h . p) l1 ()
)
				()
(caaaar l)			a
(caaadr l)			b
(caadar l)			c
(caaddr l)			d
(cadaar l)			e
(cadadr l)			f
(caddar l)			g
(cadddr l)			h
(cdaaar l)			i
(cdaadr l)			j
(cdadar l)			k
(cdaddr l)			l
(cddaar l)			m
(cddadr l)			n
(cdddar l)			o
(cddddr l)			p

(memq 'c '(a b c d e))		         (c d e)
(memq 'z '(a b c d e))		         nil

(member 'c '(a b c d e))		         (c d e)
(member 'z '(a b c d e))		         nil
(member '(a b) '(a (a b) c))		         ((a b) c)

(nth 3 '(a b c d e f))		         (c d e f)
(nth 10 '(a b c d e . f))		         nil
(nth 1 '(a b))			         (a b)
(nth 0 '(a b))			         (a b)
(nth -100 '(a b))			         (a b)

(cnth 3 '(a b c d e f))		         c
(cnth 100  '(a b c))		         nil

(last 120)			         120
(last '(a b c))			         (c)
(last '(a b c . d)) 		         (c . d)


         (testt "Fonctions creation listes")


(cons 'a () )			         (a)
(cons 'a 'b)			         (a . b)

(xcons 'a () )			         (NIL . a)
(xcons 'a 'b)			         (b . a)

(ncons () )			         (NIL)
(ncons 'a)			         (a)

(mcons)				         ()
(mcons 'a)			         a
(mcons 'a 'b)			         (a . b)
(mcons 'a 'b 'c)			         (a b . c)
['a 'b . 'c]			         (a b . c)
(mcons 'a 'b 'c 'd) 		         (a b c . d)

(kwote () )			         (quote NIL)
(kwote 'a)			         (quote a)
(kwote '(a b c))			         (quote (a b c))

(list)				         ()
['a 'b 'c]			         (a b c)

(append '(a b c) () )		         (a b c)
(append () '(d e f))		         (d e f)
(append '(a b c) '(d e f))		         (a b c d e f)

(reverse 'a () )			         NIL
(reverse '(a b c) () )		         (c b a)
(reverse '(a b c) '(d e f))		         (c b a d e f)
(reverse '(x y z) 'a)		         (z y x . a)

(copy 'a) 			         a
(copy '(a b (c (d . e) . f))) 	         (a b (c (d . e) . f))

(subst 'z 'a '(a c (d a)))		         (z c (d z))
(subst () () '(a b c))		         (a b c)

(substitute '(x y z) 'a '(a c (d a)))	         ((x y z) c (d (x y z)))
(substitute 'a '(x y) '(b (x y) (d x y) (x y z)))          (b a (d . a) (x y z
))


         (testt "Fonctions de modification")

(setq x '(a b))			         (a b)
(rplaca x '(c))			         ((c) b)
 x				         ((c) b)

(setq x '(s t))			         (s t)
(rplacd x '(u))			         (s u)
 x				         (s u)

(setq l1 '(a b c))			         (a b c)
(setq l2 l1)			         (a b c)
(rplacb l1 '(x y))			         (x y)
 l2				         (x y)

(setq l1 '(a b c) l2 l1 l3 'foo)	         foo
 l3				         foo
 l2				         (a b c)

(setq l1 1 l2 2)			         2
(psetq l1 l2 l2 l1) 		         1
 l1				         2
 l2				         1

(setq a '(x y z))			         (x y z)
(nextl a) 			         x
 a				         (y z)
(nextl a) 			         y
(nextl a) 			         z
(nextl a) 			         nil

(setq a '(x y z))			         (x y z)
(newl a 'w)			         (w x y z)
 a				         (w x y z)


         (testt "Fonctions numeriques")


(1+ 9)			         10

(1- 9)			         8

(abs 10)			         10
(abs -10) 		         10

(setq x 5)		         5
(incr x)			         6
 x				6
(incr x 4)		         10
(decr x 6)		         4
 x			         4

(+ 10 20) 		         30

(- 20)			         -20
(- 20 5)			         15
(- -20 -10)		         -10

(* 10 20) 		         200
(// 12 4) 		         3

(\ 14 4)			         2



	(testt "Fin du test.")



()

 ---(19)---

\014 \#20 (251 lines)  12/10/82 20:48  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:48 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.colfont.ll TRANSFERT DU 12/10/82  1947.9 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  le systeme graphique
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;
;	Les polices autoload
;

(autoload "FONTS.BROMAN.LL" block_roman)

(autoload "FONTS.SROMAN.LL" simplex_roman)
(autoload "FONTS.CROMAN.LL" complex_roman)
(autoload "FONTS.DROMAN.LL" duplex_roman)
(autoload "FONTS.TROMAN.LL" triplex_roman)

(autoload "FONTS.SSCRIPT.LL" simplex_script)
(autoload "FONTS.CSCRIPT.LL" complex_script)

(autoload "FONTS.CITALIC.LL" complex_italic)
(autoload "FONTS.TITALIC.LL" triplex_italic)

(autoload "FONTS.IGOTHIC.LL" italian_gothic)
(autoload "FONTS.EGOTHIC.LL" english_gothic)
(autoload "FONTS.GGOTHIC.LL" german_gothic)


;
;	Le proceseur graphique (inteprete)
;

(df graphic (gr-l)
    ; l est la liste des instructions graphiques
    (while gr-l (gr-exec1 (nextl gr-l))))

(de gr-exec1 (n)
    ; execute une instruction graphique
    (selectq (logand (logshift n -14) 3)
	   (\#%10 (gr-vector (if (= (logand n \#$2000) 0)
			    (logshift (logand n \#$1F80) -7)
			    (- (logshift (logand n \#$1F80) -7) 64))
			(if (= (logand n \#$40) 0)
			    (logand n \#$3F)
			    (- (logand n \#$3F) 64))))
	   (\#%11 (gr-shift	(if (= (logand n \#$2000) 0)
			    (logshift (logand n \#$1F80) -7)
			    (- (logshift (logand n \#$1F80) -7) 64))
			(if (= (logand n \#$40) 0)
			    (logand n \#$3F)
			    (- (logand n \#$3F) 64))))
	   (t (syserror 'graphic "instruction inconnue" n))))


;
;	Les fonctions internes du processeur graphique
;

(de gr-move (x y)
    (setq gr-x x
	gr-y y))

(de gr-shift (x y)
    (setq gr-dx (+ gr-dx x)
	gr-dy (- gr-dy y)))

(de gr-vector (x y)
    (let ((dx1)(dy1)(dx2)(dy2)(x1)(y1)(x2)(y2))
         (setq dx1 gr-dx
	     dy1 gr-dy)
         (setq gr-dx (+ gr-dx x)
	     gr-dy (- gr-dy y))
         (setq dx2 gr-dx
	     dy2 gr-dy)
         (selectq gr-rot
	        (0 (setq x1 (+ gr-x (scale gr-zx dx1 100))
		       y1 (+ gr-y (scale gr-zy dy1 100))
		       x2 (+ gr-x (scale gr-zx dx2 100))
		       y2 (+ gr-y (scale gr-zy dy2 100))))
	        (1 (setq x1 (- gr-x (scale gr-zy dy1 100))
		       y1 (+ gr-y (scale gr-zx dx1 100))
		       x2 (- gr-x (scale gr-zy dy2 100))
		       y2 (+ gr-y (scale gr-zx dx2 100))))
	        (2 (setq x1 (- gr-x (scale gr-zx dx1 100))
		       y1 (- gr-y (scale gr-zy dy1 100))
		       x2 (- gr-x (scale gr-zx dx2 100))
		       y2 (- gr-y (scale gr-zy dy2 100))))
	        (3 (setq x1 (+ gr-x (scale gr-zy dy1 100))
		       y1 (- gr-y (scale gr-zx dx1 100))
		       x2 (+ gr-x (scale gr-zy dy2 100))
		       y2 (- gr-y (scale gr-zx dx2 100)))))
         (selectq gr-mode
	        ('draw (COLVECTOR x1 y1 x2 y2 gr-c))
	        ('bbox (setq gr-xmin (min gr-xmin (min x1 x2))
			 gr-ymin (min gr-ymin (min y1 y2))
			 gr-xmax (max gr-xmax (max x1 x2))
			 gr-ymax (max gr-ymax (max y1 y2)))))))


;
;	La fonction Lisp : colfont
;

(de colfont (font msg gr-x gr-y gr-c gr-zx gr-zy gr-rot)
    ; gr-zx et gr-zy sont * 100
    (let ((gr-dx 0)
	(gr-dy 0)
	(gr-mode 'draw))
         (mapc font (explode msg))))


;
;	La fonction Lisp : colfont-bbox
;

(de colfont-bbox (font msg gr-x gr-y gr-c gr-zx gr-zy gr-rot)
    ; gr-zx et gr-zy sont * 100
    (let ((gr-dx 0) (gr-dy 0)
	(gr-xmin 32000) (gr-ymin 32000)	; + infinity
	(gr-xmax -32000) (gr-ymax -32000)	; - infinity
	(gr-mode 'bbox))
         (mapc font (explode msg))
         (list gr-xmin gr-ymin gr-xmax gr-ymax)))


;
;	La fonction Lisp : colfont-center
;

(de colfont-center (font msg x y w h c zx zy rot)
    ; zx et zy sont * 100
    (let ((bbox)(x1)(y1)(x2)(y2)(zx0)(zy0))
         (setq bbox (colfont-bbox font msg 0 0 0 zx zy rot)
	     x1 (car bbox)
	     y1 (cadr bbox)
	     x2 (caddr bbox)
	     y2 (cadddr bbox)
	     zx0 zx
	     zy0 zy)
         (if (> (- x2 x1) (- w 3))
	   (selectq rot
		  ((0 2) (setq zx0 (scale zx (- w 2) (1+ (- x2 x1)))
			     x1 (scale x1 zx0 zx)
			     x2 (scale x2 zx0 zx)))
		  ((1 3) (setq zy0 (scale zy (- w 2) (1+ (- x2 x1)))
			     x1 (scale x1 zy0 zy)
			     x2 (scale x2 zy0 zy)))
		  (t nil)))
         (if (> (- y2 y1) (- h 3))
	   (selectq rot
		  ((0 2) (setq zy0 (scale zy (- h 2) (1+ (- y2 y1)))
			     y1 (scale y1 zy0 zy)
			     y2 (scale y2 zy0 zy)))
		  ((1 3) (setq zx0 (scale zx (- h 2) (1+ (- y2 y1)))
			     y1 (scale y1 zx0 zx)
			     y2 (scale y2 zx0 zx)))
		  (t nil)))
         (colfont font msg
	        (+ x (logshift (1- (- w (+ x1 x2))) -1))
	        (+ y (logshift (1- (- h (+ y1 y2))) -1))
	        c zx0 zy0 rot)))


;
;	La fonction Lisp : colfont-center-list
;


(de colfont-center-list (font lmsg x y w h c zx zy rot)
    ; zx et zy sont * 100
    ; le rapport gr-d1/gr-d2 definit la proportion de blanc entre deux lignes
    ; (i.e., gr-d1/gr-d2 = 1/2 correspond a une ligne de texte de hauteur h
    ; suivie d'une ligne blanche de hauteur h/2)
    (let ((gr-d1 1)(gr-d2 3)
	(lbbox (mapcar (lambda (msg)
			    (colfont-bbox
			      font msg 0 0 0 zx zy rot))
		     lmsg))
	(n (length lmsg))
	(i 0)
	(x1)(y1)(x2)(y2)(dx)(dy)(w0)(h0)(x0)(y0)(zx0)(zy0))
         (setq x1 (apply 'min (mapcar 'car lbbox))
	     y1 (apply 'min (mapcar 'cadr lbbox))
	     x2 (apply 'max (mapcar 'caddr lbbox))
	     y2 (apply 'max (mapcar 'cadddr lbbox))
	     dx (1+ (- x2 x1))
	     dy (1+ (- y2 y1))
	     w0 dx
	     h0 dy
	     zx0 zx
	     zy0 zy)
         (selectq rot
	        ((0 2) (setq h0 (+ (* n dy) (scale (* (1- n) dy)
					   gr-d1 gr-d2))))
	        ((1 3) (setq w0 (+ (* n dx) (scale (* (1- n) dx)
					   gr-d1 gr-d2))))
	        (t nil))
         (if (> w0 (- w 2))
	   (selectq rot
		  ((0 2) (setq zx0 (scale zx (- w 2) w0)
			     x1 (scale x1 zx0 zx)
			     x2 (scale x2 zx0 zx)
			     dx (1+ (- x2 x1))
			     w0 dx))
		  ((1 3) (setq zy0 (scale zy (- w 2) w0)
			     x1 (scale x1 zy0 zy)
			     x2 (scale x2 zy0 zy)
			     dx (1+ (- x2 x1))
			     w0 (+ (* n dx) (scale (* (1- n) dx)
					       gr-d1 gr-d2))))
		  (t nil)))
         (if (> h0 (- h 2))
	   (selectq rot
		  ((0 2) (setq zy0 (scale zy (- h 2) h0)
			     y1 (scale y1 zy0 zy)
			     y2 (scale y2 zy0 zy)
			     dy (1+ (- y2 y1))
			     h0 (+ (* n dy) (scale (* (1- n) dy)
					       gr-d1 gr-d2))))
		  ((1 3) (setq zx0 (scale zx (- h 2) h0)
			     y1 (scale y1 zx0 zx)
			     y2 (scale y2 zx0 zx)
			     dy (1+ (- y2 y1))
			     h0 dy))
		  (t nil)))
         (selectq rot
	        (0 (setq x0 (+ x (logshift (- w w0) -1))
		       y0 (+ y (logshift (- h h0) -1))
		       dx 0))
	        (1 (setq x0 (+ x (logshift (1- (+ w w0)) -1))
		       y0 (+ y (logshift (- h h0) -1))
		       dx (- dx)
		       dy 0))
	        (2 (setq x0 (+ x (logshift (1- (+ w w0)) -1))
		       y0 (+ y (logshift (1- (+ h h0)) -1))
		       dx 0
		       dy (- dy)))
	        (3 (setq x0 (+ x (logshift (- w w0) -1))
		       y0 (+ y (logshift (1- (+ h h0)) -1))
		       dy 0))
	        (t nil))
         (while lmsg
	      (colfont font (nextl lmsg)
		     (+ x0 (* i dx) (scale (* i dx) gr-d1 gr-d2))
		     (+ y0 (* i dy) (scale (* i dy) gr-d1 gr-d2))
		     c zx0 zy0 rot)
	      (setq i (1+ i)))))

 ---(20)---

\014 \#21 (81 lines)  12/10/82 20:49  Mailed by: Chailloux.Vlsi
Date:  10 December 1982 20:49 hfh
From:  Chailloux.Vlsi
Subject:	ptf llut.croch.ll TRANSFERT DU 12/10/82  1947.9 hfh Fri TERMINE
To:  Chailloux.Vlsi

;==========================================================================
;
;	         Le_Lisp 68K  :  les macros crochets [ ]
;			     et l'operateur "unpack" !
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================

;------------------------------------------------------------
;-----	Une version adaptee du crochet Le_Lisp 80
;-----	        de Emmanuel Saint-James
;-----		 (Saint-James.Styp)
;------------------------------------------------------------

;	[a b c d e]        =>	  (LIST A B C D E)
;	[a !b]	         =>	  (CONS A B)
;	[a b c !d]         =>	  (MCONS A B C D)
;	[a !b !c !d]       =>	  (CONS A (APPEND B C D))
;	[!a b !c]          =>	  (APPEND A (CONS B C))
;	[!a !b c]          =>	  (APPEND A B (LIST C))



;-----	La variable globale d'etat

(defvar **-in-bracketp nil)


;-----	Les macros carateres eux-memes

(dmc |!| ()
     (if **-in-bracketp
         '|!|
         (syserror '|!| "pas dans un [ ]" nil)))

(dmc |]| ()
     (if **-in-bracketp
         '|]|
         (syserror '|]| "pas dans un [ ]" nil)))

(dmc |[| ()
     (let ((begin (list 'LIST)) (**-in-bracketp T))
	(readbracket begin begin (read))
	begin)))


;-----	Lecture d'un [

(de readbracket (begin current new)
    (cond ((eq new '|]|))
	((neq new '|!|)
	 (readbracket begin (placdl current new) (read)))
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
        (sequence (placdl last (read)) (read))
        (when (neq next '|]|)
	    (let ((begin (list 'LIST next)))
	         (rplacd last (list begin))
	         (readbracket begin (cdr begin) (read)))))))






 ---(21)---

\014


