;-----   La mecanique pour passer de rho/theta -> x y

 
(de sinus (theta)
    ; retourne (sinus theta) avec 0<=theta<360
    (cond
       ((<= theta 90)  (tabsin theta))
       ((<= (decr theta 90) 90) (tabsin (- 90 theta)))
       ((<= (decr theta 90) 90) (- (tabsin theta)))
       ((<= (decr theta 90) 90) (- (tabsin (- 90 theta))))))
 
(de cosinus (theta)
    ; retourne (cosinus theta) avec 0<=theta<360
    (if (<= theta 90) 
        (tabsin (- 90 theta)) 
        (- (sinus (- theta 90)))))
 
(de tabsin (theta)
    ; retourne (sinus theta) avec 0<=theta<90 par recherche
    ; dans la table -tsin, le bouvart et ratinet sur 12 bits!
    (setq theta (+ -tsin theta theta))
    (+ (* 256 (memoryb (1- theta))) (memoryb theta)))

 
;-----   Installation de la table des sinus a partir de $bcode$ + 6
 
(apply '(lambda l
           (setq -tsin (+ 7
                          (* 256 (car $bcode$))
                          (cadr $bcode$)))
           (let ((n (- -tsin 2)))
                (while l (memoryb (incr n)
                                  (// (car l)
                                      256))
                         (memoryb (incr n)
                                  (\ (nextl l)
                                     256)))))
 
       '(    0   71  143  214  286  357  428  499  570  641  711  782  852  921
 991 1060 1129 1198 1266 1334 1401 1468 1534 1600 1666 1731 1796 1860 1923 1986
2048 2110 2171 2231 2290 2349 2408 2465 2522 2578 2633 2687 2741 2793 2845 2896
2946 2996 3044 3091 3138 3183 3228 3271 3314 3355 3396 3435 3474 3511 3547 3582
3617 3650 3681 3712 3742 3770 3798 3824 3849 3873 3896 3917 3937 3956 3974 3991
4006 4021 4034 4046 4056 4065 4074 4080 4086 4090 4094 4095 4096 )
)
 
