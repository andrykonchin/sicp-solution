#lang racket

(require rackunit
         "test_helper.rkt")

; Определите процедуру double, которая принимает как аргумент процедуру с одним аргументом и
; возвращает процедуру, которая применяет исходную процедуру дважды.

(define (double f)
  (lambda (x) (f (f x))))

; тесты

(define (inc x) (+ x 1))

(check-eq? ((double inc) 4) 6)
(check-eq? (((double (double double)) inc) 5) 21)