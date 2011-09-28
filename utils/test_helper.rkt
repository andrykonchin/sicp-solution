#lang racket

(require rackunit)

(define-simple-check (check-close? a b)
  (check-= a b 0.000001 "Difference more than 0.00001"))

(define-simple-check (check-close-with-eps? a b eps)
  (< (abs (- a b)) eps))

(define (time-test f args)
  (define start-time (current-inexact-milliseconds))
  (apply f args)
  (define finish-time (current-inexact-milliseconds))
  (- finish-time start-time))

(provide check-close? 
         time-test)