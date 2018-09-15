;=================================================================
;
;    Le_Lisp  80   :   PEPE   -   (P)epe (E)st (P)resque (E)macs
;
;=================================================================
;   (c) 1982    Jerome CHAILLOUX   et   I.N.R.I.A.
;               B.P. 105, 78153 Le Chesnay Cedex France
;=================================================================

#.(unless (= (version) 12)
          (syserror 'pepe 'version (version)))

 
; PEPE implemente une version reduite du celebre editeur Emacs
; dont il garde les caracteristiques suivantes :
;   - ecrit entierement en Lisp
;   - extensible
;   - independance vis-a-vis du materiel
;   - independance vis-a-vis de le representation des lignes
; en revanche il ne possede pas de reaffichage asynchrone.
 
;        *****   Que PEPE soit avec vous   *****
 
 
;-----   Organisation des fichiers de PEPE :
 
;        PEPE.LL         la racine du mal ...
;        PEPTOP.LL       la boucle principale
;        PEPLNx.LL       les differentes gestions des lignes tassees
;        PEPMSC.LL       un ensemble de fonctions auxiliaires
;        PEPCMD.LL       les fonctions des commandes simples
;        PEPESC.LL       les fonctions des commandes ESCapes
;        PEPINI.LL       les affectations initiales des cles
;        PEPATO.LL       les fonctions autoload de PEPE
 
;-----   Les variables globales de PEPE,
;        en plus de $xmax$ $ymax$ (dans VIRTTY) :
 
;        $buffer$      la liste des lignes
;        $file$        nom du fichier du buffer
;        $ydisplay$    no de la 1ere ligne de la fenetre visible
;        $xcursor$     la colonne courante du curseur
;        $ycursor$     la ligne courante du curseur
;        $modbuf$      indicateur, vrai si le tampon n'a pas ete sauve
;        $column$      la colonne virtuelle courante
;        $commands$    la A-Liste des cles normales
;        $escommands$  la A-Liste des commandes 'escape'x
 
 
;-----   La fonction AUTOLOAD qui charge le reste
 
(dm pepe l
    (load PEPTOP)
    (load PEPLN2)
    (load PEPMSC)
    (load PEPCMD)
    (load PEPESC)
    (load PEPINI)
    l))
 
 
;-----   Le recuperateur de l'espace de PEPE
 
(df pepend ()
    (mapc 'remfn
            '(
            pkldisplay pklprint pkllength pklbreak
            pkljoin pklchar pklcharn  pklinschar
            pkldelchar pklimplode pklexplode         ; dans PEPLN2
 
            deadend currentline cursor
            redisplayhome redisplay
            bolp eolp bobp eobp bosp eosp            ; dans PEPMSC
 
            left right endline begline up down
            nextscreen insertchar deletechar breakline
            joinlines killline                      ; dans PEPCMD
 
            pepefile                                ; dans PEPTOP
 
            escommand readname
            readfile writefile                      ; dans PEPESC
 
            defkey defesckey                        ; dans PEPINI
 
        ))
      (mapc 'makunbound
            '($buffer$ $file$ $commands$ $escommands$))
 
      (autoload pepe pepe pepend)
      'pepend)))
 
 

