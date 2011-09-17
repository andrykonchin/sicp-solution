#lang racket

(require rackunit
         "test_helper.rkt")

; Определите процедуру compose которая реализует композицию

(define (compose f g)
  (lambda (x) (f (g x))))

; тесты

(define (inc x) (+ x 1))
(define (square x) (* x x))


(check-eq? ((compose square inc) 6) 49)

