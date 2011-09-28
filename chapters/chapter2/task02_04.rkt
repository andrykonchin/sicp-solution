#lang racket

(require rackunit
         "../../utils/test_helper.rkt")


; Проверьте для этого представления, что при любых двух объектах x и y (car (cons x y)) возвращает x.


(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

; тесты

(check-eq? (car (cons 1 2)) 1)

(check-eq? (cdr (cons 1 2)) 2)