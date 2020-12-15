#lang sicp
;;; 1.9
; This is recursive(chain of deferred ops)
;(define (+ a b)
; (if (= a 0) 
;    b 
;   (inc (+ (dec a) b))))

; This is iterative because 2 fixed states(dec a and inc b)
; have to be tracked
;(define (+ a b)
; (if (= a 0) 
;  b 
;  (+ (dec a) (inc b))))

;(+ 4 5)
;Recursive:
;(inc (+ (dec 4) 5))
;(inc (+ 3 5))
;(inc (inc (+ (dec 3) 5)))
;(inc (inc (+ 2 5)))
;(inc (inc (inc (+ (dec 2) 5))))
;(inc (inc (inc (+ 1 5))))
;(inc (inc (inc (inc (+ (dec 1) 5)))))
;(inc (inc (inc (inc (+ 0 5)))))
;(inc (inc (inc (inc 5))))
;(inc (inc (inc 6)
;(inc (inc 7))
;(inc 8)
;9

;Iterative:
;(+ 4 5)
;(+ (dec 4) (inc 5))
;(+ 3 6)
;(+ (dec 3) (inc 6))
;(+ 2 7)
;(+ (dec 2) (inc 7))
;(+ 1 8)
;(+ (dec 1) (inc 8))
;(+ 0 9)
;9

;;; 1.10
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
;(A (- 1 1) (A 1 (- 10 1)))
;(A 0 (A 1 9))
;(A 0 (A (- 1 1) (A 1 (- 9 1))))
;(A 0 (A 0 (A 1 8)))
;(A 0 (A 0 (A (-1 1) (A 1 (- 8 1)))))
;(A 0 (A 0 (A 0 (A 1 7))))
;...
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;...
;(A 0 512)
;1024

(A 2 4)
;(A (- 2 1) (A 2 (- 4 1)))
;(A 1 (A 2 3))
;(A 1 (A (- 2 1) (A 2 (- 3 1))))
;(A 1 (A 1 (A 2 2)))
;(A 1 (A 1 (A 1 (A 2 1))))
;(A 1 (A 1 (A 1 2)))
;(A 1 (A 1 (A (- 1 1) (A 1 (-2 1)))))
;(A 1 (A 1 (A 0 (A 1 1))))
;(A 1 (A 1 (A 0 2)))
;(A 1 (A 1 4))
;.. (A 1 y) -> (A 0 2^y) -> 2^(2^y)
;(A 1 16)
;(A 0 32768)
;65536

(A 3 3)
;(A (- 3 1) (A 3 (- 3 1)))
;(A 2 (A 3 2))
;(A 2 (A 2 (A 3 1)))
;(A 2 (A 2 2))
;(A 2 (A (-2 1) (A 2 (- 2 1))))
;(A 2 (A 1 (A 2 1)))
;(A 2 (A 1 2))
;(A 2 (A (- 1 1) (A 1 (- 2 1))))
;(A 2 (A 0 (A 1 1)))
;(A 2 (A 0 2))
;(A 2 4)
;...same as previous one (A 2 4)

; (A 0 n) -> 2 * n
(define (f n) (A 0 n))

; (A 1 n) -> 2^n for n>0
(define (g n) (A 1 n))

; (A 2 n) -> 2^2^2..(n-1) times for n>1
(define (h n) (A 2 n))