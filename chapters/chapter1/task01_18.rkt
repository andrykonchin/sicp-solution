#lang racket

(require rackunit
         "test_helper.rkt")

; Используя результаты упражнений 1.16 и 1.17, разработайте процедуру, которая порождает 
; итеративный процесс для умножения двух чисел с помощью сложения, удвоения и деления пополам, и
; затрачивает логарифмическое число шагов


(define (fast-* a b)
  (*-iter a b 0))

(define (*-iter a n product)
  (cond 
    ((= n 0) product)
    ((even? n) (*-iter (double a) (halve n) product))
    (else (*-iter a (- n 1) (+ product a))) ))

(define (double x) (* x 2))
(define (halve even-x) (/ even-x 2))


; тесты

(check-eq? (fast-* 2  0) 0)
(check-eq? (fast-* 2  4) 8)
(check-eq? (fast-* 3 3) 9)
(check-eq? (fast-* 13 6) (* 13 6))
