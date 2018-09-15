;==========================================================================
;
;                  Le_Lisp 68K  :  le fichier initial
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================
 
 
;------------------------------------------------------------
;         Le nouveau toplevel et le handler d'erreur
;------------------------------------------------------------
 
(progn              ; pour etre tres silencieux
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
             (let ((status-print ()))
                  (print "** " f " : " m " : " b)
;                  (stacktracen 4)
                   ))
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
 
   (setq tp- () tp+ () tp* () )
 
   (de toplevel ()
       (setq ; l'ancienne forme lue
             tp- tp+
             ; la nouvelle forme lue
             tp+ (car (errset (catch-all-but **errset-tag** (read)) t))
             ; la valeur de l'evaluation
             tp* (errset (catch-all-but **errset-tag** (eval tp+)) t))
       (when (and (listp tp*) status-toplevel)
             (print "= " (car tp*)))
       (setq tp* (car tp*)))
 
 
   ; les premieres definitions
 
   (synonym 'defvar 'setq)
 
   ; petit reglage du print
 
   (printline 5000)
 
   "Chargement de EXLL.SYSINI.LL"
 
))) ; du PROGN

;------------------------------------------
;         Les variables globales
;------------------------------------------
 
 
(defvar   status-toplevel () )
 
(defvar   status-redef () )
 
(defvar   loaded-from-file () )
 
(defvar   default-sys-directory  "/udd/lelisp/lib/")
(defvar   default-sys-extension  ".ll") 
 
;--------------------------------------------------
;         Les fonctions qui manquent
;         et qui sont vriment indispensables
;--------------------------------------------------
 
(df dmd (l)
    ; realise un DM avec displace
    (eval  ['dm (car l) (cadr l)
                ['displace (caadr l)
                    (cons 'progn  (cddr l))]])))
 
(setq gensym-counter 100)
 
(de gensym (n)
    (when (numberp n) (setq gensym-counter n))
    (implode (cons 71 (explode (incr gensym-counter)))))
 
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
     (displace l ['tag (cadr l)
            (mcons 'while t (cddr l))]))))))))
 
(de teread () nil)
 
;;; il faudait que je m'y mette .....
 
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
;         Sauvetage sur disque de fonctions
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
;         Les macros-caracteres standard
;--------------------------------------------------
 
;(dmc |^| () (ascii (logand (readcn) 31))))
 
;(dmc ^L ()
;     ; ^L  :  pour charger un fichier d'extension .LL
;     (let ((status-redef t))            ; on peut redefinir
;          ['LOAD (PRINT
;               (catenate (read) ".LL"))]))))))
 
;------ le ^ redevient normal
 
;(typecn 94 12)
 
(dmc |#| () (exec-sharp-macro))
 
(dmc |`| () (xr-backquote-macro))
 
(dmc |,| () (xr-comma-macro))
 
 
;--------------------------------------------------
;         Autoload et fonctions Autoloads
;--------------------------------------------------
 
;-----    pour avoir 2 arguments et lier les variables
;-----    'status-redef' et 'loaded-from-file'
 
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
         (errset (loadfile* (catenate f default-sys-extension)) t)
         f)))
 
;-----    Load et Autoload  systeme
 
(dm sys-load (l)
    ['load (catenate default-sys-directory (cadr l))]))
 
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
 
 
(sys-autoload backq xr-backquote-macro xr-comma-macro)
(sys-autoload sharpm xr-sharp-macro)
 
(sys-autoload stacktr stacktrace stacktracen)
(sys-autoload defs defmacro macroexpand)
(sys-autoload trace trace untrace)
(sys-autoload pretty pretty pprint)
(sys-autoload streamo stream-output with)
(sys-autoload closure closure)
(sys-autoload progdo for prog do)
(sys-autoload letn let-named)
(sys-autoload backtrac backtrack)
(sys-autoload sort sortl)
 
(sys-autoload emacs emacs)
(sys-autoload ehp ehp hp2621)
(sys-autoload emi emi)
(sys-autoload exor155 e155 exor155)
(sys-autoload tab132 tab132)
 
(sys-autoload loader loader)
(sys-autoload llcp compile compiler compilef)
 
(sys-autoload colfont colfont)
(sys-autoload lucifer lucifer)
(sys-autoload luciole luciole luc)
 
 
;-----    Tassage d'un fichier disque
 
(de packfile ()
    ; tasse un fichier disque
    (prin "Fichier d'entree   ") (flush) (setq fi (read))
    (prin "Fichier de sortie  ") (flush) (setq fo (read))
    (errset (progn
       (input fi) (output fo)
       (untilexit eof
            (if (eq (print (read)) EOFVAL) (exit eof))))
       t)
    (input () )
    (output () )
    fo))))))
 
 
;------------------------------------------------------------
;         Construction de l'environnement standard
;------------------------------------------------------------
 
 
(de save-std (msg)
    ; sauve une image standard
    (gc)
    (save-core 'llinit.sysstd.)
    (initasq)
    (initbrk)
    (setbrk 1)
    msg)
 
(de load-std ()
    ; charge l'image standard
    (mapc (lambda (x)
             (setq x (catenate default-sys-directory x))
             (print "Je charge " x)
             (loadfile x))
          '(; Macros
            sharpm
            backq
            croch
            stacktr
            defs
            trace
            pretty
            streamo
            closure
            progdo
            letn
            backtrac
            sort
            lhelp
            ; Chargeur et Compilateur
            loader
            llcp
            llcpa
            llcpm
            llcpe
            llcpg
            ; Emacs
            emacs
            io
            toplevel
            commands
            extended
            buffer
            kill
            files
            search
            words
            macros
            llmode
            hp2621
            ; pour les LUC*
            colfont
          ))
     (print " (llcp-std)  pour compiler l'environnement standard")
     (save-std "Systeme standard.")
))))))
 
(de llcp-std ()
    ; compilation de l'environnement standard
    (compile p-p t)
    (emacs-llcp)
    (compile loader t)
    (compile (compilindic compiledef) t)
    (compile-all-in-core)
    (save-std "Systeme standard compile."))
 
 
;------------------------------------------------------------
;         Manipulation de l'environnement experimental
;------------------------------------------------------------
 
 
(de save-exl ()
    ; sauvetage de l'image memoire experimentale
    (gc)
    (save-core 'core:.exll.exll.)
;    (initasq)
;    (initbrk)
;    (setbrk 1)
    "Systeme experimental sur core:.exll.exll.")))
 
(de load-exl ()
    (mapc (lambda (x)
             (print "Je charge " x)
             (loadfile (catenate exl-default-directory x)))
          '(; Macros
            sharpm
            backq
            croch
            stacktr
            defs
;            trace
            pretty
            streamo
            closure
            progdo
            letn
            backtrac
            sort
            lhelp
            ; Chargeur et Compilateur
            loader
            llcp
            llcpa
            llcpe
            llcpg
            llcpm
            ; Emacs
            emacs
            io
            toplevel
            commands
            extended
            buffer
            kill
            files
            search
            words
            macros
            llmode
            hp2621
            ; pour les LUCxxx
            colfont
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
;         Final de l'initialisation
;--------------------------------------------
 
(progn
 
 
   (setq STATUS-TOPLEVEL t)
   (rmargin 78)
   (print  " (load-std)  pour charger l'environnement std")
   (print  " (load-exl)  pour charger l'environnement exl")
   'LLIB.STARTUP.LL
)))
 
 
(input () )
 
 
