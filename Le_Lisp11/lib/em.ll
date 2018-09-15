

;==========================================================================
;
;		       Emacs Le_Lisp 68K
;
;	      une version compatible de Emacs Multics
;	  (adaptee pour Le_Lisp 68K par Jerome Chailloux)
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;!!! Il faut faire des types structures :
;!!! next-line == (unpackline (CDR (nextl end-buffer))) ...

(print "Emacs Le_Lisp 68K : Version du 9 Septembre 1982")

;*******************************************************
;*
;*	Les fonctions standards qui manquent
;*
;*******************************************************

(de teread () (until (= (readcn) \#\LF)))))

(de between (a x b) (and (<= a x) (<= x b)))

(de upper-case-list (l)
    ; conversion d'une liste de caracteres
    (let ((l l))
         (while l (rplaca l (uppercase (nextl l)))))
    l)))

;******************************************************************
;*
;*	   Fonctions de manipulation des listes-buffers
;*
;******************************************************************


(defmacro passl (at1 at2 val)
     `(passlist (quote ,at1) (quote ,at2) ,(or val 1)))))))))

(de passlist (at1 at2 n x y)
    (setq n (min (length (cval at2)) n))
    (if (<= n 0)
        ()
        (setq x (nthcdr (1- n) (cval at2)) y (cdr x))
        (if x (rplacd x ()))
        (set at1 (nreconc (cval at2) (cval at1)))
        (set at2 y))
    at1))))

(comment	; la fonction est standard maintenant : packline
 (de pack (l)
    ; compacte la liste l
    (let ((nl 0))
       (while (and l (= \#\SP (car l))) (incr nl) (nextl l))
       (setq nl (ncons nl))
       (while l (newl nl (+ (logshift (nextl l) 8) (or (nextl l) 0))))
       (nreverse nl))))

(comment	;  la fonction est standard maintenant : unpackline
  (de unpack (l)
    ; decompacte la liste l
    (if (null l)
        ()
        (let ((nl (makelist (nextl l) \#\SP)))
	 (while l
	    (newl nl (logshift (car l) -8))
	    (if (= (logand (car l) \#$FF) 0)
	        (nextl l)
	        (newl nl (logand (nextl l) \#$FF))))
	    (nreverse nl)))))))))

(de make-line (mark line)
    ; fabrique une ligne avec :
    ; - une liste de marque
    ; - une liste de caracteres
    (cons mark (packline line))))

(de open-line (x)
    ; ouvre la ligne suivante du texte
    ; si x ^= NIL, positionne au xieme caractere
    (if open-line-flag
        (passl end-line begin-line (length begin-line))
        (setq old-line (car end-buffer)
	    mark-line (caar end-buffer)
	    begin-line ()
	    end-line (unpackline (cdar end-buffer))
	    end-buffer (cdr end-buffer)
	    open-line-flag T))
    (and x (passl begin-line end-line x))))

(de close-line ()
    ; ferme la ligne courante
    (if open-line-flag
        (newl end-buffer
	 (if modified-line-flag
	     (cons mark-line (packline (nreconc begin-line end-line)))
	     (nreconc begin-line end-line)
	     old-line)))
    (setq open-line-flag () begin-line () end-line ()))))

(de modified-buffer ()
    ; passe en mode modified-buffer (dans la foulee
    (setq modified-line-flag T)
    (if modified-buffer-flag
        ()
        (setq modified-buffer-flag T)
        (redisplay-wholines)))

(de clear-buffer (i)
    ; efface tout un buffer
    ; si i=NIL sans precaution, si i=T on teste
    (if (and i
	   modified-buffer-flag
	   (not (display-query-yesnop
		\#"Modified buffer, do you want to destroy it ? ")))
        (command-quit)
        (setq begin-buffer ()
	    end-buffer ()
	    begin-line ()
	    end-line ()
	    modified-screen-flag ()
	    modified-buffer-flag ()
	    open-line-flag ()
	    curxpos 0
	    curypos 0
	    curcol 0)
        (redisplay-all t)))


(de insert-lines (ll)
    ; insert dans le buffer au curseur courant
    ; une liste de lignes non packees,
    ; format stream-output
    (close-line)
    (mapc (lambda (l)
	    (newl begin-buffer (make-line () l)))
	ll)
    (modified-buffer)
    (redisplay-full-window-in-middle))

(de goto-lc-buffer (l c)
    ; se pointe a la ligne 'l' et a la colonne 'c' du buffer courant
    (close-line)
    (passl begin-buffer end-buffer (length begin-buffer))
    (passl end-buffer begin-buffer l)
    (open-line c)))


;************************************************
;*
;*	  Macros des Predicats utiles
;*
;************************************************


(dm eolp (call)
    (displace call '(null end-line)))

(dm bolp (call)
    (displace call '(null begin-line)))

(dm firstlinep (call)
    (displace call '(null begin-buffer)))

(dm lastlinep (call)
    (displace call '(null end-buffer)))

(dm at-beginning-of-buffer (call)
    (displace call '(and (null begin-buffer) (null begin-line))))

(dm at-end-of-buffer (call)
    (displace call '(and (null end-buffer) (null end-line))))

(dm at-first-visible-line (call)
    (displace call '(= curypos 0)))

(dm at-last-visible-line (call)
    (displace call '(= curypos wind-size-1)))

(dm is-at (call)
    (displace call ['eq '(car end-line) (cadr call)])))

;*******************************************
;*
;*	  Fonctions du redisplay
;*
;*******************************************


(de redisp-1line (l)
    ; reaffiche la ligne 'l' a l'endroit courant
    (DCTL-erase-line)
    (ifn l
         ()
         (repeat (cadr l) (dpy-tyo \#\SP))
         (dpy-tyol (cddr l))))))

    (comment  ; l'ancienne version avec TABs! pb avec l'EMI
         (let ((nbsp (cadr l)) (xpos 0) (l (cddr l)))
	    (until (< nbsp tab-pos) (dpy-tyo \#\TAB)
	         (setq xpos (+ xpos tab-pos))
	         (setq nbsp (- nbsp tab-pos)))
	    (repeat nbsp (incr xpos) (dpy-tyo \#\SP))
	    (dpy-tyol l))))

(de redisp-1line-y (l y)
    ; affiche la ligne l (fermee) en y
    (DCTL-position-cursor 0 y)
    (redisp-1line l)))

(de redisp-lines-y (l n y)
    ; affiche n lignes de l en y
    (DCTL-position-cursor 0 y)
    (repeat (1- n)
       (redisp-1line (nextl l))
       (dpy-tyol '(\#\CR \#\LF)))
    (redisp-1line (nextl l))))

(de redisplay-all (clear-flag  y)
    ; clear-flag = T si ^L, NIL sinon
    (if clear-flag (DCTL-clear-screen))
    (ifn y (setq y wind-size))
    (close-line)
    (passl end-buffer begin-buffer curypos) ; remonte au debut de la fenetre
    (redisp-lines-y end-buffer y 0)   ; affiche la fenetre
    (passl begin-buffer end-buffer curypos) ; revient sur la bonne ligne
    (open-line curxpos)
    (redisplay-wholines clear-flag)
    (setq modified-screen-flag ())))

(de redisplay-full-window ()
    ; re-affiche toute la fenetre et se positionne en haut
    (close-line)
    (redisp-lines-y end-buffer wind-size 0)
    (setq curxpos 0 curypos 0 curcol 0))

(de redisplay-full-window-in-middle ()
    ; re-affiche toute la fenetre et se positionne au milieu
    (close-line)
    (let ((n (min half-wind (length begin-buffer))))
         (passl end-buffer begin-buffer n)
         (redisp-lines-y end-buffer wind-size 0)
         (passl begin-buffer end-buffer n)
         (setq curxpos 0 curypos n curcol 0))))))

(de redisplay-wholines (i)
    ; i = T si l'ecran est propre
    (if i ()
       (DCTL-position-cursor 0 screen-size-4)
       (repeat 3 (DCTL-erase-line) (dpy-tyol '(\#\CR \#\LF)))
       (DCTL-erase-line))
    (display 0 screen-size-4 \#"Emacs (" nmod
         (if sub-mode sub-mode)
         (if macro-learn-flag \#"<Macro Learn>) - " \#") - ") buffer)
    (display 1 screen-size-3 (if modified-buffer-flag '(\#/*) '(\#\SP)))))


;**********************************************************
;*
;*	Le chargement de tout Emacs Le Lisp 68K
;*
;**********************************************************

(de emacs ()
    ; pour charger le Emacs experimental
    (mapc (lambda (x)
	    (print "Je charge " x)
	    ; load est une FSUBR!
	    (eval ['load x]))
         ; la liste des fichiers a charger
         '(emacs.io.ll
	 emacs.toplevel.ll
	 emacs.commands.ll
	 emacs.extended.ll
	 emacs.kill.ll
	 emacs.files.ll
	 emacs.buffer.ll
	 emacs.search.ll
	 emacs.words.ll
	 emacs.llmode.ll
	 emacs.macros.ll))
    ; on lance enfin le vrai Emacs
    (emacs))))


(de save-emacs ()
    ; sauvetage d'une image memoire Emacs
    (save-core 'e)
    "Emacs Le_Lisp 68K : version experimentale.")))






;==========================================================================
;
;	Emacs Le_Lisp 68K :  les fonctions physiques
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;****************************************************************
;*
;*	 Les fonctions du display physique (le plus bas niveau)
;*	 elles sont bloquees par le 'redisplay-flag'
;*
;****************************************************************

(de dpy-tyo (n)
    (if redisplay-flag
        ()
        (tyo n)))

(de dpy-tyol (l)
    (if redisplay-flag
        ()
        (tyol l))))

(de dpy-tyflush ()
    (if redisplay-flag
        ()
        (tyflush)))


;*************************************************************
;*
;*	  Initialisation des parametres de l'ecran
;*
;*************************************************************

(setq    screen-size         24
         screen-size-1       (- screen-size 1)
         screen-size-2       (- screen-size 2)
         screen-size-3       (- screen-size 3)
         screen-size-4       (- screen-size 4)
         wind-size	         (- screen-size 4)
         wind-size-1         (- wind-size 1)
         wind-size-2         (- wind-size 2)
         half-wind	         (// wind-size 2)
         half-wind-1         (1- half-wind)
         half-wind-2         (- half-wind 2)

         tab-pos	         10)))))



;*************************************************
;*
;*	  Fonctions d'acces au clavier
;*
;*************************************************


(de echo (x)
    ; realise l'echo du caractere x
    (cond
       ((>= x 256)	; caratere prefixe
	 (echo (logshift x 8))
	 (echo (logand x \#$FF)))
       ((= x 127)	; le caractere rub-out
	 (dpy-tyol \#"<del>"))
       ((= x \#\ESC) ; le caractere escape lui-meme
	 (dpy-tyol \#"<esc>"))
       ((<= x 31)	; les autres caracteres de controle
	 (echo \#/^) (echo (+ x 64)))
       (t (dpy-tyo x)))
    x))

(setq emacs-prefix-list '(\#^X \#^Z \#\esc))

(de get-key (pref)
    ; pref = T, si un prefixe a deja ete lu.
    (let ((char (tyi)))
         (if (memq char emacs-prefix-list)
	   (if pref
	       char
	       (logor (logshift char 8) (get-key t)))
	   (if pref
	       (uppercase char)
	       char))))))

(de display l
    ; (display x y msg1 msg2 ... msgN)
    (DCTL-position-cursor (nextl l) (nextl l))
     (DCTL-erase-line)
    (while l
        (if (null (car l))
	  (nextl l)
	  (dpy-tyol (if (atom (car l)) (explode (nextl l)) (nextl l)))))
    (DCTL-position-cursor curxpos curypos)
    (dpy-tyflush)
    ))

(de display-error l
    ; (display-error msg1 ... msgN)
    (apply 'display (mcons 6 screen-size-1 l))
    (command-quit)))

(de display-comment l
    ; (display-comment msg1 ... msgN)
    (apply 'display
       (mcons 45 screen-size-4  \#"[" (append l [\#"]"])))))))

(de prompt (x y msg rep)
    ; si rep = t, retourne une reponse
    (DCTL-position-cursor x y)
    (DCTL-erase-line)
    (dpy-tyol msg)
    (ifn rep
         ()
         (setq rep ())
         (untilexit finrep
	  (let ((char (get-key)))
	       (selectq char
		      (\#\CR   (exit finrep))
		      (\#\BELL (command-quit))
		      ((\#\BS \#\RUBOUT)
			(ifn rep
			     ()
			     (dpy-tyol '(\#\BS \#\SP \#\BS))
			     (nextl rep)))
		      (t (newl rep (echo char))))))
         (dpy-tyol	'(\#/< \#/> \#\BS \#\BS)))
    (dpy-tyflush)
    (nreverse rep))))))


(de display-prompt (msg default)
    ; imprime le message 'msg' se met en attente d'une reponse (cf prompt)
    ; si cette reponse est nulle, retoure la valeur par defaut 'default'
    (cond (re-execute-command-flag default)
	((prompt 6 screen-size-2 msg t))
	(t (DCTL-position-cursor (+ (length msg) 8) screen-size-2)
	   (dpy-tyol default)
	   (DCTL-position-cursor (+ (length msg) 6) screen-size-2)
	   (dpy-tyflush)
	   default))))))))


(de display-beep ()
    ; balance un grand coup de klaxon sur le terminal
    (dpy-tyo \#\BELL)
    (dpy-tyflush))))


(de display-query-yesnop (msg)
    ; imprime le message 'msg' se met en attente d'une reponse (cf prompt)
    ; cette reponse doit etre oui ou non (yes/no, T/NIL)
    (untilexit fini
        (let ((rep (prompt 6 screen-size-2 msg t)))
	   (if (and rep (memq (car rep) \#"OoYyTtNn"))
	       (exit fini (not (memq (car rep) \#"Nn")))
	       (display 6 screen-size-1 \#"Answer Yes or No.")
	       (display-beep)
	       ())))))

(de not-yet-implemented ()
    ; dans les cas malheureux ...
    (display-error "Not yet implemented."))



;***************************************
;*
;*	le redisplay local
;*
;***************************************


;****	garde l'ancienne def de eof (en attendant LETF)

(synonym 'eol&& 'eol)

(de local-display-eol ()
    ; realise le EOL du display local
    (let ((so~i 0) (so~r))
         (setq so~t t)
         (repeat (outpos)
	    (newl so~r (outbuf so~i))
	    (outbuf so~i \#\SP)
	    (incr so~i))
         (outpos 0)
         (while (< (outpos) (lmargin))
	      (outbuf (outpos) \#\SP)
	      (outpos (1+ (outpos))))
         (when (= so~y wind-size)
	     (if (display-query-yesnop \#"Local display : more ? ")
	         (setq so~y 0)
	         (redisplay-all t)
	         (command-quit)))
         (redisp-1line-y (make-line () (nreverse so~r)) so~y)
         (incr so~y)))))))))


(df local-display (so~l)
    ; evalue le progn ~l
    ; tous les prints vont sur le terminal tres proprement
    (let ((so~y 0) (so~t) (so~lm (lmargin)) (so~rm (rmargin)))
         (synonym 'eol 'local-display-eol)
         (lmargin 0)
         (rmargin 76)
         (unwind-protect
	    (prog1 (eprogn so~l)
		 (when so~t
		       (setq modified-screen-flag t)
		       (terpri)
		       (spaces 16)
		       (repeat 10 (prin "- * "))
		       (terpri 2)
		       'local-display))
	    (lmargin so~lm)
	    (rmargin so~rm)
	    (synonym 'eol 'eol&&)))))))







;==========================================================================
;
;	Emacs Le_Lisp 68K :  toplevel de Emacs
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;**********************************************************
;*
;*	    Definition du mode fondamental
;*
;**********************************************************


(setq fund '(
;	 \#/\#	 rubout-char
	\#/@	kill-to-beginning-of-line		; in KILL
	\#^A	go-to-beginning-of-line
	\#^B	backward-char
	\#^C	re-execute-command
	\#^D	delete-char
	\#^E	go-to-end-of-line
	\#^F	forward-char
	\#^G	command-quit
	\#^H	rubout-char
	\#^I	tab-command
	\#^J	null
	\#^K	kill-lines			; in KILL
	\#^L	redisplay-command
	\#^M	new-line
	\#^N	next-line-command
	\#^O	open-space
	\#^P	prev-line-command
	\#^Q	quote-char
	\#^R	reverse-string-search		; in SEARCH
	\#^S	string-search			; in SEARCH
	\#^T	twiddle-chars
;	\#^U
	\#^V	next-screen
;	\#^W	wipe-region
	\#^Y	yank				; in KILL
	\#\DEL	rubout-char

;*** les ESC-commands

	\#\esc|/>		go-to-end-of-buffer
	\#\esc|/<		go-to-beginning-of-buffer
	\#\esc|/\#		rubout-word	         ; in WORDS
	\#\esc|/%		query-replace	         ; in SEARCH
	\#\esc|/^		delete-line-indentation
	\#\esc|^A		begin-defun	         ; in LLMODE
	\#\esc|^B		backward-sexp	         ; in LLMODE
	\#\esc|^D		down-list-level	         ; in LLMODE
	\#\esc|^E		end-defun 	         ; in LLMODE
	\#\esc|^F		forward-sexp	         ; in LLMODE
	\#\esc|^N		forward-list	         ; in LLMODE
	\#\esc|^O		split-line
	\#\esc|^P		backward-list	         ; in LLMODE
	\#\esc|^R		move-defun-to-screen-top     ; in LLMODE
	\#\esc|^S		global-search-string         ; in SEARCH
	\#\esc|^Z		eval-top-level-form          ; in LLMODE
	\#\esc|/B		backward-word	         ; in WORDS
	\#\esc|/C		capitalize-initial-word      ; in WORDS
	\#\esc|/D		delete-word	         ; in WORDS
	\#\esc|/F		forward-word	         ; in WORDS
	\#\esc|/G		go-to-line-number
	\#\esc|/L		lower-case-word	         ; in WORDS
	\#\esc|/R		move-to-screen-edge
	\#\esc|/U		upper-case-word	         ; in WORDS
	\#\esc|/V		previous-screen
	\#\esc|/X		extended-command	         ; in LLMODE
	\#\esc|\DEL	rubout-word	         ; in WORDS
	\#\esc|/~		unmodify-buffer	         ; in BUFFER
	\#\esc|\esc	eval-lisp-line	         ; in LLMODE

;*** les ^X commands

	\#^X|/(		begin-macro-collection	; in MACROS
	\#^X|/)		end-macro-collection	; in MACROS
	\#^X|/*		show-last-or-current-macro	; in MACROS
	\#^X|/=		linecounter
	\#^X|^C		quit-the-editor
	\#^X|^F		find-file 		; in FILES
	\#^X|^R		read-file 		; in FILES
	\#^X|^S		save-file 		; in FILES
	\#^X|^T		toggle-redisplay
	\#^X|^W		write-file		; in FILES
	\#^X|/E		execute-last-editor-macro	; in MACROS
	\#^X|/I		insert-file		; in FILES
	\#^X|/Q		macro-query		; in MACROS

;*** les ^Z commands

	\#^Z|^Y		show-kills
	\#^Z|^V		scroll-current-window

))))))


;*************************************************************
;*
;*	        la gestion des 'extended-commands'
;*
;*************************************************************

;*****	La liste (globale) des noms des fonctions 'extended'
;	tres commode pour le print-wall-chart

(setq extended-command-list ())

(df defext (l)
    ; la fonction de definition des 'extended-commands' (a la 'de')
    (newl extended-command-list (car l))
    (eval (cons 'de l)))


;************************************************************
;*
;*		 Les fonctions Autoloads
;*
;*************************************************************

(df emacs-autoload	(l)
    (mapc (lambda (a)
	  (eval ['dm a '(l) ['ftype (kwote a) 0]
		       ['eload (kwote (car l))] 'l]))
         (cdr l))))))

(de eload (file)
    ; autoload d'un fichier sous Emacs
    (display 6 screen-size-2 \#"Autoload file : "
	(catenate default-sys-directory file))
    (display 6 screen-size-1 \#"Loading ...")
    (eval ['load file])
    (display 6 screen-size-1 \#"	  ")
    (load "LLIB.DUMMY.LL")
    file))))

(df exload (file)
    ; charge un fichier experimental (sur EMACS.)
    (let ((default-sys-directory "EMACS."))
         (eload (catenate (car file) ".LL")))))

(emacs-autoload "FILES.LL"	   ; pour les fichiers
         file-name
         find-file
         read-file
         save-file
         write-file
         insert-file)

(emacs-autoload "BUFFER.LL"	   ; gestion des buffers
	unmodify-buffer)

(emacs-autoload "KILL.LL"	   ; pour les tueurs
         kill-to-beginning-of-line
         kill-lines
         yank
         show-kills)

(emacs-autoload "MACROS.LL"	   ; pour les macros
         begin-macro-collection
         end-macro-collection
         show-last-or-current-macro
         execute-last-editor-macro)

(emacs-autoload "LLMODE.LL"	   ; pour le mode lisp
         eval-lisp-line
         extended-command
         begin-defun
         backward-sexp
         down-list-level
         end-defun
         forward-sexp
         kill-sexp
         forward-list
         backward-list
         move-defun-to-screen-top
         eval-top-level-form
         eval-buffer)

(emacs-autoload "SEARCH.LL"	   ; pour les recherches
         reverse-string-search
         string-search)

(emacs-autoload "WORDS.LL"	   ; pour le traitement des mots
         rubout-word
         backward-word
         capitalize-initial-word
         delete-word
         forward-word
         lower-case-word
         upper-case-word)

;****************************************************
;*
;*	Pour la compilation de tout Emacs
;*
;****************************************************


(de emacs-llcp ()
    ; d'abord on compile le top-level
    (dont-compile syserror local-display stream-output)
    (compile emacs t)
    (compile top-level t)
    ; puis toutes les fonctions attachees aux cles
    (let ((l (cdr fund)))
         (while l (if (eq (getftype (car l)) 'EXPR)
		  (eval ['compile (nextl l) t])
		  (nextl l))
	        (nextl l)))
    ; puis toutes les commandes etendue
    (let ((l extended-command-list))
         (while l (if (eq (getftype (car l)) 'EXPR)
		  (eval ['compile (nextl l) t])
		  (nextl l))))
    ; et voila c'est tout
    ))))

;******************************
;*
;*	  TOP-LEVEL
;*
;******************************


(de get-key-nb (n)
    ; retour un nombre en decimal lu sur le clavier
    ; key : contient le 1er caractre non digit
    (if (digitp (setq key (get-key)))
        (get-key-nb (+ (* n 10) (- key \#/0)))
        n)))))


(de top-level (mode end funct key stack n)
    (until end
      (errset
       (tag ctrl-G
	(DCTL-position-cursor curxpos curypos)
	(setq n (cond
	   ((between \#\esc|/0 (setq key (get-key)) \#\esc|/9)
	    (get-key-nb (- key \#\esc|/0)))
	   ((= key \#^U)
	    (let ((n 4))
	         (while (= (setq key (get-key)) \#^U)
		      (setq n (* n 4)))
	         (ifn (between \#/0 key \#/9)
		    n
		    (get-key-nb (- key \#/0)))))
	   (t ())))
         (if modified-screen-flag (redisplay-all))
         (if open-line-flag () (open-line))
         (cond
	   ((setq funct (cadr (memq key mode)))
	       (ifn funct
		  (command-quit)
		  (if macro-learn-flag (macrolearn key funct  [n]))
		  (apply funct (if n [n]))
		  (if (not (memq funct '(nop re-execute-command)))
		      (setq last-command-name funct
			  last-command-arg n))))
	   ((between 32 key 126)
	       (insert-char key n)
	       (if macro-learn-flag
		 (macrolearn key 'insert-char [key n])))
	   (t (command-quit)))
        )  ; le tag cntrl-G
       t)  ; du ERRSET
    )))))))


(de emacs-load-ctl ()
    ; doit charger un CTL
    (prin "Quel type de terminal utilisez-vous ") (flush)
    (let ((ttp (read)))
         (when (or (null ttp) (not (symbolp ttp)))
	     (print "Il existe les types :  hp2621 exor155 emi")
	     (emacs-load-ctl))))))))

(de exl-emacs (buffer-name)
    ; appel de la version experimentale de Emacs
    (let ((default-sys-dir "EMACS."))
	(emacs buffer-name)))))

; probablement a mettre dans le fichier initial !!!!!

(synonym 'syserror* 'syserror)	   ;;; erreurs speciales

(de emacs (buffer-name)

  (tag emacs_abort		         ;;; en cas de panique

    (let (		         ;;; les variables globales de Emacs

	(curxpos) 		; colonne du curseur
	(curypos) 		; ligne du curseur
	(curcol)			; colonne theorique du curseur

	(modified-screen-flag)	; T = l'ecran est perturbe
	(modified-buffer-flag)	; T = le buffer est modifie
	(modified-line-flag)	; T = la ligne est modifiee
	(open-line-flag)		; T = la ligne est ouverte
	(redisplay-flag)		; T = silence !

	(macro-learn-flag)		; T = j'enregistre une macro
	(execute-macro-flag)	; T = j'execute une macro
	(macro-body)		; le corps de la macro

	(begin-buffer)
	(end-buffer)

	(begin-line)
	(end-line)
	(old-line)		; ligne avant ouverture

	(kill-ring)
	(kill-ring-size  10)	; la taille du kill-ring
	(default-string-search)	; derniere chaine recherchee

	(last-command-name 'NOP)	; en cas de ^C
	(last-command-arg)		; itou.
	(re-execute-command-flag)	; indicateur de ^C

	(buffer	 (or buffer-name "MAIN.LL"))	; nom du fichier
	(nmod	 "Fundamental")	; nom du mode
	(sub-mode)		; nom du sous-mode
	(mode	 fund)		; le mode courant

         )		         ; fin des variables locales

;   (if (or (null buffer-name) (not (boundp buffer-name)))
;       ()
;       (setq begin-buffer (car (cval buffer-name))
;	    end-buffer (cadr (cval buffer-name))))

    (when (null (ftype 'DCTL-prologue))
	(emacs-load-ctl))
    (setq kill-ring (makelist kill-ring-size 'nothing ))
    (nconc kill-ring kill-ring)   ; kill est une liste circulaire !

    (flet (gcalarm ()
	   ; le demon du GC
	   (display 65 screen-size-4 \#"[GC: "
		(cadr (memq 'CONS (gcinfo)))
		 \#"]")
	   (dpy-tyflush))

     (flet (syserror (f m b)
	   ; trap les erreurs TYI (i.e. BREAK)
	   (if (neq f 'tyi)
	       (syserror* f m b)
	       (DCTL-epilogue)
	       (dpy-tyflush)
	       (print "*** Probleme avec le BREAK ***")
	       (print "je sauve tout dans KATASTRO.FF")
	       (terpri 4)
	       (writeout-file "KATASTRO.FF")
	       (dpy-tyflush)
;	        (exit emacs_abort)))
; car le toplevel lisp ne marche pas non plus!!!!!!
	       (end)))

       (errset (progn
	(rmargin 80)
	(DCTL-prologue)
	(DCTL-clear-screen)
	(setq curxpos 0 curypos 0 curcol 0)
	(redisplay-all t)
	(top-level mode))
         t)
       (DCTL-epilogue)
       (dpy-tyflush)
       (rmargin 78)))
  )))

    'emacs))))))






;==========================================================================
;
;	Emacs Le_Lisp 68K :  les commandes de base
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;*****************************************************************
;*
;*	  Les fonctions de manipulation de l'ecran et du curseur
;*
;*****************************************************************



(de scroll-up (n y)
    ; remonte le texte sur l'ecran de 'n' lignes a partir de la ligne 'y'
    ; i.e. detruit 'n' lignes en 'y'  et rajoute 'n' lignes du texte
    ;	 en bas de la fenetre. Actualise 'curypos'.
    ; Attention : ne doit pas sortir de la fenetre : pas de test!
    (DCTL-position-cursor 0 y)
    (repeat n (DCTL-delete-line))
    (DCTL-position-cursor 0 (- wind-size n))
    (repeat n (DCTL-insert-line))
    (redisp-lines-y
        (nthcdr (- wind-size curypos) end-buffer)
	n (- wind-size n))
    (setq curypos (- curypos n)))

(de scroll-down (n)
    ; descend le texte et le curseur de n lignes
    ; attention : ne doit pas sortir de la fenetre
    (let ((n (min n (length begin-buffer))) (buf begin-buffer))
         (DCTL-position-cursor 0 (- wind-size n)) ; aller en bas
         (repeat n (DCTL-delete-line))	    ; monter de n lignes
         (DCTL-position-cursor 0 0)	      ; en haut, a gauche
         (repeat n (DCTL-insert-line)	    ; fait la place
	       (redisp-1line-y (nextl buf) 0))	  ; et affiche le reste
         (setq curypos (+ curypos n)))))

(de scroll-current-window (count)
    ; ** ^Z^V **  count est toujours positif actuellement
    (close-line)
    (setq count (or count 1))
    (when (> count curypos)
	(open-line curcol)
	(next-line-command (- count curypos)))
    (close-line)
    (scroll-up count 0)))

(de move-to-screen-edge (count)
    ; ** esc-R **  actuellement sans argument
    (close-line)
    (passl end-buffer begin-buffer curypos)
    (setq curypos 0))

(de next-screen (count)
    ; ** ^V **  passe sur l'ecran suivant (ou le nieme suivant)
    (repeat (or count 1)
	(move-to-screen-edge 1)
	(if (< (length end-buffer) wind-size)
	    (command-quit))
	(passl begin-buffer end-buffer wind-size-1))
    (redisplay-full-window)))

(de previous-screen (count)
    ; ** esc-V **  passe sur l'ecran precedent (ou le nieme precedent)
    (move-to-screen-edge 1)
    (passl end-buffer begin-buffer
       (min (1- (* wind-size (or count 1))) (length begin-buffer)))
   (redisplay-full-window)))


;***********************************************
;*
;*	  Les commandes de positionnement
;*
;***********************************************


(de backward-char (count)
    ; ** ^B **  recule d'un (ou plusieurs) caracteres
    (repeat (or count 1)
       (cond
	((at-beginning-of-buffer) (command-quit))
	((bolp)
	    (prev-line-command 1)
	    (go-to-end-of-line))
	(t ; je ne suis pas en debut de ligne
	   (passl end-line begin-line 1)
	   (decr curxpos)
	   (setq curcol curxpos))))))

(de forward-char (count)
    ; ** ^F **  avance d'un (ou plusieurs) caractere
    (repeat (or count 1)
       (cond
	((at-end-of-buffer) (command-quit))
	((eolp) (setq curcol (setq curxpos 0)) (next-line-command 1))
	(t (setq curcol (incr curxpos))
	   (passl begin-line end-line 1)))))

(de go-to-beginning-of-line (count)
    ; ** ^A **  passe en debut de ligne
    (passl end-line begin-line (length begin-line))
    (setq curxpos 0 curcol curxpos))

(de go-to-end-of-line (count)
    ; ** ^E **  passe en fin de ligne
    (passl begin-line end-line (length end-line))
    (setq curxpos (length begin-line) curcol curxpos))

(de next-line-command (count)
    ; ** ^N **  descend d'une (ou plusieurs) ligne
    (close-line)
    (repeat (or count 1)
         (when (at-last-visible-line)
	     (scroll-up half-wind 0))
         (ifn  (lastlinep)
	     (passl begin-buffer end-buffer 1)
	     (command-quit))
;	     (newl begin-buffer (make-line () () ))
;	     (modified-buffer))
         (incr curypos))
    (open-line curcol)
    (setq curxpos (length begin-line)))))

(de prev-line-command (count)
    ; ** ^P **  monte d'une (ou plusieurs) ligne
    (close-line)
    (repeat (or count 1)
       (if (firstlinep)
	 (command-quit)
	 (when (at-first-visible-line)
	       (scroll-down half-wind-2))
	 (passl end-buffer begin-buffer 1)
	 (decr curypos)))
    (open-line curcol)		 ; que l'on ouvre
    (setq curxpos (length begin-line))))

(de go-to-beginning-of-buffer (count)
    ; ** esc-< **  passe en debut de buffer
    (close-line)
    (passl end-buffer begin-buffer (length begin-buffer))
    (redisp-lines-y end-buffer wind-size 0)
    (setq curypos 0 curxpos 0 curcol 0))

(de go-to-end-of-buffer (count)
    ; ** esc-> **  passe en fin de buffer
    (close-line)
    (passl begin-buffer end-buffer (length end-buffer))
    (passl end-buffer begin-buffer half-wind)
    (redisp-lines-y end-buffer wind-size 0)
    (setq curypos (length end-buffer))
    (passl begin-buffer end-buffer (length end-buffer))
    (go-to-end-of-line))))))

(de go-to-line-number (count)
    ; ** esc-G **  se positionne a la ligne 'count'
    (close-line)
    (passl end-buffer begin-buffer (length begin-buffer))
    (passl begin-buffer end-buffer
	 (min (or count 1) (length end-buffer)))
    (redisplay-full-window-in-middle))


;***********************************************************
;*
;*	  Les commandes d'insertion/modification
;*
;***********************************************************

(de insert-char (char count)
    ; insert le caractere 'char', 'count' fois
    (repeat (or count 1)
       (newl begin-line (DCTL-insert-char char))
       (incr curxpos)
       (setq curcol curxpos))
    (modified-buffer)))

(de tab-command (count)
    ; ** ^I **  insert une (ou plusieurs) tabulation
    (repeat (or count 1)
       (insert-char \#\SP (- tab-pos  (/\ curxpos tab-pos)))))

(de twiddle-chars (count)
    ;  **  ^T  **  inverse les 2 derniers caracteres
    (if (< (length begin-line) 2)
        (command-quit)
        (let ((c1 (nextl begin-line)) (c2 (nextl begin-line)))
	   (DCTL-position-cursor (- curxpos 2) curypos)
	   (dpy-tyo c1)
	   (newl begin-line c1)
	   (dpy-tyo c2)
	   (newl begin-line c2)
	   (modified-buffer))))

(de break-the-line ()
    ; casse la ligne courante a l'endroit du curseur
    ; i.e. insere un 'rc/lf' a la position courante
    ; le curseur ne bouge pas! Si eobp ne fait rien!
    (DCTL-erase-line)
    (unless (at-last-visible-line)
	  ; le scroll-down d'1 coup
	  (DCTL-position-cursor 0 wind-size-1)
	  (DCTL-delete-line)
	  (DCTL-position-cursor 0 (1+ curypos))
	  (DCTL-insert-line)
	  (DCTL-insert-char-string end-line)
	  (DCTL-position-cursor curxpos curypos))
    (unless (at-end-of-buffer)
	  (newl end-buffer (make-line () end-line))
	  (setq end-line ()))
    (modified-buffer)))))

(de open-space (count)
    ;  ** ^O **  fait un trou de 1 (ou plusieurs) lignes
    (repeat (or count 1) (break-the-line))))

(de split-line (count)
    ; ** esc-^O **	descend la fin de la ligne (au meme endroit)
    (setq end-line (nconc (makelist (length begin-line) \#\SP) end-line))
    (repeat (or count 1) (break-the-line)))))

(de new-line (count)
    ; ** ^M **  (return)  saute de ligne
    (break-the-line)
    (go-to-beginning-of-line)
    (next-line-command)))

(de quote-char (count)
    ; ** ^Q **  insert le caractere suivant
    (insert-char (tyi) (or count 1)))


;*************************************************
;*
;*	  Les fonctions de destruction
;*
;*************************************************


(de delete-char (count)
    ; ** ^D **   detruit 1 (ou plusieurs) caractere a droite
    (repeat (or count 1)
       (cond
         ((not (eolp))
	   (nextl end-line)
	   (DCTL-delete-char))
         ((at-end-of-buffer) (command-quit))
         (t (merge-lines)))
    (modified-buffer))))

(de rubout-char (count)
    ;  **  DEL  **	detruit 1 (ou plusieurs) caracteres a gauche
    (repeat (or count 1)
       (backward-char 1)
       (DCTL-position-cursor curxpos curypos)
       (delete-char 1)))))))

(de delete-line-indentation (count)
    ;  **  esc-^  **  enleve tous les blancs en tete de ligne puis merge
    ; si 1 arg, connecte la lige suivante a la courant sans indentation
    (if count (next-line-command 1))
    (go-to-beginning-of-line 1)
    (while (and (is-at \#\SP) (not (eolp))) (nextl end-line))
    (prev-line-command 1)
    (go-to-end-of-line)
    (DCTL-position-cursor curxpos curypos)
    (merge-lines)))

(de merge-lines ()
    ; merge la ligne courante et la ligne suivante
    (DCTL-erase-line)
    (setq end-line (unpackline (cdr (nextl end-buffer))))
    (dpy-tyol end-line)
    (unless (at-last-visible-line)
	  (close-line)
	  (scroll-up 1 (incr curypos))
	  (open-line curxpos)
	  (DCTL-position-cursor curxpos curypos))))))



;*****************************************************
;*
;*	  Autres fonctions attachees aux cles
;*
;*****************************************************


(de re-execute-command (count)
    ; **	^C  **  re-appelle la derniere commande
    (let ((re-execute-command-flag t))
         (apply last-command-name
	      (if last-command-arg [last-command-arg]))))))))

(de command-quit (count)
    ; ** ^G (bell) **  sort d'une commande
    (if redisplay-flag (toggle-redisplay))
    (display-beep)
    (exit ctrl-G)))

(de noop (count)
    ; ** ^J **  (line-feed) ne fait rien
    ()))

(de redisplay-command (count)
    ; ** ^L **  redisplay tout l'ecran
    (repeat (or count 1) (redisplay-all t)))))

(de linecounter (count)
    ; ** ^X= **  imprime la poition
    (display 6 screen-size-2
        (+ (length begin-buffer)(length end-buffer))
        \#" lines, current = " (length begin-buffer))))))

(de quit-the-editor (count)
    ; ** ^X^C **  sort de Emacs
    (close-line)
;   (set buffer [begin-buffer end-buffer])
    (if modified-buffer-flag
        (or (display-query-yesnop \#"Modified buffer, do yo want to quit? ")
	  (command-quit)))
    (setq end t)
    (input))))

(de toggle-redisplay (count)
    ; ** ^X^T **   toggle le flag du redisplay
    (ifn redisplay-flag
         (setq redisplay-flag T)
         (setq redisplay-flag ())
         (redisplay-all)))








;==========================================================================
;
;	Emacs Le_Lisp 68K :  les 'extended-commands' de base
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



(defext set-tab-pos (count)
        ; positionne la tabulation
        (setq tab-pos count)
        (DCTL-prologue)
        (redisplay-all))))


;****	La gestion des cles


(defext set-permanent-key (key fnt)
        (newl fund fnt)
        (newl fund key))))


(defext print-key (n)
        ; imprime sur la sortie courante le clair de la cle 'n'
        (cond ((not (numberp n)))
	    ((> n 255)
		(print-key (// n 256))
		(princn \#\SP)
		(print-key (logand n \#$FF)))
	    ((= n 127)   (prin "<del>"))
	    ((= n \#\ESC) (prin "<esc>"))
	    ((<= n 31) (prin "^") (prin (ascii (+ n 64))))
	    (t (prin (ascii n))))))

;*****	Les faiseurs de 'wall-chart'

(de wall-chart ()
    ; realise une 'wall-chart' sur fichier (ou en memoire)
    (let ((l1 fund)
	(l2 (nthcdr (* 2 (// (length fund) 4)) fund))
	(n (// (length fund) 4))
	(extended-command-list extended-command-list))
         (terpri)
         (repeat n
		  (print-key (nextl l1))
		  (outpos 11) (prin (nextl l1))
		  (outpos 40) (print-key (nextl l2))
		  (outpos 51) (print (nextl l2)))
         (terpri 2)
         (print "**** les commandes etendues ****")
         (terpri)
         (while extended-command-list
	      (outpos 10)
	      (prin (nextl extended-command-list))
	      (when extended-command-list
		  (outpos 34)
		  (prin (nextl extended-command-list)))
	      (when extended-command-list
		  (outpos 58)
		  (prin (nextl extended-command-list)))
	      (terpri)))
       'wall-chart))))))

(defext print-wall-chart ()
        ; imprime un resume des commandes en display-local
        (local-display (wall-chart)))))

(defext make-wall-chart ()
        ; fabrique un fichier des commandes
        (output "WALLCHRT.TX")
        (wall-chart)
        (output ())
        (display-comment \#"WALLCHRT.TX created."))))))


;****	les manipulateurs de fonctions en memoire


(defext look-function ()
        (local-display
	  (eval ['pretty (implode (display-prompt \#"Function : "))])))))))

(defext edit-function ()
        ; edite une fonction particuliere
        (clear-buffer t)
        (insert-lines (stream-output
	  (eval ['pretty (implode (display-prompt \#"Function : "))]))))

(defext insert-function ()
        ; ajoute ) une fonction particuliere
        (insert-lines (stream-output
	  (eval ['pretty (implode (display-prompt \#"Function : "))]))))


;*****	les manipulations de EVAL lui-meme


(defext edit-print ()
        ; edite tout ce qui est imprime
        (clear-buffer t)
        (insert-lines (stream-output
	 (eval (implode (display-prompt \#"Expression : ")))))))

(defext edit-value ()
        ; edite la valeur d'une evaluation
        ; ex : esc-X edit-value (oblist)
        (clear-buffer t)
        (insert-lines (stream-output
	(print (eval (implode (display-prompt \#"Value : ")))))))))


(defext show-value ()
        ; visualise en local la valeur d'une evaluation
        (local-display
	 (print (car (errset (eval
		(implode
		    (nconc1 (cons \#/(
			     (display-prompt \#"Eval : (" ()))
			  \#/) )))
		     t))))))))


;*****	Pour jouer avec le chargeur et le compilateur


(defext assemble-buffer (count)
        ; appel de LOADER sur tout le buffer
        (go-to-beginning-of-buffer)
        (close-line)
        (let ((l) (buf end-buffer) (ln))
	   (while buf
	      (setq ln (unpackline (cdr (nextl buf))))
	      (setq ln
	         (ifn (eq (car ln) \#\SP)
		   ; c'est une etiquette
		   (car (implode (cons \#/(
				(nconc ln '(\#\CR \#\LF \#/) )))))
		   ; ce n'est pas une etiquette
		   (implode (cons \#/(
			     (nconc ln '(\#\CR \#\LF \#/) ))))))
	      (if ln (newl l ln)))
	   (local-display
	       (errset (loader (nreverse l)) t) t))))))))))


;*****	Les helps

(defext ls ()
        (local-display
	 (list-symbols
	    (display-prompt \#"Symbols :" ()))))))


;==========================================================================
;
;	Emacs Le_Lisp 68K :  manipulation des fichiers
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================




;******  Les points d'entree de Emacs

;	^X^F	find-file
;	^X^R	read-file
;	^X^S	save-file
;	^X^W	write-file
;	^XI	insert-file

;*****   Fonctions auxiliaires

(de file-name (l)
    ; fabrique un nom de fichier a partir de la liste des codes 'l'
    ; rajoute l'extension .LL par defaut
    (implode 
		 (append l (if (memq \#/. l) () \#".ll")))))))


(de file-version (l n)
    ; fabrique un nom de fichier de version 'n'
    (implode (reverse (cons (+ n \#/0) (cdr (reverse (explode l) ()))) ())))

(de readin-file (who)
    ; charge un fichier dans le buffer courant (appelee pas read/find file)
    (let ((fichier) (line) (char) (curcol))
        (setq fichier (file-name (display-prompt
				(append who \#" file : ")
				\#"MAIN.LL")))
        (setq buffer \#"TEMPOR.LL")
        (clear-buffer t)
        (ifn (errset (input fichier))
	   (display-error \#"Not found")
	   (prompt 6 screen-size-1 \#"Reading ...")
	   (teread)
	   (flet (gcalarm ()
		   ; par la suite cette valeur sera cablee
		   (setq gcalarm (cadr (gcinfo)))
		   (when (and (> gcalarm 0)
			    (< gcalarm 500))
		         (clear-buffer t)
		         (display-error \#"Plus assez de memoire!")))
	         (untilexit eof
		   (setq line (readline))
		   (if (eq line \#^Z)
		       (exit eof)
		       (newl begin-buffer (make-line () line))))
	         (input)))
    (setq buffer fichier)
    (setq end-buffer (nreverse begin-buffer) begin-buffer ())
    (setq open-line-flag () modified-buffer-flag ())
    (setq curxpos 0 curypos 0 curcol 0)
    (open-line)
    (redisplay-all t)
    t))

(de writeout-file (file)
    ; ecriture du buffer courant dans le fichier de nom 'file'
    (let ((ligne) (buf) (xx))
        (setq xx (length begin-buffer) modif ())
        (close-line)
        (passl end-buffer begin-buffer (length begin-buffer))
        (setq buf end-buffer)
        (prompt 6 screen-size-1 \#"Writing ...")
        (flush)
        (let ((file1 (file-version file 1)) (file2 (file-version file 2)))
	   (display-comment \#"delete " file2)
	   (errset (deletefile file2))   ; s'il n'existe pas
	   (display-comment \#"rename " file1 \#" to " file2)
	   (errset (renamefile file1 file2))  ; s'il n'existe pas
	   (display-comment \#"rename " file \#" to " file1)
	   (errset (renamefile file file1))  ; pour voir l'erreur
	   (display-comment \#"open " file)
	   (unless (errset (output file) t)
		 (output "EMERGENCY.SA")
		 (display-comment \#"***** EMERGENCY.SA *****")))
        (outpos 0)			   ; raz le buffer de sortie
        (while buf
	(prinlp (cdr (nextl buf)))
	(terpri))
        (output)
        (setq modified-buffer-flag ())
        (redisplay-wholines)
        (prompt 6 screen-size-1 \#"Written.")
        (passl begin-buffer end-buffer xx)
        (open-line curxpos))))))

;*****   The stuff

(de find-file (count)
    ; ** ^X^F **  cherche un fichier
    (readin-file \#"Find"))

(de read-file (count)
    ; ** ^X^R **  lire un fichier
    (readin-file \#"Read"))

(de save-file (count)
    ; ** ^X^S **  sauver un fichier
    (writeout-file buffer)))

(de write-file (count)
    ; ** ^X^W **  ecrire un fichier
    (writeout-file
         (file-name (display-prompt \#"Write file : " \#"OUTPUT.LL")))))

(de insert-file ()
    (let ((fichier (file-name (display-prompt \#"Insert file : " \#"INSERT.LL")))
	(char))
    (ifn (errset (input fichier)) (display-error \#"Not found."))
    (untilexit eof
	(selectq (setq char (readcn))
	   (\#^Z	(exit eof))
	   (\#\LF)
	   (\#\CR	(new-line) (DCTL-position-cursor curxpos curypos))
	   (t	(insert-char char))))
    (input)
    t))))))))



;==========================================================================
;
;	Emacs Le_Lisp 68K :  manipulation des buffers
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;*****	Les points d'entree de Emacs

;	esc-~   unmodify-buffer

;*****	Les fonctions

(de unmodify-buffer (cont)
    ;  ** esc-~ **	enleve la marque 'modified-buffer-flag'
    (setq modified-buffer-flag ())
    (redisplay-wholines)))



;==========================================================================
;
;	Emacs Le_Lisp 68K :  les fonctions de recherche
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;*****	Variables globales

;	last-string-search

;*****	Les points d'entree de Emacs

;	^S	string-search
;	^R	reverse-string-search
;	^XS	global-string-search
;	esc-%	query-replace
;	esc-X	replace

;*****	Les fonctions auxiliaires

(de search1 (str lin n)
    ; recherche str dans la ligne lin
    ; n est le nb de caracteres deja lus dans str et lin
    (setq n (searchline lin str))
    (if n (- (length lin) (length n)))))))


;*****	Les fonctions de Emacs

(de string-search (count)
    ;  **  ^S  **  cherche une chaine
    (let ((str (display-prompt
		\#"String Search : " default-string-search))
	(buf) (pos))
         (setq default-string-search str)
         (if (setq pos (search1 str end-line 0))
	   (forward-char (+ pos (length str)))
	   (tag strouve
	       (close-line)
	       (setq buf (cdr end-buffer))
	       (while buf
		 (if (setq pos (search1 str
			        (unpackline (cdr (nextl buf))) 0))
		     (let ((x (length buf)))
			(passl begin-buffer end-buffer
			     (- (length end-buffer) (1+ x)))
; ?!?!?!	bug le pointeur n'es pas bon	^S ... ^P ca va pas ?!?!?!?
			(redisplay-full-window-in-middle)
			(open-line (setq curxpos (+ pos (length str)))
)
			(exit strouve))))
	       (display-error "Not found.")))))))))


(de global-string-search (count)
    ;  **  esc-^S  **  cherche une chaine a partir du debut du buffer.
    (let ((str (display-prompt
		\#"Global Search String : " default-string-search)) (pos)
)
         (setq default-string-search str)
         (tag strouve
	  (let ((xcur (length begin-line)) (ycur (length begin-buffer)))
	       (close-line)
	       (passl end-buffer begin-buffer (length (begin-buffer)))
	       (setq buf (cdr end-buffer))
	       (while buf
		 (if (setq pos (search1 str
			        (unpackline (cdr (nextl buf))) 0))
		     (let ((x (length buf)))
			(passl begin-buffer end-buffer
			     (- (length end-buffer) (1+ x)))
			(redisplay-full-window-in-middle)
			(open-line (setq curxpos (+ pos (length str)))
)
			(exit strouve))))
	       (passl begin-buffer end-buffer ycur)
	       (open-line xcur)
	       (display-error "Not found.")))))))))


(de query-replace (count)
    ;  **  esc-%  **  remplace une chaine intractivement.
    (let ((oldstr (display-prompt \#"Old String : " () ))
	(newstr (display-prompt \#"New String : " () ))
	(pos))
         (if (setq pos (search1 str end-line 0))
	   (forward-char (+ pos (length str)))
	   (tag strouve
	       (close-line)
	       (setq buf (cdr end-buffer))
	       (while buf
		 (if (setq pos (search1 str
			        (unpackline (cdr (nextl buf))) 0))
		     (let ((x (length buf)))
			(passl begin-buffer end-buffer
			     (- (length end-buffer) (1+ x)))
			(redisplay-full-window-in-middle)
			(open-line (setq curxpos (+ pos (length str)))
)
			(exit strouve))))
	       (display-error "Not found.")))))))))





;==========================================================================
;
;	Emacs Le_Lisp 68K :  les tueurs et le 'kill-ring'
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;*****   Variables globales

;        kill-ring	         initialisee dans 'emacs'
;        kill-ring-size      sa longeur

;*****   Les points d'entree Emacs

;        @         kill-to-beginning-of-line
;        ^K        kill-lines
;        ^Y        yank
;        esc-Y     wipe-this-and-yank-previous
;        ^Z^Y      show-kills



(de kill-to-beginning-of-line (n)
    ; ** @ **  detruit jusqu'au debut de la ligne
    (if (bolp)
        ()
        (nextl kill-ring)
        (rplaca kill-ring (nreverse begin-line))
        (setq begin-line () curxpos 0 curcol 0)
        (close-line)
        (redisp-1line-y (car end-buffer) curypos)
        (open-line)))))

(de kill-lines (n)
    ; ** ^K  **  le tueur ...
    (nextl kill-ring)
    (rplaca kill-ring ())
    (ifn n  ; de type ^K
         (cond ((and (null end-line) (null begin-line)) ; la ligne est vide
	        (setq n 1))
	     (end-line			;  je ne suis pas en fin
		 (rplaca kill-ring end-line)
		 (setq end-line)
		 (DCTL-erase-line))
	     (end-buffer			   ; je suis en fin de ligne
		 (rplaca kill-ring ())
		 (setq end-line (unpackline (cdr (nextl end-buffer))))
		 (close-line)
		 (redisp-lines-y end-buffer (- wind-size curypos) curypos)
		 (open-line curcol))
	     (t	 (command-quit))))
    (ifn (numberp n) ()
         (close-line)
         (let ((q))
	    (passl q end-buffer n)
	    (rplaca kill-ring q))
         (redisp-lines-y end-buffer (- wind-size curypos) curypos)
         (open-line))
    (modified-buffer)))

(de yank (n)
    ; ** ^Y **
    (setq n (or n 1))
    (unless (between 1 n kill-ring-size)
	  (display-error \#"he! t'as vu ton yank ..."))
    (let ((q (copy (nth (- (1+ kill-ring-size) n) kill-ring))))
      (cond
         ((eq q 'nothing)
	   (display-error "Nothing in kill ring."))
         ((null q) ; le dernier kill etait un 'join'
	   (new-line))
         ((consp (car q)) ; le dernier kill etait un 'kill n'
	   (close-line)
	   (passl end-buffer q (length q))
	   (redisp-lines-y end-buffer (- wind-size curypos) curypos))
         (t  ; le dernier kill etait un 'kill to eol'
	   (setq end-line (nconc q end-line))
	   (dpy-tyol end-line)
	   (go-to-end-of-line)))
    (modified-buffer))))


(de show-kills ()
    ; ** ^Z^Y **  montre le kill-ring
    (let ((i 0) (kill-ring kill-ring))
         (local-display
	  (repeat kill-ring-size
	    (prin (incr i))
	    (outpos 5)
	    (princh "|")
	    (let ((q (nth (1+ (- kill-ring-size i)) kill-ring)))
	         (cond ((null q)
		      (prin "<return>"))
		     ((symbolp q)
		      (prin q))
		     ((consp (car q))
		      (prinlp (car q))
		      (prin "  <return> ..."))
		     (t (mapc 'princn q)))
	         (princh "|")
	         (terpri)))))))))))))))


;==========================================================================
;
;	Emacs Le_Lisp 68K :  le mode Le_Lisp
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;*****   Les points d'entree de Emacs

;	esc-^A	begin-defun
;	esc-^B	backward-sexp
;	esc-^E	end-defun
;	esc-^F	forward-sexp
;	esc-^R	move-defun-to-screen-top
;	esc-^Z	eval-top-level-form
;	esc-X	extended-command
;	esc-esc	eval-lisp-line

;*****	Les commandes etendues

;	esc-X	eval-buffer
;	esc-X	eval-loop


;*****	Les fonctions de Emacs

(de begin-defun (count)
    ;  **  esc-^A  **  begin-defun
    (repeat (or count 1)
        (go-to-beginning-of-line)
        (until (is-at \#/( ) (prev-line-command)))))

(de end-defun (count)
    ;  **  esc-^E  **  end-defun  **
    (repeat (or count 1)
        (begin-defun)
        (forward-sexp)))

(de forward-sexp (count)
    ; **	esc-^F  **  avance d'une S-expr
    (repeat (or count 1)
        (until (is-at \#/( ) (forward-char))
        (let ((dyck 0))
	   (untilexit endsexp
	       (selectq (car end-line)
		(\#/( (incr dyck))
		(\#/) (when (= (decr dyck) 0)
			 (forward-char)
			 (exit endsexp)))
		(\#/; (until (eolp) (forward-char)))
		(\#// (forward-char))
		(\#/" (forward-char)
		     (until (is-at \#/") (forward-char)))
		(t ()))
	       (forward-char))))))

(de move-defun-to-screen-top (count)
    ; **	esc-^R  **  positonne la fonction en haut de l'ecran
    (begin-defun count)
    (close-line)
    (if (neq curypos 0) (scroll-up curypos 0)))))

(de eval-top-level-form (count)
    ; ** esc-^Z **	evaluation d'une forme simple
    (begin-defun)
    (close-line)
    (let ((buf (unpackline (cdr (car end-buffer))))
	(q (cdr end-buffer))
	(l))	 ; la 1ere ligne
         (untilexit findef
	      (if (null q) (exit findef))
	      (setq l (unpackline (cdr (nextl q))))
	      (if (eq (car l) \#/( ) (exit findef))
	      (nconc buf (list \#\CR \#\LF))
	      (nconc buf l))
         (eval-list-internal (nconc buf (list \#\CR \#\LF)))))))


;*****	Les extended fonctions

(defext eval-lisp-line (count)
        ;  ** esc-esc **  appel de eval
        (eval-list-internal
	       (nconc1 (cons \#/(
			(display-prompt \#"Eval : (" () ))
		      \#/) ))))))

(de eval-list-internal (l)
    ; evalue et retourne la valeur de la liste de carateres l
    (setq l (local-display (car (errset (eval (implode l)) t))))
    (setq l (stream-output (print l)))
    (if (> (length l) 1)
	 (display 6 screen-size-1 \#"Value = " (car l) " ...")
	 (display 6 screen-size-1 \#"Value = " (car l))))))))))


(de extended-command (count)
    ;  ** esc-X  **  appel de apply
    (let ((l (display-prompt \#"Command : " ())))
         (setq l (implode (nconc1 (cons \#/( l) \#/) )))
         (errset (apply (car l) (cdr l)) t)))))


;*****	Les  esc-X  fonctions

(defext eval-buffer ()
    ;  ** esc-X eval-buffer  **  evalue le buffer (qvqf?)
    (go-to-beginning-of-buffer)
    (let ((l (copy \#"(progn ")) (buf end-buffer))
       (while buf
	(nconc l (unpackline (cdr (nextl buf))))
	(nconc l [\#\CR \#\LF]))
       (nconc l \#")")
       (eval-list-internal l)))))))


(defext eval-loop ()
    ;  ** esc-X eval-loop  **  passe dans le top-level lisp
    (DCTL-epilogue)
    (terpri 2)
    (print "(exit-eval-loop)	pour revenir a Emacs")
    (tag eval-loop
         (catch-all-but  eval-loop
	  (while t (print "= "
	     (car (errset (eval (car (errset (read) t))) t))))))
    (DCTL-prologue)
    (redisplay-all t))))))))


(de exit-eval-loop ()
    ; une maniere commode de sortir de la fonction precedente
    (exit eval-loop))))







;==========================================================================
;
;	Emacs Le_Lisp 68K :  gestion de LA macro
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;*****   Variables globales

;        macro-learn-flag	    initialise par 'emacs'
;        macro-body


;*****	Les points d'entree Emacs

;	^X(	begin-macro-collection
;	^X)	end-macro-collection
;	^X*	show-last-or-current-macro
;	^Xe	execute-last-editor-macro
;	^XQ	macro-query


(de macrolearn (key funct larg)
    ; enregistre une cle pour une macro
    (when macro-learn-flag
	(newl macro-body (mcons key funct larg)))))


(de begin-macro-collection (count)
    ; ** ^X( ** debute l'enregistrement d'une macro
    (if macro-learn-flag
        (display-error "Macro already in collection.")
        (setq macro-learn-flag t macro-body ())
        (redisplay-wholines)))))


(de end-macro-collection (count)
    ; ** ^X) **  termine l'enregistrement d'une macro
    (ifn macro-learn-flag
         (display-error "No macro in progress.")
         (setq macro-learn-flag ()
	     macro-body (nreverse (cdr macro-body)))
         (redisplay-wholines)))))


(de show-last-or-current-macro (count)
    ; ** ^X* **  visualise le texte d'une macro en display local
    (let ((l macro-body))
         (local-display
	  (while l
	         (cond
		  ((eq (cadar l) 'insert-char)
		   (when (car (cdddar l))
		         (prin "esc" (car (cdddar l)))))
		  ((caddar l)
		         (prin "esc" (caddar l))))
	         (print-key (car (nextl l))))
	  (terpri))))))))



(de execute-last-editor-macro (count)
    ; ** ^XE **  on l'execute
    (if macro-learn-flag (display-error "Macro learn in progress."))
    (if (null macro-body) (display-error "No macro to run."))
    (repeat (or count 1)
         (let ((l macro-body) (execute-macro-flag T))
	    (while l (eval (cons (cadar l) (cddar l)))
		   (DCTL-position-cursor curxpos curypos)
		   (nextl l))))))))))


(de macro-query (count)
    ; ** ^XQ  **  iterruption d'une macro
    (unless (or execute-macro-flag macro-learn-flag)
	  (display-error "Not in a macro."))
    (not-yet-implemented))))))




;==========================================================================
;
;	Emacs Le_Lisp 68K :  le  traitement des mots
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================



;*****	Les points d'entree de Emacs

;	esc-F   forward-word
;	esc-B   backward-word
;	esc-D   delete-word
;	esc-RUB rubout-word
;	esc-U   upper-case-word
;	esc-L   lower-case-word
;	esc-C   capitalize-initial-word


;*****	Les fonctions auxiliaires

(setq char-in-word
   \#"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_")))

(dm in-word-p (call)
    ; (in-word-p)  t/nil si on se trouve sur un mot
    (displace call '(memq (car end-line) char-in-word)))))))))))

(dm lower-case-char-at-cursor (call)
    ; force le caractere du curseur en bas de casse
    (displace call
       '(progn (rplaca end-line (lowercase (car end-line)))
	     (DCTL-delete-char)
	     (DCTL-insert-char (car end-line)))))))))

(dm upper-case-char-at-cursor (call)
    ; force le caractere du curseur en majuscules
    (displace call
       '(progn (rplaca end-line (uppercase (car end-line)))
	     (DCTL-delete-char)
	     (DCTL-insert-char (car end-line))))))))

(de go-to-beginning-of-word ()
    ; se positionne au debut du mot courant
    (tag word
         (ifn (in-word-p)
	    (until (in-word-p) (forward-char))
	    (while (in-word-p)
		 (when (at-beginning-of-buffer) (exit word))
		 (backward-char))
	    (forward-char)))
    (DCTL-position-cursor curxpos curypos))))))


;*****	Les fonctions de Emacs

(de forward-word (count)
    ; ** esc-F  **	:  avance d'un mot
    (repeat (or count 1)
      (until (in-word-p) (forward-char))
      (while (in-word-p) (forward-char))))

(de backward-word (count)
    ; ** esc-B **  :  recule d'un mot
    (backward-char)
    (repeat (or count 1)
       (until (in-word-p) (backward-char))
       (while (in-word-p) (backward-char)))
    (forward-char)))

(de delete-word (count)
    ; ** esc-D **  :  detruit un mot
    (repeat (or count 1)
      (until (in-word-p) (delete-char))
      (while (in-word-p) (delete-char)))))

(de rubout-word (count)
    ; ** esc-RUBOUT **  :  detruit un mot a gauche
    (backward-char)
    (DCTL-position-cursor curxpos curypos)
    (repeat (or count 1)
       (until (in-word-p)
	 (DCTL-position-cursor curxpos curypos)
	 (delete-char)
	 (backward-char))
       (while (in-word-p)
	 (DCTL-position-cursor curxpos curypos)
	 (delete-char)
	 (backward-char)))
    (forward-char))))

(de upper-case-word (count)
    ; ** esc-U  **	: force en majuscule tout un mot
    (repeat (or count 1)
        (go-to-beginning-of-word)
        (while (in-word-p) (upper-case-char-at-cursor) (forward-char)))
    (modified-buffer)))

(de lower-case-word (count)
    ; ** esc-L **  :  force en minuscule tout un mot
    (repeat (or count 1)
        (go-to-beginning-of-word)
        (while (in-word-p) (lower-case-char-at-cursor) (forward-char)))
    (modified-buffer)))

(de capitalize-initial-word (count)
    ; ** esc-C **  :  force le 1er en cap, les autres en minuscule
    (repeat (or count 1)
        (go-to-beginning-of-word)
        (upper-case-char-at-cursor)
        (forward-char)
        (while (in-word-p) (lower-case-char-at-cursor) (forward-char)))
    (modified-buffer)))


;*****	Les esc-X fonctions

(defext add-char-in-word (n)
    ; rajoute le caractere 'n' comme faisant parie d'un mot
    (newl char-in-word n)))

(defext rem-char-in-word (n)
    ; enleve le caractere 'n' comme faisant partie d'un mot
    (setq char-in-word (delq char-in-word n)))))

(defext french-mode ()
    ; passe en mode franzais
    (setq sub-mode " French")
    (redisplay-wholines t)
    (mapc 'add-char-in-word '(\#/' \#/` \#/^))))



;==========================================================================
;
;	Emacs Le_Lisp 68K :  CTL  de	l'HP 2621
;
;===========================================================================
;  (c) 1982 Institut National de Recherche en Informatique et Automatique
;===========================================================================


;-----	Pour pouvoir charger ce fichier en Autoload

(de hp2621 ()
    (emacs))

(de ehp ()
    (emacs))

;-----	Les fonctions du terminal

(de DCTL-prologue ()
    (dpy-tyol '(\#\ESC \#/H ; home
	      \#\ESC \#/J ; clear
	      \#\ESC \#/3 \#\CR)) ; clear all + return
    ; positionnement des TABs
    (repeat 7 (repeat tab-pos (dpy-tyo \#\SP)) (dpy-tyol '(\#\ESC \#/1))))

(de DCTL-epilogue ()
    (dpy-tyol '(\#\ESC \#/F)))		 ; Home down

(de DCTL-clear-screen ()
    (dpy-tyol '(\#\ESC \#/H \#\ESC \#/J)))

(setq DCTL-position-cursor-list '(\#\ESC \#/& \#/a 0 0 \#/y 0 0 \#/C))

(de DCTL-position-cursor (x y)
    (if (and (= x 0) (= y 0))
        (dpy-tyol '(\#\ESC \#/H))
        (let ((l (cdddr DCTL-position-cursor-list)))
	   (rplaca l (+ \#/0 (// y 10)))
	   (setq l (cdr l))
	   (rplaca l (+ \#/0 (/\ y 10)))
	   (setq l (cddr l))
	   (rplaca l (+ \#/0 (// x 10)))
	   (setq l (cdr l))
	   (rplaca l (+ \#/0 (/\ x 10)))
	   (dpy-tyol DCTL-position-cursor-list))))))

(de DCTL-insert-line ()
    (dpy-tyol '(\#\ESC \#/L)))

(de DCTL-delete-line ()
    (dpy-tyol '(\#\ESC \#/M)))

(de DCTL-insert-char (char)
    (dpy-tyol '(\#\ESC \#/Q))  ; insert mode on
    (dpy-tyo char)	         ; insert le caractere
    (dpy-tyol '(\#\ESC \#/R))  ; insert mode off
    char)))

(de DCTL-insert-char-string (l)
    (dpy-tyol '(\#\ESC \#/Q))  ; insert mode on
    (dpy-tyol l)	         ; insert la liste de codes
    (dpy-tyol '(\#\ESC \#/R))  ; insert mode off
    l)

(de DCTL-delete-char ()
    (dpy-tyol '(\#\ESC \#/P)))

(de DCTL-erase-line ()
    (dpy-tyol '(\#\ESC \#/K)))



(input ())

