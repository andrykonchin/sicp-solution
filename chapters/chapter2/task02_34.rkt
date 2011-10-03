#lang racket

(require rackunit
         "lib/accumulate.rkt")

; Заполните пропуски в следующей заготовке так, чтобы получить процедуру, 
; которая вычисляет многочлены по схеме Горнера. 
; Предполагается, что коэффициенты многочлена представлены в виде последовательности, 
; от a0 до an
;
; (define (horner-eval x coefficient-sequence)
;   (accumulate (lambda (this-coeff higher-terms) <??>)
;               0
;               coefficient-sequence))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ (* higher-terms x) this-coeff))
              0
              coefficient-sequence))

; тест

; 1 + 3x + 5x^3 + x^5 в точке x = 2
(define (f x) (+ 1 (* 3 x) (* 5 x x x) (* x x x x x)))

(check-eq? (horner-eval 2 (list 1 3 0 5 0 1))
           (f 2))