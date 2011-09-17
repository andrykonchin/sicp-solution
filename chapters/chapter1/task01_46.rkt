#lang racket

(require "test_helper.rkt")

; iterative-improve должна возвращать процедуру,
; которая принимает начальное значение в качестве аргумента и улучшает его, пока оно не станет
; достаточно хорошим

(define (iterative-improve good-enough? improve)
  (define (result-func x)
    (let ((improved-x (improve x)))
      (if (good-enough? x improved-x)
         improved-x
         (result-func improved-x))))
  result-func)


; процедура sqrt из раздела 1.1.7 в терминах iterative-improve

(define (sqrt-iter x)
  (define (improve guess)
    (define (average x y) 
      (/ (+ x y) 2))
    (define (next-guess guess x)
      (/ x guess))
    (average guess (next-guess guess x)))
  (define (good-enough? guess improved-guess)
    (< (abs (- guess improved-guess)) 0.000001))
  ((iterative-improve good-enough? improve) x))

; процедура процедура fixed-point из раздела 1.3.3 в терминах iterative-improve

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (next-guess guess)
    (f guess))
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  ((iterative-improve close-enough? next-guess) first-guess))

; тесты

(check-close? (sqrt-iter  3) 1.73205)
(check-close? (sqrt-iter  9)       3)

(check-close? (fixed-point cos 1.0) 0.73908)
(check-close? (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)  1.2587315962971173)