#lang racket

(require rackunit
         "test_helper.rkt")

; Метод Ньютона для кубических корней основан на том, что если y является приближением к
; кубическому корню из x, то мы можем получить лучшее приближение по формуле
;
; x/y2 + 2y
; ---------
;     3
;   
; С помощью этой формулы напишите процедуру вычисления кубического корня, подобную 
; процедуре для квадратного корня.


(define (cube-root guess x)
  (let ((improved-guess (improve guess x)))
    (if (good-enough? guess improved-guess)
        guess
        (cube-root improved-guess x))))

(define (improve guess x)
  (average guess (next-guess guess x)))

(define (good-enough? guess improved-guess)
  (< (abs (- guess improved-guess)) (* guess 0.000001)))

(define (average x y) 
  (/ (+ x y) 2))

(define (next-guess guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))



; тесты

(check-close? (cube-root 1 2.0) (expt 2 (/ 1 3)))
(check-close? (cube-root 1 9.0) (expt 9 (/ 1 3)))