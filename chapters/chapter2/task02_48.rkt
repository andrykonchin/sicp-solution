#lang racket

(require rackunit,
         "lib/vector.rkt")

(define (make-segment start end) (cons start end))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))