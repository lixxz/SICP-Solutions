#lang sicp
;;; 1.1
10 ;10
(+ 5 3 4) ;12
(/ 6 2) ; 3
(+ (* 2 4) (- 4 6)) ;6
(define a 3)
(define b ( + a 1))
(+ a b (* a b)) ;19
(= a b) ;#f
(if (and (> b a) (< b (* a b)))
    b
    a)  ;4
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a)) ;16
      (else 25))
(+ 2 (if (> b a) b a)) ;6
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)) ;16

;;; 1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

;;; 1.3
(define (smaller_number x y) (if (< x y) x y))
(define (smallest x y z) (smaller_number (smaller_number x y) z))
(define (square x) (* x x))
(define (sum_of_square x y) (+ (square x) (square y)))
(define (square_sum_of_larger x y z)
  (cond ((= (smallest x y z) x) (sum_of_square y z))
        ((= (smallest x y z) y) (sum_of_square x z))
        ((= (smallest x y z) z) (sum_of_square x y))))
(square_sum_of_larger 0 1 11)

;;; 1.4
(define (a-plus-abs a b)
  ((if (> b 0) + -) a b))
;; a+|b| i.e a can be positive or negative and b will always
;; be added to a, regardless of b being positive or negative.
(a-plus-abs -1 -3)

;;; 1.5
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

;; Applicative Order -> Evaluate the arguments and then apply
;; (test 0 (p)) -> (if (= 0 0) 0 (p)) -> (if (= 0 0) 0 (p))....
;; p's evaluation keeps repeating
;(test 0 (p))
;; Normal order -> Fully expand to primitives and then reduce
;; (test 0 (p))-> (if (= x 0) 0 y)) -> (if (= 0 0) 0 (p)) -> 0
;; p's evaluation never comes in this as 0 is returned before that.

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;;; 1.6
(define (new-if predicate
                then-clause
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter_ guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
(sqrt-iter 1.0 5)
(sqrt-iter_ 1.0 5)

(define (if-ex a) (if (= a 0) 1 (/ 1 0)))
(define (new-if-ex a) (new-if (= a 0) 1 (/ 1 0)))
;; (if-ex 0)
;; (new-if-ex 0)
;; In special form if, else expression is evaluated only if the
;; predicate is false. While in procedural new-if, all the arguments
;; will be evaluated i.e applicative order. So, (/ 1 0) is evaluated
;; regardless of the predicate value.

;;; 1.7

;; Original test fails for
;; Large number like 9999999999999999
(sqrt 9999999999999999)  ; Wrong answer because precision of more than 0.001 is required
; (sqrt 10000000000000) ; Does not finish computing(for odd number of zeroes with >= 13 zeroes)

;;;;
;; Small number like 0.0004 outputs 0.0354 rather than 0.02.
;; Because squaring 0.0354 and subtracting it from 0.0004 results
;; in a number smaller than 0.0001. Squaring the number is the main
;; reason why this behavior is happening.
(sqrt 0.0004)


(define (alt-good-enough? old-guess new-guess)
  (< (abs (- old-guess new-guess)) 0.001))

(define (sqrt-iter__ old-guess new-guess x)
  (if (alt-good-enough? old-guess new-guess)
      new-guess
      (sqrt-iter__ new-guess (improve new-guess x) x)))

(define (sqrt_ x)
  (sqrt-iter__ 1000.0 1.0 x))

(sqrt_ 0.0004) ; Works now
(sqrt 9999999999999999) ; Still fails for the same reason as above

;;; 1.8
(define (cube x)
  (* x x x))

(define (c-good-enough? approx x)
  (= (cube approx) x))

(define (cube-root x)
  (cubert-iter 1.0 x))

(define (cubert-iter y x)
  (if (c-good-enough? y x) y (cubert-iter (cube-improve y x) x)))

(define (cube-improve y x)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

(cube-root 92)