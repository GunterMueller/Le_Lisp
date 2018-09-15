;=============================================================================
;
;    Le_Lisp  80   :   VIRV24  -  gestion de la voie V24 virtuelle
;
;=============================================================================
;   (c) 1983    C.N.D.P.   29, rue d'Ulm    75005  PARIS   France
;=============================================================================

#.(unless (= (version) 12)
          (syserror 'virv24 'version (version)))


;  Ce fichier contient les fonctions de controle de la voie V24.
;  Pour chaque nouveau systeme, il faut definir ses nouvelles
;  caracteristiques en mettant a jour ce fichier. Il faut definir :
;
; (inV24)                renvoie le caractere lu sur la V24
; (outV24 n)             envoie le caractere de code ASCII n sur la V24
; (initV24 'Vxxxx B S P) initialise la V24 a la vitesse xxxx, sur B bits, avec
;             S bits de stop et une parite P (0: paire, 1: impaire, NIL: sans).
;=============================================================================


#.(selectq (system)
 
(MICRAL '(progn
            (de inV24 ()   (while (= 0 (logand 4 (memoryb '(#$FF #$FC)))))
                           (memoryb '(#$FF #$FB)))
 
            (de outV24 (n) (while (= 0 (logand 8 (memoryb '(#$FF #$FC)))))
                           (memoryb '(#$FF #$FB) n))
 
            (de initV24 (v b s p)            ; il faut le faire par hard !!
                  (terpri 2)
                  (tyo '#"Regler la voie V24 a " (cdr (explode v))' #" bauds, "
                       (explode b) '#" bits, " (explode s) '#" stop-bit(s), "
                        '#"parite " (if (= 1 p) '#"im") '#"paire.")
                      (terpri 2)
                      t)      ))
 
(SILZ  '(progn
           (de inV24 ()   (while (= 0 (logand 1 (in 7))))
                          (in 5))
 
           (de outV24 (n) (while (= 0 (logand 4 (in 7))))
                          (out 5 n))
 
           (de initV24 (v b s p)
                  (out 7 #$18)           ; raz du PIO
                  (out 7 4)              ; selection registre 4
                  (out 7 (+ #$44                    ; x16 clock, bit 2 a 1
                            (if  (= s 2)            ; 1 stop bit par defaut
                                 8                  ; bit 3 (2 stop bits)
                                 0)
                            (ifn p
                                 0                  ; aucune parite
                                 (1+ (ifn (= p 1)   ; bit 0 (enable)
                                          2         ; bit 1 (paire)
                                          0))))
                  (out 7 1)              ; registre 1
                  (out 7 0)                         ; pas d'interruption
                  (out 7 3)              ; registre 3
                  (out 7 (+ #$41                    ; bit 1 (RX enable), bit 6
                            (if (= b 7)             ; par defaut, RX sur 8 bits
                                0
                                #$80)))             ; bit 7 (Rx sur 8 bits)
                  (out 7 5)              ; registre 5
                  (out 7 (+ #$AA                    ; bits 7 (DTR), 5
                                                    ; 3 (Tx enable), 1 (RTS)
                            (if (= b 7)             ; par defaut, Tx sur 8 bits
                                0
                                #$40)))             ; bit 6 (Tx sur 8 bits)
                  (out #$0C              ; programmation vitesse
                       (car (cassq
                              (implode (cons #/v (cdr (explode v))))
                             '((v150   4) (v300   5) (v600   6) (v1200   7)
                               (v2400 10) (v4800 12) (v9600 14))))))
         ))
 
(LX529E '(progn
            (de inV24 ()   (while (= 0 (logand 1 (in 13))))
                           (in 8))
 
            (de outV24 (n) (while (= 0 (logand 32 (in 13))))
                           (out 8 n))
 
 
 
)        ; fin du SELECTQ
 
;-----   Une fonction commune a tous les systemes
 
(de outlV24 l                ; sort tous les codes de la liste l sur la V24
    (while l (outV24 (nextl l))))
 
