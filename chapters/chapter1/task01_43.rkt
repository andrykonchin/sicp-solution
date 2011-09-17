#lang racket

(require rackunit
         "test_helper.rkt")

; Напишите процедуру, которая принимает в качестве ввода процедуру, вычисляющую f, и положительное целое n, 
; и возвращает процедуру, вычисляющую n-кратное применение f

(define (repeated f n)
  (define (compose-n f n)
    (if (= n 1)
        f
        (compose f (compose-n f (- n 1)))))
  (define composed-function (compose-n f n))
  (lambda (x)
    (composed-function x)))

(define (compose f g)
  (lambda (x) (f (g x))))



; тесты

(define (inc x) (+ x 1))
(define (square x) (* x x))

(check-eq? ((repeated inc 10) 5) 15)
(check-eq? ((repeated square 2) 5) 625)