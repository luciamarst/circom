(set-logic QF_FF)
(define-sort FF0 () (_ FiniteField 21888242871839275222246405745257275088548364400416034343698204186575808495617))

(declare-fun a () FF0) 
(declare-fun b () FF0) 


(declare-fun out_circom () FF0)
(declare-fun diff () FF0)
(declare-fun inv_circom () FF0)

(declare-fun out_mio () FF0)
(declare-fun inv_mio() FF0)

; restriccion circomlib: EN circomlib lo que se hace es a - b = 0, traducido a esto (sacado de su smt2) es 0 = in_1 -in_2 - diff_lib 
(assert (= (as ff0 FF0) (ff.add a (ff.mul b (as ff21888242871839275222246405745257275088548364400416034343698204186575808495616 FF0)) (ff.mul diff (as ff21888242871839275222246405745257275088548364400416034343698204186575808495616 FF0)))))

(assert (= (as ff0 FF0) (ff.add (ff.mul diff inv_circom) (ff.add (as ff1 FF0) (ff.mul out_circom (as ff21888242871839275222246405745257275088548364400416034343698204186575808495616 FF0))))))
(assert (= (as ff0 FF0) (ff.mul diff out_circom)))

; Nuestro operador eq
; Lo hacemos mas directo porque lo que hacemos es que a * b = 0
; Luefo -diff_lib * inv_mia + (-out_mia) = 0
(assert (= (as ff0 FF0) (ff.mul diff out_mio ))) 
(assert (= (as ff0 FF0) (ff.add (ff.mul (ff.mul diff (as ff21888242871839275222246405745257275088548364400416034343698204186575808495616 FF0)) inv_mio) (ff.add (as ff21888242871839275222246405745257275088548364400416034343698204186575808495616 FF0) out_mio))))

; APlicamos el mismo truquillo de no encontrar ninguna salida para cada sistema de ecuaciones que sea diferente.
(assert (not (= out_circom out_mio)))

(check-sat)
