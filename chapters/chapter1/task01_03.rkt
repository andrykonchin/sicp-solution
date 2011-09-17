#lang racket

(require rackunit
         "test_helper.rkt")

; Определите процедуру, которая принимает в качестве аргументов три числа и возвращает сумму
; квадратов двух больших из них.

(define (sum-of-max a b c) 
  (sum-square-n-max (list a b c) 2))

(define (sum-square-n-max lst n)
  (apply + (map square (n-max lst n))))

(define (n-max lst n)
  (take (sort lst >) n))

(define (square x) (* x x))


; тест


(check-eq? (sum-of-max 1 2 3) (+ 4 9))
(check-eq? (sum-of-max 3 8 4) (+ 64 16))

