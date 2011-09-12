#lang racket

(require rackunit
         "test_helper.rkt")

; Определите процедуру cubic, которую можно было бы использовать совместно с процедурой
; newtons-method в выражениях вида
; (newtons-method (cubic a b c) 1)
; для приближенного вычисления нулей кубических уравнений x3 + ax2 + bx + c


(define (cubic a b c)
  (lambda (x) 
    (+ (* x x x) (* a x x) (* b x) c)))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (deriv g)
  (define dx 0.000001)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))


; тесты

; x^3 + x^2 + 2x + 3 = 0
(let ((root (newton-method (cubic 1 2 3) 1))) ; => -1.2756822036508881
  (check-close? ((cubic 1 2 3) root) 0))

; x^3 + 2x^2 + x + 0 = 0
(let ((root (newton-method (cubic  2 1 0) 1))) ; => ~ 0
  (check-close? ((cubic 2 1 0) root) 0))

(let ((root (newton-method (cubic 2 1 0) -1))) ; => ~ -1
  (check-close? ((cubic 2 1 0) root) 0))